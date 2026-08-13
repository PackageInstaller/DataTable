class = var_0_10000

local var_0_0 = "ClueGroupSingleView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

pg = var_0_0

local var_0_2 = var_0_0.activity_clue

pg = var_2

local var_0_3 = var_2.activity_clue_group
local var_0_4 = 0.6
local var_0_5 = 1

function var_0_1.getUIName(arg_1_0)
	return "ClueGroupSingleUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.clueGroupTf = var_1.Find(var_2_0, "clueGroup")
	setText = var_1

	local var_2_1 = arg_2_0.clueGroupTf
	local var_2_2 = var_2.Find(var_2_1, "goBtn/Text")

	i18n = var_2_1

	var_1(var_2_2, var_2_1("clue_task_goto"))

	setText = var_1

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_2.Find(var_2_3, "closeTip")

	i18n = var_2_3

	var_1(var_2_4, var_2_3("clue_close_tip"))

	arg_2_0.timerList = {}

	return
end

function var_0_1.didEnter(arg_3_0)
	ActivityConst = var_1_10001
	arg_3_0.activityId = var_1_10001.Valleyhospital_ACT_ID
	getProxy = var_1
	PlayerProxy = var_1_10002

	local var_3_0 = var_1(var_1_10002)

	arg_3_0.playerId = var_1.getRawData(var_3_0).id
	PlayerPrefs = var_1
	arg_3_0.investigatingGroupId = var_1.GetInt("investigatingGroupId_" .. arg_3_0.activityId .. "_" .. arg_3_0.playerId)
	getProxy = var_1
	TaskProxy = var_2
	arg_3_0.taskProxy = var_1(var_2)
	onButton = var_1

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0._tf
	local var_3_3 = var_3.Find(var_3_2, "mask")

	local function var_3_4()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_3_1, var_3_3, var_3_4, var_5)
	arg_3_0:SetClueGroup()

	pg = var_1

	local var_3_5 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_5, arg_3_0._tf)

	return
end

