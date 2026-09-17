CommonFlopDropDetailsLayer = class("CommonFlopDropDetailsLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = "CommonFlopDropDetailsLayer/"

require("view.Sprite.ItemSprite")
require("view.Layer.EquipLayer")
require("view.Layer.DetailsofHelpGirlLayer")
require("view.Layer.WeaponLayer")

local activity_manager = require("controller.activity_manager")
local component_manager = require("controller.component_manager")
local drop_manager = require("controller.drop_manager")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local var_0_6 = config._DEBUG and 0 or 1

local function var_0_7(arg_2_0)
	local var_2_0 = -1
	local var_2_1 = require("data.horcrux_data")[arg_2_0].horcruxt

	for iter_2_0, iter_2_1 in pairs((require("data.photofile_HelpGirl_data"))) do
		if arg_2_0 == iter_2_1.item_id then
			var_2_0 = iter_2_0

			break
		end
	end

	if var_2_0 == -1 then
		return
	end

	LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
		id = var_2_0,
		itemid = arg_2_0
	})
end

function CommonFlopDropDetailsLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = CommonFlopDropDetailsLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function CommonFlopDropDetailsLayer:init(arg_4_1)
	self.activityId = arg_4_1.activityId
	self.championData = activity_manager:getAllTurnsChampion(self.activityId)
	self.normalData = activity_manager:getNormalReward(self.activityId)

	self:initUI()
	self:initChampionsUI()
	self:initNormalUI()
	self:initBottom()
end

function CommonFlopDropDetailsLayer:initUI()
	self.rootLayer = ccui.ImageView:create(var_0_0 .. "bg.png", var_0_6)

	self:addChild(self.rootLayer)
	self.rootLayer:setAnchorPoint(0, 0)
	self.rootLayer:setPosition(0, 0)
	self.rootLayer:setPositionY(-GameDisplay.fix_y)

	self.topbg = ccui.ImageView:create(var_0_0 .. "top_bg.png", var_0_6)

	self.rootLayer:addChild(self.topbg, 2)
	self.topbg:setAnchorPoint(0, 1)
	self.topbg:setPosition(0, GameDisplay.height)

	local var_5_0 = ccui.ImageView:create(var_0_0 .. "title.png", var_0_6)

	self.rootLayer:addChild(var_5_0, 2)
	var_5_0:setAnchorPoint(0, 1)
	var_5_0:setPosition(0, GameDisplay.height)

	self.list = ccui.ListView:create()

	self.list:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.list:setBounceEnabled(true)
	self.list:setContentSize(600, var_5_0:getPositionY() - 250)
	self.list:setPosition(320, var_5_0:getPositionY() - 110)
	self.list:setAnchorPoint(cc.p(0.5, 1))
	self.list:setItemsMargin(20)
	self.rootLayer:addChild(self.list)
end

