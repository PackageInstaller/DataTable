local var_0_0 = {}

DormHeroAINode = class("DormHeroAINode")

function DormHeroAINode:Get(arg_1_1, ...)
	local var_1_0

	if var_0_0[self] and #var_0_0[self] > 0 then
		var_1_0 = table.remove(var_0_0[self])

		self.Ctor(var_1_0, arg_1_1, ...)
	else
		var_1_0 = self.New(arg_1_1, ...)
	end

	return var_1_0
end

function DormHeroAINode:Recycle()
	self:Reset()

	local var_2_0 = var_0_0[self.class] or {}

	table.insert(var_2_0, self)

	var_0_0[self.class] = var_2_0
end

function DormHeroAINode:Process(arg_3_1, ...)
	local var_3_0 = nullable(self.events, arg_3_1)

	if var_3_0 then
		var_3_0(self, ...)
	end
end

function DormHeroAINode.Finish(arg_4_0)
	return function(arg_5_0)
		DormHeroAI:MoveNext(arg_5_0.entityID, arg_4_0 or IdleNode)
	end
end

local var_0_1 = DormHeroAINode.Finish()

function DormHeroAINode.Ctor(arg_6_0, arg_6_1, ...)
	arg_6_0.entityID = arg_6_1
end

function DormHeroAINode.Reset(arg_7_0)
	return
end

function DormHeroAINode.Start(arg_8_0)
	return
end

function DormHeroAINode.Exit(arg_9_0)
	return
end

MoveNode = class("MoveNode", DormHeroAINode)
MoveNode.state = DormEnum.CharacterAIState.Move

function MoveNode:Start()
	if not (self.targetID and Dorm.DormEntityManager.SendMoveCMD(self.entityID, Dorm.DormEntityManager.QueryPosition(self.targetID), true, false) or self.targetPos and Dorm.DormEntityManager.SendMoveCMD(self.entityID, self.targetPos, true, false) or Dorm.DormEntityManager.SendRndWanderMoveCMD(self.entityID, 1.5, false)) then
		var_0_1(self)
	end
end

function MoveNode:OnMoveInterrupt(arg_11_1, ...)
	if Dorm.DormEntityManager.QueryProvideInteraction(arg_11_1, self.entityID) then
		Dorm.DormEntityManager.StopAllCmd(self.entityID)

		local var_11_0, var_11_1, var_11_2 = ...

		DormHeroAI:MoveNext(self.entityID, InteractNode, arg_11_1, var_11_2, {
			interactPos = var_11_0,
			exitPos = var_11_1
		})
	end
end

MoveNode.events = {
	[ON_DORM_CHARACTER_WAIT_CMD] = var_0_1,
	[ON_DORM_CHARACTER_MOVE_FINISH] = var_0_1,
	[ON_DORM_CHARACTER_MOVE_PICK_INTERACT_AREA] = MoveNode.OnMoveInterrupt
}
InteractNode = class("InteractNode", DormHeroAINode)
InteractNode.state = DormEnum.CharacterAIState.Interact

