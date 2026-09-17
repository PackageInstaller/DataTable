PopItemLayer = class("PopItemLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Layer.Pops.PopGoodsLayer")
require("view.Layer.Pops.PopGiftBagLayer")
require("view.Layer.Pops.PopComponentLayer")

local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local major_factor_data = require("data.major_factor_data")
local lab_manager = require("controller.lab_manager")
local var_0_5 = config._DEBUG and 0 or 1
local var_0_6

function PopItemLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopItemLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopItemLayer.getInstance()
	return var_0_6
end

function PopItemLayer:init(arg_4_1)
	print(">>>>>>>>>>>>>>PopItemLayer>>>>>>>>>>>>>>>>>>>>>>>>>", dump(arg_4_1))

	var_0_6 = true
	self.msg = arg_4_1
	self.entityid = arg_4_1.entityid
	self.itemid = arg_4_1.itemid
	self.itemInfo = item_data[self.itemid]
	self.goto_back_system_id = arg_4_1.goto_back_system_id
	self.updateCallback = arg_4_1.updateCallback
	self.isShowInBag = arg_4_1.isShowInBag

	if arg_4_1.dropnum then
		arg_4_1.itemnum = arg_4_1.dropnum
	elseif arg_4_1.itemnum then
		arg_4_1.dropnum = arg_4_1.itemnum
	end

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Popup_normal.json" or "Popup_normal.ExportJson")

	self:addChild(self.rootLayer)

	self.rootpanel = self.rootLayer:getChildByName("panel_back")
	self.bg = ccui.Helper:seekWidgetByName(self.rootpanel, "bg")
	self.title = ccui.Helper:seekWidgetByName(self.rootpanel, "title")
	self.confirm_button = ccui.Helper:seekWidgetByName(self.rootpanel, "button_sure")
	self.confirm_button_label = self.confirm_button:getChildByName("label")
	self.system_figure = ccui.Helper:seekWidgetByName(self.rootpanel, "image_system_figure")
	self.button_close = ccui.Helper:seekWidgetByName(self.rootpanel, "button_close")

	self.bg:setTouchEnabled(true)
	self.system_figure:setVisible(false)
	self.confirm_button:setVisible(false)
	self.rootLayer:setPositionY(-GameDisplay.fix_y)
	self.rootLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.rootpanel:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootpanel:setPosition(GameDisplay.width / 2, GameDisplay.height / 2)
	self.showActions.extendVertical(self)
	self:registerExitEvent()
	self:initPanelInfo()
	self:initItemInfo()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			var_0_6 = nil

			if self.updateCallback then
				self.updateCallback()
			end
		end
	end)
end

function PopItemLayer:registerExitEvent()
	local function var_6_0(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)

			if self.msg.cancelcallback then
				self.msg.cancelcallback()
			end
		end)
	end

	self.button_close:addTouchEventListener(var_6_0)
	self.rootLayer:addTouchEventListener(var_6_0)
end

function PopItemLayer:initPanelInfo()
	if self.msg.labels then
		if self.msg.labels.title then
			self.title:setString(self.msg.labels.title)
		else
			self.title:setString("")
		end

		if self.msg.button then
			self.confirm_button_label:setString(msg.button)
		end
	else
		self.title:setString("")
	end

	self:initBnt()
	self:initDecomposeBtn()
end

