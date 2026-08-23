local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostConsumptionBuild = class("OutpostConsumptionBuild", (require("app.view.module.outpost.model.struct.build.OutpostBuildBaseStruct")))

function OutpostConsumptionBuild:ctor(arg_1_1, arg_1_2)
	self._consumptionLevel = 0
	self._dailyReportInfo = {}
	self._consumptionItemDic = {}
	self._curItems = {}
	self._bonusInfoDic = {}
	self._tempNodeInfo = {}
	self._nodeInfoList = {}
	self._coinBonus = 0
	self._timeBonus = 0
	self._effectBaseTime = g.core.config.outpost_parameter_info.get(var_0_0.ParameterID.CONSUMPTION_BASE_TIME).parameter
	self._knightBaseNum = 1
	self._levelToItemIdDic = {}
	self._itemValueToItemDic = {}

	OutpostConsumptionBuild.super.ctor(self, arg_1_1, arg_1_2)

	local var_1_0 = g.core.model.User.outpostData:getBuildData():getBuild({
		type = var_0_0.BuildType.Exchange
	})

	if var_1_0 and not var_1_0:isLockBuild() then
		self:setConsumptionLevel(var_1_0:getLevel())
	end

	self:_loadDailyReport()
end

function OutpostConsumptionBuild:_initBuild()
	self._tab = g.core.config.outpost_consumption_building_info

	OutpostConsumptionBuild.super._initBuild(self)

	for iter_2_0 = 1, g.core.config.outpost_consumption_item_info.getLength() do
		local var_2_0 = g.core.config.outpost_consumption_item_info.indexOf(iter_2_0)

		if var_2_0.building_type == self._type then
			self._levelToItemIdDic[var_2_0.exchange_level] = var_2_0.id
			self._itemValueToItemDic[var_2_0.item_value] = var_2_0.id
		end
	end
end

function OutpostConsumptionBuild:_onOneCfgGot(arg_3_1)
	if arg_3_1.if_node == 0 and not self._tempNodeInfo.min then
		self._tempNodeInfo.min = arg_3_1.level
	elseif arg_3_1.if_node == 1 then
		self._tempNodeInfo.max = arg_3_1.level
		self._tempNodeInfo.cfg = arg_3_1
		self._tempNodeInfo.cnt = self._tempNodeInfo.max - self._tempNodeInfo.min
		self._nodeInfoList[#self._nodeInfoList + 1] = self._tempNodeInfo
		self._tempNodeInfo = {}
	end
end

function OutpostConsumptionBuild:canAddKnight(arg_4_1)
	local var_4_0, var_4_1 = self:getCostItem(arg_4_1)

	g.core.model.User.outpostData:checkCoinEnough(arg_4_1, var_4_1)

	if not var_4_0 then
		return var_4_1
	end

	return OutpostConsumptionBuild.super.canAddKnight(self, arg_4_1)
end

function OutpostConsumptionBuild:canChangePos()
	return true
end

function OutpostConsumptionBuild:onReceivedLevelChangeNotice(arg_6_1)
	OutpostConsumptionBuild.super.onReceivedLevelChangeNotice(self, arg_6_1)

	if var_0_0.BuildType.Exchange == arg_6_1.type then
		self:setConsumptionLevel(arg_6_1.level)
	end
end

function OutpostConsumptionBuild:setConsumptionLevel(arg_7_1)
	self._consumptionLevel = arg_7_1

	if self._consumptionLevel ~= arg_7_1 then
		self:_updateConsumption()
	end
end

function OutpostConsumptionBuild:_updateByLevel()
	OutpostConsumptionBuild.super._updateByLevel(self)

	self._bonusInfoDic = self:getBonusInfoDicByLevel(self._level)
	self._timeBonus = 0
	self._coinBonus = 0

	for iter_8_0, iter_8_1 in pairs(self._bonusInfoDic) do
		if var_0_0.BONUS_TYPE.COIN_TYPE == iter_8_0 then
			self._coinBonus = self._coinBonus + iter_8_1.value
		elseif var_0_0.BONUS_TYPE.TIME_TYPE == iter_8_0 then
			self._timeBonus = self._timeBonus + iter_8_1.value
		elseif var_0_0.BONUS_TYPE.KNIGHT_NUM == iter_8_0 then
			self._maxKnightCnt = iter_8_1.value + self._knightBaseNum
		end
	end
end

function OutpostConsumptionBuild:_updateConsumption()
	self._consumptionItemDic = {}

	for iter_9_0 = 1, self._consumptionLevel do
		self._consumptionItemDic[iter_9_0] = self:_getConsumptionItem(iter_9_0)
	end
end

function OutpostConsumptionBuild:getBuildInfo()
	return
end

function OutpostConsumptionBuild:addHoldKnightBySid(arg_11_1, arg_11_2)
	OutpostConsumptionBuild.super.addHoldKnightBySid(self, arg_11_1)

	local var_11_0 = g.core.model.User.outpostData:getKnightsData():getKnightBySid(arg_11_1)

	self:setKnightTime(var_11_0, arg_11_2)

	if self:isInBuilding(arg_11_1) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_OUTPOST_KNIGHT_CHECK_IN_BUILD, false, {
			type = self._type,
			info = self._knightSidDic[var_11_0:getServerId()]
		})
	end
