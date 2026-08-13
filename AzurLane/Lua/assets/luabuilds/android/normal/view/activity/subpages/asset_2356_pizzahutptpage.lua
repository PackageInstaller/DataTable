class = var_0_10000

local var_0_0 = "PizzahutPTPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PtTemplatePage"))

var_0_1.FADE_TIME = 0.5
var_0_1.SHOW_TIME = 1
var_0_1.FADE_OUT_TIME = 0.5
var_0_1.Menu_Ani_Open_Time = 0.5
var_0_1.Menu_Ani_Close_Time = 0.3
var_0_1.PosList = {
	-256,
	-150,
	-50,
	55,
	160,
	263
}
var_0_1.Pizza_Save_Tag_Pre = "Pizza_Tag_"

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
	local var_3_1, var_3_2, var_3_3 = var_1.GetResProgress(var_3_0)

	setText = var_1_10004

	local var_3_4 = arg_3_0.progress

	if 1 <= var_3_3 then
		setColorStr = var_6

		local var_3_5

		if not var_6(var_3_1, "#947D80FF") then
			var_3_5 = var_3_1
		end

		var_1_10004(var_3_4, var_3_5 .. "/" .. var_3_2)
		arg_3_0:updatePizza()
		arg_3_0:updateMainSelectPanel()

		setActive = var_4

		var_4(arg_3_0.openBtn, arg_3_0:isFinished())

		setActive = var_4

		var_4(arg_3_0.shareBtn, arg_3_0:isFinished())

		onButton = var_4

		local var_3_6 = arg_3_0
		local var_3_7 = arg_3_0.battleBtn

		local function var_3_8()
			local var_4_0 = arg_3_0
			local var_4_1 = var_0.emit

			ActivityMediator = var_2_10002

			var_4_1(var_4_0, var_2_10002.SPECIAL_BATTLE_OPERA)

			return
		end

		SFX_PANEL = var_8

		var_4(var_3_6, var_3_7, var_3_8, var_8)

		return
	end
end

function var_0_1.OnDestroy(arg_5_0)
	if arg_5_0.spine then
		local var_5_0 = arg_5_0.spine.transform

		Vector3 = var_1_10002
		var_5_0.localScale = var_1_10002.one
		pg = var_5_0

		local var_5_1 = var_5_0.PoolMgr.GetInstance()

		var_1.ReturnSpineChar(var_5_1, "chuixue_6", arg_5_0.spine)

		arg_5_0.spine = nil
	end

	if arg_5_0.shareGo then
		PoolMgr = var_1

		local var_5_2 = var_1.GetInstance()

		var_1.ReturnUI(var_5_2, "PizzahutSharePage", arg_5_0.shareGo)

		arg_5_0.shareGo = nil
	end

	return
end

