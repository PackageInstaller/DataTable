ActivityRechargeTemplate = class("ActivityRechargeTemplate", function()
	return cc.Layer:create()
end)

local activity_manager = require("controller.activity_manager")
local drop_manager = require("controller.drop_manager")
local item_manager = require("controller.item_manager")
local activity_conf_data = require("data.activity_conf_data")
local activity_task_conf = require("data.activity_modules.activity_task_conf")
local task_data = require("data.task_data")
local item_data = require("data.item_data")
local var_0_7 = config._DEBUG and 0 or 1
local time_check_manager = require("controller.time_check_manager")
local var_0_9
local activity_recharge_uiconfig_data = require("data.activity_template_ui_conf.activity_recharge_uiconfig_data")

require("view.Layer.Activity.ActivityRechargeByJson")

local var_0_11 = {
	total_recharge = "condition_recharge_on",
	total_twist = "condition_twist_on"
}

setmetatable(var_0_11, {
	__index = function(arg_2_0, arg_2_1)
		return "condition_" .. arg_2_1 .. "_on"
	end
})

local var_0_12 = {
	total_recharge = "condition_recharge_off",
	total_twist = "condition_twist_off"
}

setmetatable(var_0_12, {
	__index = function(arg_3_0, arg_3_1)
		return "condition_" .. arg_3_1 .. "_off"
	end
})

local var_0_13 = {
	total_recharge = L_ACTIVITY_TOTAL_RECHARGE,
	total_twist = L_ACTIVITY_TOTAL_TWIST,
	reset_recharge_1 = L_ACTIVITY_TOTAL_RECHARGE
}

setmetatable(var_0_13, {
	__index = function(arg_4_0, arg_4_1)
		if arg_4_1:find("total_recharge") then
			return L_ACTIVITY_TOTAL_RECHARGE
		elseif arg_4_1:find("total_twist") then
			return L_ACTIVITY_TOTAL_TWIST
		elseif arg_4_1:find("consume_diamond") then
			return L_ACTIVITY_TOTAL_CONSUME_DIAMOND
		elseif arg_4_1:find("recharge_count") then
			return "累計チャージ日数"
		elseif arg_4_1:find("have_skin") then
			return L_ACTIVITY_TOTAL_HAVE_SKIN
		elseif arg_4_1:find("consume_giftcard") then
			return L_ACTIVITY_TOTAL_CONSUME_GIFTCARD
		elseif arg_4_1:find("nmsl") then
			return L_ACTIVITY_TOTAL_OPEN_BAG
		elseif arg_4_1:find("reset_recharge") then
			return L_ACTIVITY_TOTAL_RECHARGE
		end

		return ""
	end
})

local var_0_14 = {
	total_twist = "sure_btn_total_twist",
	reset_recharge = "sure_btn_reset_recharge",
	total_recharge = "sure_btn_total_recharge"
}

setmetatable(var_0_14, {
	__index = function(arg_5_0, arg_5_1)
		if arg_5_1:find("twist") then
			return "sure_btn_total_twist"
		end

		if arg_5_1:find("total_recharge") then
			return "sure_btn_total_recharge"
		end

		return "sure_btn_" .. arg_5_1
	end
})

local var_0_15 = {
	total_twist = "bg_total_twist",
	reset_recharge = "bg_reset_recharge",
	total_recharge = "bg_total_recharge"
}

setmetatable(var_0_15, {
	__index = function(arg_6_0, arg_6_1)
		return "bg_" .. arg_6_1
	end
})

local function var_0_16(arg_7_0)
	local var_7_0 = ({})[arg_7_0] or "Activity_recharge_template"

	return (config._DEBUG or nil) and (var_7_0 .. ".json" or var_7_0 .. ".ExportJson")
end

local var_0_17 = {}

function ActivityRechargeTemplate:getPath(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0
	local var_8_1 = self.activityPath .. arg_8_1 .. ((arg_8_2 or nil) and ("_" .. arg_8_2 or "")) .. ".png"

	var_0_17[self.activityid] = var_0_17[self.activityid] or {}

	if not var_0_17[self.activityid][var_8_1] then
		if cc.FileUtils:getInstance():isFileExist(var_8_1) then
			var_8_0 = var_8_1
		else
			if arg_8_3 then
				if arg_8_2 then
					if cc.FileUtils:getInstance():isFileExist(self.activityPath .. arg_8_3 .. ("_" .. arg_8_2 or "") .. ".png") then
						var_8_0 = self.activityPath .. arg_8_3 .. ((arg_8_2 or nil) and ("_" .. arg_8_2 or "")) .. ".png"

						goto label_8_0
					end
				end
			end

			var_8_0 = self.activityPath .. arg_8_1 .. ".png"
		end

		::label_8_0::

		var_0_17[self.activityid][var_8_1] = var_8_0
	else
		var_8_0 = var_0_17[self.activityid][var_8_1]
	end

	return var_8_0
end

local function var_0_18(arg_9_0)
	local var_9_5 = global_get_time_by_date(arg_9_0) - time_check_manager:getCurTime()
	local var_9_6 = math.floor(var_9_5 / 24 / 3600)
	local var_9_7 = math.floor((var_9_5 - var_9_6 * 24 * 3600) / 3600)
	local var_9_8 = math.floor((var_9_5 - var_9_6 * 24 * 3600 - var_9_7 * 3600) / 60)

	return 0 ~= 0 and string.format(L_TIME_TEXT[1], var_9_6, var_9_7) or var_9_7 ~= 0 and string.format(L_TIME_TEXT[2], var_9_7, var_9_8) or string.format(L_TIME_TEXT[3], var_9_8)
end

function ActivityRechargeTemplate:getUiPositionConf(arg_10_1)
	local var_10_0

	if activity_recharge_uiconfig_data[self.activityid] then
		var_10_0 = activity_recharge_uiconfig_data[self.activityid][arg_10_1] or activity_recharge_uiconfig_data.template[arg_10_1]
	else
		activity_recharge_uiconfig_data = require("data.activity_template_ui_conf.totaltask.activity_recharge_uiconfig_data_" .. self.activityid)
		var_10_0 = activity_recharge_uiconfig_data[arg_10_1]
	end

	assert(var_10_0, "data.activity_recharge_uiconfig_data not find " .. "activityid:" .. self.activityid .. " nodename:" .. arg_10_1)

	return var_10_0
end

function ActivityRechargeTemplate:getConfValue(arg_11_1, arg_11_2)
	if arg_11_2 and activity_recharge_uiconfig_data[self.activityid] and activity_recharge_uiconfig_data[self.activityid][arg_11_1 .. "_" .. arg_11_2] then
		return activity_recharge_uiconfig_data[self.activityid][arg_11_1 .. "_" .. arg_11_2]
	elseif activity_recharge_uiconfig_data[self.activityid] and activity_recharge_uiconfig_data[self.activityid][arg_11_1] then
		return activity_recharge_uiconfig_data[self.activityid][arg_11_1]
	elseif activity_recharge_uiconfig_data[arg_11_1] or activity_recharge_uiconfig_data[arg_11_1 .. "_" .. (arg_11_2 or "")] then
		return activity_recharge_uiconfig_data[arg_11_1] or activity_recharge_uiconfig_data[arg_11_1 .. "_" .. (arg_11_2 or "")]
	end
end

function ActivityRechargeTemplate.create(arg_12_0, arg_12_1)
	if arg_12_1.activityID >= 767 then
		local var_12_0 = ActivityRechargeByJson.new()

		var_12_0:init(arg_12_1)

		return var_12_0
	end

	local var_12_1 = ActivityRechargeTemplate.new()

	var_12_1:init(arg_12_1)

	return var_12_1
end

function ActivityRechargeTemplate:init(arg_13_1)
	var_0_9 = self
	self.activityid = arg_13_1.activityID
	self.activityPath = activity_task_conf[self.activityid] and "activitiesRes/activity" .. self.activityid .. "/activitytask/" or "mainScenebg/activity/recharge/" .. self.activityid .. "/"

	if not activity_recharge_uiconfig_data[self.activityid] then
		activity_recharge_uiconfig_data = require("data.activity_template_ui_conf.totaltask.activity_recharge_uiconfig_data_" .. self.activityid)
	end

	self.templatePath = "mainScenebg/activity/recharge/128/"
	self.showmodule = arg_13_1.showmodule

	;(function(...)
		if not activity_task_conf[self.activityid] then
			self.modulegroupconf = global_deepCopy(self:getConfValue("module_group"))
		else
			self.modulegroupconf = {}

			local var_14_0 = 1

			while activity_task_conf[self.activityid]["module" .. var_14_0] do
				table.insert(self.modulegroupconf, {
					key = activity_task_conf[self.activityid]["module" .. var_14_0],
					previewitemid = activity_task_conf[self.activityid]["previewitemid" .. var_14_0]
				})

				var_14_0 = var_14_0 + 1
			end
		end

		self:devmode_bugfix()

		if activity_recharge_uiconfig_data[self.activityid] then
			self.usemodule = activity_recharge_uiconfig_data[self.activityid].default_usemodule or self.modulegroupconf[1].key
		end
	end)()

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((var_0_16(self.activityid)))
	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg")

	self.rootpanel:setTouchEnabled(true)
	self:addChild(self.rootLayer, 1)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_mask"):addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 0), cc.CallFunc:create(function()
			LayerManager:removePopLayer()
		end)))
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_mask"):setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_mask"):setPositionY(-GameDisplay.fix_y)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg"):setScaleY(0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1.1), cc.ScaleTo:create(0.1, 1, 1)))
	self:registerScriptHandler(function(arg_17_0)
		if arg_17_0 == "exit" then
			if arg_13_1 and arg_13_1.exit_set_bright_callback then
				arg_13_1.exit_set_bright_callback()
			end

			self.activity = false
			var_0_9 = nil
		end
	end)
	self:devmode_bugfix()
	self:initUI()
	self:initData(function(...)
		self:updateUI()
		self:scrollTableView()
	end)
	self:registerRechargeEvent()
