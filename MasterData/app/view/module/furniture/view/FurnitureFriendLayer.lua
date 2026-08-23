local var_0_0 = 0.3
local var_0_1 = g.core.config.furniture_info
local var_0_2 = g.core.const.ConstMgr.PARAMETER_CONST
local KsMath = require("app.core.utils.KsMath")
local var_0_4 = g.core.model.User.furnitureData
local var_0_5 = g.core.event.enum
local var_0_6 = g.core.event.EventManager
local var_0_7 = g.core.module.ModuleManager
local FurnitureFriendLayer = class("FurnitureFriendLayer", require("app.fairyGUI.furniture.UI_FurnitureFriendLayer"), function()
	return fgui.GComponent:create({
		resName = "FurnitureFriendLayer",
		pkgPath = "ui/furniture/furniture",
		isFullScreen = true,
		pkgName = "furniture"
	}, ...)
end)

function FurnitureFriendLayer:ctor(arg_2_1)
	self:addBg("bg/furniture/bg_jyxw_jiayuanxiaowu.jpg")

	self._offXRange = (self.m_roomComp:getWidth() - display.width) / 2
	self._offYRange = (self.m_roomComp:getHeight() - display.height) / 2
	self._friendId = arg_2_1 and arg_2_1.friendId
	self._friendCharm = 0
	self._curDormId = 1
	self._dormFloorData = nil
	self._cleanDormId = nil
	self._dragRoleCompName = ""

	self:_initUIListener()
	self:_onSliderChanged()
	self.m_enterTransition:play()
end

function FurnitureFriendLayer:_initUIListener()
	self:addClickListener(handler(self, self._onTouchMySelf))
	self.m_lookBtn:addClickListener(handler(self, self._onClickLookBtn))
	self.m_zoomSlider:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSliderChanged))
	self.m_rankBtn:addClickListener(handler(self, self._onClickRankBtn))
	self.m_praiseBtn:addClickListener(handler(self, self._onClickPraiseBtn))
	self.m_floorTabList:setIniter()
	self.m_floorTabList:setItemRenderer(handler(self, self._onItemRenderFloorTab))
	self.m_floorTabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickFloorTabList))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
end

function FurnitureFriendLayer:onLoad()
	var_0_6:addEventListener(var_0_5.EVENT_NET_S2C_FURNITURE_ROOM_GETINFO, self._onRoomGetInfo, self)
	var_0_6:addEventListener(var_0_5.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onRoomCrossDay), self)
	var_0_6:addEventListener(var_0_5.EVENT_NET_S2C_FURNITURE_ROOM_SWEEP, self._onS2CFurnitureRoomSweep, self)
	var_0_6:addEventListener(var_0_5.EVENT_NET_S2C_FURNITURE_ROOM_PRAISE, self._onS2CFurnitureRoomPraise, self)
	self:_sendFurnitureRoomInfo()

	if var_0_4:isCanCleanFurnitureByUserId(self._friendId) then
		self._cleanDormId = var_0_4:randomDormIdToSweep()

		self.m_roomComp:setDormIdCanSweep(self._cleanDormId)
	else
		self.m_roomComp:setDormIdCanSweep(nil)
	end

	self:_updateFriendPraiseInfo()
	self:_updateFriendRoomInfo()
	self.m_roomComp:updateFurnitureComp()
	self:_initFloorsTabComp()
	self.m_comfortLvComp:updateComp(self._curDormId)
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_SCENE_ROOM)
end

