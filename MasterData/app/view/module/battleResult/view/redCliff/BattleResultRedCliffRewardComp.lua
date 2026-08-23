local var_0_0 = g.core.model.User.redCliffData
local BattleResultRedCliffRewardComp = class("BattleResultRedCliffRewardComp", require("app.fairyGUI.battleResult.UI_BattleResultRedCliffRewardComp"))

function BattleResultRedCliffRewardComp:ctor()
	self.m_enterTransition:setHook("listLeftIn", handler(self, self._onTransAward))
end

function BattleResultRedCliffRewardComp:_onTransAward()
	return
end

function BattleResultRedCliffRewardComp:update(arg_3_1)
	local var_3_1 = var_0_0:getPlayerStructByUserId(arg_3_1.enemyId or 0)
	local var_3_2 = var_0_0:getEditorStructByComponentId(arg_3_1.componentId or 0)

	if var_3_1 and var_3_2 then
		self.m_playerName:setText(var_3_1:getUserName())
		self.m_editorName:setText(var_3_2:getEditorName())
	end
end

return BattleResultRedCliffRewardComp
