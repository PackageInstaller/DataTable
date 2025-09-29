-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/guide_config/battle_skill_huguang.lua

local configData = {
	step1 = {
		tips = "标签-[弧光]的效果：对当前目标造成75%现实伤害后，弧光会向目标两格内的随机单位弹射",
		img = "battle_skill_huguang",
		mask = true,
		imgKuang = {
			{
				-113.1179,
				-33.16402,
				0,
				314.0685,
				245.4205
			}
		},
		leftHint = {},
		rightHint = {}
	},
	step2 = {
		tips = "<color=#00ffffff>[弧光]</color>最多可弹射三次，每次衰减30%伤害。<color=#00ffffff>[弧光]</color>的效果会因不同的技能产生变化。",
		img = "battle_skill_huguang",
		imgKuang = {},
		leftHint = {},
		rightHint = {}
	}
}

return configData
