return {
	ActivityMainLayer_148 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = CHRISTMAS_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity148.ActivityMainLayer_148"):create({
				activityid = 148
			}, ...)
		end
	},
	ActivityFlopLayer_148 = {
		enterVisibleListButton = false,
		showSmallFightLayer = false,
		uiLayerName = "panel_back",
		showTopcostLayer = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bg = UIBG,
		bgm = HALLOWEEN_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityFlopBaseNewLayer")

			return (ActivityFlopLayer_148:create(...))
		end,
		textures = {
			"Activities_activity148_flop"
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
	AdventureRandomTowerLayer = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.AdventureRandomTowerLayer")

			return (AdventureRandomTowerLayer:create(...))
		end,
		textures = {
			"adventurenewtowerlayer"
		}
	},
	ActivityMainLayer_151 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		bgm = CHRISTMAS_BGM,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity151.ActivityMainLayer_151"):create({
				activityid = 151
			}, ...)
		end
	},
	ActivityMainLayer_304 = {
		enterVisibleListButton = false,
		loading = false,
		showTopcostLayer = false,
		showSmallFightLayer = false,
		loadingFinish = false,
		zOrder = 0,
		listButtonRelationUIName = {},
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

			return require("view.Layer.ActivityNew.activity304.ActivityMainLayer_304"):create({
				activityid = 304
			}, ...)
		end
	}
}
