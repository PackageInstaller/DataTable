local var_0_0 = class("PolyhedronOverBeaconItem", ReduxView)

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
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickFunc then
			local var_5_0 = arg_4_0.transform_.position
			local var_5_1 = PolyhedronBeaconCfg[arg_4_0.id]

			arg_4_0.clickFunc(var_5_1.name, var_5_1.desc, Vector3(-0.9, var_5_0.y, var_5_0.z))
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.id = arg_6_1

	local var_6_0 = PolyhedronBeaconCfg[arg_6_1]

	arg_6_0.icon_.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.BEACON_ICON_PATH .. var_6_0.icon)
end

function var_0_0.RegistCallBack(arg_7_0, arg_7_1)
	arg_7_0.clickFunc = arg_7_1
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
