local ArchivesWorldBossChallengePage = class("ArchivesWorldBossChallengePage", import(".BaseWorldBossChallengePage"))

function ArchivesWorldBossChallengePage:getUIName()
	return "ArchivesWorldBossChallengeUI"
end

function ArchivesWorldBossChallengePage:OnFilterBoss(arg_2_1)
	return not WorldBossConst._IsCurrBoss(arg_2_1)
end

function ArchivesWorldBossChallengePage:GetResSuffix()
	return "_archives"
end

function ArchivesWorldBossChallengePage:OnLoaded()
	ArchivesWorldBossChallengePage.super.OnLoaded(self)

	self.switchBtn = self._tf:Find("detail_btn")
	self.currentChallengeBtn = self._tf:Find("current_list_btn")
	self.tipTr = self._tf:Find("tip")

	setText(self.tipTr, i18n("world_boss_archives_boss_tip"))

	return
end

function ArchivesWorldBossChallengePage:OnInit()
	ArchivesWorldBossChallengePage.super.OnInit(self)
	onButton(self, self.switchBtn, function()
		local var_6_0 = nowWorld():GetBossProxy():GetSelfBoss()

		if var_6_0 and WorldBossConst._IsCurrBoss(var_6_0) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("current_boss_was_opened"))
		else
			self:emit(WorldBossScene.ON_SWITCH, WorldBossScene.PAGE_ARCHIVES)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.currentChallengeBtn, function()
		self:emit(WorldBossScene.ON_SWITCH, WorldBossScene.PAGE_CHALLENGE)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.world_archives_boss_help.tip
		})

		return
	end, SFX_PANEL)

	return
end

function ArchivesWorldBossChallengePage:UpdateEmptyCard()
	local var_9_0 = self._tf:Find("list_panel/mask/tpl"):Find("empty"):GetComponent(typeof(Image))

	var_9_0.sprite = WorldBossConst.GetAchieveState() == WorldBossConst.ACHIEVE_STATE_STARTING and GetSpriteFromAtlas("MetaWorldboss/" .. WorldBossConst.BossId2MetaId((WorldBossConst.GetArchivesId())), "item_04") or GetSpriteFromAtlas("MetaWorldboss/extra_empty", "")

	var_9_0:SetNativeSize()

	return
end

return ArchivesWorldBossChallengePage
