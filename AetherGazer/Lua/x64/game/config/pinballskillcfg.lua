return {
	[30901] = {
		description = "下次发射弹珠时，弹珠首次返回至地面后会再次弹出。",
		effect_type = 4,
		name = "",
		skill_type = 0,
		cost = 150,
		special_effects = "skill",
		action = "drink01_female",
		start_effects = "",
		activity_id = 0,
		cd = 1,
		id = 30901,
		icon = "TextureConfig/VersionUI/BaichaoUI_3_9/BaichaoUI_3_9_Pinball/Skill/skill1",
		callback_effects = "",
		skill_group = 0,
		effect = {
			2,
			1
		}
	},
	[30902] = {
		description = "下次发射弹珠时，增加5个弹珠发射数量。",
		effect_type = 14,
		name = "",
		skill_type = 0,
		cost = 150,
		special_effects = "skill",
		action = "drink01_female",
		start_effects = "",
		activity_id = 0,
		cd = 1,
		id = 30902,
		icon = "TextureConfig/VersionUI/BaichaoUI_3_9/BaichaoUI_3_9_Pinball/Skill/skill2",
		callback_effects = "",
		skill_group = 0,
		effect = {
			5
		}
	},
	[30903] = {
		description = "每回合对玩家造成一定伤害",
		effect_type = 5,
		name = "",
		skill_type = 0,
		cost = 0,
		special_effects = "skill",
		action = "attack1",
		start_effects = "",
		activity_id = 0,
		cd = 0,
		id = 30903,
		icon = "TextureConfig/BuffIcon/AFFIX_9091",
		callback_effects = "",
		skill_group = 0,
		effect = {
			30
		}
	},
	[30904] = {
		description = "下次发射弹珠时，弹珠弹射10次后会自动消失",
		effect_type = 12,
		name = "",
		skill_type = 0,
		cost = 0,
		special_effects = "skill",
		action = "skill1",
		start_effects = "",
		activity_id = 0,
		cd = 3,
		id = 30904,
		icon = "TextureConfig/BuffIcon/AFFIX_DOTIMMUNE",
		callback_effects = "",
		skill_group = 0,
		effect = {
			3,
			1
		}
	},
	[30905] = {
		description = "将场地中所有砖块类型转化为再生砖块持续1回合",
		effect_type = 13,
		name = "",
		skill_type = 0,
		cost = 0,
		special_effects = "skill",
		action = "skill1",
		start_effects = "",
		activity_id = 0,
		cd = 3,
		id = 30905,
		icon = "TextureConfig/BuffIcon/AFFIX_BUFF_SHIELD",
		callback_effects = "",
		skill_group = 0,
		effect = {
			5,
			1
		}
	},
	[40601] = {
		description = "海拉>{参数1},≤{参数2}时，使用轻攻击",
		effect_type = 1,
		name = "",
		skill_type = 3,
		cost = 0,
		special_effects = "skill",
		action = "attack1",
		start_effects = "",
		activity_id = 3840801,
		cd = 0,
		id = 40601,
		icon = "",
		callback_effects = "",
		skill_group = 0,
		effect = {
			0,
			5000
		}
	},
	[40602] = {
		description = "海拉≥{参数1}时，使用重攻击",
		effect_type = 1,
		name = "",
		skill_type = 3,
		cost = 0,
		special_effects = "skill",
		action = "attack1",
		start_effects = "skill",
		activity_id = 3840801,
		cd = 0,
		id = 40602,
		icon = "",
		callback_effects = "skill",
		skill_group = 0,
		effect = {
			5000
		}
	},
	[40603] = {
		description = "弹珠在前%s次碰撞「色块」时，造成范围爆炸",
		effect_type = 19,
		name = "爆裂弹",
		skill_type = 1,
		cost = 50,
		special_effects = "skill",
		action = "skill2",
		start_effects = "",
		activity_id = 3840801,
		cd = 0,
		id = 40603,
		icon = "TextureConfig/Activity_Hel/helSkill/activity_play_marbles_046_2",
		callback_effects = "",
		skill_group = 0,
		effect = {
			2,
			5
		}
	},
	[40604] = {
		description = "弹珠碰撞「色块」后额外分裂出%s个弹珠",
		effect_type = 20,
		name = "分裂弹",
		skill_type = 1,
		cost = 70,
		special_effects = "skill",
		action = "skill2",
		start_effects = "",
		activity_id = 3840801,
		cd = 0,
		id = 40604,
		icon = "TextureConfig/Activity_Hel/helSkill/activity_play_marbles_046_1",
		callback_effects = "",
		skill_group = 0,
		effect = {
			3
		}
	},
	[40605] = {
		description = "弹珠将直接消除前 %s 次碰撞的「色块」，且不发生反弹",
		effect_type = 21,
		name = "贯穿弹",
		skill_type = 1,
		cost = 80,
		special_effects = "skill",
		action = "skill2",
		start_effects = "",
		activity_id = 3840801,
		cd = 0,
		id = 40605,
		icon = "TextureConfig/Activity_Hel/helSkill/activity_play_marbles_046_3",
		callback_effects = "",
		skill_group = 0,
		effect = {
			20
		}
	},
	[40606] = {
		description = "在场地上的随机空位，生成 %s 个道具",
		effect_type = 15,
		name = "资源补给",
		skill_type = 1,
		cost = 100,
		special_effects = "skill",
		action = "skill2",
		start_effects = "",
		activity_id = 3840801,
		cd = 0,
		id = 40606,
		icon = "TextureConfig/Activity_Hel/helSkill/activity_play_marbles_046_4",
		callback_effects = "",
		skill_group = 0,
		effect = {
			4
		}
	},
	[40607] = {
		description = "战斗开始时，主动技能的初始能量提升至 120",
		effect_type = 16,
		name = "准备万全",
		skill_type = 2,
		cost = 0,
		special_effects = "",
		action = "",
		start_effects = "",
		activity_id = 3840801,
		cd = 0,
		id = 40607,
		icon = "TextureConfig/Activity_Hel/helSkill/activity_play_marbles_046_6",
		callback_effects = "",
		skill_group = 1,
		effect = {
			60
		}
	},
	[40608] = {
		description = "战斗开始时，主动技能的初始能量提升至 140",
		effect_type = 16,
		name = "准备万全",
		skill_type = 2,
		cost = 0,
		special_effects = "",
		action = "",
		start_effects = "",
		activity_id = 3840801,
		cd = 0,
		id = 40608,
		icon = "TextureConfig/Activity_Hel/helSkill/activity_play_marbles_046_6",
		callback_effects = "",
		skill_group = 1,
		effect = {
			80
		}
	},
	[40609] = {
		description = "战斗开始时，主动技能的初始能量提升至 160",
		effect_type = 16,
		name = "准备万全",
		skill_type = 2,
		cost = 0,
		special_effects = "",
		action = "",
		start_effects = "",
		activity_id = 3840801,
		cd = 0,
		id = 40609,
		icon = "TextureConfig/Activity_Hel/helSkill/activity_play_marbles_046_6",
		callback_effects = "",
		skill_group = 1,
		effect = {
			100
		}
	},
	[40610] = {
		description = "所有主动技能的能量消耗减少 %s%%",
		effect_type = 17,
		name = "效率射击",
		skill_type = 2,
		cost = 0,
		special_effects = "",
		action = "",
		start_effects = "",
		activity_id = 3840801,
		cd = 0,
		id = 40610,
		icon = "TextureConfig/Activity_Hel/helSkill/activity_play_marbles_046_5",
		callback_effects = "",
		skill_group = 2,
		effect = {
			10
		}
	},
	[40611] = {
		description = "所有主动技能的能量消耗减少 %s%%",
		effect_type = 17,
		name = "效率射击",
		skill_type = 2,
		cost = 0,
		special_effects = "",
		action = "",
		start_effects = "",
		activity_id = 3840801,
		cd = 0,
		id = 40611,
		icon = "TextureConfig/Activity_Hel/helSkill/activity_play_marbles_046_5",
		callback_effects = "",
		skill_group = 2,
		effect = {
			15
		}
	},
	[40612] = {
		description = "所有主动技能的能量消耗减少 %s%%",
		effect_type = 17,
		name = "效率射击",
		skill_type = 2,
		cost = 0,
		special_effects = "",
		action = "",
		start_effects = "",
		activity_id = 3840801,
		cd = 0,
		id = 40612,
		icon = "TextureConfig/Activity_Hel/helSkill/activity_play_marbles_046_5",
		callback_effects = "",
		skill_group = 2,
		effect = {
			20
		}
	},
	[40613] = {
		description = "每回合开始时，自动恢复主动技能能量提升至 20",
		effect_type = 18,
		name = "自动充能",
		skill_type = 2,
		cost = 0,
		special_effects = "",
		action = "",
		start_effects = "",
		activity_id = 3840801,
		cd = 0,
		id = 40613,
		icon = "TextureConfig/Activity_Hel/helSkill/activity_play_marbles_046_7",
		callback_effects = "",
		skill_group = 3,
		effect = {
			10
		}
	},
	[40614] = {
		description = "每回合开始时，自动恢复主动技能能量提升至 25",
		effect_type = 18,
		name = "自动充能",
		skill_type = 2,
		cost = 0,
		special_effects = "",
		action = "",
		start_effects = "",
		activity_id = 3840801,
		cd = 0,
		id = 40614,
		icon = "TextureConfig/Activity_Hel/helSkill/activity_play_marbles_046_7",
		callback_effects = "",
		skill_group = 3,
		effect = {
			15
		}
	},
	[40615] = {
		description = "每回合开始时，自动恢复主动技能能量提升至 30",
		effect_type = 18,
		name = "自动充能",
		skill_type = 2,
		cost = 0,
		special_effects = "",
		action = "",
		start_effects = "",
		activity_id = 3840801,
		cd = 0,
		id = 40615,
		icon = "TextureConfig/Activity_Hel/helSkill/activity_play_marbles_046_7",
		callback_effects = "",
		skill_group = 3,
		effect = {
			20
		}
	},
	[40616] = {
		description = "对%s个「色块」施加「护盾」",
		effect_type = 22,
		name = "扭曲屏障",
		skill_type = 4,
		cost = 0,
		special_effects = "skill",
		action = "skill1",
		start_effects = "",
		activity_id = 3840801,
		cd = 0,
		id = 40616,
		icon = "TextureConfig/Activity_Hel/helSkill/activity_play_marbles_046_9",
		callback_effects = "",
		skill_group = 4,
		effect = {
			3,
			0,
			1
		}
	},
	[40617] = {
		description = "对%s个「色块」施加「护盾」，并在场地上的 %s 个空位生成护盾",
		effect_type = 23,
		name = "扭曲屏障",
		skill_type = 4,
		cost = 0,
		special_effects = "skill",
		action = "skill1",
		start_effects = "",
		activity_id = 3840801,
		cd = 0,
		id = 40617,
		icon = "TextureConfig/Activity_Hel/helSkill/activity_play_marbles_046_9",
		callback_effects = "",
		skill_group = 4,
		effect = {
			4,
			2,
			1
		}
	},
	[40618] = {
		description = "对%s个「色块」施加「护盾」，并在场地上的 %s 个空位生成护盾",
		effect_type = 23,
		name = "扭曲屏障",
		skill_type = 4,
		cost = 0,
		special_effects = "skill",
		action = "skill1",
		start_effects = "",
		activity_id = 3840801,
		cd = 0,
		id = 40618,
		icon = "TextureConfig/Activity_Hel/helSkill/activity_play_marbles_046_9",
		callback_effects = "",
		skill_group = 4,
		effect = {
			5,
			3,
			1
		}
	},
	[40619] = {
		description = "对%s个「色块」施加「侵蚀」。「侵蚀色块」将在%s回合后向四周蔓延一格。消除「侵蚀色块」将对海拉造成%s伤害",
		effect_type = 24,
		name = "侵蚀扩散",
		skill_type = 4,
		cost = 0,
		special_effects = "skill",
		action = "skill1",
		start_effects = "",
		activity_id = 3840801,
		cd = 0,
		id = 40619,
		icon = "TextureConfig/Activity_Hel/helSkill/activity_play_marbles_046_8",
		callback_effects = "",
		skill_group = 5,
		effect = {
			2,
			2,
			50
		}
	},
	[40620] = {
		description = "对%s个「色块」施加「侵蚀」。「侵蚀色块」将在%s回合后向四周蔓延一格。消除「侵蚀色块」将对海拉造成%s伤害",
		effect_type = 24,
		name = "侵蚀扩散",
		skill_type = 4,
		cost = 0,
		special_effects = "skill",
		action = "skill1",
		start_effects = "",
		activity_id = 3840801,
		cd = 0,
		id = 40620,
		icon = "TextureConfig/Activity_Hel/helSkill/activity_play_marbles_046_8",
		callback_effects = "",
		skill_group = 5,
		effect = {
			3,
			2,
			50
		}
	},
	[40621] = {
		description = "对%s个「色块」施加「侵蚀」。「侵蚀色块」将在%s回合后向四周蔓延一格。消除「侵蚀色块」将对海拉造成%s伤害",
		effect_type = 24,
		name = "侵蚀扩散",
		skill_type = 4,
		cost = 0,
		special_effects = "skill",
		action = "skill1",
		start_effects = "",
		activity_id = 3840801,
		cd = 0,
		id = 40621,
		icon = "TextureConfig/Activity_Hel/helSkill/activity_play_marbles_046_8",
		callback_effects = "",
		skill_group = 5,
		effect = {
			4,
			2,
			80
		}
	},
	[40622] = {
		description = "视骸%s回合后完成「蓄力」，完成后造成%s点伤害，对视骸造成%s伤害可打断蓄力，并令视骸虚弱%s回合",
		effect_type = 14,
		name = "蓄力一击",
		skill_type = 4,
		cost = 0,
		special_effects = "skill",
		action = "charge",
		start_effects = "",
		activity_id = 3840801,
		cd = 0,
		id = 40622,
		icon = "TextureConfig/Activity_Hel/helSkill/activity_play_marbles_046_10",
		callback_effects = "",
		skill_group = 6,
		effect = {
			1,
			800,
			2500,
			2
		}
	},
	[40623] = {
		description = "视骸%s回合后完成「蓄力」，完成后造成%s点伤害，对视骸造成%s伤害可打断蓄力，并令视骸虚弱%s回合",
		effect_type = 14,
		name = "蓄力一击",
		skill_type = 4,
		cost = 0,
		special_effects = "skill",
		action = "charge",
		start_effects = "",
		activity_id = 3840801,
		cd = 0,
		id = 40623,
		icon = "TextureConfig/Activity_Hel/helSkill/activity_play_marbles_046_10",
		callback_effects = "",
		skill_group = 6,
		effect = {
			1,
			1000,
			3000,
			2
		}
	},
	[40624] = {
		description = "视骸%s回合后完成「蓄力」，完成后造成%s点伤害，对视骸造成%s伤害可打断蓄力，并令视骸虚弱%s回合",
		effect_type = 14,
		name = "蓄力一击",
		skill_type = 4,
		cost = 0,
		special_effects = "skill",
		action = "charge",
		start_effects = "",
		activity_id = 3840801,
		cd = 0,
		id = 40624,
		icon = "TextureConfig/Activity_Hel/helSkill/activity_play_marbles_046_10",
		callback_effects = "",
		skill_group = 6,
		effect = {
			2,
			1800,
			3000,
			1
		}
	},
	[40625] = {
		description = "视骸轻攻击对玩家造成（{参数1}*怪物攻击力）点伤害",
		effect_type = 5,
		name = "",
		skill_type = 6,
		cost = 0,
		special_effects = "skill",
		action = "attack1",
		start_effects = "",
		activity_id = 3840801,
		cd = 0,
		id = 40625,
		icon = "",
		callback_effects = "",
		skill_group = 0,
		effect = {
			45
		}
	},
	[40626] = {
		description = "视骸重攻击对玩家造成（{参数1}*怪物攻击力）点伤害",
		effect_type = 5,
		name = "",
		skill_type = 6,
		cost = 0,
		special_effects = "skill",
		action = "attack1",
		start_effects = "skill",
		activity_id = 3840801,
		cd = 0,
		id = 40626,
		icon = "",
		callback_effects = "skill",
		skill_group = 0,
		effect = {
			60
		}
	},
	[40627] = {
		description = "海拉辩论成功，使用特殊攻击",
		effect_type = 1,
		name = "",
		skill_type = 3,
		cost = 0,
		special_effects = "skill",
		action = "skill_qte",
		start_effects = "skill",
		activity_id = 3840801,
		cd = 0,
		id = 40627,
		icon = "",
		callback_effects = "skill",
		skill_group = 0,
		effect = {
			-1
		}
	},
	[40628] = {
		description = "海拉辩论失败，使用特殊攻击",
		effect_type = 1,
		name = "",
		skill_type = 3,
		cost = 0,
		special_effects = "skill",
		action = "skill1",
		start_effects = "",
		activity_id = 3840801,
		cd = 0,
		id = 40628,
		icon = "",
		callback_effects = "",
		skill_group = 0,
		effect = {}
	},
	get_id_list_by_skill_group = {
		[0] = {
			30901,
			30902,
			30903,
			30904,
			30905,
			40601,
			40602,
			40603,
			40604,
			40605,
			40606,
			40625,
			40626,
			40627,
			40628
		},
		{
			40607,
			40608,
			40609
		},
		{
			40610,
			40611,
			40612
		},
		{
			40613,
			40614,
			40615
		},
		{
			40616,
			40617,
			40618
		},
		{
			40619,
			40620,
			40621
		},
		{
			40622,
			40623,
			40624
		}
	},
	get_id_list_by_activity_id_skill_type = {
		[0] = {
			[0] = {
				30901,
				30902,
				30903,
				30904,
				30905
			}
		},
		[3840801] = {
			{
				40603,
				40604,
				40605,
				40606
			},
			{
				40607,
				40608,
				40609,
				40610,
				40611,
				40612,
				40613,
				40614,
				40615
			},
			{
				40601,
				40602,
				40627,
				40628
			},
			{
				40616,
				40617,
				40618,
				40619,
				40620,
				40621,
				40622,
				40623,
				40624
			},
			[6] = {
				40625,
				40626
			}
		}
	},
	get_id_list_by_activity_id = {
		[0] = {
			30901,
			30902,
			30903,
			30904,
			30905
		},
		[3840801] = {
			40601,
			40602,
			40603,
			40604,
			40605,
			40606,
			40607,
			40608,
			40609,
			40610,
			40611,
			40612,
			40613,
			40614,
			40615,
			40616,
			40617,
			40618,
			40619,
			40620,
			40621,
			40622,
			40623,
			40624,
			40625,
			40626,
			40627,
			40628
		}
	},
	all = {
		30901,
		30902,
		30903,
		30904,
		30905,
		40601,
		40602,
		40603,
		40604,
		40605,
		40606,
		40607,
		40608,
		40609,
		40610,
		40611,
		40612,
		40613,
		40614,
		40615,
		40616,
		40617,
		40618,
		40619,
		40620,
		40621,
		40622,
		40623,
		40624,
		40625,
		40626,
		40627,
		40628
	}
}
