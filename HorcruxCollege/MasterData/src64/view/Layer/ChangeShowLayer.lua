ChangeShowLayer = class("ChangeShowLayer", function()
	return cc.Layer:create()
end)

local var_0_1 = config._DEBUG and 0 or 1
local var_0_2 = 601

require("view.Sprite.BottomBtnList")
require("view.Sprite.TitleSprite")
require("view.Sprite.TvTRankSprite")

local BonusPreview_data = require("data/BonusPreview_data")
local activity_return_manager = require("controller.activity_return_manager")
local scorearena_manager = require("controller.scorearena_manager")
local arena_manager = require("controller.arena_manager")
local arenatft_manager = require("controller.arenatft_manager")
local alert_manager = require("controller.alert_manager")
local array_manager = require("controller.array_manager")
local monster_manager = require("controller.monster_manager")
local time_check_manager = require("controller.time_check_manager")
local levelmode_data = require("data.levelmode_data")
local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local substitution_manager = require("controller.substitution_manager")
local audio_manager = require("controller.audio_manager")
local old_substitution_manager = require("controller.old_substitution_manager")
local adverture_random_manager = require("controller.adverture_random_manager")
local explore_manager = require("controller.explore_manager")
local RichTextPro = require("view.Sprite.RichTextPro")
local activity_conf_data = require("data.activity_conf_data")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local expedition_entrance_data = require("data.expedition_entrance_data")
local Utility = require("common.Utility")
local EventManager = require("common.EventManager")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_28 = {
	{
		{
			isPseudoLevel = false,
			layerName = "AdventureNewItemLayer"
		},
		{
			isPseudoLevel = false,
			layerName = "SpecialJumpTowerLayer"
		},
		{
			isPseudoLevel = false,
			layerName = "WeeklyTowerEntranceLayer"
		},
		{
			isPseudoLevel = true,
			layerName = "ExploreOfferLayer"
		}
	},
	{
		{
			isPseudoLevel = false,
			layerName = "ScoreArenaLayer"
		},
		{
			isPseudoLevel = true,
			layerName = "ArenaLayer"
		},
		{
			isPseudoLevel = true,
			layerName = "ThreeVsThreeLayer"
		}
	},
	{
		{
			isPseudoLevel = false,
			layerName = "ExpeditionLayer"
		},
		{
			isPseudoLevel = true,
			layerName = "SubstitutionBossLayer"
		},
		{
			isPseudoLevel = true,
			layerName = "LimitTowerDefenceLevelLayer"
		},
		{
			isPseudoLevel = true,
			layerName = "TowerDefenceLevelLayer"
		},
		{
			isPseudoLevel = true,
			layerName = "OldSubstitutionLayer"
		}
	},
	{
		{
			isPseudoLevel = false,
			layerName = "BianhuaStoryLayer"
		},
		{
			isPseudoLevel = true,
			layerName = "AvalonStoryLayer"
		},
		{
			isPseudoLevel = true,
			layerName = "LamiaStoryLayer"
		},
		{
			isPseudoLevel = true,
			layerName = "ActivityMainLayer_173"
		}
	}
}
local var_0_29 = {
	AdventureNewItemLayer = "ChangeShowLayer/wz.png",
	ThreeVsThreeLayer = "ChangeShowLayer/btn_3v3.png",
	StoryModesLayer = "ChangeShowLayer/zxjq.png",
	ExpeditionLayer = "ChangeShowLayer/expedition.png",
	ArenaLayer = "ChangeShowLayer/btn_area.png",
	LimitTowerDefenceLevelLayer = "ChangeShowLayer/new_tower_defence.png",
	CompetitionLayer = "ChangeShowLayer/dzyx.png",
	OldSubstitutionLayer = "ChangeShowLayer/jxnlold.png",
	BianhuaStoryLayer = "ChangeShowLayer/bianhua.png",
	SpecialJumpTowerLayer = "ChangeShowLayer/mnzz.png",
	LamiaStoryLayer = "ChangeShowLayer/lamiya.png",
	WeeklyTowerEntranceLayer = "ChangeShowLayer/weekly_entrance.png",
	MonopolyLayer = "ChangeShowLayer/expedition.png",
	["-1"] = "ChangeShowLayer/mxjq.png",
	TowerDefenceLevelLayer = "ChangeShowLayer/tower_defence.png",
	AvalonStoryLayer = "ChangeShowLayer/avalon.png",
	ScoreArenaLayer = "ChangeShowLayer/btn_score.png",
	ActivityMainLayer_173 = "ChangeShowLayer/shexieying.png",
	SubstitutionBossLayer = "ChangeShowLayer/jxyl.png",
	ExploreOfferLayer = "ChangeShowLayer/xsl.png"
}
local var_0_30 = {
	AdventureNewItemLayer = {
		activitid = 128,
		path = "ChangeShowLayer/tips_wz.png",
		pos = cc.p(210, 30)
	}
}
local var_0_31 = {
	BianhuaStoryLayer = UNLOCK_BIANHUA,
	AvalonStoryLayer = UNLOCK_AVALON,
	LamiaStoryLayer = UNLOCK_LAMIA,
	ActivityMainLayer_173 = UNLOCK_SHEXIEYING
}
local var_0_32 = cc.c3b(245, 212, 19)

function ChangeShowLayer:getExitParam()
	return cloneconf(self.initconfig)
end

function ChangeShowLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = ChangeShowLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function ChangeShowLayer:init(arg_4_1)
	if arg_4_1 then
		self.returnbacklayer = arg_4_1.returnbacklayer or "MainLayer"
	end

	self.initconfig = arg_4_1 or {}
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ChangeShowLayer.json" or "ChangeShowLayer.ExportJson")

	self:addChild(self.rootLayer)
	self.rootLayer:setBackGroundColorOpacity(0)

	self.Listview = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_13")

	self.Listview:setContentSize(cc.size(640, 900 + (GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT)))
	self.Listview:setPosition(cc.p(0, 140))
	self.Listview:setBounceEnabled(true)

	self.toggleContainerNode = ccui.Layout:create()

	self.toggleContainerNode:setName("toggleContainer")
	self.toggleContainerNode:setLocalZOrder(1)
	self.toggleContainerNode:setAnchorPoint(cc.p(0, 0))
	self.toggleContainerNode:setPosition(cc.p(0, 90))
	self.toggleContainerNode:setContentSize(cc.size(640, 54))
	self.rootLayer:addChild(self.toggleContainerNode)

	local var_4_0 = ccui.ImageView:create("ChangeShowLayer/toggle_di.png", var_0_1)

	var_4_0:setAnchorPoint(cc.p(0, 0))
	self.toggleContainerNode:addChild(var_4_0)
	require("controller.limit_tower_defence_level_manager"):getInstance():RequestInfo(function()
		if tolua.isnull(self) then
			return
		end

		self:initPanel()
	end)
	self:fullScreen(self.rootLayer)
	EventManager:subscribe(self, EventManager.EVENT_IDS.GET_WEEKLY_TOWER_INFO, handler(self, self.handleGetWeeklyTowerInfo))
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			EventManager:unsubscribe(self)
		end
	end)
end

function ChangeShowLayer:initPanel()
	for iter_7_0 = 1, #var_0_28 do
		local var_7_0 = ccui.ImageView:create("ChangeShowLayer/toggle" .. iter_7_0 .. ".png", var_0_1)

		var_7_0:setPositionX((iter_7_0 - 1) * 150)
		var_7_0:setAnchorPoint(cc.p(0, 0))
		var_7_0:setName("toggle" .. iter_7_0)
		var_7_0:setTouchEnabled(true)

		local var_7_1 = ccui.ImageView:create("ChangeShowLayer/toggle" .. iter_7_0 .. "_on.png", var_0_1)

		var_7_1:setName("click")
		var_7_1:setAnchorPoint(cc.p(0, 0))
		var_7_0:addChild(var_7_1)
		self.toggleContainerNode:addChild(var_7_0)
	end

	self:setTglContainerCallback(self.toggleContainerNode, (self.initconfig or nil) and (self.initconfig.index or 1))
end

function ChangeShowLayer.checkExpeditionIsCanShow(arg_8_0, arg_8_1)
	return global_is_in_time(require("controller.expedition_manager"):getStarTimeStr(arg_8_1), (require("controller.expedition_manager"):getEndTimeStr(arg_8_1)))
end

function ChangeShowLayer.checkWeeklyTowerIsCanShow(arg_9_0)
	return Utility:isTimeRangeValid(nil, require("controller.weekly_tower_manager").getInstance():getEndTime())
end

function ChangeShowLayer.checkLimitTowerDefenceLayerIsCanShow(arg_10_0)
	return not not (level_manager:isPlayerPassLevel(UNLOCK_LIMITTOWERDEFENCELEVEL) and require("controller.limit_tower_defence_level_manager"):getInstance():checkActive())
end

