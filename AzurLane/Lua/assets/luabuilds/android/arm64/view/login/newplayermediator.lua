local var_0_0 = class("NewPlayerMediator", import("..base.ContextMediator"))

var_0_0.ON_CREATE = "NewPlayerMediator:ON_CREATE"
var_0_0.ON_SKILLINFO = "NewPlayerMediator:ON_SKILLINFO"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_CREATE, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.CREATE_NEW_PLAYER, {
			nickname = arg_2_1,
			shipId = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SKILLINFO, function(arg_3_0, arg_3_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = SkillInfoMediator,
			viewComponent = SkillInfoLayer,
			data = {
				fromNewShip = true,
				skillId = arg_3_1
			}
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		GAME.CREATE_NEW_PLAYER_DONE,
		GAME.LOAD_PLAYER_DATA_DONE
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()

	if var_5_0 == GAME.CREATE_NEW_PLAYER_DONE then
		arg_5_0.facade:sendNotification(GAME.LOAD_PLAYER_DATA, {
			isNewPlayer = true,
			id = arg_5_1:getBody()
		})
	elseif var_5_0 == GAME.LOAD_PLAYER_DATA_DONE then
		arg_5_0:sendNotification(GAME.GO_SCENE, SCENE.MAINUI)
	end

	return
end

return var_0_0
