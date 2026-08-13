class = var_0_10000

local var_0_0 = "GuildMissionBossFormationPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".GuildEventBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "GuildBossFormationPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "frame/close")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "frame/bottom/target/scrollrect/Text")
	local var_2_3 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.descTxt = var_2_3(var_2_2, var_4(var_1_10006))
	UIItemList = var_1

	local var_2_4 = var_1.New
	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_3.Find(var_2_5, "frame/bottom/award/list")
	local var_2_7 = arg_2_0._tf

	arg_2_0.awardList = var_2_4(var_2_6, var_4.Find(var_2_7, "frame/bottom/award/list/item"))

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_1.Find(var_2_8, "frame/title")
	local var_2_10 = var_1.GetComponent

	typeof = var_4
	Text = var_2_7
	arg_2_0.titleTxt = var_2_10(var_2_9, var_4(var_2_7))

	local var_2_11 = arg_2_0._tf

	arg_2_0.goBtn = var_1.Find(var_2_11, "frame/bottom/go")

	local var_2_12 = arg_2_0.goBtn
	local var_2_13 = var_1.Find(var_2_12, "oil/Text")
	local var_2_14 = var_1.GetComponent

	typeof = var_4
	Text = var_2_7
	arg_2_0.consumeTxt = var_2_14(var_2_13, var_4(var_2_7))

	local var_2_15 = arg_2_0._tf

	arg_2_0.recomBtn = var_1.Find(var_2_15, "frame/recom")

	local var_2_16 = arg_2_0._tf

	arg_2_0.clearBtn = var_1.Find(var_2_16, "frame/clear")

	local var_2_17 = arg_2_0._tf

	arg_2_0.grids = var_1.Find(var_2_17, "frame/double")

	local var_2_18 = arg_2_0._tf

	arg_2_0.subGrids = var_1.Find(var_2_18, "frame/single")

	local var_2_19 = arg_2_0._tf

	arg_2_0.nextBtn = var_1.Find(var_2_19, "frame/next")

	local var_2_20 = arg_2_0._tf

	arg_2_0.prevBtn = var_1.Find(var_2_20, "frame/prev")

	local var_2_21 = arg_2_0._tf

	arg_2_0._autoToggle = var_1.Find(var_2_21, "frame/auto_toggle")

	local var_2_22 = arg_2_0._tf

	arg_2_0._autoSubToggle = var_1.Find(var_2_22, "frame/sub_toggle")
	GuildCommanderFormationPage = var_1

	local var_2_23 = var_1.New
	local var_2_24 = arg_2_0._tf

	arg_2_0.commanderPage = var_2_23(var_3.Find(var_2_24, "frame/commanders"), arg_2_0.event, arg_2_0.contextData)
	setText = var_1

	local var_2_25 = arg_2_0.goBtn
	local var_2_26 = var_3.Find(var_2_25, "oil/label")

	i18n = var_4

	var_1(var_2_26, var_4("text_consume"))

	local var_2_27 = arg_2_0._tf

	arg_2_0.flag = var_1.Find(var_2_27, "frame/double/1/flag")

	local var_2_28 = arg_2_0._tf

	arg_2_0.subFlag = var_1.Find(var_2_28, "frame/single/1/flag")
	arg_2_0.shipCards = {}

	return
end