function PopItemLayer:initDecomposeBtn()
	if not self.isShowInBag then
		return
	end

	local var_10_0 = lab_manager:getOperatorInfoById(self.itemid)

	if not var_10_0 then
		return
	end

	local var_10_1 = (var_10_0.compose and 2 or 0) + (var_10_0.decompose and 1 or 0)

	if (var_10_0.compose and 2 or 0) + (var_10_0.decompose and 1 or 0) <= 0 then
		return
	end

	local function var_10_2(arg_11_0, arg_11_1, arg_11_2)
		local var_11_0 = ccui.Button:create(arg_11_0, nil, arg_11_0, var_0_5)

		var_11_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_11_0:setPosition(arg_11_1)
		self.rootpanel:addChild(var_11_0, 10)
		var_11_0:addTouchEventListener(function(arg_12_0, arg_12_1)
			if arg_12_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:removePopLayer()
			LayerManager:pushInLayer("PopDecomposeItemLayer", {
				entityId = self.entityid,
				itemId = self.itemid,
				type = arg_11_2
			})
		end)
	end

	if var_10_1 == 1 then
		var_10_2("decompose/btn_decompose.png", cc.p(GameDisplay.width / 2 - 5, 310), 1)
	elseif var_10_1 == 2 then
		var_10_2("decompose/btn_compose.png", cc.p(GameDisplay.width / 2 - 5, 310), 2)
	elseif var_10_1 == 3 then
		var_10_2("decompose/btn_decompose.png", cc.p(GameDisplay.width / 2 - 135, 310), 1)
		var_10_2("decompose/btn_compose.png", cc.p(GameDisplay.width / 2 + 135, 310), 2)
	end
end

function PopItemLayer:initItemInfo()
	local var_13_0 = cc.Layer:create()

	var_13_0:setPosition(cc.p(20, 280))
	var_13_0:setName("layer_item_info")
	self.rootpanel:addChild(var_13_0)

	self.itemInfoLayer = var_13_0

	self:initIcon()
	self:initDes()
	self:initIntro()
	self:initNumber()
	self:initWeight()
	self:initTitle()
	self:initGainBnt()
	self:initSkinBtn()
	self:initChooseGift()
end

function PopItemLayer:initIcon()
	if self.entityid and self.itemid ~= ALMIGHTY_WEAPON then
		self.Strength_Icon = ItemSprite:createBigWithEntityId(self.entityid, self.msg.dropnum or playermodel.items[self.entityid].number)

		if self.Strength_Icon:getChildByName("lock") then
			self.Strength_Icon:getChildByName("lock"):setVisible(false)
		end
	else
		self.Strength_Icon = ItemSprite:createNewWithItemId(self.itemid, nil, nil, nil, self.msg.item_attr)
	end

	self.Strength_Icon:setPosition(cc.p(140, 410))
	self.Strength_Icon:setName("Strength_Icon")
	self.itemInfoLayer:addChild(self.Strength_Icon, 1)
end

function PopItemLayer:initDes()
	local var_15_0 = ccui.ImageView:create("public/panelbg/intro_bottom.png", var_0_5)

	var_15_0:setScale9Enabled(true)
	var_15_0:setName("using_des_bg")
	var_15_0:setContentSize(cc.size(470, 50))
	var_15_0:setAnchorPoint(cc.p(0, 1))
	var_15_0:setPosition(cc.p(53, 270))
	self.itemInfoLayer:addChild(var_15_0, 1)

	local var_15_1 = cc.Label:createWithTTF("", FONT_NAME, 17)

	var_15_1:setString(item_data[self.itemid].user_manual or L_ITEM_NAME_DEFAULT)
	var_15_1:setPosition(cc.p(10, 40))
	var_15_1:setAnchorPoint(cc.p(0, 1))
	var_15_1:setMaxLineWidth(450)
	var_15_1:setColor(cc.c3b(243, 249, 255))
	var_15_0:addChild(var_15_1)

	self.using_des_bg = var_15_0
end

function PopItemLayer:initIntro()
	local var_16_0 = ccui.ImageView:create("public/panelbg/intro_bottom.png", var_0_5)

	var_16_0:setScale9Enabled(true)
	var_16_0:setName("layout")
	var_16_0:setContentSize(cc.size(470, 30))
	var_16_0:setAnchorPoint(cc.p(0, 1))
	self.itemInfoLayer:addChild(var_16_0, 1)

	local var_16_1 = cc.Label:createWithTTF(self.itemInfo.intro or L_ITEM_INFO_LOCK, FONT_DES, 17)

	var_16_1:setName("info")
	var_16_1:setColor(cc.c3b(188, 206, 226))
	var_16_1:setMaxLineWidth(450)
	var_16_1:setAnchorPoint(cc.p(0, 1))
	var_16_1:setDimensions(450, 0)
	var_16_0:addChild(var_16_1, 2)

	self.intro_info = var_16_1

	var_16_0:setPosition(cc.p(53, 210))

	if self.costLayer then
		var_16_0:setContentSize(cc.size(470, 65))
		var_16_1:setPosition(cc.p(10, 55))
	else
		var_16_0:setContentSize(cc.size(470, 65))
		var_16_1:setPosition(cc.p(10, 55))
	end
