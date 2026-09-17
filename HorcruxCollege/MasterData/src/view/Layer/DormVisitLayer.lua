DormVisitLayer = class("DormVisitLayer", (require("view.Layer.BaseUILayer")))

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
local var_0_19 = "DormVisitLayer/"
local var_0_20 = GameDisplay.width
local var_0_21 = 210
local var_0_22 = -0
local var_0_24 = 0.86
local var_0_25 = 0
local var_0_26 = -7
local var_0_27 = "Dormitory/"
local var_0_28 = "room_widget/"
local var_0_29 = "DormQuickList/"
local var_0_30 = 50
local var_0_31 = 50 + 80
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

function DormVisitLayer:ctor()
	DormVisitLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.selectType = var_0_38.NORMAL
	self.buildingId = 1
	self.bInitOver = false
	self.initPro = {}
	self.jumpIndex = nil
end

function DormVisitLayer.getInstance()
	return var_0_41
end

function DormVisitLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = DormVisitLayer.new(arg_3_1)

	if var_3_0 and var_3_0:init(arg_3_1) then
		return var_3_0
	end

	return nil
end

function DormVisitLayer.onEnter(arg_4_0)
	DormVisitLayer.super.onEnter(arg_4_0)

	var_0_41 = arg_4_0
end

function DormVisitLayer.onExit(arg_5_0)
	DormVisitLayer.super.onExit(arg_5_0)

	var_0_41 = nil

	texture_manager:removeUnusedSpineTextures()
end

function DormVisitLayer:init(arg_6_1)
	self:initLayer(arg_6_1)
	self:initListener()

	return true
end

function DormVisitLayer:initLayer(arg_7_1)
	self.playername = arg_7_1.name
	self.playerid = arg_7_1.playerid
	self.faceid = arg_7_1.faceid
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
	self:initTouchMoveLayout()
	self:initDoorLayout()
	self:initData(arg_7_1)

	self.buildingId = 1

	self:initTimer()
	self:initListView()
	self:delayShowOpenDoorLayout()
	self:initBuildingBtn()
	self:initTop()
	self:initTopShieldingLayout()
end

function DormVisitLayer:initTop()
	if not self.titleBg then
		local var_8_0 = TempWidget:CreateTempImg(var_0_27 .. "title_bg.png", self._root)

		var_8_0:align(cc.p(0.5, 1), self._root:size().w / 2, self._root:size().h)

		self.titleBg = var_8_0
	end

	if not self.topBg then
		local var_8_1 = TempWidget:CreateTempImg(var_0_19 .. "player_bg.png")

		var_8_1:setAnchorPoint(cc.p(0, 1))
		var_8_1:align(cc.p(0, 1), 0, GameDisplay.height)
		var_8_1:_addEvent(function()
			LayerManager:pushInLayer("PopFriendIntroduceLayer", {
				showType = 1,
				playeruid = self.playerid
			})
		end)
		self._root:addChild(var_8_1, 99)

		self.topBg = var_8_1
	end

	self.topBg:removeAllChildren()

	local var_8_2 = AvatarSprite:create(tonumber(self.faceid))
	local var_8_3 = 80 / var_8_2:getContentSize().width

	var_8_2:setScale(var_8_3)
	var_8_2:setPosition(cc.p(60 - 90 * var_8_3, 20 - 90 * var_8_3))
	self.topBg:addChild(var_8_2)

	local var_8_4 = TempWidget:CreateTempLabel(self.playername, FONT_NAME, 24)

	var_8_4:_setColor("#dee9ff")
	var_8_4:align(cc.p(0.5, 1), 60, self.topBg:getContentSize().height - 5)
	self.topBg:addChild(var_8_4)

	if not self.visitingImg then
		local var_8_5 = TempWidget:CreateTempImg(var_0_19 .. "visiting.png", self.titleBg)

		var_8_5:align(cc.p(0.5, 1), self.titleBg:property().cx + 100, self.titleBg:property().height - 15)

		self.visitingImg = var_8_5
	end

	if not self.nextBtn then
		local var_8_6 = TempWidget:CreateTempBtn(var_0_19 .. "next.png", self.titleBg)

		var_8_6:align(cc.p(1, 0.5), self.titleBg:property().right_center)

		self.nextBtn = var_8_6
	end
end

function DormVisitLayer:updateTop()
	self.topBg:removeAllChildren()

	local var_10_0 = AvatarSprite:create(tonumber(self.faceid))
	local var_10_1 = 80 / var_10_0:getContentSize().width

	var_10_0:setScale(var_10_1)
	var_10_0:setPosition(cc.p(60 - 90 * var_10_1, 20 - 90 * var_10_1))
	self.topBg:addChild(var_10_0)

	local var_10_2 = TempWidget:CreateTempLabel(self.playername, FONT_NAME, 24)

	var_10_2:_setColor("#dee9ff")
	var_10_2:align(cc.p(0, 1), 86, self.topBg:getContentSize().height - 5)
	self.topBg:addChild(var_10_2)
end

function DormVisitLayer:initData(arg_11_1)
	self.dormRoomConfig = {}
	self.roomInfos = {}
	self.dress_config = {}

	for iter_11_0, iter_11_1 in pairs(arg_11_1.msg.dorm.rooms) do
		self.dormRoomConfig[iter_11_0] = iter_11_1
	end

	for iter_11_2, iter_11_3 in pairs(self.dormRoomConfig) do
		if iter_11_3.soulid > 0 then
			self.roomInfos[iter_11_2] = {
				soulid = iter_11_3.soulid
			}
			self.roomInfos[iter_11_2].state = var_0_36.ATHOME
		elseif iter_11_3.soulid == 0 then
			self.roomInfos[iter_11_2] = {
				state = var_0_36.UNLOCK
			}
		elseif iter_11_3.soulid < 0 then
			self.roomInfos[iter_11_2] = {
				state = var_0_36.LOCK
			}
		end
	end

	for iter_11_4, iter_11_5 in pairs(arg_11_1.msg.dresses) do
		self.dress_config[iter_11_5.soulid] = iter_11_5.dress
	end
end

function DormVisitLayer:initSelectTypeBtn()
	local var_12_1 = TempWidget:CreateTempBtn(var_0_27 .. "move_away_bnt.png", self.titleBg)

	var_12_1:align(cc.p(0, 0.5), 0, self.titleBg:size().h / 2)
	var_12_1:_addEvent(function()
		self.selectType = self.selectType ~= var_0_38.MOVE_AWAY and var_0_38.MOVE_AWAY or var_0_38.NORMAL

		self:updateSelectType()
	end)

	self.moveAwayBtn = var_12_1

	local var_12_2 = TempWidget:CreateTempBtn(var_0_27 .. "random_visit_btn.png", self.titleBg)

	var_12_2:align(cc.p(1, 0.5), self.titleBg:size().w, self.titleBg:size().h / 2)
	var_12_2:_addEvent(function(arg_14_0)
		arg_14_0:setTouchEnabled(false)
		performWithDelay(arg_14_0, function()
			arg_14_0:setTouchEnabled(true)
		end, 2)
		friend_system_manager:randomVisitDorm(function(arg_16_0)
			if arg_16_0.result == 1 then
				LayerManager:pushInLayer("DormVisitLayer", {
					name = arg_16_0.name,
					msg = arg_16_0,
					playerid = arg_16_0.playerid,
					faceid = arg_16_0.head_sculpture
				})
			end
		end)
	end)

	self.visitBtn = var_12_2

	local var_12_3 = TempWidget:CreateTempBtn(var_0_27 .. "costume_room_btn.png", self.titleBg)

	var_12_3:setVisible(hexie_manager:canShowCostumeBtn())
	var_12_3:align(cc.p(0, 0.5), var_12_2:pos().x - var_12_2:size().w - var_12_3:size().w, self.titleBg:size().h / 2)
	var_12_3:_addEvent(function()
		LayerManager:switchShowLayer("CostumeRoomLayer")
	end, {
		touchDelay = 1
	})

	self.skinBtn = var_12_3

	local var_12_4 = TempWidget:CreateTempImg("public/reddot/reddot2.png", var_12_3)

	var_12_4:align(cc.p(1, 0.5), var_12_3:size().w, var_12_3:size().h / 2 + 20)

	self.skinBtnRedImg = var_12_4
end

function DormVisitLayer:initTopShieldingLayout()
	local var_18_0 = TempWidget:CreateTempLayout(self._root)

	var_18_0:setLocalZOrder(var_0_32)
	var_18_0:setContentSize(self._root:size())
	var_18_0:_addEvent(function()
		return
	end)
	var_18_0:hide()

	self.topShieldingLayout = var_18_0
end

function DormVisitLayer:initTimer()
	local var_20_0 = 0

	self:onUpdate(function(arg_21_0)
		var_20_0 = var_20_0 + arg_21_0

		if var_20_0 >= 1 then
			var_20_0 = 0

			for iter_21_0, iter_21_1 in ipairs(self.roomInfos) do
				if iter_21_1.state == var_0_36.BUILDING and iter_21_1.last_time > 0 then
					iter_21_1.last_time = iter_21_1.last_time - 1

					if iter_21_1.last_time <= 0 then
						iter_21_1.last_time = 0
					end
				end
			end
		end
	end)
end

