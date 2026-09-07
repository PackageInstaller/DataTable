local ActivityBossBattleFleetSelectSubPanel = class("ActivityBossBattleFleetSelectSubPanel", import("view.base.BaseSubPanel"))

function ActivityBossBattleFleetSelectSubPanel:getUIName()
	return "ActivityBossFleetSelectView"
end

function ActivityBossBattleFleetSelectSubPanel:InvokeParent(arg_2_1, ...)
	if self.viewParent then
		self.viewParent[arg_2_1](self.viewParent, ...)
	end

	return
end

function ActivityBossBattleFleetSelectSubPanel:OnInit()
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

function ActivityBossBattleFleetSelectSubPanel:InitInteractable()
	onButton(self, self.btnGo, function()
		self:OnCombat()

		return
	end, SFX_UI_WEIGHANCHOR_GO)
	onButton(self, self.btnTry, function()
		self:OnTrybat()

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
	onToggle(self, self.commanderToggle, function(arg_9_0)
		if arg_9_0 then
			self.viewParent.contextData.showCommander = arg_9_0

			for iter_9_0, iter_9_1 in pairs(self.tfFleets) do
				for iter_9_2 = 1, #iter_9_1 do
					self:updateCommanderBtn(iter_9_0, iter_9_2)
				end
			end
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.formationToggle, function(arg_10_0)
		if arg_10_0 then
			self.viewParent.contextData.showCommander = not arg_10_0

			for iter_10_0, iter_10_1 in pairs(self.tfFleets) do
				for iter_10_2 = 1, #iter_10_1 do
					self:updateCommanderBtn(iter_10_0, iter_10_2)
				end
			end
		end

		return
	end, SFX_PANEL)

	return
end

function ActivityBossBattleFleetSelectSubPanel:SetFleets(arg_11_1)
	self.fleets = {
		[FleetType.Normal] = {},
		[FleetType.Submarine] = {}
	}

	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		iter_11_1:RemoveUnusedItems()

		if iter_11_1:isSubmarineFleet() then
			if #self.fleets[FleetType.Submarine] < self:getLimitNums(FleetType.Submarine) then
				table.insert(self.fleets[FleetType.Submarine], iter_11_1)
			end
		elseif #self.fleets[FleetType.Normal] < self:getLimitNums(FleetType.Normal) then
			table.insert(self.fleets[FleetType.Normal], iter_11_1)
		end
	end

	return
end

function ActivityBossBattleFleetSelectSubPanel:SetOilLimit(arg_12_1)
	local var_12_0 = _.any(arg_12_1, function(arg_13_0)
		return arg_13_0 > 0
	end)

	setActive(self.rtCostLimit, var_12_0)
	setText(self.rtCostLimit:Find("text"), i18n("formationScene_use_oil_limit_tip_worldboss"))

	if var_12_0 then
		local var_12_2 = arg_12_1[1]

		setActive(self.rtCostLimit:Find("cost_noraml/Text"), arg_12_1[1] > 0)

		local var_12_3
		local var_12_4

		if var_12_2 > 0 then
			setText(self.rtCostLimit:Find("cost_noraml/Text"), string.format("%s(%d)", i18n("formationScene_use_oil_limit_surface"), var_12_2))

			var_12_3 = setActive
			var_12_4 = self.rtCostLimit:Find("cost_boss/Text")
		end

		var_12_3(var_12_4, 0 > 0)

		local var_12_5 = arg_12_1[2]

		setActive(self.rtCostLimit:Find("cost_sub/Text"), arg_12_1[2] > 0)

		if var_12_5 > 0 then
			setText(self.rtCostLimit:Find("cost_sub/Text"), string.format("%s(%d)", i18n("formationScene_use_oil_limit_submarine"), var_12_5))
		end
	end

	return
end

function ActivityBossBattleFleetSelectSubPanel:SetSettings(arg_14_1, arg_14_2, arg_14_3)
	self.groupNum = arg_14_1
	self.submarineNum = arg_14_2
	self.showTryBtn = arg_14_3

	return
end

function ActivityBossBattleFleetSelectSubPanel:UpdateView()
	self:clearFleets()
	self:UpdateFleets()

	local var_15_0 = not LOCK_COMMANDER and pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "CommanderCatMediator") or false

	triggerToggle((self.viewParent.contextData.showCommander and var_15_0 or nil) and (self.commanderToggle or self.formationToggle), true)
	setActive(self.commanderToggle, var_15_0)
	setActive(self.btnTry, self.showTryBtn)

	return
