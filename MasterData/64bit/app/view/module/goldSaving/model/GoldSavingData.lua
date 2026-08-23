local GoldSavingData = class("GoldSavingData")
local var_0_1 = g.core.config.gold_saving_info
local var_0_2 = g.core.config.gold_saving_gift_info
local var_0_3 = g.core.config.function_info
local var_0_4 = g.core.config.gold_saving_game_info
local GoldSavingConst = require("app.view.module.goldSaving.const.GoldSavingConst")

function GoldSavingData:ctor()
	self:initData()
end

function GoldSavingData:initData()
	self._cfgInfo = {}
	self._giftId = 0
	self._progress = 0
	self._preProgress = -1
	self._awards = {}
	self._turnGameDropIndex = {}
	self._totalProgress = 0
	self._canRewardScoreMap = {}
	self._curNewGameId = nil
	self._gameIds = {}
	self._curActId = 0
	self._isModuleUnlock = false

	self:initTurnCardData()
end

function GoldSavingData:updateGoldSavingData(arg_3_1)
	self._isModuleUnlock = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.GOLD_SAVING)
	self._cfgInfo = arg_3_1.info or {}
	self._giftId = arg_3_1.gift_id or 0
	self._progress = arg_3_1.progress or 0

	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.game_datas or {}) do
		table.insert(var_3_0, iter_3_1.id)
	end

	self:setGameIds(var_3_0)
	self:initTotalProgress()

	self._curActId = self._cfgInfo.activity_id
end

function GoldSavingData:updatePay(arg_4_1)
	self._giftId = arg_4_1.next_gift_id or 0
	self._progress = arg_4_1.progress or 0
	self._awards = arg_4_1.awards or {}
end

function GoldSavingData:getProgress()
	return g.core.model.User.resourceData:getResourceById(g.core.common.Goods.RESOURCE.GOLD_SAVING_SCORE)
end

function GoldSavingData:getGiftId()
	return self._giftId
end

function GoldSavingData:getServerCfgInfo()
	return self._cfgInfo
end

function GoldSavingData:getGiftCfg()
	return (var_0_2.get((self:getGiftId())))
end

function GoldSavingData:getTipStr()
	local var_9_0 = var_0_1.get(self._cfgInfo.activity_id)
	local var_9_1 = ""

	if var_9_0.function_1 and var_9_0.function_1 > 0 then
		var_9_1 = var_9_1 .. g.core.lang:get(407903, {
			name = var_0_3.get(var_9_0.function_1).name
		})
	end

	if var_9_0.function_2 and var_9_0.function_2 > 0 then
		var_9_1 = var_9_1 .. g.core.lang:get(407902, {
			name = var_0_3.get(var_9_0.function_2).name
		})
	end

	if var_9_0.function_3 and var_9_0.function_3 > 0 then
		var_9_1 = var_9_1 .. g.core.lang:get(407902, {
			name = var_0_3.get(var_9_0.function_3).name
		})
	end

	return var_9_1
end

function GoldSavingData:getTipCount()
	return var_0_1.get(self._cfgInfo.activity_id).count
end

function GoldSavingData:getMaxProgress()
	local var_11_0 = self:getGiftId()

	if var_11_0 == 0 then
		return
	end

	return var_0_2.get(var_11_0).count_require
end

function GoldSavingData:getAwards()
	local var_12_0 = {}
	local var_12_1 = self:getGiftCfg()

	for iter_12_0 = 1, 2 do
		if var_12_1["reward_" .. iter_12_0 .. "_type"] ~= 0 then
			var_12_0[iter_12_0] = var_12_0[iter_12_0] or {}
			var_12_0[iter_12_0].type = var_12_1["reward_" .. iter_12_0 .. "_type"]
			var_12_0[iter_12_0].value = var_12_1["reward_" .. iter_12_0 .. "_value"]
			var_12_0[iter_12_0].size = var_12_1["reward_" .. iter_12_0 .. "_size"]
		end
	end

	return var_12_0
end

function GoldSavingData:getCurActId()
	return self._curActId
end

function GoldSavingData:updateProgress(arg_14_1)
	if self._giftId == arg_14_1.id and arg_14_1.id ~= 0 then
		self._progress = arg_14_1.status
	end
end

function GoldSavingData:showNewFlag()
	local var_15_0 = self:getMaxProgress()
	local var_15_1 = self:getProgress()

	if self:getGiftId() == 0 then
		return false
	end

	if not (g.core.common.Storage:load("goldSaving.json") or {})[999] then
		-- block empty
	end

	return false
end