function DormVisitLayer:createCell(arg_22_1)
	local var_22_0 = TempWidget:CreateTempLayout()

	var_22_0:setContentSize(cc.size(var_0_20, var_0_21))
	var_22_0:setName("posLayout")

	var_22_0._childData = {}
	var_22_0._childData.director = nil

	local var_22_1 = TempWidget:CreateTempLayout(var_22_0)

	var_22_1:setContentSize(cc.size(var_0_20, var_0_21))
	var_22_1:move(0, var_0_22)

	local var_22_2 = TempWidget:CreateTempLayout(var_22_1)

	var_22_2:setContentSize(var_22_1:size())
	var_22_2:hide()

	var_22_0._childData.bgLayout = var_22_2

	TempWidget:CreateTempImg(var_0_27 .. "lock.png", var_22_2):move(var_22_2:size().w / 2, var_22_2:size().h / 2)

	local var_22_3 = TempWidget:CreateTempLayout(var_22_1)

	var_22_3:setContentSize(var_22_1:size())
	var_22_3:hide()
	var_22_3:_addEvent(function()
		return
	end)

	var_22_0._childData.superRoomDisplayLayout = var_22_3
	var_22_3._childData = {}

	local var_22_4 = TempWidget:CreateTempLayout(var_22_3)

	var_22_4:setContentSize(var_22_3:size())

	if arg_22_1 % var_0_33 == 1 then
		var_22_4:setContentSize(cc.size(var_22_3:size().w, var_22_3:size().h - var_0_22))
	end

	var_22_4:move(0, 0)
	var_22_4:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_22_4:setBackGroundColor(cc.c3b(0, 0, 0))
	var_22_4:setOpacity(180)
	var_22_4:hide()
	self:initSelectTipsLayoutVisible(var_22_4, arg_22_1)

	var_22_0._childData.selectTipsLayout = var_22_4

	local var_22_5 = TempWidget:CreateTempLayout(var_22_3)

	var_22_5:setContentSize(var_22_1:size())
	var_22_5:setScale(var_0_24)
	var_22_5:align(cc.p(0, 0.5), var_0_25, var_22_1:size().h / 2 + var_0_26)

	var_22_0._childData.roomDisplayLayout = var_22_5

	local var_22_6 = TempWidget:CreateTempLayout(var_22_5)

	var_22_6:setContentSize(cc.size(var_22_5:size().w - 35, 260))
	var_22_6:align(cc.p(0, 0), var_22_5:size().w / 2 - var_22_6:size().w / 2, var_22_5:size().h / 2 - var_22_6:size().h / 2)

	var_22_6._childData = {}
	var_22_0._childData.roomDisplayDecorationLayout = var_22_6
	var_22_6._childData[var_0_39.DECORATION_BG] = nil
	var_22_6._childData[var_0_39.DECORATION_BOX] = nil
	var_22_6._childData[var_0_39.DECORATION_BED] = nil
	var_22_6._childData[var_0_39.DECORATION_BOX_BACK] = nil
	var_22_6._childData[var_0_39.DECORATION_WINDOWS] = nil
	var_22_6._childData.smallDoor = nil
	var_22_6._childData.smallDoorSpine = nil
	var_22_6._childData.furnitureSpine = {
		[var_0_39.DECORATION_BG] = nil,
		[var_0_39.DECORATION_BOX] = nil,
		[var_0_39.DECORATION_BED] = nil,
		[var_0_39.DECORATION_BOX_BACK] = nil,
		[var_0_39.DECORATION_WINDOWS] = nil
	}

	local var_22_7 = TempWidget:CreateTempLayout(var_22_5)

	var_22_7:setContentSize(cc.size(580, 259))
	var_22_7:setClippingEnabled(true)
	var_22_7:align(cc.p(0.5, 0.5), var_22_5:size().w / 2, var_22_5:size().h / 2)

	var_22_0._childData.roomDisplayRoleLayout = var_22_7

	local var_22_8 = TempWidget:CreateTempLayout(var_22_0)

	var_22_8:setContentSize(var_22_0:size())

	var_22_0._childData.stateLayout = var_22_8

	local var_22_9 = TempWidget:CreateTempLayout(var_22_1)

	var_22_9:setClippingEnabled(true)
	var_22_9:setContentSize(var_22_1:size())

	var_22_0._childData.doorLayout = var_22_9

	local var_22_10 = TempWidget:CreateTempLayout(var_22_9)

	var_22_10:setContentSize(var_22_9:size())
	var_22_10:hide()
	var_22_10:_addEvent(function()
		self:quickUnlockRoomClick(arg_22_1)
	end)

	var_22_0._childData.remainBuildingLayout = var_22_10

	local var_22_11 = TempWidget:CreateTempImg(var_0_28 .. "building.png", var_22_10)

	var_22_11:move(var_22_10:size().w / 2, var_22_10:size().h / 2)

	local var_22_12 = TempWidget:CreateTempLabel("", FONT_DES, 24, var_22_11)

	var_22_12:_setColor("#636370")
	var_22_12:move(var_22_11:size().w / 2 + 20, var_22_11:size().h / 2 - 20)

	var_22_0._childData.remainTimeText = var_22_12

	local var_22_13 = TempWidget:CreateTempImg(var_0_28 .. "img_clock.png", var_22_11)

	var_22_13:setColor(cc.c3b(99, 99, 112))
	var_22_13:move(75, var_22_12:getPositionY())

	local var_22_14 = TempWidget:CreateTempLayout(var_22_9)

	var_22_14:setContentSize(var_22_9:size())
	var_22_14:hide()
	var_22_14:_addEvent(function()
		self:buildCompleteClick(arg_22_1)
	end)

	var_22_0._childData.buildCompleteLayout = var_22_14

	TempWidget:CreateTempImg(var_0_28 .. "finish.png", var_22_14):move(var_22_14:size().w / 2, var_22_14:size().h / 2)

	local var_22_15 = TempWidget:CreateTempLayout(var_22_9)

	var_22_15:setContentSize(var_22_9:size())
	var_22_15:hide()
	var_22_15:_addEvent(function()
		self:unLockClick(arg_22_1)
	end)

	var_22_0._childData.nextUnlockLayout = var_22_15

	TempWidget:CreateTempImg(var_0_28 .. "unlock.png", var_22_15):move(var_22_15:size().w / 2, var_22_15:size().h / 2)

	local var_22_16 = TempWidget:CreateTempLayout(var_22_1)

	var_22_16:setContentSize(var_22_1:size())

	if arg_22_1 % var_0_33 == 1 then
		var_22_16:setContentSize(cc.size(var_22_1:size().w, var_22_1:size().h - var_0_22))
	end

	var_22_16:move(0, 0)
	var_22_16:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_22_16:setBackGroundColor(cc.c3b(0, 0, 0))
	var_22_16:setOpacity(180)
	var_22_16:hide()
	var_22_16:_addEvent(function()
		self.selectType = var_0_38.NORMAL

		self:updateSelectType()
	end)
	self:initShieldingLayoutVisible(var_22_16, arg_22_1)

	var_22_0._childData.shieldingLayout = var_22_16

	if self.roomInfos[arg_22_1] then
		if var_0_36.UNLOCK == self.roomInfos[arg_22_1].state then
			var_22_3:show()
			self:initRoomDisplayLayout(var_22_0._childData, arg_22_1)
		elseif var_0_36.LOCK == self.roomInfos[arg_22_1].state then
			self:initStateLayout(var_22_0._childData, arg_22_1)
			var_22_2:show()
		elseif var_0_36.BUILDING == self.roomInfos[arg_22_1].state then
			var_22_10:show()
			self:startBuildingRemain(var_22_0._childData, arg_22_1)
			self:initStateLayout(var_22_0._childData, arg_22_1)
			var_22_2:show()
		elseif var_0_36.BUILDED == self.roomInfos[arg_22_1].state then
			self:showBuildCompleteLayout(var_22_0._childData)
			self:initStateLayout(var_22_0._childData, arg_22_1)
			var_22_2:show()
		elseif var_0_36.ATHOME == self.roomInfos[arg_22_1].state then
			var_22_3:show()
			self:initRoomDisplayLayout(var_22_0._childData, arg_22_1)
		elseif var_0_36.TRAVELBACK == self.roomInfos[arg_22_1].state then
			var_22_3:show()
			self:initRoomDisplayLayout(var_22_0._childData, arg_22_1)
		elseif var_0_36.PLOT == self.roomInfos[arg_22_1].state then
			var_22_3:show()
			self:initRoomDisplayLayout(var_22_0._childData, arg_22_1)
		elseif var_0_36.NEXTLOCK == self.roomInfos[arg_22_1].state then
			var_22_15:show()
			self:initStateLayout(var_22_0._childData, arg_22_1)
			var_22_2:show()
		end
	end

	return var_22_0
end

