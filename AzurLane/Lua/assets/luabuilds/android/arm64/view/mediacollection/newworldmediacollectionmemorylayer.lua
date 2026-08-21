local var_0_0 = class("NewWorldMediaCollectionMemoryLayer", import(".WorldMediaCollectionTemplateLayer"))

function var_0_0.getUIName(arg_1_0)
	return "NewWorldMediaCollectionMemoryUI"
end

function var_0_0.OnInit(arg_2_0)
	var_0_0.super.OnInit(arg_2_0)
	assert(arg_2_0.viewParent, "Need assign ViewParent for " .. arg_2_0.__cname)

	arg_2_0._top = arg_2_0._tf:Find("Top")
	arg_2_0.memoryMask = arg_2_0._top:Find("StoryMask")

	setActive(arg_2_0.memoryMask, false)

	arg_2_0.Layer = -1

	return
end

function var_0_0.GetDetailLayer(arg_3_0)
	setActive(arg_3_0._top:Find("RoleTitle"), true)
	setActive(arg_3_0._top:Find("HonorTitle"), false)

	if not arg_3_0.detailUI then
		arg_3_0.detailUI = NewWorldMediaCollectionMemoryDetailLayer.New(arg_3_0, arg_3_0._tf, arg_3_0.event, arg_3_0.contextData)

		arg_3_0.detailUI:Load()
		arg_3_0.detailUI:SetStoryMask(arg_3_0.memoryMask)
	end

	return arg_3_0.detailUI
end

function var_0_0.HideDetailLayer(arg_4_0)
	if not arg_4_0.detailUI then
		return
	end

	arg_4_0.detailUI.buffer:Hide()

	return
end

function var_0_0.CloseDetailLayer(arg_5_0)
	if arg_5_0.detailUI then
		arg_5_0.detailUI:Destroy()

		arg_5_0.detailUI = nil
	end

	return
end

function var_0_0.GetGroupLayer(arg_6_0)
	setActive(arg_6_0._top:Find("RoleTitle"), true)
	setActive(arg_6_0._top:Find("HonorTitle"), false)

	if not arg_6_0.groupUI then
		arg_6_0.groupUI = NewWorldMediaCollectionMemoryGroupLayer.New(arg_6_0, arg_6_0._tf, arg_6_0.event, arg_6_0.contextData)

		arg_6_0.groupUI:RegisterView(arg_6_0)
		arg_6_0.groupUI:Load()
	end

	return arg_6_0.groupUI
end

function var_0_0.HideGroupLayer(arg_7_0)
	if not arg_7_0.groupUI then
		return
	end

	arg_7_0.groupUI.buffer:Hide()

	return
end

function var_0_0.CloseGroupLayer(arg_8_0)
	if arg_8_0.groupUI then
		arg_8_0.groupUI:Destroy()

		arg_8_0.groupUI = nil
	end

	return
end

function var_0_0.GetHallGloryLayer(arg_9_0)
	setActive(arg_9_0._top:Find("RoleTitle"), false)
	setActive(arg_9_0._top:Find("HonorTitle"), true)

	if not arg_9_0.HallGloryUI then
		arg_9_0.HallGloryUI = HallGloryLayer.New(arg_9_0, arg_9_0._tf, arg_9_0.event, arg_9_0.contextData)

		arg_9_0.HallGloryUI:SetStoryMask(arg_9_0.memoryMask)
		arg_9_0.HallGloryUI:Load()
	end

	return arg_9_0.HallGloryUI
end

function var_0_0.HideHallGloryLayer(arg_10_0)
	if not arg_10_0.HallGloryUI then
		return
	end

	arg_10_0.HallGloryUI.buffer:Hide()

	return
end

function var_0_0.CloseHallGloryLayer(arg_11_0)
	if arg_11_0.HallGloryUI then
		arg_11_0.HallGloryUI:Destroy()

		arg_11_0.HallGloryUI = nil
	end

	return
end

function var_0_0.SwitchBetweenGroupsAndItems(arg_12_0, arg_12_1)
	if arg_12_0.groupUI then
		arg_12_0.groupUI.buffer:SetActive(arg_12_1)
	end

	if arg_12_0.detailUI then
		arg_12_0.detailUI.buffer:SetActive(not arg_12_1)
	end

	return
end

