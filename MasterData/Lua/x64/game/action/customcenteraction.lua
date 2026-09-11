return {
	SwitchHeroRandom = function(arg_1_0, arg_1_1)
		PlayerAction.SetIsRandomHero(arg_1_0, function()
			arg_1_1()
		end)
	end,
	SaveRandomHeroSkinList = function(arg_3_0)
		PlayerData:SetClearHeroFlag(false)
		PlayerAction.SetRandomHeroList(PlayerData:GetCacheHeroSkinList(), function()
			arg_3_0()
		end)
	end,
	SwitchSceneRandom = function(arg_5_0, arg_5_1)
		HomeSceneSettingAction.SetIsRandomScene(arg_5_0, function()
			arg_5_1()
		end)
	end,
	SaveRandomSceneList = function(arg_7_0)
		HomeSceneSettingData:SetClearSceneFlag(false)
		HomeSceneSettingAction.SetRandomSceneList(HomeSceneSettingData:GetCacheRandomSceneList(), function()
			arg_7_0()
		end)
	end,
	GetValidHeroSkin = function()
		local var_9_0 = PlayerData:GetPosterGirlHeroSkinId()

		if not CustomCenterTools.IsValidHeroSkin(SkinCfg[var_9_0].hero, var_9_0) then
			local var_9_1 = CustomCenterTools.GetValidHeroSkin(SkinCfg[var_9_0].hero)

			if CustomCenterTools.IsRandomHero() then
				CustomCenterTools.UpdateCacheRandomHeroSkinID(var_9_0)

				if not CustomCenterTools.IsContentRandomHeroSkinID(var_9_1) then
					CustomCenterTools.UpdateCacheRandomHeroSkinID(var_9_1)
				end

				CustomCenterAction.SaveRandomHeroSkinList(function()
					manager.notify:Invoke(CUSTOM_CENTER_UPDATE_RANDOM_HERO_SKIN_LIST)
				end)
			else
				HeroAction.SelectSkin(SkinCfg[var_9_1].hero, var_9_1)
				PlayerAction.ChangePosterGirl(SkinCfg[var_9_1].hero)
			end

			return var_9_1
		end

		return var_9_0
	end
}
