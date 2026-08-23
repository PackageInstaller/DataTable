local var_0_0 = g.core.model.User.activityLevelUpData
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.model.User
local ActivityLevelUpComp = class("ActivityLevelUpComp", require("app.fairyGUI.activity.UI_ActivityLevelUpComp"))

function ActivityLevelUpComp:ctor()
	self._curLevel = var_0_3:getLevel()
	self._levelAwardData = {}

	self.m_levelAwardList:setVirtual()
	self.m_levelAwardList:doFairyBatching(false)
	self.m_levelAwardList:setItemRenderer(handler(self, self._onItemRenderer))
end

function ActivityLevelUpComp:onLoad()
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_LEVEL_UP_INFO, handler(self, self._onRecvLevelUpInfo), self)
	var_0_1:addEventListener(var_0_2.EVENT_USER_LEVELUP, handler(self, self._onRcvLevelUp), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_LEVEL_UP_AWARD, handler(self, self._onRcvLevelUpAward), self)

	if not var_0_0:isReceiveLevelUpInfo() then
		g.core.network.GameNetProxy:send_C2S_LevelUp_Info({})
	end
end

function ActivityLevelUpComp:updateComp(arg_3_1)
	if arg_3_1 and arg_3_1 ~= self._activityValue then
		self._activityValue = arg_3_1
	end

	self._levelAwardData = var_0_0:getValidLevelUpTaskList()

	self.m_levelText:setText(self._curLevel)
	self:_updateLevelAwardList()

	if self.m_enterTransition then
		self.m_enterTransition:play()
	end

	self:_updateLeftSpine()
end

function ActivityLevelUpComp:_updateLeftSpine()
	self.m_spineDialogComp:updateComp()
end

function ActivityLevelUpComp:_updateLevelAwardList()
	self.m_levelAwardList:setNumItems(#self._levelAwardData)
	self.m_levelAwardList:transitionShowCells("enter_left", 0.03, 1)
end

function ActivityLevelUpComp:_onItemRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateItem(self._levelAwardData[arg_6_1 + 1])
end

function ActivityLevelUpComp:_onRecvLevelUpInfo()
	self:updateComp()
end

function ActivityLevelUpComp:_onRcvLevelUpAward(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = {}
	local var_8_1 = g.core.config.level_up_info.get(arg_8_4.id)

	for iter_8_0 = 1, 4 do
		if var_8_1["reward_type_" .. iter_8_0] > 0 then
			table.insert(var_8_0, {
				nameRow = 2,
				changeControllers = true,
				type = var_8_1["reward_type_" .. iter_8_0],
				value = var_8_1["reward_value_" .. iter_8_0],
				size = var_8_1["reward_size_" .. iter_8_0]
			})
		end
	end

	require("app.view.module.show.ShowFactory"):awardSummary(var_8_0, nil, nil, nil, (not var_0_0:isExistUnfinishedTask() or nil) and function()
		g.core.module.ModuleManager:tip(g.core.lang:get(402003))
	end)
	self:updateComp()
end

function ActivityLevelUpComp:_onRcvLevelUp()
	self._curLevel = var_0_3:getLevel()

	self:updateComp()
end

return ActivityLevelUpComp
