SupermarketTotalRechargeSprite = class("SupermarketTotalRechargeSprite", function(...)
	return cc.Layer:create()
end)

local activity_manager = require("controller.activity_manager")
local supermarket_manager = require("controller.supermarket_manager")
local drop_manager = require("controller.drop_manager")
local task_data = require("data.task_data")
local item_data = require("data.item_data")
local activity_conf_data = require("data.activity_conf_data")
local activity_task_conf = require("data.activity_modules.activity_task_conf")
local var_0_7 = config._DEBUG and 0 or 1

function SupermarketTotalRechargeSprite.create(arg_2_0, arg_2_1)
	local var_2_0 = SupermarketTotalRechargeSprite.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function SupermarketTotalRechargeSprite:init(arg_3_1)
	self.activityid = arg_3_1.activityid
	self.instance = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and ("SupermarketTotalRecharge_" .. self.activityid .. ".json" or "SupermarketTotalRecharge_" .. self.activityid .. ".ExportJson"))

	self.rootLayer:setContentSize(cc.size(self.rootLayer:getContentSize().width, 950 + GameDisplay.fix_y * 2))
	self.rootLayer:setTouchEnabled(true)
	self:addChild(self.rootLayer, 1)
	assert(activity_task_conf[self.activityid], "activity_task_conf id is nil:" .. self.activityid)

	self.usemodule = activity_task_conf[self.activityid].module1

	assert(self.usemodule, "activity_task_conf[" .. self.activityid .. "].module1 is nil")
	self:initUI()
	self:updateData(function(...)
		self:updateUI()
		self:scrollTableView()
	end)
end

function SupermarketTotalRechargeSprite:initUI(...)
	self.cloneCell = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cell")

	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_title"):setPositionY(self.rootLayer:getContentSize().height - ccui.Helper:seekWidgetByName(self.rootLayer, "Image_title"):getContentSize().height / 2)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_des"):setString(activity_task_conf[self.activityid].proceed_des1 or "谁来填下activity_conf_data[" .. self.activityid .. "].proceed_des1")
end

function SupermarketTotalRechargeSprite:updateData(arg_6_1)
	activity_manager:getActivityTaskList(self.activityid, nil, function(arg_8_0, arg_8_1)
		if #arg_8_1.list == 0 then
			hx_print("服务器拖了吗")
		end

		self.tasklist = arg_8_1.list
		self.statvalue = arg_8_1.statvalue
		self.score = arg_8_1.statvalue or -1

		table.sort(self.tasklist, function(arg_9_0, arg_9_1)
			return task_data[arg_9_0.taskid].order < task_data[arg_9_1.taskid].order
		end)

		if self.score == -1 then
			global_ShowBlockWords("任务索引表里没找到use_module为" .. self.usemodule .. "的任务", cc.c3b(255, 0, 0), nil, 9999, nil, 22)
		end

		self:updateAlert()

		if arg_6_1 then
			arg_6_1()
		end
	end, false, (function(arg_7_0)
		if string.find(arg_7_0, "total_recharge") then
			return "total_recharge"
		elseif string.find(arg_7_0, "total_twist") then
			for iter_7_0, iter_7_1 in pairs((self:getActivityTaskIndexData())) do
				if iter_7_1.usemodule == self.usemodule and task_data[iter_7_1.taskid].needs_type == E_TWIST_COUNT_ACTIVITY then
					return "twist_count_activity" .. task_data[iter_7_1.taskid].needs_target
				end
			end
		elseif string.find(arg_7_0, "total_consume_diamond") then
			return "cost_diamond"
		elseif string.find(arg_7_0, "consume_giftcard") then
			return "use_giftcard"
		end

		return arg_7_0
	end)(self.usemodule), self.usemodule)
end

function SupermarketTotalRechargeSprite:updateAlert()
	activity_manager:update_alert(self.activityid, self.usemodule, self.tasklist)
	supermarket_manager:updateTotalRechargeReddot()
end

