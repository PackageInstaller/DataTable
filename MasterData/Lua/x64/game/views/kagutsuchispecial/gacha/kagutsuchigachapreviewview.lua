local KagutsuchiGachaPreviewView = class("KagutsuchiGachaPreviewView", ReduxView)

function KagutsuchiGachaPreviewView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionJackpotRewardUI"
end

function KagutsuchiGachaPreviewView:UIParent()
	return manager.ui.uiPop.transform
end

function KagutsuchiGachaPreviewView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.poolRewardItem_ = {}
end

function KagutsuchiGachaPreviewView:AddListeners()
	self:AddBtnListener(self.bgmask_, nil, function()
		self:Back()
	end)
end

function KagutsuchiGachaPreviewView:OnEnter()
	self.activityId_ = self.params_.activityId
	self.poolId_ = self.params_.poolId

	self:RefreshUI()
end

function KagutsuchiGachaPreviewView:OnExit()
	for iter_7_0, iter_7_1 in ipairs(self.poolRewardItem_) do
		self.poolRewardItem_[iter_7_0]:OnExit()
	end
end

function KagutsuchiGachaPreviewView:OnTop()
	SetActive(self.gameObject_, true)
end

function KagutsuchiGachaPreviewView:OnBehind()
	SetActive(self.gameObject_, false)
end

function KagutsuchiGachaPreviewView:RefreshUI()
	self:RefreshPoolRewardItems(self.poolId_)
end

function KagutsuchiGachaPreviewView:RefreshPoolRewardItems(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs((KagutsuchiGachaData:GetAllDrawItemIds(arg_11_1))) do
		self.poolRewardItem_[iter_11_0] = self.poolRewardItem_[iter_11_0] or KagutsuchiGachaRewardItem.New((Object.Instantiate(self.templateItem_, self.contentParent_)))

		self.poolRewardItem_[iter_11_0]:SetData(self.activityId_, arg_11_1, iter_11_1)
	end
end

function KagutsuchiGachaPreviewView:Dispose()
	for iter_12_0, iter_12_1 in ipairs(self.poolRewardItem_) do
		self.poolRewardItem_[iter_12_0]:Dispose()
	end

	KagutsuchiGachaPreviewView.super.Dispose(self)
end

return KagutsuchiGachaPreviewView