function ChangeShowLayer:setTglContainerCallback(arg_11_1, arg_11_2)
	if arg_11_1 == nil then
		return
	end

	self.toggleContainer = {}

	local function var_11_0(arg_12_0, arg_12_1)
		if arg_12_1 == arg_12_0.isShow then
			return
		end

		local var_12_0 = arg_12_0:getChildByName("click")

		if arg_12_0.isShow == true then
			arg_12_0.isShow = false

			var_12_0:setVisible(false)
		else
			arg_12_0.isShow = true

			var_12_0:setVisible(true)

			self.initconfig.index = arg_12_0.index

			self:getListData(arg_12_0.index)
		end
	end

	local function var_11_1(arg_13_0)
		for iter_13_0 = 1, #self.toggleContainer do
			if arg_13_0 == iter_13_0 then
				var_11_0(self.toggleContainer[iter_13_0], true)
			else
				var_11_0(self.toggleContainer[iter_13_0], false)
			end
		end
	end

	while self.toggleContainerNode:getChildByName("toggle" .. 1) do
		local var_11_2 = self.toggleContainerNode:getChildByName("toggle" .. 1)

		var_11_2.index = 1
		var_11_2.isShow = false

		var_11_2:addTouchEventListener(function(arg_14_0, arg_14_1)
			if arg_14_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_11_1(arg_14_0.index)
		end)
		var_11_2:getChildByName("click"):setVisible(false)

		self.toggleContainer[1] = var_11_2
	end

	var_11_1(arg_11_2)
end

function ChangeShowLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchReturnLayer(self.returnbacklayer)
	end)

	self:addChild(self.bottomList, 10)
end

