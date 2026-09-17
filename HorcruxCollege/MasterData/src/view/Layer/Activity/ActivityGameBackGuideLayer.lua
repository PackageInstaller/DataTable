local ActivityGameBackGuideLayer = class("ActivityGameBackGuideLayer", function()
	return cc.Layer:create()
end)
local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local activity_return_manager = require("controller.activity_return_manager")
local time_check_manager = require("controller.time_check_manager")
local drop_manager = require("controller.drop_manager")
local back_guide_data = require("data.back_guide_data")
local item_data = require("data.item_data")
local hexie_manager = require("controller.hexie_manager")

require("view.Sprite.ItemSprite")

local Utility = require("common.Utility")
local EventManager = require("common.EventManager")
local LocalEvent = require("common.LocalEvent")
local var_0_12 = config._DEBUG and 0 or 1
local var_0_13 = 640
local var_0_14 = 130
local var_0_15 = {
	WELFARE = 2,
	ACTIVITY = 1,
	GUIDE = 3,
	WAKEFUND = 4
}
local var_0_16 = {
	WELFARE = 2,
	ACTIVITY = 1,
	GUIDE = 3,
	WAKEFUND = 4
}
local var_0_17 = {
	WELFARE = 3,
	SURVEY = 6,
	RECALL = 5,
	SIGN = 1,
	GUIDE = 4,
	WAKEFUND = 9,
	BP = 2,
	REWARD = 8,
	TIMESIGN = 7
}
local var_0_18 = {
	[var_0_15.ACTIVITY] = {
		off = "gameback/btn_limit_off.png",
		on = "gameback/btn_limit_on.png",
		type = var_0_16.ACTIVITY,
		idx = var_0_17.SIGN
	},
	[var_0_15.WELFARE] = {
		off = "gameback/btn_welfare_off.png",
		on = "gameback/btn_welfare_on.png",
		type = var_0_16.WELFARE,
		idx = var_0_17.WELFARE
	},
	[var_0_15.GUIDE] = {
		off = "gameback/btn_guide_off.png",
		on = "gameback/btn_guide_on.png",
		type = var_0_16.GUIDE,
		idx = var_0_17.GUIDE
	},
	[var_0_15.WAKEFUND] = {
		off = "gameback/btn_wakefund_off.png",
		on = "gameback/btn_wakefund_on.png",
		type = var_0_16.WAKEFUND,
		idx = var_0_17.WAKEFUND
	}
}
local var_0_19 = {
	RECALL = 4,
	REWARD = 5,
	BP = 3,
	SIGN = 2,
	SURVEY = 6,
	TIMESIGN = 1
}
local var_0_20 = {
	[var_0_19.TIMESIGN] = {
		off = "gameback/btn_time_sign_off.png",
		on = "gameback/btn_time_sign_on.png",
		idx = var_0_17.TIMESIGN
	},
	[var_0_19.SIGN] = {
		off = "gameback/btn_sign_off.png",
		on = "gameback/btn_sign_on.png",
		idx = var_0_17.SIGN
	},
	[var_0_19.BP] = {
		off = "gameback/btn_bp_off.png",
		on = "gameback/btn_bp_on.png",
		idx = var_0_17.BP
	},
	[var_0_19.RECALL] = {
		off = "gameback/btn_task_off.png",
		on = "gameback/btn_task_on.png",
		idx = var_0_17.RECALL
	}
}
local var_0_23 = {
	UNRECEIVE = 1,
	LEVEL_UNACHIEVE = 0,
	RECEIVE_ALL = 3,
	QIOGN_B = 4,
	RECEIVE_ORDINARY = 2
}
local var_0_24 = {
	TASK = 2,
	LEVEL = 1
}
local var_0_25 = {
	{
		id = 1,
		banner = "gameback/welfare/bg_detail.png",
		btn = "gameback/welfare/btn_detail.png",
		jump = 2123
	},
	{
		id = 8067,
		banner = "gameback/welfare/bg_card.png",
		btn = "gameback/welfare/btn_card.png",
		jump = 3800003
	},
	{
		id = 2050101,
		banner = "gameback/welfare/bg_recharge.png",
		btn = "gameback/welfare/btn_recharge.png",
		jump = "1700113@1700280"
	},
	{
		id = 8069,
		banner = "gameback/welfare/bg_egg.png",
		btn = "gameback/welfare/btn_egg.png",
		jump = 1800843
	},
	{
		id = 3,
		banner = "gameback/welfare/bg_hook.png",
		btn = "gameback/welfare/btn_hook.png",
		jump = 1311
	},
	{
		id = 2210001,
		banner = "gameback/welfare/bg_challenge.png",
		btn = "gameback/welfare/btn_challenge.png",
		jump = 600
	}
}
local var_0_26

function ActivityGameBackGuideLayer:create(...)
	local var_2_0 = ActivityGameBackGuideLayer.new()

	var_2_0:init(...)

	return var_2_0
end

function ActivityGameBackGuideLayer:init(...)
	self:initData(...)
	self:initUI()
	self:registerEvents()
end

function ActivityGameBackGuideLayer:initData(arg_4_1)
	self.activityId = BACKFLOW_BP_ID
	self.layerName = "ActivityGameBackGuideLayer"
	self.switchBtns = {}
	self.activityBtns = {}
	self.panels = {}
	self.isJump = false
	self.showIndex = arg_4_1 and arg_4_1.index

	if self.showIndex == var_0_17.REWARD then
		self.showIndex = nil
	end

	self.showIndex = self.showIndex or var_0_26 or var_0_17.SIGN
	self.recallCode = activity_return_manager:get_recall_code()
	self.preCallCode = 0
end

function ActivityGameBackGuideLayer:initUI()
	self.rootNode = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityGameBackLayer.json" or "ActivityGameBackLayer.ExportJson")

	self:addChild(self.rootNode)
	self.rootNode:setContentSize(GameDisplay.size)
	self.rootNode:setPositionY(-GameDisplay.fix_y)

	self.rootPanel = self.rootNode:getChildByName("rootPanel")
	self.panelMain = self.rootPanel:getChildByName("panelMain")
	self.imgBg = ccui.ImageView:create("mainScenebg/ActivityGameBackLayer.png")

	self.imgBg:setAnchorPoint(0, 0)
	self.imgBg:setPosition(0, 0)
	self.imgBg:setContentSize(config._DESIGN_WIDTH, self.imgBg:getContentSize().height)
	self.imgBg:ignoreContentAdaptWithSize(false)
	self.panelMain:addChild(self.imgBg, -1)

	self.imgTop = self.panelMain:getChildByName("imgTop")

	self.imgTop:setPositionType(0)
	self.imgTop:setPositionY(self.imgTop:getPositionY() - GameDisplay.statusbar_height)

	self.imgBottom = self.panelMain:getChildByName("imgBottom")

	self.imgBottom:setLocalZOrder(5)

	self.btnBack = self.imgBottom:getChildByName("btnBack")
	self.listViewBtns = self.imgBottom:getChildByName("listViewBtns")
	self.listViewActivityBtns = self.imgBottom:getChildByName("listViewActivityBtns")

	self:initSignUI()
	self:initBpUI()
	self:initWelfareUI()
	self:initGuideUI()
	self:initCallUI()
	self:initRewardUI()
	self:initWakefundUI()
	self:initActivityBtns()
	self:initListViewBtns()
	self:updateRedDotAlert()
	self:autoSwitchPanel()
end

function ActivityGameBackGuideLayer:autoSwitchPanel()
	local var_6_0 = self:queryBtnByPanelIndex(self.showIndex)

	if var_6_0 and (self.showIndex == var_0_17.SIGN or self.showIndex == var_0_17.BP or self.showIndex == var_0_17.RECALL or self.showIndex == var_0_17.SURVEY or self.showIndex == var_0_17.REWARD) then
		self.specifiedBtn = var_6_0

		self:onBtnSwitch(self.switchBtns[1])
	elseif var_6_0 then
		self:onBtnSwitch(var_6_0)
	else
		self:onBtnSwitch(self.switchBtns[1])
	end
end

