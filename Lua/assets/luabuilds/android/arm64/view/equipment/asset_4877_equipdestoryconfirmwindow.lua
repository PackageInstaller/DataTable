local EquipDestoryConfirmWindow = class("EquipDestoryConfirmWindow", import("view.base.BaseSubView"))

function EquipDestoryConfirmWindow:getUIName()
	return "DestoryConfirmWindow"
end

function EquipDestoryConfirmWindow:OnLoaded()
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

function EquipDestoryConfirmWindow:OnInit()
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

function EquipDestoryConfirmWindow:SetCallBack(arg_8_1)
	self.callback = arg_8_1

	return
end

function EquipDestoryConfirmWindow:Confirm()
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

function EquipDestoryConfirmWindow:Show(arg_10_1, arg_10_2)
	EquipDestoryConfirmWindow.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self.key = nil
	self.equips = arg_10_1

	self:SetCallBack(arg_10_2)
	self:Updatelayout()
	self:UpdateEquips()

	return
end

function EquipDestoryConfirmWindow:Updatelayout()
	local var_11_0 = {}

	if underscore.any(self.equips, function(arg_12_0)
		return arg_12_0:getConfig("rarity") >= 4
	end) then
		table.insert(var_11_0, i18n("destroy_high_rarity_tip"))
	end

	if underscore.any(self.equips, function(arg_13_0)
		return arg_13_0:getConfig("level") > 1
	end) then
		table.insert(var_11_0, i18n("destroy_high_intensify_tip", ""))
	end

	if #var_11_0 == 0 then
		table.insert(var_11_0, i18n("destroy_importantequipment_tip"))
	end

	setText(self.title, i18n("destroy_eliteequipment_tip", table.concat(var_11_0, ",")))

	local var_11_1 = underscore.any(self.equips, function(arg_14_0)
		return arg_14_0:isImportance()
	end)

	if var_11_1 and not self.key then
		self.key = math.random(100000, 999999)

		setText(self.urLabel, i18n("destroy_equip_rarity_tip", self.key))
	else
		setText(self.urLabel, "")
	end

	setActive(self.urOverflowLabel, false)
	setActive(self.urLabel, var_11_1)
	setActive(self.urInput, var_11_1)

	return
end

function EquipDestoryConfirmWindow:UpdateEquips()
	mergeSort(self.equips, CompareFuncs({
		function(arg_16_0)
			return -arg_16_0:getConfig("rarity")
		end,
		function(arg_17_0)
			return -arg_17_0:getConfig("level")
		end
	}, true))

	if #self.equips > 5 then
		setActive(self._tf:Find("window/content/ships"), true)
		setActive(self._tf:Find("window/content/ships_single"), false)

		local var_15_0 = self._tf:Find("window/content/ships/content"):GetComponent("LScrollRect")

		function var_15_0.onUpdateItem(arg_18_0, arg_18_1)
			updateEquipment(tf(arg_18_1), self.equips[arg_18_0 + 1])

			return
		end

		onNextTick(function()
			var_15_0:SetTotalCount(#self.equips)

			return
		end)
	else
		local var_15_1 = self._tf:Find("window/content/ships_single")
		local var_15_2 = UIItemList.New(var_15_1, var_15_1:Find("IconTpl"))

		setActive(self._tf:Find("window/content/ships"), false)
		setActive(self._tf:Find("window/content/ships_single"), true)
		var_15_2:make(function(arg_20_0, arg_20_1, arg_20_2)
			if arg_20_0 == UIItemList.EventUpdate then
				updateEquipment(arg_20_2, self.equips[arg_20_1 + 1])
			end

			return
		end)
		var_15_2:align(#self.equips)
	end

	return
end

function EquipDestoryConfirmWindow:Hide()
	EquipDestoryConfirmWindow.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	self.key = nil
	self.callback = nil

	setInputText(self.urInput, "")

	return
end

function EquipDestoryConfirmWindow:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return EquipDestoryConfirmWindow
