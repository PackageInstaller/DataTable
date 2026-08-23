local var_0_0 = g.core.model.User
local ActivityLevelUpAwardCell = class("ActivityLevelUpAwardCell", require("app.fairyGUI.activity.UI_ActivityLevelUpAwardCell"))

function ActivityLevelUpAwardCell:ctor()
	self._data = nil
	self._state = 0
	self._isCanSendNet = false

	self.m_awardList:setVirtual()
	self.m_awardList:doFairyBatching(false)
	self.m_awardList:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_receiveBtn:addClickListener(handler(self, self._onReceiveBtnClick))
	self.m_hasDrawComp:addClickListener(handler(self, self._onHasDrawCompClick))
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function ActivityLevelUpAwardCell:updateItem(arg_2_1)
	self._data = arg_2_1

	self.m_name:setText(g.core.lang:get(402001, {
		num = self._data.info.level
	}))

	self._awards = self:_getAward()

	self.m_awardList:setNumItems(#self._awards)

	local var_2_0 = var_0_0:getLevel()

	self.m_curProgressText:setText(math.min(var_2_0, self._data.info.level))
	self.m_destinNumText:setText("/" .. self._data.info.level)

	self._isCanSendNet = false

	local var_2_1 = 0

	if self._data.isFinish then
		var_2_1 = 2
	elseif var_2_0 < self._data.info.level then
		var_2_1 = 0
	else
		var_2_1 = 1
		self._isCanSendNet = true
	end

	self._state = var_2_1

	self.m_drawStateController:setSelectedIndex(self._state)
end

function ActivityLevelUpAwardCell:_getAward()
	local var_3_0 = {}

	for iter_3_0 = 1, 4 do
		if self._data.info["reward_type_" .. iter_3_0] > 0 then
			table.insert(var_3_0, {
				type = self._data.info["reward_type_" .. iter_3_0],
				value = self._data.info["reward_value_" .. iter_3_0],
				size = self._data.info["reward_size_" .. iter_3_0]
			})
		end
	end

	return var_3_0
end

function ActivityLevelUpAwardCell:_onItemRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateIcon(self._awards[arg_4_1 + 1])
end

function ActivityLevelUpAwardCell:_onReceiveBtnClick()
	if self._state == 1 then
		if self._isCanSendNet then
			self._isCanSendNet = false

			g.core.network.GameNetProxy:send_C2S_LevelUp_Award({
				id = self._data.info.id
			})
		end
	elseif self._state == 0 and self._data and self._data.info and self._data.info.route_id > 0 then
		g.view.entrance.ModuleGotoProxy:gotoModule(self._data.info.route_id)
	end
end

function ActivityLevelUpAwardCell:_onHasDrawCompClick()
	g.core.module.ModuleManager:tip(g.core.lang:get(402002))
end

return ActivityLevelUpAwardCell
