local BattleConst = require("battle.const.BattleConst")
local var_0_1 = {}
local var_0_2 = {
	"扣血",
	"加血",
	"减怒气",
	"加怒气",
	"减合计值",
	"加合计值",
	"清除减益",
	"清除增益",
	nil,
	nil,
	nil,
	"减能量",
	"加能量",
	nil,
	"加护盾",
	"加标记",
	"减标记",
	"复活",
	"清除护盾",
	"获得额外回合",
	"灼烧引爆",
	nil,
	nil,
	nil,
	nil,
	nil,
	"清除控制效果",
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	"清除增减益属性buff，不无视不可清除标记",
	nil,
	"清除异常状态类减益buff，不无视不可清除字段",
	nil,
	"加buff",
	nil,
	"变为灵魂状态",
	"退出灵魂状态",
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	"dot回合数+X",
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	"增加临时护盾",
	"减少临时护盾",
	"将目标范围内的临时护盾同步到表现层",
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	"清除目标范围内单位身上的护盾，清除",
	"吸取目标范围内单位value1点调律值，如果目标调律值大于等于4点则吸取value2点",
	nil,
	nil,
	nil,
	nil,
	"汲取调律值",
	nil,
	nil,
	"对范围内目标造成自身value1千分比攻击力的无视护盾的伤害",
	nil,
	"清除多少护盾",
	nil,
	nil,
	"生命流失无视护盾和吸收伤害类buff，直接作用血量，不触发反伤等效果",
	nil,
	"修改 buff 回合数",
	"吸取护盾",
	"复制自身护盾value1给目标",
	nil,
	nil,
	nil,
	nil,
	"伤害转无视护盾伤害",
	nil,
	"标记数翻倍",
	[208] = "加队长能量",
	[207] = "减队长能量"
}
local var_0_3 = {
	name = 12,
	enum = 3,
	shotDesc = 12
}

local function var_0_5(arg_3_0, arg_3_1)
	return arg_3_0
end

local function var_0_6(arg_4_0)
	if arg_4_0 then
		if arg_4_0.knightCfg then
			if arg_4_0.identity == 1 then
				return table.concat({
					"(我方",
					arg_4_0.serialId,
					")",
					arg_4_0.knightCfg.name
				})
			else
				return table.concat({
					"(敌方",
					arg_4_0.serialId,
					")",
					arg_4_0.knightCfg.name
				})
			end
		elseif arg_4_0.skillCfg then
			if arg_4_0.isPet then
				if arg_4_0.identity == 1 then
					return table.concat({
						"(我方)战宠id：",
						arg_4_0.skillId
					})
				else
					return table.concat({
						"(敌方)战宠id：",
						arg_4_0.skillId
					})
				end
			elseif arg_4_0.isSuccuba then
				if arg_4_0.identity == 1 then
					return table.concat({
						"(我方)魔女：",
						arg_4_0.skillId
					})
				else
					return table.concat({
						"(敌方)魔女：",
						arg_4_0.skillId
					})
				end
			elseif arg_4_0.isElemental then
				if arg_4_0.identity == 1 then
					return table.concat({
						"(我方)元素：",
						arg_4_0.skillCfg.curtain_name
					})
				else
					return table.concat({
						"(敌方)元素：",
						arg_4_0.skillCfg.curtain_name
					})
				end
			elseif arg_4_0.identity == 1 then
				return table.concat({
					"(我方)古物id：",
					arg_4_0.skillId
				})
			else
				return table.concat({
					"(敌方)古物id：",
					arg_4_0.skillId
				})
			end
		end
	end

	return "无(可能是技能释放者)"
end

function var_0_1:getEffectCheck()
	return string.format("attacker:%s victim:%s effect_type:%d-%s effect_value:%s", var_0_5(var_0_6(self.attacker), var_0_3.name), var_0_5(var_0_6(self.victim), var_0_3.name), var_0_5(self.effect_type, var_0_3.enum), var_0_5(var_0_2[self.effect_type] or self.effect_type, var_0_3.shotDesc), self.effect_value)
end

