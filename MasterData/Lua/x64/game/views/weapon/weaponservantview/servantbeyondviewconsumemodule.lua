local ServantBeyondViewConsumeModule = class("ServantBeyondViewConsumeModule", ReduxView)

function ServantBeyondViewConsumeModule:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ServantBeyondViewConsumeModule:BuildContext()
	self.controller = {
		comps = self.controllerComps_,
		state = {
			select = {
				False = "false",
				name = "select",
				True = "true"
			}
		}
	}
	self.staticVar = {
		costItem_ = CommonItemView.New(self.resModuleObj_),
		commonData = clone(ItemTemplateData)
	}
	self.data = {}
end

function ServantBeyondViewConsumeModule:Init()
	self:BindCfgUI()
	self:BuildContext()
	self:AddUIListener()
end

function ServantBeyondViewConsumeModule:RefreshData(arg_4_1)
	if arg_4_1 then
		SetActive(self.resModuleObj_, true)

		self.staticVar.commonData = CommonTools.SetCommonData(self.staticVar.costItem_, arg_4_1, self.staticVar.commonData)
		self.resName_.text = ItemTools.getItemName(arg_4_1.id)
	else
		SetActive(self.resModuleObj_, false)
	end
end

function ServantBeyondViewConsumeModule:Dispose()
	if self.staticVar.costItem_ then
		self.staticVar.costItem_:Dispose()

		self.staticVar.costItem_ = nil
	end

	self:RemoveAllListeners()
	ServantBeyondViewConsumeModule.super.Dispose(self)
end

function ServantBeyondViewConsumeModule:SetSelect(arg_6_1)
	if arg_6_1 then
		self:SwitchControllerState(self.controller.state.select.name, self.controller.state.select.True)
	else
		self:SwitchControllerState(self.controller.state.select.name, self.controller.state.select.False)
	end
end

function ServantBeyondViewConsumeModule:SwitchControllerState(arg_7_1, arg_7_2)
	local var_7_0 = self.controller.comps:GetController(arg_7_1)

	if var_7_0 then
		var_7_0:SetSelectedState(arg_7_2)
	end
end

function ServantBeyondViewConsumeModule:AddUIListener()
	self:AddBtnListener(self.cellBtn_, nil, function()
		if self.data.onClick then
			self.data.onClick()
		end
	end)
end

function ServantBeyondViewConsumeModule:RegisteBtnListener(arg_10_1)
	self.data.onClick = arg_10_1
end

return ServantBeyondViewConsumeModule
