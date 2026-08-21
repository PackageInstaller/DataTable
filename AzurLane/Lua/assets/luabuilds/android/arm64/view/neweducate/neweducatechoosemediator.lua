local var_0_0 = class("NewEducateChooseMediator", import("view.newEducate.base.NewEducateContextMediator"))

var_0_0.ON_REFRESH_CHOICE = "NewEducateChooseMediator.ON_REFRESH_CHOICE"
var_0_0.ON_MAKE_CHOICE = "NewEducateChooseMediator.ON_MAKE_CHOICE"
var_0_0.ON_GIVE_UP_CHOICE = "NewEducateChooseMediator.ON_GIVE_UP_CHOICE"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_REFRESH_CHOICE, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_REFRESH_CHOICE, {
			id = arg_1_0.contextData.char.id,
			idx = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_MAKE_CHOICE, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_MAKE_CHOICE, {
			id = arg_1_0.contextData.char.id,
			idx = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_GIVE_UP_CHOICE, function(arg_4_0)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_GIVE_UP_CHOICE, {
			id = arg_1_0.contextData.char.id
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		GAME.NEW_EDUCATE_REFRESH_CHOICE_DONE,
		GAME.NEW_EDUCATE_MAKE_CHOICE_DONE,
		GAME.NEW_EDUCATE_GIVE_UP_CHOICE_DONE
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == GAME.NEW_EDUCATE_REFRESH_CHOICE_DONE then
		arg_6_0.viewComponent:OnRefreshDone(var_6_1)
	elseif var_6_0 == GAME.NEW_EDUCATE_MAKE_CHOICE_DONE then
		arg_6_0.viewComponent:OnMakeChoiceDone(var_6_1)
	elseif var_6_0 == GAME.NEW_EDUCATE_GIVE_UP_CHOICE_DONE then
		arg_6_0.viewComponent:OnGiveUpDone(var_6_1)
	end

	return
end

return var_0_0
