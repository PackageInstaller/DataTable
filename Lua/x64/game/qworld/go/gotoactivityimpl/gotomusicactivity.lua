GotoActivityBase = import("game.qworld.go.gotoActivityImpl.GotoActivityBase")

local var_0_0 = class("GotoMusicActivity", GotoActivityBase)

function var_0_0.OnEnter(arg_1_0, arg_1_1)
	local var_1_0 = ActivityConst.ACTIVITY_3_11_MUSIC

	MusicData:SetPageActivityId(var_1_0)
	JumpTools.OpenPageByJump("/V210MusicMain", {
		activity_id = var_1_0
	})
end

return var_0_0
