local var_0_0 = class("AprilFoolSuperBurinSubView", import(".AprilFoolBulinSubView"))

function var_0_0.getUIName(arg_1_0)
	return "AprilFoolSuperBurinSubView"
end

function var_0_0.OnInit(arg_2_0)
	local var_2_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)

	if not var_2_0 or var_2_0:isEnd() then
		arg_2_0:Destroy()

		return
	end

	assert(pg.activity_event_picturepuzzle[var_2_0.id], "Can't Find activity_event_picturepuzzle 's ID : " .. var_2_0.id)

	arg_2_0.bulin = arg_2_0._tf:Find("bulin")

	onButton(arg_2_0, arg_2_0.bulin, function()
		pg.m02:sendNotification(GAME.PUZZLE_PIECE_OP, {
			actId = var_2_0.id,
			id = arg_2_0.pieceId,
			cmd = PuzzleActivity.CMD_ACTIVATE,
			callback = function()
				seriesAsync({
					function(arg_5_0)
						local var_5_0 = var_0.awards[table.indexof(var_0.pickup_picturepuzzle, var_0)]

						assert(var_5_0, "Cant Find Award of PieceID " .. var_0)
						arg_2_0:emit(BaseUI.ON_ACHIEVE, {
							{
								type = var_5_0[1],
								id = var_5_0[2],
								count = var_5_0[3]
							}
						}, arg_5_0)

						return
					end,
					function(arg_6_0)
						local var_6_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)

						if #table.mergeArray(var_6_0.data1_list, var_6_0.data2_list, true) < #var_0.pickup_picturepuzzle + #var_0.drop_picturepuzzle then
							return arg_6_0()
						end

						pg.NewStoryMgr.GetInstance():Play(var_6_0:getConfig("config_client").comStory, arg_6_0)

						return
					end,
					function()
						arg_2_0:Destroy()

						return
					end
				})

				return
			end
		})

		return
	end)

	return
end

return var_0_0
