class = var_0_10000

local var_0_0 = "WorldMediaCollectionMemoryLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".WorldMediaCollectionTemplateLayer"))

function var_0_1.getUIName(arg_1_0)
	return "WorldMediaCollectionMemoryUI"
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

function var_0_1.HideDetailLayer(arg_4_0)
	if not arg_4_0.detailUI then
		return
	end

	local var_4_0 = arg_4_0.detailUI.buffer

	var_1.Hide(var_4_0)

	return
end

function var_0_1.CloseDetailLayer(arg_5_0)
	if arg_5_0.detailUI then
		local var_5_0 = arg_5_0.detailUI

		var_1.Destroy(var_5_0)

		arg_5_0.detailUI = nil
	end

	return
end

function var_0_1.GetGroupLayer(arg_6_0)
	if not arg_6_0.groupUI then
		WorldMediaCollectionMemoryGroupLayer = var_1
		arg_6_0.groupUI = var_1.New(arg_6_0, arg_6_0._tf, arg_6_0.event, arg_6_0.contextData)

		local var_6_0 = arg_6_0.groupUI

		var_1.RegisterView(var_6_0, arg_6_0)

		local var_6_1 = arg_6_0.groupUI

		var_1.Load(var_6_1)
	end

	return arg_6_0.groupUI
end

function var_0_1.HideGroupLayer(arg_7_0)
	if not arg_7_0.groupUI then
		return
	end

	local var_7_0 = arg_7_0.groupUI.buffer

	var_1.Hide(var_7_0)

	return
end

function var_0_1.CloseGroupLayer(arg_8_0)
	if arg_8_0.groupUI then
		local var_8_0 = arg_8_0.groupUI

		var_1.Destroy(var_8_0)

		arg_8_0.groupUI = nil
	end

	return
end

function var_0_1.SwitchBetweenGroupsAndItems(arg_9_0, arg_9_1)
	if arg_9_0.groupUI then
		local var_9_0 = arg_9_0.groupUI.buffer

		var_2.SetActive(var_9_0, arg_9_1)
	end

	if arg_9_0.detailUI then
		local var_9_1 = arg_9_0.detailUI.buffer

		var_2.SetActive(var_9_1, not arg_9_1)
	end

	return
end

