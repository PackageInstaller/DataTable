class = var_0_10000

local var_0_0 = "EducateMapMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.EducateContextMediator"))

var_0_1.ON_SPECIAL_EVENT_TRIGGER = "EducateMapMediator.ON_SPECIAL_EVENT_TRIGGER"
var_0_1.ON_MAP_SITE_OPERATE = "EducateMapMediator.ON_MAP_SITE_OPERATE"
var_0_1.ON_OPEN_SHOP = "EducateMapMediator.ON_OPEN_SHOP"
var_0_1.ON_ADD_TASK_PROGRESS = "EducateMapMediator.ON_ADD_TASK_PROGRESS"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_SPECIAL_EVENT_TRIGGER, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.EDUCATE_TRIGGER_SPEC_EVENT, {
			siteId = arg_2_1.siteId,
			eventId = arg_2_1.id,
			callback = arg_2_1.callback
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_MAP_SITE_OPERATE, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.EDUCATE_MAP_SITE, {
			siteId = arg_3_1.siteId,
			optionVO = arg_3_1.optionVO
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_OPEN_SHOP, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_4_2 = var_2_10005.New
		local var_4_3 = {}

		EducateShopMediator = var_2_10008
		var_4_3.mediator = var_2_10008
		EducateShopLayer = var_2_10008
		var_4_3.viewComponent = var_2_10008
		var_4_3.data = {
			shopId = arg_4_1
		}

		var_4_1(var_4_0, var_4_2(var_4_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_ADD_TASK_PROGRESS, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10005

		var_5_1(var_5_0, var_2_10005.EDUCATE_ADD_TASK_PROGRESS, {
			system = arg_5_1.system,
			progresses = arg_5_1.progresses
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_6_0)
	local var_6_0 = {}

	EducateProxy = var_1_10002
	var_6_0[1] = var_1_10002.RESOURCE_UPDATED
	EducateProxy = var_2
	var_6_0[2] = var_2.ATTR_UPDATED
	EducateProxy = var_2
	var_6_0[3] = var_2.BUFF_ADDED
	EducateProxy = var_2
	var_6_0[4] = var_2.TIME_UPDATED
	EducateProxy = var_2
	var_6_0[5] = var_2.TIME_WEEKDAY_UPDATED
	EducateTaskProxy = var_2
	var_6_0[6] = var_2.TASK_UPDATED
	EducateTaskProxy = var_2
	var_6_0[7] = var_2.TASK_ADDED
	EducateTaskProxy = var_2
	var_6_0[8] = var_2.TASK_REMOVED
	EducateProxy = var_2
	var_6_0[9] = var_2.CLEAR_NEW_TIP
	GAME = var_2
	var_6_0[10] = var_2.EDUCATE_REFRESH_DONE
	GAME = var_2
	var_6_0[11] = var_2.EDUCATE_SUBMIT_TASK_DONE
	GAME = var_2
	var_6_0[12] = var_2.EDUCATE_TRIGGER_SPEC_EVENT_DONE
	GAME = var_2
	var_6_0[13] = var_2.EDUCATE_MAP_SITE_DONE

	return var_6_0
end

function var_0_1.handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1
	local var_7_1 = arg_7_1.getName(var_7_0)
	local var_7_2 = arg_7_1
	local var_7_3 = arg_7_1.getBody(var_7_2)

	EducateProxy = var_7_0

	if var_7_1 == var_7_0.RESOURCE_UPDATED then
		local var_7_4 = arg_7_0.viewComponent

		var_4.updateRes(var_7_4)

		goto label_7_0
	end

	EducateProxy = var_4

	if var_7_1 == var_4.ATTR_UPDATED then
		local var_7_5 = arg_7_0.viewComponent

		var_4.updateAttrs(var_7_5)

		goto label_7_0
	end

	EducateProxy = var_4

	if var_7_1 == var_4.BUFF_ADDED then
		local var_7_6 = arg_7_0.viewComponent

		var_4.updateAttrs(var_7_6)

		goto label_7_0
	end

	EducateProxy = var_4

	if var_7_1 == var_4.TIME_UPDATED then
		local var_7_7 = arg_7_0.viewComponent

		var_4.updateTime(var_7_7)

		local var_7_8 = arg_7_0.viewComponent

		var_4.updateRes(var_7_8)

		local var_7_9 = arg_7_0.viewComponent

		var_4.updateTarget(var_7_9)

		goto label_7_0
	end

	EducateProxy = var_4

	if var_7_1 == var_4.TIME_WEEKDAY_UPDATED then
		local var_7_10 = arg_7_0.viewComponent

		var_4.updateTimeWeekDay(var_7_10, var_7_3.weekDay)

		goto label_7_0
	end

	EducateTaskProxy = var_4

	if var_7_1 ~= var_4.TASK_UPDATED then
		EducateTaskProxy = var_4

		if var_7_1 ~= var_4.TASK_ADDED then
			EducateTaskProxy = var_4

			if var_7_1 ~= var_4.TASK_REMOVED then
				GAME = var_4

				if var_7_1 == var_4.EDUCATE_SUBMIT_TASK_DONE then
					local var_7_11 = arg_7_0.viewComponent

					var_4.updateTarget(var_7_11)
				else
					EducateProxy = var_4

					local var_7_12

					if var_7_1 == var_4.CLEAR_NEW_TIP then
						var_7_12 = var_7_3.index
						EducateTipHelper = var_7_2

						if var_7_12 == var_7_2.NEW_SITE then
							local var_7_13 = arg_7_0.viewComponent

							var_7_12.clearNewTip(var_7_13, var_7_3.id)
						end
					else
						GAME = var_7_12

						local var_7_15

						if var_7_1 == var_7_12.EDUCATE_REFRESH_DONE then
							local var_7_14 = arg_7_0.viewComponent

							var_7_15 = var_7_15.emit
							EducateBaseUI = var_1_10007

							local var_7_16 = var_1_10007.EDUCATE_CHANGE_SCENE

							SCENE = var_1_10008

							var_7_15(var_7_14, var_7_16, var_1_10008.EDUCATE)
						else
							GAME = var_7_15

							local var_7_17

							if var_7_1 == var_7_15.EDUCATE_TRIGGER_SPEC_EVENT_DONE then
								var_7_17 = var_7_3.type
								EducateSpecialEvent = var_7_2

								if var_7_17 == var_7_2.TYPE_SITE then
									local var_7_18 = arg_7_0.viewComponent

									var_7_17.ShowSpecEvent(var_7_18, var_7_3.siteId, var_7_3.id, var_7_3.drops, var_7_3.cb)
								end
							else
								GAME = var_7_17

								if var_7_1 == var_7_17.EDUCATE_MAP_SITE_DONE then
									assert = var_4

									var_4(var_7_3.branchId ~= 0, "请检查配置, 无返回结果分支, optionId: " .. var_7_3.optionId)

									local var_7_19 = arg_7_0.viewComponent

									var_4.ShowSitePerform(var_7_19, var_7_3.optionId, var_7_3.branchId, var_7_3.events, var_7_3.drops, var_7_3.eventDrops)
								end
							end
						end
					end
				end

				::label_7_0::

				return
			end
		end
	end
end

return var_0_1
