local var_0_0 = {}
local var_0_1 = import("game.const.HeroConst")
local var_0_2 = import("game.tools.BattleInstance")

function var_0_0.SortShowHero(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {}
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in pairs(arg_1_0) do
		if type(iter_1_1) == "table" then
			local var_1_2 = HeroCfg[iter_1_0]

			var_1_0[iter_1_0] = iter_1_0 + (iter_1_1.level or iter_1_1.hero_level) * 10000 + (iter_1_1.star or iter_1_1.hero_star) * 10000000

			local var_1_3 = table.keyof(arg_1_1, iter_1_0)

			if var_1_3 then
				var_1_0[iter_1_0] = var_1_3 + 100000000 * (4 - var_1_3)
			end

			if arg_1_1[arg_1_2] == iter_1_0 then
				var_1_0[iter_1_0] = var_1_0[iter_1_0] + 1000000000
			end

			if iter_1_1.hero_unlock == 1 or iter_1_1.unlock == 1 then
				table.insert(var_1_1, iter_1_0)
			end
		end
	end

	table.sort(var_1_1, function(arg_2_0, arg_2_1)
		return var_1_0[arg_2_0] > var_1_0[arg_2_1]
	end)

	return var_1_1
end

function var_0_0.PackUserData(arg_3_0)
	local var_3_0 = PlayerData:GetPlayerInfo()

	if var_3_0 == nil then
		return "{}"
	end

	local var_3_1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND)
	local var_3_2 = var_3_0.register_timestamp
	local var_3_3 = var_3_0.userID
	local var_3_4 = var_3_0.nick
	local var_3_5 = var_3_0.userLevel
	local var_3_6 = _G.TMP_SERVER_ID
	local var_3_7 = var_0_2.GetCurrentBattleId()

	return string.format("{\"dataType\" : \"%s\",\"money\" : \"%d\",\"createTime\" : \"%d\",\"roleId\" : \"%s\",\"roleName\" : \"%s\",\"level\" : \"%s\",\"serverId\" : \"%s\",\"chapter\" : \"%s\"}", arg_3_0, var_3_1, var_3_2, tostring(var_3_3), tostring(var_3_4), tostring(var_3_5), tostring(var_3_6), tostring(var_3_7))
end

function var_0_0.GetPlayerFrame(arg_4_0)
	if arg_4_0 then
		return getSpriteWithoutAtlas("TextureConfig/Frame/" .. arg_4_0)
	end
end

function var_0_0.MakeRandomModeData(arg_5_0, arg_5_1)
	return (arg_5_0 and 1 or 0) + arg_5_1 * 10
end

function var_0_0.RandomModeDataIsEnable(arg_6_0)
	return math.fmod(arg_6_0, 10) == 1
end

function var_0_0.RandomModeDataGetMode(arg_7_0)
	return math.floor(arg_7_0 / 10)
end

function var_0_0.UpdateRandomDataAfterLogin()
	local var_8_0 = false
	local var_8_1 = HomeSceneSettingData:GetRandomMode()

	if var_8_1 == HomeSceneSettingConst.RANDOM_MODE.EACH_LOGIN then
		var_0_0.UpdateRandomData(var_8_1)
	elseif var_8_1 == HomeSceneSettingConst.RANDOM_MODE.EACH_DAY then
		local var_8_2 = getData("RandomData", "LastLoginTime_SCENE") or 0
		local var_8_3 = manager.time:GetServerTime()
		local var_8_4 = getData("RandomData", "LastId_SCENE") or 0

		if table.keyof(HomeSceneSettingData:GetRandomSceneList(), var_8_4) == nil or var_8_4 == 0 or var_8_2 == 0 or not manager.time:CheckIsToday(var_8_2, var_8_3) then
			saveData("RandomData", "LastLoginTime_SCENE", var_8_3)
			var_0_0.UpdateRandomData(var_8_1)

			var_8_0 = true
		else
			HomeSceneSettingData:SetRandomScene(var_8_4)
		end
	end

	local var_8_5 = PlayerData:GetRandomHeroMode()

	if var_8_5 == HomeSceneSettingConst.RANDOM_MODE.EACH_LOGIN then
		var_0_0.UpdateRandomData(var_8_5)
	elseif var_8_5 == HomeSceneSettingConst.RANDOM_MODE.EACH_DAY then
		local var_8_6 = getData("RandomData", "LastLoginTime_HERO") or 0
		local var_8_7 = manager.time:GetServerTime()
		local var_8_8 = getData("RandomData", "LastId_HERO") or 0

		if table.keyof(PlayerData:GetRandomHeroList(), var_8_8) == nil or var_8_8 == 0 or var_8_6 == 0 or not manager.time:CheckIsToday(var_8_6, var_8_7) then
			saveData("RandomData", "LastLoginTime_HERO", var_8_7)
			var_0_0.UpdateRandomData(var_8_5)
			saveData("RandomData", "LastId_HERO", PlayerData:GetRandomHero())
		else
			PlayerData:SetRandomHero(var_8_8)
		end
	end

	if var_8_0 then
		saveData("RandomData", "LastId_SCENE", HomeSceneSettingData:GetRandomScene())
	end

	HomeSceneSettingData:SetIsTimeScene(true)
end

function var_0_0.UpdateRandomData(arg_9_0)
	if arg_9_0 == HomeSceneSettingConst.RANDOM_MODE.EACH_ENTER then
		HomeSceneSettingData:SetIsUseDlcScene(PlayerData:IsRandomHeroUseDlcScene())
		HomeSceneSettingData:SetIsSwitchTime(false)
	end

	local var_9_0 = HomeSceneSettingData:GetForceRandomSceneID() ~= nil

	if arg_9_0 == HomeSceneSettingData:GetRandomMode() or var_9_0 then
		HomeSceneSettingData:CalcNextScene()
	end

	local var_9_1 = PlayerData:GetForceRandomHeroID() ~= nil

	if arg_9_0 == PlayerData:GetRandomHeroMode() or var_9_1 then
		PlayerData:CalcNextRandomHero()
	end

	PlayerData:SetForceRandomHeroID(nil)
	HomeSceneSettingData:SetForceRandomSceneID(nil)
end

return var_0_0
