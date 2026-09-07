local ArchivesWorldBossAutoBattleTipPage = class("ArchivesWorldBossAutoBattleTipPage", import("view.base.BaseSubView"))

function ArchivesWorldBossAutoBattleTipPage:getUIName()
	return "ArchivesWorldBossAutoBattleTipUI"
end

function ArchivesWorldBossAutoBattleTipPage:OnLoaded()
	self.closeBtn = self._tf:Find("window/top/close")
	self.startBtn = self._tf:Find("window/btns/start")
	self.cancelBtn = self._tf:Find("window/btns/cancel")

	setText(self._tf:Find("window/top/title"), i18n("world_boss_title_auto_battle"))
	setText(self._tf:Find("window/msg_panel/highest_damage/label"), i18n("world_boss_title_highest_damge"))
	setText(self._tf:Find("window/msg_panel/label"), i18n("world_boss_title_estimation"))
	setText(self._tf:Find("window/msg_panel/battle_cnt/label"), i18n("world_boss_title_battle_cnt"))
	setText(self._tf:Find("window/msg_panel/oil/label"), i18n("world_boss_title_consume_oil_cnt"))
	setText(self._tf:Find("window/msg_panel/time/label"), i18n("world_boss_title_spend_time"))
	setText(self._tf:Find("window/btns/cancel/pic"), i18n("word_cancel"))
	setText(self._tf:Find("window/btns/start/pic"), i18n("word_start"))

	self.highestDamageTxt = self._tf:Find("window/msg_panel/highest_damage/Text"):GetComponent(typeof(Text))
	self.battleCntTxt = self._tf:Find("window/msg_panel/battle_cnt/Text"):GetComponent(typeof(Text))
	self.oilTxt = self._tf:Find("window/msg_panel/oil/Text"):GetComponent(typeof(Text))
	self.timeTxt = self._tf:Find("window/msg_panel/time/Text"):GetComponent(typeof(Text))

	return
end

function ArchivesWorldBossAutoBattleTipPage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.startBtn, function()
		if self.OnYes then
			self.OnYes()
		end

		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function ArchivesWorldBossAutoBattleTipPage:Show(arg_8_1)
	ArchivesWorldBossAutoBattleTipPage.super.Show(self)

	self.highestDamageTxt.text = arg_8_1.highestDamage
	self.battleCntTxt.text = arg_8_1.autoBattleCnt > 100 and ">100" or arg_8_1.autoBattleCnt
	self.oilTxt.text = arg_8_1.oil
	self.timeTxt.text = arg_8_1.time .. "MIN"
	self.OnYes = arg_8_1.onYes

	return
end

function ArchivesWorldBossAutoBattleTipPage:Hide()
	ArchivesWorldBossAutoBattleTipPage.super.Hide(self)

	self.OnYes = nil

	return
end

function ArchivesWorldBossAutoBattleTipPage:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return ArchivesWorldBossAutoBattleTipPage
