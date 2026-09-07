local ResourceFieldLevelProductAttr = class("ResourceFieldLevelProductAttr", import(".ResourceFieldProductAttr"))

function ResourceFieldLevelProductAttr:ReCalcValue()
	self.multiple = self.config[self.level].hour_time

	ResourceFieldLevelProductAttr.super.ReCalcValue(self)

	return
end

return ResourceFieldLevelProductAttr
