LinkActivityEntranceLayer = class("LinkActivityEntranceLayer", function()
	return ccui.Layout:create()
end)

local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local alert_manager = require("controller.alert_manager")
local network = require("network.network")

require("view.Sprite.MovingView")

local var_0_4 = config._DEBUG and 0 or 1

function LinkActivityEntranceLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = LinkActivityEntranceLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function LinkActivityEntranceLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "LinkActivityEntrance.json" or "LinkActivityEntrance.ExportJson")

	self.rootLayer:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootLayer, 2)

	self.copyUnit = ccui.Helper:seekWidgetByName(self.rootLayer, "copy_unit")

	self.copyUnit:removeFromParent()
	self.copyUnit:retain()
	self:getActivityInfo(1)
	self:initBottom()
	self:initTitle()
	self:registerActivityEventListener()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			self.copyUnit:release()
			activity_manager:releaseEventListenerByName("LinkActivityEntranceLayer")
		end
	end)
end

function LinkActivityEntranceLayer:initUI()
	self:drawEntranceList()

	if self.label then
		return
	end

	local var_5_0 = cc.Label:createWithTTF("剩余次数：" .. self.point .. "/1（每周一0点恢复)", FONT_DES, 18)

	var_5_0:setPosition(460, 50)
	var_5_0:setName("label")
	self.rootLayer:addChild(var_5_0, 100)

	self.label = var_5_0
end

function LinkActivityEntranceLayer:initTitle()
	local var_6_0 = ccui.ImageView:create("LinkActivityEntrance/top_activity.png", var_0_4)

	var_6_0:setPositionX(320)
	var_6_0:setPositionY(1136 - var_6_0:getContentSize().height / 2 + GameDisplay.fix_y * 2)
	self.rootLayer:addChild(var_6_0, 999999)
end

function LinkActivityEntranceLayer:getEntranceList()
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs((global_deepCopy(activity_manager:getActivityEntranceList()))) do
		if iter_7_1.linkage == 1 then
			table.insert(var_7_0, iter_7_1)
		end
	end

	self.entranceActivityList = var_7_0
	self.cellConfs = {}

	for iter_7_2, iter_7_3 in ipairs(self.entranceActivityList) do
		self.cellConfs[iter_7_2] = {
			size = {
				width = 600,
				height = iter_7_3.isbigBanner and 350 or 252
			}
		}
	end
end

function LinkActivityEntranceLayer:initBottom()
	local var_8_0 = ccui.Button:create("public/button/bottom_return_btn_archives.png", nil, "public/button/bottom_return_btn_archives.png", var_0_4)

	var_8_0:setPosition(cc.p(50, 50))
	var_8_0:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.rootLayer:addChild(var_8_0, 9999999)
end

