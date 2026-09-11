local MainReFluxSequence = class("MainReFluxSequence")

MainReFluxSequence.GUIDE_FLAG = false

local var_0_1 = {
	{
		id = "Reflux",
		condition = function()
			return true
		end,
		args = function()
			return {}
		end
	}
}

function MainReFluxSequence:Execute(arg_3_1)
	if MainReFluxSequence.GUIDE_FLAG then
		MainGuideSequence.New():DoAction(var_0_1, arg_3_1, true)

		MainReFluxSequence.GUIDE_FLAG = false

		return
	end

	if not self:ShouldHandleReflux() then
		arg_3_1()

		return
	end

	seriesAsync({
		function(arg_4_0)
			self:PlayReFluxCG(arg_4_0)

			return
		end,
		function(arg_5_0)
			self:SkipToReFluxActivity()
			arg_5_0()

			return
		end
	})

	return
end

function MainReFluxSequence:ShouldHandleReflux()
	local var_6_0 = getProxy(RefluxProxy)

	return var_6_0:isCanSign() and var_6_0:isInRefluxTime()
end

function MainReFluxSequence:PlayReFluxCG(arg_7_1)
	local var_7_0 = getProxy(RefluxProxy)
	local var_7_1 = var_7_0:GetRefluxBgs()

	MainReFluxSequence.GUIDE_FLAG = true

	if #var_7_1 < 4 then
		arg_7_1()

		return
	end

	if var_7_0.signCount ~= 0 then
		arg_7_1()

		return
	end

	local var_7_2 = RefluxAnimationPlayer.New(pg.UIMgr.GetInstance().OverlayUITop)

	pg.m02:sendNotification(GAME.START_REFLUX_CG)
	var_7_2:ExecuteAction("Play", var_7_1, function()
		if self.player then
			var_7_2:Destroy()

			self.player = nil
		end

		pg.m02:sendNotification(GAME.END_REFLUX_CG)
		arg_7_1()

		return
	end)

	self.player = var_7_2

	return
end

function MainReFluxSequence:SkipToReFluxActivity()
	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.REFLUX)

	return
end

function MainReFluxSequence:Dispose()
	if self.player and self.player:GetLoaded() then
		self.player:Destroy()

		self.player = nil
	end

	return
end

return MainReFluxSequence
