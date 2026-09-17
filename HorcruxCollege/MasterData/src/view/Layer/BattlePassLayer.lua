BattlePassLayer = class("BattlePassLayer", function()
	return cc.Layer:create()
end)

local battle_pass_manager = require("controller.battle_pass_manager")
local activity_manager = require("controller.activity_manager")
local alert_manager = require("controller.alert_manager")
local task_manager = require("controller.task_manager")
local var_0_4 = config._DEBUG and 0 or 1
local var_0_5 = 1
local var_0_6 = 2
local var_0_7 = 4
local var_0_8 = {}

var_0_8[1] = "BattlePassLayer/task_bg_black.png"
var_0_8[2] = "BattlePassLayer/task_bg_light.png"
var_0_8[3] = "BattlePassLayer/task_bg_light.png"
var_0_8[4] = "BattlePassLayer/task_bg_unknow.png"

local var_0_9 = {
	[var_0_5] = "BattlePassLayer/btn_is_getted.png",
	[2] = "public/button/public_button_orange.png",
	[3] = "public/button/public_button_off_click.png",
	[4] = "public/button/public_button_off_click.png"
}
local var_0_10 = 160

function BattlePassLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = BattlePassLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function BattlePassLayer:init()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "BattlePassLayer.json" or "BattlePassLayer.ExportJson")

	self:addChild(self.rootLayer)
	self:initUI()
	self:registerActivityEventListener()
	self:fullScreen()
	battle_pass_manager:getBattlePassListFromSever()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("BattlePassLayer")

			if not battle_pass_manager:isHasRewardCanGet() then
				alert_manager:unregister_alert(ALERT_BATTLE_PASS, true)
			end
		end
	end)
end

function BattlePassLayer.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("BattlePassLayer", activity_manager.activityEventId.BATTLE_PASS_LIST_UPDATE, function(arg_6_0)
		arg_5_0:updateHelpView()
		arg_5_0:updateTaskView(arg_6_0.list, arg_6_0.listLen)
	end)
end

function BattlePassLayer:initUI()
	self:initBgAndTitle()
	self:updateHelpView()
	self:initBottomList()
end

function BattlePassLayer:initBgAndTitle()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_bg"):setBackGroundImage("mainScenebg/battle_pass_bg.jpg")
	require("view.Sprite.TitleSprite")

	self.titleSprite = TitleSprite:create("BattlePassLayer/tltle_detail.png", 2)

	self.titleSprite:setPosition(cc.p(0, GameDisplay.getUiScreenSize().height - 56 - GameDisplay.fix_y))
	self.rootLayer:addChild(self.titleSprite)
	self.titleSprite.title:setTouchEnabled(true)
	self.titleSprite.title:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "battle_pass"
		})
	end)
end

function BattlePassLayer:updateHelpView()
	self.curLevel = battle_pass_manager:getCurBattlePassLevel() or 0

	local var_10_0 = self.rootLayer:getChildByName("panel_up")

	var_10_0:setLocalZOrder(999)
	ccui.Helper:seekWidgetByName(var_10_0, "lv"):setString("等级")
	ccui.Helper:seekWidgetByName(var_10_0, "cur_level"):setString(self.curLevel - 1)

	self.curExp = battle_pass_manager:getBattlePassExp(self.curLevel)

	local var_10_1, var_10_2 = battle_pass_manager:getCurLevelProceed(self.curLevel)
	local var_10_3 = ccui.Helper:seekWidgetByName(var_10_0, "cur_exp")

	var_10_3:setString(var_10_2)

	local var_10_4 = var_10_0:getChildByName("btn_jump_to")

	var_10_4:setSwallowTouches(true)
	var_10_4:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopBattlePassTaskLayer")
	end)

	if not self.progressBar then
		self.progressBar = ccui.Slider:create()

		self.progressBar:loadBarTexture("BattlePassLayer/progress_acr_bg.png", var_0_4)
		self.progressBar:loadProgressBarTexture("BattlePassLayer/progress_acr.png", var_0_4)
		self.progressBar:setPosition(cc.p(230, 128))
		self.progressBar:setPercent(var_10_1)
		var_10_0:addChild(self.progressBar)
	else
		self.progressBar:setPercent(var_10_1)
	end

	var_10_0:getChildByName("exp_icon"):setPositionX(var_10_3:getPositionX() - var_10_3:getContentSize().width)
end

function BattlePassLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end, {})

	self.bottomList:setName("bottomlist")
	self.rootLayer:addChild(self.bottomList, 2)
end

function BattlePassLayer:fullScreen()
	self.rootLayer:getChildByName("panel_up"):setPositionY(self.titleSprite:getPositionY() - 160)
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
end

function BattlePassLayer:updateTaskView(arg_16_1, arg_16_2)
	if not self.curLevel or self.curLevel < 0 then
		return
	end

	self.curExp = battle_pass_manager:getBattlePassExp(self.curLevel)
	self.listLen = arg_16_2
	self.listData = arg_16_1 or {}

	if self.taskView then
		self:updateShowingCells()

		return
	end

	local var_16_0 = self.bottomList:getPositionY() + 65

	self.taskView = cc.TableView:create(cc.size(640, 690 + GameDisplay.height - 1136))

	self.taskView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taskView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taskView:setAnchorPoint(cc.p(0, 0))
	self.taskView:setPosition(0, var_16_0)
	self.taskView:setDelegate()
	self.rootLayer:addChild(self.taskView)
	self.taskView:registerScriptHandler(function(arg_17_0, arg_17_1)
		return 640, var_0_10
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taskView:registerScriptHandler(function(arg_18_0, arg_18_1)
		local var_18_0 = arg_18_0:dequeueCell()

		if not var_18_0 then
			var_18_0 = cc.TableViewCell:create()

			local var_18_2 = self:createTaskSprite(self.listData[arg_18_1 + 1])

			var_18_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_18_2:setPosition(cc.p(370, var_0_10 / 2))
			var_18_0:addChild(var_18_2)
		else
			self:updateTaskSprite(var_18_0:getChildByTag(100), self.listData[arg_18_1 + 1])
		end

		return var_18_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taskView:registerScriptHandler(function(arg_19_0, arg_19_1)
		return self.listLen
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.taskView:reloadData()
	self.taskView:scrollToIndex((self:getNeedJumpToIndex()))
end

function BattlePassLayer:getNeedJumpToIndex()
	local var_20_0, var_20_1 = GetTableViewShowCellIdx(self.taskView, {
		maxcount = math.ceil(self.listLen),
		cellsize = cc.size(640, var_0_10)
	})

	return (self.curLevel + (var_20_1 - var_20_0 - 2) > self.listLen or nil) and self.listLen
end

function BattlePassLayer:updateShowingCells()
	local var_21_0, var_21_1 = GetTableViewShowCellIdx(self.taskView, {
		maxcount = math.ceil(self.listLen),
		cellsize = cc.size(640, var_0_10)
	})

	for iter_21_0 = var_21_0, var_21_1 do
		self.taskView:updateCellAtIndex(iter_21_0)
	end
end

function BattlePassLayer:createTaskSprite(arg_22_1)
	local var_22_0 = ccui.ImageView:create(var_0_8[arg_22_1.stat], var_0_4)

	var_22_0:setName("sprite_bg")
	var_22_0:setTag(100)

	local var_22_1 = ccui.ImageView:create("BattlePassLayer/level_bg.png", var_0_4)

	var_22_1:setPosition(cc.p(-45, var_0_10 / 2))
	var_22_1:setName("cur_level_bg")
	var_22_0:addChild(var_22_1, 100)

	if type(arg_22_1.level) == "number" and arg_22_1.level % 5 == 0 then
		print(arg_22_1.level)
		var_22_1:loadTexture("BattlePassLayer/level_bg_2.png", var_0_4)
	end

	local var_22_2 = cc.Label:createWithTTF("等级", FONT_DES, 18)

	var_22_2:setName("lvlbl")
	var_22_2:setPosition(cc.p(var_22_1:getContentSize().width / 2, var_22_1:getContentSize().height / 2 + 15))
	var_22_1:addChild(var_22_2)

	local var_22_3 = cc.Label:createWithTTF(tostring(arg_22_1.level), FONT_DES, 35)

	var_22_3:setName("cur_level_lbl")
	var_22_3:setPosition(cc.p(var_22_1:getContentSize().width / 2, var_22_1:getContentSize().height / 2 - 15))
	var_22_1:addChild(var_22_3)

	local var_22_4 = ccui.Slider:create()

	var_22_4:setAnchorPoint(cc.p(0, 0.5))
	var_22_4:setRotation(90)
	var_22_4:setName("progress_bar")
	var_22_4:loadBarTexture("BattlePassLayer/progress_ver_bg.png", var_0_4)
	var_22_4:loadProgressBarTexture("BattlePassLayer/progress_ver.png", var_0_4)
	var_22_4:setPosition(cc.p(var_22_1:getPositionX(), 40))
	var_22_0:addChild(var_22_4, -100)

	if type(arg_22_1.level) == "string" then
		var_22_4:setVisible(false)
	elseif arg_22_1.level < self.curLevel then
		var_22_4:setPercent(100)
	elseif arg_22_1.level == self.curLevel then
		var_22_4:setPercent((battle_pass_manager:getCurLevelProceed(self.curLevel)))
	else
		var_22_4:setPercent(0)
	end

	local var_22_5 = ccui.ImageView:create("BattlePassLayer/level_unknow.png", var_0_4)

	var_22_5:setName("un_know_icon")
	var_22_5:setPosition(cc.p(110, var_0_10 / 2))
	var_22_5:setVisible(arg_22_1.stat == var_0_7)
	var_22_0:addChild(var_22_5)

	unKnowLbl = cc.Label:createWithTTF(L_BATTLE_PASS.UN_KNOW_PASS, FONT_DES, 28)

	unKnowLbl:setName("un_know_lbl")
	unKnowLbl:setColor(cc.c3b(173, 191, 211))
	unKnowLbl:setVisible(arg_22_1.stat == var_0_7)
	unKnowLbl:setPosition(cc.p(350, var_0_10 / 2))
	var_22_0:addChild(unKnowLbl)

	if type(arg_22_1.level) ~= "string" then
		local var_22_6 = ccui.Layout:create()

		var_22_6:setPosition(cc.p(var_22_0:getContentSize().width / 2, var_0_10 / 2))
		var_22_6:setName("drop_node")
		var_22_0:addChild(var_22_6)

		for iter_22_0, iter_22_1 in pairs((self:formatDropData((battle_pass_manager:getBattlePassDrop(arg_22_1.drop))))) do
			local var_22_7 = ItemPurchaseSprite:createPurchaseItem(iter_22_1.dropid, iter_22_1.dropNum)

			var_22_7:setScale(0.7)
			var_22_7:setTouchEnabled(true)
			var_22_7:setSwallowTouches(false)
			var_22_7:addTouchEventListener(function(arg_23_0, arg_23_1)
				if arg_23_1 ~= ccui.TouchEventType.ended then
					return
				end

				if math.abs(arg_23_0:getTouchBeganPosition().y - arg_23_0:getTouchEndPosition().y) > 50 then
					return
				end

				showItemDetails(iter_22_1.dropid, var_22_7.entityid)
			end)
			var_22_7:setPosition(cc.p(-150 + (iter_22_0 - 1) * 140, 0))
			var_22_6:addChild(var_22_7)
		end
	end

	local var_22_8 = ccui.Button:create(var_0_9[arg_22_1.stat], nil, var_0_9[arg_22_1.stat], var_0_4)

	var_22_8:setName("get_reward_btn")
	var_22_8:setPosition(cc.p(450, var_0_10 / 2))
	var_22_8:setVisible(arg_22_1.stat ~= var_0_7)
	var_22_8:setScale(0.8)
	var_22_8:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_22_1.stat ~= var_0_6 then
			return
		end

		battle_pass_manager:getBattlePassReward(arg_22_1.level)

		self.needScrollToCellIndex = arg_22_1.level
	end)
	var_22_0:addChild(var_22_8)

	local var_22_9 = cc.Label:createWithTTF(L_BATTLE_PASS.GET_REWARD, FONT_DES, 30)

	var_22_9:setColor(cc.c3b(0, 0, 0))
	var_22_9:setName("get_reward_lbl")
	var_22_9:setVisible(arg_22_1.stat ~= var_0_5)
	var_22_9:setPosition(cc.p(var_22_8:getContentSize().width / 2, var_22_8:getContentSize().height / 2))
	var_22_8:addChild(var_22_9)

	return var_22_0
end

function BattlePassLayer:updateTaskSprite(arg_25_1, arg_25_2)
	arg_25_1:setTag(100)
	arg_25_1:loadTexture(var_0_8[arg_25_2.stat], var_0_4)

	local var_25_0 = arg_25_1:getChildByName("cur_level_bg")

	if type(arg_25_2.level) == "number" and arg_25_2.level % 5 == 0 then
		var_25_0:loadTexture("BattlePassLayer/level_bg_2.png", var_0_4)
	else
		var_25_0:loadTexture("BattlePassLayer/level_bg.png", var_0_4)
	end

	var_25_0:getChildByName("lvlbl"):setPosition(cc.p(var_25_0:getContentSize().width / 2, var_25_0:getContentSize().height / 2 + 15))

	local var_25_1 = var_25_0:getChildByName("cur_level_lbl")

	var_25_1:setString(tostring(arg_25_2.level))
	var_25_1:setPosition(cc.p(var_25_0:getContentSize().width / 2, var_25_0:getContentSize().height / 2 - 15))

	local var_25_2 = arg_25_1:getChildByName("progress_bar")

	if type(arg_25_2.level) == "string" then
		var_25_2:setVisible(false)
	elseif arg_25_2.level < self.curLevel then
		var_25_2:setVisible(true)
		var_25_2:setPercent(100)
	elseif arg_25_2.level == self.curLevel then
		var_25_2:setVisible(true)
		var_25_2:setPercent((battle_pass_manager:getCurLevelProceed(self.curLevel)))
	else
		var_25_2:setVisible(true)
		var_25_2:setPercent(0)
	end

	local var_25_3 = arg_25_1:getChildByName("un_know_icon")
	local var_25_4 = arg_25_1:getChildByName("un_know_lbl")

	var_25_3:setVisible(arg_25_2.stat == var_0_7)
	var_25_4:setVisible(arg_25_2.stat == var_0_7)

	local var_25_5 = arg_25_1:getChildByName("drop_node")

	if var_25_5 then
		var_25_5:removeFromParent()
	end

	if type(arg_25_2.level) ~= "string" then
		local var_25_6 = ccui.Layout:create()

		var_25_6:setPosition(cc.p(arg_25_1:getContentSize().width / 2, var_0_10 / 2))
		var_25_6:setName("drop_node")
		arg_25_1:addChild(var_25_6)

		for iter_25_0, iter_25_1 in pairs((self:formatDropData((battle_pass_manager:getBattlePassDrop(arg_25_2.drop))))) do
			local var_25_7 = ItemPurchaseSprite:createPurchaseItem(iter_25_1.dropid, iter_25_1.dropNum)

			var_25_7:setScale(0.7)
			var_25_7:setTouchEnabled(true)
			var_25_7:setSwallowTouches(false)
			var_25_7:addTouchEventListener(function(arg_26_0, arg_26_1)
				if arg_26_1 ~= ccui.TouchEventType.ended then
					return
				end

				if math.abs(arg_26_0:getTouchBeganPosition().y - arg_26_0:getTouchEndPosition().y) > 50 then
					return
				end

				showItemDetails(iter_25_1.dropid, var_25_7.entityid)
			end)
			var_25_7:setPosition(cc.p(-150 + (iter_25_0 - 1) * 140, 0))
			var_25_6:addChild(var_25_7)
		end
	end

	local var_25_8 = arg_25_1:getChildByName("get_reward_btn")

	var_25_8:loadTextures(var_0_9[arg_25_2.stat], nil, var_0_9[arg_25_2.stat], var_0_4)
	var_25_8:setVisible(arg_25_2.stat ~= var_0_7)
	var_25_8:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_25_2.stat ~= var_0_6 then
			return
		end

		battle_pass_manager:getBattlePassReward(arg_25_2.level)

		self.needScrollToCellIndex = arg_25_2.level
	end)

	local var_25_9 = var_25_8:getChildByName("get_reward_lbl")

	var_25_9:setPosition(cc.p(var_25_8:getContentSize().width / 2, var_25_8:getContentSize().height / 2))
	var_25_9:setVisible(arg_25_2.stat ~= var_0_5)
end

function BattlePassLayer.formatDropData(arg_28_0, arg_28_1)
	if #arg_28_1 > 1 then
		return arg_28_1
	end

	if arg_28_1[1].dropid and arg_28_1[1].dropNum > 1 then
		local var_28_0 = math.ceil(arg_28_1[1].dropNum / 2)

		arg_28_1[1].dropNum = var_28_0
		arg_28_1[2] = {
			dropid = arg_28_1[1].dropid,
			dropNum = arg_28_1[1].dropNum - var_28_0
		}
	end

	return arg_28_1
end
