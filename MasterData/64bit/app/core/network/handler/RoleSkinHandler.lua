local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.roleSkinData

return {
	on_S2C_SkinPart_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			dump(arg_1_2, "on_S2C_SkinPart_GetInfo")
			var_0_1:onS2CGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SKIN_PART_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_SkinPart_LevelUp = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			dump(arg_2_2, "on_S2C_SkinPart_LevelUp")
			var_0_1:onS2CLevelUp(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SKIN_PART_LEVELUP, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_SkinPart_StageUp = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			dump(arg_3_2, "on_S2C_SkinPart_StageUp")
			var_0_1:onS2CStageUp(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SKIN_PART_STAGEUP, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_SkinPart_Wear = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			dump(arg_4_2, "on_S2C_SkinPart_Wear")
			var_0_1:onS2CWear(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SKIN_PART_WEAR, false, arg_4_1, arg_4_2)
		end
	end
}
