DormitoryLayer = class("DormitoryLayer", (require("view.Layer.BaseUILayer")))

local var_0_0 = math
local var_0_1 = global_get_time_by_second
local var_0_2 = math.abs
local dormitory_manager = require("controller.dormitory_manager")
local audio_manager = require("controller.audio_manager")
local friend_system_manager = require("controller.friend_system_manager")
local theater_director = require("controller.theater_director")
local playermodel = require("model.playermodel")
local hexie_manager = require("controller.hexie_manager")
local texture_manager = require("controller.texture_manager")
local major_factor_data = require("data.major_factor_data")
local dorm_script_class_data = require("data.dorm_script_class_data")
local item_data = require("data.item_data")
local travel_conversation_data = require("data.travel_conversation_data")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local TempWidget = require("view.Sprite.TempWidget")
local QuickCell = require("view.Sprite.QuickCell")
local var_0_18 = config._DEBUG and 0 or 1
local var_0_20 = GameDisplay.width
local var_0_21 = 210
local var_0_22 = -0
local var_0_24 = 0.86
local var_0_25 = 0
local var_0_26 = -8
local var_0_27 = "Dormitory/"
local var_0_28 = "room_widget/"
local var_0_29 = "DormQuickList/"
local var_0_30 = 150
local var_0_31 = 150 + 80
local var_0_32 = 99
local var_0_33 = 20
local var_0_34 = 0.02
local var_0_35 = {
	SETTLE_IN = 4,
	TRAVEL = 5,
	NOTHING = 6,
	MOVE_AWAY = 3,
	RENOVATION = 2,
	LEAVE = 1
}
local var_0_36 = {
	PLOT = 4,
	NOUSED = 8,
	BUILDED = 12,
	BUILDING = 11,
	EXPLORING = 5,
	NEXTLOCK = 10,
	LOCK = 1,
	ATHOME = 3,
	LIVE = 7,
	TRAVELBACK = 6,
	UNLOCK = 2
}
local var_0_38 = {
	NORMAL = 1,
	MOVE_AWAY = 3,
	DECORATION = 2
}
local var_0_39 = {
	DECORATION_BED = 3,
	DECORATION_BOX = 2,
	DECORATION_BG = 1,
	DECORATION_BOX_BACK = 4,
	DECORATION_WINDOWS = 5
}
local var_0_40 = {
	RIGHT = 2,
	NULL = 0,
	LEFT = 1
}
local var_0_41

function DormitoryLayer:ctor()
	DormitoryLayer.super.ctor(self)
	self:setAutoAdapt(true)
	self:associatedManager(dormitory_manager)

	self.selectType = var_0_38.NORMAL
	self.buildingId = 1
	self.bInitOver = false
	self.initPro = {}
	self.bInit = false
end

function DormitoryLayer.getInstance()
	return var_0_41
end

function DormitoryLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = DormitoryLayer.new(arg_3_1)

	if var_3_0 and var_3_0:init(arg_3_1) then
		return var_3_0
	end

	return nil
end

function DormitoryLayer.onEnter(arg_4_0)
	DormitoryLayer.super.onEnter(arg_4_0)

	var_0_41 = arg_4_0
end

function DormitoryLayer.onExit(arg_5_0)
	DormitoryLayer.super.onExit(arg_5_0)

	var_0_41 = nil

	texture_manager:removeUnusedSpineTextures()
end

function DormitoryLayer:init(arg_6_1)
	self:initLayer(arg_6_1)
	self:initListener()

	return true
end

function DormitoryLayer:initLayer()
	self._root = TempWidget:CreateTempLayout()

	self._root:setContentSize(GameDisplay.getUiScreenSize())
	self:addChild(self._root)

	self.textureDetection = cc.Node:create()

	self._root:addChild(self.textureDetection)

	local var_7_0 = TempWidget:CreateTempListView()

	var_7_0:setContentSize(cc.size(self._root:size().w, self._root:size().h - var_0_31))
	var_7_0:move(0, var_0_30)
	var_7_0:setClippingEnabled(false)

	self.listView = var_7_0

	self._root:addChild(var_7_0)

	local var_7_1 = TempWidget:CreateTempImg(var_0_27 .. "title_bg.png", self._root)

	var_7_1:align(cc.p(0.5, 1), self._root:size().w / 2, self._root:size().h)

	self.titleBg = var_7_1

	self:initTouchMoveLayout()
	self:initDoorLayout()
	dormitory_manager:init(function(arg_8_0)
		if not var_0_41 then
			return
		end

		self.bInit = true
		self.roomInfos = arg_8_0.infos
		self.buildingId = 1

		self:initTimer()
		self:initListView()
		self:delayShowOpenDoorLayout()
		self:initSelectTypeBtn()
		self:initBuildingBtn()
		self:initTopShieldingLayout()
		self:updateRed()
	end)
end

function DormitoryLayer:initSelectTypeBtn()
	local var_9_1 = TempWidget:CreateTempBtn(var_0_27 .. "move_away_bnt.png", self.titleBg)

	var_9_1:align(cc.p(0, 0.5), 0, self.titleBg:size().h / 2)
	var_9_1:_addEvent(function()
		self.selectType = self.selectType ~= var_0_38.MOVE_AWAY and var_0_38.MOVE_AWAY or var_0_38.NORMAL

		self:updateSelectType()
	end)

	self.moveAwayBtn = var_9_1

	local var_9_2 = TempWidget:CreateTempBtn(var_0_27 .. "random_visit_btn.png", self.titleBg)

	var_9_2:align(cc.p(1, 0.5), self.titleBg:size().w, self.titleBg:size().h / 2)
	var_9_2:_addEvent(function(arg_11_0)
		arg_11_0:setTouchEnabled(false)
		performWithDelay(arg_11_0, function()
			arg_11_0:setTouchEnabled(true)
		end, 2)
		friend_system_manager:randomVisitDorm(function(arg_13_0)
			if arg_13_0.result == 1 then
				LayerManager:pushInLayer("DormVisitLayer", {
					name = arg_13_0.name,
					msg = arg_13_0,
					playerid = arg_13_0.playerid,
					faceid = arg_13_0.head_sculpture
				})
			end
		end)
	end)

	self.visitBtn = var_9_2

	self.visitBtn:setVisible(hexie_manager:canShowDormVisit())

	local var_9_3 = TempWidget:CreateTempBtn(var_0_27 .. "costume_room_btn.png", self.titleBg)

	var_9_3:setVisible(hexie_manager:canShowCostumeBtn())
	var_9_3:align(cc.p(0, 0.5), var_9_2:pos().x - var_9_2:size().w - var_9_3:size().w, self.titleBg:size().h / 2)
	var_9_3:_addEvent(function()
		LayerManager:switchShowLayer("CostumeRoomLayer")
	end, {
		touchDelay = 1
	})

	self.skinBtn = var_9_3

	var_9_3:setVisible(not hexie_manager:isChannelInShenheTime())

	local var_9_4 = TempWidget:CreateTempImg("public/reddot/reddot2.png", var_9_3)

	var_9_4:align(cc.p(1, 0.5), var_9_3:size().w, var_9_3:size().h / 2 + 20)
	var_9_4:hide()

	self.skinBtnRedImg = var_9_4

	local var_9_5 = TempWidget:CreateTempBtn(var_0_27 .. "reward_btn.png", self.titleBg)

	var_9_5:align(cc.p(1, 0.5), var_9_3:pos().x - 10, var_9_3:pos().y)
	var_9_5:_addEvent(function()
		LayerManager:pushInLayer("CostumeRoomRewardLayer")
	end)

	local var_9_6 = TempWidget:CreateTempImg("public/reddot/reddot2.png", var_9_5)

	var_9_6:align(cc.p(1, 0.5), var_9_5:size().w + 15, var_9_5:size().h / 2)

	self.rewardLayerBtnRedImg = var_9_6
end

function DormitoryLayer:initTopShieldingLayout()
	local var_16_0 = TempWidget:CreateTempLayout(self._root)

	var_16_0:setLocalZOrder(var_0_32)
	var_16_0:setContentSize(self._root:size())
	var_16_0:_addEvent(function()
		return
	end)
	var_16_0:hide()

	self.topShieldingLayout = var_16_0
end

function DormitoryLayer:initTimer()
	local var_18_0 = 0

	self:onUpdate(function(arg_19_0)
		var_18_0 = var_18_0 + arg_19_0

		if var_18_0 >= 1 then
			var_18_0 = 0

			for iter_19_0, iter_19_1 in ipairs(self.roomInfos) do
				if iter_19_1.state == var_0_36.BUILDING and iter_19_1.last_time > 0 then
					iter_19_1.last_time = iter_19_1.last_time - 1

					if iter_19_1.last_time <= 0 then
						iter_19_1.last_time = 0
					end
				end
			end
		end
	end)
end