function ActivityGameBackGuideLayer:initActivityBtns()
	self.listViewActivityBtns:removeAllChildren()

	for iter_7_0, iter_7_1 in ipairs(var_0_20) do
		local var_7_0 = ccui.Button:create(iter_7_1.off, iter_7_1.off, iter_7_1.on, var_0_12)

		self.listViewActivityBtns:pushBackCustomItem(var_7_0)
		Utility:addClickEventListener(var_7_0, handler(self, self.onBtnSwitchActivity))

		var_7_0.idx = iter_7_1.idx
		self.activityBtns[#self.activityBtns + 1] = var_7_0

		var_7_0:setVisible(false)
	end
end

function ActivityGameBackGuideLayer:onBtnSwitchActivity(arg_8_1)
	if Utility:indexOf(self.activityBtns, arg_8_1) < 0 then
		return
	end

	for iter_8_0, iter_8_1 in ipairs(self.activityBtns) do
		if iter_8_1 == arg_8_1 then
			iter_8_1:setBright(false)
			iter_8_1:setEnabled(false)
		else
			iter_8_1:setEnabled(true)
			iter_8_1:setBright(true)
		end
	end

	var_0_26 = arg_8_1.idx
	self.specifiedBtn = nil

	self:showPageWidthIndex(arg_8_1.idx)
end

function ActivityGameBackGuideLayer:queryBtnByPanelIndex(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(self.activityBtns) do
		if iter_9_1.idx == arg_9_1 then
			return iter_9_1
		end
	end

	for iter_9_2, iter_9_3 in ipairs(self.switchBtns) do
		if iter_9_3.idx == arg_9_1 then
			return iter_9_3
		end
	end
end

function ActivityGameBackGuideLayer:initListViewBtns()
	self.listViewBtns:removeAllChildren()

	for iter_10_0, iter_10_1 in ipairs(var_0_18) do
		local var_10_0 = ccui.Button:create(iter_10_1.off, iter_10_1.off, iter_10_1.on, var_0_12)

		self.listViewBtns:pushBackCustomItem(var_10_0)
		Utility:addClickEventListener(var_10_0, handler(self, self.onBtnSwitch))

		var_10_0.btnType = iter_10_1.type
		var_10_0.idx = iter_10_1.idx
		self.switchBtns[#self.switchBtns + 1] = var_10_0

		var_10_0:setVisible(false)
	end
end

function ActivityGameBackGuideLayer:onBtnSwitch(arg_11_1)
	if Utility:indexOf(self.switchBtns, arg_11_1) < 0 then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(self.switchBtns) do
		if iter_11_1 == arg_11_1 then
			iter_11_1:setBright(false)
			iter_11_1:setEnabled(false)
		else
			iter_11_1:setEnabled(true)
			iter_11_1:setBright(true)
		end
	end

	local var_11_0 = arg_11_1.btnType

	self.listViewActivityBtns:setVisible(arg_11_1.btnType == var_0_16.ACTIVITY)

	var_0_26 = arg_11_1.idx

	if var_11_0 == var_0_16.ACTIVITY then
		self:onBtnSwitchActivity(self.specifiedBtn or self.activityBtns[1])
	else
		self:showPageWidthIndex(arg_11_1.idx)
	end
end

function ActivityGameBackGuideLayer:showPageWidthIndex(arg_12_1)
	print("current show index", arg_12_1)

	for iter_12_0, iter_12_1 in pairs(self.panels) do
		iter_12_1:setVisible(false)
	end

	self.panels[arg_12_1]:setVisible(true)
	self:executeRequestByIndex(arg_12_1)
end

function ActivityGameBackGuideLayer:executeRequestByIndex(arg_13_1)
	if arg_13_1 == var_0_17.TIMESIGN then
		activity_return_manager:get_returnback_timesign_info()
	elseif arg_13_1 == var_0_17.SIGN then
		activity_return_manager:get_returnback_info()
	elseif arg_13_1 == var_0_17.BP then
		self:onBtnLevel()
	elseif arg_13_1 == var_0_17.WELFARE then
		self:updateWelfareUI()
	elseif arg_13_1 == var_0_17.GUIDE then
		activity_manager:getBPReturnbackGuideList(self.activityId)
	elseif arg_13_1 == var_0_17.RECALL then
		activity_manager:getExtraTaskList(self.activityId, "recall")
	elseif arg_13_1 == var_0_17.SURVEY then
		self:updateSurveyUI()
	elseif arg_13_1 == var_0_17.REWARD then
		activity_return_manager:get_returnback_reward_task()
	end
end

function ActivityGameBackGuideLayer:initSignUI()
	if activity_manager:getSignVersion(176) >= 4 then
		self.panelSign = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityNoviceThirtyTaskLayer.json" or "ActivityNoviceThirtyTaskLayer.ExportJson")

		self.panelSign:setPositionY(GameDisplay.fix_y)
		self.panelMain:addChild(self.panelSign)

		self.panelSignItem = ccui.Helper:seekWidgetByName(self.panelSign, "label_exp")

		self.panelSignItem:retain()
		self.panelSignItem:removeFromParent()
		ccui.Helper:seekWidgetByName(self.panelSign, "Image_bg"):loadTexture("gameback/sign/bg.png", var_0_12)

		if activity_manager:getSignVersion(176) >= 7 then
			ccui.Helper:seekWidgetByName(self.panelSign, "Image_banner"):loadTexture("gameback/sign/banner_replace.png", var_0_12)
		else
			ccui.Helper:seekWidgetByName(self.panelSign, "Image_banner"):loadTexture("gameback/sign/banner.png", var_0_12)
		end

		activity_manager:getActivitySignData(176, function(arg_15_0)
			self.taskList = {}
			self._signcount = 0

			for iter_15_0, iter_15_1 in pairs(arg_15_0.otherData.drops) do
				if arg_15_0.signstats[iter_15_0] then
					self._signcount = self._signcount + 1
				end

				table.insert(self.taskList, {
					drops = iter_15_1,
					signstats = arg_15_0.signstats[iter_15_0],
					day = iter_15_0
				})
			end

			table.sort(self.taskList, function(arg_16_0, arg_16_1)
				if arg_16_0.signstats and arg_16_1.signstats then
					return arg_16_0.day < arg_16_1.day
				elseif not arg_16_0.signstats and not arg_16_1.signstats then
					return arg_16_0.day < arg_16_1.day
				else
					return not arg_16_0.signstats
				end
			end)

			self._cansign = arg_15_0.cansign

			self:updateSignUI()
		end)
	else
		self.panelSign = self.panelMain:getChildByName("panelSign")
		self.imgBannerSign = self.panelSign:getChildByName("imgBannerSign")

		self.imgBannerSign:setPositionType(0)
		self.imgBannerSign:setPositionY(self.imgBannerSign:getPositionY() - GameDisplay.statusbar_height)

		self.labelRemainTimeSign = self.imgBannerSign:getChildByName("labelRemainTime")
		self.listViewSign = self.panelSign:getChildByName("listViewSign")

		self.listViewSign:setContentSize(cc.size(config._DESIGN_WIDTH, self.listViewSign:getContentSize().height + GameDisplay.height - config._DESIGN_HEIGHT - 10))

		self.panelSignItem = self.panelSign:getChildByName("panelSignItem")

		self.panelSignItem:retain()
		self.panelSignItem:removeFromParent()
	end

	self.panels[var_0_17.SIGN] = self.panelSign
	self.panels[var_0_17.TIMESIGN] = self.panelSign
end

function ActivityGameBackGuideLayer:updateTimeSignUI(arg_17_1)
	local var_17_0 = arg_17_1.signCount or 7
	local var_17_1 = arg_17_1.canSign
	local var_17_2 = arg_17_1.finishTime or 0
	local var_17_3 = time_check_manager:getCurTime()

	self.imgBannerSign:loadTexture("gameback/sign_258/top_banner.png", var_0_12)

	if var_17_2 > 0 then
		self.labelRemainTimeSign:setString("剩余时间:" .. Utility:formatTimeStr(var_17_2 - var_17_3))
		self.labelRemainTimeSign:stopAllActions()
		self.labelRemainTimeSign:runAction((Utility:createClockTimerAction(self.labelRemainTimeSign, 1, var_17_2 - var_17_3, function(arg_18_0, arg_18_1)
			self.labelRemainTimeSign:setString("剩余时间:" .. Utility:formatTimeStr(arg_18_0))
		end)))
	else
		self.labelRemainTimeSign:setString("活动已结束")
	end

	self.listViewSign:removeAllChildren()

	if not var_17_1 then
		var_17_0 = var_17_0 + 1
	end

	for iter_17_0, iter_17_1 in ipairs((self:sortSignData(global_deepCopy(arg_17_1.timeSignData), var_17_0, var_17_1))) do
		self.listViewSign:pushBackCustomItem((self:createOneSignItem(iter_17_1, var_17_0, var_17_1, "timesign", iter_17_0)))
	end

	self.listViewSign:doLayout()
	self.listViewSign:jumpToPercentVertical(0)
end

function ActivityGameBackGuideLayer:updateSignUI()
	if activity_manager:getSignVersion(176) < 4 then
		local var_19_0 = activity_return_manager:get_sign_count() or 7
		local var_19_1 = activity_return_manager:get_can_sign()
		local var_19_2 = activity_return_manager:get_end_time() or 0
		local var_19_3 = time_check_manager:getCurTime()

		if var_19_2 > 0 then
			self.labelRemainTimeSign:setString("剩余时间:" .. Utility:formatTimeStr(var_19_2 - var_19_3))
			self.labelRemainTimeSign:stopAllActions()
			self.labelRemainTimeSign:runAction((Utility:createClockTimerAction(self.labelRemainTimeSign, 1, var_19_2 - var_19_3, function(arg_20_0, arg_20_1)
				self.labelRemainTimeSign:setString("剩余时间:" .. Utility:formatTimeStr(arg_20_0))
			end)))
		else
			self.labelRemainTimeSign:setString("活动已结束")
		end

		self.listViewSign:removeAllChildren()

		if not var_19_1 then
			var_19_0 = var_19_0 + 1
		end

		for iter_19_0, iter_19_1 in ipairs((self:sortSignData(global_deepCopy((activity_return_manager:get_return_sign_data())), var_19_0, var_19_1))) do
			local var_19_4 = self:createOneSignItem(iter_19_1, var_19_0, var_19_1)

			var_19_4:setOpacity(0)
			var_19_4:runAction(cc.Sequence:create(cc.DelayTime:create(iter_19_0 * 0.1 - 0.1), cc.FadeIn:create(0.2)))
			self.listViewSign:pushBackCustomItem(var_19_4)
		end

		self.listViewSign:doLayout()
		self.listViewSign:jumpToPercentVertical(0)
	else
		if self.taskView then
			self.taskView:reloadData()

			return
		end

		self.taskView = cc.TableView:create(cc.size(589, 940))

		self.taskView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
		self.taskView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
		self.taskView:setAnchorPoint(cc.p(0, 0))
		self.taskView:setPosition(196, 110)
		self.taskView:setDelegate()
		self.panelSign:addChild(self.taskView, 1000)
		self.taskView:registerScriptHandler(function(arg_22_0, arg_22_1)
			return 640, 137
		end, cc.TABLECELL_SIZE_FOR_INDEX)
		self.taskView:registerScriptHandler(function(arg_21_0, arg_21_1)
			local var_21_0 = arg_21_0:dequeueCell()

			if not var_21_0 then
				var_21_0 = cc.TableViewCell:create()

				var_21_0:setName("cell_" .. arg_21_1)

				local var_21_1 = self:createTaskInfoPanel(self.taskList[arg_21_1 + 1], arg_21_1)

				var_21_1:setName("taskinfo")
				var_21_1:setPosition(cc.p(0, 20))
				var_21_0:addChild(var_21_1)
			else
				var_21_0:getChildByName("taskinfo"):updateTaskInfo(self.taskList[arg_21_1 + 1])
			end

			return var_21_0
		end, cc.TABLECELL_SIZE_AT_INDEX)
		self.taskView:registerScriptHandler(function(arg_23_0, arg_23_1)
			return #self.taskList
		end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
		self.taskView:reloadData()
		self.taskView:scrollToIndex(self._signcount + 6, false)
	end
end

function ActivityGameBackGuideLayer:createTaskInfoPanel(arg_24_1, arg_24_2)
	local var_24_0 = self.panelSignItem:clone()

	var_24_0.index = arg_24_2

	function var_24_0:updateTaskInfo(arg_25_1)
		local var_25_0 = self:getChildByName("label_day")

		if self:getChildByName("title_label") then
			self:getChildByName("title_label"):removeFromParent()
		end

		var_25_0:setVisible(false)

		local var_25_1 = cc.Label:createWithTTF(arg_25_1.day, FONT_DES, 60)

		var_25_1:setName("title_label")
		var_25_1:setPosition(var_25_0:getPositionX(), var_25_0:getPositionY())
		self:addChild(var_25_1)

		self.taskinfo = arg_25_1

		self:updateFinishedTask()
	end

	function var_24_0:updateFinishedTask()
		local var_26_0 = self.taskinfo
		local var_26_1 = drop_manager:getDropMsg(self.taskinfo.drops)

		if not next(var_26_1.equips) and var_26_1.diamond > 0 then
			var_26_1.equips[1] = {
				dropid = "diamond"
			}
		end

		self:getChildByName("button_getAwards"):setVisible(false)

		for iter_26_0, iter_26_1 in pairs(var_26_1.equips) do
			if self:getChildByName("item_sp_" .. iter_26_0) then
				self:getChildByName("item_sp_" .. iter_26_0):removeFromParent()
			end

			local var_26_2 = ItemPurchaseSprite:createPurchaseItem(var_26_1.equips[iter_26_0].dropid)
			local var_26_3 = self:getChildByName("Image_task_" .. iter_26_0)

			self:getChildByName("Image_task_" .. iter_26_0):setVisible(false)
			var_26_2:setName("item_sp_" .. iter_26_0)
			var_26_2:setScale(0.5)
			var_26_2:setPosition(cc.p(var_26_3:getPositionX(), var_26_3:getPositionY()))
			self:addChild(var_26_2)
			var_26_2:setTouchEnabled(true)
			var_26_2:addTouchEventListener(function(arg_27_0, arg_27_1)
				if arg_27_1 ~= ccui.TouchEventType.ended then
					return
				end

				showItemDetails(var_26_1.equips[iter_26_0].dropid)
			end)

			local var_26_4 = self:getChildByName("Label_name_" .. iter_26_0)

			if var_26_1.equips[iter_26_0] and var_26_1.equips[iter_26_0].dropid then
				if var_26_1.equips[iter_26_0].dropNum > 1 then
					var_26_4:setString("x" .. var_26_1.equips[iter_26_0].dropNum)
				end

				local var_26_6

				do
					var_26_4:setString(item_data[var_26_1.equips[iter_26_0].dropid].name)

					var_26_6 = var_26_4:getContentSize().width > 106 and 106 / var_26_4:getContentSize().width or 1
				end

				var_26_4:setScaleX(var_26_6)
			end
		end

		if self._signcount + 1 == self.taskinfo.day then
			if self._cansign then
				self:getChildByName("button_getAwards"):setVisible(true)
				self:getChildByName("button_done"):setVisible(false)
				self:getChildByName("button_getAwards"):addTouchEventListener(function(arg_28_0, arg_28_1)
					if arg_28_1 ~= ccui.TouchEventType.ended then
						return
					end

					activity_manager:activitySign(176, var_26_0.day, function(arg_29_0)
						self._cansign = false
						self._signcount = self._signcount + 1

						activity_manager:updateActivityAlert("sign", 176, false)

						if self._signcount >= 30 then
							activity_manager:update_module_stat(176, "sign", true)
						end

						self.taskView:scrollToIndex(self._signcount + 6, false)
					end)
					self:getChildByName("button_getAwards"):setVisible(false)
					self:getChildByName("button_done"):setVisible(true)
				end)
			else
				self:getChildByName("button_getAwards"):setVisible(false)
				self:getChildByName("button_done"):setVisible(false)
			end
		end

		if self._signcount + 1 > self.taskinfo.day then
			self:getChildByName("button_getAwards"):setVisible(false)
			self:getChildByName("button_done"):setVisible(true)
		end

		if self._signcount + 1 < self.taskinfo.day then
			self:getChildByName("button_getAwards"):setVisible(false)
			self:getChildByName("button_done"):setVisible(false)
		end
	end

	var_24_0:updateTaskInfo(arg_24_1)

	return var_24_0
end

function ActivityGameBackGuideLayer:sortSignData(arg_30_1, arg_30_2, arg_30_3)
	arg_30_2 = arg_30_3 and arg_30_2 + 1 or arg_30_2

	for iter_30_0, iter_30_1 in ipairs(arg_30_1) do
		iter_30_1.isSign = arg_30_2 > iter_30_1.id and 1 or 0
	end

	table.sort(arg_30_1, function(arg_31_0, arg_31_1)
		if arg_31_0.isSign == arg_31_1.isSign then
			return arg_31_0.id < arg_31_1.id
		else
			return arg_31_0.isSign < arg_31_1.isSign
		end
	end)

	return arg_30_1
end

function ActivityGameBackGuideLayer:initBpUI()
	self.panelBp = self.panelMain:getChildByName("panelBp")
	self.imgBannerBp = self.panelBp:getChildByName("imgBannerBp")

	self.imgBannerBp:setPositionType(0)
	self.imgBannerBp:setPositionY(self.imgBannerBp:getPositionY() - GameDisplay.statusbar_height)

	self.btnOpen = self.imgBannerBp:getChildByName("btnOpen")

	Utility:addClickEventListener(self.btnOpen, handler(self, self.onBtnOpen))

	self.labelLevelBp = Utility:seekChildByName(self.imgBannerBp, "labelLevel")
	self.labelExpBp = self.imgBannerBp:getChildByName("labelExp")
	self.btnLevel = self.imgBannerBp:getChildByName("btnLevel")

	Utility:addClickEventListener(self.btnLevel, handler(self, self.onBtnLevel))

	self.btnTask = self.imgBannerBp:getChildByName("btnTask")

	Utility:addClickEventListener(self.btnTask, handler(self, self.onBtnTask))

	self.labelRemainTimeBp = self.imgBannerBp:getChildByName("labelRemainTime")
	self.imgRewardTitle = self.imgBannerBp:getChildByName("imgRewardTitle")
	self.btnBuy = self.imgBannerBp:getChildByName("btnBuy")

	Utility:addClickEventListener(self.btnBuy, handler(self, self.onBtnBuy))

	self.imgTitle = self.imgBannerBp:getChildByName("imgTitle")

	Utility:addClickEventListener(self.imgTitle, handler(self, self.onBtnDetail))

	self.progressBarBp = Utility:seekChildByName(self.imgBannerBp, "progressBar")
	self.panelLevel = self.panelBp:getChildByName("panelLevel")
	self.panelLevelItem = self.panelLevel:getChildByName("panelLevelItem")

	self.panelLevelItem:retain()
	self.panelLevelItem:removeFromParent()

	self.panelTask = self.panelBp:getChildByName("panelTask")
	self.panelTaskItem = self.panelTask:getChildByName("panelTaskItem")

	self.panelTaskItem:retain()
	self.panelTaskItem:removeFromParent()

	self.imgRewardPreview = self.panelBp:getChildByName("imgRewardPreview")
	self.btnWholeGet = self.imgRewardPreview:getChildByName("btnWholeGet")

	Utility:addClickEventListener(self.btnWholeGet, handler(self, self.onBtnWholeGet))

	self.panels[var_0_17.BP] = self.panelBp

	self:initTimeLabel()
end

function ActivityGameBackGuideLayer:onBtnOpen()
	if activity_manager:isBattlePassSVIP(self.activityId) then
		if self.curLevel >= activity_manager:getBPMaxLevel(self.activityId) then
			global_ShowBlockWords(L_MAX_LEVLE)

			return
		end

		LayerManager:pushInLayer("PopBattlePassBuyLayer", {
			imagePath = "Activity_return_BPBasic",
			activityId = self.activityId
		})
	else
		LayerManager:pushInLayer(activity_manager:getBuyVipJumpTo(self.activityId), {
			imagePath = "Activity_return_BPBasic",
			activityId = self.activityId
		})
	end
end

function ActivityGameBackGuideLayer:onBtnLevel()
	self.btnLevel:loadTextures("Activity_return_BPBasic/switch_btn_jiangli_on.png", "Activity_return_BPBasic/switch_btn_jiangli_on.png", "Activity_return_BPBasic/switch_btn_jiangli_on.png", var_0_12)
	self.btnTask:loadTextures("Activity_return_BPBasic/switch_btn_task_off.png", "Activity_return_BPBasic/switch_btn_task_off.png", "Activity_return_BPBasic/switch_btn_task_off.png", var_0_12)

	self.showTypeBp = var_0_24.LEVEL

	self.panelLevel:setVisible(true)
	self.panelTask:setVisible(false)
	self.imgRewardTitle:setVisible(true)
	self.imgRewardPreview:setVisible(true)

	if self.tableViewLevel then
		self.tableViewLevel:setVisible(true)
	end

	if self.tableViewTask then
		self.tableViewTask:setVisible(false)
	end

	self.imgRewardPreview:setTouchEnabled(true)
	activity_manager:getBattlePassLevelData(self.activityId)
end

function ActivityGameBackGuideLayer:onBtnTask()
	self.btnLevel:loadTextures("Activity_return_BPBasic/switch_btn_jiangli_off.png", "Activity_return_BPBasic/switch_btn_jiangli_off.png", "Activity_return_BPBasic/switch_btn_jiangli_off.png", var_0_12)
	self.btnTask:loadTextures("Activity_return_BPBasic/switch_btn_task_on.png", "Activity_return_BPBasic/switch_btn_task_on.png", "Activity_return_BPBasic/switch_btn_task_on.png", var_0_12)

	self.showTypeBp = var_0_24.TASK

	self.panelLevel:setVisible(false)
	self.panelTask:setVisible(true)
	self.imgRewardTitle:setVisible(false)
	self.imgRewardPreview:setVisible(false)

	if self.tableViewLevel then
		self.tableViewLevel:setVisible(false)
	end

	if self.tableViewTask then
		self.tableViewTask:setVisible(true)
	end

	self.imgRewardPreview:setTouchEnabled(false)
	activity_manager:getActivityTask(self.activityId)
end

function ActivityGameBackGuideLayer:onBtnWholeGet()
	if self.showTypeBp == var_0_24.LEVEL then
		if not activity_manager:isHasRewardCanGet(self.activityId) then
			global_ShowBlockWords(L_BATTLE_PASS.NOT_REWARD_CAN_GET)

			return
		end

		activity_manager:getBattlePassReward(self.activityId)
	else
		if not activity_manager:isHasCanCompleteTask(self.activityId) then
			global_ShowBlockWords(L_BATTLE_PASS.NOT_REWARD_CAN_GET)

			return
		end

		activity_manager:getBPTaskRewardOneKey(self.activityId)
	end
end

function ActivityGameBackGuideLayer:onBtnBuy()
	if not activity_manager:isBattlePassVIP(self.activityId) then
		return
	end

	if self.curLevel >= activity_manager:getBPMaxLevel(self.activityId) then
		global_ShowBlockWords(L_MAX_LEVLE)

		return
	end

	LayerManager:pushInLayer("PopBattlePassBuyLayer", {
		imagePath = "Activity_return_BPBasic",
		activityId = self.activityId
	})
end

function ActivityGameBackGuideLayer:onBtnDetail()
	LayerManager:pushInLayer("PopActivityDetail", {
		key = "Activity_return_BPBasic"
	})
end

function ActivityGameBackGuideLayer:updateBpTopUI()
	self.curLevel = activity_manager:getCurBattlePassLevel(self.activityId) or 0

	self.labelLevelBp:setString(self.curLevel - 1)

	if self.curLevel > activity_manager:getBPMaxLevel(self.activityId) then
		self.labelLevelBp:setString("Max")
	end

	local var_39_0, var_39_1 = activity_manager:getCurLevelProceed(self.activityId, self.curLevel)

	self.labelExpBp:setString(var_39_1)
	self.progressBarBp:setPercent(var_39_0)
	self.imgRewardTitle:getChildByName("imgLock"):setVisible(not activity_manager:isBattlePassVIP(self.activityId))

	local var_39_2 = self.imgBannerBp:getChildByName("upup")

	self.btnBuy:setVisible(activity_manager:isBattlePassVIP(self.activityId))

	if activity_manager:isBattlePassSVIP(self.activityId) then
		self.btnOpen:loadTextures("Activity_return_BPBasic/btn_yiquanbugoumai.png", "Activity_return_BPBasic/btn_yiquanbugoumai.png", "Activity_return_BPBasic/btn_yiquanbugoumai.png", var_0_12)
	elseif activity_manager:isBattlePassVIP(self.activityId) then
		self.btnOpen:loadTextures("Activity_return_BPBasic/btn_shengji.png", "Activity_return_BPBasic/btn_shengji.png", "Activity_return_BPBasic/btn_shengji.png", var_0_12)
	else
		self.btnOpen:loadTextures("Activity_return_BPBasic/btn_kaiqizhiyuan.png", "Activity_return_BPBasic/btn_kaiqizhiyuan.png", "Activity_return_BPBasic/btn_kaiqizhiyuan.png", var_0_12)
	end
end

function ActivityGameBackGuideLayer:initTimeLabel()
	self.activityScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(global_get_time_by_date((activity_manager:get_module_finishtime(self.activityId, "bp"))) - time_check_manager:getCurTime(), function(arg_41_0)
		self.labelRemainTimeBp:setString(L_LEFT_TIME_SPACE .. Utility:formatTimeStr(arg_41_0))

		if arg_41_0 <= 0 and self.activityScheduler then
			LayerManager:switchShowLayer("MainLayer")
			time_check_manager:removeUpdatePool(self.activityScheduler)

			self.activityScheduler = nil
		end
	end)))
end

function ActivityGameBackGuideLayer:updateLevelView(arg_42_1, arg_42_2)
	if not self.curLevel or self.curLevel < 0 then
		return
	end

	self.levelListLen = arg_42_2
	self.levelListData = arg_42_1 or {}

	if self.tableViewLevel then
		self:updateShowingCells(self.tableViewLevel, self.levelListLen)

		return
	end

	self.tableViewLevel = cc.TableView:create(cc.size(var_0_13, self.panelLevel:getContentSize().height + GameDisplay.height - config._DESIGN_HEIGHT))

	self.tableViewLevel:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableViewLevel:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableViewLevel:setAnchorPoint(cc.p(0, 0))
	self.tableViewLevel:setDelegate()
	self.panelLevel:addChild(self.tableViewLevel)
	self.tableViewLevel:registerScriptHandler(handler(self, self.onNumberOfCellsLevel), cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableViewLevel:registerScriptHandler(handler(self, self.onCellSizeForIndexLevel), cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableViewLevel:registerScriptHandler(handler(self, self.onCellSizeAtIndexLevel), cc.TABLECELL_SIZE_AT_INDEX)
	self.tableViewLevel:reloadData()
	self.tableViewLevel:scrollToIndex(self:getNeedJumpToIndex(), false)
end

function ActivityGameBackGuideLayer:onNumberOfCellsLevel(arg_43_1)
	return self.levelListLen - 1
end

function ActivityGameBackGuideLayer:onCellSizeForIndexLevel()
	return var_0_13, var_0_14
end

function ActivityGameBackGuideLayer:onCellSizeAtIndexLevel(arg_45_1, arg_45_2)
	local var_45_0 = arg_45_1:dequeueCell()

	if not var_45_0 then
		var_45_0 = cc.TableViewCell:create()

		local var_45_1 = self:createOneLevelItem(self.levelListData[arg_45_2 + 1])

		var_45_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_45_1:setPosition(cc.p(320, 65))
		var_45_1:setName("panelLevelItem")
		var_45_0:addChild(var_45_1)
		var_45_0:setLocalZOrder(999 - 10 * arg_45_2)
	else
		self:updateOneLevelItem(var_45_0:getChildByName("panelLevelItem"), self.levelListData[arg_45_2 + 1])
		var_45_0:setLocalZOrder(999 - 10 * arg_45_2)
	end

	return var_45_0
end

function ActivityGameBackGuideLayer:updateShowingCells(arg_46_1, arg_46_2)
	local var_46_0, var_46_1 = GetTableViewShowCellIdx(arg_46_1, {
		maxcount = math.ceil(arg_46_2),
		cellsize = cc.size(var_0_13, var_0_14)
	})

	for iter_46_0 = var_46_0, var_46_1 do
		arg_46_1:updateCellAtIndex(iter_46_0)
	end
end

function ActivityGameBackGuideLayer:getNeedJumpToIndex()
	local var_47_0, var_47_1 = GetTableViewShowCellIdx(self.tableViewLevel, {
		maxcount = math.ceil(self.levelListLen),
		cellsize = cc.size(var_0_13, var_0_14)
	})

	return (self.curLevel + (var_47_1 - var_47_0 - 2) > self.levelListLen or nil) and self.levelListLen
end

function ActivityGameBackGuideLayer:updateTaskView(arg_48_1, arg_48_2)
	self.taskListData = activity_manager:getActivityTaskData(self.activityId) or {}
	self.taskListLen = #self.taskListData

	if self.tableViewTask then
		self:updateShowingCells(self.tableViewTask, self.taskListLen)

		return
	end

	self.tableViewTask = cc.TableView:create(cc.size(var_0_13, self.panelTask:getContentSize().height + GameDisplay.height - config._DESIGN_HEIGHT))

	self.tableViewTask:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableViewTask:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableViewTask:setAnchorPoint(cc.p(0, 0))
	self.tableViewTask:setDelegate()
	self.panelTask:addChild(self.tableViewTask)
	self.tableViewTask:registerScriptHandler(handler(self, self.onNumberOfCellsTask), cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableViewTask:registerScriptHandler(handler(self, self.onCellSizeForIndexTask), cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableViewTask:registerScriptHandler(handler(self, self.onCellSizeAtIndexTask), cc.TABLECELL_SIZE_AT_INDEX)
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		self.showEffect = false
	end)))
	self.tableViewTask:reloadData()
end

function ActivityGameBackGuideLayer:onNumberOfCellsTask(arg_50_1)
	return self.taskListLen
end

function ActivityGameBackGuideLayer:onCellSizeForIndexTask()
	return var_0_13, var_0_14
end

function ActivityGameBackGuideLayer:onCellSizeAtIndexTask(arg_52_1, arg_52_2)
	local var_52_0 = arg_52_1:dequeueCell()

	if not var_52_0 then
		var_52_0 = cc.TableViewCell:create()

		local var_52_1 = self:createOneTaskItem(self.taskListData[arg_52_2 + 1])

		var_52_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_52_1:setPosition(cc.p(var_0_13 / 2, var_0_14 / 2))
		var_52_1:setName("panelTaskItem")
		var_52_0:addChild(var_52_1)
		var_52_0:setLocalZOrder(999 - 10 * arg_52_2)

		if arg_52_2 < 7 then
			var_52_1:setOpacity(0)
			var_52_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_52_2), cc.FadeIn:create(0.1)))
		end
	else
		local var_52_2 = var_52_0:getChildByName("panelTaskItem")

		self:updateOneTaskItem(var_52_2, self.taskListData[arg_52_2 + 1])
		var_52_0:setLocalZOrder(999 - 10 * arg_52_2)

		if self.showEffect and arg_52_2 < 7 and var_52_2 then
			var_52_2:setOpacity(0)
			var_52_2:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_52_2), cc.FadeIn:create(0.1)))
		elseif var_52_2 and var_52_2:getOpacity() < 255 then
			var_52_2:setOpacity(255)
		end
	end

	return var_52_0
