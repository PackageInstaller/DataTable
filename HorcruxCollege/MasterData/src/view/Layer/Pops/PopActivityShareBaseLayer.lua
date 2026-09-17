PopActivityShareBaseLayer = class("PopActivityShareBaseLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = 237
local var_0_1 = config._DEBUG and 0 or 1
local item_data = require("data.item_data")
local task_data = require("data.task_data")
local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local account_manager = require("controller.account_manager")
local share_manager = require("controller.share_manager")

function PopActivityShareBaseLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopActivityShareBaseLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopActivityShareBaseLayer:init(arg_3_1)
	self.activityId = arg_3_1.activityId or var_0_0
	self.layerName = "ActivityShare_" .. self.activityId

	TextureManager:loadLayerTextures({
		self.layerName
	})

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))

	self.rootLayer:setPosition(cc.p(0, 0))
	self:addChild(self.rootLayer, 1)
	self:initUI()
	self:registerActivityEventListener()
	activity_manager:get_activity_share_info(self.activityId)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName(self.layerName)
			TextureManager:removeLayerTextures({
				self.layerName
			})

			ACTIVITYID = self.activityId
		end
	end)
end

function PopActivityShareBaseLayer:registerActivityEventListener()
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.LOL_SHARE_DATA_UPDATE, function(arg_6_0)
		self:upDateUI(arg_6_0)
	end)
end

function PopActivityShareBaseLayer:initUI()
	self:initBG()
	self:initTitle()
	self.showActions.fadeIn(self)
end

function PopActivityShareBaseLayer:initTitle()
	self.titlePanel = self.rootLayer:getChildByName("title")

	self.titlePanel:getChildByName("name"):setString(playermodel.nickname)
	self.titlePanel:setTouchEnabled(true)
	self.titlePanel:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = self.layerName
		})
	end)

	self.btnGet = self.titlePanel:getChildByName("btn_get")

	self.btnGet:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:createCodeWriteLayout()
	end)

	self.btnReturn = self.rootLayer:getChildByName("return")

	self.btnReturn:setPositionY(self.btnReturn:getPositionY() - GameDisplay.fix_y)
	self.btnReturn:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)
end

