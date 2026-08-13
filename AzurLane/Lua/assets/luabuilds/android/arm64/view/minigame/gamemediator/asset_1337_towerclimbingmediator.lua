class = var_0_10000

local var_0_0 = "TowerClimbingMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.ON_FINISH = "TowerClimbingMediator:ON_FINISH"
var_0_1.ON_MODIFY_DATA = "TowerClimbingMediator:ON_MODIFY_DATA"
var_0_1.ON_COLLECTION = "TowerClimbingMediator:ON_COLLECTION"
var_0_1.ON_RECORD_MAP_SCORE = "TowerClimbingMediator:ON_RECORD_MAP_SCORE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_RECORD_MAP_SCORE, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_2_2 = var_2_10006.SEND_MINI_GAME_OP
		local var_2_3 = {
			hubid = 9
		}

		MiniGameOPCommand = var_2_10008
		var_2_3.cmd = var_2_10008.CMD_SPECIAL_GAME

		local var_2_4 = {
			nil,
			4
		}

		MiniGameDataCreator = var_2_10009
		var_2_4[1] = var_2_10009.TowerClimbingGameID
		var_2_4[3] = arg_2_2
		var_2_4[4] = arg_2_1
		var_2_3.args1 = var_2_4

		var_2_1(var_2_0, var_2_2, var_2_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_COLLECTION, function(arg_3_0)
		local var_3_0 = arg_1_0
		local var_3_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_3_2 = var_2_10004.New
		local var_3_3 = {}

		TowerClimbingCollectionLayer = var_2_10007
		var_3_3.viewComponent = var_2_10007
		TowerClimbingCollectionMediator = var_2_10007
		var_3_3.mediator = var_2_10007

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_FINISH, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		if arg_4_3 < arg_4_1 then
			var_2_10006 = arg_1_0
			var_2_10004 = var_2_10004.sendNotification
			GAME = var_2_10007

			local var_4_0 = var_2_10007.SEND_MINI_GAME_OP

			var_2_10008 = {
				hubid = 9
			}
			MiniGameOPCommand = var_2_10009
			var_2_10008.cmd = var_2_10009.CMD_SPECIAL_GAME
			var_2_10009 = {
				nil,
				3
			}
			MiniGameDataCreator = var_2_10010
			var_2_10009[1] = var_2_10010.TowerClimbingGameID
			var_2_10009[3] = arg_4_1
			var_2_10009[4] = arg_4_2
			var_2_10008.args1 = var_2_10009

			var_2_10004(var_2_10006, var_4_0, var_2_10008)
		end

		getProxy = var_2_10004
		MiniGameProxy = var_2_10006

		local var_4_1 = var_2_10004(var_2_10006)
		local var_4_2 = var_4.GetHubByGameId

		MiniGameDataCreator = var_2_10008

		if var_4_2(var_4_1, var_2_10008.TowerClimbingGameID).count <= 0 then
			return
		end

		local var_4_3 = arg_1_0
		local var_4_4 = var_6.sendNotification

		GAME = var_2_10009

		local var_4_5 = var_2_10009.SEND_MINI_GAME_OP
		local var_4_6 = {
			hubid = 9
		}

		MiniGameOPCommand = var_2_10011
		var_4_6.cmd = var_2_10011.CMD_COMPLETE
		var_4_6.args1 = {}
		MiniGameDataCreator = var_11
		var_4_6.id = var_11.TowerClimbingGameID

		var_4_4(var_4_3, var_4_5, var_4_6)

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.ON_MODIFY_DATA, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_5_2 = var_2_10005.MODIFY_MINI_GAME_DATA
		local var_5_3 = {}

		MiniGameDataCreator = var_2_10007
		var_5_3.id = var_2_10007.TowerClimbingGameID
		var_5_3.map = arg_5_1

		var_5_1(var_5_0, var_5_2, var_5_3)

		return
	end)

	getProxy = var_1
	MiniGameProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.GetMiniGameData

	MiniGameDataCreator = var_4

	if var_1_2(var_1_1, var_4.TowerClimbingGameID) and not var_1:GetRuntimeData("isInited") then
		local var_1_3 = arg_1_0
		local var_1_4 = arg_1_0.sendNotification

		GAME = var_5

		local var_1_5 = var_5.SEND_MINI_GAME_OP
		local var_1_6 = {
			hubid = 9
		}

		MiniGameOPCommand = var_1_10007
		var_1_6.cmd = var_1_10007.CMD_SPECIAL_GAME

		local var_1_7 = {
			nil,
			1
		}

		MiniGameDataCreator = var_1_10008
		var_1_7[1] = var_1_10008.TowerClimbingGameID
		var_1_6.args1 = var_1_7

		var_1_4(var_1_3, var_1_5, var_1_6)
	else
		local var_1_8 = arg_1_0.viewComponent

		var_2.Start(var_1_8)
	end

	return
end

function var_0_1.listNotificationInterests(arg_6_0)
	local var_6_0 = {}

	GAME = var_1_10002
	var_6_0[1] = var_1_10002.SEND_MINI_GAME_OP_DONE
	GAME = var_2
	var_6_0[2] = var_2.REMOVE_LAYERS

	return var_6_0
end

function var_0_1.handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1
	local var_7_1 = arg_7_1.getName(var_7_0)
	local var_7_2 = arg_7_1
	local var_7_3 = arg_7_1.getBody(var_7_2)

	GAME = var_7_0

	local var_7_4

	if var_7_1 == var_7_0.SEND_MINI_GAME_OP_DONE then
		var_7_4 = {
			function(arg_8_0)
				if #var_7_3.awards > 0 then
					local var_8_0 = arg_7_0.viewComponent
					local var_8_1 = var_2.emit

					BaseUI = var_2_10005

					var_8_1(var_8_0, var_2_10005.ON_ACHIEVE, var_1, arg_8_0)
				else
					arg_8_0()
				end

				return
			end
		}
		seriesAsync = var_7_2

		var_7_2(var_7_4)

		local var_7_5 = arg_7_0.viewComponent

		var_7_2.OnSendMiniGameOPDone(var_7_5, var_7_3)
	else
		GAME = var_7_4

		if var_7_1 == var_7_4.REMOVE_LAYERS then
			local var_7_6 = var_7_3.context.mediator

			TowerClimbingCollectionMediator = var_7_2

			if var_7_6 == var_7_2 then
				local var_7_7 = arg_7_0.viewComponent

				var_4.UpdateTip(var_7_7)
			end
		end
	end

	return
end

return var_0_1