function GoldSavingData:setPreProgress(arg_16_1)
	self._preProgress = arg_16_1
end

function GoldSavingData:getPreProgress()
	return self._preProgress
end

function GoldSavingData:isShowEntrance()
	local var_18_0 = self._cfgInfo.start_time or 0
	local var_18_1 = self._cfgInfo.end_time or 0
	local var_18_2 = self._cfgInfo.start_level or 0
	local var_18_3 = self._cfgInfo.end_level or 0
	local var_18_4 = g.core.model.User:getLevel()
	local var_18_5 = g.core.common.ServerTime:getTime()
	local var_18_6 = self:getGiftId()

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.GOLD_SAVING) and var_18_0 > 0 and var_18_0 <= var_18_5 and var_18_5 <= var_18_1 and var_18_2 <= var_18_4 and var_18_4 <= var_18_3 then
		return true
	else
		return false
	end
end

function GoldSavingData:initTotalProgress()
	if self._totalProgress == 0 or self._curActId ~= self._cfgInfo.activity_id then
		self._totalProgress = 0

		for iter_19_0, iter_19_1 in var_0_2.ipairs() do
			if iter_19_1.group == self._cfgInfo.activity_id then
				self._totalProgress = self._totalProgress + iter_19_1.count_require
				self._canRewardScoreMap[iter_19_1.id] = self._totalProgress
			end
		end
	end
end

function GoldSavingData:getCurGifts()
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in var_0_2.ipairs() do
		if iter_20_1.group == self._cfgInfo.activity_id then
			table.insert(var_20_0, iter_20_1)
		end
	end

	return var_20_0
end

function GoldSavingData:getGiftScore(arg_21_1)
	if self._canRewardScoreMap[arg_21_1] then
		return self._canRewardScoreMap[arg_21_1]
	end

	return 0
end

function GoldSavingData:getTotalProgress()
	return self._totalProgress
end

function GoldSavingData:isCanBuyGift(arg_23_1)
	if self._giftId == arg_23_1 and self:getProgress() >= self._canRewardScoreMap[arg_23_1] then
		return true
	end

	return false
end

function GoldSavingData:setGameIds(arg_24_1)
	self._gameIds = arg_24_1
end

function GoldSavingData:isHasGameCanPlay()
	if not self:isShowEntrance() then
		return false
	end

	return #self._gameIds > 0
end

function GoldSavingData:delGameId(arg_26_1)
	for iter_26_0, iter_26_1 in ipairs(self._gameIds) do
		if iter_26_1 == arg_26_1 then
			table.remove(self._gameIds, iter_26_0)

			break
		end
	end
end

function GoldSavingData:addGameId(arg_27_1)
	self._curNewGameId = arg_27_1.game_data.id

	table.insert(self._gameIds, arg_27_1.game_data.id)
end

function GoldSavingData:getAllGameIds()
	return self._gameIds
end

function GoldSavingData:getHasNewGameId()
	if self._curNewGameId and #self._gameIds > 0 then
		self._curNewGameId = nil

		return self._curNewGameId
	end

	return nil
end

function GoldSavingData:getGiftAwards(arg_30_1)
	local var_30_0 = {}
	local var_30_1 = var_0_2.get(arg_30_1)

	for iter_30_0 = 1, 2 do
		if var_30_1["reward_" .. iter_30_0 .. "_type"] ~= 0 then
			var_30_0[iter_30_0] = var_30_0[iter_30_0] or {}
			var_30_0[iter_30_0].type = var_30_1["reward_" .. iter_30_0 .. "_type"]
			var_30_0[iter_30_0].value = var_30_1["reward_" .. iter_30_0 .. "_value"]
			var_30_0[iter_30_0].size = var_30_1["reward_" .. iter_30_0 .. "_size"]
		end
	end

	return var_30_0
end

function GoldSavingData:canGetNewGift()
	if self:getGiftId() == 0 then
		return false
	end

	return self:getProgress() >= self:getGiftScore(self:getGiftId())
end

function GoldSavingData:checkGoldSavingShow()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.GOLD_SAVING) and not self._isModuleUnlock then
		g.core.network.GameNetProxy:send_C2S_GoldSaving_Flush({})
	end
end

function GoldSavingData:setTurnCardGameId(arg_33_1)
	self._gameId = arg_33_1
end

function GoldSavingData:initTurnCardData()
	self._gameId = 1001
	self._rewardId = 0
	self._turnNum = 0
	self._curTurnIndex = 0

	self:_initDropIdDict()

	self._cardSequence = {}
end

