-- chunkname: @IQIGame\\Module\\SceneTransfer\\MazeSceneToHomeTransfer.lua

local SceneTransferController = require("IQIGame/Module/SceneTransfer/SceneTransferController")
local Transfer = Clone(SceneTransferController)

function Transfer:__LoadScene()
	MazeModule.ExitMazeScene()
	self:__RevertUISystemSettingValue()
	SceneTransferModule.LoadMainCity(true, function(_args)
		self:__ChangeState(self.State.Exit)
	end, {})
end

function Transfer:__Exit()
	UIModule.Close(Constant.UIControllerName.LoadingNormalUI)

	if self.completeCall == nil then
		return
	end

	self.completeCall(self.completeCallArgs)
end

return Transfer