function LinkActivityEntranceLayer:drawEntranceList()
	if self.tableView then
		self.tableView:removeFromParent()
	end

	local function var_10_0(arg_11_0)
		local var_11_0 = self.entranceActivityList[arg_11_0.index - 1 + 1]
		local var_11_1 = arg_11_0:getChildByTag(100)

		if not var_11_1 then
			var_11_1 = self:createEntrance(self.entranceActivityList[arg_11_0.index - 1 + 1])
			var_11_1.status = self.entranceActivityList[arg_11_0.index - 1 + 1].status
			var_11_1.id = self.entranceActivityList[arg_11_0.index - 1 + 1].activityid

			var_11_1:setAnchorPoint(cc.p(0.5, 0.5))
			var_11_1:setPosition(cc.p(arg_11_0:getContentSize().width / 2, arg_11_0:getContentSize().height / 2))
			self:drawEntranceAlert(var_11_1, arg_11_0.index - 1)
			arg_11_0:addChild(var_11_1)
		end

		local function var_11_2(arg_12_0, arg_12_1)
			if arg_12_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_12_0:getTouchBeganPosition().y - arg_12_0:getTouchEndPosition().y) > 50 then
				return
			end

			if arg_12_0.status == 1 then
				require("controller.goto_system_manager")
				goto_complete_system({
					jump_to_system = var_11_0.jump
				})
			elseif self.point == 1 then
				LayerManager:pushInLayer("PopDoLayer", {
					labels = {
						des = "班长是否消耗次数开启该活动30天？"
					},
					surecallback = function()
						self:openActivity(arg_12_0.id)
						self:updateEntrance(arg_12_0)
						self:updateLabel()
					end
				})
			else
				global_ShowBlockWords("活动开启次数不足!")
			end

			if var_11_0.jump then
				AnalyticManager.clickActivityEntranceType({
					enterType = "LinkActivityEntranceLayer",
					activityid = var_11_0.configId,
					jumpid = var_11_0.jump,
					id = var_11_0.id
				})
			end
		end

		var_11_1:setSwallowTouches(false)
		var_11_1:addTouchEventListener(var_11_2)
	end

	local var_10_1 = {}

	var_10_1.width = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_tableview"):getContentSize().width
	var_10_1.height = 940 + GameDisplay.fix_y * 2 + 40
	var_10_1.direction = cc.SCROLLVIEW_DIRECTION_VERTICAL
	var_10_1.cellConfs = self.cellConfs
	var_10_1.registerCellFunc = var_10_0

	if not self.cellConfs then
		return
	end

	self.tableView = MovingView:create(var_10_1)

	self.tableView:updateCells()
	self.tableView:setPosition(0, -50)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_tableview"):addChild(self.tableView)
end

function LinkActivityEntranceLayer:updateEntrance(arg_14_1)
	self:getActivityInfo()

	for iter_14_0, iter_14_1 in pairs(self.entranceActivityList) do
		if iter_14_1.id == arg_14_1.id and iter_14_1.status == 1 then
			arg_14_1.status = 1

			arg_14_1:setOpacity(255)
			arg_14_1:getChildByName("lock_icon"):setVisible(false)
		end
	end
end

function LinkActivityEntranceLayer:updateLabel()
	self.label:setString("剩余次数：" .. self.point .. "/1（每周一0点恢复)")
end

local function var_0_5(arg_16_0)
	local var_16_1 = (arg_16_0 - arg_16_0 % 60 - (arg_16_0 - arg_16_0 % 60) % 3600 / 60 * 60) / 3600 % 24
	local var_16_2 = math.floor((arg_16_0 - arg_16_0 % 60 - (arg_16_0 - arg_16_0 % 60) % 3600 / 60 * 60) / 3600 / 24)

	if var_16_2 > 0 then
		return string.format(L_TIME_FORMAT[1], var_16_2, var_16_1)
	elseif var_16_1 > 0 then
		return string.format(L_TIME_FORMAT[2], var_16_1, (arg_16_0 - arg_16_0 % 60) % 3600 / 60)
	elseif (arg_16_0 - arg_16_0 % 60) % 3600 / 60 > 0 then
		return string.format(L_TIME_FORMAT[3], (arg_16_0 - arg_16_0 % 60) % 3600 / 60)
	else
		return L_TIME_FORMAT[4]
	end
end

