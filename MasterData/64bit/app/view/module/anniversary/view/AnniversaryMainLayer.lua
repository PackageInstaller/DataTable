local var_0_0 = g.core.const.ConstMgr.AnniversaryConst
local var_0_1 = g.core.model.User.anniversaryData
local PressComp = require("app.view.module.recruit.view.comp.PressComp")
local AnniversaryMainLayer = class("AnniversaryMainLayer", require("app.fairyGUI.anniversary.UI_AnniversaryMainLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/anniversary/anniversary",
		resName = "AnniversaryMainLayer",
		pkgName = "anniversary",
		isFullScreen = true
	}, ...)
end)

function AnniversaryMainLayer:ctor(arg_2_1)
	self._ownNum = 0
	self._clickNum = 0
	self._resCompList = {}
	self._fireAwardList = {}
	self._firePlayIndexUp = 1
	self._firePlayIndexDown = 1
	self._fireUpEffList = {}
	self._fireDownEffList = {}

	self:_initView()
	self:_initBtn()
	self:_initTouch()
end

function AnniversaryMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_GETINFO, handler(self, self._onRecvInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ITEM_USE, handler(self, self._onRecvItemUse), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OP_OBJECT, handler(self, self._updateItemNum), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDay, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_ANNIVERSARY_TOPBAR_RESCOMP_REFRESH, self._onRefreshTopBarResComp, self)
	g.core.network.GameNetProxy:send_C2S_Anniversary_GetInfo({})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_taskRedPoint
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_itemRedPoint
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_floorBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_jigsawBtn
	})
	self.m_enterTransition:play()
end

function AnniversaryMainLayer:onUnload()
	if self._timeSchedule then
		self:cancelSchedule(self._timeSchedule)

		self._timeSchedule = nil
	end
end

function AnniversaryMainLayer:_initBtn()
	self.m_giftBtn:addClickListener(handler(self, self._onGiftBtnClick))
	self.m_taskBtn:addClickListener(handler(self, self._onTaskBtnClick))
	self.m_shopBtn:addClickListener(handler(self, self._onShopBtnClick))
	self.m_floorBtn:addClickListener(handler(self, self._onFloorBtnClick))
	self.m_jigsawBtn:addClickListener(handler(self, self._onJigsawBtnClick))
end

function AnniversaryMainLayer:_initTouch()
	PressComp.bindComp(self.m_itemBtn)
	self.m_itemBtn:setIgnoreMove(false)
	self.m_itemBtn:setPressTime(0.2)
	self.m_itemBtn:setPressInterval(var_0_0.PRESS_INTERVAL)
	self.m_itemBtn:setClickListener(handler(self, self._onItemBtnClick))
	self.m_itemBtn:setTouchDisableListener(handler(self, self._onItemNumShortCheck))
	self.m_itemBtn:addPressListener(handler(self, self._onItemBtnPress))

	self.m_itemBtn._additionalTouchEnd = handler(self, self._additionalTouchEnd)
	self.m_itemBtn._additionalTouchBegin = handler(self, self._additionalTouchBegin)
end

function AnniversaryMainLayer:_initView(arg_7_1)
	self:addBg(var_0_1:getActivityResource("bg", "bg_xmhy_0.jpg"))
	self.m_bgLoader:setURL(var_0_1:getActivityResource("bg", "bg_xmhy_1.png"))
	self.m_titleLoader:setURL(var_0_1:getActivityResource("pic", "txt_xmhy_xingmenghuanye.png"))
	self.m_timeLoader:setURL(var_0_1:getActivityResource("ui_cocos", "pic_xmhy_daojishidi.png"))
	self.m_giftBtn:setIcon(var_0_1:getActivityResource("ui_cocos", "btn_xmhy_rukou4.png"))
	self.m_shopBtn:setIcon(var_0_1:getActivityResource("ui_cocos", "btn_xmhy_rukou2.png"))
	self.m_floorBtn:setIcon(var_0_1:getActivityResource("ui_cocos", "btn_xmhy_rukou1.png"))
	self.m_jigsawBtn:setIcon(var_0_1:getActivityResource("ui_cocos", "btn_xmhy_rukou3.png"))
	self.m_taskBtn:setIcon(var_0_1:getActivityResource("ui_cocos", "btn_xmhy_jmqd.png"))
	self.m_itemBtn:setIcon(var_0_1:getActivityResource("ui_cocos", "btn_xmhy_yanhuadi.png"))
	self.m_timeText:setColor(var_0_0.hexToRgb(var_0_1:getAnniversaryInfo().main_color))
	self.m_taskTxt:setColor(var_0_0.hexToRgb(var_0_1:getAnniversaryInfo().main_color))
	self.m_itemNameText:setColor(var_0_0.hexToRgb(var_0_1:getAnniversaryInfo().main_color))

	local var_7_0 = "eff_ui_anniversary_bglight"
	local var_7_1 = "eff_ui_anniversary_btnlight"

	if var_0_1:getActivityId() > 1 then
		var_7_0 = "eff_ui_anniversary_bglight" .. var_0_1:getAnniversaryInfo().file_type
		var_7_1 = "eff_ui_anniversary_btnlight" .. var_0_1:getAnniversaryInfo().file_type
	end

	self.m_bgEffLoader:addEffectSpine({
		anim = "play",
		isLoop = true,
		name = var_7_0
	})

	self._itemEff = self.m_itemEffLoader:addEffectSpine({
		anim = "play",
		isLoop = true,
		name = var_7_1
	})

	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.ANNIVERSARY)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_StarNight_Firework)
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_StarDreamNight)
end