function DormitoryLayer:createCell(arg_20_1)
	local var_20_0 = TempWidget:CreateTempLayout()

	var_20_0:setContentSize(cc.size(var_0_20, var_0_21))
	var_20_0:setName("posLayout")

	var_20_0._childData = {}
	var_20_0._childData.director = nil

	local var_20_1 = TempWidget:CreateTempLayout(var_20_0)

	var_20_1:setContentSize(cc.size(var_0_20, var_0_21))
	var_20_1:move(0, var_0_22)

	local var_20_2 = TempWidget:CreateTempLayout(var_20_1)

	var_20_2:setContentSize(var_20_1:size())
	var_20_2:hide()

	var_20_0._childData.bgLayout = var_20_2

	local var_20_3 = TempWidget:CreateTempImg(var_0_27 .. "lock.png", var_20_2)

	var_20_3:setName("lockBg")
	var_20_3:move(var_20_2:size().w / 2, var_20_2:size().h / 2)

	local var_20_4 = TempWidget:CreateTempLayout(var_20_1)

	var_20_4:setContentSize(var_20_1:size())
	var_20_4:hide()
	var_20_4:_addEvent(function()
		self:roomDisplayClick(arg_20_1)
	end)

	var_20_0._childData.superRoomDisplayLayout = var_20_4
	var_20_4._childData = {}

	local var_20_5 = TempWidget:CreateTempLayout(var_20_4)

	var_20_5:setContentSize(var_20_4:size())

	if arg_20_1 % var_0_33 == 1 then
		var_20_5:setContentSize(cc.size(var_20_4:size().w, var_20_4:size().h - var_0_22))
	end

	var_20_5:move(0, 0)
	var_20_5:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_20_5:setBackGroundColor(cc.c3b(0, 0, 0))
	var_20_5:setOpacity(180)
	var_20_5:hide()
	self:initSelectTipsLayoutVisible(var_20_5, arg_20_1)

	var_20_0._childData.selectTipsLayout = var_20_5

	local var_20_6 = TempWidget:CreateTempLayout(var_20_4)

	var_20_6:setContentSize(var_20_1:size())
	var_20_6:setScale(var_0_24)
	var_20_6:align(cc.p(0, 0.5), var_0_25, var_20_1:size().h / 2 + var_0_26)

	var_20_0._childData.roomDisplayLayout = var_20_6

	local var_20_7 = TempWidget:CreateTempLayout(var_20_6)

	var_20_7:setContentSize(cc.size(var_20_6:size().w - 35, 260))
	var_20_7:align(cc.p(0, 0), var_20_6:size().w / 2 - var_20_7:size().w / 2, var_20_6:size().h / 2 - var_20_7:size().h / 2)

	var_20_7._childData = {}
	var_20_0._childData.roomDisplayDecorationLayout = var_20_7
	var_20_7._childData[var_0_39.DECORATION_BG] = nil
	var_20_7._childData[var_0_39.DECORATION_BOX] = nil
	var_20_7._childData[var_0_39.DECORATION_BED] = nil
	var_20_7._childData[var_0_39.DECORATION_BOX_BACK] = nil
	var_20_7._childData[var_0_39.DECORATION_WINDOWS] = nil
	var_20_7._childData.smallDoor = nil
	var_20_7._childData.smallDoorSpine = nil
	var_20_7._childData.furnitureSpine = {
		[var_0_39.DECORATION_BG] = nil,
		[var_0_39.DECORATION_BOX] = nil,
		[var_0_39.DECORATION_BED] = nil,
		[var_0_39.DECORATION_BOX_BACK] = nil,
		[var_0_39.DECORATION_WINDOWS] = nil
	}

	local var_20_8 = TempWidget:CreateTempLayout(var_20_6)

	var_20_8:setContentSize(cc.size(580, 259))
	var_20_8:setClippingEnabled(true)
	var_20_8:align(cc.p(0.5, 0.5), var_20_6:size().w / 2, var_20_6:size().h / 2)

	var_20_0._childData.roomDisplayRoleLayout = var_20_8

	local var_20_9 = TempWidget:CreateTempImg(var_0_27 .. "renovation_leftTop.png", var_20_6)

	var_20_9:setScale(1.2)
	var_20_9:align(cc.p(0, 1), 30, var_20_6:size().h + 12)
	var_20_9:_addEvent(function(arg_22_0)
		self.selectType = var_0_38.NORMAL

		self:updateSelectType()
		self:decorationRoom(arg_20_1)
	end)

	local var_20_10 = cc.Node:create()

	var_20_10:setName("directInitNode" .. arg_20_1)
	var_20_8:addChild(var_20_10)

	var_20_0._childData.directInitNode = var_20_10

	local var_20_11 = TempWidget:CreateTempLayout(var_20_0)

	var_20_11:setContentSize(var_20_0:size())

	var_20_0._childData.stateLayout = var_20_11

	local var_20_12 = TempWidget:CreateTempLayout(var_20_1)

	var_20_12:setClippingEnabled(true)
	var_20_12:setContentSize(var_20_1:size())

	var_20_0._childData.doorLayout = var_20_12

	local var_20_13 = TempWidget:CreateTempLayout(var_20_12)

	var_20_13:setContentSize(var_20_12:size())
	var_20_13:hide()
	var_20_13:_addEvent(function()
		self:quickUnlockRoomClick(arg_20_1)
	end)

	var_20_0._childData.remainBuildingLayout = var_20_13

	local var_20_14 = TempWidget:CreateTempImg(var_0_28 .. "building.png", var_20_13)

	var_20_14:move(var_20_13:size().w / 2, var_20_13:size().h / 2)

	local var_20_15 = TempWidget:CreateTempLabel("", FONT_DES, 24, var_20_14)

	var_20_15:_setColor("#636370")
	var_20_15:move(var_20_14:size().w / 2 + 20, var_20_14:size().h / 2 - 20)

	var_20_0._childData.remainTimeText = var_20_15

	local var_20_16 = TempWidget:CreateTempImg(var_0_28 .. "img_clock.png", var_20_14)

	var_20_16:setColor(cc.c3b(99, 99, 112))
	var_20_16:move(75, var_20_15:getPositionY())

	local var_20_17 = TempWidget:CreateTempLayout(var_20_12)

	var_20_17:setContentSize(var_20_12:size())
	var_20_17:hide()
	var_20_17:_addEvent(function()
		self:buildCompleteClick(arg_20_1)
	end)

	var_20_0._childData.buildCompleteLayout = var_20_17

	TempWidget:CreateTempImg(var_0_28 .. "finish.png", var_20_17):move(var_20_17:size().w / 2, var_20_17:size().h / 2)

	local var_20_18 = TempWidget:CreateTempLayout(var_20_12)

	var_20_18:setContentSize(var_20_12:size())
	var_20_18:hide()
	var_20_18:_addEvent(function()
		self:unLockClick(arg_20_1)
	end)

	var_20_0._childData.nextUnlockLayout = var_20_18

	TempWidget:CreateTempImg(var_0_28 .. "unlock.png", var_20_18):move(var_20_18:size().w / 2, var_20_18:size().h / 2)

	local var_20_19 = TempWidget:CreateTempLayout(var_20_1)

	var_20_19:setContentSize(var_20_1:size())

	if arg_20_1 % var_0_33 == 1 then
		var_20_19:setContentSize(cc.size(var_20_1:size().w, var_20_1:size().h - var_0_22))
	end

	var_20_19:move(0, 0)
	var_20_19:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_20_19:setBackGroundColor(cc.c3b(0, 0, 0))
	var_20_19:setOpacity(180)
	var_20_19:hide()
	var_20_19:_addEvent(function()
		self.selectType = var_0_38.NORMAL

		self:updateSelectType()
	end)
	self:initShieldingLayoutVisible(var_20_19, arg_20_1)

	var_20_0._childData.shieldingLayout = var_20_19

	if self.roomInfos[arg_20_1] then
		if var_0_36.UNLOCK == self.roomInfos[arg_20_1].state then
			var_20_4:show()
			self:initRoomDisplayLayout(var_20_0._childData, arg_20_1)
		elseif var_0_36.LOCK == self.roomInfos[arg_20_1].state then
			self:initStateLayout(var_20_0._childData, arg_20_1)
			var_20_2:show()
		elseif var_0_36.BUILDING == self.roomInfos[arg_20_1].state then
			var_20_13:show()
			self:startBuildingRemain(var_20_0._childData, arg_20_1)
			self:initStateLayout(var_20_0._childData, arg_20_1)
			var_20_2:show()
		elseif var_0_36.BUILDED == self.roomInfos[arg_20_1].state then
			self:showBuildCompleteLayout(var_20_0._childData)
			self:initStateLayout(var_20_0._childData, arg_20_1)
			var_20_2:show()
		elseif var_0_36.ATHOME == self.roomInfos[arg_20_1].state then
			var_20_4:show()
			self:initRoomDisplayLayout(var_20_0._childData, arg_20_1)
		elseif var_0_36.TRAVELBACK == self.roomInfos[arg_20_1].state then
			var_20_4:show()
			self:initRoomDisplayLayout(var_20_0._childData, arg_20_1)
		elseif var_0_36.PLOT == self.roomInfos[arg_20_1].state then
			var_20_4:show()
			self:initRoomDisplayLayout(var_20_0._childData, arg_20_1)
		elseif var_0_36.NEXTLOCK == self.roomInfos[arg_20_1].state then
			var_20_18:show()
			self:initStateLayout(var_20_0._childData, arg_20_1)
			var_20_2:show()
		end
	end

	return var_20_0
end

function DormitoryLayer.initListener(arg_27_0)
	return
end

function DormitoryLayer:initSelectTipsLayoutVisible(arg_28_1, arg_28_2)
	arg_28_1:hide()

	if self.roomInfos[arg_28_2] and self.selectType ~= var_0_38.NORMAL and self.roomInfos[arg_28_2].state == var_0_36.ATHOME then
		arg_28_1:show()
	end
end

function DormitoryLayer:initShieldingLayoutVisible(arg_29_1, arg_29_2)
	arg_29_1:hide()

	if self.roomInfos[arg_29_2] then
		if self.selectType == var_0_38.MOVE_AWAY then
			if self.roomInfos[arg_29_2].state ~= var_0_36.ATHOME then
				arg_29_1:show()
			end
		elseif self.selectType == var_0_38.DECORATION and self.roomInfos[arg_29_2].state ~= var_0_36.ATHOME and self.roomInfos[arg_29_2].state ~= var_0_36.TRAVELBACK and self.roomInfos[arg_29_2].state ~= var_0_36.PLOT and self.roomInfos[arg_29_2].state ~= var_0_36.UNLOCK then
			arg_29_1:show()
		end
	end
end

