class = var_0_10000

local var_0_0 = "DOAPtPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PtTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.buffModule = var_1.Find(var_1_0, "buff_module")

	local var_1_1 = arg_1_0.buffModule

	arg_1_0.buffPanel = var_1.Find(var_1_1, "skill")

	local var_1_2 = {}
	local var_1_3 = arg_1_0.buffPanel

	var_1_2[1] = var_2.Find(var_1_3, "pow_lv")

	local var_1_4 = arg_1_0.buffPanel

	var_1_2[2] = var_2.Find(var_1_4, "tec_lv")

	local var_1_5 = arg_1_0.buffPanel

	var_1_2[3] = var_2.Find(var_1_5, "stm_lv")

	local var_1_6 = arg_1_0.buffPanel

	var_1_2[4] = var_2.Find(var_1_6, "apl_lv")
	arg_1_0.buffLvs = var_1_2

	local var_1_7 = arg_1_0.bg

	arg_1_0.getGreyBtn = var_1.Find(var_1_7, "get_grey_btn")

	local var_1_8 = arg_1_0.bg

	arg_1_0.helpBtn = var_1.Find(var_1_8, "help_btn")

	local var_1_9 = arg_1_0.buffModule

	arg_1_0.levelPanel = var_1.Find(var_1_9, "level")

	local var_1_10 = arg_1_0.levelPanel

	arg_1_0.f2aPanel = var_1.Find(var_1_10, "f_to_a")

	local var_1_11 = arg_1_0.levelPanel

	arg_1_0.sPanel = var_1.Find(var_1_11, "s_ss")

	local var_1_12 = arg_1_0.levelPanel

	arg_1_0.sssPanel = var_1.Find(var_1_12, "sss")

	local var_1_13 = arg_1_0.bg

	arg_1_0.lvBarImages = var_1.Find(var_1_13, "lv_bars")

	local var_1_14 = arg_1_0.bg

	arg_1_0.lvTagImages = var_1.Find(var_1_14, "lv_tags")

	local var_1_15 = arg_1_0.buffModule

	arg_1_0.shieldEffect = var_1.Find(var_1_15, "level/shield_effect")

	local var_1_16 = arg_1_0.buffModule

	arg_1_0.starEffect = var_1.Find(var_1_16, "level/star_effect")

	local var_1_17 = arg_1_0.bg

	arg_1_0.mask = var_1.Find(var_1_17, "mask")

	local var_1_18 = arg_1_0._tf

	arg_1_0.trainWindow = var_1.Find(var_1_18, "TrainWindow")

	local var_1_19 = arg_1_0.trainWindow

	arg_1_0.trainBtn = var_1.Find(var_1_19, "panel/train_btn")

	local var_1_20 = arg_1_0.trainWindow

	arg_1_0.trainSkills = var_1.Find(var_1_20, "panel/skills")

	local var_1_21 = {}
	local var_1_22 = arg_1_0.trainSkills

	var_1_21[1] = var_2.Find(var_1_22, "pow_btn")

	local var_1_23 = arg_1_0.trainSkills

	var_1_21[2] = var_2.Find(var_1_23, "tec_btn")

	local var_1_24 = arg_1_0.trainSkills

	var_1_21[3] = var_2.Find(var_1_24, "stm_btn")

	local var_1_25 = arg_1_0.trainSkills

	var_1_21[4] = var_2.Find(var_1_25, "apl_btn")
	arg_1_0.trainSkillBtns = var_1_21

	local var_1_26 = arg_1_0.trainWindow

	arg_1_0.curInfoPanel = var_1.Find(var_1_26, "panel/info_bg")

	local var_1_27 = arg_1_0.trainWindow

	arg_1_0.curInfo = var_1.Find(var_1_27, "panel/info_bg/cur")

	local var_1_28 = arg_1_0.trainWindow

	arg_1_0.nextInfo = var_1.Find(var_1_28, "panel/info_bg/next")

	local var_1_29 = arg_1_0._tf

	arg_1_0.msgBox = var_1.Find(var_1_29, "MsgBox")

	local var_1_30 = arg_1_0.msgBox

	arg_1_0.msgContent = var_1.Find(var_1_30, "panel/content")

	local var_1_31 = arg_1_0.msgBox

	arg_1_0.msgBoxMask = var_1.Find(var_1_31, "mengban")

	local var_1_32 = arg_1_0.msgBox

	arg_1_0.cancelBtn = var_1.Find(var_1_32, "panel/cancel_btn")

	local var_1_33 = arg_1_0.msgBox

	arg_1_0.confirmBtn = var_1.Find(var_1_33, "panel/confirm_btn")

	local var_1_34 = arg_1_0._tf

	arg_1_0.tipPanel = var_1.Find(var_1_34, "Tip")

	local var_1_35 = arg_1_0._tf

	arg_1_0.buffBox = var_1.Find(var_1_35, "BuffBox")

	local var_1_36 = arg_1_0.buffBox

	arg_1_0.buffMask = var_1.Find(var_1_36, "mask")

	local var_1_37 = arg_1_0.buffBox

	arg_1_0.buffIconParent = var_1.Find(var_1_37, "window/panel/icon")

	local var_1_38 = arg_1_0.buffBox

	arg_1_0.buffDescContent = var_1.Find(var_1_38, "window/panel/intro_view/Viewport/Content")

	local var_1_39 = arg_1_0.buffBox

	arg_1_0.buffDescTpl = var_1.Find(var_1_39, "window/panel/intro_view/buff_desc_tpl")

	local var_1_40 = arg_1_0._tf

	arg_1_0.singleBuffBox = var_1.Find(var_1_40, "SingleBuffBox")

	local var_1_41 = arg_1_0.singleBuffBox

	arg_1_0.singleBuffMask = var_1.Find(var_1_41, "bg")

	local var_1_42 = arg_1_0.singleBuffBox

	arg_1_0.singleSureBtn = var_1.Find(var_1_42, "window/top/btnBack")

	local var_1_43 = arg_1_0.singleBuffBox

	arg_1_0.singleCloseBtn = var_1.Find(var_1_43, "window/sure_btn")

	local var_1_44 = arg_1_0.singleBuffBox

	arg_1_0.singleIconParent = var_1.Find(var_1_44, "window/panel/icon")

	local var_1_45 = arg_1_0.singleBuffBox

	arg_1_0.singleDescContent = var_1.Find(var_1_45, "window/panel/intro_view/Viewport/Content")

	local var_1_46 = arg_1_0.singleBuffBox

	arg_1_0.singleDescTpl = var_1.Find(var_1_46, "window/panel/intro_view/buff_desc_tpl")
	setText = var_1

	local var_1_47 = arg_1_0.singleBuffBox
	local var_1_48 = var_3.Find(var_1_47, "window/top/bg/infomation/title")

	i18n = var_4

	var_1(var_1_48, var_4("words_information"))

	setText = var_1

	local var_1_49 = arg_1_0.singleBuffBox
	local var_1_50 = var_3.Find(var_1_49, "window/sure_btn/pic")

	i18n = var_4

	var_1(var_1_50, var_4("text_confirm"))

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	setActive = var_1

	var_1(arg_2_0.bg, true)

	removeOnButton = var_1

	var_1(arg_2_0.getBtn)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.getBtn

	local function var_2_2()
		local var_3_0 = {}
		local var_3_1 = arg_2_0.ptData
		local var_3_2 = var_1.GetAward(var_3_1)

		getProxy = var_2_10002
		PlayerProxy = var_2_10004

		local var_3_3 = var_2_10002(var_2_10004)
		local var_3_4 = var_2.getData(var_3_3)
		local var_3_5 = var_3_2.type

		DROP_TYPE_RESOURCE = var_3_3

		if var_3_5 == var_3_3 then
			var_3_5 = var_3_2.id
			PlayerConst = var_3_3

			if var_3_5 == var_3_3.ResGold and var_3_4:GoldMax(var_3_2.count) then
				table = var_3_5

				var_3_5.insert(var_3_0, function(arg_4_0)
					pg = var_3_10001

					local var_4_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_4_1 = var_1.ShowMsgBox
					local var_4_2 = {}

					i18n = var_3_10005

					local var_4_3 = var_3_10005("gold_max_tip_title")

					i18n = var_3_10006
					var_4_2.content = var_4_3 .. var_3_10006("award_max_warning")
					var_4_2.onYes = arg_4_0

					var_4_1(var_4_0, var_4_2)

					return
				end)
			end
		end

		seriesAsync = var_3_5

		var_3_5(var_3_0, function()
			arg_2_0.isShowEffect = true

			local var_5_0 = arg_2_0.ptData
			local var_5_2

			if var_0.CanTrain(var_5_0) then
				local var_5_1 = arg_2_0.ptData

				var_5_2 = var_0.isInBuffTime(var_5_1)
			end

			local function var_5_3()
				if var_5_2 then
					local var_6_0 = arg_2_0

					var_0.showUpEffect(var_6_0)
				else
					local var_6_1 = arg_2_0

					var_0.updateLevelPanel(var_6_1)
				end

				return
			end

			local var_5_4 = arg_2_0.ptData
			local var_5_5, var_5_6 = var_2.GetResProgress(var_5_4)
			local var_5_7 = arg_2_0
			local var_5_8 = var_4.emit

			ActivityMediator = var_3_10007

			local var_5_9 = var_3_10007.EVENT_PT_OPERATION
			local var_5_10 = {
				cmd = 1
			}
			local var_5_11 = arg_2_0.ptData

			var_5_10.activity_id = var_9.GetId(var_5_11)
			var_5_10.arg1 = var_5_6
			var_5_10.callback = var_5_3

			var_5_8(var_5_7, var_5_9, var_5_10)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_0, var_2_1, var_2_2, var_1_10006)

	removeOnButton = var_1

	var_1(arg_2_0.battleBtn)

	onButton = var_1

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.battleBtn

	local function var_2_5()
		local var_7_0
		local var_7_1
		local var_7_2 = arg_2_0.activity

		if var_2.getConfig(var_7_2, "config_client") ~= "" then
			local var_7_3 = arg_2_0.activity

			if var_3.getConfig(var_7_3, "config_client").linkActID then
				getProxy = var_3
				ActivityProxy = var_7_3

				local var_7_4 = var_3(var_7_3)

				var_7_1 = var_3.getActivityById(var_7_4, var_7_0)
			end
		end

		if var_2.fightLinkActID then
			local var_7_5 = arg_2_0
			local var_7_6 = var_4.emit

			ActivityMediator = var_2_10007

			var_7_6(var_7_5, var_2_10007.SKIP_ACTIVITY_MAP, var_3)

			return
		end

		if not var_7_0 then
			local var_7_7 = arg_2_0
			local var_7_8 = var_4.emit

			ActivityMediator = var_2_10007

			var_7_8(var_7_7, var_2_10007.BATTLE_OPERA)
		elseif var_7_1 and not var_7_1:isEnd() then
			local var_7_9 = arg_2_0
			local var_7_10 = var_4.emit

			ActivityMediator = var_2_10007

			var_7_10(var_7_9, var_2_10007.BATTLE_OPERA)
		else
			local var_7_11 = arg_2_0
			local var_7_12 = var_4.showTip

			i18n = var_2_10007

			var_7_12(var_7_11, var_2_10007("common_activity_end"))
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_3, var_2_4, var_2_5, var_1_10006)

	onButton = var_1

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.helpBtn

	local function var_2_8()
		pg = var_2_10000

		local var_8_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_8_1 = var_0.ShowMsgBox
		local var_8_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_8_2.type = var_2_10004
		i18n = var_2_10004
		var_8_2.helps = var_2_10004("doa_pt_help")

		var_8_1(var_8_0, var_8_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_6, var_2_7, var_2_8, var_1_10006)

	onButton = var_1

	local var_2_9 = arg_2_0
	local var_2_10 = arg_2_0.buffModule

	local function var_2_11()
		local var_9_0 = arg_2_0

		var_0.showBuffBox(var_9_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_9, var_2_10, var_2_11, var_1_10006)

	if arg_2_0.contextData.singleActivity then
		setActive = var_1

		var_1(arg_2_0.bg, false)
		arg_2_0:showSingleBuffBox()
	end

	local var_2_12 = arg_2_0.starEffect
	local var_2_13 = var_1.GetComponent(var_2_12, "DftAniEvent")

	var_1.SetEndEvent(var_2_13, function()
		local var_10_0 = arg_2_0

		var_0.updateLevelPanel(var_10_0)

		local var_10_1 = arg_2_0
		local var_10_2 = var_0.managedTween

		LeanTween = var_2_10003

		var_10_2(var_10_1, var_2_10003.delayedCall, function()
			local var_11_0 = arg_2_0

			var_0.showTrianPanel(var_11_0)

			setActive = var_0

			var_0(arg_2_0.starEffect, false)

			setActive = var_0

			var_0(arg_2_0.mask, false)

			pg = var_0

			local var_11_1 = var_0.UIMgr.GetInstance()

			var_0.UnOverlayPanel(var_11_1, arg_2_0.mask, arg_2_0.bg)

			return
		end, 0.2, nil)

		return
	end)

	local var_2_14 = arg_2_0.shieldEffect
	local var_2_15 = var_1.GetComponent(var_2_14, "DftAniEvent")

	var_1.SetEndEvent(var_2_15, function()
		local var_12_0 = arg_2_0

		var_0.updateLevelPanel(var_12_0)

		local var_12_1 = arg_2_0
		local var_12_2 = var_0.managedTween

		LeanTween = var_2_10003

		var_12_2(var_12_1, var_2_10003.delayedCall, function()
			local var_13_0 = arg_2_0

			var_0.showTrianPanel(var_13_0)

			setActive = var_0

			var_0(arg_2_0.starEffect, false)

			setActive = var_0

			var_0(arg_2_0.mask, false)

			pg = var_0

			local var_13_1 = var_0.UIMgr.GetInstance()

			var_0.UnOverlayPanel(var_13_1, arg_2_0.mask, arg_2_0.bg)

			return
		end, 0.2, nil)

		return
	end)

	arg_2_0.isShowEffect = false

	return
