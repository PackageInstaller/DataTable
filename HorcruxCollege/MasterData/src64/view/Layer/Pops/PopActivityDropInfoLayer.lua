PopActivityDropInfoLayer = class("PopActivityDropInfoLayer", function()
	return PopBaseLayer:create()
end)

function PopActivityDropInfoLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopActivityDropInfoLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

local var_0_0 = 1
local var_0_1 = 2
local var_0_2 = 150
local activity_dropinfo_data = require("data.activity_dropinfo_data")

function PopActivityDropInfoLayer:init(arg_3_1)
	print("open poplayer : PopActivityDropInfoLayer")

	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setContentSize(GameDisplay:getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0, 0.5))
	self.rootLayer:setPositionY(GameDisplay:getScreenSize().height / 2 - GameDisplay.fix_y)
	self:addChild(self.rootLayer)

	self.activityId = arg_3_1.activityId
	self.imgPath = "activitiesRes/activity" .. self.activityId .. "/showlist/"

	self:initData()
	self:initUI(arg_3_1)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" and arg_3_1.exitcallback then
			arg_3_1.exitcallback()
		end
	end)
end

function PopActivityDropInfoLayer:initData()
	self.moduleList = {}

	local var_5_0 = 1

	while activity_dropinfo_data[self.activityId]["module_" .. var_5_0] do
		table.insert(self.moduleList, activity_dropinfo_data[self.activityId]["module_" .. var_5_0])

		var_5_0 = var_5_0 + 1
	end

	local var_5_1 = 1

	self.itemList = {}

	while activity_dropinfo_data[self.activityId]["item_" .. var_5_1] do
		table.insert(self.itemList, activity_dropinfo_data[self.activityId]["item_" .. var_5_1])

		var_5_1 = var_5_1 + 1
	end
end

function PopActivityDropInfoLayer:initUI(arg_6_1)
	self:initExitTouchEvent()
	self:initModuleView()
	self:inititemView()
	self:initSwitchBtn()
end

function PopActivityDropInfoLayer:initExitTouchEvent()
	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_8_0:isBright() then
			return
		end

		arg_8_0:setBright(false)
		self:exit()
	end)

	self.bg = ccui.ImageView:create(self.imgPath .. "bg.png")

	self.bg:setTouchEnabled(true)
	self.bg:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2))
	self.rootLayer:addChild(self.bg)
	self.rootLayer:setScaleY(0)
	self.rootLayer:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1)))
end

