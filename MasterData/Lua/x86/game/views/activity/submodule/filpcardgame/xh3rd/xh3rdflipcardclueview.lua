local XH3rdFlipCardClueView = class("XH3rdFlipCardClueView", ReduxView)

function XH3rdFlipCardClueView:UIName()
	return XH3rdFlipCardTool.GetClueUI()
end

function XH3rdFlipCardClueView:UIParent()
	return manager.ui.uiPop.transform
end

function XH3rdFlipCardClueView:Init()
	self:InitUI()
	self:AddUIListener()
end

function XH3rdFlipCardClueView:InitUI()
	self:BindCfgUI()

	if self.clueListTrans_ ~= nil then
		self.clueItemList = {}

		for iter_4_0 = 0, self.clueListTrans_.childCount - 1 do
			table.insert(self.clueItemList, XH3rdFlipCardClueItem.New(self.clueListTrans_:GetChild(iter_4_0).gameObject, iter_4_0 + 1))
		end
	end

	self.checkController_ = ControllerUtil.GetController(self.transform_, "check")
end

function XH3rdFlipCardClueView:AddUIListener()
	self:AddBtnListener(self.backMask_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.detailMask_, nil, function()
		self.checkController_:SetSelectedState("false")
	end)
end

function XH3rdFlipCardClueView:OnEnter()
	self.activityId = self.params_.activityID
	self.titleText_ = self.titleText_
	self.descText_ = self.descText_

	for iter_9_0, iter_9_1 in ipairs(FlipCardCfg[self.activityId].details) do
		self.clueItemList[iter_9_0]:SetData(FlipCardClueCfg[iter_9_1], self.activityId)
	end

	self.receiveHandler_ = handler(self, self.OpenClueDetailView)

	manager.notify:RegistListener(FLIP_CARD_VIEW_CLUE_RESULT, self.receiveHandler_)
end

function XH3rdFlipCardClueView:OpenClueDetailView(arg_10_1)
	self.checkController_:SetSelectedState("true")

	self.titleText_.text = FlipCardClueCfg[arg_10_1].name
	self.descText_.text = FlipCardClueCfg[arg_10_1].description
end

function XH3rdFlipCardClueView:OnExit()
	manager.notify:RemoveListener(FLIP_CARD_VIEW_CLUE_RESULT, self.receiveHandler_)
end

function XH3rdFlipCardClueView:Dispose()
	for iter_12_0, iter_12_1 in pairs(self.clueItemList) do
		iter_12_1:Dispose()
	end

	self.clueListTrans_ = nil

	XH3rdFlipCardClueView.super.Dispose(self)
end

return XH3rdFlipCardClueView