end

function ActivityRechargeTemplate:initData(arg_19_1)
	self.finishtime = activity_conf_data[self.activityid].finishtime
	self.des = activity_conf_data[self.activityid].proceed_des1
	self.tasklist = nil
	self.resttime = activity_manager:get_module_resettime(self.activityid, "reset_recharge")
	self.starttime = activity_manager:get_module_starttime(self.activityid, "reset_recharge_1")

	if self.resttime then
		self.stages = {}

		for iter_19_0 in string.gmatch(self.resttime, "[^,]+") do
			table.insert(self.stages, iter_19_0)
		end
	end

	if self.starttime then
		table.insert(self.stages, 1, self.starttime)
	end

	self:updateData(arg_19_1)
end

function ActivityRechargeTemplate:scrollTableView()
	local var_20_0 = 1

	for iter_20_0, iter_20_1 in pairs(self.tasklist) do
		if iter_20_1.status == 0 and iter_20_1.percent == 100 then
			var_20_0 = iter_20_0

			break
		end
	end

	for iter_20_2, iter_20_3 in pairs(self.tasklist) do
		if iter_20_3.status == 0 then
			var_20_0 = var_20_0 ~= 1 and var_20_0 or iter_20_2

			break
		end
	end

	if not self.tableView then
		return
	end

	self.tableView:scrollToPercent(var_20_0 / #self.tasklist * 100, nil, false)
end

function ActivityRechargeTemplate:updateData(arg_21_1)
	activity_manager:getActivityTaskList(self.activityid, nil, function(arg_23_0, arg_23_1)
		if tolua.isnull(self) then
			return
		end

		if #arg_23_1.list == 0 then
			hx_print("服务器拖了吗")
		end

		self.tasklist = arg_23_1.list
		self.statvalue = arg_23_1.statvalue
		self.score = arg_23_1.statvalue or -1

		table.sort(self.tasklist, function(arg_24_0, arg_24_1)
			return task_data[arg_24_0.taskid].order < task_data[arg_24_1.taskid].order
		end)

		if self.usemodule == "have_skin" then
			if not task_data[self.tasklist[1].taskid].need_target_string or not task_data[self.tasklist[1].taskid].need_target_string:find(",") then
				hx_print(string.format("taksid %d 没填 need_target_string, 应该为皮肤id组成的字符串使用【,】分隔", self.tasklist[1].taskid))

				return
			end

			local var_23_0 = {}

			for iter_23_0, iter_23_1 in pairs(task_data[self.tasklist[1].taskid].need_target_string:split(",")) do
				table.insert(var_23_0, tonumber(iter_23_1))
			end

			self.score = 0

			for iter_23_2, iter_23_3 in pairs(var_23_0) do
				if item_manager:getItemNumber(iter_23_3) > 0 then
					self.score = self.score + 1
				end
			end
		end

		self:updateAlert()

		if arg_21_1 then
			arg_21_1()
		end
	end, false, (function(arg_22_0)
		if string.find(arg_22_0, "total_recharge") then
			return "total_recharge"
		elseif string.find(arg_22_0, "reset_recharge") then
			return "total_recharge_can_reset"
		elseif string.find(arg_22_0, "total_twist") then
			for iter_22_0, iter_22_1 in pairs((self:getActivityTaskIndexData())) do
				if iter_22_1.usemodule == self.usemodule and (task_data[iter_22_1.taskid].needs_type == E_TWIST_COUNT_ACTIVITY or task_data[iter_22_1.taskid].needs_type == E_MONTHLY_TWIST_COUNT_ACTIVITY) then
					return "twist_count_activity" .. task_data[iter_22_1.taskid].needs_target
				end
			end
		elseif string.find(arg_22_0, "total_consume_diamond") then
			return "cost_diamond"
		elseif string.find(arg_22_0, "consume_giftcard") then
			return "use_giftcard"
		elseif string.find(arg_22_0, "nmsl") then
			return "open_activity_bag"
		end

		return arg_22_0
	end)(self.usemodule), self.usemodule)
end

function ActivityRechargeTemplate:updateAlert()
	activity_manager:update_alert(self.activityid, self.usemodule, self.tasklist)
end

function ActivityRechargeTemplate.getModuleBtnHandler(arg_26_0)
	return function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_26_0.usemodule = arg_27_0.key

		arg_26_0:updateData(function(...)
			arg_26_0.tableView:reloadData()
			arg_26_0:scrollTableView()
			arg_26_0:updateUI()
		end)
	end
end

function ActivityRechargeTemplate:initUI(...)
	if not activity_task_conf[self.activityid] then
		self.modulegroupconf = global_deepCopy(self:getConfValue("module_group"))
	else
		self.modulegroupconf = {}

		while activity_task_conf[self.activityid]["module" .. 1] do
			table.insert(self.modulegroupconf, {
				key = activity_task_conf[self.activityid]["module" .. 1],
				previewitemid = activity_task_conf[self.activityid]["previewitemid" .. 1]
			})
		end
	end

	local var_29_1 = {}

	for iter_29_0, iter_29_1 in pairs(self.showmodule or {}) do
		self.usemodule = self.showmodule[1]
	end

	;(function(...)
		if not self.modulegroupconf then
			return
		end

		local var_30_0 = {}

		for iter_30_0, iter_30_1 in pairs(self.modulegroupconf) do
			if var_29_1 and next(var_29_1) and not var_29_1[iter_30_1.key] then
				var_30_0[iter_30_1.key] = true
			end

			local var_30_1

			if iter_30_1.starttime then
				var_30_1 = iter_30_1.starttime
			elseif iter_30_1.key:find("twist") then
				for iter_30_2, iter_30_3 in pairs((require(string.format("data.activity_%d.%s", self.activityid, activity_conf_data[self.activityid].taskindexfile)))) do
					if iter_30_1.key == iter_30_3.usemodule then
						var_30_1 = require("data.twist_config_data")[task_data[iter_30_3.taskid].jump % 100000].starttime

						break
					end
				end
			end

			if var_30_1 and time_check_manager:getCurTime() < global_get_time_by_date(var_30_1) then
				print("与该任务模块相关的跳转未生效，在显示中移除%d任务分页", iter_30_1.key)

				var_30_0[iter_30_1.key] = true
			end
		end

		while self.modulegroupconf[1] do
			if #self.modulegroupconf == 1 then
				return
			end

			local var_30_2

			if var_30_0[self.modulegroupconf[1].key] then
				table.remove(self.modulegroupconf, 1)
			else
				var_30_2 = 1 + 1
			end
		end
	end)()

	if self.modulegroupconf and next(self.modulegroupconf) and #self.modulegroupconf > 1 then
		for iter_29_2, iter_29_3 in pairs(self.modulegroupconf) do
			local var_29_2 = ccui.Button:create(self:getPath("page_btn_" .. iter_29_3.key .. "_on"), nil, self:getPath("page_btn_" .. iter_29_3.key .. "_on"))

			var_29_2:setName("Button_module_group_" .. iter_29_2)

			var_29_2.key = iter_29_3.key
			var_29_2.alertkey = iter_29_3.key

			var_29_2:addTouchEventListener(self:getModuleBtnHandler())
			var_29_2:setPositionY(600)
			self.rootpanel:addChild(var_29_2)
		end
	end

	local var_29_3 = 1

	while self:getConfValue("Button_module_group_" .. var_29_3) do
		local var_29_4 = ccui.ImageView:create(self:getConfValue("Button_module_group_" .. var_29_3 .. "_reddot").path, var_0_7)

		var_29_4:setName("Button_module_group_" .. var_29_3 .. "_reddot")
		var_29_4:setVisible(false)
		self.rootpanel:addChild(var_29_4)
		var_29_4:setPositionY(600)

		var_29_3 = var_29_3 + 1
	end

	self:replaceUI()
	self:setUiPosition()
	self:runIntoAction()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):addTouchEventListener(function(arg_31_0, arg_31_1)
		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.usemodule == "have_skin" then
			self:pushSkinCollectLayer()
		else
			goto_complete_system({
				jump_to_system = task_data[self.tasklist[1].taskid].jump
			})
		end
	end)
	self:updateBaseUI()
