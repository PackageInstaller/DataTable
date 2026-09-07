local MiniHubMediator = class("MiniHubMediator", import("..BaseMiniGameMediator"))

function MiniHubMediator:register()
	MiniHubMediator.super.register(self)
	self.viewComponent:SetExtraData({})

	return
end

function MiniHubMediator:OnMiniGameOPeration(arg_2_1, arg_2_2)
	self:sendNotification(GAME.SEND_MINI_GAME_OP, {
		hubid = self.miniGameProxy:GetHubByGameId(self.miniGameId).id,
		cmd = arg_2_1,
		args1 = arg_2_2
	})

	return
end

function MiniHubMediator:OnMiniGameSuccess(arg_3_1)
	if self.gameRoomData then
		if self.gameRoonCoinCount and self.gameRoonCoinCount == 0 then
			return
		end

		local var_3_0 = self.gameRoonCoinCount
		local var_3_1

		if not self.gameRoonCoinCount then
			var_3_0 = 1
			var_3_1 = {}
		end

		var_3_1.roomId = self.gameRoomData.id
		var_3_1.times = var_3_0
		var_3_1.score = arg_3_1

		self:sendNotification(GAME.GAME_ROOM_SUCCESS, var_3_1)
	else
		local var_3_2 = self.miniGameProxy:GetHubByGameId(self.miniGameId)

		if var_3_2.count <= 0 then
			return
		end

		local var_3_3 = arg_3_1 and type(arg_3_1) == "table" and arg_3_1 or {
			arg_3_1
		}

		self:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = var_3_2.id,
			cmd = MiniGameOPCommand.CMD_COMPLETE,
			args1 = var_3_3,
			id = self.miniGameId
		})
	end

	return
end

function MiniHubMediator:OnMiniGameFailure(arg_4_1)
	return
end

function MiniHubMediator:listNotificationInterests()
	local var_5_0 = {
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}

	table.insertto(var_5_0, MiniHubMediator.super.listNotificationInterests(self))

	return var_5_0
end

function MiniHubMediator:handleNotification(arg_6_1)
	MiniHubMediator.super.handleNotification(self, arg_6_1)

	local var_6_0 = arg_6_1:getName()

	if var_6_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_6_1:getBody().awards)

		if self.viewComponent.ShowTask then
			self.viewComponent:ShowTask()
		end
	elseif var_6_0 == GAME.SEND_MINI_GAME_OP_DONE and self.viewComponent.OnSendMiniGameOPDoneShrine then
		self.viewComponent:OnSendMiniGameOPDoneShrine()
	end

	return
end

return MiniHubMediator
