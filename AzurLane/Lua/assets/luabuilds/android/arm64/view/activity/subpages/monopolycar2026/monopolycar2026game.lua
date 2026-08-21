local var_0_0 = class("MonopolyCar2026Game", import("..MonopolyCar2024.MonopolyCar2024Game"))
local var_0_1 = 1
local var_0_2 = 2

local function var_0_3(arg_1_0)
	local var_1_0 = arg_1_0 and arg_1_0.story

	return (arg_1_0 and arg_1_0.story) ~= nil and var_1_0 ~= "" and var_1_0 ~= "0"
end

local function var_0_4(arg_2_0)
	return pg.activity_monopolycar2026_story_event.all[arg_2_0] and pg.activity_monopolycar2026_story_event[pg.activity_monopolycar2026_story_event.all[arg_2_0]]
end

local function var_0_5(arg_3_0)
	for iter_3_0 = arg_3_0 - 1, 1, -1 do
		local var_3_0 = var_0_4(iter_3_0)

		if var_0_3(var_3_0) then
			return var_3_0
		end
	end

	return
end

local function var_0_6()
	for iter_4_0 = #pg.activity_monopolycar2026_story_event.all, 1, -1 do
		local var_4_0 = var_0_4(iter_4_0)

		if var_0_3(var_4_0) then
			return var_4_0
		end
	end

	return
end

local function var_0_7(arg_5_0)
	local var_5_0 = arg_5_0 and arg_5_0.main_story

	return (arg_5_0 and arg_5_0.main_story) ~= nil and var_5_0 ~= "" and var_5_0 ~= "0"
end

function var_0_0.NewPickPage(arg_6_0, arg_6_1, arg_6_2)
	return MonopolyCar2026PickPage.New(arg_6_1, arg_6_2)
end

function var_0_0.NewBubblePage(arg_7_0, arg_7_1, arg_7_2)
	return MonopolyCar2026BubblePage.New(arg_7_1:Find("bubble"), arg_7_2)
end

function var_0_0.InitUI(arg_8_0)
	var_0_0.super.InitUI(arg_8_0)

	arg_8_0.labelLeftCount2 = findTF(arg_8_0.btnStart, "labelLeftCount/Text_1")
	arg_8_0.mainModeBtn = findTF(arg_8_0._tf.parent, "mode/toggles/main")
	arg_8_0.storyModeBtn = findTF(arg_8_0._tf.parent, "mode/toggles/story")
	arg_8_0.storyModeBtnTip = arg_8_0.storyModeBtn:Find("tip")
	arg_8_0.btnAutolock = findTF(arg_8_0.topTr, "btnAuto/lock")

	setText(arg_8_0.mainModeBtn:Find("Text"), i18n("mono_car_2026_toggle_main"))
	setText(arg_8_0.mainModeBtn:Find("sel/Text"), i18n("mono_car_2026_toggle_main"))
	setText(arg_8_0.storyModeBtn:Find("Text"), i18n("mono_car_2026_toggle_story"))
	setText(arg_8_0.storyModeBtn:Find("sel/Text"), i18n("mono_car_2026_toggle_story"))

	arg_8_0.storyCnt = findTF(arg_8_0._tf.parent, "story/award/Text")
	arg_8_0.storyTpl = findTF(arg_8_0._tf.parent, "story/mapContainer/tpl")
	arg_8_0.storyContainer = findTF(arg_8_0._tf.parent, "story/mapContainer")
	arg_8_0.storyAward = findTF(arg_8_0._tf.parent, "story/award/award")
	arg_8_0.storyAwardGot = findTF(arg_8_0.storyAward, "icon_mask")
	arg_8_0.mileageTxt = findTF(arg_8_0._tf, "mileage/Text")
	arg_8_0.hideList = {
		arg_8_0.btnStart,
		arg_8_0.btnBack,
		arg_8_0.btnAuto,
		arg_8_0.register
	}

	return
end

