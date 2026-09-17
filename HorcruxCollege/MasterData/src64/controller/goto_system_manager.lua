local playermodel = require("model.playermodel")
local layer_manager = require("controller.layer_manager")
local shop_manager = require("controller.shop_manager")
local shop_currency_data = require("data.shop_currency_data")
local activity_manager = require("controller.activity_manager")

require("view.Layer.ActivityManageLayer")

system_jump_config = {
	DormitoryLayer_group2 = {
		layerName = "DormitoryLayer",
		config = {
			groupId = 2,
			exitCallbackType = "function"
		}
	},
	DormitoryLayer = {
		layerName = "DormitoryLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	ClassupdateLayer = {
		layerName = "ClassupdateLayer",
		config = {
			exitCallbackType = "string"
		}
	},
	AdventureLayer = {
		layerName = "AdventureLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	HorcruxLayer = {
		layerName = "HorcruxLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	TwisteggLayer = {
		layerName = "TwisteggLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	AITwisteggLayer = {
		layerName = "AITwisteggLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	ArenaLayer = {
		layerName = "ArenaLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	MallLayer = {
		layerName = "MallLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	HorcruxCommandLayer = {
		layerName = "HorcruxCommandLayer",
		popLayer = true,
		config = {
			exitCallback = function()
				LayerManager:removePopLayer()
			end
		}
	},
	ActivityLayer = {
		layerName = "ActivityLayer",
		popLayer = true,
		config = {
			exitCallback = function()
				LayerManager:removePopLayer()
			end
		}
	},
	BagPartLayer = {
		layerName = "BagLayerNew",
		config = {
			bagType = 1,
			exitCallbackType = "function"
		}
	},
	BagWeaponLayer = {
		layerName = "BagLayerNew",
		config = {
			bagType = 4,
			exitCallbackType = "function"
		}
	},
	BagMaterialLayer = {
		layerName = "BagLayerNew",
		config = {
			bagType_partition = 1,
			bagType = 2,
			exitCallbackType = "function"
		}
	},
	BagLabLayer = {
		layerName = "BagLayerNew",
		config = {
			bagType_partition = 2,
			bagType = 5,
			exitCallbackType = "function"
		}
	},
	BagFurnitureLayer = {
		layerName = "BagLayerNew",
		config = {
			bagType = 3,
			exitCallbackType = "function"
		}
	},
	MarketLayerCat = {
		layerName = "MarketLayer",
		config = {
			singleMarket = "2-1",
			exitCallbackType = "function"
		}
	},
	MarketLayerTool = {
		layerName = "MarketLayer",
		config = {
			singleMarket = "1-1",
			exitCallbackType = "function"
		}
	},
	MarketLayerRace = {
		layerName = "MarketLayer",
		config = {
			singleMarket = "2-2",
			exitCallbackType = "function"
		}
	},
	MarketLayerSupply = {
		layerName = "MarketLayer",
		config = {
			singleMarket = "1-2",
			exitCallbackType = "function"
		}
	},
	MarketLayerCollection = {
		layerName = "MarketLayer",
		config = {
			singleMarket = "2-3",
			exitCallbackType = "function"
		}
	},
	MarketLayerComponent = {
		layerName = "MarketLayer",
		config = {
			singleMarket = "2-6",
			exitCallbackType = "function"
		}
	},
	MarketLayerSoulCard = {
		layerName = "MarketLayer",
		config = {
			exitCallbackType = "function",
			singleMarket = {
				"1-3",
				"1-56",
				"1-51",
				"1-52",
				"1-53",
				"1-54",
				"1-55"
			}
		}
	},
	MarketLayerTowerDefence = {
		layerName = "MarketLayer",
		config = {
			singleMarket = "1-1999",
			exitCallbackType = "function"
		}
	},
	HandOfMidasLayer = {
		layerName = "HandOfMidasLayer",
		popLayer = true,
		config = {
			exitCallbackType = "function"
		}
	},
	SignLayerNew = {
		layerName = "SignLayerNew",
		popLayer = true,
		config = {
			exitCallback = function()
				LayerManager:removePopLayer()
			end
		}
	},
	MailLayer = {
		layerName = "MailLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	WareHouseLayer = {
		layerName = "WareHouseLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	PhotoFileHelpGirlLayer = {
		layerName = "PhotoFileHelpGirlLayer",
		popLayer = true,
		config = {
			exitCallback = function()
				LayerManager:removePopLayer()
			end
		}
	},
	PhotoGoodsLayer = {
		layerName = "PhotoGoodsLayer"
	},
	TaskLayer = {
		layerName = "TaskLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	PhotoWeaponLayer = {
		layerName = "PhotoWeaponLayer",
		popLayer = true,
		config = {
			exitCallback = function()
				LayerManager:removePopLayer()
			end
		}
	},
	PhotoFileLayer = {
		layerName = "PhotoFileLayer",
		popLayer = true,
		config = {
			exitCallbackType = function()
				LayerManager:removePopLayer()
			end
		}
	},
	EquipLayer = {
		layerName = "EquipLayer",
		popLayer = true,
		config = {
			showtype = 6,
			bottomBtnState = 0,
			layertype = "FightLayer",
			exitCallback = function()
				LayerManager:removePopLayer()
			end
		}
	},
	ActivityMenuLayer = {
		layerName = "ActivityMenuLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	ActivityTaskLayer = {
		layerName = "ActivityTaskLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	LabMenuLayer = {
		layerName = "LabMenuLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	LabMakeNewLayer = {
		layerName = "LabMakeNewLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	EquipLayer_ListButton = {
		layerName = "EquipLayer",
		config = {
			exitCallbackType = "function",
			showtype = 5,
			bottomBtnState = 1,
			layertype = "FightLayer"
		}
	},
	SchoolCinemaLayer = {
		layerName = "SchoolCinemaLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	SchoolTrainLayer = {
		layerName = "SchoolTrainLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	SchoolSwimLayer = {
		layerName = "SchoolSwimLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	SchoolDeanOfficeLayer = {
		layerName = "SchoolDeanOfficeLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	SchoolFileLayer = {
		layerName = "SchoolFileLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	SchoolArchivesLayer = {
		layerName = "SchoolArchivesLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	ActivityEntranceLayer = {
		layerName = "ActivityEntranceLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	RechargeLayer = {
		layerName = "RechargeLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	TopPlotListLayer = {
		popLayer = true,
		layerName = "TopPlotListLayer"
	},
	TopPlotListDailyLayer = {
		layerName = "TopPlotListLayer",
		popLayer = true,
		config = {
			taskType = 2
		}
	},
	TopPlotListWeeklyLayer = {
		layerName = "TopPlotListLayer",
		popLayer = true,
		config = {
			taskType = 12
		}
	},
	FightResultLayerNew = {
		layerName = "FightResultLayerNew",
		popLayer = true,
		config = {
			createItemType = "itemid"
		}
	},
	ScoreArenaLayer = {
		layerName = "ScoreArenaLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	LabMakeLayer = {
		layerName = "LabMakeLayer",
		popLayer = true,
		config = {
			exitCallback = function()
				LayerManager:removePopLayer()
			end
		}
	},
	ActivityExploreLayer_Liuli_Explore = {},
	PopElectricSupplyLayer = {
		popLayer = true,
		layerName = "PopElectricSupplyLayer"
	},
	FightLayer = {
		layerName = "FightLayer"
	},
	ActivityLayer_bianhua_Achieve = {
		layerName = "ActivityLayer_bianhua_Achieve",
		config = {
			exitCallbackType = "function"
		}
	},
	PopShowGirlPageLayer = {
		popLayer = true,
		layerName = "PopShowGirlPageLayer"
	},
	PopAnswerQuestionLayer = {
		popLayer = true,
		layerName = "PopAnswerQuestionLayer"
	},
	ActivityJpCbSignLayer = {
		popLayer = true,
		layerName = "ActivityJpCbSignLayer"
	},
	PopNoviceAwardLayer = {
		popLayer = true,
		layerName = "PopNoviceAwardLayer"
	},
	PopBirthdayPartyLayer = {
		popLayer = true,
		layerName = "PopBirthdayPartyLayer"
	},
	PopPushOpenLayer = {
		popLayer = true,
		layerName = "PopPushOpenLayer"
	},
	PopTGVRechargeInfoLayer = {
		popLayer = true,
		layerName = "PopTGVRechargeInfoLayer"
	},
	ActivitySignFmlLayer = {
		layerName = "ActivitySignBaseLayer",
		popLayer = true,
		config = {
			activityUIObjName = "ActivitySignFmlLayer",
			activityid = 2
		}
	},
	AdventureNewItemLayer = {
		layerName = "AdventureNewItemLayer",
		config = {
			exitCallbackType = "function",
			trialtype = 1,
			layer = 2
		}
	},
	EquipLayer_22120 = {
		layerName = "EquipLayer",
		config = {
			bottomBtnState = 1,
			layertype = "FightLayer",
			exitCallbackType = "function",
			cursoul = 22120,
			showtype = 5
		}
	},
	PopCommunityDonationLayer = {
		layerName = "PopCommunityDonationLayer",
		popLayer = true,
		config = {
			exitCallback = function()
				LayerManager:removePopLayer()
			end
		}
	},
	PopCommunityWishLayer = {
		layerName = "PopCommunityWishLayer",
		popLayer = true,
		config = {
			exitCallback = function()
				LayerManager:removePopLayer()
			end
		}
	},
	BondLayer = {
		popLayer = true,
		layerName = "BondLayer"
	},
	AdventureNewItemLayer_2 = {
		layerName = "AdventureNewItemLayer",
		config = {
			trialtype = 1,
			layer = 2
		}
	},
	AdventureNewItemLayer_3 = {
		layerName = "AdventureNewItemLayer",
		config = {
			trialtype = 2,
			layer = 2
		}
	},
	AdventureNewItemLayer_4 = {
		layerName = "AdventureNewItemLayer",
		config = {
			trialtype = 3,
			layer = 2
		}
	},
	AdventureNewItemLayer_Component = {
		layerName = "AdventureNewItemLayer",
		config = {
			trialtype = 4,
			layer = 2
		}
	},
	BirthdayPartyLayer = {
		layerName = "BirthdayPartyLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	PatrolFightLayer = {
		popLayer = true,
		layerName = "PatrolFightLayer"
	},
	AdventureLayer_guide = {
		layerName = "AdventureLayer",
		config = {
			index = 3,
			ignoreSameLayer = true
		}
	},
	ActivityNoviceTaskLayer = {
		layerName = "NoviceSummaryLayer",
		config = {
			isHideOther = true,
			layerName = "ActivityNoviceTaskLayer"
		}
	},
	PopNovicePasslevelAwardLayer = {
		layerName = "NoviceSummaryLayer",
		config = {
			layerName = "PopNovicePasslevelAwardLayer",
			isHideOther = true,
			type = "wake_fund"
		}
	},
	ReturnActivityGeneralBPLayer = {
		layerName = "ActivityGeneralBPLayer",
		config = {
			activityId = BACKFLOW_BP_ID
		}
	},
	ActivityGameBackGuideLayer = {
		layerName = "ActivityGameBackGuideLayer"
	},
	ActivityGameBackGuideLayer_task = {
		layerName = "ActivityGameBackGuideLayer",
		config = {
			index = 5
		}
	},
	PopActivityReturnSignLayer = {
		popLayer = true,
		layerName = "PopActivityReturnSignLayer"
	},
	NoviceSummaryLayer_ActivityXinxiYaBPLayer = {
		layerName = "NoviceSummaryLayer",
		config = {
			isHideOther = true,
			layerName = "ActivityXinxiYaBPLayer"
		}
	},
	NoviceSummaryLayer_ActivityNoviceThirtyTaskLayer = {
		layerName = "NoviceSummaryLayer",
		config = {
			isHideOther = true,
			layerName = "ActivityNoviceThirtyTaskLayer"
		}
	},
	CompetitionLayer = {
		layerName = "AdventureLayer",
		config = {
			index = 2
		}
	},
	CostumeRoomLayer = {
		layerName = "CostumeRoomLayer"
	},
	MonopolyLayer = {
		layerName = "MonopolyLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	ExpeditionLayer = {
		layerName = "ExpeditionLayer",
		config = {
			exitCallbackType = "function"
		}
	},
	LimitTowerDefenceLevelLayer = {
		layerName = "LimitTowerDefenceLevelLayer"
	},
	PopInviteResidentLayer = {
		layerName = "PopInviteResidentLayer",
		popLayer = true,
		config = {
			exitCallback = function()
				LayerManager:removePopLayer()
			end
		}
	},
	PopTapVoteLayer = {
		popLayer = true,
		layerName = "PopTapVoteLayer"
	},
	RecollectionsLayer = {
		layerName = "RecollectionsLayer",
		popLayer = true,
		customFunc = function()
			require("controller.recollections.recollections_manager"):getInstance():requestOpenLayer()
		end
	},
	RecollectionsSweepstakeLayer = {
		layerName = "RecollectionsSweepstakeLayer",
		popLayer = true,
		customFunc = function()
			require("controller.recollections.recollections_manager"):getInstance():requestOpenLayer()
		end
	},
	ActivityDailyLayer_230 = {
		layerName = "ActivityDailyLayer_230"
	},
	UrbanDefenseLayer_430 = {
		layerName = "UrbanDefenseLayer",
		config = {
			activityId = 430
		}
	},
	PopActivitySurveyLayer_1 = {
		layerName = "PopActivitySurveyLayer",
		popLayer = true,
		config = {
			type = 1
		}
	},
	PopActivitySurveyLayer_2 = {
		layerName = "PopActivitySurveyLayer",
		popLayer = true,
		config = {
			type = 2
		}
	},
	PopPhoneNumberLayer = {
		popLayer = true,
		layerName = "PopPhoneNumberLayer"
	},
	PopActivityReturnDetailLayer = {
		layerName = "PopActivityReturnDetailLayer",
		popLayer = true,
		config = {
			exitCallbackType = "function"
		}
	},
	PopRechargeDailyPrizeLayer = {
		popLayer = true,
		layerName = "PopRechargeDailyPrizeLayer"
	}
}

