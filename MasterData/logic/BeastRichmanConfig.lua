-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/config/BeastRichmanConfig.lua

module("logic.extensions.beastrichman.config.BeastRichmanConfig", package.seeall)

local BeastRichmanConfig = class("BeastRichmanConfig", BaseConfig)

function BeastRichmanConfig:onInit()
	return
end

function BeastRichmanConfig:getNames()
	return {
		"beast_rich_man_activity",
		"beast_rich_man_dice",
		"beast_rich_man_zone",
		"beast_rich_man_grid",
		"beast_rich_man_grid_tornado",
		"beast_rich_man_grid_game",
		"beast_rich_man_grid_game_type",
		"beast_rich_man_grid_game_prize",
		"beast_rich_man_story",
		"beast_rich_man_grid_story",
		"beast_rich_man_grid_story_end",
		"beast_rich_man_event",
		"beast_rich_man_event_desc",
		"beast_rich_man_event_shop",
		"beast_rich_man_event_lottery",
		"beast_rich_man_event_lottery_prize",
		"beast_rich_man_event_lottery_extra",
		"beast_rich_man_event_bank",
		"beast_rich_man_event_building",
		"beast_rich_man_beast_boss",
		"beast_rich_man_beast_boss_damage",
		"beast_rich_man_beast_collect_show",
		"beast_rich_man_beast_prize",
		"beast_rich_man_beast_stage",
		"beast_rich_man_total_rank_prize",
		"beast_rich_man_sub_rank_prize",
		"beast_rich_man_card",
		"beast_rich_man_monster",
		"beast_rich_man_creeps",
		"beast_rich_man_rank_view",
		"beast_rich_man_event_grid",
		"beast_rich_man_boss_grid",
		"beast_rich_man_game_rule"
	}
end

function BeastRichmanConfig:handleConfig(name, content)
	if name == "beast_rich_man_activity" then
		self._beast_rich_man_activity = content
	elseif name == "beast_rich_man_dice" then
		self._beast_rich_man_dice = content
	elseif name == "beast_rich_man_zone" then
		self._beast_rich_man_zone = content
	elseif name == "beast_rich_man_grid" then
		self._beast_rich_man_grid = content

		self:_handleGrid2EventUniqueId(content)
	elseif name == "beast_rich_man_grid_tornado" then
		self._beast_rich_man_grid_tornado = content
	elseif name == "beast_rich_man_grid_game" then
		self._beast_rich_man_grid_game = content
	elseif name == "beast_rich_man_grid_game_type" then
		self._beast_rich_man_grid_game_type = content
	elseif name == "beast_rich_man_grid_game_prize" then
		self._beast_rich_man_grid_game_prize = content
	elseif name == "beast_rich_man_story" then
		self._beast_rich_man_story = content
	elseif name == "beast_rich_man_grid_story" then
		self._beast_rich_man_grid_story = content
	elseif name == "beast_rich_man_grid_story_end" then
		self._beast_rich_man_grid_story_end = content
	elseif name == "beast_rich_man_event" then
		self._beast_rich_man_event = content
	elseif name == "beast_rich_man_event_desc" then
		self._beast_rich_man_event_desc = content
	elseif name == "beast_rich_man_event_shop" then
		self:_sortShopById(content.dataList)

		self._beast_rich_man_event_shop = content
	elseif name == "beast_rich_man_event_lottery" then
		self._beast_rich_man_event_lottery = content
	elseif name == "beast_rich_man_event_lottery_prize" then
		self._beast_rich_man_event_lottery_prize = content
	elseif name == "beast_rich_man_event_lottery_extra" then
		self._beast_rich_man_event_lottery_extra = content
	elseif name == "beast_rich_man_event_bank" then
		self._beast_rich_man_event_bank = content
	elseif name == "beast_rich_man_event_building" then
		self._beast_rich_man_event_building = content
	elseif name == "beast_rich_man_beast_boss" then
		self._beast_rich_man_beast_boss = content
	elseif name == "beast_rich_man_beast_boss_damage" then
		self._beast_rich_man_beast_boss_damage = content
	elseif name == "beast_rich_man_beast_stage" then
		self._beast_rich_man_beast_stage = content
	elseif name == "beast_rich_man_total_rank_prize" then
		self._beast_rich_man_total_rank_prize = content
	elseif name == "beast_rich_man_sub_rank_prize" then
		self._beast_rich_man_sub_rank_prize = content
	elseif name == "beast_rich_man_card" then
		self._beast_rich_man_card = content
	elseif name == "beast_rich_man_monster" then
		self._beast_rich_man_monster = content
	elseif name == "beast_rich_man_creeps" then
		self._beast_rich_man_creeps = content
	elseif name == "beast_rich_man_rank_view" then
		self._beast_rich_man_rank_view = content
	elseif name == "beast_rich_man_event_grid" then
		self._beast_rich_man_event_grid = content
	elseif name == "beast_rich_man_boss_grid" then
		self._beast_rich_man_boss_grid = content
	elseif name == "beast_rich_man_beast_prize" then
		self._beast_rich_man_beast_prize = content
	elseif name == "beast_rich_man_beast_collect_show" then
		self._beast_rich_man_beast_collect_show = content
	elseif name == "beast_rich_man_game_rule" then
		self._beast_rich_man_game_rule = content
	end
