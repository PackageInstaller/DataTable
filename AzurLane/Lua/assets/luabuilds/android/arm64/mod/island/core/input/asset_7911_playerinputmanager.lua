class = var_0_10000

local var_0_0 = var_0_10000("PlayerInputManager")

require = var_0_10001

local var_0_1 = var_0_10001("Framework.toLua.UnityEngine.Vector3")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	IslandCameraMgr = var_1_10002

	local var_1_0 = var_1_10002.instance.gameObject
	local var_1_1 = var_2.GetComponent

	typeof = var_1_10005
	InputController = var_1_10007
	arg_1_0.inputController = var_1_1(var_1_0, var_1_10005(var_1_10007))
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
		local var_4_1 = var_3_0
		local var_4_2 = var_2.NotifiyCore

		ISLAND_EVT = var_5

		var_4_2(var_4_1, var_5.MOVE_PLAYER_BEFORE)

		local var_4_3 = arg_4_0.magnitude

		table = var_3

		var_3.insert(arg_3_0.inputCommandQueue, {
			Execute = function()
				local var_5_0 = var_3_0
				local var_5_1 = var_0.NotifiyCore

				ISLAND_EVT = var_3_10003

				var_5_1(var_5_0, var_3_10003.MOVE_PLAYER, {
					targetDir = var_4_0,
					force = var_4_3
				})

				return
			end
		})

		return
	end

	local var_3_1 = arg_3_0.inputController

	var_2.AddUpdateMoveFunc(var_3_1, var_0_0.UpdateMoveFunc)

	function var_0_0.CancelMoveFunc(arg_6_0)
		table = var_2_10001

		var_2_10001.insert(arg_3_0.inputCommandQueue, {
			Execute = function()
				local var_7_0 = var_3_0
				local var_7_1 = var_0.NotifiyCore

				ISLAND_EVT = var_3_10003

				var_7_1(var_7_0, var_3_10003.STOP_MOVE_PLAYER)

				return
			end
		})

		return
	end

	local var_3_2 = arg_3_0.inputController

	var_2.AddCancelMoveFunc(var_3_2, var_0_0.CancelMoveFunc)

	function var_0_0.UpdateJumpFunc(arg_8_0)
		table = var_2_10001

		var_2_10001.insert(arg_3_0.inputCommandQueue, {
			Execute = function()
				local var_9_0 = var_3_0
				local var_9_1 = var_0.NotifiyCore

				ISLAND_EVT = var_3_10003

				var_9_1(var_9_0, var_3_10003.JUMP_PLAYER)

				return
			end
		})

		return
	end

	local var_3_3 = arg_3_0.inputController

	var_2.AddUpdateJumpFunc(var_3_3, var_0_0.UpdateJumpFunc)

	function var_0_0.UpdateSprintFuc(arg_10_0)
		table = var_2_10001

		var_2_10001.insert(arg_3_0.inputCommandQueue, {
			Execute = function()
				local var_11_0 = var_3_0
				local var_11_1 = var_0.NotifiyCore

				ISLAND_EVT = var_3_10003

				var_11_1(var_11_0, var_3_10003.SPRINT_PLAYER)

				return
			end
		})

		return
	end

	local var_3_4 = arg_3_0.inputController

	var_2.AddUpdateSprintFunc(var_3_4, var_0_0.UpdateSprintFuc)

	function var_0_0.CancelSprintFuc(arg_12_0)
		table = var_2_10001

		var_2_10001.insert(arg_3_0.inputCommandQueue, {
			Execute = function()
				local var_13_0 = var_3_0
				local var_13_1 = var_0.NotifiyCore

				ISLAND_EVT = var_3_10003

				var_13_1(var_13_0, var_3_10003.STOP_SPRINT_PLAYER)

				return
			end
		})

		return
	end

	local var_3_5 = arg_3_0.inputController

	var_2.AddCancelSprintFunc(var_3_5, var_0_0.CancelSprintFuc)

	return
end

function var_0_0.Update(arg_14_0)
	if not arg_14_0.isInit then
		return
	end

	if #arg_14_0.inputCommandQueue == 0 then
		return
	end

	::label_14_0::

	local var_14_0 = #arg_14_0.inputCommandQueue

	if 0 < var_14_0 then
		repeat
			local var_14_1 = arg_14_0.inputCommandQueue[1]

			table = var_2

			var_2.remove(arg_14_0.inputCommandQueue, 1)

			if not arg_14_0.disablePlayerHandle then
				var_14_1:Execute()
			end

			goto label_14_0
		until true
	end

	return
end

function var_0_0.Dispose(arg_15_0)
	if not arg_15_0.isInit then
		return
	end

	local var_15_0 = arg_15_0.inputController

	var_1.RemoveUpdateMoveFunc(var_15_0, var_0_0.UpdateMoveFunc)

	local var_15_1 = arg_15_0.inputController

	var_1.RemoveCancelMoveFunc(var_15_1, var_0_0.CancelMoveFunc)

	local var_15_2 = arg_15_0.inputController

	var_1.RemoveUpdateJumpFunc(var_15_2, var_0_0.UpdateJumpFunc)

	local var_15_3 = arg_15_0.inputController

	var_1.RemoveUpdateSprintFunc(var_15_3, var_0_0.UpdateSprintFuc)

	local var_15_4 = arg_15_0.inputController

	var_1.RemoveCancelSprintFunc(var_15_4, var_0_0.CancelSprintFuc)

	arg_15_0.inputController = nil

	return
end

function var_0_0.UpdataWorkStateFunc(arg_16_0, arg_16_1, arg_16_2)
	table = var_1_10003

	var_1_10003.insert(arg_16_0.inputCommandQueue, {
		Execute = function()
			local var_17_0 = arg_16_0.controller
			local var_17_1 = var_0.NotifiyCore

			ISLAND_EVT = var_2_10003

			var_17_1(var_17_0, var_2_10003.SET_PLAYER_WORK, arg_16_1, arg_16_2)

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
		table = var_1

		var_1.remove(arg_20_0.inputCommandQueue, 1)
	end

	local var_20_0 = arg_20_0.inputController

	var_1.DisablePlayerAllOp(var_20_0)

	return
end

function var_0_0.EnableInput(arg_21_0)
	local var_21_0 = arg_21_0.inputController

	var_1.EnablePlayerAllOp(var_21_0)

	return
end

return var_0_0
