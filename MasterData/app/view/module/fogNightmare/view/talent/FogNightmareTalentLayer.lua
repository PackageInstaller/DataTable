local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.module.ModuleManager
local FogNightmareTalentLayer = class("FogNightmareTalentLayer", require("app.fairyGUI.fogNightmare.UI_FogNightmareTalentLayer"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareTalentLayer",
		pkgPath = "ui/fogNightmare/fogNightmare",
		isFullScreen = true,
		pkgName = "fogNightmare"
	}, ...)
end)
local var_0_3 = g.core.model.User.fogNightmareData
local var_0_4 = g.core.model.User.shopData
local GuideConst = require("app.view.module.guide.const.GuideConst")

function FogNightmareTalentLayer:ctor()
	self.m_topBarComp:setResInfoById(165)

	self._tabSelectIdx = 1
	self._schedule = nil

	self.m_talentTab:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabChange))
	self.m_pointList:setVirtual(self)
	self.m_pointList:setItemRenderer(handler(self, self._onPointListItemRender))
	self.m_pointList:doFairyBatching(false)
	self.m_talentTab:setVirtual(self)
	self.m_talentTab:setItemRenderer(handler(self, self._onTabListItemRender))
	self:addBg("bg/fogNightmare/bg_wjmy_tf.jpg")
	self.m_bgLoader:addEventListener(fgui.UIEventType.Click, handler(self, self._onHideTip))
	self.m_resetBtn:addEventListener(fgui.UIEventType.Click, handler(self, self._onReset))
	self.m_btnAddition:addEventListener(fgui.UIEventType.Click, handler(self, self._onShowAdditionPop))
	self:_initView()
	g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.FOG_TALENT_ENTER)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
		tickType = 6,
		enum = GuideConst.ENUM_TICK.FOG_FIRST_ENTER_TALENT
	})
end

function FogNightmareTalentLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_TALENT_UPGRADENODE, handler(self, self.refreshView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_TALENT_RESET, handler(self, self.resetTalent), self)
	self.m_enterTransition:play(handler(self, self.onEnterAnimEnterFinish))
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.FOG_NIGHTMARE_LARGE)

	if self._schedule == nil then
		self._schedule = self:newSchedule(handler(self, self._updateTimeBySchedule), 1)
	end
end

function FogNightmareTalentLayer:onEnterAnimEnterFinish()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
end

function FogNightmareTalentLayer:_updateTimeBySchedule()
	if var_0_0:getTime() > var_0_3:getEndTime() then
		var_0_1:popAllPopup()
		var_0_1:popModule()
	end
end

function FogNightmareTalentLayer:_onTabChange()
	local var_6_0 = self.m_talentTab:getSelectedIndex() + 1

	if var_6_0 == self._tabSelectIdx then
		return
	end

	self:_onHideTip()

	self._tabSelectIdx = var_6_0

	self:_updateListView(self._tabSelectIdx)
end

function FogNightmareTalentLayer:_initView()
	local var_7_0 = cc.Director:getInstance():getSafeAreaRect()

	if var_7_0.x > 0 then
		self.m_pointList:setWidth(self.m_pointList:getWidth() - var_7_0.x)
	end

	self:_updateTabListView()
	self.m_talentTab:setSelectedIndex(0)
	self:_updateListView(self._tabSelectIdx)
	self.m_btnAddition:updateView((var_0_3:getTalentData():getAdditionLv()))
end

function FogNightmareTalentLayer:refreshView()
	self:_updateListView(self._tabSelectIdx)
	self.m_btnAddition:updateView((var_0_3:getTalentData():getAdditionLv()))

	if var_0_3:getTalentData():getAdditionLvChange() then
		self.m_btnAddition:showEffect()
		var_0_3:getTalentData():setAdditionLvChange(false)
	end
end

function FogNightmareTalentLayer:resetTalent(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	g.core.module.ModuleManager:awardSummary(arg_9_4.awards or {}, nil, nil, g.core.lang:get(103004))
	arg_9_1:refreshView()
end

function FogNightmareTalentLayer:_updateTabListView()
	self._tabData = var_0_3:getTalentData():getTalentTabData()

	self.m_talentTab:setNumItems(#self._tabData)
end

function FogNightmareTalentLayer:_updateListView(arg_11_1)
	self._curTabTalentData = var_0_3:getTalentData():getTalentDataByTab(arg_11_1)

	self.m_pointList:setNumItems(#self._curTabTalentData)
end

function FogNightmareTalentLayer:_onPointListItemRender(arg_12_1, arg_12_2)
	arg_12_2:updateCell(self._curTabTalentData[arg_12_1 + 1])
end

function FogNightmareTalentLayer:_onTabListItemRender(arg_13_1, arg_13_2)
	arg_13_2:updateTabView(self._tabData[arg_13_1 + 1])
end

function FogNightmareTalentLayer:receiveCompEvent(arg_14_1, arg_14_2)
	if arg_14_1 == "ENTER_FOG_SELECT_TALENT" then
		self.m_infoTipComp:updateView(arg_14_2.data)
		self.m_showTipController:setSelectedIndex(1)

		for iter_14_0, iter_14_1 in ipairs((self.m_pointList:getChildren())) do
			iter_14_1:resetState()
		end
	elseif arg_14_1 == "ENTER_FOG_HIDE_TIP" then
		self:_onHideTip()
	end
end

function FogNightmareTalentLayer:_onHideTip()
	self.m_showTipController:setSelectedIndex(0)

	for iter_15_0, iter_15_1 in ipairs((self.m_pointList:getChildren())) do
		iter_15_1:resetState()
	end
end

function FogNightmareTalentLayer:_onReset()
	if var_0_3:getFormationData():hasPoolMember() then
		g.core.module.ModuleManager:tip((g.core.lang:get(500198)))
	elseif var_0_3:getTalentData():getTalentTabCostNumByTab(self._tabSelectIdx) then
		if var_0_4:getBuyLimitLeft((g.core.config.play_num_info.get(75))) > 0 then
			if var_0_4:getLeftCount(75) > 0 and var_0_3:getTalentData():getIsSelectResetPopFree() or var_0_3:getTalentData():getIsSelectResetPop() then
				g.core.network.GameNetProxy:send_C2S_Fog_Talent_Reset({
					tab = self._tabSelectIdx
				})
			else
				g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.talent.FogNightmareTalentResetPop").new({
					tab = self._tabSelectIdx
				}), {
					touchDisappear = true,
					ignoreTouch = false
				})
			end
		else
			g.core.module.ModuleManager:tip((g.core.lang:get(500219)))
		end
	else
		g.core.module.ModuleManager:tip((g.core.lang:get(500150)))
	end
end

function FogNightmareTalentLayer:_onShowAdditionPop()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.talent.FogNightmareTalentAdditionPop").new({
		type = self._tabSelectIdx,
		lv = var_0_3:getTalentData():getAdditionLv()
	}), {
		touchDisappear = true,
		ignoreTouch = false
	})
end

function FogNightmareTalentLayer:onUnload()
	self._schedule = nil
end

return FogNightmareTalentLayer