end

function var_0_1.showUpEffect(arg_14_0, arg_14_1)
	setSlider = var_1_10002

	var_1_10002(arg_14_0.curPanel, 0, 1, 1)

	local var_14_0 = arg_14_0.ptData

	if var_2.GetBuffLevelProgress(var_14_0) == 8 or var_2 == 9 then
		setActive = var_1_10003

		var_1_10003(arg_14_0.starEffect, true)

		local var_14_1 = arg_14_0.starEffect
		local var_14_2 = var_1_10003.GetComponent(var_14_1, "Animator")

		var_1_10003.Play(var_14_2, "saoguang_anim", -1, 0)
	else
		setActive = var_1_10003

		var_1_10003(arg_14_0.shieldEffect, true)

		local var_14_3 = arg_14_0.shieldEffect
		local var_14_4 = var_1_10003.GetComponent(var_14_3, "Animator")

		var_1_10003.Play(var_14_4, "saoguang_anim", -1, 0)
	end

	setActive = var_1_10003

	var_1_10003(arg_14_0.mask, true)

	pg = var_1_10003

	local var_14_5 = var_1_10003.UIMgr.GetInstance()

	var_3.OverlayPanel(var_14_5, arg_14_0.mask)

	return
end

function var_0_1.updateLevelPanel(arg_15_0)
	local var_15_0 = arg_15_0.ptData
	local var_15_1, var_15_2 = var_1.GetBuffLevelProgress(var_15_0)

	setActive = var_15_0

	var_15_0(arg_15_0.f2aPanel, false)

	setActive = var_15_0

	var_15_0(arg_15_0.sPanel, false)

	setActive = var_15_0

	var_15_0(arg_15_0.sssPanel, false)

	arg_15_0.curPanel = nil

	if var_15_1 == 9 then
		arg_15_0.curPanel = arg_15_0.sssPanel
	elseif 6 < var_15_1 then
		arg_15_0.curPanel = arg_15_0.sPanel
	else
		arg_15_0.curPanel = arg_15_0.f2aPanel
	end

	setActive = var_3

	var_3(arg_15_0.curPanel, true)

	setImageSprite = var_3

	local var_15_3 = arg_15_0.curPanel
	local var_15_4 = var_5.Find(var_15_3, "bar")
	local var_15_5 = arg_15_0.lvBarImages
	local var_15_6 = var_6.Find(var_15_5, var_15_1)
	local var_15_7 = var_6.GetComponent

	typeof = var_9
	Image = var_1_10011

	var_3(var_15_4, var_15_7(var_15_6, var_9(var_1_10011)).sprite)

	setImageSprite = var_3

	local var_15_8 = arg_15_0.curPanel
	local var_15_9 = var_5.Find(var_15_8, "lv_tag")
	local var_15_10 = arg_15_0.lvTagImages
	local var_15_11 = var_6.Find(var_15_10, var_15_1)
	local var_15_12 = var_6.GetComponent

	typeof = var_9
	Image = var_1_10011

	var_3(var_15_9, var_15_12(var_15_11, var_9(var_1_10011)).sprite, true)

	setSlider = var_3

	var_3(arg_15_0.curPanel, 0, 1, var_15_2)

	return arg_15_0.curPanel
