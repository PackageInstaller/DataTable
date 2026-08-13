pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "equip_data_code") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "equip_data_code"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.equip_data_code = var_0_2
pg = var_0

local var_0_3 = var_0.equip_data_code

var_0_3.all = {
	"WAVE",
	"GUID",
	"ASW",
	"SCA",
	"NA",
	"FP",
	"AIR",
	"VOL",
	"BOMB",
	"SRG",
	"LRG",
	"NORM",
	"LOCK",
	"TRP"
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.equip_data_code = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.equip_data_code

	var_1_0.WAVE = {
		text = "/轮",
		code = "WAVE"
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.equip_data_code

	var_1_1.GUID = {
		text = "制导",
		code = "GUID"
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.equip_data_code

	var_1_2.ASW = {
		text = "反潜",
		code = "ASW"
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.equip_data_code

	var_1_3.SCA = {
		text = "散射",
		code = "SCA"
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.equip_data_code

	var_1_4.NA = {
		text = "无",
		code = "NA"
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.equip_data_code

	var_1_5.FP = {
		text = "炮击",
		code = "FP"
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.equip_data_code

	var_1_6.AIR = {
		text = "空战",
		code = "AIR"
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.equip_data_code

	var_1_7.VOL = {
		text = "跨射",
		code = "VOL"
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.equip_data_code

	var_1_8.BOMB = {
		text = "轰炸",
		code = "BOMB"
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.equip_data_code

	var_1_9.SRG = {
		text = "近程",
		code = "SRG"
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.equip_data_code

	var_1_10.LRG = {
		text = "远程",
		code = "LRG"
	}
	pg = var_1_10

	local var_1_11 = var_1_10.base.equip_data_code

	var_1_11.NORM = {
		text = "通常",
		code = "NORM"
	}
	pg = var_1_11

	local var_1_12 = var_1_11.base.equip_data_code

	var_1_12.LOCK = {
		text = "锁定",
		code = "LOCK"
	}
	pg = var_1_12
	var_1_12.base.equip_data_code.TRP = {
		text = "雷击",
		code = "TRP"
	}

	return
end)()

return
