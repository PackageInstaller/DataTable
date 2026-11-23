require("HexUtils")

ConfigSlgMgr = {}

local this = {
	cityMap = nil,
	cityPosMap = nil,
	skillMap = nil,
	skillUnify = 0,
	collectMap = nil,
	collectTypeMap = {t1="", t2="", t3=""},
	resourcesMaxMap = {},
	activityMapEvent = nil,
};

ConfigSlgMgr.Init = function()
	this.InitCitys();
	this.InitSkill();
	this.InitCollect();
	this.collectTypeMap.t1 = ConfigMgr.LangGlobal("10309");
	this.collectTypeMap.t2 = ConfigMgr.LangGlobal("10310");
	this.collectTypeMap.t3 = ConfigMgr.LangGlobal("10311");
	this.InitResourcesMax();
end

ConfigSlgMgr.Clear = function()
	this.cityMap = nil;
	this.cityPosMap = nil;
	this.skillMap = nil;
	this.collectMap = nil;
	this.activityMapEvent = nil;
end


this.InitCitys = function()
	this.cityMap = {};
	this.cityPosMap = {};
	local config;
	local key;
	local qinBuildArray = ConfigMgr.Config.QinBuildArray;
	local len = #qinBuildArray;
	for i = 1, len do
		config = qinBuildArray[i];
		if (#config.Position > 0) then
			this.cityMap[config.Id] = config;
			key = HexUtils.P2V(config.Position[1], config.Position[2]);
			this.cityPosMap[key] = config;
		end
	end
end


ConfigSlgMgr.GetCityConfig = function(id)
	return this.cityMap[id];
end


ConfigSlgMgr.GetCityConfigByPos = function(x, y)
	local key = HexUtils.P2V(x, y);
	return this.cityPosMap[key];
end


ConfigSlgMgr.GetMyCapital = function()
	local config;
	local initialForce = ConfigMgr.Config.QinTimesConstants.InitialForce;
	local qinBuildArray = ConfigMgr.Config.QinBuildArray;
	local len = #qinBuildArray;
	for i = 1, len do
		config = qinBuildArray[i];
		if (config.Type == SlgCityType.capital and config.Country == initialForce) then
			return config;
		end
	end
	return nil;
end


ConfigSlgMgr.GetCitysByCountry = function(country)
	local config;
	local list = {};
	local qinBuildArray = ConfigMgr.Config.QinBuildArray;
	local len = #qinBuildArray;
	for i = 1, len do
		config = qinBuildArray[i];
		if (config.Country == country) then
			table.insert(list, config);
		end
	end
	return list;
end


ConfigSlgMgr.GetCitysByCapital = function()
	local config;
	local list = {};
	local qinBuildArray = ConfigMgr.Config.QinBuildArray;
	local len = #qinBuildArray;
	for i = 1, len do
		config = qinBuildArray[i];
		if (config.Type == SlgCityType.capital) then
			table.insert(list, config);
		end
	end
	return list;
end


ConfigSlgMgr.GetCityMaxLevel = function(type)
	local level = 0;
	local map = ConfigMgr.Config.QinTimesRankTypeLvMap[type];
	for _, v in pairs(map) do
		if (level < v.Rank) then
			level = v.Rank;
		end
	end
	return level;
end


ConfigSlgMgr.GetCityRank = function(type, level)
	local map = ConfigMgr.Config.QinTimesRankTypeLvMap[type];
	return map[tostring(level)];
end


ConfigSlgMgr.GetCityIcon = function(type)
	if (type == SlgCityType.capital) then
		return ConfigMgr.Config.QinTimesConstants.OccupySwitchCapital;
	end
	if (type == SlgCityType.town) then
		return ConfigMgr.Config.QinTimesConstants.OccupySwitchTown;
	end
	return ConfigMgr.Config.QinTimesConstants.OccupySwitchFort;
end


ConfigSlgMgr.GetQinDynastyCountry = function(country)
	local config = ConfigMgr.Config.QinDynastyCountryMap[country];
	if (config ~= nil) then
		return config;
	end
	return nil;
end


ConfigSlgMgr.GetGridTile = function(country, isLock, isAttack)
	local config = ConfigMgr.Config.QinDynastyCountryMap[country];
	if (config ~= nil) then
		if (isLock ~= nil and isLock) then
			return config.LockBlock;
		end
		if (isAttack ~= nil and not isAttack) then
			return config.FarBlock;
		end
		return config.ColorBlock;
	end
	return "tile_idle";
end


ConfigSlgMgr.GetCountryName = function(country)
	local config = ConfigMgr.Config.QinDynastyCountryMap[country];
	if (config ~= nil) then
		return config.Country;
	end
	return "";
end


ConfigSlgMgr.GetCityType = function(type)
	if (type == "capital") then
		return ConfigMgr.LangGlobal("10413");
	elseif (type == "town") then
		return ConfigMgr.LangGlobal("10414");
	elseif (type == "fort") then
		return ConfigMgr.LangGlobal("10415");
	end
	return "";
end


ConfigSlgMgr.GetUnify = function()
	local unify = 0;
	local qinBuildArray = ConfigMgr.Config.QinBuildArray;
	local len = #qinBuildArray;
	for i = 1, len do
		config = qinBuildArray[i];
		if (config.UnifyValue > 0) then
			unify = unify + config.UnifyValue;
		end
	end
	return unify + this.skillUnify;
end


ConfigSlgMgr.GetEventConfig = function(id)
	return ConfigMgr.Config.QinTimesEventMap[id];
end


this.InitSkill = function()
	this.skillMap = {};
	local unifyValue;
	local qinTimesSkillLvMap = ConfigMgr.Config.QinTimesSkillLvMap;
	for _, map in pairs(qinTimesSkillLvMap) do
		unifyValue = 0;
		for _, v in pairs(map) do
			this.skillMap[v.Id] = v;
			if (v.UnifyValue > unifyValue) then
				unifyValue = v.UnifyValue;
			end
		end
		this.skillUnify = this.skillUnify + unifyValue;
	end
end


ConfigSlgMgr.GetSkillConfig = function(id)
	return this.skillMap[id];
end


ConfigSlgMgr.GetSkillByGroupAndLevel = function(group, level)
	local map = ConfigMgr.Config.QinTimesSkillLvMap[group];
	if (map ~= nil) then
		return map[tostring(level)];
	end
	return nil;
end


ConfigSlgMgr.GetSkillMaxLevel = function(group)
	local level = 0;
	local map = ConfigMgr.Config.QinTimesSkillLvMap[group];
	if (map ~= nil) then
		for _, v in pairs(map) do
			if (v.Level > level) then
				level = v.Level;
			end
		end
	end
	return level;
end


this.InitCollect = function()
	this.collectMap = {};
	local len;
	local config;
	local qinTimeCollectTypeMap = ConfigMgr.Config.QinTimeCollectTypeMap;
	for _, v in pairs(qinTimeCollectTypeMap) do
		len = #v;
		for i = 1, len do
			config = v[i];
			this.collectMap[config.Id] = config;
		end
	end
end


ConfigSlgMgr.GetCollectConfig = function(id)
	return this.collectMap[id];
end


ConfigSlgMgr.GetCollectCount = function(type)
	local list = ConfigMgr.Config.QinTimeCollectTypeMap[type];
	return list ~= nil and #list or 0;
end


ConfigSlgMgr.GetCollectTypeName = function(type)
	return this.collectTypeMap["t" .. type];
end


ConfigSlgMgr.GetCollectTypeIcon = function(type, select)
	if (type == "1") then
		return select and "ui_hd_dq_sptj_xx_04" or "ui_hd_dq_sptj_xx_07";
	elseif (type == "2") then
		return select and "ui_hd_dq_sptj_xx_05" or "ui_hd_dq_sptj_xx_08";
	elseif (type == "3") then
		return select and "ui_hd_dq_sptj_xx_06" or "ui_hd_dq_sptj_xx_09";
	end
	return "";
end


ConfigSlgMgr.GetCollectContent = function(config)
	local type = config.Unlock[1];
	if (type == "1") then
		local cityConfig = ConfigSlgMgr.GetCityConfig(config.Unlock[2]);
		if (cityConfig ~= nil) then
			return string.format(ConfigMgr.LangGlobal("10349"), LuaMgr.GetLangText(cityConfig.CityNameLan));
		end
	elseif (type == "2") then
		local cityConfig = ConfigSlgMgr.GetCityConfig(config.Unlock[2]);
		if (cityConfig ~= nil) then
			return string.format(ConfigMgr.LangGlobal("10350"), LuaMgr.GetLangText(cityConfig.CityNameLan));
		end
	elseif (type == "3") then
		local skillConfig = ConfigSlgMgr.GetSkillConfig(config.Unlock[2]);
		if (skillConfig ~= nil) then
			return string.format(ConfigMgr.LangGlobal("10351"), LuaMgr.GetLangText(skillConfig.NameLan));
		end
	end
	return "";
end


ConfigSlgMgr.GetBuffName = function(id)
	local config = ConfigMgr.Config.QinTimesBuffMap[id];
	if (config ~= nil) then
		return LuaMgr.GetLangText(config.NameLan);
	end
	return "";
end


ConfigSlgMgr.GetBuffEffect = function(id)
	local config = ConfigMgr.Config.QinTimesBuffMap[id];
	if (config ~= nil) then
		return LuaMgr.GetLangText(config.BuffTextLan);
	end
	return "";
end


ConfigSlgMgr.GetBuffSource = function(id)
	local config = ConfigMgr.Config.QinTimesBuffMap[id];
	if (config ~= nil) then
		if (config.Source == 1) then
			return "Technology";
		elseif (config.Source == 2) then
			return "Event";
		elseif (config.Source == 3) then
			return "Other";
		elseif (config.Source == 4) then
			return "Strategy";
		end
	end
	return "";
end


this.InitResourcesMax = function()
	local res;
	local initialResourcesMax = ConfigMgr.Config.QinTimesConstants.InitialResourcesMax;
	local len = #initialResourcesMax;
	for i = 1, len do
		res = initialResourcesMax[i];
		this.resourcesMaxMap[res[1]] = tonumber(res[2]);
	end
end


ConfigSlgMgr.GetResourcesMax = function(id)
	return this.resourcesMaxMap[id];
end


ConfigSlgMgr.InitActivityMapEvent = function(eventList)
	this.activityMapEvent = {};
	local event;
	local len = #eventList;
	for i = 1, len do
		event = eventList[i];
		this.activityMapEvent[event.id] = event;
	end
end


ConfigSlgMgr.GetActivityMapEvent = function(id)
	return this.activityMapEvent[id];
end


ConfigSlgMgr.GetUnlockName = function(unlockParam)
	local config = nil
	for i, v in ipairs(ConfigMgr.Config.activityMapEventList) do
		if v.id == unlockParam then
			config = v
			break
		end
	end
	if (config ~= nil) then
		return LuaMgr.GetLangText(config.namelan)
	end
	return "";
end