setmetatable(system_jump_config, {
	__index = function(arg_15_0, arg_15_1)
		if not arg_15_1 then
			return nil
		end

		if arg_15_1:find("MarketLayerActive") then
			local var_15_0 = tonumber(split(arg_15_1, "_")[2])

			if var_15_0 == 13301 then
				return {
					layerName = "MarketLayer",
					config = {
						exitCallbackType = "function",
						singleMarket = {
							shop_currency_data[13301].shop_type,
							shop_currency_data[13302].shop_type
						}
					}
				}
			else
				return {
					layerName = "MarketLayer",
					config = {
						exitCallbackType = "function",
						singleMarket = shop_currency_data[var_15_0].shop_type
					}
				}
			end
		end

		if arg_15_1:find("TwisteggLayerActive") then
			return {
				layerName = "TwisteggLayer",
				config = {
					exitCallbackType = "function",
					initTwisType = tonumber(split(arg_15_1, "_")[2])
				}
			}
		end

		if arg_15_1:find("LevelMapCity") then
			local var_15_1 = tonumber(string.match(arg_15_1, "LevelMapCity(%d+)"))
			local city_data = require("data.city_data")

			if city_data[var_15_1].show_in_levelmap then
				return {
					layerName = "LevelMapLayer",
					config = {
						exitCallbackType = "function",
						initcity = var_15_1
					}
				}
			elseif city_data[var_15_1].show_in_levelmapbox then
				return {
					layerName = "LevelMapSingleLayer",
					config = {
						cityid = var_15_1
					}
				}
			elseif city_data[var_15_1].show_in_specialmapbox then
				return {
					layerName = "SpecialOperationLayer",
					config = {
						initcity = var_15_1
					}
				}
			end
		end

		if arg_15_1:find("ActivityLevelLayer") then
			local var_15_3 = tonumber(string.match(arg_15_1, "ActivityLevelLayer(%d+)"))

			return {
				layerName = "ActivityLevelLayer",
				config = {
					exitCallbackType = "function",
					initcity = var_15_3,
					activityid = require("data.city_data")[var_15_3].is_activity_city
				}
			}
		end

		if arg_15_1:find("ActivityLevelBaseLayer") then
			local var_15_4 = tonumber(string.match(arg_15_1, "ActivityLevelBaseLayer(%d+)"))

			if require("data.activity_conf_data")[var_15_4].modeType then
				return {
					layerName = "ActivityDailyLevelLayer",
					config = {
						activityid = var_15_4
					}
				}
			else
				return {
					layerName = "ActivityLevelBaseLayer",
					config = {
						activityid = var_15_4
					}
				}
			end
		end

		if arg_15_1:find("ActivityUmaruLevelLayer") then
			local var_15_5 = tonumber(string.match(arg_15_1, "ActivityUmaruLevelLayer(%d+)")) or 1

			return {
				layerName = "ActivityUmaruLevelLayer",
				config = {
					initcitytype = 137,
					initcity = 13701 + math.floor((var_15_5 - 1) / 3) * 3,
					initdifficulty = (var_15_5 - 1) % 3 + 1
				}
			}
		end

		if arg_15_1:find("MonopolyLayer") then
			local var_15_6 = tonumber(string.match(arg_15_1, "MonopolyLayer(%d+)")) or 118

			return {
				layerName = "MonopolyLayer",
				config = {
					inittype = var_15_6,
					jumpid = 4001000 + var_15_6
				}
			}
		end

		if arg_15_1:find("ExpeditionLayer") then
			local var_15_7 = tonumber(string.match(arg_15_1, "ExpeditionLayer(%d+)")) or 119

			return {
				layerName = "ExpeditionLayer",
				config = {
					inittype = var_15_7,
					jumpid = 4002000 + var_15_7
				}
			}
		end

		if arg_15_1:find("PopActivityShareBaseLayer") then
			local var_15_8 = tonumber(string.match(arg_15_1, "PopActivityShareBaseLayer(%d+)")) or 119

			return {
				layerName = "PopActivityShareBaseLayer",
				popLayer = true,
				config = {
					activityId = var_15_8
				}
			}
		end

		if arg_15_1:find("TowerDefenceLevelLayer") then
			return {
				layerName = "TowerDefenceLevelLayer",
				config = {
					activityid = tonumber(string.match(arg_15_1, "TowerDefenceLevelLayer(%d+)"))
				}
			}
		end

		if arg_15_1:find("ActivityRouletteLayer") then
			local var_15_9 = tonumber(string.match(arg_15_1, "ActivityRouletteLayer_(%d+)"))

			if var_15_9 == 731 then
				LayerManager:switchShowLayer("CommonRouletteLayer", {
					activityId = var_15_9
				})

				return
			end

			return {
				layerName = "ActivityRouletteBaseLayer",
				config = {
					activityId = var_15_9
				}
			}
		end

		if arg_15_1:find("AdventurerRandomLayer") then
			return {
				layerName = "AdventurerRandomLayer",
				config = {
					activityId = tonumber(string.match(arg_15_1, "ActivityRouletteLayer_(%d+)"))
				}
			}
		end

		if arg_15_1:find("BigAvtivity") then
			return {
				layerName = "BigAvtivity",
				popLayer = true,
				config = {
					activityid1 = split(arg_15_1, "_")[2],
					activityid2 = split(arg_15_1, "_")[3],
					exitCallback = function()
						LayerManager:removePopLayer()
					end
				}
			}
		end

		if arg_15_1:find("PopDailyRechargeLayer") then
			return {
				layerName = "PopDailyRechargeLayer",
				popLayer = true,
				config = {
					activityId = tonumber(string.match(arg_15_1, "PopDailyRechargeLayer(%d+)"))
				}
			}
		elseif arg_15_1:find("RechargeLayer") then
			return {
				layerName = "RechargeLayer",
				config = {
					exitCallbackType = "function",
					initSelectPage = tonumber(split(arg_15_1, "_")[2])
				}
			}
		end

		if arg_15_1:find("ActivityRechargeTemplate") then
			local var_15_10 = {}
			local var_15_12
			local var_15_11

			if string.find(arg_15_1, "@") then
				for iter_15_0, iter_15_1 in pairs(string.split(arg_15_1, "@")) do
					if iter_15_0 == 1 then
						arg_15_1 = iter_15_1
					else
						table.insert(var_15_10, iter_15_1)
					end
				end

				var_15_11 = {
					layerName = "ActivityRechargeTemplate",
					popLayer = true
				}
				var_15_12 = {}
			end

			var_15_12.activityID = tonumber(split(arg_15_1, "_")[2])
			var_15_12.showmodule = var_15_10
			var_15_11.config = var_15_12

			return var_15_11
		end

		if arg_15_1:find("shopTimeLimitLayer") then
			local activity_manager = require("controller.activity_manager")
			local var_15_14 = tonumber(split(arg_15_1, "_")[2])
			local var_15_15 = tonumber(split(arg_15_1, "_")[3])
			local time_check_manager = require("controller.time_check_manager")
			local recharge_data = require("data.recharge_data")
			local var_15_18 = require("controller.supermarket_manager"):getAllShopTimeLimitList()

			if var_15_18[var_15_14] and var_15_18[var_15_14][1].uitype == 1 then
				return {
					layerName = "PopShopTimeLimitNewLayer",
					popLayer = true,
					config = {
						list = var_15_18[var_15_14]
					}
				}
			elseif var_15_15 and var_15_15 == 35 then
				return {
					layerName = "PopShopTimeLimitNewLayer",
					popLayer = true,
					config = {
						list = var_15_18[var_15_14]
					}
				}
			elseif string.find(arg_15_1, "@") then
				local var_15_19 = {
					tablist = {}
				}

				print(arg_15_1)

				for iter_15_2, iter_15_3 in pairs(string.split(arg_15_1, "@")) do
					print(iter_15_2, iter_15_3)

					if iter_15_2 == 1 then
						var_15_19.tab = tonumber(string.split(iter_15_3, "_")[2])

						table.insert(var_15_19.tablist, tonumber(string.split(iter_15_3, "_")[2]))
					else
						table.insert(var_15_19.tablist, tonumber(iter_15_3) % 1700000)
					end
				end

				print(dump(var_15_19))

				return {
					layerName = "PopSupermarketLayer",
					popLayer = true,
					config = var_15_19
				}
			else
				for iter_15_4, iter_15_5 in pairs((require("data.supermarket_tab_data"))) do
					if (iter_15_5.type == 5 or iter_15_5.type == 106) and iter_15_5.param == var_15_14 then
						return {
							layerName = "PopSupermarketLayer",
							popLayer = true,
							config = {
								tab = iter_15_5.id
							}
						}
					end
				end
			end
		end

		if arg_15_1:find("ActivitySignTemplateLayer") then
			return {
				layerName = "ActivitySignBaseLayer",
				popLayer = true,
				config = {
					exitCallbackType = "function",
					activityUIObjName = "ActivitySignTemplateLayer",
					activityid = tonumber(split(arg_15_1, "_")[2])
				}
			}
		end

		if arg_15_1:find("activityFlop") then
			local var_15_20 = tonumber(split(arg_15_1, "_")[2])

			if var_15_20 == 730 then
				LayerManager:switchShowLayer("CommonFlopLayer", {
					activityId = var_15_20
				})

				return
			end

			if var_15_20 >= 457 and var_15_20 ~= 458 then
				LayerManager:switchShowLayer("ActivityFlipBaseLayer", {
					activityId = var_15_20
				})

				return
			end

			if not require("controller.layerconfig.ui_layer_infos")["ActivityFlopLayer_" .. var_15_20] then
				return {
					layerName = "ActivityFlopDefaultLayer",
					config = {
						activityid = var_15_20
					}
				}
			else
				return {
					layerName = "ActivityFlopLayer_" .. var_15_20,
					config = {
						activityid = var_15_20
					}
				}
			end
		end

		if arg_15_1:find("ActivityPTLayer") then
			return {
				layerName = "ActivityPTBaseLayer",
				config = {
					activityid = tonumber(split(arg_15_1, "_")[2])
				}
			}
		end

		if arg_15_1:find("ActivityBattlePassLayer") then
			local var_15_21 = tonumber(string.match(arg_15_1, "ActivityBattlePassLayer(%d+)"))

			if var_15_21 == 136 then
				return {
					layerName = "ActivityXinxiYaBPLayer"
				}
			else
				return {
					layerName = "ActivityGeneralBPLayer",
					config = {
						activityId = var_15_21
					}
				}
			end
		end

		if arg_15_1:find("ActivityWordCollection") then
			return {
				layerName = "ActivityWordCollectionBaseLayer",
				config = {
					activityId = tonumber(split(arg_15_1, "_")[2])
				}
			}
		end

		if arg_15_1:find("ActivityMainLayer_") then
			local var_15_22 = tonumber(split(arg_15_1, "_")[2])

			if not require("controller.layerconfig.ui_layer_infos")["ActivityMainLayer_" .. var_15_22] then
				return {
					layerName = "ActivityMainDefaultLayer",
					config = {
						activityid = var_15_22
					}
				}
			else
				return {
					layerName = "ActivityMainLayer_" .. var_15_22
				}
			end
		end

		if arg_15_1:find("PopRechargeIconLayer") then
			return {
				layerName = "PopRechargeIconLayer",
				popLayer = true,
				config = {
					big_group = tonumber(string.match(arg_15_1, "PopRechargeIconLayer(%d+)"))
				}
			}
		end

		if arg_15_1:find("PopShowGirlPageLayer") then
			local var_15_23 = {}

			if string.find(arg_15_1, "@") then
				for iter_15_6, iter_15_7 in pairs(string.split(arg_15_1, "@")) do
					if iter_15_6 == 1 then
						arg_15_1 = iter_15_7
					else
						table.insert(var_15_23, iter_15_7)
					end
				end
			end

			local var_15_24 = tonumber(split(arg_15_1, "_")[2])

			return {
				layerName = "PopShowGirlPageLayer",
				popLayer = true,
				config = {
					id = tonumber(split(arg_15_1, "_")[2]),
					showmodule = var_15_23
				}
			}
		end

		if arg_15_1:find("PopBirthdayPartyLayer") then
			local var_15_25 = {}

			if string.find(arg_15_1, "@") then
				for iter_15_8, iter_15_9 in pairs(string.split(arg_15_1, "@")) do
					if iter_15_8 == 1 then
						arg_15_1 = iter_15_9
					else
						table.insert(var_15_25, iter_15_9)
					end
				end
			end

			local var_15_26 = tonumber(split(arg_15_1, "_")[2])

			return {
				layerName = "PopBirthdayPartyLayer",
				popLayer = true,
				config = {
					id = tonumber(split(arg_15_1, "_")[2]),
					showmodule = var_15_25
				}
			}
		end

		if arg_15_1:find("ActivityTimeSignTemplateLayer") then
			return {
				layerName = "ActivityTimeSignTemplateLayer",
				popLayer = true,
				config = {
					activityid = tonumber(string.match(arg_15_1, "ActivityTimeSignTemplateLayer(%d+)"))
				}
			}
		end

		if arg_15_1:find("ActivitySpecialEntranceLayer") then
			return {
				layerName = "ActivitySpecialEntranceLayer",
				config = {
					showtype = tonumber(string.match(arg_15_1, "ActivitySpecialEntranceLayer(%d+)"))
				}
			}
		end

		if arg_15_1:find("PopAnswerQuestionLayer") then
			return {
				layerName = "PopAnswerQuestionLayer",
				popLayer = true,
				config = {
					activityid = tonumber(string.match(arg_15_1, "PopAnswerQuestionLayer(%d+)"))
				}
			}
		end

		if arg_15_1:find("SupermarketLayer") then
			return {
				layerName = "SupermarketLayer",
				config = {
					tab = tonumber(string.match(arg_15_1, "SupermarketLayer(%d+)"))
				}
			}
		end

		if arg_15_1:find("ActivityWakefundBaseLayer_") then
			local var_15_27 = tonumber(string.match(arg_15_1, "ActivityWakefundBaseLayer_(%d+)"))
			local var_15_28 = "ActivityWakefundBaseLayer"

			if var_15_27 == 406 then
				var_15_28 = "ActivityWakefundBaseLayer2"
			end

			if var_15_27 == 486 then
				var_15_28 = "ActivityWakefundBaseLayer3"
			end

			return {
				layerName = "NoviceSummaryLayer",
				config = {
					isHideOther = true,
					type = "wake_fund",
					layerName = (var_15_27 == 710 or nil) and "ActivityWakefundBaseLayer4",
					activityid = var_15_27
				}
			}
		end

		if arg_15_1:find("Equiplayer") then
			return {
				layerName = "EquipLayer",
				config = {
					bottomBtnState = 1,
					intoType = "ListButtonLayer",
					layertype = "FightLayer",
					showtype = 5,
					cursoul = tonumber(string.match(arg_15_1, "Equiplayer(%d+)"))
				}
			}
		end

		if arg_15_1:find("ActivityMultiPtLayer") then
			return {
				layerName = "ActivityMultiPtLayer",
				config = {
					activityId = tonumber(string.match(arg_15_1, "ActivityMultiPtLayer(%d+)"))
				}
			}
		end

		if arg_15_1:find("ActivityArtLayer_") then
			return {
				layerName = "ActivityArtBaseLayer",
				config = {
					activityid = tonumber(string.match(arg_15_1, "ActivityArtLayer_(%d+)"))
				}
			}
		end

		if arg_15_1:find("PopSkinAccessLayer") then
			return {
				layerName = "PopSkinAccessLayer",
				popLayer = true,
				config = {
					activityId = tonumber(string.match(arg_15_1, "PopSkinAccessLayer_(%d+)")) or 298
				}
			}
		end

		if arg_15_1:find("ActivityFightCollectionLayer") then
			return {
				layerName = "ActivityFightCollectionLayer",
				config = {
					activityId = tonumber(string.match(arg_15_1, "ActivityFightCollectionLayer_(%d+)")) or 298
				}
			}
		end

		if arg_15_1:find("PopActivityBpSignLayer") then
			return {
				layerName = "PopActivityBpSignLayer",
				popLayer = true,
				config = {
					activityId = tonumber(string.match(arg_15_1, "PopActivityBpSignLayer_(%d+)")) or 298
				}
			}
		end

		if arg_15_1:find("AutoChessBaseLayer") then
			return {
				layerName = "AutoChessBaseLayer",
				config = {
					activityId = tonumber(string.match(arg_15_1, "AutoChessBaseLayer_(%d+)")) or 323
				}
			}
		end

		if arg_15_1:find("ActivityJumptowerBaseLayer") then
			return {
				layerName = "ActivityJumptowerBaseLayer",
				config = {
					activityId = tonumber(string.match(arg_15_1, "ActivityJumptowerBaseLayer_(%d+)")) or 500
				}
			}
		end

		if arg_15_1:find("ActivityBachelorBaseLayer") then
			return {
				layerName = "ActivityBachelorBaseLayer",
				config = {
					activityId = tonumber(string.match(arg_15_1, "ActivityBachelorBaseLayer(%d+)")) or 500
				}
			}
		end

		if arg_15_1:find("PopActivityFeedBackLayer") then
			return {
				layerName = "PopActivityFeedBackLayer",
				popLayer = true,
				config = {
					activityId = tonumber(string.match(arg_15_1, "PopActivityFeedBackLayer(%d+)"))
				}
			}
		end

		if arg_15_1:find("ActivityPopBaseLayer") then
			return {
				layerName = "ActivityPopBaseLayer",
				popLayer = true,
				config = {
					id = tonumber(string.match(arg_15_1, "ActivityPopBaseLayer(%d+)"))
				}
			}
		end

		return nil
	end
})

