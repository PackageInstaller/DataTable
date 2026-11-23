ConfigGuoBaoMgr = {}

local this = {
	activityMapEvent = nil,
	simulatedShopMap = nil,
};

ConfigGuoBaoMgr.Init = function()
	this.InitSimulatedShop();
end

ConfigGuoBaoMgr.Clear = function()
	this.activityMapEvent = nil;
	this.simulatedShopMap = nil;
end


ConfigGuoBaoMgr.InitActivityMapEvent = function(eventList)
	this.activityMapEvent = {};
	local event;
	local len = #eventList;
	for i = 1, len do
		event = eventList[i];
		this.activityMapEvent[event.id] = event;
	end
end


ConfigGuoBaoMgr.GetActivityMapEvent = function(id)
	return this.activityMapEvent[id];
end


this.InitSimulatedShop = function()
	this.simulatedShopMap = {};
	if (ConfigMgr.Config.SimulatedShopMap == nil) then return end
	
	local list;
	for _, v in pairs(ConfigMgr.Config.SimulatedShopMap) do
		list = this.simulatedShopMap[v.Group];
		if (list == nil) then
			list = {};
			this.simulatedShopMap[v.Group] = list;
		end
		table.insert(list, v);
	end
end


ConfigGuoBaoMgr.GetSimulatedShop = function(group, level)
	local list = this.simulatedShopMap[group];
	if (list ~= nil) then
		local len = #list;
		for i = 1, len do
			if (list[i].Level == level) then
				return list[i];
			end
		end
	end
	return nil;
end


ConfigGuoBaoMgr.GetSimulatedShopList = function()
	local simulatedShopList = {};
	for k, _ in pairs(this.simulatedShopMap) do
		table.insert(simulatedShopList, k);
	end
	return simulatedShopList;
end


ConfigGuoBaoMgr.GetBuildingYields = function(config)
	local num = 3600 / config.Period * config.YieldsBase;
	local numStr = string.format("%.2f", num);
	return LuaMgr.Replace(numStr, ".00", "");
end


ConfigGuoBaoMgr.GetSimulatedShopQuestEvent = function(text)
	local questEvent = ConfigMgr.Config.questEvent;
	for _, v in pairs(questEvent) do
		if (v.text == text) then
			return v;
		end
	end
	return nil;
end


ConfigGuoBaoMgr.GetEventList = function(eventType)
	local eventList = {};
	local guoBaoEventMap = ConfigMgr.Config.GuoBaoEventMap;
	for _, v in pairs(guoBaoEventMap) do
		if (v.EventType == eventType) then
			table.insert(eventList, v);
		end
	end
	table.sort(eventList, this.SortEventList);
	return eventList;
end


this.SortEventList = function(a, b)
	return tonumber(a.ID) < tonumber(b.ID);
end


ConfigGuoBaoMgr.GetEventUnlockTime = function(eventType)
	local eventList = ConfigGuoBaoMgr.GetEventList(eventType);
	if (#eventList > 0) then
		return eventList[1].StartTime - LuaMgr.Timestamp();
	end
	return 0;
end


ConfigGuoBaoMgr.IsEventUnlock = function(eventType)
	if (ConfigGuoBaoMgr.GetEventUnlockTime(eventType) > 0) then
		LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ConfigGuoBaoMgr_0"));
		return false;
	end
	return true;
end


ConfigGuoBaoMgr.GetNumStr = function(num)
	if (num <= 10) then
		return this.GetNumText(num);
	end
	local str = "";
	local n = math.floor(num / 10);
	if (n > 1) then
		str = this.GetNumText(n);
	end
	str = str .. this.GetNumText(10) .. this.GetNumText(num % 10);
	return str;
end


this.GetNumText = function(num)
	if (num == 1) then
		return LuaMgr.GetLangText("ConfigGuoBaoMgr_1");
	elseif (num == 2) then
		return LuaMgr.GetLangText("ConfigGuoBaoMgr_2");
	elseif (num == 3) then
		return LuaMgr.GetLangText("ConfigGuoBaoMgr_3");
	elseif (num == 4) then
		return LuaMgr.GetLangText("ConfigGuoBaoMgr_4");
	elseif (num == 5) then
		return LuaMgr.GetLangText("ConfigGuoBaoMgr_5");
	elseif (num == 6) then
		return LuaMgr.GetLangText("ConfigGuoBaoMgr_6");
	elseif (num == 7) then
		return LuaMgr.GetLangText("ConfigGuoBaoMgr_7");
	elseif (num == 8) then
		return LuaMgr.GetLangText("ConfigGuoBaoMgr_8");
	elseif (num == 9) then
		return LuaMgr.GetLangText("ConfigGuoBaoMgr_9");
	elseif (num == 10) then
		return LuaMgr.GetLangText("ConfigGuoBaoMgr_10");
	end
	return "";
end