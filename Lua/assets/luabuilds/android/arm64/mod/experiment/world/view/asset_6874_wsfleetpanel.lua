local WSFleetPanel = class("WSFleetPanel", import("...BaseEntity"))

WSFleetPanel.Fields = {
	map = "table",
	onCancel = "function",
	btnGo = "userdata",
	transform = "userdata",
	toggles = "table",
	rtLimitTips = "userdata",
	btnBack = "userdata",
	toggleList = "userdata",
	toggleMask = "userdata",
	rtShipTpl = "userdata",
	rtEmptyTpl = "userdata",
	fleets = "table",
	onConfirm = "function",
	rtFleets = "table",
	rtLimitElite = "userdata",
	rtLimit = "userdata",
	selectIds = "table"
}

function WSFleetPanel:Setup()
	pg.DelegateInfo.New(self)
	self:Init()

	return
end

function WSFleetPanel:Dispose()
	pg.DelegateInfo.Dispose(self)
	self:Clear()

	return
end

function WSFleetPanel:Init()
	self.rtShipTpl = self.transform:Find("panel/shiptpl")
	self.rtEmptyTpl = self.transform:Find("panel/emptytpl")
	self.rtFleets = {
		[FleetType.Normal] = {
			self.transform:Find("panel/bg/content/fleet/1"),
			self.transform:Find("panel/bg/content/fleet/2"),
			self.transform:Find("panel/bg/content/fleet/3"),
			self.transform:Find("panel/bg/content/fleet/4")
		},
		[FleetType.Submarine] = {
			self.transform:Find("panel/bg/content/sub/1")
		}
	}
	self.rtLimit = self.transform:Find("panel/limit")
	self.rtLimitElite = self.transform:Find("panel/limit_elite")
	self.rtLimitTips = self.transform:Find("panel/limit_tip")
	self.btnBack = self.transform:Find("panel/btnBack")
	self.btnGo = self.transform:Find("panel/start_button")
	self.toggleMask = self.transform:Find("mask")
	self.toggleList = self.transform:Find("mask/list")
	self.toggles = {}

	for iter_3_0 = 0, self.toggleList.childCount - 1 do
		table.insert(self.toggles, self.toggleList:Find("item" .. iter_3_0 + 1))
	end

	setActive(self.rtShipTpl, false)
	setActive(self.rtEmptyTpl, false)
	setActive(self.toggleMask, false)

	return
end

function WSFleetPanel:UpdateMulti(arg_4_1, arg_4_2, arg_4_3)
	self.map = arg_4_1
	self.fleets = _(_.values(arg_4_2)):chain():filter(function(arg_5_0)
		return arg_5_0:isRegularFleet()
	end):sort(function(arg_6_0, arg_6_1)
		return arg_6_0.id < arg_6_1.id
	end):value()
	self.selectIds = {
		[FleetType.Normal] = {},
		[FleetType.Submarine] = {}
	}

	for iter_4_0, iter_4_1 in ipairs(arg_4_3 or {}) do
		local var_4_0 = self:getFleetById(iter_4_1)

		if var_4_0 then
			local var_4_1 = var_4_0:getFleetType()

			if #self.selectIds[var_4_1] < self:getLimitNums(var_4_1) then
				table.insert(self.selectIds[var_4_1], iter_4_1)
			end
		end
	end

	setActive(self.rtLimitElite, false)
	setActive(self.rtLimitTips, false)
	setActive(self.rtLimit, true)
	onButton(self, self.btnGo, function()
		self.onConfirm(self:getSelectIds())

		return
	end, SFX_UI_WEIGHANCHOR_GO)
	onButton(self, self.btnBack, function()
		self.onCancel()

		return
	end, SFX_CANCEL)
	onButton(self, self.transform, function()
		self.onCancel()

		return
	end, SFX_CANCEL)
	onButton(self, self.toggleMask, function()
		self:hideToggleMask()

		return
	end, SFX_CANCEL)
	self:clearFleets()
	self:updateFleets()
	self:updateLimit()

	return
end

function WSFleetPanel:getFleetById(arg_11_1)
	return _.detect(self.fleets, function(arg_12_0)
		return arg_12_0.id == arg_11_1
	end)
end

