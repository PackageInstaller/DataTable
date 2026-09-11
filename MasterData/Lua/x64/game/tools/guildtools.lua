return {
	CheckCanExitGuild = function(arg_1_0)
		if ActivityData:GetActivityIsOpen(ActivityConst.GUILD_ACTIVITY_START) then
			ShowTips("ACTIVITY_CLUB_ACTIVITYING_REMOVE_MEMBER_TIP")

			return false
		end

		if ActivityData:GetActivityIsOpen((GuildActivitySPData:GetCurRunActivityID())) then
			ShowTips(GuildActivitySpTools.GetCurOpenActivityStateInfo().removeMenber)

			return false
		end

		return true
	end
}