function InteractNode.SendInteract(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_2 then
		Dorm.DormEntityManager.SendInteractToEntityCMD(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	else
		Dorm.DormEntityManager.SendInteractToEntityCMD(arg_12_0, arg_12_1, arg_12_3)
	end
end

function InteractNode:Ctor(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	self.class.super.Ctor(self, arg_13_1)

	self.targetEID = arg_13_2
	self.actionID = arg_13_3
	self.extraData = arg_13_4
end

local var_0_2 = DormCharacterInteractBehaviour.MakeDefaultCtx

function InteractNode:Start()
	local var_14_0 = nullable(self.extraData, "interactPos")
	local var_14_1 = nullable(self.extraData, "exitPos")

	if Dorm.DormEntityManager.IsValidEntityID(self.targetEID) then
		local var_14_2 = DormCharacterInteractBehaviour.ValidateAction(self.entityID, self.targetEID, self.actionID)

		if var_14_2 then
			local var_14_3 = var_0_2(self.entityID, self.targetEID, self.actionID, var_14_2, self.extraData)

			DormUtils.SetEntityInteractContext(self.entityID, var_14_3)
			Dorm.DormEntityManager.StopAllCmd(self.entityID)
			Dorm.DormEntityManager.KeepAsInteractNotEnd(self.entityID, self.targetEID, true)

			if nullable(self.extraData, "immediate") or not ((var_14_0 or nil) and Dorm.DormEntityManager.SendMoveLookToDirCMD(self.entityID, var_14_0, true, false)) then
				Dorm.DormEntityManager.TryExecuteInteractToEntityImmediate(self.entityID, self.targetEID, self.actionID)
			else
				self.SendInteract(self.entityID, self.targetEID, self.actionID, true)
			end

			if var_14_1 and var_14_3.nextAction == nil then
				Dorm.DormEntityManager.SendMoveLookToDirCMD(self.entityID, var_14_1, true, true)
				Dorm.DormEntityManager.SendRndResumeWanderCMD(self.entityID, 1, true)
			end

			return
		elseif nullable(self.extraData, "continuous") and var_14_1 then
			Dorm.DormEntityManager.StopAllCmd(self.entityID)
			DormHeroAI.ConsumeInteractCtx(self.entityID)
			Dorm.DormEntityManager.KeepAsInteractNotEnd(self.entityID, self.targetEID, false)
			Dorm.DormEntityManager.SendMoveLookToDirCMD(self.entityID, var_14_1, true, true)
			Dorm.DormEntityManager.SendRndResumeWanderCMD(self.entityID, 1, true)

			return
		end
	end

	DormHeroAI.ConsumeInteractCtx(self.entityID)

	local var_14_5 = DormLuaBridge.FindSpawnPosNearBy(self.entityID) or DormLuaBridge.FindSpawnPos(Dorm.DormEntityManager.QueryRadius(self.entityID), 5, true)

	if var_14_5 then
		Dorm.DormEntityManager.PutEntityAt(self.entityID, var_14_5)
	end

	var_0_1(self)
end

InteractNode.events = {
	[ON_DORM_CHARACTER_WAIT_CMD] = var_0_1
}
IdleNode = class("IdleNode", DormHeroAINode)
IdleNode.state = DormEnum.CharacterAIState.None
IdleNode.idleTimeLimit = 15

function IdleNode:Ctor(...)
	self.class.super.Ctor(self, ...)

	self.nextActionCtx = DormHeroAI.ConsumeInteractCtx(self.entityID)
	self.idleStartTime = Time.time
	self.idleAnimePlay = 0

	local var_15_0

	if nullable(self.nextActionCtx, "nextAction") then
		self.waitIdleAnimePlayTimes = 0
		self.duringIdleAnimePlaying = false
		var_15_0 = nullable(self.nextActionCtx, "nextActionWaitTime") or IdleNode.idleTimeLimit * math.random()
	else
		self.waitIdleAnimePlayTimes = DormHeroAI:GetParam(self.entityID, "waitIdleAnimePlayCnt") or math.random() > 0.5 and 1 or 0
		var_15_0 = DormHeroAI:GetParam(self.entityID, "waitTime") or math.random(IdleNode.idleTimeLimit)
		self.duringIdleAnimePlaying = false
	end

	self.idleEndTime = self.idleStartTime + var_15_0
end

function IdleNode:Start()
	if self.idleStartTime == self.idleEndTime then
		self:Update(self.idleStartTime)
	end
end

function IdleNode:Update(arg_17_1)
	if DormHeroAI:HasControl(self.entityID) then
		arg_17_1 = arg_17_1 or Time.time

		local var_17_0 = nullable(self.nextActionCtx, "nextAction")

		if not (var_17_0 == nil and self.duringIdleAnimePlaying) and arg_17_1 >= self.idleEndTime and self.idleAnimePlay >= self.waitIdleAnimePlayTimes then
			if var_17_0 then
				DormHeroAI:MoveNext(self.entityID, InteractNode, self.nextActionCtx.targetID, var_17_0, {
					continuous = true,
					exitPos = self.nextActionCtx.exitPos
				})
			else
				DormHeroAI:MoveNext(self.entityID, MoveNode)
			end
		end
	end
end

function IdleNode:OnAnime(arg_18_1, arg_18_2)
	if Dorm.DormEntityManager.IsIdleAnime(self.entityID, arg_18_2) then
		if arg_18_1 == "start" then
			self.idleAnimePlay = self.idleAnimePlay + 1
			self.duringIdleAnimePlaying = true
		elseif arg_18_1 == "end" or arg_18_1 == "end_played_once" then
			self.duringIdleAnimePlaying = false
		end
	end
end

function IdleNode:ClaimControl()
	DormHeroAI:SwitchControl(self.entityID, DormEnum.ControlType.AI)
end

function IdleNode:ReleaseControl()
	if not DormHeroTools:CheckIsVisitHero(self.entityID) then
		DormHeroAI:SwitchControl(self.entityID, DormEnum.ControlType.Player)
		DormHeroAI.ConsumeInteractCtx(self.entityID)
		DormHeroAI:MoveNext(self.entityID, IdleNode)
	end
end

function IdleNode:OnGrabStarted()
	self:ReleaseControl()
end

function IdleNode:OnGrabRelease(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	self:ClaimControl()

	if arg_22_1 then
		if arg_22_2 then
			Dorm.DormEntityManager.PutEntityAt(self.entityID, arg_22_2)
		end

		DormHeroAI:MoveNext(self.entityID, InteractNode, arg_22_1, arg_22_4, {
			exitPos = arg_22_3
		})
	end
end

IdleNode.events = {
	[DORM_LOGIC_TICK] = IdleNode.Update,
	[ON_DORM_ENTITY_ANIME_EVENT] = IdleNode.OnAnime,
	[ON_DORM_CHARACTER_GRAB_STARTED] = IdleNode.OnGrabStarted,
	[ON_DORM_CHARACTER_GRAB_RELEASED] = IdleNode.OnGrabRelease,
	[ON_PLAYER_CLICK_INTERACT] = IdleNode.ReleaseControl,
	[DORM_RESET_HERO_AI] = IdleNode.ClaimControl
}

function Dorm.TestAIMove(arg_23_0)
	return pcall(function()
		DormHeroAI:MoveNext(arg_23_0, MoveNode)
	end)
end
