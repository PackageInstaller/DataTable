ActivityNinifaExchangeLayer = class("ActivityNinifaExchangeLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local activity_manager = require("controller.activity_manager")
local activity_ninifa_manager = require("controller.activity_ninifa_manager")

require("view.Sprite.ItemSprite")

local var_0_6 = 800 * GameDisplay:getRelativeScale() * 1.1
local var_0_7 = 640
local var_0_8 = 560
local var_0_9 = 150
local var_0_10 = {
	[0] = {
		"ActivityNinifaExchangeLayer/btn_unfinish_right.png",
		"ActivityNinifaExchangeLayer/btn_unfinish_left.png"
	},
	{
		"ActivityNinifaExchangeLayer/btn_finish_right.png",
		"ActivityNinifaExchangeLayer/btn_finish_left.png"
	}
}

function ActivityNinifaExchangeLayer.create(arg_2_0)
	local var_2_0 = ActivityNinifaExchangeLayer.new()

	var_2_0:init()

	return var_2_0
end

function ActivityNinifaExchangeLayer:init()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityNinifaExchangeLayer.json" or "ActivityNinifaExchangeLayer.ExportJson")

	self:addChild(self.rootLayer)
	self:initUI()
	self:registerActivityEventListener()
	activity_ninifa_manager:getCompoundTotalNumFormServer()
	activity_ninifa_manager:getActivityTaskFormServer()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("ActivityNinifaExchangeLayer")
		end
	end)
end

function ActivityNinifaExchangeLayer.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("ActivityNinifaExchangeLayer", activity_manager.activityEventId.TOTAL_COMPOUND_NUM_UPDATE, function(arg_6_0)
		arg_5_0:updateHaveItemNumLayout(arg_6_0.data)
	end)
	activity_manager:registerEventListener("ActivityNinifaExchangeLayer", activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_7_0)
		arg_5_0:updateTaskListLayout(arg_7_0.data, #arg_7_0.data)
	end)
end

function ActivityNinifaExchangeLayer:initUI()
	self:initBG()
	self:initBottomList()
end

function ActivityNinifaExchangeLayer:initBG()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_bg"):setBackGroundImage("mainScenebg/activity/branch11/bg_child.jpg")
	require("view.Sprite.TitleSprite")

	self.titleSprite = TitleSprite:create("ActivityNinifaExchangeLayer/title.png", 2)

	self.titleSprite:setPosition(cc.p(0, GameDisplay.getUiScreenSize().height - 56 - GameDisplay.fix_y))
	self.rootLayer:addChild(self.titleSprite)
end

function ActivityNinifaExchangeLayer:updateHaveItemNumLayout(arg_10_1)
	local var_10_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "have_num_bg")

	var_10_0:setPositionY(self.titleSprite:getPositionY() - 100)

	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		var_10_0:getChildByName(iter_10_1.id):getChildByName("numLbl"):setString(iter_10_1.num)
	end
end

