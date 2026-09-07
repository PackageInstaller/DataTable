local ManualSignActivity = class("ManualSignActivity", import("model.vo.Activity"))

ManualSignActivity.OP_SIGN = 1
ManualSignActivity.OP_GET_AWARD = 2
ManualSignActivity.STATE_EMPTY = 0
ManualSignActivity.STATE_CAN_GET = 1
ManualSignActivity.STATE_GOT = 2

function ManualSignActivity:Ctor(arg_1_1)
	ManualSignActivity.super.Ctor(self, arg_1_1)

	self.dataConfig = pg.activity_event_sign[self.id]

	return
end

function ManualSignActivity:GetSignedList()
	return self.data1_list
end

function ManualSignActivity:GetIndexByToday()
	return self:getDayIndex()
end

function ManualSignActivity:GetTotalDayCnt()
	return #self:GetDropList()
end

function ManualSignActivity:GetDropList()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(self.dataConfig.drop_display) do
		table.insert(var_5_0, {
			type = iter_5_1[1],
			id = iter_5_1[2],
			count = iter_5_1[3]
		})
	end

	return var_5_0
end

function ManualSignActivity:TodayIsSigned()
	return table.contains(self:GetSignedList(), (self:GetIndexByToday()))
end

function ManualSignActivity:Signed()
	local var_7_0 = self:GetIndexByToday()

	if not table.contains(self.data1_list, var_7_0) then
		self.data1 = self.data1 + 1

		table.insert(self.data1_list, var_7_0)
	end

	return
end

function ManualSignActivity:GetSignedDayCnt()
	return #self.data1_list
end

function ManualSignActivity:CanGetAward()
	return self:GetGetAwardCnt() < self:GetSignedDayCnt()
end

function ManualSignActivity:AnyAwardCanGet()
	return #self:GetCanGetAwardIndexList() > 0
end

function ManualSignActivity:GetCanGetAwardIndexList()
	if not self:CanGetAward() then
		return {}
	end

	local var_11_0 = self:GetGetAwardCnt()
	local var_11_1 = math.max(self:GetSignedDayCnt() - var_11_0, 0)

	if var_11_1 <= 0 then
		return {}
	end

	table.sort(self.data2_list)

	local var_11_2 = {}

	for iter_11_0 = (var_11_0 == 0 and 0 or self.data2_list[var_11_0]) + 1, math.min((var_11_0 == 0 and 0 or self.data2_list[var_11_0]) + var_11_1, (self:GetTotalDayCnt())) do
		table.insert(var_11_2, iter_11_0)
	end

	return var_11_2
end

function ManualSignActivity:GetAwardState(arg_12_1)
	if table.contains(self:GetCanGetAwardIndexList(), arg_12_1) then
		return ManualSignActivity.STATE_CAN_GET
	elseif table.contains(self.data2_list, arg_12_1) then
		return ManualSignActivity.STATE_GOT
	else
		return ManualSignActivity.STATE_EMPTY
	end

	return
end

function ManualSignActivity:GetGetAwardCnt()
	return #self.data2_list
end

function ManualSignActivity:GetAllAwards()
	for iter_14_0, iter_14_1 in ipairs((self:GetCanGetAwardIndexList())) do
		self:GetIndexAward(iter_14_1)
	end

	return
end

function ManualSignActivity:GetIndexAward(arg_15_1)
	if not table.contains(self.data2_list, arg_15_1) then
		self.data2 = self.data2 + 1

		table.insert(self.data2_list, arg_15_1)
	end

	return
end

function ManualSignActivity:IsManualSignActAndAnyAwardCanGet()
	local var_16_0 = getProxy(ActivityProxy):getActivityById(self)

	if not var_16_0 or var_16_0:isEnd() then
		return false
	end

	if not isa(var_16_0, ManualSignActivity) then
		return false
	end

	return var_16_0:AnyAwardCanGet()
end

return ManualSignActivity
