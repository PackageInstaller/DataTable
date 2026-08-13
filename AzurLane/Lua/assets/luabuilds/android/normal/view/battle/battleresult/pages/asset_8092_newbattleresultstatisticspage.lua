class = var_0_10000

local var_0_0 = "NewBattleResultStatisticsPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 0
local var_0_5 = 1

function var_0_1.getUIName(arg_1_0)
	return "NewBattleResultStatisticsPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.mask = var_1.Find(var_2_0, "mask")

	local var_2_1 = arg_2_0._tf

	arg_2_0.paintingTr = var_1.Find(var_2_1, "painting")

	local var_2_2 = arg_2_0._tf

	arg_2_0.resultPaintingTr = var_1.Find(var_2_2, "result")

	local var_2_3 = arg_2_0._tf

	arg_2_0.topPanel = var_1.Find(var_2_3, "top")

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "top/grade/icon")
	local var_2_6 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.gradeIcon = var_2_6(var_2_5, var_3(var_1_10004))

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_1.Find(var_2_7, "top/grade/Text")
	local var_2_9 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.gradeTxt = var_2_9(var_2_8, var_3(var_1_10004))

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_1.Find(var_2_10, "top/grade/chapterName")
	local var_2_12 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.chapterName = var_2_12(var_2_11, var_3(var_1_10004))

	local var_2_13 = arg_2_0._tf

	arg_2_0.opBonus = var_1.Find(var_2_13, "top/grade/operation_bonus")

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_1.Find(var_2_14, "top/exp/name")
	local var_2_16 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.playerName = var_2_16(var_2_15, var_3(var_1_10004))

	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_1.Find(var_2_17, "top/exp/lv")
	local var_2_19 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.playerLv = var_2_19(var_2_18, var_3(var_1_10004))

	local var_2_20 = arg_2_0._tf
	local var_2_21 = var_1.Find(var_2_20, "top/exp/Text")
	local var_2_22 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.playerExp = var_2_22(var_2_21, var_3(var_1_10004))

	local var_2_23 = arg_2_0._tf
	local var_2_24 = var_1.Find(var_2_23, "top/exp/Text/exp_label")
	local var_2_25 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.playerExpLabel = var_2_25(var_2_24, var_3(var_1_10004))

	local var_2_26 = arg_2_0._tf
	local var_2_27 = var_1.Find(var_2_26, "top/exp/exp_bar/progress")
	local var_2_28 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.playerExpBar = var_2_28(var_2_27, var_3(var_1_10004))

	local var_2_29 = arg_2_0._tf

	arg_2_0.commmanderContainer = var_1.Find(var_2_29, "top/exp/commanders")

	local var_2_30 = arg_2_0._tf

	arg_2_0.shipContainer = var_1.Find(var_2_30, "left")

	local var_2_31 = arg_2_0._tf
	local var_2_32 = var_1.Find(var_2_31, "bg")
	local var_2_33 = var_1.GetComponent

	typeof = var_3
	RawImage = var_1_10004
	arg_2_0.rawImage = var_2_33(var_2_32, var_3(var_1_10004))
	setActive = var_1

	var_1(arg_2_0.rawImage, false)

	local var_2_34 = arg_2_0._tf

	arg_2_0.blackBg = var_1.Find(var_2_34, "black")

	local var_2_35 = arg_2_0._tf

	arg_2_0.bottomPanel = var_1.Find(var_2_35, "bottom")

	local var_2_36 = arg_2_0._tf

	arg_2_0.confrimBtn = var_1.Find(var_2_36, "bottom/confirmBtn")

	local var_2_37 = arg_2_0._tf

	arg_2_0.statisticsBtn = var_1.Find(var_2_37, "bottom/statisticsBtn")

	local var_2_38 = arg_2_0._tf

	arg_2_0.mainFleetBtn = var_1.Find(var_2_38, "bottom/mainFleetBtn")

	local var_2_39 = arg_2_0._tf

	arg_2_0.subFleetBtn = var_1.Find(var_2_39, "bottom/subFleetBtn")

	local var_2_40 = arg_2_0._tf
	local var_2_41 = var_1.Find(var_2_40, "chat/Text")
	local var_2_42 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.chatText = var_2_42(var_2_41, var_3(var_1_10004))
	setText = var_1

	local var_2_43 = arg_2_0.confrimBtn
	local var_2_44 = var_2.Find(var_2_43, "Text")

	i18n = var_2_43

	var_1(var_2_44, var_2_43("msgbox_text_confirm"))

	GetOrAddComponent = var_1

	local var_2_45 = arg_2_0._tf

	typeof = var_3
	CanvasGroup = var_4
	arg_2_0.cg = var_1(var_2_45, var_3(var_4))
	arg_2_0.commaderTpls = {}

	local var_2_46 = {}
	local var_2_47 = arg_2_0._tf

	var_2_46[1] = var_2.Find(var_2_47, "top/exp/emptycomanders/1")

	local var_2_48 = arg_2_0._tf

	var_2_46[2] = var_2.Find(var_2_48, "top/exp/emptycomanders/2")
	arg_2_0.emptyTpls = var_2_46
	setText = var_2_46

	local var_2_49 = arg_2_0.emptyTpls[1]
	local var_2_50 = var_2.Find(var_2_49, "Text")

	i18n = var_2_49

	var_2_46(var_2_50, var_2_49("series_enemy_empty_commander_main"))

	setText = var_2_46

	local var_2_51 = arg_2_0.emptyTpls[2]
	local var_2_52 = var_2.Find(var_2_51, "Text")

	i18n = var_2_51

	var_2_46(var_2_52, var_2_51("series_enemy_empty_commander_assistant"))

	arg_2_0.surfaceShipTpls = {}
	arg_2_0.subShipTpls = {}
	arg_2_0.animationFlags = {
		[var_0_2] = {
			[var_0_4] = false,
			[var_0_5] = false
		},
		[var_0_3] = {
			[var_0_4] = false,
			[var_0_5] = false
		}
	}
	NewBattleResultAnimation = var_1
	arg_2_0.animation = var_1.New(arg_2_0._tf)

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0.teamType = var_0_2
	arg_3_0.displayMode = var_0_4

	return
end