end

function ActivityGameBackGuideLayer:updateRedDotAlert()
	local var_53_0 = {
		x = 335,
		y = 70
	}
	local var_53_1 = 0

	if activity_manager:getAlertStatus(self.activityId, "bp_proceed") then
		global_add_alert_tag(self.btnLevel, var_53_0)

		var_53_1 = var_53_1 + 1
	else
		global_remove_alert_tag(self.btnLevel)
	end

	if activity_manager:getAlertStatus(self.activityId, (activity_manager:getActivityBPTaskUseModule(self.activityId))) then
		global_add_alert_tag(self.btnTask, var_53_0)

		var_53_1 = var_53_1 + 1
	else
		global_remove_alert_tag(self.btnTask)
	end

	if activity_return_manager:get_can_sign() then
		global_add_alert_tag(self:queryBtnByPanelIndex(var_0_17.SIGN), {
			x = 165,
			y = 60
		})
	else
		global_remove_alert_tag(self:queryBtnByPanelIndex(var_0_17.SIGN))
	end

	if activity_manager:getSignVersion(176) >= 4 then
		if activity_manager:getAlertStatus(176, "sign") then
			global_add_alert_tag(self:queryBtnByPanelIndex(var_0_17.SIGN), {
				x = 165,
				y = 60
			})
		else
			global_remove_alert_tag(self:queryBtnByPanelIndex(var_0_17.SIGN))
		end
	end

	if not activity_return_manager:isCommitSurvey() then
		global_add_alert_tag(self:queryBtnByPanelIndex(var_0_17.SURVEY), {
			x = 165,
			y = 60
		})
	else
		global_remove_alert_tag(self:queryBtnByPanelIndex(var_0_17.SURVEY))
	end

	if activity_manager:getAlertStatus(self.activityId, "recall") then
		global_add_alert_tag(self:queryBtnByPanelIndex(var_0_17.RECALL), {
			x = 165,
			y = 60
		})
	else
		global_remove_alert_tag(self:queryBtnByPanelIndex(var_0_17.RECALL))
	end

	if activity_manager:getAlertStatus(self.activityId, "returnback_reward") then
		global_add_alert_tag(self:queryBtnByPanelIndex(var_0_17.REWARD), {
			x = 165,
			y = 60
		})
	else
		global_remove_alert_tag(self:queryBtnByPanelIndex(var_0_17.REWARD))
	end

	if var_53_1 > 0 then
		global_add_alert_tag(self:queryBtnByPanelIndex(var_0_17.BP), {
			x = 165,
			y = 60
		})
	else
		global_remove_alert_tag(self:queryBtnByPanelIndex(var_0_17.BP))
	end

	local var_53_2 = 0

	for iter_53_0, iter_53_1 in pairs(back_guide_data) do
		if activity_manager:getAlertStatus(self.activityId, iter_53_1.usemodule) then
			var_53_2 = var_53_2 + 1

			break
		end
	end

	if var_53_2 > 0 then
		global_add_alert_tag(self:queryBtnByPanelIndex(var_0_17.GUIDE), {
			x = 170,
			y = 60
		})
	else
		global_remove_alert_tag(self:queryBtnByPanelIndex(var_0_17.GUIDE))
	end