local var_0_6 = {
	MainLayer = 0,
	PhotoWeaponLayer = 0,
	EquipLayer = 0,
	SchoolDeanOfficeLayer = 0,
	SignLayer = 0,
	MailLayer = 0,
	FightResultLayerNew = 0,
	ActivityPointLayer = 0,
	MarketLayerRace = 0,
	ActivityEntranceLayer = 0,
	SignLayerNew = 0,
	ClassupdateLayer = 0,
	MarketLayerSupply = 0,
	TopPlotListWeeklyLayer = 0,
	SchoolCinemaLayer = 0,
	MarketLayerCollection = 0,
	ActivityExploreLayer_Liuli_Explore = 0,
	HandOfMidasLayer = 0,
	ActivityLayer = 0,
	SchoolFileLayer = 0,
	RechargeLayer = 0,
	TopPlotListLayer = 0,
	ActivityMenuLayer = 0,
	SchoolArchivesLayer = 0,
	ActivityTaskLayer = 0,
	TopPlotListDailyLayer = 0,
	TaskLayer = 0,
	ChooseLayer = 0,
	ScoreArenaLayer = UNLOCK_SCOREARENA,
	PhotoMemoryLayer = UNLOCK_PHOTO,
	PhotoFileLayer = UNLOCK_PHOTO,
	PhotoGoodsLayer = UNLOCK_PHOTO,
	PhotoFileHelpGirlLayer = UNLOCK_PHOTO,
	TwisteggLayer = UNLOCK_TWIST,
	HelpfigureLayer = UNLOCK_HELP,
	BagLayerNew = UNLOCK_BAG,
	AdventureLayer = UNLOCK_AD,
	DormitoryLayer = UNLOCK_FAVOR,
	DormitoryLayer_5 = UNLOCK_FAVOR,
	GoodwellLayer = UNLOCK_FAVOR,
	SmeltLayer = UNLOCK_SMELT,
	ArenaLayer = UNLOCK_ARENA,
	RankLayer = UNLOCK_RANK,
	MarketLayer = UNLOCK_SHOP,
	HorcruxLayer = UNLOCK_HELP,
	HorcruxCommandLayer = UNLOCK_LAB,
	BagPartLayer = UNLOCK_BAG,
	BagWeaponLayer = UNLOCK_BAG,
	BagMaterialLayer = UNLOCK_BAG,
	BagFurnitureLayer = UNLOCK_BAG,
	WareHouseLayer = UNLOCK_BAG,
	MarketLayerActive = UNLOCK_SHOP,
	LabMenuLayer = UNLOCK_LAB,
	SchoolAreaLayer = UNLOCK_SCHOOL,
	SchoolTrainLayer = UNLOCK_SCHOOL_TRAIN,
	SchoolSwimLayer = UNLOCK_SCHOOL_SWIM,
	LabMakeLayer = UNLOCK_LAB,
	ThreeVsThreeLayer = UNLOCK_THREE_VS_THREE,
	AdventureNewItemLayer_3 = UNLOCK_ADVENTURENEWITEMLAYER_2,
	AdventureNewItemLayer_4 = UNLOCK_ADVENTURENEWITEMLAYER_2
}

