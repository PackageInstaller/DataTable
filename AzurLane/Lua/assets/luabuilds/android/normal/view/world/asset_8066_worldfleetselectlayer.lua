class = var_0_10000

local var_0_0 = "WorldFleetSelectLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "WorldFleetSelect"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.rtBg = var_1.Find(var_2_0, "bg")
	nowWorld = var_1

	local var_2_1 = var_1()
	local var_2_2 = var_1.GetRealm(var_2_1)

	eachChild = var_2_1

	var_2_1(arg_2_0.rtBg, function(arg_3_0)
		setActive = var_2_10001

		local var_3_0 = arg_3_0
		local var_3_1 = arg_3_0.name

		tostring = var_2_10004

		var_2_10001(var_3_0, var_3_1 == var_2_10004(var_2_2))

		return
	end)

	local var_2_3 = arg_2_0._tf

	arg_2_0.rtPanel = var_2.Find(var_2_3, "panel")

	local var_2_4 = arg_2_0.rtPanel

	arg_2_0.rtShipTpl = var_2.Find(var_2_4, "shiptpl")
	setActive = var_2

	var_2(arg_2_0.rtShipTpl, false)

	local var_2_5 = arg_2_0.rtPanel

	arg_2_0.rtEmptyTpl = var_2.Find(var_2_5, "emptytpl")
	setActive = var_2

	var_2(arg_2_0.rtEmptyTpl, false)

	local var_2_6 = arg_2_0.rtPanel

	arg_2_0.rtScroll = var_2.Find(var_2_6, "bg")

	local var_2_7 = arg_2_0.rtScroll

	arg_2_0.rtContent = var_2.Find(var_2_7, "content")

	local var_2_8 = {}

	FleetType = var_2_7

	local var_2_9 = var_2_7.Normal
	local var_2_10 = arg_2_0.rtContent

	var_2_8[var_2_9] = var_4.Find(var_2_10, "fleet")
	FleetType = var_2_9

	local var_2_11 = var_2_9.Submarine
	local var_2_12 = arg_2_0.rtContent

	var_2_8[var_2_11] = var_4.Find(var_2_12, "sub")
	arg_2_0.rtFleets = var_2_8

	local var_2_13 = arg_2_0.rtPanel

	arg_2_0.btnBack = var_2.Find(var_2_13, "btnBack")

	local var_2_14 = arg_2_0.rtPanel

	arg_2_0.btnGo = var_2.Find(var_2_14, "start_button")

	local var_2_15 = arg_2_0.rtPanel

	arg_2_0.commanderToggle = var_2.Find(var_2_15, "commander_btn")

	local var_2_16 = arg_2_0.rtPanel

	arg_2_0.formationToggle = var_2.Find(var_2_16, "formation_btn")

	local var_2_17 = arg_2_0.rtPanel

	arg_2_0.tfLimitTip = var_2.Find(var_2_17, "limit_tip")
	setText = var_2

	local var_2_18 = arg_2_0.tfLimitTip
	local var_2_19 = var_3.Find(var_2_18, "Text")

	i18n = var_2_18

	var_2(var_2_19, var_2_18("world_fleet_choose"))

	local var_2_20 = arg_2_0.rtPanel

	arg_2_0.tfLimitSub = var_2.Find(var_2_20, "limit_world/limit_sub")
	setText = var_2

	local var_2_21 = arg_2_0.tfLimitSub
	local var_2_22 = var_3.Find(var_2_21, "Text")

	i18n = var_2_21

	var_2(var_2_22, var_2_21("ship_limit_notice"))

	local var_2_23 = arg_2_0.rtPanel

	arg_2_0.tfLimitContainer = var_2.Find(var_2_23, "limit_world/limit_list")

	local var_2_24 = arg_2_0.tfLimitContainer

	arg_2_0.tfLimitTpl = var_2.Find(var_2_24, "condition")

	arg_2_0:buildCommanderPanel()

	return
end

