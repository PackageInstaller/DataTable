class = var_0_10000

local var_0_0 = "AprilFoolBulinSubView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubPanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.pieceId = arg_1_2

	return
end

function var_0_1.getUIName(arg_2_0)
	return "AprilFoolBulinSubView"
end

function var_0_1.OnInit(arg_3_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)
	local var_3_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	if not var_3_1(var_3_0, var_1_10003.ACTIVITY_TYPE_PUZZLA) or var_1:isEnd() then
		arg_3_0:Destroy()

		return
	end

	pg = var_3_0

	local var_3_2 = var_3_0.activity_event_picturepuzzle[var_1.id]

	assert = var_3

	var_3(var_3_2, "Can't Find activity_event_picturepuzzle 's ID : " .. var_1.id)

	local var_3_3 = arg_3_0._tf

	arg_3_0.bulin = var_3.Find(var_3_3, "bulin")
	onButton = var_3

	var_3(arg_3_0, arg_3_0.bulin, function()
		local var_4_0 = arg_3_0.pieceId

		pg = var_2_10001

		local var_4_1 = var_2_10001.m02
		local var_4_2 = var_1.sendNotification

		GAME = var_2_10003

		var_4_2(var_4_1, var_2_10003.PUZZLE_PIECE_OP, {
			cmd = 2,
			actId = var_0.id,
			id = var_4_0,
			callback = function()
				local var_5_0 = var_3_2.awards

				table = var_3_10001

				local var_5_1 = var_5_0[var_3_10001.indexof(var_3_2.pickup_picturepuzzle, var_4_0)]

				assert = var_1

				var_1(var_5_1, "Cant Find Award of PieceID " .. var_4_0)

				local var_5_2 = arg_3_0
				local var_5_3 = var_1.emit

				BaseUI = var_3

				var_5_3(var_5_2, var_3.ON_ACHIEVE, {
					{
						type = var_5_1[1],
						id = var_5_1[2],
						count = var_5_1[3]
					}
				})

				local var_5_4 = arg_3_0

				var_1.Destroy(var_5_4)

				return
			end
		})

		return
	end)

	return
end

function var_0_1.SetPosition(arg_6_0, arg_6_1)
	setAnchoredPosition = var_1_10002

	var_1_10002(arg_6_0._tf, arg_6_1)

	return
end

function var_0_1.SetParent(arg_7_0, arg_7_1)
	setParent = var_1_10002

	var_1_10002(arg_7_0._tf, arg_7_1)

	return
end

function var_0_1.ShowAprilFoolBulin(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0
	local var_8_1

	getProxy = var_1_10005
	ActivityProxy = var_1_10006

	local var_8_2 = var_1_10005(var_1_10006)
	local var_8_3 = var_5.getActivityByType

	ActivityConst = var_1_10007

	if not var_8_3(var_8_2, var_1_10007.ACTIVITY_TYPE_PUZZLA) or var_3:isEnd() then
		return
	end

	pg = var_5

	if not var_5.activity_event_picturepuzzle[var_3.id] then
		return
	end

	table = var_5

	local var_8_4 = var_5.indexof(var_4.pickup_views, arg_8_0.__cname)

	if var_4.pickup_picturepuzzle[var_8_4] then
		table = var_7

		if var_7.contains(var_3.data2_list, var_6) then
			return
		end

		_G = var_7

		if not var_7[var_3:getConfig("config_client").subView] then
			return
		end

		local var_8_5 = var_7.New(arg_8_0, var_6)

		var_8.Load(var_8_5)

		if arg_8_1 then
			local var_8_6 = var_8.buffer

			var_9.SetParent(var_8_6, arg_8_1)
		end

		if arg_8_2 then
			local var_8_7 = var_8.buffer

			var_9.SetPosition(var_8_7, arg_8_2)
		end

		return var_8
	end
end

function var_0_1.OnDestroy(arg_9_0)
	existCall = var_1_10001

	var_1_10001(arg_9_0.destroyCall)

	arg_9_0.destroyCall = nil

	return
end

return var_0_1
