local var_0_0 = class("SurpassUpAttrNode", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.attrList = {}

	for iter_2_0 = 1, 3 do
		local var_2_0 = arg_2_0["attr" .. iter_2_0 .. "Go_"]

		arg_2_0.attrList[iter_2_0] = SurpassUpAttrItem.New(var_2_0)
	end
end

function var_0_0.RefreshUi(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.texttittleText_.text = GetTips("BASE_PROPERTY_UP")

	local var_3_0 = arg_3_1.params

	for iter_3_0 = 1, 3 do
		arg_3_0.attrList[iter_3_0]:SetActive(false)
	end

	for iter_3_1, iter_3_2 in pairs(var_3_0) do
		local var_3_1 = iter_3_2[1]
		local var_3_2 = iter_3_2[2]
		local var_3_3 = arg_3_2[var_3_1]

		arg_3_0.attrList[iter_3_1]:RefreshUi(var_3_1, var_3_2, var_3_3)
	end
end

function var_0_0.Dispose(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.attrList) do
		iter_4_1:Dispose()

		iter_4_1 = nil
	end

	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
