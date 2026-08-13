class = var_0_10000

local var_0_0 = "MainActHolidayVillaBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseActivityBtn"))

function var_0_1.GetEventName(arg_1_0)
	return "event_holidayVilla"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0:IsShowTip()

	setActive = var_1_10002

	var_1_10002(arg_2_0.tipTr.gameObject, var_2_0)

	return
end

function var_0_1.GetActivityID(arg_3_0)
	checkExist = var_1_10001

	if not var_1_10001(arg_3_0.config, {
		"time"
	}) then
		return nil
	end

	local var_3_0

	if var_1[1] ~= "default" or not var_1[2] then
		var_3_0 = nil
	end

	return var_3_0
end

function var_0_1.CustomOnClick(arg_4_0)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.GetActivityID(var_4_0)

	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_4_2 = var_1_10002(var_1_10004)

	if var_2.getActivityById(var_4_2, var_4_1) then
		pg = var_4_0

		local var_4_3 = var_4_0.NewStoryMgr.GetInstance()
		local var_4_6

		if not var_3.IsPlayed(var_4_3, "JIARIBIESHUCHOUBEIZHONG5") then
			local var_4_4 = arg_4_0
			local var_4_5 = arg_4_0.emit

			NewMainMediator = var_4_6
			var_4_6 = var_4_6.SKIP_ACTIVITY
			tonumber = var_1_10007

			var_4_5(var_4_4, var_4_6, var_1_10007(arg_4_0.config.param[2]))
		else
			local var_4_7 = arg_4_0
			local var_4_8 = arg_4_0.emit

			NewMainMediator = var_4_6

			var_4_8(var_4_7, var_4_6.GO_SCENE, arg_4_0.config.param[1])
		end
	end

	return
end

function var_0_1.IsShowTip(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.GetActivityID(var_5_0)

	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_5_2 = var_1_10002(var_1_10004)
	local var_5_3 = var_2.getActivityById(var_5_2, var_5_1)

	pg = var_5_0

	local var_5_4 = var_5_0.NewStoryMgr.GetInstance()

	if not var_3.IsPlayed(var_5_4, "JIARIBIESHUCHOUBEIZHONG5") then
		return false
	end

	if var_5_3 then
		local var_5_5 = var_5_3

		if var_5_3.getConfig(var_5_5, "config_client").scene then
			Context = var_5_2

			local var_5_6 = var_5_2.New()

			IsUnityEditor = var_5_5

			if var_5_5 then
				assert = var_5_5
				table = var_1_10007

				local var_5_7 = var_1_10007.Find

				SCENE = var_1_10009

				var_5_5(var_5_7(var_1_10009, function(arg_6_0, arg_6_1)
					return arg_6_1 == var_0
				end), "not Find name in scene.lua : " .. var_3)
			end

			SCENE = var_5_5

			var_5_5.SetSceneInfo(var_5_6, var_3)

			if var_5_6.viewComponent.IsShowMainTip then
				return var_5(var_5_3)
			end

			errorMsg = var_6

			var_6("scene has not function IsShowMainTip Tip Activity id:", var_5_1 or "NIL")
		end
	end

	return
end

return var_0_1
