require("s_maze_state_base")
_class("SMazeState_RoundEnd", SMazeStateBase)
SMazeState_RoundEnd = SMazeState_RoundEnd

function SMazeState_RoundEnd:OnEnter(node)
  self._node = node
  self:StartTask(self._Check, self)
end

function SMazeState_RoundEnd:_Check(TT)
  self:Lock("SMazeState_RoundEnd:1")
  local cpt = self._manager:GetMazeComponent()
  local asyncRes = AsyncRequestRes:New()
  cpt:HandleSeasonMazeRoundEnd(TT, asyncRes)
  self:UnLock("SMazeState_RoundEnd:1")
  if not asyncRes:GetSucc() then
    self:_LogError("回合结束消息失败:", asyncRes:GetResult())
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(asyncRes) then
      return
    end
    return
  end
  YIELD(TT, 200)
  if not self._valid then
    self:_Log("SMazeState_RoundEnd:打断1")
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUISeasonMazeAttChanged, SeasonMazeAttrType.SMAT_Round)
  local cpt = self._manager:GetMazeComponent()
  local extraGold = cpt:GetAttrValue(SeasonMazeAttrType.SMAT_Gold_Round_Add)
  local goldCfg = Cfg.cfg_season_maze_attribute[SeasonMazeAttrType.SMAT_Gold]
  local goldAsset = SeasonMazeAsset:New(SeasonMazeEffectType.SMET_Pro, goldCfg.Name, extraGold, goldCfg.Icon, goldCfg.Desc, SeasonMazeAttrType.SMAT_Gold)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUISeasonMazeAttChanged, SeasonMazeAttrType.SMAT_Gold)
  self:_Log("收货金币:", extraGold)
  if 0 < extraGold then
    self._manager:PlayGetGold(TT, extraGold)
  end
  self:PlayAssetToast(TT, {goldAsset})
  if cpt:CurOperate() == SeasonMazeActionState.SMAS_BossBattle then
    local count = cpt:GetAttrValue(SeasonMazeAttrType.SMAT_Round)
    if count ~= 0 then
      Log.exception("当前回合数不是0", count)
    end
    self._machine:ChangeStateTo(SMazeState_BossAttack)
  elseif self._node:Room():Type() == SeasonMazeRoomType.SMRT_Camp then
    self:TransformPosEffect(function()
      self._manager:MapManager():ReMake()
      self._machine:ChangeStateTo(SMazeState_Born, true)
    end)
  else
    self._machine:ChangeStateTo(SMazeState_PlayCard, self._node, true)
  end
end

function SMazeState_RoundEnd:TransformPosEffect(cb)
  local tls = {}
  local lock = EZTL_Callback:New(function()
    GameGlobal.UIStateManager():Lock("SMazeState_PlayerMove:TransformPosEffect")
  end, "锁屏")
  table.insert(tls, lock)
  local para = EZTL_Parallel:New({
    EZTL_Sequence:New({
      EZTL_Wait:New(100, "等0.1秒"),
      EZTL_Callback:New(function()
        GameGlobal.GetUIModule(SeasonMazeModule):SeasonMazeManager():Player():GetModelGameObject():SetActive(false)
      end, "隐藏")
    }),
    EZTL_Callback:New(function()
      local pos = GameGlobal.GetUIModule(SeasonMazeModule):SeasonMazeManager():Player():Position()
      GameGlobal.GetUIModule(SeasonMazeModule):SeasonMazeManager():Player():PlayEffect("TransStartPoint", pos)
    end, "加载资源"),
    EZTL_Callback:New(function()
      GameGlobal.UIStateManager():CallUIMethod("UISeasonMazeScene", "TransStartPoint", 0.7)
    end, "黑屏"),
    EZTL_Wait:New(700, "等0.7秒")
  }, EZTL_EndTag.All, nil, "加载资源，黑屏")
  table.insert(tls, para)
  local callback = EZTL_Callback:New(function()
    if cb then
      cb()
    end
  end, "传送")
  table.insert(tls, callback)
  local para2 = EZTL_Parallel:New({
    EZTL_Callback:New(function()
      GameGlobal.GetUIModule(SeasonMazeModule):SeasonMazeManager():Player():GetModelGameObject():SetActive(true)
      local pos = GameGlobal.GetUIModule(SeasonMazeModule):SeasonMazeManager():Player():Position()
      GameGlobal.GetUIModule(SeasonMazeModule):SeasonMazeManager():Player():PlayEffect("TransEndPoint", pos)
    end, "显示特效"),
    EZTL_Callback:New(function()
      GameGlobal.UIStateManager():CallUIMethod("UISeasonMazeScene", "TransEndPoint", 0.7)
    end, "取消黑屏"),
    EZTL_Wait:New(700, "等0.7秒")
  }, EZTL_EndTag.All, nil, "加载资源，黑屏")
  table.insert(tls, para2)
  local unlock = EZTL_Callback:New(function()
    GameGlobal.UIStateManager():UnLock("SMazeState_PlayerMove:TransformPosEffect")
  end, "解锁")
  table.insert(tls, unlock)
  local seq = EZTL_Sequence:New(tls)
  GameGlobal.GetUIModule(SeasonMazeModule):SeasonMazeManager():PlayEZTL(seq)
  return seq
end
