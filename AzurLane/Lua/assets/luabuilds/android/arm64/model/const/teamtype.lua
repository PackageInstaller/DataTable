class = var_0_10000

local var_0_0 = var_0_10000("TeamType")

var_0_0.Vanguard = "vanguard"
var_0_0.Main = "main"
var_0_0.Submarine = "submarine"
var_0_0.FormShips = "ships"
var_0_0.FormCommander = "commander"
var_0_0.TeamTypeIndex = {
	var_0_0.Vanguard,
	var_0_0.Main,
	var_0_0.Submarine
}
var_0_0.VanguardMax = 3
var_0_0.MainMax = 3
var_0_0.SubmarineMax = 3

function var_0_0.GetTeamShipMax(arg_1_0)
	if arg_1_0 == var_0_0.Vanguard then
		return var_0_0.VanguardMax
	elseif arg_1_0 == var_0_0.Main then
		return var_0_0.MainMax
	elseif arg_1_0 == var_0_0.Submarine then
		return var_0_0.SubmarineMax
	end

	return
end

var_0_0.TeamPos = {}
var_0_0.TeamPos.FLAG_SHIP = "FlagShip"
var_0_0.TeamPos.LEADER = "Leader"
var_0_0.TeamPos.CENTER = "Center"
var_0_0.TeamPos.REAR = "Rear"
var_0_0.TeamPos.CONSORT = "Consort"
var_0_0.TeamPos.SUB_LEADER = "SubLeader"
var_0_0.TeamPos.SUB_CONSORT = "SubConsort"
var_0_0.TeamPos.UPPER_CONSORT = "UpperConsort"
var_0_0.TeamPos.LOWER_CONSORT = "LowerConsort"

return var_0_0
