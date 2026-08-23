local var_0_0 = g.core.const.ConstMgr.CommanderWorldConst
local CommanderWorldForgeProgCell = class("CommanderWorldForgeProgCell", require("app.fairyGUI.commanderWorld.UI_CommanderWorldForgeProgCell"))

function CommanderWorldForgeProgCell:ctor()
	self._rcvStatus = var_0_0.RECEIVE_STATUS.RECEIVE_NOT_ABLE
	self._rewardData = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderRewardItem))
end

function CommanderWorldForgeProgCell:updateForgeProgCell(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	self._rewardData = arg_2_1.rewardList
	self._rcvStatus = arg_2_1.canRec

	self.m_levelStatusController:setSelectedIndex(arg_2_5)

	if arg_2_5 == var_0_0.LEVEL_STATUS.PRE and self._rcvStatus == var_0_0.RECEIVE_STATUS.RECEIVE_NOT_ABLE then
		self._rcvStatus = not arg_2_3 and var_0_0.RECEIVE_STATUS.RECEIVE_LATE or var_0_0.RECEIVE_STATUS.RECEIVE_FINISH
	end

	self.m_isGetController:setSelectedIndex(self._rcvStatus)
	self.m_forgeNumTxt:setText(g.core.lang:get(410305, {
		num = arg_2_1.level
	}))
	self.m_progTxt:setText(g.core.lang:get(410306, {
		num = arg_2_2
	}))
	self.m_progNumText:setText(g.core.lang:get(410307, {
		myScore = arg_2_4,
		score = arg_2_2
	}))
	self.m_awardList:setNumItems(#self._rewardData)
end

function CommanderWorldForgeProgCell:_onRenderRewardItem(arg_3_1, arg_3_2)
	arg_3_2:updateIcon({
		type = self._rewardData[arg_3_1 + 1].rewardType,
		value = self._rewardData[arg_3_1 + 1].rewardValue,
		size = self._rewardData[arg_3_1 + 1].rewardNum
	})

	if self._rcvStatus == var_0_0.RECEIVE_STATUS.RECEIVE_FINISH then
		arg_3_2:setIconGray(true)
	else
		arg_3_2:setIconGray(false)
	end

	arg_3_2:setScale(0.8)
end

return CommanderWorldForgeProgCell
