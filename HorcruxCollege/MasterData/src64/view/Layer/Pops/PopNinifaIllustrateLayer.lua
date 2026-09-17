PopNinifaIllustrateLayer = class("PopNinifaIllustrateLayer", function(arg_1_0)
	return PopBaseLayer:create(arg_1_0)
end)

require("view.Sprite.ItemSprite")

local activity_manager = require("controller.activity_manager")
local activity_ninifa_manager = require("controller.activity_ninifa_manager")
local var_0_2 = 12
local var_0_3 = 535
local var_0_4 = 500
local var_0_5 = 451
local var_0_6 = 150
local var_0_7 = config._DEBUG and 0 or 1

function PopNinifaIllustrateLayer.create(arg_2_0)
	local var_2_0 = PopNinifaIllustrateLayer.new()

	var_2_0:init()

	return var_2_0
end

function PopNinifaIllustrateLayer:init()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityNinifaPop.json" or "ActivityNinifaPop.ExportJson")

	self:addChild(self.rootLayer)
	self:initUI()
	self:registerActivityEventListener()
	activity_ninifa_manager:getCompoundIllustratedFromSever()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("PopNinifaIllustrateLayer")
		end
	end)
end

function PopNinifaIllustrateLayer.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("PopNinifaIllustrateLayer", activity_manager.activityEventId.ACTIVITY_ILLUSTRATE_UPDATE, function(arg_6_0)
		arg_5_0:initViewWithData()
	end)
end

function PopNinifaIllustrateLayer:initUI()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_3"):setBackGroundImage("mainScenebg/activity/branch11/bg_child.jpg")
	require("view.Sprite.TitleSprite")

	self.titleSprite = TitleSprite:create("ActivityNinifaCompositeLayer/title.png", 2)

	self.titleSprite:setPosition(cc.p(0, GameDisplay.getUiScreenSize().height - 56 - GameDisplay.fix_y))
	self.rootLayer:addChild(self.titleSprite)
	ccui.Helper:seekWidgetByName(self.rootLayer, "title_bg"):getChildByName("title_lbl"):setString(L_ACTIVITY_NINIFA.ILLUSTRATE_TITLE)
	self:initBottomList()
end

function PopNinifaIllustrateLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)

	self.bottomList:setName("bottomlist")
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
	self.rootLayer:addChild(self.bottomList, 2)
end

