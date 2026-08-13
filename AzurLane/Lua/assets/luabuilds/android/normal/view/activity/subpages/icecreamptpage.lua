class = var_0_10000

local var_0_0 = "IcecreamPTPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PtTemplatePage"))

var_0_1.FADE_TIME = 0.5
var_0_1.SHOW_TIME = 1
var_0_1.FADE_OUT_TIME = 0.5
var_0_1.Menu_Ani_Open_Time = 0.5
var_0_1.Menu_Ani_Close_Time = 0.3
var_0_1.PosList = {
	188,
	70,
	-55,
	-178
}
var_0_1.Icecream_Save_Tag_Pre = "Icecream_Tag_"

function var_0_1.OnDataSetting(arg_1_0)
	var_0_1.super.OnDataSetting(arg_1_0)

	local var_1_0 = arg_1_0.activity

	arg_1_0.specialPhaseList = var_1.getConfig(var_1_0, "config_data")
	arg_1_0.selectedList = arg_1_0:getSelectedList()
	arg_1_0.curSelectOrder = 0
	arg_1_0.curSelectIndex = 0

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)
	arg_2_0:findUI()
	arg_2_0:initMainPanel()
	arg_2_0:addListener()
	arg_2_0:initSD()

	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	var_0_1.super.OnUpdateFlush(arg_3_0)

	local var_3_0 = arg_3_0.ptData
	local var_3_1, var_3_2, var_3_3 = var_1.GetLevelProgress(var_3_0)

	setText = var_1_10004

	var_1_10004(arg_3_0.step, var_3_1)

	isActive = var_1_10004

	if var_1_10004(arg_3_0.specialTF) then
		setActive = var_4

		var_4(arg_3_0.specialTF, false)
	end

	arg_3_0:updateIcecream()
	arg_3_0:updateMainSelectPanel()

	setActive = var_4

	var_4(arg_3_0.openBtn, arg_3_0:isFinished())

	setActive = var_4

	var_4(arg_3_0.shareBtn, arg_3_0:isFinished())

	return
end

function var_0_1.OnDestroy(arg_4_0)
	if arg_4_0.spine then
		local var_4_0 = arg_4_0.spine.transform

		Vector3 = var_1_10002
		var_4_0.localScale = var_1_10002.one
		pg = var_4_0

		local var_4_1 = var_4_0.PoolMgr.GetInstance()

		var_1.ReturnSpineChar(var_4_1, "salatuojia_8", arg_4_0.spine)

		arg_4_0.spine = nil
	end

	if arg_4_0.shareGo then
		PoolMgr = var_1

		local var_4_2 = var_1.GetInstance()

		var_1.ReturnUI(var_4_2, "IcecreamSharePage", arg_4_0.shareGo)

		arg_4_0.shareGo = nil
	end

	return
end