function DormVisitLayer:initListener()
	self.nextBtn:_addEvent(function()
		self:showCloseDoorLayout(function()
			friend_system_manager:randomVisitDorm(function(arg_31_0)
				if arg_31_0.result == 1 then
					local var_31_0 = {
						name = arg_31_0.name,
						msg = arg_31_0,
						playerid = arg_31_0.playerid,
						faceid = arg_31_0.head_sculpture
					}

					self.playername = var_31_0.name
					self.playerid = var_31_0.playerid
					self.faceid = var_31_0.faceid

					self:initData(var_31_0)
					self:initTimer()

					self.buildingId = var_0_0.min(self.buildingId, #self.roomInfos / var_0_33)

					self:initBuildingBtn()
					self:initListView()
					self:delayShowOpenDoorLayout()
					self:initTop()
				end
			end)
		end)
	end)
end

function DormVisitLayer:initSelectTipsLayoutVisible(arg_32_1, arg_32_2)
	arg_32_1:hide()

	if self.roomInfos[arg_32_2] and self.selectType ~= var_0_38.NORMAL and self.roomInfos[arg_32_2].state == var_0_36.ATHOME then
		arg_32_1:show()
	end
end

function DormVisitLayer:initShieldingLayoutVisible(arg_33_1, arg_33_2)
	arg_33_1:hide()

	if self.roomInfos[arg_33_2] then
		if self.selectType == var_0_38.MOVE_AWAY then
			if self.roomInfos[arg_33_2].state ~= var_0_36.ATHOME then
				arg_33_1:show()
			end
		elseif self.selectType == var_0_38.DECORATION and self.roomInfos[arg_33_2].state ~= var_0_36.ATHOME and self.roomInfos[arg_33_2].state ~= var_0_36.TRAVELBACK and self.roomInfos[arg_33_2].state ~= var_0_36.PLOT and self.roomInfos[arg_33_2].state ~= var_0_36.UNLOCK then
			arg_33_1:show()
		end
	end
end

function DormVisitLayer:initDoorLayout()
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

function DormVisitLayer:initTouchMoveLayout()
	local var_37_0 = TempWidget:CreateTempLayout(self._root)

	var_37_0:setLocalZOrder(var_0_32)
	var_37_0:setContentSize(self._root:size())

	local var_37_1
	local var_37_2 = cc.EventListenerTouchOneByOne:create()

	var_37_2:registerScriptHandler(function(arg_38_0, arg_38_1)
		var_37_1 = arg_38_0:getLocation()

		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_37_2:registerScriptHandler(function(arg_39_0, arg_39_1)
		return
	end, cc.Handler.EVENT_TOUCH_MOVED)
	var_37_2:registerScriptHandler(function(arg_40_0, arg_40_1)
		local var_40_0 = arg_40_0:getLocation()

		if var_0_2(var_40_0.y - var_37_1.y) >= 100 then
			return false
		end

		if self.selectType == var_0_38.NORMAL then
			if var_40_0.x - var_37_1.x > 200 then
				if self.buildingId > 1 then
					print("右移")
					self:moveRight()
				end
			elseif var_40_0.x - var_37_1.x < -200 and self.buildingId < #self.roomInfos / var_0_33 then
				print("左移")
				self:moveLeft()
			end
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	var_37_2:setSwallowTouches(false)
	var_37_0:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_37_2, var_37_0)
end

function DormVisitLayer:hideDefaultListView(arg_41_1)
	local var_41_0 = self.defaultLisiView:getChildren()
	local var_41_1 = arg_41_1 % var_0_33

	if arg_41_1 % var_0_33 == 0 then
		var_41_1 = var_0_33
	end

	if var_41_0[var_41_1] then
		performWithDelay(var_41_0[var_41_1], function()
			var_41_0[var_41_1]:setVisible(false)
		end, var_0_34)
	end
end

function DormVisitLayer:showCloseDoorLayout(arg_43_1)
	local var_43_0 = self.listViewDoorLayout
	local var_43_2 = 0

	self.listViewDoorLayout:show()
	self.listViewDoorLayout:stopAllActions()
	self.listViewDoorLayout._leftDoorImg:stopAllActions()
	self.listViewDoorLayout._rightDoorImg:stopAllActions()
	self.listViewDoorLayout._leftDoorImg:align(cc.p(0, 0.5), -self.listViewDoorLayout._leftDoorImg:size().w, self.listViewDoorLayout:size().h / 2)
	self.listViewDoorLayout._rightDoorImg:align(cc.p(1, 0.5), self.listViewDoorLayout:size().w + self.listViewDoorLayout._rightDoorImg:size().w, self.listViewDoorLayout:size().h / 2)
	self.listViewDoorLayout._leftDoorImg:runAction(cc.Sequence:create(cc.MoveBy:create(0.5, cc.p(self.listViewDoorLayout._leftDoorImg:size().w, 0)), cc.CallFunc:create(function()
		var_43_2 = var_43_2 + 1
	end)))
	self.listViewDoorLayout._rightDoorImg:runAction(cc.Sequence:create(cc.MoveBy:create(0.5, cc.p(-self.listViewDoorLayout._rightDoorImg:size().w, 0)), cc.CallFunc:create(function()
		var_43_2 = var_43_2 + 1
	end)))
	schedule(self.listViewDoorLayout, function()
		if var_43_2 >= 2 then
			if arg_43_1 then
				arg_43_1()
			end

			var_43_0:stopAllActions()
		end
	end, 0.016666666666666666)
end

function DormVisitLayer:delayShowOpenDoorLayout()
	local var_47_0 = self.listViewDoorLayout
	local var_47_2 = 0

	self.listViewDoorLayout:show()
	self.listViewDoorLayout:stopAllActions()
	self.listViewDoorLayout._leftDoorImg:stopAllActions()
	self.listViewDoorLayout._rightDoorImg:stopAllActions()
	self.listViewDoorLayout._leftDoorImg:align(cc.p(0, 0.5), 0, self.listViewDoorLayout:size().h / 2)
	self.listViewDoorLayout._rightDoorImg:align(cc.p(1, 0.5), self.listViewDoorLayout:size().w, self.listViewDoorLayout:size().h / 2)

	local var_47_3 = 0

	schedule(self.listViewDoorLayout, function()
		var_47_3 = var_47_3 + 1

		if self.bInitOver or var_47_3 > 60 then
			var_47_0._leftDoorImg:runAction(cc.Sequence:create(cc.MoveBy:create(0.5, cc.p(-var_47_0._leftDoorImg:size().w, 0)), cc.CallFunc:create(function()
				var_47_2 = var_47_2 + 1

				if var_47_2 == 2 then
					var_47_0:hide()
				end
			end)))
			var_47_0._rightDoorImg:runAction(cc.Sequence:create(cc.MoveBy:create(0.5, cc.p(var_47_0._rightDoorImg:size().w, 0)), cc.CallFunc:create(function()
				var_47_2 = var_47_2 + 1

				if var_47_2 == 2 then
					var_47_0:hide()
				end
			end)))
			var_47_0:stopAllActions()
		end
	end, 0.016666666666666666)
end

function DormVisitLayer:showDefaultDoorLayoutMove(arg_51_1)
	if arg_51_1 == var_0_40.LEFT then
		self.defaultDoorLayout:move(GameDisplay.width, 0)
	elseif arg_51_1 == var_0_40.RIGHT then
		self.defaultDoorLayout:move(-GameDisplay.width, 0)
	end

	local var_51_0 = 0.5

	self.defaultDoorLayout:show()
	self.defaultDoorLayout:runAction(cc.MoveTo:create(var_51_0, cc.p(0, 0)))
end

function DormVisitLayer:initBuildingBtn()
	local var_52_0 = self.listView:getLocalZOrder()

	if not self.btnListView then
		local var_52_1 = BottomBtnList:create(function(arg_53_0, arg_53_1)
			if arg_53_1 ~= ccui.TouchEventType.ended then
				return
			end

			KeyCodeManager:onKeyReleasedCallFunc()
		end)

		var_52_1:setPosition(0, 0)
		self._root:addChild(var_52_1, var_52_0 + 1)

		local var_52_2 = TempWidget:CreateTempImg(var_0_27 .. "buliding_bg.png")

		var_52_2:align(cc.p(0, 0), 110, -15)
		var_52_1:addChild(var_52_2, var_52_0 + 1)

		local var_52_3 = TempWidget:CreateTempListView(var_52_2)

		var_52_3:setDirection(ccui.ListViewDirection.horizontal)
		var_52_3:setContentSize(cc.size(var_52_2:size().w - 130, var_52_2:size().h))
		var_52_3:move(15, 0)

		self.btnListView = var_52_3
	end

	self.buildBtnTable = {}

	self.btnListView:removeAllItems()

	local var_52_4 = self.btnListView:size().w / (#self.roomInfos / var_0_33)

	for iter_52_0 = 1, #self.roomInfos / var_0_33 do
		local var_52_5 = "buliding_btn_off" .. iter_52_0 .. ".png"

		if self.buildingId == iter_52_0 then
			var_52_5 = "buliding_btn" .. iter_52_0 .. ".png"
		end

		local var_52_6 = TempWidget:CreateTempLayout()

		var_52_6:setContentSize(cc.size(var_52_4, self.btnListView:size().h))
		var_52_6:move(var_52_4 * (iter_52_0 - 1), 0)
		self.btnListView:pushBackCustomItem(var_52_6)

		local var_52_7 = TempWidget:CreateTempBtn(var_0_27 .. var_52_5)

		var_52_6:addChild(var_52_7)
		var_52_7:center()
		var_52_7:_addEvent(function()
			if self.selectType == var_0_38.NORMAL and iter_52_0 ~= self.buildingId then
				if iter_52_0 < self.buildingId then
					self:moveRight(iter_52_0)
				else
					self:moveLeft(iter_52_0)
				end

				self:updateBuildingBtn()
			end
		end)
		var_52_6:_addEvent(function()
			if self.selectType == var_0_38.NORMAL and iter_52_0 ~= self.buildingId then
				if iter_52_0 < self.buildingId then
					self:moveRight(iter_52_0)
				else
					self:moveLeft(iter_52_0)
				end

				self:updateBuildingBtn()
			end
		end)

		self.buildBtnTable[iter_52_0] = var_52_7
	end
end

function DormVisitLayer:updateBuildingBtn()
	for iter_56_0 = 1, #self.buildBtnTable do
		self.buildBtnTable[iter_56_0]:loadTextureNormal(var_0_27 .. ((iter_56_0 == self.buildingId or nil) and "buliding_btn" .. iter_56_0 .. ".png"), var_0_18)
	end
end

function DormVisitLayer:initListView()
	self.listView:removeAllItems()

	self.bInitOver = false
	self.initPro = {}

	for iter_57_0 = (self.buildingId - 1) * var_0_33 + 1, self.buildingId * var_0_33 do
		print(self.buildingId)

		if self.dormRoomConfig[iter_57_0].soulid and self.dormRoomConfig[iter_57_0].soulid > 0 then
			self.initPro[iter_57_0] = 0
		end
	end

	if not next(self.initPro) then
		self.bInitOver = true
	end

	for iter_57_1 = (self.buildingId - 1) * var_0_33 + 1, self.buildingId * var_0_33 do
		local var_57_0 = QuickCell:Create({
			wid = var_0_20,
			hei = var_0_21,
			activeEvent = function(arg_58_0)
				return true
			end,
			tick_interval = var_0_34,
			createCell = function()
				return self:createCell(iter_57_1)
			end
		})

		var_57_0:setName("RoomCell" .. ((((self.buildingId - 1) * var_0_33 + 1) % var_0_33 == 0 or nil) and var_0_33))
		var_57_0:setVisible(false)
		performWithDelay(var_57_0, function()
			var_57_0:setVisible(true)
		end, ((iter_57_1 % var_0_33 == 0 or nil) and var_0_33) * var_0_34 / 2)
		self.listView:pushBackCustomItem(var_57_0)
	end

	self:addScrollViewBar()
	self.textureDetection:stopAllActions()
	schedule(self.textureDetection, function()
		if self.bInitOver then
			self.textureDetection:stopAllActions()

			self.jumpIndex = nil

			texture_manager:removeUnusedSpineTextures()
		end
	end, 0.016666666666666666)
end

function DormVisitLayer:addScrollViewBar()
	if not self.scrollBarImg then
		local var_62_0 = TempWidget:CreateTempImg(var_0_27 .. "scrollView_bar.png", self._root)

		var_62_0:setScale9Enabled(true)
		var_62_0:setCapInsets(cc.rect(var_62_0:getContentSize().width / 2 - 1, var_62_0:getContentSize().height / 2 - 1, 2, 2))
		var_62_0:setContentSize(cc.size(5, self.listView:size().h))
		var_62_0:align(cc.p(1, 1), self._root:size().w, self.listView:pos().y + self.listView:getContentSize().height)

		self.scrollBarImg = var_62_0

		self.listView:addScrollViewEventListener(function(arg_63_0, arg_63_1)
			self:updateScrollBar()
		end)
		performWithDelay(var_62_0, handler(self, self.updateScrollBar), 0.016666666666666666)
	end
end

function DormVisitLayer:updateScrollBar()
	local var_64_0 = self.listView
	local var_64_1 = self.listView:getContentSize()
	local var_64_2 = self.scrollBarImg

	local function var_64_3()
		local var_65_0 = var_64_0:getInnerContainerPosition()
		local var_65_1 = var_64_0:getInnerContainerSize()
		local var_65_2 = var_64_1.height

		if var_65_0.y > 0 then
			var_65_2 = var_65_2 - var_65_0.y
		elseif var_65_0.y < var_64_1.height - var_65_1.height then
			var_65_2 = var_65_2 + (var_65_0.y - (var_64_1.height - var_65_1.height))
		end

		return var_65_2 / var_65_1.height * 100
	end

	;(function()
		var_64_2:setContentSize((cc.size(var_64_2:getContentSize().width, var_64_1.height * var_64_3() / 100)))
		var_64_2:setPosition((cc.p(var_64_1.width, var_64_0:pos().y + var_64_2:size().h + (var_64_1.height - var_64_2:size().h) * (100 - var_64_0:getPercent()) / 100)))
	end)()
end

function DormVisitLayer:getRewards(arg_67_1)
	if config._DEBUG and self.roomInfos[arg_67_1].conversation then
		assert(travel_conversation_data[self.roomInfos[arg_67_1].conversation * 100 + 1], "@郑佳 invalid travel conversation id: " .. self.roomInfos[arg_67_1].conversation .. "01")
	end

	local var_67_0 = self.roomInfos[arg_67_1].conversation
	local var_67_1

	dormitory_manager:gainTravelAwards(self.roomInfos[arg_67_1].soulid, function(arg_68_0, arg_68_1, arg_68_2)
		if arg_68_0 then
			var_67_1 = {
				labels = L_DORM_TOUCH_EVENT_MSG.TRAVELBACK.labels,
				items = arg_68_0,
				postcards = arg_68_1
			}
		end

		self.roomInfos[arg_67_1].state = var_0_36.ATHOME

		self:updateCell(arg_67_1, var_0_36.TRAVELBACK)

		if not var_67_0 and var_67_1 then
			if var_67_1.postcards then
				LayerManager:pushInLayer("PopGainPostcard", var_67_1)
			else
				LayerManager:pushInLayer("PopPurchaseResultLayer", var_67_1)
			end
		end
	end)

	if var_67_0 then
		global_basic_scene:addChild(TalkLayer:create(var_67_0, nil, TALK_TYPE_TRAVEL, "", function()
			if var_67_1 then
				if var_67_1.postcards then
					LayerManager:pushInLayer("PopGainPostcard", var_67_1)
				else
					LayerManager:pushInLayer("PopPurchaseResultLayer", var_67_1)
				end
			end
		end), ZORDER_TALKLAYER)
	end
end

function DormVisitLayer:levelTips(arg_70_1)
	if self.roomInfos[arg_70_1] then
		global_ShowBlockWords(major_factor_data[self.roomInfos[arg_70_1].soulid].easy_name .. L_DORM_TOUCH_EVENT_MSG.PLOT)
		LayerManager:pushInLayer("DormRoomLayer", {
			isout = true,
			soulid = self.roomInfos[arg_70_1].soulid,
			roomorder = var_0_0.ceil(arg_70_1 / 4),
			exitCallback = function()
				if var_0_41 then
					self:updateStateLayout(arg_70_1)
				end
			end,
			index = arg_70_1
		})
	end
end

function DormVisitLayer:intoRoom(arg_72_1)
	LayerManager:pushInLayer("DormRoomLayer", {
		soulid = self.roomInfos[arg_72_1].soulid,
		roomorder = var_0_0.ceil(arg_72_1 / 4),
		updateDressCallback = function()
			if var_0_41 and self.roomInfos[arg_72_1] then
				local var_73_0 = self.listView:getChildren()
				local var_73_1 = arg_72_1 % var_0_33

				if arg_72_1 % var_0_33 == 0 then
					var_73_1 = var_0_33
				end

				if var_73_0 and var_73_0[var_73_1] and var_73_0[var_73_1]:IsEnter() then
					self:removeDirector(arg_72_1)
					self:initDirector(ui_delegate(var_73_0[var_73_1]).posLayout._childData, arg_72_1)
				end
			end
		end,
		exitCallback = function()
			if var_0_41 and self.roomInfos[arg_72_1] then
				self:updateStateLayout(arg_72_1)
				self:updateRed()
			end
		end,
		index = arg_72_1
	})
end

function DormVisitLayer.selectRole(arg_75_0, arg_75_1)
	local var_75_0 = {}

	if dormitory_manager.exploreingSouls then
		for iter_75_0, iter_75_1 in pairs(dormitory_manager.exploreingSouls) do
			table.insert(var_75_0, iter_75_0)
		end
	end

	LayerManager:pushInLayer("GirlSelectLayer", {
		selectType = 3,
		sureCallBack = function(arg_76_0)
			if ListButtonLayer.getInstance() then
				ListButtonLayer.getInstance():showLayer()
			end

			dormitory_manager:settle_in(arg_76_0, arg_75_1, function(arg_77_0)
				if arg_77_0 == 1 then
					arg_75_0.roomInfos[arg_75_1].state = var_0_36.ATHOME
					arg_75_0.roomInfos[arg_75_1].soulid = arg_76_0

					arg_75_0:updateCell(arg_75_1)
				end
			end)
		end,
		exitcallback = function()
			if ListButtonLayer.getInstance() then
				ListButtonLayer.getInstance():showLayer()
			end
		end,
		outSide = var_75_0
	})
end

function DormVisitLayer:moveAwayRole(arg_79_1)
	local var_79_0 = self.roomInfos[arg_79_1]

	if self.roomInfos[arg_79_1] then
		self:moveAwayPop({
			surecallback = function()
				dormitory_manager:move_away(var_79_0.soulid, arg_79_1, function(arg_81_0)
					if arg_81_0 == 1 then
						local var_81_0 = dorm_script_class_data[var_79_0.soulid].class_move_out or (500 + var_79_0.soulid) * 1000 + 1

						self.roomInfos[arg_79_1].state = var_0_36.UNLOCK
						self.roomInfos[arg_79_1].soulid = nil

						self:showOpenSmallDoor(arg_79_1)

						local var_81_1 = self.listView:getChildren()
						local var_81_2 = arg_79_1 % var_0_33

						if arg_79_1 % var_0_33 == 0 then
							var_81_2 = var_0_33
						end

						if var_81_1 and var_81_1[var_81_2] and var_81_1[var_81_2]:IsEnter() then
							local var_81_3 = ui_delegate(var_81_1[var_81_2]).posLayout._childData

							if var_81_3.director then
								var_81_3.director:insertScript(var_81_0, function()
									self:showCloseSmallDoor(arg_79_1)
									self:updateCell(arg_79_1, var_0_36.ATHOME)
								end)
							end
						end
					end
				end)
			end,
			soulid = self.roomInfos[arg_79_1].soulid,
			roomid = arg_79_1
		})
	end
end

function DormVisitLayer:decorationRoom(arg_83_1)
	local var_83_0 = self.roomInfos[arg_83_1]

	if self.roomInfos[arg_83_1] then
		LayerManager:pushInLayer("DormitoryFixturesLayer", {
			goto_back_system_id = 700,
			itemtype = kITEM_FURNITURE,
			itemConditions = {
				roomid = arg_83_1,
				soulid = self.roomInfos[arg_83_1].soulid
			},
			usedItem = playermodel.dormRoomConfig[arg_83_1].furnitures,
			callbacklist = {
				sure = function(arg_84_0, arg_84_1)
					if arg_84_1 then
						local var_84_0
						local var_84_1 = self.listView:getChildren()
						local var_84_2 = arg_83_1 % var_0_33

						if arg_83_1 % var_0_33 == 0 then
							var_84_2 = var_0_33
						end

						if var_84_1 and var_84_1[var_84_2] and var_84_1[var_84_2]:IsEnter() then
							local var_84_3 = ui_delegate(var_84_1[var_84_2]).posLayout._childData
							local var_84_4 = var_84_3.roomDisplayRoleLayout

							dormitory_manager:changeRoomFurniture(arg_83_1, arg_84_0, function()
								var_84_0 = true
							end)

							local var_84_5 = cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
								if var_84_0 then
									self:initDecorationLayout(var_84_3, arg_83_1)

									if var_83_0.soulid and var_84_3.director then
										var_84_3.director:deleteSelf()

										var_84_3.director = theater_director.new_dorm(var_83_0.soulid, var_84_4)

										var_84_3.director:startPlay()
									end

									var_84_4:stopActionByTag(arg_83_1 * 100)
								end
							end)))

							var_84_5:setTag(arg_83_1 * 100)
							var_84_3.roomDisplayRoleLayout:runAction(var_84_5)
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

function DormVisitLayer:roomDisplayClick(arg_88_1)
	if self.selectType == var_0_38.NORMAL then
		if self.roomInfos[arg_88_1].state == var_0_36.UNLOCK then
			self:selectRole(arg_88_1)
		elseif self.roomInfos[arg_88_1].state == var_0_36.TRAVELBACK then
			self:getRewards(arg_88_1)
		elseif self.roomInfos[arg_88_1].state == var_0_36.PLOT then
			self:levelTips(arg_88_1)
		elseif self.roomInfos[arg_88_1].state == var_0_36.ATHOME then
			self:intoRoom(arg_88_1)
		end
	elseif self.selectType == var_0_38.MOVE_AWAY then
		self.selectType = var_0_38.NORMAL

		self:updateSelectType()
		self:moveAwayRole(arg_88_1)
	elseif self.selectType == var_0_38.DECORATION then
		self.selectType = var_0_38.NORMAL

		self:updateSelectType()
		self:decorationRoom(arg_88_1)
	end
end

function DormVisitLayer:quickUnlockRoomClick(arg_89_1)
	local var_89_0 = {
		goto_back_system_id = 700,
		sureCallback = function(arg_90_0, arg_90_1, arg_90_2)
			dormitory_manager:quick_unlock_room(arg_89_1, arg_90_0, arg_90_1, function(arg_91_0)
				if arg_91_0.time <= 0 then
					global_ShowBlockWords(L_UNLOCK_SUCCESS)

					self.roomInfos[arg_89_1].state = var_0_36.UNLOCK

					audio_manager:playeffectMusic(DORM_UNLOCK_ROOM)
					self:updateCell(arg_89_1)

					if arg_89_1 < #self.roomInfos then
						self.roomInfos[arg_89_1 + 1].state = var_0_36.NEXTLOCK

						self:updateCell(arg_89_1 + 1)
					end
				end

				if arg_90_2 then
					arg_90_2(arg_91_0.result)
				end
			end)
		end
	}

	var_89_0.surplus = self.roomInfos[arg_89_1].last_time or 0

	LayerManager:pushInLayer("PopRoomQuickFinishLayer", var_89_0)
end

function DormVisitLayer.buildCompleteClick(arg_92_0, arg_92_1)
	dormitory_manager:open_room(arg_92_1, function(arg_93_0)
		if arg_93_0.result == 1 then
			global_ShowBlockWords(L_UNLOCK_SUCCESS)

			arg_92_0.roomInfos[arg_92_1].state = var_0_36.UNLOCK

			audio_manager:playeffectMusic(DORM_UNLOCK_ROOM)
			arg_92_0:updateCell(arg_92_1)

			if arg_92_1 < #arg_92_0.roomInfos then
				arg_92_0.roomInfos[arg_92_1 + 1].state = var_0_36.NEXTLOCK

				arg_92_0:updateCell(arg_92_1 + 1)
			end
		end
	end)
end

function DormVisitLayer.unLockClick(arg_94_0, arg_94_1)
	LayerManager:pushInLayer("PopUnlockDormRoomLayer", {
		goto_back_system_id = 700,
		roomid = arg_94_1,
		sureCallback = function(arg_95_0)
			dormitory_manager:unlock_room(arg_94_1, function()
				global_ShowBlockWords(L_DORM_TOUCH_EVENT_MSG.BUILDING)

				arg_94_0.roomInfos[arg_94_1].state = var_0_36.BUILDING

				arg_94_0:updateCell(arg_94_1)

				if arg_95_0 then
					arg_95_0(1)
				end
			end)
		end
	})
end

function DormVisitLayer:showOpenSmallDoor(arg_97_1)
	local var_97_0 = self.listView:getChildren()
	local var_97_1 = arg_97_1 % var_0_33

	if arg_97_1 % var_0_33 == 0 then
		var_97_1 = var_0_33
	end

	if var_97_0 and var_97_0[var_97_1] and var_97_0[var_97_1]:IsEnter() and self.roomInfos[arg_97_1] then
		local var_97_2 = ui_delegate(var_97_0[var_97_1]).posLayout._childData.roomDisplayDecorationLayout

		if var_97_2._childData.smallDoor and var_97_2._childData.smallDoor:isVisible() then
			var_97_2._childData.smallDoor:stopAllActions()
			var_97_2._childData.smallDoor:runAction(cc.ScaleTo:create(0.2, 0, 1))
		end

		if var_97_2._childData.smallDoorSpine and var_97_2._childData.smallDoorSpine:isVisible() then
			var_97_2._childData.smallDoorSpine:stopAllActions()
			var_97_2._childData.smallDoorSpine:runAction(cc.ScaleTo:create(0.2, 0, 1))
		end
	end
end

function DormVisitLayer:showCloseSmallDoor(arg_98_1)
	local var_98_0 = self.listView:getChildren()
	local var_98_1 = arg_98_1 % var_0_33

	if arg_98_1 % var_0_33 == 0 then
		var_98_1 = var_0_33
	end

	if var_98_0 and var_98_0[var_98_1] and var_98_0[var_98_1]:IsEnter() and self.roomInfos[arg_98_1] then
		local var_98_2 = ui_delegate(var_98_0[var_98_1]).posLayout._childData.roomDisplayDecorationLayout

		if var_98_2._childData.smallDoor and var_98_2._childData.smallDoor:isVisible() then
			var_98_2._childData.smallDoor:stopAllActions()
			var_98_2._childData.smallDoor:runAction(cc.ScaleTo:create(0.2, 1, 1))
		end

		if var_98_2._childData.smallDoorSpine and var_98_2._childData.smallDoorSpine:isVisible() then
			var_98_2._childData.smallDoorSpine:stopAllActions()
			var_98_2._childData.smallDoorSpine:runAction(cc.ScaleTo:create(0.2, 1, 1))
		end
	end
end

function DormVisitLayer:updateStateLayout(arg_99_1)
	local var_99_0 = self.listView:getChildren()
	local var_99_1 = arg_99_1 % var_0_33

	if arg_99_1 % var_0_33 == 0 then
		var_99_1 = var_0_33
	end

	if var_99_0 and var_99_0[var_99_1] and var_99_0[var_99_1]:IsEnter() and self.roomInfos[arg_99_1] then
		local var_99_2 = ui_delegate(var_99_0[var_99_1]).posLayout._childData

		if var_99_2.stateLayout then
			var_99_2.stateLayout:stopAllActions()
			var_99_2.stateLayout:setOpacity(255)
			var_99_2.stateLayout:runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.CallFunc:create(function()
				self:initStateLayout(var_99_2, arg_99_1)
			end), cc.FadeIn:create(0.5)))
		end
	end
end

function DormVisitLayer:initRoomDisplayLayout(arg_101_1, arg_101_2)
	if self.roomInfos[arg_101_2].state ~= var_0_36.PLOT then
		self:initDirector(arg_101_1, arg_101_2)
	end

	self:initDecorationLayout(arg_101_1, arg_101_2)
	self:initStateLayout(arg_101_1, arg_101_2)
end

function DormVisitLayer:initStateLayout(arg_102_1, arg_102_2)
	arg_102_1.stateLayout:removeAllChildren()

	arg_102_1.stateLayout._childData = {}

	local var_102_0 = TempWidget:CreateTempImg(var_0_19 .. "default_state.png")

	arg_102_1.stateLayout:addChild(var_102_0)
	var_102_0:align(cc.p(1, 0.5), arg_102_1.stateLayout:size().w, arg_102_1.stateLayout:size().h / 2)

	arg_102_1.stateLayout._childData.bg = var_102_0

	TempWidget:CreateTempImg((self.roomInfos[arg_102_2].soulid or nil) and var_0_27 .. string.format("efficient%d.png", (dormitory_manager:get_furniture_add_favor(playermodel.dormRoomConfig[arg_102_2].furnitures, self.roomInfos[arg_102_2].soulid))), arg_102_1.stateLayout):align(cc.p(0, 0.5), 0, arg_102_1.stateLayout:size().h / 2)
end

function DormVisitLayer:initDirector(arg_103_1, arg_103_2, arg_103_3)
	if self.roomInfos[arg_103_2] then
		if self.roomInfos[arg_103_2].soulid then
			if arg_103_1.director then
				arg_103_1.director:deleteSelf()

				arg_103_1.director = nil
			end

			arg_103_1.director = theater_director.new_dorm_visit(self.roomInfos[arg_103_2].soulid, arg_103_1.roomDisplayRoleLayout, arg_103_3, self.dress_config, self.dormRoomConfig[arg_103_2])

			arg_103_1.director:startPlay()

			self.initPro[arg_103_2] = 1

			local var_103_0 = true

			for iter_103_0, iter_103_1 in pairs(self.initPro) do
				if iter_103_1 == 0 then
					var_103_0 = false

					break
				end
			end

			self.bInitOver = var_103_0
		end
	end
end

function DormVisitLayer:removeDirector(arg_104_1)
	local var_104_0 = self.listView:getChildren()
	local var_104_1 = arg_104_1 % var_0_33

	if arg_104_1 % var_0_33 == 0 then
		var_104_1 = var_0_33
	end

	if var_104_0 and var_104_0[var_104_1] and var_104_0[var_104_1]:IsEnter() and self.roomInfos[arg_104_1] then
		local var_104_2 = ui_delegate(var_104_0[var_104_1]).posLayout._childData

		if var_104_2.director then
			var_104_2.director:deleteSelf()

			var_104_2.director = nil
		end
	end
end

function DormVisitLayer:initDecorationLayout(arg_105_1, arg_105_2)
	local var_105_0 = {
		{
			textureType = 0,
			path = "mainScenebg/dorm_room_bg/"
		}
	}

	setmetatable(var_105_0, {
		__index = function(arg_106_0, arg_106_1)
			return {
				textureType = 0,
				path = "mainScenebg/furnitures/"
			}
		end
	})

	local var_105_1 = {
		[var_0_39.DECORATION_BG] = cc.p(arg_105_1.roomDisplayDecorationLayout:size().w / 2, arg_105_1.roomDisplayDecorationLayout:size().h / 2),
		[var_0_39.DECORATION_BOX] = cc.p(arg_105_1.roomDisplayDecorationLayout:size().w / 2 - 160, arg_105_1.roomDisplayDecorationLayout:size().h / 2 - 37),
		[var_0_39.DECORATION_BED] = cc.p(arg_105_1.roomDisplayDecorationLayout:size().w / 2 + 207, arg_105_1.roomDisplayDecorationLayout:size().h / 2 - 34),
		[var_0_39.DECORATION_BOX_BACK] = cc.p(arg_105_1.roomDisplayDecorationLayout:size().w / 2 - 5, arg_105_1.roomDisplayDecorationLayout:size().h / 2 + 25),
		[var_0_39.DECORATION_WINDOWS] = cc.p(arg_105_1.roomDisplayDecorationLayout:size().w / 2 + 200, arg_105_1.roomDisplayDecorationLayout:size().h / 2 + 17)
	}
	local var_105_2 = {
		[var_0_39.DECORATION_BG] = cc.p(0.5, 0.5),
		[var_0_39.DECORATION_BOX] = cc.p(0, 0),
		[var_0_39.DECORATION_BED] = cc.p(0, 0),
		[var_0_39.DECORATION_BOX_BACK] = cc.p(0, 0),
		[var_0_39.DECORATION_WINDOWS] = cc.p(0, 0)
	}

	var_105_1[2] = FURNITURE_POS[2]
	var_105_1[3] = FURNITURE_POS[3]
	var_105_1[4] = FURNITURE_POS[4]
	var_105_1[5] = FURNITURE_POS[5]

	local var_105_3 = arg_105_1.roomDisplayDecorationLayout._childData.smallDoor

	if not arg_105_1.roomDisplayDecorationLayout._childData.smallDoor then
		arg_105_1.roomDisplayDecorationLayout._childData.smallDoor = TempWidget:CreateTempImg("mainScenebg/furnitures/" .. 6500005 .. ".png", arg_105_1.roomDisplayDecorationLayout, 0)

		arg_105_1.roomDisplayDecorationLayout._childData.smallDoor:move(arg_105_1.roomDisplayDecorationLayout:size().w / 2 - 269, arg_105_1.roomDisplayDecorationLayout:size().h / 2 - 4)
		arg_105_1.roomDisplayDecorationLayout._childData.smallDoor:setLocalZOrder(1)

		var_105_3 = arg_105_1.roomDisplayDecorationLayout._childData.smallDoor
	end

	var_105_3:setVisible(false)

	local var_105_4 = arg_105_1.roomDisplayDecorationLayout._childData.smallDoorSpine

	if arg_105_1.roomDisplayDecorationLayout._childData.smallDoorSpine then
		var_105_4:setVisible(false)
	end

	for iter_105_0, iter_105_1 in pairs(self.dormRoomConfig[arg_105_2].furnitures) do
		local var_105_5 = arg_105_1.roomDisplayDecorationLayout._childData[iter_105_0]
		local var_105_6 = arg_105_1.roomDisplayDecorationLayout._childData.furnitureSpine[iter_105_0]

		if arg_105_1.roomDisplayDecorationLayout._childData.furnitureSpine[iter_105_0] then
			var_105_6:setVisible(false)
			var_105_6:setLocalZOrder(FURNITURE_ZORDER[iter_105_0])
		end

		if not var_105_5 then
			var_105_5 = TempWidget:CreateTempImg(nil, arg_105_1.roomDisplayDecorationLayout, var_105_0[iter_105_0].textureType)

			var_105_5:setLocalZOrder(FURNITURE_ZORDER[iter_105_0])
			var_105_5:setAnchorPoint(var_105_2[iter_105_0])

			local var_105_7 = item_data[iter_105_1].init_x or var_105_1[iter_105_0].x
			local var_105_8 = item_data[iter_105_1].init_y or var_105_1[iter_105_0].y

			var_105_5:move(var_105_7, var_105_8)

			if item_data[iter_105_1].offset then
				local var_105_9, var_105_10 = item_data[iter_105_1].offset:match("([^,]+),(.+)")

				var_105_5:setPosition(var_105_7 + (tonumber(var_105_9) or 0), var_105_8 + (tonumber(var_105_10) or 0))
			end

			arg_105_1.roomDisplayDecorationLayout._childData[iter_105_0] = var_105_5
		end

		var_105_5:hide()

		if iter_105_1 > 0 then
			if not item_data[iter_105_1].spine_dorm then
				var_105_5:show()
				var_105_5:loadTexture(var_105_0[iter_105_0].path .. item_data[iter_105_1].image_dorm .. ".png", 0)
				var_105_5:setLocalZOrder(FURNITURE_ZORDER[iter_105_0])

				local var_105_12 = item_data[iter_105_1].init_x or var_105_1[iter_105_0].x
				local var_105_13 = item_data[iter_105_1].init_y or var_105_1[iter_105_0].y

				var_105_5:move(var_105_12, var_105_13)

				if item_data[iter_105_1].offset then
					local var_105_14, var_105_15 = item_data[iter_105_1].offset:match("([^,]+),(.+)")

					var_105_5:setPosition(var_105_12 + (tonumber(var_105_14) or 0), var_105_13 + (tonumber(var_105_15) or 0))
				end

				if iter_105_0 == 1 then
					var_105_3:loadTexture("mainScenebg/furnitures/" .. (item_data[iter_105_1].image_dorm or 6500005) .. ".png")
					var_105_3:setVisible(true)
				end
			else
				var_105_5:hide()

				if iter_105_0 == 1 then
					if not var_105_4 then
						var_105_4 = L2Skeleton:create("spine/furniture/" .. item_data[iter_105_1].spine_dorm .. "_men.json", "spine/furniture/" .. item_data[iter_105_1].spine_dorm .. "_men.atlas", nil, true)

						var_105_4:setPosition(var_105_1[1].x, var_105_1[1].y)
						arg_105_1.roomDisplayDecorationLayout:addChild(var_105_4, FURNITURE_ZORDER[iter_105_0])

						arg_105_1.roomDisplayDecorationLayout._childData.smallDoorSpine = var_105_4
					else
						var_105_4:setVisible(true)
						var_105_4:resetL2Skeleton("spine/furniture/" .. item_data[iter_105_1].spine_dorm .. "_men.json", "spine/furniture/" .. item_data[iter_105_1].spine_dorm .. "_men.atlas", nil, true)
					end

					var_105_4:refreshSkeleton()
					var_105_4:play("animate", true)
				end

				if not var_105_6 then
					var_105_6 = L2Skeleton:create("spine/furniture/" .. item_data[iter_105_1].spine_dorm .. ".json", "spine/furniture/" .. item_data[iter_105_1].spine_dorm .. ".atlas", nil, true)

					var_105_6:setPosition(var_105_1[1])
					arg_105_1.roomDisplayDecorationLayout:addChild(var_105_6, FURNITURE_ZORDER[iter_105_0])

					arg_105_1.roomDisplayDecorationLayout._childData.furnitureSpine[iter_105_0] = var_105_6
				else
					var_105_6:setVisible(true)
					var_105_6:resetL2Skeleton("spine/furniture/" .. item_data[iter_105_1].spine_dorm .. ".json", "spine/furniture/" .. item_data[iter_105_1].spine_dorm .. ".atlas", nil, true)
				end

				var_105_6:refreshSkeleton()
				var_105_6:play("animate", true)
			end
		else
			var_105_5:hide()
		end
	end
end

function DormVisitLayer:isStateLayoutUp(arg_107_1)
	local var_107_0
	local var_107_1

	if self.roomInfos[arg_107_1].state == var_0_36.TRAVELBACK then
		var_107_0 = var_0_35.TRAVEL
		var_107_1 = false
	elseif self.roomInfos[arg_107_1].state == var_0_36.EXPLORING or self.roomInfos[arg_107_1].state == var_0_36.PLOT then
		var_107_0 = var_0_35.LEAVE
		var_107_1 = false
	elseif self.roomInfos[arg_107_1].state == var_0_36.UNLOCK then
		var_107_1 = false
		var_107_0 = var_0_35.SETTLE_IN
	elseif self.roomInfos[arg_107_1].state == var_0_36.ATHOME then
		var_107_1 = true
		var_107_0 = var_0_35.NOTHING
	else
		var_107_1 = true
		var_107_0 = var_0_35.SETTLE_IN
	end

	return var_107_0, var_107_1
end

function DormVisitLayer.showBuildCompleteLayout(arg_108_0, arg_108_1)
	arg_108_1.remainBuildingLayout:hide()
	arg_108_1.buildCompleteLayout:show()
end

function DormVisitLayer:startBuildingRemain(arg_109_1, arg_109_2)
	local var_109_0 = self.roomInfos[arg_109_2]

	if self.roomInfos[arg_109_2] and self.roomInfos[arg_109_2].state == var_0_36.BUILDING then
		local var_109_1 = arg_109_1.remainTimeText

		arg_109_1.remainTimeText:setString("")

		local var_109_2 = self.roomInfos[arg_109_2].last_time

		if self.roomInfos[arg_109_2].last_time and self.roomInfos[arg_109_2].last_time > 0 then
			local var_109_3 = 0.03333333333333333

			schedule(arg_109_1.remainTimeText, function()
				var_109_2 = var_109_2 - var_109_3

				var_109_1:setString(var_0_1(var_0_0.ceil(var_109_2)))

				if var_109_2 <= 0 then
					var_109_1:stopAllActions()

					if var_109_0.state == var_0_36.BUILDING then
						var_109_0.state = var_0_36.BUILDED

						self:updateCell(arg_109_2)
					end
				end
			end, 0.03333333333333333)
		end
	end
end

function DormVisitLayer:buildCompleteStateChange(arg_111_1)
	self:showBuildCompleteLayout(arg_111_1)
end

function DormVisitLayer:atHomeStateChange(arg_112_1, arg_112_2)
	local var_112_0 = self.listView:getChildren()
	local var_112_1 = arg_112_1 % var_0_33

	if arg_112_1 % var_0_33 == 0 then
		var_112_1 = var_0_33
	end

	if var_112_0 and var_112_0[var_112_1] and var_112_0[var_112_1]:IsEnter() then
		local var_112_2 = self.roomInfos[arg_112_1]

		if self.roomInfos[arg_112_1] then
			local var_112_3 = ui_delegate(var_112_0[var_112_1]).posLayout._childData

			self:updateStateLayout(arg_112_1)

			if arg_112_2 and arg_112_2 == var_0_36.TRAVELBACK then
				-- block empty
			else
				local var_112_4 = var_112_3.roomDisplayDecorationLayout

				self:showOpenSmallDoor(arg_112_1)
				var_112_4:runAction(cc.Sequence:create(cc.DelayTime:create(4), cc.CallFunc:create(function()
					self:showCloseSmallDoor(arg_112_1)
				end)))
			end

			self:initDirector(var_112_3, arg_112_1, dorm_script_class_data[var_112_2.soulid].class_move_in or (500 + var_112_2.soulid) * 1000 + 2)
			self:updateStateLayout(arg_112_1)
		end
	end
end

function DormVisitLayer:plotStateChange(arg_114_1)
	self:removeDirector(arg_114_1)
	self:updateStateLayout(arg_114_1)
end

function DormVisitLayer:buildingStateChange(arg_115_1, arg_115_2)
	arg_115_1.nextUnlockLayout:hide()
	arg_115_1.remainBuildingLayout:show()
	self:startBuildingRemain(arg_115_1, arg_115_2)
end

function DormVisitLayer.nextUnlockStateChange(arg_116_0, arg_116_1)
	arg_116_1.nextUnlockLayout:show()
end

function DormVisitLayer:unLockStateChange(arg_117_1, arg_117_2, arg_117_3)
	arg_117_1.buildCompleteLayout:hide()
	arg_117_1.superRoomDisplayLayout:show()

	if arg_117_3 and arg_117_3 == var_0_36.ATHOME then
		-- block empty
	else
		local var_117_0 = arg_117_1.bgLayout

		arg_117_1.bgLayout:stopAllActions()
		var_117_0:runAction(cc.Sequence:create(cc.FadeOut:create(1), cc.CallFunc:create(function()
			var_117_0:hide()
		end), cc.FadeIn:create(0)))
	end

	arg_117_1.remainBuildingLayout:hide()
	arg_117_1.remainTimeText:stopAllActions()
	self:updateStateLayout(arg_117_2)
	self:initDecorationLayout(arg_117_1, arg_117_2)
end

function DormVisitLayer:updateCell(arg_119_1, arg_119_2)
	local var_119_0 = self.listView:getChildren()
	local var_119_1 = arg_119_1 % var_0_33

	if arg_119_1 % var_0_33 == 0 then
		var_119_1 = var_0_33
	end

	if var_119_0 and var_119_0[var_119_1] and var_119_0[var_119_1]:IsEnter() then
		if self.roomInfos[arg_119_1] then
			local var_119_2 = ui_delegate(var_119_0[var_119_1]).posLayout._childData

			if var_0_36.UNLOCK == self.roomInfos[arg_119_1].state then
				self:unLockStateChange(var_119_2, arg_119_1, arg_119_2)
			elseif var_0_36.LOCK == self.roomInfos[arg_119_1].state then
				-- block empty
			elseif var_0_36.BUILDING == self.roomInfos[arg_119_1].state then
				self:buildingStateChange(var_119_2, arg_119_1)
			elseif var_0_36.BUILDED == self.roomInfos[arg_119_1].state then
				self:buildCompleteStateChange(var_119_2)
			elseif var_0_36.ATHOME == self.roomInfos[arg_119_1].state then
				self:atHomeStateChange(arg_119_1, arg_119_2)
			elseif var_0_36.TRAVELBACK == self.roomInfos[arg_119_1].state then
				-- block empty
			elseif var_0_36.PLOT == self.roomInfos[arg_119_1].state then
				self:plotStateChange(arg_119_1)
			elseif var_0_36.NEXTLOCK == self.roomInfos[arg_119_1].state then
				self:nextUnlockStateChange(var_119_2)
			end
		end
	end
end

function DormVisitLayer:updateSelectType()
	self:updateLogoVisible()

	local var_120_0 = self.selectType

	if self.selectType == var_0_38.NORMAL then
		self.moveAwayBtn:show()
		self.decorationBtn:show()
	elseif var_120_0 == var_0_38.MOVE_AWAY then
		self.moveAwayBtn:show()
		self.decorationBtn:hide()
	elseif var_120_0 == var_0_38.DECORATION then
		self.moveAwayBtn:hide()
		self.decorationBtn:show()
	end

	local var_120_1 = self.listView:getChildren()

	for iter_120_0 = 1, var_0_33 do
		if var_120_1 and var_120_1[iter_120_0] and var_120_1[iter_120_0]:IsEnter() then
			local var_120_2 = self.roomInfos[iter_120_0 + (self.buildingId - 1) * var_0_33]

			if self.roomInfos[iter_120_0 + (self.buildingId - 1) * var_0_33] then
				local var_120_3 = ui_delegate(var_120_1[iter_120_0]).posLayout._childData
				local var_120_4 = var_120_3.shieldingLayout
				local var_120_5 = var_120_3.selectTipsLayout

				if var_120_0 == var_0_38.NORMAL then
					var_120_4:hide()
					var_120_5:hide()
				elseif var_120_0 == var_0_38.MOVE_AWAY then
					var_120_4:show()
					var_120_5:hide()
				elseif var_120_0 == var_0_38.DECORATION then
					var_120_4:show()
					var_120_5:hide()
				end

				if var_0_36.UNLOCK == var_120_2.state then
					if var_120_0 == var_0_38.NORMAL then
						var_120_4:hide()
						var_120_5:hide()
					elseif var_120_0 == var_0_38.MOVE_AWAY then
						var_120_4:show()
						var_120_5:hide()
					elseif var_120_0 == var_0_38.DECORATION then
						var_120_4:hide()
						var_120_5:show()
					end
				elseif var_0_36.LOCK == var_120_2.state then
					-- block empty
				elseif var_0_36.BUILDING == var_120_2.state then
					-- block empty
				elseif var_0_36.BUILDED == var_120_2.state then
					-- block empty
				elseif var_0_36.ATHOME == var_120_2.state then
					if var_120_0 == var_0_38.NORMAL then
						var_120_4:hide()
						var_120_5:hide()
					elseif var_120_0 == var_0_38.MOVE_AWAY then
						var_120_4:hide()
						var_120_5:show()
					elseif var_120_0 == var_0_38.DECORATION then
						var_120_4:hide()
						var_120_5:show()
					end
				elseif var_0_36.TRAVELBACK == var_120_2.state then
					if var_120_0 == var_0_38.NORMAL then
						var_120_4:hide()
						var_120_5:hide()
					elseif var_120_0 == var_0_38.MOVE_AWAY then
						var_120_4:show()
						var_120_5:hide()
					elseif var_120_0 == var_0_38.DECORATION then
						var_120_4:hide()
						var_120_5:show()
					end
				elseif var_0_36.PLOT == var_120_2.state then
					if var_120_0 == var_0_38.NORMAL then
						var_120_4:hide()
						var_120_5:hide()
					elseif var_120_0 == var_0_38.MOVE_AWAY then
						var_120_4:show()
						var_120_5:hide()
					elseif var_120_0 == var_0_38.DECORATION then
						var_120_4:hide()
						var_120_5:show()
					end
				elseif var_0_36.NEXTLOCK == var_120_2.state then
					-- block empty
				end
			end
		end
	end
end

function DormVisitLayer:updateLogoVisible()
	local var_121_0 = self._root:getChildByName("showLogo")

	if var_121_0 then
		var_121_0:removeFromParent()
	end

	if self.selectType == var_0_38.MOVE_AWAY then
		local var_121_1 = ccui.ImageView:create("Dormitory/move_away_logo.png", var_0_18)

		var_121_1:setPosition(GameDisplay.width / 2, GameDisplay.height * 0.5)
		var_121_1:setName("showLogo")
		self._root:addChild(var_121_1, 10)
	elseif self.selectType == var_0_38.DECORATION then
		local var_121_2 = ccui.ImageView:create("Dormitory/renovation_logo.png", var_0_18)

		var_121_2:setPosition(GameDisplay.width / 2, GameDisplay.height * 0.5)
		var_121_2:setName("showLogo")
		self._root:addChild(var_121_2, 10)
	end
end

function DormVisitLayer:moveAwayPop(arg_122_1)
	local var_122_0 = TempWidget:CreateTempLayout()

	var_122_0:setTouchEnabled(true)
	var_122_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_122_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_122_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_122_0:setBackGroundColorOpacity(160)
	var_122_0:setCascadeOpacityEnabled(false)
	self._root:addChild(var_122_0, 999)
	var_122_0:addTouchEventListener(function(arg_123_0, arg_123_1)
		if arg_123_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_122_0:runAction(cc.RemoveSelf:create())
	end)

	local var_122_1 = TempWidget:CreateTempImg(var_0_27 .. "move_away_pop.png")

	var_122_1:setPosition(GameDisplay.width / 2, GameDisplay.height / 2)
	var_122_0:addChild(var_122_1)

	local var_122_2 = TempWidget:CreateTempBtn("public/button/public_button_orange.png")

	var_122_2:setTitleText(L_BUTTON_TEXT.Comfirm)
	var_122_2:setTitleFontSize(30)
	var_122_2:setTitleColor(cc.c3b(0, 0, 0))
	var_122_2:setTitleFontName(FONT_BUTTON)
	var_122_2:setPosition(180, GameDisplay.height / 2 - 100)
	var_122_0:addChild(var_122_2)
	var_122_2:addTouchEventListener(function(arg_124_0, arg_124_1)
		if arg_124_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_122_1.surecallback then
			arg_122_1.surecallback()
		end

		var_122_0:runAction(cc.RemoveSelf:create())
	end)

	local var_122_3 = TempWidget:CreateTempBtn("public/button/public_button_big_blue_y.png")

	var_122_3:setTitleText(L_BUTTON_TEXT.Can_cel)
	var_122_3:setTitleFontSize(30)
	var_122_3:setTitleColor(cc.c3b(0, 0, 0))
	var_122_3:setTitleFontName(FONT_BUTTON)
	var_122_3:setPosition(GameDisplay.width - 180, GameDisplay.height / 2 - 100)
	var_122_0:addChild(var_122_3)
	var_122_3:addTouchEventListener(function(arg_125_0, arg_125_1)
		if arg_125_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_122_0:runAction(cc.RemoveSelf:create())

		if arg_122_1.cancelcallback then
			arg_122_1.cancelcallback()
		end
	end)

	local var_122_4 = dormitory_manager:getSoulDressModelid(arg_122_1.soulid) or major_factor_data[arg_122_1.soulid].model
	local var_122_5 = TempWidget:CreateTempImg("roleimage/role1/" .. (model_data[var_122_4].cute_Q or model_data[var_122_4].cute_role) .. ".png", var_122_1, 0)

	var_122_5:setAnchorPoint(cc.p(0.5, 0))
	var_122_5:setScale(0.4)
	var_122_5:setPosition(560, 10)

	local var_122_6 = TempWidget:CreateTempLabel(string.format(L_MOVE_AWAY_FROM_DORM.Role, major_factor_data[arg_122_1.soulid].easy_name), FONT_TITLE, 26)

	var_122_6:setPosition(var_122_1:getContentSize().width / 2, 60)
	var_122_1:addChild(var_122_6)

	if playermodel.dormRoomConfig[arg_122_1.roomid].favorpool > 0 then
		local var_122_7 = TempWidget:CreateTempLabel(string.format(L_MOVE_AWAY_FROM_DORM.Favor_rest, playermodel.dormRoomConfig[arg_122_1.roomid].favorpool), FONT_DES, 20)

		var_122_7:setColor(cc.c3b(253, 151, 32))
		var_122_7:setPosition(var_122_1:getContentSize().width / 2, 30)
		var_122_1:addChild(var_122_7)
	end
end

function DormVisitLayer:moveLeft(arg_126_1, arg_126_2)
	self:_move(var_0_40.LEFT, arg_126_1, arg_126_2)
end

function DormVisitLayer:moveRight(arg_127_1, arg_127_2)
	self:_move(var_0_40.RIGHT, arg_127_1, arg_127_2)
end

function DormVisitLayer:resetData()
	self.textureDetection:stopAllActions()
end

function DormVisitLayer:_move(arg_129_1, arg_129_2, arg_129_3)
	self.isMove = arg_129_1

	self.topShieldingLayout:show()
	self:resetData()

	local var_129_0 = self.listView:getChildren()

	self.listView:move(0, var_0_30)

	if arg_129_2 then
		self.buildingId = arg_129_2
	elseif arg_129_1 == var_0_40.LEFT then
		self.buildingId = self.buildingId + 1
	elseif arg_129_1 == var_0_40.RIGHT then
		self.buildingId = self.buildingId - 1
	end

	local var_129_1 = 0.5
	local var_129_2

	if arg_129_1 == var_0_40.LEFT then
		var_129_2 = -GameDisplay.width
	elseif arg_129_1 == var_0_40.RIGHT then
		var_129_2 = GameDisplay.width
	end

	local var_129_3 = cc.Sequence:create(cc.CallFunc:create(function()
		self.listView:runAction(cc.Sequence:create(cc.MoveTo:create(var_129_1, cc.p(var_129_2, var_0_30)), cc.DelayTime:create(0.016666666666666666), cc.CallFunc:create(function()
			self.listView:move(0, var_0_30)
			self:initListView()
			self.defaultDoorLayout:hide()
			self:delayShowOpenDoorLayout()

			if arg_129_3 then
				self.listView:jumpToIndex(arg_129_3, cc.p(0, 1), cc.p(0, 1))
			else
				self.listView:jumpToTop()
			end
		end), cc.DelayTime:create(var_129_1), cc.CallFunc:create(function()
			self.topShieldingLayout:hide()
		end)))
		self:showDefaultDoorLayoutMove(arg_129_1)

		self.isMove = var_0_40.NULL
	end))

	self.topShieldingLayout:stopAllActions()
	self.topShieldingLayout:runAction(var_129_3)
	self:updateBuildingBtn()
end

function DormVisitLayer:createQuickPopList()
	self._root:removeChildByName("_QuickPopList")

	local var_133_0 = false
	local var_133_1
	local var_133_3 = TempWidget:CreateTempLayout(self._root)

	var_133_3:setName("_QuickPopList")
	var_133_3:setContentSize(self._root:size())
	var_133_3:setLocalZOrder(var_0_32)
	var_133_3:_setBack()
	var_133_3:setBackGroundColor(cc.c3b(0, 0, 0))
	var_133_3:setBackGroundColorOpacity(160)
	var_133_3:_addEvent(function()
		if var_133_0 then
			var_133_1:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(-var_133_1:size().w, 0)), cc.CallFunc:create(function()
				var_133_3:hide()
			end)))
		end
	end)

	var_133_1 = TempWidget:CreateTempLayout()

	var_133_1:setContentSize(var_133_3:size())
	var_133_1:align(cc.p(0, 0), -var_133_1:size().w, 0)
	var_133_3:addChild(var_133_1)
	var_133_1:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(0, 0)), cc.CallFunc:create(function()
		var_133_0 = true
	end)))

	local var_133_4 = TempWidget:CreateTempListView()

	var_133_4:setContentSize(cc.size(GameDisplay.width, 810))
	var_133_4:setPosition(0, GameDisplay.height / 2 - var_133_4:size().h / 2 + 50)
	var_133_4:setItemsMargin(50)
	var_133_1:addChild(var_133_4)

	local var_133_5 = TempWidget:CreateTempImg(var_0_29 .. "title.png")

	var_133_5:align(cc.p(0, 0), 0, var_133_4:pos().y + var_133_4:size().h + 25)
	var_133_1:addChild(var_133_5)

	var_133_1.buildId = self.buildingId

	local function var_133_6(arg_137_0)
		local var_137_0 = cc.Node:create()
		local var_137_1 = TempWidget:CreateTempImg("role/portrait/19040.png", nil, 0)

		var_137_1:setAnchorPoint(cc.p(0, 0))
		var_137_1:setPosition(0, 0)
		var_137_1:setName("role")
		var_137_0:addChild(var_137_1)

		local var_137_2 = TempWidget:CreateTempImg(var_0_29 .. "logo.png")

		var_137_2:setName("empty")
		var_137_2:setPosition(62, 52)
		var_137_0:addChild(var_137_2)

		local var_137_3 = TempWidget:CreateTempImg(var_0_29 .. "favor_bg.png")

		var_137_3:setScale9Enabled(true)
		var_137_3:setCapInsets(cc.rect(var_137_3:getContentSize().width / 2 - 1, var_137_3:getContentSize().height / 2 - 1, 2, 2))
		var_137_3:setContentSize(cc.size(108, 20))
		var_137_3:setAnchorPoint(cc.p(0, 0))
		var_137_3:setPosition(2, 0)
		var_137_3:setName("lvBg")
		var_137_0:addChild(var_137_3)

		local var_137_4 = TempWidget:CreateTempImg(var_0_29 .. "heart_icon.png")

		var_137_4:setPosition(20, var_137_3:getContentSize().height / 2)
		var_137_3:addChild(var_137_4)

		local var_137_5 = TempWidget:CreateTempLabel("", FONT_W5, 20)

		var_137_5:setAnchorPoint(cc.p(0, 0.5))
		var_137_5:setPosition(30, var_137_3:getContentSize().height / 2)
		var_137_5:setName("favorLv")
		var_137_3:addChild(var_137_5)

		local var_137_6 = TempWidget:CreateTempLabel("", FONT_NAME, 20, var_137_0)

		var_137_6:setName("nameText")
		var_137_6:move(55, -24)

		function var_137_0:update(arg_138_1)
			local var_138_0 = self:getChildByName("role")
			local var_138_1 = self:getChildByName("empty")
			local var_138_2 = self:getChildByName("lvBg")
			local var_138_3 = self:getChildByName("nameText")

			if self.roomInfos[arg_138_1] and self.roomInfos[arg_138_1].soulid and self.roomInfos[arg_138_1].soulid > 0 then
				var_138_0:setVisible(true)
				var_138_2:setVisible(true)
				var_138_1:setVisible(false)
				var_138_3:setVisible(true)
				var_138_0:loadTexture(ROLE_PORTRAIT_PATH .. model_data[servant_data[major_factor_data[self.roomInfos[arg_138_1].soulid].servant].modelid].portrait_image .. ".png")
				var_138_2:getChildByName("favorLv"):setString("Lv" .. playermodel.favor[self.roomInfos[arg_138_1].soulid].favorlevel)
				var_138_3:setString(major_factor_data[self.roomInfos[arg_138_1].soulid].easy_name)
			elseif self.roomInfos[arg_138_1].state == var_0_36.UNLOCK then
				var_138_1:loadTexture(var_0_29 .. "logo.png", var_0_18)
				var_138_0:setVisible(false)
				var_138_2:setVisible(false)
				var_138_1:setVisible(true)
				var_138_3:setVisible(false)
			else
				var_138_1:loadTexture(var_0_29 .. "logo2.png", var_0_18)
				var_138_0:setVisible(false)
				var_138_2:setVisible(false)
				var_138_1:setVisible(true)
				var_138_3:setVisible(false)
			end
		end

		var_137_0:update(arg_137_0)

		return var_137_0
	end

	for iter_133_0 = 1, var_0_33 / 4 do
		local var_133_7 = TempWidget:CreateTempLayout()
		local var_133_8 = TempWidget:CreateTempImg(var_0_29 .. "floor_bg.png", var_133_7)

		var_133_7:setContentSize(cc.size(var_133_4:size().w, var_133_8:size().h))
		var_133_8:align(cc.p(1, 0.5), var_133_7:size().w, var_133_7:size().h / 2)
		var_133_8:setName("floorBg")
		TempWidget:CreateTempImg(var_0_29 .. "title_once.png", var_133_8):align(cc.p(0, 1), -45, var_133_8:size().h + 23)
		var_133_4:pushBackCustomItem(var_133_7)
		TempWidget:CreateTempLabel("L" .. iter_133_0, FONT_W5, 50, var_133_8):align(cc.p(0, 1), -45, var_133_8:size().h)

		for iter_133_1 = 1, 4 do
			local var_133_9 = var_133_6((var_133_1.buildId - 1) * var_0_33 + (iter_133_0 - 1) * 4 + iter_133_1)

			var_133_9:setName("roleIcon" .. iter_133_1)
			var_133_9:setPosition((iter_133_1 - 1) * 132, 10)
			var_133_8:addChild(var_133_9)
		end

		var_133_8:_addEvent(function()
			if var_133_0 then
				var_133_0 = false

				var_133_1:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(-var_133_1:size().w, 0)), cc.CallFunc:create(function()
					var_133_3:hide()

					if var_133_1.buildId ~= self.buildingId then
						self.jumpIndex = (iter_133_0 - 1) * 4 + 1

						if var_133_1.buildId < self.buildingId then
							self:moveRight(var_133_1.buildId, (iter_133_0 - 1) * 4 + 1)
						else
							self:moveLeft(var_133_1.buildId, (iter_133_0 - 1) * 4 + 1)
						end
					else
						local var_140_0 = self.listView:getPercent()
						local var_140_1 = self.listView:getPercentByIndex((iter_133_0 - 1) * 4 + 1, cc.p(0, 1), cc.p(0, 1))

						if var_140_0 ~= var_140_1 then
							self.listView:scrollToPercentVertical(var_140_1, var_0_2(var_140_1 - var_140_0) / 30, true)
						end
					end
				end)))
			end
		end)
	end

	local function var_133_10()
		local var_141_0 = var_133_4:getChildren()

		for iter_141_0 = 1, #var_141_0 do
			for iter_141_1 = 1, 4 do
				local var_141_1 = var_141_0[iter_141_0]:getChildByName("floorBg"):getChildByName("roleIcon" .. iter_141_1)

				if var_141_1 then
					var_141_1:update((var_133_1.buildId - 1) * var_0_33 + (iter_141_0 - 1) * 4 + iter_141_1)
				end
			end
		end
	end

	local var_133_11 = {}

	for iter_133_2 = 1, #playermodel.dormRoomConfig / var_0_33 do
		local var_133_12 = TempWidget:CreateTempBtn(var_0_29 .. "build" .. iter_133_2 .. "_off.png")

		var_133_11[iter_133_2] = var_133_12

		if iter_133_2 == var_133_1.buildId then
			var_133_12:loadTextureNormal(var_0_29 .. "build" .. iter_133_2 .. "_on.png", var_0_18)
		end

		var_133_12:move(120 + (iter_133_2 - 1) * 130, var_133_4:pos().y - var_133_12:size().h / 2 - 25)
		var_133_1:addChild(var_133_12)
		var_133_12:_addEvent(function()
			var_133_11[var_133_1.buildId]:loadTextureNormal(var_0_29 .. "build" .. var_133_1.buildId .. "_off.png", var_0_18)
			var_133_11[iter_133_2]:loadTextureNormal(var_0_29 .. "build" .. iter_133_2 .. "_on.png", var_0_18)

			var_133_1.buildId = iter_133_2

			var_133_10()
		end)
	end
