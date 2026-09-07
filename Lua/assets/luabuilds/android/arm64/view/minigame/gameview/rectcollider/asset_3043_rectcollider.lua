local RectCollider = class("RectCollider")
local var_0_1 = 1 / (Application.targetFrameRate or 60)

function RectCollider:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._animTf = findTF(arg_1_1, "anim")
	self._config = arg_1_2
	self._event = arg_1_3
	self.scriptList = {}
	self._scripts = {}
	self._collisionInfo = RectCollisionInfo.New(self._config, self._tf)
	self._collisionInfo.frameRate = var_0_1
	self._keyInfo = RectKeyInfo.New()

	self._keyInfo:setTriggerCallback(function(arg_2_0, arg_2_1)
		self:onKeyTrigger(arg_2_0, arg_2_1)

		return
	end)

	self._keyTrigger = RectKeyTriggerController.New(self._keyInfo)
	self.initFlag = false

	return
end

function RectCollider:onInit()
	self._translateVelocity = Vector2(0, 0)
	self._collider2d = GetComponent(findTF(self._tf, "collider"), typeof(BoxCollider2D))
	self._origins = RectOriginsCom.New(self._collider2d)
	self.colliderController = RectColliderController.New(self._collisionInfo, self._origins)

	return
end

function RectCollider:clear()
	if self._collisionInfo.script then
		self._collisionInfo.script:active(false)
		self._collisionInfo:removeScript()
	end

	self._keyTrigger:destroy()

	return
end

function RectCollider:addScript(arg_5_1)
	arg_5_1:setData(self._collisionInfo, self._keyInfo, self._event)

	self.scriptList[arg_5_1.__cname] = arg_5_1

	table.insert(self._scripts, arg_5_1)

	if #self._scripts >= 2 then
		table.sort(self._scripts, function(arg_6_0, arg_6_1)
			return arg_6_0:getWeight() < arg_6_1:getWeight()
		end)
	end

	return
end

function RectCollider:addScripts(arg_7_1)
	for iter_7_0 = 1, #arg_7_1 do
		self:addScript(arg_7_1[iter_7_0])
	end

	return
end

function RectCollider:start()
	self._collisionInfo:removeScript()

	for iter_8_0, iter_8_1 in ipairs(self._scripts) do
		iter_8_1:active(false)
	end

	return
end

function RectCollider:step()
	if not self.initFlag then
		self.initFlag = true

		self:onInit()
	end

	for iter_9_0, iter_9_1 in ipairs(self._scripts) do
		iter_9_1:step()
	end

	local var_9_0 = self._collisionInfo:getVelocity()

	self._translateVelocity.x = var_9_0.x * self._collisionInfo.frameRate
	self._translateVelocity.y = var_9_0.y * self._collisionInfo.frameRate

	self.colliderController:move(self._translateVelocity)
	self._tf:Translate(self._translateVelocity)
	self._collisionInfo:setPos(self._tf.anchoredPosition)

	if self._collisionInfo.directionalInput.x ~= 0 and math.sign(self._tf.localScale.x) ~= self._collisionInfo.directionalInput.x then
		self._tf.localScale = Vector3(self._tf.localScale.x * -1, self._tf.localScale.y, self._tf.localScale.z)
	end

	for iter_9_2, iter_9_3 in ipairs(self._scripts) do
		iter_9_3:lateStep()
	end

	if self._collisionInfo.script and self._collisionInfo.scriptTime then
		self._collisionInfo.scriptTime = self._collisionInfo.scriptTime - self._collisionInfo.frameRate

		if self._collisionInfo.scriptTime <= 0 then
			self._collisionInfo.script:active(false)
			self._collisionInfo:removeScript()
		end
	end

	return
end

function RectCollider:onKeyTrigger(arg_10_1, arg_10_2)
	for iter_10_0, iter_10_1 in pairs(self.scriptList) do
		iter_10_1:keyTrigger(arg_10_1, arg_10_2)
	end

	return
end

function RectCollider:getCollisionInfo()
	return self._collisionInfo
end

function RectCollider:getScript(arg_12_1)
	return self.scriptList[arg_12_1.__cname] or nil
end

return RectCollider
