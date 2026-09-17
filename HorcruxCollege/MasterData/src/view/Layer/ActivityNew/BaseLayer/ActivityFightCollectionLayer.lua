ActivityFightCollectionLayer = class("ActivityFightCollectionLayer", function()
	return cc.Layer:create()
end)

local var_0_0
local var_0_1 = config._DEBUG and 0 or 1
local item_manager = require("controller.item_manager")
local explore_manager = require("controller.explore_manager")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")

function ActivityFightCollectionLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityFightCollectionLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityFightCollectionLayer:init(arg_3_1)
	self.activityId = arg_3_1.activityId or var_0_0
	self.layerName = "ActivityFightCollectionLayer_" .. self.activityId

	TextureManager:loadLayerTextures({
		self.layerName
	})

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))

	self:addChild(self.rootLayer)

	self.bg = ccui.ImageView:create("mainScenebg/activity/branch" .. self.activityId .. "/" .. self.layerName .. ".png")

	self.bg:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2 - GameDisplay.fix_y)
	self:addChild(self.bg, -1)

	if self.activityId == 838 then
		SwitchManageLayer:switchLayerBGM("sound/anniversary2025")
	else
		SwitchManageLayer:switchLayerBGM("sound/fight")
	end

	self:initUI()
	self:registerActivityEventListener()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			var_0_0 = self.activityId

			activity_manager:releaseEventListenerByName("ActivityFightCollectionLayer")
		end
	end)
end

function ActivityFightCollectionLayer.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("ActivityFightCollectionLayer", activity_manager.activityEventId.UPDATE_ACTIVITY_STATUS_ALERT, function(arg_6_0)
		arg_5_0:updateAlert()
	end)
end

function ActivityFightCollectionLayer:initUI()
	self:initBtnReturn()
	self:initTitle()
	self:initBtns()
	self:updateAlert()
end

function ActivityFightCollectionLayer:initBtnReturn()
	self.btnReturn = self.rootLayer:getChildByName("btn_return")

	self.btnReturn:setAnchorPoint(cc.p(0.5, 0))
	self.btnReturn:setPositionY(-GameDisplay.fix_y)
	self.btnReturn:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
end

function ActivityFightCollectionLayer:initTitle()
	self.btnDetail = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_title")

	if self.btnDetail then
		self.btnDetail:setPositionY(self.btnDetail:getPositionY() + GameDisplay.fix_y)
		self.btnDetail:addTouchEventListener(function(arg_11_0, arg_11_1)
			if arg_11_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopActivityDetail", {
				key = "ActivityFightCollectionLayer_" .. self.activityId
			})
		end)
	end
end

