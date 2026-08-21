local var_0_0 = class("PizhuanGame")
local var_0_1 = "pizhuan_game"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameFinish = arg_1_1
end

local function var_0_2(arg_2_0)
	if arg_2_0 then
		Dorm.DormEntityManager.Instance:RemoveEntity(arg_2_0)

		arg_2_0 = nil
	end
end

local var_0_3 = "pizhuan_success"
local var_0_4 = "pizhuan_fail"

local function var_0_5(arg_3_0)
	local var_3_0 = DormCharacterActionManager.taskRunner:NewTask()

	var_3_0:Then(function()
		Dorm.DormEntityManager.PlayAnimeDuringInteract(arg_3_0.player, "power_storage")
	end):WaitUntil(function(arg_5_0)
		local var_5_0, var_5_1 = arg_3_0.gameFinish()

		if var_5_0 then
			arg_5_0.taskDataCtx.result = var_5_1
		end

		return var_5_0
	end):Then(function(arg_6_0)
		local var_6_0 = arg_6_0.taskDataCtx.result
		local var_6_1 = DormCharacterInteractBehaviour.MakeCtx(arg_3_0.player, arg_3_0.brickItem, {
			waitOneTick = true
		})
		local var_6_2 = var_6_0 and var_0_3 or var_0_4
		local var_6_3 = DormCharacterInteractBehaviour.GetSequence(arg_3_0.player, nil, var_6_2)

		if var_6_3 then
			arg_6_0.taskDataCtx.performanceTask = DormCharacterInteractBehaviour.MakeInteractTask(var_6_3, var_6_1)

			arg_6_0.taskDataCtx.performanceTask:Start(true)
		end
	end):WaitUntil(function(arg_7_0)
		if arg_7_0.taskDataCtx.performanceTask == nil or arg_7_0.taskDataCtx.performanceTask:IsFinished() then
			arg_7_0.taskDataCtx.performanceTask = nil
			arg_3_0.gameTask = nil
			arg_3_0.vfxLevel = 0

			return true
		end
	end)

	return var_3_0
end

local var_0_6 = {
	"Dorm/Effect/houzhai/fx_pizhuan_xuli01",
	"Dorm/Effect/houzhai/fx_pizhuan_xuli02",
	"Dorm/Effect/houzhai/fx_pizhuan_xuli03",
	"Dorm/Effect/houzhai/fx_pizhuan_xuli04",
	"Dorm/Effect/houzhai/fx_pizhuan_xuli05"
}

local function var_0_7(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0) do
		Asset.LoadAsync(iter_8_1, nil)
	end
end

local function var_0_8(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0) do
		Asset.Unload(iter_9_1)
	end

	Resources.UnloadUnusedAssets()
end

function var_0_0.Start(arg_10_0, arg_10_1)
	if arg_10_0.gameTask then
		arg_10_0.gameTask:Abort()
	end

	arg_10_0.vfxLevel = 0
	arg_10_0.player = arg_10_1

	local var_10_0 = Dorm.DormEntityManager.Instance:SpawnEntity("Dorm/Dormitory/HZ05_huodong_piwa", nil, false, true)

	arg_10_0.brickItem = var_10_0

	local var_10_1 = Dorm.DormEntityManager.QueryPosition(arg_10_1)
	local var_10_2 = Dorm.DormEntityManager.QueryForwardDir(arg_10_1)

	Dorm.DormEntityManager.PutEntityLookToDir(var_10_0, var_10_1 + var_10_2 * 0.2, -var_10_2)
	Dorm.DormEntityManager.SendInteractToEntityCMD(arg_10_1, var_10_0, false)

	local var_10_3 = var_0_5(arg_10_0)

	var_0_7(var_0_6)
	var_10_3:SetOnComplete(function()
		Dorm.DormEntityManager.ClearAllEffect(arg_10_1, var_0_1)
		var_0_2(var_10_0)
		var_0_8(var_0_6)
	end)
	var_10_3:SetOnAbort(function()
		Dorm.DormEntityManager.ClearAllEffect(arg_10_1, var_0_1)

		if Dorm.DormEntityManager.IsValidEntityID(arg_10_1) and not var_10_3:IsCancelled() then
			Dorm.DormEntityManager.StopAllCmd(arg_10_1)
		end

		var_0_2(var_10_0)
		var_0_8(var_0_6)

		local var_12_0 = var_10_3.taskDataCtx

		if var_12_0.performanceTask then
			var_12_0.performanceTask:Abort()

			var_12_0.performanceTask = nil
		end
	end)

	local var_10_4 = DormCharacterInteractBehaviour.MakeCtx(arg_10_1, var_10_0, {
		curActionTask = var_10_3
	})

	arg_10_0.gameTask = var_10_3

	DormUtils.SetEntityInteractContext(arg_10_1, var_10_4)
end

var_0_0.QTE_LEVEL_RESET = 0

function var_0_0.OnQte(arg_13_0, arg_13_1)
	if arg_13_1 == nil then
		return
	end

	if arg_13_1 == var_0_0.QTE_LEVEL_RESET then
		arg_13_0.level = 0

		Dorm.DormEntityManager.ClearAllEffect(arg_13_0.player, var_0_1)
	elseif arg_13_1 > arg_13_0.vfxLevel then
		arg_13_0.level = arg_13_1

		Dorm.DormEntityManager.ClearAllEffect(arg_13_0.player, var_0_1)

		local var_13_0 = var_0_6[arg_13_1]

		if var_13_0 then
			Dorm.DormEntityManager.PlayEffect(arg_13_0.player, "root", var_0_1, var_13_0, -1)
		end
	end
end

function var_0_0.Abort(arg_14_0)
	if arg_14_0.gameTask then
		arg_14_0.vfxLevel = 0

		arg_14_0.gameTask:Abort()

		arg_14_0.gameTask = nil
	end
end

return var_0_0