function var_0_1.Show(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	var_0_1.super.Show(arg_3_0, arg_3_1, arg_3_2, arg_3_3)

	Input = var_4
	var_4.multiTouchEnabled = false

	return
end

function var_0_1.Hide(arg_4_0, arg_4_1)
	var_0_1.super.Hide(arg_4_0, arg_4_1)

	Input = var_2
	var_2.multiTouchEnabled = true

	return
end

function var_0_1.OnInit(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.nextBtn

	local function var_5_2()
		local var_6_0 = arg_5_0
		local var_6_1 = var_0.UpdateFleet

		GuildBossMission = var_2_10003

		var_6_1(var_6_0, var_2_10003.SUB_FLEET_ID)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10006)

	onButton = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.prevBtn

	local function var_5_5()
		local var_7_0 = arg_5_0
		local var_7_1 = var_0.UpdateFleet

		GuildBossMission = var_2_10003

		var_7_1(var_7_0, var_2_10003.MAIN_FLEET_ID)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_3, var_5_4, var_5_5, var_1_10006)

	onButton = var_1_10001

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.closeBtn

	local function var_5_8()
		if arg_5_0.contextData.editBossFleet then
			local var_8_0 = arg_5_0
			local var_8_1 = var_0.emit

			GuildEventMediator = var_2_10003

			var_8_1(var_8_0, var_2_10003.ON_SAVE_FORMATION, function()
				local var_9_0 = arg_5_0

				var_0.Hide(var_9_0)

				return
			end)
		else
			local var_8_2 = arg_5_0

			var_0.Hide(var_8_2)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_6, var_5_7, var_5_8, var_1_10006)

	onButton = var_1_10001

	local var_5_9 = arg_5_0
	local var_5_10 = arg_5_0.goBtn

	local function var_5_11()
		local var_10_0 = arg_5_0
		local var_10_1 = var_0.emit

		GuildEventMediator = var_2_10003

		var_10_1(var_10_0, var_2_10003.ON_UPDATE_BOSS_FLEET)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_9, var_5_10, var_5_11, var_1_10006)

	onButton = var_1_10001

	local var_5_12 = arg_5_0
	local var_5_13 = arg_5_0.recomBtn

	local function var_5_14()
		local var_11_0 = arg_5_0
		local var_11_1 = var_0.emit

		GuildEventMediator = var_2_10003

		var_11_1(var_11_0, var_2_10003.ON_RECOMM_BOSS_BATTLE_SHIPS, arg_5_0.fleet.id)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_12, var_5_13, var_5_14, var_1_10006)

	onButton = var_1_10001

	local var_5_15 = arg_5_0
	local var_5_16 = arg_5_0.clearBtn

	local function var_5_17()
		if not arg_5_0.contextData.editBossFleet then
			arg_5_0.contextData.editBossFleet = {}
		end

		local var_12_0

		if not arg_5_0.contextData.bossFormationIndex then
			GuildBossMission = var_12_0
			var_12_0 = var_12_0.MAIN_FLEET_ID
		end

		Clone = var_2_10001

		local var_12_1 = var_2_10001(arg_5_0.fleet)

		var_1.RemoveAll(var_12_1)

		arg_5_0.contextData.editBossFleet[var_12_0] = var_1

		local var_12_2 = arg_5_0

		var_2.UpdateFleet(var_12_2, var_12_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_15, var_5_16, var_5_17, var_1_10006)

	return
end

