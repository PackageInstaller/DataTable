local var_0_0 = g.core.config.succuba_launch_task_info
local var_0_1 = g.core.model.User.succubaLaunchData
local SuccubaLaunchTaskCell = class("SuccubaLaunchTaskCell", require("app.fairyGUI.succubaLaunch.UI_SuccubaLaunchTaskCell"))

function SuccubaLaunchTaskCell:ctor()
	self._taskParam = {}
	self._awards = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRewardItemRenderer))
	self.m_awardList:doFairyBatching(false)
	self.m_btn:addClickListener(handler(self, self._onRewardBtnClick))
end

function SuccubaLaunchTaskCell:updateSuccubaTask(arg_2_1)
	self._taskParam = arg_2_1

	local var_2_0 = arg_2_1.cfg

	self._awards = {}

	self.m_typeController:setSelectedIndex(var_2_0.refresh == 1 and 1 or 0)
	self.m_name:setText(var_2_0.task_name)
	self.m_descText:setText(g.core.lang:getByString(var_2_0.task_describe, {
		num = var_2_0.goal
	}))
	self.m_curProgressText:setText(math.min(arg_2_1.taskValue, var_2_0.goal))
	self.m_destinNumText:setText(g.core.lang:get(431503, {
		num = var_2_0.goal
	}))

	if var_2_0.goal == 0 then
		self.m_destinNumText:setText("")
		self.m_curProgressText:setText("")
	end

	local var_2_1 = 1

	while var_0_0.hasKey("reward_type_" .. var_2_1) do
		if var_2_0["reward_size_" .. var_2_1] > 0 then
			table.insert(self._awards, {
				type = var_2_0["reward_type_" .. var_2_1],
				value = var_2_0["reward_value_" .. var_2_1],
				size = var_2_0["reward_size_" .. var_2_1]
			})
		end

		var_2_1 = var_2_1 + 1
	end

	self.m_awardList:setNumItems(#self._awards)

	if arg_2_1.isGet then
		self.m_drawStateController:setSelectedIndex(2)
	elseif arg_2_1.taskValue >= var_2_0.goal then
		self.m_drawStateController:setSelectedIndex(1)
	else
		self.m_drawStateController:setSelectedIndex(0)
	end
end

function SuccubaLaunchTaskCell:_onRewardBtnClick()
	if not self._taskParam.isGet then
		if self._taskParam.taskValue >= self._taskParam.cfg.goal then
			g.core.network.GameNetProxy:send_C2S_Succuba_Activity_FinishTask({
				task_ids = var_0_1:getTaskCanRewardIds()
			})
		else
			if self._taskParam.cfg.route > 0 then
				g.view.entrance.ModuleGotoProxy:gotoModule(self._taskParam.cfg.route)
			end

			return
		end
	end
end

function SuccubaLaunchTaskCell:_onRewardItemRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateIcon(self._awards[arg_4_1 + 1])
end

return SuccubaLaunchTaskCell
