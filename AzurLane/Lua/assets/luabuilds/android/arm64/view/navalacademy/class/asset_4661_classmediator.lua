class = var_0_10000

local var_0_0 = "ClassMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.UPGRADE_FIELD = "ClassMediator:UPGRADE_FIELD"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.UPGRADE_FIELD, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.SHOPPING, {
			count = 1,
			id = arg_2_1
		})

		return
	end)

	getProxy = var_1
	NavalAcademyProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getCourse(var_1_1)
	local var_1_3 = arg_1_0.viewComponent

	var_2.SetCourse(var_1_3, var_1_2)

	getProxy = var_2
	CollectionProxy = var_1_3

	local var_1_4 = var_2(var_1_3)
	local var_1_5 = var_2.getGroups(var_1_4)
	local var_1_6 = arg_1_0.viewComponent

	var_3.SetStudents(var_1_6, var_1_5)

	getProxy = var_3
	NavalAcademyProxy = var_1_6

	local var_1_7 = var_3(var_1_6)
	local var_1_8 = var_3.GetClassVO(var_1_7)
	local var_1_9 = arg_1_0.viewComponent

	var_4.SetClass(var_1_9, var_1_8)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	NavalAcademyProxy = var_1_10002
	var_3_0[1] = var_1_10002.RESOURCE_UPGRADE_DONE
	NavalAcademyProxy = var_2
	var_3_0[2] = var_2.RESOURCE_UPGRADE
	NavalAcademyProxy = var_2
	var_3_0[3] = var_2.COURSE_UPDATED

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.getName(var_4_0)
	local var_4_2 = arg_4_1
	local var_4_3 = arg_4_1.getBody(var_4_2)

	NavalAcademyProxy = var_4_0

	local var_4_4

	if var_4_1 == var_4_0.RESOURCE_UPGRADE_DONE then
		var_4_4 = var_4_3.field
		isa = var_4_2

		local var_4_5 = var_4_4

		ClassResourceField = var_1_10008

		if var_4_2(var_4_5, var_1_10008) then
			pg = var_5

			local var_4_6 = var_5.TipsMgr.GetInstance()
			local var_4_7 = var_5.ShowTips

			i18n = var_1_10008

			local var_4_8 = "main_navalAcademyScene_class_upgrade_complete"

			pg = var_1_10011

			var_4_7(var_4_6, var_1_10008(var_4_8, var_1_10011.navalacademy_data_template[1].name, var_4_3.value, var_4_3.rate, var_4_3.exp))
		end

		local var_4_9 = arg_4_0.viewComponent

		var_5.OnUpdateResField(var_4_9, var_4_4)
	else
		NavalAcademyProxy = var_4_4

		if var_4_1 == var_4_4.RESOURCE_UPGRADE then
			var_1_10006 = arg_4_0.viewComponent

			var_4.OnUpdateResField(var_1_10006, var_4_3.resVO)
		else
			NavalAcademyProxy = var_4

			if var_4_1 == var_4.COURSE_UPDATED then
				getProxy = var_4
				NavalAcademyProxy = var_1_10006

				local var_4_10 = var_4(var_1_10006)
				local var_4_11 = var_4.getCourse(var_4_10)
				local var_4_12 = arg_4_0.viewComponent

				var_5.SetCourse(var_4_12, var_4_11)

				local var_4_13 = arg_4_0.viewComponent

				var_5.InitClassInfo(var_4_13)
			end
		end
	end

	return
end

return var_0_1
