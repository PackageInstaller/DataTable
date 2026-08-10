local var_0_0 = {}
local var_0_1 = {
	SlowdownAllTarget = 4,
	Slowdown = 6,
	AlwaysHeadShot = 3,
	FreezeNonHumanoidTarget = 2,
	FastShoot = 5,
	SpeedUp = 1,
	Freeze = 7
}

var_0_0.all = {}

for iter_0_0, iter_0_1 in pairs(var_0_1) do
	table.insert(var_0_0.all, iter_0_1)
end

table.sort(var_0_0.all)

local function var_0_2(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = DormUtils.GetEntityData(arg_1_0)
	local var_1_1 = var_1_0.speedUpFactor or 1
	local var_1_2 = var_1_0.slowdownFactor or 1

	var_1_0.speedUpFactor, var_1_0.slowdownFactor = arg_1_1 or var_1_1, arg_1_2 or var_1_2

	local var_1_3 = var_1_0.speed or defaultEntitySpeed
	local var_1_4 = 1

	if arg_1_2 then
		var_1_4 = 1 - arg_1_2
	elseif arg_1_1 then
		var_1_4 = 1 + arg_1_1
	end

	print("SetGameEntitySpeedByScale", arg_1_1, arg_1_2, var_1_4)
	Dorm.DormEntityManager.SetEntitySpeed(arg_1_0, var_1_3 * var_1_4)
end

local var_0_3 = "minigame_snowball"
local var_0_4 = "minigame_snowball_buff"
local var_0_5 = -1

local function var_0_6(arg_2_0)
	manager.audio:PlayEffect("minigame_activity_2_6_snowball", arg_2_0, "")
end

var_0_0.buff = {
	[var_0_1.SpeedUp] = {
		OnApply = function(arg_3_0, arg_3_1)
			var_0_2(arg_3_0, arg_3_1)
		end,
		OnRemove = function(arg_4_0)
			var_0_2(arg_4_0, 0)
		end
	},
	[var_0_1.FastShoot] = {
		OnApply = function(arg_5_0, arg_5_1)
			SnowballGameMgr.GetInstance().shootSpeedFactor = 1 + arg_5_1
		end,
		OnRemove = function(arg_6_0)
			SnowballGameMgr.GetInstance().shootSpeedFactor = 1
		end
	},
	[var_0_1.SlowdownAllTarget] = {
		OnApply = function(arg_7_0, arg_7_1)
			var_0_6("minigame_activity_2_6_snowball_wind")
			Dorm.LuaBridge.MiniGameBridge.ClearAllFullScreenEffect()
			Dorm.LuaBridge.MiniGameBridge.PlayFullScreenEffect("Dorm/Effect/snowball/fx_snow_effect_UI2", var_0_5)

			for iter_7_0, iter_7_1 in pairs(SnowballGameMgr.GetInstance().entityManager.managed) do
				var_0_2(iter_7_1, nil, arg_7_1)
			end
		end,
		OnRemove = function(arg_8_0)
			Dorm.LuaBridge.MiniGameBridge.ClearAllFullScreenEffect()

			for iter_8_0, iter_8_1 in pairs(SnowballGameMgr.GetInstance().entityManager.managed) do
				var_0_2(iter_8_1, nil, 0)
			end
		end,
		OnExtended = function(arg_9_0)
			var_0_6("minigame_activity_2_6_snowball_wind")
			Dorm.LuaBridge.MiniGameBridge.ClearAllFullScreenEffect()
			Dorm.LuaBridge.MiniGameBridge.PlayFullScreenEffect("Dorm/Effect/snowball/fx_snow_effect_UI2", var_0_5)
		end
	},
	[var_0_1.FreezeNonHumanoidTarget] = {
		OnApply = function()
			var_0_6("minigame_activity_2_6_snowball_freeze")
			Dorm.LuaBridge.MiniGameBridge.ClearAllFullScreenEffect()
			Dorm.LuaBridge.MiniGameBridge.PlayFullScreenEffect("Dorm/Effect/snowball/fx_snow_effect_UI1", var_0_5)

			SnowballGameTargetAI.GetInstance().pauseNonHumanoid = true
		end,
		OnRemove = function(arg_11_0)
			Dorm.LuaBridge.MiniGameBridge.ClearAllFullScreenEffect()

			SnowballGameTargetAI.GetInstance().pauseNonHumanoid = false
		end,
		OnExtended = function(arg_12_0)
			var_0_6("minigame_activity_2_6_snowball_freeze")
			Dorm.LuaBridge.MiniGameBridge.ClearAllFullScreenEffect()
			Dorm.LuaBridge.MiniGameBridge.PlayFullScreenEffect("Dorm/Effect/snowball/fx_snow_effect_UI1", var_0_5)
		end
	},
	[var_0_1.AlwaysHeadShot] = {
		OnApply = function()
			SnowballGameMgr.GetInstance().lockHeadShot = true
		end,
		OnRemove = function()
			SnowballGameMgr.GetInstance().lockHeadShot = false
		end
	},
	[var_0_1.Slowdown] = {
		IsDebuff = true,
		WillOverride = function(arg_15_0)
			return arg_15_0 == var_0_1.Freeze
		end,
		OnApply = function(arg_16_0, arg_16_1)
			var_0_6("minigame_activity_2_6_snowball_debuff01")

			local var_16_0 = SnowballGameMgr.GetInstance()

			Dorm.DormEntityManager.PlayEffect(arg_16_0, "root", var_0_4, "Dorm/Effect/snowball/fx_snow_effect_debuff_slow", var_0_5)
			Dorm.DormEntityManager.PlayEffect(arg_16_0, "root", var_0_4, "Dorm/Effect/snowball/fx_snow_effect_dust", var_0_5)
			var_0_2(arg_16_0, nil, arg_16_1)
		end,
		OnRemove = function(arg_17_0)
			local var_17_0 = SnowballGameMgr.GetInstance()

			Dorm.DormEntityManager.ClearAllEffect(arg_17_0, var_0_4)
			Dorm.DormEntityManager.PlayEffect(arg_17_0, "root", var_0_4, "Dorm/Effect/snowball/fx_snow_effect_debuff_slow2", 1)
			var_0_2(arg_17_0, nil, 0)
		end,
		OnExtended = function(arg_18_0)
			var_0_6("minigame_activity_2_6_snowball_debuff01")
		end
	},
	[var_0_1.Freeze] = {
		IsDebuff = true,
		WillOverride = function(arg_19_0)
			return arg_19_0 == var_0_1.Slowdown
		end,
		OnApply = function(arg_20_0)
			var_0_6("minigame_activity_2_6_snowball_debuff02")
			Dorm.DormEntityManager.SetFadeCMD(arg_20_0, 0)
			Dorm.DormEntityManager.PlayEffect(arg_20_0, "root", var_0_4, "Dorm/Effect/snowball/fx_snow_effect_debuff_freeze", var_0_5)
			Dorm.DormEntityManager.SetEntityMobility(arg_20_0, false)
			Dorm.DormEntityManager.ClearAllEffect(arg_20_0, var_0_3)
		end,
		OnRemove = function(arg_21_0)
			var_0_6("minigame_activity_2_6_snowball_debuff02_off")
			Dorm.DormEntityManager.ClearAllEffect(arg_21_0, var_0_4)
			Dorm.DormEntityManager.PlayEffect(arg_21_0, "root", var_0_4, "Dorm/Effect/snowball/fx_snow_effect_debuff_freeze2", 1)
			Dorm.DormEntityManager.SetFadeCMD(arg_21_0, 1)
			Dorm.DormEntityManager.SetEntityMobility(arg_21_0, true)
			SnowballGameMgr.CreateHoldSnowballVfx(arg_21_0)
		end,
		OnExtended = function(arg_22_0)
			var_0_6("minigame_activity_2_6_snowball_debuff02")
		end
	}
}
var_0_0.buffType = var_0_1

return var_0_0
