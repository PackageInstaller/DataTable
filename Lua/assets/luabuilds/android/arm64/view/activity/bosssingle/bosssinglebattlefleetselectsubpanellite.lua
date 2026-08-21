local var_0_0 = class("BossSingleBattleFleetSelectSubPanelLite", import("view.base.BaseSubPanel"))

function var_0_0.getUIName(arg_1_0)
	return "BossSingleFleetSelectView"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.tfShipTpl = arg_2_0._tf:Find("panel/shiptpl")
	arg_2_0.tfEmptyTpl = arg_2_0._tf:Find("panel/emptytpl")
	arg_2_0.tfFleets = {
		[FleetType.Normal] = {
			arg_2_0._tf:Find("panel/fleet/1"),
			arg_2_0._tf:Find("panel/fleet/2")
		},
		[FleetType.Submarine] = {
			arg_2_0._tf:Find("panel/sub/1")
		}
	}
	arg_2_0.limitList = arg_2_0._tf:Find("panel/limit_list")
	arg_2_0.btnBack = arg_2_0._tf:Find("panel/btnBack")
	arg_2_0.btnGo = arg_2_0._tf:Find("panel/start_button")
	arg_2_0.btnTry = arg_2_0._tf:Find("panel/try_button")
	arg_2_0.btnASHelp = arg_2_0._tf:Find("panel/title/ASvalue")
	arg_2_0.commanderToggle = arg_2_0._tf:Find("panel/commander_btn")
	arg_2_0.formationToggle = arg_2_0._tf:Find("panel/formation_btn")
	arg_2_0.toggleMask = arg_2_0._tf:Find("mask")
	arg_2_0.toggleList = arg_2_0._tf:Find("mask/list")
	arg_2_0.toggles = {}

	for iter_2_0 = 0, arg_2_0.toggleList.childCount - 1 do
		table.insert(arg_2_0.toggles, arg_2_0.toggleList:Find("item" .. iter_2_0 + 1))
	end

	arg_2_0.btnSp = arg_2_0._tf:Find("panel/sp")
	arg_2_0.spMask = arg_2_0._tf:Find("mask_sp")

	setActive(arg_2_0.tfShipTpl, false)
	setActive(arg_2_0.tfEmptyTpl, false)
	setActive(arg_2_0.toggleMask, false)
	setActive(arg_2_0.btnSp, false)
	setActive(arg_2_0.spMask, false)
	setActive(arg_2_0.btnASHelp, false)
	setActive(arg_2_0.commanderToggle, false)
	setActive(arg_2_0.btnTry, false)
	setActive(arg_2_0.limitList, false)
	setText(arg_2_0._tf:Find("panel/formation_btn/text"), i18n("autofight_formation"))
	setText(arg_2_0._tf:Find("panel/commander_btn/text"), i18n("autofight_cat"))
	setText(arg_2_0._tf:Find("panel/title/Image/text"), i18n("fleet_select_title"))
	arg_2_0:InitInteractable()

	return
end

