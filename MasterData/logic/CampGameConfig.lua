-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/config/CampGameConfig.lua

module("logic.extensions.funcamp.config.CampGameConfig", package.seeall)

local CampGameConfig = class("CampGameConfig", BaseConfig)

function CampGameConfig:onInit()
	CampGameConfig.super.onInit(self)

	self.camp_game_season = nil
	self.camp_game_level = nil
	self.camp_game_system_pet = nil
	self.camp_game_level_prize = nil
	self.camp_game_rank_prize = nil
	self.camp_game_common = nil
	self.camp_game_buy = nil
	self.camp_game_help = nil
end

function CampGameConfig:getNames()
	return {
		"camp_game_season",
		"camp_game_level",
		"camp_game_system_pet",
		"camp_game_level_prize",
		"camp_game_rank_prize",
		"camp_game_common",
		"camp_game_buy",
		"camp_game_help",
		"camp_battle_group",
		"camp_battle_rank_prize",
		"camp_battle_final_prize",
		"camp_battle_activity",
		"camp_battle_params"
	}
end

function CampGameConfig:handleConfig(name, content)
	if name == "camp_game_season" then
		self.camp_game_season = content
	elseif name == "camp_game_level" then
		self.camp_game_level = content
	elseif name == "camp_game_system_pet" then
		self.camp_game_system_pet = content
	elseif name == "camp_game_level_prize" then
		self.camp_game_level_prize = content
	elseif name == "camp_game_rank_prize" then
		self.camp_game_rank_prize = content
	elseif name == "camp_game_common" then
		self.camp_game_common = content
	elseif name == "camp_game_buy" then
		self.camp_game_buy = content
	elseif name == "camp_game_help" then
		self.camp_game_help = content
	elseif name == "camp_battle_group" then
		self._camp_battle_group = content
	elseif name == "camp_battle_rank_prize" then
		self._camp_battle_rank_prize = content
	elseif name == "camp_battle_final_prize" then
		self._camp_battle_final_prize = content
	elseif name == "camp_battle_activity" then
		self._camp_battle_activity = content
	elseif name == "camp_battle_params" then
		self._camp_battle_params = content
	end
end

function CampGameConfig:getSeasonCfg(id)
	return self.camp_game_season[id]
end

function CampGameConfig:getLevelCfg(level)
	return self.camp_game_level[level]
end

function CampGameConfig:getLevelCfgs()
	return self.camp_game_level.dataList
end

function CampGameConfig:getLevelCfgByScore(score)
	score = checknumber(score)

	if score < 0 then
		score = 0
	end

	local count = #self.camp_game_level.dataList

	for i = count, 1, -1 do
		local cfg = self.camp_game_level.dataList[i]

		if score >= cfg.baseScore then
			return cfg
		end
	end

	return self.camp_game_level.dataList[1]
end

function CampGameConfig:getSystemPetCfg(creepsId)
	return self.camp_game_system_pet[creepsId]
end

function CampGameConfig:getHelpPetCfg(creepsId)
	local list = self.camp_game_help.dataList

	for k, v in pairs(list) do
		if v.creepsId == creepsId then
			return v
		end
	end
end

function CampGameConfig:getLevelPrizeCfg(seasonId, level)
	if self.camp_game_level_prize[seasonId] then
		return self.camp_game_level_prize[seasonId][level]
	end

	return nil
end

function CampGameConfig:getLevelPrizeCfgs(seasonId)
	local result = TableUtil.toList(self.camp_game_level_prize[seasonId] or {})

	table.sort(result, function(a, b)
		return a.level < b.level
	end)

	return result
end

function CampGameConfig:getRankPrizeCfg(seasonId, rightTop)
	if self.camp_game_rank_prize[seasonId] then
		return self.camp_game_rank_prize[seasonId][rightTop]
	end

	return nil
end

function CampGameConfig:getRankPrizeCfgs(seasonId)
	local result = TableUtil.toList(self.camp_game_rank_prize[seasonId])

	table.sort(result, function(a, b)
		return a.rightTop < b.rightTop
	end)

	return result
end

function CampGameConfig:getCommonValueByKey(key)
	if self.camp_game_common[key] then
		return self.camp_game_common[key].value
	end

	return nil
end

function CampGameConfig:getOpenActivityId()
	if self._camp_battle_activity == nil then
		return self:actTime(-1)
	end

	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.FUN_CAMP_BATTLE)

	if cfgs == nil then
		return self:actTime(-2)
	end

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			return item.activityId
		end
	end

	return self:actTime(-3)
end

function CampGameConfig:getBattleGroup()
	local actId = self:getOpenActivityId()
	local actCfg = self._camp_battle_activity[actId]
	local groupId = actCfg.groupId

	return self._camp_battle_group[groupId]
end

function CampGameConfig:getRankRewardList()
	local actId = self:getOpenActivityId()
	local actCfg = self._camp_battle_activity[actId]
	local rankPrizePlanId = actCfg.rankPrizePlanId

	return self._camp_battle_rank_prize[rankPrizePlanId]
end

function CampGameConfig:getFinalPrize()
	local actId = self:getOpenActivityId()
	local actCfg = self._camp_battle_activity[actId]
	local finalPrizePlanId = actCfg.finalPrizePlanId

	return self._camp_battle_final_prize[finalPrizePlanId]
end

function CampGameConfig:getParams(key)
	if self._camp_battle_params[key] then
		return self._camp_battle_params[key].value
	end

	return ""
end

function CampGameConfig:actTime(key)
	print("lbc=======趣味阵营战活动(-1:没有拿到活动表，表可能为空；-2:y运营-活动时间(改)这个表有问题，没有对应的活动类型；-3:没有在活动时间)     活动id:", key)

	return key
end

function CampGameConfig:getGameBuyCfg(buyPlanId, buyNum)
	local list = self.camp_game_buy[buyPlanId]

	if list and #list > 0 then
		local cfg = list[#list]

		for i, v in ipairs(list) do
			if v.buyNum == buyNum then
				cfg = v

				break
			end
		end

		return cfg
	else
		return nil
	end
end

CampGameConfig.instance = CampGameConfig.New()

return CampGameConfig