end

function BeastRichmanConfig:getActCfg(activityId)
	return self._beast_rich_man_activity[activityId]
end

function BeastRichmanConfig:getZoneCfgs(activityId)
	return self._beast_rich_man_zone[activityId]
end

function BeastRichmanConfig:getEventCfgById(activityId, id)
	return (self._beast_rich_man_event[activityId] or nil) and (self._beast_rich_man_event[activityId][id] or {})
end

function BeastRichmanConfig:getEventDescCfgByType(activityId, type)
	return (self._beast_rich_man_event_desc[activityId] or nil) and (self._beast_rich_man_event_desc[activityId][type] or {})
end

function BeastRichmanConfig:getDiceCfgs(activityId)
	return (self._beast_rich_man_dice[activityId] or nil) and (self._beast_rich_man_dice[activityId] or {})
end

function BeastRichmanConfig:getDiceCfgByType(activityId, diceType)
	return (self._beast_rich_man_dice[activityId] or nil) and (self._beast_rich_man_dice[activityId][diceType] or {})
end

function BeastRichmanConfig:getStoryCfgById(activityId, storyId)
	return (self._beast_rich_man_story[activityId] or nil) and (self._beast_rich_man_story[activityId][storyId] or {})
end

function BeastRichmanConfig:getGridCfgs(activityId, zoneId)
	return self._beast_rich_man_grid[activityId][zoneId]
end

function BeastRichmanConfig:getGridCfgById(activityId, zoneId, gridId)
	return (self._beast_rich_man_grid[activityId] or nil) and (self._beast_rich_man_grid[activityId][zoneId][gridId] or {})
end

function BeastRichmanConfig:getGridStoryCfgsById(activityId, storyId)
	return (self._beast_rich_man_grid_story[activityId] or nil) and (self._beast_rich_man_grid_story[activityId][storyId] or {})
end

function BeastRichmanConfig:getGridStoryCfgsBySelectionId(activityId, storyId, selectionId)
	return (self._beast_rich_man_grid_story[activityId] or nil) and (self._beast_rich_man_grid_story[activityId][storyId][selectionId] or {})
end

function BeastRichmanConfig:getGridStoryEndCfgsById(activityId, dialogueId)
	return self._beast_rich_man_grid_story_end[activityId] and self._beast_rich_man_grid_story_end[activityId][dialogueId]
end

function BeastRichmanConfig:getZoneCfgById(activityId, zoneId)
	return (self._beast_rich_man_zone[activityId] or nil) and (self._beast_rich_man_zone[activityId][zoneId] or {})
end

function BeastRichmanConfig:getGridGameCfgById(activityId, id)
	return (self._beast_rich_man_grid_game[activityId] or nil) and (self._beast_rich_man_grid_game[activityId][id] or {})
end

function BeastRichmanConfig:getGridGameTypeCfgById(activityId, id)
	return (self._beast_rich_man_grid_game_type[activityId] or nil) and (self._beast_rich_man_grid_game_type[activityId][id] or {})
end

function BeastRichmanConfig:getGridGamePrizeCfgsById(activityId, id)
	return (self._beast_rich_man_grid_game_prize[activityId] or nil) and (self._beast_rich_man_grid_game_prize[activityId][id] or {})
end

function BeastRichmanConfig:getLotteryCfgsById(activityId, id)
	return (self._beast_rich_man_event_lottery[activityId] or nil) and (self._beast_rich_man_event_lottery[activityId][id] or {})
