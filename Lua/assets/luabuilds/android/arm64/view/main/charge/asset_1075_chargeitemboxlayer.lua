local ChargeItemBoxLayer = class("ChargeItemBoxLayer", import("...base.BaseUI"))

function ChargeItemBoxLayer:getUIName()
	return "ChargeItemBoxUI"
end

function ChargeItemBoxLayer:init()
	self:initData()
	self:findUI()
	self:addListener()
	self:initUIText()

	return
end

function ChargeItemBoxLayer:didEnter()
	self:updatePanel()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function ChargeItemBoxLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function ChargeItemBoxLayer:initData()
	self.panelConfig = self.contextData.panelConfig

	return
end

function ChargeItemBoxLayer:initUIText()
	setText(self._tf:Find("window/button_container/button_cancel/Image"), i18n("text_cancel"))
	setText(self._tf:Find("window/button_container/button_ok/Image"), i18n("text_buy"))

	return
end

function ChargeItemBoxLayer:findUI()
	self.bg = self._tf:Find("back_sign")
	self.detailWindow = self._tf:Find("window")
	self.cancelBtn = self.detailWindow:Find("button_container/button_cancel")
	self.confirmBtn = self.detailWindow:Find("button_container/button_ok")
	self.detailName = self.detailWindow:Find("goods/name")
	self.detailIcon = self.detailWindow:Find("goods/icon")
	self.detailRmb = self.detailWindow:Find("prince_bg/contain/icon_rmb")
	self.detailGem = self.detailWindow:Find("prince_bg/contain/icon_gem")
	self.detailPrice = self.detailWindow:Find("prince_bg/contain/Text")
	self.detailTag = self.detailWindow:Find("goods/tag")
	self.detailTags = {}

	table.insert(self.detailTags, self.detailTag:Find("hot"))
	table.insert(self.detailTags, self.detailTag:Find("new"))
	table.insert(self.detailTags, self.detailTag:Find("advice"))
	table.insert(self.detailTags, self.detailTag:Find("double"))
	table.insert(self.detailTags, self.detailTag:Find("discount"))

	self.detailTagAdviceTF = self.detailTags[3]
	self.detailTagDoubleTF = self.detailTags[4]
	self.detailNormalTip = self.detailWindow:Find("NormalTips")

	return
end

function ChargeItemBoxLayer:addListener()
	onButton(self, self.bg, function()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		if self.panelConfig.onYes then
			self.panelConfig.onYes()
			self:closeView()
		end

		return
	end, SFX_PANEL)

	return
end

function ChargeItemBoxLayer:updatePanel()
	local var_12_0 = self.panelConfig.icon
	local var_12_1

	if self.panelConfig.name then
		var_12_1 = self.panelConfig.name or ""

		if not self.panelConfig.tipBonus then
			-- block empty
		end
	end

	if not self.panelConfig.tipExtra or not self.panelConfig.tipExtra then
		-- block empty
	end

	if not self.panelConfig.extraItems or not self.panelConfig.extraItems then
		-- block empty
	end

	local var_12_6

	if self.panelConfig.price then
		var_12_6 = self.panelConfig.price or 0
	end

	local var_12_7 = self.panelConfig.isChargeType
	local var_12_8 = self.panelConfig.isLocalPrice
	local var_12_10 = self.panelConfig.tagType

	if self.detailNormalTip then
		setActive(self.detailNormalTip, self.panelConfig.normalTip)
	end

	if self.panelConfig.normalTip then
		if self.detailNormalTip:GetComponent("Text") then
			setText(self.detailNormalTip, self.panelConfig.normalTip)
		else
			setButtonText(self.detailNormalTip, self.panelConfig.normalTip)
		end
	end

	setActive(self.detailTag, var_12_10 > 0)

	if var_12_10 > 0 then
		for iter_12_0, iter_12_1 in ipairs(self.detailTags) do
			setActive(iter_12_1, iter_12_0 == var_12_10)
		end
	end

	GetImageSpriteFromAtlasAsync(var_12_0, "", self.detailIcon, false)
	setText(self.detailName, var_12_1)

	if PLATFORM_CODE == PLATFORM_CHT then
		setActive(self.detailRmb, var_12_7 and not var_12_8)
	else
		setActive(self.detailRmb, var_12_7)
	end

	setActive(self.detailGem, not var_12_7)
	setText(self.detailPrice, var_12_6)

	return
end

return ChargeItemBoxLayer
