local DormVisitRewardNewPop = class("DormVisitRewardNewPop", ReduxView)

function DormVisitRewardNewPop:UIName()
	return "Widget/BackHouseUI/Dorm/DormVisitingGiftPopUI"
end

function DormVisitRewardNewPop:UIParent()
	return manager.ui.uiPop.transform
end

function DormVisitRewardNewPop:OnCtor()
	return
end

function DormVisitRewardNewPop:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormVisitRewardNewPop:InitUI()
	self:BindCfgUI()

	self.awardListScroll_ = LuaList.New(handler(self, self.indexAwardItem), self.uilistGo_, DormAwardNewItem)
end

function DormVisitRewardNewPop:AddUIListener()
	self:AddBtnListener(self.confirmBtn, nil, function()
		JumpTools.Back()
	end)
end

local var_0_1 = "(%d/%d)"

function DormVisitRewardNewPop:OnEnter()
	self:UpdataView()

	self.titleTxt_.text = GetTips("ERROR_BACKHOME_VISIT_REWARD_TITLE") .. string.format(var_0_1, DormData:GetWeekReceivedGiftNum(), DormData:GetMaxWeekReceivedGiftNum())
end

function DormVisitRewardNewPop:UpdataView()
	self.awardListScroll_:StartScroll(#self.params_.awardList)
end

function DormVisitRewardNewPop:indexAwardItem(arg_10_1, arg_10_2)
	arg_10_2:RefreshUI(self.params_.awardList[arg_10_1])
end

function DormVisitRewardNewPop:Dispose()
	if self.awardListScroll_ then
		self.awardListScroll_:Dispose()
	end

	DormVisitRewardNewPop.super.Dispose(self)
end

return DormVisitRewardNewPop
