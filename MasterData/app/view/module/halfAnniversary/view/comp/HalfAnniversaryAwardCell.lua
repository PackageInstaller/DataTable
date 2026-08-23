local var_0_0 = {
	DAILY = 1,
	PHASE = 2
}
local var_0_1 = g.core.const.ConstMgr.HalfAnniversaryConst
local HalfAnniversaryAwardCell = class("HalfAnniversaryAwardCell", require("app.fairyGUI.halfAnniversary.UI_HalfAnniversaryAwardCell"))

function HalfAnniversaryAwardCell:ctor()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRenderer))
	self.m_receiveBtn:addClickListener(handler(self, self._onRecvClick))
	self.getSharedTrans(self, "enter_down", "CommonLongCellList", self)
end

function HalfAnniversaryAwardCell:updateCell(arg_2_1)
	self._data = arg_2_1
	self._cfg = g.core.config.welfarefund_task_info.get(self._data.id)

	if self._cfg.type == var_0_0.DAILY then
		self.m_typeController:setSelectedIndex(0)
	elseif self._cfg.type == var_0_0.PHASE then
		self.m_typeController:setSelectedIndex(1)
	end

	self.m_receiveBtn:getTransition("get"):stop()
	self.m_receiveBtn:getTransition("go"):stop()

	if arg_2_1.awarded then
		self.m_drawStateController:setSelectedIndex(2)
	elseif arg_2_1.value >= self._cfg.task_value then
		self.m_drawStateController:setSelectedIndex(1)
		self.m_receiveBtn:getTransition("get"):play(-1, 0)
	else
		self.m_drawStateController:setSelectedIndex(0)
		self.m_receiveBtn:getTransition("go"):play(-1, 0)
	end

	self.m_name:setText(self._cfg.task_name)
	self.m_descText:setText(g.core.lang:getByString(self._cfg.task_des, {
		num = self._cfg.task_value
	}))
	self.m_destinNumText:setText("/" .. self._cfg.task_value)
	self.m_curProgressText:setText(arg_2_1.value)

	self._allRewards = self:getAwardsData()

	self.m_awardList:setNumItems(#self._allRewards)
end

function HalfAnniversaryAwardCell:_onRecvClick()
	if self._data.awarded then
		return
	elseif self._data.value >= self._cfg.task_value then
		g.core.network.GameNetProxy:send_C2S_Welfarefund_GetAward({
			id = self._cfg.id
		})
	elseif self._cfg.route_id > 0 then
		g.view.entrance.ModuleGotoProxy:gotoModule(self._cfg.route_id)
	end
end

function HalfAnniversaryAwardCell:_onAwardItemRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateIcon(self._allRewards[arg_4_1 + 1])
end

function HalfAnniversaryAwardCell:getAwardsData()
	local var_5_0 = {}

	for iter_5_0 = 1, var_0_1.AWARDS_COUNT do
		if self._cfg["reward_size_" .. iter_5_0] ~= 0 then
			table.insert(var_5_0, {
				type = self._cfg["reward_type_" .. iter_5_0],
				value = self._cfg["reward_value_" .. iter_5_0],
				size = self._cfg["reward_size_" .. iter_5_0]
			})
		end
	end

	return var_5_0
end

return HalfAnniversaryAwardCell
