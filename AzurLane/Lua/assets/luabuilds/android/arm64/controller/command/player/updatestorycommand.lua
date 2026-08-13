class = var_0_10000

local var_0_0 = "UpdateStoryCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().storyId
	local var_1_1 = var_2.callback

	assert = var_1_10005
	type = var_1_10007

	var_1_10005(var_1_10007(var_1_0) == "string")

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	if var_5.getConnection(var_1_2) then
		pg = var_5
		var_1_2 = var_5.ConnectionMgr.GetInstance()

		if not var_5.isConnected(var_1_2) then
			return
		end

		getProxy = var_5
		PlayerProxy = var_1_2

		if not var_5(var_1_2) then
			return
		end

		pg = var_5

		local var_1_3 = var_5.NewStoryMgr.GetInstance()
		local var_1_4 = {}

		local function var_1_5(arg_2_0, arg_2_1)
			pg = var_2_10002

			local var_2_0 = var_2_10002.ConnectionMgr.GetInstance()

			var_2.Send(var_2_0, 11017, {
				story_id = arg_2_0
			}, 11018, function(arg_3_0)
				local var_3_0 = var_1_3

				var_1.SetPlayedFlag(var_3_0, arg_2_0)

				PlayerConst = var_1

				local var_3_1 = var_1.addTranDrop(arg_3_0.drop_list)

				table = var_3_10002

				var_3_10002.insertto(var_1_4, var_3_1)

				if arg_2_1 then
					arg_2_1()
				end

				return
			end)

			return
		end

		local function var_1_6(arg_4_0, arg_4_1)
			local var_4_0 = var_1_3
			local var_4_1, var_4_2 = var_2.StoryName2StoryId(var_4_0, arg_4_0)
			local var_4_3 = {}

			if var_4_1 and 0 < var_4_1 then
				local var_4_4 = var_1_3

				if not var_5.GetPlayedFlag(var_4_4, var_4_1) then
					table = var_5

					var_5.insert(var_4_3, function(arg_5_0)
						var_1_5(var_4_1, arg_5_0)

						return
					end)
				end
			end

			if var_4_2 and 0 < var_4_2 then
				local var_4_5 = var_1_3

				if not var_5.GetPlayedFlag(var_4_5, var_4_2) then
					table = var_5

					var_5.insert(var_4_3, function(arg_6_0)
						var_1_5(var_4_2, arg_6_0)

						return
					end)
				end
			end

			parallelAsync = var_5

			var_5(var_4_3, arg_4_1)

			return
		end

		local var_1_7 = var_1_3
		local var_1_8

		if not var_1_3.StoryLinkNames(var_1_7, var_1_0) then
			var_1_8 = {}
		end

		table = var_1_10010

		var_1_10010.insert(var_1_8, var_1_0)

		local var_1_9 = {}

		ipairs = var_1_7

		for iter_1_0, iter_1_1 in var_1_7(var_1_8) do
			table = var_1_10016

			var_1_10016.insert(var_1_9, function(arg_7_0)
				var_1_6(iter_1_1, arg_7_0)

				return
			end)
		end

		seriesAsync = var_11

		var_11(var_1_9, function()
			existCall = var_2_10000

			var_2_10000(var_1_1)

			local var_8_0 = arg_1_0
			local var_8_1 = var_0.sendNotification

			GAME = var_2_10003

			var_8_1(var_8_0, var_2_10003.STORY_UPDATE_DONE, {
				storyName = var_1_0,
				awards = var_1_4
			})

			return
		end)

		return
	end
end

return var_0_1
