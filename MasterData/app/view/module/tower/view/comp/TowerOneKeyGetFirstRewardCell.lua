local var_0_0 = g.core.config.tower_stage_info
local TowerOneKeyGetFirstRewardCell = class("TowerOneKeyGetFirstRewardCell", require("app.fairyGUI.tower.UI_TowerOneKeyGetFirstRewardCell"))

function TowerOneKeyGetFirstRewardCell:ctor()
	self._rewardList = {}

	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRenderRewardList))
	self.m_resultList:setVirtual()
	self.m_resultList:setItemRenderer(handler(self, self._onRenderResultList))
end

function TowerOneKeyGetFirstRewardCell:_onRenderRewardList(arg_2_1, arg_2_2)
	self._rewardList[arg_2_1 + 1].scaleIndex = 3

	arg_2_2:updateIcon(self._rewardList[arg_2_1 + 1])
end

function TowerOneKeyGetFirstRewardCell:_onRenderResultList(arg_3_1, arg_3_2)
	self._rewardList[arg_3_1 + 1].scaleIndex = 2

	arg_3_2:updateIcon(self._rewardList[arg_3_1 + 1])
end

function TowerOneKeyGetFirstRewardCell:updateCell(arg_4_1, arg_4_2)
	if arg_4_1.isFinal then
		self:updateResultView(arg_4_1, arg_4_2)
	else
		self:updateFirstPassRewardView(arg_4_1, arg_4_2)
	end
end

function TowerOneKeyGetFirstRewardCell:updateFirstPassRewardView(arg_5_1, arg_5_2)
	self.m_isResultShowController:setSelectedIndex(0)

	local var_5_0 = arg_5_1.data
	local var_5_2 = (arg_5_1.data.towerStageFirstRecord or {}).user_records or {}
	local var_5_3
	local var_5_4

	if var_5_2[1] then
		var_5_3 = var_5_2[1].snapshot or {}

		if var_5_3.id == nil then
			self.m_hasUserController:setSelectedIndex(0)

			goto label_5_0
		end
	end

	self.m_hasUserController:setSelectedIndex(1)
	self.m_userNameText:setText(var_5_3.name)
	self.m_powerText:setText(var_5_3.fight_value)
	self.m_userIcon:updateAsUser(var_5_3)

	do
		var_5_4 = {}
	end

	::label_5_0::

	var_5_4.stageOrder = var_0_0.get(var_5_0.info.require_value).stage_order

	self.m_passOrderText:setText(g.core.lang:get(308022, var_5_4))
	self.m_countTxt:setText(arg_5_2 + 1)

	self._rewardList = arg_5_1.rewardList or {}

	self.m_rewardList:setNumItems(#self._rewardList)
end

function TowerOneKeyGetFirstRewardCell:updateResultView(arg_6_1)
	self.m_isResultShowController:setSelectedIndex(1)

	self._rewardList = arg_6_1.rewardList or {}

	self.m_resultList:setNumItems(#self._rewardList)
end

return TowerOneKeyGetFirstRewardCell
