-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/armorherolottery/config/ArmorherolotteryConfig.lua

module("logic.extensions.armorherolottery.config.ArmorherolotteryConfig", package.seeall)

local ArmorherolotteryConfig = class("ArmorherolotteryConfig", BaseConfig)

function ArmorherolotteryConfig:onInit()
	return
end

function ArmorherolotteryConfig:getNames()
	return {
		"armor_hero_lottery_item",
		"armor_hero_lottery_rule",
		"armor_hero_lottery_prize",
		"armor_hero_lottery_activity"
	}
end

function ArmorherolotteryConfig:handleConfig(name, content)
	if name == "armor_hero_lottery_item" then
		self._armor_hero_lottery_item = content
	elseif name == "armor_hero_lottery_rule" then
		self._armor_hero_lottery_rule = content
	elseif name == "armor_hero_lottery_prize" then
		self._armor_hero_lottery_prize = content
	elseif name == "armor_hero_lottery_activity" then
		self._armor_hero_lottery_activity = content
	end
end

function ArmorherolotteryConfig:getPrizeCfgs(activityId)
	return self._armor_hero_lottery_prize[activityId]
end

function ArmorherolotteryConfig:getActCfg(activityId)
	return self._armor_hero_lottery_activity[activityId]
end

function ArmorherolotteryConfig:getItemCfg(activityId, itemId)
	return self._armor_hero_lottery_item[activityId][itemId]
end

function ArmorherolotteryConfig:getRuleCfgs(activityId)
	return self._armor_hero_lottery_rule[activityId]
end

function ArmorherolotteryConfig:getRuleCfg(activityId, ruleId)
	return self._armor_hero_lottery_rule[activityId][ruleId]
end

ArmorherolotteryConfig.instance = ArmorherolotteryConfig.New()

return ArmorherolotteryConfig
