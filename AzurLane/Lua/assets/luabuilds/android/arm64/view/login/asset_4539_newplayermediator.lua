class = var_0_10000

local var_0_0 = "NewPlayerMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.ON_CREATE = "NewPlayerMediator:ON_CREATE"
var_0_1.ON_SKILLINFO = "NewPlayerMediator:ON_SKILLINFO"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_CREATE, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.CREATE_NEW_PLAYER, {
			nickname = arg_2_1,
			shipId = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SKILLINFO, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_3_2 = var_2_10005.New
		local var_3_3 = {}

		SkillInfoMediator = var_2_10008
		var_3_3.mediator = var_2_10008
		SkillInfoLayer = var_2_10008
		var_3_3.viewComponent = var_2_10008
		var_3_3.data = {
			fromNewShip = true,
			skillId = arg_3_1
		}

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[1] = var_1_10002.CREATE_NEW_PLAYER_DONE
	GAME = var_2
	var_4_0[2] = var_2.LOAD_PLAYER_DATA_DONE

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.getName(var_5_0)
	local var_5_2 = arg_5_1:getBody()

	GAME = var_5_0

	local var_5_4

	if var_5_1 == var_5_0.CREATE_NEW_PLAYER_DONE then
		local var_5_3 = arg_5_0.facade

		var_5_4 = var_5_4.sendNotification
		GAME = var_1_10007

		var_5_4(var_5_3, var_1_10007.LOAD_PLAYER_DATA, {
			isNewPlayer = true,
			id = var_5_2
		})
	else
		GAME = var_5_4

		if var_5_1 == var_5_4.LOAD_PLAYER_DATA_DONE then
			local var_5_5 = arg_5_0
			local var_5_6 = arg_5_0.sendNotification

			GAME = var_1_10007

			local var_5_7 = var_1_10007.GO_SCENE

			SCENE = var_1_10008

			var_5_6(var_5_5, var_5_7, var_1_10008.MAINUI)
		end
	end

	return
end

return var_0_1
