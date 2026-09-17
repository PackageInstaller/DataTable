SchoolArchivesLayer = class("SchoolArchivesLayer", function()
	return cc.Layer:create()
end)

local loading_texture_manager = require("controller.loading_texture_manager")
local alert_manager = require("controller.alert_manager")
local var_0_2 = {
	[1] = "mainScenebg/dorm_room_bg/81000201.png",
	[2] = "mainScenebg/dorm_room_bg/91000013.png"
}

function SchoolArchivesLayer:getExitParam()
	return cloneconf(self.initconfig)
end

function SchoolArchivesLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = SchoolArchivesLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

local var_0_3
local var_0_4 = config._DEBUG and 0 or 1

function SchoolArchivesLayer.getInstance()
	return var_0_3
end

function SchoolArchivesLayer:init(arg_5_1)
	var_0_3 = self
	self.initconfig = arg_5_1

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
			var_0_3 = nil
		end
	end)
	AnalyticManager.enterLibrary()
end

function SchoolArchivesLayer:initData(arg_8_1)
	self.typeTable = {
		"file",
		"cinema"
	}
	self.curFloorIndex = 1
	self.maxLabRoomNum = math.ceil(#self.typeTable / 4) * 4
	self.roomListData = {}

	for iter_8_0 = 1, self.maxLabRoomNum do
		if self.typeTable[iter_8_0] then
			table.insert(self.roomListData, {
				locked = false,
				roomType = self.typeTable[iter_8_0],
				roomName = L_SCHOOL_ARCHIVES_NAME_TABLE[self.typeTable[iter_8_0]]
			})
		else
			table.insert(self.roomListData, {
				locked = true,
				roomType = self.typeTable[iter_8_0],
				roomName = L_SCHOOL_ARCHIVES_NAME_TABLE[self.typeTable[iter_8_0]]
			})
		end
	end

	if arg_8_1 then
		arg_8_1()
	end
end

function SchoolArchivesLayer:initUI()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "SchoolArchivesLayer.json" or "SchoolArchivesLayer.ExportJson")

	self:addChild(self.rootLayer)
	self:initBottomList()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_backGround"):loadTexture("mainScenebg/dormbg.jpg")

	self.roomPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_roomPanel")
	self.roomListObj = {}

	;(function()
		table.insert(self.roomListObj, ccui.Helper:seekWidgetByName(self.rootLayer, "roomCell_1"))

		for iter_10_0 = 2, 4 do
			local var_10_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "roomCell_1"):clone()

			var_10_0:setName("roomCell_" .. iter_10_0)
			self.roomPanel:addChild(var_10_0)
			table.insert(self.roomListObj, var_10_0)
		end

		local var_10_1 = (GameDisplay.height - self.bottomList:getContentSize().height) / 4 - 5

		self.roomListObj[1].full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, GameDisplay.height * ((config._DESIGN_HEIGHT - 997) / config._DESIGN_HEIGHT) + 160 * (GameDisplay.height / config._DESIGN_HEIGHT - 1), TRANSFORM_UNIT.PX)

		self.roomListObj[1]:setPositionY(self.roomListObj[1].full_posY)

		self.roomListObj[4].full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, GameDisplay.height * (179 / config._DESIGN_HEIGHT) + 160 * (GameDisplay.height / config._DESIGN_HEIGHT - 1), TRANSFORM_UNIT.PX)

		self.roomListObj[4]:setPositionY(self.roomListObj[4].full_posY)

		local var_10_2 = (self.roomListObj[1]:getPositionY() - self.roomListObj[4]:getPositionY()) / 3

		self.room_distance = var_10_2
		self.roomListObj[2].full_posY = self.roomListObj[1]:getPositionY() - var_10_2 * 1

		self.roomListObj[2]:setPositionY(self.roomListObj[2].full_posY)

		self.roomListObj[3].full_posY = self.roomListObj[1]:getPositionY() - var_10_2 * 2

		self.roomListObj[3]:setPositionY(self.roomListObj[3].full_posY)
	end)()
	self:initCloneRoom()
end

function SchoolArchivesLayer:initCloneRoom()
	local var_11_0 = (GameDisplay.height - self.bottomList:getContentSize().height) / 4 + 10

	self.cloneRooms = {}

	local var_11_3 = self.roomListObj[4]:getPositionY() - self.room_distance

	for iter_11_0 = 1, 4 do
		local var_11_4 = ccui.ImageView:create("room_widget/room_bg_margin.png", var_0_4)

		var_11_4:setPosition(320, var_11_3 - (iter_11_0 - 1) * self.room_distance)
		self.rootLayer:addChild(var_11_4)

		local var_11_5 = var_11_4:getContentSize().width / 2
		local var_11_6 = var_11_4:getContentSize().height / 2
		local var_11_7 = ccui.ImageView:create("room_widget/door_L.png", var_0_4)

		var_11_7:setPosition(var_11_5, var_11_6)
		var_11_4:addChild(var_11_7)

		local var_11_8 = ccui.ImageView:create("room_widget/door_R.png", var_0_4)

		var_11_8:setPosition(var_11_5, var_11_6)
		var_11_4:addChild(var_11_8)

		self.cloneRooms[iter_11_0] = var_11_4

		var_11_4:setVisible(false)
	end
