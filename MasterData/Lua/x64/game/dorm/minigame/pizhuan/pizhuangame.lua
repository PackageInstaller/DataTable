local PizhuanGame = class("PizhuanGame")
local var_0_1 = "pizhuan_game"

function PizhuanGame:Ctor(arg_1_1)
	self.gameFinish = arg_1_1
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
		local var_6_0 = DormCharacterInteractBehaviour.MakeCtx(arg_3_0.player, arg_3_0.brickItem, {
			waitOneTick = true
		})
		local var_6_1 = DormCharacterInteractBehaviour.GetSequence(arg_3_0.player, nil, (arg_6_0.taskDataCtx.result or nil) and (var_0_3 or var_0_4))

		if var_6_1 then
			arg_6_0.taskDataCtx.performanceTask = DormCharacterInteractBehaviour.MakeInteractTask(var_6_1, var_6_0)

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

function PizhuanGame:Start(arg_10_1)
	if self.gameTask then
		self.gameTask:Abort()
	end

	self.vfxLevel = 0
	self.player = arg_10_1

	local var_10_0 = Dorm.DormEntityManager.Instance:SpawnEntity("Dorm/Dormitory/HZ05_huodong_piwa", nil, false, true)

	self.brickItem = var_10_0

	local var_10_1 = Dorm.DormEntityManager.QueryForwardDir(arg_10_1)

	Dorm.DormEntityManager.PutEntityLookToDir(var_10_0, Dorm.DormEntityManager.QueryPosition(arg_10_1) + var_10_1 * 0.2, -var_10_1)
	Dorm.DormEntityManager.SendInteractToEntityCMD(arg_10_1, var_10_0, false)

	local var_10_2 = var_0_5(self)

	var_0_7(var_0_6)
	var_10_2:SetOnComplete(function()
		Dorm.DormEntityManager.ClearAllEffect(arg_10_1, var_0_1)
		var_0_2(var_10_0)
		var_0_8(var_0_6)
	end)
	var_10_2:SetOnAbort(function()
		Dorm.DormEntityManager.ClearAllEffect(arg_10_1, var_0_1)

		if Dorm.DormEntityManager.IsValidEntityID(arg_10_1) and not var_10_2:IsCancelled() then
			Dorm.DormEntityManager.StopAllCmd(arg_10_1)
		end

		var_0_2(var_10_0)
		var_0_8(var_0_6)

		if var_10_2.taskDataCtx.performanceTask then
			var_10_2.taskDataCtx.performanceTask:Abort()

			var_10_2.taskDataCtx.performanceTask = nil
		end
	end)

	self.gameTask = var_10_2

	DormUtils.SetEntityInteractContext(arg_10_1, (DormCharacterInteractBehaviour.MakeCtx(arg_10_1, var_10_0, {
		curActionTask = var_10_2
	})))
end

PizhuanGame.QTE_LEVEL_RESET = 0

function PizhuanGame:OnQte(arg_13_1)
	if arg_13_1 == nil then
		return
	end

	if arg_13_1 == PizhuanGame.QTE_LEVEL_RESET then
		self.level = 0

		Dorm.DormEntityManager.ClearAllEffect(self.player, var_0_1)
	elseif arg_13_1 > self.vfxLevel then
		self.level = arg_13_1

		Dorm.DormEntityManager.ClearAllEffect(self.player, var_0_1)

		if var_0_6[arg_13_1] then
			Dorm.DormEntityManager.PlayEffect(self.player, "root", var_0_1, var_0_6[arg_13_1], -1)
		end
	end
end

function PizhuanGame:Abort()
	if self.gameTask then
		self.vfxLevel = 0

		self.gameTask:Abort()

		self.gameTask = nil
	end
end

return PizhuanGame
