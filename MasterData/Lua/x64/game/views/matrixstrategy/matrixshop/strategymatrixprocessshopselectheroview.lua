local StrategyMatrixProcessShopSelectHeroView = class("StrategyMatrixProcessShopSelectHeroView", MatrixProcessSelectHeroView)

function StrategyMatrixProcessShopSelectHeroView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id

	StrategyMatrixProcessShopSelectHeroView.super.OnEnter(self)
end

function StrategyMatrixProcessShopSelectHeroView:OnRewardAction()
	self.shopIndex = self.params_.index

	local var_2_0 = self.id
	local var_2_1 = self.selectHeroId
	local var_2_2

	if self.id then
		var_2_2 = MatrixItemCfg[var_2_0] or nil

		if not var_2_2 then
			return
		end
	end

	local var_2_3 = var_2_2.matrix_item_type

	if MatrixConst.ITEM_TYPE.EQUIP == var_2_2.matrix_item_type then
		local var_2_4 = self:GetHeroData(var_2_1)

		if self:GetHeroEquipMaxCount() <= #var_2_4:GetEquipList() then
			JumpTools.OpenPageByJump("strategyMatrixProcessEquipReplace", {
				matrix_activity_id = self.matrix_activity_id,
				heroId = var_2_1,
				equipId = var_2_0,
				callback = function(arg_3_0)
					StrategyMatrixAction.BuyShopItem(self.matrix_activity_id, self.shopIndex, var_2_4:GetStandardId(), arg_3_0)
				end
			})
		else
			StrategyMatrixAction.BuyShopItem(self.matrix_activity_id, self.shopIndex, var_2_4:GetStandardId(), 0)
		end
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == var_2_3 then
		local var_2_5 = self:GetHeroData(var_2_1)
		local var_2_6 = var_2_5:GetWeaponServant()

		if var_2_6 ~= 0 then
			JumpTools.OpenPageByJump("strategyMatrixProcessWeaponReplace", {
				matrix_activity_id = self.matrix_activity_id,
				heroId = var_2_1,
				weaponId = var_2_0,
				callback = function()
					StrategyMatrixAction.BuyShopItem(self.matrix_activity_id, self.shopIndex, var_2_5:GetStandardId(), var_2_6)
				end
			})
		else
			StrategyMatrixAction.BuyShopItem(self.matrix_activity_id, self.shopIndex, var_2_5:GetStandardId(), 0)
		end
	else
		StrategyMatrixAction.BuyShopItem(self.matrix_activity_id, self.shopIndex, self:GetHeroData(var_2_1):GetStandardId(), 0)
	end
end

function StrategyMatrixProcessShopSelectHeroView:GetHeroData(arg_5_1)
	return StrategyMatrixData:GetHeroDataNew(arg_5_1)
end

function StrategyMatrixProcessShopSelectHeroView:GetHeroEquipMaxCount()
	return StrategyMatrixData:GetHeroEquipMaxCount(self.matrix_activity_id)
end

function StrategyMatrixProcessShopSelectHeroView:GetMatrixHeroTeam()
	return StrategyMatrixData:GetMatrixHeroTeam(self.matrix_activity_id)
end

return StrategyMatrixProcessShopSelectHeroView
