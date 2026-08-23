local var_0_0 = require("app.view.module.storm.const.StormConst").CITY_TYPE
local StormBigWorldLayer = class("StormBigWorldLayer", require("app.fairyGUI.storm.UI_StormBigWorldLayer"), function()
	return fgui.GComponent:create({
		resName = "StormBigWorldLayer",
		pkgPath = "ui/storm/storm",
		isFullScreen = true,
		pkgName = "storm"
	}, ...)
end)

function StormBigWorldLayer:ctor()
	self.m_bg:setURL("bg/storm/bg_xyjf_map_big2.jpg")

	self._curTouchX = 0
	self._curTouchY = 0
	self._maxX = 0
	self._maxY = 0
	self._minX = 0
	self._minX = 0
	self._centerPos = self.m_mapComp:getPosition()
	self._mapSize = self.m_mapComp:getSize()
	self._isFirstEnter = true

	self.m_mapComp:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self.m_mapComp:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:initMoveRange()
	self.m_rewardBtn:addClickListener(handler(self, self._onShowRewardPop))
	self.m_skillTreeBtn:addClickListener(handler(self, self._onSkillBtnClick))
	self.m_garrisonInfoBtn:addClickListener(handler(self, self._onGarrisonBtnClick))
	self.m_shopBtn:addClickListener(handler(self, self._onShopClick))
	self.m_easyBtn:addClickListener(handler(self, self._onEasyBtnClicked))
	self.m_topBar:setResInfoById(38)
	self.m_effmap:addEffectSpine({
		isLoop = true,
		name = "eff_ui_storm_map"
	})
	g.core.model.User.stormData:setIsEnter()
end

function StormBigWorldLayer:onLoad()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.STORM)
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_STORM_MAIN_LAYER)
	self.m_mapComp:setPosition(self._centerPos)
	self.m_playTimesComp:initView({
		type = g.core.common.Goods.RESOURCE.TYPE_TIRED,
		getTimesFunc = function()
			return g.core.model.User.bagData:getCountById(1, 24)
		end
	})

	if g.core.model.User.stormData:isAllStormFinish(var_0_0.SMALL_CITY) then
		self.m_playTimesComp:setVisible(false)
	end

	if g.core.model.User.stormData:isMiddleCityOpen() then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_INFO, self._onGetStormInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_CITY_INFO, self._onGetStormCityInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_ONEKEY_CLEAR, self._onGetStormCityInfo, self)
	g.core.network.GameNetProxy:send_C2S_Storm_Info({})
	g.core.network.GameNetProxy:send_C2S_Storm_GetSkillInfo({})

	local var_3_0

	for iter_3_0, iter_3_1 in ipairs((g.core.model.User.stormData:getUnlockMiddleCityList())) do
		local var_3_2

		if 0 < iter_3_1.info.order then
			var_3_2 = iter_3_1.info.order
			var_3_0 = iter_3_1
		end
	end

	self.m_easyBtn:setVisible(g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.STORM_ONE_KEY) and (var_3_0 or nil) and g.core.model.User.stormData:isUnlockBlitz(var_3_0.info.id))
end

function StormBigWorldLayer:_onGetStormInfo()
	if g.core.model.User.stormData:isStationOpenAndWeekFirstEnter() then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.storm.view.pop.StormStationOpenPop").new({
			callFunc = function()
				self:moveToCurLand()
			end
		})))
	else
		self:moveToCurLand()
	end

	if self._isFirstEnter then
		self.m_enterTransition:play()

		self._isFirstEnter = false
	end

	local var_5_0 = g.core.model.User.stormCityData:getOwnCityId()

	if var_5_0 ~= 0 then
		g.core.network.GameNetProxy:send_C2S_StormCity_Info({
			city = var_5_0
		})
	end

	self.m_mapComp:updatePositionState()
end

function StormBigWorldLayer:_onGetStormCityInfo()
	self.m_mapComp:updatePositionState()
end

