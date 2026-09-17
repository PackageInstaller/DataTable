ActivityWakefundBaseLayer = class("ActivityWakefundBaseLayer", function()
	return ccui.Layout:create()
end)

local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local drop_manager = require("controller.drop_manager")
local L2Actor = require("view.Sprite.L2Actor")
local var_0_7 = 0
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local favorfile_data = require("data.favorfile_data")
local task_data = require("data.task_data")
local activity_flop_condition_conf_data = require("data.activity_modules.activity_flop_condition_conf_data")
local activity_wakefund_uiconfig_data = require("data.activity_template_ui_conf.activity_wakefund_uiconfig_data")
local activity_wake_fund_conf = require("data.activity_modules.activity_wake_fund_conf")

require("view.Sprite.ItemSprite")

local function var_0_15(arg_2_0, arg_2_1)
	local var_2_0 = {
		pos = function(self, arg_3_1)
			self:setPosition(arg_3_1)
		end,
		visible = function(self, arg_4_1)
			self:setVisible(arg_4_1)
		end,
		size = function(self, arg_5_1)
			self:setContentSize(arg_5_1)
		end,
		anchorpoint = function(self, arg_6_1)
			self:setAnchorPoint(arg_6_1)
		end,
		color = function(self, arg_7_1)
			self:setColor(arg_7_1)
		end,
		zorder = function(self, arg_8_1)
			self:setLocalZOrder(arg_8_1)
		end,
		scale = function(self, arg_9_1)
			self:setScale(arg_9_1)
		end
	}

	for iter_2_0, iter_2_1 in pairs(arg_2_1) do
		if var_2_0[iter_2_0] then
			var_2_0[iter_2_0](arg_2_0, iter_2_1)
		end
	end
end

function ActivityWakefundBaseLayer:createCell()
	local var_10_0 = self:get("useConf").cell_clone
	local var_10_1 = ccui.Layout:create()

	var_10_1:setTouchEnabled(false)
	var_10_1:setContentSize(var_10_0.size)
	var_10_1:setAnchorPoint(cc.p(0, 0))
	var_10_1:setPosition(var_10_0.pos)
	var_10_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_10_1:setVisible(false)
	var_10_1:setPosition(var_10_0.pos)

	for iter_10_0, iter_10_1 in pairs(var_10_0.child) do
		local var_10_2 = self:createNode(iter_10_0, iter_10_1)

		var_0_15(var_10_2, iter_10_1)
		var_10_1:addChild(var_10_2)
	end

	return var_10_1
end

function ActivityWakefundBaseLayer.createItemSprite(arg_11_0, arg_11_1)
	local var_11_0 = ccui.Layout:create()

	var_11_0:setTouchEnabled(false)
	var_11_0:setContentSize(cc.size(100, 100))
	var_11_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_11_0:setPosition(arg_11_1.pos)
	var_11_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_11_0:setPosition(arg_11_1.pos)

	return var_11_0
end

function ActivityWakefundBaseLayer.addItemSprite(arg_12_0, arg_12_1)
	local var_12_0 = ItemSmallSprite:createSmallItem()

	var_12_0:setAttr(FONT_NAME, 26)
	var_12_0:setInfoTouchEvent(true)
	var_12_0:setSwallowTouches(false)
	var_12_0:setName("itemsmallsprite")
	var_12_0:setPositionX(arg_12_1:getChildByName("itemsmallsprite_award"):getContentSize().width / 2)
	var_12_0:setPositionY(arg_12_1:getChildByName("itemsmallsprite_award"):getContentSize().height / 2)
	arg_12_1:getChildByName("itemsmallsprite_award"):addChild(var_12_0)

	arg_12_1:getChildByName("itemsmallsprite_award").updateitemsprite = function(self, arg_13_1, arg_13_2)
		self:getChildByName("itemsmallsprite"):updateSmallItemByItemid(arg_13_1, arg_13_2)
	end

	local var_12_1 = ItemSmallSprite:createSmallItem()

	var_12_1:setInfoTouchEvent(true)
	var_12_1:setSwallowTouches(false)
	var_12_1:setName("itemsmallsprite")
	var_12_1:setPositionX(arg_12_1:getChildByName("itemsmallsprite_ext_award"):getContentSize().width / 2)
	var_12_1:setPositionY(arg_12_1:getChildByName("itemsmallsprite_ext_award"):getContentSize().height / 2)
	arg_12_1:getChildByName("itemsmallsprite_ext_award"):addChild(var_12_1)

	arg_12_1:getChildByName("itemsmallsprite_ext_award").updateitemsprite = function(self, arg_14_1, arg_14_2)
		self:getChildByName("itemsmallsprite"):updateSmallItemByItemid(arg_14_1, arg_14_2)
	end

	return arg_12_1
