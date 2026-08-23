local ProtoHandler = import(".ProtoHandler")
local var_0_1 = {}

function var_0_1.on_S2C_Knight_Upgrade(arg_1_0, arg_1_1, arg_1_2)
	if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_UPGRADE, false, arg_1_1, arg_1_2)
	end
end

function var_0_1.on_S2C_Knight_StarIncrease(arg_2_0, arg_2_1, arg_2_2)
	if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
		g.core.model.User.formationData:updateNewAssociationData()

		if g.core.model.User.knightsData:getKnight({
			id = arg_2_2.id
		}):isMaxStar() then
			g.core.model.User.UserTitleData:checkAndShowCommentArea(require("app.view.module.user.const.UserCommentConst").KEYS.KNIGHT_STAR_UP_FULL)
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_STARINCREASE, false, arg_2_1, arg_2_2)
	end
end

function var_0_1.on_S2C_Knight_AdvanceEquip(arg_3_0, arg_3_1, arg_3_2)
	if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_ADVANCEEQUIP, false, arg_3_1, arg_3_2)
	end
end

function var_0_1.on_S2C_Knight_AdvanceUpgrade(arg_4_0, arg_4_1, arg_4_2)
	if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_ADVANCEUPGRADE, false, arg_4_1, arg_4_2)
	end
end

function var_0_1.on_S2C_Knight_AdvanceCompose(arg_5_0, arg_5_1, arg_5_2)
	if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_ADVANCECOMPOSE, false, arg_5_1, arg_5_2)
	end
end

function var_0_1.on_S2C_Knight_AdvanceComposeOneKey(arg_6_0, arg_6_1, arg_6_2)
	if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_ADVANCECOMPOSEONEKEY, false, arg_6_1, arg_6_2)
	end
end

function var_0_1.on_S2C_Knight_StarTrain(arg_7_0, arg_7_1, arg_7_2)
	if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_STARTRAIN, false, arg_7_1, arg_7_2)
	end
end

function var_0_1.on_S2C_Knight_StarTrainConfirm(arg_8_0, arg_8_1, arg_8_2)
	if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_STARTRAINCONFIRM, false, arg_8_1, arg_8_2)
	end
end

function var_0_1.on_S2C_Knight_StarTrainUpgrade(arg_9_0, arg_9_1, arg_9_2)
	if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_STARTRAINUPGRADE, false, arg_9_1, arg_9_2)
	end
end

function var_0_1.on_S2C_Knight_UpgradeOneLevel(arg_10_0, arg_10_1, arg_10_2)
	if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_UPGRADEONELEVEL, false, arg_10_1, arg_10_2)
	end
end

function var_0_1.on_S2C_Knight_OneKey_Upgrade(arg_11_0, arg_11_1, arg_11_2)
	if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_ONEKEY_UPGRADE, false, arg_11_1, arg_11_2)
	end
end

function var_0_1.on_S2C_Knight_Awake_Next(arg_12_0, arg_12_1, arg_12_2)
	if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_AWAKE_NEXT, false, arg_12_1, arg_12_2)
	end
end

function var_0_1.on_S2C_Knight_Awake_Cancel(arg_13_0, arg_13_1, arg_13_2)
	if ProtoHandler:onMsgProcess(arg_13_1, arg_13_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_AWAKE_CANCEL, false, arg_13_1, arg_13_2)
	end
end

function var_0_1.on_S2C_Knight_Pendant_Up(arg_14_0, arg_14_1, arg_14_2)
	if ProtoHandler:onMsgProcess(arg_14_1, arg_14_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_PENDANT_UP, false, arg_14_1, arg_14_2)
	end
end

function var_0_1.on_S2C_Knight_FavorabilityUpgrade(arg_15_0, arg_15_1, arg_15_2)
	if ProtoHandler:onMsgProcess(arg_15_1, arg_15_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_FAVORABILITYUPGRADE, false, arg_15_1, arg_15_2)
		g.core.model.User.knightTissueData:invalidateCollectCache()
	end
end

function var_0_1.on_S2C_Knight_FavorabilityBreak(arg_16_0, arg_16_1, arg_16_2)
	if ProtoHandler:onMsgProcess(arg_16_1, arg_16_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_FAVORABILITYBREAK, false, arg_16_1, arg_16_2)
	end
end

function var_0_1.on_S2C_Knight_FavorabilityOneKeyUpgrade(arg_17_0, arg_17_1, arg_17_2)
	if ProtoHandler:onMsgProcess(arg_17_1, arg_17_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_FAVORABILITYONEKEYUPGRADE, false, arg_17_1, arg_17_2)
		g.core.model.User.knightTissueData:invalidateCollectCache()
	end
end

function var_0_1.on_S2C_Knight_InheritFormation(arg_18_0, arg_18_1, arg_18_2)
	if ProtoHandler:onMsgProcess(arg_18_1, arg_18_2) then
		g.core.model.User.formationData:updateFormation(arg_18_2.formation)
		g.core.model.User.formationData:updateAssDataAndSuit(arg_18_2)
		g.core.model.User.rebornData:updateKnightRed()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_INHERITFORMATION, false, arg_18_1, arg_18_2)
	end
end

function var_0_1.on_S2C_Knight_GetBySource(arg_19_0, arg_19_1, arg_19_2)
	if ProtoHandler:onMsgProcess(arg_19_1, arg_19_2) then
		-- block empty
	end
end

function var_0_1.on_S2C_Knight_MR_SupportUp(arg_20_0, arg_20_1, arg_20_2)
	if ProtoHandler:onMsgProcess(arg_20_1, arg_20_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_MR_SUPPORTUP, false, arg_20_1, arg_20_2)
	end
end

function var_0_1.on_S2C_Knight_MR_SupportActive(arg_21_0, arg_21_1, arg_21_2)
	if ProtoHandler:onMsgProcess(arg_21_1, arg_21_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_MR_SUPPORTACTIVE, false, arg_21_1, arg_21_2)
	end
end

function var_0_1.on_S2C_Knight_MR_SupportSkillUp(arg_22_0, arg_22_1, arg_22_2)
	if ProtoHandler:onMsgProcess(arg_22_1, arg_22_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_MR_SUPPORTSKILLUP, false, arg_22_1, arg_22_2)
	end
end

function var_0_1.on_S2C_Knight_GetFightValue(arg_23_0, arg_23_1, arg_23_2)
	if ProtoHandler:onMsgProcess(arg_23_1, arg_23_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_KNIGHT_GETFIGHTVALUE, false, arg_23_1, arg_23_2)
	end
end

return var_0_1
