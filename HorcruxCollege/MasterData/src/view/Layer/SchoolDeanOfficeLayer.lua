SchoolDeanOfficeLayer = class("SchoolDeanOfficeLayer", function()
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
local lab_workshop_data = require("data.lab_workshop_data")
local lab_recipe_data = require("data.lab_recipe_data")
local npc_data = require("data.npc_data")
local Utility = require("common.Utility")
local var_0_16 = 950
local var_0_17 = "mainScenebg/dorm_room_bg/91000001.png"

function SchoolDeanOfficeLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = SchoolDeanOfficeLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

local var_0_18 = config._DEBUG and 0 or 1

function SchoolDeanOfficeLayer.touchEvent(arg_3_0)
	LayerManager:switchShowLayer("PhotoMemoryLayer")
end

function SchoolDeanOfficeLayer.returnEvent(arg_4_0)
	KeyCodeManager:onKeyReleasedCallFunc()
end

function SchoolDeanOfficeLayer:init(arg_5_1)
	self.initconfig = initconfig

	AnalyticManager.enterOffice()

	self.initParam = arg_5_1

	self:initUI()
	self:registeTouchEvent()
	self:initData(function()
		self:initWheel()
		self:updateRoom()
		self:updateWheelTiles()
		self:doorOpenAction()
	end)
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			SchoolDeanOfficeLayerInstance = nil
		end
	end)
end

function SchoolDeanOfficeLayer:initData(arg_8_1)
	self.displayTbl = {
		{
			modelid = "100"
		},
		{
			modelid = "1000"
		},
		{
			modelid = "2100"
		},
		{
			modelid = "200"
		},
		{
			modelid = "2200"
		},
		{
			modelid = "2000"
		}
	}
	self.curFloorIndex = 1
	self.maxLabRoomNum = 12
	self.roomListData = {}

	for iter_8_0 = 1, self.maxLabRoomNum do
		if self.displayTbl[iter_8_0] then
			table.insert(self.roomListData, {
				locked = false,
				modelid = self.displayTbl[iter_8_0].modelid,
				roomName = model_data[self.displayTbl[iter_8_0].modelid].name
			})
		else
			table.insert(self.roomListData, {
				locked = true
			})
		end
	end

	if arg_8_1 then
		arg_8_1()
	end
end

function SchoolDeanOfficeLayer:initBottomList()
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

function SchoolDeanOfficeLayer.returnEvent(arg_11_0)
	KeyCodeManager:onKeyReleasedCallFunc()
end

function SchoolDeanOfficeLayer:initUI()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "DeanOfficeLayer.json" or "DeanOfficeLayer.ExportJson")

	self:addChild(self.rootLayer)
	self:initBottomList()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_backGround"):loadTexture("mainScenebg/deanoffice_bg.jpg")

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

			var_13_2:setPositionY((GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - (var_0_16 - (iter_13_1 - 1) * var_13_1), TRANSFORM_UNIT.PX)))
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

function SchoolDeanOfficeLayer.roomTouchEvent(arg_16_0, arg_16_1)
	if arg_16_1 > 2 then
		return
	end

	LayerManager:switchShowLayer("CourseCultivateLayer", {
		returnLayer = "SchoolDeanOfficeLayer",
		courseType = arg_16_1
	})
end

function SchoolDeanOfficeLayer:initWheel()
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
		arg_18_0:getChildByName("Image_num"):loadTexture(arg_18_2, var_0_18)
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

	if not require("controller.antihexie_assets_manager"):isAntiHexieNow() then
		self.wheelPanel:setVisible(false)
		self.arrowDown:setVisible(false)
		self.arrowUp:setVisible(false)
	end
end

function SchoolDeanOfficeLayer:initCloneRoom()
	local var_28_0 = (GameDisplay.height - self.bottomList:getContentSize().height) / 4 - 15

	self.cloneRooms = {}

	for iter_28_0 = 5, 8 do
		local var_28_3 = ccui.ImageView:create("room_widget/room_bg_margin.png", var_0_18)

		var_28_3:setPosition(320, GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - (var_0_16 - (iter_28_0 - 1) * var_28_0), TRANSFORM_UNIT.PX) - 200)
		self.rootLayer:addChild(var_28_3)

		local var_28_4 = var_28_3:getContentSize().width / 2
		local var_28_5 = var_28_3:getContentSize().height / 2
		local var_28_6 = ccui.ImageView:create("room_widget/door_L.png", var_0_18)

		var_28_6:setPosition(var_28_4, var_28_5)
		var_28_3:addChild(var_28_6)

		local var_28_7 = ccui.ImageView:create("room_widget/door_R.png", var_0_18)

		var_28_7:setPosition(var_28_4, var_28_5)
		var_28_3:addChild(var_28_7)

		self.cloneRooms[iter_28_0 - 4] = var_28_3
	end
