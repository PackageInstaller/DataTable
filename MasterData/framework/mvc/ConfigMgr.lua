-- chunkname: @framework/mvc/ConfigMgr.lua

module("framework.mvc.ConfigMgr", package.seeall)

local ConfigMgr = class("ConfigMgr")

function ConfigMgr:ctor()
	self._resPath = "configs/excel2json/json_"
	self._luaPath = "modules.configs.excel2json.lua_"
	self._abPath = "configs/datacfg_"
	self._requestorList = {}
	self._configNameList = {}
	self._configName2PathDict = {}
	self._configList = {}
	self._configDict = {}
	self._onLoadedCallback = nil
	self._onLoadedCallbackObj = nil
end

function ConfigMgr:init(resPath, luaPath, abPath)
	self._resPath = resPath
	self._luaPath = luaPath
	self._abPath = abPath
end

function ConfigMgr:addRequestor(requestor)
	table.insert(self._requestorList, requestor)

	local configNames = requestor:reqConfigNames()

	if configNames then
		if not #configNames then
			local configCount = 0

			for i = 1, configCount do
				local configName = configNames[i]

				if not self._configName2PathDict[configName] then
					self._configName2PathDict[configName] = string.format("%s%s.json", self._resPath, configName)

					table.insert(self._configNameList, configName)
				end
			end
		end
	end
end

function ConfigMgr:loadConfigs(callback, callbackObj)
	if #self._configNameList == 0 then
		if callback then
			if callbackObj then
				callback(callbackObj)
			else
				callback()
			end
		end

		return
	end

	self._onLoadedCallback = callback
	self._onLoadedCallbackObj = callbackObj

	if GameResMgr.IsFromEditorDir then
		for _, v in ipairs(self._configNameList) do
			local configPath = self._configName2PathDict[v]

			loadNonAbAsset(configPath, SLFramework.AssetType.TEXT, self._onConfigAbCallback, self)
		end

		logNormal("--编辑器Direct运行时，检查对应的json、jua是否有缺")
		self:_editorCheckLuaJson()
	else
		logNormal("-- json的ab是 AllToOne ，加载一次，就可以把所有json拿到了（可能会有多余的配置，自觉删除无用配置，否则报错）self._abPath = " .. self._abPath)

		self._jsonList = {}
		self._frameHandleNum = 20
		self._nowHandNum = 0
		self._allHandNum = 0
		self._maxConfigDatNum = 5
		self._configDatIndex = 1

		loadNonAbAsset(string.format("%s%s%s", self._abPath, self._configDatIndex, ".dat"), SLFramework.AssetType.DATA, self._onConfigOneAbCallback, self)
	end
end

function ConfigMgr:_onConfigOneAbCallback(assetItem)
	local allDataStr = assetItem:GetNonAbTextAsset(true)
	local allJson = cjson.decode(allDataStr)

	self._allHandNum = self._allHandNum + tabletool.len(allJson)

	for _, config in pairs(allJson) do
		table.insert(self._jsonList, config)
	end

	if self._configDatIndex == self._maxConfigDatNum then
		self:_onConfigAllAbCallback()
	else
		self._configDatIndex = self._configDatIndex + 1

		loadNonAbAsset(string.format("%s%s%s", self._abPath, self._configDatIndex, ".dat"), SLFramework.AssetType.DATA, self._onConfigOneAbCallback, self)
	end
end

function ConfigMgr:_onConfigAllAbCallback()
	TaskDispatcher.runRepeat(self._onConfigLoadedRepeat, self, 0.01)
end

function ConfigMgr:_onConfigAbCallback(assetItem)
	if not assetItem.IsLoadSuccess then
		logError("config load fail: " .. assetItem.ResPath)

		return
	end

	if GameResMgr.IsFromEditorDir then
		self:_onConfigLoaded(assetItem.TextAsset)
	else
		local allDataStr = assetItem:GetNonAbTextAsset(true)
		local allJson = cjson.decode(allDataStr)

		self._frameHandleNum = 20
		self._nowHandNum = 0
		self._allHandNum = tabletool.len(allJson)
		self._jsonList = {}

		for _, config in pairs(allJson) do
			table.insert(self._jsonList, config)
		end

		TaskDispatcher.runRepeat(self._onConfigLoadedRepeat, self, 0.01)
	end
end

