local SVPoisonPanel = class("SVPoisonPanel", import("view.base.BaseSubView"))

function SVPoisonPanel:getUIName()
	return "SVPoisonPanel"
end

function SVPoisonPanel:OnLoaded()
	return
end

function SVPoisonPanel:OnInit()
	self.rtName = self._tf:Find("window/content/name_mask/name")
	self.rtDesc = self._tf:Find("window/content/intro_view/Viewport/Content/intro")
	self.rtPoisonRate = self._tf:Find("window/content/poison_rate")
	self.rtBg = self._tf:Find("bg")
	self.btnClose = self._tf:Find("window/top/btnBack")
	self.btnConfirm = self._tf:Find("window/button_container/confirm_btn")

	onButton(self, self.rtBg, function()
		self:Hide()

		return
	end, SFX_CANCEL)
	onButton(self, self.btnClose, function()
		self:Hide()

		return
	end, SFX_CANCEL)
	onButton(self, self.btnConfirm, function()
		self:Hide()

		return
	end, SFX_CANCEL)

	return
end

function SVPoisonPanel:OnDestroy()
	return
end

function SVPoisonPanel:Show()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	setActive(self._tf, true)

	return
end

function SVPoisonPanel:Hide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	setActive(self._tf, false)

	return
end

function SVPoisonPanel:Setup(arg_10_1)
	setText(self.rtName, i18n("world_sairen_title"))

	local var_10_0 = Clone(pg.gameset.world_sairen_infection.description)

	table.insert(var_10_0, 1, 0)
	table.insert(var_10_0, 999)
	eachChild(self.rtPoisonRate:Find("bg/ring"), function(arg_11_0)
		local var_11_0 = arg_11_0:GetSiblingIndex() + 1

		if arg_10_1 >= var_10_0[var_11_0] and arg_10_1 < var_10_0[var_11_0 + 1] then
			setActive(arg_11_0, true)

			arg_11_0:GetComponent(typeof(Image)).fillAmount = arg_10_1 / 100

			setText(self.rtDesc, i18n("world_sairen_description" .. var_11_0, arg_10_1))
		else
			setActive(arg_11_0, false)
		end

		setText(self.rtPoisonRate:Find("bg/Text"), arg_10_1 .. "%")

		return
	end)

	return
end

return SVPoisonPanel
