local ThemePassCardData = class("ThemePassCardData", require("app.core.model.BaseData"))

function ThemePassCardData:ctor()
	self._canGetAward = nil
	self._passCardList = {}
	self._idIndexDic = {}
	self._actionValueDic = {}
	self._themeActivityId = 0
end

function ThemePassCardData:initData(arg_2_1)
	self._passCardList = {}
	self._idIndexDic = {}

	self:_initPassCardList(arg_2_1)
end

function ThemePassCardData:_initPassCardList(arg_3_1)
	local var_3_0 = g.core.config.activity_theme_info.get(arg_3_1).activity_passcard

	while var_3_0 ~= 0 do
		local var_3_1 = self:_createPassCardInfo((g.core.config.activity_theme_passcard_info.get(var_3_0)))

		self._passCardList[#self._passCardList + 1] = var_3_1
		self._idIndexDic[var_3_0] = #self._passCardList + 1
		var_3_0 = var_3_1.nextId
	end
end

function ThemePassCardData:_createPassCardInfo(arg_4_1)
	local var_4_0 = table.concat({
		arg_4_1.action,
		arg_4_1.key
	}, "_")
	local var_4_1 = self._actionValueDic[var_4_0]

	if self._actionValueDic[var_4_0] == nil then
		var_4_1 = 0
		self._actionValueDic[var_4_0] = 0
	end

	local var_4_2 = {
		payNum = 0,
		state = 0,
		id = arg_4_1.id,
		nextId = arg_4_1.next_id,
		cfg = arg_4_1,
		curNum = var_4_1,
		targetNum = arg_4_1.num
	}

	if arg_4_1.buy_ban_type == 1 then
		var_4_2.payLimit = arg_4_1.buy_num or -9999
	end

	var_4_2.freeAwards = g.core.common.Drops:getGoodsArray(arg_4_1.free_drop)
	var_4_2.payAwards = g.core.common.Drops:getGoodsArray(arg_4_1.pay_drop)

	return var_4_2
end

function ThemePassCardData:updateAllInfo(arg_5_1)
	self._canGetAward = false
	self._themeActivityId = arg_5_1.activity_id

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.actions or {}) do
		self:updateOneAction(iter_5_1)
	end

	self:updateAllFreeAward(arg_5_1.free_award_ids or {})

	for iter_5_2, iter_5_3 in ipairs(arg_5_1.pay_nums or {}) do
		self:updatePayNum(iter_5_3.id, iter_5_3.num)
	end
end

function ThemePassCardData:updateAllFreeAward(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		self:updateFreeAward(iter_6_1)
	end
end

function ThemePassCardData:updateFreeAward(arg_7_1)
	self._passCardList[self._idIndexDic[arg_7_1]].state = 2
end

function ThemePassCardData:updatePayNum(arg_8_1, arg_8_2, arg_8_3)
	if arg_8_3 then
		arg_8_2 = self._passCardList[self._idIndexDic[arg_8_1]].payNum + arg_8_2
	end

	self._passCardList[self._idIndexDic[arg_8_1]].payNum = math.min(math.abs(self._passCardList[self._idIndexDic[arg_8_1]].payLimit), arg_8_2)
end

function ThemePassCardData:updateActions(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if iter_9_1.activity_id == self._themeActivityId then
			self:updateOneAction(iter_9_1.action)
		end
	end
end

function ThemePassCardData:updateOneAction(arg_10_1)
	self._actionValueDic[table.concat({
		arg_10_1.type,
		arg_10_1.key
	}, "_")] = arg_10_1.value

	for iter_10_0, iter_10_1 in ipairs(self._passCardList) do
		if arg_10_1.type == iter_10_1.cfg.action and arg_10_1.key == iter_10_1.cfg.key then
			iter_10_1.curNum = arg_10_1.value

			if iter_10_1.state == 0 then
				iter_10_1.state = iter_10_1.curNum >= iter_10_1.targetNum and 1 or 0
			end
		end
	end
end

function ThemePassCardData:getPassCardInfoList()
	return self._passCardList
end

function ThemePassCardData:getThemeActivityId()
	return self._themeActivityId
end

function ThemePassCardData:getAllFreeAwardPassId()
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(self._passCardList) do
		if iter_13_1.state == 1 then
			var_13_0[#var_13_0 + 1] = iter_13_1.id
		end
	end

	return var_13_0
end

function ThemePassCardData:refreshRedPointData(arg_14_1)
	self._canGetAward = arg_14_1
end

function ThemePassCardData:canGetAward(arg_15_1)
	if not arg_15_1 then
		if self._canGetAward then
			return true
		end

		return #self:getAllFreeAwardPassId() > 0
	else
		return self._passCardList[self._idIndexDic[arg_15_1]].state == 1
	end
end

return ThemePassCardData
