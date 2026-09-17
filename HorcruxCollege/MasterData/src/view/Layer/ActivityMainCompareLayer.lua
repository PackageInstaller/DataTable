ActivityMainCompareLayer = class("ActivityMainCompareLayer", function()
	return ccui.Layout:create()
end)

local var_0_0 = 640
local var_0_1 = 140
local network = require("network.network")

function ActivityMainCompareLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityMainCompareLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityMainCompareLayer:init(arg_3_1)
	self.rootlayer = cc.Layer:create()

	self:addChild(self.rootlayer)

	arg_3_1 = {}
	arg_3_1.activityId = 593
	self.activityid = arg_3_1.activityId
	self.resPath = "activitiesRes/activity" .. arg_3_1.activityId .. "/activitywar/entrance/"
	self.bg = ccui.ImageView:create(self.resPath .. "bg.png")

	self.bg:setPosition(0, -GameDisplay.fix_y)
	self.bg:setAnchorPoint(0, 0)
	self.rootlayer:addChild(self.bg)
	self:initTitle()
	self:initTableView()
	self:initBottom()
end

function ActivityMainCompareLayer:initTitle()
	local var_4_0 = ccui.ImageView:create(self.resPath .. "head.png")

	self.rootlayer:addChild(var_4_0)
	var_4_0:setAnchorPoint(0, 1)
	var_4_0:setPosition(0, GameDisplay.origin_design_y + GameDisplay.fix_y)

	local var_4_1 = ccui.Button:create(self.resPath .. "title.png", nil, self.resPath .. "title.png")

	var_4_0:addChild(var_4_1)
	var_4_1:setAnchorPoint(0, 0.5)
	var_4_1:setPosition(0, var_4_1:getContentSize().height / 2)
	var_4_1:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityMainCompareLayer_" .. self.activityid
		})
	end)
end

function ActivityMainCompareLayer:initBottom()
	local var_6_0 = ccui.ImageView:create(self.resPath .. "bg_list.png")

	self.rootlayer:addChild(var_6_0)
	var_6_0:setPosition(0, -GameDisplay.fix_y)
	var_6_0:setAnchorPoint(0, 0)

	local var_6_1 = ccui.Button:create(self.resPath .. "btn_back.png", nil, self.resPath .. "btn_back.png")

	var_6_1:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	var_6_1:setPosition(50, 38)
	var_6_0:addChild(var_6_1)
end

function ActivityMainCompareLayer:initTableView()
	local var_8_0 = cc.TableView:create(cc.size(640, 956 + GameDisplay.fix_y * 2))

	var_8_0:setPosition(cc.p(10, 100))
	var_8_0:setDelegate()
	var_8_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.bg:addChild(var_8_0)
	var_8_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_BOTTOMUP)
	var_8_0:registerScriptHandler(function(arg_10_0, arg_10_1)
		return var_0_0, var_0_1
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_8_0:registerScriptHandler(function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_0:dequeueCell()

		if not var_9_0 then
			var_9_0 = cc.TableViewCell:create()

			local var_9_1 = self:createNode(arg_9_1 + 1)

			var_9_1:setName("node")
			var_9_1:setPosition(0, var_0_1 / 2)
			var_9_0:addChild(var_9_1)
		else
			local var_9_2 = var_9_0:getChildByName("node")

			var_9_2:setOpacity(255)
			self:updateNode(var_9_2, arg_9_1 + 1)
		end

		var_9_0:setLocalZOrder(arg_9_1)

		return var_9_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_8_0:registerScriptHandler(function(arg_11_0, arg_11_1)
		return 10
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	var_8_0:reloadData()
	var_8_0:setContentOffset(cc.p(0, 0))
end

function ActivityMainCompareLayer:createNode(arg_12_1)
	local var_12_0 = cc.Node:create()
	local var_12_1 = ccui.Button:create(self.resPath .. "btn_level.png", nil, self.resPath .. "btn_level_lock.png")

	var_12_0:addChild(var_12_1)
	var_12_1:setName("btnLevel")
	var_12_1:setLocalZOrder(99)

	local var_12_2

	if arg_12_1 % 2 == 1 then
		var_12_2 = ccui.ImageView:create(self.resPath .. "line1.png")

		var_12_2:setPosition(-140 + var_12_1:getContentSize().width / 2, 40 + var_12_1:getContentSize().height / 2)
		var_12_1:setPosition(460, 0)
	else
		var_12_2 = ccui.ImageView:create(self.resPath .. "line2.png")

		var_12_2:setPosition(190 + var_12_1:getContentSize().width / 2, 60 + var_12_1:getContentSize().height / 2)
		var_12_1:setPosition(130, 0)
	end

	var_12_2:setName("line")
	var_12_2:setLocalZOrder(-99)
	var_12_1:addChild(var_12_2)
	var_12_1:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		AnalyticManager.clickCompareGame({
			ctype = "enter",
			level = arg_12_1
		})
		LayerManager:switchShowLayer("ActivityCompareLayer", {
			level = arg_12_1,
			activityid = self.activityid
		})
	end)

	local var_12_3 = cc.Label:createWithTTF(L_LEVELS .. arg_12_1, FONT_NAME, 30)

	var_12_1:addChild(var_12_3)
	var_12_3:setName("label")
	var_12_3:setPosition(var_12_1:getContentSize().width / 2, var_12_1:getContentSize().height / 2)

	if arg_12_1 == 10 then
		var_12_2:setVisible(false)
	else
		var_12_2:setVisible(true)
	end

	return var_12_0
end

function ActivityMainCompareLayer:updateNode(arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1:getChildByName("btnLevel")
	local var_14_1 = var_14_0:getChildByName("line")

	arg_14_1:getChildByName("btnLevel"):getChildByName("label"):setString(L_LEVELS .. arg_14_2)

	if arg_14_2 % 2 == 1 then
		var_14_1:loadTexture(self.resPath .. "line1.png")
		var_14_1:setPosition(-140 + var_14_0:getContentSize().width / 2, 40 + var_14_0:getContentSize().height / 2)
		var_14_0:setPosition(460, 0)
	else
		var_14_1:loadTexture(self.resPath .. "line2.png")
		var_14_1:setPosition(190 + var_14_0:getContentSize().width / 2, 60 + var_14_0:getContentSize().height / 2)
		var_14_0:setPosition(130, 0)
	end

	var_14_0:setLocalZOrder(100)
	var_14_1:setLocalZOrder(-99)

	if arg_14_2 == 10 then
		var_14_1:setVisible(false)
	else
		var_14_1:setVisible(true)
	end

	var_14_0:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		AnalyticManager.clickCompareGame({
			type = "enter",
			level = arg_14_2
		})
		LayerManager:switchShowLayer("ActivityCompareLayer", {
			level = arg_14_2,
			activityid = self.activityid
		})
	end)
end

function ActivityMainCompareLayer:getTimes(arg_16_1)
	print("getttttttttttt", self.activityid)
	network:rpc("get_activity_bidaxiao_info", {
		activityid = self.activityid
	}, function(arg_17_0)
		print(dump(arg_17_0), "msggggggg")

		if arg_17_0.result == 1 then
			self.remain = arg_17_0.remain

			arg_16_1()
		end
	end)
end
