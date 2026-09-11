local BubbleItem = class("BubbleItem", BaseView)

function BubbleItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.uiFollow = arg_1_1:GetComponent("UIFollow")

	self:BindCfgUI()
end

function BubbleItem:ShowSubtitle(arg_3_1, arg_3_2)
	return
end

local function var_0_2(arg_4_0)
	return arg_4_0 == nil or arg_4_0 == "" or IsAllSpace(arg_4_0)
end

function BubbleItem:SetData(arg_5_1)
	self.text.text = arg_5_1

	if not var_0_2(arg_5_1) then
		self.content:SetActive(true)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.content.transform)
	end
end

function BubbleItem:Hide()
	if self.task then
		self.task:Abort()

		self.task = nil
	end
end

function BubbleItem:IsPlaying()
	return self.task ~= nil
end

function BubbleItem:Dispose()
	BubbleItem.super.Dispose(self)

	if self.task then
		self.task:Abort()

		self.task = nil
	end

	self.gameObject_:Destroy()
end

return BubbleItem
