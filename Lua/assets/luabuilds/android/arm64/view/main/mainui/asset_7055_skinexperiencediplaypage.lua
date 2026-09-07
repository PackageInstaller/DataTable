local SkinExperienceDiplayPage = class("SkinExperienceDiplayPage", import("...base.BaseSubView"))

function SkinExperienceDiplayPage:getUIName()
	return "ExSkinListUI"
end

function SkinExperienceDiplayPage:OnLoaded()
	self.uilist = UIItemList.New(self._tf:Find("window/list/content"), self._tf:Find("window/list/content/tpl"))
	self.skinTimers = {}

	return
end

function SkinExperienceDiplayPage:OnInit()
	onButton(self, self._tf:Find("window/top/btnBack"), function()
		self:Hide()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("window/button_container/confirm_btn"), function()
		self:Hide()

		return
	end, SFX_CANCEL)

	return
end

function SkinExperienceDiplayPage:Show(arg_7_1)
	SkinExperienceDiplayPage.super.Show(self)
	self:Display(arg_7_1)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function SkinExperienceDiplayPage:Hide()
	SkinExperienceDiplayPage.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, pg.UIMgr.GetInstance()._normalUIMain)

	return
end

function SkinExperienceDiplayPage:Display(arg_9_1)
	self:Clear()
	self.uilist:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			local var_10_0 = arg_9_1[arg_10_1 + 1]

			setText(arg_10_2:Find("name/Text"), arg_9_1[arg_10_1 + 1]:getConfig("name"))

			if self.skinTimers[arg_9_1[arg_10_1 + 1].id] then
				self.skinTimers[arg_9_1[arg_10_1 + 1].id]:Stop()
			end

			self.skinTimers[arg_9_1[arg_10_1 + 1].id] = Timer.New(function()
				setText(arg_10_2:Find("time/Text"), (skinTimeStamp(var_10_0:getRemainTime())))

				return
			end, 1, -1)

			self.skinTimers[arg_9_1[arg_10_1 + 1].id]:Start()
			self.skinTimers[arg_9_1[arg_10_1 + 1].id].func()

			local var_10_1 = arg_10_2:Find("icon_bg/icon")

			LoadSpriteAsync("qicon/" .. arg_9_1[arg_10_1 + 1]:getIcon(), function(arg_12_0)
				if not IsNil(self._tf) then
					var_10_1:GetComponent(typeof(Image)).sprite = arg_12_0
				end

				return
			end)
		end

		return
	end)
	self.uilist:align(#arg_9_1)

	return
end

function SkinExperienceDiplayPage:Clear()
	for iter_13_0, iter_13_1 in pairs(self.skinTimers) do
		iter_13_1:Stop()
	end

	self.skinTimers = {}

	return
end

function SkinExperienceDiplayPage:OnDestroy()
	self:Clear()

	self.skinTimers = nil

	return
end

return SkinExperienceDiplayPage