end

function ActivityGameBackGuideLayer:initWelfareUI()
	self.panelWelfare = self.panelMain:getChildByName("panelWelfare")
	self.imgTitleWelfare = self.panelWelfare:getChildByName("imgTitle")

	self.imgTitleWelfare:setPositionType(0)
	self.imgTitleWelfare:setPositionY(self.imgTitleWelfare:getPositionY() - GameDisplay.statusbar_height)

	self.listViewWelfare = self.panelWelfare:getChildByName("listViewWelfare")

	self.listViewWelfare:setContentSize(cc.size(config._DESIGN_WIDTH, self.listViewWelfare:getContentSize().height + GameDisplay.height - config._DESIGN_HEIGHT + 25))
	self.listViewWelfare:setPositionY(GameDisplay.fix_y + 20)

	self.panelWelfareItem = self.panelWelfare:getChildByName("panelWelfareItem")

	self.panelWelfareItem:retain()
	self.panelWelfareItem:removeFromParent()

	self.panels[var_0_17.WELFARE] = self.panelWelfare
end

function ActivityGameBackGuideLayer:updateWelfareUI()
	self.listViewWelfare:removeAllChildren()

	for iter_55_0, iter_55_1 in ipairs(var_0_25) do
		if self:isWelfareDataValid(iter_55_1) then
			self.listViewWelfare:pushBackCustomItem((self:createOneWelfareItem(iter_55_1)))
		end
	end
end

function ActivityGameBackGuideLayer:isWelfareDataValid(arg_56_1)
	if arg_56_1.id == 2050101 then
		return activity_manager:getActivityEntranceList()[arg_56_1.id] and true
	end

	if arg_56_1.id ~= 3 and arg_56_1.id ~= 2210001 then
		return true
	end

	local var_56_0 = activity_return_manager:get_buffs()

	if not var_56_0 then
		return false
	end

	return var_56_0[1].time > time_check_manager:getCurTime()
end

function ActivityGameBackGuideLayer:initGuideUI()
	self.panelGuide = self.panelMain:getChildByName("panelGuide")
	self.imgTitleGuide = self.panelGuide:getChildByName("imgTitle")

	self.imgTitleGuide:setPositionType(0)
	self.imgTitleGuide:setPositionY(self.imgTitleGuide:getPositionY() - GameDisplay.statusbar_height)

	self.listViewGuide = self.panelGuide:getChildByName("listViewGuide")

	self.listViewGuide:setContentSize(cc.size(config._DESIGN_WIDTH, self.listViewGuide:getContentSize().height + GameDisplay.height - config._DESIGN_HEIGHT - 20))

	self.panelGuideItem = self.panelGuide:getChildByName("panelGuideItem")

	self.panelGuideItem:retain()
	self.panelGuideItem:removeFromParent()

	self.panels[var_0_17.GUIDE] = self.panelGuide
end

function ActivityGameBackGuideLayer:updateGuideUI(arg_58_1)
	self.listViewGuide:removeAllChildren()

	for iter_58_0, iter_58_1 in ipairs((self:filterGuideData(arg_58_1))) do
		self.listViewGuide:pushBackCustomItem((self:createOneGuideItem(iter_58_1)))
	end
end

function ActivityGameBackGuideLayer:updatePanelGuideAlert()
	for iter_59_0, iter_59_1 in ipairs((self.listViewGuide:getChildren())) do
		if activity_manager:getAlertStatus(self.activityId, iter_59_1.useModule) then
			global_add_alert_tag(iter_59_1, {
				x = 620,
				y = 300
			})
		else
			global_remove_alert_tag(iter_59_1)
		end
	end
end

