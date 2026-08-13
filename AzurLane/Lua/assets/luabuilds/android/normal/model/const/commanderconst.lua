class = var_0_10000

local var_0_0 = var_0_10000("CommanderConst")

var_0_0.TALENT_POINT_LEVEL = 5
var_0_0.TALENT_POINT = 1
var_0_0.TALENT_ADDITION_NUMBER = 1
var_0_0.TALENT_ADDITION_RATIO = 2
var_0_0.TALENT_ADDITION_BUFF = 3
var_0_0.MAX_TELENT_COUNT = 5
var_0_0.RESET_TALENT_WAIT_TIME = 1
var_0_0.PLAY_MAX_COUNT = 10
var_0_0.MAX_FORMATION_POS = 2
var_0_0.MAX_ABILITY = 255

local var_0_1 = {}

AttributeType = var_0_10002
var_0_1[1] = var_0_10002.Durability
AttributeType = var_2
var_0_1[2] = var_2.Cannon
AttributeType = var_2
var_0_1[3] = var_2.Torpedo
AttributeType = var_2
var_0_1[4] = var_2.AntiAircraft
AttributeType = var_2
var_0_1[5] = var_2.Air
AttributeType = var_2
var_0_1[6] = var_2.Reload
AttributeType = var_2
var_0_1[7] = var_2.Armor
AttributeType = var_2
var_0_1[8] = var_2.Hit
AttributeType = var_2
var_0_1[9] = var_2.Dodge
AttributeType = var_2
var_0_1[10] = var_2.Speed
AttributeType = var_2
var_0_1[11] = var_2.Luck
AttributeType = var_2
var_0_1[12] = var_2.AntiSub
var_0_0.PROPERTIES = var_0_1
var_0_0.DESTROY_ATTR_ID = 202
pg = var_1

local var_0_2 = var_1.gameset.commander_get_cost.description

function var_0_0.getBoxComsume(arg_1_0)
	local var_1_0

	ipairs = var_1_10002

	for iter_1_0, iter_1_1 in var_1_10002(var_0_2) do
		if arg_1_0 < iter_1_1[3] then
			var_1_0 = iter_1_1[1]

			break
		end
	end

	var_1_0 = var_1_0 or var_0_2[#var_0_2][1]
	getProxy = var_2
	GuildProxy = var_3

	local var_1_1 = var_2(var_3)

	if var_2.GetAdditionGuild(var_1_1) then
		var_1_0 = var_1_0 - var_2:getCatBoxGoldAddition()
	end

	math = var_1_1

	return var_1_1.max(var_1_0, 0)
end

var_0_0.MAX_GETBOX_CNT = 0
ipairs = var_2

for iter_0_0, iter_0_1 in var_2(var_0_2) do
	var_0_0.MAX_GETBOX_CNT = var_0_0.MAX_GETBOX_CNT + iter_0_1[3]
end

return var_0_0
