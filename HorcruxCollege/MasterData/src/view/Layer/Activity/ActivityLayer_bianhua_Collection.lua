ActivityLayer_bianhua_Collection = class("ActivityLayer_bianhua_Collection", function()
	return cc.Layer:create()
end)

local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local activity_bianhua_manager = require("controller.activity_bianhua_manager")
local activity_proceed_data = require("data.activity_proceed_data")
local activity_conf_bianhua = require("data.activity_conf_bianhua")
local var_0_6 = config._DEBUG and 0 or 1
local var_0_8 = 2094
local var_0_9
local var_0_11 = 0
local var_0_12 = 0
local var_0_13 = 1
local var_0_14 = 2

function ActivityLayer_bianhua_Collection.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityLayer_bianhua_Collection.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityLayer_bianhua_Collection.getInstance()
	return var_0_9
end

function ActivityLayer_bianhua_Collection:init(arg_4_1)
	var_0_9 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Activity_bianhua_collection.json" or "Activity_bianhua_collection.ExportJson")

	self:addChild(self.rootLayer)
	self:initData()
	self:initUI()
	self:fullScreen(function(arg_5_0)
		self:createPtTaskList(arg_5_0)
	end)
	self:registerEventListenerAll()
	self:updateData(function()
		self:updateUI()
	end)
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			if self.callback then
				self.callback()
			end

			var_0_9 = nil

			activity_manager:releaseEventListenerByName("ActivityLayer_bianhua_Collection")
		end
	end)
end

function ActivityLayer_bianhua_Collection:initData()
	self.id = 9
	self.activity = activity_manager:getActivityObj(self.id)
	self.status = var_0_11
	self.lightcardStatus = {}
	self.awardCardNum = 0
	self.awardStatus = 0

	self:initPtAwardListData()
end

function ActivityLayer_bianhua_Collection:updateData(arg_9_1)
	if self:getStatus() == var_0_11 then
		self:updateLightCardData(arg_9_1)
	else
		self:updatePtAwardList(arg_9_1)
	end
end

function ActivityLayer_bianhua_Collection:updateLightCardData(arg_10_1)
	local function var_10_0(arg_11_0, arg_11_1)
		self.lightcardStatus[arg_11_0] = arg_11_1

		if arg_11_1 then
			self:setAwardCardNum(self:getAwardCardNum() + 1)
		end
	end

	self:setAwardCardNum(0)

	for iter_10_0 = 1, 4 do
		self:checkLightCard(iter_10_0, var_10_0)
	end

	self.activity:get_collection_status(function(arg_12_0)
		self:setAwardStatus(arg_12_0.collection_status)

		if arg_10_1 then
			arg_10_1()
		end
	end)
end

function ActivityLayer_bianhua_Collection.checkLightCard(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 then
		arg_13_2(arg_13_1, item_manager:getItemNumber(activity_conf_bianhua.collection.need_items[arg_13_1].itemid) > 0)
	end
end

function ActivityLayer_bianhua_Collection:initUI()
	self.panelCollect = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_collect")
	self.bgNet = ccui.Helper:seekWidgetByName(self.rootLayer, "net")
	self.collectBg = ccui.Helper:seekWidgetByName(self.rootLayer, "collect_bg")
	self.btnSwitch = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_switch")
	self.btnLight = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_light")
	self.btnPt = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_pt")
	self.imgLightCard = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_lightcard")
	self.imgPt = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_Pt")
	self.imgPtBg = ccui.Helper:seekWidgetByName(self.rootLayer, "img_pt")
	self.btnExchange = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_exchange")
	self.lightcardBg = ccui.Helper:seekWidgetByName(self.rootLayer, "lightcard_none")
	self.light = ccui.Helper:seekWidgetByName(self.rootLayer, "light")
	self.ptList = ccui.Helper:seekWidgetByName(self.rootLayer, "pt_list")
	self.progressBar = ccui.Helper:seekWidgetByName(self.rootLayer, "progress_bar")

	if activity_manager:getAlertStatus(9, "proceed") and not self.btnPt:getChildByName("reddot") then
		local var_14_0 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_6)

		var_14_0:setPosition(cc.p(68, 186))
		var_14_0:setName("reddot")
		var_14_0:setVisible(false)
		self.btnPt:addChild(var_14_0)
	end

	self.bgNet:loadTexture("mainScenebg/activity/branch9/decoration.png")

	self.lightcardArr = {}

	for iter_14_0 = 1, 4 do
		self.lightcardArr[iter_14_0] = self.lightcardBg:getChildByName("lightcard_" .. iter_14_0)
	end

	self:initTitle()
	self:initBtn()
