local TowerGameSectionInfoView = class("TowerGameSectionInfoView", ReduxView)

function TowerGameSectionInfoView:UIName()
	return "UI/Stage/ChapterSectionInfoUI"
end

function TowerGameSectionInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function TowerGameSectionInfoView:Init()
	self:InitUI()
	self:AddListeners()
end

function TowerGameSectionInfoView:InitUI()
	self:BindCfgUI()

	self.sectionImage_.immediate = true

	SetActive(self.rewardPanel_, false)
	SetActive(self.multiplePanel_, false)
	SetActive(self.resourcePanel_, false)
	SetActive(self.stageTitleGo_, false)

	self.levelid_ = 0
end

function TowerGameSectionInfoView:AddListeners()
	self:AddBtnListener(self.battleBtn_, nil, function()
		if ActivityData:GetActivityIsOpen(self.levelid_) then
			BattleController.GetInstance():LaunchBattle((BattleMardukeTowerGameTemplate.New(self.stageid_, self.levelid_)))
		else
			ShowTips(GetTips("TIME_OVER"))
		end
	end)
end

function TowerGameSectionInfoView:OnEnter()
	if self.levelid_ ~= self.params_.levelid then
		self.levelid_ = self.params_.levelid
		self.stageid_ = TowerGameCfg[self.levelid_].stage_id

		self:RefreshUI()
	end
end

function TowerGameSectionInfoView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		manager.notify:CallUpdateFunc(TOWERGAME_BACK)
		JumpTools.Back()
	end)
end

function TowerGameSectionInfoView:RefreshUI()
	self.sectionName_.text = GetI18NText(BattleTowerGameCfg[self.stageid_].name)
	self.sectionImage_.spriteSync = string.format("%s%s", SpritePathCfg.Stage.path, BattleTowerGameCfg[self.stageid_].background_1)
	self.tipsText_.text = GetI18NText(BattleTowerGameCfg[self.stageid_].tips)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.tipsTextContentTrans_)
end

function TowerGameSectionInfoView:OnExit()
	manager.windowBar:HideBar()
end

return TowerGameSectionInfoView
