local RegressionSelectPoolItem = class("RegressionSelectPoolItem", ReduxView)

function RegressionSelectPoolItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RegressionSelectPoolItem:Init()
	self:BindCfgUI()

	self.selectController_ = self.controller_:GetController("select")

	self:AddBtnListener(self.btn_, nil, function()
		if self.callback_ then
			self.callback_(self.index)
		end
	end)
end

function RegressionSelectPoolItem:SetData(arg_4_1, arg_4_2)
	self.index = arg_4_1
	self.iconImg_.sprite = getSpriteViaConfig("HeroItemshead", DrawPoolCfg[arg_4_2].unoption_up_items[1][1])
end

function RegressionSelectPoolItem:RegistCallBack(arg_5_1)
	self.callback_ = arg_5_1
end

function RegressionSelectPoolItem:UpdateSelectState(arg_6_1)
	self.selectController_:SetSelectedState(arg_6_1 and "true" or "false")
end

function RegressionSelectPoolItem:Dispose()
	RegressionSelectPoolItem.super.Dispose(self)
end

return RegressionSelectPoolItem
