local var_0_0 = {}
local var_0_1 = {}

if not _G.deviceInfo then
	local var_0_2 = {}
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
	tutorial = function(arg_3_0)
		if arg_3_0.guideId == 6 then
			var_0_1 = {
				af_customer_user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime()
			}

			SDKTools.SetParamsAttribute("af_tutorial_completion", var_0_1)
		end
	end,
	day_retention = function(arg_4_0)
		local var_4_0 = arg_4_0.diff

		var_0_1 = {
			af_customer_user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime()
		}

		SDKTools.SetParamsAttribute("af_retention_day" .. tostring(var_4_0 + 1), var_0_1)
	end,
	purchase_ys = function(arg_5_0)
		var_0_1 = {
			af_customer_user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime(),
			af_currency = arg_5_0.currency_type,
			af_revenue = arg_5_0.value
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
	charge_Total = function(arg_8_0)
		if arg_8_0.total >= 250 and arg_8_0.total < 648 then
			var_0_1 = {
				af_customer_user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime()
			}

			SDKTools.SetParamsAttribute("af_payment_achieved250", var_0_1)
		end

		if arg_8_0.total >= 648 then
			var_0_1 = {
				af_customer_user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime()
			}

			SDKTools.SetParamsAttribute("af_payment_achieved648", var_0_1)
		end
	end,
	role_level = function(arg_9_0)
		var_0_1 = {
			af_customer_user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime()
		}

		if arg_9_0.level == 16 or arg_9_0.level == 21 or arg_9_0.level == 30 then
			SDKTools.SetParamsAttribute("af_level_achieved" .. tostring(arg_9_0.level), var_0_1)
		end
	end,
	task_finish = function(arg_10_0)
		if arg_10_0.taskId == 160011 then
			SDKTools.SetBaseAttribute("af_task_finish")
		end
	end,
	passStage = function(arg_11_0)
		if arg_11_0.passStage[1010305] then
			SDKTools.SetBaseAttribute("af_pass_stage")
		end
	end,
	changePosterGirl = function()
		SDKTools.SetBaseAttribute("af_changePosterGirl")
	end
}

return var_0_0
