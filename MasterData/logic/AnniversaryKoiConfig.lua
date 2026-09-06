-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarykoi/config/AnniversaryKoiConfig.lua

module("logic.extensions.anniversarykoi.config.AnniversaryKoiConfig", package.seeall)

local AnniversaryKoiConfig = class("AnniversaryKoiConfig", BaseConfig)

function AnniversaryKoiConfig:onInit()
	AnniversaryKoiConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function AnniversaryKoiConfig:getNames()
	return {
		"anniversary_koi_activity",
		"anniversary_koi_pool",
		"anniversary_koi_number",
		"anniversary_koi_petnumber"
	}
end

function AnniversaryKoiConfig:handleConfig(name, content)
	if name == "anniversary_koi_activity" then
		self._koiActivityCfg = content
	elseif name == "anniversary_koi_pool" then
		self._koiPoolCfg = content
	elseif name == "anniversary_koi_number" then
		self._koiNumberCfg = content
	elseif name == "anniversary_koi_petnumber" then
		self._koiPetNumberCfg = content
	end
end

function AnniversaryKoiConfig:getKoiActivityCfgById(activityId)
	return self._koiActivityCfg[activityId]
end

function AnniversaryKoiConfig:getKoiPoolCfg(activityId)
	return self._koiPoolCfg[activityId]
end

function AnniversaryKoiConfig:getKoiNumberCfg(id)
	return self._koiNumberCfg[id]
end

function AnniversaryKoiConfig:getKoiPetNumberCfg(activityId)
	return self._koiPetNumberCfg[activityId]
end

AnniversaryKoiConfig.instance = AnniversaryKoiConfig.New()

return AnniversaryKoiConfig
