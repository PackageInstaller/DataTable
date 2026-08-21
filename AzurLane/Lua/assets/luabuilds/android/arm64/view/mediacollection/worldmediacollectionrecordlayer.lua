local var_0_0 = class("WorldMediaCollectionRecordLayer", import(".WorldMediaCollectionTemplateLayer"))

function var_0_0.getUIName(arg_1_0)
	return "WorldMediaCollectionRecordUI"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0._top = arg_2_0._tf:Find("Top")
	arg_2_0.memoryMask = arg_2_0._top:Find("StoryMask")

	return
end

function var_0_0.OnSelected(arg_3_0)
	var_0_0.super.OnSelected(arg_3_0)

	if arg_3_0.contextData.recordGroup then
		arg_3_0:ShowRecordGroup(arg_3_0.contextData.recordGroup)
	else
		arg_3_0:OpenGroupLayer()
	end

	return
end

function var_0_0.Backward(arg_4_0)
	if not arg_4_0.contextData.recordGroup then
		return
	end

	arg_4_0.contextData.recordGroup = nil

	if arg_4_0.contextData.storyNodeID then
		arg_4_0.contextData.storyNodeID = nil

		arg_4_0.viewParent:WarpToStoryNode(arg_4_0.contextData.storyNodeID)
	else
		arg_4_0:OpenGroupLayer()
	end

	return true
end

function var_0_0.OnBackward(arg_5_0)
	return arg_5_0:Backward()
end

function var_0_0.OnReselected(arg_6_0)
	arg_6_0:Backward()

	return
end

function var_0_0.OnDeselected(arg_7_0)
	arg_7_0.contextData.recordGroup = nil

	var_0_0.super.OnDeselected(arg_7_0)

	return
end

function var_0_0.Hide(arg_8_0)
	arg_8_0:HideDetailLayer()
	arg_8_0:HideGroupLayer()
	var_0_0.super.Hide(arg_8_0)

	return
end

function var_0_0.GetDetailLayer(arg_9_0)
	if not arg_9_0.detailUI then
		arg_9_0.detailUI = WorldMediaCollectionRecordDetailLayer.New(arg_9_0, arg_9_0._tf, arg_9_0.event, arg_9_0.contextData)

		arg_9_0.detailUI:RegisterView(arg_9_0.viewComponent)
		arg_9_0.detailUI:Load()
		arg_9_0.detailUI:SetStoryMask(arg_9_0.memoryMask)
	end

	return arg_9_0.detailUI
end

function var_0_0.ShowRecordGroup(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:GetDetailLayer()

	var_10_0.buffer:Show()
	var_10_0.buffer:ShowRecordGroup(arg_10_1)
	arg_10_0:HideGroupLayer()

	return
end

function var_0_0.HideDetailLayer(arg_11_0)
	if not arg_11_0.detailUI then
		return
	end

	arg_11_0.detailUI.buffer:Hide()

	return
end

function var_0_0.CloseDetailLayer(arg_12_0)
	if arg_12_0.detailUI then
		arg_12_0.detailUI:Destroy()

		arg_12_0.detailUI = nil
	end

	return
end

function var_0_0.OpenGroupLayer(arg_13_0)
	local var_13_0 = arg_13_0:GetGroupLayer()

	var_13_0.buffer:Show()
	var_13_0.buffer:RecordFilter()
	arg_13_0:HideDetailLayer()

	return
end

function var_0_0.GetGroupLayer(arg_14_0)
	if not arg_14_0.groupUI then
		arg_14_0.groupUI = WorldMediaCollectionRecordGroupLayer.New(arg_14_0, arg_14_0._tf, arg_14_0.event, arg_14_0.contextData)

		arg_14_0.groupUI:RegisterView(arg_14_0.viewComponent)
		arg_14_0.groupUI:Load()
	end

	return arg_14_0.groupUI
end

function var_0_0.HideGroupLayer(arg_15_0)
	if not arg_15_0.groupUI then
		return
	end

	arg_15_0.groupUI.buffer:Hide()

	return
end

function var_0_0.CloseGroupLayer(arg_16_0)
	if arg_16_0.groupUI then
		arg_16_0.groupUI:Destroy()

		arg_16_0.groupUI = nil
	end

	return
end

function var_0_0.OnDestroy(arg_17_0)
	arg_17_0:CloseDetailLayer()
	arg_17_0:CloseGroupLayer()
	var_0_0.super.OnDestroy(arg_17_0)

	return
end

return var_0_0
