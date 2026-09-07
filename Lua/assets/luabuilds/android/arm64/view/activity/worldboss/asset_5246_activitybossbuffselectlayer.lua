local ActivityBossBuffSelectLayer = class("ActivityBossBuffSelectLayer", import("view.base.BaseUI"))

function ActivityBossBuffSelectLayer:getUIName()
	return "ActivityBossBuffSelectUI"
end

function ActivityBossBuffSelectLayer:init()
	self.buffList = self._tf:Find("BuffList")
	self.buffScrollComp = self.buffList:Find("ScrollView"):GetComponent("LScrollRect")
	self.activeBuffRect = self._tf:Find("Active")
	self.activeBuffScrollComp = self.activeBuffRect:Find("ScrollView"):GetComponent("LScrollRect")
	self.startBtn = self._tf:Find("Start")
	self.top = self._tf:Find("top")

	setText(self._tf:Find("BuffList/Title/Text"), i18n("activityboss_sp_all_buff"))
	setText(self._tf:Find("Rewards/Desc"), i18n("activityboss_sp_best_score"))
	setText(self._tf:Find("Rewards/Reward/Text"), i18n("activityboss_sp_display_reward"))
	setText(self._tf:Find("Active/Title/Text"), i18n("activityboss_sp_active_buff"))
	setText(self._tf:Find("Active/PT/Title"), i18n("activityboss_sp_score_bonus"))

	return
end

function ActivityBossBuffSelectLayer:didEnter()
	self.buffDatas = {}
	self.buffs = _.map(self.contextData.spEnemyInfo:GetSelectableBuffs(), function(arg_4_0)
		local var_4_0 = ActivityBossBuff.New({
			configId = arg_4_0
		})

		self.buffDatas[var_4_0] = {}

		return var_4_0
	end)

	local var_3_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)

	_.each(var_3_0:GetHistoryBuffs(), function(arg_5_0)
		self.buffDatas[_.detect(self.buffs, function(arg_6_0)
			return arg_6_0:GetConfigID() == arg_5_0
		end)].selected = true

		return
	end)

	self.rewards = self.contextData.spEnemyInfo:GetRewards()
	self.targets = self.contextData.spEnemyInfo:GetScoreTargets()
	self.score = self.contextData.score

	function self.buffScrollComp.onUpdateItem(arg_7_0, arg_7_1)
		self:UpdateBuffItem(arg_7_0 + 1, arg_7_1)

		return
	end

	function self.activeBuffScrollComp.onUpdateItem(arg_8_0, arg_8_1)
		self:UpdateActiveBuffItem(arg_8_0 + 1, arg_8_1)

		return
	end

	onButton(self, self.top:Find("back_btn"), function()
		self:closeView()

		return
	end, SOUND_BACK)
	onButton(self, self.top:Find("option"), function()
		self:quickExitFunc()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("Rewards/Reward"), function()
		self:emit(ActivityBossBuffSelectMediator.SHOW_REWARDS, self.rewards, self.targets, var_3_0:GetHighestScore())

		return
	end, SFX_PANEL)
	onButton(self, self.startBtn, function()
		self:emit(ActivityBossBuffSelectMediator.ON_START, self.activeBuffs)

		return
	end, SFX_PANEL)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	setText(self._tf:Find("Rewards/Score"), var_3_0:GetHighestScore())
	self:UpdateView()

	return
end

function ActivityBossBuffSelectLayer:UpdateView()
	self.buffScrollComp:SetTotalCount(#self.buffs)
	self:UpdateActiveBuffs()

	return
end

function ActivityBossBuffSelectLayer:UpdateBuffItem(arg_14_1, arg_14_2)
	local var_14_0 = tf(arg_14_2)
	local var_14_1 = self.buffDatas[self.buffs[arg_14_1]]

	setActive(var_14_0:Find("Selected"), self.buffDatas[self.buffs[arg_14_1]].selected)
	setText(var_14_0:Find("Name/Text"), self.buffs[arg_14_1]:GetDesc())
	setText(var_14_0:Find("PT/Text"), "+" .. self.buffs[arg_14_1]:GetBonusText())
	GetImageSpriteFromAtlasAsync(self.buffs[arg_14_1]:GetIconPath(), "", var_14_0:Find("Item/Icon"))
	onButton(self, var_14_0, function()
		var_14_1.selected = not var_14_1.selected

		self:UpdateView()

		return
	end, SFX_PANEL)

	return
end

function ActivityBossBuffSelectLayer:UpdateActiveBuffs()
	self.activeBuffs = _.select(self.buffs, function(arg_17_0)
		return self.buffDatas[arg_17_0].selected
	end)

	self.activeBuffScrollComp:SetTotalCount(math.max(math.floor((#self.activeBuffs - 1) / 5) + 1, 4) * 5)
	setText(self.activeBuffRect:Find("PT/Text"), "+" .. Mathf.Round(_.reduce(self.activeBuffs, 0, function(arg_18_0, arg_18_1)
		return arg_18_0 + arg_18_1:GetBonus()
	end) * 100) .. "%")

	return
end

function ActivityBossBuffSelectLayer:UpdateActiveBuffItem(arg_19_1, arg_19_2)
	local var_19_0 = tf(arg_19_2)

	setActive(var_19_0:Find("Icon"), tobool(self.activeBuffs[arg_19_1]))

	if not self.activeBuffs[arg_19_1] then
		return
	end

	GetImageSpriteFromAtlasAsync(self.activeBuffs[arg_19_1]:GetIconPath(), "", var_19_0:Find("Icon"))

	return
end

function ActivityBossBuffSelectLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return ActivityBossBuffSelectLayer
