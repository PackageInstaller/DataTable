local ForcePlayerNameModificationPage = class("ForcePlayerNameModificationPage", import("view.base.BaseSubView"))

function ForcePlayerNameModificationPage:getUIName()
	return "PlayerVitaeRenamePage"
end

function ForcePlayerNameModificationPage:OnLoaded()
	self.content = self._tf:Find("frame/border/tip"):GetComponent(typeof(Text))
	self.confirmBtn = self._tf:Find("frame/queren")
	self.cancelBtn = self._tf:Find("frame/cancel")
	self.inputField = self._tf:Find("frame/name_field")
	self.prompt = self._tf:Find("frame/border/prompt")

	setText(self._tf:Find("frame/top/title_list/infomation/title"), i18n("change_player_name_title"))
	setText(self._tf:Find("frame/name_field/Placeholder"), i18n("change_player_name_input_tip"))
	setText(self.confirmBtn:Find("Image"), i18n("word_ok"))
	setActive(self.cancelBtn, false)
	setAnchoredPosition(self.confirmBtn, {
		x = -365
	})
	setAnchoredPosition(self.inputField, {
		y = -30
	})
	setAnchoredPosition(self.prompt, {
		y = 43
	})

	local var_2_0 = self.prompt:GetComponent(typeof(Text))

	var_2_0.alignment = TextAnchor.MiddleCenter
	var_2_0.fontSize = 27
	var_2_0.lineSpacing = 0.8
	var_2_0.verticalOverflow = ReflectionHelp.RefGetField(typeof("UnityEngine.VerticalWrapMode"), "Overflow")

	return
end

function ForcePlayerNameModificationPage:OnInit()
	onButton(self, self.confirmBtn, function()
		pg.m02:sendNotification(GAME.CHANGE_PLAYER_NAME, {
			type = 2,
			name = getInputText(self.inputField),
			onSuccess = function()
				setInputText(self.inputField, "")

				if self.callback then
					self.callback()
				end

				self:Hide()

				return
			end
		})

		return
	end, SFX_PANEL)

	return
end

function ForcePlayerNameModificationPage:Show(arg_6_1)
	self.showing = true

	ForcePlayerNameModificationPage.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	setText(self.prompt, (i18n("change_player_name_illegal", getProxy(PlayerProxy):getRawData().name)))

	self.callback = arg_6_1

	return
end

function ForcePlayerNameModificationPage:Hide()
	if self.showing then
		self.showing = false

		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
		ForcePlayerNameModificationPage.super.Hide(self)

		self.callback = nil
	end

	return
end

function ForcePlayerNameModificationPage:OnDestroy()
	self:Hide()

	return
end

return ForcePlayerNameModificationPage
