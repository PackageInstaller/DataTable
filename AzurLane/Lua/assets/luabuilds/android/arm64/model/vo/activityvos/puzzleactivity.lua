local var_0_0 = class("PuzzleActivity", import("model.vo.Activity"))

var_0_0.CMD_COMPLETE = 1
var_0_0.CMD_ACTIVATE = 2
var_0_0.CMD_UNLCOK_TIP = 3
var_0_0.CMD_EARN_EXTRA = 4

function var_0_0.GetPicturePuzzleIds(arg_1_0)
	assert(pg.activity_event_picturepuzzle[arg_1_0.id], "Can't Find activity_event_picturepuzzle 's ID : " .. (arg_1_0.id or "NIL"))

	local var_1_0 = Clone(pg.activity_event_picturepuzzle[arg_1_0.id].pickup_picturepuzzle)

	table.insertto(var_1_0, pg.activity_event_picturepuzzle[arg_1_0.id].drop_picturepuzzle)

	return var_1_0
end

return var_0_0
