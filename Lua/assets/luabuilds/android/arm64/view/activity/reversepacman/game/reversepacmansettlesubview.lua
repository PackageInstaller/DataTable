local ReversePacmanSettleSubView = class("ReversePacmanSettleSubView", import("view.base.BaseSubView"))

function ReversePacmanSettleSubView:getUIName()
	return "ReversePacmanSettlePanel"
end

function ReversePacmanSettleSubView:OnLoaded()
	setText(self.uiTipText, i18n("word_click_to_close"))
	setText(self.uiAwardTF:Find("Image/title"), i18n("reverse_pacman_settle_award_title"))
	setText(self.uiFailPanel:Find("tips/Text"), i18n("reverse_pacman_settle_fail_tips"))
	setText(self.uiSuccessPanel:Find("infos/title"), i18n("reverse_pacman_settle_statistics"))
	setText(self.uiFailPanel:Find("infos/title"), i18n("reverse_pacman_settle_statistics"))

	return
end

function ReversePacmanSettleSubView:OnInit()
	onButton(self, self.uiBgTF, function()
		self:Hide()

		return
	end, SOUND_BACK)

	self.awardUIList = UIItemList.New(self.uiAwardTF:Find("list"), self.uiAwardTF:Find("list/tpl"))

	self.awardUIList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			local var_5_0 = self.awards[arg_5_1 + 1]

			updateDrop(arg_5_2, self.awards[arg_5_1 + 1])
			onButton(self, arg_5_2, function()
				self:emit(BaseUI.ON_DROP, var_5_0)

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function ReversePacmanSettleSubView:Show(arg_7_1, arg_7_2)
	ReversePacmanSettleSubView.super.Show(self)

	self.result = arg_7_1.result
	self.time = arg_7_1.useTime
	self.grade = arg_7_1.grade
	self.shipCnt = arg_7_1.shipCnt
	self.monsterCnt = arg_7_1.monsterCnt
	self.awards = arg_7_1.awards or {}

	if self.result == ReversePacmanConst.RESULT_TYPE.SUCCESS then
		self:ShowSuccessPanel()
	else
		self:ShowFailPanel()
	end

	self.hideCallback = arg_7_2

	return
end

function ReversePacmanSettleSubView:ShowSuccessPanel()
	setActive(self.uiSuccessPanel, true)
	setActive(self.uiFailPanel, false)
	setText(self.uiSuccessPanel:Find("infos/time"), i18n("reverse_pacman_settle_time", (string.format("<color=#54FDB6>%s</color>", self.time))))
	setText(self.uiSuccessPanel:Find("infos/arrest"), i18n("reverse_pacman_settle_arrest", self.shipCnt, self.monsterCnt))
	LoadImageSpriteAtlasAsync("ui/reversepacmanui_atlas", "level_" .. self.grade, self.uiGradeTF, true)
	setActive(self.uiAwardTF, #self.awards > 0)
	self.awardUIList:align(#self.awards)

	return
end

function ReversePacmanSettleSubView:ShowFailPanel()
	setActive(self.uiSuccessPanel, false)
	setActive(self.uiFailPanel, true)
	setText(self.uiFailPanel:Find("infos/time"), (string.format("<color=#E54243>%s</color>", i18n("reverse_pacman_settle_timeout"))))
	setText(self.uiFailPanel:Find("infos/escape"), i18n("reverse_pacman_settle_escape"))

	return
end

function ReversePacmanSettleSubView:Hide()
	ReversePacmanSettleSubView.super.Hide(self)
	existCall(self.hideCallback)

	return
end

function ReversePacmanSettleSubView:OnDestroy()
	return
end

return ReversePacmanSettleSubView
