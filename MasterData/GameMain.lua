GameMain = {}

function GameMain.Start()
  require("FirstAsyncLoader").StartFirstLoad()
  GameMain = nil
end
