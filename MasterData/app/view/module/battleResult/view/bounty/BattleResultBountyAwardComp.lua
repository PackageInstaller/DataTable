local var_0_0 = g.core.const.ConstMgr.BountyConst
local BattleResultBountyAwardComp = class("BattleResultBountyAwardComp", require("app.fairyGUI.battleResult.UI_BattleResultBountyAwardComp"))

function BattleResultBountyAwardComp:ctor()
	self._awardItems = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardListRenderer))
end

function BattleResultBountyAwardComp:update(arg_2_1)
	self._awardItems = arg_2_1.awardList or {}

	self.m_awardList:setNumItems(#self._awardItems)
	self.m_awardList:transitionShowCells("listIconUiLeftIn", 0.03, 1)

	local var_2_0 = g.core.model.User.bountyData:getHelpScore() or 0

	if arg_2_1.error_ret == var_0_0.ERROR_RET_CODE.ACTIVITY_EXPIRED then
		self.m_stateController:setSelectedIndex(2)
	elseif arg_2_1.error_ret == var_0_0.ERROR_RET_CODE.MONSTER_DEFEATED then
		self.m_stateController:setSelectedIndex(1)
	elseif arg_2_1.error_ret == var_0_0.ERROR_RET_CODE.MONSTER_NOT_EXIST then
		self.m_stateController:setSelectedIndex(3)
	elseif arg_2_1.error_ret == var_0_0.ERROR_RET_CODE.MONSTER_SHARE_CHANGED then
		self.m_stateController:setSelectedIndex(5)
	elseif arg_2_1.error_ret == var_0_0.ERROR_RET_CODE.SHARE_GUILD_CHANGED then
		self.m_stateController:setSelectedIndex(6)
	elseif #self._awardItems == 0 and g.core.model.User.bountyData:getHelpScoreLimit() <= var_2_0 then
		self.m_stateController:setSelectedIndex(4)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

function BattleResultBountyAwardComp:_onAwardListRenderer(arg_3_1, arg_3_2)
	arg_3_2._inAnim = arg_3_2._inAnim or arg_3_2.getSharedTrans(arg_3_2, "listIconUiLeftIn", "ItemBagList", arg_3_2)

	arg_3_2:updateIcon(self._awardItems[arg_3_1 + 1])
end

return BattleResultBountyAwardComp
