ActivityNoviceTaskLayer = class("ActivityNoviceTaskLayer", function()
	return PopBaseLayer:create()
end)

local task_data = require("data.task_data")
local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local drop_manager = require("controller.drop_manager")
local time_check_manager = require("controller.time_check_manager")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local ShowGirlLayer = require("view.Layer.ShowGirlLayer")
local var_0_8 = config._DEBUG and 0 or 1
local var_0_9 = "mainScenebg/task_img/"
local var_0_11 = 135
local var_0_12 = {
	{
		on = "ActivityNoviceTaskLayer/day_sp_on.png",
		off = "ActivityNoviceTaskLayer/day_sp.png"
	},
	{
		on = "ActivityNoviceTaskLayer/day_first_on.png",
		off = "ActivityNoviceTaskLayer/day_first.png"
	},
	{
		on = "ActivityNoviceTaskLayer/day_second_on.png",
		off = "ActivityNoviceTaskLayer/day_second.png"
	},
	{
		on = "ActivityNoviceTaskLayer/day_third_on.png",
		off = "ActivityNoviceTaskLayer/day_third.png"
	},
	{
		on = "ActivityNoviceTaskLayer/day_fouth_on.png",
		off = "ActivityNoviceTaskLayer/day_fouth.png"
	},
	{
		on = "ActivityNoviceTaskLayer/day_fifth_on.png",
		off = "ActivityNoviceTaskLayer/day_fifth.png"
	},
	{
		on = "ActivityNoviceTaskLayer/day_six_on.png",
		off = "ActivityNoviceTaskLayer/day_six.png"
	},
	{
		on = "ActivityNoviceTaskLayer/day_seven_on.png",
		off = "ActivityNoviceTaskLayer/day_seven.png"
	}
}
local var_0_13 = {
	7,
	2,
	3,
	4,
	5,
	6,
	8,
	9
}

local function var_0_14(...)
	local activity_task_index_data = require("data.activity_task_index_data")

	return (playermodel.create_time > os.time(parse_time("2021-05-28 00:00:00")) or nil) and require("data.activity_sevendays_index_data")
end

function ActivityNoviceTaskLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = ActivityNoviceTaskLayer.new()

	var_3_0:dealWithSpInfo(function()
		var_3_0:init(arg_3_1)
	end)

	return var_3_0
end

function ActivityNoviceTaskLayer:init(arg_5_1)
	local var_5_0 = config._DEBUG and "ActivityNoviceTaskLayer.json" or "ActivityNoviceTaskLayer.ExportJson"

	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setContentSize(cc.size(640, GameDisplay.height))
	self.rootLayer:setTouchEnabled(false)
	self:addChild(self.rootLayer)

	self.rootpanel = ccs.GUIReader:getInstance():widgetFromJsonFile(var_5_0)

	self.rootpanel:setPositionY(-200 + GameDisplay.fix_y + GameDisplay.fix_y)
	self.rootLayer:addChild(self.rootpanel, 10)

	self.rewardid = 1340498

	self:initUI()
	self:registerActivityEventListener()
	self:switchPlotTaskClass(self._startIndex)
	self:getActivityTaskListBecauseOfAlert()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			if self.taskPanel then
				self.taskPanel:release()
			end

			activity_manager:releaseEventListenerByName("ActivityNoviceTaskLayer")
		end
	end)
end

function ActivityNoviceTaskLayer.registerActivityEventListener(arg_7_0)
	activity_manager:registerEventListener("ActivityNoviceTaskLayer", activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_8_0)
		arg_7_0:updateTaskView()
		arg_7_0:updateTaskBtnAlert()
		arg_7_0:updateProgress()
		arg_7_0:notifyUpdate()
	end)
end

function ActivityNoviceTaskLayer.notifyUpdate(arg_9_0)
	cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("NOVICE_SUMMARY_UPDATE")))
end

