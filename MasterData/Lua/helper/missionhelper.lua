MissionHelper = {}


MissionHelper.GetTargetCount = function(id)
    local cfg = ConfigMgr.Config.missionMap[id];
    if (cfg ~= nil) then
        return cfg.condition1[1].Count;
    end
    return 0;
end