function LinkActivityEntranceLayer:createEntrance(arg_17_1)
	local var_17_0 = self.copyUnit:clone()

	if arg_17_1.isbigBanner then
		var_17_0:setContentSize(cc.size(600, 350))
	else
		var_17_0:setContentSize(cc.size(600, 252))
	end

	var_17_0:loadTextures("mainScenebg/activity_entrance/" .. arg_17_1.image .. ".png", nil, "mainScenebg/activity_entrance/" .. arg_17_1.image .. ".png")
	var_17_0:setTag(100)
	var_17_0:setName(tostring(arg_17_1.image))

	local var_17_1 = var_17_0:getChildByName("panel_time_bg")

	var_17_1:setAnchorPoint(cc.p(1, 1))
	var_17_1:setPosition(var_17_0:getContentSize().width, 40)

	local var_17_2 = var_17_0:getChildByName("panel_time_bg"):getChildByName("left_label")
	local var_17_3 = arg_17_1.finishtime and os.time(parse_time(arg_17_1.finishtime))

	if var_17_3 and var_17_3 > time_check_manager:getCurTime() and var_17_3 - time_check_manager:getCurTime() < 31536000 then
		local var_17_4 = var_17_3 - time_check_manager:getCurTime()

		var_17_2:setString((var_0_5(var_17_4)))
		var_17_2:runAction((cc.RepeatForever:create((cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
			var_17_4 = var_17_4 - 1

			if var_17_4 >= 0 then
				var_17_2:setString((var_0_5(var_17_4)))
			else
				var_17_2:stopAction(seqre)
				self:drawEntranceList()
			end
		end))))))

		if var_17_4 < 86400 then
			var_17_1:setBackGroundImage("PopActivityEntrance/time_bg.png", var_0_4)
			var_17_2:setColor(cc.c3b(255, 255, 255))
		else
			var_17_1:setBackGroundImage("PopActivityEntrance/time_gary_bg.png", var_0_4)
			var_17_2:setColor(cc.c3b(255, 229, 158))
		end
	else
		var_17_1:setVisible(false)
	end

	local var_17_5 = ccui.ImageView:create("public/button/fight_lock.png", var_0_4)

	var_17_5:setName("lock_icon")
	var_17_5:setVisible(false)
	var_17_5:setPosition(cc.p(var_17_0:getContentSize().width - 28, var_17_0:getContentSize().height - 30))
	var_17_0:addChild(var_17_5, 1000)

	if arg_17_1.status == 0 then
		var_17_0:setOpacity(120)
		var_17_0:getChildByName("lock_icon"):setVisible(true)
	end

	return var_17_0
end

function LinkActivityEntranceLayer:drawEntranceAlert(arg_19_1, arg_19_2)
	if arg_19_1.status == 0 then
		return
	end

	local var_19_1 = {
		x = arg_19_1:getContentSize().width - 10,
		y = arg_19_1:getContentSize().height - 10
	}

	if activity_manager:isActivityInEntranceNeedAlert(self.entranceActivityList[arg_19_2 + 1].id) then
		global_add_alert_tag(arg_19_1, var_19_1)
	else
		global_remove_alert_tag(arg_19_1)
	end

	if activity_manager:isNewActivity(self.entranceActivityList[arg_19_2 + 1].image) then
		alert_manager:add_new_mark(arg_19_1, true, {
			x = arg_19_1:getContentSize().width - 40,
			y = arg_19_1:getContentSize().height - 10
		})
		activity_manager:checkRedNode(arg_19_1)
	else
		alert_manager:add_new_mark(arg_19_1, false)

		if activity_manager:checkRedNode(arg_19_1) then
			activity_manager:checkRedNode(arg_19_1):setVisible(true)
		end
	end

	local var_19_2 = ({
		["1000003"] = {
			ALERT_SIGN
		},
		["1000005"] = {
			ALERT_TWISTEGG,
			ALERT_ACTIVTIYNEWLOG_TWISTEGG
		},
		["1000008"] = {
			ALERT_MIDAS
		}
	})[arg_19_1:getName()]

	if var_19_2 then
		for iter_19_0, iter_19_1 in pairs(var_19_2) do
			if alert_manager.alertsys[iter_19_1] then
				alert_manager:add_redDot(arg_19_1, true, var_19_1)
			end
		end
	end
end

