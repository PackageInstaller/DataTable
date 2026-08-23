local GlitchAction = class("GlitchAction")

function GlitchAction:ctor(arg_1_1)
	self._elapseTS = 0
	self._duration = -1
	self._frequency = 30
	self._stepAdvance = 0
	self._increase = 1
	self._u_timeSec = 0
	self._shaderTarget = nil
	self._oldProgramStage = nil

	self:_parseParam(arg_1_1)
end

function GlitchAction:_parseParam(arg_2_1)
	self._SHADER_NAME = arg_2_1.name
	self._duration = arg_2_1.dur or -1
	self._frequency = arg_2_1.freq or 30
	self._doneCall = arg_2_1.doneCall
end

function GlitchAction:startGlitchTarget(arg_3_1)
	self._elapseTS = 0
	self._stepAdvance = 0
	self._u_timeSec = 0
	self._shaderTarget = arg_3_1
	self._oldProgramStage = self._shaderTarget:getGLProgramState()

	self._shaderTarget:setGLProgram((g.core.shader.ShaderMgr:getShader(self._SHADER_NAME)))
	self:_onStartShaderGlitch()
	self._shaderTarget:scheduleUpdate(handler(self, self._tickUpdate))
end

function GlitchAction:stopGlitch()
	if self._shaderTarget == nil then
		return
	end

	self._shaderTarget:unscheduleUpdate()
	self:_onStopShaderGlitch()

	if self._oldProgramStage then
		self._shaderTarget:setGLProgramState(self._oldProgramStage)
	end

	self._shaderTarget = nil
	self._oldProgramStage = nil
end

function GlitchAction:_tickUpdate(arg_5_1)
	if self:_isFinished() then
		self:stopGlitch()

		if self._doneCall then
			self._doneCall()

			self._doneCall = nil
		end

		return
	end

	self._elapseTS = self._elapseTS + arg_5_1
	self._stepAdvance = self._duration > 0 and math.min(1, self._elapseTS / self._duration) or 1

	self:_onStep(arg_5_1)
	self:_onUpdateShaderGlitch()
end

function GlitchAction:_isFinished()
	return self._duration > 0 and self._elapseTS > self._duration
end

function GlitchAction:_onStep(arg_7_1)
	return
end

function GlitchAction:_onStartShaderGlitch()
	return
end

function GlitchAction:_onUpdateShaderGlitch()
	return
end

function GlitchAction:_onStopShaderGlitch()
	return
end

local GlitchStripe = class("GlitchStripe", GlitchAction)

function GlitchStripe:ctor(arg_11_1)
	GlitchStripe.super.ctor(self, arg_11_1)

	self._refTex = nil
end

function GlitchStripe:_parseParam(arg_12_1)
	GlitchStripe.super._parseParam(self, arg_12_1)

	self._u_width = arg_12_1.width or 20
	self._u_height = arg_12_1.height or 20
	self._u_intensity = arg_12_1.intensity or 0.1
	self._u_colorAdjust = arg_12_1.colorAdjust or 0.4
	self._stripeLen = arg_12_1.stripeLen or 0.89
	self._frequency = arg_12_1.freq or 10
end

function GlitchStripe:_onStep(arg_13_1)
	GlitchStripe.super._onStep(self, arg_13_1)
end

function GlitchStripe:_onStartShaderGlitch()
	self._refTex = cc.Texture2D:new()

	self._refTex:initWithSize(self._u_width, self._u_height)
	self._refTex:retain()

	local var_14_0 = self._shaderTarget:getGLProgramState()

	var_14_0:setUniformFloat("u_intensity", self._u_intensity)
	var_14_0:setUniformFloat("u_colorAdjust", self._u_colorAdjust)
end

function GlitchStripe:_onUpdateShaderGlitch()
	local var_15_0 = math.floor(self._elapseTS * self._frequency)

	if var_15_0 > self._u_timeSec then
		self._refTex:updateRandomData(self._stripeLen)

		self._u_timeSec = var_15_0
	end
end

function GlitchStripe:_onStopShaderGlitch()
	if self._refTex then
		self._refTex:release()
	end
end

local GlitchLine = class("GlitchLine", GlitchAction)

