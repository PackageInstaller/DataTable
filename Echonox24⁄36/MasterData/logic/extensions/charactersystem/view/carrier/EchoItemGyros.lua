-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/carrier/EchoItemGyros.lua

module("logic.extensions.charactersystem.view.carrier.EchoItemGyros", package.seeall)

local M = class("EchoItemGyros")
local Input = Astral.ToLuaFramework.AsInputSystem.InputSystemToLua
local Shader = UnityEngine.Shader
local VLerp = UnityEngine.Vector3.Lerp
local QLerp = Quaternion.Lerp
local textureRotateLeft = 135
local textureRotateRight = 315
local angleMax = 15
local changeRate = 2.5
local filterRate = 0.03
local gyroCamDuration = 0.4
local ease = DG.Tweening.Ease.OutQuad

M.activeNodeShowFactor = 0.2
M.activeStepTime = 5

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._frameTime = 0.02
	self._isSupport = UnityEngine.SystemInfo.supportsGyroscope
	self._matSetter = false
	self._matReflect = false
	self._cameras = {}
	self._lastValue = 0
	self._isLerping = false
	self._closeGyros = true
	self._openRotation = true
	self._maskTransition = false
	self._isVertical = false
	self._isSimulate = false
	self._simulatePos = Vector3.New(0, 0, 0)
end

function M:startFrameTimer(start)
	if start then
		settimer(self._frameTime, self.onFrame, self, true)
	else
		removetimer(self.onFrame, self)
	end
end

function M:clear()
	self._matSetter = false
	self._matReflect = false
	self._cameras = {}
	self._lastValue = 0
	self._isLerping = false
	self._closeGyros = true
	self._openRotation = true
	self._activationNode = nil
	self._activeNodeState = nil
	self._lastActiveNodeTime = 0

	self:startFrameTimer(false)
	self:setEvent(false)
end

function M:closeGyros()
	self._closeGyros = true
end

function M:setIsVertical(isVertical)
	self._isVertical = isVertical
end

function M:getIsVertical()
	return self._isVertical
end

function M:openRotation(isOpen)
	self._openRotation = isOpen
end

function M:openGyros()
	self._closeGyros = false

	self:startFrameTimer(true)
	self:setEvent(true)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.GYRO_PERFORM_DATA_GET, self._handleGyroPerformDataGet, self)
		GlobalDispatcher:addEventListener(EventType.GYRO_PERFORM_DATA_SET, self._handleGyroPerformDataSet, self)
		GlobalDispatcher:addEventListener(EventType.GYRO_PERFORM_SIMULATE, self._handleGyroPerformSimulate, self)
		GlobalDispatcher:addEventListener(EventType.GYRO_PERFORM_ECHO_TEXTURE_SIM, self._handleGyroPerformEchoTextureSimulate, self)
	else
		GlobalDispatcher:removeEventListener(EventType.GYRO_PERFORM_DATA_GET, self._handleGyroPerformDataGet, self)
		GlobalDispatcher:removeEventListener(EventType.GYRO_PERFORM_DATA_SET, self._handleGyroPerformDataSet, self)
		GlobalDispatcher:removeEventListener(EventType.GYRO_PERFORM_SIMULATE, self._handleGyroPerformSimulate, self)
		GlobalDispatcher:removeEventListener(EventType.GYRO_PERFORM_ECHO_TEXTURE_SIM, self._handleGyroPerformEchoTextureSimulate, self)
	end
end

