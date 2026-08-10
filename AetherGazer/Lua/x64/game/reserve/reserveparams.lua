local var_0_0 = class("ReserveParams")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.customData = arg_1_4 or {}
	arg_1_0.stageType = arg_1_0.customData.stageType
	arg_1_0.stageID = arg_1_0.customData.stageID
	arg_1_0.reserveType = arg_1_1 or ReserveTools.GetReserveType(arg_1_0.stageType, arg_1_0.stageID)
	arg_1_0.contID = arg_1_2 or ReserveTools.GetContID(arg_1_0.stageType, arg_1_0.stageID)
	arg_1_0.teamIndex = arg_1_3 or ReserveConst.DEFAULT_TEAM_INDEX
	arg_1_0.needDefaultTeam = ReserveTools.NeedDefaultTeam(arg_1_0.stageType, arg_1_0.stageID)
	arg_1_0.filterLockHeroList = {}
end

return var_0_0