function AnniversaryMainLayer:_updateView()
	local var_8_0 = var_0_1:getCurStage()

	if var_8_0 == var_0_0.STAGE.NOT_OPEN then
		g.core.module.ModuleManager:tip(g.core.lang:get(308618))
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end

	local var_8_1 = var_8_0 == var_0_0.STAGE.SHOW

	self.m_jigsawBtn:getController("state"):setSelectedIndex(var_8_0 == var_0_0.STAGE.SHOW and 1 or 0)
	self.m_giftBtn:getController("state"):setSelectedIndex(var_8_1 and 1 or 0)

	if not self._initUI then
		self._initUI = true

		self:_updateUIOnce()
	end

	self._timeSchedule = self._timeSchedule or self:newSchedule(handler(self, self._updateTimer), 1)

	self:_updateTimer()
	self:_updateItemNum()
end

function AnniversaryMainLayer:_updateUIOnce()
	local var_9_0 = var_0_1:getAnniversaryInfo()

	self.m_topBarComp:setResInfoById(var_9_0.interface_main)
	self.m_topBarComp:setTitle(var_9_0.name)
	self.m_giftBtn:setTitle(var_9_0.pack_name)
	self.m_shopBtn:setTitle(var_9_0.shop_name)
	self.m_floorBtn:setTitle(var_9_0.floor_name)
	self.m_jigsawBtn:setTitle(var_9_0.jigsaw_name)

	local var_9_1 = g.core.config.item_info.get(var_9_0.item_value)

	self.m_itemNameText:setText(var_9_1.name)

	self._fireAwardList = g.core.common.Drops:getGoodsArray(var_9_1.item_value)
	self._resCompList = self.m_topBarComp:getMatchResCompList(self._fireAwardList)
end

function AnniversaryMainLayer:_updateTimer()
	local var_10_0 = var_0_1:getCurStageFinishTime() - g.core.common.ServerTime:getTime()

	if var_10_0 > 0 then
		self.m_timeText:setText(g.core.lang:get(var_0_1:getCurStage() == var_0_0.STAGE.GAME and 431605 or 431606, {
			time = g.core.common.ServerTime:secondToDHMString(var_10_0)
		}))
	else
		self.m_timeText:setText(g.core.lang:get(308618))
	end
end

function AnniversaryMainLayer:_updateItemNum()
	local var_11_0 = var_0_1:getAnniversaryInfo()

	self._ownNum = g.core.model.User.bagData:getOwnNum(var_11_0.item_type, var_11_0.item_value)

	self.m_itemNumText:setText("X" .. self._ownNum)
	self._itemEff:setVisible(self._ownNum > 0)
end

function AnniversaryMainLayer:_updateFireAward()
	for iter_12_0 = 1, 2 do
		if self._fireAwardList[iter_12_0] then
			self["m_awardComp" .. iter_12_0]:updateItem(self._fireAwardList[iter_12_0], iter_12_0)
		end
	end

	for iter_12_1 = 1, #self._resCompList do
		self._resCompList[iter_12_1]:setStopRcvResourceFlush(true)
	end
end

function AnniversaryMainLayer:_onRefreshTopBarResComp()
	for iter_13_0 = 1, #self._resCompList do
		self._resCompList[iter_13_0]:setStopRcvResourceFlush(false)
	end
end

function AnniversaryMainLayer:_onRecvInfo(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	self:_updateView()
end

function AnniversaryMainLayer:_onRecvItemUse(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	self:_updateItemNum()
end

function AnniversaryMainLayer:_onCrossDay(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	self:_updateView()
end

function AnniversaryMainLayer:checkActivityOpen()
	return var_0_1:isActivityOpen()
end

function AnniversaryMainLayer:_onGiftBtnClick()
	if not var_0_1:isInActivityGameTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(308618))

		return
	end

	local var_18_0 = {
		activityValue = var_0_1:getActivityId(),
		shopValue = g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.ANNIVERSARY_GIFT,
		openCheckFunc = handler(self, self.checkActivityOpen)
	}

	g.core.model.User.giftData:refreshInTime()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.anniversary.view.AnniversaryGiftPop").new(var_18_0)))
end

function AnniversaryMainLayer:_onTaskBtnClick()
	if not var_0_1:isInActivityGameTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(308618))

		return
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.anniversary.view.AnniversaryTaskPop").new(), {
		touchDisappear = true,
		hideContinue = true
	})
