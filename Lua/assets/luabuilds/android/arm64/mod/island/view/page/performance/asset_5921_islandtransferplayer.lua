local IslandTransferPlayer = class("IslandTransferPlayer", import(".IslandBasePerformancePlayer"))

function IslandTransferPlayer:Play(arg_1_1, arg_1_2)
	self:emit(ISLAND_EX_EVT.SWITCH_MAP, arg_1_1.objId)

	self.callback = arg_1_2

	return
end

function IslandTransferPlayer:EndAction()
	if self.callback then
		self.callback()
	end

	self.callback = nil

	return
end

return IslandTransferPlayer
