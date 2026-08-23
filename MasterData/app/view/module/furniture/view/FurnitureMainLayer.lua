local var_0_0 = g.core.config.furniture_info
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.const.ConstMgr.FurnitureConst
local var_0_3 = 0.3
local var_0_4 = g.core.event.enum
local var_0_5 = {
	LOOK = 0,
	EDIT = 1
}
local var_0_6 = g.core.model.User.furnitureData
local KsMath = require("app.core.utils.KsMath")
local var_0_8 = g.core.common.Scheduler
local var_0_9 = g.core.event.EventManager
local var_0_10 = g.core.module.ModuleManager
local FurnitureMainLayer = class("FurnitureMainLayer", require("app.fairyGUI.furniture.UI_FurnitureMainLayer"), function()
	return fgui.GComponent:create({
		resName = "FurnitureMainLayer",
		pkgPath = "ui/furniture/furniture",
		isFullScreen = true,
		pkgName = "furniture"
	}, ...)
end)

function FurnitureMainLayer:ctor(arg_2_1)
	self._routeDormId = arg_2_1 and arg_2_1.dormId
	self._openDress = arg_2_1 and arg_2_1.openDress
	self._scheduler_60s = nil
	self._curDormId = 1
	self._offXRange = (self.m_roomComp:getWidth() - display.width) / 2
	self._offYRange = (self.m_roomComp:getHeight() - display.height) / 2
	self._tabType = 1
	self._dragStart = false
	self._isSaveSetting = false
	self._waitState = true
	self._dragRoleCompName = ""
	self._dragFItemCompName = ""

	local var_2_0 = cc.Director:getInstance():getSafeAreaRect()
	local var_2_1 = self.m_subTypeComp:getWidth() * (display.width / CC_DESIGN_RESOLUTION.width)

	if var_2_0.x > 0 then
		var_2_1 = var_2_1 - var_2_0.x * 2
	end

	self.m_subTypeComp:setWidth(var_2_1)
	self:_initListener()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	self:_onRoomEnterChanged()
end

function FurnitureMainLayer:_onMainLayerEnterFinish()
	if self._waitState then
		self._waitState = false

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end
end

function FurnitureMainLayer:_initListener()
	self:addClickListener(handler(self, self._onTouchMySelf))
	self.m_lookBtn:addClickListener(handler(self, self._onClickLookBtn))
	self.m_topBarComp:setReturnCallBack(handler(self, self._onClickOut))
	self.m_topBarComp:setHomeCallBack(handler(self, self.onClickHomeOut))
	self.m_editRoomBtn:addClickListener(handler(self, self._onClickEditRoomBtn))
	self.m_furnitureShopBtn:addClickListener(handler(self, self._onClickShopBtn))
	self.m_checkInRoomBtn:addClickListener(handler(self, self._onClickCheckInBtn))
	self.m_gotoHLTrainBtn:addClickListener(handler(self, self._onClickGotoHLTrainBtn))
	self.m_comfortBuffBtn:addClickListener(handler(self, self._onClickComfortBuffBtn))
	self.m_charmBtn:addClickListener(handler(self, self._onClickCharmBtn))
	self.m_zoomSlider:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSliderChanged))
	self.m_editRoomController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onEditContrlChanged))
	self.m_floorTabList:setVirtual()
	self.m_floorTabList:setItemRenderer(handler(self, self._onItemRenderFloorTab))
	self.m_floorTabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickFloorTabList))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_shareComp:setCallback(handler(self, self._onShareClick))
end

function FurnitureMainLayer:_onTouchBegin(arg_5_1)
	local var_5_0 = arg_5_1:getInput():getTouch()
	local var_5_1 = var_5_0:getLocation()

	if var_5_0 and not self:isTouchCharmBubble(var_5_1) then
		arg_5_1:captureTouch()

		self._lastPos = var_5_1

		if not self.m_charmBtn:containPoint(var_5_1) then
			self.m_isShowCharmBubbleController:setSelectedIndex(0)
		end
	end
end