end

function ActivityLayer_bianhua_Collection:initTitle()
	local var_15_0 = TitleSprite:create("public/title/title_activity_collection.png", 2)

	var_15_0.title:setPositionX(0)
	var_15_0:setAnchorPoint(cc.p(0, 1))
	var_15_0:setPosition(0, SCREEN_HEIGHT)
	var_15_0:setName("titleBg")

	local var_15_1 = ccui.Button:create("Activity_bianhua_Collection/infoBtn.png", "Activity_bianhua_Collection/infoBtn.png", "Activity_bianhua_Collection/infoBtn.png", var_0_6)

	var_15_1:setPosition(240, var_15_0:getContentSize().height / 2)
	var_15_0:addChild(var_15_1)
	var_15_1:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("显示活动信息")
		LayerManager:pushInLayer("PopActivityDetail", {
			key = string.format("activity_%d_%d", activity_bianhua_manager:getActivityId(), var_0_8)
		})
	end)
	self.rootLayer:addChild(var_15_0, 5)
end

function ActivityLayer_bianhua_Collection:createPtTaskList(arg_17_1)
	self.taskList = cc.TableView:create(cc.size(415, 642 + arg_17_1))

	self.taskList:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taskList:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taskList:setAnchorPoint(cc.p(0, 0))
	self.taskList:setPosition(129, 137)
	self.taskList:setDelegate()
	self.imgPt:addChild(self.taskList)
end

function ActivityLayer_bianhua_Collection:initBtn()
	self.btnLight:setBright(false)
	self.btnLight:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_19_0:isBright() then
			return
		end

		self.btnLight:setBright(false)
		self.btnPt:setBright(true)
		self:changeStatus()
		self:updateData(function()
			self:updateUI()
		end)
		print("转换到花")
	end)
	self.btnPt:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_21_0:isBright() then
			return
		end

		self.btnPt:setBright(false)
		self.btnLight:setBright(true)
		self:changeStatus()
		self:updateData(function()
			self:updateUI()
		end)
		print("转换到灯")
	end)
	self:initBottomBtnList()
end

function ActivityLayer_bianhua_Collection:initBottomBtnList()
	self.bottomlist = BottomBtnList:create(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()

		if callback then
			callback()
		end
	end, {})

	self:addChild(self.bottomlist, 5)
end

function ActivityLayer_bianhua_Collection:updateUI()
	if self:getStatus() == var_0_11 then
		self.imgPt:setVisible(false)
		self.imgLightCard:setVisible(true)
		self.imgLightCard:setOpacity(0)
		self.imgLightCard:runAction(cc.Sequence:create(cc.FadeIn:create(0.2)))
		self:updateLightCardUI()
	else
		self.imgLightCard:setVisible(false)
		self.imgPt:setVisible(true)
		self.imgPt:setOpacity(0)
		self.imgPt:runAction(cc.Sequence:create(cc.FadeIn:create(0.2)))
		self:updatePtUI()
	end
end

function ActivityLayer_bianhua_Collection:updateLightCardUI()
	self:updateLightCard()
	self:updateAwardBtn()
	self:updateAwardList()
end

