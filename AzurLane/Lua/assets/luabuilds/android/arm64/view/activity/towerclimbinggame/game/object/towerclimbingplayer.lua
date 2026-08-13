class = var_0_10000

local var_0_0 = var_0_10000("TowerClimbingPlayer")
local var_0_1 = 0.6

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.map = arg_1_1
	arg_1_0.player = arg_1_2
	arg_1_0.action = ""

	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.player
	local var_2_1 = var_2.GetShipName(var_2_0)

	TowerClimbingResMgr = var_1_10003

	var_1_10003.GetPlayer(var_2_1, function(arg_3_0)
		arg_2_0.shipName = var_2_1

		local var_3_0 = arg_2_0

		var_1.OnLoaded(var_3_0, arg_3_0)
		arg_2_1()

		return
	end)

	return
end

function var_0_0.OnLoaded(arg_4_0, arg_4_1)
	arg_4_0._go = arg_4_1
	tf = var_1_10002
	arg_4_0._tf = var_1_10002(arg_4_1)

	local var_4_0 = arg_4_0._go
	local var_4_1 = var_2.GetComponent

	typeof = var_1_10005
	UnityEngine = var_1_10007
	arg_4_0.rigbody = var_4_1(var_4_0, var_1_10005(var_1_10007.Rigidbody2D))

	local var_4_2 = arg_4_0._go

	arg_4_0.physics2DItem = var_2.GetComponent(var_4_2, "Physics2DItem")

	local var_4_3 = arg_4_0.physics2DItem.CollisionEnter

	var_2.AddListener(var_4_3, function(arg_5_0)
		local var_5_0 = arg_4_0.map

		if var_1.GetHitBlock(var_5_0, arg_5_0.collider.gameObject) then
			local var_5_1 = arg_5_0.collider.name

			TowerClimbingGameSettings = var_5_0

			if var_5_1 == var_5_0.BLOCK_NAME then
				local var_5_2 = arg_5_0.contacts.Length

				if 0 < var_5_2 then
					local var_5_3 = arg_4_0.map

					var_2.SendEvent(var_5_3, "EnterBlock", arg_5_0.contacts[0], var_1.block.level)
				end
			end
		end

		local var_5_4 = arg_5_0.collider.name

		TowerClimbingGameSettings = var_5_0

		if var_5_4 == var_5_0.FIRE_NAME then
			local var_5_5 = arg_4_0.map

			var_2.SendEvent(var_5_5, "EnterAttacker")
		end

		local var_5_6 = arg_5_0.collider.name

		TowerClimbingGameSettings = var_3

		if var_5_6 == var_3.STAB_NAME and arg_5_0.otherCollider.name == "player" then
			Physics2D = var_2

			var_2.IgnoreCollision(arg_5_0.collider, arg_5_0.otherCollider)
		end

		local var_5_7 = arg_5_0.collider.name

		TowerClimbingGameSettings = var_3

		if var_5_7 == var_3.STAB_NAME then
			local var_5_8 = arg_5_0.otherCollider.name

			TowerClimbingGameSettings = var_3

			if var_5_8 == var_3.STAB_HURT_AREA then
				local var_5_9 = arg_4_0.map

				var_2.SendEvent(var_5_9, "EnterAttacker")
			end
		end

		local var_5_10 = arg_5_0.collider.name

		TowerClimbingGameSettings = var_3

		if var_5_10 == var_3.GROUND_NAME then
			local var_5_11 = arg_4_0.map

			var_2.SendEvent(var_5_11, "EnterGround")
		end

		return
	end)

	local var_4_4 = arg_4_0.physics2DItem.CollisionStay

	var_2.AddListener(var_4_4, function(arg_6_0)
		local var_6_0 = arg_6_0.contacts
		local var_6_1 = var_1.ToTable(var_6_0)
		local var_6_2 = arg_6_0.collider.name

		TowerClimbingGameSettings = var_6_0

		if var_6_2 == var_6_0.BLOCK_NAME then
			local var_6_3 = arg_4_0.map

			var_2.SendEvent(var_6_3, "StayBlock", var_6_1, arg_4_0.rigbody.velocity)
		end

		return
	end)

	local var_4_5 = arg_4_0.physics2DItem.CollisionExit

	var_2.AddListener(var_4_5, function(arg_7_0)
		local var_7_0 = arg_4_0.map
		local var_7_1 = var_1.GetHitBlock(var_7_0, arg_7_0.collider.gameObject)
		local var_7_2 = arg_7_0.collider.name

		TowerClimbingGameSettings = var_7_0

		if var_7_2 == var_7_0.BLOCK_NAME then
			local var_7_3 = arg_4_0.map

			var_2.SendEvent(var_7_3, "ExitBlock", var_7_1.block.level)
		end

		return
	end)

	local var_4_6 = arg_4_0._go

	arg_4_0.spineAnim = var_2.GetComponent(var_4_6, "SpineAnimUI")
	SetParent = var_2

	local var_4_7 = arg_4_1
	local var_4_8 = arg_4_0.map._tf

	var_2(var_4_7, var_5.Find(var_4_8, "game/block_play_con"))

	arg_4_1.name = "player"

	local var_4_9 = arg_4_0._tf

	Vector3 = var_1_10003
	var_4_9.localScale = var_1_10003(var_0_1, var_0_1, 1)
	setActive = var_4_9

	var_4_9(arg_4_1, true)

	return
