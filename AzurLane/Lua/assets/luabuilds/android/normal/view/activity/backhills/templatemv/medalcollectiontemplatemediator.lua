class = var_0_10000

local var_0_0 = "MedalCollectionTemplateMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.MEMORYBOOK_UNLOCK = "MEMORYBOOK_UNLOCK"
var_0_1.MEMORYBOOK_GO = "MEMORYBOOK_GO"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.BindEvent(var_1_0)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityByType

	ActivityConst = var_1_10003

	local var_1_3 = var_1_2(var_1_1, var_1_10003.ACTIVITY_TYPE_PUZZLA)
	local var_1_4 = arg_1_0.viewComponent

	var_2.UpdateActivity(var_1_4, var_1_3)

	return
end

function var_0_1.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_1.MEMORYBOOK_UNLOCK, function(arg_3_0, ...)
		local var_3_0 = arg_2_0
		local var_3_1 = var_1.sendNotification

		GAME = var_2_10003

		var_3_1(var_3_0, var_2_10003.MEMORYBOOK_UNLOCK, ...)

		return
	end)
	arg_2_0:bind(var_0_1.MEMORYBOOK_GO, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10004

		var_4_1(var_4_0, var_2_10004.TASK_GO, {
			taskVO = arg_4_1
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	ActivityProxy = var_1_10002
	var_5_0[1] = var_1_10002.ACTIVITY_ADDED
	ActivityProxy = var_2
	var_5_0[2] = var_2.ACTIVITY_UPDATED
	ActivityProxy = var_2
	var_5_0[3] = var_2.ACTIVITY_OPERATION_DONE
	GAME = var_2
	var_5_0[4] = var_2.MEMORYBOOK_UNLOCK_DONE
	ActivityProxy = var_2
	var_5_0[5] = var_2.ACTIVITY_SHOW_AWARDS

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1
	local var_6_2 = arg_6_1.getBody(var_6_1)

	ActivityProxy = var_6_1

	if var_6_0 ~= var_6_1.ACTIVITY_ADDED then
		ActivityProxy = var_6_3

		local var_6_3

		if var_6_0 == var_6_3.ACTIVITY_UPDATED then
			var_1_10005 = var_6_2
			var_6_3 = var_6_2.getConfig(var_1_10005, "type")
			ActivityConst = var_1_10005

			if var_6_3 == var_1_10005.ACTIVITY_TYPE_PUZZLA then
				var_1_10005 = arg_6_0.viewComponent

				var_6_3.UpdateActivity(var_1_10005, var_6_2)
			end
		else
			GAME = var_6_3

			local var_6_4

			if var_6_0 == var_6_3.MEMORYBOOK_UNLOCK_DONE then
				getProxy = var_6_4
				ActivityProxy = var_1_10005
				var_1_10005 = var_6_4(var_1_10005)
				var_6_4 = var_6_4.getActivityByType
				ActivityConst = var_1_10006
				var_6_4 = var_6_4(var_1_10005, var_1_10006.ACTIVITY_TYPE_PUZZLA)
				var_1_10006 = arg_6_0.viewComponent

				var_1_10005.UpdateActivity(var_1_10006, var_6_4)

				var_1_10006 = arg_6_0.viewComponent

				var_1_10005.UpdateAfterSubmit(var_1_10006, var_6_2)
			else
				ActivityProxy = var_6_4

				if var_6_0 == var_6_4.ACTIVITY_OPERATION_DONE then
					getProxy = var_4
					ActivityProxy = var_1_10005
					var_1_10005 = var_4(var_1_10005)
					var_1_10006 = var_4.getActivityById(var_1_10005, var_6_2)
					var_1_10005 = var_4.getConfig(var_1_10006, "type")
					ActivityConst = var_1_10006

					if var_1_10005 == var_1_10006.ACTIVITY_TYPE_PUZZLA then
						var_1_10006 = arg_6_0.viewComponent

						var_1_10005.UpdateActivity(var_1_10006, var_4)

						var_1_10006 = arg_6_0.viewComponent

						var_1_10005.UpdateAfterFinalMedal(var_1_10006)
					end
				else
					ActivityProxy = var_4

					if var_6_0 == var_4.ACTIVITY_SHOW_AWARDS then
						getProxy = var_4
						ContextProxy = var_1_10005

						local var_6_5 = var_4(var_1_10005)
						local var_6_6 = var_4.getContextByMediator

						ActivityMediator = var_1_10006

						if var_6_6(var_6_5, var_1_10006) then
							return
						end

						local var_6_7 = arg_6_0.viewComponent
						local var_6_8 = var_5.emit

						BaseUI = var_1_10007

						var_6_8(var_6_7, var_1_10007.ON_ACHIEVE, var_6_2.awards, var_6_2.callback)
					end
				end
			end
		end

		return
	end
end

return var_0_1
