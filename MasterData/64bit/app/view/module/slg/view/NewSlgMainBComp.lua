local var_0_0 = g.core.model.User.newSlgData
local NewSlgMainBComp = class("NewSlgMainBComp", require("app.fairyGUI.newSlg.UI_NewSlgMainBComp"))
local var_0_2 = g.core.const.ConstMgr.NewSlgConst

function NewSlgMainBComp:ctor()
	self._compChat = self:getChild("Comp_chat")
	self._btnRank = self:getChild("Btn_rank")

	self._btnRank:addClickListener(handler(self, self._onClickBtnRank))

	self._btnShop = self:getChild("Btn_shop")

	self._btnShop:addClickListener(handler(self, self._onClickBtnShop))

	self._btnAttactProgress = self:getChild("Btn_attack_city")

	self._btnAttactProgress:addClickListener(handler(self, self._onClickBtnAttackProgress))

	if var_0_0:getSName() == "S2" then
		self._btnAttactProgress:setTitle(g.core.lang:get(429041))
		self.m_BtnFirstKill:setVisible(true)
	else
		self.m_BtnFirstKill:setVisible(false)
	end

	self._btnHome = self:getChild("Btn_home")

	self._btnHome:addClickListener(handler(self, self._onClickBtnHome))

	self._btnTeam = self:getChild("Btn_team")

	self._btnTeam:addClickListener(handler(self, self._onClickBtnTeam))

	self._btnFind = self:getChild("Btn_find")

	self._btnFind:addClickListener(handler(self, self._onClickBtnFind))

	self._compAttackCityBubble = self:getChild("Comp_attackCityBubble")

	self._compAttackCityBubble:setVisible(false)

	self._btnBag = self:getChild("Btn_bag")

	self._btnBag:addClickListener(handler(self, self._onClickBtnBag))

	self._btnPass = self:getChild("Btn_pass")

	self._btnPass:addClickListener(handler(self, self._onClickBtnPass))
	self._btnPass:setVisible(false)

	self._btnReport = self:getChild("Btn_report")

	self._btnReport:addClickListener(handler(self, self._onClickBtnReport))
	self.m_BtnFirstKill:addClickListener(handler(self, self._onClickBtnFirstKill))
	self.m_Btn_mail:addClickListener(handler(self, self._onClickBtnMail))

	self._chatComp = self:getChild("Comp_chat")

	self._chatComp:setCurChannel(g.core.const.ConstMgr.ChatConst.NEW_SLG)

	self._btnLastReport = self:getChild("Btn_last_report")

	self._btnLastReport:addClickListener(handler(self, self._onClickBtnLastReport))
	self.m_seasonTaskBtn:addClickListener(handler(self, self.onClickSeasonTask))

	if var_0_0:getSName() == "S2" then
		self._btnLastReport:setTitle(g.core.lang:get(429051))
		self.m_seasonTaskBtn:setVisible(true)
	else
		self.m_seasonTaskBtn:setVisible(false)
	end

	self._btnGather = self:getChild("Btn_gather")

	self._btnGather:addClickListener(handler(self, self._onClickBtnGather))
	self._btnShop:refreshRedPoint(true)
end

function NewSlgMainBComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SCHEDULE_NOTIFY_NEW, handler(self, self._onSchedule), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EXIT, handler(self, self.onUpdateModuleExit), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_MONSTERBATTLEREPORT, handler(self, self.updateReportRed), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSBATTLEFINISHNOTIFY, handler(self, self.updateReportRed), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NEW_SLG_BOSS_INVITE_RED_POINT, handler(self, self._refreshInviteBoss), self)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self._btnHome
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self._btnAttactProgress
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self._btnTeam
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self._btnReport
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self._btnBag
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_Btn_mail
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_BtnFirstKill
	})

	if var_0_0:getSName() == "S2" then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_seasonTaskBtn
		})
	end

	self:_updateSch()
end

function NewSlgMainBComp:_updateSch()
	g.core.utils.Tools.newSlgFunc.addSchedule({
		key = "NewSlgAttackCityBubble_updateTime"
	})
	g.core.utils.Tools.newSlgFunc.addSchedule({
		isOnce = true,
		key = "NewSlgGatherTime_effectShow",
		startTime = g.core.model.User.newSlgData:getChariotGatherStartTime()
	})