function var_0_1.findUI(arg_5_0)
	local var_5_0 = arg_5_0.bg

	arg_5_0.shareBtn = var_1.Find(var_5_0, "Logo/share_btn")

	local var_5_1 = arg_5_0.bg

	arg_5_0.icecreamTF = var_1.Find(var_5_1, "Icecream")

	local var_5_2 = arg_5_0.bg

	arg_5_0.openBtn = var_1.Find(var_5_2, "open_btn")

	local var_5_3 = arg_5_0.bg

	arg_5_0.helpBtn = var_1.Find(var_5_3, "help_btn")

	local var_5_4 = arg_5_0._tf

	arg_5_0.specialTF = var_1.Find(var_5_4, "Special")

	local var_5_5 = arg_5_0.specialTF

	arg_5_0.backBG = var_1.Find(var_5_5, "BG")

	local var_5_6 = arg_5_0.specialTF

	arg_5_0.menuTF = var_1.Find(var_5_6, "Menu")

	local var_5_7 = arg_5_0.menuTF

	arg_5_0.mainPanel = var_1.Find(var_5_7, "MainPanel")
	arg_5_0.mainToggleTFList = {}

	for iter_5_0 = 1, 4 do
		local var_5_8 = arg_5_0.mainToggleTFList
		local var_5_9 = arg_5_0.mainPanel

		var_5_8[iter_5_0] = var_6.GetChild(var_5_9, iter_5_0 - 1)
	end

	local var_5_10 = arg_5_0.menuTF

	arg_5_0.secondPanel = var_1.Find(var_5_10, "SecondList")

	local var_5_11 = arg_5_0.menuTF

	arg_5_0.selectBtn = var_1.Find(var_5_11, "SelectBtn")
	GetComponent = var_1
	arg_5_0.mainPanelCG = var_1(arg_5_0.mainPanel, "CanvasGroup")
	GetComponent = var_1
	arg_5_0.secondPanelCG = var_1(arg_5_0.secondPanel, "CanvasGroup")
	GetComponent = var_1
	arg_5_0.selectBtnImg = var_1(arg_5_0.selectBtn, "Image")

	local var_5_12 = arg_5_0._tf

	arg_5_0.resTF = var_1.Find(var_5_12, "Res")

	local var_5_13 = arg_5_0.resTF
	local var_5_14 = var_1.Find(var_5_13, "1/1")
	local var_5_15 = arg_5_0.resTF
	local var_5_16 = var_2.Find(var_5_15, "1/2")
	local var_5_17 = arg_5_0.resTF
	local var_5_18 = var_3.Find(var_5_17, "1/3")
	local var_5_19 = arg_5_0.resTF
	local var_5_20 = var_4.Find(var_5_19, "2/1/1")
	local var_5_21 = arg_5_0.resTF
	local var_5_22 = var_5.Find(var_5_21, "2/1/2")
	local var_5_23 = arg_5_0.resTF
	local var_5_24 = var_6.Find(var_5_23, "2/1/3")
	local var_5_25 = arg_5_0.resTF
	local var_5_26 = var_7.Find(var_5_25, "2/2/1")
	local var_5_27 = arg_5_0.resTF
	local var_5_28 = var_8.Find(var_5_27, "2/2/2")
	local var_5_29 = arg_5_0.resTF
	local var_5_30 = var_9.Find(var_5_29, "2/2/3")
	local var_5_31 = arg_5_0.resTF
	local var_5_32 = var_10.Find(var_5_31, "2/3/1")
	local var_5_33 = arg_5_0.resTF
	local var_5_34 = var_11.Find(var_5_33, "2/3/2")
	local var_5_35 = arg_5_0.resTF
	local var_5_36 = var_12.Find(var_5_35, "2/3/3")
	local var_5_37 = arg_5_0.resTF
	local var_5_38 = var_13.Find(var_5_37, "3/1")
	local var_5_39 = arg_5_0.resTF
	local var_5_40 = var_14.Find(var_5_39, "3/2")
	local var_5_41 = arg_5_0.resTF
	local var_5_42 = var_15.Find(var_5_41, "3/3")
	local var_5_43 = arg_5_0.resTF
	local var_5_44 = var_16.Find(var_5_43, "4/1")
	local var_5_45 = arg_5_0.resTF
	local var_5_46 = var_17.Find(var_5_45, "4/2")
	local var_5_47 = arg_5_0.resTF
	local var_5_48 = var_18.Find(var_5_47, "4/3")

	arg_5_0.iconTable = {
		["1"] = {
			var_5_14,
			var_5_16,
			var_5_18
		},
		["21"] = {
			var_5_20,
			var_5_22,
			var_5_24
		},
		["22"] = {
			var_5_26,
			var_5_28,
			var_5_30
		},
		["23"] = {
			var_5_32,
			var_5_34,
			var_5_36
		},
		["3"] = {
			var_5_38,
			var_5_40,
			var_5_42
		},
		["4"] = {
			var_5_44,
			var_5_46,
			var_5_48
		}
	}

	local var_5_49 = arg_5_0._tf

	arg_5_0.icecreamResTF = var_19.Find(var_5_49, "Icecream")
	arg_5_0.mainToggleSelectedTF = {}
	arg_5_0.mainToggleUnlockTF = {}
	ipairs = var_19

	for iter_5_1, iter_5_2 in var_19(arg_5_0.mainToggleTFList) do
		arg_5_0.mainToggleSelectedTF[iter_5_1] = iter_5_2:GetChild(1)
		arg_5_0.mainToggleUnlockTF[iter_5_1] = iter_5_2:GetChild(0)
	end

	return
end

