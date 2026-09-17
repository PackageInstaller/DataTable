ActivityWarOrderLayer = class("ActivityWarOrderLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.ItemSprite")

local Utility = require("common.Utility")
local L2Actor = require("view.Sprite.L2Actor")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local favorfile_data = require("data.favorfile_data")
local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local activity_return_manager = require("controller.activity_return_manager")
local var_0_9 = config._DEBUG and 0 or 1
local var_0_10 = {
	"white",
	"green",
	"blue",
	"purple",
	"orange",
	"red"
}

local function var_0_11(arg_2_0)
	if arg_2_0 >= 86400 then
		return string.format(L_TIME_TEXT[1], math.floor(arg_2_0 / 86400), math.floor(arg_2_0 % 86400 / 3600))
	elseif arg_2_0 >= 3600 then
		return string.format(L_TIME_TEXT[2], math.floor(arg_2_0 / 3600), math.floor(arg_2_0 % 3600 / 60))
	else
		return string.format(L_TIME_TEXT[4], math.floor(arg_2_0 / 60), math.floor(arg_2_0 % 60))
	end
end

function ActivityWarOrderLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = ActivityWarOrderLayer.new()

	activity_manager:init_activity_warorder_info(ACTIVITY_WARORDER_ID, function()
		var_3_0:init(arg_3_1)
	end)

	return var_3_0
end

function ActivityWarOrderLayer:initStaticConfig()
	self.IS_GETTED = 1
	self.CAN_GET = 2
	self.UN_ACHIEVE = 3
	self.LEVEL_UNACHIEVE = 0
	self.UNRECEIVE = 1
	self.RECEIVE_ORDINARY = 2
	self.RECEIVE_ALL = 3
	self.QIOGN_B = 4
	self.LEVEL_CELL_HEIGHT = self:get_level_cell_height()
	self.TASK_CELL_HEIGHT = self:get_task_cell_height()
	self.btn_stat_img = {
		[self.IS_GETTED] = self.layerName .. "/btn_yiwancheng.png",
		[self.CAN_GET] = self.layerName .. "/btn_lingqujiangli.png",
		[self.UN_ACHIEVE] = self.layerName .. "/btn_qianwangwancheng.png"
	}
	self.SHOW_TYPE_LEVEL = 1
	self.SHOW_TYPE_TASK = 2
end

function ActivityWarOrderLayer:init(arg_6_1)
	self.activityId = ACTIVITY_WARORDER_ID

	ErrorCodeManager:check({
		systemname = "ActivityWarOrderLayer",
		id = self.activityId
	})

	self.layerName = activity_manager:getWarOrderLayerName(self.activityId)
	self.warorderid = activity_manager:get_warorder_id(self.activityId)

	TextureManager:loadLayerTextures({
		self.layerName
	})

	self.bg = ccui.ImageView:create("mainScenebg/" .. self.layerName .. ".png")

	self.bg:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2 - GameDisplay.fix_y)
	self:addChild(self.bg, -1)

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))

	self:addChild(self.rootLayer)
	self:initStaticConfig()
	self:initBaseUI()
	self:initBottomList()
	self:initTimeLabel()
	self:fullScreen()
	self:updateAlert()
	self:registerActivityEventListener()
	self:initPanel()

	function activity_manager.warorder_daily_update()
		LayerManager:pushInLayer("PopDoLayer", {
			surecallback = function()
				LayerManager:switchReturnLayer("MainLayer")
			end,
			cancelcallback = function()
				LayerManager:switchReturnLayer("MainLayer")
			end,
			labels = {
				titleImage = "title_warorder.png"
			},
			desRichTexts = {
				{
					{
						fontSize = 28,
						str = "战令系统已刷新",
						font = FONT_W5
					}
				}
			}
		})
	end

	self:registerScriptHandler(function(arg_10_0)
		if arg_10_0 == "exit" then
			activity_manager:releaseEventListenerByName(self.layerName)
			activity_manager:updateWarOrderEntranceAlert(self.activityId)

			if self.activityScheduler then
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end

			TextureManager:removeLayerTextures({
				self.layerName
			})

			function activity_manager.warorder_daily_update()
				return
			end
		end
	end)
	hx_print("UI文件夹:" .. self.layerName, CONSOLE_COLOR_LIGHT_GOLD)
end

function ActivityWarOrderLayer:initPanel()
	if activity_manager:getCurShowType(self.activityId) == self.SHOW_TYPE_LEVEL then
		self:onBtnLevelCallback()
	elseif activity_manager:getCurShowType(self.activityId) == self.SHOW_TYPE_TASK then
		self:onBtnTaskCallback()
	end
end

function ActivityWarOrderLayer:get_level_cell_height()
	return ccui.Helper:seekWidgetByName(self.rootLayer, "levelnode1"):getPositionY() - ccui.Helper:seekWidgetByName(self.rootLayer, "levelnode2"):getPositionY()
end

function ActivityWarOrderLayer:get_task_cell_height()
	return ccui.Helper:seekWidgetByName(self.rootLayer, "tasknode1"):getPositionY() - ccui.Helper:seekWidgetByName(self.rootLayer, "tasknode2"):getPositionY()
end

function ActivityWarOrderLayer:initBaseUI()
	self.panelUp = self.rootLayer:getChildByName("panel_up")

	self.panelUp:setAnchorPoint(cc.p(0, 0))
	self.panelUp:setPosition(cc.p(0, 761))
	self.panelUp:setTouchEnabled(false)
	self.panelUp:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if activity_manager:getBattlePassLive2d(self.activityId) then
			self:showSoulGirlPop()
		end
	end)

	self.title = ccui.Helper:seekWidgetByName(self.panelUp, "detail")
	self.timeLabel = ccui.Helper:seekWidgetByName(self.panelUp, "lbl_time")

	self.timeLabel:setAnchorPoint(cc.p(0, 0))
	self.timeLabel:setPosition(cc.p(5, 290))
	self.timeLabel:setFontSize(20)

	self.lblCurLevel = ccui.Helper:seekWidgetByName(self.panelUp, "cur_level")
	self.lblCurExp = ccui.Helper:seekWidgetByName(self.panelUp, "cur_exp")
	self.btnGoTo = ccui.Helper:seekWidgetByName(self.panelUp, "button_jump_to")
	self.progressBar = ccui.Helper:seekWidgetByName(self.panelUp, "ProgressBar_banner")
	self.BtnBuyPt = ccui.Helper:seekWidgetByName(self.panelUp, "Button_buy")
	self.switchBtnLevel = ccui.Helper:seekWidgetByName(self.panelUp, "switch_btn_level")
	self.switchBtnTask = ccui.Helper:seekWidgetByName(self.panelUp, "switch_btn_task")
	self.upup = ccui.Helper:seekWidgetByName(self.panelUp, "upup")
	self.lockIcon = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_suo")
	self.bottomList = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bottom")
	self.btnReturn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_return")
	self.btnAllReward = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure")
	self.btnJump = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_jump")
	self.panelLevel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_level")

	self.panelLevel:setTouchEnabled(false)

	self.bigGiftPanel = self.panelLevel:getChildByName("big_gift_bg")

	self.bigGiftPanel:setPositionY(-90)

	self.levelNode1 = ccui.Helper:seekWidgetByName(self.rootLayer, "levelnode1")
	self.levelNode2 = ccui.Helper:seekWidgetByName(self.rootLayer, "levelnode2")

	self.levelNode1:setVisible(false)
	self.levelNode2:setVisible(false)

	self.panelTask = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_task")

	self.panelTask:setTouchEnabled(false)

	self.taskNode1 = ccui.Helper:seekWidgetByName(self.rootLayer, "tasknode1")
	self.taskNode2 = ccui.Helper:seekWidgetByName(self.rootLayer, "tasknode2")

	self.taskNode1:setVisible(false)
	self.taskNode2:setVisible(false)

	self.levelOnPath = self.layerName .. "/switch_btn_jiangli_on.png"
	self.levelOffPath = self.layerName .. "/switch_btn_jiangli_off.png"
	self.taskOnPath = self.layerName .. "/switch_btn_task_on.png"
	self.taskOffPath = self.layerName .. "/switch_btn_task_off.png"

	self.switchBtnLevel:loadTextures(self.levelOnPath, self.levelOnPath, self.levelOnPath, var_0_9)
	self.switchBtnTask:loadTextures(self.taskOffPath, self.taskOffPath, self.taskOffPath, var_0_9)
	self.panelLevel:setVisible(true)
	self.panelTask:setVisible(false)
	self.switchBtnLevel:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if activity_manager:getCurShowType(self.activityId) == self.SHOW_TYPE_LEVEL then
			return
		end

		self:onBtnLevelCallback()
	end)
	self.switchBtnTask:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		if activity_manager:getCurShowType(self.activityId) == self.SHOW_TYPE_TASK then
			return
		end

		self:onBtnTaskCallback()
	end)
	self:initDynamicUI()

	if self.activityId == BACKFLOW_BP_ID then
		self.btn_sign = ccui.Button:create("Activity_return_BPBasic/btn_sign.png", "Activity_return_BPBasic/btn_sign.png", "Activity_return_BPBasic/btn_sign.png", var_0_9)

		self.btn_sign:setPosition(cc.p(595, 1090))
		self:addChild(self.btn_sign, 999)
		self.btn_sign:addTouchEventListener(function(arg_19_0, arg_19_1)
			if arg_19_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopActivityReturnSignLayer", {
				updateCallback = function()
					self:updateBtnSignRedDot()
				end
			})
		end)
		self:updateBtnSignRedDot()
	end
