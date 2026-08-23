local var_0_0 = g.core.config.multi_team_info
local var_0_1 = g.core.model.User.gveDataMgr
local var_0_2 = g.core.model.User.formationData
local var_0_3 = g.core.const.ConstMgr.FormationConst
local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_PresetFormation_Flush = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			if arg_1_2.tp == var_0_3.PRESET_FORMATION_TYPE.MAIN then
				var_0_2:onS2CPreFormationFlush(arg_1_2)
			elseif arg_1_2.tp == var_0_3.PRESET_FORMATION_TYPE.GVE then
				g.core.model.User.gveDataMgr:getGveFormationData():onS2CPreFormationFlush(arg_1_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_FLUSH, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_PresetFormation_Inherit = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_2:onS2CPreFormationInherit(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_INHERIT, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_PresetFormation_Save = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			for iter_3_0, iter_3_1 in ipairs(arg_3_2.ids or {}) do
				local var_3_1 = var_0_0.fetch(iter_3_1)

				if var_3_1 then
					if var_3_1.type == var_0_3.PRESET_FORMATION_TYPE.MAIN then
						var_0_2:onS2CPreFormationSaveById(iter_3_1)
					elseif var_3_1.type == var_0_3.PRESET_FORMATION_TYPE.GVE then
						var_0_1:getGveFormationData():onS2CPreFormationSaveById(iter_3_1)
					end
				end
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_SAVE, false, arg_3_1, arg_3_2)
		else
			var_0_2:onS2CPreFormationSaveError()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_ERROR_SAVE, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_PresetFormation_NameModify = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_2:onS2CPreFormationNameModify(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_NAMEMODIFY, false, arg_4_1, arg_4_2)
		end
	end
}