function DormitoryLayer:initTouchMoveLayout()
	local var_30_0 = TempWidget:CreateTempLayout(self._root)

	var_30_0:setLocalZOrder(var_0_32)
	var_30_0:setContentSize(self._root:size())

	local var_30_1
	local var_30_2 = cc.EventListenerTouchOneByOne:create()

	var_30_2:registerScriptHandler(function(arg_31_0, arg_31_1)
		var_30_1 = arg_31_0:getLocation()

		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_30_2:registerScriptHandler(function(arg_32_0, arg_32_1)
		return
	end, cc.Handler.EVENT_TOUCH_MOVED)
	var_30_2:registerScriptHandler(function(arg_33_0, arg_33_1)
		local var_33_0 = arg_33_0:getLocation()

		if var_0_2(var_33_0.y - var_30_1.y) >= 100 then
			return false
		end

		if self.selectType == var_0_38.NORMAL then
			if var_33_0.x - var_30_1.x > 200 then
				if self.buildingId > 1 then
					print("右移")
					self:moveRight()
				end
			elseif var_33_0.x - var_30_1.x < -200 and self.buildingId < #self.roomInfos / var_0_33 then
				print("左移")
				self:moveLeft()
			end
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	var_30_2:setSwallowTouches(false)
	var_30_0:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_30_2, var_30_0)
end

function DormitoryLayer:initDoorLayout()
	local var_34_0 = TempWidget:CreateTempLayout()

	var_34_0:setContentSize(GameDisplay.size)
	var_34_0:move(0, 0)
	var_34_0:_addEvent(function()
		return
	end)
	var_34_0:hide()
	self._root:addChild(var_34_0, 999)

	self.listViewDoorLayout = var_34_0

	local var_34_1 = TempWidget:CreateTempImg(var_0_27 .. "door_left.png", var_34_0)

	var_34_1:align(cc.p(0, 0.5), 0, var_34_0:size().h / 2)

	var_34_0._leftDoorImg = var_34_1

	local var_34_2 = TempWidget:CreateTempImg(var_0_27 .. "door_right.png", var_34_0)

	var_34_2:align(cc.p(1, 0.5), var_34_0:size().w, var_34_0:size().h / 2)

	var_34_0._rightDoorImg = var_34_2

	local var_34_3 = TempWidget:CreateTempLayout()

	var_34_3:_addEvent(function()
		return
	end)
	var_34_3:hide()
	var_34_3:setContentSize(GameDisplay.size)
	var_34_3:move(GameDisplay.width, 100)
	self._root:addChild(var_34_3, 999)

	self.defaultDoorLayout = var_34_3

	local var_34_4 = TempWidget:CreateTempImg(var_0_27 .. "door_left.png", var_34_3)

	var_34_4:align(cc.p(0, 0.5), 0, var_34_3:size().h / 2)

	var_34_3._leftDoorImg = var_34_4

	local var_34_5 = TempWidget:CreateTempImg(var_0_27 .. "door_right.png", var_34_3)

	var_34_5:align(cc.p(1, 0.5), var_34_3:size().w, var_34_3:size().h / 2)

	var_34_3._rightDoorImg = var_34_5
end

function DormitoryLayer:delayShowOpenDoorLayout()
	local var_37_0 = self.listViewDoorLayout
	local var_37_2 = 0

	self.listViewDoorLayout:show()
	self.listViewDoorLayout:stopAllActions()
	self.listViewDoorLayout._leftDoorImg:stopAllActions()
	self.listViewDoorLayout._rightDoorImg:stopAllActions()
	self.listViewDoorLayout._leftDoorImg:align(cc.p(0, 0.5), 0, self.listViewDoorLayout:size().h / 2)
	self.listViewDoorLayout._rightDoorImg:align(cc.p(1, 0.5), self.listViewDoorLayout:size().w, self.listViewDoorLayout:size().h / 2)

	local var_37_3 = 0

	schedule(self.listViewDoorLayout, function()
		var_37_3 = var_37_3 + 1

		if self.bInitOver or var_37_3 > 60 then
			var_37_0._leftDoorImg:runAction(cc.Sequence:create(cc.MoveBy:create(0.5, cc.p(-var_37_0._leftDoorImg:size().w, 0)), cc.CallFunc:create(function()
				var_37_2 = var_37_2 + 1

				if var_37_2 == 2 then
					var_37_0:hide()
				end
			end)))
			var_37_0._rightDoorImg:runAction(cc.Sequence:create(cc.MoveBy:create(0.5, cc.p(var_37_0._rightDoorImg:size().w, 0)), cc.CallFunc:create(function()
				var_37_2 = var_37_2 + 1

				if var_37_2 == 2 then
					var_37_0:hide()
				end
			end)))
			var_37_0:stopAllActions()
		end
	end, 0.016666666666666666)
end

function DormitoryLayer:showDefaultDoorLayoutMove(arg_41_1)
	if arg_41_1 == var_0_40.LEFT then
		self.defaultDoorLayout:move(GameDisplay.width, 0)
	elseif arg_41_1 == var_0_40.RIGHT then
		self.defaultDoorLayout:move(-GameDisplay.width, 0)
	end

	local var_41_0 = 0.5

	self.defaultDoorLayout:show()
	self.defaultDoorLayout:runAction(cc.MoveTo:create(var_41_0, cc.p(0, 0)))
end

function DormitoryLayer:initBuildingBtn()
	local var_42_0 = self.listView:getLocalZOrder()
	local var_42_1 = TempWidget:CreateTempImg(var_0_27 .. "buliding_bg.png")

	var_42_1:align(cc.p(0.5, 0), GameDisplay.cx, 80)
	var_42_1:_addEvent(function()
		return
	end)
	self._root:addChild(var_42_1, var_42_0 + 1)

	local var_42_2 = TempWidget:CreateTempListView(var_42_1)

	var_42_2:setDirection(ccui.ListViewDirection.horizontal)
	var_42_2:setContentSize(cc.size(var_42_1:size().w - 130, var_42_1:size().h))
	var_42_2:move(15, 0)

	local var_42_3 = TempWidget:CreateTempBtn(var_0_27 .. "renovation_bnt.png", var_42_1)

	var_42_3:align(cc.p(1, 0), var_42_1:size().w - 10, var_42_1:size().h)
	var_42_3:hide()
	var_42_3:_addEvent(function()
		self.selectType = self.selectType ~= var_0_38.DECORATION and var_0_38.DECORATION or var_0_38.NORMAL

		self:updateSelectType()
	end)

	self.decorationBtn = var_42_3
	self.buildBtnTable = {}

	local var_42_4 = var_42_2:size().w / (#self.roomInfos / var_0_33)

	for iter_42_0 = 1, #self.roomInfos / var_0_33 do
		local var_42_5 = "buliding_btn_off" .. iter_42_0 .. ".png"

		if self.buildingId == iter_42_0 then
			var_42_5 = "buliding_btn" .. iter_42_0 .. ".png"
		end

		local var_42_6 = TempWidget:CreateTempLayout()

		var_42_6:setContentSize(cc.size(var_42_4, var_42_2:size().h))
		var_42_6:move(var_42_4 * (iter_42_0 - 1), 0)
		var_42_2:pushBackCustomItem(var_42_6)

		local var_42_7 = TempWidget:CreateTempBtn(var_0_27 .. var_42_5)

		var_42_6:addChild(var_42_7)
		var_42_7:center()
		var_42_7:_addEvent(function()
			if self.selectType == var_0_38.NORMAL and iter_42_0 ~= self.buildingId then
				if iter_42_0 < self.buildingId then
					self:moveRight(iter_42_0)
				else
					self:moveLeft(iter_42_0)
				end

				self:updateBuildingBtn()
			end
		end)
		var_42_6:_addEvent(function()
			if self.selectType == var_0_38.NORMAL and iter_42_0 ~= self.buildingId then
				if iter_42_0 < self.buildingId then
					self:moveRight(iter_42_0)
				else
					self:moveLeft(iter_42_0)
				end

				self:updateBuildingBtn()
			end
		end)

		self.buildBtnTable[iter_42_0] = var_42_7
	end

	local var_42_8 = TempWidget:CreateTempBtn(var_0_29 .. "entrance_button.png", var_42_1)

	var_42_8:setLocalZOrder(var_42_0 + 1)
	var_42_8:align(cc.p(1, 0.5), var_42_1:size().w + 10, var_42_1:size().h / 2)
	var_42_8:_addEvent(function()
		self:createQuickPopList()
	end)
end

function DormitoryLayer:updateBuildingBtn()
	for iter_48_0 = 1, #self.buildBtnTable do
		self.buildBtnTable[iter_48_0]:loadTextureNormal(var_0_27 .. ((iter_48_0 == self.buildingId or nil) and "buliding_btn" .. iter_48_0 .. ".png"), var_0_18)
	end
end

function DormitoryLayer:initListView()
	self.listView:removeAllItems()

	self.bInitOver = false
	self.initPro = {}

	for iter_49_0 = (self.buildingId - 1) * var_0_33 + 1, self.buildingId * var_0_33 do
		if playermodel.dormRoomConfig[iter_49_0].soulid and playermodel.dormRoomConfig[iter_49_0].soulid > 0 then
			self.initPro[iter_49_0] = 0
		end
	end

	if not next(self.initPro) then
		self.bInitOver = true
	end

	for iter_49_1 = (self.buildingId - 1) * var_0_33 + 1, self.buildingId * var_0_33 do
		local var_49_0 = QuickCell:Create({
			wid = var_0_20,
			hei = var_0_21,
			activeEvent = function(arg_50_0)
				return true
			end,
			tick_interval = var_0_34,
			createCell = function()
				return self:createCell(iter_49_1)
			end
		})

		var_49_0:setName("RoomCell" .. ((((self.buildingId - 1) * var_0_33 + 1) % var_0_33 == 0 or nil) and var_0_33))
		var_49_0:setVisible(false)
		performWithDelay(var_49_0, function()
			var_49_0:setVisible(true)
		end, ((iter_49_1 % var_0_33 == 0 or nil) and var_0_33) * var_0_34 / 2)
		self.listView:pushBackCustomItem(var_49_0)
	end

	self:addScrollViewBar()
	self.textureDetection:stopAllActions()
	schedule(self.textureDetection, function()
		if self.bInitOver then
			self.textureDetection:stopAllActions()
			texture_manager:removeUnusedSpineTextures()
		end
	end, 0.016666666666666666)
end

function DormitoryLayer:addScrollViewBar()
	if not self.scrollBarImg then
		local var_54_0 = TempWidget:CreateTempImg(var_0_27 .. "scrollView_bar.png", self._root)

		var_54_0:setScale9Enabled(true)
		var_54_0:setCapInsets(cc.rect(var_54_0:getContentSize().width / 2 - 1, var_54_0:getContentSize().height / 2 - 1, 2, 2))
		var_54_0:setContentSize(cc.size(5, self.listView:size().h))
		var_54_0:align(cc.p(1, 1), self._root:size().w, self.listView:pos().y + self.listView:getContentSize().height)

		self.scrollBarImg = var_54_0

		self.listView:addScrollViewEventListener(function(arg_55_0, arg_55_1)
			self:updateScrollBar()
		end)
		performWithDelay(var_54_0, handler(self, self.updateScrollBar), 0.016666666666666666)
	end
end

function DormitoryLayer:updateScrollBar()
	local var_56_0 = self.listView
	local var_56_1 = self.listView:getContentSize()
	local var_56_2 = self.scrollBarImg

	local function var_56_3()
		local var_57_0 = var_56_0:getInnerContainerPosition()
		local var_57_1 = var_56_0:getInnerContainerSize()
		local var_57_2 = var_56_1.height

		if var_57_0.y > 0 then
			var_57_2 = var_57_2 - var_57_0.y
		elseif var_57_0.y < var_56_1.height - var_57_1.height then
			var_57_2 = var_57_2 + (var_57_0.y - (var_56_1.height - var_57_1.height))
		end

		return var_57_2 / var_57_1.height * 100
	end

	;(function()
		var_56_2:setContentSize((cc.size(var_56_2:getContentSize().width, var_56_1.height * var_56_3() / 100)))
		var_56_2:setPosition((cc.p(var_56_1.width, var_56_0:pos().y + var_56_2:size().h + (var_56_1.height - var_56_2:size().h) * (100 - var_56_0:getPercent()) / 100)))
	end)()
end

function DormitoryLayer:getRewards(arg_59_1)
	if config._DEBUG and self.roomInfos[arg_59_1].conversation then
		assert(travel_conversation_data[self.roomInfos[arg_59_1].conversation * 100 + 1], "@郑佳 invalid travel conversation id: " .. self.roomInfos[arg_59_1].conversation .. "01")
	end

	local var_59_0 = self.roomInfos[arg_59_1].conversation
	local var_59_1

	dormitory_manager:gainTravelAwards(self.roomInfos[arg_59_1].soulid, function(arg_60_0, arg_60_1, arg_60_2)
		if arg_60_0 then
			var_59_1 = {
				labels = L_DORM_TOUCH_EVENT_MSG.TRAVELBACK.labels,
				items = arg_60_0,
				postcards = arg_60_1
			}
		end

		self.roomInfos[arg_59_1].state = var_0_36.ATHOME

		self:updateCell(arg_59_1, var_0_36.TRAVELBACK)

		if not var_59_0 and var_59_1 then
			if var_59_1.postcards then
				LayerManager:pushInLayer("PopGainPostcard", var_59_1)
			else
				LayerManager:pushInLayer("PopPurchaseResultLayer", var_59_1)
			end
		end
	end)

	if var_59_0 then
		global_basic_scene:addChild(TalkLayer:create(var_59_0, nil, TALK_TYPE_TRAVEL, "", function()
			if var_59_1 then
				if var_59_1.postcards then
					LayerManager:pushInLayer("PopGainPostcard", var_59_1)
				else
					LayerManager:pushInLayer("PopPurchaseResultLayer", var_59_1)
				end
			end
		end), ZORDER_TALKLAYER)
	end
end

function DormitoryLayer:levelTips(arg_62_1)
	if self.roomInfos[arg_62_1] then
		global_ShowBlockWords(major_factor_data[self.roomInfos[arg_62_1].soulid].easy_name .. L_DORM_TOUCH_EVENT_MSG.PLOT)
		LayerManager:pushInLayer("DormRoomLayer", {
			isout = true,
			soulid = self.roomInfos[arg_62_1].soulid,
			roomorder = var_0_0.ceil(arg_62_1 / 4),
			exitCallback = function()
				if var_0_41 then
					self:updateStateLayout(arg_62_1)
				end
			end,
			index = arg_62_1
		})
	end
end

function DormitoryLayer:intoRoom(arg_64_1)
	LayerManager:pushInLayer("DormRoomLayer", {
		soulid = self.roomInfos[arg_64_1].soulid,
		roomorder = var_0_0.ceil(arg_64_1 / 4),
		updateDressCallback = function()
			if var_0_41 and self.roomInfos[arg_64_1] then
				local var_65_0 = self.listView:getChildren()
				local var_65_1 = arg_64_1 % var_0_33

				if arg_64_1 % var_0_33 == 0 then
					var_65_1 = var_0_33
				end

				if var_65_0 and var_65_0[var_65_1] and var_65_0[var_65_1]:IsEnter() then
					self:removeDirector(arg_64_1)
					self:initDirector(ui_delegate(var_65_0[var_65_1]).posLayout._childData, arg_64_1)
				end
			end
		end,
		exitCallback = function()
			if var_0_41 and self.roomInfos[arg_64_1] then
				self:updateStateLayout(arg_64_1)
				self:updateRed()
			end
		end,
		index = arg_64_1
	})
end

function DormitoryLayer.selectRole(arg_67_0, arg_67_1)
	local var_67_0 = {}

	if dormitory_manager.exploreingSouls then
		for iter_67_0, iter_67_1 in pairs(dormitory_manager.exploreingSouls) do
			table.insert(var_67_0, iter_67_0)
		end
	end

	LayerManager:pushInLayer("GirlSelectLayer", {
		selectType = 3,
		sureCallBack = function(arg_68_0)
			if ListButtonLayer.getInstance() then
				ListButtonLayer.getInstance():showLayer()
			end

			dormitory_manager:settle_in(arg_68_0, arg_67_1, function(arg_69_0)
				if arg_69_0 == 1 then
					arg_67_0.roomInfos[arg_67_1].state = var_0_36.ATHOME
					arg_67_0.roomInfos[arg_67_1].soulid = arg_68_0

					arg_67_0:updateCell(arg_67_1)
				end
			end)
		end,
		exitcallback = function()
			if ListButtonLayer.getInstance() then
				ListButtonLayer.getInstance():showLayer()
			end
		end,
		outSide = var_67_0
	})
end

function DormitoryLayer:moveAwayRole(arg_71_1)
	local var_71_0 = self.roomInfos[arg_71_1]

	if self.roomInfos[arg_71_1] then
		self:moveAwayPop({
			surecallback = function()
				dormitory_manager:move_away(var_71_0.soulid, arg_71_1, function(arg_73_0)
					if arg_73_0 == 1 then
						local var_73_0 = dorm_script_class_data[var_71_0.soulid].class_move_out or (500 + var_71_0.soulid) * 1000 + 1

						self.roomInfos[arg_71_1].state = var_0_36.UNLOCK
						self.roomInfos[arg_71_1].soulid = nil

						self:showOpenSmallDoor(arg_71_1)

						local var_73_1 = self.listView:getChildren()
						local var_73_2 = arg_71_1 % var_0_33

						if arg_71_1 % var_0_33 == 0 then
							var_73_2 = var_0_33
						end

						if var_73_1 and var_73_1[var_73_2] and var_73_1[var_73_2]:IsEnter() then
							local var_73_3 = ui_delegate(var_73_1[var_73_2]).posLayout._childData

							if var_73_3.director then
								var_73_3.director:insertScript(var_73_0, function()
									self:showCloseSmallDoor(arg_71_1)
									self:updateCell(arg_71_1, var_0_36.ATHOME)
								end)
							end
						end
					end
				end)
			end,
			soulid = self.roomInfos[arg_71_1].soulid,
			roomid = arg_71_1
		})
	end
end

function DormitoryLayer:decorationRoom(arg_75_1)
	local var_75_0 = self.roomInfos[arg_75_1]

	if self.roomInfos[arg_75_1] then
		LayerManager:pushInLayer("DormitoryFixturesLayer", {
			goto_back_system_id = 700,
			itemtype = kITEM_FURNITURE,
			itemConditions = {
				roomid = arg_75_1,
				soulid = self.roomInfos[arg_75_1].soulid
			},
			usedItem = playermodel.dormRoomConfig[arg_75_1].furnitures,
			callbacklist = {
				sure = function(arg_76_0, arg_76_1)
					if arg_76_1 then
						local var_76_1
						local var_76_2 = self.listView:getChildren()
						local var_76_3 = arg_75_1 % var_0_33

						if arg_75_1 % var_0_33 == 0 then
							var_76_3 = var_0_33
						end

						if var_76_2 and var_76_2[var_76_3] and var_76_2[var_76_3]:IsEnter() then
							local var_76_4 = ui_delegate(var_76_2[var_76_3]).posLayout._childData
							local var_76_5 = var_76_4.roomDisplayRoleLayout

							dormitory_manager:changeRoomFurniture(arg_75_1, arg_76_0, function()
								var_76_1 = true
							end)

							local var_76_6 = cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
								if var_76_1 then
									self:initDecorationLayout(var_76_4, arg_75_1)

									if var_75_0.soulid and var_76_4.director then
										var_76_4.director:deleteSelf()

										var_76_4.director = theater_director.new_dorm(var_75_0.soulid, var_76_5)

										var_76_4.director:startPlay()
									end

									var_76_5:stopActionByTag(arg_75_1 * 100)
								end
							end)))

							var_76_6:setTag(arg_75_1 * 100)
							var_76_4.roomDisplayRoleLayout:runAction(var_76_6)
						end
					else
						global_ShowBlockWords(L_DORM_RENOVATION_MSG.No_Change)
					end

					if ListButtonLayer.getInstance() then
						ListButtonLayer.getInstance():showLayer()
					end
				end,
				cancelcallback = function()
					if ListButtonLayer.getInstance() then
						ListButtonLayer.getInstance():showLayer()
					end
				end
			},
			paneltype = ITEMPANEL_TYPE_DORM_FURNITURE
		})
	end
