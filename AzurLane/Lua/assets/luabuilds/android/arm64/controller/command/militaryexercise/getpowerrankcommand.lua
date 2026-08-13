class = var_0_10000

local var_0_0 = "GetPowerRankCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)
local var_0_2 = 100
local var_0_3 = 5

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().type
	local var_1_1 = var_2.activityId

	assert = var_1_10005

	var_1_10005(var_1_0, "type can not be nil")

	getProxy = var_1_10005
	BillboardProxy = var_7

	local var_1_2 = var_1_10005(var_7)

	local function var_1_3(arg_2_0, arg_2_1)
		local var_2_0 = var_1_2

		var_2.setRankList(var_2_0, var_1_0, var_1_1, arg_2_0)

		local var_2_1 = var_1_2

		var_2.setPlayerRankData(var_2_1, var_1_0, var_1_1, arg_2_1)

		local var_2_2 = arg_1_0
		local var_2_3 = var_2.sendNotification

		GAME = var_5

		var_2_3(var_2_2, var_5.GET_POWERRANK_DONE, {
			list = arg_2_0,
			type = var_1_0,
			playerRankinfo = arg_2_1,
			activityId = var_1_1
		})

		return
	end

	PowerRank = var_7

	if var_1_0 == var_7.TYPE_MILITARY_RANK then
		pg = var_7

		local var_1_4 = var_7.ConnectionMgr.GetInstance()

		var_7.Send(var_1_4, 18006, {
			type = 0
		}, 18007, function(arg_3_0)
			local var_3_0 = {}

			ipairs = var_2_10002

			for iter_3_0, iter_3_1 in var_2_10002(arg_3_0.arena_rank_lsit) do
				PowerRank = var_2_10007

				local var_3_1 = var_2_10007.New(iter_3_1, var_1_0)

				var_2_10007.setRank(var_3_1, iter_3_0)

				local var_3_2 = var_2_10007
				local var_3_3 = var_2_10007.setArenaRank

				SeasonInfo = var_11

				var_3_3(var_3_2, var_11.getEmblem(iter_3_1.score, iter_3_0))

				table = var_3_3

				var_3_3.insert(var_3_0, var_2_10007)
			end

			getProxy = var_2
			PlayerProxy = var_4

			local var_3_4 = var_2(var_4)
			local var_3_5 = var_2.getData(var_3_4)

			getProxy = var_3
			BayProxy = iter_3_0

			local var_3_6 = var_3(iter_3_0)
			local var_3_7 = var_3.GetShipPhantom(var_3_6, var_3_5:GetFlagShipPhantomMark())
			local var_3_8 = {
				id = var_3_5.id,
				level = var_3_5.level,
				name = var_3_5.name,
				score = var_3_5.score
			}

			SeasonInfo = var_5
			var_3_8.arena_rank = var_5.getEmblem(var_3_5.score, var_3_5.rank)
			var_3_8.icon = var_3_7:getConfig("id")
			var_3_8.skin_id = var_3_7:getSkinId()
			var_3_8.propose = var_3_7.propose and 1 or 0
			var_3_8.remoulded = var_3_7:isRemoulded() and 1 or 0
			PowerRank = var_5

			local var_3_9 = var_5.New(var_3_8, var_1_0)

			var_5.setRank(var_3_9, var_3_5.rank)
			var_1_3(var_3_0, var_5)

			return
		end)
	else
		local var_1_5 = {}

		local function var_1_6(arg_4_0, arg_4_1)
			if #var_1_5 < (arg_4_0 - 1) * (var_0_2 / var_0_3) then
				arg_4_1()

				return
			end

			pg = var_2

			local var_4_0 = var_2.ConnectionMgr.GetInstance()
			local var_4_1 = var_2.Send
			local var_4_2 = 18201
			local var_4_3 = {
				page = arg_4_0,
				type = var_1_0
			}
			local var_4_4

			if not var_1_1 then
				var_4_4 = 0
			end

			var_4_3.act_id = var_4_4

			var_4_1(var_4_0, var_4_2, var_4_3, 18202, function(arg_5_0)
				ipairs = var_3_10001

				for iter_5_0, iter_5_1 in var_3_10001(arg_5_0.list) do
					PowerRank = var_3_10006
					var_3_10006 = var_3_10006.New(iter_5_1, var_1_0)
					table = var_3_10007

					var_3_10007.insert(var_1_5, var_3_10006)
				end

				arg_4_1()

				return
			end)

			return
		end

		local var_1_7

		local function var_1_8(arg_6_0)
			pg = var_2_10001

			local var_6_0 = var_2_10001.ConnectionMgr.GetInstance()
			local var_6_1 = var_1.Send
			local var_6_2 = 18203
			local var_6_3 = {
				type = var_1_0
			}
			local var_6_4

			if not var_1_1 then
				var_6_4 = 0
			end

			var_6_3.act_id = var_6_4

			var_6_1(var_6_0, var_6_2, var_6_3, 18204, function(arg_7_0)
				getProxy = var_3_10001
				PlayerProxy = var_3_10003

				local var_7_0 = var_3_10001(var_3_10003)
				local var_7_1 = var_1.getData(var_7_0)

				getProxy = var_3_10002
				BayProxy = var_3_10004

				local var_7_2 = var_3_10002(var_3_10004)
				local var_7_3 = var_2.GetShipPhantom
				local var_7_4 = var_7_1
				local var_7_5 = var_7_3(var_7_2, var_7_1.GetFlagShipPhantomMark(var_7_4))
				local var_7_6
				local var_7_7 = var_1_0

				PowerRank = var_5

				if var_7_7 == var_5.TYPE_POWER then
					getProxy = var_7_7
					BayProxy = var_3_10006
					var_3_10006 = var_7_7(var_3_10006)
					var_7_6 = var_4.getBayPower(var_3_10006)

					goto label_7_1
				end

				local var_7_8 = var_1_0

				PowerRank = var_5

				if var_7_8 == var_5.TYPE_COLLECTION then
					getProxy = var_7_8
					CollectionProxy = var_3_10006

					local var_7_9 = var_7_8(var_3_10006)

					var_7_6 = var_4.getCollectionCount(var_7_9)

					goto label_7_1
				end

				local var_7_10 = var_1_0

				PowerRank = var_5

				if var_7_10 ~= var_5.TYPE_PT then
					var_7_10 = var_1_0
					PowerRank = var_5

					if var_7_10 == var_5.TYPE_ACT_BOSS_BATTLE then
						assert = var_7_10

						var_7_10(var_1_1)

						getProxy = var_7_10
						ActivityProxy = var_6

						local var_7_11 = var_7_10(var_6)

						var_7_6 = var_4.getActivityById(var_7_11, var_1_1) and var_4.data1 or arg_7_0.point
					else
						local var_7_12 = var_1_0

						PowerRank = var_5

						local var_7_16

						if var_7_12 == var_5.TYPE_CHALLENGE then
							PowerRank = var_7_12

							local var_7_13 = var_7_12
							local var_7_14 = var_7_12.getActivityByRankType

							PowerRank = var_7_4

							local var_7_15 = var_7_14(var_7_13, var_7_4.TYPE_CHALLENGE)

							getProxy = var_7_16
							ChallengeProxy = var_7_4
							var_7_4 = var_7_16(var_7_4)

							if var_7_16.getChallengeInfo(var_7_4) then
								if var_7_15 then
									::label_7_0::

									getProxy = var_7_16
									ChallengeProxy = var_7_4
									var_7_4 = var_7_16(var_7_4)
									var_7_4 = var_7_16.getChallengeInfo(var_7_4)
									var_7_16 = var_7_16.getGradeList(var_7_4).seasonMaxScore
								end

								var_7_6 = var_7_15 and var_7_16 or arg_7_0.point
							else
								var_7_6 = arg_7_0.point
							end
						else
							local var_7_17 = var_1_0

							PowerRank = var_7_16

							if var_7_17 == var_7_16.TYPE_EXTRA_CHAPTER then
								PowerRank = var_7_17

								local var_7_18 = var_7_17
								local var_7_19 = var_7_17.getActivityByRankType

								PowerRank = var_7_4
								var_7_6 = var_7_19(var_7_18, var_7_4.TYPE_EXTRA_CHAPTER) and var_4.data1 or arg_7_0.point
							else
								local var_7_20 = var_1_0

								PowerRank = var_5

								if var_7_20 == var_5.TYPE_BOSSRUSH then
									PowerRank = var_7_20

									local var_7_21 = var_7_20
									local var_7_22 = var_7_20.getActivityByRankType

									PowerRank = var_7_4
									var_7_6 = var_7_22(var_7_21, var_7_4.TYPE_BOSSRUSH) and var_4.data1 or arg_7_0.point
								else
									var_7_6 = arg_7_0.point
								end
							end
						end
					end

					::label_7_1::

					local var_7_23 = {
						user_id = var_7_1.id,
						point = var_7_6,
						name = var_7_1.name,
						lv = var_7_1.level,
						arena_rank = var_7_1.maxRank,
						icon = var_7_5:getConfig("id"),
						skin_id = var_7_5:getSkinId(),
						propose = var_7_5.propose and 1 or 0,
						remoulded = var_7_5:isRemoulded() and 1 or 0
					}

					PowerRank = var_5
					var_1_7 = var_5.New(var_7_23, var_1_0)

					local var_7_24 = var_1_7

					var_5.setRank(var_7_24, arg_7_0.rank)
					arg_6_0()

					return
				end
			end)

			return
		end

		local var_1_9 = {}

		for iter_1_0 = 1, var_0_3 do
			table = var_1_10016

			var_1_10016.insert(var_1_9, function(arg_8_0)
				var_1_6(iter_1_0, arg_8_0)

				return
			end)
		end

		table = var_12

		var_12.insert(var_1_9, function(arg_9_0)
			var_1_8(arg_9_0)

			return
		end)

		seriesAsync = var_12

		var_12(var_1_9, function()
			if #var_1_5 > 0 and var_1_7 then
				local var_10_0 = {}
				local var_10_1 = {}

				local function var_10_2(arg_11_0)
					table = var_3_10001

					local var_11_0 = var_3_10001.indexof(var_10_0, arg_11_0)
					local var_11_1 = 0

					for iter_11_0 = 1, var_11_0 - 1 do
						local var_11_2 = var_10_0[iter_11_0]

						var_11_1 = var_11_1 + var_10_1[var_11_2]
					end

					return var_11_1 + 1
				end

				ipairs = var_2_10003

				for iter_10_0, iter_10_1 in var_2_10003(var_1_5) do
					local var_10_3 = iter_10_1.power

					table = var_2_10009

					if not var_2_10009.contains(var_10_0, var_10_3) then
						table = var_2_10009

						var_2_10009.insert(var_10_0, var_10_3)

						var_10_1[var_10_3] = 1
					else
						var_10_1[var_10_3] = var_10_1[var_10_3] + 1
					end
				end

				table = var_3

				var_3.sort(var_10_0, function(arg_12_0, arg_12_1)
					return arg_12_1 < arg_12_0
				end)

				ipairs = var_3

				for iter_10_2, iter_10_3 in var_3(var_1_5) do
					local var_10_4 = iter_10_3.power
					local var_10_5 = var_10_2(var_10_4)

					iter_10_3:setRank(var_10_5)
				end
			end

			var_1_3(var_1_5, var_1_7)

			return
		end)
	end

	return
end

return var_0_1
