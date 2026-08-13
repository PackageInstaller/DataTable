class = var_0_10000

local var_0_0 = "IslandDrawAwardListWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("Mod.Island.View.page.msgbox.window.IslandBaseMsgboxWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandDrawAwardListMsgBox"
end

function var_0_1.OnLoaded(arg_2_0)
	return
end

function var_0_1.OnInit(arg_3_0)
	setText = var_1_10001

	local var_3_0 = arg_3_0.rtTitle

	i18n = var_1_10003

	var_1_10001(var_3_0, var_1_10003("island_draw_S_order_title"))

	onButton = var_1_10001

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.btnClose

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_3_1, var_3_2, var_3_3, var_1_10005)

	UIItemList = var_1_10001
	arg_3_0.toggleList = var_1_10001.New(arg_3_0.rtToggles, arg_3_0.rtToggleTpl)

	local var_3_4 = arg_3_0.toggleList

	var_1.make(var_3_4, function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			unpack = var_3

			local var_5_0, var_5_1 = var_3(arg_3_0.countAwardList[arg_5_1])

			arg_5_2.name = var_5_0
			pg = var_2_10005

			local var_5_2 = var_2_10005.island_draw_reward[var_5_0]

			Drop = var_2_10006

			local var_5_3 = var_2_10006.New({
				type = var_5_2.drop_type,
				id = var_5_2.drop_id
			})

			IslandShopDrawAwardPage = var_7

			var_7.ShowDropInfo(var_5_3, arg_5_2:Find("mask/Image"))

			setScrollText = var_7

			var_7(arg_5_2:Find("name/Text"), var_5_3:getName())

			setText = var_7

			local var_5_4 = arg_5_2
			local var_5_5 = arg_5_2.Find(var_5_4, "got/got/Text")

			i18n = var_5_4

			var_7(var_5_5, var_5_4("island_draw_get"))

			setActive = var_7

			var_7(arg_5_2:Find("got"), not var_5_1)

			local var_5_6 = arg_3_0

			var_7.detachOnCardButton(var_5_6, arg_5_2)

			if var_5_1 then
				local var_5_7 = arg_3_0

				var_7.attachOnCardButton(var_5_7, arg_5_2)
			end
		end

		return
	end)

	UIItemList = var_1
	arg_3_0.marksList = var_1.New(arg_3_0.rtMarks, arg_3_0.rtMakrsTpl)

	local var_3_5 = arg_3_0.marksList

	var_1.make(var_3_5, function(arg_6_0, arg_6_1, arg_6_2)
		arg_6_1 = arg_6_1 + 1
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			unpack = var_3

			local var_6_0, var_6_1 = var_3(arg_3_0.countAwardList[arg_6_1])

			setActive = var_2_10005

			var_2_10005(arg_6_2:Find("mark"), var_6_1)

			setText = var_2_10005

			var_2_10005(arg_6_2:Find("mark/Text"), arg_6_1)
		end

		return
	end)

	setText = var_1

	local var_3_6 = arg_3_0.btnConfirm
	local var_3_7 = var_2.Find(var_3_6, "Text")

	i18n = var_3_6

	var_1(var_3_7, var_3_6("word_ok"))

	onButton = var_1

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0.btnConfirm

	local function var_3_10()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.emit

		IslandMediator = var_2_10002

		local var_7_2 = var_2_10002.DRAW_AWARD_OPERATION
		local var_7_3 = {
			op = "set_list",
			activity_id = arg_3_0.activity.id
		}

		underscore = var_4

		local var_7_4 = var_4(arg_3_0.countAwardList)
		local var_7_5 = var_4.chain(var_7_4)
		local var_7_6 = var_4.filter(var_7_5, function(arg_8_0)
			return arg_8_0[2]
		end)
		local var_7_7 = var_4.map(var_7_6, function(arg_9_0)
			return arg_9_0[1]
		end)

		var_7_3.list = var_4.value(var_7_7)

		var_7_1(var_7_0, var_7_2, var_7_3)

		local var_7_8 = arg_3_0

		var_0.Hide(var_7_8)

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_3_8, var_3_9, var_3_10, var_1_10005)

	return
end

