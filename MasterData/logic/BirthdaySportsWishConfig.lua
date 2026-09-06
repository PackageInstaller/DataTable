-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaysportswish/config/BirthdaySportsWishConfig.lua

module("logic.extensions.birthdaysportswish.config.BirthdaySportsWishConfig", package.seeall)

local BirthdaySportsWishConfig = class("BirthdaySportsWishConfig", BaseConfig)

function BirthdaySportsWishConfig:onInit()
	BirthdaySportsWishConfig.super.onInit(self)
end

function BirthdaySportsWishConfig:getNames()
	return {
		"birthday_sports_wishes_buff",
		"birthday_sports_wishes_jumpto",
		"birthday_sports_wishes_tab"
	}
end

function BirthdaySportsWishConfig:handleConfig(name, content)
	if name == "birthday_sports_wishes_buff" then
		self._birthday_sports_wishes_buff = content
	elseif name == "birthday_sports_wishes_jumpto" then
		self._birthday_sports_wishes_jumpto = content
	elseif name == "birthday_sports_wishes_tab" then
		self._birthday_sports_wishes_tab = content
	end
end

function BirthdaySportsWishConfig:getTabCfgs(actId)
	local actCfg = self:getBuffCfgsByActId(actId)

	return actCfg and self._birthday_sports_wishes_tab[actCfg.hudPlanId]
end

function BirthdaySportsWishConfig:getBuffCfgsByActId(actId)
	return self._birthday_sports_wishes_buff[actId]
end

function BirthdaySportsWishConfig:getJumpToCfgs(actId)
	local actCfg = self:getBuffCfgsByActId(actId)

	return actCfg and self._birthday_sports_wishes_jumpto[actCfg.buffJumpPlanId]
end

BirthdaySportsWishConfig.instance = BirthdaySportsWishConfig.New()

return BirthdaySportsWishConfig
