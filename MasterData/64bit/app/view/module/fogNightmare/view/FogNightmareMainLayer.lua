local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.model.User.fogNightmareData
local var_0_3 = g.core.common.ServerTime
local var_0_4 = g.core.model.User.shopData
local var_0_5 = g.core.module.ModuleManager
local BaseUseBuyPop = require("app.view.base.infoPop.BaseUseBuyPop")
local var_0_7 = g.core.service.ServiceManager:getServiceByName("GuideService")
local FogNightmareMainLayer = class("FogNightmareMainLayer", require("app.fairyGUI.fogNightmare.UI_FogNightmareMainLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/fogNightmare/fogNightmare",
		resName = "FogNightmareMainLayer",
		pkgName = "fogNightmare",
		isFullScreen = true
	}, ...)
end)

function FogNightmareMainLayer:ctor()
	self._isPlaying = false
	self._onClickBackBtn = false
	self._bg = nil
	self._startBtnEff = nil
	self._schedule = nil

	self:_initView()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(var_0_1.FUNCTION_TYPE.FOG_NIGHTMARE)
end

function FogNightmareMainLayer:_initView()
	self._bg = self:addBg("bg/fogNightmare/bg_wjmy_main.jpg")

	self.m_maskBgDadComp:addBg("bg/fogNightmare/bg_wjmy_main_mask.png")
	self.m_topBarComp:setResInfoById(var_0_1.HelpConst.HELP_TYPE.FOG_NIGHTMARE)
	self.m_topBarComp:setReturnCallBack(handler(self, self.onClickBackBtn))
	self.m_assistanceBtn:addClickListener(handler(self, self._onClickAssistanceBtn))
	self.m_rankBtn:addClickListener(handler(self, self._onClickRankBtn))
	self.m_talentBtn:addClickListener(handler(self, self._onClickTalentBtn))
	self.m_startPlayBtn:addClickListener(handler(self, self._onClickStartPlayBtn))
	self.m_idleBtn:addClickListener(handler(self, self._onClickIdleBtn))
	self.m_levelProgressBtn:addClickListener(handler(self, self._onClickLevelProgressBtn))
	self.m_buffBtn:addClickListener(handler(self, self._onShowWeeklyBuffPop))
	self.m_serverListBtn:addClickListener(handler(self, self._onShowServerListPop))
	self:addBtnEffect(self.m_rankBtn, "eff_ui_fogNightmare_mainlayerBtn1")
	self:addBtnEffect(self.m_assistanceBtn, "eff_ui_fogNightmare_mainlayerBtn2")
	self:addBtnEffect(self.m_buffBtn, "eff_ui_fogNightmare_mainlayerBtn2")
	self:addBtnEffect(self.m_talentBtn, "eff_ui_fogNightmare_mainlayerBtn3")
	self:addBtnEffect(self.m_idleBtn, "eff_ui_fogNightmare_mainlayerBtn4")
	self:addBtnEffect(self.m_levelProgressBtn, "eff_ui_fogNightmare_mainlayerLevel")
	self.m_effectNode:addEffectSpine({
		name = "eff_ui_fogNightmare_mainlayerTitle",
		isLoop = false
	})
	self.m_effectStart:addEffectSpine({
		anim = "play",
		isLoop = false,
		name = "eff_ui_fogNightmare_mainlayerRukou"
	})
	self:_initBgEffect()
end

function FogNightmareMainLayer:_initBgEffect()
	self._bgSpine = self.m_effectBgNode:addEffectSpine({
		name = "wujinmengyan_kv_play",
		isLoop = true,
		anim = "wujinmengyan_kv_idle",
		eventHandler = handler(self, self._onBgSpineEventCallBack)
	})

	for iter_4_0 = 1, 3 do
		local var_4_0 = string.format("wujinmengyan_kv_%02d", iter_4_0)

		self._bgSpine:getNodeForSlot(var_4_0):addChild((require("app.view.common.SpineBase").new({
			isLoop = true,
			resId = var_4_0,
			path = g.core.common.Path:getEffSpine(var_4_0),
			anim = var_4_0
		})))
	end

	self._bgSpine:setScale(1.2)
