TaskLayer = class("TaskLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Sprite.BottomBtnList")

local task_manager = require("controller.task_manager")
local drop_manager = require("controller.drop_manager")
local item_data = require("data.item_data")
local task_data = require("data.task_data")
local image_data = require("data.image_data")
local playermodel = require("model.playermodel")
local var_0_6 = config._DEBUG and 0 or 1
local var_0_7 = {
	[TASK_TYPE_ACHIEVE] = false
}
local var_0_8
local var_0_9
local var_0_10 = false
local var_0_11 = TASK_TYPE_NORMAL
local var_0_12 = cc.p(96, 80)
local var_0_13 = "mainScenebg/task_img/"

function TaskLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = TaskLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function TaskLayer:init(arg_3_1)
	var_0_8 = self

	if arg_3_1 then
		self.curType = arg_3_1.taskType
	end

	self.curType = self.curType or var_0_9 or TASK_TYPE_ACHIEVE
	var_0_9 = nil
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "TaskLayer.json" or "TaskLayer.ExportJson")

	self:addChild(self.rootLayer)
	require("view.Sprite.TitleSprite")

	local var_3_0 = TitleSprite:create("public/title/Task.png", 2)

	var_3_0:setPosition(0, 1080)
	self.rootLayer:addChild(var_3_0, 25)

	self.completeNum = ccui.Helper:seekWidgetByName(self.rootLayer, "complete_num")
	self.complete_label = ccui.Helper:seekWidgetByName(self.rootLayer, "complete_label")
	self.diamondPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_diamond")
	self.panel_tab = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_tab")

	self.panel_tab:removeAllItems()
	self.panel_tab:setContentSize(65, 1070)
	self.panel_tab:setItemsMargin(0)

	self.taskPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "label_exp")

	self.taskPanel:retain()
	self.taskPanel:removeFromParent()
	self:initBottomList()
	self:initTaskList()
	self:initDiamondNum()

	var_0_10 = true

	task_manager:get_task_info(function()
		var_0_10 = false

		self:switchTaskList(self.curType)
		self:updateTaskAlert()
	end)
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			var_0_10 = false

			if self.taskPanel then
				self.taskPanel:release()
			end

			if not var_0_7[TASK_TYPE_ACHIEVE] then
				AlertManager:unregister_alert(ALERT_TASK)
			end

			var_0_8 = nil
		end
	end)
end

function TaskLayer:initBottomList()
	self.rootLayer:addChild(BottomBtnList:create(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end, buttonsList), 5)
end

function TaskLayer.createButton(arg_8_0, arg_8_1)
	local var_8_0 = ccui.Button:create()

	var_8_0:setSwallowTouches(false)
	var_8_0:setName(arg_8_1)
	var_8_0:loadTextures("public/button/selected_tab_mid.png", "public/button/selected_tab_mid.png", "", var_0_6)
	var_8_0:setAnchorPoint(cc.p(0.5, 0.5))

	local var_8_1 = cc.Label:createWithTTF(({
		[TASK_TYPE_DAILY] = L_TASK_TYPE_BTN.TASK_TYPE_DAILY,
		[TASK_TYPE_NORMAL] = L_TASK_TYPE_BTN.TASK_TYPE_NORMAL,
		[TASK_TYPE_ACHIEVE] = L_TASK_TYPE_BTN.TASK_TYPE_ACHIEVE,
		[TASK_TYPE_CAREER] = L_TASK_TYPE_BTN.TASK_TYPE_CAREER
	})[arg_8_1], "fonts/newkj.ttf", 25)

	var_8_1:setName("text")
	var_8_1:setColor(cc.c3b(152, 156, 183))
	var_8_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_8_1:setPosition(var_8_0:getContentSize().width / 2 - 7, var_8_0:getContentSize().height / 2 + 10)
	var_8_0:addChild(var_8_1)

	return var_8_0
end

