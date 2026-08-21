require("s_maze_state_base")
_class("SMazeState_RoomSettle", SMazeStateBase)
SMazeState_RoomSettle = SMazeState_RoomSettle

function SMazeState_RoomSettle:OnEnter(node, dontTigger)
  self._node = node
  local room = node:Room()
  self._settleRoom = room
  if dontTigger then
    self:SettleFinish(room)
  else
    self:_Log("开始房间UI的结算:", room:ID(), room:Type())
    room:Trigger()
    self._manager:Player():InteractOnRoom(room:Type())
  end
end

function SMazeState_RoomSettle:OnExit()
end

function SMazeState_RoomSettle:SettleFinish(room)
  if not self._settleRoom then
    self:_LogError("当前没有正在结算中的房间")
    return
  end
  if room:ID() ~= self._settleRoom:ID() then
    self:_LogError("结算房间id不一致:", room:ID(), self._settleRoom:ID())
    return
  end
  local targetId = room:Node():TransRoomTargetID()
  if room:Type() == SeasonMazeRoomType.SMRT_Transfor and targetId and 0 < targetId then
    self:_StartRoomTrans(room)
  else
    self:StartTask(self._OnSettleFinish, self, room)
  end
end

function SMazeState_RoomSettle:CurRoom()
  return self._settleRoom
end

function SMazeState_RoomSettle:_OnSettleFinish(TT, room)
  self._manager:Lock("RoomSettleWait")
  YIELD(TT, 100)
  self._manager:UnLock("RoomSettleWait")
  if not self._valid then
    return
  end
  local roomAssets = room:GetAndClearAwardAssets() or {}
  if #roomAssets == 0 then
    self:_Log("房间无奖励:", room:ID(), room:Type())
  end
  SeasonMazeTool:GetInstance():SortAsset(roomAssets)
  local goldCount = 0
  for index, value in ipairs(roomAssets) do
    if value:Type() == SeasonMazeEffectType.SMET_Pro and value:SubParam() == SeasonMazeAttrType.SMAT_Gold then
      goldCount = goldCount + value:Count()
    end
  end
  if 0 < goldCount then
    self._manager:PlayGetGold(TT, goldCount)
  end
  self:PlayAssetToast(TT, roomAssets)
  local cpt = self._manager:GetMazeComponent()
  if cpt:CurOperate() == SeasonMazeActionState.SMAS_NewHand then
    self._machine:ChangeStateTo(SMazeState_Levelup)
    return
  elseif cpt:CurOperate() == SeasonMazeActionState.SMAS_Relic then
    self:_Log("房间解锁完在roomend之前需要选择一次圣物")
    self._machine:ChangeStateTo(SMazeState_ChooseRelic)
    return
  end
  self:_ReqFinish(TT)
end

function SMazeState_RoomSettle:_ReqFinish(TT)
  local cpt = self._manager:GetMazeComponent()
  local settleRes = AsyncRequestRes:New()
  self:Lock("SMazeState_RoomSettle.HandleSeasonMazeRoomEnd")
  cpt:HandleSeasonMazeRoomEnd(TT, settleRes)
  self:UnLock("SMazeState_RoomSettle.HandleSeasonMazeRoomEnd")
  if not self._valid then
    return
  end
  self._node:SetState(SMazeNodeState.UnReachable)
  if not settleRes:GetSucc() then
    self:_LogError("结算房间消息失败:", settleRes:GetResult())
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(settleRes) then
      return
    end
    return
  end
  self:_Log("房间逻辑结算完毕切状态")
  if self._node:Room():Type() == SeasonMazeRoomType.SMRT_PVE then
    self._manager:Player():SetBattleRoomState(false)
    self._manager:Player():PlayAnimation(SeasonMazePlayerAnimation.Stand)
  end
  if cpt:CurOperate() == SeasonMazeActionState.SMAS_Relic then
    self._machine:ChangeStateTo(SMazeState_ChooseRelic)
    return
  elseif cpt:CurOperate() == SeasonMazeActionState.SMAS_BossBattle then
    self:_Log("房间结算完boss突袭 回合数:", cpt:GetAttrValue(SeasonMazeAttrType.SMAT_Round))
    self._machine:ChangeStateTo(SMazeState_BossAttack)
    return
  elseif cpt:CurOperate() == SeasonMazeActionState.SMAS_BreakPet then
    self:_Log("房间结算完选择满破星灵")
    self._machine:ChangeStateTo(SMazeState_ChooseFullPet)
    return
  elseif cpt:CurOperate() == SeasonMazeActionState.SMAS_NewHand then
    self:_Log("房间结算完升级了")
    self._machine:ChangeStateTo(SMazeState_Levelup)
    return
  else
    self._machine:ChangeStateTo(SMazeState_RoundEnd, self._node)
  end
end

function SMazeState_RoomSettle:_TransformPosEffect(cb)
  local tls = {}
  local lock = EZTL_Callback:New(function()
    GameGlobal.UIStateManager():Lock("SMazeState_RoomSettle:TransformPosEffect")
  end, "锁屏")
  table.insert(tls, lock)
  local para = EZTL_Parallel:New({
    EZTL_Sequence:New({
      EZTL_Wait:New(100, "等0.1秒"),
      EZTL_Callback:New(function()
        self._manager:Player():PlayerRoot():SetActive(false)
      end, "隐藏")
    }),
    EZTL_Callback:New(function()
      local pos = SMazeAdaptor.PlayerHeadPos()
      self._manager:Player():PlayEffect("TransStartPoint", pos)
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
      self._manager:Player():PlayerRoot():SetActive(true)
      local pos = SMazeAdaptor.PlayerHeadPos()
      self._manager:Player():PlayEffect("TransEndPoint", pos)
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
  self._manager:PlayEZTL(seq)
  return seq
end

function SMazeState_RoomSettle:_StartRoomTrans(room)
  self._machine:ChangeStateTo(SMazeState_PlayerMove, 1, true)
end