function var_0_0.OnSelected(arg_13_0)
	var_0_0.super.OnSelected(arg_13_0)

	local var_13_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.QIXI_ACTIVITY_ID)

	if var_13_0 and not var_13_0:isEnd() then
		local var_13_1 = _.flatten((var_13_0:getConfig("config_data")))
		local var_13_2 = getProxy(TaskProxy):getTaskById(var_13_1[#var_13_1])

		if var_13_2 and not var_13_2:isFinish() then
			pg.NewStoryMgr.GetInstance():Play("HOSHO8", function()
				arg_13_0:emit(CollectionScene.ACTIVITY_OP, {
					cmd = 2,
					activity_id = var_13_0.id
				})

				return
			end, true)
		end
	end

	local var_13_3 = arg_13_0.contextData.memoryGroup

	arg_13_0.contextData.memoryGroup = nil

	if var_13_3 and pg.memory_group[var_13_3] then
		arg_13_0:ShowSubMemories(pg.memory_group[var_13_3])
	else
		arg_13_0:MemoryFilter()
		arg_13_0:SwitchReddotMemory()
	end

	return
end

function var_0_0.OnReselected(arg_15_0)
	arg_15_0:Return2MemoryGroup()

	return
end

function var_0_0.OnDeselected(arg_16_0)
	arg_16_0.contextData.memoryGroup = nil

	var_0_0.super.OnDeselected(arg_16_0)

	return
end

function var_0_0.Hide(arg_17_0)
	arg_17_0:HideDetailLayer()
	arg_17_0:HideGroupLayer()
	arg_17_0:HideHallGloryLayer()
	var_0_0.super.Hide(arg_17_0)

	return
end

function var_0_0.OnBackward(arg_18_0)
	return arg_18_0:Return2MemoryGroup()
end

function var_0_0.SwitchMemoryFilter(arg_19_0, arg_19_1)
	if arg_19_1 == 1 then
		arg_19_0.memoryFilterIndex = {
			true,
			true,
			true
		}
	else
		for iter_19_0 in ipairs(arg_19_0.memoryFilterIndex) do
			arg_19_0.memoryFilterIndex[iter_19_0] = arg_19_1 - 1 == iter_19_0
		end
	end

	return
end

function var_0_0.MemoryFilter(arg_20_0)
	local var_20_0 = arg_20_0:GetGroupLayer()

	var_20_0.buffer:Show()
	var_20_0.buffer:MemoryFilter()
	arg_20_0:HideDetailLayer()

	return
end

function var_0_0.SwitchReddotMemory(arg_21_0)
	arg_21_0:GetGroupLayer().buffer:SwitchReddotMemory()

	return
end

function var_0_0.ShowSubMemories(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = arg_22_0:GetDetailLayer()

	var_22_0.buffer:Show()
	var_22_0.buffer:ShowSubMemories(arg_22_1, arg_22_3)

	if not arg_22_2 then
		arg_22_0:HideGroupLayer()
		arg_22_0:HideHallGloryLayer()
	end

	return
end

function var_0_0.ShowHallGloryLayer(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_0:GetHallGloryLayer().buffer:Show()

	if not arg_23_2 then
		arg_23_0:HideGroupLayer()
	end

	return
end

function var_0_0.Return2MemoryGroup(arg_24_0)
	local var_24_1 = arg_24_0:GetGroupLayer()

	if var_24_1.index == -1 then
		return
	elseif var_24_1.index == 1 then
		var_24_1.buffer:Show()
		var_24_1.buffer:Return2MemoryGroup()
		arg_24_0:HideDetailLayer()
	elseif var_24_1.index == 2 then
		var_24_1.buffer:Show()
		var_24_1.buffer:Return2MemoryGroup()
		arg_24_0:HideHallGloryLayer()
	end

	return true
end

function var_0_0.Return2Line(arg_25_0)
	return
end

function var_0_0.UpdateView(arg_26_0)
	local var_26_0 = arg_26_0.contextData.memoryGroup and arg_26_0.groupUI or arg_26_0.detailUI

	if not var_26_0 then
		return
	end

	var_26_0.buffer:UpdateView()

	return
end

function var_0_0.WrapToStoryLine(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:GetGroupLayer()

	var_27_0:SwitchStoryLineMode(var_27_0.LINE_MODE)
	var_27_0.storyLineView:ShowNodeDetail(arg_27_1)

	return
end

function var_0_0.OnDestroy(arg_28_0)
	arg_28_0:CloseDetailLayer()
	arg_28_0:CloseGroupLayer()
	var_0_0.super.OnDestroy(arg_28_0)

	return
end

return var_0_0
