local var_0_0 = g.core.model.User.dailyTaskData
local DailyTaskAwardCell = class("DailyTaskAwardCell", require("app.fairyGUI.dailyTask.UI_DailyTaskAwardCell"))

function DailyTaskAwardCell:ctor(arg_1_1)
	self._state = 0
	self._taskId = 0
	self._routeId = 0
	self._funcId = 0
	self._extraDropId = 0
	self._dailyInfo = {}
	self._lockDesc = nil
	self._awards = {}

	self.m_receiveBtn:addClickListener(handler(self, self._onBtnClick))
	self.m_awardList:setVirtual(self)
	self.m_awardList:doFairyBatching(false)
	self.m_awardList:setItemRenderer(handler(self, self._onAwardRenderer))
	self.getSharedTrans(self, "enter_right", "CommonShortCellList", self)

	self._goBtnTrans = self.m_receiveBtn:getTransition("go")
	self._getBtnTrans = self.m_receiveBtn:getTransition("get")
end

function DailyTaskAwardCell:updateItem(arg_2_1)
	self._dailyInfo = arg_2_1.info
	self._taskId = arg_2_1.info.id
	self._routeId = arg_2_1.info.route_id
	self._funcId = arg_2_1.info.function_id
	self._extraDropId = arg_2_1.info.extra_drop
	self._state = arg_2_1.state

	self.m_name:setText(arg_2_1.info.name)
	self.m_descText:setText(arg_2_1.info.description)

	self._awards = var_0_0:getDailyTaskAwardInfo(arg_2_1.info)

	self.m_awardList:setNumItems(#self._awards)
	self.m_destinNumText:setText("/" .. arg_2_1.info.num)

	if arg_2_1.value > arg_2_1.info.num then
		self.m_curProgressText:setText(arg_2_1.info.num)
	else
		self.m_curProgressText:setText(arg_2_1.value)
	end

	self.m_surpriseController:setSelectedIndex(arg_2_1.surpriseId and arg_2_1.surpriseId > 0 and 1 or 0)
	self.m_drawStateController:setSelectedIndex(0)

	if self._state == 0 then
		self.m_drawStateController:setSelectedIndex(2)
	elseif self._state == 1 then
		self.m_drawStateController:setSelectedIndex(1)
	elseif self._state == 2 then
		self.m_drawStateController:setSelectedIndex(3)
	end

	self:setTouchable(true)

	if arg_2_1.isLock and self._funcId ~= 0 then
		self._lockDesc = g.core.config.function_info.get(self._funcId).lock_direction

		self.m_lockDesc:setText(self._lockDesc)
		self:setTouchable(false)
	end

	self._getBtnTrans:stop()
	self._goBtnTrans:stop()

	if self._state == 0 then
		self._getBtnTrans:play(-1, 0)
	elseif self._state == 1 then
		self._goBtnTrans:play(-1, 0)
	end
end

function DailyTaskAwardCell:_onAwardRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._awards[arg_3_1 + 1] or {}, self._state == 2)
end

function DailyTaskAwardCell:_onBtnClick()
	if g.core.model.User.dailyTaskData:isExpired() then
		g.core.module.ModuleManager:tip(g.core.lang:get(106505))

		return
	end

	if self._funcId == 0 or g.core.common.ModuleUnlock:checkModuleUnlockStatus(self._funcId) then
		if self._state == 0 then
			g.core.network.GameNetProxy:send_C2S_DailyTask_FinishAward({
				id = self._taskId
			})
		elseif self._state == 1 and self._routeId > 0 then
			g.view.entrance.ModuleGotoProxy:gotoModule(self._routeId)
		end
	elseif self._lockDesc then
		g.core.module.ModuleManager:tip(self._lockDesc)
	end
end

return DailyTaskAwardCell
