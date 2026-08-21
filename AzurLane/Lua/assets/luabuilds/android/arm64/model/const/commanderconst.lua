local var_0_0 = class("CommanderConst")

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
var_0_0.PROPERTIES = {
	AttributeType.Durability,
	AttributeType.Cannon,
	AttributeType.Torpedo,
	AttributeType.AntiAircraft,
	AttributeType.Air,
	AttributeType.Reload,
	AttributeType.Armor,
	AttributeType.Hit,
	AttributeType.Dodge,
	AttributeType.Speed,
	AttributeType.Luck,
	AttributeType.AntiSub
}
var_0_0.DESTROY_ATTR_ID = 202

local var_0_1 = pg.gameset.commander_get_cost.description

function var_0_0.getBoxComsume(arg_1_0)
	local var_1_0

	for iter_1_0, iter_1_1 in ipairs(var_0_1) do
		if arg_1_0 < iter_1_1[3] then
			var_1_0 = iter_1_1[1]

			break
		end
	end

	var_1_0 = var_1_0 or var_0_1[#var_0_1][1]

	local var_1_1 = getProxy(GuildProxy):GetAdditionGuild()

	if var_1_1 then
		var_1_0 = var_1_0 - var_1_1:getCatBoxGoldAddition()
	end

	return math.max(var_1_0, 0)
end

var_0_0.MAX_GETBOX_CNT = 0

for iter_0_0, iter_0_1 in ipairs(pg.gameset.commander_get_cost.description) do
	var_0_0.MAX_GETBOX_CNT = var_0_0.MAX_GETBOX_CNT + iter_0_1[3]
end

return var_0_0