setmetatable(var_0_6, {
	__index = function(arg_17_0, arg_17_1)
		if not arg_17_1 then
			return nil
		end

		if arg_17_1:find("MarketLayerActive") then
			return UNLOCK_SHOP
		end

		if arg_17_1:find("TwisteggLayerActive") then
			return UNLOCK_TWIST
		end

		if arg_17_1:find("ExploreMapLayer") then
			return UNLOCK_EXPLORE
		end

		if arg_17_1:find("ActivityMainLayer_") then
			local var_17_0 = string.match(arg_17_1, "^ActivityMainLayer_(%d+)$")

			if var_17_0 then
				local var_17_1, var_17_2 = pcall(require, string.format("data.activity_%s.activity_entrance_%s_data", var_17_0, var_17_0))

				if var_17_1 and var_17_2 and next(var_17_2) then
					for iter_17_0, iter_17_1 in pairs(var_17_2) do
						if iter_17_1 and iter_17_1.jump and tonumber(iter_17_1.jump) >= 2900000 and tonumber(iter_17_1.jump) <= 2999999 then
							return iter_17_1.unlocklevel
						end
					end
				end
			end
		end

		return nil
	end
})

local var_0_7 = L_SYSTEM_UNLOCK_WORD

setmetatable(L_SYSTEM_UNLOCK_WORD, {
	__index = function(arg_18_0, arg_18_1)
		if not arg_18_1 then
			return nil
		end

		if arg_18_1:find("MarketLayerActive") then
			return L_SHOP
		end

		if arg_18_1:find("TwisteggLayerActive") then
			return L_TWISTEGG
		end

		if arg_18_1:find("ExploreMapLayer") then
			return L_EXPLORE
		end

		if arg_18_1:find("ActivityMainLayer") then
			return L_ACTIVITY
		end

		return nil
	end
})