function StormBigWorldLayer:moveToCurLand()
	self._waitEvent = true

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	local var_8_0, var_8_1 = self.m_mapComp:getCurLandPosCompDir()
	local var_8_2 = 0
	local var_8_3 = 0

	if var_8_0 + self.m_mapComp:getX() > self._maxX then
		var_8_2 = self._maxX - (var_8_0 + self.m_mapComp:getX())
	elseif var_8_0 + self.m_mapComp:getX() < self._minX then
		var_8_2 = self._minX - (var_8_0 + self.m_mapComp:getX())
	end

	if var_8_1 + self.m_mapComp:getY() > self._maxY then
		var_8_3 = self._maxY - (var_8_1 + self.m_mapComp:getY())
	elseif var_8_0 + self.m_mapComp:getX() < self._minX then
		var_8_3 = self._minY - (var_8_1 + self.m_mapComp:getY())
	end

	self.m_mapComp:runFGAction(fgui.FSequence:create(fgui.FDelayTime:create(0.2), fgui.FMoveBy:create(0.4, cc.p(var_8_0 + var_8_2, var_8_1 + var_8_3)), fgui.FCallFunc:create(handler(self, self._onMoveEventEnd))))
end

function StormBigWorldLayer:_onMoveEventEnd()
	self._waitEvent = false

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
end

function StormBigWorldLayer:initMoveRange()
	self._mapSize = {
		width = self._mapSize.width * 0.75,
		height = self._mapSize.height * 0.75
	}
	self._maxX = self._mapSize.width / 2
	self._minX = display.width - self._mapSize.width / 2
	self._maxY = self._mapSize.height / 2
	self._minY = display.height - self._mapSize.height / 2
end

function StormBigWorldLayer:_onTouchBegin(arg_11_1)
	arg_11_1:captureTouch()

	local var_11_0 = arg_11_1:getInput():getPosition()

	self._curTouchX = var_11_0.x
	self._curTouchY = var_11_0.y
end

function StormBigWorldLayer:_onTouchMove(arg_12_1)
	arg_12_1:captureTouch()

	local var_12_0 = arg_12_1:getInput():getPosition()

	self:moveWorld(var_12_0.x - self._curTouchX, var_12_0.y - self._curTouchY)

	self._curTouchX = var_12_0.x
	self._curTouchY = var_12_0.y
end

function StormBigWorldLayer:moveWorld(arg_13_1, arg_13_2)
	local var_13_0 = self.m_mapComp:getPosition()

	self.m_mapComp:setX(math.min(math.max(var_13_0.x + arg_13_1, self._minX), self._maxX))
	self.m_mapComp:setY(math.min(math.max(var_13_0.y + arg_13_2, self._minY), self._maxY))
end

function StormBigWorldLayer:_onSkillBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.STORM_SKILL_LAYER)
end

function StormBigWorldLayer:_onShowRewardPop()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.storm.view.pop.StormLiberationRewardPop").new(), {
		touchDisappear = true
	})
end

function StormBigWorldLayer:_onGarrisonBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.STORM_STATION_RANK)
end

function StormBigWorldLayer:_onShopClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.STORM
	})
end

function StormBigWorldLayer:_onEasyBtnClicked()
	local var_18_0

	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.STORM_ONE_KEY) then
		do return end

		var_18_0 = {}
	end

	for iter_18_0, iter_18_1 in ipairs((g.core.model.User.stormData:getUnlockMiddleCityList())) do
		if not g.core.model.User.stormData:isMiddleCityCleared(iter_18_1.info.id) and (iter_18_1.info.sweep ~= 0 or nil) and g.core.model.User.stormData:isPresetUnlock(iter_18_1.info.sweep) then
			var_18_0[#var_18_0 + 1] = iter_18_1.info.id
		end
	end

	local var_18_3

	if #var_18_0 == 0 or not g.core.model.User.stormData:isMiddleCityInOpenTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(304543))

		do return end

		var_18_3 = {
			title = g.core.lang:get(111026)
		}
	end

	var_18_3.desc = g.core.lang:get(304544)

	function var_18_3.onConfirm()
		g.core.module.ModuleManager:pushPopup(require("app.view.module.storm.view.pop.StormOneKeyClearFinishPop").new(), {
			touchDisappear = true
		})
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new(var_18_3), {
		touchDisappear = true
	})
end

function StormBigWorldLayer:onUnload()
	if self._waitEvent then
		self._waitEvent = false

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end
end

return StormBigWorldLayer
