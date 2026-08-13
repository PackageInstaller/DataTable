class = var_0_10000

local var_0_0 = "WorldSwitchPlanningLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.MODE_DIFFICULT = 0
var_0_1.MODE_SAFE = 1
var_0_1.MODE_TREASURE = 2
var_0_1.modeToggleDic = {
	[0] = {
		boss = true,
		wait_2 = true,
		wait = true,
		base = true,
		consume = true
	},
	{
		safe = true,
		wait_2 = true,
		wait = true,
		boss = true,
		consume = true
	},
	{
		treasure = true,
		consume = true,
		wait = true,
		boss = true
	}
}

function var_0_1.getUIName(arg_1_0)
	return "WorldSwitchPlanningUI"
end

function var_0_1.init(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_0, arg_2_0._tf)

	local var_2_1 = arg_2_0._tf

	arg_2_0.rtBg = var_1.Find(var_2_1, "bg")
	onButton = var_1

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.rtBg

	local function var_2_4()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_2_2, var_2_3, var_2_4, var_1_10005)

	local var_2_5 = arg_2_0._tf

	arg_2_0.rtWindow = var_1.Find(var_2_5, "window")

	local var_2_6 = arg_2_0.rtWindow

	arg_2_0.btnBack = var_1.Find(var_2_6, "top/btnBack")
	onButton = var_1

	local var_2_7 = arg_2_0
	local var_2_8 = arg_2_0.btnBack

	local function var_2_9()
		local var_4_0 = arg_2_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_2_7, var_2_8, var_2_9, var_1_10005)

	local var_2_10 = arg_2_0.rtWindow

	arg_2_0.btnCancel = var_1.Find(var_2_10, "button_container/custom_button_2")
	setText = var_1

	local var_2_11 = arg_2_0.btnCancel
	local var_2_12 = var_2.Find(var_2_11, "pic")

	i18n = var_2_11

	var_1(var_2_12, var_2_11("text_cancel"))

	onButton = var_1

	local var_2_13 = arg_2_0
	local var_2_14 = arg_2_0.btnCancel

	local function var_2_15()
		local var_5_0 = arg_2_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_2_13, var_2_14, var_2_15, var_1_10005)

	local var_2_16 = arg_2_0.rtWindow

	arg_2_0.btnConfirm = var_1.Find(var_2_16, "button_container/custom_button_1")
	setText = var_1

	local var_2_17 = arg_2_0.btnConfirm
	local var_2_18 = var_2.Find(var_2_17, "pic")

	i18n = var_2_17

	var_1(var_2_18, var_2_17("text_confirm"))

	onButton = var_1

	local var_2_19 = arg_2_0
	local var_2_20 = arg_2_0.btnConfirm

	local function var_2_21()
		local var_6_0 = arg_2_0
		local var_6_1 = var_0.emit

		WorldSwitchPlanningMediator = var_2_10002

		var_6_1(var_6_0, var_2_10002.OnConfirm)

		local var_6_2 = arg_2_0

		var_0.closeView(var_6_2)

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_2_19, var_2_20, var_2_21, var_1_10005)

	local var_2_22 = arg_2_0.rtWindow

	arg_2_0.btnMove = var_1.Find(var_2_22, "button_container/custom_button_3")
	setText = var_1

	local var_2_23 = arg_2_0.btnMove
	local var_2_24 = var_2.Find(var_2_23, "pic")

	i18n = var_2_23

	var_1(var_2_24, var_2_23("text_goto"))

	onButton = var_1

	local var_2_25 = arg_2_0
	local var_2_26 = arg_2_0.btnMove

	local function var_2_27()
		nowWorld = var_2_10000

		local var_7_0 = var_2_10000()
		local var_7_1 = var_0.GetInventoryProxy(var_7_0)
		local var_7_2 = var_1.GetItemCount

		WorldConst = var_2_10003

		local var_7_5

		if var_7_2(var_7_1, var_2_10003.SwitchPlainingItemId) > 0 then
			local var_7_3 = arg_2_0
			local var_7_4 = var_1.emit

			WorldSwitchPlanningMediator = var_7_5
			var_7_5 = var_7_5.OnMove

			local var_7_6 = {
				inMap = true
			}

			Context = var_2_10005
			var_2_10005 = var_2_10005.New

			local var_7_7 = {}

			WorldInventoryMediator = var_2_10007
			var_7_7.mediator = var_2_10007
			WorldInventoryLayer = var_2_10007
			var_7_7.viewComponent = var_2_10007
			var_7_6.context = var_2_10005(var_7_7)

			var_7_4(var_7_3, var_7_5, var_7_6)
		else
			local var_7_8 = var_0
			local var_7_9 = var_0.IsSystemOpen

			WorldConst = var_7_5

			if not var_7_9(var_7_8, var_7_5.SystemResetShop) then
				pg = var_1

				local var_7_10 = var_1.TipsMgr.GetInstance()
				local var_7_11 = var_1.ShowTips

				i18n = var_3

				var_7_11(var_7_10, var_3("world_automode_treasure_3"))
			else
				local var_7_12 = arg_2_0
				local var_7_13 = var_1.emit

				WorldSwitchPlanningMediator = var_3

				local var_7_14 = var_3.OnMove
				local var_7_15 = {
					inMap = false
				}

				Context = var_2_10005

				local var_7_16 = var_2_10005.New
				local var_7_17 = {}

				WorldShopMediator = var_2_10007
				var_7_17.mediator = var_2_10007
				WorldShopLayer = var_2_10007
				var_7_17.viewComponent = var_2_10007
				var_7_15.context = var_7_16(var_7_17)

				var_7_13(var_7_12, var_7_14, var_7_15)
			end
		end

		local var_7_18 = arg_2_0

		var_1.closeView(var_7_18)

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_2_25, var_2_26, var_2_27, var_1_10005)

	local var_2_28 = arg_2_0.rtWindow

	arg_2_0.rtContent = var_1.Find(var_2_28, "content")
	onToggle = var_1

	local var_2_29 = arg_2_0
	local var_2_30 = arg_2_0.rtContent
	local var_2_31 = var_3.Find(var_2_30, "toggles/toggle_base")

	local function var_2_32(arg_8_0)
		if arg_8_0 then
			local var_8_0 = arg_2_0

			var_1.updateView(var_8_0, var_0_1.MODE_DIFFICULT)

			scrollTo = var_1

			local var_8_1 = arg_2_0.rtView

			var_1(var_2.Find(var_8_1, "content"), nil, 1)
		end

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_29, var_2_31, var_2_32, var_5)

	onToggle = var_1

	local var_2_33 = arg_2_0
	local var_2_34 = arg_2_0.rtContent
	local var_2_35 = var_3.Find(var_2_34, "toggles/toggle_safe")

	local function var_2_36(arg_9_0)
		if arg_9_0 then
			local var_9_0 = arg_2_0

			var_1.updateView(var_9_0, var_0_1.MODE_SAFE)

			scrollTo = var_1

			local var_9_1 = arg_2_0.rtView

			var_1(var_2.Find(var_9_1, "content"), nil, 1)
		end

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_33, var_2_35, var_2_36, var_5)

	onToggle = var_1

	local var_2_37 = arg_2_0
	local var_2_38 = arg_2_0.rtContent
	local var_2_39 = var_3.Find(var_2_38, "toggles/toggle_treasure")

	local function var_2_40(arg_10_0)
		if arg_10_0 then
			local var_10_0 = arg_2_0

			var_1.updateView(var_10_0, var_0_1.MODE_TREASURE)

			scrollTo = var_1

			local var_10_1 = arg_2_0.rtView

			var_1(var_2.Find(var_10_1, "content"), nil, 1)
		end

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_37, var_2_39, var_2_40, var_5)

	local var_2_41 = arg_2_0.rtContent

	arg_2_0.rtView = var_1.Find(var_2_41, "view")
	ipairs = var_1

	for iter_2_0, iter_2_1 in var_1({
		"base",
		"treasure"
	}) do
		local var_2_42 = arg_2_0.rtView
		local var_2_43 = var_6.Find(var_2_42, "content/" .. iter_2_1 .. "/toggles")
		local var_2_44 = var_6.Find(var_2_43, "all")
		local var_2_45 = {}
		local var_2_46 = 0
		local var_2_47 = var_6.childCount

		eachChild = var_1_10011

		var_1_10011(var_6, function(arg_11_0)
			onToggle = var_2_10001

			local var_11_0 = arg_2_0
			local var_11_1 = arg_11_0

			local function var_11_2(arg_12_0)
				local var_12_0 = arg_12_0 and 1 or 0

				defaultValue = var_3_10002

				local var_12_1 = var_12_0 - var_3_10002(var_2_45[arg_11_0.name], 0)

				var_2_45[arg_11_0.name] = arg_12_0 and 1 or 0
				var_2_46 = var_2_46 + var_12_1

				local var_12_2 = true

				if arg_11_0 == var_2_44 and arg_12_0 then
					eachChild = var_3

					var_3(var_0, function(arg_13_0)
						if arg_13_0 ~= arg_11_0 then
							GetComponent = var_1

							local var_13_0 = arg_13_0

							typeof = var_4_10003
							Toggle = var_4_10004

							if var_1(var_13_0, var_4_10003(var_4_10004)).isOn == true then
								triggerToggle = var_1

								var_1(arg_13_0, false)

								var_12_2 = false
							end
						end

						return
					end)
				elseif var_2_46 == 0 or var_2_46 >= var_2_47 - 1 then
					triggerToggle = var_3

					var_3(var_2_44, true)

					var_12_2 = false
				elseif var_2_46 > 1 then
					GetComponent = var_3

					local var_12_3 = var_2_44

					typeof = var_3_10005
					Toggle = var_3_10006

					if var_3(var_12_3, var_3_10005(var_3_10006)).isOn == true then
						triggerToggle = var_3

						var_3(var_2_44, false)

						var_12_2 = false
					end
				end

				if var_12_2 then
					local var_12_4 = arg_2_0

					var_3.saveConfig(var_12_4, iter_2_1)
				end

				return
			end

			SFX_PANEL = var_2_10005

			var_2_10001(var_11_0, var_11_1, var_11_2, var_2_10005)

			return
		end)
	end

	pg = var_1

	local var_2_48 = var_1.gameset.joint_boss_ticket.description[1] + var_1[2]
	local var_2_49 = var_1[1] .. "&" .. var_2_48
	local var_2_50 = {}

	table = var_5

	var_5.insert(var_2_50, "")

	table = var_5

	var_5.insert(var_2_50, var_2_49)

	table = var_5

	local var_2_51 = var_5.insert
	local var_2_52 = var_2_50

	tostring = var_7

	var_2_51(var_2_52, var_7(var_2_48))

	arg_2_0.togglesList = {
		safe = {
			getFlag = function()
				PlayerPrefs = var_2_10000

				return var_2_10000.GetString("auto_switch_difficult_safe", "all")
			end,
			setFlag = function(arg_15_0)
				PlayerPrefs = var_2_10001

				var_2_10001.SetString("auto_switch_difficult_safe", arg_15_0)

				PlayerPrefs = var_1

				var_1.Save()

				return
			end,
			info = {
				all = "all",
				only = "only"
			}
		},
		wait = {
			getFlag = function()
				PlayerPrefs = var_2_10000

				return var_2_10000.GetInt("auto_switch_wait", 0)
			end,
			setFlag = function(arg_17_0)
				PlayerPrefs = var_2_10001

				var_2_10001.SetInt("auto_switch_wait", arg_17_0)

				PlayerPrefs = var_1

				var_1.Save()

				return
			end,
			info = {
				yes = 1,
				no = 0
			}
		},
		wait_2 = {
			getFlag = function()
				PlayerPrefs = var_2_10000

				return var_2_10000.GetInt("auto_switch_wait_2", 0)
			end,
			setFlag = function(arg_19_0)
				PlayerPrefs = var_2_10001

				var_2_10001.SetInt("auto_switch_wait_2", arg_19_0)

				PlayerPrefs = var_1

				var_1.Save()

				return
			end,
			info = {
				yes = 1,
				no = 0
			}
		},
		boss = {
			getFlag = function()
				getProxy = var_2_10000
				SettingsProxy = var_2_10001

				local var_20_0 = var_2_10000(var_2_10001)

				return var_0.GetWorldBossProgressTipFlag(var_20_0)
			end,
			setFlag = function(arg_21_0)
				getProxy = var_2_10001
				SettingsProxy = var_2_10002

				local var_21_0 = var_2_10001(var_2_10002)

				var_1.WorldBossProgressTipFlag(var_21_0, arg_21_0)

				return
			end,
			info = {
				no = var_2_50[1],
				["100"] = var_2_50[2],
				["200"] = var_2_50[3]
			}
		},
		consume = {
			getFlag = function()
				getProxy = var_2_10000
				SettingsProxy = var_2_10001

				local var_22_0 = var_2_10000(var_2_10001)

				return var_0.GetWorldFlag(var_22_0, "consume_item")
			end,
			setFlag = function(arg_23_0)
				getProxy = var_2_10001
				SettingsProxy = var_2_10002

				local var_23_0 = var_2_10001(var_2_10002)

				var_1.SetWorldFlag(var_23_0, "consume_item", arg_23_0)

				return
			end,
			info = {
				yes = true,
				no = false
			}
		}
	}
	pairs = var_5

	for iter_2_2, iter_2_3 in var_5(arg_2_0.togglesList) do
		local var_2_53 = arg_2_0.rtView
		local var_2_54 = var_10.Find(var_2_53, "content/" .. iter_2_2 .. "/toggles")

		pairs = var_2_53

		for iter_2_4, iter_2_5 in var_2_53(iter_2_3.info) do
			onToggle = var_1_10016
			var_1_10017 = arg_2_0

			local var_2_55 = var_2_54:Find(iter_2_4)

			local function var_2_56(arg_24_0)
				if arg_24_0 then
					iter_2_3.setFlag(iter_2_5)
				end

				return
			end

			SFX_PANEL = var_20

			var_1_10016(var_1_10017, var_2_55, var_2_56, var_20)
		end
	end

	local var_2_57 = {
		base = {
			text = "world_automode_setting_1",
			info = {
				["5"] = "world_automode_setting_1_2",
				until_4 = "world_automode_setting_1_1",
				["6"] = "world_automode_setting_1_3",
				all = "world_automode_setting_1_4"
			}
		},
		safe = {
			text = "world_automode_setting_2",
			info = {
				all = "world_automode_setting_2_2",
				only = "world_automode_setting_2_1"
			}
		},
		treasure = {
			text = "world_automode_setting_new_1",
			info = {
				all = "world_automode_setting_new_1_5",
				["6"] = "world_automode_setting_new_1_4",
				["5"] = "world_automode_setting_new_1_3",
				until_3 = "world_automode_setting_new_1_1",
				["4"] = "world_automode_setting_new_1_2"
			}
		},
		wait = {
			text = "world_automode_setting_all_1",
			info = {
				yes = "world_automode_setting_all_1_1",
				no = "world_automode_setting_all_1_2"
			}
		},
		wait_2 = {
			text = "world_automode_setting_all_4",
			info = {
				yes = "world_automode_setting_all_4_1",
				no = "world_automode_setting_all_4_2"
			}
		},
		boss = {
			text = "world_automode_setting_all_2",
			info = {
				["200"] = "world_automode_setting_all_2_3",
				["100"] = "world_automode_setting_all_2_2",
				no = "world_automode_setting_all_2_1"
			}
		},
		consume = {
			text = "world_automode_setting_all_3",
			info = {
				yes = "world_automode_setting_all_3_2",
				no = "world_automode_setting_all_3_1"
			}
		}
	}

	pairs = var_6

	for iter_2_6, iter_2_7 in var_6(var_2_57) do
		local var_2_58 = arg_2_0.rtView
		local var_2_59 = var_11.Find(var_2_58, "content/" .. iter_2_6)

		setText = var_2_58

		local var_2_60 = var_2_59
		local var_2_61 = var_2_59.Find(var_2_60, "Text")

		i18n = var_2_60

		var_2_58(var_2_61, var_2_60(iter_2_7.text))

		pairs = var_2_58

		for iter_2_8, iter_2_9 in var_2_58(iter_2_7.info) do
			setText = var_1_10017

			local var_2_62 = var_2_59
			local var_2_63 = var_2_59.Find(var_2_62, "toggles/" .. iter_2_8 .. "/Text")

			i18n = var_2_62

			var_1_10017(var_2_63, var_2_62(iter_2_9))
		end
	end

	setText = var_6

	local var_2_64 = arg_2_0.rtWindow
	local var_2_65 = var_7.Find(var_2_64, "top/bg/title")

	i18n = var_2_64

	var_6(var_2_65, var_2_64("world_automode_title_1"))

	setText = var_6

	local var_2_66 = arg_2_0.rtWindow
	local var_2_67 = var_7.Find(var_2_66, "top/bg/title/title_en")

	i18n = var_2_66

	var_6(var_2_67, var_2_66("world_automode_title_2"))

	setText = var_6

	local var_2_68 = arg_2_0.rtContent
	local var_2_69 = var_7.Find(var_2_68, "toggles/toggle_base/Text")

	i18n = var_2_68

	var_6(var_2_69, var_2_68("area_putong"))

	setText = var_6

	local var_2_70 = arg_2_0.rtContent
	local var_2_71 = var_7.Find(var_2_70, "toggles/toggle_safe/Text")

	i18n = var_2_70

	var_6(var_2_71, var_2_70("area_anquan"))

	setText = var_6

	local var_2_72 = arg_2_0.rtContent
	local var_2_73 = var_7.Find(var_2_72, "toggles/toggle_treasure/Text")

	i18n = var_2_72

	var_6(var_2_73, var_2_72("area_yinmi"))

	return
