require("s_maze_state_base")
_class("SMazeState_Levelup", SMazeStateBase)
SMazeState_Levelup = SMazeState_Levelup

function SMazeState_Levelup:OnEnter()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUISeasonMazeAttChanged, SeasonMazeAttrType.SMAT_Exp)
  local cpt = self._manager:GetMazeComponent()
  local lvupInfo = cpt:GetComponentInfo().new_hands
  local srcLv = 9999999
  local curLv = -9999999
  for key, value in pairs(lvupInfo.lv) do
    srcLv = math.min(srcLv, key, value)
    curLv = math.max(curLv, key, value)
  end
  self:_Log("开始升级表现:", srcLv, curLv)
  if srcLv < curLv then
    self:ShowDialog("UISeasonMazeUpLv", srcLv, curLv)
  else
    self:_Log("不需要升级弹窗直接选卡 不存在这种情况")
    self:_OnPickCard()
  end
end

function SMazeState_Levelup:OnDialogClose()
  if false then
    self:OnFinish()
  else
    self:_OnPickCard()
  end
end

function SMazeState_Levelup:_OnPickCard()
  local data = {}
  local cpt = self._manager:GetMazeComponent()
  local lvupInfo = cpt:GetComponentInfo().new_hands
  local srcLv = 9999999
  local curLv = -9999999
  for key, value in pairs(lvupInfo.lv) do
    srcLv = math.min(srcLv, key, value)
    curLv = math.max(curLv, key, value)
  end
  for i = srcLv + 1, curLv do
    table.insert(data, lvupInfo.ids[i])
  end
  if data and 0 < #data then
    local relicParam = cpt:GetAttrValue(SeasonMazeAttrType.SMAT_Lv_Up_Gold)
    if relicParam and relicParam ~= 0 then
      for i = srcLv + 1, curLv do
        local eft = SeasonMazeEffect:New()
        eft.type = SeasonMazeEffectType.SMET_Pro
        eft.id = SeasonMazeAttrType.SMAT_Gold
        eft.value_min = math.floor(i * relicParam)
        eft.value_max = eft.value_min
        self:AddRelicEft(eft)
      end
    end
    self:ShowDialog("UISeasonMazePickCard", srcLv, data)
  else
    self:_Log("升级数据为空 不选牌直接跳过")
    self:StartTask(self._ReqSkip, self)
  end
end

function SMazeState_Levelup:_ReqSkip(TT)
  local cpt = self._manager:GetMazeComponent()
  local res = AsyncRequestRes:New()
  self:Lock("SMazeState_Levelup._ReqSkip")
  cpt:HandleSeasonMazeNewHand(TT, res, {})
  self:UnLock("SMazeState_Levelup._ReqSkip")
  if res:GetSucc() then
    self:OnFinish()
  else
    self:_LogError("请求跳过选卡失败:", res:GetResult())
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function SMazeState_Levelup:OnFinish()
  self:PlayAssetToast(nil, {})
  local cpt = self._manager:GetMazeComponent()
  local state = cpt:CurOperate()
  self:_Log("升级表现完毕 切状态:", state)
  if state == SeasonMazeActionState.SMAS_Invalid then
    return
  elseif state == SeasonMazeActionState.SMAS_RandomHand then
    self:_Log("升级完随机卡牌")
    self._machine:ChangeStateTo(SMazeState_PlayCard, self._machine:GetCurNode(), true)
    return
  elseif state == SeasonMazeActionState.SMAS_ChooseHand then
    self:_Log("升级完继续出卡")
    self._machine:ChangeStateTo(SMazeState_PlayCard, self._machine:GetCurNode(), false)
    return
  elseif state == SeasonMazeActionState.SMAS_GoPoint then
    local total = cpt:GetAttrValue(SeasonMazeAttrType.SMAT_Round_Step_All)
    self:_Log("升级完成开始移动")
    self._machine:ChangeStateTo(SMazeState_PlayerMove, total)
    return
  elseif state == SeasonMazeActionState.SMAS_RoomOperate then
    local curNode = self._machine:GetCurNode()
    local nodeState = self:GetNodeState(curNode)
    self:_Log("升级完继续房间结算:", nodeState)
    if nodeState == SeasonMazePointStateType.SMPST_End then
      self:_Log("升级完成回合结束")
      self._machine:ChangeStateTo(SMazeState_RoundEnd, self._machine:GetCurNode())
      return
    elseif nodeState == SeasonMazePointStateType.SMPST_Occupy then
      self:_Log("升级完成触发房间效果")
      self._machine:ChangeStateTo(SMazeState_RoomSettle, self._machine:GetCurNode(), false)
      return
    else
      self:_Log("升级完成结算房间")
      self._machine:ChangeStateTo(SMazeState_RoomSettle, self._machine:GetCurNode(), true)
      return
    end
  elseif state == SeasonMazeActionState.SMAS_Relic then
    self:_Log("升级完选圣物")
    self._machine:ChangeStateTo(SMazeState_ChooseRelic)
    return
  elseif state == SeasonMazeActionState.SMAS_NewHand then
    return
  elseif state == SeasonMazeActionState.SMAS_BossBattle then
    self:_Log("升级完boss突袭 回合数:", cpt:GetAttrValue(SeasonMazeAttrType.SMAT_Round))
    self._machine:ChangeStateTo(SMazeState_BossAttack)
    return
  elseif state == SeasonMazeActionState.SMAS_RoundEnd then
    self._machine:ChangeStateTo(SMazeState_RoundEnd, self._machine:GetCurNode())
  end
end
