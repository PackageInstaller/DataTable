local flyChessLevelRewardLayer = class("flyChessLevelRewardLayer", (require("view.Layer.BaseUILayer")))
local texture_manager = require("controller.texture_manager")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_3 = config._DEBUG and 0 or 1
local component_manager = require("controller.component_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local activity_manager = require("controller.activity_manager")
local flyChessUtility = require("view.Layer.flyChess.flyChessUtility")

require("view.Sprite.ItemSprite")

function flyChessLevelRewardLayer:ctor()
	flyChessLevelRewardLayer.super.ctor(self)
	self:setAutoAdapt(true)
end

function flyChessLevelRewardLayer:create(arg_2_1)
	self.activityId = arg_2_1.activityId
	self.ResPath = "activity_flyChess_" .. self.activityId .. "/"

	local var_2_0 = flyChessLevelRewardLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function flyChessLevelRewardLayer:onEnter()
	flyChessLevelRewardLayer.super.onEnter(self)
end

function flyChessLevelRewardLayer:onExit()
	flyChessLevelRewardLayer.super.onExit(self)
end

function flyChessLevelRewardLayer:init(arg_5_1)
	self.levelDrops = activity_manager:getFlyChessLevelRewards(self.activityId)

	self:initLayer(arg_5_1)
	self:initListener(arg_5_1)

	return true
end

function flyChessLevelRewardLayer:initLayer(arg_6_1)
	local var_6_0 = TempWidget:CreateTempLayout(self)

	var_6_0:_setBack()
	var_6_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_6_0:setBackGroundColorOpacity(100)
	var_6_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_6_0

	local var_6_1 = TempWidget:CreateTempImg(self.ResPath .. "level_boss_rewardBg.png", var_6_0)

	var_6_1:align(cc.p(0.5, 0.5), var_6_0:size().w / 2, var_6_0:size().h / 2 + 50)
	var_6_1:_addEvent(function()
		return
	end)

	self.levelDropView = cc.TableView:create(cc.size(600, 660))

	self.levelDropView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.levelDropView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.levelDropView:setAnchorPoint(cc.p(0, 0))
	self.levelDropView:setPosition(30, 240 + GameDisplay.fix_y)
	self.levelDropView:setDelegate()
	self._root:addChild(self.levelDropView)
	self.levelDropView:registerScriptHandler(function(arg_9_0, arg_9_1)
		return 600, 140
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.levelDropView:registerScriptHandler(function(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_0:dequeueCell()

		if not var_8_0 then
			var_8_0 = cc.TableViewCell:create()

			local var_8_2 = self:createTaskSprite(self.levelDrops[arg_8_1 + 1], arg_8_1 + 1)

			var_8_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_8_2:setPosition(cc.p(GameDisplay.width / 2 - 10, 65))
			var_8_0:addChild(var_8_2)
		else
			self:updateTaskSprite(var_8_0:getChildByTag(100), self.levelDrops[arg_8_1 + 1], arg_8_1 + 1)
		end

		return var_8_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.levelDropView:registerScriptHandler(function(arg_10_0, arg_10_1)
		return #self.levelDrops
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.levelDropView:reloadData()
end

function flyChessLevelRewardLayer:createTaskSprite(arg_11_1, arg_11_2)
	local var_11_0 = ccui.ImageView:create(self.ResPath .. "level_reward_listitem.png", var_0_3)

	var_11_0:setTag(100)

	local var_11_1 = ccui.ImageView:create(self.ResPath .. "mask.png", var_0_3)

	var_11_0:addChild(var_11_1, 2)
	var_11_1:setAnchorPoint(0, 0)
	var_11_1:setName("mask")

	local var_11_2 = activity_manager:getFlychessAllInfo(self.activityId)

	if var_11_2.level then
		var_11_1:setVisible(arg_11_2 < var_11_2.level)
	end

	local var_11_3 = ccui.ListView:create()

	var_11_3:setDirection(ccui.ScrollViewDir.horizontal)
	var_11_3:setContentSize(cc.size(320, 100))
	var_11_3:setPosition(cc.p(175, 15))
	var_11_0:addChild(var_11_3)
	var_11_3:setBackGroundColorOpacity(100)
	var_11_3:setBounceEnabled(true)
	var_11_3:setName("droplist")

	for iter_11_0, iter_11_1 in pairs(drop_manager:getDropMsg(arg_11_1).equips) do
		local var_11_4 = ccui.Layout:create()

		var_11_4:setContentSize(cc.size(95, 100))

		local var_11_5 = ItemSprite:createNewWithItemId(iter_11_1.dropid, iter_11_1.dropNum, nil, iter_11_1.details, iter_11_1.item_attr)

		var_11_5:setPosition(45, 50)
		var_11_5:setScale(0.45)

		local var_11_6 = ccui.Button:create("public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", "", var_0_3)

		var_11_6:setContentSize(cc.size(174, 165))
		var_11_6:setSwallowTouches(false)
		var_11_6:setOpacity(0)
		var_11_6:setAnchorPoint(cc.p(0, 0))
		var_11_6:setColor(cc.c3b(255, 255, 255))
		var_11_6:setTouchEnabled(true)
		var_11_6:setPosition(cc.p(0, 0))
		var_11_5:addChild(var_11_6)
		var_11_6:addTouchEventListener(function(arg_12_0, arg_12_1)
			if arg_12_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_12_0:getTouchBeganPosition().y - arg_12_0:getTouchEndPosition().y) > 30 then
				return
			end

			var_11_5:setTouchEnabled(false)

			if item_data[iter_11_1.dropid].bag_item_type == kITEM_HORCRUX then
				flyChessUtility.showHorcruxDetails(iter_11_1.dropid)
			else
				LayerManager:pushInLayer("PopItemLayer", {
					itemid = iter_11_1.dropid
				})
			end
		end)
		var_11_4:addChild(var_11_5)
		var_11_3:pushBackCustomItem(var_11_4)
	end

	local var_11_7 = TempWidget:CreateTempLabel("区域" .. arg_11_2, FONT_DES, 30, var_11_0)

	var_11_7:align(cc.p(0.5, 0.5), 60, 64)
	var_11_7:setName("levelName")

	return var_11_0
end

function flyChessLevelRewardLayer:updateTaskSprite(arg_13_1, arg_13_2, arg_13_3)
	arg_13_1:setTag(100)
	arg_13_1:getChildByName("levelName"):setString("区域" .. arg_13_3)

	local var_13_0 = arg_13_1:getChildByName("droplist")

	var_13_0:removeAllChildren()

	for iter_13_0, iter_13_1 in pairs(drop_manager:getDropMsg(arg_13_2).equips) do
		local var_13_1 = ccui.Layout:create()

		var_13_1:setContentSize(cc.size(95, 100))

		local var_13_2 = ItemSprite:createNewWithItemId(iter_13_1.dropid, iter_13_1.dropNum, nil, iter_13_1.details, iter_13_1.item_attr)

		var_13_2:setPosition(45, 50)
		var_13_2:setScale(0.45)
		var_13_1:addChild(var_13_2)

		local var_13_3 = ccui.Button:create("public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", "", var_0_3)

		var_13_3:setContentSize(cc.size(174, 165))
		var_13_3:setSwallowTouches(false)
		var_13_3:setOpacity(0)
		var_13_3:setAnchorPoint(cc.p(0, 0))
		var_13_3:setColor(cc.c3b(255, 255, 255))
		var_13_3:setTouchEnabled(true)
		var_13_3:setPosition(cc.p(0, 0))
		var_13_2:addChild(var_13_3)
		var_13_3:addTouchEventListener(function(arg_14_0, arg_14_1)
			if arg_14_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_14_0:getTouchBeganPosition().y - arg_14_0:getTouchEndPosition().y) > 30 then
				return
			end

			var_13_2:setTouchEnabled(false)

			if item_data[iter_13_1.dropid].bag_item_type == kITEM_HORCRUX then
				flyChessUtility.showHorcruxDetails(iter_13_1.dropid)
			else
				LayerManager:pushInLayer("PopItemLayer", {
					itemid = iter_13_1.dropid
				})
			end
		end)
		var_13_0:pushBackCustomItem(var_13_1)
	end

	local var_13_4 = arg_13_1:getChildByName("mask")
	local var_13_5 = activity_manager:getFlychessAllInfo(self.activityId)

	if var_13_5.level then
		var_13_4:setVisible(arg_13_3 < var_13_5.level)
	end
end

function flyChessLevelRewardLayer:initListener(arg_15_1)
	self._root:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
end

function flyChessLevelRewardLayer:updateLayer()
	return
end

function flyChessLevelRewardLayer:updateRed()
	return
end

return flyChessLevelRewardLayer