function var_0_1.OnSelected(arg_10_0)
	var_0_1.super.OnSelected(arg_10_0)

	getProxy = var_1
	ActivityProxy = var_2

	local var_10_0 = var_1(var_2)
	local var_10_1 = var_1.getActivityById

	ActivityConst = var_1_10004

	if var_10_1(var_10_0, var_1_10004.QIXI_ACTIVITY_ID) and not var_2:isEnd() then
		local var_10_2 = var_2
		local var_10_3 = var_2.getConfig(var_10_2, "config_data")

		_ = var_10_2

		local var_10_4 = var_4[#var_10_2.flatten(var_10_3)]

		getProxy = var_1_10006
		TaskProxy = var_1_10007

		local var_10_5 = var_1_10006(var_1_10007)

		if var_1_10006.getTaskById(var_10_5, var_10_4) and not var_7:isFinish() then
			pg = var_8

			local var_10_6 = var_8.NewStoryMgr.GetInstance()

			var_8.Play(var_10_6, "HOSHO8", function()
				local var_11_0 = arg_10_0
				local var_11_1 = var_0.emit

				CollectionScene = var_2_10002

				var_11_1(var_11_0, var_2_10002.ACTIVITY_OP, {
					cmd = 2,
					activity_id = var_0.id
				})

				return
			end, true)
		end
	end

	local var_10_7 = arg_10_0.contextData.memoryGroup
	local var_10_8 = arg_10_0.contextData

	var_10_8.memoryGroup = nil

	if var_10_7 then
		pg = var_10_8

		if var_10_8.memory_group[var_10_7] then
			local var_10_9 = arg_10_0
			local var_10_10 = arg_10_0.ShowSubMemories

			pg = var_1_10006

			var_10_10(var_10_9, var_1_10006.memory_group[var_10_7])

			goto label_10_0
		end
	end

	arg_10_0:MemoryFilter()
	arg_10_0:SwitchReddotMemory()

	::label_10_0::

	return
end

function var_0_1.OnReselected(arg_12_0)
	arg_12_0:Return2MemoryGroup()

	return
end

function var_0_1.OnDeselected(arg_13_0)
	arg_13_0.contextData.memoryGroup = nil

	var_0_1.super.OnDeselected(arg_13_0)

	return
end

function var_0_1.Hide(arg_14_0)
	arg_14_0:HideDetailLayer()
	arg_14_0:HideGroupLayer()
	var_0_1.super.Hide(arg_14_0)

	return
end

function var_0_1.OnBackward(arg_15_0)
	return arg_15_0:Return2MemoryGroup()
end

function var_0_1.SwitchMemoryFilter(arg_16_0, arg_16_1)
	if arg_16_1 == 1 then
		arg_16_0.memoryFilterIndex = {
			true,
			true,
			true
		}
	else
		ipairs = var_1_10002

		for iter_16_0 in var_1_10002(arg_16_0.memoryFilterIndex) do
			arg_16_0.memoryFilterIndex[iter_16_0] = arg_16_1 - 1 == iter_16_0
		end
	end

	return
end

function var_0_1.MemoryFilter(arg_17_0)
	local var_17_0 = arg_17_0:GetGroupLayer().buffer

	var_2.Show(var_17_0)

	local var_17_1 = var_1.buffer

	var_2.MemoryFilter(var_17_1)
	arg_17_0:HideDetailLayer()

	return
end

function var_0_1.SwitchReddotMemory(arg_18_0)
	local var_18_0 = arg_18_0:GetGroupLayer().buffer

	var_2.SwitchReddotMemory(var_18_0)

	return
end

function var_0_1.ShowSubMemories(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_0:GetDetailLayer().buffer

	var_5.Show(var_19_0)

	local var_19_1 = var_4.buffer

	var_5.ShowSubMemories(var_19_1, arg_19_1, arg_19_3)

	if not arg_19_2 then
		arg_19_0:HideGroupLayer()
	end

	return
end

function var_0_1.Return2MemoryGroup(arg_20_0)
	local var_20_0 = arg_20_0.contextData.memoryGroup
	local var_20_1 = arg_20_0:GetGroupLayer()

	if var_2.GetCurrentMode(var_20_1) == var_2.LINE_MODE then
		if not var_20_0 then
			var_2:SwitchStoryLineMode(var_2.FORM_MODE)
		else
			local var_20_2 = var_2.storyLineView

			var_3.TryPlayBGM(var_20_2)
		end
	elseif not var_20_0 then
		return
	end

	local var_20_3 = var_2.buffer

	var_3.Show(var_20_3)

	local var_20_4 = var_2.buffer

	var_3.Return2MemoryGroup(var_20_4)

	arg_20_0.contextData.memoryGroup = nil

	arg_20_0:HideDetailLayer()

	return true
end

function var_0_1.Return2Line(arg_21_0)
	return
end

function var_0_1.UpdateView(arg_22_0)
	local var_22_0

	if arg_22_0.contextData.memoryGroup then
		var_22_0 = arg_22_0.groupUI
	else
		var_22_0 = arg_22_0.detailUI
	end

	if not var_22_0 then
		return
	end

	local var_22_1 = var_22_0.buffer

	var_2.UpdateView(var_22_1)

	return
end

function var_0_1.WrapToStoryLine(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:GetGroupLayer()

	var_2.SwitchStoryLineMode(var_23_0, var_2.LINE_MODE)

	local var_23_1 = var_2.storyLineView

	var_3.ShowNodeDetail(var_23_1, arg_23_1)

	return
end

function var_0_1.OnDestroy(arg_24_0)
	arg_24_0:CloseDetailLayer()
	arg_24_0:CloseGroupLayer()
	var_0_1.super.OnDestroy(arg_24_0)

	return
end

return var_0_1
