PopElectricSupplyLayer = class("PopElectricSupplyLayer", function()
	return PopBaseLayer:create()
end)

function PopElectricSupplyLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopElectricSupplyLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

require("view.Sprite.ItemSprite")

local item_data = require("data.item_data")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local network = require("network.network")
local audio_manager = require("controller.audio_manager")
local armature_manager = require("controller.armature_manager")
local lab_manager = require("controller.lab_manager")
local var_0_7 = config._DEBUG and 0 or 1
local var_0_8 = {
	2100001,
	2100002,
	2100003,
	2100004,
	2100005
}

function PopElectricSupplyLayer:init(arg_3_1)
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ElectricSupplyLayer.json" or "ElectricSupplyLayer.ExportJson")

	self:addChild(self.rootlayer)
	self.rootlayer:setLocalZOrder(999)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_bottom")

	self.rootpanel:setPositionY(GameDisplay.getScreenSize().height / 2)

	self.panelback = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_back")

	self.panelback:setTouchEnabled(false)

	self.msg = arg_3_1

	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		arg_4_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			if arg_3_1 and arg_3_1.callback then
				arg_3_1.callback()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)

	self.btnSure = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_sure")

	self.showActions.extendVertical(self)
	self:initUI()
	self:initBatteryList()

	self.times = 1

	self.btnSure:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.oldEleNum = item_manager:getItemNumber(ELECTRIC)

		lab_manager:use_all_battery(function(arg_7_0)
			if arg_7_0.result == 1 then
				self:runAnim()
				self:initBatteryList()
				self:updateBatteryList()
				GlobalUpdateElectric()
				self:runAction(cc.Sequence:create(cc.DelayTime:create(0.7), cc.CallFunc:create(function()
					if self.rootpanel:getChildByName("electricUpEffect") then
						self.rootpanel:getChildByName("electricUpEffect"):removeFromParent()
					end
				end)))

				local var_7_0 = cc.EventCustom:new("electricSupply")

				var_7_0.eventType = eventType

				cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_7_0)
			else
				global_ShowBlockWords(L_BATTERY_LACK)

				if self.rootpanel:getChildByName("electricUpEffect") then
					self:runAction(cc.Sequence:create(cc.DelayTime:create(0.7), cc.CallFunc:create(function()
						if self.rootpanel:getChildByName("electricUpEffect") then
							self.rootpanel:getChildByName("electricUpEffect"):removeFromParent()
						end
					end)))
				end

				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end)
	end)
end

function PopElectricSupplyLayer:runAnim()
	if not self.rootpanel:getChildByName("electricUpEffect") then
		local var_10_0 = armature_manager:createAndPlayArmature("electricUpEffect")

		var_10_0:setName("electricUpEffect")
		self.rootpanel:addChild(var_10_0, 999)
		var_10_0:setPosition(cc.p(self.rootpanel:getContentSize().width / 2, self.rootpanel:getContentSize().height / 2 + 100))
	end
end

function PopElectricSupplyLayer:runRepeatAction()
	self.times = 1
	self.num = 0

	local var_11_0 = self.batteryTable[tonumber((string.sub(self.index, 7)))]:getChildByName("battery")
	local var_11_1 = item_manager:getItemNumber(self.index)
	local var_11_2 = 0

	self.scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_12_0)
		var_11_2 = var_11_2 + arg_12_0

		if var_11_2 > 1 then
			var_11_1 = var_11_1 - 1

			var_11_0:getChildByName("number"):setString("X" .. var_11_1)

			self.num = self.num + 1
			self.numberEle = self.numberEle + item_data[self.index].gain_exp

			self.labelPower:setString(global_trans_number(self.numberEle))
			self.labelPower:setColor(cc.c3b(52, 255, 181))

			local var_12_0 = self:computePercent()

			self.imageHand:setRotation(180 * (var_12_0 / 100 <= 1 and var_12_0 / 100 or 1))
			self.electricBar:setPercentage(var_12_0 / 2)

			if var_11_1 == 0 then
				global_ShowBlockWords(L_BATTERY_LACK)
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduler)
			end
		end
	end, 0, false)
end

function PopElectricSupplyLayer.getItemNum(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = item_manager:getItemNumber(arg_13_1)

	if arg_13_2 < var_13_0 then
		return arg_13_2
	else
		return var_13_0
	end
end

function PopElectricSupplyLayer:updateBatteryList()
	self.numberEle = item_manager:getItemNumber(ELECTRIC)
	self.intervalNum = (self.numberEle - self.oldEleNum) / 10

	self.labelPower:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
		self.oldEleNum = self.oldEleNum + self.intervalNum

		if self.oldEleNum >= self.numberEle then
			self.oldEleNum = self.numberEle
		end

		self.labelPower:setString(global_trans_number(self.oldEleNum))

		if self.oldEleNum == self.numberEle then
			self.labelPower:stopAllActions()
		end
	end), cc.DelayTime:create(0.07))))
	self.labelPower:setColor(cc.c3b(52, 255, 181))

	local var_14_0 = self:computePercent()
	local var_14_1 = var_14_0 / 100
	local var_14_2 = var_14_0 / 100 / 10
	local var_14_3 = self.imageHand:getRotation()

	self.imageHand:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
		var_14_3 = var_14_3 + var_14_2

		if var_14_3 >= var_14_1 then
			var_14_3 = var_14_1
		end

		self.imageHand:setRotation(180 * var_14_3)

		if var_14_3 == var_14_1 then
			self.imageHand:stopAllActions()
		end
	end), cc.DelayTime:create(0.07))))

	local var_14_4 = self.electricBar:getPercentage() * 2
	local var_14_5 = var_14_0 / 10

	self.electricBar:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
		var_14_4 = var_14_4 + var_14_5

		if var_14_4 >= var_14_0 then
			var_14_4 = var_14_0
		end

		self.electricBar:setPercentage(var_14_4 / 2)

		if var_14_4 >= var_14_0 then
			self.electricBar:stopAllActions()
		end
	end), cc.DelayTime:create(0.07))))