function ChangeShowLayer:createNode(arg_17_1, arg_17_2)
	local var_17_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "items"):clone()

	var_17_0:setTouchEnabled(false)
	var_17_0:setOpacity(0)

	local var_17_1 = ccui.Helper:seekWidgetByName(var_17_0, "jump_btn")

	var_17_1:setPressedActionEnabled(false)
	var_17_1:loadTextures(var_0_29[arg_17_1], var_0_29[arg_17_1], var_0_29[arg_17_1], var_0_1)

	local var_17_2 = ccui.Helper:seekWidgetByName(var_17_0, "Panel_lock")

	if arg_17_1 == "ScoreArenaLayer" or arg_17_1 == "ArenaLayer" or arg_17_1 == "ThreeVsThreeLayer" then
		var_17_0:setContentSize(cc.size(var_17_1:getContentSize().width, var_17_1:getContentSize().height + 20))
		var_17_1:setPositionY(var_17_0:getContentSize().height / 2 + 60)
		var_17_1:setPositionX(var_17_1:getContentSize().width / 2)

		if arg_17_1 == "ThreeVsThreeLayer" then
			local var_17_3 = ccui.ImageView:create("ChangeShowLayer/less_time.png", var_0_1)

			var_17_3:setPosition(cc.p(120, 306))
			var_17_3:setName("lessTimeImg")
			var_17_0:addChild(var_17_3)
		end

		if arg_17_1 == "ArenaLayer" then
			local var_17_4 = ccui.ImageView:create("ChangeShowLayer/arenaclass.png", var_0_1)

			var_17_4:setPosition(cc.p(80, 256))
			var_17_0:addChild(var_17_4)

			local var_17_5 = cc.Label:createWithTTF("", FONT_DES, 32)

			var_17_5:setPosition(cc.p(80, 210))
			var_17_5:setName("Label_13")
			var_17_0:addChild(var_17_5)
		end

		var_17_2:setContentSize(var_17_0:getContentSize())
		var_17_2:setPosition(cc.p(0, 60))

		self.nodeServantRank = require("view.Sprite.NodeServantRankEntrance"):showInLayer({
			mode = 0,
			chapter = 0,
			fightType = require("controller.servant_rank_manager").getInstance().FIGHT_TYPE.PVP,
			rankType = arg_17_2 + 1
		}, cc.p(tonumber(arg_17_2) % 2 == 0 and 520 or 120, 70))

		self.nodeServantRank:setCascadeOpacityEnabled(true)
		self:createLimitLevelTip(var_17_0):setPosition(tonumber(arg_17_2) % 2 == 1 and 280 or 20, 70)
	elseif arg_17_1 == "BianhuaStoryLayer" or arg_17_1 == "AvalonStoryLayer" or arg_17_1 == "LamiaStoryLayer" or arg_17_1 == "ActivityMainLayer_173" then
		var_17_0:setContentSize(cc.size(627, 269))
		var_17_2:setContentSize(var_17_0:getContentSize())
		var_17_1:setPositionX(var_17_1:getContentSize().width / 2)
		var_17_1:setPositionY(var_17_1:getContentSize().height / 2)
		var_17_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_17_2:setPosition(cc.p(var_17_1:getContentSize().width / 2, var_17_1:getContentSize().height / 2))
		self:createLimitLevelTip(var_17_0)

		if activity_return_manager:is_have_catchup_buff(activity_return_manager.BUFF_TYPES.BUFF_PVE_FIGNT_ATTRIBUTE) then
			self:createLimitLevelTip(var_17_0, L_RETURN_BUFF):setPosition(cc.p(0, var_17_0:getContentSize().height - 40))
		end
	else
		self:createLimitLevelTip(var_17_0)
	end

	if arg_17_1 == "ExpeditionLayer" then
		local var_17_6 = TempWidget:CreateTempBtn("ChangeShowLayer/btn_reward_preview.png", var_17_1)

		var_17_6:setAnchorPoint(cc.p(1, 0))
		var_17_6:align(cc.p(1, 0), var_17_1:getContentSize().width, 0)
		var_17_6:_addEvent(function()
			local var_18_0 = {}

			for iter_18_0, iter_18_1 in pairs(BonusPreview_data) do
				if iter_18_1.name == arg_17_1 then
					if iter_18_1.diamond then
						var_18_0[#var_18_0 + 1] = {
							id = "diamond",
							count = iter_18_1.diamond
						}
					end

					local var_18_1 = 1

					while iter_18_1["itemid" .. var_18_1] do
						local var_18_2 = {
							id = iter_18_1["itemid" .. var_18_1]
						}

						var_18_2.count = iter_18_1["item_num" .. var_18_1] or 1
						var_18_0[#var_18_0 + 1] = var_18_2
						var_18_1 = var_18_1 + 1
					end

					break
				end
			end

			LayerManager:pushInLayer("RewardPreviewLayer", var_18_0)
		end)
		self:createLimitLevelTip(var_17_0)
	end

	if arg_17_1 == "OldSubstitutionLayer" then
		local var_17_7 = TempWidget:CreateTempImg("ChangeShowLayer/infobg.png", var_17_1)

		var_17_7:setAnchorPoint(cc.p(1, 0))
		var_17_7:align(cc.p(1, 0), var_17_1:getContentSize().width, 5)
		var_17_7:_addEvent(function()
			LayerManager:pushInLayer("PopActivityDetail", {
				key = "OldSubstitute"
			})
		end)

		local var_17_8 = cc.Label:createWithTTF(L_ADVENTURER_RANDOMLAYER[13], FONT_DES, 20)

		var_17_8:setAnchorPoint(cc.p(0.5, 0.5))
		var_17_8:setPosition(cc.p(var_17_7:getContentSize().width / 2, var_17_7:getContentSize().height / 2))
		var_17_7:addChild(var_17_8, 1)
		self:createLimitLevelTip(var_17_0)
	end

	return var_17_0
end

function ChangeShowLayer.checkIsCanShow(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1 and arg_20_1.layerName
	local var_20_1 = {
		ExpeditionLayer = function(arg_21_0)
			return arg_20_0:checkExpeditionIsCanShow(arg_21_0)
		end,
		WeeklyTowerEntranceLayer = function()
			return arg_20_0:checkWeeklyTowerIsCanShow()
		end,
		LimitTowerDefenceLevelLayer = function()
			return arg_20_0:checkLimitTowerDefenceLayerIsCanShow()
		end
	}

	return not (var_20_1[arg_20_1 and arg_20_1.layerName] and type(var_20_1[var_20_0] == "function") and var_20_1[var_20_0](arg_20_1 and arg_20_1.id) == false)
end

function ChangeShowLayer:initListView()
	self.Listview:removeAllItems()
	self.Listview:setItemsMargin(10)
	assert(self.data, "error:----------------------------> no data can use！！！！！")

	for iter_24_0, iter_24_1 in ipairs(self.data) do
		if self:checkIsCanShow(iter_24_1) == true then
			local var_24_0 = self:createNode(iter_24_1.layerName, iter_24_0)

			var_24_0:setName("btn_" .. iter_24_1.layerName)

			local var_24_1 = ccui.Helper:seekWidgetByName(var_24_0, "jump_btn")

			var_24_1:setSwallowTouches(false)

			local var_24_2 = ccui.Helper:seekWidgetByName(var_24_0, "Panel_lock")

			var_24_0.jumplayer = iter_24_1.layerName
			var_24_0.id = iter_24_1.id

			local var_24_3 = iter_24_1.layerName

			if iter_24_1.layerName ~= "SubstitutionBossLayer" or level_manager:isPlayerPassLevel(UNLOCK_SUBSTITUTION) then
				-- block empty
			else
				var_24_1:setColor(cc.c3b(140, 140, 140))
			end

			if var_24_3 == "OldSubstitutionLayer" then
				-- block empty
			end

			var_24_0:runAction((cc.Sequence:create(cc.DelayTime:create(0.1 * (iter_24_0 - 1)), cc.FadeIn:create(0.13))))
			var_24_1:addTouchEventListener(function(arg_25_0, arg_25_1)
				if arg_25_1 ~= ccui.TouchEventType.ended then
					return
				end

				if var_24_3 == "OldSubstitutionLayer" then
					self:initSubEntrance(var_0_2)()
				else
					if var_24_3 == "ArenaLayer" or var_24_3 == "ScoreArenaLayer" then
						if time_check_manager:getCurTime() < os.time({
							hour = 12,
							month = 4,
							year = 2024,
							min = 0,
							sec = 0,
							day = 1
						}) and time_check_manager:getCurTime() > os.time({
							hour = 23,
							month = 3,
							year = 2024,
							min = 59,
							sec = 59,
							day = 29
						}) then
							global_ShowBlockWords(L_ARENA_WARNING.Begin_Fight[8], RISE_WORDS_WARNING)

							return
						end
					end

					if var_24_3 == "ThreeVsThreeLayer" and time_check_manager:getCurTime() < os.time({
						hour = 12,
						month = 4,
						year = 2024,
						min = 0,
						sec = 0,
						day = 1
					}) and time_check_manager:getCurTime() > os.time({
						hour = 23,
						month = 3,
						year = 2024,
						min = 59,
						sec = 59,
						day = 31
					}) then
						global_ShowBlockWords(L_ARENA_WARNING.Begin_Fight[8], RISE_WORDS_WARNING)

						return
					end

					if var_24_3 == "SubstitutionBossLayer" then
						if level_manager:isPlayerPassLevel(UNLOCK_SUBSTITUTION) then
							substitution_manager:get_substitution_list(function(arg_26_0)
								if not arg_26_0 or not next(arg_26_0) then
									global_ShowBlockWords(L_SUBSTUTUTION_NULL)
								elseif #arg_26_0 == 1 then
									LayerManager:switchShowLayer("SubstitutionLayer", {
										mode = arg_26_0[1].mode,
										endtime = arg_26_0[1].remaintime
									})
								else
									LayerManager:switchShowLayer(var_24_3)
								end
							end)
						else
							global_ShowBlockWords(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_SUBSTITUTION)))
						end
					elseif var_24_3 == "TowerDefenceLevelLayer" then
						LayerManager:switchShowLayer("TowerDefenceLevelLayer", {
							activityid = 1021
						})
						AnalyticManager.towerDefenceEntrnace({
							entranceid = 1
						})
					elseif var_24_3 == "ThreeVsThreeLayer" and arenatft_manager:getCurSeason() < 0 then
						global_ShowBlockWords(L_TVT_BEHAND_SEASON_2)

						return
					elseif var_24_3 == "LimitTowerDefenceLevelLayer" then
						if level_manager:isPlayerPassLevel(UNLOCK_LIMITTOWERDEFENCELEVEL) then
							local var_25_0 = require("controller.limit_tower_defence_level_manager"):getInstance()

							if not var_25_0:checkActive() then
								local var_25_1 = os.date("%y年%m月%d日", var_25_0:getStartTime() or 0)

								global_ShowBlockWords(L_CHANGE_SHOW[1])

								return
							end

							LayerManager:switchShowLayer("LimitTowerDefenceLevelLayer")
						else
							global_ShowBlockWords(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_LIMITTOWERDEFENCELEVEL)))
						end
					elseif var_24_3 == "ExpeditionLayer" or var_24_3 == "MonopolyLayer" then
						if var_24_3 == "ExpeditionLayer" and not level_manager:isPlayerPassLevel(UNLOCK_EXPEDITION) then
							global_ShowBlockWords(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_EXPEDITION)))

							return
						end

						local var_25_2
						local var_25_3

						if var_24_3 == "ExpeditionLayer" then
							var_25_3 = iter_24_1.id
							var_25_2 = "4002" .. iter_24_1.id
						elseif var_24_3 == "MonopolyLayer" then
							var_25_3 = MONOPOLY_MODE_ID
							var_25_2 = "4001" .. MONOPOLY_MODE_ID
						end

						local var_25_4

						if time_check_manager:getCurTime() > global_get_time_by_date((require("controller.expedition_manager"):getEndTimeStr(var_25_3))) then
							global_ShowBlockWords(L_CHANGE_SHOW[2])

							do return end

							var_25_4 = {
								jump_to_system = var_25_2
							}
						end

						var_25_4.config = {
							inittype = var_25_3,
							jumpid = var_25_2
						}

						goto_complete_system(var_25_4)
					elseif var_24_3 == "ArenaLayer" then
						LayerManager:switchShowLayer(var_24_3)
					elseif var_0_31[var_24_3] and not level_manager:isPlayerPassLevel(var_0_31[var_24_3]) then
						global_ShowBlockWords(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(var_0_31[var_24_3])))
					else
						LayerManager:switchShowLayer(var_24_3)
					end
				end
			end)

			if var_24_3 == "ExpeditionLayer" then
				var_24_1.mode_id = iter_24_1.id
			elseif var_24_3 == "MonopolyLayer" then
				var_24_1.mode_id = MONOPOLY_MODE_ID
			end

			self:checkAlert(var_24_1, var_24_3)
			self.Listview:pushBackCustomItem(var_24_0)
			self:createtips(var_24_0, iter_24_1.layerName)
			self:updateOtherInfo(var_24_0, iter_24_1.layerName)
			self:updateBtnLables(var_24_0, iter_24_1.layerName)

			if var_24_3 == "CompetitionLayer" then
				if level_manager:isPlayerPassLevel(math.min(UNLOCK_ARENA, UNLOCK_SCOREARENA, UNLOCK_THREE_VS_THREE)) then
					var_24_2:setVisible(false)
				else
					var_24_2:setVisible(true)
					var_24_2:getChildByName("Label_lockdes"):setString(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(math.min(UNLOCK_ARENA, UNLOCK_SCOREARENA, UNLOCK_THREE_VS_THREE))))
				end
			elseif var_24_3 == "TowerDefenceLevelLayer" then
				if level_manager:isPlayerPassLevel(UNLOCK_TOWERDEFENCE) then
					var_24_2:setVisible(false)
				else
					var_24_2:setVisible(true)
					var_24_2:getChildByName("Label_lockdes"):setString(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_TOWERDEFENCE)))
				end
			elseif var_24_3 == "StoryModesLayer" then
				if level_manager:isPlayerPassLevel(UNLOCK_STORYMODES) then
					var_24_2:setVisible(false)
				else
					var_24_2:setVisible(true)
					var_24_2:getChildByName("Label_lockdes"):setString(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_STORYMODES)))
				end
			elseif var_24_3 == "SubstitutionBossLayer" then
				if level_manager:isPlayerPassLevel(UNLOCK_SUBSTITUTION) then
					var_24_2:setVisible(false)
				else
					var_24_2:setVisible(true)
					var_24_2:getChildByName("Label_lockdes"):setString(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_SUBSTITUTION)))
				end
			elseif var_24_3 == "SpecialJumpTowerLayer" then
				if level_manager:isPlayerPassLevel(UNLOCK_SHILIANTA) then
					var_24_2:setVisible(false)
				else
					var_24_2:setVisible(true)
					var_24_2:getChildByName("Label_lockdes"):setString(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_SHILIANTA)))
				end
			elseif var_24_3 == "ScoreArenaLayer" then
				if level_manager:isPlayerPassLevel(UNLOCK_SCOREARENA) then
					var_24_2:setVisible(false)
				else
					var_24_2:setVisible(true)
					var_24_2:getChildByName("Label_lockdes"):setString(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_SCOREARENA)))

					if var_24_0:getChildByName("jfsl") then
						var_24_0:getChildByName("jfsl"):setVisible(false)
						var_24_0:getChildByName("jfslbg"):setVisible(false)

						var_24_0:getChildByName("jfslbg").visible = false

						var_24_0:getChildByName("time"):setVisible(false)
					end
				end
			elseif var_24_3 == "ArenaLayer" then
				if level_manager:isPlayerPassLevel(UNLOCK_ARENA) then
					var_24_2:setVisible(false)
				else
					var_24_2:setVisible(true)
					var_24_2:getChildByName("Label_lockdes"):setString(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_ARENA)))

					if var_24_0:getChildByName("jfsl") then
						var_24_0:getChildByName("jfsl"):setVisible(false)
						var_24_0:getChildByName("jfslbg"):setVisible(false)

						var_24_0:getChildByName("jfslbg").visible = false

						var_24_0:getChildByName("time"):setVisible(false)
					end
				end
			elseif var_24_3 == "ThreeVsThreeLayer" then
				if level_manager:isPlayerPassLevel(UNLOCK_THREE_VS_THREE) then
					var_24_2:setVisible(false)
				else
					var_24_2:setVisible(true)
					var_24_2:getChildByName("Label_lockdes"):setString(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_THREE_VS_THREE)))

					if var_24_0:getChildByName("jfsl") then
						var_24_0:getChildByName("jfsl"):setVisible(false)
						var_24_0:getChildByName("jfslbg"):setVisible(false)

						var_24_0:getChildByName("jfslbg").visible = false

						var_24_0:getChildByName("time"):setVisible(false)
						var_24_0:getChildByName("lessTimeImg"):setVisible(false)
					end
				end
			elseif var_24_3 == "BianhuaStoryLayer" or var_24_3 == "AvalonStoryLayer" or var_24_3 == "LamiaStoryLayer" or var_24_3 == "ActivityMainLayer_173" then
				if level_manager:isPlayerPassLevel(var_0_31[var_24_3]) then
					var_24_2:setVisible(false)
				else
					var_24_2:setVisible(true)
					var_24_2:getChildByName("Label_lockdes"):setString(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(var_0_31[var_24_3])))
				end
			elseif var_24_3 == "ExploreOfferLayer" then
				if level_manager:isPlayerPassLevel(UNLOCK_EXPLOREOFFERLAYER) then
					var_24_2:setVisible(false)
				else
					var_24_2:setVisible(true)
					var_24_2:getChildByName("Label_lockdes"):setString(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_EXPLOREOFFERLAYER)))

					if var_24_0:getChildByName("richText1") then
						var_24_0:getChildByName("richText1"):setVisible(false)
						var_24_0:getChildByName("richText2"):setVisible(false)
						var_24_0:getChildByName("richText3"):setVisible(false)
					end
				end
			elseif var_24_3 == "LimitTowerDefenceLevelLayer" then
				if level_manager:isPlayerPassLevel(UNLOCK_LIMITTOWERDEFENCELEVEL) then
					var_24_2:setVisible(false)
				else
					var_24_2:setVisible(true)
					var_24_2:getChildByName("Label_lockdes"):setString(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_LIMITTOWERDEFENCELEVEL)))

					if var_24_0:getChildByName("richText1") then
						var_24_0:getChildByName("richText1"):setVisible(false)
						var_24_0:getChildByName("richText2"):setVisible(false)
						var_24_0:getChildByName("richText3"):setVisible(false)
					end
				end
			elseif var_24_3 == "WeeklyTowerEntranceLayer" then
				if level_manager:isPlayerPassLevel(UNLOCK_WEEKLYTOWERD) then
					var_24_2:setVisible(false)
				else
					var_24_2:setVisible(true)
					var_24_2:getChildByName("Label_lockdes"):setString(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_WEEKLYTOWERD)))

					if var_24_0:getChildByName("richText1") then
						var_24_0:getChildByName("richText1"):setVisible(false)
						var_24_0:getChildByName("richText2"):setVisible(false)
						var_24_0:getChildByName("richText3"):setVisible(false)
					end
				end
			elseif var_24_3 == "AdventureNewItemLayer" then
				if level_manager:isPlayerPassLevel(UNLOCK_AD) then
					var_24_2:setVisible(false)
				else
					var_24_2:setVisible(true)
					var_24_2:getChildByName("Label_lockdes"):setString(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_AD)))
				end
			elseif var_24_3 == "ExpeditionLayer" then
				if level_manager:isPlayerPassLevel(UNLOCK_EXPEDITION) then
					var_24_2:setVisible(false)
				else
					var_24_2:setVisible(true)
					var_24_2:getChildByName("Label_lockdes"):setString(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_EXPEDITION)))
				end
			elseif var_24_3 == "OldSubstitutionLayer" then
				if level_manager:isPlayerPassLevel(UNLOCK_SUBSTITUTION2) then
					var_24_2:setVisible(false)
				else
					var_24_2:setVisible(true)
					var_24_2:getChildByName("Label_lockdes"):setString(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_SUBSTITUTION2)))
				end
			else
				var_24_2:setVisible(false)
			end
		end
	end
