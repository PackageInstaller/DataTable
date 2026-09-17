PopAutoArrayLayer = class("PopAutoArrayLayer", function()
	return PopBaseLayer:create()
end)

local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_5 = {
	"all",
	"wind",
	"fire",
	"water",
	"light",
	"dark",
	"positive",
	"devil",
	"mimicry"
}

function PopAutoArrayLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopAutoArrayLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopAutoArrayLayer:init(arg_3_1)
	if arg_3_1 then
		self.exitcallback = arg_3_1.surecallback or nil
	end

	self.initindex = arg_3_1.initindex
	self.rootLayer = TempWidget:CreateTempLayout(self)

	self.rootLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.rootLayer:setBackGroundColorOpacity(180)
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.rootLayer:setLocalZOrder(2)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.rootLayer:setTouchEnabled(true)

	local var_3_0 = TempWidget:CreateTempImg("PopAutoArrayLayer/bg.png", self.rootLayer)

	var_3_0:_addEvent(function()
		return
	end)
	var_3_0:center()

	self.rootpanel = var_3_0

	TempWidget:CreateTempLabel("请选择队伍天赋", FONT_NAME, 23, var_3_0):align(cc.p(0.5, 1), var_3_0:size().w / 2, var_3_0:size().h - 60)

	self.buttons = {}

	for iter_3_0 = 1, #var_0_5 do
		local var_3_1 = math.ceil(iter_3_0 / 5)
		local var_3_2 = iter_3_0 % 5

		if iter_3_0 % 5 == 0 then
			var_3_2 = 5
		end

		local var_3_3 = TempWidget:CreateTempBtn("PopAutoArrayLayer/" .. var_0_5[iter_3_0] .. ".png", var_3_0)

		var_3_3:align(cc.p(0.5, 1), 120 + (var_3_2 - 1) * 100, var_3_0:size().h - 100 - (var_3_1 - 1) * 100)

		var_3_3.id = iter_3_0

		local var_3_4 = TempWidget:CreateTempImg("PopAutoArrayLayer/select.png", var_3_3)

		var_3_4:center()
		var_3_4:hide()
		var_3_4:setName("select")

		self.buttons[iter_3_0] = var_3_3
	end

	local var_3_5 = (#var_0_5 + 1) % 5

	if (#var_0_5 + 1) % 5 == 0 then
		var_3_5 = 5
	end

	local var_3_6 = TempWidget:CreateTempBtn("PopAutoArrayLayer/other.png", var_3_0)

	var_3_6:align(cc.p(0.5, 1), 120 + (var_3_5 - 1) * 100, var_3_0:size().h - 100 - (math.ceil((#var_0_5 + 1) / 5) - 1) * 100)

	var_3_6.id = #var_0_5 + 1

	local var_3_7 = TempWidget:CreateTempImg("PopAutoArrayLayer/select.png", var_3_6)

	var_3_7:hide()
	var_3_7:center()
	var_3_7:setName("select")

	self.buttons[#var_0_5 + 1] = var_3_6
	self.sure_btn = TempWidget:CreateTempBtn("PopAutoArrayLayer/sure.png", var_3_0)

	self.sure_btn:align(cc.p(0.5, 1), var_3_0:size().w / 2, -20)
	self.rootLayer:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self.showActions.extendVertical(self)
	self:initUI()
end

function PopAutoArrayLayer:initUI()
	for iter_7_0, iter_7_1 in ipairs(self.buttons) do
		iter_7_1.id = iter_7_0

		iter_7_1:addTouchEventListener(function(arg_8_0, arg_8_1)
			if arg_8_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:updateBtnFrame(arg_8_0.id)

			if arg_8_0.id == #var_0_5 + 1 then
				self.atrr = "other|"

				local var_8_0 = {}

				for iter_8_0 = 1, #var_0_5 do
					var_8_0[var_0_5[iter_8_0]] = 1
				end

				for iter_8_1, iter_8_2 in pairs(ATTR_ID) do
					if not var_8_0[iter_8_2] and iter_8_2 ~= "null" then
						self.atrr = self.atrr .. iter_8_2 .. "#"
					end
				end

				self.atrr = string.sub(self.atrr, 1, string.len(self.atrr) - 1)
			else
				self.atrr = var_0_5[arg_8_0.id]
			end
		end)
	end

	self:updateBtnFrame(self.initindex or 1)

	self.atrr = var_0_5[self.initindex or 1]

	self.sure_btn:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.atrr then
			global_ShowBlockWords("请选择天赋!!!!!!!!!!!!")
		else
			self:exit()
		end
	end)
end

function PopAutoArrayLayer:updateBtnFrame(arg_10_1)
	if not arg_10_1 then
		return
	end

	for iter_10_0, iter_10_1 in pairs(self.buttons) do
		if iter_10_0 == arg_10_1 then
			if iter_10_1:getChildByName("select") then
				iter_10_1:getChildByName("select"):setVisible(true)
			end
		elseif iter_10_1:getChildByName("select") then
			iter_10_1:getChildByName("select"):setVisible(false)
		end
	end
end

function PopAutoArrayLayer:exit(arg_11_1)
	self.hideActions.shrinkVertical(self, function()
		if self.exitcallback then
			self.exitcallback({
				type = self.atrr
			})
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopAutoArrayLayer:initBg(arg_13_1)
	local var_13_0 = ccui.Layout:create()

	var_13_0:setTouchEnabled(true)
	var_13_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_13_0:setAnchorPoint(cc.p(0, 0))
	var_13_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_13_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_13_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_13_0:setOpacity(0)
	var_13_0:setCascadeOpacityEnabled(false)
	self:addChild(var_13_0, -1)

	local var_13_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_13_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_13_1:setPositionX(var_13_0:getContentSize().width / 2)
	var_13_1:setPositionY(var_13_0:getContentSize().height / 2)
	var_13_0:addChild(var_13_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_14_0)
		self:addChild(arg_14_0, -2)
		arg_14_0:setPositionY(arg_14_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_13_1)
		var_13_0:setOpacity(102)
		var_13_0:setTouchEnabled(false)
	end)
end
