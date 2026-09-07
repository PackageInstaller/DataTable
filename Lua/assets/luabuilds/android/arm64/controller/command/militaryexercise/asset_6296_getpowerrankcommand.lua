local GetPowerRankCommand = class("GetPowerRankCommand", pm.SimpleCommand)
local var_0_1 = 100
local var_0_2 = 5

function GetPowerRankCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.type
	local var_1_2 = var_1_0.activityId

	assert(var_1_0.type, "type can not be nil")

	local var_1_3 = getProxy(BillboardProxy)

	local function var_1_4(arg_2_0, arg_2_1)
		var_1_3:setRankList(var_1_1, var_1_2, arg_2_0)
		var_1_3:setPlayerRankData(var_1_1, var_1_2, arg_2_1)
		self:sendNotification(GAME.GET_POWERRANK_DONE, {
			list = arg_2_0,
			type = var_1_1,
			playerRankinfo = arg_2_1,
			activityId = var_1_2
		})

		return
	end

	if var_1_0.type == PowerRank.TYPE_MILITARY_RANK then
		pg.ConnectionMgr.GetInstance():Send(18006, {
			type = 0
		}, 18007, function(arg_3_0)
			local var_3_0 = {}

			for iter_3_0, iter_3_1 in ipairs(arg_3_0.arena_rank_lsit) do
				local var_3_1 = PowerRank.New(iter_3_1, var_1_1)

				var_3_1:setRank(iter_3_0)
				var_3_1:setArenaRank(SeasonInfo.getEmblem(iter_3_1.score, iter_3_0))
				table.insert(var_3_0, var_3_1)
			end

			local var_3_2 = getProxy(PlayerProxy):getData()
			local var_3_3 = getProxy(BayProxy)
			local var_3_4 = var_3_3:GetShipPhantom(var_3_2:GetFlagShipPhantomMark())
			local var_3_5 = PowerRank.New({
				id = var_3_2.id,
				level = var_3_2.level,
				name = var_3_2.name,
				score = var_3_2.score,
				arena_rank = SeasonInfo.getEmblem(var_3_2.score, var_3_2.rank),
				icon = var_3_4:getConfig("id"),
				skin_id = var_3_4:getSkinId(),
				propose = var_3_4.propose and 1 or 0,
				remoulded = var_3_4:isRemoulded() and 1 or 0
			}, var_1_1)

			var_3_5.setRank(var_3_3, var_3_2.rank)
			var_1_4(var_3_0, var_3_5)

			return
		end)
	else
		local var_1_5 = {}

		local function var_1_6(arg_4_0, arg_4_1)
			if #var_1_5 < (arg_4_0 - 1) * (var_0_1 / var_0_2) then
				arg_4_1()

				return
			end

			local var_4_0 = {
				page = arg_4_0,
				type = var_1_1
			}

			var_4_0.act_id = var_1_2 or 0

			pg.ConnectionMgr.GetInstance():Send(18201, var_4_0, 18202, function(arg_5_0)
				for iter_5_0, iter_5_1 in ipairs(arg_5_0.list) do
					table.insert(var_1_5, (PowerRank.New(iter_5_1, var_1_1)))
				end

				arg_4_1()

				return
			end)

			return
		end

		local var_1_7

		local function var_1_8(arg_6_0)
			local var_6_0 = {
				type = var_1_1
			}

			var_6_0.act_id = var_1_2 or 0

			pg.ConnectionMgr.GetInstance():Send(18203, var_6_0, 18204, function(arg_7_0)
				local var_7_0 = getProxy(PlayerProxy):getData()
				local var_7_1 = getProxy(BayProxy):GetShipPhantom(var_7_0:GetFlagShipPhantomMark())
				local var_7_2

				if var_1_1 == PowerRank.TYPE_POWER then
					var_7_2 = getProxy(BayProxy):getBayPower()
				elseif var_1_1 == PowerRank.TYPE_COLLECTION then
					var_7_2 = getProxy(CollectionProxy):getCollectionCount()
				elseif var_1_1 == PowerRank.TYPE_PT or var_1_1 == PowerRank.TYPE_ACT_BOSS_BATTLE then
					assert(var_1_2)

					local var_7_3 = getProxy(ActivityProxy):getActivityById(var_1_2)

					var_7_2 = var_7_3 and var_7_3.data1 or arg_7_0.point
				elseif var_1_1 == PowerRank.TYPE_CHALLENGE then
					local var_7_4 = PowerRank:getActivityByRankType(PowerRank.TYPE_CHALLENGE)

					if getProxy(ChallengeProxy):getChallengeInfo() then
						local var_7_5

						if var_7_4 then
							::label_7_0::

							var_7_5 = getProxy(ChallengeProxy):getChallengeInfo():getGradeList().seasonMaxScore
						end

						var_7_2 = var_7_4 and var_7_5 or arg_7_0.point
					else
						var_7_2 = arg_7_0.point
					end
				elseif var_1_1 == PowerRank.TYPE_EXTRA_CHAPTER then
					local var_7_6 = PowerRank:getActivityByRankType(PowerRank.TYPE_EXTRA_CHAPTER)

					var_7_2 = var_7_6 and var_7_6.data1 or arg_7_0.point
				elseif var_1_1 == PowerRank.TYPE_BOSSRUSH then
					local var_7_7 = PowerRank:getActivityByRankType(PowerRank.TYPE_BOSSRUSH)

					var_7_2 = var_7_7 and var_7_7.data1 or arg_7_0.point
				else
					var_7_2 = arg_7_0.point
				end

				var_1_7 = PowerRank.New({
					user_id = var_7_0.id,
					point = var_7_2,
					name = var_7_0.name,
					lv = var_7_0.level,
					arena_rank = var_7_0.maxRank,
					icon = var_7_1:getConfig("id"),
					skin_id = var_7_1:getSkinId(),
					propose = var_7_1.propose and 1 or 0,
					remoulded = var_7_1:isRemoulded() and 1 or 0
				}, var_1_1)

				var_1_7:setRank(arg_7_0.rank)
				arg_6_0()

				return
			end)

			return
		end

		local var_1_9 = {}

		for iter_1_0 = 1, var_0_2 do
			table.insert(var_1_9, function(arg_8_0)
				var_1_6(iter_1_0, arg_8_0)

				return
			end)
		end

		table.insert(var_1_9, function(arg_9_0)
			var_1_8(arg_9_0)

			return
		end)
		seriesAsync(var_1_9, function()
			if #var_1_5 > 0 and var_1_7 then
				local var_10_0 = {}
				local var_10_1 = {}

				local function var_10_2(arg_11_0)
					local var_11_0 = 0

					for iter_11_0 = 1, table.indexof(var_10_0, arg_11_0) - 1 do
						var_11_0 = var_11_0 + var_10_1[var_10_0[iter_11_0]]
					end

					return var_11_0 + 1
				end

				for iter_10_0, iter_10_1 in ipairs(var_1_5) do
					if not table.contains(var_10_0, iter_10_1.power) then
						table.insert(var_10_0, iter_10_1.power)

						var_10_1[iter_10_1.power] = 1
					else
						var_10_1[iter_10_1.power] = var_10_1[iter_10_1.power] + 1
					end
				end

				table.sort(var_10_0, function(arg_12_0, arg_12_1)
					return arg_12_1 < arg_12_0
				end)

				for iter_10_2, iter_10_3 in ipairs(var_1_5) do
					iter_10_3:setRank((var_10_2(iter_10_3.power)))
				end
			end

			var_1_4(var_1_5, var_1_7)

			return
		end)
	end

	return
end

return GetPowerRankCommand
