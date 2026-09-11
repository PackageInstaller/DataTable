local PopItemMergeView = class("PopItemMergeView", PopItemSourceView)

function PopItemMergeView:AddListeners()
	PopItemMergeView.super.AddListeners(self)
	self:AddBtnListener(self.mergeBtn_, nil, function()
		JumpTools.OpenPageByJump("synthesise", {
			id = ItemCfg[self:GetItemID()].compose_id
		})
	end)
	self:AddBtnListener(self.decomposeBtn_, nil, function()
		JumpTools.OpenPageByJump("synthesise", {
			id = ItemCfg[self:GetItemID()].decompose_id
		})
	end)
end

function PopItemMergeView:OnEnter()
	PopItemMergeView.super.OnEnter(self)

	self.equipInfo_ = self.params_.equip_info or {}
end

function PopItemMergeView:CustomInitUI()
	PopItemMergeView.super.CustomInitUI(self)
end

function PopItemMergeView:OnEnter()
	self.super.OnEnter(self)
	self:RefreshBtn()
end

function PopItemMergeView:RefreshBtn()
	local var_7_0 = ItemCfg[self:GetItemID()]

	SetActive(self.decomposeBtn_.gameObject, var_7_0.decompose_id ~= 0 and ItemExchangeCfg[var_7_0.decompose_id] ~= nil)
	SetActive(self.mergeBtn_.gameObject, var_7_0.compose_id ~= 0 and ItemExchangeCfg[var_7_0.compose_id] ~= nil)
end

function PopItemMergeView:RefreshItem()
	PopItemMergeView.super.RefreshItem(self)

	self.cntText_.text = string.format("x%d", NumberTools.RetractNumberForWindBar((ItemTools.getItemNum(self:GetItemID()))))
end

return PopItemMergeView
