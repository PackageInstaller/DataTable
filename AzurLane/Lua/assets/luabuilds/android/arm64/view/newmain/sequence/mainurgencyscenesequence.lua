local var_0_0 = class("MainUrgencySceneSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	arg_1_0:NextOne(1, {
		"SkipToActivity",
		"SkipToReFluxActivity",
		"SkipToTechnology"
	}, arg_1_1)

	return
end

function var_0_0.NextOne(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = arg_2_0[arg_2_2[arg_2_1]](arg_2_0)

	if not var_2_0 then
		return
	end

	if var_2_0 and arg_2_1 < #arg_2_2 then
		arg_2_0:NextOne(arg_2_1 + 1, arg_2_2, arg_2_3)
	else
		arg_2_3()
	end

	return
end

function var_0_0.SkipToActivity(arg_3_0)
	if getProxy(ActivityProxy):findNextAutoActivity() then
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY)

		return false
	end

	return true
end

function var_0_0.SkipToReFluxActivity(arg_4_0)
	local var_4_0 = getProxy(RefluxProxy)
	local var_4_1 = var_4_0:isCanSign() and var_4_0:isInRefluxTime()

	if var_4_1 then
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.REFLUX)

		return false
	end

	return true
end

function var_0_0.SkipToTechnology(arg_5_0)
	if not LOCK_TECHNOLOGY then
		if pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "TechnologyMediator") then
			if not pg.NewStoryMgr.GetInstance():IsPlayed("FANGAN1") then
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SELTECHNOLOGY)
				pg.NewStoryMgr.GetInstance():Play("FANGAN1", function()
					return
				end, true)

				return false
			end
		end
	end

	return true
end

return var_0_0
