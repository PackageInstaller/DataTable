local BossChallengeRewardPreviewView = class("BossChallengeRewardPreviewView", ReduxView)

function BossChallengeRewardPreviewView:UIName()
	return "Widget/System/Challenge_Boss/BossIntegralGoPop"
end

function BossChallengeRewardPreviewView:UIParent()
	return manager.ui.uiPop.transform
end

function BossChallengeRewardPreviewView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, CommonItemView)
end

function BossChallengeRewardPreviewView:OnEnter()
	self.rewardList_ = self.params_.rewardList
	self.subTitleNameText_.text = GetI18NText(self.params_.titleText) or ""
	self.targetText_.text = GetI18NText(self.params_.targetText) or ""

	self.uiList_:StartScroll(#self.rewardList_)
end

function BossChallengeRewardPreviewView:OnExit()
	return
end

function BossChallengeRewardPreviewView:Dispose()
	self.uiList_:Dispose()

	self.uiList_ = nil

	BossChallengeRewardPreviewView.super.Dispose(self)
end

function BossChallengeRewardPreviewView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
end

function BossChallengeRewardPreviewView:IndexItem(arg_9_1, arg_9_2)
	CommonTools.SetCommonData(arg_9_2, {
		id = self.rewardList_[arg_9_1].id,
		number = self.rewardList_[arg_9_1].num,
		clickFun = function(self)
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number,
				0,
				self.time_valid
			})
		end
	})
end

function BossChallengeRewardPreviewView:Cacheable()
	return false
end

return BossChallengeRewardPreviewView