end

function ChangeShowLayer:createtips(arg_27_1, arg_27_2)
	if not var_0_30[arg_27_2] or not activity_conf_data[var_0_30[arg_27_2].activitid] then
		return
	end

	local var_27_0 = activity_conf_data[var_0_30[arg_27_2].activitid].starttime

	if arg_27_1:getChildByName("tipsnode") then
		arg_27_1:getChildByName("tipsnode"):removeFromParent()
	end

	if self:checkIsTime(var_27_0, activity_conf_data[var_0_30[arg_27_2].activitid].finishtime) then
		local var_27_1 = ccui.ImageView:create(var_0_30[arg_27_2].path, var_0_1)

		var_27_1:setName("tipsnode")
		var_27_1:setPosition(var_0_30[arg_27_2].pos)
		arg_27_1:addChild(var_27_1, 33)
	end

	self.awardUpBtn = ccui.Button:create("ChangeShowLayer/awardup_btn.png", nil, "ChangeShowLayer/awardup_btn.png", var_0_1)

	self.awardUpBtn:setPosition(cc.p(400, 26))
	self.awardUpBtn:setVisible(playermodel.award_up_info.adventure and playermodel.award_up_info.adventure[1].rate > 1 and global_is_in_time(playermodel.award_up_info.adventure[1].starttime, playermodel.award_up_info.adventure[1].finishtime) or false)
	arg_27_1:addChild(self.awardUpBtn, 100)
	self.awardUpBtn:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "award_up"
		})
	end)
end

function ChangeShowLayer.checkIsTime(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0

	if not arg_29_1 or not arg_29_2 then
		do return false end

		var_29_0 = time_check_manager:getCurTime()
	end

	if global_get_time_by_date(arg_29_1) <= var_29_0 and var_29_0 <= global_get_time_by_date(arg_29_2) then
		return true
	else
		return false
	end
end

function ChangeShowLayer:createTitleSprite()
	self.title = TitleSprite:create("spicalTower/title.png", 2)

	self.title:setName("title")
	self.title:setPosition(cc.p(0, GameDisplay.getUiScreenSize().height - 56))
	self.rootLayer:addChild(self.title, 5)

	local var_30_0 = ccui.Layout:create()

	var_30_0:setTouchEnabled(true)
	var_30_0:setContentSize(self.title:getContentSize())
	var_30_0:setAnchorPoint(cc.p(0, 0))
	var_30_0:setPosition(cc.p(0, GameDisplay.getUiScreenSize().height - 56))
	var_30_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.rootLayer:addChild(var_30_0, 6)
	var_30_0:addTouchEventListener(function(arg_31_0, arg_31_1)
		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_31_0 = {
			callback = callback
		}

		var_31_0.key = "activity_lamia"

		LayerManager:pushInLayer("PopActivityDetail", var_31_0)
	end)
end

function ChangeShowLayer:getListData(arg_32_1)
	if var_0_28[arg_32_1] == nil then
		return
	end

	local var_32_0 = {}

	for iter_32_0, iter_32_1 in pairs(var_0_28[arg_32_1]) do
		if iter_32_1.layerName == "ExpeditionLayer" then
			local var_32_1 = {}

			for iter_32_2, iter_32_3 in pairs(expedition_entrance_data) do
				if iter_32_3.season_type == 1 then
					table.insert(var_32_1, {
						id = iter_32_3.season
					})
				end
			end

			for iter_32_4, iter_32_5 in pairs(var_32_1) do
				table.insert(var_32_0, {
					layerName = iter_32_1.layerName,
					isPseudoLevel = iter_32_1.isPseudoLevel,
					id = iter_32_5.id
				})
			end
		else
			table.insert(var_32_0, iter_32_1)
		end
	end

	if not next(var_32_0) then
		print("error: ---> no data can use！！！！！")
	end

	self.data = var_32_0
	self.curIndex = arg_32_1

	self:initListView()
	alert_manager:check_current_alert("AdventureLayer")
end

function ChangeShowLayer.sortByOrder(arg_33_0, arg_33_1)
	if arg_33_1 and #arg_33_1 > 1 then
		table.sort(arg_33_1, function(arg_34_0, arg_34_1)
			return arg_34_0.order < arg_34_1.order
		end)
	end
end

function ChangeShowLayer.canChange(arg_35_0, arg_35_1, arg_35_2)
	return
end

function ChangeShowLayer.createTimeString(arg_36_0, arg_36_1)
	return
end

function ChangeShowLayer.checkIsVaild(arg_37_0, arg_37_1)
	return
end

function ChangeShowLayer.checkTimeIsOverVaild(arg_38_0, arg_38_1)
	return
end

function ChangeShowLayer.dealString(arg_39_0, arg_39_1)
	return
end

function ChangeShowLayer.initSubEntrance(arg_40_0, arg_40_1)
	return function(arg_41_0)
		if not level_manager:isPlayerPassLevel(UNLOCK_SUBSTITUTION2) then
			global_ShowBlockWords(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_SUBSTITUTION2)))

			return
		end

		local function var_41_0()
			return
		end

		local var_41_1 = {
			fight_type = "SUBSTITUTION",
			chapter = 2,
			level = 1,
			mode = arg_40_1,
			callback = var_41_0,
			adventuresurecallback = function()
				LayerManager:pushInLayer("FormationOldSubstituteLayer", {
					returnlayer = "AdventureLayer",
					mode = arg_40_1,
					cancelcallback = var_41_0
				})
			end,
			initindex = curArray
		}

		LayerManager:switchShowLayer("OldSubstitutionLayer", {
			chapter = arg_41_0,
			surecallback = function()
				LayerManager:pushInLayer("LevelDetailLayer", var_41_1)
			end
		})
	end
