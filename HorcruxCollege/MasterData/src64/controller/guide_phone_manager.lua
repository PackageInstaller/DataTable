local GuidePhoneManager = class("GuidePhoneManager", (require("controller.base_manager")))

GuidePhoneManager.MULTITON_MSG = "GuidePhoneManager instancealready constructed!"

function GuidePhoneManager:ctor()
	GuidePhoneManager.super.ctor(self)

	self._data = {}
end

function GuidePhoneManager:requestInfo(arg_2_1)
	return
end

function GuidePhoneManager:handlerInfo(arg_3_1)
	return
end

function GuidePhoneManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function GuidePhoneManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

return GuidePhoneManager
