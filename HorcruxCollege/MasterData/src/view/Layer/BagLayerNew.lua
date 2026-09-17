BagLayerNew = class("BagLayerNew", function()
	return cc.Layer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Sprite.FilterSprite")
require("view.Sprite.FilterListSprite")
require("view.Sprite.TitleSprite")
require("view.Layer.PopLayer")
require("controller.goto_system_manager")
require("view.Sprite.ConfirmDialogSprite")

local FilterItemsPanelParts = require("view.Sprite.FilterItemsPanelParts")
local playermodel = require("model.playermodel")
local drop_data = require("data.drop_data")
local item_data = require("data.item_data")
local major_factor_data = require("data.major_factor_data")
local audio_manager = require("controller.audio_manager")
local bag_manager = require("controller.bag_manager")
local component_manager = require("controller.component_manager")
local dormitory_manager = require("controller.dormitory_manager")
local drop_manager = require("controller.drop_manager")
local filter_config_manager = require("controller.filter_config_manager")
local grade_manager = require("controller.grade_manager")
local horcrux_manager = require("controller.horcrux_manager")
local item_manager = require("controller.item_manager")
local activity_return_manager = require("controller.activity_return_manager")
local time_check_manager = require("controller.time_check_manager")
local LocalEvent = require("common.LocalEvent")
local network = require("network.network")
local var_0_18 = config._DEBUG and 0 or 1
local var_0_19 = 1
local var_0_20 = 2
local var_0_21 = 3
local var_0_22 = 5
local var_0_24 = 640
local var_0_25 = 204
local var_0_26 = 0
local var_0_27 = 1
local var_0_28 = 0.3
local var_0_29 = 0.2
local var_0_30 = 1
local var_0_31 = 2

baglayernewInstance = nil

function BagLayerNew.create(arg_2_0, arg_2_1)
	local var_2_0 = BagLayerNew.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function BagLayerNew.getInstance()
	return baglayernewInstance
end

function BagLayerNew:init(arg_4_1)
	local var_4_0 = RoleDefault:getInstance():getIntegerForKey("lastReturnBagType", 1)

	if arg_4_1 then
		var_4_0 = arg_4_1.bagType
		self.selectType = arg_4_1.selectType
		self.hideItem = arg_4_1.hideItem
	end

	baglayernewInstance = self

	if arg_4_1 then
		self.exitCallback = arg_4_1.exitCallback
	end

	self.equips = {}
	self.selectedQuality = var_4_0 or 1
	self.curSelectEntityid = nil
	self.selectedItems = {}
	self.tableIndex = nil
	self.curIndex = nil
	self.bagManager = bag_manager.create()

	self.bagManager:setHideItem(self.hideItem)

	self.bagUpdateFlag = false
	self.orderFlag = false
	self.tableViewPosX = 0
	self.tableViewPosY = 188
	self.tableViewWidth = 640
	self.tableViewHeight = 890
	self.sortOrder = var_0_26
	self.bag_stat = var_0_30
	self.returnLayer = LayerManager:getCurrentLayerName()
	self.selectTblAni = true
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "BagScene.json" or "BagScene.ExportJson")

	self:addChild(self.rootLayer, 1)
	self:createTitleSprite()
	self:initFilterPanel()
	self:updateFilterPanel()
	self:registerEvent()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			baglayernewInstance = nil

			LocalEvent:removeEvent(self)
		end
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "button_add_num"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "panel_resolve"):setVisible(false)
	self:initBottom()

	self.selectTblAni = false

	self:trans_overdue_item()
	LocalEvent:registerEvent(self, LocalEvent.EVENT_IDS.DECOMPOSE_ITEMS, function()
		print("更新背包数据")

		self.bagUpdateFlag = true

		self:updateEquip()
		self:updateShowingCell()
		self:updateTableView()
		self.tableView:scrollToIndex(math.min(self.tableIndex + 1, self:getTableViewCount() - 1), false)
	end)

	return true
end

