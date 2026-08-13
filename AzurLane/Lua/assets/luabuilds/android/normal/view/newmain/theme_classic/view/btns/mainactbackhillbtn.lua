class = var_0_10000

local var_0_0 = "MainActBackHillBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBaseActivityBtn"))

function var_0_1.GetEventName(arg_1_0)
	return "event_minigame"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.IsShowTip(var_2_0)

	setActive = var_2_0

	var_2_0(arg_2_0.tipTr.gameObject, var_2_1)

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

	getProxy = var_4_0
	ActivityProxy = var_1_10003

	local var_4_2 = var_4_0(var_1_10003)

	if var_2.getActivityById(var_4_2, var_4_1) and var_2:getConfig("config_client").scene then
		local var_4_3 = arg_4_0
		local var_4_4 = arg_4_0.emit

		NewMainMediator = var_1_10006

		var_4_4(var_4_3, var_1_10006.GO_SCENE, var_4_2)

		return
	end

	errorMsg = var_4_2

	var_4_2("not bind backhill Activity id:", var_4_1 or "NIL")
	arg_4_0:OnClick()

	return
end

function var_0_1.IsShowTip(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.GetActivityID(var_5_0)

	getProxy = var_5_0
	ActivityProxy = var_1_10003

	local var_5_2 = var_5_0(var_1_10003)

	if var_2.getActivityById(var_5_2, var_5_1) then
		local var_5_3 = var_2

		if var_2.getConfig(var_5_3, "config_client").scene then
			Context = var_5_3

			local var_5_4 = var_5_3.New()

			IsUnityEditor = var_5

			if var_5 then
				assert = var_5
				table = var_1_10006

				local var_5_5 = var_1_10006.Find

				SCENE = var_1_10007

				var_5(var_5_5(var_1_10007, function(arg_6_0, arg_6_1)
					return arg_6_1 == var_0
				end), "not Find name in scene.lua : " .. var_3)
			end

			SCENE = var_5

			var_5.SetSceneInfo(var_5_4, var_3)

			if var_5_4.viewComponent.IsShowMainTip then
				return var_5(var_2)
			end

			errorMsg = var_6

			var_6("scene has not function IsShowMainTip Tip Activity id:", var_5_1 or "NIL")
		end
	end

	return
end

return var_0_1