end

function DormitoryLayer:roomDisplayClick(arg_80_1)
	if self.selectType == var_0_38.NORMAL then
		if self.roomInfos[arg_80_1].state == var_0_36.UNLOCK then
			self:selectRole(arg_80_1)
		elseif self.roomInfos[arg_80_1].state == var_0_36.TRAVELBACK then
			self:getRewards(arg_80_1)
		elseif self.roomInfos[arg_80_1].state == var_0_36.PLOT then
			self:levelTips(arg_80_1)
		elseif self.roomInfos[arg_80_1].state == var_0_36.ATHOME then
			self:intoRoom(arg_80_1)
		end
	elseif self.selectType == var_0_38.MOVE_AWAY then
		self.selectType = var_0_38.NORMAL

		self:updateSelectType()
		self:moveAwayRole(arg_80_1)
	elseif self.selectType == var_0_38.DECORATION then
		self.selectType = var_0_38.NORMAL

		self:updateSelectType()
		self:decorationRoom(arg_80_1)
	end
end

function DormitoryLayer:quickUnlockRoomClick(arg_81_1)
	local var_81_0 = {
		goto_back_system_id = 700,
		sureCallback = function(arg_82_0, arg_82_1, arg_82_2)
			dormitory_manager:quick_unlock_room(arg_81_1, arg_82_0, arg_82_1, function(arg_83_0)
				if arg_83_0.time <= 0 then
					global_ShowBlockWords(L_UNLOCK_SUCCESS)

					self.roomInfos[arg_81_1].state = var_0_36.UNLOCK

					audio_manager:playeffectMusic(DORM_UNLOCK_ROOM)
					self:updateCell(arg_81_1)

					if arg_81_1 < #self.roomInfos then
						self.roomInfos[arg_81_1 + 1].state = var_0_36.NEXTLOCK

						self:updateCell(arg_81_1 + 1)
					end
				end

				if arg_82_2 then
					arg_82_2(arg_83_0.result)
				end
			end)
		end
	}

	var_81_0.surplus = self.roomInfos[arg_81_1].last_time or 0

	LayerManager:pushInLayer("PopRoomQuickFinishLayer", var_81_0)
end

function DormitoryLayer.buildCompleteClick(arg_84_0, arg_84_1)
	dormitory_manager:open_room(arg_84_1, function(arg_85_0)
		if arg_85_0.result == 1 then
			global_ShowBlockWords(L_UNLOCK_SUCCESS)

			arg_84_0.roomInfos[arg_84_1].state = var_0_36.UNLOCK

			audio_manager:playeffectMusic(DORM_UNLOCK_ROOM)
			arg_84_0:updateCell(arg_84_1)

			if arg_84_1 < #arg_84_0.roomInfos then
				arg_84_0.roomInfos[arg_84_1 + 1].state = var_0_36.NEXTLOCK

				arg_84_0:updateCell(arg_84_1 + 1)
			end
		end
	end)
end

function DormitoryLayer.unLockClick(arg_86_0, arg_86_1)
	LayerManager:pushInLayer("PopUnlockDormRoomLayer", {
		goto_back_system_id = 700,
		roomid = arg_86_1,
		sureCallback = function(arg_87_0)
			dormitory_manager:unlock_room(arg_86_1, function()
				global_ShowBlockWords(L_DORM_TOUCH_EVENT_MSG.BUILDING)

				arg_86_0.roomInfos[arg_86_1].state = var_0_36.BUILDING

				arg_86_0:updateCell(arg_86_1)

				if arg_87_0 then
					arg_87_0(1)
				end
			end)
		end
	})
end

function DormitoryLayer:showOpenSmallDoor(arg_89_1)
	local var_89_0 = self.listView:getChildren()
	local var_89_1 = arg_89_1 % var_0_33

	if arg_89_1 % var_0_33 == 0 then
		var_89_1 = var_0_33
	end

	if var_89_0 and var_89_0[var_89_1] and var_89_0[var_89_1]:IsEnter() and self.roomInfos[arg_89_1] then
		local var_89_2 = ui_delegate(var_89_0[var_89_1]).posLayout._childData.roomDisplayDecorationLayout

		if var_89_2._childData.smallDoor and var_89_2._childData.smallDoor:isVisible() then
			var_89_2._childData.smallDoor:stopAllActions()
			var_89_2._childData.smallDoor:runAction(cc.ScaleTo:create(0.2, 0, 1))
		end

		if var_89_2._childData.smallDoorSpine and var_89_2._childData.smallDoorSpine:isVisible() then
			var_89_2._childData.smallDoorSpine:stopAllActions()
			var_89_2._childData.smallDoorSpine:runAction(cc.ScaleTo:create(0.2, 0, 1))
		end
	end
end

function DormitoryLayer:showCloseSmallDoor(arg_90_1)
	local var_90_0 = self.listView:getChildren()
	local var_90_1 = arg_90_1 % var_0_33

	if arg_90_1 % var_0_33 == 0 then
		var_90_1 = var_0_33
	end

	if var_90_0 and var_90_0[var_90_1] and var_90_0[var_90_1]:IsEnter() and self.roomInfos[arg_90_1] then
		local var_90_2 = ui_delegate(var_90_0[var_90_1]).posLayout._childData.roomDisplayDecorationLayout

		if var_90_2._childData.smallDoor and var_90_2._childData.smallDoor:isVisible() then
			var_90_2._childData.smallDoor:stopAllActions()
			var_90_2._childData.smallDoor:runAction(cc.ScaleTo:create(0.2, 1, 1))
		end

		if var_90_2._childData.smallDoorSpine and var_90_2._childData.smallDoorSpine:isVisible() then
			var_90_2._childData.smallDoorSpine:stopAllActions()
			var_90_2._childData.smallDoorSpine:runAction(cc.ScaleTo:create(0.2, 1, 1))
		end
	end
end

