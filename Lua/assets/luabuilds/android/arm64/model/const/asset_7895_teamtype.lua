local TeamType = class("TeamType")

TeamType.Vanguard = "vanguard"
TeamType.Main = "main"
TeamType.Submarine = "submarine"
TeamType.FormShips = "ships"
TeamType.FormCommander = "commander"
TeamType.TeamTypeIndex = {
	TeamType.Vanguard,
	TeamType.Main,
	TeamType.Submarine
}
TeamType.VanguardMax = 3
TeamType.MainMax = 3
TeamType.SubmarineMax = 3

function TeamType:GetTeamShipMax()
	if self == TeamType.Vanguard then
		return TeamType.VanguardMax
	elseif self == TeamType.Main then
		return TeamType.MainMax
	elseif self == TeamType.Submarine then
		return TeamType.SubmarineMax
	end

	return
end

TeamType.TeamPos = {}
TeamType.TeamPos.FLAG_SHIP = "FlagShip"
TeamType.TeamPos.LEADER = "Leader"
TeamType.TeamPos.CENTER = "Center"
TeamType.TeamPos.REAR = "Rear"
TeamType.TeamPos.CONSORT = "Consort"
TeamType.TeamPos.SUB_LEADER = "SubLeader"
TeamType.TeamPos.SUB_CONSORT = "SubConsort"
TeamType.TeamPos.UPPER_CONSORT = "UpperConsort"
TeamType.TeamPos.LOWER_CONSORT = "LowerConsort"

return TeamType