function M:_handleGyroPerformDataGet(e, gyroEventId, callBackFunc, callBackHandler)
	if gyroEventId ~= MainPerformEnum.GyrosEventTyp.Echo then
		return
	end

	if callBackFunc then
		if not self._cacheGyroCfgData then
			self._cacheGyroCfgData = {}
		end

		self._cacheGyroCfgData.angleMaxX = 0
		self._cacheGyroCfgData.angleMaxY = angleMax
		self._cacheGyroCfgData.filterX = 0
		self._cacheGyroCfgData.filterY = filterRate
		self._cacheGyroCfgData.durationGetDevice = self._frameTime
		self._cacheGyroCfgData.durationTween = gyroCamDuration
		self._cacheGyroCfgData.changeRate = changeRate
		self._cacheGyroCfgData.echoTextureRotateLeft = textureRotateLeft
		self._cacheGyroCfgData.echoTextureRotateRight = textureRotateRight

		callBackFunc(callBackHandler, self._cacheGyroCfgData)
	end
end

function M:_handleGyroPerformDataSet(e, gyroEventId, dataTable)
	if gyroEventId ~= MainPerformEnum.GyrosEventTyp.Echo then
		return
	end

	if not dataTable then
		return
	end

	if dataTable.angleMaxY then
		angleMax = dataTable.angleMaxY
	end

	if dataTable.filterY then
		filterRate = dataTable.filterY
	end

	if dataTable.durationGetDevice then
		local frameTime = dataTable.durationGetDevice

		frameTime = frameTime or 0
		frameTime = tonumber(frameTime)

		if frameTime < 0 then
			frameTime = 0
		end

		if self._frameTime ~= frameTime then
			self:startFrameTimer(false)

			self._frameTime = frameTime

			self:startFrameTimer(true)
		end
	end

	if dataTable.durationTween then
		gyroCamDuration = dataTable.durationTween
	end

	if dataTable.changeRate then
		local val = tonumber(dataTable.changeRate)

		if val <= 0 then
			val = 0.1
		end

		changeRate = val
	end

	if dataTable.echoTextureRotateLeft then
		textureRotateLeft = dataTable.echoTextureRotateLeft
	end

	if dataTable.echoTextureRotateRight then
		textureRotateRight = dataTable.echoTextureRotateRight
	end
end

function M:_handleGyroPerformSimulate(e, gyroEventId, simulateActive, x, y, z)
	if gyroEventId ~= MainPerformEnum.GyrosEventTyp.Echo then
		return
	end

	if simulateActive then
		self._isSimulate = true

		self._simulatePos:Set(x, y, z)
	else
		self:stopSimulate()
	end
end

function M:_handleGyroPerformEchoTextureSimulate(e, gyroEventId, factor)
	if gyroEventId ~= MainPerformEnum.GyrosEventTyp.Echo then
		return
	end

	for _, matSetter in pairs(self._matSetter or {}) do
		local value = self._maskTransition and 0 or math.abs(factor)

		matSetter:SetFloat("_BlendFactor", value)
	end
end

function M:onFrame()
	if not self._isSupport and not self._isSimulate then
		return
	end

	self:changeEchoItemShader()
end

function M:getMobilePos()
	if self._isSimulate then
		return self._simulatePos
	end

	local curMobilePos = Input.acceleration

	if Astral.OSDef.RunOS == Astral.OSDef.Android or Astral.OSDef.RunOS == Astral.OSDef.IOS then
		-- block empty
	else
		curMobilePos.x = math.random(-5, 5) / 10
		curMobilePos.y = math.random(-5, 5) / 10
		curMobilePos.z = math.random(-5, 5) / 10
	end

	if DeviceUtil.isEmulator() then
		curMobilePos.x = 0
		curMobilePos.y = 0
		curMobilePos.z = 0
	end

	return curMobilePos
end

function M:setEchoItemMatSetter(matSetter)
	if matSetter == nil or matSetter == false then
		self._matSetter = nil

		return
	end

	if not self._matSetter then
		self._matSetter = {}
	end

	table.insert(self._matSetter, matSetter)
end

function M:setEchoItemEffectCam(camera)
	table.insert(self._cameras, camera)
end

