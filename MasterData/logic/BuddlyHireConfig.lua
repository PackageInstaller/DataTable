-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyhire/config/BuddlyHireConfig.lua

module("logic.extensions.buddyhire.config.BuddlyHireConfig", package.seeall)

local BuddlyHireConfig = class("BuddlyHireConfig", BaseConfig)

function BuddlyHireConfig:onInit()
	BuddlyHireConfig.super.onInit(self)
end

function BuddlyHireConfig:getNames()
	return {
		"buddy_pet_lease_common"
	}
end

function BuddlyHireConfig:handleConfig(name, content)
	if name == "buddy_pet_lease_common" then
		self.buddy_pet_lease_commonCfg = content
	end
end

function BuddlyHireConfig:getValueByKey(key)
	if self.buddy_pet_lease_commonCfg[key] then
		return self.buddy_pet_lease_commonCfg[key].value
	end
end

BuddlyHireConfig.instance = BuddlyHireConfig.New()

return BuddlyHireConfig
