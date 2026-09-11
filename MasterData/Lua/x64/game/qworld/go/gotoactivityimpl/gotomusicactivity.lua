GotoActivityBase = import("game.qworld.go.gotoActivityImpl.GotoActivityBase")

local GotoMusicActivity = class("GotoMusicActivity", GotoActivityBase)

function GotoMusicActivity:OnEnter(arg_1_1)
	MusicData:SetPageActivityId(ActivityConst.ACTIVITY_3_11_MUSIC)
	JumpTools.OpenPageByJump("/V210MusicMain", {
		activity_id = ActivityConst.ACTIVITY_3_11_MUSIC
	})
end

return GotoMusicActivity