function var_0_1.SetClueGroup(arg_5_0)
	local var_5_0 = arg_5_0.contextData.clueGroupId
	local var_5_1 = arg_5_0.contextData.submitClueIds
	local var_5_2 = arg_5_0.clueGroupTf
	local var_5_3 = var_0_3[var_5_0]
	local var_5_4 = var_0_2.get_id_list_by_group[var_5_0]
	local var_5_5 = {
		var_0_2[var_5_4[1]],
		var_0_2[var_5_4[2]],
		var_0_2[var_5_4[3]]
	}
	local var_5_6 = arg_5_0.taskProxy
	local var_5_7 = var_7.getTaskVO

	tonumber = var_1_10009

	local var_5_8 = var_5_7(var_5_6, var_1_10009(var_5_5[3].task_id))
	local var_5_9 = var_7.getProgress(var_5_8)
	local var_5_10 = {}

	for iter_5_0 = 1, 3 do
		local var_5_11 = arg_5_0.taskProxy
		local var_5_12 = var_13.getFinishTaskById

		tonumber = var_1_10015
		var_5_10[iter_5_0] = var_5_12(var_5_11, var_1_10015(var_5_5[iter_5_0].task_id))
	end

	setText = var_9

	var_9(var_5_2:Find("title/Text"), var_5_3.title)

	setActive = var_9

	local var_5_13 = var_5_2:Find("title/Text")
	local var_5_14

	if not var_5_10[1] and not var_5_10[2] then
		var_5_14 = var_5_10[3]
	end

	var_9(var_5_13, var_5_14)

	setActive = var_9

	var_9(var_5_2:Find("title/lock"), not var_5_10[1] and not var_5_10[2] and not var_5_10[3])

	LoadImageSpriteAsync = var_9

	var_9("cluepictures/" .. var_5_3.pic, var_5_2:Find("picture"), true)

	local var_5_16

	if var_5_3.type == 1 then
		local var_5_15 = var_5_2

		var_5_16 = var_5_2.Find(var_5_15, "picture")
		Vector3 = var_5_15
		var_5_16.localScale = var_5_15(1, 1, 1)
	else
		local var_5_17 = var_5_2

		var_5_16 = var_5_2.Find(var_5_17, "picture")
		Vector3 = var_5_17
		var_5_16.localScale = var_5_17(0.6, 0.6, 1)
	end

	setActive = var_5_16

	var_5_16(var_5_2:Find("picture/lockSite"), var_5_3.type == 1 and not var_5_10[1] and not var_5_10[2] and not var_5_10[3])

	setActive = var_5_16

	var_5_16(var_5_2:Find("picture/lockChara"), var_5_3.type == 2 and not var_5_10[1] and not var_5_10[2] and not var_5_10[3])

	local var_5_18 = false

	for iter_5_1 = 1, 3 do
		if var_5_10[iter_5_1] then
			setText = var_14

			var_14(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_1), var_5_5[iter_5_1].desc)
		elseif arg_5_0.investigatingGroupId == var_5_0 then
			setText = var_14
			var_1_10015 = var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_1)

			local var_5_19 = "<color=#858593>"
			local var_5_20 = var_5_5[iter_5_1].unlock_desc
			local var_5_21 = var_5_5[iter_5_1].unlock_num

			i18n = var_1_10019

			var_14(var_1_10015, var_5_19 .. var_5_20 .. var_5_21 .. var_1_10019("clue_task_tip", var_5_9) .. "</color>")
		elseif not var_5_18 then
			var_5_18 = true
			setText = var_14
			var_1_10015 = var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_1)

			local var_5_22 = "<color=#858593>"
			local var_5_23 = var_5_5[iter_5_1].unlock_desc
			local var_5_24 = var_5_5[iter_5_1].unlock_num

			i18n = var_1_10019

			var_14(var_1_10015, var_5_22 .. var_5_23 .. var_5_24 .. var_1_10019("clue_task_tip", var_5_9) .. "</color>")
		else
			setText = var_14

			var_14(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_1), "<color=#858593>？？？</color>")
		end
	end

	setActive = var_10

	var_10(var_5_2:Find("goBtn/selected"), arg_5_0.investigatingGroupId == var_5_0)

	onButton = var_10

	local var_5_25 = arg_5_0
	local var_5_26 = var_5_2:Find("goBtn")

	local function var_5_27()
		local var_6_0 = arg_5_0

		var_6_0.investigatingGroupId = var_5_0
		PlayerPrefs = var_6_0

		var_6_0.SetInt("investigatingGroupId_" .. arg_5_0.activityId .. "_" .. arg_5_0.playerId, var_5_0)

		setActive = var_0

		local var_6_1 = var_5_2

		var_0(var_1.Find(var_6_1, "goBtn/selected"), true)

		if arg_5_0.pageIndex == 1 then
			local var_6_2 = arg_5_0

			var_0.ShowSitePage(var_6_2)
		elseif arg_5_0.pageIndex == 2 then
			local var_6_3 = arg_5_0

			var_0.ShowCharaPage(var_6_3)
		end

		local var_6_4 = arg_5_0

		var_0.OpenChapter(var_6_4, var_5_0)

		local var_6_5 = arg_5_0

		var_0.closeView(var_6_5)

		return
	end

	SFX_PANEL = var_14

	var_10(var_5_25, var_5_26, var_5_27, var_14)

	if not var_5_10[1] and not var_5_10[2] and not var_5_10[3] then
		setActive = var_10

		local var_5_28 = arg_5_0.clueGroupTf

		var_10(var_11.Find(var_5_28, "triangle"), false)
	else
		setActive = var_10

		local var_5_29 = arg_5_0.clueGroupTf

		var_10(var_11.Find(var_5_29, "triangle"), true)

		setActive = var_10

		local var_5_30 = arg_5_0.clueGroupTf
		local var_5_31 = var_11.Find(var_5_30, "triangle")
		local var_5_32 = arg_5_0.clueGroupTf
		local var_5_33 = var_12.Find(var_5_32, "clueScroll")
		local var_5_34 = var_12.GetComponent

		typeof = var_14
		ScrollRect = var_1_10015

		var_10(var_5_31, var_5_34(var_5_33, var_14(var_1_10015)).normalizedPosition.y > 0.01)

		onScroll = var_10

		local var_5_35 = arg_5_0
		local var_5_36 = arg_5_0.clueGroupTf

		var_10(var_5_35, var_12.Find(var_5_36, "clueScroll"), function(arg_7_0)
			setActive = var_2_10001

			local var_7_0 = arg_5_0.clueGroupTf

			var_2_10001(var_2.Find(var_7_0, "triangle"), arg_7_0.y > 0.01)

			return
		end)
	end

	setActive = var_10

	local var_5_37 = arg_5_0._tf

	var_10(var_11.Find(var_5_37, "top"), var_5_1 and #var_5_1 > 0)

	if var_5_1 and #var_5_1 > 0 then
		table = var_10

		if var_10.contains(var_5_1, var_5_4[1]) then
			setActive = var_10

			var_10(var_5_2:Find("title/Text"), false)

			setActive = var_10

			var_10(var_5_2:Find("title/lock"), true)

			setActive = var_10

			var_10(var_5_2:Find("picture/lockSite"), var_5_3.type == 1)

			setActive = var_10

			var_10(var_5_2:Find("picture/lockChara"), var_5_3.type == 2)

			for iter_5_2 = 1, #var_5_1 do
				if arg_5_0.investigatingGroupId == var_5_0 then
					setText = var_14

					var_14(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_2), "<color=#858593>" .. var_5_5[iter_5_2].unlock_desc .. var_5_5[iter_5_2].unlock_num .. "</color>")
				else
					setText = var_14

					var_14(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_2), "<color=#858593>？？？</color>")
				end
			end

			arg_5_0:StartTimer(function()
				setActive = var_2_10000

				local var_8_0 = var_5_2

				var_2_10000(var_1.Find(var_8_0, "title/Text"), true)

				local var_8_1 = var_5_2
				local var_8_2 = var_0.Find(var_8_1, "title")
				local var_8_3 = var_0.GetComponent

				typeof = var_2
				Animation = var_3

				local var_8_4 = var_8_3(var_8_2, var_2(var_3))
				local var_8_5 = var_0.Play(var_8_4, "anim_clue_single_unlock1")
				local var_8_6 = arg_5_0
				local var_8_7 = var_1.SetEndAniEvent
				local var_8_8 = var_5_2

				var_8_7(var_8_6, var_3.Find(var_8_8, "title"), function()
					setActive = var_3_10000

					local var_9_0 = var_5_2

					var_3_10000(var_1.Find(var_9_0, "title/lock"), false)

					return
				end)

				return
			end, var_0_4)
			arg_5_0:StartTimer(function()
				local var_10_0 = var_5_2
				local var_10_1 = var_0.Find(var_10_0, "picture")
				local var_10_2 = var_0.GetComponent

				typeof = var_2
				Animation = var_2_10003

				local var_10_3 = var_10_2(var_10_1, var_2(var_2_10003))
				local var_10_4 = var_0.Play(var_10_3, "anim_clue_single_unlock")
				local var_10_5 = arg_5_0
				local var_10_6 = var_1.SetEndAniEvent
				local var_10_7 = var_5_2

				var_10_6(var_10_5, var_3.Find(var_10_7, "picture"), function()
					setActive = var_3_10000

					local var_11_0 = var_5_2

					var_3_10000(var_1.Find(var_11_0, "picture/lockSite"), false)

					setActive = var_3_10000

					local var_11_1 = var_5_2

					var_3_10000(var_1.Find(var_11_1, "picture/lockChara"), false)

					return
				end)

				return
			end, var_0_4)

			for iter_5_3 = 1, #var_5_1 do
				arg_5_0:StartTimer(function()
					setText = var_2_10000

					local var_12_0 = var_5_2

					var_2_10000(var_1.Find(var_12_0, "clueScroll/Viewport/Content/clue" .. iter_5_3), var_5_5[iter_5_3].desc)

					return
				end, var_0_5 * iter_5_3 + var_0_4)
			end
		else
			table = var_10

			for iter_5_4 = var_10.indexof(var_5_4, var_5_1[1]), 3 do
				if arg_5_0.investigatingGroupId == var_5_0 then
					setText = var_15

					var_15(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_4), "<color=#858593>" .. var_5_5[iter_5_4].unlock_desc .. var_5_5[iter_5_4].unlock_num .. "</color>")
				else
					setText = var_15

					var_15(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_4), "<color=#858593>？？？</color>")
				end
			end

			local var_5_38 = 1

			for iter_5_5 = var_10, var_10 + #var_5_1 - 1 do
				arg_5_0:StartTimer(function()
					setText = var_2_10000

					local var_13_0 = var_5_2

					var_2_10000(var_1.Find(var_13_0, "clueScroll/Viewport/Content/clue" .. iter_5_5), var_5_5[iter_5_5].desc)

					return
				end, var_0_5 * var_5_38)

				var_5_38 = var_5_38 + 1
			end
		end

		setActive = var_10

		var_10(var_5_2:Find("goBtn"), false)
	else
		setActive = var_10

		var_10(var_5_2:Find("goBtn"), not var_5_10[1] or not var_5_10[2] or not var_5_10[3])
	end

	return
