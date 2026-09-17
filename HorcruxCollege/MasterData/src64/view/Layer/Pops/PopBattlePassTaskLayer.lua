PopBattlePassTaskLayer = class("PopBattlePassTaskLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.TitleSprite")

local task_manager = require("controller.task_manager")
local drop_manager = require("controller.drop_manager")
local grade_manager = require("controller.grade_manager")
local armature_manager = require("controller.armature_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local battle_pass_manager = require("controller.battle_pass_manager")
local task_data = require("data.task_data")
local item_data = require("data.item_data")
local career_task_index_data = require("data.career_task_index_data")
local playermodel = require("model.playermodel")
local var_0_11 = config._DEBUG and 0 or 1
local var_0_12 = 9
local var_0_13 = false
local var_0_14
local var_0_15 = "TaskLayer/diamond.png"
local var_0_16 = "TaskLayer/level_icon.png"
local var_0_17 = {}

var_0_17[1] = true
var_0_17[2] = true
var_0_17[3] = true
var_0_17[4] = true
var_0_17[5] = true
var_0_17[6] = true

local var_0_18 = {
	1,
	2,
	3,
	4,
	5,
	6
}
local var_0_19 = {
	{
		on = "TaskLayer/soul_up_on.png",
		off = "TaskLayer/soul_up.png"
	},
	{
		on = "TaskLayer/train_fight_on.png",
		off = "TaskLayer/train_fight.png"
	},
	{
		on = "TaskLayer/midas_on.png",
		off = "TaskLayer/midas.png"
	},
	{
		on = "TaskLayer/quick_fight_on.png",
		off = "TaskLayer/quick_fight.png"
	},
	[6] = {
		on = "TaskLayer/orter_on.png",
		off = "TaskLayer/orter.png"
	},
	{
		on = "TaskLayer/level_on.png",
		off = "TaskLayer/level.png"
	}
}

setmetatable(var_0_19, {
	__index = function(arg_2_0, arg_2_1)
		if arg_2_1 == PLOT_CLASS.CAREER then
			return {
				off = "TaskLayer/class" .. playermodel.class .. ".png",
				on = "TaskLayer/class" .. playermodel.class .. "_on.png"
			}
		end
	end
})

local var_0_20 = {
	false,
	false,
	false,
	false,
	[6] = false,
	false
}
local var_0_21 = {
	"TaskLayer/chu1.png",
	"TaskLayer/chu2.png",
	"TaskLayer/chu3.png",
	"TaskLayer/chu4.png",
	"TaskLayer/gao2.png",
	"TaskLayer/gao3.png",
	"TaskLayer/da1.png",
	"TaskLayer/da2.png",
	"TaskLayer/da3.png",
	"TaskLayer/da4.png"
}
local var_0_22 = {
	"equipment/medal1.png",
	"equipment/medal2.png",
	"equipment/medal3.png",
	"equipment/medal4.png",
	"equipment/medal5.png",
	"equipment/medal6.png"
}
local var_0_23 = {
	cc.c4b(50, 150, 220, 150),
	cc.c4b(54, 255, 82, 150),
	cc.c4b(56, 122, 255, 150),
	cc.c4b(255, 12, 246, 150),
	cc.c4b(255, 84, 0, 150),
	cc.c4b(255, 0, 0, 150)
}
local var_0_25 = cc.p(96, 80)
local var_0_26 = "mainScenebg/task_img/"
local var_0_27 = cc.c4b(56, 122, 255, 150)
local var_0_28 = cc.c4b(255, 84, 0, 150)
local var_0_29 = 569
local var_0_30 = 180
local var_0_31 = {
	cc.p(78, 88)
}

function PopBattlePassTaskLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = PopBattlePassTaskLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function PopBattlePassTaskLayer:init(arg_4_1)
	var_0_14 = self
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)

	local var_4_0

	if arg_4_1 then
		var_4_0 = arg_4_1.taskType
	elseif RoleDefault:getInstance():getIntegerForKey("curBattleClassType", PLOT_CLASS.CAREER) ~= 0 then
		if not RoleDefault:getInstance():getIntegerForKey("curBattleClassType", PLOT_CLASS.CAREER) then
			::label_4_0::

			var_4_0 = PLOT_CLASS.CAREER
		end
	end

	local var_4_1 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "TaskLayer.json" or "TaskLayer.ExportJson")

	self.completeNum = ccui.Helper:seekWidgetByName(var_4_1, "complete_num"):clone()
	self.complete_label = ccui.Helper:seekWidgetByName(var_4_1, "complete_label"):clone()
	self.diamondPanel = ccui.Helper:seekWidgetByName(var_4_1, "Panel_diamond"):clone()
	self.taskPanel = ccui.Helper:seekWidgetByName(var_4_1, "label_exp")

	self.taskPanel:retain()
	self:initUI()
	self:initTaskList()
	self:fullScreen()

	var_0_13 = true

	task_manager:get_task_info(function()
		self.rootLayer:setVisible(true)

		var_0_13 = false

		self:switchPlotTaskClass(var_4_0)
		self:updateTaskAlert()
	end)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			if self.taskPanel then
				self.taskPanel:release()
			end

			var_0_13 = false
			var_0_14 = nil

			local var_6_0 = false

			for iter_6_0, iter_6_1 in ipairs(var_0_20) do
				if iter_6_1 then
					var_6_0 = true

					break
				end
			end

			if var_6_0 then
				AlertManager:register_alert(ALERT_BATTLE_PASS_TASK)
			else
				AlertManager:unregister_alert(ALERT_BATTLE_PASS_TASK, true)
			end

			if LayerManager:getActiveLayerName() == "ExploreMapLayer" then
				LayerManager:getUIElement("ExploreMapLayer"):onForeground()
			end

			battle_pass_manager:getBattlePassListFromSever()
		end
	end)
