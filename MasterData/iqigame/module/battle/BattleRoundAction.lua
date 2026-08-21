-- chunkname: @IQIGame\\Module\\Battle\\BattleRoundAction.lua

local BattleTurnAction = require("IQIGame.Module.Battle.BattleTurnAction")
local BattleRoundAction = {
	isComplete = false,
	hasSubmitAction = false
}

function BattleRoundAction.New(roundCommand)
	local obj = Clone(BattleRoundAction)

	obj:__Init(roundCommand)

	return obj
end

function BattleRoundAction:__Init(roundCommand)
	self.roundCommand = roundCommand
	self.turnCommandQueue = Queue.New()
	self.turnChooseSkillQueue = Queue.New()
	self.isComplete = false
end

function BattleRoundAction:OnAddTurnChooseSkill(battleChooseSkillCommand)
	self.turnChooseSkillQueue:Enqueue(battleChooseSkillCommand)
end

function BattleRoundAction:OnAddRoundTurn(turnCommand)
	self.turnCommandQueue:Enqueue(BattleTurnAction.New(turnCommand))
end

function BattleRoundAction:SetRoundEndCommand(command)
	self.roundEndCommand = command
end

function BattleRoundAction:StartRound(callback)
	BattleModule.Log("战斗回合{0}开始", self.roundCommand.Round)
	EventDispatcher.Dispatch(EventID.BattleUpdateRound, self.roundCommand.Round)
	BattleModule.UpdateBattleUnitsData(BattleConstant.BattleUpdatePoint.RoundStart, self.roundCommand.UpdateUnits, nil, function()
		BattleModule.WaitAllBattleUnitReady(function()
			BattleModule.CheckDialog(function()
				BattleModule.ShowAllSummons(function()
					callback()
				end)
			end)
		end)
	end)
end

function BattleRoundAction:PeekChooseSkillCommand()
	if self.turnChooseSkillQueue.Size == 0 then
		return nil
	end

	return self.turnChooseSkillQueue:Peek()
end

function BattleRoundAction:PerformingChooseSkillCommand(callback)
	local chooseSkillCommand = self.turnChooseSkillQueue:Dequeue()

	BattleModule.UpdateBattleUnitsData(BattleConstant.BattleUpdatePoint.ChooseSkillCommand, chooseSkillCommand.UpdateUnits, nil, function()
		BattleTeamActionModule.isAttackTeamTurn = chooseSkillCommand.TroopType == BattleModule.attackBattleTroopType

		local animName = BattleTeamActionModule.isAttackTeamTurn and "FriendlyTurn" or "EnemyTurn"
		local soundID = BattleTeamActionModule.isAttackTeamTurn and BattleApi:BattleAttackTurnStartSoundID() or BattleApi:BattleDefineTurnStartSoundID()

		LuaUtility.PlaySoundWithID(soundID)
		BattleModule.AddWaitUIAnimCallback(animName, function()
			EventDispatcher.Dispatch(EventID.BattleTroopTurnBeginEvent, chooseSkillCommand.TroopType)

			if callback ~= nil then
				callback()
			end
		end)
	end)
end

function BattleRoundAction:PeekTurnAction()
	if self.turnCommandQueue.Size == 0 then
		return nil
	end

	return self.turnCommandQueue:Peek()
end

function BattleRoundAction:PerformingTurnAction(callback)
	self.turnAction = self.turnCommandQueue:Dequeue()

	self.turnAction:Start(function()
		self:__OnTurnActionComplete()

		if callback ~= nil then
			callback()
		end
	end)
end

function BattleRoundAction:__OnTurnActionComplete()
	self.turnAction:Dispose()

	self.turnAction = nil
end

function BattleRoundAction:GetChooseSkillCommand()
	if self.turnChooseSkillQueue.Size == 0 then
		return nil
	end

	return self.turnChooseSkillQueue:Dequeue()
end

function BattleRoundAction:GetTurnCommand()
	if self.turnCommandQueue.Size == 0 then
		return nil
	end

	return self.turnCommandQueue:Dequeue()
end

function BattleRoundAction:GetTurnQueueSize()
	return self.turnCommandQueue.Size
end

function BattleRoundAction:OnPerform(checkAction, callback)
	if self.turnAction == nil then
		if self.turnCommandQueue.Size == 0 then
			callback()

			return
		end

		if self.turnChooseSkillQueue.Size > 0 then
			local moverID = self.turnCommandQueue:Peek().moverID
			local result = checkAction(moverID)

			if not result then
				return
			end
		end

		self.turnAction = self.turnCommandQueue:Dequeue()
	end

	if not self.turnAction.isStart then
		EventDispatcher.Dispatch(EventID.BattleUnitTurnBeginEvent, self.turnAction.moverID)
		self.turnAction:Start()
	end

	self.turnAction:OnTurnUpdate()

	if self.turnAction.isComplete then
		self:__OnTurnActionComplete()
	end
end

function BattleRoundAction:HasRoundEndCommand()
	return self.roundEndCommand ~= nil
end

function BattleRoundAction:OnRoundEnd()
	BattleModule.Log("战斗回合{0}结束", self.roundCommand.Round)
	BattleModule.UpdateBattleUnitsData(BattleConstant.BattleUpdatePoint.RoundEnd, self.roundEndCommand.UpdateUnits, nil, function()
		BattleModule.CheckDialog(function()
			BattleModule.WaitAllBattleUnitReady(function()
				BattleModule.ShowAllSummons(function()
					self:__OnRoundComplete()
				end)
			end)
		end)
	end)
end

function BattleRoundAction:__OnRoundComplete()
	self.isComplete = true
end

function BattleRoundAction:Dispose()
	if self.turnAction ~= nil then
		self.turnAction:Dispose()
	end

	self.turnChooseSkillQueue:Clear()

	self.turnChooseSkillQueue = nil

	for i = 1, self.turnCommandQueue.Size do
		local turnAction = self.turnCommandQueue:Dequeue()

		turnAction:Dispose()
	end

	self.turnCommandQueue = nil
end

return BattleRoundAction