function ActivityFightCollectionLayer:initBtns(arg_12_1)
	self.btnLevel = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_level")

	if self.btnLevel then
		self:unlockActivity("btn_level", self.btnLevel)
		self.btnLevel:addTouchEventListener(function(arg_13_0, arg_13_1)
			if arg_13_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_13_0.unlock then
				self:popWind("btn_level")

				return
			end

			LayerManager:switchShowLayer("ActivityLevelBaseLayer", {
				activityid = self.activityId
			})
		end)
	end

	self.btnWarlevel = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_warlevel")

	if self.btnWarlevel then
		self:unlockActivity("btn_warlevel", self.btnWarlevel)
		self.btnWarlevel:addTouchEventListener(function(arg_14_0, arg_14_1)
			if arg_14_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_14_0.unlock then
				self:popWind("btn_warlevel")

				return
			end

			if self.activityId == 417 then
				if global_get_time_by_date("2022-12-02 00:00:00") > time_check_manager:getCurTime() then
					global_ShowBlockWords("12月2日开启")
				else
					LayerManager:switchShowLayer("LimitTowerDefenceLevelLayer", {
						activityid = 1021
					})
				end
			else
				LayerManager:switchShowLayer("TowerDefenceDetailLayer", {
					activityid = 1021
				})
			end
		end)
	end

	self.btnRandFight = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_randfight")

	if self.btnRandFight then
		self:unlockActivity("btn_randfight", self.btnRandFight)
		self.btnRandFight:addTouchEventListener(function(arg_15_0, arg_15_1)
			if arg_15_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_15_0.unlock then
				self:popWind("btn_randfight")

				return
			end

			if self.activityId == 430 then
				if global_get_time_by_date("2022-01-18 00:00:00") > time_check_manager:getCurTime() then
					global_ShowBlockWords("1月17日后开启")
				else
					LayerManager:switchShowLayer("AdventurerInfiniteLayer")
				end
			else
				LayerManager:switchShowLayer("AdventurerInfiniteLayer")
				RoleDefault:getInstance():setBoolForKey("act_alert_randfight_" .. self.activityId, false)
			end
		end)
	end

	self.btnInfinite = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_Infinite")

	if self.btnInfinite then
		self:unlockActivity("btn_Infinite", self.btnInfinite)
		self.btnInfinite:addTouchEventListener(function(arg_16_0, arg_16_1)
			if arg_16_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_16_0.unlock then
				self:popWind("btn_Infinite")

				return
			end

			if global_get_time_by_date("2023-01-18 00:00:00") > time_check_manager:getCurTime() then
				global_ShowBlockWords("1月17日后开启")
			else
				LayerManager:switchShowLayer("AdventurerInfiniteLayer")
			end
		end)
	end

	self.btnOldSubstite = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_oldsustitute")

	if self.btnOldSubstite then
		self:unlockActivity("btn_oldsustitute", self.btnOldSubstite)
		self.btnOldSubstite:addTouchEventListener(function(arg_17_0, arg_17_1)
			if arg_17_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_17_0.unlock then
				self:popWind("btn_oldsustitute")

				return
			end

			local var_17_0 = 601

			local function var_17_1()
				print("!!!!!!!!!!!!!!")
			end

			local var_17_2 = {
				fight_type = "SUBSTITUTION",
				level = 1
			}

			var_17_2.mode = 601
			var_17_2.chapter = 1
			var_17_2.callback = var_17_1

			function var_17_2.adventuresurecallback()
				LayerManager:pushInLayer("FormationOldSubstituteLayer", {
					returnlayer = "ActivityFightCollectionLayer",
					mode = var_17_0,
					cancelcallback = var_17_1
				})
			end

			var_17_2.initindex = curArray

			LayerManager:pushInLayer("LevelDetailLayer", var_17_2)
		end)
	end

	self.btnPatrol = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_patrol")

	if self.btnPatrol then
		self:unlockActivity("btn_patrol", self.btnPatrol)
		self.btnPatrol:addTouchEventListener(function(arg_20_0, arg_20_1)
			if arg_20_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_20_0.unlock then
				self:popWind("btn_patrol")

				return
			end

			LayerManager:pushInLayer("PatrolFightLayer", {
				activityid = self.activityId
			})
		end)
	end

	self.btnDailyLevel = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_dailylevel")

	if self.btnDailyLevel then
		self:unlockActivity("btn_dailylevel", self.btnDailyLevel)
		self.btnDailyLevel:addTouchEventListener(function(arg_21_0, arg_21_1)
			if arg_21_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_21_0.unlock then
				self:popWind("btn_dailylevel")

				return
			end

			Global_save_day_end_time("activity_reddot_daily_level_" .. self.activityId)
			LayerManager:switchShowLayer("ActivityDailyLevelLayer", {
				activityid = self.activityId
			})
		end)
	end

	self.btnAutoChess = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_autochess")

	if self.btnAutoChess then
		self:unlockActivity("btn_autochess", self.btnAutoChess)
		self.btnAutoChess:addTouchEventListener(function(arg_22_0, arg_22_1)
			if arg_22_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_22_0.unlock then
				self:popWind("btn_autochess")

				return
			end

			LayerManager:switchShowLayer("AutoChessBaseLayer", {
				activityId = self.activityId
			})
		end)
	end

	self.btnBossFight = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_bossfight")

	if self.btnBossFight then
		self:unlockActivity("btn_bossfight", self.btnBossFight)
		self.btnBossFight:addTouchEventListener(function(arg_23_0, arg_23_1)
			if arg_23_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_23_0.unlock then
				self:popWind("btn_bossfight")

				do return end

				if self.activityId >= 500 then
					if self.activityId == 576 then
						LayerManager:switchShowLayer("ActivityNewBossFightBaseLayer", {
							activityId = self.activityId
						})
					else
						if self.activityId == 593 and time_check_manager:getCurTime() < global_get_time_by_date("2024-02-01 00:00:00") then
							global_ShowBlockWords("2月1日后开启")

							return
						end

						LayerManager:switchShowLayer("ActivityBossFightBaseLayer", {
							activityId = self.activityId
						})
					end

					goto label_23_0
				end
			end

			LayerManager:switchShowLayer("AdventurerRandomLayer", {
				modetype = ACTIVITY_ID_TO_MODETYPE_FUNC.boss_fight(self.activityId)
			})

			::label_23_0::

			RoleDefault:getInstance():setBoolForKey("act_alert_randfight_" .. self.activityId, false)
		end)
	end

	self.btnExplore = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_explore")

	if self.btnExplore then
		self:unlockActivity("btn_explore", self.btnExplore)
		self.btnExplore:addTouchEventListener(function(arg_24_0, arg_24_1)
			if arg_24_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_24_0.unlock then
				self:popWind("btn_explore")

				return
			end

			if activity_manager:isHasExploreMapLayer(self.activityId) then
				if require("controller.layerconfig.ui_layer_infos")["ActivityExploreLayer_" .. self.activityId] then
					LayerManager:switchShowLayer("ActivityExploreLayer_" .. self.activityId, {
						activityid = self.activityId
					})
				else
					LayerManager:switchShowLayer("ActivityExploreDefaultLayer", {
						activityid = self.activityId
					})
				end
			else
				activity_manager:get_activity_explore(self.activityId, function(arg_25_0)
					if arg_25_0.result == 1 then
						local var_25_0 = {
							returnLayer = "ActivityFightCollectionLayer",
							type = "activity",
							activityid = self.activityId,
							cancelCallback = function(arg_26_0)
								if arg_26_0 == 2 then
									global_ShowBlockWords(L_EXPLORE_ERROR_NEW[2])
								elseif arg_26_0 == 3 then
									global_ShowBlockWords(L_EXPLORE_ERROR_NEW[3])
								elseif arg_26_0 == 4 then
									global_ShowBlockWords(L_EXPLORE_ERROR_NEW[4])
								elseif arg_26_0 == 5 then
									global_ShowBlockWords(L_EXPLORE_ERROR_NEW[5])
								elseif arg_26_0 == 0 then
									global_ShowBlockWords(L_EXPLORE_ERROR_NEW[6])
								elseif arg_26_0 then
									global_ShowBlockWords(L_EXPLORE_ERROR_NEW[arg_26_0])
								end
							end
						}

						activity_manager:updateActivityAlert("freeexplorer", self.activityId, false)

						var_25_0.activity_explore_id = activity_manager:getCurExploreId(self.activityId)

						explore_manager:begin_explore(var_25_0)
					end
				end)
			end
		end)
	end

	self.pass = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_pass")

	if self.pass then
		self:unlockActivity("btn_pass", self.pass)
		self.pass:addTouchEventListener(function(arg_27_0, arg_27_1)
			if arg_27_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_27_0.unlock then
				self:popWind("btn_pass")

				return
			end

			if self.activityId == 430 then
				if global_get_time_by_date("2023-01-17 00:00:00") > time_check_manager:getCurTime() then
					global_ShowBlockWords("1月17日后开启")
				else
					LayerManager:switchShowLayer("WeeklyTowerEntranceLayer")
				end
			else
				LayerManager:switchShowLayer("WeeklyTowerEntranceLayer")
			end
		end)
	end

	self.btnGarrison = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_garrison")

	if self.btnGarrison then
		self:unlockActivity("btn_garrison", self.btnGarrison)
		self.btnGarrison:addTouchEventListener(function(arg_28_0, arg_28_1)
			if arg_28_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_28_0.unlock then
				self:popWind("btn_garrison")

				return
			end

			LayerManager:switchShowLayer("ActivityGarrisonLayer", {
				activityId = self.activityId
			})
		end)
	end

	self.btnMonopoly = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_monopoly")

	if self.btnMonopoly then
		self:unlockActivity("btn_monopoly", self.btnMonopoly)
		self.btnMonopoly:addTouchEventListener(function(arg_29_0, arg_29_1)
			if arg_29_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_29_0.unlock then
				self:popWind("btn_monopoly")

				return
			end

			LayerManager:switchShowLayer("MonopolyNewLayer", {
				activityid = self.activityId
			})
		end)
	end

	self.btnJumptower = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_jumptower")

	if self.btnJumptower then
		self:unlockActivity("btn_jumptower", self.btnJumptower)
		self.btnJumptower:addTouchEventListener(function(arg_30_0, arg_30_1)
			if arg_30_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_30_0.unlock then
				self:popWind("btn_jumptower")

				return
			end

			LayerManager:switchShowLayer("ActivityJumptowerBaseLayer", {
				activityId = self.activityId
			})
		end)
	end

	self.btnFallGame = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_fallgame")

	if self.btnFallGame then
		self:unlockActivity("btn_fallgame", self.btnFallGame)
		self.btnFallGame:addTouchEventListener(function(arg_31_0, arg_31_1)
			if arg_31_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_31_0.unlock then
				self:popWind("btn_fallgame")

				return
			end

			LayerManager:switchShowLayer("ActivityFallingLayer", {
				activityId = self.activityId
			})
		end)
	end

	self.btnPlaneGame = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_planegame")

	if self.btnPlaneGame then
		self:unlockActivity("btnPlaneGame", self.btnPlaneGame)
		self.btnPlaneGame:addTouchEventListener(function(arg_32_0, arg_32_1)
			if arg_32_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_32_0.unlock then
				self:popWind("btnPlaneGame")

				return
			end

			LayerManager:switchShowLayer("ActivityPlaneWarLayer", {
				activityId = self.activityId
			})
		end)
	end

	self.btnCompareGame = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_comparegame")

	if self.btnCompareGame then
		self:unlockActivity("btnCompareGame", self.btnCompareGame)
		self.btnCompareGame:addTouchEventListener(function(arg_33_0, arg_33_1)
			if arg_33_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_33_0.unlock then
				self:popWind("btnCompareGame")

				return
			end

			LayerManager:switchShowLayer("ActivityMainCompareLayer", {
				activityId = self.activityId
			})
		end)
	end

	self.btnSheepGame = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_sheepgame")

	if self.btnSheepGame then
		self:unlockActivity("btnSheepGame", self.btnSheepGame)
		self.btnSheepGame:addTouchEventListener(function(arg_34_0, arg_34_1)
			if arg_34_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_34_0.unlock then
				self:popWind("btnSheepGame")

				return
			end

			AnalyticManager.sheepGameScore({
				ctype = "enter"
			})
			LayerManager:switchShowLayer("SheepASheepLayer", {
				activityId = self.activityId
			})
		end)
	end

	self.btnHexagon = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_hexagon")

	if self.btnHexagon then
		self:unlockActivity("btnHexagon", self.btnHexagon)
		self.btnHexagon:addTouchEventListener(function(arg_35_0, arg_35_1)
			if arg_35_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_35_0.unlock then
				self:popWind("btnHexagon")

				return
			end

			LayerManager:switchShowLayer("ActivityHexagonDispelLayer", {
				activityId = self.activityId
			})
		end)
	end

	self.btnTowerSwap = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_towerswap")

	if self.btnTowerSwap then
		self:unlockActivity("btn_towerswap", self.btnTowerSwap)
		self.btnTowerSwap:addTouchEventListener(function(arg_36_0, arg_36_1)
			if arg_36_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_36_0.unlock then
				self:popWind("btn_towerswap")

				return
			end

			AnalyticManager.beach_defense_join(nil)
			LayerManager:switchShowLayer("SummerTowerSwapLayer", {
				activityId = self.activityId
			})
		end)
	end

	self.btn_groupfight = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_groupfight")

	if self.btn_groupfight then
		self:unlockActivity("btn_groupfight", self.btn_groupfight)
		self.btn_groupfight:addTouchEventListener(function(arg_37_0, arg_37_1)
			if arg_37_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_37_0.unlock then
				self:popWind("btn_groupfight")

				return
			end

			LayerManager:switchShowLayer("ActivityGroupFightLayer", {
				activityId = self.activityId
			})
		end)
	end

	self.btn_farm = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_farm")

	if self.btn_farm then
		self:unlockActivity("btn_farm", self.btn_groupfight)
		self.btn_farm:addTouchEventListener(function(arg_38_0, arg_38_1)
			if arg_38_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_38_0.unlock then
				self:popWind("btn_farm")

				return
			end

			LayerManager:switchShowLayer("SummerFarmLayer", {
				activityId = self.activityId
			})
		end)
	end

	self.btn_flychess = ccui.Helper:seekWidgetByName(self.rootLayer, "flychess") or ccui.Helper:seekWidgetByName(self.rootLayer, "btn_flychess")

	if self.btn_flychess then
		self:unlockActivity("btn_flychess", self.btn_flychess)
		self.btn_flychess:addTouchEventListener(function(arg_39_0, arg_39_1)
			if arg_39_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_39_0.unlock then
				self:popWind("btn_flychess")

				return
			end

			LayerManager:switchShowLayer("flyChessMainLayer", {
				activityId = self.activityId
			})
		end)
	end

	self.btn_airplane = ccui.Helper:seekWidgetByName(self.rootLayer, "airplane")

	if self.btn_airplane then
		self:unlockActivity("btn_airplane", self.btn_airplane)
		self.btn_airplane:addTouchEventListener(function(arg_40_0, arg_40_1)
			if arg_40_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_40_0.unlock then
				self:popWind("btn_airplane")

				return
			end

			LayerManager:switchShowLayer("AirPlaneLayer")
		end)
	end

	self.btn_bakery = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_bakery")

	if self.btn_bakery then
		self:unlockActivity("btn_bakery", self.btn_bakery)
		self.btn_bakery:addTouchEventListener(function(arg_41_0, arg_41_1)
			if arg_41_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_41_0.unlock then
				self:popWind("btn_bakery")

				return
			end

			LayerManager:switchShowLayer("ActivityBakeryLayer", {
				activityId = self.activityId
			})
		end)
	end

	self.btnWorldBoss = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_worldboss") or ccui.Helper:seekWidgetByName(self.rootLayer, "btn_shijieboss")

	if self.btnWorldBoss then
		self:unlockActivity("btnWorldBoss", self.btnWorldBoss)
		self.btnWorldBoss:addTouchEventListener(function(arg_42_0, arg_42_1)
			if arg_42_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_42_0.unlock then
				self:popWind("btnWorldBoss")

				return
			end

			if self.activityId == 865 and time_check_manager:getCurTime() < global_get_time_by_date("2026-02-16 00:00:00") then
				global_ShowBlockWords("新年荡岁将于2月16号开启~")

				return
			end

			LayerManager:switchShowLayer("ActivityWorldBossBaseLayer", {
				activityId = self.activityId
			})
		end)
	end

	self.btn_bmatch = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_bmatch")

	if self.btn_bmatch then
		self:unlockActivity("btn_bmatch", self.btn_bmatch)
		self.btn_bmatch:addTouchEventListener(function(arg_43_0, arg_43_1)
			if arg_43_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_43_0.unlock then
				self:popWind("btn_bmatch")

				return
			end

			LayerManager:switchShowLayer("ActivityBestComboLayer", {
				activityId = self.activityId
			})
		end)
	end

	self.btn_Rollmachine = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_Rollmachine")

	if self.btn_Rollmachine then
		self:unlockActivity("btn_Rollmachine", self.btn_Rollmachine)
		self.btn_Rollmachine:addTouchEventListener(function(arg_44_0, arg_44_1)
			if arg_44_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_44_0.unlock then
				self:popWind("btn_Rollmachine")

				return
			end

			LayerManager:switchShowLayer("ActivityAlchemyLayer", {
				activityId = self.activityId
			})
		end)
	end

	self.btn_daxigua = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_daxigua")

	if self.btn_daxigua then
		self:unlockActivity("btn_daxigua", self.btn_daxigua)
		self.btn_daxigua:addTouchEventListener(function(arg_45_0, arg_45_1)
			if arg_45_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_45_0.unlock then
				self:popWind("btn_daxigua")

				return
			end

			print("111111111111111")
			LayerManager:switchShowLayer("ActivityHitMouseLayer", {
				activityId = self.activityId
			})
		end)
	end

	self.btnHeCheng = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_hecheng")

	if self.btnHeCheng then
		self:unlockActivity("btnHeCheng", self.btnHeCheng)
		self.btnHeCheng:addTouchEventListener(function(arg_46_0, arg_46_1)
			if arg_46_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_46_0.unlock then
				self:popWind("btnHeCheng")

				return
			end

			LayerManager:switchShowLayer("ActivityExchangeLayer", {
				activityId = self.activityId
			})
		end)
	end

	self.btn_yanchushiyin = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_yanchushiyin")

	if self.btn_yanchushiyin then
		self:unlockActivity("btn_yanchushiyin", self.btn_yanchushiyin)
		self.btn_yanchushiyin:addTouchEventListener(function(arg_47_0, arg_47_1)
			if arg_47_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_47_0.unlock then
				self:popWind("btn_yanchushiyin")

				return
			end

			LayerManager:switchShowLayer("ActivityMusicalNotesLayer", {
				activityId = self.activityId
			})
		end)
	end

	self.btn_zhounianshiyin = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_zhounianshiyin")

	if self.btn_zhounianshiyin then
		self:unlockActivity("btn_zhounianshiyin", self.btn_zhounianshiyin)
		self.btn_zhounianshiyin:addTouchEventListener(function(arg_48_0, arg_48_1)
			if arg_48_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_48_0.unlock then
				self:popWind("btn_zhounianshiyin")

				return
			end

			if time_check_manager:getCurTime() < global_get_time_by_date("2025-10-03 00:00:00") then
				global_ShowBlockWords("周年合奏将于10月3号开启~")

				return
			end

			LayerManager:switchShowLayer("ActivityMusicTouchLayer", {
				activityId = self.activityId
			})
		end)
	end

	self.btn_calculate = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_calculate")

	if self.btn_calculate then
		self:unlockActivity("btn_calculate", self.btn_calculate)
		self.btn_calculate:addTouchEventListener(function(arg_49_0, arg_49_1)
			if arg_49_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_49_0.unlock then
				self:popWind("btn_calculate")

				return
			end

			LayerManager:switchShowLayer("ActivityCalculateLayer", {
				activityId = self.activityId
			})
		end)
	end

	self.btn_catchgift = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_catchgift")

	if self.btn_catchgift then
		self:unlockActivity("btn_catchgift", self.btn_catchgift)
		self.btn_catchgift:addTouchEventListener(function(arg_50_0, arg_50_1)
			if arg_50_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_50_0.unlock then
				self:popWind("btn_catchgift")

				return
			end

			LayerManager:switchShowLayer("ActivityGiftFallLayer", {
				activityId = self.activityId
			})
		end)
	end

	self.btn_springfirecracker = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_springfirecracker")

	if self.btn_springfirecracker then
		self:unlockActivity("btn_springfirecracker", self.btn_springfirecracker)
		self.btn_springfirecracker:addTouchEventListener(function(arg_51_0, arg_51_1)
			if arg_51_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.unlock and not arg_51_0.unlock then
				self:popWind("btn_springfirecracker")

				return
			end

			LayerManager:switchShowLayer("ActivitySpringFirecrackerLayer", {
				activityId = self.activityId
			})
		end)
	end

	local var_12_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "buff")

	if var_12_0 then
		var_12_0:setPositionY(var_12_0:getPositionY() - GameDisplay.fix_y)
	end

	local var_12_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "num_bg")

	if var_12_1 then
		var_12_1:setPositionY(var_12_1:getPositionY() - GameDisplay.fix_y)
		var_12_1:setTouchEnabled(true)
		var_12_1:addTouchEventListener(function(arg_52_0, arg_52_1)
			if arg_52_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:switchShowLayer("ActivityMultiPtLayer", {
				activityId = self.activityId
			})
		end)

		local var_12_2 = var_12_1:getChildByName("num")

		var_12_2:setPositionY(var_12_2:getPositionY() - 8)
		var_12_2:setString(item_manager:getItemNumber((activity_manager:getFightCollectionItemId(self.activityId))))
	end