function BagLayerNew:createInfoPanel(arg_7_1)
	local var_7_0 = cc.Layer:create()
	local var_7_1 = playermodel.items[arg_7_1].itemid
	local var_7_2 = 20
	local var_7_4 = 520
	local var_7_5 = {
		isShowInBag = true,
		entityid = arg_7_1,
		itemid = playermodel.items[arg_7_1].itemid
	}
	local var_7_8
	local var_7_7

	if self.selectType == "ActivityExchange" then
		LayerManager:removePopLayer()

		if self.exitCallback then
			self.exitCallback(arg_7_1, playermodel.items[arg_7_1].itemid)
		end

		do return end

		var_7_7 = {}
		var_7_8 = {}
	end

	function var_7_8.behavior(...)
		LayerManager:pushInLayer("PopOpenChoosegiftLayer", {
			opentype = 1,
			itemid = arg_7_1,
			callback = function(...)
				self:saveDecomposeBeforeShowingCells()

				self.bagUpdateFlag = true

				self:updateEquip()
				self:updateDecomposeAfterShowingCells()
			end
		})
	end

	var_7_8.kitemtyptbl = {
		kITEM_CHOOSE_GIFT
	}
	var_7_7[1] = var_7_8
	var_7_7[2] = {
		behavior = function(...)
			local function var_10_0(arg_11_0, arg_11_1)
				local var_11_0 = arg_11_0.num or 1

				network:rpc("use_gift_bag", {
					entityid = arg_7_1,
					num = var_11_0
				}, function(arg_12_0)
					if arg_12_0.result == 1 then
						self:saveDecomposeBeforeShowingCells()
						audio_manager:playeffectMusic(BAG_OPEN_GIFT_EFFECT)
						item_manager:deleteItem(arg_7_1, var_11_0)
						LayerManager:removePopLayer()
						global_gain(arg_12_0)

						;({})[1] = {
							entityid = arg_7_1,
							number = var_11_0
						}
						self.bagUpdateFlag = true

						self:updateEquip()
						self:updateDecomposeAfterShowingCells()

						if arg_12_0.gold and tonumber(arg_12_0.gold) > 0 then
							AnalyticManager.opengoldbag(arg_12_0.gold)
						end
					else
						global_ShowBlockWords(L_MARKET_MSG.Gift_Bag_Lack)
						audio_manager:playeffectMusicTest("sound/invalid")
					end
				end)
			end

			assert(item_data[var_7_1].mode_id, "itemData[" .. var_7_1 .. "].mode_id is nil")
			assert(drop_data[item_data[var_7_1].mode_id], "dropData id is nil:" .. item_data[var_7_1].mode_id)

			var_7_5.items = (drop_data[item_data[var_7_1].mode_id].rd_drop_weight1 or drop_data[item_data[var_7_1].mode_id].rd_dropmodel_id1 or drop_data[item_data[var_7_1].mode_id].dropmodel_id1 or drop_data[item_data[var_7_1].mode_id].rd_dropmodel_rate1) and {
				exp = 0,
				diamond = 0,
				sp = 0,
				gold = 0,
				energy = 0,
				equips = {}
			} or drop_manager:getDropMsg(item_data[var_7_1].mode_id)
			var_7_5.items.itemListType = 1

			if playermodel.items[arg_7_1].itemtype == kITEM_GIFT or playermodel.items[arg_7_1].itemtype == kITEM_COMPONENT_BOX or playermodel.items[arg_7_1].itemtype == Kitem_component_BOX_B or playermodel.items[arg_7_1].itemtype == KITEM_ACTIVITY_GIFT or playermodel.items[arg_7_1].itemtype == KITEM_ACTIVITY_GIFT_FREE or playermodel.items[arg_7_1].itemtype == KITEM_MARK_GIFT_SLIDER or playermodel.items[arg_7_1].itemtype == KITEM_DREAM_BOX or playermodel.items[arg_7_1].itemtype == KITEM_STUPID_GIFT then
				var_7_5.selectNum = playermodel.items[arg_7_1].number
				var_7_5.limitNum = playermodel.items[arg_7_1].number
				var_7_5.baggain = {}
				var_7_5.ShopSliderCallback = var_10_0
			else
				var_7_5.button = {
					{
						label = L_BUTTON_TEXT.Use,
						surecallback = var_10_0
					}
				}
			end

			var_7_5.goto_back_system_id = self:getCurSystemId()

			LayerManager:pushInLayer("PopGiftBagLayer", var_7_5)
		end,
		kitemtyptbl = {
			kITEM_GIFT,
			kITEM_GEM_BAG,
			kITEM_HELPGIRL_BAG,
			kITEM_COMPONENT_GIFT,
			kITEM_FURNITURE_GIFT,
			kITEM_SUPPLY,
			kITEM_SKIN_GIFT,
			KITEM_MARK_GIFT,
			kITEM_COMPONENT_BOX,
			Kitem_component_BOX_B,
			KITEM_ACTIVITY_GIFT,
			KITEM_ACTIVITY_GIFT_FREE,
			KITEM_DREAM_BOX,
			KITEM_STUPID_GIFT
		}
	}
	var_7_7[3] = {
		behavior = function(...)
			var_7_5.items = {
				exp = 0,
				diamond = 0,
				sp = 0,
				gold = 0,
				energy = 0,
				equips = {}
			}
			var_7_5.selectNum = playermodel.items[arg_7_1].number
			var_7_5.limitNum = playermodel.items[arg_7_1].number

			function var_7_5:ShopSliderCallback(arg_14_1)
				local var_14_0 = item_manager:getItemNumber(arg_7_1)

				if var_14_0 < 1 then
					global_ShowBlockWords(L_EXP_TICKET_MSG.Not_Enough)
					audio_manager:playeffectMusicTest("sound/invalid")
				else
					local var_14_1 = self.num or 1

					if var_14_1 == "all" then
						var_14_1 = var_14_0
					end

					network:rpc("use_exp_ticket", {
						entityid = arg_7_1,
						count = var_14_1
					}, function(arg_15_0)
						if arg_15_0.result == 1 then
							if arg_15_0.cost then
								LayerManager:removePopLayer()
								global_ShowBlockWords(string.format(L_EXP_TICKET_MSG.Gain_EXP, arg_15_0.gainexp))
								item_manager:deleteItem(arg_7_1, arg_15_0.cost)
								grade_manager:update_player_exp(arg_15_0.exp, arg_15_0.grade, arg_15_0.totalexp)

								self.bagUpdateFlag = true

								self:updateEquip()
								self:updateTableView()
								self.tableView:scrollToIndex(self.tableIndex, false)
							end
						elseif arg_15_0.result == 2 then
							global_ShowBlockWords(L_EXP_TICKET_MSG.Not_Enough)
							audio_manager:playeffectMusicTest("sound/invalid")
						else
							global_ShowBlockWords(L_EXP_TICKET_MSG.Use_Fail)
							l2Log("use_exp_ticket 使用经验券失败！")
							audio_manager:playeffectMusicTest("sound/invalid")
						end
					end)
				end
			end

			var_7_5.baggain = {}
			var_7_5.goto_back_system_id = self:getCurSystemId()

			LayerManager:pushInLayer("PopGiftBagLayer", var_7_5)
		end,
		kitemtyptbl = {
			KITEM_EXP_TICKET
		}
	}
	var_7_7[4] = {
		behavior = function(...)
			var_7_5.items = drop_manager:getDropMsg(item_data[var_7_1].mode_id)
			var_7_5.button = {
				{
					label = L_BUTTON_TEXT.Use_Bag.Single,
					surecallback = function(arg_17_0, arg_17_1)
						network:rpc("use_gold_bag", {
							entityid = arg_7_1
						}, function(arg_18_0)
							if arg_18_0.result == 1 then
								self:saveDecomposeBeforeShowingCells()
								audio_manager:playeffectMusic(BAG_OPEN_GIFT_EFFECT)
								item_manager:deleteItem(arg_7_1, 1)

								local var_18_0 = 0

								if arg_18_0.gold then
									var_18_0 = tonumber(arg_18_0.gold)

									if var_18_0 > 0 then
										playermodel.gold = playermodel.gold + var_18_0
									end
								end

								global_ShowBlockWords(string.format(L_GOLD_BAG_MSG.Gain_Gold, global_trans_number(tonumber(arg_18_0.gold))), cc.c3b(0, 255, 0), nil, 3, 0.3, 2)
								global_update_gold_stone_diamond(var_18_0)

								self.bagUpdateFlag = true

								self:updateEquip()
								self:updateDecomposeAfterShowingCells()
							end
						end)
					end
				},
				{
					label = L_BUTTON_TEXT.Use_Bag.Ten,
					surecallback = function(arg_19_0, arg_19_1)
						network:rpc("use_gold_bag_for_10", {
							entityid = arg_7_1
						}, function(arg_20_0)
							if arg_20_0.result == 1 then
								self:saveDecomposeBeforeShowingCells()
								audio_manager:playeffectMusic(BAG_OPEN_GIFT_EFFECT)
								item_manager:deleteItem(arg_7_1, arg_20_0.count)

								local var_20_0 = 0

								if arg_20_0.gold then
									var_20_0 = tonumber(arg_20_0.gold)

									if var_20_0 > 0 then
										playermodel.gold = playermodel.gold + var_20_0
									end
								end

								global_ShowBlockWords(string.format(L_GOLD_BAG_MSG.Gain_Gold, global_trans_number(tonumber(arg_20_0.gold))), cc.c3b(0, 255, 0), nil, 3, 0.3, 2)
								global_update_gold_stone_diamond(var_20_0)

								self.bagUpdateFlag = true

								self:updateEquip()
								self:updateDecomposeAfterShowingCells()
							end
						end)
					end
				}
			}
			var_7_5.goto_back_system_id = self:getCurSystemId()

			PopLayer:Item(var_7_5)
		end,
		kitemtyptbl = {
			kITEM_GOLD_BAG
		}
	}
	var_7_7[5] = {
		behavior = function(...)
			var_7_5.items = drop_manager:getDropMsg(item_data[var_7_1].mode_id)
			var_7_5.items.itemListType = 1
			var_7_5.selectNum = playermodel.items[arg_7_1].number
			var_7_5.limitNum = playermodel.items[arg_7_1].number
			var_7_5.baggain = {}

			function var_7_5:ShopSliderCallback(arg_22_1)
				component_manager:compound_component_chip(var_7_1, self.num or 1, function(arg_23_0, arg_23_1)
					if arg_23_0 == 1 then
						self:saveDecomposeBeforeShowingCells()

						if arg_23_1 and next(arg_23_1) then
							LayerManager:removePopLayer()
							global_gain({
								items = arg_23_1
							})
						end

						self.bagUpdateFlag = true

						self:updateEquip()
						self:updateDecomposeAfterShowingCells()
						self:updatebagContent()
					elseif arg_23_0 == 2 then
						global_ShowBlockWords(L_COMPONENT_CHIP_MSG[2])
						audio_manager:playeffectMusicTest("sound/invalid")
					elseif arg_23_0 == 3 then
						global_ShowBlockWords(L_COMPONENT_CHIP_MSG[3])
						audio_manager:playeffectMusicTest("sound/invalid")
					end
				end)
			end

			var_7_5.goto_back_system_id = self:getCurSystemId()

			LayerManager:pushInLayer("PopGiftBagLayer", var_7_5)
		end,
		kitemtyptbl = {
			kITEM_COMPONENT_CHIP
		}
	}
	var_7_7[6] = {
		behavior = function(...)
			var_7_5.items = {
				exp = 0,
				diamond = 0,
				sp = 0,
				gold = 0,
				energy = 0,
				equips = {}
			}
			var_7_5.selectNum = playermodel.items[arg_7_1].number
			var_7_5.baggain = {}
			var_7_5.button = {
				{
					label = L_BUTTON_TEXT.Use,
					surecallback = function(self, arg_25_1)
						if item_manager:getItemNumber(arg_7_1) < 1 then
							global_ShowBlockWords("道具不足")
							audio_manager:playeffectMusicTest("sound/invalid")
						else
							local var_25_0 = self.num or 1

							network:rpc("add_game_buff", {
								cost_item = {
									entityid = var_7_5.entityid,
									num = var_25_0
								}
							}, function(arg_26_0)
								if arg_26_0.result == 1 then
									if arg_26_0.cost_items and next(arg_26_0.cost_items) then
										LayerManager:removePopLayer()
										global_ShowBlockWords("道具使用成功！")

										for iter_26_0, iter_26_1 in pairs(arg_26_0.cost_items) do
											if iter_26_1.entityid and iter_26_1.num then
												item_manager:deleteItem(iter_26_1.entityid, iter_26_1.num)
											end
										end

										activity_return_manager:get_game_buffs()

										self.bagUpdateFlag = true

										self:updateEquip()
										self:updateTableView()
										self.tableView:scrollToIndex(self.tableIndex, false)
									end
								else
									global_ShowBlockWords("使用失败！")
									audio_manager:playeffectMusicTest("sound/invalid")
								end
							end)
						end
					end
				}
			}
			var_7_5.goto_back_system_id = self:getCurSystemId()

			LayerManager:pushInLayer("PopGiftBagLayer", var_7_5)
		end,
		kitemtyptbl = {
			KITEM_ACTIVITY_RETURN_BUFF
		}
	}
	var_7_7[7] = {
		behavior = function(...)
			local var_27_0 = cc.Label:createWithTTF(L_GIFT_MSG.Gift_Effect, FONT_DES, var_7_2)
			local var_27_1 = var_27_0:getContentSize().height * 1.2

			var_27_0:setAnchorPoint(cc.p(0, 0.5))
			var_27_0:setPosition(245, var_7_4 - 80)
			var_7_0:addChild(var_27_0, 1)

			local var_27_2 = cc.Label:createWithTTF("", FONT_DES, var_7_2)

			var_27_2:setString(string.format(L_GIFT_MSG.Add_Favor, item_data[var_7_1].favor))

			local var_27_3 = var_27_2:getContentSize().height * 1.2

			var_27_2:setColor(cc.c3b(217, 155, 164))
			var_27_2:setPosition(cc.p(400, var_7_4 - 115))
			var_7_0:addChild(var_27_2, 1)

			var_7_5.button = {
				{
					label = L_BUTTON_TEXT.Send_Gift,
					surecallback = function()
						LayerManager:switchShowLayer("DormitoryLayer")
					end
				}
			}
			var_7_5.layer = var_7_0
			var_7_5.goto_back_system_id = self:getCurSystemId()

			PopLayer:Item(var_7_5)
		end,
		kitemtyptbl = {
			kITEM_GIFT_FOR_FRIEND
		}
	}
	var_7_7[8] = {
		behavior = function(...)
			var_7_5.button = {
				{
					label = L_BUTTON_TEXT.Decoration,
					surecallback = function()
						LayerManager:switchShowLayer("DormitoryLayer")
					end
				}
			}
			var_7_5.goto_back_system_id = self:getCurSystemId()

			PopLayer:Item(var_7_5)
		end,
		kitemtyptbl = {
			kITEM_FURNITURE
		}
	}
	var_7_7[9] = {
		behavior = function(...)
			var_7_5.button = {
				{
					label = L_BUTTON_TEXT.Dress,
					surecallback = function(arg_32_0, arg_32_1, arg_32_2)
						if major_factor_data[item_data[arg_7_1].major] and playermodel.haveServant[major_factor_data[item_data[arg_7_1].major].servant] then
							LayerManager:pushInLayer("DormRoomPopLayer", {
								curShowPanel = "Panel_dress",
								soulid = require("data.servant_data")[major_factor_data[item_data[arg_7_1].major].servant].major,
								servantid = major_factor_data[item_data[arg_7_1].major].servant
							})
						elseif major_factor_data[item_data[arg_7_1].major] then
							LayerManager:switchShowLayer("GirlSelectLayer")
						else
							LayerManager:switchShowLayer("MainLayer")
						end

						if arg_32_2 then
							arg_32_2()
						end
					end
				}
			}
			var_7_5.goto_back_system_id = self:getCurSystemId()

			PopLayer:Item(var_7_5)
		end,
		kitemtyptbl = {
			kITEM_SKIN
		}
	}
	var_7_7[10] = {
		behavior = function(...)
			local var_33_0 = cc.Label:createWithTTF(L_GIFT_MSG.Cloth_Effect, "fonts/new.ttf", var_7_2)
			local var_33_1 = var_33_0:getContentSize().height * 1.2

			var_33_0:setAnchorPoint(cc.p(0, 0.5))
			var_33_0:setPosition(30, var_7_4 - 155)
			var_7_0:addChild(var_33_0, 1)

			local var_33_2

			if config._DEBUG then
				var_33_2 = cc.Scale9Sprite:create("public/bg_bg.png") or cc.Scale9Sprite:createWithSpriteFrameName("public/bg_bg.png")
			end

			var_33_2:setAnchorPoint(cc.p(0, 0.5))
			var_33_2:setPreferredSize(cc.size(560, var_33_1 * 3 + 50))
			var_33_2:setCapInsets(cc.rect(6, 6, 24, 20))
			var_33_2:setPosition(20, var_7_4 - 200)
			var_7_0:addChild(var_33_2)

			local var_33_3 = cc.Label:createWithTTF("", "fonts/W5.ttf", var_7_2)

			var_33_3:setString(string.format(L_GIFT_MSG.Add_Favor, item_data[var_7_1].favor))
			var_33_3:setColor(cc.c3b(217, 155, 164))
			var_33_3:setPosition(cc.p(190, var_7_4 - 190))
			var_7_0:addChild(var_33_3, 1)

			local var_33_4 = cc.Label:createWithTTF("", "fonts/W5.ttf", var_7_2)

			var_33_4:setString(item_data[var_7_1].fashion_fffect)
			var_33_4:setColor(cc.c3b(234, 173, 63))
			var_33_4:setPosition(cc.p(190, var_7_4 - 220))
			var_7_0:addChild(var_33_4, 1)

			var_7_5.goto_back_system_id = self:getCurSystemId()

			PopLayer:Item(var_7_5)
		end,
		kitemtyptbl = {
			kITEM_CLOTHES
		}
	}
	var_7_7[11] = {
		behavior = function(...)
			var_7_5.button = {
				{
					label = L_BUTTON_TEXT.Use_Bag.Single,
					surecallback = function(arg_35_0, arg_35_1)
						network:rpc("use_gift_bag", {
							entityid = arg_7_1
						}, function(arg_36_0)
							if arg_36_0.result == 1 then
								item_manager:deleteItem(arg_7_1, 1)
								item_manager:deleteItem(arg_7_1 - 100000, 1)
								global_gain(arg_36_0)

								self.bagUpdateFlag = true

								self:updateEquip()
								self:updateTableView()
							elseif arg_36_0.result == 2 then
								cc.Director:getInstance():getRunningScene():addChild(PopLayer:Go_Gain_Key({
									item = var_7_1 - 100000
								}), 999)

								self.bagUpdateFlag = true

								self:updateEquip()
								self:updateTableView()
								self.tableView:scrollToIndex(self.tableIndex, false)
							else
								l2Log("强化石袋使用失败")
							end
						end)
					end
				},
				{
					label = L_BUTTON_TEXT.Use_Bag.Ten,
					surecallback = function(arg_37_0, arg_37_1)
						network:rpc("use_gift_bag_for_10", {
							entityid = arg_7_1
						}, function(arg_38_0)
							if arg_38_0.result == 1 then
								item_manager:deleteItem(arg_7_1, arg_38_0.count)
								item_manager:deleteItem(arg_7_1 - 100000, arg_38_0.count)
								global_gain(arg_38_0)

								self.bagUpdateFlag = true

								self:updateEquip()
								self:updateTableView()
							elseif arg_38_0.result == 2 then
								cc.Director:getInstance():getRunningScene():addChild(PopLayer:Go_Gain_Key({
									item = var_7_1 - 100000
								}), 999)

								self.bagUpdateFlag = true

								self:updateEquip()
								self:updateTableView()
								self.tableView:scrollToIndex(self.tableIndex, false)
							else
								l2Log("强化石袋使用失败")
							end
						end)
					end
				}
			}
			var_7_5.goto_back_system_id = self:getCurSystemId()

			PopLayer:Item(var_7_5)
		end,
		kitemtyptbl = {
			kITEM_BOX
		}
	}
	var_7_7[12] = {
		behavior = function(...)
			function var_7_5.updateCallback(arg_40_0)
				self.bagUpdateFlag = true

				self:saveDecomposeBeforeShowingCells()
				self:updateEquip()
				self:updateDecomposeAfterShowingCells()
			end

			LayerManager:pushInLayer("PopComponentLayer", var_7_5)
		end,
		kitemtyptbl = {
			kITEM_COMPONENT
		}
	}
	var_7_7[13] = {
		behavior = function(...)
			local var_42_0 = playermodel.items[arg_7_1]

			var_7_5.button = {
				{
					label = L_BUTTON_TEXT.Materil_Sold,
					surecallback = function()
						item_manager:sell_item(var_42_0.entityid, 1, function(arg_44_0)
							self.bagUpdateFlag = true

							self:updateEquip()
							self:updateTableView()

							var_7_5 = {
								gold = arg_44_0
							}

							LayerManager:pushInLayer("PopPurchaseResultLayer", var_7_5)
						end)
					end
				}
			}
			var_7_5.goto_back_system_id = self:getCurSystemId()

			PopLayer:Item(var_7_5)
		end,
		kitemtyptbl = {
			kITEM_FOOD
		}
	}
	var_7_7[14] = {
		behavior = function(...)
			if playermodel.items[arg_7_1].itemid == 3150000 then
				var_7_5.goto_back_system_id = self:getCurSystemId()

				LayerManager:pushInLayer("PopItemLayer", var_7_5)

				return
			end

			local var_45_0 = cc.Label:createWithTTF("", "fonts/new1.ttf", var_7_2)
			local var_45_1 = var_45_0:getContentSize().height * 1.2

			var_45_0:setAnchorPoint(cc.p(0, 0.5))
			var_45_0:setPosition(245, var_7_4 - 80)

			if not item_data[playermodel.items[arg_7_1].itemid].compound_consume or item_data[playermodel.items[arg_7_1].itemid].compound_consume == 0 then
				var_45_0:setString("")
			else
				var_45_0:setString("\n\n" .. horcrux_manager:gethorcruxChipInfo(playermodel.items[arg_7_1].itemid))
			end

			var_7_0:addChild(var_45_0, 1)

			var_7_5.items = drop_manager:getDropMsg(item_data[playermodel.items[arg_7_1].itemid].helpgirl_number)
			var_7_5.items.itemListType = 1
			var_7_5.limitNum = playermodel.items[arg_7_1].number
			var_7_5.baggain = {}

			function var_7_5:ShopSliderCallback(arg_46_1)
				horcrux_manager:horcruxChipCompound(arg_7_1, self.num or 1, function(arg_47_0, arg_47_1)
					if arg_47_0 == 1 then
						self:saveDecomposeBeforeShowingCells()

						if next(arg_47_1) then
							LayerManager:removePopLayer()
							global_gain({
								items = arg_47_1
							})
						end

						self.bagUpdateFlag = true

						self:updateEquip()
						self:updateDecomposeAfterShowingCells()
						self:updatebagContent()
					elseif arg_47_0 == 2 then
						if not playermodel.items[arg_7_1] or not playermodel.items[arg_7_1].itemid then
							global_ShowBlockWords(L_NET_ERROR)

							return
						end

						global_ShowBlockWords(string.format(L_HORCRUX_CHIP_MSG.Chip_Need, item_data[playermodel.items[arg_7_1].itemid].compound_consume))
						audio_manager:playeffectMusicTest("sound/invalid")
					end
				end)
			end

			var_7_5.layer = var_7_0
			var_7_5.goto_back_system_id = self:getCurSystemId()

			if not item_data[playermodel.items[arg_7_1].itemid].compound_consume or item_data[playermodel.items[arg_7_1].itemid].compound_consume == 0 then
				var_7_5.ShopSliderCallback = nil
			else
				var_7_5.selectNum = math.floor(playermodel.items[arg_7_1].number / item_data[playermodel.items[arg_7_1].itemid].compound_consume) * item_data[playermodel.items[arg_7_1].itemid].compound_consume
			end

			LayerManager:pushInLayer("PopGiftBagLayer", var_7_5)
		end,
		kitemtyptbl = {
			kITEM_HORCRUX_CHIP
		}
	}
	var_7_7[15] = {
		behavior = use_basic_material,
		kitemtyptbl = {
			kITEM_BASIC_MATRIAL
		}
	}
	var_7_7[16] = {
		behavior = function(...)
			local var_50_0 = cc.Label:createWithTTF("", "fonts/new1.ttf", var_7_2)
			local var_50_1 = var_50_0:getContentSize().height * 1.2

			var_50_0:setAnchorPoint(cc.p(0, 0.5))
			var_50_0:setPosition(245, var_7_4 - 80)

			if not item_data[playermodel.items[arg_7_1].itemid].compound_consume or item_data[playermodel.items[arg_7_1].itemid].compound_consume == 0 then
				var_50_0:setString("")
			else
				var_50_0:setString("\n\n" .. item_manager:getServantChipInfo(playermodel.items[arg_7_1].itemid))
			end

			var_7_0:addChild(var_50_0, 1)

			var_7_5.items = drop_manager:getDropMsg(item_data[playermodel.items[arg_7_1].itemid].mode_id)
			var_7_5.items.itemListType = 1
			var_7_5.itemtype = kITEM_SERVANT_CHIP
			var_7_5.limitNum = playermodel.items[arg_7_1].number
			var_7_5.baggain = {}

			function var_7_5:ShopSliderCallback(arg_51_1)
				item_manager:compound_item(arg_7_1, self.num or 1, function(arg_52_0, arg_52_1)
					if arg_52_0 == 1 then
						self:saveDecomposeBeforeShowingCells()

						if next(arg_52_1) then
							LayerManager:removePopLayer()
							global_gain({
								items = arg_52_1
							})
						end

						self.bagUpdateFlag = true

						self:updateEquip()
						self:updateDecomposeAfterShowingCells()
						self:updatebagContent()
					elseif arg_52_0 == 2 then
						global_ShowBlockWords(string.format(L_SERVANT_CHIP_MSG.Chip_Need, item_data[playermodel.items[arg_7_1].itemid].compound_consume))
						audio_manager:playeffectMusicTest("sound/invalid")
					end
				end)
			end

			var_7_5.layer = var_7_0
			var_7_5.goto_back_system_id = self:getCurSystemId()

			if not item_data[playermodel.items[arg_7_1].itemid].compound_consume or item_data[playermodel.items[arg_7_1].itemid].compound_consume == 0 then
				var_7_5.ShopSliderCallback = nil
			else
				var_7_5.selectNum = math.floor(playermodel.items[arg_7_1].number / item_data[playermodel.items[arg_7_1].itemid].compound_consume) * item_data[playermodel.items[arg_7_1].itemid].compound_consume
			end

			LayerManager:pushInLayer("PopGiftBagLayer", var_7_5)
		end,
		kitemtyptbl = {
			kITEM_SERVANT_CHIP
		}
	}
	var_7_7[17] = {
		behavior = function(...)
			function var_7_5:ShopSliderCallback(arg_56_1)
				local var_56_0 = self.nowNum or 1

				network:rpc("use_gift_bag", {
					entityid = arg_7_1,
					num = var_56_0
				}, function(arg_57_0)
					if arg_57_0.result == 1 then
						self:saveDecomposeBeforeShowingCells()
						audio_manager:playeffectMusic(BAG_OPEN_GIFT_EFFECT)
						item_manager:deleteItem(arg_7_1, var_56_0)
						LayerManager:removePopLayer()
						global_gain(arg_57_0)

						;({})[1] = {
							entityid = arg_7_1,
							number = var_56_0
						}
						self.bagUpdateFlag = true

						self:updateEquip()
						self:updateDecomposeAfterShowingCells()

						if arg_57_0.gold and tonumber(arg_57_0.gold) > 0 then
							AnalyticManager.opengoldbag(arg_57_0.gold)
						end
					else
						global_ShowBlockWords(L_MARKET_MSG.Gift_Bag_Lack)
						audio_manager:playeffectMusicTest("sound/invalid")
					end
				end)
			end

			LayerManager:pushInLayer("PopOpenBagInfoLayer", var_7_5)
		end,
		kitemtyptbl = {
			KITEM_MARK_GIFT_SLIDER
		}
	}
	var_7_7[18] = {
		behavior = function(...)
			LayerManager:pushInLayer("PopOpenRandomGiftLayer", {
				opentype = 1,
				itemid = arg_7_1,
				callback = function(...)
					self:saveDecomposeBeforeShowingCells()
					audio_manager:playeffectMusic(BAG_OPEN_GIFT_EFFECT)

					self.bagUpdateFlag = true

					self:updateEquip()
					self:updateDecomposeAfterShowingCells()
				end
			})
		end,
		kitemtyptbl = {
			kITEM_RANDOM_GIFT
		}
	}

	local var_7_9 = false

	for iter_7_0, iter_7_1 in pairs(var_7_7) do
		for iter_7_2, iter_7_3 in pairs(iter_7_1.kitemtyptbl) do
			if item_data[playermodel.items[arg_7_1].itemid].bag_item_type == iter_7_3 then
				iter_7_1.behavior()

				var_7_9 = true

				break
			end
		end
	end

	if item_data[playermodel.items[arg_7_1].itemid].jump and (not item_data[playermodel.items[arg_7_1].itemid].jump_starttime or os.time(parse_time(item_data[playermodel.items[arg_7_1].itemid].jump_starttime)) < time_check_manager:getCurTime()) and (not item_data[playermodel.items[arg_7_1].itemid].jump_finishtime or time_check_manager:getCurTime() < os.time(parse_time(item_data[playermodel.items[arg_7_1].itemid].jump_finishtime))) then
		local var_7_10 = item_data[playermodel.items[arg_7_1].itemid].jump

		var_7_5.button = {
			{
				label = L_BUTTON_TEXT.Use,
				surecallback = function(...)
					LayerManager:removePopLayer()
					require("controller.goto_system_manager")

					local var_58_0 = {
						jump_to_system = var_7_10
					}

					var_58_0.config = system_jump_config[SYSTEMID[var_7_10]] and system_jump_config[SYSTEMID[var_7_10]].config

					goto_complete_system(var_58_0)
				end
			}
		}
	end

	if not var_7_9 then
		var_7_5.goto_back_system_id = self:getCurSystemId()

		LayerManager:pushInLayer("PopItemLayer", var_7_5)
	end