end

function ActivityRechargeTemplate:replaceUI(...)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cell"):setVisible(false)

	self.cloneCell = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cell")

	local var_32_0 = self:getPath("ornament")

	if var_32_0 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_ornament"):loadTexture(var_32_0)
	end

	local var_32_1 = self:getPath("progress_bg")

	if var_32_1 and (not self.stages or not string.find(self.usemodule, "reset_recharge")) then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_progress_bg"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_progress_bg"):loadTexture(var_32_1)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_progress_bg"):setVisible(false)
	end

	local var_32_2 = self:getPath("progress")

	if var_32_2 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_progress"):loadTexture(var_32_2)
	end

	local var_32_3 = self:getPath("cell_mask")

	if var_32_3 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_cell_mask"):loadTexture(var_32_3)
	end

	self.cloneCell:getChildByName("Panel_item1"):setName("Panel_item1111")
	self.cloneCell:getChildByName("Panel_item2"):setName("Panel_item2222")
	self.cloneCell:getChildByName("Panel_item1111"):setVisible(false)
	self.cloneCell:getChildByName("Panel_item2222"):setVisible(false)

	local var_32_4 = ccui.ScrollView:create()

	var_32_4:setBounceEnabled(true)
	var_32_4:setInnerContainerSize(self:getConfValue("cellscrollview").containersize)
	var_32_4:setDirection(ccui.ScrollViewDir.horizontal)
	var_32_4:setName("cellscrollview")
	var_32_4:setTouchEnabled(false)
	self.cloneCell:addChild(var_32_4)

	if activity_recharge_uiconfig_data.debug then
		local var_32_5 = ccui.Layout:create()

		var_32_5:setContentSize(self:getConfValue("cellscrollview").containersize)
		var_32_5:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
		var_32_5:setBackGroundColor(cc.c3b(255, 0, 0))
		var_32_5:setBackGroundColorOpacity(180)
		var_32_4:addChild(var_32_5)
	end

	local var_32_6 = 1

	while var_32_6 <= 5 do
		local var_32_7 = ccui.Layout:create()

		var_32_7:setName("Panel_item" .. var_32_6)
		var_32_4:addChild(var_32_7)

		var_32_6 = var_32_6 + 1
	end

	local var_32_8 = ccui.ImageView:create(self:getPath("magnifier"))

	var_32_8:setName("Image_magnifier")
	self.rootpanel:addChild(var_32_8, 100)

	local var_32_9 = ccui.Layout:create()

	var_32_9:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_32_9:setName("item_touch_panel")
	var_32_9:setTouchEnabled(true)
	var_32_9:addTouchEventListener(function(arg_33_0, arg_33_1)
		if arg_33_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_33_0

		if self.modulegroupconf and next(self.modulegroupconf) then
			for iter_33_0, iter_33_1 in pairs(self.modulegroupconf) do
				if iter_33_1.key == self.usemodule then
					var_33_0 = iter_33_1.previewitemid
				end
			end

			if var_33_0 then
				LayerManager:pushInLayer("PopShowGilrPreviewLayer", {
					itemid = var_33_0
				})
			end
		end
	end)
	self.rootpanel:addChild(var_32_9, 100)

	local var_32_10 = self:getConfValue("Image_mark")

	if var_32_10 and var_32_10.visible then
		local var_32_11 = ccui.ImageView:create("GUI/image.png", var_0_7)

		var_32_11:setName("Image_mark")
		self.cloneCell:addChild(var_32_11)
	end

	local var_32_12 = self:getConfValue("Button_taskinfo")

	if var_32_12 and var_32_12.visible then
		local var_32_13 = ccui.Button:create("GUI/image.png", "GUI/image.png", "GUI/image.png", var_0_7)

		var_32_13:setAnchorPoint("Button_taskinfo")
		var_32_13:setName("Button_taskinfo")
		self.rootpanel:addChild(var_32_13)
		var_32_13:addTouchEventListener(function(arg_34_0, arg_34_1)
			if arg_34_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_34_0 = task_data[self.tasklist[1].taskid].need_target_string

			if not task_data[self.tasklist[1].taskid].need_target_string or not var_34_0:find(",") then
				hx_print(string.format("taksid %d 没填 need_target_string, 应该为皮肤id组成的字符串使用【,】分隔", self.tasklist[1].taskid))

				return
			end

			local var_34_1 = {}

			for iter_34_0, iter_34_1 in pairs(var_34_0:split(",")) do
				table.insert(var_34_1, tonumber(iter_34_1))
			end

			LayerManager:pushInLayer("SkinCollectLayer", {
				skinList = var_34_1
			})
		end)
	end