function PopActivityShareBaseLayer:upDateUI(arg_12_1)
	if arg_12_1.result ~= 1 then
		global_ShowBlockWords(L_FLOP_WARNING[3])
		self:exit()

		return
	end

	self.linePanel = self.rootLayer:getChildByName("line_1")

	for iter_12_0, iter_12_1 in pairs(arg_12_1.rewardList) do
		local var_12_0 = self.linePanel:getChildByName("icon_" .. iter_12_0)
		local var_12_1 = self.linePanel:getChildByName("box_" .. iter_12_0)
		local var_12_2 = self.linePanel:getChildByName("btn_" .. iter_12_0)
		local var_12_3 = var_12_2:getChildByName("lock_time")

		if iter_12_1 == 0 then
			var_12_0:setVisible(false)
			var_12_1:loadTexture(self.layerName .. "/box_off.png", var_0_1)

			local var_12_4 = activity_manager:getLolShareLockTime(self.activityId, iter_12_0)

			if var_12_4 then
				var_12_3:setVisible(true)
				var_12_2:loadTextures(self.layerName .. "/btn_lock.png", nil, self.layerName .. "/btn_lock.png", var_0_1)
				var_12_3:setString(var_12_4 .. L_UNLOCK)
			else
				var_12_3:setVisible(false)
				var_12_2:loadTextures(self.layerName .. "/btn_share.png", nil, self.layerName .. "/btn_share.png", var_0_1)
			end
		elseif iter_12_1 == 1 then
			var_12_0:setVisible(true)
			var_12_1:loadTexture(self.layerName .. "/box_on.png", var_0_1)
			var_12_2:loadTextures(self.layerName .. "/btn_getreward.png", nil, self.layerName .. "/btn_getreward.png", var_0_1)
			var_12_3:setVisible(false)
		elseif iter_12_1 == 2 then
			var_12_0:setVisible(true)
			var_12_1:loadTexture(self.layerName .. "/box_on.png", var_0_1)
			var_12_2:loadTextures(self.layerName .. "/btn_got.png", nil, self.layerName .. "/btn_got.png", var_0_1)
			var_12_3:setVisible(true)
			var_12_3:setString("")
		end

		var_12_1:setTouchEnabled(true)
		var_12_2:addTouchEventListener(function(arg_13_0, arg_13_1)
			if arg_13_1 ~= ccui.TouchEventType.ended then
				return
			end

			if activity_manager:getLolShareLockTime(self.activityId, iter_12_0) then
				return
			end

			self:createGetRewardPanel(iter_12_0)
		end)
	end

	local var_12_5 = require(string.format("data.activity_%s.activity_newyear2022_reward_data", self.activityId))

	self.bottomPanel = self.rootLayer:getChildByName("panel_bottom")
	self.taskPanel = self.rootLayer:getChildByName("panel_task")

	for iter_12_2, iter_12_3 in pairs(arg_12_1.openList) do
		local var_12_6 = self.bottomPanel:getChildByName("reward_" .. iter_12_2)
		local var_12_7 = var_12_6:getChildByName("item")
		local var_12_8 = var_12_6:getChildByName("select")
		local var_12_9 = var_12_6:getChildByName("role_name")
		local var_12_10 = var_12_6:getChildByName("name")
		local var_12_11 = "equipment/" .. var_12_5[iter_12_3].image_id .. ".png"

		if item_data[var_12_5[iter_12_3].itemid].bag_item_type == kITEM_HERO then
			var_12_10:setVisible(true)
			var_12_10:setString(var_12_5[iter_12_3].name or "shareRewardData 里需要填 name: " .. iter_12_3)
			var_12_9:setVisible(true)
			var_12_9:setString(var_12_5[iter_12_3].role_name or "shareRewardData 里需要填 role_name: " .. iter_12_3)

			var_12_11 = "roleimage/role/fight/" .. var_12_5[iter_12_3].image_id .. ".png"
		end

		var_12_7:setScale(0.85)
		var_12_7:loadTexture(var_12_11)
		var_12_7:setVisible(true)
		var_12_7:setTouchEnabled(true)
		var_12_7:addTouchEventListener(function(arg_14_0, arg_14_1)
			if arg_14_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.curSelectImg then
				self.curSelectImg:setVisible(false)
			end

			var_12_8:setVisible(true)

			self.curSelectImg = var_12_8
			self.curSelect = iter_12_2
		end)
	end

	self.bottomPanel:getChildByName("btn_go_task"):addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.curSelect then
			global_ShowBlockWords(L_QINGXUANZE)

			return
		end

		if not arg_12_1.openList[self.curSelect] then
			global_ShowBlockWords(L_BUCUNZAI)

			return
		end

		activity_manager:choose_activity_newyear2022_reward(self.activityId, self.curSelect)
	end)

	if arg_12_1.openTask then
		self.btnGet:setVisible(false)

		local var_12_12 = self.taskPanel:getChildByName("btn_get_reward")
		local var_12_13 = arg_12_1.openTask.taskid
		local var_12_14 = var_12_12:getChildByName("lbl")

		self.taskPanel:getChildByName("pre"):setScaleX(math.min(arg_12_1.openTask.percent, 100) / 100)
		self.taskPanel:getChildByName("task_des"):setString(string.format(L_LOL_SHARE_TASK_DES, task_data[arg_12_1.openTask.taskid].task_des, arg_12_1.openTask.finished, arg_12_1.openTask.need))

		if arg_12_1.taskStatus == 0 then
			var_12_14:setString(L_JUMP_TO)
			var_12_14:setVisible(true)
			var_12_12:loadTextures(self.layerName .. "/btn_lock.png", nil, self.layerName .. "/btn_lock.png", var_0_1)
		elseif arg_12_1.taskStatus == 1 then
			var_12_14:setVisible(false)
			var_12_12:loadTextures(self.layerName .. "/btn_getreward.png", nil, self.layerName .. "/btn_getreward.png", var_0_1)
		elseif arg_12_1.taskStatus == 2 then
			var_12_14:setString("")
			var_12_14:setVisible(true)
			var_12_12:loadTextures(self.layerName .. "/btn_got.png", nil, self.layerName .. "/btn_got.png", var_0_1)
		end

		var_12_12:addTouchEventListener(function(arg_16_0, arg_16_1)
			if arg_16_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_12_1.taskStatus == 2 then
				return
			end

			if arg_12_1.taskStatus == 0 then
				self:taskTumpTo(task_data[var_12_13].jump)

				return
			end

			activity_manager:recv_activity_newyear2022_reward(self.activityId)
		end)
		ccui.Helper:seekWidgetByName(self.taskPanel, "item"):setScale(0.85)
		ccui.Helper:seekWidgetByName(self.taskPanel, "item"):loadTexture("equipment/" .. var_12_5[arg_12_1.openList[arg_12_1.openIndex]].image_id .. ".png")
	end

	self.bottomPanel:setVisible(arg_12_1.openTask == nil)
	self.taskPanel:setVisible(arg_12_1.openTask ~= nil)
