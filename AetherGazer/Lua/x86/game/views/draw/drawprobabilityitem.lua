local var_0_0 = class("DrawProbabilityItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
end

function var_0_0.RefreshData(arg_2_0, arg_2_1)
	arg_2_0:Show(true)

	arg_2_0.labName_.text = GetI18NText(arg_2_1.name)
	arg_2_0.labRate_.text = GetI18NText(arg_2_1.probability)
	arg_2_0.labRate2_.text = ""

	if arg_2_1.probability2 then
		arg_2_0.labRate2_.text = GetI18NText(arg_2_1.probability2)
	end

	local var_2_0 = arg_2_1.itemid_
	local var_2_1 = ""

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		local var_2_2 = DrawItemCfg[iter_2_1].item_id or 0

		if var_2_2 ~= 0 then
			local var_2_3 = ItemCfg[var_2_2]

			if var_2_1 == "" then
				var_2_1 = ItemTools.getItemName(var_2_2)
			else
				var_2_1 = var_2_1 .. "/" .. ItemTools.getItemName(var_2_2)
			end
		end
	end

	arg_2_0.labContent_.text = GetI18NText(var_2_1)
end

function var_0_0.Show(arg_3_0, arg_3_1)
	SetActive(arg_3_0.gameObject_, arg_3_1)
end

return var_0_0