end

function ActivityFightCollectionLayer:unlockActivity(arg_53_1, arg_53_2)
	local var_53_0 = activity_manager:getCollectionItem(self.activityId, arg_53_1)

	if not var_53_0 then
		return
	end

	local var_53_1 = var_53_0.itemid

	if not var_53_0.itemid then
		arg_53_2.unlock = true

		return
	end

	local var_53_2 = item_manager:getItemNumber(var_53_1)

	self.unlock = true

	local var_53_3 = ccui.ImageView:create("public/button/fight_lock.png", var_0_1)

	var_53_3:setName("lock")

	local var_53_4 = arg_53_2:getContentSize()

	var_53_3:setPosition(var_53_4.width - 30, var_53_4.height + 20)
	var_53_3:setScale(1.5, 1.5)
	var_53_3:setVisible(false)
	arg_53_2:addChild(var_53_3)

	if var_53_2 > 0 then
		var_53_3:setVisible(false)
		arg_53_2:setOpacity(255)

		arg_53_2.unlock = true
	else
		var_53_3:setVisible(true)
		arg_53_2:setOpacity(120)

		arg_53_2.unlock = false
	end
end

function ActivityFightCollectionLayer:popWind(arg_54_1)
	local item_data = require("data.item_data")
	local var_54_1 = activity_manager:getCollectionItem(self.activityId, arg_54_1)

	if not var_54_1 then
		return
	end

	local var_54_2 = var_54_1.itemid

	if not var_54_1.itemid then
		return
	end

	if not var_54_2 then
		hx_print("表里没有" .. arg_54_1 .. "这个按钮的itemid", CONSOLE_COLOR_LIGHT_GOLD)
	end

	local var_54_4 = var_54_1.des or "没有填描述信息"

	LayerManager:pushInLayer("PopDoLayer", {
		labels = {
			titleImage = "title_warorder.png"
		},
		labels = {
			des = var_54_4
		},
		surecallback = function()
			return
		end
	})
end

function ActivityFightCollectionLayer:updateAlert()
	if self.btnDailyLevel and not self.btnDailyLevel.unlock then
		if RoleDefault:getInstance():getIntegerForKey("activity_reddot_daily_level_" .. self.activityId, 0) < time_check_manager:getCurTime() then
			global_add_alert_tag(self.btnDailyLevel, {
				x = 235,
				y = 105
			})
		else
			global_remove_alert_tag(self.btnDailyLevel)
		end
	end

	if self.btnExplore and not self.btnExplore.unlock then
		if activity_manager:getAlertStatus(self.activityId, "freeexplorer") then
			global_add_alert_tag(self.btnExplore, {
				x = 190,
				y = 125
			})
		else
			global_remove_alert_tag(self.btnExplore)
		end
	end
end