end

function var_0_1.OnUpdateFlush(arg_16_0)
	setActive = var_1_10001

	var_1_10001(arg_16_0.starEffect, false)

	setActive = var_1_10001

	var_1_10001(arg_16_0.shieldEffect, false)

	local var_16_0 = arg_16_0.ptData

	if var_1.CanTrain(var_16_0) and var_1 <= arg_16_0.ptData.level then
		local var_16_1 = arg_16_0.ptData

		if var_2.isInBuffTime(var_16_1) and not arg_16_0.contextData.singleActivity and not arg_16_0.isShowEffect then
			arg_16_0:showTrianPanel()
		end
	end

	local var_16_2 = arg_16_0.ptData
	local var_16_3, var_16_4, var_16_5 = var_2.GetLevelProgress(var_16_2)
	local var_16_6 = arg_16_0.ptData
	local var_16_7, var_16_8, var_16_9 = var_5.GetResProgress(var_16_6)

	setText = var_1_10008

	var_1_10008(arg_16_0.step, var_16_3 .. "/" .. var_16_4)

	setText = var_1_10008

	local var_16_10 = arg_16_0.progress

	if 1 <= var_16_9 then
		setColorStr = var_11

		local var_16_11 = var_16_7

		COLOR_GREEN = var_1_10014

		local var_16_12

		if not var_11(var_16_11, var_1_10014) then
			var_16_12 = var_16_7
		end

		var_1_10008(var_16_10, var_16_12 .. "/" .. var_16_8)

		setSlider = var_1_10008

		var_1_10008(arg_16_0.slider, 0, 1, var_16_9)

		if not arg_16_0.isShowEffect then
			arg_16_0:updateLevelPanel()
		end

		local var_16_13 = arg_16_0.ptData
		local var_16_14 = var_8.CanGetAward(var_16_13)
		local var_16_15 = arg_16_0.ptData
		local var_16_16 = var_9.CanGetNextAward(var_16_15)
		local var_16_17 = arg_16_0.ptData
		local var_16_18 = var_10.CanGetMorePt(var_16_17)
		local var_16_19 = arg_16_0.ptData
		local var_16_20 = var_11.CanTrain(var_16_19)

		setActive = var_16_17

		var_16_17(arg_16_0.battleBtn, var_16_18 and not var_16_14 and var_16_16)

		setActive = var_16_17

		var_16_17(arg_16_0.getBtn, var_16_14)

		setActive = var_16_17

		var_16_17(arg_16_0.getGreyBtn, not var_16_14)

		setActive = var_16_17

		var_16_17(arg_16_0.gotBtn, not var_16_16 and not var_16_20)

		setActive = var_16_17

		local var_16_21 = arg_16_0.buffModule
		local var_16_22 = arg_16_0.ptData

		var_16_17(var_16_21, var_15.isInBuffTime(var_16_22))

		local var_16_23 = arg_16_0.ptData
		local var_16_24 = var_12.GetAward(var_16_23)

		updateDrop = var_16_19

		var_16_19(arg_16_0.awardTF, var_16_24)

		onButton = var_16_19

		local var_16_25 = arg_16_0
		local var_16_26 = arg_16_0.awardTF

		local function var_16_27()
			local var_17_0 = arg_16_0
			local var_17_1 = var_0.emit

			BaseUI = var_2_10003

			var_17_1(var_17_0, var_2_10003.ON_DROP, var_16_24)

			return
		end

		SFX_PANEL = var_1_10018

		var_16_19(var_16_25, var_16_26, var_16_27, var_1_10018)

		ipairs = var_16_19

		local var_16_28 = arg_16_0.ptData

		for iter_16_0, iter_16_1 in var_16_19(var_15.GetCurBuffInfos(var_16_28)) do
			setText = var_1_10018

			local var_16_29 = arg_16_0.buffLvs[iter_16_1.group]
			local var_16_30

			if not iter_16_1.next or not ("LV." .. iter_16_1.lv) then
				var_16_30 = "MAX"
			end

			var_1_10018(var_16_29, var_16_30)
		end

		return
	end
