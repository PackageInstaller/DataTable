class = var_0_10000

local var_0_0 = "BossRushFleetSelectView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

var_0_1.fleetNames = {
	vanguard = 1,
	submarine = 3,
	main = 2
}

function var_0_1.GetTextColor(arg_1_0)
	Color = var_1_10001

	local var_1_0 = var_1_10001.white

	Color = var_1_10002

	local var_1_1 = var_1_10002.New(1, 1, 1, 0.5)
end

function var_0_1.getUIName(arg_2_0)
	return "BossRushFleetSelectUI"
end

function var_0_1.init(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)
	arg_3_0:InitUI()

	return
end

function var_0_1.InitUI(arg_4_0)
	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "Panel")
	local var_4_2 = {}

	FleetType = var_4_0

	local var_4_3 = var_4_0.Normal
	local var_4_4 = arg_4_0._tf

	var_4_2[var_4_3] = var_4.Find(var_4_4, "Panel/Fleet/Normal")
	FleetType = var_4_3

	local var_4_5 = var_4_3.Submarine
	local var_4_6 = arg_4_0._tf

	var_4_2[var_4_5] = var_4.Find(var_4_6, "Panel/Fleet/Submarine")
	arg_4_0.tfFleets = var_4_2
	arg_4_0.btnRecommend = var_4_1:Find("Fleet/BtnRecommend")
	arg_4_0.btnClear = var_4_1:Find("Fleet/BtnClear")
	arg_4_0.rtCostLimit = var_4_1:Find("Fleet/CostLimit")
	arg_4_0.commanderList = var_4_1:Find("Fleet/Commander")
	arg_4_0.modeToggles = {
		var_4_1:Find("Info/Modes/Single"),
		var_4_1:Find("Info/Modes/Multiple")
	}

	local var_4_7 = arg_4_0._tf

	arg_4_0.extraAwardTF = var_2.Find(var_4_7, "Panel/Reward/Normal/Mode")

	local var_4_8 = arg_4_0._tf

	arg_4_0.sonarRangeContainer = var_2.Find(var_4_8, "Panel/Fleet/SonarRange")

	local var_4_9 = {}
	local var_4_10 = arg_4_0._tf
	local var_4_11 = var_3.Find(var_4_10, "Panel/Fleet/SonarRange/Values")

	var_4_9[1] = var_3.GetChild(var_4_11, 0)

	local var_4_12 = arg_4_0._tf
	local var_4_13 = var_3.Find(var_4_12, "Panel/Fleet/SonarRange/Values")

	var_4_9[2] = var_3.GetChild(var_4_13, 1)
	arg_4_0.sonarRangeTexts = var_4_9
	setText = var_4_9

	var_4_9(arg_4_0.sonarRangeTexts[2], "")

	arg_4_0.btnBack = var_4_1:Find("Info/Title/BtnClose")
	arg_4_0.btnGo = var_4_1:Find("Info/Start")
	setText = var_2

	local var_4_14 = arg_4_0._tf
	local var_4_15 = var_4.Find(var_4_14, "Panel/Fleet/SonarRange/Text")

	i18n = var_5

	var_2(var_4_15, var_5("fleet_antisub_range") .. ":")

	setText = var_2

	local var_4_16 = arg_4_0._tf
	local var_4_17 = var_4.Find(var_4_16, "Panel/Fleet/CostLimit/Title")

	i18n = var_5

	var_2(var_4_17, var_5("formationScene_use_oil_limit_tip_worldboss"))

	setText = var_2

	local var_4_18 = arg_4_0._tf
	local var_4_19 = var_4.Find(var_4_18, "Panel/Reward/Normal/Base/Text")

	i18n = var_5

	var_2(var_4_19, var_5("series_enemy_reward_tip1"))

	setText = var_2

	local var_4_20 = arg_4_0._tf
	local var_4_21 = var_4.Find(var_4_20, "Panel/Reward/Normal/Mode/Text")

	i18n = var_5

	var_2(var_4_21, var_5("series_enemy_reward_tip2"))

	setText = var_2

	local var_4_22 = arg_4_0._tf
	local var_4_23 = var_4.Find(var_4_22, "Panel/Reward/EX/Title")

	i18n = var_5

	var_2(var_4_23, var_5("series_enemy_reward_tip4"))

	setText = var_2

	local var_4_24 = arg_4_0._tf
	local var_4_25 = var_4.Find(var_4_24, "Panel/Reward/Tip")

	i18n = var_5

	var_2(var_4_25, var_5("limit_team_character_tips"))

	setText = var_2

	local var_4_26 = arg_4_0._tf
	local var_4_27 = var_4.Find(var_4_26, "Panel/Info/Modes/Single/On/Text")

	i18n = var_5

	var_2(var_4_27, var_5("series_enemy_mode_1"))

	setText = var_2

	local var_4_28 = arg_4_0._tf
	local var_4_29 = var_4.Find(var_4_28, "Panel/Info/Modes/Single/Off/Text")

	i18n = var_5

	var_2(var_4_29, var_5("series_enemy_mode_1"))

	setText = var_2

	local var_4_30 = arg_4_0._tf
	local var_4_31 = var_4.Find(var_4_30, "Panel/Info/Modes/Multiple/On/Text")

	i18n = var_5

	var_2(var_4_31, var_5("series_enemy_mode_2"))

	setText = var_2

	local var_4_32 = arg_4_0._tf
	local var_4_33 = var_4.Find(var_4_32, "Panel/Info/Modes/Multiple/Off/Text")

	i18n = var_5

	var_2(var_4_33, var_5("series_enemy_mode_2"))

	setText = var_2

	local var_4_34 = arg_4_0._tf
	local var_4_35 = var_4.Find(var_4_34, "Panel/Fleet/Normal/main/Item/Ship/EnergyWarn/Text")

	i18n = var_5

	var_2(var_4_35, var_5("series_enemy_mood"))

	setText = var_2

	local var_4_36 = arg_4_0._tf
	local var_4_37 = var_4.Find(var_4_36, "Panel/Fleet/Normal/vanguard/Item/Ship/EnergyWarn/Text")

	i18n = var_5

	var_2(var_4_37, var_5("series_enemy_mood"))

	setText = var_2

	local var_4_38 = arg_4_0._tf
	local var_4_39 = var_4.Find(var_4_38, "Panel/Fleet/Submarine/main/Item/Ship/EnergyWarn/Text")

	i18n = var_5

	var_2(var_4_39, var_5("series_enemy_mood"))

	return