function ActivityGameBackGuideLayer:filterGuideData(arg_60_1)
	local back_guide_data = require("data.back_guide_data")
	local var_60_1 = {}

	for iter_60_0, iter_60_1 in ipairs(arg_60_1) do
		if back_guide_data[iter_60_1] then
			var_60_1[#var_60_1 + 1] = back_guide_data[iter_60_1]
		end
	end

	table.sort(var_60_1, function(arg_61_0, arg_61_1)
		return arg_61_0.sort < arg_61_1.sort
	end)

	return var_60_1
end

function ActivityGameBackGuideLayer:showGuideTasks(arg_62_1)
	if not self.isClickGuide then
		return
	end

	self.isClickGuide = false

	LayerManager:pushInLayer("PopReturnBackGuideTaskLayer", {
		tasks = arg_62_1,
		type = self.curGuideType,
		activityId = self.activityId
	})
end

function ActivityGameBackGuideLayer:initCallUI()
	self.panelCall = self.panelMain:getChildByName("panelCall")
	self.imgTitleCall = self.panelCall:getChildByName("imgTitle")

	self.imgTitleCall:setPositionType(0)
	self.imgTitleCall:setPositionY(self.imgTitleCall:getPositionY() - GameDisplay.statusbar_height)

	local var_63_0 = ccui.Button:create("gameback/task/img_tip.png", nil, "gameback/task/img_tip.png", var_0_12)

	self.imgTitleCall:addChild(var_63_0)
	Utility:addClickEventListener(var_63_0, handler(self, self.onBtnTipCall))
	var_63_0:setPosition(280, self.imgTitleCall:getContentSize().height / 2)

	self.listViewCall = self.panelCall:getChildByName("listViewCall")

	self.listViewCall:setContentSize(cc.size(config._DESIGN_WIDTH, self.listViewCall:getContentSize().height + GameDisplay.fix_y + 110))
	self.listViewCall:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.listViewCall:setItemsMargin(5)
	self.listViewCall:setPositionY(GameDisplay.fix_y + 10)
	self.listViewCall:getInnerContainer():setAnchorPoint(cc.p(0, 0))

	self.panelCallItem = self.panelCall:getChildByName("panelCallItem")

	self.panelCallItem:retain()
	self.panelCallItem:removeFromParent()
	ccui.Helper:seekWidgetByName(self.panelCallItem, "imgCall"):getChildByName("labelCall"):setString(L_GAMEBACKLAYER[1])

	self.panels[var_0_17.RECALL] = self.panelCall
end

function ActivityGameBackGuideLayer:onBtnTipCall(arg_64_1)
	LayerManager:pushInLayer("PopActivityDetail", {
		key = "RecallTask"
	})
end

function ActivityGameBackGuideLayer:updateCallUI(arg_65_1)
	self.listViewCall:removeAllChildren()

	for iter_65_0, iter_65_1 in ipairs((self:dealWithCallTasks(arg_65_1))) do
		local var_65_0 = self.panelCallItem:clone()

		self:updateOnePanelCallItem(var_65_0, iter_65_1)
		self.listViewCall:pushBackCustomItem(var_65_0)
	end
end

function ActivityGameBackGuideLayer:dealWithCallTasks(arg_66_1)
	local var_66_0 = activity_return_manager:get_recall_code()
	local var_66_1 = {
		drop = "ZHTFDL43",
		name = "",
		type = "code",
		task_des = "",
		status = var_66_0 == 0 and 0 or 1,
		percent = var_66_0 == 0 and 100 or 0
	}
	local var_66_2 = {}

	if var_66_1.status == 0 then
		var_66_2[#var_66_2 + 1] = var_66_1
	end

	for iter_66_0, iter_66_1 in ipairs(arg_66_1) do
		var_66_2[#var_66_2 + 1] = iter_66_1
	end

	if var_66_1.status == 1 then
		var_66_2[#var_66_2 + 1] = var_66_1
	end

	return var_66_2
end

function ActivityGameBackGuideLayer:updateOnePanelCallItem(arg_67_1, arg_67_2)
	local var_67_0 = arg_67_1:getChildByName("imgBorder")
	local var_67_1 = arg_67_1:getChildByName("imgCall")
	local var_67_2 = arg_67_1:getChildByName("panelInner")
	local var_67_3 = arg_67_1:getChildByName("btnStatus")
	local var_67_4 = arg_67_1:getChildByName("listViewRewards")
	local var_67_5 = arg_67_1:getChildByName("imgMask")
	local var_67_6 = var_67_2:getChildByName("labelInfo")
	local var_67_7 = var_67_2:getChildByName("labelTitle")
	local var_67_8 = var_67_2:getChildByName("progressCall")
	local var_67_9 = var_67_2:getChildByName("labelProgress")

	arg_67_1:getChildByName("imgIcon"):loadTexture("mainScenebg/task_img/" .. (arg_67_2.image or "103") .. ".png")
	var_67_8:setPercent(Utility:clamp(arg_67_2.percent, 0, 100))
	var_67_8:setVisible(arg_67_2.status == 0)
	var_67_5:setVisible(arg_67_2.status == 1)

	if arg_67_2.status == 0 then
		var_67_0:loadTexture("gameback/task/img_border_2.png", var_0_12)

		if arg_67_2.percent < 100 then
			var_67_3:loadTextures("gameback/task/btn_go.png", "gameback/task/btn_go.png", "gameback/task/btn_go.png", var_0_12)
		else
			var_67_3:loadTextures("gameback/task/btn_get.png", "gameback/task/btn_get.png", "gameback/task/btn_get.png", var_0_12)
		end
	else
		var_67_0:loadTexture("gameback/task/img_border_1.png", var_0_12)
		var_67_3:loadTextures("gameback/task/btn_rewarded.png", "gameback/task/btn_rewarded.png", "gameback/task/btn_rewarded.png", var_0_12)
	end

	if arg_67_2.type and arg_67_2.type == "code" then
		var_67_0:loadTexture("gameback/task/img_border_1.png", var_0_12)
	end

	Utility:addClickEventListener(var_67_3, handler(self, self.onBtnStatus), arg_67_2)
	self:updateCallTaskRewards(var_67_4, arg_67_2)
	self:updateCodeUI(arg_67_1, arg_67_2)
	self:updateLabelColor(arg_67_1, arg_67_2)
end

function ActivityGameBackGuideLayer:updateLabelColor(arg_68_1, arg_68_2)
	local var_68_0 = arg_68_1:getChildByName("panelInner")
	local var_68_1 = var_68_0:getChildByName("labelInfo")
	local var_68_2 = var_68_0:getChildByName("labelTitle")
	local var_68_3 = var_68_0:getChildByName("labelProgress")

	if arg_68_2.status == 0 then
		var_68_2:setColor(cc.c3b(48, 36, 105))
		var_68_1:setColor(cc.c3b(48, 36, 105))
		var_68_3:setColor(cc.c3b(48, 36, 105))
	else
		var_68_2:setColor(cc.c3b(255, 255, 255))
		var_68_1:setColor(cc.c3b(255, 255, 255))
		var_68_3:setColor(cc.c3b(255, 255, 255))
	end

	var_68_2:setString(arg_68_2.name)
	var_68_1:setString(arg_68_2.task_des)
	var_68_3:setString(arg_68_2.percent .. "%")
	var_68_3:setVisible(arg_68_2.status == 0)
end

function ActivityGameBackGuideLayer:updateCodeUI(arg_69_1, arg_69_2)
	local var_69_0 = arg_69_1:getChildByName("imgCall")
	local var_69_1 = arg_69_1:getChildByName("panelInner")
	local var_69_2 = arg_69_1:getChildByName("imgIcon")
	local var_69_3 = var_69_0:getChildByName("labelCode")
	local var_69_4 = var_69_0:getChildByName("editBox")

	if not var_69_4 then
		var_69_4 = Utility:replaceTextFieldByEditBox(var_69_0:getChildByName("textField"), 10)

		var_69_4:registerScriptEditBoxHandler(function(arg_70_0, arg_70_1)
			if arg_70_0 == "return" then
				self.preCallCode = tonumber(var_69_4:getText()) or 0

				var_69_4:setText("")
				var_69_3:setString((self.preCallCode ~= 0 or nil) and ("已输入召回码：" .. self.preCallCode or ""))
			elseif arg_70_0 == "begin" then
				var_69_3:setString("")
			end
		end)
	end

	if self.recallCode ~= 0 then
		var_69_3:setString("已绑定召回码：" .. self.recallCode)
	else
		var_69_3:setString("")
	end

	if arg_69_2.type and arg_69_2.type == "code" then
		var_69_1:setVisible(false)
		var_69_0:setVisible(true)
		var_69_2:setVisible(false)
		var_69_4:setEnabled(self.recallCode == 0)
	else
		var_69_1:setVisible(true)
		var_69_0:setVisible(false)
		var_69_2:setVisible(true)
		var_69_4:setEnabled(false)
	end
end

function ActivityGameBackGuideLayer:updateCallTaskRewards(arg_71_1, arg_71_2)
	local var_71_0 = Utility:getDropData(arg_71_2.drop)

	arg_71_1:setTouchEnabled(false)
	arg_71_1:setItemsMargin(-20)
	arg_71_1:removeAllItems()

	local var_71_1 = 0

	for iter_71_0, iter_71_1 in ipairs(var_71_0) do
		local var_71_2 = ItemSpriteActivityRecharge:createSignItem(iter_71_1.itemid, iter_71_1.num)

		var_71_2:setScale(0.7)
		var_71_2:setSwallowsTouches(false)
		var_71_2:addClickEventListener(function()
			LayerManager:pushInLayer("PopItemLayer", {
				itemid = iter_71_1.itemid
			})
		end)

		var_71_1 = var_71_1 + var_71_2:getContentSize().width

		arg_71_1:pushBackCustomItem(var_71_2)
	end

	local var_71_3 = var_71_1 - 20 * math.max(#var_71_0 - 1, 0)

	arg_71_1:setContentSize(cc.size(var_71_3, 80))
	arg_71_1:setInnerContainerSize(cc.size(var_71_3, 80))
	arg_71_1:setAnchorPoint(1, 0)
	arg_71_1:setPosition(560, 25)
end

function ActivityGameBackGuideLayer:onBtnStatus(arg_73_1, arg_73_2)
	if arg_73_2.type and arg_73_2.type == "code" then
		if not self.preCallCode or self.preCallCode == 0 then
			global_ShowBlockWords("召回码错误，请重新输入")
		else
			activity_return_manager:bind_recall_code(self.preCallCode, function(arg_74_0)
				if arg_74_0.result ~= 1 then
					self.preCallCode = 0

					print("bind error", arg_74_0.result)
				else
					activity_manager:getExtraTaskList(self.activityId, "recall")
				end
			end)
		end

		return
	end

	if arg_73_2.status == 0 and arg_73_2.percent == 100 then
		EventManager:requestActivityTaskReward(self.activityId, arg_73_2.taskid, nil)
	elseif arg_73_2.status == 0 and arg_73_2.percent < 100 then
		if arg_73_2.jump == 3036 then
			self:onBtnSwitchActivity(self.activityBtns[1])
		end

		self.isJump = true
		self.jumpTarget = SYSTEMID[arg_73_2.jump]

		Utility:executeLayerJump({
			systemid = arg_73_2.jump
		})
	end
end

function ActivityGameBackGuideLayer:initServeyUI()
	self.panelSurvey = ccui.Layout:create()

	self.panelSurvey:setContentSize(self.panelMain:getContentSize())
	self.panelMain:addChild(self.panelSurvey)

	local var_75_0 = ccui.ImageView:create("gameback/survey/bg.png", var_0_12)

	var_75_0:setPosition(320, 680)

	local var_75_1 = ccui.ImageView:create("gameback/survey/img_info.png", var_0_12)

	var_75_1:setPosition(420, 260)
	var_75_0:addChild(var_75_1)
	self.panelSurvey:addChild(var_75_0)

	self.btnSurvey = ccui.Button:create("gameback/survey/btn_go.png", nil, "gameback/survey/btn_go.png", var_0_12)

	self.btnSurvey:setPosition(450, 320)
	self.panelSurvey:addChild(self.btnSurvey)
	Utility:addClickEventListener(self.btnSurvey, handler(self, self.onBtnSurvey), "https://aokistudio.wjx.cn/vj/Y6H8P6N.aspx")

	self.panels[var_0_17.SURVEY] = self.panelSurvey
end

function ActivityGameBackGuideLayer:onBtnSurvey(arg_76_1, arg_76_2)
	if activity_return_manager:isCommitSurvey() then
		-- block empty
	else
		self:showSurveyWeb(arg_76_2)
	end
end

function ActivityGameBackGuideLayer:showSurveyWeb(arg_77_1)
	local var_77_0 = ccui.Layout:create()

	var_77_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_77_0:setTouchEnabled(true)
	var_77_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_77_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_77_0:setBackGroundColorOpacity(150)
	self.panelSurvey:addChild(var_77_0, 1)

	local var_77_1 = cc.Sprite:create("mainScenebg/noticebg.jpg")

	var_77_1:setAnchorPoint(cc.p(0.5, 1))
	var_77_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.height))
	var_77_0:addChild(var_77_1)

	if DeviceManager.platform == "windows" then
		DeviceManager.openURL(arg_77_1)
		RoleDefault:getInstance():setIntegerForKey("CommitTime", activity_return_manager:get_end_time() or 0)
	else
		var_77_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
			local var_78_0 = false
			local var_78_1 = ccexp.WebView:create()

			var_78_1:setVisible(true)
			var_78_1:setScalesPageToFit(true)
			var_78_1:setContentSize(cc.size(GameDisplay.width, GameDisplay.height - 50))
			var_78_1:setAnchorPoint(0, 0)
			var_78_1:setPosition(0, 0)
			var_78_1:loadURL(arg_77_1)
			var_78_1:setOnDidFinishLoading(function(arg_79_0, arg_79_1)
				if string.find(arg_79_1, "complete") then
					print("commit survey success2")

					var_78_0 = true

					RoleDefault:getInstance():setIntegerForKey("CommitTime", activity_return_manager:get_end_time() or 0)
				end
			end)
			var_77_0:addChild(var_78_1, 1)

			local var_78_2 = ccui.Button:create("equipment/closebtn.png", nil, "equipment/closebtn.png")

			var_78_2:setScale(0.5)
			var_78_2:setPosition(cc.p(GameDisplay.width - 40, GameDisplay.height - 25))
			var_77_0:addChild(var_78_2, 2)
			Utility:addClickEventListener(var_78_2, function()
				var_77_0:runAction(cc.RemoveSelf:create())
			end)

			activity_return_manager.isSurvey = true

			self:updateSurveyUI()
		end)))
	end
