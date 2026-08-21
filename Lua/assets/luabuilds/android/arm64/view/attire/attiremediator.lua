local var_0_0 = class("AttireMediator", import("..base.ContextMediator"))

var_0_0.ON_APPLY = "AttireMediator:ON_APPLY"
var_0_0.ON_UNLOCK = "AttireMediator:ON_UNLOCK"
var_0_0.ON_CHANGE_MEDAL_DISPLAY = "AttireMediator:ON_CHANGE_MEDAL_DISPLAY"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_APPLY, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.ATTIRE_APPLY, {
			id = arg_2_2,
			type = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_UNLOCK, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:sendNotification(GAME.GET_ATTIRE, {
			id = arg_3_2,
			type = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_CHANGE_MEDAL_DISPLAY, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.CHANGE_PLAYER_MEDAL_DISPLAY, {
			medalList = arg_4_1
		})

		return
	end)
	arg_1_0.viewComponent:setAttires(getProxy(AttireProxy):getDataAndTrophys(true))
	arg_1_0.viewComponent:setPlayer(getProxy(PlayerProxy):getData())

	return
end

function var_0_0.updateCurrPage(arg_5_0)
	arg_5_0.viewComponent:setAttires(getProxy(AttireProxy):getDataAndTrophys())
	arg_5_0.viewComponent:updateCurrPage()

	return
end

function var_0_0.listNotificationInterests(arg_6_0)
	return {
		AttireProxy.ATTIREFRAME_EXPIRED,
		GAME.ATTIRE_APPLY_DONE,
		PlayerProxy.UPDATED,
		GAME.GET_ATTIRE_DONE,
		GAME.CHANGE_PLAYER_MEDAL_DISPLAY_DONE
	}
end

function var_0_0.handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:getName()
	local var_7_1 = arg_7_1:getBody()

	if var_7_0 == AttireProxy.ATTIREFRAME_EXPIRED then
		if arg_7_0.viewComponent.page == AttireScene.PAGE_ICONFRAME or arg_7_0.viewComponent.page == AttireScene.PAGE_CHATFRAME then
			arg_7_0:updateCurrPage()
		end

		goto label_7_0
	end

	if var_7_0 == GAME.ATTIRE_APPLY_DONE then
		arg_7_0:updateCurrPage()
		pg.TipsMgr.GetInstance():ShowTips(i18n("dress_up_success"))

		goto label_7_0
	end

	::label_7_0::

	if var_7_0 ~= PlayerProxy.UPDATED then
		if var_7_0 == GAME.CHANGE_PLAYER_MEDAL_DISPLAY_DONE then
			arg_7_0.viewComponent:setPlayer(getProxy(PlayerProxy):getData())
			arg_7_0:updateCurrPage()
		elseif var_7_0 == GAME.GET_ATTIRE_DONE then
			arg_7_0:updateCurrPage()
		end

		return
	end
end

return var_0_0