function FurnitureFriendLayer:_initFloorsTabComp()
	self._dormFloorData = var_0_4:getDormFloorData()

	self.m_floorTabList:setNumItems(#self._dormFloorData)
	self.m_floorTabList:setHeight(#self._dormFloorData * 50)
	self.m_floorTabList:setSelectedIndex(var_0_4:getFloorIdxByDormId(self._curDormId) - 1)
end

function FurnitureFriendLayer:_updateFriendRoomInfo()
	self._friendCharm = var_0_4:getFriendCharmValue()

	self.m_charmNumTxt:setText(self._friendCharm)
	self.m_timeTxt:setText(g.core.lang:get(107056, {
		num = var_0_4:getCurSweepTime(),
		maxNum = var_0_4:getSweepDailyMaxTime()
	}))
end

function FurnitureFriendLayer:_updateFriendPraiseInfo()
	local var_7_0 = var_0_4:getFriendPraiseData(self._friendId)

	if var_7_0 then
		self.m_praiseBtn:getController("isPraise"):setSelectedIndex(var_7_0.time > 0 and 1 or 0)
		self.m_praiseBtn:setTouchable(var_7_0.time == 0)
	end
end

function FurnitureFriendLayer:_onClickLookBtn()
	self:_setLookMode(true)
end

function FurnitureFriendLayer:_onTouchMySelf()
	self:_setLookMode(false)
end

function FurnitureFriendLayer:_onClickRankBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FURNITURE_CHARM_RANK, {
		isFriend = true
	})
end

function FurnitureFriendLayer:_onClickPraiseBtn()
	if table.nums((var_0_4:getPraiseRecord())) >= g.core.config.parameter_info.get(var_0_2.FURNITURE_PARAMETER_MAX).parameter then
		g.core.module.ModuleManager:tip(g.core.lang:get(107082))

		return
	end

	g.core.network.GameNetProxy:send_C2S_FurnitureRoom_Praise({
		num = 1,
		friend_id = self._friendId
	})
end

function FurnitureFriendLayer:_setLookMode(arg_12_1)
	local var_12_0 = self:_isLookMode()

	if arg_12_1 then
		if not var_12_0 then
			self.m_topBarComp:playHideAction()
			self.m_hideUIController:setSelectedIndex(1)
		end
	elseif var_12_0 then
		self.m_topBarComp:playShowAction()
		self.m_hideUIController:setSelectedIndex(0)
	end
end

function FurnitureFriendLayer:_onSliderChanged()
	self.m_roomComp:setScale(var_0_0 + (1 - var_0_0) * math.floor(self.m_zoomSlider:getValue()) / 100)
end

function FurnitureFriendLayer:_onItemRenderFloorTab(arg_14_1, arg_14_2)
	arg_14_2:updateTabComp(self._dormFloorData[arg_14_1 + 1], true, self._cleanDormId)
end

function FurnitureFriendLayer:_onClickFloorTabList(arg_15_1)
	local var_15_0 = var_0_4:getDormIdByFloorIdx(arg_15_1:getDataValue() + 1)

	if var_15_0 > 0 and var_15_0 ~= self._curDormId then
		if var_0_4:isDormUnlocked(var_15_0, true) then
			self._curDormId = var_15_0

			self:_goToFloorDorm(self._curDormId)
		else
			var_0_7:tip((var_0_4:getDormUnlockConditionDesc(var_15_0)))
			self.m_floorTabList:setSelectedIndex(var_0_4:getFloorIdxByDormId(self._curDormId) - 1)
		end
	end
end

function FurnitureFriendLayer:_goToFloorDorm(arg_16_1)
	if var_0_4:isCanCleanFurnitureByUserId(self._friendId) and self._cleanDormId then
		self.m_roomComp:setDormIdCanSweep(self._cleanDormId)
	else
		self.m_roomComp:setDormIdCanSweep(nil)
	end

	self.m_floorTabList:setSelectedIndex(var_0_4:getFloorIdxByDormId(arg_16_1) - 1)
	self.m_roomComp:setFloorId(arg_16_1)
	self.m_comfortLvComp:updateComp(self._curDormId)
end

function FurnitureFriendLayer:receiveCompEvent(arg_17_1, arg_17_2)
	if arg_17_1 == "ROLE_RUN_UPDATE_Z_ORDER" then
		self.m_roomComp:rankFurnitureZOrder()
	elseif arg_17_1 == "CHANGE_ROOM_BG_RES" then
		if arg_17_2 then
			self.m_bgComp:updatebBgWithFurnitureStruct((var_0_1.get(arg_17_2)))
		else
			self.m_bgComp:clearnFurnitureRoomBg()
			self:addBg("bg/furniture/bg_jyxw_jiayuanxiaowu.jpg")
		end
	elseif arg_17_1 == "ROLE_BEHAVIOR_BEGIN" then
		self.m_roomComp:setSingleRoleNormalBehavior(arg_17_2)
	elseif arg_17_1 == "DRAG_ROLE_START" then
		self._dragStart = true
		self._dragRoleCompName = arg_17_2

		self.m_roomComp:onDragRoleStart(arg_17_2)
	elseif arg_17_1 == "CLICK_PLACE_SWEEP_BTN" then
		local var_17_0 = {
			num = 1,
			friend_id = self._friendId,
			charm_num = self._friendCharm
		}

		var_17_0.comfort_max = var_0_4:getRoomInfo(self._curDormId):getComfortLimit()

		g.core.network.GameNetProxy:send_C2S_FurnitureRoom_Sweep(var_17_0)
	end
end

function FurnitureFriendLayer:_onTouchBegin(arg_18_1)
	arg_18_1:captureTouch()
end

function FurnitureFriendLayer:_onTouchMove(arg_19_1)
	if not self._dragStart then
		local var_19_0 = arg_19_1:getInput()
		local var_19_1 = self.m_roomComp:getPosition()

		self.m_roomComp:setPosition(KsMath.rangeIn(var_19_1.x + var_19_0.x, 0, self._offXRange), (KsMath.rangeIn(var_19_1.y - var_19_0:getTouch():getDelta().y, 0, self._offYRange)))
	elseif #self._dragRoleCompName > 0 then
		self.m_roomComp:dragTouchMoveRole(self._dragRoleCompName)
	end
end

function FurnitureFriendLayer:_onTouchEnd(arg_20_1)
	if not arg_20_1:getInput():getTouch() then
		return
	end

	if self._dragStart then
		self.m_roomComp:dragMoveEndFurnitureComp()
	end

	self._dragRoleCompName = ""
	self._dragStart = false
	self._lastPos = nil
end

function FurnitureFriendLayer:_isLookMode()
	return self.m_hideUIController:getSelectedIndex() == 1
end

function FurnitureFriendLayer:_onS2CFurnitureRoomPraise(arg_22_1, arg_22_2)
	self:_updateFriendPraiseInfo()
	self.m_praiseBtn:getTransition("like"):play()

	local var_22_0 = var_0_4:getFriendPraiseData(self._friendId)

	if var_22_0 then
		self.m_effCharmNunTxt:setText(g.core.lang:get(112551, {
			value = var_22_0.value - self._friendCharm
		}))
		self.m_charmNumTxt:setText(var_22_0.value)

		self._friendCharm = var_22_0.value

		self.m_upTransition:play()
	end
end

function FurnitureFriendLayer:_onS2CFurnitureRoomSweep(arg_23_1, arg_23_2)
	if arg_23_2.awards then
		var_0_7:awardSummary(arg_23_2.awards, true)
	end

	local var_23_0 = var_0_4:getFriendCharmValue()

	self.m_effCharmNunTxt:setText(g.core.lang:get(112551, {
		value = var_23_0 - self._friendCharm
	}))
	self.m_charmNumTxt:setText(var_0_4:getFriendCharmValue())
	self.m_upTransition:play()

	self._friendCharm = var_23_0

	self.m_timeTxt:setText(g.core.lang:get(107056, {
		num = var_0_4:getCurSweepTime(),
		maxNum = var_0_4:getSweepDailyMaxTime()
	}))

	self._cleanDormId = nil

	self.m_roomComp:setDormIdCanSweep(self._cleanDormId)
	self.m_roomComp:hideSweepEffect()
	self.m_floorTabList:setNumItems(#self._dormFloorData)
end

function FurnitureFriendLayer:_onRoomCrossDay()
	if var_0_4:isExpired() then
		self:_sendFurnitureRoomInfo()
	end
end

function FurnitureFriendLayer:_sendFurnitureRoomInfo()
	g.core.network.GameNetProxy:send_C2S_FurnitureRoom_GetInfo({})
end

function FurnitureFriendLayer:_onRoomGetInfo()
	self:_updateFriendRoomInfo()
end

return FurnitureFriendLayer
