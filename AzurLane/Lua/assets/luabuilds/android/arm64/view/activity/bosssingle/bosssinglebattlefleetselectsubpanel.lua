local var_0_0 = class("BossSingleBattleFleetSelectSubPanel", import("view.base.BaseSubPanel"))

function var_0_0.getUIName(arg_1_0)
	return "BossSingleFleetSelectView"
end

function var_0_0.InvokeParent(arg_2_0, arg_2_1, ...)
	if arg_2_0.viewParent then
		arg_2_0.viewParent[arg_2_1](arg_2_0.viewParent, ...)
	end

	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.tfShipTpl = arg_3_0._tf:Find("panel/shiptpl")
	arg_3_0.tfEmptyTpl = arg_3_0._tf:Find("panel/emptytpl")
	arg_3_0.tfFleets = {
		[FleetType.Normal] = {
			arg_3_0._tf:Find("panel/fleet/1"),
			arg_3_0._tf:Find("panel/fleet/2")
		},
		[FleetType.Submarine] = {
			arg_3_0._tf:Find("panel/sub/1")
		}
	}
	arg_3_0.tfLimit = arg_3_0._tf:Find("panel/limit_list/limit")
	arg_3_0.tfLimitTips = arg_3_0._tf:Find("panel/limit_list/limit_tip")
	arg_3_0.tfLimitElite = arg_3_0._tf:Find("panel/limit_list/limit_elite")

	setText(arg_3_0.tfLimitElite:Find("sub/Text"), i18n("ship_limit_notice"))

	arg_3_0.tfLimitContainer = arg_3_0._tf:Find("panel/limit_list/limit_elite/limit_list")
	arg_3_0.rtCostLimit = arg_3_0._tf:Find("panel/limit_list/cost_limit")
	arg_3_0.btnBack = arg_3_0._tf:Find("panel/btnBack")
	arg_3_0.btnGo = arg_3_0._tf:Find("panel/start_button")
	arg_3_0.btnTry = arg_3_0._tf:Find("panel/try_button")
	arg_3_0.btnASHelp = arg_3_0._tf:Find("panel/title/ASvalue")
	arg_3_0.commanderToggle = arg_3_0._tf:Find("panel/commander_btn")
	arg_3_0.formationToggle = arg_3_0._tf:Find("panel/formation_btn")
	arg_3_0.toggleMask = arg_3_0._tf:Find("mask")
	arg_3_0.toggleList = arg_3_0._tf:Find("mask/list")
	arg_3_0.toggles = {}

	for iter_3_0 = 0, arg_3_0.toggleList.childCount - 1 do
		table.insert(arg_3_0.toggles, arg_3_0.toggleList:Find("item" .. iter_3_0 + 1))
	end

	arg_3_0.btnSp = arg_3_0._tf:Find("panel/sp")
	arg_3_0.spMask = arg_3_0._tf:Find("mask_sp")

	setActive(arg_3_0.tfShipTpl, false)
	setActive(arg_3_0.tfEmptyTpl, false)
	setActive(arg_3_0.toggleMask, false)
	setActive(arg_3_0.btnSp, false)
	setActive(arg_3_0.spMask, false)
	setActive(arg_3_0.tfLimitElite, false)
	setActive(arg_3_0.tfLimitTips, false)
	setActive(arg_3_0.tfLimit, false)
	setActive(arg_3_0._tf:Find("panel/title/ASvalue"), false)
	setText(arg_3_0._tf:Find("panel/formation_btn/text"), i18n("autofight_formation"))
	setText(arg_3_0._tf:Find("panel/commander_btn/text"), i18n("autofight_cat"))
	setText(arg_3_0._tf:Find("panel/title/Image/text"), i18n("fleet_select_title"))
	arg_3_0:InitInteractable()

	return
end

