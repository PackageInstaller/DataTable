local AutoChessActionMoveRenderer = class("AutoChessActionMoveRenderer", (import("game.views.autoChess.battle.render.actionRenderer.AutoChessActionBaseRenderer")))

function AutoChessActionMoveRenderer:OnPlay()
	self.tweenDataList = {}

	local var_1_0 = AutoChessBattleRenderer.GetInstance()
	local var_1_1 = var_1_0:GetBattleView()
	local var_1_2 = var_1_0

	for iter_1_0, iter_1_1 in ipairs(self.actionData.moveDataList) do
		var_1_2 = math.max(var_1_2, iter_1_1.newPos)

		local var_1_3 = AutoChessData:GetPlayerTypeByChessUid(iter_1_1.chessUniquiId)
		local var_1_4 = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(iter_1_1.chessUniquiId)

		if var_1_4 then
			table.insert(self.tweenDataList, {
				chessItemView = var_1_4,
				originalPos = var_1_4:GetLocalPos(),
				targetPos = var_1_1:GetChessPosByPlayerType(var_1_3, iter_1_1.newPos)
			})
		else
			Debug.Log("AutoChessActionMoveRenderer:OnPlay() chessItemView is nil, id = " .. iter_1_1.chessUniquiId)
			self:OnControllerFinish()
		end
	end

	local var_1_5 = AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.LEAN_TWEEN)

	var_1_5:RegistFinishCallback(handler(self, self.OnControllerFinish))
	var_1_5:Value(0, 1, 0.5, LeanTweenType.easeOutCubic)
	var_1_5:RegistTweenUpdateCallback(handler(self, self.OnTweenUpdate))
	var_1_5:Play()

	if var_1_1:GetChessFormationCount() < var_1_2 then
		var_1_1:PlayChangeBgAnim(var_1_2)
	end
end

function AutoChessActionMoveRenderer:OnTweenUpdate(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(self.tweenDataList) do
		iter_2_1.chessItemView:SetLocalPos((Vector3.Lerp(iter_2_1.originalPos, iter_2_1.targetPos, arg_2_1)))
	end
end

function AutoChessActionMoveRenderer:OnControllerFinish()
	for iter_3_0, iter_3_1 in ipairs(self.tweenDataList or {}) do
		iter_3_1.chessItemView:SetLocalPos(iter_3_1.targetPos)
	end

	self:Finish()
end

return AutoChessActionMoveRenderer
