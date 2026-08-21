local var_0_0 = {}
local var_0_1 = "CharDorm/prop/huochetou"
local var_0_2 = "CharDorm/prop/huochexiang"

local function var_0_3(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, arg_1_0[1])

	for iter_1_0 = #arg_1_0, 2, -1 do
		table.insert(var_1_0, arg_1_0[iter_1_0])
	end

	return var_1_0
end

local function var_0_4(arg_2_0)
	return (nullable(DormUtils.GetEntityData(arg_2_0), "rail"))
end

local var_0_5 = 1.55
local var_0_6 = 4
local var_0_7 = "train_head"
local var_0_8 = 1.5
local var_0_9 = "train_head_stand"
local var_0_10 = 1.3

return function(arg_3_0)
	local var_3_0 = math.random() > 0.5
	local var_3_1 = arg_3_0.entityID
	local var_3_2 = arg_3_0.targetID
	local var_3_3 = var_0_4(var_3_2)
	local var_3_4 = var_3_3.path
	local var_3_5 = Dorm.DormEntityManager.QueryPosition(var_3_1)
	local var_3_6 = var_3_3:GenerateTrain(var_0_6)
	local var_3_7 = var_3_6[1]

	Dorm.DormEntityManager.KeepAsInteractNotEnd(var_3_1, var_3_7, true)
	Dorm.DormEntityManager.AttachToEntityCMD(var_3_1, var_3_7, "gua_start")
	Dorm.DormEntityManager.PlayAnimeDuringInteract(var_3_1, var_0_7)

	for iter_3_0 = 2, var_3_3:GetTrainCartNum() do
		DormLuaBridge.SetupFurnitureTileEntity(var_3_3:GetTrainEID(iter_3_0))
	end

	local var_3_8 = var_3_3:FindClosestPointOnRail(var_3_5)
	local var_3_9 = DormCharacterActionManager.taskRunner:NewTask()

	var_3_9:Then(function(arg_4_0)
		for iter_4_0, iter_4_1 in ipairs(var_3_6) do
			local var_4_0 = var_3_8 - (iter_4_0 - 1) * var_0_5 * (var_3_0 and -1 or 1)

			Dorm.DormEntityManager.SendPatrolCMD(iter_4_1, var_3_4, var_3_0, var_4_0, false)
			Dorm.DormEntityManager.SetEntitySpeed(iter_4_1, 0)
		end

		manager.audio:PlayEffect("ui_dorm", "ui_dorm_train")
	end)

	return var_3_9
end