function var_0_1.findUI(arg_6_0)
	local var_6_0 = arg_6_0.bg

	arg_6_0.shareBtn = var_1.Find(var_6_0, "share_btn")

	local var_6_1 = arg_6_0.bg

	arg_6_0.empty = var_1.Find(var_6_1, "empty")

	local var_6_2 = arg_6_0.bg

	arg_6_0.pizzaTF = var_1.Find(var_6_2, "Pizza")

	local var_6_3 = arg_6_0.bg

	arg_6_0.openBtn = var_1.Find(var_6_3, "open_btn")

	local var_6_4 = arg_6_0.bg

	arg_6_0.helpBtn = var_1.Find(var_6_4, "help_btn")

	local var_6_5 = arg_6_0._tf

	arg_6_0.specialTF = var_1.Find(var_6_5, "Special")

	local var_6_6 = arg_6_0.specialTF

	arg_6_0.backBG = var_1.Find(var_6_6, "BG")

	local var_6_7 = arg_6_0.specialTF

	arg_6_0.closeBtn = var_1.Find(var_6_7, "CloseBtn")

	local var_6_8 = arg_6_0.specialTF

	arg_6_0.menuTF = var_1.Find(var_6_8, "Menu")

	local var_6_9 = arg_6_0.menuTF

	arg_6_0.mainPanel = var_1.Find(var_6_9, "MainPanel")
	arg_6_0.mainToggleTFList = {}

	for iter_6_0 = 1, 6 do
		local var_6_10 = arg_6_0.mainToggleTFList
		local var_6_11 = arg_6_0.mainPanel

		var_6_10[iter_6_0] = var_6.GetChild(var_6_11, iter_6_0 - 1)
	end

	local var_6_12 = arg_6_0.menuTF

	arg_6_0.secondPanel = var_1.Find(var_6_12, "SecondList")

	local var_6_13 = arg_6_0.menuTF

	arg_6_0.selectBtn = var_1.Find(var_6_13, "SelectBtn")
	GetComponent = var_1
	arg_6_0.mainPanelCG = var_1(arg_6_0.mainPanel, "CanvasGroup")
	GetComponent = var_1
	arg_6_0.secondPanelCG = var_1(arg_6_0.secondPanel, "CanvasGroup")
	GetComponent = var_1
	arg_6_0.selectBtnImg = var_1(arg_6_0.selectBtn, "Image")

	local var_6_14 = arg_6_0._tf

	arg_6_0.resTF = var_1.Find(var_6_14, "Res")

	local var_6_15 = arg_6_0.resTF
	local var_6_16 = var_1.Find(var_6_15, "1/1")
	local var_6_17 = arg_6_0.resTF
	local var_6_18 = var_2.Find(var_6_17, "1/2")
	local var_6_19 = arg_6_0.resTF
	local var_6_20 = var_3.Find(var_6_19, "1/3")
	local var_6_21 = arg_6_0.resTF
	local var_6_22 = var_4.Find(var_6_21, "2/1/1")
	local var_6_23 = arg_6_0.resTF
	local var_6_24 = var_5.Find(var_6_23, "2/1/2")
	local var_6_25 = arg_6_0.resTF
	local var_6_26 = var_6.Find(var_6_25, "2/1/3")
	local var_6_27 = arg_6_0.resTF
	local var_6_28 = var_7.Find(var_6_27, "2/2/1")
	local var_6_29 = arg_6_0.resTF
	local var_6_30 = var_8.Find(var_6_29, "2/2/2")
	local var_6_31 = arg_6_0.resTF
	local var_6_32 = var_9.Find(var_6_31, "2/2/3")
	local var_6_33 = arg_6_0.resTF
	local var_6_34 = var_10.Find(var_6_33, "2/3/1")
	local var_6_35 = arg_6_0.resTF
	local var_6_36 = var_11.Find(var_6_35, "2/3/2")
	local var_6_37 = arg_6_0.resTF
	local var_6_38 = var_12.Find(var_6_37, "2/3/3")
	local var_6_39 = arg_6_0.resTF
	local var_6_40 = var_13.Find(var_6_39, "3/1/1")
	local var_6_41 = arg_6_0.resTF
	local var_6_42 = var_14.Find(var_6_41, "3/1/2")
	local var_6_43 = arg_6_0.resTF
	local var_6_44 = var_15.Find(var_6_43, "3/1/3")
	local var_6_45 = arg_6_0.resTF
	local var_6_46 = var_16.Find(var_6_45, "3/2/1")
	local var_6_47 = arg_6_0.resTF
	local var_6_48 = var_17.Find(var_6_47, "3/2/2")
	local var_6_49 = arg_6_0.resTF
	local var_6_50 = var_18.Find(var_6_49, "3/2/3")
	local var_6_51 = arg_6_0.resTF
	local var_6_52 = var_19.Find(var_6_51, "3/3/1")
	local var_6_53 = arg_6_0.resTF
	local var_6_54 = var_20.Find(var_6_53, "3/3/2")
	local var_6_55 = arg_6_0.resTF
	local var_6_56 = var_21.Find(var_6_55, "3/3/3")
	local var_6_57 = arg_6_0.resTF
	local var_6_58 = var_22.Find(var_6_57, "4/1")
	local var_6_59 = arg_6_0.resTF
	local var_6_60 = var_23.Find(var_6_59, "4/2")
	local var_6_61 = arg_6_0.resTF
	local var_6_62 = var_24.Find(var_6_61, "4/3")
	local var_6_63 = arg_6_0.resTF
	local var_6_64 = var_25.Find(var_6_63, "5/1")
	local var_6_65 = arg_6_0.resTF
	local var_6_66 = var_26.Find(var_6_65, "5/2")
	local var_6_67 = arg_6_0.resTF
	local var_6_68 = var_27.Find(var_6_67, "5/3")
	local var_6_69 = arg_6_0.resTF
	local var_6_70 = var_28.Find(var_6_69, "6/1")
	local var_6_71 = arg_6_0.resTF
	local var_6_72 = var_29.Find(var_6_71, "6/2")
	local var_6_73 = arg_6_0.resTF
	local var_6_74 = var_30.Find(var_6_73, "6/3")

	arg_6_0.iconTable = {
		["1"] = {
			var_6_16,
			var_6_18,
			var_6_20
		},
		["21"] = {
			var_6_22,
			var_6_24,
			var_6_26
		},
		["22"] = {
			var_6_28,
			var_6_30,
			var_6_32
		},
		["23"] = {
			var_6_34,
			var_6_36,
			var_6_38
		},
		["311"] = {
			var_6_40
		},
		["312"] = {
			var_6_42
		},
		["313"] = {
			var_6_44
		},
		["321"] = {
			var_6_46
		},
		["322"] = {
			var_6_48
		},
		["323"] = {
			var_6_50
		},
		["331"] = {
			var_6_52
		},
		["332"] = {
			var_6_54
		},
		["333"] = {
			var_6_56
		},
		["4"] = {
			var_6_58,
			var_6_60,
			var_6_62
		},
		["5"] = {
			var_6_64,
			var_6_66,
			var_6_68
		},
		["6"] = {
			var_6_70,
			var_6_72,
			var_6_74
		}
	}

	local var_6_75 = arg_6_0._tf

	arg_6_0.pizzaResTF = var_31.Find(var_6_75, "Pizza")
	arg_6_0.mainToggleSelectedTF = {}
	ipairs = var_31

	for iter_6_1, iter_6_2 in var_31(arg_6_0.mainToggleTFList) do
		arg_6_0.mainToggleSelectedTF[iter_6_1] = iter_6_2:GetChild(0)
	end

	local var_6_76 = arg_6_0._tf

	arg_6_0.selectedIconResTF = var_31.Find(var_6_76, "SelectedIcon")

	return
end