end

function ActivityRechargeTemplate:setUiPosition(...)
	for iter_35_0, iter_35_1 in pairs(activity_recharge_uiconfig_data.template or activity_recharge_uiconfig_data) do
		local var_35_1 = activity_recharge_uiconfig_data[self.activityid] and activity_recharge_uiconfig_data[self.activityid][iter_35_0] and activity_recharge_uiconfig_data[self.activityid][iter_35_0] or iter_35_1

		if var_35_1 and type(var_35_1) == "table" then
			for iter_35_2, iter_35_3 in pairs(var_35_1) do
				if ccui.Helper:seekWidgetByName(self.rootLayer, iter_35_0) then
					self:setUiPositionByNode(ccui.Helper:seekWidgetByName(self.rootLayer, iter_35_0), var_35_1)
				end
			end
		end
	end
end

function ActivityRechargeTemplate:setUiPositionByNode(arg_36_1, arg_36_2)
	if type(arg_36_2) ~= "table" then
		for iter_36_0, iter_36_1 in pairs(activity_recharge_uiconfig_data.template or activity_recharge_uiconfig_data) do
			if iter_36_0 == arg_36_2 then
				arg_36_2 = activity_recharge_uiconfig_data[self.activityid] and activity_recharge_uiconfig_data[self.activityid][iter_36_0] and activity_recharge_uiconfig_data[self.activityid][iter_36_0] or iter_36_1

				break
			end
		end
	end

	local var_36_2 = {
		pos = function(self, arg_37_1, arg_37_2)
			arg_37_1 = arg_37_2["pos_" .. self.usemodule] or arg_37_1

			self:setPosition(arg_37_1)
		end,
		visible = function(self, arg_38_1)
			self:setVisible(arg_38_1)
		end,
		size = function(self, arg_39_1)
			self:setContentSize(arg_39_1)
		end,
		anchorpoint = function(self, arg_40_1)
			self:setAnchorPoint(arg_40_1)
		end,
		color = function(self, arg_41_1)
			self:setColor(arg_41_1)
		end,
		font = function(self, arg_42_1)
			self:setFontName(arg_42_1)
		end,
		font_size = function(self, arg_43_1)
			self:setFontSize(arg_43_1)
		end
	}

	;(function(arg_44_0, arg_44_1)
		for iter_44_0, iter_44_1 in pairs(arg_44_1) do
			if var_36_2[iter_44_0] then
				var_36_2[iter_44_0](arg_44_0, iter_44_1, arg_44_1)
			end
		end
	end)(arg_36_1, arg_36_2)
end

function ActivityRechargeTemplate:updateTitle()
	if self.stages and string.find(self.usemodule, "reset_recharge") then
		local var_45_0 = ccui.ImageView:create(self.activityPath .. "title.png")

		self.rootpanel:addChild(var_45_0)

		self.title = var_45_0

		var_45_0:setPosition(410, 820)

		local var_45_1 = ccui.ImageView:create(self.activityPath .. "time_bg.png")

		self.rootpanel:addChild(var_45_1)

		self.time_bg = var_45_1

		var_45_1:setPosition(410, 710)

		if self.activityid == 755 then
			var_45_1:setPosition(410, 655)
		end

		local var_45_2 = 0
		local var_45_3 = ""

		for iter_45_0, iter_45_1 in pairs(self.stages) do
			if global_get_time_by_date(iter_45_1) < time_check_manager:getCurTime() and global_get_time_by_date(self.stages[iter_45_0 + 1]) > time_check_manager:getCurTime() then
				var_45_3 = var_0_18(self.stages[iter_45_0 + 1])
				var_45_2 = iter_45_0

				break
			end
		end

		local var_45_4 = cc.Label:createWithTTF(string.format(L_ACTRECHARGETP[1], var_45_2, #self.stages - 1), FONT_NAME, 22)

		var_45_1:addChild(var_45_4)
		var_45_4:setPosition(70, 20)

		local var_45_5 = cc.Label:createWithTTF(var_45_3 .. L_ACTRECHARGETP[2], FONT_NAME, 22)

		var_45_1:addChild(var_45_5)
		var_45_5:setPosition(250, 20)

		local var_45_6 = ccui.Button:create(self.activityPath .. "btn_close.png", nil, self.activityPath .. "btn_close.png")

		self.rootpanel:addChild(var_45_6)
		var_45_6:setPosition(600, 940)
		var_45_6:addTouchEventListener(function(arg_46_0, arg_46_1)
			if arg_46_1 ~= ccui.TouchEventType.ended then
				return
			end

			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 0), cc.CallFunc:create(function()
				LayerManager:removePopLayer()
			end)))
		end)

		if self.tableView then
			self.tableView:setPosition(-40, 15)
		end
	else
		if self.title then
			self.title:setVisible(false)
		end

		if self.time_bg then
			self.time_bg:setVisible(false)
		end

		if self.tableView then
			self.tableView:setPosition(0, 10)
		end
	end
end

