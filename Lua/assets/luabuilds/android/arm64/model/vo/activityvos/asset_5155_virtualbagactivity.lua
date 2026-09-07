local VirtualBagActivity = class("VirtualBagActivity", import("model.vo.Activity"))

function VirtualBagActivity:getVitemNumber(arg_1_1)
	return self.data1KeyValueList[1][arg_1_1] or 0
end

function VirtualBagActivity:setVitemNumber(arg_2_1, arg_2_2)
	if self.data1KeyValueList[1][arg_2_1] then
		self.data1KeyValueList[1][arg_2_1] = arg_2_2
	end

	return
end

function VirtualBagActivity:addVitemNumber(arg_3_1, arg_3_2)
	self.data1KeyValueList[1][arg_3_1] = self:getVitemNumber(arg_3_1) + arg_3_2

	return
end

function VirtualBagActivity:subVitemNumber(arg_4_1, arg_4_2)
	self.data1KeyValueList[1][arg_4_1] = math.max(0, self:getVitemNumber(arg_4_1) - arg_4_2)

	return
end

function VirtualBagActivity:GetAllVitems()
	return self.data1KeyValueList[1]
end

function VirtualBagActivity:GetDropCfgByType()
	local var_6_0 = self and AcessWithinNull(pg.activity_drop_type[self], "activity_id")
	local var_6_1 = var_6_0 and AcessWithinNull(pg.activity_template[var_6_0], "type")

	return
end

return VirtualBagActivity