end

function ActivityGameBackGuideLayer:updateSurveyUI()
	if not self.panelSurvey then
		self:initServeyUI()
	end

	self.btnSurvey:loadTextures("gameback/survey/btn_go.png", nil, "gameback/survey/btn_go.png", var_0_12)
end

function ActivityGameBackGuideLayer:registerEvents()
	Utility:registerNodeEvent(self)
	Utility:addClickEventListener(self.btnBack, handler(self, self.onBtnBack))
	LocalEvent:registerEvent(self, LocalEvent.EVENT_IDS.LAYER_EXIT_SCENE, handler(self, self.handleLayerExitScene))
	EventManager:subscribe(self, EventManager.EVENT_IDS.GET_ACTIVITY_TASK_REWARD, handler(self, self.handleRequestActivityTaskReward))
	self:registerActivityEvents()
end

function ActivityGameBackGuideLayer:registerActivityEvents()
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_RETURN_SIGN_UPDATE, handler(self, self.handleGetReturnSignInfo))
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_RETURN_TIME_SIGN_UPDATE, function(arg_84_0)
		self:updateTimeSignUI(arg_84_0)
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.BATTLE_PASS_LIST_UPDATE, handler(self, self.handleBpList))
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, handler(self, self.handleBpTasks))
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.BATTLE_PASS_VIP_UPDATE, function(arg_85_0)
		activity_manager:getBattlePassLevelData(self.activityId)
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.RETURNBACK_GUIDE_LIST, handler(self, self.handleReturnBackGuideList))
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.RETURNBACK_EXTRA_TASK_LIST, handler(self, self.handleRequestActivityTaskList))
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.UPDATE_ACTIVITY_STATUS_ALERT, handler(self, self.handleUpdateActivityStatusAlert))
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.RETRUN_BACK_REWARD_TASK_UPDATE, handler(self, self.handleRewardTaskList))
end

function ActivityGameBackGuideLayer:onBtnBack()
	var_0_26 = nil

	KeyCodeManager:onKeyReleasedCallFunc()
end

function ActivityGameBackGuideLayer:onEnter()
	return
end

function ActivityGameBackGuideLayer:createOneSignItem(arg_88_1, arg_88_2, arg_88_3, arg_88_4, arg_88_5)
	local var_88_0 = self.panelSignItem:clone()

	if arg_88_4 == "timesign" then
		if arg_88_3 and arg_88_1.id == arg_88_2 + 1 then
			var_88_0:loadTexture("gameback/sign_258/item_reward_bg.png", var_0_12)
		else
			var_88_0:loadTexture("gameback/sign_258/item_normal_bg.png", var_0_12)
		end
	elseif arg_88_3 and arg_88_1.id == arg_88_2 + 1 then
		var_88_0:loadTexture("gameback/sign/item_reward_bg.png", var_0_12)
	else
		var_88_0:loadTexture("gameback/sign/item_normal_bg.png", var_0_12)
	end

	local var_88_1 = var_88_0:getChildByName("labelName")
	local var_88_2 = var_88_0:getChildByName("btnReward")

	var_88_2:setVisible(arg_88_3 and arg_88_1.id == arg_88_2 + 1)

	if arg_88_4 == "timesign" then
		var_88_2:loadTextures("gameback/sign_258/btn_get.png", nil, "gameback/sign_258/btn_get.png", var_0_12)
	else
		var_88_2:loadTextures("gameback/sign/btn_get.png", nil, "gameback/sign_258/btn_get.png", var_0_12)
	end

	if arg_88_3 then
		Utility:addClickEventListener(var_88_2, function()
			if arg_88_4 == "timesign" then
				activity_return_manager:returnback_timesign(arg_88_5)

				return
			else
				activity_return_manager:returnback_sign()
			end
		end)
	end

	var_88_0:getChildByName("imgMask"):setVisible(arg_88_3 and arg_88_1.id < arg_88_2 + 1 or arg_88_2 > arg_88_1.id)
	var_88_1:setString("第" .. arg_88_1.id .. "天")

	local var_88_3 = activity_return_manager:getDropData(arg_88_1.drop_id)

	for iter_88_0 = 1, 3 do
		if not var_88_3[iter_88_0] then
			var_88_0:getChildByName("nodeItem_" .. iter_88_0):setVisible(false)
		else
			require("view.Sprite.ItemSpriteActivityRecharge")

			local var_88_4 = ItemSpriteActivityRecharge:createSignItem(var_88_3[iter_88_0].itemid, var_88_3[iter_88_0].num)

			var_88_4:addClickEventListener(handler(self, self.onBtnItemSign), var_88_3[iter_88_0].itemid)
			var_88_4:setScale(0.95)
			Utility:replaceNodeByNode(var_88_0, "nodeItem_" .. iter_88_0, var_88_4)
		end
	end

	return var_88_0
end

function ActivityGameBackGuideLayer:onBtnItemSign(arg_90_1, arg_90_2)
	LayerManager:pushInLayer("PopItemLayer", {
		itemid = arg_90_2
	})
end

function ActivityGameBackGuideLayer:createOneLevelItem(arg_91_1)
	local var_91_0 = self.panelLevelItem:clone()

	self:updateOneLevelItem(var_91_0, arg_91_1)

	return var_91_0
end

function ActivityGameBackGuideLayer:updateOneLevelItem(arg_92_1, arg_92_2)
	local var_92_0 = arg_92_1:getChildByName("imgLevelBg")

	var_92_0:getChildByName("labelLevel"):setString("" .. arg_92_2.level)

	local var_92_1 = arg_92_1:getChildByName("progressBg")
	local var_92_2 = var_92_1:getChildByName("progressBarLevel")

	arg_92_1:setVisible(type(arg_92_2.level) ~= "string")

	if type(arg_92_2.level) == "string" then
		return
	elseif arg_92_2.level == activity_manager:getBattlePassMaxLevel(self.activityId) - 1 then
		var_92_1:setVisible(false)
	else
		var_92_1:setVisible(true)
		var_92_2:setPercent(arg_92_2.level + 1 == self.curLevel and activity_manager:getCurLevelProceed(self.activityId, self.curLevel) or arg_92_2.level + 1 < self.curLevel and 100 or 0)
	end

	if arg_92_2.stat ~= var_0_23.LEVEL_UNACHIEVE then
		if arg_92_2.level % 5 == 0 then
			var_92_0:loadTexture("Activity_return_BPBasic/bg_biglv_yidadao.png", var_0_12)
		else
			var_92_0:loadTexture("Activity_return_BPBasic/bg_smalllv_yidadao.png", var_0_12)
		end
	elseif arg_92_2.level % 5 == 0 then
		var_92_0:loadTexture("Activity_return_BPBasic/bg_biglv_weidadao.png", var_0_12)
	else
		var_92_0:loadTexture("Activity_return_BPBasic/bg_smalllv_weidadao.png", var_0_12)
	end

	local var_92_3 = Utility:getDropData(arg_92_2.drop)[1] or {}
	local var_92_4 = ItemSmallSprite:createSmallItem(var_92_3.itemid, var_92_3.num)

	var_92_4:setScale(0.6)
	var_92_4:setSwallowTouches(false)
	Utility:addClickEventListener(var_92_4, handler(self, self.onBtnItemLevel), var_92_3.itemid, arg_92_2)
	Utility:replaceNodeByNode(arg_92_1, "nodeItem_1", var_92_4)

	local var_92_5 = Utility:getDropData(arg_92_2.specialDrop)
	local var_92_6 = 1

	for iter_92_0 = 2, 3 do
		if var_92_5[iter_92_0 - 1] then
			local var_92_7 = ItemSmallSprite:createSmallItem(var_92_5[iter_92_0 - 1].itemid, var_92_5[iter_92_0 - 1].num)

			Utility:replaceNodeByNode(arg_92_1, "nodeItem_" .. iter_92_0, var_92_7)
			var_92_7:setScale(0.6)
			var_92_7:setSwallowTouches(false)
			var_92_7:setLockIconVisible(not activity_manager:isBattlePassVIP(self.activityId))

			var_92_7.isSpecial = true

			Utility:addClickEventListener(var_92_7, handler(self, self.onBtnItemLevel), var_92_5[iter_92_0 - 1].itemid, arg_92_2)
			arg_92_1:getChildByName("nodeItem_" .. iter_92_0):setVisible(true)

			var_92_6 = var_92_6 + 1
		else
			arg_92_1:getChildByName("nodeItem_" .. iter_92_0):setVisible(false)
		end
	end

	self:updateShowHooks(arg_92_1, arg_92_2.stat, var_92_6)
end

