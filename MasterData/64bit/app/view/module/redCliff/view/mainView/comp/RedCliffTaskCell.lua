local var_0_0 = g.core.const.ConstMgr.RedCliffConst
local var_0_1 = g.core.model.User.redCliffData
local var_0_2 = g.core.config.chibi_achievement_info
local var_0_3 = g.core.config.chibi_pool_info
local RedCliffTaskCell = class("RedCliffTaskCell", require("app.fairyGUI.redCliff.UI_RedCliffTaskCell"))

function RedCliffTaskCell:ctor()
	self._taskInfo = nil
	self._awardList = {}

	self:_initView()
	self.getSharedTrans(self, "enter_down", "CommonLongCellList", self)
end

function RedCliffTaskCell:_initView()
	self.m_taskNumText:enableRich()
	self.m_getAwardBtn:addClickListener(handler(self, self._onGetAwardClick))
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
end

function RedCliffTaskCell:_onRenderAwardList(arg_3_1, arg_3_2)
	self._awardList[arg_3_1 + 1].scaleIndex = 2
	self._awardList[arg_3_1 + 1].hideNum = false

	arg_3_2:updateIcon(self._awardList[arg_3_1 + 1])
end

function RedCliffTaskCell:updateTaskCell(arg_4_1)
	if not arg_4_1 then
		return
	end

	self._taskInfo = arg_4_1

	local var_4_0 = arg_4_1.value

	self.m_taskNameText:setText(arg_4_1.description)

	local var_4_1 = var_0_1:getTaskProgress(arg_4_1.type)

	if arg_4_1.type == var_0_0.TASK_SHOW_SPECIAL_DESC_TYPE then
		if var_4_1 > 0 then
			self.m_taskNumText:setText(g.core.lang:get(1020, {
				desc = var_0_3.get(var_4_1).pool_name
			}))
		else
			self.m_taskNumText:setText(g.core.lang:get(1020, {
				desc = g.core.lang:get(421116)
			}))
		end
	else
		var_4_1 = math.min(var_4_1, var_4_0)

		self.m_taskNumText:setText(g.core.lang:get(302515, {
			curNum = var_4_1,
			targetNum = var_4_0
		}))
	end

	self._awardList = {}

	while var_0_2.hasKey("reward_type_" .. 1) do
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

	if var_0_1:isGotTaskById(arg_4_1.id) then
		var_4_3 = 2
	elseif var_4_0 <= var_4_1 then
		var_4_3 = 1
	end

	self.m_isGetController:setSelectedIndex(var_4_3)

	if arg_4_1.reset_type == var_0_0.TASK_REFRESH_TYPE.DAY then
		self.m_isDailyController:setSelectedIndex(1)
	else
		self.m_isDailyController:setSelectedIndex(0)
	end
end

function RedCliffTaskCell:_onGetAwardClick()
	if not self._taskInfo then
		return
	end

	self:dispatchCompEvent("EVENT_RED_CLIFF_TASK_AWARD_GET", self._taskInfo.id)
end

return RedCliffTaskCell
