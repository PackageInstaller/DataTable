local ShaderTestMgr = require("app.view.module.debug.test.ShaderTestMgr")
local ShaderGlitchPop = class("ShaderGlitchPop", require("app.fairyGUI.debug.UI_ShaderGlitchPop"), function()
	return fgui.GComponent:create({
		resName = "ShaderGlitchPop",
		pkgName = "debug",
		pkgPath = "ui/debug/debug"
	})
end)

function ShaderGlitchPop:ctor(arg_2_1)
	self._rootNode = nil
	self._shaderNode = nil
	self._elapseTS = nil

	self:initShader()
end

function ShaderGlitchPop:onLoad()
	self:_initRegisterMSG()
	self:scheduleUpdate()
end

function ShaderGlitchPop:onUnload()
	self:unscheduleUpdate()
end

function ShaderGlitchPop:receiveCompEvent(arg_5_1, arg_5_2)
	if arg_5_1 == "UI_REBEL_" then
		-- block empty
	end
end

function ShaderGlitchPop:onScheduleUpdate(arg_6_1)
	return
end

function ShaderGlitchPop:initShader()
	self:_initShaderData()
	self:_initShaderUI()
end

function ShaderGlitchPop:_initShaderData()
	self:_buildShaderElem()
end

function ShaderGlitchPop:_initShaderUI()
	self.m_testBtn:addClickListener(handler(self, self._onStartTestClick))
end

function ShaderGlitchPop:_initRegisterMSG()
	return
end

function ShaderGlitchPop:_buildShaderElem()
	self:_buildBaseElem()
end

function ShaderGlitchPop:_onStartTestClick()
	if self._glitch then
		self._glitch:closeSelf()

		self._glitch = nil

		self.m_testTxt:setText("都无法防火分区FQ防火墙FQ")
	else
		local var_12_0 = self
		local var_12_1 = require("app.view.common.GlitchNode").new({
			self.m_loadImg:displayObject(),
			self.m_showBtn:displayObject(),
			self.m_testTxt:displayObject(),
			self.m_testImg:displayObject()
		})

		var_12_1:playGlitch({
			dur = 10,
			name = "SHADER_GLITCH_STRIPE",
			doneCall = function()
				var_12_0._glitch = nil
			end
		})

		self._glitch = var_12_1

		self.m_testTxt:setText("对方无法建立考完就放假放进去")
	end
end

function ShaderGlitchPop:_buildBaseElem()
	local var_14_0 = cc.AlphaNode:create()

	self.m_holdComp:addNode(var_14_0)

	self._rootNode = var_14_0

	local var_14_1 = cc.Sprite:create("bg/story/11.jpg")

	var_14_1:setPosition(0, 0)
	var_14_1:setContentSize(1200, 500)
	self._rootNode:addChild(var_14_1)

	local var_14_2 = cc.Label:createWithTTF("和气生财1", "font/SourceHanSansCN-Regular.otf", 40)

	var_14_2:setPosition(0, -150)
	var_14_2:setTextColor(cc.c3b(255, 255, 0))
	self._rootNode:addChild(var_14_2)

	self._shaderNode = var_14_0
end

function ShaderGlitchPop:_startShaderGlitch()
	self:_startShaderGlitchScan()
end

function ShaderGlitchPop:_updateShaderGlitch()
	self:_updateShaderGlitchScan()
end

function ShaderGlitchPop:_endShaderGlitch()
	self._shaderNode:setGLProgramState(self._oldProgramStage)

	self._elapseTS = nil
end

function ShaderGlitchPop:_startShaderGlitchStripe()
	self._oldProgramStage = self._shaderNode:getGLProgramState()

	self._shaderNode:setGLProgram((ShaderTestMgr:getShaderProgram("SHADER_GLITCH_STRIPE")))

	self._elapseTS = 0

	self:_endShaderGlitchStripe()

	local var_18_0 = cc.Texture2D:new()

	var_18_0:initWithSize(20, 20)

	self._refTex = var_18_0

	var_18_0:retain()

	local var_18_1 = self._shaderNode:getGLProgramState()

	var_18_1:setUniformFloat("u_intensity", 0.1)
	var_18_1:setUniformFloat("u_colorAdjust", 0.4)
end

function ShaderGlitchPop:_updateShaderGlitchStripe()
	if self._elapseTS > 0.1 then
		self._refTex:updateRandomData(0.89)

		self._elapseTS = 0
	end
end

function ShaderGlitchPop:_endShaderGlitchStripe()
	if self._refTex then
		self._refTex:release()

		self._refTex = nil
	end
end

