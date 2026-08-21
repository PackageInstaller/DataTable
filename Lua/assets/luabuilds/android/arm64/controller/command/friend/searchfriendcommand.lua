local var_0_0 = class("SearchFriendCommand", pm.SimpleCommand)

var_0_0.SEARCH_TYPE_LIST = 1
var_0_0.SEARCH_TYPE_RESUME = 2
var_0_0.SEARCH_TYPE_FRIEND = 3

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.type
	local var_1_2 = var_1_0.keyword and string.gsub(var_1_2, "^%s*(.-)%s*$", "%1")
	local var_1_3 = tonumber(var_1_2) and 0 or 1

	if var_1_1 == var_0_0.SEARCH_TYPE_LIST then
		pg.ConnectionMgr.GetInstance():Send(50014, {
			type = 0
		}, 50015, function(arg_2_0)
			for iter_2_0, iter_2_1 in ipairs(arg_2_0.player_list) do
				table.insert({}, Friend.New(iter_2_1))
			end

			arg_1_0:sendNotification(GAME.FRIEND_SEARCH_DONE, {
				type = var_1_1,
				list = {}
			})

			return
		end)
	elseif var_1_1 == var_0_0.SEARCH_TYPE_RESUME or var_1_1 == var_0_0.SEARCH_TYPE_FRIEND then
		pg.ConnectionMgr.GetInstance():Send(50001, {
			type = var_1_3,
			keyword = tostring(var_1_2)
		}, 50002, function(arg_3_0)
			if arg_3_0.result == 0 then
				table.insert({}, Friend.New(arg_3_0.player))
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("friend_searchFriend_noPlayer"))
			end

			arg_1_0:sendNotification(GAME.FRIEND_SEARCH_DONE, {
				type = var_1_1,
				list = {}
			})

			return
		end)
	end

	return
end

return var_0_0
