local var_0_0 = class("MatrixProcessSelectHeroView", MatrixProcessSelectHeroView)

function var_0_0.OnRewardAction(arg_1_0)
	arg_1_0.shopIndex = arg_1_0.params_.index

	local var_1_0 = arg_1_0.id
	local var_1_1 = arg_1_0.selectHeroId
	local var_1_2 = var_1_0 and MatrixItemCfg[var_1_0] or nil

	if not var_1_2 then
		return
	end

	local var_1_3 = var_1_2.matrix_item_type

	if MatrixConst.ITEM_TYPE.EQUIP == var_1_3 then
		local var_1_4 = MatrixData:GetHeroData(var_1_1)
		local var_1_5 = var_1_4:GetEquipList()

		if MatrixData:GetHeroEquipMaxCount() <= #var_1_5 then
			JumpTools.OpenPageByJump("matrixProcessEquipReplace", {
				heroId = var_1_1,
				equipId = var_1_0,
				callback = function(arg_2_0)
					MatrixAction.BuyShopItem(arg_1_0.shopIndex, var_1_4:GetStandardId(), arg_2_0)
				end
			})
		else
			MatrixAction.BuyShopItem(arg_1_0.shopIndex, var_1_4:GetStandardId(), 0)
		end
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == var_1_3 then
		local var_1_6 = MatrixData:GetHeroData(var_1_1)
		local var_1_7 = var_1_6:GetWeaponServant()

		if var_1_7 ~= 0 then
			JumpTools.OpenPageByJump("matrixProcessWeaponReplace", {
				heroId = var_1_1,
				weaponId = var_1_0,
				callback = function()
					MatrixAction.BuyShopItem(arg_1_0.shopIndex, var_1_6:GetStandardId(), var_1_7)
				end
			})
		else
			MatrixAction.BuyShopItem(arg_1_0.shopIndex, var_1_6:GetStandardId(), 0)
		end
	else
		local var_1_8 = MatrixData:GetHeroData(var_1_1)

		MatrixAction.BuyShopItem(arg_1_0.shopIndex, var_1_8:GetStandardId(), 0)
	end
end

return var_0_0