end

function var_0_1.didEnter(arg_5_0)
	local var_5_0 = arg_5_0.contextData.seriesData

	onButton = var_1_10002

	local var_5_1 = arg_5_0
	local var_5_2 = arg_5_0.btnGo

	local function var_5_3()
		for iter_6_0 = 1, #arg_5_0.contextData.fleets - 1 do
			local var_6_0 = arg_5_0.contextData.fleets[iter_6_0]

			if var_4.isLegalToFight(var_6_0) ~= true then
				pg = var_2_10005

				local var_6_1 = var_2_10005.TipsMgr.GetInstance()

				var_2_10005 = var_2_10005.ShowTips
				i18n = var_2_10008

				var_2_10005(var_6_1, var_2_10008("series_enemy_team_notenough"))

				return
			end
		end

		_ = var_0

		if var_0.any(arg_5_0.contextData.fleets, function(arg_7_0)
			local var_7_0 = arg_7_0
			local var_7_1, var_7_2 = arg_7_0.HaveShipsInEvent(var_7_0)

			if var_7_1 then
				pg = var_7_0

				local var_7_3 = var_7_0.TipsMgr.GetInstance()

				var_3.ShowTips(var_7_3, var_7_2)

				return true
			end

			return
		end) then
			return
		end

		local var_6_2 = var_5_0
		local var_6_3 = var_0.GetType(var_6_2)

		BossRushSeriesData = var_1

		local var_6_4 = var_6_3 == var_1.TYPE.SP
		local var_6_5 = true

		if var_6_4 then
			getProxy = var_3
			ActivityProxy = var_2_10005

			local var_6_6 = var_3(var_2_10005)

			var_2_10006 = var_3.getActivityById(var_6_6, var_5_0.actId)

			local var_6_7 = var_3.GetActiveSeriesIds(var_2_10006)

			table = var_6_6

			local var_6_8 = var_6_6.getIndex(var_6_7, function(arg_8_0)
				return arg_8_0 == var_5_0.id
			end)

			if not var_3:GetUsedBonus()[var_6_8] then
				var_2_10006 = 0
			end

			local var_6_9 = var_5_0

			if not (var_7.GetMaxBonusCount(var_6_9) - var_2_10006 > 0) then
				pg = var_8

				local var_6_10 = var_8.TipsMgr.GetInstance()
				local var_6_11 = var_8.ShowTips

				i18n = var_2_10011

				var_6_11(var_6_10, var_2_10011("series_enemy_SP_error"))

				return
			end
		end

		local var_6_12 = arg_5_0
		local var_6_13 = var_3.emit

		BossRushFleetSelectMediator = var_2_10006

		var_6_13(var_6_12, var_2_10006.ON_PRECOMBAT)

		return
	end

	SFX_UI_WEIGHANCHOR_GO = var_1_10007

	var_1_10002(var_5_1, var_5_2, var_5_3, var_1_10007)

	onButton = var_1_10002

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.sonarRangeContainer

	local function var_5_6()
		pg = var_2_10000

		local var_9_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_9_1 = var_0.ShowMsgBox
		local var_9_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_9_2.type = var_2_10004
		pg = var_2_10004
		var_9_2.helps = var_2_10004.gametip.fleet_antisub_range_tip.tip

		var_9_1(var_9_0, var_9_2)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_5_4, var_5_5, var_5_6, var_1_10007)

	onButton = var_1_10002

	local var_5_7 = arg_5_0
	local var_5_8 = arg_5_0.btnBack

	local function var_5_9()
		local var_10_0 = arg_5_0

		var_0.onCancelHard(var_10_0)

		return
	end

	SFX_CANCEL = var_1_10007

	var_1_10002(var_5_7, var_5_8, var_5_9, var_1_10007)

	onButton = var_1_10002

	local var_5_10 = arg_5_0
	local var_5_11 = arg_5_0._tf
	local var_5_12 = var_5.Find(var_5_11, "BG")

	local function var_5_13()
		local var_11_0 = arg_5_0

		var_0.onCancelHard(var_11_0)

		return
	end

	SFX_CANCEL = var_5_11

	var_1_10002(var_5_10, var_5_12, var_5_13, var_5_11)

	local var_5_14 = var_5_0:IsSingleFight()

	setActive = var_1_10003

	var_1_10003(arg_5_0.modeToggles[1].parent, var_5_14)

	if var_5_14 then
		table = var_1_10003

		var_1_10003.Foreach(arg_5_0.modeToggles, function(arg_12_0, arg_12_1)
			triggerToggle = var_2_10002

			var_2_10002(arg_12_1, arg_12_0 == arg_5_0.contextData.mode)

			return
		end)

		table = var_3

		var_3.Foreach(arg_5_0.modeToggles, function(arg_13_0, arg_13_1)
			onToggle = var_2_10002

			local var_13_0 = arg_5_0
			local var_13_1 = arg_13_1

			local function var_13_2(arg_14_0)
				if not arg_14_0 then
					return
				end

				local var_14_0 = arg_5_0
				local var_14_1 = var_1.emit

				BossRushFleetSelectMediator = var_3_10004

				var_14_1(var_14_0, var_3_10004.ON_SWITCH_MODE, arg_13_0)

				local var_14_2 = arg_5_0

				var_1.updateToggles(var_14_2)

				triggerToggle = var_1

				var_1(arg_5_0.fleetIndexToggles[arg_5_0.contextData.fleetIndex], true)

				return
			end

			SFX_PANEL = var_2_10007

			var_2_10002(var_13_0, var_13_1, var_13_2, var_2_10007)

			return
		end)
	end

	local var_5_15 = arg_5_0._tf
	local var_5_16 = var_3.Find(var_5_15, "Panel/Fleet/Indexes").childCount

	UIItemList = var_5_15

	var_5_15.StaticAlign(var_3, var_3:GetChild(0), var_5_16, function(arg_15_0, arg_15_1, arg_15_2)
		arg_15_1 = arg_15_1 + 1
		UIItemList = var_2_10003

		if arg_15_0 == var_2_10003.EventUpdate then
			if arg_15_1 < var_5_16 then
				setText = var_3

				local var_15_0 = arg_15_2:Find("Text")

				i18n = var_2_10006
				var_2_10008 = "series_enemy_fleet_prefix"
				GetRomanDigit = var_2_10009

				var_3(var_15_0, var_2_10006(var_2_10008, var_2_10009(arg_15_1)))
			else
				setText = var_3

				local var_15_1 = arg_15_2:Find("Text")

				i18n = var_2_10006

				var_3(var_15_1, var_2_10006("formationScene_use_oil_limit_submarine"))
			end

			onToggle = var_3

			local var_15_2 = arg_5_0
			local var_15_3 = arg_15_2

			local function var_15_4(arg_16_0)
				setActive = var_3_10001

				local var_16_0 = arg_15_2

				var_3_10001(var_3.Find(var_16_0, "Selected"), arg_16_0)

				local var_16_1 = arg_5_0
				local var_16_2, var_16_3 = var_1.GetTextColor(var_16_1)

				setTextColor = var_16_1

				local var_16_4 = arg_15_2

				var_16_1(var_5.Find(var_16_4, "Text"), arg_16_0 and var_16_2 or var_16_3)

				if arg_16_0 then
					local var_16_5 = arg_5_0.contextData.fleets
					local var_16_6 = arg_5_0.contextData
					local var_16_7

					if not var_16_5[arg_15_1] or not arg_15_1 then
						var_16_7 = #var_16_5
					end

					var_16_6.fleetIndex = var_16_7

					local var_16_8 = arg_5_0

					var_4.updateEliteFleets(var_16_8)
				end

				return
			end

			SFX_PANEL = var_2_10008

			var_3(var_15_2, var_15_3, var_15_4, var_2_10008)
		end

		return
	end)

	setText = var_5

	local var_5_17 = arg_5_0._tf

	var_5(var_7.Find(var_5_17, "Panel/Info/Title/Text"), var_5_0:GetName())

	setText = var_5

	local var_5_18 = arg_5_0._tf

	var_5(var_7.Find(var_5_18, "Panel/Info/Title/Text/EN"), var_5_0:GetSeriesCode())

	setText = var_5

	local var_5_19 = arg_5_0._tf

	var_5(var_7.Find(var_5_19, "Panel/Info/Description/Text"), var_5_0:GetDescription())

	local var_5_20 = var_5_0:GetExpeditionIds()
	local var_5_21 = var_5_0
	local var_5_22 = var_5_0.GetBossIcons(var_5_21)
	local var_5_23 = arg_5_0._tf
	local var_5_24 = var_7.Find(var_5_23, "Panel/Info/Boss")

	UIItemList = var_5_21

	var_5_21.StaticAlign(var_5_24, var_5_24:GetChild(0), #var_5_20, function(arg_17_0, arg_17_1, arg_17_2)
		UIItemList = var_2_10003

		if arg_17_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_17_0 = var_5_20[arg_17_1 + 1]
		local var_17_1 = var_5_22[arg_17_1 + 1][1]

		pg = var_5

		local var_17_2 = var_5.expedition_data_template[var_17_0].level
		local var_17_3 = arg_17_2
		local var_17_4 = arg_17_2.Find(var_17_3, "shiptpl")

		findTF = var_2_10008

		local var_17_5 = var_2_10008(var_17_4, "icon_bg")

		findTF = var_17_3

		local var_17_6 = var_17_3(var_17_4, "icon_bg/frame")

		SetCompomentEnabled = var_10

		var_10(var_17_5, "Image", false)

		SetCompomentEnabled = var_10

		var_10(var_17_6, "Image", false)

		setActive = var_10

		var_10(arg_17_2:Find("shiptpl/icon_bg/lv"), false)

		local var_17_7 = arg_17_2
		local var_17_8 = arg_17_2.Find(var_17_7, "shiptpl/icon_bg/icon")

		GetImageSpriteFromAtlasAsync = var_11

		var_11("SquareIcon/" .. var_17_1, "", var_17_8)

		findTF = var_11

		if var_11(var_17_4, "ship_type") then
			setActive = var_17_7

			var_17_7(var_11, true)

			setImageSprite = var_17_7

			local var_17_9 = var_11

			GetSpriteFromAtlas = var_15

			local var_17_10 = "shiptype"

			shipType2print = var_2_10018

			var_17_7(var_17_9, var_15(var_17_10, var_2_10018(var_5_22[arg_17_1 + 1][2])))
		end

		return
	end)

	local function var_5_25(arg_18_0)
		type = var_2_10001

		if var_2_10001(arg_18_0) ~= "table" then
			return {}
		end

		return arg_18_0
	end

	local var_5_26 = var_5_0:GetType()

	BossRushSeriesData = var_10

	local var_5_27 = var_5_26 == var_10.TYPE.EXTRA

	setActive = var_5_31

	local var_5_28 = arg_5_0._tf

	var_5_31(var_12.Find(var_5_28, "Panel/Reward/Normal"), not var_5_27)

	setActive = var_5_31

	local var_5_29 = arg_5_0._tf

	var_5_31(var_12.Find(var_5_29, "Panel/Reward/EX"), var_5_27)

	local var_5_30, var_5_31, var_5_34

	if not var_5_27 then
		var_5_30 = arg_5_0._tf
		var_5_31 = var_5_31.Find(var_5_30, "Panel/Reward/Normal/Base/Items")

		local var_5_32 = var_5_25(var_5_0:GetPassAwards())

		UIItemList = var_5_30

		var_5_30.StaticAlign(var_5_31, var_5_31:GetChild(0), #var_5_32, function(arg_19_0, arg_19_1, arg_19_2)
			UIItemList = var_2_10003

			if arg_19_0 ~= var_2_10003.EventUpdate then
				return
			end

			local var_19_0 = var_5_32[arg_19_1 + 1]

			Drop = var_4

			local var_19_1 = var_4.Create(var_19_0)

			updateDrop = var_2_10005

			var_2_10005(arg_19_2, var_19_1)

			onButton = var_2_10005

			local var_19_2 = arg_5_0
			local var_19_3 = arg_19_2

			local function var_19_4()
				local var_20_0 = arg_5_0

				var_0.ShowDropDetail(var_20_0, var_19_1)

				return
			end

			SFX_PANEL = var_2_10010

			var_2_10005(var_19_2, var_19_3, var_19_4, var_2_10010)

			return
		end)

		local var_5_33 = arg_5_0.extraAwardTF

		var_5_30 = var_5_30.Find(var_5_33, "Items")
		var_5_34 = var_5_25(var_5_0:GetAdditionalAwards())
		UIItemList = var_5_33

		var_5_33.StaticAlign(var_5_30, var_5_30:GetChild(0), #var_5_34, function(arg_21_0, arg_21_1, arg_21_2)
			UIItemList = var_2_10003

			if arg_21_0 ~= var_2_10003.EventUpdate then
				return
			end

			local var_21_0 = var_5_34[arg_21_1 + 1]

			Drop = var_4

			local var_21_1 = var_4.Create(var_21_0)

			updateDrop = var_2_10005

			var_2_10005(arg_21_2, var_21_1)

			onButton = var_2_10005

			local var_21_2 = arg_5_0
			local var_21_3 = arg_21_2

			local function var_21_4()
				local var_22_0 = arg_5_0

				var_0.ShowDropDetail(var_22_0, var_21_1)

				return
			end

			SFX_PANEL = var_2_10010

			var_2_10005(var_21_2, var_21_3, var_21_4, var_2_10010)

			return
		end)
	else
		getProxy = var_5_31
		ActivityProxy = var_5_30

		local var_5_35 = var_5_31(var_5_30)
		local var_5_36 = var_10.getActivityByType

		ActivityConst = var_5_34

		local var_5_37 = var_5_36(var_5_35, var_5_34.ACTIVITY_TYPE_EXTRA_BOSSRUSH_RANK)
		local var_5_38 = var_10.GetScore(var_5_37)
		local var_5_39 = arg_5_0._tf
		local var_5_40

		var_5_40, setText = var_12.Find(var_5_39, "Panel/Reward/EX/Title/Text"), var_5_37
		math = var_1_10016

		var_5_37(var_5_40, var_1_10016.floor(var_5_38))
	end

	arg_5_0:updateToggles()

	triggerToggle = var_10

	var_10(arg_5_0.fleetIndexToggles[arg_5_0.contextData.fleetIndex], true)

	return