end

function PopBattlePassTaskLayer:fullScreen()
	local var_7_0 = self.rootLayer:getChildByName("titleBg")

	var_7_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 0, TRANSFORM_UNIT.PX)

	var_7_0:setPositionY(var_7_0.full_posY)

	local var_7_1 = self:getChildByName("bottomBtnList")

	var_7_1.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, var_7_1:getPositionY(), TRANSFORM_UNIT.PX)

	var_7_1:setPositionY(var_7_1.full_posY)
	self.dropListView:setPositionY(var_7_1:getPositionY() + 60)
end

function PopBattlePassTaskLayer:initUI()
	self.rootLayer:setVisible(false)

	titleBg = TitleSprite:create("TaskLayer/battlepass_title.png", 2, "TaskLayer/top_bg.png")

	titleBg.title:setPositionX(0)
	titleBg:setAnchorPoint(cc.p(0, 1))
	titleBg:setPosition(0, SCREEN_HEIGHT)
	titleBg:addChild(self.diamondPanel)
	titleBg:setName("titleBg")
	self.diamondPanel:setPosition(cc.p(480, titleBg:getContentSize().height / 2 - self.diamondPanel:getContentSize().height / 2))
	self.rootLayer:addChild(titleBg, var_0_12)
	self:initDiamondNum()

	local var_8_0 = BottomBtnList:create(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end, {
		{
			texture = "public/button/public_button_orange.png",
			name = "onekey",
			word = L_BATTLE_PASS.GET_ALL_REWARD,
			handler = function(self, arg_10_1)
				if arg_10_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not self:isBright() then
					return
				end

				if var_0_13 then
					return
				end

				self:setBright(false)

				var_0_13 = true

				self:confirmAwardsOneKey(self)
			end
		}
	}, "TaskLayer/bottom_bg.png", {
		img = "TaskLayer/return_bnt.png",
		pos = cc.p(63, 64)
	})

	self.classUpBnt = ccui.Button:create("TaskLayer/up_bnt.png", nil, "TaskLayer/up_bnt.png", var_0_11)

	self.classUpBnt:setPosition(320, var_8_0:getContentSize().height / 2 + 5)
	self.classUpBnt:setVisible(false)
	var_8_0:addChild(self.classUpBnt, 10)

	local var_8_1 = ccui.ImageView:create("TaskLayer/bnt_effect.png", var_0_11)

	var_8_1:setPosition(self.classUpBnt:getContentSize().width / 2, self.classUpBnt:getContentSize().height / 2)
	var_8_1:setVisible(false)
	var_8_1:setName("effect")
	self.classUpBnt:addChild(var_8_1)
	var_8_1:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(1), cc.FadeIn:create(1))))
	self.completeNum:setPosition(620, var_8_0:getContentSize().height / 2)
	var_8_0:addChild(self.completeNum, 10)
	self.complete_label:setPositionY(var_8_0:getContentSize().height / 2)
	var_8_0:addChild(self.complete_label, 10)
	var_8_0:setName("bottomBtnList")
	self:addChild(var_8_0, 5)

	self.classBnts = {}
	self.dropListView = ccui.ListView:create()

	self.dropListView:setDirection(ccui.ListViewDirection.vertical)
	self.dropListView:setItemsMargin(6)
	self.dropListView:setAnchorPoint(cc.p(0, 0))
	self.dropListView:setPosition(0, 80)
	self.dropListView:setContentSize(cc.size(100, 990 + GameDisplay.height - 1136))
	self.rootLayer:addChild(self.dropListView)

	for iter_8_0 = 1, #var_0_18 do
		local var_8_2 = ccui.Button:create(var_0_19[iter_8_0].off, var_0_19[iter_8_0].on, var_0_19[iter_8_0].on, var_0_11)

		var_8_2:setAnchorPoint(cc.p(0, 0))
		var_8_2:setName("classBnt" .. iter_8_0)
		print(var_8_2:getContentSize().height)
		self.dropListView:pushBackCustomItem(var_8_2)

		self.classBnts[iter_8_0] = var_8_2

		var_8_2:addTouchEventListener(function(arg_11_0, arg_11_1)
			if arg_11_1 ~= ccui.TouchEventType.ended then
				return
			end

			if var_0_13 then
				return
			end

			self:switchPlotTaskClass(iter_8_0)
		end)
	end

	self:createFullMask()