end

function ActivityWarOrderLayer:onBtnLevelCallback()
	self.switchBtnLevel:loadTextures(self.levelOnPath, self.levelOnPath, self.levelOnPath, var_0_9)
	self.switchBtnTask:loadTextures(self.taskOffPath, self.taskOffPath, self.taskOffPath, var_0_9)
	activity_manager:setCurShowType(self.activityId, self.SHOW_TYPE_LEVEL)
	activity_manager:requestWarOrderLevelInfo(self.activityId)
	self.panelLevel:setVisible(true)
	self.panelTask:setVisible(false)
end

function ActivityWarOrderLayer:onBtnTaskCallback()
	self.switchBtnLevel:loadTextures(self.levelOffPath, self.levelOffPath, self.levelOffPath, var_0_9)
	self.switchBtnTask:loadTextures(self.taskOnPath, self.taskOnPath, self.taskOnPath, var_0_9)
	activity_manager:setCurShowType(self.activityId, self.SHOW_TYPE_TASK)
	activity_manager:requestWarOrderTaskInfo(self.activityId)
	self.panelLevel:setVisible(false)
	self.panelTask:setVisible(true)
end

function ActivityWarOrderLayer:updateBtnSignRedDot()
	if activity_return_manager:get_can_sign() then
		global_add_alert_tag(self.btn_sign, cc.p(85, 85))
	else
		global_remove_alert_tag(self.btn_sign)
	end
end

function ActivityWarOrderLayer:initDynamicUI()
	local var_24_0 = activity_manager:getBPShowFurniture(self.activityId)

	self.furnitureBg = ccui.Helper:seekWidgetByName(self.rootLayer, "furniture_bg")

	if self.furnitureBg and var_24_0 then
		self.furnitureBg:setVisible(true)
		self.furnitureBg:getChildByName("furniture"):loadTexture(self.layerName .. "/" .. var_24_0 .. ".png", var_0_9)
	end
end

function ActivityWarOrderLayer:initBottomList()
	self.btnReturn:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.btnAllReward:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		if activity_manager:getCurShowType(self.activityId) == self.SHOW_TYPE_LEVEL then
			if not activity_manager:isHasWarOrderRewardCanGet(self.activityId) then
				global_ShowBlockWords(L_BATTLE_PASS.NOT_REWARD_CAN_GET)

				return
			end

			activity_manager:getWarOrderLevelReward(self.activityId)
		else
			if not activity_manager:isHasCanCompleteWarorderTask(self.activityId) then
				global_ShowBlockWords(L_BATTLE_PASS.NOT_REWARD_CAN_GET)

				return
			end

			activity_manager:getWarOrderTaskRewardOneKey(self.activityId)
		end
	end)
	self.btnJump:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopGetWarOrdrBpVIPLayer", {
			activityId = self.activityId,
			warorderId = self.warorderid,
			imagePath = self.layerName
		})
	end)
	self.title:setTouchEnabled(true)
	self.title:addTouchEventListener(function(arg_29_0, arg_29_1)
		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = self.layerName
		})
	end)
end

function ActivityWarOrderLayer:initTimeLabel()
	if self.activityScheduler then
		time_check_manager:removeUpdatePool(self.activityScheduler)

		self.activityScheduler = nil
	end

	self.activityScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(global_get_time_by_date((activity_manager:get_warorder_module_finishtime(self.activityId, "bp"))) - time_check_manager:getCurTime(), function(arg_31_0)
		self.timeLabel:setString(L_LEFT_TIME_SPACE .. var_0_11(arg_31_0))

		if arg_31_0 > 0 and arg_31_0 < 5 and self.activityScheduler then
			time_check_manager:reset(function()
				self:initTimeLabel()
			end)
		elseif arg_31_0 <= 0 and self.activityScheduler then
			time_check_manager:removeUpdatePool(self.activityScheduler)

			self.activityScheduler = nil
		end
	end)))
end

function ActivityWarOrderLayer:registerActivityEventListener()
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.BATTLE_PASS_LIST_UPDATE, function(arg_34_0)
		self:updateHelpView()

		if activity_manager:getCurShowType(self.activityId) == self.SHOW_TYPE_LEVEL then
			self:updateLevelView(arg_34_0.list, arg_34_0.listLen)
			self:updateShowBigGift()
		end
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_35_0)
		self:updateHelpView()

		if activity_manager:getCurShowType(self.activityId) == self.SHOW_TYPE_TASK then
			self:updateTaskView(arg_35_0.list, arg_35_0.listLen)
		end
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.BATTLE_PASS_VIP_UPDATE, function(arg_36_0)
		self:updateHelpView()

		if activity_manager:getCurShowType(self.activityId) == self.SHOW_TYPE_LEVEL then
			activity_manager:requestWarOrderLevelInfo(self.activityId)
		end
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.UPDATE_ACTIVITY_STATUS_ALERT, function(arg_37_0)
		self:updateAlert()
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_38_0)
		activity_manager:requestWarOrderLevelInfo(self.activityId)
		self:updateHelpView()
	end), self)
end

function ActivityWarOrderLayer:updateHelpView()
	self.curLevel = activity_manager:getCurWarOrderLevel(self.activityId) or 1

	self.lblCurLevel:setString(self.curLevel - 1)

	if self.curLevel > activity_manager:getWarOrderMaxLevel(self.activityId) then
		self.lblCurLevel:setString("Max")
	end

	self.curExp = activity_manager:getWarOrderExp(self.activityId, self.curLevel)

	local var_39_0, var_39_1 = activity_manager:getCurWarOrderLevelProceed(self.activityId, self.curLevel)

	self.lblCurExp:setString(var_39_1)

	local var_39_2 = self.btnGoTo

	if activity_manager:isWarOrderSVIP(self.activityId) then
		var_39_2:loadTextures(self.layerName .. "/btn_yiquanbugoumai.png", self.layerName .. "/btn_yiquanbugoumai.png", self.layerName .. "/btn_yiquanbugoumai.png", var_0_9)
	elseif activity_manager:isWarOrderVIP(self.activityId) then
		var_39_2:loadTextures(self.layerName .. "/btn_shengji.png", self.layerName .. "/btn_shengji.png", self.layerName .. "/btn_shengji.png", var_0_9)
	else
		var_39_2:loadTextures(self.layerName .. "/btn_kaiqizhiyuan.png", self.layerName .. "/btn_kaiqizhiyuan.png", self.layerName .. "/btn_kaiqizhiyuan.png", var_0_9)
	end

	var_39_2:setSwallowTouches(true)
	var_39_2:addTouchEventListener(function(arg_40_0, arg_40_1)
		if arg_40_1 ~= ccui.TouchEventType.ended then
			return
		end

		if activity_manager:isWarOrderSVIP(self.activityId) then
			if self.curLevel >= activity_manager:getWarOrderMaxLevel(self.activityId) then
				if not activity_manager:isWarOrderVIP(self.activityId) or not activity_manager:isWarOrderSVIP(self.activityId) then
					LayerManager:pushInLayer("PopGetWarOrdrBpVIPLayer", {
						activityId = self.activityId,
						warorderId = self.warorderid,
						imagePath = self.layerName
					})

					return
				end

				global_ShowBlockWords(L_MAX_LEVLE)

				return
			end

			LayerManager:pushInLayer("PopWarOrderBuyLayer", {
				activityId = self.activityId,
				imagePath = self.layerName
			})
		else
			LayerManager:pushInLayer("PopGetWarOrdrBpVIPLayer", {
				activityId = self.activityId,
				warorderId = self.warorderid,
				imagePath = self.layerName
			})
		end
	end)
	self.progressBar:setPercent(var_39_0)
	self.BtnBuyPt:setVisible(activity_manager:isWarOrderVIP(self.activityId))
	self.BtnBuyPt:addTouchEventListener(function(arg_41_0, arg_41_1)
		if arg_41_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not activity_manager:isWarOrderVIP(self.activityId) then
			return
		end

		if self.curLevel >= activity_manager:getWarOrderMaxLevel(self.activityId) then
			if not activity_manager:isWarOrderVIP(self.activityId) or not activity_manager:isWarOrderSVIP(self.activityId) then
				LayerManager:pushInLayer("PopGetWarOrdrBpVIPLayer", {
					activityId = self.activityId,
					warorderId = self.warorderid,
					imagePath = self.layerName
				})

				return
			end

			global_ShowBlockWords(L_MAX_LEVLE)

			return
		end

		LayerManager:pushInLayer("PopWarOrderBuyLayer", {
			activityId = self.activityId,
			imagePath = self.layerName
		})
	end)

	if activity_manager:isWarOrderSVIP(self.activityId) then
		self.upup:setVisible(true)
	else
		self.upup:setVisible(true)
	end

	self.lockIcon:setVisible(not activity_manager:isWarOrderVIP(self.activityId))