end

function var_0_1.didEnter(arg_25_0)
	triggerToggle = var_1_10001

	local var_25_0 = arg_25_0.rtContent
	local var_25_1 = var_2.Find(var_25_0, "toggles")
	local var_25_2 = var_2.GetChild

	PlayerPrefs = var_4

	var_1_10001(var_25_2(var_25_1, var_4.GetInt("auto_switch_mode", 0)), true)

	return
end

function var_0_1.willExit(arg_26_0)
	pg = var_1_10001

	local var_26_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_26_0, arg_26_0._tf)

	return
end

function var_0_1.initToggle(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0.togglesList[arg_27_1].getFlag()

	pairs = var_1_10004

	for iter_27_0, iter_27_1 in var_1_10004(var_2.info) do
		if iter_27_1 == var_27_0 then
			triggerToggle = var_1_10009

			local var_27_1 = arg_27_0.rtView

			var_1_10009(var_10.Find(var_27_1, "content/" .. arg_27_1 .. "/toggles/" .. iter_27_0), true)

			break
		end
	end

	return
end

function var_0_1.updateView(arg_28_0, arg_28_1)
	PlayerPrefs = var_1_10002

	var_1_10002.SetInt("auto_switch_mode", arg_28_1)

	PlayerPrefs = var_2

	var_2.Save()

	nowWorld = var_2

	local var_28_0 = var_2()
	local var_28_1, var_28_2

	if arg_28_1 == var_0_1.MODE_TREASURE then
		var_28_1 = var_28_0
		var_28_2 = not var_28_0.GetGobalFlag(var_28_1, "treasure_flag")
	else
		var_28_2 = false
	end

	if false then
		var_28_2 = true
	end

	setActive = var_28_1

	local var_28_3 = arg_28_0.rtView

	var_28_1(var_5.Find(var_28_3, "content"), not var_28_2)

	setActive = var_28_1

	local var_28_4 = arg_28_0.rtContent

	var_28_1(var_5.Find(var_28_4, "scrollbar"), not var_28_2)

	setActive = var_28_1

	local var_28_5 = arg_28_0.rtView

	var_28_1(var_5.Find(var_28_5, "tip"), var_28_2)

	setActive = var_28_1

	var_28_1(arg_28_0.btnConfirm, not var_28_2)

	setActive = var_28_1

	var_28_1(arg_28_0.btnMove, var_28_2)

	if var_28_2 then
		local var_28_6 = var_28_0:GetInventoryProxy()

		var_28_1 = var_28_1.GetItemCount
		WorldConst = var_6

		if var_28_1(var_28_6, var_6.SwitchPlainingItemId) > 0 then
			setText = var_28_1

			local var_28_7 = arg_28_0.rtView
			local var_28_8 = var_5.Find(var_28_7, "tip/Text")

			i18n = var_28_7

			var_28_1(var_28_8, var_28_7("world_automode_treasure_2"))
		else
			setText = var_28_1

			local var_28_9 = arg_28_0.rtView
			local var_28_10 = var_5.Find(var_28_9, "tip/Text")

			i18n = var_28_9

			var_28_1(var_28_10, var_28_9("world_automode_treasure_1"))
		end
	end

	eachChild = var_28_1

	local var_28_11 = arg_28_0.rtView

	var_28_1(var_5.Find(var_28_11, "content"), function(arg_29_0)
		setActive = var_2_10001

		var_2_10001(arg_29_0, var_0_1.modeToggleDic[arg_28_1][arg_29_0.name])

		if var_0_1.modeToggleDic[arg_28_1] then
			switch = var_1

			var_1(arg_29_0.name, {
				base = function()
					local var_30_0 = {}

					ipairs = var_3_10001

					local var_30_1 = var_0_1.paresingToggleString

					PlayerPrefs = var_3_10003

					for iter_30_0, iter_30_1 in var_3_10001(var_30_1(var_3_10003.GetString("auto_switch_difficult_base", "all"))) do
						var_30_0[iter_30_1] = true
					end

					eachChild = var_1

					local var_30_2 = arg_28_0.rtView

					var_1(var_2.Find(var_30_2, "content/base/toggles"), function(arg_31_0)
						triggerToggle = var_4_10001

						var_4_10001(arg_31_0, var_30_0[arg_31_0.name])

						return
					end)

					return
				end,
				treasure = function()
					local var_32_0 = {}

					ipairs = var_3_10001

					local var_32_1 = var_0_1.paresingToggleString

					PlayerPrefs = var_3_10003

					for iter_32_0, iter_32_1 in var_3_10001(var_32_1(var_3_10003.GetString("auto_switch_difficult_treasure", "all"))) do
						var_32_0[iter_32_1] = true
					end

					eachChild = var_1

					local var_32_2 = arg_28_0.rtView

					var_1(var_2.Find(var_32_2, "content/treasure/toggles"), function(arg_33_0)
						triggerToggle = var_4_10001

						var_4_10001(arg_33_0, var_32_0[arg_33_0.name])

						return
					end)

					return
				end
			}, function()
				local var_34_0 = arg_28_0

				var_0.initToggle(var_34_0, arg_29_0.name)

				return
			end)
		end

		return
	end)

	return
end

function var_0_1.saveConfig(arg_35_0, arg_35_1)
	local var_35_0 = {}

	eachChild = var_1_10003

	local var_35_1 = arg_35_0.rtView

	var_1_10003(var_4.Find(var_35_1, "content/" .. arg_35_1 .. "/toggles"), function(arg_36_0)
		GetComponent = var_2_10001

		local var_36_0 = arg_36_0

		typeof = var_2_10003
		Toggle = var_2_10004

		if var_2_10001(var_36_0, var_2_10003(var_2_10004)).isOn then
			table = var_1

			var_1.insert(var_35_0, arg_36_0.name)
		end

		return
	end)

	PlayerPrefs = var_1_10003

	local var_35_2 = var_1_10003.SetString
	local var_35_3 = "auto_switch_difficult_" .. arg_35_1

	table = var_5

	var_35_2(var_35_3, var_5.concat(var_35_0, "&"))

	PlayerPrefs = var_35_2

	var_35_2.Save()

	return
end

function var_0_1.paresingToggleString(arg_37_0)
	if not arg_37_0 or arg_37_0 == "" then
		return {}
	end

	string = var_1_10001

	return var_1_10001.split(arg_37_0, "&")
end

function var_0_1.checkDifficultValid(arg_38_0, arg_38_1)
	local var_38_0 = var_0_1.paresingToggleString(arg_38_0)

	ipairs = var_3

	for iter_38_0, iter_38_1 in var_3(var_38_0) do
		if iter_38_1 == "all" then
			return true
		else
			string = var_1_10008

			if var_1_10008.sub(iter_38_1, 1, 6) == "until_" then
				tonumber = var_1_10008
				string = var_9

				if arg_38_1 <= var_1_10008(var_9.sub(iter_38_1, 7)) then
					return true
				end
			else
				tonumber = var_1_10008

				if arg_38_1 == var_1_10008(iter_38_1) then
					return true
				end
			end
		end
	end

	return false
end

return var_0_1
