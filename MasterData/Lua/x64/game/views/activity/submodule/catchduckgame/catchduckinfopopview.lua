local CatchDuckInfoPopView = class("CatchDuckInfoPopView", ReduxView)

function CatchDuckInfoPopView:UIName()
	return "Widget/System/Summer2024/Summer2024_Minicom/SUminiDuckInfoPopUI"
end

function CatchDuckInfoPopView:UIParent()
	return manager.ui.uiPop.transform
end

function CatchDuckInfoPopView:Init()
	self:BindCfgUI()

	self.leftBtnController_ = self.leftBtnControllerEx_:GetController("state")
	self.rightBtnController_ = self.rightBtnControllerEx_:GetController("state")

	self:AddUIListener()
end

function CatchDuckInfoPopView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.leftBtn_, nil, function()
		self:SwitchPage(self.enterIndex_ - 1)
	end)
	self:AddBtnListener(self.rightBtn_, nil, function()
		self:SwitchPage(self.enterIndex_ + 1)
	end)
end

function CatchDuckInfoPopView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.duckList_ = self.params_.duckList

	self:SwitchPage(self.params_.index)
end

function CatchDuckInfoPopView:SwitchPage(arg_9_1)
	self.enterIndex_ = arg_9_1
	self.duckId_ = self.duckList_[arg_9_1]
	self.nameText_.text = ActivityDuckCfg[self.duckId_].name
	self.descText_.text = ActivityDuckCfg[self.duckId_].desc
	self.icon_.sprite = pureGetSpriteWithoutAtlas(ActivityDuckCfg[self.duckId_].icon)
	self.leftBtn_.enabled = arg_9_1 > 1
	self.rightBtn_.enabled = arg_9_1 < #self.duckList_

	self.leftBtnController_:SetSelectedState(arg_9_1 > 1 and "on" or "off")
	self.rightBtnController_:SetSelectedState(arg_9_1 < #self.duckList_ and "on" or "off")
end

return CatchDuckInfoPopView
