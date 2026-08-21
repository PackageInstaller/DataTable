local var_0_0 = require("cjson")
local var_0_1 = {}

JUDGE_MESSAGE_TYPE = {
	GUILD_NOTICE = 4,
	CHAT_GUILD = 6,
	GUILD_NAME = 3,
	GUILD_NAME_LOGIN = 10,
	PLAYER_SIGN_LOGIN = 9,
	ACTIVITY_MOON_CAKE = 1001,
	PLAYER_NAME = 1,
	GUILD_SHARE = 12,
	GUILD_ACTIVITY = 13,
	PLAYER_NAME_LOGIN = 5,
	PLAYER_SIGN = 2,
	OTHER = 500,
	CHAT_FRIEND = 8,
	GUILD_NOTICE_LOGIN = 11,
	CHAT_OTHER = 501,
	CHAT_WORLD = 7,
	DORM_TEMPLATE = 14
}

function var_0_1.JudgePlayerInfo()
	local var_1_0 = PlayerData:GetPlayerInfo()

	var_0_1.JudgeKeyAndPush(var_1_0.nick, JUDGE_MESSAGE_TYPE.PLAYER_NAME_LOGIN)
	var_0_1.JudgeKeyAndPush(var_1_0.sign, JUDGE_MESSAGE_TYPE.PLAYER_SIGN_LOGIN)

	local var_1_1 = GuildData:GetGuildInfo()

	if var_1_1 and var_1_1.id and var_1_1.id ~= 0 then
		var_0_1.JudgeKeyAndPush(var_1_1.name, JUDGE_MESSAGE_TYPE.GUILD_NAME_LOGIN)
		var_0_1.JudgeKeyAndPush(var_1_1.notice, JUDGE_MESSAGE_TYPE.GUILD_NOTICE_LOGIN)
	end
end

function var_0_1.JudgeKeyAndPush(arg_2_0, arg_2_1)
	WordVerifyBySDK(arg_2_0, function(arg_3_0, arg_3_1)
		return
	end, arg_2_1)
end

function var_0_1.SendMessageToSDK(arg_4_0, arg_4_1)
	local var_4_0 = {}
	local var_4_1 = var_0_0.encode(arg_4_1)

	table.insert(var_4_0, {
		event_name = arg_4_0,
		attribute_json = var_4_1
	})
	print(string.format("sendMessageToSDK(GS), eventId = %s, message = %s", arg_4_0, var_4_1))
	manager.net:Push(38014, {
		log_list = var_4_0
	})
end

return var_0_1
