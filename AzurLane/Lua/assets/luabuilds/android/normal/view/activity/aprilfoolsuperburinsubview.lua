class = var_0_10000

local var_0_0 = "AprilFoolSuperBurinSubView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".AprilFoolBulinSubView"))

function var_0_1.getUIName(arg_1_0)
	return "AprilFoolSuperBurinSubView"
end

function var_0_1.OnInit(arg_2_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)
	local var_2_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	if not var_2_1(var_2_0, var_1_10003.ACTIVITY_TYPE_PUZZLA) or var_1:isEnd() then
		arg_2_0:Destroy()

		return
	end

	pg = var_2_0

	local var_2_2 = var_2_0.activity_event_picturepuzzle[var_1.id]

	assert = var_3

	var_3(var_2_2, "Can't Find activity_event_picturepuzzle 's ID : " .. var_1.id)

	local var_2_3 = arg_2_0._tf

	arg_2_0.bulin = var_3.Find(var_2_3, "bulin")
	onButton = var_3

	var_3(arg_2_0, arg_2_0.bulin, function()
		local var_3_0 = arg_2_0.pieceId

		pg = var_2_10001

		local var_3_1 = var_2_10001.m02
		local var_3_2 = var_1.sendNotification

		GAME = var_2_10003

		local var_3_3 = var_2_10003.PUZZLE_PIECE_OP
		local var_3_4 = {
			actId = var_0.id,
			id = var_3_0
		}

		PuzzleActivity = var_5
		var_3_4.cmd = var_5.CMD_ACTIVATE

		function var_3_4.callback()
			seriesAsync = var_3_10000

			var_3_10000({
				function(arg_5_0)
					local var_5_0 = var_2_2.awards

					table = var_4_10002

					local var_5_1 = var_5_0[var_4_10002.indexof(var_2_2.pickup_picturepuzzle, var_3_0)]

					assert = var_2

					var_2(var_5_1, "Cant Find Award of PieceID " .. var_3_0)

					local var_5_2 = arg_2_0
					local var_5_3 = var_2.emit

					BaseUI = var_4

					var_5_3(var_5_2, var_4.ON_ACHIEVE, {
						{
							type = var_5_1[1],
							id = var_5_1[2],
							count = var_5_1[3]
						}
					}, arg_5_0)

					return
				end,
				function(arg_6_0)
					getProxy = var_4_10001
					ActivityProxy = var_4_10002

					local var_6_0 = var_4_10001(var_4_10002)
					local var_6_1 = var_1.getActivityByType

					ActivityConst = var_4_10003

					local var_6_2 = var_6_1(var_6_0, var_4_10003.ACTIVITY_TYPE_PUZZLA)

					table = var_6_0

					if #var_6_0.mergeArray(var_6_2.data1_list, var_6_2.data2_list, true) < #var_2_2.pickup_picturepuzzle + #var_2_2.drop_picturepuzzle then
						return arg_6_0()
					end

					local var_6_3 = var_6_2
					local var_6_4 = var_6_2.getConfig(var_6_3, "config_client").comStory

					pg = var_6_3

					local var_6_5 = var_6_3.NewStoryMgr.GetInstance()

					var_4.Play(var_6_5, var_6_4, arg_6_0)

					return
				end,
				function()
					local var_7_0 = arg_2_0

					var_0.Destroy(var_7_0)

					return
				end
			})

			return
		end

		var_3_2(var_3_1, var_3_3, var_3_4)

		return
	end)

	return
end

return var_0_1