end

function ActivityWakefundBaseLayer:createTableviewSp(...)
	local var_15_0 = self:createCell()

	self:addItemSprite(var_15_0)
	var_15_0:getChildByName("btn_bg"):setSwallowTouches(false)
	var_15_0:setVisible(true)
	var_15_0:getChildByName("btn_gain"):addTouchEventListener(self:getTouchHandel("btn_gain"))
	var_15_0:getChildByName("btn_gain"):setSwallowTouches(false)

	function var_15_0:update(arg_16_1)
		local var_16_0 = self:get("useConf")
		local var_16_1 = self:get("tasklist")[arg_16_1]

		self.taskid = var_16_1.taskid
		var_15_0:getChildByName("btn_gain").taskid = var_16_1.taskid

		self:getChildByName("text_name1"):setString((string.sub(task_data[self.taskid].name, 1, string.find(task_data[self.taskid].name, "[0-9]") - 1)))
		self:getChildByName("text_name2"):setString((string.sub(task_data[self.taskid].name, string.find(task_data[self.taskid].name, "[0-9]"), #task_data[self.taskid].name)))

		local var_16_2 = drop_manager:getDropMsg(task_data[self.taskid].drop)
		local var_16_3
		local var_16_4

		if var_16_2.diamond > 0 then
			var_16_3 = "diamond"
			var_16_4 = var_16_2.diamond
		end

		if var_16_2.gold > 0 then
			var_16_3 = "gold"
			var_16_4 = var_16_2.gold
		end

		if next(var_16_2.equips) then
			var_16_3 = var_16_2.equips[1].dropid
			var_16_4 = var_16_2.equips[1].dropNum
		end

		if task_data[self.taskid].free_extra_drop then
			if task_data[self.taskid].free_extra_drop and var_16_1.free_extra_award == 0 and (var_16_1.status == 1 or var_16_1.status == 2) then
				local var_16_5 = drop_manager:getDropMsg(task_data[self.taskid].free_extra_drop)

				if var_16_5.diamond > 0 then
					var_16_4 = var_16_5.diamond
				end

				if var_16_5.gold > 0 then
					var_16_4 = var_16_5.gold
				end

				if next(var_16_5.equips) then
					var_16_4 = var_16_5.equips[1].dropNum
				end
			else
				local var_16_6 = drop_manager:getDropMsg(task_data[self.taskid].free_extra_drop)

				if var_16_6.diamond > 0 then
					var_16_4 = var_16_4 + var_16_6.diamond
				end

				if var_16_6.gold > 0 then
					var_16_4 = var_16_4 + var_16_6.gold
				end

				if next(var_16_6.equips) then
					var_16_4 = var_16_4 + var_16_6.equips[1].dropNum
				end
			end
		end

		self:getChildByName("itemsmallsprite_award"):updateitemsprite(var_16_3, var_16_4)

		if task_data[self.taskid].extra_drop then
			local var_16_7 = drop_manager:getDropMsg(task_data[self.taskid].extra_drop)
			local var_16_8
			local var_16_9

			if var_16_7.diamond > 0 then
				var_16_8 = "diamond"
				var_16_9 = var_16_7.diamond
			end

			if var_16_7.gold > 0 then
				var_16_8 = "gold"
				var_16_9 = var_16_7.gold
			end

			if next(var_16_7.equips) then
				var_16_8 = var_16_7.equips[1].dropid
				var_16_9 = var_16_7.equips[1].dropNum
			end

			self:getChildByName("itemsmallsprite_ext_award"):setVisible(true)
			self:getChildByName("itemsmallsprite_ext_award"):updateitemsprite(var_16_8, var_16_9)
		else
			self:getChildByName("itemsmallsprite_ext_award"):setVisible(false)
		end

		self:getChildByName("img_all_mask"):setVisible(false)
		self:getChildByName("img_extra_mask"):setVisible(false)

		local var_16_10

		if var_16_1.status == 1 or var_16_1.status == 2 then
			var_16_10 = self:getPath(var_16_0.cell_clone.child.btn_gain.path_got)

			self:getChildByName("img_normal_mask"):setVisible(true)

			if task_data[self.taskid].extra_drop then
				if task_data[self.taskid].free_extra_drop then
					if var_16_1.extra_award == 1 and var_16_1.free_extra_award == 1 then
						self:getChildByName("img_normal_mask"):setVisible(false)
						self:getChildByName("img_extra_mask"):setVisible(false)
						self:getChildByName("img_all_mask"):setVisible(true)

						var_16_10 = self:getPath(var_16_0.cell_clone.child.btn_gain.path_got)
					elseif var_16_1.extra_award == 1 and var_16_1.free_extra_award == 0 then
						self:getChildByName("img_normal_mask"):setVisible(false)
						self:getChildByName("img_extra_mask"):setVisible(true)
						self:getChildByName("img_all_mask"):setVisible(false)

						var_16_10 = self:getPath(var_16_0.cell_clone.child.btn_gain.path_free)
					elseif var_16_1.extra_award == 0 and var_16_1.free_extra_award == 1 then
						self:getChildByName("img_normal_mask"):setVisible(true)
						self:getChildByName("img_extra_mask"):setVisible(false)
						self:getChildByName("img_all_mask"):setVisible(false)

						var_16_10 = self:getPath(var_16_0.cell_clone.child.btn_gain.path_vip)
					elseif var_16_1.extra_award == 0 and var_16_1.free_extra_award == 0 then
						self:getChildByName("img_normal_mask"):setVisible(false)
						self:getChildByName("img_extra_mask"):setVisible(false)
						self:getChildByName("img_all_mask"):setVisible(false)

						var_16_10 = self:getPath(var_16_0.cell_clone.child.btn_gain.path_free)
					end

					if self:get("isvip") then
						self:getChildByName("img_lock"):setVisible(false)
					else
						self:getChildByName("img_lock"):setVisible(true)
					end
				elseif var_16_1.extra_award == 0 then
					if self:get("isvip") then
						var_16_10 = self:getPath(var_16_0.cell_clone.child.btn_gain.path_vip)

						self:getChildByName("img_lock"):setVisible(false)
					else
						var_16_10 = self:getPath(var_16_0.cell_clone.child.btn_gain.path_vip)

						self:getChildByName("img_lock"):setVisible(true)
					end
				else
					self:getChildByName("img_normal_mask"):setVisible(false)
					self:getChildByName("img_lock"):setVisible(false)
					self:getChildByName("img_all_mask"):setVisible(true)
				end
			else
				self:getChildByName("img_normal_mask"):setVisible(false)
				self:getChildByName("img_all_mask"):setVisible(true)
			end
		elseif var_16_1.status == 0 and var_16_1.percent == 100 then
			self:getChildByName("img_normal_mask"):setVisible(false)

			var_16_10 = self:getPath(var_16_0.cell_clone.child.btn_gain.path)

			if task_data[self.taskid].extra_drop and var_16_1.extra_award == 0 then
				if self:get("isvip") then
					self:getChildByName("img_lock"):setVisible(false)
				else
					self:getChildByName("img_lock"):setVisible(true)
				end
			end
		else
			self:getChildByName("img_normal_mask"):setVisible(false)

			var_16_10 = self:getPath(var_16_0.cell_clone.child.btn_gain.path_off)

			if task_data[self.taskid].extra_drop and var_16_1.extra_award == 0 then
				if self:get("isvip") then
					self:getChildByName("img_lock"):setVisible(false)
				else
					self:getChildByName("img_lock"):setVisible(true)
				end
			end
		end

		self:getChildByName("btn_gain"):loadTextures(var_16_10, var_16_10, var_16_10, var_0_7)

		if not self:get("isvip") then
			self:getChildByName("img_lock"):setVisible(true)
		end

		if not task_data[self.taskid].extra_drop then
			self:getChildByName("img_lock"):setVisible(false)
		end
	end

	return var_15_0
end

function ActivityWakefundBaseLayer.createTableView(arg_17_0, arg_17_1)
	local var_17_0 = ccui.Layout:create()

	var_17_0:setTouchEnabled(true)

	var_17_0._setContentSize = var_17_0.setContentSize

	function var_17_0:setContentSize(arg_18_1)
		self:_setContentSize(arg_18_1)
		self:getChildByName("tableview"):setContentSize(arg_18_1)
	end

	var_17_0._setPosition = var_17_0.setPosition

	function var_17_0:setPosition(arg_19_1)
		self:_setPosition(arg_19_1)
		self:getChildByName("tableview"):setPosition(arg_19_1)
	end

	function var_17_0:reloadData()
		self:getChildByName("tableview"):reloadData()
	end

	function var_17_0:scrollToPercent(arg_21_1, arg_21_2, arg_21_3)
		self:getChildByName("tableview"):scrollToPercent(arg_21_1, arg_21_2, arg_21_3)
	end

	function var_17_0:updateShowingCells()
		local var_22_0 = arg_17_0:get("useConf", useConf)
		local var_22_1 = {}

		var_22_1.maxcount = arg_17_0:get("tasklist") and #arg_17_0:get("tasklist") or 0
		var_22_1.cellsize = var_22_0.cell_clone.size

		local var_22_2, var_22_3 = GetTableViewShowCellIdx(self:getChildByName("tableview"), var_22_1)

		for iter_22_0 = var_22_2, var_22_3 do
			self:getChildByName("tableview"):updateCellAtIndex(iter_22_0)
		end
	end

	var_17_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)

	local var_17_1 = cc.TableView:create(arg_17_1.size)

	var_17_1:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_17_1:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_17_1:setPosition(arg_17_1.pos)
	var_17_1:setDelegate()
	var_17_1:setName("tableview")
	var_17_0:addChild(var_17_1)
	var_17_1:registerScriptHandler(function(arg_24_0, arg_24_1)
		local var_24_0 = arg_17_0:get("useConf").cell_clone.size

		return var_24_0.width, var_24_0.height
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_17_1:registerScriptHandler(function(arg_23_0, arg_23_1)
		local var_23_0 = arg_23_0:dequeueCell()

		if not var_23_0 then
			var_23_0 = cc.TableViewCell:create()

			var_23_0:setName("cell_" .. arg_23_1)
		end

		if not var_23_0:getChildByName("sp") then
			local var_23_1 = arg_17_0:createTableviewSp()

			var_23_1:setName("sp")
			var_23_0:addChild(var_23_1)
		end

		var_23_0:getChildByName("sp"):update(arg_23_1 + 1)

		return var_23_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_17_1:registerScriptHandler(function(arg_25_0, arg_25_1)
		return arg_17_0:get("tasklist") and #arg_17_0:get("tasklist") or 0
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)

	return var_17_0
end

function ActivityWakefundBaseLayer.createNode(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0

	for iter_26_0, iter_26_1 in pairs({
		img = function(...)
			return ccui.ImageView:create(arg_26_0:getPath(arg_26_2.path), var_0_7)
		end,
		text = function(...)
			return ccui.Text:create("nodename", arg_26_2.font or FONT_DES, arg_26_2.fontsize or 20)
		end,
		btn = function(...)
			return ccui.Button:create(arg_26_0:getPath(arg_26_2.path), arg_26_0:getPath(arg_26_2.path_on or arg_26_2.path), arg_26_0:getPath(arg_26_2.path), var_0_7)
		end,
		itemsmallsprite = function(...)
			return arg_26_0:createItemSprite(arg_26_2)
		end,
		tableview = function(...)
			return arg_26_0:createTableView(arg_26_2)
		end
	}) do
		if string.find(arg_26_1, iter_26_0) then
			var_26_0 = iter_26_1()
		end
	end

	if not var_26_0 then
		print(arg_26_1 .. "没有找对对应的预定义类型")

		var_26_0 = cc.Node:create()
	end

	var_26_0:setName(arg_26_1)

	return var_26_0
end

local var_0_16 = {
	[2] = {},
	[406] = {},
	[486] = {},
	[176] = {},
	[710] = {}
}

function ActivityWakefundBaseLayer.create(arg_32_0, arg_32_1)
	local var_32_0 = ActivityWakefundBaseLayer.new(arg_32_1)

	var_32_0:init(arg_32_1)

	return var_32_0
end

function ActivityWakefundBaseLayer:initUIConfData()
	self:set("id", self:get("initParam").activityid)
	self:set("templateuipath", "activitiesRes/activitytemplate/wake_fund/")
	self:set("activityuipath", "activitiesRes/activity" .. self:get("id") .. "/wake_fund/")
end

function ActivityWakefundBaseLayer:getPath(arg_34_1)
	local var_34_0

	if not var_0_16[self.id][arg_34_1] then
		var_34_0 = cc.FileUtils:getInstance():isFileExist(self:get("activityuipath") .. arg_34_1) and self:get("activityuipath") .. arg_34_1 or self:get("templateuipath") .. arg_34_1
		var_0_16[self.id][arg_34_1] = var_34_0
	else
		var_34_0 = var_0_16[self.id][arg_34_1]
	end

	return var_34_0
end

function ActivityWakefundBaseLayer:init(arg_35_1)
	self:set("initParam", arg_35_1)
	self:initUIConfData()
	self:initData()
	self:initUI()
	self:updateData(function(...)
		ccui.Helper:seekWidgetByName(self:get("rootLayer"), "tableview"):reloadData()
		self:updateUI()
		self:scrollTableView()
		cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("NOVICE_SUMMARY_UPDATE")))
	end)
	self:registerScriptHandler(function(arg_37_0)
		if arg_37_0 == "exit" then
			activity_manager:update_alert(self.id, "wake_fund", self:get("tasklist"))
			activity_manager:update_module_stat(self.id, "wake_fund", self:get("tasklist"))

			if arg_35_1.exitcallback then
				arg_35_1.exitcallback()
			end
		end
	end)
	self:test()
end

function ActivityWakefundBaseLayer:initData()
	self:set("isvip", item_manager:getItemNumber(activity_wake_fund_conf[self:get("id")].extra_drop_vip) > 0)
end

function ActivityWakefundBaseLayer:updateData(arg_39_1)
	print(self:get("id"))
	activity_manager:getActivityTaskList(self:get("id"), nil, function(arg_40_0, arg_40_1)
		if tolua.isnull(self) then
			return
		end

		self:set("tasklist", arg_40_1.list)
		self:sortTasklist()
		self:set("isvip", item_manager:getItemNumber(activity_wake_fund_conf[self:get("id")].extra_drop_vip) > 0)

		if arg_39_1 then
			arg_39_1()
		end

		activity_manager:update_alert(self.id, "wake_fund", self:get("tasklist"))
		activity_manager:update_module_stat(self.id, "wake_fund", self:get("tasklist"))
	end, false, nil, "wake_fund")
end

function ActivityWakefundBaseLayer:sortTasklist(...)
	table.sort(self:get("tasklist"), function(arg_42_0, arg_42_1)
		return arg_42_0.taskid < arg_42_1.taskid
	end)
end

function ActivityWakefundBaseLayer:initUI(...)
	self:set("rootLayer", ccui.Layout:create())
	self:get("rootLayer"):setTouchEnabled(true)
	self:get("rootLayer"):setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self:get("rootLayer"):setAnchorPoint(cc.p(0, 0))
	self:get("rootLayer"):setPosition(cc.p(0, 0))
	self:get("rootLayer"):setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self:get("rootLayer"), -1)
	self:addUI()
	self:registerTouchEvent()
	self:updateBuyVipBtn()
end

function ActivityWakefundBaseLayer:updateUI(...)
	ccui.Helper:seekWidgetByName(self:get("rootLayer"), "tableview"):updateShowingCells()
	self:updateBuyVipBtn()
end

function ActivityWakefundBaseLayer:updateBuyVipBtn()
	local var_45_0 = self:get("useConf")

	if not self:get("isvip") then
		local var_45_1 = self:getPath(var_45_0.btn_buy_vip.path)

		ccui.Helper:seekWidgetByName(self:get("rootLayer"), "btn_buy_vip"):loadTextures(var_45_1, var_45_1, var_45_1, var_0_7)
	else
		local var_45_2 = self:getPath(var_45_0.btn_buy_vip.path_off)

		ccui.Helper:seekWidgetByName(self:get("rootLayer"), "btn_buy_vip"):loadTextures(var_45_2, var_45_2, var_45_2, var_0_7)
	end
end

function ActivityWakefundBaseLayer:addUI(...)
	local var_46_0 = {}

	;(function(...)
		local var_47_0 = activity_wakefund_uiconfig_data[self:get("id")]

		for iter_47_0, iter_47_1 in pairs(activity_wakefund_uiconfig_data.template) do
			var_46_0 = var_46_0 or {}

			for iter_47_2, iter_47_3 in pairs(iter_47_1) do
				var_46_0[iter_47_0] = var_46_0[iter_47_0] or {}
				var_46_0[iter_47_0][iter_47_2] = var_47_0 and var_47_0[iter_47_0] and var_47_0[iter_47_0][iter_47_2] ~= nil and var_47_0[iter_47_0][iter_47_2] or iter_47_3
			end
		end

		self:set("useConf", var_46_0)
	end)()

	for iter_46_0, iter_46_1 in pairs(var_46_0) do
		if iter_46_0 ~= "cell_clone" then
			local var_46_1 = self:createNode(iter_46_0, iter_46_1)

			if var_46_1 then
				var_0_15(var_46_1, iter_46_1)
				self:set(iter_46_0, var_46_1)
				self:get("rootLayer"):addChild(self:get(iter_46_0))
			else
				print("not find register create function:", iter_46_0)
			end
		end
	end
end

function ActivityWakefundBaseLayer:set(arg_48_1, arg_48_2)
	if type(arg_48_2) == "table" or not self[arg_48_1] then
		self[arg_48_1] = arg_48_2
	else
		print("ActivityWakefundBaseLayer:set(k, v) BUG!", arg_48_1, arg_48_2)
	end
end

function ActivityWakefundBaseLayer:get(arg_49_1)
	return self[arg_49_1]
end

function ActivityWakefundBaseLayer:registerTouchEvent()
	for iter_50_0, iter_50_1 in pairs((self:get("useConf", useConf))) do
		local var_50_0 = self:getTouchHandel(iter_50_0)

		if var_50_0 then
			ccui.Helper:seekWidgetByName(self:get("rootLayer"), iter_50_0):addTouchEventListener(var_50_0)
		end
	end
end

function ActivityWakefundBaseLayer.getTouchHandel(arg_51_0, arg_51_1)
	if not string.find(arg_51_1, "btn") then
		return
	end

	local var_51_0 = {
		btn_return = function(arg_52_0, arg_52_1)
			if arg_52_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:removePopLayer()
		end,
		btn_buy_vip = function(arg_53_0, arg_53_1)
			if arg_53_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("ActivityWakefundVipBuyPopLayer", {
				id = arg_51_0:get("id"),
				tasklist = arg_51_0:get("tasklist"),
				updatecallback = function(...)
					arg_51_0:updateData(function(...)
						arg_51_0:updateUI()
					end)
				end
			})
		end,
		btn_big_gift = function(arg_56_0, arg_56_1)
			if arg_56_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("ActivityWakefundVipBuyPopLayer", {
				id = arg_51_0:get("id"),
				tasklist = arg_51_0:get("tasklist"),
				updatecallback = function(...)
					arg_51_0:updateData(function(...)
						arg_51_0:updateUI()
					end)
				end
			})
		end,
		btn_all_gain = function(arg_59_0, arg_59_1)
			if arg_59_1 ~= ccui.TouchEventType.ended then
				return
			end

			arg_51_0:gainAllAward(arg_59_0, arg_59_1)
		end,
		btn_gain = function(self, arg_60_1)
			if arg_60_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(self:getTouchBeganPosition().y - self:getTouchEndPosition().y) > 50 then
				return
			end

			arg_51_0:gainAward(self, arg_60_1)
		end,
		null = function(arg_61_0, arg_61_1)
			if arg_61_1 ~= ccui.TouchEventType.ended then
				return
			end

			print("该组件未注册有效点击事件")
		end
	}

	return var_51_0[arg_51_1] or var_51_0.null
end

function ActivityWakefundBaseLayer:gainAward(arg_62_1, arg_62_2)
	for iter_62_0, iter_62_1 in pairs((self:get("tasklist"))) do
		if iter_62_1.taskid == arg_62_1.taskid then
			if iter_62_1.status == 1 or iter_62_1.status == 2 then
				if task_data[iter_62_1.taskid].extra_drop and iter_62_1.extra_award == 0 then
					break
				end

				if task_data[iter_62_1.taskid].free_extra_drop and iter_62_1.free_extra_award == 0 then
					break
				end

				global_ShowBlockWords("已领取")
			elseif iter_62_1.status == 0 and iter_62_1.percent < 100 then
				local var_62_0 = {
					jump_to_system = task_data[arg_62_1.taskid].jump
				}

				require("controller.goto_system_manager")
				goto_complete_system(var_62_0)

				return
			end
		end
	end

	activity_manager:getTaskReward(self:get("id"), arg_62_1.taskid, function(arg_63_0, arg_63_1)
		print("result", arg_63_0)

		if arg_63_0 == 1 then
			global_gain(arg_63_1)
			self:updateData(function(...)
				self:updateUI()
			end)
		elseif arg_63_0 == 3 then
			LayerManager:pushInLayer("ActivityWakefundVipBuyPopLayer", {
				id = self:get("id"),
				tasklist = self:get("tasklist"),
				updatecallback = function(...)
					self:updateData(function(...)
						self:updateUI()
					end)
				end
			})
		end
	end)
end

function ActivityWakefundBaseLayer:gainAllAward(arg_67_1, arg_67_2)
	local var_67_0 = false

	for iter_67_0, iter_67_1 in pairs((self:get("tasklist"))) do
		if iter_67_1.status == 0 and iter_67_1.percent == 100 then
			var_67_0 = true
		end

		if iter_67_1.status == 0 and iter_67_1.percent == 100 and task_data[iter_67_1.taskid].extra_drop and iter_67_1.extra_award == 0 and self:get("isvip") then
			var_67_0 = true
		end

		if (iter_67_1.status == 1 or iter_67_1.status == 2) and task_data[iter_67_1.taskid].extra_drop and iter_67_1.extra_award == 0 and self:get("isvip") then
			var_67_0 = true
		end

		if (iter_67_1.status == 1 or iter_67_1.status == 2) and task_data[iter_67_1.taskid].free_extra_drop and iter_67_1.free_extra_award == 0 then
			var_67_0 = true
		end
	end

	if not var_67_0 then
		global_ShowBlockWords("没有可领取奖励")

		return
	end

	activity_manager:getActivityTaskList(self:get("id"), nil, function(arg_68_0, arg_68_1)
		if arg_68_0 == 1 then
			global_gain(arg_68_1)
			self:updateData(function(...)
				self:updateUI()
			end)
		end
	end, true, nil, "wake_fund")
end

function ActivityWakefundBaseLayer:scrollTableView()
	local var_70_0 = 1

	for iter_70_0, iter_70_1 in pairs(self:get("tasklist")) do
		if iter_70_1.status == 0 then
			var_70_0 = iter_70_0

			break
		end

		if (iter_70_1.status == 1 or iter_70_1.status == 2) and task_data[iter_70_1.taskid].extra_drop and iter_70_1.extra_award == 0 then
			var_70_0 = iter_70_0

			break
		end

		if (iter_70_1.status == 1 or iter_70_1.status == 2) and task_data[iter_70_1.taskid].free_extra_drop and iter_70_1.free_extra_award == 0 then
			var_70_0 = iter_70_0

			break
		end
	end

	self:get("tableview"):scrollToPercent(var_70_0 / #self:get("tasklist") * 100, nil, false)
end

function ActivityWakefundBaseLayer:test()
	if not activity_wakefund_uiconfig_data.debug or not config._DEBUG then
		return
	end

	local var_71_0 = ccui.Button:create("GUI/button.png", "GUI/button.png", "GUI/button.png", var_0_7)

	var_71_0:addTouchEventListener(function(arg_72_0, arg_72_1)
		if arg_72_1 ~= ccui.TouchEventType.ended then
			return
		end

		local function var_72_0(arg_73_0)
			require(arg_73_0)

			if not package.loaded[arg_73_0] then
				print(" fuck ! can't find mod!")
			end

			arg_73_0 = string.gsub(arg_73_0, "%.", "/")

			print("data", arg_73_0)

			for iter_73_0, iter_73_1 in pairs(package.loaded[arg_73_0]) do
				package.loaded[arg_73_0][iter_73_0] = nil
			end

			for iter_73_2, iter_73_3 in pairs((loadstring((io.open("./src/" .. arg_73_0 .. ".lua"):read("*a")))())) do
				package.loaded[arg_73_0][iter_73_2] = iter_73_3
			end

			return ret
		end

		var_72_0("data.activity_template_ui_conf.activity_wakefund_uiconfig_data")
		var_72_0("view.Layer.ActivityNew.BaseLayer.ActivityWakefundBaseLayer")
		var_72_0("view.Layer.ActivityNew.BaseLayer.ActivityWakefundVipBuyPopLayer")

		local var_72_1 = {}

		;(function(...)
			local var_74_0 = activity_wakefund_uiconfig_data[self:get("id")]

			for iter_74_0, iter_74_1 in pairs(activity_wakefund_uiconfig_data.template) do
				var_72_1 = var_72_1 or {}

				for iter_74_2, iter_74_3 in pairs(iter_74_1) do
					var_72_1[iter_74_0] = var_72_1[iter_74_0] or {}
					var_72_1[iter_74_0][iter_74_2] = var_74_0 and var_74_0[iter_74_0] and var_74_0[iter_74_0][iter_74_2] and var_74_0[iter_74_0][iter_74_2] or iter_74_3
				end
			end

			self:set("useConf", var_72_1)
		end)()

		for iter_72_0, iter_72_1 in pairs(var_72_1) do
			local var_72_2 = ccui.Helper:seekWidgetByName(self:get("rootLayer"), iter_72_0)

			if var_72_2 then
				var_0_15(var_72_2, iter_72_1)
			end
		end

		ccui.Helper:seekWidgetByName(self:get("rootLayer"), "tableview"):reloadData()
	end)
	var_71_0:setPosition(cc.p(320, 568))
	self:addChild(var_71_0, 1000)
	activity_manager:getActivityTaskList(self:get("id"), nil, function(arg_75_0, arg_75_1)
		self:set("tasklist", arg_75_1.list)
		self:sortTasklist()

		if callback then
			callback()
		end
	end, false, nil, "wake_fund")
end

return ActivityWakefundBaseLayer
