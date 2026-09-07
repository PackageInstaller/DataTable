local BuildShipHelpWindow = class("BuildShipHelpWindow", import("...base.BaseSubView"))

function BuildShipHelpWindow:getUIName()
	return "BuildShipHelpWindowUI"
end

function BuildShipHelpWindow:OnLoaded()
	self.shipListTF = self._tf:Find("window/list/scrollview/list")
	self.shipListTpl = self._tf:Find("window/list/scrollview/item")

	setActive(self.shipListTpl, false)

	self.tipListTF = self._tf:Find("window/rateList/scrollview/list")
	self.tipListTpl = self._tf:Find("window/rateList/scrollview/item")

	setText(self._tf:Find("window/confirm_btn/Image/Image (1)"), i18n("text_confirm"))

	return
end

function BuildShipHelpWindow:OnInit()
	onButton(self, self._tf:Find("window/close_btn"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("window/confirm_btn"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function BuildShipHelpWindow:Show(arg_7_1, arg_7_2, arg_7_3)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self.isSupport = arg_7_2 == "support"

	local var_7_0 = self._tf:Find("window/rateList/title/Text")

	if self.isSupport then
		setText(var_7_0, i18n("support_rate_title"))
	else
		setText(var_7_0, i18n("build_rate_title"))
	end

	setActive(var_7_0, false)
	setActive(var_7_0, true)
	self:OnShow(arg_7_1, arg_7_3)
	setActiveViaLayer(self._tf, true)
	self:PlayOpenAnimation()

	return
end

function BuildShipHelpWindow:OnShow(arg_8_1, arg_8_2)
	self.showing = true

	for iter_8_0 = 1, self.shipListTF.childCount do
		local var_8_0 = self.shipListTF:GetChild(iter_8_0 - 1)

		if var_8_0 then
			setActive(var_8_0, false)
		end
	end

	local var_8_1 = self.tipListTF.childCount

	for iter_8_1 = 1, self.tipListTF.childCount do
		local var_8_2 = self.tipListTF:GetChild(iter_8_1 - 1)

		if var_8_2 then
			setActive(var_8_2, false)
		end
	end

	local var_8_3 = getProxy(ActivityProxy)
	local var_8_4

	if not self.isSupport then
		var_8_4 = arg_8_2 and var_8_3:getBuildActivityCfgByID(arg_8_1.id) or var_8_3:getNoneActBuildActivityCfgByID(arg_8_1.id)
	end

	local var_8_5

	if var_8_4 then
		var_8_5 = var_8_4.rate_tip or arg_8_1.rate_tip
	end

	for iter_8_2 = 1, #var_8_5 do
		local var_8_6 = iter_8_2 <= var_8_1 and self.tipListTF:GetChild(iter_8_2 - 1) or cloneTplTo(self.tipListTpl, self.tipListTF)

		if var_8_6 then
			setActive(var_8_6, true)
			setText(var_8_6, HXSet.hxLan(var_8_5[iter_8_2]))
		end
	end

	return
end

function BuildShipHelpWindow:Hide()
	self.showing = false

	setActiveViaLayer(self._tf, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._tf)

	return
end

function BuildShipHelpWindow:isShowing()
	return self.showing
end

function BuildShipHelpWindow:OnDestroy()
	return
end

function BuildShipHelpWindow:PlayOpenAnimation()
	local var_12_0 = self._tf:Find("window/bg_decorations"):GetComponent(typeof(Animation))

	var_12_0:Stop()
	var_12_0:Play("anim_window_bg")

	local var_12_1 = self._tf:Find("window/title"):GetComponent(typeof(Animation))

	var_12_1:Stop()
	var_12_1:Play("anim_top")

	local var_12_2 = self._tf:Find("window"):GetComponent(typeof(Animation))

	var_12_2:Stop()
	var_12_2:Play("anim_content")

	local var_12_3 = self._tf:Find("print"):GetComponent(typeof(Animation))

	var_12_3:Stop()
	var_12_3:Play("anim_bg_plus")

	local var_12_4 = self._tf:Find("window/confirm_btn"):GetComponent(typeof(Animation))

	var_12_4:Stop()
	var_12_4:Play("anim_button_container")

	return
end

return BuildShipHelpWindow
