local AffixBoxView = class("AffixBoxView", ReduxView)

function AffixBoxView:UIName()
	return "UI/Common/MessageBox4"
end

function AffixBoxView:UIParent()
	return manager.ui.uiMessage.transform
end

function AffixBoxView:OnCtor()
	self.itemView_ = {}
end

function AffixBoxView:Init()
	self:InitUI()
	self:AddListeners()
end

function AffixBoxView:OnEnter()
	for iter_5_0, iter_5_1 in ipairs(self.params_.affixList) do
		self.itemView_[iter_5_0] = self.itemView_[iter_5_0] or AffixBoxItem.New(self.item_, self.itemParent_)

		self.itemView_[iter_5_0]:SetData(iter_5_1)
	end

	for iter_5_2 = #self.params_.affixList + 1, #self.itemView_ do
		self.itemView_[iter_5_2]:SetActive(false)
	end

	self.listScrollRect_.verticalNormalizedPosition = 1
end

function AffixBoxView:OnExit()
	return
end

function AffixBoxView:Dispose()
	self:RemoveListeners()

	for iter_7_0, iter_7_1 in pairs(self.itemView_) do
		iter_7_1:Dispose()
	end

	self.itemView_ = nil

	AffixBoxView.super.Dispose(self)
end

function AffixBoxView:InitUI()
	self.backBtn_ = self:FindCom(typeof(Button), "mask")
	self.item_ = self:FindGo("panel/bg/affixList/Viewport/Content/Item")
	self.itemParent_ = self:FindGo("panel/bg/affixList/Viewport/Content")
	self.listScrollRect_ = self:FindCom(typeof(ScrollRect), "panel/bg/affixList")
end

function AffixBoxView:AddListeners()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
end

function AffixBoxView:RemoveListeners()
	self.backBtn_.onClick:RemoveAllListeners()
end

return AffixBoxView
