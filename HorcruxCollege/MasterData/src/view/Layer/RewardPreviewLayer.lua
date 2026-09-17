local RewardPreviewLayer = class("RewardPreviewLayer", (require("view.Layer.BaseUILayer")))

require("view.Sprite.ItemSprite")

local TempWidget = require("view.Sprite.TempWidget")
local var_0_2 = config._DEBUG and 0 or 1
local var_0_3 = "RewardPreviewLayer/"
local TableViewEx = require("view.Sprite.TableViewEx")
local var_0_5 = 180
local var_0_6 = 3

function RewardPreviewLayer:ctor()
	RewardPreviewLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller/reward_preview_manager"):getInstance()
end

function RewardPreviewLayer:create(arg_2_1, arg_2_2)
	local var_2_0 = RewardPreviewLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1, arg_2_2) then
		return var_2_0
	end

	return nil
end

function RewardPreviewLayer:onEnter()
	RewardPreviewLayer.super.onEnter(self)
	self._bg:setScaleY(0.01)
	self._bg:runAction(cc.ScaleTo:create(0.2, 1, 1))
end

function RewardPreviewLayer:onExit()
	RewardPreviewLayer.super.onExit(self)
end

function RewardPreviewLayer:init(arg_5_1, arg_5_2)
	self._data = arg_5_1 or {}
	self._upServants = arg_5_2

	self:initLayer()
	self:initListener()

	return true
end

function RewardPreviewLayer:initLayer()
	local var_6_0 = TempWidget:CreateTempLayout(self)

	var_6_0:_setBack()
	var_6_0:setBackGroundColorOpacity(100)
	var_6_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_6_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_6_0

	local var_6_1 = TempWidget:CreateTempImg(var_0_3 .. "bg_reward.png", var_6_0)

	var_6_1:center()
	var_6_1:_addEvent(function()
		return
	end)

	self._bg = var_6_1

	local var_6_2 = cc.size(var_6_1:size().w - 40, var_6_1:size().h - 250)
	local var_6_3 = math.ceil(#self._data / var_0_6)
	local var_6_4 = TableViewEx:create({
		size = var_6_2,
		cellSizeForTable = function()
			return var_6_2.width, var_0_5
		end,
		tableCellAtIndex = function(self, arg_9_1)
			local var_9_0 = self:dequeueCell() or cc.TableViewCell:new()

			var_9_0:removeAllChildren()
			var_9_0:addChild((self:createCell(arg_9_1 + 1)))

			return var_9_0
		end,
		numberOfCellsInTableView = function(arg_10_0)
			return var_6_3
		end,
		direction = cc.SCROLLVIEW_DIRECTION_VERTICAL
	})

	var_6_1:addChild(var_6_4)
	var_6_4:setPosition(cc.p(20, 200))
	self:initUpServant()
end

function RewardPreviewLayer:initListener()
	self._root:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
end

function RewardPreviewLayer:createCell(arg_13_1)
	local var_13_0 = self._bg:size().w - 40
	local var_13_1 = TempWidget:CreateTempLayout()

	var_13_1:setContentSize(cc.size(var_13_0, var_0_5))

	var_13_1._children = {}

	local var_13_2

	for iter_13_0 = 1, var_0_6 do
		local var_13_3 = self._data[(arg_13_1 - 1) * var_0_6 + iter_13_0]

		if self._data[(arg_13_1 - 1) * var_0_6 + iter_13_0] then
			local var_13_4 = ItemSprite:createNewWithItemId(self._data[(arg_13_1 - 1) * var_0_6 + iter_13_0].id, self._data[(arg_13_1 - 1) * var_0_6 + iter_13_0].count)

			var_13_4:setSwallowTouches(false)
			var_13_4:setAnchorPoint(cc.p(0, 0.5))
			var_13_4:setScale(0.7)
			var_13_1:addChild(var_13_4)

			if not var_13_2 then
				local var_13_5 = var_13_4:getContentSize().width * var_13_4:getScale()

				var_13_2 = (var_13_0 - var_13_5 * 3) / 2 + var_13_5
			end

			var_13_4:setPosition(cc.p(0 + (iter_13_0 - 1) * var_13_2, var_13_1:size().h / 2))
			var_13_4:addSpriteTouchEventListener(function(arg_14_0, arg_14_1)
				if arg_14_1 == ccui.TouchEventType.ended then
					LayerManager:pushInLayer("PopItemLayer", {
						itemid = var_13_3.id
					})
				end
			end)

			var_13_1._children[iter_13_0] = var_13_4
		end
	end

	return var_13_1
end

function RewardPreviewLayer:initUpServant()
	if not self._upServants then
		return
	end

	local var_15_0 = ccui.ImageView:create("weeklytower/reward_up.png", var_0_2)

	var_15_0:setPosition(20, 163)
	var_15_0:setAnchorPoint(0, 0)
	self._bg:addChild(var_15_0)

	local var_15_1 = cc.Label:createWithTTF(L_TOWER_SERVANT_DROPUP, FONT_NAME, 20)

	var_15_1:setPosition(138, 170)
	var_15_1:setAnchorPoint(0, 0)
	self._bg:addChild(var_15_1)

	local var_15_2 = ccui.Layout:create()

	var_15_2:setContentSize(cc.size(462, 140))
	var_15_2:setAnchorPoint(0, 0)
	var_15_2:setPosition(0, 10)
	self._bg:addChild(var_15_2)

	for iter_15_0, iter_15_1 in ipairs(self._upServants) do
		local var_15_3 = ccui.ImageView:create("roleimage/role/portrait/" .. iter_15_1 .. ".png")

		var_15_3:setScale(0.8)
		var_15_2:addChild(var_15_3)
		var_15_3:setPosition(-10 + 90 * iter_15_0, 80)
		var_15_3:setTouchEnabled(true)
		var_15_3:addTouchEventListener(function(arg_16_0, arg_16_1)
			if arg_16_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("SoulsLayer", {
				showtype = 6,
				layertype = "DropDetailsLayer",
				cursoul = tonumber(iter_15_1)
			})
		end)
	end
end

function RewardPreviewLayer:updateLayer()
	return
end

function RewardPreviewLayer:updateRed()
	return
end

return RewardPreviewLayer