local var_0_8 = {}
local var_0_9 = {
	MainLayer = true,
	DormitoryLayer = true,
	FightLayer = true
}
local var_0_10 = {
	{
		501,
		503,
		504,
		505
	}
}

local function var_0_11(arg_19_0, arg_19_1)
	if not arg_19_0 then
		return false
	end

	if not arg_19_1 then
		return false
	end

	if type(arg_19_0) == "string" then
		arg_19_0 = tonumber(arg_19_0)
	end

	if type(arg_19_1) == "string" then
		arg_19_1 = tonumber(arg_19_1)
	end

	for iter_19_0, iter_19_1 in pairs(var_0_10) do
		local var_19_0 = false
		local var_19_1 = false

		for iter_19_2, iter_19_3 in pairs(iter_19_1) do
			if arg_19_0 == iter_19_3 then
				var_19_0 = true
			end

			if arg_19_1 == iter_19_3 then
				var_19_1 = true
			end
		end

		if var_19_0 and var_19_1 then
			return true
		end
	end

	return false
end

function createExitCallback(arg_20_0, arg_20_1)
	return
end

local function var_0_12()
	local activity_img_data = require("data.activity_img_data")
	local var_21_1 = 4
	local var_21_2 = activity_manager:getActivityObj(4)

	if not var_21_2 then
		return
	end

	if var_21_2:getStatus() ~= 2 then
		global_ShowBlockWords(L_ACTIVITY_CLOSE)

		return
	end

	if not var_21_2._explore then
		return
	end

	var_21_2:get_activity_explore(function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 == 1 then
			if arg_22_2 then
				require("controller.explore_manager"):begin_explore({
					returnLayer = "MainLayer",
					type = "activity",
					activity_explore_id = arg_22_2,
					cancelCallback = function()
						self.ActivityExploreIcon:setBright(true)
					end
				})
			else
				LayerManager:switchShowLayer("ActivityExploreLayer", {
					activityid = var_21_1,
					explore_info = arg_22_1
				})
			end
		end
	end)
