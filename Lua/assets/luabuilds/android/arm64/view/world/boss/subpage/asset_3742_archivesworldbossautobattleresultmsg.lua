local ArchivesWorldBossAutoBattleResultMsg = class("ArchivesWorldBossAutoBattleResultMsg", import("view.base.BaseSubView"))

function ArchivesWorldBossAutoBattleResultMsg:getUIName()
	return "ArchivesWorldBossAutoBattleResultUI"
end

function ArchivesWorldBossAutoBattleResultMsg:OnLoaded()
	self.closeBtn = self._tf:Find("window/top/close")
	self.confirmBtn = self._tf:Find("window/btns/start")

	setText(self._tf:Find("window/top/title"), i18n("world_boss_title_auto_battle"))
	setText(self._tf:Find("window/msg_panel/label"), i18n("world_boss_archives_auto_battle_reusle_title"))
	setText(self._tf:Find("window/msg_panel/battle_cnt/label"), i18n("world_boss_title_battle_cnt"))
	setText(self._tf:Find("window/msg_panel/damage/label"), i18n("world_boss_title_total_damage"))
	setText(self._tf:Find("window/msg_panel/oil/label"), i18n("world_boss_title_consume_oil_cnt"))
	setText(self._tf:Find("window/btns/start/pic"), i18n("text_confirm"))

	self.battleCntTxt = self._tf:Find("window/msg_panel/battle_cnt/Text"):GetComponent(typeof(Text))
	self.damageTxt = self._tf:Find("window/msg_panel/damage/Text"):GetComponent(typeof(Text))
	self.oilTxt = self._tf:Find("window/msg_panel/oil/Text"):GetComponent(typeof(Text))

	return
end

function ArchivesWorldBossAutoBattleResultMsg:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function ArchivesWorldBossAutoBattleResultMsg:Show(arg_7_1)
	self.battleCntTxt.text = arg_7_1.battleCnt
	self.damageTxt.text = arg_7_1.damage
	self.oilTxt.text = arg_7_1.oil

	ArchivesWorldBossAutoBattleResultMsg.super.Show(self)

	return
end

function ArchivesWorldBossAutoBattleResultMsg:OnDestroy()
	return
end

return ArchivesWorldBossAutoBattleResultMsg