end

function FogNightmareMainLayer:_onBgSpineEventCallBack(arg_5_1, arg_5_2)
	return
end

function FogNightmareMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_GETINFO, handler(self, self._onGetInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_NOTICEACTIVITY, handler(self, self._onGetActivityInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_TALENT_GETINFO, handler(self, self._updateTalentRed), self)
	self:_initPlayTimesComp()

	if self.m_showStyleController:getSelectedIndex() == 0 then
		self.m_enterTransition:play()
		self._bg:setOpacity(0)
		self._bg:runFGAction(fgui.FEaseQuinticActionOut:create((fgui.FFadeTo:create(2, 255))))
	end

	g.core.network.GameNetProxy:send_C2S_Fog_GetInfo({})
	g.core.network.GameNetProxy:send_C2S_Fog_Talent_Attribute({})
	g.core.network.GameNetProxy:send_C2S_Fog_Talent_GetInfo({})
	g.core.network.GameNetProxy:send_C2S_Fog_GetServerInfos({})

	local var_6_0 = g.core.model.User:getGuildId()

	if var_6_0 and var_6_0 ~= 0 then
		g.core.network.GameNetProxy:send_C2S_Fog_GuildFloor({})
	else
		var_0_2:getIdleData():clearGuildBuffInfo()
	end

	self._runnerScheduler = self:newSchedule(handler(self, self._updateProfitTime), 1)

	if g.core.model.User.guideData:getServerDataById(20) then
		self:checkGuideTick()
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_GUIDE_RE_CHECK)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	g.core.sound.SoundManager:playMusic(var_0_1.SoundConst.BGM.MUSIC_MENU_WUJINGMENGYAN_LAYER)
	self.m_selectComp:hideList()
end

function FogNightmareMainLayer:_onGetInfo()
	if self._schedule == nil then
		self._schedule = self:newSchedule(handler(self, self._updateTimeBySchedule), 1)
	end

	self:updateView()
	var_0_2:resetServerRedPoint()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_idleBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_startPlayBtn
	})

	if not g.core.guide.GuideProxy:isGuideRunning() then
		self:newScheduleOnce(handler(self, self._checkWeekBuffPop), 0.8)
	end
end

function FogNightmareMainLayer:_updateTalentRed()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_talentBtn
	})
end

function FogNightmareMainLayer:_checkWeekBuffPop()
	if not self._onClickBackBtn and not g.core.model.User.storyData:isInStory() and var_0_2:isAutoPopWeekBuff() then
		self:_onShowWeeklyBuffPop()
	end
end

function FogNightmareMainLayer:_onGetActivityInfo()
	g.core.network.GameNetProxy:send_C2S_Fog_GetInfo({})
end

function FogNightmareMainLayer:updateView()
	local var_11_0 = var_0_2:getTowerData():getFastFloors()

	if #var_11_0 > 0 then
		if not var_0_2:getFormationData():hasPoolMember() then
			self.m_selectComp:updateBtn(var_11_0)
			self.m_canQuickJumpController:setSelectedIndex(1)

			goto label_11_0
		end
	end

	self.m_canQuickJumpController:setSelectedIndex(0)

	::label_11_0::
end

function FogNightmareMainLayer:_updateProfitTime()
	local var_12_0, var_12_1, var_12_2 = var_0_2:getIdleData():getCurIdleTimeHMS()

	self.m_profitTime:setText(g.core.lang:get(500105, {
		hour = g.core.utils.Number.getFormatNum(2, var_12_0),
		min = g.core.utils.Number.getFormatNum(2, var_12_1),
		sec = g.core.utils.Number.getFormatNum(2, var_12_2)
	}))
end

