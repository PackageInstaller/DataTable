ItemsPanel = class("ItemsPanel", function()
	return cc.Layer:create()
end)

local network = require("network.network")
local item_data = require("data.item_data")
local var_0_2 = require("data.item_data")
local component_effect_data = require("data.component_effect_data")
local core_data = require("data.core_data")
local servant_data = require("data.servant_data")
local var_0_6 = require("data.item_data")
local furnituresuit_data = require("data.furnituresuit_data")
local furniture_data = require("data.furniture_data")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local playermodel = require("model.playermodel")
local component_manager = require("controller.component_manager")
local item_manager = require("controller.item_manager")
local weapon_manager = require("controller.weapon_manager")
local bag_manager = require("controller.bag_manager")
local filter_config_manager = require("controller.filter_config_manager")
local audio_manager = require("controller.audio_manager")
local core_manager = require("controller.core_manager")
local dormitory_manager = require("controller.dormitory_manager")
local shop_manager = require("controller.shop_manager")
local array_manager = require("controller.array_manager")
local discount_manager = require("controller.discount_manager")
local Utility = require("common.Utility")

require("view.Sprite.ItemSprite")
require("view.Sprite.FilterSprite")
require("view.Sprite.FilterListSprite")

local var_0_24
local var_0_33 = 1
local var_0_34 = 2
local var_0_37 = config._DEBUG and 0 or 1
local var_0_38 = 600
local var_0_39 = 1010
local var_0_40 = 700
local var_0_42 = 42
local var_0_43 = 60
local var_0_44 = 640
local var_0_45 = 190
local var_0_46 = {
	cc.p(90, 92),
	cc.p(235, 92),
	cc.p(380, 92),
	(cc.p(525, 92))
}
local var_0_47 = "itempanel/item_unchoosed.png"
local var_0_48 = "itempanel/item_bg.png"
local var_0_49 = "itempanel/item_unequiped.png"
local var_0_52 = 0
local var_0_53 = 1
local var_0_54 = 2
local var_0_55 = 3
local var_0_57 = 100
local var_0_58 = {
	function()
		return playermodel.gold
	end,
	[0] = function()
		return playermodel.diamond
	end,
	function()
		return playermodel.honor
	end,
	function()
		return playermodel.explorecoin
	end,
	[100] = function()
		return 0
	end
}

setmetatable(var_0_58, {
	__index = function(arg_7_0, arg_7_1)
		return function()
			return item_manager:getItemNumber(arg_7_1)
		end
	end
})

local var_0_59 = {
	DAMAGE_REDUCE = 4,
	ADD_ATTACK = 5,
	CD = 2,
	MAGIC_IMMUNE = 1,
	FIRM = 6,
	ATTACK_SPEED = 3
}
local var_0_60 = {
	STRENGTH = 4,
	QUALITY = 3,
	SCORE = 1,
	LEVEL = 2,
	ROLE = 6,
	POS = 5
}
local var_0_61 = {
	STAR5 = 5,
	STAR3 = 3,
	STAR2 = 2,
	STAR1 = 1,
	STAR4 = 4
}
local var_0_62 = {
	[ITEMPANEL_TYPE_ROLE_COMPONENT] = L_ITEM_CONFIG_NAME.ITEMPANEL_TYPE_ROLE_COMPONENT,
	[ITEMPANEL_TYPE_SMELT_COMPONENT] = L_ITEM_CONFIG_NAME.ITEMPANEL_TYPE_SMELT_COMPONENT,
	[ITEMPANEL_TYPE_ROLE_WEAPON] = L_ITEM_CONFIG_NAME.ITEMPANEL_TYPE_ROLE_WEAPON,
	[ITEMPANEL_TYPE_WEAPON_STRENGTHEN] = L_ITEM_CONFIG_NAME.ITEMPANEL_TYPE_WEAPON_STRENGTHEN,
	[ITEMPANEL_TYPE_UPGRADE_WEAPON] = L_ITEM_CONFIG_NAME.ITEMPANEL_TYPE_UPGRADE_WEAPON,
	[ITEMPANEL_TYPE_COOK_ADD_FOOD] = L_ITEM_CONFIG_NAME.ITEMPANEL_TYPE_COOK_ADD_FOOD,
	[ITEMPANEL_TYPE_DORM_FURNITURE] = L_ITEM_CONFIG_NAME.ITEMPANEL_TYPE_DORM_FURNITURE,
	[ITEMPANEL_TYPE_MEDAL] = L_ITEM_CONFIG_NAME.ITEMPANEL_TYPE_MEDAL
}
local var_0_63 = {
	[ITEMPANEL_TYPE_ROLE_COMPONENT] = {
		filter_table = {
			{
				var_0_59.CD,
				var_0_59.DAMAGE_REDUCE,
				var_0_59.ADD_ATTACK
			},
			{
				"white_1",
				"green_2",
				"blue_3",
				"purple_4",
				"orange_5"
			},
			{
				"attr_1",
				"attr_2",
				"attr_3",
				"attr_4",
				"attr_5",
				"attr_6",
				"attr_7",
				"attr_8",
				"attr_9",
				"attr_10"
			}
		},
		filter_str = {
			[var_0_59.CD] = L_COMPONENT_EFFECT[var_0_59.CD],
			[var_0_59.DAMAGE_REDUCE] = L_COMPONENT_EFFECT[var_0_59.DAMAGE_REDUCE],
			[var_0_59.ADD_ATTACK] = L_COMPONENT_EFFECT[var_0_59.ADD_ATTACK],
			white_1 = L_SORT_COLOR[1],
			green_2 = L_SORT_COLOR[2],
			blue_3 = L_SORT_COLOR[3],
			purple_4 = L_SORT_COLOR[4],
			orange_5 = L_SORT_COLOR[5],
			attr_1 = L_COMPONENT_ATTR[1],
			attr_2 = L_COMPONENT_ATTR[2],
			attr_3 = L_COMPONENT_ATTR[3],
			attr_4 = L_COMPONENT_ATTR[4],
			attr_5 = L_COMPONENT_ATTR[5],
			attr_6 = L_COMPONENT_ATTR[6],
			attr_7 = L_COMPONENT_ATTR[7],
			attr_8 = L_COMPONENT_ATTR[8],
			attr_9 = L_COMPONENT_ATTR[9],
			attr_10 = L_COMPONENT_ATTR[10]
		},
		filter_type_str = L_ITEMPANEL_FILTER_TYPE_STR.ITEMPANEL_TYPE_ROLE_COMPONENT,
		sort_table = {
			var_0_60.SCORE,
			var_0_60.LEVEL,
			var_0_60.QUALITY,
			var_0_60.STRENGTH
		},
		sort_str = {
			[var_0_60.SCORE] = L_COMPONENT_SORT[var_0_60.SCORE],
			[var_0_60.LEVEL] = L_COMPONENT_SORT[var_0_60.LEVEL],
			[var_0_60.QUALITY] = L_COMPONENT_SORT[var_0_60.QUALITY],
			[var_0_60.STRENGTH] = L_COMPONENT_SORT[var_0_60.STRENGTH]
		},
		default_sort = var_0_60.SCORE
	},
	[ITEMPANEL_TYPE_SMELT_COMPONENT] = {
		filter_table = {
			{
				var_0_59.CD,
				var_0_59.DAMAGE_REDUCE,
				var_0_59.ADD_ATTACK
			},
			{
				"tank",
				"assassin",
				"fighter",
				"shooter",
				"witcher",
				"support"
			},
			{
				[1] = "remote",
				[2] = "melee"
			}
		},
		filter_str = {
			[var_0_59.CD] = L_COMPONENT_EFFECT[var_0_59.CD],
			[var_0_59.DAMAGE_REDUCE] = L_COMPONENT_EFFECT[var_0_59.DAMAGE_REDUCE],
			[var_0_59.ADD_ATTACK] = L_COMPONENT_EFFECT[var_0_59.ADD_ATTACK],
			tank = L_CAREER_LIST.tank,
			assassin = L_CAREER_LIST.assassin,
			fighter = L_CAREER_LIST.fighter,
			shooter = L_CAREER_LIST.shooter,
			witcher = L_CAREER_LIST.witcher,
			support = L_CAREER_LIST.support,
			remote = L_CAREER_LIST.remote,
			melee = L_CAREER_LIST.melee
		},
		filter_type_str = L_ITEMPANEL_FILTER_TYPE_STR.ITEMPANEL_TYPE_SMELT_COMPONENT,
		sort_table = {
			var_0_60.STRENGTH,
			var_0_60.QUALITY,
			var_0_60.LEVEL,
			var_0_60.POS,
			var_0_60.ROLE
		},
		sort_str = {
			[var_0_60.STRENGTH] = L_COMPONENT_SORT[var_0_60.STRENGTH],
			[var_0_60.QUALITY] = L_COMPONENT_SORT[var_0_60.QUALITY],
			[var_0_60.LEVEL] = L_COMPONENT_SORT[var_0_60.LEVEL],
			[var_0_60.POS] = L_COMPONENT_SORT[var_0_60.POS],
			[var_0_60.ROLE] = L_COMPONENT_SORT[var_0_60.ROLE]
		},
		default_sort = var_0_60.LEVEL
	},
	[ITEMPANEL_TYPE_ROLE_WEAPON] = {
		default_sort = "quality",
		filter_table = {
			{
				var_0_61.STAR1,
				var_0_61.STAR2,
				var_0_61.STAR3,
				var_0_61.STAR4,
				var_0_61.STAR5
			},
			{
				"one",
				"two",
				"three",
				"four",
				"five"
			}
		},
		filter_str = {
			[var_0_61.STAR1] = L_SORT_STAR[1],
			[var_0_61.STAR2] = L_SORT_STAR[2],
			[var_0_61.STAR3] = L_SORT_STAR[3],
			[var_0_61.STAR4] = L_SORT_STAR[4],
			[var_0_61.STAR5] = L_SORT_STAR[5],
			one = L_SORT_COLOR[1],
			two = L_SORT_COLOR[2],
			three = L_SORT_COLOR[3],
			four = L_SORT_COLOR[4],
			five = L_SORT_COLOR[5]
		},
		filter_type_str = ITEMPANEL_TYPE_ROLE_WEAPON,
		sort_table = {
			"level",
			"quality",
			"nowStars"
		},
		sort_str = {
			level = L_ITEMPANEL_SORT_STR.level,
			quality = L_ITEMPANEL_SORT_STR.quality,
			nowStars = L_ITEMPANEL_SORT_STR.nowStars
		}
	},
	[ITEMPANEL_TYPE_WEAPON_STRENGTHEN] = {
		default_sort = "quality",
		filter_table = {
			{
				1,
				2,
				3,
				4,
				5
			}
		},
		filter_str = {
			L_SORT_COLOR[1],
			L_SORT_COLOR[2],
			L_SORT_COLOR[3],
			L_SORT_COLOR[4],
			L_SORT_COLOR[5]
		},
		filter_type_str = L_ITEMPANEL_FILTER_TYPE_STR.ITEMPANEL_TYPE_WEAPON_STRENGTHEN,
		sort_table = {
			[1] = "quality"
		},
		sort_str = {
			quality = L_ITEMPANEL_SORT_STR.quality
		}
	},
	[ITEMPANEL_TYPE_UPGRADE_WEAPON] = {
		default_sort = "quality",
		filter_table = {
			{
				1,
				2,
				3,
				4,
				5
			}
		},
		filter_str = {
			L_SORT_COLOR[1],
			L_SORT_COLOR[2],
			L_SORT_COLOR[3],
			L_SORT_COLOR[4],
			L_SORT_COLOR[5]
		},
		filter_type_str = L_ITEMPANEL_FILTER_TYPE_STR.ITEMPANEL_TYPE_UPGRADE_WEAPON,
		sort_table = {
			[1] = "quality",
			[2] = "level"
		},
		sort_str = {
			quality = L_ITEMPANEL_SORT_STR.quality,
			level = L_ITEMPANEL_SORT_STR.level2
		}
	},
	[ITEMPANEL_TYPE_COOK_ADD_FOOD] = {
		default_sort = "number",
		filter_table = {
			{
				1,
				2,
				3,
				4,
				5
			}
		},
		filter_str = {
			L_SORT_COLOR[1],
			L_SORT_COLOR[2],
			L_SORT_COLOR[3],
			L_SORT_COLOR[4],
			L_SORT_COLOR[5]
		},
		filter_type_str = L_ITEMPANEL_FILTER_TYPE_STR.ITEMPANEL_TYPE_COOK_ADD_FOOD,
		sort_table = {
			[1] = "quality",
			[2] = "number"
		},
		sort_str = {
			quality = L_ITEMPANEL_SORT_STR.quality,
			number = L_ITEMPANEL_SORT_STR.number
		}
	},
	[ITEMPANEL_TYPE_DORM_FURNITURE] = {
		default_sort = "quality",
		filter_table = {
			{
				1,
				2,
				3,
				4,
				5
			}
		},
		filter_str = L_FILTER_STR.DORMROOM_FURNITURE_ITEMPANEL[1],
		filter_type_str = L_ITEMPANEL_FILTER_TYPE_STR.ITEMPANEL_TYPE_DORM_FURNITURE,
		sort_table = {
			[1] = "quality"
		},
		sort_str = {
			quality = L_ITEMPANEL_SORT_STR.quality
		}
	}
}

function ItemsPanel.create(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7, arg_9_8)
	if type(arg_9_1) == "table" and arg_9_1.itemtype == 50 and arg_9_1.paneltype == 2 then
		return require("view.Layer.ItemsPanelPartsLayer"):create(arg_9_1, 1)
	end

	local var_9_0 = ItemsPanel.new()

	if type(arg_9_1) == "table" then
		var_9_0:init(arg_9_1.itemtype, arg_9_1.itemConditions, arg_9_1.usedItem, arg_9_1.callbacklist, arg_9_1.paneltype, arg_9_1.pos, true, arg_9_1.componentScore, arg_9_1.effectid, arg_9_1.goto_back_system_id)
	else
		var_9_0:init(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, nil, nil)
	end

	return var_9_0
end

function ItemsPanel.getInstance()
	return var_0_24
end

function ItemsPanel:init(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7, arg_11_8, arg_11_9, arg_11_10)
	var_0_24 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Change_items.json" or "Change_items.ExportJson")

	self:addChild(self.rootLayer)

	self.medalPos = arg_11_6 or 1
	self.panelType = arg_11_5
	self.goto_back_system_id = arg_11_10
	self.isPopPushLayer = arg_11_7 and true
	self.selectTblAni = true
	self.bottomPanel = self.rootLayer:getChildByName("Bottom_bg")
	self.returnBnt = self.bottomPanel:getChildByName("Button_return")
	self.bottomBnt1 = self.bottomPanel:getChildByName("Button1")
	self.bottomBnt2 = self.bottomPanel:getChildByName("Button2")
	self.panelEquipment = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_choose")
	self.itemEquiped = ccui.Helper:seekWidgetByName(self.rootLayer, "img_equiped")
	self.itemChoosed = ccui.Helper:seekWidgetByName(self.rootLayer, "img_choosed")

	require("view.Sprite.TitleSprite")

	if not var_0_62[arg_11_5] then
		print("ItemsPanel lack title name! C++ nullpoint error")
	end

	self.TitleSprite = TitleSprite:create(var_0_62[arg_11_5], 1)

	self.TitleSprite:setPosition(0, 1080)
	self.TitleSprite:setName("TitleSprite")
	self.rootLayer:addChild(self.TitleSprite, 50)
	self:initFilterPanelNew(arg_11_5)

	self.itemsPanel = self.rootLayer:getChildByName("Panel_items")

	self.returnBnt:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()

		if arg_11_4.cancelcallback then
			arg_11_4.cancelcallback()
		end
	end)

	self.filterFlagData = {}
	self.filterBnts = {}
	self.itemBnts = {}
	self.lastUsedItems = {}
	self.itemType = arg_11_1
	self.itemConditions = arg_11_2 or {}
	self.usedcallback = arg_11_4.used or nil
	self.unusedcallback = arg_11_4.unused or nil
	self.extracallback = arg_11_4.extra or nil
	self.surecallback = arg_11_4.sure or nil
	self.usedItems = arg_11_3 and global_deepCopy(arg_11_3) or nil

	if arg_11_2 then
		self.servantid = arg_11_2.servantid or nil
	end

	if arg_11_2 then
		self.weaponsoulid = arg_11_2.soulid or nil
	end

	self.servantid = self.servantid or self.weaponsoulid

	if arg_11_2 and arg_11_2.pos then
		self.componentPos = arg_11_2.pos[1] or 1
	end

	self.lastSelected = nil
	self.lastSelectedNum = nil
	self.choosedTag = false
	self.initParamComponentScore = arg_11_8 or 0
	self.componentEffectid = arg_11_9
	self.bagManager = bag_manager.create()

	if arg_11_2 then
		self.cookFoods = arg_11_2.cookFoods or {}
	end

	self:initBottomBnts()
	self:initOtherUI()
	self:initItemsList()
	self:initDisplayValue(self.rootLayer)
	self:initLayerPattern()
	self:updateFilterListAlert()

	self.selectTblAni = false

	self:registerScriptHandler(function(arg_13_0)
		if arg_13_0 == "exit" then
			if self.panelType == ITEMPANEL_TYPE_COOK_ADD_FOOD then
				for iter_13_0, iter_13_1 in pairs(self.cookFoods) do
					if playermodel.items[iter_13_1.id] then
						playermodel.items[iter_13_1.id].number = playermodel.items[iter_13_1.id].number + iter_13_1.num
					else
						playermodel.items[iter_13_1.id] = {}
						playermodel.items[iter_13_1.id].entityid = iter_13_1.id
						playermodel.items[iter_13_1.id].itemid = iter_13_1.id
						playermodel.items[iter_13_1.id].itemtype = kITEM_FOOD
						playermodel.items[iter_13_1.id].number = iter_13_1.num
					end
				end
			end

			var_0_24 = nil
		end
	end)
end

function ItemsPanel:initFilterPanelNew(arg_14_1)
	self.filterType = ({
		[ITEMPANEL_TYPE_ROLE_COMPONENT] = filter_config_manager.COMPONENT_ITEMPANEL,
		[ITEMPANEL_TYPE_ROLE_WEAPON] = filter_config_manager.WEAPON_ITEMPANEL,
		[ITEMPANEL_TYPE_WEAPON_STRENGTHEN] = filter_config_manager.WEAPON_EXP_ITEMPANEL,
		[ITEMPANEL_TYPE_UPGRADE_WEAPON] = filter_config_manager.WEAPON_UPGRADE_ITEMPANEL,
		[ITEMPANEL_TYPE_DORM_FURNITURE] = filter_config_manager.DORMROOM_FURNITURE_ITEMPANEL,
		[ITEMPANEL_TYPE_MEDAL] = filter_config_manager.MEDAL_ITEMPANEL
	})[arg_14_1]
	self.curSortOrders = 1
	self.filterTbl = filter_config_manager:getDefaultFilterData(self.filterType, self.curSortOrders)
	self.curSort = self.filterTbl.sortType

	if arg_14_1 ~= ITEMPANEL_TYPE_MEDAL then
		self.filterAniFlag = true
		self.filterAniFlag1 = false
		self.filterPopModel = false

		self:createFilterList()

		self.filterListData = self.filterList:getFilterData()
		self.filterButton = ccui.Button:create("public/filter/filter_icon_off.png", "public/filter/filter_icon_off.png", nil, var_0_37)

		self.filterButton:setPositionX(320)
		self.filterButton:setPositionY(self.TitleSprite:getContentSize().height / 2)
		self.TitleSprite:addChild(self.filterButton, 5)
		self.filterButton:addTouchEventListener(function(arg_15_0, arg_15_1)
			if arg_15_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not self.filterAniFlag then
				return
			end

			self.filterAniFlag = false

			self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
				self.filterAniFlag = true
				self.filterAniFlag1 = true
			end)))
			self:showFilterPop()
		end)

		self.button_attribute = ccui.Button:create("public/filter/attr_icon_off.png", "public/filter/attr_icon_off.png", nil, var_0_37)

		self.button_attribute:setPositionX(550)
		self.button_attribute:setPositionY(self.TitleSprite:getContentSize().height / 2)

		self.button_attribute.isClickOn = false

		self.TitleSprite:addChild(self.button_attribute, 5)
		self.button_attribute:addTouchEventListener(function(arg_17_0, arg_17_1)
			if arg_17_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.isShowAttrs = not self.isShowAttrs
			arg_17_0.isClickOn = not arg_17_0.isClickOn

			if arg_17_0.isClickOn == false then
				arg_17_0:loadTextures("public/filter/attr_icon_off.png", "public/filter/attr_icon_off.png", nil, var_0_37)
			else
				arg_17_0:loadTextures("public/filter/attr_icon_on.png", "public/filter/attr_icon_on.png", nil, var_0_37)
			end

			self:updateShowingCells()
		end)
	end
end

function ItemsPanel:updateTitleBottom(arg_18_1)
	if self.filterPopModel == false and arg_18_1 == 2 or self.filterPopModel == true and arg_18_1 == 1 then
		self.filterPopModel = not self.filterPopModel

		if arg_18_1 == 1 then
			self.filterButton:loadTextures("public/filter/filter_icon_off.png", "public/filter/filter_icon_off.png", nil, var_0_37)
			self.bottomPanel:runAction(cc.MoveBy:create(0.2, cc.p(0, 100)))
		else
			self.filterButton:loadTextures("public/filter/filter_icon_on.png", "public/filter/filter_icon_on.png", nil, var_0_37)
			self.bottomPanel:runAction(cc.MoveBy:create(0.2, cc.p(0, -100)))
		end
	end
end

