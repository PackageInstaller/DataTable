local var_0_0 = class("StrategyMatrixProcessShopSelectHeroView", MatrixProcessSelectHeroView)

function var_0_0.OnEnter(arg_1_0)
	arg_1_0.matrix_activity_id = arg_1_0.params_.matrix_activity_id

	var_0_0.super.OnEnter(arg_1_0)
end

function var_0_0.OnRewardAction(arg_2_0)
	arg_2_0.shopIndex = arg_2_0.params_.index

	local var_2_0 = arg_2_0.id
	local var_2_1 = arg_2_0.selectHeroId
	local var_2_2 = var_2_0 and MatrixItemCfg[var_2_0] or nil

	if not var_2_2 then
		return
	end

	local var_2_3 = var_2_2.matrix_item_type

	if MatrixConst.ITEM_TYPE.EQUIP == var_2_3 then
		local var_2_4 = arg_2_0:GetHeroData(var_2_1)
		local var_2_5 = var_2_4:GetEquipList()

		if arg_2_0:GetHeroEquipMaxCount() <= #var_2_5 then
			JumpTools.OpenPageByJump("strategyMatrixProcessEquipReplace", {
				matrix_activity_id = arg_2_0.matrix_activity_id,
				heroId = var_2_1,
				equipId = var_2_0,
				callback = function(arg_3_0)
					StrategyMatrixAction.BuyShopItem(arg_2_0.matrix_activity_id, arg_2_0.shopIndex, var_2_4:GetStandardId(), arg_3_0)
				end
			})
		else
			StrategyMatrixAction.BuyShopItem(arg_2_0.matrix_activity_id, arg_2_0.shopIndex, var_2_4:GetStandardId(), 0)
		end
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == var_2_3 then
		local var_2_6 = arg_2_0:GetHeroData(var_2_1)
		local var_2_7 = var_2_6:GetWeaponServant()

		if var_2_7 ~= 0 then
			JumpTools.OpenPageByJump("strategyMatrixProcessWeaponReplace", {
				matrix_activity_id = arg_2_0.matrix_activity_id,
				heroId = var_2_1,
				weaponId = var_2_0,
				callback = function()
					StrategyMatrixAction.BuyShopItem(arg_2_0.matrix_activity_id, arg_2_0.shopIndex, var_2_6:GetStandardId(), var_2_7)
				end
			})
		else
			StrategyMatrixAction.BuyShopItem(arg_2_0.matrix_activity_id, arg_2_0.shopIndex, var_2_6:GetStandardId(), 0)
		end
	else
		local var_2_8 = arg_2_0:GetHeroData(var_2_1)

		StrategyMatrixAction.BuyShopItem(arg_2_0.matrix_activity_id, arg_2_0.shopIndex, var_2_8:GetStandardId(), 0)
	end
end

function var_0_0.GetHeroData(arg_5_0, arg_5_1)
	return StrategyMatrixData:GetHeroDataNew(arg_5_1)
end

function var_0_0.GetHeroEquipMaxCount(arg_6_0)
	return StrategyMatrixData:GetHeroEquipMaxCount(arg_6_0.matrix_activity_id)
end

function var_0_0.GetMatrixHeroTeam(arg_7_0)
	return StrategyMatrixData:GetMatrixHeroTeam(arg_7_0.matrix_activity_id)
end

return var_0_0
