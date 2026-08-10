local var_0_0 = class("AtuoChessActionRefreshRenderer", AutoChessActionBaseRenderer)

function var_0_0.OnPlay(arg_1_0)
	for iter_1_0, iter_1_1 in ipairs(arg_1_0.actionData.refreshChessList) do
		local var_1_0 = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(iter_1_1.uniqueId)
		local var_1_1 = arg_1_0.actionData.oldChessList[iter_1_1.uniqueId]

		if var_1_0 and var_1_1 then
			if iter_1_1.attributeData.hp - var_1_1.attributeData.hp > 0 then
				var_1_0:UpdateHP()
				var_1_0:UpdateHPChange(iter_1_1.attributeData.hp - var_1_1.attributeData.hp)
			end

			if iter_1_1.attributeData.atk - var_1_1.attributeData.atk > 0 then
				var_1_0:UpdateAttack()
				var_1_0:UpdateAttackChange(iter_1_1.attributeData.atk - var_1_1.attributeData.atk)
			end

			if iter_1_1.attributeData.exp - var_1_1.attributeData.exp > 0 then
				var_1_0:UpdateLevel()
			end
		end
	end

	arg_1_0:Finish()
end

return var_0_0