end

function AnniversaryMainLayer:_onShopBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANNIVERSARY_SHOP_LAYER)
end

function AnniversaryMainLayer:_onFloorBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANNIVERSARY_FLOOR_LAYER)
end

function AnniversaryMainLayer:_onJigsawBtnClick()
	if not var_0_1:isInActivityGameTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(308618))

		return
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.ANNIVERSARY_JIGSAW_LAYER)
end

function AnniversaryMainLayer:_onItemNumShortCheck(arg_23_1)
	if self._ownNum - (arg_23_1 and 0 or self._clickNum) <= 0 then
		local var_23_0 = var_0_1:getAnniversaryInfo()

		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			size = 0,
			type = var_23_0.item_type,
			value = var_23_0.item_value
		})

		return true
	end

	return false
end

function AnniversaryMainLayer:_onItemBtnClick()
	if self:_onItemNumShortCheck(true) then
		return
	end

	local var_24_0 = 1
	local var_24_1

	if self._clickNum > 0 then
		var_24_0 = math.min(self._clickNum, self._ownNum)
		self._clickNum = 0
	else
		self:playFireworkEffect(true)
		self:_updateFireAward()
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_StarNight_Firework_02)

		var_24_1 = {}
	end

	var_24_1.id = var_0_1:getAnniversaryInfo().item_value
	var_24_1.num = var_24_0

	g.core.network.GameNetProxy:send_C2S_Item_Use(var_24_1)
end

function AnniversaryMainLayer:_additionalTouchBegin(arg_25_1, arg_25_2)
	return
end

function AnniversaryMainLayer:_onItemBtnPress()
	if not self._effSchedule then
		self._effSchedule = self:newSchedule(handler(self, self.playFireworkEffect), 0.07)

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_StarNight_Firework_03)
	end

	self._clickNum = self._clickNum + 1

	self.m_itemNumText:setText("X" .. math.max(0, self._ownNum - self._clickNum))
	self:_updateFireAward()
end

function AnniversaryMainLayer:_additionalTouchEnd(arg_27_1, arg_27_2)
	if self._effSchedule then
		self:cancelSchedule(self._effSchedule)

		self._effSchedule = nil
	end

	if self._clickNum > 0 then
		self:_onItemBtnClick()
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_StarNight_Firework_03_Stop)
	end
end

function AnniversaryMainLayer:_getRandomNums(arg_28_1)
	if type(arg_28_1) ~= "boolean" then
		arg_28_1 = math.random(0, 1) > 0.5
	end

	local var_28_0 = math.random(1, var_0_0.FIRE_SPINE_ANIM_NUM)
	local var_28_1 = arg_28_1 and math.random(0, var_0_0.FIRE_UP_OFFX) or math.random(0, var_0_0.FIRE_DOWN_OFFX)

	return arg_28_1, var_28_0, (math.random(0, 1) > 0.5 or nil) and (-var_28_1 or var_28_1)
end

function AnniversaryMainLayer:playFireworkEffect(arg_29_1)
	local var_29_0, var_29_1, var_29_2 = self:_getRandomNums(arg_29_1)

	if var_29_0 then
		if #self._fireUpEffList < var_0_0.FIRE_NUM then
			self._fireUpEffList[#self._fireUpEffList + 1] = self.m_fireUpEffLoader:addEffectSpine({
				name = "eff_ui_anniversary_fireworkup",
				isLoop = false,
				anim = "play_" .. var_29_1
			})

			self._fireUpEffList[#self._fireUpEffList + 1]:setPosition(var_29_2, 0)
		else
			self._fireUpEffList[self._firePlayIndexUp]:setAnimation(0, "play_" .. var_29_1, false)
			self._fireUpEffList[self._firePlayIndexUp]:setPosition(var_29_2, 0)

			self._firePlayIndexUp = self._firePlayIndexUp + 1

			if self._firePlayIndexUp > var_0_0.FIRE_NUM then
				self._firePlayIndexUp = 1
			end
		end
	else
		local var_29_3 = #self._fireDownEffList

		if #self._fireDownEffList < var_0_0.FIRE_NUM then
			self._fireDownEffList[var_29_3 + 1] = self.m_fireDownEffLoader:addEffectSpine({
				name = "eff_ui_anniversary_fireworkdown",
				isLoop = false,
				anim = "play_" .. var_29_1
			})

			self._fireDownEffList[var_29_3 + 1]:setPosition(var_29_2, 0)
		else
			self._fireDownEffList[self._firePlayIndexDown]:setAnimation(0, "play_" .. var_29_1, false)
			self._fireDownEffList[self._firePlayIndexDown]:setPosition(var_29_2, 0)

			self._firePlayIndexDown = self._firePlayIndexDown + 1

			if self._firePlayIndexDown > var_0_0.FIRE_NUM then
				self._firePlayIndexDown = 1
			end
		end
	end
end

return AnniversaryMainLayer