end

function SchoolArchivesLayer:registeTouchEvent()
	local var_12_0 = ccui.Layout:create()

	var_12_0:setContentSize(cc.size(640, 1136))
	var_12_0:setTouchEnabled(false)
	self:addChild(var_12_0, 999)

	listener = cc.EventListenerTouchOneByOne:create()

	listener:setSwallowTouches(false)
	listener:registerScriptHandler(function(arg_13_0, arg_13_1)
		if LayerManager:getCurrentLayerName() ~= "SchoolArchivesLayer" then
			return false
		end

		if self.wheelPanel.action_state == "running" then
			return false
		end

		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(function(arg_14_0, arg_14_1)
		local var_14_0 = var_12_0:convertToNodeSpace(arg_14_0:getStartLocation())
		local var_14_1 = var_12_0:convertToNodeSpace(arg_14_0:getLocation())

		if var_14_1.y - var_14_0.y > 200 then
			self:switchGroup("up")
		elseif var_14_1.y - var_14_0.y < -200 then
			self:switchGroup("down")
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, var_12_0)
end

function SchoolArchivesLayer:initWheel()
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

	local var_15_0 = {
		181,
		134,
		79,
		24,
		-23
	}
	local var_15_1 = {
		0.5,
		0.7,
		1,
		0.7,
		0.5
	}

	self.wheelTiles = {}

	for iter_15_0 = 1, 4 do
		local var_15_2 = self.wheelTile:clone()

		self.wheelPanel:addChild(var_15_2)
		var_15_2:setVisible(false)

		self.wheelTiles[iter_15_0] = var_15_2
	end

	if self.curFloorIndex == 1 then
		self.arrowUp:setOpacity(100)
	elseif self.curFloorIndex == self.maxLabRoomNum / 4 then
		self.arrowDown:setOpacity(100)
	end

	local function var_15_3(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
		arg_16_0:setPositionY(var_15_0[arg_16_1])
		arg_16_0:setScale(var_15_1[arg_16_1])
		arg_16_0:setVisible(true)
		arg_16_0:getChildByName("Image_num"):loadTexture(arg_16_2, var_0_4)
	end

	local function var_15_4()
		for iter_17_0, iter_17_1 in pairs(self.wheelTiles) do
			iter_17_1:setVisible(false)
		end

		if self.curFloorIndex == 1 then
			var_15_3(self.wheelTiles[1], 3, "room_widget/num_1.png")
			var_15_3(self.wheelTiles[2], 4, "room_widget/num_2.png")
			var_15_3(self.wheelTiles[3], 5, "room_widget/num_3.png")
		elseif self.curFloorIndex == self.maxLabRoomNum / 4 then
			var_15_3(self.wheelTiles[1], 1, "room_widget/num_" .. self.maxLabRoomNum / 4 - 2 .. ".png")
			var_15_3(self.wheelTiles[2], 2, "room_widget/num_" .. self.maxLabRoomNum / 4 - 1 .. ".png")
			var_15_3(self.wheelTiles[3], 3, "room_widget/num_" .. self.maxLabRoomNum / 4 .. ".png")
		else
			var_15_3(self.wheelTiles[1], 2, "room_widget/num_" .. self.curFloorIndex - 1 .. ".png")
			var_15_3(self.wheelTiles[2], 3, "room_widget/num_" .. self.curFloorIndex .. ".png")
			var_15_3(self.wheelTiles[3], 4, "room_widget/num_" .. self.curFloorIndex + 1 .. ".png")
		end
	end

	local function var_15_5()
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

	var_15_4()
	var_15_5()
	self:updateWheelTiles()

	function self.wheelPanel.changeAction(arg_19_0)
		if self.curFloorIndex == 1 then
			self.arrowUp:setOpacity(100)
		elseif self.curFloorIndex == self.maxLabRoomNum / 4 then
			self.arrowDown:setOpacity(100)
		else
			self.arrowUp:setOpacity(255)
			self.arrowDown:setOpacity(255)
		end

		local function var_19_0(arg_20_0, arg_20_1)
			arg_20_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.Spawn:create(cc.MoveTo:create(0.8, cc.p(arg_20_0:getPositionX(), var_15_0[arg_20_1])), cc.ScaleTo:create(0.8, var_15_1[arg_20_1])), cc.CallFunc:create(var_15_4)))
		end

		if arg_19_0 == "up" then
			if self.curFloorIndex ~= self.maxLabRoomNum / 4 then
				var_15_3(self.wheelTiles[4], 5, "room_widget/num_" .. self.curFloorIndex + 1 .. ".png", self.curFloorIndex + 1)
			end

			if self.curFloorIndex == 2 then
				var_19_0(self.wheelTiles[4], 5)
				var_19_0(self.wheelTiles[3], 4)
				var_19_0(self.wheelTiles[2], 3)
				var_19_0(self.wheelTiles[1], 2)
			else
				var_19_0(self.wheelTiles[4], 4)
				var_19_0(self.wheelTiles[3], 3)
				var_19_0(self.wheelTiles[2], 2)
				var_19_0(self.wheelTiles[1], 1)
			end
		elseif arg_19_0 == "down" then
			if self.curFloorIndex ~= 1 then
				var_15_3(self.wheelTiles[4], 1, "room_widget/num_" .. self.curFloorIndex - 1 .. ".png", self.curFloorIndex - 1)
			end

			if self.curFloorIndex == self.maxLabRoomNum / 4 - 1 then
				var_19_0(self.wheelTiles[4], 1)
				var_19_0(self.wheelTiles[3], 4)
				var_19_0(self.wheelTiles[2], 3)
				var_19_0(self.wheelTiles[1], 2)
			else
				var_19_0(self.wheelTiles[4], 2)
				var_19_0(self.wheelTiles[3], 5)
				var_19_0(self.wheelTiles[2], 4)
				var_19_0(self.wheelTiles[1], 3)
			end
		end

		self.wheelPanel:runAction(cc.Sequence:create(cc.DelayTime:create(1.1), cc.CallFunc:create(function()
			var_15_5()
			self:updateWheelTiles()
		end)))
	end

	self.arrowUp:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_22_0:getOpacity() ~= 255 then
			return
		end

		self:switchGroup("down")
	end)
	self.arrowDown:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_23_0:getOpacity() ~= 255 then
			return
		end

		self:switchGroup("up")
	end)
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

	if self.maxLabRoomNum <= 4 then
		self.wheelPanel:setVisible(false)
		self.arrowUp:setVisible(false)
		self.arrowDown:setVisible(false)
	end