function ActivityRechargeTemplate:updateBaseUI(...)
	if not self.stages or not string.find(self.usemodule, "reset_recharge") then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_time"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_time"):setString(L_TIME_REST2 .. L_TIME .. var_0_18(self.finishtime))
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_time"):setVisible(false)
	end

	local var_48_0 = 1

	if not activity_task_conf[self.activityid] then
		if activity_recharge_uiconfig_data[self.activityid] and activity_recharge_uiconfig_data[self.activityid].module_group then
			for iter_48_0, iter_48_1 in pairs(activity_recharge_uiconfig_data[self.activityid].module_group) do
				if self.usemodule == iter_48_1.key then
					var_48_0 = iter_48_0
				end
			end
		end
	else
		local var_48_1 = 1

		while activity_task_conf[self.activityid]["module" .. var_48_1] do
			if activity_task_conf[self.activityid]["module" .. var_48_1] == self.usemodule then
				var_48_0 = var_48_1
			end

			var_48_1 = var_48_1 + 1
		end
	end

	self.index = var_48_0

	local var_48_2 = self:getUiPositionConf("Label_des_" .. var_48_0)

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_des"):setFontSize(var_48_2.fontsize or 20)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_des"):setContentSize(var_48_2.size)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_des"):setPosition(var_48_2.pos)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_des"):setColor(var_48_2.color)

	local var_48_3 = self:getUiPositionConf("Label_desshadow_" .. var_48_0)

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_desshadow"):setFontSize(var_48_3.fontsize or 20)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_desshadow"):setContentSize(var_48_3.size)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_desshadow"):setPosition(var_48_3.pos)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_desshadow"):setColor(var_48_3.color)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_desshadow"):setVisible(var_48_3.visible and true or false)

	if not activity_task_conf[self.activityid] then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_des"):setString(activity_conf_data[self.activityid]["proceed_des" .. var_48_0])
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_desshadow"):setString(activity_conf_data[self.activityid]["proceed_des" .. var_48_0])

		if not activity_conf_data[self.activityid]["proceed_des" .. var_48_0] and config._DEBUG then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Label_des"):setString("谁来填下activity_conf_data[" .. self.activityid .. "].proceed_des" .. var_48_0)
			ccui.Helper:seekWidgetByName(self.rootLayer, "Label_desshadow"):setString("谁来填下activity_conf_data[" .. self.activityid .. "].proceed_des" .. var_48_0)
		end
	elseif not self.stages or not string.find(self.usemodule, "reset_recharge") then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_des"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_des"):setString(activity_task_conf[self.activityid]["des" .. var_48_0])
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_desshadow"):setString(activity_task_conf[self.activityid]["des" .. var_48_0])

		if not activity_task_conf[self.activityid]["des" .. var_48_0] and config._DEBUG then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Label_des"):setString("谁来填下activity_conf_data[" .. self.activityid .. "].des" .. var_48_0)
			ccui.Helper:seekWidgetByName(self.rootLayer, "Label_desshadow"):setString("谁来填下activity_conf_data[" .. self.activityid .. "].des" .. var_48_0)
		end
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_des"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_desshadow"):setVisible(false)
	end

	local var_48_4 = 1

	while ccui.Helper:seekWidgetByName(self.rootLayer, "Button_module_group_" .. var_48_4) do
		local var_48_5 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_module_group_" .. var_48_4)

		if var_48_5.key == self.usemodule then
			var_48_5:loadTextures(self:getPath("page_btn_" .. var_48_5.key .. "_on"), nil, self:getPath("page_btn_" .. var_48_5.key .. "_on"))
		else
			var_48_5:loadTextures(self:getPath("page_btn_" .. var_48_5.key .. "_off"), nil, self:getPath("page_btn_" .. var_48_5.key .. "_off"))
		end

		var_48_5:setPositionY(600)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_module_group_" .. var_48_4 .. "_reddot"):setPosition(var_48_5:getPositionX() + 55, 610)

		if activity_manager:getAlertStatus(self.activityid, var_48_5.alertkey) then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Button_module_group_" .. var_48_4 .. "_reddot"):setVisible(true)
		else
			ccui.Helper:seekWidgetByName(self.rootLayer, "Button_module_group_" .. var_48_4 .. "_reddot"):setVisible(false)
		end

		var_48_4 = var_48_4 + 1
	end

	local var_48_6 = self:getPath(var_0_14[self.usemodule])

	if var_48_6 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):loadTextures(var_48_6, var_48_6, var_48_6)
	end

	local var_48_7 = self:getPath(var_0_15[self.usemodule])

	if var_48_7 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg"):loadTexture(var_48_7)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_totalrecharge"):setString("")
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_magnifier"):setVisible(false)
	self:devmode_bugfix()

	for iter_48_2, iter_48_3 in pairs(self.modulegroupconf) do
		if iter_48_3.key == self.usemodule and iter_48_3.previewitemid then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_magnifier"):setVisible(true)
		end
	end
end

function ActivityRechargeTemplate:updateUI(...)
	if self.stages and string.find(self.usemodule, "reset_recharge") then
		self.orginSize = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cell"):getContentSize()

		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cell"):setContentSize(620, 125)
	elseif self.orginSize then
		-- block empty
	end

	self:updateTitle()
	self:updateBaseUI()
	self:updateShowingCells()

	if self:getConfValue("recharge_font") then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_totalrecharge"):setFontName(self:getConfValue("recharge_font"))
	end

	local var_49_0

	for iter_49_0, iter_49_1 in pairs(self.tasklist) do
		if not var_49_0 and iter_49_1.status == 0 then
			var_49_0 = iter_49_1.need
		end
	end

	if var_49_0 then
		if var_49_0 <= self.score then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Label_totalrecharge"):setString(L_ACTIVITY_TOTAL_AWARD)
		else
			ccui.Helper:seekWidgetByName(self.rootLayer, "Label_totalrecharge"):setString(string.format(var_0_13[self.usemodule], var_49_0 - self.score))
		end
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_totalrecharge"):setString("")
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):setVisible(self.usemodule ~= "pass_level")

	if ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure") then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_totalrecharge"):setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):getPositionY() - 50)
	end

	if self.usemodule == "have_skin" then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_taskinfo"):setVisible(true)

		local var_49_1 = self:getPath("task_info")

		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_taskinfo"):loadTextures(var_49_1, var_49_1, var_49_1)
	elseif ccui.Helper:seekWidgetByName(self.rootLayer, "Button_taskinfo") then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_taskinfo"):setVisible(false)
	end

	if activity_task_conf[self.activityid].button_hide and activity_task_conf[self.activityid].button_hide == LayerManager:getActiveLayerName() then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):setVisible(false)
	end
end

function ActivityRechargeTemplate:updateShowingCells(...)
	if not self.tableView then
		self:createTableview()
	end

	local var_50_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cell"):getContentSize()

	var_50_0.height = var_50_0.height

	local var_50_1, var_50_2 = GetTableViewShowCellIdx(self.tableView, {
		cellsize = var_50_0,
		maxcount = #self.tasklist
	})

	for iter_50_0 = var_50_1, var_50_2 do
		self.tableView:updateCellAtIndex(iter_50_0)
	end

	self.tableView:reloadData()
end

function ActivityRechargeTemplate:createTableview(...)
	local var_51_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_scrollarena"):getContentSize()

	var_51_0.width = 620
	self.tableView = cc.TableView:create(var_51_0)

	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableView:setPosition(cc.p(0, 10))
	self.tableView:setDelegate()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_scrollarena"):addChild(self.tableView)
	self.tableView:registerScriptHandler(function(arg_53_0, arg_53_1)
		return 620, ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cell"):getContentSize().height
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:registerScriptHandler(function(arg_52_0, arg_52_1)
		local var_52_0 = arg_52_0:dequeueCell() or cc.TableViewCell:create()

		if not var_52_0:getChildByName("sp") then
			local var_52_1 = self:createSp()

			var_52_1:setName("sp")
			var_52_1:setAnchorPoint(cc.p(0, 0))
			var_52_1:setPosition(cc.p(0, 0))

			if self.activityid == 573 then
				var_52_1:setPosition(cc.p(-50, 0))
			end

			var_52_0:addChild(var_52_1)
		end

		var_52_0:getChildByName("sp"):update(arg_52_1 + 1)

		return var_52_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:registerScriptHandler(function(arg_54_0, arg_54_1)
		return #self.tasklist
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:reloadData()

	local var_51_1 = ccui.Layout:create()

	var_51_1:setPosition(cc.p(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_scrollarena"):getPositionX(), (ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_scrollarena"):getPositionY())))
	var_51_1:setContentSize(cc.size(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_scrollarena"):getContentSize().width, 200))
	var_51_1:setAnchorPoint(cc.p(0, 1))
	var_51_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_51_1:setTouchEnabled(true)
	var_51_1:addTouchEventListener(function(arg_55_0, arg_55_1)
		if arg_55_1 ~= ccui.TouchEventType.ended then
			return
		end

		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 0), cc.CallFunc:create(function()
			LayerManager:removePopLayer()
		end)))
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_scrollarena"):getParent():addChild(var_51_1, ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_scrollarena"):getLocalZOrder() + 1)
end

