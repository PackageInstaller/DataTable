local ProtoHandler = import(".ProtoHandler")
local var_0_1
local TowerCommon = require("app.view.module.tower.const.TowerCommon")
local var_0_3 = g.core.event.EventManager
local var_0_4 = g.core.event.enum

return {
	on_S2C_Tower_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1 = TowerCommon:getModelDataByType(arg_1_2.play_type)

			var_0_1:onsS2CTowerGetInfo(arg_1_2)
			var_0_3:dispatchEvent(var_0_4.EVENT_NET_S2C_TOWER_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Tower_ChallengeStageBegin = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_3:dispatchEvent(var_0_4.EVENT_NET_S2C_TOWER_CHALLENGESTAGEBEGIN, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Tower_ChallengeStageFinish = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_1 = TowerCommon:getModelDataByType(arg_3_2.play_type)

			var_0_1:onsS2CChallengeStageFinish(arg_3_2)
			var_0_3:dispatchEvent(var_0_4.EVENT_NET_S2C_TOWER_CHALLENGESTAGEFINISH, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Tower_GetFirstPassInfo = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_3:dispatchEvent(var_0_4.EVENT_NET_S2C_TOWER_GETFIRSTPASSINFO, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Tower_FirstPassAward = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			var_0_1 = TowerCommon:getModelDataByType(arg_5_2.play_type)

			var_0_1:onsS2CFirstPassAward(arg_5_2)
			var_0_3:dispatchEvent(var_0_4.EVENT_NET_S2C_TOWER_FIRSTPASSAWARD, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_Tower_HangupAward = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			var_0_1 = TowerCommon:getModelDataByType(arg_6_2.play_type)

			var_0_1:onsS2CHangupAward(arg_6_2)
			var_0_3:dispatchEvent(var_0_4.EVENT_NET_S2C_TOWER_HANGUPAWARD, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_Tower_HangupQuickAward = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			var_0_3:dispatchEvent(var_0_4.EVENT_NET_S2C_TOWER_HANGUPQUICKAWARD, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_Tower_FastRolling = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			var_0_1 = TowerCommon:getModelDataByType(arg_8_2.play_type)

			var_0_1:onsS2CFastRolling(arg_8_2)
			var_0_3:dispatchEvent(var_0_4.EVENT_NET_S2C_TOWER_FASTROLLING, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_Tower_OnekeyFirstPassAward = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			var_0_1 = TowerCommon:getModelDataByType(arg_9_2.play_type)

			var_0_1:onsS2COneKeyFirstPassAward(arg_9_2)
			var_0_3:dispatchEvent(var_0_4.EVENT_NET_S2C_TOWER_ONEKEYFIRSTPASSAWARD, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_Tower_HelpOneKeyChallenge = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			var_0_1 = TowerCommon:getModelDataByType(arg_10_2.play_type)

			var_0_1:onsS2COneKeyChallenge(arg_10_2)
			var_0_3:dispatchEvent(var_0_4.EVENT_NET_S2C_TOWER_HELPONEKEYCHALLENGE, false, arg_10_1, arg_10_2)
		end
	end
}