function FurnitureMainLayer:isTouchCharmBubble(arg_6_1)
	if self.m_isShowCharmBubbleController:getSelectedIndex() == 1 and self.m_charmShowComp:containPoint(arg_6_1) then
		return true
	end

	return false
end

function FurnitureMainLayer:_onTouchMove(arg_7_1)
	if not self._dragStart then
		local var_7_0 = arg_7_1:getInput()
		local var_7_1 = self.m_roomComp:getPosition()

		self.m_roomComp:setPosition(KsMath.rangeIn(var_7_1.x + var_7_0.x, 0, self._offXRange), (KsMath.rangeIn(var_7_1.y - var_7_0:getTouch():getDelta().y, 0, self._offYRange)))
	elseif #self._dragRoleCompName > 0 then
		self.m_roomComp:dragTouchMoveRole(self._dragRoleCompName)
	elseif #self._dragFItemCompName > 0 and self._lastPos then
		local var_7_2 = arg_7_1:getInput()

		self._lastPos = var_7_2:getTouch():getLocation()

		self.m_roomComp:dragMoveFurnitureComp((cc.pMul(cc.pSub(var_7_2, self._lastPos), 1 / (var_0_3 + (1 - var_0_3) * math.floor(self.m_zoomSlider:getValue()) / 100))))
	end
end

function FurnitureMainLayer:_onTouchEnd(arg_8_1)
	if not arg_8_1:getInput():getTouch() then
		return
	end

	if self._dragStart then
		self.m_roomComp:dragMoveEndFurnitureComp()
	end

	self._dragRoleCompName = ""
	self._dragStart = false
	self._lastPos = nil
end

function FurnitureMainLayer:onLoad()
	var_0_9:addEventListener(var_0_4.EVENT_NET_S2C_FURNITURE_ROOM_GETINFO, self._onS2CFurnitureRoomGetInfo, self)
	var_0_9:addEventListener(var_0_4.EVENT_NET_S2C_FURNITURE_ROOM_PLACE, self._onS2CFurnitureRoomPlace, self)
	var_0_9:addEventListener(var_0_4.EVENT_NET_S2C_FURNITURE_ROOM_PLACEKNIGHT, self._onS2CPlaceKnight, self)
	var_0_9:addEventListener(var_0_4.EVENT_NET_S2C_FURNITURE_ROOM_UPGRADE, self._onS2CFurnitureRoomUpgrade, self)
	var_0_9:addEventListener(var_0_4.EVENT_NET_S2C_FURNITURE_ROOM_BATH, self._onS2cFurnitureRoomBath, self)
	var_0_9:addEventListener(var_0_4.EVENT_NET_S2C_HOME_LAND_TRAIN_GETINFO, self._onS2CHLTrainGetInfo, self)
	var_0_9:addEventListener(var_0_4.EVENT_NET_S2C_FURNITURE_ROOM_FRIENDGETINFO, handler(self, self._onRecGetFriendFurnitureInfo), self)
	self.m_roomComp:updateFurnitureComp()
	self:_initFloorsTabComp()
	self.m_typeTab:onUpdateTypeTabRedPoint()

	self._isSaveSetting = false

	if self._routeDormId then
		self._curDormId = self._routeDormId

		self:_goToFloorDorm(self._curDormId)
		self.m_editRoomController:setSelectedIndex((self._openDress or nil) and (var_0_5.EDIT or var_0_5.LOOK))
	else
		self.m_comfortLvComp:updateComp(self._curDormId)
		self.m_actionRecoveryComp:updateComp(self._curDormId)
	end

	self._scheduler_60s = self._scheduler_60s or var_0_8:newSchedule(handler(self, self._onSchedulerUpdate_60s), 60)

	self.m_charmNumTxt:setText(var_0_6:getSumCharmValue())
	var_0_9:dispatchEvent(var_0_4.EVENT_WEAK_GUIDE_READY)
	var_0_9:dispatchEvent(var_0_4.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_checkInRoomBtn
	})
	var_0_9:dispatchEvent(var_0_4.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_editRoomBtn,
		customData = {
			all = true
		}
	})
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_SCENE_ROOM)
	g.core.model.User.functionUnlockData:saveUnlockedFunc(var_0_1.FUNCTION_TYPE.HOME_LAND_FURNITURE)