function var_0_1.detachOnCardButton(arg_10_0, arg_10_1)
	GetOrAddComponent = var_1_10002

	local var_10_0 = var_1_10002(arg_10_1, "EventTriggerListener")

	var_2.RemovePointClickFunc(var_10_0)
	var_2:RemoveBeginDragFunc()
	var_2:RemoveDragFunc()
	var_2:RemoveDragEndFunc()

	return
end

function var_0_1.attachOnCardButton(arg_11_0, arg_11_1)
	GetOrAddComponent = var_1_10002

	local var_11_0 = var_1_10002(arg_11_1, "EventTriggerListener")
	local var_11_1 = arg_11_1.parent
	local var_11_2 = {}

	var_11_0:AddBeginDragFunc(function()
		if arg_11_0.carddrag then
			return
		end

		arg_11_0._currentDragDelegate = var_11_0
		arg_11_0.carddrag = arg_11_1

		for iter_12_0 = 1, arg_11_0.count do
			local var_12_0 = var_11_2
			local var_12_1 = var_11_1

			var_12_0[iter_12_0] = var_5.GetChild(var_12_1, iter_12_0 - 1).localPosition.x
		end

		local var_12_2 = arg_11_0
		local var_12_3 = arg_11_1

		var_12_2.before = var_1.GetSiblingIndex(var_12_3) + 1
		arg_11_0.after = arg_11_0.before

		local var_12_4 = arg_11_0

		cloneTplTo = var_1
		var_12_4.copyCard = var_1(arg_11_1, var_11_1, "copy")

		local var_12_5 = arg_11_0.copyCard

		var_0.SetSiblingIndex(var_12_5, arg_11_0.before - 1)

		GetOrAddComponent = var_0

		local var_12_6 = arg_11_0.copyCard

		typeof = var_2
		CanvasGroup = var_3

		local var_12_7 = var_0(var_12_6, var_2(var_3))

		var_12_7.alpha = 0
		GetOrAddComponent = var_12_7

		local var_12_8 = arg_11_1

		typeof = var_2
		LayoutElement = var_3
		var_12_7(var_12_8, var_2(var_3)).ignoreLayout = true

		local var_12_9 = arg_11_1

		var_0.SetAsLastSibling(var_12_9)

		LeanTween = var_0

		local var_12_10 = var_0.scale
		local var_12_11 = arg_11_1

		Vector3 = var_2

		var_12_10(var_12_11, var_2(1.1, 1.1, 1), 0.3)

		return
	end)
	var_11_0:AddDragFunc(function(arg_13_0, arg_13_1)
		if arg_11_0.carddrag ~= arg_11_1 then
			return
		end

		local var_13_0 = arg_11_1.localPosition

		math = var_3

		local var_13_1 = var_3.clamp
		local var_13_2 = arg_11_0

		var_13_0.x = var_13_1(var_4.change2ScrPos(var_13_2, var_11_1, arg_13_1.position).x, var_11_2[1], var_11_2[#var_11_2])
		arg_11_1.localPosition = var_13_0

		local var_13_3 = 1

		ipairs = var_4

		for iter_13_0, iter_13_1 in var_4(var_11_2) do
			if not var_11_2[iter_13_0 + 1] or var_13_0.x < (iter_13_1 + var_11_2[iter_13_0 + 1]) / 2 then
				var_13_3 = iter_13_0

				break
			end
		end

		if var_13_3 ~= arg_11_0.after then
			arg_11_0.after = var_13_3

			local var_13_4 = arg_11_0.copyCard

			var_4.SetSiblingIndex(var_13_4, arg_11_0.after - 1)
		end

		return
	end)
	var_11_0:AddDragEndFunc(function(arg_14_0, arg_14_1)
		if arg_11_0.carddrag ~= arg_11_1 then
			return
		end

		local var_14_0 = arg_11_0._forceDropCharacter

		arg_11_0._forceDropCharacter = nil
		arg_11_0._currentDragDelegate = nil
		var_11_0.enabled = false

		local var_14_1 = {}

		table = var_4

		var_4.insert(var_14_1, function(arg_15_0)
			local var_15_0

			if var_14_0 then
				var_15_0 = arg_11_1
				Vector3 = var_3_10002
				var_15_0.localScale = var_3_10002(1, 1, 1)

				arg_15_0()
			else
				parallelAsync = var_15_0

				var_15_0({
					function(arg_16_0)
						math = var_4_10001

						local var_16_0 = var_4_10001.min

						math = var_4_10002

						local var_16_1 = var_16_0(var_4_10002.abs(arg_11_1.localPosition.x - var_11_2[arg_11_0.after]) / 200, 1) * 0.3

						LeanTween = var_2

						local var_16_2 = var_2.moveLocalX(arg_11_1.gameObject, var_11_2[arg_11_0.after], var_16_1)
						local var_16_3 = var_2.setEase

						LeanTweenType = var_4

						local var_16_4 = var_16_3(var_16_2, var_4.easeOutCubic)
						local var_16_5 = var_2.setOnComplete

						System = var_4

						var_16_5(var_16_4, var_4.Action(arg_16_0))

						return
					end,
					function(arg_17_0)
						LeanTween = var_4_10001

						local var_17_0 = var_4_10001.scale
						local var_17_1 = arg_11_1

						Vector3 = var_4_10003

						local var_17_2 = var_17_0(var_17_1, var_4_10003(1, 1, 1), 0.3)
						local var_17_3 = var_1.setOnComplete

						System = var_3

						var_17_3(var_17_2, var_3.Action(arg_17_0))

						return
					end
				}, arg_15_0)
			end

			return
		end)

		seriesAsync = var_4

		var_4(var_14_1, function()
			Destroy = var_3_10000

			var_3_10000(arg_11_0.copyCard)

			arg_11_0.copyCard = nil

			local var_18_0 = arg_11_1

			var_0.SetSiblingIndex(var_18_0, arg_11_0.after - 1)

			GetOrAddComponent = var_0

			local var_18_1 = arg_11_1

			typeof = var_2
			LayoutElement = var_3_10003

			local var_18_2 = var_0(var_18_1, var_2(var_3_10003))

			var_18_2.ignoreLayout = false
			table = var_18_2

			local var_18_3 = var_18_2.insert
			local var_18_4 = arg_11_0.countAwardList
			local var_18_5 = arg_11_0.after

			table = var_3_10003

			var_18_3(var_18_4, var_18_5, var_3_10003.remove(arg_11_0.countAwardList, arg_11_0.before))

			arg_11_0.before = nil
			arg_11_0.after = nil
			var_11_0.enabled = true
			arg_11_0.carddrag = nil

			return
		end)

		return
	end)

	return
end

function var_0_1.ForceDropChar(arg_19_0)
	if arg_19_0._currentDragDelegate then
		arg_19_0._forceDropCharacter = true
		LuaHelper = var_1

		var_1.triggerEndDrag(arg_19_0._currentDragDelegate)
	end

	return
end

function var_0_1.change2ScrPos(arg_20_0, arg_20_1, arg_20_2)
	pg = var_1_10003

	local var_20_0 = var_1_10003.UIMgr.GetInstance().overlayCameraComp

	LuaHelper = var_1_10004

	return (var_1_10004.ScreenToLocal(arg_20_1, arg_20_2, var_20_0))
end

function var_0_1.OnShow(arg_21_0)
	var_0_1.super.OnShow(arg_21_0)
	arg_21_0:UpdateActivity(arg_21_0.settings.activity)

	return
end

function var_0_1.UpdateActivity(arg_22_0, arg_22_1)
	arg_22_0.activity = arg_22_1
	arg_22_0.countAwardList = arg_22_1:GetList()
	mergeSort = var_2

	local var_22_0 = arg_22_0.countAwardList

	CompareFuncs = var_1_10004

	var_2(var_22_0, var_1_10004({
		function(arg_23_0)
			return arg_23_0[2] and 0 or 1
		end
	}, true))

	underscore = var_2
	arg_22_0.count = #var_2.filter(arg_22_0.countAwardList, function(arg_24_0)
		return arg_24_0[2]
	end)

	local var_22_1 = arg_22_0.toggleList

	var_2.align(var_22_1, #arg_22_0.countAwardList)

	local var_22_2 = arg_22_0.marksList

	var_2.align(var_22_2, #arg_22_0.countAwardList)

	setText = var_2

	local var_22_3 = arg_22_0.rtCountWord

	i18n = var_4

	var_2(var_22_3, var_4("island_draw_S_order"))

	return
end

return var_0_1