end

function ChangeShowLayer.fullScreen(arg_45_0, arg_45_1)
	arg_45_1:setContentSize((GameDisplay.getScreenSize()))
	arg_45_1:setPositionY(arg_45_1:getPositionY() - GameDisplay.fix_y)
end

function ChangeShowLayer.checkAlert(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = {
		AdventureNewItemLayer = function(...)
			if alert_manager.alertsys[ALERT_NEW_CHANGING] then
				alert_manager:add_new_mark(arg_46_1, true, cc.p(arg_46_1:getContentSize().width - 10, arg_46_1:getContentSize().height - 15))
			end
		end,
		BianhuaStoryLayer = function()
			if level_manager:isPlayerPassLevel(UNLOCK_STORYMODES) then
				if not RoleDefault:getInstance():getBoolForKey("BianhuaStoryLayer_first", false) then
					alert_manager:add_new_mark(arg_46_1, true, cc.p(arg_46_1:getContentSize().width - 20, arg_46_1:getContentSize().height - 15))
				end
			end
		end,
		AvalonStoryLayer = function()
			if level_manager:isPlayerPassLevel(UNLOCK_STORYMODES) then
				if not RoleDefault:getInstance():getBoolForKey("AvalonStoryLayer_first", false) then
					alert_manager:add_new_mark(arg_46_1, true, cc.p(arg_46_1:getContentSize().width - 20, arg_46_1:getContentSize().height - 15))
				end
			end
		end,
		LamiaStoryLayer = function()
			if level_manager:isPlayerPassLevel(UNLOCK_STORYMODES) then
				if not RoleDefault:getInstance():getBoolForKey("LamiaStoryLayer_first", false) then
					alert_manager:add_new_mark(arg_46_1, true, cc.p(arg_46_1:getContentSize().width - 20, arg_46_1:getContentSize().height - 15))
				end
			end
		end,
		ActivityMainLayer_173 = function(...)
			if level_manager:isPlayerPassLevel(UNLOCK_STORYMODES) then
				if not RoleDefault:getInstance():getBoolForKey("ActivityMainLayer_173_first", false) then
					alert_manager:add_new_mark(arg_46_1, true, cc.p(arg_46_1:getContentSize().width - 20, arg_46_1:getContentSize().height - 15))
				end
			end
		end,
		ExpeditionLayer = function(...)
			if level_manager:isPlayerPassLevel(UNLOCK_STORYMODES) then
				if not RoleDefault:getInstance():getBoolForKey("ExpeditionLayer_" .. arg_46_1.mode_id .. "_first", false) then
					alert_manager:add_new_mark(arg_46_1, true, cc.p(arg_46_1:getContentSize().width - 20, arg_46_1:getContentSize().height - 15))
				end
			end
		end,
		SpecialJumpTowerLayer = function(...)
			if alert_manager.alertsys[E_ALTER_LEVEL_ADVENTURE] then
				alert_manager:add_new_tower_mark(arg_46_1, true, cc.p(arg_46_1:getContentSize().width - 20, arg_46_1:getContentSize().height - 15), nil)
			end
		end
	}

	if var_46_0[arg_46_2] then
		var_46_0[arg_46_2]()
	end
end

function ChangeShowLayer:registerTimeCheckEvent()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("timeCheckManagerEvent", function(arg_55_0)
		if arg_55_0.eventType == NEXT_DAY then
			playermodel:getServerTime(function()
				self:getListData()
			end)
		end
	end), self)
end

function ChangeShowLayer.checkIsOpen(arg_57_0, arg_57_1)
	local var_57_0 = {}

	if var_57_0[arg_57_1] then
		return var_57_0[arg_57_1]()
	else
		return true
	end
end

function ChangeShowLayer:updateOtherInfo(arg_58_1, arg_58_2)
	local var_58_0 = {
		AdventureNewItemLayer = function()
			self:updateWeekedTimes(arg_58_1)
		end,
		CompetitionLayer = function()
			self:updateCompetionTimes(arg_58_1)
		end,
		SubstitutionBossLayer = function()
			self:updateSubstitutionEndTime(arg_58_1)
		end,
		ExploreOfferLayer = function()
			self:updateExploreOfferTimes(arg_58_1)
		end,
		LimitTowerDefenceLevelLayer = function()
			self:updateLimitTowerDefenceLevelEndTime(arg_58_1)
		end,
		TowerDefenceLevelLayer = function()
			self:updateTowerDefenceLevelEndTime(arg_58_1)
		end,
		WeeklyTowerEntranceLayer = function()
			self:updateWeeklyTowerEndTime(arg_58_1)
		end,
		ExpeditionLayer = function()
			self:updateExpeditionEndTime(arg_58_1)
		end,
		SpecialJumpTowerLayer = function()
			self:updateSpecialJumpTowerTimes(arg_58_1)
		end
	}

	if var_58_0[arg_58_2] then
		var_58_0[arg_58_2]()
	end

	local var_58_1 = Utility:indexOf(self.data, function(arg_68_0)
		return arg_68_0.layerName == arg_58_2
	end)
	local var_58_2 = arg_58_1:getChildByName("imgLevelTip")

	if var_0_28[self.curIndex][var_58_1] and var_0_28[self.curIndex][var_58_1].isPseudoLevel then
		var_58_2:setVisible(true)
	else
		var_58_2:setVisible(false)
	end
end

function ChangeShowLayer.createLimitLevelTip(arg_69_0, arg_69_1, arg_69_2)
	arg_69_2 = arg_69_2 or L_FALSE_LEVEL

	local var_69_0 = ccui.ImageView:create("public/panelbg/level_tip.png", var_0_1)

	arg_69_1:addChild(var_69_0)
	var_69_0:setAnchorPoint(0, 1)

	local var_69_1 = ccui.ImageView:create("public/panelbg/img_exclamation.png", var_0_1)

	var_69_1:setAnchorPoint(0, 0.5)
	var_69_1:setPosition(15, 20)
	var_69_0:addChild(var_69_1)
	var_69_0:setPosition(0, arg_69_1:getContentSize().height)

	local var_69_2 = ccui.Text:create(arg_69_2, "fonts/W5.ttf", 22)

	var_69_2:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_LEFT)
	var_69_2:setTextVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
	var_69_2:setAnchorPoint(0, 0.5)
	var_69_0:addChild(var_69_2)
	var_69_2:setPosition(45, 21)
	var_69_0:setName("imgLevelTip")

	return var_69_0
end

function ChangeShowLayer:updateExpeditionEndTime(arg_70_1)
	if arg_70_1:getChildByName("endtime_expedition") then
		arg_70_1:getChildByName("endtime_expedition"):removeFromParent()
	end

	local var_70_0 = cc.Label:createWithTTF("", "fonts/number.ttf", 22)

	var_70_0:setAnchorPoint(cc.p(0, 0.5))
	var_70_0:setPosition(cc.p(10, 20))
	var_70_0:setName("endtime_expedition")
	arg_70_1:addChild(var_70_0)
	var_70_0:setString(L_ADVENTURER_RANDOMLAYER[12] .. require("controller.expedition_manager"):getLeftTimeStr())

	if activity_return_manager:is_have_catchup_buff(activity_return_manager.BUFF_TYPES.BUFF_PVE_FIGNT_ATTRIBUTE) then
		local var_70_1 = self:createLimitLevelTip(arg_70_1, L_RETURN_BUFF)
	end
end

function ChangeShowLayer:updateWeeklyTowerEndTime(arg_71_1)
	EventManager:requestGetWeeklyTowerInfo()

	if activity_return_manager:is_have_catchup_buff(activity_return_manager.BUFF_TYPES.BUFF_PVE_FIGNT_ATTRIBUTE) then
		local var_71_0 = self:createLimitLevelTip(arg_71_1, L_RETURN_BUFF)
	end
end

function ChangeShowLayer:handleGetWeeklyTowerInfo(arg_72_1)
	if not arg_72_1 then
		return
	end

	local var_72_0 = self.Listview:getChildByName("btn_" .. "WeeklyTowerEntranceLayer")
	local var_72_1 = require("controller.weekly_tower_manager").getInstance()

	if var_72_0:getChildByName("endtime_random") then
		var_72_0:getChildByName("endtime_random"):removeFromParent()
	end