end

function BagLayerNew.startLongPressSelect(arg_59_0, arg_59_1, arg_59_2)
	local var_59_0 = 1
	local var_59_1 = 1

	arg_59_1:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
		arg_59_2(var_59_1)

		var_59_1 = var_59_1 + math.floor(var_59_0 / 10)
		var_59_0 = var_59_0 + 1
	end), cc.DelayTime:create(0.1))))
end

function BagLayerNew.createEquip(arg_61_0, arg_61_1)
	local var_61_0 = {}

	table.insert(var_61_0, {
		entityid = arg_61_1,
		number = (item_data[playermodel.items[arg_61_1].itemid].bag_item_type == kITEM_FURNITURE or nil) and (dormitory_manager:getLeftoverFurniture(arg_61_1) or item_manager:getItemNumberByEntityId(arg_61_1)) or 1
	})

	return var_61_0
end

function BagLayerNew:updateEquip()
	if self.bagUpdateFlag == true then
		self.bagManager:update()

		self.bagUpdateFlag = false
	end

	self:updatebagContent()

	for iter_62_0, iter_62_1 in pairs(self.equips) do
		self.equips[iter_62_0] = nil
	end

	self.curSelectEntityid = nil

	local var_62_0 = self.filterTbl

	if self.selectedQuality == var_0_19 then
		var_62_0.filterConfig.use = {}

		table.insert(var_62_0.filterConfig.use, false)
	elseif self.selectedQuality == var_0_20 then
		if self.bag_stat == var_0_31 then
			var_62_0.filterConfig.is_sale = {}

			table.insert(var_62_0.filterConfig.is_sale, true)
		else
			var_62_0.filterConfig.is_sale = nil
		end

		var_62_0.bagType_partition = 1
	elseif self.selectedQuality == var_0_21 then
		if self.bag_stat == var_0_31 then
			var_62_0.filterConfig.is_sale = {}

			table.insert(var_62_0.filterConfig.is_sale, true)
		else
			var_62_0.filterConfig.is_sale = nil
		end
	elseif self.selectedQuality == var_0_22 then
		if self.bag_stat == var_0_31 then
			var_62_0.filterConfig.is_sale = {}

			table.insert(var_62_0.filterConfig.is_sale, true)
		else
			var_62_0.filterConfig.is_sale = nil
		end

		var_62_0.bagType_partition = 2
	end

	if self.selectedQuality == var_0_22 then
		var_62_0.bag_type = 2
	end

	local var_62_1 = self.bagManager:getBagData(var_62_0)

	if self.selectedQuality == var_0_20 and self.filterTbl and self.filterTbl.filterConfig and self.filterTbl.filterConfig.type and not self.filterTbl.filterConfig.type[1] then
		while var_62_1[1] do
			local var_62_2

			if item_data[var_62_1[1]].bag_item_type == kITEM_ACTIVITY then
				table.remove(var_62_1, 1)
			else
				var_62_2 = 1 + 1
			end
		end

		for iter_62_2, iter_62_3 in pairs(var_62_1) do
			if item_data[iter_62_3].bag_item_type == kITEM_ACTIVITY then
				table.remove(var_62_1, iter_62_2)
			end
		end
	end

	self.equipCount = 0

	for iter_62_4 = 1, #var_62_1 do
		if playermodel.items[var_62_1[iter_62_4]].itemtype == kITEM_COMPONENT then
			self.equipCount = self.equipCount + 1

			local var_62_3 = {
				index = self.equipCount,
				entityid = var_62_1[iter_62_4]
			}

			var_62_3.number = 1
			self.equips[#self.equips + 1] = var_62_3
		else
			local var_62_4 = self:createEquip(var_62_1[iter_62_4])

			for iter_62_5 = 1, #var_62_4 do
				self.equipCount = self.equipCount + 1
				var_62_4[iter_62_5].index = self.equipCount
				self.equips[#self.equips + 1] = var_62_4[iter_62_5]
			end
		end
	end

	if self.bag_stat ~= var_0_30 then
		self:insertSelectedItem()
	end

	self.oldEquips = global_deepCopy(self.equips)
end

function BagLayerNew:initFilterPanel()
	local var_63_0 = ccui.ImageView:create("BagLayer/filter_bg.png", var_0_18)

	var_63_0:setPositionX(320)
	var_63_0:setPositionY(92 - GameDisplay.fix_y)
	var_63_0:setTouchEnabled(true)
	self.rootLayer:addChild(var_63_0, 9)

	self.materialFilterBtn = ccui.Button:create("BagLayer/filter_btn_material.png", nil, "BagLayer/filter_btn_material.png", var_0_18)
	self.labFilterBtn = ccui.Button:create("BagLayer/filter_btn_lab.png", nil, "BagLayer/filter_btn_lab_on.png", var_0_18)
	self.componentFilterBtn = ccui.Button:create("BagLayer/filter_btn_component.png", nil, "BagLayer/filter_btn_component_on.png", var_0_18)
	self.furnitureFilterBtn = ccui.Button:create("BagLayer/filter_btn_furniture.png", nil, "BagLayer/filter_btn_furniture_on.png", var_0_18)
	self.materialFilterBtn.bagtype = var_0_20
	self.labFilterBtn.bagtype = var_0_22
	self.componentFilterBtn.bagtype = var_0_19
	self.furnitureFilterBtn.bagtype = var_0_21

	self.materialFilterBtn:setPosition(cc.p(180, var_63_0:getContentSize().height / 2))
	self.labFilterBtn:setPosition(cc.p(310, var_63_0:getContentSize().height / 2))
	self.componentFilterBtn:setPosition(cc.p(440, var_63_0:getContentSize().height / 2))
	self.furnitureFilterBtn:setPosition(cc.p(570, var_63_0:getContentSize().height / 2))

	local function var_63_1(arg_64_0, arg_64_1)
		if arg_64_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.selectedQuality = arg_64_0.bagtype
		self.oldCellCount = nil
		self.selectAll = false
		self.filterTbl = filter_config_manager:getDefaultFilterData(self.selectedQuality)
		self.sortType = self.filterTbl.sortType
		self.curSelectEntityid = nil
		self.selectedItems = {}
		self.tableIndex = nil
		self.curIndex = nil
		self.bagUpdateFlag = false
		self.orderFlag = false
		self.sortOrder = var_0_26
		self.bag_stat = var_0_30
		self.selectTblAni = false

		self:updateEquip()
		self:updateTableView()
		self:updatebagContent(self.selectedQuality)
		self:updateTitleSprite()

		if self.filterSpritePop then
			self.filterSpritePop:removeFromParent()

			self.filterSpritePop = nil
		end

		self:updateFilterPanel()
	end

	self.materialFilterBtn:addTouchEventListener(var_63_1)
	self.labFilterBtn:addTouchEventListener(var_63_1)
	self.componentFilterBtn:addTouchEventListener(var_63_1)
	self.furnitureFilterBtn:addTouchEventListener(var_63_1)
	var_63_0:addChild(self.materialFilterBtn)
	var_63_0:addChild(self.labFilterBtn)
	var_63_0:addChild(self.componentFilterBtn)
	var_63_0:addChild(self.furnitureFilterBtn)

	local var_63_2 = ccui.ImageView:create("BagLayer/operation_bg.png", var_0_18)

	var_63_2:setPositionX(320)
	var_63_2:setPositionY(var_63_0:getPositionY() + var_63_0:getContentSize().height / 2 + var_63_2:getContentSize().height / 2)
	var_63_2:setTouchEnabled(true)
	self.rootLayer:addChild(var_63_2, 9)

	self.filterButton = ccui.Button:create("BagLayer/btn_filter.png", nil, "BagLayer/btn_filter.png", var_0_18)

	self.filterButton:setPositionX(570)
	self.filterButton:setPositionY(var_63_2:getContentSize().height / 2)
	var_63_2:addChild(self.filterButton, 5)
	self.filterButton:addTouchEventListener(function(arg_65_0, arg_65_1)
		if arg_65_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:showFilterPop()
	end)

	self.sellBtn = ccui.Button:create("BagLayer/btn_sell.png", nil, "BagLayer/btn_sell.png", var_0_18)

	self.sellBtn:setPosition(cc.p(446, var_63_2:getContentSize().height / 2))
	self.sellBtn:addTouchEventListener(self:getSellBtnTouchHandler())
	var_63_2:addChild(self.sellBtn)

	self.cancelBtn = ccui.Button:create("BagLayer/btn_cancel.png", nil, "BagLayer/btn_cancel.png", var_0_18)

	self.cancelBtn:setPosition(cc.p(70, var_63_0:getContentSize().height / 2))
	var_63_2:addChild(self.cancelBtn)
	self.cancelBtn:addTouchEventListener(function(arg_66_0, arg_66_1)
		if arg_66_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.oldCellCount = nil
		self.bag_stat = var_0_30

		self:updateSortOderIcon()
		self:resetSortOrder()
		self:updateEquip()
		self:updateTableView()
		self:updateFilterPanel()
	end)

	self.bagContent = ccui.Button:create("BagLayer/capacity.png", "BagLayer/capacity.png", "BagLayer/capacity.png", var_0_18)

	self.bagContent:setPositionX(120)
	self.bagContent:setPositionY(var_63_2:getContentSize().height / 2)
	var_63_2:addChild(self.bagContent)

	local var_63_3 = cc.Label:createWithTTF(L_CONTENT, FONT_NAME, 18)

	var_63_3:setAnchorPoint(cc.p(0, 0.5))
	var_63_3:setPositionX(5)
	var_63_3:setPositionY(self.bagContent:getContentSize().height / 2)
	var_63_3:setName("desnum")
	self.bagContent:addChild(var_63_3)

	local var_63_4 = cc.Label:createWithTTF("", FONT_NAME, 18)

	var_63_4:setAnchorPoint(cc.p(0, 0.5))
	var_63_4:setPositionX(5)
	var_63_4:setPositionY(self.bagContent:getContentSize().height / 2)
	var_63_4:setName("curnum")
	self.bagContent:addChild(var_63_4)

	local var_63_5 = cc.Label:createWithTTF("", FONT_NAME, 18)

	var_63_5:setAnchorPoint(cc.p(0, 0.5))
	var_63_5:setPositionX(5)
	var_63_5:setPositionY(self.bagContent:getContentSize().height / 2)
	var_63_5:setName("maxnum")
	self.bagContent:addChild(var_63_5)

	self.filterTbl = filter_config_manager:getDefaultFilterData(self.selectedQuality)
	self.sortType = self.filterTbl.sortType
	self.button_attribute = ccui.Button:create("public/filter/attr_icon_off.png", "public/filter/attr_icon_off.png", nil, var_0_18)

	self.button_attribute:setPositionX(550)
	self.button_attribute:setPositionY(self.title:getContentSize().height / 2)

	self.button_attribute.isClickOn = false

	self.title:addChild(self.button_attribute, 5)
	self.button_attribute:setVisible(false)
	self.button_attribute:addTouchEventListener(function(arg_67_0, arg_67_1)
		if arg_67_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.button_attribute.is_show_attribute = not self.button_attribute.is_show_attribute
		arg_67_0.isClickOn = not arg_67_0.isClickOn

		if arg_67_0.isClickOn == false then
			arg_67_0:loadTextures("public/filter/attr_icon_off.png", "public/filter/attr_icon_off.png", nil, var_0_18)
		else
			arg_67_0:loadTextures("public/filter/attr_icon_on.png", "public/filter/attr_icon_on.png", nil, var_0_18)
		end

		self:saveDecomposeBeforeShowingCells()
		self:updateDecomposeAfterShowingCells()
	end)

	self.selectAllBtnBg = ccui.ImageView:create("BagLayer/select_all_bg.png", var_0_18)

	self.selectAllBtnBg:setPositionX(346)
	self.selectAllBtnBg:setTouchEnabled(true)
	self.selectAllBtnBg:setPositionY(var_63_2:getContentSize().height / 2 + 2)
	var_63_2:addChild(self.selectAllBtnBg)
	self.selectAllBtnBg:addTouchEventListener(function(arg_68_0, arg_68_1)
		if arg_68_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.selectAll = not self.selectAll

		self:updateSelectAllData()
		self:updateFilterPanel()
		self:updateShowingCell()
	end)

	self.selectAllLabel = cc.Label:createWithTTF("全选:", FONT_DES, 22)

	self.selectAllLabel:setAnchorPoint(cc.p(1, 0.5))
	self.selectAllLabel:setPositionX(-self.selectAllBtnBg:getContentSize().width / 2)
	self.selectAllLabel:setPositionY(self.selectAllBtnBg:getContentSize().height / 2)
	self.selectAllBtnBg:addChild(self.selectAllLabel)

	self.selectAllHook = ccui.ImageView:create("public/rolebg/horcrux_hook.png", var_0_18)

	self.selectAllHook:setPosition(self.selectAllBtnBg:getPosition())
	var_63_2:addChild(self.selectAllHook)
end

function BagLayerNew.getSellBtnTouchHandler(arg_69_0, ...)
	return function(arg_70_0, arg_70_1)
		if arg_70_1 ~= ccui.TouchEventType.ended then
			return
		end

		local function var_70_0()
			arg_69_0.bagContent:setVisible(arg_69_0.bag_stat ~= var_0_31)
		end

		local function var_70_1()
			if arg_69_0.bag_stat == var_0_30 then
				arg_69_0.oldCellCount = nil
				arg_69_0.bag_stat = var_0_31
				arg_69_0.selectedItems = {}

				var_70_0()
				arg_69_0:saveCurSortOrder()
				arg_69_0:updateSortOderIcon()
				arg_69_0:updateEquip()
				arg_69_0:updateTableView()
			else
				local var_74_0 = {}

				for iter_74_0, iter_74_1 in pairs(arg_69_0.selectedItems) do
					var_74_0[#var_74_0 + 1] = {}
					var_74_0[#var_74_0 + 1].entityid = iter_74_1.entityid
					var_74_0[#var_74_0 + 1].number = iter_74_1.number
				end

				if #var_74_0 == 0 then
					global_ShowBlockWords(L_SELECT_EQUIP_MSG.Unselected_Resource)
					audio_manager:playeffectMusicTest("sound/invalid")
				else
					local var_74_1 = playermodel.items[var_74_0[1].entityid].itemid

					item_manager:sell_item_batch(var_74_0, function(arg_75_0)
						arg_69_0.bagUpdateFlag = true

						arg_69_0:updateCurData(var_74_0)

						if arg_69_0.tableIndex then
							arg_69_0.tableView:scrollToIndex(arg_69_0.tableIndex, false)
						end

						LayerManager:pushInLayer("PopPurchaseResultLayer", {
							gold = arg_75_0
						})
						arg_69_0:updatebagContent()

						arg_69_0.selectedItems = {}

						if arg_69_0.selectedQuality == var_0_20 then
							AnalyticManager.sellSuccess6({
								ItemId = var_74_1,
								get_gold = arg_75_0
							})
						else
							AnalyticManager.sellSuccess5({
								ItemId = var_74_1,
								get_gold = arg_75_0
							})
						end
					end)
				end
			end
		end

		local var_70_3 = {
			function()
				if arg_69_0.bag_stat == var_0_30 then
					arg_69_0.oldCellCount = nil
					arg_69_0.bag_stat = var_0_31
					arg_69_0.selectedItems = {}

					var_70_0()
					arg_69_0:saveCurSortOrder()
					arg_69_0:updateSortOderIcon()
					arg_69_0:updateEquip()
					arg_69_0:updateTableView()
				else
					local var_76_0 = {}
					local var_76_1 = {}
					local var_76_2 = {}

					for iter_76_0, iter_76_1 in pairs(arg_69_0.selectedItems) do
						var_76_0[#var_76_0 + 1] = iter_76_1.entityid

						if item_data[playermodel.items[iter_76_1.entityid].itemid].bag_item_type == kITEM_COMPONENT then
							table.insert(var_76_2, iter_76_1.entityid)
						else
							table.insert(var_76_1, {
								entityid = iter_76_1.entityid,
								number = iter_76_1.number
							})
						end
					end

					if #var_76_0 == 0 then
						global_ShowBlockWords(L_SELECT_EQUIP_MSG.Unselected_Parts)
						audio_manager:playeffectMusicTest("sound/invalid")
					else
						if #var_76_2 ~= 0 then
							component_manager:BreakdownComponent(var_76_2, function(arg_77_0, arg_77_1)
								if arg_77_0 == 1 then
									arg_69_0.bagUpdateFlag = true

									arg_69_0:updateCurData(var_76_2)

									if arg_69_0.tableIndex then
										arg_69_0.tableView:scrollToIndex(arg_69_0.tableIndex, false)
									end

									local var_77_0 = {}

									if arg_77_1.gold and arg_77_1.gold > 0 then
										var_77_0.gold = arg_77_1.gold
									end

									if arg_77_1.items and next(arg_77_1.items) ~= nil then
										local var_77_1 = {}

										for iter_77_0, iter_77_1 in pairs(arg_77_1.items) do
											table.insert(var_77_1, {
												itemid = iter_77_1.dropid,
												dropNum = iter_77_1.dropNum
											})
										end

										var_77_0.items = var_77_1
									end

									LayerManager:pushInLayer("PopPurchaseResultLayer", var_77_0)
									arg_69_0:updatebagContent()

									arg_69_0.selectedItems = {}
								elseif arg_77_0 == 0 then
									global_ShowBlockWords(L_SELECT_EQUIP_MSG.Component.Decompose_Fail)
									audio_manager:playeffectMusicTest("sound/invalid")
								elseif arg_77_0 == 2 then
									global_ShowBlockWords(L_SELECT_EQUIP_MSG.Component.Using)
									audio_manager:playeffectMusicTest("sound/invalid")
								elseif arg_77_0 == 3 then
									global_ShowBlockWords(L_SELECT_EQUIP_MSG.Component.Unselected)
									audio_manager:playeffectMusicTest("sound/invalid")
								elseif arg_77_0 == 4 then
									global_ShowBlockWords(L_SELECT_EQUIP_MSG.Component.Decompose_Fail)
									audio_manager:playeffectMusicTest("sound/invalid")
								end
							end)
						end

						if #var_76_1 ~= 0 then
							item_manager:sell_item_batch(var_76_1, function(arg_78_0)
								arg_69_0.bagUpdateFlag = true

								arg_69_0:updateCurData(var_76_1)

								if arg_69_0.tableIndex then
									arg_69_0.tableView:scrollToIndex(arg_69_0.tableIndex, false)
								end

								LayerManager:pushInLayer("PopPurchaseResultLayer", {
									gold = arg_78_0
								})
								arg_69_0:updatebagContent()

								arg_69_0.selectedItems = {}
							end)
						end
					end
				end
			end,
			var_70_1,
			function()
				if arg_69_0.bag_stat == var_0_30 then
					arg_69_0.oldCellCount = nil
					arg_69_0.bag_stat = var_0_31
					arg_69_0.selectedItems = {}

					var_70_0()
					arg_69_0:saveCurSortOrder()
					arg_69_0:updateSortOderIcon()
					arg_69_0:updateEquip()
					arg_69_0:updateTableView()
				else
					local var_72_0 = {}

					for iter_72_0, iter_72_1 in pairs(arg_69_0.selectedItems) do
						var_72_0[#var_72_0 + 1] = {}
						var_72_0[#var_72_0 + 1].entityid = iter_72_1.entityid
						var_72_0[#var_72_0 + 1].number = iter_72_1.number
					end

					if #var_72_0 == 0 then
						global_ShowBlockWords(L_SELECT_EQUIP_MSG.Unselected_Furniture)
						audio_manager:playeffectMusicTest("sound/invalid")
					else
						item_manager:sell_item_batch(var_72_0, function(arg_73_0)
							arg_69_0.bagUpdateFlag = true

							arg_69_0:updateCurData(var_72_0)

							if arg_69_0.tableIndex then
								arg_69_0.tableView:scrollToIndex(arg_69_0.tableIndex, false)
							end

							LayerManager:pushInLayer("PopPurchaseResultLayer", {
								gold = arg_73_0
							})
							arg_69_0:updatebagContent()

							arg_69_0.selectedItems = {}

							AnalyticManager.sellSuccess4({
								ItemId = playermodel.items[var_72_0[1].entityid].itemid,
								get_gold = arg_73_0
							})
						end)
					end
				end
			end,
			[5] = var_70_1
		}

		local function var_70_4()
			for iter_79_0, iter_79_1 in pairs(arg_69_0.selectedItems) do
				if item_data[playermodel.items[iter_79_1.entityid].itemid].equip_quality == 5 then
					return 5
				end

				if item_data[playermodel.items[iter_79_1.entityid].itemid].equip_quality == 6 then
					return 6
				end
			end

			return false
		end

		if arg_69_0.bag_stat ~= var_0_30 then
			arg_69_0:showSellDrop(function(...)
				local var_80_0 = var_70_4()

				if var_80_0 then
					if not arg_69_0.rootLayer:getChildByName("dialog") then
						local var_80_1 = ConfirmDialogSprite:create(L_SELECT_EQUIP_MSG.Choose_Confirm, L_SELECT_EQUIP_MSG.Items_Include_Orange_Or_RedQuality[var_80_0], {
							layerType = "BagLayer",
							surecallback = function(arg_81_0, arg_81_1)
								var_70_3[arg_69_0.selectedQuality]()
							end,
							cancelCallback = function(arg_82_0, arg_82_1)
								return
							end
						})

						global_basic_scene:addChild(var_80_1, 10)
						var_80_1:setName("dialog")
					end
				else
					var_70_3[arg_69_0.selectedQuality]()
				end
			end)
		else
			var_70_3[arg_69_0.selectedQuality]()
		end

		arg_69_0:updateFilterPanel()
	end
end

function BagLayerNew:updateFilterPanel(...)
	if self.materialFilterBtn.bagtype == self.selectedQuality then
		self.materialFilterBtn:loadTextures("BagLayer/filter_btn_material_on.png", nil, "BagLayer/filter_btn_material_on.png", var_0_18)
	else
		self.materialFilterBtn:loadTextures("BagLayer/filter_btn_material.png", nil, "BagLayer/filter_btn_material.png", var_0_18)
	end

	if self.labFilterBtn.bagtype == self.selectedQuality then
		self.labFilterBtn:loadTextures("BagLayer/filter_btn_lab_on.png", nil, "BagLayer/filter_btn_lab_on.png", var_0_18)
	else
		self.labFilterBtn:loadTextures("BagLayer/filter_btn_lab.png", nil, "BagLayer/filter_btn_lab.png", var_0_18)
	end

	if self.componentFilterBtn.bagtype == self.selectedQuality then
		self.componentFilterBtn:loadTextures("BagLayer/filter_btn_component_on.png", nil, "BagLayer/filter_btn_component_on.png", var_0_18)
	else
		self.componentFilterBtn:loadTextures("BagLayer/filter_btn_component.png", nil, "BagLayer/filter_btn_component.png", var_0_18)
	end

	if self.furnitureFilterBtn.bagtype == self.selectedQuality then
		self.furnitureFilterBtn:loadTextures("BagLayer/filter_btn_furniture_on.png", nil, "BagLayer/filter_btn_furniture_on.png", var_0_18)
	else
		self.furnitureFilterBtn:loadTextures("BagLayer/filter_btn_furniture.png", nil, "BagLayer/filter_btn_furniture.png", var_0_18)
	end

	if self.bag_stat == var_0_30 then
		self.sellBtn:loadTextures("BagLayer/btn_sell.png", nil, "BagLayer/btn_sell.png", var_0_18)
		self.cancelBtn:setVisible(false)
		self.bagContent:setVisible(true)
		self.selectAllBtnBg:setVisible(false)
		self.selectAllHook:setVisible(false)
	elseif self.bag_stat == var_0_31 then
		self.sellBtn:loadTextures("BagLayer/btn_sell_sure.png", nil, "BagLayer/btn_sell_sure.png", var_0_18)
		self.cancelBtn:setVisible(true)
		self.bagContent:setVisible(false)
		self.selectAllBtnBg:setVisible(true)

		if self.selectAll then
			self.selectAllHook:setVisible(true)
		else
			self.selectAllHook:setVisible(false)
		end
	end

	self.filterButton:loadTextures("BagLayer/btn_filter.png", nil, "BagLayer/btn_filter.png", var_0_18)

	for iter_83_0, iter_83_1 in pairs(self.filterTbl.filterConfig) do
		if next(iter_83_1) and iter_83_0 ~= "use" then
			self.filterButton:loadTextures("BagLayer/btn_filter_on.png", nil, "BagLayer/btn_filter_on.png", var_0_18)
		end
	end
end

function BagLayerNew:createFilterPop()
	local var_84_0 = {
		filterType = self.selectedQuality,
		filterCallback = function(arg_85_0)
			self:filterCallback(arg_85_0)
		end,
		maskTouchCallback = function(arg_86_0)
			arg_86_0()
		end,
		sortOrderChangeCallback = function(arg_87_0)
			self:sortCallback(arg_87_0)
		end,
		initButtonConfig = {},
		defaultSortOrder = self.sortOrder
	}

	if self.selectedQuality == var_0_22 then
		var_84_0.filterTbl = 2
		var_84_0.bagType_partition = 2
	elseif self.selectedQuality == var_0_20 then
		var_84_0.bagType_partition = 1
	end

	local var_84_1 = FilterItemsPanelParts:create(var_84_0)

	var_84_1:setPositionY(-GameDisplay.fix_y)

	return var_84_1
end

function BagLayerNew:showFilterPop()
	if self.filterSpritePop then
		self.filterSpritePop:setSortOrderState(1, self.sortOrder == var_0_27 and {
			0,
			1
		} or {
			1,
			0
		})
		self.filterSpritePop:updateAllFilterBtn()
		self.filterSpritePop:playPopAni()
	else
		self.filterSpritePop = self:createFilterPop()

		self.rootLayer:addChild(self.filterSpritePop, 1000)
	end
end

function BagLayerNew:filterCallback(arg_89_1)
	self.filterTbl.sortType = arg_89_1.sortType or self.filterTbl

	for iter_89_0, iter_89_1 in pairs(arg_89_1.filterConfig) do
		self.filterTbl.filterConfig[iter_89_0] = global_deepCopy(iter_89_1)
	end

	self.oldCellCount = nil
	self.sortType = self.filterTbl.sortType

	self:updateEquip()
	self:updateTableView()
	self:updateFilterPanel()
end

function BagLayerNew:sortCallback(arg_90_1)
	self.orderFlag = true
	self.sortOrder = arg_90_1

	if self.bag_stat == var_0_31 then
		self:insertSelectedItem()
	end

	self:updateTableView()
end

function BagLayerNew:createTitleSprite()
	self.title = TitleSprite:create(({
		"BagLayer/title_componentlbag.png",
		"BagLayer/title_materialbag.png",
		"BagLayer/title_furnitrunesbag.png",
		"BagLayer/title_componentlbag.png",
		"BagLayer/title_labmaterialbag.png"
	})[self.selectedQuality == var_0_20 and 2 or self.selectedQuality == var_0_22 and 5 or self.selectedQuality], 2)

	self.title:setPosition(cc.p(0, GameDisplay.getUiScreenSize().height - self.title:getContentSize().height - GameDisplay.fix_y))
	self.rootLayer:addChild(self.title, 5)
end

function BagLayerNew:updateTitleSprite()
	self.title.title:loadTexture(({
		"BagLayer/title_componentlbag.png",
		"BagLayer/title_materialbag.png",
		"BagLayer/title_furnitrunesbag.png",
		"BagLayer/title_componentlbag.png",
		"BagLayer/title_labmaterialbag.png"
	})[self.selectedQuality == var_0_20 and 2 or self.selectedQuality == var_0_22 and 5 or self.selectedQuality], var_0_18)
end

function BagLayerNew.getTableLength(arg_93_0, arg_93_1)
	local var_93_0 = 0

	for iter_93_0, iter_93_1 in pairs(arg_93_1) do
		var_93_0 = var_93_0 + 1
	end

	return var_93_0
end

function BagLayerNew:insertSelectedItem()
	local var_94_0 = {}

	for iter_94_0, iter_94_1 in pairs(self.selectedItems) do
		table.insert(var_94_0, iter_94_1.entityid)
	end

	local var_94_1 = {}

	self.bagManager:getDataOfId(var_94_0, var_94_1)
	self.bagManager:sortData(var_94_1, self.sortType, 0)

	local var_94_2 = {}

	if self.sortOrder == var_0_26 then
		for iter_94_2, iter_94_3 in pairs(var_94_1) do
			var_94_2[#var_94_2 + 1] = iter_94_3.id
		end
	else
		local var_94_3 = #var_94_1

		while var_94_3 > 0 do
			var_94_2[#var_94_2 + 1] = var_94_1[var_94_3].id
			var_94_3 = var_94_3 - 1
		end
	end

	local function var_94_4(arg_95_0)
		local var_95_0 = {}

		self.equipCount = 0

		if playermodel.items[arg_95_0].itemtype == kITEM_COMPONENT then
			self.equipCount = self.equipCount + 1
			var_95_0.index = self.equipCount
			var_95_0.entityid = arg_95_0
			var_95_0.number = 1
		else
			local var_95_1 = self:createEquip(arg_95_0)

			var_95_0.number = var_95_1[1].number
			var_95_0.entityid = var_95_1[1].entityid
			self.equipCount = self.equipCount + 1
			var_95_0.index = self.equipCount
		end

		return var_95_0
	end

	if self.sortOrder == var_0_27 then
		local var_94_5 = 1

		while self.equips[var_94_5] do
			if self.selectedItems[self.equips[var_94_5].entityid] then
				table.remove(self.equips, var_94_5)
			else
				var_94_5 = var_94_5 + 1
			end
		end

		for iter_94_4, iter_94_5 in pairs(var_94_2) do
			table.insert(self.equips, 1, var_94_4(iter_94_5))
		end
	else
		local var_94_6 = 1

		while self.equips[var_94_6] do
			if self.selectedItems[self.equips[var_94_6].entityid] then
				table.remove(self.equips, var_94_6)
			else
				var_94_6 = var_94_6 + 1
			end
		end

		for iter_94_6, iter_94_7 in pairs(var_94_2) do
			self.equips[#self.equips + 1] = var_94_4(iter_94_7)
		end
	end

	local var_94_7 = #self.equips

	while var_94_7 > 0 do
		self.equips[var_94_7].index = var_94_7
		var_94_7 = var_94_7 - 1
	end
end

function BagLayerNew:createItem(arg_96_1)
	local var_96_0 = ItemSprite:createBigWithEntityId(self.equips[arg_96_1].entityid, self.equips[arg_96_1].number)
	local var_96_1 = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, var_0_18)

	var_96_1:setCascadeOpacityEnabled(true)

	var_96_1.entityid = self.equips[arg_96_1].entityid
	var_96_1.itemid = playermodel.items[self.equips[arg_96_1].entityid].itemid
	var_96_1.sp = var_96_0
	var_96_1.number = self.equips[arg_96_1].number
	var_96_1.index = self.equips[arg_96_1].index

	if playermodel.items[var_96_1.entityid].itemtype == kITEM_COMPONENT and var_96_0:getChildByName("lock") then
		local var_96_2 = var_96_0:getChildByName("lock")

		var_96_2.entityid = self.equips[arg_96_1].entityid

		var_96_2:addTouchEventListener(function(arg_97_0, arg_97_1)
			if arg_97_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:unlock(arg_97_0.entityid)
		end)
	end

	var_96_1.usedNum = self.equips[arg_96_1].usedNum or 0

	local var_96_3

	if config._DEBUG then
		var_96_3 = cc.Sprite:create("public/box/new_item_bg_on.png") or cc.Sprite:createWithSpriteFrameName("public/box/new_item_bg_on.png")
	end

	var_96_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_96_3:setPosition(cc.p(var_96_1:getContentSize().width / 2, var_96_1:getContentSize().height / 2))
	var_96_3:setName("selectedBg")
	var_96_3:setVisible(false)
	var_96_1:addChild(var_96_3, 1)

	local var_96_4 = ccui.Button:create("public/box/new_item_bg_cancle.png", "public/box/new_item_bg_cancle.png", "public/box/new_item_bg_cancle.png", var_0_18)

	var_96_4.key = arg_96_1

	var_96_4:setName("canelBnt")
	var_96_4:setPosition(22, 208)

	local var_96_5 = true

	var_96_4:addTouchEventListener(function(arg_98_0, arg_98_1)
		local function var_98_0(arg_99_0)
			if var_96_1.usedNum <= 0 then
				return
			end

			var_96_1.usedNum = var_96_1.usedNum - arg_99_0

			if var_96_1.usedNum <= 0 then
				var_96_1.usedNum = 0
				self.selectedItems[var_96_1.entityid] = nil
				self.equips[arg_98_0.key].usedNum = nil
				self.equips[arg_98_0.key].selected = false

				var_96_1:getChildByName("selectedBg"):setVisible(false)
			else
				self.selectedItems[var_96_1.entityid].number = var_96_1.usedNum
				self.equips[arg_98_0.key].usedNum = var_96_1.usedNum

				var_96_1:getChildByName("selectedBg"):getChildByName("label_num"):setString(var_96_1.usedNum)
			end
		end

		if arg_98_1 == ccui.TouchEventType.began or arg_98_1 == ccui.TouchEventType.moved then
			local var_98_1 = arg_98_0:getTouchBeganPosition()
			local var_98_2 = arg_98_0:getTouchMovePosition()

			self.movePos = var_98_2
			arg_98_0.pos = arg_98_0.pos or global_deepCopy(var_98_2)
			var_96_5 = true

			if arg_98_1 == ccui.TouchEventType.began then
				if self.bag_stat == var_0_31 and item_manager:can_stack(playermodel.items[var_96_1.entityid].itemtype) then
					self:startPress(function()
						if arg_98_0.pos and arg_98_0.pos.x == self.movePos.x and arg_98_0.pos.y == self.movePos.y or math.abs(var_98_1.y - self.movePos.y) < 10 and math.abs(var_98_1.x - self.movePos.x) < 10 then
							return true
						end

						return false
					end, function()
						self:endPress()
						self:startLongPressSelect(arg_98_0, var_98_0)

						var_96_5 = false
					end)
				end
			end
		elseif arg_98_1 == ccui.TouchEventType.canceled then
			self:endPress()

			arg_98_0.pos = nil

			arg_98_0:stopAllActions()
		elseif arg_98_1 == ccui.TouchEventType.ended then
			if math.abs(arg_98_0:getTouchBeganPosition().y - arg_98_0:getTouchEndPosition().y) > 50 then
				self:endPress()

				arg_98_0.pos = nil

				arg_98_0:stopAllActions()

				return
			end

			if not var_96_1.entityid then
				return
			end

			self:endPress()

			arg_98_0.pos = nil

			arg_98_0:stopAllActions()

			if var_96_5 then
				var_98_0(1)
			end
		end
	end)
	var_96_3:addChild(var_96_4)

	local var_96_6 = cc.Label:createWithTTF(var_96_1.usedNum, "fonts/newkj.ttf", 20)

	var_96_6:setPosition(168, 218)
	var_96_6:setColor(cc.c3b(73, 58, 68))
	var_96_6:setAnchorPoint(cc.p(1, 0.5))
	var_96_6:setName("label_num")
	var_96_3:addChild(var_96_6)
	var_96_0:setPosition(cc.p(var_96_1:getContentSize().width / 2, var_96_1:getContentSize().height / 2))
	var_96_0:setName("item")
	var_96_1:addChild(var_96_0)
	var_96_1:setSwallowTouches(false)

	local function var_96_7(arg_102_0, arg_102_1)
		if self.selectedQuality == 1 then
			if playermodel.items[arg_102_0.entityid].component_attr and playermodel.items[arg_102_0.entityid].component_attr.lock then
				global_ShowBlockWords(L_SELECT_EQUIP_MSG.Component.Lock)
				audio_manager:playeffectMusicTest("sound/invalid")

				return
			elseif playermodel.items[arg_102_0.entityid].component_attr and playermodel.items[arg_102_0.entityid].component_attr.use then
				global_ShowBlockWords(L_SELECT_EQUIP_MSG.Component.Using)
				audio_manager:playeffectMusicTest("sound/invalid")

				return
			end
		end

		if arg_102_0.usedNum >= arg_102_0.number then
			arg_102_0.usedNum = arg_102_0.number
			self.selectedItems[arg_102_0.entityid] = {
				entityid = arg_102_0.entityid,
				number = arg_102_0.usedNum,
				index = arg_102_0.index
			}

			return
		end

		self.tableIndex = self.curIndex
		arg_102_0.usedNum = arg_102_0.usedNum + arg_102_1

		if arg_102_0.usedNum > arg_102_0.number then
			arg_102_0.usedNum = arg_102_0.number

			global_ShowBlockWords(L_SELECT_EQUIP_MSG.Non_Items)
			audio_manager:playeffectMusicTest("sound/invalid")
		end

		if self.equips[arg_102_0.index] then
			self.equips[arg_102_0.index].usedNum = arg_102_0.usedNum
		end

		self.selectedItems[arg_102_0.entityid] = {
			entityid = arg_102_0.entityid,
			number = arg_102_0.usedNum,
			index = arg_102_0.index
		}

		if arg_102_0.usedNum <= 0 then
			self.selectedItems[arg_102_0.entityid] = nil
			self.equips[arg_102_0.index].usedNum = nil

			arg_102_0:getChildByName("selectedBg"):setVisible(false)
		end
	end

	local var_96_8 = true

	var_96_1:addTouchEventListener(function(arg_103_0, arg_103_1)
		local function var_103_0(arg_104_0)
			if self.bag_stat == var_0_31 then
				self.equips[arg_103_0.index].selected = true

				var_96_7(arg_103_0, arg_104_0)

				for iter_104_0, iter_104_1 in pairs(self.selectedItems) do
					if iter_104_1.entityid == arg_103_0.entityid then
						arg_103_0:getChildByName("selectedBg"):setVisible(true)
						arg_103_0:getChildByName("selectedBg"):getChildByName("label_num"):setString(iter_104_1.number)

						arg_103_0.usedNum = iter_104_1.number
					end
				end

				local var_104_0 = arg_103_0:getChildByName("selectedBg"):getChildByName("canelBnt").key

				if self.equips[var_104_0].usedNum and self.equips[var_104_0].usedNum > 0 then
					var_96_1:getChildByName("selectedBg"):setVisible(true)
					var_96_1:getChildByName("selectedBg"):getChildByName("label_num"):setString(self.equips[var_104_0].usedNum)
				end
			else
				if arg_103_1 ~= ccui.TouchEventType.ended then
					return
				end

				self.tableIndex = arg_103_0:getParent():getIdx()

				self:createInfoPanel(arg_103_0.entityid)

				self.curSelectEntityid = arg_103_0.entityid

				self:updateShowingCell()
			end
		end

		if arg_103_1 == ccui.TouchEventType.began or arg_103_1 == ccui.TouchEventType.moved then
			local var_103_1 = arg_103_0:getTouchBeganPosition()
			local var_103_2 = arg_103_0:getTouchMovePosition()

			self.movePos = var_103_2
			arg_103_0.pos = arg_103_0.pos or global_deepCopy(var_103_2)
			var_96_8 = true

			if arg_103_1 == ccui.TouchEventType.began then
				if self.bag_stat == var_0_31 and item_manager:can_stack(playermodel.items[var_96_1.entityid].itemtype) then
					self:startPress(function()
						if arg_103_0.pos and arg_103_0.pos.x == self.movePos.x and arg_103_0.pos.y == self.movePos.y or math.abs(var_103_1.y - self.movePos.y) < 10 and math.abs(var_103_1.x - self.movePos.x) < 10 then
							return true
						end

						return false
					end, function()
						self:endPress()
						self:startLongPressSelect(arg_103_0, var_103_0)

						var_96_8 = false
					end)
				end
			end
		elseif arg_103_1 == ccui.TouchEventType.canceled then
			self:endPress()

			arg_103_0.pos = nil

			arg_103_0:stopAllActions()
		elseif arg_103_1 == ccui.TouchEventType.ended then
			if math.abs(arg_103_0:getTouchBeganPosition().y - arg_103_0:getTouchEndPosition().y) > 50 then
				self:endPress()

				arg_103_0.pos = nil

				arg_103_0:stopAllActions()

				return
			end

			if not arg_103_0.entityid then
				return
			end

			self:endPress()

			arg_103_0.pos = nil

			arg_103_0:stopAllActions()

			if var_96_8 then
				var_103_0(1)
			end
		end
	end)

	if var_96_1:getChildByName("item"):getChildByName("attr") then
		var_96_1:getChildByName("item"):getChildByName("attr"):setVisible(self.button_attribute.is_show_attribute)
	end

	return var_96_1
end

function BagLayerNew:updateItem(arg_107_1, arg_107_2)
	arg_107_1:getChildByName("item"):updateBigInfo(self.button_attribute.is_show_attribute, self.equips[arg_107_2].entityid)

	local var_107_0 = arg_107_1:getChildByName("item")

	arg_107_1.entityid = self.equips[arg_107_2].entityid
	arg_107_1.itemid = playermodel.items[self.equips[arg_107_2].entityid].itemid
	arg_107_1.sp = var_107_0
	arg_107_1.number = self.equips[arg_107_2].number
	arg_107_1.index = self.equips[arg_107_2].index
	arg_107_1.usedNum = self.equips[arg_107_2].usedNum or 0

	if arg_107_1:getChildByName("heightLight") then
		arg_107_1:removeChildByName("heightLight")
	end

	if self.bag_stat == var_0_30 then
		if self.curSelectEntityid == arg_107_1.entityid then
			self:createItemHightLight(arg_107_1)
		end
	else
		arg_107_1:getChildByName("selectedBg"):getChildByName("canelBnt").key = arg_107_2
	end

	if arg_107_1:getChildByName("item"):getChildByName("attr") then
		arg_107_1:getChildByName("item"):getChildByName("attr"):setVisible(self.button_attribute.is_show_attribute)
	end

	if playermodel.items[arg_107_1.entityid].itemtype == kITEM_COMPONENT and var_107_0:getChildByName("lock") then
		var_107_0:getChildByName("lock").entityid = self.equips[arg_107_2].entityid
	end

	if playermodel.items[arg_107_1.entityid].itemtype == kITEM_COMPONENT then
		if var_107_0:getChildByName("lock") then
			local var_107_1 = var_107_0:getChildByName("lock")

			var_107_1.entityid = self.equips[arg_107_2].entityid

			var_107_1:addTouchEventListener(function(arg_108_0, arg_108_1)
				if arg_108_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:unlock(arg_108_0.entityid)
			end)
		end

		if playermodel.items[arg_107_1.entityid].component_attr.attr2 then
			if var_107_0:getChildByName("rainbowBg") then
				var_107_0:getChildByName("rainbowBg"):setVisible(true)
			else
				local var_107_2 = ccui.ImageView:create("public/box/rainbow_bg.png", var_0_18)

				var_107_2:setAnchorPoint(1, 1)
				var_107_2:setPosition(var_107_0:getContentSize().width, var_107_0:getContentSize().height)
				var_107_2:setName("rainbowBg")
				var_107_0:addChild(var_107_2, 100)
			end
		elseif var_107_0:getChildByName("rainbowBg") then
			var_107_0:getChildByName("rainbowBg"):setVisible(false)
		end
	end

	arg_107_1:getChildByName("selectedBg"):setVisible(false)

	for iter_107_0, iter_107_1 in pairs(self.selectedItems) do
		if iter_107_1.entityid == self.equips[arg_107_2].entityid and self.bag_stat ~= var_0_30 then
			arg_107_1:getChildByName("selectedBg"):setVisible(true)
			arg_107_1:getChildByName("selectedBg"):getChildByName("label_num"):setString(iter_107_1.number)

			arg_107_1.usedNum = iter_107_1.number
		end
	end
end

function BagLayerNew:updatebagContent()
	if self.bag_stat == var_0_30 then
		self.bagContent:setVisible(true)
	end

	local var_109_0 = ({
		[var_0_19] = {
			bagweightID = 3
		},
		[var_0_20] = {
			bagweightID = 6
		},
		[var_0_21] = {
			bagweightID = 4
		},
		[var_0_22] = {
			bagweightID = 5
		}
	})[self.selectedQuality].bagweightID

	local function var_109_1(...)
		local var_110_0 = self.bagContent:getChildByName("desnum")
		local var_110_1 = self.bagContent:getChildByName("curnum")
		local var_110_2 = self.bagContent:getChildByName("maxnum")

		var_110_1:setString(math.floor(playermodel.bagweight[var_109_0].weight))
		var_110_2:setString("/" .. playermodel.bagweight[var_109_0].limit)
		var_110_1:setPositionX(var_110_0:getPositionX() + var_110_0:getContentSize().width)
		var_110_2:setPositionX(var_110_1:getPositionX() + var_110_1:getContentSize().width)

		if playermodel.bagweight[var_109_0].weight >= playermodel.bagweight[var_109_0].limit then
			var_110_1:setColor((cc.c3b(232, 0, 0)))
		else
			var_110_1:setColor((cc.c3b(249, 188, 0)))
		end
	end

	var_109_1()

	local function var_109_2(arg_111_0)
		item_manager:addMaxBagWeight(var_109_0, arg_111_0, function(arg_112_0)
			print("result", arg_112_0)

			if arg_112_0 == 1 then
				var_109_1()
				global_ShowBlockWords(string.format(L_BAG_WARNING.Add_Content_Warning[1], BAG_ADD_WEIGHT * arg_111_0), RISE_WORDS_SUCCESS)
				audio_manager:playeffectMusicTest("sound/invalid")

				if var_109_0 == 6 then
					AnalyticManager.buyWeight6({
						WeightLimit = playermodel.bagweight[var_109_0].limit
					})
				elseif var_109_0 == 5 then
					AnalyticManager.buyWeight5({
						WeightLimit = playermodel.bagweight[var_109_0].limit
					})
				elseif var_109_0 == 4 then
					AnalyticManager.buyWeight4({
						WeightLimit = playermodel.bagweight[var_109_0].limit
					})
				end
			elseif arg_112_0 == 2 then
				LayerManager:pushInLayer("PopGoBuyDiamond", {
					is_need_pop_layer = 1
				})
			elseif arg_112_0 == 3 then
				global_ShowBlockWords(L_BAG_WARNING.Add_Content_Warning[3])
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end)
	end

	local function var_109_3(arg_113_0)
		LayerManager:pushInLayer("PopBuyBagWeight", {
			surecallback = var_109_2,
			weightid = var_109_0,
			time = arg_113_0
		})
	end

	local function var_109_4(arg_114_0, arg_114_1)
		self.bagContent:setBright(true)

		if arg_114_0 == 1 then
			if arg_114_1 >= BAG_MAX_ADD_TIME[var_109_0] then
				global_ShowBlockWords(L_BAG_WARNING.Bag_Status_Warning)
				audio_manager:playeffectMusicTest("sound/invalid")
			else
				var_109_3(arg_114_1)
			end
		end
	end

	self.bagContent:addTouchEventListener(function(arg_115_0, arg_115_1)
		if arg_115_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_115_0:isBright() then
			return
		end

		arg_115_0:setBright(false)
		item_manager:getBagWeightStatus(var_109_0, var_109_4)
	end)
end

function BagLayerNew:initBag()
	self.bagPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_right")

	self.rootLayer:getChildByName("right_bg"):loadTexture(TASK_BG)
	self:updateEquip()
	self:updateTableView()
	self:updatebagContent(self.selectedQuality)
end

function BagLayerNew.getComponentDrop(arg_117_0, arg_117_1)
	local var_117_2 = component_manager:getComponentStrengthTable()
	local var_117_3 = 0

	if item_data[playermodel.items[arg_117_1].itemid] then
		var_117_3 = item_data[playermodel.items[arg_117_1].itemid].sale_price
	end

	local var_117_4 = playermodel.items[arg_117_1].component_attr.extra

	return ((playermodel.items[arg_117_1].component_attr.extra and var_117_4 > 0 or nil) and (var_117_2[item_data[playermodel.items[arg_117_1].itemid].equip_quality][item_data[playermodel.items[arg_117_1].itemid].level][var_117_4] and var_117_2[item_data[playermodel.items[arg_117_1].itemid].equip_quality][item_data[playermodel.items[arg_117_1].itemid].level][var_117_4].sale_price or 0)) + var_117_3
end

function BagLayerNew:updateSortOderIcon()
	self.orderFlag = not self.orderFlag
	self.sortOrder = self.sortOrder == var_0_26 and var_0_27 or var_0_26
end

function BagLayerNew:saveCurSortOrder()
	self.col3SortOrder = self.sortOrder
end

function BagLayerNew:resetSortOrder()
	self.sortOrder = self.col3SortOrder
end

function BagLayerNew:updateTableView()
	if self.bagPanel:getChildByName("tableView") then
		self.bagPanel:getChildByName("tableView"):removeFromParent()
	end

	self.tableView = self.bagPanel:getChildByName("tableView")

	local var_121_0 = self.tableViewHeight + GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT

	if not self.tableView then
		self.tableView = cc.TableView:create(cc.size(self.tableViewWidth, var_121_0))

		self.tableView:setPosition(cc.p(self.tableViewPosX, self.tableViewPosY - GameDisplay.getUiScreenSize().height + config._DESIGN_HEIGHT))
		self.tableView:setName("tableView")
		self.tableView:setDelegate()
		self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
		self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
		self.tableView:setAnchorPoint(cc.p(0, 0))
		self.bagPanel:addChild(self.tableView, 2)
	end

	local function var_121_1(arg_122_0, arg_122_1)
		local var_122_0 = self:getColNumber()

		for iter_122_0 = 1, self:getColNumber() do
			local var_122_1 = arg_122_1 * self:getColNumber() + iter_122_0

			if self.sortOrder == var_0_26 then
				var_122_1 = #self.equips - var_122_1 + 1
			end

			local var_122_2 = arg_122_0:getChildByName("equip" .. iter_122_0)

			if var_122_2 then
				if self.equips[var_122_1] then
					var_122_2:setVisible(true)
					self:updateItem(var_122_2, var_122_1)
				else
					var_122_2:setVisible(false)
				end

				var_122_2:setLocalZOrder(var_122_0 - iter_122_0)
			elseif self.equips[var_122_1] then
				local var_122_3 = self:createItem(var_122_1)

				self:updateItem(var_122_3, var_122_1)
				var_122_3:setScale(0.85)
				var_122_3:setName("equip" .. iter_122_0)

				local var_122_4 = var_122_3:getContentSize()

				var_122_3:setPositionX((iter_122_0 * 2 - 1) / self:getColNumber() / 2 * 640)
				var_122_3:setPositionY(var_122_4.height / 2 * var_122_3:getScale())
				arg_122_0:addChild(var_122_3)
				var_122_3:setLocalZOrder(var_122_0 - iter_122_0)
			end
		end

		if self.startRunOutAni then
			self.startIndex = self.startIndex or arg_122_1

			local var_122_5 = LAYER_OUT_TIME / math.ceil(var_121_0 / var_0_25)

			for iter_122_1 = 1, self:getColNumber() do
				if arg_122_0:getChildByName("equip" .. iter_122_1) then
					arg_122_0:getChildByName("equip" .. iter_122_1):runAction(cc.Sequence:create(cc.DelayTime:create((arg_122_1 - self.startIndex) * var_122_5), cc.FadeOut:create(var_122_5)))
				end
			end
		end

		if self.selectTblAni then
			local var_122_6 = LAYER_OUT_TIME / math.ceil(var_121_0 / var_0_25) * 1.5

			for iter_122_2 = 1, self:getColNumber() do
				if arg_122_0:getChildByName("equip" .. iter_122_2) then
					arg_122_0:getChildByName("equip" .. iter_122_2):setOpacity(0)
					arg_122_0:getChildByName("equip" .. iter_122_2):runAction(cc.Sequence:create(cc.DelayTime:create(arg_122_1 * var_122_6), cc.FadeIn:create(var_122_6)))
				end
			end
		else
			for iter_122_3 = 1, self:getColNumber() do
				if arg_122_0:getChildByName("equip" .. iter_122_3) then
					arg_122_0:getChildByName("equip" .. iter_122_3):setOpacity(255)
				end
			end
		end
	end

	self.tableView:registerScriptHandler(function(arg_124_0, arg_124_1)
		return var_0_24, var_0_25
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:registerScriptHandler(function(arg_123_0, arg_123_1)
		local var_123_0 = arg_123_0:dequeueCell() or cc.TableViewCell:create()

		self.curIndex = arg_123_1

		var_121_1(var_123_0, arg_123_1)

		return var_123_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:registerScriptHandler(function(arg_125_0, arg_125_1)
		return self.oldCellCount or self:getTableViewCount()
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:reloadData()
end

function BagLayerNew:getTableViewCount()
	return math.ceil(#self.equips / self:getColNumber())
end

function BagLayerNew:updateCurData(arg_127_1)
	local var_127_0 = {}
	local var_127_1 = {}

	arg_127_1 = arg_127_1 or {}

	local var_127_2 = arg_127_1[1]

	if not arg_127_1[1] then
		return
	end

	if type(var_127_2) == "table" then
		for iter_127_0, iter_127_1 in pairs(arg_127_1) do
			var_127_0[iter_127_1.entityid] = iter_127_1.number
		end

		local var_127_3 = 1

		while var_127_3 <= #self.equips do
			self.equips[var_127_3].selected = false

			if var_127_0[self.equips[var_127_3].entityid] then
				self.equips[var_127_3].number = self.equips[var_127_3].number - var_127_0[self.equips[var_127_3].entityid]
			end

			if self.equips[var_127_3].number <= 0 then
				var_127_1[self.equips[var_127_3].entityid] = self.equips[var_127_3].entityid

				table.remove(self.equips, var_127_3)
			else
				self.equips[var_127_3].index = var_127_3
				var_127_3 = var_127_3 + 1
			end
		end
	else
		for iter_127_2, iter_127_3 in pairs(arg_127_1) do
			var_127_0[iter_127_3] = true
		end

		local var_127_4 = 1

		while var_127_4 <= #self.equips do
			self.equips[var_127_4].selected = false

			if var_127_0[self.equips[var_127_4].entityid] then
				var_127_1[self.equips[var_127_4].entityid] = self.equips[var_127_4].entityid

				table.remove(self.equips, var_127_4)
			else
				self.equips[var_127_4].index = var_127_4
				var_127_4 = var_127_4 + 1
			end
		end
	end

	for iter_127_4, iter_127_5 in pairs(self.equips) do
		self.equips[iter_127_4].selected = false
	end

	self:updatebagContent()

	for iter_127_6, iter_127_7 in pairs(self.selectedItems) do
		self.selectedItems[iter_127_6] = nil
	end

	self.selectedItems = {}
	self.curSelectEntityid = nil
	self.oldEquips = global_deepCopy(self.equips)

	self.bagManager:removeValue(var_127_1)
	self:updateTableView()
end

function BagLayerNew:initBottom()
	self.bottomList = BottomBtnList:create(function(arg_129_0, arg_129_1)
		if arg_129_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.startRunOutAni = true

		self:updateTableView()
		KeyCodeManager:onKeyReleasedCallFunc()
		self.bagManager:clear()
	end, conf)

	self.bottomList:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.rootLayer:addChild(self.bottomList, 10)
	self:initBag()

	return true
end

function BagLayerNew.unlock(arg_130_0, arg_130_1, arg_130_2)
	if playermodel.items[arg_130_1].itemtype == kITEM_COMPONENT then
		(function(arg_131_0)
			network:rpc("lock_item", {
				locktype = playermodel.items[arg_130_1].component_attr.lock and 1 or 2,
				entityid = arg_130_1
			}, function(arg_132_0)
				if arg_132_0.result == 1 then
					playermodel.items[arg_130_1].component_attr.lock = arg_132_0.lock

					if not playermodel.items[arg_130_1].component_attr.lock then
						global_ShowBlockWords(L_SELECT_EQUIP_MSG.Component.UnLock)

						arg_130_0.bagUpdateFlag = true

						arg_130_0:updateShowingCell()
					end
				else
					l2Log("unlock fail")
				end
			end)
		end)()
	end
end

function BagLayerNew:startPress(arg_133_1, arg_133_2)
	local var_133_0 = 0.1

	if not self.timer then
		self.timer = cc.Node:create()

		self:addChild(self.timer)

		self.timer1 = cc.Node:create()

		self:addChild(self.timer1)
	end

	self.timer1:runAction(cc.Sequence:create(cc.DelayTime:create(var_0_29), cc.CallFunc:create(function()
		if arg_133_1() then
			self:showLongPressProgress()
			self.timer:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
				self:setLongPressProgressPercent(var_133_0 / var_0_28 * 100)

				if var_133_0 >= var_0_28 then
					self.timer:stopAllActions()

					if arg_133_2 then
						arg_133_2()
					end
				end

				var_133_0 = var_133_0 + 0.016666666666666666
			end))))
		else
			self:endPress()
		end
	end)))
end

function BagLayerNew:endPress()
	if self.timer then
		self.timer:stopAllActions()
		self.timer1:stopAllActions()
	end

	self:hideLongPressProgress()
end

function BagLayerNew:showLongPressProgress()
	if not self.progress then
		self.progressBg = ccui.Layout:create()

		self.progressBg:setTouchEnabled(true)
		self.progressBg:setContentSize(GameDisplay.getUiScreenSize())
		self.progressBg:setAnchorPoint(cc.p(0.5, 0.5))
		self.progressBg:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
		self.progressBg:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		self.progressBg:setBackGroundColor(cc.c3b(0, 0, 0))
		self.progressBg:setBackGroundColorOpacity(128)
		self.progressBg:setPosition(cc.p(320, 568))
		self.rootLayer:addChild(self.progressBg, 10000)

		self.progress = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("public/button/press_bar.png") or cc.Sprite:createWithSpriteFrameName("public/button/press_bar.png")))

		self.progress:setAnchorPoint(cc.p(0.5, 0.5))
		self.progress:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
		self.progress:setPositionX(self.progressBg:getContentSize().width / 2)
		self.progress:setPositionY(self.progressBg:getContentSize().height / 2)
		self.progress:setReverseDirection(false)
		self.progressBg:addChild(self.progress)
	end

	self.progressBg:setVisible(true)
	self.progress:setPercentage(50)
end

function BagLayerNew:setLongPressProgressPercent(arg_138_1)
	if self.progress then
		self.progress:setPercentage(arg_138_1)
	end
end

function BagLayerNew:hideLongPressProgress()
	if self.progress then
		self.progressBg:setVisible(false)
	end
end

function BagLayerNew.getColNumber(arg_140_0, ...)
	return 4
end

function BagLayerNew:updateShowingCell(...)
	self:saveDecomposeBeforeShowingCells()
	self:updateDecomposeAfterShowingCells()
end

function BagLayerNew.fullScreen(arg_142_0, arg_142_1, arg_142_2)
	arg_142_1:setPositionY(arg_142_1:getPositionY() - GameDisplay.fix_y)
	arg_142_2:setPositionY(arg_142_2:getPositionY() - GameDisplay.notch_height)
end

function BagLayerNew:createItemHightLight(arg_143_1)
	local var_143_2 = ccui.Layout:create()
	local var_143_3 = "public/box/new_item_bg_on1.png"

	if self.bag_stat ~= var_0_30 then
		var_143_3 = "public/box/new_item_bg_on2.png"
	end

	local var_143_4

	if config._DEBUG then
		var_143_4 = cc.Sprite:create(var_143_3) or cc.Sprite:createWithSpriteFrameName(var_143_3)
	end

	var_143_4:setPosition(arg_143_1:getContentSize().width / 2, arg_143_1:getContentSize().height / 2 - 5)
	var_143_2:addChild(var_143_4)

	if self.bag_stat == var_0_30 then
		local var_143_5 = {}

		for iter_143_0 = 1, 2 do
			if iter_143_0 == 1 then
				if config._DEBUG then
					var_143_5[iter_143_0] = cc.Sprite:create("public/box/new_item_bg_on2.png") or cc.Sprite:createWithSpriteFrameName("public/box/new_item_bg_on2.png")
				end

				var_143_5[iter_143_0]:setScale(1.1)
				var_143_5[iter_143_0]:setOpacity(0)
				var_143_5[iter_143_0]:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)))))
			else
				if config._DEBUG then
					var_143_5[iter_143_0] = cc.Sprite:create("public/box/new_item_bg_on2.png") or cc.Sprite:createWithSpriteFrameName("public/box/new_item_bg_on2.png")
				end

				var_143_5[iter_143_0]:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)))))
			end

			var_143_5[iter_143_0]:setPosition(arg_143_1:getContentSize().width / 2, (arg_143_1:getContentSize().height - 5) / 2)
			var_143_2:addChild(var_143_5[iter_143_0])
		end
	end

	var_143_2:setName("heightLight")
	arg_143_1:addChild(var_143_2)
