LabMakeNewLayer = class("LabMakeNewLayer", function()
	return cc.Layer:create()
end)

local playermodel = require("model.playermodel")
local audio_manager = require("controller.audio_manager")
local theater_director = require("controller.theater_director")
local lab_manager = require("controller.lab_manager")
local alert_manager = require("controller.alert_manager")
local l2utils = require("controller.l2utils")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local lab_recipe_data = require("data.lab_recipe_data")
local lab_research_workshop_data = require("data.lab_research_workshop_data")
local var_0_10
local var_0_11 = config._DEBUG and 0 or 1
local var_0_12 = {
	"mainScenebg/dorm_room_bg/81000101.png",
	"mainScenebg/dorm_room_bg/81000102.png",
	"mainScenebg/dorm_room_bg/81000103.png"
}
local var_0_13 = 950

function LabMakeNewLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = LabMakeNewLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function LabMakeNewLayer.getInstance()
	return var_0_10
end

function LabMakeNewLayer:init(arg_4_1)
	var_0_10 = self
	self.initParam = arg_4_1

	self:initUI()
	self:registeTouchEvent()
	self:initData(function()
		self:initWheel()
		self:updateRoom()
		self:updateWheelTiles()
		self:doorOpenAction()
		self:startScheduler()
	end)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			if self.wheelTile then
				self.wheelTile:release()
			end

			var_0_10 = nil

			if self.scheduler then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduler)

				self.scheduler = nil
			end
		end
	end)
end

function LabMakeNewLayer:initData(arg_7_1)
	self.curFloorIndex = 1
	self.maxLabRoomNum = math.ceil(#lab_research_workshop_data / 4) * 4
	self.maxLabRoomNum = math.max(self.maxLabRoomNum, 12)
	self.dataRoomNum = #lab_research_workshop_data
	self.roomListData = {}

	lab_manager:get_research_list(function(arg_8_0)
		if not var_0_10 and self.scheduler then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduler)

			self.scheduler = nil

			return
		end

		if not self.roomListData then
			return
		end

		self.roomListData = global_deepCopy(arg_8_0.reserch_list)

		for iter_8_0 = 1, self.maxLabRoomNum do
			if not self.roomListData[iter_8_0] then
				table.insert(self.roomListData, {
					locked = true,
					modelid = 999901,
					slot = iter_8_0
				})
			end
		end

		self:updateGuidesOnLayer()

		if arg_7_1 then
			arg_7_1()
		end
	end)
end

function LabMakeNewLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:returnEvent()
	end, conf)

	self.bottomList:setName("bottomlist")
	self.bottomList:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.bottomList, 1000)
end

function LabMakeNewLayer:returnEvent()
	local var_11_0

	for iter_11_0, iter_11_1 in pairs(self.roomListData) do
		if not iter_11_1.locked and iter_11_1.cacheItemCount and iter_11_1.status and iter_11_1.cacheItemCount > 0 and iter_11_1.status == RECIPE_COMPLETE then
			var_11_0 = true

			break
		end
	end

	if not var_11_0 then
		alert_manager:unregister_alert(ALERT_LAB)
	end

	KeyCodeManager:onKeyReleasedCallFunc()
end

function LabMakeNewLayer:initUI()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "LabMakeNewLayer.json" or "LabMakeNewLayer.ExportJson")

	self:addChild(self.rootLayer)
	self:initBottomList()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_backGround"):loadTexture("mainScenebg/laboratory_bg.jpg")

	self.roomPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_roomPanel")

	self:initCloneRoom()

	self.roomListObj = {}

	;(function()
		table.insert(self.roomListObj, ccui.Helper:seekWidgetByName(self.rootLayer, "roomCell_1"))

		for iter_13_0 = 2, 4 do
			local var_13_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "roomCell_1"):clone()

			var_13_0:setName("roomCell_" .. iter_13_0)
			self.roomPanel:addChild(var_13_0)
			table.insert(self.roomListObj, var_13_0)
		end

		local var_13_1 = (GameDisplay.height - self.bottomList:getContentSize().height) / 4 - 15

		for iter_13_1 = 1, 4 do
			local var_13_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "roomCell_" .. iter_13_1)

			var_13_2:getChildByName("Label_BAY"):setVisible(false)
			var_13_2:setPositionY((GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - (var_0_13 - (iter_13_1 - 1) * var_13_1), TRANSFORM_UNIT.PX)))
			var_13_2:setTouchEnabled(true)
			var_13_2:addTouchEventListener(function(arg_14_0, arg_14_1)
				if arg_14_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:roomTouchEvent(arg_14_0.index)
			end)
			ccui.Helper:seekWidgetByName(var_13_2, "Panel_unlock"):addTouchEventListener(function(arg_15_0, arg_15_1)
				if arg_15_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:showUnlockRoomPop()
			end)
		end
	end)()
