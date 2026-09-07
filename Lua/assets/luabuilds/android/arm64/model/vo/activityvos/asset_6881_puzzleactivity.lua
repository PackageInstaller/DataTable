local PuzzleActivity = class("PuzzleActivity", import("model.vo.Activity"))

PuzzleActivity.CMD_COMPLETE = 1
PuzzleActivity.CMD_ACTIVATE = 2
PuzzleActivity.CMD_UNLCOK_TIP = 3
PuzzleActivity.CMD_EARN_EXTRA = 4

function PuzzleActivity:GetPicturePuzzleIds()
	assert(pg.activity_event_picturepuzzle[self.id], "Can't Find activity_event_picturepuzzle 's ID : " .. (self.id or "NIL"))

	local var_1_0 = Clone(pg.activity_event_picturepuzzle[self.id].pickup_picturepuzzle)

	table.insertto(var_1_0, pg.activity_event_picturepuzzle[self.id].drop_picturepuzzle)

	return var_1_0
end

return PuzzleActivity