end

function ActivityWarOrderLayer:updateLevelView(arg_42_1, arg_42_2)
	if not self.curLevel or self.curLevel < 0 then
		return
	end

	if self.taskView then
		self.taskView:setVisible(false)
	end

	self.curExp = activity_manager:getWarOrderExp(self.activityId, self.curLevel)
	self.levelListLen = arg_42_2
	self.levelListData = arg_42_1 or {}

	if self.levelView then
		self.levelView:setVisible(true)
		self:updateShowingCells(self.levelView, self.levelListLen)

		return
	end

	self.panelLevel:setLocalZOrder(999)

	local var_42_0 = 640
	local var_42_1 = self.LEVEL_CELL_HEIGHT
	local var_42_2 = self.panelLevel:getChildByName("Panel_zi")
	local var_42_3 = 555 + (GameDisplay.height - 1136) - var_42_2:getContentSize().height

	var_42_2:setPosition(cc.p(320, var_42_3 - 30))

	local var_42_4 = self.panelLevel:getChildByName("view")

	var_42_4:setAnchorPoint(cc.p(0, 0))
	var_42_4:setPosition(cc.p(0, -40))

	self.levelView = Utility:getTableView(self.levelListLen, function(arg_43_0)
		return var_42_0, var_42_1
	end, cc.size(640, var_42_3 - 5), function(arg_44_0, arg_44_1)
		local var_44_0 = arg_44_0:dequeueCell()

		if not var_44_0 then
			var_44_0 = cc.TableViewCell:create()

			local var_44_2 = self:createLevelSprite(self.levelListData[arg_44_1 + 1])

			var_44_2:setAnchorPoint(cc.p(0, 0))
			var_44_2:setPosition(cc.p(0, 0))
			var_44_0:addChild(var_44_2)
			var_44_0:setLocalZOrder(999 - 10 * arg_44_1)
		else
			self:updateLevelSprite(var_44_0:getChildByTag(100), self.levelListData[arg_44_1 + 1])
			var_44_0:setLocalZOrder(999 - 10 * arg_44_1)
		end

		return var_44_0
	end)

	self.levelView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.levelView:setVisible(true)
	var_42_4:addChild(self.levelView)
	self.levelView:scrollToIndex(self:getNeedJumpToIndex(), false)
end

