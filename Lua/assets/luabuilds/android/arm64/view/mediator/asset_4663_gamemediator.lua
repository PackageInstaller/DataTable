local GameMediator = class("GameMediator", pm.Mediator)

function GameMediator:listNotificationInterests()
	return {
		GAME.GO_SCENE,
		GAME.GO_MINI_GAME,
		GAME.LOAD_SCENE_DONE,
		GAME.SEND_CMD_DONE
	}
end

function GameMediator:handleNotification(arg_2_1)
	local var_2_0 = arg_2_1:getName()
	local var_2_1 = arg_2_1:getBody()

	if var_2_0 == GAME.GO_SCENE then
		local var_2_3 = Context.New()

		var_2_3:extendData((arg_2_1:getType()))
		SCENE.SetSceneInfo(var_2_3, var_2_1)
		print("load scene: " .. var_2_1)
		self:sendNotification(GAME.LOAD_SCENE, {
			context = var_2_3
		})
	elseif var_2_0 == GAME.GO_MINI_GAME then
		local var_2_4 = Context.New()
		local var_2_5
		local var_2_6

		if type(var_2_1) == "number" then
			var_2_5 = var_2_1
			var_2_6 = {
				miniGameId = var_2_1
			}
		else
			var_2_5 = var_2_1.id
			var_2_6 = var_2_1
			var_2_6.miniGameId = var_2_1.id
		end

		var_2_4:extendData(var_2_6)

		var_2_4.mediator = _G[pg.mini_game[var_2_5].mediator_name]
		var_2_4.viewComponent = _G[pg.mini_game[var_2_5].view_name]
		var_2_4.scene = pg.mini_game[var_2_5].view_name

		print("load minigame: " .. pg.mini_game[var_2_5].view_name)

		local var_2_7 = {
			context = var_2_4
		}

		table.merge(var_2_7, (arg_2_1:getType()))
		self:sendNotification(GAME.LOAD_SCENE, var_2_7)
	elseif var_2_0 == GAME.LOAD_SCENE_DONE then
		print("scene loaded: ", var_2_1)

		if var_2_1 == SCENE.LOGIN then
			pg.UIMgr.GetInstance():displayLoadingBG(false)
		end
	elseif var_2_0 == GAME.SEND_CMD_DONE then
		-- block empty
	end

	return
end

return GameMediator