end

function ChangeShowLayer:updateSubstitutionEndTime(arg_73_1)
	local var_73_1
	local var_73_0

	if not arg_73_1 then
		do return end

		var_73_1 = time_check_manager:getCurTime()
	end

	for iter_73_0, iter_73_1 in pairs((require("data.levelmode_601_data"))) do
		local var_73_2 = global_get_time_by_date(iter_73_1.starttime)

		if iter_73_1.is_show_in_list and 0 < var_73_2 and var_73_2 < var_73_1 then
			var_73_0 = iter_73_1
		end
	end

	if arg_73_1:getChildByName("endtime_Subs") then
		arg_73_1:getChildByName("endtime_Subs"):removeFromParent()
	end

	local var_73_4 = cc.Label:createWithTTF(L_TVT_NOT_OPEN, "fonts/number.ttf", 22)

	var_73_4:setAnchorPoint(cc.p(0, 0.5))
	var_73_4:setPosition(cc.p(10, 20))
	var_73_4:setName("endtime_Subs")
	arg_73_1:addChild(var_73_4)

	if var_73_0 and var_73_0.endtime then
		local var_73_5 = os.date("*t", math.floor((global_get_time_by_date(var_73_0.endtime))))

		arg_73_1:getChildByName("endtime_Subs"):setString((string.format(L_ADVENTURER_RANDOMLAYER[1], var_73_5.year, var_73_5.month, var_73_5.day, var_73_5.hour, var_73_5.min, var_73_5.sec)))
	end

	if not level_manager:isPlayerPassLevel(UNLOCK_SUBSTITUTION) then
		var_73_4:setVisible(false)
	end

	if activity_return_manager:is_have_catchup_buff(activity_return_manager.BUFF_TYPES.BUFF_PVE_FIGNT_ATTRIBUTE) then
		self:createLimitLevelTip(arg_73_1, L_RETURN_BUFF):setPosition(cc.p(0, arg_73_1:getContentSize().height - 40))
	end
end

function ChangeShowLayer:updateSpecialJumpTowerTimes(arg_74_1)
	if activity_return_manager:is_have_catchup_buff(activity_return_manager.BUFF_TYPES.BUFF_PVE_FIGNT_ATTRIBUTE) then
		local var_74_0 = self:createLimitLevelTip(arg_74_1, L_RETURN_BUFF)
	end
end

function ChangeShowLayer.getWeekedTimes(arg_75_0, arg_75_1)
	if not arg_75_1 then
		return
	end

	local var_75_0 = 0

	for iter_75_0, iter_75_1 in pairs(levelmode_data) do
		if iter_75_1.modetype == arg_75_1 and iter_75_1.dailytime then
			var_75_0 = iter_75_1.dailytime
		end
	end

	return var_75_0
end

function ChangeShowLayer:updateWeekedTimes(arg_76_1)
	local var_76_0 = {
		[2] = L_ADVENTURER_RANDOMLAYER[8],
		[3] = L_ADVENTURER_RANDOMLAYER[3],
		[4] = L_ADVENTURER_RANDOMLAYER[4],
		[70] = L_ADVENTURER_RANDOMLAYER[70]
	}

	if arg_76_1:getChildByName("wzcbl") then
		arg_76_1:getChildByName("wzcbl"):removeFromParent()
	end

	if arg_76_1:getChildByName("wsssl") then
		arg_76_1:getChildByName("wsssl"):removeFromParent()
	end

	if arg_76_1:getChildByName("zykhl") then
		arg_76_1:getChildByName("wsssl"):removeFromParent()
	end

	local var_76_1 = "<p></p>"
	local var_76_2 = "<p>%s:<span style=color: rgb(255,210,0);>%d</span>/%d</p>"
	local var_76_3 = RichTextPro:create()

	var_76_3:setSize(22)
	var_76_3:setLineSpace(0)
	var_76_3:setText(var_76_1, nil, true)
	var_76_3:setName("wzcbl")
	arg_76_1:addChild(var_76_3)

	local var_76_4 = RichTextPro:create()

	var_76_4:setSize(22)
	var_76_4:setLineSpace(0)
	var_76_4:setText(var_76_1, nil, true)
	var_76_4:setName("wsssl")
	arg_76_1:addChild(var_76_4)

	local var_76_5 = RichTextPro:create()

	var_76_5:setSize(22)
	var_76_5:setLineSpace(0)
	var_76_5:setText(var_76_1, nil, true)
	var_76_5:setName("zykhl")
	arg_76_1:addChild(var_76_5)

	local var_76_6 = RichTextPro:create()

	var_76_6:setSize(22)
	var_76_6:setLineSpace(0)
	var_76_6:setText(var_76_1, nil, true)
	var_76_6:setName("component")
	arg_76_1:addChild(var_76_6)
	level_manager:getAdventureDailytimeByModeType(nil, function(arg_77_0, arg_77_1)
		if not tolua.isnull(arg_76_1) and arg_77_0 == 1 then
			if arg_77_1 and arg_77_1[2] then
				if arg_77_1[2].time == 0 and self:getWeekedTimes(2) == 0 then
					arg_76_1:getChildByName("wzcbl"):setText(var_76_1)
				else
					arg_76_1:getChildByName("wzcbl"):setText(string.format(var_76_2, var_76_0[2], arg_77_1[2].time, self:getWeekedTimes(2)))
					arg_76_1:getChildByName("wzcbl"):setPosition(cc.p(10, 30))
				end
			else
				arg_76_1:getChildByName("wzcbl"):setText(var_76_1)
			end

			if arg_77_1 and arg_77_1[3] then
				if arg_77_1[3].time == 0 and self:getWeekedTimes(3) == 0 then
					arg_76_1:getChildByName("wsssl"):setText(var_76_1)
				else
					arg_76_1:getChildByName("wsssl"):setText(string.format(var_76_2, var_76_0[3], arg_77_1[3].time, self:getWeekedTimes(3)))

					local var_77_0, var_77_1 = arg_76_1:getChildByName("wzcbl"):getContentSize()

					arg_76_1:getChildByName("wsssl"):setPosition(cc.p(10, arg_76_1:getChildByName("wzcbl"):getPositionY() - var_77_1 - 2))
				end
			else
				arg_76_1:getChildByName("wsssl"):setText(var_76_1)
			end

			if arg_77_1 and arg_77_1[4] then
				if arg_77_1[4].time == 0 and self:getWeekedTimes(4) == 0 then
					arg_76_1:getChildByName("zykhl"):setText(var_76_1)
				else
					arg_76_1:getChildByName("zykhl"):setText(string.format(var_76_2, var_76_0[4], arg_77_1[4].time, self:getWeekedTimes(4)))

					local var_77_2, var_77_3 = arg_76_1:getChildByName("wsssl"):getContentSize()

					arg_76_1:getChildByName("zykhl"):setPosition(cc.p(10, arg_76_1:getChildByName("wsssl"):getPositionY() - var_77_3 - 2))
				end
			else
				arg_76_1:getChildByName("zykhl"):setText(var_76_1)
			end

			if arg_77_1 and arg_77_1[70] then
				if arg_77_1[70].time == 0 and self:getWeekedTimes(70) == 0 then
					arg_76_1:getChildByName("component"):setText(var_76_1)
				else
					arg_76_1:getChildByName("component"):setText(string.format(var_76_2, var_76_0[70], arg_77_1[70].time, self:getWeekedTimes(70)))

					local var_77_4, var_77_5 = arg_76_1:getChildByName("zykhl"):getContentSize()

					arg_76_1:getChildByName("component"):setPosition(cc.p(10, arg_76_1:getChildByName("zykhl"):getPositionY() - var_77_5 - 2))
				end
			else
				arg_76_1:getChildByName("component"):setText(var_76_1)
			end
		end
	end)

	if activity_return_manager:is_have_catchup_buff(activity_return_manager.BUFF_TYPES.BUFF_TYPE_ADVENTURE_DROP) or playermodel.award_up_info.adventure and playermodel.award_up_info.adventure[1].rate > 1 and global_is_in_time(playermodel.award_up_info.adventure[1].starttime, playermodel.award_up_info.adventure[1].finishtime) or false then
		local var_76_7 = ccui.ImageView:create("ChangeShowLayer/double_drop.png", var_0_1)

		var_76_7:setName("imgCatchUp")
		arg_76_1:addChild(var_76_7, 5)
		var_76_7:setPosition(cc.p(70, 65))
	end

	if activity_return_manager:is_have_catchup_buff(activity_return_manager.BUFF_TYPES.BUFF_PVE_FIGNT_ATTRIBUTE) then
		self:createLimitLevelTip(arg_76_1, L_RETURN_BUFF):setPosition(cc.p(0, arg_76_1:getContentSize().height - 40))
	end
end

