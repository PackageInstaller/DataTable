-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_gallery_camp_info.lua

module("logic.config.t_gallery_camp_info", package.seeall)

local title = {
	masterName = 5,
	name = 2,
	icon = 3,
	uiPattern = 14,
	organisation = 13,
	influenceZone = 7,
	industry = 10,
	desc = 8,
	aim = 9,
	amity = 11,
	masterMask = 6,
	hostile = 12,
	id = 1,
	master = 4
}
local dataList = {
	{
		1,
		"OAD",
		"camp_logo_301",
		0,
		"SOL委员会",
		1,
		"禹、高天原",
		"OAD 阵营介绍",
		"OAD 阵营宗旨",
		"产业：深空矿业\r\n产业B：7号孤儿院",
		{
			2,
			5
		},
		{
			7
		},
		{
			1001,
			1002,
			1003,
			1004,
			1005,
			1006,
			1007,
			1008
		},
		""
	},
	{
		2,
		"伊甸之树",
		"camp_logo_302",
		0,
		"愚者",
		1,
		"西格纳斯、雾海",
		"拥抱超自然力的坚定支持者，神话时代教会力量的主要继承者，最正统的超自然力量组织",
		"人类应当也必须拥抱超自然力量，只有神秘才能对抗神秘，也是人类能避免毁灭的唯一之路。",
		"产业A：伊甸之树\r\n产业B：伊甸之树",
		{
			1
		},
		{
			3,
			7
		},
		{
			2001,
			2002,
			2003,
			2004
		},
		""
	},
	{
		3,
		"真理兄弟会",
		"camp_logo_303",
		0,
		"首领",
		1,
		"北海联盟",
		"来自神话时代弥赛亚教会的极端者，他们曾经被超凡力量迫害，因此认为超凡力量是邪恶的，这些人在教会失去权威后依然不肯放弃对超自然力的敌视，认为超自然力会给人类带来毁灭。",
		"人类就是人类，如果通过把人类变成怪物来获得生存，生存下来的也不是人类。未来是属于科学和秩序的，而不是扭曲和未知",
		"产业：斯莫尔尼\r\n产业：烈火酒业\r\n产业：北海特种设备制造局",
		{},
		{
			2
		},
		{
			3001,
			3002,
			3003,
			3004,
			3005,
			3006
		},
		""
	},
	{
		4,
		"白银黎明",
		"camp_logo_304",
		0,
		"父亲",
		1,
		"伊利亚特",
		"内部有严格的等级制度，以“父亲”为首的阶级统治，崇尚完美秩序。",
		"隐藏自己的力量和存在",
		"产业A：白银黎明\r\n产业B：白银黎明",
		{},
		{},
		{
			4001,
			4002,
			4003
		},
		""
	},
	{
		5,
		"诺亚",
		"camp_logo_305",
		0,
		"理事长",
		1,
		"白羽联盟、鸢尾公国、械城",
		"原本是人类最大的电动汽车和卫星制造公司，后因为拆解大量的GROS机械而获得了技术飞跃，成为科技侧核心势力",
		"对人类能对抗超自然生物的可能性表示绝望，认为尝试逃离",
		"产业：keeper保险公司\r\n产业：夸克制药\r\n产业：黑金公司\r\n产业：亚当机器人",
		{
			1
		},
		{},
		{
			5001,
			5002,
			5003,
			5004,
			5005,
			5006,
			5007,
			5008
		},
		""
	},
	{
		6,
		"星空教会",
		"camp_logo_306",
		0,
		"未知",
		1,
		"未知",
		"阿尔法人的组织，为了维护地下冷冻设施的运转，一部分阿尔法人组成星空教会，会每10年唤醒一次，能够苏醒的人如果少于10人就会标注另一些人为教会人员，以此来保证每年都有人能及时维护设备。",
		"未知",
		"未知",
		{},
		{},
		{
			6001
		},
		""
	},
	{
		7,
		"水滴结社",
		"camp_logo_307",
		0,
		"死之国",
		1,
		"万国",
		"D先生因为渴望更加强大而有破坏力的超凡力量，渴望滥用密室回响和崇拜神话生物，而创立了“水滴结社”，本意是“我们现在的力量就像一个小小的水滴，我们应该拥有整个大海。”",
		"疯子和狂信徒，他们不太在意其他人类的生死，甚至并不认为变成堕落生物有问题，认为只是人类尚未找到和神话生物的沟通办法，他们对一些邪神甚至有所崇拜，认为如果能得到这些宇宙中最神秘诡异生物的保佑，人类可能会进化为一种高等生物。",
		"未知",
		{},
		{
			1,
			3
		},
		{
			7001,
			7002,
			7003
		},
		""
	}
}
local t_gallery_camp_info = {}

t_gallery_camp_info.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_gallery_camp_info[v[1]] = v

	setmetatable(v, mt)
end

return t_gallery_camp_info