function ConfigMgr:_onConfigLoadedRepeat()
	for i = 1, self._frameHandleNum do
		self._nowHandNum = self._nowHandNum + 1

		local config = self._jsonList[self._nowHandNum]

		self:_onConfigLoaded(config)

		if self._nowHandNum == self._allHandNum then
			TaskDispatcher.cancelTask(self._onConfigLoadedRepeat, self)

			self._jsonList = nil

			if not GameResMgr.IsFromEditorDir and #self._configList ~= #self._configNameList then
				for _, configName in ipairs(self._configNameList) do
					if not self._configDict[configName] then
						logError("config: <" .. configName .. "> not exist. You're runnning in AssetBundle mode.")
					end
				end
			end

			break
		end
	end
end

function ConfigMgr:_onConfigLoaded(jsonString)
	local json = self:_decodeJsonStr(jsonString)
	local configName = json[1]
	local configText = json[2]

	if not configName then
		logError("config name not exist: " .. jsonString)

		return
	end

	local luaConfig = addGlobalModule(self._luaPath .. configName, configName)

	if not luaConfig then
		logError("config lua head not exist: <" .. configName .. ">")

		return
	end

	if not GameResMgr.IsFromEditorDir and isDebugBuild and GameConfig.UseDebugLuaFile then
		local filePath = UnityEngine.Application.persistentDataPath .. string.format("/lua/json_%s.json", configName)
		local text = SLFramework.FileHelper.ReadText(filePath)

		if not string.nilorempty(text) then
			logNormal("替换了外部目录的json配置表：" .. configName)

			json = self:_decodeJsonStr(text)
			configText = json[2]
		end
	end

	luaConfig.onLoad(configText)

	if not self._configDict[configName] then
		if self._configName2PathDict[configName] then
			self._configDict[configName] = luaConfig

			table.insert(self._configList, luaConfig)
		else
			logWarn("config: <" .. configName .. "> never use, please remove it")
		end
	end

	if #self._configList == #self._configNameList and not self._requestorCbDone then
		self._requestorCbDone = true

		for _, requestor in ipairs(self._requestorList) do
			local configNames = requestor:reqConfigNames()

			if configNames then
				if not #configNames then
					local configCount = 0

					for i = 1, configCount do
						requestor:onConfigLoaded(configNames[i], self._configDict[configNames[i]])
					end
				end
			end
		end

		if self._onLoadedCallback then
			if self._onLoadedCallbackObj then
				self._onLoadedCallback(self._onLoadedCallbackObj)
			else
				self._onLoadedCallback()
			end
		end

		self._onLoadedCallback = nil
		self._onLoadedCallbackObj = nil
	end
end

function ConfigMgr:_decodeJsonStr(jsonString)
	local json

	if isDebugBuild then
		local ok, ret = pcall(cjson.decode, jsonString)

		if not ok then
			logError("配置解析失败: " .. jsonString)

			return
		end

		json = ret
	else
		json = cjson.decode(jsonString)
	end

	return json
end

function ConfigMgr:_editorCheckLuaJson()
	local luaPath = SLFramework.FrameworkSettings.ProjLuaRootDir .. "/modules/configs/excel2json/"
	local jsonPath = SLFramework.FrameworkSettings.AssetRootDir .. "/configs/excel2json/"
	local luaFilePaths = SLFramework.FileHelper.GetDirFilePaths(luaPath)
	local jsonFilePaths = SLFramework.FileHelper.GetDirFilePaths(jsonPath)
	local luaDict = {}
	local jsonDict = {}

	for i = 0, luaFilePaths.Length - 1 do
		local name = luaFilePaths[i]

		if not string.find(name, ".meta") and string.find(name, "lua_") then
			name = SLFramework.FileHelper.GetFileName(name, false)
			name = string.sub(name, 5)
			luaDict[name] = true
		end
	end

	for i = 0, jsonFilePaths.Length - 1 do
		local name = jsonFilePaths[i]

		if not string.find(name, ".meta") and string.find(name, "json_") then
			local name = SLFramework.FileHelper.GetFileName(name, false)

			name = string.sub(name, 6)
			jsonDict[name] = true
		end
	end

	for name, _ in pairs(luaDict) do
		if not jsonDict[name] then
			logError("config lua_" .. name .. ".lua not match, <color=red><json_" .. name .. ".json>" .. " not exist</color>")
		end
	end

	for name, _ in pairs(jsonDict) do
		if not luaDict[name] then
			logError("config json_" .. name .. ".json not match, <color=red><lua_" .. name .. ".lua>" .. " not exist</color>")
		end
	end
end

ConfigMgr.instance = ConfigMgr.New()

return ConfigMgr