function var_0_0.UpdateAutoBtn(arg_9_0)
	var_0_0.super.UpdateAutoBtn(arg_9_0)
	setActive(arg_9_0.btnAutolock, not (arg_9_0.useCount >= 10))

	return
end

function var_0_0.OnEnterDone(arg_10_0, arg_10_1)
	if not pg.NewStoryMgr.GetInstance():IsPlayed("BINHAIJISU1") then
		pg.NewStoryMgr.GetInstance():Play("BINHAIJISU1", arg_10_1, true)
	else
		arg_10_1()
	end

	return
end

function var_0_0.InitDone(arg_11_0, arg_11_1)
	if not pg.NewStoryMgr.GetInstance():IsPlayed("BINHAIJISU2") then
		pg.NewStoryMgr.GetInstance():Play("BINHAIJISU2", arg_11_1, true)
	else
		arg_11_1()
	end

	return
end

function var_0_0.CheckMainStorys(arg_12_0, arg_12_1)
	arg_12_1 = arg_12_1 or function()
		return
	end

	local var_12_0 = pg.activity_monopolycar2026_story_event
	local var_12_1 = pg.NewStoryMgr.GetInstance()
	local var_12_2 = arg_12_0.turnCnt or 1

	for iter_12_0, iter_12_1 in ipairs(var_12_0.all) do
		if var_12_0[iter_12_1] and iter_12_1 <= var_12_2 - 1 and var_0_7(var_12_0[iter_12_1]) and not var_12_1:IsPlayed(var_12_0[iter_12_1].main_story) then
			table.insert({}, var_12_0[iter_12_1].main_story)
		end
	end

	if #{} <= 0 then
		arg_12_0:PlayStepHideAnim(arg_12_1)

		return
	end

	local var_12_3 = {}

	for iter_12_2, iter_12_3 in ipairs({}) do
		table.insert(var_12_3, function(arg_14_0)
			if arg_12_0.autoFlag then
				var_12_1:ForceAutoPlay(iter_12_3, arg_14_0, true, true)
			else
				var_12_1:Play(iter_12_3, arg_14_0, true)
			end

			return
		end)
	end

	seriesAsync(var_12_3, function()
		arg_12_0:PlayStepHideAnim(arg_12_1)

		return
	end)

	return
end

function var_0_0.PlayStepHideAnim(arg_16_0, arg_16_1)
	local var_16_0 = findTF(arg_16_0.rollStep, "animroot"):GetComponent(typeof(Animation))

	var_16_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		arg_16_0:SetRollStepAct(false)

		if arg_16_1 then
			arg_16_1()
		end

		return
	end)
	var_16_0:Play("anim_monopolycar_mainui_step_hide")

	return
end

function var_0_0.PlayRollAnimation(arg_18_0, arg_18_1, arg_18_2)
	setText(findTF(arg_18_0.rollStep, "animroot/Image/Text"), "00")

	local var_18_0 = arg_18_0.btnStart:GetComponent(typeof(Animation))
	local var_18_1 = arg_18_0.btnStart:GetComponent(typeof(Animation)):GetComponent(typeof(DftAniEvent))
	local var_18_2 = findTF(arg_18_0.rollStep, "animroot"):GetComponent(typeof(Animation))
	local var_18_3 = findTF(arg_18_0.rollStep, "animroot"):GetComponent(typeof(Animation)):GetComponent(typeof(DftAniEvent))

	findTF(arg_18_0.rollStep, "animroot"):GetComponent(typeof(Animation)):GetComponent(typeof(DftAniEvent)):SetTriggerEvent(function()
		setText(findTF(arg_18_0.rollStep, "animroot/Image/Text"), "0" .. arg_18_1)

		return
	end)
	seriesAsync({
		function(arg_20_0)
			var_18_1:SetEndEvent(function()
				arg_20_0()

				return
			end)
			var_18_0:Play("anim_monopolycar_mainui_btn_hide")

			return
		end,
		function(arg_22_0)
			arg_18_0:SetRollStepAct(true)
			arg_22_0()

			return
		end,
		function(arg_23_0)
			var_18_3:SetEndEvent(function()
				arg_23_0()

				return
			end)
			var_18_2:Play("anim_monopolycar_mainui_step_0" .. arg_18_1)

			return
		end
	}, function()
		var_18_0:Play("anim_monopolycar_mainui_btn_show")
		arg_18_2()

		return
	end)

	return
