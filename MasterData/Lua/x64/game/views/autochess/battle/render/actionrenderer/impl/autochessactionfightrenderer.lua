local AutoChessActionFightRenderer = class("AutoChessActionFightRenderer", (import("game.views.autoChess.battle.render.actionRenderer.AutoChessActionBaseRenderer")))

function AutoChessActionFightRenderer:OnPlay()
	self.fightOver = false
	self.hpChangeEndCount = 0

	for iter_1_0, iter_1_1 in ipairs(self.actionData.fightDataList) do
		local var_1_0 = AutoChessData:GetPlayerTypeByChessUid(iter_1_1.chessUniquiId)

		if var_1_0 == AutoChessConst.PLAYER_TYPE.SELF then
			self.selfChessFightData = iter_1_1
		elseif var_1_0 == AutoChessConst.PLAYER_TYPE.OPPONENT then
			self.opponentChessFightData = iter_1_1
		end
	end

	self.selfChessItem = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(self.selfChessFightData.chessUniquiId)
	self.opponentChessItem = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(self.opponentChessFightData.chessUniquiId)

	if self.selfChessItem and self.opponentChessItem then
		self:PlayFightTimeline()
		self:UpdateChessItemHp()
	end
end

function AutoChessActionFightRenderer:Update(arg_2_1)
	if self.delayHpChangeTime > 0 then
		self.delayHpChangeTime = self.delayHpChangeTime - arg_2_1

		if self.delayHpChangeTime <= 0 then
			self:PlayChessItemHpChange()
		end
	end

	if self.fightOver and self.hpChangeEndCount >= 2 then
		self:Finish()
	end
end

function AutoChessActionFightRenderer:OnControllerFinish()
	self.fightOver = true
end

function AutoChessActionFightRenderer:PlayFightTimeline()
	manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_collide", "")

	local var_4_0 = AutoChessBattleRenderer.GetInstance():GetBattleView()

	var_4_0:PlayShakeAnim(math.max(math.abs(self.selfChessFightData.hpChange), math.abs(self.opponentChessFightData.hpChange)), 0.2)
	var_4_0.fightDirector_:SetGenericBinding(var_4_0.fightPlayable_:GetOutputTrack(0), self.selfChessItem:GetAnimator())
	var_4_0.fightDirector_:SetGenericBinding(var_4_0.fightPlayable_:GetOutputTrack(1), self.opponentChessItem:GetAnimator())

	local var_4_1 = AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.TIME_LINE)

	var_4_1:RegistFinishCallback(handler(self, self.OnControllerFinish))
	var_4_1:InitPlayable(var_4_0.fightDirector_, var_4_0.fightPlayable_)
	var_4_1:Play()
end

function AutoChessActionFightRenderer:UpdateChessItemHp()
	self.delayHpChangeTime = 0.4 / AutoChessBattleRenderer.GetInstance():GetSpeed()
end

function AutoChessActionFightRenderer:PlayChessItemHpChange()
	self.selfChessItem:UpdateHP(self.actionData.selfChessDataHp)
	self.opponentChessItem:UpdateHP(self.actionData.opponentChessDataHp)
	self.selfChessItem:UpdateBigHp(self.selfChessFightData.hpChange)
	self.opponentChessItem:UpdateBigHp(self.opponentChessFightData.hpChange)

	local var_6_0 = AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.ANIMATOR)
	local var_6_1 = AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.ANIMATOR)

	var_6_0:RegistFinishCallback(handler(self, self.OnHpChangeEnd))
	var_6_0:PlayAnim(self.selfChessItem:GetBigHpAnim(), "U_BigHP_cx")
	var_6_1:RegistFinishCallback(handler(self, self.OnHpChangeEnd))
	var_6_1:PlayAnim(self.opponentChessItem:GetBigHpAnim(), "U_BigHP_cx")
end

function AutoChessActionFightRenderer:OnHpChangeEnd()
	self.hpChangeEndCount = self.hpChangeEndCount + 1
end

function AutoChessActionFightRenderer:OnFinish()
	AutoChessBattleSimulator.GetInstance():GetBlackboard():SetIsFightOver()

	self.selfChessFightData = nil
	self.selfChessItem = nil
	self.opponentChessFightData = nil
	self.opponentChessItem = nil
end

return AutoChessActionFightRenderer