function var_0_1.addListener(arg_6_0)
	IsUnityEditor = var_1_10001

	if var_1_10001 then
		local var_6_0 = arg_6_0.bg

		var_1_10001 = var_1_10001.Find(var_6_0, "Logo")
		onButton = var_6_0

		local var_6_1 = arg_6_0
		local var_6_2 = var_1_10001

		function var_1_10005()
			for iter_7_0 = 1, 4 do
				local var_7_0 = var_0_1.Icecream_Save_Tag_Pre .. iter_7_0

				PlayerPrefs = var_5

				var_5.SetInt(var_7_0, 0)
			end

			return
		end

		SFX_PANEL = var_1_10006

		var_6_0(var_6_1, var_6_2, var_1_10005, var_1_10006)
	end

	onButton = var_1_10001

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0.getBtn

	local function var_6_5()
		local var_8_0 = arg_6_0.ptData
		local var_8_1, var_8_2, var_8_3 = var_0.GetLevelProgress(var_8_0)

		table = var_2_10003

		if var_2_10003.indexof(arg_6_0.specialPhaseList, var_8_1, 1) then
			local var_8_4 = arg_6_0

			var_4.openMainPanel(var_8_4, var_3)
		else
			local var_8_5 = {}
			local var_8_6 = arg_6_0.ptData
			local var_8_7 = var_5.GetAward(var_8_6)

			getProxy = var_8_6
			PlayerProxy = var_2_10007

			local var_8_8 = var_8_6(var_2_10007)
			local var_8_9 = var_6.getData(var_8_8)
			local var_8_10 = var_8_7.type

			DROP_TYPE_RESOURCE = var_2_10009

			if var_8_10 == var_2_10009 then
				var_8_10 = var_8_7.id
				PlayerConst = var_2_10009

				if var_8_10 == var_2_10009.ResGold and var_8_9:GoldMax(var_8_7.count) then
					table = var_8_10

					var_8_10.insert(var_8_5, function(arg_9_0)
						pg = var_3_10001

						local var_9_0 = var_3_10001.MsgboxMgr.GetInstance()
						local var_9_1 = var_1.ShowMsgBox
						local var_9_2 = {}

						i18n = var_3_10004

						local var_9_3 = var_3_10004("gold_max_tip_title")

						i18n = var_5
						var_9_2.content = var_9_3 .. var_5("award_max_warning")
						var_9_2.onYes = arg_9_0

						var_9_1(var_9_0, var_9_2)

						return
					end)
				end
			end

			seriesAsync = var_8_10

			var_8_10(var_8_5, function()
				local var_10_0 = arg_6_0.ptData
				local var_10_1, var_10_2 = var_0.GetResProgress(var_10_0)
				local var_10_3 = arg_6_0
				local var_10_4 = var_2.emit

				ActivityMediator = var_3_10004

				local var_10_5 = var_3_10004.EVENT_PT_OPERATION
				local var_10_6 = {
					cmd = 1
				}
				local var_10_7 = arg_6_0.ptData

				var_10_6.activity_id = var_6.GetId(var_10_7)
				var_10_6.arg1 = var_10_2

				var_10_4(var_10_3, var_10_5, var_10_6)

				return
			end)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_6_3, var_6_4, var_6_5, var_1_10005)

	onButton = var_1_10001

	local var_6_6 = arg_6_0
	local var_6_7 = arg_6_0.battleBtn

	local function var_6_8()
		local var_11_0 = arg_6_0
		local var_11_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_11_1(var_11_0, var_2_10002.SPECIAL_BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_6_6, var_6_7, var_6_8, var_1_10005)

	onButton = var_1_10001

	local var_6_9 = arg_6_0
	local var_6_10 = arg_6_0.openBtn

	local function var_6_11()
		local var_12_0 = arg_6_0

		var_0.openMainPanel(var_12_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_6_9, var_6_10, var_6_11, var_1_10005)

	onButton = var_1_10001

	local var_6_12 = arg_6_0
	local var_6_13 = arg_6_0.helpBtn

	local function var_6_14()
		pg = var_2_10000

		local var_13_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_13_1 = var_0.ShowMsgBox
		local var_13_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_13_2.type = var_2_10003
		pg = var_2_10003
		var_13_2.helps = var_2_10003.gametip.icecream_help.tip

		var_13_1(var_13_0, var_13_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_6_12, var_6_13, var_6_14, var_1_10005)

	onButton = var_1_10001

	local var_6_15 = arg_6_0
	local var_6_16 = arg_6_0.shareBtn

	local function var_6_17()
		local var_14_0 = arg_6_0

		var_0.share(var_14_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_6_15, var_6_16, var_6_17, var_1_10005)

	return
end

