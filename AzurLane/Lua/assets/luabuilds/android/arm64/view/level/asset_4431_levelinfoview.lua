class = var_0_10000

local var_0_0 = "LevelInfoView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "LevelStageInfoView"
end

function var_0_1.OnInit(arg_2_0)
	AutoLoader = var_1_10001
	arg_2_0.loader = var_1_10001.New()

	arg_2_0:InitUI()

	return
end

function var_0_1.OnDestroy(arg_3_0)
	if arg_3_0:isShowing() then
		arg_3_0:Hide()
	end

	arg_3_0.onConfirm = nil
	arg_3_0.onCancel = nil

	if arg_3_0.LTid then
		LeanTween = var_1

		var_1.cancel(arg_3_0.LTid)

		arg_3_0.LTid = nil
	end

	local var_3_0 = arg_3_0.loader

	var_1.Clear(var_3_0)

	return
end

function var_0_1.Show(arg_4_0)
	setActive = var_1_10001

	var_1_10001(arg_4_0._tf, true)
	arg_4_0:BlurPanel(arg_4_0._tf)

	return
end

function var_0_1.Hide(arg_5_0)
	arg_5_0:clear()

	setActive = var_1

	var_1(arg_5_0._tf, false)
	arg_5_0:UnOverlayPanel(arg_5_0._tf, arg_5_0._parentTf)

	return
end

