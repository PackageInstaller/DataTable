local AtuoChessActionDeadRenderer = class("AtuoChessActionDeadRenderer", AutoChessActionBaseRenderer)

function AtuoChessActionDeadRenderer:OnPlay()
	self.finishCount = 0

	for iter_1_0, iter_1_1 in ipairs(self.actionData.deadChessList) do
		local var_1_0 = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(iter_1_1)

		if var_1_0 then
			local var_1_1 = var_1_0:GetAnimator()
			local var_1_2 = AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.ANIMATOR)

			var_1_2:RegistFinishCallback(handler(self, self.OnControllerFinish))
			var_1_2:PlayAnim(var_1_1, "ChessItemDeadAnim")
		else
			Debug.Log("AutoChessActionDeadRenderer:OnPlay chessItemView is nil, chessUniqueId: " .. iter_1_1)
			self:OnControllerFinish()
		end
	end
end

function AtuoChessActionDeadRenderer:OnControllerFinish()
	self.finishCount = self.finishCount + 1

	if not AutoChessBattleRenderer.GetInstance():CheckDeathWhisper(self.actionData.deadChessList[self.finishCount]) then
		AutoChessBattleRenderer.GetInstance():RemoveChessItemByUniqueId(self.actionData.deadChessList[self.finishCount])
	end

	if self.finishCount == #self.actionData.deadChessList then
		self:Finish()
	end
end

return AtuoChessActionDeadRenderer
