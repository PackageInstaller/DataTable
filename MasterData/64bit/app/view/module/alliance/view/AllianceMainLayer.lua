local var_0_0 = g.core.const.ConstMgr.SpineConst
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.model.User.snapShotCacheData
local var_0_3 = g.core.const.ConstMgr.SnapShotCacheConst
local var_0_4 = g.core.model.User.allianceData
local AllianceMainLayer = class("AllianceMainLayer", require("app.fairyGUI.alliance.UI_AllianceMainLayer"), function()
	return fgui.GComponent:create({
		resName = "AllianceMainLayer",
		pkgName = "alliance",
		isFullScreen = true,
		pkgPath = "ui/alliance/alliance"
	}, ...)
end)

function AllianceMainLayer:ctor(arg_2_1)
	if arg_2_1 then
		self._routeValue = arg_2_1.route1 or 0
	end

	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.ALLIANCE)

	self._flyEff = nil

	self:initView()
end

function AllianceMainLayer:initView()
	self.m_topBar:setResInfoById(338)
	self.m_openBoxBtn:addClickListener(handler(self, self._onClickOpenBoxBtn))
	self.m_sendBoxBtn:addClickListener(handler(self, self._onClickSendBoxBtn))
	self.m_warZoneBtn:addClickListener(handler(self, self._onClickWarZoneBtn))
	self.m_mergeTipsBtn:addClickListener(handler(self, self._onClickMergeTipBtn))
	self.m_bgComp:setMoveToPos(self.m_openBoxBtn:getPosition())
end

function AllianceMainLayer:_onClickOpenBoxBtn()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_box)
	g.core.module.ModuleManager:pushModule(g.view.entrance.ALLIANCE_OPEN_BOX)
end

function AllianceMainLayer:_onClickSendBoxBtn()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SY_Cardon)
	g.core.module.ModuleManager:pushModule(g.view.entrance.ALLIANCE_SEND_BOX)
end

function AllianceMainLayer:_onClickWarZoneBtn()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_RodClick)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.alliance.view.pop.AllianceAreaPop").new())
end

function AllianceMainLayer:_onClickMergeTipBtn()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_RodClick)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.alliance.view.pop.AllianceMergeAreaPop").new())
end

function AllianceMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_GETINFO, handler(self, self._onGetInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_DISPLAYLIST, handler(self, self._onGetDisplayList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._updateShowUser), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_BOXINFO, handler(self, self._updateBoxView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_NOTICESTATE, handler(self, self._onNoticeState), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_AREA_MERGEINFO, handler(self, self._updateMergeAreaTip), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EXIT, handler(self, self._updateMergeAreaTip), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDay), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_HONOURGETINFO, handler(self, self._onGetHonourInfo), self)
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_GetInfo({})
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_TaskList({})
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_BoxInfo({})
	g.core.network.GameNetProxy:send_C2S_Area_MergeInfo({})
	self.m_bgComp:hideShowBox()

	if var_0_4:checkNeedGetUserTime() then
		g.core.network.GameNetProxy:send_C2S_GuildAlliance_DisplayList({})
	else
		self:_updateShowUser()
	end

	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_Menu_GHLM)
end

function AllianceMainLayer:_onGetHonourInfo()
	if #var_0_4:getHonorList() > 0 then
		g.core.module.ModuleManager:pushModule(g.view.entrance.ALLIANCE_HONOR, {})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(428615))
	end
end

function AllianceMainLayer:_onCrossDay()
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_GetInfo({})
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_TaskList({})
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_BoxInfo({})
end

function AllianceMainLayer:_onNoticeState()
	if not var_0_4:hasAlliance() then
		g.core.module.ModuleManager:tip(g.core.lang:get(428567))
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function AllianceMainLayer:_onGetInfo()
	if not self._isShowEnter then
		self._isShowEnter = true

		self.m_enterTransition:play()
	end

	self:checkPop(self._routeValue == 4)
	self.m_flag:setURL(var_0_1:getAllianceFlag128(var_0_4:getAllianceFlag()))
	self.m_allianceName:setText(var_0_4:getAllianceName())
	self.m_allianceLevel:setText(g.core.lang:get(120) .. var_0_4:getAllianceLevel())
	self.m_bgComp:updateEnterBtn()
	self:_updateMergeAreaTip()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_sendBoxBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_openBoxBtn
	})

	if self._routeValue == 7 then
		self:_onClickSendBoxBtn()
	elseif self._routeValue == 8 then
		self:_onClickOpenBoxBtn()
	elseif self._routeValue == 4 and g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.ALLIANCE_TRIAL) then
		self:newScheduleOnce(function()
			g.core.module.ModuleManager:pushModule(g.view.entrance.ALLIANCE_TRIAL)
		end, 0.2)
	end

	self._routeValue = 0