function ActivityWarOrderLayer:createLevelSprite(arg_45_1)
	local var_45_0 = self.levelNode1:clone()

	var_45_0:setName("sprite_bg")
	var_45_0:setTag(100)

	if type(arg_45_1.id) == "string" then
		var_45_0:setVisible(false)
	else
		var_45_0:setVisible(true)
	end

	local var_45_1 = var_45_0:getChildByName("level_bg")
	local var_45_2 = var_45_1:getChildByName("lv_num")
	local var_45_3 = type(arg_45_1.id) == "number" and arg_45_1.id % 5 == 0
	local var_45_4 = arg_45_1.status ~= self.LEVEL_UNACHIEVE
	local var_45_5 = cc.p(30, 30)

	if var_45_3 then
		var_45_5 = cc.p(45, 40)
	elseif var_45_3 == false and var_45_4 == true then
		var_45_5 = cc.p(38, 35)
	end

	var_45_2:setPosition(var_45_5)

	local var_45_6 = var_45_0:getChildByName("Image_got_mask")

	if not arg_45_1.status and arg_45_1.id == "?" and var_45_6 then
		var_45_6:setVisible(false)
	elseif var_45_6 then
		if arg_45_1.status == self.RECEIVE_ALL then
			var_45_6:setVisible(true)
			var_45_6:loadTexture(self.layerName .. "/image_got_mask2.png", var_0_9)

			if type(arg_45_1.id) ~= "string" and arg_45_1.specialDrop then
				if activity_manager:getBattlePassDrop(self.activityId, arg_45_1.specialDrop)[2] then
					var_45_6:getChildByName("Image_hook1"):setVisible(true)
					var_45_6:getChildByName("Image_hook2"):setVisible(true)
					var_45_6:getChildByName("Image_hook3"):setVisible(true)
				else
					var_45_6:getChildByName("Image_hook1"):setVisible(true)
					var_45_6:getChildByName("Image_hook2"):setVisible(true)
					var_45_6:getChildByName("Image_hook3"):setVisible(false)
				end
			end
		elseif arg_45_1.status >= self.RECEIVE_ORDINARY then
			var_45_6:setVisible(true)
			var_45_6:loadTexture(self.layerName .. "/image_got_mask1.png", var_0_9)
			var_45_6:getChildByName("Image_hook1"):setVisible(true)
			var_45_6:getChildByName("Image_hook2"):setVisible(false)
			var_45_6:getChildByName("Image_hook3"):setVisible(false)
		else
			var_45_6:setVisible(false)
			var_45_6:getChildByName("Image_hook1"):setVisible(false)
			var_45_6:getChildByName("Image_hook2"):setVisible(false)
			var_45_6:getChildByName("Image_hook3"):setVisible(false)
		end
	end

	var_45_2:setString(arg_45_1.id)

	if arg_45_1.status ~= self.LEVEL_UNACHIEVE then
		if type(arg_45_1.id) == "number" and arg_45_1.id % 5 == 0 then
			var_45_1:loadTexture(self.layerName .. "/bg_biglv_yidadao.png", var_0_9)
		else
			var_45_1:loadTexture(self.layerName .. "/bg_smalllv_yidadao.png", var_0_9)
		end

		var_45_2:setColor(self.levelNode1:getChildByName("level_bg"):getChildByName("lv_num"):getColor())
	else
		if type(arg_45_1.id) == "number" and arg_45_1.id % 5 == 0 then
			var_45_1:loadTexture(self.layerName .. "/bg_biglv_weidadao.png", var_0_9)
		else
			var_45_1:loadTexture(self.layerName .. "/bg_smalllv_weidadao.png", var_0_9)
		end

		var_45_2:setColor(self.levelNode2:getChildByName("level_bg"):getChildByName("lv_num"):getColor())
	end

	local var_45_7 = var_45_0:getChildByName("progress_bg")
	local var_45_8 = var_45_7:getChildByName("ProgressBar_lv")

	if type(arg_45_1.id) == "string" or arg_45_1.id == activity_manager:getBattlePassMaxLevel(self.activityId) - 1 then
		var_45_7:setVisible(false)
	elseif arg_45_1.id + 1 < self.curLevel then
		var_45_7:setVisible(true)
		var_45_8:setPercent(100)
	elseif arg_45_1.id + 1 == self.curLevel then
		var_45_7:setVisible(true)
		var_45_8:setPercent((activity_manager:getCurWarOrderLevelProceed(self.activityId, self.curLevel)))
	else
		var_45_7:setVisible(true)
		var_45_8:setPercent(0)
	end

	if type(arg_45_1.id) ~= "string" and arg_45_1.drop then
		local var_45_9 = activity_manager:getBattlePassDrop(self.activityId, arg_45_1.drop)
		local var_45_10 = var_45_9[1].dropid
		local var_45_11 = var_45_0:getChildByName("item1")
		local var_45_12 = var_45_11:getChildByName("lv_bg")
		local var_45_13 = var_45_11:getChildByName("icon")
		local var_45_14 = var_45_11:getChildByName("Image_gain")
		local var_45_15 = var_45_11:getChildByName("star")
		local var_45_16 = ItemNoBgSprite:create(var_45_9[1].dropid)

		var_45_16:setName("sp_icon")
		var_45_11:addChild(var_45_16, 0)
		var_45_11:loadTextures("public/box/weapon_bg_" .. var_0_10[item_data[var_45_10].equip_quality] .. ".png", "public/box/weapon_bg_" .. var_0_10[item_data[var_45_10].equip_quality] .. ".png", "public/box/weapon_bg_" .. var_0_10[item_data[var_45_10].equip_quality] .. ".png", var_0_9)
		var_45_12:getChildByName("Label_33"):setString("x" .. var_45_9[1].dropNum)

		if var_45_14 then
			var_45_14:setVisible(arg_45_1.status >= self.RECEIVE_ORDINARY)
		end

		if item_data[var_45_10].bag_item_type == kITEM_HORCRUX and var_45_9[1].item_attr then
			var_45_15:setVisible(true)
			var_45_15:loadTexture("public/currency/star" .. tonumber(string.sub(var_45_9[1].item_attr, 6, 6)) .. ".png", var_0_9)
		else
			var_45_15:setVisible(false)
		end

		var_45_12:setVisible(item_data[var_45_10].bag_item_type ~= kITEM_SCULTURE)
		var_45_13:setVisible(false)
		var_45_16:setPosition(var_45_13:getPosition())
		var_45_16:setTouchEnabled(false)
		var_45_11:setTouchEnabled(true)
		var_45_11:setSwallowTouches(false)
		var_45_11:addTouchEventListener(function(arg_46_0, arg_46_1)
			if arg_46_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_46_0:getTouchBeganPosition().y - arg_46_0:getTouchEndPosition().y) > 50 then
				return
			end

			if arg_45_1.status == self.LEVEL_UNACHIEVE then
				showItemDetails(var_45_10)

				return
			end

			if arg_45_1.status == self.RECEIVE_ALL then
				return
			end

			if arg_45_1.status == self.RECEIVE_ORDINARY and not activity_manager:isWarOrderVIP(self.activityId) then
				return
			end

			activity_manager:getWarOrderLevelReward(self.activityId, arg_45_1.id)
		end)
	end

	if type(arg_45_1.id) ~= "string" and arg_45_1.specialDrop then
		local var_45_17 = activity_manager:getBattlePassDrop(self.activityId, arg_45_1.specialDrop)

		for iter_45_0 = 1, 2 do
			local var_45_18 = var_45_0:getChildByName("item" .. iter_45_0 + 1)

			var_45_18:setVisible(true)

			if var_45_17[iter_45_0] then
				local var_45_19 = var_45_17[iter_45_0].dropid
				local var_45_20 = var_45_18:getChildByName("lv_bg")
				local var_45_21 = var_45_20:getChildByName("Label_33")
				local var_45_22 = var_45_18:getChildByName("icon")
				local var_45_23 = var_45_18:getChildByName("Image_gain")
				local var_45_24 = var_45_18:getChildByName("Image_lock")
				local var_45_25 = var_45_18:getChildByName("star")
				local var_45_26 = ItemNoBgSprite:create(var_45_17[iter_45_0].dropid)

				var_45_26:setName("sp_icon")
				var_45_18:addChild(var_45_26, 0)
				var_45_18:loadTextures("public/box/weapon_bg_" .. var_0_10[item_data[var_45_19].equip_quality] .. ".png", "public/box/weapon_bg_" .. var_0_10[item_data[var_45_19].equip_quality] .. ".png", "public/box/weapon_bg_" .. var_0_10[item_data[var_45_19].equip_quality] .. ".png", var_0_9)
				var_45_22:setVisible(false)
				var_45_21:setString("x" .. var_45_17[iter_45_0].dropNum)

				if var_45_23 then
					var_45_23:setVisible(arg_45_1.status == self.RECEIVE_ALL)
				end

				var_45_24:setVisible(not activity_manager:isWarOrderVIP(self.activityId))
				var_45_20:setVisible(item_data[var_45_19].bag_item_type ~= kITEM_SCULTURE)
				var_45_26:setPosition(var_45_22:getPosition())
				var_45_26:setTouchEnabled(false)

				if item_data[var_45_19].bag_item_type == kITEM_HORCRUX and var_45_17[iter_45_0].item_attr then
					local var_45_27 = tonumber(string.sub(var_45_17[iter_45_0].item_attr, 6, 6))

					var_45_25:setVisible(true)
					var_45_25:loadTexture("public/currency/star" .. var_45_27 .. ".png", var_0_9)
				else
					var_45_25:setVisible(false)
				end

				var_45_18:setTouchEnabled(true)
				var_45_18:setSwallowTouches(false)
				var_45_18:addTouchEventListener(function(arg_47_0, arg_47_1)
					if arg_47_1 ~= ccui.TouchEventType.ended then
						return
					end

					if math.abs(arg_47_0:getTouchBeganPosition().y - arg_47_0:getTouchEndPosition().y) > 50 then
						return
					end

					if not activity_manager:isWarOrderVIP(self.activityId) then
						LayerManager:pushInLayer("PopGetWarOrdrBpVIPLayer", {
							activityId = self.activityId,
							warorderId = self.warorderid,
							imagePath = self.layerName
						})

						return
					end

					if arg_45_1.status == self.LEVEL_UNACHIEVE then
						showItemDetails(var_45_19)

						return
					end

					if arg_45_1.status == self.RECEIVE_ALL then
						return
					end

					if arg_45_1.status == self.RECEIVE_ORDINARY and not activity_manager:isWarOrderVIP(self.activityId) then
						return
					end

					activity_manager:getWarOrderLevelReward(self.activityId, arg_45_1.id)
				end)
			else
				var_45_18:setVisible(false)
			end
		end
	end

	return var_45_0
end

