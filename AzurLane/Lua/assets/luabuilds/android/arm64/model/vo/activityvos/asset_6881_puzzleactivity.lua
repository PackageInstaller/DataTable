class = var_0_10000

local var_0_0 = "PuzzleActivity"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.Activity"))

var_0_1.CMD_COMPLETE = 1
var_0_1.CMD_ACTIVATE = 2
var_0_1.CMD_UNLCOK_TIP = 3
var_0_1.CMD_EARN_EXTRA = 4

function var_0_1.GetPicturePuzzleIds(arg_1_0)
	local var_1_0 = arg_1_0.id

	pg = var_1_10002

	local var_1_1 = var_1_10002.activity_event_picturepuzzle[var_1_0]

	assert = var_1_10003

	var_1_10003(var_1_1, "Can't Find activity_event_picturepuzzle 's ID : " .. (var_1_0 or "NIL"))

	Clone = var_1_10003

	local var_1_2 = var_1_10003(var_1_1.pickup_picturepuzzle)

	table = var_1_10004

	var_1_10004.insertto(var_1_2, var_1_1.drop_picturepuzzle)

	return var_1_2
end

return var_0_1