end

function PopItemLayer:initNumber()
	local var_17_0 = cc.Label:createWithTTF("", FONT_DES, 20)

	var_17_0:setAnchorPoint(cc.p(0, 0.5))
	var_17_0:setPosition(cc.p(245, 470))
	var_17_0:setColor(cc.c3b(0, 216, 255))
	var_17_0:setName("numberLabel")
	self.itemInfoLayer:addChild(var_17_0, 1)

	if self.itemInfo.bag_item_type ~= 13 and self.itemInfo.bag_item_type ~= 188 then
		var_17_0:setString(L_ITEM_NUMBER .. (self.msg.itemnum or item_manager:getItemNumber(self.itemid)))
	else
		var_17_0:setString(self.itemInfo.name)
	end

	self.numberLabel = var_17_0

	local var_17_2 = cc.Label:createWithTTF(self.itemInfo.name, FONT_DES, 32)

	var_17_2:setName("name_label")
	var_17_2:setColor(cc.c3b(188, 206, 226))
	var_17_2:setAnchorPoint(0, 0.5)
	var_17_2:setPosition(cc.p(245, 510))
	self.itemInfoLayer:addChild(var_17_2, 1)

	self.nameLabel = var_17_2
end

function PopItemLayer:initWeight()
	local var_18_0 = ccui.Helper:seekWidgetByName(self.rootpanel, "image_bg")

	if self.itemInfo.bagweight and self.itemInfo.bagweight ~= 0 then
		local var_18_1 = ccui.Helper:seekWidgetByName(self.rootpanel, "title")

		var_18_0:setContentSize(cc.size(532, 540))
		var_18_0:setPositionY(var_18_0:getPositionY() + 17)

		local var_18_2 = cc.Label:createWithTTF(L_ITEM_WEIGHT .. self.itemInfo.bagweight, FONT_DES, 20)

		var_18_2:setColor(cc.c3b(188, 206, 226))
		var_18_2:setAnchorPoint(cc.p(1, 0))
		var_18_2:setPosition(cc.p(520, 115))
		self.itemInfoLayer:addChild(var_18_2)

		self.weightLabel = var_18_2
	else
		var_18_0:setContentSize(cc.size(532, 540))
		var_18_0:setPositionY(var_18_0:getPositionY() + 17)
	end
end

function PopItemLayer:initTitle()
	local var_19_1 = ccui.ImageView:create(self.itemInfo.bag_item_type == kITEM_WEAPON and "public/panelbg/title_weapon.png" or self.itemInfo.bag_item_type == kITEM_COMPONENT and "public/panelbg/title_component.png" or "public/panelbg/title_item.png", var_0_5)

	var_19_1:setName("titleImg")
	var_19_1:setAnchorPoint(cc.p(0, 0.5))
	var_19_1:setPosition(cc.p(34, 578))
	self.itemInfoLayer:addChild(var_19_1)

	self.titleImg = var_19_1
end

function PopItemLayer:initGainBnt()
	local var_20_0 = ccui.Button:create("public/button/button_saying.png", nil, "public/button/button_saying.png", var_0_5)

	var_20_0:setPosition(cc.p(470, 295))
	var_20_0:setName("GainButton")
	self.itemInfoLayer:addChild(var_20_0, 1)
	var_20_0:setVisible(self.msg.hideGainButton ~= true)
	var_20_0:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_21_0 = {
			item = self.itemid,
			returnlayer = self.msg.returnlayer,
			goto_back_system_id = self.msg.goto_back_system_id,
			goto_back_system_config = self.msg.goto_back_system_config
		}

		LayerManager:removePopLayer()
		LayerManager:pushInLayer("PopGoGainLayer", var_21_0)
	end)

	self.gainButton = var_20_0