function GlitchLine:ctor(arg_17_1)
	GlitchLine.super.ctor(self, arg_17_1)
end

function GlitchLine:_parseParam(arg_18_1)
	GlitchLine.super._parseParam(self, arg_18_1)

	self._u_amount = arg_18_1.amount or 0.5
	self._u_lineW = arg_18_1.lineW or 1
	self._u_offset = arg_18_1.offset or 1
	self._u_alpha = arg_18_1.alpha or 1
end

function GlitchLine:_onStep(arg_19_1)
	GlitchLine.super._onStep(self, arg_19_1)

	self._u_timeSec = self._elapseTS
end

function GlitchLine:_onStartShaderGlitch()
	local var_20_0 = self._shaderTarget:getGLProgramState()

	var_20_0:setUniformFloat("u_amount", self._u_amount)
	var_20_0:setUniformFloat("u_lineW", self._u_lineW)
	var_20_0:setUniformFloat("u_offset", self._u_offset)
	var_20_0:setUniformFloat("u_alpha", self._u_alpha)
end

function GlitchLine:_onUpdateShaderGlitch()
	self._shaderTarget:getGLProgramState():setUniformFloat("u_timeSec", self._u_timeSec)
end

local GlitchBlock = class("GlitchBlock", GlitchAction)

function GlitchBlock:ctor(arg_22_1)
	GlitchBlock.super.ctor(self, arg_22_1)
end

function GlitchBlock:_parseParam(arg_23_1)
	GlitchBlock.super._parseParam(self, arg_23_1)

	self._u_block1_x = arg_23_1.block1_x or 8
	self._u_block1_y = arg_23_1.block1_y or 5
	self._u_block2_x = arg_23_1.block2_x or 4
	self._u_block2_y = arg_23_1.block2_y or 10
	self._u_intensity1 = arg_23_1.intensity1 or 8
	self._u_intensity2 = arg_23_1.intensity2 or 4
end

function GlitchBlock:_onStep(arg_24_1)
	GlitchBlock.super._onStep(self, arg_24_1)

	self._u_timeSec = math.floor(self._elapseTS * self._frequency)
end

function GlitchBlock:_onStartShaderGlitch()
	local var_25_0 = self._shaderTarget:getGLProgramState()

	var_25_0:setUniformVec2("u_block1", cc.p(self._u_block1_x, self._u_block1_y))
	var_25_0:setUniformVec2("u_block2", cc.p(self._u_block2_x, self._u_block2_y))
	var_25_0:setUniformFloat("u_intensity1", self._u_intensity1)
	var_25_0:setUniformFloat("u_intensity2", self._u_intensity2)
end

function GlitchBlock:_onUpdateShaderGlitch()
	self._shaderTarget:getGLProgramState():setUniformFloat("u_timeSec", self._u_timeSec)
end

local GlitchJump = class("GlitchJump", GlitchAction)

function GlitchJump:ctor(arg_27_1)
	GlitchJump.super.ctor(self, arg_27_1)
end

function GlitchJump:_parseParam(arg_28_1)
	GlitchJump.super._parseParam(self, arg_28_1)

	self._u_amount = arg_28_1.amount or 0.31
end

function GlitchJump:_onStep(arg_29_1)
	GlitchJump.super._onStep(self, arg_29_1)

	self._u_timeSec = self._elapseTS * 0.098 * self._frequency
end

function GlitchJump:_onStartShaderGlitch()
	self._shaderTarget:getGLProgramState():setUniformFloat("u_amount", self._u_amount)
end

function GlitchJump:_onUpdateShaderGlitch()
	self._shaderTarget:getGLProgramState():setUniformFloat("u_timeSec", self._u_timeSec)
end

local GlitchWave = class("GlitchWave", GlitchAction)

function GlitchWave:ctor(arg_32_1)
	GlitchWave.super.ctor(self, arg_32_1)

	self._u_amount = 0
end

function GlitchWave:_parseParam(arg_33_1)
	GlitchWave.super._parseParam(self, arg_33_1)

	self._intensity = arg_33_1.intensity or 5
	self._u_resolutionW = arg_33_1.resolutionW or 1200
	self._u_resolutionH = arg_33_1.resolutionH or 500
	self._u_rgbSplit = arg_33_1.rgbSplit or 200
