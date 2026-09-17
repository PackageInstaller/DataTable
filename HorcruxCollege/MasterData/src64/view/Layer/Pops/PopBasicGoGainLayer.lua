PopBasicGoGainLayer = class("PopBasicGoGainLayer", function()
	return PopBaseLayer:create()
end)

local item_data = require("data.item_data")
local var_0_1 = 150

function PopBasicGoGainLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopBasicGoGainLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopBasicGoGainLayer:init(arg_3_1)
	self.rootLayer = cc.Layer:create()

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.rootLayer:setTouchEnabled(false)
	self:addChild(self.rootLayer, 2)

	self.itemid = arg_3_1.itemid

	print(string.format("self.itemid is %d", self.itemid))
	print(string.format("self.itemid is %d", self.itemid))
	print(string.format("self.itemid is %d", self.itemid))
	self:initData()
	self:initUI(arg_3_1)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			popstarrewardlayerInstance = false

			if arg_3_1.updateCallback then
				arg_3_1.updateCallback()
			end
		end
	end)
end

function PopBasicGoGainLayer:initData()
	self.itemList = {}

	if self.itemid == nil then
		return
	end

	local var_5_0 = item_data[self.itemid]

	assert(item_data[self.itemid], string.format("没有这个物品，self.itemid is %d", self.itemid))

	while var_5_0["targetlayer" .. 1] do
		table.insert(self.itemList, var_5_0["targetlayer" .. 1])
	end
end

function PopBasicGoGainLayer:initUI()
	self:initBGAndTitle()
	self:addTouchEventMask()
	self:playJoinEffect()
	self:initButtons()
end

function PopBasicGoGainLayer:addTouchEventMask()
	self:createFullScreenMask(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_8_0:isBright() then
			return
		end

		arg_8_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
end

function PopBasicGoGainLayer:playJoinEffect()
	self.rootpanel:setScaleY(0.1)
	self.rootpanel:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 1)))
end

function PopBasicGoGainLayer:initBGAndTitle()
	self.imgPath = "mainScenebg/gogain_basic/itemid_" .. self.itemid
	self.rootpanel = ccui.ImageView:create(self.imgPath .. "/buy_bg.png")

	self.rootpanel:setPosition(cc.p(320, GameDisplay.getScreenSize().height / 2))
	self.rootpanel:setTouchEnabled(true)
	self.rootLayer:addChild(self.rootpanel)

	local var_11_0 = ccui.ImageView:create(self.imgPath .. "/title.png")

	var_11_0:setPosition(cc.p(320, 860))
	self.rootpanel:addChild(var_11_0)

	local var_11_1 = ccui.Layout:create()

	var_11_1:setContentSize(cc.size(GameDisplay.width, 100))
	var_11_1:setAnchorPoint(cc.p(0, 0))
	var_11_1:setPosition(cc.p(0, 0))
	var_11_1:setTouchEnabled(true)
	self.rootLayer:addChild(var_11_1, 20000)
	var_11_1:setTouchEnabled(true)
	var_11_1:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
end

function PopBasicGoGainLayer:initButtons()
	self.itemView = cc.TableView:create(cc.size(600, 630))

	self.itemView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.itemView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.itemView:setAnchorPoint(cc.p(0, 0))
	self.itemView:setPosition(-20, 170)
	self.itemView:setDelegate()
	self.rootpanel:addChild(self.itemView)
	self.itemView:registerScriptHandler(function(arg_16_0, arg_16_1)
		return 520, var_0_1 + 20
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.itemView:registerScriptHandler(function(arg_15_0, arg_15_1)
		local var_15_0 = arg_15_0:dequeueCell()

		if not var_15_0 then
			var_15_0 = cc.TableViewCell:create()

			local var_15_2 = self:createItemSprite(arg_15_1 + 1)

			var_15_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_15_2:setPosition(cc.p(300, var_0_1 / 2))
			var_15_0:addChild(var_15_2)
		else
			self:updateItemSprite(var_15_0:getChildByTag(100), arg_15_1 + 1)
		end

		return var_15_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.itemView:registerScriptHandler(function(arg_17_0, arg_17_1)
		return #self.itemList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.itemView:reloadData()
end

function PopBasicGoGainLayer:createItemSprite(arg_18_1)
	local var_18_0 = string.format("mainScenebg/gogain_basic/itemid_%d/go_gain_%s.png", self.itemid, arg_18_1)
	local var_18_1 = ccui.Button:create(var_18_0, nil, var_18_0)

	var_18_1:setTag(100)
	var_18_1:setSwallowTouches(false)
	var_18_1:addTouchEventListener(function(arg_19_0, arg_19_1)
		if math.abs(arg_19_0:getTouchBeganPosition().y - arg_19_0:getTouchEndPosition().y) > 15 then
			return
		end

		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:onBtnJumpCallback(arg_18_1)
	end)

	return var_18_1
end

function PopBasicGoGainLayer:onBtnJumpCallback(arg_20_1)
	if type(self.itemList[arg_20_1]) == "string" and self.itemList[arg_20_1]:find("buy") then
		self:buyActivityItem(self.itemList[arg_20_1])

		return
	end

	goto_complete_system({
		jump_to_system = self.itemList[arg_20_1]
	})
end

function PopBasicGoGainLayer:updateItemSprite(arg_21_1, arg_21_2)
	local var_21_0 = string.format("mainScenebg/gogain_basic/itemid_%d/go_gain_%s.png", self.itemid, arg_21_2)

	arg_21_1:loadTextures(var_21_0, nil, var_21_0)
	arg_21_1:addTouchEventListener(function(arg_22_0, arg_22_1)
		if math.abs(arg_22_0:getTouchBeganPosition().y - arg_22_0:getTouchEndPosition().y) > 15 then
			return
		end

		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:onBtnJumpCallback(arg_21_2)
	end)
	arg_21_1:setTag(100)
end

function PopBasicGoGainLayer.buyActivityItem(arg_23_0, arg_23_1)
	local var_23_0 = string.split(arg_23_1, "#")

	require("controller.activity_manager"):buyActivityItem(tonumber(var_23_0[1]), (tonumber(string.match(var_23_0[2], "buy_(%d+)"))))
end
