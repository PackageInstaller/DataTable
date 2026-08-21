local var_0_0 = class("WorldMediaCollectionAlbumLayer", import(".WorldMediaCollectionTemplateLayer"))

function var_0_0.getUIName(arg_1_0)
	return "WorldMediaCollectionAlbumUI"
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

function var_0_0.GetGroupLayer(arg_4_0)
	if not arg_4_0.groupUI then
		arg_4_0.groupUI = WorldMediaCollectionAlbumGroupLayer.New(arg_4_0, arg_4_0._tf, arg_4_0.event, arg_4_0.contextData)

		arg_4_0.groupUI:Load()
	end

	return arg_4_0.groupUI
end

function var_0_0.HideGroupLayer(arg_5_0)
	if not arg_5_0.groupUI then
		return
	end

	arg_5_0.groupUI.buffer:Hide()

	return
end

function var_0_0.CloseGroupLayer(arg_6_0)
	if arg_6_0.groupUI then
		arg_6_0.groupUI:Destroy()

		arg_6_0.groupUI = nil
	end

	return
end

function var_0_0.SwitchBetweenGroupsAndItems(arg_7_0, arg_7_1)
	if arg_7_0.groupUI then
		arg_7_0.groupUI.buffer:SetActive(arg_7_1)
	end

	if arg_7_0.detailUI then
		arg_7_0.detailUI.buffer:SetActive(not arg_7_1)
	end

	return
end

function var_0_0.OnSelected(arg_8_0)
	var_0_0.super.OnSelected(arg_8_0)

	local var_8_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.QIXI_ACTIVITY_ID)

	if var_8_0 and not var_8_0:isEnd() then
		local var_8_1 = _.flatten((var_8_0:getConfig("config_data")))
		local var_8_2 = getProxy(TaskProxy):getTaskById(var_8_1[#var_8_1])

		if var_8_2 and not var_8_2:isFinish() then
			pg.NewStoryMgr.GetInstance():Play("HOSHO8", function()
				arg_8_0:emit(CollectionScene.ACTIVITY_OP, {
					cmd = 2,
					activity_id = var_8_0.id
				})

				return
			end, true)
		end
	end

	local var_8_3 = arg_8_0.contextData.memoryGroup

	arg_8_0.contextData.memoryGroup = nil

	if var_8_3 and pg.memory_group[var_8_3] then
		arg_8_0:ShowSubMemories(pg.memory_group[var_8_3])
	else
		arg_8_0:MemoryFilter()
		arg_8_0:SwitchReddotMemory()
	end

	return
end

function var_0_0.OnReselected(arg_10_0)
	arg_10_0:Return2MemoryGroup()

	return
end

function var_0_0.OnDeselected(arg_11_0)
	arg_11_0.contextData.memoryGroup = nil

	var_0_0.super.OnDeselected(arg_11_0)

	return
end

function var_0_0.Hide(arg_12_0)
	arg_12_0:HideGroupLayer()
	var_0_0.super.Hide(arg_12_0)

	return
end

function var_0_0.OnBackward(arg_13_0)
	return arg_13_0:Return2MemoryGroup()
end

function var_0_0.SwitchMemoryFilter(arg_14_0, arg_14_1)
	if arg_14_1 == 1 then
		arg_14_0.memoryFilterIndex = {
			true,
			true,
			true
		}
	else
		for iter_14_0 in ipairs(arg_14_0.memoryFilterIndex) do
			arg_14_0.memoryFilterIndex[iter_14_0] = arg_14_1 - 1 == iter_14_0
		end
	end

	return
end

function var_0_0.MemoryFilter(arg_15_0)
	arg_15_0:GetGroupLayer().buffer:Show()

	return
end

function var_0_0.SwitchReddotMemory(arg_16_0)
	arg_16_0:GetGroupLayer().buffer:SwitchReddotMemory()

	return
end

function var_0_0.ShowAlbum(arg_17_0, arg_17_1)
	arg_17_0.viewParent:emit(WorldMediaCollectionMediator.ON_ADD_SUBLAYER, (Context.New({
		mediator = _G[arg_17_1.ui_prefab.mediator],
		viewComponent = _G[arg_17_1.ui_prefab.scene]
	})))

	return
end

function var_0_0.Return2MemoryGroup(arg_18_0)
	if not arg_18_0.contextData.memoryGroup then
		return
	end

	local var_18_0 = arg_18_0:GetGroupLayer()

	var_18_0.buffer:Show()
	var_18_0.buffer:Return2MemoryGroup()

	arg_18_0.contextData.memoryGroup = nil

	return true
end

function var_0_0.UpdateView(arg_19_0)
	local var_19_0 = arg_19_0.contextData.memoryGroup and arg_19_0.groupUI or arg_19_0.detailUI

	if not var_19_0 then
		return
	end

	var_19_0.buffer:UpdateView()

	return
end

function var_0_0.OnDestroy(arg_20_0)
	arg_20_0:CloseGroupLayer()
	var_0_0.super.OnDestroy(arg_20_0)

	return
end

return var_0_0
