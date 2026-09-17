PopOnlineRewardLayer = class("PopOnlineRewardLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local audio_manager = require("controller.audio_manager")
local online_reward_conf_data = require("data.online_reward_conf_data")
local drop_manager = require("controller.drop_manager")
local network = require("network.network")
local alert_manager = require("controller.alert_manager")
local var_0_6

local function var_0_7()
	network:rpc("get_online_time_info", nil, function(arg_3_0)
		print("get_online_time_info")
		print(dump(arg_3_0))

		if not var_0_6 then
			return
		end

		if arg_3_0.result == 1 then
			var_0_6:update(arg_3_0.online_time, arg_3_0.reward_count, arg_3_0.day)
		elseif arg_3_0.result == 2 then
			global_ShowBlockWords(L_ACTIVITY_END)
			var_0_6:exit()
		elseif arg_3_0.result == 3 then
			-- block empty
		end
	end)
end

local function var_0_8()
	network:rpc("get_online_time_reward", nil, function(arg_5_0)
		print("get_online_time_reward")
		print(dump(arg_5_0))

		if not var_0_6 then
			return
		end

		if arg_5_0.result == 1 then
			global_gain(arg_5_0)
			var_0_6:update(arg_5_0.online_time, arg_5_0.reward_count, arg_5_0.day)
			alert_manager:unregister_alert(E_ALERT_ONLINE_REWARD)
		elseif arg_5_0.result == 2 then
			global_ShowBlockWords(L_ACTIVITY_END)
			var_0_6:exit()
		elseif arg_5_0.result == 3 then
			-- block empty
		elseif arg_5_0.result == 4 then
			var_0_6:request()
			global_ShowBlockWords(L_PATROL_RESULT.Gain_Nil)
		end
	end)
end

function PopOnlineRewardLayer.create(arg_6_0, arg_6_1)
	local var_6_0 = PopOnlineRewardLayer.new()

	var_6_0:init(arg_6_1)

	return var_6_0
end

function PopOnlineRewardLayer:init(arg_7_1)
	self.callback = arg_7_1 and arg_7_1.callback

	local var_7_0 = config._DEBUG and "PopOnlineRewardLayer.json" or "PopOnlineRewardLayer.ExportJson"

	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setContentSize(cc.size(640, GameDisplay.height))
	self.rootLayer:setTouchEnabled(false)
	self:addChild(self.rootLayer, 10)

	self.rootpanel = ccs.GUIReader:getInstance():widgetFromJsonFile(var_7_0)

	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2 - GameDisplay.fix_y * 2)
	self.rootpanel:setTouchEnabled(false)
	self.rootLayer:addChild(self.rootpanel, 10)
	self.rootpanel:getChildByName("PanelBg"):setTouchEnabled(false)
	self.rootpanel:getChildByName("PanelBg"):getChildByName("ImageBg"):setTouchEnabled(true)
	self.showActions.extendVertical(self)
	self:createFullScreenMask(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_8_0:isBright() then
			return
		end

		arg_8_0:setBright(false)
		self:exit()
	end, 120)
	self:registerScriptHandler(function(arg_9_0)
		if arg_9_0 == "exit" then
			var_0_6 = nil

			if self.callback then
				self.callback()
			end
		end
	end)

	var_0_6 = self
	self.panelTableView = ccui.Helper:seekWidgetByName(self.rootpanel, "PanelTableView")
	self.panelCell = ccui.Helper:seekWidgetByName(self.rootpanel, "PanelCell")

	self:request()
end

function PopOnlineRewardLayer.request(arg_10_0)
	var_0_7()
end

function PopOnlineRewardLayer:update(arg_11_1, arg_11_2, arg_11_3)
	self.online_time = arg_11_1
	self.reward_count = arg_11_2
	self.day = arg_11_3
	self.rewardArr = {}

	local var_11_0 = {}

	for iter_11_0 = self.day, 7 do
		var_11_0[iter_11_0] = var_11_0[iter_11_0] or {
			day = iter_11_0,
			reward = {}
		}

		local var_11_1 = 1

		while online_reward_conf_data[iter_11_0 .. "-" .. var_11_1] do
			table.insert(var_11_0[iter_11_0].reward, iter_11_0 .. "-" .. var_11_1)

			var_11_1 = var_11_1 + 1
		end
	end

	for iter_11_1, iter_11_2 in pairs(var_11_0) do
		table.insert(self.rewardArr, iter_11_2)
	end

	table.sort(self.rewardArr, function(arg_12_0, arg_12_1)
		return arg_12_0.day < arg_12_1.day
	end)
	self:updateUI()
