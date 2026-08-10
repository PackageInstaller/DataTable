local var_0_0 = import("game.views.autoChess.battle.render.actionRenderer.Impl.buffAction.AutoChessEffectBaseRenderer")
local var_0_1 = class("AutoChessAddAttrRenderer", var_0_0)

function var_0_1.OnPlay(arg_1_0)
	for iter_1_0, iter_1_1 in ipairs(arg_1_0.actionData.targetAttributeDataList) do
		local var_1_0 = iter_1_1.chessUid
		local var_1_1 = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(var_1_0)
		local var_1_2 = AutoChessData:GetChessData(var_1_0)

		if var_1_1 then
			var_1_1:UpdateData(var_1_2)

			if iter_1_1.attrData.hp ~= 0 then
				var_1_1:UpdateHP()
				var_1_1:UpdateHPChange(iter_1_1.attrData.hp)
			end

			if iter_1_1.attrData.atk ~= 0 then
				var_1_1:UpdateAttack()
				var_1_1:UpdateAttackChange(iter_1_1.attrData.atk)
			end

			if iter_1_1.attrData.exp ~= 0 then
				var_1_1:UpdateLevel()
			end
		else
			print("添加属性表现节点，目标" .. var_1_0 .. "不存在")
		end
	end

	arg_1_0:Finish()
end

return var_0_1