function ActivityNoviceTaskLayer:initUI()
	self.bg = ccui.Helper:seekWidgetByName(self.rootpanel, "Image_bg")

	self.bg:loadTexture("ActivityNoviceTaskLayer/bg_new.png", var_0_8)

	local var_10_0 = ccui.Helper:seekWidgetByName(self.rootpanel, "Image_18")

	var_10_0:setPositionY(var_10_0:getPositionY() + 80)

	self.award_finish = ccui.ImageView:create("ActivityNoviceTaskLayer/award_finish.png", var_0_8)

	self.award_finish:setAnchorPoint(0.5, 0.5)
	self.award_finish:setPosition(var_10_0:getPositionX(), var_10_0:getPositionY() - 136)
	var_10_0:getParent():addChild(self.award_finish, 999)

	self.noviceBg = ccui.ImageView:create("ActivityNoviceTaskLayer/noviceBg.png", var_0_8)

	self.bg:addChild(self.noviceBg)
	self.noviceBg:setPosition(100, 1050)

	self.rewardBg = ccui.ImageView:create("ActivityNoviceTaskLayer/reward_bg.png", var_0_8)

	self.bg:addChild(self.rewardBg)
	self.rewardBg:setAnchorPoint(0, 0)
	self.rewardBg:setPosition(10, 900)

	local var_10_1 = ccui.ImageView:create("ActivityNoviceTaskLayer/task_progress_bg.png", var_0_8)

	var_10_1:setPosition(cc.p(300, 15))
	self.rewardBg:addChild(var_10_1)

	self.progressBg = var_10_1

	local var_10_2 = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("ActivityNoviceTaskLayer/task_progress.png") or cc.Sprite:createWithSpriteFrameName("ActivityNoviceTaskLayer/task_progress_bg.png")))

	var_10_2:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	var_10_2:setMidpoint(cc.p(0, 0.5))
	var_10_2:setBarChangeRate(cc.p(1, 0))
	var_10_2:setPercentage(100)
	var_10_2:setPosition(cc.p(300, 15))
	var_10_2:setName("progress")
	self.rewardBg:addChild(var_10_2)

	self.progress = var_10_2
	self.completeTask = self.completeTask or 0
	self.needCount = self.needCount or 0
	self.progressLable = cc.Label:createWithTTF(self.completeTask .. "/" .. self.needCount, FONT_NAME, 18)

	self.progressLable:setPosition(300, 5)
	self.progress:addChild(self.progressLable)

	local var_10_3 = ccui.Button:create("ActivityNoviceTaskLayer/icon.png", nil, "ActivityNoviceTaskLayer/icon.png", var_0_8)

	var_10_3:setPosition(self.rewardBg:getContentSize().width - 48, self.rewardBg:getContentSize().height / 2)
	self.rewardBg:addChild(var_10_3)
	var_10_3:setLocalZOrder(999)
	var_10_3:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.isComplete then
			self:confirmAwards(self.rewardid, arg_11_0)
		else
			showItemDetails(drop_manager:getDropMsg(task_data[self.rewardid].drop).equips[1].dropid)
		end
	end)

	self.taskPanel = ccui.Helper:seekWidgetByName(self.rootpanel, "label_exp")

	self.taskPanel:retain()

	local var_10_4 = ccui.Button:create("ActivityNoviceTaskLayer/button_gray.png", nil, "ActivityNoviceTaskLayer/button_gray.png", var_0_8)

	var_10_4:setPosition(cc.p(self.taskPanel:getChildByName("button_goto"):getPositionX(), self.taskPanel:getChildByName("button_goto"):getPositionY()))
	var_10_4:setName("button_gray")
	self.taskPanel:addChild(var_10_4)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_touch"):setTouchEnabled(true)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_touch"):addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopShowGilrPreviewLayer", {
			itemid = 6410830
		})
	end)
	self.taskPanel:removeFromParent()

	self.showgirlLayer = ShowGirlLayer:create(item_data[6410830].model)

	self.showgirlLayer:setPosition(cc.p(-220, 0))
	self.showgirlLayer:setScale(0.8)
	self.showgirlLayer:setTalkEnabled(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_spineskin"):addChild(self.showgirlLayer, 10)

	self.backGroundLayer = BackGroundLayer:create(model_data[item_data[6410830].model].backgroundid_main or 6300001, 1)

	self.backGroundLayer:setPosition(cc.p(-220, -200))
	self.backGroundLayer:setScale(0.8)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_spineskin"):addChild(self.backGroundLayer)
	self:createSwitchBtnList()
	self:fullScreen()
end

function ActivityNoviceTaskLayer:updateProgress()
	self.progressLable:setString(self.completeTask .. "/" .. self.needCount)
	self.progress:setPercentage(self.completeTask / self.needCount * 100)

	self.taskLabel = cc.Label:createWithTTF(string.format(L_NOVICELAYER[1], self.needCount), FONT_NAME, 24)

	self.rewardBg:addChild(self.taskLabel)
	self.taskLabel:setPosition(self.rewardBg:getContentSize().width / 2, self.rewardBg:getContentSize().height - 25)
end

function ActivityNoviceTaskLayer:createSwitchBtnList()
	self.classBnts = {}
	self.btnsByStage = {}
	self.dropListView = ccui.ListView:create()

	self.dropListView:setDirection(ccui.ListViewDirection.horizontal)
	self.dropListView:setItemsMargin(2)
	self.dropListView:setAnchorPoint(cc.p(0, 0))
	self.dropListView:setPosition(200, 1070)
	self.dropListView:setContentSize(cc.size(640, 88))
	self.rootpanel:addChild(self.dropListView, 11111)

	for iter_15_0 = self._startIndex or 1, #var_0_12 do
		local var_15_0 = ccui.Button:create(var_0_12[iter_15_0].off, var_0_12[iter_15_0].on, var_0_12[iter_15_0].on, var_0_8)

		var_15_0:setAnchorPoint(cc.p(0, 0))
		var_15_0:setName("classBnt" .. iter_15_0)
		self.dropListView:pushBackCustomItem(var_15_0)

		self.classBnts[iter_15_0] = var_15_0
		self.btnsByStage[var_0_13[iter_15_0]] = var_15_0

		var_15_0:addTouchEventListener(function(arg_16_0, arg_16_1)
			if arg_16_1 ~= ccui.TouchEventType.ended then
				return
			end

			if global_button_lock then
				return
			end

			self:switchPlotTaskClass(iter_15_0)
		end)

		if playermodel.create_time < os.time(parse_time("2021-05-28 00:00:00")) and (iter_15_0 == 7 or iter_15_0 == 8) then
			var_15_0:setVisible(false)
		end
	end
end

function ActivityNoviceTaskLayer:switchPlotTaskClass(arg_17_1)
	arg_17_1 = arg_17_1 or self.curClassType

	if self.curClassType == arg_17_1 then
		return
	end

	for iter_17_0, iter_17_1 in pairs(self.classBnts) do
		iter_17_1:setBright(iter_17_0 ~= arg_17_1)
	end

	self.curClassType = arg_17_1
	global_button_lock = true

	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		global_button_lock = false
	end)))
	self:getActivityTaskByStage()