function ItemsPanel:showFilterPop()
	local var_19_0 = self.filterListData.col
	local var_19_1 = {}

	if not self.filterListData.filterValue then
		if self.filterList:getTouchFlag() then
			for iter_19_0, iter_19_1 in pairs(self.filterListData.btnState) do
				var_19_1[iter_19_0] = 0
			end

			self.filterList:setTouchFlag(false)
		end
	else
		for iter_19_2, iter_19_3 in pairs(self.filterListData.btnState) do
			var_19_1[iter_19_2] = iter_19_3 == 1 and -2 or -1
		end
	end

	if self.filterSpritePop then
		self.filterSpritePop:setFilterBtnState(var_19_0, var_19_1)
		self.filterSpritePop:setSortOrderState(1, self.curSortOrders == 0 and {
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

		global_basic_scene:addChild(self.filterSpritePop, 1000)
	end

	self:updateTitleBottom(2)
end

function ItemsPanel:createFilterList()
	local var_20_0 = {
		defaultSelected = 1,
		bagLayerType = self.filterType,
		filterCallback = function(self)
			self.selectTblAni = true

			if self.panelType == ITEMPANEL_TYPE_DORM_FURNITURE then
				if self.furniture_suit then
					self.listPanel:setVisible(false)

					if self.furnitureSuitlist then
						self.furnitureSuitlist:setVisible(true)
					end

					self.suitList, self.shopList = dormitory_manager:getHavedFurnitureSuits(self.itemConditions.roomid, self.itemConditions.soulid)

					self:updateFurnitureSuitList()
					self.filterButton:setVisible(false)
				else
					self.listPanel:setVisible(true)

					local var_21_0

					if self.furnitureSuitlist then
						self.furnitureSuitlist:setVisible(false)

						var_21_0 = {}
					end

					var_21_0[1] = self.filterValue
					self.filterTbl.filterConfig[self.filterKey] = var_21_0
					self.filterListData = self

					self:updateItemList()
					self.itemChoosed:removeAllChildren()
					self.itemChoosed:loadTexture(var_0_47, var_0_37)

					self.choosedTag = false

					self.filterButton:setVisible(true)
				end
			else
				local var_21_1 = {}

				var_21_1[1] = self.filterValue
				self.filterTbl.filterConfig[self.filterKey] = var_21_1
				self.filterListData = self

				self:updateItemList()
				self.itemChoosed:removeAllChildren()
				self.itemChoosed:loadTexture(var_0_47, var_0_37)

				self.choosedTag = false

				self.bottomBnt2:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Unload)

				if self.equipedEntityid == -1 then
					self.bottomBnt2:setVisible(false)
					self.bottomBnt2:setTouchEnabled(false)
				end

				if self.panelType == ITEMPANEL_TYPE_ROLE_COMPONENT then
					self.bottomBnt1:setVisible(false)
				end
			end

			self.selectTblAni = false
		end
	}

	if self.panelType == ITEMPANEL_TYPE_DORM_FURNITURE then
		var_20_0.style = "style_furniture"
	end

	self.filterList = FilterListSprite:create(var_20_0)

	self.filterList:setAnchorPoint(cc.p(0, 1))
	self.filterList:setPositionX(0)
	self.filterList:setPositionY((GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 56, TRANSFORM_UNIT.PX)))
	self.filterList:setName("filterList")
	self.rootLayer:addChild(self.filterList, 40)
end

function ItemsPanel:updateFilterListAlert()
	if self.itemType ~= kITEM_COMPONENT and self.goto_back_system_id ~= 301 then
		return
	end

	local var_22_0 = filter_config_manager.ConfigTable[self.filterType]
	local var_22_1 = filter_config_manager:getDefaultFilterData(self.filterType, self.curSortOrders)

	var_22_1.filterConfig.pos = {
		self.itemConditions.pos[1]
	}
	var_22_1.filterConfig.soulid = {
		"soul_" .. servant_data[self.itemConditions.servantid].major,
		"all"
	}
	var_22_1.servantid = self.itemConditions.servantid

	for iter_22_0, iter_22_1 in ipairs(var_22_0.filter_table[filter_config_manager.BagConfig[self.filterType].index]) do
		var_22_1.filterConfig[filter_config_manager.ConfigTable[self.filterType].filter_key[filter_config_manager.BagConfig[self.filterType].index]] = {
			iter_22_1
		}

		if iter_22_1 ~= "sp" then
			local var_22_2 = false

			for iter_22_2, iter_22_3 in ipairs((self.bagManager:getBagData(var_22_1))) do
				if component_manager:isRecommendComponent(self.servantid, iter_22_3) then
					var_22_2 = true

					break
				end
			end

			if var_22_2 then
				local var_22_3 = self.filterList:getButton(iter_22_0)

				if var_22_3 then
					local var_22_4 = ccui.ImageView:create("itempanel/img_recommend.png", var_0_37)

					var_22_4:setPosition(var_22_3:getContentSize().width - 10, var_22_3:getContentSize().height - 10)
					var_22_3:addChild(var_22_4)
				end
			end
		end
	end
end

function ItemsPanel:sortCallback(arg_23_1)
	self.orderType = arg_23_1
	self.curSortOrders = arg_23_1

	self.bagManager:reverseOrder(self.resultList)
	self:updateShowingCells()
end

function ItemsPanel:filterCallback(arg_24_1)
	self.filterTbl.sortType = arg_24_1.sortType or self.filterTbl

	for iter_24_0, iter_24_1 in pairs(arg_24_1.filterConfig) do
		self.filterTbl.filterConfig[iter_24_0] = global_deepCopy(iter_24_1)
	end

	self.curSort = self.filterTbl.sortType

	self:updateItemList()

	if self.panelType == ITEMPANEL_TYPE_ROLE_COMPONENT or self.panelType == ITEMPANEL_TYPE_ROLE_WEAPON then
		self:updateChoosedPanelbyRank()
	end
end

function ItemsPanel:createFilterPop()
	local function var_25_0(arg_27_0)
		if self.filterAniFlag1 then
			self.filterAniFlag1 = false

			self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
				self.filterAniFlag1 = true
				self.filterAniFlag = true
			end)))
			self:updateTitleBottom(1)
			arg_27_0()
		end
	end

	local function var_25_1(arg_29_0)
		self:sortCallback(arg_29_0)
	end

	local var_25_2 = self.filterListData.col or {}
	local var_25_3 = self.filterListData.btnState or {}
	local var_25_4 = {}
	local var_25_5 = false

	for iter_25_0, iter_25_1 in pairs(var_25_3) do
		if iter_25_1 == 1 then
			var_25_5 = true
		end
	end

	for iter_25_2, iter_25_3 in pairs(var_25_3) do
		var_25_4[iter_25_2] = var_25_5 and (iter_25_3 == 1 and -2 or -1) or iter_25_3
	end

	local var_25_7 = FilterSprite:create({
		filterType = self.filterType,
		filterCallback = function(arg_26_0)
			self:filterCallback(arg_26_0)
		end,
		maskTouchCallback = var_25_0,
		sortOrderChangeCallback = var_25_1,
		initButtonConfig = {
			[var_25_2] = var_25_4
		},
		defaultSortOrder = self.curSortOrders == 1 and 0 or 1
	})

	var_25_7:setPositionX(320)
	var_25_7:setPositionY(568)
	var_25_7:moveToTop()

	return var_25_7
end

function ItemsPanel:exit()
	self:layerOutAni(function()
		if self.isPopPushLayer then
			LayerManager:removePopLayer()
		else
			self:runAction(cc.RemoveSelf:create())
		end
	end)
end

function ItemsPanel:layerOutAni(arg_32_1)
	self.startRunOutAni = true

	self:updateShowingCells()
	self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(LAYER_OUT_TIME), cc.CallFunc:create(arg_32_1)))
end

function ItemsPanel:registBntsEvent()
	for iter_33_0, iter_33_1 in pairs(self.topBnts) do
		iter_33_1:addTouchEventListener(function(arg_34_0, arg_34_1)
			if arg_34_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:updateTopPanel(iter_33_0)
		end)
	end

	self.selectPanel:addTouchEventListener(function(arg_35_0, arg_35_1)
		if arg_35_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.selectPanel.panelType == "nothing" then
			return
		end

		self:updateTopPanel("nothing")
	end)

	local var_33_0 = 1
	local var_33_1 = 0

	self.orderType = 1

	self.orderTypeBnt:addTouchEventListener(function(arg_36_0, arg_36_1)
		if arg_36_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.orderType == var_33_0 then
			self.orderTypeBnt:getChildByName("button_title_image"):loadTexture("public/filter/up_or_down.png", var_0_37)

			self.orderType = var_33_1
		elseif self.orderType == var_33_1 then
			self.orderTypeBnt:getChildByName("button_title_image"):loadTexture("public/filter/down_or_up.png", var_0_37)

			self.orderType = var_33_0
		end

		self:updateItemList()
		self:updateChoosedPanelbyRank()
	end)

	self.isShowAttrs = false

	self.attrInfoBnt:addTouchEventListener(function(arg_37_0, arg_37_1)
		if arg_37_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.isShowAttrs = not self.isShowAttrs

		self:updateShowingCells()
	end)
end

local var_0_64 = 1085

function ItemsPanel:updateTopPanel(arg_38_1)
	local function var_38_0(arg_39_0, arg_39_1)
		local var_39_0 = self.topPanels[arg_39_0]

		self.topPanels[arg_39_0]:stopAllActions()
		self.topPanels[arg_39_0]:runAction(cc.Sequence:create(cc.CallFunc:create(function()
			self.selectPanel.panelType = "running"
		end), cc.MoveTo:create(0.1, cc.p(self.topPanels[arg_39_0]:getPositionX(), self.topPanels[arg_39_0]:getPositionY() - 10)), cc.MoveTo:create(0.1, cc.p(self.topPanels[arg_39_0]:getPositionX(), var_0_64)), cc.CallFunc:create(function()
			var_39_0:resetPanel()

			if arg_39_1 then
				arg_39_1()
			end
		end)))
	end

	local function var_38_1(arg_42_0, arg_42_1)
		self.topPanels[arg_42_0]:stopAllActions()
		self.topPanels[arg_42_0]:runAction(cc.Sequence:create(cc.CallFunc:create(function()
			self.selectPanel.panelType = "running"
		end), cc.MoveTo:create(0.1, cc.p(self.topPanels[arg_42_0]:getPositionX(), var_0_64 - self.topPanels[arg_42_0]:getContentSize().height - 10)), cc.MoveTo:create(0.05, cc.p(self.topPanels[arg_42_0]:getPositionX(), var_0_64 - self.topPanels[arg_42_0]:getContentSize().height + 10)), cc.MoveTo:create(0.05, cc.p(self.topPanels[arg_42_0]:getPositionX(), var_0_64 - self.topPanels[arg_42_0]:getContentSize().height)), cc.CallFunc:create(function()
			if arg_42_1 then
				arg_42_1()
			end
		end)))
	end

	if self.selectPanel.panelType ~= "running" then
		if arg_38_1 == "nothing" then
			var_38_0(self.selectPanel.panelType, function()
				self.selectPanel:setTouchEnabled(false)

				self.selectPanel.panelType = "nothing"
			end)
		elseif self.selectPanel.panelType == "nothing" then
			var_38_1(arg_38_1, function()
				self.selectPanel.panelType = arg_38_1

				self.selectPanel:setTouchEnabled(true)
			end)
		elseif self.selectPanel.panelType == arg_38_1 then
			var_38_0(arg_38_1, function()
				self.selectPanel.panelType = "nothing"

				self.selectPanel:setTouchEnabled(false)
			end)
		else
			var_38_0(self.selectPanel.panelType, function()
				var_38_1(arg_38_1, function()
					self.selectPanel.panelType = arg_38_1

					self.selectPanel:setTouchEnabled(true)
				end)
			end)
		end
	else
		return
	end

	for iter_38_0, iter_38_1 in pairs(self.topBnts) do
		if iter_38_0 == arg_38_1 then
			if iter_38_1:isBright() then
				iter_38_1:setBright(false)
			else
				iter_38_1:setBright(true)
			end
		else
			iter_38_1:setBright(true)
		end
	end
end

local var_0_65 = 59
local var_0_66 = -40
local var_0_67 = 162
local var_0_68 = 70

function ItemsPanel:initFilterData()
	local var_50_0 = 0
	local var_50_1 = {}

	for iter_50_0, iter_50_1 in ipairs(var_0_63[self.panelType].filter_table) do
		self.filterFlagData[iter_50_0] = {}

		if self.itemType == kITEM_COMPONENT then
			self.filterFlagData[iter_50_0].all = true
		end

		for iter_50_2, iter_50_3 in ipairs(iter_50_1) do
			self.filterFlagData[iter_50_0][iter_50_3] = false
		end

		var_50_1[iter_50_0] = iter_50_0 > 1 and math.ceil(#iter_50_1 / 4) * 60 + 40 + var_50_1[iter_50_0 - 1] or math.ceil(#iter_50_1 / 4) * 60 + 40
		var_50_0 = var_50_0 + math.ceil(#iter_50_1 / 4) * 60 + 40
	end

	return #var_50_1 * 15 + var_50_0 + 60, var_50_1
end

function ItemsPanel:initFilterPanel()
	local var_51_0, var_51_1 = self:initFilterData()

	self.topPanels.filter:setContentSize(cc.size(640, var_51_0))

	for iter_51_0, iter_51_1 in ipairs(var_0_63[self.panelType].filter_table) do
		self.filterBnts[iter_51_0] = {}

		local var_51_2 = self.topPanels.filter.typeUI:clone()

		var_51_2:setPositionY((iter_51_0 > 1 or nil) and (var_51_0 - 20 * iter_51_0 - var_51_1[iter_51_0 - 1] or var_51_0 - 20))
		var_51_2:getChildByName("suit_label"):setString(var_0_63[self.panelType].filter_type_str[iter_51_0])
		self.topPanels.filter:addChild(var_51_2)

		for iter_51_2, iter_51_3 in ipairs(iter_51_1) do
			local var_51_3 = self.topPanels.filter.button:clone()

			var_51_3:setTitleText(var_0_63[self.panelType].filter_str[iter_51_3])
			var_51_3:setPosition(cc.p(var_0_65 + (iter_51_2 - 1) % 4 * var_0_67, var_0_66 - math.floor((iter_51_2 - 1) / 4) * var_0_68))
			var_51_2:addChild(var_51_3)

			self.filterBnts[iter_51_0][iter_51_3] = var_51_3

			var_51_3:addTouchEventListener(function(arg_52_0, arg_52_1)
				if arg_52_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_52_0:getChildByName("selected_bg"):isVisible() then
					arg_52_0:getChildByName("selected_bg"):setVisible(false)
				else
					arg_52_0:getChildByName("selected_bg"):setVisible(true)
				end
			end)
		end
	end

	function self.topPanels.filter.resetPanel(arg_53_0)
		for iter_53_0, iter_53_1 in pairs(self.filterBnts) do
			for iter_53_2, iter_53_3 in pairs(iter_53_1) do
				if self.filterFlagData[iter_53_0][iter_53_2] ~= iter_53_3:getChildByName("selected_bg"):isVisible() then
					iter_53_3:getChildByName("selected_bg"):setVisible(self.filterFlagData[iter_53_0][iter_53_2])
				end
			end
		end
	end

	self.topPanels.filter:getChildByName("button_complete"):addTouchEventListener(function(arg_54_0, arg_54_1)
		if arg_54_1 ~= ccui.TouchEventType.ended then
			return
		end

		for iter_54_0, iter_54_1 in pairs(self.filterBnts) do
			for iter_54_2, iter_54_3 in pairs(iter_54_1) do
				if self.filterFlagData[iter_54_0][iter_54_2] ~= iter_54_3:getChildByName("selected_bg"):isVisible() then
					self.filterFlagData[iter_54_0][iter_54_2] = iter_54_3:getChildByName("selected_bg"):isVisible()

					if iter_54_3:getChildByName("selected_bg"):isVisible() then
						self.filterFlagData[iter_54_0].all = false
					end
				end
			end
		end

		self:updateTopPanel("filter")
		self:updateItemList()
		self:updateChoosedPanelbyRank()
	end)
end

function ItemsPanel:initSortPanel()
	self.sortBnts = {}

	for iter_55_0, iter_55_1 in ipairs(var_0_63[self.panelType].sort_table) do
		local var_55_0 = self.topPanels.sort.button:clone()

		var_55_0:setTitleText(var_0_63[self.panelType].sort_str[iter_55_1])
		var_55_0:setPosition(cc.p(var_0_65 + (iter_55_0 - 1) % 4 * var_0_67, var_0_66 - math.floor((iter_55_0 - 1) / 4) * var_0_68))

		var_55_0.sortType = iter_55_1

		self.topPanels.sort.typeUI:addChild(var_55_0)

		self.sortBnts[iter_55_0] = var_55_0

		if var_0_63[self.panelType].default_sort == iter_55_1 then
			var_55_0:getChildByName("selected_bg"):setVisible(true)

			self.sortType = iter_55_1
		end

		var_55_0:addTouchEventListener(function(arg_56_0, arg_56_1)
			if arg_56_1 ~= ccui.TouchEventType.ended then
				return
			end

			for iter_56_0, iter_56_1 in pairs(self.sortBnts) do
				if iter_55_0 == iter_56_0 then
					iter_56_1:getChildByName("selected_bg"):setVisible(true)
				else
					iter_56_1:getChildByName("selected_bg"):setVisible(false)
				end
			end
		end)
	end

	local var_55_1 = math.ceil(#var_0_63[self.panelType].sort_table / 4) * 60 + 40 + 60

	self.topPanels.sort:setContentSize(cc.size(640, var_55_1))
	self.topPanels.sort.typeUI:setPositionY(var_55_1 - 20)
	self.topPanels.sort:getChildByName("button_complete"):addTouchEventListener(function(arg_57_0, arg_57_1)
		if arg_57_1 ~= ccui.TouchEventType.ended then
			return
		end

		for iter_57_0, iter_57_1 in pairs(self.sortBnts) do
			if iter_57_1:getChildByName("selected_bg"):isVisible() then
				self.sortType = iter_57_1.sortType
			end
		end

		self:updateTopPanel("sort")
		self:updateItemList()
		self:updateChoosedPanelbyRank()
	end)

	function self.topPanels.sort.resetPanel(arg_58_0)
		for iter_58_0, iter_58_1 in pairs(self.sortBnts) do
			if iter_58_1.sortType == self.sortType then
				iter_58_1:getChildByName("selected_bg"):setVisible(true)
			else
				iter_58_1:getChildByName("selected_bg"):setVisible(false)
			end
		end
	end
end

function ItemsPanel:updateChoosedPanelbyRank()
	self.choosedTag = false

	if self.lastSelected then
		self.lastSelected.selected = nil
	end

	self.itemChoosed:removeAllChildren()
	self.itemChoosed:loadTexture(var_0_47, var_0_37)
	self:itemChangeUpdate(nil)
end

function ItemsPanel:initBottomBnts()
	if self.panelType == ITEMPANEL_TYPE_WEAPON_STRENGTHEN then
		self.bottomBnt1:setVisible(false)
		self.bottomBnt2:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Sure)
		self.bottomBnt2:setVisible(true)

		local var_60_0 = 0

		for iter_60_0, iter_60_1 in pairs(self.usedItems) do
			if var_0_2[iter_60_0] and iter_60_1 > 0 then
				var_60_0 = var_60_0 + var_0_2[iter_60_0].gain_exp * iter_60_1
			end
		end

		local var_60_2 = math.floor(var_60_0 * WEAPON_STRENGTHEN_C)
		local var_60_3 = ccui.ImageView:create("public/panelbg/bottom_black_bg.png", var_0_37)

		var_60_3:setAnchorPoint(cc.p(0, 0))
		var_60_3:setPosition(0, self.bottomBnt2:getParent():getContentSize().height)
		var_60_3:setName("costPanel")
		self.bottomBnt2:getParent():addChild(var_60_3)

		local var_60_4 = cc.Label:createWithTTF(L_COST .. ":" .. L_GOLD .. "  " .. var_60_2, "fonts/newkj.ttf", 20)

		var_60_4:setPosition(160, self.bottomBnt2:getParent():getContentSize().height + var_60_3:getContentSize().height / 2)
		var_60_4:setColor(cc.c3b(165, 182, 197))
		var_60_4:setName("costgoldLabel")
		self.bottomBnt2:getParent():addChild(var_60_4)

		local var_60_5 = cc.Label:createWithTTF(L_GET_EXP .. "  " .. var_60_0, "fonts/newkj.ttf", 20)

		var_60_5:setPosition(480, self.bottomBnt2:getParent():getContentSize().height + var_60_3:getContentSize().height / 2)
		var_60_5:setColor(cc.c3b(212, 152, 88))
		var_60_5:setName("gainexpLabel")
		self.bottomBnt2:getParent():addChild(var_60_5)

		local var_60_6 = playermodel.gold
		local var_60_7 = require("data.weapon_strengthen" .. var_0_2[playermodel.items[self.itemConditions.weaponEntityid].itemid].equip_quality .. "_data")
		local var_60_8 = math.ceil((playermodel.items[self.itemConditions.weaponEntityid].weapon_attr.level + 1) / 10) * 10
		local var_60_9 = false
		local var_60_10 = false

		if var_60_7[var_60_8].all_exp - var_60_7[var_60_8].exp - (var_60_7[playermodel.items[self.itemConditions.weaponEntityid].weapon_attr.level].all_exp - var_60_7[playermodel.items[self.itemConditions.weaponEntityid].weapon_attr.level].exp + playermodel.items[self.itemConditions.weaponEntityid].weapon_attr.exp) < var_60_0 then
			var_60_9 = true

			var_60_5:setString(L_GET_EXP .. "  " .. var_60_0 .. " (MAX)")
			var_60_5:setColor(cc.c3b(255, 28, 81))
		else
			var_60_9 = false

			var_60_5:setString(L_GET_EXP .. "  " .. var_60_0)
			var_60_5:setColor(cc.c3b(212, 152, 88))
		end

		if var_60_6 < var_60_2 then
			var_60_10 = true

			var_60_4:setString(L_COST .. L_GOLD .. ":  " .. var_60_2 .. "(" .. L_GOLD_LACK .. ")")
			var_60_4:setColor(cc.c3b(255, 28, 81))
		else
			var_60_10 = false

			var_60_4:setString(L_COST .. L_GOLD .. ":  " .. var_60_2)
			var_60_4:setColor(cc.c3b(165, 182, 197))
		end

		self.isStrengthenMax = var_60_10 or var_60_9

		self.bottomBnt2:addTouchEventListener(function(arg_61_0, arg_61_1)
			if arg_61_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_61_0:isBright() then
				return
			end

			self:exit()

			if self.surecallback then
				arg_61_0:setBright(false)
				self.surecallback(self.usedItems)
			end
		end)
	elseif self.panelType == ITEMPANEL_TYPE_COOK_ADD_FOOD then
		self.bottomBnt1:setVisible(false)
		self.bottomBnt2:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Sure)
		self.bottomBnt2:setVisible(false)
	elseif self.panelType == ITEMPANEL_TYPE_MEDAL then
		self.bottomBnt1:setVisible(false)
		self.bottomBnt2:setVisible(false)
	elseif self.panelType == ITEMPANEL_TYPE_DORM_FURNITURE then
		self.bottomBnt1:setVisible(false)
		self.bottomBnt2:setVisible(false)
	elseif self.panelType == ITEMPANEL_TYPE_UPGRADE_WEAPON then
		self.bottomBnt1:setVisible(true)
		self.bottomBnt2:setVisible(false)
		self.bottomBnt1:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Details)
		self.bottomBnt1:addTouchEventListener(function(arg_62_0, arg_62_1)
			if arg_62_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.desPanel:updatePos()
		end)
	elseif self.panelType == ITEMPANEL_TYPE_ROLE_COMPONENT then
		if playermodel.component[self.servantid] and playermodel.component[self.servantid][self.componentPos] then
			self.equipedEntityid = playermodel.component[self.servantid][self.componentPos].id or -1
		end

		self.bottomBnt1:setVisible(false)
		self.bottomBnt1:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Strenthen)
		self.bottomBnt2:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Unload)

		if self.equipedEntityid == -1 then
			self.bottomBnt2:setVisible(false)
			self.bottomBnt2:setTouchEnabled(false)
		else
			self.bottomBnt2:setVisible(true)
			self.bottomBnt2:setTouchEnabled(true)
		end

		self.bottomBnt2:addTouchEventListener(function(arg_63_0, arg_63_1)
			if arg_63_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_63_0:isBright() then
				return
			end

			if self.equipedEntityid == -1 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_COMPONENT_TEXT.No_equip)

				return
			end

			if self.usedcallback then
				arg_63_0:setBright(false)
				self.usedcallback(function()
					arg_63_0:setBright(true)
				end)
			end
		end)
	elseif self.panelType == ITEMPANEL_TYPE_ROLE_WEAPON then
		self.equipedEntityid = playermodel.weaponId[self.weaponsoulid] or -1

		self.bottomBnt1:setVisible(false)
		self.bottomBnt1:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Strenthen)
		self.bottomBnt2:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Unload)

		if self.equipedEntityid == -1 then
			self.bottomBnt1:setVisible(false)
			self.bottomBnt1:setTouchEnabled(false)
			self.bottomBnt2:setVisible(false)
			self.bottomBnt2:setTouchEnabled(false)
		else
			self.bottomBnt2:setVisible(true)
			self.bottomBnt2:setTouchEnabled(true)
		end

		self.bottomBnt2:addTouchEventListener(function(arg_65_0, arg_65_1)
			if arg_65_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_65_0:isBright() then
				return
			end

			if self.equipedEntityid == -1 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_WEAPON_NO_EQUIP)

				return
			end

			if self.usedcallback then
				arg_65_0:setBright(false)
				self.usedcallback(function(arg_66_0)
					arg_65_0:setBright(true)

					if arg_66_0 == 1 then
						self:exit()
					end
				end)
			end
		end)
	else
		self.bottomBnt1:setVisible(false)
		self.bottomBnt2:setVisible(false)
	end
