_class("MazeExitLoadingHandler", LoadingHandler)
MazeExitLoadingHandler = MazeExitLoadingHandler

function MazeExitLoadingHandler:PreLoadBeforeLoadLevel(TT)
end

function MazeExitLoadingHandler:PreLoadAfterLoadLevel(TT, ...)
  LoadingHandler.PreLoadAfterLoadLevel(self, TT, ...)
end

function MazeExitLoadingHandler:OnLoadingFinish(...)
  local params = {
    ...
  }
  local func = params[1]
  if type(func) == "function" then
    func()
  else
    Log.fatal("[MazeExit] 秘境Loading结束的参数必须是function")
  end
end
