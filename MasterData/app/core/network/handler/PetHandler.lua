local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.petsData
local var_0_2 = g.core.model.User.petHandBookData

return {
	on_S2C_Pet_HandbookInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_2:onS2CPetHandbookInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PET_HANDBOOKINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Pet_HandbookActivate = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_2:onS2CPetHandbookActivate(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PET_HANDBOOKACTIVATE, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Pet_HandbookUpgrade = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_2:onS2CPetHandbookUpgrade(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PET_HANDBOOKUPGRADE, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Pet_InheritFormation = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_1:onS2CInheriFormation(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PET_INHERITFORMATION, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Pet_OneKey_LevelUp = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PET_ONEKEY_LEVELUP, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_Pet_StarUp = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PET_STARUP, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_Pet_StageUp = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PET_STAGEUP, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_Pet_UR_HandbookActive = function(arg_8_0, arg_8_1, arg_8_2)
		dump(arg_8_2, "on_S2C_Pet_UR_HandbookActive------------------>")

		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			var_0_2:onS2CURHandbookActive(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PET_UR_HANDBOOKACTIVE, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_Pet_UR_HandbookUpgrade = function(arg_9_0, arg_9_1, arg_9_2)
		dump(arg_9_2, "on_S2C_Pet_UR_HandbookUpgrade------------------>")

		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			var_0_2:onS2CURHandbookUpgrade(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PET_UR_HANDBOOKUPGRADE, false, arg_9_1, arg_9_2)
		end
	end
}