function FogNightmareMainLayer:_updateTimeBySchedule()
	local var_13_0 = var_0_3:getTime()
	local var_13_1 = var_0_2:getEndTime()

	if var_13_0 <= var_13_1 then
		self.m_timeText:setText(g.core.lang:get(500103, {
			timeStr = var_0_3:secondToDHMString(var_13_1 - var_13_0)
		}))
	else
		var_0_5:tip(g.core.lang:get(500104))
		var_0_5:popAllPopup()
		var_0_5:replaceModule(g.view.entrance.FOG_NIGHTMARE_RESULT_LAYER)
	end
end

function FogNightmareMainLayer:_initPlayTimesComp()
	self.m_playTimesComp:initView({
		playNum = var_0_1.ShopConst.PLAY_TYPE.FOG_NIGHTMARE_EXPLORE,
		getTimesFunc = function()
			return var_0_4:getLeftCount(var_0_1.ShopConst.PLAY_TYPE.FOG_NIGHTMARE_EXPLORE)
		end,
		refreshEvent = {
			g.core.event.enum.EVENT_RECOVER_STEP,
			g.core.event.enum.EVENT_FORCE_FRESH,
			g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM,
			g.core.event.enum.EVENT_NET_S2C_RFRESH_RESOURCE
		},
		onGetTimes = function()
			var_0_5:pushPopup(BaseUseBuyPop.new({
				type = var_0_0.TYPE_ITEM,
				value = var_0_0.ITEM.TYPE_FOG_NIGHT_CHALLENGE,
				shopId = var_0_1.ShopConst.SHOP_ITEM_ID.FOG_NIGHTMARE_EXPLORE_TOKEN
			}), {
				touchDisappear = true
			})
		end
	})
end

function FogNightmareMainLayer:_onClickAssistanceBtn()
	var_0_5:pushPopup(require("app.view.module.fogNightmare.view.assistant.FogNightAssistantPop").new(), {
		hideContinue = true,
		touchDisappear = true,
		ignoreTouch = false
	})
end

function FogNightmareMainLayer:_onClickRankBtn()
	var_0_5:pushPopup(require("app.view.module.fogNightmare.view.rank.FogNightmareRankPop").new(), {
		blackOpacity = 0.5,
		touchDisappear = false,
		ignoreTouch = false
	})
end

function FogNightmareMainLayer:_onClickTalentBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FOG_NIGHTMARE_TALENT)
end

function FogNightmareMainLayer:_onClickStartPlayBtn()
	self.m_selectComp:hideList()

	if self._isPlaying then
		return
	end

	self.m_enterTransition:stop()

	if var_0_2:getFormationData():hasPoolMember() then
		self._isPlaying = true

		self.m_backTransition:play(handler(self, self._onStartPlay))
	elseif var_0_4:getLeftCount(var_0_1.ShopConst.PLAY_TYPE.FOG_NIGHTMARE_EXPLORE) <= 0 then
		var_0_5:pushPopup(BaseUseBuyPop.new({
			type = var_0_0.TYPE_ITEM,
			value = var_0_0.ITEM.TYPE_FOG_NIGHT_CHALLENGE,
			shopId = var_0_1.ShopConst.SHOP_ITEM_ID.FOG_NIGHTMARE_EXPLORE_TOKEN
		}), {
			touchDisappear = true
		})
	else
		local var_20_0 = 1

		if self.m_canQuickJumpController:getSelectedIndex() == 1 then
			var_20_0 = self.m_selectComp:getSelectedFloor()
		end

		var_0_2:getFormationData():updateSelectInfos()
		var_0_5:pushPopup(require("app.view.module.fogNightmare.view.explore.pop.FogNightmareExploreKnightPoolPop").new({
			showBtn = true,
			floor = var_20_0
		}), {
			touchDisappear = false
		})
	end
end

function FogNightmareMainLayer:_onStartPlay()
	self._isPlaying = false

	var_0_5:pushModule(g.view.entrance.FOG_NIGHTMARE_EXPLORE)
