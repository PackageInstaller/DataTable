local TowerClimbingPlayer = class("TowerClimbingPlayer")
local var_0_1 = 0.6

function TowerClimbingPlayer:Ctor(arg_1_1, arg_1_2)
	self.map = arg_1_1
	self.player = arg_1_2
	self.action = ""

	return
end

function TowerClimbingPlayer:Init(arg_2_1)
	local var_2_0 = self.player:GetShipName()

	TowerClimbingResMgr.GetPlayer(var_2_0, function(arg_3_0)
		self.shipName = var_2_0

		self:OnLoaded(arg_3_0)
		arg_2_1()

		return
	end)

	return
end

function TowerClimbingPlayer:OnLoaded(arg_4_1)
	self._go = arg_4_1
	self._tf = tf(arg_4_1)
	self.rigbody = self._go:GetComponent(typeof(UnityEngine.Rigidbody2D))
	self.physics2DItem = self._go:GetComponent("Physics2DItem")

	self.physics2DItem.CollisionEnter:AddListener(function(arg_5_0)
		local var_5_0 = self.map:GetHitBlock(arg_5_0.collider.gameObject)

		if var_5_0 and arg_5_0.collider.name == TowerClimbingGameSettings.BLOCK_NAME and arg_5_0.contacts.Length > 0 then
			self.map:SendEvent("EnterBlock", arg_5_0.contacts[0], var_5_0.block.level)
		end

		if arg_5_0.collider.name == TowerClimbingGameSettings.FIRE_NAME then
			self.map:SendEvent("EnterAttacker")
		end

		if arg_5_0.collider.name == TowerClimbingGameSettings.STAB_NAME and arg_5_0.otherCollider.name == "player" then
			Physics2D.IgnoreCollision(arg_5_0.collider, arg_5_0.otherCollider)
		end

		if arg_5_0.collider.name == TowerClimbingGameSettings.STAB_NAME and arg_5_0.otherCollider.name == TowerClimbingGameSettings.STAB_HURT_AREA then
			self.map:SendEvent("EnterAttacker")
		end

		if arg_5_0.collider.name == TowerClimbingGameSettings.GROUND_NAME then
			self.map:SendEvent("EnterGround")
		end

		return
	end)
	self.physics2DItem.CollisionStay:AddListener(function(arg_6_0)
		if arg_6_0.collider.name == TowerClimbingGameSettings.BLOCK_NAME then
			self.map:SendEvent("StayBlock", arg_6_0.contacts:ToTable(), self.rigbody.velocity)
		end

		return
	end)
	self.physics2DItem.CollisionExit:AddListener(function(arg_7_0)
		if arg_7_0.collider.name == TowerClimbingGameSettings.BLOCK_NAME then
			self.map:SendEvent("ExitBlock", self.map:GetHitBlock(arg_7_0.collider.gameObject).block.level)
		end

		return
	end)

	self.spineAnim = self._go:GetComponent("SpineAnimUI")

	SetParent(arg_4_1, self.map._tf:Find("game/block_play_con"))

	arg_4_1.name = "player"
	self._tf.localScale = Vector3(var_0_1, var_0_1, 1)

	setActive(arg_4_1, true)

	return
end

function TowerClimbingPlayer:AdjustVel(arg_8_1)
	self.rigbody.velocity = self.rigbody.velocity + arg_8_1

	return
end

function TowerClimbingPlayer:Jump(arg_9_1)
	self.rigbody.velocity = Vector2(self.rigbody.velocity.x, arg_9_1)

	return
end

function TowerClimbingPlayer:MoveLeft(arg_10_1)
	self:SetAction("walk")

	self._tf.localScale = Vector3(-var_0_1, var_0_1, 1)
	self.rigbody.velocity = Vector2(-arg_10_1, self.rigbody.velocity.y)

	return
end

function TowerClimbingPlayer:MoveRight(arg_11_1)
	self:SetAction("walk")

	self._tf.localScale = Vector3(var_0_1, var_0_1, 1)
	self.rigbody.velocity = Vector2(arg_11_1, self.rigbody.velocity.y)

	return
end

function TowerClimbingPlayer:BeInjured(arg_12_1)
	self.rigbody.velocity = self.rigbody.velocity + arg_12_1

	return
end

function TowerClimbingPlayer:Idle()
	self:SetAction("stand2")

	return
end

function TowerClimbingPlayer:Dead()
	setActive(self._tf, false)

	return
end

function TowerClimbingPlayer:Invincible(arg_15_1)
	local var_15_0 = self._tf:GetComponent("SkeletonGraphic")

	if arg_15_1 then
		if self.timer then
			self.timer:Stop()

			self.timer = nil
		end

		local var_15_1 = 0

		self.timer = Timer.New(function()
			var_15_1 = var_15_1 + 1
			var_15_0.color = var_15_1 % 2 == 0 and Color.New(1, 1, 1, 1) or Color.New(1, 0, 0, 1)

			return
		end, 0.3, -1)

		self.timer:Start()
	else
		if self.timer then
			self.timer:Stop()

			self.timer = nil
		end

		var_15_0.color = Color.New(1, 1, 1, 1)
	end

	return
end

function TowerClimbingPlayer:ChangePosition(arg_17_1)
	self._tf.anchoredPosition = self.map.blockContainer:InverseTransformVector(self.map.groundContainer:TransformVector(arg_17_1))

	return
end

function TowerClimbingPlayer:BeFatalInjured(arg_18_1)
	self.spineAnim:SetActionCallBack(function(arg_19_0)
		if arg_19_0 == "finish" then
			self.spineAnim:SetActionCallBack(nil)
			arg_18_1()
		end

		return
	end)

	self.action = "dead"

	self.spineAnim:SetAction(self.action, 0)

	return
end

function TowerClimbingPlayer:SetAction(arg_20_1)
	if self.action == arg_20_1 then
		return
	end

	self.action = arg_20_1

	self.spineAnim:SetAction(arg_20_1, 0)

	return
end

function TowerClimbingPlayer:Dispose()
	self.spineAnim:SetActionCallBack(nil)

	if LeanTween.isTweening(self._go) then
		LeanTween.cancel(self._go)
	end

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if self.shipName then
		TowerClimbingResMgr.ReturnPlayer(self.shipName, self._go)
	end

	return
end

return TowerClimbingPlayer
