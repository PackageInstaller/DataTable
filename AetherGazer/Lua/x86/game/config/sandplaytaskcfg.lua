return {
	[101] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "前往与NPC1交谈",
		condition = 60,
		main_task_id = 101,
		need = 1,
		task_tag = "任务1",
		hide_task = 0,
		task_id = 101,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[102] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "前往与NPC2交谈",
		condition = 60,
		main_task_id = 101,
		need = 1,
		task_tag = "任务2",
		hide_task = 0,
		task_id = 102,
		pre_operation = 2,
		pre_task_id = {
			101
		},
		additional_parameter = {}
	},
	[103] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "找到NPC2_1并跟随其前往指定地点",
		condition = 60,
		main_task_id = 101,
		need = 1,
		task_tag = "任务3",
		hide_task = 0,
		task_id = 103,
		pre_operation = 2,
		pre_task_id = {
			102
		},
		additional_parameter = {}
	},
	[104] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "找到NPC4交谈后生成走格子小游戏",
		condition = 60,
		main_task_id = 101,
		need = 1,
		task_tag = "任务4",
		hide_task = 0,
		task_id = 104,
		pre_operation = 2,
		pre_task_id = {
			103
		},
		additional_parameter = {}
	},
	[105] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "通过NPC3传送到指定区域",
		condition = 60,
		main_task_id = 101,
		need = 1,
		task_tag = "任务5",
		hide_task = 0,
		task_id = 105,
		pre_operation = 2,
		pre_task_id = {
			102
		},
		additional_parameter = {}
	},
	[106] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "找到NPC5聊聊，争取获得宝箱",
		condition = 60,
		main_task_id = 101,
		need = 1,
		task_tag = "任务6",
		hide_task = 0,
		task_id = 106,
		pre_operation = 2,
		pre_task_id = {
			105
		},
		additional_parameter = {}
	},
	[107] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "再次找到NPC4，验证任务完成后生成永久",
		condition = 60,
		main_task_id = 101,
		need = 1,
		task_tag = "任务7",
		hide_task = 0,
		task_id = 107,
		pre_operation = 2,
		pre_task_id = {
			104,
			106
		},
		additional_parameter = {}
	},
	[108] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "（可选）找NPC3谈话",
		condition = 60,
		main_task_id = 101,
		need = 1,
		task_tag = "任务8",
		hide_task = 0,
		task_id = 108,
		pre_operation = 2,
		pre_task_id = {
			107
		},
		additional_parameter = {}
	},
	[109] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "（必选）找NPC1谈话，任务结束后观察NPC3是否被销毁",
		condition = 60,
		main_task_id = 101,
		need = 1,
		task_tag = "任务9",
		hide_task = 0,
		task_id = 109,
		pre_operation = 2,
		pre_task_id = {
			107
		},
		additional_parameter = {}
	},
	[201] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "与宝箱交互后，移除宝箱，并发放任务奖励",
		condition = 60,
		main_task_id = 201,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 201,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[202] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "与宝箱交互后，移除宝箱，并发放任务奖励",
		condition = 60,
		main_task_id = 202,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 202,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10101001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "在附近转转",
		condition = 60,
		main_task_id = 10101,
		need = 1,
		task_tag = "在附近转转",
		hide_task = 0,
		task_id = 10101001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10102001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "不如找人问问路？",
		condition = 60,
		main_task_id = 10102,
		need = 1,
		task_tag = "不如找人问问路？",
		hide_task = 0,
		task_id = 10102001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10102002] = {
		task_blueprint_sign = 1,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "和熟人打个招呼",
		condition = 60,
		main_task_id = 10102,
		need = 1,
		task_tag = "和熟人打个招呼",
		hide_task = 0,
		task_id = 10102002,
		pre_operation = 2,
		pre_task_id = {
			10102001
		},
		additional_parameter = {}
	},
	[10103001] = {
		task_blueprint_sign = 1,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "与英招对话",
		condition = 60,
		main_task_id = 10103,
		need = 1,
		task_tag = "与英招对话",
		hide_task = 0,
		task_id = 10103001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10103002] = {
		task_blueprint_sign = 1,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "跟随英招",
		condition = 60,
		main_task_id = 10103,
		need = 1,
		task_tag = "跟随英招",
		hide_task = 0,
		task_id = 10103002,
		pre_operation = 2,
		pre_task_id = {
			10103001
		},
		additional_parameter = {}
	},
	[10103003] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "关于师父的考验…",
		condition = 60,
		main_task_id = 10103,
		need = 1,
		task_tag = "关于师父的考验…",
		hide_task = 0,
		task_id = 10103003,
		pre_operation = 2,
		pre_task_id = {
			10103002
		},
		additional_parameter = {}
	},
	[10104001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "购买笔记本",
		condition = 60,
		main_task_id = 10104,
		need = 1,
		task_tag = "购买笔记本",
		hide_task = 0,
		task_id = 10104001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10104002] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "从柜台取得笔记本",
		condition = 60,
		main_task_id = 10104,
		need = 1,
		task_tag = "从柜台取得笔记本",
		hide_task = 0,
		task_id = 10104002,
		pre_operation = 2,
		pre_task_id = {
			10104001
		},
		additional_parameter = {}
	},
	[10105001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "答应的帮忙不能忘",
		condition = 60,
		main_task_id = 10105,
		need = 1,
		task_tag = "答应的帮忙不能忘",
		hide_task = 0,
		task_id = 10105001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10105002] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "收起孟章订的食材",
		condition = 60,
		main_task_id = 10105,
		need = 1,
		task_tag = "收起孟章订的食材",
		hide_task = 0,
		task_id = 10105002,
		pre_operation = 2,
		pre_task_id = {
			10105001
		},
		additional_parameter = {}
	},
	[10105003] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "返回寻找孟章",
		condition = 60,
		main_task_id = 10105,
		need = 1,
		task_tag = "返回寻找孟章",
		hide_task = 0,
		task_id = 10105003,
		pre_operation = 2,
		pre_task_id = {
			10105002
		},
		additional_parameter = {}
	},
	[10105004] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "打开地图查看",
		condition = 60,
		main_task_id = 10116,
		need = 1,
		task_tag = "打开地图查看",
		hide_task = 0,
		task_id = 10105004,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10106001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "在「掌厨来也！」中满足6个菜肴需求",
		condition = 310103,
		main_task_id = 10106,
		need = 6,
		task_tag = "在「掌厨来也！」中满足6个菜肴需求",
		hide_task = 0,
		task_id = 10106001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10107001] = {
		task_blueprint_sign = 2,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "等待醒岁节来临",
		condition = 61,
		main_task_id = 10107,
		need = 1,
		task_tag = "等待醒岁节来临",
		hide_task = 0,
		task_id = 10107001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {
			2025,
			1,
			29,
			0,
			0,
			0
		}
	},
	[10108001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "禄良的消息",
		condition = 60,
		main_task_id = 10108,
		need = 1,
		task_tag = "禄良的消息",
		hide_task = 0,
		task_id = 10108001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10108002] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "收下禄良的新年礼",
		condition = 60,
		main_task_id = 10108,
		need = 1,
		task_tag = "收下禄良的新年礼",
		hide_task = 0,
		task_id = 10108002,
		pre_operation = 2,
		pre_task_id = {
			10108001
		},
		additional_parameter = {}
	},
	[10108003] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "前往码头",
		condition = 60,
		main_task_id = 10108,
		need = 1,
		task_tag = "前往码头",
		hide_task = 0,
		task_id = 10108003,
		pre_operation = 2,
		pre_task_id = {
			10108002
		},
		additional_parameter = {}
	},
	[10108004] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "给师父甜品和修习心得",
		condition = 60,
		main_task_id = 10108,
		need = 1,
		task_tag = "给师父甜品和修习心得",
		hide_task = 0,
		task_id = 10108004,
		pre_operation = 2,
		pre_task_id = {
			10108003
		},
		additional_parameter = {}
	},
	[10108005] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "和师父的交流",
		condition = 60,
		main_task_id = 10108,
		need = 1,
		task_tag = "和师父的交流",
		hide_task = 0,
		task_id = 10108005,
		pre_operation = 2,
		pre_task_id = {
			10108004
		},
		additional_parameter = {}
	},
	[10108006] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "捡起修习记录",
		condition = 60,
		main_task_id = 10108,
		need = 1,
		task_tag = "捡起修习记录",
		hide_task = 0,
		task_id = 10108006,
		pre_operation = 2,
		pre_task_id = {
			10108005
		},
		additional_parameter = {}
	},
	[10109001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "在「醒狮传说」中成功通关「研习Ⅴ」",
		condition = 51202,
		main_task_id = 10109,
		need = 1,
		task_tag = "在「醒狮传说」中成功通关「研习Ⅴ」",
		hide_task = 0,
		task_id = 10109001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {
			4005
		}
	},
	[10110001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "稍等数日",
		condition = 61,
		main_task_id = 10110,
		need = 1,
		task_tag = "稍等数日",
		hide_task = 0,
		task_id = 10110001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {
			2025,
			2,
			20,
			7,
			0,
			0
		}
	},
	[10111001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "在「泰府新秀」中答对20道题",
		condition = 18002,
		main_task_id = 10111,
		need = 20,
		task_tag = "在「泰府新秀」中答对20道题",
		hide_task = 0,
		task_id = 10111001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10112001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "在「《江胡》高手！」中通过4个不同关卡",
		condition = 54037,
		main_task_id = 10112,
		need = 4,
		task_tag = "在「《江胡》高手！」中通过4个不同关卡",
		hide_task = 0,
		task_id = 10112001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {
			313431
		}
	},
	[10113001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "在「香绣连珠」中达成9个关卡目标",
		condition = 170003,
		main_task_id = 10113,
		need = 9,
		task_tag = "在「香绣连珠」中达成9个关卡目标",
		hide_task = 0,
		task_id = 10113001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {
			313531
		}
	},
	[10114001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "在「浮光绎曲」中完成 Wordless Song for a Starry Night 普通难度1次",
		condition = 50103,
		main_task_id = 10114,
		need = 1,
		task_tag = "在「浮光绎曲」中完成 Wordless Song for a Starry Night 普通难度1次",
		hide_task = 0,
		task_id = 10114001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {
			311491,
			1,
			5
		}
	},
	[10115001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10115,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10115001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10115002] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10115,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10115002,
		pre_operation = 2,
		pre_task_id = {
			10115001
		},
		additional_parameter = {}
	},
	[10117001] = {
		task_blueprint_sign = 2,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 61,
		main_task_id = 10117,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10117001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {
			2025,
			1,
			29,
			5,
			0,
			0
		}
	},
	[10118001] = {
		task_blueprint_sign = 2,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 61,
		main_task_id = 10118,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10118001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {
			2025,
			2,
			20,
			7,
			0,
			0
		}
	},
	[10302001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10302,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10302001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10303001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10303,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10303001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10304001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10304,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10304001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10305001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10305,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10305001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10306001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10306,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10306001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10307001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10307,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10307001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10308001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10308,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10308001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10309001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10309,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10309001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10310001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10310,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10310001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10311001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10311,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10311001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10312001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10312,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10312001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10313001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10313,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10313001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10314001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10314,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10314001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10315001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10315,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10315001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10320001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10320,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10320001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10321001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10321,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10321001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10322001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10322,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10322001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10325001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10325,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10325001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10326001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10326,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10326001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10327001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10327,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10327001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10328001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10328,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10328001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10329001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10329,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10329001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10330001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10330,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10330001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10331001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10331,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10331001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10332001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10332,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10332001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10333001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10333,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10333001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10334001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10334,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 10334001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10345001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "听听禄良的请求",
		condition = 60,
		main_task_id = 10345,
		need = 1,
		task_tag = "暗度陈仓？！",
		hide_task = 0,
		task_id = 10345001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10345002] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "找个好地方藏东西",
		condition = 60,
		main_task_id = 10345,
		need = 1,
		task_tag = "找个好地方藏东西",
		hide_task = 0,
		task_id = 10345002,
		pre_operation = 2,
		pre_task_id = {
			10345001
		},
		additional_parameter = {}
	},
	[10345003] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "听听禄良怎么说",
		condition = 60,
		main_task_id = 10345,
		need = 1,
		task_tag = "东西藏好了",
		hide_task = 0,
		task_id = 10345003,
		pre_operation = 2,
		pre_task_id = {
			10345002
		},
		additional_parameter = {}
	},
	[10346001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "询问禄良为何苦恼",
		condition = 60,
		main_task_id = 10346,
		need = 1,
		task_tag = "寻找订单",
		hide_task = 0,
		task_id = 10346001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10346002] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "寻找这批货的订单",
		condition = 60,
		main_task_id = 10346,
		need = 1,
		task_tag = "寻找这批货的订单",
		hide_task = 0,
		task_id = 10346002,
		pre_operation = 2,
		pre_task_id = {
			10346001
		},
		additional_parameter = {}
	},
	[10346003] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "寻找禄良提交订单",
		condition = 60,
		main_task_id = 10346,
		need = 1,
		task_tag = "提交订单",
		hide_task = 0,
		task_id = 10346003,
		pre_operation = 2,
		pre_task_id = {
			10346002
		},
		additional_parameter = {}
	},
	[10347001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "听听禄良的打算",
		condition = 60,
		main_task_id = 10347,
		need = 1,
		task_tag = "小风车，呼呼呼",
		hide_task = 0,
		task_id = 10347001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10347002] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "寻找风车",
		condition = 60,
		main_task_id = 10347,
		need = 1,
		task_tag = "寻找风车",
		hide_task = 0,
		task_id = 10347002,
		pre_operation = 2,
		pre_task_id = {
			10347001
		},
		additional_parameter = {}
	},
	[10347003] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "将风车给禄良",
		condition = 60,
		main_task_id = 10347,
		need = 1,
		task_tag = "交还风车",
		hide_task = 0,
		task_id = 10347003,
		pre_operation = 2,
		pre_task_id = {
			10347002
		},
		additional_parameter = {}
	},
	[10348001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "问问禄良怎么了",
		condition = 60,
		main_task_id = 10348,
		need = 1,
		task_tag = "吹走的福签",
		hide_task = 0,
		task_id = 10348001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10348002] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "找到被风吹走的福签",
		condition = 60,
		main_task_id = 10348,
		need = 1,
		task_tag = "寻找福签",
		hide_task = 0,
		task_id = 10348002,
		pre_operation = 2,
		pre_task_id = {
			10348001
		},
		additional_parameter = {}
	},
	[10348003] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "将福签交给禄良",
		condition = 60,
		main_task_id = 10348,
		need = 1,
		task_tag = "交还",
		hide_task = 0,
		task_id = 10348003,
		pre_operation = 2,
		pre_task_id = {
			10348002
		},
		additional_parameter = {}
	},
	[10350001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10350,
		need = 1,
		task_tag = "",
		hide_task = 1,
		task_id = 10350001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10352001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10352,
		need = 1,
		task_tag = "",
		hide_task = 1,
		task_id = 10352001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10353001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10353,
		need = 1,
		task_tag = "",
		hide_task = 1,
		task_id = 10353001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10354001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10354,
		need = 1,
		task_tag = "",
		hide_task = 1,
		task_id = 10354001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10355001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10355,
		need = 1,
		task_tag = "",
		hide_task = 1,
		task_id = 10355001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10356001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10356,
		need = 1,
		task_tag = "",
		hide_task = 1,
		task_id = 10356001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10357001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10357,
		need = 1,
		task_tag = "",
		hide_task = 1,
		task_id = 10357001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10358001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10358,
		need = 1,
		task_tag = "",
		hide_task = 1,
		task_id = 10358001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10359001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10359,
		need = 1,
		task_tag = "",
		hide_task = 1,
		task_id = 10359001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10360001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10360,
		need = 1,
		task_tag = "",
		hide_task = 1,
		task_id = 10360001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10361001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10361,
		need = 1,
		task_tag = "",
		hide_task = 1,
		task_id = 10361001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10362001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 10362,
		need = 1,
		task_tag = "",
		hide_task = 1,
		task_id = 10362001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[10401001] = {
		task_blueprint_sign = 2,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 54038,
		main_task_id = 10401,
		need = 1,
		task_tag = "",
		hide_task = 1,
		task_id = 10401001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {
			102
		}
	},
	[10402001] = {
		task_blueprint_sign = 2,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 54038,
		main_task_id = 10402,
		need = 1,
		task_tag = "",
		hide_task = 1,
		task_id = 10402001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {
			112
		}
	},
	[10403001] = {
		task_blueprint_sign = 2,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 54038,
		main_task_id = 10403,
		need = 1,
		task_tag = "",
		hide_task = 1,
		task_id = 10403001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {
			114
		}
	},
	[10404001] = {
		task_blueprint_sign = 2,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 54038,
		main_task_id = 10404,
		need = 1,
		task_tag = "",
		hide_task = 1,
		task_id = 10404001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {
			124
		}
	},
	[11199001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11199,
		need = 1,
		task_tag = "",
		hide_task = 1,
		task_id = 11199001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11101001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "初到刺桐城就遇到了熟人，但对方行色匆匆，似乎遇到了什么困难？",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11101,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11101001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11101002] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "初到刺桐城就遇到了熟人，但对方行色匆匆，似乎遇到了什么困难？",
		task_item = "",
		task_target = "前往码头",
		condition = 60,
		main_task_id = 11101,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11101002,
		pre_operation = 2,
		pre_task_id = {
			11101001
		},
		additional_parameter = {}
	},
	[11101003] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "初到刺桐城就遇到了熟人，但对方行色匆匆，似乎遇到了什么困难？",
		task_item = "",
		task_target = "（可选）到街上看看",
		condition = 60,
		main_task_id = 11101,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11101003,
		pre_operation = 2,
		pre_task_id = {
			11101001
		},
		additional_parameter = {}
	},
	[11101004] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "初到刺桐城就遇到了熟人，但对方行色匆匆，似乎遇到了什么困难？",
		task_item = "",
		task_target = "（可选）到岸边看看",
		condition = 60,
		main_task_id = 11101,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11101004,
		pre_operation = 2,
		pre_task_id = {
			11101001
		},
		additional_parameter = {}
	},
	[11101005] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "初到刺桐城就遇到了熟人，但对方行色匆匆，似乎遇到了什么困难？",
		task_item = "",
		task_target = "找安海了解情况",
		condition = 330001,
		main_task_id = 11101,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11101005,
		pre_operation = 2,
		pre_task_id = {
			11101002
		},
		additional_parameter = {
			5240201
		}
	},
	[11102001] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "折腾了许久，古船总算是安然无恙回港，但需要做的事情还有不少……事已至此，不如先吃顿饭吧？",
		task_item = "",
		task_target = "跟随安海",
		condition = 60,
		main_task_id = 11102,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11102001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11102002] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "折腾了许久，古船总算是安然无恙回港，但需要做的事情还有不少……事已至此，不如先吃顿饭吧？",
		task_item = "",
		task_target = "进入餐厅",
		condition = 60,
		main_task_id = 11102,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11102002,
		pre_operation = 2,
		pre_task_id = {
			11102001
		},
		additional_parameter = {}
	},
	[11103000] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "德化窑的李爷爷年纪大了，有些仍待处理的瓷器素胚搬运困难，想要在巡船节前完成，恐怕有些困难。有什么能帮忙的？",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11103,
		need = 1,
		task_tag = "",
		hide_task = 1,
		task_id = 11103000,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11103001] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "德化窑的李爷爷年纪大了，有些仍待处理的瓷器素胚搬运困难，想要在巡船节前完成，恐怕有些困难。有什么能帮忙的？",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11103,
		need = 1,
		task_tag = "",
		hide_task = 1,
		task_id = 11103001,
		pre_operation = 2,
		pre_task_id = {
			11103000
		},
		additional_parameter = {}
	},
	[11103002] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "德化窑的李爷爷年纪大了，有些仍待处理的瓷器素胚搬运困难，想要在巡船节前完成，恐怕有些困难。有什么能帮忙的？",
		task_item = "",
		task_target = "前往德化窑",
		condition = 60,
		main_task_id = 11103,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11103002,
		pre_operation = 2,
		pre_task_id = {
			11103000
		},
		additional_parameter = {}
	},
	[11103003] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "德化窑的李爷爷年纪大了，有些仍待处理的瓷器素胚搬运困难，想要在巡船节前完成，恐怕有些困难。有什么能帮忙的？",
		task_item = "",
		task_target = "和英招对话",
		condition = 60,
		main_task_id = 11103,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11103003,
		pre_operation = 2,
		pre_task_id = {
			11103002
		},
		additional_parameter = {}
	},
	[11103004] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "德化窑的李爷爷年纪大了，有些仍待处理的瓷器素胚搬运困难，想要在巡船节前完成，恐怕有些困难。有什么能帮忙的？",
		task_item = "",
		task_target = "找到3个素胚",
		condition = 60,
		main_task_id = 11103,
		need = 3,
		task_tag = "",
		hide_task = 0,
		task_id = 11103004,
		pre_operation = 2,
		pre_task_id = {
			11103003
		},
		additional_parameter = {}
	},
	[11103005] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "德化窑的李爷爷年纪大了，有些仍待处理的瓷器素胚搬运困难，想要在巡船节前完成，恐怕有些困难。有什么能帮忙的？",
		task_item = "",
		task_target = "将素胚交给李爷爷",
		condition = 60,
		main_task_id = 11103,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11103005,
		pre_operation = 2,
		pre_task_id = {
			11103004
		},
		additional_parameter = {}
	},
	[11103006] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "德化窑的李爷爷年纪大了，有些仍待处理的瓷器素胚搬运困难，想要在巡船节前完成，恐怕有些困难。有什么能帮忙的？",
		task_target = "拍照留念！",
		condition = 60,
		main_task_id = 11103,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11103006,
		pre_operation = 2,
		pre_task_id = {
			11103901
		},
		additional_parameter = {},
		task_item = {
			{
				77,
				1
			}
		}
	},
	[11103901] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "德化窑的李爷爷年纪大了，有些仍待处理的瓷器素胚搬运困难，想要在巡船节前完成，恐怕有些困难。有什么能帮忙的？",
		task_item = "",
		task_target = "和安海对话",
		condition = 330001,
		main_task_id = 11103,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11103901,
		pre_operation = 2,
		pre_task_id = {
			11103005
		},
		additional_parameter = {
			5240202
		}
	},
	[11104001] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "织染坊遇到了一些困难，坊中的清白源井年代已久，古井下的淤泥堵塞严重，单凭英招一个人有些难以解决。或许麟钰能帮到一些忙？",
		task_item = "",
		task_target = "前往织染坊找小鱼",
		condition = 60,
		main_task_id = 11104,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11104001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11104002] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "织染坊遇到了一些困难，坊中的清白源井年代已久，古井下的淤泥堵塞严重，单凭英招一个人有些难以解决。或许麟钰能帮到一些忙？",
		task_item = "",
		task_target = "清理淤泥",
		condition = 60,
		main_task_id = 11104,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11104002,
		pre_operation = 2,
		pre_task_id = {
			11104001
		},
		additional_parameter = {}
	},
	[11104003] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "织染坊遇到了一些困难，坊中的清白源井年代已久，古井下的淤泥堵塞严重，单凭英招一个人有些难以解决。或许麟钰能帮到一些忙？",
		task_item = "",
		task_target = "搬运染缸",
		condition = 60,
		main_task_id = 11104,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11104003,
		pre_operation = 2,
		pre_task_id = {
			11104001
		},
		additional_parameter = {}
	},
	[11104004] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "织染坊遇到了一些困难，坊中的清白源井年代已久，古井下的淤泥堵塞严重，单凭英招一个人有些难以解决。或许麟钰能帮到一些忙？",
		task_item = "",
		task_target = "和英招聊聊",
		condition = 60,
		main_task_id = 11104,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11104004,
		pre_operation = 2,
		pre_task_id = {
			11104002,
			11104003
		},
		additional_parameter = {}
	},
	[11104005] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "织染坊遇到了一些困难，坊中的清白源井年代已久，古井下的淤泥堵塞严重，单凭英招一个人有些难以解决。或许麟钰能帮到一些忙？",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11104,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11104005,
		pre_operation = 2,
		pre_task_id = {
			11104901
		},
		additional_parameter = {}
	},
	[11104006] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "织染坊遇到了一些困难，坊中的清白源井年代已久，古井下的淤泥堵塞严重，单凭英招一个人有些难以解决。或许麟钰能帮到一些忙？",
		task_item = "",
		task_target = "找王叔交差",
		condition = 60,
		main_task_id = 11104,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11104006,
		pre_operation = 2,
		pre_task_id = {
			11104005
		},
		additional_parameter = {}
	},
	[11104007] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "织染坊遇到了一些困难，坊中的清白源井年代已久，古井下的淤泥堵塞严重，单凭英招一个人有些难以解决。或许麟钰能帮到一些忙？",
		task_item = "",
		task_target = "试试染布吧",
		condition = 60,
		main_task_id = 11104,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11104007,
		pre_operation = 2,
		pre_task_id = {
			11104006
		},
		additional_parameter = {}
	},
	[11104008] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "织染坊遇到了一些困难，坊中的清白源井年代已久，古井下的淤泥堵塞严重，单凭英招一个人有些难以解决。或许麟钰能帮到一些忙？",
		task_target = "拍照留念！",
		condition = 60,
		main_task_id = 11104,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11104008,
		pre_operation = 2,
		pre_task_id = {
			11104007
		},
		additional_parameter = {},
		task_item = {
			{
				77,
				1
			}
		}
	},
	[11104009] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "成功地解决了德化窑与织染坊的困难，现在去把这个消息告诉安海吧。",
		task_item = "",
		task_target = "前往钟楼",
		condition = 60,
		main_task_id = 11104,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11104009,
		pre_operation = 2,
		pre_task_id = {
			11104008
		},
		additional_parameter = {}
	},
	[11104010] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "成功地解决了德化窑与织染坊的困难，现在去把这个消息告诉安海吧。",
		task_item = "",
		task_target = "与安海对话",
		condition = 60,
		main_task_id = 11104,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11104010,
		pre_operation = 2,
		pre_task_id = {
			11104009
		},
		additional_parameter = {}
	},
	[11104011] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "成功地解决了德化窑与织染坊的困难，现在去把这个消息告诉安海吧。",
		task_target = "拍照留念！",
		condition = 60,
		main_task_id = 11104,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11104011,
		pre_operation = 2,
		pre_task_id = {
			11104010
		},
		additional_parameter = {},
		task_item = {
			{
				77,
				1
			}
		}
	},
	[11104901] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "织染坊遇到了一些困难，坊中的清白源井年代已久，古井下的淤泥堵塞严重，单凭英招一个人有些难以解决。或许麟钰能帮到一些忙？",
		task_item = "",
		task_target = "和英招对话",
		condition = 330001,
		main_task_id = 11104,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11104901,
		pre_operation = 2,
		pre_task_id = {
			11104004
		},
		additional_parameter = {
			5240203
		}
	},
	[11105000] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "这几年刺桐港对外交流越来越频繁，不少外地来的客商，也想把自己的货品推销到虚恒各地。一位欧莫菲斯来的首饰商，也有着参与巡船节的想法。",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11105,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11105000,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11105001] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "这几年刺桐港对外交流越来越频繁，不少外地来的客商，也想把自己的货品推销到虚恒各地。一位欧莫菲斯来的首饰商，也有着参与巡船节的想法。",
		task_item = "",
		task_target = "找安海问个好",
		condition = 60,
		main_task_id = 11105,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11105001,
		pre_operation = 2,
		pre_task_id = {
			11105000
		},
		additional_parameter = {}
	},
	[11105002] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "这几年刺桐港对外交流越来越频繁，不少外地来的客商，也想把自己的货品推销到虚恒各地。一位欧莫菲斯来的首饰商，也有着参与巡船节的想法。",
		task_item = "",
		task_target = "寻找首饰店老板",
		condition = 60,
		main_task_id = 11105,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11105002,
		pre_operation = 2,
		pre_task_id = {
			11105001
		},
		additional_parameter = {}
	},
	[11105003] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "这几年刺桐港对外交流越来越频繁，不少外地来的客商，也想把自己的货品推销到虚恒各地。一位欧莫菲斯来的首饰商，也有着参与巡船节的想法。",
		task_item = "",
		task_target = "前往天禄贸易仓库",
		condition = 330002,
		main_task_id = 11105,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11105003,
		pre_operation = 2,
		pre_task_id = {
			11105002
		},
		additional_parameter = {
			5240221
		}
	},
	[11105004] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "这几年刺桐港对外交流越来越频繁，不少外地来的客商，也想把自己的货品推销到虚恒各地。一位欧莫菲斯来的首饰商，也有着参与巡船节的想法。",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11105,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11105004,
		pre_operation = 2,
		pre_task_id = {
			11105003
		},
		additional_parameter = {}
	},
	[11105005] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "这几年刺桐港对外交流越来越频繁，不少外地来的客商，也想把自己的货品推销到虚恒各地。一位欧莫菲斯来的首饰商，也有着参与巡船节的想法。",
		task_item = "",
		task_target = "送回原石",
		condition = 60,
		main_task_id = 11105,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11105005,
		pre_operation = 2,
		pre_task_id = {
			11105004
		},
		additional_parameter = {}
	},
	[11105006] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "这几年刺桐港对外交流越来越频繁，不少外地来的客商，也想把自己的货品推销到虚恒各地。一位欧莫菲斯来的首饰商，也有着参与巡船节的想法。",
		task_target = "拍照留念！",
		condition = 60,
		main_task_id = 11105,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11105006,
		pre_operation = 2,
		pre_task_id = {
			11105901
		},
		additional_parameter = {},
		task_item = {
			{
				77,
				1
			}
		}
	},
	[11105901] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "这几年刺桐港对外交流越来越频繁，不少外地来的客商，也想把自己的货品推销到虚恒各地。一位欧莫菲斯来的首饰商，也有着参与巡船节的想法。",
		task_item = "",
		task_target = "和英招对话",
		condition = 330001,
		main_task_id = 11105,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11105901,
		pre_operation = 2,
		pre_task_id = {
			11105005
		},
		additional_parameter = {
			5240204
		}
	},
	[11106001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "原本信心十足参展的特质调味酱，似乎出了些问题，让来自夏什瓦特的阿玛尔塔不知所措。一起去看看到底发生了什么吧？",
		task_item = "",
		task_target = "去酱料店看看",
		condition = 60,
		main_task_id = 11106,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11106001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11106002] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "原本信心十足参展的特质调味酱，似乎出了些问题，让来自夏什瓦特的阿玛尔塔不知所措。一起去看看到底发生了什么吧？",
		task_item = "",
		task_target = "去买材料",
		condition = 60,
		main_task_id = 11106,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11106002,
		pre_operation = 2,
		pre_task_id = {
			11106001
		},
		additional_parameter = {}
	},
	[11106003] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "原本信心十足参展的特质调味酱，似乎出了些问题，让来自夏什瓦特的阿玛尔塔不知所措。一起去看看到底发生了什么吧？",
		task_item = "",
		task_target = "挑选香料",
		condition = 60,
		main_task_id = 11106,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11106003,
		pre_operation = 2,
		pre_task_id = {
			11106002
		},
		additional_parameter = {}
	},
	[11106004] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "原本信心十足参展的特质调味酱，似乎出了些问题，让来自夏什瓦特的阿玛尔塔不知所措。一起去看看到底发生了什么吧？",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11106,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11106004,
		pre_operation = 2,
		pre_task_id = {
			11106003
		},
		additional_parameter = {}
	},
	[11106005] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "原本信心十足参展的特质调味酱，似乎出了些问题，让来自夏什瓦特的阿玛尔塔不知所措。一起去看看到底发生了什么吧？",
		task_item = "",
		task_target = "回到调料店",
		condition = 60,
		main_task_id = 11106,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11106005,
		pre_operation = 2,
		pre_task_id = {
			11106004
		},
		additional_parameter = {}
	},
	[11106006] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "原本信心十足参展的特质调味酱，似乎出了些问题，让来自夏什瓦特的阿玛尔塔不知所措。一起去看看到底发生了什么吧？",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11106,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11106006,
		pre_operation = 2,
		pre_task_id = {
			11106901
		},
		additional_parameter = {}
	},
	[11106007] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "原本信心十足参展的特质调味酱，似乎出了些问题，让来自夏什瓦特的阿玛尔塔不知所措。一起去看看到底发生了什么吧？",
		task_target = "拍照留念！",
		condition = 60,
		main_task_id = 11106,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11106007,
		pre_operation = 2,
		pre_task_id = {
			11106006
		},
		additional_parameter = {},
		task_item = {
			{
				77,
				1
			}
		}
	},
	[11106008] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "原本信心十足参展的特质调味酱，似乎出了些问题，让来自夏什瓦特的阿玛尔塔不知所措。一起去看看到底发生了什么吧？",
		task_item = "",
		task_target = "前往餐厅",
		condition = 60,
		main_task_id = 11106,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11106008,
		pre_operation = 2,
		pre_task_id = {
			11106007
		},
		additional_parameter = {}
	},
	[11106901] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "原本信心十足参展的特质调味酱，似乎出了些问题，让来自夏什瓦特的阿玛尔塔不知所措。一起去看看到底发生了什么吧？",
		task_item = "",
		task_target = "和禄良对话",
		condition = 330001,
		main_task_id = 11106,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11106901,
		pre_operation = 2,
		pre_task_id = {
			11106005
		},
		additional_parameter = {
			5240205
		}
	},
	[11106902] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "原本信心十足参展的特质调味酱，似乎出了些问题，让来自夏什瓦特的阿玛尔塔不知所措。一起去看看到底发生了什么吧？",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11106,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11106902,
		pre_operation = 2,
		pre_task_id = {
			11106008
		},
		additional_parameter = {}
	},
	[11107001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "远海天幕中正在逐步凝聚的风暴似乎并不是错觉，近岸边也出现了视骸活动的踪迹……到底出了什么问题？",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11107,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11107001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11107002] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "远海天幕中正在逐步凝聚的风暴似乎并不是错觉，近岸边也出现了视骸活动的踪迹……到底出了什么问题？",
		task_item = "",
		task_target = "到石桥边看看",
		condition = 60,
		main_task_id = 11107,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11107002,
		pre_operation = 2,
		pre_task_id = {
			11107001
		},
		additional_parameter = {}
	},
	[11107003] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "远海天幕中正在逐步凝聚的风暴似乎并不是错觉，近岸边也出现了视骸活动的踪迹……到底出了什么问题？",
		task_item = "",
		task_target = "和陆吾对话",
		condition = 60,
		main_task_id = 11107,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11107003,
		pre_operation = 2,
		pre_task_id = {
			11107002
		},
		additional_parameter = {}
	},
	[11107004] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "远海天幕中正在逐步凝聚的风暴似乎并不是错觉，近岸边也出现了视骸活动的踪迹……到底出了什么问题？",
		task_item = "",
		task_target = "调查1号监测水面",
		condition = 60,
		main_task_id = 11107,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11107004,
		pre_operation = 2,
		pre_task_id = {
			11107003
		},
		additional_parameter = {}
	},
	[11107005] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "远海天幕中正在逐步凝聚的风暴似乎并不是错觉，近岸边也出现了视骸活动的踪迹……到底出了什么问题？",
		task_item = "",
		task_target = "调查2号监测水面",
		condition = 60,
		main_task_id = 11107,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11107005,
		pre_operation = 2,
		pre_task_id = {
			11107003
		},
		additional_parameter = {}
	},
	[11107006] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "远海天幕中正在逐步凝聚的风暴似乎并不是错觉，近岸边也出现了视骸活动的踪迹……到底出了什么问题？",
		task_item = "",
		task_target = "返回石桥",
		condition = 60,
		main_task_id = 11107,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11107006,
		pre_operation = 2,
		pre_task_id = {
			11107004,
			11107005
		},
		additional_parameter = {}
	},
	[11107007] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "远海天幕中正在逐步凝聚的风暴似乎并不是错觉，近岸边也出现了视骸活动的踪迹……到底出了什么问题？",
		task_item = "",
		task_target = "前往防波堤",
		condition = 330002,
		main_task_id = 11107,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11107007,
		pre_operation = 2,
		pre_task_id = {
			11107006
		},
		additional_parameter = {
			5240222
		}
	},
	[11107008] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "远海天幕中正在逐步凝聚的风暴似乎并不是错觉，近岸边也出现了视骸活动的踪迹……到底出了什么问题？",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11107,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11107008,
		pre_operation = 2,
		pre_task_id = {
			11107007
		},
		additional_parameter = {}
	},
	[11107009] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "远海天幕中正在逐步凝聚的风暴似乎并不是错觉，近岸边也出现了视骸活动的踪迹……到底出了什么问题？",
		task_item = "",
		task_target = "出航调查",
		condition = 60,
		main_task_id = 11107,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11107009,
		pre_operation = 2,
		pre_task_id = {
			11107008
		},
		additional_parameter = {}
	},
	[11107010] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "远海天幕中正在逐步凝聚的风暴似乎并不是错觉，近岸边也出现了视骸活动的踪迹……到底出了什么问题？",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11107,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11107010,
		pre_operation = 2,
		pre_task_id = {
			11107901
		},
		additional_parameter = {}
	},
	[11107901] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "远海天幕中正在逐步凝聚的风暴似乎并不是错觉，近岸边也出现了视骸活动的踪迹……到底出了什么问题？",
		task_item = "",
		task_target = "和禄良对话",
		condition = 330001,
		main_task_id = 11107,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11107901,
		pre_operation = 2,
		pre_task_id = {
			11107009
		},
		additional_parameter = {
			5240206
		}
	},
	[11108001] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "刺桐的渔船都已经归航，但风暴仍然在持续，肩上的责任催促着麟钰迈开步伐，向刺桐人的希冀奋勇前行。",
		task_item = "",
		task_target = "去桥边看看",
		condition = 60,
		main_task_id = 11108,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11108001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11108002] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "刺桐的渔船都已经归航，但风暴仍然在持续，肩上的责任催促着麟钰迈开步伐，向刺桐人的希冀奋勇前行。",
		task_item = "",
		task_target = "石敢当的神力",
		condition = 60,
		main_task_id = 11108,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11108002,
		pre_operation = 2,
		pre_task_id = {
			11108001
		},
		additional_parameter = {}
	},
	[11108003] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "刺桐的渔船都已经归航，但风暴仍然在持续，肩上的责任催促着麟钰迈开步伐，向刺桐人的希冀奋勇前行。",
		task_item = "",
		task_target = "再次出航！",
		condition = 60,
		main_task_id = 11108,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11108003,
		pre_operation = 2,
		pre_task_id = {
			11108002
		},
		additional_parameter = {}
	},
	[11108004] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "刺桐的渔船都已经归航，但风暴仍然在持续，肩上的责任催促着麟钰迈开步伐，向刺桐人的希冀奋勇前行。",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11108,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11108004,
		pre_operation = 2,
		pre_task_id = {
			11108901
		},
		additional_parameter = {}
	},
	[11108005] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "刺桐的渔船都已经归航，但风暴仍然在持续，肩上的责任催促着麟钰迈开步伐，向刺桐人的希冀奋勇前行。",
		task_item = "",
		task_target = "前往灯塔",
		condition = 60,
		main_task_id = 11108,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11108005,
		pre_operation = 2,
		pre_task_id = {
			11108004
		},
		additional_parameter = {}
	},
	[11108006] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "刺桐的渔船都已经归航，但风暴仍然在持续，肩上的责任催促着麟钰迈开步伐，向刺桐人的希冀奋勇前行。",
		task_target = "拍照留念！",
		condition = 60,
		main_task_id = 11108,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11108006,
		pre_operation = 2,
		pre_task_id = {
			11108005
		},
		additional_parameter = {},
		task_item = {
			{
				77,
				1
			}
		}
	},
	[11108901] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "刺桐的渔船都已经归航，但风暴仍然在持续，肩上的责任催促着麟钰迈开步伐，向刺桐人的希冀奋勇前行。",
		task_item = "",
		task_target = "和陆吾对话",
		condition = 330001,
		main_task_id = 11108,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11108901,
		pre_operation = 2,
		pre_task_id = {
			11108003
		},
		additional_parameter = {
			5240207
		}
	},
	[11109000] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11109,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11109000,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11109001] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11109,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11109001,
		pre_operation = 2,
		pre_task_id = {
			11109000
		},
		additional_parameter = {}
	},
	[11201001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "平静的海边，却站着一个并不平静的男孩，他是为什么展露出了伤心的表情？",
		task_item = "",
		task_target = "询问男孩发生了什么",
		condition = 60,
		main_task_id = 11211,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11201001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11201002] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "平静的海边，却站着一个并不平静的男孩，他是为什么展露出了伤心的表情？",
		task_item = "",
		task_target = "找个没人的地方施展法术",
		condition = 60,
		main_task_id = 11201,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11201002,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11201003] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "平静的海边，却站着一个并不平静的男孩，他是为什么展露出了伤心的表情？",
		task_item = "",
		task_target = "找出男孩的玻璃罐",
		condition = 60,
		main_task_id = 11201,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11201003,
		pre_operation = 2,
		pre_task_id = {
			11201002
		},
		additional_parameter = {}
	},
	[11201004] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "平静的海边，却站着一个并不平静的男孩，他是为什么展露出了伤心的表情？",
		task_item = "",
		task_target = "将玻璃罐交还给男孩",
		condition = 60,
		main_task_id = 11201,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11201004,
		pre_operation = 2,
		pre_task_id = {
			11201003
		},
		additional_parameter = {}
	},
	[11202001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "在大街上如果发现了有神能波动的物品，该怎么偷偷处理掉比较好呢？真是让人伤脑筋……",
		task_item = "",
		task_target = "找到四方院同事",
		condition = 60,
		main_task_id = 11212,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11202001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11202002] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "在大街上如果发现了有神能波动的物品，该怎么偷偷处理掉比较好呢？真是让人伤脑筋……",
		task_item = "",
		task_target = "尝试对石敢当灌注一些神能",
		condition = 60,
		main_task_id = 11202,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11202002,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11202003] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "在大街上如果发现了有神能波动的物品，该怎么偷偷处理掉比较好呢？真是让人伤脑筋……",
		task_item = "",
		task_target = "找到三个飞散的石敢当",
		condition = 60,
		main_task_id = 11202,
		need = 3,
		task_tag = "",
		hide_task = 0,
		task_id = 11202003,
		pre_operation = 2,
		pre_task_id = {
			11202002
		},
		additional_parameter = {}
	},
	[11202004] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "在大街上如果发现了有神能波动的物品，该怎么偷偷处理掉比较好呢？真是让人伤脑筋……",
		task_item = "",
		task_target = "找到第二个飞散的石敢当",
		condition = 60,
		main_task_id = 11202,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11202004,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11202005] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "在大街上如果发现了有神能波动的物品，该怎么偷偷处理掉比较好呢？真是让人伤脑筋……",
		task_item = "",
		task_target = "找到第三个飞散的石敢当",
		condition = 60,
		main_task_id = 11202,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11202005,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11202006] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "在大街上如果发现了有神能波动的物品，该怎么偷偷处理掉比较好呢？真是让人伤脑筋……",
		task_item = "",
		task_target = "回到发现石敢当的原处",
		condition = 60,
		main_task_id = 11202,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11202006,
		pre_operation = 2,
		pre_task_id = {
			11202003
		},
		additional_parameter = {}
	},
	[11203001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "平时会在终端上挂着委托平台的麟钰，收到了来自附近的一则特殊委托，是来自一家人工智能企业的，一线业务员的求助……",
		task_item = "",
		task_target = "听听科鲁兹工作人员的苦恼",
		condition = 60,
		main_task_id = 11213,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11203001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11203002] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "平时会在终端上挂着委托平台的麟钰，收到了来自附近的一则特殊委托，是来自一家人工智能企业的，一线业务员的求助……",
		task_item = "",
		task_target = "使用秘钥接入售货机",
		condition = 60,
		main_task_id = 11203,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11203002,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11203003] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "平时会在终端上挂着委托平台的麟钰，收到了来自附近的一则特殊委托，是来自一家人工智能企业的，一线业务员的求助……",
		task_item = "",
		task_target = "尝试和智能售货机对话",
		condition = 60,
		main_task_id = 11203,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11203003,
		pre_operation = 2,
		pre_task_id = {
			11203002
		},
		additional_parameter = {}
	},
	[11203004] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "平时会在终端上挂着委托平台的麟钰，收到了来自附近的一则特殊委托，是来自一家人工智能企业的，一线业务员的求助……",
		task_item = "",
		task_target = "回复科鲁兹工作人员",
		condition = 60,
		main_task_id = 11203,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11203004,
		pre_operation = 2,
		pre_task_id = {
			11203003
		},
		additional_parameter = {}
	},
	[11206001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "不经历过一次熊孩子的捣蛋事件，你永远不知道一个母亲会在一瞬间爆发出多大的怒火……",
		task_item = "",
		task_target = "听听年轻母亲的苦恼",
		condition = 60,
		main_task_id = 11216,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11206001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11206002] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "不经历过一次熊孩子的捣蛋事件，你永远不知道一个母亲会在一瞬间爆发出多大的怒火……",
		task_item = "",
		task_target = "找个隐秘的地方释放神能",
		condition = 60,
		main_task_id = 11206,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11206002,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11206003] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "不经历过一次熊孩子的捣蛋事件，你永远不知道一个母亲会在一瞬间爆发出多大的怒火……",
		task_item = "",
		task_target = "找到失散的数学作业",
		condition = 60,
		main_task_id = 11206,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11206003,
		pre_operation = 2,
		pre_task_id = {
			11206002
		},
		additional_parameter = {}
	},
	[11206004] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "不经历过一次熊孩子的捣蛋事件，你永远不知道一个母亲会在一瞬间爆发出多大的怒火……",
		task_item = "",
		task_target = "找到失散的物理作业",
		condition = 60,
		main_task_id = 11206,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11206004,
		pre_operation = 2,
		pre_task_id = {
			11206002
		},
		additional_parameter = {}
	},
	[11206005] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "不经历过一次熊孩子的捣蛋事件，你永远不知道一个母亲会在一瞬间爆发出多大的怒火……",
		task_item = "",
		task_target = "找到失散的地理作业",
		condition = 60,
		main_task_id = 11206,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11206005,
		pre_operation = 2,
		pre_task_id = {
			11206002
		},
		additional_parameter = {}
	},
	[11206006] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "不经历过一次熊孩子的捣蛋事件，你永远不知道一个母亲会在一瞬间爆发出多大的怒火……",
		task_item = "",
		task_target = "回去听听年轻母亲的想法",
		condition = 60,
		main_task_id = 11206,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11206006,
		pre_operation = 2,
		pre_task_id = {
			11206003,
			11206004,
			11206005
		},
		additional_parameter = {}
	},
	[11207000] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "开元寺里好不热闹，大家都在这里求签解签，想沾沾福气。没想到树边，男孩和女孩却因为福签的事情苦恼着……",
		task_item = "",
		task_target = "来自工作人员的邀请",
		condition = 60,
		main_task_id = 11217,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11207000,
		pre_operation = 1,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11207001] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "开元寺里好不热闹，大家都在这里求签解签，想沾沾福气。没想到树边，男孩和女孩却因为福签的事情苦恼着……",
		task_item = "",
		task_target = "听听两人在焦急什么",
		condition = 60,
		main_task_id = 11207,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11207001,
		pre_operation = 2,
		pre_task_id = {
			11207004
		},
		additional_parameter = {}
	},
	[11207002] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "开元寺里好不热闹，大家都在这里求签解签，想沾沾福气。没想到树边，男孩和女孩却因为福签的事情苦恼着……",
		task_item = "",
		task_target = "找工作人员拿回正确的福签",
		condition = 60,
		main_task_id = 11207,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11207002,
		pre_operation = 2,
		pre_task_id = {
			11207001
		},
		additional_parameter = {}
	},
	[11207003] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "开元寺里好不热闹，大家都在这里求签解签，想沾沾福气。没想到树边，男孩和女孩却因为福签的事情苦恼着……",
		task_item = "",
		task_target = "将正确的福签交给两人",
		condition = 60,
		main_task_id = 11207,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11207003,
		pre_operation = 2,
		pre_task_id = {
			11207002
		},
		additional_parameter = {}
	},
	[11207004] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "开元寺里好不热闹，大家都在这里求签解签，想沾沾福气。没想到树边，男孩和女孩却因为福签的事情苦恼着……",
		task_item = "",
		task_target = "进入开元寺",
		condition = 60,
		main_task_id = 11207,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11207004,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11208001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "让你不去钓鱼，你偏要去，公司出了事不知道，这下老实了吧？一天就知道钓鱼，钓鱼，再钓下去，你干脆跟鱼去过算了。——郝嫂如是说",
		task_item = "",
		task_target = "问问郝大哥为什么叹气",
		condition = 60,
		main_task_id = 11218,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11208001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11208002] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "让你不去钓鱼，你偏要去，公司出了事不知道，这下老实了吧？一天就知道钓鱼，钓鱼，再钓下去，你干脆跟鱼去过算了。——郝嫂如是说",
		task_item = "",
		task_target = "找郝大哥的渔友传个话",
		condition = 60,
		main_task_id = 11208,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11208002,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11208003] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "让你不去钓鱼，你偏要去，公司出了事不知道，这下老实了吧？一天就知道钓鱼，钓鱼，再钓下去，你干脆跟鱼去过算了。——郝嫂如是说",
		task_item = "",
		task_target = "听听郝大哥如何反应",
		condition = 60,
		main_task_id = 11208,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11208003,
		pre_operation = 2,
		pre_task_id = {
			11208002
		},
		additional_parameter = {}
	},
	[11209001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "风暴虽然已经结束，但四方院仍然有一些善后事宜需要处理。",
		task_item = "",
		task_target = "听听四方院成员的问题",
		condition = 60,
		main_task_id = 11219,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11209001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11209000] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "风暴虽然已经结束，但四方院仍然有一些善后事宜需要处理。",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11209,
		need = 1,
		task_tag = "",
		hide_task = 1,
		task_id = 11209000,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11209002] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "风暴虽然已经结束，但四方院仍然有一些善后事宜需要处理。",
		task_item = "",
		task_target = "尝试捕捉天后宫前的石敢当",
		condition = 60,
		main_task_id = 11209,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11209002,
		pre_operation = 2,
		pre_task_id = {
			11209000
		},
		additional_parameter = {}
	},
	[11209003] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "风暴虽然已经结束，但四方院仍然有一些善后事宜需要处理。",
		task_item = "",
		task_target = "尝试捕捉景观码头的石敢当",
		condition = 60,
		main_task_id = 11209,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11209003,
		pre_operation = 2,
		pre_task_id = {
			11209000
		},
		additional_parameter = {}
	},
	[11209004] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "风暴虽然已经结束，但四方院仍然有一些善后事宜需要处理。",
		task_item = "",
		task_target = "尝试捕捉开元寺内的石敢当",
		condition = 60,
		main_task_id = 11209,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11209004,
		pre_operation = 2,
		pre_task_id = {
			11209000
		},
		additional_parameter = {}
	},
	[11209005] = {
		task_blueprint_sign = 0,
		is_unload = 1,
		main_description = "风暴虽然已经结束，但四方院仍然有一些善后事宜需要处理。",
		task_item = "",
		task_target = "询问成员完成情况",
		condition = 60,
		main_task_id = 11209,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11209005,
		pre_operation = 2,
		pre_task_id = {
			11209002,
			11209003,
			11209004
		},
		additional_parameter = {}
	},
	[11307001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_target = "",
		condition = 60,
		main_task_id = 11307,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11307001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {},
		task_item = {
			{
				77,
				1
			}
		}
	},
	[11308001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_target = "",
		condition = 60,
		main_task_id = 11308,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11308001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {},
		task_item = {
			{
				77,
				1
			}
		}
	},
	[11309001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_target = "",
		condition = 60,
		main_task_id = 11309,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11309001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {},
		task_item = {
			{
				77,
				1
			}
		}
	},
	[11310001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_target = "",
		condition = 60,
		main_task_id = 11310,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11310001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {},
		task_item = {
			{
				77,
				1
			}
		}
	},
	[11311001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11311,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11311001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11312001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11312,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11312001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11313001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11313,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11313001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11314001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11314,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11314001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11315001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11315,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11315001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11321001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11321,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11321001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11322001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11322,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11322001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11323001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11323,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11323001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11324001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11324,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11324001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11331001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11331,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11331001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11332001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11332,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11332001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11333001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11333,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11333001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11334001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11334,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11334001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11335001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11335,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11335001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11336001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11336,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11336001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11341001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11341,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11341001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11342001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11342,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11342001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11343001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11343,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11343001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11344001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11344,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11344001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11345001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11345,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11345001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11346001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11346,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11346001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11347001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11347,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11347001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11348001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11348,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11348001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11349001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11349,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11349001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	[11350001] = {
		task_blueprint_sign = 0,
		is_unload = 0,
		main_description = "",
		task_item = "",
		task_target = "",
		condition = 60,
		main_task_id = 11350,
		need = 1,
		task_tag = "",
		hide_task = 0,
		task_id = 11350001,
		pre_operation = 2,
		pre_task_id = {},
		additional_parameter = {}
	},
	get_id_list_by_main_task_id = {
		[11350] = {
			11350001
		},
		[11349] = {
			11349001
		},
		[11348] = {
			11348001
		},
		[11347] = {
			11347001
		},
		[11346] = {
			11346001
		},
		[11345] = {
			11345001
		},
		[11344] = {
			11344001
		},
		[11343] = {
			11343001
		},
		[11342] = {
			11342001
		},
		[11341] = {
			11341001
		},
		[11336] = {
			11336001
		},
		[11335] = {
			11335001
		},
		[11334] = {
			11334001
		},
		[11333] = {
			11333001
		},
		[11332] = {
			11332001
		},
		[11331] = {
			11331001
		},
		[11324] = {
			11324001
		},
		[11323] = {
			11323001
		},
		[11322] = {
			11322001
		},
		[11321] = {
			11321001
		},
		[11315] = {
			11315001
		},
		[11314] = {
			11314001
		},
		[11313] = {
			11313001
		},
		[11312] = {
			11312001
		},
		[11311] = {
			11311001
		},
		[11310] = {
			11310001
		},
		[11309] = {
			11309001
		},
		[11308] = {
			11308001
		},
		[11307] = {
			11307001
		},
		[11209] = {
			11209000,
			11209002,
			11209003,
			11209004,
			11209005
		},
		[11219] = {
			11209001
		},
		[11208] = {
			11208002,
			11208003
		},
		[11218] = {
			11208001
		},
		[11207] = {
			11207001,
			11207002,
			11207003,
			11207004
		},
		[11217] = {
			11207000
		},
		[11206] = {
			11206002,
			11206003,
			11206004,
			11206005,
			11206006
		},
		[11216] = {
			11206001
		},
		[11203] = {
			11203002,
			11203003,
			11203004
		},
		[11213] = {
			11203001
		},
		[11202] = {
			11202002,
			11202003,
			11202004,
			11202005,
			11202006
		},
		[11212] = {
			11202001
		},
		[11201] = {
			11201002,
			11201003,
			11201004
		},
		[11211] = {
			11201001
		},
		[11109] = {
			11109000,
			11109001
		},
		[11108] = {
			11108001,
			11108002,
			11108003,
			11108004,
			11108005,
			11108006,
			11108901
		},
		[11107] = {
			11107001,
			11107002,
			11107003,
			11107004,
			11107005,
			11107006,
			11107007,
			11107008,
			11107009,
			11107010,
			11107901
		},
		[11106] = {
			11106001,
			11106002,
			11106003,
			11106004,
			11106005,
			11106006,
			11106007,
			11106008,
			11106901,
			11106902
		},
		[11105] = {
			11105000,
			11105001,
			11105002,
			11105003,
			11105004,
			11105005,
			11105006,
			11105901
		},
		[11104] = {
			11104001,
			11104002,
			11104003,
			11104004,
			11104005,
			11104006,
			11104007,
			11104008,
			11104009,
			11104010,
			11104011,
			11104901
		},
		[11103] = {
			11103000,
			11103001,
			11103002,
			11103003,
			11103004,
			11103005,
			11103006,
			11103901
		},
		[11102] = {
			11102001,
			11102002
		},
		[11101] = {
			11101001,
			11101002,
			11101003,
			11101004,
			11101005
		},
		[11199] = {
			11199001
		},
		[10404] = {
			10404001
		},
		[10403] = {
			10403001
		},
		[10402] = {
			10402001
		},
		[10401] = {
			10401001
		},
		[10362] = {
			10362001
		},
		[10361] = {
			10361001
		},
		[10360] = {
			10360001
		},
		[10359] = {
			10359001
		},
		[10358] = {
			10358001
		},
		[10357] = {
			10357001
		},
		[10356] = {
			10356001
		},
		[10355] = {
			10355001
		},
		[10354] = {
			10354001
		},
		[10353] = {
			10353001
		},
		[10352] = {
			10352001
		},
		[10350] = {
			10350001
		},
		[10348] = {
			10348001,
			10348002,
			10348003
		},
		[10347] = {
			10347001,
			10347002,
			10347003
		},
		[10346] = {
			10346001,
			10346002,
			10346003
		},
		[10345] = {
			10345001,
			10345002,
			10345003
		},
		[10334] = {
			10334001
		},
		[10333] = {
			10333001
		},
		[10332] = {
			10332001
		},
		[10331] = {
			10331001
		},
		[10330] = {
			10330001
		},
		[10329] = {
			10329001
		},
		[10328] = {
			10328001
		},
		[10327] = {
			10327001
		},
		[10326] = {
			10326001
		},
		[10325] = {
			10325001
		},
		[10322] = {
			10322001
		},
		[10321] = {
			10321001
		},
		[10320] = {
			10320001
		},
		[10315] = {
			10315001
		},
		[10314] = {
			10314001
		},
		[10313] = {
			10313001
		},
		[10312] = {
			10312001
		},
		[10311] = {
			10311001
		},
		[10310] = {
			10310001
		},
		[10309] = {
			10309001
		},
		[10308] = {
			10308001
		},
		[10307] = {
			10307001
		},
		[10306] = {
			10306001
		},
		[10305] = {
			10305001
		},
		[10304] = {
			10304001
		},
		[10303] = {
			10303001
		},
		[10302] = {
			10302001
		},
		[10118] = {
			10118001
		},
		[10117] = {
			10117001
		},
		[10115] = {
			10115001,
			10115002
		},
		[10114] = {
			10114001
		},
		[10113] = {
			10113001
		},
		[10112] = {
			10112001
		},
		[10111] = {
			10111001
		},
		[10110] = {
			10110001
		},
		[10109] = {
			10109001
		},
		[10108] = {
			10108001,
			10108002,
			10108003,
			10108004,
			10108005,
			10108006
		},
		[10107] = {
			10107001
		},
		[10106] = {
			10106001
		},
		[10116] = {
			10105004
		},
		[10105] = {
			10105001,
			10105002,
			10105003
		},
		[10104] = {
			10104001,
			10104002
		},
		[10103] = {
			10103001,
			10103002,
			10103003
		},
		[10102] = {
			10102001,
			10102002
		},
		[10101] = {
			10101001
		},
		[202] = {
			202
		},
		[201] = {
			201
		},
		[101] = {
			101,
			102,
			103,
			104,
			105,
			106,
			107,
			108,
			109
		}
	},
	all = {
		101,
		102,
		103,
		104,
		105,
		106,
		107,
		108,
		109,
		201,
		202,
		10101001,
		10102001,
		10102002,
		10103001,
		10103002,
		10103003,
		10104001,
		10104002,
		10105001,
		10105002,
		10105003,
		10105004,
		10106001,
		10107001,
		10108001,
		10108002,
		10108003,
		10108004,
		10108005,
		10108006,
		10109001,
		10110001,
		10111001,
		10112001,
		10113001,
		10114001,
		10115001,
		10115002,
		10117001,
		10118001,
		10302001,
		10303001,
		10304001,
		10305001,
		10306001,
		10307001,
		10308001,
		10309001,
		10310001,
		10311001,
		10312001,
		10313001,
		10314001,
		10315001,
		10320001,
		10321001,
		10322001,
		10325001,
		10326001,
		10327001,
		10328001,
		10329001,
		10330001,
		10331001,
		10332001,
		10333001,
		10334001,
		10345001,
		10345002,
		10345003,
		10346001,
		10346002,
		10346003,
		10347001,
		10347002,
		10347003,
		10348001,
		10348002,
		10348003,
		10350001,
		10352001,
		10353001,
		10354001,
		10355001,
		10356001,
		10357001,
		10358001,
		10359001,
		10360001,
		10361001,
		10362001,
		10401001,
		10402001,
		10403001,
		10404001,
		11199001,
		11101001,
		11101002,
		11101003,
		11101004,
		11101005,
		11102001,
		11102002,
		11103000,
		11103001,
		11103002,
		11103003,
		11103004,
		11103005,
		11103006,
		11103901,
		11104001,
		11104002,
		11104003,
		11104004,
		11104005,
		11104006,
		11104007,
		11104008,
		11104009,
		11104010,
		11104011,
		11104901,
		11105000,
		11105001,
		11105002,
		11105003,
		11105004,
		11105005,
		11105006,
		11105901,
		11106001,
		11106002,
		11106003,
		11106004,
		11106005,
		11106006,
		11106007,
		11106008,
		11106901,
		11106902,
		11107001,
		11107002,
		11107003,
		11107004,
		11107005,
		11107006,
		11107007,
		11107008,
		11107009,
		11107010,
		11107901,
		11108001,
		11108002,
		11108003,
		11108004,
		11108005,
		11108006,
		11108901,
		11109000,
		11109001,
		11201001,
		11201002,
		11201003,
		11201004,
		11202001,
		11202002,
		11202003,
		11202004,
		11202005,
		11202006,
		11203001,
		11203002,
		11203003,
		11203004,
		11206001,
		11206002,
		11206003,
		11206004,
		11206005,
		11206006,
		11207000,
		11207001,
		11207002,
		11207003,
		11207004,
		11208001,
		11208002,
		11208003,
		11209001,
		11209000,
		11209002,
		11209003,
		11209004,
		11209005,
		11307001,
		11308001,
		11309001,
		11310001,
		11311001,
		11312001,
		11313001,
		11314001,
		11315001,
		11321001,
		11322001,
		11323001,
		11324001,
		11331001,
		11332001,
		11333001,
		11334001,
		11335001,
		11336001,
		11341001,
		11342001,
		11343001,
		11344001,
		11345001,
		11346001,
		11347001,
		11348001,
		11349001,
		11350001
	}
}
