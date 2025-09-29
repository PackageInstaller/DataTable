-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/model/CharacterInfoEnum.lua

module("logic.extensions.characterinformation.model.CharacterInfoEnum", package.seeall)

local CharacterInfoEnum = {}

CharacterInfoEnum.AnchorViewPageType = {
	CarryItem = 1,
	Impression = 2
}
CharacterInfoEnum.UnlockTyp = {
	Ability = 6,
	Height = 3,
	Birth = 5,
	OrganName = 2,
	SpFile2 = 102,
	SpFile3 = 103,
	Area = 7,
	SpFile1 = 101,
	CarryItem2 = 202,
	Name = 1,
	BaseInfo = 8,
	CarryItem4 = 204,
	Weight = 4,
	CarryItem3 = 203,
	CarryItem1 = 201
}
CharacterInfoEnum.Name = 1
CharacterInfoEnum.CV = 2
CharacterInfoEnum.Title = 3
CharacterInfoEnum.OrganName = 4
CharacterInfoEnum.Sex = 5
CharacterInfoEnum.Age = 6
CharacterInfoEnum.Birth = 7
CharacterInfoEnum.Blood = 8
CharacterInfoEnum.Area = 9
CharacterInfoEnum.Height = 10
CharacterInfoEnum.Weight = 11
CharacterInfoEnum.BWH = 12
CharacterInfoEnum.BelongItem = 13
CharacterInfoEnum.Favour = 14
CharacterInfoEnum.Dislike = 15
CharacterInfoEnum.Memory = 16
CharacterInfoEnum.Bodyparts = 17
CharacterInfoEnum.File1 = 18
CharacterInfoEnum.File2 = 19
CharacterInfoEnum.File3 = 20
CharacterInfoEnum.File4 = 21
CharacterInfoEnum.File5 = 22
CharacterInfoEnum.File6 = 23
CharacterInfoEnum.File7 = 24
CharacterInfoEnum.PastInfo = 1
CharacterInfoEnum.Expression = 2
CharacterInfoEnum.Voice = 3
CharacterInfoEnum.VoiceRes = {
	"speech_%d_shangzhen",
	"speech_%d_xuanzhong_01",
	"speech_%d_xuanzhong_02",
	"speech_%d_attack_01",
	"speech_%d_attack_02",
	"speech_%d_special_01",
	"speech_%d_special_02",
	"speech_%d_unique_01",
	"speech_%d_unique_02",
	"speech_%d_unique_03",
	"speech_%d_hit_01",
	"speech_%d_hit_02",
	"speech_%d_death_01",
	"speech_%d_death_02",
	"speech_%d_lizhiqianghua",
	"speech_%d_dilizhi",
	"speech_%d_gaolizhi",
	"speech_%d_shengli",
	"speech_%d_shibai",
	"speech_%d_chouka",
	"speech_%d_shengji",
	"speech_%d_tupo",
	"speech_%d_qinhe",
	"speech_%d_haogan",
	"speech_%d_haoganrenwu",
	"speech_%d_xiedai",
	"speech_%d_heihezi",
	"speech_%d_yangcheng_01",
	"speech_%d_yangcheng_02",
	"speech_%d_yangcheng_03",
	"speech_%d_meiri",
	"speech_%d_zhujiemian_01",
	"speech_%d_zhujiemian_02",
	"speech_%d_zhujiemian_03"
}
CharacterInfoEnum.VoiceResKey = {
	attack_01 = 4,
	chouka = 20,
	xuanzhong_01 = 2,
	gaolizhi = 17,
	hit_02 = 12,
	special_02n = 7,
	unique_01 = 8,
	tupo = 22,
	main_interact_03 = 34,
	shangzhen = 1,
	unique_02 = 9,
	shengji = 21,
	qinhe = 23,
	main_interact_01 = 32,
	haoganrenwu = 25,
	hit_01 = 11,
	xuanzhong_02 = 3,
	special_01 = 6,
	main_interact_02 = 33,
	death_02 = 14,
	shengli = 18,
	yangcheng_01 = 28,
	death_01 = 13,
	heihezi = 27,
	main_login = 31,
	haogan = 24,
	yangcheng_03 = 30,
	attack_02 = 5,
	xiedai = 26,
	unique_03 = 10,
	yangcheng_02 = 29,
	lizhi_enhance = 15,
	shibai = 19,
	dilizhi = 16
}

return CharacterInfoEnum