end

function OutpostConsumptionBuild:updateBuildBySvr(arg_12_1, arg_12_2)
	OutpostConsumptionBuild.super.updateBuildBySvr(self, arg_12_1, arg_12_2)

	self._curItems = arg_12_1.cur_items or {}
end

function OutpostConsumptionBuild:onEffect(arg_13_1)
	self._judgeValue = self:getJudgeValue(arg_13_1 or {})

	OutpostConsumptionBuild.super.onEffect(self, arg_13_1)

	if arg_13_1.orderInfo then
		self:_sendOrderProcessToSever(arg_13_1.orderInfo)
	elseif arg_13_1.knightId then
		self:_doConsumption(arg_13_1.knightId)
	end
end

function OutpostConsumptionBuild:_doConsumption(arg_14_1)
	if not self:isInBuilding(arg_14_1) then
		return
	end

	local var_14_0 = 0

	for iter_14_0, iter_14_1 in pairs(self._knightSidDic) do
		if iter_14_1.time == var_0_0.BUILD_SP_KNIGHT_TIME.FOREVER then
			var_14_0 = var_14_0 + 1
		end
	end

	local var_14_1 = self:getCostItem(arg_14_1, var_14_0)

	if var_14_1 then
		g.core.network.GameNetProxy:send_C2S_Outpost_Build_Use({
			build_tp = self._type,
			knight_id = arg_14_1,
			target_item_id = var_14_1
		})
	else
		self._knightSidDic[arg_14_1].time = var_0_0.BUILD_SP_KNIGHT_TIME.WAIT_TO_DO
	end
end

function OutpostConsumptionBuild:_sendOrderProcessToSever(arg_15_1)
	g.core.network.GameNetProxy:send_C2S_Outpost_Build_OrderProcess({
		knight_id = 0,
		build_tp = self._type,
		order_tp = var_0_0.EXCHANGE_TYPE.PRODUCE,
		target_id = arg_15_1.itemId,
		target_num = arg_15_1.num
	})
end

function OutpostConsumptionBuild:getEffectTime()
	return self._effectBaseTime - self._timeBonus
end

function OutpostConsumptionBuild:getEffectBaseTimeAndTimeBonus()
	return self._effectBaseTime, self._timeBonus
end

function OutpostConsumptionBuild:getCoinBonus()
	return self._coinBonus
end

function OutpostConsumptionBuild:getBonusInfoDic()
	return self._bonusInfoDic
end

function OutpostConsumptionBuild:getBonusInfoDicByLevel(arg_20_1)
	local var_20_0 = {}

	for iter_20_0 = 1, arg_20_1 do
		self:getOneBonusInfoByLevel(iter_20_0, var_20_0)
	end

	return var_20_0
end

