local AutoChessAddAttrRenderer = class("AutoChessAddAttrRenderer", (import("game.views.autoChess.battle.render.actionRenderer.Impl.buffAction.AutoChessEffectBaseRenderer")))

function AutoChessAddAttrRenderer:OnPlay()
	for iter_1_0, iter_1_1 in ipairs(self.actionData.targetAttributeDataList) do
		local var_1_0 = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(iter_1_1.chessUid)

		if var_1_0 then
			var_1_0:UpdateData((AutoChessData:GetChessData(iter_1_1.chessUid)))

			if iter_1_1.attrData.hp ~= 0 then
				var_1_0:UpdateHP()
				var_1_0:UpdateHPChange(iter_1_1.attrData.hp)
			end

			if iter_1_1.attrData.atk ~= 0 then
				var_1_0:UpdateAttack()
				var_1_0:UpdateAttackChange(iter_1_1.attrData.atk)
			end

			if iter_1_1.attrData.exp ~= 0 then
				var_1_0:UpdateLevel()
			end
		else
			print("添加属性表现节点，目标" .. iter_1_1.chessUid .. "不存在")
		end
	end

	self:Finish()
end

return AutoChessAddAttrRenderer