function TaskLayer:initSwitchButtons()
	self.buttons = {
		[TASK_TYPE_ACHIEVE] = self:createButton(TASK_TYPE_ACHIEVE)
	}

	local var_9_0 = TASK_TYPE_ACHIEVE

	self.panel_tab:pushBackCustomItem(self.buttons[TASK_TYPE_ACHIEVE])
	self.buttons[TASK_TYPE_ACHIEVE]:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_0_10 then
			return
		end

		if math.abs(arg_10_0:getTouchBeganPosition().y - arg_10_0:getTouchEndPosition().y) > 50 then
			return
		end

		if var_9_0 == self.curType then
			return
		end

		self:switchTaskList(var_9_0)
	end)
end

function TaskLayer.updateTaskAlert(arg_11_0)
	return
end

function TaskLayer:initTaskList()
	self.taskList = cc.TableView:create(cc.size(589, 1030))

	self.taskList:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taskList:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taskList:setAnchorPoint(cc.p(0, 0))
	self.taskList:setPosition(28, 50)
	self.taskList:setDelegate()
	self.rootLayer:addChild(self.taskList)

	self.curtaskListLen = 0

	self.taskList:registerScriptHandler(function(arg_13_0, arg_13_1)
		return 569, 150
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taskList:registerScriptHandler(function(arg_14_0, arg_14_1)
		local var_14_0 = arg_14_0:dequeueCell()

		if not var_14_0 then
			var_14_0 = cc.TableViewCell:create()

			local var_14_1 = self:createTaskInfoPanel(task_manager:dequeueTaskInfo(self.curType, arg_14_1 + 1))

			var_14_1:setName("taskinfo")
			var_14_1:setPosition(cc.p(0, 0))

			if arg_14_0.withaction and arg_14_1 < 7 then
				var_14_1:setOpacity(0)
				var_14_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_14_1), cc.FadeIn:create(0.1)))
			end

			var_14_0:addChild(var_14_1)
		else
			var_14_0:getChildByName("taskinfo"):updateTaskInfo(task_manager:dequeueTaskInfo(self.curType, arg_14_1 + 1))

			if arg_14_0.withaction and arg_14_1 < 7 then
				var_14_0:getChildByName("taskinfo"):setOpacity(0)
				var_14_0:getChildByName("taskinfo"):runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_14_1), cc.FadeIn:create(0.1)))
			end
		end

		return var_14_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taskList:registerScriptHandler(function(arg_15_0, arg_15_1)
		return self.curtaskListLen
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.taskList:reloadData()
end

function TaskLayer:switchTaskList(arg_16_1)
	self.curType = arg_16_1
	var_0_11 = self.curType
	self.taskList.withaction = true
	var_0_10 = true

	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		var_0_10 = false
		self.taskList.withaction = false
	end)))
	self:updateTaskList()
end

function TaskLayer:updateTaskList()
	self.curtaskListLen = task_manager:getTaskListLen(self.curType)

	self.completeNum:setString(task_manager:getTaskFinishLen(self.curType) .. "/" .. task_manager:getTaskListMaxLen(self.curType))
	self.complete_label:setPosition(self.completeNum:getPositionX() - self.completeNum:getContentSize().width - 5, self.completeNum:getPositionY())
	self.taskList:reloadData()
end

function TaskLayer:updateDailyTaskList()
	if self.curType ~= TASK_TYPE_DAILY then
		return
	end

	self:updateTaskList()
end