end

function var_0_0.AdjustVel(arg_8_0, arg_8_1)
	arg_8_0.rigbody.velocity = arg_8_0.rigbody.velocity + arg_8_1

	return
end

function var_0_0.Jump(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.rigbody.velocity
	local var_9_1 = arg_9_0.rigbody

	Vector2 = var_1_10004
	var_9_1.velocity = var_1_10004(arg_9_0.rigbody.velocity.x, arg_9_1)

	return
end

function var_0_0.MoveLeft(arg_10_0, arg_10_1)
	arg_10_0:SetAction("walk")

	local var_10_0 = arg_10_0._tf

	Vector3 = var_1_10003
	var_10_0.localScale = var_1_10003(-var_0_1, var_0_1, 1)

	local var_10_1 = arg_10_0.rigbody

	Vector2 = var_3
	var_10_1.velocity = var_3(-arg_10_1, arg_10_0.rigbody.velocity.y)

	return
end

function var_0_0.MoveRight(arg_11_0, arg_11_1)
	arg_11_0:SetAction("walk")

	local var_11_0 = arg_11_0._tf

	Vector3 = var_1_10003
	var_11_0.localScale = var_1_10003(var_0_1, var_0_1, 1)

	local var_11_1 = arg_11_0.rigbody

	Vector2 = var_3
	var_11_1.velocity = var_3(arg_11_1, arg_11_0.rigbody.velocity.y)

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
	setActive = var_1_10001

	var_1_10001(arg_14_0._tf, false)

	return
end

function var_0_0.Invincible(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._tf
	local var_15_1 = var_2.GetComponent(var_15_0, "SkeletonGraphic")

	if arg_15_1 then
		if arg_15_0.timer then
			local var_15_2 = arg_15_0.timer

			var_3.Stop(var_15_2)

			arg_15_0.timer = nil
		end

		local var_15_3 = 0

		Timer = var_15_0
		arg_15_0.timer = var_15_0.New(function()
			var_15_3 = var_15_3 + 1

			if var_15_3 % 2 == 0 then
				local var_16_0 = var_15_1

				Color = var_2_10001
				var_16_0.color = var_2_10001.New(1, 1, 1, 1)
			else
				local var_16_1 = var_15_1

				Color = var_2_10001
				var_16_1.color = var_2_10001.New(1, 0, 0, 1)
			end

			return
		end, 0.3, -1)

		local var_15_4 = arg_15_0.timer

		var_4.Start(var_15_4)
	else
		if arg_15_0.timer then
			local var_15_5 = arg_15_0.timer

			var_3.Stop(var_15_5)

			arg_15_0.timer = nil
		end

		Color = var_3
		var_15_1.color = var_3.New(1, 1, 1, 1)
	end

	return
end

function var_0_0.ChangePosition(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.map.blockContainer
	local var_17_1 = var_2.InverseTransformVector
	local var_17_2 = arg_17_0.map.groundContainer
	local var_17_3 = var_17_1(var_17_0, var_5.TransformVector(var_17_2, arg_17_1))

	arg_17_0._tf.anchoredPosition = var_17_3

	return
end

function var_0_0.BeFatalInjured(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.spineAnim

	var_2.SetActionCallBack(var_18_0, function(arg_19_0)
		if arg_19_0 == "finish" then
			local var_19_0 = arg_18_0.spineAnim

			var_1.SetActionCallBack(var_19_0, nil)
			arg_18_1()
		end

		return
	end)

	arg_18_0.action = "dead"

	local var_18_1 = arg_18_0.spineAnim

	var_2.SetAction(var_18_1, arg_18_0.action, 0)

	return
end

function var_0_0.SetAction(arg_20_0, arg_20_1)
	if arg_20_0.action == arg_20_1 then
		return
	end

	arg_20_0.action = arg_20_1

	local var_20_0 = arg_20_0.spineAnim

	var_2.SetAction(var_20_0, arg_20_1, 0)

	return
end

function var_0_0.Dispose(arg_21_0)
	local var_21_0 = arg_21_0.spineAnim

	var_1.SetActionCallBack(var_21_0, nil)

	LeanTween = var_1

	if var_1.isTweening(arg_21_0._go) then
		LeanTween = var_1

		var_1.cancel(arg_21_0._go)
	end

	if arg_21_0.timer then
		local var_21_1 = arg_21_0.timer

		var_1.Stop(var_21_1)

		arg_21_0.timer = nil
	end

	if arg_21_0.shipName then
		TowerClimbingResMgr = var_1

		var_1.ReturnPlayer(arg_21_0.shipName, arg_21_0._go)
	end

	return
end

return var_0_0
