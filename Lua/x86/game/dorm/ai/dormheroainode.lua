local var_0_0 = {}

DormHeroAINode = class("DormHeroAINode")

function DormHeroAINode.Get(arg_1_0, arg_1_1, ...)
	local var_1_0 = var_0_0[arg_1_0]
	local var_1_1

	if var_1_0 and #var_1_0 > 0 then
		var_1_1 = table.remove(var_1_0)

		arg_1_0.Ctor(var_1_1, arg_1_1, ...)
	else
		var_1_1 = arg_1_0.New(arg_1_1, ...)
	end

	return var_1_1
end

function DormHeroAINode.Recycle(arg_2_0)
	arg_2_0:Reset()

	local var_2_0 = var_0_0[arg_2_0.class] or {}

	table.insert(var_2_0, arg_2_0)

	var_0_0[arg_2_0.class] = var_2_0
end

function DormHeroAINode.Process(arg_3_0, arg_3_1, ...)
	local var_3_0 = nullable(arg_3_0.events, arg_3_1)

	if var_3_0 then
		var_3_0(arg_3_0, ...)
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

function MoveNode.Start(arg_10_0)
	local var_10_0

	if arg_10_0.targetID then
		local var_10_1 = Dorm.DormEntityManager.QueryPosition(arg_10_0.targetID)

		var_10_0 = Dorm.DormEntityManager.SendMoveCMD(arg_10_0.entityID, var_10_1, true, false)
	elseif arg_10_0.targetPos then
		var_10_0 = Dorm.DormEntityManager.SendMoveCMD(arg_10_0.entityID, arg_10_0.targetPos, true, false)
	else
		var_10_0 = Dorm.DormEntityManager.SendRndWanderMoveCMD(arg_10_0.entityID, 1.5, false)
	end

	if not var_10_0 then
		var_0_1(arg_10_0)
	end
end

