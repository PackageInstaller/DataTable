local ClassMediator = class("ClassMediator", import("...base.ContextMediator"))

ClassMediator.UPGRADE_FIELD = "ClassMediator:UPGRADE_FIELD"

function ClassMediator:register()
	self:bind(ClassMediator.UPGRADE_FIELD, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.SHOPPING, {
			count = 1,
			id = arg_2_1
		})

		return
	end)
	self.viewComponent:SetCourse((getProxy(NavalAcademyProxy):getCourse()))
	self.viewComponent:SetStudents((getProxy(CollectionProxy):getGroups()))
	self.viewComponent:SetClass((getProxy(NavalAcademyProxy):GetClassVO()))

	return
end

function ClassMediator:listNotificationInterests()
	return {
		NavalAcademyProxy.RESOURCE_UPGRADE_DONE,
		NavalAcademyProxy.RESOURCE_UPGRADE,
		NavalAcademyProxy.COURSE_UPDATED
	}
end

function ClassMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == NavalAcademyProxy.RESOURCE_UPGRADE_DONE then
		if isa(var_4_1.field, ClassResourceField) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("main_navalAcademyScene_class_upgrade_complete", pg.navalacademy_data_template[1].name, var_4_1.value, var_4_1.rate, var_4_1.exp))
		end

		self.viewComponent:OnUpdateResField(var_4_1.field)
	elseif var_4_0 == NavalAcademyProxy.RESOURCE_UPGRADE then
		self.viewComponent:OnUpdateResField(var_4_1.resVO)
	elseif var_4_0 == NavalAcademyProxy.COURSE_UPDATED then
		self.viewComponent:SetCourse((getProxy(NavalAcademyProxy):getCourse()))
		self.viewComponent:InitClassInfo()
	end

	return
end

return ClassMediator
