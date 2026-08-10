local var_0_0 = {}
local var_0_1 = require("game.dorm.canteen.RestaurantCharacter.InteractAction.InteractUtil").waitAnime.handleEventWaitAnimation
local var_0_2 = {}
local var_0_3 = 1

function var_0_0.SetEntity(arg_1_0, arg_1_1)
	local var_1_0 = var_0_3

	if var_0_2[arg_1_1] == nil then
		var_0_3 = var_0_3 + 1
	end

	var_0_2[arg_1_1] = {
		eid = arg_1_0,
		idx = var_1_0
	}

	Dorm.LuaBridge.MiniGameBridge.MuteAudioTriggerOnEntityAnimator(arg_1_0)
end

function var_0_0.Clear()
	var_0_2 = {}
	var_0_3 = 1
end

function var_0_0.Work(arg_3_0, arg_3_1)
	local var_3_0 = Dorm.storage:GetData(LianLianKanGameManager.ItemEidNameSpace(DormEnum.ItemType.Pan), arg_3_1.idx)

	if arg_3_0 and var_3_0 then
		Dorm.DormEntityManager.SendInteractToEntityCMD(arg_3_0, var_3_0, false)
	end
end

local function var_0_4(arg_4_0, arg_4_1)
	local var_4_0 = "game.dorm.interacts.canteen.cook_" .. arg_4_0 .. "_" .. arg_4_1
	local var_4_1 = package.loaded[var_4_0]

	if var_4_1 then
		if type(var_4_1) == "table" then
			return var_4_1
		end
	else
		local var_4_2 = Dorm.InteractionGrouping[var_4_0]

		if var_4_2 then
			return var_4_2[math.random(#var_4_2)]
		end
	end
end

function var_0_0.Cook(arg_5_0, arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in pairs(var_0_2) do
		if arg_5_0 == iter_5_1.eid then
			local var_5_0 = DormUtils.GetEntityData(arg_5_0).style
			local var_5_1 = var_0_4("saucepan", var_5_0)
			local var_5_2 = DormCharacterInteractBehaviour.MakeCtx(arg_5_0, arg_5_1)
			local var_5_3 = DormCharacterInteractBehaviour.MakeInteractTask(var_5_1, var_5_2) or DormCharacterActionManager.taskRunner:NewTask()

			var_5_3:Then(function()
				arg_5_2:Notify()
			end)

			var_5_2.curActionTask = var_5_3

			DormUtils.SetEntityInteractContext(arg_5_0, var_5_2)
		end
	end
end

local function var_0_5(arg_7_0, arg_7_1)
	if arg_7_0 == arg_7_1.eid then
		if arg_7_1.wait ~= nil then
			arg_7_1.wait:Abort()
		end

		local var_7_0 = DormCharacterActionManager.taskRunner
		local var_7_1 = DormUtils.GetEntityData(arg_7_1.eid)

		arg_7_1.wait = var_7_0:NewTask():WaitUntil(function()
			return (var_7_1.pause or 0) <= UnityEngine.Time.time
		end):Then(function()
			var_7_1.pause = nil

			var_0_0.Work(arg_7_0, arg_7_1)

			arg_7_1.wait = nil
		end):SetOnAbort(function()
			arg_7_1.wait = nil
		end)

		arg_7_1.wait:Start()
	end
end

function var_0_0.OnEntityCompleteAllCmd(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(var_0_2) do
		var_0_5(arg_11_0, iter_11_1)
	end
end

function var_0_0.OnPauseForSec(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(var_0_2) do
		DormUtils.GetEntityData(iter_12_1.eid).pause = UnityEngine.Time.time + arg_12_0
	end
end

var_0_0.events = {
	[ON_DORM_CHARACTER_WAIT_CMD] = var_0_0.OnEntityCompleteAllCmd,
	[ON_DORM_CHARACTER_INTERACT] = var_0_0.Cook,
	[LIANLIANKAN_FREEZE] = var_0_0.OnPauseForSec
}

return var_0_0