function ActivityGameBackGuideLayer:updateShowHooks(arg_93_1, arg_93_2, arg_93_3)
	local var_93_0 = arg_93_1:getChildByName("imgMask")

	if arg_93_2 == var_0_23.RECEIVE_ALL then
		var_93_0:loadTexture("Activity_return_BPBasic/image_got_mask2.png", var_0_12)
	elseif arg_93_2 == var_0_23.RECEIVE_ORDINARY then
		var_93_0:loadTexture("Activity_return_BPBasic/image_got_mask1.png", var_0_12)
	end

	var_93_0:setVisible(arg_93_2 > var_0_23.UNRECEIVE)

	for iter_93_0 = 1, 3 do
		local var_93_1 = var_93_0:getChildByName("imgHook_" .. iter_93_0)

		if arg_93_2 == var_0_23.RECEIVE_ALL then
			var_93_1:setVisible(iter_93_0 < arg_93_3 + 1)
		elseif arg_93_2 == var_0_23.RECEIVE_ORDINARY and iter_93_0 == 1 then
			var_93_1:setVisible(iter_93_0 < arg_93_3 + 1)
		else
			var_93_1:setVisible(false)
		end
	end
end

function ActivityGameBackGuideLayer:onBtnItemLevel(arg_94_1, arg_94_2, arg_94_3)
	if not activity_manager:isBattlePassVIP(self.activityId) and arg_94_1.isSpecial then
		LayerManager:pushInLayer(activity_manager:getBuyVipJumpTo(self.activityId), {
			imagePath = "Activity_return_BPBasic",
			activityId = self.activityId
		})
	elseif arg_94_3.stat == var_0_23.UNRECEIVE or arg_94_3.stat == var_0_23.RECEIVE_ORDINARY then
		activity_manager:getBattlePassReward(self.activityId, arg_94_3.level)
	else
		LayerManager:pushInLayer("PopItemLayer", {
			itemid = arg_94_2
		})
	end
end

function ActivityGameBackGuideLayer:updateRewardPreview()
	local var_95_0 = activity_manager:getBattlePassMaxLevel(self.activityId)
	local var_95_1 = math.floor((self.curLevel - 1) / 10) * 10 + 10

	if var_95_0 < var_95_1 then
		var_95_1 = var_95_0
	end

	local var_95_2 = self.levelListData[var_95_1] or {}
	local var_95_3 = Utility:getDropData(var_95_2.drop)[1]

	if var_95_3 then
		local var_95_4 = ItemSmallSprite:createSmallItem(var_95_3.itemid)

		var_95_4:setScale(0.6)
		Utility:addClickEventListener(var_95_4, function()
			LayerManager:pushInLayer("PopItemLayer", {
				itemid = var_95_3.itemid
			})
		end)
		Utility:replaceNodeByNode(self.imgRewardPreview, "nodeItem_1", var_95_4)
	end

	local var_95_5 = Utility:getDropData(var_95_2.specialDrop)

	if var_95_5 then
		for iter_95_0 = 2, 3 do
			if var_95_5[iter_95_0 - 1] then
				local var_95_6 = ItemSmallSprite:createSmallItem(var_95_5[iter_95_0 - 1].itemid)

				Utility:replaceNodeByNode(self.imgRewardPreview, "nodeItem_" .. iter_95_0, var_95_6)
				var_95_6:setScale(0.6)

				var_95_6.isSpecial = true

				Utility:addClickEventListener(var_95_6, function()
					LayerManager:pushInLayer("PopItemLayer", {
						itemid = var_95_5[iter_95_0 - 1].itemid
					})
				end)
				self.imgRewardPreview:getChildByName("nodeItem_" .. iter_95_0):setVisible(true)
			else
				self.imgRewardPreview:getChildByName("nodeItem_" .. iter_95_0):setVisible(false)
			end
		end
	end
end

function ActivityGameBackGuideLayer:createOneTaskItem(arg_98_1)
	local var_98_0 = self.panelTaskItem:clone()

	self:updateOneTaskItem(var_98_0, arg_98_1)

	return var_98_0
end

function ActivityGameBackGuideLayer:updateOneTaskItem(arg_99_1, arg_99_2)
	arg_99_1:getChildByName("imgTask"):loadTexture("Activity_return_BPBasic/icon_bpdianshu.png", var_0_12)
	arg_99_1:getChildByName("labelPt"):setString("x" .. Utility:getDropData(arg_99_2.drop)[1].num)
	arg_99_1:getChildByName("labelName"):setString(arg_99_2.task_des)

	local var_99_0 = arg_99_1:getChildByName("progressBg")
	local var_99_1

	if arg_99_2.status == 1 then
		var_99_1 = 100
	elseif arg_99_2.percent >= 0 then
		var_99_1 = arg_99_2.percent or 100
	end

	var_99_0:getChildByName("progressBarTask"):setPercent(var_99_1)
	var_99_0:getChildByName("labelPercent"):setString(var_99_1 .. "%")

	local var_99_2 = arg_99_1:getChildByName("btnRewardTask")

	Utility:addClickEventListener(var_99_2, handler(self, self.onBtnRewardTask), arg_99_2)

	if arg_99_2.status >= 1 then
		var_99_2:loadTextures("Activity_return_BPBasic/btn_yiwancheng.png", nil, "Activity_return_BPBasic/btn_yiwancheng.png", var_0_12)
	elseif var_99_1 >= 100 then
		var_99_2:loadTextures("Activity_return_BPBasic/btn_lingqujiangli.png", nil, "Activity_return_BPBasic/btn_lingqujiangli.png", var_0_12)
	else
		var_99_2:loadTextures("Activity_return_BPBasic/btn_qianwangwancheng.png", nil, "Activity_return_BPBasic/btn_qianwangwancheng.png", var_0_12)
	end
end

function ActivityGameBackGuideLayer:onBtnRewardTask(arg_100_1, arg_100_2)
	if arg_100_2.status >= 1 then
		return
	end

	if arg_100_2.percent >= 100 then
		activity_manager:getBPTaskRewardOneKey(self.activityId, arg_100_2.taskid)
	else
		Utility:executeLayerJump({
			systemid = arg_100_2.jump
		})

		self.isJump = true
		self.jumpTarget = SYSTEMID[arg_100_2.jump]
	end
end

function ActivityGameBackGuideLayer:createOneWelfareItem(arg_101_1)
	local var_101_0 = self.panelWelfareItem:clone()

	var_101_0:loadTexture(arg_101_1.banner, var_0_12)

	local var_101_1 = var_101_0:getChildByName("btnGo")

	Utility:addClickEventListener(var_101_0, handler(self, self.onBtnGo), arg_101_1.jump)
	Utility:addClickEventListener(var_101_1, handler(self, self.onBtnGo), arg_101_1.jump)

	local var_101_2 = Utility:seekChildByName(var_101_0, "labelRemainTimeWelfare")

	if arg_101_1.id == 3 or arg_101_1.id == 2210001 then
		local var_101_3 = activity_return_manager:get_buff_end_time() or activity_return_manager:getFinishtime()

		if var_101_3 and var_101_3 > time_check_manager:getCurTime() and var_101_3 - time_check_manager:getCurTime() < 31536000 then
			local var_101_4 = var_101_3 - time_check_manager:getCurTime()

			var_101_2:setString("剩余时间:" .. Utility:formatTimeStr(var_101_4))
			var_101_2:runAction((Utility:createClockTimerAction(var_101_2, 1, var_101_4, function(arg_102_0, arg_102_1)
				var_101_2:setString("剩余时间:" .. Utility:formatTimeStr(arg_102_0))
			end)))

			if var_101_4 < 86400 then
				var_101_2:setColor(cc.c3b(255, 255, 255))
			else
				var_101_2:setColor(cc.c3b(255, 229, 158))
			end

			goto label_101_0
		end
	end

	var_101_0:getChildByName("imgTimeBg"):setVisible(false)

	::label_101_0::

	if condition then
		var_101_1:loadTextures("gameback/welfare/btn_bought.png", nil, "gameback/welfare/btn_bought.png", var_0_12)
	else
		var_101_1:loadTextures(arg_101_1.btn, nil, arg_101_1.btn, var_0_12)
	end

	return var_101_0
end

function ActivityGameBackGuideLayer:onBtnGo(arg_103_1, arg_103_2)
	print("welfare jump", arg_103_2)

	if not arg_103_2 then
		return
	end

	Utility:executeLayerJump({
		systemid = arg_103_2
	})
end

function ActivityGameBackGuideLayer:createOneGuideItem(arg_104_1)
	local var_104_0 = self.panelGuideItem:clone()

	var_104_0:loadTexture(string.format("gameback/guide/img_%s.png", arg_104_1.usemodule), var_0_12)
	Utility:addClickEventListener(var_104_0, handler(self, self.onPanelGuideItem), arg_104_1.usemodule)

	var_104_0.useModule = arg_104_1.usemodule

	if activity_manager:getAlertStatus(self.activityId, arg_104_1.usemodule) then
		global_add_alert_tag(var_104_0, {
			x = 620,
			y = 300
		})
	else
		global_remove_alert_tag(var_104_0)
	end

	return var_104_0
end

function ActivityGameBackGuideLayer:onPanelGuideItem(arg_105_1, arg_105_2)
	if self.isRequestingGuideTask then
		return
	end

	self.isRequestingGuideTask = true
	self.curGuideType = arg_105_2
	self.isClickGuide = true

	self:showGuideTasks()
end

function ActivityGameBackGuideLayer:onExit()
	self.panelSignItem:release()
	self.panelLevelItem:release()
	self.panelTaskItem:release()
	self.panelWelfareItem:release()
	self.panelGuideItem:release()
	self.panelCallItem:release()
	activity_manager:releaseEventListenerByName(self.layerName)
	EventManager:unsubscribe(self)
	LocalEvent:removeEvent(self)

	if self.activityScheduler then
		time_check_manager:removeUpdatePool(self.activityScheduler)

		self.activityScheduler = nil
	end
end