end

function ActivityNoviceTaskLayer:updateTaskView()
	if not self.taskList then
		return
	end

	if self.taskView then
		self.taskView:reloadData()

		return
	end

	self.taskView = cc.TableView:create(cc.size(589, 850))

	self.taskView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taskView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taskView:setAnchorPoint(cc.p(0, 0))
	self.taskView:setPosition(196, 114)
	self.taskView:setDelegate()
	self.rootpanel:addChild(self.taskView, 5000)
	self.taskView:registerScriptHandler(function(arg_20_0, arg_20_1)
		return 640, var_0_11
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taskView:registerScriptHandler(function(arg_21_0, arg_21_1)
		local var_21_0 = arg_21_0:dequeueCell()

		if not var_21_0 then
			var_21_0 = cc.TableViewCell:create()

			var_21_0:setName("cell_" .. arg_21_1)

			local var_21_1 = self:createTaskInfoPanel(self.taskList[arg_21_1 + 1], arg_21_1)

			var_21_1:setName("taskinfo")
			var_21_1:setPosition(cc.p(0, 25))
			var_21_0:addChild(var_21_1)
		else
			var_21_0:getChildByName("taskinfo"):updateTaskInfo(self.taskList[arg_21_1 + 1])
		end

		return var_21_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taskView:registerScriptHandler(function(arg_22_0, arg_22_1)
		return #self.taskList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.taskView:reloadData()
end

function ActivityNoviceTaskLayer:createTaskInfoPanel(arg_25_1, arg_25_2)
	local var_25_0 = self.taskPanel:clone()

	var_25_0:getChildByName("des"):setContentSize(cc.size(200, 100))

	var_25_0.index = arg_25_2

	var_25_0:getChildByName("button_goto"):setName("button_goto_" .. arg_25_2)

	function var_25_0:updateTaskInfo(arg_26_1)
		self.taskinfo = arg_26_1

		if arg_26_1.percent then
			self:updateTriggeredTask()
		else
			self:updateFinishedTask()
		end
	end

	function var_25_0:updateFinishedTask()
		local var_27_0 = task_data[self.taskinfo.taskid]

		if task_data[self.taskinfo.taskid] and var_27_0.medal_id then
			local var_27_3 = self:getChildByName("medal")

			if not var_27_3 then
				var_27_3 = createMedal()

				var_27_3:setPositionX(self:getChildByName("Image_task"):getPositionX() + 5)
				var_27_3:setPositionY(self:getChildByName("Image_task"):getPositionY() - 5)
				self:addChild(var_27_3)
			end

			var_27_3:setVisible(true)

			local var_27_4 = item_data[tonumber(var_27_0.medal_id)]

			var_27_3:setTexture((item_data[itemid].bg or nil) and ("equipment/" .. var_27_4.bg .. ".png" or medal_frame[var_27_4.equip_quality]))
			var_27_3:setString(var_27_4.name)
			var_27_3:enableOutline(medal_colors[var_27_4.equip_quality], 1)
			var_27_3:enableShadow(medal_colors[var_27_4.equip_quality], cc.size(0, 0))
		elseif self:getChildByName("medal") then
			self:getChildByName("medal"):removeFromParent()
		end

		if self:getChildByName("item_sp") then
			self:getChildByName("item_sp"):removeFromParent()
		end

		local var_27_9 = drop_manager:getDropMsg(var_27_0.drop)

		if not next(var_27_9.equips) and var_27_9.diamond > 0 then
			var_27_9.equips[1] = {
				dropid = "diamond"
			}
		end

		local var_27_10 = ItemPurchaseSprite:createPurchaseItem(var_27_9.equips[1].dropid)
		local var_27_11 = self:getChildByName("Image_task")

		var_27_10:setName("item_sp")
		var_27_10:setScale(0.5)
		var_27_10:setPosition(cc.p(var_27_11:getPositionX(), var_27_11:getPositionY()))
		self:addChild(var_27_10)
		var_27_10:setTouchEnabled(true)
		var_27_10:addTouchEventListener(function(arg_28_0, arg_28_1)
			if arg_28_1 ~= ccui.TouchEventType.ended then
				return
			end

			showItemDetails(var_27_9.equips[1].dropid)
		end)
		self:getChildByName("name"):setString(var_27_0.name)
		self:getChildByName("des"):setString(var_27_0.task_des)
		self:getChildByName("Image_task"):setVisible(false)
		self:getChildByName("button_goto_" .. self.index):setVisible(false)
		self:getChildByName("button_getAwards"):setVisible(false)
		self:getChildByName("button_done"):setVisible(true)
		self:getChildByName("ProgressBar"):setVisible(false)
		self:getChildByName("button_gray"):setVisible(false)
		self:getChildByName("bar_bg"):setVisible(false)
		self:updateAwardList(var_27_0.drop)
	end

	function var_25_0:updateTriggeredTask()
		local var_29_0 = self.taskinfo

		if self.taskinfo.medal_id then
			local var_29_2 = self:getChildByName("medal")

			if not var_29_2 then
				var_29_2 = createMedal()

				var_29_2:setPositionX(self:getChildByName("Image_task"):getPositionX() + 5)
				var_29_2:setPositionY(self:getChildByName("Image_task"):getPositionY() - 5)
				self:addChild(var_29_2)
			end

			local var_29_3 = item_data[tonumber(self.taskinfo.medal_id)]

			var_29_2:setVisible(true)
			var_29_2:setString(var_29_3.name)
			var_29_2:enableOutline(medal_colors[var_29_3.equip_quality], 1)
			var_29_2:enableShadow(medal_colors[var_29_3.equip_quality], cc.size(0, 0))

			if item_data[itemid].bg then
				-- block empty
			end
		elseif self:getChildByName("medal") then
			self:getChildByName("medal"):removeFromParent()
		end

		if self:getChildByName("item_sp") then
			self:getChildByName("item_sp"):removeFromParent()
		end

		local var_29_6 = drop_manager:getDropMsg(self.taskinfo.drop)

		if not next(var_29_6.equips) and var_29_6.diamond > 0 then
			var_29_6.equips[1] = {
				dropid = "diamond"
			}
		end

		local var_29_7 = ItemPurchaseSprite:createPurchaseItem(var_29_6.equips[1].dropid)
		local var_29_8 = self:getChildByName("Image_task")

		var_29_7:setName("item_sp")
		var_29_7:setScale(0.5)
		var_29_7:setPosition(cc.p(var_29_8:getPositionX(), var_29_8:getPositionY()))
		self:addChild(var_29_7)
		var_29_7:setTouchEnabled(true)
		var_29_7:addTouchEventListener(function(arg_30_0, arg_30_1)
			if arg_30_1 ~= ccui.TouchEventType.ended then
				return
			end

			showItemDetails(var_29_6.equips[1].dropid)
		end)
		self:getChildByName("name"):setString(self.taskinfo.name)
		self:getChildByName("des"):setString(self.taskinfo.des)
		self:getChildByName("button_done"):setVisible(false)
		self:getChildByName("Image_task"):setVisible(false)
		self:getChildByName("ProgressBar"):setVisible(true)
		self:getChildByName("bar_bg"):setVisible(true)

		if self.taskinfo.isLock then
			self:getChildByName("button_gray"):setVisible(false)
			self:getChildByName("button_goto_" .. self.index):setVisible(false)
			self:getChildByName("button_getAwards"):setVisible(false)
			self:getChildByName("ProgressBar"):setPercent(self.taskinfo.percent)
			self:getChildByName("ProgressBar"):getChildByName("Label_percent"):setString(self.taskinfo.percent .. "%")

			if self.taskinfo.percent and self.taskinfo.percent == 100 then
				self:getChildByName("button_gray"):setVisible(true)
			else
				self:getChildByName("button_goto_" .. self.index):setVisible(true)
			end
		elseif self.taskinfo.percent and self.taskinfo.percent < 100 then
			self:getChildByName("button_goto_" .. self.index):setVisible(true)
			self:getChildByName("button_gray"):setVisible(false)
			self:getChildByName("ProgressBar"):setPercent(self.taskinfo.percent)
			self:getChildByName("ProgressBar"):getChildByName("Label_percent"):setString(self.taskinfo.percent .. "%")
			self:getChildByName("button_getAwards"):setVisible(false)
		else
			self:getChildByName("button_gray"):setVisible(false)
			self:getChildByName("button_goto_" .. self.index):setVisible(false)
			self:getChildByName("button_getAwards"):setVisible(true)
			self:getChildByName("ProgressBar"):setPercent(self.taskinfo.percent)
			self:getChildByName("ProgressBar"):getChildByName("Label_percent"):setString(self.taskinfo.percent .. "%")
			self:getChildByName("button_getAwards"):addTouchEventListener(function(arg_31_0, arg_31_1)
				if arg_31_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_31_0:isBright() then
					return
				end

				if global_button_lock then
					return
				end

				arg_31_0:setBright(false)

				global_button_lock = true

				self:confirmAwards(var_29_0.taskid, arg_31_0)
			end)
		end

		self:getChildByName("button_goto_" .. self.index):addTouchEventListener(function(arg_32_0, arg_32_1)
			if arg_32_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_29_0 = arg_32_0:getParent().taskinfo

			print(dump(var_29_0))
			print("taskinfo.jump = ", var_29_0.jump)

			if var_29_0.jump == 130 then
				LayerManager:pushInLayer("SignLayerNew", {
					callback = function()
						if topPlotListInstance then
							self:useMidasAfterUpdate()
						end

						self:getActivityTaskByStage()
					end
				})
			elseif var_29_0.jump == 111 then
				require("controller.sign_manager"):createMidasLayer(function()
					if topPlotListInstance then
						self:useMidasAfterUpdate()
					end

					self:getActivityTaskByStage()
				end)
			elseif var_29_0.jump == 220 then
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
						if topPlotListInstance then
							self:useMidasAfterUpdate()
						end

						self:getActivityTaskByStage()
					end
				})
			elseif var_29_0.jump then
				require("controller.goto_system_manager")

				local var_32_0 = {
					jump_to_system = var_29_0.jump
				}

				var_32_0.config = system_jump_config[SYSTEMID[var_29_0.jump]] and system_jump_config[SYSTEMID[var_29_0.jump]].config

				if var_32_0.config then
					if var_32_0.config.exitCallbackType == "function" then
						var_32_0.config.exitCallback = nil
					elseif var_32_0.config.exitCallbackType == "string" then
						var_32_0.config = "MainLayer"
					end
				end

				goto_complete_system(var_32_0)
			end
		end)
		self:updateAwardList(self.taskinfo.drop)
	end

	function var_25_0:updateAwardList(arg_38_1)
		local var_38_0 = self:getChildByName("Label_name")
		local var_38_1 = drop_manager:getDropMsg(arg_38_1)

		if var_38_1.equips[1] and var_38_1.equips[1].dropid then
			var_38_0:setString(item_data[var_38_1.equips[1].dropid].name .. ((var_38_1.equips[1].dropNum > 1 or nil) and "x" .. var_38_1.equips[1].dropNum))
			var_38_0:setScaleX(var_38_0:getContentSize().width > 106 and 106 / var_38_0:getContentSize().width or 1)
		end
	end

	var_25_0:updateTaskInfo(arg_25_1)

	return var_25_0
end

function ActivityNoviceTaskLayer:updateShowingCells()
	local var_39_0, var_39_1 = GetTableViewShowCellIdx(self.taskView, {
		maxcount = math.ceil(#self.taskList),
		cellsize = cc.size(640, var_0_11)
	})

	for iter_39_0 = var_39_0, var_39_1 do
		self.taskView:updateCellAtIndex(iter_39_0)
	end
end

function ActivityNoviceTaskLayer.fullScreen(arg_40_0)
	return
end

function ActivityNoviceTaskLayer.checkTaskIsLock(arg_41_0, arg_41_1)
	local var_41_0 = var_0_14()[arg_41_1.index].stage

	if var_41_0 == 7 then
		return false
	end

	local var_41_1 = time_check_manager:getCurTime()
	local var_41_2 = os.date("*t", playermodel.create_time)
	local var_41_3 = os.time({
		hour = 0,
		min = 0,
		sec = 1,
		year = var_41_2.year,
		month = var_41_2.month,
		day = var_41_2.day
	})

	if var_41_0 < 7 then
		return var_41_1 < var_41_3 + 86400 * (var_41_0 - 2)
	else
		return var_41_1 < var_41_3 + 86400 * (var_41_0 - 3)
	end
end

function ActivityNoviceTaskLayer.getActivityTaskByStage(arg_42_0)
	local var_42_0 = var_0_14()
	local var_42_1 = activity_manager:getActivityObj(2)

	if var_42_1 then
		var_42_1:getActivityTaskList(nil, function(arg_43_0, arg_43_1)
			if arg_43_0 ~= 1 then
				return
			end

			activity_manager:update_alert(2, "task", arg_43_1.list)

			for iter_43_0, iter_43_1 in pairs(arg_43_1.list) do
				if iter_43_1.taskid == arg_42_0.rewardid then
					break
				end

				arg_43_1.list[iter_43_0].des = task_data[iter_43_1.taskid].task_des
				arg_43_1.list[iter_43_0].img = task_data[iter_43_1.taskid].image
				arg_43_1.list[iter_43_0].drop = task_data[iter_43_1.taskid].drop
				arg_43_1.list[iter_43_0].order = task_data[iter_43_1.taskid].order
				arg_43_1.list[iter_43_0].name = task_data[iter_43_1.taskid].name
				arg_43_1.list[iter_43_0].jump = task_data[iter_43_1.taskid].jump
				arg_43_1.list[iter_43_0].isLock = arg_42_0:checkTaskIsLock(task_data[iter_43_1.taskid])
			end

			local function var_43_0(arg_44_0)
				for iter_44_0, iter_44_1 in pairs(var_42_0) do
					if iter_44_1.taskid == arg_44_0 then
						return iter_44_0
					end
				end
			end

			arg_42_0.reddotlist = {}

			for iter_43_2, iter_43_3 in pairs(arg_43_1.list) do
				if iter_43_3.taskid == arg_42_0.rewardid then
					break
				end

				if iter_43_3.finished == 2 then
					arg_42_0.reddotlist[var_42_0[var_43_0(iter_43_3.taskid)].stage] = true
				end
			end

			local function var_43_1(arg_45_0, arg_45_1)
				if not arg_45_0.percent then
					return false
				end

				if not arg_45_1.percent then
					return true
				end

				if arg_45_0.percent == arg_45_1.percent then
					return arg_45_0.order < arg_45_1.order
				else
					return arg_45_0.percent > arg_45_1.percent
				end
			end

			arg_42_0.completeTask = 0
			arg_42_0.needCount = 0
			arg_42_0.isComplete = false
			arg_42_0.taskList = {}

			for iter_43_4, iter_43_5 in pairs(arg_43_1.list) do
				if var_0_13[arg_42_0.curClassType] == var_42_0[var_43_0(iter_43_5.taskid)].stage and iter_43_5.taskid ~= arg_42_0.rewardid then
					table.insert(arg_42_0.taskList, iter_43_5)
				end

				if iter_43_5.taskid == arg_42_0.rewardid then
					if iter_43_5.finished then
						arg_42_0.completeTask = iter_43_5.finished or task_data[arg_42_0.rewardid].needs_num
					end

					if iter_43_5.need then
						arg_42_0.needCount = iter_43_5.need or arg_42_0.completeTask
					end

					if iter_43_5.status == 1 then
						arg_42_0.isComplete = true
					end
				end
			end

			table.sort(arg_42_0.taskList, var_43_1)
			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE)
		end, false)
	end
end

function ActivityNoviceTaskLayer.confirmAwards(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = activity_manager:getActivityObj(2)

	if var_46_0 then
		var_46_0:getTaskReward(arg_46_1, function(arg_47_0, arg_47_1)
			arg_46_2:setBright(true)

			global_button_lock = nil

			if arg_47_0 ~= 1 then
				return
			end

			global_gain(arg_47_1)
			arg_46_0:getActivityTaskByStage()
			arg_46_0:getActivityTaskListBecauseOfAlert()
		end)
	end
end

local function var_0_17(arg_48_0)
	return var_0_14()[require("data.task_data")[arg_48_0].index].stage
end

local function var_0_18(arg_49_0)
	if arg_49_0 == 7 then
		return false
	end

	local var_49_0 = time_check_manager:getCurTime()
	local var_49_1 = os.date("*t", playermodel.create_time)
	local var_49_2 = os.time({
		hour = 0,
		min = 0,
		sec = 1,
		year = var_49_1.year,
		month = var_49_1.month,
		day = var_49_1.day
	})

	if arg_49_0 < 7 then
		return var_49_0 < var_49_2 + 86400 * (arg_49_0 - 2)
	else
		return var_49_0 < var_49_2 + 86400 * (arg_49_0 - 3)
	end
end

function ActivityNoviceTaskLayer:getActivityTaskListBecauseOfAlert()
	for iter_50_0, iter_50_1 in pairs(self.btnsByStage) do
		if iter_50_1:getChildByName("reddot123") then
			iter_50_1:getChildByName("reddot123"):setVisible(false)
		end
	end

	local var_50_0 = activity_manager:getActivityObj(2)

	if var_50_0 then
		var_50_0:getActivityTaskList(nil, function(arg_51_0, arg_51_1)
			for iter_51_0, iter_51_1 in pairs(arg_51_1.list) do
				if iter_51_1.taskid == self.rewardid then
					break
				end

				local var_51_0 = var_0_17(iter_51_1.taskid)

				if not var_0_18(var_51_0) and iter_51_1.status == 0 and iter_51_1.percent >= 100 and self.btnsByStage[var_51_0] then
					if not self.btnsByStage[var_51_0]:getChildByName("reddot123") then
						local var_51_1 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_8)

						var_51_1:setPosition(cc.p(46, 70))
						var_51_1:setName("reddot123")
						self.btnsByStage[var_51_0]:addChild(var_51_1)
					end

					self.btnsByStage[var_51_0]:getChildByName("reddot123"):setVisible(true)
				end
			end
		end, false)
	end
end

function ActivityNoviceTaskLayer:updateTaskBtnAlert()
	if not var_0_18(var_0_13[self.curClassType]) and self.taskList[1].status == 0 and self.taskList[1].percent >= 100 then
		global_add_alert_tag(self.classBnts[self.curClassType], {
			x = 62,
			y = 180
		})
	else
		global_remove_alert_tag(self.classBnts[self.curClassType])
	end
end

function ActivityNoviceTaskLayer.dealWithSpInfo(arg_53_0, arg_53_1)
	local var_53_0 = activity_manager:getActivityObj(2)

	if var_53_0 then
		local var_53_1 = false

		var_53_0:getActivityTaskList(nil, function(arg_54_0, arg_54_1)
			for iter_54_0, iter_54_1 in pairs(arg_54_1.list) do
				if task_data[iter_54_1.taskid] and task_data[iter_54_1.taskid].display_type == 7 then
					var_53_1 = true

					break
				end
			end

			arg_53_0._startIndex = var_53_1 == true and 1 or 2

			if arg_53_1 then
				arg_53_1()
			end
		end, false)
	elseif arg_53_1 then
		arg_53_1()
	end
end