local var_0_7 = {
	function(arg_6_0)
		local var_6_0 = {}

		if arg_6_0.crit then
			var_6_0[#var_6_0 + 1] = "暴击!"
		end

		if arg_6_0.miss then
			var_6_0[#var_6_0 + 1] = "闪避!"
		end

		if arg_6_0.block then
			var_6_0[#var_6_0 + 1] = "格挡!"
		end

		if arg_6_0.invincible then
			var_6_0[#var_6_0 + 1] = "无敌!"
		end

		if arg_6_0.seckill then
			var_6_0[#var_6_0 + 1] = "秒杀!"
		end

		if arg_6_0.behead then
			var_6_0[#var_6_0 + 1] = "斩杀!"
		end

		if arg_6_0.detonate then
			var_6_0[#var_6_0 + 1] = "引爆!"
		end

		if arg_6_0.hide then
			var_6_0[#var_6_0 + 1] = "隐身!"
		end

		if arg_6_0.immune then
			var_6_0[#var_6_0 + 1] = "免疫!"
		end

		if arg_6_0.ignoreShield then
			var_6_0[#var_6_0 + 1] = "无视护盾!"
		end

		if arg_6_0.isSelfCost then
			var_6_0[#var_6_0 + 1] = "流血!"
		end

		if arg_6_0.isBuffAddDamage then
			var_6_0[#var_6_0 + 1] = "buff追加伤害!"
		end

		if arg_6_0.victim then
			var_6_0[#var_6_0 + 1] = string.format("当前血量:%d 千分比%d", arg_6_0.victim.baseInfo.INITIAL_HP, arg_6_0.victim:getHpRate())
		end

		return string.format("%s让%s 扣血 %s %s", var_0_5(var_0_6(arg_6_0.attacker), var_0_3.name), var_0_5(var_0_6(arg_6_0.victim), var_0_3.name), arg_6_0.effect_value, table.concat(var_6_0, ""))
	end,
	function(arg_7_0)
		return string.format("%s 回血 %s", var_0_5(var_0_6(arg_7_0.victim), var_0_3.name), arg_7_0.effect_value)
	end,
	function(arg_8_0)
		return string.format("%s 扣怒气 %s", var_0_5(var_0_6(arg_8_0.victim), var_0_3.name), arg_8_0.effect_value)
	end,
	function(arg_9_0)
		return string.format("%s 加怒气 %s", var_0_5(var_0_6(arg_9_0.victim), var_0_3.name), arg_9_0.effect_value)
	end,
	function(arg_10_0)
		return string.format("%s 减少合击值 %s", arg_10_0.victim.identity == 1 and "我方" or "敌方", arg_10_0.effect_value)
	end,
	function(arg_11_0)
		return string.format("%s 增加合击值 %s", arg_11_0.victim.identity == 1 and "我方" or "敌方", arg_11_0.effect_value)
	end,
	[12] = function(arg_12_0)
		return string.format("%s 减必杀能量 %s", var_0_5(var_0_6(arg_12_0.victim), var_0_3.name), arg_12_0.effect_value)
	end,
	[13] = function(arg_13_0)
		return string.format("%s 加必杀能量 %s", var_0_5(var_0_6(arg_13_0.victim), var_0_3.name), arg_13_0.effect_value)
	end,
	[15] = function(arg_14_0)
		return string.format("%s 加护盾 %s 当前拥有护盾:%d", var_0_5(var_0_6(arg_14_0.victim), var_0_3.name), arg_14_0.effect_value, arg_14_0.victim.baseInfo.SHIELD)
	end,
	[16] = function(arg_15_0)
		return string.format("%s 加标记 %s 层数：%d", var_0_5(var_0_6(arg_15_0.victim), var_0_3.name), arg_15_0.effect_value, arg_15_0.add_value)
	end,
	[17] = function(arg_16_0)
		return string.format("%s 减标记 %s 层数：%d", var_0_5(var_0_6(arg_16_0.victim), var_0_3.name), arg_16_0.effect_value, arg_16_0.add_value)
	end,
	[18] = function(arg_17_0)
		return string.format("%s 复活 %s,当前复活次数 %d", var_0_5(var_0_6(arg_17_0.victim), var_0_3.name), arg_17_0.victim.isDead and "失败" or "成功", arg_17_0.victim.rebornCount)
	end,
	[19] = function(arg_18_0)
		return string.format("%s 清除所有护盾", var_0_5(var_0_6(arg_18_0.victim), var_0_3.name))
	end,
	[20] = function(arg_19_0)
		return string.format("%s 获得额外行动回合", var_0_5(var_0_6(arg_19_0.victim), var_0_3.name))
	end,
	[44] = function(arg_20_0)
		return string.format("%s 加buff %s", var_0_5(var_0_6(arg_20_0.victim), var_0_3.name), g.core.config.buff_info.get(arg_20_0.add_value).buff_name)
	end,
	[46] = function(arg_21_0)
		return string.format("%s 变为灵魂状态", var_0_5(var_0_6(arg_21_0.victim), var_0_3.name))
	end,
	[47] = function(arg_22_0)
		return string.format("%s 退出灵魂状态", var_0_5(var_0_6(arg_22_0.victim), var_0_3.name))
	end,
	[80] = function(arg_23_0)
		return string.format("%s 增加临时护盾", var_0_5(var_0_6(arg_23_0.victim), var_0_3.name))
	end,
	[81] = function(arg_24_0)
		return string.format("%s 减少临时护盾", var_0_5(var_0_6(arg_24_0.victim), var_0_3.name))
	end,
	[100] = function(arg_25_0)
		return string.format("%s 清除护盾 %d,当前护盾 %d", var_0_5(var_0_6(arg_25_0.victim), var_0_3.name), arg_25_0.effect_value, arg_25_0.victim.baseInfo.SHIELD)
	end,
	[117] = function(arg_26_0)
		return string.format("%s 回溯 血量:%d 护盾:%d", var_0_5(var_0_6(arg_26_0.victim), var_0_3.name), arg_26_0.victim.baseInfo.INITIAL_HP, arg_26_0.victim.baseInfo.SHIELD)
	end,
	[207] = function(arg_27_0)
		return string.format("%s 减队长能量 %s", var_0_5(var_0_6(arg_27_0.victim), var_0_3.name), arg_27_0.effect_value)
	end,
	[208] = function(arg_28_0)
		return string.format("%s 加队长能量 %s", var_0_5(var_0_6(arg_28_0.victim), var_0_3.name), arg_28_0.effect_value)
	end
}

function var_0_1.getSkillEffectCheck(arg_29_0, arg_29_1)
	return var_0_7[arg_29_0] and var_0_7[arg_29_0](arg_29_1) or ""
end

function var_0_1:getBuffStrCheck()
	local var_30_0 = {}

	var_30_0[#var_30_0 + 1] = "剩余回合:" .. self.buffTime
	var_30_0[#var_30_0 + 1] = "等级:" .. self.level

	local var_30_1 = ""

	if BattleConst.BL_SHOW_BUFF_DESC then
		var_30_1 = g.core.utils.String.formatBuffDesc(self.buffCfg.id)
		var_30_1 = string.gsub(var_30_1, "%b[]", "")
		var_30_1 = "描述：" .. var_30_1
	end

	return string.format("施加者:%s 携带者:%s buffId:%d-%s %s %s", var_0_5(var_0_6(self.attacker), var_0_3.name), var_0_5(var_0_6(self.victim), var_0_3.name), self.buffCfg.id, var_0_5(self.buffCfg.buff_type, var_0_3.name), table.concat(var_30_0, ","), var_30_1)
end

function var_0_1:getAddBuffStrCheck()
	local var_31_0 = ""

	if BattleConst.BL_SHOW_BUFF_DESC then
		var_31_0 = g.core.utils.String.formatBuffDesc(self.buffCfg.id)
		var_31_0 = string.gsub(var_31_0, "%b[]", "")
	end

	return string.format("%s 给 %s 添加buff:%d-%d %s", var_0_5(var_0_6(self.attacker), var_0_3.name), var_0_5(var_0_6(self.victim), var_0_3.name), self.buffCfg.id, self.buffCfg.buff_type, var_31_0)
end

function var_0_1:getDelBuffStrCheck()
	local var_32_0 = ""

	if BattleConst.BL_SHOW_BUFF_DESC then
		var_32_0 = g.core.utils.String.formatBuffDesc(self.buffCfg.id)
		var_32_0 = string.gsub(var_32_0, "%b[]", "")
	end

	return string.format("%s 移除buff:%d-%d 施加者：%s %s", var_0_5(var_0_6(self.victim), var_0_3.name), self.buffCfg.id, self.buffCfg.buff_type, var_0_5(var_0_6(self.attacker), var_0_3.name), var_32_0)
end

function var_0_1:getPassiveStrCheck()
	local var_33_0 = self.info

	if not self.isSkill and self.info.passive_skill_type == 1 then
		var_33_0 = g.core.config.skill_info.get(self.info.passive_skill_value)
	end

	local var_33_1 = ""

	if self.identity == 0 then
		var_33_1 = "战场"
	else
		var_33_1 = self.identity == 2 and "敌方 " or "我方 "

		if self.knight and not self.knight.isPlayer then
			var_33_1 = var_33_1 .. self.knight.knightCfg.name
		end
	end

	return (string.format("%s 释放%s技能:%d-%s", var_33_1, var_33_0.skill_type == 3 and "合击" or var_33_0.skill_type == 6 and "战宠" or var_33_0.skill_type == 14 and "战宠附属被动技能" or (var_33_0.skill_type == 15 or var_33_0.skill_type == 30) and "古物被动" or "类型" .. var_33_0.skill_type, var_33_0.id, (string.gsub(string.gsub(g.core.utils.String.formatSkillDesc(var_33_0.id), "%b[]", ""), "\n", ""))))
end

var_0_1.GetKnightName = var_0_6

return var_0_1
