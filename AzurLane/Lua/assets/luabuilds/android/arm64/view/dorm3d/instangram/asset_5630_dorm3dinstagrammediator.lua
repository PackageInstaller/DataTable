class = var_0_10000

local var_0_0 = "Dorm3dInstagramMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_DISCUSS = "Dorm3dInstagramMediator:ON_DISCUSS"
var_0_1.ON_READ = "Dorm3dInstagramMediator:ON_READ"
var_0_1.ON_LIKE = "Dorm3dInstagramMediator:ON_LIKE"
var_0_1.ON_SHARE = "Dorm3dInstagramMediator:ON_SHARE"
var_0_1.ON_EXIT = "Dorm3dInstagramMediator:ON_EXIT"
var_0_1.BACK_PRESSED = "Dorm3dInstagramMediator:BACK_PRESSED"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_DISCUSS, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = arg_1_0
		local var_2_1 = var_4.sendNotification

		GAME = var_2_10007

		local var_2_2 = var_2_10007.APARTMENT_INS_OP
		local var_2_3 = {
			shipId = arg_1_0.contextData.apartmentGroupId
		}

		Instagram3Dorm = var_9
		var_2_3.op = var_9.OP_DISCUSS
		var_2_3.id = arg_2_1
		var_2_3.commentId = arg_2_2
		var_2_3.index = arg_2_3

		var_2_1(var_2_0, var_2_2, var_2_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_READ, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_3_2 = var_2_10005.APARTMENT_INS_OP
		local var_3_3 = {
			shipId = arg_1_0.contextData.apartmentGroupId
		}

		Instagram3Dorm = var_7
		var_3_3.op = var_7.OP_READ
		var_3_3.id = arg_3_1

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_LIKE, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_4_2 = var_2_10005.APARTMENT_INS_OP
		local var_4_3 = {
			shipId = arg_1_0.contextData.apartmentGroupId
		}

		Instagram3Dorm = var_7
		var_4_3.op = var_7.OP_LIKE
		var_4_3.id = arg_4_1

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SHARE, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_5_2 = var_2_10005.APARTMENT_INS_OP
		local var_5_3 = {
			shipId = arg_1_0.contextData.apartmentGroupId
		}

		Instagram3Dorm = var_7
		var_5_3.op = var_7.OP_SHARE
		var_5_3.id = arg_5_1

		var_5_1(var_5_0, var_5_2, var_5_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_EXIT, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_6_2 = var_2_10005.APARTMENT_INS_OP
		local var_6_3 = {
			shipId = arg_1_0.contextData.apartmentGroupId
		}

		Instagram3Dorm = var_7
		var_6_3.op = var_7.OP_EXIT
		var_6_3.id = arg_6_1

		var_6_1(var_6_0, var_6_2, var_6_3)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	GAME = var_1_10002
	var_7_0[1] = var_1_10002.APARTMENT_INS_OP_DONE
	var_7_0[2] = var_0_1.BACK_PRESSED

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.getName(var_8_0)
	local var_8_2 = arg_8_1
	local var_8_3 = arg_8_1.getBody(var_8_2)

	GAME = var_8_0

	if var_8_1 == var_8_0.APARTMENT_INS_OP_DONE then
		local var_8_4 = var_8_3.op

		Instagram3Dorm = var_8_2

		if var_8_4 == var_8_2.OP_DISCUSS then
			local var_8_5 = arg_8_0.viewComponent

			var_4.UpdateCommentList(var_8_5)
		else
			local var_8_6 = var_8_3.op

			Instagram3Dorm = var_5

			if var_8_6 == var_5.OP_READ then
				-- block empty
			else
				local var_8_7 = var_8_3.op

				Instagram3Dorm = var_5

				if var_8_7 == var_5.OP_LIKE then
					local var_8_8 = arg_8_0.viewComponent

					var_4.OnLikeInstagram(var_8_8)
				else
					local var_8_9 = var_8_3.op

					Instagram3Dorm = var_5

					if var_8_9 == var_5.OP_SHARE then
						-- block empty
					else
						local var_8_10 = var_8_3.op

						Instagram3Dorm = var_5

						if var_8_10 == var_5.OP_EXIT then
							-- block empty
						end
					end
				end
			end
		end
	elseif var_8_1 == var_0_1.BACK_PRESSED then
		local var_8_11 = arg_8_0.viewComponent

		var_4.onBackPressed(var_8_11)
	end

	return
end

return var_0_1