function ActivityWarOrderLayer:updateLevelSprite(arg_48_1, arg_48_2)
	if type(arg_48_2.id) == "string" then
		arg_48_1:setVisible(false)
	else
		arg_48_1:setVisible(true)
	end

	arg_48_1:setTag(100)

	local var_48_0 = arg_48_1:getChildByName("level_bg")
	local var_48_1 = var_48_0:getChildByName("lv_num")
	local var_48_2 = type(arg_48_2.id) == "number" and arg_48_2.id % 5 == 0
	local var_48_3 = arg_48_2.status ~= self.LEVEL_UNACHIEVE
	local var_48_4 = cc.p(30, 30)

	if var_48_2 then
		var_48_4 = cc.p(45, 40)
	elseif var_48_2 == false and var_48_3 == true then
		var_48_4 = cc.p(38, 35)
	end

	var_48_1:setPosition(var_48_4)
	var_48_1:setString(arg_48_2.id)

	local var_48_5 = arg_48_1:getChildByName("Image_got_mask")

	if not arg_48_2.status and arg_48_2.id == "?" and var_48_5 then
		var_48_5:setVisible(false)
	elseif var_48_5 then
		if arg_48_2.status == self.RECEIVE_ALL then
			var_48_5:setVisible(true)
			var_48_5:loadTexture(self.layerName .. "/image_got_mask2.png", var_0_9)

			if type(arg_48_2.id) ~= "string" and arg_48_2.specialDrop then
				if activity_manager:getBattlePassDrop(self.activityId, arg_48_2.specialDrop)[2] then
					var_48_5:getChildByName("Image_hook1"):setVisible(true)
					var_48_5:getChildByName("Image_hook2"):setVisible(true)
					var_48_5:getChildByName("Image_hook3"):setVisible(true)
				else
					var_48_5:getChildByName("Image_hook1"):setVisible(true)
					var_48_5:getChildByName("Image_hook2"):setVisible(true)
					var_48_5:getChildByName("Image_hook3"):setVisible(false)
				end
			end
		elseif arg_48_2.status >= self.RECEIVE_ORDINARY then
			var_48_5:setVisible(true)
			var_48_5:loadTexture(self.layerName .. "/image_got_mask1.png", var_0_9)
			var_48_5:getChildByName("Image_hook1"):setVisible(true)
			var_48_5:getChildByName("Image_hook2"):setVisible(false)
			var_48_5:getChildByName("Image_hook3"):setVisible(false)
		else
			var_48_5:setVisible(false)
			var_48_5:getChildByName("Image_hook1"):setVisible(false)
			var_48_5:getChildByName("Image_hook2"):setVisible(false)
			var_48_5:getChildByName("Image_hook3"):setVisible(false)
		end
	end

	if arg_48_2.status ~= self.LEVEL_UNACHIEVE then
		if type(arg_48_2.id) == "number" and arg_48_2.id % 5 == 0 then
			var_48_0:loadTexture(self.layerName .. "/bg_biglv_yidadao.png", var_0_9)
		else
			var_48_0:loadTexture(self.layerName .. "/bg_smalllv_yidadao.png", var_0_9)
		end

		var_48_1:setColor(self.levelNode1:getChildByName("level_bg"):getChildByName("lv_num"):getColor())
	else
		if type(arg_48_2.id) == "number" and arg_48_2.id % 5 == 0 then
			var_48_0:loadTexture(self.layerName .. "/bg_biglv_weidadao.png", var_0_9)
		else
			var_48_0:loadTexture(self.layerName .. "/bg_smalllv_weidadao.png", var_0_9)
		end

		var_48_1:setColor(self.levelNode2:getChildByName("level_bg"):getChildByName("lv_num"):getColor())
	end

	local var_48_6 = arg_48_1:getChildByName("progress_bg")
	local var_48_7 = var_48_6:getChildByName("ProgressBar_lv")

	if type(arg_48_2.id) == "string" or arg_48_2.id == activity_manager:getBattlePassMaxLevel(self.activityId) - 1 then
		var_48_6:setVisible(false)
	elseif arg_48_2.id + 1 < self.curLevel then
		var_48_6:setVisible(true)
		var_48_7:setPercent(100)
	elseif arg_48_2.id + 1 == self.curLevel then
		var_48_6:setVisible(true)
		var_48_7:setPercent((activity_manager:getCurWarOrderLevelProceed(self.activityId, self.curLevel)))
	else
		var_48_6:setVisible(true)
		var_48_7:setPercent(0)
	end

	if type(arg_48_2.id) ~= "string" and arg_48_2.drop then
		local var_48_8 = activity_manager:getBattlePassDrop(self.activityId, arg_48_2.drop)
		local var_48_9 = var_48_8[1].dropid
		local var_48_10 = arg_48_1:getChildByName("item1")
		local var_48_11 = var_48_10:getChildByName("lv_bg")
		local var_48_12 = var_48_10:getChildByName("icon")
		local var_48_13 = var_48_10:getChildByName("Image_gain")
		local var_48_14 = var_48_10:getChildByName("star")
		local var_48_15 = var_48_10:getChildByName("sp_icon")

		var_48_11:getChildByName("Label_33"):setString("x" .. var_48_8[1].dropNum)

		if var_48_13 then
			var_48_13:setVisible(arg_48_2.status >= self.RECEIVE_ORDINARY)
		end

		var_48_11:setVisible(item_data[var_48_9].bag_item_type ~= kITEM_SCULTURE)
		var_48_12:setVisible(false)

		if not var_48_15 then
			var_48_15 = ItemNoBgSprite:create(var_48_9)

			var_48_15:setName("sp_icon")
			var_48_10:addChild(var_48_15, 0)
		end

		var_48_15:updateIcon(var_48_9)
		var_48_15:setPosition(var_48_12:getPosition())
		var_48_15:setTouchEnabled(false)
		var_48_10:loadTextures("public/box/weapon_bg_" .. var_0_10[item_data[var_48_9].equip_quality] .. ".png", "public/box/weapon_bg_" .. var_0_10[item_data[var_48_9].equip_quality] .. ".png", "public/box/weapon_bg_" .. var_0_10[item_data[var_48_9].equip_quality] .. ".png", var_0_9)

		if item_data[var_48_9].bag_item_type == kITEM_HORCRUX and var_48_8[1].item_attr then
			var_48_14:setVisible(true)
			var_48_14:loadTexture("public/currency/star" .. tonumber(string.sub(var_48_8[1].item_attr, 6, 6)) .. ".png", var_0_9)
		else
			var_48_14:setVisible(false)
		end

		var_48_10:setTouchEnabled(true)
		var_48_10:setSwallowTouches(false)
		var_48_10:addTouchEventListener(function(arg_49_0, arg_49_1)
			if arg_49_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_49_0:getTouchBeganPosition().y - arg_49_0:getTouchEndPosition().y) > 50 then
				return
			end

			if arg_48_2.status == self.LEVEL_UNACHIEVE then
				showItemDetails(var_48_9)

				return
			end

			if arg_48_2.status == self.RECEIVE_ALL then
				return
			end

			if arg_48_2.status == self.RECEIVE_ORDINARY and not activity_manager:isWarOrderVIP(self.activityId) then
				return
			end

			activity_manager:getWarOrderLevelReward(self.activityId, arg_48_2.id)
		end)
	end

	if type(arg_48_2.id) ~= "string" and arg_48_2.specialDrop then
		local var_48_16 = activity_manager:getBattlePassDrop(self.activityId, arg_48_2.specialDrop)

		for iter_48_0 = 1, 2 do
			local var_48_17 = arg_48_1:getChildByName("item" .. iter_48_0 + 1)

			var_48_17:setVisible(true)

			if var_48_16[iter_48_0] then
				local var_48_18 = var_48_16[iter_48_0].dropid
				local var_48_19 = var_48_17:getChildByName("lv_bg")
				local var_48_20 = var_48_19:getChildByName("Label_33")
				local var_48_21 = var_48_17:getChildByName("icon")
				local var_48_22 = var_48_17:getChildByName("Image_gain")
				local var_48_23 = var_48_17:getChildByName("Image_lock")
				local var_48_24 = var_48_17:getChildByName("star")
				local var_48_25 = var_48_17:getChildByName("sp_icon")

				if not var_48_25 then
					var_48_25 = ItemNoBgSprite:create(var_48_18)

					var_48_25:setName("sp_icon")
					var_48_17:addChild(var_48_25, 0)
				end

				var_48_17:loadTextures("public/box/weapon_bg_" .. var_0_10[item_data[var_48_18].equip_quality] .. ".png", "public/box/weapon_bg_" .. var_0_10[item_data[var_48_18].equip_quality] .. ".png", "public/box/weapon_bg_" .. var_0_10[item_data[var_48_18].equip_quality] .. ".png", var_0_9)
				var_48_20:setString("x" .. var_48_16[iter_48_0].dropNum)

				if var_48_22 then
					var_48_22:setVisible(arg_48_2.status == self.RECEIVE_ALL)
				end

				var_48_23:setVisible(not activity_manager:isWarOrderVIP(self.activityId))
				var_48_19:setVisible(item_data[var_48_18].bag_item_type ~= kITEM_SCULTURE)
				var_48_21:setVisible(false)
				var_48_25:updateIcon(var_48_18)
				var_48_25:setPosition(var_48_21:getPosition())
				var_48_25:setTouchEnabled(false)

				if item_data[var_48_18].bag_item_type == kITEM_HORCRUX and var_48_16[iter_48_0].item_attr then
					local var_48_26 = tonumber(string.sub(var_48_16[iter_48_0].item_attr, 6, 6))

					var_48_24:setVisible(true)
					var_48_24:loadTexture("public/currency/star" .. var_48_26 .. ".png", var_0_9)
				else
					var_48_24:setVisible(false)
				end

				var_48_17:setTouchEnabled(true)
				var_48_17:setSwallowTouches(false)
				var_48_17:addTouchEventListener(function(arg_50_0, arg_50_1)
					if arg_50_1 ~= ccui.TouchEventType.ended then
						return
					end

					if math.abs(arg_50_0:getTouchBeganPosition().y - arg_50_0:getTouchEndPosition().y) > 50 then
						return
					end

					if not activity_manager:isWarOrderVIP(self.activityId) then
						LayerManager:pushInLayer("PopGetWarOrdrBpVIPLayer", {
							activityId = self.activityId,
							warorderId = self.warorderid,
							imagePath = self.layerName
						})

						return
					end

					if arg_48_2.status == self.LEVEL_UNACHIEVE then
						showItemDetails(var_48_18)

						return
					end

					if arg_48_2.status == self.RECEIVE_ALL then
						return
					end

					if arg_48_2.status == self.RECEIVE_ORDINARY and not activity_manager:isWarOrderVIP(self.activityId) then
						return
					end

					activity_manager:getWarOrderLevelReward(self.activityId, arg_48_2.id)
				end)
			else
				var_48_17:setVisible(false)
			end
		end
	end
end

function ActivityWarOrderLayer:getNeedJumpToIndex()
	local var_51_0, var_51_1 = GetTableViewShowCellIdx(self.levelView, {
		maxcount = math.ceil(self.levelListLen),
		cellsize = cc.size(640, self.LEVEL_CELL_HEIGHT)
	})

	return (self.curLevel + (var_51_1 - var_51_0 - 2) > self.levelListLen or nil) and self.levelListLen
end

