local var_0_0 = class("Nation")

var_0_0.CM = 0
var_0_0.US = 1
var_0_0.EN = 2
var_0_0.JP = 3
var_0_0.DE = 4
var_0_0.CN = 5
var_0_0.ITA = 6
var_0_0.SN = 7
var_0_0.FF = 8
var_0_0.MNF = 9
var_0_0.FR = 10
var_0_0.NL = 11
var_0_0.LDP = 12
var_0_0.MOT = 96
var_0_0.META = 97
var_0_0.BURIN = 98
var_0_0.SIRE = 99
var_0_0.LINK = 100
var_0_0.IDOL_LINK = 107
var_0_0.YUMIA = 113

function var_0_0.IsLinkType(arg_1_0)
	return arg_1_0 > var_0_0.LINK
end

function var_0_0.IsMeta(arg_2_0)
	return arg_2_0 == var_0_0.META
end

function var_0_0.Nation2Print(arg_3_0)
	var_0_0.prints = var_0_0.prints or {
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

	return var_0_0.prints[arg_3_0]
end

function var_0_0.Nation2Side(arg_4_0)
	var_0_0.side = var_0_0.side or {
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

	return var_0_0.side[arg_4_0]
end

function var_0_0.Nation2BG(arg_5_0)
	var_0_0.bg = var_0_0.bg or {
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

	return var_0_0.bg[arg_5_0]
end

function var_0_0.Nation2Name(arg_6_0)
	var_0_0.nationName = var_0_0.nationName or {
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

	return var_0_0.nationName[arg_6_0]
end

function var_0_0.Nation2facionName(arg_7_0)
	var_0_0.facionName = var_0_0.facionName or {
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

	return var_0_0.facionName[arg_7_0]
end

return var_0_0
