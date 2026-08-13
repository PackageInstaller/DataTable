class = var_0_10000

local var_0_0 = var_0_10000("Ore")

var_0_0.TYPE_SMALL = 1
var_0_0.TYPE_LA = 2
var_0_0.FallTime = 1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.binder = arg_1_1
	arg_1_0._tf = arg_1_2
	arg_1_0.collisionMgr = arg_1_3
	arg_1_0.id = arg_1_4
	OreGameConfig = var_1_10006
	arg_1_0.config = var_1_10006.ORE_CONFIG[arg_1_0.id]
	arg_1_0.startPoint = arg_1_5

	arg_1_0:Init()

	return
end

function var_0_0.AddListener(arg_2_0)
	local var_2_0 = arg_2_0.binder
	local var_2_1 = var_1.bind

	OreGameConfig = var_1_10003

	var_2_1(var_2_0, var_1_10003.EVENT_UPDATE_ORE_TARGET, function(arg_3_0, arg_3_1)
		if not arg_2_0.isDestroy then
			setActive = var_2
			findTF = var_2_10003

			var_2(var_2_10003(arg_2_0.effectTF, "Frame"), arg_2_0.index == arg_3_1.index)
		end

		arg_2_0.isTarget = arg_2_0.index == arg_3_1.index

		return
	end)

	local var_2_2 = arg_2_0.binder
	local var_2_3 = var_1.bind

	OreGameConfig = var_3

	var_2_3(var_2_2, var_3.EVENT_CHECK_CARRY, function(arg_4_0, arg_4_1)
		if not arg_2_0.isDestroy and arg_2_0.isTarget then
			local var_4_0 = arg_4_1.weight + arg_2_0.config.weight

			OreGameConfig = var_3

			if var_3.MAX_WEIGHT < var_4_0 then
				setActive = var_4_0
				findTF = var_3

				var_4_0(var_3(arg_2_0.effectTF, "Limit"), true)

				setActive = var_4_0
				findTF = var_3

				var_4_0(var_3(arg_2_0.effectTF, "Full"), true)
			else
				local var_4_1 = arg_2_0.binder
				local var_4_2 = var_2.emit

				OreGameConfig = var_2_10004

				var_4_2(var_4_1, var_2_10004.EVENT_DO_CARRY, {
					weight = arg_2_0.config.weight,
					point = arg_2_0.config.score,
					type = arg_2_0.config.type
				})

				local var_4_3 = arg_2_0.animator

				var_2.Play(var_4_3, "Vanish")

				local var_4_4 = arg_2_0.collisionMgr

				var_2.RemoveOreObject(var_4_4, arg_2_0.index, arg_2_0)
			end
		end

		return
	end)

	return
end

function var_0_0.AddDftAniEvent(arg_5_0)
	findTF = var_1_10001

	local var_5_0 = var_1_10001(arg_5_0._tf, "main")
	local var_5_1 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004

	local var_5_2 = var_5_1(var_5_0, var_3(var_1_10004))

	var_1.SetEndEvent(var_5_2, function()
		local var_6_0 = arg_5_0

		var_0.Destroy(var_6_0)

		return
	end)

	findTF = var_1

	local var_5_3 = var_1(arg_5_0._tf, "main/Image")
	local var_5_4 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004

	local var_5_5 = var_5_4(var_5_3, var_3(var_1_10004))

	var_1.SetEndEvent(var_5_5, function()
		local var_7_0 = arg_5_0

		var_0.Destroy(var_7_0)

		return
	end)

	findTF = var_1

	local var_5_6 = var_1(arg_5_0.effectTF, "Limit")
	local var_5_7 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004

	local var_5_8 = var_5_7(var_5_6, var_3(var_1_10004))

	var_1.SetEndEvent(var_5_8, function()
		setActive = var_2_10000
		findTF = var_2_10001

		var_2_10000(var_2_10001(arg_5_0.effectTF, "Limit"), false)

		return
	end)

	findTF = var_1

	local var_5_9 = var_1(arg_5_0.effectTF, "Full")
	local var_5_10 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004

	local var_5_11 = var_5_10(var_5_9, var_3(var_1_10004))

	var_1.SetEndEvent(var_5_11, function()
		setActive = var_2_10000
		findTF = var_2_10001

		var_2_10000(var_2_10001(arg_5_0.effectTF, "Full"), false)

		return
	end)

	return
end

