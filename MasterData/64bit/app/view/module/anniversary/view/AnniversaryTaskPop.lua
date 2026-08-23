local var_0_0 = g.core.const.ConstMgr.AnniversaryConst
local var_0_1 = g.core.model.User.anniversaryData
local AnniversaryTaskPop = class("AnniversaryTaskPop", require("app.fairyGUI.anniversary.UI_AnniversaryTaskPop"), function()
	return fgui.GComponent:create({
		resName = "AnniversaryTaskPop",
		pkgName = "anniversary"
	}, ...)
end)

function AnniversaryTaskPop:ctor(arg_2_1)
	self:showAtCenter()

	self._selectedTab = 0
	self._taskList = {}

	self:_initBtn()
	self:_initListView()
	self:_updateView(true)
end

function AnniversaryTaskPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_GETTASKAWARD, self._onAnniversaryGetTaskAward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_TASKNOTIFY, self._updateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EXIT, self._onModuleExit, self)
	self:_updateTabRedpoint()
end

function AnniversaryTaskPop:_initBtn()
	self.m_oneKeyBtn:addClickListener(handler(self, self._onOneKeyBtnClick))
	self.m_selTabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabSelChanged))
end

function AnniversaryTaskPop:_initListView()
	self.m_taskList:setVirtual()
	self.m_taskList:doFairyBatching(false)
	self.m_taskList:setItemRenderer(handler(self, self._onRenderTaskList))
	self:addListen(self.m_taskList)
	self.m_bg:setURL(var_0_1:getActivityResource("ui_cocos", "pic_xmhy_majiangfx_di1.png"))
end

function AnniversaryTaskPop:_onRenderTaskList(arg_6_1, arg_6_2)
	arg_6_2:updateCell(self._taskList[arg_6_1 + 1])
end

function AnniversaryTaskPop:_updateTabRedpoint()
	for iter_7_0, iter_7_1 in ipairs((self.m_tabList:getChildren())) do
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = iter_7_1:getChild("redPointComp"),
			customData = {
				index = self.m_tabList:itemIndexToChildIndex(iter_7_0)
			}
		})
	end
end

function AnniversaryTaskPop:_updateView(arg_8_1)
	self._taskList = var_0_1:getTaskData():getTaskList((self._selectedTab == 0 or nil) and (var_0_0.TASK_TYPE.DAILY or var_0_0.TASK_TYPE.SEASON))

	self.m_taskList:setNumItems(#self._taskList)

	if arg_8_1 then
		self.m_taskList:transitionShowCells("enter_down", 0.03)
	end
end

function AnniversaryTaskPop:_onTabSelChanged()
	self._selectedTab = self.m_selTabController:getSelectedIndex()

	self:_updateView()
end

function AnniversaryTaskPop:receiveCompEvent(arg_10_1, arg_10_2)
	if arg_10_1 == "EVENT_ANNIVERSARY_AWARD_GET" then
		if not var_0_1:isInActivityGameTime() then
			g.core.module.ModuleManager:tip(g.core.lang:get(308618))

			return
		end

		g.core.network.GameNetProxy:send_C2S_Anniversary_GetTaskAward({
			id = {
				arg_10_2
			}
		})
	end
end

function AnniversaryTaskPop:_onAnniversaryGetTaskAward(arg_11_1, arg_11_2, arg_11_3)
	g.core.module.ModuleManager:awardSummary(arg_11_3.awards)
	self:_updateView()
end

function AnniversaryTaskPop:_onModuleExit()
	self:_updateView()
end

function AnniversaryTaskPop:_onOneKeyBtnClick()
	if not var_0_1:isInActivityGameTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(308618))

		return
	end

	local var_13_0 = var_0_1:getTaskData():getCanRewardTaskList((self._selectedTab == 0 or nil) and (var_0_0.TASK_TYPE.DAILY or var_0_0.TASK_TYPE.SEASON))

	if #var_13_0 == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(431408))
	else
		g.core.network.GameNetProxy:send_C2S_Anniversary_GetTaskAward({
			id = var_13_0
		})
	end
end

return AnniversaryTaskPop
