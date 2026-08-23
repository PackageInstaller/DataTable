local var_0_0 = g.core.const.ConstMgr.BountyConst
local BountyFormationChallengeComp = class("BountyFormationChallengeComp", require("app.fairyGUI.bounty.UI_BountyFormationChallengeComp"))

function BountyFormationChallengeComp:ctor()
	self._monsterStruct = nil

	self:initView()
end

function BountyFormationChallengeComp:initView()
	self.m_enemyList:setVirtual(self)
	self.m_enemyList:setItemRenderer(handler(self, self._onRenderEnemyList))
	self.m_shareAwardList:setVirtual(self)
	self.m_shareAwardList:setItemRenderer(handler(self, self._onRenderShareAwardList))
	self.m_killAwardList:setVirtual(self)
	self.m_killAwardList:setItemRenderer(handler(self, self._onRenderKillAwardList))
	self.m_battleBtn:addClickListener(handler(self, self._onClickBattleBtn))
	self.m_formationBtn:addClickListener(handler(self, self._onClickFormationBtn))
end

function BountyFormationChallengeComp:updateComp(arg_3_1)
	self._monsterStruct = arg_3_1

	self.m_fightValueText:setText(self._monsterStruct:getFightValue())

	if self._monsterStruct:isDetailMonster() then
		self.m_enemyList:setNumItems(#self._monsterStruct:getUnits())
	else
		self.m_enemyList:setNumItems(0)
	end

	local var_3_0 = self._monsterStruct:getRewardsByRewardType(var_0_0.MONSTER_REWARD_TYPE.KILL) or {}

	self._killRewards = var_3_0

	self.m_killAwardList:setNumItems(#var_3_0)
	self.m_costComp:updateByTVS({
		size = 1,
		type = var_0_0.BATTLE_COST_ITEM.type,
		value = var_0_0.BATTLE_COST_ITEM.value
	})

	if self._monsterStruct:getSummonUserId() == g.core.model.User:getId() then
		local var_3_1 = self._monsterStruct:getRewardsByRewardType(var_0_0.MONSTER_REWARD_TYPE.SHARE) or {}

		self._shareAwards = var_3_1

		self.m_shareAwardList:setNumItems(#var_3_1)
		self.m_hideShareAwardController:setSelectedIndex(0)
		self.m_shareNameText:setText(g.core.model.User:getName())
	else
		local var_3_2 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, (self._monsterStruct:getSummonUserId()))

		if var_3_2 then
			self.m_shareNameText:setText(var_3_2.name)
		else
			self.m_shareNameText:setText("")
		end

		self.m_hideShareAwardController:setSelectedIndex(1)
	end
end

function BountyFormationChallengeComp:updateEnemyList()
	self.m_enemyList:setNumItems(#self._monsterStruct:getUnits())
end

function BountyFormationChallengeComp:_onRenderEnemyList(arg_5_1, arg_5_2)
	local var_5_0 = self._monsterStruct:getUnits()[arg_5_1 + 1]

	arg_5_2:updateIcon({
		isFogNightPop = true,
		type = g.core.common.Goods.TYPE_KNIGHT,
		struct = var_5_0,
		star = var_5_0:getInfo().star_level
	})
end

function BountyFormationChallengeComp:_onRenderShareAwardList(arg_6_1, arg_6_2)
	arg_6_2:updateIcon(self._shareAwards[arg_6_1 + 1])
end

function BountyFormationChallengeComp:_onRenderKillAwardList(arg_7_1, arg_7_2)
	arg_7_2:updateIcon(self._killRewards[arg_7_1 + 1])
end

function BountyFormationChallengeComp:_onClickFormationBtn()
	self:dispatchCompEvent("click_formation_btn")
end

function BountyFormationChallengeComp:_onClickBattleBtn()
	self:dispatchCompEvent("click_battle_btn")
end

return BountyFormationChallengeComp
