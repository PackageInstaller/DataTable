PopUnlockLabSlotLayer = class("PopUnlockLabSlotLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")

local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local lab_workshop_data = require("data.lab_workshop_data")
local dorm_rooms_data = require("data.dorm_rooms_data")
local LocalEvent = require("common.LocalEvent")
local Utility = require("common.Utility")

function PopUnlockLabSlotLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopUnlockLabSlotLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopUnlockLabSlotLayer:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(false)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.rootLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.rootLayer:setBackGroundColorOpacity(0)
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.ImageView:create("public/panelbg/bg_pupup_level3.png", var_0_0)

	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2 - GameDisplay.fix_y)
	self.rootLayer:addChild(self.rootpanel)
	self.showActions.extendVertical(self)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		arg_4_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			if self.exitcallback then
				self.exitcallback(0)
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)

	self.goto_back_system_id = arg_3_1.goto_back_system_id
	self.id = arg_3_1.slotid
	self.sureCallback = arg_3_1.sureCallback
	self.datePath = arg_3_1.datePath or "data.lab_workshop_data"
	self.time = self:getData()[self.id].cost_time
	self.titlePath = arg_3_1.title or "pop_unlock_room/title_unlock_workshop.png"

	self:initUI()
	self:updateUI()
	Utility:registerNodeEvent(self)
	LocalEvent:registerEvent(self, LocalEvent.EVENT_IDS.COMPOUND_ITEM_ONE_KEY, handler(self, self.handleComposeItemOneKey))
end

function PopUnlockLabSlotLayer:handleComposeItemOneKey()
	self:updateUI()
end

function PopUnlockLabSlotLayer.onExit(arg_7_0)
	LocalEvent:removeEvent(arg_7_0)
end

function PopUnlockLabSlotLayer:getData()
	return require(self.datePath)
end

function PopUnlockLabSlotLayer:initUI()
	local var_9_0 = ccui.ImageView:create(self.titlePath, var_0_0)

	var_9_0:setPositionX(var_9_0:getContentSize().width / 2)
	var_9_0:setPositionY(self.rootpanel:getContentSize().height + var_9_0:getContentSize().height / 2)
	self.rootpanel:addChild(var_9_0)

	local var_9_1 = cc.Label:createWithTTF(L_LAB_UNLOCK_MATERIAL, FONT_NAME, 30)

	var_9_1:setColor(cc.c3b(216, 230, 246))
	var_9_1:setPositionX(self.rootpanel:getContentSize().width / 2)
	var_9_1:setPositionY(self.rootpanel:getContentSize().height - var_9_1:getContentSize().height)
	self.rootpanel:addChild(var_9_1)

	self.unlockBtn = ccui.Button:create("pop_unlock_room/btn_unlock.png", nil, "pop_unlock_room/btn_unlock.png", var_0_0)

	self.unlockBtn:setPositionX(self.rootpanel:getContentSize().width / 2)
	self.unlockBtn:setPositionY(-self.unlockBtn:getContentSize().height / 2)
	self.rootpanel:addChild(self.unlockBtn)

	self.clockIcon = ccui.ImageView:create("room_widget/img_clock.png", var_0_0)

	self.clockIcon:setPosition(cc.p(500, 170))
	self.rootpanel:addChild(self.clockIcon)

	self.costTimeLabel = cc.Label:createWithTTF(global_get_time_by_second(self.time), FONT_DES, 22)

	self.costTimeLabel:setAnchorPoint(cc.p(0, 0.5))
	self.costTimeLabel:setPositionX(self.clockIcon:getPositionX() + self.clockIcon:getContentSize().width / 2 + 5)
	self.costTimeLabel:setPositionY(self.clockIcon:getPositionY())
	self.rootpanel:addChild(self.costTimeLabel)
	self.unlockBtn:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_10_0:isBright() then
			return
		end

		arg_10_0:setBright(false)

		if self.sureCallback then
			self.sureCallback(function(arg_11_0)
				if arg_11_0 == 1 then
					self.hideActions.shrinkVertical(self, function()
						if self.exitcallback then
							self.exitcallback(0)
						end

						LayerManager:removePopLayer(self.__queueindex)
					end)
				end

				arg_10_0:setBright(true)
			end)
		end
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("electricSupply", function(...)
		self:updateUI()
	end), self)
end

