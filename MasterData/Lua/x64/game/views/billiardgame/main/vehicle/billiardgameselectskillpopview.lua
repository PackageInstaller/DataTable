local BilliardGameSelectSkillPopView = class("BilliardGameSelectSkillPopView", ReduxView)

function BilliardGameSelectSkillPopView:UIName()
	return "Widget/System/Activity_WuLuo/Activity_WuLuo_BallxPit/Activity_WuLuo_BallxPit_BuffSelectPopUI"
end

function BilliardGameSelectSkillPopView:UIParent()
	return manager.ui.uiPop.transform
end

function BilliardGameSelectSkillPopView:Init()
	self:OnInit()
	self:AddUIListner()
end

function BilliardGameSelectSkillPopView:OnInit()
	self:BindCfgUI()

	self.skillCardItemList = {}

	for iter_4_0 = 1, 2 do
		table.insert(self.skillCardItemList, (BilliardGameSelectSkillCardItemView.New(self["skillCardItemGo_" .. iter_4_0])))
	end

	self.refreshController_ = self.transCon_:GetController("refreshBtn")
end

function BilliardGameSelectSkillPopView:AddUIListner()
	self:AddBtnListener(self.refreshBtn_, nil, function()
		if self.refreshCount_ == 0 then
			return
		end

		if self.refreshCount_ <= BilliardGameConst.PassStageParams.ADDREFRESHCOUNT then
			for iter_6_0 = 1, #self.skillCardItemList do
				self.skillCardItemList[iter_6_0].changeAnim_:Play("card_change", -1, 0)
			end

			self:RefreshSkillCardItem()

			self.refreshCount_ = self.refreshCount_ - 1
			self.refreshCountText_.text = string.format("%d/%d", self.refreshCount_, BilliardGameConst.PassStageParams.ADDREFRESHCOUNT)

			self.refreshController_:SetSelectedState(self.refreshCount_ == 0 and "red" or "white")
			BilliardGameMgr:SetRefreshCount(self.refreshCount_)
			BilliardGameMgr:OnSkillChange(BilliardGameConst.ChangeSkillType.ADD, BilliardGameConst.ChangeSkillOpt.RESET, {})
		end
	end)
end

function BilliardGameSelectSkillPopView:OnEnter()
	self.isSelected_ = false
	self.refreshCount_ = BilliardGameMgr:GetRefreshCount()

	self.refreshController_:SetSelectedState(self.refreshCount_ == 0 and "red" or "white")

	self.refreshCountText_.text = string.format("%d/%d", self.refreshCount_, BilliardGameConst.PassStageParams.ADDREFRESHCOUNT)

	self:RefreshSkillCardItem()
end

function BilliardGameSelectSkillPopView:OnTop()
	manager.windowBar:SwitchBar({})
	self:RefreshItemTrack()
end

function BilliardGameSelectSkillPopView:OnExit()
	AnimatorTools.Stop()
end

function BilliardGameSelectSkillPopView:Dispose()
	for iter_10_0 = 1, #self.skillCardItemList do
		self.skillCardItemList[iter_10_0]:Dispose()
	end

	BilliardGameSelectSkillPopView.super.Dispose(self)
end

function BilliardGameSelectSkillPopView:RefreshSkillCardItem()
	self.buffIdList_ = BilliardGameMgr:GetRoundSelectBuffList()

	for iter_11_0, iter_11_1 in ipairs(self.skillCardItemList) do
		iter_11_1:SetData(self.buffIdList_[iter_11_0])
		iter_11_1:RegisterClickListener(function(arg_12_0)
			self:OnClickSkillCardItem(arg_12_0, iter_11_0)
		end)
	end
end

function BilliardGameSelectSkillPopView:RefreshItemTrack()
	for iter_13_0, iter_13_1 in ipairs(self.skillCardItemList) do
		iter_13_1:RefreshTrackState()
	end
end

function BilliardGameSelectSkillPopView:OnClickSkillCardItem(arg_14_1, arg_14_2)
	if self.isSelected_ then
		return
	end

	self.isSelected_ = true

	AnimatorTools.PlayAnimationWithCallback(self.skillCardItemList[arg_14_2].selectAnim_, "card_select", function()
		AnimatorTools.PlayAnimationWithCallback(self.exitAnim_, "exit", function()
			self:Back()
			BilliardGameMgr:AddSelectedSkill(arg_14_1)
			BilliardGameLuaBridge.SetSelectBuffOver(true)
		end)
	end)
end

return BilliardGameSelectSkillPopView