end

function DormVisitLayer.getAllFavorFromPool(arg_143_0)
	dormitory_manager:getAllFavorFromPool(function(arg_144_0)
		if var_0_41 then
			local var_144_0 = arg_143_0.listView:getChildren()

			for iter_144_0 = 1, #var_144_0 do
				if var_144_0[iter_144_0]:IsEnter() then
					arg_143_0:updateStateLayout((arg_143_0.buildingId - 1) * var_0_33 + iter_144_0)
				end
			end

			arg_143_0:updateRed()
		end
	end)
end

function DormVisitLayer:pop_img()
	local var_145_0 = self:getChildByName("pop_img")

	if not var_145_0 then
		var_145_0 = TempWidget:CreateTempImg(var_0_27 .. "pop_img.png")

		var_145_0:setPosition(320, GameDisplay.height / 2)
		var_145_0:setName("pop_img")
		self:addChild(var_145_0, 999)
	end

	var_145_0:stopAllActions()
	var_145_0:setScaleY(1)
	var_145_0:setOpacity(255)
	var_145_0:runAction((cc.Spawn:create(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeTo:create(2 - 0.5, 50)), cc.Sequence:create(cc.DelayTime:create(2 - 0.5), cc.ScaleTo:create(0.1, 1, 0), cc.RemoveSelf:create()))))
