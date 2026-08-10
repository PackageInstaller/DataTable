local var_0_0 = class("ServantBeyondViewConsumeModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.BuildContext(arg_2_0)
	arg_2_0.controller = {
		comps = arg_2_0.controllerComps_,
		state = {
			select = {
				False = "false",
				name = "select",
				True = "true"
			}
		}
	}
	arg_2_0.staticVar = {
		costItem_ = CommonItemView.New(arg_2_0.resModuleObj_),
		commonData = clone(ItemTemplateData)
	}
	arg_2_0.data = {}
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:BuildContext()
	arg_3_0:AddUIListener()
end

function var_0_0.RefreshData(arg_4_0, arg_4_1)
	if arg_4_1 then
		SetActive(arg_4_0.resModuleObj_, true)

		arg_4_0.staticVar.commonData = CommonTools.SetCommonData(arg_4_0.staticVar.costItem_, arg_4_1, arg_4_0.staticVar.commonData)
		arg_4_0.resName_.text = ItemTools.getItemName(arg_4_1.id)
	else
		SetActive(arg_4_0.resModuleObj_, false)
	end
end

function var_0_0.Dispose(arg_5_0)
	if arg_5_0.staticVar.costItem_ then
		arg_5_0.staticVar.costItem_:Dispose()

		arg_5_0.staticVar.costItem_ = nil
	end

	arg_5_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.SetSelect(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0:SwitchControllerState(arg_6_0.controller.state.select.name, arg_6_0.controller.state.select.True)
	else
		arg_6_0:SwitchControllerState(arg_6_0.controller.state.select.name, arg_6_0.controller.state.select.False)
	end
end

function var_0_0.SwitchControllerState(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.controller.comps:GetController(arg_7_1)

	if var_7_0 then
		var_7_0:SetSelectedState(arg_7_2)
	end
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.cellBtn_, nil, function()
		local var_9_0 = arg_8_0.data.onClick

		if var_9_0 then
			var_9_0()
		end
	end)
end

function var_0_0.RegisteBtnListener(arg_10_0, arg_10_1)
	arg_10_0.data.onClick = arg_10_1
end

return var_0_0
