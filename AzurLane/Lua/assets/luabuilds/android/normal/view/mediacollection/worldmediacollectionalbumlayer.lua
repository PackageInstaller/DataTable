class = var_0_10000

local var_0_0 = "WorldMediaCollectionAlbumLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".WorldMediaCollectionTemplateLayer"))

function var_0_1.getUIName(arg_1_0)
	return "WorldMediaCollectionAlbumUI"
end

function var_0_1.OnInit(arg_2_0)
	var_0_1.super.OnInit(arg_2_0)

	assert = var_1

	var_1(arg_2_0.viewParent, "Need assign ViewParent for " .. arg_2_0.__cname)

	local var_2_0 = arg_2_0._tf

	arg_2_0._top = var_1.Find(var_2_0, "Top")

	local var_2_1 = arg_2_0._top

	arg_2_0.memoryMask = var_1.Find(var_2_1, "StoryMask")
	setActive = var_1

	var_1(arg_2_0.memoryMask, false)

	return
end

function var_0_1.GetDetailLayer(arg_3_0)
	if not arg_3_0.detailUI then
		WorldMediaCollectionMemoryDetailLayer = var_1
		arg_3_0.detailUI = var_1.New(arg_3_0, arg_3_0._tf, arg_3_0.event, arg_3_0.contextData)

		local var_3_0 = arg_3_0.detailUI

		var_1.Load(var_3_0)

		local var_3_1 = arg_3_0.detailUI

		var_1.SetStoryMask(var_3_1, arg_3_0.memoryMask)
	end

	return arg_3_0.detailUI
end

function var_0_1.GetGroupLayer(arg_4_0)
	if not arg_4_0.groupUI then
		WorldMediaCollectionAlbumGroupLayer = var_1
		arg_4_0.groupUI = var_1.New(arg_4_0, arg_4_0._tf, arg_4_0.event, arg_4_0.contextData)

		local var_4_0 = arg_4_0.groupUI

		var_1.Load(var_4_0)
	end

	return arg_4_0.groupUI
end

function var_0_1.HideGroupLayer(arg_5_0)
	if not arg_5_0.groupUI then
		return
	end

	local var_5_0 = arg_5_0.groupUI.buffer

	var_1.Hide(var_5_0)

	return
end

function var_0_1.CloseGroupLayer(arg_6_0)
	if arg_6_0.groupUI then
		local var_6_0 = arg_6_0.groupUI

		var_1.Destroy(var_6_0)

		arg_6_0.groupUI = nil
	end

	return
end

function var_0_1.SwitchBetweenGroupsAndItems(arg_7_0, arg_7_1)
	if arg_7_0.groupUI then
		local var_7_0 = arg_7_0.groupUI.buffer

		var_2.SetActive(var_7_0, arg_7_1)
	end

	if arg_7_0.detailUI then
		local var_7_1 = arg_7_0.detailUI.buffer

		var_2.SetActive(var_7_1, not arg_7_1)
	end

	return
end

