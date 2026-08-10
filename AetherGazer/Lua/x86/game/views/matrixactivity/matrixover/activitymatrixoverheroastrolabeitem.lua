local var_0_0 = import("game.views.matrixOver.MatrixOverHeroAstrolabeItem")
local var_0_1 = class("ActivityMatrixOverHeroAstrolabeItem", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddBtnListener(arg_1_0.btn_, nil, function()
		if arg_1_0.astrolabeID and arg_1_0.astrolabeID ~= 0 then
			local var_2_0 = arg_1_0.transform_.position

			manager.matrixPop:ShowMatrixPopItem(arg_1_0.astrolabeID, Vector3(-0.45, var_2_0.y + 0.1, var_2_0.z), nil, arg_1_0.heroId, arg_1_0.matrix_activity_id)
		end
	end)
end

function var_0_1.SetMatrixActivityId(arg_3_0, arg_3_1)
	arg_3_0.matrix_activity_id = arg_3_1
end

return var_0_1
