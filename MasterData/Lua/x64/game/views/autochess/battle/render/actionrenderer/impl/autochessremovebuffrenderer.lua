local AutoChessRemoveBuffRenderer = class("AutoChessRemoveBuffRenderer", (import("game.views.autoChess.battle.render.actionRenderer.AutoChessActionBaseRenderer")))

function AutoChessRemoveBuffRenderer:OnPlay()
	self:PlayRemoveBuffAnim()
	self:PlayChessAttrChangeAnim()
end

function AutoChessRemoveBuffRenderer:PlayRemoveBuffAnim()
	self.chessBuffData = AutoChessData:GetBuffData(self.actionData.buffUid)

	if self.chessBuffData then
		local var_2_0, var_2_1 = AutoChessData:GetBuffTargetInfo(self.actionData.buffUid)

		if var_2_0 == AutoChessConst.BUFF_TARGET_TYPE.CHESS and AutoChessBuffCfg[self.chessBuffData.buffId].keyword_type ~= AutoChessConst.BUFF_KEYWORD_TYPE.NONE then
			self.chessItemView = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(var_2_1)

			if self.chessItemView ~= nil and self.chessItemView:GetBuffKeywordConfig(AutoChessBuffCfg[self.chessBuffData.buffId].keyword_type) ~= nil then
				local var_2_2 = self.chessItemView:GetBuffKeywordConfig(AutoChessBuffCfg[self.chessBuffData.buffId].keyword_type)
				local var_2_3 = AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.ANIMATOR)

				var_2_3:RegistFinishCallback(handler(self, self.OnKeywordAnimEnd))
				var_2_3:PlayAnim(var_2_2.animator, var_2_2.disappearAnimName)

				if AutoChessBuffCfg[self.chessBuffData.buffId].keyword_type == AutoChessConst.BUFF_KEYWORD_TYPE.VENOMOUS then
					manager.audio:PlayEffect("minigame_activity_4_8", "minigame_activity_4_8_duel_effect", "")
				end
			else
				self:OnKeywordAnimEnd()
			end
		else
			self:OnKeywordAnimEnd()
		end
	else
		self:Finish()
	end
end

function AutoChessRemoveBuffRenderer:OnKeywordAnimEnd()
	if self.chessItemView then
		self.chessItemView:RemoveBuff(self.chessBuffData)
	end

	self.chessItemView = nil
	self.chessBuffData = nil

	self:Finish()
end

function AutoChessRemoveBuffRenderer:PlayChessAttrChangeAnim()
	for iter_4_0, iter_4_1 in ipairs(self.actionData.chessAttrChangeDataList) do
		local var_4_0 = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(iter_4_1.chessUid)

		if var_4_0 then
			if iter_4_1.attrData.hp ~= 0 then
				var_4_0:UpdateHP()
			end

			if iter_4_1.attrData.atk ~= 0 then
				var_4_0:UpdateAttack()
			end
		end
	end
end

function AutoChessRemoveBuffRenderer:OnReset()
	self.chessItemView = nil
	self.chessBuffData = nil
end

return AutoChessRemoveBuffRenderer