end

function var_0_1.showTrianPanel(arg_18_0)
	setActive = var_1_10001

	var_1_10001(arg_18_0.trainWindow, true)

	local var_18_0 = arg_18_0.ptData
	local var_18_1 = var_1.GetCurBuffInfos(var_18_0)

	arg_18_0.selectIndex = nil
	arg_18_0.selectBuffId = nil
	arg_18_0.selectBuffLv = nil
	arg_18_0.selectNewBuffId = nil
	ipairs = var_2

	for iter_18_0, iter_18_1 in var_2(arg_18_0.trainSkillBtns) do
		onButton = var_1_10007

		local var_18_2 = arg_18_0
		local var_18_3 = iter_18_1

		local function var_18_4()
			ipairs = var_2_10000

			for iter_19_0, iter_19_1 in var_2_10000(var_18_1) do
				if iter_18_0 == iter_19_1.group then
					if iter_19_1.next then
						arg_18_0.selectIndex = iter_18_0
						arg_18_0.selectBuffId = iter_19_1.id
						arg_18_0.selectNewBuffId = iter_19_1.next
						arg_18_0.selectBuffLv = iter_19_1.lv
					else
						arg_18_0.selectIndex = nil
						arg_18_0.selectBuffId = nil
						arg_18_0.selectNewBuffId = nil
						arg_18_0.selectBuffLv = nil
					end
				end
			end

			local var_19_0 = arg_18_0

			var_0.flushTrainPanel(var_19_0)

			return
		end

		SFX_PANEL = var_1_10012

		var_1_10007(var_18_2, var_18_3, var_18_4, var_1_10012)
	end

	onButton = var_2

	local var_18_5 = arg_18_0
	local var_18_6 = arg_18_0.trainBtn

	local function var_18_7()
		local var_20_0 = arg_18_0

		var_0.showMsgBox(var_20_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_18_5, var_18_6, var_18_7, var_1_10007)
	;(function()
		ipairs = var_2_10000

		for iter_21_0, iter_21_1 in var_2_10000(var_18_1) do
			if iter_21_1.next then
				arg_18_0.selectIndex = iter_21_1.group
				arg_18_0.selectBuffId = iter_21_1.id
				arg_18_0.selectNewBuffId = iter_21_1.next
				arg_18_0.selectBuffLv = iter_21_1.lv

				return
			end
		end

		return
	end)()
	arg_18_0:flushTrainPanel()

	return