function ActivityLayer_bianhua_Collection:updateLightCard()
	for iter_27_0, iter_27_1 in ipairs(self.lightcardStatus) do
		if iter_27_1 then
			self.lightcardArr[iter_27_0]:setVisible(true)
			self.lightcardArr[iter_27_0]:getChildByName("shine"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(1.5, 0), cc.FadeTo:create(1.5, 255))))
		end
	end
end

function ActivityLayer_bianhua_Collection:updateAwardBtn()
	if self:getAwardCardNum() < 4 then
		self.btnExchange:setBright(false)
		self.btnExchange:loadTextures("Activity_bianhua_Collection/btn_no_lightcard.png", "Activity_bianhua_Collection/btn_no_lightcard.png", "Activity_bianhua_Collection/btn_no_lightcard.png", var_0_6)
	elseif self:getAwardCardNum() == 4 and self:getAwardStatus() == var_0_12 then
		self.btnExchange:setBright(true)
		self.btnExchange:loadTextures("Activity_bianhua_Collection/btn_enough_lightcard.png", "Activity_bianhua_Collection/btn_enough_lightcard.png", "Activity_bianhua_Collection/btn_enough_lightcard.png", var_0_6)
	else
		self.btnExchange:setBright(false)
		self.btnExchange:loadTextures("Activity_bianhua_Collection/btn_used_lightcard.png", "Activity_bianhua_Collection/btn_used_lightcard.png", "Activity_bianhua_Collection/btn_used_lightcard.png", var_0_6)
	end

	self.btnExchange:addTouchEventListener(function(arg_29_0, arg_29_1)
		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.btnExchange:setBright(false)
		self.activity:get_collection_reward(function(arg_30_0)
			self:receiveLightCardAward(arg_30_0)
		end)
		print("注册事件，写在manager里，和服务器通信获取物品")
	end)
end

function ActivityLayer_bianhua_Collection:updateAwardList()
	local var_31_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "furniture_all")

	var_31_0:loadTexture("mainScenebg/activity/branch9/furniture_suit.png")
	var_31_0:setScale(0.7)

	if not var_31_0:getChildByName("hide_panel") then
		local var_31_1 = ccui.Layout:create()

		var_31_1:setContentSize(cc.size(var_31_0:getContentSize().width, var_31_0:getContentSize().height))
		var_31_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_31_1:setAnchorPoint(0.5, 0.5)
		var_31_1:setPosition(cc.p(var_31_0:getContentSize().width / 2, var_31_0:getContentSize().height / 2))
		var_31_1:setBackGroundColor(cc.c3b(8, 14, 71))
		var_31_1:setBackGroundColorOpacity(128)
		var_31_1:setName("hide_panel")
		var_31_0:addChild(var_31_1)

		local var_31_2 = ccui.ImageView:create("Activity_bianhua_Collection/finish_tick.png", var_0_6)

		var_31_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_31_2:setPosition(cc.p(var_31_1:getContentSize().width / 2, var_31_1:getContentSize().height / 2))
		var_31_2:setScale(2)
		var_31_2:setVisible(false)
		var_31_2:setName("tick")
		var_31_1:addChild(var_31_2)
	end

	if self:getAwardStatus() == var_0_12 then
		var_31_0:getChildByName("hide_panel"):setVisible(false)
	else
		var_31_0:getChildByName("hide_panel"):setVisible(true)
		var_31_0:getChildByName("hide_panel"):getChildByName("tick"):setVisible(true)
	end
end

function ActivityLayer_bianhua_Collection:getAwardCardNum()
	return self.awardCardNum
end