function ActivityRechargeTemplate:createSp(...)
	local var_57_0 = self.cloneCell:clone()

	var_57_0:setVisible(true)

	while ccui.Helper:seekWidgetByName(var_57_0, "Panel_item" .. 1) do
		local var_57_1 = ccui.Helper:seekWidgetByName(var_57_0, "Panel_item" .. 1)
		local var_57_2 = ItemSpriteActivityRecharge:createSignItem()

		var_57_2:setName("sp")
		var_57_2:setPositionX(var_57_1:getContentSize().width / 2)
		var_57_2:setPositionY(var_57_1:getContentSize().height / 2)
		var_57_1:addChild(var_57_2)
		var_57_2:setInfoTouchEvent(true)
		var_57_2:setSwallowTouches(false)
	end

	ccui.Helper:seekWidgetByName(var_57_0, "Button_award"):setSwallowTouches(false)
	ccui.Helper:seekWidgetByName(var_57_0, "Button_award"):addTouchEventListener(function(arg_58_0, arg_58_1)
		if arg_58_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_58_0:isBright() then
			return
		end

		if math.abs(arg_58_0:getTouchBeganPosition().y - arg_58_0:getTouchEndPosition().y) > 50 then
			return
		end

		arg_58_0:setBright(false)
		self:getAward(arg_58_0.id, function(...)
			arg_58_0:setBright(true)
		end)
	end)

	function var_57_0:update(arg_60_1)
		local var_60_9000
		local var_60_0 = self:getConfValue("cell_bg_special_path")
		local var_60_1 = self:getPath((var_60_0 and var_60_0[self.index] or nil) and (var_60_0[self.index].path or "cell_bg"))

		var_57_0:setContentSize(620, 120)
		ccui.Helper:seekWidgetByName(var_57_0, "Button_cell"):loadTextures(self:getPath("cell_bg", self.usemodule), self:getPath("cell_bg", self.usemodule), self:getPath("cell_bg", self.usemodule))
		ccui.Helper:seekWidgetByName(var_57_0, "Button_cell"):loadTextures(var_60_1, var_60_1, var_60_1)

		if self.stages and string.find(self.usemodule, "reset_recharge") then
			ccui.Helper:seekWidgetByName(var_57_0, "Button_cell"):loadTextures(self.activityPath .. "cell_bg1.png", self.activityPath .. "cell_bg1.png", self.activityPath .. "cell_bg1.png")
			ccui.Helper:seekWidgetByName(var_57_0, "Button_award"):setPositionX(560)
			var_57_0:getChildByName("cellscrollview"):setPositionX(220)
		else
			ccui.Helper:seekWidgetByName(var_57_0, "Button_award"):setPositionX(510)
			var_57_0:getChildByName("cellscrollview"):setPositionX(170)
		end

		local var_60_2 = self:getUiPositionConf("item_bg_path")

		self.id = arg_60_1
		ccui.Helper:seekWidgetByName(var_57_0, "Button_award").id = arg_60_1

		local var_60_3 = self.tasklist[arg_60_1]
		local var_60_4 = self.tasklist[arg_60_1].taskid
		local var_60_6 = self.tasklist[arg_60_1].status
		local var_60_7 = drop_manager:getDropMsg(task_data[self.tasklist[arg_60_1].taskid].drop)

		table.sort(var_60_7.equips, function(arg_61_0, arg_61_1)
			return arg_61_0._index < arg_61_1._index
		end)

		local var_60_8 = {}

		if var_60_7.diamond > 0 then
			table.insert(var_60_8, {
				itemid = "diamond",
				num = var_60_7.diamond,
				name = L_DIAMOND
			})
		end

		if var_60_7.gold > 0 then
			table.insert(var_60_8, {
				itemid = "gold",
				num = var_60_7.gold,
				name = L_GOLD
			})
		end

		local var_60_9 = {}

		for iter_60_0, iter_60_1 in pairs(var_60_7.equips) do
			table.insert(var_60_9, {
				itemid = iter_60_1.dropid,
				num = iter_60_1.dropNum,
				name = item_data[iter_60_1.dropid].name,
				item_attr = iter_60_1.item_attr
			})
		end

		for iter_60_2, iter_60_3 in pairs(var_60_9) do
			table.insert(var_60_8, iter_60_3)
		end

		while ccui.Helper:seekWidgetByName(self, "Panel_item" .. 1) do
			ccui.Helper:seekWidgetByName(self, "Panel_item" .. 1):setVisible(false)

			if var_60_8[1] then
				ccui.Helper:seekWidgetByName(self, "Panel_item" .. 1):setVisible(true)
				ccui.Helper:seekWidgetByName(self, "Panel_item" .. 1):getChildByName("sp"):updateSignItemByItemid(var_60_8[1].itemid, var_60_8[1].num, nil, nil, nil, var_60_2, var_60_8[1].item_attr)
			end

			if ccui.Helper:seekWidgetByName(self, "Panel_item_mask" .. 1) then
				ccui.Helper:seekWidgetByName(self, "Panel_item_mask" .. 1):setVisible(false)
			end
		end

		local var_60_11
		local var_60_12

		if self.activityid >= 151 then
			var_60_11 = task_data[self.tasklist[arg_60_1].taskid].name
			var_60_12 = task_data[self.tasklist[arg_60_1].taskid].task_des
		else
			var_60_11 = string.match(task_data[self.tasklist[arg_60_1].taskid].name, "%d+")
			var_60_12 = string.match(task_data[self.tasklist[arg_60_1].taskid].name, "%D+")
		end

		ccui.Helper:seekWidgetByName(self, "Button_award"):loadTextures(self:getPath("get_award", self.usemodule), self:getPath("get_award", self.usemodule), self:getPath("get_award", self.usemodule))

		if self:getConfValue("Image_condition").visible == false then
			self:getChildByName("Label_score"):setPosition(self:getConfValue("Label_score", self.usemodule).pos)
			self:getChildByName("Label_scoredes"):setPosition(self:getConfValue("Label_scoredes", self.usemodule).pos)

			local var_60_13 = self:getConfValue("Label_scoredes", self.usemodule)

			if var_60_13 and var_60_13.color then
				self:getChildByName("Label_scoredes"):setColor(var_60_13.color)
			end
		else
			self:getChildByName("Label_score"):setString(var_60_11)
			self:getChildByName("Label_scoredes"):setString(var_60_12)

			local var_60_14 = self:getChildByName("Label_score")
			local var_60_15 = var_60_14:getContentSize().width + var_60_9000
			local var_60_16 = ccui.Helper:seekWidgetByName(self.cloneCell, "Label_score")

			self:getChildByName("Label_score").setPositionX(self:getChildByName("Label_scoredes").getContentSize(var_60_14).width, var_60_16:getPositionX() - self:getChildByName("Label_scoredes").getContentSize(var_60_16).width / 2)

			local var_60_17 = ccui.Helper:seekWidgetByName(self.cloneCell, "Label_score")

			self:getChildByName("Label_scoredes"):setPositionX(var_60_17:getPositionX() + self:getChildByName("Label_score").getContentSize(var_60_17).width / 2)

			if self.stages and string.find(self.usemodule, "reset_recharge") then
				local var_60_18 = ccui.Helper:seekWidgetByName(self.cloneCell, "Label_score")

				self:getChildByName("Label_score"):setPositionX(var_60_18:getPositionX() - self:getChildByName("Label_scoredes").getContentSize(var_60_18).width / 2 + 40)

				local var_60_19 = ccui.Helper:seekWidgetByName(self.cloneCell, "Label_score")

				self:getChildByName("Label_scoredes"):setPositionX(var_60_19:getPositionX() + self:getChildByName("Label_score").getContentSize(var_60_19).width / 2 + 40)
			end

			local var_60_20 = self:getPath(var_0_12[self.usemodule])

			if var_60_20 then
				ccui.Helper:seekWidgetByName(self, "Image_condition"):loadTexture(var_60_20)
			end

			local var_60_21 = self:getConfValue("Label_scoredes")

			if var_60_21 and var_60_21.color then
				self:getChildByName("Label_scoredes"):setColor(var_60_21.color)
			end
		end

		ccui.Helper:seekWidgetByName(self, "Image_cell_mask"):setVisible(false)

		local var_60_22 = self:getConfValue("Image_mark")

		if var_60_22 and var_60_22.visible then
			local var_60_23 = self:getChildByName("Image_mark")

			if var_60_3 and (var_60_3.need and var_60_3.need <= self.score or var_60_3.status == 1) then
				var_60_23:loadTexture(self:getPath(var_60_22.path_on))
			else
				var_60_23:loadTexture(self:getPath(var_60_22.path))
			end
		end

		self:getChildByName("Label_scoredes"):setColor(self:getConfValue("Label_scoredes").color)
		self:getChildByName("Label_score"):setColor(self:getConfValue("Label_score").color)

		if var_60_3 and var_60_3.percent and var_60_3.percent < 100 then
			ccui.Helper:seekWidgetByName(self, "Button_award"):loadTextures(self:getPath("get_late", self.usemodule), self:getPath("get_late", self.usemodule), self:getPath("get_late", self.usemodule))

			local var_60_24 = self:getPath("cell_bg_late", self.usemodule, "cell_bg")

			ccui.Helper:seekWidgetByName(var_57_0, "Button_cell"):loadTextures(var_60_24, var_60_24, var_60_24)

			if self.stages and string.find(self.usemodule, "reset_recharge") then
				ccui.Helper:seekWidgetByName(var_57_0, "Button_cell"):loadTextures(self.activityPath .. "cell_bg1.png", self.activityPath .. "cell_bg1.png", self.activityPath .. "cell_bg1.png")
			end

			local var_60_25 = self:getConfValue("Label_scoredes")

			if var_60_25 and var_60_25.color_late then
				self:getChildByName("Label_scoredes"):setColor(var_60_25.color_late)
			end

			local var_60_26 = self:getConfValue("Label_score")

			if var_60_26 and var_60_26.color_late then
				self:getChildByName("Label_score"):setColor(var_60_26.color_late)
			end
		end

		if var_60_3 and var_60_3.percent and var_60_3.percent == 100 then
			if self:getConfValue("Image_condition").visible ~= false then
				local var_60_27 = self:getPath(var_0_11[self.usemodule])

				if var_60_27 then
					ccui.Helper:seekWidgetByName(self, "Image_condition"):loadTexture(var_60_27)
				end
			end

			local var_60_28 = self:getPath("cell_bg", self.usemodule, "cell_bg")

			ccui.Helper:seekWidgetByName(var_57_0, "Button_cell"):loadTextures(var_60_28, var_60_28, var_60_28)

			if self.stages and string.find(self.usemodule, "reset_recharge") then
				ccui.Helper:seekWidgetByName(var_57_0, "Button_cell"):loadTextures(self.activityPath .. "cell_bg1.png", self.activityPath .. "cell_bg1.png", self.activityPath .. "cell_bg1.png")
			end

			local var_60_29 = self:getConfValue("Label_scoredes")

			if var_60_29 and var_60_29.color_get then
				self:getChildByName("Label_scoredes"):setColor(var_60_29.color_get)
			end

			local var_60_30 = self:getConfValue("Label_score")

			if var_60_30 and var_60_30.color_get then
				self:getChildByName("Label_score"):setColor(var_60_30.color_get)
			end
		end

		if var_60_6 == 1 then
			if self:getConfValue("Image_condition").visible ~= false then
				local var_60_31 = self:getPath(var_0_11[self.usemodule])

				ccui.Helper:seekWidgetByName(self, "Image_condition"):loadTexture(var_60_31)

				if var_60_31 then
					ccui.Helper:seekWidgetByName(self, "Image_condition"):loadTexture(var_60_31)
				end
			end

			ccui.Helper:seekWidgetByName(self, "Button_award"):loadTextures(self:getPath("got_btn", self.usemodule), self:getPath("got_btn", self.usemodule), self:getPath("got_btn", self.usemodule))
			ccui.Helper:seekWidgetByName(self, "Image_cell_mask"):setVisible(true)

			local var_60_32 = 1

			while ccui.Helper:seekWidgetByName(self, "Panel_item" .. var_60_32) do
				local var_60_33 = self:getConfValue("Image_item_got_mask")

				if var_60_33 and var_60_33.path then
					if not ccui.Helper:seekWidgetByName(self, "Panel_item_mask" .. var_60_32) then
						local var_60_34 = ccui.ImageView:create(self:getPath(var_60_33.path))

						var_60_34:setName("Panel_item_mask" .. var_60_32)
						var_60_34:setPositionX(var_60_34:getContentSize().width / 2)
						var_60_34:setPositionY(var_60_34:getContentSize().height / 2 + 4)
						ccui.Helper:seekWidgetByName(self, "Panel_item" .. var_60_32):addChild(var_60_34)
					end

					ccui.Helper:seekWidgetByName(self, "Panel_item_mask" .. var_60_32):setVisible(true)
				end

				var_60_32 = var_60_32 + 1
			end

			local var_60_35 = self:getPath("cell_bg_got", self.usemodule, "cell_bg")

			ccui.Helper:seekWidgetByName(var_57_0, "Button_cell"):loadTextures(var_60_35, var_60_35, var_60_35)

			if self.stages and string.find(self.usemodule, "reset_recharge") then
				ccui.Helper:seekWidgetByName(var_57_0, "Button_cell"):loadTextures(self.activityPath .. "cell_bg1.png", self.activityPath .. "cell_bg1.png", self.activityPath .. "cell_bg1.png")
			end

			local var_60_36 = self:getConfValue("Label_scoredes")

			if var_60_36 and var_60_36.color_got then
				self:getChildByName("Label_scoredes"):setColor(var_60_36.color_got)
			end

			local var_60_37 = self:getConfValue("Label_score")

			if var_60_37 and var_60_37.color_got then
				self:getChildByName("Label_score"):setColor(var_60_37.color_got)
			end
		end

		if not self.stages or not string.find(self.usemodule, "reset_recharge") then
			(function(...)
				ccui.Helper:seekWidgetByName(self, "Image_progress_bg"):setVisible(self.usemodule ~= "pass_level")
				ccui.Helper:seekWidgetByName(self, "Image_progress"):setVisible(self.usemodule ~= "pass_level")

				if ccui.Helper:seekWidgetByName(self, "Image_mark") then
					ccui.Helper:seekWidgetByName(self, "Image_mark"):setVisible(self.usemodule ~= "pass_level")
				end

				if self.usemodule == "pass_level" then
					return
				end

				ccui.Helper:seekWidgetByName(self, "Image_progress_bg"):setPositionY(self:getContentSize().height / 2)

				if self.id == 1 then
					ccui.Helper:seekWidgetByName(self, "Image_progress_bg"):setPositionY(self:getContentSize().height / 2)
				elseif self.id == #self.tasklist then
					ccui.Helper:seekWidgetByName(self, "Image_progress_bg"):setPositionY(self:getContentSize().height)
				end

				if self.tasklist[arg_60_1 - 1] then
					local var_62_1 = self.tasklist[arg_60_1 - 1].taskid or nil
					local var_62_2

					if self.tasklist[arg_60_1 + 1] then
						var_62_2 = self.tasklist[arg_60_1 + 1].taskid or nil

						local var_62_3

						if task_data[var_62_1] then
							var_62_3 = task_data[var_62_1].needs_num or nil
						end
					end
				end

				local var_62_4 = task_data[var_60_4].needs_num
				local var_62_5

				if task_data[var_62_2] then
					var_62_5 = task_data[var_62_2].needs_num or nil
				end

				local var_62_6 = var_62_4
				local var_62_7 = var_62_4

				var_62_6 = var_62_3 and (var_62_3 + var_62_4) / 2 or 0

				if var_62_5 then
					var_62_7 = (var_62_5 + var_62_4) / 2
				end

				local var_62_8 = 0

				var_62_8 = var_62_7 <= self.score and var_62_7 == var_62_4 and 0 or var_62_4 > self.score and (1 - (self.score - var_62_6) / (var_62_4 - var_62_6)) / 2 + 0.5 + 1 or 1 - (self.score - var_62_4) / (var_62_7 - var_62_4) / 2 - 0.5 + 1

				ccui.Helper:seekWidgetByName(self, "Image_progress"):setScaleY(1)

				if var_62_8 < 1 then
					if self.id == #self.tasklist then
						ccui.Helper:seekWidgetByName(self, "Image_progress"):setPositionY(1.5 * self:getContentSize().height)
					else
						ccui.Helper:seekWidgetByName(self, "Image_progress"):setPositionY(1 * self:getContentSize().height)
					end
				else
					ccui.Helper:seekWidgetByName(self, "Image_progress"):setPositionY(var_62_8 * self:getContentSize().height)
				end
			end)()
		else
			ccui.Helper:seekWidgetByName(self, "Image_progress_bg"):setVisible(false)
			ccui.Helper:seekWidgetByName(self, "Image_progress"):setVisible(false)

			if ccui.Helper:seekWidgetByName(self, "Image_mark") then
				ccui.Helper:seekWidgetByName(self, "Image_mark"):setVisible(false)
			end
		end

		local var_60_38 = self:getConfValue("Image_cell_mask")

		if var_60_38 and var_60_38.visible == false then
			ccui.Helper:seekWidgetByName(self, "Image_cell_mask"):setVisible(false)
		end

		;(function(...)
			self:setUiPositionByNode(ccui.Helper:seekWidgetByName(var_57_0, "Button_cell"), "Button_cell")
		end)()
	end

	return var_57_0
