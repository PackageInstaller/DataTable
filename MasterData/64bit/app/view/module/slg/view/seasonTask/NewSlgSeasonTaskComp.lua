local var_0_0 = g.core.config.new_slg_season_task_info
local var_0_1 = g.core.const.ConstMgr.NewSlgConst
local NewSlgSeasonTaskComp = class("NewSlgSeasonTaskComp", require("app.fairyGUI.newSlg.UI_NewSlgSeasonTaskComp"))

function NewSlgSeasonTaskComp:ctor()
	self.getSharedTrans(self, "listCardAUiLeftIn", "CombineBagList", self)

	self._taskParam = nil

	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onSeasonRewardRenderer))

	self._rewards = {}
	self._timeLeft = 0
end

function NewSlgSeasonTaskComp:updateSeasonTaskComp(arg_2_1)
	self._taskParam = arg_2_1

	self.m_stateController:setSelectedIndex(arg_2_1.state)

	local var_2_0 = self._taskParam.cfg

	self.m_progComp:setMax(self._taskParam.cfg.goal)
	self.m_progComp:setValue(arg_2_1.progress)
	self.m_progTxt:setText(arg_2_1.progress .. "/" .. var_2_0.goal)
	self.m_taskNameTxt:setText(var_2_0.name)
	self.m_picLoader:setURL("ui://newSlg/pic_bg_hzts_renwu0" .. var_2_0.pic)
	self.m_descTxt:setText(g.core.lang:getByString(var_2_0.describe, {
		num = var_2_0.goal
	}))
	self.m_taskDesc2Txt:setText(var_2_0.bonus_describe)

	self._timeLeft = arg_2_1.taskEndTime

	if arg_2_1.needShowUnlockTime then
		self._timeLeft = arg_2_1.taskStartTime
	end

	self.m_lockStr:setText(g.core.lang:get(429754))
	self:updatePreTime()

	self._rewards = {}

	local var_2_1 = 1
	local var_2_3 = (arg_2_1.state ~= var_0_1.SEASON_TASK_STATE.LOCK and (arg_2_1.inTaskTime or arg_2_1.isTaskFinish) or true) and 1 or g.core.model.User.newSlgData:getNewSlgParamsValueById(1020) / 1000

	while var_0_0.hasKey("reward_size_" .. var_2_1) do
		if var_2_0["reward_size_" .. var_2_1] > 0 then
			table.insert(self._rewards, {
				overrideClick = true,
				type = var_2_0["reward_type_" .. var_2_1],
				value = var_2_0["reward_value_" .. var_2_1],
				size = math.floor(var_2_0["reward_size_" .. var_2_1] * var_2_3)
			})
		end

		var_2_1 = var_2_1 + 1
	end

	self.m_rewardList:setNumItems(#self._rewards)
end

function NewSlgSeasonTaskComp:_onSeasonRewardRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._rewards[arg_3_1 + 1], self._taskParam.canReward, self._taskParam.isRewarded, self._taskParam.cfg.id)
end

function NewSlgSeasonTaskComp:updatePreTime(arg_4_1)
	if self._taskParam.inTaskTime and self._timeLeft > 0 then
		self.m_progressTimeTxt:setText((g.core.common.ServerTime:getLeftSecondsString(self._timeLeft)))
	end

	if self._taskParam.needShowUnlockTime then
		self.m_lockStr:setText(g.core.lang:get(429755, {
			time = g.core.common.ServerTime:getLeftSecondsString(self._timeLeft)
		}))
	end
end

function NewSlgSeasonTaskComp:onRewardItemClick()
	if self._taskParam.canReward then
		g.core.network.GameNetProxy:send_C2S_NewSlg_SeasonTaskAward({
			id = self._taskParam.cfg.id
		})
	end
end

return NewSlgSeasonTaskComp
