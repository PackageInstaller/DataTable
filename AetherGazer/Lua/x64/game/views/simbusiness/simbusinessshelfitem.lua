local var_0_0 = class("SimBusinessShelfItem", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.levelController = arg_2_0.controllerExCollection_:GetController("quality")
	arg_2_0.selectController = arg_2_0.controllerExCollection_:GetController("select")

	arg_2_0:AddUIListener()
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.clickBtn_, nil, function()
		if arg_4_0.clickFunc then
			arg_4_0.clickFunc(arg_4_0.id)
		else
			manager.notify:CallFirstUpdateFunc("OnShelfItemClick", arg_4_0.id)
		end
	end)
end

local var_0_1 = {
	"1",
	"2",
	"3",
	"4",
	"5",
	"6"
}

function var_0_0.RefreshData(arg_6_0, arg_6_1)
	local var_6_0 = SimBusinessShelfCfg[arg_6_1]

	arg_6_0.iconImage_.sprite = SimBusinessTools.GetShelfIcon(arg_6_1)

	local var_6_1 = SimBusinessData:GetShelfLevel(arg_6_1)

	if var_6_1 == 0 then
		arg_6_0.levelController:SetSelectedState("off")
	else
		arg_6_0.levelController:SetSelectedState(var_0_1[var_6_1] or var_0_1[#var_0_1])
	end
end

function var_0_0.RefreshSelect(arg_7_0, arg_7_1)
	arg_7_0.selectController:SetSelectedState(arg_7_1 and "true" or "false")
end

function var_0_0.RegisterClick(arg_8_0, arg_8_1)
	arg_8_0.clickFunc = arg_8_1
end

return var_0_0
