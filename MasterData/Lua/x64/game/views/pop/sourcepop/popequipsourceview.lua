local PopEquipSourceView = class("PopEquipSourceView", import("game.views.pop.PopItemView"))

function PopEquipSourceView:OnEnter()
	self.equipInfo_ = self.params_.equip_info or {}

	PopEquipSourceView.super.OnEnter(self)

	self.itemList_ = {}

	self:RefreshItem()

	if self.params_.suitID then
		self:CustomizeForSuit(self.params_.suitID)
	end
end

function PopEquipSourceView:OnExit()
	for iter_2_0, iter_2_1 in ipairs(self.itemList_) do
		iter_2_1:Dispose()
	end

	self.itemList_ = nil

	PopEquipSourceView.super.OnExit(self)
end

function PopEquipSourceView:CustomInitUI()
	PopEquipSourceView.super.CustomInitUI(self)
	self.btnShowControllerController:SetSelectedState("hide")
	self.tabControllerController:SetSelectedState("source")
end

function PopEquipSourceView:CustomizeForSuit(arg_4_1)
	self.nameText_.text = GetI18NText(EquipSuitCfg[arg_4_1].name)
end

function PopEquipSourceView:indexSoureceItem(arg_5_1, arg_5_2)
	self.sourceList[arg_5_1].equipId = self:GetItemID()

	arg_5_2:RefreshUI(self:GetItemID(), self.sourceList[arg_5_1])

	if self.OnJumpCallback then
		arg_5_2:SetJumpCallback(handler(self, self.OnJumpCallback))
	end
end

function PopEquipSourceView:RefreshItem()
	self.sourceList = ItemTools.GetItemSourceList((self:GetItemID()))

	self.sourceScroll_:StartScroll(#self.sourceList)
end

function PopEquipSourceView:OnTop()
	local var_7_0 = ItemTools.GetItemSourceList((self:GetItemID()))

	self.sourceList = var_7_0

	if #var_7_0 > 0 then
		self.sourceScroll_:Refresh()
	end
end

function PopEquipSourceView:OnJumpCallback()
	OperationRecorder.Record(self.lastRecord_, "jump")
end

return PopEquipSourceView