end

function ItemsPanel:initOtherUI()
	if self.panelType == ITEMPANEL_TYPE_DORM_FURNITURE then
		self.rootLayer:getChildByName("Panel_room"):setVisible(true)
		self.rootLayer:getChildByName("Panel_room"):setTouchEnabled(true)
		self.rootLayer:getChildByName("Panel_room"):setAnchorPoint(cc.p(0, 0.5))
		self.rootLayer:getChildByName("Panel_room"):setPositionX(53)
		self.rootLayer:getChildByName("Panel_room"):setScaleX(590 / self.rootLayer:getChildByName("Panel_room"):getContentSize().width)

		self.roomPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "room_margin")

		local var_67_0 = cc.Label:createWithTTF("", FONT_NAME, 26)

		var_67_0:setColor(cc.c3b(255, 151, 32))
		var_67_0:setAnchorPoint(cc.p(0.5, 0))
		var_67_0:setPosition(self.roomPanel:getContentSize().width / 2, -18)
		var_67_0:setName("furnitures_add")
		self.roomPanel:addChild(var_67_0)

		local var_67_1 = ccui.Button:create("public/button/public_button_normal_y.png", nil, "public/button/public_button_off.png", var_0_37)

		var_67_1:setScale(0.6)
		var_67_1:setAnchorPoint(cc.p(1, 1))
		var_67_1:setPosition(self.roomPanel:getContentSize().width, self.roomPanel:getContentSize().height + 16)
		self.roomPanel:addChild(var_67_1)

		local var_67_2 = cc.Label:createWithTTF(L_CHECK_MORE, FONT_BUTTON, 30)

		var_67_2:setColor(cc.c3b(41, 49, 58))
		var_67_2:setName("label")
		var_67_2:setPosition(cc.p(var_67_1:getContentSize().width / 2, var_67_1:getContentSize().height / 2))
		var_67_1:addChild(var_67_2)
		var_67_1:addTouchEventListener(function(arg_68_0, arg_68_1)
			if arg_68_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_67_1:setTouchEnabled(false)

			local var_68_0 = {
				jump_to_system = 153
			}

			var_68_0.config = system_jump_config[SYSTEMID[153]] and system_jump_config[SYSTEMID[153]].config

			require("controller.goto_system_manager")

			var_68_0.config.exitCallback = createExitCallback({
				jump_to_system = 700
			})

			goto_complete_system(var_68_0)
			self:exit()
		end)

		function self.roomPanel:updataFurniture(arg_69_1)
			local var_69_0 = self:getChildByName("small_door_spine")

			if var_69_0 then
				var_69_0:removeFromParent()
			end

			for iter_69_0 = 1, 5 do
				local var_69_1 = self:getChildByName("furniture" .. iter_69_0)

				var_69_1:setLocalZOrder(FURNITURE_ZORDER[iter_69_0])

				local var_69_2 = self:getChildByName("furniture_spine" .. iter_69_0)

				if var_69_2 then
					var_69_2:removeFromParent()
				end

				if iter_69_0 ~= 1 then
					var_69_1:setAnchorPoint(cc.p(0, 0))
				end

				if not var_69_1.id or var_69_1.id ~= arg_69_1[iter_69_0] then
					if arg_69_1[iter_69_0] < 0 then
						var_69_1:setVisible(false)
					else
						var_69_1:setVisible(true)

						if not var_0_2[arg_69_1[iter_69_0]].spine_dorm then
							if iter_69_0 == 1 then
								var_69_1:loadTexture("mainScenebg/dorm_room_bg/" .. var_0_2[arg_69_1[iter_69_0]].image_dorm .. ".png")
								self.rootLayer:getChildByName("Panel_room"):getChildByName("small_door"):setVisible(true)
								self.rootLayer:getChildByName("Panel_room"):getChildByName("small_door"):loadTexture("mainScenebg/furnitures/" .. var_0_2[arg_69_1[iter_69_0]].image_door .. ".png")
							else
								var_69_1:loadTexture("mainScenebg/furnitures/" .. var_0_2[arg_69_1[iter_69_0]].image_dorm .. ".png")
							end

							local var_69_3 = var_0_2[arg_69_1[iter_69_0]].init_x or FURNITURE_POS[iter_69_0].x
							local var_69_4 = var_0_2[arg_69_1[iter_69_0]].init_y or FURNITURE_POS[iter_69_0].y

							var_69_1:setPosition(var_69_3, var_69_4)
							print(var_0_2[arg_69_1[iter_69_0]].name, "家具原始位置", "x" .. var_69_3, "y" .. var_69_4)

							if var_0_2[arg_69_1[iter_69_0]].offset then
								local var_69_5, var_69_6 = var_0_2[arg_69_1[iter_69_0]].offset:match("([^,]+),(.+)")
								local var_69_7

								var_69_7 = tonumber(var_69_5) or 0

								local var_69_8

								var_69_8 = tonumber(var_69_6) or 0

								var_69_1:setPosition(var_69_3 + var_69_7, var_69_4 + var_69_8)
								print(var_0_2[arg_69_1[iter_69_0]].name, "家具偏移位置", "x" .. var_69_3 + var_69_7, "y" .. var_69_4 + var_69_8)
							end
						else
							if iter_69_0 == 1 then
								self.rootLayer:getChildByName("Panel_room"):getChildByName("small_door"):setVisible(false)

								local var_69_9 = L2Skeleton:create("spine/furniture/" .. var_0_2[arg_69_1[iter_69_0]].spine_dorm .. "_men.json", "spine/furniture/" .. var_0_2[arg_69_1[iter_69_0]].spine_dorm .. "_men.atlas", nil, true)

								var_69_9:setName("small_door_spine")
								var_69_9:refreshSkeleton()
								var_69_9:play("animate", true)
								var_69_9:setPosition(FURNITURE_POS[1])
								self:addChild(var_69_9, FURNITURE_ZORDER[iter_69_0])
							end

							var_69_1:setVisible(false)

							local var_69_10 = L2Skeleton:create("spine/furniture/" .. var_0_2[arg_69_1[iter_69_0]].spine_dorm .. ".json", "spine/furniture/" .. var_0_2[arg_69_1[iter_69_0]].spine_dorm .. ".atlas", nil, true)

							var_69_10:setName("furniture_spine" .. iter_69_0)
							var_69_10:refreshSkeleton()
							var_69_10:play("animate", true)
							var_69_10:setPosition(FURNITURE_POS[1])
							self:addChild(var_69_10, FURNITURE_ZORDER[iter_69_0])
						end
					end
				end
			end

			self:getChildByName("furnitures_add"):setString(string.format(L_ADD_FAVOR_COIN_HOUR, (dormitory_manager:get_furniture_add_favor(arg_69_1, self.itemConditions.soulid))))
		end

		self.roomPanel:updataFurniture(self.usedItems)
	elseif self.panelType == ITEMPANEL_TYPE_UPGRADE_WEAPON then
		self.desPanel = ccui.ImageView:create("public/panelbg/bottom_black_bg.png", var_0_37)

		self.desPanel:setScale9Enabled(true)
		self.desPanel:setCapInsets(cc.rect(10, 10, 10, 10))
		self.desPanel:setContentSize(cc.size(650, 100))
		self.desPanel:setAnchorPoint(cc.p(0, 0))
		self.desPanel:setPosition(0, -100)

		self.desPanel.status = "down"

		self:addChild(self.desPanel, 10)

		local var_67_3 = cc.Label:createWithTTF(L_WEAPON_UPGRADED_TIP, FONT_NAME, 28)

		var_67_3:setColor(cc.c3b(212, 152, 88))

		local var_67_4 = self.desPanel:getContentSize()

		var_67_3:setPosition(var_67_4.width / 2, var_67_4.height / 2)
		self.desPanel:addChild(var_67_3)

		function self.desPanel:updatePos()
			if self.status == "down" then
				self.status = "running"

				self.desPanel:runAction(cc.Sequence:create(cc.MoveTo:create(0.1, cc.p(self:getPositionX(), 90)), cc.MoveTo:create(0.05, cc.p(self:getPositionX(), 70)), cc.MoveTo:create(0.05, cc.p(self:getPositionX(), 80)), cc.CallFunc:create(function()
					self.status = "up"
				end)))
			elseif self.status == "up" then
				self.status = "running"

				self.desPanel:runAction(cc.Sequence:create(cc.MoveTo:create(0.1, cc.p(self:getPositionX(), self:getPositionY() + 10)), cc.MoveTo:create(0.1, cc.p(self:getPositionX(), 0 - self:getContentSize().height)), cc.CallFunc:create(function()
					self.status = "down"
				end)))
			end
		end
	end
end

function ItemsPanel:updateItemList()
	local var_73_0
	local var_73_1 = {}
	local var_73_2 = {
		[ITEMPANEL_TYPE_ROLE_COMPONENT] = function()
			self.filterTbl.filterConfig.pos = {
				self.itemConditions.pos[1]
			}
			self.filterTbl.filterConfig.soulid = {
				"soul_" .. servant_data[self.itemConditions.servantid].major,
				"all"
			}
			self.filterTbl.servantid = self.itemConditions.servantid
			self.resultList = self.bagManager:getBagData(self.filterTbl)

			local var_74_0

			for iter_74_0, iter_74_1 in pairs(self.resultList) do
				if iter_74_1 == self.equipedEntityid then
					var_74_0 = iter_74_0
				end
			end

			if var_74_0 then
				table.insert(self.resultList, 1, (table.remove(self.resultList, var_74_0)))
			end

			return self.resultList
		end,
		[ITEMPANEL_TYPE_ROLE_WEAPON] = function()
			self.filterTbl.outSide = {
				self.equipedEntityid
			}
			self.filterTbl.filterConfig.servantid = {
				self.itemConditions.soulid
			}
			self.resultList = self.bagManager:getBagData(self.filterTbl)

			return self.resultList
		end,
		[ITEMPANEL_TYPE_WEAPON_STRENGTHEN] = function()
			self.filterTbl.filterConfig.weaponType = {
				0,
				var_0_2[playermodel.items[self.itemConditions.weaponEntityid].itemid].mechanical_or_energy
			}
			self.resultList = self.bagManager:getBagData(self.filterTbl)

			return self.resultList
		end,
		[ITEMPANEL_TYPE_UPGRADE_WEAPON] = function()
			self.filterTbl.outSide = self.itemConditions.selected or {}
			self.filterTbl.filterConfig.lock = {
				false
			}
			self.filterTbl.filterConfig.use = {
				false
			}
			self.filterTbl.filterConfig.itemid = {
				self.itemConditions.itemid
			}
			self.resultList = self.bagManager:getBagData(self.filterTbl)

			return self.resultList
		end,
		[ITEMPANEL_TYPE_DORM_FURNITURE] = function()
			local var_78_0 = {}

			for iter_78_0, iter_78_1 in pairs(self.usedItems) do
				if iter_78_1 > 0 then
					table.insert(var_78_0, 1, iter_78_1)
				end
			end

			self.filterTbl.outSide = var_78_0
			self.resultList = self.bagManager:getBagData(self.filterTbl)

			return self.resultList
		end,
		[ITEMPANEL_TYPE_MEDAL] = function()
			self.filterTbl.filterConfig.pos = {
				self.medalPos,
				"all"
			}
			self.resultList = item_manager:getAllHavedMedals()

			return self.resultList
		end
	}

	if var_73_2[self.panelType] then
		self.itemList = var_73_2[self.panelType]()
	else
		({
			[ITEMPANEL_TYPE_ROLE_COMPONENT] = function()
				return
			end,
			[ITEMPANEL_TYPE_SMELT_COMPONENT] = function()
				return
			end,
			[ITEMPANEL_TYPE_ROLE_WEAPON] = function()
				return
			end,
			[ITEMPANEL_TYPE_WEAPON_STRENGTHEN] = function()
				return
			end,
			[ITEMPANEL_TYPE_UPGRADE_WEAPON] = function()
				return
			end,
			[ITEMPANEL_TYPE_COOK_ADD_FOOD] = function()
				for iter_85_0, iter_85_1 in pairs(self.cookFoods) do
					item_manager:deleteItem(iter_85_1.id, iter_85_1.num)
				end

				var_73_0 = {
					quality = {},
					orderType = self.orderType,
					sortType = self.sortType
				}

				for iter_85_2, iter_85_3 in ipairs(self.filterFlagData) do
					for iter_85_4, iter_85_5 in pairs(iter_85_3) do
						if iter_85_5 then
							table.insert(var_73_0.quality, iter_85_4)
						end
					end
				end
			end,
			[ITEMPANEL_TYPE_MEDAL] = function()
				return
			end,
			[ITEMPANEL_TYPE_SCULTURE] = function()
				var_73_0 = {}
			end,
			[ITEMPANEL_TYPE_DORM_FURNITURE] = function()
				return
			end
		})[self.panelType]()

		self.itemList = item_manager:filterSortItems(self.itemType, nil)
	end

	if self.panelType == ITEMPANEL_TYPE_ROLE_COMPONENT then
		if self.usedItems and next(self.usedItems) then
			for iter_73_0, iter_73_1 in pairs(self.usedItems) do
				if tonumber(iter_73_1) ~= tonumber(self.equipedEntityid) then
					table.insert(self.itemList, 1, iter_73_1)
				end
			end
		end
	elseif self.panelType == ITEMPANEL_TYPE_SMELT_COMPONENT then
		for iter_73_2, iter_73_3 in ipairs(var_73_1) do
			table.insert(self.itemList, iter_73_2, iter_73_3)
			table.insert(self.itemConditions.itemList, iter_73_2, iter_73_3)
		end
	elseif self.panelType == ITEMPANEL_TYPE_ROLE_WEAPON then
		if self.usedItems and next(self.usedItems) then
			for iter_73_4, iter_73_5 in pairs(self.usedItems) do
				if tonumber(iter_73_5) ~= tonumber(self.equipedEntityid) then
					table.insert(self.itemList, 1, iter_73_5)
				end
			end
		end
	elseif self.panelType == ITEMPANEL_TYPE_UPGRADE_WEAPON then
		-- block empty
	elseif self.panelType == ITEMPANEL_TYPE_DORM_FURNITURE then
		local var_73_3 = {}

		for iter_73_6, iter_73_7 in pairs(self.filterTbl.filterConfig.type) do
			var_73_3[iter_73_7] = true
		end

		if next(var_73_3) == nil then
			var_73_3[1] = true
			var_73_3[2] = true
			var_73_3[3] = true
			var_73_3[4] = true
			var_73_3[5] = true
		end

		for iter_73_8, iter_73_9 in pairs(playermodel.dormRoomConfig[self.itemConditions.roomid].furnitures) do
			if iter_73_9 > 0 and var_73_3[var_0_2[iter_73_9].furniture_type] then
				table.insert(self.itemList, 1, iter_73_9)
			end
		end

		local var_73_4 = {}

		for iter_73_10 = 1, 5 do
			if playermodel.dormRoomConfig[self.itemConditions.roomid].furnitures[iter_73_10] ~= self.usedItems[iter_73_10] and self.usedItems[iter_73_10] > 0 then
				table.insert(var_73_4, iter_73_10)
			end
		end

		if next(var_73_4) ~= nil then
			for iter_73_11, iter_73_12 in pairs(var_73_4) do
				if var_73_3[var_0_2[self.usedItems[iter_73_12]].furniture_type] then
					table.insert(self.itemList, 1, self.usedItems[iter_73_12])
				end
			end
		end
	end

	self.highestQuality = self:getHighestQuality()

	if self.listPanel then
		self.listPanel:reloadData()
	end
end

function ItemsPanel:initLayerPattern()
	if self.panelType == ITEMPANEL_TYPE_MEDAL then
		self.listPanel:setPositionX(cc.Director:getInstance():getVisibleSize().width / 2 - (self.listPanel:getContentSize().width / 2 + 5))

		Bg = self.rootLayer:getChildByName("Bg")

		Bg:loadTexture("mainScenebg/task_bg.jpg")

		local var_89_0 = ccui.ImageView:create("itempanel/medal_title.png", var_0_37)

		var_89_0:setAnchorPoint(cc.p(0, 0))
		print("###############", GameDisplay.fix_y, GameDisplay.height, var_89_0:getContentSize().height)
		var_89_0:setPosition(cc.p(0, GameDisplay.height - var_89_0:getContentSize().height - GameDisplay.fix_y))
		self.rootLayer:addChild(var_89_0, 999)
	else
		self.rootLayer:getChildByName("Bg"):loadTexture(LABEL_BG)
	end

	self.rootLayer:getChildByName("Bg"):setPositionY(GameDisplay.height / 2 - GameDisplay.fix_y - self.rootLayer:getChildByName("Bg"):getContentSize().height / 2)
end