end

function var_0_0.InitMap(arg_26_0)
	arg_26_0.mapCells = {}

	for iter_26_0, iter_26_1 in ipairs(pg.activity_monopolycar2026_map_event.all) do
		local var_26_0 = cloneTplTo(arg_26_0.tplMapCell, arg_26_0.mapContainer, tostring(pg.activity_monopolycar2026_map_event[iter_26_1].event_id))
		local var_26_1 = Vector3(pg.activity_monopolycar2026_map_event[iter_26_1].pos.x, pg.activity_monopolycar2026_map_event[iter_26_1].pos.y, 0)

		var_26_0.localPosition = var_26_1

		setActive(var_26_0, false)

		;({
			col = col,
			row = row,
			mapId = pg.activity_monopolycar2026_map_event[iter_26_1].event_id,
			tf = var_26_0,
			icon = pg.activity_event_monopoly_map[pg.activity_monopolycar2026_map_event[iter_26_1].event_id].icon,
			position = var_26_1
		}).flip = pg.activity_monopolycar2026_map_event[iter_26_1].flip or 0

		table.insert(arg_26_0.mapCells, {
			col = col,
			row = row,
			mapId = pg.activity_monopolycar2026_map_event[iter_26_1].event_id,
			tf = var_26_0,
			icon = pg.activity_event_monopoly_map[pg.activity_monopolycar2026_map_event[iter_26_1].event_id].icon,
			position = var_26_1
		})
	end

	table.sort(arg_26_0.mapCells, function(arg_27_0, arg_27_1)
		return arg_27_0.mapId < arg_27_1.mapId
	end)
	arg_26_0:InitStoryMap()

	return
end

function var_0_0.SetRollStepAct(arg_28_0, arg_28_1)
	if not arg_28_1 then
		setText(findTF(arg_28_0.rollStep, "animroot/Image/Text"), "00")
	end

	setActive(arg_28_0.rollStep, true)

	return
end

function var_0_0.InitStoryMap(arg_29_0)
	arg_29_0.storyCells = {}

	for iter_29_0, iter_29_1 in ipairs(pg.activity_monopolycar2026_story_event.all) do
		local var_29_0 = pg.activity_monopolycar2026_story_event[iter_29_1]
		local var_29_1 = cloneTplTo(arg_29_0.storyTpl, arg_29_0.storyContainer, tostring(iter_29_1))

		var_29_1.localPosition = Vector3(pg.activity_monopolycar2026_story_event[iter_29_1].pos.x, pg.activity_monopolycar2026_story_event[iter_29_1].pos.y, 0)

		local var_29_2 = var_0_3(pg.activity_monopolycar2026_story_event[iter_29_1])

		if var_29_2 then
			onButton(arg_29_0, var_29_1, function()
				pg.NewStoryMgr.GetInstance():Play(var_29_0.story, nil, true)

				return
			end, SFX_PANEL)
		end

		GetImageSpriteFromAtlasAsync("SquareIcon/" .. pg.ship_skin_template[pg.activity_monopolycar2026_story_event[iter_29_1].icon].prefab, "", (findTF(var_29_1, "Image")))
		setActive(var_29_1, var_29_2)
		table.insert(arg_29_0.storyCells, var_29_1)
	end

	arg_29_0:UpdateStoriesUnlock()
	arg_29_0:UpdateStoryAward()

	return
end