function var_0_0.InitInteractable(arg_3_0)
	onButton(arg_3_0, arg_3_0.btnGo, function()
		arg_3_0:OnCombat()
		arg_3_0:OnHide()

		return
	end, SFX_UI_WEIGHANCHOR_GO)
	onButton(arg_3_0, arg_3_0.btnBack, function()
		arg_3_0:OnHide()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:OnHide()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.toggleMask, function()
		arg_3_0:hideToggleMask()

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.SetFleets(arg_8_0, arg_8_1)
	arg_8_0.selectIds = {
		[FleetType.Normal] = {
			1
		},
		[FleetType.Submarine] = {}
	}
	arg_8_0.fleets = _(_.values(arg_8_1)):chain():filter(function(arg_9_0)
		return arg_9_0:isRegularFleet()
	end):sort(function(arg_10_0, arg_10_1)
		return arg_10_0.id < arg_10_1.id
	end):value()

	return
end

function var_0_0.SetSettings(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	arg_11_0.groupNum = arg_11_1
	arg_11_0.submarineNum = arg_11_2
	arg_11_0.stageID = arg_11_3
	arg_11_0.system = arg_11_4
	arg_11_0.actID = arg_11_5

	return
end

function var_0_0.UpdateView(arg_12_0)
	arg_12_0:clearFleets()
	arg_12_0:UpdateFleets()

	return
end

function var_0_0.getLimitNums(arg_13_0, arg_13_1)
	local var_13_0 = 0

	if arg_13_1 == FleetType.Normal then
		var_13_0 = arg_13_0.groupNum
	elseif arg_13_1 == FleetType.Submarine then
		var_13_0 = arg_13_0.submarineNum
	end

	return var_13_0 or 0
end

function var_0_0.UpdateFleets(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.tfFleets) do
		for iter_14_2 = 1, #iter_14_1 do
			arg_14_0:updateFleet(iter_14_0, iter_14_2)
		end
	end

	return
end

function var_0_0.showToggleMask(arg_15_0, arg_15_1, arg_15_2)
	setActive(arg_15_0.toggleMask, true)

	local var_15_0 = _.filter(arg_15_0.fleets, function(arg_16_0)
		return arg_16_0:getFleetType() == arg_15_1
	end)

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.toggles) do
		local var_15_1 = var_15_0[iter_15_0]

		setActive(iter_15_1, var_15_0[iter_15_0])

		if var_15_0[iter_15_0] then
			local var_15_2 = iter_15_1:GetComponent(typeof(Toggle))
			local var_15_3 = iter_15_1:Find("lock")
			local var_15_4, var_15_5 = var_15_0[iter_15_0]:isUnlock()

			setToggleEnabled(iter_15_1, var_15_4)
			setActive(var_15_3, not var_15_4)

			local var_15_6 = table.contains(arg_15_0.selectIds[arg_15_1], var_15_0[iter_15_0].id)

			setActive(iter_15_1:Find("on"), var_15_6)
			setActive(iter_15_1:Find("off"), not var_15_6)

			if var_15_4 then
				var_15_2.isOn = false

				onToggle(arg_15_0, iter_15_1, function(arg_17_0)
					if arg_17_0 then
						setActive(arg_15_0.toggleMask, false)
						arg_15_2(var_15_1.id)
					end

					return
				end, SFX_UI_TAG)
			else
				onButton(arg_15_0, var_15_3, function()
					pg.TipsMgr.GetInstance():ShowTips(var_15_5)

					return
				end, SFX_UI_CLICK)
			end
		end
	end

	return
end

function var_0_0.hideToggleMask(arg_19_0)
	setActive(arg_19_0.toggleMask, false)

	return
end

function var_0_0.updateFleet(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_2 <= arg_20_0:getLimitNums(arg_20_1)
	local var_20_1 = arg_20_0:getFleetById(arg_20_0.selectIds[arg_20_1][arg_20_2])
	local var_20_2 = findTF(arg_20_0.tfFleets[arg_20_1][arg_20_2], "bg/name")
	local var_20_3 = arg_20_0.tfFleets[arg_20_1][arg_20_2]:Find(TeamType.Main)
	local var_20_4 = arg_20_0.tfFleets[arg_20_1][arg_20_2]:Find(TeamType.Vanguard)
	local var_20_5 = arg_20_0.tfFleets[arg_20_1][arg_20_2]:Find(TeamType.Submarine)

	setActive(arg_20_0.tfFleets[arg_20_1][arg_20_2]:Find("btn_recom"), false)
	setActive(arg_20_0.tfFleets[arg_20_1][arg_20_2]:Find("btn_clear"), false)

	local var_20_6 = arg_20_0.tfFleets[arg_20_1][arg_20_2]:Find("btn_select")

	setActive(var_20_6, var_20_0)

	local var_20_7 = arg_20_0.tfFleets[arg_20_1][arg_20_2]:Find("commander")

	setActive(arg_20_0.tfFleets[arg_20_1][arg_20_2]:Find("selected"), false)
	setText(var_20_2, "")

	if var_20_3 then
		setActive(var_20_3, var_20_0 and var_20_1)
	end

	if var_20_4 then
		setActive(var_20_4, var_20_0 and var_20_1)
	end

	if var_20_5 then
		setActive(var_20_5, var_20_0 and var_20_1)
	end

	if var_20_0 and var_20_1 then
		local var_20_8 = var_20_1 and var_20_1:GetName() or ""

		setText(var_20_2, var_20_8)

		if arg_20_1 == FleetType.Submarine then
			arg_20_0:updateShips(var_20_5, var_20_1.subShips, var_20_1.id, TeamType.Submarine)
		else
			arg_20_0:updateShips(var_20_3, var_20_1.mainShips, var_20_1.id, TeamType.Main)
			arg_20_0:updateShips(var_20_4, var_20_1.vanguardShips, var_20_1.id, TeamType.Vanguard)
		end
	end

	onButton(arg_20_0, var_20_6, function()
		arg_20_0.toggleList.position = (var_20_6.position + var_0.position) / 2
		arg_20_0.toggleList.anchoredPosition = arg_20_0.toggleList.anchoredPosition + Vector2(-arg_20_0.toggleList.rect.width / 2, -var_20_6.rect.height / 2)

		arg_20_0:showToggleMask(arg_20_1, function(arg_22_0)
			arg_20_0:hideToggleMask()
			arg_20_0:selectFleet(arg_20_1, arg_20_2, arg_22_0)

			return
		end)

		return
	end, SFX_UI_CLICK)

	return
end

function var_0_0.getFleetById(arg_23_0, arg_23_1)
	return _.detect(arg_23_0.fleets, function(arg_24_0)
		return arg_24_0.id == arg_23_1
	end)
end

function var_0_0.updateShips(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	removeAllChildren(arg_25_1)

	local var_25_0 = getProxy(BayProxy)

	for iter_25_0 = 1, 3 do
		local var_25_1 = var_25_0:getShipById(arg_25_2[iter_25_0])

		if var_25_1 then
			local var_25_2 = cloneTplTo(var_25_1 and arg_25_0.tfShipTpl, arg_25_1)

			setActive(var_25_2, true)

			if var_25_1 then
				updateShip(var_25_2, var_25_1)
				setActive(var_25_2:Find("event_block"), false)
			end

			setActive(var_25_2:Find("ship_type"), false)
		end
	end

	return
end

function var_0_0.selectFleet(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	if arg_26_3 > 0 and table.contains(arg_26_0.selectIds[arg_26_1], arg_26_3) then
		return
	end

	if arg_26_1 == FleetType.Normal and arg_26_0:getLimitNums(arg_26_1) > 0 and arg_26_3 == 0 and #_.filter(arg_26_0.selectIds[arg_26_1], function(arg_27_0)
		return arg_27_0 > 0
	end) == 1 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("level_fleet_lease_one_ship"))

		return
	end

	local var_26_0 = arg_26_0:getFleetById(arg_26_3)

	if var_26_0 then
		if not var_26_0:isUnlock() then
			return
		end

		if var_26_0:isLegalToFight() ~= true then
			pg.TipsMgr.GetInstance():ShowTips(i18n("level_fleet_not_enough"))

			return
		end
	end

	arg_26_0.selectIds[arg_26_1][arg_26_2] = arg_26_3

	arg_26_0:updateFleet(arg_26_1, arg_26_2)

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
	pg.UIMgr.GetInstance():BlurPanel(arg_31_0._tf)
	setActive(arg_31_0._tf, true)

	return
end

function var_0_0.OnHide(arg_32_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_32_0._tf, arg_32_0.viewParent._tf)
	setActive(arg_32_0._tf, false)

	return
end

function var_0_0.OnCombat(arg_33_0)
	arg_33_0:emit(ActivityMediator.GO_SINGLE_PRECOMBAT, {
		system = arg_33_0.system,
		stageId = arg_33_0.stageID,
		activityID = arg_33_0.actID,
		fleets = {
			arg_33_0.fleets[arg_33_0.selectIds[FleetType.Normal][1]]
		}
	})

	return
end

return var_0_0
