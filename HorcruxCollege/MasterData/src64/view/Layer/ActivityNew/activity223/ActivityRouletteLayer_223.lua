ActivityRouletteLayer_223 = class("ActivityRouletteLayer_223", function()
	return ActivityRouletteBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")

function ActivityRouletteLayer_223.create(arg_2_0)
	local var_2_0 = ActivityRouletteLayer_223.new()

	var_2_0:init({
		id = 223
	})

	return var_2_0
end

function ActivityRouletteLayer_223:initBottomList()
	self.btnReturn = ccui.Button:create(self._imagePath .. "/btn_return.png", nil, self._imagePath .. "/btn_return.png", var_0_0)

	self.btnReturn:setPosition(cc.p(95, 20 + (GameDisplay.height - 1136) * 0.07))
	self.rootLayer:addChild(self.btnReturn, 999)
	self.btnReturn:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.slotMachineSprite.isplay then
			return
		end

		self:playOutEffect(function()
			KeyCodeManager:onKeyReleasedCallFunc()
		end)
	end)

	self.returnBG = ccui.ImageView:create(self._imagePath .. "/return_bg.png", var_0_0)

	self.returnBG:setAnchorPoint(cc.p(0, 0))
	self.returnBG:setPosition(cc.p(0, -10))
	self.rootLayer:addChild(self.returnBG)

	self.btnCost = ccui.Button:create(self._imagePath .. "/btn_cost.png", self._imagePath .. "/btn_cost.png", self._imagePath .. "/btn_cost.png", var_0_0)

	self.btnCost:setPosition(cc.p(550, 20 + (GameDisplay.height - 1136) * 0.08))
	self.rootLayer:addChild(self.btnCost, 999)
	self.btnCost:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_6_0 = activity_manager:canBuyRouletteCurrency(self.activityId)

		if var_6_0 and var_6_0 < 0 then
			LayerManager:pushInLayer("PopActivityItemGainLayer", {
				activityId = self.activityId
			})

			return
		elseif var_6_0 then
			goto_complete_system({
				jump_to_system = var_6_0
			})

			return
		end

		LayerManager:pushInLayer("PopRouletteBuyLayer", {
			activityId = self.activityId
		})
	end)

	local var_3_0 = ccui.ImageView:create(self._imagePath .. "/+.png", var_0_0)

	var_3_0:setPosition(cc.p(160, 28))
	self.btnCost:addChild(var_3_0, 999)

	self.lblHasNum = cc.Label:createWithTTF("X999", FONT_W5, 30)

	self.lblHasNum:setPosition(cc.p(110, 28))
	self.btnCost:addChild(self.lblHasNum, 999)
end

function ActivityRouletteLayer_223:initTitle()
	local var_7_0 = ccui.Button:create(self._imagePath .. "/img_title.png", self._imagePath .. "/img_title.png", self._imagePath .. "/img_title.png", var_0_0)

	var_7_0:setPosition(cc.p(210, GameDisplay.height - 80 - (GameDisplay.height - 1136) * 0.18))
	self.rootLayer:addChild(var_7_0, 99)
	var_7_0:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = self._imagePath
		})
	end)

	self.timeLbl = cc.Label:createWithTTF("", FONT_W5, 20)

	self.timeLbl:setPosition(cc.p(306, var_7_0:getPositionY() - 105))
	self.timeLbl:setColor(cc.c3b(82, 31, 14))
	self.rootLayer:addChild(self.timeLbl, 99)
end