end

function goto_complete_system(arg_24_0)
	print("跳转信息", dump(arg_24_0))

	local var_24_0 = arg_24_0.jump_to_system

	if type(arg_24_0.jump_to_system) == "string" and not var_24_0:find("@") then
		var_24_0 = tonumber(var_24_0)
	end

	if var_24_0 == -1 then
		global_ShowBlockWords(L_NO_WAY_GET)

		return
	end

	if config.debug and SYSTEMID[var_24_0] == "DEPRECATED" then
		global_ShowBlockWords("该跳转id已经弃用！")

		return
	end

	if not SYSTEMID[var_24_0] then
		if config._DEBUG then
			global_ShowBlockWords("这个id未在SYSTEMID定义" .. var_24_0, cc.c3b(255, 0, 0))
			print("这个id未在SYSTEMID定义" .. var_24_0)
		else
			global_ShowBlockWords(L_PHOTOFILE_HELPGIRL_FORBID_POINT)
		end

		return
	end

	if var_24_0 == 140 then
		LayerManager:pushInLayer("MailLayer")

		return
	end

	if var_0_11(var_24_0, arg_24_0.cur_system_id) then
		global_ShowBlockWords(L_CANNOT_JUMP_SAME)

		return
	end

	local level_manager = require("controller.level_manager")

	if var_0_6[SYSTEMID[var_24_0]] and not level_manager:isPlayerPassLevel(var_0_6[SYSTEMID[var_24_0]]) then
		if type(var_0_6[SYSTEMID[var_24_0]]) == "number" and var_0_6[SYSTEMID[var_24_0]] < 0 then
			global_ShowBlockWords(L_NO_OPEN)
		else
			global_ShowBlockWords(string.format(L_FINISH_LEVEL_UNLOCK, "", level_manager:formatModeChapterLevelByPlayerLevel(var_0_6[SYSTEMID[var_24_0]]), var_0_7[SYSTEMID[var_24_0]]))
		end

		return
	else
		if SYSTEMID[var_24_0] == "ActivityExploreLayer_Liuli_Explore" then
			var_0_12()

			return
		end

		local var_24_2
		local var_24_3

		if system_jump_config[SYSTEMID[var_24_0]] then
			if system_jump_config[SYSTEMID[var_24_0]].popLayer then
				local var_24_4 = arg_24_0.config or global_deepCopy(system_jump_config[SYSTEMID[var_24_0]].config)

				if system_jump_config[SYSTEMID[var_24_0]].layerName == "BigAvtivity" then
					activity_manager:createActivitySignLayer(tonumber(var_24_4.activityid1), tonumber(var_24_4.activityid2), {})
				else
					if system_jump_config[SYSTEMID[var_24_0]].customFunc then
						system_jump_config[SYSTEMID[var_24_0]].customFunc()

						return SYSTEMID[var_24_0]
					end

					if arg_24_0.config then
						if type(system_jump_config[SYSTEMID[var_24_0]].config) == "table" and next(system_jump_config[SYSTEMID[var_24_0]].config) then
							for iter_24_0, iter_24_1 in pairs(system_jump_config[SYSTEMID[var_24_0]].config) do
								var_24_4[iter_24_0] = var_24_4[iter_24_0] or global_deepCopy(iter_24_1)
							end
						else
							var_24_4 = global_deepCopy(system_jump_config[SYSTEMID[var_24_0]].config)
						end
					end

					LayerManager:pushInLayer(system_jump_config[SYSTEMID[var_24_0]].layerName, var_24_4)

					return system_jump_config[SYSTEMID[var_24_0]].layerName
				end
			else
				local var_24_5 = arg_24_0.config or global_deepCopy(system_jump_config[SYSTEMID[var_24_0]].config)

				if arg_24_0.config then
					if type(system_jump_config[SYSTEMID[var_24_0]].config) == "table" and next(system_jump_config[SYSTEMID[var_24_0]].config) then
						for iter_24_2, iter_24_3 in pairs(system_jump_config[SYSTEMID[var_24_0]].config) do
							var_24_5[iter_24_2] = var_24_5[iter_24_2] or global_deepCopy(iter_24_3)
						end
					else
						var_24_5 = global_deepCopy(system_jump_config[SYSTEMID[var_24_0]].config) or var_24_5
					end
				end

				var_24_2 = system_jump_config[SYSTEMID[var_24_0]].layerName
				var_24_3 = var_24_5
			end
		else
			var_24_2 = SYSTEMID[var_24_0]
		end

		layer_manager:switchShowLayer(var_24_2, var_24_3)

		return var_24_2
	end
end

local function var_0_13()
	var_0_8 = {}
end

function gotoSystem_updateStack(arg_26_0)
	if var_0_9[arg_26_0] then
		var_0_13()
	end
end
