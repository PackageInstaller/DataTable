local var_0_0 = class("MatrixOverArtifactItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		if arg_2_0.id and arg_2_0.id ~= 0 then
			local var_3_0 = arg_2_0.transform_.position

			manager.matrixPop:ShowMatrixPopItem(arg_2_0.id, Vector3(-1, var_3_0.y + 0.1, var_3_0.z), arg_2_0.level)
		end
	end)
end

function var_0_0.Refresh(arg_4_0, arg_4_1)
	arg_4_0.id = arg_4_1.id

	local var_4_0 = arg_4_1.wins

	arg_4_0.level = nil

	local var_4_1 = MatrixItemCfg[arg_4_1.id].params[1]
	local var_4_2 = MatrixEffectCfg[var_4_1]

	if MatrixConst.EFFECT_ACTION.AFFIX == var_4_2.action then
		local var_4_3 = var_4_2.params[1]
		local var_4_4 = AffixTypeCfg[var_4_3]

		if var_4_4.max_level ~= 1 then
			arg_4_0.level = math.min(var_4_0, var_4_4.max_level)
		end
	end

	arg_4_0.icon_.sprite = MatrixTools.GetMatrixItemSprite(arg_4_1.id)
end

return var_0_0
