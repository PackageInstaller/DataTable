local MonopolyBuildInfoManager = class("MonopolyBuildInfoManager", (require("controller.base_manager")))

MonopolyBuildInfoManager.MULTITON_MSG = "MonopolyBuildInfoManager instancealready constructed!"

function MonopolyBuildInfoManager:ctor()
	MonopolyBuildInfoManager.super.ctor(self)

	self._data = {}
end

function MonopolyBuildInfoManager:requestInfo(arg_2_1)
	return
end

function MonopolyBuildInfoManager:handlerInfo(arg_3_1)
	return
end

function MonopolyBuildInfoManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function MonopolyBuildInfoManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

return MonopolyBuildInfoManager
