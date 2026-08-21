local var_0_0 = class("OreEnemy")

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
	arg_1_0.config = OreGameConfig.ENEMY_CONFIG[arg_1_0.id]
	arg_1_0.type = arg_1_6
	arg_1_0.roadID = arg_1_5

	arg_1_0:Init()

	return
end

function var_0_0.AddListener(arg_2_0)
	arg_2_0.binder:bind(OreGameConfig.EVENT_AKASHI_COLLISION, function(arg_3_0, arg_3_1)
		if arg_2_0.isDestroy then
			return
		end

		if arg_2_0 == arg_3_1.b then
			arg_2_0.binder:emit(OreGameConfig.EVENT_AKASHI_HIT, {
				dir = arg_2_0.type == var_0_0.TYPE_RIGHT_TO_LEFT and "W" or "E",
				class = arg_2_0.config.class,
				y = arg_2_0._tf.anchoredPosition.x
			})
		end

		return
	end)
	arg_2_0.binder:bind(OreGameConfig.EVENT_ENEMY_COLLISION, function(arg_4_0, arg_4_1)
		if arg_2_0.isDestroy or arg_2_0.clashTime then
			return
		end

		arg_2_0:OnEnemyCollison(arg_4_1.a, arg_4_1.b)

		return
	end)

	return
end

function var_0_0.AddDftAniEvent(arg_5_0)
	eachChild(arg_5_0._tf:Find("effect"), function(arg_6_0)
		arg_6_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
			setActive(arg_6_0, false)

			if arg_6_0.name == "EF_Clash_Heavy" then
				arg_5_0:Destroy()
			end

			return
		end)

		return
	end)
	arg_5_0._tf:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		arg_5_0:Destroy()

		return
	end)

	return
end

function var_0_0.Init(arg_9_0)
	arg_9_0:AddListener()
	arg_9_0:AddDftAniEvent()

	arg_9_0.index = tonumber(arg_9_0._tf.name)

	if arg_9_0.type == var_0_0.TYPE_RIGHT_TO_LEFT then
		arg_9_0.deltaX = -OreGameConfig.TIME_INTERVAL

		setLocalPosition(arg_9_0._tf, Vector2(var_0_0.BORDER_X, var_0_0.ROAD_Y[arg_9_0.roadID]))
		setLocalEulerAngles(arg_9_0._tf, Vector3(0, 0, 0))
	else
		arg_9_0.deltaX = OreGameConfig.TIME_INTERVAL

		setLocalPosition(arg_9_0._tf, Vector2(-var_0_0.BORDER_X, var_0_0.ROAD_Y[arg_9_0.roadID]))
		setLocalEulerAngles(arg_9_0._tf, Vector3(0, 180, 0))
	end

	arg_9_0.speed = arg_9_0.config.speed

	arg_9_0.collisionMgr:AddEnemyObject(arg_9_0.roadID, arg_9_0.index, arg_9_0)

	arg_9_0.aabbTF = arg_9_0._tf:Find("Image/aabb")

	setActive(arg_9_0.aabbTF, OreGameConfig.SHOW_AABB)

	arg_9_0.aabb = OreGameHelper.GetAABBWithTF(arg_9_0.aabbTF, arg_9_0.type == var_0_0.TYPE_LEFT_TO_RIGHT)

	setActive(arg_9_0._tf:Find("Image"), true)
	arg_9_0._tf:GetComponent(typeof(Animator)):Play("Initial")
	arg_9_0._tf:Find("Image"):GetComponent(typeof(Animator)):Play("Move")
	eachChild(arg_9_0._tf:Find("effect"), function(arg_10_0)
		setActive(arg_10_0, false)

		return
	end)

	local var_9_0 = var_0_0.OFFSET_Y[arg_9_0.id] or 0

	arg_9_0.posY = var_0_0.ROAD_Y[arg_9_0.roadID] + var_9_0

	return
end

function var_0_0.SetSpeed(arg_11_0, arg_11_1)
	arg_11_0.speed = arg_11_1

	return
end

