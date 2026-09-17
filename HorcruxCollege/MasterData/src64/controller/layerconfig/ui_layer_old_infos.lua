return {
	ListButton = {
		showSmallFightLayer = false,
		zOrder = 3,
		aniUIElement = {},
		createLayer = function()
			require("view.Layer.ListButtonLayer")

			return (ListButtonLayer:create())
		end
	},
	FightLayer = {
		showSmallFightLayer = true,
		uiLayerName = "panel_back",
		uiPanelName = "playeritem_panel",
		showTopcostLayer = true,
		zOrder = 2,
		aniUIElement = {
			["players@1"] = {
				initPos = {
					x = -132,
					y = 126
				},
				finalPos = {
					x = 508,
					y = 126
				}
			},
			["players@2"] = {
				initPos = {
					x = -322,
					y = 126
				},
				finalPos = {
					x = 320,
					y = 126
				}
			},
			["players@3"] = {
				initPos = {
					x = -512,
					y = 126
				},
				finalPos = {
					x = 132,
					y = 126
				}
			}
		},
		listButtonRelationUIName = {},
		bgm = FIGHT_BGM,
		createLayer = function()
			require("view.Layer.FightLayer")

			return (FightLayer:create())
		end,
		textures = {
			"chat_system_layer",
			"TowerDefenceListPanel",
			"MainLineTask"
		}
	},
	SmallFightLayer = {
		showSmallFightLayer = false,
		zOrder = 1,
		aniUIElement = {},
		listButtonRelationUIName = {},
		createLayer = function()
			require("view.Layer.SmallFightLayer")

			return (SmallFightLayer:create())
		end
	},
	MainLayer = {
		showTopcostLayer = true,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 2,
		aniUIElement = {
			panel_thirdlist = {
				initPos = {
					x = -178,
					y = GameDisplay.top - 163 - GameDisplay.fix_y - GameDisplay.notch_height
				},
				finalPos = {
					x = 122,
					y = GameDisplay.top - 163 - GameDisplay.fix_y - GameDisplay.notch_height
				}
			},
			panel_sencondlist = {
				initPos = {
					x = 710,
					y = 611 - GameDisplay.fix_y
				},
				finalPos = {
					x = 210,
					y = 611 - GameDisplay.fix_y
				}
			}
		},
		listButtonRelationUIName = {
			"panel_userinfo",
			"panel_bg1",
			"image_notice"
		},
		bgm = MAIN_BGM,
		createLayer = function()
			require("view.Layer.MainLayer")

			return (MainLayer:create())
		end,
		textures = {
			"MainLayer",
			"activity_return",
			"MainLineTask"
		}
	},
	BagLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		zOrder = 0,
		aniUIElement = {
			filterList = {
				initPos = {
					x = 0,
					y = 1080 + GameDisplay.fix_y - GameDisplay.notch_height
				},
				finalPos = {
					x = 0,
					y = 1080 + GameDisplay.fix_y - GameDisplay.notch_height
				}
			},
			button_add_num = {
				initPos = {
					x = 812,
					y = 81 - GameDisplay.fix_y
				},
				finalPos = {
					x = 512,
					y = 81 - GameDisplay.fix_y
				}
			},
			panel_right = {
				initPos = {
					x = 0,
					y = 0 + GameDisplay.fix_y - GameDisplay.notch_height
				},
				finalPos = {
					x = 0,
					y = 0 + GameDisplay.fix_y - GameDisplay.notch_height
				}
			}
		},
		listButtonRelationUIName = {
			"topUI"
		},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.BagLayer")

			return (BagLayer:create(...))
		end,
		textures = {
			"BagLayer",
			"HorcruxLayer",
			"HorcruxSelectLayer"
		}
	},
	EnergyLabLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		zOrder = 0,
		aniUIElement = {
			title = {
				initPos = {
					x = 320,
					y = 1636
				},
				finalPos = {
					x = 320,
					y = 1136
				}
			},
			bottom = {
				initPos = {
					x = 320,
					y = -599
				},
				finalPos = {
					x = 320,
					y = 0
				}
			}
		},
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.EnergyLabLayer")

			return (EnergyLabLayer:create(...))
		end
	},
	TaskLayer = {
		enterVisibleListButton = false,
		statusbarbg = "taskstatusbar",
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		zOrder = 0,
		aniUIElement = {
			panel_tab = {
				initPos = {
					x = 0,
					y = 1136
				},
				finalPos = {
					x = 0,
					y = 9
				}
			}
		},
		listButtonRelationUIName = {
			"panel_top_0"
		},
		bg = TASK_BG,
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.TaskLayer")

			return (TaskLayer:create(...))
		end
	},
	EquipLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		showTopcostLayer = true,
		zOrder = 0,
		aniUIElement = {},
		listButtonRelationUIName = {},
		bgm = FIGHT_BGM,
		createLayer = function(...)
			require("view.Layer.EquipLayer")

			return (SoulsLayer:create(...))
		end
	},
	RankListLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		showTopcostLayer = true,
		zOrder = 0,
		aniUIElement = {
			framepanel = {
				initPos = {
					x = -640,
					y = 94
				},
				finalPos = {
					x = 23,
					y = 94
				}
			},
			button_return = {
				initPos = {
					x = -640,
					y = 118
				},
				finalPos = {
					x = 50,
					y = 118
				}
			}
		},
		listButtonRelationUIName = {
			"panel_top"
		},
		bgm = MAIN_BGM,
		bg = UIBG,
		createLayer = function()
			require("view.Layer.RankListLayer")

			return (RankListLayer:create(1))
		end,
		textures = {
			"ArenaScene"
		}
	},
	ArenaLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		zOrder = 0,
		aniUIElement = {},
		listButtonRelationUIName = {
			"panel_top"
		},
		bgm = MAIN_BGM,
		bg = AREANBG,
		createLayer = function(...)
			return (require("view.Layer.ArenaLayer"):create(...))
		end,
		textures = {
			"ArenaScene",
			"Array",
			"ArenaLayer"
		}
	},
	SettingLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		uiLayerName = "Panel_9",
		showTopcostLayer = false,
		zOrder = 0,
		aniUIElement = {
			sound_panel = {
				initPos = {
					x = -608,
					y = global_transfrompercent_pos(677)
				},
				finalPos = {
					x = 14,
					y = global_transfrompercent_pos(677)
				}
			},
			push_panel = {
				initPos = {
					x = 618,
					y = global_transfrompercent_pos(482)
				},
				finalPos = {
					x = 14,
					y = global_transfrompercent_pos(482)
				}
			},
			service_panel = {
				initPos = {
					x = -554,
					y = global_transfrompercent_pos(307)
				},
				finalPos = {
					x = 14,
					y = global_transfrompercent_pos(307)
				}
			},
			other_panel = {
				initPos = {
					x = 618,
					y = global_transfrompercent_pos(80)
				},
				finalPos = {
					x = 14,
					y = global_transfrompercent_pos(80)
				}
			}
		},
		bg = SETTINGBG,
		listButtonRelationUIName = {
			"panel_top"
		},
		createLayer = function()
			require("view.Layer.SettingLayer")

			return (SettingLayer:create())
		end,
		textures = {
			"settingLayer"
		}
	},
	HandOfMidasLayer = {
		enterVisibleListButton = true,
		showSmallFightLayer = false,
		uiLayerName = "Panel_9",
		showTopcostLayer = true,
		zOrder = 0,
		aniUIElement = {
			bg = {
				initPos = {
					x = 1123,
					y = 628
				},
				finalPos = {
					x = 323,
					y = 628
				}
			},
			box = {
				initPos = {
					x = 920,
					y = 724
				},
				finalPos = {
					x = 320,
					y = 734
				}
			},
			panel_midas = {
				initPos = {
					x = 799,
					y = 0
				},
				finalPos = {
					x = -1,
					y = 0
				}
			}
		},
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.SignLayer")

			return (SignLayer:create(...))
		end,
		textures = {
			"midas"
		}
	},
	HorcruxLayer = {
		enterVisibleListButton = true,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		showTopcostLayer = true,
		zOrder = 0,
		aniUIElement = {},
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = HORCRUXBG,
		createLayer = function(...)
			require("view.Layer.HorcruxLayer")

			return (HorcruxLayer:create(...))
		end,
		textures = {
			"HorcruxLayer",
			"HorcruxSelectLayer"
		}
	},
	TwisteggLayer = {
		enterVisibleListButton = false,
		loading = true,
		showSmallFightLayer = false,
		uiLayerName = "panel_twist",
		uiPanelName = "panel_twistegg",
		showTopcostLayer = true,
		zOrder = 0,
		aniUIElement = {},
		listButtonRelationUIName = {},
		bg = TWISTBG,
		createLayer = function(...)
			require("view.Layer.TwisteggLayer")

			return (TwisteggLayer:create(...))
		end
	},
	AITwistLayer = {
		enterVisibleListButton = false,
		loading = true,
		showSmallFightLayer = false,
		uiLayerName = "panel_twist",
		uiPanelName = "panel_twistegg",
		showTopcostLayer = false,
		zOrder = 0,
		aniUIElement = {},
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = TWISTBG,
		createLayer = function(...)
			require("view.Layer.AITwistLayer")

			return (AITwistLayer:create(...))
		end
	},
	DormitoryLayer = {
		enterVisibleListButton = true,
		loading = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		zOrder = 0,
		aniUIElement = {},
		listButtonRelationUIName = {},
		bgm = FAVOR_BGM,
		bg = DORM_BG,
		createLayer = function(...)
			require("view.Layer.DormitoryLayer")

			return (DormitoryLayer:create(...))
		end,
		textures = {
			"Dormitory",
			"room_widget",
			"DormQuickList"
		}
	},
	SignLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		aniUIElement = {},
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.SignLayer")

			return (SignLayer:create(...))
		end
	},
	RechargeLayer = {
		enterVisibleListButton = false,
		statusbarbg = "shopstatusbar",
		showSmallFightLayer = false,
		bg = "mainScenebg/Recharge_bg.jpg",
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		zOrder = 0,
		aniUIElement = {
			frame_back = {
				initPos = {
					x = 658,
					y = 61
				},
				finalPos = {
					x = 18,
					y = 61
				}
			},
			image_system_figure = {
				initPos = {
					x = -150,
					y = 197
				},
				finalPos = {
					x = 82,
					y = 197
				}
			},
			button_return = {
				initPos = {
					x = -150,
					y = 118
				},
				finalPos = {
					x = 50,
					y = 118
				}
			}
		},
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.RechargeLayer")

			return (RechargeLayer:create(...))
		end,
		textures = {
			"recharge",
			"MarketLayer"
		}
	},
	TopcostLayer = {
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		showSmallFightLayer = false,
		zOrder = 3,
		aniUIElement = {},
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function()
			require("view.Layer.TopcostLayer")

			return (TopcostLayer:create())
		end
	},
	MarketLayer = {
		enterVisibleListButton = false,
		statusbarbg = "shopstatusbar",
		showSmallFightLayer = false,
		uiLayerName = "Panel_7",
		showTopcostLayer = false,
		zOrder = 0,
		aniUIElement = {
			panel_bottom = {
				initPos = {
					x = -640,
					y = -GameDisplay.fix_y
				},
				finalPos = {
					x = 0,
					y = -GameDisplay.fix_y
				}
			}
		},
		listButtonRelationUIName = {},
		bg = TASK_BG,
		createLayer = function(...)
			require("view.Layer.MarketLayer")

			return (MarketLayer:create(...))
		end,
		textures = {
			"MarketLayer",
			"CostumeRoomLayer"
		}
	},
	MallLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		showTopcostLayer = true,
		zOrder = 2,
		aniUIElement = {
			button_market = {
				initPos = {
					x = 958,
					y = 567
				},
				finalPos = {
					x = 318,
					y = 567
				}
			},
			button_heishi = {
				initPos = {
					x = -322,
					y = 889
				},
				finalPos = {
					x = 318,
					y = 889
				}
			},
			button_recharge = {
				initPos = {
					x = -322,
					y = 244
				},
				finalPos = {
					x = 318,
					y = 244
				}
			},
			bottom = {
				initPos = {
					x = 320,
					y = -100
				},
				finalPos = {
					x = 320,
					y = 0
				}
			}
		},
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.MallLayer")

			return (MallLayer:create(...))
		end
	},
	MailLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		showTopcostLayer = true,
		zOrder = 0,
		aniUIElement = {
			image_system_figure = {
				initPos = {
					x = 575,
					y = 1847
				},
				finalPos = {
					x = 575,
					y = 847
				}
			},
			frame_back = {
				initPos = {
					x = 1120,
					y = 568
				},
				finalPos = {
					x = 320,
					y = 568
				}
			}
		},
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.MailLayer")

			return (MailLayer:create(...))
		end
	},
	ExploreUILayer = {
		enterVisibleListButton = true,
		showTopcostLayer = true,
		showSmallFightLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ExploreUILayer")

			return (ExploreUILayer:create(...))
		end
	},
	ExploreMapLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = EXPLORE_BGM,
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ExploreMapLayer")

			return (ExploreMapLayer:create(...))
		end,
		textures = {
			"explore"
		}
	},
	PhotoFileHelpGirlLayer = {
		zOrder = 0,
		showTopcostLayer = true,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		listButtonRelationUIName = {
			"panel_top"
		},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.PhotoFileHelpGirlLayer")

			return (PhotoFileHelpGirlLayer:create(...))
		end
	},
	ClassupdateLayer = {
		showSmallFightLayer = false,
		uiLayerName = "Panel_725",
		showTopcostLayer = false,
		zOrder = 5,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = CHANGELAYER,
		createLayer = function(...)
			require("view.Layer.ClassupdateLayer")

			return (ClassupdateLayer:create(...))
		end,
		textures = {
			"Class"
		}
	},
	WareHouseLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/warehouse_bg.jpg",
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		zOrder = 2,
		aniUIElement = {
			horcruxButton = {
				initPos = {
					x = -322,
					y = global_transfrompercent_pos(900 - GameDisplay.fix_y / 2)
				},
				finalPos = {
					x = 318,
					y = global_transfrompercent_pos(900 - GameDisplay.fix_y / 2)
				}
			},
			resourceButton = {
				initPos = {
					x = 812,
					y = global_transfrompercent_pos(603 - GameDisplay.fix_y / 2)
				},
				finalPos = {
					x = 172,
					y = global_transfrompercent_pos(603 - GameDisplay.fix_y / 2)
				}
			},
			labButton = {
				initPos = {
					x = 1103,
					y = global_transfrompercent_pos(603 - GameDisplay.fix_y / 2)
				},
				finalPos = {
					x = 463,
					y = global_transfrompercent_pos(603 - GameDisplay.fix_y / 2)
				}
			},
			partsButton = {
				initPos = {
					x = -467,
					y = global_transfrompercent_pos(264 - GameDisplay.fix_y / 2)
				},
				finalPos = {
					x = 173,
					y = global_transfrompercent_pos(264 - GameDisplay.fix_y / 2)
				}
			},
			foodButton = {
				initPos = {
					x = -177,
					y = global_transfrompercent_pos(267 - GameDisplay.fix_y / 2)
				},
				finalPos = {
					x = 463,
					y = global_transfrompercent_pos(267 - GameDisplay.fix_y / 2)
				}
			}
		},
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.WareHouseLayer")

			return (WareHouseLayer:create(...))
		end,
		textures = {
			"wareHouseLayer"
		}
	},
	WareHouseListBottonLayer = {
		enterVisibleListButton = true,
		showSmallFightLayer = false,
		bg = "mainScenebg/warehouse_bg.jpg",
		uiLayerName = "panel_back",
		showTopcostLayer = true,
		zOrder = 2,
		aniUIElement = {
			horcruxButton = {
				initPos = {
					x = -322,
					y = global_transfrompercent_pos(900 - GameDisplay.fix_y / 2)
				},
				finalPos = {
					x = 318,
					y = global_transfrompercent_pos(900 - GameDisplay.fix_y / 2)
				}
			},
			resourceButton = {
				initPos = {
					x = 812,
					y = global_transfrompercent_pos(603 - GameDisplay.fix_y / 2)
				},
				finalPos = {
					x = 172,
					y = global_transfrompercent_pos(603 - GameDisplay.fix_y / 2)
				}
			},
			labButton = {
				initPos = {
					x = 1103,
					y = global_transfrompercent_pos(603 - GameDisplay.fix_y / 2)
				},
				finalPos = {
					x = 463,
					y = global_transfrompercent_pos(603 - GameDisplay.fix_y / 2)
				}
			},
			partsButton = {
				initPos = {
					x = -467,
					y = global_transfrompercent_pos(264 - GameDisplay.fix_y / 2)
				},
				finalPos = {
					x = 173,
					y = global_transfrompercent_pos(264 - GameDisplay.fix_y / 2)
				}
			},
			foodButton = {
				initPos = {
					x = -177,
					y = global_transfrompercent_pos(267 - GameDisplay.fix_y / 2)
				},
				finalPos = {
					x = 463,
					y = global_transfrompercent_pos(267 - GameDisplay.fix_y / 2)
				}
			}
		},
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.WareHouseLayer")

			return (WareHouseLayer:createWithListBotton(...))
		end,
		textures = {
			"wareHouseLayer"
		}
	},
	LoadingLayer = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		zOrder = 5,
		createLayer = function(...)
			require("view.Layer.LoadingLayer")

			return (LoadingLayer:create(...))
		end
	},
	PhotoMemoryLayer = {
		loading = true,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		zOrder = 1,
		bgm = MAIN_BGM,
		bg = LABEL_BG,
		createLayer = function(...)
			require("view.Layer.PhotoMemoryLayer")

			return (PhotoMemoryLayer:create(...))
		end
	},
	PhotoGoodsLayer = {
		loading = true,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		zOrder = 1,
		bgm = MAIN_BGM,
		bg = LABEL_BG,
		createLayer = function(...)
			require("view.Layer.PhotoGoodsLayer")

			return (PhotoGoodsLayer:create(...))
		end
	},
	LevelMapLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = CHAPTERBG,
		createLayer = function(...)
			require("view.Layer.LevelMapLayer")

			return (LevelMapLayer:create(...))
		end,
		textures = {
			"LevelMap"
		}
	},
	LevelTalkMapLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = CHAPTERBG,
		createLayer = function(...)
			require("view.Layer.LevelTalkMapLayer")

			return (LevelTalkMapLayer:create(...))
		end,
		textures = {
			"LevelMap"
		}
	},
	ActivityMenuLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = CHAPTERBG,
		createLayer = function(...)
			require("view.Layer.ActivityMenuLayer")

			return (ActivityMenuLayer:create(...))
		end
	},
	GirlSelectLayer = {
		enterVisibleListButton = true,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/girlselectlayer_bg.png",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.GirlSelectLayer")

			return (GirlSelectLayer:create(...))
		end,
		textures = {
			"GirlSelectLayer"
		}
	},
	ActivityTaskLayer = {
		enterVisibleListButton = false,
		statusbarbg = "taskstatusbar",
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		zOrder = 0,
		aniUIElement = {
			panel_tab = {
				initPos = {
					x = 0,
					y = 1136
				},
				finalPos = {
					x = 0,
					y = 9
				}
			}
		},
		listButtonRelationUIName = {
			"panel_top_0"
		},
		bg = TASK_BG,
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityTaskLayer")

			return (ActivityTaskLayer:create(...))
		end,
		textures = {
			"Activity_PointActivityLayer"
		}
	},
	ActivityPointLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityPointLayer")

			return (ActivityPointLayer:create(...))
		end,
		textures = {
			"Activity_PointActivityLayer"
		}
	},
	ActivitySignLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.ActivitySignLayer")

			return (ActivitySignLayer:create(...))
		end
	},
	LabMenuLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.LabLayerNew")

			return (LabLayerNew:create(...))
		end,
		textures = {
			"room_widget",
			"lab_main_screen"
		}
	},
	SchoolAreaLayer = {
		enterVisibleListButton = true,
		loading = false,
		showTopcostLayer = true,
		showSmallFightLayer = false,
		statusbarbg = "schoolstatusbar",
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.SchoolAreaLayer")

			return (SchoolAreaLayer:create(...))
		end,
		textures = {
			"schoolArea"
		}
	},
	SchoolCinemaLayer = {
		enterVisibleListButton = false,
		loading = false,
		statusbarbg = "schoolstatusbar",
		showSmallFightLayer = false,
		loadingFinish = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = CINEMA_BG,
		createLayer = function(...)
			require("view.Layer.SchoolCinemaLayer")

			return (SchoolCinemaLayer:create(...))
		end,
		textures = {
			"SchoolCinemaLayer0",
			"SchoolCinemaLayer1",
			"Photo0",
			"Photo1"
		}
	},
	RecruitRoleLayer = {
		enterVisibleListButton = false,
		loading = false,
		statusbarbg = "schoolstatusbar",
		showSmallFightLayer = false,
		bg = "mainScenebg/recruit_role_bg.png",
		loadingFinish = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.RecruitRoleLayer")

			return (RecruitRoleLayer:create(...))
		end,
		textures = {
			"RecruitRoleLayer"
		}
	},
	SchoolFileLayer = {
		enterVisibleListButton = false,
		loading = false,
		statusbarbg = "schoolstatusbar",
		showSmallFightLayer = false,
		loadingFinish = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = FILE_BG,
		createLayer = function(...)
			require("view.Layer.SchoolFileLayer")

			return (SchoolFileLayer:create(...))
		end,
		textures = {
			"SchoolFileLayer"
		}
	},
	SchoolTrainLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		statusbarbg = "schoolstatusbar",
		loadingFinish = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.SchoolTrainLayer")

			return (SchoolTrainLayer:create(...))
		end,
		textures = {
			"room_widget",
			"SchoolTrainLayer"
		}
	},
	SchoolSwimLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = {
			SWIM_BGM,
			3
		},
		createLayer = function(...)
			require("view.Layer.SchoolSwimLayer")

			return (SchoolSwimLayer:create(...))
		end,
		textures = {
			"SchoolSwimLayer"
		}
	},
	SchoolDeanOfficeLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		statusbarbg = "schoolstatusbar",
		loadingFinish = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.SchoolDeanOfficeLayer")

			return (SchoolDeanOfficeLayer:create(...))
		end,
		textures = {
			"room_widget",
			"SchoolDeanOfficeLayer"
		}
	},
	NewSchoolDeanOfficeLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		statusbarbg = "schoolstatusbar",
		loadingFinish = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.NewSchoolDeanOfficeLayer")

			return (NewSchoolDeanOfficeLayer:create(...))
		end,
		textures = {
			"NewSchoolDeanOfficeLayer"
		}
	},
	ActivityEntranceLayer = {
		enterVisibleListButton = true,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = TASK_BG,
		createLayer = function(...)
			require("view.Layer.ActivityEntranceLayer")

			return (ActivityEntranceLayer:create(...))
		end,
		textures = {
			"PopActivityEntrance",
			"LinkActivityEntrance"
		}
	},
	LinkActivityEntranceLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = TASK_BG,
		createLayer = function(...)
			require("view.Layer.LinkActivityEntranceLayer")

			return (LinkActivityEntranceLayer:create(...))
		end,
		textures = {
			"LinkActivityEntrance",
			"PopActivityEntrance"
		}
	},
	NewLinkActivityEntranceLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = TASK_BG,
		createLayer = function(...)
			require("view.Layer.NewLinkActivityEntranceLayer")

			return (NewLinkActivityEntranceLayer:create(...))
		end,
		textures = {
			"LinkActivityEntrance",
			"PopActivityEntrance"
		}
	},
	ActivityFallingLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityFallingLayer")

			return (ActivityFallingLayer:create(...))
		end,
		textures = {
			"ActivityFallingLayer"
		}
	},
	ActivityFallingRankLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityFallingRankLayer")

			return (ActivityFallingRankLayer:create(...))
		end,
		textures = {
			"arenascenenew"
		}
	},
	ActivityBossFightRankLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityBossFightRankLayer")

			return (ActivityBossFightRankLayer:create(...))
		end,
		textures = {
			"arenascenenew"
		}
	},
	ActivityCompareLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityCompareLayer")

			return (ActivityCompareLayer:create(...))
		end,
		textures = {
			"ChapterSettlement",
			"LevelResultLayer"
		}
	},
	ActivityMainCompareLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityMainCompareLayer")

			return (ActivityMainCompareLayer:create(...))
		end,
		textures = {}
	},
	SchoolArchivesLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		statusbarbg = "schoolstatusbar",
		loadingFinish = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.SchoolArchivesLayer")

			return (SchoolArchivesLayer:create(...))
		end,
		textures = {
			"PhotoFile",
			"room_widget"
		}
	},
	ShowGirlSwitchLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ShowGirlSwitchLayer")

			return (ShowGirlSwitchLayer:create(...))
		end
	},
	ActivitySignLayer_4_1 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = LIULI_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivitySignLayer_4_1")

			return (ActivitySignLayer_4_1:create(...))
		end,
		textures = {
			"Activity_LiuLiActivity",
			"Activity_DaKaActivity"
		}
	},
	ActivityLayer_bianhua_Main = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		uiLayerName = "mainScene",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = BIANHUA_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityLayer_bianhua_Main")

			return (ActivityLayer_bianhua_Main:create(...))
		end,
		textures = {
			"Activity_bianhua_Main"
		}
	},
	ActivityLayer_bianhua_Chapter = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch9/bianhua_chapter_bg.jpg",
		uiLayerName = "Panel_1",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = BIANHUA_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityLayer_bianhua_Chapter")
			print("|||||||||||||||||", os.clock() - os.clock())

			return (ActivityLayer_bianhua_Chapter:create(...))
		end,
		textures = {
			"Activity_bianhua_Chapter"
		}
	},
	ActivityLayer_bianhua_Achieve = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity_achievement.jpg",
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = BIANHUA_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityLayer_bianhua_Achieve")

			return (ActivityLayer_bianhua_Achieve:create(...))
		end,
		textures = {
			"Activity_bianhua_Achievement"
		}
	},
	ActivityLayer_bianhua_Collection = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity_achievement.jpg",
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = BIANHUA_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityLayer_bianhua_Collection")

			return (ActivityLayer_bianhua_Collection:create(...))
		end,
		textures = {
			"Activity_bianhua_Collection"
		}
	},
	ScoreArenaLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = AREANBG,
		createLayer = function(...)
			require("view.Layer.ScoreArenaLayer")

			return (ScoreArenaLayer:create(...))
		end,
		textures = {
			"arenascenenew"
		}
	},
	ScoreArenaRankingPanelLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ScoreArenaRankingPanelLayer")

			return (ScoreArenaRankingPanelLayer:create(...))
		end,
		textures = {
			"arenascenenew"
		}
	},
	ActivityExploreLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = true,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.Activity.ActivityExploreLayer")

			return (ActivityExploreLayer:create(...))
		end,
		textures = {
			"explore"
		}
	},
	AdventureNewItemLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.AdventureNewItemLayer")

			return (AdventureNewItemLayer:create(...))
		end,
		textures = {
			"adventurenewlayer"
		}
	},
	AdventureNewTowerLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.AdventureNewTowerLayer")

			return (AdventureNewTowerLayer:create(...))
		end,
		textures = {
			"adventurenewtowerlayer"
		}
	},
	ActivityJumptowerBaseLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityJumptowerBaseLayer")

			return (ActivityJumptowerBaseLayer:create(...))
		end,
		textures = {
			"adventurenewtowerlayer"
		}
	},
	LabMakeNewLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.LabMakeNewLayer")

			return (LabMakeNewLayer:create(...))
		end,
		textures = {
			"lab_main_screen",
			"room_widget"
		}
	},
	ActivityNinifaLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = NINIFA_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityNinifa.ActivityNinifaLayer")

			return (ActivityNinifaLayer:create(...))
		end,
		textures = {
			"ActivityNinifaLayer"
		}
	},
	ActivityNinifaExploreLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = NINIFA_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityNinifa.ActivityNinifaExploreLayer")

			return (ActivityNinifaExploreLayer:create(...))
		end,
		textures = {
			"ActivityNinifaExploreLayer"
		}
	},
	ActivityNinifaCompositeLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = NINIFA_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityNinifa.ActivityNinifaCompositeLayer")

			return (ActivityNinifaCompositeLayer:create(...))
		end,
		textures = {
			"ActivityNinifaCompositeLayer"
		}
	},
	ActivityNinifaExchangeLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = NINIFA_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityNinifa.ActivityNinifaExchangeLayer")

			return (ActivityNinifaExchangeLayer:create(...))
		end,
		textures = {
			"ActivityNinifaExchangeLayer"
		}
	},
	ActivityPreheatPoint = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityTwoEggPreheat.ActivityPreheatPoint")

			return (ActivityPreheatPoint:create(...))
		end,
		textures = {
			"Activity_PointActivityLayer"
		}
	},
	ActivityPreheatTask = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityTwoEggPreheat.ActivityPreheatTask")

			return (ActivityPreheatTask:create(...))
		end,
		textures = {
			"Activity_PointActivityLayer"
		}
	},
	DoubleHoliday_WoldCityLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch12/sd_bg.jpg",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = CHTISMAS_1,
		createLayer = function(...)
			require("view.Layer.DoubleHoliday_WoldCityLayer")

			return (DoubleHoliday_WoldCityLayer:create(...))
		end,
		textures = {
			"Activity_doubleholiday"
		}
	},
	DoubleHoliday_AchievementLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch12/chengjiubg.jpg",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = CHTISMAS_1,
		createLayer = function(...)
			require("view.Layer.DoubleHoliday_AchievementLayer")

			return (DoubleHoliday_AchievementLayer:create(...))
		end,
		textures = {
			"Activity_doubleholiday",
			"PopTechnologyTree"
		}
	},
	DoubleHoliday_CityNodeLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = CHTISMAS_1,
		createLayer = function(...)
			require("view.Layer.DoubleHoliday_CityNodeLayer")

			return (DoubleHoliday_CityNodeLayer:create(...))
		end,
		textures = {
			"Activity_doubleholiday",
			"doubleholiday_city",
			"PopTechnologyTree"
		}
	},
	DoubleHoliday_WoldCityLayer_2 = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch12/sd_bg.jpg",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = CHTISMAS_1,
		createLayer = function(...)
			require("view.Layer.DoubleHoliday_WoldCityLayer_2")

			return (DoubleHoliday_WoldCityLayer_2:create(...))
		end,
		textures = {
			"Activity_doubleholiday",
			"doubleholiday_city",
			"PopTechnologyTree"
		}
	},
	BattlePassLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.BattlePassLayer")

			return (BattlePassLayer:create(...))
		end,
		textures = {
			"BattlePassLayer"
		}
	},
	ActivityLayer_SpringFestival = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch100/bg_enter.png",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = SPRING_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivitySpringFestival.ActivityLayer_SpringFestival")

			return (ActivityLayer_SpringFestival:create(...))
		end,
		textures = {
			"Activity_Spring_Festival_Activity_MainEnter"
		}
	},
	StarRankListLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		showTopcostLayer = true,
		zOrder = 0,
		aniUIElement = {
			framepanel = {
				initPos = {
					x = -640,
					y = 94
				},
				finalPos = {
					x = 23,
					y = 94
				}
			},
			button_return = {
				initPos = {
					x = -640,
					y = 118
				},
				finalPos = {
					x = 50,
					y = 118
				}
			}
		},
		listButtonRelationUIName = {
			"panel_top"
		},
		bgm = MAIN_BGM,
		bg = UIBG,
		createLayer = function()
			require("view.Layer.StarRankListLayer")

			return (StarRankListLayer:create(1))
		end,
		textures = {
			"arenascenenew"
		}
	},
	ActivityLayer_Valentine_Day = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = VALENTINEBG,
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityLayer_Valentine_Day")

			return (ActivityLayer_Valentine_Day:create(...))
		end,
		textures = {
			"Activity_Valentine_Day"
		}
	},
	levelAreaMapLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = CHAPTERBG,
		createLayer = function(...)
			require("view.Layer.levelAreaMapLayer")

			return (levelAreaMapLayer:create(...))
		end,
		textures = {
			"LevelMap"
		}
	},
	ChapterAdvertureTower = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/roledatabg.jpg",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ChapterAdvertureTower")

			return (ChapterAdvertureTower:create(...))
		end,
		textures = {
			"ChapterAdvertureTower"
		}
	},
	ActivityQuestionPtLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch18/bg_main.jpg",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityPtQuestion.ActivityQuestionPtLayer")

			return (ActivityQuestionPtLayer:create(...))
		end,
		textures = {
			"ActivityQuestionPtLayer"
		}
	},
	ActivityQuestionPtTaskLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch18/bg_main.jpg",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityPtQuestion.ActivityQuestionPtTaskLayer")

			return (ActivityQuestionPtTaskLayer:create(...))
		end,
		textures = {
			"ActivityQuestionPtLayer",
			"Activity_lamia"
		}
	},
	ActivityMarryMainLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = MARRYBG,
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityMarry.ActivityMarryMainLayer")

			return (ActivityMarryMainLayer:create(...))
		end,
		textures = {
			"Activity_Marry"
		}
	},
	ActivityQuestionPointLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch18/bg_main.jpg",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityPtQuestion.ActivityQuestionPointLayer")

			return (ActivityQuestionPointLayer:create(...))
		end,
		textures = {
			"Activity_PointActivityLayer"
		}
	},
	SubstitutionLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/roledatabg.jpg",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.SubstitutionLayer")

			return (SubstitutionLayer:create(...))
		end,
		textures = {
			"SubstitutionLayer",
			"SubstitutionBossLayer0",
			"SubstitutionBossLayer1",
			"NewSubstitutionLayer"
		}
	},
	SpecialJumpTowerLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/roledatabg.jpg",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.SpecialJumpTowerLayer")

			return (SpecialJumpTowerLayer:create(...))
		end,
		textures = {
			"spicalTower"
		}
	},
	WeekendAdventureLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/roledatabg.jpg",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.WeekendAdventureLayer")

			return (WeekendAdventureLayer:create(...))
		end,
		textures = {
			"weekendadventure"
		}
	},
	AdventureLayer = {
		enterVisibleListButton = true,
		loading = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/roledatabg.jpg",
		showTopcostLayer = true,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ChangeShowLayer")

			return (ChangeShowLayer:create(...))
		end,
		textures = {
			"ChangeShowLayer",
			"TvtLevet"
		}
	},
	CompetitionLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/roledatabg.jpg",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.CompetitionLayer")

			return (CompetitionLayer:create(...))
		end,
		textures = {
			"CompetitionLayer",
			"TvtLevet"
		}
	},
	ActivityStupidLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityStupidLayer")

			return (ActivityStupidLayer:create(...))
		end,
		textures = {
			"ActivityStupidLayer",
			"MarketLayer",
			"TwistEgg"
		}
	},
	ActivityWideWakeLayer = {
		enterVisibleListButton = false,
		loading = true,
		loadingFinish = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = SUBSITUTIONBG,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityWideWake.ActivityWideWakeLayer")

			return (ActivityWideWakeLayer:create(...))
		end,
		textures = {
			"ActivityWideWakeLayer",
			"MarketLayer",
			"TwistEgg"
		}
	},
	ExplorePlotLayer = {
		enterVisibleListButton = false,
		loading = false,
		statusbarbg = "taskstatusbar",
		showSmallFightLayer = false,
		bg = "mainScenebg/roledatabg.jpg",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ExplorePlotLayer")

			return (ExplorePlotLayer:create(...))
		end,
		textures = {
			"explore_entrance"
		}
	},
	SubstitutionBossLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/roledatabg.jpg",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.SubstitutionBossLayer")

			return (SubstitutionBossLayer:create(...))
		end,
		textures = {
			"SubstitutionBossLayer0",
			"SubstitutionBossLayer1"
		}
	},
	ActivityNoviceTaskLayer = {
		enterVisibleListButton = false,
		loading = false,
		statusbarbg = "taskstatusbar",
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = TASK_BG,
		createLayer = function(...)
			require("view.Layer.ActivityNoviceTaskLayer")

			return (ActivityNoviceTaskLayer:create(...))
		end,
		textures = {
			"ActivityNoviceTaskLayer",
			"TaskLayer"
		}
	},
	ActivityNoviceThirtyTaskLayer = {
		enterVisibleListButton = false,
		loading = false,
		statusbarbg = "taskstatusbar",
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = TASK_BG,
		createLayer = function(...)
			require("view.Layer.ActivityNoviceThirtyTaskLayer")

			return (ActivityNoviceThirtyTaskLayer:create(...))
		end,
		textures = {
			"ActivityNoviceThirtyTaskLayer",
			"TaskLayer"
		}
	},
	ManageMoneyLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		statusbarbg = "taskstatusbar",
		showSmallFightLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ManageMoneyLayer")

			return (ManageMoneyLayer:create(...))
		end,
		textures = {
			"ManageMoneyLayer"
		}
	},
	NewbeeTwistReturnLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		statusbarbg = "taskstatusbar",
		showSmallFightLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.NewbeeTwistReturnLayer")

			return (NewbeeTwistReturnLayer:create(...))
		end,
		textures = {
			"NewbeeTwistReturnLayer"
		}
	},
	BianhuaStoryLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch9/bianhua_chapter_bg.jpg",
		uiLayerName = "Panel_1",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = BIANHUA_BGM,
		createLayer = function(...)
			local var_103_0 = os.clock()

			require("view.Layer.BianhuaStoryLayer")

			return (BianhuaStoryLayer:create(...))
		end,
		textures = {
			"Activity_bianhua_Chapter"
		}
	},
	StoryModesLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/roledatabg.jpg",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.StoryModesLayer")

			return (StoryModesLayer:create(...))
		end,
		textures = {
			"StoryModesLayer"
		}
	},
	AchievementListLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = TASK_BG,
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.AchievementListLayer")

			return (AchievementListLayer:create(...))
		end,
		textures = {
			"TaskLayer"
		}
	},
	MedalSelectLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = TASK_BG,
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.MedalSelectLayer")

			return (MedalSelectLayer:create(...))
		end,
		textures = {
			"medalSelect",
			"itempanel"
		}
	},
	StarRankListLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		showTopcostLayer = true,
		zOrder = 0,
		aniUIElement = {
			framepanel = {
				initPos = {
					x = -640,
					y = 94
				},
				finalPos = {
					x = 23,
					y = 94
				}
			},
			button_return = {
				initPos = {
					x = -640,
					y = 118
				},
				finalPos = {
					x = 50,
					y = 118
				}
			}
		},
		listButtonRelationUIName = {
			"panel_top"
		},
		bgm = MAIN_BGM,
		bg = UIBG,
		createLayer = function()
			require("view.Layer.StarRankListLayer")

			return (StarRankListLayer:create(1))
		end,
		textures = {
			"arenascenenew"
		}
	},
	ActivityBattlePassBaseLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/skill_bg.jpg",
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityBattlePassBaseLayer")

			return (ActivityBattlePassBaseLayer:create(...))
		end,
		textures = {
			"ActivityBianhuaBP",
			"MarketLayer"
		}
	},
	ActivityBianhuaBPLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/skill_bg.jpg",
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = BIANHUA_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityBianhuaBPLayer")

			return (ActivityBianhuaBPLayer:create(...))
		end,
		textures = {
			"ActivityBianhuaBP",
			"MarketLayer"
		}
	},
	ActivitySecondMarryBPLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/marry_bp_bg_second.jpg",
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = SAVE_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityBattlePassBaseLayer")

			return (ActivitySecondMarryBPLayer:create(...))
		end,
		textures = {
			"ActivityBianhuaBP",
			"MarketLayer",
			"Activity_Spring_Festival_Share"
		}
	},
	FriendListLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/roledatabg.jpg",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.FriendListLayer")

			return (FriendListLayer:create(...))
		end,
		textures = {
			"friendsystem",
			"arenascenenew"
		}
	},
	ActivityRoutineBPLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = ACTIVITYBPBG,
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityBattlePassBaseLayer")

			return (ActivityRoutineBPLayer:create(...))
		end,
		textures = {
			"ActivityBianhuaBP",
			"MarketLayer",
			"ActivityRoutineBP"
		}
	},
	ActivityFlopDuanWuLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityFlopBaseLayer")

			return (ActivityFlopDuanWuLayer:create(...))
		end,
		textures = {
			"ActivityFlopDuanwu",
			"MarketLayer"
		}
	},
	ActivitySaveBPLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/save_bg.jpg",
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = SAVE_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityBattlePassBaseLayer")

			return (ActivitySaveBPLayer:create(...))
		end,
		textures = {
			"ActivityBianhuaBP",
			"ActivitySaveBPLayer",
			"MarketLayer"
		}
	},
	ActivityMarryMainLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = MARRYBG,
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityMarry.ActivityMarryMainLayer")

			return (ActivityMarryMainLayer:create(...))
		end,
		textures = {
			"Activity_Marry"
		}
	},
	AvalonStoryLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch115/bg.png",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = AVALON_BGM,
		createLayer = function(...)
			require("view.Layer.AvalonStoryLayer")

			return (AvalonStoryLayer:create(...))
		end,
		textures = {
			"Activity_avalon"
		}
	},
	ActivityLevelLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = CHAPTERBG,
		createLayer = function(...)
			require("view.Layer.ActivityLevelLayer")

			return (ActivityLevelLayer:create(...))
		end,
		textures = {
			"LevelMap"
		}
	},
	ActivityAvalonBPLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = ACTIVITYBPBG,
		bgm = AVALON_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityBattlePassBaseLayer")

			return (ActivityAvalonBPLayer:create(...))
		end,
		textures = {
			"ActivityBianhuaBP",
			"MarketLayer",
			"ActivityAvalonBP",
			"ActivityXinxiYaBPLayer",
			"Activity_bp_136"
		}
	},
	AdventureRankingPanel = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = AVALON_BGM,
		createLayer = function(...)
			require("view.Layer.AdventureRankingPanel")

			return (AdventureRankingPanel:create(...))
		end,
		textures = {
			"adventure_score"
		}
	},
	AdventurerVisualLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch115/bg_adver.png",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = AVALON_BGM,
		createLayer = function(...)
			require("view.Layer.AdventurerVisualLayer")

			return (AdventurerVisualLayer:create(...))
		end,
		textures = {
			"adventure_score"
		}
	},
	ThreeVsThreeLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {
			"panel_top"
		},
		bgm = TFT_LAYER_BGM,
		bg = AREANBG,
		createLayer = function(...)
			require("view.Layer.ThreeVsThreeLayer")

			return (ThreeVsThreeLayer:create(...))
		end,
		textures = {
			"ThreeVsThreeLayer",
			"TvtLevet",
			"arenascenenew",
			"Array"
		}
	},
	TVTTaskLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {
			"panel_top"
		},
		bgm = TFT_LAYER_BGM,
		bg = TASK_BG,
		createLayer = function(...)
			require("view.Layer.TVTTaskLayer")

			return (TVTTaskLayer:create(...))
		end,
		textures = {
			"Activity_PointActivityLayer"
		}
	},
	ExpeditionTaskLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {
			"panel_top"
		},
		bgm = MAIN_BGM,
		bg = TASK_BG,
		createLayer = function(...)
			require("view.Layer.ExpeditionTaskLayer")

			return (ExpeditionTaskLayer:create(...))
		end,
		textures = {
			"Activity_PointActivityLayer"
		}
	},
	ActivityWordCollectionBaseLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityWordCollectionBaseLayer")

			return (ActivityWordCollectionBaseLayer:create(...))
		end,
		checktextures = function(self)
			return self.activityId and {
				"Activity_Collect_" .. self.activityId
			}
		end
	},
	ActivityFlopSummerLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityFlopBaseLayer")

			return (ActivityFlopSummerLayer:create(...))
		end,
		textures = {
			"ActivityPreSummer",
			"MarketLayer"
		}
	},
	ActivityPreSummerPTLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/pre_summer_pt_bg.png",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityPreSummer.ActivityPreSummerPTLayer")

			return (ActivityPreSummerPTLayer:create(...))
		end,
		textures = {
			"ActivityPreSummerPTLayer"
		}
	},
	SchoolSwimLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = SWIM_BGM,
		createLayer = function(...)
			require("view.Layer.SchoolSwimLayer")

			return (SchoolSwimLayer:create(...))
		end,
		textures = {
			"room_widget",
			"SchoolSwimLayer"
		}
	},
	SwimMainLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = {
			SWIM_BGM,
			3
		},
		bg = SWIM_BG,
		createLayer = function(...)
			require("view.Layer.SwimMainLayer")

			return (SwimMainLayer:create(...))
		end,
		textures = {
			"SwimMainLayer"
		}
	},
	ActivityLevelLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = CHAPTERBG,
		createLayer = function(...)
			require("view.Layer.ActivityLevelLayer")

			return (ActivityLevelLayer:create(...))
		end,
		textures = {
			"LevelMap"
		}
	},
	ActivityLevelLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = CHAPTERBG,
		createLayer = function(...)
			require("view.Layer.ActivityLevelLayer")

			return (ActivityLevelLayer:create(...))
		end,
		textures = {
			"LevelMap"
		}
	},
	AdventurerVisualLayerSummer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch128/bg_adver.png",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = SUMMER_MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.AdventurerVisualLayerSummer")

			return (AdventurerVisualLayerSummer:create(...))
		end,
		textures = {
			"adventure_score_summer"
		}
	},
	ActivityRouletteBaseLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.Activity.ActivityRouletteBaseLayer")

			return (ActivityRouletteBaseLayer:create(...))
		end,
		checktextures = function(self)
			if not self or not self.activityId then
				return {}
			end

			return self.activityId and {
				"ActivityRoulette_" .. self.activityId
			} or {}
		end
	},
	ActivityArtBaseLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/qixi_bp_bg.jpg",
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.Activity.ActivityArtBaseLayer")

			return (ActivityArtBaseLayer:create(...))
		end,
		checktextures = function(self)
			return self.activityid and {
				"ActivityArt_" .. self.activityid
			} or {}
		end
	},
	ActivityPreSummerPTLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/pre_summer_pt_bg.png",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityPreSummer.ActivityPreSummerPTLayer")

			return (ActivityPreSummerPTLayer:create(...))
		end,
		textures = {
			"ActivityPreSummerPTLayer"
		}
	},
	ActivityAnniversaryExploreLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch132/explore_bg.png",
		uiLayerName = "ActivityAnniversaryExploreLayer",
		showTopcostLayer = false,
		zOrder = 0,
		bgm = ANN_BGM,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.Activity.ActivityOneAnniversary.ActivityAnniversaryExploreLayer")

			return (ActivityAnniversaryExploreLayer:create(...))
		end,
		textures = {
			"ActivityAnniversaryExploreLayer"
		}
	},
	ActivityNoviceTaskLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = TASK_BG,
		createLayer = function(...)
			require("view.Layer.ActivityNoviceTaskLayer")

			return (ActivityNoviceTaskLayer:create(...))
		end,
		textures = {
			"ActivityNoviceTaskLayer",
			"TaskLayer"
		}
	},
	ActivityXinxiYaBPLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/xinxiya_bp_bg.jpg",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityBattlePassBaseLayer")

			return (ActivityXinxiYaBPLayer:create(...))
		end,
		textures = {
			"ActivityXinxiYaBPLayer",
			"Activity_bp_219",
			"Activity_bp_136"
		}
	},
	AdventurerInfiniteLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/randomade_bg.png",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = ANN_BGM,
		createLayer = function(...)
			require("view.Layer.AdventurerInfiniteLayer")

			return (AdventurerInfiniteLayer:create(...))
		end,
		textures = {
			"adventure_infinite"
		}
	},
	AdventureInfiniteRankLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = ANN_BGM,
		createLayer = function(...)
			require("view.Layer.AdventureInfiniteRankLayer")

			return (AdventureInfiniteRankLayer:create(...))
		end,
		textures = {
			"adventure_infinite",
			"arenascenenew"
		}
	},
	ActivityBattlePassLayer_140 = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/marry4_bp.jpg",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MARRYBG,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityBattlePassBaseLayer")

			return (ActivityBattlePassLayer_140:create(...))
		end,
		textures = {
			"ActivityBattlePassLayer_140",
			"ActivityBianhuaBP"
		}
	},
	joinCommunityLayer = {
		enterVisibleListButton = true,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = CHAPTERBG,
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.joinCommunityLayer")

			return (joinCommunityLayer:create(...))
		end,
		textures = {
			"community_system_communityMainLayer0",
			"community_system_communityMainLayer1",
			"community_system_joinCommunityLayer0"
		}
	},
	CommunityMainLayer = {
		enterVisibleListButton = true,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/commnity_mainbg.png",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.CommunityMainLayer")

			return (CommunityMainLayer:create(...))
		end,
		textures = {
			"community_system_communityMainLayer0",
			"community_system_communityMainLayer1",
			"community_system_joinCommunityLayer0",
			"chat_system_layer"
		}
	},
	CommunityMemberLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = CHAPTERBG,
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.CommunityMemberLayer")

			return (CommunityMemberLayer:create(...))
		end,
		textures = {
			"community_system_communityMainLayer0",
			"community_system_communityMainLayer1",
			"community_system_joinCommunityLayer0"
		}
	},
	CommunityTaskShowLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = CHAPTERBG,
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.CommunityTaskShowLayer")

			return (CommunityTaskShowLayer:create(...))
		end,
		textures = {
			"community_system_communityMainLayer0",
			"community_system_communityMainLayer1",
			"community_system_joinCommunityLayer0"
		}
	},
	AdventurerRandomLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/randomade_bg.png",
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.AdventurerRandomLayer")

			return (AdventurerRandomLayer:create(...))
		end,
		textures = {
			"adventure_random"
		}
	},
	ActivityBossFightBaseLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityBossFightBaseLayer")

			return (ActivityBossFightBaseLayer:create(...))
		end,
		checktextures = function(self)
			if self and self.activityId then
				return {
					"ActivityBossFight_" .. self.activityId
				}
			end
		end
	},
	ActivityNewBossFightBaseLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityNewBossFightBaseLayer")

			return (ActivityNewBossFightBaseLayer:create(...))
		end,
		checktextures = function(self)
			if self and self.activityId then
				return {
					"ActivityBossFight_" .. self.activityId
				}
			end
		end
	},
	ActivityBachelorBaseLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch409/bg.jpg",
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityBachelorBaseLayer")

			return (ActivityBachelorBaseLayer:create(...))
		end,
		textures = {
			"ActivityBachelor_550",
			"ActivityBachelor_2020"
		},
		checktextures = function(self)
			if self and self.activityId then
				return {
					"ActivityBachelor_550",
					"ActivityBachelor_" .. self.activityId
				}
			end
		end
	},
	AdventureRandomTowerLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.AdventureRandomTowerLayer")

			return (AdventureRandomTowerLayer:create(...))
		end,
		textures = {
			"adventurenewtowerlayer"
		}
	},
	ActivityLevelBaseLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = CHAPTERBG,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityLevelBaseLayer")

			return (ActivityLevelBaseLayer:create(...))
		end,
		textures = {},
		checktextures = function(self)
			local var_157_0 = {}

			if self and self.activityid then
				table.insert(var_157_0, "Activities_activity" .. self.activityid .. "_levelmap")
			end

			return var_157_0
		end
	},
	CommunityWishMianLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.CommunityWishMianLayer")

			return (CommunityWishMianLayer:create(...))
		end,
		textures = {
			"community_system_communityMainLayer0",
			"community_system_communityMainLayer1",
			"community_system_joinCommunityLayer0"
		}
	},
	TowerDefenceLevelLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = CHAPTERBG,
		bgm = FIGHT_BGM,
		createLayer = function(...)
			require("view.Layer.TowerDefenceLevelLayer")

			return (TowerDefenceLevelLayer:create(...))
		end,
		textures = {
			"TowerDefenceLevelLayer",
			"LevelMap"
		}
	},
	LimitTowerDefenceLevelLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = CHAPTERBG,
		bgm = FIGHT_BGM,
		createLayer = function(...)
			require("view.Layer.LimitTowerDefenceLevelLayer")

			return (LimitTowerDefenceLevelLayer:create(...))
		end,
		textures = {
			"LimitTowerDefenceLevelLayer",
			"TowerDefenceLevelLayer",
			"LevelMap",
			"Array"
		}
	},
	BirthdayPartyLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = BIRTHDAYPARTYBG,
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.BirthdayPartyLayer")

			return (BirthdayPartyLayer:create(...))
		end,
		textures = {
			"BirthdayPartyLayer"
		}
	},
	CostumeRoomLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.CostumeRoom.CostumeRoomLayer")

			return (CostumeRoomLayer:create(...))
		end,
		textures = {
			"CostumeRoomLayer"
		}
	},
	CostumeRoomShowLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.CostumeRoom.CostumeRoomShowLayer")

			return (CostumeRoomShowLayer:create(...))
		end,
		textures = {
			"CostumeRoomShowLayer"
		}
	},
	ActivityLevel_186 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch173/level_bg.png",
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.activity186.ActivityLevel_186")

			return (ActivityLevel_173:create(...))
		end,
		textures = {
			"ActivityLevel_186",
			"LevelMap"
		}
	},
	ExpeditionLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/expedition_bg.png",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ExpeditionLayer")

			return (ExpeditionLayer:create(...))
		end,
		textures = {
			"ExpeditionLayer",
			"ArenaLayer"
		}
	},
	MonopolyLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/monopoly_bg.png",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.MonopolyLayer")

			return (MonopolyLayer:create(...))
		end,
		textures = {
			"MonopolyLayer"
		}
	},
	ServantRankLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			return (require("view.Layer.ServantRankLayer"):create(...))
		end,
		textures = {
			"servantrank"
		}
	},
	CourseCultivateLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			return (require("view.Layer.CourseCultivateLayer"):create(...))
		end,
		textures = {
			"gamecourse0",
			"gamecourse1"
		}
	},
	WeeklyTowerEntranceLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/roledatabg.jpg",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			return (require("view.Layer.WeeklyTowerEntranceLayer"):create(...))
		end,
		textures = {
			"weeklytower"
		}
	},
	WeeklyTowerLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/roledatabg.jpg",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			return (require("view.Layer.WeeklyTowerLayer"):create(...))
		end,
		textures = {
			"adventurenewtowerlayer",
			"weeklytower"
		}
	},
	ActivityExploreLayer_210 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch210/exp_bg.jpg",
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.activity210.ActivityExploreLayer_210")

			return (ActivityExploreLayer_210:create(...))
		end,
		textures = {
			"ActivityExplore_210"
		}
	},
	ActivityExploreLayer_418 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch418/ActivityFightCollectionLayer_418.png",
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.activity418.ActivityExploreLayer_418")

			return (ActivityExploreLayer_418:create(...))
		end,
		textures = {
			"ActivityExplore_418"
		}
	},
	SupermarketPrivilegeLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			return (require("view.Layer.SupermarketLayer.SupermarketPrivilegeLayer"):create(...))
		end,
		textures = {
			"SupermarketPrivilegeLayer"
		}
	},
	SupermarketPrivilegeRechargeLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			return (require("view.Layer.SupermarketLayer.SupermarketPrivilegeRechargeLayer"):create(...))
		end,
		textures = {
			"SupermarketPrivilegeRechargeLayer"
		}
	},
	AfkLevelLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/Activity_logisticsupport_BPBasic.png",
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.AfkLevelLayer")

			return (AfkLevelLayer:create(...))
		end,
		textures = {
			"AfkLevelLayer"
		}
	},
	ActivityPlaneWarLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bgm = "sound/ninifa",
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityPlaneWarLayer")

			return (ActivityPlaneWarLayer:create(...))
		end,
		textures = {
			"ActivityPlaneWarLayer"
		}
	},
	SheepASheepLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bgm = "sound/ninifa",
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.SheepASheepLayer")

			return (SheepASheepLayer:create(...))
		end,
		textures = {
			"SheepASheepLayer"
		}
	},
	ActivityHexagonDispelLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		zOrder = 0,
		bgm = MAIN_BGM,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityHexagonDispelLayer")

			return (ActivityHexagonDispelLayer:create(...))
		end,
		checktextures = function(self)
			if self.activityId then
				return {
					"ActivityHexagonDispelLayer_" .. self.activityId
				}
			end
		end
	},
	SummerTowerSwapLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bgm = "sound/ninifa",
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.SwapTowerLayer.SummerTowerSwapLayer")

			return (SummerTowerSwapLayer:create(...))
		end,
		textures = {
			"SummerTowerSwapLayer",
			"ActivityPlaneWarLayer"
		}
	},
	SummerFarmLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bgm = "sound/mainbgm",
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.SummerFarmLayer")

			return (SummerFarmLayer:create(...))
		end,
		textures = {
			"SummerFarmLayer"
		}
	},
	ActivityGroupFightLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bgm = "sound/ninifa",
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityGroupFightLayer")

			return (ActivityGroupFightLayer:create(...))
		end,
		textures = {
			"adventurenewtowerlayer"
		}
	},
	CommonFlopLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		zOrder = 0,
		bgm = MAIN_BGM,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.CommonFlopLayer")

			return (CommonFlopLayer:create(...))
		end,
		textures = {
			"CommonFlopLayer"
		}
	},
	CommonRouletteLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		zOrder = 0,
		bgm = MAIN_BGM,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.CommonRouletteLayer")

			return (CommonRouletteLayer:create(...))
		end,
		textures = {
			"ActivityRoulette_731"
		}
	},
	AirPlaneLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		zOrder = 0,
		bgm = MAIN_BGM,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.AirPlaneLayer")

			return (AirPlaneLayer:create(...))
		end,
		textures = {
			"AirPlaneLayer",
			"CommonTaskAirPlane"
		}
	},
	flyChessMainLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		zOrder = 0,
		bgm = MAIN_BGM,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.flyChess.flyChessMainLayer")

			return (flyChessMainLayer:create(...))
		end,
		checktextures = function(self)
			if self.activityId then
				return {
					"activity_flyChess_" .. self.activityId
				}
			end
		end
	},
	OldSubstitutionLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/roledatabg.jpg",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.OldSubstitutionLayer")

			return (OldSubstitutionLayer:create(...))
		end,
		textures = {
			"OldSubstitutionLayer"
		}
	},
	ActivityBakeryLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/roledatabg.jpg",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityBakery.ActivityBakeryLayer")

			return (ActivityBakeryLayer:create(...))
		end,
		textures = {
			"ActivityBakeryLayer"
		}
	},
	ActivityBakeryDeBugLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/roledatabg.jpg",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityBakery.ActivityBakeryDeBugLayer")

			return (ActivityBakeryDeBugLayer:create(...))
		end
	},
	ActivityWorldBossBaseLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityWorldBossBaseLayer")

			return (ActivityWorldBossBaseLayer:create(...))
		end,
		checktextures = function(self)
			if self and self.activityId then
				return {
					"ActivityBossFight_" .. self.activityId
				}
			end
		end
	},
	ActivityBestComboLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityBestComboLayer")

			return (ActivityBestComboLayer:create(...))
		end,
		checktextures = function(self)
			if self and self.activityId then
				return {
					"Activity_BestCombo_" .. self.activityId
				}
			end
		end
	},
	ActivityAlchemyLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityAlchemyLayer")

			return (ActivityAlchemyLayer:create(...))
		end,
		checktextures = function(self)
			if self and self.activityId then
				return {
					"Activity_Alchemy_" .. self.activityId
				}
			end
		end
	},
	ActivityHitMouseLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityHitMouseLayer")

			return (ActivityHitMouseLayer:create(...))
		end,
		checktextures = function(self)
			if self and self.activityId then
				return {
					"Activity_HitMouse_" .. self.activityId
				}
			end
		end
	},
	ActivityMusicalNotesLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bgm = "sound/anniversary2025",
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityMusicalNotes.ActivityMusicalNotesLayer")

			return (ActivityMusicalNotesLayer:create(...))
		end,
		checktextures = function(self)
			if self and self.activityId then
				return {
					"ActivityMusicalNotesLayer_" .. self.activityId
				}
			end
		end
	},
	ActivityMusicTouchLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bgm = "sound/anniversary2025",
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityMusicTouch.ActivityMusicTouchLayer")

			return (ActivityMusicTouchLayer:create(...))
		end,
		checktextures = function(self)
			if self and self.activityId then
				return {
					"ActivityMusicTouchLayer_" .. self.activityId
				}
			end
		end
	},
	ActivityCalculateLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bgm = "sound/anniversary2025",
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityCalculateLayer")

			return (ActivityCalculateLayer:create(...))
		end,
		checktextures = function(self)
			if self and self.activityId then
				return {
					"ActivityCalculateLayer_" .. self.activityId
				}
			end
		end
	},
	ActivityGiftFallLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bgm = "sound/anniversary2025",
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityGiftFallLayer")

			return (ActivityGiftFallLayer:create(...))
		end,
		checktextures = function(self)
			if self and self.activityId then
				return {
					"ActivityGiftFallLayer_" .. self.activityId
				}
			end
		end
	},
	ActivitySpringFirecrackerLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bgm = "sound/anniversary2025",
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivitySpringFirecrackerLayer")

			return (ActivitySpringFirecrackerLayer:create(...))
		end,
		checktextures = function(self)
			if self and self.activityId then
				return {
					"ActivitySpringFirecracker_" .. self.activityId
				}
			end
		end
	}
}