end

local var_0_2 = {
	[99] = true
}

function var_0_1.ShowDropDetail(arg_23_0, arg_23_1)
	Item = var_1_10002

	if var_1_10002.getConfigData(arg_23_1.id) and var_0_2[var_2.type] then
		local var_23_0 = var_2.display_icon
		local var_23_1 = {}

		ipairs = var_1_10005

		for iter_23_0, iter_23_1 in var_1_10005(var_23_0) do
			local var_23_2 = iter_23_1[1]
			local var_23_3 = iter_23_1[2]

			var_23_1[#var_23_1 + 1] = {
				hideName = true,
				type = var_23_2,
				id = var_23_3
			}
		end

		arg_23_0:emit(var_0_1.ON_DROP_LIST, {
			item2Row = true,
			itemList = var_23_1,
			content = var_2.display
		})
	else
		arg_23_0:emit(var_0_1.ON_DROP, arg_23_1)
	end

	return
end

function var_0_1.willExit(arg_24_0)
	pg = var_1_10001

	local var_24_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_24_0, arg_24_0._tf)

	return
end

function var_0_1.onCancelHard(arg_25_0)
	local var_25_0 = arg_25_0
	local var_25_1 = arg_25_0.emit

	BossRushFleetSelectMediator = var_1_10004

	var_25_1(var_25_0, var_1_10004.ON_UPDATE_CUSTOM_FLEET)
	arg_25_0:closeView()

	return
