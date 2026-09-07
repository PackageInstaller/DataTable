local WorldInPictureMediator = class("WorldInPictureMediator", import("...base.ContextMediator"))

WorldInPictureMediator.ON_TRAVEL = "WorldInPictureMediator:ON_TRAVEL"
WorldInPictureMediator.ON_DRAW = "WorldInPictureMediator:ON_DRAW"
WorldInPictureMediator.ON_AUTO_TRAVEL = "WorldInPictureMediator:ON_AUTO_TRAVEL"
WorldInPictureMediator.ON_AUTO_DRAW = "WorldInPictureMediator:ON_AUTO_DRAW"
WorldInPictureMediator.RESULT_ONEKEY_AWARD = "WorldInPictureMediator:RESULT_ONEKEY_AWARD"

function WorldInPictureMediator:register()
	self:bind(WorldInPictureMediator.ON_AUTO_TRAVEL, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		self:sendNotification(GAME.WORLDIN_PICTURE_OP, {
			auto = true,
			cmd = ActivityConst.WORLDINPICTURE_OP_TURN,
			arg1 = arg_2_1,
			arg2 = arg_2_2,
			index = arg_2_3
		})

		return
	end)
	self:bind(WorldInPictureMediator.ON_AUTO_DRAW, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		self:sendNotification(GAME.WORLDIN_PICTURE_OP, {
			auto = true,
			cmd = ActivityConst.WORLDINPICTURE_OP_DRAW,
			arg1 = arg_3_1,
			arg2 = arg_3_2,
			index = arg_3_3
		})

		return
	end)
	self:bind(WorldInPictureMediator.ON_TRAVEL, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		self:sendNotification(GAME.WORLDIN_PICTURE_OP, {
			cmd = ActivityConst.WORLDINPICTURE_OP_TURN,
			arg1 = arg_4_1,
			arg2 = arg_4_2,
			index = arg_4_3
		})

		return
	end)
	self:bind(WorldInPictureMediator.ON_DRAW, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		self:sendNotification(GAME.WORLDIN_PICTURE_OP, {
			cmd = ActivityConst.WORLDINPICTURE_OP_DRAW,
			arg1 = arg_5_1,
			arg2 = arg_5_2,
			index = arg_5_3
		})

		return
	end)
	self:bind(WorldInPictureMediator.RESULT_ONEKEY_AWARD, function(arg_6_0)
		if #self.cacheAwards > 0 then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, self.cacheAwards, function()
				self.cacheAwards = {}

				return
			end)
		end

		return
	end)

	self.cacheAwards = {}

	self.viewComponent:SetData((WorldInPictureActiviyData.New((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_WORLDINPICTURE)))))

	return
end

function WorldInPictureMediator:listNotificationInterests()
	return {
		GAME.WORLDIN_PICTURE_OP_DONE,
		GAME.WORLDIN_PICTURE_OP_ERRO
	}
end

function WorldInPictureMediator:handleNotification(arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	if var_9_0 == GAME.WORLDIN_PICTURE_OP_DONE then
		self.viewComponent:SetData((WorldInPictureActiviyData.New(var_9_1.activity)))

		if #var_9_1.awards > 0 then
			if not var_9_1.auto then
				self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_9_1.awards)
			else
				for iter_9_0, iter_9_1 in ipairs(var_9_1.awards) do
					table.insert(self.cacheAwards, iter_9_1)
				end
			end
		end

		if var_9_1.cmd == ActivityConst.WORLDINPICTURE_OP_TURN then
			self.viewComponent:OnOpenCell(var_9_1.arg1, var_9_1.arg2, var_9_1.auto)
		elseif var_9_1.cmd == ActivityConst.WORLDINPICTURE_OP_DRAW then
			self.viewComponent:OnDrawArea(var_9_1.arg1, var_9_1.arg2, var_9_1.auto)
		end
	elseif var_9_0 == GAME.WORLDIN_PICTURE_OP_ERRO then
		if var_9_1.cmd == ActivityConst.WORLDINPICTURE_OP_TURN then
			self.viewComponent:OnOpenCellErro(var_9_1.auto)
		elseif var_9_1.cmd == ActivityConst.WORLDINPICTURE_OP_DRAW then
			self.viewComponent:OnDrawAreaErro(var_9_1.auto)
		end
	end

	return
end

return WorldInPictureMediator
