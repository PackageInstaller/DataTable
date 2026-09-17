PopActivityGameTaskLayer = class("PopActivityGameTaskLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local drop_manager = require("controller.drop_manager")
local activity_manager = require("controller.activity_manager")
local servant_data = require("data.servant_data")
local playermodel = require("model.playermodel")
local task_data = require("data.task_data")
local item_data = require("data.item_data")

local function var_0_7(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = ccui.ImageView:create()

	if item_data[arg_2_0].bag_item_type == kITEM_SKIN then
		var_2_0:loadTexture("roleimage/role1/" .. modelData[item_data[arg_2_0].model].cute_role .. ".png")
		var_2_0:setScale(0.3)
	elseif item_data[arg_2_0].bag_item_type == kITEM_HORCRUX then
		local var_2_1 = drop_manager:getAllDropsNotMerge(dropid)
		local var_2_2 = ccui.Layout:create()

		var_2_2:setName("starsPanel")
		var_2_2:setScale(1.75)
		var_2_2:setPositionY(58)
		var_2_2:setPositionX(200)
		var_2_0:addChild(var_2_2, 5)

		local var_2_3 = 0

		if arg_2_2 then
			for iter_2_0, iter_2_1 in arg_2_2:gmatch("([^&]+)=([^&]+)") do
				if iter_2_0 == "star" then
					var_2_3 = tonumber(iter_2_1)
				end
			end
		end

		for iter_2_2 = 1, var_2_3 do
			local var_2_4

			if config._DEBUG then
				var_2_4 = cc.Sprite:create("public/currency/weapon_star.png") or cc.Sprite:createWithSpriteFrameName("public/currency/weapon_star.png")
			end

			var_2_4:setPosition(25, (iter_2_2 - 1) * 24 - 30)
			var_2_2:addChild(var_2_4)
		end

		var_2_0:loadTexture("equipment/" .. item_data[arg_2_0].image_id .. ".png")
		var_2_0:setScale(0.3)
	elseif item_data[arg_2_0].bag_item_type == kITEM_COMPONENT then
		var_2_0:removeFromParent()

		var_2_0 = nil
		var_2_0 = componentManager:create_component_icon(arg_2_0)

		;(nil):setPosition(cc.p(self.championBg:getContentSize().width / 2, self.championBg:getContentSize().height / 2 + 20))
		var_2_0:setScale(0.75)
	else
		var_2_0:loadTexture("equipment/" .. item_data[arg_2_0].image_id .. ".png")
		var_2_0:setScale(0.75)
	end

	local var_2_5 = cc.Label:createWithTTF("", FONT_DES, 70)

	var_2_5:setString("x" .. arg_2_1)
	var_2_5:setPosition(80, 0)
	var_2_5:setName("num")
	var_2_0:addChild(var_2_5)
	var_2_0:setTouchEnabled(arg_2_3)
	var_2_0:addTouchEventListener(function(arg_3_0, arg_3_1)
		if arg_3_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_data[arg_2_0].bag_item_type == kITEM_HORCRUX then
			showHorcruxDetails(arg_2_0)
		else
			LayerManager:pushInLayer("PopItemLayer", {
				itemid = arg_2_0
			})
		end
	end)

	return var_2_0, arg_2_1
end

function PopActivityGameTaskLayer.create(arg_4_0, arg_4_1)
	local var_4_0 = PopActivityGameTaskLayer.new()

	var_4_0:initBg(arg_4_1)

	return var_4_0
end

function PopActivityGameTaskLayer:init(arg_5_1)
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2 - GameDisplay.fix_y))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootLayer)

	self.activityId = arg_5_1.activityId
	self.uiconfmodule = arg_5_1.uiconfmodule
	self.ui_data = self:getUIConf()
	self.ui_conf = self.ui_data.uiconf
	self._imagePath = string.format(self.ui_data.uipath, self.activityId)

	TextureManager:loadLayerTextures({
		self._imagePath
	})
	self:initUI()
	self:registerActivityEventListener()

	if type(self.ui_data.taskmodule) == "string" then
		self.usemodule = self.ui_data.taskmodule or self.ui_data.taskmodule[1]
	end

	self.isswitching = true

	local var_5_0 = activity_manager:getActivityObj(self.activityId)

	function self.getTaskListCallback(arg_6_0, arg_6_1)
		if arg_6_0 ~= 1 then
			return
		end

		self.taskList = {}

		for iter_6_0, iter_6_1 in pairs(arg_6_1.list) do
			iter_6_1.name = task_data[iter_6_1.taskid].name
			iter_6_1.task_des = task_data[iter_6_1.taskid].task_des
			iter_6_1.image = task_data[iter_6_1.taskid].image
			iter_6_1.drop = task_data[iter_6_1.taskid].drop
			iter_6_1.jump = task_data[iter_6_1.taskid].jump
			iter_6_1.order = task_data[iter_6_1.taskid].order

			if iter_6_1.status == 1 then
				iter_6_1.percent = -1
			end

			table.insert(self.taskList, iter_6_1)
		end

		table.sort(self.taskList, function(arg_7_0, arg_7_1)
			if arg_7_0.percent == arg_7_1.percent then
				return arg_7_0.order < arg_7_1.order
			else
				return arg_7_0.percent > arg_7_1.percent
			end
		end)
		self:updateTask()
		activity_manager:update_alert(self.activityId, self.usemodule, self.taskList)

		self.isswitching = false

		self:updateModuleBtns()

		if self.moduleTitle then
			self.moduleTitle:loadTexture(self._imagePath .. "/module_title_" .. self.usemodule .. ".png", var_0_0)
		end
	end

	if var_5_0 then
		var_5_0:getActivityTaskList(nil, self.getTaskListCallback, false, nil, self.usemodule)
	end

	self:registerScriptHandler(function(arg_8_0)
		if arg_8_0 == "exit" then
			activity_manager:releaseEventListenerByName("PopActivityGameTaskLayer")
			TextureManager:removeLayerTextures({
				self._imagePath
			})
		end
	end)
	self:initmoduleBtn()
	self:initOtherUI()
