local var_0_0 = fgui.GLoader.setURLBase

function fgui.GLoader:setURL(arg_1_1, arg_1_2)
	local var_1_0, var_1_1 = g.core.utils.Tools.getPngTextureFormat(arg_1_1)

	if var_1_0 then
		cc.Texture2D:setDefaultAlphaPixelFormat(var_1_1)
	end

	self:setLoadAsync(arg_1_2)
	var_0_0(self, arg_1_1)

	local var_1_2 = self:getComponent()

	if var_1_2 and var_1_2:getRemark() then
		fgui.UIPackage:bindLoaderUIComponent(var_1_2)
	end

	if var_1_0 then
		cc.Texture2D:setDefaultAlphaPixelFormat(cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888)
	end
end

function fgui.GLoader:setGloaderColor(arg_2_1, arg_2_2)
	local var_2_0 = cc.GLProgramState:create((g.core.shader.ShaderMgr:getShader(arg_2_1 and "SHADER_SET_COLOR" or "SHADER_UI_NORMAL")))

	if arg_2_1 then
		var_2_0:setUniformVec3("setColor", arg_2_2 or cc.vec3(0.2, 0.2, 0.2))
	end

	self:setOpenGlState(var_2_0)
end

function fgui.GLoader:setGloaderMask(arg_3_1, arg_3_2)
	local var_3_0 = cc.GLProgramState:create((g.core.shader.ShaderMgr:getShader(arg_3_1 and "SHADER_SET_MASK" or "SHADER_UI_NORMAL")))

	if arg_3_1 then
		var_3_0:setUniformFloat("maskFloat", arg_3_2 or 0.3)
	end

	self:setOpenGlState(var_3_0)
end