function var_0_1.SetUp(arg_4_0, arg_4_1, arg_4_2)
	seriesAsync = var_1_10003

	var_1_10003({
		function(arg_5_0)
			arg_4_0.cg.alpha = 0

			local var_5_0 = arg_4_0

			var_1.UpdatePainting(var_5_0, arg_5_0)

			local var_5_1 = arg_4_0

			var_1.UpdateGrade(var_5_1)

			local var_5_2 = arg_4_0

			var_1.UpdateChapterName(var_5_2)

			local var_5_3 = arg_4_0

			var_1.UpdateSwitchBtn(var_5_3)

			local var_5_4 = arg_4_0

			var_1.UpdatePlayer(var_5_4)

			return
		end,
		function(arg_6_0)
			local var_6_0 = arg_4_0

			var_1.LoadBG(var_6_0, arg_6_0)

			return
		end,
		function(arg_7_0)
			arg_4_0.cg.alpha = 1

			local var_7_0 = arg_4_0

			var_1.PlayEnterAnimation(var_7_0, arg_7_0)

			return
		end,
		function(arg_8_0)
			if arg_4_2 then
				arg_4_2()
			end

			local var_8_0 = arg_4_0

			var_1.InitMainView(var_8_0, arg_8_0)

			return
		end
	}, function()
		local var_9_0 = arg_4_0

		var_0.UpdateMetaBtn(var_9_0)

		local var_9_1 = arg_4_0

		var_0.RegisterEvent(var_9_1, arg_4_1)

		return
	end)

	return
end

function var_0_1.InitMainView(arg_10_0, arg_10_1)
	arg_10_0.isEnter = true
	parallelAsync = var_2

	var_2({
		function(arg_11_0)
			local var_11_0 = arg_10_0

			var_1.UpdateCommanders(var_11_0, arg_11_0)

			return
		end,
		function(arg_12_0)
			local var_12_0 = arg_10_0

			var_1.StartEnterAnimation(var_12_0, arg_12_0)

			return
		end,
		function(arg_13_0)
			local var_13_0 = arg_10_0

			var_1.InitShips(var_13_0, arg_13_0)

			return
		end
	}, arg_10_1)

	return
end

function var_0_1.PlayEnterAnimation(arg_14_0, arg_14_1)
	getProxy = var_1_10002
	SettingsProxy = var_1_10003

	local var_14_0 = var_1_10002(var_1_10003)

	if not var_2.IsDisplayResultPainting(var_14_0) then
		if arg_14_0.resultPaintingData == nil then
			arg_14_1()

			return
		end

		local var_14_1 = arg_14_0.animation

		var_14_0.ZoomPainting(var_14_1, arg_14_0.resultPaintingData, arg_14_1)

		return
	end

	pg = var_14_0

	local var_14_2 = var_14_0.UIMgr.GetInstance().uiCamera.gameObject.transform
	local var_14_3 = var_3.Find(var_14_2, "Canvas")

	arg_14_0.blackBg.sizeDelta = var_14_3.sizeDelta

	local var_14_4

	if arg_14_0.effectTr then
		var_14_4 = arg_14_0.effectTr
		Vector2 = var_5
		var_14_4.anchorMax = var_5(0.5, 0.5)
		var_14_4 = arg_14_0.effectTr
		Vector2 = var_5
		var_14_4.anchorMin = var_5(0.5, 0.5)
		GameObject = var_14_4
		var_14_4 = var_14_4.Find("UICamera/Canvas").transform
		arg_14_0.effectTr.sizeDelta = var_14_4.sizeDelta
	end

	setAnchoredPosition = var_14_4

	var_14_4(arg_14_0.topPanel, {
		y = 320
	})

	setAnchoredPosition = var_14_4

	var_14_4(arg_14_0.bottomPanel, {
		y = -320
	})

	local var_14_5 = arg_14_0:GetPaintingPosition()

	arg_14_0.mask.localPosition = var_14_5

	if arg_14_0.animation then
		local var_14_6 = arg_14_0.animation

		var_5.Play(var_14_6, arg_14_0.resultPaintingData, arg_14_1)
	end

	return
end

function var_0_1.LoadBG(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._parentTf
	local var_15_1 = var_2.Find(var_15_0, "Effect")

	IsNil = var_15_0

	if not var_15_0(var_15_1) then
		setParent = var_3

		var_3(var_15_1, arg_15_0._tf)
		var_15_1:SetSiblingIndex(2)

		arg_15_0.effectTr = var_15_1

		arg_15_1()
	else
		NewBattleResultUtil = var_3

		local var_15_2 = var_3.Score2Bg(arg_15_0.contextData.score)

		LoadAnyAsync = var_4

		var_4("BattleResultItems/" .. var_15_2, "", nil, function(arg_16_0)
			if not arg_15_0.exited then
				IsNil = var_1

				if var_1(arg_16_0) then
					if arg_15_1 then
						arg_15_1()
					end

					return
				end

				Object = var_1

				local var_16_0 = var_1.Instantiate(arg_16_0, arg_15_0._tf).transform

				var_2.SetSiblingIndex(var_16_0, 2)

				arg_15_0.effectTr = var_1.transform

				if arg_15_1 then
					arg_15_1()
				end

				return
			end
		end)
	end

	return
end

function var_0_1.RegisterEvent(arg_17_0, arg_17_1)
	onButton = var_1_10002

	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.mainFleetBtn

	local function var_17_2()
		arg_17_0.teamType = var_0_2

		local var_18_0 = arg_17_0

		var_0.UpdateShips(var_18_0, false)

		local var_18_1 = arg_17_0

		var_0.UpdateCommanders(var_18_1, function()
			return
		end)

		local var_18_2 = arg_17_0

		var_0.UpdateSwitchBtn(var_18_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_17_0, var_17_1, var_17_2, var_1_10006)

	onButton = var_1_10002

	local var_17_3 = arg_17_0
	local var_17_4 = arg_17_0.subFleetBtn

	local function var_17_5()
		arg_17_0.teamType = var_0_3

		local var_20_0 = arg_17_0

		var_0.UpdateShips(var_20_0, false)

		local var_20_1 = arg_17_0

		var_0.UpdateCommanders(var_20_1, function()
			return
		end)

		local var_20_2 = arg_17_0

		var_0.UpdateSwitchBtn(var_20_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_17_3, var_17_4, var_17_5, var_1_10006)

	onButton = var_1_10002

	local var_17_6 = arg_17_0
	local var_17_7 = arg_17_0.statisticsBtn

	local function var_17_8()
		arg_17_0.displayMode = 1 - arg_17_0.displayMode

		local var_22_0 = arg_17_0

		var_0.UpdateShipDetail(var_22_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_17_6, var_17_7, var_17_8, var_1_10006)

	onButton = var_1_10002

	local var_17_9 = arg_17_0
	local var_17_10 = arg_17_0.confrimBtn

	local function var_17_11()
		arg_17_1()

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_17_9, var_17_10, var_17_11, var_1_10006)

	if arg_17_0.contextData.autoSkipFlag then
		onNextTick = var_2

		var_2(function()
			triggerButton = var_2_10000

			var_2_10000(arg_17_0.confrimBtn)

			return
		end)
	end

	return
