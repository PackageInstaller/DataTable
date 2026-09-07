local NewEducateGetRankCommand = class("NewEducateGetRankCommand", pm.SimpleCommand)
local var_0_1 = 100
local var_0_2 = 5

function NewEducateGetRankCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.type
	local var_1_2 = var_1_0.tbId
	local var_1_3 = getProxy(PlayerProxy):getData().id
	local var_1_4
	local var_1_5 = {}

	local function var_1_6(arg_2_0, arg_2_1)
		if #var_1_5 < (arg_2_0 - 1) * (var_0_1 / var_0_2) then
			arg_2_1()

			return
		end

		pg.ConnectionMgr.GetInstance():Send(18201, {
			page = arg_2_0,
			type = var_1_1,
			act_id = var_1_2
		}, 18202, function(arg_3_0)
			for iter_3_0, iter_3_1 in ipairs(arg_3_0.list) do
				local var_3_0 = PowerRank.New(iter_3_1, var_1_1)

				var_3_0:setArenaRank(iter_3_1.arena_rank)
				table.insert(var_1_5, var_3_0)

				if var_3_0.id == var_1_3 then
					var_1_4 = var_3_0
				end
			end

			arg_2_1()

			return
		end)

		return
	end

	local function var_1_7(arg_4_0)
		pg.ConnectionMgr.GetInstance():Send(18203, {
			type = var_1_1,
			act_id = var_1_2
		}, 18204, function(arg_5_0)
			local var_5_0 = getProxy(PlayerProxy):getData()
			local var_5_1 = getProxy(BayProxy):getShipById(var_5_0.character)
			local var_5_2 = {
				user_id = var_5_0.id,
				point = arg_5_0.point
			}

			var_5_2.name = var_5_0.name .. "|" .. getProxy(NewEducateProxy):GetCurChar():GetCallName()
			var_5_2.lv = var_5_0.level
			var_5_2.arena_rank = var_5_0.maxRank
			var_5_2.icon = var_5_1:getConfig("id")
			var_5_2.skin_id = var_5_1.skinId
			var_5_2.propose = var_5_1.propose and 1 or 0
			var_5_2.remoulded = var_5_1:isRemoulded() and 1 or 0
			var_1_4 = PowerRank.New(var_5_2, var_1_1)

			var_1_4:setRank(arg_5_0.rank)
			arg_4_0()

			return
		end)

		return
	end

	local var_1_8 = {}

	for iter_1_0 = 1, var_0_2 do
		table.insert(var_1_8, function(arg_6_0)
			var_1_6(iter_1_0, arg_6_0)

			return
		end)
	end

	table.insert(var_1_8, function(arg_7_0)
		if not var_1_4 then
			var_1_7(arg_7_0)
		else
			arg_7_0()
		end

		return
	end)
	seriesAsync(var_1_8, function()
		if #var_1_5 > 0 then
			self:HandleSamePoint(var_1_2, var_1_5)
		end

		local var_8_0 = getProxy(BillboardProxy)

		var_8_0:setRankList(var_1_1, var_1_2, var_1_5)
		var_8_0:setPlayerRankData(var_1_1, var_1_2, var_1_4)
		self:sendNotification(GAME.NEW_EDUCATE_GET_RANK_DONE, {
			type = var_1_1,
			tbId = var_1_2,
			list = var_1_5,
			playerInfo = var_1_4
		})

		return
	end)

	return
end

function NewEducateGetRankCommand:HandleSamePoint(arg_9_1, arg_9_2)
	local var_9_0 = {}
	local var_9_1 = {}

	local function var_9_2(arg_10_0)
		local var_10_0 = 0

		for iter_10_0 = 1, table.indexof(var_9_0, arg_10_0) - 1 do
			var_10_0 = var_10_0 + var_9_1[var_9_0[iter_10_0]]
		end

		return var_10_0 + 1
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_2) do
		if not table.contains(var_9_0, iter_9_1.power) then
			table.insert(var_9_0, iter_9_1.power)

			var_9_1[iter_9_1.power] = 1
		else
			var_9_1[iter_9_1.power] = var_9_1[iter_9_1.power] + 1
		end
	end

	table.sort(var_9_0, function(arg_11_0, arg_11_1)
		return arg_11_1 < arg_11_0
	end)

	for iter_9_2, iter_9_3 in ipairs(arg_9_2) do
		iter_9_3:setRank((var_9_2(iter_9_3.power)))
	end

	return
end

return NewEducateGetRankCommand
