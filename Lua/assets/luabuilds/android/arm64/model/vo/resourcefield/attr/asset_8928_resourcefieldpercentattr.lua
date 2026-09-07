local ResourceFieldPercentAttr = class("ResourceFieldPercentAttr", import(".ResourceFieldProductAttr"))

function ResourceFieldPercentAttr:GetProgressDesc()
	return self.value .. "%" .. "/" .. self.maxValue .. "%"
end

function ResourceFieldPercentAttr:GetAdditionDesc()
	return self.addition .. "%"
end

return ResourceFieldPercentAttr