function LinkActivityEntranceLayer:registerActivityEventListener()
	activity_manager:registerEventListener("LinkActivityEntranceLayer", activity_manager.activityEventId.UPDATE_NEW_ACTIVITY_LIST, function(arg_21_0)
		self:updateShowingCells()
		alert_manager:check_current_alert("LinkActivityEntranceLayer")
	end)
	activity_manager:registerEventListener("LinkActivityEntranceLayer", activity_manager.activityEventId.ACTIVITY_GET_REWARD_CHANGED, function(arg_22_0)
		activity_manager:updateActivityEntranceList()
	end)
	activity_manager:registerEventListener("LinkActivityEntranceLayer", activity_manager.activityEventId.UPDATE_ACTIVITY_STATUS_ALERT, function(arg_23_0)
		self:drawEntranceList()
		alert_manager:check_current_alert("LinkActivityEntranceLayer")
	end)
	activity_manager:registerEventListener("LinkActivityEntranceLayer", activity_manager.activityEventId.ACTIVITY_STATE_CHANGED, function(arg_24_0)
		activity_manager:updateActivityEntranceList()
	end)
	activity_manager:registerEventListener("LinkActivityEntranceLayer", activity_manager.activityEventId.ACTIVITY_ENTRANCE_LIST_UPDATE, function(arg_25_0)
		self:initUI()
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("timeCheckManagerEvent", function(arg_26_0)
		if arg_26_0.eventType ~= NEXT_DAY then
			return
		end

		activity_manager:updateActivityEntranceList()
	end), self)
end

function LinkActivityEntranceLayer.updateShowingCells(arg_27_0)
	return
end

function LinkActivityEntranceLayer.getActivityInfo(arg_28_0, arg_28_1)
	arg_28_1 = arg_28_1 or 1

	network:rpc("get_resident_activity_info", {
		resident_type = arg_28_1
	}, function(arg_29_0)
		if arg_29_0.result == 1 then
			arg_28_0:insertList(arg_29_0.list)

			arg_28_0.point = arg_29_0.point

			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_ENTRANCE_LIST_UPDATE)
		end
	end)
end

function LinkActivityEntranceLayer:insertList(arg_30_1)
	if not arg_30_1 then
		return
	end

	self.entranceActivityList = {}

	local var_30_0 = {}

	for iter_30_0, iter_30_1 in pairs(arg_30_1) do
		local var_30_1 = json.decode(iter_30_1.entrance_data)

		var_30_1.status = iter_30_1.status
		var_30_1.activityid = iter_30_1.activityid
		var_30_1.entrance_data = json.decode(iter_30_1.entrance_data)
		var_30_0[iter_30_0] = var_30_1
	end

	table.sort(var_30_0, function(arg_31_0, arg_31_1)
		if arg_31_0.status ~= arg_31_1.status then
			return arg_31_0.status > arg_31_1.status
		elseif arg_31_0.status == arg_31_1.status and arg_31_0.status == 0 then
			return arg_31_0.order > arg_31_1.order
		elseif arg_31_0.status == arg_31_1.status and arg_31_0.status == 1 then
			local var_31_0 = time_check_manager:getCurTime()

			return (arg_31_1.finishtime and os.time(parse_time(arg_31_1.finishtime))) < (arg_31_0.finishtime and os.time(parse_time(arg_31_0.finishtime)))
		end
	end)

	for iter_30_2, iter_30_3 in pairs((global_deepCopy(activity_manager:getActivityEntranceList()))) do
		if iter_30_3.id == 2860001 then
			iter_30_3.status = 1

			table.insert(var_30_0, 1, iter_30_3)
		end
	end

	self.entranceActivityList = var_30_0
	self.cellConfs = {}

	for iter_30_4, iter_30_5 in pairs(self.entranceActivityList) do
		self.cellConfs[#self.cellConfs + 1] = {
			size = {
				width = 600,
				height = iter_30_5.isbigBanner and 350 or 252
			}
		}
	end
end

function LinkActivityEntranceLayer.openActivity(arg_32_0, arg_32_1)
	if not arg_32_1 then
		return
	end

	network:rpc("open_resident_activity", {
		activityid = arg_32_1
	}, function(arg_33_0)
		if arg_33_0.result == 1 then
			global_ShowBlockWords("活动开启成功!")

			arg_32_0.point = arg_33_0.point

			activity_manager:updateActivity(arg_32_1, "START", arg_33_0.activity)
		elseif arg_33_0.result == 2 then
			global_ShowBlockWords("失败，点数不足!")
		elseif arg_33_0.result == 3 then
			global_ShowBlockWords("失败，活动不存在!")
		elseif arg_33_0.result == 4 then
			global_ShowBlockWords("活动已经开启，不需重复开启!")
		end
	end)
end