function ActivityGameBackGuideLayer:getWelfareDatas()
	local var_107_0 = {}

	for iter_107_0, iter_107_1 in pairs(activity_manager:getActivityEntranceList()) do
		if iter_107_1.image ~= 3000001 and not iter_107_1.is_not_in_entrance then
			if iter_107_0 == 8061 then
				if not activity_manager:is_module_stat_finished(2, "sign") then
					var_107_0[#var_107_0 + 1] = iter_107_1
				end
			elseif iter_107_0 == 8065 then
				local novice_pass_level_data = require("data.novice_pass_level_data")
				local level_manager = require("controller.level_manager")
				local var_107_3 = {}

				for iter_107_2, iter_107_3 in pairs(playermodel.novice_pass_level_award) do
					var_107_3[iter_107_3] = true
				end

				local var_107_4

				for iter_107_4, iter_107_5 in pairs(novice_pass_level_data) do
					if not var_107_3[iter_107_5.id] then
						var_107_4 = true

						break
					end
				end

				if var_107_4 then
					var_107_0[#var_107_0 + 1] = iter_107_1
				end
			elseif iter_107_0 == 8062 then
				local novice_award_data = require("data.novice_award_data")

				if not hexie_manager:isChannelInShenheTime() and (playermodel.novice_award_process_xinxiya < #novice_award_data or playermodel.novice_award_process_lucun < #novice_award_data) then
					var_107_0[#var_107_0 + 1] = iter_107_1
				end
			elseif iter_107_0 == 8063 then
				if not activity_manager:is_module_stat_finished(2, "wake_fund") then
					var_107_0[#var_107_0 + 1] = iter_107_1
				end
			elseif iter_107_0 == 8064 then
				if not activity_manager:is_module_stat_finished(2, "task_novice") then
					if (playermodel.create_time < os.time(parse_time("2020-9-19 00:00:00")) and os.time(parse_time("2020-9-19 00:00:00")) + 1209600 or playermodel.create_time + 1209600) > time_check_manager:getCurTime() then
						var_107_0[#var_107_0 + 1] = iter_107_1
					end
				end
			elseif iter_107_0 == 1371008 then
				if activity_manager:getActivityObj(iter_107_1.configId) then
					if (playermodel.create_time < os.time(parse_time("2020-9-19 00:00:00")) and os.time(parse_time("2020-9-19 00:00:00")) + 1209600 or playermodel.create_time + 1209600) > time_check_manager:getCurTime() then
						var_107_0[#var_107_0 + 1] = iter_107_1
					end
				end
			elseif iter_107_0 == 8068 then
				if playermodel.create_time + require("data.recharge_data")[20001].canbuy_timeout * 24 * 60 * 60 > time_check_manager:getCurTime() then
					var_107_0[#var_107_0 + 1] = iter_107_1
				end
			elseif iter_107_0 == 8066 then
				if not activity_return_manager:isReturnSignFinish() then
					var_107_0[#var_107_0 + 1] = iter_107_1
				end
			elseif iter_107_0 == 8067 then
				if activity_return_manager:isShowReturnBp() then
					var_107_0[#var_107_0 + 1] = iter_107_1
				end
			elseif iter_107_0 == 176 then
				if activity_return_manager:isShowReturnBp() then
					var_107_0[#var_107_0 + 1] = iter_107_1
				end
			else
				var_107_0[#var_107_0 + 1] = iter_107_1
			end
		end
	end

	table.sort(var_107_0, function(arg_108_0, arg_108_1)
		if arg_108_0.isbigBanner == arg_108_1.isbigBanner then
			return arg_108_0.order < arg_108_1.order
		else
			return arg_108_0.isbigBanner and not arg_108_1.isbigBanner
		end
	end)

	local var_107_8 = {}

	for iter_107_6, iter_107_7 in ipairs(var_107_0) do
		if iter_107_7.tab == 4 then
			var_107_8[#var_107_8 + 1] = iter_107_7
		end
	end

	return var_107_8
end

function ActivityGameBackGuideLayer:initRewardUI()
	self.panelReward = self.panelMain:getChildByName("panelReward")
	self.imgBannerReward = self.panelReward:getChildByName("imgBannerReward")

	self.imgBannerReward:setPositionType(0)
	self.imgBannerReward:setPositionY(self.imgBannerReward:getPositionY() - GameDisplay.statusbar_height)

	self.panelRewardTask = self.panelReward:getChildByName("panelTask")
	self.panelRewardTaskItem = self.panelRewardTask:getChildByName("panelTaskItem")

	self.panelRewardTaskItem:setVisible(false)

	self.panels[var_0_17.REWARD] = self.panelReward
end

function ActivityGameBackGuideLayer:handleRewardTaskList()
	self.rewardTaskListData = activity_return_manager:getRewardTaskListData(self.activityId) or {}
	self.rewardTaskListLen = #self.rewardTaskListData

	if self.rewardTaskView then
		self:updateShowingCells(self.rewardTaskView, self.rewardTaskListLen)

		return
	end

	self.rewardTaskView = cc.TableView:create(cc.size(var_0_13, self.panelRewardTask:getContentSize().height + GameDisplay.fix_y + 60))

	self.rewardTaskView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.rewardTaskView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.rewardTaskView:setAnchorPoint(cc.p(0, 0))
	self.rewardTaskView:setPosition(cc.p(0, GameDisplay.fix_y - 120))
	self.rewardTaskView:setDelegate()
	self.panelRewardTask:addChild(self.rewardTaskView)
	self.rewardTaskView:registerScriptHandler(handler(self, self.onNumberOfCellsRewardTask), cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.rewardTaskView:registerScriptHandler(handler(self, self.onCellSizeForIndexTask), cc.TABLECELL_SIZE_FOR_INDEX)
	self.rewardTaskView:registerScriptHandler(handler(self, self.updateRewardTaskCellAtIndex), cc.TABLECELL_SIZE_AT_INDEX)
	self.rewardTaskView:reloadData()
end

function ActivityGameBackGuideLayer:onNumberOfCellsRewardTask()
	return self.rewardTaskListLen
end

function ActivityGameBackGuideLayer:updateRewardTaskCellAtIndex(arg_112_1, arg_112_2)
	local var_112_0 = arg_112_1:dequeueCell()

	if not var_112_0 then
		var_112_0 = cc.TableViewCell:create()

		local var_112_1 = self:createRewardTaskItem(self.rewardTaskListData[arg_112_2 + 1])

		var_112_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_112_1:setPosition(cc.p(var_0_13 / 2, var_0_14 / 2))
		var_112_1:setName("panelTaskItem")
		var_112_0:addChild(var_112_1)
	else
		self:updateRewardTaskItem(var_112_0:getChildByName("panelTaskItem"), self.rewardTaskListData[arg_112_2 + 1])
	end

	return var_112_0
end

function ActivityGameBackGuideLayer:createRewardTaskItem(arg_113_1)
	local var_113_0 = self.panelRewardTaskItem:clone()

	self:updateRewardTaskItem(var_113_0, arg_113_1)

	return var_113_0
end

function ActivityGameBackGuideLayer:updateRewardTaskItem(arg_114_1, arg_114_2)
	arg_114_1:setVisible(true)

	local var_114_0 = arg_114_1:getChildByName("lbl_title")

	var_114_0:setString(arg_114_2.name)

	local var_114_1 = arg_114_1:getChildByName("lbl_des")

	print(arg_114_2.task_des, arg_114_2.name)
	var_114_0:setString(arg_114_2.task_des)
	arg_114_1:getChildByName("mask"):setVisible(arg_114_2.status >= 1)

	local var_114_2 = arg_114_1:getChildByName("btnRewardTask")

	Utility:addClickEventListener(var_114_2, handler(self, self.onBtnRewardTask2), arg_114_2)

	self.btnRewardTaskLock = true

	if arg_114_2.status >= 1 then
		var_114_2:loadTextures("ReturnBackReward/btn_got.png", nil, "ReturnBackReward/btn_got.png", var_0_12)
	elseif arg_114_2.percent >= 100 then
		var_114_2:loadTextures("ReturnBackReward/btn_get.png", nil, "ReturnBackReward/btn_get.png", var_0_12)
	else
		var_114_2:loadTextures("ReturnBackReward/btn_goto.png", nil, "ReturnBackReward/btn_goto.png", var_0_12)
	end

	local var_114_3 = activity_return_manager:getRewardTaskDropData(arg_114_2.taskid)

	for iter_114_0 = 1, 2 do
		local var_114_4 = arg_114_1:getChildByName("item_" .. iter_114_0)
		local var_114_5 = var_114_4:getChildByName("icon")

		if var_114_3[iter_114_0] then
			local var_114_6
			local var_114_8

			if var_114_3[iter_114_0].dropid == "diamond" then
				var_114_6 = "equipment/1000000.png"
				var_114_8 = 6
			else
				var_114_6 = "equipment/" .. item_data[var_114_3[iter_114_0].dropid].image_id .. ".png"
				var_114_8 = item_data[var_114_3[iter_114_0].dropid].equip_quality
			end

			var_114_4:loadTexture("public/box/box_activity_recharge_" .. var_114_8 .. ".png", var_0_12)
			var_114_5:loadTexture(var_114_6)
			var_114_5:setScale(0.45)
			var_114_4:getChildByName("num"):setString("X" .. var_114_3[iter_114_0].dropNum)
			var_114_4:setVisible(true)
		else
			var_114_4:setVisible(false)
		end
	end
end

function ActivityGameBackGuideLayer:onBtnRewardTask2(arg_115_1, arg_115_2)
	if not self.btnRewardTaskLock then
		return
	end

	if arg_115_2.status >= 1 then
		return
	end

	if arg_115_2.percent >= 100 then
		self.btnRewardTaskLock = false

		activity_return_manager:getTaskReward(arg_115_2.taskid)
	else
		Utility:executeLayerJump({
			systemid = arg_115_2.jump
		})

		self.isJump = true
		self.jumpTarget = SYSTEMID[arg_115_2.jump]
	end
end

function ActivityGameBackGuideLayer:handleGetReturnSignInfo()
	self:updateSignUI()
end

function ActivityGameBackGuideLayer:handleBpList(arg_117_1)
	print("handle bp list")

	if self.showTypeBp ~= var_0_24.LEVEL then
		return
	end

	self:updateBpTopUI()
	self:updateLevelView(arg_117_1.list, arg_117_1.listLen)
	self:updateRewardPreview()
end

function ActivityGameBackGuideLayer:handleBpTasks(arg_118_1)
	print("handle bp tasks")

	if self.showTypeBp ~= var_0_24.TASK then
		return
	end

	self:updateBpTopUI()
	self:updateTaskView(arg_118_1.list, arg_118_1.listLen)
end

function ActivityGameBackGuideLayer:handleReturnBackGuideList(arg_119_1)
	self:updateGuideUI(arg_119_1.guideids or {})
end

function ActivityGameBackGuideLayer:handleRequestActivityTaskList(arg_120_1)
	self.isRequestingGuideTask = false

	if var_0_26 == var_0_17.RECALL then
		self:updateCallUI(arg_120_1.list)

		return
	end

	self:showGuideTasks(arg_120_1.list or {})
end

function ActivityGameBackGuideLayer:handleRequestActivityTaskReward(arg_121_1)
	if not arg_121_1 then
		return
	end

	if arg_121_1.result == 1 then
		global_gain(arg_121_1)
		activity_manager:getExtraTaskList(self.activityId, "recall")
	end
end

function ActivityGameBackGuideLayer:handleLayerExitScene(arg_122_1)
	if not arg_122_1 or not arg_122_1.name then
		return
	end

	if arg_122_1.name == "PopReturnBackGuideTaskLayer" then
		self:updatePanelGuideAlert()
	end

	if not self.isJump or self.jumpTarget ~= arg_122_1.name then
		return
	end

	self.isJump = false

	activity_manager:getActivityTask(self.activityId)
	activity_manager:getExtraTaskList(self.activityId, "recall")
end

function ActivityGameBackGuideLayer:handleUpdateActivityStatusAlert(arg_123_1)
	self:updateRedDotAlert()
end

function ActivityGameBackGuideLayer:handlePurchaseSuccess(arg_124_1)
	self:updateBpTopUI()

	if self.showTypeBp == var_0_24.LEVEL then
		activity_manager:getBattlePassLevelData(self.activityId)
	end
end

function ActivityGameBackGuideLayer:updateShowBtns()
	local function var_125_0(arg_126_0, arg_126_1)
		local var_126_0 = Utility:removeElement(arg_126_0, function(arg_127_0)
			return arg_127_0.idx == arg_126_1
		end)

		if var_126_0 then
			var_126_0:removeFromParent()

			return true
		end

		return false
	end

	local var_125_1 = 0

	if not activity_return_manager:isReturnTimeSignFinish() and var_125_0(self.activityBtns, var_0_17.TIMESIGN) then
		var_125_1 = var_125_1 + 1
	end

	if activity_return_manager:isReturnSignFinish() and var_125_0(self.activityBtns, var_0_17.SIGN) then
		var_125_1 = var_125_1 + 1
	end

	if activity_return_manager:isCommitSurvey() and var_125_0(self.activityBtns, var_0_17.SURVEY) then
		var_125_1 = var_125_1 + 1
	end

	if activity_manager:isBpComplete(self.activityId) then
		-- block empty
	end

	if var_125_1 == #var_0_20 then
		var_125_0(self.switchBtns, var_0_17.SIGN)
	end

	if activity_manager:isGuideComplete(self.activityId) then
		var_125_0(self.switchBtns, var_0_17.GUIDE)
	end
end

function ActivityGameBackGuideLayer:initWakefundUI()
	require("view.Layer.ActivityNew.BaseLayer.ActivityWakefundBaseLayer")

	self.panelWakefund = ActivityWakefundBaseLayer:create({
		activityid = 176
	})

	self.panelWakefund:setPositionY(GameDisplay.fix_y + 43)
	self.panelMain:addChild(self.panelWakefund)
	self.panelWakefund:setVisible(false)

	self.panels[var_0_17.WAKEFUND] = self.panelWakefund
end

return ActivityGameBackGuideLayer
