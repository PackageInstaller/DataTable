local KindergartenMediator = class("KindergartenMediator", import("view.base.ContextMediator"))

KindergartenMediator.GO_SCENE = "KindergartenMediator.GO_SCENE"
KindergartenMediator.GO_SUBLAYER = "KindergartenMediator.GO_SUBLAYER"
KindergartenMediator.ON_EXTRA_RANK = "KindergartenMediator.ON_EXTRA_RANK"

function KindergartenMediator:register()
	self:bind(KindergartenMediator.GO_SCENE, function(arg_2_0, arg_2_1, ...)
		self:sendNotification(GAME.GO_SCENE, arg_2_1, ...)

		return
	end)
	self:bind(KindergartenMediator.GO_SUBLAYER, function(arg_3_0, arg_3_1, arg_3_2)
		self:addSubLayers(arg_3_1, nil, arg_3_2)

		return
	end)
	self:bind(KindergartenMediator.ON_EXTRA_RANK, function(arg_4_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.BILLBOARD, {
			page = PowerRank.TYPE_BOSSRUSH
		})

		return
	end)

	return
end

function KindergartenMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}
end

function KindergartenMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()

	if var_6_0 == ActivityProxy.ACTIVITY_UPDATED then
		if arg_6_1:getBody().id == ActivityConst.ALVIT_PT_ACT_ID then
			self.viewComponent:UpdatePt()
		end
	elseif var_6_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		self.viewComponent:UpdateTask()
	end

	return
end

return KindergartenMediator
