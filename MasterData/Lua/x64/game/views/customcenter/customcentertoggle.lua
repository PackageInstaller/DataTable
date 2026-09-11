local CustomCenterToggle = class("CustomCenterToggle", ReduxView)

function CustomCenterToggle:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = self.conEx_:GetController("select")
end

function CustomCenterToggle:Dispose()
	CustomCenterToggle.super.Dispose(self)
end

function CustomCenterToggle:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickFunc_ then
			self.clickFunc_()
		end
	end)
end

function CustomCenterToggle:RegisterClickListener(arg_5_1)
	self.clickFunc_ = arg_5_1
end

function CustomCenterToggle:SetSelectedState(arg_6_1)
	self.selectController_:SetSelectedState(arg_6_1 and "on" or "off")
end

return CustomCenterToggle
