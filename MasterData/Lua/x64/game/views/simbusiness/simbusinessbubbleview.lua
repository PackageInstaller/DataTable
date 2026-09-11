local SimBusinessBubbleView = class("SimBusinessBubbleView", BaseView)

function SimBusinessBubbleView:UIName()
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/SummerUI_3_5_BubbleView"
end

function SimBusinessBubbleView:BubbleRoot()
	return self.transform_
end

function SimBusinessBubbleView:Ctor()
	SimBusinessBubbleView.super.Ctor(self)

	self.gameObject_ = GameObject.Instantiate(Asset.Load(self:UIName()), manager.ui.uiMain.transform)
	self.transform_ = self.gameObject_.transform
	self.bubbles = {}
end

function SimBusinessBubbleView:Dispose()
	for iter_4_0, iter_4_1 in pairs(self.bubbles) do
		iter_4_1:Dispose()
	end

	self.bubbles = nil

	SimBusinessBubbleView.super.Dispose(self)
	GameObject.Destroy(self.gameObject_)

	self.transform_, self.gameObject_ = nil
end

function SimBusinessBubbleView:GetBubble(arg_5_1)
	return self.bubbles[arg_5_1]
end

function SimBusinessBubbleView:EmplaceBubble(arg_6_1, arg_6_2, ...)
	local var_6_0 = self:GetBubble(arg_6_1)

	if var_6_0 then
		return false, var_6_0
	end

	local var_6_1 = arg_6_2.New(...)

	var_6_1.transform_:SetParent(self.transform_)

	self.bubbles[arg_6_1] = var_6_1

	return true, var_6_1
end

function SimBusinessBubbleView:RemoveBubble(arg_7_1)
	local var_7_0 = self:GetBubble(arg_7_1)

	if var_7_0 then
		var_7_0:Dispose()

		self.bubbles[arg_7_1] = nil
	end
end

function SimBusinessBubbleView:ClearAllBubble()
	for iter_8_0, iter_8_1 in pairs(self.bubbles) do
		iter_8_1:Dispose()
	end

	self.bubbles = {}
end

return SimBusinessBubbleView