function ActivityWarOrderLayer:updateTaskView(arg_52_1, arg_52_2)
	if self.levelView then
		self.levelView:setVisible(false)
	end

	self.taskListData = arg_52_1 or {}
	self.taskListLen = #self.taskListData

	if self.taskView then
		self.taskView:setVisible(true)
		self:updateShowingCells(self.taskView, self.taskListLen, "taskView")

		return
	end

	local var_52_0 = 640
	local var_52_1 = self.TASK_CELL_HEIGHT
	local var_52_2 = self.panelTask:getChildByName("Panel_zi2")
	local var_52_3 = 670 + (GameDisplay.height - 1136) - var_52_2:getContentSize().height / 2

	var_52_2:setPosition(cc.p(320, var_52_3 - 5))

	local var_52_4 = self.panelTask:getChildByName("view")

	var_52_4:setAnchorPoint(cc.p(0, 0))

	self.taskView = Utility:getTableView(self.taskListLen, function(arg_53_0)
		return var_52_0, var_52_1
	end, cc.size(var_52_0, var_52_3 - 10), function(arg_54_0, arg_54_1)
		local var_54_0 = arg_54_0:dequeueCell()

		if not var_54_0 then
			var_54_0 = cc.TableViewCell:create()

			local var_54_2 = self:createTaskSprite(self.taskListData[arg_54_1 + 1])

			var_54_2:getChildByName("btn_Refresh").index = arg_54_1 + 1

			var_54_2:setAnchorPoint(cc.p(0, 0))
			var_54_2:setPosition(cc.p(0, 0))
			var_54_0:addChild(var_54_2)
			var_54_0:setLocalZOrder(999 - 10 * arg_54_1)

			if arg_54_1 < 7 then
				var_54_2:setOpacity(0)
				var_54_2:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_54_1), cc.FadeIn:create(0.1)))
			end
		else
			local var_54_3 = var_54_0:getChildByTag(100)

			var_54_3:getChildByName("btn_Refresh").index = arg_54_1 + 1

			self:updateTaskSprite(var_54_3, self.taskListData[arg_54_1 + 1])
			var_54_0:setLocalZOrder(999 - 10 * arg_54_1)

			if self.showEffect and arg_54_1 < 7 then
				var_54_3:setOpacity(0)
				var_54_3:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_54_1), cc.FadeIn:create(0.1)))
			elseif var_54_3:getOpacity() < 255 then
				var_54_3:setOpacity(255)
			end
		end

		return var_54_0
	end)

	self.taskView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taskView:setVisible(true)
	var_52_4:addChild(self.taskView)
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		self.showEffect = false
	end)))
end

function ActivityWarOrderLayer:createTaskSprite(arg_56_1)
	local var_56_0 = self.taskNode1:clone()

	var_56_0:setName("sprite_bg")
	var_56_0:setVisible(true)
	var_56_0:setTag(100)
	var_56_0:getChildByName("task_img"):loadTexture(self.layerName .. "/icon_bpdianshu.png", var_0_9)
	var_56_0:getChildByName("pt_num"):setString("X" .. activity_manager:getBattlePassDrop(self.activityId, arg_56_1.drop)[1].dropNum)
	var_56_0:getChildByName("name_lbl"):setString(arg_56_1.name)

	local var_56_1 = var_56_0:getChildByName("get_reward_btn")

	if arg_56_1.status >= 1 then
		var_56_1:loadTextures(self.btn_stat_img[self.IS_GETTED], nil, self.btn_stat_img[self.IS_GETTED], var_0_9)
	elseif arg_56_1.percent >= 100 then
		var_56_1:loadTextures(self.btn_stat_img[self.CAN_GET], nil, self.btn_stat_img[self.CAN_GET], var_0_9)
	else
		var_56_1:loadTextures(self.btn_stat_img[self.UN_ACHIEVE], nil, self.btn_stat_img[self.UN_ACHIEVE], var_0_9)
	end

	var_56_1:addTouchEventListener(function(arg_57_0, arg_57_1)
		if arg_57_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_56_1.status >= 1 then
			return
		end

		if arg_56_1.percent >= 100 then
			activity_manager:getWarOrderTaskReward(self.activityId, arg_56_1.taskid)
		else
			self:taskTumpTo(arg_56_1.jump)
		end
	end)

	local var_56_2 = var_56_0:getChildByName("btn_Refresh")

	var_56_2:setVisible(arg_56_1.status < 1)
	var_56_2:addTouchEventListener(function(arg_58_0, arg_58_1)
		if arg_58_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_58_0
		local var_58_1
		local var_58_2
		local var_58_3
		local var_58_4 = activity_manager:getActivityWarOrderFreeCostNum(self.activityId)

		if var_58_4 > 0 then
			var_58_0 = "剩余免费次数："
			var_58_1 = var_58_4
		else
			var_58_0 = "当前每次消耗10魂晶"
			var_58_1 = ""
			var_58_3 = "diamond"
			var_58_2 = 10
		end

		LayerManager:pushInLayer("PopDoLayer", {
			surecallback = function()
				activity_manager:refresh_task_one_item(self.activityId, arg_58_0.index)
			end,
			labels = {
				titleImage = "title_warorder.png"
			},
			costtype = var_58_3,
			cost = var_58_2,
			own = playermodel.diamond,
			desRichTexts = {
				{
					{
						fontSize = 28,
						str = "是否刷新当前任务",
						font = FONT_W5
					}
				},
				{
					{
						fontSize = 20,
						str = var_58_0,
						font = FONT_NAME
					},
					{
						fontSize = 20,
						str = var_58_1,
						color = cc.c3b(0, 255, 181),
						font = FONT_NAME
					}
				}
			}
		})
	end)

	local var_56_3 = var_56_0:getChildByName("progress_bg")
	local var_56_4 = var_56_3:getChildByName("ProgressBar_43")
	local var_56_5 = var_56_3:getChildByName("percent_lbl")
	local var_56_7 = arg_56_1.status == 1 and 100 or arg_56_1.percent >= 0 and arg_56_1.percent or 100

	var_56_4:setPercent(arg_56_1.status == 1 and 100 or arg_56_1.percent >= 0 and arg_56_1.percent or 100)
	var_56_5:setString(var_56_7 .. "%")

	return var_56_0
end

function ActivityWarOrderLayer:updateTaskSprite(arg_60_1, arg_60_2)
	arg_60_1:getChildByName("pt_num"):setString("X" .. activity_manager:getBattlePassDrop(self.activityId, arg_60_2.drop)[1].dropNum)
	arg_60_1:getChildByName("name_lbl"):setString(arg_60_2.name)

	local var_60_0 = arg_60_1:getChildByName("get_reward_btn")

	if arg_60_2.status >= 1 then
		var_60_0:loadTextures(self.btn_stat_img[self.IS_GETTED], nil, self.btn_stat_img[self.IS_GETTED], var_0_9)
	elseif arg_60_2.percent >= 100 then
		var_60_0:loadTextures(self.btn_stat_img[self.CAN_GET], nil, self.btn_stat_img[self.CAN_GET], var_0_9)
	else
		var_60_0:loadTextures(self.btn_stat_img[self.UN_ACHIEVE], nil, self.btn_stat_img[self.UN_ACHIEVE], var_0_9)
	end

	var_60_0:addTouchEventListener(function(arg_61_0, arg_61_1)
		if arg_61_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_60_2.status >= 1 then
			return
		end

		if arg_60_2.percent >= 100 then
			activity_manager:getWarOrderTaskReward(self.activityId, arg_60_2.taskid)
		else
			self:taskTumpTo(arg_60_2.jump)
		end
	end)

	local var_60_2 = arg_60_2.status == 1 and 100 or arg_60_2.percent >= 0 and arg_60_2.percent or 100

	arg_60_1:getChildByName("progress_bg"):getChildByName("ProgressBar_43"):setPercent(arg_60_2.status == 1 and 100 or arg_60_2.percent >= 0 and arg_60_2.percent or 100)
	arg_60_1:getChildByName("progress_bg"):getChildByName("percent_lbl"):setString(var_60_2 .. "%")
	arg_60_1:getChildByName("btn_Refresh"):setVisible(arg_60_2.status < 1)
end

