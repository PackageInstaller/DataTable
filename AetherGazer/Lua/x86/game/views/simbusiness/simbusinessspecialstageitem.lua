local var_0_0 = class("SimBusinessSpecialStageItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.scoreController = arg_2_0.controller:GetController("score")
	arg_2_0.stateController = arg_2_0.controller:GetController("state")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn, nil, function()
		if arg_4_0.clickFunc and arg_4_0.id and not arg_4_0.lock then
			arg_4_0.clickFunc(arg_4_0.id)
		end
	end)
end

function var_0_0.RefreshView(arg_6_0, arg_6_1)
	arg_6_0.id = arg_6_1
	arg_6_0.icon.sprite = SimBusinessTools.GetStageIcon(arg_6_0.id)
	arg_6_0.name.text = SimBusinessStageCfg[arg_6_0.id].name

	local var_6_0, var_6_1 = SimBusinessTools.GetStageState(arg_6_0.id)

	if var_6_0 == "lock" then
		arg_6_0.lock = true

		arg_6_0.stateController:SetSelectedState("lock")

		arg_6_0.lockDesc.text = GetTips(var_6_1)
	else
		arg_6_0.lock = false

		arg_6_0.stateController:SetSelectedState("normal")
	end

	if var_6_1 then
		arg_6_0.scoreController:SetSelectedState("1")

		arg_6_0.score.text = var_6_1
	else
		arg_6_0.scoreController:SetSelectedState("0")
	end

	local var_6_2 = SimBusinessTools.GetSpStageRedPoint(arg_6_1)

	if manager.redPoint:getTipBoolean(var_6_2) then
		manager.redPoint:SetRedPointIndependent(arg_6_0.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(arg_6_0.transform_, false)
	end
end

function var_0_0.RegisterClickFunc(arg_7_0, arg_7_1)
	arg_7_0.clickFunc = arg_7_1
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