function ChangeShowLayer.updateCompetionTimes(arg_78_0, arg_78_1)
	local var_78_0 = {
		{
			max = 2,
			name = L_ADVENTURER_RANDOMLAYER[5]
		},
		{
			max = 10,
			name = L_ADVENTURER_RANDOMLAYER[6]
		},
		{
			max = 5,
			name = L_ADVENTURER_RANDOMLAYER[7]
		}
	}

	if arg_78_1:getChildByName("jfsl") then
		arg_78_1:getChildByName("jfsl"):removeFromParent()
	end

	if arg_78_1:getChildByName("qwsl") then
		arg_78_1:getChildByName("qwsl"):removeFromParent()
	end

	if arg_78_1:getChildByName("ttsl") then
		arg_78_1:getChildByName("ttsl"):removeFromParent()
	end

	local var_78_1 = "<p></p>"
	local var_78_2 = "<p>%s:<span style=color: rgb(255,210,0);>%d</span>/%d</p>"
	local var_78_3 = RichTextPro:create()

	var_78_3:setSize(22)
	var_78_3:setLineSpace(0)
	var_78_3:setText(var_78_1, nil, true)
	var_78_3:setName("jfsl")
	arg_78_1:addChild(var_78_3)

	local var_78_4 = RichTextPro:create()

	var_78_4:setSize(22)
	var_78_4:setLineSpace(0)
	var_78_4:setText(var_78_1, nil, true)
	var_78_4:setName("qwsl")
	arg_78_1:addChild(var_78_4)

	local var_78_5 = RichTextPro:create()

	var_78_5:setSize(22)
	var_78_5:setLineSpace(0)
	var_78_5:setText(var_78_1, nil, true)
	var_78_5:setName("ttsl")
	arg_78_1:addChild(var_78_5)
	scorearena_manager:get_player_scorearena_data(function(arg_79_0)
		if not tolua.isnull(arg_78_1) and arg_79_0 then
			if arg_79_0.refreshtime then
				arg_78_1:getChildByName("jfsl"):setText(string.format(var_78_2, var_78_0[1].name, arg_79_0.refreshtime, var_78_0[1].max))
				arg_78_1:getChildByName("jfsl"):setPosition(cc.p(10, 60))
			else
				arg_78_1:getChildByName("jfsl"):setText(var_78_1)
			end
		end
	end)
	arena_manager:get_arena_daily_times(function(arg_80_0)
		if not tolua.isnull(arg_78_1) and arg_80_0 then
			if arg_80_0.single then
				arg_78_1:getChildByName("qwsl"):setText(string.format(var_78_2, var_78_0[2].name, var_78_0[2].max - arg_80_0.single, var_78_0[2].max))

				local var_80_0, var_80_1 = arg_78_1:getChildByName("jfsl"):getContentSize()

				arg_78_1:getChildByName("qwsl"):setPosition(cc.p(10, arg_78_1:getChildByName("jfsl"):getPositionY() - var_80_1 - 2))
			else
				arg_78_1:getChildByName("qwsl"):setText(var_78_1)
			end
		end
	end)
	arenatft_manager:get_player_arenatft_info(function(arg_81_0)
		if not tolua.isnull(arg_78_1) and arg_81_0 then
			if arg_81_0.daily_remain_count then
				arg_78_1:getChildByName("ttsl"):setText(string.format(var_78_2, var_78_0[3].name, arg_81_0.daily_remain_count, arg_81_0.daily_total_count))

				local var_81_0, var_81_1 = arg_78_1:getChildByName("qwsl"):getContentSize()

				arg_78_1:getChildByName("ttsl"):setPosition(cc.p(10 + var_81_0, 60))
			else
				arg_78_1:getChildByName("ttsl"):setString("")
			end
		end
	end)

	if not level_manager:isPlayerPassLevel(math.min(UNLOCK_ARENA, UNLOCK_SCOREARENA, UNLOCK_THREE_VS_THREE)) then
		arg_78_1:getChildByName("jfsl"):setVisible(false)
		arg_78_1:getChildByName("qwsl"):setVisible(false)
		arg_78_1:getChildByName("ttsl"):setVisible(false)
	end
end

function ChangeShowLayer:updateExploreOfferTimes(arg_82_1)
	if arg_82_1:getChildByName("richText1") then
		arg_82_1:getChildByName("richText1"):removeFromParent()
	end

	if arg_82_1:getChildByName("richText2") then
		arg_82_1:getChildByName("richText2"):removeFromParent()
	end

	if arg_82_1:getChildByName("richText3") then
		arg_82_1:getChildByName("richText2"):removeFromParent()
	end

	local var_82_0 = "<p></p>"
	local var_82_1 = "<p>%s:<span style=color: rgb(255,210,0);>%d</span>/%d</p>"
	local var_82_2 = RichTextPro:create()

	var_82_2:setSize(22)
	var_82_2:setLineSpace(0)
	var_82_2:setText(var_82_0, nil, true)
	var_82_2:setName("richText1")
	arg_82_1:addChild(var_82_2)

	local var_82_3 = RichTextPro:create()

	var_82_3:setSize(22)
	var_82_3:setLineSpace(0)
	var_82_3:setText(var_82_0, nil, true)
	var_82_3:setName("richText2")
	arg_82_1:addChild(var_82_3)

	local var_82_4 = RichTextPro:create()

	var_82_4:setSize(22)
	var_82_4:setLineSpace(0)
	var_82_4:setText(var_82_0, nil, true)
	var_82_4:setName("richText3")
	arg_82_1:addChild(var_82_4)
	explore_manager:initOfferConfig(function()
		if tolua.isnull(arg_82_1) then
			return
		end

		arg_82_1:getChildByName("richText1"):setText(string.format("<p>%s:%d</p>", L_ADVENTURER_RANDOMLAYER[11], explore_manager:getRunningOfferNum("special")))
		arg_82_1:getChildByName("richText1"):setPosition(cc.p(10, 80))
		arg_82_1:getChildByName("richText1"):setVisible(false)
		arg_82_1:getChildByName("richText2"):setText(string.format(var_82_1, L_ADVENTURER_RANDOMLAYER[9], explore_manager:getRunningOfferNum("daily"), explore_manager:getRunningOfferLimit()))

		local var_83_0, var_83_1 = arg_82_1:getChildByName("richText1"):getContentSize()

		arg_82_1:getChildByName("richText2"):setPosition(cc.p(10, arg_82_1:getChildByName("richText1"):getPositionY() - var_83_1 - 2))
		arg_82_1:getChildByName("richText3"):setText(string.format(var_82_1, L_ADVENTURER_RANDOMLAYER[10], explore_manager:getReadyOfferNum(), explore_manager:getReadyOfferLimit()))

		local var_83_2, var_83_3 = arg_82_1:getChildByName("richText2"):getContentSize()

		arg_82_1:getChildByName("richText3"):setPosition(cc.p(10, arg_82_1:getChildByName("richText2"):getPositionY() - var_83_3 - 2))
	end)

	if activity_return_manager:is_have_catchup_buff(activity_return_manager.BUFF_TYPES.BUFF_PVE_FIGNT_ATTRIBUTE) then
		self:createLimitLevelTip(arg_82_1, L_RETURN_BUFF):setPosition(cc.p(0, arg_82_1:getContentSize().height - 40))
	end
end

function ChangeShowLayer:updateTowerDefenceLevelEndTime(arg_84_1)
	if activity_return_manager:is_have_catchup_buff(activity_return_manager.BUFF_TYPES.BUFF_PVE_FIGNT_ATTRIBUTE) then
		self:createLimitLevelTip(arg_84_1, L_RETURN_BUFF):setPosition(cc.p(0, arg_84_1:getContentSize().height - 40))
	end
end

function ChangeShowLayer:updateLimitTowerDefenceLevelEndTime(arg_85_1)
	if not arg_85_1 then
		return
	end

	local var_85_0 = require("controller.limit_tower_defence_level_manager"):getInstance()

	var_85_0:RequestInfo(function()
		if arg_85_1:getChildByName("endtime_Subs") then
			arg_85_1:getChildByName("endtime_Subs"):removeFromParent()
		end

		local var_86_0 = cc.Label:createWithTTF(L_TVT_NOT_OPEN, "fonts/number.ttf", 22)

		var_86_0:setAnchorPoint(cc.p(0, 0.5))
		var_86_0:setPosition(cc.p(10, 20))
		var_86_0:setName("endtime_Subs")
		arg_85_1:addChild(var_86_0)

		if not var_85_0:checkActive() then
			arg_85_1:getChildByName("endtime_Subs"):setString(var_85_0:getTipsStr())
		else
			local var_86_1 = var_85_0:getEndTime()

			if var_86_1 then
				local var_86_2 = os.date("*t", math.floor(var_86_1))

				arg_85_1:getChildByName("endtime_Subs"):setString((string.format(L_ADVENTURER_RANDOMLAYER[1], var_86_2.year, var_86_2.month, var_86_2.day, var_86_2.hour, var_86_2.min, var_86_2.sec)))
			end
		end
	end)

	if activity_return_manager:is_have_catchup_buff(activity_return_manager.BUFF_TYPES.BUFF_PVE_FIGNT_ATTRIBUTE) then
		self:createLimitLevelTip(arg_85_1, L_RETURN_BUFF):setPosition(cc.p(0, arg_85_1:getContentSize().height - 40))
	end