end

function BeastRichmanConfig:getLotteryPrizeCfgsById(activityId, id)
	return (self._beast_rich_man_event_lottery_prize[activityId] or nil) and (self._beast_rich_man_event_lottery_prize[activityId][id] or {})
end

function BeastRichmanConfig:getLotteryPrizeCfgsByRound(activityId, id, round)
	local prizeCfgs = self:getLotteryPrizeCfgsById(activityId, id)

	return (prizeCfgs[round] or nil) and (prizeCfgs[round] or {})
end

function BeastRichmanConfig:getLotteryPrizeCfgsByPrizeId(activityId, id, round, prizeId)
	local prizeCfgs = self:getLotteryPrizeCfgsByRound(activityId, id, round)

	return (prizeCfgs[prizeId] or nil) and (prizeCfgs[prizeId] or {})
end

function BeastRichmanConfig:getLotteryExtraCfgs(activityId)
	return (self._beast_rich_man_event_lottery_extra[activityId] or nil) and (self._beast_rich_man_event_lottery_extra[activityId] or {})
end

function BeastRichmanConfig:getLotteryExtraCfgById(activityId, wheelId)
	return self._beast_rich_man_event_lottery_extra[activityId] and self._beast_rich_man_event_lottery_extra[activityId][wheelId]
end

function BeastRichmanConfig:getEventBankCfgById(activityId, id)
	return (self._beast_rich_man_event_bank[activityId] or nil) and (self._beast_rich_man_event_bank[activityId][id] or {})
end

function BeastRichmanConfig:getEventBuildShowCfgsById(activityId, id)
	return (self._beast_rich_man_event_building[activityId] or nil) and (self._beast_rich_man_event_building[activityId][id] or {})
end

function BeastRichmanConfig:getIpairsEventBuildShowCfgsById(activityId, id)
	local list = {}

	for i, v in ipairs(self._beast_rich_man_event_building.dataList) do
		if v.activityId == activityId and v.id == id then
			table.insert(list, v)
		end
	end

	return list
end

function BeastRichmanConfig:getEventBuildShowCfgByLv(activityId, id, lv)
	local buildIdCfgs = self._beast_rich_man_event_building[activityId]

	if buildIdCfgs then
		if not buildIdCfgs[id] then
			local buildLvCfgs = {}

			return (buildLvCfgs[lv] or nil) and (buildLvCfgs[lv] or {})
		end
	end
end

function BeastRichmanConfig:getBankBenefitDesc(activityId, id)
	local bankCfg = self:getEventBankCfgById(activityId, id)
	local benfitWeight = bankCfg.benfitWeight

	if not string.nilorempty(benfitWeight) then
		local weightArr = string.split(benfitWeight, "_")
		local minBenefit = math.huge
		local maxBenefit = 0

		for i, weightStr in ipairs(weightArr) do
			local weightArr = string.split(weightStr, ",")

			maxBenefit = math.max(maxBenefit, checknumber(weightArr[1]))
			minBenefit = math.min(minBenefit, checknumber(weightArr[1]))
		end

		return (string.format("%s%%~%s%%", minBenefit, maxBenefit))
	end
end

function BeastRichmanConfig:_sortShopById(dataList)
	self._shopDic = {}

	for i, cfg in ipairs(dataList) do
		self._shopDic[cfg.activityId] = self._shopDic[cfg.activityId] or {}

		local shopDic = self._shopDic[cfg.activityId]

		shopDic[cfg.shopId] = shopDic[cfg.shopId] or {}

		local shopList = shopDic[cfg.shopId]

		table.insert(shopList, cfg)
	end
end

function BeastRichmanConfig:getShopCfgsById(activityId, shopId)
	local shopDic = self._shopDic[activityId]

	return (shopDic or nil) and (shopDic[shopId] or {})
end

function BeastRichmanConfig:getShopCfgById(activityId, shopId, id)
	for i, v in ipairs(self._shopDic[activityId][shopId]) do
		if v.id == id then
			return v
		end
	end
end

function BeastRichmanConfig:getShopCfgByCreepsId(activityId, shopId, creepsId)
	for i, v in ipairs(self._shopDic[activityId][shopId]) do
		if v.creepsId == creepsId then
			return v
		end
	end
