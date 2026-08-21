require("s_maze_state_base")
_class("SMazeState_MazeComplete", SMazeStateBase)
SMazeState_MazeComplete = SMazeState_MazeComplete

function SMazeState_MazeComplete:OnEnter()
  self:StartTask(self._ReqComplete, self)
end

function SMazeState_MazeComplete:_ReqComplete(TT)
  GameGlobal.UIStateManager():ShowDialog("UISeasonMazeCompleteResult", nil, true)
end