end

function PopActivityShareBaseLayer.showGetRewardPanel(arg_17_0, arg_17_1)
	return
end

function PopActivityShareBaseLayer:createCodeWriteLayout()
	local var_18_0 = self.rootLayer:getChildByName("write_layout")

	if var_18_0 then
		var_18_0:setVisible(true)

		return
	end

	local var_18_1 = ccui.Layout:create()

	var_18_1:setBackGroundImageColor(cc.c3b(255, 255, 255))
	var_18_1:setContentSize(cc.size(cc.Director:getInstance():getVisibleSize().width, cc.Director:getInstance():getVisibleSize().height))
	var_18_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_18_1:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	var_18_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_18_1:setBackGroundColor(cc.c3b(0, 0, 0))
	var_18_1:setBackGroundColorOpacity(180)
	var_18_1:setTouchEnabled(true)
	var_18_1:setName("write_layout")
	var_18_1:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_18_1:setVisible(false)
	end)
	self.rootLayer:addChild(var_18_1, 100)

	local var_18_2 = ccui.ImageView:create(self.layerName .. "/reward_bg.png", var_0_1)

	var_18_2:setTouchEnabled(true)
	var_18_2:setPosition(var_18_1:getContentSize().width / 2, var_18_1:getContentSize().height / 2)
	var_18_1:addChild(var_18_2)

	local var_18_3 = config._DEBUG and cc.EditBox:create(cc.size(319, 32), cc.Scale9Sprite:create(self.layerName .. "/input_text.png")) or cc.EditBox:create(cc.size(319, 32), cc.Scale9Sprite:createWithSpriteFrameName(self.layerName .. "/input_text.png"))

	var_18_3:setName("input")
	var_18_3:setPosition(cc.p(270, 155))
	var_18_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_18_3:setFontName(FONT_NAME)
	var_18_3:setPlaceholderFont(FONT_NAME, 28)
	var_18_3:setFontSize(15)
	var_18_3:setFontColor(cc.c3b(255, 255, 255))
	var_18_3:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
	var_18_3:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
	var_18_3:setInputFlag(cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_WORD)
	var_18_2:addChild(var_18_3, 5)

	local var_18_4 = ccui.Button:create(self.layerName .. "/btn_getreward.png", nil, self.layerName .. "/btn_getreward.png", var_0_1)

	var_18_4:setPosition(cc.p(270, 60))
	var_18_2:addChild(var_18_4)
	var_18_4:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_18_3:getText() or var_18_3:getText() == "" then
			global_ShowBlockWords(L_CDK_WARNING.Use_Failed)

			return
		end

		activity_manager:write_activity_newyear2022_code(self.activityId, var_18_3:getText())
		var_18_1:setVisible(false)
	end)
end