function ActivityWarOrderLayer:updateShowBigGift()
	self.bigGiftPanel:setTouchEnabled(true)

	if self.curLevel >= #self.levelListData then
		self.bigGiftPanel:setVisible(false)

		return
	end

	for iter_62_0 = 1, 3 do
		self.bigGiftPanel:getChildByName("Image_item" .. iter_62_0):setVisible(false)
	end

	local var_62_0 = math.floor((self.curLevel - 1) / 10) * 10 + 10

	if var_62_0 > 40 then
		var_62_0 = 40
	end

	local var_62_1 = self.levelListData[var_62_0]
	local var_62_2 = self.bigGiftPanel:getChildByName("drop_node")

	if var_62_2 then
		var_62_2:removeFromParent()
	end

	if type(var_62_1.id) ~= "string" and var_62_1.drop then
		local var_62_3 = ccui.Layout:create()

		var_62_3:setPosition(cc.p(self.bigGiftPanel:getContentSize().width / 2 + 50, self.LEVEL_CELL_HEIGHT / 2 + 5))
		var_62_3:setName("drop_node")
		self.bigGiftPanel:addChild(var_62_3)

		for iter_62_1, iter_62_2 in pairs((activity_manager:getBattlePassDrop(self.activityId, var_62_1.drop))) do
			local var_62_4 = ItemPurchaseSprite:createPurchaseItem(iter_62_2.dropid)

			var_62_4:setScale(0.6)
			var_62_4:setTouchEnabled(true)
			var_62_4:setSwallowTouches(false)
			var_62_4:setPosition(cc.p(-150 + (iter_62_1 - 1) * 150, 0))
			var_62_4:addTouchEventListener(function(arg_63_0, arg_63_1)
				if arg_63_1 ~= ccui.TouchEventType.ended then
					return
				end

				showItemDetails(iter_62_2.dropid)
			end)
			var_62_3:addChild(var_62_4)
		end
	end

	local var_62_5 = 1
	local var_62_6 = self.bigGiftPanel:getChildByName("special_drop_node")

	if var_62_6 then
		var_62_6:removeFromParent()
	end

	if type(var_62_1.id) ~= "string" and var_62_1.specialDrop then
		local var_62_7 = ccui.Layout:create()

		var_62_7:setPosition(cc.p(self.bigGiftPanel:getContentSize().width / 2 + 100 + var_62_5 * 100, self.LEVEL_CELL_HEIGHT / 2 + 5))
		var_62_7:setName("special_drop_node")
		self.bigGiftPanel:addChild(var_62_7)

		for iter_62_3, iter_62_4 in pairs((activity_manager:getBattlePassDrop(self.activityId, var_62_1.specialDrop))) do
			local var_62_8 = ItemPurchaseSprite:createPurchaseItem(iter_62_4.dropid)

			var_62_8:setScale(0.6)
			var_62_8:setTouchEnabled(true)
			var_62_8:setSwallowTouches(false)
			var_62_8:setPosition(cc.p(-150 + (iter_62_3 - 1) * 150, 0))
			var_62_7:addChild(var_62_8)
			var_62_8:addTouchEventListener(function(arg_64_0, arg_64_1)
				if arg_64_1 ~= ccui.TouchEventType.ended then
					return
				end

				showItemDetails(iter_62_4.dropid)
			end)
		end
	end
end

function ActivityWarOrderLayer.taskTumpTo(arg_65_0, arg_65_1)
	if arg_65_1 == 130 then
		LayerManager:pushInLayer("SignLayerNew", {
			callback = function()
				activity_manager:requestWarOrderTaskInfo(arg_65_0.activityId)
			end
		})
	elseif arg_65_1 == 111 then
		require("controller.sign_manager"):createMidasLayer(function()
			activity_manager:requestWarOrderTaskInfo(arg_65_0.activityId)
		end)
	elseif arg_65_1 == 220 then
		LayerManager:pushInLayer("FightResultLayerNew", {
			createItemType = "itemid",
			items = playermodel.dropcache,
			surecallback = function()
				if FightLayer and FightLayer.getInstance() then
					ccui.Helper:seekWidgetByName(FightLayer.getInstance().rootLayer, "dropcache"):checkPlayerDropCache()
					AnalyticManager.collectDropcache()
				end
			end,
			cancelcallback = function()
				return
			end
		}, {
			exitCallback = function()
				activity_manager:requestWarOrderTaskInfo(arg_65_0.activityId)
			end
		})
	elseif arg_65_1 == 300 then
		LayerManager:pushInLayer("EquipLayer", {
			exitCallback = function()
				activity_manager:requestWarOrderTaskInfo(arg_65_0.activityId)
			end
		})
	elseif arg_65_1 then
		require("controller.goto_system_manager")

		local var_65_0 = {
			jump_to_system = arg_65_1
		}

		var_65_0.config = system_jump_config[SYSTEMID[arg_65_1]] and system_jump_config[SYSTEMID[arg_65_1]].config

		if var_65_0.config then
			if var_65_0.config.exitCallbackType == "function" then
				var_65_0.config.exitCallback = nil
			elseif var_65_0.config.exitCallbackType == "string" then
				var_65_0.config = "MainLayer"
			end
		end

		goto_complete_system(var_65_0)
	end
end

function ActivityWarOrderLayer:updateShowingCells(arg_72_1, arg_72_2, arg_72_3)
	local var_72_0 = {
		maxcount = math.ceil(arg_72_2)
	}

	var_72_0.cellsize = cc.size(640, (arg_72_3 == "taskView" or nil) and (self.TASK_CELL_HEIGHT or self.LEVEL_CELL_HEIGHT))

	local var_72_1, var_72_2 = GetTableViewShowCellIdx(arg_72_1, var_72_0)

	for iter_72_0 = var_72_1, var_72_2 do
		arg_72_1:updateCellAtIndex(iter_72_0)
	end
end

function ActivityWarOrderLayer:fullScreen()
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))

	if self.btn_sign then
		self.btn_sign:setPositionY(self.btn_sign:getPositionY() + GameDisplay.fix_y)
	end

	local var_73_0 = {
		"panel_up"
	}

	for iter_73_0, iter_73_1 in pairs({
		"Image_bottom"
	}) do
		local var_73_1 = self.rootLayer:getChildByName(iter_73_1)

		var_73_1:setLocalZOrder(1)

		var_73_1.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, var_73_1:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

		var_73_1:setPositionY(var_73_1.full_posY)
	end

	for iter_73_2, iter_73_3 in pairs(var_73_0) do
		local var_73_2 = self.rootLayer:getChildByName(iter_73_3)

		var_73_2:setLocalZOrder(1)

		var_73_2.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - var_73_2:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

		var_73_2:setPositionY(var_73_2.full_posY)
	end
end

function ActivityWarOrderLayer:updateAlert()
	local var_74_0 = {
		x = 335,
		y = 70
	}

	if activity_manager:getAlertStatus(self.activityId, "warorder_level") then
		global_add_alert_tag(self.switchBtnLevel, var_74_0)
	else
		global_remove_alert_tag(self.switchBtnLevel)
	end

	if activity_manager:getAlertStatus(self.activityId, "warorder_task") then
		global_add_alert_tag(self.switchBtnTask, var_74_0)
	else
		global_remove_alert_tag(self.switchBtnTask)
	end
end

local var_0_12 = {}

