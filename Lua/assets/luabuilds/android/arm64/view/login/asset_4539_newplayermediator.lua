local NewPlayerMediator = class("NewPlayerMediator", import("..base.ContextMediator"))

NewPlayerMediator.ON_CREATE = "NewPlayerMediator:ON_CREATE"
NewPlayerMediator.ON_SKILLINFO = "NewPlayerMediator:ON_SKILLINFO"

function NewPlayerMediator:register()
	self:bind(NewPlayerMediator.ON_CREATE, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.CREATE_NEW_PLAYER, {
			nickname = arg_2_1,
			shipId = arg_2_2
		})

		return
	end)
	self:bind(NewPlayerMediator.ON_SKILLINFO, function(arg_3_0, arg_3_1)
		self:addSubLayers(Context.New({
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

function NewPlayerMediator:listNotificationInterests()
	return {
		GAME.CREATE_NEW_PLAYER_DONE,
		GAME.LOAD_PLAYER_DATA_DONE
	}
end

function NewPlayerMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()

	if var_5_0 == GAME.CREATE_NEW_PLAYER_DONE then
		self.facade:sendNotification(GAME.LOAD_PLAYER_DATA, {
			isNewPlayer = true,
			id = arg_5_1:getBody()
		})
	elseif var_5_0 == GAME.LOAD_PLAYER_DATA_DONE then
		self:sendNotification(GAME.GO_SCENE, SCENE.MAINUI)
	end

	return
end

return NewPlayerMediator