function DormitoryLayer:updateStateLayout(arg_91_1)
	local var_91_0 = self.listView:getChildren()
	local var_91_1 = arg_91_1 % var_0_33

	if arg_91_1 % var_0_33 == 0 then
		var_91_1 = var_0_33
	end

	if var_91_0 and var_91_0[var_91_1] and var_91_0[var_91_1]:IsEnter() and self.roomInfos[arg_91_1] then
		local var_91_2 = ui_delegate(var_91_0[var_91_1]).posLayout._childData

		if var_91_2.stateLayout then
			var_91_2.stateLayout:stopAllActions()
			var_91_2.stateLayout:setOpacity(255)
			var_91_2.stateLayout:runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.CallFunc:create(function()
				self:initStateLayout(var_91_2, arg_91_1)
			end), cc.FadeIn:create(0.5)))
		end
	end
end

function DormitoryLayer:initRoomDisplayLayout(arg_93_1, arg_93_2)
	if self.roomInfos[arg_93_2].state ~= var_0_36.PLOT then
		self:initDirector(arg_93_1, arg_93_2)
	end

	self:initDecorationLayout(arg_93_1, arg_93_2)
	self:initStateLayout(arg_93_1, arg_93_2)
end

function DormitoryLayer:initStateLayout(arg_94_1, arg_94_2)
	local var_94_0 = self.roomInfos[arg_94_2]
	local var_94_1 = arg_94_1.stateLayout

	arg_94_1.stateLayout:removeAllChildren()

	var_94_1._childData = {}

	local var_94_2 = TempWidget:CreateTempBtn()
	local var_94_3 = var_94_2:getVirtualRenderer()

	if var_94_0.state == var_0_36.UNLOCK then
		var_94_2:loadTextureNormal(var_0_27 .. "nobody_state_bg.png", var_0_18)
	elseif var_94_0.state == var_0_36.ATHOME then
		var_94_2:loadTextureNormal(var_0_27 .. "favour_state_bg.png", var_0_18)

		local var_94_4 = TempWidget:CreateTempImg("public/reddot/reddot2.png", var_94_2)

		var_94_4:setVisible(dormitory_manager:checkRoleSpillageFavorByIndex(arg_94_2))
		var_94_4:align(cc.p(1, 1), var_94_2:size().w - 0.5, var_94_2:size().h - 5)

		var_94_1._childData.redImg = var_94_4

		local var_94_5 = TempWidget:CreateTempLabel(playermodel.dormRoomConfig[arg_94_2].favorpool, FONT_NAME, 23, var_94_2)

		var_94_5:_setColor("e518cb")
		var_94_5:align(cc.p(0, 0), 22, 5)

		var_94_1._childData.curFavorPoolText = var_94_5

		local var_94_6 = TempWidget:CreateTempLabel("/" .. 25 + playermodel.favor[var_94_0.soulid].favorlevel * 4, FONT_NAME, 23, var_94_2)

		var_94_6:align(cc.p(0, 0), var_94_5:pos().x + var_94_5:size().w, 5)

		var_94_1._childData.curFavorPoolLimitText = var_94_6

		if var_94_0.soulid then
			local var_94_7 = TempWidget:CreateTempLabel(major_factor_data[var_94_0.soulid].easy_name, FONT_NAME, 17, var_94_3)
			local var_94_8 = {}

			for iter_94_0 in string.gmatch(major_factor_data[var_94_0.soulid].color or "229,232,241", "([^,]+)") do
				var_94_8[#var_94_8 + 1] = tonumber(iter_94_0)
			end

			var_94_7:setColor(cc.c3b(var_94_8[1], var_94_8[2], var_94_8[3]))
			var_94_7:align(cc.p(0.5, 0), var_94_2:size().w / 2, 35)
		end
	elseif var_94_0.state == var_0_36.TRAVELBACK then
		var_94_2:loadTextureNormal(var_0_27 .. "event_state_bg.png", var_0_18)
		TempWidget:CreateTempLabel("事件", FONT_DES, 24, var_94_2):align(cc.p(0, 0.5), 5, var_94_2:size().h / 2 + 20)
	end

	TempWidget:CreateTempLabel(string.format("%.2d", arg_94_2), FONT_W5, 38, var_94_3):align(cc.p(1, 0), 105, 63)
	var_94_1:setClippingEnabled(true)
	var_94_1:setLocalZOrder(6)
	var_94_1:addChild(var_94_2)
	var_94_2:align(cc.p(1, 0.5), var_94_1:size().w, var_94_1:size().h / 2)

	var_94_1._childData.bg = var_94_2

	var_94_2:_addEvent(function()
		if self.selectType == var_0_38.NORMAL then
			if self.roomInfos[arg_94_2].state == var_0_36.ATHOME then
				if dormitory_manager:checkHaveFavour() then
					self:getAllFavorFromPool()
				else
					self:pop_img()
				end
			else
				self:roomDisplayClick(arg_94_2)
			end
		else
			self:roomDisplayClick(arg_94_2)
		end
	end)
	TempWidget:CreateTempImg((var_94_0.soulid or nil) and var_0_27 .. string.format("efficient%d.png", (dormitory_manager:get_furniture_add_favor(playermodel.dormRoomConfig[arg_94_2].furnitures, var_94_0.soulid))), var_94_1):align(cc.p(0, 0.5), 0, var_94_1:size().h / 2)
end

function DormitoryLayer:initDirector(arg_96_1, arg_96_2, arg_96_3)
	if self.roomInfos[arg_96_2] then
		if self.roomInfos[arg_96_2].soulid then
			if arg_96_1.director then
				arg_96_1.director:deleteSelf()

				arg_96_1.director = nil
			end

			arg_96_1.director = theater_director.new_dorm(self.roomInfos[arg_96_2].soulid, arg_96_1.roomDisplayRoleLayout, arg_96_3)

			arg_96_1.director:startPlay()

			self.initPro[arg_96_2] = 1

			local var_96_0 = true

			for iter_96_0, iter_96_1 in pairs(self.initPro) do
				if iter_96_1 == 0 then
					var_96_0 = false

					break
				end
			end

			self.bInitOver = var_96_0
		end
	end
end

function DormitoryLayer:removeDirector(arg_97_1)
	local var_97_0 = self.listView:getChildren()
	local var_97_1 = arg_97_1 % var_0_33

	if arg_97_1 % var_0_33 == 0 then
		var_97_1 = var_0_33
	end

	if var_97_0 and var_97_0[var_97_1] and var_97_0[var_97_1]:IsEnter() and self.roomInfos[arg_97_1] then
		local var_97_2 = ui_delegate(var_97_0[var_97_1]).posLayout._childData

		if var_97_2.director then
			var_97_2.director:deleteSelf()

			var_97_2.director = nil
		end
	end
end

function DormitoryLayer.initDecorationLayout(arg_98_0, arg_98_1, arg_98_2)
	local var_98_0 = {
		{
			textureType = 0,
			path = "mainScenebg/dorm_room_bg/"
		}
	}

	setmetatable(var_98_0, {
		__index = function(arg_99_0, arg_99_1)
			return {
				textureType = 0,
				path = "mainScenebg/furnitures/"
			}
		end
	})

	local var_98_1 = {
		[var_0_39.DECORATION_BG] = cc.p(arg_98_1.roomDisplayDecorationLayout:size().w / 2, arg_98_1.roomDisplayDecorationLayout:size().h / 2),
		[var_0_39.DECORATION_BOX] = cc.p(arg_98_1.roomDisplayDecorationLayout:size().w / 2 - 160, arg_98_1.roomDisplayDecorationLayout:size().h / 2 - 37),
		[var_0_39.DECORATION_BED] = cc.p(arg_98_1.roomDisplayDecorationLayout:size().w / 2 + 207, arg_98_1.roomDisplayDecorationLayout:size().h / 2 - 34),
		[var_0_39.DECORATION_BOX_BACK] = cc.p(arg_98_1.roomDisplayDecorationLayout:size().w / 2 - 5, arg_98_1.roomDisplayDecorationLayout:size().h / 2 + 25),
		[var_0_39.DECORATION_WINDOWS] = cc.p(arg_98_1.roomDisplayDecorationLayout:size().w / 2 + 200, arg_98_1.roomDisplayDecorationLayout:size().h / 2 + 17)
	}
	local var_98_2 = {
		[var_0_39.DECORATION_BG] = cc.p(0.5, 0.5),
		[var_0_39.DECORATION_BOX] = cc.p(0, 0),
		[var_0_39.DECORATION_BED] = cc.p(0, 0),
		[var_0_39.DECORATION_BOX_BACK] = cc.p(0, 0),
		[var_0_39.DECORATION_WINDOWS] = cc.p(0, 0)
	}

	var_98_1[2] = FURNITURE_POS[2]
	var_98_1[3] = FURNITURE_POS[3]
	var_98_1[4] = FURNITURE_POS[4]
	var_98_1[5] = FURNITURE_POS[5]

	local var_98_3 = arg_98_1.roomDisplayDecorationLayout._childData.smallDoor

	if not arg_98_1.roomDisplayDecorationLayout._childData.smallDoor then
		arg_98_1.roomDisplayDecorationLayout._childData.smallDoor = TempWidget:CreateTempImg("mainScenebg/furnitures/" .. 6500005 .. ".png", arg_98_1.roomDisplayDecorationLayout, 0)

		arg_98_1.roomDisplayDecorationLayout._childData.smallDoor:move(arg_98_1.roomDisplayDecorationLayout:size().w / 2 - 269, arg_98_1.roomDisplayDecorationLayout:size().h / 2 - 4)
		arg_98_1.roomDisplayDecorationLayout._childData.smallDoor:setLocalZOrder(1)

		var_98_3 = arg_98_1.roomDisplayDecorationLayout._childData.smallDoor
	end

	var_98_3:setVisible(false)

	local var_98_4 = arg_98_1.roomDisplayDecorationLayout._childData.smallDoorSpine

	if arg_98_1.roomDisplayDecorationLayout._childData.smallDoorSpine then
		var_98_4:setVisible(false)
	end

	for iter_98_0, iter_98_1 in pairs(playermodel.dormRoomConfig[arg_98_2].furnitures) do
		local var_98_5 = arg_98_1.roomDisplayDecorationLayout._childData[iter_98_0]
		local var_98_6 = arg_98_1.roomDisplayDecorationLayout._childData.furnitureSpine[iter_98_0]

		if arg_98_1.roomDisplayDecorationLayout._childData.furnitureSpine[iter_98_0] then
			var_98_6:setVisible(false)
			var_98_6:setLocalZOrder(FURNITURE_ZORDER[iter_98_0])
		end

		if not var_98_5 then
			var_98_5 = TempWidget:CreateTempImg(nil, arg_98_1.roomDisplayDecorationLayout, var_98_0[iter_98_0].textureType)

			var_98_5:setLocalZOrder(FURNITURE_ZORDER[iter_98_0])
			var_98_5:setAnchorPoint(var_98_2[iter_98_0])

			local var_98_7 = item_data[iter_98_1].init_x or var_98_1[iter_98_0].x
			local var_98_8 = item_data[iter_98_1].init_y or var_98_1[iter_98_0].y

			var_98_5:move(var_98_7, var_98_8)

			if item_data[iter_98_1].offset then
				local var_98_9, var_98_10 = item_data[iter_98_1].offset:match("([^,]+),(.+)")

				var_98_5:setPosition(var_98_7 + (tonumber(var_98_9) or 0), var_98_8 + (tonumber(var_98_10) or 0))
			end

			arg_98_1.roomDisplayDecorationLayout._childData[iter_98_0] = var_98_5
		end

		var_98_5:hide()

		if iter_98_1 > 0 then
			if not item_data[iter_98_1].spine_dorm then
				var_98_5:show()
				var_98_5:loadTexture(var_98_0[iter_98_0].path .. item_data[iter_98_1].image_dorm .. ".png", 0)
				var_98_5:setLocalZOrder(FURNITURE_ZORDER[iter_98_0])

				local var_98_12 = item_data[iter_98_1].init_x or var_98_1[iter_98_0].x
				local var_98_13 = item_data[iter_98_1].init_y or var_98_1[iter_98_0].y

				var_98_5:move(var_98_12, var_98_13)

				if item_data[iter_98_1].offset then
					local var_98_14, var_98_15 = item_data[iter_98_1].offset:match("([^,]+),(.+)")

					var_98_5:setPosition(var_98_12 + (tonumber(var_98_14) or 0), var_98_13 + (tonumber(var_98_15) or 0))
				end

				if iter_98_0 == 1 then
					var_98_3:loadTexture("mainScenebg/furnitures/" .. (item_data[iter_98_1].image_dorm or 6500005) .. ".png")
					var_98_3:setVisible(true)
				end
			else
				var_98_5:hide()

				local var_98_18 = item_data[iter_98_1].spine_init_x or var_98_1[1].x
				local var_98_19 = item_data[iter_98_1].spine_init_y or var_98_1[1].y

				if iter_98_0 == 1 then
					if not var_98_4 then
						var_98_4 = L2Skeleton:create("spine/furniture/" .. item_data[iter_98_1].spine_dorm .. "_men.json", "spine/furniture/" .. item_data[iter_98_1].spine_dorm .. "_men.atlas", nil, true)

						var_98_4:setPosition(var_98_18, var_98_19)
						arg_98_1.roomDisplayDecorationLayout:addChild(var_98_4, FURNITURE_ZORDER[iter_98_0] + 1)

						arg_98_1.roomDisplayDecorationLayout._childData.smallDoorSpine = var_98_4
					else
						var_98_4:setVisible(true)
						var_98_4:resetL2Skeleton("spine/furniture/" .. item_data[iter_98_1].spine_dorm .. "_men.json", "spine/furniture/" .. item_data[iter_98_1].spine_dorm .. "_men.atlas", nil, true)
					end

					var_98_4:refreshSkeleton()
					var_98_4:play("animate", true)
				end

				if not var_98_6 then
					var_98_6 = L2Skeleton:create("spine/furniture/" .. item_data[iter_98_1].spine_dorm .. ".json", "spine/furniture/" .. item_data[iter_98_1].spine_dorm .. ".atlas", nil, true)

					var_98_6:setPosition(var_98_18, var_98_19)
					arg_98_1.roomDisplayDecorationLayout:addChild(var_98_6, FURNITURE_ZORDER[iter_98_0])

					arg_98_1.roomDisplayDecorationLayout._childData.furnitureSpine[iter_98_0] = var_98_6
				else
					var_98_6:setVisible(true)
					var_98_6:resetL2Skeleton("spine/furniture/" .. item_data[iter_98_1].spine_dorm .. ".json", "spine/furniture/" .. item_data[iter_98_1].spine_dorm .. ".atlas", nil, true)
				end

				var_98_6:refreshSkeleton()
				var_98_6:play("animate", true)
			end
		else
			var_98_5:hide()
		end
	end
end

function DormitoryLayer:isStateLayoutUp(arg_100_1)
	local var_100_0
	local var_100_1

	if self.roomInfos[arg_100_1].state == var_0_36.TRAVELBACK then
		var_100_0 = var_0_35.TRAVEL
		var_100_1 = false
	elseif self.roomInfos[arg_100_1].state == var_0_36.EXPLORING or self.roomInfos[arg_100_1].state == var_0_36.PLOT then
		var_100_0 = var_0_35.LEAVE
		var_100_1 = false
	elseif self.roomInfos[arg_100_1].state == var_0_36.UNLOCK then
		var_100_1 = false
		var_100_0 = var_0_35.SETTLE_IN
	elseif self.roomInfos[arg_100_1].state == var_0_36.ATHOME then
		var_100_1 = true
		var_100_0 = var_0_35.NOTHING
	else
		var_100_1 = true
		var_100_0 = var_0_35.SETTLE_IN
	end

	return var_100_0, var_100_1
end

function DormitoryLayer.showBuildCompleteLayout(arg_101_0, arg_101_1)
	arg_101_1.remainBuildingLayout:hide()
	arg_101_1.buildCompleteLayout:show()
end

function DormitoryLayer:startBuildingRemain(arg_102_1, arg_102_2)
	local var_102_0 = self.roomInfos[arg_102_2]

	if self.roomInfos[arg_102_2] and self.roomInfos[arg_102_2].state == var_0_36.BUILDING then
		local var_102_1 = arg_102_1.remainTimeText

		arg_102_1.remainTimeText:setString("")

		local var_102_2 = self.roomInfos[arg_102_2].last_time

		if self.roomInfos[arg_102_2].last_time and self.roomInfos[arg_102_2].last_time > 0 then
			local var_102_3 = 0.03333333333333333

			schedule(arg_102_1.remainTimeText, function()
				var_102_2 = var_102_2 - var_102_3

				var_102_1:setString(var_0_1(var_0_0.ceil(var_102_2)))

				if var_102_2 <= 0 then
					var_102_1:stopAllActions()

					if var_102_0.state == var_0_36.BUILDING then
						var_102_0.state = var_0_36.BUILDED

						self:updateCell(arg_102_2)
					end
				end
			end, 0.03333333333333333)
		end
	end
end

function DormitoryLayer:buildCompleteStateChange(arg_104_1)
	self:showBuildCompleteLayout(arg_104_1)
end

function DormitoryLayer:atHomeStateChange(arg_105_1, arg_105_2)
	local var_105_0 = self.listView:getChildren()
	local var_105_1 = arg_105_1 % var_0_33

	if arg_105_1 % var_0_33 == 0 then
		var_105_1 = var_0_33
	end

	if var_105_0 and var_105_0[var_105_1] and var_105_0[var_105_1]:IsEnter() then
		local var_105_2 = self.roomInfos[arg_105_1]

		if self.roomInfos[arg_105_1] then
			local var_105_3 = ui_delegate(var_105_0[var_105_1]).posLayout._childData

			self:updateStateLayout(arg_105_1)

			if arg_105_2 and arg_105_2 == var_0_36.TRAVELBACK then
				-- block empty
			else
				local var_105_4 = var_105_3.roomDisplayDecorationLayout

				self:showOpenSmallDoor(arg_105_1)
				var_105_4:runAction(cc.Sequence:create(cc.DelayTime:create(4), cc.CallFunc:create(function()
					self:showCloseSmallDoor(arg_105_1)
				end)))
			end

			self:initDirector(var_105_3, arg_105_1, dorm_script_class_data[var_105_2.soulid].class_move_in or (500 + var_105_2.soulid) * 1000 + 2)
			self:updateStateLayout(arg_105_1)
		end
	end
end

function DormitoryLayer:plotStateChange(arg_107_1)
	self:removeDirector(arg_107_1)
	self:updateStateLayout(arg_107_1)
end

function DormitoryLayer:buildingStateChange(arg_108_1, arg_108_2)
	arg_108_1.nextUnlockLayout:hide()
	arg_108_1.remainBuildingLayout:show()
	self:startBuildingRemain(arg_108_1, arg_108_2)
end

function DormitoryLayer.nextUnlockStateChange(arg_109_0, arg_109_1)
	arg_109_1.nextUnlockLayout:show()
end

function DormitoryLayer:unLockStateChange(arg_110_1, arg_110_2, arg_110_3)
	arg_110_1.buildCompleteLayout:hide()
	arg_110_1.superRoomDisplayLayout:show()

	if arg_110_3 and arg_110_3 == var_0_36.ATHOME then
		self:updateStateLayout(arg_110_2)
	else
		local var_110_0 = arg_110_1.bgLayout

		arg_110_1.bgLayout:stopAllActions()
		var_110_0:hide()

		local var_110_1 = var_110_0:getChildByName("lockBg")
		local var_110_2 = TempWidget:CreateTempLayout(arg_110_1.doorLayout)

		var_110_2:setContentSize(cc.size(var_110_1:size().w, var_110_1:size().h + 5))
		var_110_2:setClippingEnabled(true)
		var_110_2:align(cc.p(0.5, 0.5), arg_110_1.doorLayout:size().w / 2, arg_110_1.doorLayout:size().h / 2 + 1)

		local var_110_3 = L2Skeleton:create("spine/ui/dormitory_unlock.json", "spine/ui/dormitory_unlock.atlas", nil, true)

		var_110_3:refreshSkeleton()
		var_110_3:play("animation", false)
		var_110_3:setPosition(cc.p(var_110_2:size().w / 2, var_110_2:size().h / 2))
		var_110_3:registerListener(SP_ANIMATION_COMPLETE, function(arg_111_0)
			self:updateStateLayout(arg_110_2)
			var_110_3:runAction(cc.RemoveSelf:create())
		end)
		var_110_2:addChild(var_110_3)
	end

	arg_110_1.remainBuildingLayout:hide()
	arg_110_1.remainTimeText:stopAllActions()
	self:initDecorationLayout(arg_110_1, arg_110_2)
end

function DormitoryLayer:updateCell(arg_112_1, arg_112_2)
	local var_112_0 = self.listView:getChildren()
	local var_112_1 = arg_112_1 % var_0_33

	if arg_112_1 % var_0_33 == 0 then
		var_112_1 = var_0_33
	end

	if var_112_0 and var_112_0[var_112_1] and var_112_0[var_112_1]:IsEnter() then
		if self.roomInfos[arg_112_1] then
			local var_112_2 = ui_delegate(var_112_0[var_112_1]).posLayout._childData

			if var_0_36.UNLOCK == self.roomInfos[arg_112_1].state then
				self:unLockStateChange(var_112_2, arg_112_1, arg_112_2)
			elseif var_0_36.LOCK == self.roomInfos[arg_112_1].state then
				-- block empty
			elseif var_0_36.BUILDING == self.roomInfos[arg_112_1].state then
				self:buildingStateChange(var_112_2, arg_112_1)
			elseif var_0_36.BUILDED == self.roomInfos[arg_112_1].state then
				self:buildCompleteStateChange(var_112_2)
			elseif var_0_36.ATHOME == self.roomInfos[arg_112_1].state then
				self:atHomeStateChange(arg_112_1, arg_112_2)
			elseif var_0_36.TRAVELBACK == self.roomInfos[arg_112_1].state then
				-- block empty
			elseif var_0_36.PLOT == self.roomInfos[arg_112_1].state then
				self:plotStateChange(arg_112_1)
			elseif var_0_36.NEXTLOCK == self.roomInfos[arg_112_1].state then
				self:nextUnlockStateChange(var_112_2)
			end
		end
	end
end

function DormitoryLayer:updateSelectType()
	self:updateLogoVisible()

	local var_113_0 = self.selectType

	if self.selectType == var_0_38.NORMAL then
		self.moveAwayBtn:show()
	elseif var_113_0 == var_0_38.MOVE_AWAY then
		self.moveAwayBtn:show()
	elseif var_113_0 == var_0_38.DECORATION then
		self.moveAwayBtn:hide()
	end

	local var_113_1 = self.listView:getChildren()

	for iter_113_0 = 1, var_0_33 do
		if var_113_1 and var_113_1[iter_113_0] and var_113_1[iter_113_0]:IsEnter() then
			local var_113_2 = self.roomInfos[iter_113_0 + (self.buildingId - 1) * var_0_33]

			if self.roomInfos[iter_113_0 + (self.buildingId - 1) * var_0_33] then
				local var_113_3 = ui_delegate(var_113_1[iter_113_0]).posLayout._childData
				local var_113_4 = var_113_3.shieldingLayout
				local var_113_5 = var_113_3.selectTipsLayout

				if var_113_0 == var_0_38.NORMAL then
					var_113_4:hide()
					var_113_5:hide()
				elseif var_113_0 == var_0_38.MOVE_AWAY then
					var_113_4:show()
					var_113_5:hide()
				elseif var_113_0 == var_0_38.DECORATION then
					var_113_4:show()
					var_113_5:hide()
				end

				if var_0_36.UNLOCK == var_113_2.state then
					if var_113_0 == var_0_38.NORMAL then
						var_113_4:hide()
						var_113_5:hide()
					elseif var_113_0 == var_0_38.MOVE_AWAY then
						var_113_4:show()
						var_113_5:hide()
					elseif var_113_0 == var_0_38.DECORATION then
						var_113_4:hide()
						var_113_5:show()
					end
				elseif var_0_36.LOCK == var_113_2.state then
					-- block empty
				elseif var_0_36.BUILDING == var_113_2.state then
					-- block empty
				elseif var_0_36.BUILDED == var_113_2.state then
					-- block empty
				elseif var_0_36.ATHOME == var_113_2.state then
					if var_113_0 == var_0_38.NORMAL then
						var_113_4:hide()
						var_113_5:hide()
					elseif var_113_0 == var_0_38.MOVE_AWAY then
						var_113_4:hide()
						var_113_5:show()
					elseif var_113_0 == var_0_38.DECORATION then
						var_113_4:hide()
						var_113_5:show()
					end
				elseif var_0_36.TRAVELBACK == var_113_2.state then
					if var_113_0 == var_0_38.NORMAL then
						var_113_4:hide()
						var_113_5:hide()
					elseif var_113_0 == var_0_38.MOVE_AWAY then
						var_113_4:show()
						var_113_5:hide()
					elseif var_113_0 == var_0_38.DECORATION then
						var_113_4:hide()
						var_113_5:show()
					end
				elseif var_0_36.PLOT == var_113_2.state then
					if var_113_0 == var_0_38.NORMAL then
						var_113_4:hide()
						var_113_5:hide()
					elseif var_113_0 == var_0_38.MOVE_AWAY then
						var_113_4:show()
						var_113_5:hide()
					elseif var_113_0 == var_0_38.DECORATION then
						var_113_4:hide()
						var_113_5:show()
					end
				elseif var_0_36.NEXTLOCK == var_113_2.state then
					-- block empty
				end
			end
		end
	end
end

function DormitoryLayer:updateLogoVisible()
	local var_114_0 = self._root:getChildByName("showLogo")

	if var_114_0 then
		var_114_0:removeFromParent()
	end

	if self.selectType == var_0_38.MOVE_AWAY then
		local var_114_1 = ccui.ImageView:create("Dormitory/move_away_logo.png", var_0_18)

		var_114_1:setPosition(GameDisplay.width / 2, GameDisplay.height * 0.5)
		var_114_1:setName("showLogo")
		self._root:addChild(var_114_1, 10)
	elseif self.selectType == var_0_38.DECORATION then
		local var_114_2 = ccui.ImageView:create("Dormitory/renovation_logo.png", var_0_18)

		var_114_2:setPosition(GameDisplay.width / 2, GameDisplay.height * 0.5)
		var_114_2:setName("showLogo")
		self._root:addChild(var_114_2, 10)
	end
end

function DormitoryLayer:moveAwayPop(arg_115_1)
	local var_115_0 = TempWidget:CreateTempLayout()

	var_115_0:setTouchEnabled(true)
	var_115_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_115_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_115_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_115_0:setBackGroundColorOpacity(160)
	var_115_0:setCascadeOpacityEnabled(false)
	self._root:addChild(var_115_0, 999)
	var_115_0:addTouchEventListener(function(arg_116_0, arg_116_1)
		if arg_116_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_115_0:runAction(cc.RemoveSelf:create())
	end)

	local var_115_1 = TempWidget:CreateTempImg(var_0_27 .. "move_away_pop.png")

	var_115_1:setPosition(GameDisplay.width / 2, GameDisplay.height / 2)
	var_115_0:addChild(var_115_1)

	local var_115_2 = TempWidget:CreateTempBtn("public/button/public_button_orange.png")

	var_115_2:setTitleText(L_BUTTON_TEXT.Comfirm)
	var_115_2:setTitleFontSize(30)
	var_115_2:setTitleColor(cc.c3b(0, 0, 0))
	var_115_2:setTitleFontName(FONT_BUTTON)
	var_115_2:setPosition(180, GameDisplay.height / 2 - 100)
	var_115_0:addChild(var_115_2)
	var_115_2:addTouchEventListener(function(arg_117_0, arg_117_1)
		if arg_117_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_115_1.surecallback then
			arg_115_1.surecallback()
		end

		var_115_0:runAction(cc.RemoveSelf:create())
	end)

	local var_115_3 = TempWidget:CreateTempBtn("public/button/public_button_big_blue_y.png")

	var_115_3:setTitleText(L_BUTTON_TEXT.Can_cel)
	var_115_3:setTitleFontSize(30)
	var_115_3:setTitleColor(cc.c3b(0, 0, 0))
	var_115_3:setTitleFontName(FONT_BUTTON)
	var_115_3:setPosition(GameDisplay.width - 180, GameDisplay.height / 2 - 100)
	var_115_0:addChild(var_115_3)
	var_115_3:addTouchEventListener(function(arg_118_0, arg_118_1)
		if arg_118_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_115_0:runAction(cc.RemoveSelf:create())

		if arg_115_1.cancelcallback then
			arg_115_1.cancelcallback()
		end
	end)

	local var_115_4 = dormitory_manager:getSoulDressModelid(arg_115_1.soulid) or major_factor_data[arg_115_1.soulid].model
	local var_115_5 = TempWidget:CreateTempImg("roleimage/role1/" .. (model_data[var_115_4].cute_Q or model_data[var_115_4].cute_role) .. ".png", var_115_1, 0)

	var_115_5:setAnchorPoint(cc.p(0.5, 0))
	var_115_5:setScale(0.4)
	var_115_5:setPosition(560, 10)

	local var_115_6 = TempWidget:CreateTempLabel(string.format(L_MOVE_AWAY_FROM_DORM.Role, major_factor_data[arg_115_1.soulid].easy_name), FONT_TITLE, 26)

	var_115_6:setPosition(var_115_1:getContentSize().width / 2, 60)
	var_115_1:addChild(var_115_6)

	if playermodel.dormRoomConfig[arg_115_1.roomid].favorpool > 0 then
		local var_115_7 = TempWidget:CreateTempLabel(string.format(L_MOVE_AWAY_FROM_DORM.Favor_rest, playermodel.dormRoomConfig[arg_115_1.roomid].favorpool), FONT_DES, 20)

		var_115_7:setColor(cc.c3b(253, 151, 32))
		var_115_7:setPosition(var_115_1:getContentSize().width / 2, 30)
		var_115_1:addChild(var_115_7)
	end
end

function DormitoryLayer:moveLeft(arg_119_1, arg_119_2)
	self:_move(var_0_40.LEFT, arg_119_1, arg_119_2)
end

function DormitoryLayer:moveRight(arg_120_1, arg_120_2)
	self:_move(var_0_40.RIGHT, arg_120_1, arg_120_2)
end

function DormitoryLayer:resetData()
	self.textureDetection:stopAllActions()

	local var_121_0 = self.listView:getChildren()

	for iter_121_0 = 1, #var_121_0 do
		if var_121_0 and var_121_0[iter_121_0] and var_121_0[iter_121_0]:IsEnter() then
			ui_delegate(var_121_0[iter_121_0]).posLayout._childData.directInitNode:stopAllActions()
		end
	end
end

function DormitoryLayer:_move(arg_122_1, arg_122_2, arg_122_3)
	self.isMove = arg_122_1

	self.topShieldingLayout:show()
	self:resetData()

	local var_122_0 = self.listView:getChildren()

	self.listView:move(0, var_0_30)

	if arg_122_2 then
		self.buildingId = arg_122_2
	elseif arg_122_1 == var_0_40.LEFT then
		self.buildingId = self.buildingId + 1
	elseif arg_122_1 == var_0_40.RIGHT then
		self.buildingId = self.buildingId - 1
	end

	local var_122_1 = 0.5
	local var_122_2

	if arg_122_1 == var_0_40.LEFT then
		var_122_2 = -GameDisplay.width
	elseif arg_122_1 == var_0_40.RIGHT then
		var_122_2 = GameDisplay.width
	end

	local var_122_3 = cc.Sequence:create(cc.CallFunc:create(function()
		self.listView:runAction(cc.Sequence:create(cc.MoveTo:create(var_122_1, cc.p(var_122_2, var_0_30)), cc.DelayTime:create(0.016666666666666666), cc.CallFunc:create(function()
			self.listView:move(0, var_0_30)
			self:initListView()
			self.defaultDoorLayout:hide()
			self:delayShowOpenDoorLayout()

			if arg_122_3 then
				self.listView:jumpToIndex(arg_122_3, cc.p(0, 1), cc.p(0, 1))
			else
				self.listView:jumpToTop()
			end
		end), cc.DelayTime:create(var_122_1), cc.CallFunc:create(function()
			self.topShieldingLayout:hide()
		end)))
		self:showDefaultDoorLayoutMove(arg_122_1)

		self.isMove = var_0_40.NULL
	end))

	self.topShieldingLayout:stopAllActions()
	self.topShieldingLayout:runAction(var_122_3)
	self:updateBuildingBtn()
end

function DormitoryLayer:createQuickPopList()
	self._root:removeChildByName("_QuickPopList")

	local var_126_0 = false
	local var_126_1
	local var_126_3 = TempWidget:CreateTempLayout(self._root)

	var_126_3:setName("_QuickPopList")
	var_126_3:setContentSize(self._root:size())
	var_126_3:setLocalZOrder(var_0_32)
	var_126_3:_setBack()
	var_126_3:setBackGroundColor(cc.c3b(0, 0, 0))
	var_126_3:setBackGroundColorOpacity(160)
	var_126_3:_addEvent(function()
		if var_126_0 then
			var_126_1:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(-var_126_1:size().w, 0)), cc.CallFunc:create(function()
				var_126_3:hide()
			end)))
		end
	end)

	var_126_1 = TempWidget:CreateTempLayout()

	var_126_1:setContentSize(var_126_3:size())
	var_126_1:align(cc.p(0, 0), -var_126_1:size().w, 0)
	var_126_3:addChild(var_126_1)
	var_126_1:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(0, 0)), cc.CallFunc:create(function()
		var_126_0 = true
	end)))

	local var_126_4 = TempWidget:CreateTempListView()

	var_126_4:setContentSize(cc.size(GameDisplay.width, 810))
	var_126_4:setPosition(0, GameDisplay.height / 2 - var_126_4:size().h / 2 + 50)
	var_126_4:setItemsMargin(50)
	var_126_1:addChild(var_126_4)

	local var_126_5 = TempWidget:CreateTempImg(var_0_29 .. "title.png")

	var_126_5:align(cc.p(0, 0), 0, var_126_4:pos().y + var_126_4:size().h + 25)
	var_126_1:addChild(var_126_5)

	var_126_1.buildId = self.buildingId

	local function var_126_6(arg_130_0)
		local var_130_0 = cc.Node:create()
		local var_130_1 = TempWidget:CreateTempImg("role/portrait/19040.png", nil, 0)

		var_130_1:setAnchorPoint(cc.p(0, 0))
		var_130_1:setPosition(0, 0)
		var_130_1:setName("role")
		var_130_0:addChild(var_130_1)

		local var_130_2 = TempWidget:CreateTempImg(var_0_29 .. "logo.png")

		var_130_2:setName("empty")
		var_130_2:setPosition(62, 52)
		var_130_0:addChild(var_130_2)

		local var_130_3 = TempWidget:CreateTempImg(var_0_29 .. "favor_bg.png")

		var_130_3:setScale9Enabled(true)
		var_130_3:setCapInsets(cc.rect(var_130_3:getContentSize().width / 2 - 1, var_130_3:getContentSize().height / 2 - 1, 2, 2))
		var_130_3:setContentSize(cc.size(108, 20))
		var_130_3:setAnchorPoint(cc.p(0, 0))
		var_130_3:setPosition(2, 0)
		var_130_3:setName("lvBg")
		var_130_0:addChild(var_130_3)

		local var_130_4 = TempWidget:CreateTempImg(var_0_29 .. "heart_icon.png")

		var_130_4:setPosition(20, var_130_3:getContentSize().height / 2)
		var_130_3:addChild(var_130_4)

		local var_130_5 = TempWidget:CreateTempLabel("", FONT_W5, 20)

		var_130_5:setAnchorPoint(cc.p(0, 0.5))
		var_130_5:setPosition(30, var_130_3:getContentSize().height / 2)
		var_130_5:setName("favorLv")
		var_130_3:addChild(var_130_5)

		local var_130_6 = TempWidget:CreateTempLabel("", FONT_NAME, 20, var_130_0)

		var_130_6:setName("nameText")
		var_130_6:move(55, -24)

		function var_130_0:update(arg_131_1)
			local var_131_0 = self:getChildByName("role")
			local var_131_1 = self:getChildByName("empty")
			local var_131_2 = self:getChildByName("lvBg")
			local var_131_3 = self:getChildByName("nameText")

			if self.roomInfos[arg_131_1] and self.roomInfos[arg_131_1].soulid and self.roomInfos[arg_131_1].soulid > 0 then
				var_131_0:setVisible(true)
				var_131_2:setVisible(true)
				var_131_1:setVisible(false)
				var_131_3:setVisible(true)
				var_131_0:loadTexture(ROLE_PORTRAIT_PATH .. model_data[servant_data[major_factor_data[self.roomInfos[arg_131_1].soulid].servant].modelid].portrait_image .. ".png")
				var_131_2:getChildByName("favorLv"):setString("等级" .. playermodel.favor[self.roomInfos[arg_131_1].soulid].favorlevel)
				var_131_3:setString(major_factor_data[self.roomInfos[arg_131_1].soulid].easy_name)
			elseif self.roomInfos[arg_131_1].state == var_0_36.UNLOCK then
				var_131_1:loadTexture(var_0_29 .. "logo.png", var_0_18)
				var_131_0:setVisible(false)
				var_131_2:setVisible(false)
				var_131_1:setVisible(true)
				var_131_3:setVisible(false)
			else
				var_131_1:loadTexture(var_0_29 .. "logo2.png", var_0_18)
				var_131_0:setVisible(false)
				var_131_2:setVisible(false)
				var_131_1:setVisible(true)
				var_131_3:setVisible(false)
			end
		end

		var_130_0:update(arg_130_0)

		return var_130_0
	end

	for iter_126_0 = 1, var_0_33 / 4 do
		local var_126_7 = TempWidget:CreateTempLayout()
		local var_126_8 = TempWidget:CreateTempImg(var_0_29 .. "floor_bg.png", var_126_7)

		var_126_7:setContentSize(cc.size(var_126_4:size().w, var_126_8:size().h))
		var_126_8:align(cc.p(1, 0.5), var_126_7:size().w, var_126_7:size().h / 2)
		var_126_8:setName("floorBg")
		TempWidget:CreateTempImg(var_0_29 .. "title_once.png", var_126_8):align(cc.p(0, 1), -45, var_126_8:size().h + 23)
		var_126_4:pushBackCustomItem(var_126_7)
		TempWidget:CreateTempLabel(iter_126_0 .. L_LAYER, FONT_W5, 35, var_126_8):align(cc.p(0, 1), -45, var_126_8:size().h)

		for iter_126_1 = 1, 4 do
			local var_126_9 = var_126_6((var_126_1.buildId - 1) * var_0_33 + (iter_126_0 - 1) * 4 + iter_126_1)

			var_126_9:setName("roleIcon" .. iter_126_1)
			var_126_9:setPosition((iter_126_1 - 1) * 132, 10)
			var_126_8:addChild(var_126_9)
		end

		var_126_8:_addEvent(function()
			if var_126_0 then
				var_126_0 = false

				var_126_1:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(-var_126_1:size().w, 0)), cc.CallFunc:create(function()
					var_126_3:hide()

					if var_126_1.buildId ~= self.buildingId then
						if var_126_1.buildId < self.buildingId then
							self:moveRight(var_126_1.buildId, (iter_126_0 - 1) * 4 + 1)
						else
							self:moveLeft(var_126_1.buildId, (iter_126_0 - 1) * 4 + 1)
						end
					else
						local var_133_0 = self.listView:getPercent()
						local var_133_1 = self.listView:getPercentByIndex((iter_126_0 - 1) * 4 + 1, cc.p(0, 1), cc.p(0, 1))

						if var_133_0 ~= var_133_1 then
							self.listView:scrollToPercentVertical(var_133_1, var_0_2(var_133_1 - var_133_0) / 30, true)
						end
					end
				end)))
			end
		end)
	end

	local function var_126_10()
		local var_134_0 = var_126_4:getChildren()

		for iter_134_0 = 1, #var_134_0 do
			for iter_134_1 = 1, 4 do
				local var_134_1 = var_134_0[iter_134_0]:getChildByName("floorBg"):getChildByName("roleIcon" .. iter_134_1)

				if var_134_1 then
					var_134_1:update((var_126_1.buildId - 1) * var_0_33 + (iter_134_0 - 1) * 4 + iter_134_1)
				end
			end
		end
	end

	local var_126_11 = (var_126_1:size().w - 80 * 2) / (#playermodel.dormRoomConfig / var_0_33 - 1)
	local var_126_12 = {}

	for iter_126_2 = 1, #playermodel.dormRoomConfig / var_0_33 do
		local var_126_13 = TempWidget:CreateTempBtn(var_0_29 .. "build" .. iter_126_2 .. "_off.png")

		var_126_12[iter_126_2] = var_126_13

		if iter_126_2 == var_126_1.buildId then
			var_126_13:loadTextureNormal(var_0_29 .. "build" .. iter_126_2 .. "_on.png", var_0_18)
		end

		var_126_13:move(80 + (iter_126_2 - 1) * var_126_11, var_126_4:pos().y - var_126_13:size().h / 2 - 25)
		var_126_1:addChild(var_126_13)
		var_126_13:_addEvent(function()
			var_126_12[var_126_1.buildId]:loadTextureNormal(var_0_29 .. "build" .. var_126_1.buildId .. "_off.png", var_0_18)
			var_126_12[iter_126_2]:loadTextureNormal(var_0_29 .. "build" .. iter_126_2 .. "_on.png", var_0_18)

			var_126_1.buildId = iter_126_2

			var_126_10()
		end)
	end
end

function DormitoryLayer.getAllFavorFromPool(arg_136_0)
	dormitory_manager:getAllFavorFromPool(function(arg_137_0)
		if var_0_41 then
			local var_137_0 = arg_136_0.listView:getChildren()

			for iter_137_0 = 1, #var_137_0 do
				if var_137_0[iter_137_0]:IsEnter() then
					arg_136_0:updateStateLayout((arg_136_0.buildingId - 1) * var_0_33 + iter_137_0)
				end
			end

			arg_136_0:updateRed()
		end
	end)
end

function DormitoryLayer:pop_img()
	local var_138_0 = self:getChildByName("pop_img")

	if not var_138_0 then
		var_138_0 = TempWidget:CreateTempImg(var_0_27 .. "pop_img.png")

		var_138_0:setPosition(320, GameDisplay.height / 2)
		var_138_0:setName("pop_img")
		self:addChild(var_138_0, 999)
	end

	var_138_0:stopAllActions()
	var_138_0:setScaleY(1)
	var_138_0:setOpacity(255)
	var_138_0:runAction((cc.Spawn:create(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeTo:create(2 - 0.5, 50)), cc.Sequence:create(cc.DelayTime:create(2 - 0.5), cc.ScaleTo:create(0.1, 1, 0), cc.RemoveSelf:create()))))