end

function var_0_1.hideTrianPanel(arg_22_0)
	setActive = var_1_10001

	var_1_10001(arg_22_0.trainWindow, false)

	return
end

function var_0_1.flushTrainPanel(arg_23_0)
	local var_23_0 = arg_23_0.ptData

	if var_1.GetCurBuffInfos(var_23_0) then
		ipairs = var_1_10002

		for iter_23_0, iter_23_1 in var_1_10002(var_1) do
			setText = var_1_10007

			local var_23_1 = arg_23_0.trainSkillBtns[iter_23_1.group]
			local var_23_2 = var_9.Find(var_23_1, "lv_bg/lv")
			local var_23_3

			if not iter_23_1.next or not ("LV." .. iter_23_1.lv) then
				var_23_3 = "MAX"
			end

			var_1_10007(var_23_2, var_23_3)
		end
	end

	ipairs = var_1_10002

	for iter_23_2, iter_23_3 in var_1_10002(arg_23_0.trainSkillBtns) do
		if iter_23_2 == arg_23_0.selectIndex then
			setActive = var_7

			var_7(iter_23_3:Find("selected"), true)
		else
			setActive = var_7

			var_7(iter_23_3:Find("selected"), false)
		end
	end

	if arg_23_0.selectIndex then
		setActive = var_2

		var_2(arg_23_0.curInfoPanel, true)

		setActive = var_2

		var_2(arg_23_0.trainBtn, true)

		setText = var_2

		local var_23_4 = arg_23_0.curInfo

		pg = var_5

		var_2(var_23_4, var_5.benefit_buff_template[arg_23_0.selectBuffId].desc)

		setText = var_2

		local var_23_5 = arg_23_0.nextInfo

		pg = var_5

		var_2(var_23_5, var_5.benefit_buff_template[arg_23_0.selectNewBuffId].desc)
	else
		setActive = var_2

		var_2(arg_23_0.curInfoPanel, false)

		setActive = var_2

		var_2(arg_23_0.trainBtn, false)
	end

	return
