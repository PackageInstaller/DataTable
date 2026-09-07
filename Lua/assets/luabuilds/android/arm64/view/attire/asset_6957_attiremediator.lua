local AttireMediator = class("AttireMediator", import("..base.ContextMediator"))

AttireMediator.ON_APPLY = "AttireMediator:ON_APPLY"
AttireMediator.ON_UNLOCK = "AttireMediator:ON_UNLOCK"
AttireMediator.ON_CHANGE_MEDAL_DISPLAY = "AttireMediator:ON_CHANGE_MEDAL_DISPLAY"

function AttireMediator:register()
	self:bind(AttireMediator.ON_APPLY, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.ATTIRE_APPLY, {
			id = arg_2_2,
			type = arg_2_1
		})

		return
	end)
	self:bind(AttireMediator.ON_UNLOCK, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.GET_ATTIRE, {
			id = arg_3_2,
			type = arg_3_1
		})

		return
	end)
	self:bind(AttireMediator.ON_CHANGE_MEDAL_DISPLAY, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.CHANGE_PLAYER_MEDAL_DISPLAY, {
			medalList = arg_4_1
		})

		return
	end)
	self.viewComponent:setAttires(getProxy(AttireProxy):getDataAndTrophys(true))
	self.viewComponent:setPlayer(getProxy(PlayerProxy):getData())

	return
end

function AttireMediator:updateCurrPage()
	self.viewComponent:setAttires(getProxy(AttireProxy):getDataAndTrophys())
	self.viewComponent:updateCurrPage()

	return
end

function AttireMediator:listNotificationInterests()
	return {
		AttireProxy.ATTIREFRAME_EXPIRED,
		GAME.ATTIRE_APPLY_DONE,
		PlayerProxy.UPDATED,
		GAME.GET_ATTIRE_DONE,
		GAME.CHANGE_PLAYER_MEDAL_DISPLAY_DONE
	}
end

function AttireMediator:handleNotification(arg_7_1)
	local var_7_0 = arg_7_1:getName()
	local var_7_1 = arg_7_1:getBody()

	if var_7_0 == AttireProxy.ATTIREFRAME_EXPIRED then
		if self.viewComponent.page == AttireScene.PAGE_ICONFRAME or self.viewComponent.page == AttireScene.PAGE_CHATFRAME then
			self:updateCurrPage()
		end
	elseif var_7_0 == GAME.ATTIRE_APPLY_DONE then
		self:updateCurrPage()
		pg.TipsMgr.GetInstance():ShowTips(i18n("dress_up_success"))
	elseif var_7_0 ~= PlayerProxy.UPDATED then
		if var_7_0 == GAME.CHANGE_PLAYER_MEDAL_DISPLAY_DONE then
			self.viewComponent:setPlayer(getProxy(PlayerProxy):getData())
			self:updateCurrPage()
		elseif var_7_0 == GAME.GET_ATTIRE_DONE then
			self:updateCurrPage()
		end
	end

	return
end

return AttireMediator
