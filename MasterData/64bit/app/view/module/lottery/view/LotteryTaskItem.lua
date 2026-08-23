local var_0_0 = {
	PHASE = 1,
	DAILY = 2
}
local LotteryConst = require("app.view.module.lottery.const.LotteryConst")
local LotteryTaskItem = class("LotteryTaskItem", require("app.fairyGUI.lottery.UI_LotteryTaskItem"))

function LotteryTaskItem:ctor()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRenderer))
	self.m_btn:addClickListener(handler(self, self._onBtnClick))
	self.getSharedTrans(self, "enter_down", "CommonLongCellList", self)
end

function LotteryTaskItem:updateCell(arg_2_1)
	self._data = arg_2_1

	local var_2_0 = arg_2_1.cfg

	if arg_2_1.receiveNum >= arg_2_1.receiveLimit then
		self.m_drawStateController:setSelectedIndex(2)
	elseif arg_2_1.curValue >= self._data.receiveNum * self._data.cfg.value + self._data.cfg.value then
		self.m_drawStateController:setSelectedIndex(1)
	else
		self.m_drawStateController:setSelectedIndex(0)
	end

	if var_2_0.refresh == var_0_0.DAILY then
		self.m_typeController:setSelectedIndex(0)
	elseif var_2_0.refresh == var_0_0.PHASE then
		self.m_typeController:setSelectedIndex(1)
	end

	local var_2_1 = var_2_0.value

	if g.core.config.lottery_task_info.hasKey("show_value") then
		var_2_1 = var_2_0.show_value
	end

	self.m_name:setText(var_2_0.title)
	self.m_descText:setText(g.core.lang:getByString(var_2_0.text, {
		num = var_2_1
	}))

	if self._data.receiveLimit > 1 then
		self.m_curProgressText:setText("")
		self.m_destinNumText:setText("")
	else
		self.m_curProgressText:setText(math.min(arg_2_1.curValue, var_2_0.value))
		self.m_destinNumText:setText("/" .. var_2_0.value)
	end

	local var_2_2 = {}

	while g.core.config.lottery_task_info.hasKey("reward_size" .. 1) do
		if var_2_0["reward_size" .. 1] ~= 0 then
			table.insert(var_2_2, {
				type = var_2_0["reward_type" .. 1],
				value = var_2_0["reward_value" .. 1],
				size = var_2_0["reward_size" .. 1]
			})
		end
	end

	self._allRewards = var_2_2

	self.m_awardList:setNumItems(#self._allRewards)
end

function LotteryTaskItem:_onBtnClick()
	if self._data.receiveNum >= self._data.receiveLimit then
		return
	else
		local var_3_0 = self._data.receiveNum * self._data.cfg.value

		if self._data.curValue >= self._data.receiveNum * self._data.cfg.value + self._data.cfg.value then
			g.core.network.GameNetProxy:send_C2S_Lottery_TaskAward({
				task_id = self._data.cfg.id,
				num = math.min(LotteryConst.MAX_RECEIVE_NUM, (math.min(self._data.receiveLimit - self._data.receiveNum, (math.floor((self._data.curValue - var_3_0) / self._data.cfg.value)))))
			})
		else
			if self._data.cfg.source_route > 0 then
				g.view.entrance.ModuleGotoProxy:gotoModule(self._data.cfg.source_route)
			end

			return
		end
	end
end

function LotteryTaskItem:_onAwardItemRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateIcon(self._allRewards[arg_4_1 + 1])
end

return LotteryTaskItem
