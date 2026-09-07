local IslandRoleDelegationReward = class("IslandRoleDelegationReward")

function IslandRoleDelegationReward:Ctor(arg_1_1)
	self:UpdateData(arg_1_1)

	return
end

function IslandRoleDelegationReward:UpdateData(arg_2_1)
	self.formula_id = arg_2_1.formula_id
	self.formula_drop_list = arg_2_1.formula_drop_list
	self.ship_id = arg_2_1.ship_id
	self.exp = arg_2_1.exp
	self.main_num = arg_2_1.main_num
	self.other_num = arg_2_1.other_num

	return
end

function IslandRoleDelegationReward:GetState()
	return
end

return IslandRoleDelegationReward
