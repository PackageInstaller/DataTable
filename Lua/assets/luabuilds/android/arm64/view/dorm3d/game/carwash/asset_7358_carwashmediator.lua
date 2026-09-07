local CarWashMediator = class("CarWashMediator", import("view.dorm3d.Core.Dorm3dBaseMediator"))

function CarWashMediator.GetDefaultSystemClasses()
	return CarWashConst.GetDefaultSystemClasses()
end

function CarWashMediator:register()
	return
end

function CarWashMediator:initNotificationHandleDic()
	self.handleDic = {}

	return
end

return CarWashMediator
