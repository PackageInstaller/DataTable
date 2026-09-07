local BossSingleBattleFleetSelectSubPanel = class("BossSingleBattleFleetSelectSubPanel", import("view.base.BaseSubPanel"))

function BossSingleBattleFleetSelectSubPanel:getUIName()
	return "BossSingleFleetSelectView"
end

function BossSingleBattleFleetSelectSubPanel:InvokeParent(arg_2_1, ...)
	if self.viewParent then
		self.viewParent[arg_2_1](self.viewParent, ...)
	end

	return
end

function BossSingleBattleFleetSelectSubPanel:OnInit()
	self.tfShipTpl = self._tf:Find("panel/shiptpl")
	self.tfEmptyTpl = self._tf:Find("panel/emptytpl")
	self.tfFleets = {
		[FleetType.Normal] = {
			self._tf:Find("panel/fleet/1"),
			self._tf:Find("panel/fleet/2")
		},
		[FleetType.Submarine] = {
			self._tf:Find("panel/sub/1")
		}
	}
	self.tfLimit = self._tf:Find("panel/limit_list/limit")
	self.tfLimitTips = self._tf:Find("panel/limit_list/limit_tip")
	self.tfLimitElite = self._tf:Find("panel/limit_list/limit_elite")

	setText(self.tfLimitElite:Find("sub/Text"), i18n("ship_limit_notice"))

	self.tfLimitContainer = self._tf:Find("panel/limit_list/limit_elite/limit_list")
	self.rtCostLimit = self._tf:Find("panel/limit_list/cost_limit")
	self.btnBack = self._tf:Find("panel/btnBack")
	self.btnGo = self._tf:Find("panel/start_button")
	self.btnTry = self._tf:Find("panel/try_button")
	self.btnASHelp = self._tf:Find("panel/title/ASvalue")
	self.commanderToggle = self._tf:Find("panel/commander_btn")
	self.formationToggle = self._tf:Find("panel/formation_btn")
	self.toggleMask = self._tf:Find("mask")
	self.toggleList = self._tf:Find("mask/list")
	self.toggles = {}

	for iter_3_0 = 0, self.toggleList.childCount - 1 do
		table.insert(self.toggles, self.toggleList:Find("item" .. iter_3_0 + 1))
	end

	self.btnSp = self._tf:Find("panel/sp")
	self.spMask = self._tf:Find("mask_sp")

	setActive(self.tfShipTpl, false)
	setActive(self.tfEmptyTpl, false)
	setActive(self.toggleMask, false)
	setActive(self.btnSp, false)
	setActive(self.spMask, false)
	setActive(self.tfLimitElite, false)
	setActive(self.tfLimitTips, false)
	setActive(self.tfLimit, false)
	setActive(self._tf:Find("panel/title/ASvalue"), false)
	setText(self._tf:Find("panel/formation_btn/text"), i18n("autofight_formation"))
	setText(self._tf:Find("panel/commander_btn/text"), i18n("autofight_cat"))
	setText(self._tf:Find("panel/title/Image/text"), i18n("fleet_select_title"))
	self:InitInteractable()

	return
end

function BossSingleBattleFleetSelectSubPanel:InitInteractable()
	onButton(self, self.btnGo, function()
		local var_5_0, var_5_1 = self:CheckValid()

		if var_5_0 then
			self:OnCombat()
		else
			pg.TipsMgr.GetInstance():ShowTips(var_5_1)
		end

		return
	end, SFX_UI_WEIGHANCHOR_GO)
	onButton(self, self.btnBack, function()
		self:OnCancel()
		self:OnCommit()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf, function()
		self:OnCancel()
		self:OnCommit()

		return
	end, SFX_CANCEL)
	onToggle(self, self.commanderToggle, function(arg_8_0)
		if arg_8_0 then
			self.viewParent.contextData.showCommander = arg_8_0

			for iter_8_0, iter_8_1 in pairs(self.tfFleets) do
				for iter_8_2 = 1, #iter_8_1 do
					self:updateCommanderBtn(iter_8_0, iter_8_2)
				end
			end
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.formationToggle, function(arg_9_0)
		if arg_9_0 then
			self.viewParent.contextData.showCommander = not arg_9_0

			for iter_9_0, iter_9_1 in pairs(self.tfFleets) do
				for iter_9_2 = 1, #iter_9_1 do
					self:updateCommanderBtn(iter_9_0, iter_9_2)
				end
			end
		end

		return
	end, SFX_PANEL)

	return