function var_0_1.addListener(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.getBtn

	local function var_7_2()
		local var_8_0 = arg_7_0.ptData
		local var_8_1, var_8_2, var_8_3 = var_0.GetLevelProgress(var_8_0)

		table = var_2_10003

		if var_2_10003.indexof(arg_7_0.specialPhaseList, var_8_1, 1) then
			local var_8_4 = arg_7_0

			var_4.openMainPanel(var_8_4, var_3)
		else
			local var_8_5 = {}
			local var_8_6 = arg_7_0.ptData
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
				local var_10_0 = arg_7_0.ptData
				local var_10_1, var_10_2 = var_0.GetResProgress(var_10_0)
				local var_10_3 = arg_7_0
				local var_10_4 = var_2.emit

				ActivityMediator = var_3_10004

				local var_10_5 = var_3_10004.EVENT_PT_OPERATION
				local var_10_6 = {
					cmd = 1
				}
				local var_10_7 = arg_7_0.ptData

				var_10_6.activity_id = var_6.GetId(var_10_7)
				var_10_6.arg1 = var_10_2

				var_10_4(var_10_3, var_10_5, var_10_6)

				return
			end)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10005)

	onButton = var_1_10001

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.openBtn

	local function var_7_5()
		local var_11_0 = arg_7_0

		var_0.openMainPanel(var_11_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_3, var_7_4, var_7_5, var_1_10005)

	onButton = var_1_10001

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.helpBtn

	local function var_7_8()
		pg = var_2_10000

		local var_12_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_12_1 = var_0.ShowMsgBox
		local var_12_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_12_2.type = var_2_10003
		pg = var_2_10003
		var_12_2.helps = var_2_10003.gametip.pizzahut_help.tip

		var_12_1(var_12_0, var_12_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_6, var_7_7, var_7_8, var_1_10005)

	onButton = var_1_10001

	local var_7_9 = arg_7_0
	local var_7_10 = arg_7_0.shareBtn

	local function var_7_11()
		local var_13_0 = arg_7_0

		var_0.share(var_13_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_9, var_7_10, var_7_11, var_1_10005)

	return
end

