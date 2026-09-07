local IslandSystemUnlockPage = class("IslandSystemUnlockPage", import(".Island3dTaskAcceptPage"))

function IslandSystemUnlockPage:getUIName()
	return "IslandSystemUnlockMsgBox"
end

function IslandSystemUnlockPage:Show(arg_2_1, arg_2_2)
	IslandSystemUnlockPage.super.super.Show(self)
	self:BlurPanel()
	setText(self.tipText, i18n("word_unlock"))

	local var_2_1 = string.split((not (pg.island_ability_template[arg_2_1] or {}).show_pop_text or nil) and "", "|")

	setText(self.chapterText, var_2_1[2] or "")
	setText(self.nameText, var_2_1[1] or "")

	self.onExit = arg_2_2

	local var_2_2 = self._tf:GetComponent(typeof(Animation))
	local var_2_3 = self._tf:GetComponent(typeof(DftAniEvent))

	var_2_3:SetEndEvent(function()
		var_2_3:SetEndEvent(nil)
		var_2_2:Play("Anim_Island3dTaskAcceptUI_loop")

		self.onAnimationLoop = true

		return
	end)

	return
end

function IslandSystemUnlockPage:BlurPanel()
	pg.UIMgr.GetInstance():BlurPanel(self._go.transform)

	self.isBlurPanel = true

	return
end

function IslandSystemUnlockPage:UnBlurPanel()
	if self.isBlurPanel then
		pg.UIMgr.GetInstance():UnOverlayPanel(self._go.transform, pg.UIMgr.GetInstance().UIMain)
	end

	self.isBlurPanel = false

	return
end

function IslandSystemUnlockPage:OnDestroy()
	IslandSystemUnlockPage.super.OnDestroy(self)
	self:UnBlurPanel()

	return
end

function IslandSystemUnlockPage:Hide()
	IslandSystemUnlockPage.super.Hide(self)
	self:UnBlurPanel()

	return
end

function IslandSystemUnlockPage:TouchEvent()
	local var_8_0 = self._tf:GetComponent(typeof(Animation))

	if not self.onAnimationLoop then
		var_8_0:Play("Anim_Island3dTaskAcceptUI_loop")

		self.onAnimationLoop = true

		return
	end

	local var_8_1 = self._tf:GetComponent(typeof(DftAniEvent))

	var_8_1:SetEndEvent(function()
		var_8_1:SetEndEvent(nil)

		if self.onExit then
			self.onExit()

			self.onExit = nil
		end

		self:Hide()

		return
	end)
	var_8_0:Play("Anim_Island3dTaskAcceptUI_out")

	return
end

return IslandSystemUnlockPage