function M:setEchoMatReflect(matSetter)
	if matSetter == nil or matSetter == false then
		self._matReflect = nil

		return
	end

	if not self._matReflect then
		self._matReflect = {}
	end

	table.insert(self._matReflect, matSetter)
end

function M:changeEchoItemShader()
	if not self._matSetter or not self._matReflect or #self._cameras == 0 or self._closeGyros then
		return
	end

	local mobilePos = self:getMobilePos()
	local value = self:getIsVertical() and mobilePos.y * changeRate or mobilePos.x * changeRate

	value = math.floor(value * 10000) / 10000

	if math.abs(value - self._lastValue) < filterRate then
		return
	end

	self._isLerping = true
	self._lerpTweener = TweenNumberUtils.FloatTo(self._lastValue, value, gyroCamDuration, self._lerpUpdate, self):SetEase(ease):SetAutoKill(true):OnComplete(self._lerpFinish, self)
end

function M:_lerpUpdate(updateValue)
	for _, matReflect in pairs(self._matReflect or {}) do
		matReflect:SetFloat("_Factor", updateValue)
	end

	local angle = -updateValue * (angleMax / changeRate)

	for i = 1, #self._cameras do
		if self._openRotation then
			Astral.TransformUtil.SetLocalRotation(self._cameras[i].transform, 0, angle, 0)
		end
	end

	local matVal = updateValue

	if matVal > 1 then
		matVal = 1
	end

	if matVal < -1 then
		matVal = -1
	end

	if math.abs(angle) >= 0.5 then
		for _, matSetter in pairs(self._matSetter or {}) do
			local value = self._maskTransition and 0 or math.abs(matVal)

			value = matVal < 0 and 0 or value

			matSetter:SetFloat("_BlendFactor", value)
		end

		local rotate = updateValue > 0 and textureRotateRight or textureRotateLeft

		if not self._lastRotateSet or self._lastRotateSet ~= rotate then
			self._lastRotateSet = rotate

			for _, matSetter in pairs(self._matSetter or {}) do
				matSetter:SetFloat("_BaseMap02_Rotation", rotate)
			end
		end
	else
		for _, matSetter in pairs(self._matSetter or {}) do
			matSetter:SetFloat("_BlendFactor", 0)
		end
	end

	self._lastValue = updateValue

	self:_dealActiveNode(matVal)
end

function M:_lerpFinish()
	if self._lerpTweener then
		self._lerpTweener:Kill(false)

		self._lerpTweener = nil
	end

	self._isLerping = false
	self._lastRotateSet = nil
end

function M:_dealActiveNode(curValue)
	if math.abs(curValue) >= M.activeNodeShowFactor then
		if not self._activeNodeState then
			self:_setActiveNodeVisible(true)

			self._lastActiveNodeTime = os.clock()
		end
	elseif os.clock() - self._lastActiveNodeTime >= M.activeStepTime then
		self:_setActiveNodeVisible(false)
	end
end

function M:_setActiveNodeVisible(visible)
	local activationNode = self:getActivationNode()

	if activationNode then
		goutil.setActive(activationNode, visible)
	end

	self._activeNodeState = visible
end

function M:setActivationNode(activationNode)
	self._activationNode = activationNode
	self._lastActiveNodeTime = 0

	if self._activationNode then
		local _, _, time = string.find(self._activationNode.name, "(%d+)")

		if not string.nilorempty(time) then
			M.activeStepTime = tonumber(time)
		end
	end

	self:_setActiveNodeVisible(false)
end

function M:getActivationNode()
	return self._activationNode
end

function M:maskTransition(value)
	self._maskTransition = value
end

function M:startSimulate(param)
	self._isSimulate = param.isSimulate
	self._simulatePos = param.simulatePos
end

function M:setIsSimulate(value)
	self._isSimulate = value
end

function M:stopSimulate()
	self._isSimulate = false
	self._simulatePos.x = 0
	self._simulatePos.y = 0
	self._simulatePos.z = 0
end

return M
