require("common_async_base")
_class("GM_SetWhiteTestSeasonMazeTrue", Common_AsyncBase)
GM_SetWhiteTestSeasonMazeTrue = GM_SetWhiteTestSeasonMazeTrue

function GM_SetWhiteTestSeasonMazeTrue:TaskFunc(TT, status)
  self.m_pManager:AsyncGM_SetWhiteTestSeasonMazeTrue(TT, status)
end
