local var_0_0 = {}
local var_0_1

function var_0_0:TryToCheckForeignDetailInfo(arg_1_1, arg_1_2)
	if arg_1_1 == tostring(PlayerData:GetPlayerInfo().userID) then
		OpenPageUntilLoaded("/userinfo", {
			maskScene = arg_1_2
		}, ViewConst.SYSTEM_ID.PLAYER_INFO)

		return
	end

	local var_1_0 = FriendsData:GetInfoByID(arg_1_1)

	if var_1_0 and var_1_0.relationship == FriendsConst.FRIEND_TYPE.BLACKLIST then
		ShowTips("BLACKLIST_TIP")

		return
	end

	var_0_1 = arg_1_2

	manager.net:SendWithLoadingNew(32018, {
		user_id = arg_1_1
	}, 32019, handler(self, self.OnTryToCheckForeignDetailInfo))
end

function var_0_0.OnTryToCheckForeignDetailInfo(arg_2_0, arg_2_1, arg_2_2)
	if isSuccess(arg_2_1.result) then
		ForeignInfoData:SetCurForeignDetailInfo(arg_2_1)
		OpenPageUntilLoaded("/playerinfo", {
			isForeign = true,
			maskScene = var_0_1
		})
		manager.notify:CallUpdateFunc(CHECK_FOREIGN_INFO, {
			isForeign = true
		})

		var_0_1 = nil
	else
		ShowTips(arg_2_1.result)
	end
end

function var_0_0.TryToCheckForeignHeroInfo(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_3 = arg_3_3 or 1

	manager.net:SendWithLoadingNew(32020, {
		user_id = arg_3_1,
		type = arg_3_3
	}, 32021, function(arg_4_0, arg_4_1)
		if isSuccess(arg_4_0.result) then
			ForeignInfoData:SetForeignHeroInfo(arg_4_0.hero_list or {})
			ForeignInfoData:SetForeignOathInfo(arg_4_0.hero_oath_display)

			if arg_3_4 then
				arg_3_4()
			end
		else
			ShowTips(arg_4_0.result)
		end
	end)
end

function var_0_0:GetSimpleForeignInfo(arg_5_1)
	manager.net:SendWithLoadingNew(32036, {
		user_id_list = arg_5_1
	}, 32037, handler(self, self.OnGetSimpleForeignInfo))
end

function var_0_0.OnGetSimpleForeignInfo(arg_6_0, arg_6_1, arg_6_2)
	if isSuccess(arg_6_1.result) then
		manager.notify:CallUpdateFunc(GET_SIMPLE_FOREIGN_INFO, arg_6_1.user_brief_list)
	else
		ShowTips(arg_6_1.result)
	end
end

local var_0_2

function var_0_0:SearchGuildInfo(arg_7_1, arg_7_2)
	var_0_2 = arg_7_2

	manager.net:SendWithLoadingNew(31028, {
		id = arg_7_1
	}, 31029, handler(self, self.OnSearchGuildInfo))
end

function var_0_0.OnSearchGuildInfo(arg_8_0, arg_8_1, arg_8_2)
	if isSuccess(arg_8_1.result) then
		GuildData:SetCacheGuildInfo(arg_8_1.club_base_info)
		JumpTools.OpenPageByJump("guildInfo", {
			guildID = arg_8_2.id,
			source = var_0_2
		})

		var_0_2 = nil
	else
		ShowTips(arg_8_1.result)
	end
end

return var_0_0
