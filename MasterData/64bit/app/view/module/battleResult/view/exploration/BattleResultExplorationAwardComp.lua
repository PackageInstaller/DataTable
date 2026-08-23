local var_0_0 = g.core.const.ConstMgr.ExplorationConst
local BattleResultExplorationAwardComp = class("BattleResultExplorationAwardComp", require("app.fairyGUI.battleResult.UI_BattleResultExplorationAwardComp"))

function BattleResultExplorationAwardComp:ctor()
	self._awardItems = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardListRenderer))
end

function BattleResultExplorationAwardComp:update(arg_2_1)
	self._awardItems = arg_2_1.awardList or {}

	self.m_awardList:setNumItems(#self._awardItems)
	self.m_awardList:transitionShowCells("listIconUiLeftIn", 0.03, 1)

	local var_2_0 = g.core.model.User.explorationData:getFormationData():getKnightByServerId(arg_2_1.knightId or 0)

	if var_2_0 then
		self.m_knightIcon:updateIcon({
			isFogNightPop = true,
			type = g.core.common.Goods.TYPE_KNIGHT,
			struct = var_2_0
		})
		self.m_knightIcon:getIconComp():setAdvanceLevel(0)
		self.m_knightIcon:setVisible(true)
	else
		self.m_knightIcon:setVisible(false)
	end

	local var_2_1 = arg_2_1.guildBuff or {}
	local var_2_2 = var_2_1.user_ids or {}
	local var_2_3 = false

	for iter_2_0, iter_2_1 in ipairs(var_2_2) do
		if iter_2_1 == g.core.model.User:getId() then
			var_2_3 = true
		end
	end

	if not var_2_3 then
		self.m_hideBuffController:setSelectedIndex(1)

		return
	end

	local var_2_4

	for iter_2_2, iter_2_3 in g.core.config.exploration_guild_buff_info.ipairs() do
		if iter_2_3.group == var_2_1.buff_group and iter_2_3.num == math.max(1, #var_2_2) then
			var_2_4 = iter_2_3

			break
		end
	end

	if var_2_4 then
		self.m_buffIcon:updateBuffIcon(var_2_4.id, var_0_0.BUFF.GUILD_TYPE)
		self.m_hideBuffController:setSelectedIndex(0)
	else
		self.m_hideBuffController:setSelectedIndex(1)
	end
end

function BattleResultExplorationAwardComp:_onAwardListRenderer(arg_3_1, arg_3_2)
	arg_3_2._inAnim = arg_3_2._inAnim or arg_3_2.getSharedTrans(arg_3_2, "listIconUiLeftIn", "ItemBagList", arg_3_2)

	arg_3_2:updateIcon(self._awardItems[arg_3_1 + 1])
end

return BattleResultExplorationAwardComp
