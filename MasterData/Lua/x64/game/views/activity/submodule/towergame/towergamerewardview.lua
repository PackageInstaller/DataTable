local TowerGameRewardView = class("TowerGameRewardView", ReduxView)

function TowerGameRewardView:UIName()
	return "UI/MardukUI/snakeactive/MarduksnakeRewardUI"
end

function TowerGameRewardView:UIParent()
	return manager.ui.uiMain.transform
end

function TowerGameRewardView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function TowerGameRewardView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.RefreshItem), self.listgo_, TowerGameRewardBlock)
end

function TowerGameRewardView:AddUIListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		JumpTools.Back()
	end)
end

function TowerGameRewardView:OnEnter()
	self:RefreshUI()
end

function TowerGameRewardView:RefreshItem(arg_8_1, arg_8_2)
	arg_8_2:Refresh(TowerGameCfg.all[arg_8_1])
end

function TowerGameRewardView:RefreshUI()
	self.list_:StartScroll(#TowerGameCfg.all, TowerGameData:GetFirstCanGetRewardIndex())

	self.gettext_.text = TowerGameData:GetRewardsNum()
	self.alltext_.text = "/" .. TowerGameData:GetAllRewardNum()
end

function TowerGameRewardView:OnTowerGameGetReward()
	self.gettext_.text = TowerGameData:GetRewardsNum()
	self.alltext_.text = "/" .. TowerGameData:GetAllRewardNum()

	self.list_:Refresh()
end

function TowerGameRewardView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end
end

return TowerGameRewardView
