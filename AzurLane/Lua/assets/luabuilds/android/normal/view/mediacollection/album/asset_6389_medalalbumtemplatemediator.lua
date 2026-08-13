class = var_0_10000

local var_0_0 = "MedalAlbumTemplateMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ON_TASK_GO = "ON_TASK_GO"
var_0_1.ON_TASK_SUBMIT = "ON_TASK_SUBMIT"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.BindEvent(var_1_0)

	getProxy = var_1
	PlayerProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getRawData(var_1_1)
	local var_1_3 = var_1.getActivityMedalGroup(var_1_2)
	local var_1_4 = arg_1_0.viewComponent

	var_3.SetMedalGroupData(var_1_4, var_1_3)

	if arg_1_0:GetContext().parent.mediator.__cname == "WorldMediaCollectionMediator" then
		local var_1_5 = arg_1_0.viewComponent

		var_3.ShowPageBtn(var_1_5, true)
	else
		local var_1_6 = arg_1_0.viewComponent

		var_3.ShowPageBtn(var_1_6, false)
	end

	return
end

function var_0_1.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_1.ON_TASK_GO, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.TASK_GO, {
			taskVO = arg_3_1
		})

		return
	end)
	arg_2_0:bind(var_0_1.ON_TASK_SUBMIT, function(arg_4_0, arg_4_1, arg_4_2)
		seriesAsync = var_2_10003

		var_2_10003({
			function(arg_5_0)
				arg_2_0.awardIndex = 0
				arg_2_0.showAwards = {}

				local var_5_0 = arg_2_0
				local var_5_1 = var_1.sendNotification

				GAME = var_3_10003

				local var_5_2 = var_3_10003.SUBMIT_ACTIVITY_TASK
				local var_5_3 = {}
				local var_5_4 = arg_4_1

				var_5_3.act_id = var_5.getActId(var_5_4)
				var_5_3.task_ids = {
					arg_4_1.id
				}
				var_5_3.callback = arg_5_0

				var_5_1(var_5_0, var_5_2, var_5_3)

				return
			end
		}, function()
			getProxy = var_3_10000
			PlayerProxy = var_3_10001

			local var_6_0 = var_3_10000(var_3_10001)
			local var_6_1 = var_0.getRawData(var_6_0)
			local var_6_2 = var_0.getActivityMedalGroup(var_6_1)
			local var_6_3 = arg_2_0.viewComponent

			var_2.SetMedalGroupData(var_6_3, var_6_2)

			local var_6_4 = arg_2_0.viewComponent

			var_2.UpdateView(var_6_4)

			existCall = var_2

			var_2(arg_4_2)

			return
		end)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	GAME = var_1_10002
	var_7_0[1] = var_1_10002.SUBMIT_ACTIVITY_TASK_DONE

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1
	local var_8_2 = arg_8_1.getBody(var_8_1)

	GAME = var_8_1

	if var_8_0 == var_8_1.SUBMIT_ACTIVITY_TASK_DONE then
		getProxy = var_4
		ContextProxy = var_1_10005

		local var_8_3 = var_4(var_1_10005)

		if var_4.getCurrentContext(var_8_3).mediator.__cname == "WorldMediaCollectionMediator" then
			local var_8_4 = arg_8_0.viewComponent
			local var_8_5 = var_5.emit

			BaseUI = var_1_10007

			var_8_5(var_8_4, var_1_10007.ON_ACHIEVE, var_8_2.awards)
		end

		local var_8_6 = arg_8_0.viewComponent

		var_5.FlushTaskPanel(var_8_6)
	end

	return
end

return var_0_1
