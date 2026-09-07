local CurrentWorldBossChallengePage = class("CurrentWorldBossChallengePage", import(".BaseWorldBossChallengePage"))

CurrentWorldBossChallengePage.Listeners = {
	onPtUpdated = "OnPtUpdated",
	onRankListUpdated = "OnRankListUpdated",
	onCacheBossUpdated = "OnCacheBossUpdated"
}

function CurrentWorldBossChallengePage:getUIName()
	return "CurrentWorldBossChallengeUI"
end

function CurrentWorldBossChallengePage:OnFilterBoss(arg_2_1)
	return WorldBossConst._IsCurrBoss(arg_2_1)
end

function CurrentWorldBossChallengePage:Setup(arg_3_1)
	for iter_3_0, iter_3_1 in pairs(CurrentWorldBossChallengePage.Listeners) do
		self[iter_3_0] = function(...)
			CurrentWorldBossChallengePage[iter_3_1](self, ...)

			return
		end
	end

	self.proxy = arg_3_1

	return
end

function CurrentWorldBossChallengePage:AddListeners(arg_5_1)
	CurrentWorldBossChallengePage.super.AddListeners(self, arg_5_1)
	arg_5_1:AddListener(WorldBossProxy.EventPtUpdated, self.onPtUpdated)

	return
end

function CurrentWorldBossChallengePage:RemoveListeners(arg_6_1)
	CurrentWorldBossChallengePage.super.RemoveListeners(self, arg_6_1)
	arg_6_1:RemoveListener(WorldBossProxy.EventPtUpdated, self.onPtUpdated)

	return
end

function CurrentWorldBossChallengePage:OnPtUpdated(arg_7_1)
	if self.ptBtn then
		self.ptBtn:Update()
	end

	return
end

function CurrentWorldBossChallengePage:OnLoaded()
	CurrentWorldBossChallengePage.super.OnLoaded(self)

	self.awardPage = WorldBossAwardPage.New(self._tf.parent.parent, self.event)
	self.switchBtn = self._tf:Find("detail_btn")
	self.archivesChallengeBtn = self._tf:Find("archives_list_btn")
	self.awardBtn = self._tf:Find("main/award_btn")

	setActive(self.archivesChallengeBtn, not LOCK_WORLDBOSS_ARCHIVES)

	return
end

function CurrentWorldBossChallengePage:OnInit()
	CurrentWorldBossChallengePage.super.OnInit(self)
	onButton(self, self.switchBtn, function()
		local var_10_0 = nowWorld():GetBossProxy():GetSelfBoss()

		if var_10_0 and not WorldBossConst._IsCurrBoss(var_10_0) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("archives_boss_was_opened"))
		else
			self:emit(WorldBossScene.ON_SWITCH, WorldBossScene.PAGE_CURRENT)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.archivesChallengeBtn, function()
		self:emit(WorldBossScene.ON_SWITCH, WorldBossScene.PAGE_ARCHIVES_CHALLENGE)

		return
	end, SFX_PANEL)
	onToggle(self, self._tf:Find("list_panel/frame/filter/toggles/world"), function(arg_12_0)
		if arg_12_0 then
			self.filterFlags[1] = WorldBoss.BOSS_TYPE_WORLD or -1
		end

		self:CheckToggle()
		self:UpdateNonProcessList()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("point/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.world_boss_help_meta.tip
		})

		return
	end, SFX_PANEL)

	self.ptBtn = WorldbossPtBtn.New(self._tf:Find("point"))

	return
end

function CurrentWorldBossChallengePage:CheckToggle()
	CurrentWorldBossChallengePage.super.CheckToggle(self)

	if _.all(self.filterFlags, function(arg_15_0)
		return arg_15_0 == -1
	end) then
		triggerToggle(self._tf:Find("list_panel/frame/filter/toggles/world"), true)
	end

	return
end

function CurrentWorldBossChallengePage:UpdateMainView(arg_16_1, arg_16_2)
	CurrentWorldBossChallengePage.super.UpdateMainView(self, arg_16_1, arg_16_2)
	setActive(self.awardBtn, not arg_16_1:isDeath())
	onButton(self, self.awardBtn, function()
		self.awardPage:ExecuteAction("Update", arg_16_1)

		return
	end, SFX_PANEL)

	return
end

function CurrentWorldBossChallengePage:OnDestroy()
	CurrentWorldBossChallengePage.super.OnDestroy(self)

	if self.awardPage then
		self.awardPage:Destroy()

		self.awardPage = nil
	end

	if self.ptBtn then
		self.ptBtn:Dispose()

		self.ptBtn = nil
	end

	return
end

return CurrentWorldBossChallengePage
