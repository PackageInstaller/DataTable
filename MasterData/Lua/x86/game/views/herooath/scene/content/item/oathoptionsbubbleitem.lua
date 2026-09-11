local OathOptionsBubbleItem = class("OathOptionsBubbleItem", ReduxView)

function OathOptionsBubbleItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.finishController_ = self.controller_:GetController("finish")
end

function OathOptionsBubbleItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.data and self.data.clickCallback then
			LuaExchangeHelper.ActionInvoke(self.data.clickCallback)
		end
	end)
end

function OathOptionsBubbleItem:SetData(arg_4_1)
	self.data = arg_4_1

	self:RefreshUI()
	self:ChangeOrder()
	self:RefreshFinishUI()
end

function OathOptionsBubbleItem:Remove()
	if self.data then
		self.data.clickCallback = nil
	end

	self.data = nil
end

function OathOptionsBubbleItem:RefreshUI()
	self.bubbleText_.text = GetTips(self.data.tipsKey)
end

function OathOptionsBubbleItem:ChangeOrder()
	self.transform_:SetSiblingIndex(self.data.order + 1)
end

function OathOptionsBubbleItem:RefreshFinishUI()
	if self.data and self.data.isFinish then
		self.finishController_:SetSelectedState("finish")
	else
		self.finishController_:SetSelectedState("normal")
	end
end

function OathOptionsBubbleItem:Dispose()
	self:Remove()
	OathOptionsBubbleItem.super.Dispose(self)
end

return OathOptionsBubbleItem