end

function FogNightmareMainLayer:_onClickIdleBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FOG_NIGHTMARE_IDLE)
end

function FogNightmareMainLayer:_onClickLevelProgressBtn()
	var_0_5:pushPopup(require("app.view.module.fogNightmare.view.level.FogNightmareLevelPop").new(0, 1), {
		hideContinue = false,
		touchDisappear = true,
		ignoreTouch = false
	})
end

function FogNightmareMainLayer:_onShowWeeklyBuffPop()
	var_0_5:pushPopup(require("app.view.module.fogNightmare.view.pop.FogNightmareWeeklyBuffPop").new({
		buffInfo = var_0_2:getWeeklyBuff()
	}), {
		touchDisappear = true
	})
end

function FogNightmareMainLayer:onClickBackBtn()
	if self._isPlaying then
		return
	end

	self._isPlaying = true

	self.m_enterTransition:stop()

	self._onClickBackBtn = true

	self.m_backTransition:play(handler(self, self._onClose))
end

function FogNightmareMainLayer:_onClose()
	g.core.module.ModuleManager:popComponent()
end

function FogNightmareMainLayer:addBtnEffect(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	return arg_27_1:getChild("effectNode"):addEffectSpine({
		name = arg_27_2,
		isLoop = arg_27_4 == true,
		anim = arg_27_3 or "play"
	})
end

function FogNightmareMainLayer:onUnload()
	if self._runnerScheduler then
		self:cancelSchedule(self._runnerScheduler)

		self._runnerScheduler = nil
	end

	self._isPlaying = false
	self._schedule = nil

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

function FogNightmareMainLayer:_onShowServerListPop()
	var_0_5:pushPopup(require("app.view.module.fogNightmare.view.pop.FogNightmareServerListPop").new(), {
		touchDisappear = true
	})
end

function FogNightmareMainLayer:checkGuideTick()
	self:checkStartExploreGuide()
	self:checkIdleFirstGuide()
	self:checkIdleFullGuide()
	self:checkTalentFirstGuide()
	self:checkTalentUpgradeGuide()
end

function FogNightmareMainLayer:checkStartExploreGuide()
	if self._tickExploreGuide then
		return
	end

	if var_0_2:getTowerData():getHistoryMaxFloorNum() < 10 then
		self._tickExploreGuide = true

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "GUIDE_CHECK_FOG_EXPLORE",
			targetBtn = self.m_startPlayBtn
		})
	end
end

function FogNightmareMainLayer:checkIdleFirstGuide()
	if var_0_2:getIdleData():getCurIdleTime() >= 900 and not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.FOG_IDLE_ENTER) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "GUIDE_CHECK_FOG_IDLE_FIRST",
			targetBtn = self.m_idleBtn
		})
	end
end

function FogNightmareMainLayer:checkIdleFullGuide()
	if self._tickIdleFull then
		return
	end

	if var_0_2:getIdleData():isIdleTimeFull() and not var_0_7:isInTickedSpeGuide() then
		self._tickIdleFull = true

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "GUIDE_CHECK_FOG_IDLE_FULL",
			targetBtn = self.m_idleBtn
		})
	end
end

function FogNightmareMainLayer:checkTalentFirstGuide()
	if g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.TYPE_FOG_NIGHTMARE_TALENT_POINT) > 75 and not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.FOG_TALENT_ENTER) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "GUIDE_CHECK_FOG_TALENT_FIRST",
			targetBtn = self.m_talentBtn
		})
	end
end

function FogNightmareMainLayer:checkTalentUpgradeGuide()
	if self._tickTalentGuide then
		return
	end

	if g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.TYPE_FOG_NIGHTMARE_TALENT_POINT) > 150 and not var_0_7:isInTickedSpeGuide() then
		self._tickTalentGuide = true

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "GUIDE_CHECK_FOG_TALENT",
			targetBtn = self.m_talentBtn
		})
	end
end

return FogNightmareMainLayer
