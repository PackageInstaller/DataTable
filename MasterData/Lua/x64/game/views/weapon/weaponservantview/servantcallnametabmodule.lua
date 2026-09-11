local ServantCallNameTabModule = class("ServantCallNameTabModule", ReduxView)

function ServantCallNameTabModule:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ServantCallNameTabModule:Init()
	self:BindCfgUI()
	self:BuildContext()
	self:AddUIListener()
end

function ServantCallNameTabModule:BuildContext()
	self.controller = {
		comps = self.tabController_,
		select = {
			False = "false",
			True = "true",
			comps = self.tabController_:GetController("select")
		}
	}
	self.data = {
		tabIdx = 1
	}
end

function ServantCallNameTabModule:AddUIListener()
	self:AddBtnListener(self.tabClickBtn_, nil, function()
		self:OnTabClick()
	end)
end

function ServantCallNameTabModule:SetTabIndex(arg_6_1)
	self.data.tabIdx = arg_6_1
end

function ServantCallNameTabModule:SetNumber(arg_7_1)
	self.callNameCountTxt_.text = arg_7_1
end

function ServantCallNameTabModule:SetSelect(arg_8_1)
	self.controller.select.comps:SetSelectedState((arg_8_1 or nil) and self.controller.select.True)
end

function ServantCallNameTabModule:RegisterClickCallback(arg_9_1)
	self.data.clickCallback = arg_9_1
end

function ServantCallNameTabModule:OnTabClick()
	if self.data.clickCallback then
		self.data.clickCallback(self.data.tabIdx)
	end
end

function ServantCallNameTabModule:OnDispose()
	self:RemoveAllListeners()
	ServantCallNameTabModule.super.Dispose(self)
end

return ServantCallNameTabModule