end

function BeastRichmanConfig:getRankViewCfgs(activityId)
	return self._beast_rich_man_rank_view[activityId]
end

function BeastRichmanConfig:getRankViewCfg(activityId, tabId)
	return self._beast_rich_man_rank_view[activityId][tabId]
end

function BeastRichmanConfig:getRankRewardStrList(rank, activityId, tabType)
	if tabType == BeastRichManEnum.RankTabType.Total then
		for i, v in pairs(self._beast_rich_man_total_rank_prize[activityId]) do
			if rank >= i[1] and rank <= i[2] then
				return string.split(v.prize, "#")
			end
		end
	elseif tabType == BeastRichManEnum.RankTabType.Score then
		for i, v in pairs(self._beast_rich_man_sub_rank_prize[activityId]) do
			if rank >= i[1] and rank <= i[2] then
				return string.split(v.prize, "#")
			end
		end
	elseif tabType == BeastRichManEnum.RankTabType.Sub then
		for i, v in pairs(self._beast_rich_man_sub_rank_prize[activityId]) do
			if rank >= i[1] and rank <= i[2] then
				return string.split(v.prize, "#")
			end
		end
	end

	return {}
end

function BeastRichmanConfig:getBossCfgById(activityId, bossId)
	return self._beast_rich_man_beast_boss[activityId][bossId]
end

function BeastRichmanConfig:getBossCfgs(activityId)
	return self._beast_rich_man_beast_boss[activityId]
end

function BeastRichmanConfig:getMasterCfg(creepsMasterId)
	return self._beast_rich_man_monster[creepsMasterId]
end

function BeastRichmanConfig:getCreepsCfgs(creepsMasterId)
	return self._beast_rich_man_creeps[creepsMasterId]
end

function BeastRichmanConfig:getGridCfg(activityId, zoneId, gridId)
	return self._beast_rich_man_grid[activityId][zoneId][gridId]
end

function BeastRichmanConfig:getBossDamagePrizeCfgs(activityId, bossId)
	return self._beast_rich_man_beast_boss_damage[activityId][bossId]
end

function BeastRichmanConfig:getRuleCfg(ruleId)
	return self._beast_rich_man_game_rule[ruleId]
end

function BeastRichmanConfig:getBossDamagePrizeIdByDamage(activityId, bossId, damage)
	damage = checknumber(damage)

	local cfgs = self._beast_rich_man_beast_boss_damage[activityId][bossId]

	for i = #cfgs, 1, -1 do
		if damage >= checknumber(cfgs[i].damage) then
			return cfgs[i].prizeId
		end
	end

	return -1
end

function BeastRichmanConfig:getBossRankScoreByDamage(activityId, bossId, damage)
	damage = checknumber(damage)

	local cfgs = self._beast_rich_man_beast_boss_damage[activityId][bossId]

	for i = #cfgs, 1, -1 do
		if damage >= checknumber(cfgs[i].damage) then
			return cfgs[i].rankScore
		end
	end

	return 0
end

function BeastRichmanConfig:getBreamRankScoreByDamage(activityId, bossId, stageId)
	local cfg = self:getBeakStageCfg(activityId, bossId, stageId)

	if cfg then
		return cfg.rankScore
	end

	return 0
end

function BeastRichmanConfig:getBossIsCollect(activityId, bossId, damage)
	damage = checknumber(damage)

	local cfgs = self._beast_rich_man_beast_boss_damage[activityId][bossId]

	for i = #cfgs, 1, -1 do
		if damage >= checknumber(cfgs[i].damage) then
			return cfgs[i].fnishBossActivity
		end
	end

	return false
end

function BeastRichmanConfig:getBossDamageHangingPrizeByDamage(activityId, bossId, damage)
	damage = checknumber(damage)

	local cfgs = self._beast_rich_man_beast_boss_damage[activityId][bossId]

	for i = #cfgs, 1, -1 do
		if damage >= checknumber(cfgs[i].damage) then
			return cfgs[i].hanging
		end
	end

	return 0
end

function BeastRichmanConfig:getStageBossHangingPrizeByStageId(activityId, bossId, stageId)
	local cfg = self:getBeakStageCfg(activityId, bossId, stageId)

	if cfg then
		return cfg.hanging
	end

	return 0
end

function BeastRichmanConfig:getBeakStageCfgs(activityId, bossId)
	return self._beast_rich_man_beast_stage[activityId][bossId]