end

function BossSingleBattleFleetSelectSubPanel:SetFleets(arg_10_1)
	self.fleets = {
		[FleetType.Normal] = {},
		[FleetType.Submarine] = {}
	}

	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		iter_10_1:RemoveUnusedItems()

		if iter_10_1:isSubmarineFleet() then
			if #self.fleets[FleetType.Submarine] < self:getLimitNums(FleetType.Submarine) then
				table.insert(self.fleets[FleetType.Submarine], iter_10_1)
			end
		elseif #self.fleets[FleetType.Normal] < self:getLimitNums(FleetType.Normal) then
			table.insert(self.fleets[FleetType.Normal], iter_10_1)
		end
	end

	return
end

function BossSingleBattleFleetSelectSubPanel:SetOilLimit(arg_11_1)
	local var_11_0 = _.any(arg_11_1, function(arg_12_0)
		return arg_12_0 > 0
	end)

	setActive(self.rtCostLimit, var_11_0)
	setText(self.rtCostLimit:Find("text"), i18n("formationScene_use_oil_limit_tip_worldboss"))

	if var_11_0 then
		local var_11_2 = arg_11_1[1]

		setActive(self.rtCostLimit:Find("cost_noraml/Text"), arg_11_1[1] > 0)

		local var_11_3
		local var_11_4

		if var_11_2 > 0 then
			setText(self.rtCostLimit:Find("cost_noraml/Text"), string.format("%s(%d)", i18n("formationScene_use_oil_limit_surface"), var_11_2))

			var_11_3 = setActive
			var_11_4 = self.rtCostLimit:Find("cost_boss/Text")
		end

		var_11_3(var_11_4, 0 > 0)

		local var_11_5 = arg_11_1[2]

		setActive(self.rtCostLimit:Find("cost_sub/Text"), arg_11_1[2] > 0)

		if var_11_5 > 0 then
			setText(self.rtCostLimit:Find("cost_sub/Text"), string.format("%s(%d)", i18n("formationScene_use_oil_limit_submarine"), var_11_5))
		end
	end

	return
end

function BossSingleBattleFleetSelectSubPanel:SetSettings(arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	self.groupNum = arg_13_1
	self.submarineNum = arg_13_2
	self.showTryBtn = arg_13_3
	self.propetyLimitation = arg_13_4
	self.index = arg_13_5

	return
end

function BossSingleBattleFleetSelectSubPanel:UpdateView()
	self:clearFleets()
	self:UpdateFleets()
	self:updatePropetyLimit()

	local var_14_0 = not LOCK_COMMANDER and pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "CommanderCatMediator") or false

	triggerToggle((self.viewParent.contextData.showCommander and var_14_0 or nil) and (self.commanderToggle or self.formationToggle), true)
	setActive(self.commanderToggle, var_14_0)
	setActive(self.btnTry, self.showTryBtn)

	return
end

function BossSingleBattleFleetSelectSubPanel:getLimitNums(arg_15_1)
	local var_15_0 = 0

	if arg_15_1 == FleetType.Normal then
		var_15_0 = self.groupNum
	elseif arg_15_1 == FleetType.Submarine then
		var_15_0 = self.submarineNum
	end

	return var_15_0 or 0
end

