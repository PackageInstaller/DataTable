import(".DormHeroAINode")

local var_0_0 = singletonClass("DormHeroAI")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.characterList = {}
	arg_1_0.listener = EventListener.New()
end

function var_0_0:Init()
	self:RegisterEvent()
end

function var_0_0:AddCharacterAI(arg_3_1, arg_3_2)
	if self.characterList[arg_3_1] then
		print(arg_3_1 .. "对象已激活ai")

		return
	end

	local var_3_0 = {
		controlType = DormEnum.ControlType.AI,
		params = arg_3_2 or {}
	}

	self.characterList[arg_3_1] = var_3_0
	var_3_0.curNode = DormHeroAINode.Get(IdleNode, arg_3_1)

	var_3_0.curNode:Start()
end

function var_0_0:RemoveCharacterAI(arg_4_1)
	local var_4_0 = nullable(self.characterList[arg_4_1], "curNode")

	if var_4_0 then
		var_4_0:Exit()
		DormHeroAINode.Recycle(var_4_0)

		self.characterList[arg_4_1] = nil
	end
end

function var_0_0:Clear()
	for iter_5_0, iter_5_1 in pairs(self.characterList) do
		iter_5_1.curNode:Exit()
		DormHeroAINode.Recycle(iter_5_1.curNode)
	end

	self.characterList = {}
end

function var_0_0:RegisterEvent()
	for iter_6_0, iter_6_1 in pairs({
		[DORM_DORMITORY_NEW_HERO] = handler(self, self.AddCharacterAI),
		[DORM_LOGIC_TICK] = handlerArg1(self, self.ProcessUpdate),
		[ON_DORM_CHARACTER_CMD_ABORTED] = handler(self, self.OnCmdAbort)
	}) do
		self.listener:Register(iter_6_0, iter_6_1)
	end

	for iter_6_2, iter_6_3 in ipairs({
		ON_DORM_CHARACTER_MOVE_FINISH,
		ON_DORM_CHARACTER_INTERACT_FINISH,
		ON_DORM_CHARACTER_WAIT_CMD,
		ON_DORM_ENTITY_ANIME_EVENT,
		ON_DORM_CHARACTER_MOVE_PICK_INTERACT_AREA,
		ON_DORM_CHARACTER_GRAB_STARTED,
		ON_DORM_CHARACTER_GRAB_RELEASED,
		ON_PLAYER_CLICK_INTERACT,
		DORM_RESET_HERO_AI
	}) do
		self.listener:Register(iter_6_3, handlerArg1(self, self.ProcessEvent, iter_6_3))
	end
end

function var_0_0:ProcessUpdate()
	for iter_7_0, iter_7_1 in pairs(self.characterList) do
		self:ProcessEvent(DORM_LOGIC_TICK, iter_7_0)
	end
end

function var_0_0:ProcessEvent(arg_8_1, arg_8_2, ...)
	if self.characterList[arg_8_2] then
		DormHeroAINode.Process(self.characterList[arg_8_2].curNode, arg_8_1, ...)
	end
end

function var_0_0:OnCmdAbort(arg_9_1)
	if self.characterList[arg_9_1] then
		self.ConsumeInteractCtx(arg_9_1)
		self:MoveNext(arg_9_1, IdleNode)
	end
end

function var_0_0:MoveNext(arg_10_1, arg_10_2, ...)
	self.characterList[arg_10_1].curNode:Exit()
	DormHeroAINode.Recycle(self.characterList[arg_10_1].curNode)

	self.characterList[arg_10_1].curNode = DormHeroAINode.Get(arg_10_2 or IdleNode, arg_10_1, ...)

	self.characterList[arg_10_1].curNode:Start()
end

function var_0_0:HasControl(arg_11_1)
	return self.characterList[arg_11_1].controlType == DormEnum.ControlType.AI
end

function var_0_0:SwitchControl(arg_12_1, arg_12_2)
	self.characterList[arg_12_1].controlType = arg_12_2

	if arg_12_2 == DormEnum.ControlType.Player then
		-- block empty
	elseif arg_12_2 == DormEnum.ControlType.AI then
		-- block empty
	end
end

function var_0_0:Dispose()
	for iter_13_0, iter_13_1 in pairs(self.characterList) do
		DormHeroAINode.Recycle(iter_13_1.curNode)
	end

	self.characterList = {}

	self.listener:RemoveAll()
end

function var_0_0.GetEntityData(arg_14_0)
	return Dorm.storage:GetData(DormEnum.Namespace.EntityData, arg_14_0)
end

function var_0_0.ConsumeInteractCtx(arg_15_0)
	DormUtils.SetEntityInteractContext(arg_15_0, nil)

	return var_0_0.GetEntityData(arg_15_0).interactCtx
end

function var_0_0:SetParam(arg_16_1, arg_16_2, arg_16_3)
	if self.characterList[arg_16_1] then
		self.characterList[arg_16_1].params[arg_16_2] = arg_16_3
	end
end

function var_0_0:GetParam(arg_17_1, arg_17_2)
	if self.characterList[arg_17_1] then
		return self.characterList[arg_17_1].params[arg_17_2]
	end
end

return var_0_0.GetInstance()
