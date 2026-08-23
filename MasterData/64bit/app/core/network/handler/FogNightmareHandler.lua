local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.fogNightmareData
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum

return {
	on_S2C_Fog_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1:onS2CGetInfo(arg_1_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Fog_ChooseStage = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_1:onS2CChooseStage(arg_2_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_CHOOSESTAGE, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Fog_ChallengeBegin = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FOG_CHALLENGEBEGIN, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Fog_ChallengeFinish = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_1:onS2CFogChallengeFinish(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FOG_CHALLENGEFINISH, false, arg_4_1, arg_4_2)
		elseif g.core.battle.BattleProxy:isInBattle() then
			g.core.battle.BattleProxy:exitBattle()
		end
	end,
	on_S2C_Fog_Recover = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			var_0_1:onS2CFogRecover(arg_5_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_RECOVER, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_Fog_Back = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			var_0_1:onS2CFogBack(arg_6_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_BACK, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_Fog_ChooseSeal = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			var_0_1:onS2CFogChooseSeal(arg_7_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_CHOOSESEAL, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_Fog_GiveUpSeal = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			var_0_1:getTowerData():setPassCurFloor(true)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_GIVEUPSEAL, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_Fog_Fast = function(arg_9_0, arg_9_1, arg_9_2)
		var_0_1:checkErrorCode(arg_9_2)

		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			var_0_1:onS2CFogFast(arg_9_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_FAST, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_Fog_PhaseAward = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			var_0_1:getTowerData():getPhaseAward(arg_10_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_PHASEAWARD, false, arg_10_1, arg_10_2)
		end
	end,
	on_S2C_Fog_KnightUp = function(arg_11_0, arg_11_1, arg_11_2)
		var_0_1:checkErrorCode(arg_11_2)

		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			var_0_1:getFormationData():updateMemberPoolData(arg_11_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_KNIGHTUP, false, arg_11_1, arg_11_2)
		end
	end,
	on_S2C_Fog_AddKnight = function(arg_12_0, arg_12_1, arg_12_2)
		var_0_1:checkErrorCode(arg_12_2)

		if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
			var_0_1:getFormationData():updateMemberPoolData(arg_12_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_ADDKNIGHT, false, arg_12_1, arg_12_2)
		end
	end,
	on_S2C_Fog_GiveUp = function(arg_13_0, arg_13_1, arg_13_2)
		if ProtoHandler:onMsgProcess(arg_13_1, arg_13_2) then
			var_0_1:onS2CFogGiveUp(arg_13_2)
			var_0_1:getTowerData():clearFrontText()
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_GIVEUP, false, arg_13_1, arg_13_2)
		end
	end,
	on_S2C_Fog_ResetSeals = function(arg_14_0, arg_14_1, arg_14_2)
		if ProtoHandler:onMsgProcess(arg_14_1, arg_14_2) then
			if arg_14_2.floor and arg_14_2.floor > 0 then
				var_0_1:getTalentData():updateRandSealDataMapItem(arg_14_2.floor, arg_14_2.rand_seals)
			else
				var_0_1:getTalentData():setRandSealData(arg_14_2)
			end

			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_RESETSEALS, false, arg_14_1, arg_14_2)
		end
	end,
	on_S2C_Fog_NoticeSeals = function(arg_15_0, arg_15_1, arg_15_2)
		if ProtoHandler:onMsgProcess(arg_15_1, arg_15_2) then
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_NOTICESEALS, false, arg_15_1, arg_15_2)
		end
	end,
	on_S2C_Fog_MakeChoice = function(arg_16_0, arg_16_1, arg_16_2)
		if ProtoHandler:onMsgProcess(arg_16_1, arg_16_2) then
			var_0_1:onS2CFogMakeChoice(arg_16_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_MAKECHOICE, false, arg_16_1, arg_16_2)
		end
	end,
	on_S2C_Fog_DemonConvert = function(arg_17_0, arg_17_1, arg_17_2)
		if ProtoHandler:onMsgProcess(arg_17_1, arg_17_2) then
			var_0_1:onS2CDemonConvert(arg_17_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_DEMONCONVERT, false, arg_17_1, arg_17_2)
		end
	end,
	on_S2C_Fog_UpgradeLevel = function(arg_18_0, arg_18_1, arg_18_2)
		if ProtoHandler:onMsgProcess(arg_18_1, arg_18_2) then
			var_0_1:onS2CUpgradeLevel(arg_18_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_UPGRADELEVEL, false, arg_18_1, arg_18_2)
		end
	end,
	on_S2C_Fog_IdleInfo = function(arg_19_0, arg_19_1, arg_19_2)
		if ProtoHandler:onMsgProcess(arg_19_1, arg_19_2) then
			var_0_1:updateIdleData(arg_19_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_IDLEINFO, false, arg_19_1, arg_19_2)
		end
	end,
	on_S2C_Fog_IdleAward = function(arg_20_0, arg_20_1, arg_20_2)
		if ProtoHandler:onMsgProcess(arg_20_1, arg_20_2) then
			var_0_1:updateIdleData(arg_20_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_IDLEAWARD, false, arg_20_1, arg_20_2)
		end
	end,
	on_S2C_Fog_GuildFloor = function(arg_21_0, arg_21_1, arg_21_2)
		if ProtoHandler:onMsgProcess(arg_21_1, arg_21_2) then
			var_0_1:updateIdleGuildData(arg_21_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_GUILDFLOOR, false, arg_21_1, arg_21_2)
		end
	end,
	on_S2C_Fog_GuildFloorUser = function(arg_22_0, arg_22_1, arg_22_2)
		if ProtoHandler:onMsgProcess(arg_22_1, arg_22_2) then
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_GUILDFLOORUSER, false, arg_22_1, arg_22_2)
		end
	end,
	on_S2C_Fog_Talent_GetInfo = function(arg_23_0, arg_23_1, arg_23_2)
		if ProtoHandler:onMsgProcess(arg_23_1, arg_23_2) then
			var_0_1:updateTalentData(arg_23_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_TALENT_GETINFO, false, arg_23_1, arg_23_2)
		end
	end,
	on_S2C_Fog_Talent_UpgradeNode = function(arg_24_0, arg_24_1, arg_24_2)
		if ProtoHandler:onMsgProcess(arg_24_1, arg_24_2) then
			arg_24_2.isUpgrade = true

			var_0_1:updateTalentData(arg_24_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_TALENT_UPGRADENODE, false, arg_24_1, arg_24_2)
		end
	end,
	on_S2C_Fog_Talent_Reset = function(arg_25_0, arg_25_1, arg_25_2)
		if ProtoHandler:onMsgProcess(arg_25_1, arg_25_2) then
			var_0_1:resetTalentData(arg_25_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_TALENT_RESET, false, arg_25_1, arg_25_2)
		end
	end,
	on_S2C_Fog_NextFloor = function(arg_26_0, arg_26_1, arg_26_2)
		if ProtoHandler:onMsgProcess(arg_26_1, arg_26_2) then
			var_0_1:onS2CNextFloor(arg_26_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_NEXTFLOOR, false, arg_26_1, arg_26_2)
		end
	end,
	on_S2C_Fog_NoticeFirst = function(arg_27_0, arg_27_1, arg_27_2)
		if ProtoHandler:onMsgProcess(arg_27_1, arg_27_2) then
			var_0_1:onS2CUpgradeLevel(arg_27_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_NOTICEFIRST, false, arg_27_1, arg_27_2)
		end
	end,
	on_S2C_Fog_RandSeals = function(arg_28_0, arg_28_1, arg_28_2)
		if ProtoHandler:onMsgProcess(arg_28_1, arg_28_2) then
			var_0_1:getTalentData():setRandSealData(arg_28_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_RANDSEALS, false, arg_28_1, arg_28_2)
		end
	end,
	on_S2C_Fog_UpdateBuff = function(arg_29_0, arg_29_1, arg_29_2)
		if ProtoHandler:onMsgProcess(arg_29_1, arg_29_2) then
			var_0_1:getTowerData():updateBuffDatas(arg_29_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_UPDATEBUFF, false, arg_29_1, arg_29_2)
		end
	end,
	on_S2C_Fog_UpdateKnight = function(arg_30_0, arg_30_1, arg_30_2)
		if ProtoHandler:onMsgProcess(arg_30_1, arg_30_2) then
			var_0_1:onS2CUpdateKnight(arg_30_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_UPDATEKNIGHT, false, arg_30_1, arg_30_2)
		end
	end,
	on_S2C_Fog_NoticeActivity = function(arg_31_0, arg_31_1, arg_31_2)
		if ProtoHandler:onMsgProcess(arg_31_1, arg_31_2) then
			var_0_1:onS2CUpdateAcitivty(arg_31_2.activity or {})
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_NOTICEACTIVITY, false, arg_31_1, arg_31_2)
		end
	end,
	on_S2C_Fog_Talent_Attribute = function(arg_32_0, arg_32_1, arg_32_2)
		if ProtoHandler:onMsgProcess(arg_32_1, arg_32_2) then
			var_0_1:onS2CFogTalentAttr(arg_32_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_TALENT_ATTRIBUTE, false, arg_32_1, arg_32_2)
		end
	end,
	on_S2C_Fog_RandExtraSeals = function(arg_33_0, arg_33_1, arg_33_2)
		if ProtoHandler:onMsgProcess(arg_33_1, arg_33_2) then
			var_0_1:getTowerData():updateExtraKeepsake(arg_33_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_RANDEXTRASEALS, false, arg_33_1, arg_33_2)
		end
	end,
	on_S2C_Fog_ChooseExtraSeal = function(arg_34_0, arg_34_1, arg_34_2)
		if ProtoHandler:onMsgProcess(arg_34_1, arg_34_2) then
			var_0_1:onS2CFogChooseExtraSeal(arg_34_2)
			var_0_1:getTowerData():onOneExtraPassed()
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_CHOOSEEXTRASEAL, false, arg_34_1, arg_34_2)
		end
	end,
	on_S2C_Fog_GiveUpExtraSeal = function(arg_35_0, arg_35_1, arg_35_2)
		if ProtoHandler:onMsgProcess(arg_35_1, arg_35_2) then
			var_0_1:getTowerData():onOneExtraPassed()
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_GIVEUPEXTRASEAL, false, arg_35_1, arg_35_2)
		end
	end,
	on_S2C_Fog_ResetExtraSeals = function(arg_36_0, arg_36_1, arg_36_2)
		if ProtoHandler:onMsgProcess(arg_36_1, arg_36_2) then
			var_0_1:getTowerData():updateExtraKeepsake(arg_36_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_RESETEXTRASEALS, false, arg_36_1, arg_36_2)
		end
	end,
	on_S2C_Fog_GetServerInfos = function(arg_37_0, arg_37_1, arg_37_2)
		if ProtoHandler:onMsgProcess(arg_37_1, arg_37_2) then
			var_0_1:onS2CFogGetServerInfos(arg_37_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_GETSERVERINFOS, false, arg_37_1, arg_37_2)
		end
	end,
	on_S2C_Fog_OneKeySweep = function(arg_38_0, arg_38_1, arg_38_2)
		if ProtoHandler:onMsgProcess(arg_38_1, arg_38_2) then
			var_0_1:onS2CFogOneKeySweep(arg_38_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_ONEKEYSWEEP, false, arg_38_1, arg_38_2)
		end
	end,
	on_S2C_Fog_OneKeyChooseSeal = function(arg_39_0, arg_39_1, arg_39_2)
		if ProtoHandler:onMsgProcess(arg_39_1, arg_39_2) then
			var_0_1:getTalentData():onRemoveRandSealDataMapItem(arg_39_2.floor)
			var_0_1:onS2CFogOneKeyChooseSeal(arg_39_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_ONEKEYCHOOSESEAL, false, arg_39_1, arg_39_2)
		end
	end,
	on_S2C_Fog_StageSkip = function(arg_40_0, arg_40_1, arg_40_2)
		if ProtoHandler:onMsgProcess(arg_40_1, arg_40_2) then
			var_0_1:onS2CFogStageSkip(arg_40_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_FOG_STAGESKIP, false, arg_40_1, arg_40_2)
		end
	end
}
