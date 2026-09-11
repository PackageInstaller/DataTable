local DormVisitRewardPop = class("DormVisitRewardPop", ReduxView)

function DormVisitRewardPop:UIName()
	return "Widget/BackHouseUI/Dorm/EmptyDormVisitPop"
end

function DormVisitRewardPop:UIParent()
	return manager.ui.uiPop.transform
end

function DormVisitRewardPop:OnCtor()
	return
end

function DormVisitRewardPop:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormVisitRewardPop:InitUI()
	self:BindCfgUI()

	self.awardListScroll_ = LuaList.New(handler(self, self.indexAwardItem), self.awardviewuilistUilist_, DormAwardItem)
end

function DormVisitRewardPop:AddUIListener()
	self:AddBtnListener(self.okbtnBtn_, nil, function()
		JumpTools.Back()
	end)
end

function DormVisitRewardPop:OnEnter()
	self:UpdataView()
end

function DormVisitRewardPop:UpdataView()
	self.awardListScroll_:StartScroll(#self.params_.awardList)
end

function DormVisitRewardPop:indexAwardItem(arg_10_1, arg_10_2)
	arg_10_2:RefreshUI(self.params_.awardList[arg_10_1])
end

function DormVisitRewardPop:Dispose()
	if self.awardListScroll_ then
		self.awardListScroll_:Dispose()
	end

	DormVisitRewardPop.super.Dispose(self)
end

return DormVisitRewardPop
