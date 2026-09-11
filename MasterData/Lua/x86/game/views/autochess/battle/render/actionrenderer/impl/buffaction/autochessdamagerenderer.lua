local AutoChessDamageRenderer = class("AutoChessDamageRenderer", (import("game.views.autoChess.battle.render.actionRenderer.Impl.buffAction.AutoChessEffectBaseRenderer")))

function AutoChessDamageRenderer:OnPlay()
	local var_1_0, var_1_1 = AutoChessData:GetBuffTargetInfo(self.actionData.buffUid)

	if var_1_0 == AutoChessConst.BUFF_TARGET_TYPE.CHESS then
		local var_1_2 = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(var_1_1)

		self.invokeChessItemType = AutoChessData:GetPlayerTypeByChessUid(var_1_1)

		if var_1_2 and var_1_2.chessItemData_.attributeData.hp > 0 then
			self.invokerChessItemIndex = var_1_2.chessItemData_.index
			self.startGo = var_1_2.gameObject_
		else
			local var_1_3 = AutoChessData:GetChessData(var_1_1)

			if var_1_3 then
				self.invokerChessItemIndex = var_1_3.index
				self.startGo = AutoChessBattleRenderer.GetInstance():GetFormationItemByIndex(self.invokeChessItemType, self.invokerChessItemIndex).gameObject_
			end
		end
	end

	self.playedCount = 0
	self.moveEndCount = 0
	self.finishCount = 0
	self.hpChangeEndNum = 0
	self.totalNum = #self.actionData.targetHpChangeData
	self.isPlayingEffectItem = false
	self.effectItemList = {}
	self.movetionEndHandler = handler(self, self.OnMotionEnd)
	self.nextEffecHandler = handler(self, self.OnNextEffect)
	self.speed = getData("AutoChess", "battleSpeed") == 1 and 2 or 1
	self.prop = GameSetting.auto_chess_fixed_percentage.value[1] / 100

	self:PlayBuffInvokeAnim()
end

function AutoChessDamageRenderer:Update(arg_2_1)
	if not self.isPlayingEffectItem and self.playedCount < self.totalNum then
		self.playedCount = self.playedCount + 1

		if not self.invokerChessItemIndex or not self.startGo then
			self:OnHitAnimEnd()

			return
		end

		self.isPlayingEffectItem = true

		local var_2_0 = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(self.actionData.targetHpChangeData[self.playedCount].chessUid)
		local var_2_1 = var_2_0 and var_2_0.gameObject_
		local var_2_2 = true

		var_2_2 = var_2_0 and self.invokeChessItemType == AutoChessData:GetPlayerTypeByChessUid(self.actionData.targetHpChangeData[self.playedCount].chessUid) and (self.invokeChessItemType == AutoChessConst.PLAYER_TYPE.SELF and self.invokerChessItemIndex > var_2_0.chessItemData_.index or self.invokerChessItemIndex < var_2_0.chessItemData_.index) or self.invokeChessItemType == AutoChessConst.PLAYER_TYPE.SELF

		local var_2_3 = AutoChessBattleRenderer.GetInstance():GetBuffDamageEffectItem()

		if var_2_3 and self.startGo and var_2_1 then
			var_2_3:SetIsFree(false)
			var_2_3:SetDir(var_2_2)
			var_2_3.motionCom_:StartMotion(self.startGo, var_2_1, self.speed, self.prop, self.nextEffecHandler, self.movetionEndHandler)

			self.effectItemList[self.playedCount] = var_2_3

			manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_lose", "")
		else
			self.nextEffecHandler()
			self.movetionEndHandler()
		end
	end

	if self.finishCount >= self.totalNum and self.hpChangeEndNum >= self.totalNum then
		self:Finish()
	end
end

function AutoChessDamageRenderer:OnNextEffect()
	self.isPlayingEffectItem = false
end

function AutoChessDamageRenderer:OnMotionEnd()
	self.moveEndCount = self.moveEndCount + 1

	if self.effectItemList[self.moveEndCount] then
		self.effectItemList[self.moveEndCount]:SetIsFree(true)

		self.effectItemList[self.moveEndCount] = nil
	end

	local var_4_0 = self.actionData.targetHpChangeData[self.moveEndCount]
	local var_4_1 = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(self.actionData.targetHpChangeData[self.moveEndCount].chessUid)

	if var_4_1 then
		var_4_1:UpdateHP(AutoChessData:GetChessData(self.actionData.targetHpChangeData[self.moveEndCount].chessUid).attributeData.hp)
		var_4_1:UpdateBigHp(var_4_0.hpChange)

		local var_4_2 = AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.ANIMATOR)

		var_4_2:RegistFinishCallback(handler(self, self.OnHpChangeEnd))
		var_4_2:PlayAnim(var_4_1:GetBigHpAnim(), "U_BigHP_cx")

		local var_4_3 = AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.ANIMATOR)

		var_4_3:PlayAnim(var_4_1:GetAnimator(), "ChessItem_hit")
		var_4_3:RegistFinishCallback(handler(self, self.OnHitAnimEnd))
		AutoChessBattleRenderer.GetInstance():GetBattleView():PlayShakeAnim(math.abs(var_4_0.hpChange), 0)
	else
		Debug.LogError("AutoChessDamageRenderer OnMotionEnd 找不到棋子，uid=" .. tostring(self.actionData.targetHpChangeData[self.moveEndCount].chessUid))
		self:OnHitAnimEnd()
	end
end

function AutoChessDamageRenderer:OnHitAnimEnd()
	self.finishCount = self.finishCount + 1
end

function AutoChessDamageRenderer:OnHpChangeEnd()
	self.hpChangeEndNum = self.hpChangeEndNum + 1
end

function AutoChessDamageRenderer:OnReset()
	if self.effectItemList then
		for iter_7_0, iter_7_1 in pairs(self.effectItemList) do
			iter_7_1:SetIsFree(true)
		end

		self.effectItemList = {}
	end
end

function AutoChessDamageRenderer:SetSpeed(arg_8_1)
	self.speed = arg_8_1

	for iter_8_0, iter_8_1 in pairs(self.effectItemList) do
		iter_8_1.motionCom_:SetSpeedMultiplier(self.speed)
	end
end

function AutoChessDamageRenderer:OnBuffInvokeAnimEnd()
	return
end

return AutoChessDamageRenderer