function BossSingleBattleFleetSelectSubPanel:UpdateFleets()
	for iter_16_0, iter_16_1 in pairs(self.tfFleets) do
		for iter_16_2 = 1, #iter_16_1 do
			self:updateFleet(iter_16_0, iter_16_2)
		end
	end

	return
end

function BossSingleBattleFleetSelectSubPanel:updateFleet(arg_17_1, arg_17_2)
	self:updateCommanderBtn(arg_17_1, arg_17_2)

	local var_17_0 = arg_17_2 <= self:getLimitNums(arg_17_1)
	local var_17_1 = var_17_0 and self.fleets[arg_17_1][arg_17_2]
	local var_17_2 = findTF(self.tfFleets[arg_17_1][arg_17_2], "bg/name")
	local var_17_3 = self.tfFleets[arg_17_1][arg_17_2]:Find(TeamType.Main)
	local var_17_4 = self.tfFleets[arg_17_1][arg_17_2]:Find(TeamType.Vanguard)
	local var_17_5 = self.tfFleets[arg_17_1][arg_17_2]:Find(TeamType.Submarine)
	local var_17_6 = self.tfFleets[arg_17_1][arg_17_2]:Find("btn_recom")
	local var_17_7 = self.tfFleets[arg_17_1][arg_17_2]:Find("btn_clear")
	local var_17_8 = self.tfFleets[arg_17_1][arg_17_2]:Find("commander")

	setActive(self.tfFleets[arg_17_1][arg_17_2]:Find("selected"), false)
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

	if self.viewParent.contextData.bossActivity:getConfig("type") == ActivityConst.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE then
		if var_17_0 and var_17_1 then
			setText(var_17_2, (Fleet.DEFAULT_NAME_BOSS_SINGLE_VARIABLE_ACT or Fleet.DEFAULT_NAME_BOSS_SINGLE_ACT)[var_17_1.id] or "")

			if arg_17_1 == FleetType.Submarine then
				self:updateShips(var_17_5, var_17_1.subShips, var_17_1.id, TeamType.Submarine)
			else
				self:updateShips(var_17_3, var_17_1.mainShips, var_17_1.id, TeamType.Main)
				self:updateShips(var_17_4, var_17_1.vanguardShips, var_17_1.id, TeamType.Vanguard)
			end

			self:updateCommanders(var_17_8, var_17_1)
			onButton(self, var_17_6, function()
				self:emit(self.viewParent.contextData.mediatorClass.ON_FLEET_RECOMMEND, var_17_1.id)

				return
			end)
			onButton(self, var_17_7, function()
				self:emit(self.viewParent.contextData.mediatorClass.ON_FLEET_CLEAR, var_17_1.id)

				return
			end, SFX_UI_CLICK)
		end
	end

	return
end

