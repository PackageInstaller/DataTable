local var_0_0 = g.core.event.EventManager
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.model.User.newSlgData
local NewSlgAchievementPop = class("NewSlgAchievementPop", require("app.fairyGUI.newSlg.UI_NewSlgAchievementPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/newSlg/newSlg",
		resName = "NewSlgAchievementPop",
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgAchievementPop:ctor()
	self._taskArr = {}
	self._tabIndex = 0

	self:showAtCenter()
	self:initView()
	self.m_closeBtn:setClickCallBack(handler(self, self._onClickClose))
	self.m_closeGraph:addClickListener(handler(self, self._onClickClose))
	self.m_enterTransition:play()
end

function NewSlgAchievementPop:_onClickClose()
	if self._inClose then
		return
	end

	self._inClose = true

	self.m_backTransition:play(handler(self, self.onCloseAnimFinish))
end

function NewSlgAchievementPop:onCloseAnimFinish()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function NewSlgAchievementPop:initView()
	self.m_achieveList:setVirtual()
	self.m_achieveList:doFairyBatching(false)
	self.m_achieveList:setItemRenderer(handler(self, self._onRenderListAchievementCell))
	self:addListen(self.m_achieveList)
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onCtrlTabChange))
end

function NewSlgAchievementPop:_onCtrlTabChange()
	local var_6_0 = self.m_tabController:getSelectedIndex()

	if var_6_0 == self._tabIndex then
		return
	end

	self._tabIndex = var_6_0

	self:_updateView()
end

function NewSlgAchievementPop:_onRenderListAchievementCell(arg_7_1, arg_7_2)
	arg_7_2:updateCell(self._taskArr[arg_7_1 + 1])
end

function NewSlgAchievementPop:onLoad()
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_NEW_SLG_USERACHIEVEMENTNTF, handler(self, self._updateView), self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_NEW_SLG_ONEKEYOBTAINREWARDS, handler(self, self._onObtainAwards), self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_NEW_SLG_OBTAINQUESTREWARD, handler(self, self._onObtainAwards), self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_NEW_SLG_SYNCCITYQUESTPROGRESS, handler(self, self._updateView), self)
	self:_updateView()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_tab0,
		customData = {
			tp = 1
		}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_tab1,
		customData = {
			tp = 2
		}
	})
end

function NewSlgAchievementPop:_updateView()
	self._taskArr = var_0_2:getAchievementDataArrByType(self._tabIndex + 1)

	self.m_achieveList:setNumItems(#self._taskArr)
end

function NewSlgAchievementPop:_onObtainAwards(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if arg_10_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_10_4.awards, true)
	end

	self:_updateView()
end

function NewSlgAchievementPop:receiveCompEvent(arg_11_1, arg_11_2)
	if arg_11_1 == "NewSlgS2AchieveCell_onClickBtnGet" then
		g.core.network.GameNetProxy:send_C2S_NewSlg_ObtainQuestReward({
			id = arg_11_2.id
		})
	elseif arg_11_1 == "NewSlgS2AchieveCell_onClickBtnRoute" then
		if arg_11_2.routeId > 0 then
			g.view.entrance.ModuleGotoProxy:gotoModule(arg_11_2.routeId)
			self:onCloseAnimFinish()
		end
	end
end

return NewSlgAchievementPop