end

function BagLayerNew:getCurSystemId()
	local var_144_1 = {
		[var_0_19] = 503,
		[var_0_20] = 504,
		[var_0_21] = 505,
		[var_0_22] = 502
	}

	return self.selectedQuality == var_0_22 and var_144_1[5] or var_144_1[self.selectedQuality]
end

function BagLayerNew:saveDecomposeBeforeShowingCells(arg_145_1)
	self.oldCellCount = self.oldCellCount or self:getTableViewCount()

	local var_145_0 = {
		cellsize = cc.size(var_0_24, var_0_25)
	}

	var_145_0.maxcount = arg_145_1 and arg_145_1 or self:getTableViewCount()
	self.oldStartidx, self.oldEndidx = GetTableViewShowCellIdx(self.tableView, var_145_0)
end

function BagLayerNew:updateDecomposeAfterShowingCells()
	local var_146_0 = self:getTableViewCount()

	if var_146_0 > self.oldCellCount then
		self.oldCellCount = var_146_0

		self.tableView:reloadData()
	else
		for iter_146_0 = self.oldStartidx, self.oldEndidx do
			self.tableView:updateCellAtIndex(iter_146_0)
		end
	end
end

function BagLayerNew:updateSelectAllData(...)
	if self.selectAll then
		for iter_147_0, iter_147_1 in pairs(self.equips) do
			if playermodel.items[iter_147_1.entityid].component_attr and (playermodel.items[iter_147_1.entityid].component_attr.lock or playermodel.items[iter_147_1.entityid].component_attr.use) then
				-- block empty
			else
				self.selectedItems[iter_147_1.entityid] = {
					entityid = iter_147_1.entityid,
					number = iter_147_1.number,
					index = iter_147_1.index
				}
			end

			if 0 >= 500 then
				return
			end
		end
	else
		self.selectedItems = {}
	end
