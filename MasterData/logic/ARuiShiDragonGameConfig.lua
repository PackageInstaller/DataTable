-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aruishidragongame/config/ARuiShiDragonGameConfig.lua

module("logic.extensions.aruishidragongame.config.ARuiShiDragonGameConfig", package.seeall)

local ARuiShiDragonGameConfig = class("ARuiShiDragonGameConfig", BaseConfig)

function ARuiShiDragonGameConfig:onInit()
	ARuiShiDragonGameConfig.super.onInit(self)

	self.aruishi_dragon_game_activity = nil
end

function ARuiShiDragonGameConfig:getNames()
	return {
		"aruishi_dragon_game_activity",
		"aruishi_dragon_game_prize",
		"aruishi_dragon_game",
		"aruishi_dragon_game_block",
		"aruishi_dragon_game_type",
		"aruishi_dragon_game_common"
	}
end

function ARuiShiDragonGameConfig:handleConfig(name, content)
	if name == "aruishi_dragon_game_activity" then
		self.aruishi_dragon_game_activity = content
	elseif name == "aruishi_dragon_game_prize" then
		self.aruishi_dragon_game_prize = content
	elseif name == "aruishi_dragon_game" then
		self.aruishi_dragon_game = content
	elseif name == "aruishi_dragon_game_block" then
		self.aruishi_dragon_game_block = content
	elseif name == "aruishi_dragon_game_type" then
		self.aruishi_dragon_game_type = content
	elseif name == "aruishi_dragon_game_common" then
		self.aruishi_dragon_game_common = content
	end
end

function ARuiShiDragonGameConfig:getActivityCfg(activityId)
	return self.aruishi_dragon_game_activity[activityId]
end

function ARuiShiDragonGameConfig:getPrizeList(activityId)
	return self.aruishi_dragon_game_prize[activityId]
end

function ARuiShiDragonGameConfig:getPrizeCfg(activityId, prizeId)
	return self.aruishi_dragon_game_prize[activityId] and self.aruishi_dragon_game_prize[activityId][prizeId]
end

function ARuiShiDragonGameConfig:getGameCfgList(planId)
	return self.aruishi_dragon_game[planId] or {}
end

function ARuiShiDragonGameConfig:getGameCfg(planId, checkId)
	return self.aruishi_dragon_game[planId] and self.aruishi_dragon_game[planId][checkId]
end

function ARuiShiDragonGameConfig:getBlockCfg(challengeId, id)
	return self.aruishi_dragon_game_block[challengeId][id]
end

function ARuiShiDragonGameConfig:getAmClientCommonValue(activityId, key, isToNumber)
	local baseData = self:getActivityCfg(activityId)

	if baseData then
		if not baseData.comPlanId then
			local comPlanId = 0

			if self.aruishi_dragon_game_common[comPlanId] then
				local data = self.aruishi_dragon_game_common[comPlanId][key]
				local value

				if data then
					value = data.value

					if isToNumber then
						value = checknumber(value)
					end
				end

				return value
			end
		end
	end
end

function ARuiShiDragonGameConfig:getTypeCfg(activityId, type)
	if not self.aruishi_dragon_game_type[activityId] then
		return self.aruishi_dragon_game_type[activityId][type]
	end
end

function ARuiShiDragonGameConfig:getGamePlanId(activityId, type)
	local data = self:getTypeCfg(activityId, type)

	return data and data.gridPlanId
end

ARuiShiDragonGameConfig.instance = ARuiShiDragonGameConfig.New()

return ARuiShiDragonGameConfig