function var_0_0.UpdateStoryAward(arg_31_0)
	local var_31_0 = var_0_6()
	local var_31_1 = var_31_0 and pg.NewStoryMgr.GetInstance():StoryName2StoryId(var_31_0.story)
	local var_31_2 = var_31_1 and pg.story_template[var_31_1]
	local var_31_3

	if var_31_1 and pg.story_template[var_31_1] then
		::label_31_0::

		var_31_3 = var_31_2.drop_client and var_31_2.drop_client[1]
	end

	if var_31_3 then
		updateDrop(arg_31_0.storyAward, {
			type = var_31_3[1],
			id = var_31_3[2],
			count = var_31_3[3]
		})
	end

	return
end

function var_0_0.UpdateStoriesUnlock(arg_32_0)
	local var_32_0 = pg.NewStoryMgr.GetInstance()
	local var_32_1 = 0

	for iter_32_0, iter_32_1 in ipairs(arg_32_0.storyCells) do
		local var_32_2 = false

		if var_0_3((var_0_4(iter_32_0))) then
			var_32_1 = var_32_1 + 1
			var_32_2 = var_32_1 <= arg_32_0.turnCnt
		end

		if var_32_2 and var_32_1 > 1 then
			local var_32_3 = var_0_5(iter_32_0)

			var_32_2 = not var_32_3 or var_32_0:IsPlayed(var_32_3.story)
		end

		setActive(iter_32_1, var_32_2)
	end

	return
end

function var_0_0.InitCar(arg_33_0, arg_33_1)
	arg_33_0.model = findTF(arg_33_0.car, "car")
	arg_33_0.model.transform.localScale = Vector3.one
	arg_33_0.model.transform.localPosition = Vector3.zero

	arg_33_0.model.transform:SetParent(arg_33_0.car, false)

	arg_33_0.modelIconTf = findTF(arg_33_0.model, "icon")
	arg_33_0.modelArrTf = findTF(arg_33_0.model, "arr")

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

function var_0_0.UpdateStory(arg_34_0)
	arg_34_0:UpdateStoriesUnlock()
	arg_34_0:UpdateStoryUI()

	return
end

