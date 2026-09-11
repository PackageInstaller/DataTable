local RewardPreviewView = class("RewardPreviewView", ReduxView)

function RewardPreviewView:UIName()
	return "Widget/Common/Pop/RewardPreviewPopUI"
end

function RewardPreviewView:UIParent()
	return manager.ui.uiPop.transform
end

function RewardPreviewView:Init()
	self:InitUI()
	self:AddListeners()
end

function RewardPreviewView:InitUI()
	self:BindCfgUI()

	self.scrollList = LuaList.New(handler(self, self.indexAwardItem), self.itemListGo_, CommonItemView)
end

function RewardPreviewView:AddListeners()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self:Back()
	end)
end

function RewardPreviewView:OnEnter()
	self:RefreshUI()
end

function RewardPreviewView:OnExit()
	return
end

function RewardPreviewView:Dispose()
	if self.scrollList then
		self.scrollList:Dispose()
	end

	RewardPreviewView.super.Dispose(self)
end

function RewardPreviewView:RefreshUI()
	self.rewardList = formatRewardCfgList(self.params_.rewardList)

	self.scrollList:StartScroll(#self.rewardList)
end

function RewardPreviewView:indexAwardItem(arg_11_1, arg_11_2)
	local var_11_0 = rewardToItemTemplate(self.rewardList[arg_11_1])

	if self.params_.extraItemTemplateDataList and self.params_.extraItemTemplateDataList[var_11_0.id] then
		for iter_11_0, iter_11_1 in pairs(self.params_.extraItemTemplateDataList[var_11_0.id]) do
			var_11_0[iter_11_0] = iter_11_1
		end
	end

	function var_11_0.clickFun(arg_12_0)
		ShowPopItem(POP_ITEM, arg_12_0)
	end

	arg_11_2:SetData(var_11_0)
end

function RewardPreviewView:OnExitInput()
	JumpTools.Back()

	return true
end

return RewardPreviewView