function ItemsPanel:initItemsList()
	self:updateItemList()

	self.tableViewHeight = 0

	if self.panelType == ITEMPANEL_TYPE_ROLE_COMPONENT or self.panelType == ITEMPANEL_TYPE_ROLE_WEAPON then
		self.panelEquipment:setVisible(true)

		self.tableViewHeight = var_0_40

		self:createPanelofCompareItems()
	elseif self.panelType == ITEMPANEL_TYPE_DORM_FURNITURE then
		self.panelEquipment:setVisible(true)

		self.tableViewHeight = var_0_40
	elseif self.panelType == ITEMPANEL_TYPE_MEDAL then
		self.panelEquipment:setVisible(false)

		self.tableViewHeight = var_0_39

		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_48"):setVisible(false)
	else
		self.panelEquipment:setVisible(false)

		self.tableViewHeight = var_0_39
	end

	self.tableViewHeight = self.tableViewHeight + GameDisplay.fix_y * 2 - GameDisplay.notch_height
	self.listPanel = cc.TableView:create(cc.size(var_0_38, self.tableViewHeight))

	self.listPanel:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.listPanel:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.listPanel:setPosition(cc.p(var_0_42, var_0_43 - GameDisplay.fix_y))
	self.listPanel:setDelegate()
	self.itemsPanel:addChild(self.listPanel)
	self.listPanel:registerScriptHandler(function(arg_91_0, arg_91_1)
		return var_0_44, var_0_45
	end, cc.TABLECELL_SIZE_FOR_INDEX)

	local function var_90_0(arg_92_0, arg_92_1)
		if arg_92_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_92_0:getTouchBeganPosition().y - arg_92_0:getTouchEndPosition().y) > 50 then
			return
		end

		if self.panelType == ITEMPANEL_TYPE_WEAPON_STRENGTHEN then
			if arg_92_0.usedNum >= playermodel.items[arg_92_0.entityid].number then
				arg_92_0.usedNum = playermodel.items[arg_92_0.entityid].number
				self.usedItems[arg_92_0.entityid] = arg_92_0.usedNum

				return
			end

			if self.isStrengthenMax == true then
				self.bottomBnt2:getParent():getChildByName("gainexpLabel"):stopAllActions()
				self.bottomBnt2:getParent():getChildByName("costgoldLabel"):stopAllActions()
				self.bottomBnt2:getParent():getChildByName("gainexpLabel"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.05, 1.2), cc.ScaleTo:create(0.05, 1), cc.ScaleTo:create(0.05, 0.8), cc.ScaleTo:create(0.05, 1)))
				self.bottomBnt2:getParent():getChildByName("costgoldLabel"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.05, 1.2), cc.ScaleTo:create(0.05, 1), cc.ScaleTo:create(0.05, 0.8), cc.ScaleTo:create(0.05, 1)))

				return
			end

			arg_92_0.usedNum = arg_92_0.usedNum + 1
			self.usedItems[arg_92_0.entityid] = arg_92_0.usedNum

			if arg_92_0.usedNum > 0 then
				arg_92_0:getChildByName("selectedBg"):setVisible(true)
				arg_92_0:getChildByName("selectedBg"):getChildByName("label_num"):setString(arg_92_0.usedNum)
			else
				arg_92_0:getChildByName("selectedBg"):setVisible(false)
			end

			self:itemChangeUpdate(arg_92_0)
		elseif self.panelType == ITEMPANEL_TYPE_UPGRADE_WEAPON then
			if arg_92_0.selected then
				return
			end

			if playermodel.items[arg_92_0.entityid].weapon_attr and playermodel.items[arg_92_0.entityid].weapon_attr.lock then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_WEAPON_HAVE_LOCKED)
			else
				self:createItemHightLight(arg_92_0)

				if self.lastSelected and self.lastSelected.selected then
					self.lastSelected.selected:removeFromParent()

					self.lastSelected.selected = nil
				end

				self:itemChangeUpdate(arg_92_0)

				self.lastSelected = arg_92_0
				self.lastSelectedNum = arg_92_0.index
			end
		elseif self.panelType == ITEMPANEL_TYPE_COOK_ADD_FOOD then
			local var_92_0 = 0

			for iter_92_0, iter_92_1 in pairs(self.usedItems) do
				if iter_92_1 > 0 then
					var_92_0 = var_92_0 + iter_92_1
				else
					self.usedItems[iter_92_0] = nil
				end
			end

			self.isStrengthenMax = var_92_0 >= 3

			if self.isStrengthenMax then
				return
			end

			if arg_92_0.usedNum >= playermodel.items[arg_92_0.entityid].number then
				arg_92_0.usedNum = playermodel.items[arg_92_0.entityid].number
				self.usedItems[arg_92_0.entityid] = arg_92_0.usedNum

				return
			end

			arg_92_0.usedNum = arg_92_0.usedNum + 1
			self.usedItems[arg_92_0.entityid] = arg_92_0.usedNum

			if arg_92_0.usedNum > 0 then
				arg_92_0:getChildByName("selectedBg"):setVisible(true)
				arg_92_0:getChildByName("selectedBg"):getChildByName("label_num"):setString(arg_92_0.usedNum)
			else
				arg_92_0:getChildByName("selectedBg"):setVisible(false)
			end

			self:itemChangeUpdate(arg_92_0)
		elseif self.panelType == ITEMPANEL_TYPE_DORM_FURNITURE then
			self:itemChangeUpdate(arg_92_0)
		elseif self.panelType == ITEMPANEL_TYPE_ROLE_COMPONENT or self.panelType == ITEMPANEL_TYPE_ROLE_WEAPON then
			if arg_92_0.selected then
				arg_92_0.selected:removeFromParent()
				self.itemChoosed:removeAllChildren()
				self.itemChoosed:loadTexture(var_0_47, var_0_37)

				self.lastSelected.selected = nil
				self.choosedTag = false

				self:itemChangeUpdate(arg_92_0)

				if self.equipedEntityid == -1 then
					self.bottomBnt2:setVisible(false)
					self.bottomBnt2:setTouchEnabled(false)
				end

				if self.panelType == ITEMPANEL_TYPE_ROLE_COMPONENT then
					self.bottomBnt1:setVisible(false)
				end

				self.lastSelectedEntityid = entityid

				GuideListener.cleanCurGuides()
				GuideListener.swallowEvent(false)
				GuideListener.lockGuideTrigger(false)
				GuideListener.updateGuides(self)

				return
			end

			if self.lastSelected and self.lastSelected.selected then
				self.lastSelected.selected:removeFromParent()

				self.lastSelected.selected = nil
			end

			self.lastSelected = arg_92_0
			self.lastSelectedNum = arg_92_0.index

			self:createItemHightLight(arg_92_0)
			self:updatePanelofCompareItems(arg_92_0.entityid)
			self:itemChangeUpdate(arg_92_0)

			if self.choosedTag == false then
				self.choosedTag = true
			end
		else
			if arg_92_0.selected then
				return
			end

			self:createItemHightLight(arg_92_0)

			if self.lastSelected and self.lastSelected.selected then
				self.lastSelected.selected:removeFromParent()

				self.lastSelected.selected = nil
			end

			self:itemChangeUpdate(arg_92_0)

			self.lastSelected = arg_92_0
			self.lastSelectedNum = arg_92_0.index
		end
	end

	self.listPanel:registerScriptHandler(function(arg_93_0, arg_93_1)
		local var_93_0 = arg_93_0:dequeueCell()

		if not var_93_0 then
			var_93_0 = cc.TableViewCell:create()

			for iter_93_0 = 1, 4 do
				if self.itemList[4 * arg_93_1 + iter_93_0] then
					local var_93_1 = self:createItem(self.itemList[4 * arg_93_1 + iter_93_0])

					var_93_1:setCascadeOpacityEnabled(true)
					var_93_1:setName("sp_" .. arg_93_1 .. "_" .. iter_93_0)
					var_93_1:setPosition(var_0_46[iter_93_0])
					var_93_0:addChild(var_93_1)

					var_93_1.entityid = self.itemList[4 * arg_93_1 + iter_93_0]
					var_93_1.index = 4 * arg_93_1 + iter_93_0
					self.itemBnts[4 * arg_93_1 + iter_93_0] = var_93_1

					if var_93_1:getChildByName("icon"):getChildByName("attr") then
						var_93_1:getChildByName("icon"):getChildByName("attr"):setVisible(self.isShowAttrs)
					end

					var_93_1:addTouchEventListener(var_90_0)

					if self.panelType ~= ITEMPANEL_TYPE_WEAPON_STRENGTHEN and self.panelType ~= ITEMPANEL_TYPE_COOK_ADD_FOOD then
						if self.panelType == ITEMPANEL_TYPE_DORM_FURNITURE then
							if self.lastSelectedNum and 4 * arg_93_1 + iter_93_0 == self.lastSelectedNum then
								var_90_0(var_93_1, ccui.TouchEventType.ended)
							end
						elseif self.panelType == ITEMPANEL_TYPE_ROLE_COMPONENT or self.panelType == ITEMPANEL_TYPE_ROLE_WEAPON then
							-- block empty
						elseif 4 * arg_93_1 + iter_93_0 == (self.lastSelectedNum or 1) then
							var_90_0(var_93_1, ccui.TouchEventType.ended)
						end
					end

					if not self.lastSelected and self.panelType == ITEMPANEL_TYPE_ROLE_COMPONENT then
						self.lastSelected = var_93_1
						self.lastSelectedNum = var_93_1.index

						self:createItemHightLight(var_93_1)
						self:updatePanelofCompareItems(var_93_1.entityid)
						self:itemChangeUpdate(var_93_1)

						if self.choosedTag == false then
							self.choosedTag = true
						end
					end
				end
			end
		else
			var_93_0:removeAllChildren()

			for iter_93_1 = 1, 4 do
				if self.itemList[4 * arg_93_1 + iter_93_1] then
					local var_93_4 = self:createItem(self.itemList[4 * arg_93_1 + iter_93_1])

					var_93_4:setCascadeOpacityEnabled(true)
					var_93_4:setName("sp_" .. arg_93_1 .. "_" .. iter_93_1)
					var_93_4:setPosition(var_0_46[iter_93_1])
					var_93_0:addChild(var_93_4)

					var_93_4.entityid = self.itemList[4 * arg_93_1 + iter_93_1]
					var_93_4.index = 4 * arg_93_1 + iter_93_1
					self.itemBnts[4 * arg_93_1 + iter_93_1] = var_93_4

					if var_93_4:getChildByName("icon"):getChildByName("attr") then
						var_93_4:getChildByName("icon"):getChildByName("attr"):setVisible(self.isShowAttrs)
					end

					var_93_4:addTouchEventListener(var_90_0)

					if self.panelType ~= ITEMPANEL_TYPE_WEAPON_STRENGTHEN and self.panelType ~= ITEMPANEL_TYPE_COOK_ADD_FOOD then
						if self.panelType == ITEMPANEL_TYPE_DORM_FURNITURE then
							if self.lastSelectedNum and 4 * arg_93_1 + iter_93_1 == self.lastSelectedNum then
								var_90_0(var_93_4, ccui.TouchEventType.ended)
							end
						elseif self.panelType == ITEMPANEL_TYPE_ROLE_COMPONENT or self.panelType == ITEMPANEL_TYPE_ROLE_WEAPON then
							-- block empty
						elseif 4 * arg_93_1 + iter_93_1 == (self.lastSelectedNum or 1) then
							var_90_0(var_93_4, ccui.TouchEventType.ended)
						end
					end
				end
			end
		end

		if self.startRunOutAni then
			self.startIndex = self.startIndex or arg_93_1

			local var_93_6 = LAYER_OUT_TIME / math.ceil(self.tableViewHeight / var_0_45)

			for iter_93_2 = 1, 4 do
				if var_93_0:getChildByName("sp_" .. arg_93_1 .. "_" .. iter_93_2) then
					var_93_0:getChildByName("sp_" .. arg_93_1 .. "_" .. iter_93_2):runAction(cc.Sequence:create(cc.DelayTime:create((arg_93_1 - self.startIndex) * var_93_6), cc.FadeOut:create(var_93_6)))
				end
			end
		end

		if self.selectTblAni then
			local var_93_7 = LAYER_OUT_TIME / math.ceil(self.tableViewHeight / var_0_45) * 1.5

			for iter_93_3 = 1, 4 do
				if var_93_0:getChildByName("sp_" .. arg_93_1 .. "_" .. iter_93_3) then
					var_93_0:getChildByName("sp_" .. arg_93_1 .. "_" .. iter_93_3):setOpacity(0)
					var_93_0:getChildByName("sp_" .. arg_93_1 .. "_" .. iter_93_3):runAction(cc.Sequence:create(cc.DelayTime:create(arg_93_1 * var_93_7), cc.FadeIn:create(var_93_7)))
				end
			end
		else
			for iter_93_4 = 1, 4 do
				if var_93_0:getChildByName("sp_" .. arg_93_1 .. "_" .. iter_93_4) then
					var_93_0:getChildByName("sp_" .. arg_93_1 .. "_" .. iter_93_4):setOpacity(255)
				end
			end
		end

		return var_93_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.listPanel:registerScriptHandler(function(arg_94_0, arg_94_1)
		local var_94_0 = math.ceil(#self.itemList / 3)

		return self.panelType == ITEMPANEL_TYPE_DORM_FURNITURE and math.ceil(#self.itemList / 4) + 1 or self.panelType == ITEMPANEL_TYPE_MEDAL and math.ceil(#self.itemList / 4) or math.ceil(#self.itemList / 4)
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.listPanel:reloadData()
end

function ItemsPanel:updateFurnitureSuitList()
	if not self.furnitureSuitlist then
		self.furnitureSuitlist = cc.TableView:create(cc.size(var_0_38, var_0_40 + GameDisplay.fix_y * 2))

		self.furnitureSuitlist:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
		self.furnitureSuitlist:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
		self.furnitureSuitlist:setPosition(cc.p(54, var_0_43 - GameDisplay.fix_y))
		self.furnitureSuitlist:setDelegate()
		self.itemsPanel:addChild(self.furnitureSuitlist)
		self.furnitureSuitlist:registerScriptHandler(function(arg_98_0, arg_98_1)
			return 586, 320
		end, cc.TABLECELL_SIZE_FOR_INDEX)
		self.furnitureSuitlist:registerScriptHandler(function(arg_96_0, arg_96_1)
			local var_96_0 = arg_96_0:dequeueCell()

			if not var_96_0 then
				var_96_0 = cc.TableViewCell:create()
			else
				var_96_0:removeAllChildren()
			end

			local var_96_3

			if arg_96_1 + 1 > #self.shopList then
				var_96_3 = self.suitList[arg_96_1 + 1 - #self.shopList] or self.shopList[arg_96_1 + 1].suitid
			end

			local var_96_4 = furnituresuit_data[var_96_3]
			local var_96_5 = ccui.Button:create("itempanel/furniture_bg.png", "itempanel/furniture_bg.png", "itempanel/furniture_bg.png", var_0_37)

			var_96_5:setSwallowTouches(false)
			var_96_5:setTouchEnabled(true)

			var_96_5.suitid = var_96_3

			var_96_5:setAnchorPoint(cc.p(0.5, 1))
			var_96_5:setPosition(293, 310)
			var_96_5:setCascadeOpacityEnabled(true)
			var_96_0:addChild(var_96_5)

			local var_96_6 = ccui.ImageView:create("mainScenebg/market/" .. var_0_2[furnituresuit_data[var_96_3].furniture_gift_id].image_id .. ".jpg")

			var_96_6:setAnchorPoint(cc.p(0.5, 1))
			var_96_6:setPosition(var_96_5:getContentSize().width / 2, var_96_5:getContentSize().height)
			var_96_5:addChild(var_96_6, -1)

			local var_96_7 = ccui.ImageView:create("itempanel/name_bg.png", var_0_37)

			var_96_7:setScaleX(var_96_5:getContentSize().width / var_96_7:getContentSize().width)
			var_96_7:setAnchorPoint(cc.p(0.5, 1))
			var_96_7:setPosition(var_96_5:getContentSize().width / 2, 0)
			var_96_5:addChild(var_96_7)

			local var_96_8 = cc.Label:createWithTTF(var_0_2[furnituresuit_data[var_96_3].furniture_gift_id].name, FONT_DES, 30)

			var_96_8:setPosition(var_96_7:getContentSize().width / 2, var_96_7:getContentSize().height / 2)
			var_96_7:addChild(var_96_8)

			if arg_96_1 + 1 <= #self.shopList then
				var_96_5.shopconfig = self.shopList[arg_96_1 + 1]

				var_96_6:setOpacity(120)

				local var_96_9 = ccui.ImageView:create("Dormitory/recommend_logo.png", var_0_37)

				var_96_9:setAnchorPoint(cc.p(0, 1))
				var_96_9:setPosition(0, var_96_5:getContentSize().height)
			end

			if var_96_3 == self.furnitureSuitlist.selectSuitId then
				local var_96_10

				if config._DEBUG then
					var_96_10 = cc.Scale9Sprite:create("public/box/used_on.png") or cc.Scale9Sprite:createWithSpriteFrameName("public/box/used_on.png")
				end

				var_96_10:setCapInsets(cc.rect(var_96_10:getContentSize().width / 2 - 5, var_96_10:getContentSize().height / 2 - 5, 10, 10))
				var_96_10:setContentSize(cc.size(var_96_6:getContentSize().width, var_96_10:getContentSize().height))
				var_96_10:setAnchorPoint(cc.p(0.5, 0.5))
				var_96_10:setPosition(cc.p(var_96_5:getContentSize().width / 2, var_96_5:getContentSize().height * 2 / 5))
				var_96_10:setName("uesdTag")

				local var_96_11 = cc.Label:createWithTTF(L_COMMON_WARNING.Using, "fonts/newkj.ttf", 22)

				var_96_11:setColor(cc.c3b(255, 100, 0))
				var_96_11:setPosition(var_96_10:getContentSize().width / 2, var_96_10:getContentSize().height / 2)
				var_96_10:addChild(var_96_11, 9)
				var_96_5:addChild(var_96_10)

				self.furnitureSuitlist.selectSuitImg = var_96_5
			end

			var_96_5:addTouchEventListener(function(arg_97_0, arg_97_1)
				if arg_97_1 ~= ccui.TouchEventType.ended then
					return
				end

				if math.abs(arg_97_0:getTouchBeganPosition().y - arg_97_0:getTouchEndPosition().y) > 50 then
					return
				end

				self:furnitureSuitChangeUpdate(arg_97_0)
			end)

			if self.startRunOutAni then
				self.startIndex = self.startIndex or arg_96_1

				local var_96_12 = LAYER_OUT_TIME / math.ceil(self.tableViewHeight / var_0_45)

				var_96_5:runAction(cc.Sequence:create(cc.DelayTime:create((arg_96_1 - self.startIndex) * var_96_12), cc.FadeOut:create(var_96_12)))
			end

			if self.selectTblAni then
				var_96_5:setOpacity(0)

				local var_96_13 = LAYER_OUT_TIME / math.ceil(self.tableViewHeight / var_0_45) * 1.5

				var_96_5:runAction(cc.Sequence:create(cc.DelayTime:create(arg_96_1 * var_96_13), cc.FadeIn:create(var_96_13)))
			else
				var_96_5:setOpacity(255)
			end

			self:initMiniHead(var_96_5, var_96_4)

			return var_96_0
		end, cc.TABLECELL_SIZE_AT_INDEX)
		self.furnitureSuitlist:registerScriptHandler(function(arg_99_0, arg_99_1)
			return #self.shopList + #self.suitList
		end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
		self.furnitureSuitlist:reloadData()
	else
		self.furnitureSuitlist:setVisible(true)
		self.furnitureSuitlist:reloadData()
	end
end

function ItemsPanel:initMiniHead(arg_100_1, arg_100_2, arg_100_3)
	if (arg_100_2 and arg_100_2.servantid and major_factor_data[arg_100_2.servantid] and major_factor_data[arg_100_2.servantid].model) == nil then
		return
	end

	if arg_100_1:getChildByName("isShowHaveServant") then
		arg_100_1:getChildByName("isShowHaveServant"):removeFromParent()
	end

	if arg_100_1:getChildByName("mask") then
		arg_100_1:getChildByName("mask"):removeFromParent()
	end

	if arg_100_1:getChildByName("di") then
		arg_100_1:getChildByName("di"):removeFromParent()
	end

	local var_100_2 = arg_100_3 or cc.p(72, 190)
	local var_100_3 = "roleimage/role1/" .. model_data[var_100_0].cute_role .. ".png"
	local var_100_4

	if config._DEBUG then
		var_100_4 = cc.Sprite:create("public/rolebg/q_avatar_furniture_mask.png") or cc.Sprite:createWithSpriteFrameName("public/rolebg/q_avatar_furniture_mask.png")
	end

	local var_100_5 = cc.Sprite:create(var_100_3)

	var_100_5:setScale(0.28)
	var_100_5:setPosition(cc.p(-20, 30))

	local var_100_6 = cc.ClippingNode:create(var_100_4)

	var_100_6:setAlphaThreshold(0.5)
	var_100_6:setContentSize(cc.size(120, 112))
	var_100_6:setPosition(var_100_2)
	var_100_6:addChild(var_100_5)

	self.miniHeadNode = var_100_6

	self.miniHeadNode:setName("isShowHaveServant")
	arg_100_1:addChild(var_100_6, 99)

	maskNode = ccui.ImageView:create("public/rolebg/q_avatar_furniture_lock.png", var_0_37)

	maskNode:setName("mask")
	maskNode:setPosition(var_100_2)
	arg_100_1:addChild(maskNode, 99)
	maskNode:setVisible(self:isShowHaveServant(arg_100_2.furniture_gift_id) == false)

	local var_100_7 = ccui.ImageView:create("public/rolebg/q_avatar_furniture_di.png", var_0_37)

	var_100_7:setName("di")
	var_100_7:setPosition(var_100_2)
	arg_100_1:addChild(var_100_7, 98)
end

function ItemsPanel.isShowHaveServant(arg_101_0, arg_101_1)
	local var_101_0 = false
	local var_101_1 = {}

	if var_0_2[arg_101_1] and var_0_2[arg_101_1].bag_item_type == kITEM_WEAPON then
		table.insert(var_101_1, var_0_2[arg_101_1].servant)
	elseif var_0_2[arg_101_1] and var_0_2[arg_101_1].bag_item_type == kITEM_GIFT_FOR_FRIEND then
		for iter_101_0, iter_101_1 in pairs(servant_data) do
			if iter_101_1.major == var_0_2[arg_101_1].exclusive then
				table.insert(var_101_1, iter_101_1.id)
			end
		end
	elseif var_0_2[arg_101_1] and var_0_2[arg_101_1].bag_item_type == kITEM_FURNITURE_GIFT and furnituresuit_data[var_0_2[arg_101_1].suit_id] then
		for iter_101_2, iter_101_3 in pairs(servant_data) do
			if iter_101_3.major == furnituresuit_data[var_0_2[arg_101_1].suit_id].servantid then
				table.insert(var_101_1, iter_101_3.id)
			end
		end
	end

	for iter_101_4, iter_101_5 in pairs(var_101_1) do
		if playermodel.haveServant[iter_101_5] then
			var_101_0 = true

			break
		end
	end

	return var_101_0
end

local function var_0_69(arg_102_0)
	local var_102_0 = require("controller.dormitory_manager"):getUsedFurniture()

	if var_102_0[arg_102_0] then
		return playermodel.items[arg_102_0].number - var_102_0[arg_102_0]
	else
		return playermodel.items[arg_102_0].number
	end
end

function ItemsPanel:furnitureSuitChangeUpdate(arg_103_1)
	if self.furnitureSuitlist.selectSuitId and self.furnitureSuitlist.selectSuitId == arg_103_1.suitid then
		return
	end

	if arg_103_1.shopconfig then
		self:goBuyFurniture(arg_103_1.shopconfig.shopinfo, arg_103_1.shopconfig.shoptype)
	else
		if self.furnitureSuitlist.selectSuitImg and self.furnitureSuitlist.selectSuitImg.suitid then
			self.furnitureSuitlist.selectSuitImg:getChildByName("uesdTag"):removeFromParent()
		end

		self.furnitureSuitlist.selectSuitImg = arg_103_1
		self.furnitureSuitlist.selectSuitId = arg_103_1.suitid

		if not arg_103_1:getChildByName("uesdTag") then
			local var_103_0

			if config._DEBUG then
				var_103_0 = cc.Scale9Sprite:create("public/box/used_on.png") or cc.Scale9Sprite:createWithSpriteFrameName("public/box/used_on.png")
			end

			var_103_0:setCapInsets(cc.rect(var_103_0:getContentSize().width / 2 - 5, var_103_0:getContentSize().height / 2 - 5, 10, 10))
			var_103_0:setContentSize(cc.size(arg_103_1:getContentSize().width, var_103_0:getContentSize().height))
			var_103_0:setAnchorPoint(cc.p(0.5, 0.5))
			var_103_0:setPosition(cc.p(arg_103_1:getContentSize().width / 2, arg_103_1:getContentSize().height * 2 / 5))
			var_103_0:setName("uesdTag")

			local var_103_1 = cc.Label:createWithTTF(L_COMMON_WARNING.Using, "fonts/newkj.ttf", 24)

			var_103_1:setColor(cc.c3b(255, 100, 0))
			var_103_1:setPosition(var_103_0:getContentSize().width / 2, var_103_0:getContentSize().height / 2)
			var_103_0:addChild(var_103_1, 9)
			arg_103_1:addChild(var_103_0)
		end

		for iter_103_0 = 1, 5 do
			self.usedItems[iter_103_0] = furnituresuit_data[arg_103_1.suitid]["furniture" .. iter_103_0]
		end

		self.roomPanel:updataFurniture(self.usedItems)
		self.bottomBnt1:setVisible(true)
		self.bottomBnt2:setVisible(true)
		self.bottomBnt1:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Restore)
		self.bottomBnt2:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Sure)
		self.bottomBnt1:addTouchEventListener(function(arg_104_0, arg_104_1)
			if arg_104_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.usedItems = global_deepCopy(playermodel.dormRoomConfig[self.itemConditions.roomid].furnitures)

			self.roomPanel:updataFurniture(self.usedItems)
			self:furnituresAction()

			self.furnitureSuitlist.selectSuitImg = nil
			self.furnitureSuitlist.selectSuitId = nil

			self.furnitureSuitlist:reloadData()

			self.lastUsedItems = {}

			self.listPanel:reloadData()
			self.bottomBnt1:setVisible(false)
			self.bottomBnt2:setVisible(false)
		end)
		self.bottomBnt2:addTouchEventListener(function(arg_105_0, arg_105_1)
			if arg_105_1 ~= ccui.TouchEventType.ended then
				return
			end

			arg_105_0:setTouchEnabled(false)

			local var_105_0 = false

			for iter_105_0, iter_105_1 in pairs(self.usedItems) do
				if iter_105_1 ~= playermodel.dormRoomConfig[self.itemConditions.roomid].furnitures[iter_105_0] then
					var_105_0 = true

					break
				end
			end

			self:exit()

			if self.surecallback then
				self.surecallback(self.usedItems, var_105_0)
			end
		end)
	end
end

function ItemsPanel.goBuyFurniture(arg_106_0, arg_106_1, arg_106_2)
	local var_106_0 = {
		[6800202] = "public/currency/6800202.png",
		[var_0_53] = "public/currency/UI_battleEnd_gold.png",
		[var_0_52] = "public/currency/UI_battleEnd_diamond.png",
		[var_0_54] = "public/currency/arenascene_dot_1.png",
		[var_0_55] = "public/currency/explorecoin.png",
		[var_0_57] = "public/currency/rmb_white.png",
		[BLACK_CARD] = "public/currency/1500001_1.png",
		[BLACK_SP_CARD] = "public/currency/1500002_1.png"
	}

	setmetatable(var_106_0, {
		__index = function(arg_107_0, arg_107_1)
			return "public/currency/" .. var_0_2[arg_107_1].image_id .. ".png"
		end
	})

	local var_106_1 = {
		[var_0_53] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "HandOfMidasLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_GOLD
			})
		end,
		[var_0_52] = function()
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1
			})
		end,
		[var_0_54] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ArenaLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_HORNOR
			})
		end,
		[var_0_55] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ExploreMapLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_EXPLORECOIN
			})
		end
	}

	setmetatable(var_106_1, {
		__index = function(arg_112_0, arg_112_1)
			return function()
				global_ShowBlockWords(string.format(L_COMMON_WARNING.Used_Up, var_0_2[arg_112_1].name))
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end
	})

	local function var_106_2(arg_114_0)
		if not arg_114_0 then
			return "-1"
		end

		local var_114_5 = global_get_time_by_date(arg_114_0) - playermodel.onlineTime
		local var_114_6 = math.floor(var_114_5 / 24 / 3600)
		local var_114_7 = math.floor((var_114_5 - var_114_6 * 24 * 3600) / 3600)
		local var_114_8 = math.floor((var_114_5 - var_114_6 * 24 * 3600 - var_114_7 * 3600) / 60)

		return var_114_6 ~= 0 and string.format(L_TIME_TEXT[1], var_114_6, var_114_7) or var_114_7 ~= 0 and string.format(L_TIME_TEXT[2], var_114_7, var_114_8) or string.format(L_TIME_TEXT[3], var_114_8)
	end

	local function var_106_3(arg_115_0)
		if not arg_115_0.currency2 or discount_manager:getLastPriceByItem(arg_115_0.itemid, arg_115_0.currency2, arg_115_0.discount2) < arg_115_0.discount2 then
			return true
		end

		return false
	end

	local function var_106_4(arg_124_0)
		local var_124_0 = {
			name = var_0_2[arg_124_0.itemtype].name,
			itemid = arg_124_0.itemtype,
			shopid = arg_124_0.shopid,
			costIcon = var_106_0[arg_124_0.currency],
			currency = arg_124_0.currency,
			isnewitem = arg_124_0.isnewitem,
			discountfinish = arg_124_0.discountfinish
		}

		var_124_0.cost = arg_124_0.discount or arg_124_0.price

		if arg_124_0.currency2 then
			var_124_0.costIcon2 = var_106_0[arg_124_0.currency2]
			var_124_0.currency2 = arg_124_0.currency2
			var_124_0.discount2 = arg_124_0.discount2 or arg_124_0.price2
			var_124_0.cost_old2 = arg_124_0.price2
		end

		var_124_0.quality = var_0_2[arg_124_0.itemtype].equip_quality or 1
		var_124_0.cost_old = arg_124_0.price
		var_124_0.bag_item_type = var_0_2[arg_124_0.itemtype].bag_item_type
		var_124_0.item_attr = arg_124_0.item_attr
		var_124_0.finish_time = arg_124_0.finish_time
		var_124_0.discount = arg_124_0.discount
		var_124_0.buy_limit = arg_124_0.buy_limit or 1000000
		var_124_0.have_bought = arg_124_0.have_bought or 0
		var_124_0.sell_out = arg_124_0.buy_limit and arg_124_0.buy_limit <= arg_124_0.have_bought
		var_124_0.tag = arg_124_0.tag or 0
		var_124_0.pos = arg_124_0.pos
		var_124_0.purchaseid = arg_124_0.productid

		return var_124_0
	end

	if arg_106_1.currency == var_0_57 then
		(function(arg_120_0)
			local var_120_0 = {
				itemid = arg_120_0.itemid,
				item_attr = arg_120_0.item_attr
			}
			local var_120_1 = {
				costtype = arg_120_0.costIcon
			}

			var_120_1.costnum = arg_120_0.discount or arg_120_0.cost
			var_120_0.slidecost = var_120_1

			function var_120_0:ShopSliderCallback(arg_121_1, arg_121_2)
				if arg_121_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_120_0.have_bought >= arg_120_0.buy_limit then
					global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
					audio_manager:playeffectMusicTest("sound/invalid")

					return
				end

				self:setTouchEnabled(false)
				shop_manager:shop_purchase(arg_120_0.shopid, arg_120_0.purchaseid, function(arg_122_0)
					if arg_122_0 == 1 then
						arg_106_1.have_bought = arg_106_1.have_bought + curbuyTime
						arg_106_1.sell_out = arg_106_1.buy_limit and arg_106_1.buy_limit <= arg_106_1.have_bought
						arg_106_0.suitList, arg_106_0.shopList = dormitory_manager:getHavedFurnitureSuits(arg_106_0.itemConditions.roomid)

						arg_106_0:updateFurnitureSuitList()

						if arg_106_0:getChildByName("popBuyLayer") then
							arg_106_0:getChildByName("popBuyLayer"):removeFromParent()
						end

						if var_0_2[var_120_0.itemid].bag_item_type == kITEM_SKIN then
							require("view.Layer.GetRoleAnimationLayer")
							cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_120_0.itemid), 1000)
						end

						if arg_106_2 == 6 then
							for iter_122_0, iter_122_1 in pairs({
								{
									entityid = var_120_0.itemid
								}
							}) do
								network:rpc("use_gift_bag", {
									num = 1,
									entityid = iter_122_1.entityid
								}, function(arg_123_0)
									if arg_123_0.result == 1 then
										global_gain(arg_123_0)
										item_manager:deleteItem(iter_122_1.entityid, 1)
									else
										global_ShowBlockWords(L_MARKET_MSG.Gift_Bag_Lack)
									end
								end)
							end
						else
							cc.Director:getInstance():getRunningScene():addChild(PopLayer:Gain({
								items = {
									{
										dropNum = 1,
										dropid = var_120_0.itemid,
										entityid = var_120_0.itemid
									}
								}
							}), 999)
						end
					elseif arg_122_0 == 2 then
						global_ShowBlockWords(L_MARKET_MSG.Goods_Sended)
						audio_manager:playeffectMusicTest("sound/invalid")
					end

					if arg_121_2 then
						arg_121_2(arg_122_0)
					end
				end)
			end

			if arg_106_2 == 4 or arg_106_2 == 6 then
				arg_106_0:buyFurniturePop(var_120_0)
			else
				print("暂时没给非服装商城做人民币支付")
			end

			arg_120_0.isnewitem = false
		end)(var_106_4(arg_106_1))
	else
		(function(arg_116_0)
			local var_116_0 = {
				itemid = arg_116_0.itemid,
				item_attr = arg_116_0.item_attr,
				data = arg_116_0
			}

			var_116_0.limitNum = arg_116_0.buy_limit and arg_116_0.buy_limit - arg_116_0.have_bought or 100

			local var_116_1 = math.floor(var_0_58[arg_116_0.currency]() / arg_116_0.cost)

			if var_116_1 > var_116_0.limitNum then
				var_116_0.limitNum = var_116_0.limitNum or var_116_1
			end

			local var_116_2 = var_106_2(arg_116_0.finish_time)

			if var_116_2 ~= "-1" then
				var_116_0.limit_time = L_MARKET_MSG.Rest_Time .. var_116_2
			end

			var_116_0.slidecost = {
				nowHave = var_0_58[arg_116_0.currency]()
			}

			if var_106_3(arg_116_0) then
				var_116_0.slidecost.costtype = arg_116_0.costIcon
				var_116_0.slidecost.costnum = arg_116_0.discount or arg_116_0.cost
				var_116_0.slidecost.cost_old = arg_116_0.cost_old or var_116_0.slidecost.costnum
				var_116_0.slidecost.nowHave = var_0_58[arg_116_0.currency]()
				var_116_0.currency = arg_116_0.currency
			else
				var_116_0.slidecost.costtype = arg_116_0.costIcon2
				var_116_0.slidecost.costnum = arg_116_0.discount2 or arg_116_0.cost2
				var_116_0.slidecost.cost_old = arg_116_0.cost_old2 or var_116_0.slidecost.costnum
				var_116_0.slidecost.nowHave = var_0_58[arg_116_0.currency2]()
				var_116_0.currency = arg_116_0.currency2
			end

			function var_116_0:ShopSliderCallback(arg_117_1, arg_117_2, arg_117_3, arg_117_4)
				if arg_117_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not self:isBright() then
					return
				end

				local var_117_0
				local var_117_1

				if var_106_3(arg_116_0) then
					var_117_0 = arg_116_0.currency
					var_117_1 = arg_116_0.discount
				else
					var_117_0 = arg_116_0.currency2
					var_117_1 = arg_116_0.discount2
				end

				if var_117_1 > var_0_58[var_117_0]() + discount_manager:getCouponsDiscount(arg_117_3) then
					var_106_1[var_117_0]()

					if arg_106_0:getChildByName("popBuyLayer") then
						arg_106_0:getChildByName("popBuyLayer"):runAction(cc.RemoveSelf:create())
					end

					return
				end

				self:setTouchEnabled(false)

				local var_117_2 = self.nowNum or 1

				if not arg_117_3 then
					shop_manager:shop_buy(arg_106_2, arg_116_0.shopid, function(arg_118_0)
						if arg_118_0 == 1 then
							arg_106_1.have_bought = arg_106_1.have_bought + var_117_2
							arg_106_1.sell_out = arg_106_1.buy_limit and arg_106_1.buy_limit <= arg_106_1.have_bought
							arg_106_0.suitList, arg_106_0.shopList = dormitory_manager:getHavedFurnitureSuits(arg_106_0.itemConditions.roomid)

							arg_106_0:updateFurnitureSuitList()

							if var_0_2[var_116_0.itemid].bag_item_type == kITEM_SKIN then
								require("view.Layer.GetRoleAnimationLayer")
								cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_116_0.itemid), 1000)
							end

							if arg_117_2 then
								arg_117_2()
							end
						elseif arg_118_0 == 2 then
							global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
							audio_manager:playeffectMusicTest("sound/invalid")
						elseif arg_118_0 == 3 then
							var_106_1[arg_116_0.currency]()
						end

						if arg_117_2 then
							arg_117_2(arg_118_0)
						end
					end, var_117_2, nil, nil, arg_117_4)
				else
					shop_manager:shop_buy_with_ticket(arg_106_2, arg_116_0.shopid, function(arg_119_0)
						if arg_119_0 == 1 then
							arg_106_1.have_bought = arg_106_1.have_bought + var_117_2
							arg_106_1.sell_out = arg_106_1.buy_limit and arg_106_1.buy_limit <= arg_106_1.have_bought
							arg_106_0.suitList, arg_106_0.shopList = dormitory_manager:getHavedFurnitureSuits(arg_106_0.itemConditions.roomid)

							arg_106_0:updateFurnitureSuitList()

							if var_0_2[var_116_0.itemid].bag_item_type == kITEM_SKIN then
								require("view.Layer.GetRoleAnimationLayer")
								cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_116_0.itemid), 1000)
							end

							if arg_117_2 then
								arg_117_2()
							end
						elseif arg_119_0 == 2 then
							global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
							audio_manager:playeffectMusicTest("sound/invalid")
						elseif arg_119_0 == 3 then
							var_106_1[arg_116_0.currency]()
						end

						if arg_117_2 then
							arg_117_2(arg_119_0)
						end
					end, var_117_2, nil, arg_117_3, 1)
				end
			end

			var_116_0.hideGainButton = true

			if arg_116_0.have_bought and arg_116_0.buy_limit then
				var_116_0.limit_buy_num = arg_116_0.buy_limit - arg_116_0.have_bought
				var_116_0.have_bought_num = arg_116_0.have_bought
			end

			local var_116_3 = discount_manager:getCanUseCoupin(var_116_0.itemid, var_116_0.currency, var_116_0.costnum or var_116_0.slidecost.costnum, arg_106_2)

			if var_116_3 and next(var_116_3) then
				var_116_0.couponList = var_116_3

				arg_106_0:showBachelorFurniturePop(var_116_0)

				arg_116_0.isnewitem = false

				return
			end

			arg_106_0:showFurniturePopNew(var_116_0)

			arg_116_0.isnewitem = false
		end)(var_106_4(arg_106_1))
	end
