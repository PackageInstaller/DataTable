local ShaderMgr = class("ShaderMgr")
local var_0_1 = cc.FileUtils:getInstance()

ShaderMgr.SHADER_SHADOW_OUTLINE = "SHADER_SHADOW_OUTLINE"
ShaderMgr.SHADER_SHADOW_GLOW = "SHADER_SHADOW_GLOW"
ShaderMgr.SHADER_UI_GRAY = "SHADER_UI_GRAY"
ShaderMgr.SHADER_UI_NORMAL = "SHADER_UI_NORMAL"
ShaderMgr.SHADER_GAUSSIAN_BLUR = "SHADER_GAUSSIAN_BLUR"
ShaderMgr.SHADER_ADD_COLOR = "SHADER_ADD_COLOR"
ShaderMgr.SHADER_MUL_COLOR = "SHADER_MUL_COLOR"
ShaderMgr.SHADER_SET_COLOR = "SHADER_SET_COLOR"
ShaderMgr.SHADER_SET_MASK = "SHADER_SET_MASK"
ShaderMgr.SHADER_LABEL_ADD_IMG = "SHADER_LABEL_ADD_IMG"

function ShaderMgr:ctor()
	self._shaders = {}
	self._shaders[ShaderMgr.SHADER_SHADOW_OUTLINE] = {
		"shader/texture_color_noMVP.vsh",
		"shader/shadow.fsh",
		handler(self, self._shadowCallback)
	}
	self._shaders[ShaderMgr.SHADER_SHADOW_GLOW] = {
		"shader/texture_color_noMVP.vsh",
		"shader/glow.fsh",
		handler(self, self._shadowGlowCallback)
	}
	self._shaders[ShaderMgr.SHADER_UI_GRAY] = {
		"shader/texture_color_noMVP.vsh",
		"shader/gray.fsh"
	}
	self._shaders[ShaderMgr.SHADER_UI_NORMAL] = {
		"shader/texture_color_noMVP.vsh",
		"shader/normal.fsh"
	}
	self._shaders[ShaderMgr.SHADER_GAUSSIAN_BLUR] = {
		"shader/texture_color_noMVP.vsh",
		"shader/blur.fsh"
	}
	self._shaders[ShaderMgr.SHADER_ADD_COLOR] = {
		"shader/texture_color_noMVP.vsh",
		"shader/addColor.fsh"
	}
	self._shaders[ShaderMgr.SHADER_MUL_COLOR] = {
		"shader/texture_color_noMVP.vsh",
		"shader/mulColor.fsh"
	}
	self._shaders[ShaderMgr.SHADER_SET_COLOR] = {
		"shader/texture_color_noMVP.vsh",
		"shader/setColor.fsh"
	}
	self._shaders[ShaderMgr.SHADER_SET_MASK] = {
		"shader/texture_color_noMVP.vsh",
		"shader/setMaskAlpha.fsh"
	}
	self._shaders.SHADER_GLITCH_SPLIT = {
		"shader/texture_color_noMVP.vsh",
		"shader/glitch_split.fsh"
	}
	self._shaders.SHADER_GLITCH_SCAN = {
		"shader/texture_color_noMVP.vsh",
		"shader/glitch_scan.fsh"
	}
	self._shaders.SHADER_GLITCH_WAVE = {
		"shader/texture_color_noMVP.vsh",
		"shader/glitch_wave.fsh"
	}
	self._shaders.SHADER_GLITCH_JUMP = {
		"shader/texture_color_noMVP.vsh",
		"shader/glitch_jump.fsh"
	}
	self._shaders.SHADER_GLITCH_BLOCK = {
		"shader/texture_color_noMVP.vsh",
		"shader/glitch_block.fsh"
	}
	self._shaders.SHADER_GLITCH_LINE = {
		"shader/texture_color_noMVP.vsh",
		"shader/glitch_line.fsh"
	}
	self._shaders.SHADER_GLITCH_STRIPE = {
		"shader/texture_color_noMVP.vsh",
		"shader/glitch_stripe.fsh"
	}
	self._shaders[ShaderMgr.SHADER_LABEL_ADD_IMG] = {
		"shader/label_add_img.vsh",
		"shader/label_add_img.fsh"
	}
	self._cacheShaderNames = {}

	cc.Director:getInstance():getEventDispatcher():addEventListenerWithFixedPriority(cc.EventListenerCustom:create("GLPROGRAM_CACHE_RELOAD_DEFAULT", function()
		print("GLPROGRAM_CACHE_RELOAD_DEFAULT")
		self:reloadShaders()
	end), 1)
end

function ShaderMgr:_loadShader(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = cc.GLProgram:createWithFilenames(var_0_1:fullPathForFilename(arg_3_1), var_0_1:fullPathForFilename(arg_3_2))

	if arg_3_3 ~= nil then
		cc.GLProgramCache:getInstance():addGLProgram(var_3_0, arg_3_3)

		self._cacheShaderNames[arg_3_3] = {
			arg_3_1,
			arg_3_2
		}
	end

	return var_3_0
end

function ShaderMgr:loadShaders()
	for iter_4_0, iter_4_1 in pairs(self._shaders) do
		if iter_4_1[3] then
			iter_4_1[3](self:_loadShader(iter_4_1[1], iter_4_1[2], iter_4_0), iter_4_0)
		end
	end
end

function ShaderMgr:reloadShaders()
	for iter_5_0 in pairs(self._cacheShaderNames) do
		local var_5_0 = cc.GLProgramCache:getInstance():getGLProgram(iter_5_0)

		if var_5_0 then
			var_5_0:reset()

			if self._shaders[iter_5_0] then
				var_5_0:initWithFilenames(self._shaders[iter_5_0][1], self._shaders[iter_5_0][2])

				if self._shaders[iter_5_0][3] then
					self._shaders[iter_5_0][3](var_5_0, iter_5_0)
				end
			end
		end
	end
end

function ShaderMgr:_shadowCallback(arg_6_1, arg_6_2)
	local var_6_0 = cc.Director:getInstance():getWinSize()
	local var_6_1 = cc.GLProgramState:getOrCreateWithGLProgramName(arg_6_2)

	var_6_1:setUniformFloat("dir_x", 1 / var_6_0.width)
	var_6_1:setUniformFloat("dir_y", 1 / var_6_0.height)
	var_6_1:setUniformFloat("strength", 3)
	var_6_1:setUniformVec3("shadow_color", cc.vec3(0.9, 0.87, 0.52))
	var_6_1:setUniformInt("range", 12)
end

function ShaderMgr:_shadowGlowCallback(arg_7_1, arg_7_2)
	local var_7_0 = cc.Director:getInstance():getWinSize()
	local var_7_1 = cc.GLProgramState:getOrCreateWithGLProgramName(arg_7_2)

	var_7_1:setUniformFloat("dir_x", 1 / var_7_0.width)
	var_7_1:setUniformFloat("dir_y", 1 / var_7_0.height)
	var_7_1:setUniformVec3("shadow_color", cc.vec3(0.9, 0.87, 0.52))
	var_7_1:setUniformInt("range", 12)
end

function ShaderMgr:getShadowShader()
	return cc.GLProgramCache:getInstance():getGLProgram(ShaderMgr.SHADER_SHADOW_OUTLINE)
end

function ShaderMgr:getGlowShader()
	return cc.GLProgramCache:getInstance():getGLProgram(ShaderMgr.SHADER_SHADOW_GLOW)
end

function ShaderMgr:getShader(arg_10_1)
	return cc.GLProgramCache:getInstance():getGLProgram(arg_10_1)
end

return ShaderMgr
