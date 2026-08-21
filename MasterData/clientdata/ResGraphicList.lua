-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResGraphicList.lua

local RT = {}

RT[1] = {
	-125,
	-130
}
RT[2] = {
	0,
	-250
}
RT[3] = {
	-131,
	-162
}
RT[4] = {
	-147,
	-308
}

local Data = {
	{
		{
			icon_path = "NoAlpha/PlayerGuide/Page/PageSupport1",
			id = 1,
			step = 1,
			content = Lang.get(4142),
			pos = RT[2],
			title = Lang.get(4143),
			title_pos = RT[1]
		},
		{
			step = 2,
			icon_path = "NoAlpha/PlayerGuide/Page/PageSupport2",
			id = 1,
			effect_path = "Effects/UI/efx_ui_Novice_guide.prefab",
			content = Lang.get(4144),
			pos = RT[2],
			title = Lang.get(4143),
			title_pos = RT[1]
		},
		{
			step = 3,
			icon_path = "NoAlpha/PlayerGuide/Page/PageSupport2",
			id = 1,
			effect_path = "Effects/UI/efx_ui_Novice_guide_1.prefab",
			content = Lang.get(4145),
			pos = RT[2],
			title = Lang.get(4146),
			title_pos = RT[1]
		}
	},
	{
		{
			movie_path = "Videos/teach_2_01.mp4",
			icon_path = "NoAlpha/PlayerGuide/SetTeamPage/SetTeamPage02",
			id = 2,
			step = 1,
			content = Lang.get(33397),
			pos = RT[4],
			title = Lang.get(33398),
			title_pos = RT[3]
		},
		{
			step = 2,
			icon_path = "NoAlpha/PlayerGuide/SetTeamPage/SetTeamPage01",
			id = 2,
			effect_path = "Effects/UI/efx_ui_Novice_guide2_1.prefab",
			content = Lang.get(33399),
			pos = RT[4],
			title = Lang.get(33400),
			title_pos = RT[3]
		}
	},
	{
		{
			movie_path = "Videos/teach_2_22.mp4",
			icon_path = "NoAlpha/PlayerGuide/SetTeamPage/SetTeamPage03",
			id = 3,
			step = 1,
			content = Lang.get(33401),
			pos = RT[4],
			title = Lang.get(33398),
			title_pos = RT[3]
		},
		{
			step = 2,
			icon_path = "NoAlpha/PlayerGuide/SetTeamPage/SetTeamPage05",
			id = 3,
			effect_path = "Effects/UI/efx_ui_Novice_guide2_2.prefab",
			content = Lang.get(33402),
			pos = RT[4],
			title = Lang.get(33400),
			title_pos = RT[3]
		}
	},
	{
		{
			movie_path = "Videos/teach_4_04.mp4",
			icon_path = "NoAlpha/PlayerGuide/SetTeamPage/SetTeamPage04",
			id = 4,
			step = 1,
			content = Lang.get(33403),
			pos = RT[4],
			title = Lang.get(33398),
			title_pos = RT[3]
		},
		{
			step = 2,
			icon_path = "NoAlpha/PlayerGuide/SetTeamPage/SetTeamPage06",
			id = 4,
			effect_path = "Effects/UI/efx_ui_Novice_guide2_3.prefab",
			content = Lang.get(33404),
			pos = RT[4],
			title = Lang.get(33400),
			title_pos = RT[3]
		}
	}
}

return Data
