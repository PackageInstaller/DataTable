local IslandVistorFishingPlayer = class("IslandVistorFishingPlayer", import(".IslandFishingPlayer"))

function IslandVistorFishingPlayer:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	IslandVistorFishingPlayer.super.Ctor(self, arg_1_1, arg_1_2)
	self:InitArgs(arg_1_3, arg_1_4, arg_1_5)

	return
end

function IslandVistorFishingPlayer:IsSameFishPoint(arg_2_1)
	return self.fishPointId == arg_2_1
end

function IslandVistorFishingPlayer:Play()
	local var_3_0 = self.fishPointId

	seriesAsync({
		function(arg_4_0)
			self:TurnToFishPoistion(var_3_0, arg_4_0)

			return
		end,
		function(arg_5_0)
			self:LoadFishRodModel(arg_5_0)

			return
		end,
		function(arg_6_0)
			self:PreloadEffects(arg_6_0)

			return
		end,
		function(arg_7_0)
			self:PlayEffect(IslandFishingEffectMgr.EFFECT_ENTER, IslandFishingEffectMgr.EFFECT_ENTER_TIME)
			self:PlayCastAnimation(arg_7_0)

			return
		end,
		function(arg_8_0)
			self:PlayEffect(IslandFishingEffectMgr.EFFECT_WAITING)
			onDelayTick(arg_8_0, 2)

			return
		end,
		function(arg_9_0)
			self:PlayEffect(IslandFishingEffectMgr.EFFECT_HOOKED)
			self:PlayHookedAnimation()
			onDelayTick(arg_9_0, 1)

			return
		end,
		function(arg_10_0)
			self:PlayEffect(IslandFishingEffectMgr.EFFECT_SHAKE)
			arg_10_0()

			return
		end
	})

	return
end

function IslandVistorFishingPlayer:OnSuccess(arg_11_1)
	seriesAsync({
		function(arg_12_0)
			onDelayTick(arg_12_0, 1)

			return
		end,
		function(arg_13_0)
			self:LoadFishModel(arg_13_0)

			return
		end,
		function(arg_14_0)
			self:PlayEffect(IslandFishingEffectMgr.EFFECT_LEAVE, IslandFishingEffectMgr.EFFECT_LEAVE_TIME)
			self:PlayHookEndAnimation(arg_14_0)

			return
		end,
		function(arg_15_0)
			self:WaitForExit(arg_15_0)

			return
		end
	}, arg_11_1)

	return
end

function IslandVistorFishingPlayer:WaitForExit(arg_16_1)
	self:RemoveWaitForExit()

	self.exitTimer = Timer.New(arg_16_1, math.max(0.01, pg.island_set.island_fishing_success_exit_time.key_value_int), 1)

	self.exitTimer:Start()

	return
end

function IslandVistorFishingPlayer:RemoveWaitForExit()
	if self.exitTimer then
		self.exitTimer:Stop()

		self.exitTimer = nil
	end

	return
end

function IslandVistorFishingPlayer:OnFailed(arg_18_1)
	self:PlayEffect(IslandFishingEffectMgr.EFFECT_NORMAL)
	self:PlayFailAnimation(arg_18_1)

	return
end

function IslandVistorFishingPlayer:OnCancel(arg_19_1)
	self:PlayEffect(IslandFishingEffectMgr.EFFECT_NORMAL)
	self:PlayCancelAnimation(arg_19_1)

	return
end

function IslandVistorFishingPlayer:OnDestroy()
	self:PlayEffect(IslandFishingEffectMgr.EFFECT_NORMAL)
	self:RemoveWaitForExit()
	self:UnLoadFishModel()
	self:UnLoadFishRodModel()
	self:PlayMovementAnimation()
	IslandVistorFishingPlayer.super.OnDestroy(self)

	return
end

return IslandVistorFishingPlayer