function ShaderGlitchPop:_startShaderGlitchLine()
	self._oldProgramStage = self._shaderNode:getGLProgramState()

	self._shaderNode:setGLProgram((ShaderTestMgr:getShaderProgram("SHADER_GLITCH_LINE")))

	self._elapseTS = 0

	local var_21_0 = self._shaderNode:getGLProgramState()

	var_21_0:setUniformFloat("u_amount", 0.5)
	var_21_0:setUniformFloat("u_lineW", 1)
	var_21_0:setUniformFloat("u_offset", 1)
	var_21_0:setUniformFloat("u_alpha", 1)
end

function ShaderGlitchPop:_updateShaderGlitchLine()
	self._shaderNode:getGLProgramState():setUniformFloat("u_timeSec", self._elapseTS)
end

function ShaderGlitchPop:_startShaderGlitchBlock()
	self._oldProgramStage = self._shaderNode:getGLProgramState()

	self._shaderNode:setGLProgram((ShaderTestMgr:getShaderProgram("SHADER_GLITCH_BLOCK")))

	self._elapseTS = 0

	local var_23_0 = self._shaderNode:getGLProgramState()

	var_23_0:setUniformVec2("u_block1", cc.p(8, 5))
	var_23_0:setUniformVec2("u_block2", cc.p(4.9, 9.9))
	var_23_0:setUniformFloat("u_intensity1", 8)
	var_23_0:setUniformFloat("u_intensity2", 4)
end

function ShaderGlitchPop:_updateShaderGlitchBlock()
	self._shaderNode:getGLProgramState():setUniformFloat("u_timeSec", math.floor(self._elapseTS * 10))
end

function ShaderGlitchPop:_startShaderGlitchJump()
	self._oldProgramStage = self._shaderNode:getGLProgramState()

	self._shaderNode:setGLProgram((ShaderTestMgr:getShaderProgram("SHADER_GLITCH_JUMP")))

	self._elapseTS = 0
	self.__tmpAmount = 0.31

	self._shaderNode:getGLProgramState():setUniformFloat("u_amount", self.__tmpAmount)
end

function ShaderGlitchPop:_updateShaderGlitchJump()
	self._shaderNode:getGLProgramState():setUniformFloat("u_timeSec", self._elapseTS * 9.8 * self.__tmpAmount)
end

function ShaderGlitchPop:_startShaderGlitchWave()
	self._oldProgramStage = self._shaderNode:getGLProgramState()

	self._shaderNode:setGLProgram((ShaderTestMgr:getShaderProgram("SHADER_GLITCH_WAVE")))

	self._elapseTS = 0

	local var_27_0 = self._shaderNode:getGLProgramState()

	var_27_0:setUniformVec2("u_resolution", cc.p(1200, 500))
	var_27_0:setUniformFloat("u_rgbSplit", 200)
end

function ShaderGlitchPop:_updateShaderGlitchWave()
	local var_28_0 = self._shaderNode:getGLProgramState()

	var_28_0:setUniformFloat("u_timeSec", self._elapseTS)
	var_28_0:setUniformFloat("u_amount", 5 * (0.5 + 0.5 * math.cos(self._elapseTS)))
	var_28_0:setUniformFloat("u_timeSec", self._elapseTS * 20)
end

function ShaderGlitchPop:_startShaderGlitchScan()
	self._oldProgramStage = self._shaderNode:getGLProgramState()

	self._shaderNode:setGLProgram((ShaderTestMgr:getShaderProgram("SHADER_GLITCH_SCAN")))

	self._elapseTS = 0
end

function ShaderGlitchPop:_updateShaderGlitchScan()
	local var_30_9000
	local var_30_0 = self._shaderNode:getGLProgramState()

	var_30_0:setUniformFloat("u_timeSec", self._elapseTS)

	local var_30_1 = var_30_9000 * (0.5 + 0.5 * math.cos(self._elapseTS))

	var_30_0:setUniformFloat("u_amount", 0.005 + 0.1 * var_30_1 * 0.8 * var_30_1)
	var_30_0:setUniformFloat("u_threshold", (math.clamp(1 - var_30_1 * 1.2, 0, 1)))
end

function ShaderGlitchPop:_startShaderGlitchSplit()
	self._oldProgramStage = self._shaderNode:getGLProgramState()

	self._shaderNode:setGLProgram((ShaderTestMgr:getShaderProgram("SHADER_GLITCH_SPLIT")))

	self._elapseTS = 0
end

function ShaderGlitchPop:_updateShaderGlitchSplit()
	self._shaderNode:getGLProgramState():setUniformFloat("u_timeSec", math.floor(self._elapseTS * 100))
end

return ShaderGlitchPop
