import(".DormHeroAINode")

local var_0_0 = singletonClass("DormHeroAI")
local var_0_1 = {
	interactState = "interactState",
	moveState = "moveState",
	StartState = "StartState"
}

function var_0_0.Ctor(arg_1_0)
	arg_1_0.characterList = {}
	arg_1_0.listener = EventListener.New()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:RegisterEvent()
end

function var_0_0.AddCharacterAI(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0.characterList[arg_3_1] then
		print(arg_3_1 .. "对象已激活ai")

		return
	end

	local var_3_0 = {
		controlType = DormEnum.ControlType.AI,
		params = arg_3_2 or {}
	}

	arg_3_0.characterList[arg_3_1] = var_3_0
	var_3_0.curNode = DormHeroAINode.Get(IdleNode, arg_3_1)

	var_3_0.curNode:Start()
end

function var_0_0.RemoveCharacterAI(arg_4_0, arg_4_1)
	local var_4_0 = nullable(arg_4_0.characterList[arg_4_1], "curNode")

	if var_4_0 then
		var_4_0:Exit()
		DormHeroAINode.Recycle(var_4_0)

		arg_4_0.characterList[arg_4_1] = nil
	end
end

function var_0_0.Clear(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.characterList) do
		local var_5_0 = iter_5_1.curNode

		var_5_0:Exit()
		DormHeroAINode.Recycle(var_5_0)
	end

	arg_5_0.characterList = {}
end

function var_0_0.RegisterEvent(arg_6_0)
	local var_6_0 = {
		[DORM_DORMITORY_NEW_HERO] = handler(arg_6_0, arg_6_0.AddCharacterAI),
		[DORM_LOGIC_TICK] = handlerArg1(arg_6_0, arg_6_0.ProcessUpdate),
		[ON_DORM_CHARACTER_CMD_ABORTED] = handler(arg_6_0, arg_6_0.OnCmdAbort)
	}

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		arg_6_0.listener:Register(iter_6_0, iter_6_1)
	end

	local var_6_1 = {
		ON_DORM_CHARACTER_MOVE_FINISH,
		ON_DORM_CHARACTER_INTERACT_FINISH,
		ON_DORM_CHARACTER_WAIT_CMD,
		ON_DORM_ENTITY_ANIME_EVENT,
		ON_DORM_CHARACTER_MOVE_PICK_INTERACT_AREA,
		ON_DORM_CHARACTER_GRAB_STARTED,
		ON_DORM_CHARACTER_GRAB_RELEASED,
		ON_PLAYER_CLICK_INTERACT,
		DORM_RESET_HERO_AI
	}

	for iter_6_2, iter_6_3 in ipairs(var_6_1) do
		arg_6_0.listener:Register(iter_6_3, handlerArg1(arg_6_0, arg_6_0.ProcessEvent, iter_6_3))
	end
end

function var_0_0.ProcessUpdate(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.characterList) do
		arg_7_0:ProcessEvent(DORM_LOGIC_TICK, iter_7_0)
	end
end

function var_0_0.ProcessEvent(arg_8_0, arg_8_1, arg_8_2, ...)
	local var_8_0 = arg_8_0.characterList[arg_8_2]

	if var_8_0 then
		DormHeroAINode.Process(var_8_0.curNode, arg_8_1, ...)
	end
end

function var_0_0.OnCmdAbort(arg_9_0, arg_9_1)
	if arg_9_0.characterList[arg_9_1] then
		arg_9_0.ConsumeInteractCtx(arg_9_1)
		arg_9_0:MoveNext(arg_9_1, IdleNode)
	end
end

function var_0_0.MoveNext(arg_10_0, arg_10_1, arg_10_2, ...)
	local var_10_0 = arg_10_0.characterList[arg_10_1]

	var_10_0.curNode:Exit()
	DormHeroAINode.Recycle(var_10_0.curNode)

	var_10_0.curNode = DormHeroAINode.Get(arg_10_2 or IdleNode, arg_10_1, ...)

	var_10_0.curNode:Start()
end

function var_0_0.HasControl(arg_11_0, arg_11_1)
	return arg_11_0.characterList[arg_11_1].controlType == DormEnum.ControlType.AI
end

function var_0_0.SwitchControl(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.characterList[arg_12_1].controlType = arg_12_2

	if arg_12_2 == DormEnum.ControlType.Player then
		-- block empty
	elseif arg_12_2 == DormEnum.ControlType.AI then
		-- block empty
	end
end

function var_0_0.Dispose(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.characterList) do
		DormHeroAINode.Recycle(iter_13_1.curNode)
	end

	arg_13_0.characterList = {}

	arg_13_0.listener:RemoveAll()
end

function var_0_0.GetEntityData(arg_14_0)
	return Dorm.storage:GetData(DormEnum.Namespace.EntityData, arg_14_0)
end

function var_0_0.ConsumeInteractCtx(arg_15_0)
	local var_15_0 = var_0_0.GetEntityData(arg_15_0).interactCtx

	DormUtils.SetEntityInteractContext(arg_15_0, nil)

	return var_15_0
end

function var_0_0.SetParam(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_0.characterList[arg_16_1]

	if var_16_0 then
		var_16_0.params[arg_16_2] = arg_16_3
	end
end

function var_0_0.GetParam(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.characterList[arg_17_1]

	if var_17_0 then
		return var_17_0.params[arg_17_2]
	end
end

return var_0_0.GetInstance()