function PopActivityDropInfoLayer:initModuleView()
	self.moduleView = cc.TableView:create(cc.size(560, 800))

	self.moduleView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.moduleView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.moduleView:setAnchorPoint(cc.p(0, 0))
	self.moduleView:setPosition(-58, 6)
	self.moduleView:setDelegate()
	self.moduleView:setVisible(false)
	self.bg:addChild(self.moduleView)
	self.moduleView:registerScriptHandler(function(arg_11_0, arg_11_1)
		return 640, var_0_2
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.moduleView:registerScriptHandler(function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_0:dequeueCell()

		if not var_10_0 then
			var_10_0 = cc.TableViewCell:create()

			local var_10_2 = self:createModuleSprite(arg_10_1 + 1)

			var_10_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_10_2:setPosition(cc.p(320, var_0_2 / 2))
			var_10_0:addChild(var_10_2)
		else
			self:updateModuleSprite(var_10_0:getChildByTag(100), arg_10_1 + 1)
		end

		return var_10_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.moduleView:registerScriptHandler(function(arg_12_0, arg_12_1)
		return #self.moduleList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.moduleView:reloadData()
end

function PopActivityDropInfoLayer:createModuleSprite(arg_13_1)
	local var_13_0 = ccui.Button:create(self.imgPath .. "module_" .. arg_13_1 .. ".png", nil, self.imgPath .. "module_" .. arg_13_1 .. ".png")

	var_13_0:setSwallowTouches(false)
	var_13_0:setTag(100)
	var_13_0:addTouchEventListener(function(arg_14_0, arg_14_1)
		if math.abs(arg_14_0:getTouchBeganPosition().y - arg_14_0:getTouchEndPosition().y) > 15 then
			return
		end

		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.moduleList[arg_13_1] == 99999999 then
			return
		end

		goto_complete_system({
			jump_to_system = self.moduleList[arg_13_1]
		})
		AnalyticManager.activityJumpTo({
			module = "activity_drop_info_module",
			activityid = self.activityId,
			jump = self.moduleList[arg_13_1]
		})
	end)

	return var_13_0
end

function PopActivityDropInfoLayer:updateModuleSprite(arg_15_1, arg_15_2)
	arg_15_1:loadTextures(self.imgPath .. "module_" .. arg_15_2 .. ".png", self.imgPath .. "module_" .. arg_15_2 .. ".png", self.imgPath .. "module_" .. arg_15_2 .. ".png")
	arg_15_1:setTag(100)
	arg_15_1:addTouchEventListener(function(arg_16_0, arg_16_1)
		if math.abs(arg_16_0:getTouchBeganPosition().y - arg_16_0:getTouchEndPosition().y) > 15 then
			return
		end

		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.moduleList[arg_15_2] == 99999999 then
			return
		end

		goto_complete_system({
			jump_to_system = self.moduleList[arg_15_2]
		})
		AnalyticManager.activityJumpTo({
			module = "activity_drop_info_module",
			activityid = self.activityId,
			jump = self.moduleList[arg_15_2]
		})
	end)
end

function PopActivityDropInfoLayer:inititemView()
	self.itemView = cc.TableView:create(cc.size(560, 800))

	self.itemView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.itemView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.itemView:setAnchorPoint(cc.p(0, 0))
	self.itemView:setPosition(-58, 6)
	self.itemView:setDelegate()
	self.bg:addChild(self.itemView)
	self.itemView:registerScriptHandler(function(arg_19_0, arg_19_1)
		return 640, var_0_2
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.itemView:registerScriptHandler(function(arg_18_0, arg_18_1)
		local var_18_0 = arg_18_0:dequeueCell()

		if not var_18_0 then
			var_18_0 = cc.TableViewCell:create()

			local var_18_2 = self:createItemSprite(arg_18_1 + 1)

			var_18_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_18_2:setPosition(cc.p(320, var_0_2 / 2))
			var_18_0:addChild(var_18_2)
		else
			self:updateItemSprite(var_18_0:getChildByTag(100), arg_18_1 + 1)
		end

		return var_18_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.itemView:registerScriptHandler(function(arg_20_0, arg_20_1)
		return #self.itemList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.itemView:reloadData()
end

function PopActivityDropInfoLayer:createItemSprite(arg_21_1)
	local var_21_0 = ccui.Button:create(self.imgPath .. "item_" .. arg_21_1 .. ".png", nil, self.imgPath .. "item_" .. arg_21_1 .. ".png")

	var_21_0:setSwallowTouches(false)
	var_21_0:setTag(100)
	var_21_0:addTouchEventListener(function(arg_22_0, arg_22_1)
		if math.abs(arg_22_0:getTouchBeganPosition().y - arg_22_0:getTouchEndPosition().y) > 15 then
			return
		end

		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_22_0 = string.split(self.itemList[arg_21_1], ",")

		if #var_22_0 == 1 then
			LayerManager:pushInLayer("PopGoGainLayer", {
				item = tonumber(var_22_0[1])
			})
			AnalyticManager.activityJumpTo({
				module = "activity_drop_info_item",
				activityid = self.activityId,
				item = var_22_0[1]
			})
		else
			local var_22_1 = self:createDoubleItemSprite(arg_21_1, var_22_0)

			var_22_1:setPosition(cc.p(var_21_0:getContentSize().width / 2, var_21_0:getContentSize().height / 2))
			var_21_0:addChild(var_22_1)
		end
	end)

	return var_21_0
end

function PopActivityDropInfoLayer:createDoubleItemSprite(arg_23_1, arg_23_2)
	local var_23_0 = ccui.Button:create(self.imgPath .. "double_item_" .. arg_23_1 .. ".png", self.imgPath .. "double_item_" .. arg_23_1 .. ".png", self.imgPath .. "double_item_" .. arg_23_1 .. ".png")
	local var_23_1 = ccui.Layout:create()

	var_23_1:setContentSize(cc.size(130, 120))
	var_23_1:setTouchEnabled(true)
	var_23_1:setPosition(cc.p(65, 10))
	var_23_0:addChild(var_23_1)
	var_23_1:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopGoGainLayer", {
			item = tonumber(arg_23_2[1])
		})
		AnalyticManager.activityJumpTo({
			module = "activity_drop_info_item",
			activityid = self.activityId,
			item = arg_23_2[1]
		})
	end)

	local var_23_2 = ccui.Layout:create()

	var_23_2:setContentSize(cc.size(130, 120))
	var_23_2:setPosition(cc.p(270, 10))
	var_23_2:setTouchEnabled(true)
	var_23_0:addChild(var_23_2)
	var_23_2:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopGoGainLayer", {
			item = tonumber(arg_23_2[2])
		})
		AnalyticManager.activityJumpTo({
			module = "activity_drop_info_item",
			activityid = self.activityId,
			item = arg_23_2[2]
		})
	end)
	var_23_0:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_23_0:runAction(cc.RemoveSelf:create())
	end)

	return var_23_0
