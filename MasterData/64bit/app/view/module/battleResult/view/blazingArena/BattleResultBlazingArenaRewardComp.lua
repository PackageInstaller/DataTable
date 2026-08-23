local BattleResultArenaRewardComp = class("BattleResultArenaRewardComp", require("app.fairyGUI.battleResult.UI_BattleResultArenaRewardComp"))

function BattleResultArenaRewardComp:ctor()
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onListAwardRenderer))
	self.m_enterTransition:setHook("listLeftIn", handler(self, self._onTransAward))

	if require("app.view.battle.const.BattleConst").TYPE_FRIEND_PVP == g.core.battle.BattleProxy:getType() then
		self.m_hideRankController:setSelectedIndex(1)
	end
end

function BattleResultArenaRewardComp:_onListAwardRenderer(arg_2_1, arg_2_2)
	arg_2_2._inAnim = arg_2_2._inAnim or arg_2_2.getSharedTrans(arg_2_2, "listIconUiLeftIn", "ItemBagList", arg_2_2)

	local var_2_0 = self._dropParams[arg_2_1 + 1]
	local var_2_1

	if self._dropParams[arg_2_1 + 1].type == g.core.common.Goods.TYPE_ITEM and g.core.model.User.themeData:isActivityItem(var_2_0.value) then
		var_2_1 = g.core.const.ConstMgr.BASE_CONST.ICON_TAG_TYPE.PROB
	end

	local var_2_2 = {
		darkQuality = true,
		nameRow = 0,
		type = var_2_0.type,
		value = var_2_0.value,
		size = var_2_0.size
	}

	var_2_2.rightTxt = var_2_0.rightTxt or ""
	var_2_2.iconTagType = var_2_1

	arg_2_2:getChild("icon"):updateIcon(var_2_2)
end

function BattleResultArenaRewardComp:_isGuildSkill(arg_3_1)
	return arg_3_1.type == g.core.common.Goods.TYPE_RESOURCE and arg_3_1.value == g.core.common.Goods.RESOURCE.TYPE_CHIEF_ARENA_SKILL
end

function BattleResultArenaRewardComp:_onTransAward()
	if self._dropParams then
		self.m_rewardList:setNumItems(#self._dropParams)
		self.m_rewardList:transitionShowCells("listIconUiLeftIn", 0.03, 1)
	end
end

function BattleResultArenaRewardComp:update(arg_5_1)
	self._dropParams = arg_5_1.dropList or {}

	if arg_5_1.isWin and arg_5_1.rank then
		if (arg_5_1.oldRank or 10000) - arg_5_1.rank > 0 then
			self.m_stateController:setSelectedIndex(0)
		else
			self.m_stateController:setSelectedIndex(1)
		end
	end

	self.m_rewardList:setNumItems(#self._dropParams)
end

return BattleResultArenaRewardComp