function PopActivityShareBaseLayer:createGetRewardPanel(arg_21_1)
	rewardLayout = ccui.Layout:create()

	rewardLayout:setBackGroundImageColor(cc.c3b(255, 255, 255))
	rewardLayout:setContentSize(cc.size(cc.Director:getInstance():getVisibleSize().width, cc.Director:getInstance():getVisibleSize().height))
	rewardLayout:setAnchorPoint(cc.p(0.5, 0.5))
	rewardLayout:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	rewardLayout:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	rewardLayout:setBackGroundColor(cc.c3b(0, 0, 0))
	rewardLayout:setBackGroundColorOpacity(180)
	rewardLayout:setTouchEnabled(true)
	rewardLayout:setName("reward_layout")
	rewardLayout:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		rewardLayout:runAction(cc.RemoveSelf:create())
	end)
	self.rootLayer:addChild(rewardLayout, 100)

	local var_21_0 = ccui.ImageView:create(self.layerName .. "/task_bg.png", var_0_1)

	var_21_0:setTouchEnabled(true)
	var_21_0:setPosition(rewardLayout:getContentSize().width / 2, rewardLayout:getContentSize().height / 2)
	rewardLayout:addChild(var_21_0)

	for iter_21_0 = 1, 4 do
		local var_21_1 = ccui.ImageView:create(self.layerName .. "/reward_lock.png", var_0_1)

		var_21_1:setTouchEnabled(true)
		var_21_1:setPosition(cc.p(100 + (iter_21_0 - 1) * 145, 200))
		var_21_1:setName("box_" .. iter_21_0)
		var_21_0:addChild(var_21_1)

		local var_21_2 = ccui.ImageView:create(self.layerName .. "/icon.png", var_0_1)

		var_21_2:setName("icon")
		var_21_2:setVisible(false)
		var_21_2:setPosition(var_21_1:getContentSize().width / 2, var_21_1:getContentSize().height / 2)
		var_21_1:addChild(var_21_2)

		local var_21_3 = cc.Label:createWithTTF("", FONT_NAME, 21)

		var_21_3:setName("role_name")
		var_21_3:setColor(cc.c3b(255, 229, 194))
		var_21_2:setVisible(false)
		var_21_3:setPosition(var_21_1:getContentSize().width / 2, var_21_1:getContentSize().height / 2 - 70)
		var_21_1:addChild(var_21_3)

		local var_21_4 = cc.Label:createWithTTF("", FONT_NAME, 15)

		var_21_4:setName("name")
		var_21_4:setColor(cc.c3b(175, 150, 123))
		var_21_2:setVisible(false)
		var_21_4:setPosition(var_21_1:getContentSize().width / 2, var_21_1:getContentSize().height / 2 - 100)
		var_21_1:addChild(var_21_4)

		local var_21_5 = ccui.ImageView:create(self.layerName .. "/select.png", var_0_1)

		var_21_5:setName("select")
		var_21_5:setVisible(false)
		var_21_5:setPosition(var_21_1:getContentSize().width / 2, var_21_1:getContentSize().height / 2)
		var_21_1:addChild(var_21_5)
	end

	local var_21_6 = ccui.Button:create(self.layerName .. "/btn_share.png", nil, self.layerName .. "/btn_share.png", var_0_1)

	var_21_6:setPosition(cc.p(320, 60))
	var_21_0:addChild(var_21_6)

	local var_21_7 = cc.Label:createWithTTF(L_BUTTON_TEXT.Got, FONT_NAME, 18)

	var_21_7:setVisible(false)
	var_21_7:setPosition(var_21_6:getContentSize().width / 2, var_21_6:getContentSize().height / 2)
	var_21_6:addChild(var_21_7)
	activity_manager:get_activity_newyear2022_share(self.activityId, arg_21_1, function(arg_23_0)
		for iter_23_0, iter_23_1 in pairs(arg_23_0.rewardList) do
			local var_23_1 = var_21_0:getChildByName("box_" .. iter_23_0)
			local var_23_2 = var_23_1:getChildByName("icon")
			local var_23_3 = var_23_1:getChildByName("name")
			local var_23_4 = var_23_1:getChildByName("roleName")
			local var_23_5 = var_23_1:getChildByName("select")
			local var_23_6 = require(string.format("data.activity_%s.activity_newyear2022_reward_data", self.activityId))
			local var_23_7 = "equipment/" .. var_23_6[iter_23_1].image_id .. ".png"

			if item_data[shareRewardData[iter_23_1].itemid].bag_item_type == kITEM_HERO then
				var_23_3:setVisible(true)
				var_23_3:setString(var_23_6[iter_23_1].name or "shareRewardData 里需要填 name: " .. iter_23_1)
				var_23_4:setVisible(true)
				var_23_4:setString(var_23_6[iter_23_1].role_name or "shareRewardData 里需要填 role_name: " .. iter_23_1)

				var_23_7 = "roleimage/role/fight/" .. var_23_6[iter_23_1].image_id .. ".png"
			end

			var_23_2:loadTexture(var_23_7)
			var_23_2:setVisible(true)
			var_23_2:setScale(0.85)
			var_23_5:setVisible(iter_23_1 == arg_23_0.rewardIndex)

			self.selectRed = arg_23_0.rewardIndex

			var_23_1:addTouchEventListener(function(arg_24_0, arg_24_1)
				if arg_24_1 ~= ccui.TouchEventType.ended then
					return
				end

				if rewardLayout.selectImg then
					rewardLayout.selectImg:setVisible(false)
				end

				arg_24_0:getChildByName("select"):setVisible(true)

				rewardLayout.select = iter_23_0
				rewardLayout.selectImg = arg_24_0:getChildByName("select")
			end)
		end

		if arg_23_0.rewardIndex > 0 then
			var_21_7:setVisible(true)
			var_21_6:loadTextures(self.layerName .. "/btn_lock.png", nil, self.layerName .. "/btn_lock.png", var_0_1)
		elseif not arg_23_0.rewardList or #arg_23_0.rewardList < 4 then
			var_21_7:setVisible(false)
			var_21_6:loadTextures(self.layerName .. "/btn_share.png", nil, self.layerName .. "/btn_share.png", var_0_1)
		else
			var_21_7:setVisible(false)
			var_21_6:loadTextures(self.layerName .. "/btn_getreward.png", nil, self.layerName .. "/btn_getreward.png", var_0_1)
		end

		var_21_6:addTouchEventListener(function(arg_25_0, arg_25_1)
			if arg_25_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_23_0.rewardList or #arg_23_0.rewardList < 4 then
				self:doShare(arg_21_1)

				return
			end

			if not rewardLayout.select then
				global_ShowBlockWords(L_QINGXUANZE)

				return
			end

			activity_manager:recv_activity_newyear2022_share(self.activityId, arg_21_1, rewardLayout.select)
			rewardLayout:runAction(cc.RemoveSelf:create())
		end)
	end)