function ActivityLayer_bianhua_Collection.getLightCardAwardList(arg_33_0)
	local var_33_0 = drop_manager:getDropMsg(activity_conf_bianhua.collection.drop)
	local var_33_1 = {}

	if var_33_0.gold and var_33_0.gold ~= 0 then
		table.insert(var_33_1, {
			itemid = "gold",
			itemNum = var_33_0.gold
		})
	end

	if var_33_0.diamond and var_33_0.diamond ~= 0 then
		table.insert(var_33_1, {
			itemid = "diamond",
			itemNum = var_33_0.diamond
		})
	end

	if var_33_0.equips then
		for iter_33_0, iter_33_1 in ipairs(var_33_0.equips) do
			table.insert(var_33_1, {
				itemid = iter_33_1.dropid,
				itemNum = iter_33_1.dropNum
			})
		end
	end

	return var_33_1
end

function ActivityLayer_bianhua_Collection.receiveLightCardAward(arg_34_0, arg_34_1)
	local var_34_1 = {}

	var_34_1.gold = arg_34_1.gold
	var_34_1.diamond = arg_34_1.diamond
	var_34_1.items = arg_34_1.items

	global_gain(var_34_1)
end

function ActivityLayer_bianhua_Collection:initPtAwardListData()
	self.ptTaskList = {
		taskTotal = 0,
		taskFinish = 0,
		taskTbl = {}
	}

	for iter_37_0, iter_37_1 in pairs(activity_proceed_data) do
		if iter_37_1.activityid == self.id then
			table.insert(self.ptTaskList.taskTbl, {
				ptNum = iter_37_1.num1,
				ptItem = iter_37_1.item1,
				itemList = drop_manager:getDropMsg(iter_37_1.drop),
				status = var_0_14,
				id = tonumber(split(iter_37_1.id, "-")[2])
			})
		end
	end

	table.sort(self.ptTaskList.taskTbl, function(arg_38_0, arg_38_1)
		return arg_38_0.id < arg_38_1.id
	end)

	self.ptTaskList.taskTotal = #self.ptTaskList.taskTbl
end

function ActivityLayer_bianhua_Collection:updatePtAwardList(arg_39_1)
	self.activity:getActivityProceed(function(arg_40_0, arg_40_1)
		if arg_40_0 == 1 then
			local function var_40_0(arg_41_0)
				if arg_41_0.ptNum > item_manager:getItemNumber(arg_41_0.ptItem) then
					return false
				end

				return true
			end

			for iter_40_0, iter_40_1 in pairs(arg_40_1) do
				if iter_40_1.status == var_0_13 then
					self.ptTaskList.taskTbl[iter_40_1.id].status = iter_40_1.status
				elseif var_40_0(self.ptTaskList.taskTbl[iter_40_1.id]) then
					self.ptTaskList.taskTbl[iter_40_1.id].status = var_0_12 or var_0_14
				end
			end

			local var_40_2 = 0

			for iter_40_2, iter_40_3 in pairs(self.ptTaskList.taskTbl) do
				if iter_40_3.status == var_0_13 then
					var_40_2 = var_40_2 + 1
				end
			end

			self.ptTaskList.taskFinish = var_40_2

			print("?????????ddddddddddddd", self.ptTaskList.taskFinish)

			if arg_39_1 then
				arg_39_1()
			end
		end
	end)
end

function ActivityLayer_bianhua_Collection:getPtTaskTotal()
	return self.ptTaskList.taskTotal
end

function ActivityLayer_bianhua_Collection:getPtTaskFinish()
	return self.ptTaskList.taskFinish
end

function ActivityLayer_bianhua_Collection:updatePtUI()
	self.ptList:setVisible(false)
	self:updatePtList()
	self:updateProgressBar()
end