end

function PopActivityGameTaskLayer:getUIConf()
	local activity_gametask_uiconfig_data = require("data.activity_template_ui_conf.activity_gametask_uiconfig_data")

	return activity_gametask_uiconfig_data[self.uiconfmodule .. "_" .. self.activityId] or activity_gametask_uiconfig_data[self.uiconfmodule]
end

function PopActivityGameTaskLayer.registerActivityEventListener(arg_10_0)
	activity_manager:registerEventListener("PopActivityGameTaskLayer", activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_11_0)
		activity_manager:getActivityObj(arg_10_0.activityId):getActivityTaskList(nil, arg_10_0.getTaskListCallback, false, nil, arg_10_0.usemodule)
	end)
end

function PopActivityGameTaskLayer:initUI()
	self:initExitTouchEvent()
	self:initTitle()
	self:playJoinInEffect()
end

function PopActivityGameTaskLayer:initmoduleBtn()
	if type(self.ui_data.taskmodule) == "string" or #self.ui_data.taskmodule == 1 then
		return
	end

	self.modulebtns = {}

	for iter_13_0, iter_13_1 in ipairs(self.ui_data.taskmodule) do
		local var_13_0 = ccui.Button:create(self._imagePath .. "/" .. self.ui_conf["modulebtn_" .. iter_13_0 .. "_name"] .. "_on.png", nil, self._imagePath .. "/" .. self.ui_conf["modulebtn_" .. iter_13_0 .. "_name"] .. "_on.png", var_0_0)

		var_13_0:setPosition(self.ui_conf["taskmodule_" .. iter_13_0 .. "_pos"])
		self.panelBg:addChild(var_13_0)
		var_13_0:addTouchEventListener(function(arg_14_0, arg_14_1)
			if arg_14_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.usemodule == iter_13_1 then
				return
			end

			if self.isswitching then
				return
			end

			self.isswitching = true
			self.usemodule = iter_13_1

			activity_manager:getActivityObj(self.activityId):getActivityTaskList(nil, self.getTaskListCallback, false, nil, self.usemodule)
		end)

		var_13_0.usemodule = iter_13_1
		var_13_0.btnname = self.ui_conf["modulebtn_" .. iter_13_0 .. "_name"]

		table.insert(self.modulebtns, var_13_0)
	end
end

