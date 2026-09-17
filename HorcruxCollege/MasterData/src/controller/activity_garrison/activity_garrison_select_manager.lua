local ActivityGarrisonSelectManager = class("ActivityGarrisonSelectManager", (require("controller.base_manager")))

ActivityGarrisonSelectManager.MULTITON_MSG = "ActivityGarrisonSelectManager instancealready constructed!"

function ActivityGarrisonSelectManager:ctor()
	ActivityGarrisonSelectManager.super.ctor(self)

	self._data = {}
end

function ActivityGarrisonSelectManager:requestInfo(arg_2_1)
	return
end

function ActivityGarrisonSelectManager:handlerInfo(arg_3_1)
	return
end

function ActivityGarrisonSelectManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function ActivityGarrisonSelectManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

return ActivityGarrisonSelectManager
