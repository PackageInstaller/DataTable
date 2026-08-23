local ValentinesDayVoteTaskLayer = class("ValentinesDayVoteTaskLayer", require("app.fairyGUI.valentinesDayVote.UI_ValentinesDayVoteTaskLayer"), function()
	return fgui.GComponent:create({
		resName = "ValentinesDayVoteTaskLayer",
		pkgPath = "ui/valentinesDayVote/valentinesDayVote",
		isFullScreen = true,
		pkgName = "valentinesDayVote"
	}, ...)
end)
local var_0_1 = g.core.model.User.valentinesDayVoteData

function ValentinesDayVoteTaskLayer:ctor()
	self._tabSelectIdx = 1

	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabChange))
	self.m_tabList:setVirtual(self)
	self.m_tabList:setItemRenderer(handler(self, self._onTabListItemRender))
	self.m_tabList:setNumItems(2)
	self.m_taskList:setVirtual(self)
	self.m_taskList:setItemRenderer(handler(self, self._onTaskListItemRender))
	self.m_rewardAllBtn:addClickListener(handler(self, self._onRewardAllClick))
	self.m_enterTransition:play()
	self.m_topBar:setResInfoById(177)
	self:_initView()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_OPEN_VOTE_TASK_POP)
end

function ValentinesDayVoteTaskLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SUPPORT_TASKAWARD, handler(self, self._showReward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SUPPORT_TASKALLAWARD, handler(self, self._showReward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SUPPORT_GETINFO, handler(self, self._updateView), self)

	if var_0_1:isProcess() then
		g.core.network.GameNetProxy:send_C2S_Support_GetInfo({})
	end

	self:_updateView()
end

function ValentinesDayVoteTaskLayer:_initView()
	self:addBg("bg/activity/bg_vote01_qrj_main.jpg")
	self.m_tabList:setSelectedIndex(0)
	self:_updateListView(self._tabSelectIdx)
	self:_refreshTaskCooldown()
end

function ValentinesDayVoteTaskLayer:_onTabListItemRender(arg_5_1, arg_5_2)
	arg_5_2:getController("type"):setSelectedIndex(arg_5_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = arg_5_2,
		customData = {
			type = self._tabSelectIdx
		}
	})
end

function ValentinesDayVoteTaskLayer:_onTaskListItemRender(arg_6_1, arg_6_2)
	arg_6_2:updateView(self._curTaskData[arg_6_1 + 1])
end

function ValentinesDayVoteTaskLayer:_onTabChange()
	local var_7_0 = self.m_tabList:getSelectedIndex() + 1

	if var_7_0 == self._tabSelectIdx then
		return
	end

	local var_7_1 = self.m_tabList:getChildAt(self._tabSelectIdx - 1)

	self._tabSelectIdx = var_7_0

	self:_updateListView(self._tabSelectIdx)
end

function ValentinesDayVoteTaskLayer:_updateListView(arg_8_1)
	if arg_8_1 == 1 then
		self.m_showCountDownController:setSelectedIndex(1)
		self:_refreshTaskCooldown()
	else
		self.m_showCountDownController:setSelectedIndex(0)
	end

	self._curTaskData = var_0_1:getTaskDataByTab(arg_8_1)

	table.sort(self._curTaskData, function(arg_9_0, arg_9_1)
		local var_9_0 = 1
		local var_9_1 = 1

		if arg_9_0:isGetReward() then
			var_9_0 = 2
		elseif arg_9_0:getCurProgress() >= arg_9_0:getCfg().task_value then
			var_9_0 = 0
		end

		if arg_9_1:isGetReward() then
			var_9_1 = 2
		elseif arg_9_1:getCurProgress() >= arg_9_1:getCfg().task_value then
			var_9_1 = 0
		end

		if var_9_0 == var_9_1 then
			return arg_9_0:getCfg().id < arg_9_1:getCfg().id
		else
			return var_9_0 < var_9_1
		end
	end)
	self.m_taskList:setNumItems(#self._curTaskData)
	self.m_taskList:transitionShowCells("enter_left", 0.03)

	for iter_8_0, iter_8_1 in ipairs(self.m_tabList:getChildren()) do
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = iter_8_1,
			customData = {
				type = iter_8_0
			}
		})
	end
end

function ValentinesDayVoteTaskLayer:_updateView()
	self:_updateListView(self._tabSelectIdx)
	self:_refreshTaskCooldown()
end

function ValentinesDayVoteTaskLayer:_showReward(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	g.core.module.ModuleManager:awardSummary(arg_11_4.awards or {}, nil, nil, g.core.lang:get(300001))
	arg_11_1:_updateView()
end

function ValentinesDayVoteTaskLayer:_onRewardAllClick()
	if var_0_1:hasTaskAwardCanGet({}) then
		g.core.network.GameNetProxy:send_C2S_Support_TaskAllAward({})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(308025))
	end
end

function ValentinesDayVoteTaskLayer:_refreshTaskCooldown()
	self.m_cooldown:resetCooldownTs((g.core.common.ServerTime:getOpenLeftTime(24, 0, 0)))
end

return ValentinesDayVoteTaskLayer
