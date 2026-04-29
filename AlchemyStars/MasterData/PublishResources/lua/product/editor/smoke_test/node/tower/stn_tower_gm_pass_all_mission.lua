require("common_async_base")
_class("Tower_GM_PassAllMission", Common_AsyncBase)
Tower_GM_PassAllMission = Tower_GM_PassAllMission

function Tower_GM_PassAllMission:TaskFunc(TT, status)
  local gmproxy = GameGlobal.GetModule(GMProxyModule)
  for type = 1, 8 do
    local cfg = Cfg.cfg_tower_detail({Type = type})
    if cfg then
      local maxStage = 1
      for _, c in pairs(cfg) do
        maxStage = math.max(maxStage, c.stage)
      end
      self._manager:AsyncGM_PassTowerLevel(TT, status, type, maxStage)
      if status:IsErrorOccured() then
        return
      end
    end
  end
end