end

function var_0_1.getBuffNameIndex(arg_24_0, arg_24_1)
	if arg_24_1 == 35 or arg_24_1 == 36 or arg_24_1 == 37 then
		return 1
	elseif arg_24_1 == 38 or arg_24_1 == 39 or arg_24_1 == 40 then
		return 2
	elseif arg_24_1 == 41 or arg_24_1 == 42 or arg_24_1 == 43 then
		return 3
	elseif arg_24_1 == 44 or arg_24_1 == 45 or arg_24_1 == 46 then
		return 4
	end

	return 1
end

function var_0_1.getTip(arg_25_0, arg_25_1)
	if arg_25_1 == 35 or arg_25_1 == 36 or arg_25_1 == 37 then
		i18n = var_1_10002

		return var_1_10002("doa_liliang")
	elseif arg_25_1 == 38 or arg_25_1 == 39 or arg_25_1 == 40 then
		i18n = var_1_10002

		return var_1_10002("doa_jiqiao")
	elseif arg_25_1 == 41 or arg_25_1 == 42 or arg_25_1 == 43 then
		i18n = var_1_10002

		return var_1_10002("doa_tili")
	elseif arg_25_1 == 44 or arg_25_1 == 45 or arg_25_1 == 46 then
		i18n = var_1_10002

		return var_1_10002("doa_meili")
	end

	return ""
end

function var_0_1.showMsgBox(arg_26_0)
	if arg_26_0.selectBuffId then
		setActive = var_1

		var_1(arg_26_0.msgBox, true)

		setText = var_1

		local var_26_0 = arg_26_0.msgContent

		i18n = var_4

		local var_26_1 = "doa_pt_up"
		local var_26_2 = arg_26_0
		local var_26_3 = arg_26_0.getTip

		pg = var_1_10010

		var_1(var_26_0, var_4(var_26_1, var_26_3(var_26_2, var_1_10010.benefit_buff_template[arg_26_0.selectBuffId].id)))

		onButton = var_1

		local var_26_4 = arg_26_0
		local var_26_5 = arg_26_0.msgBoxMask

		local function var_26_6()
			local var_27_0 = arg_26_0

			var_0.hideMsgBox(var_27_0)

			return
		end

		SFX_PANEL = var_26_1

		var_1(var_26_4, var_26_5, var_26_6, var_26_1)

		onButton = var_1

		local var_26_7 = arg_26_0
		local var_26_8 = arg_26_0.cancelBtn

		local function var_26_9()
			local var_28_0 = arg_26_0

			var_0.hideMsgBox(var_28_0)

			return
		end

		SFX_PANEL = var_26_1

		var_1(var_26_7, var_26_8, var_26_9, var_26_1)

		onButton = var_1

		local var_26_10 = arg_26_0
		local var_26_11 = arg_26_0.confirmBtn

		local function var_26_12()
			local var_29_0 = arg_26_0

			var_0.hideMsgBox(var_29_0)

			local var_29_1 = arg_26_0
			local var_29_2 = var_0.emit

			ActivityMediator = var_2_10003

			local var_29_3 = var_2_10003.EVENT_PT_OPERATION
			local var_29_4 = {
				cmd = 3
			}
			local var_29_5 = arg_26_0.ptData

			var_29_4.activity_id = var_5.GetId(var_29_5)

			local var_29_6 = arg_26_0.ptData

			var_29_4.arg1 = var_5.CanTrain(var_29_6)
			var_29_4.arg2 = arg_26_0.selectNewBuffId
			var_29_4.oldBuffId = arg_26_0.selectBuffId

			var_29_2(var_29_1, var_29_3, var_29_4)

			local var_29_7 = arg_26_0

			var_0.hideTrianPanel(var_29_7)

			local var_29_8 = arg_26_0
			local var_29_9 = var_0.showTip

			i18n = var_29_3

			var_29_9(var_29_8, var_29_3("doa_pt_complete"))

			return
		end

		SFX_PANEL = var_26_1

		var_1(var_26_10, var_26_11, var_26_12, var_26_1)
	end

	return
