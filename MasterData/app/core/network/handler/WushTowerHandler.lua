local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.wushTowerData

return {
	on_S2C_DeadTower_EnterInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1:onS2CDeadTowerEnterInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DEAD_TOWER_ENTERINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_DeadTower_ChooseGrid = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_1:onS2CDeadTowerChooseGrid(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DEAD_TOWER_CHOOSEGRID, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_DeadTower_BattleStart = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_1:onS2CDeadTowerBattleStart(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DEAD_TOWER_BATTLESTART, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_DeadTower_BattleFinish = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_1:onS2CDeadTowerBattleFinish(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DEAD_TOWER_BATTLEFINISH, false, arg_4_1, arg_4_2)
		elseif g.core.battle.BattleProxy:isInBattle() then
			g.core.battle.BattleProxy:exitBattle()
		end
	end,
	on_S2C_DeadTower_NextGrids = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			var_0_1:onS2CDeadTowerNextGrids(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DEAD_TOWER_NEXTGRIDS, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_DeadTower_GetCard = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			var_0_1:onS2CGetCard(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DEAD_TOWER_GETCARD, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_DeadTower_TaskAward = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			var_0_1:onS2cTaskAward(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DEAD_TOWER_TASKAWARD, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_DeadTower_OneKeySweep = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			var_0_1:onS2cOneKeySweepAward(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DEAD_TOWER_ONEKEYSWEEP, false, arg_8_1, arg_8_2)
		end
	end
}
