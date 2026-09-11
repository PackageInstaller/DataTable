local BossCombatSelectView = class("BossCombatSelectView", ReduxView)

function BossCombatSelectView:UIName()
	return "UI/DamageTest/BossCombatSelectUI"
end

function BossCombatSelectView:UIParent()
	return manager.ui.uiMain.transform
end

function BossCombatSelectView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.affixList_ = LuaList.New(handler(self, self.RefreshAffixItem), self.affixUIList_, DamageTestConditionItem)
end

function BossCombatSelectView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.damageTestId_ = self.params_.damageTestId

	self:RefreshUI()
	self.affixList_:StartScroll(#DamageTestCfg[self.damageTestId_].time_pool + #DamageTestCfg[self.damageTestId_].affix_pool, 1)
end

function BossCombatSelectView:OnExit()
	manager.windowBar:HideBar()
end

function BossCombatSelectView:Dispose()
	BossCombatSelectView.super.Dispose(self)

	self.chooseConditionHandler_ = nil

	if self.affixList_ then
		self.affixList_:Dispose()

		self.affixList_ = nil
	end
end

function BossCombatSelectView:AddListeners()
	self:AddBtnListener(self.battleBtn_, nil, function()
		self:Go("/sectionSelectHero", {
			section = DamageTestCfg[self.damageTestId_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.DAMAGE_TEST,
			activityID = self.damageTestId_
		})
	end)
end

function BossCombatSelectView:RefreshUI()
	self.bossHealthText_.text = DamageTestCfg[self.damageTestId_].boss_base_hp
	self.bossImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.BossLittlePaint.path, BossChallengeUICfg[DamageTestCfg[self.damageTestId_].boss_id].icon))
end

function BossCombatSelectView:RefreshAffixItem(arg_10_1, arg_10_2)
	local var_10_0
	local var_10_1

	if arg_10_1 <= #DamageTestCfg[self.damageTestId_].time_pool then
		var_10_0 = BossConst.TYPE_STAGE
		var_10_1 = DamageTestCfg[self.damageTestId_].time_pool[arg_10_1]
	else
		var_10_0 = BossConst.TYPE_AFFIX
		var_10_1 = DamageTestCfg[self.damageTestId_].affix_pool[arg_10_1 - #DamageTestCfg[self.damageTestId_].time_pool]
	end

	arg_10_2:SetData(self.damageTestId_, var_10_0, var_10_1)
end

return BossCombatSelectView
