local NightMareData = class("NightMareData", require("app.core.model.BaseData"))
local var_0_1 = g.core.config.spacetime_dungeon_chapter_info
local var_0_2 = g.core.config.spacetime_dungeon_reward_info
local var_0_3 = g.core.config.spacetime_dungeon_item_info
local var_0_5 = g.core.config.spacetime_dungeon_message_info

function NightMareData:ctor()
	self:initData()
end

function NightMareData:initData()
	NightMareData.super.ctor(self)

	self._messageLog = {}
	self._spaceTimeId = {}
	self._latestChapterId = 0
	self._chapterId = 0
	self._hasTriggerEvents = {}
	self._hasPassItemIds = {}
	self._triggerEventGrid = {}
	self._lineUpHps = {}
	self._qualityPowers = {}
	self._needDealBattleData = nil
	self._initData = {}
	self._dungeonProgress = {}
	self._hpList = {}
	self._monstersHplist = {}
	self._revivePos = {}

	self:initQualityPowers()
end

function NightMareData:initQualityPowers()
	for iter_3_0, iter_3_1 in var_0_3.ipairs() do
		self._qualityPowers[iter_3_1.quality] = self._qualityPowers[iter_3_1.quality] or {}

		table.insert(self._qualityPowers[iter_3_1.quality], iter_3_1.id)
	end
end

function NightMareData:reset()
	self._hasTriggerEvents = {}
	self._hasPassItemIds = {}
end

function NightMareData:checkNMChapterIsOpen(arg_5_1)
	local var_5_0 = var_0_1.get(arg_5_1)
	local var_5_1 = ""

	if var_5_0 then
		local var_5_2 = var_5_0.if_show == 1
		local var_5_3 = g.core.model.User.dungeonData:getLastPassedChapter()
		local var_5_4 = 0
		local var_5_5, var_5_6

		if arg_5_1 > 1 then
			var_5_4 = self:getCurRewardNum(arg_5_1 - 1)
			var_5_1 = var_0_1.get(arg_5_1 - 1).name
			var_5_5 = var_5_0.pre_reward_num <= var_5_4
			var_5_6 = {
				isShowOpen = var_5_2,
				isOpen = var_5_0.dungeon_chapter_open <= var_5_3 and var_5_5 and var_5_2,
				openCondition1 = var_5_0.dungeon_chapter_open <= var_5_3,
				openCondition2 = var_5_0.pre_reward_num <= var_5_4,
				preName = var_5_1,
				openChapter = var_5_0.dungeon_chapter_open
			}
		end

		var_5_6.progressNum = math.ceil(var_5_0.pre_reward_num / self:getTotalRewardNum(var_5_0.reward_team) * 100)

		return var_5_6
	end
end

function NightMareData:checkFirstChapter()
	return self:getCurRewardNum(1) < 1 and g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.NIGHTMARE_DUNGEON)
end

function NightMareData:checkIsTipsNewChapter()
	if not g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.NIGHTMARE_DUNGEON) then
		return false
	end

	local var_7_0 = g.core.model.User.dungeonData:getLastPassedChapter()
	local var_7_1 = var_0_1.fetch(self:getLatestOpenChapterId() + 1)

	if var_7_1 then
		if var_7_0 < var_7_1.dungeon_chapter_open and var_7_1.dungeon_chapter_open - var_7_0 < 10 then
			return true, var_7_1.dungeon_chapter_open - var_7_0
		end
	end

	return false
end

function NightMareData:getLatestOpenChapterId()
	for iter_8_0, iter_8_1 in var_0_1.ipairs() do
		if self:checkNMChapterIsOpen(iter_8_1.id).isOpen then
			self._latestChapterId = iter_8_1.id
		end
	end

	return self._latestChapterId
end

function NightMareData:saveEnterData(arg_9_1)
	local var_9_0 = g.core.common.Storage:load("night_mare_enter.json") or {}

	var_9_0[arg_9_1] = true

	g.core.common.Storage:save("night_mare_enter.json", var_9_0)
end

function NightMareData:checkIsEnterByChapterId(arg_10_1)
	return (g.core.common.Storage:load("night_mare_enter.json") or {})[arg_10_1]
end

function NightMareData:setDungeonProgress(arg_11_1)
	if arg_11_1.progress then
		self._dungeonProgress = arg_11_1.progress
	end
