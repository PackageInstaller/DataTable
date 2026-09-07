local SettingsMsgBosPage = class("SettingsMsgBosPage", import("..base.BaseSubView"))

SettingsMsgBosPage.ALIGN_CENTER = 0
SettingsMsgBosPage.ALIGN_LEFT = 1

function SettingsMsgBosPage:getUIName()
	return "SetttingMsgbox"
end

function SettingsMsgBosPage:OnLoaded()
	self.closeBtn = self._tf:Find("window/top/btnBack")
	self.textTr = self._tf:Find("window/view/content/Text")
	self.text = self.textTr:GetComponent(typeof(Text))
	self.scrollrect = self._tf:Find("window/view/content")

	return
end

function SettingsMsgBosPage:OnInit()
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function SettingsMsgBosPage:Show(arg_6_1, arg_6_2)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	SettingsMsgBosPage.super.Show(self)

	self.text.text = arg_6_1

	self:UpdateLayout(arg_6_2 or SettingsMsgBosPage.ALIGN_CENTER)

	self.scrollrect:GetComponent(typeof(ScrollRect)).verticalNormalizedPosition = 1

	self._tf:SetAsLastSibling()

	return
end

function SettingsMsgBosPage:UpdateLayout(arg_7_1)
	local var_7_0 = Vector2(0.5, 0.5)
	local var_7_1 = TextAnchor.MiddleCenter

	if arg_7_1 == SettingsMsgBosPage.ALIGN_LEFT then
		var_7_0 = Vector2(0, 1)
		var_7_1 = TextAnchor.UpperLeft
	end

	self.textTr.pivot = var_7_0
	self.text.alignment = var_7_1

	setAnchoredPosition(self.textTr, {
		x = self.textTr:GetComponent(typeof(LayoutElement)).preferredWidth * (var_7_0.x - 0.5)
	})

	return
end

function SettingsMsgBosPage:Hide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	SettingsMsgBosPage.super.Hide(self)

	self.text.text = ""

	return
end

function SettingsMsgBosPage:OnDestroy()
	self:Hide()

	return
end

return SettingsMsgBosPage