function var_0_1.setCBFunc(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.onConfirm = arg_6_1
	arg_6_0.onCancel = arg_6_2

	return
end

function var_0_1.InitUI(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.titleBG = var_1.Find(var_7_0, "panel/title")

	local var_7_1 = arg_7_0._tf

	arg_7_0.titleBGDecoration = var_1.Find(var_7_1, "panel/title/Image")

	local var_7_2 = arg_7_0._tf

	arg_7_0.titleIcon = var_1.Find(var_7_2, "panel/title/icon")

	local var_7_3 = arg_7_0._tf

	arg_7_0.txTitle = var_1.Find(var_7_3, "panel/title_form")
	arg_7_0.txTitleOriginPosY = arg_7_0.txTitle.anchoredPosition.y

	local var_7_4 = arg_7_0._tf

	arg_7_0.txTitleHead = var_1.Find(var_7_4, "panel/title_head")
	setActive = var_1

	var_1(arg_7_0.txTitleHead, false)

	local var_7_5 = arg_7_0._tf

	arg_7_0.txIntro = var_1.Find(var_7_5, "panel/intro")

	local var_7_6 = arg_7_0._tf

	arg_7_0.txCost = var_1.Find(var_7_6, "panel/cost/text")

	local var_7_7 = arg_7_0._tf

	arg_7_0.progressBar = var_1.Find(var_7_7, "panel/progress")

	local var_7_8 = arg_7_0._tf

	arg_7_0.txProgress = var_1.Find(var_7_8, "panel/progress/Text/value")

	local var_7_9 = arg_7_0._tf

	arg_7_0.progress = var_1.Find(var_7_9, "panel/progress")

	local var_7_10 = arg_7_0._tf

	arg_7_0.head = var_1.Find(var_7_10, "panel/head/Image")

	local var_7_11 = arg_7_0._tf

	arg_7_0.trAchieveTpl = var_1.Find(var_7_11, "panel/achieve")

	local var_7_12 = arg_7_0._tf

	arg_7_0.trAchieves = var_1.Find(var_7_12, "panel/achieves")

	local var_7_13 = arg_7_0._tf

	arg_7_0.passStateMask = var_1.Find(var_7_13, "panel/passState")

	local var_7_14 = arg_7_0._tf

	arg_7_0.passState = var_1.Find(var_7_14, "panel/passState/Image")
	setActive = var_1

	var_1(arg_7_0.passState, true)

	local var_7_15 = arg_7_0._tf

	arg_7_0.winCondDesc = var_1.Find(var_7_15, "panel/win_conditions/desc")

	local var_7_16 = arg_7_0._tf

	arg_7_0.winCondAwardBtn = var_1.Find(var_7_16, "panel/win_conditions/icon")

	local var_7_17 = arg_7_0._tf

	arg_7_0.loseCondDesc = var_1.Find(var_7_17, "panel/lose_conditions/desc")
	UIItemList = var_1
	arg_7_0.achieveList = var_1.New(arg_7_0.trAchieves, arg_7_0.trAchieveTpl)
	setActive = var_1

	var_1(arg_7_0.trAchieveTpl, false)

	local var_7_18 = arg_7_0._tf

	arg_7_0.trDropTpl = var_1.Find(var_7_18, "panel/drops/frame/list/item")

	local var_7_19 = arg_7_0._tf

	arg_7_0.trDrops = var_1.Find(var_7_19, "panel/drops/frame/list")
	UIItemList = var_1
	arg_7_0.dropList = var_1.New(arg_7_0.trDrops, arg_7_0.trDropTpl)

	local var_7_20 = arg_7_0.dropList

	var_1.make(var_7_20, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_7_0

		var_3.updateDrop(var_8_0, arg_8_0, arg_8_1, arg_8_2)

		return
	end)

	setActive = var_1

	var_1(arg_7_0.trDropTpl, false)

	local var_7_21 = arg_7_0._tf

	arg_7_0.btnConfirm = var_1.Find(var_7_21, "panel/start_button")

	local var_7_22 = arg_7_0._tf

	arg_7_0.btnCancel = var_1.Find(var_7_22, "panel/btnBack")

	local var_7_23 = arg_7_0._tf

	arg_7_0.quickPlayGroup = var_1.Find(var_7_23, "panel/quickPlay")

	local var_7_24 = arg_7_0.quickPlayGroup

	arg_7_0.descQuickPlay = var_1.Find(var_7_24, "desc")

	local var_7_25 = arg_7_0.quickPlayGroup
	local var_7_26 = var_1.GetComponent

	typeof = var_4
	Toggle = var_1_10006
	arg_7_0.toggleQuickPlay = var_7_26(var_7_25, var_4(var_1_10006))

	local var_7_27 = arg_7_0._tf

	arg_7_0.bottomExtra = var_1.Find(var_7_27, "panel/BottomExtra")
	GetComponent = var_1

	local var_7_28 = arg_7_0.bottomExtra
	local var_7_29 = var_3.Find(var_7_28, "LoopGroup/view")

	typeof = var_4
	LayoutElement = var_6
	arg_7_0.layoutView = var_1(var_7_29, var_4(var_6))

	local var_7_30 = arg_7_0.bottomExtra

	arg_7_0.rtViewContainer = var_1.Find(var_7_30, "LoopGroup/view/container")
	setText = var_1

	local var_7_31 = arg_7_0.bottomExtra
	local var_7_32 = var_3.Find(var_7_31, "LoopGroup/Loop/Text")

	i18n = var_4

	var_1(var_7_32, var_4("autofight_farm"))

	local var_7_33 = arg_7_0.bottomExtra

	arg_7_0.loopToggle = var_1.Find(var_7_33, "LoopGroup/Loop/Toggle")

	local var_7_34 = arg_7_0.loopToggle

	arg_7_0.loopOn = var_1.Find(var_7_34, "on")

	local var_7_35 = arg_7_0.loopToggle

	arg_7_0.loopOff = var_1.Find(var_7_35, "off")

	local var_7_36 = arg_7_0.bottomExtra

	arg_7_0.loopHelp = var_1.Find(var_7_36, "ButtonHelp")

	local var_7_37 = arg_7_0.bottomExtra

	arg_7_0.costLimitTip = var_1.Find(var_7_37, "LoopGroup/view/container/CostLimit")
	setActive = var_1

	var_1(arg_7_0.costLimitTip, false)

	local var_7_38 = arg_7_0.bottomExtra

	arg_7_0.autoFightToggle = var_1.Find(var_7_38, "LoopGroup/view/container/AutoFight")
	setText = var_1

	local var_7_39 = arg_7_0.autoFightToggle
	local var_7_40 = var_3.Find(var_7_39, "Text")

	i18n = var_4

	var_1(var_7_40, var_4("autofight"))

	arg_7_0.delayTween = {}
	arg_7_0.doEaseIn = true

	return
end

local var_0_2 = 525
local var_0_3 = 373

function var_0_1.set(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0

	arg_9_0.cancelTween(var_9_0)

	getProxy = var_3
	ChapterProxy = var_9_0

	local var_9_1 = var_3(var_9_0)

	arg_9_0.chapter = var_3.getChapterById(var_9_1, arg_9_1, true)

	if not arg_9_2 then
		::label_9_0::

		Vector3 = var_1_10004
		var_1_10004 = var_1_10004(0, 0, 0)
	end

	arg_9_0.posStart = var_1_10004
	getProxy = var_1_10004
	ChapterProxy = var_6

	local var_9_2 = var_1_10004(var_6)
	local var_9_3 = var_4.getMapById(var_9_2, var_3:getConfig("map"))
	local var_9_4 = var_3:getConfigTable()

	string = var_9_2

	local var_9_5 = var_9_2.split(var_9_4.name, "|")
	local var_9_6 = var_3:getPlayType()

	ChapterConst = var_8

	local var_9_7 = var_9_6 == var_8.TypeDefence

	GetSpriteFromAtlasAsync = var_8

	var_8("ui/levelstageinfoview_atlas", var_9_7 and "title_print_defense" or "title_print", function(arg_10_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_9_0.titleBGDecoration) then
			local var_10_0 = arg_9_0.titleBGDecoration
			local var_10_1 = var_1.GetComponent

			typeof = var_2_10004
			Image = var_2_10006
			var_10_1(var_10_0, var_2_10004(var_2_10006)).sprite = arg_10_0
		end

		return
	end)

	GetSpriteFromAtlasAsync = var_8

	var_8("ui/levelstageinfoview_atlas", var_9_7 and "titlebar_bg_defense" or "titlebar_bg", function(arg_11_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_9_0.titleBG) then
			local var_11_0 = arg_9_0.titleBG
			local var_11_1 = var_1.GetComponent

			typeof = var_2_10004
			Image = var_2_10006
			var_11_1(var_11_0, var_2_10004(var_2_10006)).sprite = arg_11_0
		end

		return
	end)

	setActive = var_8

	var_8(arg_9_0.titleIcon, var_9_7)

	local var_9_8 = arg_9_0.progressBar.sizeDelta
	local var_9_9

	if not var_9_7 or not var_0_3 then
		var_9_9 = var_0_2
	end

	var_9_8.x = var_9_9

	local var_9_10 = arg_9_0.progressBar

	var_9_10.sizeDelta = var_9_8
	setText = var_9_10

	local var_9_11 = arg_9_0.txTitle

	var_9_10(var_11.Find(var_9_11, "title_index"), var_9_4.chapter_name .. "  ")

	setText = var_9_10

	local var_9_12 = arg_9_0.txTitle

	var_9_10(var_11.Find(var_9_12, "title"), var_9_5[1])

	setText = var_9_10

	local var_9_13 = arg_9_0.txTitle
	local var_9_14 = var_11.Find(var_9_13, "title_en")
	local var_9_15

	if not var_9_5[2] then
		var_9_15 = ""
	end

	var_9_10(var_9_14, var_9_15)

	setActive = var_9_10

	local var_9_16 = arg_9_0.txTitleHead
	local var_9_17

	if var_9_5[3] then
		var_9_17 = #var_9_5[3] > 0
	end

	var_9_10(var_9_16, var_9_17)

	if var_9_5[3] then
		local var_9_18 = #var_9_5[3]
		local var_9_19

		if not (0 < var_9_18) or not arg_9_0.txTitleOriginPosY then
			var_9_19 = arg_9_0.txTitleOriginPosY + 8
		end

		setAnchoredPosition = var_10

		var_10(arg_9_0.txTitle, {
			y = var_9_19
		})

		setText = var_10

		local var_9_20 = arg_9_0.txTitleHead
		local var_9_21

		if not var_9_5[3] then
			var_9_21 = ""
		end

		var_10(var_9_20, var_9_21)

		setText = var_10

		local var_9_22 = arg_9_0.winCondDesc

		i18n = var_9_21

		local var_9_23 = var_9_21("text_win_condition")
		local var_9_24 = "："

		i18n = var_15

		var_10(var_9_22, var_9_23 .. var_9_24 .. var_15(var_3:getConfig("win_condition_display")))

		setText = var_10

		local var_9_25 = arg_9_0.loseCondDesc

		i18n = var_13

		local var_9_26 = var_13("text_lose_condition")
		local var_9_27 = "："

		i18n = var_15

		var_10(var_9_25, var_9_26 .. var_9_27 .. var_15(var_3:getConfig("lose_condition_display")))

		setActive = var_10

		local var_9_28 = arg_9_0.winCondAwardBtn
		local var_9_29 = var_3:getPlayType()

		ChapterConst = var_9_27

		var_10(var_9_28, var_9_29 == var_9_27.TypeDefence)

		local var_9_30

		if not var_3:existAchieve() then
			setActive = var_9_30

			var_9_30(arg_9_0.passState, false)

			setActive = var_9_30

			var_9_30(arg_9_0.progress, false)

			setActive = var_9_30

			var_9_30(arg_9_0.trAchieves, false)
		else
			setActive = var_9_30

			var_9_30(arg_9_0.passState, true)

			setActive = var_9_30

			var_9_30(arg_9_0.progress, true)

			setActive = var_9_30

			var_9_30(arg_9_0.trAchieves, true)

			var_9_30 = arg_9_0.passState
			Vector3 = var_9_16
			var_9_30.localPosition = var_9_16(-arg_9_0.passState.rect.width, 0, 0)

			local var_9_31 = var_3

			var_9_30 = var_3.hasMitigation(var_9_31)
			setActive = var_9_16

			var_9_16(arg_9_0.passState, var_9_30)

			local var_9_32

			if var_9_30 then
				var_9_16 = var_3:getRiskLevel()
				setImageSprite = var_9_31
				var_9_32 = arg_9_0.passState
				GetSpriteFromAtlas = var_15

				var_9_31(var_9_32, var_15("passstate", var_9_16), true)
			end

			setWidgetText = var_9_16

			local var_9_33 = arg_9_0.progress

			i18n = var_9_32

			var_9_16(var_9_33, var_9_32("levelScene_threat_to_rule_out", ": "))

			table = var_9_16
			var_9_16 = var_9_16.insert

			local var_9_34 = arg_9_0.delayTween

			LeanTween = var_14

			local var_9_35 = var_14.value

			go = var_1_10016
			var_1_10016 = var_9_35(var_1_10016(arg_9_0.progress), 0, var_3.progress, 0.5)
			var_1_10016 = var_14.setDelay(var_1_10016, 0.15)

			local var_9_36 = var_14.setOnUpdate

			System = var_17

			var_9_16(var_9_34, var_9_36(var_1_10016, var_17.Action_float(function(arg_12_0)
				setSlider = var_2_10001

				var_2_10001(arg_9_0.progress, 0, 100, arg_12_0)

				setText = var_2_10001

				local var_12_0 = arg_9_0.txProgress

				math = var_4

				var_2_10001(var_12_0, var_4.floor(arg_12_0) .. "%")

				return
			end)).uniqueId)

			local var_9_37 = arg_9_0.achieveList

			var_9_16.align(var_9_37, #var_3.achieves)

			local var_9_38 = arg_9_0.achieveList

			var_9_16.each(var_9_38, function(arg_13_0, arg_13_1)
				local var_13_0 = var_0.achieves[arg_13_0 + 1]

				findTF = var_3

				local var_13_1 = var_3(arg_13_1, "desc")

				setText = var_2_10004

				local var_13_2 = var_13_1

				ChapterConst = var_2_10007

				var_2_10004(var_13_2, var_2_10007.GetAchieveDesc(var_13_0.type, var_0))

				setTextColor = var_2_10004

				local var_13_3 = var_13_1

				Color = var_7

				var_2_10004(var_13_3, var_7.white)

				setActive = var_2_10004
				findTF = var_13_3

				var_2_10004(var_13_3(arg_13_1, "star"), false)

				setActive = var_2_10004
				findTF = var_6

				var_2_10004(var_6(arg_13_1, "star_empty"), true)

				ChapterConst = var_2_10004

				local var_13_4 = var_2_10004.IsAchieved(var_13_0)

				table = var_5

				local var_13_5 = var_5.insert
				local var_13_6 = arg_9_0.delayTween

				LeanTween = var_8

				local var_13_7 = var_8.delayedCall
				local var_13_8 = 0.15 + (arg_13_0 + 1) * 0.15

				System = var_2_10011

				var_13_5(var_13_6, var_13_7(var_13_8, var_2_10011.Action(function()
					IsNil = var_3_10000

					if not var_3_10000(arg_13_1) then
						findTF = var_0

						local var_14_0

						var_14_0, setTextColor = var_0(arg_13_1, "desc"), var_3_10001

						if var_13_4 then
							Color = var_14_1

							local var_14_1

							if not var_14_1.yellow then
								Color = var_14_1
								var_14_1 = var_14_1.white
							end

							var_3_10001(var_14_0, var_14_1)

							setActive = var_3_10001
							findTF = var_14_0

							var_3_10001(var_14_0(arg_13_1, "star"), var_13_4)

							setActive = var_3_10001
							findTF = var_3

							var_3_10001(var_3(arg_13_1, "star_empty"), not var_13_4)

							return
						end
					end
				end)).uniqueId)

				return
			end)
		end

		setText = var_9_30

		var_9_30(arg_9_0.txIntro, var_9_4.profiles)

		setText = var_9_30

		var_9_30(arg_9_0.txCost, var_9_4.oil)

		if var_9_4.icon and var_9_4.icon[1] then
			setActive = var_10

			var_10(arg_9_0.head.parent, true)

			setImageSprite = var_10

			local var_9_39 = arg_9_0.head

			LoadSprite = var_13

			var_10(var_9_39, var_13("qicon/" .. var_9_4.icon[1]))
		else
			setActive = var_10

			var_10(arg_9_0.head.parent, false)
		end

		arg_9_0.awards = arg_9_0:getChapterAwards()

		local var_9_40 = arg_9_0.dropList

		var_10.align(var_9_40, #arg_9_0.awards)

		local var_9_41 = var_3
		local var_9_42 = var_3.existLoop(var_9_41)

		setActive = var_9_16

		var_9_16(arg_9_0.bottomExtra, var_9_42)

		local var_9_48

		if var_9_42 then
			var_9_16 = var_3:canActivateLoop()
			var_9_41 = "chapter_loop_flag_" .. var_3.id
			PlayerPrefs = var_13

			local var_9_43 = (var_13.GetInt(var_9_41, -1) == 1 or var_13 == -1) and var_9_16
			local var_9_44 = #var_3:getConfig("use_oil_limit")
			local var_9_45 = 0 < var_9_44

			setActive = var_1_10016

			var_1_10016(arg_9_0.loopOn, var_9_43)

			setActive = var_1_10016

			var_1_10016(arg_9_0.loopOff, not var_9_43)

			setActive = var_1_10016

			var_1_10016(arg_9_0.costLimitTip, var_9_45)

			onNextTick = var_1_10016

			var_1_10016(function()
				Canvas = var_2_10000

				var_2_10000.ForceUpdateCanvases()

				local var_15_0 = arg_9_0.layoutView
				local var_15_1

				if not var_9_43 or not arg_9_0.rtViewContainer.rect.width then
					var_15_1 = 0
				end

				var_15_0.preferredWidth = var_15_1

				return
			end)

			onButton = var_1_10016

			local var_9_46 = arg_9_0
			local var_9_47 = arg_9_0.loopToggle

			function var_9_48()
				if not var_9_16 then
					pg = var_0

					local var_16_0 = var_0.TipsMgr.GetInstance()
					local var_16_1 = var_0.ShowTips

					i18n = var_2_10003

					var_16_1(var_16_0, var_2_10003("levelScene_activate_loop_mode_failed"))

					return
				end

				local var_16_2 = not arg_9_0.loopOn.gameObject.activeSelf

				PlayerPrefs = var_2_10001

				var_2_10001.SetInt(var_9_41, var_16_2 and 1 or 0)

				PlayerPrefs = var_1

				var_1.Save()

				setActive = var_1

				var_1(arg_9_0.loopOn, var_16_2)

				setActive = var_1

				var_1(arg_9_0.loopOff, not var_16_2)

				local var_16_3 = 0
				local var_16_4 = 0

				if var_16_2 then
					var_16_4 = arg_9_0.rtViewContainer.rect.width
				else
					var_16_3 = arg_9_0.rtViewContainer.rect.width
				end

				if arg_9_0.LTid then
					LeanTween = var_3

					var_3.cancel(arg_9_0.LTid)

					arg_9_0.LTid = nil
				end

				local var_16_5 = arg_9_0

				LeanTween = var_4

				local var_16_6 = var_4.value(var_16_3, var_16_4, 0.3)
				local var_16_7 = var_4.setOnUpdate

				System = var_7

				local var_16_8 = var_16_7(var_16_6, var_7.Action_float(function(arg_17_0)
					arg_9_0.layoutView.preferredWidth = arg_17_0

					return
				end))
				local var_16_9 = var_4.setOnComplete

				System = var_7
				var_16_5.LTid = var_16_9(var_16_8, var_7.Action(function()
					arg_9_0.LTid = nil

					return
				end)).uniqueId

				return
			end

			SFX_PANEL = var_1_10021

			var_1_10016(var_9_46, var_9_47, var_9_48, var_1_10021)

			onButton = var_1_10016

			var_1_10016(arg_9_0, arg_9_0.loopHelp, function()
				pg = var_2_10000

				local var_19_0 = var_2_10000.MsgboxMgr.GetInstance()
				local var_19_1 = var_0.ShowMsgBox
				local var_19_2 = {}

				MSGBOX_TYPE_HELP = var_2_10004
				var_19_2.type = var_2_10004
				i18n = var_2_10004
				var_19_2.helps = var_2_10004("levelScene_loop_help_tip")

				var_19_1(var_19_0, var_19_2)

				return
			end)

			AutoBotCommand = var_1_10016
			var_1_10016 = var_1_10016.autoBotSatisfied()

			local var_9_49 = "chapter_autofight_flag_" .. var_3.id
			local var_9_50

			if var_1_10016 then
				::label_9_1::

				PlayerPrefs = var_9_50
				var_9_50 = var_9_50.GetInt(var_9_49, 1) == 1
			end

			onToggle = var_19

			local var_9_51 = arg_9_0
			local var_9_52 = arg_9_0.autoFightToggle

			local function var_9_53(arg_20_0)
				if arg_20_0 ~= var_9_50 then
					var_9_50 = arg_20_0
					PlayerPrefs = var_1

					var_1.SetInt(var_9_49, var_9_50 and 1 or 0)

					PlayerPrefs = var_1

					var_1.Save()
				end

				return
			end

			SFX_UI_TAG = var_1_10024

			var_19(var_9_51, var_9_52, var_9_53, var_1_10024)

			triggerToggle = var_19

			var_19(arg_9_0.autoFightToggle, var_9_50)

			setActive = var_19

			var_19(arg_9_0.autoFightToggle, var_1_10016)
		end

		onButton = var_9_16

		local var_9_54 = arg_9_0
		local var_9_55 = arg_9_0.btnConfirm

		local function var_9_56()
			getProxy = var_2_10000
			BayProxy = var_2_10002

			local var_21_0 = var_2_10000(var_2_10002)
			local var_21_1 = var_0.getShipCount(var_21_0)

			getProxy = var_2_10002
			PlayerProxy = var_2_10004

			local var_21_2 = var_2_10002(var_2_10004)
			local var_21_3 = var_2.getRawData(var_21_2)

			if var_2.getMaxShipBag(var_21_3) <= var_21_1 then
				NoPosMsgBox = var_3
				i18n = var_21_3

				local var_21_4 = var_21_3("switch_to_shop_tip_noDockyard")

				openDockyardClear = var_2_10006
				gotoChargeScene = var_7
				openDockyardIntensify = var_2_10008

				var_3(var_21_4, var_2_10006, var_7, var_2_10008)

				return
			end

			if not arg_9_0.onConfirm then
				return
			end

			local var_21_5

			if var_9_42 then
				var_21_5 = arg_9_0.loopOn.gameObject.activeSelf
			end

			local var_21_6 = var_21_5 and 1 or 0

			arg_9_0.onConfirm(arg_9_1, var_21_6)

			return
		end

		SFX_UI_WEIGHANCHOR_GO = var_1_10016

		var_9_16(var_9_54, var_9_55, var_9_56, var_1_10016)

		onButton = var_9_16

		local var_9_57 = arg_9_0
		local var_9_58 = arg_9_0.btnCancel

		local function var_9_59()
			if arg_9_0.onCancel then
				arg_9_0.onCancel()
			end

			return
		end

		SFX_CANCEL = var_1_10016

		var_9_16(var_9_57, var_9_58, var_9_59, var_1_10016)

		onButton = var_9_16

		local var_9_60 = arg_9_0
		local var_9_61 = arg_9_0._tf
		local var_9_62 = var_14.Find(var_9_61, "bg")

		local function var_9_63()
			if arg_9_0.onCancel then
				arg_9_0.onCancel()
			end

			return
		end

		SFX_CANCEL = var_9_61

		var_9_16(var_9_60, var_9_62, var_9_63, var_9_61)

		local var_9_64 = var_3

		if not var_3.getConfig(var_9_64, "risk_levels") then
			local var_9_65 = {}
		end

		onButton = var_9_41

		local var_9_66 = arg_9_0
		local var_9_67 = arg_9_0.passState

		local function var_9_68()
			local var_24_0 = var_0

			if not var_0.hasMitigation(var_24_0) then
				return
			end

			i18n = var_0

			local var_24_1 = "level_risk_level_desc"
			local var_24_2 = var_0
			local var_24_3 = var_0(var_24_1, var_3.getChapterState(var_24_2))

			i18n = var_2_10001

			local var_24_4 = "level_risk_level_mitigation_rate"
			local var_24_5 = var_0
			local var_24_6 = var_4.getRemainPassCount(var_24_5)
			local var_24_7 = var_0
			local var_24_8 = var_24_3 .. var_2_10001(var_24_4, var_24_6, var_5.getMitigationRate(var_24_7))
			local var_24_9 = var_9_3
			local var_24_10 = var_1.getMapType(var_24_9)

			Map = var_24_1

			if var_24_10 == var_24_1.ELITE then
				var_24_10 = var_24_8

				local var_24_11 = "\n"

				i18n = var_24_9
				var_24_8 = var_24_10 .. var_24_11 .. var_24_9("level_diffcult_chapter_state_safety")
			end

			pg = var_24_10

			local var_24_12 = var_24_10.MsgboxMgr.GetInstance()

			var_1.ShowMsgBox(var_24_12, {
				hideNo = true,
				content = var_24_8
			})

			return
		end

		SFX_PANEL = var_17

		var_9_41(var_9_66, var_9_67, var_9_68, var_17)

		onButton = var_9_41

		local var_9_69 = arg_9_0
		local var_9_70 = arg_9_0.head

		local function var_9_71()
			triggerButton = var_2_10000

			var_2_10000(arg_9_0.passState)

			return
		end

		SFX_PANEL = var_17

		var_9_41(var_9_69, var_9_70, var_9_71, var_17)

		onButton = var_9_41

		var_9_41(arg_9_0, arg_9_0.winCondAwardBtn, function()
			local var_26_0 = arg_9_0

			var_0.ShowChapterRewardPanel(var_26_0)

			return
		end)

		setText = var_9_41

		local var_9_72 = arg_9_0.descQuickPlay

		i18n = var_15

		var_9_41(var_9_72, var_15("desc_quick_play"))

		local var_9_73 = var_3:CanQuickPlay()

		setActive = var_9_64

		var_9_64(arg_9_0.quickPlayGroup, var_9_73)

		local var_9_76

		if var_9_73 then
			local var_9_74 = "chapter_quickPlay_flag_" .. var_3.id

			PlayerPrefs = var_14

			local var_9_75 = var_14.GetInt(var_9_74, 1)

			onToggle = var_15
			var_9_76 = arg_9_0

			local var_9_77 = arg_9_0.toggleQuickPlay

			local function var_9_78(arg_27_0)
				PlayerPrefs = var_2_10001

				var_2_10001.SetInt(var_9_74, arg_27_0 and 1 or 0)

				PlayerPrefs = var_1

				var_1.Save()

				return
			end

			SFX_PANEL = var_9_48

			var_15(var_9_76, var_9_77, var_9_78, var_9_48)

			triggerToggle = var_15

			var_15(arg_9_0.toggleQuickPlay, var_9_75 == 1)
		end

		if arg_9_0.doEaseIn then
			local var_9_79 = arg_9_0._tf
			local var_9_80 = var_13.Find(var_9_79, "panel").transform

			var_9_80.localPosition = arg_9_0.posStart
			table = var_9_80

			local var_9_81 = var_9_80.insert
			local var_9_82 = arg_9_0.delayTween

			LeanTween = var_9_76

			local var_9_83 = var_9_76.move
			local var_9_84 = var_13

			Vector3 = var_9_48

			var_9_81(var_9_82, var_9_83(var_9_84, var_9_48.zero, 0.2).uniqueId)

			Vector3 = var_9_81
			var_13.localScale = var_9_81.zero
			table = var_14

			local var_9_85 = var_14.insert
			local var_9_86 = arg_9_0.delayTween

			LeanTween = var_17

			local var_9_87 = var_17.scale
			local var_9_88 = var_13

			Vector3 = var_20

			var_9_85(var_9_86, var_9_87(var_9_88, var_20(1, 1, 1), 0.2).uniqueId)

			table = var_9_85

			local var_9_89 = var_9_85.insert
			local var_9_90 = arg_9_0.delayTween

			LeanTween = var_17

			local var_9_91 = var_17.moveX(arg_9_0.passState, 0, 0.35)
			local var_9_92 = var_17.setEase

			LeanTweenType = var_20

			local var_9_93 = var_9_92(var_9_91, var_20.easeInOutSine)

			var_9_89(var_9_90, var_17.setDelay(var_9_93, 0.3).uniqueId)
		end

		return
	end
end

function var_0_1.cancelTween(arg_28_0)
	_ = var_1_10001

	var_1_10001.each(arg_28_0.delayTween, function(arg_29_0)
		LeanTween = var_2_10001

		var_2_10001.cancel(arg_29_0)

		return
	end)

	arg_28_0.delayTween = {}

	return
end

function var_0_1.updateDrop(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	UIItemList = var_1_10004

	if arg_30_1 == var_1_10004.EventUpdate then
		local var_30_0 = arg_30_0.awards[arg_30_2 + 1]

		Drop = var_5

		local var_30_1 = var_5.Create(var_30_0)

		updateDrop = var_1_10006

		var_1_10006(arg_30_3, var_30_1)

		onButton = var_1_10006

		local var_30_2 = arg_30_0
		local var_30_3 = arg_30_3

		local function var_30_4()
			local var_31_0 = {
				[99] = true
			}
			local var_31_1 = var_30_1
			local var_31_3

			if var_31_0[var_1.getConfig(var_31_1, "type")] then
				local function var_31_2(arg_32_0)
					local var_32_0 = var_30_1
					local var_32_1 = var_1.getConfig(var_32_0, "display_icon")
					local var_32_2 = {}

					ipairs = var_32_0

					for iter_32_0, iter_32_1 in var_32_0(var_32_1) do
						local var_32_3 = iter_32_1[1]
						local var_32_4 = iter_32_1[2]

						DROP_TYPE_SHIP = var_3_10010

						if var_32_3 == var_3_10010 then
							table = var_3_10010
							var_3_10010 = not var_3_10010.contains(arg_32_0, var_32_4)
						else
							var_3_10010 = false
						end

						if false then
							var_3_10010 = true
						end

						var_32_2[#var_32_2 + 1] = {
							type = var_32_3,
							id = var_32_4,
							anonymous = var_3_10010
						}
					end

					local var_32_5 = arg_30_0
					local var_32_6 = var_3.emit

					BaseUI = iter_32_0

					local var_32_7 = iter_32_0.ON_DROP_LIST
					local var_32_8 = {
						item2Row = true,
						itemList = var_32_2
					}
					local var_32_9 = var_30_1

					var_32_8.content = var_8.getConfig(var_32_9, "display")

					var_32_6(var_32_5, var_32_7, var_32_8)

					local var_32_10 = arg_30_0
					local var_32_11 = var_3.initTestShowDrop
					local var_32_12 = var_30_1

					Clone = var_32_8

					var_32_11(var_32_10, var_32_12, var_32_8(var_32_2))

					return
				end

				var_31_3 = arg_30_0

				local var_31_4 = var_2.emit

				LevelMediator2 = var_2_10005

				var_31_4(var_31_3, var_2_10005.GET_CHAPTER_DROP_SHIP_LIST, arg_30_0.chapter.id, var_31_2)
			else
				local var_31_5 = arg_30_0
				local var_31_6 = var_1.emit

				BaseUI = var_31_3

				var_31_6(var_31_5, var_31_3.ON_DROP, var_30_1)
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_30_2, var_30_3, var_30_4, var_1_10011)
	end

	return
end

function var_0_1.getChapterAwards(arg_33_0)
	local var_33_0 = arg_33_0.chapter

	Clone = var_1_10002

	local var_33_1 = var_33_0
	local var_33_2 = var_1_10002(var_33_0.getConfig(var_33_1, "awards"))

	if var_33_0:getStageExtraAwards() then
		for iter_33_0 = #var_3, 1, -1 do
			table = var_1_10008

			var_1_10008.insert(var_33_2, 1, var_3[iter_33_0])
		end
	end

	local var_33_3 = {
		var_33_0:getConfig("boss_expedition_id"),
		var_33_0:getConfig("ai_expedition_list")
	}
	local var_33_4 = var_33_0:getPlayType()

	ChapterConst = var_33_1

	if var_33_4 == var_33_1.TypeMultiStageBoss then
		table = var_33_4
		var_33_4 = var_33_4.insert

		local var_33_5 = var_33_3

		pg = var_8

		var_33_4(var_33_5, var_8.chapter_model_multistageboss[var_33_0.id].boss_expedition_id)
	end

	_ = var_33_4

	local var_33_6 = var_33_4.flatten(var_33_3)
	local var_33_7 = {}
	local var_33_8 = {}

	local function var_33_9(arg_34_0)
		ipairs = var_2_10001

		for iter_34_0, iter_34_1 in var_2_10001(var_33_7) do
			if iter_34_1 == arg_34_0 then
				return false
			end
		end

		return true
	end

	local var_33_10 = {}

	ipairs = var_1_10010

	for iter_33_1, iter_33_2 in var_1_10010(var_33_6) do
		checkExist = var_1_10015
		pg = var_1_10017

		if var_1_10015(var_1_10017.expedition_activity_template[iter_33_2], {
			"pt_drop_display"
		}) then
			type = var_1_10016

			if var_1_10016(var_1_10015) == "table" then
				ipairs = var_1_10016

				for iter_33_3, iter_33_4 in var_1_10016(var_1_10015) do
					local var_33_11 = iter_33_4[1]
					local var_33_12 = iter_33_4[2]
					local var_33_13 = iter_33_4[3]

					if var_33_9(var_33_12) then
						table = var_24

						var_24.insert(var_33_7, var_33_12)

						var_33_8[var_33_12] = {}
					end

					var_33_8[var_33_12][var_33_11] = true

					local var_33_14

					if not var_33_10[var_33_12] then
						var_33_14 = {}
					end

					var_33_10[var_33_12] = var_33_14
					var_33_10[var_33_12][var_33_11] = var_33_13
				end
			end
		end
	end

	getProxy = var_10
	ActivityProxy = var_12

	local var_33_15 = var_10(var_12)

	for iter_33_5 = #var_33_7, 1, -1 do
		pairs = var_1_10015

		for iter_33_6, iter_33_7 in var_1_10015(var_33_8[var_33_7[iter_33_5]]) do
			if var_33_15:getActivityById(iter_33_6) and not var_20:isEnd() then
				table = var_21

				local var_33_16 = var_21.insert
				local var_33_17 = var_33_2
				local var_33_18 = 1
				local var_33_19 = {}

				DROP_TYPE_ITEM = var_1_10026
				var_33_19[1] = var_1_10026
				id2ItemId = var_1_10026
				var_33_19[2] = var_1_10026(var_33_7[iter_33_5])
				var_33_19[3] = var_33_10[var_33_7[iter_33_5]][iter_33_6]

				var_33_16(var_33_17, var_33_18, var_33_19)

				break
			end
		end
	end

	return var_33_2
end

function var_0_1.initTestShowDrop(arg_35_0, arg_35_1, arg_35_2)
	IsUnityEditor = var_1_10003

	if var_1_10003 then
		pg = var_1_10003

		local var_35_0 = var_1_10003.MsgboxMgr.GetInstance()._go.transform
		local var_35_1 = var_4.Find(var_35_0, "button_test_show_drop")

		IsNil = var_1_10005

		if var_1_10005(var_35_1) then
			GameObject = var_5

			local var_35_2 = var_5.New("button_test_show_drop")
			local var_35_3 = var_35_1.AddComponent

			typeof = var_1_10008
			Button = var_1_10010

			var_35_3(var_35_2, var_1_10008(var_1_10010))

			local var_35_4 = var_35_1
			local var_35_5 = var_35_1.AddComponent

			typeof = var_1_10008
			RectTransform = var_1_10010

			var_35_5(var_35_4, var_1_10008(var_1_10010))

			local var_35_6 = var_35_1
			local var_35_7 = var_35_1.AddComponent

			typeof = var_1_10008
			Image = var_1_10010

			var_35_7(var_35_6, var_1_10008(var_1_10010))
		end

		local var_35_8 = var_35_1
		local var_35_9 = var_35_1.GetComponent

		typeof = var_1_10008
		RectTransform = var_1_10010

		local var_35_10 = var_35_9(var_35_8, var_1_10008(var_1_10010))

		var_5.SetParent(var_35_10, var_3.transform, false)

		Vector3 = var_6
		var_5.anchoredPosition = var_6(-239, 173, 0)
		Vector2 = var_6
		var_5.sizeDelta = var_6(40, 40)
		onButton = var_6

		var_6(arg_35_0, var_5, function()
			_ = var_2_10000

			var_2_10000.each(arg_35_2, function(arg_37_0)
				arg_37_0.anonymous = false

				return
			end)

			local var_36_0 = arg_35_0
			local var_36_1 = var_0.emit

			BaseUI = var_3

			local var_36_2 = var_3.ON_DROP_LIST
			local var_36_3 = {
				item2Row = true,
				itemList = arg_35_2
			}
			local var_36_4 = arg_35_1

			var_36_3.content = var_5.getConfig(var_36_4, "display")

			var_36_1(var_36_0, var_36_2, var_36_3)

			return
		end)
	end

	return
end

function var_0_1.clearTestShowDrop(arg_38_0)
	IsUnityEditor = var_1_10001

	if var_1_10001 then
		pg = var_1_10001

		local var_38_0 = var_1_10001.MsgboxMgr.GetInstance()._go.transform
		local var_38_1 = var_2.Find(var_38_0, "button_test_show_drop")

		IsNil = var_1_10003

		if not var_1_10003(var_38_1) then
			Destroy = var_3

			var_3(var_38_1)
		end
	end

	return
end

function var_0_1.ShowChapterRewardPanel(arg_39_0)
	if arg_39_0.rewardPanel == nil then
		ChapterRewardPanel = var_1
		arg_39_0.rewardPanel = var_1.New(arg_39_0._tf.parent, arg_39_0.event, arg_39_0.contextData)

		local var_39_0 = arg_39_0.rewardPanel

		var_1.Load(var_39_0)
	end

	local var_39_1 = arg_39_0.rewardPanel

	var_1.ActionInvoke(var_39_1, "Enter", arg_39_0.chapter)

	return
end

function var_0_1.ClearChapterRewardPanel(arg_40_0)
	if arg_40_0.rewardPanel ~= nil then
		local var_40_0 = arg_40_0.rewardPanel

		var_1.Destroy(var_40_0)

		arg_40_0.rewardPanel = nil
	end

	return
end

function var_0_1.clear(arg_41_0)
	arg_41_0:cancelTween()

	local var_41_0 = arg_41_0.dropList

	var_1.each(var_41_0, function(arg_42_0, arg_42_1)
		clearDrop = var_2_10002

		var_2_10002(arg_42_1)

		return
	end)
	arg_41_0:clearTestShowDrop()
	arg_41_0:ClearChapterRewardPanel()

	return
end

return var_0_1
