local var_0_0 = class("HeroSurpassPreviewNodeItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.surpassItemList = {}

	for iter_2_0 = 1, arg_2_0.transform_.childCount do
		local var_2_0 = arg_2_0["messagebg" .. iter_2_0 .. "Go_"]
		local var_2_1 = HeroSurpaasPreviewItem.New(var_2_0, iter_2_0 == 1)

		arg_2_0.surpassItemList[iter_2_0] = var_2_1
	end
end

function var_0_0.SetClickCheckCallback(arg_3_0, arg_3_1)
	arg_3_0.surpassItemList[1]:SetClickCheckCallback(arg_3_1)
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, true)

	for iter_4_0, iter_4_1 in pairs(arg_4_0.surpassItemList) do
		local var_4_0 = arg_4_1[iter_4_0]

		if var_4_0 then
			iter_4_1:SetActive(true)
			iter_4_1:RefreshUI(var_4_0)
		else
			iter_4_1:SetActive(false)
		end
	end
end

function var_0_0.Show(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

function var_0_0.Dispose(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.surpassItemList) do
		iter_6_1:Dispose()
	end

	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
