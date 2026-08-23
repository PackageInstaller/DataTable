local ProtoHandler = import(".ProtoHandler")
local var_0_2 = g.core.model.User.themeData

return {
	on_S2C_ThemeExplore_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			local var_1_0 = var_0_2:getThemeData(arg_1_2.act_id)

			if var_1_0 then
				var_1_0:getExploreData():onNetThemeExploreGetInfo(arg_1_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_EXPLORE_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_ThemeExplore_SaveMapInfo = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			local var_2_0 = var_0_2:getThemeData(arg_2_2.act_id)

			if var_2_0 then
				var_2_0:getExploreData():onSaveExploreData(arg_2_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_EXPLORE_SAVEMAPINFO, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_ThemeExplore_GetMapInfo = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			local var_3_0 = var_0_2:getThemeData(arg_3_2.act_id)

			if var_3_0 then
				var_3_0:getExploreData():onGetExploreMapData(arg_3_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_EXPLORE_GETMAPINFO, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_ThemeExplore_GetBoxAward = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			local var_4_0 = var_0_2:getThemeData(arg_4_2.act_id)

			if var_4_0 then
				var_4_0:getExploreData():onGetExploreBox(arg_4_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_EXPLORE_GETBOXAWARD, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_ThemeExplore_ResetInfo = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			local var_5_0 = var_0_2:getThemeData(arg_5_2.act_id)

			if var_5_0 then
				var_5_0:getExploreData():onResetChapter(arg_5_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_EXPLORE_RESETINFO, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_ThemeExplore_GetTimePower = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			local var_6_0 = var_0_2:getThemeData(arg_6_2.act_id)

			if var_6_0 then
				var_6_0:getExploreData():onGetTimePower(arg_6_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_EXPLORE_GETTIMEPOWER, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_ThemeExplore_HpRecover = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			local var_7_0 = var_0_2:getThemeData(arg_7_2.act_id)

			if var_7_0 then
				var_7_0:getExploreData():onRecoverHpEvent(arg_7_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_EXPLORE_HPRECOVER, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_ThemeExplore_BeginChallenge = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_EXPLORE_BEGINCHALLENGE, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_ThemeExplore_ChallengeFinish = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			local var_9_0 = var_0_2:getThemeData(arg_9_2.act_id)

			if var_9_0 then
				var_9_0:getExploreData():onBattleFinishUpdateHp(arg_9_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_EXPLORE_CHALLENGEFINISH, false, arg_9_1, arg_9_2)
		elseif g.core.battle.BattleProxy:isInBattle() then
			g.core.battle.BattleProxy:exitBattle()
		end
	end,
	on_S2C_ThemeExplore_GetMonsterHp = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_EXPLORE_GETMONSTERHP, false, arg_10_1, arg_10_2)
		end
	end
}
