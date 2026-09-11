local var_0_0 = {}
local var_0_1 = {}

if not _G.deviceInfo then
	-- block empty
end

var_0_0.typeToFunction = {
	account_create_ys = function()
		var_0_1 = {
			af_customer_user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			yongshi_id = _G.YONGSHI_ID
		}

		SDKTools.SetParamsAttribute("af_complete_registration", var_0_1)
	end,
	role_login = function()
		var_0_1 = {
			af_customer_user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			role_name = PlayerData:GetPlayerInfo().nick
		}

		SDKTools.SetParamsAttribute("af_login", var_0_1)
	end,
	tutorial = function(self)
		if self.guideId == 6 then
			var_0_1 = {
				af_customer_user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime()
			}

			SDKTools.SetParamsAttribute("af_tutorial_completion", var_0_1)
		end
	end,
	day_retention = function(self)
		var_0_1 = {
			af_customer_user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime()
		}

		SDKTools.SetParamsAttribute("af_retention_day" .. tostring(self.diff + 1), var_0_1)
	end,
	purchase_ys = function(self)
		var_0_1 = {
			af_customer_user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			af_currency = self.currency_type,
			af_revenue = self.value
		}

		SDKTools.SetParamsAttribute("af_purchase", var_0_1)
	end,
	purchase_complete_montlycard = function()
		var_0_1 = {
			af_customer_user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime()
		}

		SDKTools.SetParamsAttribute("af_purchase_montlycard", var_0_1)
	end,
	purchase_first_ys = function()
		var_0_1 = {
			af_customer_user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime()
		}

		SDKTools.SetParamsAttribute("af_purchase_first", var_0_1)
	end,
	charge_Total = function(self)
		if self.total >= 250 and self.total < 648 then
			var_0_1 = {
				af_customer_user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime()
			}

			SDKTools.SetParamsAttribute("af_payment_achieved250", var_0_1)
		end

		if self.total >= 648 then
			var_0_1 = {
				af_customer_user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime()
			}

			SDKTools.SetParamsAttribute("af_payment_achieved648", var_0_1)
		end
	end,
	role_level = function(self)
		var_0_1 = {
			af_customer_user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime()
		}

		if self.level == 16 or self.level == 21 or self.level == 30 then
			SDKTools.SetParamsAttribute("af_level_achieved" .. tostring(self.level), var_0_1)
		end
	end,
	task_finish = function(self)
		if self.taskId == 160011 then
			SDKTools.SetBaseAttribute("af_task_finish")
		end
	end,
	passStage = function(self)
		if self.passStage[1010305] then
			SDKTools.SetBaseAttribute("af_pass_stage")
		end
	end,
	changePosterGirl = function()
		SDKTools.SetBaseAttribute("af_changePosterGirl")
	end
}

return var_0_0
