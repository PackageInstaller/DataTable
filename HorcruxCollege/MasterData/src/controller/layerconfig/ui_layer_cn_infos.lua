return {
	ActivityExploreDefaultLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityExploreDefaultLayer")

			return ActivityExploreDefaultLayer:create(...)
		end,
		checktextures = function(self)
			return self.activityId and {
				"ActivityExplore_" .. self.activityId
			} or {}
		end
	},
	ActivityPTBaseLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityPTBaseLayer")

			return (ActivityPTBaseLayer:create(...))
		end,
		checktextures = function(self)
			if self.activityid then
				return {
					"Activity_pt_" .. self.activityid
				}
			elseif self.activityId then
				return {
					"Activity_pt_" .. self.activityId
				}
			else
				return {}
			end
		end
	},
	ActivityMainDefaultLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			return require("view.Layer.ActivityNew.BaseLayer.ActivityMainDefaultLayer"):create(...)
		end
	},
	AutoChessBaseLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.AutoChessBaseLayer")

			return (AutoChessBaseLayer:create(...))
		end,
		textures = {
			"TowerDefenceLevelLayer",
			"LevelMap"
		}
	},
	ActivityMainLayer_154 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = SPRING_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity154.ActivityMainLayer_154"):create({
				activityid = 154
			}, ...)
		end
	},
	ActivityMainLayer_230 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = SPRING_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity230.ActivityMainLayer_230"):create({
				activityid = 230
			}, ...)
		end
	},
	ActivityMainLayer_285 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = SPRING_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity285.ActivityMainLayer_285"):create({
				activityid = 285
			}, ...)
		end
	},
	ActivityMainLayer_286 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity286.ActivityMainLayer_286"):create({
				activityid = 286
			}, ...)
		end
	},
	ActivityMainLayer_417 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity417.ActivityMainLayer_417"):create({
				activityid = 417
			}, ...)
		end
	},
	ActivityMainLayer_500 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity500.ActivityMainLayer_500"):create({
				activityid = 500
			}, ...)
		end
	},
	ActivityMainLayer_550 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity550.ActivityMainLayer_550"):create({
				activityid = 550
			}, ...)
		end
	},
	ActivityMainLayer_529 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity529.ActivityMainLayer_529"):create({
				activityid = 529
			}, ...)
		end
	},
	ActivityMainLayer_562 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity562.ActivityMainLayer_562"):create({
				activityid = 562
			}, ...)
		end
	},
	ActivityMainLayer_576 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity576.ActivityMainLayer_576"):create({
				activityid = 576
			}, ...)
		end
	},
	ActivityMainLayer_528 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity528.ActivityMainLayer_528"):create({
				activityid = 528
			}, ...)
		end
	},
	ActivityMainLayer_538 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity538.ActivityMainLayer_538"):create({
				activityid = 538
			}, ...)
		end
	},
	ActivityMainLayer_591 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity591.ActivityMainLayer_591"):create({
				activityid = 591
			}, ...)
		end
	},
	ActivityMainLayer_593 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity593.ActivityMainLayer_593"):create({
				activityid = 593
			}, ...)
		end
	},
	ActivityMainLayer_599 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity599.ActivityMainLayer_599"):create({
				activityid = 599
			}, ...)
		end
	},
	ActivityMainLayer_707 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity707.ActivityMainLayer_707"):create({
				activityid = 707
			}, ...)
		end
	},
	ActivityMainLayer_534 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity534.ActivityMainLayer_534"):create({
				activityid = 534
			}, ...)
		end
	},
	ActivityMainLayer_288 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bgm = "sound/mainbgm",
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity288.ActivityMainLayer_288"):create({
				activityid = 288
			}, ...)
		end
	},
	ActivityMainLayer_329 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bgm = "sound/mainbgm",
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity329.ActivityMainLayer_329"):create({
				activityid = 329
			}, ...)
		end
	},
	ActivityMainLayer_195 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity195.ActivityMainLayer_195"):create({
				activityid = 195
			}, ...)
		end
	},
	ActivityRouletteLayer_163 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityRouletteBaseLayer")

			return (ActivityRouletteLayer_163:create(...))
		end,
		textures = {
			"ActivityRoulette_163"
		}
	},
	ActivityFlopLayer_154 = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopLayer_154:create(...))
		end,
		textures = {
			"Activities_activity154_flop"
		}
	},
	ActivityFlipBaseLayer = {
		enterVisibleListButton = false,
		zOrder = 0,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlipBaseLayer")

			return (ActivityFlipBaseLayer:create(...))
		end,
		checktextures = function(self)
			return self.activityId and {
				"Activities_activity" .. self.activityId .. "_flop"
			} or {}
		end
	},
	ActivityFlopLayer_248 = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopLayer_248:create(...))
		end,
		textures = {
			"Activities_activity248_flop"
		}
	},
	ActivityFlopDefaultLayer = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopDefaultLayer:create(...))
		end,
		checktextures = function(self)
			return self.activityid and {
				"Activities_activity" .. self.activityid .. "_flop"
			} or {}
		end
	},
	BagLayerNew = {
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
			require("view.Layer.BagLayerNew")

			return (BagLayerNew:create(...))
		end,
		textures = {
			"BagLayer",
			"HorcruxLayer",
			"ItemsPanelPartsLayer",
			"HorcruxSelectLayer"
		}
	},
	ActivityMainLayer_155 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity155.ActivityMainLayer_155"):create({
				activityid = 155
			}, ...)
		end
	},
	ActivityMainLayer_156 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = SPRING_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity156.ActivityMainLayer_156"):create({
				activityid = 156
			}, ...)
		end
	},
	SchoolOrderLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = ORDER_BG,
		createLayer = function(...)
			require("view.Layer.SchoolOrderLayer")

			return (SchoolOrderLayer:create())
		end,
		textures = {
			"SchoolOrderLayer"
		}
	},
	LevelMapBoxLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/level_map_box_layer_bg.png",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.LevelMapBoxLayer")

			return LevelMapBoxLayer:create(...)
		end,
		textures = {
			"LevelMapBoxLayer"
		}
	},
	LevelMapSingleLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = CHAPTERBG,
		createLayer = function(...)
			require("view.Layer.LevelMapSingleLayer")

			return (LevelMapSingleLayer:create(...))
		end,
		textures = {
			"LevelMap"
		}
	},
	SpecialOperationLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		bg = CHAPTERBG,
		createLayer = function(...)
			require("view.Layer.SpecialOperationLayer")

			return (SpecialOperationLayer:create(...))
		end,
		textures = {
			"LevelMap"
		}
	},
	ActivityMainLayer_167 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity167.ActivityMainLayer_167"):create({
				activityid = 167
			}, ...)
		end
	},
	ActivityPTLayer_169 = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/pt_169_bg.png",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityPTLayer_169")

			return (ActivityPTLayer_169:create(...))
		end,
		textures = {
			"ActivityPTLayer_169",
			"ActivityBianhuaBP"
		}
	},
	ActivityMainLayer_168 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity168.ActivityMainLayer_168"):create({
				activityid = 168
			}, ...)
		end
	},
	ActivityMainLayer_170 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity170.ActivityMainLayer_170"):create({
				activityid = 170
			}, ...)
		end
	},
	ActivityMainLayer_171 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity171.ActivityMainLayer_171"):create({
				activityid = 171
			}, ...)
		end
	},
	ActivityMainLayer_172 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity172.ActivityMainLayer_172"):create({
				activityid = 172
			}, ...)
		end
	},
	SupermarketLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/supermarket_bg.png",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			return require("view.Layer.SupermarketLayer.SupermarketLayer"):create(...)
		end,
		textures = {
			"SupermarketLayer",
			"recharge",
			"SupermarketPrivilegeLayer",
			"SupermarketPrivilegeRechargeLayer"
		}
	},
	ActivityMainLayer_173 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity173.ActivityMainLayer_173"):create({
				activityid = 173
			}, ...)
		end
	},
	ActivityStoryLayer_173 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch173/Activity_Story_173.jpg",
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.activity173.ActivityStoryLayer_173")

			return (ActivityStoryLayer_173:create(...))
		end,
		textures = {
			"Activity_Story_173"
		}
	},
	ActivityFightCollectionLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFightCollectionLayer")

			return (ActivityFightCollectionLayer:create(...))
		end,
		checktextures = function(self)
			return self.activityId and {
				"ActivityFightCollectionLayer_" .. self.activityId
			} or {}
		end
	},
	ActivityExchangeLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityExchangeLayer")

			return (ActivityExchangeLayer:create(...))
		end,
		checktextures = function(self)
			return self.activityId and {
				"ActivityExchangeLayer_" .. self.activityId
			} or {}
		end
	},
	ActivityLevel_173 = {
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
			require("view.Layer.ActivityNew.activity173.ActivityLevel_173")

			return (ActivityLevel_173:create(...))
		end,
		textures = {
			"ActivityLevel_173"
		}
	},
	ActivityLevel_202 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.activity202.ActivityLevel_202")

			return (ActivityLevel_202:create(...))
		end,
		textures = {
			"ActivityLevel_202"
		}
	},
	SchoolStudyLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/school_study.jpg",
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.SchoolStudyLayer")

			return (SchoolStudyLayer:create(...))
		end,
		textures = {
			"SchoolSturdyLayer"
		}
	},
	ActivityMainLayer_178 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity178.ActivityMainLayer_178"):create({
				activityid = 178
			}, ...)
		end
	},
	ActivityMainLayer_180 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity180.ActivityMainLayer_180"):create({
				activityid = 180
			}, ...)
		end
	},
	ActivityLevel_180 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch180/Activity_Story_180.jpg",
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.activity180.ActivityLevel_180")

			return (ActivityLevel_180:create(...))
		end,
		textures = {
			"ActivityLevel_180"
		}
	},
	ActivityMainLayer_186 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = SUMMER_MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity186.ActivityMainLayer_186"):create({
				activityid = 186
			}, ...)
		end
	},
	ActivityFlopLayer_186 = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopLayer_186:create(...))
		end,
		textures = {
			"Activities_activity186_flop"
		}
	},
	ActivityRouletteLayer_186 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityRouletteBaseLayer")

			return (ActivityRouletteLayer_186:create(...))
		end,
		textures = {
			"ActivityRoulette_186"
		}
	},
	ActivityRouletteLayer_209 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityRouletteBaseLayer")

			return (ActivityRouletteLayer_209:create(...))
		end,
		textures = {
			"ActivityRoulette_209"
		}
	},
	ActivityRouletteLayer_210 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = CHRISTMAS_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityRouletteBaseLayer")

			return (ActivityRouletteLayer_210:create(...))
		end,
		textures = {
			"ActivityRoulette_210"
		}
	},
	ActivityRouletteLayer_223 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityRouletteBaseLayer")

			return (ActivityRouletteLayer_223:create(...))
		end,
		textures = {
			"ActivityRoulette_223"
		}
	},
	ActivityMultiPtLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMultiPtLayer")

			return (ActivityMultiPtLayer:create(...))
		end,
		checktextures = function(self)
			if self.activityid then
				return {
					"Activity_multiPt_" .. self.activityid
				}
			elseif self.activityId then
				return {
					"Activity_multiPt_" .. self.activityId
				}
			else
				return {}
			end
		end
	},
	ActivityExploreLayer_186 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch180/explore_bg.jpg",
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.activity186.ActivityExploreLayer_186")

			return (ActivityExploreLayer_186:create(...))
		end,
		textures = {
			"ActivityExploreLayer_186"
		}
	},
	ActivityExploreLayer_209 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch209/explore_bg.jpg",
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.activity209.ActivityExploreLayer_209")

			return (ActivityExploreLayer_209:create(...))
		end,
		textures = {
			"ActivityAnniversaryExploreLayer"
		}
	},
	ActivityFlopLayer_185 = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = HALLOWEEN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopLayer_185:create(...))
		end,
		textures = {
			"Activities_activity185_flop"
		}
	},
	ActivityMainLayer_182 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity182.ActivityMainLayer_182"):create({
				activityid = 182
			}, ...)
		end
	},
	ActivityLevel_182 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch180/Activity_Story_180.jpg",
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.activity182.ActivityLevel_182")

			return (ActivityLevel_182:create(...))
		end,
		textures = {
			"ActivityLevel_180",
			"ActivityLevel_182"
		}
	},
	NoviceSummaryLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/popnovicepasslevelawardlayer.png",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			return require("view.Layer.NoviceSummaryLayer"):create(...)
		end,
		textures = {
			"NoviceSummaryLayer",
			"MarketLayer"
		},
		checktextures = {
			"NoviceSummaryLayer",
			"ActivityNoviceTaskLayer",
			"ActivityXinxiYaBPLayer",
			"NoviceJumpLayer",
			"PopNovicePasslevelAwardLayer",
			"ActivityBianhuaBP",
			"TaskLayer",
			"Activity_bp_136",
			"ManageMoneyLayer",
			"NewbeeTwistReturnLayer"
		}
	},
	NoviceJumpLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/supermarket_bg.png",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			return require("view.Layer.NoviceJumpLayer"):create(...)
		end,
		textures = {
			"NoviceJumpLayer"
		}
	},
	LamiaStoryLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch104/bg.png",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.LamiaStoryLayer")

			return LamiaStoryLayer:create(...)
		end,
		textures = {
			"Activity_lamia"
		}
	},
	ActivityMainLayer_187 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity187.ActivityMainLayer_187"):create({
				activityid = 187
			}, ...)
		end
	},
	GuidePhoneLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/popnovicepasslevelawardlayer.png",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.GuidePhoneLayer")

			return GuidePhoneLayer:create(...)
		end,
		textures = {
			"GuidePhoneLayer"
		}
	},
	GuidePhoneJumpLayer = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/popnovicepasslevelawardlayer.png",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.GuidePhoneJumpLayer")

			return GuidePhoneJumpLayer:create(...)
		end,
		textures = {
			"GuidePhoneLayer"
		}
	},
	ActivityMainLayer_192 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity192.ActivityMainLayer_192"):create({
				activityid = 192
			}, ...)
		end
	},
	ActivityPTLayer_193 = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/pt_193_bg.png",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.activity193.ActivityPTLayer_193")

			return (ActivityPTLayer_193:create(...))
		end,
		textures = {
			"ActivityPTLayer_193",
			"ActivityBianhuaBP"
		}
	},
	ActivityMainLayer_197 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity197.ActivityMainLayer_197"):create({
				activityid = 197
			}, ...)
		end
	},
	ActivityFlopLayer_197 = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopLayer_197:create(...))
		end,
		textures = {
			"Activities_activity197_flop"
		}
	},
	ActivityPTLayer_197 = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/pt_197_bg.png",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.activity197.ActivityPTLayer_197")

			return (ActivityPTLayer_197:create(...))
		end,
		textures = {
			"ActivityPTLayer_197",
			"ActivityBianhuaBP"
		}
	},
	ActivityPTLayer_214 = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/pt_210_bg.png",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.activity214.ActivityPTLayer_214")

			return (ActivityPTLayer_214:create(...))
		end,
		textures = {
			"ActivityPTLayer_214",
			"ActivityBianhuaBP"
		}
	},
	ActivityFlopLayer_196 = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopLayer_196:create(...))
		end,
		textures = {
			"Activities_activity196_flop"
		}
	},
	ActivityFlopLayer_208 = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopLayer_208:create(...))
		end,
		textures = {
			"Activities_activity208_flop"
		}
	},
	ActivityFlopLayer_210 = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopLayer_210:create(...))
		end,
		textures = {
			"Activities_activity210_flop"
		}
	},
	ActivityFlopLayer_264 = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopLayer_264:create(...))
		end,
		textures = {
			"Activities_activity264_flop"
		}
	},
	ActivityFlopLayer_291 = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopLayer_291:create(...))
		end,
		textures = {
			"Activities_activity291_flop"
		}
	},
	ActivityFlopLayer_304 = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopLayer_304:create(...))
		end,
		textures = {
			"Activities_activity304_flop"
		}
	},
	ActivityFlopLayer_330 = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopLayer_330:create(...))
		end,
		textures = {
			"Activities_activity330_flop"
		}
	},
	ActivityFlopLayer_334 = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopLayer_334:create(...))
		end,
		textures = {
			"Activities_activity334_flop"
		}
	},
	ActivityFlopLayer_436 = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopLayer_436:create(...))
		end,
		textures = {
			"Activities_activity436_flop"
		}
	},
	ActivityFlopLayer_430 = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopLayer_430:create(...))
		end,
		textures = {
			"Activities_activity430_flop"
		}
	},
	ActivityFlopLayer_405 = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopLayer_405:create(...))
		end,
		textures = {
			"Activities_activity405_flop"
		}
	},
	ActivityFlopLayer_418 = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopLayer_418:create(...))
		end,
		textures = {
			"Activities_activity418_flop"
		}
	},
	ActivityFlopLayer_333 = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopLayer_333:create(...))
		end,
		textures = {
			"Activities_activity333_flop"
		}
	},
	ActivityFlopLayer_312 = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopLayer_312:create(...))
		end,
		textures = {
			"Activities_activity312_flop"
		}
	},
	ActivityFlopLayer_433 = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopLayer_433:create(...))
		end,
		textures = {
			"Activities_activity433_flop"
		}
	},
	ActivityFlopLayer_314 = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopLayer_314:create(...))
		end,
		textures = {
			"Activities_activity314_flop"
		}
	},
	ActivityFlopLayer_217 = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopLayer_217:create(...))
		end,
		textures = {
			"Activities_activity217_flop"
		}
	},
	ActivityFlopLayer_227 = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopLayer_227:create(...))
		end,
		textures = {
			"Activities_activity227_flop"
		}
	},
	ActivityFlopLayer_230 = {
		enterVisibleListButton = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopLayer_230:create(...))
		end,
		textures = {
			"Activities_activity230_flop"
		}
	},
	ActivityMainLayer_199 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity199.ActivityMainLayer_199"):create({
				activityid = 199
			}, ...)
		end
	},
	ActivityLevel_199 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch199/level_bg.png",
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.activity199.ActivityLevel_199")

			return (ActivityLevel_199:create(...))
		end,
		textures = {
			"ActivityLevel_199",
			"ActivityLevel_180"
		}
	},
	ActivityMainLayer_203 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity203.ActivityMainLayer_203"):create({
				activityid = 203
			}, ...)
		end
	},
	ActivityMainLayer_202 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity202.ActivityMainLayer_202"):create({
				activityid = 202
			}, ...)
		end
	},
	ActivityDailyLevelLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityDailyLevelLayer")

			return (ActivityDailyLevelLayer:create(...))
		end,
		checktextures = function(self)
			return {
				"ActivityLevel_" .. ((self or nil) and (self.activityid or -1))
			}
		end
	},
	TestFightLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.TestFightLayer")

			return (TestFightLayer:create(...))
		end,
		textures = {
			"TestFightLayer"
		}
	},
	ActivityMainLayer_205 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity205.ActivityMainLayer_205"):create({
				activityid = 205
			}, ...)
		end
	},
	ActivityMainLayer_210 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity210.ActivityMainLayer_210"):create({
				activityid = 210
			}, ...)
		end
	},
	ActivityLevel_205 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch205/level_bg.png",
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.activity205.ActivityLevel_205")

			return (ActivityLevel_205:create(...))
		end,
		textures = {
			"ActivityLevel_205",
			"ActivityLevel_180"
		}
	},
	ActivityDailyLayer_230 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch205/level_bg.png",
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.activity230.ActivityDailyLayer_230")

			return (ActivityDailyLayer_230:create(...))
		end,
		textures = {
			"ActivityDailyLayer_230"
		}
	},
	ActivityDailyLayer_450 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch450/level_bg.png",
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.activity450.ActivityDailyLayer_450")

			return (ActivityDailyLayer_450:create(...))
		end,
		textures = {
			"ActivityDailyLayer_450"
		}
	},
	SkinShowPopLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			return (require("view.Layer.SkinShowPopLayer"):create(...))
		end,
		textures = {
			"SkinShowPopLayer",
			"Dormitory"
		}
	},
	MonopolyNewLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			return (require("view.Layer.Monopoly.MonopolyNewLayer"):create(...))
		end
	},
	UrbanDefenseLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			return (require("view.Layer.UrbanDefenseLayer"):create(...))
		end
	},
	ActivityGarrisonLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			return (require("view.Layer.ActivityGarrison.ActivityGarrisonLayer"):create(...))
		end,
		checktextures = function(self)
			return self.activityId and {
				"ActivityGarrisonLayer_" .. self.activityId
			} or {}
		end
	},
	RogueExploreLayer = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = EXPLORE_BGM,
		bg = UIBG,
		createLayer = function(...)
			require("view.Layer.RogueExploreLayer")

			return (RogueExploreLayer:create(...))
		end,
		textures = {
			"explore"
		}
	},
	ActivityMainLayer_505 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = SPRING_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity505.ActivityMainLayer_505"):create({
				activityid = 505
			}, ...)
		end
	},
	ActivityMainLayer_176 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = SPRING_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity176.ActivityMainLayer_176"):create({
				activityid = 176
			}, ...)
		end
	},
	ActivityMainLayer_737 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = SPRING_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity737.ActivityMainLayer_737"):create({
				activityid = 737
			}, ...)
		end
	},
	NewPlayerActivityLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.NewPlayerActivityLayer")

			return (NewPlayerActivityLayer:create(...))
		end,
		textures = {
			"NewPlayerActivityLayer"
		}
	}
}
