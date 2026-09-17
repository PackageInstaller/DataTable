local function var_0_0(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7, arg_1_8)
	local var_1_0 = cc.EditBox:create(arg_1_7, (config._DEBUG or nil) and (cc.Scale9Sprite:create("public/panelbg/editBoxBG.png") or cc.Scale9Sprite:createWithSpriteFrameName("public/panelbg/editBoxBG.png")))

	var_1_0:setName(arg_1_0)
	var_1_0:setPosition(arg_1_8)
	var_1_0:setAnchorPoint(cc.p(0, 0.5))
	var_1_0:setFontName(arg_1_3)
	var_1_0:setPlaceholderFont(arg_1_3, arg_1_2)
	var_1_0:setFontSize(arg_1_2)
	var_1_0:setFontColor(cc.c3b(255, 255, 255))
	var_1_0:setPlaceHolder(arg_1_4)
	var_1_0:setPlaceholderFontColor(cc.c3b(255, 255, 255))
	var_1_0:setMaxLength(arg_1_5)
	var_1_0:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
	var_1_0:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
	var_1_0:setInputFlag(arg_1_6)
	arg_1_1:addChild(var_1_0, 100)

	return var_1_0
end

local model_data = require("data.model_data")
local playermodel = require("model.playermodel")
local var_0_3 = {
	[0] = "mid",
	[1] = "init"
}

local function var_0_4(arg_2_0)
	local var_2_0, var_2_1 = arg_2_0:match("([^,]+),(.+)")

	return cc.p(checknumber(var_2_0), checknumber(var_2_1))
end

function MainLayer:initDebugShowGrilPos()
	local var_3_0 = ccs.GUIReader:getInstance():widgetFromJsonFile("MainLayerDebug.json")

	self:addChild(var_3_0, 10)

	local var_3_1 = var_0_0("input", var_3_0:getChildByName("Panel_1"), 30, "fonts/newkj.ttf", playermodel.showgirl, 22, cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_WORD, cc.size(100, 70), cc.p(80, 150))
	local var_3_2 = var_3_0:getChildByName("Panel_1")
	local var_3_3 = cc.p(0, 0)
	local var_3_4 = playermodel.showgirl

	var_3_3 = self._uiStatus == SHOW_ALL_UI and (model_data[playermodel.showgirl].maininitoffset and var_0_4(model_data[playermodel.showgirl].maininitoffset) or cc.p(0, 0)) or model_data[playermodel.showgirl].mainmidoffset and var_0_4(model_data[playermodel.showgirl].mainmidoffset) or cc.p(0, 0)

	var_3_2:getChildByName("choose"):addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_4_0 = checkint(var_3_1:getText())

		if not model_data[var_4_0] then
			global_ShowBlockWords("modelid error")
		end

		var_3_4 = var_4_0

		self.showgirlLayer:update(var_4_0)

		var_3_3 = self._uiStatus == SHOW_ALL_UI and (model_data[var_4_0].maininitoffset and var_0_4(model_data[var_4_0].maininitoffset) or cc.p(0, 0)) or model_data[var_4_0].mainmidoffset and var_0_4(model_data[var_4_0].mainmidoffset) or cc.p(0, 0)
	end)
	var_3_2:getChildByName("up"):addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_3_3.y = var_3_3.y + 1

		self.showgirlLayer:debugPosition(cc.p(0, 1))
	end)
	var_3_2:getChildByName("down"):addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_3_3.y = var_3_3.y - 1

		self.showgirlLayer:debugPosition(cc.p(0, -1))
	end)
	var_3_2:getChildByName("left"):addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_3_3.x = var_3_3.x - 1

		self.showgirlLayer:debugPosition(cc.p(-1, 0))
	end)
	var_3_2:getChildByName("right"):addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_3_3.x = var_3_3.x + 1

		self.showgirlLayer:debugPosition(cc.p(1, 0))
	end)
	var_3_2:getChildByName("output"):addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_3_4 then
			return
		end

		local var_9_0 = io.open("./MainLayerPos.lua", "a+")

		var_9_0:write(dump({
			modelid = var_3_4,
			postype = var_0_3[self._uiStatus],
			offset = string.format("%d,%d", var_3_3.x, var_3_3.y)
		}, true) .. "\n")
		var_9_0:flush()
		var_9_0:close()
	end)
end