function PopNinifaIllustrateLayer:initViewWithData()
	local var_10_0, var_10_1 = activity_ninifa_manager:getIllustrateData()

	self.viewPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "view_bg")
	self.tableView = cc.TableView:create(cc.size(var_0_4, var_0_3))

	self.tableView:setDelegate()
	self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.viewPanel:addChild(self.tableView)
	self.tableView:setPositionY(var_0_2)
	self.tableView:registerScriptHandler(function(arg_12_0, arg_12_1)
		return var_0_5, var_0_6
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:registerScriptHandler(function(arg_11_0, arg_11_1)
		local var_11_0 = arg_11_0:dequeueCell()

		if not var_11_0 then
			var_11_0 = cc.TableViewCell:create()

			local var_11_2 = self:createIllustrateSprite(var_10_0[arg_11_1 + 1])

			var_11_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_11_2:setPosition(cc.p(260, var_0_6 / 2))
			var_11_0:addChild(var_11_2)

			if arg_11_1 < 4 then
				local var_11_3 = var_11_2:getContentSize().width * 2

				if arg_11_1 % 2 == 0 then
					var_11_3 = -var_11_3 / 2
				end

				var_11_2:setPositionX(var_11_3)
				var_11_2:runAction((cc.MoveTo:create(LAYER_INTO_TIME * 1.5, cc.p(260, (var_11_2:getPositionY())))))
			end
		else
			self:updateIllustrateSprite(var_11_0:getChildByTag(100), var_10_0[arg_11_1 + 1])
		end

		return var_11_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:registerScriptHandler(function(arg_13_0, arg_13_1)
		return var_10_1
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:reloadData()
end

function PopNinifaIllustrateLayer.createIllustrateSprite(arg_14_0, arg_14_1)
	local var_14_0 = ccui.Button:create("ActivityNinifaCompositeLayer/count_bg.png", nil, "ActivityNinifaCompositeLayer/count_bg.png", var_0_7)

	var_14_0:setScale9Enabled(true)
	var_14_0:setTag(100)
	var_14_0:setCapInsets(cc.rect(10, 10, 10, 10))
	var_14_0:setContentSize(cc.size(var_0_5, 136))

	for iter_14_0 = 1, 3 do
		local var_14_1 = ItemPurchaseSprite:createIllustrateItem(arg_14_1["need_item" .. iter_14_0], arg_14_1.isUnLock)

		var_14_1:setPosition(cc.p(60 + (iter_14_0 - 1) * 110, 68))
		var_14_1:setName("need_item" .. iter_14_0)
		var_14_1:setScale(0.5)
		var_14_0:addChild(var_14_1)
		var_14_1:setTouchEnabled(true)
		var_14_1:addTouchEventListener(function(arg_15_0, arg_15_1)
			if math.abs(arg_15_0:getTouchBeganPosition().y - arg_15_0:getTouchEndPosition().y) > 50 then
				return
			end

			if arg_15_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_14_1.isUnLock then
				return
			end

			showItemDetails(arg_14_1["need_item" .. iter_14_0])
		end)
	end

	local var_14_2 = ItemPurchaseSprite:createIllustrateItem(arg_14_1.result_item, arg_14_1.isUnLock)

	var_14_2:setPosition(cc.p(390, 68))
	var_14_2:setName("result_item")
	var_14_2:setScale(0.5)
	var_14_0:addChild(var_14_2)
	var_14_2:setTouchEnabled(true)
	var_14_2:addTouchEventListener(function(arg_16_0, arg_16_1)
		if math.abs(arg_16_0:getTouchBeganPosition().y - arg_16_0:getTouchEndPosition().y) > 50 then
			return
		end

		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_14_1.isUnLock then
			return
		end

		showItemDetails(arg_14_1.result_item)
	end)

	for iter_14_1 = 1, 2 do
		local var_14_3 = ccui.ImageView:create("ActivityNinifaCompositeLayer/add_small.png", var_0_7)

		var_14_3:setPosition(cc.p(115 + (iter_14_1 - 1) * 110, 67))
		var_14_0:addChild(var_14_3)
	end

	local var_14_4 = ccui.ImageView:create("ActivityNinifaCompositeLayer/goto.png", var_0_7)

	var_14_4:setPosition(cc.p(335, 67))
	var_14_0:addChild(var_14_4)
	var_14_0:setTouchEnabled(true)
	var_14_0:setSwallowTouches(false)
	var_14_0:addTouchEventListener(function(arg_17_0, arg_17_1)
		if math.abs(arg_17_0:getTouchBeganPosition().y - arg_17_0:getTouchEndPosition().y) > 50 then
			return
		end

		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_14_1.isUnLock then
			return
		end

		activity_manager:fireEvent(activity_manager.activityEventId.NEED_DIRECT_GOTO_COMPOUD, {
			data = arg_14_1
		})
	end)

	return var_14_0
end

function PopNinifaIllustrateLayer.updateIllustrateSprite(arg_18_0, arg_18_1, arg_18_2)
	arg_18_1:setTag(100)

	for iter_18_0 = 1, 3 do
		local var_18_0 = arg_18_1:getChildByName("need_item" .. iter_18_0)

		var_18_0:updateIllustrateItem(arg_18_2["need_item" .. iter_18_0], arg_18_2.isUnLock)
		var_18_0:addTouchEventListener(function(arg_19_0, arg_19_1)
			if math.abs(arg_19_0:getTouchBeganPosition().y - arg_19_0:getTouchEndPosition().y) > 50 then
				return
			end

			if arg_19_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_18_2.isUnLock then
				return
			end

			showItemDetails(arg_18_2["need_item" .. iter_18_0])
		end)
	end

	local var_18_1 = arg_18_1:getChildByName("result_item")

	var_18_1:updateIllustrateItem(arg_18_2.result_item, arg_18_2.isUnLock)
	var_18_1:addTouchEventListener(function(arg_20_0, arg_20_1)
		if math.abs(arg_20_0:getTouchBeganPosition().y - arg_20_0:getTouchEndPosition().y) > 50 then
			return
		end

		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_18_2.isUnLock then
			return
		end

		showItemDetails(arg_18_2.result_item)
	end)
	arg_18_1:addTouchEventListener(function(arg_21_0, arg_21_1)
		if math.abs(arg_21_0:getTouchBeganPosition().y - arg_21_0:getTouchEndPosition().y) > 50 then
			return
		end

		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_18_2.isUnLock then
			return
		end

		activity_manager:fireEvent(activity_manager.activityEventId.NEED_DIRECT_GOTO_COMPOUD, {
			data = arg_18_2
		})
	end)
end
