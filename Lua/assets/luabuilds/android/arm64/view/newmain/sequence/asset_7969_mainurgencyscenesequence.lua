local MainUrgencySceneSequence = class("MainUrgencySceneSequence")

function MainUrgencySceneSequence:Execute(arg_1_1)
	self:NextOne(1, {
		"SkipToActivity",
		"SkipToReFluxActivity",
		"SkipToTechnology"
	}, arg_1_1)

	return
end

function MainUrgencySceneSequence:NextOne(arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = self[arg_2_2[arg_2_1]](self)

	if not var_2_0 then
		return
	end

	if var_2_0 and arg_2_1 < #arg_2_2 then
		self:NextOne(arg_2_1 + 1, arg_2_2, arg_2_3)
	else
		arg_2_3()
	end

	return
end

function MainUrgencySceneSequence:SkipToActivity()
	if getProxy(ActivityProxy):findNextAutoActivity() then
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY)

		return false
	end

	return true
end

function MainUrgencySceneSequence:SkipToReFluxActivity()
	local var_4_0 = getProxy(RefluxProxy)

	if var_4_0:isCanSign() and var_4_0:isInRefluxTime() then
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.REFLUX)

		return false
	end

	return true
end

function MainUrgencySceneSequence:SkipToTechnology()
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

return MainUrgencySceneSequence