end

function PopBattlePassTaskLayer:updateClassUpBnt()
	self.classUpBnt:setVisible(false)
end

function PopBattlePassTaskLayer:createFullMask()
	local var_13_0 = ccui.Layout:create()

	var_13_0:setTouchEnabled(true)
	var_13_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_13_0:setAnchorPoint(cc.p(0, 0))
	var_13_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_13_0:setOpacity(0)
	self:addChild(var_13_0, -1)
end

function PopBattlePassTaskLayer:switchPlotTaskClass(arg_14_1)
	arg_14_1 = arg_14_1 or self.curClassType

	if self.curClassType == arg_14_1 then
		return
	end

	RoleDefault:getInstance():setIntegerForKey("curBattleClassType", arg_14_1)

	for iter_14_0, iter_14_1 in pairs(self.classBnts) do
		if iter_14_0 == arg_14_1 then
			iter_14_1:setBright(false)
		else
			iter_14_1:setBright(true)
		end
	end

	self.curClassType = arg_14_1
	self.taskList.withaction = true
	var_0_13 = true

	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		var_0_13 = false
		self.taskList.withaction = false
	end)))
	self:updateTaskList()
end

function PopBattlePassTaskLayer:initTaskList()
	local var_16_0 = 1000 + GameDisplay.height - 1136

	self.taskList = cc.TableView:create(cc.size(589, 1000 + GameDisplay.height - 1136))

	self.taskList:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taskList:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taskList:setAnchorPoint(cc.p(0, 0))
	self.taskList:setPosition(80, (GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, 70, TRANSFORM_UNIT.PX)))
	self.taskList:setDelegate()
	self.rootLayer:addChild(self.taskList)

	self.curtaskListLen = 0

	self.taskList:registerScriptHandler(function(arg_17_0, arg_17_1)
		return var_0_29, var_0_30
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taskList:registerScriptHandler(function(arg_18_0, arg_18_1)
		local var_18_0 = arg_18_0:dequeueCell()

		if not var_18_0 then
			var_18_0 = cc.TableViewCell:create()

			local var_18_1 = self:createTaskInfoPanel(self:dequeueTaskInfo(self.curClassType, arg_18_1 + 1), arg_18_1)

			var_18_1:setName("taskinfo")
			var_18_1:setPosition(cc.p(0, 25))

			if arg_18_0.withaction and arg_18_1 < 8 then
				var_18_1:setOpacity(0)
				var_18_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_18_1), cc.FadeIn:create(0.1)))
			end

			var_18_0:addChild(var_18_1)
		else
			var_18_0:getChildByName("taskinfo"):updateTaskInfo((self:dequeueTaskInfo(self.curClassType, arg_18_1 + 1)))

			if arg_18_0.withaction and arg_18_1 < 8 then
				var_18_0:getChildByName("taskinfo"):setOpacity(0)
				var_18_0:getChildByName("taskinfo"):runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_18_1), cc.FadeIn:create(0.1)))
			elseif var_18_0:getChildByName("taskinfo"):getOpacity() < 255 then
				var_18_0:getChildByName("taskinfo"):setOpacity(255)
			end
		end

		if self.startRunOutAni then
			self.startIndex = self.startIndex or arg_18_1

			local var_18_2 = LAYER_OUT_TIME / math.ceil(var_16_0 / var_0_30)

			var_18_0:getChildByName("taskinfo"):runAction(cc.Sequence:create(cc.DelayTime:create((arg_18_1 - self.startIndex + 1) * var_18_2), cc.FadeOut:create(var_18_2)))
		end

		return var_18_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taskList:registerScriptHandler(function(arg_19_0, arg_19_1)
		return self.curtaskListLen
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.taskList:reloadData()
end

function PopBattlePassTaskLayer:updateTaskList()
	self.curtaskListLen = self:getTaskListLen(self.curClassType)

	if var_0_17[self.curClassType] then
		self.completeNum:setString("")
		self.complete_label:setPosition(self.completeNum:getPositionX() - self.completeNum:getContentSize().width - 5, self.completeNum:getPositionY())
		self.completeNum:setVisible(false)
		self.complete_label:setVisible(false)
	else
		self.completeNum:setVisible(false)
		self.complete_label:setVisible(false)
	end

	self.taskList:reloadData()
	self:updateClassUpBnt()
end

function PopBattlePassTaskLayer.getTaskListLen(arg_21_0, arg_21_1)
	return task_manager:getBattlePassListLen(arg_21_1)
end

function PopBattlePassTaskLayer.dequeueTaskInfo(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = task_manager:dequeueBattlePassTaskInfo(arg_22_1, arg_22_2)

	if type(var_22_0) == "table" then
		local var_22_1 = {
			taskid = var_22_0.taskid,
			name = task_data[var_22_0.taskid].name,
			des = task_data[var_22_0.taskid].task_des,
			percent = var_22_0.percent,
			jump = task_data[var_22_0.taskid].jump,
			drop = task_data[var_22_0.taskid].drop,
			order = task_data[var_22_0.taskid].order
		}

		var_22_1.img = task_data[var_22_0.taskid].image or 1
		var_22_1.medal_id = task_data[var_22_0.taskid].medal_id

		return var_22_1
	else
		return var_22_0
	end
end

local function var_0_33(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = ccui.ImageView:create(arg_24_0, var_0_11)

	if arg_24_2 then
		var_24_0:setContentSize(arg_24_2)
		var_24_0:ignoreContentAdaptWithSize(false)
	end

	local var_24_1 = cc.Label:createWithTTF(arg_24_1, "fonts/new1.ttf", 20)

	var_24_1:setColor(cc.c3b(171, 239, 58))
	var_24_1:setAnchorPoint(cc.p(0, 0.5))
	var_24_1:setPosition(var_24_0:getContentSize().width, var_24_0:getContentSize().height / 2)
	var_24_0:addChild(var_24_1)

	local var_24_2 = ccui.Layout:create()

	var_24_2:setContentSize(cc.size(var_24_0:getContentSize().width + var_24_1:getContentSize().width, var_24_0:getContentSize().height))
	var_24_0:setAnchorPoint(cc.p(0, 0))
	var_24_0:setPosition(0, 0)
	var_24_2:addChild(var_24_0)

	return var_24_2
end

local function var_0_34()
	local var_25_0 = cc.Label:createWithTTF(L_SOUL, FONT_DES, 54)

	var_25_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_25_0:enableOutline(var_0_23[1], 1)
	var_25_0:enableShadow(var_0_23[1], cc.size(0, 0))
	var_25_0:setName("medal")

	return var_25_0
end

function PopBattlePassTaskLayer:createTaskInfoPanel(arg_26_1, arg_26_2)
	local var_26_0 = self.taskPanel:clone()

	var_26_0.index = arg_26_2

	var_26_0:getChildByName("button_goto"):setName("button_goto_" .. var_26_0.index)

	function var_26_0:updateTaskInfo(arg_27_1)
		if type(arg_27_1) == "table" then
			self:updateTriggeredTask(arg_27_1)
		elseif type(arg_27_1) == "number" then
			self:updateFinishedTask(arg_27_1)
		end
	end

	function var_26_0:updateFinishedTask(arg_28_1)
		local var_28_0 = task_data[arg_28_1]
		local var_28_1

		if task_data[arg_28_1] and var_28_0.medal_id then
			local var_28_3 = self:getChildByName("medal")

			if not var_28_3 then
				var_28_3 = var_0_34()

				var_28_3:setPositionX(self:getChildByName("Image_task"):getPositionX() + 5)
				var_28_3:setPositionY(self:getChildByName("Image_task"):getPositionY() - 5)
				self:addChild(var_28_3)
			end

			var_28_3:setVisible(true)

			local var_28_4 = item_data[tonumber(var_28_0.medal_id)]
			local var_28_5

			if item_data[itemid].bg then
				var_28_5 = "equipment/" .. var_28_4.bg .. ".png" or var_0_22[var_28_4.equip_quality]
			end

			var_28_3:setTexture(var_28_5)
			var_28_3:setString(var_28_4.name)
			var_28_3:enableOutline(var_0_23[var_28_4.equip_quality], 1)
			var_28_3:enableShadow(var_0_23[var_28_4.equip_quality], cc.size(0, 0))
			var_28_3:setVisible(var_28_4.only_bg ~= 1)

			var_28_1 = var_28_5
		else
			var_28_1 = var_0_26 .. ((not var_28_0.image or nil) and 1) .. ".png"

			if self:getChildByName("medal") then
				self:getChildByName("medal"):removeFromParent()
			end
		end

		self:getChildByName("name"):setString(var_28_0.name)
		self:getChildByName("des"):setString(var_28_0.task_des)
		self:getChildByName("Image_task"):loadTexture(var_28_1)
		self:getChildByName("button_goto_" .. self.index):setVisible(false)
		self:getChildByName("button_getAwards"):setVisible(false)
		self:getChildByName("button_done"):setVisible(true)
		self:getChildByName("ProgressBar"):setVisible(false)
		self:updateAwardList(var_28_0.drop)
	end

	function var_26_0:updateTriggeredTask(arg_29_1)
		local var_29_0

		if arg_29_1.medal_id then
			local var_29_1 = self:getChildByName("medal")

			if not var_29_1 then
				var_29_1 = var_0_34()

				var_29_1:setPositionX(self:getChildByName("Image_task"):getPositionX() + 5)
				var_29_1:setPositionY(self:getChildByName("Image_task"):getPositionY() - 5)
				self:addChild(var_29_1)
			end

			local var_29_2 = item_data[tonumber(arg_29_1.medal_id)]

			var_29_1:setVisible(true)
			var_29_1:setString(var_29_2.name)
			var_29_1:enableOutline(var_0_23[var_29_2.equip_quality], 1)
			var_29_1:enableShadow(var_0_23[var_29_2.equip_quality], cc.size(0, 0))
			var_29_1:setVisible(var_29_2.only_bg ~= 1)

			if item_data[itemid].bg then
				var_29_0 = "equipment/" .. var_29_2.bg .. ".png" or var_0_22[var_29_2.equip_quality]
			end
		else
			var_29_0 = var_0_26 .. arg_29_1.img .. ".png"

			if self:getChildByName("medal") then
				self:getChildByName("medal"):removeFromParent()
			end
		end

		self:getChildByName("name"):setString(arg_29_1.name)
		self:getChildByName("des"):setString(arg_29_1.des)
		self:getChildByName("button_done"):setVisible(false)
		self:getChildByName("Image_task"):loadTexture(var_29_0)
		self:getChildByName("ProgressBar"):setVisible(true)

		if arg_29_1.percent < 100 then
			self:getChildByName("button_goto_" .. self.index):setVisible(true)
			self:getChildByName("ProgressBar"):setPercent(arg_29_1.percent)
			self:getChildByName("ProgressBar"):getChildByName("Label_percent"):setString(arg_29_1.percent .. "%")
			self:getChildByName("button_goto_" .. self.index):addTouchEventListener(function(arg_30_0, arg_30_1)
				if arg_30_1 ~= ccui.TouchEventType.ended then
					return
				end

				print("taskinfo.jump = ", arg_29_1.jump)

				if arg_29_1.jump == 130 then
					LayerManager:pushInLayer("SignLayerNew", {
						callback = function()
							if var_0_14 then
								self:useMidasAfterUpdate()
							end
						end
					})
				elseif arg_29_1.jump == 111 then
					require("controller.sign_manager"):createMidasLayer(function()
						if var_0_14 then
							self:useMidasAfterUpdate()
						end
					end)
				elseif arg_29_1.jump == 220 then
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
							if var_0_14 then
								self:useMidasAfterUpdate()
							end
						end
					})
				elseif arg_29_1.jump then
					require("controller.goto_system_manager")

					local var_30_0 = {
						jump_to_system = arg_29_1.jump
					}

					var_30_0.config = system_jump_config[SYSTEMID[arg_29_1.jump]] and system_jump_config[SYSTEMID[arg_29_1.jump]].config

					if var_30_0.config then
						if var_30_0.config.exitCallbackType == "function" then
							var_30_0.config.exitCallback = nil
						elseif var_30_0.config.exitCallbackType == "string" then
							var_30_0.config = "MainLayer"
						end
					end

					goto_complete_system(var_30_0)
				end
			end)
			self:getChildByName("button_getAwards"):setVisible(false)
		else
			self:getChildByName("button_goto_" .. self.index):setVisible(false)
			self:getChildByName("button_getAwards"):setVisible(true)
			self:getChildByName("ProgressBar"):setPercent(arg_29_1.percent)
			self:getChildByName("ProgressBar"):getChildByName("Label_percent"):setString(arg_29_1.percent .. "%")
			self:getChildByName("button_getAwards"):addTouchEventListener(function(arg_36_0, arg_36_1)
				if arg_36_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_36_0:isBright() then
					return
				end

				if var_0_13 then
					return
				end

				arg_36_0:setBright(false)

				var_0_13 = true

				self:confirmAwards(arg_29_1.taskid, arg_36_0)
			end)
		end

		self:updateAwardList(arg_29_1.drop)
	end

	function var_26_0:updateAwardList(arg_37_1)
		local var_37_0 = self:getChildByName("reward_list")
		local var_37_1 = drop_manager:getDropMsg(arg_37_1)

		var_37_0:setItemsMargin(10)
		var_37_0:removeAllItems()

		if var_37_1.diamond and var_37_1.diamond > 0 then
			var_37_0:pushBackCustomItem(var_0_33(var_0_15, "X" .. var_37_1.diamond))
		end

		if var_37_1.gold and var_37_1.gold > 0 then
			var_37_0:pushBackCustomItem(var_0_33(IMAGE_GOLD, "X" .. var_37_1.gold, cc.size(43, 30)))
		end

		if var_37_1.equips[1].dropid and var_37_1.equips[1].dropid == 199000001 then
			var_37_0:pushBackCustomItem(var_0_33(var_0_16, "X" .. var_37_1.equips[1].dropNum, cc.size(50, 35)))
		end

		var_37_0:setPositionX(38)

		if var_37_1.equips then
			for iter_37_0, iter_37_1 in pairs(var_37_1.equips) do
				assert(item_data[iter_37_1.dropid], "itemid: " .. iter_37_1.dropid .. " is nil")
			end
		end
	end

	var_26_0:updateTaskInfo(arg_26_1)

	return var_26_0
end

function PopBattlePassTaskLayer:confirmAwards(arg_38_1, arg_38_2)
	local function var_38_0(arg_39_0, arg_39_1)
		if arg_39_0 == 1 then
			task_manager:generate_battle_pass_task_info()
			global_gain(arg_39_1)

			if arg_39_1.items then
				while arg_39_1.items[1] do
					if item_data[arg_39_1.items[1].itemid].bag_item_type == 64 then
						require("view.Layer.GetRoleAnimationLayer")
						cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(arg_39_1.items[1].itemid), 1000)
					end
				end
			end

			var_0_13 = false

			if not var_0_14 then
				return
			end

			arg_38_2:setBright(true)
			self:updateTaskList()
			self:updateTaskAlert()
			self:updateDiamondNum()
		else
			arg_38_2:setBright(true)

			var_0_13 = false
		end
	end

	if var_0_17[self.curClassType] then
		task_manager:getTaskReward(arg_38_1, var_38_0)
	else
		PlotManager:finishPlot(arg_38_1, var_38_0)
	end
