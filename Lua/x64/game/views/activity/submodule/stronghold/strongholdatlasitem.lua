local var_0_0 = class("StrongholdAtlasItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.rareController = ControllerUtil.GetController(arg_3_0.transform_, "rare")
	arg_3_0.typeController = ControllerUtil.GetController(arg_3_0.transform_, "type")
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = ActivityStrongholdArtifactCfg[arg_5_1]
	local var_5_1 = StrongholdData:GetAtlasUseCount(arg_5_2, arg_5_1)

	if var_5_1 == 0 then
		arg_5_0.stateController:SetSelectedIndex(1)
	else
		arg_5_0.stateController:SetSelectedIndex(0)

		arg_5_0.m_name.text = var_5_0.name
		arg_5_0.m_des.text = var_5_0.desc
		arg_5_0.m_icon.sprite = pureGetSpriteWithoutAtlas(var_5_0.icon)

		arg_5_0.rareController:SetSelectedIndex(var_5_0.rare - 1)

		arg_5_0.m_useCount.text = string.format(GetTips("ACTIVITY_STRONGHOLD_ATLAS_USE_COUNT"), var_5_1)
	end

	arg_5_0.typeController:SetSelectedIndex(var_5_0.type)
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
