local BilliardGameQuestModule = class("BilliardGameQuestModule", ReduxView)

function BilliardGameQuestModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function BilliardGameQuestModule:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.lookController = self.mainControllerEx_:GetController("look")
	self.completeController = self.mainControllerEx_:GetController("complete")

	self.lookController:SetSelectedIndex(1)
	self.completeController:SetSelectedIndex(0)
end

function BilliardGameQuestModule:AddUIListener()
	self:AddBtnListener(self.lookBtn_, nil, function()
		if self.lookController:GetSelectedIndex() == 1 then
			return
		end

		self.lookController:SetSelectedIndex(1)
	end)
	self:AddBtnListener(self.closeBtn_, nil, function()
		if self.lookController:GetSelectedIndex() == 0 then
			return
		end

		self.lookController:SetSelectedIndex(0)
	end)
end

function BilliardGameQuestModule:Refresh(arg_6_1)
	return
end

function BilliardGameQuestModule:OnDataChange()
	return
end

function BilliardGameQuestModule:Finish(arg_8_1)
	if arg_8_1 then
		self.lookController:SetSelectedIndex(1)
		self.completeController:SetSelectedIndex(1)
	else
		self.lookController:SetSelectedIndex(0)
		self.completeController:SetSelectedIndex(0)
	end
end

function BilliardGameQuestModule:Dispose()
	BilliardGameQuestModule.super.Dispose(self)
end

return BilliardGameQuestModule
