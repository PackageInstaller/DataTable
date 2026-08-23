local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Storm_Info = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.stormData:updateInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_INFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Storm_Finish_Award = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.stormData:updateFinishAwardInfo(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_FINISH_AWARD, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Storm_StormInfo = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.stormData:updateStormInfo(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_STORMINFO, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Storm_ChallengeBegin = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_CHALLENGEBEGIN, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Storm_ChallengeFinish = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.stormData:updateStormChallenge(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_CHALLENGEFINISH, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_Storm_Award = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.model.User.stormData:updateStormEvent(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_AWARD, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_Storm_Break = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.stormData:updateStormEvent(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_BREAK, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_Storm_Clear = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.model.User.stormData:updateStormClear(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_CLEAR, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_Storm_Reset = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			local var_9_0 = g.core.config.play_num_info.get((g.core.model.User.stormData:getMiddleCityPlayNumId(arg_9_2.storm_id)))

			g.core.model.User.shopData:updatePlayInfo({
				buy_count = 0,
				id = var_9_0.id,
				left_count = var_9_0.reset
			})
			g.core.model.User.stormData:updateStormReset(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_RESET, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_Storm_NotifyFinishStorm = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_NOTIFYFINISHSTORM, false, arg_10_1, arg_10_2)
		end
	end,
	on_S2C_Storm_GetEnemy = function(arg_11_0, arg_11_1, arg_11_2)
		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			g.core.model.User.stormData:updateStormEnemy(arg_11_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_GETENEMY, false, arg_11_1, arg_11_2)
		end
	end,
	on_S2C_Storm_GetSkillInfo = function(arg_12_0, arg_12_1, arg_12_2)
		if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
			g.core.model.User.stormData:updateSkillData(arg_12_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_GETSKILLINFO, false, arg_12_1, arg_12_2)
		end
	end,
	on_S2C_Storm_SkillLvUp = function(arg_13_0, arg_13_1, arg_13_2)
		if ProtoHandler:onMsgProcess(arg_13_1, arg_13_2) then
			g.core.model.User.stormData:updateSkillLvUp(arg_13_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_SKILLLVUP, false, arg_13_1, arg_13_2)
		end
	end,
	on_S2C_Storm_SkillReset = function(arg_14_0, arg_14_1, arg_14_2)
		if ProtoHandler:onMsgProcess(arg_14_1, arg_14_2) then
			g.core.model.User.stormData:resetSkill()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_SKILLRESET, false, arg_14_1, arg_14_2)
		end
	end,
	on_S2C_Storm_GetBattleUser = function(arg_15_0, arg_15_1, arg_15_2)
		if ProtoHandler:onMsgProcess(arg_15_1, arg_15_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_GETBATTLEUSER, false, arg_15_1, arg_15_2)
		end
	end,
	on_S2C_Storm_Finish_Award_OneKey = function(arg_16_0, arg_16_1, arg_16_2)
		if ProtoHandler:onMsgProcess(arg_16_1, arg_16_2) then
			g.core.model.User.stormData:updateFinishAwardInfo(arg_16_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_FINISH_AWARD_ONEKEY, false, arg_16_1, arg_16_2)
		end
	end,
	on_S2C_Storm_OneKey_Clear = function(arg_17_0, arg_17_1, arg_17_2)
		if ProtoHandler:onMsgProcess(arg_17_1, arg_17_2) then
			for iter_17_0, iter_17_1 in ipairs(arg_17_2.storm_awards or {}) do
				g.core.model.User.stormData:updateStormClear(iter_17_1)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_STORM_ONEKEY_CLEAR, false, arg_17_1, arg_17_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.SPIRIT_HELP_NET_ERROR, false, arg_17_1, arg_17_2)
		end
	end
}