end

function SchoolDeanOfficeLayer:switchGroup(arg_29_1)
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

		self.wheelPanel.action_state = nil
	end)))
end

function SchoolDeanOfficeLayer:roomScrollAction(arg_32_1)
	local var_32_0 = (GameDisplay.height - self.bottomList:getContentSize().height) / 4 - 15
	local var_32_1

	if arg_32_1 == "up" then
		var_32_1 = var_32_0 * 4 or -var_32_0 * 4
	end

	local var_32_2 = 0

	if arg_32_1 == "up" then
		var_32_2 = 100

		for iter_32_0 = 1, 4 do
			self.cloneRooms[iter_32_0]:setPositionY((GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - (var_0_16 - (iter_32_0 - 1 + 4) * var_32_0) + var_32_2, TRANSFORM_UNIT.PX)))
		end
	else
		for iter_32_1 = 1, 4 do
			self.cloneRooms[iter_32_1]:setPositionY((GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - (var_0_16 - (iter_32_1 - 1 - 4) * var_32_0), TRANSFORM_UNIT.PX)))
		end
	end

	for iter_32_2 = 1, 4 do
		self.roomListObj[iter_32_2]:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.MoveBy:create(0.8, cc.p(0, var_32_1))))
		self.cloneRooms[iter_32_2]:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
			self.cloneRooms[iter_32_2]:setVisible(true)
		end), cc.MoveBy:create(0.8, cc.p(0, var_32_1 + var_32_2)), cc.CallFunc:create(function()
			self.roomListObj[iter_32_2]:setPositionY((GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - (var_0_16 - (iter_32_2 - 1) * var_32_0), TRANSFORM_UNIT.PX)))
			self.cloneRooms[iter_32_2]:setPositionY((GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - (var_0_16 - (iter_32_2 - 1 - 4) * var_32_0), TRANSFORM_UNIT.PX)))
			self.cloneRooms[iter_32_2]:setVisible(false)
		end)))
	end
end

function SchoolDeanOfficeLayer:doorCloseAction()
	for iter_35_0, iter_35_1 in ipairs(self.roomListObj) do
		ccui.Helper:seekWidgetByName(iter_35_1, "Image_doorR"):stopAllActions()
		ccui.Helper:seekWidgetByName(iter_35_1, "Image_doorL"):stopAllActions()
		ccui.Helper:seekWidgetByName(iter_35_1, "Image_doorR"):runAction(cc.Sequence:create(cc.DelayTime:create((iter_35_0 - 1) * 0.1), cc.MoveTo:create(0.3, cc.p(303, 129))))
		ccui.Helper:seekWidgetByName(iter_35_1, "Image_doorL"):runAction(cc.Sequence:create(cc.DelayTime:create((iter_35_0 - 1) * 0.1), cc.MoveTo:create(0.3, cc.p(303, 129))))
	end
end

function SchoolDeanOfficeLayer:doorOpenAction(arg_36_1)
	local function var_36_0(arg_37_0)
		if self.roomListData[arg_37_0.index].locked then
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

function SchoolDeanOfficeLayer:updateRoom()
	for iter_39_0 = (self.curFloorIndex - 1) * 4 + 1, self.curFloorIndex * 4 do
		self:updateRoomByRoomIndex(iter_39_0)
	end
end

