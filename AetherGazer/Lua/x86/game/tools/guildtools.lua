return {
	CheckCanExitGuild = function(arg_1_0)
		if ActivityData:GetActivityIsOpen(ActivityConst.GUILD_ACTIVITY_START) then
			ShowTips("ACTIVITY_CLUB_ACTIVITYING_REMOVE_MEMBER_TIP")

			return false
		end

		local var_1_0 = GuildActivitySPData:GetCurRunActivityID()

		if ActivityData:GetActivityIsOpen(var_1_0) then
			local var_1_1 = GuildActivitySpTools.GetCurOpenActivityStateInfo()

			ShowTips(var_1_1.removeMenber)

			return false
		end

		return true
	end
}
