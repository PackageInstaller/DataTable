local var_0_0 = class("NewEducateTalentMediator", import("view.newEducate.base.NewEducateContextMediator"))

var_0_0.ON_REFRESH_TALENT = "NewEducateTalentMediator:ON_REFRESH_TALENT"
var_0_0.ON_SELECT_TALENT = "NewEducateTalentMediator:ON_SELECT_TALENT"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_REFRESH_TALENT, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_REFRESH_TALENT, {
			id = arg_1_0.contextData.char.id,
			talentId = arg_2_1,
			idx = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SELECT_TALENT, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_SEL_TALENT, {
			id = arg_1_0.contextData.char.id,
			talentId = arg_3_1,
			idx = arg_3_2
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		GAME.NEW_EDUCATE_REFRESH_TALENT_DONE,
		GAME.NEW_EDUCATE_SEL_TALENT_DONE
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GAME.NEW_EDUCATE_REFRESH_TALENT_DONE then
		arg_5_0.viewComponent:OnRefreshTalent(var_5_1.idx, var_5_1.newId)
	elseif var_5_0 == GAME.NEW_EDUCATE_SEL_TALENT_DONE then
		arg_5_0.viewComponent:OnSelectedDone(var_5_1)
	end

	return
end

return var_0_0
