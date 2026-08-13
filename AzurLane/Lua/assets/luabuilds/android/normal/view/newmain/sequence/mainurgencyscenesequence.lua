class = var_0_10000

local var_0_0 = var_0_10000("MainUrgencySceneSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	local var_1_0 = {
		"SkipToActivity",
		"SkipToReFluxActivity",
		"SkipToTechnology"
	}

	arg_1_0:NextOne(1, var_1_0, arg_1_1)

	return
end

function var_0_0.NextOne(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if not arg_2_0[arg_2_2[arg_2_1]](arg_2_0) then
		return
	end

	if var_5 and arg_2_1 < #arg_2_2 then
		arg_2_0:NextOne(arg_2_1 + 1, arg_2_2, arg_2_3)
	else
		arg_2_3()
	end

	return
end

function var_0_0.SkipToActivity(arg_3_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)

	if var_1.findNextAutoActivity(var_3_0) then
		pg = var_3_0

		local var_3_1 = var_3_0.m02
		local var_3_2 = var_3.sendNotification

		GAME = var_1_10005

		local var_3_3 = var_1_10005.GO_SCENE

		SCENE = var_1_10006

		var_3_2(var_3_1, var_3_3, var_1_10006.ACTIVITY)

		return false
	end

	return true
end

function var_0_0.SkipToReFluxActivity(arg_4_0)
	getProxy = var_1_10001
	RefluxProxy = var_1_10002

	local var_4_0 = var_1_10001(var_1_10002)
	local var_4_1

	if var_1.isCanSign(var_4_0) then
		var_4_0 = var_1
		var_4_1 = var_1.isInRefluxTime(var_4_0)
	end

	if var_4_1 then
		pg = var_4_0

		local var_4_2 = var_4_0.m02
		local var_4_3 = var_3.sendNotification

		GAME = var_1_10005

		local var_4_4 = var_1_10005.GO_SCENE

		SCENE = var_1_10006

		var_4_3(var_4_2, var_4_4, var_1_10006.REFLUX)

		return false
	end

	return true
end

function var_0_0.SkipToTechnology(arg_5_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_5_0 = var_1_10001(var_1_10002)
	local var_5_1 = var_1.getRawData(var_5_0).level

	LOCK_TECHNOLOGY = var_5_0

	if not var_5_0 then
		pg = var_5_0

		local var_5_2 = var_5_0.SystemOpenMgr.GetInstance()

		if var_2.isOpenSystem(var_5_2, var_5_1, "TechnologyMediator") then
			pg = var_2

			local var_5_3 = var_2.NewStoryMgr.GetInstance()

			if not var_2.IsPlayed(var_5_3, "FANGAN1") then
				pg = var_2

				local var_5_4 = var_2.m02
				local var_5_5 = var_2.sendNotification

				GAME = var_4

				local var_5_6 = var_4.GO_SCENE

				SCENE = var_5

				var_5_5(var_5_4, var_5_6, var_5.SELTECHNOLOGY)

				pg = var_5_5

				local var_5_7 = var_5_5.NewStoryMgr.GetInstance()

				var_2.Play(var_5_7, "FANGAN1", function()
					return
				end, true)

				return false
			end
		end
	end

	return true
end

return var_0_0
