local BossSingleBattleFleetSelectSubPanelLite = class("BossSingleBattleFleetSelectSubPanelLite", import("view.base.BaseSubPanel"))

function BossSingleBattleFleetSelectSubPanelLite:getUIName()
	return "BossSingleFleetSelectView"
end

function BossSingleBattleFleetSelectSubPanelLite:OnInit()
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
	self.limitList = self._tf:Find("panel/limit_list")
	self.btnBack = self._tf:Find("panel/btnBack")
	self.btnGo = self._tf:Find("panel/start_button")
	self.btnTry = self._tf:Find("panel/try_button")
	self.btnASHelp = self._tf:Find("panel/title/ASvalue")
	self.commanderToggle = self._tf:Find("panel/commander_btn")
	self.formationToggle = self._tf:Find("panel/formation_btn")
	self.toggleMask = self._tf:Find("mask")
	self.toggleList = self._tf:Find("mask/list")
	self.toggles = {}

	for iter_2_0 = 0, self.toggleList.childCount - 1 do
		table.insert(self.toggles, self.toggleList:Find("item" .. iter_2_0 + 1))
	end

	self.btnSp = self._tf:Find("panel/sp")
	self.spMask = self._tf:Find("mask_sp")

	setActive(self.tfShipTpl, false)
	setActive(self.tfEmptyTpl, false)
	setActive(self.toggleMask, false)
	setActive(self.btnSp, false)
	setActive(self.spMask, false)
	setActive(self.btnASHelp, false)
	setActive(self.commanderToggle, false)
	setActive(self.btnTry, false)
	setActive(self.limitList, false)
	setText(self._tf:Find("panel/formation_btn/text"), i18n("autofight_formation"))
	setText(self._tf:Find("panel/commander_btn/text"), i18n("autofight_cat"))
	setText(self._tf:Find("panel/title/Image/text"), i18n("fleet_select_title"))
	self:InitInteractable()

	return
end

function BossSingleBattleFleetSelectSubPanelLite:InitInteractable()
	onButton(self, self.btnGo, function()
		self:OnCombat()
		self:OnHide()

		return
	end, SFX_UI_WEIGHANCHOR_GO)
	onButton(self, self.btnBack, function()
		self:OnHide()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf, function()
		self:OnHide()

		return
	end, SFX_CANCEL)
	onButton(self, self.toggleMask, function()
		self:hideToggleMask()

		return
	end, SFX_CANCEL)

	return
end

function BossSingleBattleFleetSelectSubPanelLite:SetFleets(arg_8_1)
	self.selectIds = {
		[FleetType.Normal] = {
			1
		},
		[FleetType.Submarine] = {}
	}
	self.fleets = _(_.values(arg_8_1)):chain():filter(function(arg_9_0)
		return arg_9_0:isRegularFleet()
	end):sort(function(arg_10_0, arg_10_1)
		return arg_10_0.id < arg_10_1.id
	end):value()

	return
end

