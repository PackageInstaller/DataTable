local ActivityMatrixProcessShopSelectHeroView = class("ActivityMatrixProcessShopSelectHeroView", MatrixProcessSelectHeroView)

function ActivityMatrixProcessShopSelectHeroView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id

	ActivityMatrixProcessShopSelectHeroView.super.OnEnter(self)
end

function ActivityMatrixProcessShopSelectHeroView:OnRewardAction()
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
			JumpTools.OpenPageByJump("activityMatrixProcessEquipReplace", {
				matrix_activity_id = self.matrix_activity_id,
				heroId = var_2_1,
				equipId = var_2_0,
				callback = function(arg_3_0)
					ActivityMatrixAction.BuyShopItem(self.matrix_activity_id, self.shopIndex, var_2_4:GetStandardId(), arg_3_0)
				end
			})
		else
			ActivityMatrixAction.BuyShopItem(self.matrix_activity_id, self.shopIndex, var_2_4:GetStandardId(), 0)
		end
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == var_2_3 then
		local var_2_5 = self:GetHeroData(var_2_1)
		local var_2_6 = var_2_5:GetWeaponServant()

		if var_2_6 ~= 0 then
			JumpTools.OpenPageByJump("activityMatrixProcessWeaponReplace", {
				matrix_activity_id = self.matrix_activity_id,
				heroId = var_2_1,
				weaponId = var_2_0,
				callback = function()
					ActivityMatrixAction.BuyShopItem(self.matrix_activity_id, self.shopIndex, var_2_5:GetStandardId(), var_2_6)
				end
			})
		else
			ActivityMatrixAction.BuyShopItem(self.matrix_activity_id, self.shopIndex, var_2_5:GetStandardId(), 0)
		end
	else
		ActivityMatrixAction.BuyShopItem(self.matrix_activity_id, self.shopIndex, self:GetHeroData(var_2_1):GetStandardId(), 0)
	end
end

function ActivityMatrixProcessShopSelectHeroView:GetHeroData(arg_5_1)
	return ActivityMatrixData:GetHeroData(self.matrix_activity_id, arg_5_1)
end

function ActivityMatrixProcessShopSelectHeroView:GetHeroEquipMaxCount()
	return ActivityMatrixData:GetHeroEquipMaxCount(self.matrix_activity_id)
end

function ActivityMatrixProcessShopSelectHeroView:GetMatrixHeroTeam()
	return ActivityMatrixData:GetMatrixHeroTeam(self.matrix_activity_id)
end

return ActivityMatrixProcessShopSelectHeroView
