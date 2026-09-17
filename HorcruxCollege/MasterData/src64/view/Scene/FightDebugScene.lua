local FightDebugScene = class("FightDebugScene", function()
	return cc.Scene:create()
end)

function FightDebugScene:create()
	local var_2_0 = FightDebugScene.new()

	var_2_0:init()

	return var_2_0
end

function FightDebugScene:init()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "FightLayer.json" or "FightLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.panelMap = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_map")
	self.panelLevel = self.panelMap:getChildByName("panelLevel")
	self.panelBoss = self.panelMap:getChildByName("panelBoss")
	self.panelConsole = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_console")

	self.panelMap:setVisible(true)
	self.panelLevel:setVisible(false)
	self.panelBoss:setVisible(true)
	self.panelConsole:setVisible(false)
	self:initMapBG()
	self:initBossPanel()
	self:initDebugPanel()
end

function FightDebugScene:initMapBG()
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("fighteffect/anim_fight&clear&boss.ExportJson")

	self.mapBg = ccs.Armature:create("anim_fight&clear&boss")

	self.mapBg:setPosition(cc.p(320, 568))
	self.panelMap:addChild(self.mapBg, 1)
end

local function var_0_1(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:getAnimation():play(arg_5_1)
	arg_5_0:getAnimation():gotoAndPause(arg_5_2)
	arg_5_0:getAnimation():stop()
end

function FightDebugScene:initBossPanel()
	self._chapterboss = cc.ClippingNode:create()

	self._chapterboss:setInverted(false)
	self._chapterboss:setStencil((cc.Sprite:createWithSpriteFrameName("anim_find_boss_effect4_5.png")))
	self._chapterboss:setAlphaThreshold(0.5)

	local var_6_0 = cc.Sprite:create("role1/35102.png")

	var_6_0:setPosition(cc.p(-50, -100))
	var_6_0:setName("boss")
	var_6_0:setOpacity(178.5)
	self._chapterboss:addChild(var_6_0)
	self._chapterboss:setPosition(cc.p(350, 294))
	self.panelBoss:addChild(self._chapterboss, 1)
	var_0_1(self.mapBg, "anim_bosslayer", 180)
end

local function var_0_2(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6, arg_7_7, arg_7_8)
	local var_7_0 = cc.EditBox:create(arg_7_7, (config._DEBUG or nil) and (cc.Scale9Sprite:create("public/panelbg/editBoxBG.png") or cc.Scale9Sprite:createWithSpriteFrameName("public/panelbg/editBoxBG.png")))

	var_7_0:setName(arg_7_0)
	var_7_0:setPosition(arg_7_8)
	var_7_0:setAnchorPoint(cc.p(0, 0.5))
	var_7_0:setFontName(arg_7_3)
	var_7_0:setPlaceholderFont(arg_7_3, arg_7_2)
	var_7_0:setFontSize(arg_7_2)
	var_7_0:setFontColor(cc.c3b(255, 255, 255))
	var_7_0:setPlaceHolder(arg_7_4)
	var_7_0:setPlaceholderFontColor(cc.c3b(255, 255, 255))
	var_7_0:setMaxLength(arg_7_5)
	var_7_0:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
	var_7_0:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
	var_7_0:setInputFlag(arg_7_6)
	arg_7_1:addChild(var_7_0, 100)

	return var_7_0
end

local model_data = require("data.model_data")

function FightDebugScene:initDebugPanel()
	self.modelid = 60200
	self.posx = -100
	self.posy = -300
	self.scale = -1

	self:resetBoss()

	local var_8_0 = ccs.GUIReader:getInstance():widgetFromJsonFile("MainLayerDebug.json")

	var_8_0:setPosition(cc.p(0, 400))
	self:addChild(var_8_0, 10)

	local var_8_1 = var_0_2("input", var_8_0:getChildByName("Panel_1"), 30, "fonts/newkj.ttf", initmodelid, 22, cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_WORD, cc.size(100, 70), cc.p(80, 150))
	local var_8_2 = var_8_0:getChildByName("Panel_1")
	local var_8_3 = var_8_0:getChildByName("Panel_21")

	var_8_3:setVisible(true)
	var_8_2:getChildByName("choose"):addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_9_0 = checkint(var_8_1:getText())

		if not model_data[var_9_0] then
			require("controller.global_func")
			global_ShowBlockWords("modelid error")
		end

		self.modelid = var_9_0

		self:resetBoss()
	end)
	var_8_2:getChildByName("up"):addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 == ccui.TouchEventType.began then
			self:startMove("posy", 1)
		elseif arg_10_1 == ccui.TouchEventType.ended then
			self:endMove()

			self.posy = self.posy + 1

			self:updateBossPos()
		end
	end)
	var_8_2:getChildByName("down"):addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 == ccui.TouchEventType.began then
			self:startMove("posy", -1)
		elseif arg_11_1 == ccui.TouchEventType.ended then
			self:endMove()

			self.posy = self.posy - 1

			self:updateBossPos()
		end
	end)
	var_8_2:getChildByName("left"):addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 == ccui.TouchEventType.began then
			self:startMove("posx", -1)
		elseif arg_12_1 == ccui.TouchEventType.ended then
			self:endMove()

			self.posx = self.posx - 1

			self:updateBossPos()
		end
	end)
	var_8_2:getChildByName("right"):addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 == ccui.TouchEventType.began then
			self:startMove("posx", 1)
		elseif arg_13_1 == ccui.TouchEventType.ended then
			self:endMove()

			self.posx = self.posx + 1

			self:updateBossPos()
		end
	end)
	var_8_2:getChildByName("output"):addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.modelid then
			return
		end

		self:outputBossPos()
	end)
	var_8_3:getChildByName("left"):addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.scale = -1 * self.scale

		self:updateBossPos()
	end)
	var_8_3:getChildByName("mid"):addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.scale = -1 * self.scale

		self:updateBossPos()
	end)
	var_8_3:getChildByName("right"):addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.scale = -1 * self.scale

		self:updateBossPos()
	end)
end

function FightDebugScene:startMove(arg_18_1, arg_18_2)
	self.startscheduler = self.startscheduler or cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_19_0)
		self[arg_18_1] = self[arg_18_1] + arg_18_2

		self:updateBossPos()
	end, 0.1, false)
end

function FightDebugScene:endMove()
	if self.startscheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.startscheduler)

		self.startscheduler = nil
	end
end

function FightDebugScene:updateBossPos()
	self._chapterboss:getChildByName("boss"):setScaleX(self.scale)
	self._chapterboss:getChildByName("boss"):setPosition(cc.p(self.posx, self.posy))
end

function FightDebugScene:resetBoss()
	self._chapterboss:getChildByName("boss"):setTexture("role/" .. model_data[self.modelid].role_image .. ".png")

	self.posx = -100
	self.posy = -300
	self.scale = -1

	self:updateBossPos()
end

function FightDebugScene:outputBossPos()
	local var_23_0 = io.open("./FightBossPos.lua", "a+")

	var_23_0:write(dump({
		modelid = self.modelid,
		bossflip = self.scale,
		bossoffset = string.format("%d,%d", self.posx, self.posy)
	}, true) .. "\n")
	var_23_0:flush()
	var_23_0:close()
end

return FightDebugScene
