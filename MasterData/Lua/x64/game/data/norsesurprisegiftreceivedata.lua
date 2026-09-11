local var_0_0 = singletonClass("NorseSurpriseGiftReceiveData")

function var_0_0.Ctor(arg_1_0)
	return
end

function var_0_0:InitData(arg_2_1)
	print("抽扭蛋初始数据", 65429)

	self.delete_list = arg_2_1.delete_list
	self.choose_list = arg_2_1.choose_list
	self.draw_list = arg_2_1.draw_list
	self.result_role_id = arg_2_1.result_role_id

	self:UpdateRedPointData(ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW)
	self:UpdateRedPointData2(ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW)
end

function var_0_0:SetRoleData(arg_3_1, arg_3_2)
	for iter_3_0, iter_3_1 in ipairs(arg_3_2.delete_list) do
		table.insert(self.delete_list, iter_3_1)
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_2.draw_list) do
		table.insert(self.draw_list, iter_3_3)
	end

	self:UpdateRedPointData2(ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW)
end

function var_0_0:GetDelRoleData()
	return self.delete_list
end

function var_0_0:GetDrawRoleData()
	return self.draw_list
end

function var_0_0:GetChooseRoleData()
	return self.choose_list
end

function var_0_0.SetChooseRoleData(arg_7_0, arg_7_1)
	arg_7_0.choose_list = arg_7_1
end

function var_0_0:GetResultRoleId()
	return self.result_role_id
end

function var_0_0.SetResultRoleId(arg_9_0, arg_9_1)
	arg_9_0.result_role_id = arg_9_1
end

function var_0_0:UpdateRedPointData(arg_10_1)
	local var_10_0 = string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW, arg_10_1)

	manager.redPoint:setTip(var_10_0, (ItemTools.getItemNum(CurrencyConst.CURRENCY_RANDOM_TARGET_COIN)))

	if #self.draw_list >= 5 or self.result_role_id and self.result_role_id > 0 then
		manager.redPoint:setTip(var_10_0, 0)
	end
end

function var_0_0:UpdateRedPointData2(arg_11_1)
	self:UpdateRedPointData(arg_11_1)

	local var_11_0 = string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT_RECEIVE, arg_11_1)

	if self.draw_list and #self.draw_list >= 5 then
		manager.redPoint:setTip(var_11_0, 1)
	else
		manager.redPoint:setTip(var_11_0, 0)
	end

	if self.result_role_id and self.result_role_id > 0 then
		manager.redPoint:setTip(var_11_0, 0)
	end
end

return var_0_0