function ActivityLayer_bianhua_Collection:updatePtList()
	self.taskList:registerScriptHandler(function(arg_46_0, arg_46_1)
		return self:getPtTaskTotal()
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.taskList:registerScriptHandler(function(arg_47_0)
		return
	end, cc.SCROLLVIEW_SCRIPT_SCROLL)
	self.taskList:registerScriptHandler(function(arg_48_0)
		return
	end, cc.SCROLLVIEW_SCRIPT_ZOOM)
	self.taskList:registerScriptHandler(function(arg_49_0, arg_49_1)
		print("cell touched at index: " .. arg_49_1:getIdx())
	end, cc.TABLECELL_TOUCHED)
	self.taskList:registerScriptHandler(function(arg_50_0, arg_50_1)
		return 415, 96
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taskList:registerScriptHandler(function(arg_51_0, arg_51_1)
		local var_51_0 = arg_51_0:dequeueCell()

		if not var_51_0 then
			var_51_0 = cc.TableViewCell:create()

			if type(self.ptTaskList.taskTbl[arg_51_1 + 1]) == "table" then
				self.ptTaskList.taskTbl[arg_51_1 + 1].index = arg_51_1 + 1
			end

			local var_51_1 = self:drawPtListCell(self.ptTaskList.taskTbl[arg_51_1 + 1], arg_51_1 + 1)

			var_51_1:setName("task_info")
			var_51_1:setVisible(true)
			var_51_1:setPosition(cc.p(0, 0))
			var_51_0:addChild(var_51_1)
		else
			var_51_0:getChildByName("task_info"):updateCell(self.ptTaskList.taskTbl[arg_51_1 + 1])
		end

		return var_51_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taskList:reloadData()
end

function ActivityLayer_bianhua_Collection:drawPtListCell(arg_52_1, arg_52_2)
	local var_52_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "pt_cell"):clone()

	var_52_0.index = arg_52_2

	local var_52_1 = cc.Label:createWithBMFont("fonts/bianhua_collection.fnt", arg_52_1.ptNum)

	var_52_1:setAnchorPoint(cc.p(0, 0))
	var_52_1:setPosition(6, -10)
	var_52_1:setName("numLabel")
	var_52_0:getChildByName("pt_cell_bg"):addChild(var_52_1)

	function var_52_0:updateCell(arg_53_1)
		local var_53_0 = self:getChildByName("pt_cell_bg")
		local var_53_1 = var_53_0:getChildByName("pt_status")
		local var_53_2 = var_53_0:getChildByName("obj_panel")
		local var_53_3 = var_53_0:getChildByName("numLabel")

		var_53_0:getChildByName("pt_num"):setVisible(false)
		self:setVisible(true)
		var_53_2:setTouchEnabled(false)
		self:setTouchEnabled(false)

		var_53_1.id = arg_53_1.id

		var_53_1:setBright(true)

		if arg_53_1.status == var_0_14 then
			var_53_0:loadTexture("Activity_bianhua_Collection/cell_gray.png", var_0_6)
			var_53_1:setVisible(false)
			var_53_3:setString(arg_53_1.ptNum)
			var_53_3:setColor(cc.c3b(0, 163, 182))
		elseif arg_53_1.status == var_0_12 then
			var_53_0:loadTexture("Activity_bianhua_Collection/cell_color.png", var_0_6)
			var_53_1:setVisible(true)
			var_53_1:loadTextures("Activity_bianhua_Collection/btn_can_get.png", "Activity_bianhua_Collection/btn_can_get.png", "Activity_bianhua_Collection/btn_can_get.png", var_0_6)
			var_53_3:setString(arg_53_1.ptNum)
			var_53_3:setColor(cc.c3b(225, 135, 255))
			var_53_1:addTouchEventListener(function(arg_54_0, arg_54_1)
				if arg_54_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_54_0:isBright() then
					return
				end

				var_53_1:setBright(false)
				var_53_1:loadTextures("Activity_bianhua_Collection/btn_have_got.png", "Activity_bianhua_Collection/btn_have_got.png", "Activity_bianhua_Collection/btn_have_got.png", var_0_6)
				self:getActivityProceedAward(arg_54_0.id, function(...)
					arg_54_0:setBright(true)
				end)
			end)
		elseif arg_53_1.status == var_0_13 then
			var_53_0:loadTexture("Activity_bianhua_Collection/cell_color.png", var_0_6)
			var_53_1:setVisible(true)
			var_53_1:setBright(false)
			var_53_1:loadTextures("Activity_bianhua_Collection/btn_have_got.png", "Activity_bianhua_Collection/btn_have_got.png", "Activity_bianhua_Collection/btn_have_got.png", var_0_6)
			var_53_3:setString(arg_53_1.ptNum)
			var_53_3:setColor(cc.c3b(225, 135, 255))
		else
			global_ShowBlockWords("非法请求")
		end

		self:drawPtObjList(var_53_2, arg_53_1.itemList, arg_53_1.status)
	end

	var_52_0:updateCell(arg_52_1)

	return var_52_0
end

function ActivityLayer_bianhua_Collection:getActivityProceedAward(arg_56_1, arg_56_2)
	self.activity:getActivityProceedAward(arg_56_1, function(arg_57_0, arg_57_1)
		if arg_57_0 == 1 and self then
			global_gain(arg_57_1)

			self.ptTaskList.taskTbl[arg_56_1].status = var_0_13

			if self.btnPt:getChildByName("reddot") then
				self.btnPt:getChildByName("reddot"):setVisible(false)
			end

			for iter_57_0, iter_57_1 in pairs(self.ptTaskList.taskTbl) do
				if iter_57_1.status == var_0_12 and self.btnPt:getChildByName("reddot") then
					self.btnPt:getChildByName("reddot"):setVisible(false)
				end
			end
		end

		if self and arg_56_2 then
			arg_56_2()
		end
	end)
end

function ActivityLayer_bianhua_Collection:drawPtObjList(arg_58_1, arg_58_2, arg_58_3)
	arg_58_1:removeAllChildren()

	local var_58_0 = {
		0,
		130,
		90
	}
	local var_58_1 = 0

	for iter_58_0, iter_58_1 in ipairs(arg_58_2.equips) do
		local var_58_2 = ccui.Layout:create()

		var_58_2:setContentSize(cc.size(75, 75))
		var_58_2:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
		var_58_2:setAnchorPoint(0, 0)

		if arg_58_3 == var_0_14 then
			var_58_2:setOpacity(120)

			var_58_1 = var_58_0[#arg_58_2.equips]
		else
			var_58_2:setOpacity(255)

			var_58_1 = 75
		end

		local var_58_3

		var_58_2:setPosition(cc.p(40 + var_58_1 * (iter_58_0 - 1), 0))
		arg_58_1:addChild(var_58_2, 10)

		var_58_3 = not activity_bianhua_manager:checkIfHead(iter_58_1.dropid) and ItemSmallSprite:createSmallItem(iter_58_1.dropid, iter_58_1.dropNum, self.goto_back_system_id) or ItemSmallSprite:createSmallItem(iter_58_1.dropid, iter_58_1.dropNum, nil, self.goto_back_system_id, (activity_bianhua_manager:getHeadPath(iter_58_1.dropid)))

		var_58_3:setScale(0.36)
		var_58_3:getChildByName("icon"):setScale(1.1)
		var_58_3:getChildByName("numLabel"):setScale(2)
		var_58_3:setInfoTouchEvent(true)
		var_58_3:setPosition(cc.p(var_58_2:getContentSize().width / 2, var_58_2:getContentSize().height / 2))
		var_58_2:addChild(var_58_3)
	end
end

function ActivityLayer_bianhua_Collection:updateProgressBar()
	self.progressBar:setPercent(self:getPtTaskFinish() / self:getPtTaskTotal() * 100)
	self:updateProgressBarText()
end

function ActivityLayer_bianhua_Collection:updateProgressBarText()
	ccui.Helper:seekWidgetByName(self.rootLayer, "progress_label"):setString(self:getPtTaskFinish() .. "/" .. self:getPtTaskTotal())
end

function ActivityLayer_bianhua_Collection:fullScreen(arg_61_1)
	local var_61_0 = self.rootLayer:getChildByName("titleBg")

	var_61_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 0, TRANSFORM_UNIT.PX)

	var_61_0:setPositionY(var_61_0.full_posY)

	self.panelCollect.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, GameDisplay.height * 0.15, TRANSFORM_UNIT.PX)

	self.panelCollect:setPositionY(self.panelCollect.full_posY)

	self.bottomlist.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.bottomlist:getPositionY(), TRANSFORM_UNIT.PX)

	self.bottomlist:setPositionY(self.bottomlist.full_posY)
	self:changeFullBgSize(arg_61_1)
