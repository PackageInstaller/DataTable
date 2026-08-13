class = var_0_10000

local var_0_0 = "OtherWorldTaskMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.SUBMIT_TASK_ALL = "activity submit task all"
var_0_1.SUBMIT_TASK = "activity submit task "
var_0_1.TASK_GO = "activity task go "
var_0_1.SHOW_DETAIL = "activity task show detail"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.SUBMIT_TASK_ALL, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0

		var_2.checkActStory(var_2_0, arg_2_1.activityId, arg_2_1.ids, function()
			local var_3_0 = arg_1_0
			local var_3_1 = var_0.sendNotification

			GAME = var_3_10002

			var_3_1(var_3_0, var_3_10002.SUBMIT_ACTIVITY_TASK, {
				act_id = arg_2_1.activityId,
				task_ids = arg_2_1.ids
			})

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_1.SUBMIT_TASK, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0

		var_2.checkActStory(var_4_0, arg_4_1.activityId, {
			arg_4_1.id
		}, function()
			local var_5_0 = arg_1_0
			local var_5_1 = var_0.sendNotification

			GAME = var_3_10002

			var_5_1(var_5_0, var_3_10002.SUBMIT_ACTIVITY_TASK, {
				act_id = arg_4_1.activityId,
				task_ids = {
					arg_4_1.id
				}
			})

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_1.TASK_GO, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0.viewComponent

		var_2.closeView(var_6_0)

		local var_6_1 = arg_6_1.taskVO
		local var_6_2 = var_2.getConfig(var_6_1, "scene")[1]

		SCENE = var_4

		if var_6_2 == var_4.OTHERWORLD_MAP then
			pg = var_6_2

			local var_6_3 = var_6_2.SceneAnimMgr.GetInstance()
			local var_6_4 = var_3.OtherWorldCoverGoScene

			SCENE = var_2_10005

			var_6_4(var_6_3, var_2_10005.OTHERWORLD_MAP, {
				mode = var_2[2].mode
			})
		else
			local var_6_5 = arg_1_0
			local var_6_6 = var_3.sendNotification

			GAME = var_2_10005

			var_6_6(var_6_5, var_2_10005.TASK_GO, {
				taskVO = arg_6_1.taskVO
			})
		end

		return
	end)
	arg_1_0:bind(var_0_1.SHOW_DETAIL, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_7_2 = var_2_10004.New
		local var_7_3 = {}

		AtelierMaterialDetailMediator = var_2_10006
		var_7_3.mediator = var_2_10006
		AtelierMaterialDetailLayer = var_2_10006
		var_7_3.viewComponent = var_2_10006
		var_7_3.data = {
			material = arg_7_1
		}

		var_7_1(var_7_0, var_7_2(var_7_3))

		return
	end)

	return
end

function var_0_1.checkActStory(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	pg = var_1_10004

	if not var_1_10004.activity_template[arg_8_1].config_client.task_story then
		arg_8_3()

		return
	end

	local var_8_0 = {}

	ipairs = var_1_10006

	for iter_8_0, iter_8_1 in var_1_10006(var_4) do
		local var_8_1 = iter_8_1[1]

		var_1_10012 = iter_8_1[2]
		table = var_1_10013

		if var_1_10013.contains(arg_8_2, var_8_1) then
			table = var_1_10013

			var_1_10013.insert(var_8_0, var_1_10012)
		end
	end

	local var_8_2 = {}

	ipairs = var_7

	for iter_8_2, iter_8_3 in var_7(var_8_0) do
		table = var_1_10012

		var_1_10012.insert(var_8_2, function(arg_9_0)
			pg = var_2_10001

			local var_9_0 = var_2_10001.NewStoryMgr.GetInstance()

			var_1.Play(var_9_0, iter_8_3, arg_9_0, true)

			return
		end)
	end

	seriesAsync = var_7

	var_7(var_8_2, function()
		arg_8_3()

		return
	end)

	return
end

function var_0_1.onUIAvalible(arg_11_0)
	return
end

function var_0_1.listNotificationInterests(arg_12_0)
	local var_12_0 = {}

	GAME = var_1_10002
	var_12_0[1] = var_1_10002.SUBMIT_ACTIVITY_TASK_DONE
	GAME = var_2
	var_12_0[2] = var_2.ZERO_HOUR_OP_DONE

	return var_12_0
end

function var_0_1.handleNotification(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1:getName()
	local var_13_1 = arg_13_1
	local var_13_2 = arg_13_1.getBody(var_13_1)

	GAME = var_13_1

	local var_13_4

	if var_13_0 == var_13_1.SUBMIT_ACTIVITY_TASK_DONE then
		if #var_13_2.awards > 0 then
			local var_13_3 = arg_13_0.viewComponent

			var_13_4 = var_13_4.emit
			BaseUI = var_1_10006

			var_13_4(var_13_3, var_1_10006.ON_ACHIEVE, var_13_2.awards)
		end

		if var_13_2.callback then
			-- block empty
		end

		local var_13_5 = arg_13_0.viewComponent

		var_13_4.updateTask(var_13_5, true)
	else
		GAME = var_13_4

		if var_13_0 == var_13_4.ZERO_HOUR_OP_DONE then
			local var_13_6 = arg_13_0.viewComponent

			var_4.updateTask(var_13_6, true)
		end
	end

	return
end

return var_0_1