end

function ActivityRechargeTemplate:getAward(arg_64_1, arg_64_2)
	if self.tasklist[arg_64_1].status == 1 then
		global_ShowBlockWords("已领取")

		if arg_64_2 then
			arg_64_2()
		end

		return
	end

	activity_manager:getTaskReward(self.activityid, self.tasklist[arg_64_1].taskid, function(arg_65_0, arg_65_1)
		if arg_65_0 == 1 then
			global_gain(arg_65_1)
			self:updateData(function(...)
				self:updateUI()

				if arg_64_2 then
					arg_64_2()
				end
			end)
		elseif arg_65_0 == 3 then
			if self.usemodule:find("have_skin") then
				self:pushSkinCollectLayer()
			else
				goto_complete_system({
					jump_to_system = task_data[self.tasklist[arg_64_1].taskid].jump
				})
			end

			if arg_64_2 then
				arg_64_2()
			end
		end
	end)
end

function ActivityRechargeTemplate:runIntoAction()
	while ccui.Helper:seekWidgetByName(self.rootLayer, "Button_module_group_" .. 1) do
		local var_67_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_module_group_" .. 1)

		var_67_0:setPositionY(600)
		var_67_0:runAction(cc.Sequence:create(cc.MoveTo:create(0, cc.p(var_67_0:getPositionX(), var_67_0:getPositionY() + 400)), cc.DelayTime:create(1 * 0.1), cc.MoveTo:create(0.1, cc.p(var_67_0:getPositionX(), var_67_0:getPositionY()))))
	end
