require("s_maze_state_base")
_class("SMazeState_ChooseFullPet", SMazeStateBase)
SMazeState_ChooseFullPet = SMazeState_ChooseFullPet

function SMazeState_ChooseFullPet:OnEnter()
  local cpt = self._manager:GetMazeComponent()
  self:ShowDialog("UISeasonMazeChooseMaxPet")
end

function SMazeState_ChooseFullPet:OnChooseFinish(petID)
  self:OnFinish()
end

function SMazeState_ChooseFullPet:OnFinish()
  local cpt = self._manager:GetMazeComponent()
  local state = cpt:CurOperate()
  self:_Log("满突破星灵选择完毕 切状态:", state)
  if state == SeasonMazeActionState.SMAS_Invalid then
    return
  elseif state == SeasonMazeActionState.SMAS_RandomHand then
    self:_Log("选择完毕随机卡牌")
    self._machine:ChangeStateTo(SMazeState_PlayCard, self._machine:GetCurNode(), true)
    return
  elseif state == SeasonMazeActionState.SMAS_ChooseHand then
    self:_Log("选择完毕继续出卡")
    self._machine:ChangeStateTo(SMazeState_PlayCard, self._machine:GetCurNode(), false)
    return
  elseif state == SeasonMazeActionState.SMAS_GoPoint then
    self:_Log("选择完毕开始移动")
    local total = cpt:GetAttrValue(SeasonMazeAttrType.SMAT_Round_Step_All)
    self._machine:ChangeStateTo(SMazeState_PlayerMove, total)
    return
  elseif state == SeasonMazeActionState.SMAS_RoomOperate then
    self:_Log("选择完毕继续房间结算")
    local curNode = self._machine:GetCurNode()
    local nodeState = self:GetNodeState(curNode)
    if nodeState == SeasonMazePointStateType.SMPST_End then
      self:_Log("选择完毕回合结束")
      self._machine:ChangeStateTo(SMazeState_RoundEnd, curNode)
      return
    elseif nodeState == SeasonMazePointStateType.SMPST_Occupy then
      self:_Log("选完满破星灵触发房间效果")
      self._machine:ChangeStateTo(SMazeState_RoomSettle, curNode, false)
      return
    else
      self:_Log("选择完毕结算房间 当前房间状态:", nodeState)
      self._machine:ChangeStateTo(SMazeState_RoomSettle, curNode, true)
      return
    end
  elseif state == SeasonMazeActionState.SMAS_Relic then
    self:_Log("选择完毕选圣物")
    self._machine:ChangeStateTo(SMazeState_ChooseRelic)
    return
  elseif state == SeasonMazeActionState.SMAS_NewHand then
    self:_Log("选完星灵升级了")
    self._machine:ChangeStateTo(SMazeState_Levelup)
    return
  elseif state == SeasonMazeActionState.SMAS_BossBattle then
    return
  elseif state == SeasonMazeActionState.SMAS_RoundEnd then
    self._machine:ChangeStateTo(SMazeState_RoundEnd, self._machine:GetCurNode())
  end
end
