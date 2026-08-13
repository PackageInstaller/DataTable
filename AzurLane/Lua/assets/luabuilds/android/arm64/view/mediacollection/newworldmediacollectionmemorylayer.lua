class = var_0_10000

local var_0_0 = "NewWorldMediaCollectionMemoryLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".WorldMediaCollectionTemplateLayer"))

function var_0_1.getUIName(arg_1_0)
	return "NewWorldMediaCollectionMemoryUI"
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

	arg_2_0.Layer = -1

	return
end

function var_0_1.GetDetailLayer(arg_3_0)
	setActive = var_1_10001

	local var_3_0 = arg_3_0._top

	var_1_10001(var_3.Find(var_3_0, "RoleTitle"), true)

	setActive = var_1_10001

	local var_3_1 = arg_3_0._top

	var_1_10001(var_3.Find(var_3_1, "HonorTitle"), false)

	if not arg_3_0.detailUI then
		NewWorldMediaCollectionMemoryDetailLayer = var_1
		arg_3_0.detailUI = var_1.New(arg_3_0, arg_3_0._tf, arg_3_0.event, arg_3_0.contextData)

		local var_3_2 = arg_3_0.detailUI

		var_1.Load(var_3_2)

		local var_3_3 = arg_3_0.detailUI

		var_1.SetStoryMask(var_3_3, arg_3_0.memoryMask)
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
	setActive = var_1_10001

	local var_6_0 = arg_6_0._top

	var_1_10001(var_3.Find(var_6_0, "RoleTitle"), true)

	setActive = var_1_10001

	local var_6_1 = arg_6_0._top

	var_1_10001(var_3.Find(var_6_1, "HonorTitle"), false)

	if not arg_6_0.groupUI then
		NewWorldMediaCollectionMemoryGroupLayer = var_1
		arg_6_0.groupUI = var_1.New(arg_6_0, arg_6_0._tf, arg_6_0.event, arg_6_0.contextData)

		local var_6_2 = arg_6_0.groupUI

		var_1.RegisterView(var_6_2, arg_6_0)

		local var_6_3 = arg_6_0.groupUI

		var_1.Load(var_6_3)
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

function var_0_1.GetHallGloryLayer(arg_9_0)
	setActive = var_1_10001

	local var_9_0 = arg_9_0._top

	var_1_10001(var_3.Find(var_9_0, "RoleTitle"), false)

	setActive = var_1_10001

	local var_9_1 = arg_9_0._top

	var_1_10001(var_3.Find(var_9_1, "HonorTitle"), true)

	if not arg_9_0.HallGloryUI then
		HallGloryLayer = var_1
		arg_9_0.HallGloryUI = var_1.New(arg_9_0, arg_9_0._tf, arg_9_0.event, arg_9_0.contextData)

		local var_9_2 = arg_9_0.HallGloryUI

		var_1.SetStoryMask(var_9_2, arg_9_0.memoryMask)

		local var_9_3 = arg_9_0.HallGloryUI

		var_1.Load(var_9_3)
	end

	return arg_9_0.HallGloryUI
end

function var_0_1.HideHallGloryLayer(arg_10_0)
	if not arg_10_0.HallGloryUI then
		return
	end

	local var_10_0 = arg_10_0.HallGloryUI.buffer

	var_1.Hide(var_10_0)

	return
end

function var_0_1.CloseHallGloryLayer(arg_11_0)
	if arg_11_0.HallGloryUI then
		local var_11_0 = arg_11_0.HallGloryUI

		var_1.Destroy(var_11_0)

		arg_11_0.HallGloryUI = nil
	end

	return
end

function var_0_1.SwitchBetweenGroupsAndItems(arg_12_0, arg_12_1)
	if arg_12_0.groupUI then
		local var_12_0 = arg_12_0.groupUI.buffer

		var_2.SetActive(var_12_0, arg_12_1)
	end

	if arg_12_0.detailUI then
		local var_12_1 = arg_12_0.detailUI.buffer

		var_2.SetActive(var_12_1, not arg_12_1)
	end

	return
end