end

function LabMakeNewLayer:roomTouchEvent(arg_16_1)
	if self.roomListData[arg_16_1].locked then
		global_ShowBlockWords(L_LAB_LOCK)
	else
		LayerManager:pushInLayer("LabRecipeListLayer", {
			listType = 2,
			tab = arg_16_1
		})
	end
end

function LabMakeNewLayer:initWheel()
	self.wheelPanel = self.rootLayer:getChildByName("Panel_wheel")
	self.wheelTile = self.wheelPanel:getChildByName("Image_tile")

	self.wheelTile:retain()
	self.wheelTile:removeFromParent()

	self.arrowUp = self.rootLayer:getChildByName("Button_arrow_up")

	self.arrowUp:setPositionY(self.arrowUp:getPositionY() - 20)
	self.arrowUp:setAnchorPoint(cc.p(0.5, 0))
	self.arrowUp:setPositionX(self.wheelTile:getPositionX() + 11)
	self.arrowUp:setScale(1.5)

	self.arrowDown = self.rootLayer:getChildByName("Button_arrow_down")

	self.arrowDown:setPositionY(self.arrowDown:getPositionY() + 20)
	self.arrowDown:setAnchorPoint(cc.p(0.5, 1))
	self.arrowDown:setPositionX(self.wheelTile:getPositionX() + 11)
	self.arrowDown:setScale(1.5)

	local var_17_0 = {
		181,
		134,
		79,
		24,
		-23
	}
	local var_17_1 = {
		0.5,
		0.7,
		1,
		0.7,
		0.5
	}

	self.wheelTiles = {}

	for iter_17_0 = 1, 4 do
		local var_17_2 = self.wheelTile:clone()

		self.wheelPanel:addChild(var_17_2)
		var_17_2:setVisible(false)

		self.wheelTiles[iter_17_0] = var_17_2
	end

	if self.curFloorIndex == 1 then
		self.arrowUp:setOpacity(100)
	elseif self.curFloorIndex == self.maxLabRoomNum / 4 then
		self.arrowDown:setOpacity(100)
	end

	local function var_17_3(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
		arg_18_0:setPositionY(var_17_0[arg_18_1])
		arg_18_0:setScale(var_17_1[arg_18_1])
		arg_18_0:setVisible(true)
		arg_18_0:getChildByName("Image_num"):loadTexture(arg_18_2, var_0_11)
	end

	local function var_17_4()
		for iter_19_0, iter_19_1 in pairs(self.wheelTiles) do
			iter_19_1:setVisible(false)
		end

		if self.curFloorIndex == 1 then
			var_17_3(self.wheelTiles[1], 3, "room_widget/num_1.png")
			var_17_3(self.wheelTiles[2], 4, "room_widget/num_2.png")
			var_17_3(self.wheelTiles[3], 5, "room_widget/num_3.png")
		elseif self.curFloorIndex == self.maxLabRoomNum / 4 then
			var_17_3(self.wheelTiles[1], 1, "room_widget/num_" .. self.maxLabRoomNum / 4 - 2 .. ".png")
			var_17_3(self.wheelTiles[2], 2, "room_widget/num_" .. self.maxLabRoomNum / 4 - 1 .. ".png")
			var_17_3(self.wheelTiles[3], 3, "room_widget/num_" .. self.maxLabRoomNum / 4 .. ".png")
		else
			var_17_3(self.wheelTiles[1], 2, "room_widget/num_" .. self.curFloorIndex - 1 .. ".png")
			var_17_3(self.wheelTiles[2], 3, "room_widget/num_" .. self.curFloorIndex .. ".png")
			var_17_3(self.wheelTiles[3], 4, "room_widget/num_" .. self.curFloorIndex + 1 .. ".png")
		end
	end

	local function var_17_5()
		if self.curFloorIndex == 1 then
			self.wheelTiles[1].id = 1
			self.wheelTiles[2].id = 2
			self.wheelTiles[3].id = 3
		elseif self.curFloorIndex == self.maxLabRoomNum / 4 then
			self.wheelTiles[1].id = self.maxLabRoomNum / 4 - 2
			self.wheelTiles[2].id = self.maxLabRoomNum / 4 - 1
			self.wheelTiles[3].id = self.maxLabRoomNum / 4
		else
			self.wheelTiles[1].id = self.curFloorIndex - 1
			self.wheelTiles[2].id = self.curFloorIndex
			self.wheelTiles[3].id = self.curFloorIndex + 1
		end
	end

	var_17_4()
	var_17_5()
	self:updateWheelTiles()

	function self.wheelPanel.changeAction(arg_21_0)
		if self.curFloorIndex == 1 then
			self.arrowUp:setOpacity(100)
		elseif self.curFloorIndex == self.maxLabRoomNum / 4 then
			self.arrowDown:setOpacity(100)
		else
			self.arrowUp:setOpacity(255)
			self.arrowDown:setOpacity(255)
		end

		local function var_21_0(arg_22_0, arg_22_1)
			arg_22_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.Spawn:create(cc.MoveTo:create(0.8, cc.p(arg_22_0:getPositionX(), var_17_0[arg_22_1])), cc.ScaleTo:create(0.8, var_17_1[arg_22_1])), cc.CallFunc:create(var_17_4)))
		end

		if arg_21_0 == "up" then
			if self.curFloorIndex ~= self.maxLabRoomNum / 4 then
				var_17_3(self.wheelTiles[4], 5, "room_widget/num_" .. self.curFloorIndex + 1 .. ".png", self.curFloorIndex + 1)
			end

			if self.curFloorIndex == 2 then
				var_21_0(self.wheelTiles[4], 5)
				var_21_0(self.wheelTiles[3], 4)
				var_21_0(self.wheelTiles[2], 3)
				var_21_0(self.wheelTiles[1], 2)
			else
				var_21_0(self.wheelTiles[4], 4)
				var_21_0(self.wheelTiles[3], 3)
				var_21_0(self.wheelTiles[2], 2)
				var_21_0(self.wheelTiles[1], 1)
			end
		elseif arg_21_0 == "down" then
			if self.curFloorIndex ~= 1 then
				var_17_3(self.wheelTiles[4], 1, "room_widget/num_" .. self.curFloorIndex - 1 .. ".png", self.curFloorIndex - 1)
			end

			if self.curFloorIndex == self.maxLabRoomNum / 4 - 1 then
				var_21_0(self.wheelTiles[4], 1)
				var_21_0(self.wheelTiles[3], 4)
				var_21_0(self.wheelTiles[2], 3)
				var_21_0(self.wheelTiles[1], 2)
			else
				var_21_0(self.wheelTiles[4], 2)
				var_21_0(self.wheelTiles[3], 5)
				var_21_0(self.wheelTiles[2], 4)
				var_21_0(self.wheelTiles[1], 3)
			end
		end

		self.wheelPanel:runAction(cc.Sequence:create(cc.DelayTime:create(1.1), cc.CallFunc:create(function()
			var_17_5()
			self:updateWheelTiles()
		end)))
	end

	self.arrowUp:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_24_0:getOpacity() ~= 255 then
			return
		end

		self:switchGroup("down")
	end)
	self.arrowDown:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_25_0:getOpacity() ~= 255 then
			return
		end

		self:switchGroup("up")
	end)
	self.arrowUp:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_26_0:getOpacity() ~= 255 then
			return
		end

		self:switchGroup("down")
	end)
	self.arrowDown:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_27_0:getOpacity() ~= 255 then
			return
		end

		self:switchGroup("up")
	end)