end

function var_0_1.hideMsgBox(arg_30_0)
	setActive = var_1_10001

	var_1_10001(arg_30_0.msgBox, false)

	return
end

function var_0_1.showTip(arg_31_0, arg_31_1)
	cloneTplTo = var_1_10002

	local var_31_0 = var_1_10002(arg_31_0.tipPanel, arg_31_0._tf)

	setActive = var_1_10003

	var_1_10003(var_31_0, true)

	setText = var_1_10003

	var_1_10003(var_31_0:Find("Text"), arg_31_1)

	local var_31_1 = var_31_0.transform

	Vector3 = var_4
	var_31_1.localScale = var_4(0, 0.1, 1)
	LeanTween = var_31_1

	local var_31_2 = var_31_1.scale
	local var_31_3 = var_31_0

	Vector3 = var_6

	local var_31_4 = var_31_2(var_31_3, var_6(1.8, 0.1, 1), 0.1)

	var_3.setUseEstimatedTime(var_31_4, true)

	LeanTween = var_3

	local var_31_5 = var_3.scale
	local var_31_6 = var_31_0

	Vector3 = var_6

	local var_31_7 = var_31_5(var_31_6, var_6(1.1, 1.1, 1), 0.1)
	local var_31_8 = var_3.setDelay(var_31_7, 0.1)

	var_3.setUseEstimatedTime(var_31_8, true)

	GetOrAddComponent = var_3

	local var_31_9 = var_3(var_31_0, "CanvasGroup")

	Timer = var_4

	local var_31_10 = var_4.New(function()
		IsNil = var_2_10000

		if var_2_10000(var_31_0) then
			return
		end

		LeanTween = var_0

		local var_32_0 = var_0.scale
		local var_32_1 = var_31_0

		Vector3 = var_2_10003

		local var_32_2 = var_32_0(var_32_1, var_2_10003(0.1, 1.5, 1), 0.1)
		local var_32_3 = var_0.setUseEstimatedTime(var_32_2, true)
		local var_32_4 = var_0.setOnComplete

		System = var_3

		var_32_4(var_32_3, var_3.Action(function()
			LeanTween = var_3_10000

			local var_33_0 = var_3_10000.scale
			local var_33_1 = var_31_0

			Vector3 = var_3_10003

			local var_33_2 = var_33_0(var_33_1, var_3_10003.zero, 0.1)
			local var_33_3 = var_0.setUseEstimatedTime(var_33_2, true)
			local var_33_4 = var_0.setOnComplete

			System = var_3

			var_33_4(var_33_3, var_3.Action(function()
				Destroy = var_4_10000

				var_4_10000(var_31_0)

				return
			end))

			return
		end))

		return
	end, 3)

	var_4.Start(var_31_10)

	return
end

function var_0_1.showBuffBox(arg_35_0)
	setActive = var_1_10001

	var_1_10001(arg_35_0.buffBox, true)

	removeAllChildren = var_1_10001

	var_1_10001(arg_35_0.buffIconParent)

	cloneTplTo = var_1_10001

	local var_35_0 = arg_35_0
	local var_35_1 = var_1_10001(arg_35_0.updateLevelPanel(var_35_0), arg_35_0.buffIconParent)

	setLocalPosition = var_1_10002

	local var_35_2 = var_35_1

	Vector3 = var_35_0

	var_1_10002(var_35_2, var_35_0(0, 0, 0))

	setLocalScale = var_1_10002

	local var_35_3 = var_35_1

	Vector3 = var_5

	var_1_10002(var_35_3, var_5(1.3, 1.3, 1))

	local var_35_4 = arg_35_0.ptData

	if var_2.GetCurBuffInfos(var_35_4) then
		ipairs = var_3

		for iter_35_0, iter_35_1 in var_3(var_2) do
			local var_35_5

			if iter_35_0 <= arg_35_0.buffDescContent.childCount then
				local var_35_6 = arg_35_0.buffDescContent

				var_35_5 = var_9.GetChild(var_35_6, iter_35_0 - 1)
			else
				cloneTplTo = var_9
				var_35_5 = var_9(arg_35_0.buffDescTpl, arg_35_0.buffDescContent)
			end

			setText = var_9

			local var_35_7 = var_35_5

			pg = var_1_10012
			var_1_10012 = var_1_10012.benefit_buff_template[iter_35_1.id].name
			pg = var_13

			var_9(var_35_7, var_1_10012 .. var_13.benefit_buff_template[iter_35_1.id].desc)
		end
	end

	onButton = var_3

	local var_35_8 = arg_35_0
	local var_35_9 = arg_35_0.buffMask

	local function var_35_10()
		setActive = var_2_10000

		var_2_10000(arg_35_0.buffBox, false)

		return
	end

	SFX_PANEL = var_35_5

	var_3(var_35_8, var_35_9, var_35_10, var_35_5)

	return
