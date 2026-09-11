local DamageTestBossInfoView = class("DamageTestBossInfoView", (import("game.views.stage.bossChallenge.BattleBossInfoBaseView")))

function DamageTestBossInfoView:UIName()
	return "UI/DamageTest/DamageTestBossInformationUI"
end

function DamageTestBossInfoView:OnEnterExtend()
	manager.windowBar:SetGameHelpKey("BOSS_CHALLENGE_ADVANCE_DESC")
end

function DamageTestBossInfoView:OnEnter()
	manager.ui:SetMainCamera("bossChallenge")
	self:InitBackScene()

	self.exitView_ = false
	self.currentBossTemplateID_ = nil

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	self:OnEnterExtend()
	self:RefreshData()
	self:RefreshUI()
end

function DamageTestBossInfoView:OnExit()
	DamageTestBossInfoView.super.OnExit(self)
end

function DamageTestBossInfoView:OnUpdate()
	DamageTestBossInfoView.super.OnUpdate(self)
end

function DamageTestBossInfoView:AddListeners()
	self:AddBtnListener(self.startBattleBtn_, nil, function()
		self:Go("/bossCombatSelect", {
			damageTestId = self.damageTestId_
		})
	end)
end

function DamageTestBossInfoView:RefreshData()
	self.damageTestId_ = self.params_.damageTestId
	self.templateID_ = DamageTestCfg[self.damageTestId_].boss_id
end

function DamageTestBossInfoView:RefreshLockHero()
	return
end

function DamageTestBossInfoView:RefreshUI()
	self:RefreshText()
	self:LoadModel()
	self:RefreshSkill()
end

return DamageTestBossInfoView
