local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.mulFormationData
local var_0_2 = g.core.model.User.formationData
local var_0_3 = g.core.const.ConstMgr.LineUpConst

return {
	on_S2C_Formation_ChangePosition = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_2:updateFormation(arg_1_2.formation)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEPOSITION, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Formation_ChangeFormation = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			if arg_2_2.tp == g.core.network.proto.TYPE_TREASURE then
				g.core.model.User.treasureData:changeTreasurePos(arg_2_2.id, arg_2_2.pos)
				var_0_2:updateFormation(arg_2_2.formation)
			elseif arg_2_2.tp == g.core.network.proto.TYPE_PET then
				g.core.model.User.petsData:onS2CFormationChangeFormation(arg_2_2)
			elseif arg_2_2.tp == g.core.network.proto.TYPE_PRECIOUS_SUIT then
				var_0_2:updatePreciousSuitFormation(arg_2_2.formation)
			elseif arg_2_2.tp == g.core.network.proto.TYPE_SUCCUBA then
				g.core.model.User.succubaData:onS2CFormationChangeFormation(arg_2_2)
				var_0_2:updateSuccubaFormation(arg_2_2.formation)
			else
				var_0_2:updateFormation(arg_2_2.formation)
				var_0_2:updateAssDataAndSuit(arg_2_2)
				g.core.model.User.rebornData:updateKnightRed()
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Formation_Get = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			local var_3_0 = {}

			for iter_3_0, iter_3_1 in pairs(arg_3_2.formations or {}) do
				var_3_0[iter_3_1.tp] = var_3_0[iter_3_1.tp] or {}

				table.insert(var_3_0[iter_3_1.tp], iter_3_1)
			end

			if var_3_0[var_0_3.MulTeamType.FOG_NIGHTMARE] then
				g.core.model.User.fogNightmareData:getFormationData():updateFormationData(var_3_0[var_0_3.MulTeamType.FOG_NIGHTMARE])
			elseif var_3_0[var_0_3.MulTeamType.GVE] then
				g.core.model.User.gveDataMgr:getGveFormationData():updateFormationData(var_3_0[var_0_3.MulTeamType.GVE])
			elseif var_3_0[var_0_3.MulTeamType.EXPLORATION] then
				g.core.model.User.explorationData:getFormationData():updateFormationData(var_3_0[var_0_3.MulTeamType.EXPLORATION], true)
			elseif var_3_0[var_0_3.MulTeamType.TEAM_BATTLE] then
				g.core.model.User.teamBattleData:getFormationData():updateFormationData(var_3_0[var_0_3.MulTeamType.TEAM_BATTLE], true)
			else
				var_0_1:onS2CFormationGet(arg_3_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FORMATION_GET, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Formation_Save = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			local var_4_0 = {}

			for iter_4_0, iter_4_1 in pairs(arg_4_2.formations or {}) do
				var_4_0[iter_4_1.tp] = var_4_0[iter_4_1.tp] or {}

				table.insert(var_4_0[iter_4_1.tp], iter_4_1)
			end

			if var_4_0[var_0_3.MulTeamType.FOG_NIGHTMARE] then
				g.core.model.User.fogNightmareData:getFormationData():updateFormationByRequestFormations()
			elseif var_4_0[var_0_3.MulTeamType.EXPLORATION] then
				g.core.model.User.explorationData:getFormationData():updateFormationData(var_4_0[var_0_3.MulTeamType.EXPLORATION])
			elseif var_4_0[var_0_3.MulTeamType.TEAM_BATTLE] then
				g.core.model.User.teamBattleData:getFormationData():updateFormationData(var_4_0[var_0_3.MulTeamType.TEAM_BATTLE])
			elseif var_4_0[var_0_3.MulTeamType.GVE] then
				g.core.model.User.gveDataMgr:getGveFormationData():updateFormationData(var_4_0[var_0_3.MulTeamType.GVE])
			else
				var_0_1:onS2CFormationSaveSuccess(arg_4_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FORMATION_SAVE, false, arg_4_1, arg_4_2)
		else
			var_0_1:onS2CFormationSaveFailed(arg_4_2)
			g.core.model.User.explorationData:getFormationData():resetFormationStruct()
			g.core.model.User.gveDataMgr:getGveFormationData():resetFormation()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_ERROR_SAVE, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Formation_FightValue = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			if arg_5_2.tp == var_0_3.MulTeamType.EXPLORATION then
				g.core.model.User.explorationData:getFormationData():onS2CFormationFightValue(arg_5_2)
			elseif arg_5_2.tp == var_0_3.MulTeamType.TEAM_BATTLE then
				g.core.model.User.teamBattleData:getFormationData():onS2CFormationFightValue(arg_5_2)
			else
				var_0_1:onS2CFormationFightValue(arg_5_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FORMATION_FIGHTVALUE, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_Formation_GetOther = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			if arg_6_2.tp == g.core.const.ConstMgr.LineUpConst.MulTeamType.FOG_NIGHTMARE then
				g.core.model.User.fogNightmareData:getFormationData():setOtherFormationData(arg_6_2)
			elseif arg_6_2.tp == g.core.const.ConstMgr.LineUpConst.MulTeamType.CROSS_SERVER_ARENA then
				g.core.model.User.crossServerArenaData:setOtherFormationData(arg_6_2)
			elseif arg_6_2.tp == g.core.const.ConstMgr.LineUpConst.MulTeamType.BLAZING_ARENA then
				g.core.model.User.blazingArenaData:setOtherFormationData(arg_6_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FORMATION_GETOTHER, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_Formation_ModifyName = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			var_0_2:setMainName(arg_7_2.name or "")
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FORMATION_MODIFYNAME, false, arg_7_1, arg_7_2)
		end
	end
}