function OutpostConsumptionBuild:getEffectInfoList(arg_21_1)
	arg_21_1 = arg_21_1 or self._level

	local var_21_0 = {}
	local var_21_1 = 0
	local var_21_2 = 0
	local var_21_3 = 0

	if arg_21_1 == self._level then
		var_21_1 = self._coinBonus
		var_21_2 = self._timeBonus
		var_21_3 = self._maxKnightCnt
	elseif arg_21_1 > 0 then
		for iter_21_0, iter_21_1 in pairs((self:getBonusInfoDicByLevel(arg_21_1))) do
			if var_0_0.BONUS_TYPE.COIN_TYPE == iter_21_0 then
				var_21_1 = var_21_1 + iter_21_1.value
			elseif var_0_0.BONUS_TYPE.TIME_TYPE == iter_21_0 then
				var_21_2 = var_21_2 + iter_21_1.value
			elseif var_0_0.BONUS_TYPE.KNIGHT_NUM == iter_21_0 then
				var_21_3 = iter_21_1.value + self._knightBaseNum
			end
		end
	end

	var_21_0[#var_21_0 + 1] = {
		type = var_0_0.BONUS_TYPE.COIN_TYPE,
		value = var_21_1
	}
	var_21_0[#var_21_0 + 1] = {
		type = var_0_0.BONUS_TYPE.TIME_TYPE,
		value = self._effectBaseTime - var_21_2
	}
	var_21_0[#var_21_0 + 1] = {
		type = var_0_0.BONUS_TYPE.KNIGHT_NUM,
		value = var_21_3
	}

	return var_21_0
end

function OutpostConsumptionBuild:getOneBonusInfoByLevel(arg_22_1, arg_22_2)
	arg_22_2 = arg_22_2 or {}

	self:_inputInfoToInfoDic(g.core.config.outpost_consumption_building_info.get(self._levelToIdDic[arg_22_1]), arg_22_2, {
		{
			unexpectedValue = 0,
			key = "bonus_type_",
			toKey = "type"
		},
		{
			unexpectedValue = 0,
			key = "bonus_value_",
			toKey = "value"
		}
	}, g.core.config.outpost_consumption_building_info)

	return arg_22_2
end

function OutpostConsumptionBuild:isNode()
	return self._cfg.if_node == 1
end

