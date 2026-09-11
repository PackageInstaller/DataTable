local CowboyRewardView = class("CowboyRewardView", ReduxView)

function CowboyRewardView:UIName()
	return "UI/VolumeIIIUI/VolumeIntegralPopnew"
end

function CowboyRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function CowboyRewardView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CowboyRewardView:InitUI()
	self:BindCfgUI()

	self.list_ = {}
	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, CowboyRewardItem)
end

function CowboyRewardView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(self.activityID_, self.list_[arg_5_1])
end

function CowboyRewardView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function CowboyRewardView:OnEnter()
	self.activityID_ = self.params_.activityID

	self:RefreshUI()
end

function CowboyRewardView:RefreshUI()
	self:RefreshText()
	self:RefreshList()
end

function CowboyRewardView:RefreshText()
	local var_10_0, var_10_1 = CowboyData:GetRewardCount(self.activityID_)

	self.text_.text = var_10_0 .. "/" .. var_10_1
end

function CowboyRewardView:RefreshList()
	self.list_ = CowboyData:GetList(self.activityID_)

	local var_11_4 = 1

	for iter_11_0 = #self.list_, 1, -1 do
		local var_11_5 = CowboyData:GetHistoryScore(self.list_[iter_11_0])

		for iter_11_1, iter_11_2 in ipairs(CowboyData:GetData(self.list_[iter_11_0]).reward) do
			if var_11_5 >= ActivityPointRewardCfg[iter_11_2.point_id].need and iter_11_2.point_reward_state == 1 then
				var_11_4 = iter_11_0

				break
			end
		end
	end

	self.scrollHelper_:StartScroll(#self.list_, var_11_4)
end

function CowboyRewardView:OnCowboyReward()
	self:RefreshUI()
end

function CowboyRewardView:OnExit()
	for iter_13_0, iter_13_1 in pairs(self.scrollHelper_:GetItemList()) do
		iter_13_1:OnExit()
	end
end

function CowboyRewardView:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	CowboyRewardView.super.Dispose(self)
end

return CowboyRewardView