end

function DormVisitLayer.updateLayer(arg_146_0)
	return
end

function DormVisitLayer:updateRed()
	local var_147_0 = self.listView:getChildren()

	for iter_147_0 = 1 + var_0_33 * (self.buildingId - 1), 1 + var_0_33 * (self.buildingId - 1) + (var_0_33 - 1) do
		local var_147_1 = iter_147_0 % var_0_33

		if iter_147_0 % var_0_33 == 0 then
			var_147_1 = var_0_33
		end

		if var_147_0 and var_147_0[var_147_1] and var_147_0[var_147_1]:IsEnter() then
			local var_147_3 = ui_delegate(var_147_0[var_147_1])

			if var_147_3 and var_147_3.posLayout and var_147_3.posLayout._childData then
				if var_147_3.posLayout._childData.stateLayout then
					local var_147_4 = ui_delegate(var_147_3.posLayout._childData.stateLayout)

					if var_147_4 and var_147_4._childData and var_147_4._childData.redImg then
						var_147_4._childData.redImg:setVisible(dormitory_manager:checkRoleSpillageFavorByIndex(iter_147_0))
					end
				end
			end
		end
	end

	if require("controller.costume_room_cumulative_reward_manager"):getInstance():checkRed() then
		self.skinBtnRedImg:show()
	else
		self.skinBtnRedImg:hide()
	end
end

return DormVisitLayer
