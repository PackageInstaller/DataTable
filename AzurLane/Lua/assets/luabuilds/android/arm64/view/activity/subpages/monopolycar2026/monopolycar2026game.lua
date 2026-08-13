class = var_0_10000

local var_0_0 = "MonopolyCar2026Game"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..MonopolyCar2024.MonopolyCar2024Game"))
local var_0_2 = 1
local var_0_3 = 2

local function var_0_4(arg_1_0)
	return (arg_1_0 and arg_1_0.story) ~= nil and var_1 ~= "" and var_1 ~= "0"
end

local function var_0_5(arg_2_0)
	pg = var_1_10001

	return var_1_10001.activity_monopolycar2026_story_event.all[arg_2_0] and var_1[var_2]
end

local function var_0_6(arg_3_0)
	for iter_3_0 = arg_3_0 - 1, 1, -1 do
		local var_3_0 = var_0_5(iter_3_0)

		if var_0_4(var_3_0) then
			return var_3_0
		end
	end

	return
end

local function var_0_7()
	pg = var_1_10000

	for iter_4_0 = #var_1_10000.activity_monopolycar2026_story_event.all, 1, -1 do
		local var_4_0 = var_0_5(iter_4_0)

		if var_0_4(var_4_0) then
			return var_4_0
		end
	end

	return
end

local function var_0_8(arg_5_0)
	return (arg_5_0 and arg_5_0.main_story) ~= nil and var_1 ~= "" and var_1 ~= "0"
end

function var_0_1.NewPickPage(arg_6_0, arg_6_1, arg_6_2)
	MonopolyCar2026PickPage = var_1_10003

	return var_1_10003.New(arg_6_1, arg_6_2)
end

function var_0_1.NewBubblePage(arg_7_0, arg_7_1, arg_7_2)
	MonopolyCar2026BubblePage = var_1_10003

	return var_1_10003.New(arg_7_1:Find("bubble"), arg_7_2)
end

function var_0_1.InitUI(arg_8_0)
	var_0_1.super.InitUI(arg_8_0)

	findTF = var_1
	arg_8_0.labelLeftCount2 = var_1(arg_8_0.btnStart, "labelLeftCount/Text_1")
	findTF = var_1
	arg_8_0.mainModeBtn = var_1(arg_8_0._tf.parent, "mode/toggles/main")
	findTF = var_1
	arg_8_0.storyModeBtn = var_1(arg_8_0._tf.parent, "mode/toggles/story")

	local var_8_0 = arg_8_0.storyModeBtn

	arg_8_0.storyModeBtnTip = var_1.Find(var_8_0, "tip")
	findTF = var_1
	arg_8_0.btnAutolock = var_1(arg_8_0.topTr, "btnAuto/lock")
	setText = var_1

	local var_8_1 = arg_8_0.mainModeBtn
	local var_8_2 = var_3.Find(var_8_1, "Text")

	i18n = var_4

	var_1(var_8_2, var_4("mono_car_2026_toggle_main"))

	setText = var_1

	local var_8_3 = arg_8_0.mainModeBtn
	local var_8_4 = var_3.Find(var_8_3, "sel/Text")

	i18n = var_4

	var_1(var_8_4, var_4("mono_car_2026_toggle_main"))

	setText = var_1

	local var_8_5 = arg_8_0.storyModeBtn
	local var_8_6 = var_3.Find(var_8_5, "Text")

	i18n = var_4

	var_1(var_8_6, var_4("mono_car_2026_toggle_story"))

	setText = var_1

	local var_8_7 = arg_8_0.storyModeBtn
	local var_8_8 = var_3.Find(var_8_7, "sel/Text")

	i18n = var_4

	var_1(var_8_8, var_4("mono_car_2026_toggle_story"))

	findTF = var_1
	arg_8_0.storyCnt = var_1(arg_8_0._tf.parent, "story/award/Text")
	findTF = var_1
	arg_8_0.storyTpl = var_1(arg_8_0._tf.parent, "story/mapContainer/tpl")
	findTF = var_1
	arg_8_0.storyContainer = var_1(arg_8_0._tf.parent, "story/mapContainer")
	findTF = var_1
	arg_8_0.storyAward = var_1(arg_8_0._tf.parent, "story/award/award")
	findTF = var_1
	arg_8_0.storyAwardGot = var_1(arg_8_0.storyAward, "icon_mask")
	findTF = var_1
	arg_8_0.mileageTxt = var_1(arg_8_0._tf, "mileage/Text")
	arg_8_0.hideList = {
		arg_8_0.btnStart,
		arg_8_0.btnBack,
		arg_8_0.btnAuto,
		arg_8_0.register
	}

	return
