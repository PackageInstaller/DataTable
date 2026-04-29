require("s_maze_state_base")
_class("SMazeState_ChooseRelic", SMazeStateBase)
SMazeState_ChooseRelic = SMazeState_ChooseRelic

function SMazeState_ChooseRelic:OnEnter(...)
  if GameGlobal.UIStateManager():IsShow("UISeasonMazeSelectRelicPopUp") then
    self:_Log("圣物选择界面已经打开了")
  else
    self:ShowDialog("UISeasonMazeSelectRelicPopUp")
  end
end

function SMazeState_ChooseRelic:Finish()
  local cpt = self._manager:GetMazeComponent()
  if cpt:CurOperate() == SeasonMazeActionState.SMAS_HardClearing then
    self:_Log("选完圣物秘境结算")
    self._machine:ChangeStateTo(SMazeState_MazeComplete)
    return
  elseif cpt:CurOperate() == SeasonMazeActionState.SMAS_BreakPet then
    self:_Log("选完圣物选择满破星灵")
    self._machine:ChangeStateTo(SMazeState_ChooseFullPet)
    return
  elseif cpt:CurOperate() == SeasonMazeActionState.SMAS_NewHand then
    self:_Log("选完圣物升级了")
    self._machine:ChangeStateTo(SMazeState_Levelup)
    return
  elseif cpt:CurOperate() == SeasonMazeActionState.SMAS_RoomOperate then
    self:_Log("选完圣物结算房间")
    self._machine:ChangeStateTo(SMazeState_RoomSettle, self._machine:GetCurNode(), true)
    return
  elseif cpt:CurOperate() == SeasonMazeActionState.SMAS_ChooseHand then
    self:_Log("选完圣物继续出牌")
    self._machine:ChangeStateTo(SMazeState_PlayCard, self._machine:GetCurNode(), false)
    return
  elseif cpt:CurOperate() == SeasonMazeActionState.SMAS_RoundEnd then
    self:_Log("选完圣物回合结束")
    self._machine:ChangeStateTo(SMazeState_RoundEnd, self._machine:GetCurNode())
    return
  end
  self:_Log("选完圣物状态错误:", cpt:CurOperate())
end
