class = var_0_10000

local var_0_0 = "GuildMemberMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.OPEN_DESC_INFO = "GuildMemberMediator:OPEN_DESC_INFO"
var_0_1.FIRE = "GuildMemberMediator:FIRE"
var_0_1.SET_DUTY = "GuildMemberMediator:SET_DUTY"
var_0_1.IMPEACH = "GuildMemberMediator:IMPEACH"
var_0_1.GET_RANK = "GuildMemberMediator:GET_RANK"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)
	local var_1_1 = var_1.getData(var_1_0)
	local var_1_2 = arg_1_0.viewComponent

	var_3.setPlayerVO(var_1_2, var_1_1)

	getProxy = var_3
	GuildProxy = var_1_2

	local var_1_3 = var_3(var_1_2)
	local var_1_4 = arg_1_0.viewComponent

	var_4.setGuildVO(var_1_4, var_1_3:getData())
	arg_1_0:bind(var_0_1.GET_RANK, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.GUILD_GET_RANK, {
			id = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_DESC_INFO, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_3_2 = var_2_10005.FRIEND_SEARCH
		local var_3_3 = {}

		SearchFriendCommand = var_2_10007
		var_3_3.type = var_2_10007.SEARCH_TYPE_RESUME
		var_3_3.keyword = arg_3_1.id

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end)
	arg_1_0:bind(var_0_1.FIRE, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.GUILD_FIRE, arg_4_1)

		return
	end)
	arg_1_0:bind(var_0_1.SET_DUTY, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10006

		var_5_1(var_5_0, var_2_10006.SET_GUILD_DUTY, {
			playerId = arg_5_1,
			dutyId = arg_5_2
		})

		return
	end)

	local var_1_5 = arg_1_0

	arg_1_0.bind(var_1_5, var_0_1.IMPEACH, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10005

		var_6_1(var_6_0, var_2_10005.GUILD_IMPEACH, arg_6_1)

		return
	end)

	getProxy = var_4
	GuildProxy = var_1_5

	local var_1_6 = var_4(var_1_5)
	local var_1_7 = var_4.GetRanks(var_1_6)
	local var_1_8 = arg_1_0.viewComponent

	var_5.SetRanks(var_1_8, var_1_7)

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	GuildProxy = var_1_10002
	var_7_0[1] = var_1_10002.GUILD_UPDATED
	GAME = var_2
	var_7_0[2] = var_2.SET_GUILD_DUTY_DONE
	GAME = var_2
	var_7_0[3] = var_2.GUILD_FIRE_DONE
	GAME = var_2
	var_7_0[4] = var_2.FRIEND_SEARCH_DONE
	GAME = var_2
	var_7_0[5] = var_2.GUILD_GET_RANK_DONE

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.getName(var_8_0)
	local var_8_2 = arg_8_1:getBody()

	GuildProxy = var_8_0

	if var_8_1 == var_8_0.GUILD_UPDATED then
		local var_8_3 = arg_8_0.viewComponent

		var_4.setGuildVO(var_8_3, var_8_2)

		local var_8_4 = arg_8_0.viewComponent

		var_4.RefreshMembers(var_8_4)
	else
		GAME = var_4

		if var_8_1 == var_4.SET_GUILD_DUTY_DONE then
			local var_8_5 = arg_8_0.viewComponent

			var_4.LoadPainting(var_8_5, var_8_2)
		else
			GAME = var_4

			if var_8_1 == var_4.GUILD_FIRE_DONE then
				local var_8_6 = arg_8_0.viewComponent

				var_4.ActiveDefaultMenmber(var_8_6)
			else
				GAME = var_4

				local var_8_7

				if var_8_1 == var_4.FRIEND_SEARCH_DONE then
					var_8_7 = var_8_2.list[1]

					local var_8_8 = arg_8_0.viewComponent

					var_5.ShowInfoPanel(var_8_8, var_8_7)
				else
					GAME = var_8_7

					if var_8_1 == var_8_7.GUILD_GET_RANK_DONE then
						local var_8_9 = var_8_2.id
						local var_8_10 = var_8_2.list
						local var_8_11 = arg_8_0.viewComponent

						var_6.UpdateRankList(var_8_11, var_8_9, var_8_10)
					end
				end
			end
		end
	end

	return
end

return var_0_1
