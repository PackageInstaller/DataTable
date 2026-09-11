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
	local var_3_2 = var_0_4(arg_3_0.targetID)

	if var_3_2 and not var_3_2:HasTrainStarted() then
		local var_3_3 = var_3_2.path
		local var_3_4 = var_3_2:GenerateTrain(var_0_6)
		local var_3_5 = var_3_4[1]

		Dorm.DormEntityManager.KeepAsInteractNotEnd(var_3_1, var_3_4[1], true)
		Dorm.DormEntityManager.AttachToEntityCMD(var_3_1, var_3_4[1], "gua_start")
		Dorm.DormEntityManager.PlayAnimeDuringInteract(var_3_1, var_0_7)

		for iter_3_0 = 2, var_3_2:GetTrainCartNum() do
			DormLuaBridge.SetupFurnitureTileEntity(var_3_2:GetTrainEID(iter_3_0))
		end

		local var_3_6 = var_3_2:FindClosestPointOnRail((Dorm.DormEntityManager.QueryPosition(var_3_1)))
		local var_3_7 = DormCharacterActionManager.taskRunner:NewTask()

		var_3_7:Then(function(arg_4_0)
			for iter_4_0, iter_4_1 in ipairs(var_3_4) do
				Dorm.DormEntityManager.SendPatrolCMD(iter_4_1, var_3_3, var_3_0, var_3_6 - (iter_4_0 - 1) * var_0_5 * (var_3_0 and -1 or 1), false)
				Dorm.DormEntityManager.SetEntitySpeed(iter_4_1, 0)
			end

			manager.audio:PlayEffect("ui_dorm", "ui_dorm_train")
		end):WaitForSec(var_0_8):Then(function()
			for iter_5_0, iter_5_1 in ipairs(var_3_4) do
				Dorm.DormEntityManager.SetEntitySpeed(iter_5_1, var_0_10)
			end

			Dorm.DormEntityManager.PlayAnimeDuringInteract(var_3_1, var_0_9)
		end):WaitUntil(function()
			return false
		end)
		var_3_7:SetOnAbort(function()
			Dorm.DormEntityManager.KeepAsInteractNotEnd(var_3_1, var_3_5, false)

			for iter_7_0, iter_7_1 in ipairs(var_3_4) do
				if iter_7_1 ~= var_3_5 then
					for iter_7_2, iter_7_3 in DormUtils.EnumerateInteractEntities(iter_7_1) do
						Dorm.DormEntityManager.StopAllCmd(iter_7_3)
						DormLuaBridge.TryGrabPlayerOutOfStuck(iter_7_3)
					end
				end
			end

			var_3_2:ClearTrain()
		end)

		return var_3_7
	else
		DormLuaBridge.TryGrabPlayerOutOfStuck(var_3_1, true)
	end
end
