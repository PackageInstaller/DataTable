local TransitionMediator = class("TransitionMediator", import("..base.ContextMediator"))

TransitionMediator.FINISH = "TransitionMediator:FINISH"

function TransitionMediator:register()
	return
end

function TransitionMediator:remove()
	return
end

function TransitionMediator:listNotificationInterests()
	return {
		GAME.LOAD_SCENE_DONE,
		GAME.BEGIN_STAGE_DONE
	}
end

function TransitionMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == GAME.LOAD_SCENE_DONE then
		if var_4_1 == SCENE.TRANSITION then
			self.contextData.afterLoadFunc()
		end
	elseif var_4_0 == GAME.BEGIN_STAGE_DONE then
		local var_4_2 = getProxy(ContextProxy):getContextByMediator(BattleMediator)

		if var_4_2 then
			getProxy(ContextProxy):RemoveContext(var_4_2)
		end

		self:sendNotification(GAME.CHANGE_SCENE, SCENE.COMBATLOAD, var_4_1)
	end

	return
end

return TransitionMediator
