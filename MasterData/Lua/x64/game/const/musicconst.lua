local var_0_0 = {
	MusicNodeHitRating = {
		Perfect = 2,
		PerfectPlus = 3,
		Good = 1,
		Miss = 0
	},
	MusicNodeHitType = {
		Long = 2,
		Short = 1,
		LongPress = 3,
		None = 0
	},
	MusicViewType = {
		V46Resident = 4,
		V210 = 2,
		V51Resident = 5,
		Volume = 0,
		Enternal = 1,
		QWorld = 3
	},
	MusicSpectralType = {
		Mirror = 1,
		Random = 2,
		None = 0
	},
	MusicTrackType = {
		Slope = 1,
		Vertical = 2,
		Constant_Slope = 3
	},
	MusicDiffcult = {
		Hardest = 9,
		Challenge = 3,
		Hard = 2,
		Normal = 1
	},
	MusicLookBackID = {
		ActivityConst.VOLUME_MUSIC,
		ActivityConst.ENTERNAL_MUSIC,
		ActivityConst.ACTIVITY_2_10_MUSIC,
		ActivityConst.ACTIVITY_3_11_MUSIC
	},
	MusicFinishState = {
		Finished = 1,
		NoMistake = 2,
		Unfinished = 0,
		Perfect = 3
	},
	MusicTag = {
		Unfinished = 4,
		Finished = 5,
		New = 1,
		Link = 2,
		Original = 3
	},
	MusicLinkTag = {
		LimitLink = 2,
		Link = 1,
		None = 0
	},
	MusicFilterType = {
		tagFilterKey = "Tag_Filter",
		verFilterKey = "Ver_Filter"
	},
	MusicTrackEnum = {
		Four = 4,
		Five = 5,
		Six = 6
	}
}

var_0_0.MusicTrackSetDefaultKey = {
	[var_0_0.MusicTrackEnum.Four] = {
		"D",
		"F",
		"J",
		"K"
	},
	[var_0_0.MusicTrackEnum.Five] = {
		"D",
		"F",
		"J",
		"K",
		"L"
	},
	[var_0_0.MusicTrackEnum.Six] = {
		"S",
		"D",
		"F",
		"J",
		"K",
		"L"
	}
}
var_0_0.MusicTagTips = {
	[var_0_0.MusicTag.New] = "ACTIVITY_MUSIC_SCREEN_1",
	[var_0_0.MusicTag.Link] = "ACTIVITY_MUSIC_SCREEN_3",
	[var_0_0.MusicTag.Original] = "ACTIVITY_MUSIC_SCREEN_2",
	[var_0_0.MusicTag.Unfinished] = "ACTIVITY_MUSIC_SCREEN_4",
	[var_0_0.MusicTag.Finished] = "ACTIVITY_MUSIC_SCREEN_5"
}
var_0_0.MusicViewRoutesName = {
	[var_0_0.MusicViewType.Volume] = {
		settlement = "volumeMusicSettlement",
		musicStop = "volumeMusicstop",
		musicMain = "/volumeMusicMain",
		musicName = "/volumeMusicGame",
		activityID = ActivityConst.VOLUME_MUSIC
	},
	[var_0_0.MusicViewType.Enternal] = {
		settlement = "enternalMusicSettlement",
		musicStop = "enternalMusicStop",
		musicMain = "/enternalMusicMain",
		musicName = "/enternalMusicGame",
		activityID = ActivityConst.ENTERNAL_MUSIC
	},
	[var_0_0.MusicViewType.V210] = {
		settlement = "V210MusicSettlement",
		musicStop = "V210MusicStop",
		musicMain = "/V210MusicMain",
		musicName = "/V210MusicGame",
		activityID = ActivityConst.ACTIVITY_2_10_MUSIC
	},
	[var_0_0.MusicViewType.QWorld] = {
		settlement = "V210MusicSettlement",
		musicStop = "V210MusicStop",
		musicMain = "/V210MusicMain",
		musicName = "/V210MusicGame",
		activityID = ActivityConst.ACTIVITY_3_11_MUSIC
	},
	[var_0_0.MusicViewType.V46Resident] = {
		settlement = "V210MusicSettlement",
		musicStop = "V210MusicStop",
		musicMain = "/residentMusicGameMainView",
		musicName = "/V210MusicGame",
		activityID = ActivityConst.ACTIVITY_4_6_MUSIC,
		taskID = ActivityConst.ACTIVITY_4_6_MUSIC_TASK
	},
	[var_0_0.MusicViewType.V51Resident] = {
		settlement = "V210MusicSettlement",
		musicStop = "V210MusicStop",
		musicMain = "/residentMusicGameMainView",
		musicName = "/V210MusicGame",
		activityID = ActivityConst.ACTIVITY_5_1_MUSIC,
		taskID = ActivityConst.ACTIVITY_5_1_MUSIC_TASK
	}
}
var_0_0.MusicViewUIName = {
	[var_0_0.MusicViewType.QWorld] = {
		rewardView = "Widget/System/Activity_Resident/Acitvity_MusicUI/Acitvity_MusicRewardUI",
		mainView = "Widget/System/Activity_Resident/Acitvity_MusicUI/Acitvity_MusicMainUI",
		stopView = "Widget/System/Activity_Resident/Acitvity_MusicUI/Acitvity_MusicPromptUI",
		settingView = "Widget/System/Activity_Resident/Acitvity_MusicUI/Acitvity_MusicSetUI",
		gameView = "Widget/System/Activity_Resident/Acitvity_MusicUI/Acitvity_MusicGameUI",
		scoreView = "Widget/System/Activity_Resident/Acitvity_MusicUI/Acitvity_MusicScoreUI"
	},
	[var_0_0.MusicViewType.V46Resident] = {
		rewardView = "Widget/System/Activity_Resident/Acitvity_MusicUI/Acitvity_MusicRewardUI",
		mainView = "Widget/System/Activity_Resident/Acitvity_MusicUI/Acitvity_MusicMainUI",
		stopView = "Widget/System/Activity_Resident/Acitvity_MusicUI/Acitvity_MusicPromptUI",
		settingView = "Widget/System/Activity_Resident/Acitvity_MusicUI/Acitvity_MusicSetUI",
		gameView = "Widget/System/Activity_Resident/Acitvity_MusicUI/Acitvity_MusicGameUI",
		scoreView = "Widget/System/Activity_Resident/Acitvity_MusicUI/Acitvity_MusicScoreUI"
	},
	[var_0_0.MusicViewType.V51Resident] = {
		rewardView = "Widget/System/Activity_Resident/Acitvity_MusicUI/Acitvity_MusicRewardUI",
		mainView = "Widget/System/Activity_Resident/Acitvity_MusicUI/Acitvity_MusicMainUI",
		stopView = "Widget/System/Activity_Resident/Acitvity_MusicUI/Acitvity_MusicPromptUI",
		settingView = "Widget/System/Activity_Resident/Acitvity_MusicUI/Acitvity_MusicSetUI",
		gameView = "Widget/System/Activity_Resident/Acitvity_MusicUI/Acitvity_MusicGameUI",
		scoreView = "Widget/System/Activity_Resident/Acitvity_MusicUI/Acitvity_MusicScoreUI"
	}
}
var_0_0.PCTrackKeyMap = {
	[4] = {
		"D",
		"F",
		"J",
		"K"
	},
	[5] = {
		"D",
		"F",
		"J",
		"K",
		"L"
	},
	[6] = {
		"S",
		"D",
		"F",
		"J",
		"K",
		"L"
	}
}

return var_0_0
