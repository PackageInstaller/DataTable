local var_0_0 = g.core.model.User.newSlgData
local var_0_1 = g.core.common.ServerTime
local var_0_2 = g.core.module.ModuleManager
local var_0_3 = g.core.event.EventManager
local var_0_4 = g.core.event.enum
local NewSlgDevelopMainLayer = class("NewSlgDevelopMainLayer", require("app.fairyGUI.newSlg.UI_NewSlgDevelopMainLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/newSlg/newSlg",
		resName = "NewSlgDevelopMainLayer",
		pkgName = "newSlg",
		isFullScreen = true
	}, ...)
end)
local var_0_6 = g.core.const.ConstMgr.NewSlgConst

function NewSlgDevelopMainLayer:ctor(arg_2_1)
	self.m_bgLoader:setURL("bg/newSlg/bg_hzts_zhucheng.jpg")

	self._params = arg_2_1 or {}
	self._isParamFirst = true
	self._endTime = var_0_0:getActEndTime()
	self._schedule = nil

	self.m_topBarComp:setResInfoById(344, nil, {
		{
			type = 3,
			value = 60005
		},
		{
			type = 3,
			value = 60006
		}
	})

	if g.core.model.User.newSlgData:getSeasonId() >= 2 then
		self.m_topBarComp:setHelpId(376)
	end

	self.m_chatComp:setCurChannel(g.core.const.ConstMgr.ChatConst.NEW_SLG)
	self:_initClickListener()
end

function NewSlgDevelopMainLayer:_initClickListener()
	self.m_rankBtn:addClickListener(handler(self, self._onClickBtnRank))
	self.m_shopBtn:addClickListener(handler(self, self._onClickBtnShop))
	self.m_reportBtn:addClickListener(handler(self, self._onClickBtnReport))
	self.m_bagBtn:addClickListener(handler(self, self._onClickBtnBag))
	self.m_lastReportBtn:addClickListener(handler(self, self._onClickBtnLastReport))
	self.m_checkBtn:addClickListener(handler(self, self._onCheck))
	self.m_checkBtn:setVisible(device.isWindowsDebug())
	self.m_strategyBtn:addClickListener(handler(self, self._onStrategyBtnClicked))
end

function NewSlgDevelopMainLayer:_onCheck()
	g.core.model.User.newSlgDevelopData:checkUpgradeCfgValid()
end

function NewSlgDevelopMainLayer:onLoad()
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_SLG_Menu)
	var_0_3:addEventListener(var_0_4.EVENT_GUIDE_STOP, handler(self, self._onRecGuideStop), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_GUILD_ALLIANCE_NOTICESTATE, handler(self, self._onNoticeState), self)
	var_0_3:addEventListener(var_0_4.SLG_FARM_JUMP_STEP_1, handler(self, self.onJumpFarm), self)
	var_0_3:dispatchEvent(var_0_4.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_bagBtn
	})
	var_0_3:addEventListener(var_0_4.EVENT_CROSS_DAY_NOTIFY, handler(self, self._updateStrategyBtn), self)
	self:_updateCountDown()

	self._schedule = self._schedule or self:newSchedule(handler(self, self._updateCountDown), 1)

	self:_updateView()
	self.m_enterTransition:play(handler(self, self._checkGuide))
	self:_dealInitParams()
	self:_updateStrategyBtn()
end

function NewSlgDevelopMainLayer:_dealInitParams()
	if self._isParamFirst then
		self._isParamFirst = false

		if g.core.guide.GuideProxy:isGuideRunning() then
			return
		end

		if self._params then
			local var_6_0 = self._params.route1 or 0

			if var_6_0 == 1 then
				self:newScheduleOnce(function()
					var_0_2:pushModule(g.view.entrance.NEW_SLG_EMBRYO_LINEUP_POP)
				end)
			elseif var_6_0 == 2 then
				self:newScheduleOnce(function()
					var_0_2:pushModule(g.view.entrance.NEW_SLG_SUPPLY_POP)
				end)
			elseif var_6_0 >= 3 and var_6_0 <= 5 then
				local var_6_1 = var_0_6.SLG_BUILD_TYPE.BARRACK
				local var_6_2 = var_0_6.ARMY_TYPE.QI

				if var_6_0 == 4 then
					var_6_2 = var_0_6.ARMY_TYPE.DUN
				elseif var_6_0 == 5 then
					var_6_2 = var_0_6.ARMY_TYPE.GONG
				end

				self:newScheduleOnce(function()
					var_0_2:pushModule(g.view.entrance.New_SLG_BARRACK_POP, {
						buildType = var_6_1,
						armyType = var_6_2
					})
				end)
			elseif var_6_0 == 7 then
				self:newScheduleOnce(function()
					var_0_2:pushModule(g.view.entrance.NEW_SLG_SKILL_TREE)
				end)
			end
		end
	end
end

