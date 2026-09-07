local PlayerInputManager = class("PlayerInputManager")
local Vector3 = require("Framework.toLua.UnityEngine.Vector3")

function PlayerInputManager:Ctor(arg_1_1)
	self.inputController = IslandCameraMgr.instance.gameObject:GetComponent(typeof(InputController))
	self.controller = arg_1_1
	self.inputCommandQueue = {}
	self.isInit = false

	return
end

function PlayerInputManager:IsInit()
	return self.isInit
end

function PlayerInputManager:Init()
	self.isInit = true

	local var_3_0 = self.controller

	function PlayerInputManager:UpdateMoveFunc()
		local var_4_0 = Vector3(self.x, 0, self.y)

		var_3_0:NotifiyCore(ISLAND_EVT.MOVE_PLAYER_BEFORE)

		local var_4_1 = self.magnitude

		table.insert(self.inputCommandQueue, {
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

	self.inputController:AddUpdateMoveFunc(PlayerInputManager.UpdateMoveFunc)

	function PlayerInputManager.CancelMoveFunc(arg_6_0)
		table.insert(self.inputCommandQueue, {
			Execute = function()
				var_3_0:NotifiyCore(ISLAND_EVT.STOP_MOVE_PLAYER)

				return
			end
		})

		return
	end

	self.inputController:AddCancelMoveFunc(PlayerInputManager.CancelMoveFunc)

	function PlayerInputManager.UpdateJumpFunc(arg_8_0)
		table.insert(self.inputCommandQueue, {
			Execute = function()
				var_3_0:NotifiyCore(ISLAND_EVT.JUMP_PLAYER)

				return
			end
		})

		return
	end

	self.inputController:AddUpdateJumpFunc(PlayerInputManager.UpdateJumpFunc)

	function PlayerInputManager.UpdateSprintFuc(arg_10_0)
		table.insert(self.inputCommandQueue, {
			Execute = function()
				var_3_0:NotifiyCore(ISLAND_EVT.SPRINT_PLAYER)

				return
			end
		})

		return
	end

	self.inputController:AddUpdateSprintFunc(PlayerInputManager.UpdateSprintFuc)

	function PlayerInputManager.CancelSprintFuc(arg_12_0)
		table.insert(self.inputCommandQueue, {
			Execute = function()
				var_3_0:NotifiyCore(ISLAND_EVT.STOP_SPRINT_PLAYER)

				return
			end
		})

		return
	end

	self.inputController:AddCancelSprintFunc(PlayerInputManager.CancelSprintFuc)

	return
end

function PlayerInputManager:Update()
	if not self.isInit then
		return
	end

	if #self.inputCommandQueue == 0 then
		return
	end

	while #self.inputCommandQueue > 0 do
		table.remove(self.inputCommandQueue, 1)

		if not self.disablePlayerHandle then
			self.inputCommandQueue[1]:Execute()
		end
	end

	return
end

function PlayerInputManager:Dispose()
	if not self.isInit then
		return
	end

	self.inputController:RemoveUpdateMoveFunc(PlayerInputManager.UpdateMoveFunc)
	self.inputController:RemoveCancelMoveFunc(PlayerInputManager.CancelMoveFunc)
	self.inputController:RemoveUpdateJumpFunc(PlayerInputManager.UpdateJumpFunc)
	self.inputController:RemoveUpdateSprintFunc(PlayerInputManager.UpdateSprintFuc)
	self.inputController:RemoveCancelSprintFunc(PlayerInputManager.CancelSprintFuc)

	self.inputController = nil

	return
end

function PlayerInputManager:UpdataWorkStateFunc(arg_16_1, arg_16_2)
	table.insert(self.inputCommandQueue, {
		Execute = function()
			self.controller:NotifiyCore(ISLAND_EVT.SET_PLAYER_WORK, arg_16_1, arg_16_2)

			return
		end
	})

	return
end

function PlayerInputManager:DisablePlayerHandle()
	self.disablePlayerHandle = true

	return
end

function PlayerInputManager:EnablePlayerHandle()
	self.disablePlayerHandle = false

	return
end

function PlayerInputManager:DisableInput()
	while #self.inputCommandQueue > 0 do
		table.remove(self.inputCommandQueue, 1)
	end

	self.inputController:DisablePlayerAllOp()

	return
end

function PlayerInputManager:EnableInput()
	self.inputController:EnablePlayerAllOp()

	return
end

return PlayerInputManager