function var_0_1.OnSelected(arg_13_0)
	var_0_1.super.OnSelected(arg_13_0)

	getProxy = var_1
	ActivityProxy = var_3

	local var_13_0 = var_1(var_3)
	local var_13_1 = var_1.getActivityById

	ActivityConst = var_1_10005

	if var_13_1(var_13_0, var_1_10005.QIXI_ACTIVITY_ID) and not var_2:isEnd() then
		local var_13_2 = var_2:getConfig("config_data")

		_ = var_13_0

		local var_13_3 = var_4[#var_13_0.flatten(var_13_2)]

		getProxy = var_6
		TaskProxy = var_1_10008

		local var_13_4 = var_6(var_1_10008)

		if var_6.getTaskById(var_13_4, var_13_3) and not var_1_10007:isFinish() then
			pg = var_8

			local var_13_5 = var_8.NewStoryMgr.GetInstance()

			var_8.Play(var_13_5, "HOSHO8", function()
				local var_14_0 = arg_13_0
				local var_14_1 = var_0.emit

				CollectionScene = var_2_10003

				var_14_1(var_14_0, var_2_10003.ACTIVITY_OP, {
					cmd = 2,
					activity_id = var_0.id
				})

				return
			end, true)
		end
	end

	local var_13_6 = arg_13_0.contextData.memoryGroup
	local var_13_7 = arg_13_0.contextData

	var_13_7.memoryGroup = nil

	if var_13_6 then
		pg = var_13_7

		if var_13_7.memory_group[var_13_6] then
			local var_13_8 = arg_13_0
			local var_13_9 = arg_13_0.ShowSubMemories

			pg = var_1_10007

			var_13_9(var_13_8, var_1_10007.memory_group[var_13_6])

			goto label_13_0
		end
	end

	arg_13_0:MemoryFilter()
	arg_13_0:SwitchReddotMemory()

	::label_13_0::

	return
end

function var_0_1.OnReselected(arg_15_0)
	arg_15_0:Return2MemoryGroup()

	return
end

function var_0_1.OnDeselected(arg_16_0)
	arg_16_0.contextData.memoryGroup = nil

	var_0_1.super.OnDeselected(arg_16_0)

	return
end

function var_0_1.Hide(arg_17_0)
	arg_17_0:HideDetailLayer()
	arg_17_0:HideGroupLayer()
	arg_17_0:HideHallGloryLayer()
	var_0_1.super.Hide(arg_17_0)

	return
end

function var_0_1.OnBackward(arg_18_0)
	return arg_18_0:Return2MemoryGroup()
end

function var_0_1.SwitchMemoryFilter(arg_19_0, arg_19_1)
	if arg_19_1 == 1 then
		arg_19_0.memoryFilterIndex = {
			true,
			true,
			true
		}
	else
		ipairs = var_1_10002

		for iter_19_0 in var_1_10002(arg_19_0.memoryFilterIndex) do
			arg_19_0.memoryFilterIndex[iter_19_0] = arg_19_1 - 1 == iter_19_0
		end
	end

	return
end

function var_0_1.MemoryFilter(arg_20_0)
	local var_20_0 = arg_20_0:GetGroupLayer().buffer

	var_2.Show(var_20_0)

	local var_20_1 = var_1.buffer

	var_2.MemoryFilter(var_20_1)
	arg_20_0:HideDetailLayer()

	return
end

function var_0_1.SwitchReddotMemory(arg_21_0)
	local var_21_0 = arg_21_0:GetGroupLayer().buffer

	var_2.SwitchReddotMemory(var_21_0)

	return
end

function var_0_1.ShowSubMemories(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = arg_22_0:GetDetailLayer().buffer

	var_5.Show(var_22_0)

	local var_22_1 = var_4.buffer

	var_5.ShowSubMemories(var_22_1, arg_22_1, arg_22_3)

	if not arg_22_2 then
		arg_22_0:HideGroupLayer()
		arg_22_0:HideHallGloryLayer()
	end

	return
end

function var_0_1.ShowHallGloryLayer(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = arg_23_0:GetHallGloryLayer().buffer

	var_5.Show(var_23_0)

	if not arg_23_2 then
		arg_23_0:HideGroupLayer()
	end

	return
end

function var_0_1.Return2MemoryGroup(arg_24_0)
	local var_24_0 = arg_24_0.contextData.memoryGroup

	if arg_24_0:GetGroupLayer().index == -1 then
		return
	elseif var_2.index == 1 then
		local var_24_1 = var_2.buffer

		var_3.Show(var_24_1)

		local var_24_2 = var_2.buffer

		var_3.Return2MemoryGroup(var_24_2)
		arg_24_0:HideDetailLayer()
	elseif var_2.index == 2 then
		local var_24_3 = var_2.buffer

		var_3.Show(var_24_3)

		local var_24_4 = var_2.buffer

		var_3.Return2MemoryGroup(var_24_4)
		arg_24_0:HideHallGloryLayer()
	end

	return true
end

function var_0_1.Return2Line(arg_25_0)
	return
end

function var_0_1.UpdateView(arg_26_0)
	local var_26_0

	if arg_26_0.contextData.memoryGroup then
		var_26_0 = arg_26_0.groupUI
	else
		var_26_0 = arg_26_0.detailUI
	end

	if not var_26_0 then
		return
	end

	local var_26_1 = var_26_0.buffer

	var_2.UpdateView(var_26_1)

	return
end

function var_0_1.WrapToStoryLine(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:GetGroupLayer()

	var_2.SwitchStoryLineMode(var_27_0, var_2.LINE_MODE)

	local var_27_1 = var_2.storyLineView

	var_3.ShowNodeDetail(var_27_1, arg_27_1)

	return
end

function var_0_1.OnDestroy(arg_28_0)
	arg_28_0:CloseDetailLayer()
	arg_28_0:CloseGroupLayer()
	var_0_1.super.OnDestroy(arg_28_0)

	return
end

return var_0_1
