local var_0_0 = class("CultureGravureEquipPopItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController_ = arg_3_0.itemControl_:GetController("state")
	arg_3_0.previewItems = {}

	for iter_3_0 = 1, 2 do
		arg_3_0.previewItems[iter_3_0] = CultureGravureEquipPreviewItem.New(arg_3_0["previewItem_" .. iter_3_0])
	end
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1.equipedData
	local var_4_1 = arg_4_1.recommendData

	arg_4_0.previewItems[1]:SetData(var_4_0, arg_4_1.state, false, arg_4_2)
	arg_4_0.previewItems[2]:SetData(var_4_1, arg_4_1.state, true, arg_4_2)
	arg_4_0.stateController_:SetSelectedState(arg_4_1.state == "had" and "had" or "nothad")
end

function var_0_0.Dispose(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.previewItems) do
		iter_5_1:Dispose()
	end

	arg_5_0.previewItems = nil

	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
