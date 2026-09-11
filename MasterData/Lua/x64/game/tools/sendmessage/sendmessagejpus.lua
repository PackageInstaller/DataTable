local var_0_0 = {}
local var_0_1 = {}

var_0_0.typeToFunction = {
	role_create = function(self)
		var_0_1 = {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			role_name = self.curNameText
		}

		SDKTools.SetParamsAttribute("role_create", var_0_1)
	end,
	purchase_complete_skin = function()
		SDKTools.SetBaseAttribute("purchase_complete_SKIN")
	end,
	guild_join = function()
		SDKTools.SetBaseAttribute("guild_join")
	end,
	purchase_crystal = function(self)
		var_0_1 = {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			num = self.purchaseNum
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
	roll_complete_140 = function(self)
		var_0_1 = {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			pool_id = self.poolID
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
		var_0_1 = {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			days = manager.time:DiffDay2(getData("SDK", "register_timestamp"), manager.time:GetServerTime())
		}

		SDKTools.SetParamsAttribute("day_retention", var_0_1)
	end,
	account_create_ys = function()
		var_0_1 = {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			account_id = PlayerPrefs.GetString("AccountID")
		}

		SDKTools.SetParamsAttribute("account_create_ys", var_0_1)
	end,
	day_retention_return = function()
		var_0_1 = {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			days = getData("SDK", "continueTime") + 1
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
	purchase_ys = function(self)
		var_0_1 = {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			payment = self.value,
			order_id = self.order_id
		}

		SDKTools.SetParamsAttribute("purchase_ys", var_0_1)
	end,
	purchase_click = function()
		SDKTools.SetBaseAttribute("purchase_click")
	end,
	unlockStage = function(self)
		if self.chapterID == 2011 then
			SDKTools.SetBaseAttribute("coin_stage5")
		elseif self.chapterID == 2012 then
			SDKTools.SetBaseAttribute("mod_ex_stage5")
		elseif self.chapterID == 2013 then
			SDKTools.SetBaseAttribute("skillpoint_stage5")
		elseif self.chapterID == 2014 then
			SDKTools.SetBaseAttribute("access_key_stage5")
		elseif self.chapterID == 2015 then
			SDKTools.SetBaseAttribute("elite_stage5")
		elseif self.chapterID == 2016 then
			SDKTools.SetBaseAttribute("mod_elite_stage5")
		elseif self.chapterID == 202 then
			SDKTools.SetBaseAttribute("sigil_stage5")
		end
	end,
	add_friend = function()
		SDKTools.SetBaseAttribute("add_friend")
	end,
	role_level = function(self)
		var_0_1 = {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			role_level = self.level
		}

		if math.floor(self.level % 10) == 0 then
			SDKTools.SetParamsAttribute("role_level", var_0_1)
		elseif self.level <= 30 and self.level > 4 and math.floor(self.level % 5) == 0 then
			SDKTools.SetParamsAttribute("role_level", var_0_1)
		end

		if self.level == 45 then
			SDKTools.SetBaseAttribute("sigil_stage5")
		end
	end,
	role_logout = function()
		SDKTools.SetBaseAttribute("role_logout")
	end,
	tutorial_complete = function()
		SDKTools.SetBaseAttribute("tutorial_complete")
	end,
	purchase_swigs = function(self)
		var_0_1 = {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			times = self.buyFatigueNum
		}

		if self.buyFatigueNum == 5 then
			SDKTools.SetParamsAttribute("purchase_5swigs", var_0_1)
		elseif self.buyFatigueNum == 10 then
			SDKTools.SetParamsAttribute("purchase_10swigs", var_0_1)
		elseif self.buyFatigueNum == 20 then
			SDKTools.SetParamsAttribute("purchase_20swigs", var_0_1)
		elseif self.buyFatigueNum == 30 then
			SDKTools.SetParamsAttribute("purchase_30swigs", var_0_1)
		end
	end,
	chapter_main = function(self)
		var_0_1 = {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			chapter = self.passChapter
		}

		SDKTools.SetParamsAttribute("chapter_main", var_0_1)
	end,
	blackzone_clear = function(self)
		SDKTools.SetParamsAttribute("blackzone_clear", {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			difficult = self.partition
		})
	end,
	bossrush_star = function(self)
		var_0_1 = {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			star_num = self.curStarCnt
		}

		SDKTools.SetParamsAttribute("bossrush_star", var_0_1)
	end,
	tutorial = function(self)
		var_0_1 = {
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			phase = self.guideId
		}

		SDKTools.SetParamsAttribute("tutorial", var_0_1)
	end,
	charge_Total = function(self)
		if self.total >= 50 and self.total < 100 then
			SDKTools.SetBaseAttribute("charge_junior")
		elseif self.total >= 100 and self.total < 500 then
			SDKTools.SetBaseAttribute("charge_medium")
		elseif self.total >= 500 then
			SDKTools.SetBaseAttribute("charge_senior")
		end
	end,
	purchase_complete_GP_ONCE = function()
		SDKTools.SetBaseAttribute("purchase_complete_GP_ONCE", var_0_1)
	end
}

return var_0_0
