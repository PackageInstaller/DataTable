local var_0_0 = g.core.const.ConstMgr.AchievementConst.RECEIVE_STATE
local AchievementTotalProgPopCell = class("AchievementTotalProgPopCell", require("app.fairyGUI.achievement.UI_AchievementTotalProgPopCell"))

function AchievementTotalProgPopCell:ctor()
	self._awardDataStruct = {}

	self.m_receiveBtn:addClickListener(handler(self, self._onClickReceive))
	self.m_awardList:setVirtual()
	self.m_awardList:doFairyBatching(false)
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRenderer))
end

function AchievementTotalProgPopCell:updateCell(arg_2_1)
	self._awardDataStruct = arg_2_1

	local var_2_0 = arg_2_1:getInfo()

	self.m_desText:setText(g.core.lang:get(113004, {
		number = var_2_0.num
	}))
	self.m_nameText:setText(var_2_0.name)
	self.m_awardList:setNumItems(#arg_2_1:getAwardArr())

	local var_2_1 = arg_2_1:getState()

	if var_2_1 == var_0_0.NOT_ACHIEVE then
		self.m_curValueText:setText((arg_2_1:getCurNum()))
		self.m_totalValueText:setText(g.core.lang:get(113001, {
			totalValue = var_2_0.num
		}))
	end

	self.m_rewardStatusController:setSelectedIndex(var_2_1)
end

function AchievementTotalProgPopCell:_onAwardItemRenderer(arg_3_1, arg_3_2)
	local var_3_0 = self._awardDataStruct:getAwardArr()[arg_3_1 + 1]

	var_3_0.scaleIndex = 2

	arg_3_2:updateIcon(var_3_0)
end

function AchievementTotalProgPopCell:_onClickReceive()
	g.core.network.GameNetProxy:send_C2S_Achievement_Reward({
		id = self._awardDataStruct:getInfo().id
	})
end

return AchievementTotalProgPopCell