function var_0_1.UpdateMission(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.bossMission = arg_13_1

	if arg_13_2 then
		local var_13_0

		if not arg_13_0.contextData.bossFormationIndex then
			GuildBossMission = var_13_0
			var_13_0 = var_13_0.MAIN_FLEET_ID
		end

		arg_13_0:UpdateFleet(var_13_0)
	end

	return
end

function var_0_1.OnBossCommanderFormationChange(arg_14_0)
	local var_14_0 = arg_14_0.fleet.id

	arg_14_0.fleet = arg_14_0.contextData.editBossFleet[var_14_0]

	arg_14_0:UpdateCommanders(arg_14_0.fleet)

	return
end

function var_0_1.OnBossCommanderPrefabFormationChange(arg_15_0)
	arg_15_0:UpdateCommanders(arg_15_0.fleet)

	return
end

function var_0_1.OnShow(arg_16_0)
	arg_16_0.isOpenCommander = arg_16_0:CheckCommanderPanel()
	arg_16_0.guild = arg_16_0.guild

	arg_16_0:UpdateMission(arg_16_0.extraData.mission, true)

	local var_16_0 = arg_16_0

	arg_16_0.UpdateDesc(var_16_0)

	getProxy = var_1
	PlayerProxy = var_16_0

	local var_16_1 = var_1(var_16_0)
	local var_16_2 = var_1.getRawData(var_16_1)

	pg = var_1_10002

	if var_1_10002.guildset.use_oil.key_value <= var_16_2:getResource(2) then
		COLOR_GREEN = var_4

		if not var_4 then
			COLOR_RED = var_4
		end

		local var_16_3 = arg_16_0.consumeTxt

		string = var_6
		var_16_3.text = var_6.format("<color=%s>%d</color>/%d", var_4, var_3, var_2)
		ys = var_16_3

		local var_16_4 = var_16_3.Battle.BattleState.IsAutoBotActive

		SYSTEM_GUILD = var_1_10007
		arg_16_0.isOpenAuto = var_16_4(var_1_10007)
		AutoBotCommand = var_5

		local var_16_5 = var_5.GetAutoBotMark

		SYSTEM_GUILD = var_1_10007

		local var_16_6 = var_16_5(var_1_10007)
		local var_16_7 = arg_16_0

		arg_16_0.OnSwitch(var_16_7, arg_16_0._autoToggle, arg_16_0.isOpenAuto, function(arg_17_0)
			arg_16_0.isOpenAuto = arg_17_0

			local var_17_0 = arg_16_0

			var_1.UpdateSubToggle(var_17_0)

			PlayerPrefs = var_1

			var_1.SetInt("autoBotIsAcitve" .. var_16_6, arg_17_0 and 1 or 0)

			PlayerPrefs = var_1

			var_1.Save()

			return
		end)

		ys = var_6

		local var_16_8 = var_6.Battle.BattleState.IsAutoSubActive

		SYSTEM_GUILD = var_16_7

		local var_16_9 = var_16_8(var_16_7)

		AutoSubCommand = var_1_10007

		local var_16_10 = var_1_10007.GetAutoSubMark

		SYSTEM_GUILD = var_9

		local var_16_11 = var_16_10(var_9)

		arg_16_0:OnSwitch(arg_16_0._autoSubToggle, var_16_9, function(arg_18_0)
			PlayerPrefs = var_2_10001

			var_2_10001.SetInt("autoSubIsAcitve" .. var_16_11, arg_18_0 and 1 or 0)

			PlayerPrefs = var_1

			var_1.Save()

			return
		end)
		arg_16_0:UpdateSubToggle()

		return
	end
end

function var_0_1.GetFleet(arg_19_0, arg_19_1)
	local var_19_0

	if arg_19_0.contextData.editBossFleet then
		var_19_0 = arg_19_0.contextData.editBossFleet[arg_19_1]
	end

	if not var_19_0 then
		local var_19_1 = arg_19_0.bossMission

		var_19_0 = var_3.GetFleetByIndex(var_19_1, arg_19_1)
	end

	return var_19_0
end

function var_0_1.UpdateSubToggle(arg_20_0)
	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_0.GetFleet

	GuildBossMission = var_1_10004

	local var_20_2 = var_20_1(var_20_0, var_1_10004.SUB_FLEET_ID)
	local var_20_3 = arg_20_0
	local var_20_4 = arg_20_0.GetFleet

	GuildBossMission = var_1_10005

	local var_20_5 = var_20_4(var_20_3, var_1_10005.MAIN_FLEET_ID)
	local var_20_6 = var_2.IsLegal(var_20_5)

	setActive = var_20_3

	local var_20_7 = arg_20_0._autoSubToggle
	local var_20_8

	if arg_20_0.isOpenAuto then
		var_20_8 = var_20_6 and var_20_2 and var_20_2:ExistSubShip()
	end

	var_20_3(var_20_7, var_20_8)

	setActive = var_20_3

	local var_20_9 = arg_20_0._autoToggle

	AutoBotCommand = var_20_8

	local var_20_10

	if var_20_8.autoBotSatisfied() then
		var_20_10 = var_20_6
	end

	var_20_3(var_20_9, var_20_10)

	return
end

function var_0_1.OnSwitch(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_1:Find("on")
	local var_21_1 = arg_21_1
	local var_21_2 = arg_21_1.Find(var_21_1, "off")

	local function var_21_3(arg_22_0)
		setActive = var_2_10001

		var_2_10001(var_21_0, arg_22_0)

		setActive = var_2_10001

		var_2_10001(var_21_2, not arg_22_0)

		return
	end

	removeOnToggle = var_21_1

	var_21_1(arg_21_1)
	var_21_3(arg_21_2)

	triggerToggle = var_7

	var_7(arg_21_1, arg_21_2)

	onToggle = var_7

	local var_21_4 = arg_21_0
	local var_21_5 = arg_21_1

	local function var_21_6(arg_23_0)
		var_21_3(arg_23_0)
		arg_21_3(arg_23_0)

		return
	end

	SFX_PANEL = var_1_10012

	var_7(var_21_4, var_21_5, var_21_6, var_1_10012)

	return
end

function var_0_1.CheckCommanderPanel(arg_24_0)
	pg = var_1_10001

	local var_24_0 = var_1_10001.SystemOpenMgr.GetInstance()
	local var_24_1

	if var_1.isOpenSystem(var_24_0, arg_24_0.player.level, "CommanderCatMediator") then
		LOCK_COMMANDER = var_24_1
		var_24_1 = not var_24_1
	end

	return var_24_1
end

function var_0_1.UpdateDesc(arg_25_0)
	local var_25_0 = arg_25_0.bossMission
	local var_25_1 = arg_25_0.descTxt

	i18n = var_1_10003
	var_25_1.text = var_1_10003("guild_boss_fleet_desc")

	local var_25_2 = var_25_0:GetAwards()
	local var_25_3 = arg_25_0.awardList

	var_3.make(var_25_3, function(arg_26_0, arg_26_1, arg_26_2)
		UIItemList = var_2_10003

		if arg_26_0 == var_2_10003.EventUpdate then
			local var_26_0 = var_25_2[arg_26_1 + 1]
			local var_26_1 = {
				type = var_26_0[1],
				id = var_26_0[2],
				count = var_26_0[3]
			}

			updateDrop = var_5

			var_5(arg_26_2, var_26_1)

			onButton = var_5

			local var_26_2 = arg_25_0
			local var_26_3 = arg_26_2

			local function var_26_4()
				local var_27_0 = arg_25_0
				local var_27_1 = var_0.emit

				BaseUI = var_3_10003

				var_27_1(var_27_0, var_3_10003.ON_DROP, var_26_1)

				return
			end

			SFX_PANEL = var_2_10010

			var_5(var_26_2, var_26_3, var_26_4, var_2_10010)
		end

		return
	end)

	local var_25_4 = arg_25_0.awardList

	var_3.align(var_25_4, #var_25_2)

	arg_25_0.titleTxt.text = var_25_0:GetName()

	return
end

function var_0_1.UpdateFleet(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.bossMission
	local var_28_1

	if arg_28_0.contextData.editBossFleet and arg_28_0.contextData.editBossFleet[arg_28_1] then
		var_28_1 = arg_28_0.contextData.editBossFleet[arg_28_1]
	else
		var_28_1 = var_28_0:GetFleetByIndex(arg_28_1)
	end

	arg_28_0.fleet = var_28_1

	arg_28_0:UpdateShips(var_28_1)
	arg_28_0:UpdateCommanders(var_28_1)

	local var_28_2 = arg_28_0.contextData

	var_28_2.bossFormationIndex = arg_28_1
	setActive = var_28_2

	local var_28_3 = arg_28_0.nextBtn

	GuildBossMission = var_7

	var_28_2(var_28_3, arg_28_1 == var_7.MAIN_FLEET_ID)

	setActive = var_28_2

	local var_28_4 = arg_28_0.prevBtn

	GuildBossMission = var_7

	var_28_2(var_28_4, arg_28_1 == var_7.SUB_FLEET_ID)
	arg_28_0:UpdateSubToggle()

	return
end

function var_0_1.UpdateCommanders(arg_29_0, arg_29_1)
	if arg_29_0.isOpenCommander then
		getProxy = var_2
		CommanderProxy = var_1_10004

		local var_29_0 = var_2(var_1_10004)
		local var_29_1 = var_2.getPrefabFleet(var_29_0)
		local var_29_2 = arg_29_0.commanderPage

		var_3.ExecuteAction(var_29_2, "Update", arg_29_1, var_29_1)
	end

	return
end

function var_0_1.UpdateShips(arg_30_0, arg_30_1)
	arg_30_0:ClearShips()

	local var_30_0 = arg_30_1:GetShips()
	local var_30_1 = {}
	local var_30_2 = {}
	local var_30_3 = {}

	ipairs = var_1_10006

	for iter_30_0, iter_30_1 in var_1_10006(var_30_0) do
		if iter_30_1 and iter_30_1.ship then
			local var_30_4 = iter_30_1.ship
			local var_30_5 = var_11.getTeamType(var_30_4)

			TeamType = var_1_10012

			if var_30_5 == var_1_10012.Vanguard then
				table = var_1_10012

				var_1_10012.insert(var_30_2, iter_30_1)
			else
				TeamType = var_1_10012

				if var_30_5 == var_1_10012.Main then
					table = var_1_10012

					var_1_10012.insert(var_30_1, iter_30_1)
				else
					TeamType = var_1_10012

					if var_30_5 == var_1_10012.Submarine then
						table = var_1_10012

						var_1_10012.insert(var_30_3, iter_30_1)
					end
				end
			end
		end
	end

	if arg_30_1:IsMainFleet() then
		arg_30_0:UpdateMainFleetShips(var_30_1, var_30_2)
	else
		arg_30_0:UpdateSubFleetShips(var_30_3)
	end

	setActive = var_7

	var_7(arg_30_0.flag, var_6 and #var_30_1 > 0)

	setActive = var_7

	var_7(arg_30_0.subFlag, not var_6 and #var_30_3 > 0)

	setActive = var_7

	var_7(arg_30_0.grids, var_6)

	setActive = var_7

	var_7(arg_30_0.subGrids, not var_6)

	return
end

function var_0_1.UpdateMainFleetShips(arg_31_0, arg_31_1, arg_31_2)
	for iter_31_0 = 1, 3 do
		local var_31_0 = arg_31_0.grids
		local var_31_1 = var_7.Find(var_31_0, iter_31_0)
		local var_31_2 = arg_31_1[iter_31_0]
		local var_31_3 = arg_31_0
		local var_31_4 = arg_31_0.UpdateShip
		local var_31_5 = iter_31_0
		local var_31_6 = var_31_1

		TeamType = var_1_10014

		var_31_4(var_31_3, var_31_5, var_31_6, var_1_10014.Main, var_31_2)
	end

	for iter_31_1 = 4, 6 do
		local var_31_7 = arg_31_0.grids
		local var_31_8 = var_7.Find(var_31_7, iter_31_1)
		local var_31_9 = arg_31_2[iter_31_1 - 3]
		local var_31_10 = arg_31_0
		local var_31_11 = arg_31_0.UpdateShip
		local var_31_12 = iter_31_1
		local var_31_13 = var_31_8

		TeamType = var_1_10014

		var_31_11(var_31_10, var_31_12, var_31_13, var_1_10014.Vanguard, var_31_9)
	end

	return
end

function var_0_1.UpdateSubFleetShips(arg_32_0, arg_32_1)
	for iter_32_0 = 1, 3 do
		local var_32_0 = arg_32_0.subGrids
		local var_32_1 = var_6.Find(var_32_0, iter_32_0)
		local var_32_2 = arg_32_1[iter_32_0]
		local var_32_3 = arg_32_0
		local var_32_4 = arg_32_0.UpdateShip
		local var_32_5 = iter_32_0
		local var_32_6 = var_32_1

		TeamType = var_1_10013

		var_32_4(var_32_3, var_32_5, var_32_6, var_1_10013.Submarine, var_32_2)
	end

	return
end

function var_0_1.UpdateShip(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	local var_33_0 = arg_33_2:Find("Image")

	if arg_33_4 then
		local var_33_1 = arg_33_4.ship
		local var_33_2 = var_1_10006.getPrefab(var_33_1)

		SpineAnimChar = var_8
		var_1_10011 = var_8.New()

		var_8.SetPaint(var_1_10011, var_33_2)

		var_1_10011 = var_8

		var_8.Load(var_1_10011, true, function(arg_34_0)
			arg_34_0:SetName(var_33_2)
			arg_34_0:SetParent(arg_33_2.parent)

			GuildBossFormationShipCard = var_1

			local var_34_0 = var_1.New(arg_34_0)

			var_1.Update(var_34_0, var_1_10006, arg_33_1)
			arg_34_0:SetAction("stand", 0)

			GetOrAddComponent = var_2

			local var_34_1 = var_2(arg_34_0:GetModel(), "EventTriggerListener")

			var_2.AddPointClickFunc(var_34_1, function(arg_35_0, arg_35_1)
				if arg_33_0.dragging then
					return
				end

				local var_35_0 = arg_33_0
				local var_35_1 = var_2.emit

				GuildEventMediator = var_3_10005

				var_35_1(var_35_0, var_3_10005.ON_SELECT_BOSS_SHIP, arg_33_3, arg_33_0.fleet.id, arg_33_4)

				return
			end)
			var_2:AddBeginDragFunc(function(arg_36_0, arg_36_1)
				arg_33_0.dragging = true

				local var_36_0 = arg_36_0.transform

				var_2.SetAsLastSibling(var_36_0)

				local var_36_1 = arg_34_0

				var_2.SetAction(var_36_1, "tuozhuai", 0)

				return
			end)
			var_2:AddDragFunc(function(arg_37_0, arg_37_1)
				local var_37_0 = var_0_1.Scr2Lpos(arg_33_2.parent, arg_37_1.position)
				local var_37_1 = var_0

				var_3.SetLocalPosition(var_37_1, var_37_0)

				local var_37_2 = arg_33_0

				if var_3.GetNearestCard(var_37_2, var_0) then
					local var_37_3 = arg_33_0

					var_4.SwopCardSolt(var_37_3, var_3, var_0)
				end

				return
			end)
			var_2:AddDragEndFunc(function(arg_38_0, arg_38_1)
				arg_33_0.dragging = false

				local var_38_0 = var_0
				local var_38_1 = var_2.RefreshPosition
				local var_38_2 = var_0

				var_38_1(var_38_0, var_5.GetSoltIndex(var_38_2), true)

				local var_38_3 = arg_34_0

				var_2.SetAction(var_38_3, "stand", 0)

				local var_38_4 = arg_33_0

				var_2.RefreshFleet(var_38_4)

				return
			end)

			table = var_3

			var_3.insert(arg_33_0.shipCards, var_1)

			return
		end)
	else
		onButton = var_1_10006

		local var_33_3 = arg_33_0
		local var_33_4 = var_33_0

		local function var_33_5()
			local var_39_0 = arg_33_0
			local var_39_1 = var_0.emit

			GuildEventMediator = var_2_10003

			var_39_1(var_39_0, var_2_10003.ON_SELECT_BOSS_SHIP, arg_33_3, arg_33_0.fleet.id)

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_33_3, var_33_4, var_33_5, var_1_10011)
	end

	setActive = var_1_10006

	var_1_10006(var_33_0, not arg_33_4)

	return
end

function var_0_1.GetNearestCard(arg_40_0, arg_40_1)
	ipairs = var_1_10002

	for iter_40_0, iter_40_1 in var_1_10002(arg_40_0.shipCards) do
		if iter_40_1:GetSoltIndex() ~= arg_40_1:GetSoltIndex() and iter_40_1.teamType == arg_40_1.teamType then
			Vector2 = var_7

			if var_7.Distance(arg_40_1:GetLocalPosition(), iter_40_1:GetLocalPosition()) <= 50 then
				return iter_40_1
			end
		end
	end

	return nil
end

function var_0_1.SwopCardSolt(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_1:GetSoltIndex()

	arg_41_1:RefreshPosition(arg_41_2:GetSoltIndex(), true)
	arg_41_2:RefreshPosition(var_41_0, false)

	return
end

function var_0_1.RefreshFleet(arg_42_0)
	local var_42_0 = {}

	ipairs = var_1_10002

	for iter_42_0, iter_42_1 in var_1_10002(arg_42_0.shipCards) do
		table = var_1_10007

		var_1_10007.insert(var_42_0, {
			index = iter_42_1:GetSoltIndex(),
			shipId = iter_42_1.shipId
		})
	end

	table = var_2

	var_2.sort(var_42_0, function(arg_43_0, arg_43_1)
		return arg_43_0.index < arg_43_1.index
	end)

	if not arg_42_0.contextData.editBossFleet then
		arg_42_0.contextData.editBossFleet = {}
	end

	if not arg_42_0.contextData.editBossFleet[arg_42_0.fleet.id] then
		local var_42_1 = arg_42_0.contextData.editBossFleet
		local var_42_2 = arg_42_0.fleet.id

		Clone = var_4
		var_42_1[var_42_2] = var_4(arg_42_0.fleet)
		arg_42_0.fleet = arg_42_0.contextData.editBossFleet[arg_42_0.fleet.id]
	end

	local var_42_3 = arg_42_0.fleet

	var_2.ResortShips(var_42_3, var_42_0)

	return
end

function var_0_1.ClearShips(arg_44_0)
	ipairs = var_1_10001

	for iter_44_0, iter_44_1 in var_1_10001(arg_44_0.shipCards) do
		iter_44_1:Dispose()
	end

	arg_44_0.shipCards = {}

	return
end

function var_0_1.OnDestroy(arg_45_0)
	var_0_1.super.OnDestroy(arg_45_0)
	arg_45_0:ClearShips()

	local var_45_0 = arg_45_0.commanderPage

	var_1.Destroy(var_45_0)

	return
end

function var_0_1.Scr2Lpos(arg_46_0, arg_46_1)
	GameObject = var_1_10002

	local var_46_0 = var_1_10002.Find("OverlayCamera")
	local var_46_1 = var_2.GetComponent(var_46_0, "Camera")
	local var_46_2 = arg_46_0:GetComponent("RectTransform")

	LuaHelper = var_46_0

	return (var_46_0.ScreenToLocal(var_46_2, arg_46_1, var_46_1))
end

return var_0_1
