local IslandFindingPathPlayer = class("IslandFindingPathPlayer", import(".IslandBasePerformancePlayer"))

function IslandFindingPathPlayer:Play(arg_1_1, arg_1_2)
	self:emit(IslandBaseScene.LINK_CORE_EVENT, IslandProxy.START_PATHFINDER, {
		navData = {
			unitId = arg_1_1.object,
			position = arg_1_1.position,
			speed = arg_1_1.speed,
			hide = arg_1_1.hide,
			waitUntilDone = arg_1_1.waitUntilDone,
			index = arg_1_1.index
		},
		callback = arg_1_2,
		onEndAction = function()
			if self.endCallback then
				self.endCallback()
			end

			self.endCallback = nil

			return
		end
	})

	return
end

function IslandFindingPathPlayer:SetEndCallback(arg_3_1)
	self.endCallback = arg_3_1

	return
end

return IslandFindingPathPlayer
