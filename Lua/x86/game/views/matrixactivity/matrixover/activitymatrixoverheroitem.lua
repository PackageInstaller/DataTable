local var_0_0 = import("game.views.matrixOver.MatrixOverHeroItem")
local var_0_1 = class("ActivityMatrixOverHeroItem", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.servantView_ = ActivityMatrixOverHeroServantItem.New(arg_1_0.servantItem_)
	arg_1_0.equipItemView_ = {}

	for iter_1_0 = 1, 5 do
		local var_1_0 = arg_1_0[string.format("equipGo%s_", iter_1_0)]

		table.insert(arg_1_0.equipItemView_, MatrixOverHeroEquipItem.New(var_1_0))
	end

	arg_1_0.astrolabeItemView_ = {}

	for iter_1_1 = 1, 6 do
		local var_1_1 = arg_1_0[string.format("astrolabeGo%s_", iter_1_1)]

		table.insert(arg_1_0.astrolabeItemView_, ActivityMatrixOverHeroAstrolabeItem.New(var_1_1))
	end
end

function var_0_1.SetMatrixActivityId(arg_2_0, arg_2_1)
	arg_2_0.servantView_:SetMatrixActivityId(arg_2_1)

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.astrolabeItemView_) do
		iter_2_1:SetMatrixActivityId(arg_2_1)
	end

	arg_2_0.matrix_activity_id = arg_2_1
end

function var_0_1.GetHeroData(arg_3_0, arg_3_1)
	return ActivityMatrixData:GetHeroData(arg_3_0.matrix_activity_id, arg_3_1)
end

function var_0_1.GetHeroSkin(arg_4_0, arg_4_1)
	return ActivityMatrixData:GetHeroSkin(arg_4_0.matrix_activity_id, arg_4_1)
end

return var_0_1
