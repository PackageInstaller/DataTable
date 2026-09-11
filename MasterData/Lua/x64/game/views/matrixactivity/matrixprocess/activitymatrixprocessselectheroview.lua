local ActivityMatrixProcessSelectHeroView = class("ActivityMatrixProcessSelectHeroView", MatrixProcessSelectHeroView)

function ActivityMatrixProcessSelectHeroView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id

	ActivityMatrixProcessSelectHeroView.super.OnEnter(self)
end

function ActivityMatrixProcessSelectHeroView:OnRewardAction()
	local var_2_0 = self.id
	local var_2_1 = self.selectHeroId
	local var_2_2

	if self.id then
		var_2_2 = MatrixItemCfg[self.id] or nil

		if not var_2_2 then
			return
		end
	end

	local var_2_3 = var_2_2.matrix_item_type

	if MatrixConst.ITEM_TYPE.EQUIP == var_2_2.matrix_item_type then
		local var_2_4 = self:GetHeroData(var_2_1)

		if self:GetHeroEquipMaxCount() <= #var_2_4:GetEquipList() then
			JumpTools.OpenPageByJump("activityMatrixProcessEquipReplace", {
				heroId = var_2_1,
				equipId = self.id,
				callback = function(arg_3_0)
					ActivityMatrixAction.QueryNextProgress(self.matrix_activity_id, {
						var_2_0,
						arg_3_0,
						var_2_4:GetStandardId()
					})
				end
			})
		else
			ActivityMatrixAction.QueryNextProgress(self.matrix_activity_id, {
				self.id,
				0,
				var_2_4:GetStandardId()
			})
		end
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == var_2_3 then
		local var_2_5 = self:GetHeroData(var_2_1)
		local var_2_6 = var_2_5:GetWeaponServant()

		if var_2_6 ~= 0 then
			JumpTools.OpenPageByJump("activityMatrixProcessWeaponReplace", {
				heroId = var_2_1,
				weaponId = self.id,
				callback = function()
					ActivityMatrixAction.QueryNextProgress(self.matrix_activity_id, {
						var_2_0,
						var_2_6,
						var_2_5:GetStandardId()
					})
				end
			})
		else
			ActivityMatrixAction.QueryNextProgress(self.matrix_activity_id, {
				self.id,
				0,
				var_2_5:GetStandardId()
			})
		end
	else
		local var_2_7 = self:GetHeroData(var_2_1)

		ActivityMatrixAction.QueryNextProgress(self.matrix_activity_id, {
			self.id,
			0,
			var_2_7:GetStandardId()
		})
	end
end

function ActivityMatrixProcessSelectHeroView:GetHeroData(arg_5_1)
	return ActivityMatrixData:GetHeroData(self.matrix_activity_id, arg_5_1)
end

function ActivityMatrixProcessSelectHeroView:GetMatrixHeroTeam()
	return ActivityMatrixData:GetMatrixHeroTeam(self.matrix_activity_id)
end

function ActivityMatrixProcessSelectHeroView:GetHeroEquipMaxCount()
	return ActivityMatrixData:GetHeroEquipMaxCount(self.matrix_activity_id)
end

return ActivityMatrixProcessSelectHeroView
