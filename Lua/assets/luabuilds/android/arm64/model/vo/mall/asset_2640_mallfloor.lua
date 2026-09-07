local MallFloor = class("MallFloor", import("model.vo.BaseVO"))

function MallFloor:Ctor(arg_1_1, arg_1_2)
	self.id = arg_1_1.id
	self.configId = self.id

	local var_1_0 = arg_1_1.employee_list or {}

	self.staffList = {}

	for iter_1_0 = 1, self:getConfig("need_staff_count") do
		self.staffList[iter_1_0] = var_1_0[iter_1_0] or 0
	end

	self.isUnlock = arg_1_2

	return
end

function MallFloor:bindConfigTable()
	return pg.activity_mall_template
end

function MallFloor:IsUnlock()
	return self.isUnlock
end

function MallFloor:CheckUnlock(arg_4_1)
	self.isUnlock = arg_4_1 >= self:getConfig("need_mall_level")

	return
end

function MallFloor:SetLastIncome(arg_5_1)
	self.lastIncome = arg_5_1

	return
end

function MallFloor:GetLastIncome()
	return self.lastIncome or 0
end

function MallFloor:SetStaff(arg_7_1, arg_7_2)
	self.staffList[arg_7_1] = arg_7_2

	return
end

function MallFloor:GetStaffList()
	return self.staffList
end

function MallFloor:GetEmptyIdx()
	for iter_9_0, iter_9_1 in ipairs(self.staffList) do
		if iter_9_1 == 0 then
			return iter_9_0
		end
	end

	return nil
end

function MallFloor:GetTargetInfos(arg_10_1)
	local var_10_0 = underscore.detect(self:getConfig("floor_target"), function(arg_11_0)
		return arg_10_1 >= arg_11_0[1][1] and arg_10_1 <= arg_11_0[1][2]
	end)

	return var_10_0 and var_10_0[2]
end

function MallFloor:GetBaseIncome(arg_12_1)
	local var_12_0 = underscore.detect(self:getConfig("floor_basic_profit"), function(arg_13_0)
		return arg_12_1 >= arg_13_0[1][1] and arg_12_1 <= arg_13_0[1][2]
	end)

	return var_12_0 and var_12_0[3]
end

return MallFloor