end

function LabMakeNewLayer:initCloneRoom()
	local var_28_0 = (GameDisplay.height - self.bottomList:getContentSize().height) / 4 - 15

	self.cloneRooms = {}

	for iter_28_0 = 5, 8 do
		local var_28_3 = ccui.ImageView:create("room_widget/room_bg_margin.png", var_0_11)

		var_28_3:setPosition(320, GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - (var_0_13 - (iter_28_0 - 1) * var_28_0), TRANSFORM_UNIT.PX) - 200)
		self.rootLayer:addChild(var_28_3)

		local var_28_4 = var_28_3:getContentSize().width / 2
		local var_28_5 = var_28_3:getContentSize().height / 2
		local var_28_6 = ccui.ImageView:create("room_widget/door_L.png", var_0_11)

		var_28_6:setPosition(var_28_4, var_28_5)
		var_28_3:addChild(var_28_6)

		local var_28_7 = ccui.ImageView:create("room_widget/door_R.png", var_0_11)

		var_28_7:setPosition(var_28_4, var_28_5)
		var_28_3:addChild(var_28_7)

		self.cloneRooms[iter_28_0 - 4] = var_28_3
	end
end

function LabMakeNewLayer:switchGroup(arg_29_1)
	if self.wheelPanel.action_state == "running" then
		return
	end

	self.wheelPanel.action_state = "running"

	if arg_29_1 == "up" then
		if self.curFloorIndex == self.maxLabRoomNum / 4 then
			self.wheelPanel.action_state = nil

			return
		end

		self.curFloorIndex = self.curFloorIndex + 1
	elseif arg_29_1 == "down" then
		if self.curFloorIndex == 1 then
			self.wheelPanel.action_state = nil

			return
		end

		self.curFloorIndex = self.curFloorIndex - 1
	end

	self:runAction(cc.Sequence:create(cc.CallFunc:create(function()
		self:doorCloseAction()
		self:roomScrollAction(arg_29_1)
		self.wheelPanel.changeAction(arg_29_1)
	end), cc.DelayTime:create(1.1), cc.CallFunc:create(function()
		self:updateRoom()
		self:doorOpenAction()
		self:updateGuidesOnLayer()

		self.wheelPanel.action_state = nil
	end)))