end

function DormitoryLayer.updateLayer(arg_139_0)
	return
end

function DormitoryLayer:updateRed()
	if self.bInit then
		local var_140_0 = self.listView:getChildren()

		for iter_140_0 = 1 + var_0_33 * (self.buildingId - 1), 1 + var_0_33 * (self.buildingId - 1) + (var_0_33 - 1) do
			local var_140_1 = iter_140_0 % var_0_33

			if iter_140_0 % var_0_33 == 0 then
				var_140_1 = var_0_33
			end

			if var_140_0 and var_140_0[var_140_1] and var_140_0[var_140_1]:IsEnter() then
				local var_140_3 = ui_delegate(var_140_0[var_140_1])

				if var_140_3 and var_140_3.posLayout and var_140_3.posLayout._childData then
					if var_140_3.posLayout._childData.stateLayout then
						local var_140_4 = ui_delegate(var_140_3.posLayout._childData.stateLayout)

						if var_140_4 and var_140_4._childData and var_140_4._childData.redImg then
							var_140_4._childData.redImg:setVisible(dormitory_manager:checkRoleSpillageFavorByIndex(iter_140_0))
						end
					end
				end
			end
		end

		if require("controller.costume_room_cumulative_reward_manager"):getInstance():checkRed() then
			self.rewardLayerBtnRedImg:show()
		else
			self.rewardLayerBtnRedImg:hide()
		end
	end
