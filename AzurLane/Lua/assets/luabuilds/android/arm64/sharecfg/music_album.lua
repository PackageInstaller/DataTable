pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "music_album") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "music_album"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.music_album = var_0_2
pg = var_0

local var_0_3 = var_0.music_album

var_0_3.all = {
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	10
}
pg = var_0_3

local var_0_4 = var_0_3.music_album

var_0_4.get_id_list_by_album_name = {
	启航之时 = {
		5
	},
	奏响鸢尾之歌 = {
		10
	},
	弧光 = {
		9
	},
	海风与夏日的无人岛 = {
		4
	},
	清茶氤氲 = {
		6
	},
	湮烬尘墟 = {
		8
	},
	神圣的悲喜剧 = {
		2
	},
	空相交汇点 = {
		3
	},
	翩若飞仙 = {
		7
	},
	["铁血、音符&誓言"] = {
		1
	}
}
pg = var_0_4
pg = var_1

local var_0_5

if not var_1.base then
	var_0_5 = {}
end

var_0_4.base = var_0_5
pg = var_0_4
var_0_4.base.music_album = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.music_album

	var_1_0[1] = {
		order = 5,
		cover = "MusicCover1",
		album_name = "铁血、音符&誓言"
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.music_album

	var_1_1[2] = {
		order = 4,
		cover = "MusicCover2",
		album_name = "神圣的悲喜剧"
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.music_album

	var_1_2[3] = {
		order = 3,
		cover = "MusicCover3",
		album_name = "空相交汇点"
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.music_album

	var_1_3[4] = {
		order = 2,
		cover = "MusicCover4",
		album_name = "海风与夏日的无人岛"
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.music_album

	var_1_4[5] = {
		order = 1,
		cover = "MusicCover5",
		album_name = "启航之时"
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.music_album

	var_1_5[6] = {
		order = 6,
		cover = "MusicCover6",
		album_name = "清茶氤氲"
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.music_album

	var_1_6[7] = {
		order = 7,
		cover = "MusicCover7",
		album_name = "翩若飞仙"
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.music_album

	var_1_7[8] = {
		order = 8,
		cover = "MusicCover8",
		album_name = "湮烬尘墟"
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.music_album

	var_1_8[9] = {
		order = 9,
		cover = "MusicCover9",
		album_name = "弧光"
	}
	pg = var_1_8
	var_1_8.base.music_album[10] = {
		order = 10,
		cover = "MusicCover10",
		album_name = "奏响鸢尾之歌"
	}

	return
end)()

return