end

function LabMakeNewLayer:roomScrollAction(arg_32_1)
	local var_32_0 = (GameDisplay.height - self.bottomList:getContentSize().height) / 4 - 15
	local var_32_1

	if arg_32_1 == "up" then
		var_32_1 = var_32_0 * 4 or -var_32_0 * 4
	end

	local var_32_2 = 0

	if arg_32_1 == "up" then
		var_32_2 = 100

		for iter_32_0 = 1, 4 do
			self.cloneRooms[iter_32_0]:setPositionY((GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - (var_0_13 - (iter_32_0 - 1 + 4) * var_32_0) + var_32_2, TRANSFORM_UNIT.PX)))
		end
	else
		for iter_32_1 = 1, 4 do
			self.cloneRooms[iter_32_1]:setPositionY((GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - (var_0_13 - (iter_32_1 - 1 - 4) * var_32_0), TRANSFORM_UNIT.PX)))
		end
	end

	for iter_32_2 = 1, 4 do
		self.roomListObj[iter_32_2]:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.MoveBy:create(0.8, cc.p(0, var_32_1))))
		self.cloneRooms[iter_32_2]:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
			self.cloneRooms[iter_32_2]:setVisible(true)
		end), cc.MoveBy:create(0.8, cc.p(0, var_32_1 + var_32_2)), cc.CallFunc:create(function()
			self.roomListObj[iter_32_2]:setPositionY((GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - (var_0_13 - (iter_32_2 - 1) * var_32_0), TRANSFORM_UNIT.PX)))
			self.cloneRooms[iter_32_2]:setPositionY((GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - (var_0_13 - (iter_32_2 - 1 - 4) * var_32_0), TRANSFORM_UNIT.PX)))
			self.cloneRooms[iter_32_2]:setVisible(false)
		end)))
	end
end