end

function PopBattlePassTaskLayer:confirmAwardsOneKey(arg_40_1)
	local var_40_0 = self:dequeueTaskInfo(self.curClassType, 1)

	if type(var_40_0) == "table" and var_40_0.percent >= 100 then
		task_manager:getBattlePassRewardOneKey(self.curClassType, function(arg_41_0, arg_41_1)
			if arg_41_0 == 1 then
				task_manager:generate_battle_pass_task_info()
				global_gain(arg_41_1)

				if arg_41_1.items then
					while arg_41_1.items[1] do
						if item_data[arg_41_1.items[1].itemid].bag_item_type == 64 then
							require("view.Layer.GetRoleAnimationLayer")
							cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(arg_41_1.items[1].itemid), 1000)
						end
					end
				end

				if not var_0_14 then
					return
				end

				self:updateTaskList()
				self:updateTaskAlert()
				self:updateDiamondNum()
			end

			arg_40_1:setBright(true)

			var_0_13 = false
		end)
	else
		arg_40_1:setBright(true)

		var_0_13 = false

		global_ShowBlockWords(L_BATTLE_PASS.NOT_REWARD_CAN_GET)
	end
end

function PopBattlePassTaskLayer:updateTaskAlert()
	local var_42_0 = true

	if playermodel.class == #PlAYER_CLASS then
		var_42_0 = false
	else
		for iter_42_0, iter_42_1 in pairs(task_manager.tasks[TASK_TYPE_CAREER]) do
			if iter_42_1.percent < 100 then
				var_42_0 = false
			end
		end
	end

	for iter_42_2, iter_42_3 in pairs(var_0_20) do
		local var_42_1 = self:dequeueTaskInfo(iter_42_2, 1)

		var_0_20[iter_42_2] = type(var_42_1) == "table" and var_42_1.percent >= 100

		if iter_42_2 == PLOT_CLASS.CAREER then
			AlertManager:add_redDot(self.classBnts[iter_42_2], var_42_0 or var_0_20[iter_42_2], cc.p(48, 164))
		else
			AlertManager:add_redDot(self.classBnts[iter_42_2], var_0_20[iter_42_2], cc.p(48, 164))
		end
	end