function SupermarketTotalRechargeSprite:createTableview(...)
	self.tableView = cc.TableView:create(cc.size(640, self.rootLayer:getContentSize().height - ccui.Helper:seekWidgetByName(self.rootLayer, "Image_title"):getContentSize().height))

	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableView:setPosition(cc.p(0, 0))
	self.tableView:setDelegate()
	self.rootLayer:addChild(self.tableView)
	self.tableView:registerScriptHandler(function(arg_13_0, arg_13_1)
		local var_13_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cell"):getContentSize()

		return var_13_0.width, var_13_0.height
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:registerScriptHandler(function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_0:dequeueCell() or cc.TableViewCell:create()

		if not var_12_0:getChildByName("sp") then
			local var_12_1 = self:createSp()

			var_12_1:setName("sp")
			var_12_1:setAnchorPoint(cc.p(0, 0))
			var_12_1:setPosition(cc.p(0, 0))
			var_12_0:addChild(var_12_1)
		end

		var_12_0:getChildByName("sp"):update(arg_12_1 + 1)

		return var_12_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:registerScriptHandler(function(arg_14_0, arg_14_1)
		return #self.tasklist
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:reloadData()
end

function SupermarketTotalRechargeSprite:createSp(...)
	local var_15_0 = self.cloneCell:clone()

	var_15_0:setVisible(true)

	while ccui.Helper:seekWidgetByName(var_15_0, "Panel_item" .. 1) do
		local var_15_1 = ccui.Helper:seekWidgetByName(var_15_0, "Panel_item" .. 1)
		local var_15_2 = ItemSpriteActivityRecharge:createSignItem()

		var_15_2:setName("sp")
		var_15_2:setPositionX(var_15_1:getContentSize().width / 2)
		var_15_2:setPositionY(var_15_1:getContentSize().height / 2)
		var_15_1:addChild(var_15_2)
		var_15_2:setInfoTouchEvent(true)
		var_15_2:setSwallowTouches(false)
	end

	ccui.Helper:seekWidgetByName(var_15_0, "Button_award"):setSwallowTouches(false)
	ccui.Helper:seekWidgetByName(var_15_0, "Button_award"):addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_16_0:isBright() then
			return
		end

		if math.abs(arg_16_0:getTouchBeganPosition().y - arg_16_0:getTouchEndPosition().y) > 50 then
			return
		end

		arg_16_0:setBright(false)
		self:getAward(arg_16_0.id, function(...)
			arg_16_0:setBright(true)
		end)
	end)

	function var_15_0:update(arg_18_1)
		local var_18_9000

		ccui.Helper:seekWidgetByName(var_15_0, "Button_cell"):loadTextures(self:getPath("cell_bg"), self:getPath("cell_bg"), self:getPath("cell_bg"), var_0_7)

		self.id = arg_18_1
		ccui.Helper:seekWidgetByName(var_15_0, "Button_award").id = arg_18_1

		local var_18_0 = self.tasklist[arg_18_1]
		local var_18_1 = self.tasklist[arg_18_1].taskid
		local var_18_3 = self.tasklist[arg_18_1].status
		local var_18_4 = drop_manager:getDropMsg(task_data[self.tasklist[arg_18_1].taskid].drop)

		table.sort(var_18_4.equips, function(arg_19_0, arg_19_1)
			return arg_19_0._index < arg_19_1._index
		end)

		local var_18_5 = {}

		if var_18_4.diamond > 0 then
			table.insert(var_18_5, {
				itemid = "diamond",
				num = var_18_4.diamond,
				name = L_DIAMOND
			})
		end

		if var_18_4.gold > 0 then
			table.insert(var_18_5, {
				itemid = "gold",
				num = var_18_4.gold,
				name = L_GOLD
			})
		end

		local var_18_6 = {}

		for iter_18_0, iter_18_1 in pairs(var_18_4.equips) do
			table.insert(var_18_6, {
				itemid = iter_18_1.dropid,
				num = iter_18_1.dropNum,
				name = item_data[iter_18_1.dropid].name,
				item_attr = iter_18_1.item_attr
			})
		end

		for iter_18_2, iter_18_3 in pairs(var_18_6) do
			table.insert(var_18_5, iter_18_3)
		end

		while ccui.Helper:seekWidgetByName(self, "Panel_item" .. 1) do
			ccui.Helper:seekWidgetByName(self, "Panel_item" .. 1):setVisible(false)

			if var_18_5[1] then
				ccui.Helper:seekWidgetByName(self, "Panel_item" .. 1):setVisible(true)
				ccui.Helper:seekWidgetByName(self, "Panel_item" .. 1):getChildByName("sp"):updateSignItemByItemid(var_18_5[1].itemid, var_18_5[1].num, nil, nil, nil, "public/box/box_activity_recharge_", var_18_5[1].item_attr)
			end
		end

		local var_18_8
		local var_18_9

		if self.activityid >= 151 then
			var_18_8 = task_data[self.tasklist[arg_18_1].taskid].name
			var_18_9 = task_data[self.tasklist[arg_18_1].taskid].task_des
		else
			var_18_8 = string.match(task_data[self.tasklist[arg_18_1].taskid].name, "%d+")
			var_18_9 = string.match(task_data[self.tasklist[arg_18_1].taskid].name, "%D+")
		end

		ccui.Helper:seekWidgetByName(self, "Button_award"):loadTextures(self:getPath("get_award"), self:getPath("get_award"), self:getPath("get_award"), var_0_7)
		self:getChildByName("Label_score"):setString(var_18_8)
		self:getChildByName("Label_scoredes"):setString(var_18_9)

		local var_18_10 = self:getChildByName("Label_score")
		local var_18_11 = var_18_10:getContentSize().width + var_18_9000
		local var_18_12 = ccui.Helper:seekWidgetByName(self.cloneCell, "Label_score")

		self:getChildByName("Label_score").setPositionX(self:getChildByName("Label_scoredes").getContentSize(var_18_10).width, var_18_12:getPositionX() - self:getChildByName("Label_scoredes").getContentSize(var_18_12).width / 2)

		local var_18_13 = ccui.Helper:seekWidgetByName(self.cloneCell, "Label_score")

		self:getChildByName("Label_scoredes"):setPositionX(var_18_13:getPositionX() + self:getChildByName("Label_score").getContentSize(var_18_13).width / 2)
		ccui.Helper:seekWidgetByName(self, "Image_condition"):loadTexture(self:getPath("condition_off"), var_0_7)
		ccui.Helper:seekWidgetByName(self, "Image_cell_mask"):setVisible(false)

		if var_18_0 and var_18_0.percent and var_18_0.percent < 100 then
			ccui.Helper:seekWidgetByName(self, "Button_award"):loadTextures(self:getPath("get_late"), self:getPath("get_late"), self:getPath("get_late"), var_0_7)
		end

		if var_18_0 and var_18_0.percent and var_18_0.percent == 100 then
			ccui.Helper:seekWidgetByName(self, "Button_award"):loadTextures(self:getPath("get_award"), self:getPath("get_award"), self:getPath("get_award"), var_0_7)
			ccui.Helper:seekWidgetByName(self, "Image_condition"):loadTexture(self:getPath("condition_on"), var_0_7)
		end

		if var_18_3 == 1 then
			ccui.Helper:seekWidgetByName(self, "Button_award"):loadTextures(self:getPath("got_btn"), self:getPath("got_btn"), self:getPath("got_btn"), var_0_7)
			ccui.Helper:seekWidgetByName(self, "Image_cell_mask"):setVisible(true)
			ccui.Helper:seekWidgetByName(self, "Image_condition"):loadTexture(self:getPath("condition_on"), var_0_7)
		end

		;(function(...)
			ccui.Helper:seekWidgetByName(self, "Image_progress_bg"):setPositionY(self:getContentSize().height / 2)

			if self.id == 1 then
				ccui.Helper:seekWidgetByName(self, "Image_progress_bg"):setPositionY(self:getContentSize().height / 2)
			elseif self.id == #self.tasklist then
				ccui.Helper:seekWidgetByName(self, "Image_progress_bg"):setPositionY(self:getContentSize().height)
			end

			if self.tasklist[arg_18_1 - 1] then
				local var_20_1 = self.tasklist[arg_18_1 - 1].taskid or nil
				local var_20_2

				if self.tasklist[arg_18_1 + 1] then
					var_20_2 = self.tasklist[arg_18_1 + 1].taskid or nil

					local var_20_3

					if task_data[var_20_1] then
						var_20_3 = task_data[var_20_1].needs_num or nil
					end
				end
			end

			local var_20_4 = task_data[var_18_1].needs_num
			local var_20_5

			if task_data[var_20_2] then
				var_20_5 = task_data[var_20_2].needs_num or nil
			end

			local var_20_6 = var_20_4
			local var_20_7 = var_20_4

			var_20_6 = var_20_3 and (var_20_3 + var_20_4) / 2 or 0

			if var_20_5 then
				var_20_7 = (var_20_5 + var_20_4) / 2
			end

			local var_20_8 = 0

			var_20_8 = var_20_7 <= self.score and var_20_7 == var_20_4 and 0 or var_20_4 > self.score and (1 - (self.score - var_20_6) / (var_20_4 - var_20_6)) / 2 + 0.5 + 1 or 1 - (self.score - var_20_4) / (var_20_7 - var_20_4) / 2 - 0.5 + 1

			ccui.Helper:seekWidgetByName(self, "Image_progress"):setScaleY(1)

			if var_20_8 < 1 then
				if self.id == #self.tasklist then
					ccui.Helper:seekWidgetByName(self, "Image_progress"):setPositionY(1.5 * self:getContentSize().height)
				else
					ccui.Helper:seekWidgetByName(self, "Image_progress"):setPositionY(1 * self:getContentSize().height)
				end
			else
				ccui.Helper:seekWidgetByName(self, "Image_progress"):setPositionY(var_20_8 * self:getContentSize().height)
			end
		end)()
	end

	return var_15_0
end

function SupermarketTotalRechargeSprite:getPath(arg_21_1)
	return "SupermarketTotalRecharge_" .. self.activityid .. "/" .. arg_21_1 .. ".png"
end

function SupermarketTotalRechargeSprite:updateShowingCells(...)
	if not self.tableView then
		self:createTableview()
	end

	local var_22_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cell"):getContentSize()

	var_22_0.height = var_22_0.height

	local var_22_1, var_22_2 = GetTableViewShowCellIdx(self.tableView, {
		cellsize = var_22_0,
		maxcount = #self.tasklist
	})

	for iter_22_0 = var_22_1, var_22_2 do
		self.tableView:updateCellAtIndex(iter_22_0)
	end
end

function SupermarketTotalRechargeSprite:updateUI(...)
	self:updateShowingCells()
end

function SupermarketTotalRechargeSprite:scrollTableView()
	local var_24_0 = 1

	for iter_24_0, iter_24_1 in pairs(self.tasklist) do
		if iter_24_1.status == 0 and iter_24_1.percent == 100 then
			var_24_0 = iter_24_0

			break
		end
	end

	for iter_24_2, iter_24_3 in pairs(self.tasklist) do
		if iter_24_3.status == 0 then
			var_24_0 = var_24_0 ~= 1 and var_24_0 or iter_24_2

			break
		end
	end

	if not self.tableView then
		return
	end

	self.tableView:scrollToPercent(var_24_0 / #self.tasklist * 100, nil, false)
end

function SupermarketTotalRechargeSprite:getAward(arg_25_1, arg_25_2)
	if self.tasklist[arg_25_1].status == 1 then
		global_ShowBlockWords("已领取")

		if arg_25_2 then
			arg_25_2()
		end

		return
	end

	activity_manager:getTaskReward(self.activityid, self.tasklist[arg_25_1].taskid, function(arg_26_0, arg_26_1)
		if arg_26_0 == 1 then
			global_gain(arg_26_1)
			self:updateData(function(...)
				self:updateUI()

				if arg_25_2 then
					arg_25_2()
				end
			end)
		elseif arg_26_0 == 3 then
			goto_complete_system({
				jump_to_system = task_data[self.tasklist[arg_25_1].taskid].jump
			})

			if arg_25_2 then
				arg_25_2()
			end
		end
	end)
end

function SupermarketTotalRechargeSprite:getActivityTaskIndexData(...)
	if not activity_task_conf[self.activityid] then
		return require("data." .. activity_conf_data[self.activityid].taskindexfile)
	else
		return require("data.activity_taskindex." .. activity_conf_data[self.activityid].taskindexfile)
	end
end

function SupermarketTotalRechargeSprite:updateBySupermarketLayer(...)
	self:updateData(function(...)
		self:updateUI()
		self:scrollTableView()
	end)
end