end

function PopItemLayer:initSkinBtn()
	if item_data[self.itemid].bag_item_type ~= kITEM_SKIN then
		return
	end

	if not major_factor_data[item_data[self.itemid].major] then
		return
	end

	local var_22_0 = ccui.Button:create("public/button/skin_btn.png", nil, "public/button/skin_btn.png", var_0_5)

	var_22_0:setPosition(cc.p(496, 512))
	var_22_0:setName("skinButton")
	self.itemInfoLayer:addChild(var_22_0, 1)
	var_22_0:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer()
		LayerManager:pushInLayer("PopShowGilrPreviewLayer", {
			itemid = self.itemid
		})
	end)

	self.skinButton = var_22_0
end

function PopItemLayer:initChooseGift(...)
	if item_data[self.itemid].bag_item_type ~= kITEM_CHOOSE_GIFT then
		return
	end

	local var_24_0 = ccui.Button:create("public/button/pop_item_info_btn.png", nil, "public/button/pop_item_info_btn.png", var_0_5)

	var_24_0:setPosition(cc.p(496, 470))
	var_24_0:setName("itemInfoButton")
	self.itemInfoLayer:addChild(var_24_0, 1)
	var_24_0:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer()
		LayerManager:pushInLayer("PopOpenChoosegiftLayer", {
			opentype = 2,
			itemid = self.itemid
		})
	end)
end

function PopItemLayer:initBnt()
	if not self.msg.button then
		return
	end

	if next(self.msg.button) == nil then
		return
	end

	local var_26_1 = GameDisplay.width / 2 - 5
	local var_26_2 = 450
	local var_26_3 = 280
	local var_26_4 = #self.msg.button

	for iter_26_0, iter_26_1 in pairs(self.msg.button) do
		local var_26_5 = ccui.Button:create(var_26_4 >= 2 and "public/button/public_button_orange.png" or "public/button/public_button_orange_long.png", nil, var_26_4 >= 2 and "public/button/public_button_orange.png" or "public/button/public_button_orange_long.png", var_0_5)

		var_26_5:setAnchorPoint(cc.p(0.5, 0.5))
		var_26_5:setPositionX(var_26_1 + var_26_3 * (iter_26_0 - 1 - (var_26_4 - 1) / 2))
		var_26_5:setPositionY(var_26_2 - 140)

		var_26_5.count = iter_26_1.count

		self.rootpanel:addChild(var_26_5, 10)

		var_26_5[iter_26_0] = var_26_5

		local var_26_6 = cc.Label:createWithTTF(iter_26_1.label or L_ITEM_SURE_BTN, FONT_BUTTON, 30)

		var_26_6:setColor(cc.c3b(41, 49, 58))
		var_26_6:setName("openLabel")
		var_26_6:setPosition(var_26_5:getContentSize().width / 2, var_26_5:getContentSize().height / 2 - 5)
		var_26_5:addChild(var_26_6)
		var_26_5:addTouchEventListener(function(arg_27_0, arg_27_1)
			if arg_27_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_27_0:isBright() then
				return
			end

			if iter_26_1.surecallback then
				iter_26_1.surecallback(arg_27_0, arg_27_1, function()
					LayerManager:removePopLayer(self.__queueindex)
				end)
			end
		end)
	end
end

function PopItemLayer:changeWeaponName()
	if item_data[self.itemid].bag_item_type == kITEM_EQUIPMENT then
		local var_29_0, var_29_1 = string.find(item_data[self.itemid].name, "·", 1)

		if var_29_0 then
			if self.Strength_Icon and self.Strength_Icon:getChildByName("itemName") then
				self.Strength_Icon:getChildByName("itemName"):setString((string.sub(item_data[self.itemid].name, 1, var_29_0 - 1)))
			end
		end
	end
end

function PopItemLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)

		if self.msg.cancelcallback then
			self.msg.cancelcallback()
		end
	end)
end
