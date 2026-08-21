local var_0_0 = class("RectCollider")
local var_0_1 = Application.targetFrameRate or 60
local var_0_2 = 1 / var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._animTf = findTF(arg_1_1, "anim")
	arg_1_0._config = arg_1_2
	arg_1_0._event = arg_1_3
	arg_1_0.scriptList = {}
	arg_1_0._scripts = {}
	arg_1_0._collisionInfo = RectCollisionInfo.New(arg_1_0._config, arg_1_0._tf)
	arg_1_0._collisionInfo.frameRate = var_0_2
	arg_1_0._keyInfo = RectKeyInfo.New()

	arg_1_0._keyInfo:setTriggerCallback(function(arg_2_0, arg_2_1)
		arg_1_0:onKeyTrigger(arg_2_0, arg_2_1)

		return
	end)

	arg_1_0._keyTrigger = RectKeyTriggerController.New(arg_1_0._keyInfo)
	arg_1_0.initFlag = false

	return
end

function var_0_0.onInit(arg_3_0)
	arg_3_0._translateVelocity = Vector2(0, 0)
	arg_3_0._collider2d = GetComponent(findTF(arg_3_0._tf, "collider"), typeof(BoxCollider2D))
	arg_3_0._origins = RectOriginsCom.New(arg_3_0._collider2d)
	arg_3_0.colliderController = RectColliderController.New(arg_3_0._collisionInfo, arg_3_0._origins)

	return
end

function var_0_0.clear(arg_4_0)
	if arg_4_0._collisionInfo.script then
		arg_4_0._collisionInfo.script:active(false)
		arg_4_0._collisionInfo:removeScript()
	end

	arg_4_0._keyTrigger:destroy()

	return
end

function var_0_0.addScript(arg_5_0, arg_5_1)
	arg_5_1:setData(arg_5_0._collisionInfo, arg_5_0._keyInfo, arg_5_0._event)

	arg_5_0.scriptList[arg_5_1.__cname] = arg_5_1

	table.insert(arg_5_0._scripts, arg_5_1)

	if #arg_5_0._scripts >= 2 then
		table.sort(arg_5_0._scripts, function(arg_6_0, arg_6_1)
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
	arg_8_0._collisionInfo:removeScript()

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._scripts) do
		iter_8_1:active(false)
	end

	return
end

function var_0_0.step(arg_9_0)
	if not arg_9_0.initFlag then
		arg_9_0.initFlag = true

		arg_9_0:onInit()
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._scripts) do
		iter_9_1:step()
	end

	local var_9_0 = arg_9_0._collisionInfo:getVelocity()

	arg_9_0._translateVelocity.x = var_9_0.x * arg_9_0._collisionInfo.frameRate
	arg_9_0._translateVelocity.y = var_9_0.y * arg_9_0._collisionInfo.frameRate

	arg_9_0.colliderController:move(arg_9_0._translateVelocity)
	arg_9_0._tf:Translate(arg_9_0._translateVelocity)
	arg_9_0._collisionInfo:setPos(arg_9_0._tf.anchoredPosition)

	if arg_9_0._collisionInfo.directionalInput.x ~= 0 and math.sign(arg_9_0._tf.localScale.x) ~= arg_9_0._collisionInfo.directionalInput.x then
		arg_9_0._tf.localScale = Vector3(arg_9_0._tf.localScale.x * -1, arg_9_0._tf.localScale.y, arg_9_0._tf.localScale.z)
	end

	for iter_9_2, iter_9_3 in ipairs(arg_9_0._scripts) do
		iter_9_3:lateStep()
	end

	if arg_9_0._collisionInfo.script and arg_9_0._collisionInfo.scriptTime then
		arg_9_0._collisionInfo.scriptTime = arg_9_0._collisionInfo.scriptTime - arg_9_0._collisionInfo.frameRate

		if arg_9_0._collisionInfo.scriptTime <= 0 then
			arg_9_0._collisionInfo.script:active(false)
			arg_9_0._collisionInfo:removeScript()
		end
	end

	return
end

function var_0_0.onKeyTrigger(arg_10_0, arg_10_1, arg_10_2)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.scriptList) do
		iter_10_1:keyTrigger(arg_10_1, arg_10_2)
	end

	return
end

function var_0_0.getCollisionInfo(arg_11_0)
	return arg_11_0._collisionInfo
end

function var_0_0.getScript(arg_12_0, arg_12_1)
	return arg_12_0.scriptList[arg_12_1.__cname] or nil
end

return var_0_0