end

function NewSlgMainBComp:onUpdateModuleExit()
	self:updateReportRed()
end

function NewSlgMainBComp:updateReportRed()
	return
end

function NewSlgMainBComp:_refreshInviteBoss()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self._btnTeam
	})
end

function NewSlgMainBComp:_onSchedule(arg_7_1, arg_7_2, arg_7_3)
	if arg_7_3.key == "NewSlgAttackCityBubble_updateTime" then
		self:_updateAttackCityBubble()
	elseif arg_7_3.key == "NewSlgGatherTime_effectShow" then
		self:_updateGatherEffect()
	elseif arg_7_3.key == "NewSlgAttackCityBubble_fightingFinish" then
		self._compAttackCityBubble:setVisible(false)
	elseif arg_7_3.key == "NewSlgGatherTimeFinish_effectShow" then
		-- block empty
	end
end

function NewSlgMainBComp:updateView()
	self:_updateAttackCityBubble()
	self:_updateGatherEffect()
	self:updatePassGateBtn()
end

function NewSlgMainBComp:updatePassGateBtn()
	self._btnPass:setVisible(false)

	self._checkPointId = nil

	for iter_9_0, iter_9_1 in ipairs((g.core.model.User.newSlgData:getProvinceLinkIds())) do
		if g.core.model.User.newSlgData:getCheckPointState(iter_9_1) == var_0_2.CheckPointState.UnPass then
			self._btnPass:setVisible(true)

			self._checkPointId = iter_9_1

			break
		end
	end

	if self._checkPointId then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self._btnPass,
			customData = {
				id = self._checkPointId
			}
		})
	end
end

function NewSlgMainBComp:_updateAttackCityBubble()
	local var_10_0 = false

	for iter_10_0, iter_10_1 in ipairs((var_0_0:getNextAttackCityIds())) do
		if iter_10_1 > 0 and var_0_0:isCityFighting(iter_10_1) then
			var_10_0 = true

			break
		end
	end

	self._compAttackCityBubble:setVisible(var_10_0)
end

function NewSlgMainBComp:_updateGatherEffect()
	self.m_effGather:removeAllEffect()

	for iter_11_0, iter_11_1 in ipairs((var_0_0:getNextAttackCityIds())) do
		if iter_11_1 > 0 and var_0_0:isChariotGatherTime() then
			self.m_effGather:addEffectSpine({
				isLoop = true,
				name = "eff_ui_newSlg_gather"
			})
		end
	end
end

function NewSlgMainBComp:_onClickBtnGather()
	self:dispatchCompEvent("NewSlgMainBComp_onClickBtnGather")
end

function NewSlgMainBComp:_onClickBtnLastReport()
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_S2_CITY_RESULT)
end

function NewSlgMainBComp:_onClickBtnAttackProgress()
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_PVC_QUEST_POP)
end

function NewSlgMainBComp:_onClickBtnHome()
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_DEVELOP_MAIN_LAYER)
end

function NewSlgMainBComp:_onClickBtnTeam()
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_BOSS_TOTAL_TEAM)
end

function NewSlgMainBComp:_onClickBtnFind()
	self:dispatchCompEvent("NewSlg_SearchBtn_Click")
end

function NewSlgMainBComp:_onClickBtnBag()
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_BAG_POP)
end

function NewSlgMainBComp:_onClickBtnShop()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.NEW_SLG
	})
end

function NewSlgMainBComp:_onClickBtnRank()
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_RANK)
end

function NewSlgMainBComp:_onClickBtnReport()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.slg.view.br.NewSlgBattleReportPop").new(), {
		touchDisappear = true
	})
end

function NewSlgMainBComp:_onClickBtnFirstKill()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.slg.view.event.NewSlgEventPop").new(), {
		touchDisappear = true
	})
end

function NewSlgMainBComp:_onClickBtnMail()
	g.core.module.ModuleManager:pushModule(g.view.entrance.MAIL)
end

function NewSlgMainBComp:_onClickBtnPass()
	if self._checkPointId then
		g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_POINT_QUEST_POP, self._checkPointId)
		self:updatePassGateBtn()
	end
end

function NewSlgMainBComp:onClickSeasonTask()
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_SEASON_TASK)
end

return NewSlgMainBComp
