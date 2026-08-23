local var_0_0 = g.core.model.User.gveDataMgr
local BattleResultGveStarComp = class("BattleResultGveStarComp", require("app.fairyGUI.battleResult.UI_BattleResultGveStarComp"))

function BattleResultGveStarComp:ctor()
	self.m_enterTransition:setHook("starEnter1", handler(self, self._onStarEnter1))
	self.m_enterTransition:setHook("starEnter2", handler(self, self._onStarEnter2))
	self.m_enterTransition:setHook("starEnter3", handler(self, self._onStarEnter3))
end

function BattleResultGveStarComp:_onStarEnter1()
	self.m_star1:playSpineAnim()
end

function BattleResultGveStarComp:_onStarEnter2()
	self.m_star2:playSpineAnim()
end

function BattleResultGveStarComp:_onStarEnter3()
	self.m_star3:playSpineAnim()
end

function BattleResultGveStarComp:update(arg_5_1)
	local var_5_0 = arg_5_1.content or {}
	local var_5_1 = var_5_0.recover_action or 0
	local var_5_2 = 0

	for iter_5_0, iter_5_1 in pairs(var_5_0.star or {}) do
		if iter_5_1 == true then
			var_5_2 = var_5_2 + 1
		end
	end

	for iter_5_2 = 1, 3 do
		self["m_star" .. iter_5_2]:setActive(iter_5_2 <= var_5_2, iter_5_2 == 3, 0.3 * (iter_5_2 - 1))
	end

	local var_5_3 = var_0_0:getGveBaseCfg().rating_action_recover * var_5_2

	if var_5_1 - var_5_3 > 0 then
		self.m_descTxt:setText(g.core.lang:get(309007, {
			action = var_5_3,
			addText = g.core.lang:get(309025, {
				addAction = var_5_1 - var_5_3
			})
		}))
		self.m_hasSealAddController:setSelectedIndex(1)
	else
		self.m_descTxt:setText(g.core.lang:get(309007, {
			addText = "",
			action = var_5_3
		}))
		self.m_hasSealAddController:setSelectedIndex(0)
	end
end

return BattleResultGveStarComp
