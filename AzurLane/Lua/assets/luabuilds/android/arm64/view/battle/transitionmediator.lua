local var_0_0 = class("TransitionMediator", import("..base.ContextMediator"))

var_0_0.FINISH = "TransitionMediator:FINISH"

function var_0_0.register(arg_1_0)
	return
end

function var_0_0.remove(arg_2_0)
	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		GAME.LOAD_SCENE_DONE,
		GAME.BEGIN_STAGE_DONE
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == GAME.LOAD_SCENE_DONE then
		if var_4_1 == SCENE.TRANSITION then
			arg_4_0.contextData.afterLoadFunc()
		end
	elseif var_4_0 == GAME.BEGIN_STAGE_DONE then
		local var_4_2 = getProxy(ContextProxy):getContextByMediator(BattleMediator)

		if var_4_2 then
			getProxy(ContextProxy):RemoveContext(var_4_2)
		end

		arg_4_0:sendNotification(GAME.CHANGE_SCENE, SCENE.COMBATLOAD, var_4_1)
	end

	return
end

return var_0_0