function GoldSavingData:_initDropIdDict()
	self._rewardDict = {}

	local var_35_0 = g.core.config.gold_saving_game_info.fetch(self._gameId)

	while g.core.config.gold_saving_game_info.hasKey("parameter_" .. 1) do
		if var_35_0["reward_" .. 1] > 0 then
			self._rewardDict[1] = g.core.common.Drops:getGoodsArray(var_35_0["reward_" .. 1])
		end
	end
end

function GoldSavingData:_createCardSequence()
	self._turnNum = math.random(3, 7)
	self._cardSequence = {}

	local var_36_0 = {
		self._rewardId,
		self._rewardId
	}
	local var_36_1 = 1
	local var_36_2 = 2

	if self._rewardId == 1 then
		var_36_1 = 3
	elseif self._rewardId == 2 then
		var_36_2 = 3
	end

	for iter_36_0 = 1, self._turnNum - 3 do
		table.insert(var_36_0, var_36_1)
	end

	for iter_36_1 = 3, 2 + math.random(math.max(0, self._turnNum - 3 - 2), (math.min(2, self._turnNum - 3))) do
		var_36_0[iter_36_1] = var_36_2
	end

	require("app.core.utils.KsMath").shuffleArray(var_36_0)

	for iter_36_2 = 1, #var_36_0 do
		table.insert(self._cardSequence, var_36_0[iter_36_2])
	end

	self._cardSequence[self._turnNum] = self._rewardId
end

function GoldSavingData:getCardTypeByIndex(arg_37_1)
	return self._cardSequence[arg_37_1]
end

function GoldSavingData:onS2CGoldSavingGameStart(arg_38_1)
	self._rewardId = arg_38_1.params[1]

	self:_createCardSequence()
end

function GoldSavingData:getGameId()
	return self._gameId
end

function GoldSavingData:getCardSequence()
	return self._cardSequence
end

function GoldSavingData:getRewardDict()
	return self._rewardDict
end

function GoldSavingData:getCurCardIndex()
	self._curTurnIndex = self._curTurnIndex + 1

	return self._curTurnIndex
end

function GoldSavingData:isLastCard(arg_43_1)
	return arg_43_1 >= self._turnNum
end

function GoldSavingData:getRewardId()
	return self._rewardId
end

function GoldSavingData:saveGameStartInfo(arg_45_1)
	local var_45_0 = arg_45_1 and arg_45_1.gameId

	if arg_45_1 and arg_45_1.gameId and var_0_4.fetch(var_45_0) and var_0_4.get(var_45_0).type == GoldSavingConst.GAME_TYPE.TURN_TABLE then
		self:saveTurnGameDropIndex(arg_45_1)
	end
end

function GoldSavingData:getTurnGameAwardList(arg_46_1)
	local var_46_0 = {}
	local var_46_1

	if arg_46_1 and var_0_4.fetch(arg_46_1) then
		local var_46_2 = var_0_4.get(arg_46_1)

		var_46_0 = g.core.common.Drops:getGoodsArray(var_46_2.reward_1, false, true)

		if var_46_2.special_reward > 0 then
			local var_46_3 = g.core.common.Drops:getGoodsArray(var_46_2.special_reward, false, true)

			if #var_46_3 > 0 then
				var_46_1 = var_46_3[1]
			end
		end
	end

	return var_46_0, var_46_1
end

function GoldSavingData:saveTurnGameDropIndex(arg_47_1)
	self._turnGameDropIndex = {}

	if arg_47_1 and arg_47_1.params then
		for iter_47_0 = 1, #arg_47_1.params do
			table.insert(self._turnGameDropIndex, arg_47_1.params[iter_47_0] + 1)
		end
	end
end

function GoldSavingData:getTurnGameDropIndex()
	return self._turnGameDropIndex
end

function GoldSavingData:setIgnoreTodayTip(arg_49_1)
	self._isTodayIgnoreTick = arg_49_1

	local var_49_0 = "goldSavingTickData.json"
	local var_49_1 = {}

	var_49_1.time = arg_49_1 and g.core.common.ServerTime:getTime() or 0

	g.core.common.Storage:save(var_49_0, var_49_1, true)
end

function GoldSavingData:isIgnoreTodayTip()
	if not self._loadTodayTick then
		self._loadTodayTick = true
		self._isTodayIgnoreTick = g.core.common.ServerTime:getIsSameDay(tonumber((g.core.common.Storage:load("goldSavingTickData.json", true) or {
			time = 0
		}).time))
	end

	return self._isTodayIgnoreTick
end

return GoldSavingData
