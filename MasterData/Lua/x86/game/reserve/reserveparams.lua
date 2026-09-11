local ReserveParams = class("ReserveParams")

function ReserveParams:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.customData = arg_1_4 or {}
	self.stageType = self.customData.stageType
	self.stageID = self.customData.stageID
	self.reserveType = arg_1_1 or ReserveTools.GetReserveType(self.stageType, self.stageID)
	self.contID = arg_1_2 or ReserveTools.GetContID(self.stageType, self.stageID)
	self.teamIndex = arg_1_3 or ReserveConst.DEFAULT_TEAM_INDEX
	self.needDefaultTeam = ReserveTools.NeedDefaultTeam(self.stageType, self.stageID)
	self.filterLockHeroList = {}
end

return ReserveParams