function OutpostConsumptionBuild:getAllConsumptionItem()
	local var_24_0 = {}

	for iter_24_0 = self._consumptionLevel, 1, -1 do
		if self._consumptionItemDic[iter_24_0] then
			var_24_0[#var_24_0 + 1] = self._consumptionItemDic[iter_24_0]
			self._consumptionItemDic[iter_24_0].itemInfo.realCoin = self:getCostCoin(self._consumptionItemDic[iter_24_0].cfg.gold)
		end
	end

	return var_24_0
end

function OutpostConsumptionBuild:_getConsumptionItem(arg_25_1)
	if not self._levelToItemIdDic[arg_25_1] then
		return
	end

	local var_25_0 = g.core.config.outpost_consumption_item_info.get(self._levelToItemIdDic[arg_25_1])
	local var_25_1 = {
		costDic = {},
		itemInfo = {
			size = 0,
			realCoin = 0,
			type = var_0_0.EXCHANGE_ITEM_TYPE,
			value = var_25_0.item_value
		},
		cfg = var_25_0
	}

	self:_inputInfoToInfoDic(var_25_0, var_25_1.costDic, {
		{
			unexpectedValue = 0,
			key = "item_cost_value_",
			toKey = "value"
		},
		{
			unexpectedValue = 0,
			key = "item_cost_size_",
			toKey = "size"
		}
	}, g.core.config.outpost_consumption_item_info)

	return var_25_1
end

function OutpostConsumptionBuild:getConsumptionItemByItemId(arg_26_1)
	local var_26_0

	for iter_26_0, iter_26_1 in ipairs(self._curItems) do
		if iter_26_1.item_id == arg_26_1 then
			var_26_0 = iter_26_1

			break
		end
	end

	return var_26_0
end

function OutpostConsumptionBuild:getConsumptionNum(arg_27_1)
	local var_27_1 = self:getConsumptionItemByItemId(arg_27_1)

	return (var_27_1 or nil) and var_27_1.item_num
end

function OutpostConsumptionBuild:getCostItem(arg_28_1, arg_28_2)
	arg_28_2 = arg_28_2 or 1

	local var_28_0
	local var_28_1 = var_0_0.REJECT_IN_BUILD_REASON.ITEM_LIMIT

	for iter_28_0 = self._consumptionLevel, 1, -1 do
		if self._consumptionItemDic[iter_28_0] then
			local var_28_2 = self:getConsumptionNum(self._consumptionItemDic[iter_28_0].itemInfo.value)
			local var_28_3 = true

			if arg_28_1 then
				var_28_3 = self:getCostCoin(self._consumptionItemDic[iter_28_0].cfg.gold * arg_28_2) <= g.core.model.User.outpostData:getKnightsData():getKnightBySid(arg_28_1):getOwnCoinNum()

				if not var_28_3 then
					var_28_1 = var_0_0.REJECT_IN_BUILD_REASON.NOT_COIN
				end
			end

			if arg_28_2 <= var_28_2 and var_28_3 then
				var_28_0 = self._consumptionItemDic[iter_28_0].itemInfo.value
				var_28_1 = var_0_0.REJECT_IN_BUILD_REASON.NONE

				break
			end
		end
	end

	return var_28_0, var_28_1
end

function OutpostConsumptionBuild:onCostItemChanged()
	local var_29_0 = 0

	for iter_29_0 = self._consumptionLevel, 1, -1 do
		if self._consumptionItemDic[iter_29_0] then
			var_29_0 = var_29_0 + self:getConsumptionNum(self._consumptionItemDic[iter_29_0].itemInfo.value)
		end
	end

	if var_29_0 > 0 then
		self:_checkWaitKnight(var_29_0)
	end
end

function OutpostConsumptionBuild:_checkWaitKnight(arg_30_1)
	for iter_30_0, iter_30_1 in pairs(self._knightSidDic) do
		if iter_30_1.time == var_0_0.BUILD_SP_KNIGHT_TIME.WAIT_TO_DO then
			self:_doConsumption(iter_30_1.sid)

			arg_30_1 = arg_30_1 - 1

			if arg_30_1 == 0 then
				break
			end
		end
	end
end

function OutpostConsumptionBuild:getNodeInfo()
	local var_31_0

	for iter_31_0, iter_31_1 in ipairs(self._nodeInfoList) do
		if self._level < iter_31_1.max then
			var_31_0 = iter_31_1

			break
		end
	end

	return var_31_0
end

function OutpostConsumptionBuild:setKnightTime(arg_32_1, arg_32_2)
	local var_32_0 = arg_32_1:getServerId()
	local var_32_1 = arg_32_1:getStateMaps()[var_0_0.BuildToState[self:getBuildType()]] or {}
	local var_32_2 = self._knightSidDic[var_32_0]
	local var_32_3 = g.core.common.ServerTime:getTime()

	if arg_32_2 then
		var_32_2.time = var_0_0.BUILD_SP_KNIGHT_TIME.FOREVER
	else
		var_32_2.time = var_32_1.last_calc_time

		if var_32_3 < var_32_2.time and not var_32_2.scheduler and not var_32_2.request then
			var_32_2.leftTime = var_32_2.time - var_32_3
			var_32_2.scheduler = g.core.common.Scheduler:newSchedule(handler(self, function(arg_33_0, arg_33_1)
				if not arg_33_0:_tickKnightLeftTime(var_32_0, arg_33_1) then
					g.core.common.Scheduler:cancelSchedule(var_32_2.scheduler)
				end
			end), 1)
		end
	end
end

function OutpostConsumptionBuild:onKnightUseConsumption(arg_34_1)
	self:setKnightTime((g.core.model.User.outpostData:getKnightsData():getKnightBySid(arg_34_1.knight_id)))

	for iter_34_0, iter_34_1 in ipairs(self._curItems) do
		if iter_34_1.item_id == arg_34_1.target_item_id then
			iter_34_1.item_num = iter_34_1.item_num - 1
		end
	end

	self:_addDailyReportItem({
		absNum = 1,
		id = self._itemValueToItemDic[arg_34_1.target_item_id],
		knightId = arg_34_1.knight_id
	})
end

function OutpostConsumptionBuild:getCostCoin(arg_35_1)
	local var_35_0 = 1
	local var_35_1 = self:getBonusInfoDic()[var_0_0.BONUS_TYPE.COIN_TYPE]

	if var_35_1 then
		var_35_0 = var_35_0 + var_35_1.value / 10000
	end

	return (math.floor(arg_35_1 * var_35_0))
end

function OutpostConsumptionBuild:getEffectDes()
	return
end

function OutpostConsumptionBuild:_onOrderChanged(arg_37_1)
	if arg_37_1.order_tp == var_0_0.EXCHANGE_TYPE.PRODUCE then
		local var_37_0 = g.core.config.outpost_consumption_item_info.get(arg_37_1.id)
		local var_37_1 = self:getConsumptionItemByItemId(var_37_0.item_value)

		if var_37_1 then
			var_37_1.item_num = var_37_1.item_num + arg_37_1.num
		else
			self._curItems[#self._curItems + 1] = {
				item_id = var_37_0.item_value,
				item_num = arg_37_1.num
			}
		end

		self:onCostItemChanged()
	end
end

function OutpostConsumptionBuild:isHasConsumptionItem()
	for iter_38_0, iter_38_1 in pairs(self._curItems) do
		if iter_38_1.item_num > 0 then
			return true
		end
	end

	return false
end

function OutpostConsumptionBuild:hasResItem()
	for iter_39_0, iter_39_1 in pairs((self:getAllConsumptionItem())) do
		for iter_39_2, iter_39_3 in pairs(iter_39_1.costDic) do
			if g.core.model.User.outpostData:getBagData():getOwnNum(iter_39_3.value) >= iter_39_3.size then
				return true
			end
		end
	end

	return false
end

function OutpostConsumptionBuild:_loadDailyReport()
	local var_40_0 = g.core.common.ServerTime:getDateObject()
	local var_40_1 = g.core.common.Storage:load(table.concat({
		self.__cname,
		"dailyReport"
	}), true)

	self._dailyReportInfo = (not var_40_1 or var_40_1.date ~= var_40_0.year .. "." .. var_40_0.month .. "." .. var_40_0.day) and {
		total = 0,
		date = var_40_0.year .. "." .. var_40_0.month .. "." .. var_40_0.day,
		list = {}
	} or var_40_1
end

function OutpostConsumptionBuild:_addDailyReportItem(arg_41_1)
	local var_41_0 = g.core.common.ServerTime:getDateObject()

	if not self._dailyReportInfo.date ~= var_41_0.year .. "." .. var_41_0.month .. "." .. var_41_0.day then
		self:_loadDailyReport()
	end

	local var_41_1 = self._dailyReportInfo.list
	local var_41_2, var_41_3 = self:_getDailyReportItem(arg_41_1)

	var_41_1[#var_41_1 + 1] = var_41_2
	self._dailyReportInfo.total = self._dailyReportInfo.total + var_41_3

	self:_saveDailyReport()
end

function OutpostConsumptionBuild:_getDailyReportItem(arg_42_1)
	local var_42_0 = g.core.config.outpost_consumption_item_info.get(arg_42_1.id)
	local var_42_1 = g.core.model.User:getName()
	local var_42_2, var_42_3

	if arg_42_1.knightId then
		var_42_1 = g.core.model.User.outpostData:getKnightsData():getKnightBySid(arg_42_1.knightId):getCfg().name
		var_42_2 = self:getCostCoin(arg_42_1.absNum * var_42_0.gold)
		var_42_3 = {
			time = g.core.common.ServerTime:getTimeStringHMS(),
			userName = var_42_1
		}
	end

	var_42_3.itemName = g.core.config.outpost_item_info.get(var_42_0.item_value).name
	var_42_3.coin = var_42_2

	return g.core.lang:get(432641, var_42_3), var_42_2
end

function OutpostConsumptionBuild:_saveDailyReport()
	g.core.common.Storage:save(table.concat({
		self.__cname,
		"dailyReport"
	}), self._dailyReportInfo, true)
end

function OutpostConsumptionBuild:getDailyReportInfo()
	local var_44_0 = g.core.common.ServerTime:getDateObject()

	if not self._dailyReportInfo.date ~= var_44_0.year .. "." .. var_44_0.month .. "." .. var_44_0.day then
		self:_loadDailyReport()
	end

	return self._dailyReportInfo
end

function OutpostConsumptionBuild:getJudgeValue(arg_45_1)
	return
end

return OutpostConsumptionBuild