end

function FurnitureMainLayer:_onRecGetFriendFurnitureInfo(arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = g.core.module.ModuleManager:getCurModule()

	if var_10_0 and var_10_0.module ~= g.view.entrance.FRIEND_FURNITURE and arg_10_3 and arg_10_3.friend_id then
		g.core.module.ModuleManager:pushModule(g.view.entrance.FRIEND_FURNITURE, {
			friendId = arg_10_3.friend_id
		})
	end
end

function FurnitureMainLayer:onUnload()
	if self._scheduler_60s then
		var_0_8:cancelSchedule(self._scheduler_60s)

		self._scheduler_60s = nil
	end

	if self._waitState then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end

	self._dragRoleCompName = ""
	self._dragFItemCompName = ""
end

function FurnitureMainLayer:_initFloorsTabComp()
	self._dormFloorData = var_0_6:getDormFloorData()

	self.m_floorTabList:setNumItems(#self._dormFloorData)
	self.m_floorTabList:setHeight(#self._dormFloorData * 50)
	self.m_floorTabList:setSelectedIndex(var_0_6:getFloorIdxByDormId(self._curDormId) - 1)
end

function FurnitureMainLayer:_goToFloorDorm(arg_13_1)
	self.m_floorTabList:setSelectedIndex(var_0_6:getFloorIdxByDormId(arg_13_1) - 1)
	self.m_roomComp:setFloorId(arg_13_1)
	self.m_comfortLvComp:updateComp(self._curDormId)
	self.m_actionRecoveryComp:updateComp(self._curDormId)
	self.m_comfortLvComp:checkAndShowPromptUpgrade(self._curDormId)
end

function FurnitureMainLayer:receiveCompEvent(arg_14_1, arg_14_2)
	if arg_14_1 == "CLICK_PLACE_FURNITURE_BTN" then
		self.m_roomComp:onClickPlaceFurnitureBtn()
		self:_setBottomFurnitureVisible(true)
	elseif arg_14_1 == "CHANGE_ROOM_BG_RES" then
		if arg_14_2 then
			self.m_bgComp:updatebBgWithFurnitureStruct((var_0_0.get(arg_14_2)))
		else
			self.m_bgComp:clearnFurnitureRoomBg()
			self:addBg("bg/furniture/bg_jyxw_jiayuanxiaowu.jpg")
		end
	elseif arg_14_1 == "CLICK_DELETE_FURNITURE_BTN" then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
		self.m_roomComp:onClickDeleteFurnitureBtn()
		self:_updateSubTypeComp()
		self:_setBottomFurnitureVisible(true)
	elseif arg_14_1 == "CLICK_ROTATE_FURNITURE_BTN" then
		self.m_roomComp:onClickRotateFurnitureBtn()
	elseif arg_14_1 == "CLICK_DELETE_ALL_BTN" then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
		self.m_roomComp:collectAllFurniture()
		self:_updateSubTypeComp()
	elseif arg_14_1 == "CLICK_SAVE_ALL_BTN" then
		self.m_roomComp:sendSaveSettingRoom2S()
	elseif arg_14_1 == "CLICK_RESET_ALL_BTN" then
		self.m_roomComp:updateFurnitureComp()
		self:_updateSubTypeComp()
	elseif arg_14_1 == "CLICK_FURNITURE_ITEM_COMP" then
		self.m_roomComp:onClickFurnitureItemComp(arg_14_2)
	elseif arg_14_1 == "FURNITURE_TYPE_CELL_ON_SELECT" then
		self._tabType = arg_14_2

		self:_updateSubTypeComp()
		var_0_9:dispatchEvent(var_0_4.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_editRoomBtn,
			customData = {
				all = true
			}
		})
	elseif arg_14_1 == "CREATE_FURNITURE_OBJECT" then
		self.m_roomComp:addFurniture(arg_14_2)
		self:_updateSubTypeComp()

		if g.core.guide.GuideProxy:isGuideRunning() then
			self:_setBottomFurnitureVisible(true)
		else
			self:_setBottomFurnitureVisible(var_0_6:getFurnitureBasalTypeById(arg_14_2) == var_0_2.FLOOR_LAYER)
		end
	elseif arg_14_1 == "DRAG_ROLE_START" then
		self._dragStart = true
		self._dragRoleCompName = arg_14_2

		self.m_roomComp:onDragRoleStart(arg_14_2)
	elseif arg_14_1 == "DRAG_FURNITURE_ITEM_START" then
		self._dragStart = true
		self._dragFItemCompName = arg_14_2
	elseif arg_14_1 == "BATHING_OVER" then
		self.m_roomComp:outOfBathing(arg_14_2)
	elseif arg_14_1 == "SAVE_BUT_NO_CHANGE" then
		self.m_editRoomController:setSelectedIndex(var_0_5.LOOK)
	elseif arg_14_1 == "ROLE_BEHAVIOR_BEGIN" then
		self.m_roomComp:setSingleRoleNormalBehavior(arg_14_2)
	elseif arg_14_1 == "ROLE_RUN_UPDATE_Z_ORDER" then
		self.m_roomComp:rankFurnitureZOrder()
	elseif arg_14_1 == "EVENT_GOTO_DRESS_MODE" then
		self._curDormId = arg_14_2.dormId

		self:_goToFloorDorm(self._curDormId)
		self.m_editRoomController:setSelectedIndex((arg_14_2.openDress or nil) and (var_0_5.EDIT or var_0_5.LOOK))
	elseif arg_14_1 == "EVENT_CLOSE_LEVEL_UP_POP" then
		self.m_comfortLvComp:checkAndShowPromptUpgrade(self._curDormId)
	elseif arg_14_1 == "BATH_CROCK_CD_OVER" then
		self.m_roomComp:onBathCrockCDOver()
	end
end

function FurnitureMainLayer:_updateSubTypeComp()
	self.m_subTypeComp:updateView(self._curDormId, self._tabType, (self.m_roomComp:getCurRoomAllPlaceFurniture()))
end

function FurnitureMainLayer:_setBottomFurnitureVisible(arg_16_1)
	self.m_leftGroup:setVisible(arg_16_1)
	self.m_zoomSlider:setVisible(arg_16_1)
	self.m_subTypeComp:setVisible(arg_16_1)
	self.m_typeTab:setVisible(arg_16_1)
end

function FurnitureMainLayer:_onClickShopBtn()
	if var_0_5.EDIT == self.m_editRoomController:getSelectedIndex() then
		if not self._isSaveSetting then
			if #self.m_roomComp:getAddFurnitureData() == 0 and #self.m_roomComp:getDeleteFurnitureData() == 0 then
				local var_17_0 = {
					tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.FLUSH_TAB_TYPE
				}

				var_17_0.shopType = g.core.const.ConstMgr.ShopConst.SHOP_FLUSH_TYPE.FURNITURE

				var_0_10:pushModule(g.view.entrance.SHOP, var_17_0)

				goto label_17_0
			end
		end

		self:_showConfirmPop()

		::label_17_0::

		self:_updateSubTypeComp()
		self.m_roomComp:saveFurniturePos()
	else
		local var_17_1 = {
			tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.FLUSH_TAB_TYPE
		}

		var_17_1.shopType = g.core.const.ConstMgr.ShopConst.SHOP_FLUSH_TYPE.FURNITURE

		var_0_10:pushModule(g.view.entrance.SHOP, var_17_1)
	end
end

function FurnitureMainLayer:_onClickCheckInBtn()
	var_0_10:pushPopup(require("app.view.module.furniture.view.pop.FurnitureCheckInPop").new())
	var_0_6:saveCheckInBtnClicked()
	var_0_9:dispatchEvent(var_0_4.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_checkInRoomBtn
	})
end

function FurnitureMainLayer:_onClickGotoHLTrainBtn()
	g.core.network.GameNetProxy:send_C2S_HomeLandTrain_GetInfo({})
end

function FurnitureMainLayer:_onClickComfortBuffBtn()
	var_0_10:pushPopup(require("app.view.module.furniture.view.pop.FurnitureComfortBuffPop").new(self._curDormId), {
		touchDisappear = false,
		ignoreTouch = true
	})
end

function FurnitureMainLayer:_onClickCharmBtn()
	if self.m_isShowCharmBubbleController:getSelectedIndex() == 1 then
		self.m_isShowCharmBubbleController:setSelectedIndex(0)
	else
		self.m_isShowCharmBubbleController:setSelectedIndex(1)
		self.m_charmShowComp:playTransition()
	end
end

function FurnitureMainLayer:_onShareClick()
	self:_setLookMode(true)
	self.m_roomComp:setShareStatus(true)
	self.m_topBarComp:setVisible(false)

	local var_22_0 = cc.utils:captureNode(self)

	var_22_0:saveToFile(g.core.model.User.ShareData:getShotPath())
	var_22_0:release()
	self:_setLookMode(false)
	self.m_roomComp:setShareStatus(false)
	self.m_topBarComp:setVisible((self.m_topBarComp:isVisible()))
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHARE_LAYER, {
		shareType = g.core.const.ConstMgr.ShareConst.SHARE_TYPE.TYPE_ID_2
	})
