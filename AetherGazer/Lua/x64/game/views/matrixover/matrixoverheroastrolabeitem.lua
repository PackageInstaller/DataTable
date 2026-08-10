local var_0_0 = class("MatrixOverHeroAstrolabeItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddBtnListener(arg_1_0.btn_, nil, function()
		if arg_1_0.astrolabeID and arg_1_0.astrolabeID ~= 0 then
			local var_2_0 = arg_1_0.transform_.position

			manager.matrixPop:ShowMatrixPopItem(arg_1_0.astrolabeID, Vector3(-0.45, var_2_0.y + 0.1, var_2_0.z), nil, arg_1_0.heroId)
		end
	end)
end

function var_0_0.Refresh(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.heroId = arg_3_2
	arg_3_0.astrolabeID = arg_3_1 or 0

	if arg_3_1 and arg_3_1 ~= 0 then
		arg_3_0.icon_.sprite = MatrixTools.GetMatrixItemSprite(arg_3_1)

		SetActive(arg_3_0.gameObject_, true)
	else
		SetActive(arg_3_0.gameObject_, false)
	end
end

return var_0_0