function ActivityNinifaExchangeLayer:updateTaskListLayout(arg_11_1, arg_11_2)
	if self.tableView then
		self.tableView:removeFromParent()
	end

	if not arg_11_1 or not next(arg_11_1) or arg_11_2 < 1 then
		return
	end

	self.viewPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "view_bg")
	self.tableView = cc.TableView:create(cc.size(var_0_7, var_0_6))

	self.tableView:setDelegate()
	self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableView:setAnchorPoint(cc.p(0.5, 0))
	self.rootLayer:addChild(self.tableView)
	self.tableView:setPositionY(self.bottomList:getPositionY() + 60)
	self.tableView:registerScriptHandler(function(arg_13_0, arg_13_1)
		return var_0_8, var_0_9
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:registerScriptHandler(function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_0:dequeueCell()

		if not var_12_0 then
			var_12_0 = cc.TableViewCell:create()

			local var_12_2 = self:createTaskSprite(arg_11_1[arg_12_1 + 1])

			var_12_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_12_2:setPosition(cc.p(260, var_0_9 / 2))
			var_12_0:addChild(var_12_2)

			if arg_12_1 <= math.floor(4 * GameDisplay:getRelativeScale() * 1.1) then
				local var_12_3 = var_12_2:getContentSize().width * 2

				if arg_12_1 % 2 == 0 then
					var_12_3 = -var_12_3 / 2
				end

				var_12_2:setPositionX(var_12_3)
				var_12_2:runAction((cc.MoveTo:create(LAYER_INTO_TIME * 1.5, cc.p(260, (var_12_2:getPositionY())))))
			end
		else
			self:updateRecordSprite(var_12_0:getChildByTag(100), arg_11_1[arg_12_1 + 1])
		end

		return var_12_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:registerScriptHandler(function(arg_14_0, arg_14_1)
		return arg_11_2
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:reloadData()
end

function ActivityNinifaExchangeLayer.createTaskSprite(arg_15_0, arg_15_1)
	local var_15_0 = ccui.ImageView:create(var_0_10[arg_15_1.status][1], var_0_0)

	var_15_0:setPosition(cc.p(200, 200))
	var_15_0:setName("right_img")
	var_15_0:setTag(100)

	local var_15_1 = ccui.Button:create(var_0_10[arg_15_1.status][2], nil, var_0_10[arg_15_1.status][2], var_0_0)

	var_15_1:setPosition(cc.p(490, 65))
	var_15_0:addChild(var_15_1)
	var_15_1:setName("left_img")
	var_15_1:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_15_1.finished == 1 then
			activity_ninifa_manager:getTaskReward(arg_15_1.taskid)
		else
			LayerManager:switchShowLayer("ActivityNinifaCompositeLayer")
		end
	end)

	local var_15_2 = drop_manager:getAllDrops(arg_15_1.drop)

	if not var_15_2 or not next(var_15_2) then
		var_15_2 = {
			{
				dropid = "gold",
				dropNum = drop_manager:getGold(arg_15_1.drop)
			}
		}
	end

	local var_15_3 = ItemPurchaseSprite:createPurchaseItem(var_15_2[1].dropid, var_15_2[1].dropNum)

	var_15_3:setPosition(cc.p(80, 65))
	var_15_3:setScale(0.6)
	var_15_3:setName("drop_sprite")
	var_15_0:addChild(var_15_3)

	local var_15_4 = cc.Label:createWithTTF(L_ACTIVITY_NINIFA.CUMULATIVE_MANUFACTURING, FONT_NAME, 26)

	var_15_4:setPosition(cc.p(200, 65))
	var_15_0:addChild(var_15_4)

	local var_15_5 = ccui.ImageView:create("equipment/" .. arg_15_1.needs_target .. ".png")

	var_15_5:setPosition(cc.p(275, 67))
	var_15_5:setScale(0.4)
	var_15_5:setName("item_img")
	var_15_0:addChild(var_15_5)

	local var_15_6 = cc.Label:createWithTTF("X" .. tostring(arg_15_1.needs_num), FONT_NAME, 26)

	var_15_6:setPosition(cc.p(335, 65))
	var_15_6:setName("num_lbl")
	var_15_0:addChild(var_15_6)

	local var_15_7 = cc.Label:createWithTTF(tostring(arg_15_1.percent or 100) .. "%", FONT_NAME, 17)

	var_15_7:setColor(cc.c3b(0, 252, 184))
	var_15_7:setPosition(cc.p(432, 120))
	var_15_7:setName("percent_lbl")
	var_15_0:addChild(var_15_7)

	local var_15_8 = ccui.Slider:create()

	var_15_8:loadBarTexture("ActivityNinifaExchangeLayer/progress_bg.png", var_0_0)
	var_15_8:loadProgressBarTexture("ActivityNinifaExchangeLayer/progress_bar.png", var_0_0)
	var_15_8:setName("progress_bar")
	var_15_8:setPosition(cc.p(210, 122))
	var_15_8:setPercent(arg_15_1.percent or 100)
	var_15_0:addChild(var_15_8)

	return var_15_0
end

function ActivityNinifaExchangeLayer.updateRecordSprite(arg_17_0, arg_17_1, arg_17_2)
	arg_17_1:setTag(100)

	if not arg_17_2 then
		return
	end

	arg_17_1:loadTexture(var_0_10[arg_17_2.status][1], var_0_0)

	local var_17_0 = arg_17_1:getChildByName("left_img")

	var_17_0:loadTextures(var_0_10[arg_17_2.status][2], nil, var_0_10[arg_17_2.status][2], var_0_0)
	var_17_0:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_17_2.finished == 1 then
			activity_ninifa_manager:getTaskReward(arg_17_2.taskid)
		else
			LayerManager:switchShowLayer("ActivityNinifaCompositeLayer")
		end
	end)

	local var_17_1 = drop_manager:getAllDrops(arg_17_2.drop)

	if not var_17_1 or not next(var_17_1) then
		var_17_1 = {
			{
				dropid = "gold",
				dropNum = drop_manager:getGold(arg_17_2.drop)
			}
		}
	end

	arg_17_1:getChildByName("drop_sprite"):updatePurchaseItemByItemid(var_17_1[1].dropid, var_17_1[1].dropNum)
	arg_17_1:getChildByName("item_img"):loadTexture("equipment/" .. arg_17_2.needs_target .. ".png")
	arg_17_1:getChildByName("num_lbl"):setString("X" .. tostring(arg_17_2.needs_num))
	arg_17_1:getChildByName("percent_lbl"):setString(tostring(arg_17_2.percent or 100) .. "%")
	arg_17_1:getChildByName("progress_bar"):setPercent(arg_17_2.percent or 100)
end

function ActivityNinifaExchangeLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchReturnLayer("ActivityNinifaLayer")
	end)

	self.bottomList:setName("bottomlist")
	self.bottomList:setPositionY(-GameDisplay.fix_y)
	self.rootLayer:addChild(self.bottomList, 2)
end