function var_0_1.didEnter(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_4_0, arg_4_0.rtPanel)

	onButton = var_1

	local var_4_1 = arg_4_0
	local var_4_2 = arg_4_0.btnGo

	local function var_4_3()
		local var_5_0 = arg_4_0
		local var_5_1, var_5_2 = var_0.CheckValid(var_5_0)

		if var_5_1 then
			local var_5_3 = arg_4_0

			var_2_10002 = var_2_10002.emit
			WorldFleetSelectMediator = var_2_10004

			var_2_10002(var_5_3, var_2_10004.OnGO)
		else
			pg = var_2_10002

			local var_5_4 = var_2_10002.TipsMgr.GetInstance()

			var_2.ShowTips(var_5_4, var_5_2)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_4_1, var_4_2, var_4_3, var_1_10005)

	onButton = var_1

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0.btnBack

	local function var_4_6()
		local var_6_0 = arg_4_0

		var_0.closeView(var_6_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_4_4, var_4_5, var_4_6, var_1_10005)

	local function var_4_7(arg_7_0)
		local var_7_0 = arg_4_0.contextData

		var_7_0.showCommander = arg_7_0
		pairs = var_7_0

		for iter_7_0, iter_7_1 in var_7_0(arg_4_0.rtFleets) do
			for iter_7_2 = 1, #arg_4_0.contextData.fleets[iter_7_0] do
				local var_7_1 = arg_4_0

				var_10.updateCommanderBtn(var_7_1, iter_7_1:GetChild(iter_7_2 - 1))
			end
		end

		return
	end

	onToggle = var_4_4

	local var_4_8 = arg_4_0
	local var_4_9 = arg_4_0.commanderToggle

	local function var_4_10(arg_8_0)
		if arg_8_0 then
			var_4_7(arg_8_0)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_4_4(var_4_8, var_4_9, var_4_10, var_1_10006)

	onToggle = var_4_4

	local var_4_11 = arg_4_0
	local var_4_12 = arg_4_0.formationToggle

	local function var_4_13(arg_9_0)
		if arg_9_0 then
			var_4_7(not arg_9_0)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_4_4(var_4_11, var_4_12, var_4_13, var_1_10006)
	arg_4_0:UpdateFleets()

	scrollTo = var_2

	var_2(arg_4_0.rtContent, nil, arg_4_0.contextData.scrollY)

	local var_4_14 = arg_4_0.contextData

	defaultValue = var_3
	var_4_14.showCommander = var_3(arg_4_0.contextData.showCommander, true)
	triggerToggle = var_4_14

	local var_4_15

	if not arg_4_0.contextData.showCommander or not arg_4_0.commanderToggle then
		var_4_15 = arg_4_0.formationToggle
	end

	var_4_14(var_4_15, true)
	arg_4_0:CheckWorldResetAward()

	return
end

function var_0_1.willExit(arg_10_0)
	local var_10_0 = arg_10_0.contextData

	GetComponent = var_1_10002

	local var_10_1 = arg_10_0.rtContent

	typeof = var_1_10004
	ScrollRect = var_1_10005
	var_10_0.scrollY = var_1_10002(var_10_1, var_1_10004(var_1_10005)).normalizedPosition.y
	pg = var_10_0

	local var_10_2 = var_10_0.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_10_2, arg_10_0.rtPanel, arg_10_0._tf)
	arg_10_0:destroyCommanderPanel()

	return
end

function var_0_1.onBackPressed(arg_11_0)
	local var_11_0 = arg_11_0.levelCMDFormationView

	if var_1.isShowing(var_11_0) then
		local var_11_1 = arg_11_0.levelCMDFormationView

		var_1.ActionInvoke(var_11_1, "Hide")
	else
		arg_11_0:closeView()
	end

	return
end

