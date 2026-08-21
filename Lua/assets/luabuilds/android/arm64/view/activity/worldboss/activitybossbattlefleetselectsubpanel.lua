local var_0_0 = class("ActivityBossBattleFleetSelectSubPanel", import("view.base.BaseSubPanel"))

function var_0_0.getUIName(arg_1_0)
	return "ActivityBossFleetSelectView"
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
		arg_4_0:OnCombat()

		return
	end, SFX_UI_WEIGHANCHOR_GO)
	onButton(arg_4_0, arg_4_0.btnTry, function()
		arg_4_0:OnTrybat()

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
	onToggle(arg_4_0, arg_4_0.commanderToggle, function(arg_9_0)
		if arg_9_0 then
			arg_4_0.viewParent.contextData.showCommander = arg_9_0

			for iter_9_0, iter_9_1 in pairs(arg_4_0.tfFleets) do
				for iter_9_2 = 1, #iter_9_1 do
					arg_4_0:updateCommanderBtn(iter_9_0, iter_9_2)
				end
			end
		end

		return
	end, SFX_PANEL)
	onToggle(arg_4_0, arg_4_0.formationToggle, function(arg_10_0)
		if arg_10_0 then
			arg_4_0.viewParent.contextData.showCommander = not arg_10_0

			for iter_10_0, iter_10_1 in pairs(arg_4_0.tfFleets) do
				for iter_10_2 = 1, #iter_10_1 do
					arg_4_0:updateCommanderBtn(iter_10_0, iter_10_2)
				end
			end
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SetFleets(arg_11_0, arg_11_1)
	arg_11_0.fleets = {
		[FleetType.Normal] = {},
		[FleetType.Submarine] = {}
	}

	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		iter_11_1:RemoveUnusedItems()

		if iter_11_1:isSubmarineFleet() then
			if #arg_11_0.fleets[FleetType.Submarine] < arg_11_0:getLimitNums(FleetType.Submarine) then
				table.insert(arg_11_0.fleets[FleetType.Submarine], iter_11_1)
			end
		elseif #arg_11_0.fleets[FleetType.Normal] < arg_11_0:getLimitNums(FleetType.Normal) then
			table.insert(arg_11_0.fleets[FleetType.Normal], iter_11_1)
		end
	end

	return
end

function var_0_0.SetOilLimit(arg_12_0, arg_12_1)
	local var_12_0 = _.any(arg_12_1, function(arg_13_0)
		return arg_13_0 > 0
	end)

	setActive(arg_12_0.rtCostLimit, var_12_0)
	setText(arg_12_0.rtCostLimit:Find("text"), i18n("formationScene_use_oil_limit_tip_worldboss"))

	if var_12_0 then
		local var_12_2 = arg_12_1[1]

		setActive(arg_12_0.rtCostLimit:Find("cost_noraml/Text"), arg_12_1[1] > 0)

		local var_12_3, var_12_4

		if var_12_2 > 0 then
			setText(arg_12_0.rtCostLimit:Find("cost_noraml/Text"), string.format("%s(%d)", i18n("formationScene_use_oil_limit_surface"), var_12_2))

			var_12_3 = setActive
			var_12_4 = arg_12_0.rtCostLimit:Find("cost_boss/Text")
		end

		var_12_3(var_12_4, 0 > 0)

		local var_12_5 = arg_12_1[2]

		setActive(arg_12_0.rtCostLimit:Find("cost_sub/Text"), arg_12_1[2] > 0)

		if var_12_5 > 0 then
			setText(arg_12_0.rtCostLimit:Find("cost_sub/Text"), string.format("%s(%d)", i18n("formationScene_use_oil_limit_submarine"), var_12_5))
		end
	end

	return
end

function var_0_0.SetSettings(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_0.groupNum = arg_14_1
	arg_14_0.submarineNum = arg_14_2
	arg_14_0.showTryBtn = arg_14_3

	return
end

function var_0_0.UpdateView(arg_15_0)
	arg_15_0:clearFleets()
	arg_15_0:UpdateFleets()

	local var_15_0 = not LOCK_COMMANDER and pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "CommanderCatMediator") or false

	if false then
		var_15_0 = true
	end

	if arg_15_0.viewParent.contextData.showCommander and var_15_0 then
		local var_15_2 = arg_15_0.commanderToggle or arg_15_0.formationToggle

		var_15_1(var_15_2, true)
		setActive(arg_15_0.commanderToggle, var_15_0)
		setActive(arg_15_0.btnTry, arg_15_0.showTryBtn)

		return
	end
end

function var_0_0.getLimitNums(arg_16_0, arg_16_1)
	local var_16_0 = 0

	if arg_16_1 == FleetType.Normal then
		var_16_0 = arg_16_0.groupNum
	elseif arg_16_1 == FleetType.Submarine then
		var_16_0 = arg_16_0.submarineNum
	end

	return var_16_0 or 0
end

function var_0_0.UpdateFleets(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.tfFleets) do
		for iter_17_2 = 1, #iter_17_1 do
			arg_17_0:updateFleet(iter_17_0, iter_17_2)
		end
	end

	return
end

function var_0_0.updateFleet(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0:updateCommanderBtn(arg_18_1, arg_18_2)

	local var_18_0 = arg_18_2 <= arg_18_0:getLimitNums(arg_18_1)
	local var_18_1 = var_18_0 and arg_18_0.fleets[arg_18_1][arg_18_2]
	local var_18_2 = findTF(arg_18_0.tfFleets[arg_18_1][arg_18_2], "bg/name")
	local var_18_3 = arg_18_0.tfFleets[arg_18_1][arg_18_2]:Find(TeamType.Main)
	local var_18_4 = arg_18_0.tfFleets[arg_18_1][arg_18_2]:Find(TeamType.Vanguard)
	local var_18_5 = arg_18_0.tfFleets[arg_18_1][arg_18_2]:Find(TeamType.Submarine)
	local var_18_6 = arg_18_0.tfFleets[arg_18_1][arg_18_2]:Find("btn_recom")
	local var_18_7 = arg_18_0.tfFleets[arg_18_1][arg_18_2]:Find("btn_clear")
	local var_18_8 = arg_18_0.tfFleets[arg_18_1][arg_18_2]:Find("commander")

	setActive(arg_18_0.tfFleets[arg_18_1][arg_18_2]:Find("selected"), false)
	setText(var_18_2, "")

	if var_18_3 then
		setActive(var_18_3, var_18_0 and var_18_1)
	end

	if var_18_4 then
		setActive(var_18_4, var_18_0 and var_18_1)
	end

	if var_18_5 then
		setActive(var_18_5, var_18_0 and var_18_1)
	end

	if var_18_0 and var_18_1 then
		local var_18_9 = Fleet.DEFAULT_NAME_BOSS_ACT[var_18_1.id] or ""

		setText(var_18_2, var_18_9)

		if arg_18_1 == FleetType.Submarine then
			arg_18_0:updateShips(var_18_5, var_18_1.subShips, var_18_1.id, TeamType.Submarine)
		else
			arg_18_0:updateShips(var_18_3, var_18_1.mainShips, var_18_1.id, TeamType.Main)
			arg_18_0:updateShips(var_18_4, var_18_1.vanguardShips, var_18_1.id, TeamType.Vanguard)
		end

		arg_18_0:updateCommanders(var_18_8, var_18_1)
		onButton(arg_18_0, var_18_6, function()
			arg_18_0:emit(arg_18_0.viewParent.contextData.mediatorClass.ON_FLEET_RECOMMEND, var_18_1.id)

			return
		end)
		onButton(arg_18_0, var_18_7, function()
			arg_18_0:emit(arg_18_0.viewParent.contextData.mediatorClass.ON_FLEET_CLEAR, var_18_1.id)

			return
		end, SFX_UI_CLICK)
	end

	return
end

function var_0_0.updateShips(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	removeAllChildren(arg_21_1)

	local var_21_0 = getProxy(BayProxy)

	for iter_21_0 = 1, 3 do
		local var_21_1 = var_21_0:getShipById(arg_21_2[iter_21_0])

		if var_21_1 then
			local var_21_2 = arg_21_0.tfShipTpl or arg_21_0.tfEmptyTpl
			local var_21_3 = cloneTplTo(var_21_2, arg_21_1)

			setActive(var_21_3, true)

			if var_21_1 then
				updateShip(var_21_3, var_21_1)
				setActive(var_21_3:Find("event_block"), var_21_1:getFlag("inEvent"))
			end

			setActive(var_21_3:Find("ship_type"), false)

			local var_21_4 = GetOrAddComponent(var_21_3, typeof(UILongPressTrigger))

			var_21_4.onLongPressed:RemoveAllListeners()
			onButton(arg_21_0, var_21_3, function()
				arg_21_0:emit(arg_21_0.viewParent.contextData.mediatorClass.ON_OPEN_DOCK, {
					fleet = arg_21_2,
					shipVO = var_21_1,
					fleetIndex = arg_21_3,
					teamType = arg_21_4
				})

				return
			end)
			var_21_4.onLongPressed:AddListener(function()
				if var_21_1 then
					arg_21_0:OnLongPressShip(arg_21_2[iter_21_0], arg_21_3)
				else
					var_0()
				end

				return
			end)
		end
	end

	return
end

function var_0_0.updateCommanderBtn(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_2 <= arg_24_0:getLimitNums(arg_24_1)
	local var_24_1 = var_24_0 and arg_24_0.fleets[arg_24_1][arg_24_2]
	local var_24_2 = arg_24_0.tfFleets[arg_24_1][arg_24_2]:Find("blank")

	setActive(arg_24_0.tfFleets[arg_24_1][arg_24_2]:Find("btn_select"), false)
	setActive(arg_24_0.tfFleets[arg_24_1][arg_24_2]:Find("btn_clear"), var_24_0 and not arg_24_0.viewParent.contextData.showCommander)
	setActive(arg_24_0.tfFleets[arg_24_1][arg_24_2]:Find("btn_recom"), var_24_0 and not arg_24_0.viewParent.contextData.showCommander)
	setActive(arg_24_0.tfFleets[arg_24_1][arg_24_2]:Find("commander"), var_24_0 and var_24_1 and arg_24_0.viewParent.contextData.showCommander)
	setActive(var_24_2, not var_24_0 or var_24_0 and not var_24_1 and arg_24_0.viewParent.contextData.showCommander)

	return
end

function var_0_0.updateCommanders(arg_25_0, arg_25_1, arg_25_2)
	for iter_25_0 = 1, 2 do
		local var_25_0 = arg_25_2:getCommanderByPos(iter_25_0)
		local var_25_1 = arg_25_1:Find("pos" .. iter_25_0)
		local var_25_2 = var_25_1:Find("add")
		local var_25_3 = var_25_1:Find("info")

		setActive(var_25_2, not var_25_0)
		setActive(var_25_3, var_25_0)

		if var_25_0 then
			setImageSprite(var_25_3:Find("frame"), GetSpriteFromAtlas("weaponframes", "commander_" .. Commander.rarity2Frame(var_25_0:getRarity())))
			GetImageSpriteFromAtlasAsync("CommanderHrz/" .. var_25_0:getPainting(), "", var_25_3:Find("mask/icon"))
		end

		onButton(arg_25_0, var_25_2, function()
			arg_25_0:InvokeParent("openCommanderPanel", arg_25_2, arg_25_2.id)

			return
		end, SFX_PANEL)
		onButton(arg_25_0, var_25_3, function()
			arg_25_0:InvokeParent("openCommanderPanel", arg_25_2, arg_25_2.id)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.clearFleets(arg_28_0)
	for iter_28_0, iter_28_1 in pairs(arg_28_0.tfFleets) do
		_.each(iter_28_1, function(arg_29_0)
			arg_28_0:clearFleet(arg_29_0)

			return
		end)
	end

	return
end

function var_0_0.clearFleet(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1:Find(TeamType.Main)
	local var_30_1 = arg_30_1:Find(TeamType.Vanguard)
	local var_30_2 = arg_30_1:Find(TeamType.Submarine)

	if var_30_0 then
		removeAllChildren(var_30_0)
	end

	if var_30_1 then
		removeAllChildren(var_30_1)
	end

	if var_30_2 then
		removeAllChildren(var_30_2)
	end

	return
end

function var_0_0.OnShow(arg_31_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_31_0._tf, {
		groupDelta = -1,
		groupName = "ActivityBossSceneTemplate"
	})

	return
end

function var_0_0.OnHide(arg_32_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_32_0._tf, arg_32_0.viewParent._tf)
	triggerToggle(arg_32_0.commanderToggle, false)

	return
end

function var_0_0.OnCancel(arg_33_0)
	arg_33_0:InvokeParent("hideFleetEdit")

	return
end

function var_0_0.OnCommit(arg_34_0)
	arg_34_0:InvokeParent("commitEdit")

	return
end

function var_0_0.OnCombat(arg_35_0)
	arg_35_0:InvokeParent("commitEdit")
	arg_35_0:InvokeParent("commitCombat")

	return
end

function var_0_0.OnTrybat(arg_36_0)
	arg_36_0:InvokeParent("commitEdit")
	arg_36_0:InvokeParent("commitTrybat")

	return
end

function var_0_0.OnLongPressShip(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0:InvokeParent("openShipInfo", arg_37_1, arg_37_2)

	return
end

return var_0_0
