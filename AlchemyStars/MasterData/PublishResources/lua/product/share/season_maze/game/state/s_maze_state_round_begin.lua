require("s_maze_state_base")
_class("SMazeState_RoundBegin", SMazeStateBase)
SMazeState_RoundBegin = SMazeState_RoundBegin

function SMazeState_RoundBegin:OnEnter()
end

function SMazeState_RoundBegin:OnUpdate()
  self._machine:ChangeStateTo(SMazeState_PlayCard, self._machine:GetCurNode(), true)
end
