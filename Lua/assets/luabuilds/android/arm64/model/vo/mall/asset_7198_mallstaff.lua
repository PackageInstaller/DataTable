local MallStaff = class("MallStaff", import("model.vo.BaseVO"))

MallStaff.STATUS = {
	FLOOR = 2,
	NORMAL = 1,
	ORDER = 3
}

function MallStaff:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.tid = arg_1_1.tid
	self.configId = self.tid
	self.attrs = {}

	if arg_1_1.attr_list then
		table.sort(arg_1_1.attr_list, function(arg_2_0, arg_2_1)
			return arg_2_0.key < arg_2_1.key
		end)

		for iter_1_0, iter_1_1 in ipairs(arg_1_1.attr_list) do
			table.insert(self.attrs, iter_1_1.value)
		end
	end

	self:SetStatus(MallStaff.STATUS.NORMAL, {})

	return
end

function MallStaff:bindConfigTable()
	return pg.activity_mall_staff_template
end

function MallStaff:NeedReqData()
	return #self.attrs == 0
end

function MallStaff:GetAttrList()
	return self.attrs
end

function MallStaff:SetStatus(arg_6_1, arg_6_2)
	self.status = arg_6_1
	self.statusData = arg_6_2

	return
end

function MallStaff:GetStatusInfos()
	return self.status, self.statusData
end

function MallStaff:SetExtraData(arg_8_1)
	local var_8_0 = {}

	for iter_8_0 = 1, #arg_8_1, 2 do
		table.insert(var_8_0, {
			key = arg_8_1[iter_8_0],
			value = arg_8_1[iter_8_0 + 1]
		})
	end

	table.sort(var_8_0, function(arg_9_0, arg_9_1)
		return arg_9_0.key < arg_9_1.key
	end)

	self.attrs = {}

	for iter_8_1, iter_8_2 in ipairs(var_8_0) do
		table.insert(self.attrs, iter_8_2.value)
	end

	return
end

function MallStaff:GetTotalVal()
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(self.attrs) do
		var_10_0 = var_10_0 + iter_10_1
	end

	return var_10_0
end

return MallStaff
