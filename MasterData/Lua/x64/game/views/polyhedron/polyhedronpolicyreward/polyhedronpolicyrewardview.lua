local PolyhedronPolicyRewardView = class("PolyhedronPolicyRewardView", ReduxView)

function PolyhedronPolicyRewardView:UIName()
	return "Widget/System/Polyhedron/PolyhedronDeviationUI"
end

function PolyhedronPolicyRewardView:UIParent()
	return manager.ui.uiMain.transform
end

function PolyhedronPolicyRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronPolicyRewardView:InitUI()
	self:BindCfgUI()

	self.rewardList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, PolyhedronPolicyRewardItem)
	self.stageRewardItem_ = PolyhedronPolicyRewardItem.New(self.stageRewardGo_)
end

function PolyhedronPolicyRewardView:AddUIListener()
	self:AddBtnListener(self.allReceiveBtn_, nil, function()
		PolyhedronAction.QueryPolicyReward(1)
	end)
end

function PolyhedronPolicyRewardView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self:RefreshUI()
end

function PolyhedronPolicyRewardView:OnExit()
	manager.windowBar:HideBar()
end

function PolyhedronPolicyRewardView:Dispose()
	self.rewardList_:Dispose()

	self.rewardList_ = nil

	self.stageRewardItem_:Dispose()

	self.stageRewardItem_ = nil

	PolyhedronPolicyRewardView.super.Dispose(self)
end

function PolyhedronPolicyRewardView:RefreshUI()
	self.rewardCfg_ = PolyhedronTools.GetPolicyIDList()
	self.curLevel_, self.curExp_ = PolyhedronTools.PolyhedronPolicyExpToLevel()

	self:RefreshLevel()

	local var_10_0 = self:RefreshReceiveBtn()

	var_10_0 = var_10_0 <= #self.rewardCfg_ and var_10_0 or #self.rewardCfg_

	self.rewardList_:StartScroll(#self.rewardCfg_, var_10_0)
end

function PolyhedronPolicyRewardView:IndexItem(arg_11_1, arg_11_2)
	arg_11_2:SetData(self.rewardCfg_[arg_11_1], self.curLevel_)

	local var_11_0 = 1

	for iter_11_0, iter_11_1 in pairs((self.rewardList_:GetItemList())) do
		var_11_0 = var_11_0 < iter_11_1.level_ and iter_11_1.level_ or var_11_0
	end

	if var_11_0 > self.curStageLevel_ or var_11_0 <= self.curStageLevel_ - 10 then
		self:RefreshStageReward(var_11_0)
	end
end

function PolyhedronPolicyRewardView:RefreshLevel()
	self.levelText_.text = self.curLevel_

	local var_12_0 = PolyhedronTools.GetPolicyIDList()

	self.levelList_ = var_12_0

	local var_12_1 = #var_12_0
	local var_12_2 = self.curLevel_ + 1

	var_12_2 = self.curLevel_ + 1 <= #var_12_0 and var_12_2 or var_12_1

	local var_12_3 = 0

	var_12_3 = self.curLevel_ == 0 and PolyhedronPolicyCfg[var_12_0[1]].exp or self.curLevel_ == var_12_1 and PolyhedronPolicyCfg[var_12_0[self.curLevel_]].exp - PolyhedronPolicyCfg[var_12_0[self.curLevel_ - 1]].exp or PolyhedronPolicyCfg[var_12_0[var_12_2]].exp - PolyhedronPolicyCfg[var_12_0[self.curLevel_]].exp
	self.expText_.text = string.format("%d/%d", math.min(self.curExp_, var_12_3), var_12_3)
	self.progressSlider_.value = self.curExp_ / var_12_3

	self:RefreshStageReward(var_12_2)
end

function PolyhedronPolicyRewardView:RefreshStageReward(arg_13_1)
	local var_13_0 = math.ceil(arg_13_1 / 10) * 10

	var_13_0 = #self.levelList_ < var_13_0 and #self.levelList_ or var_13_0

	self.stageRewardItem_:SetData(self.rewardCfg_[var_13_0], self.curLevel_)

	self.curStageLevel_ = var_13_0
end

function PolyhedronPolicyRewardView:RefreshReceiveBtn()
	local var_14_0 = PolyhedronData:GetPolicyApplyList()

	for iter_14_0 = 1, self.curLevel_ do
		if var_14_0[iter_14_0] == nil then
			SetActive(self.allReceiveBtn_.gameObject, true)

			return iter_14_0
		end
	end

	SetActive(self.allReceiveBtn_.gameObject, false)

	return self.curLevel_ + 1
end

function PolyhedronPolicyRewardView:OnReceivedPolicyReward()
	self:RefreshUI()
end

function PolyhedronPolicyRewardView:OnPolyhedronGameUpdate()
	self:RefreshUI()
end

return PolyhedronPolicyRewardView
