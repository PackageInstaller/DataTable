local MineTaskRewardCell = class("MineTaskRewardCell", require("app.fairyGUI.mine.UI_MineTaskRewardCell"))

function MineTaskRewardCell:ctor()
	self.m_rewardList:setVirtual(self)
	self.m_rewardList:setItemRenderer(handler(self, self._onAwardListRender))
	self.m_takeRewardBtn:addClickListener(handler(self, self._onClickReceiveBtn))
end

function MineTaskRewardCell:updateCell(arg_2_1)
	self._taskData = arg_2_1

	self.m_titleTxt:setText(arg_2_1.info.name)
	self.m_descTxt:setText(g.core.model.User.mineData:getTaskDesc(arg_2_1.info))

	self._awards = g.core.common.Drops:getGoodsArray(arg_2_1.info.drop_id)

	self.m_rewardList:setNumItems(#self._awards)

	local var_2_0 = math.min(arg_2_1.progress, arg_2_1.info.num)

	if arg_2_1.progress < arg_2_1.info.num then
		var_2_0 = g.core.lang:get(307551, {
			num = var_2_0
		})
	end

	self.m_processTxt:setText(var_2_0 .. "/" .. arg_2_1.info.num)
	self.m_stateController:setSelectedIndex(arg_2_1.isFinish and 2 or arg_2_1.canRec and 1 or 0)
end

function MineTaskRewardCell:_onAwardListRender(arg_3_1, arg_3_2)
	if self._awards[arg_3_1 + 1] then
		arg_3_2:updateIcon(self._awards[arg_3_1 + 1])
	end
end

function MineTaskRewardCell:_onClickReceiveBtn()
	if self._taskData and self._taskData.canRec and not self._taskData.isFinish then
		g.core.network.GameNetProxy:send_C2S_Mine_GetMissionReward({
			id = self._taskData.info.id
		})
	end
end

return MineTaskRewardCell
