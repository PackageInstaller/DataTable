local SkinExpireDisplayPage = class("SkinExpireDisplayPage", import("...base.BaseSubView"))

function SkinExpireDisplayPage:getUIName()
	return "SkinOverDueUI"
end

function SkinExpireDisplayPage:OnLoaded()
	self.uilist = UIItemList.New(self._tf:Find("window/list/scrollrect/content"), self._tf:Find("window/list/scrollrect/content/tpl"))

	return
end

function SkinExpireDisplayPage:OnInit()
	onButton(self, self._tf:Find("window/button_container/confirm_btn"), function()
		self:Hide()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("window/top/btnBack"), function()
		self:Hide()

		return
	end, SFX_CANCEL)

	return
end

function SkinExpireDisplayPage:Show(arg_7_1)
	SkinExpireDisplayPage.super.Show(self)
	self:Display(arg_7_1)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function SkinExpireDisplayPage:Display(arg_8_1)
	self.uilist:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			setText(arg_9_2:Find("name/Text"), arg_8_1[arg_9_1 + 1]:getConfig("name"))

			local var_9_0 = arg_9_2:Find("icon_bg/icon")

			LoadSpriteAsync("qicon/" .. arg_8_1[arg_9_1 + 1]:getIcon(), function(arg_10_0)
				if not IsNil(self._tf) then
					var_9_0:GetComponent(typeof(Image)).sprite = arg_10_0
				end

				return
			end)
		end

		return
	end)
	self.uilist:align(#arg_8_1)

	return
end

function SkinExpireDisplayPage:OnDestroy()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, pg.UIMgr.GetInstance()._normalUIMain)

	return
end

return SkinExpireDisplayPage
