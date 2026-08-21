local var_0_0 = class("ActivityFleetPanel", import("..level.LevelEliteFleetPanel"))

var_0_0.ON_OPEN_DOCK = "ActivityFleetPanel:ON_OPEN_DOCK"
var_0_0.ON_FLEET_RECOMMEND = "ActivityFleetPanel:ON_FLEET_RECOMMEND"
var_0_0.ON_FLEET_CLEAR = "ActivityFleetPanel:ON_FLEET_CLEAR"

function var_0_0.init(arg_1_0)
	var_0_0.super.init(arg_1_0)

	return
end

function var_0_0.set(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.groupNum = arg_2_1
	arg_2_0.submarineNum = arg_2_2

	setActive(arg_2_0.tfLimitElite, false)
	setActive(arg_2_0.tfLimitTips, false)
	setActive(arg_2_0.tfLimit, false)
	onButton(arg_2_0, arg_2_0.btnGo, function()
		if arg_2_0.onCombat then
			arg_2_0.onCombat()
		end

		return
	end, SFX_UI_WEIGHANCHOR_GO)
	onButton(arg_2_0, arg_2_0.btnBack, function()
		if arg_2_0.onCancel then
			arg_2_0.onCancel()
		end

		if arg_2_0.onCommit then
			arg_2_0.onCommit()
		end

		return
	end, SFX_CANCEL)
	onButton(arg_2_0, arg_2_0._tf, function()
		if arg_2_0.onCancel then
			arg_2_0.onCancel()
		end

		if arg_2_0.onCommit then
			arg_2_0.onCommit()
		end

		return
	end, SFX_CANCEL)
	onButton(arg_2_0, arg_2_0.toggleMask, function()
		arg_2_0:hideToggleMask()

		return
	end, SFX_CANCEL)
	onToggle(arg_2_0, arg_2_0.commanderBtn, function(arg_7_0)
		arg_2_0.parent.contextData.showCommander = arg_7_0

		for iter_7_0, iter_7_1 in pairs(arg_2_0.tfFleets) do
			for iter_7_2 = 1, #iter_7_1 do
				arg_2_0:updateCommanderBtn(iter_7_0, iter_7_2)
			end
		end

		return
	end, SFX_PANEL)
	triggerToggle(arg_2_0.commanderBtn, arg_2_0.parent.contextData.showCommander)
	setActive(arg_2_0.commanderBtn, arg_2_0.parent.openedCommanerSystem)
	arg_2_0:clearFleets()
	arg_2_0:updateFleets()

	return
end

function var_0_0.getLimitNums(arg_8_0, arg_8_1)
	local var_8_0 = 0

	if arg_8_1 == FleetType.Normal then
		var_8_0 = arg_8_0.groupNum
	elseif arg_8_1 == FleetType.Submarine then
		var_8_0 = arg_8_0.submarineNum
	end

	return var_8_0
end

function var_0_0.updateFleets(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.tfFleets) do
		for iter_9_2 = 1, #iter_9_1 do
			arg_9_0:updateFleet(iter_9_0, iter_9_2)
		end
	end

	return
end

function var_0_0.updateLimit(arg_10_0)
	return
end

function var_0_0.updateCommanderBtn(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2 <= arg_11_0:getLimitNums(arg_11_1)
	local var_11_1 = arg_11_0.fleets[arg_11_1][arg_11_2]
	local var_11_2 = arg_11_0.tfFleets[arg_11_1][arg_11_2]:Find("blank")
	local var_11_3 = arg_11_0.tfFleets[arg_11_1][arg_11_2]:Find("commander")

	setActive(arg_11_0.tfFleets[arg_11_1][arg_11_2]:Find("btn_select"), false)
	setActive(arg_11_0.tfFleets[arg_11_1][arg_11_2]:Find("btn_clear"), var_11_0 and not arg_11_0.parent.contextData.showCommander)
	setActive(arg_11_0.tfFleets[arg_11_1][arg_11_2]:Find("btn_recom"), var_11_0 and not arg_11_0.parent.contextData.showCommander)
	setActive(var_11_2, not var_11_0 or var_11_0 and not var_11_1 and arg_11_0.parent.contextData.showCommander)

	local var_11_4 = arg_11_0.parent.contextData.showCommander and var_11_0 and var_11_1

	setActive(var_11_3, var_11_4)

	return
end

function var_0_0.updateFleet(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:updateCommanderBtn(arg_12_1, arg_12_2)

	local var_12_0 = arg_12_0.fleets[arg_12_1][arg_12_2]
	local var_12_1 = arg_12_2 <= arg_12_0:getLimitNums(arg_12_1)
	local var_12_2 = findTF(arg_12_0.tfFleets[arg_12_1][arg_12_2], "bg/name")
	local var_12_3 = arg_12_0.tfFleets[arg_12_1][arg_12_2]:Find(TeamType.Main)
	local var_12_4 = arg_12_0.tfFleets[arg_12_1][arg_12_2]:Find(TeamType.Vanguard)
	local var_12_5 = arg_12_0.tfFleets[arg_12_1][arg_12_2]:Find(TeamType.Submarine)
	local var_12_6 = arg_12_0.tfFleets[arg_12_1][arg_12_2]:Find("btn_select")
	local var_12_7 = arg_12_0.tfFleets[arg_12_1][arg_12_2]:Find("blank")
	local var_12_8 = arg_12_0.tfFleets[arg_12_1][arg_12_2]:Find("commander")

	setActive(arg_12_0.tfFleets[arg_12_1][arg_12_2]:Find("selected"), false)
	setText(var_12_2, "")

	if var_12_3 then
		setActive(var_12_3, var_12_1 and var_12_0)
	end

	if var_12_4 then
		setActive(var_12_4, var_12_1 and var_12_0)
	end

	if var_12_5 then
		setActive(var_12_5, var_12_1 and var_12_0)
	end

	if var_12_1 then
		if var_12_0 then
			local var_12_10 = var_12_2

			if var_12_0.name == "" then
				local var_12_11 = Fleet.DEFAULT_NAME[var_12_0.id] or var_12_0.name

				var_12_9(var_12_10, var_12_11)

				if arg_12_1 == FleetType.Submarine then
					arg_12_0:updateShips(var_12_5, var_12_0.subShips, var_12_0.id, TeamType.Submarine, var_12_0)
				else
					arg_12_0:updateShips(var_12_3, var_12_0.mainShips, var_12_0.id, TeamType.Main, var_12_0)
					arg_12_0:updateShips(var_12_4, var_12_0.vanguardShips, var_12_0.id, TeamType.Vanguard, var_12_0)
				end

				arg_12_0:updateCommanders(var_12_8, var_12_0)
				onButton(arg_12_0, arg_12_0.tfFleets[arg_12_1][arg_12_2]:Find("btn_recom"), function()
					arg_12_0.parent:emit(var_0_0.ON_FLEET_RECOMMEND, var_12_0.id)

					return
				end)
				onButton(arg_12_0, arg_12_0.tfFleets[arg_12_1][arg_12_2]:Find("btn_clear"), function()
					arg_12_0.parent:emit(var_0_0.ON_FLEET_CLEAR, var_12_0.id)

					return
				end, SFX_UI_CLICK)

				return
			end
		end
	end
end

function var_0_0.updateCommanders(arg_15_0, arg_15_1, arg_15_2)
	for iter_15_0 = 1, 2 do
		local var_15_0 = arg_15_2:getCommanderByPos(iter_15_0)
		local var_15_1 = arg_15_1:Find("pos" .. iter_15_0)
		local var_15_2 = var_15_1:Find("add")
		local var_15_3 = var_15_1:Find("info")

		setActive(var_15_2, not var_15_0)
		setActive(var_15_3, var_15_0)

		if var_15_0 then
			setImageSprite(var_15_3:Find("frame"), GetSpriteFromAtlas("weaponframes", "commander_" .. Commander.rarity2Frame(var_15_0:getRarity())))
			GetImageSpriteFromAtlasAsync("CommanderHrz/" .. var_15_0:getPainting(), "", var_15_3:Find("mask/icon"))
		end

		onButton(arg_15_0, var_15_2, function()
			arg_15_0.parent:openCommanderPanel(arg_15_2, arg_15_2.id)

			return
		end, SFX_PANEL)
		onButton(arg_15_0, var_15_3, function()
			arg_15_0.parent:openCommanderPanel(arg_15_2, arg_15_2.id)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.updateShips(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	local var_18_0 = UIItemList.New(arg_18_1, arg_18_0.tfShipTpl)

	var_18_0:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			local var_19_0 = getProxy(BayProxy)
			local var_19_1 = getProxy(BayProxy):getShipById(arg_18_2[arg_19_1 + 1])

			if var_19_1 then
				setActive(arg_19_2:Find("icon_bg"), true)
				setActive(arg_19_2:Find("empty"), false)
				updateShip(arg_19_2, var_19_1)
			else
				setActive(arg_19_2:Find("icon_bg"), false)
				setActive(arg_19_2:Find("empty"), true)
			end

			setActive(findTF(arg_19_2, "ship_type"), false)

			local var_19_2 = GetOrAddComponent(arg_19_2, typeof(UILongPressTrigger))

			local function var_19_3()
				arg_18_0.onCancel()
				arg_18_0.parent:emit(var_0_0.ON_OPEN_DOCK, {
					shipType = 0,
					fleet = arg_18_2,
					shipVO = var_19_1,
					fleetIndex = arg_18_3,
					teamType = arg_18_4
				})

				return
			end

			var_19_2.onReleased:RemoveAllListeners()
			var_19_2.onLongPressed:RemoveAllListeners()
			var_19_2.onReleased:AddListener(function()
				var_19_3()

				return
			end)
			var_19_2.onLongPressed:AddListener(function()
				if var_19_1 then
					arg_18_0.onCancel()
					arg_18_0.onLongPressShip(var_19_1.id, _.map(arg_18_5:getShipIds(), function(arg_23_0)
						return var_19_0:getShipById(arg_23_0)
					end))
				else
					var_19_3()
				end

				return
			end)
		end

		return
	end)
	var_18_0:align(3)

	return
end

function var_0_0.showToggleMask(arg_24_0, arg_24_1, arg_24_2)
	setActive(arg_24_0.toggleMask, true)

	local var_24_0 = _.filter(arg_24_0.fleets, function(arg_25_0)
		return arg_25_0:getFleetType() == arg_24_1
	end)

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.toggles) do
		local var_24_1 = var_24_0[iter_24_0]

		setActive(iter_24_1, var_24_0[iter_24_0])

		if var_24_0[iter_24_0] then
			local var_24_2, var_24_3 = var_24_0[iter_24_0]:isUnlock()
			local var_24_4 = iter_24_1:Find("lock")

			setButtonEnabled(iter_24_1, var_24_2)
			setActive(var_24_4, not var_24_2)

			if var_24_2 then
				local var_24_5 = table.contains(arg_24_0.selectIds[arg_24_1], var_24_0[iter_24_0].id)

				setActive(findTF(iter_24_1, "selected"), var_24_5)
				setActive(findTF(iter_24_1, "text"), not var_24_5)
				setActive(findTF(iter_24_1, "text_selected"), var_24_5)
				onButton(arg_24_0, iter_24_1, function()
					arg_24_2(var_24_1.id)

					return
				end, SFX_UI_TAG)
			else
				onButton(arg_24_0, var_24_4, function()
					pg.TipsMgr.GetInstance():ShowTips(var_24_3)

					return
				end, SFX_UI_CLICK)
			end
		end
	end

	return
end

function var_0_0.hideToggleMask(arg_28_0)
	setActive(arg_28_0.toggleMask, false)

	return
end

function var_0_0.setFleets(arg_29_0, arg_29_1)
	arg_29_0.fleets = {
		[FleetType.Normal] = {},
		[FleetType.Submarine] = {}
	}

	for iter_29_0, iter_29_1 in pairs(arg_29_1) do
		if iter_29_1:isSubmarineFleet() then
			table.insert(arg_29_0.fleets[FleetType.Submarine], iter_29_1)
		else
			table.insert(arg_29_0.fleets[FleetType.Normal], iter_29_1)
		end
	end

	return
end

function var_0_0.clearFleets(arg_30_0)
	for iter_30_0, iter_30_1 in pairs(arg_30_0.tfFleets) do
		_.each(iter_30_1, function(arg_31_0)
			arg_30_0:clearFleet(arg_31_0)

			return
		end)
	end

	return
end

function var_0_0.clearFleet(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_1:Find(TeamType.Main)
	local var_32_1 = arg_32_1:Find(TeamType.Vanguard)
	local var_32_2 = arg_32_1:Find(TeamType.Submarine)

	if var_32_0 then
		removeAllChildren(var_32_0)
	end

	if var_32_1 then
		removeAllChildren(var_32_1)
	end

	if var_32_2 then
		removeAllChildren(var_32_2)
	end

	return
end

function var_0_0.clear(arg_33_0)
	triggerToggle(arg_33_0.commanderBtn, false)

	return
end

return var_0_0
