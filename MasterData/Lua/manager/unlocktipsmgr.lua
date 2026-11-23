UnlockTipsMgr = {}


UnlockTipsMgr.level = 0;

UnlockTipsMgr.completedAreaEvents = nil;

UnlockTipsMgr.unlockTipsList = {};


local function InitCompletedAreaEvents()
	local areaEvents = {};
	local completedAreaEvents = DataMgr.Player.completedAreaEvents;
	for k, _ in pairs(completedAreaEvents) do
		areaEvents[k] = true;
	end
	UnlockTipsMgr.completedAreaEvents = areaEvents;
end


local function GetCompletedAreaEvent()
	local areaEvents = {};
	local completedAreaEvents = DataMgr.Player.completedAreaEvents;
	for k, _ in pairs(completedAreaEvents) do
		if (UnlockTipsMgr.completedAreaEvents[k] == nil) then
			UnlockTipsMgr.completedAreaEvents[k] = true;
			table.insert(areaEvents, k);
		end
	end
	return areaEvents;
end


local function CheckAreaEvent()
	local areaEvents = GetCompletedAreaEvent();
	local len = #areaEvents;
	if (len > 0) then
		local config;
		local areaEventId;
		local unlockTips = ConfigMgr.Config.unlockTips;
		local len2 = #unlockTips;
		for i = 1, len do
			areaEventId = areaEvents[i];
			for j = 1, len2 do
				config = unlockTips[j];
				if (config.Condition[1] == "2" and config.Condition[2] == areaEventId) then
					table.insert(UnlockTipsMgr.unlockTipsList, config);
				end
			end
		end
	end
end


local function CheckUpLevel(level)
	if (level > UnlockTipsMgr.level) then
		local config;
		local lv;
		local unlockTips = ConfigMgr.Config.unlockTips;
		local len = #unlockTips;
		for i = 1, len do
			config = unlockTips[i];
			if (config.Condition[1] == "1") then
				lv = tonumber(config.Condition[2]);
				if (lv == level) then
					table.insert(UnlockTipsMgr.unlockTipsList, config);
				end
			end
		end
	end
end


UnlockTipsMgr.Init = function()
	UnlockTipsMgr.level = DataMgr.Player.level;
	InitCompletedAreaEvents();
	LuaMgr.RemoveDataEventListener(UnlockTipsMgr.OnDataEvent);
	LuaMgr.AddDataEventListener(UnlockTipsMgr.OnDataEvent);
end


UnlockTipsMgr.CheckUnlockTips = function()
	if (#UnlockTipsMgr.unlockTipsList > 0) then
		local list = {};
		local len = #UnlockTipsMgr.unlockTipsList;
		for i = 1, len do
			list[i] = UnlockTipsMgr.unlockTipsList[i];
		end
		UnlockTipsMgr.unlockTipsList = {};
		LuaMgr.ShowLuaPanel(UIName.FeatureUnlockViewModel, list);
	end
end


UnlockTipsMgr.OnDataEvent = function(args)
	local type = args[0];
	if (type == "level") then
		CheckUpLevel(args[1]);
	elseif (type == "completedAreaEvents") then
		CheckAreaEvent();
	end
end