function LabMakeNewLayer:doorCloseAction()
	for iter_35_0, iter_35_1 in ipairs(self.roomListObj) do
		ccui.Helper:seekWidgetByName(iter_35_1, "Image_doorR"):stopAllActions()
		ccui.Helper:seekWidgetByName(iter_35_1, "Image_doorL"):stopAllActions()
		ccui.Helper:seekWidgetByName(iter_35_1, "Image_doorR"):runAction(cc.Sequence:create(cc.DelayTime:create((iter_35_0 - 1) * 0.1), cc.MoveTo:create(0.3, cc.p(303, 129))))
		ccui.Helper:seekWidgetByName(iter_35_1, "Image_doorL"):runAction(cc.Sequence:create(cc.DelayTime:create((iter_35_0 - 1) * 0.1), cc.MoveTo:create(0.3, cc.p(303, 129))))
	end
end

function LabMakeNewLayer:doorOpenAction(arg_36_1)
	local function var_36_0(arg_37_0)
		if self.roomListData[arg_37_0.index].locked or self.roomListData[arg_37_0.index].status == RECIPE_LOCK or self.roomListData[arg_37_0.index].status == RECIPE_UNLOCK then
			return false
		end

		return true
	end

	local function var_36_1(arg_38_0, arg_38_1)
		ccui.Helper:seekWidgetByName(arg_38_0, "Image_doorR"):stopAllActions()
		ccui.Helper:seekWidgetByName(arg_38_0, "Image_doorL"):stopAllActions()

		if var_36_0(arg_38_0) then
			ccui.Helper:seekWidgetByName(arg_38_0, "Image_doorR"):runAction(cc.Sequence:create(cc.DelayTime:create((arg_38_1 - 1) * 0.1), cc.MoveTo:create(0.3, cc.p(643, 129))))
			ccui.Helper:seekWidgetByName(arg_38_0, "Image_doorL"):runAction(cc.Sequence:create(cc.DelayTime:create((arg_38_1 - 1) * 0.1), cc.MoveTo:create(0.3, cc.p(-37, 129))))
		end
	end

	if arg_36_1 then
		var_36_1(self.roomListObj[arg_36_1], arg_36_1 % 4 + 1)
	else
		for iter_36_0, iter_36_1 in ipairs(self.roomListObj) do
			var_36_1(iter_36_1, iter_36_0)
		end
	end
end

function LabMakeNewLayer:updateRoom()
	for iter_39_0 = (self.curFloorIndex - 1) * 4 + 1, self.curFloorIndex * 4 do
		self:updateRoomByRoomIndex(iter_39_0)
	end
end

