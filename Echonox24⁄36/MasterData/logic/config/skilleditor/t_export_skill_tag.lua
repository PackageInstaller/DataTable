-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/skilleditor/t_export_skill_tag.lua

module("logic.config.skilleditor.t_export_skill_tag", package.seeall)

local configData = {
	{
		name = "测试一哈",
		type = 2,
		remarks = "无",
		id = 1001,
		desc = "2333",
		skillDescKey = "yuehuan1",
		typeName = "MoonRing",
		tagType = "效果实例",
		param = {
			critical = "NO",
			damageRate = 3,
			count = 3,
			code = 11003,
			referRate = 2,
			referAtr = 51,
			damageType = 1,
			shape = {
				type = "Rhombus",
				range = 2
			}
		}
	},
	{
		name = "233",
		type = 2,
		remarks = "",
		id = 1002,
		desc = "",
		skillDescKey = "",
		typeName = "Chase",
		tagType = "效果实例",
		param = {
			critical = "NO",
			triggerMinor = "NO",
			count = 1,
			code = 11002,
			skillType = 1,
			strengthen = "NO"
		}
	},
	{
		name = "测试振荡",
		type = 2,
		remarks = "3圈振荡",
		id = 1003,
		desc = "对自身周围3圈内的敌方造成100%的物理伤害,重复3次",
		skillDescKey = "",
		typeName = "MoonRing",
		tagType = "效果实例",
		param = {
			critical = "NO",
			damageRate = 1,
			count = 3,
			code = 11003,
			referRate = 1,
			referAtr = 51,
			damageType = 1,
			shape = {
				type = "Circle",
				range = 5
			}
		}
	},
	{
		name = "追击",
		type = 2,
		remarks = "标准追击",
		id = 1004,
		desc = "攻击后对敌方再使用1次普攻",
		skillDescKey = "追击",
		typeName = "Chase",
		tagType = "效果实例",
		param = {
			critical = "NO",
			triggerMinor = "YES",
			count = 1,
			code = 11002,
			skillType = 1,
			strengthen = "NO"
		}
	},
	{
		name = "测试振荡",
		type = 2,
		remarks = "1圈振荡",
		id = 1005,
		desc = "对自身周围1圈内的单位造成伤害",
		skillDescKey = "",
		typeName = "MoonRing",
		tagType = "效果实例",
		param = {
			critical = "YES",
			damageRate = 1,
			count = 1,
			code = 11003,
			referRate = 1,
			referAtr = 51,
			damageType = 1,
			shape = {
				type = "Circle",
				range = 1
			}
		}
	},
	{
		name = "测试振荡",
		type = 2,
		remarks = "2圈振荡",
		id = 1006,
		desc = "2圈振荡",
		skillDescKey = "",
		typeName = "MoonRing",
		tagType = "效果实例",
		param = {
			critical = "NO",
			damageRate = 1,
			count = 1,
			code = 11003,
			referRate = 1,
			referAtr = 51,
			damageType = 1,
			shape = {
				type = "Circle",
				range = 2
			}
		}
	},
	{
		name = "测试追击",
		type = 2,
		remarks = "",
		id = 1007,
		desc = "测试用追击,使用必杀追击2次",
		skillDescKey = "",
		typeName = "Chase",
		tagType = "效果实例",
		param = {
			critical = "NO",
			triggerMinor = "YES",
			count = 2,
			code = 11002,
			skillType = 3,
			strengthen = "NO"
		}
	},
	{
		name = "振荡",
		type = 2,
		remarks = "标准振荡",
		id = 1008,
		desc = "对自身周围1圈内的敌方单位造成85%物理伤害",
		skillDescKey = "振荡",
		typeName = "MoonRing",
		tagType = "效果实例",
		param = {
			critical = "NO",
			damageRate = 0.85,
			count = 1,
			code = 11003,
			referRate = 1,
			referAtr = 51,
			damageType = 1,
			shape = {
				type = "Circle",
				range = 1
			}
		}
	},
	{
		name = "超感",
		type = 2,
		remarks = "标准超感",
		id = 1009,
		desc = "对目标周围1格内的敌方单位造成100%法术伤害",
		skillDescKey = "超感",
		typeName = "Bomb",
		tagType = "效果实例",
		param = {
			critical = "NO",
			damageRate = 1,
			count = 1,
			code = 11006,
			referRate = 1,
			referAtr = 53,
			damageType = 2,
			shape = {
				type = "Rhombus",
				range = 1
			}
		}
	},
	{
		name = "援护",
		type = 2,
		remarks = "标准援护",
		id = 1010,
		desc = "恢复自身周围1格内的我方单位相当于自身75%以太的血量",
		skillDescKey = "援护",
		typeName = "Assist",
		tagType = "效果实例",
		param = {
			code = 11007,
			count = 1,
			referRate = 0.75,
			referAtr = 53,
			shape = {
				type = "Rhombus",
				range = 1
			}
		}
	},
	{
		name = "锥刺",
		type = 2,
		remarks = "标准锥刺",
		id = 1011,
		desc = "对目标造成相当于自身200%防御的真实伤害",
		skillDescKey = "锥刺",
		typeName = "BoreSpine",
		tagType = "效果实例",
		param = {
			code = 11008,
			damageRate = 2,
			count = 1,
			referRate = 1,
			referAtr = 52,
			damageType = 3,
			shape = {
				type = "Point",
				range = 0
			}
		}
	},
	{
		name = "弧光",
		type = 2,
		remarks = "标准弧光",
		id = 1012,
		desc = "对目标造成75%物理伤害后，弹射向目标周围2格内的随机单位，总共可弹射2次，每次衰减15%伤害",
		skillDescKey = "弧光",
		typeName = "ArcLight",
		tagType = "效果实例",
		param = {
			shootCount = 3,
			code = 11009,
			repeated = "NO",
			comparator = 1,
			damageRate = 0.75,
			includeMe = "NO",
			shapeRange = 2,
			referRate = 1,
			damageRateReduce = 0.15,
			referAtr = 51,
			damageType = 1
		}
	},
	{
		name = "锁定",
		type = 2,
		remarks = "标准锁定(用于描述)",
		id = 1013,
		desc = "瞄准目标，下回合己方阶段开始时对其造成伤害",
		skillDescKey = "锁定",
		typeName = "Snipe",
		tagType = "效果实例",
		param = {
			code = 11029
		}
	},
	{
		name = "压制",
		type = 1,
		remarks = "标准压制",
		id = 2001,
		desc = "自身灵感高出目标至少10点",
		skillDescKey = "压制",
		typeName = "Suppress",
		tagType = "条件实例",
		param = {
			attrId = 5,
			code = 1081,
			offset = 10
		}
	},
	{
		name = "低血",
		type = 1,
		remarks = "标准低血",
		id = 2002,
		desc = "自身血量小于等于50%",
		skillDescKey = "低血",
		typeName = "LowHp",
		tagType = "条件实例",
		param = {
			value = 0.5,
			code = 1076,
			op = "<="
		}
	},
	{
		name = "孤军",
		type = 1,
		remarks = "标准孤军",
		id = 2003,
		desc = "自身周围1格内没有友方单位",
		skillDescKey = "孤军",
		typeName = "IsolatedForce",
		tagType = "条件实例",
		param = {
			code = 1077,
			count = 0,
			op = "<=",
			shape = {
				type = "Rhombus",
				range = 1
			}
		}
	},
	{
		name = "协同",
		type = 1,
		remarks = "标准协同",
		id = 2004,
		desc = "自身周围1格内有至少1名友方单位",
		skillDescKey = "协同",
		typeName = "Synergy",
		tagType = "条件实例",
		param = {
			code = 1078,
			count = 1,
			op = ">=",
			shape = {
				type = "Rhombus",
				range = 1
			}
		}
	},
	{
		name = "奔袭",
		type = 1,
		remarks = "标准奔袭",
		id = 2005,
		desc = "主动攻击前，移动至少3格",
		skillDescKey = "奔袭",
		typeName = "Rush",
		tagType = "条件实例",
		param = {
			distance = 3,
			code = 1079
		}
	},
	{
		name = "蓄势",
		type = 1,
		remarks = "标准蓄势",
		id = 2006,
		desc = "主动攻击前，未进行移动",
		skillDescKey = "蓄势",
		typeName = "Poise",
		tagType = "条件实例",
		param = {
			distance = 0,
			code = 1080
		}
	},
	{
		name = "负理智",
		type = 1,
		remarks = "标准狂乱",
		id = 2007,
		desc = "当前理智为负理智",
		skillDescKey = "负理智",
		typeName = "Frenzied",
		tagType = "条件实例",
		param = {
			value = -1,
			code = 1082,
			op = "<="
		}
	},
	{
		name = "正理智",
		type = 1,
		remarks = "标准理性",
		id = 2008,
		desc = "当前理智为正理智",
		skillDescKey = "正理智",
		typeName = "Sanity",
		tagType = "条件实例",
		param = {
			value = 1,
			code = 1083,
			op = ">="
		}
	}
}
local configDataDic = {}

configDataDic.configData = configData

for _, v in ipairs(configData) do
	configDataDic[v.id] = v
end

return configDataDic