end

function ItemsPanel:buyFurniturePop(arg_125_1)
	local var_125_0 = ccui.Layout:create()

	var_125_0:setTouchEnabled(true)
	var_125_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_125_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_125_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	var_125_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_125_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_125_0:setBackGroundColorOpacity(180)
	var_125_0:setName("popBuyLayer")
	self:addChild(var_125_0, 10)

	local var_125_1 = ccui.ImageView:create("mainScenebg/market/" .. arg_125_1.itemid .. ".jpg")

	var_125_1:setPosition(cc.p(var_125_0:getContentSize().width / 2, var_125_0:getContentSize().height / 2))
	var_125_0:addChild(var_125_1)

	local var_125_2 = ccui.ImageView:create("itempanel/furniture_bg.png", var_0_37)

	var_125_2:setPosition(cc.p(var_125_1:getContentSize().width / 2, var_125_1:getContentSize().height / 2 - 18))
	var_125_1:addChild(var_125_2)

	local var_125_3 = cc.Label:createWithTTF(var_0_2[arg_125_1.itemid].name, FONT_DES, 22)

	var_125_3:setPosition(cc.p(470, 235))
	var_125_2:addChild(var_125_3)

	local var_125_4 = -130

	if arg_125_1.slidecost.cost_old and arg_125_1.slidecost.costnum < arg_125_1.slidecost.cost_old then
		local var_125_5 = ccui.ImageView:create(arg_125_1.slidecost.costtype, var_0_37)

		var_125_5:setPositionX(var_125_2:getContentSize().width / 2 - 30)
		var_125_5:setPositionY(var_125_4)
		var_125_2:addChild(var_125_5)

		local var_125_6 = cc.Label:createWithTTF(arg_125_1.slidecost.cost_old, FONT_DES, 23)

		var_125_6:setAnchorPoint(cc.p(0, 0.5))
		var_125_6:setPositionX(var_125_5:getPositionX() + var_125_5:getContentSize().width / 2 + 5)
		var_125_6:setPositionY(var_125_5:getPositionY())
		var_125_2:addChild(var_125_6)

		local var_125_7 = ccui.ImageView:create("public/currency/discount_line.png", var_0_37)

		var_125_7:setPositionX((var_125_5:getPositionX() + var_125_6:getPositionX() + var_125_6:getContentSize().width / 2) / 2)
		var_125_7:setPositionY(var_125_5:getPositionY())
		var_125_2:addChild(var_125_7, 2)

		var_125_4 = var_125_4 - 45
	end

	local var_125_8 = ccui.ImageView:create(arg_125_1.slidecost.costtype, var_0_37)

	var_125_8:setPositionX(var_125_2:getContentSize().width / 2 - 30)
	var_125_8:setPositionY(var_125_4)
	var_125_2:addChild(var_125_8)

	local var_125_9 = cc.Label:createWithTTF(arg_125_1.slidecost.costnum, FONT_DES, 23)

	var_125_9:setAnchorPoint(cc.p(0, 0.5))
	var_125_9:setPositionX(var_125_8:getPositionX() + var_125_8:getContentSize().width / 2 + 5)
	var_125_9:setPositionY(var_125_8:getPositionY())
	var_125_2:addChild(var_125_9)

	local var_125_10
	local var_125_11

	if arg_125_1.slidecost.costnum > arg_125_1.slidecost.nowHave then
		var_125_10 = ccui.Button:create("public/button/public_button_off.png", nil, "public/button/public_button_off.png", var_0_37)
		var_125_11 = cc.Label:createWithTTF(L_BUTTON_TEXT.Not_Enough, FONT_BUTTON, 26)
	else
		var_125_10 = ccui.Button:create("public/button/public_button_big_y.png", nil, "public/button/public_button_big_y.png", var_0_37)
		var_125_11 = cc.Label:createWithTTF(L_BUTTON_TEXT.Buy, FONT_BUTTON, 26)
	end

	var_125_11:setColor(cc.c3b(12, 12, 12))
	var_125_10:setScale9Enabled(true)
	var_125_10:setCapInsets(cc.rect(90, 30, 20, 20))
	var_125_10:setContentSize(cc.size(500, var_125_10:getContentSize().height))
	var_125_10:setPosition(cc.p(var_125_2:getContentSize().width / 2, -80))
	var_125_11:setPosition(cc.p(var_125_10:getContentSize().width / 2, var_125_10:getContentSize().height / 2))
	var_125_10:addChild(var_125_11)
	var_125_2:addChild(var_125_10)
	var_125_10:addTouchEventListener(function(arg_126_0, arg_126_1)
		if arg_126_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_125_1.ShopSliderCallback then
			arg_125_1.ShopSliderCallback(arg_126_0, arg_126_1, function()
				var_125_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
					var_125_0:runAction(cc.RemoveSelf:create())
				end)))
			end)
		end
	end)
	var_125_1:setScaleY(0)
	var_125_1:runAction(cc.ScaleTo:create(0.2, 1))
	var_125_0:addTouchEventListener(function(arg_129_0, arg_129_1)
		if arg_129_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_125_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_125_0:runAction(cc.RemoveSelf:create())
		end)))
	end)
	self:initMiniHead(var_125_2, furnituresuit_data[furniture_data[arg_125_1.itemid].suit_id])
end