function var_0_1.initMainPanel(arg_15_0)
	onButton = var_1_10001

	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.backBG

	local function var_15_2()
		local var_16_0 = arg_15_0

		var_0.closeSpecial(var_16_0)

		local var_16_1 = arg_15_0

		if var_0.isFinished(var_16_1) then
			setActive = var_0

			var_0(arg_15_0.openBtn, true)
		end

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_15_0, var_15_1, var_15_2, var_1_10005)

	ipairs = var_1_10001

	for iter_15_0, iter_15_1 in var_1_10001(arg_15_0.mainToggleTFList) do
		onToggle = var_1_10006

		local var_15_3 = arg_15_0
		local var_15_4 = iter_15_1

		local function var_15_5(arg_17_0)
			if arg_17_0 == true then
				arg_15_0.curSelectOrder = iter_15_0

				local var_17_0 = var_0_1.PosList[iter_15_0]

				setLocalPosition = var_2

				var_2(arg_15_0.secondPanel, {
					y = var_17_0
				})

				setLocalPosition = var_2

				var_2(arg_15_0.selectBtn, {
					y = var_17_0
				})

				local var_17_1

				if iter_15_0 == 1 then
					var_17_1 = arg_15_0.iconTable["1"]
				elseif iter_15_0 == 2 then
					local var_17_2 = 2 .. arg_15_0.selectedList[1]

					var_17_1 = arg_15_0.iconTable[var_17_2]
				elseif iter_15_0 == 3 then
					var_17_1 = arg_15_0.iconTable["3"]
				elseif iter_15_0 == 4 then
					var_17_1 = arg_15_0.iconTable["4"]
				end

				local var_17_3 = {}

				for iter_17_0 = 1, 3 do
					local var_17_4 = arg_15_0.secondPanel

					var_17_3[iter_17_0] = var_2_10008.GetChild(var_17_4, iter_17_0)
				end

				for iter_17_1 = 1, 3 do
					getImageSprite = var_2_10008
					var_2_10008 = var_2_10008(var_17_1[iter_17_1])
					setImageSprite = var_9

					local var_17_5 = var_17_3[iter_17_1]

					var_9(var_10.Find(var_17_5, "icon"), var_2_10008, true)

					onToggle = var_9

					local var_17_6 = arg_15_0
					local var_17_7 = var_17_3[iter_17_1]

					local function var_17_8(arg_18_0)
						if arg_18_0 == true then
							Clone = var_3_10001
							var_3_10001 = var_3_10001(arg_15_0.selectedList)
							var_3_10001[arg_15_0.curSelectOrder] = iter_17_1

							local var_18_0 = arg_15_0

							var_2.updateIcecream(var_18_0, var_3_10001)

							local var_18_1 = arg_15_0

							var_2.openSelectBtn(var_18_1)

							arg_15_0.curSelectIndex = iter_17_1
						else
							setActive = var_3_10001

							var_3_10001(arg_15_0.selectBtn, false)

							arg_15_0.curSelectIndex = 0
						end

						return
					end

					SFX_PANEL = var_2_10013

					var_9(var_17_6, var_17_7, var_17_8, var_2_10013)
				end

				for iter_17_2 = 1, 3 do
					triggerToggle = var_2_10008

					var_2_10008(var_17_3[iter_17_2], false)
				end

				local var_17_9 = arg_15_0

				var_4.openSecondPanel(var_17_9)

				setActive = var_4

				var_4(arg_15_0.selectBtn, false)
			else
				local var_17_10 = arg_15_0

				var_17_10.curSelectOrder = 0
				setActive = var_17_10

				var_17_10(arg_15_0.secondPanel, false)

				setActive = var_17_10

				var_17_10(arg_15_0.selectBtn, false)
			end

			local var_17_11 = arg_15_0

			var_1.updateMainSelectPanel(var_17_11)

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_15_3, var_15_4, var_15_5, var_1_10010)
	end

	onButton = var_1

	local var_15_6 = arg_15_0
	local var_15_7 = arg_15_0.selectBtn

	local function var_15_8()
		local var_19_0 = arg_15_0

		if not var_0.isFinished(var_19_0) then
			if arg_15_0.curSelectIndex then
				local var_19_1 = arg_15_0.ptData
				local var_19_2, var_19_3 = var_0.GetResProgress(var_19_1)
				local var_19_4 = arg_15_0
				local var_19_5 = var_2.emit

				ActivityMediator = var_2_10004

				local var_19_6 = var_2_10004.EVENT_PT_OPERATION
				local var_19_7 = {
					cmd = 1
				}
				local var_19_8 = arg_15_0.ptData

				var_19_7.activity_id = var_6.GetId(var_19_8)
				var_19_7.arg1 = var_19_3
				var_19_7.arg2 = arg_15_0.curSelectIndex

				function var_19_7.callback()
					arg_15_0.selectedList[arg_15_0.curSelectOrder] = arg_15_0.curSelectIndex

					local var_20_0 = arg_15_0

					var_0.closeSpecial(var_20_0)

					return
				end

				var_19_5(var_19_4, var_19_6, var_19_7)
			end
		else
			local var_19_9 = arg_15_0

			var_0.changeIndexSelect(var_19_9)

			local var_19_10 = arg_15_0

			var_0.updateIcecream(var_19_10)

			local var_19_11 = arg_15_0

			var_0.updateMainSelectPanel(var_19_11)
		end

		return
	end

	SFX_PANEL = iter_15_1

	var_1(var_15_6, var_15_7, var_15_8, iter_15_1)

	return
end

function var_0_1.openMainPanel(arg_21_0, arg_21_1)
	arg_21_0.selectedList = arg_21_0:getSelectedList()
	setActive = var_2

	var_2(arg_21_0.displayBtn, false)

	setActive = var_2

	var_2(arg_21_0.slider, false)

	setActive = var_2

	var_2(arg_21_0.awardTF, false)

	setActive = var_2

	var_2(arg_21_0.progress, false)

	for iter_21_0 = 1, 4 do
		triggerToggle = var_1_10006

		var_1_10006(arg_21_0.mainToggleTFList[iter_21_0], false)

		GetComponent = var_1_10006
		var_1_10006 = var_1_10006(arg_21_0.mainToggleTFList[iter_21_0], "Toggle")
		var_1_10006.interactable = arg_21_0:isFinished()
	end

	arg_21_0:updateMainSelectPanel()

	setActive = var_2

	var_2(arg_21_0.specialTF, true)

	LeanTween = var_2

	local var_21_0 = var_2.value

	go = var_3

	local var_21_1 = var_21_0(var_3(arg_21_0.mainPanel), 0, 1, var_0_1.Menu_Ani_Open_Time)
	local var_21_2 = var_2.setOnUpdate

	System = var_4

	local var_21_3 = var_21_2(var_21_1, var_4.Action_float(function(arg_22_0)
		arg_21_0.mainPanelCG.alpha = arg_22_0

		return
	end))
	local var_21_4 = var_2.setOnComplete

	System = var_4

	var_21_4(var_21_3, var_4.Action(function()
		arg_21_0.mainPanelCG.alpha = 1

		return
	end))

	LeanTween = var_21_4

	local var_21_5 = var_21_4.value

	go = var_21_3

	local var_21_6 = var_21_5(var_21_3(arg_21_0.mainPanel), -391, -271, var_0_1.Menu_Ani_Open_Time)
	local var_21_7 = var_2.setOnUpdate

	System = var_4

	local var_21_8 = var_21_7(var_21_6, var_4.Action_float(function(arg_24_0)
		setLocalPosition = var_2_10001

		var_2_10001(arg_21_0.mainPanel, {
			x = arg_24_0
		})

		return
	end))
	local var_21_9 = var_2.setOnComplete

	System = var_4

	var_21_9(var_21_8, var_4.Action(function()
		setLocalPosition = var_2_10000

		var_2_10000(arg_21_0.mainPanel, {
			x = -271
		})

		if arg_21_1 and arg_21_1 > 0 then
			triggerToggle = var_0

			var_0(arg_21_0.mainToggleTFList[arg_21_1], true)
		end

		return
	end))

	return
