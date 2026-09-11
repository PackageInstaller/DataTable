local PopItemSourceView = class("PopItemSourceView", import("game.views.pop.PopItemView"))

function PopItemSourceView:Init()
	PopItemSourceView.super.Init(self)
end

function PopItemSourceView:OnEnter()
	PopItemSourceView.super.OnEnter(self)

	if self.itemInfo_.number then
		-- block empty
	end

	if ItemCfg[self.itemInfo_.id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		self.tabControllerController:SetSelectedState("source")
	end

	self.itemList_ = {}

	self:RefreshItem()

	local var_2_2 = ItemCfg[self:GetItemID()]

	if var_2_2 and ItemConst.ITEM_SUB_TYPE.FUKUBUKURO == var_2_2.sub_type then
		self.probabilityController:SetSelectedState("show")
	else
		self.probabilityController:SetSelectedState("notshow")
	end
end

function PopItemSourceView:OnExit()
	for iter_3_0, iter_3_1 in ipairs(self.itemList_) do
		iter_3_1:Dispose()
	end

	self.itemList_ = nil

	PopItemSourceView.super.OnExit(self)
end

function PopItemSourceView:CustomInitUI()
	PopItemSourceView.super.CustomInitUI(self)
	self.btnShowControllerController:SetSelectedState("show")
	self.tabControllerController:SetSelectedState("source")
end

function PopItemSourceView:AddListeners()
	PopItemSourceView.super.AddListeners(self)
	self:AddBtnListener(self.sourceBtn_, nil, function()
		self.tabControllerController:SetSelectedState("descripe")
		OperationRecorder.Record(self.lastRecord_, "popSourceItem_sourceBtn")
	end)
	self:AddBtnListener(self.infoBtn_, nil, function()
		self.tabControllerController:SetSelectedState("source")
	end)
	self:AddBtnListener(nil, self.m_probabilityBtn, function()
		JumpTools.OpenPageByJump("popFukubukuroProbability", {
			itemId = self:GetItemID()
		})
	end)
end

function PopItemSourceView:RefreshItem()
	local var_9_0 = ItemTools.GetItemSourceList((self:GetItemID()))

	self.sourceList = var_9_0

	if #var_9_0 > 0 then
		self.btnShowControllerController:SetSelectedState("show")
	else
		self:ShowInfo()
	end

	self.sourceScroll_:StartScroll(#var_9_0)
end

function PopItemSourceView:OnTop()
	local var_10_0 = ItemTools.GetItemSourceList((self:GetItemID()))

	self.sourceList = var_10_0

	if #var_10_0 > 0 then
		self.btnShowControllerController:SetSelectedState("show")
	else
		self:ShowInfo()
	end

	self.sourceScroll_:Refresh()
end

function PopItemSourceView:OnJumpCallback()
	OperationRecorder.Record(self.lastRecord_, "jump")
end

return PopItemSourceView
