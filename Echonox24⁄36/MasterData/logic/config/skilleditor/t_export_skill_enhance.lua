-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/skilleditor/t_export_skill_enhance.lua

module("logic.config.skilleditor.t_export_skill_enhance", package.seeall)

local configData = {
	{
		skillCode = 10001,
		name = "未知",
		remarks = "",
		newDesc = "",
		modDesc = "测试修改描述，普通数值<effect-1_action-1_damageRate>",
		code = 10001001,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.123",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 10001,
		name = "未知",
		remarks = "",
		newDesc = "",
		modDesc = "测试修改描述，百分比<effect-1_action-1_damageRate%%>",
		code = 10001002,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.234",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 10001,
		name = "未知",
		remarks = "",
		newDesc = "",
		modDesc = "测试修改描述，普通数值<effect-1_action-1_damageRate>",
		code = 10001003,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.345",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 10001,
		name = "未知",
		remarks = "",
		newDesc = "测试替换描述修改描述<effect-1_action-1_damageRate>",
		modDesc = "测试修改描述，普通数值2",
		code = 10001004,
		upgradeType = 2,
		normalConfig = {
			modList = {},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 8,
				timePrograming = "ATTACKING_ENDED",
				conditionList = {
					{
						code = -1
					}
				},
				actionList = {
					{
						referRate = 1,
						code = 20001,
						referAtr = 51
					}
				}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 10002,
		name = "未知",
		remarks = "",
		newDesc = "",
		modDesc = "测试修改描述，普通数值<effect-1_action-1_damageRate>",
		code = 10002001,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.123",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 10002,
		name = "未知",
		remarks = "",
		newDesc = "",
		modDesc = "测试修改描述，普通数值<effect-1_action-1_damageRate>",
		code = 10002002,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.234",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 10002,
		name = "未知",
		remarks = "",
		newDesc = "",
		modDesc = "测试修改描述，普通数值<effect-1_action-1_damageRate>",
		code = 10002003,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.345",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 10002,
		name = "未知",
		remarks = "",
		newDesc = "测试替换描述修改描述<effect-1_action-1_damageRate>",
		modDesc = "测试修改描述，普通数值2",
		code = 10002004,
		upgradeType = 2,
		normalConfig = {
			modList = {},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 8,
				timePrograming = "ATTACKING_ENDED",
				conditionList = {
					{
						code = -1
					}
				},
				actionList = {
					{
						referRate = 1.1,
						code = 20001,
						referAtr = 51
					}
				}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 10003,
		name = "未知",
		remarks = "",
		newDesc = "",
		modDesc = "测试修改描述，普通数值<effect-1_action-1_damageRate>",
		code = 10003001,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.123",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 10003,
		name = "未知",
		remarks = "",
		newDesc = "",
		modDesc = "测试修改描述，普通数值<effect-1_action-1_damageRate>",
		code = 10003002,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.234",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 10003,
		name = "未知",
		remarks = "",
		newDesc = "",
		modDesc = "测试修改描述，普通数值<effect-1_action-1_damageRate>",
		code = 10003003,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.345",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 10003,
		name = "未知",
		remarks = "",
		newDesc = "测试替换描述修改描述<effect-1_action-1_damageRate>",
		modDesc = "测试修改描述，普通数值2",
		code = 10003004,
		upgradeType = 2,
		normalConfig = {
			modList = {},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 8,
				timePrograming = "ATTACKING_ENDED",
				conditionList = {
					{
						code = -1
					}
				},
				actionList = {
					{
						referRate = 1,
						code = 20001,
						referAtr = 51
					}
				}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 10004,
		name = "未知",
		remarks = "",
		newDesc = "",
		modDesc = "测试修改描述，普通数值<effect-1_action-1_damageRate>",
		code = 10004001,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.123",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 10004,
		name = "未知",
		remarks = "",
		newDesc = "",
		modDesc = "测试修改描述，普通数值<effect-1_action-1_damageRate>",
		code = 10004002,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.234",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 10004,
		name = "未知",
		remarks = "",
		newDesc = "",
		modDesc = "测试修改描述，普通数值<effect-1_action-1_damageRate>",
		code = 10004003,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.345",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 10004,
		name = "未知",
		remarks = "",
		newDesc = "",
		modDesc = "测试修改描述，普通数值<effect-1_action-1_damageRate>",
		code = 10004004,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.345",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 10004,
		name = "未知",
		remarks = "",
		newDesc = "",
		modDesc = "测试修改描述，普通数值<effect-1_action-1_damageRate>",
		code = 10004005,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.345",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1100501,
		name = "亲和度I-4",
		remarks = "幻星普攻",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110050101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1100501,
		name = "亲和度III-2",
		remarks = "幻星普攻",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110050102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1100501,
		name = "亲和度IV-4",
		remarks = "幻星普攻",
		newDesc = "",
		modDesc = "减益持续回合+<effect-2_action-1_buffList-1_round>",
		code = 110050103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "buffList-1_round:1",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "buffList-1_round:1",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1100502,
		name = "亲和度II-2",
		remarks = "幻星特殊技",
		newDesc = "",
		modDesc = "治疗比例增加<effect-1_action-1_referRate%%>",
		code = 110050201,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.25",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "referRate:0.25",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1100502,
		name = "亲和度III-4",
		remarks = "幻星特殊技",
		newDesc = "",
		modDesc = "治疗比例增加<effect-1_action-1_referRate%%>",
		code = 110050202,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.25",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "referRate:0.25",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1100502,
		name = "亲和度V-2",
		remarks = "幻星特殊技",
		newDesc = "",
		modDesc = "增益持续回合+<effect-2_action-1_buffList-2_round>",
		code = 110050203,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "buffList-2_round:1",
					type = "effect-2_action-1"
				},
				{
					effectStr = "buffList-1_round:1",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "buffList-1_round:1",
					type = "effect-2_action-1"
				},
				{
					effectStr = "buffList-2_round:1",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1100503,
		name = "亲和度II-4",
		remarks = "幻星大招",
		newDesc = "",
		modDesc = "血量回复比例提高<effect-1_action-1_referRate%%>",
		code = 110050301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "referRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1100503,
		name = "亲和度IV-2",
		remarks = "幻星大招",
		newDesc = "",
		modDesc = "血量回复比例提高<effect-1_action-1_referRate%%>",
		code = 110050302,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "referRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1100503,
		name = "亲和度V-4",
		remarks = "幻星大招",
		newDesc = "",
		modDesc = "血量回复比例提高<effect-1_action-1_referRate%%>",
		code = 110050303,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "referRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1100504,
		name = "心锚I",
		remarks = "幻星天赋",
		newDesc = "",
		modDesc = "血量阈值<effect-1_condition-1_value%%>",
		code = 110050401,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "value:-0.05",
					type = "effect-1_condition-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1100504,
		name = "心锚II",
		remarks = "幻星天赋",
		newDesc = "",
		modDesc = "血量阈值<effect-1_condition-1_value%%>",
		code = 110050402,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "value:-0.05",
					type = "effect-1_condition-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1100504,
		name = "心锚III",
		remarks = "幻星天赋",
		newDesc = "",
		modDesc = "血量阈值<effect-1_condition-1_value%%>",
		code = 110050403,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "value:-0.05",
					type = "effect-1_condition-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1100504,
		name = "心锚IV",
		remarks = "幻星天赋",
		newDesc = "",
		modDesc = "血量阈值<effect-1_condition-1_value%%>",
		code = 110050404,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "value:-0.05",
					type = "effect-1_condition-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1100504,
		name = "心锚V",
		remarks = "幻星天赋",
		newDesc = "",
		modDesc = "血量阈值<effect-1_condition-1_value%%>",
		code = 110050405,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "value:-0.05",
					type = "effect-1_condition-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101101,
		name = "亲和度I-4",
		remarks = "一云普攻",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110110101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101101,
		name = "亲和度III-2",
		remarks = "一云普攻",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110110102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101101,
		name = "亲和度IV-2",
		remarks = "一云普攻",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110110103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101101,
		name = "亲和度IV-4",
		remarks = "一云普攻",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110110104,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101102,
		name = "亲和度II-2",
		remarks = "一云特殊技",
		newDesc = "",
		modDesc = "[先制反击]持续回合数+<effect-2_action-1_buffList-1_round>",
		code = 110110201,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "buffList-1_round:1",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "buffList-1_round:1",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101102,
		name = "未知",
		remarks = "测试用",
		newDesc = "",
		modDesc = "自身范围增加<effect-1_action-1_range>格",
		code = 110110202,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "range:1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101103,
		name = "亲和度II-4",
		remarks = "一云必杀",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110110301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101103,
		name = "亲和度III-4",
		remarks = "一云必杀",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110110302,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101103,
		name = "亲和度V-2",
		remarks = "一云必杀",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110110303,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101103,
		name = "亲和度V-4",
		remarks = "一云必杀",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110110304,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101104,
		name = "心锚I",
		remarks = "一云天赋",
		newDesc = "",
		modDesc = "攻击提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110110401,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101104,
		name = "心锚II",
		remarks = "一云天赋",
		newDesc = "",
		modDesc = "攻击提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110110402,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101104,
		name = "心锚III",
		remarks = "一云天赋",
		newDesc = "",
		modDesc = "攻击提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110110403,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101104,
		name = "心锚IV",
		remarks = "一云天赋",
		newDesc = "",
		modDesc = "攻击提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110110404,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101104,
		name = "心锚V",
		remarks = "一云天赋",
		newDesc = "",
		modDesc = "攻击提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110110405,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101199,
		name = "未知",
		remarks = "一云天赋",
		newDesc = "",
		modDesc = "攻击提高<effect-1_action-1_attrModifies-1_modify%%>，灵感增加<effect-3_action-1_attrModifies-1_modify>",
		code = 110119901,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				},
				{
					effectStr = "attrModifies-1_modify:1",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101199,
		name = "未知",
		remarks = "",
		newDesc = "",
		modDesc = "攻击提高<effect-1_action-1_attrModifies-1_modify%%>，灵感增加<effect-3_action-1_attrModifies-1_modify>",
		code = 110119902,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				},
				{
					effectStr = "attrModifies-1_modify:1",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101199,
		name = "未知",
		remarks = "",
		newDesc = "",
		modDesc = "攻击提高<effect-1_action-1_attrModifies-1_modify%%>，灵感增加<effect-3_action-1_attrModifies-1_modify>",
		code = 110119903,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				},
				{
					effectStr = "attrModifies-1_modify:1",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101199,
		name = "未知",
		remarks = "",
		newDesc = "",
		modDesc = "攻击提高<effect-1_action-1_attrModifies-1_modify%%>，灵感增加<effect-3_action-1_attrModifies-1_modify>",
		code = 110119904,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				},
				{
					effectStr = "attrModifies-1_modify:1",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101199,
		name = "未知",
		remarks = "",
		newDesc = "",
		modDesc = "攻击提高<effect-1_action-1_attrModifies-1_modify%%>，灵感增加<effect-3_action-1_attrModifies-1_modify>",
		code = 110119905,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				},
				{
					effectStr = "attrModifies-1_modify:1",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101201,
		name = "亲和度I-4",
		remarks = "芬里尔普攻",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110120101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101201,
		name = "亲和度III-2",
		remarks = "芬里尔普攻",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110120102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101201,
		name = "亲和度IV-4",
		remarks = "芬里尔普攻",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110120103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101202,
		name = "亲和度II-2",
		remarks = "芬里尔特殊技",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110120201,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101202,
		name = "亲和度III-4",
		remarks = "芬里尔特殊技",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110120202,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101202,
		name = "亲和度V-2",
		remarks = "芬里尔特殊技",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110120203,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101203,
		name = "亲和度II-4",
		remarks = "芬里尔大招",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110120301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.15",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.15",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101203,
		name = "亲和度IV-2",
		remarks = "芬里尔大招",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110120302,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.15",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.15",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101203,
		name = "亲和度V-4",
		remarks = "芬里尔大招",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110120303,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101204,
		name = "心锚I",
		remarks = "芬里尔天赋",
		newDesc = "",
		modDesc = "自身以太额外增加<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110120401,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101204,
		name = "心锚II",
		remarks = "芬里尔天赋",
		newDesc = "",
		modDesc = "自身以太额外增加<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110120402,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101204,
		name = "心锚III",
		remarks = "芬里尔天赋",
		newDesc = "",
		modDesc = "自身以太额外增加<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110120403,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101204,
		name = "心锚IV",
		remarks = "芬里尔天赋",
		newDesc = "",
		modDesc = "自身以太额外增加<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110120404,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101204,
		name = "心锚V",
		remarks = "芬里尔天赋",
		newDesc = "",
		modDesc = "自身以太额外增加<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110120405,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101301,
		name = "亲和度I-4",
		remarks = "安妮薇普攻",
		newDesc = "",
		modDesc = "伤害额外提高<effect-1_action-1_damageRate%%>",
		code = 110130101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101301,
		name = "亲和度II-4",
		remarks = "安妮薇普攻",
		newDesc = "",
		modDesc = "伤害额外提高<effect-1_action-1_damageRate%%>",
		code = 110130102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101301,
		name = "亲和度III-4",
		remarks = "安妮薇普攻",
		newDesc = "",
		modDesc = "伤害额外提高<effect-1_action-1_damageRate%%>",
		code = 110130103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101301,
		name = "亲和度IV-4",
		remarks = "安妮薇普攻",
		newDesc = "",
		modDesc = "伤害额外提高<effect-1_action-1_damageRate%%>",
		code = 110130104,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101302,
		name = "亲和度V-4",
		remarks = "安妮薇特殊技",
		newDesc = "",
		modDesc = "生效对象数量+<effect-1_action-1_count>",
		code = 110130201,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "count:1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101303,
		name = "亲和度II-2",
		remarks = "安妮薇大招",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110130301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101303,
		name = "亲和度III-2",
		remarks = "安妮薇大招",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110130302,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101303,
		name = "亲和度IV-2",
		remarks = "安妮薇大招",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110130303,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101303,
		name = "亲和度V-2",
		remarks = "安妮薇大招",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110130304,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101304,
		name = "心锚突破",
		remarks = "安妮薇天赋",
		newDesc = "",
		modDesc = "自身以太额外提高<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110130401,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101304,
		name = "心锚突破",
		remarks = "安妮薇天赋",
		newDesc = "",
		modDesc = "自身以太额外提高<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110130402,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101304,
		name = "心锚突破",
		remarks = "安妮薇天赋",
		newDesc = "",
		modDesc = "自身以太额外提高<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110130403,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101304,
		name = "心锚突破",
		remarks = "安妮薇天赋",
		newDesc = "",
		modDesc = "自身以太额外提高<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110130404,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101304,
		name = "心锚突破",
		remarks = "安妮薇天赋",
		newDesc = "",
		modDesc = "自身以太额外提高<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110130405,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101601,
		name = "亲和度I-4",
		remarks = "烟火普攻",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110160101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101601,
		name = "亲和度II-2",
		remarks = "烟火普攻",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110160102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101601,
		name = "亲和度III-2",
		remarks = "烟火普攻",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110160103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101603,
		name = "亲和度II-4",
		remarks = "烟火必杀",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110160301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101603,
		name = "亲和度IV-2",
		remarks = "烟火必杀",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110160302,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101603,
		name = "亲和度IV-2",
		remarks = "烟火必杀",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110160303,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.15",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.15",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101603,
		name = "亲和度IV-4",
		remarks = "烟火必杀",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110160304,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.15",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.15",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101604,
		name = "心锚I",
		remarks = "烟火天赋",
		newDesc = "",
		modDesc = "攻击、防御额外提升<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110160401,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				},
				{
					effectStr = "attrModifies-2_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101604,
		name = "心锚II",
		remarks = "烟火天赋",
		newDesc = "",
		modDesc = "攻击、防御额外提升<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110160402,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				},
				{
					effectStr = "attrModifies-2_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101604,
		name = "心锚III",
		remarks = "烟火天赋",
		newDesc = "",
		modDesc = "攻击、防御额外提升<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110160403,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				},
				{
					effectStr = "attrModifies-2_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101604,
		name = "心锚IV",
		remarks = "烟火天赋",
		newDesc = "",
		modDesc = "攻击、防御额外提升<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110160404,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				},
				{
					effectStr = "attrModifies-2_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101604,
		name = "心锚V",
		remarks = "烟火天赋",
		newDesc = "",
		modDesc = "攻击、防御额外提升<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110160405,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				},
				{
					effectStr = "attrModifies-2_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101901,
		name = "亲和度I-4",
		remarks = "多里安普攻",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110190101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101901,
		name = "亲和度II-4",
		remarks = "多里安普攻",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110190102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101901,
		name = "亲和度III-2",
		remarks = "多里安普攻",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110190103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101901,
		name = "亲和度V-2",
		remarks = "多里安普攻",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110190104,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101903,
		name = "亲和度II-2",
		remarks = "多里安大招",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110190301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101903,
		name = "亲和度III-4",
		remarks = "多里安大招",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110190302,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101903,
		name = "亲和度IV-2",
		remarks = "多里安大招",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110190303,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101903,
		name = "亲和度IV-4",
		remarks = "多里安大招",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110190304,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101903,
		name = "亲和度V-4",
		remarks = "多里安大招",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110190305,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101904,
		name = "心锚",
		remarks = "多里安天赋",
		newDesc = "",
		modDesc = "自身攻击额外提高<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110190401,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101904,
		name = "心锚",
		remarks = "多里安天赋",
		newDesc = "",
		modDesc = "自身攻击额外提高<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110190402,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101904,
		name = "心锚",
		remarks = "多里安天赋",
		newDesc = "",
		modDesc = "自身攻击额外提高<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110190403,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101904,
		name = "心锚",
		remarks = "多里安天赋",
		newDesc = "",
		modDesc = "自身攻击额外提高<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110190404,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1101904,
		name = "心锚",
		remarks = "多里安天赋",
		newDesc = "",
		modDesc = "自身攻击额外提高<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110190405,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102001,
		name = "亲和度I-4",
		remarks = "安布蕾拉普攻",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110200101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102001,
		name = "亲和度II-4",
		remarks = "安布蕾拉普攻",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110200102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102001,
		name = "亲和度III-4",
		remarks = "安布蕾拉普攻",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110200103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102001,
		name = "亲和度IV-4",
		remarks = "安布蕾拉普攻",
		newDesc = "",
		modDesc = "最大血量回复比例提高<effect-2_action-1_referRate%%>",
		code = 110200104,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.15",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "referRate:0.15",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102003,
		name = "亲和度II-2",
		remarks = "安布蕾拉必杀",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110200301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102003,
		name = "亲和度III-2",
		remarks = "安布蕾拉必杀",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110200302,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102003,
		name = "亲和度IV-2",
		remarks = "安布蕾拉必杀",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110200303,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102003,
		name = "亲和度V-2",
		remarks = "安布蕾拉必杀",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110200304,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102003,
		name = "亲和度V-4",
		remarks = "安布蕾拉必杀",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110200305,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102004,
		name = "亲和度",
		remarks = "安布蕾拉天赋",
		newDesc = "",
		modDesc = "防御提高<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110200401,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102004,
		name = "亲和度",
		remarks = "安布蕾拉天赋",
		newDesc = "",
		modDesc = "防御提高<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110200402,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102004,
		name = "亲和度",
		remarks = "安布蕾拉天赋",
		newDesc = "",
		modDesc = "防御提高<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110200403,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102004,
		name = "亲和度",
		remarks = "安布蕾拉天赋",
		newDesc = "",
		modDesc = "防御提高<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110200404,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102004,
		name = "亲和度",
		remarks = "安布蕾拉天赋",
		newDesc = "",
		modDesc = "防御提高<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110200405,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102101,
		name = "亲和度I-4",
		remarks = "暮雪普攻",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110210101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102101,
		name = "亲和度III-2",
		remarks = "暮雪普攻",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110210102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102101,
		name = "亲和度IV-4",
		remarks = "暮雪普攻",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110210103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102102,
		name = "亲和度II-2",
		remarks = "暮雪特殊技",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110210201,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102102,
		name = "亲和度III-4",
		remarks = "暮雪特殊技",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110210202,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102102,
		name = "亲和度V-2",
		remarks = "暮雪特殊技",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110210203,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102103,
		name = "亲和度II-4",
		remarks = "暮雪大招",
		newDesc = "",
		modDesc = "对次要目标伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110210301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.125",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.125",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102103,
		name = "亲和度IV-2",
		remarks = "暮雪大招",
		newDesc = "",
		modDesc = "对次要目标伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110210302,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.125",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.125",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102103,
		name = "亲和度V-4",
		remarks = "暮雪大招",
		newDesc = "",
		modDesc = "对次要目标伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110210303,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.125",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.125",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102104,
		name = "心锚I",
		remarks = "暮雪天赋",
		newDesc = "",
		modDesc = "额外忽视<effect-1_action-1_attrModifies-1_modify%%>的防御",
		code = 110210401,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102104,
		name = "心锚II",
		remarks = "暮雪天赋",
		newDesc = "",
		modDesc = "额外忽视<effect-1_action-1_attrModifies-1_modify%%>的防御",
		code = 110210402,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102104,
		name = "心锚III",
		remarks = "暮雪天赋",
		newDesc = "",
		modDesc = "额外忽视<effect-1_action-1_attrModifies-1_modify%%>的防御",
		code = 110210403,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102104,
		name = "心锚IV",
		remarks = "暮雪天赋",
		newDesc = "",
		modDesc = "额外忽视<effect-1_action-1_attrModifies-1_modify%%>的防御",
		code = 110210404,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102104,
		name = "心锚V",
		remarks = "暮雪天赋",
		newDesc = "",
		modDesc = "额外忽视<effect-1_action-1_attrModifies-1_modify%%>的防御",
		code = 110210405,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102201,
		name = "亲和度I-4",
		remarks = "飞鸟普攻",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110220101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102201,
		name = "亲和度III-2",
		remarks = "飞鸟普攻",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110220102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102201,
		name = "亲和度IV-4",
		remarks = "飞鸟普攻",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110220103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102202,
		name = "亲和度II-2",
		remarks = "飞鸟特殊技",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110220201,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102202,
		name = "亲和度III-4",
		remarks = "飞鸟特殊技",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110220202,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102202,
		name = "亲和度V-2",
		remarks = "飞鸟特殊技",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110220203,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102203,
		name = "亲和度II-4",
		remarks = "飞鸟必杀",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110220301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.15",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.15",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102203,
		name = "亲和度IV-2",
		remarks = "飞鸟必杀",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110220302,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.15",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.15",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102203,
		name = "亲和度V-4",
		remarks = "飞鸟必杀",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110220303,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102204,
		name = "心锚I",
		remarks = "飞鸟天赋",
		newDesc = "",
		modDesc = "每格距离伤害额外提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110220401,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.01",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102204,
		name = "心锚II",
		remarks = "飞鸟天赋",
		newDesc = "",
		modDesc = "每格距离灵感额外提高<effect-1_action-1_attrModifies-2_modify>",
		code = 110220402,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-2_modify:1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102204,
		name = "心锚III",
		remarks = "飞鸟天赋",
		newDesc = "",
		modDesc = "每格距离伤害额外提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110220403,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.01",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102204,
		name = "心锚IV",
		remarks = "飞鸟天赋",
		newDesc = "",
		modDesc = "每格距离灵感额外提高<effect-1_action-1_attrModifies-2_modify>",
		code = 110220404,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-2_modify:1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102204,
		name = "心锚V",
		remarks = "飞鸟天赋",
		newDesc = "",
		modDesc = "每格距离伤害额外提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110220405,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.01",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102701,
		name = "亲和度I-4",
		remarks = "赝作普攻",
		newDesc = "",
		modDesc = "伤害额外增加<effect-1_action-1_damageRate%%>",
		code = 110270101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102701,
		name = "亲和度III-2",
		remarks = "赝作普攻",
		newDesc = "",
		modDesc = "伤害额外增加<effect-1_action-1_damageRate%%>",
		code = 110270102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102701,
		name = "亲和度IV-2",
		remarks = "赝作普攻",
		newDesc = "",
		modDesc = "伤害额外增加<effect-1_action-1_damageRate%%>",
		code = 110270103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102702,
		name = "亲和度II-2",
		remarks = "赝作特殊技",
		newDesc = "",
		modDesc = "增益持续时长提升<effect-1_action-1_buffList-1_round>回合",
		code = 110270201,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "buffList-1_round:1#buffList-2_round:1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102702,
		name = "亲和度III-4",
		remarks = "赝作特殊技",
		newDesc = "",
		modDesc = "效果范围提升<effect-1_action-1_shape_range>",
		code = 110270202,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "shape_range:1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102703,
		name = "亲和度II-4",
		remarks = "赝作大招",
		newDesc = "粉碎目标造成<effect-1_action-1_damageRate%%>的以太伤害。攻击后，对目标周围<effect-2_action-1_shape_range>格内所有敌方造成<effect-2_action-1_buffList-1_round>回合[攻击削弱]，[抗性削弱]。<godlikeeffect-2_action-1_buffList-2_round><godlikeeffect-1_action-1_damageRate>新增神化灵感<godlikeaddEffect_action-1_attrModifies-1_modify> \n非神化新增灵感<addEffect_action-1_attrModifies-1_modify>",
		modDesc = "攻击前提升自身7点灵感",
		code = 110270301,
		upgradeType = 2,
		normalConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = 7,
				timePrograming = "ATTACKING_STARTED",
				conditionList = {
					{
						code = -1
					}
				},
				actionList = {
					{
						code = 60001,
						attrModifies = {
							{
								attrId = 5,
								modify = 7
							}
						}
					}
				}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = 7,
				timePrograming = "ATTACKING_STARTED",
				conditionList = {
					{
						code = -1
					}
				},
				actionList = {
					{
						code = 60001,
						attrModifies = {
							{
								attrId = 5,
								modify = 9
							}
						}
					}
				}
			}
		}
	},
	{
		skillCode = 1102703,
		name = "亲和度IV-4",
		remarks = "赝作大招",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110270302,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.3",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102703,
		name = "默契",
		remarks = "赝作大招",
		newDesc = "提高自身7点灵感后,粉碎目标造成<effect-1_action-1_damageRate%%>的以太伤害。",
		modDesc = "攻击前提升自身7点灵感",
		code = 110270305,
		upgradeType = 2,
		normalConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = 7,
				timePrograming = "ATTACKING_STARTED",
				conditionList = {
					{
						code = -1
					}
				},
				actionList = {
					{
						code = 60001,
						attrModifies = {
							{
								attrId = 5,
								modify = 7
							}
						}
					}
				}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = 7,
				timePrograming = "ATTACKING_STARTED",
				conditionList = {
					{
						code = -1
					}
				},
				actionList = {
					{
						code = 60001,
						attrModifies = {
							{
								attrId = 5,
								modify = 7
							}
						}
					}
				}
			}
		}
	},
	{
		skillCode = 1102704,
		name = "心锚I",
		remarks = "赝作天赋",
		newDesc = "",
		modDesc = "防御额外提升<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110270401,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102704,
		name = "心锚II",
		remarks = "赝作天赋",
		newDesc = "",
		modDesc = "防御额外提升<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110270402,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102704,
		name = "心锚III",
		remarks = "赝作天赋",
		newDesc = "",
		modDesc = "防御额外提升<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110270403,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102704,
		name = "心锚IV",
		remarks = "赝作天赋",
		newDesc = "",
		modDesc = "防御额外提升<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110270404,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1102704,
		name = "心锚V",
		remarks = "赝作天赋",
		newDesc = "",
		modDesc = "防御额外提升<effect-2_action-1_attrModifies-1_modify%%>",
		code = 110270405,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103001,
		name = "亲和度I-4",
		remarks = "波波莎普攻",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110300101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103001,
		name = "亲和度III-2",
		remarks = "波波莎普攻",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110300102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103001,
		name = "亲和度IV-2",
		remarks = "波波莎普攻",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110300103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103001,
		name = "亲和度IV-4",
		remarks = "波波莎普攻",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110300104,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103001,
		name = "亲和度强化5",
		remarks = "波波莎普攻",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110300105,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103002,
		name = "亲和度II-2",
		remarks = "波波莎特殊",
		newDesc = "",
		modDesc = "减伤比例提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110300201,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103002,
		name = "亲和度III-4",
		remarks = "波波莎特殊",
		newDesc = "",
		modDesc = "减伤比例提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110300202,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103003,
		name = "亲和度II-4",
		remarks = "波波莎大招",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110300301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103003,
		name = "亲和度强化2",
		remarks = "波波莎大招",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110300302,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103003,
		name = "默契",
		remarks = "波波莎大招",
		newDesc = "对敌方造成<effect-1_action-1_damageRate%%>的物理伤害以及<effect-2_action-1_buffList-1_round>回合[缴械],攻击后使自身获得1回合[攻击强化]。",
		modDesc = "攻击后额外获得1回合[攻击强化]",
		code = 110300303,
		upgradeType = 2,
		normalConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = 8,
				timePrograming = "ATTACKING_ENDED",
				conditionList = {
					{
						code = -1
					}
				},
				actionList = {
					{
						code = 12345,
						buffList = {
							{
								buffId = 11001,
								round = 1
							}
						}
					}
				}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103004,
		name = "心锚I",
		remarks = "波波莎天赋",
		newDesc = "",
		modDesc = "攻击、防御额外提升<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110300401,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.03#attrModifies-2_modify:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103004,
		name = "心锚II",
		remarks = "波波莎天赋",
		newDesc = "",
		modDesc = "攻击、防御额外提升<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110300402,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.03#attrModifies-2_modify:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103004,
		name = "心锚III",
		remarks = "波波莎天赋",
		newDesc = "",
		modDesc = "攻击、防御额外提升<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110300403,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.03#attrModifies-2_modify:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103004,
		name = "心锚IV",
		remarks = "波波莎天赋",
		newDesc = "",
		modDesc = "攻击、防御额外提升<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110300404,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.03#attrModifies-2_modify:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103004,
		name = "心锚V",
		remarks = "波波莎天赋",
		newDesc = "",
		modDesc = "攻击、防御额外提升<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110300405,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.03#attrModifies-2_modify:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103601,
		name = "亲和度I-4",
		remarks = "",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110360101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103601,
		name = "亲和度III-2",
		remarks = "",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110360102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103601,
		name = "亲和度IV-4",
		remarks = "",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110360103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103602,
		name = "亲和度II-2",
		remarks = "",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110360201,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103602,
		name = "亲和度III-4",
		remarks = "",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110360202,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103602,
		name = "亲和度V-2",
		remarks = "",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110360203,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103603,
		name = "亲和度II-4",
		remarks = "",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110360301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103603,
		name = "亲和度IV-2",
		remarks = "",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110360302,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103603,
		name = "亲和度V-4",
		remarks = "",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110360303,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103604,
		name = "心锚",
		remarks = "多萝西天赋",
		newDesc = "",
		modDesc = "伤害额外提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110360401,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103604,
		name = "心锚",
		remarks = "多萝西天赋",
		newDesc = "",
		modDesc = "伤害额外提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110360402,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103604,
		name = "心锚",
		remarks = "多萝西天赋",
		newDesc = "",
		modDesc = "伤害额外提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110360403,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103604,
		name = "心锚",
		remarks = "多萝西天赋",
		newDesc = "",
		modDesc = "伤害额外提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110360404,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103604,
		name = "未知",
		remarks = "多萝西天赋",
		newDesc = "",
		modDesc = "伤害额外提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110360405,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103901,
		name = "亲和度I-4",
		remarks = "伊丽莎白普攻",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110390101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103901,
		name = "亲和度II-4",
		remarks = "伊丽莎白普攻",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110390102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103901,
		name = "亲和度III-4",
		remarks = "伊丽莎白普攻",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110390103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103901,
		name = "亲和度IV-4",
		remarks = "伊丽莎白普攻",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110390104,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103902,
		name = "亲和度V-2",
		remarks = "伊丽莎白特殊技",
		newDesc = "",
		modDesc = "减益持续回合数+<effect-2_action-1_buffList-1_round>",
		code = 110390201,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "buffList-1_round:1",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "buffList-1_round:1",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103903,
		name = "亲和度II-2",
		remarks = "伊丽莎白必杀",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110390301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103903,
		name = "亲和度III-2",
		remarks = "伊丽莎白必杀",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110390302,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103903,
		name = "亲和度IV-2",
		remarks = "伊丽莎白必杀",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110390303,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103903,
		name = "亲和度V-4",
		remarks = "伊丽莎白必杀",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110390304,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103904,
		name = "亲和度",
		remarks = "伊丽莎白天赋",
		newDesc = "",
		modDesc = "攻击、防御提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110390401,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				},
				{
					effectStr = "attrModifies-2_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103904,
		name = "亲和度",
		remarks = "伊丽莎白天赋",
		newDesc = "",
		modDesc = "攻击、防御提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110390402,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				},
				{
					effectStr = "attrModifies-2_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103904,
		name = "亲和度",
		remarks = "伊丽莎白天赋",
		newDesc = "",
		modDesc = "攻击、防御提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110390403,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				},
				{
					effectStr = "attrModifies-2_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103904,
		name = "亲和度",
		remarks = "伊丽莎白天赋",
		newDesc = "",
		modDesc = "攻击、防御提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110390404,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				},
				{
					effectStr = "attrModifies-2_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1103904,
		name = "亲和度",
		remarks = "伊丽莎白天赋",
		newDesc = "",
		modDesc = "攻击、防御提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110390405,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				},
				{
					effectStr = "attrModifies-2_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1104101,
		name = "亲和度I-4",
		remarks = "辛德瑞拉普攻",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110410101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1104101,
		name = "亲和度III-2",
		remarks = "辛德瑞拉普攻",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110410102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1104101,
		name = "亲和度IV-4",
		remarks = "辛德瑞拉普攻",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110410103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1104102,
		name = "亲和度II-2",
		remarks = "辛德瑞拉特殊技",
		newDesc = "",
		modDesc = "替代比例提高<effect-1_action-1_rate%%>",
		code = 110410201,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "rate:0.15",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1104102,
		name = "亲和度III-4",
		remarks = "辛德瑞拉特殊技",
		newDesc = "",
		modDesc = "替代比例提高<effect-1_action-1_rate%%>",
		code = 110410202,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "rate:0.15",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1104102,
		name = "亲和度V-2",
		remarks = "辛德瑞拉特殊技",
		newDesc = "",
		modDesc = "替代比例提高<effect-1_action-1_rate%%>",
		code = 110410203,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "rate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1104103,
		name = "亲和度II-4",
		remarks = "辛德瑞拉必杀",
		newDesc = "",
		modDesc = "真实伤害比例提高<effect-2_action-1_referRate%%>",
		code = 110410301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.15",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "referRate:0.15",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1104103,
		name = "亲和度IV-2",
		remarks = "辛德瑞拉必杀",
		newDesc = "",
		modDesc = "真实伤害比例提高<effect-2_action-1_referRate%%>",
		code = 110410302,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.15",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "referRate:0.15",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1104103,
		name = "亲和度V-4",
		remarks = "辛德瑞拉必杀",
		newDesc = "",
		modDesc = "真实伤害比例提高<effect-2_action-1_referRate%%>",
		code = 110410303,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.2",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "referRate:0.2",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1104104,
		name = "亲和度",
		remarks = "辛德瑞拉天赋",
		newDesc = "",
		modDesc = "自身防御提高<effect-3_action-1_attrModifies-1_modify%%>",
		code = 110410401,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1104104,
		name = "亲和度",
		remarks = "辛德瑞拉天赋",
		newDesc = "",
		modDesc = "自身防御提高<effect-3_action-1_attrModifies-1_modify%%>",
		code = 110410402,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1104104,
		name = "亲和度",
		remarks = "辛德瑞拉天赋",
		newDesc = "",
		modDesc = "自身防御提高<effect-3_action-1_attrModifies-1_modify%%>",
		code = 110410403,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1104104,
		name = "亲和度",
		remarks = "辛德瑞拉天赋",
		newDesc = "",
		modDesc = "自身防御提高<effect-3_action-1_attrModifies-1_modify%%>",
		code = 110410404,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1104104,
		name = "亲和度",
		remarks = "辛德瑞拉天赋",
		newDesc = "",
		modDesc = "自身防御提高<effect-3_action-1_attrModifies-1_modify%%>",
		code = 110410405,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105301,
		name = "亲和度I-4",
		remarks = "阿妮亚普攻",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110530101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105301,
		name = "亲和度III-2",
		remarks = "阿妮亚普攻",
		newDesc = "",
		modDesc = "伤害比例增加<effect-1_action-1_damageRate%%>",
		code = 110530102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105301,
		name = "亲和度IV-4",
		remarks = "阿妮亚普攻",
		newDesc = "",
		modDesc = "治疗比例提高<effect-2_action-1_cureReferRate%%>",
		code = 110530103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "cureReferRate:0.2",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "cureReferRate:0.2",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105302,
		name = "亲和度II-2",
		remarks = "阿妮亚特殊技",
		newDesc = "",
		modDesc = "治疗比例增加<effect-1_action-1_referRate%%>",
		code = 110530201,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "referRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105302,
		name = "亲和度III-4",
		remarks = "阿妮亚特殊技",
		newDesc = "",
		modDesc = "治疗比例增加<effect-1_action-1_referRate%%>",
		code = 110530202,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "referRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105303,
		name = "亲和度II-4",
		remarks = "阿妮亚大招",
		newDesc = "",
		modDesc = "参考以太比例增加<effect-1_action-1_referRate%%>",
		code = 110530301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.25",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "referRate:0.25",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105303,
		name = "亲和度IV-2",
		remarks = "阿妮亚大招",
		newDesc = "",
		modDesc = "参考以太比例增加<effect-1_action-1_referRate%%>",
		code = 110530302,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.25",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "referRate:0.25",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105304,
		name = "心锚I",
		remarks = "阿妮亚天赋",
		newDesc = "",
		modDesc = "防御、抗性额外提升<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110530401,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105304,
		name = "心锚II",
		remarks = "阿妮亚天赋",
		newDesc = "",
		modDesc = "防御、抗性额外提升<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110530402,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105304,
		name = "心锚III",
		remarks = "阿妮亚天赋",
		newDesc = "",
		modDesc = "防御、抗性额外提升<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110530403,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105304,
		name = "心锚IV",
		remarks = "阿妮亚天赋",
		newDesc = "",
		modDesc = "防御、抗性额外提升<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110530404,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105304,
		name = "心锚V",
		remarks = "阿妮亚天赋",
		newDesc = "",
		modDesc = "防御、抗性额外提升<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110530405,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105601,
		name = "亲和度I-4",
		remarks = "提亚普攻",
		newDesc = "",
		modDesc = "根据伤害回复比例提高<effect-2_action-1_referRate%%>",
		code = 110560101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.15",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "referRate:0.15",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105601,
		name = "亲和度III-2",
		remarks = "提亚普攻",
		newDesc = "",
		modDesc = "根据伤害回复比例提高<effect-2_action-1_referRate%%>",
		code = 110560102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.15",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "referRate:0.15",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105601,
		name = "亲和度IV-4",
		remarks = "提亚普攻",
		newDesc = "",
		modDesc = "根据伤害回复比例提高<effect-2_action-1_referRate%%>",
		code = 110560103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.2",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "referRate:0.2",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105602,
		name = "亲和度II-2",
		remarks = "提亚特殊技",
		newDesc = "",
		modDesc = "血量回复比例提高<effect-1_action-1_referRate%%>",
		code = 110560201,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.25",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "referRate:0.25",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105602,
		name = "亲和度III-4",
		remarks = "提亚特殊技",
		newDesc = "",
		modDesc = "血量回复比例提高<effect-1_action-1_referRate%%>",
		code = 110560202,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.25",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "referRate:0.25",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105602,
		name = "亲和度V-2",
		remarks = "提亚特殊技",
		newDesc = "",
		modDesc = "减益持续回合数+<effect-2_action-1_buffList-1_round>",
		code = 110560203,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "buffList-1_round:1",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "buffList-1_round:1",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105603,
		name = "亲和度II-4",
		remarks = "提亚必杀",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110560301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105603,
		name = "亲和度IV-2",
		remarks = "提亚必杀",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 110560302,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "damageRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105603,
		name = "亲和度V-4",
		remarks = "提亚必杀",
		newDesc = "",
		modDesc = "增益持续回合+<effect-3_action-1_buffList-1_round>",
		code = 110560303,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "buffList-1_round:1",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {
				{
					effectStr = "buffList-1_round:1",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105604,
		name = "心锚",
		remarks = "提亚天赋",
		newDesc = "",
		modDesc = "每个友方使以太和抗性额外提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110560401,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.01",
					type = "effect-1_action-1"
				},
				{
					effectStr = "attrModifies-2_modify:0.01",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105604,
		name = "心锚",
		remarks = "提亚天赋",
		newDesc = "",
		modDesc = "每个友方使以太和抗性额外提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110560402,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.01",
					type = "effect-1_action-1"
				},
				{
					effectStr = "attrModifies-2_modify:0.01",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105604,
		name = "心锚",
		remarks = "提亚天赋",
		newDesc = "",
		modDesc = "每个友方使以太和抗性额外提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110560403,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.01",
					type = "effect-1_action-1"
				},
				{
					effectStr = "attrModifies-2_modify:0.01",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105604,
		name = "心锚",
		remarks = "提亚天赋",
		newDesc = "",
		modDesc = "每个友方使以太和抗性额外提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110560404,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.01",
					type = "effect-1_action-1"
				},
				{
					effectStr = "attrModifies-2_modify:0.01",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1105604,
		name = "心锚",
		remarks = "提亚天赋",
		newDesc = "",
		modDesc = "每个友方使以太和抗性额外提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 110560405,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.01",
					type = "effect-1_action-1"
				},
				{
					effectStr = "attrModifies-2_modify:0.01",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1199901,
		name = "亲和度I-4",
		remarks = "",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 119990101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1199901,
		name = "亲和度III-2",
		remarks = "",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 119990102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1199901,
		name = "亲和度IV-4",
		remarks = "",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 119990103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1199902,
		name = "亲和度II-2",
		remarks = "",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 119990201,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1199902,
		name = "亲和度III-4",
		remarks = "",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 119990202,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1199902,
		name = "亲和度V-2",
		remarks = "",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 119990203,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1199903,
		name = "亲和度II-4",
		remarks = "",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 119990301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1199903,
		name = "亲和度IV-2",
		remarks = "",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 119990302,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1199903,
		name = "亲和度V-4",
		remarks = "",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_damageRate%%>",
		code = 119990303,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1199903,
		name = "好感度",
		remarks = "",
		newDesc = "切割目标,造成<effect-1_action-1_damageRate%%>的物理伤害.主动攻击后,获得1回合[攻击强化]",
		modDesc = "主动攻击后,获得1回合[攻击强化]",
		code = 119990304,
		upgradeType = 2,
		normalConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = 8,
				timePrograming = "ATTACKING_ENDED",
				conditionList = {
					{
						code = -1
					}
				},
				actionList = {
					{
						code = 12345,
						buffList = {
							{
								buffId = 11001,
								round = 2
							}
						}
					}
				}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1199904,
		name = "心锚突破",
		remarks = "",
		newDesc = "",
		modDesc = "攻击、以太额外提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 119990401,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.05#attrModifies-2_modify:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1199904,
		name = "心锚突破",
		remarks = "",
		newDesc = "",
		modDesc = "攻击、以太额外提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 119990402,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02#attrModifies-2_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1199904,
		name = "心锚突破",
		remarks = "",
		newDesc = "",
		modDesc = "攻击、以太额外提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 119990403,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02#attrModifies-2_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1199904,
		name = "心锚突破",
		remarks = "",
		newDesc = "",
		modDesc = "攻击、以太额外提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 119990404,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02#attrModifies-2_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1199904,
		name = "心锚突破",
		remarks = "",
		newDesc = "",
		modDesc = "攻击、以太额外提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 119990405,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02#attrModifies-2_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1282001,
		name = "未知",
		remarks = "",
		newDesc = "",
		modDesc = "前131",
		code = 128200101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "damageRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1303002,
		name = "残响满破",
		remarks = "临时配置",
		newDesc = "",
		modDesc = "伤害减少比例提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 130300201,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1303003,
		name = "残响满破",
		remarks = "临时配置",
		newDesc = "",
		modDesc = "灵感+<effect-1_action-1_attrModifies-1_modify>",
		code = 130300301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:4",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1303004,
		name = "残响满破",
		remarks = "临时配置",
		newDesc = "",
		modDesc = "驱散减益数量+<effect-1_action-1_count>",
		code = 130300401,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "count:1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1303005,
		name = "残响满破",
		remarks = "临时配置",
		newDesc = "",
		modDesc = "造成伤害比例提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 130300501,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1303006,
		name = "残响满破",
		remarks = "",
		newDesc = "",
		modDesc = "回复血量比例提高<effect-1_action-1_referRate%%>",
		code = 130300601,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1303007,
		name = "残响满破",
		remarks = "临时配置",
		newDesc = "",
		modDesc = "伤害提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 130300701,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.15",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1303008,
		name = "残响满破",
		remarks = "临时配置",
		newDesc = "",
		modDesc = "参考自身以太比例提高<effect-1_action-1_cureReferRate%%>",
		code = 130300801,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "cureReferRate:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1304001,
		name = "回响突破",
		remarks = "",
		newDesc = "",
		modDesc = "伤害提高增加<effect-1_action-1_referRate%%>",
		code = 130400101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1304001,
		name = "回响突破",
		remarks = "",
		newDesc = "",
		modDesc = "伤害提高增加<effect-1_action-1_referRate%%>",
		code = 130400102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1304001,
		name = "回响突破",
		remarks = "",
		newDesc = "",
		modDesc = "伤害提高增加<effect-1_action-1_referRate%%>",
		code = 130400103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1304001,
		name = "回响突破",
		remarks = "",
		newDesc = "",
		modDesc = "伤害提高增加<effect-1_action-1_referRate%%>",
		code = 130400104,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1304001,
		name = "回响突破",
		remarks = "",
		newDesc = "",
		modDesc = "伤害提高增加<effect-1_action-1_referRate%%>",
		code = 130400105,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1313001,
		name = "回响突破1",
		remarks = "A幻影收容物突破",
		newDesc = "",
		modDesc = "生命回复百分比提高<effect-1_action-1_referRate%%>",
		code = 131300101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.04",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1313001,
		name = "回响突破2",
		remarks = "A幻影收容物突破",
		newDesc = "",
		modDesc = "生命回复百分比提高<effect-1_action-1_referRate%%>",
		code = 131300102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.04",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1313001,
		name = "回响突破3",
		remarks = "A幻影收容物突破",
		newDesc = "",
		modDesc = "生命回复百分比提高<effect-1_action-1_referRate%%>",
		code = 131300103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.04",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1313001,
		name = "回响突破4",
		remarks = "A幻影收容物突破",
		newDesc = "",
		modDesc = "生命回复百分比提高<effect-1_action-1_referRate%%>",
		code = 131300104,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.04",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1313001,
		name = "回响突破5",
		remarks = "A幻影收容物突破",
		newDesc = "",
		modDesc = "增益持续回合数+<effect-2_action-1_buffList-1_round>",
		code = 131300105,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "buffList-1_round:1#buffList-2_round:1",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1314001,
		name = "残响满破",
		remarks = "",
		newDesc = "",
		modDesc = "敌方数量阈值<effect-1_condition-1_count>",
		code = 131400101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "count:-1",
					type = "effect-1_condition-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1314002,
		name = "残响满破",
		remarks = "",
		newDesc = "",
		modDesc = "失去血量-<effect-1_action-1_referRate%%>，回复血量+<effect-2_action-1_referRate%%>",
		code = 131400201,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:-0.1",
					type = "effect-1_action-1"
				},
				{
					effectStr = "referRate:0.1",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1314003,
		name = "残响满破",
		remarks = "",
		newDesc = "",
		modDesc = "伤害减少增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 131400301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1314004,
		name = "回响突破",
		remarks = "",
		newDesc = "",
		modDesc = "伤害增加<effect-1_action-1_damageRate%%>",
		code = 131400401,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1314004,
		name = "回响突破",
		remarks = "",
		newDesc = "",
		modDesc = "伤害增加<effect-1_action-1_damageRate%%>",
		code = 131400402,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1314004,
		name = "回响突破",
		remarks = "",
		newDesc = "",
		modDesc = "伤害增加<effect-1_action-1_damageRate%%>",
		code = 131400403,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1314004,
		name = "回响突破",
		remarks = "",
		newDesc = "",
		modDesc = "伤害增加<effect-1_action-1_damageRate%%>",
		code = 131400404,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1314004,
		name = "回响突破",
		remarks = "",
		newDesc = "",
		modDesc = "伤害增加<effect-1_action-1_damageRate%%>",
		code = 131400405,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1315003,
		name = "残响满破",
		remarks = "",
		newDesc = "",
		modDesc = "增益改为[伤害提高Ⅱ]",
		code = 131500301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "buffList-1_buffId:1",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1323001,
		name = "回响突破1",
		remarks = "A守卫收容物突破",
		newDesc = "",
		modDesc = "生命回复百分比提高<effect-1_action-1_referRate%%>",
		code = 132300101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1323001,
		name = "回响突破2",
		remarks = "A守卫收容物突破",
		newDesc = "",
		modDesc = "触发阈值提高<effect-1_condition-1_value%%>",
		code = 132300102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "value:0.05",
					type = "effect-1_condition-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1323001,
		name = "回响突破3",
		remarks = "A守卫收容物突破",
		newDesc = "",
		modDesc = "生命回复百分比提高<effect-1_action-1_referRate%%>",
		code = 132300103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1323001,
		name = "回响突破4",
		remarks = "A守卫收容物突破",
		newDesc = "",
		modDesc = "触发阈值提高<effect-1_condition-1_value%%>",
		code = 132300104,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "value:0.05",
					type = "effect-1_condition-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1323001,
		name = "回响突破5",
		remarks = "A守卫收容物突破",
		newDesc = "",
		modDesc = "触发阈值提高<effect-1_condition-1_value%%>",
		code = 132300105,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "value:0.1",
					type = "effect-1_condition-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1324001,
		name = "残响满破",
		remarks = "",
		newDesc = "",
		modDesc = "血量阈值提高<effect-1_condition-1_value%%>，回复血量提高<effect-1_action-1_referRate%%>",
		code = 132400101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "value:0.2",
					type = "effect-1_condition-1"
				},
				{
					effectStr = "referRate:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1324002,
		name = "残响满破",
		remarks = "",
		newDesc = "",
		modDesc = "对方血量阈值提高<effect-1_condition-1_value%%>",
		code = 132400201,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "value:0.5",
					type = "effect-1_condition-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1325001,
		name = "残响满破",
		remarks = "",
		newDesc = "",
		modDesc = "反击伤害提高15%。",
		code = 132500101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.15",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1333001,
		name = "回响突破1",
		remarks = "A狙击收容物突破",
		newDesc = "",
		modDesc = "攻击加成提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 133300101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1333001,
		name = "回响突破2",
		remarks = "A狙击收容物突破",
		newDesc = "",
		modDesc = "攻击加成提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 133300102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1333001,
		name = "回响突破3",
		remarks = "A狙击收容物突破",
		newDesc = "",
		modDesc = "攻击加成提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 133300103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1333001,
		name = "回响突破4",
		remarks = "A狙击收容物突破",
		newDesc = "",
		modDesc = "攻击加成提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 133300104,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1333001,
		name = "回响突破5",
		remarks = "A狙击收容物突破",
		newDesc = "",
		modDesc = "攻击加成提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 133300105,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1334001,
		name = "残响满破",
		remarks = "",
		newDesc = "",
		modDesc = "攻击提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 133400101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1334002,
		name = "残响满破",
		remarks = "",
		newDesc = "",
		modDesc = "伤害比例提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 133400201,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.15",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1335001,
		name = "残响满破",
		remarks = "",
		newDesc = "",
		modDesc = "每格距离灵感提高+<effect-1_action-1_attrModifies-1_modify>，伤害比例提高+<effect-1_action-1_attrModifies-2_modify%%>",
		code = 133500101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:2",
					type = "effect-1_action-1"
				},
				{
					effectStr = "attrModifies-2_modify:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1343001,
		name = "回响突破1",
		remarks = "A特异收容物突破",
		newDesc = "",
		modDesc = "生命、抗性加成提高<effect-2_action-1_attrModifies-1_modify%%>",
		code = 134300101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.025#attrModifies-2_modify:0.025",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1343001,
		name = "回响突破2",
		remarks = "A特异收容物突破",
		newDesc = "",
		modDesc = "生命、抗性加成提高<effect-2_action-1_attrModifies-1_modify%%>",
		code = 134300102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.025#attrModifies-2_modify:0.025",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1343001,
		name = "回响突破3",
		remarks = "A特异收容物突破",
		newDesc = "",
		modDesc = "生命、抗性加成提高<effect-2_action-1_attrModifies-1_modify%%>",
		code = 134300103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.025#attrModifies-2_modify:0.025",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1343001,
		name = "回响突破4",
		remarks = "A特异收容物突破",
		newDesc = "",
		modDesc = "生命、抗性加成提高<effect-2_action-1_attrModifies-1_modify%%>",
		code = 134300104,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.025#attrModifies-2_modify:0.025",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1343001,
		name = "回响突破5",
		remarks = "A特异收容物突破",
		newDesc = "",
		modDesc = "增益持续回合数+<effect-1_action-1_buffList-1_round>",
		code = 134300105,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "buffList-1_round:1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1344001,
		name = "残响满破",
		remarks = "",
		newDesc = "",
		modDesc = "以太提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 134400101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.07",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1344002,
		name = "残响满破",
		remarks = "",
		newDesc = "",
		modDesc = "生效目标数量+<effect-1_action-1_count>",
		code = 134400201,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "count:2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1345001,
		name = "回响突破",
		remarks = "",
		newDesc = "",
		modDesc = "伤害增加提升<effect-1_action-1_attrModifies-1_modify%%>",
		code = 134500101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.06",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1345001,
		name = "回响突破",
		remarks = "",
		newDesc = "",
		modDesc = "伤害增加提升<effect-1_action-1_attrModifies-1_modify%%>",
		code = 134500102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.06",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1345001,
		name = "回响突破",
		remarks = "",
		newDesc = "",
		modDesc = "伤害增加提升<effect-1_action-1_attrModifies-1_modify%%>",
		code = 134500103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.06",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1345001,
		name = "回响突破",
		remarks = "",
		newDesc = "",
		modDesc = "伤害增加提升<effect-1_action-1_attrModifies-1_modify%%>",
		code = 134500104,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.06",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1345001,
		name = "回响突破",
		remarks = "",
		newDesc = "",
		modDesc = "伤害增加提升<effect-1_action-1_attrModifies-1_modify%%>",
		code = 134500105,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.06",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1345003,
		name = "残响满破",
		remarks = "",
		newDesc = "",
		modDesc = "受伤减少比例提高<effect-1_action-1_attrModifies-1_modify%%>",
		code = 134500301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1353001,
		name = "回响突破1",
		remarks = "A陨灭收容物突破",
		newDesc = "",
		modDesc = "生命、防御加成提高<effect-2_action-1_attrModifies-1_modify%%>",
		code = 135300101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.03#attrModifies-2_modify:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1353001,
		name = "回响突破2",
		remarks = "A陨灭收容物突破",
		newDesc = "",
		modDesc = "生命、防御加成提高<effect-2_action-1_attrModifies-1_modify%%>",
		code = 135300102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.03#attrModifies-2_modify:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1353001,
		name = "回响突破3",
		remarks = "A陨灭收容物突破",
		newDesc = "",
		modDesc = "生命、防御加成提高<effect-2_action-1_attrModifies-1_modify%%>",
		code = 135300103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.03#attrModifies-2_modify:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1353001,
		name = "回响突破4",
		remarks = "A陨灭收容物突破",
		newDesc = "",
		modDesc = "生命、防御加成提高<effect-2_action-1_attrModifies-1_modify%%>",
		code = 135300104,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.03#attrModifies-2_modify:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1353001,
		name = "回响突破5",
		remarks = "A陨灭收容物突破",
		newDesc = "",
		modDesc = "生命、防御加成提高<effect-2_action-1_attrModifies-1_modify%%>",
		code = 135300105,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.03#attrModifies-2_modify:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1354001,
		name = "残响满破",
		remarks = "",
		newDesc = "",
		modDesc = "攻击、以太提高+<effect-1_action-1_attrModifies-2_modify%%>",
		code = 135400101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.05",
					type = "effect-1_action-1"
				},
				{
					effectStr = "attrModifies-2_modify:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1354002,
		name = "残响满破",
		remarks = "",
		newDesc = "",
		modDesc = "[疾行]持续回合数+<effect-1_action-1_buffList-1_round>",
		code = 135400201,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "buffList-1_round:1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1363001,
		name = "回响突破1",
		remarks = "A支援收容物突破",
		newDesc = "",
		modDesc = "生命回复百分比提高<effect-1_action-1_referRate%%>",
		code = 136300101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.01",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1363001,
		name = "回响突破2",
		remarks = "A支援收容物突破",
		newDesc = "",
		modDesc = "生命回复百分比提高<effect-1_action-1_referRate%%>",
		code = 136300102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.01",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1363001,
		name = "回响突破3",
		remarks = "A支援收容物突破",
		newDesc = "",
		modDesc = "生命回复百分比提高<effect-1_action-1_referRate%%>",
		code = 136300103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.01",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1363001,
		name = "回响突破4",
		remarks = "A支援收容物突破",
		newDesc = "",
		modDesc = "生命回复百分比提高<effect-1_action-1_referRate%%>",
		code = 136300104,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.01",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1363001,
		name = "回响突破5",
		remarks = "A支援收容物突破",
		newDesc = "",
		modDesc = "生命回复百分比提高<effect-1_action-1_referRate%%>",
		code = 136300105,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.01",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1364001,
		name = "回响突满破",
		remarks = "S支援收容物突破",
		newDesc = "",
		modDesc = "驱散范围提高<effect-1_action-1_range>,作用单位数量提高<effect-1_action-1_count>",
		code = 136400101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "range:1#count:1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1364002,
		name = "残响满破",
		remarks = "",
		newDesc = "",
		modDesc = "血量回复比例增加<effect-1_action-1_referRate%%>",
		code = 136400201,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.15",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1364003,
		name = "残响满破",
		remarks = "",
		newDesc = "",
		modDesc = "驱散范围+<effect-1_action-1_range>",
		code = 136400301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "range:1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1365002,
		name = "残响满破",
		remarks = "",
		newDesc = "",
		modDesc = "回复目标数量+<effect-1_action-1_count>",
		code = 136500201,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "count:2",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1365003,
		name = "残响满破",
		remarks = "",
		newDesc = "",
		modDesc = "以太提高+<effect-1_action-2_attrModifies-1_modify%%>",
		code = 136500301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.07",
					type = "effect-1_action-2"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "ANYTIME",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400101,
		name = "技能升级1",
		remarks = "惧之煞-幻影升级",
		newDesc = "",
		modDesc = "攻击提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140010101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400101,
		name = "技能升级2",
		remarks = "惧之煞-幻影升级",
		newDesc = "",
		modDesc = "攻击提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140010102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400101,
		name = "技能升级3",
		remarks = "惧之煞-幻影升级",
		newDesc = "",
		modDesc = "攻击提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140010103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400101,
		name = "技能升级4",
		remarks = "惧之煞-幻影升级",
		newDesc = "",
		modDesc = "攻击提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140010104,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400101,
		name = "技能升级5",
		remarks = "惧之煞-幻影升级",
		newDesc = "",
		modDesc = "攻击提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140010105,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400102,
		name = "技能升级1",
		remarks = "惧之煞-守卫升级",
		newDesc = "",
		modDesc = "防御提高+<effect-3_action-1_attrModifies-1_modify%%>",
		code = 140010201,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400102,
		name = "技能升级2",
		remarks = "惧之煞-守卫升级",
		newDesc = "",
		modDesc = "防御提高+<effect-3_action-1_attrModifies-1_modify%%>",
		code = 140010202,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400102,
		name = "技能升级3",
		remarks = "惧之煞-守卫升级",
		newDesc = "",
		modDesc = "防御提高+<effect-3_action-1_attrModifies-1_modify%%>",
		code = 140010203,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400102,
		name = "技能升级4",
		remarks = "惧之煞-守卫升级",
		newDesc = "",
		modDesc = "防御提高+<effect-3_action-1_attrModifies-1_modify%%>",
		code = 140010204,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400102,
		name = "技能升级5",
		remarks = "惧之煞-守卫升级",
		newDesc = "",
		modDesc = "防御提高+<effect-3_action-1_attrModifies-1_modify%%>",
		code = 140010205,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400103,
		name = "技能升级1",
		remarks = "惧之煞-狙击升级",
		newDesc = "",
		modDesc = "攻击提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140010301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400103,
		name = "技能升级2",
		remarks = "惧之煞-狙击升级",
		newDesc = "",
		modDesc = "攻击提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140010302,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400103,
		name = "技能升级3",
		remarks = "惧之煞-狙击升级",
		newDesc = "",
		modDesc = "攻击提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140010303,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400103,
		name = "技能升级4",
		remarks = "惧之煞-狙击升级",
		newDesc = "",
		modDesc = "攻击提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140010304,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400103,
		name = "技能升级5",
		remarks = "惧之煞-狙击升级",
		newDesc = "",
		modDesc = "攻击提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140010305,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400104,
		name = "技能升级1",
		remarks = "惧之煞-特异升级",
		newDesc = "",
		modDesc = "防御提高+<effect-3_action-1_attrModifies-1_modify%%>",
		code = 140010401,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400104,
		name = "技能升级2",
		remarks = "惧之煞-特异升级",
		newDesc = "",
		modDesc = "防御提高+<effect-3_action-1_attrModifies-1_modify%%>",
		code = 140010402,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400104,
		name = "技能升级3",
		remarks = "惧之煞-特异升级",
		newDesc = "",
		modDesc = "防御提高+<effect-3_action-1_attrModifies-1_modify%%>",
		code = 140010403,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400104,
		name = "技能升级4",
		remarks = "惧之煞-特异升级",
		newDesc = "",
		modDesc = "防御提高+<effect-3_action-1_attrModifies-1_modify%%>",
		code = 140010404,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400104,
		name = "技能升级5",
		remarks = "惧之煞-特异升级",
		newDesc = "",
		modDesc = "防御提高+<effect-3_action-1_attrModifies-1_modify%%>",
		code = 140010405,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400105,
		name = "技能升级1",
		remarks = "惧之煞-陨灭升级",
		newDesc = "",
		modDesc = "防御提高+<effect-3_action-1_attrModifies-1_modify%%>",
		code = 140010501,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400105,
		name = "技能升级2",
		remarks = "惧之煞-陨灭升级",
		newDesc = "",
		modDesc = "防御提高+<effect-3_action-1_attrModifies-1_modify%%>",
		code = 140010502,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400105,
		name = "技能升级3",
		remarks = "惧之煞-陨灭升级",
		newDesc = "",
		modDesc = "防御提高+<effect-3_action-1_attrModifies-1_modify%%>",
		code = 140010503,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400105,
		name = "技能升级4",
		remarks = "惧之煞-陨灭升级",
		newDesc = "",
		modDesc = "防御提高+<effect-3_action-1_attrModifies-1_modify%%>",
		code = 140010504,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400105,
		name = "技能升级5",
		remarks = "惧之煞-陨灭升级",
		newDesc = "",
		modDesc = "防御提高+<effect-3_action-1_attrModifies-1_modify%%>",
		code = 140010505,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400106,
		name = "技能升级1",
		remarks = "惧之煞-支援升级",
		newDesc = "",
		modDesc = "防御提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140010601,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400106,
		name = "技能升级2",
		remarks = "惧之煞-支援升级",
		newDesc = "",
		modDesc = "防御提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140010602,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400106,
		name = "技能升级3",
		remarks = "惧之煞-支援升级",
		newDesc = "",
		modDesc = "防御提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140010603,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400106,
		name = "技能升级4",
		remarks = "惧之煞-支援升级",
		newDesc = "",
		modDesc = "防御提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140010604,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400106,
		name = "技能升级5",
		remarks = "惧之煞-支援升级",
		newDesc = "",
		modDesc = "防御提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140010605,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400201,
		name = "技能升级1",
		remarks = "狂之煞-幻影升级",
		newDesc = "",
		modDesc = "抗性提高+<effect-3_action-1_attrModifies-1_modify%%>",
		code = 140020101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400201,
		name = "技能升级2",
		remarks = "狂之煞-幻影升级",
		newDesc = "",
		modDesc = "抗性提高+<effect-3_action-1_attrModifies-1_modify%%>",
		code = 140020102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400201,
		name = "技能升级3",
		remarks = "狂之煞-幻影升级",
		newDesc = "",
		modDesc = "抗性提高+<effect-3_action-1_attrModifies-1_modify%%>",
		code = 140020103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400201,
		name = "技能升级4",
		remarks = "狂之煞-幻影升级",
		newDesc = "",
		modDesc = "抗性提高+<effect-3_action-1_attrModifies-1_modify%%>",
		code = 140020104,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400201,
		name = "技能升级5",
		remarks = "狂之煞-幻影升级",
		newDesc = "",
		modDesc = "抗性提高+<effect-3_action-1_attrModifies-1_modify%%>",
		code = 140020105,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400202,
		name = "技能升级1",
		remarks = "狂之煞-守卫升级",
		newDesc = "",
		modDesc = "抗性提高+<effect-3_action-1_attrModifies-1_modify%%>",
		code = 140020201,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400202,
		name = "技能升级2",
		remarks = "狂之煞-守卫升级",
		newDesc = "",
		modDesc = "抗性提高+<effect-3_action-1_attrModifies-1_modify%%>",
		code = 140020202,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400202,
		name = "技能升级3",
		remarks = "狂之煞-守卫升级",
		newDesc = "",
		modDesc = "抗性提高+<effect-3_action-1_attrModifies-1_modify%%>",
		code = 140020203,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400202,
		name = "技能升级4",
		remarks = "狂之煞-守卫升级",
		newDesc = "",
		modDesc = "抗性提高+<effect-3_action-1_attrModifies-1_modify%%>",
		code = 140020204,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400202,
		name = "技能升级5",
		remarks = "狂之煞-守卫升级",
		newDesc = "",
		modDesc = "抗性提高+<effect-3_action-1_attrModifies-1_modify%%>",
		code = 140020205,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-3_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400203,
		name = "技能升级1",
		remarks = "狂之煞-狙击升级",
		newDesc = "",
		modDesc = "抗性提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140020301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400203,
		name = "技能升级2",
		remarks = "狂之煞-狙击升级",
		newDesc = "",
		modDesc = "抗性提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140020302,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400203,
		name = "技能升级3",
		remarks = "狂之煞-狙击升级",
		newDesc = "",
		modDesc = "抗性提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140020303,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400203,
		name = "技能升级4",
		remarks = "狂之煞-狙击升级",
		newDesc = "",
		modDesc = "抗性提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140020304,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400203,
		name = "技能升级5",
		remarks = "狂之煞-狙击升级",
		newDesc = "",
		modDesc = "抗性提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140020305,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400204,
		name = "技能升级1",
		remarks = "狂之煞-特异升级",
		newDesc = "",
		modDesc = "以太提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140020401,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400204,
		name = "技能升级2",
		remarks = "狂之煞-特异升级",
		newDesc = "",
		modDesc = "以太提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140020402,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400204,
		name = "技能升级3",
		remarks = "狂之煞-特异升级",
		newDesc = "",
		modDesc = "以太提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140020403,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400204,
		name = "技能升级4",
		remarks = "狂之煞-特异升级",
		newDesc = "",
		modDesc = "以太提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140020404,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400204,
		name = "技能升级5",
		remarks = "狂之煞-特异升级",
		newDesc = "",
		modDesc = "以太提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140020405,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400205,
		name = "技能升级1",
		remarks = "狂之煞-陨灭升级",
		newDesc = "",
		modDesc = "以太提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140020501,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400205,
		name = "技能升级2",
		remarks = "狂之煞-陨灭升级",
		newDesc = "",
		modDesc = "以太提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140020502,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400205,
		name = "技能升级3",
		remarks = "狂之煞-陨灭升级",
		newDesc = "",
		modDesc = "以太提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140020503,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400205,
		name = "技能升级4",
		remarks = "狂之煞-陨灭升级",
		newDesc = "",
		modDesc = "以太提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140020504,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400205,
		name = "技能升级5",
		remarks = "狂之煞-陨灭升级",
		newDesc = "",
		modDesc = "以太提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140020505,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400206,
		name = "技能升级1",
		remarks = "狂之煞-支援升级",
		newDesc = "",
		modDesc = "以太提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140020601,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400206,
		name = "技能升级2",
		remarks = "狂之煞-支援升级",
		newDesc = "",
		modDesc = "以太提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140020602,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400206,
		name = "技能升级3",
		remarks = "狂之煞-支援升级",
		newDesc = "",
		modDesc = "以太提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140020603,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400206,
		name = "技能升级4",
		remarks = "狂之煞-支援升级",
		newDesc = "",
		modDesc = "以太提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140020604,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1400206,
		name = "技能升级5",
		remarks = "狂之煞-支援升级",
		newDesc = "",
		modDesc = "以太提高+<effect-2_action-1_attrModifies-1_modify%%>",
		code = 140020605,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 0,
				conditionJudgeOnlyMainTarget = false,
				time = 0,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1410001,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "攻击加成增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 141000101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.01",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1410001,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "攻击加成增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 141000102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.01",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1410001,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "攻击加成增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 141000103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.01",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1410001,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "攻击加成增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 141000104,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.01",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1410001,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "攻击加成增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 141000105,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1410002,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "抗性提高增加<effect-1_action-1_attrModifies-1_modify%%>，生命恢复增加<effect-2_action-1_referRate%%>",
		code = 141000201,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				},
				{
					effectStr = "referRate:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1410002,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "抗性提高增加<effect-1_action-1_attrModifies-1_modify%%>，生命恢复增加<effect-2_action-1_referRate%%>",
		code = 141000202,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				},
				{
					effectStr = "referRate:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1410002,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "抗性提高增加<effect-1_action-1_attrModifies-1_modify%%>，生命恢复增加<effect-2_action-1_referRate%%>",
		code = 141000203,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				},
				{
					effectStr = "referRate:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1410002,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "抗性提高增加<effect-1_action-1_attrModifies-1_modify%%>，生命恢复增加<effect-2_action-1_referRate%%>",
		code = 141000204,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				},
				{
					effectStr = "referRate:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1410002,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "抗性提高增加<effect-1_action-1_attrModifies-1_modify%%>，生命恢复增加<effect-2_action-1_referRate%%>",
		code = 141000205,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				},
				{
					effectStr = "referRate:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1410003,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "生命值恢复增加<effect-1_action-1_referRate%%>",
		code = 141000301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1410003,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "生命值恢复增加<effect-1_action-1_referRate%%>",
		code = 141000302,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1410003,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "生命值恢复增加<effect-1_action-1_referRate%%>",
		code = 141000303,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1410003,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "生命值恢复增加<effect-1_action-1_referRate%%>",
		code = 141000304,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1410003,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "生命值恢复增加<effect-1_action-1_referRate%%>",
		code = 141000305,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1420003,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "提升防御和抗性增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 142000301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.01",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1420003,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "提升防御和抗性增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 142000302,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.01",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1420003,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "提升防御和抗性增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 142000303,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.01",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1420003,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "提升防御和抗性增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 142000304,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.01",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1420003,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "提升防御和抗性增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 142000305,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.01",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1420004,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "损失最大生命值增加<effect-1_action-1_range%%>",
		code = 142000401,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1420004,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "损失最大生命值增加<effect-1_action-1_range%%>",
		code = 142000402,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1420004,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "损失最大生命值增加<effect-1_action-1_range%%>",
		code = 142000403,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1420004,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "损失最大生命值增加<effect-1_action-1_range%%>",
		code = 142000404,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1420004,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "损失最大生命值增加<effect-1_action-1_range%%>",
		code = 142000405,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1420005,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "伤害提高增加<effect-2_action-1_referRate%%>",
		code = 142000501,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1420005,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "伤害提高增加<effect-2_action-1_referRate%%>",
		code = 142000502,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1420005,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "伤害提高增加<effect-2_action-1_referRate%%>",
		code = 142000503,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1420005,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "伤害提高增加<effect-2_action-1_referRate%%>",
		code = 142000504,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1420005,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "伤害提高增加<effect-2_action-1_referRate%%>",
		code = 142000505,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1420006,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "恢复最大生命值提升<effect-1_action-1_referRate%%>",
		code = 142000601,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1420006,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "恢复最大生命值提升<effect-1_action-1_referRate%%>",
		code = 142000602,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1420006,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "恢复最大生命值提升<effect-1_action-1_referRate%%>",
		code = 142000603,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1420006,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "恢复最大生命值提升<effect-1_action-1_referRate%%>",
		code = 142000604,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1420006,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "恢复最大生命值提升<effect-1_action-1_referRate%%>",
		code = 142000605,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1420008,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "暴击伤害减少效果增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 142000801,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.04",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1420008,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "暴击伤害减少效果增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 142000802,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.04",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1420008,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "暴击伤害减少效果增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 142000803,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.04",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1420008,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "暴击伤害减少效果增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 142000804,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.04",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1420008,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "暴击伤害减少效果增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 142000805,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.04",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1430001,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "攻击提高效果增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 143000101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1430001,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "攻击提高效果增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 143000102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1430001,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "攻击提高效果增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 143000103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1430001,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "攻击提高效果增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 143000104,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1430001,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "攻击提高效果增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 143000105,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1430003,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "恢复生命值提升<effect-1_action-1_referRate%%>",
		code = 143000301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1430003,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "恢复生命值提升<effect-1_action-1_referRate%%>",
		code = 143000302,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1430003,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "恢复生命值提升<effect-1_action-1_referRate%%>",
		code = 143000303,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1430003,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "恢复生命值提升<effect-1_action-1_referRate%%>",
		code = 143000304,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1430003,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "恢复生命值提升<effect-1_action-1_referRate%%>",
		code = 143000305,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1430005,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "暴击倍率提高效果增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 143000501,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1430005,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "暴击倍率提高效果增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 143000502,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1430005,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "暴击倍率提高效果增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 143000503,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1430005,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "暴击倍率提高效果增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 143000504,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1430005,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "暴击倍率提高效果增加<effect-1_action-1_attrModifies-1_modify%%>",
		code = 143000505,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1440001,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "受到伤害减少效果增加<effect-2_action-1_attrModifies-1_modify%%>",
		code = 144000101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1440001,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "受到伤害减少效果增加<effect-2_action-1_attrModifies-1_modify%%>",
		code = 144000102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1440001,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "受到伤害减少效果增加<effect-2_action-1_attrModifies-1_modify%%>",
		code = 144000103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1440001,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "受到伤害减少效果增加<effect-2_action-1_attrModifies-1_modify%%>",
		code = 144000104,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1440001,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "受到伤害减少效果增加<effect-2_action-1_attrModifies-1_modify%%>",
		code = 144000105,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1440004,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "参考以太属性值增加<effect-2_action-1_referRate%%>",
		code = 144000401,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1440004,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "参考以太属性值增加<effect-2_action-1_referRate%%>",
		code = 144000402,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1440004,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "参考以太属性值增加<effect-2_action-1_referRate%%>",
		code = 144000403,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1440004,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "参考以太属性值增加<effect-2_action-1_referRate%%>",
		code = 144000404,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1440004,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "参考以太属性值增加<effect-2_action-1_referRate%%>",
		code = 144000405,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1440008,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "无视效果增加<effect-1_action-1_referRate%%>",
		code = 144000801,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1440008,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "无视效果增加<effect-1_action-1_referRate%%>",
		code = 144000802,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1440008,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "无视效果增加<effect-1_action-1_referRate%%>",
		code = 144000803,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1440008,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "无视效果增加<effect-1_action-1_referRate%%>",
		code = 144000804,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1440008,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "无视效果增加<effect-1_action-1_referRate%%>",
		code = 144000805,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.05",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1450001,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "3个效果增加<effect-1_action-1_attrModifies-1_modify%%>，1个效果增加<effect-2_action-1_attrModifies-1_modify%%>",
		code = 145000101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				},
				{
					effectStr = "attrModifies-1_modify:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1450001,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "3个效果增加<effect-1_action-1_attrModifies-1_modify%%>，1个效果增加<effect-2_action-1_attrModifies-1_modify%%>",
		code = 145000102,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				},
				{
					effectStr = "attrModifies-1_modify:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1450001,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "3个效果增加<effect-1_action-1_attrModifies-1_modify%%>，1个效果增加<effect-2_action-1_attrModifies-1_modify%%>",
		code = 145000103,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				},
				{
					effectStr = "attrModifies-1_modify:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1450001,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "3个效果增加<effect-1_action-1_attrModifies-1_modify%%>，1个效果增加<effect-2_action-1_attrModifies-1_modify%%>",
		code = 145000104,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				},
				{
					effectStr = "attrModifies-1_modify:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1450001,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "3个效果增加<effect-1_action-1_attrModifies-1_modify%%>，1个效果增加<effect-2_action-1_attrModifies-1_modify%%>",
		code = 145000105,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "attrModifies-1_modify:0.02",
					type = "effect-1_action-1"
				},
				{
					effectStr = "attrModifies-1_modify:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1450003,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "血量判定范围增加<effect-1_condition-1_value%%>",
		code = 145000301,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "value:0.05",
					type = "effect-1_condition-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1450003,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "血量判定范围增加<effect-1_condition-1_value%%>",
		code = 145000302,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "value:0.05",
					type = "effect-1_condition-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1450003,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "血量判定范围增加<effect-1_condition-1_value%%>",
		code = 145000303,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "value:0.05",
					type = "effect-1_condition-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1450003,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "血量判定范围增加<effect-1_condition-1_value%%>",
		code = 145000304,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "value:0.05",
					type = "effect-1_condition-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1450003,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "血量判定范围增加<effect-1_condition-1_value%%>",
		code = 145000305,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "value:0.05",
					type = "effect-1_condition-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1450006,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "伤害增加<effect-2_action-1_referRate%%>",
		code = 145000601,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1450006,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "伤害增加<effect-2_action-1_referRate%%>",
		code = 145000602,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1450006,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "伤害增加<effect-2_action-1_referRate%%>",
		code = 145000603,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1450006,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "伤害增加<effect-2_action-1_referRate%%>",
		code = 145000604,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1450006,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "伤害增加<effect-2_action-1_referRate%%>",
		code = 145000605,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.03",
					type = "effect-2_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1450008,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "伤害提高效果增加<effect-1_action-1_referRate%%>",
		code = 145000801,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1450008,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "伤害提高效果增加<effect-1_action-1_referRate%%>",
		code = 145000802,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1450008,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "伤害提高效果增加<effect-1_action-1_referRate%%>",
		code = 145000803,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1450008,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "伤害提高效果增加<effect-1_action-1_referRate%%>",
		code = 145000804,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1450008,
		name = "思维升级",
		remarks = "",
		newDesc = "",
		modDesc = "伤害提高效果增加<effect-1_action-1_referRate%%>",
		code = 145000805,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "referRate:0.03",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	},
	{
		skillCode = 1460001,
		name = "升级",
		remarks = "",
		newDesc = "",
		modDesc = "范围+<effect-1_action-1_shape_range>",
		code = 146000101,
		upgradeType = 1,
		normalConfig = {
			modList = {
				{
					effectStr = "shape_range:1",
					type = "effect-1_action-1"
				}
			},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		},
		godlikeConfig = {
			modList = {},
			addEffect = {
				effectObject = 1,
				conditionJudgeOnlyMainTarget = false,
				time = -1,
				timePrograming = "",
				conditionList = {},
				actionList = {}
			}
		}
	}
}
local configDataDic = {}

configDataDic.configData = configData

for _, v in ipairs(configData) do
	configDataDic[v.code] = v
end

return configDataDic
