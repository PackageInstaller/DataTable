local BattleResultAllianceTrialRewardComp = class("BattleResultAllianceTrialRewardComp", require("app.fairyGUI.battleResult.UI_BattleResultAllianceTrialRewardComp"))

function BattleResultAllianceTrialRewardComp:ctor()
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onListAwardRenderer))
	self.m_enterTransition:setHook("listLeftIn", handler(self, self._onTransAward))
end

function BattleResultAllianceTrialRewardComp:_onListAwardRenderer(arg_2_1, arg_2_2)
	arg_2_2._inAnim = arg_2_2._inAnim or arg_2_2.getSharedTrans(arg_2_2, "listIconUiLeftIn", "ItemBagList", arg_2_2)

	local var_2_0 = self._dropParams[arg_2_1 + 1]
	local var_2_1

	if self._dropParams[arg_2_1 + 1].type == g.core.common.Goods.TYPE_ITEM and g.core.model.User.themeData:isActivityItem(var_2_0.value) then
		var_2_1 = g.core.const.ConstMgr.BASE_CONST.ICON_TAG_TYPE.PROB
	end

	local var_2_2 = {
		nameRow = 0,
		darkQuality = true,
		type = var_2_0.type,
		value = var_2_0.value,
		size = var_2_0.size
	}

	var_2_2.rightTxt = var_2_0.rightTxt or ""
	var_2_2.iconTagType = var_2_1

	arg_2_2:updateIcon(var_2_2)
end

function BattleResultAllianceTrialRewardComp:_onTransAward()
	if self._dropParams then
		self.m_rewardList:setNumItems(#self._dropParams)
		self.m_rewardList:transitionShowCells("listIconUiLeftIn", 0.03, 1)
	end
end

function BattleResultAllianceTrialRewardComp:update(arg_4_1)
	self._dropParams = arg_4_1.awards or {}

	self.m_hasAwardController:setSelectedIndex(arg_4_1.isValid and 1 or 0)
end

return BattleResultAllianceTrialRewardComp
