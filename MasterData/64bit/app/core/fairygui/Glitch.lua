local Glitch = class("Glitch")
local var_0_1 = cc.Director:getInstance():getScheduler()
local var_0_2 = cc.FileUtils:getInstance()

Glitch.SHADER_GLITCH = "SHADER_GLITCH"

function Glitch:ctor(arg_1_1)
	self._node = arg_1_1.node
	self._lineJitter = arg_1_1.lineJitter or 0.25
	self._colorDrift = arg_1_1.colorDrift or 0.25
	self._jitterWidth = arg_1_1.jitterWidth or 2
	self._driftTime = arg_1_1.driftTime or 5
	self._jitterTime = arg_1_1.jitterTime or 10
	self._frames = math.max(arg_1_1.frames, 2 * (self._driftTime + self._jitterTime))
	self._cur = 0
	self._perJitter = self._lineJitter / self._jitterTime
	self._perDrift = self._colorDrift / self._driftTime

	self:initShader()
end

function Glitch:initShader()
	cc.GLProgramCache:getInstance():addGLProgram(cc.GLProgram:createWithFilenames(var_0_2:fullPathForFilename("shader/texture_color_noMVP.vsh"), var_0_2:fullPathForFilename("shader/glitch.fsh")), Glitch.SHADER_GLITCH)
end

function Glitch:start()
	if self._updateEntryID then
		return
	end

	local var_3_0 = cc.GLProgramState:create((cc.GLProgramCache:getInstance():getGLProgram(Glitch.SHADER_GLITCH)))

	self._state = var_3_0

	self._state:setUniformFloat("screenWidth", cc.Director:getInstance():getOpenGLView():getFrameSize().height)
	self._state:setUniformFloat("jitterWidth", self._jitterWidth)

	self._lastState = self._node:getGLProgramState()

	self._node:setGLProgramState(var_3_0)

	self._updateEntryID = var_0_1:scheduleScriptFunc(handler(self, self.update), 0, false)
end

function Glitch:update()
	if self._cur >= self._frames then
		if self._updateEntryID then
			var_0_1:unscheduleScriptEntry(self._updateEntryID)

			self._updateEntryID = nil

			if self._lastState then
				self._node:setGLProgramState(self._lastState)
			end
		end

		return
	end

	local var_4_0 = 0
	local var_4_1 = 0

	if self._cur < self._driftTime then
		var_4_0 = 0
		var_4_1 = self._perDrift * self._cur
	elseif self._cur < self._driftTime + self._jitterTime then
		var_4_0 = self._perJitter * (self._cur - self._driftTime)
		var_4_1 = self._colorDrift
	elseif self._cur < self._frames - self._driftTime - self._jitterTime then
		var_4_0 = self._lineJitter
		var_4_1 = self._colorDrift
	elseif self._cur < self._frames - self._driftTime then
		var_4_0 = self._perJitter * (self._frames - self._driftTime - self._cur)
		var_4_1 = self._colorDrift
	else
		var_4_0 = 0
		var_4_1 = self._perDrift * (self._frames - self._cur)
	end

	self._state:setUniformFloat("lineJitter", var_4_0)
	self._state:setUniformFloat("colorDrift", var_4_1)
	self._state:setUniformFloat("time", self._cur / self._frames)

	self._cur = self._cur + 1
end

return Glitch