end

function var_0_1.UpdateAutoBtn(arg_9_0)
	var_0_1.super.UpdateAutoBtn(arg_9_0)

	local var_9_0 = arg_9_0.useCount
	local var_9_1 = 10 <= var_9_0

	setActive = var_2

	var_2(arg_9_0.btnAutolock, not var_9_1)

	return
end

function var_0_1.OnEnterDone(arg_10_0, arg_10_1)
	pg = var_1_10002

	local var_10_0 = var_1_10002.NewStoryMgr.GetInstance()

	if not var_2.IsPlayed(var_10_0, "BINHAIJISU1") then
		pg = var_2

		local var_10_1 = var_2.NewStoryMgr.GetInstance()

		var_2.Play(var_10_1, "BINHAIJISU1", arg_10_1, true)
	else
		arg_10_1()
	end

	return
end

function var_0_1.InitDone(arg_11_0, arg_11_1)
	pg = var_1_10002

	local var_11_0 = var_1_10002.NewStoryMgr.GetInstance()

	if not var_2.IsPlayed(var_11_0, "BINHAIJISU2") then
		pg = var_2

		local var_11_1 = var_2.NewStoryMgr.GetInstance()

		var_2.Play(var_11_1, "BINHAIJISU2", arg_11_1, true)
	else
		arg_11_1()
	end

	return
end

function var_0_1.CheckMainStorys(arg_12_0, arg_12_1)
	arg_12_1 = arg_12_1 or function()
		return
	end
	pg = var_1_10002

	local var_12_0 = var_1_10002.activity_monopolycar2026_story_event

	pg = var_1_10003

	local var_12_1 = var_1_10003.NewStoryMgr.GetInstance()
	local var_12_2 = {}
	local var_12_3

	if not arg_12_0.turnCnt then
		var_12_3 = 1
	end

	ipairs = var_1_10006

	for iter_12_0, iter_12_1 in var_1_10006(var_12_0.all) do
		if var_12_0[iter_12_1] and iter_12_1 <= var_12_3 - 1 and var_0_8(var_11) and not var_12_1:IsPlayed(var_11.main_story) then
			table = var_1_10012

			var_1_10012.insert(var_12_2, var_11.main_story)
		end
	end

	if #var_12_2 <= 0 then
		arg_12_0:PlayStepHideAnim(arg_12_1)

		return
	end

	local var_12_4 = {}

	ipairs = var_7

	for iter_12_2, iter_12_3 in var_7(var_12_2) do
		table = var_1_10012

		var_1_10012.insert(var_12_4, function(arg_14_0)
			if arg_12_0.autoFlag then
				local var_14_0 = var_12_1

				var_1.ForceAutoPlay(var_14_0, iter_12_3, arg_14_0, true, true)
			else
				local var_14_1 = var_12_1

				var_1.Play(var_14_1, iter_12_3, arg_14_0, true)
			end

			return
		end)
	end

	seriesAsync = var_7

	var_7(var_12_4, function()
		local var_15_0 = arg_12_0

		var_0.PlayStepHideAnim(var_15_0, arg_12_1)

		return
	end)

	return
end

function var_0_1.PlayStepHideAnim(arg_16_0, arg_16_1)
	findTF = var_1_10002

	local var_16_0 = var_1_10002(arg_16_0.rollStep, "animroot")
	local var_16_1 = var_2.GetComponent

	typeof = var_5
	Animation = var_1_10007

	local var_16_2 = var_16_1(var_16_0, var_5(var_1_10007))
	local var_16_3 = var_2.GetComponent

	typeof = var_1_10006
	DftAniEvent = var_1_10008

	local var_16_4 = var_16_3(var_16_2, var_1_10006(var_1_10008))

	var_3.SetEndEvent(var_16_4, function()
		local var_17_0 = arg_16_0

		var_0.SetRollStepAct(var_17_0, false)

		if arg_16_1 then
			arg_16_1()
		end

		return
	end)
	var_2:Play("anim_monopolycar_mainui_step_hide")

	return
end

