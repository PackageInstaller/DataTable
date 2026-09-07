local EquipCode = class("EquipCode", import(".BaseVO"))

function EquipCode:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.shipGroupId = arg_1_1.shipGroupId
	self.str = arg_1_1.eqcode
	self.new = arg_1_1.new
	self.like = arg_1_1.like
	self.evaPoint = arg_1_1.eval_point
	self.state = arg_1_1.state

	local var_1_0 = string.split(self.str, "&")

	self.valid = #var_1_0 == 4 and self.shipGroupId == tonumber(var_1_0[2], 32)
	self.tags = {
		tonumber(var_1_0[3]),
		tonumber(var_1_0[4])
	}

	return
end

function EquipCode:IsValid()
	return self.valid
end

function EquipCode:GetLabels()
	return self.tags
end

function EquipCode:MarkLike()
	self.afterLike = true

	return
end

return EquipCode