end

function var_0_1.onBackPressed(arg_26_0)
	arg_26_0:onCancelHard()
	var_0_1.super.onBackPressed(arg_26_0)

	return
end

function var_0_1.setHardShipVOs(arg_27_0, arg_27_1)
	arg_27_0.shipVOs = arg_27_1

	return
end

function var_0_1.initAddButton(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = arg_28_0.contextData.fleets[arg_28_3]
	local var_28_1 = var_4.getShipIds(var_28_0)
	local var_28_2 = {}
	local var_28_3 = {}

	ipairs = var_1_10008

	for iter_28_0, iter_28_1 in var_1_10008(var_28_1) do
		var_28_2[arg_28_0.shipVOs[iter_28_1]] = true

		local var_28_4 = arg_28_0.shipVOs[iter_28_1]

		if arg_28_2 == var_13.getTeamType(var_28_4) then
			table = var_13

			var_13.insert(var_28_3, iter_28_1)
		end
	end

	_ = var_8

	local var_28_5 = var_8.map(var_28_1, function(arg_29_0)
		return arg_28_0.shipVOs[arg_29_0]
	end)

	table = var_9

	var_9.sort(var_28_5, function(arg_30_0, arg_30_1)
		if not (var_0_1.fleetNames[arg_30_0:getTeamType()] < var_0_1.fleetNames[arg_30_1:getTeamType()]) then
			if var_0_1.fleetNames[arg_30_0:getTeamType()] == var_0_1.fleetNames[arg_30_1:getTeamType()] then
				table = var_2

				local var_30_0 = var_2.indexof(var_28_1, arg_30_0.id)

				table = var_3

				local var_30_1

				if not (var_30_0 < var_3.indexof(var_28_1, arg_30_1.id)) then
					var_30_1 = false

					goto label_30_0
				end

				var_30_1 = true

				::label_30_0::

				return var_30_1
			end
		end
	end)

	local var_28_6 = arg_28_1:GetComponent("ContentSizeFitter")
	local var_28_7 = arg_28_1:GetComponent("HorizontalLayoutGroup")

	var_28_6.enabled = true
	var_28_7.enabled = true
	arg_28_0.isDraging = false
	UIItemList = var_11

	var_11.StaticAlign(arg_28_1, arg_28_1:GetChild(0), 3, function(arg_31_0, arg_31_1, arg_31_2)
		UIItemList = var_2_10003

		if arg_31_0 ~= var_2_10003.EventUpdate then
			return
		end

		arg_31_1 = arg_31_1 + 1

		local var_31_0

		if not var_28_3[arg_31_1] or not arg_28_0.shipVOs[var_28_3[arg_31_1]] then
			var_31_0 = nil
		end

		setActive = var_2_10004

		var_2_10004(arg_31_2:Find("Ship"), var_31_0)

		setActive = var_2_10004

		var_2_10004(arg_31_2:Find("Empty"), not var_31_0)

		local var_31_1

		if not var_31_0 or not arg_31_2:Find("Ship") then
			var_31_1 = arg_31_2:Find("Empty")
		end

		if var_31_0 then
			updateShip = var_2_10005

			var_2_10005(var_31_1, var_31_0)

			setActive = var_2_10005

			local var_31_2 = var_31_1
			local var_31_3 = var_31_1.Find(var_31_2, "EnergyWarn")
			local var_31_4 = arg_28_0.contextData.mode

			BossRushSeriesData = var_31_2

			if var_31_4 == var_31_2.MODE.SINGLE then
				local var_31_5 = var_31_0:getEnergy()

				pg = var_9

				local var_31_6

				if not (var_31_5 <= var_9.gameset.series_enemy_mood_limit.key_value) then
					var_31_6 = false
				else
					var_31_6 = true
				end

				var_2_10005(var_31_3, var_31_6)

				setActive = var_2_10005

				var_2_10005(var_31_1:Find("event_block"), var_31_0:getFlag("inEvent"))

				setActive = var_2_10005

				var_2_10005(var_31_1:Find("ship_type"), false)

				GetOrAddComponent = var_2_10005

				local var_31_7 = var_31_1

				typeof = var_8
				UILongPressTrigger = var_10

				local var_31_8 = var_2_10005(var_31_7, var_8(var_10)).onLongPressed

				var_6.RemoveAllListeners(var_31_8)

				if var_31_0 then
					local var_31_9 = var_5.onLongPressed

					var_6.AddListener(var_31_9, function()
						local var_32_0 = arg_28_0
						local var_32_1 = var_0.emit

						BossRushFleetSelectMediator = var_3_10003

						var_32_1(var_32_0, var_3_10003.ON_FLEET_SHIPINFO, {
							shipId = var_31_0.id,
							shipVOs = var_28_5
						})

						return
					end)
				end

				GetOrAddComponent = var_6

				local var_31_10 = var_6(var_31_1, "EventTriggerListener")

				var_6.RemovePointClickFunc(var_31_10)
				var_6:AddPointClickFunc(function(arg_33_0, arg_33_1)
					if arg_28_0.isDraging then
						return
					end

					local var_33_0 = arg_28_0
					local var_33_1 = var_2.emit

					BossRushFleetSelectMediator = var_3_10005

					var_33_1(var_33_0, var_3_10005.ON_OPEN_DECK, {
						fleet = var_28_2,
						chapter = arg_28_0.chapter,
						shipVO = var_31_0,
						fleetIndex = arg_28_3,
						teamType = arg_28_2
					})

					return
				end)
				var_6:RemoveBeginDragFunc()
				var_6:RemoveDragFunc()
				var_6:RemoveDragEndFunc()

				return
			end
		end
	end)

	return
end

function var_0_1.updateToggles(arg_34_0)
	local var_34_0 = #arg_34_0.contextData.fleets
	local var_34_1 = arg_34_0._tf
	local var_34_2 = var_2.Find(var_34_1, "Panel/Fleet/Indexes").childCount

	arg_34_0.fleetIndexToggles = {}
	eachChild = var_4

	var_4(var_2, function(arg_35_0, arg_35_1)
		arg_35_1 = arg_35_1 + 1
		setActive = var_2_10002

		var_2_10002(arg_35_0, arg_35_1 == var_34_2 or arg_35_1 < var_34_0)

		if arg_35_1 == var_34_2 then
			arg_34_0.fleetIndexToggles[var_34_0] = arg_35_0
		elseif arg_35_1 < var_34_0 then
			arg_34_0.fleetIndexToggles[arg_35_1] = arg_35_0
		end

		return
	end)

	return
end

function var_0_1.updateEliteFleets(arg_36_0)
	local var_36_0 = arg_36_0.contextData.seriesData
	local var_36_1 = arg_36_0.contextData.fleetIndex
	local var_36_2 = arg_36_0.contextData.fleets[var_36_1]
	local var_36_3 = var_36_1 == #arg_36_0.contextData.fleets

	setActive = var_1_10005

	local var_36_4 = arg_36_0._tf

	var_1_10005(var_7.Find(var_36_4, "Panel/Fleet/Normal"), not var_36_3)

	setActive = var_1_10005

	local var_36_5 = arg_36_0._tf

	var_1_10005(var_7.Find(var_36_5, "Panel/Fleet/Submarine"), var_36_3)

	local var_36_6 = arg_36_0.btnClear
	local var_36_7 = arg_36_0.btnRecommend
	local var_36_8 = arg_36_0.commanderList

	if not var_36_3 then
		local var_36_9 = arg_36_0.tfFleets

		FleetType = var_36_5

		local var_36_10 = var_36_9[var_36_5.Normal]

		setText = var_36_5
		var_1_10013 = var_36_10

		local var_36_11 = var_36_10.Find(var_1_10013, "bg/name")

		Fleet = var_1_10012

		var_36_5(var_36_11, var_1_10012.DEFAULT_NAME[var_36_1])

		local var_36_12 = arg_36_0

		var_36_5 = arg_36_0.initAddButton

		local var_36_13 = var_36_10
		local var_36_14 = var_36_10.Find

		TeamType = var_1_10015

		local var_36_15 = var_36_14(var_36_13, var_1_10015.Main)

		TeamType = var_1_10013

		var_36_5(var_36_12, var_36_15, var_1_10013.Main, var_36_1)

		local var_36_16 = arg_36_0

		var_36_5 = arg_36_0.initAddButton

		local var_36_17 = var_36_10
		local var_36_18 = var_36_10.Find

		TeamType = var_15

		local var_36_19 = var_36_18(var_36_17, var_15.Vanguard)

		TeamType = var_1_10013

		var_36_5(var_36_16, var_36_19, var_1_10013.Vanguard, var_36_1)
	else
		local var_36_20 = arg_36_0.tfFleets

		FleetType = var_36_5

		local var_36_21 = var_36_20[var_36_5.Submarine]
		local var_36_22 = #arg_36_0.contextData.fleets

		setText = var_10

		local var_36_23 = var_36_21
		local var_36_24 = var_36_21.Find(var_36_23, "bg/name")

		Fleet = var_1_10013

		local var_36_25 = var_1_10013.DEFAULT_NAME

		Fleet = var_36_23

		var_10(var_36_24, var_36_25[var_36_23.SUBMARINE_FLEET_ID])

		local var_36_26 = arg_36_0
		local var_36_27 = arg_36_0.initAddButton
		local var_36_28 = var_36_21
		local var_36_29 = var_36_21.Find

		TeamType = var_1_10016

		local var_36_30 = var_36_29(var_36_28, var_1_10016.Main)

		TeamType = var_14

		var_36_27(var_36_26, var_36_30, var_14.Submarine, var_36_22)
	end

	arg_36_0:initCommander(var_36_2, var_36_8)

	setText = var_8

	local var_36_31 = arg_36_0.sonarRangeTexts[1]

	math = var_11

	var_8(var_36_31, var_11.floor(var_36_2:GetFleetSonarRange()))

	local var_36_32 = var_36_2
	local var_36_33 = #var_36_2.GetRawShipIds(var_36_32) == (var_36_3 and 3 or 6)

	onButton = var_36_32

	var_36_32(arg_36_0, var_36_6, function()
		if var_0 == 0 then
			return
		end

		pg = var_0

		local var_37_0 = var_0.MsgboxMgr.GetInstance()
		local var_37_1 = var_0.ShowMsgBox
		local var_37_2 = {}

		i18n = var_2_10004
		var_37_2.content = var_2_10004("battle_preCombatLayer_clear_confirm")

		function var_37_2.onYes()
			local var_38_0 = arg_36_0
			local var_38_1 = var_0.emit

			BossRushFleetSelectMediator = var_3_10003

			var_38_1(var_38_0, var_3_10003.ON_ELITE_CLEAR, {
				index = var_36_1
			})

			return
		end

		var_37_1(var_37_0, var_37_2)

		return
	end)

	onButton = var_36_32

	var_36_32(arg_36_0, var_36_7, function()
		if var_36_33 then
			return
		end

		seriesAsync = var_0

		var_0({
			function(arg_40_0)
				if var_0 == 0 then
					return arg_40_0()
				end

				pg = var_1

				local var_40_0 = var_1.MsgboxMgr.GetInstance()
				local var_40_1 = var_1.ShowMsgBox
				local var_40_2 = {}

				i18n = var_3_10005
				var_40_2.content = var_3_10005("battle_preCombatLayer_auto_confirm")
				var_40_2.onYes = arg_40_0

				var_40_1(var_40_0, var_40_2)

				return
			end,
			function(arg_41_0)
				local var_41_0 = arg_36_0
				local var_41_1 = var_1.emit

				BossRushFleetSelectMediator = var_3_10004

				var_41_1(var_41_0, var_3_10004.ON_ELITE_RECOMMEND, {
					index = var_36_1
				})

				return
			end
		})

		return
	end)

	local var_36_34 = var_36_0:GetOilLimit()

	setActive = var_11

	local var_36_35 = arg_36_0.rtCostLimit

	_ = var_14

	var_11(var_36_35, var_14.any(var_36_34, function(arg_42_0)
		return arg_42_0 > 0
	end))

	local var_36_38

	if #var_36_34 > 0 then
		local var_36_36 = var_36_3 and "formationScene_use_oil_limit_submarine" or "formationScene_use_oil_limit_surface"
		local var_36_37

		if not var_36_3 or not var_36_34[2] then
			var_36_37 = var_36_34[1]
		end

		setText = var_36_35
		var_36_38 = arg_36_0.rtCostLimit

		local var_36_39 = var_15.Find(var_36_38, "Text")

		string = var_16

		local var_36_40 = var_16.format
		local var_36_41 = "%s(%d)"

		i18n = var_1_10019

		var_36_35(var_36_39, var_36_40(var_36_41, var_1_10019(var_36_36), var_36_37))
	end

	local var_36_42 = (function(arg_43_0)
		type = var_2_10001

		if var_2_10001(arg_43_0) ~= "table" then
			return {}
		end

		return arg_43_0
	end)(var_36_0:GetAdditionalAwards())

	setActive = var_36_35

	local var_36_43 = arg_36_0.extraAwardTF
	local var_36_44 = arg_36_0.contextData.mode

	BossRushSeriesData = var_36_38

	var_36_35(var_36_43, var_36_44 == var_36_38.MODE.MULTIPLE and #var_36_42 > 0)

	local var_36_45 = var_36_0
	local var_36_46 = var_36_0.GetExpeditionIds(var_36_45)
	local var_36_47 = arg_36_0._tf
	local var_36_48 = var_14.Find(var_36_47, "Panel/Info/Boss")

	UIItemList = var_36_45

	var_36_45.StaticAlign(var_36_48, var_36_48:GetChild(0), #var_36_46, function(arg_44_0, arg_44_1, arg_44_2)
		UIItemList = var_2_10003

		if arg_44_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_44_2

		if arg_44_1 + 1 ~= var_36_1 then
			local var_44_0 = var_36_1

			if not (#var_36_46 < var_44_0) then
				local var_44_1 = arg_36_0.contextData.mode

				BossRushSeriesData = var_4

				if var_44_1 ~= var_4.MODE.SINGLE then
					var_44_2 = false

					goto label_44_0
				end
			end
		end

		var_44_2 = true

		::label_44_0::

		setActive = var_4

		var_4(arg_44_2:Find("Select"), var_44_2)

		setActive = var_4

		var_4(arg_44_2:Find("Image"), var_44_2)

		return
	end)

	return
end

function var_0_1.initCommander(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = arg_45_1:GetRawCommanderIds()

	for iter_45_0 = 1, 2 do
		local var_45_1 = var_45_0[iter_45_0]
		local var_45_2

		if var_45_1 then
			getProxy = var_1_10010
			CommanderProxy = var_1_10012
			var_1_10012 = var_1_10010(var_1_10012)
			var_45_2 = var_1_10010.getCommanderById(var_1_10012, var_45_1)
		end

		var_1_10012 = arg_45_2

		local var_45_3 = arg_45_2.Find(var_1_10012, iter_45_0)
		local var_45_4 = var_1_10010.Find(var_45_3, "add")
		local var_45_5 = var_1_10010

		var_1_10012 = var_1_10010.Find(var_45_5, "info")
		setActive = var_45_3

		var_45_3(var_45_4, not var_45_2)

		setActive = var_45_3

		var_45_3(var_1_10012, var_45_2)

		if var_45_2 then
			Commander = var_45_3
			var_45_3 = var_45_3.rarity2Frame

			local var_45_6 = var_45_2

			var_45_3 = var_45_3(var_45_2.getRarity(var_45_6))
			setImageSprite = var_45_5
			var_1_10018 = var_1_10012

			local var_45_7 = var_1_10012.Find(var_1_10018, "frame")

			GetSpriteFromAtlas = var_45_6

			var_45_5(var_45_7, var_45_6("weaponframes", "commander_" .. var_45_3))

			GetImageSpriteFromAtlasAsync = var_45_5

			var_45_5("CommanderHrz/" .. var_45_2:getPainting(), "", var_1_10012:Find("mask/icon"))
		end

		onButton = var_45_3

		local var_45_8 = arg_45_0
		local var_45_9 = var_45_4

		local function var_45_10()
			local var_46_0 = arg_45_0
			local var_46_1 = var_0.emit

			BossRushFleetSelectMediator = var_2_10003

			var_46_1(var_46_0, var_2_10003.OPEN_COMMANDER_PANEL, arg_45_1)

			return
		end

		SFX_PANEL = var_1_10018

		var_45_3(var_45_8, var_45_9, var_45_10, var_1_10018)

		onButton = var_45_3

		local var_45_11 = arg_45_0
		local var_45_12 = var_1_10012

		local function var_45_13()
			local var_47_0 = arg_45_0
			local var_47_1 = var_0.emit

			BossRushFleetSelectMediator = var_2_10003

			var_47_1(var_47_0, var_2_10003.OPEN_COMMANDER_PANEL, arg_45_1)

			return
		end

		SFX_PANEL = var_1_10018

		var_45_3(var_45_11, var_45_12, var_45_13, var_1_10018)
	end

	return
end

return var_0_1