end

function FurnitureMainLayer:_onClickEditRoomBtn()
	self._isSaveSetting = false

	self.m_editRoomController:setSelectedIndex(var_0_5.EDIT)
end

function FurnitureMainLayer:onClickBackBtn()
	self:_onClickOut()
end

function FurnitureMainLayer:_onClickOut()
	if var_0_5.EDIT == self.m_editRoomController:getSelectedIndex() then
		if self._isSaveSetting then
			self.m_editRoomController:setSelectedIndex(var_0_5.LOOK)
		elseif #self.m_roomComp:getAddFurnitureData() == 0 and #self.m_roomComp:getDeleteFurnitureData() == 0 then
			self.m_editRoomController:setSelectedIndex(var_0_5.LOOK)
		else
			self:_showConfirmPop()
		end

		self:_updateSubTypeComp()
		self.m_roomComp:saveFurniturePos()
	else
		self.m_topBarComp:checkFullPageExitAnim()
	end
end

function FurnitureMainLayer:onClickHomeOut()
	if var_0_5.EDIT == self.m_editRoomController:getSelectedIndex() then
		if self._isSaveSetting then
			self.m_editRoomController:setSelectedIndex(var_0_5.LOOK)
		elseif #self.m_roomComp:getAddFurnitureData() == 0 and #self.m_roomComp:getDeleteFurnitureData() == 0 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_EXIT_PLAY_TRANSITION)
			g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
		else
			self:_showConfirmPop()
		end
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_EXIT_PLAY_TRANSITION)
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function FurnitureMainLayer:_showConfirmPop()
	var_0_10:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(112503),
		desc = g.core.lang:get(112504),
		onConfirm = handler(self, function()
			self.m_editRoomController:setSelectedIndex(var_0_5.LOOK)
			self:_updateSubTypeComp()
			self:_setBottomFurnitureVisible(true)
		end)
	}))