end

function GlitchWave:_onStep(arg_34_1)
	GlitchWave.super._onStep(self, arg_34_1)

	self._u_timeSec = self._elapseTS * 20
	self._u_amount = self._intensity * self._increase
end

function GlitchWave:_onStartShaderGlitch()
	local var_35_0 = self._shaderTarget:getGLProgramState()

	var_35_0:setUniformVec2("u_resolution", cc.p(self._u_resolutionW, self._u_resolutionH))
	var_35_0:setUniformFloat("u_rgbSplit", self._u_rgbSplit)
end

function GlitchWave:_onUpdateShaderGlitch()
	local var_36_0 = self._shaderTarget:getGLProgramState()

	var_36_0:setUniformFloat("u_amount", self._u_amount)
	var_36_0:setUniformFloat("u_timeSec", self._u_timeSec)
end

local GlitchScan = class("GlitchScan", GlitchAction)

function GlitchScan:ctor(arg_37_1)
	GlitchScan.super.ctor(self, arg_37_1)

	self._u_amount = 0
	self._u_threshold = 0
end

function GlitchScan:_parseParam(arg_38_1)
	GlitchScan.super._parseParam(self, arg_38_1)

	self._intensity = arg_38_1.intensity or 0.4
end

function GlitchScan:_onStep(arg_39_1)
	GlitchScan.super._onStep(self, arg_39_1)

	self._u_timeSec = self._elapseTS
	self._u_amount = 0.005 + 0.1 * (self._intensity * self._increase) * (self._intensity * self._increase) * (self._intensity * self._increase)
	self._u_threshold = math.clamp(1 - self._intensity * self._increase * 1.2, 0, 1)
end

function GlitchScan:_onStartShaderGlitch()
	return
end

function GlitchScan:_onUpdateShaderGlitch()
	local var_41_0 = self._shaderTarget:getGLProgramState()

	var_41_0:setUniformFloat("u_timeSec", self._u_timeSec)
	var_41_0:setUniformFloat("u_amount", self._u_amount)
	var_41_0:setUniformFloat("u_threshold", self._u_threshold)
end

local GlitchSplit = class("GlitchSplit", GlitchAction)

function GlitchSplit:_parseParam(arg_42_1)
	GlitchSplit.super._parseParam(self, arg_42_1)

	self._u_colorOffR = arg_42_1.colorOffR or 0
	self._u_colorOffG = arg_42_1.colorOffG or 1
	self._u_colorOffB = arg_42_1.colorOffB or 0
	self._u_intensityX = arg_42_1.intensityX or 0.1
	self._u_intensityY = arg_42_1.intensityY or 0
	self._u_intensity = cc.p(0, 0)
end

function GlitchSplit:_onStep(arg_43_1)
	GlitchSplit.super._onStep(self, arg_43_1)

	self._u_timeSec = self._elapseTS
	self._u_intensity.x = self._u_intensityX * self._increase
	self._u_intensity.y = self._u_intensityY * self._increase
end

function GlitchSplit:_onStartShaderGlitch()
	self._shaderTarget:getGLProgramState():setUniformVec3("u_colorOff", cc.vec3(self._u_colorOffR, self._u_colorOffG, self._u_colorOffB))
end

function GlitchSplit:_onUpdateShaderGlitch()
	local var_45_0 = self._shaderTarget:getGLProgramState()

	var_45_0:setUniformVec2("u_intensity", self._u_intensity)
	var_45_0:setUniformFloat("u_timeSec", self._u_timeSec)
end

local var_0_8 = {
	SHADER_GLITCH_SPLIT = GlitchSplit,
	SHADER_GLITCH_SCAN = GlitchScan,
	SHADER_GLITCH_WAVE = GlitchWave,
	SHADER_GLITCH_JUMP = GlitchJump,
	SHADER_GLITCH_BLOCK = GlitchBlock,
	SHADER_GLITCH_LINE = GlitchLine,
	SHADER_GLITCH_STRIPE = GlitchStripe
}

function GlitchAction:create()
	if var_0_8[self.name] then
		return var_0_8[self.name].new(self)
	end

	return nil
end

return GlitchAction
