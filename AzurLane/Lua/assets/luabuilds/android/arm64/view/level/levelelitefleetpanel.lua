local var_0_0 = class("LevelEliteFleetPanel", import("..base.BasePanel"))
local var_0_1 = {
	vanguard = 1,
	submarine = 3,
	main = 2
}

function var_0_0.init(arg_1_0)
	var_0_0.super.init(arg_1_0)

	arg_1_0.tfShipTpl = arg_1_0._tf:Find("panel/shiptpl")
	arg_1_0.tfEmptyTpl = arg_1_0._tf:Find("panel/emptytpl")
	arg_1_0.tfFleets = {
		[FleetType.Normal] = {
			arg_1_0._tf:Find("panel/fleet/1"),
			arg_1_0._tf:Find("panel/fleet/2")
		},
		[FleetType.Submarine] = {
			arg_1_0._tf:Find("panel/sub/1")
		}
	}
	arg_1_0.tfLimit = arg_1_0._tf:Find("panel/limit")
	arg_1_0.tfLimitTips = arg_1_0._tf:Find("panel/limit_tip")
	arg_1_0.tfLimitElite = arg_1_0._tf:Find("panel/limit_elite")
	arg_1_0.tfLimitContainer = arg_1_0._tf:Find("panel/limit_elite/limit_list")
	arg_1_0.tfLimitTpl = arg_1_0._tf:Find("panel/limit_elite/condition")
	arg_1_0.btnBack = arg_1_0._tf:Find("panel/btnBack")
	arg_1_0.btnGo = arg_1_0._tf:Find("panel/start_button")
	arg_1_0.btnAdHelp = arg_1_0._tf:Find("panel/title/ADvalue/helpbtn")
	arg_1_0.commanderBtn = arg_1_0._tf:Find("panel/commander_btn")
	arg_1_0.toggleMask = arg_1_0._tf:Find("mask")

	setActive(arg_1_0.tfShipTpl, false)
	setActive(arg_1_0.tfEmptyTpl, false)
	setActive(arg_1_0.tfLimitTpl, false)
	setActive(arg_1_0.toggleMask, false)

	arg_1_0.onConfirm = nil
	arg_1_0.onCancel = nil
	arg_1_0.onClick = nil
	arg_1_0.onLongPressed = nil
	arg_1_0.onEliteClear = nil
	arg_1_0.onEliteRecommend = nil

	return
end

function var_0_0.set(arg_2_0, arg_2_1)
	arg_2_0.chapter = arg_2_1
	arg_2_0.propetyLimitation = arg_2_0.chapter:getConfig("property_limitation")
	arg_2_0.eliteFleetList = arg_2_0.chapter:getEliteFleetList()
	arg_2_0.chapterADValue = arg_2_0.chapter:getConfig("air_dominance")
	arg_2_0.suggestionValue = math.max(arg_2_0.chapter:getConfig("best_air_dominance"), 150)
	arg_2_0.eliteCommanderList = arg_2_0.chapter:getEliteFleetCommanders()
	arg_2_0.typeLimitations = arg_2_0.chapter:getConfig("limitation")

	onButton(arg_2_0, arg_2_0.btnGo, function()
		if arg_2_0.onConfirm then
			arg_2_0.onConfirm()
		end

		return
	end, SFX_UI_WEIGHANCHOR_GO)
	onButton(arg_2_0, arg_2_0.btnAdHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("help_battle_ac")
		})

		return
	end, SFX_UI_CLICK)
	onButton(arg_2_0, arg_2_0.btnBack, function()
		if arg_2_0.onCancel then
			arg_2_0.onCancel()
		end

		return
	end, SFX_CANCEL)
	onButton(arg_2_0, arg_2_0._tf, function()
		if arg_2_0.onCancel then
			arg_2_0.onCancel()
		end

		return
	end, SFX_CANCEL)
	onToggle(arg_2_0, arg_2_0.commanderBtn, function(arg_7_0)
		arg_2_0.parent.contextData.EditingCommander = arg_7_0

		arg_2_0:flush()

		return
	end, SFX_PANEL)
	triggerToggle(arg_2_0.commanderBtn, arg_2_0.parent.contextData.EditingCommander)
	setActive(arg_2_0.commanderBtn, arg_2_0.parent.openedCommanerSystem)
	arg_2_0:flush()

	return