end

function AllianceMainLayer:checkPop(arg_14_1)
	if arg_14_1 or g.core.guide.GuideProxy:isGuideRunning() then
		return
	end

	if var_0_4:isNeedPopJoinAlliance() then
		local var_14_0 = require("app.view.module.alliance.view.pop.AllianceJoinSuccessPop").new()

		self:addListen(var_14_0)
		g.core.module.ModuleManager:pushPopup(var_14_0, {
			touchDisappear = true
		})

		return
	end

	if var_0_4:isNeedPopExpandAlliance() then
		local var_14_1 = {}

		var_14_1.touchDisappear = true
		var_14_1.hideContinue = true
		var_14_1.blackOpacity = 0.7
		var_14_1.withoutAni = true
		var_14_1.ignoreTouch = true

		g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
			autoDisappear = false,
			data = {},
			title = g.core.lang:get(428514),
			func = handler(self, self.checkPop),
			showComp = fgui.UIPackage:createObject("alliance", "AllianceExpandComp")
		}), var_14_1)

		return
	end

	if var_0_4:isNeedPopLevelUpAlliance() then
		local var_14_2 = {}

		var_14_2.touchDisappear = true
		var_14_2.hideContinue = true
		var_14_2.blackOpacity = 0.7
		var_14_2.withoutAni = true
		var_14_2.ignoreTouch = true

		g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
			autoDisappear = false,
			data = {},
			title = g.core.lang:get(428516),
			func = handler(self, self.checkPop),
			showComp = fgui.UIPackage:createObject("alliance", "AllianceLevelUpComp")
		}), var_14_2)
		self.m_bgComp:checkLevelUpUnlockBtn()

		return
	end
end

function AllianceMainLayer:_onGetDisplayList(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_4.user_ids or {}) do
		if not self:getUser(iter_15_1) then
			table.insert(var_15_1, iter_15_1)
		end
	end

	if #var_15_1 == 0 then
		self:_updateShowUser()
	end
end

function AllianceMainLayer:getUser(arg_16_1)
	return var_0_2:getSnapShot(var_0_3.SNAP_SHOT_KEY.USER, arg_16_1)
end

function AllianceMainLayer:_updateShowUser()
	self.m_bgComp:refreshOtherKnight()
end

function AllianceMainLayer:_updateBoxView()
	self.m_bgComp:scheduleLogTip()
	self.m_bgComp:showBoxView()
end

function AllianceMainLayer:receiveCompEvent(arg_19_1, arg_19_2)
	if arg_19_1 == "Success_pop_end" then
		self:checkPop()
	elseif arg_19_1 == "Play_fly_effect" and not self._flyEff then
		self._flyEff = self.m_openBoxBtn:getChild("eff"):addEffectSpine({
			remove = true,
			name = "eff_ui_alliance_fly",
			isLoop = false,
			anim = "play",
			eventHandler = handler(self, self._flyEffectEnd)
		})
	end
end

function AllianceMainLayer:_flyEffectEnd(arg_20_1)
	if arg_20_1.type == var_0_0.SPINE_EVENT.COMPLETE then
		self._flyEff = nil
	end
end

function AllianceMainLayer:_updateMergeAreaTip()
	local var_21_0 = g.core.model.User.areaMergeData:isShowMergeTips()

	self.m_mergeTipsBtn:setVisible(var_21_0)

	if var_21_0 then
		if g.core.model.User.areaMergeData:getMergeAreaStage() == g.core.const.ConstMgr.AreaMergeConst.STAGE.PREVIEW then
			self.m_mergeTipsBtn:setTitle(g.core.lang:get(430101))
		elseif g.core.model.User.areaMergeData:getMergeAreaStage() == g.core.const.ConstMgr.AreaMergeConst.STAGE.MERGE then
			self.m_mergeTipsBtn:setTitle(g.core.lang:get(430102))
		end

		if not g.core.model.User.dayNotifyTool:isTodayHasRecord(require("app.view.common.const.DayNotifyToolConst").TYPE_MERGE_AREA_TIP) then
			self.m_mergeTipsBtn:getController("isShowTip"):setSelectedIndex(1)
		else
			self.m_mergeTipsBtn:getController("isShowTip"):setSelectedIndex(0)
		end
	end
end

return AllianceMainLayer