function var_0_1.PlayRollAnimation(arg_18_0, arg_18_1, arg_18_2)
	setText = var_1_10003
	findTF = var_1_10005

	var_1_10003(var_1_10005(arg_18_0.rollStep, "animroot/Image/Text"), "00")

	local var_18_0 = arg_18_0.btnStart
	local var_18_1 = var_3.GetComponent

	typeof = var_6
	Animation = var_8

	local var_18_2 = var_18_1(var_18_0, var_6(var_8))
	local var_18_3 = var_3.GetComponent

	typeof = var_7
	DftAniEvent = var_1_10009

	local var_18_4 = var_18_3(var_18_2, var_7(var_1_10009))

	findTF = var_18_0

	local var_18_5 = var_18_0(arg_18_0.rollStep, "animroot")
	local var_18_6 = var_5.GetComponent

	typeof = var_8
	Animation = var_1_10010

	local var_18_7 = var_18_6(var_18_5, var_8(var_1_10010))
	local var_18_8 = var_5.GetComponent

	typeof = var_1_10009
	DftAniEvent = var_1_10011

	local var_18_9 = var_18_8(var_18_7, var_1_10009(var_1_10011))

	var_6.SetTriggerEvent(var_18_9, function()
		setText = var_2_10000
		findTF = var_2_10002

		var_2_10000(var_2_10002(arg_18_0.rollStep, "animroot/Image/Text"), "0" .. arg_18_1)

		return
	end)

	seriesAsync = var_7

	var_7({
		function(arg_20_0)
			local var_20_0 = var_18_4

			var_1.SetEndEvent(var_20_0, function()
				arg_20_0()

				return
			end)

			local var_20_1 = var_0

			var_1.Play(var_20_1, "anim_monopolycar_mainui_btn_hide")

			return
		end,
		function(arg_22_0)
			local var_22_0 = arg_18_0

			var_1.SetRollStepAct(var_22_0, true)
			arg_22_0()

			return
		end,
		function(arg_23_0)
			local var_23_0 = var_0

			var_1.SetEndEvent(var_23_0, function()
				arg_23_0()

				return
			end)

			local var_23_1 = var_0

			var_1.Play(var_23_1, "anim_monopolycar_mainui_step_0" .. arg_18_1)

			return
		end
	}, function()
		local var_25_0 = var_0

		var_0.Play(var_25_0, "anim_monopolycar_mainui_btn_show")
		arg_18_2()

		return
	end)

	return
end

function var_0_1.InitMap(arg_26_0)
	arg_26_0.mapCells = {}
	ipairs = var_1
	pg = var_1_10003

	for iter_26_0, iter_26_1 in var_1(var_1_10003.activity_monopolycar2026_map_event.all) do
		pg = var_1_10006

		local var_26_0 = var_1_10006.activity_monopolycar2026_map_event[iter_26_1].event_id

		cloneTplTo = var_1_10008

		local var_26_1 = arg_26_0.tplMapCell
		local var_26_2 = arg_26_0.mapContainer

		tostring = var_1_10012
		var_1_10008 = var_1_10008(var_26_1, var_26_2, var_1_10012(var_26_0))
		Vector3 = var_1_10009
		var_1_10008.localPosition = var_1_10009(var_1_10006.pos.x, var_1_10006.pos.y, 0)
		setActive = var_26_1

		var_26_1(var_1_10008, false)

		pg = var_26_1

		local var_26_3 = var_26_1.activity_event_monopoly_map[var_26_0].icon
		local var_26_4 = {}

		col = var_1_10012
		var_26_4.col = var_1_10012
		row = var_1_10012
		var_26_4.row = var_1_10012
		var_26_4.mapId = var_26_0
		var_26_4.tf = var_1_10008
		var_26_4.icon = var_26_3
		var_26_4.position = var_1_10009

		if not var_1_10006.flip then
			var_1_10012 = 0
		end

		var_26_4.flip = var_1_10012
		table = var_1_10012

		var_1_10012.insert(arg_26_0.mapCells, var_26_4)
	end

	table = var_1

	var_1.sort(arg_26_0.mapCells, function(arg_27_0, arg_27_1)
		return arg_27_0.mapId < arg_27_1.mapId
	end)
	arg_26_0:InitStoryMap()

	return
end

function var_0_1.SetRollStepAct(arg_28_0, arg_28_1)
	if not arg_28_1 then
		setText = var_1_10002
		findTF = var_1_10004

		var_1_10002(var_1_10004(arg_28_0.rollStep, "animroot/Image/Text"), "")
	end

	setActive = var_1_10002

	var_1_10002(arg_28_0.rollStep, true)

	return
end

