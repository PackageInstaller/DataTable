local MonopolyDiceSelectManager = class("MonopolyDiceSelectManager", (require("controller.base_manager")))

MonopolyDiceSelectManager.MULTITON_MSG = "MonopolyDiceSelectManager instancealready constructed!"

function MonopolyDiceSelectManager:ctor()
	MonopolyDiceSelectManager.super.ctor(self)

	self._data = {}
end

function MonopolyDiceSelectManager:requestInfo(arg_2_1)
	return
end

function MonopolyDiceSelectManager:handlerInfo(arg_3_1)
	return
end

function MonopolyDiceSelectManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function MonopolyDiceSelectManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

return MonopolyDiceSelectManager