end

function PopActivityDropInfoLayer:updateItemSprite(arg_27_1, arg_27_2)
	arg_27_1:loadTextures(self.imgPath .. "item_" .. arg_27_2 .. ".png", self.imgPath .. "item_" .. arg_27_2 .. ".png", self.imgPath .. "item_" .. arg_27_2 .. ".png")
	arg_27_1:removeAllChildren()
	arg_27_1:setTag(100)
	arg_27_1:addTouchEventListener(function(arg_28_0, arg_28_1)
		if math.abs(arg_28_0:getTouchBeganPosition().y - arg_28_0:getTouchEndPosition().y) > 15 then
			return
		end

		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_28_0 = string.split(self.itemList[arg_27_2], ",")

		if #var_28_0 == 1 then
			LayerManager:pushInLayer("PopGoGainLayer", {
				item = tonumber(var_28_0[1])
			})
			AnalyticManager.activityJumpTo({
				module = "activity_drop_info_item",
				activityid = self.activityId,
				item = var_28_0[1]
			})
		else
			local var_28_1 = self:createDoubleItemSprite(arg_27_2, var_28_0)

			var_28_1:setPosition(cc.p(arg_27_1:getContentSize().width / 2, arg_27_1:getContentSize().height / 2))
			arg_27_1:addChild(var_28_1)
		end
	end)
end

function PopActivityDropInfoLayer:initSwitchBtn()
	local var_29_0 = ccui.Button:create(self.imgPath .. "btn_switch_module.png", nil, self.imgPath .. "btn_switch_module.png")

	var_29_0:setPosition(cc.p(320, self.bg:getPositionY() - 520))
	self.rootLayer:addChild(var_29_0)

	self.showStat = var_0_1

	var_29_0:addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.showStat == var_0_0 then
			self.moduleView:setVisible(false)
			self.itemView:setVisible(true)

			self.showStat = var_0_1

			var_29_0:loadTextures(self.imgPath .. "btn_switch_module.png", nil, self.imgPath .. "btn_switch_module.png")
		else
			self.moduleView:setVisible(true)
			self.itemView:setVisible(false)

			self.showStat = var_0_0

			var_29_0:loadTextures(self.imgPath .. "btn_switch_item.png", nil, self.imgPath .. "btn_switch_item.png")
		end
	end)
end

function PopActivityDropInfoLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopActivityDropInfoLayer:initBg(arg_33_1)
	local var_33_0 = ccui.Layout:create()

	var_33_0:setTouchEnabled(true)
	var_33_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_33_0:setAnchorPoint(cc.p(0, 0))
	var_33_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_33_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_33_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_33_0:setOpacity(0)
	self:addChild(var_33_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_34_0)
		self:addChild(arg_34_0, -2)
		arg_34_0:setPositionY(arg_34_0:getPositionY() - GameDisplay.fix_y)

		local var_34_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_34_0:setAnchorPoint(cc.p(0, 0))
		var_34_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_34_0, -1)
		self:init(arg_33_1)
		var_33_0:setOpacity(102)
		var_33_0:setTouchEnabled(false)
	end)
end
