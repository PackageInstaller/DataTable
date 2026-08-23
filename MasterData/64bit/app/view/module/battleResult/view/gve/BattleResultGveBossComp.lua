local var_0_0 = g.core.config.monster_team_info
local var_0_1 = g.core.config.monster_info
local var_0_2 = g.core.model.User.gveDataMgr
local BattleResultGveBossComp = class("BattleResultGveBossComp", require("app.fairyGUI.battleResult.UI_BattleResultGveBossComp"))

function BattleResultGveBossComp:ctor()
	self._monsterList = {}

	self.m_monsterList:setVirtual()
	self.m_monsterList:setItemRenderer(handler(self, self._onMonsterListRender))
end

function BattleResultGveBossComp:update(arg_2_1)
	local var_2_0 = arg_2_1.content or {}

	self.m_damageText:setText(var_2_0.damage)

	self._monsterList = {}

	local var_2_1 = var_2_0.boss_info or {}
	local var_2_2 = var_0_2:getGveData():getBossData(var_2_0.boss_id)

	if var_2_2 then
		local var_2_3 = 0
		local var_2_4 = {}

		if var_2_0.challenge_type == 1 then
			var_2_3 = var_2_2:getInfo().boss_team
			var_2_4 = var_2_1.boss_hp or {}
		else
			local var_2_5 = var_2_0.guard_id

			var_2_3 = var_2_2:getInfo()["guard_" .. var_2_0.guard_id]

			for iter_2_0, iter_2_1 in pairs(var_2_1.boss_guard or {}) do
				if iter_2_1.id == var_2_5 then
					var_2_4 = iter_2_1.guard_hp or {}
				end
			end
		end

		local var_2_6 = var_0_0.get(var_2_3, 1)

		for iter_2_2 = 1, 6 do
			if var_2_6["monster_" .. iter_2_2] > 0 then
				local var_2_7 = var_0_1.get(var_2_6["monster_" .. iter_2_2])
				local var_2_8 = {
					info = var_2_7,
					knightId = var_2_7.res_id
				}

				var_2_8.hp = var_2_4[iter_2_2] or 0
				var_2_8.maxHp = var_2_7.initial_hp

				table.insert(self._monsterList, var_2_8)
			end
		end
	end

	self.m_monsterList:setNumItems(#self._monsterList)
end

function BattleResultGveBossComp:_onMonsterListRender(arg_3_1, arg_3_2)
	arg_3_2:updateComp(self._monsterList[arg_3_1 + 1])
end

return BattleResultGveBossComp