end

function SchoolArchivesLayer:switchGroup(arg_26_1)
	if self.wheelPanel.action_state == "running" then
		return
	end

	self.wheelPanel.action_state = "running"

	if arg_26_1 == "up" then
		if self.curFloorIndex == self.maxLabRoomNum / 4 then
			self.wheelPanel.action_state = nil

			return
		end

		self.curFloorIndex = self.curFloorIndex + 1
	elseif arg_26_1 == "down" then
		if self.curFloorIndex == 1 then
			self.wheelPanel.action_state = nil

			return
		end

		self.curFloorIndex = self.curFloorIndex - 1
	end

	self:runAction(cc.Sequence:create(cc.CallFunc:create(function()
		self:doorCloseAction()
		self:roomScrollAction(arg_26_1)
		self.wheelPanel.changeAction(arg_26_1)
	end), cc.DelayTime:create(1.1), cc.CallFunc:create(function()
		self:updateRoom()
		self:doorOpenAction()

		self.wheelPanel.action_state = nil
	end)))
end

function SchoolArchivesLayer:roomScrollAction(arg_29_1)
	local var_29_0

	if arg_29_1 == "up" then
		var_29_0 = self.room_distance * 4 or -self.room_distance * 4

		if arg_29_1 == "up" then
			for iter_29_0 = 1, 4 do
				self.cloneRooms[iter_29_0]:setPositionY(self.roomListObj[4].full_posY - iter_29_0 * self.room_distance)
			end

			goto label_29_0
		end
	end

	for iter_29_1 = 1, 4 do
		self.cloneRooms[iter_29_1]:setPositionY(self.roomListObj[1].full_posY + (5 - iter_29_1) * self.room_distance)
	end

	::label_29_0::

	for iter_29_2 = 1, 4 do
		self.roomListObj[iter_29_2]:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.MoveBy:create(0.8, cc.p(0, var_29_0))))
		self.cloneRooms[iter_29_2]:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
			self.cloneRooms[iter_29_2]:setVisible(true)
		end), cc.MoveBy:create(0.8, cc.p(0, var_29_0)), cc.CallFunc:create(function()
			self.roomListObj[iter_29_2]:setPositionY(self.roomListObj[iter_29_2].full_posY)
			self.cloneRooms[iter_29_2]:setPositionY(self.roomListObj[4].full_posY - iter_29_2 * self.room_distance)
			self.cloneRooms[iter_29_2]:setVisible(false)
		end)))
	end