function PopActivityGameTaskLayer:initOtherUI()
	if self.ui_data.uiconf.moduleTitlePos then
		self.moduleTitle = ccui.ImageView:create(self._imagePath .. "/module_title_" .. self.usemodule .. ".png", var_0_0)

		self.panelBg:addChild(self.moduleTitle)
		self.moduleTitle:setPosition(self.ui_data.uiconf.moduleTitlePos)
	end

	if self.ui_data.uiconf.closeBtnPos then
		self.close_btn = ccui.Button:create(self._imagePath .. "/close_btn.png", nil, self._imagePath .. "/close_btn.png", var_0_0)

		self.panelBg:addChild(self.close_btn)
		self.close_btn:setPosition(self.ui_data.uiconf.closeBtnPos)
		self.close_btn:addTouchEventListener(function(arg_16_0, arg_16_1)
			if arg_16_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:exit()
		end)
	end
end

function PopActivityGameTaskLayer:updateModuleBtns()
	if not self.modulebtns or not next(self.modulebtns) then
		return
	end

	for iter_17_0, iter_17_1 in ipairs(self.modulebtns) do
		if self.usemodule == iter_17_1.usemodule then
			iter_17_1:loadTextures(self._imagePath .. "/" .. iter_17_1.btnname .. "_on.png", nil, self._imagePath .. "/" .. iter_17_1.btnname .. "_on.png", var_0_0)
		else
			iter_17_1:loadTextures(self._imagePath .. "/" .. iter_17_1.btnname .. "_off.png", nil, self._imagePath .. "/" .. iter_17_1.btnname .. "_off.png", var_0_0)
		end
	end
end

function PopActivityGameTaskLayer:initExitTouchEvent()
	self.rootLayer:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_19_0:isBright() then
			return
		end

		arg_19_0:setBright(false)
		self:exit()
	end)
end

function PopActivityGameTaskLayer:initTitle()
	self.panelBg = ccui.ImageView:create(self._imagePath .. "/task_bg.png", var_0_0)

	self.panelBg:setTouchEnabled(true)
	self.panelBg:setPosition(cc.p(320, GameDisplay.getScreenSize().height / 2 + 50))
	self.rootLayer:addChild(self.panelBg)
end

