local Dorm3dInstagramMediator = class("Dorm3dInstagramMediator", import("view.base.ContextMediator"))

Dorm3dInstagramMediator.ON_DISCUSS = "Dorm3dInstagramMediator:ON_DISCUSS"
Dorm3dInstagramMediator.ON_READ = "Dorm3dInstagramMediator:ON_READ"
Dorm3dInstagramMediator.ON_LIKE = "Dorm3dInstagramMediator:ON_LIKE"
Dorm3dInstagramMediator.ON_SHARE = "Dorm3dInstagramMediator:ON_SHARE"
Dorm3dInstagramMediator.ON_EXIT = "Dorm3dInstagramMediator:ON_EXIT"
Dorm3dInstagramMediator.BACK_PRESSED = "Dorm3dInstagramMediator:BACK_PRESSED"

function Dorm3dInstagramMediator:register()
	self:bind(Dorm3dInstagramMediator.ON_DISCUSS, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		self:sendNotification(GAME.APARTMENT_INS_OP, {
			shipId = self.contextData.apartmentGroupId,
			op = Instagram3Dorm.OP_DISCUSS,
			id = arg_2_1,
			commentId = arg_2_2,
			index = arg_2_3
		})

		return
	end)
	self:bind(Dorm3dInstagramMediator.ON_READ, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.APARTMENT_INS_OP, {
			shipId = self.contextData.apartmentGroupId,
			op = Instagram3Dorm.OP_READ,
			id = arg_3_1
		})

		return
	end)
	self:bind(Dorm3dInstagramMediator.ON_LIKE, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.APARTMENT_INS_OP, {
			shipId = self.contextData.apartmentGroupId,
			op = Instagram3Dorm.OP_LIKE,
			id = arg_4_1
		})

		return
	end)
	self:bind(Dorm3dInstagramMediator.ON_SHARE, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.APARTMENT_INS_OP, {
			shipId = self.contextData.apartmentGroupId,
			op = Instagram3Dorm.OP_SHARE,
			id = arg_5_1
		})

		return
	end)
	self:bind(Dorm3dInstagramMediator.ON_EXIT, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.APARTMENT_INS_OP, {
			shipId = self.contextData.apartmentGroupId,
			op = Instagram3Dorm.OP_EXIT,
			id = arg_6_1
		})

		return
	end)

	return
end

function Dorm3dInstagramMediator:listNotificationInterests()
	return {
		GAME.APARTMENT_INS_OP_DONE,
		Dorm3dInstagramMediator.BACK_PRESSED
	}
end

function Dorm3dInstagramMediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == GAME.APARTMENT_INS_OP_DONE then
		if var_8_1.op == Instagram3Dorm.OP_DISCUSS then
			self.viewComponent:UpdateCommentList()
		elseif var_8_1.op == Instagram3Dorm.OP_READ then
			-- block empty
		elseif var_8_1.op == Instagram3Dorm.OP_LIKE then
			self.viewComponent:OnLikeInstagram()
		elseif var_8_1.op == Instagram3Dorm.OP_SHARE then
			-- block empty
		elseif var_8_1.op == Instagram3Dorm.OP_EXIT then
			-- block empty
		end
	elseif var_8_0 == Dorm3dInstagramMediator.BACK_PRESSED then
		self.viewComponent:onBackPressed()
	end

	return
end

return Dorm3dInstagramMediator