end

function ActivityLayer_bianhua_Collection:changeFullBgSize(arg_62_1)
	local var_62_0 = self.collectBg:getContentSize().height

	self.collectBg:setScale9Enabled(true)
	self.collectBg:setCapInsets(cc.rect(0, 300, 625, 50))
	self.collectBg:setContentSize(cc.size(self.collectBg:getContentSize().width, GameDisplay.height * 0.7))
	self.collectBg:setPositionY(self.collectBg:getPositionY() + (self.collectBg:getContentSize().height - var_62_0) / 2)

	local var_62_1 = self.collectBg:getContentSize().height - var_62_0
	local var_62_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cut")

	var_62_2:setContentSize(cc.size(var_62_2:getContentSize().width, var_62_2:getContentSize().height + var_62_1))
	self.imgPtBg:setContentSize(cc.size(self.imgPtBg:getContentSize().width, self.imgPtBg:getContentSize().height + var_62_1))
	self.ptList:setContentSize(cc.size(self.ptList:getContentSize().width, self.ptList:getContentSize().height + var_62_1))

	local var_62_3 = self.imgLightCard:getChildByName("lightcard_bg")
	local var_62_4 = self.imgLightCard:getChildByName("award_list_bg")
	local var_62_5 = self.imgLightCard:getChildByName("award_list_title")

	self.light:setPositionY(self.light:getPositionY() + var_62_1 * 0.74)
	self.btnSwitch:setPositionY(self.btnSwitch:getPositionY() + var_62_1 * 0.81)
	var_62_3:setPositionY(var_62_3:getPositionY() + var_62_1 * 0.9)
	var_62_4:setPositionY(var_62_4:getPositionY() + var_62_1 * 0.3)
	var_62_5:setPositionY(var_62_5:getPositionY() + var_62_1 * 0.3)
	self.imgPtBg:setPositionY(self.imgPtBg:getPositionY() + var_62_1 / 2)

	if arg_62_1 then
		arg_62_1(var_62_1)
	end
