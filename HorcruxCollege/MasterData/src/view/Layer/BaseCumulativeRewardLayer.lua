local BaseCumulativeRewardLayer = class("BaseCumulativeRewardLayer", (require("view.Layer.BaseUILayer")))
local TempWidget = require("view.Sprite.TempWidget")
local QuickCell = require("view.Sprite.QuickCell")
local GoodsItem = require("view.Sprite.GoodsItem")
local item_data = require("data.item_data")
local var_0_5 = config._DEBUG and 0 or 1

BaseCumulativeRewardLayer.CellRewardState = {
	Completed_Unclaimed = 1,
	Received = 2,
	Incomplete = 0
}
BaseCumulativeRewardLayer.AccumulateDisplayType = {
	Text = 1,
	ImageView = 2
}

function BaseCumulativeRewardLayer:ctor()
	BaseCumulativeRewardLayer.super.ctor(self)

	self.data = {}
	self.designSize = cc.size(580, 840)
	self.viewSize = cc.size(self.designSize.width, self.designSize.height)
	self.cellSize = cc.size(self.designSize.width, 240)
	self.rewardsViewParam = {
		size = cc.size(self.cellSize.width - 50, self.cellSize.height - 50),
		pos = cc.p(self.cellSize.width - 20, self.cellSize.height / 2),
		anchorPoint = cc.p(1, 0.5)
	}
	self.targetNumParam = {
		size = 50,
		des = "%s",
		pos = cc.p(self.cellSize.width - 10, self.cellSize.height - 10),
		font = FONT_NAME,
		anchorPoint = cc.p(1, 1)
	}
	self.progressImg = {
		dark = "CostumeRoomRewardLayer/dark_pro.png",
		light = "CostumeRoomRewardLayer/light_pro.png"
	}
	self.completeImg = {
		complete = "CostumeRoomRewardLayer/icon_complete.png",
		unfinished = "CostumeRoomRewardLayer/icon_unfinished.png"
	}
	self.accumulateDisplayParam = {
		imgDark = "CostumeRoomRewardLayer/accumulate_dark.png",
		size = 50,
		imgLight = "CostumeRoomRewardLayer/accumulate_light.png",
		des = "累计获得",
		type = self.AccumulateDisplayType.ImageView,
		font = FONT_DES,
		anchorPoint = cc.p(0, 1),
		pos = cc.p(50, self.cellSize.height - 20)
	}
	self.bgParam = {
		[self.CellRewardState.Incomplete] = "CostumeRoomRewardLayer/bg_unfinished.png",
		[self.CellRewardState.Completed_Unclaimed] = "CostumeRoomRewardLayer/bg_complete.png",
		[self.CellRewardState.Received] = "CostumeRoomRewardLayer/bg_complete.png",
		anchorPoint = cc.p(1, 0.5),
		pos = cc.p(self.cellSize.width - 10, self.cellSize.height / 2)
	}
	self.bgMaskParam = {
		path = "CostumeRoomRewardLayer/complete_mask.png",
		isShow = false
	}
	self.rewardBtnParam = {
		[self.CellRewardState.Incomplete] = "CostumeRoomRewardLayer/incomplete_btn.png",
		[self.CellRewardState.Completed_Unclaimed] = "CostumeRoomRewardLayer/completed_unclaimed_btn.png",
		[self.CellRewardState.Received] = "CostumeRoomRewardLayer/received_btn.png",
		anchorPoint = cc.p(1, 0.5),
		pos = cc.p(self.cellSize.width - 10, self.cellSize.height / 2)
	}
	self.rewardItemParam = {
		medalScale = 1,
		itemScale = 0.5,
		itemLayoutsize = cc.size(100, 100)
	}
end

function BaseCumulativeRewardLayer:create()
	local var_2_0 = BaseCumulativeRewardLayer.new()

	if var_2_0 and var_2_0:init() then
		return var_2_0
	end

	return nil
end

function BaseCumulativeRewardLayer:onEnter()
	BaseCumulativeRewardLayer.super.onEnter(self)
end

function BaseCumulativeRewardLayer:onExit()
	BaseCumulativeRewardLayer.super.onExit(self)
end

function BaseCumulativeRewardLayer:init()
	self:initLayer()
	self:initListener()

	return true
end