function var_0_0.OnEnemyCollison(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0

	var_12_0 = arg_12_1.type == var_0_0.TYPE_RIGHT_TO_LEFT and (arg_12_1._tf.anchoredPosition.x < arg_12_2._tf.anchoredPosition.x and arg_12_1 or arg_12_2) or arg_12_2._tf.anchoredPosition.x < arg_12_1._tf.anchoredPosition.x and arg_12_1 or arg_12_2

	local var_12_2 = var_12_0 == arg_12_1 and arg_12_2 or arg_12_1
	local var_12_3 = var_12_0.config.class

	if var_12_0.config.class < (var_12_0 == arg_12_1 and arg_12_2 or arg_12_1).config.class then
		if arg_12_0 == var_12_0 then
			if var_12_3 <= 3 and (var_12_0 == arg_12_1 and arg_12_2 or arg_12_1).config.class <= 3 and math.abs(var_12_3 - (var_12_0 == arg_12_1 and arg_12_2 or arg_12_1).config.class) <= 1 then
				arg_12_0:PlayClashLightAnim()
			else
				arg_12_0:PlayClashHeavyAnim()
			end
		end
	elseif arg_12_0 == var_12_2 then
		arg_12_0:SetSpeed(var_12_0.speed)
	end

	return
end

function var_0_0.PlayClashLightAnim(arg_13_0)
	arg_13_0.collisionMgr:RemoveEnemyObject(arg_13_0.roadID, arg_13_0.index, arg_13_0)
	setActive(arg_13_0._tf:Find("effect/EF_Clash_Light"), true)
	arg_13_0._tf:Find("Image"):GetComponent(typeof(Animator)):Play("Clash_Light")

	arg_13_0.clashTime = 0
	arg_13_0.startPoint = arg_13_0._tf.anchoredPosition
	arg_13_0.endPoint = Vector2(arg_13_0.startPoint.x + (arg_13_0.type == var_0_0.TYPE_RIGHT_TO_LEFT and -150 or 150), arg_13_0.startPoint.y)
	arg_13_0.centerPoint = Vector2((arg_13_0.startPoint.x + arg_13_0.endPoint.x) / 2, arg_13_0.startPoint.y + 50)

	return
end

function var_0_0.PlayClashHeavyAnim(arg_14_0)
	arg_14_0.collisionMgr:RemoveEnemyObject(arg_14_0.roadID, arg_14_0.index, arg_14_0)
	setActive(arg_14_0._tf:Find("Image"), false)
	setActive(arg_14_0._tf:Find("effect/EF_Clash_Heavy"), true)

	return
end

function var_0_0.Destroy(arg_15_0)
	if arg_15_0.isDestroy then
		return arg_15_0.isDestroy
	end

	arg_15_0.isDestroy = true

	arg_15_0.binder:emit(OreGameConfig.EVENT_ENEMY_DESTROY, {
		roadID = arg_15_0.roadID,
		index = arg_15_0.index,
		id = arg_15_0.id
	})
	arg_15_0.collisionMgr:RemoveEnemyObject(arg_15_0.roadID, arg_15_0.index, arg_15_0)

	return
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.isDestroy = true

	return
end

function var_0_0.OnTimer(arg_17_0, arg_17_1)
	if arg_17_0.clashTime then
		if arg_17_0.clashTime < var_0_0.CLASH_TIME then
			arg_17_0.clashTime = arg_17_0.clashTime + arg_17_1

			setAnchoredPosition(arg_17_0._tf, (OreGameHelper.GetBeziersPoints(arg_17_0.startPoint, arg_17_0.endPoint, arg_17_0.centerPoint, arg_17_0.clashTime)))
		else
			arg_17_0._tf:GetComponent(typeof(Animator)):Play("fade_away")

			arg_17_0.clashTime = nil
		end

		return
	end

	setLocalPosition(arg_17_0._tf, {
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

	var_20_0 = arg_20_0.type == var_0_0.TYPE_RIGHT_TO_LEFT and arg_20_0._tf.anchoredPosition.x + arg_20_0.aabbTF.anchoredPosition.x or arg_20_0._tf.anchoredPosition.x - arg_20_0.aabbTF.anchoredPosition.x

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