end

function var_0_1.OpenChapter(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.emit

	ClueGroupSingleMediator = var_1_10004

	var_14_1(var_14_0, var_1_10004.OPEN_CLUE_JUMP, arg_14_1)

	return
end

function var_0_1.StartTimer(arg_15_0, arg_15_1, arg_15_2)
	Timer = var_1_10003

	local var_15_0 = var_1_10003.New(arg_15_1, arg_15_2, 1)

	var_3.Start(var_15_0)

	table = var_4

	var_4.insert(arg_15_0.timerList, var_3)

	return
end

function var_0_1.RemoveAllTimer(arg_16_0)
	ipairs = var_1_10001

	for iter_16_0, iter_16_1 in var_1_10001(arg_16_0.timerList) do
		iter_16_1:Stop()
	end

	arg_16_0.timerList = {}

	return
end

function var_0_1.SetEndAniEvent(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1
	local var_17_1 = arg_17_1.GetComponent

	typeof = var_1_10005
	DftAniEvent = var_1_10006

	if var_17_1(var_17_0, var_1_10005(var_1_10006)) then
		var_3:SetEndEvent(function()
			arg_17_2()

			local var_18_0 = var_0

			var_0.SetEndEvent(var_18_0, nil)

			return
		end)
	end

	return
end

function var_0_1.willExit(arg_19_0)
	arg_19_0:RemoveAllTimer()

	return
end

function var_0_1.onBackPressed(arg_20_0)
	arg_20_0:closeView()

	return
end

return var_0_1