end

function SchoolArchivesLayer:doorCloseAction()
	for iter_32_0, iter_32_1 in ipairs(self.roomListObj) do
		ccui.Helper:seekWidgetByName(iter_32_1, "Image_doorR"):stopAllActions()
		ccui.Helper:seekWidgetByName(iter_32_1, "Image_doorL"):stopAllActions()
		ccui.Helper:seekWidgetByName(iter_32_1, "Image_doorR"):runAction(cc.Sequence:create(cc.DelayTime:create((iter_32_0 - 1) * 0.1), cc.MoveTo:create(0.3, cc.p(303, 129))))
		ccui.Helper:seekWidgetByName(iter_32_1, "Image_doorL"):runAction(cc.Sequence:create(cc.DelayTime:create((iter_32_0 - 1) * 0.1), cc.MoveTo:create(0.3, cc.p(303, 129))))
	end
end

function SchoolArchivesLayer:doorOpenAction(arg_33_1)
	local function var_33_0(arg_34_0)
		if self.roomListData[arg_34_0.index].locked then
			return false
		end

		return true
	end

	local function var_33_1(arg_35_0, arg_35_1)
		ccui.Helper:seekWidgetByName(arg_35_0, "Image_doorR"):stopAllActions()
		ccui.Helper:seekWidgetByName(arg_35_0, "Image_doorL"):stopAllActions()

		if var_33_0(arg_35_0) then
			ccui.Helper:seekWidgetByName(arg_35_0, "Image_doorR"):runAction(cc.Sequence:create(cc.DelayTime:create((arg_35_1 - 1) * 0.1), cc.MoveTo:create(0.3, cc.p(643, 129))))
			ccui.Helper:seekWidgetByName(arg_35_0, "Image_doorL"):runAction(cc.Sequence:create(cc.DelayTime:create((arg_35_1 - 1) * 0.1), cc.MoveTo:create(0.3, cc.p(-37, 129))))
		end
	end

	if arg_33_1 then
		var_33_1(self.roomListObj[arg_33_1], arg_33_1 % 4 + 1)
	else
		for iter_33_0, iter_33_1 in ipairs(self.roomListObj) do
			var_33_1(iter_33_1, iter_33_0)
		end
	end
end

function SchoolArchivesLayer:updateRoom()
	for iter_36_0 = (self.curFloorIndex - 1) * 4 + 1, self.curFloorIndex * 4 do
		self:updateRoomByRoomIndex(iter_36_0)
	end
end

function SchoolArchivesLayer:updateRoomByRoomIndex(arg_37_1)
	local var_37_0 = self.roomListObj[arg_37_1 - (self.curFloorIndex - 1) * 4]

	var_37_0.index = arg_37_1

	if self.roomListData[arg_37_1].locked == false then
		ccui.Helper:seekWidgetByName(var_37_0, "Panel_lockTouch"):setVisible(false)
		ccui.Helper:seekWidgetByName(var_37_0, "Panel_show"):setVisible(true)
		ccui.Helper:seekWidgetByName(var_37_0, "Panel_show"):addTouchEventListener(function(arg_38_0, arg_38_1)
			if arg_38_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_37_1 == 1 then
				LayerManager:switchShowLayer("SchoolFileLayer")
			elseif arg_37_1 == 2 then
				LayerManager:switchShowLayer("SchoolCinemaLayer")
			end
		end)
	elseif self.roomListData[arg_37_1].locked == true then
		ccui.Helper:seekWidgetByName(var_37_0, "Panel_lockTouch"):setVisible(true)
		ccui.Helper:seekWidgetByName(var_37_0, "Panel_show"):setVisible(false)
	end

	ccui.Helper:seekWidgetByName(var_37_0, "Label_order"):setString(string.format("%2d", arg_37_1))
	ccui.Helper:seekWidgetByName(var_37_0, "Label_str"):setString((self.roomListData[arg_37_1].roomName or nil) and (self.roomListData[arg_37_1].roomName or ""))
	ccui.Helper:seekWidgetByName(var_37_0, "Image_roomBg"):loadTexture(var_0_2[(arg_37_1 - 1) % 3 + 1])
end

function SchoolArchivesLayer.returnEvent(arg_39_0)
	KeyCodeManager:onKeyReleasedCallFunc()
end

function SchoolArchivesLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_41_0, arg_41_1)
		if arg_41_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:returnEvent()
	end, conf)

	self.bottomList:setPositionY(-GameDisplay.fix_y)
	self.bottomList:setName("bottomlist")
	self:addChild(self.bottomList, 1000)
end

function SchoolArchivesLayer.updateWheelTiles(arg_42_0)
	return
end
