local var_0_0 = {}
local var_0_1 = {}
local var_0_2 = _G.deviceInfo or {}

var_0_0.typeToFunction = {
	role_create = function()
		SDKTools.SetParamsAttribute("af_Createrole", {
			subType = 0
		})
		SDKTools.SetParamsAttribute("Fire_Createrole", {
			subType = 0
		})
	end,
	SDKLogin = function()
		var_0_1 = {
			load_name = "SDK登录触发",
			load_id = 1014,
			load_time = 0,
			sub_id = var_0_2.subId,
			model = tostring(var_0_2.model)
		}

		SDKTools.SetParamsAttribute("game_start", var_0_1)
	end,
	SDKLoginSuccess = function()
		var_0_1 = {
			load_name = "SDK登录成功",
			load_id = 1016,
			load_time = 0,
			sub_id = var_0_2.subId,
			model = tostring(var_0_2.model)
		}

		SDKTools.SetParamsAttribute("game_start", var_0_1)
	end,
	SDKLoginFailed = function()
		var_0_1 = {
			load_name = "SDK登录报错",
			load_id = 1015,
			load_time = 0,
			sub_id = var_0_2.subId,
			model = tostring(var_0_2.model)
		}

		SDKTools.SetParamsAttribute("game_start", var_0_1)
	end,
	purchase_complete_skin = function()
		SDKTools.SetParamsAttribute("af_buy_skin", {
			subType = 0
		})
		SDKTools.SetParamsAttribute("Fire_buy_skin", {
			subType = 0
		})
	end,
	purchase_crystal = function(arg_6_0)
		SDKTools.SetParamsAttribute("af_buy_pay" .. tostring(arg_6_0.purchaseNum), {
			subType = 0
		})
		SDKTools.SetParamsAttribute("Fire_buy_pay" .. tostring(arg_6_0.purchaseNum), {
			subType = 0
		})
	end,
	roll_complete_1 = function()
		SDKTools.SetParamsAttribute("Fire_SUMMON_1", {
			subType = 0
		})
		SDKTools.SetParamsAttribute("af_SUMMON_1", {
			subType = 0
		})
	end,
	roll_complete_10 = function()
		SDKTools.SetParamsAttribute("Fire_SUMMON_10", {
			subType = 0
		})
		SDKTools.SetParamsAttribute("af_SUMMON_10", {
			subType = 0
		})
	end,
	gacha_complete = function()
		SDKTools.SetParamsAttribute("af_SUMMON_New", {
			subType = 0
		})
		SDKTools.SetParamsAttribute("Fire_SUMMON_New", {
			subType = 0
		})
	end,
	role_login = function()
		SDKTools.SetParamsAttribute("Fire_login", {
			subType = 0
		})

		var_0_1 = {
			sub_id = var_0_2.subId
		}

		SDKTools.SetParamsAttribute("account_login", var_0_1)

		var_0_1 = {
			AFInAppEventType = "LOGIN",
			subType = 0,
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime()
		}

		SDKTools.SetParamsAttribute("af_login", var_0_1)
	end,
	account_create_ys = function()
		var_0_1 = {
			sub_id = tostring(var_0_2.subId),
			model = tostring(var_0_2.model),
			os_version = tostring(var_0_2 and var_0_2.system or nil),
			ram = tostring(UnityEngine.SystemInfo.systemMemorySize),
			rom = tostring(LuaForUtil.GetFreeDiskSpace()),
			cpu_hardware = _G.CPUINFO,
			network = _G.NETTYPE,
			mac = tostring(var_0_2.mac),
			ip = _G.TCP_ADDR
		}

		SDKTools.SetParamsAttribute("register", var_0_1)
		SDKTools.SetParamsAttribute("Fire_completeregistration", {
			subType = 0
		})

		var_0_1 = {
			AFInAppEventType = "COMPLETE_REGISTRATION",
			subType = 0,
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime()
		}

		SDKTools.SetParamsAttribute("af_completeregistration", var_0_1)
	end,
	purchase_first_ys = function()
		SDKTools.SetParamsAttribute("af_FirstPurchase", {
			subType = 0
		})
		SDKTools.SetParamsAttribute("Fire_FirstPurchase", {
			subType = 0
		})
	end,
	purchase_click = function()
		var_0_1 = {
			AFInAppEventType = "INITIATED_CHECKOUT",
			subType = 0,
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime()
		}

		SDKTools.SetParamsAttribute("af_initiatedcheckout", var_0_1)
		SDKTools.SetParamsAttribute("Fire_initiatedcheckout", {
			subType = 0
		})
	end,
	role_level = function(arg_14_0)
		var_0_1 = {
			AFInAppEventType = "LEVEL_ACHIEVED",
			subType = 0,
			user_id = PlayerData:GetPlayerInfo().userID,
			time = manager.time:GetServerTime()
		}

		if arg_14_0.level == 7 or arg_14_0.level == 10 or arg_14_0.level == 15 or arg_14_0.level == 30 then
			SDKTools.SetParamsAttribute("af_levelachieved" .. tostring(arg_14_0.level), var_0_1)
			SDKTools.SetParamsAttribute("Fire_levelachieved" .. tostring(arg_14_0.level), {
				subType = 0
			})
		end
	end
}

return var_0_0