end

function FurnitureMainLayer:_onEditContrlChanged()
	if self.m_editRoomController:getSelectedIndex() == var_0_5.LOOK then
		self.m_typeTab:getTransition("back"):play()
		self.m_roomComp:setEditMode(false)
		self.m_roomComp:updateFurnitureComp()
		self.m_comfortBuffBubbleComp:checkShow(self._curDormId)
	else
		self.m_typeTab:getTransition("enter"):play()
		self.m_typeTab:getChild("typeList"):transitionShowCells("listCardAUiRightIn01", 0.06)
		self.m_subTypeComp:getTransition("enter"):play()
		self.m_roomComp:setEditMode(true)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
		end, 1)
	end

	self:_updateSubTypeComp()
end

function FurnitureMainLayer:_onSliderChanged()
	self.m_roomComp:setScale(var_0_3 + (1 - var_0_3) * math.floor(self.m_zoomSlider:getValue()) / 100)
end

function FurnitureMainLayer:_onRoomEnterChanged()
	if g.core.guide.GuideProxy:isGuideRunning() then
		self.m_zoomSlider:setValue(0)
		self.m_roomComp:setScale(var_0_3)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	else
		self.m_enterTransition:play(handler(self, self._onMainLayerEnterFinish))
	end
end

function FurnitureMainLayer:_onClickFloorTabList(arg_33_1)
	local var_33_0 = var_0_6:getDormIdByFloorIdx(arg_33_1:getDataValue() + 1)

	if var_33_0 > 0 and var_33_0 ~= self._curDormId then
		if var_0_6:isDormUnlocked(var_33_0) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)

			self._curDormId = var_33_0

			self:_goToFloorDorm(self._curDormId)
		else
			var_0_10:tip((var_0_6:getDormUnlockConditionDesc(var_33_0)))
			self.m_floorTabList:setSelectedIndex(var_0_6:getFloorIdxByDormId(self._curDormId) - 1)
		end
	end