end

function PopBattlePassTaskLayer.showGetDiamondAni(arg_43_0, arg_43_1)
	require("controller.audio_manager"):playeffectMusicTest("sound/gain_diamond")
	cc.SpriteFrameCache:getInstance():addSpriteFrames("effect/gain_diamond/jinbi.plist")
	cc.SpriteFrameCache:getInstance():addSpriteFrames("effect/gain_diamond/feizou.plist")

	local var_43_0 = cc.Sprite:createWithSpriteFrameName("jinbi01.png")

	var_43_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_43_0:setPosition(320, GameDisplay.height / 2)
	var_43_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
		local var_44_0 = cc.Sprite:createWithSpriteFrameName("feizou_00001.png")

		var_44_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_44_0:setPosition(270, 468)
		var_44_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.6666666666666666), cc.CallFunc:create(arg_43_1), cc.RemoveSelf:create()))

		local var_44_1 = cc.Animation:create()

		for iter_44_0 = 1, 14 do
			var_44_1:addSpriteFrame((cc.SpriteFrameCache:getInstance():getSpriteFrame(string.format("feizou_%05d.png", iter_44_0))))
		end

		var_44_1:setDelayPerUnit(0.047619047619047616)
		var_44_1:setRestoreOriginalFrame(false)
		var_44_0:runAction(cc.Animate:create(var_44_1))
		var_44_0:runAction(cc.MoveTo:create(0.6666666666666666, cc.p(540, 1107)))
		global_basic_scene:addChild(var_44_0, 100000)
	end), cc.RemoveSelf:create()))

	local var_43_1 = cc.Animation:create()

	for iter_43_0 = 1, 7 do
		var_43_1:addSpriteFrame((cc.SpriteFrameCache:getInstance():getSpriteFrame(string.format("jinbi%02d.png", iter_43_0))))
	end

	var_43_1:setDelayPerUnit(0.0625)
	var_43_1:setRestoreOriginalFrame(false)
	var_43_0:runAction(cc.Animate:create(var_43_1))
	global_basic_scene:addChild(var_43_0, 100000)
