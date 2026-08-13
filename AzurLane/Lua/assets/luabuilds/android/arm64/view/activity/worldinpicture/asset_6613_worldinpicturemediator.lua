class = var_0_10000

local var_0_0 = "WorldInPictureMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.ON_TRAVEL = "WorldInPictureMediator:ON_TRAVEL"
var_0_1.ON_DRAW = "WorldInPictureMediator:ON_DRAW"
var_0_1.ON_AUTO_TRAVEL = "WorldInPictureMediator:ON_AUTO_TRAVEL"
var_0_1.ON_AUTO_DRAW = "WorldInPictureMediator:ON_AUTO_DRAW"
var_0_1.RESULT_ONEKEY_AWARD = "WorldInPictureMediator:RESULT_ONEKEY_AWARD"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_AUTO_TRAVEL, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = arg_1_0
		local var_2_1 = var_4.sendNotification

		GAME = var_2_10007

		local var_2_2 = var_2_10007.WORLDIN_PICTURE_OP
		local var_2_3 = {
			auto = true
		}

		ActivityConst = var_2_10009
		var_2_3.cmd = var_2_10009.WORLDINPICTURE_OP_TURN
		var_2_3.arg1 = arg_2_1
		var_2_3.arg2 = arg_2_2
		var_2_3.index = arg_2_3

		var_2_1(var_2_0, var_2_2, var_2_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_AUTO_DRAW, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		local var_3_0 = arg_1_0
		local var_3_1 = var_4.sendNotification

		GAME = var_2_10007

		local var_3_2 = var_2_10007.WORLDIN_PICTURE_OP
		local var_3_3 = {
			auto = true
		}

		ActivityConst = var_2_10009
		var_3_3.cmd = var_2_10009.WORLDINPICTURE_OP_DRAW
		var_3_3.arg1 = arg_3_1
		var_3_3.arg2 = arg_3_2
		var_3_3.index = arg_3_3

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_TRAVEL, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		local var_4_0 = arg_1_0
		local var_4_1 = var_4.sendNotification

		GAME = var_2_10007

		local var_4_2 = var_2_10007.WORLDIN_PICTURE_OP
		local var_4_3 = {}

		ActivityConst = var_2_10009
		var_4_3.cmd = var_2_10009.WORLDINPICTURE_OP_TURN
		var_4_3.arg1 = arg_4_1
		var_4_3.arg2 = arg_4_2
		var_4_3.index = arg_4_3

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_DRAW, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		local var_5_0 = arg_1_0
		local var_5_1 = var_4.sendNotification

		GAME = var_2_10007

		local var_5_2 = var_2_10007.WORLDIN_PICTURE_OP
		local var_5_3 = {}

		ActivityConst = var_2_10009
		var_5_3.cmd = var_2_10009.WORLDINPICTURE_OP_DRAW
		var_5_3.arg1 = arg_5_1
		var_5_3.arg2 = arg_5_2
		var_5_3.index = arg_5_3

		var_5_1(var_5_0, var_5_2, var_5_3)

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.RESULT_ONEKEY_AWARD, function(arg_6_0)
		if #arg_1_0.cacheAwards > 0 then
			local var_6_0 = arg_1_0.viewComponent
			local var_6_1 = var_1.emit

			BaseUI = var_2_10004

			var_6_1(var_6_0, var_2_10004.ON_ACHIEVE, arg_1_0.cacheAwards, function()
				arg_1_0.cacheAwards = {}

				return
			end)
		end

		return
	end)

	arg_1_0.cacheAwards = {}
	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityByType

	ActivityConst = var_4

	local var_1_3 = var_1_2(var_1_1, var_4.ACTIVITY_TYPE_WORLDINPICTURE)

	WorldInPictureActiviyData = var_1_10002

	local var_1_4 = var_1_10002.New(var_1_3)
	local var_1_5 = arg_1_0.viewComponent

	var_3.SetData(var_1_5, var_1_4)

	return
end

function var_0_1.listNotificationInterests(arg_8_0)
	local var_8_0 = {}

	GAME = var_1_10002
	var_8_0[1] = var_1_10002.WORLDIN_PICTURE_OP_DONE
	GAME = var_2
	var_8_0[2] = var_2.WORLDIN_PICTURE_OP_ERRO

	return var_8_0
end

function var_0_1.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1
	local var_9_1 = arg_9_1.getName(var_9_0)
	local var_9_2 = arg_9_1
	local var_9_3 = arg_9_1.getBody(var_9_2)

	GAME = var_9_0

	local var_9_4

	if var_9_1 == var_9_0.WORLDIN_PICTURE_OP_DONE then
		WorldInPictureActiviyData = var_9_4
		var_9_4 = var_9_4.New(var_9_3.activity)

		local var_9_5 = arg_9_0.viewComponent

		var_9_2.SetData(var_9_5, var_9_4)

		var_9_2 = #var_9_3.awards

		if 0 < var_9_2 then
			if not var_9_3.auto then
				local var_9_6 = arg_9_0.viewComponent

				var_9_2 = var_9_2.emit
				BaseUI = var_8

				var_9_2(var_9_6, var_8.ON_ACHIEVE, var_9_3.awards)
			else
				ipairs = var_9_2

				for iter_9_0, iter_9_1 in var_9_2(var_9_3.awards) do
					table = var_1_10010

					var_1_10010.insert(arg_9_0.cacheAwards, iter_9_1)
				end
			end
		end

		var_9_2 = var_9_3.cmd
		ActivityConst = var_6

		if var_9_2 == var_6.WORLDINPICTURE_OP_TURN then
			local var_9_7 = arg_9_0.viewComponent

			var_9_2.OnOpenCell(var_9_7, var_9_3.arg1, var_9_3.arg2, var_9_3.auto)
		else
			var_9_2 = var_9_3.cmd
			ActivityConst = var_6

			if var_9_2 == var_6.WORLDINPICTURE_OP_DRAW then
				local var_9_8 = arg_9_0.viewComponent

				var_9_2.OnDrawArea(var_9_8, var_9_3.arg1, var_9_3.arg2, var_9_3.auto)
			end
		end
	else
		GAME = var_9_4

		if var_9_1 == var_9_4.WORLDIN_PICTURE_OP_ERRO then
			local var_9_9 = var_9_3.cmd

			ActivityConst = var_9_2

			if var_9_9 == var_9_2.WORLDINPICTURE_OP_TURN then
				local var_9_10 = arg_9_0.viewComponent

				var_4.OnOpenCellErro(var_9_10, var_9_3.auto)
			else
				local var_9_11 = var_9_3.cmd

				ActivityConst = var_5

				if var_9_11 == var_5.WORLDINPICTURE_OP_DRAW then
					local var_9_12 = arg_9_0.viewComponent

					var_4.OnDrawAreaErro(var_9_12, var_9_3.auto)
				end
			end
		end
	end

	return
end

return var_0_1
