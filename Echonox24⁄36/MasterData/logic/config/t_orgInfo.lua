-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_orgInfo.lua

module("logic.config.t_orgInfo", package.seeall)

local title = {
	OrganizationId = 2,
	name = 3,
	id = 1
}
local dataList = {
	{
		0,
		"",
		"无阵营"
	},
	{
		1,
		"icon_js_oad",
		"天文台"
	},
	{
		2,
		"icon_js_ydzs",
		"伊甸之树"
	},
	{
		3,
		"icon_js_zlhxd",
		"真理"
	},
	{
		4,
		"icon_js_bylm",
		"白银黎明"
	},
	{
		5,
		"icon_js_yn",
		"诺亚"
	},
	{
		6,
		"icon_js_xkjh",
		"星空"
	},
	{
		7,
		"icon_js_sdjs",
		"水滴"
	},
	{
		8,
		"icon_js_gey",
		"7号孤儿院"
	},
	{
		9,
		"icon_js_chk",
		"CHICKEN KING"
	},
	{
		10,
		"icon_js_x-cat",
		"X-CAT"
	},
	{
		11,
		"icon_js_kpwjj",
		"壳牌挖掘机"
	},
	{
		12,
		"icon_js_lhjy",
		"烈火酒业"
	},
	{
		13,
		"icon_js_slmmy",
		"所罗门贸易"
	},
	{
		14,
		"icon_js_xzbwg",
		"星之博物馆"
	},
	{
		15,
		"icon_js_ydjqr",
		"亚当机器人"
	},
	{
		16,
		"icon_js_myzt",
		"命运之瞳"
	},
	{
		17,
		"icon_js_fxhsys",
		"泛星海实验室"
	},
	{
		18,
		"icon_js_flydc",
		"奉灵院道场"
	},
	{
		19,
		"icon_js_kkzy",
		"夸克制药"
	},
	{
		20,
		"icon_js_danss",
		"狄奥尼索斯"
	},
	{
		21,
		"icon_js_mt",
		"门徒"
	},
	{
		22,
		"icon_js_ysy",
		"约书亚"
	},
	{
		23,
		"icon_js_edps",
		"厄迪普斯"
	},
	{
		24,
		"icon_js_ylsb",
		"伊丽莎白"
	},
	{
		25,
		"icon_js_ty",
		"提亚"
	},
	{
		26,
		"icon_js_pai",
		"π"
	},
	{
		27,
		"icon_js_jgz",
		"监管者"
	},
	{
		28,
		"icon_js_nszz",
		"南十字座"
	},
	{
		29,
		"icon_js_skky",
		"深空矿业"
	},
	{
		30,
		"icon_js_spr",
		"审判日"
	},
	{
		31,
		"icon_js_jsz",
		"校时者"
	},
	{
		32,
		"icon_js_ycxzzx",
		"异常修正中心"
	},
	{
		33,
		"icon_js_jz",
		"家具序列"
	},
	{
		34,
		"icon_js_qs",
		"亲属序列"
	},
	{
		35,
		"icon_js_yr",
		"佣人序列"
	},
	{
		36,
		"icon_js_kpbx",
		"Keeper保险"
	},
	{
		37,
		"icon_js_msc",
		"秘书处"
	},
	{
		38,
		"icon_js_nygyyjs",
		"诺亚工业研究所"
	},
	{
		39,
		"icon_js_bhdyst",
		"北海第一师团"
	},
	{
		40,
		"icon_js_bhzzj",
		"北海特种装备制造局"
	},
	{
		41,
		"icon_js_bhzzst",
		"北海装甲师团"
	},
	{
		42,
		"icon_js_smen",
		"斯莫尔尼"
	}
}
local t_orgInfo = {}

t_orgInfo.dataList = dataList

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
	t_orgInfo[v[1]] = v

	setmetatable(v, mt)
end

return t_orgInfo