function BaseCumulativeRewardLayer:initLayer()
	self._root = TempWidget:CreateTempLayout(self)

	self._root:setContentSize(self.designSize)

	local var_6_0 = TempWidget:CreateTempListView(self._root)

	var_6_0:setContentSize(self.viewSize)
	var_6_0:move(0, 0)

	self.listView = var_6_0

	for iter_6_0 = 1, #self.data do
		local var_6_1 = QuickCell:Create({
			wid = self.cellSize.width,
			hei = self.cellSize.height,
			createCell = function()
				return self:createCell(iter_6_0)
			end
		})

		if var_6_1:IsActive() then
			local var_6_2 = cc.Node:create()

			var_6_1:addChild(var_6_2)
			var_6_1:setVisible(false)
			var_6_1:setOpacity(0)
			var_6_2:runAction(cc.Sequence:create(cc.DelayTime:create(iter_6_0 * 0.1), cc.CallFunc:create(function()
				var_6_1:setVisible(true)
				var_6_1:runAction(cc.FadeIn:create(0.1))
			end)))
		end

		var_6_0:pushBackCustomItem(var_6_1)
	end
end

function BaseCumulativeRewardLayer:createCell(arg_9_1)
	local var_9_0 = TempWidget:CreateTempLayout()

	var_9_0:setName("cell")
	var_9_0:setContentSize(self.cellSize)

	var_9_0._childData = {}

	local var_9_1 = self.data[arg_9_1]
	local var_9_2 = self:getState(arg_9_1)
	local var_9_3 = 50
	local var_9_4 = self:getProgressByIndex(arg_9_1)
	local var_9_5 = TempWidget:CreateTempImg(self.bgParam[var_9_2], var_9_0)

	var_9_5:align(self.bgParam.anchorPoint, self.bgParam.pos)

	var_9_0._childData.bg = var_9_5

	local var_9_6 = TempWidget:CreateTempBtn(self.rewardBtnParam[var_9_2], var_9_0)

	var_9_6:align(self.rewardBtnParam.anchorPoint, self.rewardBtnParam.pos)
	var_9_6:_addEvent(function()
		self:rewardBtnHandler(arg_9_1)
	end, {
		touchDelay = 1
	})
	var_9_6:setSwallowTouches(false)

	var_9_0._childData.rewardBtn = var_9_6

	local var_9_7 = TempWidget:CreateTempListView(var_9_0)

	var_9_7:setDirection(ccui.ListViewDirection.horizontal)
	var_9_7:setContentSize(self.rewardsViewParam.size)
	var_9_7:align(self.rewardsViewParam.anchorPoint, self.rewardsViewParam.pos)

	for iter_9_0 = 1, #var_9_1.rewards do
		local var_9_8 = GoodsItem:create(var_9_1.rewards[iter_9_0])

		var_9_8:setButtonSwallowTouches(false)

		if item_data[var_9_1.rewards[iter_9_0].itemId] and item_data[var_9_1.rewards[iter_9_0].itemId].bag_item_type == kITEM_MEDAL then
			var_9_8:setScale(self.rewardItemParam.medalScale or 1)
		else
			var_9_8:setScale(self.rewardItemParam.itemScale or 0.5)
		end

		local var_9_11 = TempWidget:CreateTempLayout()

		var_9_11:setContentSize(self.rewardItemParam.itemLayoutsize)
		var_9_11:addChild(var_9_8)
		var_9_8:align(cc.p(0.5, 0.5), var_9_11:size().w / 2, var_9_11:size().h / 2)
		var_9_7:pushBackCustomItem(var_9_11)
	end

	local var_9_12 = TempWidget:CreateTempImg(self.bgMaskParam.path, var_9_0)

	var_9_12:align(self.bgParam.anchorPoint, self.bgParam.pos)
	var_9_12:hide()

	var_9_0._childData.bgMask = var_9_12

	if var_9_2 == self.CellRewardState.Received and self.bgMaskParam.isShow then
		var_9_12:show()
	end

	local var_9_13 = var_0_5 == 1 and cc.Sprite:createWithSpriteFrameName(self.progressImg.dark) or cc.Sprite:create(self.progressImg.dark)

	var_9_13:setScaleX((var_9_13:getContentSize().width - 2) / var_9_13:getContentSize().width)
	var_9_13:setScaleY(var_9_0:size().h / var_9_13:getContentSize().height)
	var_9_13:setAnchorPoint(cc.p(0.5, 1))
	var_9_13:setPosition(cc.p(10, var_9_0:size().h))
	var_9_0:addChild(var_9_13)

	local var_9_14 = var_0_5 == 1 and cc.Sprite:createWithSpriteFrameName(self.progressImg.light) or cc.Sprite:create(self.progressImg.light)
	local var_9_15 = cc.ProgressTimer:create(var_9_14)

	var_9_15:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	var_9_15:setMidpoint(cc.p(0, 1))
	var_9_15:setBarChangeRate(cc.p(0, 1))
	var_9_15:setAnchorPoint(cc.p(0.5, 1))
	var_9_15:setPosition(cc.p(var_9_13:getPositionX(), var_9_0:size().h))
	var_9_15:setPercentage(var_9_0:size().h / var_9_14:getContentSize().height * var_9_4)
	var_9_0:addChild(var_9_15)

	local var_9_16 = TempWidget:CreateTempImg(self.completeImg.unfinished, var_9_0)

	if var_9_3 <= var_9_4 then
		var_9_16:loadTextureEx(self.completeImg.complete)
	end

	var_9_16:align(cc.p(0.5, 0.5), cc.p(var_9_13:getPositionX(), var_9_0:size().h / 2))

	if self.accumulateDisplayParam.type == self.AccumulateDisplayType.ImageView then
		local var_9_17 = TempWidget:CreateTempImg(self.accumulateDisplayParam.imgDark, var_9_0)

		if var_9_3 <= var_9_4 then
			var_9_17:loadTextureEx(self.accumulateDisplayParam.imgLight)
		end

		var_9_17:align(self.accumulateDisplayParam.anchorPoint, self.accumulateDisplayParam.pos)

		var_9_0._childData.accumulateDisplayImg = var_9_17
	end

	local var_9_18 = TempWidget:CreateTempLabel(string.format(self.targetNumParam.des, var_9_1.needCumulativeNumber), self.targetNumParam.font, self.targetNumParam.size, var_9_0)

	var_9_18:_setColor(self.targetNumParam.color or "#ffffff")
	var_9_18:align(self.targetNumParam.anchorPoint, self.targetNumParam.pos)

	var_9_0._childData.needCumulativeNumberText = var_9_18

	return var_9_0
