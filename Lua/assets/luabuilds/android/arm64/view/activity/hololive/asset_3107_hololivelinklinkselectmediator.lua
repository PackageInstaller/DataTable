local HoloLiveLinkLinkSelectMediator = class("HoloLiveLinkLinkSelectMediator", import("view.base.ContextMediator"))

HoloLiveLinkLinkSelectMediator.HUB_ID = 3

function HoloLiveLinkLinkSelectMediator:register()
	self:BindEvent()
	self:requestDataFromServer()

	return
end

function HoloLiveLinkLinkSelectMediator:requestDataFromServer()
	pg.ConnectionMgr.GetInstance():Send(26101, {
		type = MiniGameRequestCommand.REQUEST_HUB_DATA
	}, 26102, function(arg_3_0)
		local var_3_0 = getProxy(MiniGameProxy)

		for iter_3_0, iter_3_1 in ipairs(arg_3_0.hubs) do
			if iter_3_1.id == HoloLiveLinkLinkSelectMediator.HUB_ID then
				var_3_0:UpdataHubData(iter_3_1)
			end
		end

		return
	end)

	return
end

function HoloLiveLinkLinkSelectMediator:BindEvent()
	return
end

function HoloLiveLinkLinkSelectMediator:listNotificationInterests()
	return {
		MiniGameProxy.ON_HUB_DATA_UPDATE,
		GAME.SEND_MINI_GAME_OP_DONE
	}
end

function HoloLiveLinkLinkSelectMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == MiniGameProxy.ON_HUB_DATA_UPDATE then
		if var_6_1.id == HoloLiveLinkLinkSelectScene.HOLOLIVE_LINKGAME_HUB_ID then
			self.viewComponent:updateData()
			self.viewComponent:updateUI()
		end
	elseif var_6_0 == GAME.SEND_MINI_GAME_OP_DONE and var_6_1.cmd == MiniGameOPCommand.CMD_ULTIMATE then
		seriesAsync({
			function(arg_7_0)
				if #var_6_1.awards > 0 then
					self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_1.awards, arg_7_0)
				else
					arg_7_0()
				end

				return
			end,
			function(arg_8_0)
				self.viewComponent:updateData()
				self.viewComponent:updateUI()

				return
			end
		})
	end

	return
end

return HoloLiveLinkLinkSelectMediator
