class = var_0_10000

local var_0_0 = "NewEducateGetRankCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)
local var_0_2 = 100
local var_0_3 = 5

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().type
	local var_1_1 = var_2.tbId

	getProxy = var_1_10005
	PlayerProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.getData(var_1_2).id
	local var_1_4
	local var_1_5 = {}

	local function var_1_6(arg_2_0, arg_2_1)
		if #var_1_5 < (arg_2_0 - 1) * (var_0_2 / var_0_3) then
			arg_2_1()

			return
		end

		pg = var_2

		local var_2_0 = var_2.ConnectionMgr.GetInstance()

		var_2.Send(var_2_0, 18201, {
			page = arg_2_0,
			type = var_1_0,
			act_id = var_1_1
		}, 18202, function(arg_3_0)
			ipairs = var_3_10001

			for iter_3_0, iter_3_1 in var_3_10001(arg_3_0.list) do
				PowerRank = var_3_10006

				local var_3_0 = var_3_10006.New(iter_3_1, var_1_0)

				var_3_10006.setArenaRank(var_3_0, iter_3_1.arena_rank)

				table = var_7

				var_7.insert(var_1_5, var_3_10006)

				if var_3_10006.id == var_1_3 then
					var_1_4 = var_3_10006
				end
			end

			arg_2_1()

			return
		end)

		return
	end

	local function var_1_7(arg_4_0)
		pg = var_2_10001

		local var_4_0 = var_2_10001.ConnectionMgr.GetInstance()

		var_1.Send(var_4_0, 18203, {
			type = var_1_0,
			act_id = var_1_1
		}, 18204, function(arg_5_0)
			getProxy = var_3_10001
			PlayerProxy = var_3_10002

			local var_5_0 = var_3_10001(var_3_10002)
			local var_5_1 = var_1.getData(var_5_0)

			getProxy = var_5_0
			NewEducateProxy = var_3_10003

			local var_5_2 = var_5_0(var_3_10003)
			local var_5_3 = var_2.GetCurChar(var_5_2)
			local var_5_4 = var_2.GetCallName(var_5_3)

			getProxy = var_5_3
			BayProxy = var_3_10004

			local var_5_5 = var_5_3(var_3_10004)
			local var_5_6 = var_3.getShipById(var_5_5, var_5_1.character)
			local var_5_7 = {
				user_id = var_5_1.id,
				point = arg_5_0.point,
				name = var_5_1.name .. "|" .. var_5_4,
				lv = var_5_1.level,
				arena_rank = var_5_1.maxRank,
				icon = var_5_6:getConfig("id"),
				skin_id = var_5_6.skinId,
				propose = var_5_6.propose and 1 or 0,
				remoulded = var_5_6:isRemoulded() and 1 or 0
			}

			PowerRank = var_5
			var_1_4 = var_5.New(var_5_7, var_1_0)

			local var_5_8 = var_1_4

			var_5.setRank(var_5_8, arg_5_0.rank)
			arg_4_0()

			return
		end)

		return
	end

	local var_1_8 = {}

	for iter_1_0 = 1, var_0_3 do
		table = var_1_10015

		var_1_10015.insert(var_1_8, function(arg_6_0)
			var_1_6(iter_1_0, arg_6_0)

			return
		end)
	end

	table = var_11

	var_11.insert(var_1_8, function(arg_7_0)
		if not var_1_4 then
			var_1_7(arg_7_0)
		else
			arg_7_0()
		end

		return
	end)

	seriesAsync = var_11

	var_11(var_1_8, function()
		local var_8_0 = #var_1_5
		local var_8_1

		if 0 < var_8_0 then
			var_8_1 = arg_1_0

			var_8_0.HandleSamePoint(var_8_1, var_1_1, var_1_5)
		end

		getProxy = var_8_0
		BillboardProxy = var_8_1

		local var_8_2 = var_8_0(var_8_1)

		var_0.setRankList(var_8_2, var_1_0, var_1_1, var_1_5)
		var_0:setPlayerRankData(var_1_0, var_1_1, var_1_4)

		local var_8_3 = arg_1_0
		local var_8_4 = var_1.sendNotification

		GAME = var_3

		var_8_4(var_8_3, var_3.NEW_EDUCATE_GET_RANK_DONE, {
			type = var_1_0,
			tbId = var_1_1,
			list = var_1_5,
			playerInfo = var_1_4
		})

		return
	end)

	return
end

function var_0_1.HandleSamePoint(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {}
	local var_9_1 = {}

	local function var_9_2(arg_10_0)
		table = var_2_10001

		local var_10_0 = var_2_10001.indexof(var_9_0, arg_10_0)
		local var_10_1 = 0

		for iter_10_0 = 1, var_10_0 - 1 do
			local var_10_2 = var_9_0[iter_10_0]

			var_10_1 = var_10_1 + var_9_1[var_10_2]
		end

		return var_10_1 + 1
	end

	ipairs = var_1_10006

	for iter_9_0, iter_9_1 in var_1_10006(arg_9_2) do
		local var_9_3 = iter_9_1.power

		table = var_1_10012

		if not var_1_10012.contains(var_9_0, var_9_3) then
			table = var_1_10012

			var_1_10012.insert(var_9_0, var_9_3)

			var_9_1[var_9_3] = 1
		else
			var_9_1[var_9_3] = var_9_1[var_9_3] + 1
		end
	end

	table = var_6

	var_6.sort(var_9_0, function(arg_11_0, arg_11_1)
		return arg_11_1 < arg_11_0
	end)

	ipairs = var_6

	for iter_9_2, iter_9_3 in var_6(arg_9_2) do
		local var_9_4 = iter_9_3.power
		local var_9_5 = var_9_2(var_9_4)

		iter_9_3:setRank(var_9_5)
	end

	return
end

return var_0_1
