local IslandFishingPlayer = class("IslandFishingPlayer", import("Mod.Island.Core.View.IslandBaseUnit"))

function IslandFishingPlayer:Ctor(arg_1_1, arg_1_2)
	IslandFishingPlayer.super.Ctor(self, arg_1_1)

	self.player = arg_1_2
	self.effectMgr = IslandFishingEffectMgr.New(self:GetView())
	self.animator = IslandFishingAnimator.New(arg_1_2)

	return
end

function IslandFishingPlayer:InitArgs(arg_2_1, arg_2_2, arg_2_3)
	self.fishPointId = arg_2_1
	self.fishRodId = arg_2_2
	self.fishId = arg_2_3

	return
end

function IslandFishingPlayer:PreloadEffects(arg_3_1)
	assert(self.fishPointId, "call InitArgs first")
	self.effectMgr:Preload(self.fishPointId, arg_3_1)

	return
end

function IslandFishingPlayer:PlayEffect(arg_4_1, arg_4_2)
	if not arg_4_2 or arg_4_2 <= 0 then
		self.effectMgr:Play(arg_4_1)
	else
		self.effectMgr:DelayPlay(arg_4_2, arg_4_1)
	end

	return
end

function IslandFishingPlayer:PlayCastAnimation(arg_5_1)
	self.animator:Trigger(IslandFishingAnimator.STATE_THROW, 0.25, arg_5_1)

	return
end

function IslandFishingPlayer:PlayHookedAnimation()
	self.animator:Trigger(IslandFishingAnimator.STATE_HOOKED, 0.25)

	return
end

function IslandFishingPlayer:PlayMovementAnimation()
	self.animator:Trigger(IslandFishingAnimator.STATE_MOVEMENT, 0)

	return
end

function IslandFishingPlayer:PlayHookEndAnimation(arg_8_1)
	self.animator:Trigger(IslandFishingAnimator.STATE_HOOKED_5, 0.25, arg_8_1)

	return
end

function IslandFishingPlayer:PlayHookMiddleAnimation()
	self.animator:Trigger(IslandFishingAnimator.STATE_HOOKED_3, 0)

	return
end

function IslandFishingPlayer:PlayCancelAnimation(arg_10_1)
	self.animator:Trigger(IslandFishingAnimator.STATE_CANCEL, 0.25, arg_10_1)

	return
end

function IslandFishingPlayer:PlayFailAnimation(arg_11_1)
	self.animator:Trigger(IslandFishingAnimator.STATE_FAIL, 0.25, arg_11_1)

	return
end

function IslandFishingPlayer:TurnToFishPoistion(arg_12_1, arg_12_2)
	local var_12_0 = self:GetView():GetUnitModuleWithType(IslandConst.UNIT_LIST_FISH_POINT, arg_12_1)

	assert(var_12_0, "unit should be exist>>>." .. arg_12_1)

	;(var_12_0._go.transform.position - self.player._tf.position).y = 0
	self.player._tf.rotation = Quaternion.LookRotation(var_12_0._go.transform.position - self.player._tf.position)

	arg_12_2()

	return
end

function IslandFishingPlayer:LoadFishRodModel(arg_13_1)
	assert(self.fishRodId, "call InitArgs first")

	if not self.fishRodId then
		arg_13_1()

		return
	end

	self:GetPoolMgr():GetFishRod(pg.island_animation_attachments[self.fishRodId].model, pg.island_animation_attachments[self.fishRodId].animator, function(arg_14_0)
		self.fishRodAnimator = arg_14_0:GetComponent(typeof(Animator))

		local var_14_0 = arg_14_0:GetComponent(typeof(FishingLineVerlet))

		if var_14_0 then
			self.effectMgr:SetFishHook(var_14_0.hook)
		end

		setParent(arg_14_0, self.player._tf)
		self.animator:SetFishRod(self.fishRodAnimator)
		arg_13_1()

		return
	end)

	return
end

function IslandFishingPlayer:UnLoadFishRodModel()
	if self.fishRodId and self.fishRodAnimator and self.fishRodAnimator.gameObject then
		self:GetPoolMgr():ReturnFishRod(pg.island_animation_attachments[self.fishRodId].model, pg.island_animation_attachments[self.fishRodId].animator, self.fishRodAnimator.gameObject)

		self.fishRodId = nil

		self.animator:ClearFishRod()

		self.fishRodAnimator = nil
	end

	return
end

function IslandFishingPlayer:LoadFishModel(arg_16_1)
	assert(self.fishId, "call InitArgs first")

	if not self.fishId or not self.fishRodAnimator then
		arg_16_1()

		return
	end

	self:GetPoolMgr():GetFish(pg.island_unit_character[pg.island_fish[self.fishId].unit_id].model, pg.island_unit_character[pg.island_fish[self.fishId].unit_id].animator, function(arg_17_0)
		self.fishAnimator = arg_17_0:GetComponent(typeof(Animator))

		setParent(arg_17_0, self.fishRodAnimator.gameObject.transform:Find("all/fish_bone/fish1_mount"))
		arg_16_1()

		return
	end)

	return
end

function IslandFishingPlayer:UnLoadFishModel()
	if self.fishAnimator then
		self:GetPoolMgr():ReturnFish(pg.island_unit_character[pg.island_fish[self.fishId].unit_id].model, pg.island_unit_character[pg.island_fish[self.fishId].unit_id].animator, self.fishAnimator.gameObject)

		self.fishAnimator = nil
	end

	return
end

function IslandFishingPlayer:OnDestroy()
	if self.effectMgr then
		self.effectMgr:Dispose()

		self.effectMgr = nil
	end

	if self.animator then
		self.animator:Dispose()

		self.animator = nil
	end

	return
end

return IslandFishingPlayer
