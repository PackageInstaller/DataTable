local ResourceFieldAttr = class("ResourceFieldAttr")

function ResourceFieldAttr:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.name = arg_1_2
	self.config = arg_1_1
	self.attrName = arg_1_3
	self.level = 0
	self.nextLevel = 0
	self.value = 0
	self.nextValue = 0
	self.maxValue = 0
	self.addition = 0

	return
end

function ResourceFieldAttr:Update(arg_2_1)
	if arg_2_1 == self.level then
		return
	end

	self.level = arg_2_1
	self.nextLevel = math.min(arg_2_1 + 1, #self.config.all)

	self:ReCalcValue()

	return
end

function ResourceFieldAttr:ReCalcValue()
	self.value = self.config[self.level][self.attrName]
	self.nextValue = self.config[self.nextLevel][self.attrName]
	self.maxValue = self.config[#self.config.all][self.attrName]
	self.addition = self.nextValue - self.value

	return
end

function ResourceFieldAttr:GetName()
	return self.name
end

function ResourceFieldAttr:IsMaxLevel()
	return self.level == self.nextLevel
end

function ResourceFieldAttr:GetValue()
	return self.value
end

function ResourceFieldAttr:GetNextValue()
	return self.nextValue
end

function ResourceFieldAttr:GetMaxValue()
	return self.maxValue
end

function ResourceFieldAttr:GetAddition()
	return self.addition
end

function ResourceFieldAttr:GetAdditionDesc()
	return self.addition
end

function ResourceFieldAttr:GetProgressDesc()
	return self.value .. "/" .. self.maxValue
end

return ResourceFieldAttr