function ItemsPanel:showBachelorFurniturePop(arg_131_1)
	local var_131_0 = ccui.Layout:create()

	var_131_0:setTouchEnabled(true)
	var_131_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_131_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_131_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	var_131_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_131_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_131_0:setBackGroundColorOpacity(180)
	self:addChild(var_131_0, 10)

	local var_131_1 = ccui.ImageView:create("public/panelbg/bg_pop_small.png", var_0_37)

	var_131_1:setPosition(cc.p(var_131_0:getContentSize().width / 2, var_131_0:getContentSize().height / 2))
	var_131_1:setScaleY(0)
	var_131_1:setScaleY(0)
	var_131_1:setVisible(false)
	var_131_1:runAction(cc.ScaleTo:create(0.2, 1.2))
	var_131_0:addChild(var_131_1)

	local var_131_2 = ccui.ImageView:create("mainScenebg/market/" .. arg_131_1.itemid .. ".jpg")

	var_131_2:setPosition(cc.p(var_131_0:getContentSize().width / 2, var_131_0:getContentSize().height / 2))
	var_131_0:addChild(var_131_2)

	local var_131_3 = ccui.ImageView:create("itempanel/furniture_bg.png", var_0_37)

	var_131_3:setPosition(cc.p(var_131_2:getContentSize().width / 2, var_131_2:getContentSize().height / 2 - 18))
	var_131_2:addChild(var_131_3)

	local var_131_4 = string_split(var_0_2[arg_131_1.itemid].name, "】")

	if #var_131_4 == 2 then
		local var_131_5 = cc.Label:createWithTTF(var_131_4[2], FONT_DES, 26)

		var_131_5:setPosition(cc.p(470, 188))
		var_131_5:setColor(cc.c3b(187, 62, 198))
		var_131_3:addChild(var_131_5)

		local var_131_6 = cc.Label:createWithTTF(var_131_4[2], FONT_DES, 26)

		var_131_6:setPosition(cc.p(472, 188))
		var_131_6:setColor(cc.c3b(0, 168, 255))
		var_131_3:addChild(var_131_6)
	else
		local var_131_7 = cc.Label:createWithTTF(var_0_2[arg_131_1.itemid].name, FONT_DES, 26)

		var_131_7:setPosition(cc.p(470, 188))
		var_131_7:setColor(cc.c3b(187, 62, 198))
		var_131_3:addChild(var_131_7)

		local var_131_8 = cc.Label:createWithTTF(var_0_2[arg_131_1.itemid].name, FONT_DES, 26)

		var_131_8:setPosition(cc.p(472, 188))
		var_131_8:setColor(cc.c3b(0, 168, 255))
		var_131_3:addChild(var_131_8)
	end

	local var_131_9 = ccui.ImageView:create(arg_131_1.slidecost.costtype, var_0_37)

	var_131_9:setPositionX(var_131_3:getContentSize().width / 2 - 30)
	var_131_9:setPositionY(-130)
	var_131_3:addChild(var_131_9)

	local var_131_10 = cc.Label:createWithTTF(arg_131_1.slidecost.costnum, FONT_DES, 23)

	var_131_10:setAnchorPoint(cc.p(0, 0.5))
	var_131_10:setPositionX(var_131_9:getPositionX() + var_131_9:getContentSize().width / 2 + 5)
	var_131_10:setPositionY(var_131_9:getPositionY())
	var_131_3:addChild(var_131_10)

	local var_131_11
	local var_131_12

	if arg_131_1.limit_buy_num == 0 then
		var_131_11 = ccui.Button:create("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_37)
		var_131_12 = cc.Label:createWithTTF(L_MARKET_GOODS_LACK, FONT_BUTTON, 26)
	else
		var_131_11 = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_37)
		var_131_12 = cc.Label:createWithTTF(L_BUTTON_TEXT.Buy, FONT_BUTTON, 26)
	end

	var_131_12:setColor(cc.c3b(12, 12, 12))
	var_131_11:setPosition(cc.p(var_131_3:getContentSize().width / 2, -60))
	var_131_12:setPosition(cc.p(var_131_11:getContentSize().width / 2, var_131_11:getContentSize().height / 2 - 5))
	var_131_11:addChild(var_131_12)
	var_131_3:addChild(var_131_11)
	var_131_2:setScaleY(0)
	var_131_2:runAction(cc.ScaleTo:create(0.2, 1))
	var_131_0:addTouchEventListener(function(arg_132_0, arg_132_1)
		var_131_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_131_0:runAction(cc.RemoveSelf:create())
		end)))
		var_131_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_131_0:runAction(cc.RemoveSelf:create())
		end)))
	end)

	local var_131_13 = ccui.ImageView:create("public/panelbg/coupon_select_bg.png", var_0_37)

	var_131_13:setScale9Enabled(true)
	var_131_13:setCapInsets(cc.rect(0, 0, 10, 10))
	var_131_13:setContentSize(cc.size(570, 45 * (#arg_131_1.couponList + 1) + (#arg_131_1.couponList + 1 - 2) * 12))
	var_131_11:setPositionY(var_131_11:getPositionY() - var_131_13:getContentSize().height + 18)
	var_131_13:setAnchorPoint(cc.p(0.5, 0))
	var_131_13:setPosition(cc.p(282, var_131_11:getPositionY() + 30))
	var_131_3:addChild(var_131_13, 1)
	var_131_9:setPositionY(var_131_9:getPositionY() - var_131_13:getContentSize().height + 18)
	var_131_10:setPositionY(var_131_9:getPositionY())

	self.selectBtnList = {}

	local var_131_14

	for iter_131_0, iter_131_1 in pairs(arg_131_1.couponList) do
		local var_131_15 = ccui.ImageView:create("public/panelbg/coupon_sprite_bg.png", var_0_37)

		var_131_15:setPosition(cc.p(var_131_13:getContentSize().width / 2, var_131_13:getContentSize().height - 45 - (var_131_15:getContentSize().height + 12) * (iter_131_0 - 1)))
		var_131_13:addChild(var_131_15)

		local var_131_16 = ccui.ImageView:create("equipment/" .. iter_131_1.id .. ".png")

		var_131_16:setPosition(cc.p(40, 23))
		var_131_16:setScale(0.3)
		var_131_15:addChild(var_131_16)

		local var_131_17 = cc.Label:createWithTTF(iter_131_1.name .. " X" .. item_manager:getItemNumber(iter_131_1.id), FONT_NAME, 20)

		var_131_17:setColor(cc.c3b(188, 206, 226))
		var_131_17:setAnchorPoint(cc.p(0, 0.5))
		var_131_17:setPosition(cc.p(80, 23))
		var_131_15:addChild(var_131_17)

		local var_131_18 = ccui.ImageView:create(arg_131_1.slidecost.costtype, var_0_37)

		var_131_18:setPosition(cc.p(355, 23))
		var_131_15:addChild(var_131_18)

		local var_131_19 = "-" .. iter_131_1.discount1

		if iter_131_1.discount1 == -1 then
			var_131_19 = L_FREE_BUY

			var_131_18:setVisible(false)
		end

		local var_131_20 = cc.Label:createWithTTF(var_131_19, FONT_NAME, 24)

		var_131_20:setColor(cc.c3b(188, 206, 226))
		var_131_20:setPosition(cc.p(400, 23))
		var_131_15:addChild(var_131_20)

		local var_131_21 = ccui.Button:create("public/button/coupon_unselect.png", "public/button/coupon_unselect.png", "public/button/coupon_unselect.png", var_0_37)

		self.selectBtnList[iter_131_0] = var_131_21

		var_131_21:setPosition(cc.p(444, 22))
		var_131_15:addChild(var_131_21)
		var_131_21:addTouchEventListener(function(arg_135_0, arg_135_1)
			if arg_135_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:updateSelectBtn(iter_131_0)

			var_131_14 = iter_131_1.id

			var_131_10:setString((iter_131_1.discount1 == -1 or nil) and "0")
		end)
	end

	if arg_131_1.couponList[1] then
		self:updateSelectBtn(1)

		var_131_14 = arg_131_1.couponList[1].id

		var_131_10:setString((arg_131_1.couponList[1].discount1 == -1 or nil) and "0")
	end

	var_131_11:addTouchEventListener(function(arg_136_0, arg_136_1)
		if arg_136_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_131_1.ShopSliderCallback then
			arg_131_1.ShopSliderCallback(arg_136_0, arg_136_1, function()
				var_131_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
					var_131_0:runAction(cc.RemoveSelf:create())
				end)))
				var_131_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
					var_131_0:runAction(cc.RemoveSelf:create())
				end)))
			end, var_131_14)
		end
	end)
end

function ItemsPanel:showFurniturePopNew(arg_140_1)
	local var_140_0 = ccui.Layout:create()

	var_140_0:setTouchEnabled(true)
	var_140_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_140_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_140_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	var_140_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_140_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_140_0:setBackGroundColorOpacity(180)
	self:addChild(var_140_0, 10)

	local var_140_1 = ccui.Layout:create()

	var_140_1:setTouchEnabled(true)
	var_140_1:setContentSize(cc.size(640, 480))
	var_140_1:setAnchorPoint(0.5, 0.5)
	var_140_1:setPosition(320, var_140_0:getContentSize().height / 2)
	var_140_0:addChild(var_140_1)

	local var_140_2 = ccui.ImageView:create("public/panelbg/bg_pop_big.png", var_0_37)

	var_140_2:setPosition(cc.p(var_140_1:getContentSize().width / 2, var_140_1:getContentSize().height / 2 + 20))
	var_140_1:addChild(var_140_2)

	local var_140_3 = ccui.ImageView:create("mainScenebg/market/" .. arg_140_1.itemid .. ".jpg")

	var_140_3:setPosition(cc.p(var_140_1:getContentSize().width / 2, var_140_1:getContentSize().height / 2 + 80))
	var_140_1:addChild(var_140_3)

	local var_140_4 = ccui.ImageView:create("MarketLayer/furniture_bg.png", var_0_37)

	var_140_4:setPosition(cc.p(var_140_3:getContentSize().width / 2, var_140_3:getContentSize().height / 2))
	var_140_3:addChild(var_140_4)

	local var_140_5 = string_split(var_0_2[arg_140_1.itemid].name, "】")

	if #var_140_5 == 2 then
		local var_140_6 = cc.Label:createWithTTF(var_140_5[2], FONT_DES, 26)

		var_140_6:setPosition(cc.p(470, 188))
		var_140_6:setColor(cc.c3b(187, 62, 198))
		var_140_4:addChild(var_140_6)

		local var_140_7 = cc.Label:createWithTTF(var_140_5[2], FONT_DES, 26)

		var_140_7:setPosition(cc.p(472, 188))
		var_140_7:setColor(cc.c3b(0, 168, 255))
		var_140_4:addChild(var_140_7)
	else
		local var_140_8 = cc.Label:createWithTTF(var_0_2[arg_140_1.itemid].name, FONT_DES, 26)

		var_140_8:setPosition(cc.p(470, 188))
		var_140_8:setColor(cc.c3b(187, 62, 198))
		var_140_4:addChild(var_140_8)

		local var_140_9 = cc.Label:createWithTTF(var_0_2[arg_140_1.itemid].name, FONT_DES, 26)

		var_140_9:setPosition(cc.p(472, 188))
		var_140_9:setColor(cc.c3b(0, 168, 255))
		var_140_4:addChild(var_140_9)
	end

	local var_140_10 = arg_140_1.data
	local var_140_11 = ItemSmallSprite:createSmallItem("diamond", var_0_58[arg_140_1.data.currency](), arg_140_1.data.discount or var_140_10.cost_old)

	var_140_11:setPosition(230, 150)

	local var_140_12 = ccui.Button:create("public/button/coupon_select_small.png", "public/button/coupon_select_small.png", "public/button/coupon_unselect_small.png", var_0_37)

	var_140_12:setPosition(var_140_11:getContentSize().width / 2 + 60, var_140_11:getContentSize().height / 2 + 60)
	var_140_11:addChild(var_140_12, 5)
	var_140_12:setScale(1.8)
	var_140_11:setScale(0.6)
	var_140_1:addChild(var_140_11)

	local var_140_13 = ItemSmallSprite:createSmallItem(var_140_10.currency2, var_0_58[var_140_10.currency2](), var_140_10.discount2 or var_140_10.cost_old2)

	var_140_1:addChild(var_140_13)
	var_140_13:setPosition(410, 150)

	local var_140_14 = ccui.Button:create("public/button/coupon_select_small.png", "public/button/coupon_select_small.png", "public/button/coupon_unselect_small.png", var_0_37)

	var_140_14:setPosition(var_140_13:getContentSize().width / 2 + 60, var_140_13:getContentSize().height / 2 + 60)
	var_140_13:addChild(var_140_14, 5)
	var_140_13:setScale(0.6)
	var_140_14:setEnabled(false)
	var_140_14:setBright(false)
	var_140_14:setScale(1.8)
	var_140_11:setTouchEnabled(true)
	var_140_13:setTouchEnabled(true)

	local var_140_15 = var_140_10.currency
	local var_140_16 = var_140_10.discount or var_140_10.cost_old

	Utility:addClickEventListener(var_140_11, function()
		var_140_12:setEnabled(true)
		var_140_12:setBright(true)
		var_140_14:setEnabled(false)
		var_140_14:setBright(false)

		var_140_15 = var_140_10.currency
		var_140_16 = var_140_10.discount or var_140_10.cost_old
	end)
	Utility:addClickEventListener(var_140_13, function()
		var_140_12:setEnabled(false)
		var_140_12:setBright(false)
		var_140_14:setEnabled(true)
		var_140_14:setBright(true)

		var_140_15 = var_140_10.currency2
		var_140_16 = var_140_10.discount2 or var_140_10.cost_old2
	end)

	local var_140_17
	local var_140_18

	if arg_140_1.limit_buy_num == 0 then
		var_140_17 = ccui.Button:create("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_37)
		var_140_18 = cc.Label:createWithTTF(L_MARKET_GOODS_LACK, FONT_BUTTON, 26)
	else
		var_140_17 = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_37)
		var_140_18 = cc.Label:createWithTTF(L_BUTTON_TEXT.Buy, FONT_BUTTON, 26)
	end

	var_140_18:setColor(cc.c3b(12, 12, 12))
	var_140_17:setPosition(cc.p(320, 20))
	var_140_18:setPosition(cc.p(var_140_17:getContentSize().width / 2, var_140_17:getContentSize().height / 2 - 5))
	var_140_17:addChild(var_140_18)
	var_140_1:addChild(var_140_17)
	var_140_17:addTouchEventListener(function(arg_143_0, arg_143_1)
		if arg_143_1 ~= ccui.TouchEventType.ended then
			return
		end

		local function var_143_0()
			var_140_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
				var_140_0:runAction(cc.RemoveSelf:create())
			end)))
		end

		if var_0_58[var_140_15]() < var_140_16 then
			if var_140_15 == var_0_52 then
				self.dumpPopLayerFunc(var_140_15)
			else
				local var_143_1 = var_140_16 - var_0_58[var_140_15]()
				local var_143_2 = {
					shopId = 110076,
					cost = 80,
					shopType = 1
				}

				LayerManager:pushInLayer("PopDoLayer", {
					costtype = "diamond",
					surecallback = function()
						shop_manager:purchase_shop_currency(var_140_15, var_143_1, function()
							if arg_140_1.ShopSliderCallback then
								arg_140_1.ShopSliderCallback(arg_143_0, arg_143_1, var_143_0, nil, var_140_15)
							end
						end, true)
					end,
					own = playermodel.diamond,
					cost = var_143_1 * var_143_2.cost,
					labels = {
						title = "家具兑换券不足",
						des = string.format("消耗%d魂晶补足%d张家具兑换券", var_143_1 * var_143_2.cost, var_143_1)
					}
				})
			end

			return
		end

		if arg_140_1.ShopSliderCallback then
			arg_140_1.ShopSliderCallback(arg_143_0, arg_143_1, var_143_0, nil, var_140_15)
		end
	end)
	var_140_1:setScaleY(0)
	var_140_1:runAction(cc.ScaleTo:create(0.2, 1, 1))
	var_140_0:addTouchEventListener(function(arg_148_0, arg_148_1)
		var_140_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_140_0:runAction(cc.RemoveSelf:create())
		end)))
	end)
	self:initMiniHead(var_140_4, furnituresuit_data[var_0_2[arg_140_1.itemid].suit_id], cc.p(60, 150))
end

function ItemsPanel:updateSelectBtn(arg_150_1)
	for iter_150_0, iter_150_1 in pairs(self.selectBtnList) do
		if iter_150_0 == arg_150_1 then
			iter_150_1:loadTextures("public/button/coupon_select.png", "public/button/coupon_select.png", "public/button/coupon_select.png", var_0_37)
		else
			iter_150_1:loadTextures("public/button/coupon_unselect.png", "public/button/coupon_unselect.png", "public/button/coupon_unselect.png", var_0_37)
		end
	end
end

function ItemsPanel:createItemDataPanel(arg_151_1, arg_151_2)
	local var_151_0 = L_EQUIPLAYER .. "0"
	local var_151_1 = L_ATTR_HIDE
	local var_151_2 = "unkonwn"
	local var_151_3 = L_DES_HIDE
	local var_151_4 = ""
	local var_151_5 = ""

	if self.panelType == ITEMPANEL_TYPE_ROLE_COMPONENT then
		local var_151_6 = component_manager:getComponentAttrsInfo(arg_151_2)

		var_151_0 = L_EQUIPLAYER[6] .. var_151_6.extra
		var_151_2 = L_COMPONENT_TEXT.Component_Score .. component_manager:getPotential(arg_151_2)

		local var_151_7 = ""

		for iter_151_0, iter_151_1 in ipairs(var_151_6.sub_attr) do
			if iter_151_0 > 1 then
				var_151_7 = var_151_7 .. "\n"
			end

			var_151_7 = var_151_7 .. iter_151_1
		end

		mainAttrDes = var_151_6.main_attr
		var_151_1 = var_151_7
		var_151_3 = var_151_6.suit
		var_151_3 = string.gsub(var_151_6.suit, L_COMPONENT_TEXT.Suit_Effect, L_COMPONENT_TEXT.Suit_Effect .. "\n")

		local var_151_8 = component_manager:getComponentAttrsInfo(arg_151_2, self.servantid)
		local var_151_9 = ""

		for iter_151_2, iter_151_3 in ipairs(var_151_8.sub_attr) do
			if iter_151_2 > 1 then
				var_151_9 = var_151_9 .. "\n"
			end

			var_151_9 = var_151_9 .. iter_151_3
		end

		var_151_4 = var_151_8.main_attr
		var_151_5 = var_151_9
	else
		local var_151_10 = weapon_manager:getWeaponConfig(playermodel.items[arg_151_2])

		var_151_0 = L_EQUIPLAYER[6] .. playermodel.items[arg_151_2].weapon_attr.level
		mainAttrDes = FIGHT_ATTR_INFO[var_151_10.main_attr.attrtype] .. "+" .. FIGHT_ATTR_FORMAT(var_151_10.main_attr.attrtype, var_151_10.main_attr.value)
		var_151_1 = FIGHT_ATTR_INFO[var_151_10.sub_attr.attrtype] .. "+" .. FIGHT_ATTR_FORMAT(var_151_10.sub_attr.attrtype, var_151_10.sub_attr.value)
		var_151_3 = var_0_2[playermodel.items[arg_151_2].itemid].intro
	end

	local var_151_11 = ItemSprite:createBigWithEntityId(arg_151_2)

	var_151_11:setAnchorPoint(cc.p(0.5, 0.5))
	var_151_11:setPosition(cc.p(120, 255))
	var_151_11:setName("ItemIcon")
	var_151_11:setScale(0.8)
	arg_151_1:addChild(var_151_11)

	if var_151_11:getChildByName("lock") then
		var_151_11:getChildByName("lock"):setTouchEnabled(false)
	end

	local var_151_12 = cc.Label:createWithTTF("", FONT_DES, 20)

	var_151_12:setAnchorPoint(cc.p(0, 1))
	var_151_12:setName("mainAttrLabel")
	var_151_12:setString(mainAttrDes)
	var_151_12:setLineBreakWithoutSpace(true)
	var_151_12:setMaxLineWidth(140)
	arg_151_1:addChild(var_151_12)

	local var_151_13 = cc.Label:createWithTTF("", FONT_DES, 20)

	var_151_13:setAnchorPoint(cc.p(0, 1))
	var_151_13:setName("lvLabel")
	var_151_13:setColor(cc.c3b(255, 168, 0))
	var_151_13:setString(var_151_0)
	arg_151_1:addChild(var_151_13)

	local var_151_14 = cc.Label:createWithTTF("", FONT_DES, 20)

	var_151_14:setAnchorPoint(cc.p(0, 1))
	var_151_14:setPosition(cc.p(200, 300))
	var_151_14:setMaxLineWidth(150)
	var_151_14:setName("attributeLabel")
	var_151_14:setString(var_151_1)
	arg_151_1:addChild(var_151_14)

	local var_151_15 = cc.Label:createWithTTF("", FONT_DES, 20)

	var_151_15:setAnchorPoint(cc.p(0, 1))
	var_151_15:setPosition(cc.p(60, 150))
	var_151_15:setMaxLineWidth(260)
	var_151_15:setName("otherDesLabel")
	var_151_15:setString(var_151_3)
	arg_151_1:addChild(var_151_15)

	local var_151_16 = {
		lvLabel = cc.p(200, 350),
		weaponMainAttrLabel = cc.p(200, 330),
		weaponAttributeLabel = cc.p(200, 310),
		componentLabel = cc.p(200, 330),
		componentMainAttrDesLabel = cc.p(200, 310),
		componentSubAttrDesLabel = cc.p(200, 290),
		componentLimitLabel = cc.p(200, 260),
		componentLimitMainAttrDesLabel = cc.p(200, 240),
		componentLimitSubAttrDesLabel = cc.p(200, 220),
		componentScoreLabel = cc.p(200, 200)
	}

	var_151_13:setPosition(var_151_16.lvLabel)

	local function var_151_17()
		local var_152_0 = cc.Label:createWithTTF(L_ATTR_TOTAL, FONT_DES, 20)

		var_152_0:setAnchorPoint(cc.p(0, 1))
		var_152_0:setPosition(var_151_16.componentLabel)
		var_152_0:setMaxLineWidth(150)
		var_152_0:setColor(cc.c3b(255, 168, 0))
		var_152_0:setName("mainTitleLabel")
		arg_151_1:addChild(var_152_0)

		local var_152_1 = cc.Label:createWithTTF(L_ATTR_EFFECT, FONT_DES, 20)

		var_152_1:setAnchorPoint(cc.p(0, 1))
		var_152_1:setPosition(var_151_16.componentLimitLabel)
		var_152_1:setMaxLineWidth(150)
		var_152_1:setColor(cc.c3b(255, 168, 0))
		var_152_1:setName("limitTitleLabel")
		arg_151_1:addChild(var_152_1)

		local var_152_2 = cc.Label:createWithTTF(var_151_4, FONT_DES, 20)

		var_152_2:setAnchorPoint(cc.p(0, 1))
		var_152_2:setPosition(var_151_16.componentLimitMainAttrDesLabel)
		var_152_2:setMaxLineWidth(150)
		var_152_2:setName("limitMainAttrDesLabel")
		arg_151_1:addChild(var_152_2)

		local var_152_3 = cc.Label:createWithTTF(var_151_5, FONT_DES, 20)

		var_152_3:setAnchorPoint(cc.p(0, 1))
		var_152_3:setPosition(var_151_16.componentLimitSubAttrDesLabel)
		var_152_3:setMaxLineWidth(150)
		var_152_3:setName("limitSubAttrDesLabel")
		arg_151_1:addChild(var_152_3)

		local var_152_4 = ccui.Layout:create()

		var_152_4:setTouchEnabled(true)
		var_152_4:setContentSize(cc.size(150, 2))
		var_152_4:setAnchorPoint(cc.p(0, 1))
		var_152_4:setPosition(cc.p(200, var_151_16.componentLimitLabel.y + 5))
		var_152_4:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_152_4:setBackGroundColor(cc.c3b(113, 119, 134))
		var_152_4:setBackGroundColorOpacity(255)
		var_152_4:setName("line")
		arg_151_1:addChild(var_152_4)
	end

	if self.panelType == ITEMPANEL_TYPE_ROLE_COMPONENT then
		var_151_12:setPosition(var_151_16.componentMainAttrDesLabel)
		var_151_14:setPosition(var_151_16.componentSubAttrDesLabel)

		local var_151_18 = cc.Label:createWithTTF("", FONT_DES, 18)

		var_151_18:setAnchorPoint(cc.p(0, 1))
		var_151_18:setPosition(var_151_16.componentScoreLabel)
		var_151_18:setMaxLineWidth(150)
		var_151_18:setName("scoreLabel")
		var_151_18:setString(var_151_2 .. "(" .. (component_manager:getMaxLevel(playermodel.items[arg_151_2].itemid) + 1) * 20 .. ")")
		var_151_18:setColor(cc.c3b(255, 168, 0))
		arg_151_1:addChild(var_151_18)

		if COMPONENT_SERVANT_LIMIT[var_0_6[playermodel.items[arg_151_2].itemid].equip_quality] and core_manager:getServantCoreRank(servantid) < COMPONENT_SERVANT_LIMIT[var_0_6[playermodel.items[arg_151_2].itemid].equip_quality] or playermodel.items[arg_151_2].component_attr.extra < var_0_6[playermodel.items[arg_151_2].itemid].equip_quality * 5 then
			var_151_17()
		end
	end

	if self.panelType == ITEMPANEL_TYPE_ROLE_WEAPON then
		var_151_12:setPosition(var_151_16.weaponMainAttrLabel)
		var_151_14:setPosition(var_151_16.weaponAttributeLabel)
	elseif self.panelType == ITEMPANEL_TYPE_ROLE_COMPONENT and mainAttrDes == var_151_4 then
		if not arg_151_1:getChildByName("limitTitleLabel") then
			var_151_17()
		end

		arg_151_1:getChildByName("limitTitleLabel"):setVisible(false)
		arg_151_1:getChildByName("limitMainAttrDesLabel"):setVisible(false)
		arg_151_1:getChildByName("limitSubAttrDesLabel"):setVisible(false)
		arg_151_1:getChildByName("line"):setVisible(false)
	end
