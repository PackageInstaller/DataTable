local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Equipment_Upgrade = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.formationData:generateNewEquipMasterData()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EQUIPMENT_UPGRADE, false, arg_1_1, arg_1_2)
		else
			g.core.model.User.equipmentData:setLazy(false)
		end
	end,
	on_S2C_Equipment_Refining = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.formationData:generateNewEquipMasterData()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EQUIPMENT_REFINING, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Equipment_RefiningOneLevel = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.formationData:generateNewEquipMasterData()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EQUIPMENT_REFININGONELEVEL, false, arg_3_1, arg_3_2, true)
		end
	end,
	on_S2C_Equipment_Glyph = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EQUIPMENT_GLYPH, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Equipment_Resonance_Up = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.formationData:generateNewEquipMasterData()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EQUIPMENT_RESONANCE_UP, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_Equipment_Cast = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EQUIPMENT_CAST, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_Equipment_InheritFormation = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.equipmentData:onS2CEquipInheritFormation(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EQUIPMENT_INHERITFORMATION, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_Equipment_MagicalStage_Up = function(arg_8_0, arg_8_1, arg_8_2)
		dump(arg_8_2)

		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.model.User.equipmentData:onS2CEquipmentMagicalStageUp(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EQUIPMENT_MAGICALSTAGE_UP, false, arg_8_1, arg_8_2)
		end
	end
}