end

function NightMareData:updataDungeonProgress(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(self._dungeonProgress) do
		if iter_12_1.chapterId == self._chapterId then
			if iter_12_1.awards then
				for iter_12_2, iter_12_3 in ipairs(iter_12_1.awards) do
					if iter_12_3 == arg_12_1 then
						return
					end
				end

				table.insert(iter_12_1.awards, arg_12_1)
			else
				iter_12_1.awards = {
					arg_12_1
				}
			end

			return
		end
	end

	table.insert(self._dungeonProgress, {
		chapterId = self._chapterId,
		awards = {
			arg_12_1
		}
	})
end

function NightMareData:setSpaceTimeId(arg_13_1)
	if arg_13_1.item_ids then
		self._spaceTimeId = arg_13_1.item_ids

		table.sort(self._spaceTimeId, function(arg_14_0, arg_14_1)
			return var_0_3.get(arg_14_0).quality > var_0_3.get(arg_14_1).quality
		end)
	else
		self._spaceTimeId = {}
	end
end

function NightMareData:getDungeonProgress()
	return self._dungeonProgress
end

function NightMareData:getCurRewardNum(arg_16_1, arg_16_2)
	local var_16_0 = {}
	local var_16_1 = 0

	for iter_16_0, iter_16_1 in pairs(self._dungeonProgress) do
		if iter_16_1.chapterId == arg_16_1 and iter_16_1.awards then
			var_16_0 = iter_16_1.awards
		end
	end

	if arg_16_2 then
		for iter_16_2, iter_16_3 in ipairs(var_16_0) do
			local var_16_2 = var_0_2.fetch(iter_16_3)

			if var_16_2 and var_16_2.reward_type == arg_16_2 then
				var_16_1 = var_16_1 + 1
			end
		end
	else
		var_16_1 = #var_16_0
	end

	return var_16_1
end

function NightMareData:getTotalRewardNum(arg_17_1, arg_17_2)
	return #(arg_17_2 and var_0_2.match(function(arg_18_0)
		return arg_18_0.team == arg_17_1 and arg_18_0.reward_type == arg_17_2
	end) or var_0_2.match(function(arg_19_0)
		return arg_19_0.team == arg_17_1
	end))
end

function NightMareData:getDropReward(arg_20_1)
	for iter_20_0, iter_20_1 in var_0_2.ipairs() do
		if iter_20_1.team == arg_20_1 and iter_20_1.reward_type == 1 then
			return g.core.common.Drops:getGoodsArray(iter_20_1.reward_value)[1]
		end
	end
end

function NightMareData:isGotReward(arg_21_1, arg_21_2)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in pairs(self._dungeonProgress) do
		if iter_21_1.chapterId == arg_21_1 and iter_21_1.awards then
			var_21_0 = iter_21_1.awards
		end
	end

	for iter_21_2, iter_21_3 in ipairs(var_21_0) do
		if arg_21_2 == iter_21_3 then
			return true
		end
	end

	return false
end

function NightMareData:getAllReward(arg_22_1, arg_22_2)
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in var_0_2.ipairs() do
		if iter_22_1.team == arg_22_1 and iter_22_1.reward_type == 2 then
			local var_22_1 = g.core.common.Drops:getGoodsArray(iter_22_1.reward_value)

			var_22_1[1].rewardId = iter_22_1.id

			if self:isGotReward(arg_22_2, iter_22_1.id) then
				var_22_1[1].isMask = true
				var_22_1[1].showGou = true
			else
				var_22_1[1].isMask = false
				var_22_1[1].showGou = false
			end

			table.insert(var_22_0, var_22_1[1])
		end
	end

	table.sort(var_22_0, function(arg_23_0, arg_23_1)
		if arg_23_0.rewardId ~= arg_23_1.rewardId then
			return arg_23_0.rewardId < arg_23_1.rewardId
		end
	end)

	return var_22_0
end

function NightMareData:getMessageLogList()
	self._messageLog = {}

	for iter_24_0, iter_24_1 in ipairs(self._hasTriggerEvents) do
		local var_24_0 = var_0_5.fetch(self._chapterId, iter_24_1)

		if var_24_0 then
			table.insert(self._messageLog, var_24_0)
		end
	end

	return self._messageLog
end

function NightMareData:getSpaceTimeId()
	return self._spaceTimeId