function LabMakeNewLayer:updateRoomByRoomIndex(arg_40_1)
	local var_40_0

	for iter_40_0, iter_40_1 in pairs(self.roomListData) do
		if iter_40_1.locked or iter_40_1.status == RECIPE_LOCK or iter_40_1.status == RECIPE_UNLOCK then
			var_40_0 = iter_40_1.slot

			break
		end
	end

	if arg_40_1 > self.dataRoomNum then
		var_40_0 = false
	end

	local var_40_1 = self.roomListObj[arg_40_1 - (self.curFloorIndex - 1) * 4]

	var_40_1.index = arg_40_1

	ccui.Helper:seekWidgetByName(var_40_1, "Label_time"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_40_1, "Image_clock"):setVisible(false)

	if not var_40_0 then
		ccui.Helper:seekWidgetByName(var_40_1, "Panel_unlock"):setVisible(false)
	else
		ccui.Helper:seekWidgetByName(var_40_1, "Panel_unlock"):setVisible(arg_40_1 == var_40_0)

		if self.roomListData[arg_40_1].status == RECIPE_LOCK then
			ccui.Helper:seekWidgetByName(var_40_1, "Image_logo"):loadTexture("room_widget/building.png", var_0_11)
			ccui.Helper:seekWidgetByName(var_40_1, "Label_time"):setVisible(true)
			ccui.Helper:seekWidgetByName(var_40_1, "Image_clock"):setVisible(true)
			ccui.Helper:seekWidgetByName(var_40_1, "Image_logo"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
				local var_41_9001
				local var_41_9000

				ccui.Helper:seekWidgetByName(var_40_1, "Label_time"):setString(global_get_time_by_second(self.roomListData[arg_40_1].time))
				ccui.Helper:seekWidgetByName(var_40_1, "Image_clock").setPositionX(ccui.Helper:seekWidgetByName(var_40_1, "Image_clock").getContentSize(ccui.Helper:seekWidgetByName(var_40_1, "Label_time"):getContentSize().width / 2).width / 2, ccui.Helper:seekWidgetByName(var_40_1, "Label_time"):getPositionX() - var_41_9001 - var_41_9000 - 5)
			end), cc.DelayTime:create(1))))
		elseif self.roomListData[arg_40_1].status == RECIPE_UNLOCK then
			ccui.Helper:seekWidgetByName(var_40_1, "Image_logo"):loadTexture("room_widget/finish.png", var_0_11)
			ccui.Helper:seekWidgetByName(var_40_1, "Image_logo"):stopAllActions()
		else
			ccui.Helper:seekWidgetByName(var_40_1, "Image_logo"):loadTexture("room_widget/unlock.png", var_0_11)
			ccui.Helper:seekWidgetByName(var_40_1, "Image_logo"):stopAllActions()
		end
	end

	ccui.Helper:seekWidgetByName(var_40_1, "Panel_lockTouch"):setVisible(self.roomListData[arg_40_1].locked == true)
	ccui.Helper:seekWidgetByName(var_40_1, "Panel_lockTouch"):addTouchEventListener(function(arg_42_0, arg_42_1)
		if arg_42_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.roomListData[arg_40_1].locked then
			if not var_40_0 then
				global_ShowBlockWords(L_FUNCTION_DEVELOPING)
			else
				global_ShowBlockWords(L_LAB_LOCK)
			end
		end
	end)
	ccui.Helper:seekWidgetByName(var_40_1, "Label_order"):setString(string.format("%2d", arg_40_1))
	ccui.Helper:seekWidgetByName(var_40_1, "Label_str"):setString((lab_research_workshop_data[arg_40_1] or nil) and (lab_research_workshop_data[arg_40_1].name or ""))
	ccui.Helper:seekWidgetByName(var_40_1, "Image_roomBg"):loadTexture(var_0_12[(arg_40_1 - 1) % 3 + 1])
	ccui.Helper:seekWidgetByName(var_40_1, "Image_door"):loadTexture("lab_main_screen/recipe_door.png", var_0_11)
end

function LabMakeNewLayer.updateGuidesOnLayer(arg_43_0)
	LayerManager:updateGuidesOnSwitchLayer()
end

function LabMakeNewLayer:showUnlockRoomPop()
	for iter_44_0, iter_44_1 in pairs(self.roomListData) do
		if iter_44_1.status == RECIPE_LOCK then
			LayerManager:pushInLayer("PopRoomQuickFinishLayer", {
				sureCallback = function(arg_45_0, arg_45_1, arg_45_2)
					lab_manager:add_research_unlock_speed(arg_45_0, arg_45_1, function(arg_46_0)
						for iter_46_0, iter_46_1 in pairs(arg_46_0.research_single) do
							self.roomListData[arg_46_0.research_single.slot][iter_46_0] = iter_46_1
						end

						self:updateRoom()

						if arg_45_2 then
							arg_45_2(arg_46_0.result)
						end

						if arg_46_0.research_single.status == 0 then
							audio_manager:playeffectMusic(DORM_UNLOCK_ROOM)
							self:doorOpenAction()
						end
					end)
				end,
				surplus = iter_44_1.time,
				goto_back_system_id = self.goto_back_system_id
			})

			return
		end

		if iter_44_1.status == RECIPE_UNLOCK then
			lab_manager:unlock_cur_research_slot(function(arg_47_0)
				for iter_47_0, iter_47_1 in pairs(arg_47_0.research_single) do
					self.roomListData[arg_47_0.research_single.slot][iter_47_0] = iter_47_1
				end

				self:doorOpenAction()
				self:updateRoom()
				audio_manager:playeffectMusic(DORM_UNLOCK_ROOM)
			end)

			return
		end
	end

	for iter_44_2, iter_44_3 in pairs(self.roomListData) do
		if iter_44_3.locked then
			slotid = iter_44_3.slot

			break
		end
	end

	LayerManager:pushInLayer("PopUnlockLabSlotLayer", {
		datePath = "data.lab_research_workshop_data",
		title = "public/title/unlock_lab.png",
		sureCallback = function(arg_48_0)
			self:unlockRoom(arg_48_0)
		end,
		slotid = slotid,
		goto_back_system_id = self.goto_back_system_id
	})
