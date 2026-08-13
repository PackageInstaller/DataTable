class = var_0_10000

local var_0_0 = var_0_10000("RectCollider")

Application = var_0_10001

local var_0_1

if not var_0_10001.targetFrameRate then
	var_0_1 = 60
end

local var_0_2 = 1 / var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	findTF = var_1_10004
	arg_1_0._animTf = var_1_10004(arg_1_1, "anim")
	arg_1_0._config = arg_1_2
	arg_1_0._event = arg_1_3
	arg_1_0.scriptList = {}
	arg_1_0._scripts = {}
	RectCollisionInfo = var_4
	arg_1_0._collisionInfo = var_4.New(arg_1_0._config, arg_1_0._tf)

	local var_1_0 = arg_1_0._collisionInfo

	var_1_0.frameRate = var_0_2
	RectKeyInfo = var_1_0
	arg_1_0._keyInfo = var_1_0.New()

	local var_1_1 = arg_1_0._keyInfo

	var_4.setTriggerCallback(var_1_1, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0

		var_2.onKeyTrigger(var_2_0, arg_2_0, arg_2_1)

		return
	end)

	RectKeyTriggerController = var_4
	arg_1_0._keyTrigger = var_4.New(arg_1_0._keyInfo)
	arg_1_0.initFlag = false

	return
end

function var_0_0.onInit(arg_3_0)
	Vector2 = var_1_10001
	arg_3_0._translateVelocity = var_1_10001(0, 0)
	GetComponent = var_1
	findTF = var_3

	local var_3_0 = var_3(arg_3_0._tf, "collider")

	typeof = var_4
	BoxCollider2D = var_6
	arg_3_0._collider2d = var_1(var_3_0, var_4(var_6))
	RectOriginsCom = var_1
	arg_3_0._origins = var_1.New(arg_3_0._collider2d)
	RectColliderController = var_1
	arg_3_0.colliderController = var_1.New(arg_3_0._collisionInfo, arg_3_0._origins)

	return
end

function var_0_0.clear(arg_4_0)
	if arg_4_0._collisionInfo.script then
		local var_4_0 = arg_4_0._collisionInfo.script

		var_1.active(var_4_0, false)

		local var_4_1 = arg_4_0._collisionInfo

		var_1.removeScript(var_4_1)
	end

	local var_4_2 = arg_4_0._keyTrigger

	var_1.destroy(var_4_2)

	return
end

function var_0_0.addScript(arg_5_0, arg_5_1)
	arg_5_1:setData(arg_5_0._collisionInfo, arg_5_0._keyInfo, arg_5_0._event)

	local var_5_0 = arg_5_0.scriptList

	var_5_0[arg_5_1.__cname] = arg_5_1
	table = var_5_0

	var_5_0.insert(arg_5_0._scripts, arg_5_1)

	if #arg_5_0._scripts >= 2 then
		table = var_2

		var_2.sort(arg_5_0._scripts, function(arg_6_0, arg_6_1)
			return arg_6_0:getWeight() < arg_6_1:getWeight()
		end)
	end

	return
end

function var_0_0.addScripts(arg_7_0, arg_7_1)
	for iter_7_0 = 1, #arg_7_1 do
		arg_7_0:addScript(arg_7_1[iter_7_0])
	end

	return
end

function var_0_0.start(arg_8_0)
	local var_8_0 = arg_8_0._collisionInfo

	var_1.removeScript(var_8_0)

	ipairs = var_1

	for iter_8_0, iter_8_1 in var_1(arg_8_0._scripts) do
		iter_8_1:active(false)
	end

	return
end

function var_0_0.step(arg_9_0)
	if not arg_9_0.initFlag then
		arg_9_0.initFlag = true

		arg_9_0:onInit()
	end

	ipairs = var_1

	for iter_9_0, iter_9_1 in var_1(arg_9_0._scripts) do
		iter_9_1:step()
	end

	local var_9_0 = arg_9_0._collisionInfo
	local var_9_1 = var_1.getVelocity(var_9_0)

	arg_9_0._translateVelocity.x = var_9_1.x * arg_9_0._collisionInfo.frameRate
	arg_9_0._translateVelocity.y = var_9_1.y * arg_9_0._collisionInfo.frameRate

	local var_9_2 = arg_9_0.colliderController

	var_2.move(var_9_2, arg_9_0._translateVelocity)

	local var_9_3 = arg_9_0._tf

	var_2.Translate(var_9_3, arg_9_0._translateVelocity)

	local var_9_4 = arg_9_0._collisionInfo

	var_2.setPos(var_9_4, arg_9_0._tf.anchoredPosition)

	local var_9_5

	if arg_9_0._collisionInfo.directionalInput.x ~= 0 then
		math = var_9_5

		if var_9_5.sign(arg_9_0._tf.localScale.x) ~= arg_9_0._collisionInfo.directionalInput.x then
			var_9_5 = arg_9_0._tf
			Vector3 = var_3
			var_9_5.localScale = var_3(arg_9_0._tf.localScale.x * -1, arg_9_0._tf.localScale.y, arg_9_0._tf.localScale.z)
		end
	end

	ipairs = var_9_5

	for iter_9_2, iter_9_3 in var_9_5(arg_9_0._scripts) do
		iter_9_3:lateStep()
	end

	if arg_9_0._collisionInfo.script and arg_9_0._collisionInfo.scriptTime then
		arg_9_0._collisionInfo.scriptTime = arg_9_0._collisionInfo.scriptTime - arg_9_0._collisionInfo.frameRate

		if arg_9_0._collisionInfo.scriptTime <= 0 then
			local var_9_6 = arg_9_0._collisionInfo.script

			var_2.active(var_9_6, false)

			local var_9_7 = arg_9_0._collisionInfo

			var_2.removeScript(var_9_7)
		end
	end

	return
end

function var_0_0.onKeyTrigger(arg_10_0, arg_10_1, arg_10_2)
	pairs = var_1_10003

	for iter_10_0, iter_10_1 in var_1_10003(arg_10_0.scriptList) do
		iter_10_1:keyTrigger(arg_10_1, arg_10_2)
	end

	return
end

function var_0_0.getCollisionInfo(arg_11_0)
	return arg_11_0._collisionInfo
end

function var_0_0.getScript(arg_12_0, arg_12_1)
	local var_12_0

	if not arg_12_0.scriptList[arg_12_1.__cname] then
		var_12_0 = nil
	end

	return var_12_0
end

return var_0_0