end

function NightMareData:getSkillDesc(arg_26_1)
	local var_26_0, var_26_1 = g.core.utils.String.formatPassiveSkillDesc(arg_26_1)

	return var_26_0
end

function NightMareData:updateEnterChapterData(arg_27_1)
	self._initData = arg_27_1

	local var_27_0 = arg_27_1.trigger_events or {}
	local var_27_1 = arg_27_1.pass_grids or {}

	self:updateHpList(arg_27_1)
	self:updateMonsterHpList(arg_27_1)
	self:updateHasTriggerEvents(var_27_0)
	self:updatePassItemIds(var_27_1)
end

function NightMareData:updateHpList(arg_28_1)
	self._revivePos = {}

	if arg_28_1 and arg_28_1.hp_list then
		for iter_28_0, iter_28_1 in ipairs(arg_28_1.hp_list) do
			if self._hpList[iter_28_0] == 0 and iter_28_1 > 0 then
				table.insert(self._revivePos, iter_28_0)
			end
		end
	end

	self._hpList = arg_28_1.hp_list
end

function NightMareData:updateMonsterHpList(arg_29_1)
	self._monstersHplist = {}

	if arg_29_1.monsters and next(arg_29_1.monsters) then
		for iter_29_0, iter_29_1 in ipairs(arg_29_1.monsters) do
			self._monstersHplist[iter_29_1.monster_id] = iter_29_1.hp
		end
	end
end

function NightMareData:updateMonsterHp(arg_30_1)
	if arg_30_1.mHp then
		self._monstersHplist[arg_30_1.mHp.monster_id] = arg_30_1.mHp.hp
	end
end

function NightMareData:updatePassItemIds(arg_31_1)
	self._hasPassItemIds = arg_31_1
end

function NightMareData:addTriggerEvent(arg_32_1)
	local var_32_0 = false

	for iter_32_0, iter_32_1 in ipairs(self._hasTriggerEvents) do
		if arg_32_1 == iter_32_1 then
			var_32_0 = true
		end
	end

	if not var_32_0 then
		table.insert(self._hasTriggerEvents, arg_32_1)
	end
end

function NightMareData:updateHasTriggerEvents(arg_33_1)
	self._hasTriggerEvents = arg_33_1
end

function NightMareData:updateLineUpHp(arg_34_1, arg_34_2)
	return
end

function NightMareData:updateCurrentChapterId(arg_35_1)
	self._chapterId = arg_35_1
end

function NightMareData:addNeedDealBattleData(arg_36_1)
	self._needDealBattleData = arg_36_1

	self:updateHpList(arg_36_1)
end

function NightMareData:delNeedDealBattleData()
	self._needDealBattleData = nil
end

function NightMareData:getRevivePos()
	return self._revivePos
end

function NightMareData:getMonsterHp(arg_39_1)
	if self._monstersHplist[arg_39_1] then
		return self._monstersHplist[arg_39_1]
	end

	return {}
end

function NightMareData:getCurHp()
	local var_40_0 = 0

	for iter_40_0, iter_40_1 in ipairs(self._hpList) do
		var_40_0 = var_40_0 + iter_40_1
	end

	return var_40_0
end

function NightMareData:getHpList()
	return self._hpList
end

function NightMareData:getInitData()
	return self._initData
end

function NightMareData:getNeedDealBattleData()
	return self._needDealBattleData
end

function NightMareData:getHasTriggerEvents()
	return self._hasTriggerEvents
end

function NightMareData:getHasPassItemIds()
	return self._hasPassItemIds
end

function NightMareData:getCurrentChapterId()
	return self._chapterId
end

function NightMareData:getLineUpHps()
	return
end

function NightMareData:getRandomItemIdsByQuality(arg_48_1)
	local var_48_1 = {}

	for iter_48_0, iter_48_1 in ipairs(self._qualityPowers[arg_48_1] or {}) do
		table.insert(var_48_1, iter_48_1)
	end

	local var_48_2 = {}

	for iter_48_2 = 1, 3 do
		if #var_48_1 >= 1 then
			local var_48_3 = math.random(1, #var_48_1)

			table.remove(var_48_1, var_48_3)
			table.insert(var_48_2, var_48_1[var_48_3])
		end
	end

	return var_48_2
end

return NightMareData