end

function var_0_1.closeMainPanel(arg_26_0)
	LeanTween = var_1_10001

	local var_26_0 = var_1_10001.value

	go = var_1_10002

	local var_26_1 = var_26_0(var_1_10002(arg_26_0.mainPanel), 1, 0, var_0_1.Menu_Ani_Close_Time)
	local var_26_2 = var_1.setOnUpdate

	System = var_3

	local var_26_3 = var_26_2(var_26_1, var_3.Action_float(function(arg_27_0)
		arg_26_0.mainPanelCG.alpha = arg_27_0

		return
	end))
	local var_26_4 = var_1.setOnComplete

	System = var_3

	var_26_4(var_26_3, var_3.Action(function()
		local var_28_0 = arg_26_0.mainPanelCG

		var_28_0.alpha = 0
		setActive = var_28_0

		var_28_0(arg_26_0.specialTF, false)

		return
	end))

	LeanTween = var_26_4

	local var_26_5 = var_26_4.value

	go = var_26_3

	local var_26_6 = var_26_5(var_26_3(arg_26_0.mainPanel), -271, -391, var_0_1.Menu_Ani_Close_Time)
	local var_26_7 = var_1.setOnUpdate

	System = var_3

	local var_26_8 = var_26_7(var_26_6, var_3.Action_float(function(arg_29_0)
		setLocalPosition = var_2_10001

		var_2_10001(arg_26_0.mainPanel, {
			x = arg_29_0
		})

		return
	end))
	local var_26_9 = var_1.setOnComplete

	System = var_3

	var_26_9(var_26_8, var_3.Action(function()
		setLocalPosition = var_2_10000

		var_2_10000(arg_26_0.mainPanel, {
			x = -391
		})

		setActive = var_2_10000

		var_2_10000(arg_26_0.specialTF, false)

		local var_30_0 = arg_26_0

		var_0.updateIcecream(var_30_0)

		setActive = var_0

		var_0(arg_26_0.displayBtn, true)

		setActive = var_0

		var_0(arg_26_0.slider, true)

		setActive = var_0

		var_0(arg_26_0.awardTF, true)

		setActive = var_0

		var_0(arg_26_0.progress, true)

		return
	end))

	return
end

function var_0_1.openSecondPanel(arg_31_0)
	setActive = var_1_10001

	var_1_10001(arg_31_0.secondPanel, true)

	LeanTween = var_1_10001

	local var_31_0 = var_1_10001.value

	go = var_2

	local var_31_1 = var_31_0(var_2(arg_31_0.secondPanel), 0, 1, var_0_1.Menu_Ani_Open_Time)
	local var_31_2 = var_1.setOnUpdate

	System = var_3

	local var_31_3 = var_31_2(var_31_1, var_3.Action_float(function(arg_32_0)
		arg_31_0.secondPanelCG.alpha = arg_32_0

		return
	end))
	local var_31_4 = var_1.setOnComplete

	System = var_3

	var_31_4(var_31_3, var_3.Action(function()
		arg_31_0.secondPanelCG.alpha = 1

		return
	end))

	LeanTween = var_31_4

	local var_31_5 = var_31_4.value

	go = var_31_3

	local var_31_6 = var_31_5(var_31_3(arg_31_0.secondPanel), -646, -213, var_0_1.Menu_Ani_Open_Time)
	local var_31_7 = var_1.setOnUpdate

	System = var_3

	local var_31_8 = var_31_7(var_31_6, var_3.Action_float(function(arg_34_0)
		setLocalPosition = var_2_10001

		var_2_10001(arg_31_0.secondPanel, {
			x = arg_34_0
		})

		return
	end))
	local var_31_9 = var_1.setOnComplete

	System = var_3

	var_31_9(var_31_8, var_3.Action(function()
		setLocalPosition = var_2_10000

		var_2_10000(arg_31_0.secondPanel, {
			x = -213
		})

		return
	end))

	return
end

function var_0_1.closeSecondPanel(arg_36_0)
	LeanTween = var_1_10001

	local var_36_0 = var_1_10001.value

	go = var_1_10002

	local var_36_1 = var_36_0(var_1_10002(arg_36_0.secondPanel), 1, 0, var_0_1.Menu_Ani_Close_Time)
	local var_36_2 = var_1.setOnUpdate

	System = var_3

	local var_36_3 = var_36_2(var_36_1, var_3.Action_float(function(arg_37_0)
		arg_36_0.secondPanelCG.alpha = arg_37_0

		return
	end))
	local var_36_4 = var_1.setOnComplete

	System = var_3

	var_36_4(var_36_3, var_3.Action(function()
		local var_38_0 = arg_36_0.secondPanelCG

		var_38_0.alpha = 0
		setActive = var_38_0

		var_38_0(arg_36_0.secondPanel, false)

		return
	end))

	LeanTween = var_36_4

	local var_36_5 = var_36_4.value

	go = var_36_3

	local var_36_6 = var_36_5(var_36_3(arg_36_0.secondPanel), -213, -646, var_0_1.Menu_Ani_Close_Time)
	local var_36_7 = var_1.setOnUpdate

	System = var_3

	local var_36_8 = var_36_7(var_36_6, var_3.Action_float(function(arg_39_0)
		setLocalPosition = var_2_10001

		var_2_10001(arg_36_0.secondPanel, {
			x = arg_39_0
		})

		return
	end))
	local var_36_9 = var_1.setOnComplete

	System = var_3

	var_36_9(var_36_8, var_3.Action(function()
		setLocalPosition = var_2_10000

		var_2_10000(arg_36_0.secondPanel, {
			x = -646
		})

		setActive = var_2_10000

		var_2_10000(arg_36_0.secondPanel, false)

		local var_40_0 = arg_36_0

		var_0.closeMainPanel(var_40_0)

		return
	end))

	return