end

local function var_0_6(arg_25_0, arg_25_1)
	onButton = var_1_10002

	local var_25_0 = arg_25_0
	local var_25_1 = arg_25_1

	local function var_25_2()
		setActive = var_2_10000

		var_2_10000(arg_25_1, false)

		if arg_25_0.metaExpView then
			return
		end

		local var_26_0 = arg_25_0

		BattleResultMetaExpView = var_1
		var_26_0.metaExpView = var_1.New(arg_25_0._tf, arg_25_0.event, arg_25_0.contextData)
		getProxy = var_26_0
		MetaCharacterProxy = var_1

		local var_26_1 = var_26_0(var_1)
		local var_26_2 = var_0.getLastMetaSkillExpInfoList(var_26_1)
		local var_26_3 = arg_25_0.metaExpView

		var_1.setData(var_26_3, var_26_2, function()
			if arg_25_1 then
				setActive = var_0

				var_0(arg_25_1, true)
			end

			arg_25_0.metaExpView = nil

			return
		end)

		local var_26_4 = arg_25_0.metaExpView

		var_1.Reset(var_26_4)

		local var_26_5 = arg_25_0.metaExpView

		var_1.Load(var_26_5)

		local var_26_6 = arg_25_0.metaExpView

		var_1.ActionInvoke(var_26_6, "Show")

		local var_26_7 = arg_25_0.metaExpView

		var_1.ActionInvoke(var_26_7, "openPanel")

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_25_0, var_25_1, var_25_2, var_1_10006)

	return
end

function var_0_1.UpdateMetaBtn(arg_28_0)
	getProxy = var_1_10001
	MetaCharacterProxy = var_1_10002

	local var_28_0 = var_1_10001(var_1_10002)
	local var_28_2

	if var_1.getLastMetaSkillExpInfoList(var_28_0) then
		::label_28_0::

		local var_28_1 = #var_1

		var_28_2 = 0 < var_28_1
	end

	if var_28_2 then
		LoadAnyAsync = var_1_10003

		var_1_10003("BattleResultItems/MetaBtn", "", nil, function(arg_29_0)
			if not arg_28_0.exited then
				IsNil = var_1

				if var_1(arg_29_0) then
					return
				end

				Object = var_1

				local var_29_0 = var_1.Instantiate(arg_29_0, arg_28_0._tf)

				var_0_6(arg_28_0, var_29_0.transform)

				return
			end
		end)
	end

	return
end

function var_0_1.StartEnterAnimation(arg_30_0, arg_30_1)
	LeanTween = var_1_10002

	local var_30_0 = var_1_10002.value(arg_30_0.topPanel.gameObject, 320, 0, 0.2)
	local var_30_1 = var_2.setOnUpdate

	System = var_4

	var_30_1(var_30_0, var_4.Action_float(function(arg_31_0)
		setAnchoredPosition = var_2_10001

		var_2_10001(arg_30_0.topPanel, {
			y = arg_31_0
		})

		return
	end))

	LeanTween = var_30_1

	local var_30_2 = var_30_1.value(arg_30_0.bottomPanel.gameObject, -320, 0, 0.2)
	local var_30_3 = var_2.setOnUpdate

	System = var_4

	local var_30_4 = var_30_3(var_30_2, var_4.Action_float(function(arg_32_0)
		setAnchoredPosition = var_2_10001

		var_2_10001(arg_30_0.bottomPanel, {
			y = arg_32_0
		})

		return
	end))
	local var_30_5 = var_2.setOnComplete

	System = var_4

	var_30_5(var_30_4, var_4.Action(arg_30_1))

	return
end