local function var_0_14(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = ccui.ImageView:create(arg_20_0, var_0_6)

	if arg_20_2 then
		var_20_0:setContentSize(arg_20_2)
		var_20_0:ignoreContentAdaptWithSize(false)
	end

	local var_20_1 = cc.Label:createWithTTF(arg_20_1, "fonts/new1.ttf", 20)

	var_20_1:setColor(cc.c3b(184, 201, 223))
	var_20_1:setAnchorPoint(cc.p(0, 0.5))
	var_20_1:setPosition(var_20_0:getContentSize().width, var_20_0:getContentSize().height / 2)
	var_20_0:addChild(var_20_1)

	local var_20_2 = ccui.Layout:create()

	var_20_2:setContentSize(cc.size(var_20_0:getContentSize().width + var_20_1:getContentSize().width, var_20_0:getContentSize().height))
	var_20_0:setAnchorPoint(cc.p(0, 0))
	var_20_0:setPosition(0, 0)
	var_20_2:addChild(var_20_0)

	return var_20_2
end

local function var_0_15(arg_21_0)
	local var_21_0 = cc.Label:createWithTTF(arg_21_0, "fonts/new1.ttf", 20)

	var_21_0:setColor(cc.c3b(184, 201, 223))

	local var_21_1 = ccui.Layout:create()

	var_21_1:setContentSize(cc.size(var_21_0:getContentSize().width, var_21_0:getContentSize().height))
	var_21_0:setAnchorPoint(cc.p(0, 0))
	var_21_0:setPosition(0, 0)
	var_21_1:addChild(var_21_0)

	return var_21_1
end

local var_0_16 = {
	"equipment/medal1.png",
	"equipment/medal2.png",
	"equipment/medal3.png",
	"equipment/medal4.png",
	"equipment/medal5.png",
	"equipment/medal6.png"
}
local var_0_17 = {
	cc.c4b(50, 150, 220, 150),
	cc.c4b(54, 255, 82, 150),
	cc.c4b(56, 122, 255, 150),
	cc.c4b(255, 12, 246, 150),
	cc.c4b(255, 84, 0, 150),
	cc.c4b(255, 0, 0, 150)
}
local var_0_18 = {
	"medal_1",
	"medal_2",
	"medal_3",
	"medal_4",
	"medal_5"
}

local function var_0_19()
	local var_22_0 = cc.Label:createWithTTF(L_SOUL, FONT_DES, 54)

	var_22_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_22_0:enableOutline(var_0_17[1], 1)
	var_22_0:enableShadow(var_0_17[1], cc.size(0, 0))
	var_22_0:setName("medal")

	return var_22_0
end

function TaskLayer:createTaskInfoPanel(arg_23_1)
	local var_23_0 = self.taskPanel:clone()

	function var_23_0:updateTaskInfo(arg_24_1)
		if type(arg_24_1) == "number" then
			self:updateFinishedTask(arg_24_1)
		elseif type(arg_24_1) == "table" then
			self:updateTriggeredTask(arg_24_1)
		end
	end

	function var_23_0:updateFinishedTask(arg_25_1)
		if task_data[arg_25_1].medal_id then
			local var_25_0 = self:getChildByName("medal")

			if not var_25_0 then
				var_25_0 = var_0_19()

				var_25_0:setPosition(var_0_12)
				self:addChild(var_25_0)
			end

			var_25_0:setVisible(true)

			local var_25_1 = item_data[tonumber(task_data[arg_25_1].medal_id)]

			var_25_0:setTexture(var_0_16[var_25_1.equip_quality])
			var_25_0:setString(var_25_1.name)
			var_25_0:enableOutline(var_0_17[var_25_1.equip_quality], 1)
			var_25_0:enableShadow(var_0_17[var_25_1.equip_quality], cc.size(0, 0))
			var_25_0:setVisible(var_25_1.only_bg ~= 1)
		end

		self:getChildByName("name"):setString(task_data[arg_25_1].name)
		self:getChildByName("des"):setString(task_data[arg_25_1].task_des)
		self:getChildByName("Image_task"):loadTexture(var_0_13 .. var_0_18[medalInfo.equip_quality] .. ".png", var_0_6)
		self:getChildByName("button_goto"):setVisible(false)
		self:getChildByName("button_getAwards"):setVisible(false)
		self:getChildByName("button_done"):setVisible(true)
		self:getChildByName("ProgressBar"):setPercent(100)
		self:getChildByName("ProgressBar"):getChildByName("Label_percent"):setString("100%")
		self:updateAwardList(arg_25_1)
	end

	function var_23_0:updateTriggeredTask(arg_26_1)
		local var_26_0 = arg_26_1.taskid
		local var_26_1 = task_data[arg_26_1.taskid]
		local var_26_2 = item_data[tonumber(task_data[arg_26_1.taskid].medal_id)]

		self:getChildByName("name"):setString(task_data[arg_26_1.taskid].name)
		self:getChildByName("des"):setString(task_data[arg_26_1.taskid].task_des)
		self:getChildByName("Image_task"):loadTexture(var_0_13 .. var_0_18[var_26_2.equip_quality] .. ".png", var_0_6)
		self:getChildByName("button_done"):setVisible(false)

		if task_data[arg_26_1.taskid].medal_id then
			local var_26_3 = self:getChildByName("medal")

			if not var_26_3 then
				var_26_3 = var_0_19()

				var_26_3:setPosition(var_0_12)
				self:addChild(var_26_3)
			end

			var_26_3:setVisible(true)
			var_26_3:setTexture(var_0_16[var_26_2.equip_quality])
			var_26_3:setString(var_26_2.name)
			var_26_3:enableOutline(var_0_17[var_26_2.equip_quality], 1)
			var_26_3:enableShadow(var_0_17[var_26_2.equip_quality], cc.size(0, 0))
			var_26_3:setVisible(var_26_2.only_bg ~= 1)
		end

		if arg_26_1.percent < 100 then
			self:getChildByName("button_goto"):setVisible(true)
			self:getChildByName("ProgressBar"):setPercent(arg_26_1.percent)
			self:getChildByName("ProgressBar"):getChildByName("Label_percent"):setString(arg_26_1.percent .. "%")
			self:getChildByName("button_goto"):addTouchEventListener(function(arg_27_0, arg_27_1)
				if arg_27_1 ~= ccui.TouchEventType.ended then
					return
				end

				print("curData.jump = ", var_26_1.jump)

				if var_26_1.jump == 130 then
					require("controller.sign_manager"):createSignLayer()
				elseif var_26_1.jump == 111 then
					require("controller.sign_manager"):createMidasLayer()
				else
					var_0_9 = self.curType

					require("controller.goto_system_manager")

					local var_27_0 = {
						jump_to_system = var_26_1.jump
					}

					var_27_0.config = system_jump_config[SYSTEMID[var_26_1.jump]] and system_jump_config[SYSTEMID[var_26_1.jump]].config

					if var_27_0.config then
						if var_27_0.config.exitCallbackType == "function" then
							var_27_0.config.exitCallback = createExitCallback({
								jump_to_system = 400,
								config = {
									taskType = self.curType
								}
							})
						end

						if var_27_0.config.exitCallbackType == "string" then
							var_27_0.config = "TaskLayer"
						end
					end

					goto_complete_system(var_27_0)
				end
			end)
			self:getChildByName("button_getAwards"):setVisible(false)
		else
			self:getChildByName("button_goto"):setVisible(false)
			self:getChildByName("button_getAwards"):setVisible(true)
			self:getChildByName("ProgressBar"):setPercent(arg_26_1.percent)
			self:getChildByName("ProgressBar"):getChildByName("Label_percent"):setString(arg_26_1.percent .. "%")
			self:getChildByName("button_getAwards"):addTouchEventListener(function(arg_28_0, arg_28_1)
				if arg_28_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_28_0:isBright() then
					return
				end

				if var_0_10 then
					return
				end

				arg_28_0:setBright(false)

				var_0_10 = true

				self:confirmAwards(var_26_0, arg_28_0)
			end)
		end

		self:updateAwardList(arg_26_1.taskid)
	end

	function var_23_0:updateAwardList(arg_29_1)
		local var_29_0 = self:getChildByName("reward_list")
		local var_29_1 = drop_manager:getDropMsg(task_data[arg_29_1].drop)

		var_29_0:setItemsMargin(10)
		var_29_0:removeAllItems()

		if var_29_1.diamond and var_29_1.diamond > 0 then
			var_29_0:pushBackCustomItem(var_0_14(IMAGE_DIAMOND, "X" .. var_29_1.diamond))
		end

		if var_29_1.gold and var_29_1.gold > 0 then
			var_29_0:pushBackCustomItem(var_0_14(IMAGE_GOLD, "X" .. var_29_1.gold, cc.size(43, 30)))
		end

		if var_29_1.equips then
			for iter_29_0, iter_29_1 in pairs(var_29_1.equips) do
				var_29_0:pushBackCustomItem(var_0_15(item_data[iter_29_1.dropid].name .. "X" .. iter_29_1.dropNum))
			end
		end
	end

	var_23_0:updateTaskInfo(arg_23_1)

	return var_23_0
end

function TaskLayer.confirmAwards(arg_30_0, arg_30_1, arg_30_2)
	task_manager:getTaskReward(arg_30_1, function(arg_31_0, arg_31_1)
		if arg_31_0 == 1 then
			global_gain(arg_31_1)

			while arg_31_1.items[1] do
				if item_data[arg_31_1.items[1].itemid].bag_item_type == 64 then
					require("view.Layer.GetRoleAnimationLayer")
					cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(arg_31_1.items[1].itemid), 1000)
				end
			end

			var_0_10 = false

			if not var_0_8 then
				return
			end

			arg_30_2:setBright(true)
			arg_30_0:updateTaskList()
			arg_30_0:updateTaskAlert()

			if arg_31_1 and arg_31_1.diamond and arg_31_1.diamond > 0 then
				arg_30_0:showGetDiamondAni(function()
					if var_0_8 then
						arg_30_0:updateDiamondNum()
					end
				end)
			end
		elseif arg_31_0 == 0 then
			arg_30_2:setBright(true)

			var_0_10 = false
		end
	end)
