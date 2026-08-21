local var_0_0 = class("PlayerInputManager")
local var_0_1 = require("Framework.toLua.UnityEngine.Vector3")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.inputController = IslandCameraMgr.instance.gameObject:GetComponent(typeof(InputController))
	arg_1_0.controller = arg_1_1
	arg_1_0.inputCommandQueue = {}
	arg_1_0.isInit = false

	return
end

function var_0_0.IsInit(arg_2_0)
	return arg_2_0.isInit
end

function var_0_0.Init(arg_3_0)
	arg_3_0.isInit = true

	local var_3_0 = arg_3_0.controller

	function var_0_0.UpdateMoveFunc(arg_4_0)
		local var_4_0 = var_0_1(arg_4_0.x, 0, arg_4_0.y)

		var_3_0:NotifiyCore(ISLAND_EVT.MOVE_PLAYER_BEFORE)

		local var_4_1 = arg_4_0.magnitude

		table.insert(arg_3_0.inputCommandQueue, {
			Execute = function()
				var_3_0:NotifiyCore(ISLAND_EVT.MOVE_PLAYER, {
					targetDir = var_4_0,
					force = var_4_1
				})

				return
			end
		})

		return
	end

	arg_3_0.inputController:AddUpdateMoveFunc(var_0_0.UpdateMoveFunc)

	function var_0_0.CancelMoveFunc(arg_6_0)
		table.insert(arg_3_0.inputCommandQueue, {
			Execute = function()
				var_3_0:NotifiyCore(ISLAND_EVT.STOP_MOVE_PLAYER)

				return
			end
		})

		return
	end

	arg_3_0.inputController:AddCancelMoveFunc(var_0_0.CancelMoveFunc)

	function var_0_0.UpdateJumpFunc(arg_8_0)
		table.insert(arg_3_0.inputCommandQueue, {
			Execute = function()
				var_3_0:NotifiyCore(ISLAND_EVT.JUMP_PLAYER)

				return
			end
		})

		return
	end

	arg_3_0.inputController:AddUpdateJumpFunc(var_0_0.UpdateJumpFunc)

	function var_0_0.UpdateSprintFuc(arg_10_0)
		table.insert(arg_3_0.inputCommandQueue, {
			Execute = function()
				var_3_0:NotifiyCore(ISLAND_EVT.SPRINT_PLAYER)

				return
			end
		})

		return
	end

	arg_3_0.inputController:AddUpdateSprintFunc(var_0_0.UpdateSprintFuc)

	function var_0_0.CancelSprintFuc(arg_12_0)
		table.insert(arg_3_0.inputCommandQueue, {
			Execute = function()
				var_3_0:NotifiyCore(ISLAND_EVT.STOP_SPRINT_PLAYER)

				return
			end
		})

		return
	end

	arg_3_0.inputController:AddCancelSprintFunc(var_0_0.CancelSprintFuc)

	return
end

function var_0_0.Update(arg_14_0)
	if not arg_14_0.isInit then
		return
	end

	if #arg_14_0.inputCommandQueue == 0 then
		return
	end

	while #arg_14_0.inputCommandQueue > 0 do
		table.remove(arg_14_0.inputCommandQueue, 1)

		if not arg_14_0.disablePlayerHandle then
			arg_14_0.inputCommandQueue[1]:Execute()
		end
	end

	return
end

function var_0_0.Dispose(arg_15_0)
	if not arg_15_0.isInit then
		return
	end

	arg_15_0.inputController:RemoveUpdateMoveFunc(var_0_0.UpdateMoveFunc)
	arg_15_0.inputController:RemoveCancelMoveFunc(var_0_0.CancelMoveFunc)
	arg_15_0.inputController:RemoveUpdateJumpFunc(var_0_0.UpdateJumpFunc)
	arg_15_0.inputController:RemoveUpdateSprintFunc(var_0_0.UpdateSprintFuc)
	arg_15_0.inputController:RemoveCancelSprintFunc(var_0_0.CancelSprintFuc)

	arg_15_0.inputController = nil

	return
end

function var_0_0.UpdataWorkStateFunc(arg_16_0, arg_16_1, arg_16_2)
	table.insert(arg_16_0.inputCommandQueue, {
		Execute = function()
			arg_16_0.controller:NotifiyCore(ISLAND_EVT.SET_PLAYER_WORK, arg_16_1, arg_16_2)

			return
		end
	})

	return
end

function var_0_0.DisablePlayerHandle(arg_18_0)
	arg_18_0.disablePlayerHandle = true

	return
end

function var_0_0.EnablePlayerHandle(arg_19_0)
	arg_19_0.disablePlayerHandle = false

	return
end

function var_0_0.DisableInput(arg_20_0)
	while #arg_20_0.inputCommandQueue > 0 do
		table.remove(arg_20_0.inputCommandQueue, 1)
	end

	arg_20_0.inputController:DisablePlayerAllOp()

	return
end

function var_0_0.EnableInput(arg_21_0)
	arg_21_0.inputController:EnablePlayerAllOp()

	return
end

return var_0_0
