class = var_0_10000

local var_0_0 = "NewEducateTalentMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.newEducate.base.NewEducateContextMediator"))

var_0_1.ON_REFRESH_TALENT = "NewEducateTalentMediator:ON_REFRESH_TALENT"
var_0_1.ON_SELECT_TALENT = "NewEducateTalentMediator:ON_SELECT_TALENT"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_REFRESH_TALENT, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.NEW_EDUCATE_REFRESH_TALENT, {
			id = arg_1_0.contextData.char.id,
			talentId = arg_2_1,
			idx = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SELECT_TALENT, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10006

		var_3_1(var_3_0, var_2_10006.NEW_EDUCATE_SEL_TALENT, {
			id = arg_1_0.contextData.char.id,
			talentId = arg_3_1,
			idx = arg_3_2
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[1] = var_1_10002.NEW_EDUCATE_REFRESH_TALENT_DONE
	GAME = var_2
	var_4_0[2] = var_2.NEW_EDUCATE_SEL_TALENT_DONE

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.getName(var_5_0)
	local var_5_2 = arg_5_1:getBody()

	GAME = var_5_0

	if var_5_1 == var_5_0.NEW_EDUCATE_REFRESH_TALENT_DONE then
		local var_5_3 = arg_5_0.viewComponent

		var_4.OnRefreshTalent(var_5_3, var_5_2.idx, var_5_2.newId)
	else
		GAME = var_4

		if var_5_1 == var_4.NEW_EDUCATE_SEL_TALENT_DONE then
			local var_5_4 = arg_5_0.viewComponent

			var_4.OnSelectedDone(var_5_4, var_5_2)
		end
	end

	return
end

return var_0_1