function var_0_1.InitStoryMap(arg_29_0)
	arg_29_0.storyCells = {}
	ipairs = var_1
	pg = var_1_10003

	for iter_29_0, iter_29_1 in var_1(var_1_10003.activity_monopolycar2026_story_event.all) do
		pg = var_1_10006
		var_1_10006 = var_1_10006.activity_monopolycar2026_story_event[iter_29_1]
		cloneTplTo = var_1_10007

		local var_29_0 = arg_29_0.storyTpl
		local var_29_1 = arg_29_0.storyContainer

		tostring = var_1_10011
		var_1_10007 = var_1_10007(var_29_0, var_29_1, var_1_10011(iter_29_1))
		Vector3 = var_1_10008
		var_1_10007.localPosition = var_1_10008(var_1_10006.pos.x, var_1_10006.pos.y, 0)

		if var_0_4(var_1_10006) then
			onButton = var_29_0
			var_1_10011 = arg_29_0

			local var_29_2 = var_1_10007

			local function var_29_3()
				pg = var_2_10000

				local var_30_0 = var_2_10000.NewStoryMgr.GetInstance()

				var_0.Play(var_30_0, var_1_10006.story, nil, true)

				return
			end

			SFX_PANEL = var_1_10014

			var_29_0(var_1_10011, var_29_2, var_29_3, var_1_10014)
		end

		findTF = var_29_0

		local var_29_4 = var_29_0(var_1_10007, "Image")

		pg = var_10

		local var_29_5 = var_10.ship_skin_template[var_1_10006.icon]

		GetImageSpriteFromAtlasAsync = var_1_10011

		var_1_10011("SquareIcon/" .. var_29_5.prefab, "", var_29_4)

		setActive = var_1_10011

		var_1_10011(var_1_10007, var_1_10008)

		table = var_1_10011

		var_1_10011.insert(arg_29_0.storyCells, var_1_10007)
	end

	arg_29_0:UpdateStoriesUnlock()
	arg_29_0:UpdateStoryAward()

	return
end

function var_0_1.UpdateStoryAward(arg_31_0)
	if var_0_7() then
		::label_31_0::

		pg = var_1_10002

		local var_31_0 = var_1_10002.NewStoryMgr.GetInstance()

		var_1_10002 = var_1_10002.StoryName2StoryId(var_31_0, var_1.story)
	end

	if var_1_10002 then
		::label_31_1::

		pg = var_1_10003
		var_1_10003 = var_1_10003.story_template[var_1_10002]
	end

	local var_31_1

	if var_1_10003 and var_1_10003.drop_client then
		var_31_1 = var_1_10003.drop_client[1]
	end

	if var_31_1 then
		local var_31_2 = {
			type = var_31_1[1],
			id = var_31_1[2],
			count = var_31_1[3]
		}

		updateDrop = var_6

		var_6(arg_31_0.storyAward, var_31_2)
	end

	return
end

function var_0_1.UpdateStoriesUnlock(arg_32_0)
	pg = var_1_10001

	local var_32_0 = var_1_10001.NewStoryMgr.GetInstance()
	local var_32_1 = 0

	ipairs = var_1_10003

	for iter_32_0, iter_32_1 in var_1_10003(arg_32_0.storyCells) do
		local var_32_2 = var_0_5(iter_32_0)
		local var_32_3 = false

		if var_0_4(var_32_2) then
			var_32_3 = var_32_1 + 1 <= arg_32_0.turnCnt
		end

		if var_32_3 and 1 < var_32_1 then
			var_32_3 = not var_0_6(iter_32_0) or var_32_0:IsPlayed(var_10.story)
		end

		setActive = var_10

		var_10(iter_32_1, var_32_3)
	end

	return
end

function var_0_1.InitCar(arg_33_0, arg_33_1)
	findTF = var_1_10002
	arg_33_0.model = var_1_10002(arg_33_0.car, "car")

	local var_33_0 = arg_33_0.model.transform

	Vector3 = var_1_10003
	var_33_0.localScale = var_1_10003.one

	local var_33_1 = arg_33_0.model.transform

	Vector3 = var_3
	var_33_1.localPosition = var_3.zero

	local var_33_2 = arg_33_0.model.transform

	var_2.SetParent(var_33_2, arg_33_0.car, false)

	findTF = var_2
	arg_33_0.modelIconTf = var_2(arg_33_0.model, "icon")
	findTF = var_2
	arg_33_0.modelArrTf = var_2(arg_33_0.model, "arr")

	if arg_33_0.modelIconTf then
		arg_33_0.modelIconBasePos = arg_33_0.modelIconTf.localPosition
	end

	if arg_33_0.modelArrTf then
		arg_33_0.modelArrBaseScale = arg_33_0.modelArrTf.localScale
	end

	if arg_33_0.pos then
		arg_33_0:UpdateCarPos(arg_33_0.pos, false)
	end

	arg_33_1()

	return