function PopUnlockLabSlotLayer:updateUI()
	local var_14_0 = {}

	if self:getData()[self.id].costdiamond and self:getData()[self.id].costdiamond > 0 then
		table.insert(var_14_0, {
			itemid = "diamond",
			needNum = self:getData()[self.id].costdiamond,
			ownNum = playermodel.diamond
		})
	end

	if self:getData()[self.id].gold and self:getData()[self.id].gold > 0 then
		table.insert(var_14_0, {
			itemid = "gold",
			needNum = self:getData()[self.id].gold,
			ownNum = playermodel.gold
		})
	end

	local var_14_1 = 1

	while self:getData()[self.id]["material" .. var_14_1] do
		local var_14_2 = self:getData()[self.id]["material" .. var_14_1]

		table.insert(var_14_0, {
			itemid = var_14_2,
			needNum = self:getData()[self.id]["material" .. var_14_1 .. "_num"],
			ownNum = item_manager:getItemNumber(var_14_2)
		})

		var_14_1 = var_14_1 + 1
	end

	local var_14_3 = false

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		if iter_14_1.needNum > iter_14_1.ownNum then
			var_14_3 = true
		end

		local var_14_4 = ItemSmallSprite:createSmallItem(iter_14_1.itemid, iter_14_1.ownNum, iter_14_1.needNum, self.goto_back_system_id)

		var_14_4:setScale(0.7)
		var_14_4:setInfoTouchEvent(true)
		var_14_4:setPositionX(self.rootpanel:getContentSize().width / 2 - (iter_14_0 - (#var_14_0 + 1) / 2) * (var_14_4:getContentSize().width + 5))
		var_14_4:setPositionY(self.rootpanel:getContentSize().height / 2 - 10)
		self.rootpanel:addChild(var_14_4)
	end

	if var_14_3 then
		self.unlockBtn:loadTextures("pop_unlock_room/btn_unlock_gray.png", nil, "pop_unlock_room/btn_unlock_gray.png", var_0_0)

		self.unlockBtn.satisfied = false
	else
		self.unlockBtn:loadTextures("pop_unlock_room/btn_unlock.png", nil, "pop_unlock_room/btn_unlock.png", var_0_0)

		self.unlockBtn.satisfied = true
	end
end

PopUnlockDormRoomLayer = class("PopUnlockDormRoomLayer", function()
	return PopBaseLayer:create()
end)

function PopUnlockDormRoomLayer.create(arg_16_0, arg_16_1)
	local var_16_0 = PopUnlockDormRoomLayer.new()

	var_16_0:init(arg_16_1)

	return var_16_0
end

function PopUnlockDormRoomLayer:init(arg_17_1)
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(cc.Director:getInstance():getVisibleSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.width / 2, GameDisplay.height / 2 - GameDisplay.fix_y))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.rootLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.rootLayer:setBackGroundColorOpacity(180)
	self:addChild(self.rootLayer)

	self.rootpanel = ccui.ImageView:create("public/panelbg/bg_pupup_level3.png", var_0_0)

	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2)
	self.rootLayer:addChild(self.rootpanel)
	self.rootLayer:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_18_0:isBright() then
			return
		end

		arg_18_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			if self.exitcallback then
				self.exitcallback(0)
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self.showActions.extendVertical(self)

	self.goto_back_system_id = arg_17_1.goto_back_system_id
	self.id = arg_17_1.roomid
	self.sureCallback = arg_17_1.sureCallback

	self:initUI()
	self:updateUI()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("electricSupply", function(...)
		self:updateUI()
	end), self)
	Utility:registerNodeEvent(self)
	LocalEvent:registerEvent(self, LocalEvent.EVENT_IDS.COMPOUND_ITEM_ONE_KEY, handler(self, self.handleComposeItemOneKey))
end

function PopUnlockDormRoomLayer:handleComposeItemOneKey()
	self:updateUI()
end

function PopUnlockDormRoomLayer.onExit(arg_22_0)
	LocalEvent:removeEvent(arg_22_0)
end