function PopActivityGameTaskLayer:updateTask()
	if self.taksView then
		self.taksView:reloadData()

		return
	end

	self.taksView = cc.TableView:create(self.ui_conf.taskviewSize)

	self.taksView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taksView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taksView:setAnchorPoint(cc.p(0, 0))
	self.taksView:setPosition(self.ui_conf.taskviewPos)
	self.taksView:setDelegate()
	self.panelBg:addChild(self.taksView)
	self.taksView:registerScriptHandler(function(arg_23_0, arg_23_1)
		return self.ui_conf.taskspriteSize.width, self.ui_conf.taskspriteSize.height
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taksView:registerScriptHandler(function(arg_22_0, arg_22_1)
		local var_22_0 = arg_22_0:dequeueCell()

		if not var_22_0 then
			var_22_0 = cc.TableViewCell:create()

			local var_22_2 = self:createTaskSprite(self.taskList[arg_22_1 + 1], arg_22_1 + 1)

			var_22_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_22_2:setPosition(self.ui_conf.taskspritePos)
			var_22_0:addChild(var_22_2)
		else
			self:updateTaskSprite(var_22_0:getChildByTag(100), self.taskList[arg_22_1 + 1], arg_22_1 + 1)
		end

		return var_22_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taksView:registerScriptHandler(function(arg_24_0, arg_24_1)
		return #self.taskList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.taksView:reloadData()
end

function PopActivityGameTaskLayer:createTaskSprite(arg_25_1, arg_25_2)
	local var_25_0 = ccui.ImageView:create(self._imagePath .. "/task_bottom.png", var_0_0)

	var_25_0:setTag(100)

	local var_25_1 = cc.Label:createWithTTF(arg_25_1.name, FONT_NAME, 24)

	var_25_1:setColor(self.ui_conf.taskspriteColor)
	var_25_1:setAnchorPoint(cc.p(0, 0.5))
	var_25_1:setPosition(self.ui_conf.taskspriteTitlePos or cc.p(15, 95))
	var_25_1:setName("title")
	var_25_0:addChild(var_25_1)

	local var_25_2 = cc.Label:createWithTTF(arg_25_1.task_des, FONT_NAME, 20)

	var_25_2:setColor(self.ui_conf.taskspriteColor)
	var_25_2:setAnchorPoint(cc.p(0, 0.5))
	var_25_2:setPosition(self.ui_conf.taskspriteDesPos or cc.p(15, 60))
	var_25_2:setName("des")
	var_25_0:addChild(var_25_2)
	self:createTaskSpriteReward(var_25_0, arg_25_1.drop)

	local var_25_3 = self._imagePath .. "/btn_goto.png"

	if arg_25_1.status >= 1 then
		var_25_3 = self._imagePath .. "/btn_got.png"
	elseif arg_25_1.percent >= 100 then
		var_25_3 = self._imagePath .. "/btn_get_reward.png"
	end

	local var_25_4 = ccui.Button:create(var_25_3, nil, var_25_3, var_0_0)

	var_25_4:setPosition(self.ui_conf.taskspriteBtnPos)
	var_25_4:setName("btn")
	var_25_0:addChild(var_25_4)
	var_25_4:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_25_1.status >= 1 then
			return
		end

		if arg_25_1.percent >= 100 then
			activity_manager:getArtTaskReward(self.activityId, arg_25_1.taskid)
		else
			self:taskTumpTo(arg_25_1.jump)
		end
	end)

	local var_25_5 = ccui.Slider:create()

	var_25_5:loadBarTexture(self._imagePath .. "/progress_bg.png", var_0_0)
	var_25_5:loadProgressBarTexture(self._imagePath .. "/progress_on.png", var_0_0)
	var_25_5:setPosition(self.ui_conf.progressPos)
	var_25_5:setPercent(arg_25_1.percent)
	var_25_5:setName("progressBar")

	if arg_25_1.status == 1 then
		var_25_5:setPercent(100)
	end

	var_25_0:addChild(var_25_5)

	local var_25_7 = cc.Label:createWithTTF((arg_25_1.percent >= 0 or nil) and (arg_25_1.finished > arg_25_1.need and string.format("%s/%s", arg_25_1.need, arg_25_1.need) or string.format("%s/%s", arg_25_1.finished, arg_25_1.need)), FONT_NAME, 20)

	var_25_7:setAnchorPoint(0, 0.5)
	var_25_7:setAnchorPoint(cc.p(1, 0.5))
	var_25_7:setPosition(self.ui_conf.percentPos)
	var_25_7:setName("percent")
	var_25_7:setVisible(arg_25_1.percent >= 0)
	var_25_7:setColor(self.ui_conf.taskspriteColor)
	var_25_0:addChild(var_25_7)

	if self._imagePath == "CommonTaskAirPlane" then
		local var_25_8 = ccui.ImageView:create(self._imagePath .. "/label_bg.png", var_0_0)

		var_25_8:setAnchorPoint(0, 0)
		icon_bg:addChild(var_25_8)

		local var_25_9 = sp:getChildByName("num")

		var_25_9:setPosition(60, -40)
		var_25_9:setScale(0.6)
	end

	return var_25_0
end

function PopActivityGameTaskLayer:updateTaskSprite(arg_27_1, arg_27_2, arg_27_3)
	arg_27_1:setTag(100)
	arg_27_1:getChildByName("title"):setString(arg_27_2.name)

	local var_27_0 = drop_manager:getAllDrops(arg_27_2.drop)

	arg_27_1:getChildByName("des"):setString(arg_27_2.task_des)

	local var_27_1 = self._imagePath .. "/btn_goto.png"

	if arg_27_2.status >= 1 then
		var_27_1 = self._imagePath .. "/btn_got.png"
	elseif arg_27_2.percent >= 100 then
		var_27_1 = self._imagePath .. "/btn_get_reward.png"
	end

	arg_27_1:getChildByName("btn"):loadTextures(var_27_1, nil, var_27_1, var_0_0)
	arg_27_1:getChildByName("progressBar"):setPercent(arg_27_2.percent)

	if arg_27_2.status == 1 then
		arg_27_1:getChildByName("progressBar"):setPercent(100)
	end

	if arg_27_2.percent >= 0 then
		arg_27_1:getChildByName("percent"):setString(arg_27_2.finished > arg_27_2.need and string.format("%s/%s", arg_27_2.need, arg_27_2.need) or string.format("%s/%s", arg_27_2.finished, arg_27_2.need))
	end

	arg_27_1:getChildByName("percent"):setVisible(arg_27_2.percent >= 0)
	arg_27_1:getChildByName("btn"):addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_27_2.status >= 1 then
			return
		end

		if arg_27_2.percent >= 100 then
			activity_manager:getArtTaskReward(self.activityId, arg_27_2.taskid)
		else
			self:taskTumpTo(arg_27_2.jump)
		end
	end)
	self:createTaskSpriteReward(arg_27_1, arg_27_2.drop)

	if self._imagePath == "CommonTaskAirPlane" then
		local var_27_3 = ccui.ImageView:create(self._imagePath .. "/label_bg.png", var_0_0)

		var_27_3:setAnchorPoint(0, 0)
		arg_27_1:getChildByName("icon_bg"):addChild(var_27_3)

		local var_27_4 = sp:getChildByName("num")

		var_27_4:setPosition(60, -40)
		var_27_4:setScale(0.6)
	end
end

function PopActivityGameTaskLayer:taskTumpTo(arg_29_1)
	if arg_29_1 then
		require("controller.goto_system_manager")
		goto_complete_system({
			jump_to_system = arg_29_1
		})
	else
		self:exit()
	end
end

function PopActivityGameTaskLayer:playJoinInEffect()
	self.rootLayer:setOpacity(0)
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeIn:create(0.2)))
end

function PopActivityGameTaskLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopActivityGameTaskLayer:initBg(arg_33_1)
	local var_33_0 = ccui.Layout:create()

	var_33_0:setTouchEnabled(true)
	var_33_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_33_0:setAnchorPoint(cc.p(0, 0))
	var_33_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_33_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_33_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_33_0:setOpacity(0)
	self:addChild(var_33_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_34_0)
		self:addChild(arg_34_0, -2)
		arg_34_0:setPositionY(arg_34_0:getPositionY() - GameDisplay.fix_y)

		local var_34_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_34_0:setAnchorPoint(cc.p(0, 0))
		var_34_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_34_0, -1)
		self:init(arg_33_1)
		var_33_0:setOpacity(102)
		var_33_0:setTouchEnabled(false)
	end)
end

function PopActivityGameTaskLayer:createTaskSpriteReward(arg_35_1, arg_35_2)
	if arg_35_1:getChildByName("icon_bg") then
		arg_35_1:getChildByName("icon_bg"):removeFromParent()
	end

	if arg_35_1:getChildByName("icon_list") then
		arg_35_1:getChildByName("icon_list"):removeFromParent()
	end

	local var_35_0 = drop_manager:getDropMsg(arg_35_2)

	if #var_35_0.equips == 1 then
		local var_35_1 = ccui.ImageView:create(self._imagePath .. "/task_reward_bg.png", var_0_0)

		arg_35_1:addChild(var_35_1)
		var_35_1:setPosition(self.ui_conf.taskspriteSpPos)
		var_35_1:setName("icon_bg")

		local var_35_2 = var_0_7(var_35_0.equips[1].dropid, var_35_0.equips[1].dropNum, var_35_0.equips[1].item_attr, true)

		var_35_1:addChild(var_35_2)
		var_35_2:setScale(0.3)
		var_35_2:setName("sp")
		var_35_2:setPosition(cc.p(30, 40))
	else
		local var_35_3 = ccui.ListView:create()

		var_35_3:setDirection(ccui.ListViewDirection.horizontal)
		var_35_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_35_3:setPosition(self.ui_conf.taskspriteSpPos)
		var_35_3:setContentSize(cc.size(140, 70))
		var_35_3:setItemsMargin(5)
		arg_35_1:addChild(var_35_3)
		var_35_3:setName("icon_list")

		for iter_35_0, iter_35_1 in pairs(var_35_0.equips) do
			local var_35_4 = ccui.ImageView:create(self._imagePath .. "/task_reward_bg.png", var_0_0)
			local var_35_5 = var_0_7(iter_35_1.dropid, iter_35_1.dropNum, iter_35_1.item_attr, true)

			var_35_4:addChild(var_35_5)
			var_35_5:setScale(0.3)
			var_35_5:setName("sp")
			var_35_5:setPosition(cc.p(30, 40))
			var_35_3:pushBackCustomItem(var_35_4)
		end
	end
end