end

function var_0_1.UpdateStory(arg_34_0)
	arg_34_0:UpdateStoriesUnlock()
	arg_34_0:UpdateStoryUI()

	return
end

function var_0_1.UpdateUI(arg_35_0)
	var_0_1.super.UpdateUI(arg_35_0)

	setText = var_1

	local var_35_0 = arg_35_0.labelLeftCount2

	i18n = var_1_10004

	var_1(var_35_0, var_1_10004("monopoly2026_left_cnt", arg_35_0.leftCount))

	setText = var_1

	var_1(arg_35_0.mileageTxt, arg_35_0.pos .. "/" .. #arg_35_0.mapCells .. "KM")

	setText = var_1

	var_1(arg_35_0.labelLeftCount, arg_35_0.leftCount)

	setText = var_1

	var_1(arg_35_0.registerTxt, arg_35_0.turnCnt)
	arg_35_0:UpdateStoriesUnlock()
	arg_35_0:UpdateStoryUI()

	return
end

function var_0_1.UpdateStoryUI(arg_36_0)
	local var_36_0 = 0
	local var_36_1 = 0
	local var_36_2 = false

	pg = var_1_10004

	local var_36_3 = var_1_10004.NewStoryMgr.GetInstance()
	local var_36_4 = 0

	ipairs = var_1_10006
	pg = var_1_10008

	for iter_36_0, iter_36_1 in var_1_10006(var_1_10008.activity_monopolycar2026_story_event.all) do
		pg = var_1_10011
		var_1_10011 = var_1_10011.activity_monopolycar2026_story_event[iter_36_1]

		if var_0_4(var_1_10011) then
			var_36_4 = var_36_4 + 1
			var_36_0 = var_36_0 + 1
		end

		local var_36_5 = false

		if var_12 then
			if var_36_3:IsPlayed(var_1_10011.story) then
				var_36_1 = var_36_1 + 1
			end

			local var_36_6

			if var_36_4 <= arg_36_0.turnCnt and var_36_4 > 1 then
				var_36_6 = not var_0_6(iter_36_0) or var_36_3:IsPlayed(var_16.story)
			end

			var_36_5 = var_36_6 and not var_14
			var_36_2 = var_36_2 or var_36_5
		else
			setActive = var_14

			var_14(arg_36_0.storyCells[iter_36_0], false)
		end

		setActive = var_14

		local var_36_7 = arg_36_0.storyCells[iter_36_0]

		var_14(var_16.Find(var_36_7, "tip"), var_36_5)
	end

	setText = var_6

	local var_36_8 = arg_36_0.storyCnt

	i18n = iter_36_0

	var_6(var_36_8, iter_36_0("monopoly2026_story_award", var_36_1, var_36_0))

	local var_36_9 = var_36_0 > 0 and var_36_1 == var_36_0

	setActive = var_7

	var_7(arg_36_0.storyAwardGot, var_36_9)

	setActive = var_7

	var_7(arg_36_0.storyModeBtnTip, var_36_2)

	return
end

function var_0_1.UpdateCarPos(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_0.model then
		assert = var_3

		var_3(arg_37_0.mapCells[arg_37_1], arg_37_1)

		local var_37_0 = arg_37_0
		local var_37_1 = arg_37_0.ApplyModelFlip
		local var_37_2

		if not arg_37_0.mapCells[arg_37_1].flip then
			var_37_2 = 0
		end

		var_37_1(var_37_0, var_37_2)

		local var_37_3 = arg_37_0.mapCells[arg_37_1].position
		local var_37_4 = arg_37_1 + 1 > #arg_37_0.mapCells and 1 or arg_37_1 + 1
		local var_37_5 = arg_37_0.mapCells[var_37_4]

		arg_37_0.car.localPosition = var_37_3

		local var_37_6 = arg_37_0.car

		var_6.SetAsLastSibling(var_37_6)
	end

	return
end

function var_0_1.ReadyMoveCar(arg_38_0, arg_38_1, arg_38_2)
	if not arg_38_1 or #arg_38_1 <= 0 then
		if arg_38_2 then
			arg_38_2()
		end

		return
	end

	local var_38_0 = {}

	for iter_38_0 = 1, #arg_38_1 do
		table = var_1_10008

		var_1_10008.insert(var_38_0, function(arg_39_0)
			local var_39_0 = arg_38_0

			var_1.UpdateCarPos(var_39_0, arg_38_1[iter_38_0], true)

			Timer = var_1

			local var_39_1 = var_1.New(arg_39_0, 1, 1)

			var_1.Start(var_39_1)

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_38_0, arg_38_2)

	return
end

function var_0_1.ApplyModelFlip(arg_40_0, arg_40_1)
	if not arg_40_0.model then
		return
	end

	if arg_40_0.modelIconTf and arg_40_0.modelIconBasePos then
		local var_40_0 = 0

		if arg_40_1 == 1 then
			var_1_10005 = arg_40_0.modelIconTf

			local var_40_1 = var_3.GetComponent

			typeof = var_1_10006
			RectTransform = var_1_10008

			local var_40_2 = var_40_1(var_1_10005, var_1_10006(var_1_10008))
			local var_40_4

			if arg_40_0.modelArrTf then
				local var_40_3 = arg_40_0.modelArrTf

				var_40_4 = var_40_4.GetComponent
				typeof = var_1_10007
				RectTransform = var_1_10009
				var_40_4 = var_40_4(var_40_3, var_1_10007(var_1_10009))
			end

			if not var_40_2 or not var_40_2.rect.height then
				var_1_10005 = 0
			end

			local var_40_5

			if not var_40_4 or not var_40_4.rect.height then
				var_40_5 = 0
			end

			var_40_0 = var_1_10005 + var_40_5
		end

		local var_40_6 = arg_40_0.modelIconBasePos
		local var_40_7 = arg_40_0.modelIconTf

		Vector3 = var_1_10005
		var_40_7.localPosition = var_1_10005(var_40_6.x, var_40_6.y - var_40_0, var_40_6.z)
	end

	if arg_40_0.modelArrTf and arg_40_0.modelArrBaseScale then
		local var_40_8 = arg_40_0.modelArrBaseScale
		local var_40_9 = arg_40_1 == 1 and -1 or var_40_8.y
		local var_40_10 = arg_40_0.modelArrTf

		Vector3 = var_1_10005
		var_40_10.localScale = var_1_10005(var_40_8.x, var_40_9, var_40_8.z)
	end

	return
end

function var_0_1.GetCarMoveType(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	local var_41_0
	local var_41_1

	if arg_41_3 then
		stateWalkB = var_1_10006

		if not var_1_10006 then
			::label_41_0::

			stateStandB = var_41_0
		end

		Vector3 = var_1_10006

		local var_41_2 = var_1_10006(1, 1, 1)

		return var_41_0, var_41_2
	end
end

function var_0_1.InitCheerLeaders(arg_42_0, arg_42_1)
	arg_42_0.cheerLeaders = {}

	arg_42_1()

	return
end

function var_0_1.RegisterUI(arg_43_0)
	var_0_1.super.RegisterUI(arg_43_0)

	onToggle = var_1

	local var_43_0 = arg_43_0
	local var_43_1 = arg_43_0.mainModeBtn

	local function var_43_2(arg_44_0)
		if arg_44_0 then
			local var_44_0 = arg_43_0

			var_1.SwitchMode(var_44_0, var_0_2)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_43_0, var_43_1, var_43_2, var_1_10006)

	onToggle = var_1

	local var_43_3 = arg_43_0
	local var_43_4 = arg_43_0.storyModeBtn

	local function var_43_5(arg_45_0)
		if arg_45_0 then
			local var_45_0 = arg_43_0

			var_1.SwitchMode(var_45_0, var_0_3)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_43_3, var_43_4, var_43_5, var_1_10006)

	onButton = var_1

	local var_43_6 = arg_43_0
	local var_43_7 = arg_43_0.btnHelp

	local function var_43_8()
		pg = var_2_10000

		local var_46_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_46_1 = var_0.ShowMsgBox
		local var_46_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_46_2.type = var_2_10004
		pg = var_2_10004
		var_46_2.helps = var_2_10004.gametip.help_monopoly_car2026.tip

		var_46_1(var_46_0, var_46_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_43_6, var_43_7, var_43_8, var_1_10006)

	onButton = var_1

	local var_43_9 = arg_43_0
	local var_43_10 = arg_43_0.register

	local function var_43_11()
		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_43_9, var_43_10, var_43_11, var_1_10006)

	return
end

function var_0_1.SwitchMode(arg_48_0, arg_48_1)
	arg_48_0.mode = arg_48_1

	return
end

return var_0_1
