class = var_0_10000

local var_0_0 = "GameMediator"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.Mediator)

function var_0_1.listNotificationInterests(arg_1_0)
	local var_1_0 = {}

	GAME = var_1_10002
	var_1_0[1] = var_1_10002.GO_SCENE
	GAME = var_2
	var_1_0[2] = var_2.GO_MINI_GAME
	GAME = var_2
	var_1_0[3] = var_2.LOAD_SCENE_DONE
	GAME = var_2
	var_1_0[4] = var_2.SEND_CMD_DONE

	return var_1_0
end

function var_0_1.handleNotification(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1:getName()
	local var_2_1 = arg_2_1
	local var_2_2 = arg_2_1.getBody(var_2_1)
	local var_2_3

	GAME = var_2_1

	local var_2_4

	if var_2_0 == var_2_1.GO_SCENE then
		var_1_10007 = arg_2_1
		var_2_4 = arg_2_1.getType(var_1_10007)
		Context = var_1_10006
		var_1_10008 = var_1_10006.New()

		var_4.extendData(var_1_10008, var_2_4)

		SCENE = var_6

		var_6.SetSceneInfo(var_4, var_2_2)

		print = var_6

		var_6("load scene: " .. var_2_2)

		var_1_10008 = arg_2_0

		local var_2_5 = arg_2_0.sendNotification

		GAME = var_9

		var_2_5(var_1_10008, var_9.LOAD_SCENE, {
			context = var_4
		})
	else
		GAME = var_2_4

		local var_2_7

		if var_2_0 == var_2_4.GO_MINI_GAME then
			Context = var_2_7

			local var_2_6 = var_2_7.New()

			var_2_7 = nil

			local var_2_8

			type = var_1_10007

			if var_1_10007(var_2_2) == "number" then
				var_2_7 = var_2_2
				var_2_8 = {
					miniGameId = var_2_7
				}
			else
				var_2_7 = var_2_2.id
				var_2_8 = var_2_2
				var_2_8.miniGameId = var_2_7
			end

			var_2_6:extendData(var_2_8)

			pg = var_7

			local var_2_9 = var_7.mini_game[var_2_7]

			_G = var_1_10008
			var_2_6.mediator = var_1_10008[var_2_9.mediator_name]
			_G = var_8
			var_2_6.viewComponent = var_8[var_2_9.view_name]
			var_2_6.scene = var_2_9.view_name
			print = var_8

			var_8("load minigame: " .. var_2_9.view_name)

			local var_2_10 = {
				context = var_2_6
			}
			local var_2_11 = arg_2_1:getType()

			table = var_10

			var_10.merge(var_2_10, var_2_11)

			local var_2_12 = arg_2_0
			local var_2_13 = arg_2_0.sendNotification

			GAME = var_13

			var_2_13(var_2_12, var_13.LOAD_SCENE, var_2_10)
		else
			GAME = var_2_7

			if var_2_0 == var_2_7.LOAD_SCENE_DONE then
				print = var_5

				var_5("scene loaded: ", var_2_2)

				SCENE = var_5

				if var_2_2 == var_5.LOGIN then
					pg = var_5

					local var_2_14 = var_5.UIMgr.GetInstance()

					var_5.displayLoadingBG(var_2_14, false)
				end
			else
				GAME = var_5

				if var_2_0 == var_5.SEND_CMD_DONE then
					-- block empty
				end
			end
		end
	end

	return
end

return var_0_1