function SchoolDeanOfficeLayer:updateRoomByRoomIndex(arg_40_1)
	local var_40_0

	for iter_40_0, iter_40_1 in pairs(self.roomListData) do
		if iter_40_1.locked then
			var_40_0 = iter_40_1.slot

			break
		end
	end

	local var_40_1 = self.roomListObj[arg_40_1 - (self.curFloorIndex - 1) * 4]

	var_40_1.index = arg_40_1

	if not var_40_0 then
		ccui.Helper:seekWidgetByName(var_40_1, "Panel_unlock"):setVisible(false)
	else
		ccui.Helper:seekWidgetByName(var_40_1, "Panel_unlock"):setVisible(arg_40_1 == var_40_0 + 1)
	end

	ccui.Helper:seekWidgetByName(var_40_1, "Panel_lockTouch"):setVisible(self.roomListData[arg_40_1].locked == true)
	ccui.Helper:seekWidgetByName(var_40_1, "Panel_lockTouch"):addTouchEventListener(function(arg_41_0, arg_41_1)
		if arg_41_1 ~= ccui.TouchEventType.ended then
			return
		end
	end)
	ccui.Helper:seekWidgetByName(var_40_1, "Label_order"):setString(string.format("%2d", arg_40_1))

	if not require("controller.antihexie_assets_manager"):isAntiHexieNow() then
		var_40_1:getChildByName("Label_BAY"):setVisible(false)
		var_40_1:getChildByName("Label_order"):setPosition(var_40_1:getChildByName("Label_BAY"):getPositionX(), var_40_1:getChildByName("Label_BAY"):getPositionY() + 5)
	end

	ccui.Helper:seekWidgetByName(var_40_1, "Label_str"):setString((self.roomListData[arg_40_1] or nil) and (self.roomListData[arg_40_1].roomName or ""))
	self:updateScreen(arg_40_1)
	ccui.Helper:seekWidgetByName(var_40_1, "Image_roomBg"):loadTexture(var_0_17)
	ccui.Helper:seekWidgetByName(var_40_1, "Image_door"):loadTexture("SchoolDeanOfficeLayer/door.png", var_0_18)
	self:updateCourseBtn(var_40_1, arg_40_1)

	if var_40_1.director then
		if not self.roomListData[arg_40_1].locked and self.roomListData[arg_40_1].modelid then
			if self.roomListData[arg_40_1].modelid ~= var_40_1.modelid then
				var_40_1.director:deleteSelf()

				local var_40_2 = theater_director.new_lab_npc(self.roomListData[arg_40_1].modelid, ccui.Helper:seekWidgetByName(var_40_1, "Panel_show"))

				var_40_1.director = var_40_2

				var_40_2:startPlay()
				print(self.roomListData[arg_40_1].modelid, model_data[self.roomListData[arg_40_1].modelid].name)

				var_40_1.modelid = self.roomListData[arg_40_1].modelid
			end
		else
			var_40_1.director:deleteSelf()

			var_40_1.director = nil
		end
	elseif not self.roomListData[arg_40_1].locked and self.roomListData[arg_40_1].modelid then
		local var_40_3 = theater_director.new_lab_npc(self.roomListData[arg_40_1].modelid, ccui.Helper:seekWidgetByName(var_40_1, "Panel_show"))

		var_40_1.director = var_40_3

		var_40_3:startPlay()

		var_40_1.modelid = self.roomListData[arg_40_1].modelid
	end
end

function SchoolDeanOfficeLayer:updateScreen(arg_42_1)
	local var_42_0 = {
		170,
		310
	}
	local var_42_1 = ccui.Helper:seekWidgetByName(self.roomListObj[arg_42_1 - (self.curFloorIndex - 1) * 4], "Image_screen1")

	var_42_1:setVisible(false)

	var_42_1.index = arg_42_1

	var_42_1:setPositionX(var_42_0[1])

	var_42_1.time = 0
	var_42_1.state = "down"
	var_42_1:getChildByName("Button_arrow").state = "down"
	var_42_1:getChildByName("Button_arrow").colour = "blue"

	var_42_1:setLocalZOrder(-1)

	if false then
		var_42_1:getChildByName("Button_arrow").state = "up"

		local var_42_2 = "room_widget/" .. var_42_1:getChildByName("Button_arrow").colour .. "_up.png"

		var_42_1:getChildByName("Button_arrow"):loadTextures(var_42_2, var_42_2, var_42_2, var_0_18)
		var_42_1:setPositionY(278)
	else
		var_42_1:getChildByName("Button_arrow").state = "down"

		local var_42_3 = "room_widget/" .. var_42_1:getChildByName("Button_arrow").colour .. "_down.png"

		var_42_1:getChildByName("Button_arrow"):loadTextures(var_42_3, var_42_3, var_42_3, var_0_18)
		var_42_1:setPositionY(182)
	end

	var_42_1:getChildByName("Button_arrow"):addTouchEventListener(function(arg_43_0, arg_43_1)
		if arg_43_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_43_0.state == "up" then
			arg_43_0.state = "running"

			arg_43_0:loadTextures("room_widget/" .. arg_43_0.colour .. "_down.png", "room_widget/" .. arg_43_0.colour .. "_down.png", "room_widget/" .. arg_43_0.colour .. "_down.png", var_0_18)
			var_42_1:runAction(cc.Sequence:create(cc.MoveTo:create(0.2, cc.p(var_42_0[1], 182)), cc.MoveTo:create(0.05, cc.p(var_42_0[1], 178)), cc.MoveTo:create(0.05, cc.p(var_42_0[1], 186)), cc.MoveTo:create(0.05, cc.p(var_42_0[1], 182)), cc.CallFunc:create(function()
				arg_43_0.state = "down"
			end)))
		elseif arg_43_0.state == "down" then
			arg_43_0.state = "running"

			arg_43_0:loadTextures("room_widget/" .. arg_43_0.colour .. "_up.png", "room_widget/" .. arg_43_0.colour .. "_up.png", "room_widget/" .. arg_43_0.colour .. "_up.png", var_0_18)
			var_42_1:runAction(cc.Sequence:create(cc.MoveTo:create(0.1, cc.p(var_42_0[1], 175)), cc.MoveTo:create(0.3, cc.p(var_42_0[1], 303)), cc.CallFunc:create(function()
				arg_43_0.state = "up"
			end)))
		end
	end)
	var_42_1:addTouchEventListener(self:getScreenHandel())