function BossSingleBattleFleetSelectSubPanelLite:SetSettings(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	self.groupNum = arg_11_1
	self.submarineNum = arg_11_2
	self.stageID = arg_11_3
	self.system = arg_11_4
	self.actID = arg_11_5

	return
end

function BossSingleBattleFleetSelectSubPanelLite:UpdateView()
	self:clearFleets()
	self:UpdateFleets()

	return
end

function BossSingleBattleFleetSelectSubPanelLite:getLimitNums(arg_13_1)
	local var_13_0 = 0

	if arg_13_1 == FleetType.Normal then
		var_13_0 = self.groupNum
	elseif arg_13_1 == FleetType.Submarine then
		var_13_0 = self.submarineNum
	end

	return var_13_0 or 0
end

function BossSingleBattleFleetSelectSubPanelLite:UpdateFleets()
	for iter_14_0, iter_14_1 in pairs(self.tfFleets) do
		for iter_14_2 = 1, #iter_14_1 do
			self:updateFleet(iter_14_0, iter_14_2)
		end
	end

	return
end

function BossSingleBattleFleetSelectSubPanelLite:showToggleMask(arg_15_1, arg_15_2)
	setActive(self.toggleMask, true)

	local var_15_0 = _.filter(self.fleets, function(arg_16_0)
		return arg_16_0:getFleetType() == arg_15_1
	end)

	for iter_15_0, iter_15_1 in ipairs(self.toggles) do
		local var_15_1 = var_15_0[iter_15_0]

		setActive(iter_15_1, var_15_0[iter_15_0])

		if var_15_0[iter_15_0] then
			local var_15_2 = iter_15_1:GetComponent(typeof(Toggle))
			local var_15_3 = iter_15_1:Find("lock")
			local var_15_4, var_15_5 = var_15_0[iter_15_0]:isUnlock()

			setToggleEnabled(iter_15_1, var_15_4)
			setActive(var_15_3, not var_15_4)

			local var_15_6 = table.contains(self.selectIds[arg_15_1], var_15_0[iter_15_0].id)

			setActive(iter_15_1:Find("on"), var_15_6)
			setActive(iter_15_1:Find("off"), not var_15_6)

			if var_15_4 then
				var_15_2.isOn = false

				onToggle(self, iter_15_1, function(arg_17_0)
					if arg_17_0 then
						setActive(self.toggleMask, false)
						arg_15_2(var_15_1.id)
					end

					return
				end, SFX_UI_TAG)
			else
				onButton(self, var_15_3, function()
					pg.TipsMgr.GetInstance():ShowTips(var_15_5)

					return
				end, SFX_UI_CLICK)
			end
		end
	end

	return
end

function BossSingleBattleFleetSelectSubPanelLite:hideToggleMask()
	setActive(self.toggleMask, false)

	return
end

function BossSingleBattleFleetSelectSubPanelLite:updateFleet(arg_20_1, arg_20_2)
	local var_20_0 = arg_20_2 <= self:getLimitNums(arg_20_1)
	local var_20_1 = self:getFleetById(self.selectIds[arg_20_1][arg_20_2])
	local var_20_2 = findTF(self.tfFleets[arg_20_1][arg_20_2], "bg/name")
	local var_20_3 = self.tfFleets[arg_20_1][arg_20_2]:Find(TeamType.Main)
	local var_20_4 = self.tfFleets[arg_20_1][arg_20_2]:Find(TeamType.Vanguard)
	local var_20_5 = self.tfFleets[arg_20_1][arg_20_2]:Find(TeamType.Submarine)

	setActive(self.tfFleets[arg_20_1][arg_20_2]:Find("btn_recom"), false)

	local var_20_6 = self.tfFleets[arg_20_1][arg_20_2]:Find("btn_clear")

	setActive(var_20_6, false)

	local var_20_7 = self.tfFleets[arg_20_1][arg_20_2]:Find("btn_select")

	setActive(var_20_7, var_20_0)

	local var_20_8 = self.tfFleets[arg_20_1][arg_20_2]:Find("commander")

	setActive(self.tfFleets[arg_20_1][arg_20_2]:Find("selected"), false)
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
		setText(var_20_2, var_20_1 and var_20_1:GetName() or "")

		if arg_20_1 == FleetType.Submarine then
			self:updateShips(var_20_5, var_20_1.subShips, var_20_1.id, TeamType.Submarine)
		else
			self:updateShips(var_20_3, var_20_1.mainShips, var_20_1.id, TeamType.Main)
			self:updateShips(var_20_4, var_20_1.vanguardShips, var_20_1.id, TeamType.Vanguard)
		end
	end

	onButton(self, var_20_7, function()
		self.toggleList.position = (var_20_7.position + var_20_6.position) / 2
		self.toggleList.anchoredPosition = self.toggleList.anchoredPosition + Vector2(-self.toggleList.rect.width / 2, -var_20_7.rect.height / 2)

		self:showToggleMask(arg_20_1, function(arg_22_0)
			self:hideToggleMask()
			self:selectFleet(arg_20_1, arg_20_2, arg_22_0)

			return
		end)

		return
	end, SFX_UI_CLICK)

	return
end

function BossSingleBattleFleetSelectSubPanelLite:getFleetById(arg_23_1)
	return _.detect(self.fleets, function(arg_24_0)
		return arg_24_0.id == arg_23_1
	end)
end

function BossSingleBattleFleetSelectSubPanelLite:updateShips(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	removeAllChildren(arg_25_1)

	local var_25_0 = getProxy(BayProxy)

	for iter_25_0 = 1, 3 do
		local var_25_1 = var_25_0:getShipById(arg_25_2[iter_25_0])

		if var_25_1 then
			local var_25_2 = cloneTplTo(var_25_1 and self.tfShipTpl, arg_25_1)

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

function BossSingleBattleFleetSelectSubPanelLite:selectFleet(arg_26_1, arg_26_2, arg_26_3)
	if arg_26_3 > 0 and table.contains(self.selectIds[arg_26_1], arg_26_3) then
		return
	end

	if arg_26_1 == FleetType.Normal and self:getLimitNums(arg_26_1) > 0 and arg_26_3 == 0 and #_.filter(self.selectIds[arg_26_1], function(arg_27_0)
		return arg_27_0 > 0
	end) == 1 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("level_fleet_lease_one_ship"))

		return
	end

	local var_26_0 = self:getFleetById(arg_26_3)

	if var_26_0 then
		if not var_26_0:isUnlock() then
			return
		end

		if var_26_0:isLegalToFight() ~= true then
			pg.TipsMgr.GetInstance():ShowTips(i18n("level_fleet_not_enough"))

			return
		end
	end

	self.selectIds[arg_26_1][arg_26_2] = arg_26_3

	self:updateFleet(arg_26_1, arg_26_2)

	return
end

function BossSingleBattleFleetSelectSubPanelLite:clearFleets()
	for iter_28_0, iter_28_1 in pairs(self.tfFleets) do
		_.each(iter_28_1, function(arg_29_0)
			self:clearFleet(arg_29_0)

			return
		end)
	end

	return
end

function BossSingleBattleFleetSelectSubPanelLite:clearFleet(arg_30_1)
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

function BossSingleBattleFleetSelectSubPanelLite:OnShow()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	setActive(self._tf, true)

	return
end

function BossSingleBattleFleetSelectSubPanelLite:OnHide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self.viewParent._tf)
	setActive(self._tf, false)

	return
end

function BossSingleBattleFleetSelectSubPanelLite:OnCombat()
	self:emit(ActivityMediator.GO_SINGLE_PRECOMBAT, {
		system = self.system,
		stageId = self.stageID,
		activityID = self.actID,
		fleets = {
			self.fleets[self.selectIds[FleetType.Normal][1]]
		}
	})

	return
end

return BossSingleBattleFleetSelectSubPanelLite
