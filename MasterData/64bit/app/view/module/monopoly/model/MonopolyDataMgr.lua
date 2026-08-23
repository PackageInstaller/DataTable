local var_0_0 = g.core.model.User.cultivateDataMgr
local MonopolyData = require("app.view.module.monopoly.model.MonopolyData")
local MonopolyDataMgr = class("MonopolyDataMgr")

function MonopolyDataMgr:ctor()
	self._monopolyDataMap = {}
	self._svrRedCache = {}
	self._curOpenAct = 0
end

function MonopolyDataMgr:onGetMonopolyInfo(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.map_data or {}) do
		if self._monopolyDataMap[iter_2_1.activity_id] then
			self._monopolyDataMap[iter_2_1.activity_id]:updateMapData(iter_2_1)
		else
			self._monopolyDataMap[iter_2_1.activity_id] = MonopolyData.new(iter_2_1)
		end
	end
end

function MonopolyDataMgr:onMonopolyRollDice(arg_3_1)
	if self._monopolyDataMap[arg_3_1.activityId] then
		self._monopolyDataMap[arg_3_1.activityId]:onMonopolyRollDice(arg_3_1)
	end
end

function MonopolyDataMgr:onMonopolyNodeAward(arg_4_1)
	if self._monopolyDataMap[arg_4_1.activityId] then
		self._monopolyDataMap[arg_4_1.activityId]:onMonopolyNodeAward(arg_4_1)
	end
end

function MonopolyDataMgr:onMonopolyUseFixedDice(arg_5_1)
	if self._monopolyDataMap[arg_5_1.activityId] then
		self._monopolyDataMap[arg_5_1.activityId]:onMonopolyUseFixedDice(arg_5_1)
	end
end

function MonopolyDataMgr:onS2CRedPoint(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1.hint_activity_ids or {}) do
		self._svrRedCache[iter_6_1] = true
	end
end

function MonopolyDataMgr:getMonopolyData(arg_7_1)
	if not arg_7_1 then
		if self._monopolyDataMap[self._curOpenAct] then
			return self._monopolyDataMap[self._curOpenAct]
		end

		return self._monopolyDataMap[next(self._monopolyDataMap or {})]
	end

	return self._monopolyDataMap[arg_7_1]
end

function MonopolyDataMgr:setCurOpenActId(arg_8_1)
	self._curOpenAct = arg_8_1
end

function MonopolyDataMgr:isHasDiceCanUse(arg_9_1)
	local var_9_0 = var_0_0:getCultivateData((arg_9_1 or nil) and (arg_9_1.actValue or 0))

	if var_9_0:isWitchActivity() and var_9_0:isInNormalOpenTime() then
		local var_9_1 = g.core.common.Goods

		return g.core.model.User.shopData:getLeftCount(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.MONOPOLY_ITEM_COUNT) > 0 or g.core.model.User.bagData:getOwnNum(var_9_1.TYPE_ITEM, var_9_1.ITEM.MONOPOLY_RUN_DICE) > 0
	end

	return false
end

function MonopolyDataMgr:isHasPointRewardCanGet(arg_10_1)
	local var_10_0

	if arg_10_1 then
		var_10_0 = arg_10_1.actValue or 0
	end

	local var_10_1 = var_0_0:getCultivateData(var_10_0)

	if var_10_1:isWitchActivity() and var_10_1:isInNormalOpenTime() then
		if self._monopolyDataMap[var_10_0] then
			return self._monopolyDataMap[var_10_0]:isHasPointRewardCanGet()
		else
			return self._svrRedCache[var_10_0]
		end
	end

	return false
end

return MonopolyDataMgr