end

function ItemsPanel:createPanelofCompareItems()
	self.itemEquiped:setVisible(true)
	self.itemChoosed:setVisible(true)

	if self.panelType == ITEMPANEL_TYPE_ROLE_COMPONENT then
		if self.equipedEntityid == -1 then
			self.itemEquiped:loadTexture(var_0_49, var_0_37)
		else
			self:createItemDataPanel(self.itemEquiped, self.equipedEntityid)
		end
	elseif self.panelType == ITEMPANEL_TYPE_ROLE_WEAPON then
		if self.equipedEntityid == -1 then
			self.itemEquiped:loadTexture(var_0_49, var_0_37)
		else
			self:createItemDataPanel(self.itemEquiped, self.equipedEntityid)
		end
	end
end

function ItemsPanel:getShowStat()
	if not self.lastSelectedEntityid or self.lastSelectedEntityid == -1 then
		return 0
	else
		return 1
	end
end

function ItemsPanel:updatePanelofCompareItems(arg_155_1)
	self.lastSelectedEntityid = arg_155_1

	GuideListener.cleanCurGuides()
	GuideListener.swallowEvent(false)
	GuideListener.lockGuideTrigger(false)
	GuideListener.updateGuides(self)

	local var_155_0 = ""

	if self.choosedTag == true then
		local var_155_2, var_155_3, var_155_5, var_155_6, var_155_9

		if self.panelType == ITEMPANEL_TYPE_ROLE_COMPONENT then
			local var_155_1 = component_manager:getComponentAttrsInfo(arg_155_1)

			var_155_2 = L_EQUIPLAYER[6] .. var_155_1.extra
			var_155_3 = L_COMPONENT_TEXT.Component_Score .. component_manager:getPotential(arg_155_1)

			local var_155_4 = ""

			for iter_155_0, iter_155_1 in ipairs(var_155_1.sub_attr) do
				if iter_155_0 > 1 then
					var_155_4 = var_155_4 .. "\n"
				end

				var_155_4 = var_155_4 .. iter_155_1
			end

			mainAttrDes = var_155_1.main_attr
			var_155_5 = var_155_4
			var_155_6 = var_155_1.suit
			var_155_6 = string.gsub(var_155_1.suit, L_COMPONENT_TEXT.Suit_Effect, L_COMPONENT_TEXT.Suit_Effect .. "\n")

			local var_155_7 = component_manager:getComponentAttrsInfo(arg_155_1, self.servantid)
			local var_155_8 = ""

			for iter_155_2, iter_155_3 in ipairs(var_155_7.sub_attr) do
				if iter_155_2 > 1 then
					var_155_8 = var_155_8 .. "\n"
				end

				var_155_8 = var_155_8 .. iter_155_3
			end

			var_155_0 = var_155_7.main_attr
			var_155_9 = var_155_8
		else
			local var_155_10 = weapon_manager:getWeaponConfig(playermodel.items[arg_155_1])

			var_155_2 = L_EQUIPLAYER[6] .. playermodel.items[arg_155_1].weapon_attr.level
			mainAttrDes = FIGHT_ATTR_INFO[var_155_10.main_attr.attrtype] .. "+" .. FIGHT_ATTR_FORMAT(var_155_10.main_attr.attrtype, var_155_10.main_attr.value)
			var_155_5 = FIGHT_ATTR_INFO[var_155_10.sub_attr.attrtype] .. "+" .. FIGHT_ATTR_FORMAT(var_155_10.sub_attr.attrtype, var_155_10.sub_attr.value)
			var_155_6 = var_0_2[playermodel.items[arg_155_1].itemid].intro
		end

		self.itemChoosed:getChildByName("ItemIcon"):updateBigInfo(false, arg_155_1)
		self.itemChoosed:getChildByName("lvLabel"):setString(L_EQUIPLAYER .. "0")
		self.itemChoosed:getChildByName("mainAttrLabel"):setString(mainAttrDes)
		self.itemChoosed:getChildByName("attributeLabel"):setString(L_ATTR_HIDE)

		if self.panelType == ITEMPANEL_TYPE_ROLE_COMPONENT then
			self.itemChoosed:getChildByName("scoreLabel"):setString("unkonwn" .. "(" .. (component_manager:getMaxLevel(playermodel.items[arg_155_1].itemid) + 1) * 20 .. ")")

			if COMPONENT_SERVANT_LIMIT[var_0_6[playermodel.items[arg_155_1].itemid].equip_quality] and core_manager:getServantCoreRank(servantid) < COMPONENT_SERVANT_LIMIT[var_0_6[playermodel.items[arg_155_1].itemid].equip_quality] or playermodel.items[arg_155_1].component_attr.extra < var_0_6[playermodel.items[arg_155_1].itemid].equip_quality * 5 then
				self.itemChoosed:getChildByName("limitMainAttrDesLabel"):setString(var_155_0)
				self.itemChoosed:getChildByName("limitSubAttrDesLabel"):setString("")
			end

			if mainAttrDes == var_155_0 then
				self.itemChoosed:getChildByName("limitTitleLabel"):setVisible(false)
				self.itemChoosed:getChildByName("limitMainAttrDesLabel"):setVisible(false)
				self.itemChoosed:getChildByName("limitSubAttrDesLabel"):setVisible(false)
				self.itemChoosed:getChildByName("line"):setVisible(false)
			else
				self.itemChoosed:getChildByName("limitTitleLabel"):setVisible(true)
				self.itemChoosed:getChildByName("limitMainAttrDesLabel"):setVisible(true)
				self.itemChoosed:getChildByName("limitSubAttrDesLabel"):setVisible(true)
				self.itemChoosed:getChildByName("line"):setVisible(true)
			end
		end

		self.itemChoosed:getChildByName("otherDesLabel"):setString(L_DES_HIDE)
	else
		self.itemChoosed:loadTexture(var_0_48, var_0_37)
		self:createItemDataPanel(self.itemChoosed, arg_155_1)
	end
end

function ItemsPanel.setLackMaterialTag(arg_156_0, arg_156_1)
	local var_156_0 = ccui.Layout:create()

	var_156_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_156_0:setBackGroundColor(cc.c3b(15, 15, 15))
	var_156_0:setContentSize(arg_156_1:getContentSize())
	var_156_0:setCascadeOpacityEnabled(true)
	var_156_0:setBackGroundColorOpacity(100)
	var_156_0:setScale(1)
	var_156_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_156_0:setPosition(cc.p(arg_156_1:getContentSize().width / 2, arg_156_1:getContentSize().height / 2))
	arg_156_1:addChild(var_156_0, 9)
end

function ItemsPanel:createItem(arg_157_1)
	local var_157_1 = playermodel.items[arg_157_1]
	local var_157_2 = playermodel.items[arg_157_1] and "entityid" or "itemid"
	local var_157_3

	if playermodel.items[arg_157_1] then
		var_157_3 = var_0_2[var_157_1.itemid] or var_0_2[arg_157_1]
	end

	local var_157_4 = ccui.Button:create("public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", var_0_37)

	var_157_4:setScale(0.8)
	var_157_4:setSwallowTouches(false)

	local var_157_5 = var_157_3.bag_item_type == kITEM_FURNITURE and var_0_69(arg_157_1) or nil
	local var_157_6

	if var_157_2 == "entityid" then
		var_157_6 = self.panelType == ITEMPANEL_TYPE_MEDAL and ItemSprite:createBigWithEntityId(arg_157_1, var_157_5, self.servantid, true) or ItemSprite:createBigWithEntityId(arg_157_1, var_157_5, self.servantid)
	elseif var_157_2 == "itemid" then
		var_157_6 = ItemSprite:createNewWithItemId(arg_157_1)
	end

	var_157_6:setName("icon")
	var_157_6:setPosition(var_157_4:getContentSize().width / 2, var_157_4:getContentSize().height / 2)
	var_157_4:addChild(var_157_6)

	if var_157_6:getChildByName("lock") then
		var_157_6:getChildByName("lock"):setTouchEnabled(false)
		var_157_6:getChildByName("lock"):setVisible(false)
	end

	local var_157_7 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_37)

	var_157_7:setPositionX(var_157_4:getContentSize().width - 10)
	var_157_7:setPositionY(var_157_4:getContentSize().height - 10)
	var_157_7:setName("redDot")
	var_157_7:setVisible(self:isShowRedDot(arg_157_1))
	var_157_4:addChild(var_157_7, 100)

	if self.itemType == kITEM_COMPONENT and self.goto_back_system_id == 301 then
		local var_157_8, var_157_9 = component_manager:isRecommendComponent(self.servantid, arg_157_1)
		local var_157_10 = var_157_4:getChildByName("imgRecommend")

		if not var_157_10 and var_157_8 then
			var_157_10 = ccui.ImageView:create("itempanel/bg_recommend.png", var_0_37)

			local var_157_11 = ccui.ImageView:create(string.format("itempanel/recommend_%d.png", var_157_9), var_0_37)

			var_157_11:setPosition(var_157_10:getContentSize().width / 2 + 5, var_157_10:getContentSize().height / 2)
			var_157_10:addChild(var_157_11)
			var_157_10:setPosition(var_157_4:getContentSize().width / 2 + 35, var_157_4:getContentSize().height / 2 + 95)
			var_157_10:setName("imgRecommend")
			var_157_4:addChild(var_157_10, 99)
		end

		if var_157_10 then
			var_157_10:setVisible(var_157_8)
		end
	end

	if var_157_3.bag_item_type == kITEM_COMPONENT then
		if self.panelType == ITEMPANEL_TYPE_ROLE_COMPONENT then
			if var_157_1.component_attr.use then
				var_157_4.used = true
			end
		elseif self.panelType == ITEMPANEL_TYPE_SMELT_COMPONENT then
			local var_157_12 = 0

			for iter_157_0, iter_157_1 in pairs(self.usedItems.components) do
				if arg_157_1 == iter_157_1.entityid then
					var_157_12 = iter_157_1.pos == self.usedItems.pos and 1 or 2
				end
			end

			if var_157_12 > 0 then
				var_157_4.used = var_157_12
			end
		end
	elseif var_157_3.bag_item_type == kITEM_WEAPON then
		if var_157_1.weapon_attr.use then
			var_157_4.used = true
		end

		if var_157_1.weapon_attr.lock and self.panelType == ITEMPANEL_TYPE_UPGRADE_WEAPON then
			var_157_6:getChildByName("lock"):addTouchEventListener(function(arg_158_0, arg_158_1)
				if arg_158_1 ~= ccui.TouchEventType.ended then
					return
				end

				weapon_manager:lockWeapon(arg_157_1, function(arg_159_0)
					if arg_159_0 then
						print("unlock fail")
					else
						var_157_6:getChildByName("lock"):runAction(cc.RemoveSelf:create())
						global_ShowBlockWords(L_SELECT_EQUIP_MSG.Weapon_Unlock)
					end
				end)
			end)
		end
	elseif var_157_3.bag_item_type == kITEM_WEAPON_EXP or var_157_3.bag_item_type == kITEM_FOOD then
		var_157_4.usedNum = self.usedItems[arg_157_1] or 0

		local var_157_13

		if config._DEBUG then
			var_157_13 = cc.Sprite:create("public/box/new_item_bg_on.png") or cc.Sprite:createWithSpriteFrameName("public/box/new_item_bg_on.png")
		end

		var_157_13:setAnchorPoint(cc.p(0.5, 0.5))
		var_157_13:setPosition(cc.p(var_157_6:getContentSize().width / 2, var_157_6:getContentSize().height / 2))
		var_157_13:setName("selectedBg")
		var_157_13:setVisible(false)
		var_157_4:addChild(var_157_13)

		local var_157_14 = ccui.Button:create("public/box/new_item_bg_cancle.png", "public/box/new_item_bg_cancle.png", "public/box/new_item_bg_cancle.png", var_0_37)

		var_157_14:setPosition(10, var_157_6:getContentSize().height - 10)
		var_157_14:addTouchEventListener(function(arg_160_0, arg_160_1)
			if arg_160_1 ~= ccui.TouchEventType.ended then
				return
			end

			if var_157_4.usedNum <= 0 then
				return
			end

			var_157_4.usedNum = var_157_4.usedNum - 1
			self.usedItems[arg_157_1] = var_157_4.usedNum

			if var_157_4.usedNum <= 0 then
				var_157_4.usedNum = 0
				self.usedItems[arg_157_1] = var_157_4.usedNum

				var_157_4:getChildByName("selectedBg"):setVisible(false)
			else
				var_157_4:getChildByName("selectedBg"):getChildByName("label_num"):setString(var_157_4.usedNum)
			end

			self:itemChangeUpdate(arg_160_0)
		end)
		var_157_13:addChild(var_157_14)

		local var_157_15 = cc.Label:createWithTTF(var_157_4.usedNum, "fonts/newkj.ttf", 20)

		var_157_15:setPosition(160, 222)
		var_157_15:setColor(cc.c3b(73, 58, 68))
		var_157_15:setName("label_num")
		var_157_13:addChild(var_157_15)

		if self.usedItems[arg_157_1] and self.usedItems[arg_157_1] > 0 then
			var_157_4:getChildByName("selectedBg"):setVisible(true)
		end
	elseif var_157_3.bag_item_type == kITEM_MEDAL then
		for iter_157_2, iter_157_3 in pairs(playermodel.cur_medal) do
			if iter_157_3 == arg_157_1 then
				local var_157_16

				if config._DEBUG then
					var_157_16 = cc.Sprite:create("public/box/used_on.png") or cc.Sprite:createWithSpriteFrameName("public/box/used_on.png")
				end

				var_157_16:setAnchorPoint(cc.p(0.5, 0.5))
				var_157_16:setPosition(cc.p(var_157_6:getContentSize().width / 2, var_157_6:getContentSize().height * 2 / 5))

				local var_157_17 = cc.Label:createWithTTF(L_COMMON_WARNING.Using, "fonts/newkj.ttf", 22)

				var_157_17:setColor(cc.c3b(255, 100, 0))
				var_157_17:setPosition(var_157_16:getContentSize().width / 2, var_157_16:getContentSize().height / 2)
				var_157_16:addChild(var_157_17)
				var_157_6:addChild(var_157_16)

				var_157_4.used = true

				break
			end
		end
	elseif var_157_3.bag_item_type == kITEM_FURNITURE then
		local var_157_18 = {}

		for iter_157_4, iter_157_5 in pairs(self.usedItems) do
			if iter_157_5 > 0 then
				var_157_18[iter_157_5] = iter_157_4
			end
		end

		if var_157_18[arg_157_1] then
			self.lastUsedItems[var_157_18[arg_157_1]] = var_157_4

			local var_157_19

			if config._DEBUG then
				var_157_19 = cc.Sprite:create("public/box/used_on.png") or cc.Sprite:createWithSpriteFrameName("public/box/used_on.png")
			end

			var_157_19:setAnchorPoint(cc.p(0.5, 0.5))
			var_157_19:setPosition(cc.p(var_157_6:getContentSize().width / 2, var_157_6:getContentSize().height * 2 / 5))
			var_157_19:setName("uesdTag")

			local var_157_20 = cc.Label:createWithTTF(L_COMMON_WARNING.Using, "fonts/newkj.ttf", 22)

			var_157_20:setColor(cc.c3b(255, 100, 0))
			var_157_20:setPosition(var_157_19:getContentSize().width / 2, var_157_19:getContentSize().height / 2)
			var_157_19:addChild(var_157_20)
			var_157_6:addChild(var_157_19)

			var_157_4.used = true
			var_157_4.usedImg = var_157_19
		end
	end

	return var_157_4
end

function ItemsPanel:isShowRedDot(arg_161_1)
	if self.panelType == ITEMPANEL_TYPE_ROLE_COMPONENT then
		local var_161_0 = self.initParamComponentScore or 0

		if playermodel.items[arg_161_1].component_attr.use then
			return false
		end

		if var_161_0 < component_manager:getScore(arg_161_1) and (not self.componentEffectid or self.componentEffectid == playermodel.items[arg_161_1].component_attr.effect) then
			local var_161_2 = var_0_2[playermodel.items[arg_161_1].itemid].pos

			if self.componentEffectid and playermodel.component[self.servantid] and playermodel.component[self.servantid][var_161_2] then
				local var_161_3 = playermodel.component[self.servantid][var_161_2] and playermodel.component[self.servantid][var_161_2].id

				if var_161_3 and var_0_6[playermodel.items[arg_161_1].itemid].main_attr ~= var_0_6[playermodel.items[var_161_3].itemid].main_attr then
					return false
				end
			end

			if self.highestQuality then
				if var_0_2[playermodel.items[arg_161_1].itemid].equip_quality == self.highestQuality then
					return true
				end
			else
				return true
			end
		end
	end

	if self.panelType == ITEMPANEL_TYPE_ROLE_WEAPON then
		if playermodel.items[arg_161_1] then
			if ((playermodel.items[playermodel.weaponId[self.servantid]] or nil) and (var_0_2[playermodel.items[playermodel.weaponId[self.servantid]].itemid].equip_quality or 0)) < (var_0_2[playermodel.items[arg_161_1].itemid].equip_quality or 0) and not playermodel.items[arg_161_1].weapon_attr.use then
				if self.highestQuality then
					if var_0_2[playermodel.items[arg_161_1].itemid].equip_quality == self.highestQuality then
						return true
					end
				else
					return true
				end
			end
		end
	end

	return false
end

function ItemsPanel:getHighestQuality()
	local var_162_0

	if self.panelType == ITEMPANEL_TYPE_MEDAL then
		for iter_162_0, iter_162_1 in pairs(self.itemList) do
			if not false then
				var_162_0 = math.max(var_162_0 or 1, var_0_2[iter_162_1].equip_quality)
			end
		end
	else
		for iter_162_2, iter_162_3 in pairs(self.itemList) do
			local var_162_1 = false

			if playermodel.items[iter_162_3].itemtype == kITEM_COMPONENT then
				if playermodel.items[iter_162_3].component_attr.use then
					var_162_1 = true
				end
			elseif playermodel.items[iter_162_3].itemtype == kITEM_WEAPON and playermodel.items[iter_162_3].weapon_attr.use then
				var_162_1 = true
			end

			if not var_162_1 then
				var_162_0 = math.max(var_162_0 or 1, var_0_2[playermodel.items[iter_162_3].itemid].equip_quality)
			end
		end
	end

	return var_162_0
end

function ItemsPanel.createItemHightLight(arg_163_0, arg_163_1)
	if arg_163_1.selected then
		return
	end

	local var_163_2 = ccui.Layout:create()
	local var_163_3

	if config._DEBUG then
		var_163_3 = cc.Sprite:create("public/box/new_item_bg_on1.png") or cc.Sprite:createWithSpriteFrameName("public/box/new_item_bg_on1.png")
	end

	var_163_3:setPosition(arg_163_1:getContentSize().width / 2, arg_163_1:getContentSize().height / 2)
	var_163_2:addChild(var_163_3)

	local var_163_4 = {}

	for iter_163_0 = 1, 2 do
		if iter_163_0 == 1 then
			if config._DEBUG then
				var_163_4[iter_163_0] = cc.Sprite:create("public/box/new_item_bg_on2.png") or cc.Sprite:createWithSpriteFrameName("public/box/new_item_bg_on2.png")
			end

			var_163_4[iter_163_0]:setScale(1.1)
			var_163_4[iter_163_0]:setOpacity(0)
			var_163_4[iter_163_0]:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)))))
		else
			if config._DEBUG then
				var_163_4[iter_163_0] = cc.Sprite:create("public/box/new_item_bg_on2.png") or cc.Sprite:createWithSpriteFrameName("public/box/new_item_bg_on2.png")
			end

			var_163_4[iter_163_0]:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)))))
		end

		var_163_4[iter_163_0]:setPosition(arg_163_1:getContentSize().width / 2, arg_163_1:getContentSize().height / 2)
		var_163_2:addChild(var_163_4[iter_163_0])
	end

	var_163_2:setName("heightLight")
	arg_163_1:addChild(var_163_2)

	arg_163_1.selected = var_163_2
