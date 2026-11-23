ConfigMgr = {}

ConfigMgr.Config = {};

function ConfigMgr.Init()
	ConfigInterfaceMgr.Init();
	ConfigFoundationMgr.Init();

	ConfigVoyageMgr.Init();
	ConfigRhythmGameMgr.Init();



	ActivityMgr.Init();
	ConfigKZRYMgr.Init();
	ManagementData.Init()
	ZXLData.Init()
end

function ConfigMgr.ConfigKeys(data)
	local key;
	local jsonData = json.decode(data);
	local configKeys = jsonData.configKeys;
	local len = #configKeys;
	if (len > 0) then
		for i = 1, len do
			key = configKeys[i];
			ConfigMgr.Config[key] = jsonData.config[key];
		end
	end
end

function ConfigMgr.LuaConfig(key, data)
	local jsonData = json.decode(data);
	ConfigMgr.Config[key] = jsonData;
end

function ConfigMgr.Clear()


	ConfigInterfaceMgr.Clear();
	ConfigFoundationMgr.Clear();
	ConfigSlgMgr.Clear();
	ConfigVoyageMgr.Clear();
	ConfigRhythmGameMgr.Clear();
	ConfigQinMgr.Clear();
	ConfigCharacterMgr.Clear();
	ConfigGuoBaoMgr.Clear();
	ConfigSGYMgr.Clear();
	ConfigKZRYMgr.Clear();
end


function ConfigMgr.LangGlobal(id)
	if ConfigMgr.Config.langGlobal==nil then
		print("langGlobal is nil")
		return id;
	end
	local config = ConfigMgr.Config.langGlobal[id];
	if (config ~= nil) then
		return LuaMgr.GetLangText(config.NameLan);
	end
	return id;
end