local var_0_0 = class("AutoChessBaseURCardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.cardID_ = 0
	arg_1_0.ItemList = {}

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.InitUI(arg_3_0)
	return
end

function var_0_0.AddListeners(arg_4_0)
	return
end

function var_0_0.SetItem(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.ItemList[arg_5_1] == nil then
		local var_5_0 = Object.Instantiate(arg_5_2, arg_5_0.parentTrans_)

		arg_5_0.ItemList[arg_5_1] = AutoChessBaseCardItem.New(var_5_0)
	end
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.cardID_ = arg_6_1

	for iter_6_0, iter_6_1 in pairs(arg_6_0.ItemList) do
		if iter_6_0 == arg_6_0.cardID_ then
			iter_6_1:SetActive(true)
		else
			iter_6_1:SetActive(false)
		end
	end

	arg_6_0:RefreshUI()
end

function var_0_0.SetClickHandler(arg_7_0, arg_7_1)
	arg_7_0.ItemList[arg_7_0.cardID_]:SetClickHandler(arg_7_1)
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.ItemList[arg_8_0.cardID_]:SetData(arg_8_0.cardID_, true)
end

function var_0_0.SetPositionState(arg_9_0, arg_9_1)
	arg_9_0.ItemList[arg_9_0.cardID_]:SetPositionState(arg_9_1)
end

function var_0_0.SetActive(arg_10_0, arg_10_1)
	SetActive(arg_10_0.gameObject_, arg_10_1)
end

function var_0_0.Dispose(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.ItemList) do
		iter_11_1:Dispose()
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
