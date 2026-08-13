class = var_0_10000

local var_0_0 = "WorldMediaCollectionRecordLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".WorldMediaCollectionTemplateLayer"))

function var_0_1.getUIName(arg_1_0)
	return "WorldMediaCollectionRecordUI"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0._top = var_1.Find(var_2_0, "Top")

	local var_2_1 = arg_2_0._top

	arg_2_0.memoryMask = var_1.Find(var_2_1, "StoryMask")

	return
end

function var_0_1.OnSelected(arg_3_0)
	var_0_1.super.OnSelected(arg_3_0)

	if arg_3_0.contextData.recordGroup then
		arg_3_0:ShowRecordGroup(arg_3_0.contextData.recordGroup)
	else
		arg_3_0:OpenGroupLayer()
	end

	return
end

function var_0_1.Backward(arg_4_0)
	if not arg_4_0.contextData.recordGroup then
		return
	end

	arg_4_0.contextData.recordGroup = nil

	if arg_4_0.contextData.storyNodeID then
		local var_4_0 = arg_4_0.contextData.storyNodeID

		arg_4_0.contextData.storyNodeID = nil

		local var_4_1 = arg_4_0.viewParent

		var_2.WarpToStoryNode(var_4_1, var_4_0)
	else
		arg_4_0:OpenGroupLayer()
	end

	return true
end

function var_0_1.OnBackward(arg_5_0)
	return arg_5_0:Backward()
end

function var_0_1.OnReselected(arg_6_0)
	arg_6_0:Backward()

	return
end

function var_0_1.OnDeselected(arg_7_0)
	arg_7_0.contextData.recordGroup = nil

	var_0_1.super.OnDeselected(arg_7_0)

	return
end

function var_0_1.Hide(arg_8_0)
	arg_8_0:HideDetailLayer()
	arg_8_0:HideGroupLayer()
	var_0_1.super.Hide(arg_8_0)

	return
end

function var_0_1.GetDetailLayer(arg_9_0)
	if not arg_9_0.detailUI then
		WorldMediaCollectionRecordDetailLayer = var_1
		arg_9_0.detailUI = var_1.New(arg_9_0, arg_9_0._tf, arg_9_0.event, arg_9_0.contextData)

		local var_9_0 = arg_9_0.detailUI

		var_1.RegisterView(var_9_0, arg_9_0.viewComponent)

		local var_9_1 = arg_9_0.detailUI

		var_1.Load(var_9_1)

		local var_9_2 = arg_9_0.detailUI

		var_1.SetStoryMask(var_9_2, arg_9_0.memoryMask)
	end

	return arg_9_0.detailUI
end

function var_0_1.ShowRecordGroup(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:GetDetailLayer().buffer

	var_3.Show(var_10_0)

	local var_10_1 = var_2.buffer

	var_3.ShowRecordGroup(var_10_1, arg_10_1)
	arg_10_0:HideGroupLayer()

	return
end

function var_0_1.HideDetailLayer(arg_11_0)
	if not arg_11_0.detailUI then
		return
	end

	local var_11_0 = arg_11_0.detailUI.buffer

	var_1.Hide(var_11_0)

	return
end

function var_0_1.CloseDetailLayer(arg_12_0)
	if arg_12_0.detailUI then
		local var_12_0 = arg_12_0.detailUI

		var_1.Destroy(var_12_0)

		arg_12_0.detailUI = nil
	end

	return
end

function var_0_1.OpenGroupLayer(arg_13_0)
	local var_13_0 = arg_13_0:GetGroupLayer().buffer

	var_2.Show(var_13_0)

	local var_13_1 = var_1.buffer

	var_2.RecordFilter(var_13_1)
	arg_13_0:HideDetailLayer()

	return
end

function var_0_1.GetGroupLayer(arg_14_0)
	if not arg_14_0.groupUI then
		WorldMediaCollectionRecordGroupLayer = var_1
		arg_14_0.groupUI = var_1.New(arg_14_0, arg_14_0._tf, arg_14_0.event, arg_14_0.contextData)

		local var_14_0 = arg_14_0.groupUI

		var_1.RegisterView(var_14_0, arg_14_0.viewComponent)

		local var_14_1 = arg_14_0.groupUI

		var_1.Load(var_14_1)
	end

	return arg_14_0.groupUI
end

function var_0_1.HideGroupLayer(arg_15_0)
	if not arg_15_0.groupUI then
		return
	end

	local var_15_0 = arg_15_0.groupUI.buffer

	var_1.Hide(var_15_0)

	return
end

function var_0_1.CloseGroupLayer(arg_16_0)
	if arg_16_0.groupUI then
		local var_16_0 = arg_16_0.groupUI

		var_1.Destroy(var_16_0)

		arg_16_0.groupUI = nil
	end

	return
end

function var_0_1.OnDestroy(arg_17_0)
	arg_17_0:CloseDetailLayer()
	arg_17_0:CloseGroupLayer()
	var_0_1.super.OnDestroy(arg_17_0)

	return
end

return var_0_1
