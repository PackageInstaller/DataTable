local var_0_0 = class("PopFukubukuroProbabilityItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_1[1]
	local var_5_1 = arg_5_1[2]
	local var_5_2 = arg_5_1[3]
	local var_5_3 = ItemCfg[var_5_0]

	arg_5_0.m_name.text = ItemTools.getItemName(var_5_0) .. "x" .. var_5_1

	local var_5_4 = var_5_2 / arg_5_3
	local var_5_5 = 0

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		local var_5_6 = iter_5_1[1]
		local var_5_7 = iter_5_1[2]
		local var_5_8 = iter_5_1[3] / arg_5_3

		if var_5_6 ~= var_5_0 then
			var_5_5 = var_5_4 / (1 - var_5_4) * var_5_8 + var_5_8 / (1 - var_5_8) * var_5_4 + var_5_5
		end
	end

	local var_5_9 = math.floor(var_5_5 * 10000) / 100

	arg_5_0.m_probability.text = string.format("%.2f", var_5_9) .. "%"
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
