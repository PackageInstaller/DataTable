local TowerClimbingMediator = class("TowerClimbingMediator", import("...base.ContextMediator"))

TowerClimbingMediator.ON_FINISH = "TowerClimbingMediator:ON_FINISH"
TowerClimbingMediator.ON_MODIFY_DATA = "TowerClimbingMediator:ON_MODIFY_DATA"
TowerClimbingMediator.ON_COLLECTION = "TowerClimbingMediator:ON_COLLECTION"
TowerClimbingMediator.ON_RECORD_MAP_SCORE = "TowerClimbingMediator:ON_RECORD_MAP_SCORE"

function TowerClimbingMediator:register()
	self:bind(TowerClimbingMediator.ON_RECORD_MAP_SCORE, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = 9,
			cmd = MiniGameOPCommand.CMD_SPECIAL_GAME,
			args1 = {
				MiniGameDataCreator.TowerClimbingGameID,
				4,
				arg_2_2,
				arg_2_1
			}
		})

		return
	end)
	self:bind(TowerClimbingMediator.ON_COLLECTION, function(arg_3_0)
		self:addSubLayers(Context.New({
			viewComponent = TowerClimbingCollectionLayer,
			mediator = TowerClimbingCollectionMediator
		}))

		return
	end)
	self:bind(TowerClimbingMediator.ON_FINISH, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		if arg_4_3 < arg_4_1 then
			self:sendNotification(GAME.SEND_MINI_GAME_OP, {
				hubid = 9,
				cmd = MiniGameOPCommand.CMD_SPECIAL_GAME,
				args1 = {
					MiniGameDataCreator.TowerClimbingGameID,
					3,
					arg_4_1,
					arg_4_2
				}
			})
		end

		if getProxy(MiniGameProxy):GetHubByGameId(MiniGameDataCreator.TowerClimbingGameID).count <= 0 then
			return
		end

		self:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = 9,
			cmd = MiniGameOPCommand.CMD_COMPLETE,
			args1 = {},
			id = MiniGameDataCreator.TowerClimbingGameID
		})

		return
	end)
	self:bind(TowerClimbingMediator.ON_MODIFY_DATA, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.MODIFY_MINI_GAME_DATA, {
			id = MiniGameDataCreator.TowerClimbingGameID,
			map = arg_5_1
		})

		return
	end)

	local var_1_0 = getProxy(MiniGameProxy):GetMiniGameData(MiniGameDataCreator.TowerClimbingGameID)

	if var_1_0 and not var_1_0:GetRuntimeData("isInited") then
		self:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = 9,
			cmd = MiniGameOPCommand.CMD_SPECIAL_GAME,
			args1 = {
				MiniGameDataCreator.TowerClimbingGameID,
				1
			}
		})
	else
		self.viewComponent:Start()
	end

	return
end

function TowerClimbingMediator:listNotificationInterests()
	return {
		GAME.SEND_MINI_GAME_OP_DONE,
		GAME.REMOVE_LAYERS
	}
end

function TowerClimbingMediator:handleNotification(arg_7_1)
	local var_7_0 = arg_7_1:getName()
	local var_7_1 = arg_7_1:getBody()

	if var_7_0 == GAME.SEND_MINI_GAME_OP_DONE then
		seriesAsync({
			function(arg_8_0)
				if #var_7_1.awards > 0 then
					self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_7_1.awards, arg_8_0)
				else
					arg_8_0()
				end

				return
			end
		})
		self.viewComponent:OnSendMiniGameOPDone(var_7_1)
	elseif var_7_0 == GAME.REMOVE_LAYERS and var_7_1.context.mediator == TowerClimbingCollectionMediator then
		self.viewComponent:UpdateTip()
	end

	return
end

return TowerClimbingMediator