function var_0_1.UpdateFleets(arg_12_0)
	local var_12_0 = arg_12_0.contextData.fleets

	pairs = var_1_10002

	for iter_12_0, iter_12_1 in var_1_10002(var_12_0) do
		local var_12_1 = arg_12_0.rtFleets[iter_12_0]

		UIItemList = var_1_10008

		local var_12_2 = var_1_10008.New(var_12_1, var_12_1:GetChild(0))

		var_1_10008.make(var_12_2, function(arg_13_0, arg_13_1, arg_13_2)
			UIItemList = var_2_10003

			if arg_13_0 == var_2_10003.EventUpdate then
				local var_13_0 = arg_12_0

				var_3.UpdateFleet(var_13_0, arg_13_2, iter_12_0, arg_13_1 + 1)
			end

			return
		end)
		var_1_10008:align(#var_12_0[iter_12_0])

		setActive = var_9

		var_9(var_12_1, #var_12_0[iter_12_0] > 0)
	end

	arg_12_0:updateEliteLimit()

	return
end

function var_0_1.IsPropertyLimitationSatisfy(arg_14_0)
	getProxy = var_1_10001
	BayProxy = var_1_10002

	local var_14_0 = var_1_10001(var_1_10002)
	local var_14_1 = var_1.getRawData(var_14_0)

	pg = var_14_0

	local var_14_2 = var_14_0.gameset.world_fleet_unlock_level.description
	local var_14_3 = {}

	ipairs = var_1_10004

	for iter_14_0, iter_14_1 in var_1_10004(var_14_2) do
		var_14_3[iter_14_1[1]] = 0
	end

	local var_14_4 = 0

	ipairs = var_5

	local var_14_5 = arg_14_0.contextData.fleets

	FleetType = iter_14_0

	for iter_14_2, iter_14_3 in var_5(var_14_5[iter_14_0.Normal]) do
		var_1_10011 = arg_14_0

		local var_14_6 = arg_14_0.GetTeamShipCount

		TeamType = var_1_10012

		if var_14_6(var_1_10011, iter_14_3[var_1_10012.Main]) ~= 0 then
			var_1_10011 = arg_14_0

			local var_14_7 = arg_14_0.GetTeamShipCount

			TeamType = var_1_10012

			if var_14_7(var_1_10011, iter_14_3[var_1_10012.Vanguard]) == 0 then
				-- block empty
			else
				local var_14_8 = {}

				var_1_10011 = {}
				var_1_10012 = 0
				ipairs = var_1_10013

				for iter_14_4, iter_14_5 in var_1_10013(var_14_2) do
					unpack = var_1_10018

					local var_14_9, var_14_10, var_14_11

					var_1_10018, var_14_9, var_14_10, var_14_11 = var_1_10018(iter_14_5)
					string = var_1_10022

					if var_1_10022.sub(var_1_10018, 1, 5) == "fleet" then
						var_14_8[var_1_10018] = 0
						var_1_10011[var_1_10018] = var_14_11
					end
				end

				pairs = var_1_10013

				for iter_14_6, iter_14_7 in var_1_10013(iter_14_3) do
					for iter_14_8 = 1, 3 do
						if iter_14_7[iter_14_8] then
							var_1_10022 = var_14_1[iter_14_7[iter_14_8]]
						end

						if var_1_10022 then
							var_14_4 = var_14_4 + 1
							var_1_10012 = var_1_10012 + 1
							intProperties = var_1_10023
							var_1_10023 = var_1_10023(var_1_10022:getProperties())
							pairs = var_24

							for iter_14_9, iter_14_10 in var_24(var_14_3) do
								string = var_1_10029

								if var_1_10029.sub(iter_14_9, 1, 5) == "fleet" then
									if iter_14_9 == "fleet_totle_level" then
										var_14_8[iter_14_9] = var_14_8[iter_14_9] + var_1_10022.level
									end
								elseif iter_14_9 == "level" then
									var_14_3[iter_14_9] = iter_14_10 + var_1_10022.level
								else
									var_14_3[iter_14_9] = iter_14_10 + var_1_10023[iter_14_9]
								end
							end
						end
					end
				end

				pairs = var_1_10013

				for iter_14_11, iter_14_12 in var_1_10013(var_14_8) do
					if iter_14_11 == "fleet_totle_level" and var_1_10011[iter_14_11] < iter_14_12 then
						var_14_3[iter_14_11] = var_14_3[iter_14_11] + 1
					end
				end
			end
		end
	end

	local var_14_12 = {}

	ipairs = var_6

	for iter_14_13, iter_14_14 in var_6(var_14_2) do
		unpack = var_1_10011

		local var_14_13, var_14_14, var_14_15

		var_1_10011, var_14_13, var_14_14, var_14_15 = var_1_10011(iter_14_14)

		if var_1_10011 == "level" and 0 < var_14_4 then
			math = var_1_10015
			var_14_3[var_1_10011] = var_1_10015.ceil(var_14_3[var_1_10011] / var_14_4)
		end

		AttributeType = var_1_10015
		var_1_10015 = var_1_10015.EliteConditionCompare(var_14_13, var_14_3[var_1_10011], var_14_14) and 1 or 0
		var_14_12[iter_14_13] = var_1_10015
	end

	return var_14_12, var_14_3
end

function var_0_1.updateEliteLimit(arg_15_0)
	pg = var_1_10001

	if #var_1_10001.gameset.world_fleet_unlock_level.description == 0 then
		return
	end

	local var_15_0, var_15_1 = arg_15_0:IsPropertyLimitationSatisfy()

	UIItemList = var_1_10004

	local var_15_2 = var_1_10004.New(arg_15_0.tfLimitContainer, arg_15_0.tfLimitTpl)

	var_4.make(var_15_2, function(arg_16_0, arg_16_1, arg_16_2)
		arg_16_1 = arg_16_1 + 1
		UIItemList = var_2_10003

		if arg_16_0 == var_2_10003.EventUpdate then
			local var_16_0 = var_0[arg_16_1]

			unpack = var_2_10004

			local var_16_1, var_16_2, var_16_3, var_16_4 = var_2_10004(var_16_0)
			local var_16_6

			if var_15_0[arg_16_1] == 1 then
				local var_16_5 = arg_16_2:Find("Text")

				var_16_6 = var_16_6.GetComponent
				typeof = var_10
				Text = var_2_10011
				var_16_6 = var_16_6(var_16_5, var_10(var_2_10011))
				Color = var_16_5
				var_16_6.color = var_16_5.New(1, 0.9607843137254902, 0.5019607843137255)
			else
				local var_16_7 = arg_16_2:Find("Text")

				var_16_6 = var_16_6.GetComponent
				typeof = var_10
				Text = var_2_10011
				var_16_6 = var_16_6(var_16_7, var_10(var_2_10011))
				Color = var_16_7
				var_16_6.color = var_16_7.New(0.9568627450980393, 0.30196078431372547, 0.30196078431372547)
			end

			AttributeType = var_16_6

			local var_16_8 = var_16_6.EliteCondition2Name(var_16_1, var_16_4)

			AttributeType = var_9

			local var_16_9 = (var_16_8 .. var_9.eliteConditionCompareTip(var_16_2) .. var_16_3) .. "（" .. var_15_1[var_16_1] .. "）"

			setText = var_9

			var_9(arg_16_2:Find("Text"), var_16_9)
		end

		return
	end)
	var_4:align(#var_1)

	return
end

function var_0_1.updateCommanderBtn(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1:Find("btn_recom")
	local var_17_1 = arg_17_1:Find("btn_clear")
	local var_17_2 = arg_17_1
	local var_17_3 = arg_17_1.Find(var_17_2, "commander")

	setActive = var_17_2

	var_17_2(var_17_0, not arg_17_0.contextData.showCommander)

	setActive = var_17_2

	var_17_2(var_17_1, not arg_17_0.contextData.showCommander)

	setActive = var_17_2

	var_17_2(var_17_3, arg_17_0.contextData.showCommander)

	return
end

function var_0_1.UpdateFleet(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_1:Find("commander")

	arg_18_0:updateCommanders(var_18_0, arg_18_2, arg_18_3)

	local var_18_1 = arg_18_0.contextData.fleets[arg_18_2][arg_18_3]

	FleetType = var_7

	local var_18_2 = (arg_18_2 == var_7.Submarine and 10 or 0) + arg_18_3

	setText = var_8

	local var_18_3 = arg_18_1
	local var_18_4 = arg_18_1.Find(var_18_3, "bg/name")

	Fleet = var_18_3

	var_8(var_18_4, var_18_3.DEFAULT_NAME[var_18_2])

	FleetType = var_8

	if arg_18_2 == var_8.Normal then
		local var_18_5 = arg_18_0
		local var_18_6 = arg_18_0.UpdateShips
		local var_18_7 = arg_18_1
		local var_18_8 = arg_18_1.Find

		TeamType = var_1_10012

		local var_18_9 = var_18_8(var_18_7, var_1_10012.Main)

		TeamType = var_18_7

		var_18_6(var_18_5, var_18_9, var_18_7.Main, var_18_1)

		local var_18_10 = arg_18_0

		var_18_6 = arg_18_0.UpdateShips

		local var_18_11 = arg_18_1
		local var_18_12 = arg_18_1.Find

		TeamType = var_1_10012

		local var_18_13 = var_18_12(var_18_11, var_1_10012.Vanguard)

		TeamType = var_18_11

		var_18_6(var_18_10, var_18_13, var_18_11.Vanguard, var_18_1)

		setActive = var_18_6

		local var_18_14 = arg_18_1:Find("selected")
		local var_18_15 = arg_18_0
		local var_18_16 = arg_18_0.GetTeamShipCount

		TeamType = var_1_10012

		if var_18_16(var_18_15, var_18_1[var_1_10012.Main]) > 0 then
			local var_18_17 = arg_18_0
			local var_18_18 = arg_18_0.GetTeamShipCount

			TeamType = var_1_10012

			local var_18_19

			if not (var_18_18(var_18_17, var_18_1[var_1_10012.Vanguard]) > 0) then
				var_18_19 = false
			else
				var_18_19 = true
			end

			var_18_6(var_18_14, var_18_19)

			if false then
				FleetType = var_18_6

				if arg_18_2 == var_18_6.Submarine then
					local var_18_20 = arg_18_0
					local var_18_21 = arg_18_0.UpdateShips
					local var_18_22 = arg_18_1
					local var_18_23 = arg_18_1.Find

					TeamType = var_1_10012

					local var_18_24 = var_18_23(var_18_22, var_1_10012.Submarine)

					TeamType = var_18_22

					var_18_21(var_18_20, var_18_24, var_18_22.Submarine, var_18_1)

					setActive = var_18_21

					local var_18_25 = arg_18_1:Find("selected")
					local var_18_26 = arg_18_0
					local var_18_27 = arg_18_0.GetTeamShipCount

					TeamType = var_12

					var_18_21(var_18_25, var_18_27(var_18_26, var_18_1[var_12.Submarine]) > 0)
				end
			end

			local var_18_28 = arg_18_1:Find("btn_recom")
			local var_18_29 = arg_18_1
			local var_18_30 = arg_18_1.Find(var_18_29, "btn_clear")

			onButton = var_18_29

			local var_18_31 = arg_18_0
			local var_18_32 = var_18_28

			local function var_18_33()
				local var_19_0 = arg_18_0

				var_0.RecommendFormation(var_19_0, arg_18_2, arg_18_3)

				local var_19_1 = arg_18_0

				var_0.UpdateFleet(var_19_1, arg_18_1, arg_18_2, arg_18_3)

				local var_19_2 = arg_18_0

				var_0.updateEliteLimit(var_19_2)

				return
			end

			SFX_PANEL = var_1_10014

			var_18_29(var_18_31, var_18_32, var_18_33, var_1_10014)

			onButton = var_18_29

			local var_18_34 = arg_18_0
			local var_18_35 = var_18_30

			local function var_18_36()
				local var_20_0 = arg_18_0
				local var_20_1 = var_0.GetTeamShipCount
				local var_20_2 = var_18_1

				TeamType = var_2_10003

				if not (var_20_1(var_20_0, var_20_2[var_2_10003.Main]) > 0) then
					local var_20_3 = arg_18_0
					local var_20_4 = var_20_4.GetTeamShipCount
					local var_20_5 = var_18_1

					TeamType = var_3

					if not (var_20_4(var_20_3, var_20_5[var_3.Vanguard]) > 0) then
						local var_20_6 = arg_18_0

						var_20_4 = var_20_4.GetTeamShipCount

						local var_20_7 = var_18_1

						TeamType = var_3

						if var_20_4(var_20_6, var_20_7[var_3.Submarine]) > 0 then
							pg = var_20_4

							local var_20_8 = var_20_4.MsgboxMgr.GetInstance()
							local var_20_9 = var_0.ShowMsgBox
							local var_20_10 = {}

							i18n = var_3
							var_20_10.content = var_3("battle_preCombatLayer_clear_confirm")

							function var_20_10.onYes()
								local var_21_0 = var_18_1

								TeamType = var_3_10001
								var_21_0[var_3_10001.Main] = {}

								local var_21_1 = var_18_1

								TeamType = var_1
								var_21_1[var_1.Vanguard] = {}

								local var_21_2 = var_18_1

								TeamType = var_1
								var_21_2[var_1.Submarine] = {}

								local var_21_3 = arg_18_0

								var_0.UpdateFleet(var_21_3, arg_18_1, arg_18_2, arg_18_3)

								local var_21_4 = arg_18_0

								var_0.updateEliteLimit(var_21_4)

								return
							end

							var_20_9(var_20_8, var_20_10)
						end

						return
					end
				end
			end

			SFX_CANCEL = var_1_10014

			var_18_29(var_18_34, var_18_35, var_18_36, var_1_10014)

			return
		end
	end
end

function var_0_1.updateCommanders(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = arg_22_0.contextData.fleets[arg_22_2][arg_22_3]

	Fleet = var_1_10005

	local var_22_1 = var_1_10005.New({
		ship_list = {},
		commanders = var_22_0.commanders
	})

	for iter_22_0 = 1, 2 do
		local var_22_2 = var_22_1:getCommanderByPos(iter_22_0)
		local var_22_3 = arg_22_1:Find("pos" .. iter_22_0)
		local var_22_4 = var_11.Find(var_22_3, "add")
		local var_22_5 = var_11
		local var_22_6 = var_11.Find(var_22_5, "info")

		setActive = var_22_5

		var_22_5(var_22_4, not var_22_2)

		setActive = var_22_5

		var_22_5(var_22_6, var_22_2)

		if var_22_2 then
			Commander = var_22_5
			var_22_5 = var_22_5.rarity2Frame(var_22_2:getRarity())
			setImageSprite = var_15

			local var_22_7 = var_22_6
			local var_22_8 = var_22_6.Find(var_22_7, "frame")

			GetSpriteFromAtlas = var_22_7

			var_15(var_22_8, var_22_7("weaponframes", "commander_" .. var_22_5))

			GetImageSpriteFromAtlasAsync = var_15

			local var_22_9 = "CommanderHrz/"

			var_1_10018 = var_22_2

			var_15(var_22_9 .. var_22_2.getPainting(var_1_10018), "", var_22_6:Find("mask/icon"))
		else
			var_22_5 = 1

			while var_22_0.commanders[var_22_5] and var_22_0.commanders[var_22_5].pos ~= iter_22_0 do
				var_22_5 = var_22_5 + 1
			end

			if var_22_0.commanders[var_22_5] then
				table = var_15

				var_15.remove(var_22_0.commanders, var_22_5)
			end
		end

		onButton = var_22_5

		local var_22_10 = arg_22_0
		local var_22_11 = var_22_4

		local function var_22_12()
			local var_23_0 = arg_22_0

			var_0.openCommanderPanel(var_23_0, var_22_1, arg_22_2, arg_22_3)

			return
		end

		SFX_PANEL = var_1_10018

		var_22_5(var_22_10, var_22_11, var_22_12, var_1_10018)

		onButton = var_22_5

		local var_22_13 = arg_22_0
		local var_22_14 = var_22_6

		local function var_22_15()
			local var_24_0 = arg_22_0

			var_0.openCommanderPanel(var_24_0, var_22_1, arg_22_2, arg_22_3)

			return
		end

		SFX_PANEL = var_1_10018

		var_22_5(var_22_13, var_22_14, var_22_15, var_1_10018)
	end

	return
end

function var_0_1.UpdateShips(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	getProxy = var_1_10004
	BayProxy = var_1_10005

	local var_25_0 = var_1_10004(var_1_10005)
	local var_25_1 = arg_25_3[arg_25_2]
	local var_25_2 = {}

	ipairs = var_1_10007

	local var_25_3 = {}

	TeamType = var_1_10009
	var_25_3[1] = var_1_10009.Vanguard
	TeamType = var_9
	var_25_3[2] = var_9.Main
	TeamType = var_9
	var_25_3[3] = var_9.Submarine

	for iter_25_0, iter_25_1 in var_1_10007(var_25_3) do
		for iter_25_2 = 1, 3 do
			if arg_25_3[iter_25_1][iter_25_2] then
				var_1_10017 = var_25_0

				local var_25_4

				if not var_25_0.getShipById(var_1_10017, arg_25_3[iter_25_1][iter_25_2]) then
					var_25_4 = nil
				end

				table = var_1_10017

				var_1_10017.insert(var_25_2, var_25_4)

				if not var_25_4 then
					var_1_10017 = arg_25_3[iter_25_1]
					var_1_10017[iter_25_2] = nil
				end
			end
		end
	end

	removeAllChildren = var_7

	var_7(arg_25_1)

	for iter_25_3 = 1, 3 do
		local var_25_5
		local var_25_6

		if var_25_1[iter_25_3] then
			cloneTplTo = var_13
			var_25_5 = var_13(arg_25_0.rtShipTpl, arg_25_1, "ship_" .. var_25_1[iter_25_3])
			var_25_6 = var_25_0:getShipById(var_25_1[iter_25_3])
			updateShip = var_13

			var_13(var_25_5, var_25_6)
		else
			cloneTplTo = var_13
			var_25_5 = var_13(arg_25_0.rtEmptyTpl, arg_25_1, "empty")
			setActive = var_13

			var_13(var_25_5:Find("ship_type"), false)
		end

		onButton = var_13

		local var_25_7 = arg_25_0
		local var_25_8 = var_25_5:Find("icon_bg")

		local function var_25_9()
			local var_26_0 = arg_25_0
			local var_26_1 = var_0.emit

			WorldFleetSelectMediator = var_2_10002

			var_26_1(var_26_0, var_2_10002.OnSelectShip, arg_25_2, var_25_1, iter_25_3)

			return
		end

		SFX_PANEL = var_17

		var_13(var_25_7, var_25_8, var_25_9, var_17)

		GetOrAddComponent = var_13

		local var_25_10 = var_25_5
		local var_25_11 = var_25_5.Find(var_25_10, "icon_bg")

		typeof = var_25_10
		UILongPressTrigger = var_16

		local var_25_12 = var_13(var_25_11, var_25_10(var_16))

		pg = var_25_11

		var_25_11.DelegateInfo.Add(arg_25_0, var_25_12.onLongPressed)

		local var_25_13 = var_25_12.onLongPressed

		var_14.RemoveAllListeners(var_25_13)

		local var_25_14 = var_25_12.onLongPressed

		var_14.AddListener(var_25_14, function()
			if not var_25_6 then
				local var_27_0 = arg_25_0
				local var_27_1 = var_0.emit

				WorldFleetSelectMediator = var_2_10002

				var_27_1(var_27_0, var_2_10002.OnSelectShip, arg_25_2, var_25_1, iter_25_3)
			else
				local var_27_2 = arg_25_0
				local var_27_3 = var_0.emit

				WorldFleetSelectMediator = var_2_10002

				var_27_3(var_27_2, var_2_10002.OnShipDetail, {
					shipId = var_25_6.id,
					shipVOs = var_25_2
				})
			end

			return
		end)
	end

	return
end

function var_0_1.setCommanderPrefabs(arg_28_0, arg_28_1)
	arg_28_0.commanderPrefabs = arg_28_1

	return
end

function var_0_1.openCommanderPanel(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_0.levelCMDFormationView

	var_4.setCallback(var_29_0, function(arg_30_0)
		local var_30_0 = arg_30_0.type

		LevelUIConst = var_2_10002

		local var_30_1

		if var_30_0 == var_2_10002.COMMANDER_OP_SHOW_SKILL then
			var_30_1 = arg_29_0

			local var_30_2 = var_1.emit

			WorldFleetSelectMediator = var_2_10003

			var_30_2(var_30_1, var_2_10003.OnCommanderSkill, arg_30_0.skill)
		else
			local var_30_3 = arg_30_0.type

			LevelUIConst = var_30_1

			if var_30_3 == var_30_1.COMMANDER_OP_ADD then
				arg_29_0.contextData.eliteCommanderSelected = {
					fleetType = arg_29_2,
					fleetIndex = arg_29_3,
					pos = arg_30_0.pos
				}

				local var_30_4 = arg_29_0
				local var_30_5 = var_1.emit

				WorldFleetSelectMediator = var_2_10003

				var_30_5(var_30_4, var_2_10003.OnSelectEliteCommander, arg_29_2, arg_29_3, arg_30_0.pos)

				local var_30_6 = arg_29_0

				var_1.closeCommanderPanel(var_30_6)
			else
				local var_30_7 = arg_29_0
				local var_30_8 = var_1.emit

				WorldFleetSelectMediator = var_2_10003

				local var_30_9 = var_2_10003.OnCommanderFormationOp
				local var_30_10 = {}

				LevelUIConst = var_2_10005
				var_30_10.FleetType = var_2_10005.FLEET_TYPE_WORLD
				var_30_10.data = arg_30_0
				var_30_10.fleets = arg_29_0.contextData.fleets
				var_30_10.fleetType = arg_29_2
				var_30_10.fleetIndex = arg_29_3

				var_30_8(var_30_7, var_30_9, var_30_10)
			end
		end

		return
	end)

	local var_29_1 = arg_29_0.levelCMDFormationView

	var_4.Load(var_29_1)

	local var_29_2 = arg_29_0.levelCMDFormationView

	var_4.ActionInvoke(var_29_2, "update", arg_29_1, arg_29_0.commanderPrefabs)

	local var_29_3 = arg_29_0.levelCMDFormationView

	var_4.ActionInvoke(var_29_3, "Show")

	return
end

function var_0_1.closeCommanderPanel(arg_31_0)
	local var_31_0 = arg_31_0.levelCMDFormationView

	var_1.ActionInvoke(var_31_0, "Hide")

	return
end

function var_0_1.updateCommanderFleet(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0.levelCMDFormationView

	if var_2.isShowing(var_32_0) then
		local var_32_1 = arg_32_0.levelCMDFormationView

		var_2.ActionInvoke(var_32_1, "updateFleet", arg_32_1)
	end

	return
end

function var_0_1.updateCommanderPrefab(arg_33_0)
	local var_33_0 = arg_33_0.levelCMDFormationView

	if var_1.isShowing(var_33_0) then
		local var_33_1 = arg_33_0.levelCMDFormationView

		var_1.ActionInvoke(var_33_1, "updatePrefabs", arg_33_0.commanderPrefabs)
	end

	return
end

function var_0_1.buildCommanderPanel(arg_34_0)
	LevelCMDFormationView = var_1_10001
	arg_34_0.levelCMDFormationView = var_1_10001.New(arg_34_0._tf, arg_34_0.event, arg_34_0.contextData)

	return
end

function var_0_1.destroyCommanderPanel(arg_35_0)
	local var_35_0 = arg_35_0.levelCMDFormationView

	var_1.Destroy(var_35_0)

	arg_35_0.levelCMDFormationView = nil

	return
end

function var_0_1.CheckValid(arg_36_0)
	pairs = var_1_10001

	for iter_36_0, iter_36_1 in var_1_10001(arg_36_0.contextData.fleets) do
		FleetType = var_1_10006

		if iter_36_0 == var_1_10006.Normal then
			ipairs = var_1_10006

			for iter_36_2, iter_36_3 in var_1_10006(iter_36_1) do
				local var_36_0 = arg_36_0
				local var_36_1 = arg_36_0.GetTeamShipCount

				TeamType = var_1_10013

				if var_36_1(var_36_0, iter_36_3[var_1_10013.Main]) ~= 0 then
					var_36_0 = arg_36_0

					local var_36_2 = arg_36_0.GetTeamShipCount

					TeamType = var_1_10013

					if var_36_2(var_36_0, iter_36_3[var_1_10013.Vanguard]) == 0 then
						local var_36_3 = false

						i18n = var_36_0
						var_1_10013 = "world_fleet_formation_not_valid"
						Fleet = var_1_10014

						local var_36_4 = var_36_0(var_1_10013, var_1_10014.DEFAULT_NAME[iter_36_2])

						return
					end
				end
			end
		end
	end

	local var_36_5, var_36_6 = arg_36_0:IsPropertyLimitationSatisfy()
	local var_36_7 = 1

	ipairs = iter_36_0

	for iter_36_4, iter_36_5 in iter_36_0(var_36_5) do
		var_36_7 = var_36_7 * iter_36_5
	end

	if var_36_7 ~= 1 then
		local var_36_8 = false

		i18n = var_5

		local var_36_9 = var_5("elite_disable_property_unsatisfied")

		return
	end

	return true
end

function var_0_1.GetTeamShipCount(arg_37_0, arg_37_1)
	local var_37_0 = 0

	for iter_37_0 = 1, 3 do
		if arg_37_1[iter_37_0] then
			var_37_0 = var_37_0 + 1
		end
	end

	return var_37_0
end

function var_0_1.RecommendFormation(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = {}

	FleetType = var_1_10004

	local var_38_1 = var_1_10004.Normal
	local var_38_2 = {}

	TeamType = var_1_10006
	var_38_2[1] = var_1_10006.Main
	TeamType = var_6
	var_38_2[2] = var_6.Vanguard
	var_38_0[var_38_1] = var_38_2
	FleetType = var_38_1

	local var_38_3 = var_38_1.Submarine
	local var_38_4 = {}

	TeamType = var_6
	var_38_4[1] = var_6.Submarine
	var_38_0[var_38_3] = var_38_4

	local var_38_5 = {}

	pairs = var_38_4

	for iter_38_0, iter_38_1 in var_38_4(arg_38_0.contextData.fleets) do
		ipairs = var_1_10010

		for iter_38_2, iter_38_3 in var_1_10010(iter_38_1) do
			ipairs = var_1_10015

			for iter_38_4, iter_38_5 in var_1_10015(var_38_0[iter_38_0]) do
				for iter_38_6 = 1, 3 do
					if iter_38_3[iter_38_5][iter_38_6] then
						table = var_1_10025

						var_1_10025.insert(var_38_5, var_24)
					end
				end
			end
		end
	end

	local var_38_6 = arg_38_0.contextData.fleets[arg_38_1][arg_38_2]

	getProxy = var_6
	BayProxy = var_7

	local var_38_7 = var_6(var_7)

	ipairs = var_7

	for iter_38_7, iter_38_8 in var_7(var_38_0[arg_38_1]) do
		for iter_38_9 = 1, 3 do
			if not var_38_6[iter_38_8][iter_38_9] and var_38_7:getWorldRecommendShip(iter_38_8, var_38_5) then
				local var_38_8 = var_38_6[iter_38_8]

				var_38_8[iter_38_9] = var_16.id
				table = var_38_8

				var_38_8.insert(var_38_5, var_16.id)
			end
		end
	end

	return
end

function var_0_1.CheckWorldResetAward(arg_39_0)
	local var_39_0 = {}

	nowWorld = var_1_10002

	if var_1_10002().resetAward and #var_3 > 0 then
		pg = var_4

		if #var_4.gameset.world_resetting_story.description[1] > 0 then
			table = var_5

			var_5.insert(var_39_0, function(arg_40_0)
				pg = var_2_10001

				local var_40_0 = var_2_10001.NewStoryMgr.GetInstance()

				var_1.Play(var_40_0, var_0, arg_40_0, true)

				return
			end)
		end

		table = var_5

		var_5.insert(var_39_0, function(arg_41_0)
			local var_41_0
			local var_41_1 = {
				hideYes = true,
				hideNo = true
			}

			MSGBOX_TYPE_WORLD_RESET = var_2_10003
			var_41_1.type = var_2_10003

			function var_41_1.itemFunc(arg_42_0)
				local var_42_0 = arg_39_0

				var_1.emit(var_42_0, var_0_1.ON_DROP, arg_42_0, function()
					pg = var_4_10000

					local var_43_0 = var_4_10000.MsgboxMgr.GetInstance()

					var_0.ShowMsgBox(var_43_0, var_41_0)

					return
				end)

				return
			end

			var_41_1.drops = var_0
			i18n = var_3
			var_41_1.tipWord = var_3("world_recycle_item_transform")
			var_41_1.onNo = arg_41_0
			var_41_0 = var_41_1
			pg = var_41_1

			local var_41_2 = var_41_1.MsgboxMgr.GetInstance()

			var_2.ShowMsgBox(var_41_2, var_41_0)

			return
		end)
	end

	if var_2.resetLimitTip then
		table = var_4

		var_4.insert(var_39_0, function(arg_44_0)
			pg = var_2_10001

			local var_44_0 = var_2_10001.MsgboxMgr.GetInstance()
			local var_44_1 = var_1.ShowMsgBox
			local var_44_2 = {
				hideNo = true
			}

			i18n = var_2_10004
			var_44_2.content = var_2_10004("world_resource_fill")

			var_44_1(var_44_0, var_44_2)

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_39_0, function()
		local var_45_0 = var_0

		var_0.ClearResetAward(var_45_0)

		return
	end)

	return
end

return var_0_1