end

function ActivityRechargeTemplate:pushSkinCollectLayer(...)
	if not task_data[self.tasklist[1].taskid].need_target_string or not task_data[self.tasklist[1].taskid].need_target_string:find(",") then
		hx_print(string.format("taksid %d 没填 need_target_string, 应该为皮肤id组成的字符串使用【,】分隔", self.tasklist[1].taskid))

		return
	end

	local var_68_0 = {}

	for iter_68_0, iter_68_1 in pairs(task_data[self.tasklist[1].taskid].need_target_string:split(",")) do
		table.insert(var_68_0, tonumber(iter_68_1))
	end

	LayerManager:pushInLayer("SkinCollectLayer", {
		skinList = var_68_0
	})
end

function ActivityRechargeTemplate:registerRechargeEvent(...)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_70_0)
		self:updateData(function(...)
			self:updateUI()
		end)
	end), self)
end

function ActivityRechargeTemplate:getActivityTaskIndexData(...)
	if not activity_task_conf[self.activityid] then
		return require("data." .. activity_conf_data[self.activityid].taskindexfile)
	else
		return require(string.format("data.activity_%d.%s", self.activityid, activity_conf_data[self.activityid].taskindexfile))
	end
end

function ActivityRechargeTemplate:devmode_bugfix(...)
	if config._DEBUG and not activity_task_conf[self.activityid] and self.activityid >= 170 then
		self.activityPath = "activitiesRes/activity" .. self.activityid .. "/activitytask/"

		if not self.modulegroupconf then
			if not cc.FileUtils:getInstance():isFileExist(not activity_task_conf[self.activityid] and "data." .. activity_conf_data[self.activityid].taskindexfile or string.format("data.activity_%d.%s", self.activityid, activity_conf_data[self.activityid].taskindexfile)) then
				function self.getActivityTaskIndexData(arg_74_0, ...)
					return require("data.activity_taskindex.activity_154_task_index_data")
				end
			end

			hx_print(string.format("activity_task_conf[%d] is nil", self.activityid))

			self.modulegroupconf = {
				"total_recharge"
			}
		end
	end
end
