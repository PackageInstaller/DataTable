local var_0_0 = class("DanceDIYSceneItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.selectController = arg_2_0.controllers_:GetController("select")

	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		arg_3_0:OnClick()
	end)
end

function var_0_0.SetOnClick(arg_5_0, arg_5_1)
	arg_5_0.onClick = arg_5_1
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.scene = arg_6_1

	arg_6_0:Refresh()
end

function var_0_0.SetSelected(arg_7_0, arg_7_1)
	arg_7_0.selectController:SetSelectedState(arg_7_1 and "true" or "false")
end

function var_0_0.Refresh(arg_8_0)
	local var_8_0 = IdolStageSceneCfg[arg_8_0.scene]

	arg_8_0.icon_.sprite = getSpriteViaConfig("IdolStageIcon", var_8_0.stage_picture)
end

function var_0_0.OnClick(arg_9_0)
	if arg_9_0.onClick then
		arg_9_0.onClick(arg_9_0.scene)
	end
end

return var_0_0