function var_0_1.GetShipSlotExpandPosition(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0
	local var_33_1 = arg_33_0.GetShipSlotShrinkPosition(var_33_0, arg_33_1)

	Vector2 = var_33_0

	return var_33_0(1300, var_33_1.y)
end

function var_0_1.GetShipSlotShrinkPosition(arg_34_0, arg_34_1)
	Vector2 = var_1_10002

	local var_34_0 = var_1_10002(500, 250)
	local var_34_1 = arg_34_1 - 1

	Vector2 = var_4

	return var_34_0 + var_34_1 * var_4(69.55, -117.7)
end

local function var_0_7(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = ""
	local var_35_1 = arg_35_0 and arg_35_0[arg_35_2]

	if (arg_35_1 or var_35_1) and (not arg_35_1 or not arg_35_1:getConfig("name")) and var_35_1 then
		::label_35_1::

		i18n = var_1_10006
		var_35_0 = var_1_10006("Word_Ship_Exp_Buff")
	end

	return var_35_0
end

function var_0_1.GetAnimationFlag(arg_36_0)
	if arg_36_0.contextData.autoSkipFlag then
		return false
	end

	if arg_36_0.animationFlags[arg_36_0.teamType][arg_36_0.displayMode] == false then
		arg_36_0.animationFlags[arg_36_0.teamType][arg_36_0.displayMode] = true
	end

	return not var_1
end

function var_0_1.UpdateShipDetail(arg_37_0)
	local var_37_0

	if not (arg_37_0.teamType == var_0_2) or not arg_37_0.surfaceShipTpls then
		var_37_0 = arg_37_0.subShipTpls
	end

	NewBattleResultUtil = var_1_10003

	local var_37_1, var_37_2 = var_1_10003.SeparateSurfaceAndSubShips(arg_37_0.contextData.oldMainShips)
	local var_37_3 = var_1 and var_37_1 or var_37_2
	local var_37_4 = arg_37_0.displayMode == var_0_4
	local var_37_5 = arg_37_0.contextData.expBuff
	local var_37_6 = arg_37_0.contextData.buffShips

	NewBattleResultUtil = var_1_10009

	local var_37_7 = var_1_10009.GetMaxOutput(arg_37_0.contextData.oldMainShips, arg_37_0.contextData.statistics)

	arg_37_0.numeberAnimations = {}

	local var_37_8 = arg_37_0
	local var_37_9 = arg_37_0.GetAnimationFlag(var_37_8)

	ipairs = var_37_8

	for iter_37_0, iter_37_1 in var_37_8(var_37_3) do
		local var_37_10

		if not arg_37_0.contextData.statistics[iter_37_1.id] then
			var_37_10 = {}
		end

		local var_37_11 = var_37_0[iter_37_0]
		local var_37_12 = arg_37_0.contextData.newMainShips[iter_37_1.id]

		local function var_37_13()
			setText = var_2_10000

			local var_38_0 = var_37_11
			local var_38_1 = var_1.Find(var_38_0, "atk")
			local var_38_2

			if not var_37_4 then
				if not var_37_10.output then
					var_38_2 = 0
				end
			else
				var_38_2 = "EXP"

				local var_38_3 = "<color=#FFDE38>+"

				NewBattleResultUtil = var_2_10004
				var_38_2 = var_38_2 .. var_38_3 .. var_2_10004.GetShipExpOffset(iter_37_1, var_37_12) .. "</color>"
			end

			var_2_10000(var_38_1, var_38_2)

			setText = var_2_10000

			local var_38_4 = var_37_11
			local var_38_5 = var_1.Find(var_38_4, "killCount")
			local var_38_6

			if not var_37_4 then
				if not var_37_10.kill_count then
					var_38_6 = 0
				end
			else
				var_38_6 = "Lv." .. var_37_12.level
			end

			var_2_10000(var_38_5, var_38_6)

			local var_38_7 = var_37_11
			local var_38_8 = var_0.Find(var_38_7, "dmg/bar")
			local var_38_9 = var_0.GetComponent

			typeof = var_2
			Image = var_3

			local var_38_10 = var_38_9(var_38_8, var_2(var_3))

			if not var_37_4 then
				local var_38_11

				if not var_37_10.output then
					var_38_11 = 0
				end

				if not (var_38_11 / var_37_7) then
					local var_38_12 = var_37_12

					var_38_11 = var_38_11.getExp(var_38_12)
					getExpByRarityFromLv1 = var_38_12

					local var_38_13 = var_37_12

					var_38_11 = var_38_11 / var_38_12(var_3.getConfig(var_38_13, "rarity"), var_37_12.level)
				end

				var_38_10.fillAmount = var_38_11

				return
			end
		end

		if var_37_9 then
			NewBattleResultShipCardAnimation = var_1_10020

			local var_37_14 = var_1_10020.New(var_37_11, var_37_4, iter_37_1, var_37_12, var_37_10, var_37_7)

			var_1_10020.SetUp(var_37_14, var_37_13)

			table = var_21

			var_21.insert(arg_37_0.numeberAnimations, var_1_10020)
		else
			var_37_13()
		end

		setText = var_1_10020

		local var_37_15 = var_37_11
		local var_37_16 = var_37_11.Find(var_37_15, "kill_count_label")

		if not var_37_4 then
			i18n = var_37_15

			local var_37_17

			if not var_37_15("battle_result_kill_count") then
				var_37_17 = iter_37_1:getName()
			end

			var_1_10020(var_37_16, var_37_17)

			setText = var_1_10020

			local var_37_18 = var_37_11
			local var_37_19 = var_37_11.Find(var_37_18, "dmg_count_label")

			if not var_37_4 then
				i18n = var_37_18

				local var_37_20

				if not var_37_18("battle_result_dmg") then
					if not var_0_7(var_37_6, var_37_5, iter_37_1:getGroupId()) then
						var_37_20 = ""
					end
				end

				var_1_10020(var_37_19, var_37_20)
			end
		end
	end

	return
end

local function var_0_8(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_1
	local var_39_1 = arg_39_1.Find(var_39_0, "MVP")

	IsNil = var_39_0

	if var_39_0(var_39_1) then
		LoadAnyAsync = var_3

		var_3("BattleResultItems/MVP", "", nil, function(arg_40_0)
			if not arg_39_0.exited then
				IsNil = var_1

				if var_1(arg_40_0) then
					return
				end

				Object = var_1
				var_1.Instantiate(arg_40_0, arg_39_1).name = "MVP"

				return
			end
		end)
	end

	local var_39_2 = arg_39_1
	local var_39_3 = arg_39_1.Find(var_39_2, "MVPBG")

	IsNil = var_39_2

	if var_39_2(var_39_3) then
		LoadAnyAsync = var_4

		var_4("BattleResultItems/MVPBG", "", nil, function(arg_41_0)
			if not arg_39_0.exited then
				IsNil = var_1

				if var_1(arg_41_0) then
					return
				end

				Object = var_1

				local var_41_0 = var_1.Instantiate(arg_41_0, arg_39_1)

				var_41_0.name = "MVPBG"

				local var_41_1 = var_41_0.transform

				var_2.SetAsFirstSibling(var_41_1)

				return
			end
		end)
	end

	return
end

local function var_0_9(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_1
	local var_42_1 = arg_42_1.Find(var_42_0, "LevelUp")

	IsNil = var_42_0

	if var_42_0(var_42_1) then
		LoadAnyAsync = var_3

		var_3("BattleResultItems/LevelUp", "", nil, function(arg_43_0)
			if not arg_42_0.exited then
				IsNil = var_1

				if var_1(arg_43_0) then
					return
				end

				Object = var_1
				var_1.Instantiate(arg_43_0, arg_42_1).name = "LevelUp"

				return
			end
		end)
	end

	return
end

local function var_0_10(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_1
	local var_44_1 = arg_44_1.Find(var_44_0, "Intmacy")

	IsNil = var_44_0

	if var_44_0(var_44_1) then
		ResourceMgr = var_3

		local var_44_2 = var_3.Inst
		local var_44_3 = var_3.getAssetAsync
		local var_44_4 = "ui/zhandoujiesuan_xingxing"
		local var_44_5 = ""

		UnityEngine = var_1_10007

		var_44_3(var_44_2, var_44_4, var_44_5, var_1_10007.Events.UnityAction_UnityEngine_Object(function(arg_45_0)
			if not arg_44_0.exited then
				IsNil = var_1

				if var_1(arg_45_0) then
					return
				end

				Object = var_1
				var_1.Instantiate(arg_45_0, arg_44_1).name = "Intmacy"

				return
			end
		end), true, true)
	end

	return
end

local function var_0_11(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5)
	local var_46_0 = arg_46_1:Find("mask/icon")
	local var_46_1 = var_6.GetComponent

	typeof = var_8
	Image = var_1_10009

	local var_46_2 = var_46_1(var_46_0, var_8(var_1_10009))

	LoadSprite = var_46_0
	var_46_2.sprite = var_46_0("herohrzicon/" .. arg_46_2:getPainting())

	local var_46_3 = var_46_2.gameObject.transform

	Vector2 = var_8
	var_46_3.sizeDelta = var_8(432, 96)
	setImageSprite = var_46_3

	local var_46_4 = arg_46_1
	local var_46_5 = arg_46_1.Find(var_46_4, "type")

	GetSpriteFromAtlas = var_46_4

	local var_46_6 = "shiptype"

	shipType2print = var_1_10011

	var_46_3(var_46_5, var_46_4(var_46_6, var_1_10011(arg_46_2:getShipType())), true)

	local var_46_7 = arg_46_2:getStar()
	local var_46_8 = arg_46_2
	local var_46_9 = arg_46_2.getMaxStar(var_46_8)

	UIItemList = var_46_8

	local var_46_10 = var_46_8.New(arg_46_1:Find("stars"), arg_46_1:Find("stars/star_tpl"))
	local var_46_11 = var_46_9 - var_46_7

	var_46_10:make(function(arg_47_0, arg_47_1, arg_47_2)
		UIItemList = var_2_10003

		if arg_47_0 == var_2_10003.EventUpdate then
			local var_47_0 = arg_47_1 + 1 <= var_46_11

			SetActive = var_4

			var_4(arg_47_2:Find("empty"), var_47_0)

			SetActive = var_4

			var_4(arg_47_2:Find("star"), not var_47_0)
		end

		return
	end)
	var_46_10:align(var_46_9)

	if arg_46_3 then
		var_0_8(arg_46_0, arg_46_1)
	end

	if arg_46_4 then
		var_0_9(arg_46_0, arg_46_1)
	end

	if arg_46_5 then
		onDelayTick = var_11

		var_11(function()
			if arg_46_0.exited then
				return
			end

			var_0_10(arg_46_0, arg_46_1)

			return
		end, 1)
	end

	return
end

function var_0_1.InitShips(arg_49_0, arg_49_1)
	arg_49_0:UpdateShips(true, arg_49_1)

	return
end

function var_0_1.UpdateShips(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0

	if arg_50_0.teamType ~= var_0_2 or not arg_50_0.surfaceShipTpls then
		var_50_0 = arg_50_0.subShipTpls
	end

	local var_50_1

	if arg_50_0.teamType ~= var_0_2 or not arg_50_0.subShipTpls then
		var_50_1 = arg_50_0.surfaceShipTpls
	end

	NewBattleResultUtil = var_5

	local var_50_2, var_50_3 = var_5.SeparateSurfaceAndSubShips(arg_50_0.contextData.oldMainShips)
	local var_50_4 = arg_50_0.teamType == var_0_2 and var_50_2 or var_50_3

	local function var_50_5()
		ipairs = var_2_10000

		for iter_51_0, iter_51_1 in var_2_10000(var_50_4) do
			local var_51_0 = var_50_0[iter_51_0]
			local var_51_1 = var_5.GetComponent

			typeof = var_2_10008
			CanvasGroup = var_2_10009
			var_51_1(var_51_0, var_2_10008(var_2_10009)).alpha = 1

			local var_51_2 = arg_50_0

			var_5.anchoredPosition = var_6.GetShipSlotExpandPosition(var_51_2, iter_51_0)

			local var_51_3 = arg_50_0.contextData.newMainShips[iter_51_1.id]
			local var_51_4 = var_0_11

			var_2_10008 = arg_50_0
			var_2_10009 = var_5

			local var_51_5 = iter_51_1
			local var_51_6

			if arg_50_0.contextData.statistics.mvpShipID then
				var_51_6 = arg_50_0.contextData.statistics.mvpShipID == iter_51_1.id
			end

			var_51_4(var_2_10008, var_2_10009, var_51_5, var_51_6, var_51_3.level > iter_51_1.level, var_51_3:getIntimacy() > iter_51_1:getIntimacy())
		end

		local var_51_7 = arg_50_0

		var_0.UpdateShipDetail(var_51_7)

		local var_51_8 = arg_50_0

		var_0.StartShipsEnterAnimation(var_51_8, var_50_0, arg_50_1 and 0.6 or 0, arg_50_2)

		return
	end

	arg_50_0:LoadShipTpls(var_50_0, var_50_4, var_50_5)

	ipairs = var_9

	for iter_50_0, iter_50_1 in var_9(var_50_1) do
		local var_50_6 = iter_50_1
		local var_50_7 = iter_50_1.GetComponent

		typeof = var_1_10016
		CanvasGroup = var_1_10017
		var_50_7(var_50_6, var_1_10016(var_1_10017)).alpha = 0
	end

	return
end

function var_0_1.LoadShipTpls(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	local var_52_0 = {}

	if #arg_52_1 < #arg_52_2 then
		table = var_5

		var_5.insert(var_52_0, function(arg_53_0)
			LoadAnyAsync = var_2_10001

			var_2_10001("BattleResultItems/Ship", "", nil, function(arg_54_0)
				if arg_52_0.exited then
					arg_53_0()

					return
				end

				arg_53_0(arg_54_0)

				return
			end)

			return
		end)

		table = var_5

		var_5.insert(var_52_0, function(arg_55_0, arg_55_1)
			if not arg_55_1 then
				arg_55_0()

				return
			end

			for iter_55_0 = #arg_52_1 + 1, #arg_52_2 do
				Object = var_2_10006

				local var_55_0 = var_2_10006.Instantiate(arg_55_1, arg_52_0.shipContainer).transform
				local var_55_1 = var_2_10006.GetComponent

				typeof = var_2_10009
				CanvasGroup = var_2_10010

				local var_55_2 = var_55_1(var_55_0, var_2_10009(var_2_10010))

				var_55_2.alpha = 0
				table = var_55_2

				var_55_2.insert(arg_52_1, var_2_10006)
			end

			arg_55_0()

			return
		end)
	end

	seriesAsync = var_5

	var_5(var_52_0, arg_52_3)

	return
end

function var_0_1.StartShipsEnterAnimation(arg_56_0, arg_56_1, arg_56_2, arg_56_3)
	if arg_56_2 <= 0 then
		ipairs = var_4

		for iter_56_0, iter_56_1 in var_4(arg_56_1) do
			iter_56_1.anchoredPosition = arg_56_0:GetShipSlotShrinkPosition(iter_56_0)
		end

		return
	end

	local var_56_0 = {}

	ipairs = var_1_10005

	for iter_56_2, iter_56_3 in var_1_10005(arg_56_1) do
		local var_56_1 = iter_56_3
		local var_56_2 = iter_56_3.GetComponent

		typeof = var_1_10012
		CanvasGroup = var_1_10013

		local var_56_3 = var_56_2(var_56_1, var_1_10012(var_1_10013))

		var_56_3.alpha = 0
		var_1_10012 = arg_56_0

		local var_56_4 = arg_56_0.GetShipSlotExpandPosition(var_1_10012, iter_56_2)

		var_1_10013 = arg_56_0
		var_1_10012 = arg_56_0.GetShipSlotShrinkPosition(var_1_10013, iter_56_2)
		table = var_1_10013

		var_1_10013.insert(var_56_0, function(arg_57_0)
			if arg_56_0.exited then
				return
			end

			local var_57_0 = var_56_3

			var_57_0.alpha = 1
			LeanTween = var_57_0

			local var_57_1 = var_57_0.value(iter_56_3.gameObject, var_56_4.x, var_1_10012.x, arg_56_2 - (iter_56_2 - 1) * 0.1)
			local var_57_2 = var_1.setOnUpdate

			System = var_3

			var_57_2(var_57_1, var_3.Action_float(function(arg_58_0)
				local var_58_0 = iter_56_3

				Vector3 = var_3_10002
				var_58_0.anchoredPosition = var_3_10002(arg_58_0, iter_56_3.anchoredPosition.y, 0)

				return
			end))

			onDelayTick = var_57_2

			var_57_2(arg_57_0, 0.1)

			return
		end)
	end

	seriesAsync = var_5

	var_5(var_56_0, arg_56_3)

	return
end

function var_0_1.UpdateSwitchBtn(arg_59_0)
	NewBattleResultUtil = var_1_10001

	local var_59_0 = var_1_10001.HasSubShip(arg_59_0.contextData.oldMainShips)

	NewBattleResultUtil = var_2

	local var_59_1 = var_2.HasSurfaceShip(arg_59_0.contextData.oldMainShips)

	setActive = var_3

	var_3(arg_59_0.mainFleetBtn, arg_59_0.teamType == var_0_3 and var_59_1 and var_59_0)

	setActive = var_3

	var_3(arg_59_0.subFleetBtn, arg_59_0.teamType == var_0_2 and var_59_1 and var_59_0)

	if not var_59_1 then
		arg_59_0.teamType = var_0_3
	end

	return
end

function var_0_1.UpdateMvpPainting(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_0.contextData.oldMainShips

	NewBattleResultUtil = var_1_10003

	local var_60_1, var_60_2, var_60_3, var_60_4 = var_1_10003.SeparateMvpShip(var_60_0, arg_60_0.contextData.statistics.mvpShipID, arg_60_0.contextData.statistics._flagShipID)

	var_60_4 = var_60_4 or var_60_0[#var_60_0 - 1]

	local var_60_5 = arg_60_0.resultPaintingTr
	local var_60_6 = var_60_4
	local var_60_7 = var_60_4.getPainting(var_60_6)

	setPaintingPrefabAsync = var_60_6

	var_60_6(var_60_5, var_60_7, "jiesuan", function()
		ShipExpressionHelper = var_2_10000

		local var_61_0 = var_2_10000.SetExpression

		findTF = var_2_10001

		local var_61_1 = var_2_10001(var_60_5, "fitter")
		local var_61_2 = var_1.GetChild(var_61_1, 0)
		local var_61_3 = var_60_7

		ShipWordHelper = var_3

		local var_61_4 = var_3.WORD_TYPE_MVP
		local var_61_5 = var_60_4

		var_61_0(var_61_2, var_61_3, var_61_4, var_4.getCVIntimacy(var_61_5))

		local var_61_6 = arg_60_0

		var_0.RecordPainting(var_61_6, arg_60_1)

		return
	end)
	arg_60_0:DisplayShipDialogue(var_60_4)

	return
end

function var_0_1.RecordPainting(arg_62_0, arg_62_1)
	onNextTick = var_1_10002

	var_1_10002(function()
		local var_63_0 = arg_62_0.resultPaintingTr
		local var_63_1 = var_0.Find(var_63_0, "fitter")
		local var_63_2 = var_0.GetChild(var_63_1, 0)

		IsNil = var_63_1

		if not var_63_1(var_63_2) then
			local var_63_3 = arg_62_0
			local var_63_4 = {}

			Vector2 = var_2_10003
			var_63_4.position = var_2_10003(var_63_2.position.x, var_63_2.position.y)
			rtf = var_3
			var_63_4.pivot = var_3(var_63_2).pivot
			Vector2 = var_3
			var_63_4.scale = var_3(var_63_2.localScale.x, var_63_2.localScale.y)
			var_63_3.resultPaintingData = var_63_4
			SetParent = var_63_3

			local var_63_5 = var_63_2
			local var_63_6 = arg_62_0.paintingTr

			var_63_3(var_63_5, var_3.Find(var_63_6, "painting/fitter"), true)
		end

		arg_62_1()

		return
	end)

	return
end

function var_0_1.UpdateFailedPainting(arg_64_0, arg_64_1)
	local var_64_0 = arg_64_0.contextData.oldMainShips

	LoadAnyAsync = var_1_10003

	var_1_10003("BattleResultItems/FailedPainting", "", nil, function(arg_65_0)
		if not arg_64_0.exited then
			IsNil = var_1

			if var_1(arg_65_0) then
				arg_64_1()

				return
			end

			Object = var_1

			local var_65_0 = var_1.Instantiate(arg_65_0, arg_64_0.paintingTr).transform

			var_2.SetAsFirstSibling(var_65_0)
			arg_64_1()

			return
		end
	end)

	local var_64_1 = arg_64_0
	local var_64_2 = arg_64_0.DisplayShipDialogue

	math = var_5

	var_64_2(var_64_1, var_64_0[var_5.random(#var_64_0)])

	return
end

function var_0_1.GetPaintingPosition(arg_66_0)
	local var_66_0 = arg_66_0.contextData.oldMainShips

	NewBattleResultDisplayPaintingsPage = var_1_10002

	return (var_1_10002.StaticGetFinalExpandPosition(#var_66_0))
end

function var_0_1.UpdatePaintingPosition(arg_67_0)
	local var_67_0 = arg_67_0:GetPaintingPosition()

	arg_67_0.paintingTr.localPosition = var_67_0

	return
end

function var_0_1.UpdatePainting(arg_68_0, arg_68_1)
	arg_68_0:UpdatePaintingPosition()

	if arg_68_0.contextData.score > 1 then
		arg_68_0:UpdateMvpPainting(arg_68_1)
	else
		arg_68_0:UpdateFailedPainting(arg_68_1)
	end

	return
end

function var_0_1.DisplayShipDialogue(arg_69_0, arg_69_1)
	local var_69_0
	local var_69_1
	local var_69_2
	local var_69_3

	if arg_69_0.contextData.score > 1 then
		ShipWordHelper = var_69_3
		var_69_3 = var_69_3.GetWordAndCV

		local var_69_4 = arg_69_1.skinId

		ShipWordHelper = var_1_10007

		local var_69_5

		var_69_3, var_69_5, var_1_10007 = var_69_3(var_69_4, var_1_10007.WORD_TYPE_MVP, nil, nil, arg_69_1:getCVIntimacy())
		var_69_1 = var_1_10007

		local var_69_6 = var_69_5
		local var_69_7 = var_69_3
	else
		ShipWordHelper = var_69_3

		local var_69_8 = var_69_3.GetWordAndCV
		local var_69_9 = arg_69_1.skinId

		ShipWordHelper = var_1_10007

		local var_69_10, var_69_11

		var_69_10, var_69_11, var_1_10007 = var_69_8(var_69_9, var_1_10007.WORD_TYPE_LOSE, nil, nil, arg_69_1:getCVIntimacy())
		var_69_1 = var_1_10007

		local var_69_12 = var_69_11
		local var_69_13 = var_69_10
	end

	arg_69_0.chatText.text = var_69_1

	local var_69_14 = arg_69_0.chatText
	local var_69_15 = #var_69_1

	CHAT_POP_STR_LEN = var_1_10007

	if var_1_10007 < var_69_15 then
		TextAnchor = var_69_15

		if not var_69_15.MiddleLeft then
			TextAnchor = var_69_15
			var_69_15 = var_69_15.MiddleCenter
		end

		var_69_14.alignment = var_69_15

		arg_69_0:PlayMvpShipVoice()

		return
	end
end

function var_0_1.PlayMvpShipVoice(arg_70_0)
	if arg_70_0.contextData.statistics.mvpShipID then
		type = var_1

		if var_1(arg_70_0.contextData.statistics.mvpShipID) == "number" and arg_70_0.contextData.statistics.mvpShipID <= 0 then
			return
		end

		_ = var_1

		local var_70_0 = var_1.detect(arg_70_0.contextData.oldMainShips, function(arg_71_0)
			return arg_71_0.id == arg_70_0.contextData.statistics.mvpShipID
		end)

		assert = var_2

		var_2(var_70_0)

		local var_70_1
		local var_70_2
		local var_70_3
		local var_70_4

		if arg_70_0.contextData.score > 1 then
			ShipWordHelper = var_70_4
			var_70_4 = var_70_4.GetWordAndCV

			local var_70_5 = var_70_0.skinId

			ShipWordHelper = var_1_10007

			local var_70_6

			var_70_4, var_70_6, var_1_10007 = var_70_4(var_70_5, var_1_10007.WORD_TYPE_MVP, nil, nil, var_70_0:getCVIntimacy())

			local var_70_7 = var_1_10007

			var_70_3 = var_70_6

			local var_70_8 = var_70_4
		else
			ShipWordHelper = var_70_4

			local var_70_9 = var_70_4.GetWordAndCV
			local var_70_10 = var_70_0.skinId

			ShipWordHelper = var_1_10007

			local var_70_11, var_70_12

			var_70_11, var_70_3, var_70_12 = var_70_9(var_70_10, var_1_10007.WORD_TYPE_LOSE)
		end

		if var_70_3 then
			arg_70_0:StopVoice()

			pg = var_5

			local var_70_13 = var_5.CriMgr.GetInstance()

			var_5.PlaySoundEffect_V3(var_70_13, var_70_3, function(arg_72_0)
				arg_70_0._currentVoice = arg_72_0

				return
			end)
		end

		return
	end
end

function var_0_1.StopVoice(arg_73_0)
	if arg_73_0._currentVoice then
		local var_73_0 = arg_73_0._currentVoice

		var_1.PlaybackStop(var_73_0)

		arg_73_0._currentVoice = nil
	end

	return
end

function var_0_1.UpdateGrade(arg_74_0)
	NewBattleResultUtil = var_1_10001

	local var_74_0, var_74_1 = var_1_10001.Score2Grade(arg_74_0.contextData.score, arg_74_0.contextData._scoreMark)

	LoadImageSpriteAsync = var_3

	var_3(var_74_0, arg_74_0.gradeIcon, false)

	LoadImageSpriteAsync = var_3

	var_3(var_74_1, arg_74_0.gradeTxt, false)

	return
end

function var_0_1.UpdateChapterName(arg_75_0)
	NewBattleResultUtil = var_1_10001

	local var_75_0

	var_75_0.text, var_75_0 = var_1_10001.GetChapterName(arg_75_0.contextData), arg_75_0.chapterName
	setActive = var_75_0

	local var_75_1 = arg_75_0.opBonus

	NewBattleResultUtil = var_1_10004

	var_75_0(var_75_1, var_1_10004.IsOpBonus(arg_75_0.contextData.extraBuffList))

	return
end

function var_0_1.UpdatePlayer(arg_76_0)
	local var_76_0 = arg_76_0.contextData.oldPlayer

	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_76_1 = var_1_10002(var_1_10003)
	local var_76_2 = var_2.getRawData(var_76_1)

	arg_76_0.playerName.text = var_76_2:GetName()

	local function var_76_3()
		local var_77_0 = arg_76_0.playerLv

		var_77_0.text = "Lv." .. var_76_2.level
		NewBattleResultUtil = var_77_0

		local var_77_1 = var_77_0.GetPlayerExpOffset(var_76_0, var_76_2)

		arg_76_0.playerExp.text = "+" .. var_77_1
		arg_76_0.playerExpLabel.text = "EXP"

		local var_77_2 = arg_76_0.playerExpBar
		local var_77_3 = var_76_2.level
		local var_77_4 = var_76_2

		if var_77_3 == var_3.getMaxLevel(var_77_4) then
			var_77_3 = 1
		else
			var_77_3 = var_76_2.exp
			getConfigFromLevel1 = var_3
			pg = var_77_4
			var_77_3 = var_77_3 / var_3(var_77_4.user_level, var_76_2.level).exp_interval
		end

		var_77_2.fillAmount = var_77_3

		return
	end

	if not arg_76_0.contextData.autoSkipFlag then
		NewBattleResultPlayerAniamtion = var_4

		local var_76_4 = var_4.New(arg_76_0.playerLv, arg_76_0.playerExp, arg_76_0.playerExpBar, var_76_2, var_76_0)

		var_4.SetUp(var_76_4, var_76_3)

		arg_76_0.playerAniamtion = var_4
	else
		var_76_3()
	end

	return
end

local function var_0_12(arg_78_0, arg_78_1, arg_78_2)
	GetImageSpriteFromAtlasAsync = var_1_10003

	local var_78_0 = "commandericon/" .. arg_78_2:getPainting()
	local var_78_1 = ""
	local var_78_2 = arg_78_0

	var_1_10003(var_78_0, var_78_1, arg_78_0.Find(var_78_2, "icon"))

	setText = var_1_10003

	var_1_10003(arg_78_0:Find("name_text"), arg_78_2:getName())

	setText = var_1_10003

	var_1_10003(arg_78_0:Find("lv_text"), "Lv." .. arg_78_2.level)

	setText = var_1_10003

	var_1_10003(arg_78_0:Find("exp"), "+" .. arg_78_1.exp)

	local var_78_3 = arg_78_2:isMaxLevel() and 1 or arg_78_1.curExp / arg_78_2:getNextLevelExp()
	local var_78_4 = arg_78_0:Find("exp_bar/progress")
	local var_78_5 = var_4.GetComponent

	typeof = var_6
	Image = var_78_2
	var_78_5(var_78_4, var_6(var_78_2)).fillAmount = var_78_3

	return
end

function var_0_1.UpdateCommanders(arg_79_0, arg_79_1)
	local var_79_0 = arg_79_0.teamType
	local var_79_1

	if not arg_79_0.contextData.commanderExps then
		var_79_1 = {}
	end

	local var_79_2

	if var_79_0 ~= var_0_2 or not var_79_1.surfaceCMD then
		var_79_2 = var_79_1.submarineCMD
	end

	var_79_2 = var_79_2 or {}

	local function var_79_3()
		for iter_80_0 = 1, #var_79_2 do
			getProxy = var_2_10004
			CommanderProxy = var_2_10005
			var_2_10005 = var_2_10004(var_2_10005)
			var_2_10004 = var_2_10004.getCommanderById(var_2_10005, var_79_2[iter_80_0].commander_id)
			setActive = var_2_10005

			var_2_10005(arg_79_0.commaderTpls[iter_80_0], true)
			var_0_12(arg_79_0.commaderTpls[iter_80_0], var_79_2[iter_80_0], var_2_10004)
		end

		for iter_80_1 = #arg_79_0.commaderTpls, #var_79_2 + 1, -1 do
			setActive = var_2_10004

			var_2_10004(arg_79_0.commaderTpls[iter_80_1], false)
		end

		return
	end

	for iter_79_0 = 1, #arg_79_0.emptyTpls do
		setActive = var_1_10010

		var_1_10010(arg_79_0.emptyTpls[iter_79_0], var_79_2[iter_79_0] == nil)
	end

	arg_79_0:LoadCommanderTpls(#var_79_2, var_79_3)
	arg_79_1()

	return
end

function var_0_1.LoadCommanderTpls(arg_81_0, arg_81_1, arg_81_2)
	local var_81_0 = {}

	if #arg_81_0.commaderTpls < arg_81_1 then
		table = var_4

		var_4.insert(var_81_0, function(arg_82_0)
			LoadAnyAsync = var_2_10001

			var_2_10001("BattleResultItems/Commander", "", nil, function(arg_83_0)
				if arg_81_0.exited then
					arg_82_0()

					return
				end

				arg_82_0(arg_83_0)

				return
			end)

			return
		end)

		table = var_4

		var_4.insert(var_81_0, function(arg_84_0, arg_84_1)
			if not arg_84_1 then
				arg_84_0()

				return
			end

			for iter_84_0 = #arg_81_0.commaderTpls + 1, arg_81_1 do
				table = var_2_10006
				var_2_10006 = var_2_10006.insert

				local var_84_0 = arg_81_0.commaderTpls

				Object = var_2_10008

				var_2_10006(var_84_0, var_2_10008.Instantiate(arg_84_1, arg_81_0.commmanderContainer).transform)
			end

			arg_84_0()

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_81_0, arg_81_2)

	return
end

function var_0_1.onBackPressed(arg_85_0)
	if arg_85_0.metaExpView then
		local var_85_0 = arg_85_0.metaExpView

		var_1.closePanel(var_85_0)

		arg_85_0.metaExpView = nil

		return true
	end

	return false
end

function var_0_1.OnDestroy(arg_86_0)
	arg_86_0.exited = true

	if arg_86_0.metaExpView then
		local var_86_0 = arg_86_0.metaExpView

		var_1.Destroy(var_86_0)

		arg_86_0.metaExpView = nil
	end

	if arg_86_0:isShowing() then
		arg_86_0:Hide()
	end

	if arg_86_0.animation then
		local var_86_1 = arg_86_0.animation

		var_1.Dispose(var_86_1)
	end

	arg_86_0.animation = nil
	LeanTween = var_1

	if var_1.isTweening(arg_86_0.topPanel.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_86_0.topPanel.gameObject)
	end

	LeanTween = var_1

	if var_1.isTweening(arg_86_0.bottomPanel.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_86_0.bottomPanel.gameObject)
	end

	if arg_86_0.surfaceShipTpls then
		ipairs = var_1

		for iter_86_0, iter_86_1 in var_1(arg_86_0.surfaceShipTpls) do
			LeanTween = var_1_10006

			if var_1_10006.isTweening(iter_86_1.gameObject) then
				LeanTween = var_1_10006

				var_1_10006.cancel(iter_86_1.gameObject)
			end
		end
	end

	if arg_86_0.subShipTpls then
		ipairs = var_1

		for iter_86_2, iter_86_3 in var_1(arg_86_0.subShipTpls) do
			LeanTween = var_1_10006

			if var_1_10006.isTweening(iter_86_3.gameObject) then
				LeanTween = var_1_10006

				var_1_10006.cancel(iter_86_3.gameObject)
			end
		end
	end

	if arg_86_0.numeberAnimations then
		ipairs = var_1

		for iter_86_4, iter_86_5 in var_1(arg_86_0.numeberAnimations) do
			iter_86_5:Dispose()
		end
	end

	if arg_86_0.playerAniamtion then
		local var_86_2 = arg_86_0.playerAniamtion

		var_1.Dispose(var_86_2)

		arg_86_0.playerAniamtion = nil
	end

	return
end

return var_0_1
