-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Helper\\RemoteConfig.lua

local HttpUtils = Framework.Network.HttpUtils
local LuaToolkit = Framework.Tools.LuaToolkit
local EventConst = require("EventConst")
local DeviceHelper = require("Helper/DeviceHelper")
local RemoteConfig = {}
local self = RemoteConfig

self._switchDict = {}

local KEY_CONFIG_KEY = "key"
local KEY_CONFIG_VALUE = "value"
local KEY_ENGINE_MIN = "engine_min"
local KEY_ENGINE_MAX = "engine_max"
local KEY_REQUIRE_CHANNELS = "channels"
local KEY_REQUIRE_SPMARKS = "spmarks"

function RemoteConfig.init()
	if self._timerUpdate == nil then
		self._timerUpdate = Timer.New(self._onRefresh, 1800, -1)
	end

	self._onRefresh()
	self._timerUpdate:Restart()
end

function RemoteConfig.getValue(key)
	return self._switchDict[key]
end

function RemoteConfig._onRefresh()
	local url = self._getUrl()

	if url then
		HttpHelper.get(url, self._onGetData, 3)
	end
end

function RemoteConfig._onGetData(succ, data)
	self._load(data)
	EventCenter.sendEvent(EventConst.REMOTE_CONFIG_LOADED)
end

function RemoteConfig._getUrl()
	if self._url == nil then
		local url, urlStr
		local localPatchVersion = LuaToolkit.GetLocalPatchVersion()

		if localPatchVersion then
			urlStr = localPatchVersion.downloadVersion
		end

		if IS_EDITOR and urlStr == nil then
			urlStr = "http://192.168.1.217:8001/dev/antman/pl/android/"

			if RegionUtils.isJP() then
				urlStr = "http://192.168.1.219:8001/dev/antman_jp/pl/android/"
			end
		end

		if urlStr then
			urlStr = urlStr .. "remote_config_" .. string.lower(DeviceHelper.runtimePlatform)

			local UrlConfig = require("Network/UrlConfig")

			if UrlConfig.isPre then
				urlStr = urlStr .. ".pre"
			end

			Framework.Tools.LuaToolkit.LogEx("urlStr: " .. urlStr)

			self._url = HttpHelper.createUrlGroup({
				urlStr
			})
		end
	end

	if self._url ~= nil then
		ClientUtils.composeGetUrl(self._url, {
			t = math.floor(os.time() / 120)
		})
	end

	return self._url
end

function RemoteConfig._load(content)
	self._switchDict = {}

	local configList

	if content then
		configList = ClientUtils.string2Table(content)
	end

	if not configList then
		return
	end

	for i, item in ipairs(configList) do
		if type(item) ~= "table" then
			-- block empty
		else
			local key = item[KEY_CONFIG_KEY]
			local value = item[KEY_CONFIG_VALUE]

			if key ~= nil and value ~= nil then
				while true do
					local isOn
					local engineMin = tonumber(item[KEY_ENGINE_MIN])
					local engineMax = tonumber(item[KEY_ENGINE_MAX])
					local engineVersion = VersionUtils.getEngineVersion()

					if engineMin and engineVersion < engineMin then
						break
					end

					if engineMax and engineMax <= engineVersion then
						break
					end

					local conditionChannels = item[KEY_REQUIRE_CHANNELS]

					if conditionChannels and type(conditionChannels) == "table" then
						local bingo = false
						local subChannel = ChannelUtil.getSubChannelID()

						for _, channel in ipairs(conditionChannels) do
							if subChannel == channel then
								bingo = true

								break
							end
						end

						if not bingo then
							break
						end
					end

					local conditionSpmarks = item[KEY_REQUIRE_SPMARKS]

					if conditionSpmarks and type(conditionSpmarks) == "table" then
						local bingo = false
						local spmark = LuaToolkit.GetPatchSPMark()

						for _, condition in ipairs(conditionSpmarks) do
							if spmark == condition then
								bingo = true

								break
							end
						end

						if not bingo then
							break
						end
					end

					if RegionUtils.isJP() and item[Const.REMOTE_CONFIG_KEY_JP_TIME_A] then
						self._switchDict[Const.REMOTE_CONFIG_KEY_JP_TIME_A] = item[Const.REMOTE_CONFIG_KEY_JP_TIME_A]
						self._switchDict[Const.REMOTE_CONFIG_KEY_JP_TIME_B] = item[Const.REMOTE_CONFIG_KEY_JP_TIME_B]
						self._switchDict[Const.REMOTE_CONFIG_KEY_TIPS_TEXT] = item[Const.REMOTE_CONFIG_KEY_TIPS_TEXT]
					end

					if RegionUtils.isCN() then
						self._switchDict[Const.REMOTE_CONFIG_KEY_CHA_TIME_S] = item[Const.REMOTE_CONFIG_KEY_CHA_TIME_S]
						self._switchDict[Const.REMOTE_CONFIG_KEY_CHA_TIME_E] = item[Const.REMOTE_CONFIG_KEY_CHA_TIME_E]
					end

					self._switchDict[key] = value

					break
				end
			end
		end
	end
end

return RemoteConfig