end

function DormitoryLayer:jumpToTarSoulId(arg_141_1)
	if self.bInit then
		local var_141_0
		local var_141_1

		for iter_141_0 = 1, #self.roomInfos do
			if self.roomInfos[iter_141_0].soulid ~= nil then
				if arg_141_1 == self.roomInfos[iter_141_0].soulid and not var_141_0 then
					var_141_0 = iter_141_0
				end
			elseif not var_141_1 and self.roomInfos[iter_141_0].state == var_0_36.UNLOCK then
				var_141_1 = iter_141_0
			end
		end

		local var_141_2

		if var_141_0 then
			var_141_2 = var_141_0
		elseif var_141_1 then
			var_141_2 = var_141_1
		end

		if var_141_2 then
			local var_141_3 = var_0_0.ceil(var_141_2 / var_0_33)
			local var_141_4 = var_141_2 % var_0_33

			if var_141_2 % var_0_33 == 0 then
				var_141_4 = var_0_33
			end

			if self.buildingId == var_141_3 then
				self.listView:jumpToIndex(var_141_4, cc.p(0, 1), cc.p(0, 1))
			else
				self:_move(var_141_3 > self.buildingId and var_0_40.LEFT or var_0_40.RIGHT, var_141_3, var_141_4)
			end
		end
	end
end

return DormitoryLayer
