local IdolTraineeBattleComparePop = class("IdolTraineeBattleComparePop", ReduxView)

function IdolTraineeBattleComparePop:UIName()
	return "Widget/BackHouseUI/IdolTrainee/IdolPropertyComparePopup"
end

function IdolTraineeBattleComparePop:UIParent()
	return manager.ui.uiPop.transform
end

function IdolTraineeBattleComparePop:Init()
	self:InitUI()
	self:AddUIListener()
end

function IdolTraineeBattleComparePop:InitUI()
	self:BindCfgUI()

	self.myInfoView = IdolTraineeTrainInfoPage.New(self.player1Info_, handler(self, self.ChangeContentProperty), handler(self, self.ChangeContentSkill))

	self.myInfoView:EnableLockControl(true)

	self.enemyInfoView = IdolTraineeTrainInfoPage.New(self.player2Info_, handler(self, self.ChangeContentProperty), handler(self, self.ChangeContentSkill))
end

function IdolTraineeBattleComparePop:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function IdolTraineeBattleComparePop:OnEnter()
	self.userID = self.params_.userID
	self.friendType = self.params_.friendType
	self.stageID = self.params_.stageID

	local var_7_0, var_7_1 = IdolTraineeData:GetCurAttackHeroInfo()

	self.curHeroID_ = var_7_1

	self.myInfoView:RegisterEvents()
	self.myInfoView:RefreshUI((IdolTraineeTools:GetHeroBattleInfoTemplate(self.curHeroID_)))
	self.enemyInfoView:RefreshUI((IdolTraineeTools:GetHeroBattleInfoTemplate(nil, self.userID, self.friendType, self.stageID)))
end

function IdolTraineeBattleComparePop:OnExit()
	self.myInfoView:RemoveAllEventListener()
end

function IdolTraineeBattleComparePop:ChangeContentProperty()
	self.myInfoView:ChangeContent(1)
	self.enemyInfoView:ChangeContent(1)
end

function IdolTraineeBattleComparePop:ChangeContentSkill()
	self.myInfoView:ChangeContent(2)
	self.enemyInfoView:ChangeContent(2)
end

function IdolTraineeBattleComparePop:Dispose()
	self.myInfoView:Dispose()
	self.enemyInfoView:Dispose()
	IdolTraineeBattleComparePop.super.Dispose(self)
end

return IdolTraineeBattleComparePop
