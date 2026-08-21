_class("SMazeMapHistoryEventpointMgr", Object)
SMazeMapHistoryEventpointMgr = SMazeMapHistoryEventpointMgr

function SMazeMapHistoryEventpointMgr:Init(seasonId, root)
  self._historyEventpoints = {}
  local cfgs = Cfg.cfg_season_maze_eventpoint_history({SeasonID = seasonId})
  if cfgs then
    for k, cfg in pairs(cfgs) do
      local p = SMazeMapHistoryEventpoint:New(cfg, root)
      table.insert(self._historyEventpoints, p)
    end
  end
end

function SMazeMapHistoryEventpointMgr:Dispose()
  for k, p in pairs(self._historyEventpoints) do
    p:Dispose()
  end
  table.clear(self._historyEventpoints)
end
