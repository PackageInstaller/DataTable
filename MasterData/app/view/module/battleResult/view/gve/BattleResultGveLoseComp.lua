local var_0_0 = g.core.common.ServerTime
local var_0_2 = g.core.model.User.gveDataMgr
local var_0_3 = g.core.config.massive_monster_team_info
local BattleResultGveLoseComp = class("BattleResultGveLoseComp", require("app.fairyGUI.battleResult.UI_BattleResultGveLoseComp"))

function BattleResultGveLoseComp:ctor()
	self._monsterList = {}

	self.m_monsterList:setVirtual()
	self.m_monsterList:setItemRenderer(handler(self, self._onMonsterListRender))
end

function BattleResultGveLoseComp:update(arg_2_1)
	local var_2_0 = arg_2_1.content or {}
	local var_2_1 = {}

	var_2_1.timeStr = var_0_0:getLeftDHMSFormat(var_2_0.atk_timestamp or 0)

	self.m_timeText:setText(g.core.lang:get(309008, var_2_1))

	if not var_2_0.x or not var_2_0.y then
		return
	end

	local var_2_2 = var_0_3.get(var_0_2:getGveData():getBuildDataByPos({
		x = var_2_0.x,
		y = var_2_0.y
	}).cfg["monster_" .. (var_2_0.wave or 1)])
	local var_2_3 = var_2_0.monster_hp or {}

	for iter_2_0 = 1, 6 do
		if var_2_2["knight_id_" .. iter_2_0] > 0 then
			local var_2_4 = {
				maxHp = 1000
			}

			var_2_4.hp = var_2_3[iter_2_0] or 0
			var_2_4.knightId = var_2_2["knight_id_" .. iter_2_0]

			table.insert(self._monsterList, var_2_4)
		end
	end

	self.m_monsterList:setNumItems(#self._monsterList)
end

function BattleResultGveLoseComp:_onMonsterListRender(arg_3_1, arg_3_2)
	arg_3_2:updateComp(self._monsterList[arg_3_1 + 1])
end

return BattleResultGveLoseComp
