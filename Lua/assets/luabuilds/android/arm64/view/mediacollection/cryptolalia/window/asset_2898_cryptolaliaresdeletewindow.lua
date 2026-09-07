local CryptolaliaResDeleteWindow = class("CryptolaliaResDeleteWindow", import("view.base.BaseSubView"))

function CryptolaliaResDeleteWindow:getUIName()
	return "CryptolaliaResDeleteWindowui"
end

function CryptolaliaResDeleteWindow:OnLoaded()
	self.closeBtn = self._tf:Find("window/top/btnBack")
	self.contentTxt = self._tf:Find("window/content/Text"):GetComponent(typeof(Text))
	self.icon = self._tf:Find("window/content/cover/icon"):GetComponent(typeof(Image))
	self.signature = self._tf:Find("window/content/cover/signature"):GetComponent(typeof(Image))
	self.name = self._tf:Find("window/content/cover/name"):GetComponent(typeof(Text))
	self.shipname = self._tf:Find("window/content/cover/shipname"):GetComponent(typeof(Text))
	self.cancelBtn = self._tf:Find("window/button_container/cancel")
	self.confirmBtn = self._tf:Find("window/button_container/confirm")

	setText(self._tf:Find("window/top/title"), i18n("cryptolalia_delete_res_title"))
	setText(self.cancelBtn:Find("Text"), i18n("text_cancel"))
	setText(self.confirmBtn:Find("Text"), i18n("text_confirm"))

	return
end

function CryptolaliaResDeleteWindow:OnInit()
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
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

function CryptolaliaResDeleteWindow:Show(arg_7_1, arg_7_2)
	CryptolaliaResDeleteWindow.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self.contentTxt.text = i18n("cryptolalia_delete_res_tip", arg_7_1:GetResSize(arg_7_2))
	self.name.text = arg_7_1:GetName()
	self.shipname.text = arg_7_1:GetShipName()

	LoadSpriteAtlasAsync("CryptolaliaShip/" .. arg_7_1:GetShipGroupId(), "cd", function(arg_8_0)
		if self.exited then
			return
		end

		self.icon.sprite = arg_8_0

		self.icon:SetNativeSize()

		return
	end)
	onButton(self, self.confirmBtn, function()
		if IsUnityEditor then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_open"))

			return
		end

		self:Delete(arg_7_1, arg_7_2)
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function CryptolaliaResDeleteWindow:Delete(arg_10_1, arg_10_2)
	if arg_10_1 and arg_10_1:IsPlayableState(arg_10_2) then
		local var_10_0 = arg_10_1:GetCpkName(arg_10_2)

		pg.CipherGroupMgr.GetInstance():DelFile({
			Cryptolalia.BuildCpkPath(var_10_0),
			(Cryptolalia.BuildSubtitlePath(var_10_0))
		})
		self:emit(CryptolaliaScene.ON_DELETE)
	end

	return
end

function CryptolaliaResDeleteWindow:Hide()
	CryptolaliaResDeleteWindow.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function CryptolaliaResDeleteWindow:OnDestroy()
	self.exited = true

	return
end

return CryptolaliaResDeleteWindow
