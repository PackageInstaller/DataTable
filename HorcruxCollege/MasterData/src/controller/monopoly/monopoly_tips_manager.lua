local MonopolyTipsManager = class("MonopolyTipsManager", (require("controller.base_manager")))

MonopolyTipsManager.MULTITON_MSG = "MonopolyTipsManager instancealready constructed!"

function MonopolyTipsManager:ctor()
	MonopolyTipsManager.super.ctor(self)

	self._data = {}
end

function MonopolyTipsManager:requestInfo(arg_2_1)
	return
end

function MonopolyTipsManager:handlerInfo(arg_3_1)
	return
end

function MonopolyTipsManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function MonopolyTipsManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

return MonopolyTipsManager