function PopUnlockDormRoomLayer:initUI()
	local var_23_0 = ccui.ImageView:create("public/title/unlock_dormitory.png", var_0_0)

	var_23_0:setPositionX(var_23_0:getContentSize().width / 2)
	var_23_0:setPositionY(self.rootpanel:getContentSize().height + var_23_0:getContentSize().height / 2 + 5)
	self.rootpanel:addChild(var_23_0)

	local var_23_1 = cc.Label:createWithTTF(L_DORM_UNLOCK_MATERIAL, FONT_NAME, 30)

	var_23_1:setColor(cc.c3b(216, 230, 246))
	var_23_1:setPositionX(self.rootpanel:getContentSize().width / 2)
	var_23_1:setPositionY(self.rootpanel:getContentSize().height - var_23_1:getContentSize().height)
	self.rootpanel:addChild(var_23_1)

	self.unlockBtn = ccui.Button:create("pop_unlock_room/btn_unlock.png", nil, "pop_unlock_room/btn_unlock.png", var_0_0)

	self.unlockBtn:setPositionX(self.rootpanel:getContentSize().width / 2)
	self.unlockBtn:setPositionY(-self.unlockBtn:getContentSize().height / 2)
	self.rootpanel:addChild(self.unlockBtn)

	self.clockIcon = ccui.ImageView:create("room_widget/img_clock.png", var_0_0)

	self.clockIcon:setPosition(cc.p(500, 170))
	self.rootpanel:addChild(self.clockIcon)

	self.costTimeLabel = cc.Label:createWithTTF("", FONT_DES, 22)

	self.costTimeLabel:setAnchorPoint(cc.p(0, 0.5))
	self.costTimeLabel:setPositionX(self.clockIcon:getPositionX() + self.clockIcon:getContentSize().width / 2 + 5)
	self.costTimeLabel:setPositionY(self.clockIcon:getPositionY())
	self.rootpanel:addChild(self.costTimeLabel)
	self.unlockBtn:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_24_0:isBright() then
			return
		end

		arg_24_0:setBright(false)

		if self.sureCallback then
			self.sureCallback(function(arg_25_0)
				if arg_25_0 == 1 then
					self.hideActions.shrinkVertical(self, function()
						if self.exitcallback then
							self.exitcallback(0)
						end

						LayerManager:removePopLayer(self.__queueindex)
					end)
				end

				arg_24_0:setBright(true)
			end)
		end
	end)
end

function PopUnlockDormRoomLayer:updateUI()
	local var_27_0 = {}

	if dorm_rooms_data[self.id].costdiamond and dorm_rooms_data[self.id].costdiamond > 0 then
		table.insert(var_27_0, {
			itemid = "diamond",
			needNum = dorm_rooms_data[self.id].costdiamond,
			ownNum = playermodel.diamond
		})
	end

	if dorm_rooms_data[self.id].gold and dorm_rooms_data[self.id].gold > 0 then
		table.insert(var_27_0, {
			itemid = "gold",
			needNum = dorm_rooms_data[self.id].gold,
			ownNum = playermodel.gold
		})
	end

	self.costTimeLabel:setString(global_get_time_by_second(dorm_rooms_data[self.id].cost_time))

	while dorm_rooms_data[self.id]["material" .. 1] do
		table.insert(var_27_0, {
			itemid = dorm_rooms_data[self.id]["material" .. 1],
			needNum = dorm_rooms_data[self.id]["material" .. 1 .. "_num"],
			ownNum = item_manager:getItemNumber(dorm_rooms_data[self.id]["material" .. 1])
		})
	end

	local var_27_2 = false

	for iter_27_0, iter_27_1 in pairs(var_27_0) do
		if iter_27_1.needNum > iter_27_1.ownNum then
			var_27_2 = true
		end

		local var_27_3 = ItemSmallSprite:createSmallItem(iter_27_1.itemid, iter_27_1.ownNum, iter_27_1.needNum, self.goto_back_system_id)

		var_27_3:setScale(0.7)
		var_27_3:setInfoTouchEvent(true)
		var_27_3:setPositionX(self.rootpanel:getContentSize().width / 2 - (iter_27_0 - (#var_27_0 + 1) / 2) * (var_27_3:getContentSize().width + 5))
		var_27_3:setPositionY(self.rootpanel:getContentSize().height / 2 - 10)
		self.rootpanel:addChild(var_27_3)
	end

	if var_27_2 then
		self.unlockBtn:loadTextures("pop_unlock_room/btn_unlock_gray.png", nil, "pop_unlock_room/btn_unlock_gray.png", var_0_0)

		self.unlockBtn.satisfied = false
	else
		self.unlockBtn:loadTextures("pop_unlock_room/btn_unlock.png", nil, "pop_unlock_room/btn_unlock.png", var_0_0)

		self.unlockBtn.satisfied = true
	end
end

function PopUnlockDormRoomLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.exitcallback then
			self.exitcallback(0)
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
