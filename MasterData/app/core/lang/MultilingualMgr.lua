local var_0_0 = "use_lang"
local var_0_1 = "lang_info_version"
local var_0_2 = "lang_to_version"
local var_0_3 = "lang_last_downsz"
local var_0_4 = {}

var_0_4._useLang = nil
var_0_4._defaultLang = nil
var_0_4._langChangeArr = nil
var_0_4._langToNameDict = nil
var_0_4._langStorage = nil
var_0_4._checkFHX = true

function var_0_4:initLangSearchPath()
	local var_1_0 = cc.FileUtils:getInstance()
	local var_1_1 = json.decodeFileIfExists(var_1_0:getWritablePath() .. "userdata/multilingual.json")

	if var_1_0 == nil then
		cc.FileUtils:getInstance():addSearchPath("res/language/" .. config.DEFAULT_LANG .. "/", true)
		self:addFanHeXieFolderPath()

		return
	end

	local var_1_2 = "res/language/" .. var_1_1[var_0_0] .. "/"

	cc.FileUtils:getInstance():addSearchPath("res/language/" .. var_1_1[var_0_0] .. "/", true)
	cc.FileUtils:getInstance():addSearchPath((cc.FileUtils:getInstance():getWritablePath() .. "upgradelang/") .. var_1_2, true)
	self:addFanHeXieFolderPath()
end

function var_0_4.addFanHeXieFolderPath(arg_2_0)
	local var_2_0 = cc.FileUtils:getInstance():getWritablePath()

	cc.FileUtils:getInstance():createDirectory(var_2_0 .. "highquality/")
	cc.FileUtils:getInstance():addSearchPath((var_2_0 .. "highquality/") .. "res/", true)
	cc.FileUtils:getInstance():addSearchPath((var_2_0 .. "highquality/") .. "res/common/", true)
	cc.FileUtils:getInstance():addSearchPath(var_2_0 .. "highquality/", true)
end

function var_0_4:uploadFanHeXiePoint()
	if self._checkFHX then
		if not cc.FileUtils:getInstance():isDirectoryExist((cc.FileUtils:getInstance():getWritablePath() .. "highquality/") .. "res/common/") then
			if cc.FileUtils:getInstance():isDirectoryExist((cc.FileUtils:getInstance():getWritablePath() .. "highquality/") .. "knight_spine/") then
				self._checkFHX = false

				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
					event_id = g.core.const.ConstMgr.SuperSdkConst.USE_FHX_HIGH_QUALITY
				})
			end
		end
	end
end

function var_0_4:getUseLang()
	if self._useLang == nil then
		self:_initMultilingual()
	end

	return self._useLang
end

function var_0_4:setUseLang(arg_5_1)
	if self._useLang == arg_5_1 then
		return
	end

	self._useLang = arg_5_1
	self._langStorage[var_0_0] = arg_5_1

	self:_doSerialize()
end

function var_0_4:getLangVersion(arg_6_1)
	local var_6_0 = self._langStorage[arg_6_1][var_0_1]

	if arg_6_1 == config.DEFAULT_LANG and var_6_0 < config.LANG_VERSION_NO then
		var_6_0 = config.LANG_VERSION_NO
	end

	return var_6_0
end

function var_0_4:setLangVersion(arg_7_1, arg_7_2)
	self._langStorage[arg_7_1][var_0_1] = arg_7_2

	self:_doSerialize()
end

function var_0_4:getMultiLangs()
	return self._langChangeArr
end

function var_0_4:isAllowChangeTo(arg_9_1)
	for iter_9_0, iter_9_1 in pairs(self._langChangeArr) do
		if arg_9_1 == iter_9_1 then
			return true
		end
	end

	return false
end

function var_0_4:setLangToVer(arg_10_1, arg_10_2)
	self._langStorage[arg_10_1][var_0_2] = arg_10_2

	self:_doSerialize()
end

function var_0_4:setLangDownsz(arg_11_1, arg_11_2)
	self._langStorage[arg_11_1][var_0_3] = arg_11_2

	self:_doSerialize()
end

function var_0_4:setDownFinish(arg_12_1)
	self._langStorage[arg_12_1][var_0_1] = self._langStorage[arg_12_1][var_0_2]
	self._langStorage[arg_12_1][var_0_2] = 0
	self._langStorage[arg_12_1][var_0_3] = 0

	self:_doSerialize()
end

function var_0_4:getLocalLangInfo(arg_13_1)
	return self._langStorage[arg_13_1]
end

function var_0_4.getLangIdByDesc(arg_14_0, arg_14_1)
	for iter_14_0 = 1, g.core.config.language_config_info.getLength() do
		local var_14_0 = g.core.config.language_config_info.indexOf(iter_14_0)

		if arg_14_1 == var_14_0.language_1 then
			return var_14_0.id
		end
	end

	return nil
end

function var_0_4.getLangDescById(arg_15_0, arg_15_1)
	local var_15_0 = g.core.config.language_config_info.get(arg_15_1)

	if var_15_0 then
		return var_15_0.language_1
	else
		return nil
	end
end

function var_0_4:getLangNameByDesc(arg_16_1)
	return self._langToNameDict[arg_16_1]
end

function var_0_4:_initMultilingual()
	self._langToNameDict = {}

	if config.DEBUG_VERSION or config.SHOW_DEBUG_BTN then
		local var_17_0 = g.core.common.Storage:load("channelDebug.json", false)

		if var_17_0 and var_17_0.channel then
			config.PUBLISH_REGION = tonumber(var_17_0.channel)
		end
	end

	local var_17_1 = g.core.config.language_pack_info.get(config.PUBLISH_REGION)

	self._defaultLang = config.SHOW_DEBUG_BTN and config.DEFAULT_LANG or var_17_1.language_1

	local var_17_2, var_17_3 = var_17_1.getKeyLength("language_%d+")
	local var_17_4 = {}

	self._langChangeArr = {}

	for iter_17_0 = 1, var_17_3 do
		if var_17_1["language_" .. iter_17_0] ~= "" then
			table.insert(self._langChangeArr, var_17_1["language_" .. iter_17_0])

			var_17_4[var_17_1["language_" .. iter_17_0]] = #self._langChangeArr
		end
	end

	for iter_17_1 = 1, g.core.config.language_config_info.getLength() do
		local var_17_5 = g.core.config.language_config_info.indexOf(iter_17_1)

		if var_17_4[var_17_5.language_1] then
			self._langToNameDict[var_17_5.language_1] = var_17_5.name
		end
	end

	self:_doDeserialize()

	self._useLang = self._langStorage[var_0_0]
end

function var_0_4:_doSerialize()
	g.core.common.Storage:save("multilingual.json", self._langStorage, false)
end

function var_0_4:_doDeserialize()
	local var_19_0 = g.core.common.Storage:load("multilingual.json", false)
	local var_19_1 = false

	if var_19_0 == nil then
		var_19_0 = {
			[var_0_0] = self._defaultLang
		}
		var_19_1 = true
	end

	for iter_19_0, iter_19_1 in pairs(self._langChangeArr) do
		if var_19_0[iter_19_1] == nil then
			local var_19_2 = {}

			var_19_0[iter_19_1] = var_19_2

			if iter_19_1 == self._defaultLang then
				var_19_2[var_0_1] = config.LANG_VERSION_NO or 101
			end

			var_19_2[var_0_2] = 0
			var_19_2[var_0_3] = 0
			var_19_1 = true
		end
	end

	self._langStorage = var_19_0

	if var_19_1 then
		self:_doSerialize()
	end
end

return var_0_4