function ActivityWarOrderLayer:showSoulGirlPop(arg_75_1, arg_75_2)
	arg_75_1 = arg_75_1 or {}

	local var_75_0 = activity_manager:getBattlePassLive2d(self.activityId) or "15330"
	local var_75_1 = ccs.GUIReader:getInstance()
	local var_75_2 = var_75_1:widgetFromJsonFile(config._DEBUG and "SoulGirlPop.json" or "SoulGirlPop.ExportJson")
	local var_75_3 = ccui.Helper:seekWidgetByName(var_75_2, "Panel_26")

	var_75_3.setLocalZOrder(var_75_1, 1)
	self:addChild(var_75_2)

	self.showSoulGirlScenePanel = ccui.Helper:seekWidgetByName(var_75_2, "Image_back")

	self.showSoulGirlScenePanel:setPosition(cc.p(320, 568))
	self.showSoulGirlScenePanel:setTouchEnabled(true)
	self.showSoulGirlScenePanel:setLocalZOrder(0)

	local var_75_4 = ccui.Helper:seekWidgetByName(var_75_2, "Button_return")

	if model_data[var_75_0].background and model_data[var_75_0].background == "dark" then
		var_75_4:loadTextures("MarketLayer/return_btn_dark.png", nil, "MarketLayer/return_btn_dark.png", var_0_9)
	else
		var_75_4:loadTextures("MarketLayer/return_btn_bright.png", nil, "MarketLayer/return_btn_bright.png", var_0_9)
	end

	var_75_4:setLocalZOrder(2)

	local function var_75_5(arg_76_0, arg_76_1)
		if arg_76_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.showgirlLayer:resetCurTalkConfig()
		var_75_2:runAction(cc.RemoveSelf:create())

		var_75_2 = nil
	end

	var_75_4:setTouchEnabled(false)
	self.showSoulGirlScenePanel:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function(...)
		var_75_4:setTouchEnabled(true)
		var_75_4:addTouchEventListener(var_75_5)
	end)))

	local var_75_6 = ccui.Helper:seekWidgetByName(var_75_2, "Panel_cute_role")
	local var_75_7 = ccui.Helper:seekWidgetByName(var_75_2, "Image_cute_role")

	var_75_7:loadTexture("roleimage/role1/" .. model_data[var_75_0].cute_role .. ".png")
	var_75_7:setPosition(cc.p(var_75_6:getContentSize().width / 2, var_75_6:getContentSize().height / 2 + 30))
	var_75_7:setScale(0.4)
	var_75_7:setVisible(false)

	local var_75_8 = ccui.Helper:seekWidgetByName(var_75_2, "Panel_up"):setPositionY(568 + GameDisplay.fix_y)
	local var_75_9 = ccui.Helper:seekWidgetByName(var_75_2, "Panel_down"):setPositionY(568 - GameDisplay.fix_y)

	ccui.Helper:seekWidgetByName(var_75_2, "Panel_down"):setLocalZOrder(3)
	ccui.Helper:seekWidgetByName(var_75_2, "Panel_up"):setLocalZOrder(3)

	L2ActorSprite = L2Actor:create(ROLE_SPINE_PATH .. model_data[var_75_0].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_75_0].spine_model .. ".atlas", (model_data[var_75_0].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[var_75_0].clothes_model .. ".atlas" or nil))

	L2ActorSprite:setScale(model_data[var_75_0].modelscale / 1.3 * 0.4, model_data[var_75_0].modelscale / 1.3 * 0.4)
	L2ActorSprite:setContentSize(cc.size(100, 200))
	L2ActorSprite:setPosition(cc.p(var_75_6:getContentSize().width / 2, var_75_6:getContentSize().height / 2 - 60))
	var_75_6:addChild(L2ActorSprite, 99)
	L2ActorSprite:playAni(nil, "idle", true)
	var_75_6:addTouchEventListener(function(arg_78_0, arg_78_1)
		if arg_78_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_78_0 = math.random(2, 5)

		local function var_78_1()
			L2ActorSprite:playAni(nil, "idle", true)
		end

		if var_78_0 == 2 then
			L2ActorSprite:playAni(var_78_1, "run", false)
		elseif var_78_0 == 3 then
			L2ActorSprite:playAni(var_78_1, "yule", false)
		elseif var_78_0 == 4 then
			L2ActorSprite:playAni(var_78_1, "chihe", false)
		else
			L2ActorSprite:playAni(var_78_1, "fadai", false)
		end
	end)

	local var_75_10 = ccui.Helper:seekWidgetByName(var_75_2, "Label_name")
	local var_75_11 = ccui.Helper:seekWidgetByName(var_75_2, "Image_cv")

	var_75_11:loadTexture("public/panelbg/cv_bg.png", var_0_9)

	if favorfile_data[3][model_data[var_75_0].photofile_model] then
		var_75_11:setVisible(favorfile_data[3][model_data[var_75_0].photofile_model] ~= L_CV_UNSURE)

		local var_75_12 = cc.Label:createWithTTF("CV/" .. favorfile_data[3][model_data[var_75_0].photofile_model], FONT_DES, 28)

		var_75_12:setPosition(cc.p(var_75_11:getContentSize().width / 2, var_75_11:getContentSize().height / 2 - 3))
		var_75_11:addChild(var_75_12)
	else
		var_75_11:setVisible(false)
	end

	var_75_10:setFontSize(global_change_fontsize_by_length(model_data[var_75_0].name, 40, 4, 6))
	var_75_10:setString(model_data[var_75_0].name)
	var_75_10:setLocalZOrder(9999)

	local var_75_13 = ccui.Helper:seekWidgetByName(var_75_2, "Label_name_bottom")
	local var_75_14 = ccui.Helper:seekWidgetByName(var_75_2, "Label_name_top")

	var_75_13:setString(model_data[var_75_0].main_name)
	var_75_14:setString(model_data[var_75_0].main_name)

	if model_data[var_75_0].background and model_data[var_75_0].background == "bright" then
		var_75_13:setColor(cc.c3b(40, 125, 205))
		var_75_14:setColor(cc.c3b(0, 255, 246))
	end

	local var_75_15 = ccui.Helper:seekWidgetByName(var_75_2, "Image_type")
	local var_75_16

	if model_data[var_75_0].live2d then
		var_75_16 = "MarketLayer/skin_type_live2d.png"
	elseif model_data[var_75_0].rolespine then
		var_75_16 = "MarketLayer/skin_type_spine.png"
	else
		var_75_15:setVisible(false)
	end

	var_75_15:loadTextures(var_75_16, nil, var_75_16, var_0_9)

	local var_75_17 = ccui.Helper:seekWidgetByName(var_75_2, "Image_cost_bottom")

	var_75_17:loadTexture("MarketLayer/cost_bottom_bright.png", var_0_9)
	var_75_17:setVisible(false)
	ccui.Helper:seekWidgetByName(var_75_2, "Image_name"):loadTexture("MarketLayer/skin_name_bottom_bright.png", var_0_9)

	local var_75_18 = ccui.Helper:seekWidgetByName(var_75_2, "Button_buy")

	var_75_18:loadTextures("MarketLayer/buy_btn_bright.png", nil, "MarketLayer/buy_btn_bright.png", var_0_9)

	local var_75_19 = ccui.Layout:create()

	var_75_19:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_75_19:setAnchorPoint(cc.p(0.5, 0.5))
	var_75_19:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_75_19:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_75_19:setBackGroundColor(cc.c3b(0, 0, 0))
	var_75_19:setBackGroundColorOpacity(0)
	var_75_3:addChild(var_75_19, 2)

	local var_75_20 = cc.EventListenerTouchOneByOne:create()

	var_75_20:setSwallowTouches(false)
	var_75_20:registerScriptHandler(function(arg_80_0, arg_80_1)
		if arg_75_1.have_bought_num == 1 then
			return true
		end

		if var_0_12[playermodel.playerid][var_75_0] > PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT + 1 and arg_75_1.have_bought_num ~= 1 then
			return true
		elseif var_0_12[playermodel.playerid][var_75_0] >= PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT then
			var_0_12[playermodel.playerid][var_75_0] = var_0_12[playermodel.playerid][var_75_0] + 1

			global_ShowBlockWords(L_DORMROOM_SEND_GIFT.Interaciton_Used_Up)

			return false
		else
			return true
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_75_20:registerScriptHandler(function(arg_81_0, arg_81_1)
		return false
	end, cc.Handler.EVENT_TOUCH_ENDED)
	var_75_19:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_75_20, var_75_19)
	var_75_18:setVisible(false)

	if arg_75_1.have_bought_num == 1 then
		var_75_18:setVisible(false)
		var_75_17:setVisible(false)
	end

	local var_75_21 = ccui.Helper:seekWidgetByName(var_75_2, "Image_costType_new")

	self.showSoulGirlScenePanel:setVisible(true)
	var_75_21:setVisible(false)
	ccui.Helper:seekWidgetByName(var_75_2, "Label_cost_num_new"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_75_2, "Panel_old_cost"):setVisible(false)

	self.showgirlLayer = require("view.Layer.ShowGirlLayer"):create(var_75_0, 3)

	self.showgirlLayer:resetCurTalkConfig()

	if not var_0_12[playermodel.playerid] then
		var_0_12[playermodel.playerid] = {}
		var_0_12[playermodel.playerid][var_75_0] = var_0_12[playermodel.playerid][var_75_0] or 0
	else
		var_0_12[playermodel.playerid][var_75_0] = var_0_12[playermodel.playerid][var_75_0] or 0
	end

	self.showgirlLayer:setTalkEnabled(var_0_12[playermodel.playerid][var_75_0] < PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT)
	self.showgirlLayer:setTouchTalkCallback(function()
		var_0_12[playermodel.playerid][var_75_0] = var_0_12[playermodel.playerid][var_75_0] + 1

		self.showgirlLayer:setTalkEnabled(var_0_12[playermodel.playerid][var_75_0] < PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT)
	end)
	var_75_3:addChild(self.showgirlLayer, 1)

	if model_data[var_75_0].backgroundid then
		var_75_3:addChild(BackGroundLayer:create(model_data[var_75_0].backgroundid, (model_data[var_75_0].is_own_full_screen_background == 1 or nil) and 2), 0)
	end
end
