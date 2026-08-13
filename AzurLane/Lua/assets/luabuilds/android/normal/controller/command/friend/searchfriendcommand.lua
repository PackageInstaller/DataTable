class = var_0_10000

local var_0_0 = "SearchFriendCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

var_0_1.SEARCH_TYPE_LIST = 1
var_0_1.SEARCH_TYPE_RESUME = 2
var_0_1.SEARCH_TYPE_FRIEND = 3

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().type
	local var_1_1

	if var_2.keyword then
		string = var_1_10005
		var_1_1 = var_1_10005.gsub(var_1_1, "^%s*(.-)%s*$", "%1")
	end

	local var_1_2

	tonumber = var_1_10006

	local var_1_3 = var_1_10006(var_1_1) and 0 or 1

	if var_1_0 == var_0_1.SEARCH_TYPE_LIST then
		pg = var_6

		local var_1_4 = var_6.ConnectionMgr.GetInstance()

		var_6.Send(var_1_4, 50014, {
			type = 0
		}, 50015, function(arg_2_0)
			local var_2_0 = {}

			ipairs = var_2_10002

			for iter_2_0, iter_2_1 in var_2_10002(arg_2_0.player_list) do
				table = var_2_10007
				var_2_10007 = var_2_10007.insert

				local var_2_1 = var_2_0

				Friend = var_2_10009

				var_2_10007(var_2_1, var_2_10009.New(iter_2_1))
			end

			local var_2_2 = arg_1_0
			local var_2_3 = var_2.sendNotification

			GAME = var_4

			var_2_3(var_2_2, var_4.FRIEND_SEARCH_DONE, {
				type = var_1_0,
				list = var_2_0
			})

			return
		end)
	elseif var_1_0 == var_0_1.SEARCH_TYPE_RESUME or var_1_0 == var_0_1.SEARCH_TYPE_FRIEND then
		pg = var_6

		local var_1_5 = var_6.ConnectionMgr.GetInstance()
		local var_1_6 = var_6.Send
		local var_1_7 = 50001
		local var_1_8 = {
			type = var_1_3
		}

		tostring = var_1_10010
		var_1_8.keyword = var_1_10010(var_1_1)

		var_1_6(var_1_5, var_1_7, var_1_8, 50002, function(arg_3_0)
			local var_3_0 = {}
			local var_3_1

			if arg_3_0.result == 0 then
				table = var_3_1
				var_3_1 = var_3_1.insert

				local var_3_2 = var_3_0

				Friend = var_2_10004

				var_3_1(var_3_2, var_2_10004.New(arg_3_0.player))
			else
				pg = var_3_1

				local var_3_3 = var_3_1.TipsMgr.GetInstance()
				local var_3_4 = var_2.ShowTips

				i18n = var_2_10004

				var_3_4(var_3_3, var_2_10004("friend_searchFriend_noPlayer"))
			end

			local var_3_5 = arg_1_0
			local var_3_6 = var_2.sendNotification

			GAME = var_2_10004

			var_3_6(var_3_5, var_2_10004.FRIEND_SEARCH_DONE, {
				type = var_1_0,
				list = var_3_0
			})

			return
		end)
	end

	return
end

return var_0_1
