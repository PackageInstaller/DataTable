local var_0_0 = class("BarbuceGame")

local function var_0_1(arg_1_0)
	return arg_1_0.model
end

local function var_0_2(arg_2_0)
	return arg_2_0.spawnAt
end

function var_0_0.Ctor(arg_3_0, arg_3_1)
	local var_3_0 = SPHeroChallengeData:GetActivityID()

	arg_3_0.gameFinish = arg_3_1

	local var_3_1 = EntityManager.CreatePlayer.New(var_0_1, var_0_2)

	arg_3_0.playerManager = EntityManager.New(var_3_1)

	function arg_3_0.playerManager.OnRemove(arg_4_0, arg_4_1)
		manager.notify:Invoke(DORM_CHARACTER_DISPOSE, arg_4_1)
	end

	arg_3_0.managers = {
		arg_3_0.playerManager
	}
	arg_3_0.player = arg_3_0.playerManager:Create(1, {
		complex = true,
		model = "CharDorm/activity/Barbuce/" .. ActivityHeroChallengeCfg[var_3_0].hero_prefab_id,
		spawnAt = Dorm.storage:PickData("barbuce.spawn.player").transform
	}, {
		type = "player",
		cfgID = ActivityHeroChallengeCfg[var_3_0].hero_id or 1084
	})
	arg_3_0.brickItem = Dorm.DormEntityManager.Instance:SpawnEntity("CharDorm/prop/kaoroujia", Dorm.storage:PickData("barbuce.spawn.player").transform, false, true)
	arg_3_0.brickItemSucess = GameObject.Find("kaorou_success"):GetComponent("PlayableDirector")
	arg_3_0.brickItemFaile = GameObject.Find("kaorou_fail"):GetComponent("PlayableDirector")
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
		local var_8_0 = arg_8_0.taskDataCtx.result
		local var_8_1 = var_8_0 and var_0_3 or var_0_4

		if var_8_0 then
			arg_5_0.brickItemSucess:Play()
		else
			arg_5_0.brickItemFaile:Play()
		end

		Dorm.DormEntityManager.PlayAnimeDuringInteract(arg_5_0.brickItem, var_8_1)
		Dorm.DormEntityManager.PlayAnimeDuringInteract(arg_5_0.player, var_8_1)
	end):WaitUntil(function(arg_9_0)
		if arg_9_0.taskDataCtx.finish == true or arg_5_0.gameTask:IsFinished() then
			arg_9_0.taskDataCtx = nil
			arg_5_0.gameTask = nil

			return true
		end
	end)

	return var_5_0
end

function var_0_0.StopPlayable(arg_10_0)
	arg_10_0.brickItemSucess:Stop()

	arg_10_0.brickItemSucess.time = 0

	arg_10_0.brickItemSucess:Evaluate()
	arg_10_0.brickItemFaile:Stop()

	arg_10_0.brickItemFaile.time = 0

	arg_10_0.brickItemFaile:Evaluate()
end

function var_0_0.Start(arg_11_0)
	if arg_11_0.gameTask then
		arg_11_0.gameTask:Abort()
	end

	local var_11_0 = var_0_5(arg_11_0)

	var_11_0:SetOnComplete(function()
		arg_11_0:StopPlayable()
		Dorm.DormEntityManager.PlayAnimeDuringInteract(arg_11_0.brickItem, "barbecue_start")
		Dorm.DormEntityManager.PlayAnimeDuringInteract(arg_11_0.player, "barbecue_start")
	end)
	var_11_0:SetOnAbort(function()
		arg_11_0:StopPlayable()
	end)

	arg_11_0.gameTask = var_11_0

	arg_11_0.gameTask:Start()
end

function var_0_0.PlayStartAnim(arg_14_0)
	arg_14_0:StopPlayable()
	Dorm.DormEntityManager.PlayAnimeDuringInteract(arg_14_0.brickItem, "barbecue_start")
	Dorm.DormEntityManager.PlayAnimeDuringInteract(arg_14_0.player, "barbecue_start")
end

function var_0_0.OnQte(arg_15_0, arg_15_1)
	return
end

function var_0_0.Abort(arg_16_0)
	if arg_16_0.gameTask then
		arg_16_0.gameTask:Abort()

		arg_16_0.gameTask = nil
	end
end

return var_0_0