end

function PopActivityShareBaseLayer.taskTumpTo(arg_26_0, arg_26_1)
	if arg_26_1 == 130 then
		LayerManager:pushInLayer("SignLayerNew", {
			callback = function()
				activity_manager:getActivityTask(arg_26_0.activityId)
			end
		})
	elseif arg_26_1 == 111 then
		require("controller.sign_manager"):createMidasLayer(function()
			activity_manager:getActivityTask(arg_26_0.activityId)
		end)
	elseif arg_26_1 == 220 then
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
				activity_manager:getActivityTask(arg_26_0.activityId)
			end
		})
	elseif arg_26_1 == 300 then
		LayerManager:pushInLayer("EquipLayer", {
			exitCallback = function()
				activity_manager:getActivityTask(arg_26_0.activityId)
			end
		})
	elseif arg_26_1 then
		require("controller.goto_system_manager")

		local var_26_0 = {
			jump_to_system = arg_26_1
		}

		var_26_0.config = system_jump_config[SYSTEMID[arg_26_1]] and system_jump_config[SYSTEMID[arg_26_1]].config

		if var_26_0.config then
			if var_26_0.config.exitCallbackType == "function" then
				var_26_0.config.exitCallback = nil
			elseif var_26_0.config.exitCallbackType == "string" then
				var_26_0.config = "MainLayer"
			end
		end

		goto_complete_system(var_26_0)
	end
end