end

function PopOnlineRewardLayer:updateUI()
	if not self.tableView then
		self:createTableView()
	end

	self:updateShowingCells()
	self.rootpanel:getChildByName("PanelBg"):getChildByName("LabelOnlineTime"):setString(string.format(L_ONLINE_TIME, tostring(math.floor(self.online_time / 60))))
end

function PopOnlineRewardLayer:createTableView()
	self.tableView = cc.TableView:create(self.panelTableView:getContentSize())

	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableView:setPosition(cc.p(0, 0))
	self.tableView:setDelegate()
	self.panelTableView:addChild(self.tableView)
	self.tableView:registerScriptHandler(function(arg_18_0, arg_18_1)
		return self.panelCell:getContentSize().width, self.panelCell:getContentSize().height
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:registerScriptHandler(function(arg_16_0, arg_16_1)
		local var_16_0 = arg_16_0:dequeueCell()

		if not var_16_0 then
			var_16_0 = cc.TableViewCell:create()

			local var_16_2 = self.panelCell:clone()

			var_16_2:setName("node")
			var_16_2:setPosition(cc.p(0, 0))
			var_16_2:setVisible(true)
			var_16_2:setTouchEnabled(false)
			var_16_0:addChild(var_16_2)
		end

		local var_16_3 = self.rewardArr[arg_16_1 + 1].day
		local var_16_4 = var_16_0:getChildByName("node")

		var_16_4:getChildByName("ImageDay"):loadTexture("PopOnlineRewardLayer/" .. self.rewardArr[arg_16_1 + 1].day .. ".png", var_0_0)
		var_16_4:getChildByName("LabelLock"):setString(string.format(L_UNLOCK_DAY, var_16_3 - self.day))
		var_16_4:getChildByName("LabelLock"):setVisible(var_16_3 > self.day)
		var_16_4:getChildByName("Image_10"):setVisible(var_16_3 > self.day)
		var_16_4:getChildByName("ImageCellMask"):setVisible(var_16_3 > self.day)

		local var_16_5 = 1

		while var_16_4:getChildByName("PanelItem_" .. var_16_5) do
			local var_16_6 = var_16_4:getChildByName("PanelItem_" .. var_16_5)

			var_16_6:getChildByName("ButtonTouch").day = var_16_3

			var_16_6:getChildByName("ButtonTouch"):setSwallowTouches(false)

			if online_reward_conf_data[var_16_3 .. "-" .. var_16_5] then
				var_16_6:setVisible(true)

				local var_16_7 = online_reward_conf_data[var_16_3 .. "-" .. var_16_5].time or ""
				local var_16_8 = online_reward_conf_data[var_16_3 .. "-" .. var_16_5].drop

				var_16_6:getChildByName("ImageMask"):setVisible(var_16_5 <= self.reward_count)
				var_16_6:getChildByName("ImageLight"):setVisible(var_16_3 == self.day and var_16_5 > self.reward_count and self.online_time >= var_16_7 * 60)
				var_16_6:getChildByName("ImageLight"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(1, 80), cc.FadeTo:create(1, 255))))
				var_16_6:getChildByName("LabelTime"):setString(var_16_7)
				var_16_6:getChildByName("ImageArrow"):setVisible(online_reward_conf_data[var_16_3 .. "-" .. var_16_5 + 1] ~= nil)
				var_16_6:getChildByName("LabelNum"):setString("x" .. drop_manager:getDropMsg(var_16_8).diamond)
			else
				var_16_6:setVisible(false)
			end

			var_16_6:getChildByName("ButtonTouch"):addTouchEventListener(function(arg_17_0, arg_17_1)
				if arg_17_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_17_0.day ~= self.day then
					return
				end

				var_0_8()
			end)

			var_16_5 = var_16_5 + 1
		end

		return var_16_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:registerScriptHandler(function(arg_19_0, arg_19_1)
		return #self.rewardArr
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:reloadData()
end

function PopOnlineRewardLayer:updateShowingCells(arg_20_1)
	local var_20_0, var_20_1 = GetTableViewShowCellIdx(self.tableView, {
		cellsize = self.panelCell:getContentSize(),
		maxcount = #self.rewardArr
	})

	for iter_20_0 = var_20_0, var_20_1 do
		self.tableView:updateCellAtIndex(iter_20_0)
	end
end

function PopOnlineRewardLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.exitcallback then
			self.exitcallback(0)
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
