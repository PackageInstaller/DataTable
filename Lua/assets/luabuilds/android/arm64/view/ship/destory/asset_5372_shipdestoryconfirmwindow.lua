local ShipDestoryConfirmWindow = class("ShipDestoryConfirmWindow", import("...base.BaseSubView"))

function ShipDestoryConfirmWindow:getUIName()
	return "DestoryConfirmWindow"
end

function ShipDestoryConfirmWindow:OnLoaded()
	self.closeBtn = self._tf:Find("window/top/btnBack")

	setActive(self._tf:Find("window/top/bg/infomation/title_en"), PLATFORM_CODE ~= PLATFORM_US)
	setText(self._tf:Find("window/top/bg/infomation/title"), i18n("title_info"))

	self.cancelBtn = self._tf:Find("window/cancel_btn")
	self.confirmBtn = self._tf:Find("window/confirm_btn")

	setText(findTF(self.confirmBtn, "pic"), i18n("destroy_confirm_access"))
	setText(findTF(self.cancelBtn, "pic"), i18n("destroy_confirm_cancel"))

	self.title = self._tf:Find("window/content/Text")
	self.label = self._tf:Find("window/content/desc/label")

	setText(self.label, i18n("destory_ship_before_tip"))

	self.urLabel = self._tf:Find("window/content/desc/label1")
	self.urInput = self._tf:Find("window/content/desc/InputField")
	self.urOverflowLabel = self._tf:Find("window/content/desc/label2")

	setText(self.urOverflowLabel, i18n("destory_ur_pt_overflowa"))
	setText(self.urInput:Find("Placeholder"), i18n("box_ship_del_click"))

	return
end

function ShipDestoryConfirmWindow:OnInit()
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		self:Confirm()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("bg"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function ShipDestoryConfirmWindow:SetCallBack(arg_8_1)
	self.callback = arg_8_1

	return
end

function ShipDestoryConfirmWindow:Confirm()
	if self.key then
		if self.key ~= tonumber((getInputText(self.urInput))) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("destory_ship_input_erro"))

			return
		end

		local var_9_0 = self.callback

		self:Hide()
		existCall(var_9_0)
	else
		local var_9_1 = self.callback

		self:Hide()
		existCall(var_9_1)
	end

	return
end