function var_0_1.initMainPanel(arg_14_0)
	onButton = var_1_10001

	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.backBG

	local function var_14_2()
		local var_15_0 = arg_14_0

		var_0.closeSpecial(var_15_0)

		local var_15_1 = arg_14_0

		if var_0.isFinished(var_15_1) then
			setActive = var_0

			var_0(arg_14_0.openBtn, true)
		end

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_14_0, var_14_1, var_14_2, var_1_10005)

	ipairs = var_1_10001

	for iter_14_0, iter_14_1 in var_1_10001(arg_14_0.mainToggleTFList) do
		onToggle = var_1_10006

		local var_14_3 = arg_14_0
		local var_14_4 = iter_14_1

		local function var_14_5(arg_16_0)
			local var_16_0 = arg_14_0

			var_16_0.curSelectOrder = iter_14_0

			if arg_16_0 == true then
				var_16_0 = var_0_1.PosList[iter_14_0]
				setLocalPosition = var_2

				var_2(arg_14_0.secondPanel, {
					x = var_16_0
				})

				setLocalPosition = var_2

				var_2(arg_14_0.selectBtn, {
					x = var_16_0
				})

				local var_16_1

				if iter_14_0 == 1 then
					var_16_1 = arg_14_0.iconTable["1"]
				elseif iter_14_0 == 2 then
					local var_16_2 = 2 .. arg_14_0.selectedList[1]

					var_16_1 = arg_14_0.iconTable[var_16_2]
				elseif iter_14_0 == 3 then
					local var_16_3 = 3 .. arg_14_0.selectedList[1] .. arg_14_0.selectedList[2]

					var_16_1 = arg_14_0.iconTable[var_16_3]
				elseif iter_14_0 >= 4 and iter_14_0 <= 6 then
					local var_16_4 = arg_14_0.iconTable

					tostring = var_4
					var_16_1 = var_16_4[var_4(iter_14_0)]
				end

				local var_16_5 = {}

				for iter_16_0 = 1, 3 do
					var_2_10009 = arg_14_0.secondPanel
					var_16_5[iter_16_0] = var_2_10008.GetChild(var_2_10009, iter_16_0 - 1)
				end

				local var_16_6

				if #var_16_1 == 1 then
					setActive = var_16_6

					var_16_6(var_16_5[2], false)

					setActive = var_16_6

					var_16_6(var_16_5[3], false)

					getImageSprite = var_16_6
					var_16_6 = var_16_6(var_16_1[1])
					setImageSprite = var_5

					local var_16_7 = var_16_5[1]

					var_5(var_6.Find(var_16_7, "icon"), var_16_6, true)

					onToggle = var_5

					local var_16_8 = arg_14_0
					local var_16_9 = var_16_5[1]

					function var_2_10008(arg_17_0)
						if arg_17_0 == true then
							local var_17_0 = arg_14_0

							var_1.openSelectBtn(var_17_0)

							arg_14_0.curSelectIndex = 1
						end

						return
					end

					SFX_PANEL = var_2_10009

					var_5(var_16_8, var_16_9, var_2_10008, var_2_10009)

					triggerToggle = var_5

					var_5(var_16_5[1], true)
				else
					setActive = var_16_6

					var_16_6(var_16_5[2], true)

					setActive = var_16_6

					var_16_6(var_16_5[3], true)

					for iter_16_1 = 1, 3 do
						getImageSprite = var_2_10008
						var_2_10008 = var_2_10008(var_16_1[iter_16_1])
						setImageSprite = var_9

						local var_16_10 = var_16_5[iter_16_1]

						var_9(var_10.Find(var_16_10, "icon"), var_2_10008, true)

						onToggle = var_9

						local var_16_11 = arg_14_0
						local var_16_12 = var_16_5[iter_16_1]

						local function var_16_13(arg_18_0)
							if arg_18_0 == true then
								local var_18_0 = arg_14_0

								var_3_10001.openSelectBtn(var_18_0)

								var_3_10001 = arg_14_0
								var_3_10001.curSelectIndex = iter_16_1
							else
								setActive = var_3_10001

								var_3_10001(arg_14_0.selectBtn, false)

								arg_14_0.curSelectIndex = 0
							end

							return
						end

						SFX_PANEL = var_2_10013

						var_9(var_16_11, var_16_12, var_16_13, var_2_10013)
					end
				end

				for iter_16_2 = 1, 3 do
					triggerToggle = var_2_10008

					var_2_10008(var_16_5[iter_16_2], false)
				end

				local var_16_14 = arg_14_0

				var_4.openSecondPanel(var_16_14)

				setActive = var_4

				var_4(arg_14_0.selectBtn, false)
			else
				setActive = var_16_0

				var_16_0(arg_14_0.secondPanel, false)

				setActive = var_16_0

				var_16_0(arg_14_0.selectBtn, false)
			end

			local var_16_15 = arg_14_0

			var_1.updateMainSelectPanel(var_16_15)

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_14_3, var_14_4, var_14_5, var_1_10010)
	end

	onButton = var_1

	local var_14_6 = arg_14_0
	local var_14_7 = arg_14_0.selectBtn

	local function var_14_8()
		local var_19_0 = arg_14_0

		if not var_0.isFinished(var_19_0) then
			if arg_14_0.curSelectIndex then
				local var_19_1 = arg_14_0.ptData
				local var_19_2, var_19_3 = var_0.GetResProgress(var_19_1)
				local var_19_4 = arg_14_0
				local var_19_5 = var_2.emit

				ActivityMediator = var_2_10004

				local var_19_6 = var_2_10004.EVENT_PT_OPERATION
				local var_19_7 = {
					cmd = 1
				}
				local var_19_8 = arg_14_0.ptData

				var_19_7.activity_id = var_6.GetId(var_19_8)
				var_19_7.arg1 = var_19_3
				var_19_7.arg2 = arg_14_0.curSelectIndex

				function var_19_7.callback()
					arg_14_0.selectedList[arg_14_0.curSelectOrder] = arg_14_0.curSelectIndex

					local var_20_0 = arg_14_0

					var_0.closeSpecial(var_20_0)

					return
				end

				var_19_5(var_19_4, var_19_6, var_19_7)
			end
		else
			local var_19_9 = arg_14_0

			var_0.changeIndexSelect(var_19_9)

			local var_19_10 = arg_14_0

			var_0.updatePizza(var_19_10)

			local var_19_11 = arg_14_0

			var_0.updateMainSelectPanel(var_19_11)
		end

		return
	end

	SFX_PANEL = iter_14_1

	var_1(var_14_6, var_14_7, var_14_8, iter_14_1)

	return
end

