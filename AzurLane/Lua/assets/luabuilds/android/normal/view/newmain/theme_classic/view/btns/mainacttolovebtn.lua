class = var_0_10000

local var_0_0 = "MainActToLoveBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBaseActivityBtn"))

function var_0_1.GetEventName(arg_1_0)
	return "event_tolove"
end

function var_0_1.GetActivityID(arg_2_0)
	checkExist = var_1_10001

	if not var_1_10001(arg_2_0.config, {
		"time"
	}) then
		return nil
	end

	local var_2_0

	if var_1[1] ~= "default" or not var_1[2] then
		var_2_0 = nil
	end

	return var_2_0
end

function var_0_1.OnClick(arg_3_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)
	local var_3_1 = var_1.getActivityById

	ActivityConst = var_1_10003

	if var_3_1(var_3_0, var_1_10003.TOLOVE_MINIGAME_TASK_ID) == nil or var_1:isEnd() then
		pg = var_3_0

		local var_3_2 = var_3_0.m02
		local var_3_3 = var_2.sendNotification

		GAME = var_1_10004

		local var_3_4 = var_1_10004.LOAD_LAYERS
		local var_3_5 = {}

		getProxy = var_1_10006
		ContextProxy = var_1_10007

		local var_3_6 = var_1_10006(var_1_10007)

		var_3_5.parentContext = var_6.getCurrentContext(var_3_6)
		Context = var_6

		local var_3_7 = var_6.New
		local var_3_8 = {}

		MedalCollectionTemplateMediator = var_1_10008
		var_3_8.mediator = var_1_10008
		ToLoveCollabMedalView = var_1_10008
		var_3_8.viewComponent = var_1_10008
		var_3_5.context = var_3_7(var_3_8)

		var_3_3(var_3_2, var_3_4, var_3_5)
	else
		var_0_1.super.OnClick(arg_3_0)
	end

	return
end

function var_0_1.OnInit(arg_4_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_4_0 = var_1_10001(var_1_10002)
	local var_4_1 = var_1.getActivityById

	ActivityConst = var_1_10003

	if var_4_1(var_4_0, var_1_10003.TOLOVE_MINIGAME_TASK_ID) ~= nil then
		local var_4_2 = var_1

		if not var_1.isEnd(var_4_2) then
			ToLoveCollabBackHillScene = var_4_0
			var_4_0 = var_4_0.IsShowMainTip()
			setActive = var_4_2

			var_4_2(arg_4_0.tipTr.gameObject, var_4_0)

			goto label_4_0
		end
	end

	setActive = var_4_0

	var_4_0(arg_4_0.tipTr.gameObject, false)

	::label_4_0::

	return
end

return var_0_1
