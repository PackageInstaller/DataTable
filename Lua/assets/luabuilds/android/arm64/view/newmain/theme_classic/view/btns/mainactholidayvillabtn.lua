local var_0_0 = class("MainActHolidayVillaBtn", import(".MainBaseActivityBtn"))

function var_0_0.GetEventName(arg_1_0)
	return "event_holidayVilla"
end

function var_0_0.OnInit(arg_2_0)
	setActive(arg_2_0.tipTr.gameObject, (arg_2_0:IsShowTip()))

	return
end

function var_0_0.GetActivityID(arg_3_0)
	local var_3_0 = checkExist(arg_3_0.config, {
		"time"
	})

	if not var_3_0 then
		return nil
	end

	if var_3_0[1] == "default" then
		return var_3_0[2] or nil
	end
end

function var_0_0.CustomOnClick(arg_4_0)
	if getProxy(ActivityProxy):getActivityById((arg_4_0:GetActivityID())) then
		if not pg.NewStoryMgr.GetInstance():IsPlayed("JIARIBIESHUCHOUBEIZHONG5") then
			arg_4_0:emit(NewMainMediator.SKIP_ACTIVITY, tonumber(arg_4_0.config.param[2]))
		else
			arg_4_0:emit(NewMainMediator.GO_SCENE, arg_4_0.config.param[1])
		end
	end

	return
end

function var_0_0.IsShowTip(arg_5_0)
	local var_5_0 = arg_5_0:GetActivityID()
	local var_5_1 = getProxy(ActivityProxy):getActivityById(var_5_0)

	if not pg.NewStoryMgr.GetInstance():IsPlayed("JIARIBIESHUCHOUBEIZHONG5") then
		return false
	end

	if var_5_1 then
		local var_5_2 = var_5_1:getConfig("config_client").scene

		if var_5_2 then
			local var_5_3 = Context.New()

			if IsUnityEditor then
				assert(table.Find(SCENE, function(arg_6_0, arg_6_1)
					return arg_6_1 == var_5_2
				end), "not Find name in scene.lua : " .. var_5_2)
			end

			SCENE.SetSceneInfo(var_5_3, var_5_2)

			if var_5_3.viewComponent.IsShowMainTip then
				return var_5_3.viewComponent.IsShowMainTip(var_5_1)
			end

			errorMsg("scene has not function IsShowMainTip Tip Activity id:", var_5_0 or "NIL")
		end
	end

	return
end

return var_0_0