end

function ActivityLayer_bianhua_Collection.registerEventListenerAll(arg_63_0)
	activity_manager:registerEventListener("ActivityLayer_bianhua_Collection", activity_manager.activityEventId.EXIT_FORM_PURCHASE_LAYER, function(arg_64_0)
		arg_63_0:updateData(function()
			if arg_63_0:getStatus() == var_0_11 then
				arg_63_0:updateUI()
			else
				arg_63_0:updateProgressBar()
			end
		end)
	end)
end

function ActivityLayer_bianhua_Collection:changeStatus()
	if self:getStatus() == var_0_11 then
		self:setStatus(1)
	else
		self:setStatus(0)
	end
end

function ActivityLayer_bianhua_Collection:getStatus()
	return self.status
end

function ActivityLayer_bianhua_Collection.setStatus(arg_68_0, arg_68_1)
	arg_68_0.status = arg_68_1
end

function ActivityLayer_bianhua_Collection:getAwardCardNum()
	return self.awardCardNum
end

function ActivityLayer_bianhua_Collection.setAwardCardNum(arg_70_0, arg_70_1)
	arg_70_0.awardCardNum = arg_70_1
end

function ActivityLayer_bianhua_Collection:getAwardStatus()
	return self.awardStatus
end

function ActivityLayer_bianhua_Collection.setAwardStatus(arg_72_0, arg_72_1)
	arg_72_0.awardStatus = arg_72_1
end