end

function var_0_1.openSelectBtn(arg_41_0)
	setLocalPosition = var_1_10001

	var_1_10001(arg_41_0.selectBtn, {
		x = 287
	})

	setActive = var_1_10001

	var_1_10001(arg_41_0.selectBtn, true)

	LeanTween = var_1_10001

	local var_41_0 = var_1_10001.value

	go = var_2

	local var_41_1 = var_41_0(var_2(arg_41_0.selectBtn), 0, 1, var_0_1.Menu_Ani_Open_Time)
	local var_41_2 = var_1.setOnUpdate

	System = var_3

	local var_41_3 = var_41_2(var_41_1, var_3.Action_float(function(arg_42_0)
		setImageAlpha = var_2_10001

		var_2_10001(arg_41_0.selectBtn, arg_42_0)

		return
	end))
	local var_41_4 = var_1.setOnComplete

	System = var_3

	var_41_4(var_41_3, var_3.Action(function()
		setImageAlpha = var_2_10000

		var_2_10000(arg_41_0.selectBtn, 1)

		return
	end))

	return
end

function var_0_1.closeSelectBtn(arg_44_0)
	LeanTween = var_1_10001

	local var_44_0 = var_1_10001.value

	go = var_1_10002

	local var_44_1 = var_44_0(var_1_10002(arg_44_0.selectBtn), 1, 0, var_0_1.Menu_Ani_Close_Time)
	local var_44_2 = var_1.setOnUpdate

	System = var_3

	local var_44_3 = var_44_2(var_44_1, var_3.Action_float(function(arg_45_0)
		setImageAlpha = var_2_10001

		var_2_10001(arg_44_0.selectBtn, arg_45_0)

		return
	end))
	local var_44_4 = var_1.setOnComplete

	System = var_3

	var_44_4(var_44_3, var_3.Action(function()
		setImageAlpha = var_2_10000

		var_2_10000(arg_44_0.selectBtn, 0)

		setActive = var_2_10000

		var_2_10000(arg_44_0.selectBtn, false)

		return
	end))

	return
end

function var_0_1.closeSpecial(arg_47_0)
	arg_47_0:closeSelectBtn()
	arg_47_0:closeSecondPanel()

	return
end

