local var_0_0 = class("UpdateStoryCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.storyId
	local var_1_2 = var_1_0.callback

	assert(type(var_1_0.storyId) == "string")

	if pg.ConnectionMgr.GetInstance():getConnection() then
		if not pg.ConnectionMgr.GetInstance():isConnected() then
			return
		end

		if not getProxy(PlayerProxy) then
			return
		end

		local var_1_3 = pg.NewStoryMgr.GetInstance()
		local var_1_4 = {}

		local function var_1_5(arg_2_0, arg_2_1)
			pg.ConnectionMgr.GetInstance():Send(11017, {
				story_id = arg_2_0
			}, 11018, function(arg_3_0)
				var_1_3:SetPlayedFlag(arg_2_0)
				table.insertto(var_1_4, (PlayerConst.addTranDrop(arg_3_0.drop_list)))

				if arg_2_1 then
					arg_2_1()
				end

				return
			end)

			return
		end

		local function var_1_6(arg_4_0, arg_4_1)
			local var_4_0, var_4_1 = var_1_3:StoryName2StoryId(arg_4_0)

			if var_4_0 and var_4_0 > 0 and not var_1_3:GetPlayedFlag(var_4_0) then
				table.insert({}, function(arg_5_0)
					var_1_5(var_4_0, arg_5_0)

					return
				end)
			end

			if var_4_1 and var_4_1 > 0 and not var_1_3:GetPlayedFlag(var_4_1) then
				table.insert({}, function(arg_6_0)
					var_1_5(var_4_1, arg_6_0)

					return
				end)
			end

			parallelAsync({}, arg_4_1)

			return
		end

		local var_1_7 = var_1_3:StoryLinkNames(var_1_1) or {}

		table.insert(var_1_7, var_1_1)

		for iter_1_0, iter_1_1 in ipairs(var_1_7) do
			table.insert({}, function(arg_7_0)
				var_1_6(iter_1_1, arg_7_0)

				return
			end)
		end

		seriesAsync({}, function()
			existCall(var_1_2)
			arg_1_0:sendNotification(GAME.STORY_UPDATE_DONE, {
				storyName = var_1_1,
				awards = var_1_4
			})

			return
		end)

		return
	end
end

return var_0_0
