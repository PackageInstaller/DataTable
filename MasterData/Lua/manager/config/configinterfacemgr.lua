ConfigInterfaceMgr = {}

local this = {
	interfaceMap = nil,
	interfaceIdMap = nil,
};

ConfigInterfaceMgr.Init = function()
	this.InitInterface();
end

ConfigInterfaceMgr.Clear = function()
	this.interfaceMap = nil;
	this.interfaceIdMap = nil;
end


this.InitInterface = function()
	this.interfaceMap = {};
	this.interfaceIdMap = {};
	local config;
	local list;
	local interfaces = ConfigMgr.Config.interfaces;
	local len = #interfaces;
	for i = 1, len do
		config = interfaces[i];
		if (config.screen ~= "") then
			list = this.interfaceMap[config.screen]
			if (list == nil) then
				list = {};
				this.interfaceMap[config.screen] = list;
			end
			table.insert(list, config);
		end
		this.interfaceIdMap[config.id] = config;
	end
end


ConfigInterfaceMgr.GetInterfaceById = function(id)
	if this.interfaceIdMap==nil then
		return nil;
	end
	return this.interfaceIdMap[id];
end


ConfigInterfaceMgr.GetInterface = function(screen, tab)
	if this.interfaceMap==nil then return nil end;
	local list = this.interfaceMap[screen];
	if (list ~= nil) then
		if (tab == "") then
			return list[1];
		end
		local config;
		local len = #list;
		for i = 1, len do
			config = list[i];
			if (config.tab == tab) then
				return config;
			end
		end
	end
	return nil;
end