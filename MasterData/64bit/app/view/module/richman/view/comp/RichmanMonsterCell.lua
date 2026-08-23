local var_0_0 = g.core.config.richman_monster_info
local var_0_1 = g.core.model.User.richmanData
local RichmanMonsterCell = class("RichmanMonsterCell", require("app.fairyGUI.richman.UI_RichmanMonsterCell"))

function RichmanMonsterCell:ctor()
	self.m_monsterIconList:setVirtual()
	self.m_monsterIconList:setItemRenderer(handler(self, self.onRichManMonsterRenderer))
	self.m_challengeBtn:addClickListener(handler(self, self.onClickChallenge))
end

function RichmanMonsterCell:onRichManMonsterCellRenderer(arg_2_1)
	self._monsterData = arg_2_1

	local var_2_0 = var_0_0.get(arg_2_1.value)
	local var_2_1 = g.core.config.massive_monster_team_info.get(var_2_0.monster_id)

	self.m_fightValueText:setText(var_2_1.fight)
	self.m_nameTxt:setText(var_2_0.name)

	self._monsterList = self:getMonsterTeam(var_2_1)

	self.m_monsterIconList:setNumItems(#self._monsterList)
	self.m_canSkipController:setSelectedIndex(g.core.model.User:checkUserSkipBattle(g.core.model.User:getFightValue(), var_2_1.fight, 2) and 1 or 0)
end

function RichmanMonsterCell:getMonsterTeam(arg_3_1)
	local var_3_0 = {}

	for iter_3_0 = 1, 6 do
		if arg_3_1["knight_id_" .. iter_3_0] > 0 then
			var_3_0[iter_3_0] = g.core.config.knight_info.get(arg_3_1["knight_id_" .. iter_3_0])
		end
	end

	return var_3_0
end

function RichmanMonsterCell:onRichManMonsterRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateRichmanMonster(self._monsterList[arg_4_1 + 1])
end

function RichmanMonsterCell:onClickChallenge()
	if self._monsterData and var_0_1:checkChallengeTime(self._monsterData.unique_id) then
		g.core.network.GameNetProxy:send_C2S_RichMan_EventProcess({
			unique_id = self._monsterData.unique_id
		})
	end
end

return RichmanMonsterCell
