local Nation = class("Nation")

Nation.CM = 0
Nation.US = 1
Nation.EN = 2
Nation.JP = 3
Nation.DE = 4
Nation.CN = 5
Nation.ITA = 6
Nation.SN = 7
Nation.FF = 8
Nation.MNF = 9
Nation.FR = 10
Nation.NL = 11
Nation.LDP = 12
Nation.MOT = 96
Nation.META = 97
Nation.BURIN = 98
Nation.SIRE = 99
Nation.LINK = 100
Nation.IDOL_LINK = 107
Nation.YUMIA = 113

function Nation:IsLinkType()
	return self > Nation.LINK
end

function Nation:IsMeta()
	return self == Nation.META
end

function Nation:Nation2Print()
	Nation.prints = Nation.prints or {
		[0] = "um",
		115,
		"um",
		98,
		"cm",
		106,
		"um",
		114,
		"um",
		99,
		"sr",
		105,
		"um",
		cm = "us",
		en = "jp",
		de = "cn",
		ita = "sn",
		ff = "mnf",
		ff = "nl",
		ldp = 96,
		mot = 113,
		um = 104,
		um = 112,
		um = 97,
		meta = 111,
		um = 102,
		bili = 110,
		um = 103,
		um = 109,
		um = 117,
		um = 108,
		um = 101,
		np = 107
	}

	return Nation.prints[self]
end

function Nation:Nation2Side()
	Nation.side = Nation.side or {
		[0] = "Jp",
		107,
		"Imas",
		115,
		"West",
		98,
		"West",
		106,
		"West",
		114,
		"West",
		105,
		"Jp",
		West = "West",
		West = "Jp",
		West = "Cn",
		West = "West",
		West = "West",
		West = "West",
		West = 113,
		West = 96,
		West = 104,
		West = 112,
		Jp = 97,
		Meta = 111,
		Jp = 102,
		Cn = 110,
		Jp = 103,
		Jp = 109,
		West = 117,
		West = 108,
		Jp = 101
	}

	return Nation.side[self]
end

function Nation:Nation2BG()
	Nation.bg = Nation.bg or {
		[0] = "bg/bg_church",
		107,
		"bg/bg_church_imas",
		115,
		"bg/bg_church",
		98,
		"bg/bg_church",
		106,
		"bg/bg_church",
		114,
		"bg/bg_church",
		105,
		"bg/bg_church",
		["bg/bg_church"] = "bg/bg_church",
		["bg/bg_church"] = "bg/bg_church_jp",
		["bg/bg_church"] = "bg/bg_church_cn",
		["bg/bg_church"] = "bg/bg_church",
		["bg/bg_church"] = "bg/bg_church",
		["bg/bg_church"] = "bg/bg_church",
		["bg/bg_church"] = 113,
		["bg/bg_church"] = 96,
		["bg/bg_church"] = 104,
		["bg/bg_church"] = 112,
		["bg/bg_church"] = 97,
		["bg/bg_church_meta"] = 111,
		["bg/bg_church"] = 102,
		["bg/bg_church"] = 110,
		["bg/bg_church"] = 103,
		["bg/bg_church"] = 109,
		["bg/bg_church"] = 117,
		["bg/bg_church"] = 108,
		["bg/bg_church"] = 101
	}

	return Nation.bg[self]
end

function Nation:Nation2Name()
	Nation.nationName = Nation.nationName or {
		[0] = i18n("word_shipNation_other"),
		i18n("word_shipNation_baiYing"),
		i18n("word_shipNation_huangJia"),
		i18n("word_shipNation_chongYing"),
		i18n("word_shipNation_tieXue"),
		i18n("word_shipNation_dongHuang"),
		i18n("word_shipNation_saDing"),
		i18n("word_shipNation_beiLian"),
		i18n("word_shipNation_ziyou"),
		i18n("word_shipNation_weixi"),
		i18n("word_shipNation_yuanwei"),
		i18n("word_shipNation_yujinwangguo"),
		i18n("word_shipNation_jinghuanlianmeng"),
		[96] = i18n("word_shipNation_mot"),
		[97] = i18n("word_shipNation_meta"),
		[98] = i18n("word_shipNation_other"),
		[101] = i18n("word_shipNation_np"),
		[102] = i18n("word_shipNation_bili"),
		[103] = i18n("word_shipNation_um"),
		[104] = i18n("word_shipNation_ai"),
		[105] = i18n("word_shipNation_holo"),
		[106] = i18n("word_shipNation_doa"),
		[107] = i18n("word_shipNation_imas"),
		[108] = i18n("word_shipNation_ssss"),
		[109] = i18n("word_shipNation_ryza"),
		[110] = i18n("word_shipNation_senran"),
		[111] = i18n("word_shipNation_tolove"),
		[112] = i18n("word_shipNation_brs"),
		[113] = i18n("word_shipNation_yumia"),
		[114] = i18n("word_shipNation_danmachi"),
		[115] = i18n("word_shipNation_dal"),
		[117] = i18n("word_shipNation_nierautomata")
	}

	return Nation.nationName[self]
end

function Nation:Nation2facionName()
	Nation.facionName = Nation.facionName or {
		[0] = i18n("guild_faction_unknown"),
		i18n("guild_faction_blhx"),
		i18n("guild_faction_blhx"),
		i18n("guild_faction_cszz"),
		i18n("guild_faction_cszz"),
		i18n("guild_faction_blhx"),
		i18n("guild_faction_cszz"),
		i18n("guild_faction_blhx"),
		i18n("guild_faction_blhx"),
		i18n("guild_faction_cszz"),
		i18n("guild_faction_blhx"),
		i18n("guild_faction_unknown"),
		i18n("guild_faction_blhx"),
		[96] = i18n("guild_faction_unknown"),
		[97] = i18n("guild_faction_meta"),
		[98] = i18n("guild_faction_unknown"),
		[101] = i18n("guild_faction_unknown"),
		[102] = i18n("guild_faction_unknown"),
		[103] = i18n("guild_faction_unknown"),
		[104] = i18n("guild_faction_unknown"),
		[105] = i18n("guild_faction_unknown"),
		[106] = i18n("guild_faction_unknown"),
		[107] = i18n("guild_faction_unknown"),
		[108] = i18n("guild_faction_unknown"),
		[109] = i18n("guild_faction_unknown"),
		[110] = i18n("guild_faction_unknown"),
		[111] = i18n("guild_faction_unknown"),
		[112] = i18n("guild_faction_unknown"),
		[113] = i18n("guild_faction_unknown"),
		[114] = i18n("guild_faction_unknown"),
		[115] = i18n("guild_faction_unknown"),
		[117] = i18n("guild_faction_unknown")
	}

	return Nation.facionName[self]
end

return Nation
