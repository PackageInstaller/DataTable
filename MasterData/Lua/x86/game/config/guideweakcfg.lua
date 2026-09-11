return {
	[1005] = {
		closetime = 5,
		priority = -3,
		talk_adapt = 1,
		talk_anchors = 1,
		name = "home",
		narrator_icon = "mmr",
		id = 1005,
		talk_content = "相信管理员现在已经对自己的基本职责非常熟悉了，那就让我们开启进修企划吧！",
		narrator_name = "弥弥尔",
		guide_component = {
			"btn_newbie_task"
		},
		mask_component = {},
		opencondition = {
			{
				"newbieTaskOpen"
			}
		},
		skipcondition = {},
		talk_position = {
			568,
			-267
		}
	},
	[1201] = {
		closetime = 5,
		priority = 0,
		talk_adapt = 0,
		talk_anchors = 0,
		name = "newHero",
		narrator_icon = "mmr",
		id = 1201,
		talk_content = "「连携奥义动画」回看功能已经开放，管理员现在可以回看修正者们的连携奥义动画了。",
		narrator_name = "弥弥尔",
		guide_component = {
			"pages_",
			2,
			"buttonComboSkill_"
		},
		mask_component = {},
		opencondition = {
			{
				"uiName",
				"newHero"
			},
			{
				"anyComboSkill"
			}
		},
		skipcondition = {
			{
				"uiName",
				"comboSkillInfo"
			}
		},
		talk_position = {
			80,
			125
		}
	},
	[1202] = {
		closetime = 5,
		priority = 0,
		talk_adapt = 0,
		talk_anchors = 8,
		name = "comboSkillInfo",
		narrator_icon = "mmr",
		id = 1202,
		talk_content = "管理员可以从此处查看修正者们的连携奥义动画。",
		narrator_name = "弥弥尔",
		guide_component = {
			"viewBtn_"
		},
		mask_component = {},
		opencondition = {
			{
				"uiName",
				"comboSkillInfo"
			},
			{
				"anyComboSkill"
			}
		},
		skipcondition = {
			{
				"uiName",
				"HeroCooperationView"
			}
		},
		talk_position = {
			-50,
			100
		}
	},
	[1301] = {
		closetime = 5,
		priority = 0,
		talk_adapt = 0,
		talk_anchors = 3,
		name = "heroPreviewChange",
		narrator_icon = "mmr",
		id = 1301,
		talk_content = "「连携奥义动画」回看功能已经开放，管理员现在可以回看修正者们的连携奥义动画了。",
		narrator_name = "弥弥尔",
		guide_component = {
			"infoBtn_"
		},
		mask_component = {},
		opencondition = {
			{
				"uiName",
				"heroPreviewChange"
			},
			{
				"anyComboSkill"
			}
		},
		skipcondition = {
			{
				"uiName",
				"heroPreviewMain"
			}
		},
		talk_position = {
			-380,
			220
		}
	},
	[1302] = {
		closetime = 5,
		priority = 0,
		talk_adapt = 0,
		talk_anchors = 2,
		name = "heroPreviewMain",
		narrator_icon = "mmr",
		id = 1302,
		talk_content = "管理员可以从此处查看修正者们的连携奥义动画。",
		narrator_name = "弥弥尔",
		guide_component = {
			"subPages_",
			1,
			"cooperationBtn_"
		},
		mask_component = {},
		opencondition = {
			{
				"uiName",
				"heroPreviewMain"
			},
			{
				"anyComboSkill"
			}
		},
		skipcondition = {
			{
				"uiName",
				"HeroCooperationView"
			}
		},
		talk_position = {
			-650,
			-685
		}
	},
	[1401] = {
		closetime = 5,
		priority = 0,
		talk_adapt = 1,
		talk_anchors = 1,
		name = "home",
		narrator_icon = "mmr",
		id = 1401,
		talk_content = "管理员，贴纸系统已完成更新，快来看看吧。",
		narrator_name = "弥弥尔",
		guide_component = {
			"btn_message"
		},
		mask_component = {},
		opencondition = {
			{
				"uiName",
				"home"
			}
		},
		skipcondition = {
			{
				"uiName",
				"userinfo"
			}
		},
		talk_position = {
			410,
			-230
		}
	},
	[1402] = {
		closetime = 5,
		priority = 0,
		talk_adapt = 0,
		talk_anchors = 4,
		name = "userinfo",
		narrator_icon = "mmr",
		id = 1402,
		talk_content = "管理员，快来试试自由摆放的贴纸吧！",
		narrator_name = "弥弥尔",
		guide_component = {
			"illustratedStickerBtn_"
		},
		mask_component = {},
		opencondition = {
			{
				"uiName",
				"userinfo"
			}
		},
		skipcondition = {
			{
				"uiName",
				"customStickerMain"
			}
		},
		talk_position = {
			1371,
			125
		}
	},
	[1501] = {
		closetime = 5,
		priority = 0,
		talk_adapt = 1,
		talk_anchors = 5,
		name = "polyhedronLobby",
		narrator_icon = "mmr",
		id = 1501,
		talk_content = "演算终端机现已完成优化升级，提高了信息探索的效率，「维度偏移」的最高等级从40级调降至20级，可以获取的奖励总量不变。",
		narrator_name = "弥弥尔",
		guide_component = {
			"m_policyBtn"
		},
		mask_component = {},
		opencondition = {
			{
				"uiName",
				"polyhedronLobby"
			}
		},
		skipcondition = {
			{
				"uiName",
				"polyhedronPolicyReward"
			}
		},
		talk_position = {
			830,
			68
		}
	},
	[1502] = {
		closetime = 5,
		priority = 0,
		talk_adapt = 1,
		talk_anchors = 5,
		name = "polyhedronLobby",
		narrator_icon = "mmr",
		id = 1502,
		talk_content = "「维度曲线」的任务系统更新，将提供固有状态的任务，降低了整体任务处理流程的复杂度。",
		narrator_name = "弥弥尔",
		guide_component = {
			"m_taskBtn"
		},
		mask_component = {},
		opencondition = {
			{
				"uiName",
				"polyhedronLobby"
			}
		},
		skipcondition = {
			{
				"uiName",
				"polyhedronTask"
			}
		},
		talk_position = {
			776,
			-151
		}
	},
	[1701] = {
		closetime = 5,
		priority = 1,
		talk_adapt = 0,
		talk_anchors = 0,
		name = "challengeRogueTeamSectionSelectHero",
		narrator_icon = "mmr",
		id = 1701,
		talk_content = "这里可以关闭队友特效",
		narrator_name = "弥弥尔",
		guide_component = {
			"conditionBtn_"
		},
		mask_component = {},
		opencondition = {
			{
				"uiName",
				"challengeRogueTeamSectionSelectHero"
			}
		},
		skipcondition = {},
		talk_position = {
			320,
			380
		}
	},
	[1804] = {
		closetime = 5,
		priority = 2,
		talk_adapt = 0,
		talk_anchors = 7,
		name = "bloodCardGame",
		narrator_icon = "9508",
		id = 1804,
		talk_content = "有时我们会遇到一些希望对手先行动的局面，也可以选择主动结束回合，双方都直接结束回合的时候游戏结束。",
		narrator_name = "老板娘",
		guide_component = {
			"guideComponents",
			"guide_jumpRoundBtn"
		},
		mask_component = {},
		opencondition = {
			{
				"bloodCardFunction",
				1804
			}
		},
		skipcondition = {},
		talk_position = {
			-346,
			-151
		}
	},
	[1805] = {
		closetime = 5,
		priority = 1,
		talk_adapt = 0,
		talk_anchors = 4,
		name = "bloodCardDeckCheck",
		narrator_icon = "9508",
		id = 1805,
		talk_content = "刚刚我们获得了一些群侠牌，现在我们可以开始更换和配置卡组了",
		narrator_name = "老板娘",
		guide_component = {
			"changeBtn_"
		},
		mask_component = {},
		opencondition = {
			{
				"uiName",
				"bloodCardDeckCheck"
			}
		},
		skipcondition = {},
		talk_position = {
			692,
			252
		}
	},
	[1901] = {
		closetime = 10,
		priority = 1,
		talk_adapt = 0,
		talk_anchors = 0,
		name = "eatSnakesGame",
		narrator_icon = "mmr",
		id = 1901,
		talk_content = "收集对应颜色的绣珠后通过这里即可完成目标",
		narrator_name = "弥弥尔",
		guide_component = {
			"guideComponents",
			"guide_weak"
		},
		mask_component = {},
		opencondition = {
			{
				"uiName",
				"eatSnakesGame"
			}
		},
		skipcondition = {},
		talk_position = {
			0,
			380
		}
	},
	[2102] = {
		closetime = 5,
		priority = 1,
		talk_adapt = 0,
		talk_anchors = 0,
		name = "seaWarfareNormalBattleReady",
		narrator_icon = "1073",
		id = 2102,
		talk_content = "姐姐加入以后，我们的船变得更厉害了呢。",
		narrator_name = "麟钰",
		guide_component = {
			"guideComponents",
			"guide_introduce3"
		},
		mask_component = {},
		opencondition = {
			{
				"qworldSubQuest",
				11104003
			},
			{
				"uiNameList",
				{
					"seaWarfareNormalBattleReady"
				}
			}
		},
		skipcondition = {},
		talk_position = {
			-85,
			122
		}
	},
	[2103] = {
		closetime = 5,
		priority = 1,
		talk_adapt = 0,
		talk_anchors = 0,
		name = "qWorldBookletMain",
		narrator_icon = "1073",
		id = 2103,
		talk_content = "要是在街巷中拍到了好风景，就记录在这里吧。",
		narrator_name = "麟钰",
		guide_component = {
			"extraScenicBtn_"
		},
		mask_component = {},
		opencondition = {
			{
				"qworldSubQuest",
				11104011
			},
			{
				"uiNameList",
				{
					"qWorldBookletMain"
				}
			}
		},
		skipcondition = {},
		talk_position = {
			-581,
			133
		}
	},
	[2201] = {
		closetime = 5,
		priority = 1,
		talk_adapt = 0,
		talk_anchors = 7,
		name = "tetrisGameStageView",
		narrator_icon = "mmr",
		id = 2201,
		talk_content = "携带新技能「更替重置」会每回合放置一个方块后，将<color=#F48800>直接进入下一个回合</color>，即右侧方块刷新。",
		narrator_name = "弥弥尔",
		guide_component = {
			"guideComponents",
			"guide_s1_2"
		},
		mask_component = {},
		opencondition = {
			{
				"uiNameList",
				{
					"tetrisGameStageView"
				}
			},
			{
				"tetris",
				"tetrisStage",
				40104
			}
		},
		skipcondition = {},
		talk_position = {
			-880,
			283
		}
	},
	[2202] = {
		closetime = 5,
		priority = 1,
		talk_adapt = 0,
		talk_anchors = 0,
		name = "tetrisGameStageView",
		narrator_icon = "mmr",
		id = 2202,
		talk_content = "如果坚持<color=#F48800>放入9个方块也不消除</color>就可以<color=#F48800>锁定</color>特殊方块了。",
		narrator_name = "弥弥尔",
		guide_component = {
			"guideComponents",
			"guide_s3_1"
		},
		mask_component = {},
		opencondition = {
			{
				"uiNameList",
				{
					"tetrisGameStageView"
				}
			},
			{
				"tetris",
				"tetrisStage",
				40107
			}
		},
		skipcondition = {},
		talk_position = {
			-531,
			-133
		}
	},
	[2301] = {
		closetime = 5,
		priority = 1,
		talk_adapt = 0,
		talk_anchors = 0,
		name = "summerPubEnterView",
		narrator_icon = "10144_split_1",
		id = 2301,
		talk_content = "来不及解释了，快继续探险吧！",
		narrator_name = "尼娅",
		guide_component = {
			"exploreBtn_"
		},
		mask_component = {
			"guideComponents",
			"guide_Explore"
		},
		opencondition = {
			{
				"uiName",
				"summerPubEnterView"
			},
			{
				"guide",
				140
			},
			{
				"cookid",
				4030001
			}
		},
		skipcondition = {},
		talk_position = {
			-55,
			-319.5
		}
	},
	[3001] = {
		closetime = 10,
		priority = 1,
		talk_adapt = 0,
		talk_anchors = 4,
		name = "passportMain",
		narrator_icon = "mmr",
		id = 3001,
		talk_content = "可以在合作商店中兑换角色情报了，管理员快来看看吧。",
		narrator_name = "弥弥尔",
		guide_component = {
			"shopBtn_"
		},
		mask_component = {},
		opencondition = {
			{
				"stage",
				1010102
			}
		},
		skipcondition = {},
		talk_position = {
			655,
			230
		}
	},
	[3201] = {
		closetime = 5,
		priority = 1,
		talk_adapt = 0,
		talk_anchors = 0,
		name = "pinballTurnBasedGame",
		narrator_icon = "ganglati",
		id = 3201,
		talk_content = "可以点击<color=#E78300>二倍速</color>，更快速度发射弹珠。",
		narrator_name = "迟钝",
		guide_component = {
			"guideComponents",
			"guide_20806"
		},
		mask_component = {},
		opencondition = {
			{
				"uiName",
				"pinballTurnBasedGame"
			},
			{
				"guide",
				209
			}
		},
		skipcondition = {},
		talk_position = {
			626,
			240
		}
	},
	[3301] = {
		closetime = 5,
		priority = 1,
		talk_adapt = 0,
		talk_anchors = 5,
		mask_component = "",
		name = "adminHomePageView",
		narrator_icon = "128402",
		id = 3301,
		talk_content = "管理员，仪式要开始了，带上我们「最初的誓约」，一起出发吧。",
		narrator_name = "薇儿丹蒂",
		guide_component = {
			"guideComponents",
			"guide_1"
		},
		opencondition = {
			{
				"playerLevel",
				27
			},
			{
				"uiNameList",
				{
					"adminHomePageView"
				}
			},
			{
				"system",
				3110
			}
		},
		skipcondition = {},
		talk_position = {
			820,
			172
		}
	},
	[3401] = {
		closetime = 10,
		priority = 1,
		talk_adapt = 0,
		talk_anchors = 2,
		mask_component = "",
		name = "chapterV2MapMain",
		narrator_icon = "1070",
		id = 3401,
		talk_content = "点击这里，每段主线故事结束以后就会自动翻到下一节主线故事的位置。",
		narrator_name = "金乌",
		guide_component = {
			"trackBtnGo_"
		},
		opencondition = {
			{
				"v2MapEventFinish",
				4080104
			},
			{
				"uiNameList",
				{
					"chapterV2MapMain"
				}
			}
		},
		skipcondition = {},
		talk_position = {
			-550,
			-230
		}
	},
	[3601] = {
		closetime = 10,
		priority = 1,
		talk_adapt = 0,
		talk_anchors = 0,
		name = "home",
		narrator_icon = "1019",
		id = 3601,
		talk_content = "隐科组开发的内部通讯软件已经完成了，我帮你下载到了终端里，有空记得来看看。",
		narrator_name = "休",
		guide_component = {
			"momoTalkBtn_"
		},
		mask_component = {},
		opencondition = {
			{
				"playerLevel",
				1
			}
		},
		skipcondition = {},
		talk_position = {
			210,
			243
		}
	},
	[10201] = {
		closetime = 5,
		priority = -1,
		talk_adapt = 2,
		talk_anchors = 3,
		name = "home",
		narrator_icon = "mmr",
		id = 10201,
		talk_content = "矩阵公会现已开放。",
		narrator_name = "弥弥尔",
		guide_component = {
			"btnGuild_"
		},
		mask_component = {},
		opencondition = {
			{
				"playerLevel",
				30
			}
		},
		skipcondition = {
			{
				"stage",
				1010613
			}
		},
		talk_position = {
			-600,
			240
		}
	},
	[10301] = {
		closetime = 5,
		priority = 1,
		talk_adapt = 1,
		talk_anchors = 1,
		name = "home",
		narrator_icon = "mmr",
		id = 10301,
		talk_content = "新人，这是我们特意为你准备的欢迎仪式，希望你能再接再厉。",
		narrator_name = "弥弥尔",
		guide_component = {
			"buttonNewbie_"
		},
		mask_component = {},
		opencondition = {
			{
				"stage",
				1030006
			}
		},
		skipcondition = {
			{
				"stage",
				1030306
			}
		},
		talk_position = {
			568,
			-284
		}
	},
	[10401] = {
		closetime = 5,
		priority = 4,
		talk_adapt = 0,
		talk_anchors = 4,
		name = "chapterMap",
		narrator_icon = "mmr",
		id = 10401,
		talk_content = "「模拟作战」玩法开放，修正者升级所需物资获取权限已开启。",
		narrator_name = "弥弥尔",
		guide_component = {
			"toggleView_",
			2,
			"button_"
		},
		mask_component = {},
		opencondition = {
			{
				"stage",
				1030101
			}
		},
		skipcondition = {
			{
				"stage",
				1030306
			}
		},
		talk_position = {
			970,
			285
		}
	},
	[10501] = {
		closetime = 5,
		priority = 2,
		talk_adapt = 0,
		talk_anchors = 4,
		name = "chapterMap",
		narrator_icon = "mmr",
		id = 10501,
		talk_content = "「失落遗迹」玩法开放，修正者突破所需物资获取权限已开启。",
		narrator_name = "弥弥尔",
		guide_component = {
			"toggleView_",
			2,
			"button_"
		},
		mask_component = {},
		opencondition = {
			{
				"stage",
				1030102
			}
		},
		skipcondition = {
			{
				"stage",
				1030306
			}
		},
		talk_position = {
			970,
			285
		}
	},
	[10601] = {
		closetime = 5,
		priority = 5,
		talk_adapt = 0,
		talk_anchors = 4,
		name = "chapterMap",
		narrator_icon = "mmr",
		id = 10601,
		talk_content = "「因子采集」玩法开放，技能升级所需物资获取权限已开启。",
		narrator_name = "弥弥尔",
		guide_component = {
			"toggleView_",
			2,
			"button_"
		},
		mask_component = {},
		opencondition = {
			{
				"stage",
				1030103
			}
		},
		skipcondition = {
			{
				"stage",
				1030306
			}
		},
		talk_position = {
			970,
			285
		}
	},
	[10701] = {
		closetime = 5,
		priority = 3,
		talk_adapt = 0,
		talk_anchors = 4,
		name = "chapterMap",
		narrator_icon = "mmr",
		id = 10701,
		talk_content = "「深层勘探」玩法开放，权钥升级所需物资获取权限已开启。",
		narrator_name = "弥弥尔",
		guide_component = {
			"toggleView_",
			2,
			"button_"
		},
		mask_component = {},
		opencondition = {
			{
				"stage",
				1030108
			}
		},
		skipcondition = {
			{
				"stage",
				1030306
			}
		},
		talk_position = {
			970,
			285
		}
	},
	[10801] = {
		closetime = 5,
		priority = 1,
		talk_adapt = 0,
		talk_anchors = 4,
		name = "chapterMap",
		narrator_icon = "mmr",
		id = 10801,
		talk_content = "「极限萃取」、「酬金委托」玩法开放，全部物资获取权限已开启。",
		narrator_name = "弥弥尔",
		guide_component = {
			"toggleView_",
			2,
			"button_"
		},
		mask_component = {},
		opencondition = {
			{
				"stage",
				1030109
			}
		},
		skipcondition = {
			{
				"stage",
				1030306
			}
		},
		talk_position = {
			970,
			285
		}
	},
	[10901] = {
		closetime = 5,
		priority = -2,
		talk_adapt = 2,
		talk_anchors = 2,
		name = "home",
		narrator_icon = "mmr",
		id = 10901,
		talk_content = "管理员，热门活动的参与入口已经开放了。",
		narrator_name = "弥弥尔",
		guide_component = {
			"@@activityEntraceView_",
			1
		},
		mask_component = {
			"guideComponents",
			"guide_activity"
		},
		opencondition = {
			{
				"playerLevel",
				20
			},
			{
				"stage",
				1030306
			}
		},
		skipcondition = {
			{
				"stage",
				1010613
			}
		},
		talk_position = {
			-760,
			-330
		}
	},
	get_id_list_by_name = {
		chapterMap = {
			10401,
			10501,
			10601,
			10701,
			10801
		},
		chapterV2MapMain = {
			3401
		},
		adminHomePageView = {
			3301
		},
		pinballTurnBasedGame = {
			3201
		},
		passportMain = {
			3001
		},
		summerPubEnterView = {
			2301
		},
		tetrisGameStageView = {
			2201,
			2202
		},
		qWorldBookletMain = {
			2103
		},
		seaWarfareNormalBattleReady = {
			2102
		},
		eatSnakesGame = {
			1901
		},
		bloodCardDeckCheck = {
			1805
		},
		bloodCardGame = {
			1804
		},
		challengeRogueTeamSectionSelectHero = {
			1701
		},
		polyhedronLobby = {
			1501,
			1502
		},
		userinfo = {
			1402
		},
		heroPreviewMain = {
			1302
		},
		heroPreviewChange = {
			1301
		},
		comboSkillInfo = {
			1202
		},
		newHero = {
			1201
		},
		home = {
			1005,
			1401,
			3601,
			10201,
			10301,
			10901
		}
	},
	all = {
		1005,
		1201,
		1202,
		1301,
		1302,
		1401,
		1402,
		1501,
		1502,
		1701,
		1804,
		1805,
		1901,
		2102,
		2103,
		2201,
		2202,
		2301,
		3001,
		3201,
		3301,
		3401,
		3601,
		10201,
		10301,
		10401,
		10501,
		10601,
		10701,
		10801,
		10901
	}
}