function WSFleetPanel:getLimitNums(arg_13_1)
	local var_13_0 = 0

	if arg_13_1 == FleetType.Normal then
		var_13_0 = 4
	elseif arg_13_1 == FleetType.Submarine then
		var_13_0 = 1
	end

	return var_13_0
end

function WSFleetPanel:getSelectIds()
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs(self.selectIds) do
		for iter_14_2, iter_14_3 in ipairs(iter_14_1) do
			if iter_14_3 > 0 then
				table.insert(var_14_0, iter_14_3)
			end
		end
	end

	_.sort(var_14_0, function(arg_15_0, arg_15_1)
		return arg_15_0 < arg_15_1
	end)

	return var_14_0
end

function WSFleetPanel:updateFleets()
	for iter_16_0, iter_16_1 in pairs(self.rtFleets) do
		for iter_16_2 = 1, #iter_16_1 do
			self:updateFleet(iter_16_0, iter_16_2)
		end
	end

	return
end

function WSFleetPanel:updateLimit()
	setText(self.rtLimit:Find("number"), string.format("%d/%d", #_.filter(self.selectIds[FleetType.Normal], function(arg_18_0)
		return arg_18_0 > 0
	end), (self:getLimitNums(FleetType.Normal))))
	setText(self.rtLimit:Find("number_sub"), string.format("%d/%d", #_.filter(self.selectIds[FleetType.Submarine], function(arg_19_0)
		return arg_19_0 > 0
	end), (self:getLimitNums(FleetType.Submarine))))

	return
end

function WSFleetPanel:selectFleet(arg_20_1, arg_20_2, arg_20_3)
	if fleetId ~= arg_20_3 then
		if arg_20_3 > 0 and table.contains(self.selectIds[arg_20_1], arg_20_3) then
			return
		end

		if arg_20_1 == FleetType.Normal and self:getLimitNums(arg_20_1) > 0 and arg_20_3 == 0 and #_.filter(self.selectIds[arg_20_1], function(arg_21_0)
			return arg_21_0 > 0
		end) == 1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("level_fleet_lease_one_ship"))

			return
		end

		local var_20_0 = self:getFleetById(arg_20_3)

		if var_20_0 then
			if not var_20_0:isUnlock() then
				return
			end

			if var_20_0:isLegalToFight() ~= true then
				pg.TipsMgr.GetInstance():ShowTips(i18n("level_fleet_not_enough"))

				return
			end
		end

		self.selectIds[arg_20_1][arg_20_2] = arg_20_3

		self:updateFleet(arg_20_1, arg_20_2)
		self:updateLimit()
	end

	return
end

function WSFleetPanel:updateFleet(arg_22_1, arg_22_2)
	local var_22_0 = self:getFleetById(self.selectIds[arg_22_1][arg_22_2])
	local var_22_1 = arg_22_2 <= self:getLimitNums(arg_22_1)
	local var_22_2 = self.rtFleets[arg_22_1][arg_22_2]:Find("bg/name")
	local var_22_3 = self.rtFleets[arg_22_1][arg_22_2]:Find("main")
	local var_22_4 = self.rtFleets[arg_22_1][arg_22_2]:Find("vanguard")
	local var_22_5 = self.rtFleets[arg_22_1][arg_22_2]:Find("sub")
	local var_22_6 = self.rtFleets[arg_22_1][arg_22_2]:Find("btn_select")
	local var_22_7 = self.rtFleets[arg_22_1][arg_22_2]:Find("btn_clear")

	setText(var_22_2, "")
	setActive(self.rtFleets[arg_22_1][arg_22_2]:Find("selected"), false)
	setActive(var_22_6, var_22_1)
	setActive(var_22_7, var_22_1)
	setActive(self.rtFleets[arg_22_1][arg_22_2]:Find("btn_recom"), false)
	setActive(self.rtFleets[arg_22_1][arg_22_2]:Find("blank"), not var_22_1)

	if var_22_3 then
		setActive(var_22_3, var_22_1 and var_22_0)
	end

	if var_22_4 then
		setActive(var_22_4, var_22_1 and var_22_0)
	end

	if var_22_5 then
		setActive(var_22_5, var_22_1 and var_22_0)
	end

	if var_22_1 then
		if var_22_0 then
			setText(var_22_2, (var_22_0.name == "" or nil) and (Fleet.DEFAULT_NAME[var_22_0.id] or var_22_0.name))

			if arg_22_1 == FleetType.Submarine then
				self:updateShips(var_22_5, var_22_0.subShips)
			else
				self:updateShips(var_22_3, var_22_0.mainShips)
				self:updateShips(var_22_4, var_22_0.vanguardShips)
			end
		end

		onButton(self, var_22_6, function()
			self.toggleList.position = (var_22_6.position + var_22_7.position) / 2
			self.toggleList.anchoredPosition = self.toggleList.anchoredPosition + Vector2(-self.toggleList.rect.width / 2, -var_22_6.rect.height / 2)

			self:showToggleMask(arg_22_1, function(arg_24_0)
				self:hideToggleMask()
				self:selectFleet(arg_22_1, arg_22_2, arg_24_0)

				return
			end)

			return
		end, SFX_UI_CLICK)
		onButton(self, var_22_7, function()
			self:selectFleet(arg_22_1, arg_22_2, 0)

			return
		end, SFX_UI_CLICK)
	end

	return
