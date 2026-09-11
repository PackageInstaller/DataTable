local PlotTalkItem = class("PlotTalkItem", ReduxView)

function PlotTalkItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function PlotTalkItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function PlotTalkItem:InitUI()
	self:BindCfgUI()

	self.lockController_ = self.controller_:GetController("lock")
end

function PlotTalkItem:AddUIListeners()
	self:AddBtnListener(self.talkBtn_, nil, function()
		if self.clickLimitFunc_ and not self.clickLimitFunc_(self.preStoryID_) then
			return
		end

		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.null)
		manager.story:StartStoryById(self.storyId_, function()
			if self.storyCallBack_ then
				self.storyCallBack_(self.storyId_)
			end
		end)

		if self.callBack_ then
			self.callBack_()
		end
	end)
end

function PlotTalkItem:SetClickLimitFunc(arg_7_1)
	self.clickLimitFunc_ = arg_7_1
end

function PlotTalkItem:SetCallBack(arg_8_1)
	self.callBack_ = arg_8_1
end

function PlotTalkItem:SetStoryCallBack(arg_9_1)
	self.storyCallBack_ = arg_9_1
end

function PlotTalkItem:OnEnter()
	return
end

function PlotTalkItem:RefreshUI(arg_11_1, arg_11_2, arg_11_3)
	self.titleText_.text = arg_11_1
	self.storyId_ = arg_11_2
	self.preStoryID_ = arg_11_3

	if arg_11_3 > 0 and not manager.story:IsStoryPlayed(arg_11_3) then
		self.lockController_:SetSelectedState("on")
	else
		self.lockController_:SetSelectedState("off")
	end
end

function PlotTalkItem:Show(arg_12_1)
	SetActive(self.gameObject_, arg_12_1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.descRect_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.rect_)
end

function PlotTalkItem:OnExit()
	return
end

function PlotTalkItem:Dispose()
	self:RemoveAllListeners()
	PlotTalkItem.super.Dispose(self)
end

return PlotTalkItem