function var_0_1.OnSelected(arg_8_0)
	var_0_1.super.OnSelected(arg_8_0)

	getProxy = var_1
	ActivityProxy = var_2

	local var_8_0 = var_1(var_2)
	local var_8_1 = var_1.getActivityById

	ActivityConst = var_1_10004

	if var_8_1(var_8_0, var_1_10004.QIXI_ACTIVITY_ID) and not var_2:isEnd() then
		local var_8_2 = var_2
		local var_8_3 = var_2.getConfig(var_8_2, "config_data")

		_ = var_8_2

		local var_8_4 = var_4[#var_8_2.flatten(var_8_3)]

		getProxy = var_1_10006
		TaskProxy = var_1_10007

		local var_8_5 = var_1_10006(var_1_10007)

		if var_1_10006.getTaskById(var_8_5, var_8_4) and not var_7:isFinish() then
			pg = var_8

			local var_8_6 = var_8.NewStoryMgr.GetInstance()

			var_8.Play(var_8_6, "HOSHO8", function()
				local var_9_0 = arg_8_0
				local var_9_1 = var_0.emit

				CollectionScene = var_2_10002

				var_9_1(var_9_0, var_2_10002.ACTIVITY_OP, {
					cmd = 2,
					activity_id = var_0.id
				})

				return
			end, true)
		end
	end

	local var_8_7 = arg_8_0.contextData.memoryGroup
	local var_8_8 = arg_8_0.contextData

	var_8_8.memoryGroup = nil

	if var_8_7 then
		pg = var_8_8

		if var_8_8.memory_group[var_8_7] then
			local var_8_9 = arg_8_0
			local var_8_10 = arg_8_0.ShowSubMemories

			pg = var_1_10006

			var_8_10(var_8_9, var_1_10006.memory_group[var_8_7])

			goto label_8_0
		end
	end

	arg_8_0:MemoryFilter()
	arg_8_0:SwitchReddotMemory()

	::label_8_0::

	return
end

function var_0_1.OnReselected(arg_10_0)
	arg_10_0:Return2MemoryGroup()

	return
end

function var_0_1.OnDeselected(arg_11_0)
	arg_11_0.contextData.memoryGroup = nil

	var_0_1.super.OnDeselected(arg_11_0)

	return
end

function var_0_1.Hide(arg_12_0)
	arg_12_0:HideGroupLayer()
	var_0_1.super.Hide(arg_12_0)

	return
end

function var_0_1.OnBackward(arg_13_0)
	return arg_13_0:Return2MemoryGroup()
end

function var_0_1.SwitchMemoryFilter(arg_14_0, arg_14_1)
	if arg_14_1 == 1 then
		arg_14_0.memoryFilterIndex = {
			true,
			true,
			true
		}
	else
		ipairs = var_1_10002

		for iter_14_0 in var_1_10002(arg_14_0.memoryFilterIndex) do
			arg_14_0.memoryFilterIndex[iter_14_0] = arg_14_1 - 1 == iter_14_0
		end
	end

	return
end

function var_0_1.MemoryFilter(arg_15_0)
	local var_15_0 = arg_15_0:GetGroupLayer().buffer

	var_2.Show(var_15_0)

	return
end

function var_0_1.SwitchReddotMemory(arg_16_0)
	local var_16_0 = arg_16_0:GetGroupLayer().buffer

	var_2.SwitchReddotMemory(var_16_0)

	return
end

function var_0_1.ShowAlbum(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1.ui_prefab.scene

	_G = var_1_10003

	local var_17_1 = var_1_10003[var_17_0]
	local var_17_2 = arg_17_1.ui_prefab.mediator

	_G = var_1_10005

	local var_17_3 = var_1_10005[var_17_2]

	Context = var_1_10006

	local var_17_4 = var_1_10006.New({
		mediator = var_17_3,
		viewComponent = var_17_1
	})
	local var_17_5 = arg_17_0.viewParent
	local var_17_6 = var_7.emit

	WorldMediaCollectionMediator = var_1_10009

	var_17_6(var_17_5, var_1_10009.ON_ADD_SUBLAYER, var_17_4)

	return
end

function var_0_1.Return2MemoryGroup(arg_18_0)
	if not arg_18_0.contextData.memoryGroup then
		return
	end

	local var_18_0 = arg_18_0:GetGroupLayer().buffer

	var_3.Show(var_18_0)

	local var_18_1 = var_2.buffer

	var_3.Return2MemoryGroup(var_18_1)

	arg_18_0.contextData.memoryGroup = nil

	return true
end

function var_0_1.UpdateView(arg_19_0)
	local var_19_0

	if arg_19_0.contextData.memoryGroup then
		var_19_0 = arg_19_0.groupUI
	else
		var_19_0 = arg_19_0.detailUI
	end

	if not var_19_0 then
		return
	end

	local var_19_1 = var_19_0.buffer

	var_2.UpdateView(var_19_1)

	return
end

function var_0_1.OnDestroy(arg_20_0)
	arg_20_0:CloseGroupLayer()
	var_0_1.super.OnDestroy(arg_20_0)

	return
end

return var_0_1