end

function WSFleetPanel:updateShips(arg_26_1, arg_26_2)
	local var_26_0 = UIItemList.New(arg_26_1, self.rtShipTpl)

	var_26_0:make(function(arg_27_0, arg_27_1, arg_27_2)
		if arg_27_0 == UIItemList.EventUpdate then
			local var_27_0 = getProxy(BayProxy):getShipById(arg_26_2[arg_27_1 + 1])

			updateShip(arg_27_2, var_27_0)

			local var_27_1 = arg_27_2:Find("icon_bg/energy")
			local var_27_2 = var_27_0:getEnergeConfig()

			if var_27_2 and var_27_2.id <= 2 then
				setActive(var_27_1, true)
				GetImageSpriteFromAtlasAsync("energy", var_27_2.icon, var_27_1)
			else
				setActive(var_27_1, false)
			end
		end

		return
	end)
	var_26_0:align(#arg_26_2)

	return
end

function WSFleetPanel:showToggleMask(arg_28_1, arg_28_2)
	setActive(self.toggleMask, true)

	local var_28_0 = _.filter(self.fleets, function(arg_29_0)
		return arg_29_0:getFleetType() == arg_28_1
	end)

	for iter_28_0, iter_28_1 in ipairs(self.toggles) do
		local var_28_1 = var_28_0[iter_28_0]

		setActive(iter_28_1, var_28_0[iter_28_0])

		if var_28_0[iter_28_0] then
			local var_28_2, var_28_3 = var_28_0[iter_28_0]:isUnlock()
			local var_28_4 = iter_28_1:Find("lock")

			setButtonEnabled(iter_28_1, var_28_2)
			setActive(var_28_4, not var_28_2)

			if var_28_2 then
				local var_28_5 = table.contains(self.selectIds[arg_28_1], var_28_0[iter_28_0].id)

				setActive(iter_28_1:Find("selected"), var_28_5)
				setActive(iter_28_1:Find("text"), not var_28_5)
				setActive(iter_28_1:Find("text_selected"), var_28_5)
				onButton(self, iter_28_1, function()
					arg_28_2(var_28_1.id)

					return
				end, SFX_UI_TAG)
			else
				onButton(self, var_28_4, function()
					pg.TipsMgr.GetInstance():ShowTips(var_28_3)

					return
				end, SFX_UI_CLICK)
			end
		end
	end

	return
end

function WSFleetPanel:hideToggleMask()
	setActive(self.toggleMask, false)

	return
end

function WSFleetPanel:clearFleets()
	for iter_33_0, iter_33_1 in pairs(self.rtFleets) do
		_.each(iter_33_1, function(arg_34_0)
			self:clearFleet(arg_34_0)

			return
		end)
	end

	return
end

function WSFleetPanel:clearFleet(arg_35_1)
	local var_35_0 = arg_35_1:Find("main")
	local var_35_1 = arg_35_1:Find("vanguard")
	local var_35_2 = arg_35_1:Find("sub")

	if var_35_0 then
		removeAllChildren(var_35_0)
	end

	if var_35_1 then
		removeAllChildren(var_35_1)
	end

	if var_35_2 then
		removeAllChildren(var_35_2)
	end

	return
end

return WSFleetPanel
