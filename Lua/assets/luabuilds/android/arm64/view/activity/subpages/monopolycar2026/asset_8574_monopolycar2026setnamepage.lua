local MonopolyCar2026SetNamePage = class("MonopolyCar2026SetNamePage", import("view.base.BaseSubView"))

function MonopolyCar2026SetNamePage:getUIName()
	return "MonopolyCar2026SetNameUI"
end

function MonopolyCar2026SetNamePage:OnLoaded()
	self.confirmBtn = self._tf:Find("btn")
	self.input = self._tf:Find("main/input")
	self.bgTr = self._tf:Find("bg")

	setText(self.confirmBtn:Find("Text"), i18n("word_ok"))

	return
end

function MonopolyCar2026SetNamePage:OnInit()
	onButton(self, self.confirmBtn, function()
		local var_4_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MONOPOLY)

		if not var_4_0 or var_4_0:isEnd() then
			if self.callback then
				self.callback()
			end

			return
		end

		local var_4_1 = var_4_0:getConfig("config_client").link_act
		local var_4_2 = getInputText(self.input)

		if var_4_2 == "" then
			return
		end

		if not nameValidityCheck(var_4_2, 0, 20, {
			"spece_illegal_tip",
			"login_newPlayerScene_name_tooShort",
			"login_newPlayerScene_name_tooLong",
			"playerinfo_mask_word"
		}) then
			return
		end

		pg.m02:sendNotification(GAME.ACTIVITY_STORE_DATE, {
			intValue = 0,
			activity_id = var_4_1,
			strValue = var_4_2 or "",
			callback = function()
				if self.callback then
					self.callback()
				end

				return
			end
		})

		return
	end, SFX_PANEL)

	return
end

function MonopolyCar2026SetNamePage:Show(arg_6_1)
	self.callback = arg_6_1

	MonopolyCar2026SetNamePage.super.Show(self)
	self:BlurPanel()

	return
end

function MonopolyCar2026SetNamePage:BlurPanel()
	setParent(self.bgTr, pg.NewStoryMgr.GetInstance()._go)
	setParent(pg.NewStoryMgr.GetInstance()._go, pg.UIMgr.GetInstance().UIMain)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function MonopolyCar2026SetNamePage:UnBlurPanel()
	setParent(self.bgTr, self._tf)
	self.bgTr:SetAsFirstSibling()
	setParent(pg.NewStoryMgr.GetInstance()._go, pg.UIMgr.GetInstance().OverlayToast)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function MonopolyCar2026SetNamePage:Hide()
	self:UnBlurPanel()
	MonopolyCar2026SetNamePage.super.Hide(self)

	return
end

function MonopolyCar2026SetNamePage:OnDestroy()
	self.callback = nil

	if self:isShowing() then
		self:Hide()
	end

	return
end

return MonopolyCar2026SetNamePage
