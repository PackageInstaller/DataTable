local SculptureMediator = class("SculptureMediator", import("view.base.ContextMediator"))

SculptureMediator.ON_UNLOCK_SCULPTURE = "SculptureMediator:ON_UNLOCK_SCULPTURE"
SculptureMediator.ON_DRAW_SCULPTURE = "SculptureMediator:ON_DRAW_SCULPTURE"
SculptureMediator.ON_JOINT_SCULPTURE = "SculptureMediator:ON_JOINT_SCULPTURE"
SculptureMediator.ON_FINSIH_SCULPTURE = "SculptureMediator:ON_FINSIH_SCULPTURE"

function SculptureMediator:register()
	self:bind(SculptureMediator.ON_FINSIH_SCULPTURE, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.SCULPTURE_ACT_OP, {
			id = arg_2_1,
			state = SculptureActivity.STATE_FINSIH
		})

		return
	end)
	self:bind(SculptureMediator.ON_JOINT_SCULPTURE, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.SCULPTURE_ACT_OP, {
			id = arg_3_1,
			state = SculptureActivity.STATE_JOINT
		})

		return
	end)
	self:bind(SculptureMediator.ON_UNLOCK_SCULPTURE, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.SCULPTURE_ACT_OP, {
			id = arg_4_1,
			state = SculptureActivity.STATE_UNLOCK
		})

		return
	end)
	self:bind(SculptureMediator.ON_DRAW_SCULPTURE, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.SCULPTURE_ACT_OP, {
			id = arg_5_1,
			state = SculptureActivity.STATE_DRAW
		})

		return
	end)
	self.viewComponent:SetActivity((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_SCULPTURE)))

	return
end

function SculptureMediator:listNotificationInterests()
	return {
		GAME.SCULPTURE_ACT_OP_DONE
	}
end

function SculptureMediator:handleNotification(arg_7_1)
	local var_7_0 = arg_7_1:getBody()

	if arg_7_1:getName() == GAME.SCULPTURE_ACT_OP_DONE then
		self.viewComponent:OnUpdateActivity(var_7_0.state, var_7_0.id, var_7_0.activity)

		if #var_7_0.awards > 0 then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_7_0.awards)
		end
	end

	return
end

return SculptureMediator