end

function var_0_0.clear(arg_8_0)
	triggerToggle(arg_8_0.commanderBtn, false)

	return
end

function var_0_0.flush(arg_9_0)
	arg_9_0:updateLimit()

	if OPEN_AIR_DOMINANCE and arg_9_0.chapterADValue > 0 then
		setActive(arg_9_0._tf:Find("panel/title/ADvalue"), true)
		arg_9_0:updateFleetPanelADValue()
	else
		setActive(arg_9_0._tf:Find("panel/title/ADvalue"), false)
	end

	arg_9_0:updateFleets()

	return
end

function var_0_0.updateLimit(arg_10_0)
	setActive(arg_10_0.toggleMask, false)
	setActive(arg_10_0.tfLimit, false)
	setActive(arg_10_0.tfLimitTips, #arg_10_0.propetyLimitation == 0)
	setActive(arg_10_0.tfLimitElite, #arg_10_0.propetyLimitation > 0)
	removeAllChildren(arg_10_0.tfLimitContainer)

	if #arg_10_0.propetyLimitation > 0 then
		local var_10_0, var_10_1 = arg_10_0.chapter:IsPropertyLimitationSatisfy()

		for iter_10_0, iter_10_1 in ipairs(arg_10_0.propetyLimitation) do
			local var_10_2, var_10_3, var_10_4, var_10_5 = unpack(iter_10_1)
			local var_10_6 = cloneTplTo(arg_10_0.tfLimitTpl, arg_10_0.tfLimitContainer)

			if var_10_0[iter_10_0] == 1 then
				local var_10_7 = var_10_6:Find("Text")

				var_10_7:GetComponent(typeof(Text)).color = Color.New(1, 0.9607843137254902, 0.5019607843137255)
			else
				local var_10_8 = var_10_6:Find("Text")

				var_10_8:GetComponent(typeof(Text)).color = Color.New(0.9568627450980393, 0.30196078431372547, 0.30196078431372547)
			end

			setActive(var_10_6, true)
			setText(var_10_6:Find("Text"), (AttributeType.EliteCondition2Name(var_10_2, var_10_5) .. AttributeType.eliteConditionCompareTip(var_10_3) .. var_10_4) .. "（" .. var_10_1[var_10_2] .. "）")
		end

		setActive(arg_10_0.tfLimitElite:Find("sub"), arg_10_0.chapter:getConfig("submarine_num") > 0)
	end

	return
end

function var_0_0.updateFleetPanelADValue(arg_11_0)
	local var_11_0 = getProxy(BayProxy)
	local var_11_1 = 0

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.eliteFleetList) do
		for iter_11_2, iter_11_3 in pairs(arg_11_0.eliteCommanderList[iter_11_0]) do
			({})[iter_11_2] = getProxy(CommanderProxy):getCommanderById(iter_11_3)
		end

		for iter_11_4, iter_11_5 in ipairs(iter_11_1) do
			var_11_1 = var_11_1 + calcAirDominanceValue(var_11_0:getShipById(iter_11_5), {})
		end
	end

	local var_11_2 = math.floor(var_11_1)
	local var_11_3 = arg_11_0._tf:Find("panel/title/ADvalue/Text")

	setText(var_11_3, i18n("level_scene_title_word_5"))
	setText(var_11_3:Find("Num1"), setColorStr(var_11_2, var_11_2 < arg_11_0.suggestionValue and "#f1dc36" or COLOR_WHITE))
	setText(var_11_3:Find("Num2"), arg_11_0.suggestionValue)

	return
end

function var_0_0.initAddButton(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = arg_12_0.eliteFleetList[arg_12_4]
	local var_12_1 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.eliteFleetList[arg_12_4]) do
		var_12_1[arg_12_0.parent.shipVOs[iter_12_1]] = true

		if arg_12_2 == arg_12_0.parent.shipVOs[iter_12_1]:getTeamType() then
			table.insert({}, iter_12_1)
		end
	end

	removeAllChildren(arg_12_1)

	local var_12_2 = 0
	local var_12_3 = false
	local var_12_4 = 0

	arg_12_3 = Clone(arg_12_3)

	table.sort(arg_12_3, function(arg_13_0, arg_13_1)
		local var_13_0 = type(arg_13_0)
		local var_13_1 = type(arg_13_1)

		if var_13_0 == var_13_1 then
			return var_13_1 < var_13_0
		elseif arg_13_1 == 0 or var_13_1 == "string" and arg_13_0 ~= 0 then
			return true
		else
			return false
		end

		return
	end)

	local var_12_5 = {}
	local var_12_6 = {}

	for iter_12_2 = 1, 3 do
		local var_12_8
		local var_12_9

		if ({})[iter_12_2] then
			local var_12_10 = arg_12_0.parent.shipVOs[({})[iter_12_2]]

			if not arg_12_0.parent.shipVOs[({})[iter_12_2]] then
				var_12_10 = nil
			end

			if var_12_10 then
				for iter_12_3, iter_12_4 in ipairs(arg_12_3) do
					if ShipType.ContainInLimitBundle(iter_12_4, var_12_10:getShipType()) then
						var_12_8 = var_12_10
						var_12_9 = iter_12_4

						table.remove(arg_12_3, iter_12_3)
						table.insert(var_12_5, iter_12_3)

						var_12_3 = var_12_3 or iter_12_4 ~= 0

						break
					end
				end
			else
				var_12_9 = arg_12_3[1]

				table.remove(arg_12_3, 1)
				table.insert(var_12_5, 1)
			end

			if var_12_9 == 0 then
				var_12_4 = var_12_4 + 1
			end

			local var_12_11 = var_12_8 and cloneTplTo(arg_12_0.tfShipTpl, arg_12_1) or cloneTplTo(arg_12_0.tfEmptyTpl, arg_12_1)

			table.insert(var_12_6, var_12_11)
			setActive(var_12_11, true)

			if var_12_8 then
				updateShip(var_12_11, var_12_8)
				setActive(var_12_11:Find("event_block"), var_12_8:getFlag("inEvent"))

				var_12_1[var_12_8] = true
			else
				var_12_2 = var_12_2 + 1
			end

			local var_12_12 = findTF(var_12_11, "icon_bg")

			setActive(var_12_11:Find("ship_type"), true)

			if type(var_12_9) == "number" then
				if var_12_9 ~= 0 then
					setImageSprite(var_12_11:Find("ship_type"), GetSpriteFromAtlas("shiptype", ShipType.Type2CNLabel(var_12_9)), true)
				else
					setActive(var_12_11:Find("ship_type"), false)
				end
			elseif type(var_12_9) == "string" then
				setImageSprite(var_12_11:Find("ship_type"), GetSpriteFromAtlas("shiptype", ShipType.BundleType2CNLabel(var_12_9)), true)
			end

			setActive(var_12_11:Find("ship_type"), not var_12_8 and var_12_9 ~= 0)
			table.sort(_.map(var_12_0, function(arg_14_0)
				return arg_12_0.parent.shipVOs[arg_14_0]
			end), function(arg_15_0, arg_15_1)
				return var_0_1[arg_15_0:getTeamType()] < var_0_1[arg_15_1:getTeamType()] or var_0_1[arg_15_0:getTeamType()] == var_0_1[arg_15_1:getTeamType()] and table.indexof(var_12_0, arg_15_0.id) < table.indexof(var_12_0, arg_15_1.id)
			end)

			local var_12_13 = GetOrAddComponent(var_12_12, typeof(UILongPressTrigger))

			var_12_13.onReleased:RemoveAllListeners()
			var_12_13.onLongPressed:RemoveAllListeners()
			var_12_13.onReleased:AddListener(function()
				arg_12_0.onClick({
					shipType = var_12_9,
					fleet = var_12_1,
					chapter = arg_12_0.chapter,
					shipVO = var_12_8,
					fleetIndex = arg_12_4,
					teamType = arg_12_2
				})

				return
			end)
			var_12_13.onLongPressed:AddListener(function()
				if not var_12_8 then
					arg_12_0.onClick({
						shipType = var_12_9,
						fleet = var_12_1,
						chapter = arg_12_0.chapter,
						shipVO = var_12_8,
						fleetIndex = arg_12_4,
						teamType = arg_12_2
					})
				else
					arg_12_0.onLongPressed({
						shipId = var_12_8.id,
						shipVOs = var_0,
						chapter = arg_12_0.chapter
					})
				end

				return
			end)
		end
	end

	for iter_12_5 = 3, 1, -1 do
		var_12_6[iter_12_5]:SetSiblingIndex(var_12_5[iter_12_5] - 1)
	end

	if (var_12_3 == true or var_12_4 == 3) and var_12_2 ~= 3 then
		return true
	else
		return false
	end

	return
end

function var_0_0.initCommander(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_3:getEliteFleetCommanders()[arg_18_1]

	for iter_18_0 = 1, 2 do
		local var_18_1

		if var_18_0[iter_18_0] then
			var_18_1 = getProxy(CommanderProxy):getCommanderById(var_18_0[iter_18_0])
		end

		local var_18_2 = arg_18_2:Find("pos" .. iter_18_0)
		local var_18_3 = var_18_2:Find("add")
		local var_18_4 = var_18_2:Find("info")

		setActive(var_18_3, not var_18_1)
		setActive(var_18_4, var_18_1)

		if var_18_1 then
			setImageSprite(var_18_4:Find("frame"), GetSpriteFromAtlas("weaponframes", "commander_" .. Commander.rarity2Frame(var_18_1:getRarity())))
			GetImageSpriteFromAtlasAsync("CommanderHrz/" .. var_18_1:getPainting(), "", var_18_4:Find("mask/icon"))
		end

		local var_18_5 = arg_18_3:wrapEliteFleet(arg_18_1)

		onButton(arg_18_0, var_18_3, function()
			arg_18_0.parent:openCommanderPanel(var_18_5, arg_18_3.id, arg_18_1)

			return
		end, SFX_PANEL)
		onButton(arg_18_0, var_18_4, function()
			arg_18_0.parent:openCommanderPanel(var_18_5, arg_18_3.id, arg_18_1)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.updateFleets(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0.tfFleets[FleetType.Normal]) do
		local var_21_0 = iter_21_1:Find("btn_clear")
		local var_21_1 = iter_21_1:Find("btn_recom")
		local var_21_2 = iter_21_1:Find("blank")
		local var_21_3 = iter_21_1:Find("commander")

		setActive(iter_21_1:Find("btn_select"), false)
		setActive(findTF(iter_21_1, "selected"), false)

		local var_21_4 = iter_21_0 <= arg_21_0.chapter:getConfig("group_num")

		setActive(findTF(iter_21_1, TeamType.Main), var_21_4)
		setActive(findTF(iter_21_1, TeamType.Vanguard), var_21_4)
		setActive(var_21_0, var_21_4 and not arg_21_0.contextData.EditingCommander)
		setActive(var_21_1, var_21_4 and not arg_21_0.contextData.EditingCommander)
		setActive(var_21_2, not var_21_4)
		setActive(var_21_3, var_21_4 and arg_21_0.contextData.EditingCommander)

		local var_21_6 = iter_21_1:Find("bg/name")

		if var_21_4 then
			local var_21_7 = Fleet.DEFAULT_NAME[iter_21_0] or ""

			var_21_5(var_21_6, var_21_7)

			if var_21_4 then
				local var_21_8 = arg_21_0:initAddButton(iter_21_1:Find(TeamType.Main), TeamType.Main, arg_21_0.typeLimitations[iter_21_0][1], iter_21_0)
				local var_21_9 = arg_21_0:initAddButton(iter_21_1:Find(TeamType.Vanguard), TeamType.Vanguard, arg_21_0.typeLimitations[iter_21_0][2], iter_21_0)

				arg_21_0:initCommander(iter_21_0, var_21_3, arg_21_0.chapter)

				if var_21_8 and var_21_9 then
					setActive(iter_21_1:Find("selected"), true)
				end

				onButton(arg_21_0, var_21_0, function()
					if #arg_21_0.eliteFleetList[iter_21_0] ~= 0 then
						pg.MsgboxMgr.GetInstance():ShowMsgBox({
							content = i18n("battle_preCombatLayer_clear_confirm"),
							onYes = function()
								arg_21_0.onEliteClear({
									index = iter_21_0,
									chapterVO = arg_21_0.chapter
								})

								return
							end
						})
					end

					return
				end)
				onButton(arg_21_0, var_21_1, function()
					if #arg_21_0.eliteFleetList[iter_21_0] ~= 6 then
						if #arg_21_0.eliteFleetList[iter_21_0] ~= 0 then
							pg.MsgboxMgr.GetInstance():ShowMsgBox({
								content = i18n("battle_preCombatLayer_auto_confirm"),
								onYes = function()
									arg_21_0.onEliteRecommend({
										index = iter_21_0,
										chapterVO = arg_21_0.chapter
									})

									return
								end
							})
						else
							arg_21_0.onEliteRecommend({
								index = iter_21_0,
								chapterVO = arg_21_0.chapter
							})
						end
					end

					return
				end)
			end
		end
	end

	for iter_21_2, iter_21_3 in ipairs(arg_21_0.tfFleets[FleetType.Submarine]) do
		local var_21_10 = iter_21_2 + 2
		local var_21_11 = iter_21_3:Find("btn_clear")
		local var_21_12 = iter_21_3:Find("btn_recom")
		local var_21_13 = iter_21_3:Find("blank")
		local var_21_14 = iter_21_3:Find("commander")

		setActive(iter_21_3:Find("btn_select"), false)
		setActive(findTF(iter_21_3, "selected"), false)
		setActive(findTF(iter_21_3, TeamType.Submarine), iter_21_2 <= arg_21_0.chapter:getConfig("submarine_num"))
		setActive(var_21_11, iter_21_2 <= arg_21_0.chapter:getConfig("submarine_num") and not arg_21_0.contextData.EditingCommander)
		setActive(var_21_12, iter_21_2 <= arg_21_0.chapter:getConfig("submarine_num") and not arg_21_0.contextData.EditingCommander)
		setActive(var_21_13, iter_21_2 > arg_21_0.chapter:getConfig("submarine_num"))
		setActive(var_21_14, iter_21_2 <= arg_21_0.chapter:getConfig("submarine_num") and arg_21_0.contextData.EditingCommander)

		local var_21_16 = iter_21_3:Find("bg/name")

		if iter_21_2 <= arg_21_0.chapter:getConfig("submarine_num") then
			local var_21_17 = Fleet.DEFAULT_NAME[Fleet.SUBMARINE_FLEET_ID + iter_21_2 - 1] or ""

			var_21_15(var_21_16, var_21_17)
			arg_21_0:initCommander(var_21_10, var_21_14, arg_21_0.chapter)

			if iter_21_2 <= arg_21_0.chapter:getConfig("submarine_num") then
				if arg_21_0:initAddButton(iter_21_3:Find(TeamType.Main), TeamType.Submarine, {
					0,
					0,
					0
				}, var_21_10) then
					setActive(iter_21_3:Find("selected"), true)
				end

				onButton(arg_21_0, var_21_11, function()
					if #arg_21_0.eliteFleetList[var_21_10] ~= 0 then
						pg.MsgboxMgr.GetInstance():ShowMsgBox({
							content = i18n("battle_preCombatLayer_clear_confirm"),
							onYes = function()
								arg_21_0.onEliteClear({
									index = var_21_10,
									chapterVO = arg_21_0.chapter
								})

								return
							end
						})
					end

					return
				end)
				onButton(arg_21_0, var_21_12, function()
					if #arg_21_0.eliteFleetList[var_21_10] ~= 3 then
						if #arg_21_0.eliteFleetList[var_21_10] ~= 0 then
							pg.MsgboxMgr.GetInstance():ShowMsgBox({
								content = i18n("battle_preCombatLayer_auto_confirm"),
								onYes = function()
									arg_21_0.onEliteRecommend({
										index = var_21_10,
										chapterVO = arg_21_0.chapter
									})

									return
								end
							})
						else
							arg_21_0.onEliteRecommend({
								index = var_21_10,
								chapterVO = arg_21_0.chapter
							})
						end
					end

					return
				end)
			end
		end
	end

	return
end

return var_0_0