function CommonFlopDropDetailsLayer:initChampionsUI()
	local var_6_0 = ccui.ImageView:create(var_0_0 .. "champion_title.png", var_0_6)

	var_6_0:setAnchorPoint(0, 1)
	self.list:pushBackCustomItem(var_6_0)

	local function var_6_1(arg_7_0, arg_7_1)
		local var_7_0 = ccui.ImageView:create(var_0_0 .. "list_bg.png", var_0_6)

		self.list:pushBackCustomItem(var_7_0)

		local var_7_1 = cc.Label:createWithTTF(string.format(L_FLOP_TURNS_IN_DETAILS, arg_7_1), FONT_DES, 30)

		if arg_7_1 == #self.championData then
			var_7_1:setString(string.format(L_FLOP_TURNS_DOWN, arg_7_1))
			var_7_1:setScale(0.7)
		end

		var_7_1:setPosition(100, 80)
		var_7_0:addChild(var_7_1)

		local var_7_2 = cc.TableView:create(cc.size(370, 180))

		var_7_2:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
		var_7_2:setAnchorPoint(cc.p(0, 0))
		var_7_2:setPosition(200, 20)
		var_7_2:setDelegate()
		var_7_0:addChild(var_7_2)
		var_7_2:registerScriptHandler(function(arg_9_0, arg_9_1)
			return 110, 100
		end, cc.TABLECELL_SIZE_FOR_INDEX)
		var_7_2:registerScriptHandler(function(arg_8_0, arg_8_1)
			local var_8_0 = arg_8_0:dequeueCell()

			if not var_8_0 then
				var_8_0 = cc.TableViewCell:create()

				local var_8_2 = self:createChampionsTableSprite(arg_7_0[arg_8_1 + 1], arg_8_1 + 1)

				var_8_2:setAnchorPoint(cc.p(0, 0.5))
				var_8_2:setPosition(cc.p(0, 65))
				var_8_2:setScale(0.8)
				var_8_0:addChild(var_8_2)
			else
				var_8_0:removeAllChildren()

				local var_8_3 = self:createChampionsTableSprite(arg_7_0[arg_8_1 + 1], arg_8_1 + 1)

				var_8_3:setAnchorPoint(cc.p(0, 0.5))
				var_8_3:setPosition(cc.p(0, 65))
				var_8_3:setScale(0.8)
				var_8_0:addChild(var_8_3)
			end

			return var_8_0
		end, cc.TABLECELL_SIZE_AT_INDEX)
		var_7_2:registerScriptHandler(function(arg_10_0, arg_10_1)
			return #arg_7_0
		end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
		var_7_2:reloadData()
	end

	for iter_6_0 = 1, #self.championData do
		local var_6_2 = var_6_1(self.championData[iter_6_0], iter_6_0)
	end
end

function CommonFlopDropDetailsLayer:createChampionsTableSprite(arg_11_1, arg_11_2)
	local var_11_0 = ccui.ImageView:create(var_0_0 .. "championIconBg.png", var_0_6)

	var_11_0:setTag(100)

	local var_11_1, var_11_2, var_11_3 = self:updateIcon(nil, arg_11_1, true)

	var_11_1:setPosition(48, 68)
	var_11_1:setScale(var_11_1:getScale() * 0.85)
	var_11_1:setName("sp")
	var_11_0:addChild(var_11_1)

	local var_11_4 = cc.Label:createWithTTF("", FONT_DES, 20)

	var_11_4:setString("x" .. var_11_2)
	var_11_4:setPosition(50, 12)
	var_11_4:setName("championNum")
	var_11_0:addChild(var_11_4)

	if var_11_3 then
		var_11_0:loadTexture(var_0_0 .. "new_item_bg" .. var_11_3 .. ".png", var_0_6)
	end

	return var_11_0
end

function CommonFlopDropDetailsLayer:initNormalUI()
	local var_12_0 = ccui.ImageView:create(var_0_0 .. "champion_title1.png", var_0_6)

	var_12_0:setAnchorPoint(0, 1)
	self.list:pushBackCustomItem(var_12_0)

	local var_12_1 = ccui.Layout:create()

	var_12_1:setBackGroundImage(var_0_0 .. "normal_bg.png", var_0_6)
	var_12_1:setBackGroundImageScale9Enabled(true)
	var_12_1:setContentSize(620, 200)
	self.list:pushBackCustomItem(var_12_1)

	local var_12_2 = (math.ceil(#self.normalData / 5) + 1) * 148 - 40

	var_12_1:setContentSize(620, var_12_2)

	for iter_12_0 = 1, #self.normalData do
		local var_12_3 = ccui.ImageView:create(var_0_0 .. "championIconBg.png", var_0_6)

		var_12_3:setTouchEnabled(true)
		var_12_3:setPosition((iter_12_0 - 1) % 5 * 117 + 75, var_12_2 - math.ceil(iter_12_0 / 5) * 148 + 20)
		var_12_1:addChild(var_12_3)

		local var_12_4, var_12_5, var_12_6 = self:updateIcon(nil, self.normalData[iter_12_0], true)

		var_12_4:setPosition(50, 62)
		var_12_4:setScale(var_12_4:getScale() * 0.8)
		var_12_3:addChild(var_12_4)

		local var_12_7 = cc.Label:createWithTTF("", FONT_DES, 20)

		var_12_7:setString("x" .. var_12_5)
		var_12_7:setPosition(50, 12)
		var_12_3:addChild(var_12_7)

		if var_12_6 then
			var_12_3:loadTexture(var_0_0 .. "new_item_bg" .. var_12_6 .. ".png", var_0_6)
		end
	end
end

function CommonFlopDropDetailsLayer:initBottom()
	local var_13_0 = BottomBtnList:create(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	var_13_0:setName("bottombg")
	self:addChild(var_13_0)
	var_13_0:setPositionY(-GameDisplay.fix_y)
end

function CommonFlopDropDetailsLayer:updateIcon(arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = drop_manager:getDropMsg(arg_15_2)
	local var_15_1
	local var_15_2

	if var_15_0.gold ~= 0 then
		var_15_1 = "gold"
		var_15_2 = var_15_0.gold
	elseif var_15_0.diamond ~= 0 then
		var_15_1 = "diamond"
		var_15_2 = var_15_0.diamond
	elseif var_15_0.equips then
		for iter_15_0, iter_15_1 in pairs(var_15_0.equips) do
			var_15_1 = iter_15_1.dropid
			var_15_2 = iter_15_1.dropNum
		end
	end

	arg_15_1 = arg_15_1 or ccui.ImageView:create(var_0_0 .. "championIconBg.png", var_0_6)

	if item_data[var_15_1].bag_item_type == kITEM_SKIN then
		arg_15_1:loadTexture("roleimage/role1/" .. model_data[item_data[var_15_1].model].cute_role .. ".png")
		arg_15_1:setScale(0.3)
	elseif item_data[var_15_1].bag_item_type == kITEM_HORCRUX then
		local var_15_4 = drop_manager:getAllDropsNotMerge(arg_15_2)[1].item_attr
		local var_15_5 = ccui.Layout:create()

		var_15_5:setName("starsPanel")
		var_15_5:setScale(1.75)
		var_15_5:setPositionY(58)
		var_15_5:setPositionX(200)
		arg_15_1:addChild(var_15_5, 5)

		local var_15_6 = 0

		if var_15_4 then
			for iter_15_2, iter_15_3 in var_15_4:gmatch("([^&]+)=([^&]+)") do
				if iter_15_2 == "star" then
					var_15_6 = tonumber(iter_15_3)
				end
			end
		end

		for iter_15_4 = 1, var_15_6 do
			local var_15_7

			if config._DEBUG then
				var_15_7 = cc.Sprite:create("public/currency/weapon_star.png") or cc.Sprite:createWithSpriteFrameName("public/currency/weapon_star.png")
			end

			var_15_7:setPosition(25, (iter_15_4 - 1) * 24 - 30)
			var_15_5:addChild(var_15_7)
		end

		arg_15_1:loadTexture("equipment/" .. item_data[var_15_1].image_id .. ".png")
		arg_15_1:setScale(0.3)
	elseif item_data[var_15_1].bag_item_type == kITEM_COMPONENT then
		arg_15_1:removeFromParent()

		arg_15_1 = nil
		arg_15_1 = component_manager:create_component_icon(var_15_1)

		;(nil):setPosition(cc.p(self.championBg:getContentSize().width / 2, self.championBg:getContentSize().height / 2 + 20))
		arg_15_1:setScale(0.75)
	else
		arg_15_1:loadTexture("equipment/" .. item_data[var_15_1].image_id .. ".png")
		arg_15_1:setScale(0.75)
	end

	arg_15_1:setSwallowsTouches(false)
	arg_15_1:setTouchEnabled(arg_15_3)
	arg_15_1:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_data[var_15_1].bag_item_type == kITEM_HORCRUX then
			var_0_7(var_15_1)
		else
			LayerManager:pushInLayer("PopItemLayer", {
				itemid = var_15_1
			})
		end
	end)

	return arg_15_1, var_15_2, item_data[var_15_1].equip_quality
end
