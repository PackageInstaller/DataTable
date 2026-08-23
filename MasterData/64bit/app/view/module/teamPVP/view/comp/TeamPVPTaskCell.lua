local var_0_0 = g.core.model.User.teamPvpData
local var_0_1 = g.core.config.group_battle_task_info
local TeamPVPTaskCell = class("TeamPVPTaskCell", require("app.fairyGUI.teamPVP.UI_TeamPVPTaskCell"))

function TeamPVPTaskCell:ctor()
	self._taskInfo = nil
	self._awardList = {}

	self:_initView()
	self.getSharedTrans(self, "enter_down", "CommonLongCellList", self)
end

function TeamPVPTaskCell:_initView()
	self.m_taskNumText:enableRich()
	self.m_getAwardBtn:addClickListener(handler(self, self._onGetAwardClick))
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
end

function TeamPVPTaskCell:_onRenderAwardList(arg_3_1, arg_3_2)
	self._awardList[arg_3_1 + 1].scaleIndex = 2
	self._awardList[arg_3_1 + 1].hideNum = false

	arg_3_2:updateIcon(self._awardList[arg_3_1 + 1])
end

function TeamPVPTaskCell:updateTaskCell(arg_4_1)
	if not arg_4_1 then
		return
	end

	self._taskInfo = arg_4_1

	local var_4_0 = arg_4_1.goal

	self.m_taskNameText:setText(g.core.lang:getByString(arg_4_1.task_describe, {
		num = arg_4_1.goal
	}))

	local var_4_1 = math.min(var_0_0:getTaskProgress(arg_4_1.task_type, arg_4_1.refresh), var_4_0)

	self.m_taskNumText:setText(g.core.lang:get(302515, {
		curNum = var_4_1,
		targetNum = var_4_0
	}))

	self._awardList = {}

	while var_0_1.hasKey("reward_type_" .. 1) do
		if arg_4_1["reward_type_" .. 1] > 0 then
			table.insert(self._awardList, {
				type = arg_4_1["reward_type_" .. 1],
				value = arg_4_1["reward_value_" .. 1],
				size = arg_4_1["reward_size_" .. 1]
			})
		end
	end

	self.m_awardList:setNumItems(#self._awardList)
	self.m_awardList:setScrollEnabled(#self._awardList > 2)

	local var_4_3 = 0

	if var_0_0:isGotTaskById(arg_4_1.id) then
		var_4_3 = 2
	elseif var_4_0 <= var_4_1 then
		var_4_3 = 1
	end

	self.m_isGetController:setSelectedIndex(var_4_3)

	if arg_4_1.refresh == g.core.const.ConstMgr.ShopConst.NUM_BAN_TYPE.DAY then
		self.m_isDailyController:setSelectedIndex(1)
	else
		self.m_isDailyController:setSelectedIndex(0)
	end
end

function TeamPVPTaskCell:_onGetAwardClick()
	if not self._taskInfo then
		return
	end

	self:dispatchCompEvent("EVENT_TEAM_PVP_AWARD_GET", self._taskInfo.id)
end

return TeamPVPTaskCell
