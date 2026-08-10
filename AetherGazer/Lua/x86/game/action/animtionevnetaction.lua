return {
	OnAnimtionEvent = function(arg_1_0)
		print("Animation Event key = " .. arg_1_0)

		if arg_1_0 == "EquipEnchantSuccess" or arg_1_0 == "EquipEnchantConfirm" then
			manager.notify:CallUpdateFunc(EQUIP_ENCHANT_ANIMATION_EVENT, arg_1_0)
		elseif arg_1_0 == "MythicLinePlayEnd" then
			manager.notify:CallUpdateFunc(MYTHIC_ANIMATION_EVENT, arg_1_0)
		elseif arg_1_0 == "OnSevenSignBeginEvent" then
			manager.notify:CallUpdateFunc(SEVEN_DAY_SIGN_ANIMATION_EVENT, arg_1_0)
		elseif arg_1_0 == "GuildActivityEnterLevel" then
			manager.notify:CallUpdateFunc(GUILD_ACTIVITY_ENTER_LEVEL_ANIMATION, arg_1_0)
		else
			manager.notify:CallUpdateFunc(OBTAIN_HERO_MOVIE_ANIMATION, arg_1_0)
		end
	end
}