function var_0_0.UpdateUI(arg_35_0)
	var_0_0.super.UpdateUI(arg_35_0)
	setText(arg_35_0.labelLeftCount2, i18n("monopoly2026_left_cnt", arg_35_0.leftCount))
	setText(arg_35_0.mileageTxt, arg_35_0.pos .. "/" .. #arg_35_0.mapCells .. "KM")
	setText(arg_35_0.labelLeftCount, arg_35_0.leftCount)
	setText(arg_35_0.registerTxt, arg_35_0.turnCnt)
	arg_35_0:UpdateStoriesUnlock()
	arg_35_0:UpdateStoryUI()

	return
end

function var_0_0.UpdateStoryUI(arg_36_0)
	local var_36_0 = 0
	local var_36_1 = 0
	local var_36_2 = false
	local var_36_3 = pg.NewStoryMgr.GetInstance()
	local var_36_4 = 0

	for iter_36_0, iter_36_1 in ipairs(pg.activity_monopolycar2026_story_event.all) do
		local var_36_5 = var_0_3(pg.activity_monopolycar2026_story_event[iter_36_1])

		if var_36_5 then
			var_36_4 = var_36_4 + 1
			var_36_0 = var_36_0 + 1
		end

		local var_36_6 = false

		if var_36_5 then
			local var_36_7 = var_36_3:IsPlayed(pg.activity_monopolycar2026_story_event[iter_36_1].story)

			if var_36_7 then
				var_36_1 = var_36_1 + 1
			end

			local var_36_8 = var_36_4 <= arg_36_0.turnCnt

			if var_36_4 <= arg_36_0.turnCnt and var_36_4 > 1 then
				local var_36_9 = var_0_5(iter_36_0)

				var_36_8 = not var_36_9 or var_36_3:IsPlayed(var_36_9.story)
			end

			var_36_6 = var_36_8 and not var_36_7
			var_36_2 = var_36_2 or var_36_6
		else
			setActive(arg_36_0.storyCells[iter_36_0], false)
		end

		setActive(arg_36_0.storyCells[iter_36_0]:Find("tip"), var_36_6)
	end

	setText(arg_36_0.storyCnt, i18n("monopoly2026_story_award", var_36_1, var_36_0))
	setActive(arg_36_0.storyAwardGot, var_36_0 > 0 and var_36_1 == var_36_0)
	setActive(arg_36_0.storyModeBtnTip, var_36_2)

	return
end

function var_0_0.UpdateCarPos(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_0.model then
		assert(arg_37_0.mapCells[arg_37_1], arg_37_1)

		local var_37_0 = arg_37_0.mapCells[arg_37_1].flip or 0

		arg_37_0:ApplyModelFlip(var_37_0)

		arg_37_0.car.localPosition = arg_37_0.mapCells[arg_37_1].position

		arg_37_0.car:SetAsLastSibling()
	end

	return
end

function var_0_0.ReadyMoveCar(arg_38_0, arg_38_1, arg_38_2)
	if not arg_38_1 or #arg_38_1 <= 0 then
		if arg_38_2 then
			arg_38_2()
		end

		return
	end

	local var_38_0 = {}

	for iter_38_0 = 1, #arg_38_1 do
		table.insert(var_38_0, function(arg_39_0)
			arg_38_0:UpdateCarPos(arg_38_1[iter_38_0], true)
			Timer.New(arg_39_0, 1, 1):Start()

			return
		end)
	end

	seriesAsync(var_38_0, arg_38_2)

	return
end

function var_0_0.ApplyModelFlip(arg_40_0, arg_40_1)
	if not arg_40_0.model then
		return
	end

	if arg_40_0.modelIconTf and arg_40_0.modelIconBasePos then
		local var_40_0 = 0

		if arg_40_1 == 1 then
			local var_40_1 = arg_40_0.modelIconTf:GetComponent(typeof(RectTransform))
			local var_40_2 = arg_40_0.modelArrTf and arg_40_0.modelArrTf:GetComponent(typeof(RectTransform))

			if var_40_1 then
				local var_40_3 = var_40_1.rect.height or 0

				if var_40_2 then
					local var_40_4 = var_40_2.rect.height or 0

					var_40_0 = var_40_3 + var_40_4
					arg_40_0.modelIconTf.localPosition = Vector3(arg_40_0.modelIconBasePos.x, arg_40_0.modelIconBasePos.y - var_40_0, arg_40_0.modelIconBasePos.z)

					if arg_40_0.modelArrTf and arg_40_0.modelArrBaseScale then
						local var_40_5 = arg_40_0.modelArrBaseScale

						arg_40_0.modelArrTf.localScale = Vector3(arg_40_0.modelArrBaseScale.x, arg_40_1 == 1 and -1 or var_40_5.y, arg_40_0.modelArrBaseScale.z)
					end

					return
				end
			end
		end
	end
end

function var_0_0.GetCarMoveType(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	return arg_41_3 and stateWalkB or stateStandB, (Vector3(1, 1, 1))
end

function var_0_0.InitCheerLeaders(arg_42_0, arg_42_1)
	arg_42_0.cheerLeaders = {}

	arg_42_1()

	return
end

function var_0_0.RegisterUI(arg_43_0)
	var_0_0.super.RegisterUI(arg_43_0)
	onToggle(arg_43_0, arg_43_0.mainModeBtn, function(arg_44_0)
		if arg_44_0 then
			arg_43_0:SwitchMode(var_0_1)
		end

		return
	end, SFX_PANEL)
	onToggle(arg_43_0, arg_43_0.storyModeBtn, function(arg_45_0)
		if arg_45_0 then
			arg_43_0:SwitchMode(var_0_2)
		end

		return
	end, SFX_PANEL)
	onButton(arg_43_0, arg_43_0.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_monopoly_car2026.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_43_0, arg_43_0.register, function()
		return
	end, SFX_PANEL)

	return
end

function var_0_0.SwitchMode(arg_48_0, arg_48_1)
	arg_48_0.mode = arg_48_1

	return
end

return var_0_0
