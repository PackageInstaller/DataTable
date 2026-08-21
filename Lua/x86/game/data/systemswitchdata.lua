local var_0_0 = singletonClass("SystemSwitchData")

function var_0_0.Init(arg_1_0)
	arg_1_0.switchIDList_ = {}
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.close_switch) do
		table.insert(arg_2_0.switchIDList_, iter_2_1)
	end
end

function var_0_0.UpdateData(arg_3_0, arg_3_1)
	if arg_3_1.type == 1 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_1.close_switch) do
			table.insert(arg_3_0.switchIDList_, iter_3_1)
		end
	else
		for iter_3_2, iter_3_3 in ipairs(arg_3_1.close_switch) do
			local var_3_0 = table.indexof(arg_3_0.switchIDList_, iter_3_3)

			if var_3_0 then
				arg_3_0.switchIDList_[var_3_0] = nil
			end
		end
	end
end

function var_0_0.GetSwitchIDIsOpen(arg_4_0, arg_4_1)
	if table.indexof(arg_4_0.switchIDList_, arg_4_1) then
		return true
	else
		return false
	end
end

return var_0_0
