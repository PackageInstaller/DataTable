local FightDebugScene = class("FightDebugScene", function()
	return cc.Scene:create()
end)

function FightDebugScene:create()
	local var_2_0 = FightDebugScene.new()

	var_2_0:init()

	return var_2_0
end

local var_0_1 = 0
local var_0_2 = 0

function FightDebugScene:init()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "fight_result.json" or "fight_result.ExportJson")

	self:addChild(self.rootLayer)

	self.roleImg = ccui.Helper:seekWidgetByName(self.rootLayer, "image_system_figure")

	self.roleImg:loadTexture("role/broken_21204.png")
	self.roleImg:setOpacity(255)

	var_0_1, var_0_2 = self.roleImg:getPosition()

	self:initDebugPanel()
end

local function var_0_3(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7, arg_4_8)
	local var_4_0 = cc.EditBox:create(arg_4_7, (config._DEBUG or nil) and (cc.Scale9Sprite:create("public/panelbg/editBoxBG.png") or cc.Scale9Sprite:createWithSpriteFrameName("public/panelbg/editBoxBG.png")))

	var_4_0:setName(arg_4_0)
	var_4_0:setPosition(arg_4_8)
	var_4_0:setAnchorPoint(cc.p(0, 0.5))
	var_4_0:setFontName(arg_4_3)
	var_4_0:setPlaceholderFont(arg_4_3, arg_4_2)
	var_4_0:setFontSize(arg_4_2)
	var_4_0:setFontColor(cc.c3b(255, 255, 255))
	var_4_0:setPlaceHolder(arg_4_4)
	var_4_0:setPlaceholderFontColor(cc.c3b(255, 255, 255))
	var_4_0:setMaxLength(arg_4_5)
	var_4_0:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
	var_4_0:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
	var_4_0:setInputFlag(arg_4_6)
	arg_4_1:addChild(var_4_0, 100)

	return var_4_0
end

local model_data = require("data.model_data")

function FightDebugScene:initDebugPanel()
	self.modelid = 20104
	self.posx = 0
	self.posy = 0
	self.scale = 1

	self:resetBoss()

	local var_5_0 = ccs.GUIReader:getInstance():widgetFromJsonFile("MainLayerDebug.json")

	var_5_0:setPosition(cc.p(0, -50))
	self:addChild(var_5_0, 900)

	local var_5_1 = var_0_3("input", var_5_0:getChildByName("Panel_1"), 30, "fonts/newkj.ttf", initmodelid, 22, cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_WORD, cc.size(100, 70), cc.p(80, 150))
	local var_5_2 = var_5_0:getChildByName("Panel_1")
	local var_5_3 = var_5_0:getChildByName("Panel_21")

	var_5_3:setVisible(true)
	var_5_2:getChildByName("choose"):addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_6_0 = checkint(var_5_1:getText())

		if not model_data[var_6_0] then
			require("controller.global_func")
			global_ShowBlockWords("modelid error")
		end

		self.modelid = var_6_0

		self:resetBoss()
	end)
	var_5_2:getChildByName("up"):addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 == ccui.TouchEventType.began then
			self:startMove("posy", 1)
		elseif arg_7_1 == ccui.TouchEventType.ended then
			self:endMove()

			self.posy = self.posy + 1

			self:updateBossPos()
		end
	end)
	var_5_2:getChildByName("down"):addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 == ccui.TouchEventType.began then
			self:startMove("posy", -1)
		elseif arg_8_1 == ccui.TouchEventType.ended then
			self:endMove()

			self.posy = self.posy - 1

			self:updateBossPos()
		end
	end)
	var_5_2:getChildByName("left"):addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 == ccui.TouchEventType.began then
			self:startMove("posx", -1)
		elseif arg_9_1 == ccui.TouchEventType.ended then
			self:endMove()

			self.posx = self.posx - 1

			self:updateBossPos()
		end
	end)
	var_5_2:getChildByName("right"):addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 == ccui.TouchEventType.began then
			self:startMove("posx", 1)
		elseif arg_10_1 == ccui.TouchEventType.ended then
			self:endMove()

			self.posx = self.posx + 1

			self:updateBossPos()
		end
	end)
	var_5_2:getChildByName("output"):addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.modelid then
			return
		end

		self:outputBossPos()
	end)
	var_5_3:getChildByName("left"):addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.scale = -1 * self.scale

		self:updateBossPos()
	end)
	var_5_3:getChildByName("mid"):addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.scale = -1 * self.scale

		self:updateBossPos()
	end)
	var_5_3:getChildByName("right"):addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.scale = -1 * self.scale

		self:updateBossPos()
	end)
end

function FightDebugScene:startMove(arg_15_1, arg_15_2)
	self.startscheduler = self.startscheduler or cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_16_0)
		self[arg_15_1] = self[arg_15_1] + arg_15_2

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
	self.roleImg:setScaleX(self.scale)
	self.roleImg:setPosition(cc.p(var_0_1 + self.posx, var_0_2 + self.posy))
end

function FightDebugScene:resetBoss()
	self.roleImg:loadTexture("role/" .. model_data[self.modelid].broken_role .. ".png")

	self.posx = 0
	self.posy = 0
	self.scale = 1

	self:updateBossPos()
end

function FightDebugScene:outputBossPos()
	local var_20_0 = io.open("./FightResultOffset.lua", "a+")

	var_20_0:write(dump({
		modelid = self.modelid,
		bossflip = self.scale,
		bossoffset = string.format("%d,%d", self.posx, self.posy)
	}, true) .. "\n")
	var_20_0:flush()
	var_20_0:close()
end

return FightDebugScene
