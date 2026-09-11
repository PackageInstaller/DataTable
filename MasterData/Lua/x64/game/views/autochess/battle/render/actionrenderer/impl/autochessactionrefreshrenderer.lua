local AtuoChessActionRefreshRenderer = class("AtuoChessActionRefreshRenderer", AutoChessActionBaseRenderer)

function AtuoChessActionRefreshRenderer:OnPlay()
	for iter_1_0, iter_1_1 in ipairs(self.actionData.refreshChessList) do
		local var_1_0 = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(iter_1_1.uniqueId)

		if var_1_0 and self.actionData.oldChessList[iter_1_1.uniqueId] then
			if iter_1_1.attributeData.hp - self.actionData.oldChessList[iter_1_1.uniqueId].attributeData.hp > 0 then
				var_1_0:UpdateHP()
				var_1_0:UpdateHPChange(iter_1_1.attributeData.hp - self.actionData.oldChessList[iter_1_1.uniqueId].attributeData.hp)
			end

			if iter_1_1.attributeData.atk - self.actionData.oldChessList[iter_1_1.uniqueId].attributeData.atk > 0 then
				var_1_0:UpdateAttack()
				var_1_0:UpdateAttackChange(iter_1_1.attributeData.atk - self.actionData.oldChessList[iter_1_1.uniqueId].attributeData.atk)
			end

			if iter_1_1.attributeData.exp - self.actionData.oldChessList[iter_1_1.uniqueId].attributeData.exp > 0 then
				var_1_0:UpdateLevel()
			end
		end
	end

	self:Finish()
end

return AtuoChessActionRefreshRenderer