function PopActivityShareBaseLayer:doShare(arg_33_1)
	local var_33_1 = "https://192.168.8.52:8088/?redid=%s"

	activity_manager:get_activity_newyear2022_share(self.activityId, arg_33_1, function(arg_34_0)
		if share_manager:can_share(arg_33_1) and config.packagechannel ~= "palmpi" then
			local var_34_0 = string.format(var_33_1, arg_34_0.redCode, "s" .. account_manager:getServerID())

			share_manager:doShare(L_SHARE_TITLE_2022, nil, L_SHARE_DESC_2022 .. var_34_0, var_34_0)
		elseif cc.Native.copyStringToClipboard then
			self:showChannelShare(string.format(var_33_1, arg_34_0.redCode, "s" .. account_manager:getServerID()))
		else
			DeviceManager.openURL(string.format(var_33_1, arg_34_0.redCode, "s" .. account_manager:getServerID()))
		end
	end)
end

function PopActivityShareBaseLayer:showChannelShare(arg_35_1)
	local var_35_0 = self.rootLayer:getChildByName("channel_layout")

	if var_35_0 then
		var_35_0:setVisible(true)

		return
	end

	local var_35_1 = ccui.Layout:create()

	var_35_1:setBackGroundImageColor(cc.c3b(255, 255, 255))
	var_35_1:setContentSize(cc.size(cc.Director:getInstance():getVisibleSize().width, cc.Director:getInstance():getVisibleSize().height))
	var_35_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_35_1:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	var_35_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_35_1:setBackGroundColor(cc.c3b(0, 0, 0))
	var_35_1:setBackGroundColorOpacity(180)
	var_35_1:setTouchEnabled(true)
	var_35_1:setName("write_layout")
	var_35_1:addTouchEventListener(function(arg_36_0, arg_36_1)
		if arg_36_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_35_1:setVisible(false)
	end)
	self.rootLayer:addChild(var_35_1, 100)

	local var_35_2 = ccui.ImageView:create(self.layerName .. "/task_bg.png", var_0_1)

	var_35_2:setTouchEnabled(true)
	var_35_2:setPosition(var_35_1:getContentSize().width / 2, var_35_1:getContentSize().height / 2)
	var_35_1:addChild(var_35_2)

	local var_35_3 = cc.Label:createWithTTF("         距离班长开启元旦礼盒只差“一步”啦~ \n      点击下方“一键复制”并粘贴分享给其他班长，\n邀请4人成功拆解红包礼物即可获取元旦好礼！百分百中奖哦~\n\n" .. arg_35_1, FONT_NAME, 20)

	var_35_3:setPosition(var_35_2:getContentSize().width / 2, var_35_2:getContentSize().height / 2)
	var_35_2:addChild(var_35_3)

	local var_35_4 = ccui.Button:create(self.layerName .. "/btn_lock.png", nil, self.layerName .. "/btn_lock.png", var_0_1)

	var_35_4:setPosition(cc.p(320, 60))
	var_35_2:addChild(var_35_4)

	local var_35_5 = cc.Label:createWithTTF(L_COPY_TO_CLIPBOARD, FONT_NAME, 18)

	var_35_5:setPosition(var_35_4:getContentSize().width / 2, var_35_4:getContentSize().height / 2)
	var_35_4:addChild(var_35_5)
	var_35_4:addTouchEventListener(function(arg_37_0, arg_37_1)
		if arg_37_1 ~= ccui.TouchEventType.ended then
			return
		end

		cc.Native.copyStringToClipboard("魂器学院元旦宝箱,百分百中奖,点击即可抽取扭蛋券,翻牌道具等珍贵道具,领取戳我: " .. arg_35_1)
	end)
end

function PopActivityShareBaseLayer:initBG()
	self.bg = ccui.ImageView:create("mainScenebg/activity/branch" .. self.activityId .. "/share_bg.png")

	self.bg:setPosition(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2)
	self.rootLayer:addChild(self.bg, -1)

	self.rootpanel = self.rootLayer

	self.bg:setTouchEnabled(true)
	self.rootLayer:setTouchEnabled(true)
	self.bg:addTouchEventListener(function(arg_39_0, arg_39_1)
		if arg_39_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)
end

function PopActivityShareBaseLayer:exit(arg_40_1)
	self.hideActions.fadeOut(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end