end

function FurnitureMainLayer:_onItemRenderFloorTab(arg_34_1, arg_34_2)
	arg_34_2:updateTabComp(self._dormFloorData[arg_34_1 + 1])
end

function FurnitureMainLayer:_onClickLookBtn()
	self:_setLookMode(true)
end

function FurnitureMainLayer:_onTouchMySelf()
	self:_setLookMode(false)
end

function FurnitureMainLayer:_onS2CFurnitureRoomGetInfo()
	self.m_roomComp:updateRolesMobility()
	self.m_charmNumTxt:setText(var_0_6:getSumCharmValue())
end

function FurnitureMainLayer:_onS2CFurnitureRoomPlace(arg_38_1, arg_38_2, arg_38_3)
	self._isSaveSetting = true

	self:_updateSubTypeComp()
	self.m_comfortLvComp:updateComp(self._curDormId)
	self.m_actionRecoveryComp:updateComp(self._curDormId)
	self.m_roomComp:updateFurnitureComp(true)
	var_0_10:tip(g.core.lang:get(112527))
end

function FurnitureMainLayer:_onS2CPlaceKnight()
	self._dragRoleCompName = ""

	self.m_roomComp:updateRoomRoleComps()
end

function FurnitureMainLayer:_onS2CFurnitureRoomUpgrade()
	self.m_floorTabList:setNumItems(#self._dormFloorData)
	self.m_comfortLvComp:updateComp(self._curDormId)
	self.m_actionRecoveryComp:updateComp(self._curDormId)
end

function FurnitureMainLayer:_onS2cFurnitureRoomBath(arg_41_1, arg_41_2)
	self.m_roomComp:startBathing(arg_41_2)
end

function FurnitureMainLayer:_onS2CHLTrainGetInfo()
	var_0_10:replaceModule(g.view.entrance.HOME_LAND_TRAIN)
end

function FurnitureMainLayer:_onSchedulerUpdate_60s()
	if var_0_6:isExpired() then
		g.core.network.GameNetProxy:send_C2S_FurnitureRoom_GetInfo({})
	end
end

function FurnitureMainLayer:_setLookMode(arg_44_1)
	local var_44_0 = self:_isLookMode()

	if arg_44_1 then
		if not var_44_0 then
			self.m_roomComp:setLookMode(arg_44_1)
			self.m_topBarComp:playHideAction()
			self.m_hideUIController:setSelectedIndex(1)
		end
	elseif var_44_0 then
		self.m_roomComp:setLookMode(arg_44_1)
		self.m_topBarComp:playShowAction()
		self.m_hideUIController:setSelectedIndex(0)
	end
end

function FurnitureMainLayer:_isLookMode()
	return self.m_hideUIController:getSelectedIndex() == 1
end

return FurnitureMainLayer
