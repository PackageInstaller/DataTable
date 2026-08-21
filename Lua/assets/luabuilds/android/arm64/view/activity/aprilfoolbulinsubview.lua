local var_0_0 = class("AprilFoolBulinSubView", import("view.base.BaseSubPanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.pieceId = arg_1_2

	return
end

function var_0_0.getUIName(arg_2_0)
	return "AprilFoolBulinSubView"
end

function var_0_0.OnInit(arg_3_0)
	local var_3_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)

	if not var_3_0 or var_3_0:isEnd() then
		arg_3_0:Destroy()

		return
	end

	assert(pg.activity_event_picturepuzzle[var_3_0.id], "Can't Find activity_event_picturepuzzle 's ID : " .. var_3_0.id)

	arg_3_0.bulin = arg_3_0._tf:Find("bulin")

	onButton(arg_3_0, arg_3_0.bulin, function()
		pg.m02:sendNotification(GAME.PUZZLE_PIECE_OP, {
			cmd = 2,
			actId = var_3_0.id,
			id = arg_3_0.pieceId,
			callback = function()
				local var_5_0 = var_0.awards[table.indexof(var_0.pickup_picturepuzzle, var_0)]

				assert(var_5_0, "Cant Find Award of PieceID " .. var_0)
				arg_3_0:emit(BaseUI.ON_ACHIEVE, {
					{
						type = var_5_0[1],
						id = var_5_0[2],
						count = var_5_0[3]
					}
				})
				arg_3_0:Destroy()

				return
			end
		})

		return
	end)

	return
end

function var_0_0.SetPosition(arg_6_0, arg_6_1)
	setAnchoredPosition(arg_6_0._tf, arg_6_1)

	return
end

function var_0_0.SetParent(arg_7_0, arg_7_1)
	setParent(arg_7_0._tf, arg_7_1)

	return
end

function var_0_0.ShowAprilFoolBulin(arg_8_0, arg_8_1, arg_8_2)
	local var_8_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)

	if not var_8_2 or var_8_2:isEnd() then
		return
	end

	local var_8_3 = pg.activity_event_picturepuzzle[var_8_2.id]

	if not pg.activity_event_picturepuzzle[var_8_2.id] then
		return
	end

	local var_8_4 = var_8_3.pickup_picturepuzzle[table.indexof(var_8_3.pickup_views, arg_8_0.__cname)]

	if not var_8_4 or table.contains(var_8_2.data2_list, var_8_4) then
		return
	end

	local var_8_5 = _G[var_8_2:getConfig("config_client").subView]

	if not var_8_5 then
		return
	end

	local var_8_6 = var_8_5.New(arg_8_0, var_8_4)

	var_8_6:Load()

	if arg_8_1 then
		var_8_6.buffer:SetParent(arg_8_1)
	end

	if arg_8_2 then
		var_8_6.buffer:SetPosition(arg_8_2)
	end

	return var_8_6
end

function var_0_0.OnDestroy(arg_9_0)
	existCall(arg_9_0.destroyCall)

	arg_9_0.destroyCall = nil

	return
end

return var_0_0