end

function var_0_1.showSingleBuffBox(arg_37_0)
	setActive = var_1_10001

	var_1_10001(arg_37_0.singleBuffBox, true)

	pg = var_1_10001

	local var_37_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_37_0, arg_37_0.singleBuffBox)

	removeAllChildren = var_1

	var_1(arg_37_0.singleIconParent)

	cloneTplTo = var_1

	local var_37_1 = arg_37_0
	local var_37_2 = var_1(arg_37_0.updateLevelPanel(var_37_1), arg_37_0.singleIconParent)

	setLocalPosition = var_1_10002

	local var_37_3 = var_37_2

	Vector3 = var_37_1

	var_1_10002(var_37_3, var_37_1(0, 0, 0))

	setLocalScale = var_1_10002

	local var_37_4 = var_37_2

	Vector3 = var_5

	var_1_10002(var_37_4, var_5(1.3, 1.3, 1))

	local var_37_5 = arg_37_0.ptData

	if var_2.GetCurBuffInfos(var_37_5) then
		ipairs = var_3

		for iter_37_0, iter_37_1 in var_3(var_2) do
			local var_37_6

			if iter_37_0 <= arg_37_0.singleDescContent.childCount then
				local var_37_7 = arg_37_0.singleDescContent

				var_37_6 = var_9.GetChild(var_37_7, iter_37_0 - 1)
			else
				cloneTplTo = var_9
				var_37_6 = var_9(arg_37_0.singleDescTpl, arg_37_0.singleDescContent)
			end

			setText = var_9

			local var_37_8 = var_37_6

			pg = var_1_10012
			var_1_10012 = var_1_10012.benefit_buff_template[iter_37_1.id].name
			pg = var_13

			var_9(var_37_8, var_1_10012 .. var_13.benefit_buff_template[iter_37_1.id].desc)
		end
	end

	local function var_37_9()
		setActive = var_2_10000

		var_2_10000(arg_37_0.singleBuffBox, false)

		local var_38_0 = arg_37_0
		local var_38_1 = var_0.emit

		ActivitySingleScene = var_3

		var_38_1(var_38_0, var_3.EXIT)

		local var_38_2 = arg_37_0
		local var_38_3 = var_0.emit

		ActivitySingleScene = var_3

		var_38_3(var_38_2, var_3.ON_CLOSE)

		pg = var_38_3

		local var_38_4 = var_38_3.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_38_4, arg_37_0.singleBuffBox, arg_37_0._tf)

		return
	end

	onButton = var_37_5

	local var_37_10 = arg_37_0
	local var_37_11 = arg_37_0.singleBuffMask

	local function var_37_12()
		var_37_9()

		return
	end

	SFX_PANEL = var_9

	var_37_5(var_37_10, var_37_11, var_37_12, var_9)

	onButton = var_37_5

	local var_37_13 = arg_37_0
	local var_37_14 = arg_37_0.singleCloseBtn

	local function var_37_15()
		var_37_9()

		return
	end

	SFX_PANEL = var_9

	var_37_5(var_37_13, var_37_14, var_37_15, var_9)

	onButton = var_37_5

	local var_37_16 = arg_37_0
	local var_37_17 = arg_37_0.singleSureBtn

	local function var_37_18()
		var_37_9()

		return
	end

	SFX_PANEL = var_9

	var_37_5(var_37_16, var_37_17, var_37_18, var_9)

	return
end

function var_0_1.onBackPressed(arg_42_0)
	if arg_42_0.contextData.singleActivity then
		pg = var_1

		local var_42_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_42_0, arg_42_0.singleBuffBox, arg_42_0._tf)
	end

	return
end

function var_0_1.willExit(arg_43_0)
	if arg_43_0.contextData.singleActivity then
		pg = var_1

		local var_43_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_43_0, arg_43_0.singleBuffBox, arg_43_0._tf)
	end

	return
end

return var_0_1