end

function ActivityBossBattleFleetSelectSubPanel:getLimitNums(arg_16_1)
	local var_16_0 = 0

	if arg_16_1 == FleetType.Normal then
		var_16_0 = self.groupNum
	elseif arg_16_1 == FleetType.Submarine then
		var_16_0 = self.submarineNum
	end

	return var_16_0 or 0
end

function ActivityBossBattleFleetSelectSubPanel:UpdateFleets()
	for iter_17_0, iter_17_1 in pairs(self.tfFleets) do
		for iter_17_2 = 1, #iter_17_1 do
			self:updateFleet(iter_17_0, iter_17_2)
		end
	end

	return
end

function ActivityBossBattleFleetSelectSubPanel:updateFleet(arg_18_1, arg_18_2)
	self:updateCommanderBtn(arg_18_1, arg_18_2)

	local var_18_0 = arg_18_2 <= self:getLimitNums(arg_18_1)
	local var_18_1 = var_18_0 and self.fleets[arg_18_1][arg_18_2]
	local var_18_2 = findTF(self.tfFleets[arg_18_1][arg_18_2], "bg/name")
	local var_18_3 = self.tfFleets[arg_18_1][arg_18_2]:Find(TeamType.Main)
	local var_18_4 = self.tfFleets[arg_18_1][arg_18_2]:Find(TeamType.Vanguard)
	local var_18_5 = self.tfFleets[arg_18_1][arg_18_2]:Find(TeamType.Submarine)
	local var_18_6 = self.tfFleets[arg_18_1][arg_18_2]:Find("btn_recom")
	local var_18_7 = self.tfFleets[arg_18_1][arg_18_2]:Find("btn_clear")
	local var_18_8 = self.tfFleets[arg_18_1][arg_18_2]:Find("commander")

	setActive(self.tfFleets[arg_18_1][arg_18_2]:Find("selected"), false)
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
		setText(var_18_2, Fleet.DEFAULT_NAME_BOSS_ACT[var_18_1.id] or "")

		if arg_18_1 == FleetType.Submarine then
			self:updateShips(var_18_5, var_18_1.subShips, var_18_1.id, TeamType.Submarine)
		else
			self:updateShips(var_18_3, var_18_1.mainShips, var_18_1.id, TeamType.Main)
			self:updateShips(var_18_4, var_18_1.vanguardShips, var_18_1.id, TeamType.Vanguard)
		end

		self:updateCommanders(var_18_8, var_18_1)
		onButton(self, var_18_6, function()
			self:emit(self.viewParent.contextData.mediatorClass.ON_FLEET_RECOMMEND, var_18_1.id)

			return
		end)
		onButton(self, var_18_7, function()
			self:emit(self.viewParent.contextData.mediatorClass.ON_FLEET_CLEAR, var_18_1.id)

			return
		end, SFX_UI_CLICK)
	end

	return
end