function ShipDestoryConfirmWindow:ShowOneShipProtect(arg_10_1, arg_10_2)
	ShipDestoryConfirmWindow.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self.key = nil
	self.ships = arg_10_1

	self:SetCallBack(arg_10_2)
	setText(self.title, i18n("unique_ship_tip1"))

	self.key = math.random(100000, 999999)

	setText(self.urLabel, i18n("unique_ship_tip2", self.key))
	setActive(self.urLabel, true)
	setActive(self.urInput, true)
	setActive(self.urOverflowLabel, false)
	mergeSort(self.ships, CompareFuncs({
		function(arg_11_0)
			return -arg_11_0.level
		end,
		function(arg_12_0)
			return -arg_12_0:getRarity()
		end
	}, true))

	if #self.ships > 5 then
		setActive(self._tf:Find("window/content/ships"), true)
		setActive(self._tf:Find("window/content/ships_single"), false)

		local var_10_0 = self._tf:Find("window/content/ships/content"):GetComponent("LScrollRect")

		function var_10_0.onUpdateItem(arg_13_0, arg_13_1)
			updateShip(tf(arg_13_1), self.ships[arg_13_0 + 1])

			return
		end

		onNextTick(function()
			var_10_0:SetTotalCount(#self.ships)

			return
		end)
	else
		setActive(self._tf:Find("window/content/ships"), false)
		setActive(self._tf:Find("window/content/ships_single"), true)

		local var_10_1 = self._tf:Find("window/content/ships_single")
		local var_10_2 = UIItemList.New(var_10_1, var_10_1:Find("IconTpl"))

		var_10_2:make(function(arg_15_0, arg_15_1, arg_15_2)
			if arg_15_0 == UIItemList.EventUpdate then
				updateShip(arg_15_2, self.ships[arg_15_1 + 1])
			end

			return
		end)
		var_10_2:align(#self.ships)
	end

	return
end

function ShipDestoryConfirmWindow:Show(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	ShipDestoryConfirmWindow.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self.key = nil
	self.eliteShips = arg_16_1
	self.highLevelShips = arg_16_2
	self.overflow = arg_16_3

	self:SetCallBack(arg_16_4)
	self:Updatelayout()
	self:UpdateShips()

	return
end

function ShipDestoryConfirmWindow:ShowEliteTag(arg_17_1, arg_17_2)
	ShipDestoryConfirmWindow.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:SetCallBack(arg_17_2)
	setText(self.title, i18n("destroy_eliteship_tip", i18n("destroy_inHardFormation_tip")))
	setActive(self.urOverflowLabel, false)
	setActive(self.urLabel, false)
	setActive(self.urInput, false)

	self.ships = arg_17_1

	if #self.ships > 5 then
		setActive(self._tf:Find("window/content/ships"), true)
		setActive(self._tf:Find("window/content/ships_single"), false)

		local var_17_0 = self._tf:Find("window/content/ships/content"):GetComponent("LScrollRect")

		function var_17_0.onUpdateItem(arg_18_0, arg_18_1)
			updateShip(tf(arg_18_1), self.ships[arg_18_0 + 1])

			return
		end

		onNextTick(function()
			var_17_0:SetTotalCount(#self.ships)

			return
		end)
	else
		setActive(self._tf:Find("window/content/ships"), false)
		setActive(self._tf:Find("window/content/ships_single"), true)

		local var_17_1 = self._tf:Find("window/content/ships_single")
		local var_17_2 = UIItemList.New(var_17_1, var_17_1:Find("IconTpl"))

		var_17_2:make(function(arg_20_0, arg_20_1, arg_20_2)
			if arg_20_0 == UIItemList.EventUpdate then
				updateShip(arg_20_2, self.ships[arg_20_1 + 1])
			end

			return
		end)
		var_17_2:align(#self.ships)
	end

	return
end

function ShipDestoryConfirmWindow:Updatelayout()
	local var_21_0 = {}

	if #self.eliteShips > 0 then
		table.insert(var_21_0, i18n("destroy_high_rarity_tip"))
	end

	if #self.highLevelShips > 0 then
		table.insert(var_21_0, i18n("destroy_high_level_tip", ""))
	end

	setText(self.title, i18n("destroy_eliteship_tip", table.concat(var_21_0, "、")))

	local var_21_1 = _.any(self.eliteShips, function(arg_22_0)
		return arg_22_0:getConfig("rarity") >= ShipRarity.SSR
	end)

	if var_21_1 and not self.key then
		self.key = math.random(100000, 999999)

		setText(self.urLabel, i18n("destroy_ur_rarity_tip", self.key))
	end

	local var_21_2

	do
		setText(self.urLabel, "")

		var_21_2 = setActive
	end

	var_21_2(self.urOverflowLabel, var_21_1 and self.overflow)
	setActive(self.urLabel, var_21_1)
	setActive(self.urInput, var_21_1)

	return
end

function ShipDestoryConfirmWindow:UpdateShips()
	local var_23_0 = table.mergeArray(self.highLevelShips, self.eliteShips)

	mergeSort(var_23_0, CompareFuncs({
		function(arg_24_0)
			return -arg_24_0.level
		end,
		function(arg_25_0)
			return -arg_25_0:getRarity()
		end
	}, true))

	self.ships = var_23_0

	if #self.ships > 5 then
		setActive(self._tf:Find("window/content/ships"), true)
		setActive(self._tf:Find("window/content/ships_single"), false)

		local var_23_1 = self._tf:Find("window/content/ships/content"):GetComponent("LScrollRect")

		function var_23_1.onUpdateItem(arg_26_0, arg_26_1)
			updateShip(tf(arg_26_1), self.ships[arg_26_0 + 1])

			return
		end

		onNextTick(function()
			var_23_1:SetTotalCount(#self.ships)

			return
		end)
	else
		setActive(self._tf:Find("window/content/ships"), false)
		setActive(self._tf:Find("window/content/ships_single"), true)

		local var_23_2 = self._tf:Find("window/content/ships_single")
		local var_23_3 = UIItemList.New(var_23_2, var_23_2:Find("IconTpl"))

		var_23_3:make(function(arg_28_0, arg_28_1, arg_28_2)
			if arg_28_0 == UIItemList.EventUpdate then
				updateShip(arg_28_2, self.ships[arg_28_1 + 1])
			end

			return
		end)
		var_23_3:align(#self.ships)
	end

	return
end

function ShipDestoryConfirmWindow:Hide()
	ShipDestoryConfirmWindow.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	self.key = nil
	self.callback = nil

	setInputText(self.urInput, "")

	return
end

function ShipDestoryConfirmWindow:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return ShipDestoryConfirmWindow
