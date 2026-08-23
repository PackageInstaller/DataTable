local var_0_0 = g.core.const.ConstMgr.GveConst.TASK_RECEIVE_STATUS
local var_0_1 = g.core.model.User.gveDataMgr
local var_0_2 = g.core.model.User.gveDataMgr:getGveTaskData()
local GveTaskAwardPop = class("GveTaskAwardPop", require("app.fairyGUI.gve.UI_GveTaskAwardPop"), function()
	return fgui.GComponent:create({
		resName = "GveTaskAwardPop",
		pkgName = "gve",
		pkgPath = "ui/gve/gve"
	}, ...)
end)

function GveTaskAwardPop:ctor(arg_2_1)
	var_0_2 = var_0_1:getGveTaskData()
	self._chapterId = arg_2_1.chapterId
	self._chapterRewardStatus = arg_2_1.chapterRewardStatus
	self._rewardList = var_0_2:getProfileAwardInfo(g.core.config.gve_task_group_info.get(self._chapterId).drop_id)

	self:showAtCenter()
	self:_initView()
	self:updateView()
end

function GveTaskAwardPop:_initView()
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onItemRenderer))
end

function GveTaskAwardPop:updateView()
	self.m_rewardList:setNumItems(#self._rewardList)

	if self._chapterRewardStatus == var_0_0.CAN_NOT_RECEIVE then
		self.m_statusController:setSelectedIndex(1)
	elseif self._chapterRewardStatus == var_0_0.CAN_RECEIVE then
		-- block empty
	elseif self._chapterRewardStatus == var_0_0.HAVE_RECEIVED then
		self.m_statusController:setSelectedIndex(0)
	end
end

function GveTaskAwardPop:_onItemRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateIcon(self._rewardList[arg_5_1 + 1])
end

return GveTaskAwardPop
