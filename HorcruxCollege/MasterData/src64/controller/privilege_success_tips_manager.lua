local PrivilegeSuccessTipsManager = class("PrivilegeSuccessTipsManager", (require("controller.base_manager")))

PrivilegeSuccessTipsManager.MULTITON_MSG = "PrivilegeSuccessTipsManager instancealready constructed!"

function PrivilegeSuccessTipsManager:ctor()
	PrivilegeSuccessTipsManager.super.ctor(self)

	self._data = {}
end

function PrivilegeSuccessTipsManager:requestInfo(arg_2_1)
	return
end

function PrivilegeSuccessTipsManager:handlerInfo(arg_3_1)
	return
end

function PrivilegeSuccessTipsManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function PrivilegeSuccessTipsManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

return PrivilegeSuccessTipsManager