function var_0_0.Init(arg_10_0)
	setAnchoredPosition = var_1_10001

	var_1_10001(arg_10_0._tf, arg_10_0.startPoint)

	findTF = var_1_10001
	arg_10_0.effectTF = var_1_10001(arg_10_0._tf, "effect")
	findTF = var_1

	local var_10_0 = var_1(arg_10_0._tf, "main/Image")
	local var_10_1 = var_1.GetComponent

	typeof = var_3
	Animator = var_1_10004
	arg_10_0.animator = var_10_1(var_10_0, var_3(var_1_10004))
	arg_10_0.index = arg_10_0._tf.name
	findTF = var_1
	arg_10_0.endPoint = var_1(arg_10_0._tf.parent.parent, "pos/" .. arg_10_0._tf.name).anchoredPosition
	math = var_1

	local var_10_2 = var_1.random()
	local var_10_3 = 0.5 < var_10_2 and -10 or 10

	Vector2 = var_2
	arg_10_0.centerPoint = var_2(arg_10_0.startPoint.x + var_10_3, arg_10_0.startPoint.y + 80)
	arg_10_0.time = 0
	arg_10_0.isFallEnd = false
	arg_10_0.isTarget = false

	arg_10_0:AddListener()
	arg_10_0:AddDftAniEvent()

	local var_10_4 = arg_10_0._tf
	local var_10_5 = var_2.Find(var_10_4, "main")
	local var_10_6 = var_2.GetComponent

	typeof = var_4
	Animator = var_1_10005

	local var_10_7 = var_10_6(var_10_5, var_4(var_1_10005))

	var_2.Play(var_10_7, "Initial")

	local var_10_8 = arg_10_0._tf
	local var_10_9 = var_2.Find(var_10_8, "main/Image")
	local var_10_10 = var_2.GetComponent

	typeof = var_4
	Animator = var_1_10005

	local var_10_11 = var_10_10(var_10_9, var_4(var_1_10005))

	var_2.Play(var_10_11, "Fall")

	eachChild = var_2

	var_2(arg_10_0.effectTF, function(arg_11_0)
		setActive = var_2_10001

		var_2_10001(arg_11_0, false)

		return
	end)

	return
end

function var_0_0.FallEnd(arg_12_0)
	local var_12_0 = arg_12_0.animator

	var_1.Play(var_12_0, "Spawn")

	arg_12_0.isFallEnd = true

	local var_12_1 = arg_12_0.collisionMgr

	var_1.AddOreObject(var_12_1, arg_12_0.index, arg_12_0)

	return
end

function var_0_0.PlayBlink(arg_13_0)
	findTF = var_1_10001

	local var_13_0 = var_1_10001(arg_13_0._tf, "main")
	local var_13_1 = var_1.GetComponent

	typeof = var_3
	Animator = var_1_10004

	local var_13_2 = var_13_1(var_13_0, var_3(var_1_10004))

	var_1.Play(var_13_2, "Blink")

	return
end

function var_0_0.Destroy(arg_14_0)
	if arg_14_0.isDestroy then
		return
	end

	local var_14_0 = arg_14_0.binder
	local var_14_1 = var_1.emit

	OreGameConfig = var_1_10003

	var_14_1(var_14_0, var_1_10003.EVENT_ORE_DESTROY, {
		index = arg_14_0.index,
		id = arg_14_0.id
	})

	local var_14_2 = arg_14_0.collisionMgr

	var_1.RemoveOreObject(var_14_2, arg_14_0.index, arg_14_0)

	arg_14_0.isDestroy = true

	return
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.isDestroy = true

	return
end

function var_0_0.OnTimer(arg_16_0, arg_16_1)
	if arg_16_0.time < var_0_0.FallTime then
		arg_16_0.time = arg_16_0.time + arg_16_1
		OreGameHelper = var_2

		local var_16_0 = var_2.GetBeziersPoints(arg_16_0.startPoint, arg_16_0.endPoint, arg_16_0.centerPoint, arg_16_0.time)

		setAnchoredPosition = var_3

		var_3(arg_16_0._tf, var_16_0)
	elseif not arg_16_0.isFallEnd then
		arg_16_0:FallEnd()
	end

	if arg_16_0.isFallEnd then
		arg_16_0.time = arg_16_0.time + arg_16_1

		if arg_16_0.time > var_0_0.FallTime + arg_16_0.config.duration then
			arg_16_0:PlayBlink()
		end
	end

	return
end

function var_0_0.GetAABB(arg_17_0)
	if arg_17_0.config.size == var_0_0.TYPE_SMALL then
		return {
			{
				-7,
				7
			},
			{
				7,
				-7
			}
		}
	else
		return {
			{
				-11,
				11
			},
			{
				13,
				-13
			}
		}
	end

	return
end

function var_0_0.GetCollisionInfo(arg_18_0)
	return {
		pos = arg_18_0._tf.anchoredPosition,
		aabb = arg_18_0:GetAABB()
	}
end

return var_0_0