function ActivityBossBattleFleetSelectSubPanel:updateShips(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	removeAllChildren(arg_21_1)

	local var_21_0 = getProxy(BayProxy)

	for iter_21_0 = 1, 3 do
		local var_21_1 = var_21_0:getShipById(arg_21_2[iter_21_0])
		local var_21_2 = cloneTplTo((var_21_1 or nil) and (self.tfShipTpl or self.tfEmptyTpl), arg_21_1)

		setActive(var_21_2, true)

		if var_21_1 then
			updateShip(var_21_2, var_21_1)
			setActive(var_21_2:Find("event_block"), var_21_1:getFlag("inEvent"))
		end

		setActive(var_21_2:Find("ship_type"), false)

		local var_21_3 = GetOrAddComponent(var_21_2, typeof(UILongPressTrigger))

		var_21_3.onLongPressed:RemoveAllListeners()

		local function var_21_4()
			self:emit(self.viewParent.contextData.mediatorClass.ON_OPEN_DOCK, {
				fleet = arg_21_2,
				shipVO = var_21_1,
				fleetIndex = arg_21_3,
				teamType = arg_21_4
			})

			return
		end

		onButton(self, var_21_2, var_21_4)
		var_21_3.onLongPressed:AddListener(function()
			if var_21_1 then
				self:OnLongPressShip(arg_21_2[iter_21_0], arg_21_3)
			else
				var_21_4()
			end

			return
		end)
	end

	return
end

function ActivityBossBattleFleetSelectSubPanel:updateCommanderBtn(arg_24_1, arg_24_2)
	local var_24_0 = arg_24_2 <= self:getLimitNums(arg_24_1)
	local var_24_1 = var_24_0 and self.fleets[arg_24_1][arg_24_2]
	local var_24_2 = self.tfFleets[arg_24_1][arg_24_2]:Find("blank")

	setActive(self.tfFleets[arg_24_1][arg_24_2]:Find("btn_select"), false)
	setActive(self.tfFleets[arg_24_1][arg_24_2]:Find("btn_clear"), var_24_0 and not self.viewParent.contextData.showCommander)
	setActive(self.tfFleets[arg_24_1][arg_24_2]:Find("btn_recom"), var_24_0 and not self.viewParent.contextData.showCommander)
	setActive(self.tfFleets[arg_24_1][arg_24_2]:Find("commander"), var_24_0 and var_24_1 and self.viewParent.contextData.showCommander)
	setActive(var_24_2, not var_24_0 or var_24_0 and not var_24_1 and self.viewParent.contextData.showCommander)

	return
end

function ActivityBossBattleFleetSelectSubPanel:updateCommanders(arg_25_1, arg_25_2)
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

		onButton(self, var_25_2, function()
			self:InvokeParent("openCommanderPanel", arg_25_2, arg_25_2.id)

			return
		end, SFX_PANEL)
		onButton(self, var_25_3, function()
			self:InvokeParent("openCommanderPanel", arg_25_2, arg_25_2.id)

			return
		end, SFX_PANEL)
	end

	return
end

function ActivityBossBattleFleetSelectSubPanel:clearFleets()
	for iter_28_0, iter_28_1 in pairs(self.tfFleets) do
		_.each(iter_28_1, function(arg_29_0)
			self:clearFleet(arg_29_0)

			return
		end)
	end

	return
end

function ActivityBossBattleFleetSelectSubPanel:clearFleet(arg_30_1)
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

function ActivityBossBattleFleetSelectSubPanel:OnShow()
	pg.UIMgr.GetInstance():BlurPanel(self._tf, {
		groupDelta = -1,
		groupName = "ActivityBossSceneTemplate"
	})

	return
end

function ActivityBossBattleFleetSelectSubPanel:OnHide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self.viewParent._tf)
	triggerToggle(self.commanderToggle, false)

	return
end

function ActivityBossBattleFleetSelectSubPanel:OnCancel()
	self:InvokeParent("hideFleetEdit")

	return
end

function ActivityBossBattleFleetSelectSubPanel:OnCommit()
	self:InvokeParent("commitEdit")

	return
end

function ActivityBossBattleFleetSelectSubPanel:OnCombat()
	self:InvokeParent("commitEdit")
	self:InvokeParent("commitCombat")

	return
end

function ActivityBossBattleFleetSelectSubPanel:OnTrybat()
	self:InvokeParent("commitEdit")
	self:InvokeParent("commitTrybat")

	return
end

function ActivityBossBattleFleetSelectSubPanel:OnLongPressShip(arg_37_1, arg_37_2)
	self:InvokeParent("openShipInfo", arg_37_1, arg_37_2)

	return
end

return ActivityBossBattleFleetSelectSubPanel