end

function BaseCumulativeRewardLayer:initListener()
	return
end

function BaseCumulativeRewardLayer:updateCell(arg_12_1)
	local var_12_0 = self.listView:getChildren()

	if var_12_0 and var_12_0[arg_12_1] and var_12_0[arg_12_1]:IsEnter() then
		local var_12_1 = ui_delegate(var_12_0[arg_12_1]).cell._childData
		local var_12_2 = self:getState(arg_12_1)

		var_12_1.bg:loadTextureEx(self.bgParam[var_12_2])
		var_12_1.rewardBtn:loadTextureNormal(self.rewardBtnParam[var_12_2], var_0_5)

		if self.bgMaskParam.isShow then
			var_12_1.bgMask:show()
		end

		if self.accumulateDisplayParam.type == self.AccumulateDisplayType.ImageView then
			var_12_1.accumulateDisplayImg:loadTextureEx(self.accumulateDisplayParam.imgLight)
		end
	end
end

function BaseCumulativeRewardLayer:getProgressByIndex(arg_13_1)
	local var_13_0 = 0
	local var_13_2 = self:getCurCumulativeNumber()

	if var_13_2 >= self.data[arg_13_1].needCumulativeNumber then
		var_13_0 = arg_13_1 == #self.data and 50 or var_13_2 - self.data[arg_13_1].needCumulativeNumber > (self.data[arg_13_1 + 1].needCumulativeNumber - self.data[arg_13_1].needCumulativeNumber) / 2 and 100 or (var_13_2 - self.data[arg_13_1].needCumulativeNumber) / (self.data[arg_13_1 + 1].needCumulativeNumber - self.data[arg_13_1].needCumulativeNumber) * 100 + 50
	else
		local var_13_4 = 0

		if arg_13_1 ~= 1 then
			var_13_4 = self.data[arg_13_1 - 1].needCumulativeNumber
		end

		local var_13_5 = self.data[arg_13_1].needCumulativeNumber - var_13_4

		var_13_0 = arg_13_1 == 1 and (var_13_2 - var_13_4) / var_13_5 * 100 / 2 or var_13_2 - var_13_4 > var_13_5 / 2 and (var_13_2 - var_13_4) / var_13_5 * 100 - 50 or 0
	end

	return var_13_0
end

function BaseCumulativeRewardLayer:updateLayer()
	return
end

function BaseCumulativeRewardLayer:getCurCumulativeNumber()
	return 25
end

function BaseCumulativeRewardLayer:getState(arg_16_1)
	return self.CellRewardState.Incomplete
end

function BaseCumulativeRewardLayer:rewardBtnHandler(arg_17_1)
	return
end

return BaseCumulativeRewardLayer