function BossSingleBattleFleetSelectSubPanel:updateShips(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	removeAllChildren(arg_20_1)

	local var_20_0 = getProxy(BayProxy)

	for iter_20_0 = 1, 3 do
		local var_20_1 = var_20_0:getShipById(arg_20_2[iter_20_0])
		local var_20_2 = cloneTplTo((var_20_1 or nil) and (self.tfShipTpl or self.tfEmptyTpl), arg_20_1)

		setActive(var_20_2, true)

		if var_20_1 then
			updateShip(var_20_2, var_20_1)
			setActive(var_20_2:Find("event_block"), var_20_1:getFlag("inEvent"))
		end

		setActive(var_20_2:Find("ship_type"), false)

		local var_20_3 = GetOrAddComponent(var_20_2, typeof(UILongPressTrigger))

		var_20_3.onLongPressed:RemoveAllListeners()

		local function var_20_4()
			self:emit(self.viewParent.contextData.mediatorClass.ON_OPEN_DOCK, {
				fleet = arg_20_2,
				shipVO = var_20_1,
				fleetIndex = arg_20_3,
				teamType = arg_20_4
			})

			return
		end

		onButton(self, var_20_2, var_20_4)
		var_20_3.onLongPressed:AddListener(function()
			if var_20_1 then
				self:OnLongPressShip(arg_20_2[iter_20_0], arg_20_3)
			else
				var_20_4()
			end

			return
		end)
	end

	return
end

function BossSingleBattleFleetSelectSubPanel:updateCommanderBtn(arg_23_1, arg_23_2)
	local var_23_0 = arg_23_2 <= self:getLimitNums(arg_23_1)
	local var_23_1 = var_23_0 and self.fleets[arg_23_1][arg_23_2]
	local var_23_2 = self.tfFleets[arg_23_1][arg_23_2]:Find("blank")

	setActive(self.tfFleets[arg_23_1][arg_23_2]:Find("btn_select"), false)
	setActive(self.tfFleets[arg_23_1][arg_23_2]:Find("btn_clear"), var_23_0 and not self.viewParent.contextData.showCommander)
	setActive(self.tfFleets[arg_23_1][arg_23_2]:Find("btn_recom"), var_23_0 and not self.viewParent.contextData.showCommander)
	setActive(self.tfFleets[arg_23_1][arg_23_2]:Find("commander"), var_23_0 and var_23_1 and self.viewParent.contextData.showCommander)
	setActive(var_23_2, not var_23_0 or var_23_0 and not var_23_1 and self.viewParent.contextData.showCommander)

	return
end

function BossSingleBattleFleetSelectSubPanel:updateCommanders(arg_24_1, arg_24_2)
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

		onButton(self, var_24_2, function()
			self:InvokeParent("openCommanderPanel", arg_24_2, arg_24_2.id)

			return
		end, SFX_PANEL)
		onButton(self, var_24_3, function()
			self:InvokeParent("openCommanderPanel", arg_24_2, arg_24_2.id)

			return
		end, SFX_PANEL)
	end

	return
end

function BossSingleBattleFleetSelectSubPanel:clearFleets()
	for iter_27_0, iter_27_1 in pairs(self.tfFleets) do
		_.each(iter_27_1, function(arg_28_0)
			self:clearFleet(arg_28_0)

			return
		end)
	end

	return
end

function BossSingleBattleFleetSelectSubPanel:clearFleet(arg_29_1)
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

function BossSingleBattleFleetSelectSubPanel:updatePropetyLimit()
	setActive(self.toggleMask, false)
	setActive(self.tfLimit, false)
	setActive(self.tfLimitTips, false)
	setActive(self.tfLimitElite, #self.propetyLimitation > 0)

	if #self.propetyLimitation > 0 then
		local var_30_0 = UIItemList.New(self.tfLimitContainer, self.tfLimitContainer:GetChild(0))
		local var_30_1, var_30_2 = self:IsPropertyLimitationSatisfy()

		var_30_0:make(function(arg_31_0, arg_31_1, arg_31_2)
			arg_31_1 = arg_31_1 + 1

			if arg_31_0 == UIItemList.EventUpdate then
				local var_31_0, var_31_1, var_31_2, var_31_3 = unpack(self.propetyLimitation[arg_31_1])

				arg_31_2:Find("Text"):GetComponent(typeof(Text)).color = var_30_1[arg_31_1] == 1 and Color.New(1, 0.9607843137254902, 0.5019607843137255) or Color.New(0.9568627450980393, 0.30196078431372547, 0.30196078431372547)

				setActive(arg_31_2, true)
				setText(arg_31_2:Find("Text"), AttributeType.EliteCondition2Name(var_31_0, var_31_3) .. AttributeType.eliteConditionCompareTip(var_31_1) .. var_31_2)
			end

			return
		end)
		var_30_0:align(#self.propetyLimitation)
	end

	return
end

function BossSingleBattleFleetSelectSubPanel:OnShow()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function BossSingleBattleFleetSelectSubPanel:OnHide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self.viewParent._tf)
	triggerToggle(self.commanderToggle, false)

	return
end

function BossSingleBattleFleetSelectSubPanel:OnCancel()
	self:InvokeParent("hideFleetEdit")

	return
end

function BossSingleBattleFleetSelectSubPanel:OnCommit()
	self:InvokeParent("commitEdit")

	return
end

function BossSingleBattleFleetSelectSubPanel:OnCombat()
	self:InvokeParent("commitEdit")
	self:InvokeParent("commitCombat")

	return
end

function BossSingleBattleFleetSelectSubPanel:OnLongPressShip(arg_37_1, arg_37_2)
	self:InvokeParent("openShipInfo", arg_37_1, arg_37_2)

	return
end

function BossSingleBattleFleetSelectSubPanel:IsPropertyLimitationSatisfy()
	local var_38_0 = getProxy(BayProxy):getRawData()
	local var_38_1 = {}

	for iter_38_0, iter_38_1 in ipairs(self.propetyLimitation) do
		var_38_1[iter_38_1[1]] = 0
	end

	local var_38_2 = 0
	local var_38_3 = {}

	for iter_38_2 = 1, 2 do
		if self.fleets[FleetType.Normal][iter_38_2] then
			for iter_38_3, iter_38_4 in pairs(self.fleets[FleetType.Normal][iter_38_2].mainShips) do
				table.insert(var_38_3, iter_38_4)
			end

			for iter_38_5, iter_38_6 in pairs(self.fleets[FleetType.Normal][iter_38_2].vanguardShips) do
				table.insert(var_38_3, iter_38_6)
			end
		end
	end

	local var_38_4 = {}
	local var_38_5 = {}

	for iter_38_7, iter_38_8 in ipairs(self.propetyLimitation) do
		local var_38_6, var_38_7, var_38_8, var_38_9 = unpack(iter_38_8)

		if string.sub(var_38_6, 1, 5) == "fleet" then
			var_38_4[var_38_6] = 0
			var_38_5[var_38_6] = var_38_9
		end
	end

	for iter_38_9, iter_38_10 in ipairs(var_38_3) do
		var_38_2 = var_38_2 + 1

		local var_38_10 = intProperties(var_38_0[iter_38_10]:getProperties())

		for iter_38_11, iter_38_12 in pairs(var_38_1) do
			if string.sub(iter_38_11, 1, 5) == "fleet" then
				if iter_38_11 == "fleet_totle_level" then
					var_38_4[iter_38_11] = var_38_4[iter_38_11] + var_38_0[iter_38_10].level
				end
			else
				var_38_1[iter_38_11] = iter_38_11 == "level" and iter_38_12 + var_38_0[iter_38_10].level or iter_38_12 + var_38_10[iter_38_11]
			end
		end
	end

	for iter_38_13, iter_38_14 in pairs(var_38_4) do
		if iter_38_13 == "fleet_totle_level" and iter_38_14 > var_38_5[iter_38_13] then
			var_38_1[iter_38_13] = var_38_1[iter_38_13] + 1
		end
	end

	local var_38_11 = {}

	for iter_38_15, iter_38_16 in ipairs(self.propetyLimitation) do
		local var_38_12, var_38_13, var_38_14 = unpack(iter_38_16)

		if var_38_12 == "level" and var_38_2 > 0 then
			var_38_1[var_38_12] = math.ceil(var_38_1[var_38_12] / var_38_2)
		end

		var_38_11[iter_38_15] = AttributeType.EliteConditionCompare(var_38_13, var_38_1[var_38_12], var_38_14) and 1 or 0
	end

	return var_38_11, var_38_1
end

function BossSingleBattleFleetSelectSubPanel:CheckValid()
	local var_39_0, var_39_1 = self.viewParent.contextData.bossActivity:CheckCntByIdx(self.index)

	if not var_39_0 then
		return var_39_0, var_39_1
	end

	local var_39_2, var_39_3 = self:IsPropertyLimitationSatisfy()
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

return BossSingleBattleFleetSelectSubPanel