function MoveNode.OnMoveInterrupt(arg_11_0, arg_11_1, ...)
	if Dorm.DormEntityManager.QueryProvideInteraction(arg_11_1, arg_11_0.entityID) then
		Dorm.DormEntityManager.StopAllCmd(arg_11_0.entityID)

		local var_11_0, var_11_1, var_11_2 = ...

		DormHeroAI:MoveNext(arg_11_0.entityID, InteractNode, arg_11_1, var_11_2, {
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

function InteractNode.Ctor(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	arg_13_0.class.super.Ctor(arg_13_0, arg_13_1)

	arg_13_0.targetEID = arg_13_2
	arg_13_0.actionID = arg_13_3
	arg_13_0.extraData = arg_13_4
end

local var_0_2 = DormCharacterInteractBehaviour.MakeDefaultCtx

function InteractNode.Start(arg_14_0)
	local var_14_0 = nullable(arg_14_0.extraData, "interactPos")
	local var_14_1 = nullable(arg_14_0.extraData, "exitPos")
	local var_14_2 = nullable(arg_14_0.extraData, "immediate")
	local var_14_3 = nullable(arg_14_0.extraData, "continuous")

	if Dorm.DormEntityManager.IsValidEntityID(arg_14_0.targetEID) then
		local var_14_4 = DormCharacterInteractBehaviour.ValidateAction(arg_14_0.entityID, arg_14_0.targetEID, arg_14_0.actionID)

		if var_14_4 then
			local var_14_5 = var_0_2(arg_14_0.entityID, arg_14_0.targetEID, arg_14_0.actionID, var_14_4, arg_14_0.extraData)

			DormUtils.SetEntityInteractContext(arg_14_0.entityID, var_14_5)
			Dorm.DormEntityManager.StopAllCmd(arg_14_0.entityID)
			Dorm.DormEntityManager.KeepAsInteractNotEnd(arg_14_0.entityID, arg_14_0.targetEID, true)

			local var_14_6 = false

			if var_14_0 then
				var_14_6 = Dorm.DormEntityManager.SendMoveLookToDirCMD(arg_14_0.entityID, var_14_0, true, false)
			end

			if var_14_2 or not var_14_6 then
				Dorm.DormEntityManager.TryExecuteInteractToEntityImmediate(arg_14_0.entityID, arg_14_0.targetEID, arg_14_0.actionID)
			else
				arg_14_0.SendInteract(arg_14_0.entityID, arg_14_0.targetEID, arg_14_0.actionID, true)
			end

			if var_14_1 and var_14_5.nextAction == nil then
				Dorm.DormEntityManager.SendMoveLookToDirCMD(arg_14_0.entityID, var_14_1, true, true)
				Dorm.DormEntityManager.SendRndResumeWanderCMD(arg_14_0.entityID, 1, true)
			end

			return
		elseif var_14_3 and var_14_1 then
			Dorm.DormEntityManager.StopAllCmd(arg_14_0.entityID)
			DormHeroAI.ConsumeInteractCtx(arg_14_0.entityID)
			Dorm.DormEntityManager.KeepAsInteractNotEnd(arg_14_0.entityID, arg_14_0.targetEID, false)
			Dorm.DormEntityManager.SendMoveLookToDirCMD(arg_14_0.entityID, var_14_1, true, true)
			Dorm.DormEntityManager.SendRndResumeWanderCMD(arg_14_0.entityID, 1, true)

			return
		end
	end

	DormHeroAI.ConsumeInteractCtx(arg_14_0.entityID)

	local var_14_7 = Dorm.DormEntityManager.QueryRadius(arg_14_0.entityID)
	local var_14_8 = DormLuaBridge.FindSpawnPosNearBy(arg_14_0.entityID) or DormLuaBridge.FindSpawnPos(var_14_7, 5, true)

	if var_14_8 then
		Dorm.DormEntityManager.PutEntityAt(arg_14_0.entityID, var_14_8)
	end

	var_0_1(arg_14_0)
end

InteractNode.events = {
	[ON_DORM_CHARACTER_WAIT_CMD] = var_0_1
}
IdleNode = class("IdleNode", DormHeroAINode)
IdleNode.state = DormEnum.CharacterAIState.None
IdleNode.idleTimeLimit = 15

function IdleNode.Ctor(arg_15_0, ...)
	arg_15_0.class.super.Ctor(arg_15_0, ...)

	arg_15_0.nextActionCtx = DormHeroAI.ConsumeInteractCtx(arg_15_0.entityID)
	arg_15_0.idleStartTime = Time.time
	arg_15_0.idleAnimePlay = 0

	local var_15_0 = nullable(arg_15_0.nextActionCtx, "nextAction")
	local var_15_1 = nullable(arg_15_0.nextActionCtx, "nextActionWaitTime")
	local var_15_2

	if var_15_0 then
		arg_15_0.waitIdleAnimePlayTimes = 0
		arg_15_0.duringIdleAnimePlaying = false
		var_15_2 = var_15_1 or IdleNode.idleTimeLimit * math.random()
	else
		arg_15_0.waitIdleAnimePlayTimes = DormHeroAI:GetParam(arg_15_0.entityID, "waitIdleAnimePlayCnt") or math.random() > 0.5 and 1 or 0
		var_15_2 = DormHeroAI:GetParam(arg_15_0.entityID, "waitTime") or math.random(IdleNode.idleTimeLimit)
		arg_15_0.duringIdleAnimePlaying = false
	end

	arg_15_0.idleEndTime = arg_15_0.idleStartTime + var_15_2
end

function IdleNode.Start(arg_16_0)
	if arg_16_0.idleStartTime == arg_16_0.idleEndTime then
		arg_16_0:Update(arg_16_0.idleStartTime)
	end
end

function IdleNode.Update(arg_17_0, arg_17_1)
	if DormHeroAI:HasControl(arg_17_0.entityID) then
		arg_17_1 = arg_17_1 or Time.time

		local var_17_0 = nullable(arg_17_0.nextActionCtx, "nextAction")

		if not (var_17_0 == nil and arg_17_0.duringIdleAnimePlaying) and arg_17_1 >= arg_17_0.idleEndTime and arg_17_0.idleAnimePlay >= arg_17_0.waitIdleAnimePlayTimes then
			if var_17_0 then
				DormHeroAI:MoveNext(arg_17_0.entityID, InteractNode, arg_17_0.nextActionCtx.targetID, var_17_0, {
					continuous = true,
					exitPos = arg_17_0.nextActionCtx.exitPos
				})
			else
				DormHeroAI:MoveNext(arg_17_0.entityID, MoveNode)
			end
		end
	end
end

function IdleNode.OnAnime(arg_18_0, arg_18_1, arg_18_2)
	if Dorm.DormEntityManager.IsIdleAnime(arg_18_0.entityID, arg_18_2) then
		if arg_18_1 == "start" then
			arg_18_0.idleAnimePlay = arg_18_0.idleAnimePlay + 1
			arg_18_0.duringIdleAnimePlaying = true
		elseif arg_18_1 == "end" or arg_18_1 == "end_played_once" then
			arg_18_0.duringIdleAnimePlaying = false
		end
	end
end

function IdleNode.ClaimControl(arg_19_0)
	DormHeroAI:SwitchControl(arg_19_0.entityID, DormEnum.ControlType.AI)
end

function IdleNode.ReleaseControl(arg_20_0)
	if not DormHeroTools:CheckIsVisitHero(arg_20_0.entityID) then
		DormHeroAI:SwitchControl(arg_20_0.entityID, DormEnum.ControlType.Player)
		DormHeroAI.ConsumeInteractCtx(arg_20_0.entityID)
		DormHeroAI:MoveNext(arg_20_0.entityID, IdleNode)
	end
end

function IdleNode.OnGrabStarted(arg_21_0)
	arg_21_0:ReleaseControl()
end

function IdleNode.OnGrabRelease(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	arg_22_0:ClaimControl()

	if arg_22_1 then
		if arg_22_2 then
			Dorm.DormEntityManager.PutEntityAt(arg_22_0.entityID, arg_22_2)
		end

		DormHeroAI:MoveNext(arg_22_0.entityID, InteractNode, arg_22_1, arg_22_4, {
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
