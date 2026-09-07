local ArchivesWorldBossEmptyPage = class("ArchivesWorldBossEmptyPage", import(".BaseWorldBossEmptyPage"))

function ArchivesWorldBossEmptyPage:getUIName()
	return "ArchivesWorldBossEmptyUI"
end

function ArchivesWorldBossEmptyPage:OnInit()
	ArchivesWorldBossEmptyPage.super.OnInit(self)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.world_archives_boss_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("list_btn"), function()
		self:emit(WorldBossScene.ON_SWITCH, WorldBossScene.PAGE_ARCHIVES_CHALLENGE)

		return
	end, SFX_PANEL)
	onButton(self, self.activeBtn, function()
		local var_5_0 = WorldBossConst.GetAchieveState()

		if var_5_0 == WorldBossConst.ACHIEVE_STATE_NOSTART then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_no_select_archives"))
		elseif var_5_0 == WorldBossConst.ACHIEVE_STATE_STARTING then
			if WorldBossConst.CanUnlockArchivesBoss() then
				self:emit(WorldBossMediator.ON_ACTIVE_ARCHIVES_BOSS)
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_archives_item_count_noenough"))
			end
		elseif var_5_0 == WorldBossConst.ACHIEVE_STATE_CLEAR then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_archives_are_clear"))
		end

		return
	end, SFX_PANEL)
	onButton(self, self.progressTr, function()
		local var_6_0 = WorldBossConst.GetAchieveBossItemInfo()

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			type = MSGBOX_TYPE_DROP_ITEM,
			name = var_6_0.name,
			content = var_6_0.display,
			iconPath = var_6_0.icon,
			frame = var_6_0.rarity
		})

		return
	end, SFX_PANEL)

	if not pg.NewStoryMgr.GetInstance():IsPlayed("WorldG193") then
		WorldGuider.GetInstance():PlayGuide("WorldG193")
	end

	return
end

function ArchivesWorldBossEmptyPage:OnUpdate()
	self.archivesWorldbossBtn = self.archivesWorldbossBtn or ArchivesWorldbossBtn.New(self._tf:Find("archives_btn"), self.event)

	local var_7_0 = WorldBossConst.GetAchieveState()
	local var_7_1

	if var_7_0 == WorldBossConst.ACHIEVE_STATE_NOSTART then
		var_7_1 = "text04"
	elseif var_7_0 == WorldBossConst.ACHIEVE_STATE_CLEAR then
		var_7_1 = "text05"
	end

	if var_7_1 then
		local var_7_2 = self.noItem:GetComponent(typeof(Image))

		GetSpriteFromAtlasAsync("ui/WorldBossUI_atlas", var_7_1, function(arg_8_0)
			var_7_2.sprite = arg_8_0

			return
		end)
		var_7_2:SetNativeSize()
	end

	local var_7_3 = WorldBossConst.GetAchieveState() == WorldBossConst.ACHIEVE_STATE_STARTING

	if var_7_3 then
		self:UpdateUseItemStyle((WorldBossConst.BossId2MetaId((WorldBossConst.GetArchivesId()))))
	end

	setActive(self.useItem, var_7_3)
	setActive(self.noItem, not var_7_3)
	self.archivesWorldbossBtn:Flush()

	return
end

function ArchivesWorldBossEmptyPage:OnUpdateRes()
	if not self.progressTxt then
		return
	end

	local var_9_0, var_9_1, var_9_2 = WorldBossConst.GetAchieveBossConsume()

	self.progressTxt.text = WorldBossConst.GetAchieveBossItemProgress() .. "/" .. var_9_2

	return
end

function ArchivesWorldBossEmptyPage:OnDestroy()
	ArchivesWorldBossEmptyPage.super.OnDestroy(self)

	if self.archivesWorldbossBtn then
		self.archivesWorldbossBtn:Dispose()

		self.archivesWorldbossBtn = nil
	end

	return
end

return ArchivesWorldBossEmptyPage
