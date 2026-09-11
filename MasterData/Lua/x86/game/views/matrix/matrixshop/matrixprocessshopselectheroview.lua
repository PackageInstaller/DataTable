local MatrixProcessSelectHeroView = class("MatrixProcessSelectHeroView", MatrixProcessSelectHeroView)

function MatrixProcessSelectHeroView:OnRewardAction()
	self.shopIndex = self.params_.index

	local var_1_0 = self.id
	local var_1_1 = self.selectHeroId
	local var_1_2

	if self.id then
		var_1_2 = MatrixItemCfg[var_1_0] or nil

		if not var_1_2 then
			return
		end
	end

	local var_1_3 = var_1_2.matrix_item_type

	if MatrixConst.ITEM_TYPE.EQUIP == var_1_2.matrix_item_type then
		local var_1_4 = MatrixData:GetHeroData(var_1_1)

		if MatrixData:GetHeroEquipMaxCount() <= #var_1_4:GetEquipList() then
			JumpTools.OpenPageByJump("matrixProcessEquipReplace", {
				heroId = var_1_1,
				equipId = var_1_0,
				callback = function(arg_2_0)
					MatrixAction.BuyShopItem(self.shopIndex, var_1_4:GetStandardId(), arg_2_0)
				end
			})
		else
			MatrixAction.BuyShopItem(self.shopIndex, var_1_4:GetStandardId(), 0)
		end
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == var_1_3 then
		local var_1_5 = MatrixData:GetHeroData(var_1_1)
		local var_1_6 = var_1_5:GetWeaponServant()

		if var_1_6 ~= 0 then
			JumpTools.OpenPageByJump("matrixProcessWeaponReplace", {
				heroId = var_1_1,
				weaponId = var_1_0,
				callback = function()
					MatrixAction.BuyShopItem(self.shopIndex, var_1_5:GetStandardId(), var_1_6)
				end
			})
		else
			MatrixAction.BuyShopItem(self.shopIndex, var_1_5:GetStandardId(), 0)
		end
	else
		MatrixAction.BuyShopItem(self.shopIndex, MatrixData:GetHeroData(var_1_1):GetStandardId(), 0)
	end
end

return MatrixProcessSelectHeroView
