class = var_0_10000

local var_0_0 = var_0_10000("OreEnemy")

var_0_0.TYPE_RIGHT_TO_LEFT = 1
var_0_0.TYPE_LEFT_TO_RIGHT = 2
var_0_0.BORDER_X = 300
var_0_0.ROAD_Y = {
	20,
	-28,
	-73
}
var_0_0.CLASH_TIME = 0.5
var_0_0.OFFSET_Y = {
	[9] = 17,
	[5] = 17
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	arg_1_0.binder = arg_1_1
	arg_1_0._tf = arg_1_2
	arg_1_0.collisionMgr = arg_1_3
	arg_1_0.id = arg_1_4
	OreGameConfig = var_1_10007
	arg_1_0.config = var_1_10007.ENEMY_CONFIG[arg_1_0.id]
	arg_1_0.type = arg_1_6
	arg_1_0.roadID = arg_1_5

	arg_1_0:Init()

	return
end

function var_0_0.AddListener(arg_2_0)
	local var_2_0 = arg_2_0.binder
	local var_2_1 = var_1.bind

	OreGameConfig = var_1_10003

	var_2_1(var_2_0, var_1_10003.EVENT_AKASHI_COLLISION, function(arg_3_0, arg_3_1)
		if arg_2_0.isDestroy then
			return
		end

		if arg_2_0 == arg_3_1.b then
			local var_3_0 = arg_2_0.type == var_0_0.TYPE_RIGHT_TO_LEFT and "W" or "E"
			local var_3_1 = arg_2_0.binder
			local var_3_2 = var_3.emit

			OreGameConfig = var_2_10005

			var_3_2(var_3_1, var_2_10005.EVENT_AKASHI_HIT, {
				dir = var_3_0,
				class = arg_2_0.config.class,
				y = arg_2_0._tf.anchoredPosition.x
			})
		end

		return
	end)

	local var_2_2 = arg_2_0.binder
	local var_2_3 = var_1.bind

	OreGameConfig = var_3

	var_2_3(var_2_2, var_3.EVENT_ENEMY_COLLISION, function(arg_4_0, arg_4_1)
		if arg_2_0.isDestroy or arg_2_0.clashTime then
			return
		end

		local var_4_0 = arg_2_0

		var_2.OnEnemyCollison(var_4_0, arg_4_1.a, arg_4_1.b)

		return
	end)

	return
end

function var_0_0.AddDftAniEvent(arg_5_0)
	eachChild = var_1_10001

	local var_5_0 = arg_5_0._tf

	var_1_10001(var_2.Find(var_5_0, "effect"), function(arg_6_0)
		local var_6_0 = arg_6_0
		local var_6_1 = arg_6_0.GetComponent

		typeof = var_2_10003
		DftAniEvent = var_2_10004

		local var_6_2 = var_6_1(var_6_0, var_2_10003(var_2_10004))

		var_1.SetEndEvent(var_6_2, function()
			setActive = var_3_10000

			var_3_10000(arg_6_0, false)

			if arg_6_0.name == "EF_Clash_Heavy" then
				local var_7_0 = arg_5_0

				var_0.Destroy(var_7_0)
			end

			return
		end)

		return
	end)

	local var_5_1 = arg_5_0._tf
	local var_5_2 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_4

	local var_5_3 = var_5_2(var_5_1, var_3(var_4))

	var_1.SetEndEvent(var_5_3, function()
		local var_8_0 = arg_5_0

		var_0.Destroy(var_8_0)

		return
	end)

	return
end

function var_0_0.Init(arg_9_0)
	arg_9_0:AddListener()
	arg_9_0:AddDftAniEvent()

	tonumber = var_1
	arg_9_0.index = var_1(arg_9_0._tf.name)

	if arg_9_0.type == var_0_0.TYPE_RIGHT_TO_LEFT then
		OreGameConfig = var_1
		arg_9_0.deltaX = -var_1.TIME_INTERVAL
		setLocalPosition = var_1

		local var_9_0 = arg_9_0._tf

		Vector2 = var_1_10003

		var_1(var_9_0, var_1_10003(var_0_0.BORDER_X, var_0_0.ROAD_Y[arg_9_0.roadID]))

		setLocalEulerAngles = var_1

		local var_9_1 = arg_9_0._tf

		Vector3 = var_1_10003

		var_1(var_9_1, var_1_10003(0, 0, 0))
	else
		OreGameConfig = var_1
		arg_9_0.deltaX = var_1.TIME_INTERVAL
		setLocalPosition = var_1

		local var_9_2 = arg_9_0._tf

		Vector2 = var_1_10003

		var_1(var_9_2, var_1_10003(-var_0_0.BORDER_X, var_0_0.ROAD_Y[arg_9_0.roadID]))

		setLocalEulerAngles = var_1

		local var_9_3 = arg_9_0._tf

		Vector3 = var_3

		var_1(var_9_3, var_3(0, 180, 0))
	end

	arg_9_0.speed = arg_9_0.config.speed

	local var_9_4 = arg_9_0.collisionMgr

	var_1.AddEnemyObject(var_9_4, arg_9_0.roadID, arg_9_0.index, arg_9_0)

	local var_9_5 = arg_9_0._tf

	arg_9_0.aabbTF = var_1.Find(var_9_5, "Image/aabb")
	setActive = var_1

	local var_9_6 = arg_9_0.aabbTF

	OreGameConfig = var_3

	var_1(var_9_6, var_3.SHOW_AABB)

	OreGameHelper = var_1
	arg_9_0.aabb = var_1.GetAABBWithTF(arg_9_0.aabbTF, arg_9_0.type == var_0_0.TYPE_LEFT_TO_RIGHT)
	setActive = var_1

	local var_9_7 = arg_9_0._tf

	var_1(var_2.Find(var_9_7, "Image"), true)

	local var_9_8 = arg_9_0._tf
	local var_9_9 = var_1.GetComponent

	typeof = var_3
	Animator = var_4

	local var_9_10 = var_9_9(var_9_8, var_3(var_4))

	var_1.Play(var_9_10, "Initial")

	local var_9_11 = arg_9_0._tf
	local var_9_12 = var_1.Find(var_9_11, "Image")
	local var_9_13 = var_1.GetComponent

	typeof = var_3
	Animator = var_4

	local var_9_14 = var_9_13(var_9_12, var_3(var_4))

	var_1.Play(var_9_14, "Move")

	eachChild = var_1

	local var_9_15 = arg_9_0._tf

	var_1(var_2.Find(var_9_15, "effect"), function(arg_10_0)
		setActive = var_2_10001

		var_2_10001(arg_10_0, false)

		return
	end)

	local var_9_16 = var_0_0.ROAD_Y[arg_9_0.roadID]
	local var_9_17

	if not var_0_0.OFFSET_Y[arg_9_0.id] then
		var_9_17 = 0
	end

	arg_9_0.posY = var_9_16 + var_9_17

	return
end

function var_0_0.SetSpeed(arg_11_0, arg_11_1)
	arg_11_0.speed = arg_11_1

	return
end

function var_0_0.OnEnemyCollison(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1.type
	local var_12_1
	local var_12_2
	local var_12_3 = arg_12_1._tf.anchoredPosition.x
	local var_12_4 = arg_12_2._tf.anchoredPosition.x

	if var_12_0 == var_0_0.TYPE_RIGHT_TO_LEFT then
		var_12_1 = var_12_3 < var_12_4 and arg_12_1 or arg_12_2
	else
		var_12_1 = var_12_4 < var_12_3 and arg_12_1 or arg_12_2
	end

	local var_12_5 = var_12_1 == arg_12_1 and arg_12_2 or arg_12_1

	if var_12_1.config.class < var_12_5.config.class then
		if arg_12_0 == var_12_1 then
			if var_8 <= 3 and var_9 <= 3 then
				math = var_10

				if var_10.abs(var_8 - var_9) <= 1 then
					arg_12_0:PlayClashLightAnim()

					goto label_12_0
				end
			end

			arg_12_0:PlayClashHeavyAnim()
		end
	elseif arg_12_0 == var_12_5 then
		arg_12_0:SetSpeed(var_12_1.speed)
	end

	::label_12_0::

	return
end

function var_0_0.PlayClashLightAnim(arg_13_0)
	local var_13_0 = arg_13_0.collisionMgr

	var_1.RemoveEnemyObject(var_13_0, arg_13_0.roadID, arg_13_0.index, arg_13_0)

	setActive = var_1

	local var_13_1 = arg_13_0._tf

	var_1(var_2.Find(var_13_1, "effect/EF_Clash_Light"), true)

	local var_13_2 = arg_13_0._tf
	local var_13_3 = var_1.Find(var_13_2, "Image")
	local var_13_4 = var_1.GetComponent

	typeof = var_3
	Animator = var_4

	local var_13_5 = var_13_4(var_13_3, var_3(var_4))

	var_1.Play(var_13_5, "Clash_Light")

	arg_13_0.clashTime = 0
	arg_13_0.startPoint = arg_13_0._tf.anchoredPosition

	local var_13_6 = arg_13_0.type == var_0_0.TYPE_RIGHT_TO_LEFT and -150 or 150

	Vector2 = var_2
	arg_13_0.endPoint = var_2(arg_13_0.startPoint.x + var_13_6, arg_13_0.startPoint.y)
	Vector2 = var_2
	arg_13_0.centerPoint = var_2((arg_13_0.startPoint.x + arg_13_0.endPoint.x) / 2, arg_13_0.startPoint.y + 50)

	return
end

function var_0_0.PlayClashHeavyAnim(arg_14_0)
	local var_14_0 = arg_14_0.collisionMgr

	var_1.RemoveEnemyObject(var_14_0, arg_14_0.roadID, arg_14_0.index, arg_14_0)

	setActive = var_1

	local var_14_1 = arg_14_0._tf

	var_1(var_2.Find(var_14_1, "Image"), false)

	setActive = var_1

	local var_14_2 = arg_14_0._tf

	var_1(var_2.Find(var_14_2, "effect/EF_Clash_Heavy"), true)

	return
end

function var_0_0.Destroy(arg_15_0)
	if arg_15_0.isDestroy then
		return arg_15_0.isDestroy
	end

	arg_15_0.isDestroy = true

	local var_15_0 = arg_15_0.binder
	local var_15_1 = var_1.emit

	OreGameConfig = var_1_10003

	var_15_1(var_15_0, var_1_10003.EVENT_ENEMY_DESTROY, {
		roadID = arg_15_0.roadID,
		index = arg_15_0.index,
		id = arg_15_0.id
	})

	local var_15_2 = arg_15_0.collisionMgr

	var_1.RemoveEnemyObject(var_15_2, arg_15_0.roadID, arg_15_0.index, arg_15_0)

	return
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.isDestroy = true

	return
end

function var_0_0.OnTimer(arg_17_0, arg_17_1)
	local var_17_0

	if arg_17_0.clashTime then
		if arg_17_0.clashTime < var_0_0.CLASH_TIME then
			arg_17_0.clashTime = arg_17_0.clashTime + arg_17_1
			OreGameHelper = var_17_0
			var_17_0 = var_17_0.GetBeziersPoints(arg_17_0.startPoint, arg_17_0.endPoint, arg_17_0.centerPoint, arg_17_0.clashTime)
			setAnchoredPosition = var_3

			var_3(arg_17_0._tf, var_17_0)
		else
			local var_17_1 = arg_17_0._tf

			var_17_0 = var_17_0.GetComponent
			typeof = var_1_10004
			Animator = var_1_10005

			local var_17_2 = var_17_0(var_17_1, var_1_10004(var_1_10005))

			var_17_0.Play(var_17_2, "fade_away")

			arg_17_0.clashTime = nil
		end

		return
	end

	setLocalPosition = var_17_0

	var_17_0(arg_17_0._tf, {
		x = arg_17_0._tf.anchoredPosition.x + arg_17_0.deltaX * arg_17_0.speed,
		y = arg_17_0.posY
	})

	if (arg_17_0._tf.anchoredPosition.x < -var_0_0.BORDER_X - 10 or arg_17_0._tf.anchoredPosition.x > var_0_0.BORDER_X + 10) and not arg_17_0.isDestroy then
		arg_17_0:Destroy()
	end

	return
end

function var_0_0.GetAABB(arg_18_0)
	return arg_18_0.aabb
end

function var_0_0.GetCarryTriggerOffset(arg_19_0)
	return {
		0,
		10
	}
end

function var_0_0.GetCollisionInfo(arg_20_0)
	local var_20_0 = 0

	if arg_20_0.type == var_0_0.TYPE_RIGHT_TO_LEFT then
		var_20_0 = arg_20_0._tf.anchoredPosition.x + arg_20_0.aabbTF.anchoredPosition.x
	else
		var_20_0 = arg_20_0._tf.anchoredPosition.x - arg_20_0.aabbTF.anchoredPosition.x
	end

	return {
		pos = {
			x = var_20_0,
			y = arg_20_0._tf.anchoredPosition.y + arg_20_0.aabbTF.anchoredPosition.y
		},
		aabb = arg_20_0:GetAABB(),
		carryOffset = arg_20_0:GetCarryTriggerOffset()
	}
end

return var_0_0
