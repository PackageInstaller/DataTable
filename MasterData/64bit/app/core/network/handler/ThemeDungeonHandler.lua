local ProtoHandler = import(".ProtoHandler")
local var_0_2 = g.core.model.User.themeData

return {
	on_S2C_ThemeDungeon_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			local var_1_0 = var_0_2:getThemeData(arg_1_2.id)

			if var_1_0 then
				var_1_0:getDungeonData():onNetThemeDungeonGetInfo(arg_1_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_DUNGEON_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_ThemeDungeon_BeginChallenge = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_DUNGEON_BEGINCHALLENGE, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_ThemeDungeon_ChallengeFinish = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			local var_3_0 = var_0_2:getThemeData(arg_3_2.act_id)

			if var_3_0 then
				var_3_0:getDungeonData():onNetThemeDungeonChallengeFinish(arg_3_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_DUNGEON_CHALLENGEFINISH, false, arg_3_1, arg_3_2)
		elseif g.core.battle.BattleProxy:isInBattle() then
			g.core.battle.BattleProxy:exitBattle()
		end
	end,
	on_S2C_ThemeDungeon_GetChapterBox = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			local var_4_0 = var_0_2:getThemeData(arg_4_2.act_id)

			if var_4_0 then
				var_4_0:getDungeonData():onNetThemeDungeonGetChapterBox(arg_4_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_DUNGEON_GETCHAPTERBOX, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_ThemeDungeon_GetPlot = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			local var_5_0 = var_0_2:getThemeData(arg_5_2.act_id)

			if var_5_0 then
				var_5_0:getDungeonData():onNetThemeDungeonGetPlot(arg_5_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_DUNGEON_GETPLOT, false, arg_5_1, arg_5_2)
		end
	end
}