function var_0_0.InitInteractable(arg_4_0)
	onButton(arg_4_0, arg_4_0.btnGo, function()
		local var_5_0, var_5_1 = arg_4_0:CheckValid()

		if var_5_0 then
			arg_4_0:OnCombat()
		else
			pg.TipsMgr.GetInstance():ShowTips(var_5_1)
		end

		return
	end, SFX_UI_WEIGHANCHOR_GO)
	onButton(arg_4_0, arg_4_0.btnBack, function()
		arg_4_0:OnCancel()
		arg_4_0:OnCommit()

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0._tf, function()
		arg_4_0:OnCancel()
		arg_4_0:OnCommit()

		return
	end, SFX_CANCEL)
	onToggle(arg_4_0, arg_4_0.commanderToggle, function(arg_8_0)
		if arg_8_0 then
			arg_4_0.viewParent.contextData.showCommander = arg_8_0

			for iter_8_0, iter_8_1 in pairs(arg_4_0.tfFleets) do
				for iter_8_2 = 1, #iter_8_1 do
					arg_4_0:updateCommanderBtn(iter_8_0, iter_8_2)
				end
			end
		end

		return
	end, SFX_PANEL)
	onToggle(arg_4_0, arg_4_0.formationToggle, function(arg_9_0)
		if arg_9_0 then
			arg_4_0.viewParent.contextData.showCommander = not arg_9_0

			for iter_9_0, iter_9_1 in pairs(arg_4_0.tfFleets) do
				for iter_9_2 = 1, #iter_9_1 do
					arg_4_0:updateCommanderBtn(iter_9_0, iter_9_2)
				end
			end
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SetFleets(arg_10_0, arg_10_1)
	arg_10_0.fleets = {
		[FleetType.Normal] = {},
		[FleetType.Submarine] = {}
	}

	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		iter_10_1:RemoveUnusedItems()

		if iter_10_1:isSubmarineFleet() then
			if #arg_10_0.fleets[FleetType.Submarine] < arg_10_0:getLimitNums(FleetType.Submarine) then
				table.insert(arg_10_0.fleets[FleetType.Submarine], iter_10_1)
			end
		elseif #arg_10_0.fleets[FleetType.Normal] < arg_10_0:getLimitNums(FleetType.Normal) then
			table.insert(arg_10_0.fleets[FleetType.Normal], iter_10_1)
		end
	end

	return
end

function var_0_0.SetOilLimit(arg_11_0, arg_11_1)
	local var_11_0 = _.any(arg_11_1, function(arg_12_0)
		return arg_12_0 > 0
	end)

	setActive(arg_11_0.rtCostLimit, var_11_0)
	setText(arg_11_0.rtCostLimit:Find("text"), i18n("formationScene_use_oil_limit_tip_worldboss"))

	if var_11_0 then
		local var_11_2 = arg_11_1[1]

		setActive(arg_11_0.rtCostLimit:Find("cost_noraml/Text"), arg_11_1[1] > 0)

		local var_11_3, var_11_4

		if var_11_2 > 0 then
			setText(arg_11_0.rtCostLimit:Find("cost_noraml/Text"), string.format("%s(%d)", i18n("formationScene_use_oil_limit_surface"), var_11_2))

			var_11_3 = setActive
			var_11_4 = arg_11_0.rtCostLimit:Find("cost_boss/Text")
		end

		var_11_3(var_11_4, 0 > 0)

		local var_11_5 = arg_11_1[2]

		setActive(arg_11_0.rtCostLimit:Find("cost_sub/Text"), arg_11_1[2] > 0)

		if var_11_5 > 0 then
			setText(arg_11_0.rtCostLimit:Find("cost_sub/Text"), string.format("%s(%d)", i18n("formationScene_use_oil_limit_submarine"), var_11_5))
		end
	end

	return
end

function var_0_0.SetSettings(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	arg_13_0.groupNum = arg_13_1
	arg_13_0.submarineNum = arg_13_2
	arg_13_0.showTryBtn = arg_13_3
	arg_13_0.propetyLimitation = arg_13_4
	arg_13_0.index = arg_13_5

	return
end

function var_0_0.UpdateView(arg_14_0)
	arg_14_0:clearFleets()
	arg_14_0:UpdateFleets()
	arg_14_0:updatePropetyLimit()

	local var_14_0 = not LOCK_COMMANDER and pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "CommanderCatMediator") or false

	if false then
		var_14_0 = true
	end

	if arg_14_0.viewParent.contextData.showCommander and var_14_0 then
		local var_14_2 = arg_14_0.commanderToggle or arg_14_0.formationToggle

		var_14_1(var_14_2, true)
		setActive(arg_14_0.commanderToggle, var_14_0)
		setActive(arg_14_0.btnTry, arg_14_0.showTryBtn)

		return
	end
end

function var_0_0.getLimitNums(arg_15_0, arg_15_1)
	local var_15_0 = 0

	if arg_15_1 == FleetType.Normal then
		var_15_0 = arg_15_0.groupNum
	elseif arg_15_1 == FleetType.Submarine then
		var_15_0 = arg_15_0.submarineNum
	end

	return var_15_0 or 0
end

function var_0_0.UpdateFleets(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.tfFleets) do
		for iter_16_2 = 1, #iter_16_1 do
			arg_16_0:updateFleet(iter_16_0, iter_16_2)
		end
	end

	return
end

function var_0_0.updateFleet(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:updateCommanderBtn(arg_17_1, arg_17_2)

	local var_17_0 = arg_17_2 <= arg_17_0:getLimitNums(arg_17_1)
	local var_17_1 = var_17_0 and arg_17_0.fleets[arg_17_1][arg_17_2]
	local var_17_2 = findTF(arg_17_0.tfFleets[arg_17_1][arg_17_2], "bg/name")
	local var_17_3 = arg_17_0.tfFleets[arg_17_1][arg_17_2]:Find(TeamType.Main)
	local var_17_4 = arg_17_0.tfFleets[arg_17_1][arg_17_2]:Find(TeamType.Vanguard)
	local var_17_5 = arg_17_0.tfFleets[arg_17_1][arg_17_2]:Find(TeamType.Submarine)
	local var_17_6 = arg_17_0.tfFleets[arg_17_1][arg_17_2]:Find("btn_recom")
	local var_17_7 = arg_17_0.tfFleets[arg_17_1][arg_17_2]:Find("btn_clear")
	local var_17_8 = arg_17_0.tfFleets[arg_17_1][arg_17_2]:Find("commander")

	setActive(arg_17_0.tfFleets[arg_17_1][arg_17_2]:Find("selected"), false)
	setText(var_17_2, "")

	if var_17_3 then
		setActive(var_17_3, var_17_0 and var_17_1)
	end

	if var_17_4 then
		setActive(var_17_4, var_17_0 and var_17_1)
	end

	if var_17_5 then
		setActive(var_17_5, var_17_0 and var_17_1)
	end

	if arg_17_0.viewParent.contextData.bossActivity:getConfig("type") == ActivityConst.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE then
		local var_17_9 = Fleet.DEFAULT_NAME_BOSS_SINGLE_VARIABLE_ACT or Fleet.DEFAULT_NAME_BOSS_SINGLE_ACT

		if var_17_0 and var_17_1 then
			local var_17_10 = var_17_9[var_17_1.id] or ""

			setText(var_17_2, var_17_10)

			if arg_17_1 == FleetType.Submarine then
				arg_17_0:updateShips(var_17_5, var_17_1.subShips, var_17_1.id, TeamType.Submarine)
			else
				arg_17_0:updateShips(var_17_3, var_17_1.mainShips, var_17_1.id, TeamType.Main)
				arg_17_0:updateShips(var_17_4, var_17_1.vanguardShips, var_17_1.id, TeamType.Vanguard)
			end

			arg_17_0:updateCommanders(var_17_8, var_17_1)
			onButton(arg_17_0, var_17_6, function()
				arg_17_0:emit(arg_17_0.viewParent.contextData.mediatorClass.ON_FLEET_RECOMMEND, var_17_1.id)

				return
			end)
			onButton(arg_17_0, var_17_7, function()
				arg_17_0:emit(arg_17_0.viewParent.contextData.mediatorClass.ON_FLEET_CLEAR, var_17_1.id)

				return
			end, SFX_UI_CLICK)
		end

		return
	end
end

function var_0_0.updateShips(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	removeAllChildren(arg_20_1)

	local var_20_0 = getProxy(BayProxy)

	for iter_20_0 = 1, 3 do
		local var_20_1 = var_20_0:getShipById(arg_20_2[iter_20_0])

		if var_20_1 then
			local var_20_2 = arg_20_0.tfShipTpl or arg_20_0.tfEmptyTpl
			local var_20_3 = cloneTplTo(var_20_2, arg_20_1)

			setActive(var_20_3, true)

			if var_20_1 then
				updateShip(var_20_3, var_20_1)
				setActive(var_20_3:Find("event_block"), var_20_1:getFlag("inEvent"))
			end

			setActive(var_20_3:Find("ship_type"), false)

			local var_20_4 = GetOrAddComponent(var_20_3, typeof(UILongPressTrigger))

			var_20_4.onLongPressed:RemoveAllListeners()
			onButton(arg_20_0, var_20_3, function()
				arg_20_0:emit(arg_20_0.viewParent.contextData.mediatorClass.ON_OPEN_DOCK, {
					fleet = arg_20_2,
					shipVO = var_20_1,
					fleetIndex = arg_20_3,
					teamType = arg_20_4
				})

				return
			end)
			var_20_4.onLongPressed:AddListener(function()
				if var_20_1 then
					arg_20_0:OnLongPressShip(arg_20_2[iter_20_0], arg_20_3)
				else
					var_0()
				end

				return
			end)
		end
	end

	return
end

function var_0_0.updateCommanderBtn(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_2 <= arg_23_0:getLimitNums(arg_23_1)
	local var_23_1 = var_23_0 and arg_23_0.fleets[arg_23_1][arg_23_2]
	local var_23_2 = arg_23_0.tfFleets[arg_23_1][arg_23_2]:Find("blank")

	setActive(arg_23_0.tfFleets[arg_23_1][arg_23_2]:Find("btn_select"), false)
	setActive(arg_23_0.tfFleets[arg_23_1][arg_23_2]:Find("btn_clear"), var_23_0 and not arg_23_0.viewParent.contextData.showCommander)
	setActive(arg_23_0.tfFleets[arg_23_1][arg_23_2]:Find("btn_recom"), var_23_0 and not arg_23_0.viewParent.contextData.showCommander)
	setActive(arg_23_0.tfFleets[arg_23_1][arg_23_2]:Find("commander"), var_23_0 and var_23_1 and arg_23_0.viewParent.contextData.showCommander)
	setActive(var_23_2, not var_23_0 or var_23_0 and not var_23_1 and arg_23_0.viewParent.contextData.showCommander)

	return
end

function var_0_0.updateCommanders(arg_24_0, arg_24_1, arg_24_2)
	for iter_24_0 = 1, 2 do
		local var_24_0 = arg_24_2:getCommanderByPos(iter_24_0)
		local var_24_1 = arg_24_1:Find("pos" .. iter_24_0)
		local var_24_2 = var_24_1:Find("add")
		local var_24_3 = var_24_1:Find("info")

		setActive(var_24_2, not var_24_0)
		setActive(var_24_3, var_24_0)

		if var_24_0 then
			setImageSprite(var_24_3:Find("frame"), GetSpriteFromAtlas("weaponframes", "commander_" .. Commander.rarity2Frame(var_24_0:getRarity())))
			GetImageSpriteFromAtlasAsync("CommanderHrz/" .. var_24_0:getPainting(), "", var_24_3:Find("mask/icon"))
		end

		onButton(arg_24_0, var_24_2, function()
			arg_24_0:InvokeParent("openCommanderPanel", arg_24_2, arg_24_2.id)

			return
		end, SFX_PANEL)
		onButton(arg_24_0, var_24_3, function()
			arg_24_0:InvokeParent("openCommanderPanel", arg_24_2, arg_24_2.id)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.clearFleets(arg_27_0)
	for iter_27_0, iter_27_1 in pairs(arg_27_0.tfFleets) do
		_.each(iter_27_1, function(arg_28_0)
			arg_27_0:clearFleet(arg_28_0)

			return
		end)
	end

	return
end

function var_0_0.clearFleet(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1:Find(TeamType.Main)
	local var_29_1 = arg_29_1:Find(TeamType.Vanguard)
	local var_29_2 = arg_29_1:Find(TeamType.Submarine)

	if var_29_0 then
		removeAllChildren(var_29_0)
	end

	if var_29_1 then
		removeAllChildren(var_29_1)
	end

	if var_29_2 then
		removeAllChildren(var_29_2)
	end

	return
end

function var_0_0.updatePropetyLimit(arg_30_0)
	setActive(arg_30_0.toggleMask, false)
	setActive(arg_30_0.tfLimit, false)
	setActive(arg_30_0.tfLimitTips, false)
	setActive(arg_30_0.tfLimitElite, #arg_30_0.propetyLimitation > 0)

	if #arg_30_0.propetyLimitation > 0 then
		local var_30_0 = UIItemList.New(arg_30_0.tfLimitContainer, arg_30_0.tfLimitContainer:GetChild(0))
		local var_30_1, var_30_2 = arg_30_0:IsPropertyLimitationSatisfy()

		var_30_0:make(function(arg_31_0, arg_31_1, arg_31_2)
			arg_31_1 = arg_31_1 + 1

			if arg_31_0 == UIItemList.EventUpdate then
				local var_31_0, var_31_1, var_31_2, var_31_3 = unpack(arg_30_0.propetyLimitation[arg_31_1])

				if var_30_1[arg_31_1] == 1 then
					arg_31_2:Find("Text"):GetComponent(typeof(Text)).color = Color.New(1, 0.9607843137254902, 0.5019607843137255)
				else
					local var_31_4 = arg_31_2:Find("Text")

					var_31_4:GetComponent(typeof(Text)).color = Color.New(0.9568627450980393, 0.30196078431372547, 0.30196078431372547)
				end

				setActive(arg_31_2, true)
				setText(arg_31_2:Find("Text"), AttributeType.EliteCondition2Name(var_31_0, var_31_3) .. AttributeType.eliteConditionCompareTip(var_31_1) .. var_31_2)
			end

			return
		end)
		var_30_0:align(#arg_30_0.propetyLimitation)
	end

	return
end

function var_0_0.OnShow(arg_32_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_32_0._tf)

	return
end

function var_0_0.OnHide(arg_33_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_33_0._tf, arg_33_0.viewParent._tf)
	triggerToggle(arg_33_0.commanderToggle, false)

	return
end

function var_0_0.OnCancel(arg_34_0)
	arg_34_0:InvokeParent("hideFleetEdit")

	return
end

function var_0_0.OnCommit(arg_35_0)
	arg_35_0:InvokeParent("commitEdit")

	return
end

function var_0_0.OnCombat(arg_36_0)
	arg_36_0:InvokeParent("commitEdit")
	arg_36_0:InvokeParent("commitCombat")

	return
end

function var_0_0.OnLongPressShip(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0:InvokeParent("openShipInfo", arg_37_1, arg_37_2)

	return
end

function var_0_0.IsPropertyLimitationSatisfy(arg_38_0)
	local var_38_0 = getProxy(BayProxy):getRawData()
	local var_38_1 = {}

	for iter_38_0, iter_38_1 in ipairs(arg_38_0.propetyLimitation) do
		var_38_1[iter_38_1[1]] = 0
	end

	local var_38_2 = 0

	for iter_38_2 = 1, 2 do
		if arg_38_0.fleets[FleetType.Normal][iter_38_2] then
			for iter_38_3, iter_38_4 in pairs(arg_38_0.fleets[FleetType.Normal][iter_38_2].mainShips) do
				table.insert({}, iter_38_4)
			end

			for iter_38_5, iter_38_6 in pairs(arg_38_0.fleets[FleetType.Normal][iter_38_2].vanguardShips) do
				table.insert({}, iter_38_6)
			end
		end
	end

	for iter_38_7, iter_38_8 in ipairs(arg_38_0.propetyLimitation) do
		local var_38_3, var_38_4, var_38_5, var_38_6 = unpack(iter_38_8)

		if string.sub(var_38_3, 1, 5) == "fleet" then
			({})[var_38_3] = 0
			;({})[var_38_3] = var_38_6
		end
	end

	for iter_38_9, iter_38_10 in ipairs({}) do
		var_38_2 = var_38_2 + 1

		local var_38_7 = intProperties(var_38_0[iter_38_10]:getProperties())

		for iter_38_11, iter_38_12 in pairs(var_38_1) do
			if string.sub(iter_38_11, 1, 5) == "fleet" then
				if iter_38_11 == "fleet_totle_level" then
					({})[iter_38_11] = ({})[iter_38_11] + var_38_0[iter_38_10].level
				end
			else
				var_38_1[iter_38_11] = iter_38_11 == "level" and iter_38_12 + var_38_0[iter_38_10].level or iter_38_12 + var_38_7[iter_38_11]
			end
		end
	end

	for iter_38_13, iter_38_14 in pairs({}) do
		if iter_38_13 == "fleet_totle_level" and iter_38_14 > ({})[iter_38_13] then
			var_38_1[iter_38_13] = var_38_1[iter_38_13] + 1
		end
	end

	local var_38_8 = {}

	for iter_38_15, iter_38_16 in ipairs(arg_38_0.propetyLimitation) do
		local var_38_9, var_38_10, var_38_11 = unpack(iter_38_16)

		if var_38_9 == "level" and var_38_2 > 0 then
			var_38_1[var_38_9] = math.ceil(var_38_1[var_38_9] / var_38_2)
		end

		var_38_8[iter_38_15] = AttributeType.EliteConditionCompare(var_38_10, var_38_1[var_38_9], var_38_11) and 1 or 0
	end

	return var_38_8, var_38_1
end

function var_0_0.CheckValid(arg_39_0)
	local var_39_0, var_39_1 = arg_39_0.viewParent.contextData.bossActivity:CheckCntByIdx(arg_39_0.index)

	if not var_39_0 then
		return var_39_0, var_39_1
	end

	local var_39_2, var_39_3 = arg_39_0:IsPropertyLimitationSatisfy()
	local var_39_4 = 1

	for iter_39_0, iter_39_1 in ipairs(var_39_2) do
		var_39_4 = var_39_4 * iter_39_1
	end

	if var_39_4 ~= 1 then
		local var_39_6 = i18n("elite_disable_property_unsatisfied")

		return
	end

	return true
end

return var_0_0