end

function TaskLayer.showGetDiamondAni(arg_33_0, arg_33_1)
	require("controller.audio_manager"):playeffectMusicTest("sound/gain_diamond")
	cc.SpriteFrameCache:getInstance():addSpriteFrames("effect/gain_diamond/jinbi.plist")
	cc.SpriteFrameCache:getInstance():addSpriteFrames("effect/gain_diamond/feizou.plist")

	local var_33_0 = cc.Sprite:createWithSpriteFrameName("jinbi01.png")

	var_33_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_33_0:setPosition(320, 568)
	var_33_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
		local var_34_0 = cc.Sprite:createWithSpriteFrameName("feizou_00001.png")

		var_34_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_34_0:setPosition(270, 468)
		var_34_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.6666666666666666), cc.CallFunc:create(arg_33_1), cc.RemoveSelf:create()))

		local var_34_1 = cc.Animation:create()

		for iter_34_0 = 1, 14 do
			var_34_1:addSpriteFrame((cc.SpriteFrameCache:getInstance():getSpriteFrame(string.format("feizou_%05d.png", iter_34_0))))
		end

		var_34_1:setDelayPerUnit(0.047619047619047616)
		var_34_1:setRestoreOriginalFrame(false)
		var_34_0:runAction(cc.Animate:create(var_34_1))
		var_34_0:runAction(cc.MoveTo:create(0.6666666666666666, cc.p(540, 1107)))
		global_basic_scene:addChild(var_34_0, 100000)
	end), cc.RemoveSelf:create()))

	local var_33_1 = cc.Animation:create()

	for iter_33_0 = 1, 7 do
		var_33_1:addSpriteFrame((cc.SpriteFrameCache:getInstance():getSpriteFrame(string.format("jinbi%02d.png", iter_33_0))))
	end

	var_33_1:setDelayPerUnit(0.0625)
	var_33_1:setRestoreOriginalFrame(false)
	var_33_0:runAction(cc.Animate:create(var_33_1))
	global_basic_scene:addChild(var_33_0, 100000)
end

function TaskLayer:initDiamondNum()
	ccui.Helper:seekWidgetByName(self.diamondPanel, "Label_diamondNum"):setString(global_trans_number(playermodel.diamond))
end

function TaskLayer:updateDiamondNum()
	ccui.Helper:seekWidgetByName(self.diamondPanel, "Label_diamondNum"):setString(global_trans_number(playermodel.diamond))
	ccui.Helper:seekWidgetByName(self.diamondPanel, "Label_diamondNum"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1.2), cc.ScaleTo:create(0.2, 1)))
end
