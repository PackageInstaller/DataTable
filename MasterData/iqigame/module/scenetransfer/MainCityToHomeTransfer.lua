-- chunkname: @IQIGame\\Module\\SceneTransfer\\MainCityToHomeTransfer.lua

local SceneTransferController = require("IQIGame/Module/SceneTransfer/SceneTransferController")
local Transfer = Clone(SceneTransferController)

function Transfer:__OnPrepare()
	SceneTransferModule.SetMainCameraType(self.cameraStackType)
	self:__ChangeState(self.State.UnloadScene)
end

function Transfer:__UnloadScene()
	self:__ChangeState(self.State.LoadScene)
end

function Transfer:__LoadScene()
	self:__OnEnterHome()
end

function Transfer:__OnLoadSceneCallback(sender, event)
	if event.SceneID ~= SceneID.Home then
		return
	end

	GameEntry.LuaEvent:Unsubscribe(LoadSceneExtResEndEventArgs.EventId, self.__delegateLoadSceneCallback)
	self:__OnEnterHome()
end

function Transfer:__OnEnterHome()
	SceneTransferModule.LoadMainCity(false, function(_args)
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