end

function PopBattlePassTaskLayer:initDiamondNum()
	self.diamondPanel:setVisible(false)
end

function PopBattlePassTaskLayer:updateDiamondNum()
	self.diamondPanel:setVisible(false)
end

function PopBattlePassTaskLayer:updateShowingCells()
	local var_47_0, var_47_1 = GetTableViewShowCellIdx(self.taskList, {
		cellsize = cc.size(var_0_29, var_0_30),
		maxcount = self.curtaskListLen
	})

	for iter_47_0 = var_47_0, var_47_1 do
		self.taskList:updateCellAtIndex(iter_47_0)
	end
end

function PopBattlePassTaskLayer.useMidasAfterUpdate(arg_48_0)
	task_manager:get_task_info(function()
		arg_48_0:switchPlotTaskClass()
		arg_48_0:updateTaskAlert()
		arg_48_0:updateDiamondNum()
		arg_48_0:updateShowingCells()
	end)
end

function PopBattlePassTaskLayer.upPlayerClassAni(arg_50_0)
	local var_50_0 = ccui.Layout:create()

	var_50_0:setTouchEnabled(true)
	var_50_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_50_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_50_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_50_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_50_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_50_0:setBackGroundColorOpacity(180)
	cc.Director:getInstance():getRunningScene():addChild(var_50_0, 10000)
	audio_manager:playeffectMusic(CLASS_UPGRADE_EFFECT)
	var_50_0:addChild((armature_manager:createAndPlayArmature("playerUpClass", {
		grade1 = var_0_21[playermodel.class - 1],
		grade2 = var_0_21[playermodel.class]
	}, {})))
	var_50_0:runAction(cc.Sequence:create(cc.DelayTime:create(10), cc.RemoveSelf:create()))
	var_50_0:addTouchEventListener(function(arg_51_0, arg_51_1)
		if arg_51_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_50_0:runAction(cc.RemoveSelf:create())
	end)
end

function PopBattlePassTaskLayer:layerOutAni(arg_52_1)
	self.startRunOutAni = true

	self:updateShowingCells()
	self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(LAYER_OUT_TIME), cc.CallFunc:create(arg_52_1)))
end

function PopBattlePassTaskLayer:exit()
	self:layerOutAni(function()
		LayerManager:removePopLayer()
	end)
end
