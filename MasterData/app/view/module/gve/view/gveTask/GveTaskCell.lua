local var_0_0 = g.core.config.gve_task_info
local var_0_2 = g.core.model.User.gveDataMgr
local var_0_3 = g.core.model.User.gveDataMgr:getGveTaskData()
local var_0_4 = g.core.const.ConstMgr.GveConst.TASK_RECEIVE_STATUS
local GveTaskCell = class("GveTaskCell", require("app.fairyGUI.gve.UI_GveTaskCell"))

function GveTaskCell:ctor()
	var_0_3 = var_0_2:getGveTaskData()

	self.getSharedTrans(self, "listCrossbandAUiRightIn", "LongCellFromLeft", self)

	self._taskId = 0
	self._chapterId = 0
	self._routeId = 0
	self._rewardStatus = var_0_4.CAN_NOT_RECEIVE
	self._rewardData = {}

	self.m_rewardList:setIniter()
	self.m_rewardList:setItemRenderer(handler(self, self._onListRenderer))
	self.m_getBtn:addClickListener(handler(self, self.onRewardClick))
	self.m_gotoBtn:addClickListener(handler(self, self.onGotoClick))
	self.m_completeBtn:addClickListener(handler(self, self.onCompleteClick))
end

function GveTaskCell:updateView(arg_2_1, arg_2_2)
	self._showChapterId = arg_2_2
	self._taskId = arg_2_1.task_id
	self._chapterId = arg_2_1.chapter_id

	local var_2_0 = arg_2_1.value or 0
	local var_2_1 = arg_2_1.target or ""
	local var_2_2 = var_0_3:getTaskStatus(arg_2_1)

	if var_2_2 == var_0_4.CAN_RECEIVE then
		self.m_rewardStateController:setSelectedIndex(2)
	elseif var_2_2 == var_0_4.CAN_NOT_RECEIVE then
		self.m_rewardStateController:setSelectedIndex(1)
	elseif var_2_2 == var_0_4.HAVE_RECEIVED then
		self.m_rewardStateController:setSelectedIndex(3)
	end

	self._rewardStatus = var_2_2

	local var_2_3 = var_0_0.get(self._taskId)

	self._routeId = var_2_3.route_id

	self.m_taskName:setText(var_2_3.name)
	self.m_taskDesText:setText((string.gsub((var_2_3.key ~= 0 or nil) and string.gsub(var_2_3.des, "#key#", (var_2_3.key_des == "0" or nil) and (var_2_3.key or var_2_3.key_des)), "#value#", var_2_3.value)))
	self.m_curText:setText(var_2_0)
	self.m_targetText:setText("/" .. var_2_1)

	self._rewardData = var_0_3:getProfileAwardInfo(var_2_3.drop_id)

	self.m_rewardList:setNumItems(#self._rewardData)

	if self._showChapterId > var_0_3:getMaxCompleteChapterId() + 1 then
		self.m_showMaskController:setSelectedIndex(1)
	else
		self.m_showMaskController:setSelectedIndex(0)
	end
end

function GveTaskCell:_onListRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._rewardData[arg_3_1 + 1])
end

function GveTaskCell:onRewardClick()
	if not self:checkTip() then
		return
	end

	if self._rewardStatus == var_0_4.CAN_RECEIVE then
		g.core.network.GameNetProxy:send_C2S_GVE_TaskAward({
			id = self._taskId
		})
	end
end

function GveTaskCell:onGotoClick()
	if not self:checkTip() then
		return
	end

	if self._rewardStatus == var_0_4.CAN_NOT_RECEIVE then
		if self._routeId == 285 then
			g.core.module.ModuleManager:popComponent()
		else
			g.view.entrance.ModuleGotoProxy:gotoModule(self._routeId)
		end
	end
end

function GveTaskCell:onCompleteClick()
	self:checkTip()
end

function GveTaskCell:checkTip()
	if not var_0_3:isCompleteChapter(self._chapterId - 1) then
		g.core.module.ModuleManager:tip(g.core.lang:get(309165))

		return false
	end

	return true
end

return GveTaskCell
