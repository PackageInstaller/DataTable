local var_0_0 = g.core.model.User.bioData
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum
local BioTeamChooseCampaignLayer = class("BioTeamChooseCampaignLayer", require("app.fairyGUI.biography.UI_BioTeamChooseCampaignLayer"), function()
	return fgui.GComponent:create({
		resName = "BioTeamChooseCampaignLayer",
		pkgName = "biography",
		isFullScreen = true,
		pkgPath = "ui/biography/biography"
	}, ...)
end)

function BioTeamChooseCampaignLayer:ctor(arg_2_1)
	self:addBg("bg/bio/bg_jjxd_juejingxingdong.jpg")

	self._maxOpenLandIndex = 1
	self._showTab = 1
	self._isFirstEnter = true

	self.m_pageList:setVirtual()
	self.m_pageList:doFairyBatching(false)
	self.m_pageList:setItemRenderer(handler(self, self._onListRenderer))
	self.m_achieveBtn:addClickListener(handler(self, self._onAchieveClick))
	self.m_simpleBtn:addClickListener(handler(self, self._onSimpleClick))
	self.m_hardBtn:addClickListener(handler(self, self._onHardClick))
	self.m_desperateBtn:addClickListener(handler(self, self._onDesperateClick))
	self.m_nightmareBtn:addClickListener(handler(self, self._onNightmareClick))
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.BIO_TEAM)
	self.m_isHardController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTitleStyle))

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.NIGHTMARE_BIO_TEAM) then
		self._showTab = 4
	elseif g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.DESPERATE_BIO_TEAM) then
		self._showTab = 3
	elseif g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.HARD_BIO_TEAM) then
		self._showTab = 2
	end
end

function BioTeamChooseCampaignLayer:onLoad()
	var_0_2:dispatchEvent(var_0_3.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_BIOGRAPHY_GETCAMPAIGNFIRSTAWARD, self._onGetCampaignAward, self)
	var_0_2:addEventListener(var_0_3.EVENT_GUIDE_FINISH, self._onForceGuideEnd, self)
	var_0_2:addEventListener(var_0_3.EVENT_CROSS_DAY_NOTIFY, self._onCrossDay, self)

	local var_3_0 = var_0_0:getTeamInfo()

	if var_3_0 and var_3_0.id ~= 0 then
		g.core.network.GameNetProxy:send_C2S_Biography_LeaveTeam({
			id = var_3_0.campaign_id
		})
	end

	self:_updateView()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)

	local var_3_1 = 0

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.NIGHTMARE_BIO_TEAM) then
		var_3_1 = 3
	elseif g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.DESPERATE_BIO_TEAM) then
		var_3_1 = 2
	elseif g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.HARD_BIO_TEAM) then
		var_3_1 = 1
	end

	self.m_openHardController:setSelectedIndex(var_3_1)
	self:_checkSpeWeakGuide()
end

function BioTeamChooseCampaignLayer:_onSimpleClick()
	self.m_isHardController:setSelectedIndex(0)

	self._isChangeTab = true
end

function BioTeamChooseCampaignLayer:_onHardClick()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.HARD_BIO_TEAM) then
		self.m_isHardController:setSelectedIndex(1)

		self._isChangeTab = true
	else
		self.m_lockCtrlController:setSelectedIndex(0)

		local var_5_0, var_5_1 = g.core.common.ModuleUnlock:getModuleUnlockLevelAndComment(g.core.const.ConstMgr.FUNCTION_TYPE.HARD_BIO_TEAM)

		g.core.module.ModuleManager:tip(var_5_1)
	end
end

function BioTeamChooseCampaignLayer:_onDesperateClick()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.DESPERATE_BIO_TEAM) then
		self.m_isHardController:setSelectedIndex(2)

		self._isChangeTab = true
	else
		self.m_lockCtrlController:setSelectedIndex(0)

		local var_6_0, var_6_1 = g.core.common.ModuleUnlock:getModuleUnlockLevelAndComment(g.core.const.ConstMgr.FUNCTION_TYPE.DESPERATE_BIO_TEAM)

		g.core.module.ModuleManager:tip(var_6_1)
	end
end

function BioTeamChooseCampaignLayer:_onNightmareClick()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.NIGHTMARE_BIO_TEAM) then
		self.m_isHardController:setSelectedIndex(3)

		self._isChangeTab = true
	else
		self.m_lockCtrlController:setSelectedIndex(0)

		local var_7_0, var_7_1 = g.core.common.ModuleUnlock:getModuleUnlockLevelAndComment(g.core.const.ConstMgr.FUNCTION_TYPE.NIGHTMARE_BIO_TEAM)

		g.core.module.ModuleManager:tip(var_7_1)
	end
end

function BioTeamChooseCampaignLayer:_onChangeTitleStyle()
	self._showTab = self.m_isHardController:getSelectedIndex() + 1

	self:_updateView()
end

function BioTeamChooseCampaignLayer:_onForceGuideEnd()
	self:_checkSpeWeakGuide()
end

function BioTeamChooseCampaignLayer:_checkSpeWeakGuide()
	local var_10_0, var_10_1, var_10_2 = g.core.model.User.bioData:getBioTeamMaxLevelOpenLand()

	if var_10_2 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "BIO_TEAM_WEAK_FINGER",
			targetBtn = self.m_pageList:getChildAt(0)
		})
	end
end

function BioTeamChooseCampaignLayer:_updateView()
	self:_updateLeftCount()
	self.m_topBar:setResInfoById(32)
	self:_updateCampaignList()
end

function BioTeamChooseCampaignLayer:_updateLeftCount()
	self.m_leftCountComp:updateLeftCount()
end

function BioTeamChooseCampaignLayer:_updateCampaignList()
	self._openLands = var_0_0:getOpenLands(false, self._showTab)

	local var_13_0, var_13_1 = var_0_0:getBioTeamMaxLevelOpenLand(self._showTab)

	self._maxOpenLandIndex = var_13_1

	self.m_pageList:setNumItems(#self._openLands)

	if self._isFirstEnter then
		self._isFirstEnter = false

		self.m_lockCtrlController:setSelectedIndex(self._showTab - 1)
		self.m_isHardController:setSelectedIndex(self._showTab - 1)
		self.m_pageList:scrollToView(self._maxOpenLandIndex - 1)
	elseif self._isChangeTab then
		self._isChangeTab = false

		self.m_pageList:scrollToView(self._maxOpenLandIndex - 1)
	end

	self.m_pageList:transitionShowCells("enter_left", 0.03, 1)
end

function BioTeamChooseCampaignLayer:_onListRenderer(arg_14_1, arg_14_2)
	arg_14_2:updateCell(self._openLands[arg_14_1 + 1], arg_14_1, self._showTab - 1)
end

function BioTeamChooseCampaignLayer:_onAchieveClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.biography.view.team.BioTeamAwardPop").new()))
end

function BioTeamChooseCampaignLayer:_onGetCampaignAward(arg_16_1, arg_16_2, arg_16_3)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
end

function BioTeamChooseCampaignLayer:_onCrossDay()
	self:_updateLeftCount()
	self.m_topBar:updateResource()
end

function BioTeamChooseCampaignLayer:onUnload()
	var_0_0:resetAllListNewState()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

return BioTeamChooseCampaignLayer
