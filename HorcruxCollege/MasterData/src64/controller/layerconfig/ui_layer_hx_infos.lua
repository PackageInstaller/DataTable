return {
	ActivityMainLayer_142 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = HALLOWEEN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity142.ActivityMainLayer_142"):create({
				activityid = 142
			}, ...)
		end
	},
	ActivityGeneralBPLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.Activity.ActivityGeneralBPLayer")

			return (ActivityGeneralBPLayer:create(...))
		end,
		textures = {
			"LevelMap"
		},
		checktextures = function(self)
			return self.activityId and {
				"AutoChessLayer_" .. self.activityId
			} or {}
		end
	},
	ActivityGeneralBPLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.Activity.ActivityGeneralBPLayer")

			return (ActivityGeneralBPLayer:create(...))
		end,
		textures = {
			"MarketLayer"
		},
		checktextures = function(self)
			if self.activityId == 207 then
				return {
					"Activity_vivien_BPBasic"
				}
			elseif self.activityId == 255 then
				return {
					"Activity_bp_136"
				}
			else
				return self.activityId and {
					"Activity_bp_" .. self.activityId
				} or {}
			end
		end
	},
	ActivityWarOrderLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.Activity.ActivityWarOrderLayer")

			return (ActivityWarOrderLayer:create(...))
		end,
		textures = {
			"MarketLayer"
		},
		checktextures = {
			"Activity_logisticsupport_BPBasic",
			"MarketLayer"
		}
	},
	ResidentActicityEntranceLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ResidentActicityEntranceLayer")

			return (ResidentActicityEntranceLayer:create(...))
		end,
		textures = {
			"MarketLayer"
		},
		checktextures = {
			"Activity_logisticsupport_BPBasic",
			"MarketLayer",
			"ActivityRoulette_" .. FLIPANDROULETTE,
			"Activities_activity" .. FLIPANDROULETTE .. "_flop"
		}
	},
	ActivityFlopLayer_142 = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		bgm = HALLOWEEN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseLayer")

			return (ActivityFlopLayer_142:create(...))
		end,
		textures = {
			"Activities_activity142_flop"
		}
	},
	ActivityRouletteLayer_143 = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch132/roulette_bg.jpg",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityRouletteBaseLayer")

			return (ActivityRouletteLayer_143:create(...))
		end,
		textures = {
			"ActivityRoulette_143"
		}
	},
	ActivityBachelor_2020 = {
		enterVisibleListButton = false,
		loading = false,
		loadingFinish = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/activity/branch409/bg.jpg",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityBachelor_2020.ActivityBachelor_2020")

			return (ActivityBachelor_2020:create(...))
		end,
		textures = {
			"ActivityBachelor_2020"
		}
	},
	ActivityTGDPTLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/TGD_pt_bg.png",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityTGDPTLayer")

			return (ActivityTGDPTLayer:create(...))
		end,
		textures = {
			"ActivityTGDPTLayer"
		}
	},
	ActivityNewYearPTLayer = {
		enterVisibleListButton = false,
		loading = false,
		showSmallFightLayer = false,
		bg = "mainScenebg/new_year_pt_bg.png",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityNewYearPTLayer")

			return (ActivityNewYearPTLayer:create(...))
		end,
		textures = {
			"ActivityNewYearPTLayer"
		}
	},
	TowerDefenceSelectLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = TFT_LAYER_BGM,
		createLayer = function(...)
			require("view.Layer.TowerDefenceSelectLayer")

			return (TowerDefenceSelectLayer:create(...))
		end,
		textures = {}
	},
	UrbanDefenseSelectLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = TFT_LAYER_BGM,
		createLayer = function(...)
			require("view.Layer.UrbanDefenseSelectLayer")

			return (UrbanDefenseSelectLayer:create(...))
		end,
		textures = {
			"TowerDefenceListPanel"
		}
	},
	AutoChessSelectLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = TFT_LAYER_BGM,
		createLayer = function(...)
			require("view.Layer.AutoChessSelectLayer")

			return (AutoChessSelectLayer:create(...))
		end,
		textures = {
			"TowerDefenceListPanel"
		}
	},
	ExpeditionSelectLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = TFT_LAYER_BGM,
		createLayer = function(...)
			require("view.Layer.ExpeditionSelectLayer")

			return (ExpeditionSelectLayer:create(...))
		end,
		textures = {}
	},
	SkinTwisteggLayer = {
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
			require("view.Layer.SkinTwisteggLayer")

			return (SkinTwisteggLayer:create(...))
		end
	},
	ActivitySpecialEntranceLayer = {
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
			require("view.Layer.ActivitySpecialEntranceLayer")

			return (ActivitySpecialEntranceLayer:create(...))
		end
	},
	ExploreOfferLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ExploreOfferLayer")

			return (ExploreOfferLayer:create(...))
		end,
		textures = {
			"ExploreOfferLayer"
		}
	},
	ActivityGameBackGuideLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			return (require("view.Layer.Activity.ActivityGameBackGuideLayer"):create(...))
		end,
		textures = {
			"gameback0",
			"gameback1",
			"Activity_return_BPBasic",
			"ReturnBackReward",
			"ActivityNoviceThirtyTaskLayer"
		}
	},
	ReturnBackSevenTaskLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.ReturnBackSevenTaskLayer")

			return (ReturnBackSevenTaskLayer:create(...))
		end,
		textures = {
			"ReturnBackSevenTaskLayer"
		}
	},
	AIchatLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = MAIN_BGM,
		createLayer = function(...)
			require("view.Layer.AIchatLayer")

			return (AIchatLayer:create(...))
		end,
		textures = {
			"aichat_layer"
		}
	}
}
