local var_0_0 = class("MatrixOverBeaconItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		local var_3_0 = arg_2_0.transform_.position

		manager.matrixPop:ShowMatrixBeaconPopItem(arg_2_0.id, Vector3(-0.8, var_3_0.y + 0.1, var_3_0.z))
	end)
end

function var_0_0.Refresh(arg_4_0, arg_4_1)
	arg_4_0.id = arg_4_1

	local var_4_0 = MatrixBeaconCfg[arg_4_1]

	arg_4_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/MatrixItem/MatrixArtifact/" .. var_4_0.icon)
end

return var_0_0