function var_0_1.updateIcecream(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_1 or arg_48_0.selectedList

	setActive = var_1_10003

	var_1_10003(arg_48_0.icecreamTF, var_48_0[1] > 0)

	local var_48_1 = arg_48_0.icecreamTF
	local var_48_2 = var_3.Find(var_48_1, "1")
	local var_48_3 = var_3.Find(var_48_2, "Taste")
	local var_48_4 = arg_48_0.icecreamTF
	local var_48_5 = var_5.Find(var_48_4, "2")
	local var_48_6 = arg_48_0.icecreamTF
	local var_48_7 = var_6.Find(var_48_6, "3")
	local var_48_8 = arg_48_0.icecreamTF
	local var_48_9 = var_7.Find(var_48_8, "4")
	local var_48_11

	if var_48_0[1] then
		local var_48_10 = var_48_0[1]

		var_48_11 = 0 < var_48_10
	end

	if var_48_11 then
		pairs = var_9

		for iter_48_0, iter_48_1 in var_9(var_48_0) do
			if iter_48_1 > 0 and iter_48_0 > 1 then
				var_48_11 = false
			end
		end
	end

	setActive = var_9

	var_9(var_3, var_48_11)

	setActive = var_9

	local var_48_12 = var_48_5
	local var_48_13

	if var_48_0[2] then
		var_48_13 = var_48_0[2] > 0
	end

	var_9(var_48_12, var_48_13)

	setActive = var_9

	local var_48_14 = var_48_7
	local var_48_15

	if var_48_0[3] then
		var_48_15 = var_48_0[3] > 0
	end

	var_9(var_48_14, var_48_15)

	setActive = var_9

	local var_48_16 = var_48_9
	local var_48_17

	if var_48_0[4] then
		var_48_17 = var_48_0[4] > 0
	end

	var_9(var_48_16, var_48_17)

	if var_48_11 then
		local var_48_18 = "1_" .. var_48_0[1]

		getImageSprite = var_10

		local var_48_19 = arg_48_0.icecreamResTF
		local var_48_20 = var_10(var_11.Find(var_48_19, var_48_18))

		setImageSprite = var_11

		var_11(var_48_3, var_48_20, true)
	end

	if var_48_0[2] and var_48_0[2] > 0 then
		local var_48_21 = "2_" .. var_48_0[1] .. var_48_0[2]

		getImageSprite = var_10

		local var_48_22 = arg_48_0.icecreamResTF
		local var_48_23 = var_10(var_11.Find(var_48_22, var_48_21))

		setImageSprite = var_11

		var_11(var_48_5, var_48_23, true)
	end

	if var_48_0[3] and var_48_0[3] > 0 then
		local var_48_24 = "3_" .. var_48_0[3]

		getImageSprite = var_10

		local var_48_25 = arg_48_0.icecreamResTF
		local var_48_26 = var_10(var_11.Find(var_48_25, var_48_24))

		setImageSprite = var_11

		var_11(var_48_7, var_48_26, true)
	end

	if var_48_0[4] and var_48_0[4] > 0 then
		local var_48_27 = "4_" .. var_48_0[4]

		getImageSprite = var_10

		local var_48_28 = arg_48_0.icecreamResTF
		local var_48_29 = var_10(var_11.Find(var_48_28, var_48_27))

		setImageSprite = var_11

		var_11(var_48_9, var_48_29, true)
	end

	return
end

function var_0_1.updateMainSelectPanel(arg_49_0)
	for iter_49_0 = 1, 4 do
		setActive = var_1_10005

		local var_49_0 = arg_49_0.mainToggleUnlockTF[iter_49_0]
		local var_49_1

		if arg_49_0.selectedList[iter_49_0] then
			var_49_1 = arg_49_0.selectedList[iter_49_0] > 0
		end

		var_1_10005(var_49_0, var_49_1)
	end

	if arg_49_0.curSelectOrder > 0 then
		setActive = var_1

		var_1(arg_49_0.mainToggleUnlockTF[arg_49_0.curSelectOrder], true)
	end

	local var_49_2, var_49_4

	if arg_49_0.selectedList[1] and arg_49_0.selectedList[1] > 0 then
		var_49_2 = arg_49_0.selectedList[1]

		local var_49_3 = arg_49_0.iconTable["1"][var_49_2]

		getImageSprite = var_49_4
		var_49_4 = var_49_4(var_49_3)
		setImageSprite = iter_49_0

		iter_49_0(arg_49_0.mainToggleSelectedTF[1], var_49_4, true)

		setActive = iter_49_0

		iter_49_0(arg_49_0.mainToggleSelectedTF[1], true)
	else
		setActive = var_49_2

		var_49_2(arg_49_0.mainToggleSelectedTF[1], false)
	end

	local var_49_5

	if arg_49_0.selectedList[2] and arg_49_0.selectedList[2] > 0 then
		var_49_5 = 2 .. arg_49_0.selectedList[1]

		local var_49_6 = arg_49_0.selectedList[2]

		var_49_4 = arg_49_0.iconTable[var_49_5][var_49_6]
		getImageSprite = iter_49_0

		local var_49_7 = iter_49_0(var_49_4)

		setImageSprite = var_5

		var_5(arg_49_0.mainToggleSelectedTF[2], var_49_7, true)

		setActive = var_5

		var_5(arg_49_0.mainToggleSelectedTF[2], true)
	else
		setActive = var_49_5

		var_49_5(arg_49_0.mainToggleSelectedTF[2], false)
	end

	local var_49_8

	if arg_49_0.selectedList[3] and arg_49_0.selectedList[3] > 0 then
		var_49_8 = arg_49_0.selectedList[3]

		local var_49_9 = arg_49_0.iconTable["3"][var_49_8]

		getImageSprite = var_49_4
		var_49_4 = var_49_4(var_49_9)
		setImageSprite = var_4

		var_4(arg_49_0.mainToggleSelectedTF[3], var_49_4, true)

		setActive = var_4

		var_4(arg_49_0.mainToggleSelectedTF[3], true)
	else
		setActive = var_49_8

		var_49_8(arg_49_0.mainToggleSelectedTF[3], false)
	end

	local var_49_10

	if arg_49_0.selectedList[4] and arg_49_0.selectedList[4] > 0 then
		var_49_10 = arg_49_0.selectedList[4]

		local var_49_11 = arg_49_0.iconTable["4"][var_49_10]

		getImageSprite = var_49_4

		local var_49_12 = var_49_4(var_49_11)

		setImageSprite = var_4

		var_4(arg_49_0.mainToggleSelectedTF[4], var_49_12, true)

		setActive = var_4

		var_4(arg_49_0.mainToggleSelectedTF[4], true)
	else
		setActive = var_49_10

		var_49_10(arg_49_0.mainToggleSelectedTF[4], false)
	end

	return
end

function var_0_1.isFinished(arg_50_0)
	return #arg_50_0.activity.data2_list == 4
end

function var_0_1.changeIndexSelect(arg_51_0)
	arg_51_0.selectedList[arg_51_0.curSelectOrder] = arg_51_0.curSelectIndex

	local var_51_0 = var_0_1.Icecream_Save_Tag_Pre .. arg_51_0.curSelectOrder

	PlayerPrefs = var_2

	var_2.SetInt(var_51_0, arg_51_0.curSelectIndex)

	return
end

function var_0_1.getSelectedList(arg_52_0)
	arg_52_0.selectedList = {
		0,
		0,
		0,
		0
	}
	ipairs = var_1

	for iter_52_0, iter_52_1 in var_1(arg_52_0.activity.data2_list) do
		arg_52_0.selectedList[iter_52_0] = iter_52_1
	end

	if arg_52_0:isFinished() then
		for iter_52_2 = 1, 4 do
			local var_52_0 = var_0_1.Icecream_Save_Tag_Pre .. iter_52_2

			PlayerPrefs = var_6

			if var_6.GetInt(var_52_0, 0) > 0 then
				arg_52_0.selectedList[iter_52_2] = var_6
			end
		end
	end

	arg_52_0:saveSelectedList()

	return arg_52_0.selectedList
end

function var_0_1.saveSelectedList(arg_53_0)
	for iter_53_0 = 1, 4 do
		local var_53_0 = var_0_1.Icecream_Save_Tag_Pre .. iter_53_0
		local var_53_1 = arg_53_0.selectedList[iter_53_0]

		PlayerPrefs = var_1_10007

		var_1_10007.SetInt(var_53_0, var_53_1)
	end

	return
end

function var_0_1.share(arg_54_0)
	PoolMgr = var_1_10001

	local var_54_0 = var_1_10001.GetInstance()

	var_1.GetUI(var_54_0, "IcecreamSharePage", false, function(arg_55_0)
		GameObject = var_2_10001

		local var_55_0 = var_2_10001.Find("UICamera/Canvas/UIMain")

		SetParent = var_2

		var_2(arg_55_0, var_55_0, false)

		arg_54_0.shareGo = arg_55_0

		local var_55_1 = arg_55_0:Find("PlayerName")
		local var_55_2 = arg_55_0
		local var_55_3 = arg_55_0.Find(var_55_2, "IcecreamContainer")

		getProxy = var_55_2
		PlayerProxy = var_5

		local var_55_4 = var_55_2(var_5)
		local var_55_5 = var_4.getData(var_55_4).name

		setText = var_2_10007

		local var_55_6 = var_55_1

		i18n = var_2_10009

		var_2_10007(var_55_6, var_2_10009("icecream_make_tip", var_55_5))

		getProxy = var_2_10007
		PlayerProxy = var_55_6

		local var_55_7 = var_2_10007(var_55_6)
		local var_55_8 = var_7.getRawData(var_55_7)

		getProxy = var_55_7
		UserProxy = var_9

		local var_55_9 = var_55_7(var_9)
		local var_55_10 = var_8.getRawData(var_55_9)

		getProxy = var_55_9
		ServerProxy = var_10

		local var_55_11 = var_55_9(var_10)
		local var_55_12 = var_9.getRawData(var_55_11)
		local var_55_13

		if not var_55_10 or not var_55_10.server then
			var_55_13 = 0
		end

		local var_55_14 = var_55_12[var_55_13]
		local var_55_15

		if not var_55_8 or not var_55_8.name then
			var_55_15 = ""
		end

		local var_55_16

		if not var_55_14 or not var_55_14.name then
			var_55_16 = ""
		end

		local var_55_17 = arg_55_0
		local var_55_18 = arg_55_0.Find(var_55_17, "deck")

		setText = var_55_17

		var_55_17(var_55_18:Find("name/value"), var_55_15)

		setText = var_55_17

		var_55_17(var_55_18:Find("server/value"), var_55_16)

		setText = var_55_17

		var_55_17(var_55_18:Find("lv/value"), var_55_8.level)

		cloneTplTo = var_55_17

		local var_55_19 = var_55_17(arg_54_0.icecreamTF, var_55_3)

		setLocalPosition = var_14
		tf = var_15

		var_14(var_15(var_55_19), {
			x = 0,
			y = 0
		})

		setLocalScale = var_14
		tf = var_15

		var_14(var_15(var_55_19), {
			x = 1.4,
			y = 1.4
		})

		pg = var_14

		local var_55_20 = var_14.ShareMgr.GetInstance()
		local var_55_21 = var_14.Share

		pg = var_16

		var_55_21(var_55_20, var_16.ShareMgr.TypeIcecream)

		if arg_54_0.shareGo then
			PoolMgr = var_14

			local var_55_22 = var_14.GetInstance()

			var_14.ReturnUI(var_55_22, "IcecreamSharePage", arg_54_0.shareGo)

			arg_54_0.shareGo = nil
		end

		return
	end)

	return
end

function var_0_1.initSD(arg_56_0)
	local var_56_0 = arg_56_0.bg

	arg_56_0.sdContainer = var_1.Find(var_56_0, "sdcontainer")
	arg_56_0.spine = nil
	GetSpineRequestPackage = var_1

	local var_56_1 = var_1.New("salatuojia_8", function(arg_57_0)
		SetParent = var_2_10001

		var_2_10001(arg_57_0, arg_56_0.sdContainer)

		arg_56_0.spine = arg_57_0

		local var_57_0 = arg_56_0.spine.transform

		Vector3 = var_2
		var_57_0.localScale = var_2.one

		local var_57_1 = arg_56_0.spine

		if var_1.GetComponent(var_57_1, "SpineAnimUI") then
			var_1:SetAction("stand", 0)
		end

		arg_56_0.spineLRQ = nil

		return
	end)

	arg_56_0.spineLRQ = var_1.Start(var_56_1)
	setActive = var_1

	var_1(arg_56_0.sdContainer, true)

	return
end

return var_0_1