end

local var_0_19 = {
	"SchoolDeanOfficeLayer/course_base.png",
	"SchoolDeanOfficeLayer/course_element.png"
}

function SchoolDeanOfficeLayer.updateCourseBtn(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = ccui.Helper:seekWidgetByName(arg_46_1, "Image_roomBg")
	local var_46_1 = var_46_0:getChildByName("btnCourse")

	if not var_46_1 and var_0_19[arg_46_2] then
		var_46_1 = ccui.Button:create(var_0_19[arg_46_2], var_0_19[arg_46_2], var_0_19[arg_46_2], var_0_18)

		var_46_1:setName("btnCourse")
		var_46_1:setPosition(cc.p(220, 180))
		var_46_0:addChild(var_46_1)
		Utility:addClickEventListener(var_46_1, function()
			LayerManager:switchShowLayer("CourseCultivateLayer", {
				returnLayer = "SchoolDeanOfficeLayer",
				courseType = arg_46_2
			})
		end)

		local var_46_2 = ccui.ImageView:create("SchoolDeanOfficeLayer/course_arrow.png", var_0_18)

		var_46_2:setPosition(var_46_1:getContentSize().width / 2, -20)
		var_46_1:addChild(var_46_2)
		var_46_2:runAction(cc.RepeatForever:create((cc.Sequence:create(cc.MoveBy:create(0.5, cc.p(0, 10)), cc.MoveBy:create(0.5, cc.p(0, -10))))))
	end

	if var_46_1 and not var_0_19[arg_46_2] then
		var_46_1:setVisible(false)
	elseif var_46_1 then
		var_46_1:setVisible(true)
	end
end

function SchoolDeanOfficeLayer.showUnlockRoomPop(arg_48_0)
	return
end

function SchoolDeanOfficeLayer.unlockRoom(arg_49_0, arg_49_1)
	return
end

function SchoolDeanOfficeLayer.getScreenHandel(arg_50_0)
	return function(arg_51_0, arg_51_1)
		if arg_51_1 ~= ccui.TouchEventType.ended then
			return
		end
	end
end

function SchoolDeanOfficeLayer.updateWheelTiles(arg_52_0)
	return
end

function SchoolDeanOfficeLayer:registeTouchEvent()
	local var_53_0 = ccui.Layout:create()

	var_53_0:setContentSize(cc.size(640, 1136))
	var_53_0:setTouchEnabled(false)
	self:addChild(var_53_0, 999)

	listener = cc.EventListenerTouchOneByOne:create()

	listener:setSwallowTouches(false)
	listener:registerScriptHandler(function(arg_54_0, arg_54_1)
		if LayerManager:getCurrentLayerName() ~= "SchoolDeanOfficeLayer" then
			return false
		end

		if self.wheelPanel.action_state == "running" then
			return false
		end

		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(function(arg_55_0, arg_55_1)
		local var_55_0 = var_53_0:convertToNodeSpace(arg_55_0:getStartLocation())
		local var_55_1 = var_53_0:convertToNodeSpace(arg_55_0:getLocation())

		if var_55_1.y - var_55_0.y > 200 then
			self:switchGroup("up")
		elseif var_55_1.y - var_55_0.y < -200 then
			self:switchGroup("down")
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, var_53_0)
end
