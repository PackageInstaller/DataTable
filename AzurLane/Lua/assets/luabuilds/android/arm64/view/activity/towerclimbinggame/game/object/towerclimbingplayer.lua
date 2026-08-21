local var_0_0 = class("TowerClimbingPlayer")
local var_0_1 = 0.6

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.map = arg_1_1
	arg_1_0.player = arg_1_2
	arg_1_0.action = ""

	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	TowerClimbingResMgr.GetPlayer(arg_2_0.player:GetShipName(), function(arg_3_0)
		arg_2_0.shipName = var_0

		arg_2_0:OnLoaded(arg_3_0)
		arg_2_1()

		return
	end)

	return
end

function var_0_0.OnLoaded(arg_4_0, arg_4_1)
	arg_4_0._go = arg_4_1
	arg_4_0._tf = tf(arg_4_1)
	arg_4_0.rigbody = arg_4_0._go:GetComponent(typeof(UnityEngine.Rigidbody2D))
	arg_4_0.physics2DItem = arg_4_0._go:GetComponent("Physics2DItem")

	arg_4_0.physics2DItem.CollisionEnter:AddListener(function(arg_5_0)
		local var_5_0 = arg_4_0.map:GetHitBlock(arg_5_0.collider.gameObject)

		if var_5_0 and arg_5_0.collider.name == TowerClimbingGameSettings.BLOCK_NAME and arg_5_0.contacts.Length > 0 then
			arg_4_0.map:SendEvent("EnterBlock", arg_5_0.contacts[0], var_5_0.block.level)
		end

		if arg_5_0.collider.name == TowerClimbingGameSettings.FIRE_NAME then
			arg_4_0.map:SendEvent("EnterAttacker")
		end

		if arg_5_0.collider.name == TowerClimbingGameSettings.STAB_NAME and arg_5_0.otherCollider.name == "player" then
			Physics2D.IgnoreCollision(arg_5_0.collider, arg_5_0.otherCollider)
		end

		if arg_5_0.collider.name == TowerClimbingGameSettings.STAB_NAME and arg_5_0.otherCollider.name == TowerClimbingGameSettings.STAB_HURT_AREA then
			arg_4_0.map:SendEvent("EnterAttacker")
		end

		if arg_5_0.collider.name == TowerClimbingGameSettings.GROUND_NAME then
			arg_4_0.map:SendEvent("EnterGround")
		end

		return
	end)
	arg_4_0.physics2DItem.CollisionStay:AddListener(function(arg_6_0)
		if arg_6_0.collider.name == TowerClimbingGameSettings.BLOCK_NAME then
			arg_4_0.map:SendEvent("StayBlock", arg_6_0.contacts:ToTable(), arg_4_0.rigbody.velocity)
		end

		return
	end)
	arg_4_0.physics2DItem.CollisionExit:AddListener(function(arg_7_0)
		if arg_7_0.collider.name == TowerClimbingGameSettings.BLOCK_NAME then
			arg_4_0.map:SendEvent("ExitBlock", arg_4_0.map:GetHitBlock(arg_7_0.collider.gameObject).block.level)
		end

		return
	end)

	arg_4_0.spineAnim = arg_4_0._go:GetComponent("SpineAnimUI")

	SetParent(arg_4_1, arg_4_0.map._tf:Find("game/block_play_con"))

	arg_4_1.name = "player"
	arg_4_0._tf.localScale = Vector3(var_0_1, var_0_1, 1)

	setActive(arg_4_1, true)

	return
end

function var_0_0.AdjustVel(arg_8_0, arg_8_1)
	arg_8_0.rigbody.velocity = arg_8_0.rigbody.velocity + arg_8_1

	return
end

function var_0_0.Jump(arg_9_0, arg_9_1)
	arg_9_0.rigbody.velocity = Vector2(arg_9_0.rigbody.velocity.x, arg_9_1)

	return
end

function var_0_0.MoveLeft(arg_10_0, arg_10_1)
	arg_10_0:SetAction("walk")

	arg_10_0._tf.localScale = Vector3(-var_0_1, var_0_1, 1)
	arg_10_0.rigbody.velocity = Vector2(-arg_10_1, arg_10_0.rigbody.velocity.y)

	return
end

function var_0_0.MoveRight(arg_11_0, arg_11_1)
	arg_11_0:SetAction("walk")

	arg_11_0._tf.localScale = Vector3(var_0_1, var_0_1, 1)
	arg_11_0.rigbody.velocity = Vector2(arg_11_1, arg_11_0.rigbody.velocity.y)

	return
end

function var_0_0.BeInjured(arg_12_0, arg_12_1)
	arg_12_0.rigbody.velocity = arg_12_0.rigbody.velocity + arg_12_1

	return
end

function var_0_0.Idle(arg_13_0)
	arg_13_0:SetAction("stand2")

	return
end

function var_0_0.Dead(arg_14_0)
	setActive(arg_14_0._tf, false)

	return
end

function var_0_0.Invincible(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._tf:GetComponent("SkeletonGraphic")

	if arg_15_1 then
		if arg_15_0.timer then
			arg_15_0.timer:Stop()

			arg_15_0.timer = nil
		end

		local var_15_1 = 0

		arg_15_0.timer = Timer.New(function()
			var_15_1 = var_15_1 + 1
			var_15_0.color = var_15_1 % 2 == 0 and Color.New(1, 1, 1, 1) or Color.New(1, 0, 0, 1)

			return
		end, 0.3, -1)

		arg_15_0.timer:Start()
	else
		if arg_15_0.timer then
			arg_15_0.timer:Stop()

			arg_15_0.timer = nil
		end

		arg_15_0._tf:GetComponent("SkeletonGraphic").color = Color.New(1, 1, 1, 1)
	end

	return
end

function var_0_0.ChangePosition(arg_17_0, arg_17_1)
	arg_17_0._tf.anchoredPosition = arg_17_0.map.blockContainer:InverseTransformVector(arg_17_0.map.groundContainer:TransformVector(arg_17_1))

	return
end

function var_0_0.BeFatalInjured(arg_18_0, arg_18_1)
	arg_18_0.spineAnim:SetActionCallBack(function(arg_19_0)
		if arg_19_0 == "finish" then
			arg_18_0.spineAnim:SetActionCallBack(nil)
			arg_18_1()
		end

		return
	end)

	arg_18_0.action = "dead"

	arg_18_0.spineAnim:SetAction(arg_18_0.action, 0)

	return
end

function var_0_0.SetAction(arg_20_0, arg_20_1)
	if arg_20_0.action == arg_20_1 then
		return
	end

	arg_20_0.action = arg_20_1

	arg_20_0.spineAnim:SetAction(arg_20_1, 0)

	return
end

function var_0_0.Dispose(arg_21_0)
	arg_21_0.spineAnim:SetActionCallBack(nil)

	if LeanTween.isTweening(arg_21_0._go) then
		LeanTween.cancel(arg_21_0._go)
	end

	if arg_21_0.timer then
		arg_21_0.timer:Stop()

		arg_21_0.timer = nil
	end

	if arg_21_0.shipName then
		TowerClimbingResMgr.ReturnPlayer(arg_21_0.shipName, arg_21_0._go)
	end

	return
end

return var_0_0