end

function ChangeShowLayer.updateBtnLables(arg_87_0, arg_87_1, arg_87_2)
	if arg_87_2 ~= "ScoreArenaLayer" and arg_87_2 ~= "ArenaLayer" and arg_87_2 ~= "ThreeVsThreeLayer" then
		return
	end

	local var_87_0 = {
		ScoreArenaLayer = {
			max = 2,
			pos = cc.p(390, 80)
		},
		ArenaLayer = {
			max = 10,
			pos = cc.p(20, 80)
		},
		ThreeVsThreeLayer = {
			max = 5,
			pos = cc.p(390, 120)
		}
	}

	if arg_87_1:getChildByName("jfsl") then
		arg_87_1:getChildByName("jfsl"):removeFromParent()
	end

	local var_87_1 = cc.Label:createWithTTF("", "fonts/number.ttf", 20)

	var_87_1:setAnchorPoint(cc.p(0, 0))
	var_87_1:setName("jfsl")
	var_87_1:setColor(var_0_32)
	var_87_1:enableOutline(cc.c4b(0, 0, 0, 255), 0.5)
	arg_87_1:addChild(var_87_1, 1000)

	local var_87_2 = ccui.ImageView:create("ChangeShowLayer/less_time.png", var_0_1)

	var_87_2:setName("jfslbg")
	arg_87_1:addChild(var_87_2, 99)
	var_87_2:setVisible(false)
	var_87_2:setScale(-1)

	if arg_87_2 == "ScoreArenaLayer" then
		local var_87_3 = os.date("*t", math.floor((time_check_manager:getCurTime())))
		local var_87_4 = 0

		if var_87_3.wday < 7 and var_87_3.wday >= 2 then
			var_87_4 = (5 - (var_87_3.wday - 1)) * 24 * 3600 + (23 - var_87_3.hour) * 3600 + (59 - var_87_3.min) * 60 + (59 - var_87_3.sec)
		elseif var_87_3.wday == 1 then
			var_87_4 = (23 - var_87_3.hour) * 3600 + (59 - var_87_3.min) * 60 + (59 - var_87_3.sec) + 432000
		elseif var_87_3.wday == 7 then
			var_87_4 = (23 - var_87_3.hour) * 3600 + (59 - var_87_3.min) * 60 + (59 - var_87_3.sec) + 518400
		end

		arg_87_1:getChildByName("time"):setString(Global_format_time_str(var_87_4))
		arg_87_1:getChildByName("time"):setPosition(cc.p(90, 120))
		scorearena_manager:get_player_scorearena_data(function(arg_88_0)
			local var_88_9000

			if tolua.isnull(arg_87_1) then
				return
			end

			if arg_88_0 then
				if arg_88_0.refreshtime then
					arg_87_1:getChildByName("jfsl"):setString(string.format(L_QUICK_FIGHT.more, arg_88_0.refreshtime, var_87_0[arg_87_2].max))
					arg_87_1:getChildByName("jfsl"):setPosition(var_87_0[arg_87_2].pos)
					arg_87_1:getChildByName("jfslbg"):setPosition(cc.p(arg_87_1:getChildByName("jfsl"):getPositionX() + var_88_9000 + 8, arg_87_1:getChildByName("jfsl").getPositionY(arg_87_1:getChildByName("jfsl"):getContentSize().width / 2) + arg_87_1:getChildByName("jfsl"):getContentSize().height / 2))

					if arg_87_1:getChildByName("jfslbg").visible ~= false then
						arg_87_1:getChildByName("jfslbg"):setVisible(true)
					end
				else
					arg_87_1:getChildByName("jfsl"):setString("")
				end
			end
		end)
	elseif arg_87_2 == "ArenaLayer" then
		arena_manager:get_fight_data(function(arg_89_0)
			if tolua.isnull(arg_87_1) then
				return
			end

			local var_89_0 = arg_89_0.rank
			local var_89_1 = arg_89_0.class
			local var_89_2 = arg_87_1:getChildByName("time")

			var_89_2:setPosition(cc.p(490, 116))

			if var_89_0 < 0 then
				var_89_2:setString(L_PVP_RESULT_NO_RANK)
			elseif var_89_0 < 1000 then
				var_89_2:setString(string.format("%03d", var_89_0))
			else
				var_89_2:setString(var_89_0)
			end

			if var_89_1 and var_89_1 < 0 then
				var_89_1 = -1 * var_89_1
			end

			if var_89_1 < 1000 then
				arg_87_1:getChildByName("Label_13"):setString(string.format("%04d", var_89_1))
			else
				arg_87_1:getChildByName("Label_13"):setString(string.format("%04d", var_89_1))
			end
		end)
		arena_manager:get_arena_daily_times(function(arg_90_0)
			local var_90_9000

			if tolua.isnull(arg_87_1) then
				return
			end

			if arg_90_0 then
				if arg_90_0.single then
					arg_87_1:getChildByName("jfsl"):setString(string.format(L_QUICK_FIGHT.more, var_87_0[arg_87_2].max - arg_90_0.single, var_87_0[arg_87_2].max))
					arg_87_1:getChildByName("jfsl"):setPosition(var_87_0[arg_87_2].pos)
					arg_87_1:getChildByName("jfslbg"):setPosition(cc.p(arg_87_1:getChildByName("jfsl"):getPositionX() + var_90_9000 + 8, arg_87_1:getChildByName("jfsl").getPositionY(arg_87_1:getChildByName("jfsl"):getContentSize().width / 2) + arg_87_1:getChildByName("jfsl"):getContentSize().height / 2))

					if arg_87_1:getChildByName("jfslbg").visible ~= false then
						arg_87_1:getChildByName("jfslbg"):setVisible(true)
					end
				else
					arg_87_1:getChildByName("jfsl"):setString("")
				end
			end
		end)
	elseif arg_87_2 == "ThreeVsThreeLayer" then
		arenatft_manager:get_season_data(function(arg_91_0)
			if tolua.isnull(arg_87_0) then
				do return end

				local var_91_0 = arg_87_1:getChildByName("jump_btn")
			end

			local var_91_1 = arg_87_1:getChildByName("time")
			local var_91_2 = arenatft_manager:getSeasonLessTime()
			local var_91_3 = L_SEASON_END

			if arenatft_manager:getCurSeason() < 0 then
				var_91_3 = L_TVT_BEHAND_SEASON
			elseif var_91_2 > 0 then
				var_91_3 = L_SEASON_LESS_TIME .. Global_format_time_str(var_91_2)
			else
				arg_87_1:setVisible(false)
			end

			var_91_1:setPosition(cc.p(52, 304))
			var_91_1:setString(var_91_3)

			if arg_87_0.tvtSprite then
				arg_87_0.tvtSprite:update(arenatft_manager:getCurScore())
			else
				arg_87_0.tvtSprite = TvTRankSprite:create(arenatft_manager:getCurScore())

				arg_87_0.tvtSprite:setCascadeOpacityEnabled(true)
				arg_87_0.tvtSprite:setName("tvTRankSprite")
				arg_87_0.tvtSprite:setScale(0.35)
				arg_87_0.tvtSprite:setPosition(cc.p(140, 115))
				arg_87_1:addChild(arg_87_0.tvtSprite)
				arg_87_0.tvtSprite:registerScriptHandler(function(arg_92_0)
					if arg_92_0 == "exit" then
						arg_87_0.tvtSprite = nil
					end
				end)
			end
		end)
		arenatft_manager:get_player_arenatft_info(function(arg_93_0)
			local var_93_9000

			if tolua.isnull(arg_87_1) then
				return
			end

			if arg_93_0 then
				if arg_93_0.daily_remain_count then
					arg_87_1:getChildByName("jfsl"):setString(string.format(L_QUICK_FIGHT.more_2, arg_93_0.daily_remain_count, arg_93_0.daily_total_count))
					arg_87_1:getChildByName("jfsl"):setPosition(var_87_0[arg_87_2].pos)
					arg_87_1:getChildByName("jfslbg"):setPosition(cc.p(arg_87_1:getChildByName("jfsl"):getPositionX() + var_93_9000 + 8, arg_87_1:getChildByName("jfsl").getPositionY(arg_87_1:getChildByName("jfsl"):getContentSize().width / 2) + arg_87_1:getChildByName("jfsl"):getContentSize().height / 2))

					if arg_87_1:getChildByName("jfslbg").visible ~= false then
						arg_87_1:getChildByName("jfslbg"):setVisible(true)
					end
				else
					arg_87_1:getChildByName("jfsl"):setString("")
				end
			end
		end)
	end
end