end

function LabMakeNewLayer.unlockRoom(arg_49_0, arg_49_1)
	lab_manager:start_unlock_cur_research_slot(function(arg_50_0)
		if arg_50_0.result == 1 then
			for iter_50_0, iter_50_1 in pairs(arg_50_0.research_single) do
				arg_49_0.roomListData[arg_50_0.research_single.slot][iter_50_0] = iter_50_1
			end

			arg_49_0.roomListData[arg_50_0.research_single.slot].locked = false

			arg_49_0:updateRoom(arg_50_0.research_single.slot - (arg_49_0.curFloorIndex - 1) * 4)
		end

		if arg_49_1 then
			arg_49_1(arg_50_0.result)
		end
	end)
end

function LabMakeNewLayer:updateWheelTiles()
	for iter_51_0, iter_51_1 in pairs(self.wheelTiles) do
		iter_51_1:getChildByName("Image_redDot"):setVisible(false)
	end

	self.arrowUp:getChildByName("Image_redDot"):setVisible(false)
	self.arrowDown:getChildByName("Image_redDot"):setVisible(false)

	for iter_51_2 = 1, #self.wheelTiles do
		for iter_51_3 = 1, 4 do
			if self.roomListData[(iter_51_2 - 1) * 4 + iter_51_3] and self.roomListData[(iter_51_2 - 1) * 4 + iter_51_3].cacheItemCount and self.roomListData[(iter_51_2 - 1) * 4 + iter_51_3].cacheItemCount > 0 then
				for iter_51_4, iter_51_5 in pairs(self.wheelTiles) do
					if iter_51_5.id == iter_51_2 then
						iter_51_5:getChildByName("Image_redDot"):setVisible(true)
					end
				end

				if self.curFloorIndex >= iter_51_2 + 2 then
					self.arrowUp:getChildByName("Image_redDot"):setVisible(true)
				end

				if self.curFloorIndex <= iter_51_2 - 2 then
					self.arrowDown:getChildByName("Image_redDot"):setVisible(true)
				end
			end
		end
	end
end

function LabMakeNewLayer:registeTouchEvent()
	local var_52_0 = ccui.Layout:create()

	var_52_0:setContentSize(cc.size(640, GameDisplay.height))
	var_52_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_52_0:setTouchEnabled(false)
	self:addChild(var_52_0, 999)

	listener = cc.EventListenerTouchOneByOne:create()

	listener:setSwallowTouches(false)
	listener:registerScriptHandler(function(arg_53_0, arg_53_1)
		if LayerManager:getCurrentLayerName() ~= "LabMakeNewLayer" then
			return false
		end

		if self.wheelPanel.action_state == "running" then
			return false
		end

		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(function(arg_54_0, arg_54_1)
		local var_54_0 = var_52_0:convertToNodeSpace(arg_54_0:getStartLocation())
		local var_54_1 = var_52_0:convertToNodeSpace(arg_54_0:getLocation())

		if var_54_1.y - var_54_0.y > 200 then
			self:switchGroup("up")
		elseif var_54_1.y - var_54_0.y < -200 then
			self:switchGroup("down")
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, var_52_0)
end

function LabMakeNewLayer.startScheduler(arg_55_0)
	local function var_55_0()
		local function var_56_0(arg_57_0)
			if not var_0_10 and arg_55_0.scheduler then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(arg_55_0.scheduler)

				arg_55_0.scheduler = nil

				return
			end

			if not arg_55_0.roomListData then
				return
			end

			for iter_57_0, iter_57_1 in ipairs(arg_55_0.roomListData) do
				if iter_57_1.status == RECIPE_LOCK then
					iter_57_1.time = iter_57_1.time - arg_57_0

					if iter_57_1.time <= 0 then
						iter_57_1.status = RECIPE_UNLOCK
						iter_57_1.time = nil

						arg_55_0:doorOpenAction()
						arg_55_0:updateRoom()
					end
				end
			end
		end

		var_56_0(0)

		arg_55_0.scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(var_56_0, 1, false)
	end

	playermodel:getServerTime(function()
		var_55_0()
	end)
end
