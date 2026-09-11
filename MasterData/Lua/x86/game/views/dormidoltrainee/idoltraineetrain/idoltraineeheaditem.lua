local IdolTraineeHeadItem = class("IdolTraineeHeadItem", ReduxView)

function IdolTraineeHeadItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function IdolTraineeHeadItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.selectController_ = self.mainControllerEx_:GetController("select")
	self.defendController_ = self.mainControllerEx_:GetController("defend")
	self.attackController_ = self.mainControllerEx_:GetController("attack")
	self.doubleController_ = self.mainControllerEx_:GetController("double")
	self.lockController_ = self.mainControllerEx_:GetController("lock")
	self.lockingController_ = self.mainControllerEx_:GetController("locking")
	self.clearController_ = self.mainControllerEx_:GetController("clear")
	self.competitionSelController_ = self.mainControllerEx_:GetController("competitionSel")
end

function IdolTraineeHeadItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.click_ then
			self:click_()
		end
	end)
end

function IdolTraineeHeadItem:SetData(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self.heroID_ = arg_5_1
	self.click_ = arg_5_3
	self.headIcon_.sprite = IdolTraineeTools:GetHeroBattleInfoTemplate(arg_5_1).heroIcon

	self:RefreshDanceGameRole((not nullable(arg_5_4, "ignoreDefender") or nil) and IdolTraineeTools:CheckHeroIsDefine(arg_5_1), (not nullable(arg_5_4, "ignoreAttacker") or nil) and IdolTraineeTools:CheckHeroIsAttack(arg_5_1))
	self.selectController_:SetSelectedState(arg_5_1 == arg_5_2 and "true" or "false")

	if self.lockController_ then
		self.lockController_:SetSelectedState(HeroTools.GetHeroIsUnlock(arg_5_1) and "off" or "on")
	end

	if self.competitionSelController_ then
		self.competitionSelController_:SetSelectedState(nullable(arg_5_4, "competitionSel") and "on" or "off")
	end

	self.lockingController_:SetSelectedState(BackHomeTools.CheckHeroIsLockForAnyFeatureByHeroID(arg_5_1) and "true" or "false")
	self.clearController_:SetSelectedState(DormTools.CheckMax(arg_5_1) and "on" or "off")
end

function IdolTraineeHeadItem:RefreshDanceGameRole(arg_6_1, arg_6_2)
	if arg_6_1 and arg_6_2 then
		self.defendController_:SetSelectedState("false")
		self.attackController_:SetSelectedState("false")
		self.doubleController_:SetSelectedState("true")

		return
	end

	self.defendController_:SetSelectedState(arg_6_1 and "true" or "false")
	self.attackController_:SetSelectedState(arg_6_2 and "true" or "false")
	self.doubleController_:SetSelectedState("false")
end

function IdolTraineeHeadItem:SelectOn()
	self.selectController_:SetSelectedState("true")
end

function IdolTraineeHeadItem:SelectOff()
	self.selectController_:SetSelectedState("false")
end

function IdolTraineeHeadItem:Dispose()
	IdolTraineeHeadItem.super.Dispose(self)
end

return IdolTraineeHeadItem
