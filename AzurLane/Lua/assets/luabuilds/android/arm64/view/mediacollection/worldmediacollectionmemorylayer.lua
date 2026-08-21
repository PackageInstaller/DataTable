local var_0_0 = class("WorldMediaCollectionMemoryLayer", import(".WorldMediaCollectionTemplateLayer"))

function var_0_0.getUIName(arg_1_0)
	return "WorldMediaCollectionMemoryUI"
end

function var_0_0.OnInit(arg_2_0)
	var_0_0.super.OnInit(arg_2_0)
	assert(arg_2_0.viewParent, "Need assign ViewParent for " .. arg_2_0.__cname)

	arg_2_0._top = arg_2_0._tf:Find("Top")
	arg_2_0.memoryMask = arg_2_0._top:Find("StoryMask")

	setActive(arg_2_0.memoryMask, false)

	return
end

function var_0_0.GetDetailLayer(arg_3_0)
	if not arg_3_0.detailUI then
		arg_3_0.detailUI = WorldMediaCollectionMemoryDetailLayer.New(arg_3_0, arg_3_0._tf, arg_3_0.event, arg_3_0.contextData)

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
	if not arg_6_0.groupUI then
		arg_6_0.groupUI = WorldMediaCollectionMemoryGroupLayer.New(arg_6_0, arg_6_0._tf, arg_6_0.event, arg_6_0.contextData)

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

function var_0_0.SwitchBetweenGroupsAndItems(arg_9_0, arg_9_1)
	if arg_9_0.groupUI then
		arg_9_0.groupUI.buffer:SetActive(arg_9_1)
	end

	if arg_9_0.detailUI then
		arg_9_0.detailUI.buffer:SetActive(not arg_9_1)
	end

	return
end

function var_0_0.OnSelected(arg_10_0)
	var_0_0.super.OnSelected(arg_10_0)

	local var_10_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.QIXI_ACTIVITY_ID)

	if var_10_0 and not var_10_0:isEnd() then
		local var_10_1 = _.flatten((var_10_0:getConfig("config_data")))
		local var_10_2 = getProxy(TaskProxy):getTaskById(var_10_1[#var_10_1])

		if var_10_2 and not var_10_2:isFinish() then
			pg.NewStoryMgr.GetInstance():Play("HOSHO8", function()
				arg_10_0:emit(CollectionScene.ACTIVITY_OP, {
					cmd = 2,
					activity_id = var_10_0.id
				})

				return
			end, true)
		end
	end

	local var_10_3 = arg_10_0.contextData.memoryGroup

	arg_10_0.contextData.memoryGroup = nil

	if var_10_3 and pg.memory_group[var_10_3] then
		arg_10_0:ShowSubMemories(pg.memory_group[var_10_3])
	else
		arg_10_0:MemoryFilter()
		arg_10_0:SwitchReddotMemory()
	end

	return
end

function var_0_0.OnReselected(arg_12_0)
	arg_12_0:Return2MemoryGroup()

	return
end

function var_0_0.OnDeselected(arg_13_0)
	arg_13_0.contextData.memoryGroup = nil

	var_0_0.super.OnDeselected(arg_13_0)

	return
end

function var_0_0.Hide(arg_14_0)
	arg_14_0:HideDetailLayer()
	arg_14_0:HideGroupLayer()
	var_0_0.super.Hide(arg_14_0)

	return
end

function var_0_0.OnBackward(arg_15_0)
	return arg_15_0:Return2MemoryGroup()
end

function var_0_0.SwitchMemoryFilter(arg_16_0, arg_16_1)
	if arg_16_1 == 1 then
		arg_16_0.memoryFilterIndex = {
			true,
			true,
			true
		}
	else
		for iter_16_0 in ipairs(arg_16_0.memoryFilterIndex) do
			arg_16_0.memoryFilterIndex[iter_16_0] = arg_16_1 - 1 == iter_16_0
		end
	end

	return
end

function var_0_0.MemoryFilter(arg_17_0)
	local var_17_0 = arg_17_0:GetGroupLayer()

	var_17_0.buffer:Show()
	var_17_0.buffer:MemoryFilter()
	arg_17_0:HideDetailLayer()

	return
end

function var_0_0.SwitchReddotMemory(arg_18_0)
	arg_18_0:GetGroupLayer().buffer:SwitchReddotMemory()

	return
end

function var_0_0.ShowSubMemories(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_0:GetDetailLayer()

	var_19_0.buffer:Show()
	var_19_0.buffer:ShowSubMemories(arg_19_1, arg_19_3)

	if not arg_19_2 then
		arg_19_0:HideGroupLayer()
	end

	return
end

function var_0_0.Return2MemoryGroup(arg_20_0)
	local var_20_0 = arg_20_0:GetGroupLayer()

	if var_20_0:GetCurrentMode() == var_20_0.LINE_MODE then
		if not arg_20_0.contextData.memoryGroup then
			var_20_0:SwitchStoryLineMode(var_20_0.FORM_MODE)
		else
			var_20_0.storyLineView:TryPlayBGM()
		end
	elseif not arg_20_0.contextData.memoryGroup then
		return
	end

	var_20_0.buffer:Show()
	var_20_0.buffer:Return2MemoryGroup()

	arg_20_0.contextData.memoryGroup = nil

	arg_20_0:HideDetailLayer()

	return true
end

function var_0_0.Return2Line(arg_21_0)
	return
end

function var_0_0.UpdateView(arg_22_0)
	local var_22_0 = arg_22_0.contextData.memoryGroup and arg_22_0.groupUI or arg_22_0.detailUI

	if not var_22_0 then
		return
	end

	var_22_0.buffer:UpdateView()

	return
end

function var_0_0.WrapToStoryLine(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:GetGroupLayer()

	var_23_0:SwitchStoryLineMode(var_23_0.LINE_MODE)
	var_23_0.storyLineView:ShowNodeDetail(arg_23_1)

	return
end

function var_0_0.OnDestroy(arg_24_0)
	arg_24_0:CloseDetailLayer()
	arg_24_0:CloseGroupLayer()
	var_0_0.super.OnDestroy(arg_24_0)

	return
end

return var_0_0
