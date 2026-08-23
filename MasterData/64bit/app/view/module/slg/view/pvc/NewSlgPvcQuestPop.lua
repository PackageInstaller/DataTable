local var_0_0 = g.core.model.User.newSlgData
local NewSlgPvcQuestPop = class("NewSlgPvcQuestPop", require("app.fairyGUI.newSlg.UI_NewSlgPvcQuestPop"), function()
	return fgui.GComponent:create({
		resName = "NewSlgPvcQuestPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgPvcQuestPop:ctor()
	self:showAtCenter()
	self.m_tabList:setVirtual()
	self.m_tabList:setItemRenderer(handler(self, self._onRenderListTabCell))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onItemClickTab))
	self.m_taskList:setVirtual()
	self.m_taskList:doFairyBatching(false)
	self.m_taskList:setItemRenderer(handler(self, self._onRenderListTaskCell))
	self:addListen(self.m_taskList)

	self._tabArr = var_0_0:getCityQuestTabArr()

	local var_2_0, var_2_1 = var_0_0:canAchieveCityQuest()

	self._tabIndex = var_2_0 and var_2_1 - 1 or 0

	self.m_tabList:setNumItems(#self._tabArr)

	self._taskArr = {}
end

function NewSlgPvcQuestPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_SYNCCITYQUESTPROGRESS, handler(self, self._onRcvNewSlgSyncCityQuestProgress), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_CITYQUESTAWARD, handler(self, self._onRcvNewSlgCityQuestAward), self)
	self:_updateView()
end

function NewSlgPvcQuestPop:receiveCompEvent(arg_4_1, arg_4_2)
	if arg_4_1 == "NewSlgPvcQuestCell_onClickBtnGet" then
		g.core.network.GameNetProxy:send_C2S_NewSlg_CityQuestAward({
			ids = {
				arg_4_2.id
			}
		})
	elseif arg_4_1 == "NewSlgPvcQuestCell_onClickBtnRoute" then
		local var_4_0 = var_0_0:getAllianceData().bornPID or 0

		if var_4_0 == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(428892))

			return
		end

		local var_4_1 = var_0_0:getCityComponentById(var_0_0:getCityIdsByPID(var_4_0)[arg_4_2.cityIdIndex])

		self:dispatchCompEvent("NewSlg_jumpToPos", {
			pos = cc.p(var_4_1.anchor_x, var_4_1.anchor_y)
		})
		g.core.module.ModuleManager:popAllPopup()
	end
end

function NewSlgPvcQuestPop:_onItemClickTab(arg_5_1)
	local var_5_0 = arg_5_1 and arg_5_1:getDataValue() or 0

	if self._tabIndex == var_5_0 then
		return
	end

	self._tabIndex = var_5_0

	self:_updateView()
end

function NewSlgPvcQuestPop:_updateView()
	self:_calTaskInfo(self._tabIndex + 1)
	self.m_taskList:setNumItems(#self._taskArr)
end

function NewSlgPvcQuestPop:_calTaskInfo(arg_7_1)
	self._taskArr = var_0_0:dealCityQuestArrByLevel(arg_7_1, true)
end

function NewSlgPvcQuestPop:_onRenderListTabCell(arg_8_1, arg_8_2)
	local var_8_0 = self._tabArr[arg_8_1 + 1].level

	arg_8_2:setTitle(g.core.lang:get(429010, {
		num = self._tabArr[arg_8_1 + 1].level,
		name = self._tabArr[arg_8_1 + 1].name
	}))
	arg_8_2:setSelected(arg_8_1 == self._tabIndex)
	arg_8_2:setCtrlState("passed", {
		index = var_0_0:isAllCityQuestAwardedByLevel(var_8_0) and 1 or 0
	})
end

function NewSlgPvcQuestPop:_onRenderListTaskCell(arg_9_1, arg_9_2)
	arg_9_2:updateCell(self._taskArr[arg_9_1 + 1])
end

function NewSlgPvcQuestPop:_onRcvNewSlgSyncCityQuestProgress()
	self:_updateView()
end

function NewSlgPvcQuestPop:_onRcvNewSlgCityQuestAward(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if arg_11_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_11_4.awards)
	end

	self:_updateView()
end

return NewSlgPvcQuestPop
