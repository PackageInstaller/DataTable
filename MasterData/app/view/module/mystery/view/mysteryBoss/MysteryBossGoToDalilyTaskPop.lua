local var_0_0 = g.core.model.User.mysteryBossData
local var_0_1 = g.core.model.User.mysteryData
local var_0_2 = g.core.const.ConstMgr.MysteryConst
local MysteryBossGoToDalilyTaskPop = class("MysteryBossGoToDalilyTaskPop", require("app.fairyGUI.mystery.UI_MysteryBossGoToDalilyTaskPop"), function()
	return fgui.GComponent:create({
		resName = "MysteryBossGoToDalilyTaskPop",
		pkgPath = "ui/mystery/mystery",
		pkgName = "mystery"
	}, ...)
end)

function MysteryBossGoToDalilyTaskPop:ctor(arg_2_1)
	self:showAtCenter()

	self._tasks = arg_2_1

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
	self.m_goToBtn:addClickListener(handler(self, self._onClickGoToBtn))
	self.m_getAwardBtn:addClickListener(handler(self, self._onClickGetAwardBtn))
	self:_updateMainView()
	self.m_enterTransition:play()
end

function MysteryBossGoToDalilyTaskPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_AWARD, self._onS2CMysteryAward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDay), self)
end

function MysteryBossGoToDalilyTaskPop:_onS2CMysteryAward(arg_4_1, arg_4_2, arg_4_3)
	g.core.module.ModuleManager:awardSummary(arg_4_3.awards)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function MysteryBossGoToDalilyTaskPop:_onCrossDay()
	self:_updateMainView()
end

function MysteryBossGoToDalilyTaskPop:_updateMainView()
	if not self._tasks or #self._tasks == 0 then
		return
	end

	self._taskInfo = self._tasks[1]

	self.m_title:setText(self._taskInfo.task_title)

	local var_6_0 = var_0_1:getTaskProgById(self._taskInfo.id)

	self.m_taskDescTxt:setText(self._taskInfo.task_desc .. g.core.lang:get(423002, {
		cur = (var_6_0 or nil) and (var_6_0.progress or 0),
		max = self._taskInfo.task_size
	}))

	self._awards = self:_getTaskAwards()

	self.m_awardList:setNumItems(#self._awards)

	self._recommendBoss = var_0_0:getRecommendBoss()

	if self._recommendBoss then
		self._bossId = self._recommendBoss:getBossId()

		self.m_bossIconComp:updateBossIcon(self._bossId)
		self.m_bossNameTxt:setText(self._recommendBoss:getBossName())
	end

	self._taskState = var_0_1:getTaskStateById(self._taskInfo.id)

	if self._taskState == var_0_2.TASK_STATE.UNDONE then
		self.m_taskStateController:setSelectedIndex(0)
	elseif self._taskState == var_0_2.TASK_STATE.CAN_AWARD then
		self.m_taskStateController:setSelectedIndex(1)
	else
		self.m_taskStateController:setSelectedIndex(2)
	end
end

function MysteryBossGoToDalilyTaskPop:_onAwardItemRender(arg_7_1, arg_7_2)
	arg_7_2:updateIcon(self._awards[arg_7_1 + 1])
end

function MysteryBossGoToDalilyTaskPop:_onClickGoToBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.MYSTERY_BOSS_CHOOSE, {
		bossData = self._recommendBoss
	})
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function MysteryBossGoToDalilyTaskPop:_onClickGetAwardBtn()
	if self._taskState == var_0_2.TASK_STATE.CAN_AWARD then
		g.core.network.GameNetProxy:send_C2S_Mystery_Award({
			task_id = self._taskInfo.id
		})
	end
end

function MysteryBossGoToDalilyTaskPop:_getTaskAwards()
	local var_10_0 = {}

	for iter_10_0 = 1, 4 do
		if self._taskInfo["reward_type_" .. iter_10_0] > 0 then
			table.insert(var_10_0, {
				type = self._taskInfo["reward_type_" .. iter_10_0],
				value = self._taskInfo["reward_value_" .. iter_10_0],
				size = self._taskInfo["reward_size_" .. iter_10_0]
			})
		end
	end

	return var_10_0
end

return MysteryBossGoToDalilyTaskPop
