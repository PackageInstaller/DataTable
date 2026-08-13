class = var_0_10000

local var_0_0 = "WorldMediaCollectionFileLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".WorldMediaCollectionTemplateLayer"))

function var_0_1.getUIName(arg_1_0)
	return "WorldMediaCollectionFileUI"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0._top = var_1.Find(var_2_0, "Top")

	return
end

function var_0_1.GetDetailLayer(arg_3_0)
	if not arg_3_0.detailLayer then
		WorldMediaCollectionFileDetailLayer = var_1
		arg_3_0.detailLayer = var_1.New(arg_3_0, arg_3_0._tf, arg_3_0.event, arg_3_0.contextData)

		local var_3_0 = arg_3_0.detailLayer

		var_1.Load(var_3_0)
	end

	return arg_3_0.detailLayer
end

function var_0_1.OpenDetailLayer(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0:GetDetailLayer()

	arg_4_0.contextData.FileGroupIndex = arg_4_1

	local var_4_1 = var_4_0.buffer

	var_4.Show(var_4_1)

	if arg_4_2 then
		local var_4_2 = var_4_0.buffer

		var_4.Openning(var_4_2)
	else
		local var_4_3 = var_4_0.buffer

		var_4.Enter(var_4_3)
	end

	arg_4_0:HideGroupLayer()

	return
end

function var_0_1.HideDetailLayer(arg_5_0)
	if not arg_5_0.detailLayer then
		return
	end

	local var_5_0 = arg_5_0.detailLayer.buffer

	var_1.Hide(var_5_0)

	return
end

function var_0_1.CloseDetailLayer(arg_6_0)
	if arg_6_0.detailLayer then
		local var_6_0 = arg_6_0.detailLayer

		var_1.Destroy(var_6_0)

		arg_6_0.detailLayer = nil
	end

	return
end

function var_0_1.GetGroupLayer(arg_7_0)
	if not arg_7_0.groupLayer then
		WorldMediaCollectionFileGroupLayer = var_1
		arg_7_0.groupLayer = var_1.New(arg_7_0, arg_7_0._tf, arg_7_0.event, arg_7_0.contextData)

		local var_7_0 = arg_7_0.groupLayer

		var_1.Load(var_7_0)
	end

	return arg_7_0.groupLayer
end

function var_0_1.OpenGroupLayer(arg_8_0)
	local var_8_0 = arg_8_0:GetGroupLayer().buffer

	var_2.Show(var_8_0)

	local var_8_1 = var_1.buffer

	var_2.UpdateGroupList(var_8_1)
	arg_8_0:HideDetailLayer()

	return
end

function var_0_1.HideGroupLayer(arg_9_0)
	if not arg_9_0.groupLayer then
		return
	end

	local var_9_0 = arg_9_0.groupLayer.buffer

	var_1.Hide(var_9_0)

	return
end

function var_0_1.CloseGroupLayer(arg_10_0)
	if arg_10_0.groupLayer then
		local var_10_0 = arg_10_0.groupLayer

		var_1.Destroy(var_10_0)

		arg_10_0.groupLayer = nil
	end

	return
end

function var_0_1.OnSelected(arg_11_0)
	var_0_1.super.OnSelected(arg_11_0)

	if arg_11_0.contextData.FileGroupIndex then
		arg_11_0:OpenDetailLayer(arg_11_0.contextData.FileGroupIndex)
	else
		arg_11_0:OpenGroupLayer()
	end

	return
end

function var_0_1.OnReselected(arg_12_0)
	var_0_1.super.OnReselected(arg_12_0)
	arg_12_0:Backward()

	return
end

function var_0_1.OnDeselected(arg_13_0)
	arg_13_0.contextData.FileGroupIndex = nil
	arg_13_0.contextData.SelectedFile = nil

	var_0_1.super.OnDeselected(arg_13_0)

	return
end

function var_0_1.Hide(arg_14_0)
	arg_14_0:HideDetailLayer()
	arg_14_0:HideGroupLayer()
	var_0_1.super.Hide(arg_14_0)

	return
end

function var_0_1.Backward(arg_15_0)
	if not arg_15_0.contextData.FileGroupIndex then
		return
	end

	arg_15_0.contextData.FileGroupIndex = nil
	arg_15_0.contextData.SelectedFile = nil

	arg_15_0:OpenGroupLayer()

	return true
end

function var_0_1.OnBackward(arg_16_0)
	return arg_16_0:Backward()
end

function var_0_1.OnDestroy(arg_17_0)
	arg_17_0:CloseDetailLayer()
	arg_17_0:CloseGroupLayer()
	var_0_1.super.OnDestroy(arg_17_0)

	return
end

return var_0_1