end

function ItemsPanel:itemChangeUpdate(arg_164_1)
	if not arg_164_1 then
		return
	end

	local var_164_0 = arg_164_1.entityid

	if self.panelType == ITEMPANEL_TYPE_ROLE_COMPONENT then
		if not self.lastSelected and self.equipedEntityid ~= -1 or self.lastSelected and self.lastSelected.selected == nil and self.equipedEntityid ~= -1 then
			self.bottomBnt1:setVisible(false)
			self.bottomBnt1:setTouchEnabled(false)
			self.bottomBnt2:setVisible(true)
			self.bottomBnt2:setTouchEnabled(true)
			self.bottomBnt2:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Unload)
			self.bottomBnt2:addTouchEventListener(function(arg_165_0, arg_165_1)
				if arg_165_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_165_0:isBright() then
					return
				end

				if self.equipedEntityid == -1 then
					audio_manager:playeffectMusicTest("sound/invalid")
					global_ShowBlockWords(L_COMPONENT_TEXT.No_equip)

					return
				end

				if self.usedcallback then
					arg_165_0:setBright(false)
					self.usedcallback(self.equipedEntityid)
				end
			end)
		elseif self.lastSelected and self.lastSelected.selected ~= nil then
			if not arg_164_1 then
				return
			end

			self.bottomBnt1:setVisible(true)
			self.bottomBnt1:setTouchEnabled(true)
			self.bottomBnt2:setVisible(true)
			self.bottomBnt2:setTouchEnabled(true)

			if self.lastSelected.entityid == self.equipedEntityid then
				self.bottomBnt2:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Unload)
			elseif self.equipedEntityid ~= -1 then
				self.bottomBnt2:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Switch)
			else
				self.bottomBnt2:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Equip)
			end

			self.bottomBnt2:addTouchEventListener(function(arg_166_0, arg_166_1)
				if arg_166_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_166_0:isBright() then
					return
				end

				if self.lastSelected.entityid == self.equipedEntityid then
					if self.usedcallback then
						arg_166_0:setBright(false)
						self.usedcallback(function()
							arg_166_0:setBright(true)
						end)
					end
				elseif arg_164_1.used then
					LayerManager:pushInLayer("PopDoLayer", {
						labels = {
							titleNewImage = "public/panelbg/title_item.png",
							title = L_COMPONENT_CHANGE.title,
							des = L_COMPONENT_CHANGE.des,
							button = L_COMPONENT_CHANGE.button
						},
						surecallback = function()
							if self.unusedcallback then
								arg_166_0:setBright(false)
								self.unusedcallback(var_164_0, function()
									arg_166_0:setBright(true)
								end)
							end
						end
					})
				elseif self.unusedcallback then
					arg_166_0:setBright(false)
					self.unusedcallback(var_164_0, function()
						arg_166_0:setBright(true)
					end)
				end
			end)
		else
			self.bottomBnt1:setVisible(false)
			self.bottomBnt1:setTouchEnabled(false)
			self.bottomBnt2:setVisible(false)
			self.bottomBnt2:setTouchEnabled(false)
		end

		if arg_164_1 then
			local var_164_1 = arg_164_1.entityid or -1

			if var_164_1 == -1 then
				return
			end
		end

		self.bottomBnt1:addTouchEventListener(function(arg_171_0, arg_171_1)
			if arg_171_1 ~= ccui.TouchEventType.ended then
				return
			end

			if var_164_1 == -1 then
				return
			end

			LayerManager:pushInLayer("PopComponentLayer", {
				entityid = var_164_1,
				itemid = playermodel.items[var_164_1].itemid,
				updateCallback = function(arg_172_0)
					if arg_172_0 == 1 then
						self.bagManager:update()
						self:updatePanelofCompareItems(var_164_1)
						self:updateItemList()
						self:updateShowingCells()
					elseif arg_172_0 == 2 then
						-- block empty
					elseif arg_172_0 == 3 then
						-- block empty
					elseif arg_172_0 == 4 then
						audio_manager:playeffectMusicTest("sound/invalid")
						global_ShowBlockWords(L_COMPONENT_TEXT.Warning[4])
						LayerManager:removePopLayer()
						LayerManager:pushInLayer("PopGoGainLayer", {
							item = "gold",
							goto_back_system_id = self.goto_back_system_id
						})
					end
				end
			})
		end)
	elseif self.panelType == ITEMPANEL_TYPE_SMELT_COMPONENT then
		self.bottomBnt1:setVisible(false)

		if arg_164_1.used then
			if arg_164_1.used == var_0_33 then
				self.bottomBnt2:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Unload)
				self.bottomBnt2:setVisible(true)
				self.bottomBnt2:addTouchEventListener(function(arg_173_0, arg_173_1)
					if arg_173_1 ~= ccui.TouchEventType.ended then
						return
					end

					if not arg_173_0:isBright() then
						return
					end

					if self.usedcallback then
						arg_173_0:setBright(false)
						self.usedcallback(arg_164_1.entityid)
					end
				end)
			elseif arg_164_1.used == var_0_34 then
				self.bottomBnt2:setVisible(false)
			end
		else
			self.bottomBnt2:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Switch)
			self.bottomBnt2:setVisible(true)
			self.bottomBnt2:addTouchEventListener(function(arg_174_0, arg_174_1)
				if arg_174_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_174_0:isBright() then
					return
				end

				if self.unusedcallback then
					arg_174_0:setBright(false)
					self.unusedcallback(arg_164_1.entityid, function()
						arg_174_0:setBright(true)
					end)
				end
			end)
		end
	elseif self.panelType == ITEMPANEL_TYPE_ROLE_WEAPON then
		self.bottomBnt1:setVisible(false)

		if not self.lastSelected and self.equipedEntityid ~= -1 or self.lastSelected and self.lastSelected.selected == nil and self.equipedEntityid ~= -1 then
			self.bottomBnt2:setVisible(true)
			self.bottomBnt2:setTouchEnabled(true)
			self.bottomBnt2:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Unload)
			self.bottomBnt2:setVisible(true)
			self.bottomBnt2:addTouchEventListener(function(arg_176_0, arg_176_1)
				if arg_176_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_176_0:isBright() then
					return
				end

				if self.equipedEntityid == -1 then
					audio_manager:playeffectMusicTest("sound/invalid")
					global_ShowBlockWords(L_WEAPON_NO_EQUIP)

					return
				end

				if self.usedcallback then
					arg_176_0:setBright(false)
					self.usedcallback(function(arg_177_0)
						arg_176_0:setBright(true)

						if arg_177_0 == 1 then
							self:exit()
						end
					end)
				end
			end)
		elseif self.lastSelected and self.lastSelected.selected ~= nil then
			self.bottomBnt2:setVisible(true)
			self.bottomBnt2:setTouchEnabled(true)

			if self.equipedEntityid ~= -1 then
				self.bottomBnt2:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Switch)
			else
				self.bottomBnt2:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Equip)
			end

			self.bottomBnt2:setVisible(true)
			self.bottomBnt2:addTouchEventListener(function(arg_178_0, arg_178_1)
				if arg_178_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_178_0:isBright() then
					return
				end

				if arg_164_1.used then
					LayerManager:pushInLayer("PopDoLayer", {
						labels = {
							title = L_WEAPON_CHANGE.title,
							des = L_WEAPON_CHANGE.des,
							button = L_WEAPON_CHANGE.button
						},
						surecallback = function()
							if self.unusedcallback then
								arg_178_0:setBright(false)
								self.unusedcallback(arg_164_1.entityid, function(arg_180_0)
									if arg_180_0 == 1 then
										self:exit()
									else
										arg_178_0:setBright(true)
									end
								end)
							end
						end
					})
				elseif self.unusedcallback then
					arg_178_0:setBright(false)
					self.unusedcallback(arg_164_1.entityid, function(arg_181_0)
						if arg_181_0 == 1 then
							self:exit()
						else
							arg_178_0:setBright(true)
						end
					end)
				end
			end)

			if arg_164_1.entityid then
				local var_164_2 = arg_164_1.entityid
				local var_164_3 = playermodel.items[arg_164_1.entityid].itemid

				self.bottomBnt1:setVisible(true)
				self.bottomBnt1:setTouchEnabled(true)
				self.bottomBnt1:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Strenthen)
				self.bottomBnt1:addTouchEventListener(function(arg_182_0, arg_182_1)
					local var_182_0

					if arg_182_1 ~= ccui.TouchEventType.ended then
						do return end

						var_182_0 = {
							showType = "strengthen",
							entityid = var_164_2,
							itemid = var_164_3
						}
					end

					function var_182_0.updateCallback()
						if arg_164_1 then
							arg_164_1:getChildByName("icon"):updateBigInfo()
							self:updatePanelofCompareItems(var_164_2)
						end
					end

					var_182_0.goto_back_system_id = self.goto_back_system_id

					global_basic_scene:addChild(PopLayer:Weapon_Info(var_182_0), 999)
				end)
			end
		else
			self.bottomBnt1:setVisible(false)
			self.bottomBnt1:setTouchEnabled(false)
			self.bottomBnt2:setVisible(false)
			self.bottomBnt2:setTouchEnabled(false)
		end
	elseif self.panelType == ITEMPANEL_TYPE_WEAPON_STRENGTHEN then
		self.bottomBnt1:setVisible(false)
		self.bottomBnt2:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Sure)
		self.bottomBnt2:setVisible(true)

		local var_164_4 = 0

		for iter_164_0, iter_164_1 in pairs(self.usedItems) do
			if var_0_2[iter_164_0] and iter_164_1 > 0 then
				var_164_4 = var_164_4 + var_0_2[iter_164_0].gain_exp * iter_164_1
			end
		end

		local var_164_6 = math.floor(var_164_4 * WEAPON_STRENGTHEN_C)
		local var_164_7 = playermodel.gold
		local var_164_8 = require("data.weapon_strengthen" .. var_0_2[playermodel.items[self.itemConditions.weaponEntityid].itemid].equip_quality .. "_data")
		local var_164_9 = math.ceil((playermodel.items[self.itemConditions.weaponEntityid].weapon_attr.level + 1) / 10) * 10

		if self.bottomBnt2:getParent():getChildByName("costPanel") then
			local var_164_10 = false
			local var_164_11 = false

			if var_164_8[var_164_9].all_exp - var_164_8[var_164_9].exp - (var_164_8[playermodel.items[self.itemConditions.weaponEntityid].weapon_attr.level].all_exp - var_164_8[playermodel.items[self.itemConditions.weaponEntityid].weapon_attr.level].exp + playermodel.items[self.itemConditions.weaponEntityid].weapon_attr.exp) < var_164_4 then
				var_164_10 = true

				self.bottomBnt2:getParent():getChildByName("gainexpLabel"):setString(L_GET_EXP .. "  " .. var_164_4 .. " (MAX)")
				self.bottomBnt2:getParent():getChildByName("gainexpLabel"):setColor(cc.c3b(255, 28, 81))
			else
				var_164_10 = false

				self.bottomBnt2:getParent():getChildByName("gainexpLabel"):setString(L_GET_EXP .. "  " .. var_164_4)
				self.bottomBnt2:getParent():getChildByName("gainexpLabel"):setColor(cc.c3b(212, 152, 88))
			end

			if var_164_7 < var_164_6 then
				var_164_11 = true

				self.bottomBnt2:getParent():getChildByName("costgoldLabel"):setString(L_COST .. L_GOLD .. ":  " .. var_164_6 .. "(" .. L_GOLD_LACK .. ")")
				self.bottomBnt2:getParent():getChildByName("costgoldLabel"):setColor(cc.c3b(255, 28, 81))
			else
				var_164_11 = false

				self.bottomBnt2:getParent():getChildByName("costgoldLabel"):setString(L_COST .. L_GOLD .. ":  " .. var_164_6)
				self.bottomBnt2:getParent():getChildByName("costgoldLabel"):setColor(cc.c3b(165, 182, 197))
			end

			self.isStrengthenMax = var_164_11 or var_164_10
		end

		self.bottomBnt2:addTouchEventListener(function(arg_184_0, arg_184_1)
			if arg_184_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_184_0:isBright() then
				return
			end

			self:exit()

			if self.surecallback then
				arg_184_0:setBright(false)

				for iter_184_0, iter_184_1 in pairs(self.usedItems) do
					if iter_184_1 == 0 then
						self.usedItems[iter_184_0] = nil
					end
				end

				self.surecallback(self.usedItems)
			end
		end)
	elseif self.panelType == ITEMPANEL_TYPE_UPGRADE_WEAPON then
		self.bottomBnt1:setVisible(true)
		self.bottomBnt1:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Details)
		self.bottomBnt2:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Comfirm_Comsume)
		self.bottomBnt2:setVisible(true)
		self.bottomBnt2:addTouchEventListener(function(arg_185_0, arg_185_1)
			if arg_185_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_185_0:isBright() then
				return
			end

			if playermodel.items[arg_164_1.entityid].itemType == kITEM_WEAPON and playermodel.items[arg_164_1.entityid].weapon_attr.lock then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_WEAPON_LOCK)

				return
			end

			self:exit()

			if self.surecallback then
				arg_185_0:setBright(false)
				self.surecallback(arg_164_1.entityid)
			end
		end)
	elseif self.panelType == ITEMPANEL_TYPE_COOK_ADD_FOOD then
		self.bottomBnt1:setVisible(false)
		self.bottomBnt2:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Sure)
		self.bottomBnt2:setVisible(true)

		local var_164_12 = 0

		for iter_164_2, iter_164_3 in pairs(self.usedItems) do
			if iter_164_3 > 0 then
				var_164_12 = var_164_12 + iter_164_3
			else
				self.usedItems[iter_164_2] = nil
			end
		end

		self.isStrengthenMax = var_164_12 >= 3

		self.bottomBnt2:addTouchEventListener(function(arg_186_0, arg_186_1)
			if arg_186_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_186_0:isBright() then
				return
			end

			self:exit()

			if self.surecallback then
				arg_186_0:setBright(false)
				self.surecallback(self.usedItems)
			end
		end)
	elseif self.panelType == ITEMPANEL_TYPE_MEDAL then
		self.bottomBnt1:setVisible(false)

		if playermodel.cur_medal[self.medalPos] == arg_164_1.entityid then
			self.bottomBnt2:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Unload)
			self.bottomBnt2:setVisible(true)
			self.bottomBnt2:addTouchEventListener(function(arg_187_0, arg_187_1)
				if arg_187_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_187_0:isBright() then
					return
				end

				item_manager:setShowMedal({
					pos = self.medalPos
				}, self.usedcallback)

				if self.usedcallback then
					arg_187_0:setBright(false)
				end
			end)
		else
			self.bottomBnt2:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Choose)
			self.bottomBnt2:setVisible(true)
			self.bottomBnt2:addTouchEventListener(function(arg_188_0, arg_188_1)
				if arg_188_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_188_0:isBright() then
					return
				end

				item_manager:setShowMedal({
					pos = self.medalPos,
					medal = arg_164_1.entityid
				}, self.unusedcallback)

				if self.unusedcallback then
					arg_188_0:setBright(false)
				end
			end)
		end
	elseif self.panelType == ITEMPANEL_TYPE_DORM_FURNITURE then
		self.bottomBnt1:setVisible(true)
		self.bottomBnt2:setVisible(true)
		self.bottomBnt1:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Restore)
		self.bottomBnt2:setTitleText(L_BUTTON_TEXT.Item_Panel_Btn.Sure)
		self.bottomBnt1:addTouchEventListener(function(arg_189_0, arg_189_1)
			if arg_189_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.usedItems = global_deepCopy(playermodel.dormRoomConfig[self.itemConditions.roomid].furnitures)

			self.roomPanel:updataFurniture(self.usedItems)
			self:furnituresAction()

			self.lastUsedItems = {}

			self.listPanel:reloadData()

			if self.furnitureSuitlist then
				self.furnitureSuitlist.selectSuitImg = nil
				self.furnitureSuitlist.selectSuitId = nil

				self.furnitureSuitlist:reloadData()
			end

			self.bottomBnt1:setVisible(false)
			self.bottomBnt2:setVisible(false)
		end)
		self.bottomBnt2:setVisible(true)

		if arg_164_1 then
			local var_164_13 = var_0_2[playermodel.items[arg_164_1.entityid].itemid]

			if arg_164_1.used then
				local var_164_14 = true

				for iter_164_4, iter_164_5 in pairs(self.usedItems) do
					if iter_164_5 > 0 and arg_164_1.entityid == iter_164_5 then
						if iter_164_4 == 1 then
							audio_manager:playeffectMusicTest("sound/invalid")
							global_ShowBlockWords(L_DORMROOM_CHANGE_FURNTURE_MSG[3])

							var_164_14 = false
						else
							self.usedItems[iter_164_4] = -1
						end
					end
				end

				if var_164_14 then
					arg_164_1.used = nil

					arg_164_1:getChildByName("icon"):getChildByName("uesdTag"):removeFromParent()
					self.roomPanel:updataFurniture(self.usedItems)

					self.lastUsedItems[var_164_13.furniture_type] = nil
				end
			else
				self.usedItems[var_164_13.furniture_type] = arg_164_1.entityid

				if self.lastUsedItems[var_164_13.furniture_type] and self.lastUsedItems[var_164_13.furniture_type].usedImg then
					self.lastUsedItems[var_164_13.furniture_type].usedImg:removeFromParent()

					self.lastUsedItems[var_164_13.furniture_type].used = nil
				end

				self.lastUsedItems[var_164_13.furniture_type] = arg_164_1

				self.roomPanel:updataFurniture(self.usedItems)

				if not arg_164_1:getChildByName("icon"):getChildByName("uesdTag") then
					local var_164_15

					if config._DEBUG then
						var_164_15 = cc.Sprite:create("public/box/used_on.png") or cc.Sprite:createWithSpriteFrameName("public/box/used_on.png")
					end

					var_164_15:setAnchorPoint(cc.p(0.5, 0.5))
					var_164_15:setPosition(cc.p(arg_164_1:getChildByName("icon"):getContentSize().width / 2, arg_164_1:getChildByName("icon"):getContentSize().height * 2 / 5))
					var_164_15:setName("uesdTag")

					local var_164_16 = cc.Label:createWithTTF(L_COMMON_WARNING.Using, "fonts/newkj.ttf", 22)

					var_164_16:setColor(cc.c3b(255, 100, 0))
					var_164_16:setPosition(var_164_15:getContentSize().width / 2, var_164_15:getContentSize().height / 2)
					var_164_15:addChild(var_164_16)
					arg_164_1:getChildByName("icon"):addChild(var_164_15)

					arg_164_1.usedImg = var_164_15
				end

				arg_164_1.used = true
			end

			self:furnituresAction(var_164_13.furniture_type)
		end

		self.bottomBnt2:addTouchEventListener(function(arg_190_0, arg_190_1)
			if arg_190_1 ~= ccui.TouchEventType.ended then
				return
			end

			arg_190_0:setTouchEnabled(false)

			local var_190_0 = false

			for iter_190_0, iter_190_1 in pairs(self.usedItems) do
				if iter_190_1 ~= playermodel.dormRoomConfig[self.itemConditions.roomid].furnitures[iter_190_0] then
					var_190_0 = true

					break
				end
			end

			self:exit()

			if self.surecallback then
				self.surecallback(self.usedItems, var_190_0)
			end
		end)
	end
end

function ItemsPanel.furnituresAction(arg_191_0, arg_191_1)
	return
end

function ItemsPanel.UpdateItemAttrPanel(arg_192_0)
	return
end

function ItemsPanel:getItemListLen()
	local var_193_0 = self.panelType == ITEMPANEL_TYPE_DORM_FURNITURE and math.ceil(#self.itemList / 3) + 1 or math.ceil(#self.itemList / 3)

	if var_193_0 < 5 then
		var_193_0 = 5
	end

	return var_193_0
end

function ItemsPanel:updateShowingCells(arg_194_1)
	local var_194_0, var_194_1 = GetTableViewShowCellIdx(self.listPanel, {
		cellsize = cc.size(var_0_44, var_0_45),
		maxcount = self:getItemListLen()
	})

	for iter_194_0 = var_194_0, var_194_1 do
		self.listPanel:updateCellAtIndex(iter_194_0)
	end

	if self.furnitureSuitlist then
		local var_194_2, var_194_3 = GetTableViewShowCellIdx(self.furnitureSuitlist, {
			cellsize = cc.size(586, 320),
			maxcount = #self.shopList + #self.suitList
		})

		for iter_194_1 = var_194_2, var_194_3 do
			self.furnitureSuitlist:updateCellAtIndex(iter_194_1)
		end
	end
end

function ItemsPanel:initDisplayValue(arg_195_1)
	self.displayPos = global_get_node_display_posy(arg_195_1, {
		TitleSprite = {
			posY = 56,
			focusName = "TitleSprite",
			reference = TRANSFORM_REFERENCE.UP,
			unit = TRANSFORM_UNIT.PX
		},
		Bottom_bg = {
			posY = 31,
			focusName = "Bottom_bg",
			reference = TRANSFORM_REFERENCE.DOWN,
			unit = TRANSFORM_UNIT.PX
		},
		panel_choose = {
			posY = 66,
			focusName = "panel_choose",
			reference = TRANSFORM_REFERENCE.UP,
			unit = TRANSFORM_UNIT.PX
		},
		Image_48 = {
			posY = 60,
			focusName = "Image_48",
			reference = TRANSFORM_REFERENCE.DOWN,
			unit = TRANSFORM_UNIT.PX
		},
		Panel_room = {
			posY = 213,
			focusName = "Panel_room",
			reference = TRANSFORM_REFERENCE.UP,
			unit = TRANSFORM_UNIT.PX
		}
	})

	for iter_195_0, iter_195_1 in pairs(self.displayPos) do
		local var_195_0 = ccui.Helper:seekWidgetByName(arg_195_1, iter_195_0)

		if var_195_0 then
			var_195_0:setPositionY(iter_195_1)
		end
	end

	local var_195_1 = ccui.Helper:seekWidgetByName(arg_195_1, "Image_48"):getContentSize()

	ccui.Helper:seekWidgetByName(arg_195_1, "Image_48"):setContentSize(cc.size(var_195_1.width, var_195_1.height + GameDisplay.fix_y * 2 - GameDisplay.notch_height))
end