function var_0_1.openMainPanel(arg_21_0, arg_21_1)
	arg_21_0.selectedList = arg_21_0:getSelectedList()
	setActive = var_2

	var_2(arg_21_0.openBtn, false)

	for iter_21_0 = 1, 6 do
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

	local var_21_6 = var_21_5(var_21_3(arg_21_0.mainPanel), -640, 0, var_0_1.Menu_Ani_Open_Time)
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
			x = 0
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

	local var_26_6 = var_26_5(var_26_3(arg_26_0.mainPanel), 0, -640, var_0_1.Menu_Ani_Close_Time)
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
			x = -640
		})

		setActive = var_2_10000

		var_2_10000(arg_26_0.specialTF, false)

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

	local var_31_6 = var_31_5(var_31_3(arg_31_0.secondPanel), -530, -60, var_0_1.Menu_Ani_Open_Time)
	local var_31_7 = var_1.setOnUpdate

	System = var_3

	local var_31_8 = var_31_7(var_31_6, var_3.Action_float(function(arg_34_0)
		setLocalPosition = var_2_10001

		var_2_10001(arg_31_0.secondPanel, {
			y = arg_34_0
		})

		return
	end))
	local var_31_9 = var_1.setOnComplete

	System = var_3

	var_31_9(var_31_8, var_3.Action(function()
		setLocalPosition = var_2_10000

		var_2_10000(arg_31_0.secondPanel, {
			y = -60
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

	local var_36_6 = var_36_5(var_36_3(arg_36_0.secondPanel), -60, -530, var_0_1.Menu_Ani_Close_Time)
	local var_36_7 = var_1.setOnUpdate

	System = var_3

	local var_36_8 = var_36_7(var_36_6, var_3.Action_float(function(arg_39_0)
		setLocalPosition = var_2_10001

		var_2_10001(arg_36_0.secondPanel, {
			y = arg_39_0
		})

		return
	end))
	local var_36_9 = var_1.setOnComplete

	System = var_3

	var_36_9(var_36_8, var_3.Action(function()
		setLocalPosition = var_2_10000

		var_2_10000(arg_36_0.secondPanel, {
			y = -530
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

	LeanTween = var_41_4

	local var_41_5 = var_41_4.value

	go = var_41_3

	local var_41_6 = var_41_5(var_41_3(arg_41_0.selectBtn), -145, -210, var_0_1.Menu_Ani_Open_Time)
	local var_41_7 = var_1.setOnUpdate

	System = var_3

	local var_41_8 = var_41_7(var_41_6, var_3.Action_float(function(arg_44_0)
		setLocalPosition = var_2_10001

		var_2_10001(arg_41_0.selectBtn, {
			y = arg_44_0
		})

		return
	end))
	local var_41_9 = var_1.setOnComplete

	System = var_3

	var_41_9(var_41_8, var_3.Action(function()
		setLocalPosition = var_2_10000

		var_2_10000(arg_41_0.selectBtn, {
			y = -210
		})

		return
	end))

	return
end

function var_0_1.closeSelectBtn(arg_46_0)
	LeanTween = var_1_10001

	local var_46_0 = var_1_10001.value

	go = var_1_10002

	local var_46_1 = var_46_0(var_1_10002(arg_46_0.selectBtn), 1, 0, var_0_1.Menu_Ani_Close_Time)
	local var_46_2 = var_1.setOnUpdate

	System = var_3

	local var_46_3 = var_46_2(var_46_1, var_3.Action_float(function(arg_47_0)
		setImageAlpha = var_2_10001

		var_2_10001(arg_46_0.selectBtn, arg_47_0)

		return
	end))
	local var_46_4 = var_1.setOnComplete

	System = var_3

	var_46_4(var_46_3, var_3.Action(function()
		setImageAlpha = var_2_10000

		var_2_10000(arg_46_0.selectBtn, 0)

		setActive = var_2_10000

		var_2_10000(arg_46_0.selectBtn, false)

		return
	end))

	LeanTween = var_46_4

	local var_46_5 = var_46_4.value

	go = var_46_3

	local var_46_6 = var_46_5(var_46_3(arg_46_0.selectBtn), -210, -145, var_0_1.Menu_Ani_Close_Time)
	local var_46_7 = var_1.setOnUpdate

	System = var_3

	local var_46_8 = var_46_7(var_46_6, var_3.Action_float(function(arg_49_0)
		setLocalPosition = var_2_10001

		var_2_10001(arg_46_0.selectBtn, {
			y = arg_49_0
		})

		return
	end))
	local var_46_9 = var_1.setOnComplete

	System = var_3

	var_46_9(var_46_8, var_3.Action(function()
		setLocalPosition = var_2_10000

		var_2_10000(arg_46_0.selectBtn, {
			y = -145
		})

		setActive = var_2_10000

		var_2_10000(arg_46_0.selectBtn, false)

		return
	end))

	return
end

function var_0_1.closeSpecial(arg_51_0)
	arg_51_0:closeSelectBtn()
	arg_51_0:closeSecondPanel()

	return
end

function var_0_1.updatePizza(arg_52_0)
	setActive = var_1_10001

	var_1_10001(arg_52_0.empty, arg_52_0.selectedList[1] == 0)

	setActive = var_1_10001

	var_1_10001(arg_52_0.pizzaTF, arg_52_0.selectedList[1] > 0)

	local var_52_0 = arg_52_0.pizzaTF
	local var_52_1 = var_1.Find(var_52_0, "PizzaPan")
	local var_52_2 = arg_52_0.pizzaTF
	local var_52_3 = var_2.Find(var_52_2, "PizzaSauce")
	local var_52_4 = arg_52_0.pizzaTF
	local var_52_5 = var_3.Find(var_52_4, "PizzaCheese")
	local var_52_6 = arg_52_0.pizzaTF
	local var_52_7 = var_4.Find(var_52_6, "EX1")
	local var_52_8 = arg_52_0.pizzaTF
	local var_52_9 = var_5.Find(var_52_8, "EX2")
	local var_52_10 = arg_52_0.pizzaTF
	local var_52_11 = var_6.Find(var_52_10, "EX3")

	setActive = var_52_10

	local var_52_12 = var_52_1
	local var_52_14

	if arg_52_0.selectedList[1] then
		local var_52_13 = arg_52_0.selectedList[1]

		var_52_14 = 0 < var_52_13
	end

	var_52_10(var_52_12, var_52_14)

	setActive = var_52_10

	local var_52_15 = var_52_3
	local var_52_17

	if arg_52_0.selectedList[2] then
		local var_52_16 = arg_52_0.selectedList[2]

		var_52_17 = 0 < var_52_16
	end

	var_52_10(var_52_15, var_52_17)

	setActive = var_52_10

	local var_52_18 = var_52_5
	local var_52_20

	if arg_52_0.selectedList[3] then
		local var_52_19 = arg_52_0.selectedList[3]

		var_52_20 = 0 < var_52_19
	end

	var_52_10(var_52_18, var_52_20)

	setActive = var_52_10

	local var_52_21 = var_52_7
	local var_52_23

	if arg_52_0.selectedList[4] then
		local var_52_22 = arg_52_0.selectedList[4]

		var_52_23 = 0 < var_52_22
	end

	var_52_10(var_52_21, var_52_23)

	setActive = var_52_10

	local var_52_24 = var_52_9
	local var_52_26

	if arg_52_0.selectedList[5] then
		local var_52_25 = arg_52_0.selectedList[5]

		var_52_26 = 0 < var_52_25
	end

	var_52_10(var_52_24, var_52_26)

	setActive = var_52_10

	local var_52_27 = var_52_11
	local var_52_29

	if arg_52_0.selectedList[6] then
		local var_52_28 = arg_52_0.selectedList[6]

		var_52_29 = 0 < var_52_28
	end

	var_52_10(var_52_27, var_52_29)

	if arg_52_0.selectedList[1] and arg_52_0.selectedList[1] > 0 then
		getImageSprite = var_7

		local var_52_30 = arg_52_0._tf
		local var_52_31 = var_8.Find

		tostring = var_1_10010

		local var_52_32 = var_7(var_52_31(var_52_30, var_1_10010(arg_52_0.selectedList[1]), arg_52_0.pizzaResTF))

		setImageSprite = var_8

		var_8(var_52_1, var_52_32, true)
	end

	if arg_52_0.selectedList[2] and arg_52_0.selectedList[2] > 0 then
		local var_52_33 = arg_52_0.selectedList[1] .. arg_52_0.selectedList[2]

		getImageSprite = var_8

		local var_52_34 = arg_52_0.pizzaResTF
		local var_52_35 = var_8(var_9.Find(var_52_34, var_52_33))

		setImageSprite = var_9

		var_9(var_52_3, var_52_35, true)
	end

	if arg_52_0.selectedList[3] and arg_52_0.selectedList[3] > 0 then
		local var_52_36 = arg_52_0.selectedList[1] .. arg_52_0.selectedList[2] .. arg_52_0.selectedList[3]

		getImageSprite = var_8

		local var_52_37 = arg_52_0.pizzaResTF
		local var_52_38 = var_8(var_9.Find(var_52_37, var_52_36))

		setImageSprite = var_9

		var_9(var_52_5, var_52_38, true)
	end

	if arg_52_0.selectedList[4] and arg_52_0.selectedList[4] > 0 then
		local var_52_39 = 4 .. arg_52_0.selectedList[4]

		getImageSprite = var_8

		local var_52_40 = arg_52_0.pizzaResTF
		local var_52_41 = var_8(var_9.Find(var_52_40, var_52_39))

		setImageSprite = var_9

		var_9(var_52_7, var_52_41, true)
	end

	if arg_52_0.selectedList[5] and arg_52_0.selectedList[5] > 0 then
		local var_52_42 = 5 .. arg_52_0.selectedList[5]

		getImageSprite = var_8

		local var_52_43 = arg_52_0.pizzaResTF
		local var_52_44 = var_8(var_9.Find(var_52_43, var_52_42))

		setImageSprite = var_9

		var_9(var_52_9, var_52_44, true)
	end

	if arg_52_0.selectedList[6] and arg_52_0.selectedList[6] > 0 then
		local var_52_45 = 6 .. arg_52_0.selectedList[6]

		getImageSprite = var_8

		local var_52_46 = arg_52_0.pizzaResTF
		local var_52_47 = var_8(var_9.Find(var_52_46, var_52_45))

		setImageSprite = var_9

		var_9(var_52_11, var_52_47, true)
	end

	return
end

function var_0_1.updateMainSelectPanel(arg_53_0)
	if arg_53_0.selectedList[1] and arg_53_0.selectedList[1] > 0 then
		getImageSprite = var_1

		local var_53_0 = arg_53_0._tf
		local var_53_1 = var_2.Find

		tostring = var_1_10004

		local var_53_2 = var_1(var_53_1(var_53_0, var_1_10004(arg_53_0.selectedList[1]), arg_53_0.selectedIconResTF))

		setImageSprite = var_2

		var_2(arg_53_0.mainToggleSelectedTF[1], var_53_2, true)

		setActive = var_2

		var_2(arg_53_0.mainToggleSelectedTF[1], true)
	end

	if arg_53_0.selectedList[2] and arg_53_0.selectedList[2] > 0 then
		local var_53_3 = arg_53_0.selectedList[1] .. arg_53_0.selectedList[2]

		getImageSprite = var_2

		local var_53_4 = arg_53_0.selectedIconResTF
		local var_53_5 = var_2(var_3.Find(var_53_4, var_53_3))

		setImageSprite = var_3

		var_3(arg_53_0.mainToggleSelectedTF[2], var_53_5, true)

		setActive = var_3

		var_3(arg_53_0.mainToggleSelectedTF[2], true)
	end

	if arg_53_0.selectedList[3] and arg_53_0.selectedList[3] > 0 then
		local var_53_6 = arg_53_0.selectedList[1] .. arg_53_0.selectedList[2] .. arg_53_0.selectedList[3]

		getImageSprite = var_2

		local var_53_7 = arg_53_0.selectedIconResTF
		local var_53_8 = var_2(var_3.Find(var_53_7, var_53_6))

		setImageSprite = var_3

		var_3(arg_53_0.mainToggleSelectedTF[3], var_53_8, true)

		setActive = var_3

		var_3(arg_53_0.mainToggleSelectedTF[3], true)
	end

	if arg_53_0.selectedList[4] and arg_53_0.selectedList[4] > 0 then
		local var_53_9 = 4 .. arg_53_0.selectedList[4]

		getImageSprite = var_2

		local var_53_10 = arg_53_0.selectedIconResTF
		local var_53_11 = var_2(var_3.Find(var_53_10, var_53_9))

		setImageSprite = var_3

		var_3(arg_53_0.mainToggleSelectedTF[4], var_53_11, true)

		setActive = var_3

		var_3(arg_53_0.mainToggleSelectedTF[4], true)
	end

	if arg_53_0.selectedList[5] and arg_53_0.selectedList[5] > 0 then
		local var_53_12 = 5 .. arg_53_0.selectedList[5]

		getImageSprite = var_2

		local var_53_13 = arg_53_0.selectedIconResTF
		local var_53_14 = var_2(var_3.Find(var_53_13, var_53_12))

		setImageSprite = var_3

		var_3(arg_53_0.mainToggleSelectedTF[5], var_53_14, true)

		setActive = var_3

		var_3(arg_53_0.mainToggleSelectedTF[5], true)
	end

	if arg_53_0.selectedList[6] and arg_53_0.selectedList[6] > 0 then
		local var_53_15 = 6 .. arg_53_0.selectedList[6]

		getImageSprite = var_2

		local var_53_16 = arg_53_0.selectedIconResTF
		local var_53_17 = var_2(var_3.Find(var_53_16, var_53_15))

		setImageSprite = var_3

		var_3(arg_53_0.mainToggleSelectedTF[6], var_53_17, true)

		setActive = var_3

		var_3(arg_53_0.mainToggleSelectedTF[6], true)
	end

	return
end

function var_0_1.isFinished(arg_54_0)
	return #arg_54_0.activity.data2_list == 6
end

function var_0_1.changeIndexSelect(arg_55_0)
	arg_55_0.selectedList[arg_55_0.curSelectOrder] = arg_55_0.curSelectIndex

	local var_55_0 = var_0_1.Pizza_Save_Tag_Pre .. arg_55_0.curSelectOrder

	PlayerPrefs = var_2

	var_2.SetInt(var_55_0, arg_55_0.curSelectIndex)

	return
end

function var_0_1.getSelectedList(arg_56_0)
	arg_56_0.selectedList = {
		0,
		0,
		0,
		0,
		0,
		0
	}
	ipairs = var_1

	for iter_56_0, iter_56_1 in var_1(arg_56_0.activity.data2_list) do
		arg_56_0.selectedList[iter_56_0] = iter_56_1
	end

	if arg_56_0:isFinished() then
		for iter_56_2 = 1, 6 do
			local var_56_0 = var_0_1.Pizza_Save_Tag_Pre .. iter_56_2

			PlayerPrefs = var_6

			if var_6.GetInt(var_56_0, 0) > 0 then
				arg_56_0.selectedList[iter_56_2] = var_6
			end
		end
	end

	arg_56_0:saveSelectedList()

	return arg_56_0.selectedList
end

function var_0_1.saveSelectedList(arg_57_0)
	for iter_57_0 = 1, 6 do
		local var_57_0 = var_0_1.Pizza_Save_Tag_Pre .. iter_57_0
		local var_57_1 = arg_57_0.selectedList[iter_57_0]

		PlayerPrefs = var_1_10007

		var_1_10007.SetInt(var_57_0, var_57_1)
	end

	return
end

function var_0_1.share(arg_58_0)
	PoolMgr = var_1_10001

	local var_58_0 = var_1_10001.GetInstance()

	var_1.GetUI(var_58_0, "PizzahutSharePage", false, function(arg_59_0)
		GameObject = var_2_10001

		local var_59_0 = var_2_10001.Find("UICamera/Canvas/UIMain")

		SetParent = var_2

		var_2(arg_59_0, var_59_0, false)

		arg_58_0.shareGo = arg_59_0

		local var_59_1 = arg_59_0:Find("PlayerName")
		local var_59_2 = arg_59_0
		local var_59_3 = arg_59_0.Find(var_59_2, "PizzaContainer")

		getProxy = var_59_2
		PlayerProxy = var_5

		local var_59_4 = var_59_2(var_5)
		local var_59_5 = var_4.getData(var_59_4).name

		setText = var_2_10007

		var_2_10007(var_59_1, var_59_5)

		getProxy = var_2_10007
		PlayerProxy = var_8

		local var_59_6 = var_2_10007(var_8)
		local var_59_7 = var_7.getRawData(var_59_6)

		getProxy = var_59_6
		UserProxy = var_9

		local var_59_8 = var_59_6(var_9)
		local var_59_9 = var_8.getRawData(var_59_8)

		getProxy = var_59_8
		ServerProxy = var_2_10010

		local var_59_10 = var_59_8(var_2_10010)
		local var_59_11 = var_9.getRawData(var_59_10)
		local var_59_12

		if not var_59_9 or not var_59_9.server then
			var_59_12 = 0
		end

		local var_59_13 = var_59_11[var_59_12]
		local var_59_14

		if not var_59_7 or not var_59_7.name then
			var_59_14 = ""
		end

		local var_59_15

		if not var_59_13 or not var_59_13.name then
			var_59_15 = ""
		end

		local var_59_16 = arg_59_0
		local var_59_17 = arg_59_0.Find(var_59_16, "deck")

		setText = var_59_16

		var_59_16(var_59_17:Find("name/value"), var_59_14)

		setText = var_59_16

		var_59_16(var_59_17:Find("server/value"), var_59_15)

		setText = var_59_16

		var_59_16(var_59_17:Find("lv/value"), var_59_7.level)

		cloneTplTo = var_59_16

		local var_59_18 = var_59_16(arg_58_0.pizzaTF, var_59_3)

		setLocalPosition = var_14
		tf = var_15

		var_14(var_15(var_59_18), {
			x = 0,
			y = 0
		})

		setLocalScale = var_14
		tf = var_15

		var_14(var_15(var_59_18), {
			x = 1.4,
			y = 1.4
		})

		pg = var_14

		local var_59_19 = var_14.ShareMgr.GetInstance()
		local var_59_20 = var_14.Share

		pg = var_16

		var_59_20(var_59_19, var_16.ShareMgr.TypePizzahut)

		if arg_58_0.shareGo then
			PoolMgr = var_14

			local var_59_21 = var_14.GetInstance()

			var_14.ReturnUI(var_59_21, "PizzahutSharePage", arg_58_0.shareGo)

			arg_58_0.shareGo = nil
		end

		return
	end)

	return
end

function var_0_1.initSD(arg_60_0)
	local var_60_0 = arg_60_0.bg

	arg_60_0.sdContainer = var_1.Find(var_60_0, "sdcontainer")
	arg_60_0.spine = nil
	GetSpineRequestPackage = var_1

	local var_60_1 = var_1.New("chuixue_6", function(arg_61_0)
		SetParent = var_2_10001

		var_2_10001(arg_61_0, arg_60_0.sdContainer)

		arg_60_0.spine = arg_61_0

		local var_61_0 = arg_60_0.spine.transform

		Vector3 = var_2
		var_61_0.localScale = var_2.one

		local var_61_1 = arg_60_0.spine

		if var_1.GetComponent(var_61_1, "SpineAnimUI") then
			var_1:SetAction("stand", 0)
		end

		arg_60_0.spineLRQ = nil

		return
	end)

	arg_60_0.spineLRQ = var_1.Start(var_60_1)
	setActive = var_1

	var_1(arg_60_0.sdContainer, true)

	return
end

function var_0_1.showBubble(arg_62_0, arg_62_1)
	local var_62_0

	if not arg_62_1 then
		isActive = var_1_10003

		if var_1_10003(arg_62_0.battleBtn) then
			i18n = var_1_10003
			var_62_0 = var_1_10003("sofmapsd_1")
		else
			isActive = var_1_10003

			if var_1_10003(arg_62_0.getBtn) then
				i18n = var_1_10003
				var_62_0 = var_1_10003("sofmapsd_2")
			else
				isActive = var_1_10003

				if var_1_10003(arg_62_0.gotBtn) then
					i18n = var_1_10003
					var_62_0 = var_1_10003("sofmapsd_4")
				end
			end
		end
	else
		var_62_0 = arg_62_1
	end

	setText = var_1_10003

	var_1_10003(arg_62_0.bubbleText, var_62_0)

	local function var_62_1(arg_63_0)
		local var_63_0 = arg_62_0.bubbleCG

		var_63_0.alpha = arg_63_0
		setLocalScale = var_63_0

		local var_63_1 = arg_62_0.bubble

		Vector3 = var_2_10003

		var_63_0(var_63_1, var_2_10003.one * arg_63_0)

		return
	end

	local function var_62_2()
		LeanTween = var_2_10000

		local var_64_0 = var_2_10000.value

		go = var_2_10001

		local var_64_1 = var_64_0(var_2_10001(arg_62_0.bubble), 1, 0, var_0_1.FADE_OUT_TIME)
		local var_64_2 = var_0.setOnUpdate

		System = var_2

		local var_64_3 = var_64_2(var_64_1, var_2.Action_float(var_62_1))
		local var_64_4 = var_0.setOnComplete

		System = var_2

		var_64_4(var_64_3, var_2.Action(function()
			setActive = var_3_10000

			var_3_10000(arg_62_0.bubble, false)

			return
		end))

		return
	end

	LeanTween = var_5

	local var_62_3 = var_5.cancel

	go = var_1_10006

	var_62_3(var_1_10006(arg_62_0.bubble))

	setActive = var_62_3

	var_62_3(arg_62_0.bubble, true)

	LeanTween = var_62_3

	local var_62_4 = var_62_3.value

	go = var_6

	local var_62_5 = var_62_4(var_6(arg_62_0.bubble), 0, 1, var_0_1.FADE_TIME)
	local var_62_6 = var_5.setOnUpdate

	System = var_7

	local var_62_7 = var_62_6(var_62_5, var_7.Action_float(var_62_1))
	local var_62_8 = var_5.setOnComplete

	System = var_7

	var_62_8(var_62_7, var_7.Action(function()
		LeanTween = var_2_10000

		local var_66_0 = var_2_10000.delayedCall

		go = var_2_10001

		local var_66_1 = var_2_10001(arg_62_0.bubble)
		local var_66_2 = var_0_1.SHOW_TIME

		System = var_2_10003

		var_66_0(var_66_1, var_66_2, var_2_10003.Action(var_62_2))

		return
	end))

	return
end

return var_0_1
