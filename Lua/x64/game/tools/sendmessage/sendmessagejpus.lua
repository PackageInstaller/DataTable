local var_0_0 = {}
local var_0_1 = {}

var_0_0.typeToFunction = {
	role_create = function(arg_1_0)
		var_0_1 = {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			role_name = arg_1_0.curNameText
		}

		SDKTools.SetParamsAttribute("role_create", var_0_1)
	end,
	purchase_complete_skin = function()
		SDKTools.SetBaseAttribute("purchase_complete_SKIN")
	end,
	guild_join = function()
		SDKTools.SetBaseAttribute("guild_join")
	end,
	purchase_crystal = function(arg_4_0)
		var_0_1 = {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			num = arg_4_0.purchaseNum
		}

		SDKTools.SetParamsAttribute("purchase_crystal", var_0_1)
	end,
	passport_complete = function()
		SDKTools.SetBaseAttribute("purchase_click_MONTLYCARD")
	end,
	purchase_click_montlycard = function()
		SDKTools.SetBaseAttribute("purchase_click_MONTLYCARD")
	end,
	roll_complete_10 = function()
		SDKTools.SetBaseAttribute("roll_complete_10")
	end,
	gacha_complete = function()
		SDKTools.SetBaseAttribute("gacha_complete")
	end,
	limited_gacha_complete = function()
		SDKTools.SetBaseAttribute("limited_gacha_complete")
	end,
	roll_complete_140 = function(arg_10_0)
		var_0_1 = {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			pool_id = arg_10_0.poolID
		}

		SDKTools.SetParamsAttribute("roll_complete_140", var_0_1)
	end,
	roll_complete_40 = function()
		SDKTools.SetBaseAttribute("roll_complete_40")
	end,
	purchase_click_gp_once = function()
		SDKTools.SetBaseAttribute("purchase_click_GP_ONCE")
	end,
	purchase_click_skin = function()
		SDKTools.SetBaseAttribute("purchase_click_SKIN")
	end,
	role_login = function()
		SDKTools.SetBaseAttribute("role_login")
	end,
	day_retention = function()
		local var_15_0 = getData("SDK", "register_timestamp")
		local var_15_1 = manager.time:DiffDay2(var_15_0, manager.time:GetServerTime())

		var_0_1 = {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			days = var_15_1
		}

		SDKTools.SetParamsAttribute("day_retention", var_0_1)
	end,
	account_create_ys = function()
		local var_16_0 = PlayerPrefs.GetString("AccountID")

		var_0_1 = {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			account_id = var_16_0
		}

		SDKTools.SetParamsAttribute("account_create_ys", var_0_1)
	end,
	day_retention_return = function()
		local var_17_0 = getData("SDK", "continueTime")

		var_0_1 = {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			days = var_17_0 + 1
		}

		SDKTools.SetParamsAttribute("day_retention_return", var_0_1)
	end,
	purchase_complete_montlycard = function()
		SDKTools.SetBaseAttribute("purchase_complete_MONTLYCARD")
	end,
	purchase_first_ys = function()
		SDKTools.SetBaseAttribute("purchase_first_ys")
	end,
	purchase_complete = function()
		SDKTools.SetBaseAttribute("purchase_complete")
	end,
	purchase_ys = function(arg_21_0)
		var_0_1 = {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			payment = arg_21_0.value,
			order_id = arg_21_0.order_id
		}

		SDKTools.SetParamsAttribute("purchase_ys", var_0_1)
	end,
	purchase_click = function()
		SDKTools.SetBaseAttribute("purchase_click")
	end,
	unlockStage = function(arg_23_0)
		if arg_23_0.chapterID == 2011 then
			SDKTools.SetBaseAttribute("coin_stage5")
		elseif arg_23_0.chapterID == 2012 then
			SDKTools.SetBaseAttribute("mod_ex_stage5")
		elseif arg_23_0.chapterID == 2013 then
			SDKTools.SetBaseAttribute("skillpoint_stage5")
		elseif arg_23_0.chapterID == 2014 then
			SDKTools.SetBaseAttribute("access_key_stage5")
		elseif arg_23_0.chapterID == 2015 then
			SDKTools.SetBaseAttribute("elite_stage5")
		elseif arg_23_0.chapterID == 2016 then
			SDKTools.SetBaseAttribute("mod_elite_stage5")
		elseif arg_23_0.chapterID == 202 then
			SDKTools.SetBaseAttribute("sigil_stage5")
		end
	end,
	add_friend = function()
		SDKTools.SetBaseAttribute("add_friend")
	end,
	role_level = function(arg_25_0)
		var_0_1 = {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			role_level = arg_25_0.level
		}

		if math.floor(arg_25_0.level % 10) == 0 then
			SDKTools.SetParamsAttribute("role_level", var_0_1)
		elseif arg_25_0.level <= 30 and arg_25_0.level > 4 and math.floor(arg_25_0.level % 5) == 0 then
			SDKTools.SetParamsAttribute("role_level", var_0_1)
		end

		if arg_25_0.level == 45 then
			SDKTools.SetBaseAttribute("sigil_stage5")
		end
	end,
	role_logout = function()
		SDKTools.SetBaseAttribute("role_logout")
	end,
	tutorial_complete = function()
		SDKTools.SetBaseAttribute("tutorial_complete")
	end,
	purchase_swigs = function(arg_28_0)
		var_0_1 = {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			times = arg_28_0.buyFatigueNum
		}

		if arg_28_0.buyFatigueNum == 5 then
			SDKTools.SetParamsAttribute("purchase_5swigs", var_0_1)
		elseif arg_28_0.buyFatigueNum == 10 then
			SDKTools.SetParamsAttribute("purchase_10swigs", var_0_1)
		elseif arg_28_0.buyFatigueNum == 20 then
			SDKTools.SetParamsAttribute("purchase_20swigs", var_0_1)
		elseif arg_28_0.buyFatigueNum == 30 then
			SDKTools.SetParamsAttribute("purchase_30swigs", var_0_1)
		end
	end,
	chapter_main = function(arg_29_0)
		var_0_1 = {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			chapter = arg_29_0.passChapter
		}

		SDKTools.SetParamsAttribute("chapter_main", var_0_1)
	end,
	blackzone_clear = function(arg_30_0)
		local var_30_0 = {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			difficult = arg_30_0.partition
		}

		SDKTools.SetParamsAttribute("blackzone_clear", var_30_0)
	end,
	bossrush_star = function(arg_31_0)
		var_0_1 = {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			star_num = arg_31_0.curStarCnt
		}

		SDKTools.SetParamsAttribute("bossrush_star", var_0_1)
	end,
	tutorial = function(arg_32_0)
		var_0_1 = {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			phase = arg_32_0.guideId
		}

		SDKTools.SetParamsAttribute("tutorial", var_0_1)
	end,
	charge_Total = function(arg_33_0)
		if arg_33_0.total >= 50 and arg_33_0.total < 100 then
			SDKTools.SetBaseAttribute("charge_junior")
		elseif arg_33_0.total >= 100 and arg_33_0.total < 500 then
			SDKTools.SetBaseAttribute("charge_medium")
		elseif arg_33_0.total >= 500 then
			SDKTools.SetBaseAttribute("charge_senior")
		end
	end,
	purchase_complete_GP_ONCE = function()
		SDKTools.SetBaseAttribute("purchase_complete_GP_ONCE", var_0_1)
	end
}

return var_0_0
