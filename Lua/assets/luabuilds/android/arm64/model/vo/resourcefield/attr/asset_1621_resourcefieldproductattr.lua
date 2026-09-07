local ResourceFieldProductAttr = class("ResourceFieldProductAttr", import(".ResourceFieldAttr"))

function ResourceFieldProductAttr:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	ResourceFieldProductAttr.super.Ctor(self, arg_1_1, arg_1_2, arg_1_3)

	self.multiple = arg_1_4

	return
end

function ResourceFieldProductAttr:ReCalcValue()
	self.value = self.config[self.level][self.attrName] * self.multiple
	self.nextValue = self.config[self.nextLevel][self.attrName] * self.multiple
	self.maxValue = self.config[#self.config.all][self.attrName] * self.multiple
	self.addition = self.nextValue - self.value

	return
end

function ResourceFieldProductAttr:GetAdditionDesc()
	return self.addition .. "/h"
end

function ResourceFieldProductAttr:GetProgressDesc()
	return self.value .. "/h" .. "/" .. self.maxValue .. "/h"
end

return ResourceFieldProductAttr
