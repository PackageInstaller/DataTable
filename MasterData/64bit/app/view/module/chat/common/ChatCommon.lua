local ChatCommon = class("ChatCommon")
local var_0_1 = g.core.const.ConstMgr.ChatConst

function ChatCommon:getChannelTitle(arg_1_1)
	return g.core.lang:get(arg_1_1 == var_0_1.WORLD and 109001 or arg_1_1 == var_0_1.SYSTEM and 109002 or arg_1_1 == var_0_1.ARMY and 109004 or arg_1_1 == var_0_1.TROOPS and 109005 or arg_1_1 == var_0_1.SINGLE and 109006 or arg_1_1 == var_0_1.GUILD_WAR and 109007 or arg_1_1 == var_0_1.GVE and 109054 or arg_1_1 == var_0_1.BOUNTY and 109069 or arg_1_1 == var_0_1.TEAM_BATTLE and 109005 or arg_1_1 == var_0_1.TEAM_BATTLE_ZONE and 427100 or arg_1_1 == var_0_1.ALLIANCE and 428520 or arg_1_1 == var_0_1.NEW_SLG and 429544 or arg_1_1 == var_0_1.ANCIENTS and 433400 or arg_1_1 == var_0_1.ANNIVERSARY and 431662 or 109003)
end

function ChatCommon:getSpecialContent(arg_2_1)
	local var_2_0 = g.core.utils.Table.convertListToMap(arg_2_1.special_params)

	var_2_0.time = g.core.common.ServerTime:getTimeStringHMS(arg_2_1.time or 0)

	if tonumber(var_2_0.position) then
		var_2_0.position = g.core.config.guild_right_info.get(tonumber(var_2_0.position)).name
	end

	if var_2_0.redpacket then
		var_2_0.redpacket = g.core.config.language_info.get(var_2_0.redpacket).value
	end

	if var_2_0.buff_nameL then
		var_2_0.buff_nameL = g.core.config.language_info.get(var_2_0.buff_nameL).value
	end

	if var_2_0.awardL then
		var_2_0.awardL = g.core.lang:get(var_2_0.awardL)
	end

	return g.core.utils.String.dealMailStr(g.core.config.guild_news_info.get(arg_2_1.special_id).news, var_2_0)
end

function ChatCommon:getTopJson()
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs(g.core.common.Storage:load("topPrivateChatUid.json", true) or {}) do
		var_3_0[tonumber(iter_3_0)] = tonumber(iter_3_1)
	end

	return var_3_0
end

function ChatCommon:setTopJson(arg_4_1)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		var_4_0[tostring(iter_4_0)] = iter_4_1
	end

	g.core.common.Storage:save("topPrivateChatUid.json", var_4_0, true)
end

return ChatCommon