end

function BeastRichmanConfig:getBeakStageCfg(activityId, bossId, stageId)
	return self._beast_rich_man_beast_stage[activityId][bossId][stageId]
end

function BeastRichmanConfig:getIsStageBossCollect(activityId, bossId, stageId)
	for i = 1, stageId do
		local stageCfg = self:getBeakStageCfg(activityId, bossId, i)

		if stageCfg and stageCfg.fnishBossActivity == true then
			return true
		end
	end

	return false
end

function BeastRichmanConfig:getCardCfgs(activityId)
	return (self._beast_rich_man_card[activityId] or nil) and (self._beast_rich_man_card[activityId] or {})
end

function BeastRichmanConfig:getCardCfg(activityId, cardId)
	return self._beast_rich_man_card[activityId][cardId]
end

function BeastRichmanConfig:getEventParam(activityId, zoneId, gridId)
	local gridCfg = self:getGridCfg(activityId, zoneId, gridId)
	local eventId = gridCfg.eventId
	local eventCfg = self:getEventCfgById(activityId, eventId)

	if eventCfg then
		return eventCfg.eventParam
	end
end

function BeastRichmanConfig:getGridIdByEventId(activityId, zoneId, eventId)
	for i, v in ipairs(self._beast_rich_man_grid.dataList) do
		if v.eventId == eventId then
			return v.gridId
		end
	end

	return 0
end

function BeastRichmanConfig:getEventGridCfgs(activityId, zoneId)
	return self._beast_rich_man_event_grid[activityId][zoneId]
end

function BeastRichmanConfig:getEventTypeByGridId(activityId, zoneId, gridId)
	local gridCfg = self:getGridCfgById(activityId, zoneId, gridId)
	local eventId = checknumber(gridCfg.eventId)

	if eventId > 0 then
		local eventCfg = self:getEventCfgById(activityId, eventId)

		return eventCfg.eventType
	end
end

function BeastRichmanConfig:getEventGridCfg(activityId, zoneId, uniqueId)
	return self._beast_rich_man_event_grid[activityId][zoneId][uniqueId]
end

function BeastRichmanConfig:eventUniqueId2PathGridId(activityId, zoneId, uniqueId)
	local key = activityId .. "_" .. zoneId .. "_" .. uniqueId

	return self._eventUniqueId2PathGridId[key]
end

function BeastRichmanConfig:_handleGrid2EventUniqueId(content)
	self._eventUniqueId2PathGridId = {}

	for i, v in ipairs(content.dataList) do
		if v.eventId > 0 and v.bindEventUniqueId > 0 then
			local id = v.bindEventUniqueId
			local key = v.activityId .. "_" .. v.zoneId .. "_" .. id

			self._eventUniqueId2PathGridId[key] = v.gridId
		end
	end
end

function BeastRichmanConfig:getBossGridCfg(activityId, zoneId, beastType, bossId)
	return self._beast_rich_man_boss_grid[activityId][zoneId][beastType][bossId]
end

function BeastRichmanConfig:getBossGridCfgs(activityId, zoneId)
	local list = {}

	for i, v in ipairs(self._beast_rich_man_boss_grid.dataList) do
		if v.activityId == activityId and v.zoneId == zoneId then
			table.insert(list, v)
		end
	end

	return list
end

function BeastRichmanConfig:getEventIdByGridId(activityId, zoneId, gridId)
	local gridCfg = self:getGridCfg(activityId, zoneId, gridId)

	return gridCfg.eventId
end

function BeastRichmanConfig:getBeastPrizeCfgs(activityId)
	return self._beast_rich_man_beast_prize[activityId]
end

function BeastRichmanConfig:getBossCycle(activityId)
	local actCfg = self:getActCfg(activityId)

	return (actCfg or nil) and (actCfg.cycle or 0)
end

function BeastRichmanConfig:getBeastCollectShowCfgs(activityId)
	return self._beast_rich_man_beast_collect_show[activityId]
end

function BeastRichmanConfig:getRuleCfgById(activityId, id)
	return
end

function BeastRichmanConfig:getSupportPetCfg(activityId, id)
	return self._beast_rich_man_event_shop[activityId][id]
end

BeastRichmanConfig.instance = BeastRichmanConfig.New()

return BeastRichmanConfig