end

function PopElectricSupplyLayer:switchBattery(arg_18_1)
	if self.index == arg_18_1 then
		return
	end

	self.index = arg_18_1

	for iter_18_0 = 1, #self.batteryTable do
		if self.batteryTable[iter_18_0].id == self.index then
			self.batteryTable[iter_18_0]:getChildByName("imageChoice"):setVisible(true)
		else
			self.batteryTable[iter_18_0]:getChildByName("imageChoice"):setVisible(false)
		end
	end
end

function PopElectricSupplyLayer:initBatteryList()
	local var_19_0 = 22
	local var_19_2 = cc.p(self.panelBattery:getContentSize().width / 2, self.panelBattery:getContentSize().height / 2 + 25)

	if not self.batteryTable then
		self.batteryTable = {}
	else
		for iter_19_0 = 1, #self.batteryTable do
			self.batteryTable[iter_19_0]:removeFromParent()
		end

		self.batteryTable = {}
	end

	self.batteryIdTable = {}

	for iter_19_1, iter_19_2 in pairs(var_0_8) do
		local var_19_3
		local var_19_5 = self.panelBattery:clone()

		if playermodel.items[iter_19_2] then
			var_19_3 = ItemSprite:createBigWithEntityId(iter_19_2)

			local var_19_6 = ccui.ImageView:create("ElectricSupplyLayer/select_frame_electric.png", var_0_7)

			var_19_6:setPosition(var_19_2)
			var_19_6:setName("imageChoice")
			var_19_5:addChild(var_19_6, 999)

			self.batteryIdTable[#self.batteryIdTable + 1] = iter_19_2
		else
			var_19_3 = ItemSprite:createNewWithItemId(iter_19_2)

			local var_19_7 = ccui.ImageView:create("ElectricSupplyLayer/no_electric.png", var_0_7)

			var_19_7:setPosition(cc.p(var_19_3:getContentSize().width / 2, var_19_3:getContentSize().height / 2))
			var_19_7:setScale(1.7)
			var_19_3:addChild(var_19_7, 9999)
		end

		var_19_3:setName("battery")
		var_19_3:setScale(0.6)
		var_19_3:setPosition(cc.p(self.panelBattery:getContentSize().width / 2, self.panelBattery:getContentSize().height / 2 + 15))
		var_19_5:addChild(var_19_3, 99)
		var_19_5:setPosition(cc.p(30, var_19_0))
		var_19_5:setLocalZOrder(999)
		var_19_5:getChildByName("Label_ele"):setString(L_ELECTRIC .. item_data[iter_19_2].gain_exp)
		self.rootpanel:addChild(var_19_5, 99)

		self.batteryTable[#self.batteryTable + 1] = var_19_5
		var_19_5.id = iter_19_2
	end
end

function PopElectricSupplyLayer.computePercent(arg_20_0)
	local var_20_0 = 11.11111111111111 * math.log((item_manager:getItemNumber(ELECTRIC))) / math.log(10)

	if var_20_0 > 100 then
		-- block empty
	end

	return var_20_0
end

function PopElectricSupplyLayer:initUI()
	self.labelPower = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_power")
	self.panelBattery = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_battery")
	self.imageHand = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_hand")

	local var_21_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_10")

	self.numberEle = item_manager:getItemNumber(ELECTRIC)

	self.labelPower:setString(global_trans_number(self.numberEle))

	local var_21_1 = self:computePercent()

	if self.numberEle == 0 then
		self.labelPower:setColor(cc.c3b(255, 52, 133))
	else
		self.labelPower:setColor(cc.c3b(52, 255, 181))
		self.imageHand:setRotation(180 * (var_21_1 / 100 <= 1 and var_21_1 / 100 or 1))
	end

	self.electricBar = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("ElectricSupplyLayer/progress_charge2.png") or cc.Sprite:createWithSpriteFrameName("ElectricSupplyLayer/progress_charge2.png")))

	self.electricBar:setAnchorPoint(cc.p(0.5, 0.5))
	self.electricBar:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
	self.electricBar:setPositionX(var_21_0:getContentSize().width / 2)
	self.electricBar:setPositionY(var_21_0:getContentSize().height / 2)
	self.electricBar:setReverseDirection(false)
	var_21_0:addChild(self.electricBar, 999)
	self.electricBar:setPercentage(var_21_1 / 2)
end

function PopElectricSupplyLayer:initBg(arg_22_1)
	local var_22_0 = ccui.Layout:create()

	var_22_0:setTouchEnabled(true)
	var_22_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_22_0:setAnchorPoint(cc.p(0, 0))
	var_22_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_22_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_22_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_22_0:setOpacity(0)
	self:addChild(var_22_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_23_0)
		self:addChild(arg_23_0, -2)
		arg_23_0:setPositionY(arg_23_0:getPositionY() - GameDisplay.fix_y)

		local var_23_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_23_0:setAnchorPoint(cc.p(0, 0))
		var_23_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_23_0, -1)
		self:init(arg_22_1)
		var_22_0:setOpacity(102)
		var_22_0:setTouchEnabled(false)
	end)
end

function PopElectricSupplyLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.msg and self.msg.callback then
			self.msg.callback()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
