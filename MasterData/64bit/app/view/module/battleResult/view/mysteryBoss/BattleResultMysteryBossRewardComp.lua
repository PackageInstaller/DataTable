local var_0_0 = g.core.model.User.mysteryBossData
local BattleResultMysteryBossRewardComp = class("BattleResultMysteryBossRewardComp", require("app.fairyGUI.battleResult.UI_BattleResultMysteryBossRewardComp"))

function BattleResultMysteryBossRewardComp:ctor()
	self.m_enterTransition:setHook("listLeftIn", handler(self, self._onTransAward))
end

function BattleResultMysteryBossRewardComp:_onTransAward()
	return
end

function BattleResultMysteryBossRewardComp:update(arg_3_1)
	local var_3_0 = var_0_0:getOldPosUserId()

	if var_3_0 and var_3_0 > 0 then
		local var_3_1 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_3_0)

		if var_3_1 then
			self.m_playerName:setText(var_3_1.name)
		else
			self.m_playerName:setText("")
		end
	end
end

return BattleResultMysteryBossRewardComp