function NewSlgDevelopMainLayer:_onRecGuideStop()
	self:_checkGuide()
end

function NewSlgDevelopMainLayer:_onNoticeState()
	if not g.core.model.User.allianceData:hasAlliance() then
		var_0_2:tip(g.core.lang:get(428567))
		var_0_2:popToRoot()
	end
end

function NewSlgDevelopMainLayer:receiveCompEvent(arg_13_1)
	if arg_13_1 == "GetAwardPop_exit" then
		self:_checkGuide()
	elseif arg_13_1 == "NewSlgSupply_goto_farm" then
		var_0_2:popComponent()
	end
end

function NewSlgDevelopMainLayer:_updateCountDown()
	local var_14_0 = self._endTime - var_0_1:getTime()

	self.m_timeTxt:setText((var_0_1:getActivityLeftTime(math.max(0, var_14_0))))

	if var_14_0 >= 0 then
		self.m_developComp:updateResVisible()
	else
		if self._schedule then
			self:cancelSchedule(self._schedule)

			self._schedule = nil
		end

		self:_updateView()
	end
end

function NewSlgDevelopMainLayer:_checkGuide()
	do return end

	if var_0_2:getCurModule().module ~= g.view.entrance.NEW_SLG_DEVELOP_MAIN_LAYER then
		return
	end

	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	end

	if not self:_checkTaskGuide(1001) and not self:_checkSupplyGuide() and self:_checkTaskGuide(1002) then
		-- block empty
	end
end

function NewSlgDevelopMainLayer:_checkTaskGuide(arg_16_1)
	if g.core.model.User.newSlgData:checkTaskCanGetAwardById(arg_16_1) then
		if arg_16_1 == 1001 then
			if not g.core.guide.GuideProxy:isIgnoreGuide(g.core.const.ConstMgr.GuideConst.TYPE.NEW_SLG_GUIDE_3) then
				g.core.guide.GuideProxy:startGuide(g.guide.NewSlgGuideConfig.GUIDE.NEW_SLG_GUIDE_3)

				return true
			end
		elseif arg_16_1 == 1002 and not g.core.guide.GuideProxy:isIgnoreGuide(g.core.const.ConstMgr.GuideConst.TYPE.NEW_SLG_GUIDE_5) then
			g.core.guide.GuideProxy:startGuide(g.guide.NewSlgGuideConfig.GUIDE.NEW_SLG_GUIDE_5)

			return true
		end
	end

	return false
end

function NewSlgDevelopMainLayer:_checkSupplyGuide()
	if not g.core.guide.GuideProxy:isIgnoreGuide(g.core.const.ConstMgr.GuideConst.TYPE.NEW_SLG_GUIDE_4) and g.core.model.User.newSlgDevelopData:checkSupplyCanCall() then
		g.core.guide.GuideProxy:startGuide(g.guide.NewSlgGuideConfig.GUIDE.NEW_SLG_GUIDE_4)

		return true
	end

	return false
end

function NewSlgDevelopMainLayer:_updateView()
	self.m_compTeamInfo:updateView()
end

function NewSlgDevelopMainLayer:_onClickBtnReport()
	var_0_2:pushPopup(require("app.view.module.slg.view.br.NewSlgBattleReportPop").new(), {
		touchDisappear = true
	})
end

function NewSlgDevelopMainLayer:_onClickBtnRank()
	var_0_2:pushModule(g.view.entrance.NEW_SLG_RANK)
end

function NewSlgDevelopMainLayer:_onClickBtnShop()
	var_0_2:pushModule(g.view.entrance.SHOP, {
		tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.NEW_SLG
	})
end

function NewSlgDevelopMainLayer:_onClickBtnBag()
	var_0_2:pushModule(g.view.entrance.NEW_SLG_BAG_POP)
end

function NewSlgDevelopMainLayer:_onClickBtnLastReport()
	if self._sName == "S3" then
		var_0_2:pushModule(g.view.entrance.NEW_SLG_S3_CITY_RESULT)
	else
		var_0_2:pushModule(g.view.entrance.NEW_SLG_S2_CITY_RESULT)
	end
end

function NewSlgDevelopMainLayer:_onClickBtnAttackProgress()
	var_0_2:pushModule(g.view.entrance.NEW_SLG_PVC_QUEST_POP)
end

function NewSlgDevelopMainLayer:onJumpFarm(arg_25_1, arg_25_2, arg_25_3)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.SLG_FARM_JUMP_STEP_2, false, arg_25_3)
	end, 0.2)
end

function NewSlgDevelopMainLayer:_onStrategyBtnClicked()
	var_0_2:pushModule(g.view.entrance.NEW_SLG_STRATEGY_POP)
end

function NewSlgDevelopMainLayer:_updateStrategyBtn()
	self.m_strategyBtn:setVisible(var_0_0:isShowStrategy())
end

return NewSlgDevelopMainLayer
