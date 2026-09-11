local BarbuceGame = class("BarbuceGame")

local function var_0_1(arg_1_0)
	return arg_1_0.model
end

local function var_0_2(arg_2_0)
	return arg_2_0.spawnAt
end

function BarbuceGame:Ctor(arg_3_1)
	local var_3_0 = SPHeroChallengeData:GetActivityID()

	self.gameFinish = arg_3_1
	self.playerManager = EntityManager.New((EntityManager.CreatePlayer.New(var_0_1, var_0_2)))

	function self.playerManager.OnRemove(arg_4_0, arg_4_1)
		manager.notify:Invoke(DORM_CHARACTER_DISPOSE, arg_4_1)
	end

	self.managers = {
		self.playerManager
	}

	local var_3_1 = {
		type = "player"
	}

	var_3_1.cfgID = ActivityHeroChallengeCfg[var_3_0].hero_id or 1084
	self.player = self.playerManager:Create(1, {
		complex = true,
		model = "CharDorm/activity/Barbuce/" .. ActivityHeroChallengeCfg[var_3_0].hero_prefab_id,
		spawnAt = Dorm.storage:PickData("barbuce.spawn.player").transform
	}, var_3_1)
	self.brickItem = Dorm.DormEntityManager.Instance:SpawnEntity("CharDorm/prop/kaoroujia", Dorm.storage:PickData("barbuce.spawn.player").transform, false, true)
	self.brickItemSucess = GameObject.Find("kaorou_success"):GetComponent("PlayableDirector")
	self.brickItemFaile = GameObject.Find("kaorou_fail"):GetComponent("PlayableDirector")
end

local var_0_3 = "barbecue_successed"
local var_0_4 = "barbecue_failed"

local function var_0_5(arg_5_0)
	local var_5_0 = DormCharacterActionManager.taskRunner:NewTask()

	var_5_0:Then(function()
		return
	end):WaitUntil(function(arg_7_0)
		local var_7_0, var_7_1 = arg_5_0.gameFinish()

		if var_7_0 then
			arg_7_0.taskDataCtx.result = var_7_1
		end

		return var_7_0
	end):Then(function(arg_8_0)
		local var_8_0

		if arg_8_0.taskDataCtx.result then
			var_8_0 = var_0_3 or var_0_4

			if arg_8_0.taskDataCtx.result then
				arg_5_0.brickItemSucess:Play()

				goto label_8_0
			end
		end

		arg_5_0.brickItemFaile:Play()

		::label_8_0::

		Dorm.DormEntityManager.PlayAnimeDuringInteract(arg_5_0.brickItem, var_8_0)
		Dorm.DormEntityManager.PlayAnimeDuringInteract(arg_5_0.player, var_8_0)
	end):WaitUntil(function(arg_9_0)
		if arg_9_0.taskDataCtx.finish == true or arg_5_0.gameTask:IsFinished() then
			arg_9_0.taskDataCtx = nil
			arg_5_0.gameTask = nil

			return true
		end
	end)

	return var_5_0
end

function BarbuceGame:StopPlayable()
	self.brickItemSucess:Stop()

	self.brickItemSucess.time = 0

	self.brickItemSucess:Evaluate()
	self.brickItemFaile:Stop()

	self.brickItemFaile.time = 0

	self.brickItemFaile:Evaluate()
end

function BarbuceGame:Start()
	if self.gameTask then
		self.gameTask:Abort()
	end

	local var_11_0 = var_0_5(self)

	var_11_0:SetOnComplete(function()
		self:StopPlayable()
		Dorm.DormEntityManager.PlayAnimeDuringInteract(self.brickItem, "barbecue_start")
		Dorm.DormEntityManager.PlayAnimeDuringInteract(self.player, "barbecue_start")
	end)
	var_11_0:SetOnAbort(function()
		self:StopPlayable()
	end)

	self.gameTask = var_11_0

	self.gameTask:Start()
end

function BarbuceGame:PlayStartAnim()
	self:StopPlayable()
	Dorm.DormEntityManager.PlayAnimeDuringInteract(self.brickItem, "barbecue_start")
	Dorm.DormEntityManager.PlayAnimeDuringInteract(self.player, "barbecue_start")
end

function BarbuceGame:OnQte(arg_15_1)
	return
end

function BarbuceGame:Abort()
	if self.gameTask then
		self.gameTask:Abort()

		self.gameTask = nil
	end
end

return BarbuceGame
