local YoumiyaStrongholdMediator = class("YoumiyaStrongholdMediator", import("view.base.ContextMediator"))

YoumiyaStrongholdMediator.MAKE_FURNITURE = "YoumiyaStrongholdMediator.MAKE_FURNITURE"
YoumiyaStrongholdMediator.GET_AWARD = "YoumiyaStrongholdMediator.GET_AWARD"
YoumiyaStrongholdMediator.YOUMIA_GO_SCENE = "YoumiyaStrongholdMediator.YOUMIA_GO_SCENE"

function YoumiyaStrongholdMediator:register()
	self:bind(YoumiyaStrongholdMediator.MAKE_FURNITURE, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = ActivityConst.YUMIA_BASE_ACT_ID,
			arg1 = arg_2_1,
			consumes = arg_2_2
		})

		return
	end)
	self:bind(YoumiyaStrongholdMediator.GET_AWARD, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 2,
			activity_id = ActivityConst.YUMIA_BASE_ACT_ID,
			arg1 = arg_3_1,
			canGetIndex = arg_3_2
		})

		return
	end)
	self:bind(YoumiyaStrongholdMediator.YOUMIA_GO_SCENE, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.GO_SCENE, arg_4_1, arg_4_2)

		return
	end)

	return
end

function YoumiyaStrongholdMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_OPERATION_DONE
	}
end

function YoumiyaStrongholdMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getBody()

	if arg_6_1:getName() == ActivityProxy.ACTIVITY_OPERATION_DONE then
		self.viewComponent:RefreshView()
	end

	return
end

return YoumiyaStrongholdMediator
