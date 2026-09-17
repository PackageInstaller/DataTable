PhotoGoodsLayer = class("PhotoGoodsLayer", function()
	return cc.Layer:create()
end)

require("data.constants")

local photo_manager = require("controller.photo_manager")

require("view.Sprite.ItemSprite")

local var_0_1 = "goods_weapon"
local var_0_2 = "goods_foods"
local var_0_3 = "goods_medal"
local var_0_4 = "goods_parts"
local var_0_5 = {}

var_0_5[#var_0_5 + 1] = "goods_weapon"
var_0_5[#var_0_5 + 1] = "goods_foods"
var_0_5[#var_0_5 + 1] = "goods_medal"
var_0_5[#var_0_5 + 1] = "goods_parts"

local var_0_6 = {}

var_0_6[#var_0_6 + 1] = L_PHOTOFILE_LEFT_BTN_TEXT[1]
var_0_6[#var_0_6 + 1] = L_PHOTOFILE_LEFT_BTN_TEXT[2]
var_0_6[#var_0_6 + 1] = L_PHOTOFILE_LEFT_BTN_TEXT[3]
var_0_6[#var_0_6 + 1] = L_PHOTOFILE_LEFT_BTN_TEXT[4]

local var_0_7 = {}

var_0_7.goods_weapon = true
var_0_7.goods_foods = true
var_0_7.goods_medal = true
var_0_7.goods_parts = true

local var_0_8 = config._DEBUG and 0 or 1
local var_0_9 = {
	[var_0_1] = require("data.weapon_data"),
	[var_0_2] = require("data.food_photo_data"),
	[var_0_3] = require("data.medal_data"),
	[var_0_4] = require("data.photogoods_component_data")
}
local var_0_13 = "ALL"
local var_0_14 = "UNLOCK"

function PhotoGoodsLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PhotoGoodsLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PhotoGoodsLayer.exit(arg_3_0)
	local var_3_0 = cc.EventCustom:new("switchShowLayer")

	var_3_0.layerName = "DormitoryLayer"
	var_3_0.initparam = {
		groupId = 5
	}

	cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_3_0)
	photo_manager:releaseAllData()
end

function PhotoGoodsLayer:init(arg_4_1)
	local var_4_0 = cc.EventCustom:new("showTopBottomLayer")

	var_4_0.showconfig = {
		ListButtonLayer = false,
		TopcostLayer = false
	}

	cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_4_0)

	self.select_buttonMode = var_0_13
	self.runLayer = nil
	self.size = cc.Director:getInstance():getVisibleSize()
	self.leftMemoryListCount = #var_0_6

	if arg_4_1 then
		self.leftSelectIndex = arg_4_1.photoSelectIndex or 1
	end

	self.rootlayer = cc.Layer:create()

	self.rootlayer:setName("rootlayer")
	self:addChild(self.rootlayer)
	require("view.Sprite.TitleSprite")

	local var_4_1 = TitleSprite:create("public/title/Items.png", 2)

	var_4_1:setPosition(0, 1080)
	self.rootlayer:addChild(var_4_1, 25)

	self.unlockLabel = cc.Label:createWithTTF(L_UNLOCK, FONT_NAME, 28)

	self.unlockLabel:setPosition(cc.p(476, 1103))
	self.unlockLabel:setName("unlockLabel1")
	self.unlockLabel:setColor(cc.c3b(198, 216, 233))
	self:addChild(self.unlockLabel, 1002)
	self:setBottomBtnList()

	self.leftMemoryListSize = cc.p(52, 162)
	self.leftIndex = self.leftMemoryListCount - self.leftSelectIndex
	self.space = 200
	self.leftBtnList = {}
	self.cellList = {}

	local var_4_2 = cc.TableView:create(cc.size(52, self.size.height - 58))

	var_4_2:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_4_2:setPosition(cc.p(0, 0))
	var_4_2:setDelegate()
	self.rootlayer:addChild(var_4_2)
	var_4_2:registerScriptHandler(function(arg_6_0)
		return self.leftMemoryListCount
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	var_4_2:registerScriptHandler(function(arg_7_0)
		layout = arg_7_0:getContainer()
		currentY = layout:getPositionY()

		if -currentY > layout:getContentSize().height - arg_7_0:getViewSize().height then
			arg_7_0:setContentOffset(cc.p(0, -layout:getContentSize().height + arg_7_0:getViewSize().height))
		end
	end, cc.SCROLLVIEW_SCRIPT_SCROLL)
	var_4_2:registerScriptHandler(function(arg_8_0, arg_8_1)
		if var_0_7[var_0_5[#var_0_5 - arg_8_1:getIdx()]] == false then
			global_ShowBlockWords(L_FUNCTION_NO_OPEN)

			return
		end

		self.leftSelectIndex = #var_0_5 - arg_8_1:getIdx()

		local var_8_0 = self.leftBtnList[tostring(self.leftIndex)]

		if config._DEBUG then
			var_8_0:setTexture("public/button/selected_tab_mid.png")
			var_8_0:getChildByName("text"):setColor(cc.c3b(152, 156, 183))
		else
			var_8_0:setSpriteFrame("public/button/selected_tab_mid.png")
			var_8_0:getChildByName("text"):setColor(cc.c3b(152, 156, 183))
		end

		local var_8_1 = self.leftBtnList[tostring(arg_8_1:getIdx())]

		if config._DEBUG then
			var_8_1:setTexture("public/button/selected_tab_top_on.png")
			var_8_1:getChildByName("text"):setColor(cc.c3b(140, 215, 255))
		else
			var_8_1:setSpriteFrame("public/button/selected_tab_top_on.png")
			var_8_1:getChildByName("text"):setColor(cc.c3b(140, 215, 255))
		end

		self.leftIndex = arg_8_1:getIdx()

		for iter_8_0, iter_8_1 in pairs(self.cellList) do
			iter_8_1:setLocalZOrder(iter_8_1:getIdx())
		end

		arg_8_1:setLocalZOrder(999)
		self:showRightViewList(var_0_5[self.leftMemoryListCount - arg_8_1:getIdx()])
	end, cc.TABLECELL_TOUCHED)
	var_4_2:registerScriptHandler(function(arg_9_0, arg_9_1)
		if arg_9_1 == 0 then
			return 52, 362
		else
			return 52, 162
		end
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_4_2:registerScriptHandler(function(arg_5_0, arg_5_1)
		local var_5_0 = string.format("%d", arg_5_1)
		local var_5_1 = arg_5_0:dequeueCell()

		if var_5_1 == nil then
			var_5_1 = cc.TableViewCell:new()

			local var_5_3

			if arg_5_1 == self.leftMemoryListCount - self.leftSelectIndex then
				var_5_3 = config._DEBUG and cc.Sprite:create("public/button/selected_tab_top_on.png") or cc.Sprite:createWithSpriteFrameName("public/button/selected_tab_top_on.png")

				var_5_1:setLocalZOrder(999)
			else
				var_5_3 = config._DEBUG and cc.Sprite:create("public/button/selected_tab_mid.png") or cc.Sprite:createWithSpriteFrameName("public/button/selected_tab_mid.png")
			end

			text = var_5_0

			if var_0_6[self.leftMemoryListCount - arg_5_1] then
				text = var_0_6[self.leftMemoryListCount - arg_5_1]
			end

			local var_5_4 = cc.Label:createWithTTF(text, FONT_BUTTON, 25)

			var_5_4:setName("text")
			var_5_4:setPosition(cc.p(25, 95))
			var_5_4:setLineBreakWithoutSpace(true)
			var_5_4:setMaxLineWidth(26)

			if arg_5_1 == self.leftMemoryListCount - self.leftSelectIndex then
				var_5_4:setColor(cc.c3b(140, 215, 255))
			else
				var_5_4:setColor(cc.c3b(152, 156, 183))
			end

			var_5_3:addChild(var_5_4)
			var_5_3:setAnchorPoint(cc.p(0, 0))

			if arg_5_1 == 0 then
				var_5_3:setPosition(cc.p(0, 0 + self.space))
			else
				var_5_3:setPosition(cc.p(0, 0))
			end

			self.leftBtnList[tostring(var_5_0)] = var_5_3

			var_5_1:addChild(var_5_3)
		else
			var_5_1:removeAllChildren()

			local var_5_5

			if arg_5_1 == self.leftMemoryListCount - self.leftSelectIndex then
				var_5_5 = config._DEBUG and cc.Sprite:create("public/button/selected_tab_top_on.png") or cc.Sprite:createWithSpriteFrameName("public/button/selected_tab_top_on.png")

				var_5_1:setLocalZOrder(999)
			else
				var_5_5 = config._DEBUG and cc.Sprite:create("public/button/selected_tab_mid.png") or cc.Sprite:createWithSpriteFrameName("public/button/selected_tab_mid.png")
			end

			text = var_5_0

			if var_0_6[self.leftMemoryListCount - arg_5_1] then
				text = var_0_6[self.leftMemoryListCount - arg_5_1]
			end

			local var_5_6 = cc.Label:createWithTTF(text, FONT_BUTTON, 25)

			var_5_6:setName("text")
			var_5_6:setPosition(cc.p(25, 95))
			var_5_6:setLineBreakWithoutSpace(true)
			var_5_6:setMaxLineWidth(26)

			if arg_5_1 == self.leftMemoryListCount - self.leftSelectIndex then
				var_5_6:setColor(cc.c3b(140, 215, 255))
			else
				var_5_6:setColor(cc.c3b(152, 156, 183))
			end

			var_5_5:addChild(var_5_6)
			var_5_5:setAnchorPoint(cc.p(0, 0))

			if arg_5_1 == 0 then
				var_5_5:setPosition(cc.p(0, 0 + self.space))
			else
				var_5_5:setPosition(cc.p(0, 0))
			end

			self.leftBtnList[tostring(var_5_0)] = var_5_5

			var_5_1:addChild(var_5_5)
		end

		if arg_5_1 == self.leftMemoryListCount - 1 then
			tempCell = var_5_1
		end

		self.cellList[#self.cellList + 1] = var_5_1

		return var_5_1
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_4_2:reloadData()
	self:showRightViewList(var_0_5[self.leftSelectIndex])
end

function PhotoGoodsLayer:setBottomBtnList()
	if self.bottomlist then
		self:removeChild(self.bottomlist)
	end

	local var_10_0 = {
		{
			name = "select"
		}
	}

	var_10_0[1].word = self.select_buttonMode == var_0_13 and L_PHOTO_SELECT_BUTTON_MODE[1] or L_PHOTO_SELECT_BUTTON_MODE[2]
	var_10_0[1].handler = function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.select_buttonMode = self.select_buttonMode == var_0_13 and var_0_14 or var_0_13

		self:setBottomBtnList()
		self:showRightViewList()
	end
	self.bottomList = BottomBtnList:create(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end, var_10_0)

	self.bottomList:setName("bottomlist")
	self:addChild(self.bottomList, 1000)
end

function PhotoGoodsLayer:showRightViewList(arg_13_1)
	local var_13_0 = cc.size(174, 236)

	self.rootlayer:removeChild(self.runLayer)
	self:removeChild(self:getChildByName("unlockLabel2"))

	if arg_13_1 then
		self.filesSelectType = arg_13_1
	end

	local var_13_1 = 0
	local var_13_2 = 0

	self.totalNumber = nil
	self.fileInfo = nil

	if self.filesSelectType == var_0_5[1] then
		photo_manager:initWeaponData()

		self.goodsInfoAll = photo_manager:getWeaponData()

		if self.select_buttonMode == var_0_13 then
			self.totalNumber = photo_manager:getWeaponNumber()
			self.goodsInfo = photo_manager:getWeaponData()
		else
			self.totalNumber = photo_manager:getUnlockWeaponNumber()
			self.goodsInfo = photo_manager:getUnlockWeaponData()
		end

		var_13_1 = photo_manager:getWeaponNumber()
		var_13_2 = photo_manager:getUnlockWeaponNumber()
		var_13_0 = cc.size(174, 256)
	elseif self.filesSelectType == var_0_5[2] then
		photo_manager:initFoodTable()

		self.goodsInfoAll = photo_manager:getFoodData()

		if self.select_buttonMode == var_0_13 then
			self.totalNumber = photo_manager:getFoodNumber()
			self.goodsInfo = photo_manager:getFoodData()
		else
			self.totalNumber = photo_manager:getUnlockFoodNumber()
			self.goodsInfo = photo_manager:getUnlockFoodData()
		end

		var_13_1 = photo_manager:getFoodNumber()
		var_13_2 = photo_manager:getUnlockFoodNumber()
	elseif self.filesSelectType == var_0_5[3] then
		photo_manager:initMedalTable()

		self.goodsInfoAll = photo_manager:getMedalData()

		if self.select_buttonMode == var_0_13 then
			self.totalNumber = photo_manager:getMedalNumber()
			self.goodsInfo = photo_manager:getMedalData()
		else
			self.totalNumber = photo_manager:getUnlockMedalNumber()
			self.goodsInfo = photo_manager:getUnlockMedalData()
		end

		var_13_1 = photo_manager:getMedalNumber()
		var_13_2 = photo_manager:getUnlockMedalNumber()
	elseif self.filesSelectType == var_0_5[4] then
		photo_manager:initPartsTable()

		self.goodsInfoAll = photo_manager:getPartsData()

		if self.select_buttonMode == var_0_13 then
			self.totalNumber = photo_manager:getPartsNumber()
			self.goodsInfo = photo_manager:getPartsData()
		else
			self.totalNumber = photo_manager:getUnlockPartsNumber()
			self.goodsInfo = photo_manager:getUnlockPartsData()
		end

		var_13_1 = photo_manager:getPartsNumber()
		var_13_2 = photo_manager:getUnlockPartsNumber()
	elseif arg_13_1 ~= nil then
		return
	end

	local var_13_3 = cc.Label:createWithTTF(tostring(var_13_2) .. "/" .. tostring(var_13_1), FONT_DES, 22)

	var_13_3:setAnchorPoint(cc.p(0, 0.5))
	var_13_3:setPosition(cc.p(self.unlockLabel:getPositionX() + 35, self.unlockLabel:getPositionY()))
	var_13_3:setName("unlockLabel2")
	var_13_3:setColor(cc.c3b(255, 164, 16))
	self:addChild(var_13_3, 1002)

	self.filesTableCellNumber = math.ceil(self.totalNumber / 3)

	local var_13_4 = cc.Director:getInstance():getVisibleSize()

	var_13_4.width = var_13_4.width - 52
	var_13_4.height = var_13_4.height + 100

	function setCellInfo(arg_14_0, arg_14_1, arg_14_2)
		arg_14_0:removeAllChildren()

		if not arg_14_1 then
			return
		end

		local var_14_0
		local var_14_1
		local var_14_2

		if self.filesSelectType == var_0_1 then
			var_14_1 = ItemSprite:createNewWithItemId(self.goodsInfo[arg_14_1].id, nil, nil, self.goodsInfo[arg_14_1].name, "maxStars=5&nowStars=5")

			var_14_1:setPosition(cc.p(arg_14_0:getContentSize().width / 2, arg_14_0:getContentSize().height / 2))
			arg_14_0:addChild(var_14_1, 1)

			if var_14_1:getChildByName("starsPanel") then
				var_14_1:getChildByName("starsPanel"):setVisible(false)
			end

			var_14_0 = ccui.Button:create("public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", var_0_8)

			var_14_0:setPosition(cc.p(0, 0))
			var_14_0:setAnchorPoint(cc.p(0, 0))
			arg_14_0:addChild(var_14_0, 0)
			var_14_0:setSwallowTouches(false)
		end

		if self.filesSelectType == var_0_2 then
			var_14_1 = ItemSprite:createNewWithItemId(arg_14_2[self.goodsInfo[arg_14_1].id].id, nil, nil, arg_14_2[self.goodsInfo[arg_14_1].id].name)

			var_14_1:setPosition(cc.p(arg_14_0:getContentSize().width / 2, arg_14_0:getContentSize().height / 2))
			arg_14_0:addChild(var_14_1, 1)

			var_14_0 = ccui.Button:create("public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", var_0_8)

			var_14_0:setPosition(cc.p(0, 0))
			var_14_0:setAnchorPoint(cc.p(0, 0))
			arg_14_0:addChild(var_14_0, 0)
			var_14_0:setSwallowTouches(false)
		end

		if self.filesSelectType == var_0_3 then
			var_14_1 = ItemSprite:createNewWithItemId(arg_14_2[self.goodsInfo[arg_14_1].id].id, nil, nil, arg_14_2[self.goodsInfo[arg_14_1].id].name)

			var_14_1:setPosition(cc.p(arg_14_0:getContentSize().width / 2, arg_14_0:getContentSize().height / 2))
			arg_14_0:addChild(var_14_1, 1)

			var_14_0 = ccui.Button:create("public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", var_0_8)

			var_14_0:setPosition(cc.p(0, 0))
			var_14_0:setAnchorPoint(cc.p(0, 0))
			arg_14_0:addChild(var_14_0, 0)
			var_14_0:setSwallowTouches(false)
		end

		if self.filesSelectType == var_0_4 then
			var_14_1 = config._DEBUG and cc.Sprite:create("public/box/new_item_bg5.png") or cc.Sprite:createWithSpriteFrameName("public/box/new_item_bg5.png")

			var_14_1:setPosition(cc.p(arg_14_0:getContentSize().width / 2, arg_14_0:getContentSize().height / 2))
			arg_14_0:addChild(var_14_1, 1)

			local var_14_3 = {
				"bg_white.png",
				"bg_green.png",
				"bg_blue.png",
				"bg_purple.png",
				"bg_orange.png"
			}
			local var_14_4

			if config._DEBUG then
				var_14_4 = cc.Sprite:create("parts/" .. var_14_3[arg_14_2[self.goodsInfo[arg_14_1].id].equip_quality]) or cc.Sprite:createWithSpriteFrameName("parts/" .. var_14_3[arg_14_2[self.goodsInfo[arg_14_1].id].equip_quality])
			end

			var_14_4:setAnchorPoint(cc.p(0.5, 0.5))
			var_14_4:setScale(0.5)
			var_14_4:setPosition(cc.p(90, 140))

			local var_14_5

			if config._DEBUG then
				var_14_5 = cc.Sprite:create("parts/new/" .. arg_14_2[self.goodsInfo[arg_14_1].id].image_id .. ".png") or cc.Sprite:createWithSpriteFrameName("parts/new/" .. arg_14_2[self.goodsInfo[arg_14_1].id].image_id .. ".png")
			end

			var_14_5:setAnchorPoint(cc.p(0.5, 0.5))
			var_14_5:setPosition(cc.p(var_14_4:getContentSize().width / 2, var_14_4:getContentSize().height / 2))
			var_14_4:addChild(var_14_5, 1)
			var_14_1:addChild(var_14_4)
			var_14_1:setPosition(cc.p(arg_14_0:getContentSize().width / 2, arg_14_0:getContentSize().height / 2))

			local var_14_6 = cc.Label:createWithTTF("", "fonts/new.ttf", 22)

			var_14_6:setAnchorPoint(cc.p(0.5, 1))
			var_14_6:setPosition(cc.p(var_14_1:getContentSize().width / 2, 38))
			var_14_6:setString(arg_14_2[self.goodsInfo[arg_14_1].id].name)
			var_14_6:setColor(cc.c3b(213, 206, 231))
			var_14_1:addChild(var_14_6)

			var_14_0 = ccui.Button:create("public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", var_0_8)

			var_14_0:setPosition(cc.p(0, 0))
			var_14_0:setAnchorPoint(cc.p(0, 0))
			arg_14_0:addChild(var_14_0, 0)
			var_14_0:setSwallowTouches(false)
		end

		if self.goodsInfo[arg_14_1].unlock ~= 1 then
			if self.filesSelectType ~= var_0_3 then
				var_14_1:setOpacity(100)

				if var_14_2 then
					var_14_2:setOpacity(100)
				end

				if var_14_1 then
					var_14_1:setOpacity(100)
				end

				if var_14_0 then
					var_14_0:setOpacity(100)
				end
			end

			local var_14_7

			if config._DEBUG then
				var_14_7 = cc.Sprite:create("MarketLayer/cost_bg.png") or cc.Sprite:createWithSpriteFrameName("MarketLayer/cost_bg.png")

				if self.filesSelectType == files_player then
					var_14_7:setPosition(cc.p(arg_14_0:getContentSize().width / 2, arg_14_0:getContentSize().height / 2 - 80))

					goto label_14_0
				end
			end

			var_14_7:setPosition(cc.p(arg_14_0:getContentSize().width / 2, arg_14_0:getContentSize().height / 2 - 20))

			::label_14_0::

			arg_14_0:addChild(var_14_7, 3)

			local var_14_8

			if config._DEBUG then
				var_14_8 = cc.Sprite:create("Photo/plot_lock.png") or cc.Sprite:createWithSpriteFrameName("Photo/plot_lock.png")
			end

			var_14_8:setPosition(cc.p(var_14_7:getContentSize().width / 2 - 45, var_14_7:getContentSize().height / 2))
			var_14_8:setScale(0.7)
			var_14_7:addChild(var_14_8)

			local var_14_9 = cc.Label:createWithTTF(L_COMMON_WARNING.Locking, FONT_NAME, 22)

			var_14_9:setPosition(cc.p(var_14_7:getContentSize().width / 2 + 20, var_14_7:getContentSize().height / 2))
			var_14_9:setColor(cc.c3b(133, 145, 169))
			var_14_7:addChild(var_14_9)
			var_14_7:setVisible(false)
		end

		var_14_0:addTouchEventListener(function(arg_15_0, arg_15_1)
			if arg_15_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_15_0:getTouchBeganPosition().y - arg_15_0:getTouchEndPosition().y) > 50 then
				return
			end

			if self.filesSelectType == var_0_2 then
				require("view.Layer.PhotoGoodsPopLayer")
				self:addChild(PhotoGoodsPopLayer:create({
					goodsType = 1,
					id = self.goodsInfo[arg_14_1].id,
					photoSelectIndex = self.leftSelectIndex
				}), 10)
			end

			if self.filesSelectType == var_0_1 then
				require("view.Layer.WeaponLayer")
				self:setName("PhotoGoodsLayer")
				LayerManager:pushInLayer("PhotoWeaponLayer", {
					showGetWays = true,
					itemid = self.goodsInfo[arg_14_1].id,
					photoSelectIndex = self.leftSelectIndex
				})
			end

			if self.filesSelectType == var_0_3 then
				require("view.Layer.PhotoGoodsPopLayer")
				self:addChild(PhotoGoodsPopLayer:create({
					goodsType = 2,
					id = self.goodsInfo[arg_14_1].id,
					photoSelectIndex = self.leftSelectIndex
				}), 10)
			end

			if self.filesSelectType == var_0_4 then
				require("view.Layer.PhotoGoodsPopLayer")
				self:addChild(PhotoGoodsPopLayer:create({
					goodsType = 3,
					id = self.goodsInfo[arg_14_1].id,
					photoSelectIndex = self.leftSelectIndex
				}), 10)
			end
		end)
	end

	function updateTable(arg_16_0, arg_16_1)
		local var_16_0 = string.format("%d", arg_16_1)
		local var_16_1 = arg_16_0:dequeueCell()
		local var_16_2
		local var_16_3
		local var_16_4
		local var_16_5 = (self.filesTableCellNumber - arg_16_1) * 3 - 2

		if var_16_1 == nil then
			var_16_1 = cc.TableViewCell:create()
			var_16_2 = self.filesSelectType == files_player and (config._DEBUG and cc.Sprite:create("Photo/clothes_bg1.png") or cc.Sprite:createWithSpriteFrameName("Photo/clothes_bg1.png")) or config._DEBUG and cc.Sprite:create("public/box/new_item_bg_touming.png") or cc.Sprite:createWithSpriteFrameName("public/box/new_item_bg_touming.png")

			var_16_2:setAnchorPoint(cc.p(0, 0))

			if arg_16_1 == 0 then
				var_16_2:setPosition(cc.p(0, self.space))
			else
				var_16_2:setPosition(cc.p(0, 0))
			end

			var_16_2:setName("photo1")
			var_16_1:addChild(var_16_2)

			if var_16_5 + 1 <= self.totalNumber then
				var_16_3 = self.filesSelectType == files_player and (config._DEBUG and cc.Sprite:create("Photo/clothes_bg1.png") or cc.Sprite:createWithSpriteFrameName("Photo/clothes_bg1.png")) or config._DEBUG and cc.Sprite:create("public/box/new_item_bg_touming.png") or cc.Sprite:createWithSpriteFrameName("public/box/new_item_bg_touming.png")

				var_16_3:setAnchorPoint(cc.p(0, 0))

				if arg_16_1 == 0 then
					var_16_3:setPosition(cc.p(189, self.space))
				else
					var_16_3:setPosition(cc.p(189, 0))
				end

				var_16_3:setName("photo2")
				var_16_1:addChild(var_16_3)
			end

			if var_16_5 + 2 <= self.totalNumber then
				var_16_4 = self.filesSelectType == files_player and (config._DEBUG and cc.Sprite:create("Photo/clothes_bg1.png") or cc.Sprite:createWithSpriteFrameName("Photo/clothes_bg1.png")) or config._DEBUG and cc.Sprite:create("public/box/new_item_bg_touming.png") or cc.Sprite:createWithSpriteFrameName("public/box/new_item_bg_touming.png")

				var_16_4:setAnchorPoint(cc.p(0, 0))

				if arg_16_1 == 0 then
					var_16_4:setPosition(cc.p(378, self.space))
				else
					var_16_4:setPosition(cc.p(378, 0))
				end

				var_16_4:setName("photo3")
				var_16_1:addChild(var_16_4)
			end
		else
			var_16_2 = var_16_1:getChildByName("photo1")

			var_16_2:setAnchorPoint(cc.p(0, 0))

			var_16_3 = var_16_1:getChildByName("photo2")

			if not var_16_3 then
				var_16_3 = config._DEBUG and cc.Sprite:create("Photo/clothes_bg1.png") or cc.Sprite:createWithSpriteFrameName("Photo/clothes_bg1.png")

				var_16_3:setAnchorPoint(cc.p(0, 0))
				var_16_3:setName("photo2")
				var_16_1:addChild(var_16_3)
			end

			var_16_4 = var_16_1:getChildByName("photo3")

			if not var_16_4 then
				var_16_4 = config._DEBUG and cc.Sprite:create("MarketLayer/clothes_bg.png") or cc.Sprite:createWithSpriteFrameName("MarketLayer/clothes_bg.png")

				var_16_4:setAnchorPoint(cc.p(0, 0))
				var_16_4:setName("photo3")
				var_16_1:addChild(var_16_4)
			end

			if arg_16_1 == 0 and var_16_2 then
				var_16_2:setPosition(cc.p(0, self.space))
			elseif var_16_2 then
				var_16_2:setPosition(cc.p(0, 0))
			end

			if arg_16_1 == 0 and var_16_3 then
				var_16_3:setPosition(cc.p(189, self.space))
			elseif var_16_3 then
				var_16_3:setPosition(cc.p(189, 0))
			end

			if arg_16_1 == 0 and var_16_4 then
				var_16_4:setPosition(cc.p(378, self.space))
			elseif var_16_4 then
				var_16_4:setPosition(cc.p(378, 0))
			end
		end

		setCellInfo(var_16_2, var_16_5, var_0_9[self.filesSelectType])

		if var_16_5 + 1 <= self.totalNumber and var_16_3 then
			var_16_3:setVisible(true)
			setCellInfo(var_16_3, var_16_5 + 1, var_0_9[self.filesSelectType])

			if var_16_5 + 1 + 1 <= self.totalNumber and var_16_4 then
				var_16_4:setVisible(true)
				setCellInfo(var_16_4, var_16_5 + 1 + 1, var_0_9[self.filesSelectType])
			elseif var_16_4 then
				var_16_4:setVisible(false)
			end
		elseif var_16_3 then
			var_16_3:setVisible(false)

			if var_16_4 then
				var_16_4:setVisible(false)
			end
		end

		return var_16_1
	end

	self.runLayer = cc.TableView:create(cc.size(var_13_4.width, 1078))

	self.runLayer:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.runLayer:setPosition(cc.p(71, 0))
	self.runLayer:setDelegate()
	self.rootlayer:addChild(self.runLayer)
	self.runLayer:registerScriptHandler(function(arg_17_0)
		return self.filesTableCellNumber
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.runLayer:registerScriptHandler(function(arg_18_0)
		return
	end, cc.SCROLLVIEW_SCRIPT_SCROLL)
	self.runLayer:registerScriptHandler(function(arg_19_0, arg_19_1)
		if arg_19_1 == 0 then
			return var_13_0.width, var_13_0.height + self.space
		end

		return var_13_0.width, var_13_0.height
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.runLayer:registerScriptHandler(updateTable, cc.TABLECELL_SIZE_AT_INDEX)
	self.runLayer:reloadData()
end
