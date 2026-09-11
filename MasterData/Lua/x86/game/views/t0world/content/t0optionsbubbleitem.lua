local T0OptionsBubbleItem = class("T0OptionsBubbleItem", ReduxView)

function T0OptionsBubbleItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()
end

function T0OptionsBubbleItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.data and self.data.clickCallback then
			LuaExchangeHelper.ActionInvoke(self.data.clickCallback)
		end
	end)
end

function T0OptionsBubbleItem:SetData(arg_4_1)
	self.data = arg_4_1

	self:RefreshUI()
	self:ChangeOrder()
end

function T0OptionsBubbleItem:Remove()
	if self.data then
		self.data.clickCallback = nil
	end

	self.data = nil
end

function T0OptionsBubbleItem:RefreshUI()
	self.bubbleText_.text = GetTips(self.data.tipsKey)
end

function T0OptionsBubbleItem:ChangeOrder()
	self.transform_:SetSiblingIndex(self.data.order + 1)
end

function T0OptionsBubbleItem:Dispose()
	self:Remove()
	T0OptionsBubbleItem.super.Dispose(self)
end

return T0OptionsBubbleItem