end

function BagLayerNew:showSellDrop(arg_148_1)
	local function var_148_0(arg_149_0, arg_149_1)
		local var_149_0 = {
			[kITEM_COMPONENT] = function()
				return self:getComponentDrop(arg_149_1.entityid)
			end
		}

		return var_149_0[item_data[playermodel.items[arg_149_1.entityid].itemid].bag_item_type] and var_149_0[item_data[playermodel.items[arg_149_1.entityid].itemid].bag_item_type]() or (function()
			return item_data[playermodel.items[arg_149_1.entityid].itemid].sale_price * arg_149_1.number
		end)()
	end

	if not self.selectedItems or not next(self.selectedItems) then
		global_ShowBlockWords(L_SELECT_EQUIP_MSG.Unselected_Parts)

		return
	end

	local var_148_1 = 0

	for iter_148_0, iter_148_1 in pairs(self.selectedItems) do
		var_148_1 = var_148_1 + var_148_0(iter_148_0, iter_148_1)
	end

	LayerManager:pushInLayer("BagSellItemPopLayer", {
		sureCallback = arg_148_1,
		gold = var_148_1
	})
end

function BagLayerNew.trans_overdue_item(arg_152_0, ...)
	local var_152_0 = RoleDefault:getInstance():getIntegerForKey("trans_overdue_item", 0)

	RoleDefault:getInstance():setIntegerForKey("trans_overdue_item", (tonumber(os.date("%j", require("controller.time_check_manager"):getCurTime()))))
	item_manager:trans_overdue_item(function(arg_153_0)
		if arg_153_0.result == 1 and next(arg_153_0.items) then
			LayerManager:pushInLayer("PopTransOverdueItemLayer", {
				items = arg_153_0.items,
				consumes = arg_153_0.consumes
			})

			arg_152_0.bagUpdateFlag = true

			arg_152_0:updateEquip()
			arg_152_0:updateShowingCell()
			arg_152_0:updateTableView()
			arg_152_0.tableView:scrollToIndex(math.min((arg_152_0.tableIndex or 0) + 1, arg_152_0:getTableViewCount() - 1), false)
		end
	end)
end

function BagLayerNew:registerEvent(...)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("hand_of_midas", function(arg_155_0)
		if item_manager:getItemNumber(6800411) == 0 then
			self.bagUpdateFlag = true

			self:updateEquip()
			self:updateShowingCell()
			self:updateTableView()
			self.tableView:scrollToIndex(math.min((self.tableIndex or 0) + 1, self:getTableViewCount() - 1), false)
		else
			self:updateShowingCell()
		end
	end), self)
end

return BagLayerNew
