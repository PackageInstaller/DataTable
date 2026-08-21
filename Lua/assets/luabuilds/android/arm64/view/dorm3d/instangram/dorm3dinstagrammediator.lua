local var_0_0 = class("Dorm3dInstagramMediator", import("view.base.ContextMediator"))

var_0_0.ON_DISCUSS = "Dorm3dInstagramMediator:ON_DISCUSS"
var_0_0.ON_READ = "Dorm3dInstagramMediator:ON_READ"
var_0_0.ON_LIKE = "Dorm3dInstagramMediator:ON_LIKE"
var_0_0.ON_SHARE = "Dorm3dInstagramMediator:ON_SHARE"
var_0_0.ON_EXIT = "Dorm3dInstagramMediator:ON_EXIT"
var_0_0.BACK_PRESSED = "Dorm3dInstagramMediator:BACK_PRESSED"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_DISCUSS, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		arg_1_0:sendNotification(GAME.APARTMENT_INS_OP, {
			shipId = arg_1_0.contextData.apartmentGroupId,
			op = Instagram3Dorm.OP_DISCUSS,
			id = arg_2_1,
			commentId = arg_2_2,
			index = arg_2_3
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_READ, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.APARTMENT_INS_OP, {
			shipId = arg_1_0.contextData.apartmentGroupId,
			op = Instagram3Dorm.OP_READ,
			id = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_LIKE, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.APARTMENT_INS_OP, {
			shipId = arg_1_0.contextData.apartmentGroupId,
			op = Instagram3Dorm.OP_LIKE,
			id = arg_4_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SHARE, function(arg_5_0, arg_5_1)
		arg_1_0:sendNotification(GAME.APARTMENT_INS_OP, {
			shipId = arg_1_0.contextData.apartmentGroupId,
			op = Instagram3Dorm.OP_SHARE,
			id = arg_5_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_EXIT, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.APARTMENT_INS_OP, {
			shipId = arg_1_0.contextData.apartmentGroupId,
			op = Instagram3Dorm.OP_EXIT,
			id = arg_6_1
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		GAME.APARTMENT_INS_OP_DONE,
		var_0_0.BACK_PRESSED
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == GAME.APARTMENT_INS_OP_DONE then
		if var_8_1.op == Instagram3Dorm.OP_DISCUSS then
			arg_8_0.viewComponent:UpdateCommentList()
		elseif var_8_1.op == Instagram3Dorm.OP_READ then
			-- block empty
		elseif var_8_1.op == Instagram3Dorm.OP_LIKE then
			arg_8_0.viewComponent:OnLikeInstagram()
		elseif var_8_1.op == Instagram3Dorm.OP_SHARE then
			-- block empty
		elseif var_8_1.op == Instagram3Dorm.OP_EXIT then
			-- block empty
		end
	elseif var_8_0 == var_0_0.BACK_PRESSED then
		arg_8_0.viewComponent:onBackPressed()
	end

	return
end

return var_0_0
