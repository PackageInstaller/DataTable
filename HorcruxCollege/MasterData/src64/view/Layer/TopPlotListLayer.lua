TopPlotListLayer = class("TopPlotListLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.TitleSprite")

local task_manager = require("controller.task_manager")
local drop_manager = require("controller.drop_manager")
local grade_manager = require("controller.grade_manager")
local armature_manager = require("controller.armature_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local achieve_manager = require("controller.achieve_manager")
local substitution_manager = require("controller.substitution_manager")
local var_0_8 = require("controller.daily_weekly_manager"):getInstance()
local time_check_manager = require("controller.time_check_manager")
local l2utils = require("controller.l2utils")
local activity_manager = require("controller.activity_manager")

require("view.Sprite.ItemSpriteActivityRecharge")

local task_data = require("data.task_data")
local item_data = require("data.item_data")
local career_task_index_data = require("data.career_task_index_data")
local playermodel = require("model.playermodel")
local drop_data = require("data.drop_data")
local var_0_17 = config._DEBUG and 0 or 1
local var_0_18
local var_0_19 = "dailytask/diamond.png"
local Utility = require("common.Utility")
local EventManager = require("common.EventManager")
local TempWidget = require("view/Sprite/TempWidget")
local var_0_23 = {
	[PLOT_CLASS.DAILY] = true,
	[PLOT_CLASS.CAREER] = true,
	[PLOT_CLASS.WEEKLY] = true
}
local var_0_24 = {
	[PLOT_CLASS.ROLE] = true,
	[PLOT_CLASS.ITEM] = true,
	[PLOT_CLASS.MOVE] = true,
	[PLOT_CLASS.RESOURCES] = true,
	[PLOT_CLASS.CHALLENGE] = true,
	[PLOT_CLASS.GROWTH] = true
}
local var_0_25 = {
	[PLOT_CLASS.NORMAL] = {
		on = "dailytask/btn_normal_on.png",
		off = "dailytask/btn_normal_off.png"
	},
	[PLOT_CLASS.DAILY] = {
		on = "dailytask/btn_daily_on.png",
		off = "dailytask/btn_daily_off.png"
	},
	[PLOT_CLASS.ACHIEVE] = {
		on = "dailytask/btn_achieve_on.png",
		off = "dailytask/btn_achieve_off.png"
	},
	[PLOT_CLASS.ACTIVITY] = {
		on = "dailytask/activity_bnt_on.png",
		off = "dailytask/activity_bnt.png"
	},
	[PLOT_CLASS.ROLE] = {
		on = "dailytask/btn_role_on.png",
		off = "dailytask/btn_role_off.png"
	},
	[PLOT_CLASS.ITEM] = {
		on = "dailytask/btn_item_on.png",
		off = "dailytask/btn_item_off.png"
	},
	[PLOT_CLASS.MOVE] = {
		on = "dailytask/btn_move_on.png",
		off = "dailytask/btn_move_off.png"
	},
	[PLOT_CLASS.RESOURCES] = {
		on = "dailytask/btn_resource_on.png",
		off = "dailytask/btn_resource_off.png"
	},
	[PLOT_CLASS.CHALLENGE] = {
		on = "dailytask/btn_challenge_on.png",
		off = "dailytask/btn_challenge_off.png"
	},
	[PLOT_CLASS.GROWTH] = {
		on = "dailytask/btn_grow_on.png",
		off = "dailytask/btn_grow_off.png"
	},
	[PLOT_CLASS.WEEKLY] = {
		on = "dailytask/btn_weekly_on.png",
		off = "dailytask/btn_weekly_off.png"
	},
	[PLOT_CLASS.DAILY_WEEKLY] = {
		on = "dailytask/btn_daily_weekly_on.png",
		off = "dailytask/btn_daily_weekly_off.png"
	}
}
local var_0_26 = {
	[PLOT_CLASS.DAILY_WEEKLY] = {
		title = "dailytask/title1.png",
		bg = "dailytask/banner1.png"
	},
	[PLOT_CLASS.CAREER] = {
		title = "dailytask/title2.png",
		bg = "dailytask/banner2.png"
	},
	[PLOT_CLASS.NORMAL] = {
		title = "dailytask/title3.png",
		bg = "dailytask/banner3.png"
	},
	[PLOT_CLASS.ROLE] = {
		title = "dailytask/title4.png",
		bg = "dailytask/banner4.png"
	},
	[PLOT_CLASS.DAILY] = {
		title = "dailytask/title5.png",
		bg = "dailytask/banner5.png"
	},
	[PLOT_CLASS.WEEKLY] = {
		title = "dailytask/title6.png",
		bg = "dailytask/banner6.png"
	}
}

setmetatable(var_0_25, {
	__index = function(arg_2_0, arg_2_1)
		if arg_2_1 == PLOT_CLASS.CAREER then
			return {
				off = "dailytask/btn_career" .. playermodel.class .. "_off.png",
				on = "dailytask/btn_career" .. playermodel.class .. "_on.png"
			}
		end
	end
})

local var_0_27 = {
	[PLOT_CLASS.NORMAL] = false,
	[PLOT_CLASS.DAILY] = false,
	[PLOT_CLASS.ACHIEVE] = false,
	[PLOT_CLASS.ACTIVITY] = false,
	[PLOT_CLASS.CAREER] = false,
	[PLOT_CLASS.ROLE] = false,
	[PLOT_CLASS.ITEM] = false,
	[PLOT_CLASS.MOVE] = false,
	[PLOT_CLASS.RESOURCES] = false,
	[PLOT_CLASS.CHALLENGE] = false,
	[PLOT_CLASS.GROWTH] = false,
	[PLOT_CLASS.WEEKLY] = false,
	[PLOT_CLASS.DAILY_WEEKLY] = false
}
local var_0_28 = {
	PLOT_CLASS.DAILY,
	PLOT_CLASS.WEEKLY,
	PLOT_CLASS.NORMAL,
	PLOT_CLASS.DAILY_WEEKLY,
	PLOT_CLASS.CAREER,
	PLOT_CLASS.ACHIEVE
}
local var_0_29 = {
	PLOT_CLASS.ROLE,
	PLOT_CLASS.GROWTH,
	PLOT_CLASS.ITEM,
	PLOT_CLASS.MOVE,
	PLOT_CLASS.RESOURCES,
	PLOT_CLASS.CHALLENGE
}
local var_0_30 = {
	"dailytask/img_career_1.png",
	"dailytask/img_career_2.png",
	"dailytask/img_career_3.png",
	"dailytask/img_career_4.png",
	"dailytask/img_career_5.png"
}
local var_0_31 = {
	"public/box/box_activity_recharge_1.png",
	"public/box/box_activity_recharge_2.png",
	"public/box/box_activity_recharge_3.png",
	"public/box/box_activity_recharge_4.png",
	"public/box/box_activity_recharge_5.png",
	"public/box/box_activity_recharge_6.png"
}
local var_0_32 = {
	"equipment/medal1.png",
	"equipment/medal2.png",
	"equipment/medal3.png",
	"equipment/medal4.png",
	"equipment/medal5.png",
	"equipment/medal6.png"
}
local var_0_33 = {
	cc.c4b(50, 150, 220, 150),
	cc.c4b(54, 255, 82, 150),
	cc.c4b(56, 122, 255, 150),
	cc.c4b(255, 12, 246, 150),
	cc.c4b(255, 84, 0, 150),
	cc.c4b(255, 0, 0, 150)
}
local var_0_34 = "mainScenebg/task_img/"
local var_0_35 = 640
local var_0_36 = 135
local var_0_37 = {
	IMG_BOTTOM = 2,
	IMG_TIP = 3,
	IMG_TITLE = 3,
	RADIO_ACHIEVE = 4,
	IMG_DAILY = 3,
	RADIO_SWITCH = 5
}

function TopPlotListLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = TopPlotListLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function TopPlotListLayer:init(arg_4_1)
	self:initData(arg_4_1)
	self:initUI()
	self:registerEvents()
end

function TopPlotListLayer.initData(arg_5_0, arg_5_1)
	local var_5_0 = time_check_manager:getCurTime()

	if var_5_0 < var_0_8:getCloseTime() then
		var_0_28 = {
			PLOT_CLASS.NORMAL,
			PLOT_CLASS.DAILY_WEEKLY,
			PLOT_CLASS.CAREER,
			PLOT_CLASS.ACHIEVE
		}
		var_0_27 = {
			[PLOT_CLASS.NORMAL] = false,
			[PLOT_CLASS.ACHIEVE] = false,
			[PLOT_CLASS.ACTIVITY] = false,
			[PLOT_CLASS.CAREER] = false,
			[PLOT_CLASS.ROLE] = false,
			[PLOT_CLASS.ITEM] = false,
			[PLOT_CLASS.MOVE] = false,
			[PLOT_CLASS.RESOURCES] = false,
			[PLOT_CLASS.CHALLENGE] = false,
			[PLOT_CLASS.GROWTH] = false,
			[PLOT_CLASS.DAILY_WEEKLY] = false
		}
	else
		var_0_28 = {
			PLOT_CLASS.DAILY,
			PLOT_CLASS.WEEKLY,
			PLOT_CLASS.NORMAL,
			PLOT_CLASS.CAREER,
			PLOT_CLASS.ACHIEVE
		}
		var_0_27 = {
			[PLOT_CLASS.NORMAL] = false,
			[PLOT_CLASS.DAILY] = false,
			[PLOT_CLASS.ACHIEVE] = false,
			[PLOT_CLASS.ACTIVITY] = false,
			[PLOT_CLASS.CAREER] = false,
			[PLOT_CLASS.ROLE] = false,
			[PLOT_CLASS.ITEM] = false,
			[PLOT_CLASS.MOVE] = false,
			[PLOT_CLASS.RESOURCES] = false,
			[PLOT_CLASS.CHALLENGE] = false,
			[PLOT_CLASS.GROWTH] = false,
			[PLOT_CLASS.WEEKLY] = false
		}
	end

	var_0_18 = arg_5_0
	arg_5_0.totalActiveNum = 0
	arg_5_0.isSwitchAchieve = false

	local var_5_1

	if arg_5_1 then
		var_5_1 = arg_5_1.taskType
	else
		var_5_1 = RoleDefault:getInstance():getIntegerForKey("curClassType", PLOT_CLASS.CAREER)

		if var_5_0 < var_0_8:getCloseTime() then
			if var_5_1 == PLOT_CLASS.DAILY or var_5_1 == PLOT_CLASS.WEEKLY then
				var_5_1 = PLOT_CLASS.DAILY_WEEKLY
			end
		elseif var_5_1 == PLOT_CLASS.DAILY_WEEKLY then
			var_5_1 = PLOT_CLASS.DAILY
		end
	end

	PlotManager:get_top_task_list(function()
		arg_5_0:updateTaskAlert()

		for iter_6_0, iter_6_1 in pairs(var_0_27) do
			if iter_6_1 == true then
				var_5_1 = var_5_1 or iter_6_0

				break
			end
		end

		if var_5_0 < var_0_8:getCloseTime() then
			if var_5_1 == PLOT_CLASS.DAILY or var_5_1 == PLOT_CLASS.WEEKLY then
				var_5_1 = PLOT_CLASS.DAILY_WEEKLY
			end
		elseif var_5_1 == PLOT_CLASS.DAILY_WEEKLY then
			var_5_1 = PLOT_CLASS.DAILY
		end

		arg_5_0.rootNode:setVisible(true)
		arg_5_0:switchPageByClassType(var_5_1)
	end)
end

function TopPlotListLayer:initUI()
	self.rootNode = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "DailyTaskLayer.json" or "DailyTaskLayer.ExportJson")

	self.rootNode:setContentSize(GameDisplay.size)
	self.rootNode:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootNode)

	self.rootpanel = self.rootNode:getChildByName("panelRoot")
	self.panelMain = self.rootpanel:getChildByName("panelMain")
	self.imgTitle = self.panelMain:getChildByName("imgTitle")
	self.imgBgDiamond = self.imgTitle:getChildByName("imgBgDiamond")
	self.labelDiamond = self.imgBgDiamond:getChildByName("labelDiamond")

	self.labelDiamond:setFontName("fonts/number.ttf")

	self.imgBottom = self.panelMain:getChildByName("imgBottom")
	self.btnExit = self.imgBottom:getChildByName("btnExit")
	self.imgDaily = self.panelMain:getChildByName("imgDaily")

	self:initActivityBottomBg()

	self.imgTip = self.panelMain:getChildByName("imgTip")
	self.btnWhole = self.imgTip:getChildByName("btnWhole")
	self.btnUpgrade = self.imgTip:getChildByName("btnUpgrade")
	self.listViewTasks = self.panelMain:getChildByName("listViewTasks")

	self.listViewTasks:setVisible(false)

	self.panelItem = self.panelMain:getChildByName("panelItem")

	self.panelItem:retain()
	self.panelItem:removeFromParent()

	local var_7_0 = self.panelItem:getChildByName("progressbg")

	var_7_0:setContentSize(cc.size(240, 6))
	var_7_0:loadTexture("dailytask/progress_bg.png", var_0_17)
	var_7_0:setPosition(cc.p(142, 19))

	local var_7_1 = self.panelItem:getChildByName("progressbar")

	var_7_1:setContentSize(cc.size(240, 4))
	var_7_1:loadTexture("dailytask/progress_bar.png", var_0_17)
	var_7_1:setPercent(0)
	var_7_1:setPosition(cc.p(var_7_0:getPosition()))

	local var_7_2 = self.panelItem:getChildByName("labelProgress")

	var_7_2:setAnchorPoint(cc.p(0, 0.5))
	var_7_2:setPosition(cc.p(270, 20))
	self.imgTitle:setLocalZOrder(var_0_37.IMG_TITLE)
	self.imgDaily:setLocalZOrder(var_0_37.IMG_DAILY)
	self.imgBottom:setLocalZOrder(var_0_37.IMG_BOTTOM)
	self.imgTip:setLocalZOrder(var_0_37.IMG_TIP)
	self.imgBottom:setTouchEnabled(true)
	self.imgTip:setTouchEnabled(true)
	self.imgDaily:setTouchEnabled(true)
	self:initTopUI()
	self:initDailyUI()
	self:initPanleMask()
	self:initRadioSwitch()
	self:initRadioAchieve()
	self:initDiamondNum()
	self:initTableViewTask()
	self:fullScreen()
end

function TopPlotListLayer:registerEvents()
	Utility:registerNodeEvent(self)
	Utility:addClickEventListener(self.btnWhole, handler(self, self.onBtnWhole))
	Utility:addClickEventListener(self.btnUpgrade, handler(self, self.onBtnUpgrade))
	Utility:addClickEventListener(self.btnExit, handler(self, self.onBtnExit))
	EventManager:subscribe(self, EventManager.EVENT_IDS.GET_DAILY_TASK_INFO, handler(self, self.handleGetDailyTaskInfo))
	EventManager:subscribe(self, EventManager.EVENT_IDS.GET_DAILY_TASK_ACTIVE_NUM, handler(self, self.handleGetDailyTaskAvtiveNum))
	EventManager:subscribe(self, EventManager.EVENT_IDS.GET_DAILY_TASK_REWARD, handler(self, self.handleGetDailyTaskReward))
end

function TopPlotListLayer:initPanleMask()
	self.panelMask = ccui.Layout:create()

	self.panelMask:setVisible(false)
	self.panelMask:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.panelMask:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.panelMask:setBackGroundColor(cc.c3b(0, 0, 0))
	self.panelMask:setBackGroundColorOpacity(160)
	self.panelMask:setPosition(-GameDisplay.fix_x, -GameDisplay.fix_y)
	self.panelMask:setTouchEnabled(true)
	self:addChild(self.panelMask, 999)

	local var_9_0 = cc.Label:createWithTTF("领取中...", FONT_NAME, 30)

	var_9_0:setName("label")
	var_9_0:setPosition(self.panelMask:getContentSize().width / 2, self.panelMask:getContentSize().height / 2)
	self.panelMask:addChild(var_9_0)

	local var_9_1 = ccui.ImageView:create("dailytask/mask_rewarded.png", var_0_17)

	self.panelMask:addChild(var_9_1)
	var_9_1:setName("img")
	var_9_1:setPosition(self.panelMask:getContentSize().width / 2, self.panelMask:getContentSize().height / 2)
end

function TopPlotListLayer.onEnter(arg_10_0)
	EventManager:requestGetDailyTaskInfo()
end

function TopPlotListLayer:onExit()
	if self.panelItem then
		self.panelItem:release()
	end

	var_0_18 = nil

	EventManager:unsubscribe(self)

	local var_11_0 = #task_manager.tasks[TASK_TYPE_CAREER] ~= 0

	for iter_11_0, iter_11_1 in pairs(task_manager.tasks[TASK_TYPE_CAREER]) do
		if iter_11_1.percent < 100 or playermodel.class == #PlAYER_CLASS then
			var_11_0 = false
		end
	end

	for iter_11_2, iter_11_3 in pairs(var_0_27) do
		AlertManager:unregister_alert(ALERT_TOP_PLOT)

		if iter_11_2 ~= PLOT_CLASS.DAILY then
			if iter_11_3 or var_11_0 then
				AlertManager:register_alert(ALERT_TOP_PLOT)

				break
			end
		elseif iter_11_3 and self.totalActiveNum < 100 then
			AlertManager:register_alert(ALERT_TOP_PLOT)

			break
		end
	end

	if LayerManager:getActiveLayerName() == "ExploreMapLayer" then
		LayerManager:getUIElement("ExploreMapLayer"):onForeground()
	end

	activity_manager:fireEvent(activity_manager.activityEventId.EXIT_FORM_TOPPLOTLIST_LAYER)
end

function TopPlotListLayer:onBtnExit()
	self.imgDaily:setVisible(false)
	self.imgTip:setVisible(false)
	KeyCodeManager:onKeyReleasedCallFunc()
end

function TopPlotListLayer.onBtnUpgrade(arg_13_0, arg_13_1)
	local var_13_0 = true

	for iter_13_0, iter_13_1 in pairs(task_manager.tasks[TASK_TYPE_CAREER]) do
		if iter_13_1.percent < 100 then
			var_13_0 = false
		end
	end

	if not var_13_0 then
		global_ShowBlockWords(L_CLASSUP_MSG[1])

		return
	elseif next(task_manager.tasks[TASK_TYPE_CAREER]) ~= nil then
		global_ShowBlockWords(L_CLASSUP_MSG[2])

		return
	end

	grade_manager:player_update_class(function(arg_14_0)
		if arg_14_0.result == 1 then
			arg_13_0:upPlayerClassAni()

			if arg_14_0.items then
				for iter_14_0, iter_14_1 in pairs(arg_14_0.items) do
					item_manager:setItemByServerItem(iter_14_1)
				end
			end

			task_manager.tasks[TASK_TYPE_CAREER] = {}
			task_manager.taskfinised[TASK_TYPE_CAREER] = {}
			task_manager.task_type_len[TASK_TYPE_CAREER] = 0

			for iter_14_2, iter_14_3 in pairs(career_task_index_data) do
				if iter_14_3.valid and iter_14_3.class == playermodel.class then
					if task_manager:is_task_finished(task_manager.taskinfo[TASK_TYPE_CAREER], iter_14_3.id) then
						table.insert(task_manager.taskfinised[TASK_TYPE_CAREER], iter_14_3.taskid)
					elseif task_manager:can_task_triggered(iter_14_3.taskid) then
						table.insert(task_manager.tasks[TASK_TYPE_CAREER], task_manager:cal_task_stat(iter_14_3.taskid))
					end

					if not task_data[iter_14_3.taskid].classtype or task_data[iter_14_3.taskid].classtype == playermodel.class then
						task_manager.task_type_len[TASK_TYPE_CAREER] = task_manager.task_type_len[TASK_TYPE_CAREER] + 1
					end
				end
			end

			table.sort(task_manager.tasks[TASK_TYPE_CAREER], function(arg_15_0, arg_15_1)
				if arg_15_0.percent == arg_15_1.percent then
					return arg_15_0.order < arg_15_1.order
				else
					return arg_15_0.percent > arg_15_1.percent
				end
			end)
			arg_13_0:queryAlertNodeByClassType(TASK_TYPE_CAREER):loadTextures(var_0_25[PLOT_CLASS.CAREER].off, var_0_25[PLOT_CLASS.CAREER].on, var_0_25[PLOT_CLASS.CAREER].on, var_0_17)
			arg_13_0:updateTableViewTask()
			arg_13_0:updateTaskAlert()
			arg_13_0:updateTopUI()
			AlertManager:add_redDot(arg_13_0.classUpBnt, false)
		else
			cclog("条件未达成", arg_14_0.result)
			audio_manager:playeffectMusicTest("sound/invalid")
			global_ShowBlockWords(L_CLASSUP_FORBID)
		end
	end)
end

function TopPlotListLayer:onBtnWhole()
	if self.curClassType == PLOT_CLASS.NORMAL then
		if not PlotManager:isHaveReward(self.curClassType) then
			global_ShowBlockWords(TASK_REWARD_ONEKEY_WARN)

			return
		end

		self:setPanelMaskVisible(true, true)
		PlotManager:finishPlotOneKey(function(arg_17_0, arg_17_1)
			if arg_17_0 == 1 then
				self:handleGetAwards(arg_17_1)
			end

			self:setPanelMaskVisible(false, false)
		end)
	elseif var_0_24[self.curClassType] then
		self:setPanelMaskVisible(true, true)
		achieve_manager:getTaskRewardOneKey(self.curClassType, function(arg_18_0, arg_18_1)
			if arg_18_0 == 1 then
				self:handleGetAwards(arg_18_1)
			end

			self:setPanelMaskVisible(false, false)
		end)
	else
		if self.curClassType == PLOT_CLASS.WEEKLY then
			if not task_manager:isHaveReward(TASK_TYPE_WEEKLY or self.curClassType) then
				global_ShowBlockWords(TASK_REWARD_ONEKEY_WARN)

				return
			end
		end

		self:setPanelMaskVisible(true, true)

		if self.curClassType == PLOT_CLASS.DAILY then
			task_manager:getDailyTaskActiveNum(0, function(arg_19_0, arg_19_1)
				if arg_19_0 == 1 then
					self:handleGetAwards(arg_19_1)
					self:handleGetDailyTaskAvtiveNum(arg_19_1)
				end

				self:setPanelMaskVisible(false, false)
			end)
		else
			task_manager:getTaskRewardOneKey((self.curClassType == PLOT_CLASS.WEEKLY or nil) and (TASK_TYPE_WEEKLY or self.curClassType), function(arg_20_0, arg_20_1)
				if arg_20_0 == 1 then
					self:handleGetAwards(arg_20_1)
				end

				self:setPanelMaskVisible(false, false)
			end)
		end
	end
end

function TopPlotListLayer:switchPlotTaskClass(arg_21_1)
	if self.curClassType == arg_21_1 then
		return
	end

	RoleDefault:getInstance():setIntegerForKey("curClassType", arg_21_1)

	self.curClassType = arg_21_1
	self.tabelView.withaction = true

	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		self.tabelView.withaction = false
	end)))
	self:setPanelMaskVisible(false)
	self.panelMask:setPositionY(-GameDisplay.fix_y)
	self:updateTopUI()
	self:updateBottomUI()
	self:updateTableViewTask()
end

function TopPlotListLayer:updateTopUI()
	if var_0_26[self.curClassType] then
		self.imgTitle:loadTexture(var_0_26[self.curClassType].bg, var_0_17)
		self.titleImg:loadTexture(var_0_26[self.curClassType].title, var_0_17)
	end

	if self.curClassType == PLOT_CLASS.CAREER then
		self.huntRewardBg:setVisible(playermodel.class ~= #PlAYER_CLASS)

		local var_23_0 = self.huntRewardBg:getChildByName("huntRewardImg")
		local var_23_1 = self.huntRewardBg:getChildByName("huntRewardNumBg"):getChildByName("huntRewardNumText")
		local var_23_2 = self.huntRewardBg:getChildByName("huntRewardNumBg"):getChildByName("HuntBtn")
		local var_23_3 = drop_manager:getEquipAllDrops("study0" .. playermodel.class)
		local var_23_4 = true

		for iter_23_0, iter_23_1 in pairs(task_manager.tasks[TASK_TYPE_CAREER]) do
			if iter_23_1.percent < 100 then
				var_23_4 = false
			end
		end

		if var_23_4 then
			var_23_2:loadTextureNormal("dailytask/can_upgrade_btn.png", var_0_17)
			l2utils:recoverShader(var_23_2:getVirtualRenderer())
		else
			var_23_2:loadTextureNormal("dailytask/hunt_btn.png", var_0_17)
			l2utils:shaderNode(var_23_2:getVirtualRenderer(), true)
		end

		if var_23_3 and var_23_3[1] and var_23_3[1].dropid then
			var_23_0:loadTextureEx(GetCurrencyIconPath(var_23_3[1].dropid))
			var_23_0:show()
			var_23_0:_setColor("#301239")
			var_23_1:setString("x" .. var_23_3[1].dropNum)
		end

		self.imgBgDiamond:setVisible(false)
	else
		self.huntRewardBg:hide()
		self.imgBgDiamond:setVisible(true)
	end

	if self.curClassType == PLOT_CLASS.DAILY_WEEKLY then
		self.labelComplete:setString(TOP_PLOT_LIST[4])
	else
		self.labelComplete:setString(L_ACTIVITY_GARRISON[21])
	end

	if var_0_23[self.curClassType] or var_0_24[self.curClassType] then
		self.labelTaskCount:setString(self:getTaskFinishLen(self.curClassType) .. "/" .. self:getTaskListMaxLen(self.curClassType))

		if self.curClassType == PLOT_CLASS.CAREER then
			self.labelTaskCount:setPosition(self.imgTitle:getContentSize().width - 165, 65)
			self.labelComplete:setPosition(self.labelTaskCount:getPositionX() - self.labelTaskCount:getContentSize().width - 45, self.labelTaskCount:getPositionY())
		else
			self.labelTaskCount:setPosition(self.imgTitle:getContentSize().width - 15, 20)
			self.labelComplete:setPosition(self.labelTaskCount:getPositionX() - self.labelTaskCount:getContentSize().width - 45, self.labelTaskCount:getPositionY())
		end

		self.labelTaskCount:setVisible(true)
		self.labelComplete:setVisible(true)
	elseif self.curClassType == PLOT_CLASS.DAILY_WEEKLY then
		self.labelTaskCount:setString(var_0_8:getRefreshRemainTime())
		self.labelComplete:setPosition(self.labelTaskCount:getPositionX() - self.labelTaskCount:getContentSize().width - 75, self.labelTaskCount:getPositionY())
		self.labelTaskCount:setVisible(true)
		self.labelComplete:setVisible(true)
	else
		self.labelTaskCount:setVisible(false)
		self.labelComplete:setVisible(false)
	end
end

function TopPlotListLayer:updateBottomUI()
	self.imgDaily:setVisible(self.curClassType == PLOT_CLASS.DAILY)
	self.activityBottomBg:setVisible(self.curClassType == PLOT_CLASS.DAILY_WEEKLY)

	local var_24_0 = false

	var_24_0 = self.curClassType == PLOT_CLASS.NORMAL and PlotManager:isHaveReward(self.curClassType) or var_0_24[self.curClassType] and achieve_manager:isHaveReward(self.curClassType) or task_manager:isHaveReward((self.curClassType == PLOT_CLASS.WEEKLY or nil) and (TASK_TYPE_WEEKLY or self.curClassType))

	if var_0_24[self.curClassType] then
		self.radioButtonAchieve:setVisible(true)
		self.imgTip:setPositionY(self.radioButtonAchieve:getPositionY() + self.radioButtonAchieve:getInnerContentSize().height + 35)
	else
		if self.curClassType == PLOT_CLASS.DAILY then
			self.imgTip:setPositionY(self.imgDaily:getPositionY() + self.imgDaily:getContentSize().height)
		else
			self.imgTip:setPositionY(self.imgBottom:getPositionY() + self.imgBottom:getContentSize().height + 35)
		end

		self.radioButtonAchieve:setVisible(false)
	end

	self.imgTip:setVisible(var_24_0)

	local var_24_1 = self.imgTip:getChildByName("labelInfo")

	var_24_1:setFontName("fonts/name.ttf")

	if var_24_0 then
		var_24_1:setString(TOP_PLOT_LIST[1])
	end

	if self.curClassType == PLOT_CLASS.CAREER then
		var_24_1:setString(TOP_PLOT_LIST[2])
		self.imgTip:setVisible(false)
	end

	self.btnWhole:setVisible(self.curClassType ~= PLOT_CLASS.CAREER)
	self.btnUpgrade:setVisible(self.curClassType == PLOT_CLASS.CAREER)

	if self.curClassType == PLOT_CLASS.DAILY_WEEKLY then
		local var_24_2 = var_0_8:getBoxsData()

		for iter_24_0 = 1, #var_24_2 do
			local var_24_3 = self.activityBottomBg._btns[iter_24_0]

			local function var_24_5(arg_25_0)
				local var_25_0 = var_0_8:getBoxRewardByIndex(arg_25_0)

				if var_25_0 == 0 then
					var_24_3._rewardImg:hide()
				else
					var_24_3._rewardImg:show()
					var_24_3._rewardNumLabel:setString("x" .. var_25_0)
				end
			end

			if iter_24_0 == 1 then
				if var_24_2[iter_24_0].percent >= 100 then
					self.activityBottomBg._btns[iter_24_0]:loadTextures("dailytask/box_receive" .. var_24_2[iter_24_0].rarity .. ".png", nil, nil, var_0_17)
					self.activityBottomBg._btns[iter_24_0]._stateImg:show()
					self.activityBottomBg._btns[iter_24_0]._stateImg:loadTextureEx("dailytask/state_receive.png")
					self.activityBottomBg._btns[iter_24_0]._progressLayout:hide()
				else
					self.activityBottomBg._btns[iter_24_0]:loadTextures("dailytask/box_doing" .. var_24_2[iter_24_0].rarity .. ".png", nil, nil, var_0_17)
					self.activityBottomBg._btns[iter_24_0]._stateImg:hide()
					self.activityBottomBg._btns[iter_24_0]._progressLayout:show()
					self.activityBottomBg._btns[iter_24_0]._progressLabel:setString(var_24_2[iter_24_0].progressStr)
					self.activityBottomBg._btns[iter_24_0]._bar:setPercentage(var_24_2[iter_24_0].percent)
				end
			else
				self.activityBottomBg._btns[iter_24_0]:loadTextures("dailytask/box_doing" .. var_24_2[iter_24_0].rarity .. ".png", nil, nil, var_0_17)
				self.activityBottomBg._btns[iter_24_0]._stateImg:show()
				self.activityBottomBg._btns[iter_24_0]._stateImg:loadTextureEx("dailytask/state_dealy.png")
				self.activityBottomBg._btns[iter_24_0]._progressLayout:hide()
			end

			var_24_5(iter_24_0)
		end
	end
end

function TopPlotListLayer:initTableViewTask()
	self.height = self.listViewTasks:getContentSize().height + GameDisplay.height - GameDisplay.origin_design_y
	self.tabelView = cc.TableView:create(cc.size(640, self.height))

	self.tabelView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tabelView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tabelView:setAnchorPoint(cc.p(0, 0))
	self.tabelView:setPosition(self.listViewTasks:getPosition())
	self.tabelView:setDelegate()
	self.panelMain:addChild(self.tabelView)
	self.activityBottomBg:setLocalZOrder(self.tabelView:getLocalZOrder() + 1)

	self.curtaskListLen = 0

	self.tabelView:registerScriptHandler(handler(self, self.numberOfCells), cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tabelView:registerScriptHandler(handler(self, self.cellSizeForIndex), cc.TABLECELL_SIZE_FOR_INDEX)
	self.tabelView:registerScriptHandler(handler(self, self.updateCellAtIndex), cc.TABLECELL_SIZE_AT_INDEX)
	self.tabelView:reloadData()
end

function TopPlotListLayer:numberOfCells(arg_27_1)
	return self.curtaskListLen
end

function TopPlotListLayer.cellSizeForIndex(arg_28_0, arg_28_1, arg_28_2)
	return var_0_35, var_0_36
end

function TopPlotListLayer:updateCellAtIndex(arg_29_1, arg_29_2)
	local var_29_0 = arg_29_1:dequeueCell()

	if not var_29_0 then
		var_29_0 = cc.TableViewCell:create()

		local var_29_1 = self:createOnePanelTask(self:dequeueTaskInfo(self.curClassType, arg_29_2 + 1), arg_29_2)

		var_29_1._index = arg_29_2 + 1

		var_29_1:setName("panelTask")
		var_29_1:setPosition(cc.p(0, 10))

		if arg_29_1.withaction and arg_29_2 < 9 then
			var_29_1:setOpacity(0)
			var_29_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_29_2), cc.FadeIn:create(0.1)))
		end

		var_29_0:addChild(var_29_1)
	else
		local var_29_2 = self:dequeueTaskInfo(self.curClassType, arg_29_2 + 1)
		local var_29_3 = var_29_0:getChildByName("panelTask")

		var_29_3._index = arg_29_2 + 1

		self:updateOnePanleTask(var_29_3, var_29_2)

		if arg_29_1.withaction and arg_29_2 < 9 then
			var_29_3:setOpacity(0)
			var_29_3:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_29_2), cc.FadeIn:create(0.1)))
		elseif var_29_3:getOpacity() < 255 then
			var_29_3:setOpacity(255)
		end
	end

	if self.startRunOutAni then
		self.startIndex = self.startIndex or arg_29_2

		local var_29_4 = LAYER_OUT_TIME / math.ceil(self.height / var_0_36)

		var_29_0:getChildByName("panelTask"):runAction(cc.Sequence:create(cc.DelayTime:create((arg_29_2 - self.startIndex + 1) * var_29_4), cc.FadeOut:create(var_29_4)))
	end

	return var_29_0
end

function TopPlotListLayer:updateTableViewTask()
	self.curtaskListLen = self:getTaskListLen(self.curClassType)

	local var_30_0 = self.imgTip:isVisible() and self.imgTip:getContentSize().height or 0

	if self.curClassType == PLOT_CLASS.DAILY then
		self.tabelView:setViewSize(cc.size(640, self.height - self.imgDaily:getContentSize().height - var_30_0 - 220))
		self.tabelView:setPosition(0, self.imgDaily:getPositionY() + self.imgDaily:getContentSize().height + var_30_0 - 30)
	elseif self.curClassType == PLOT_CLASS.DAILY_WEEKLY then
		if not self.activityBottomBg:isVisible() or not self.activityBottomBg:getContentSize().height then
			::label_30_0::

			var_30_0 = 0
		end

		self.tabelView:setViewSize(cc.size(640, self.height - self.radioButtonAchieve:getInnerContentSize().height - var_30_0 - 205))
		self.tabelView:setPosition(0, self.radioButtonAchieve:getPositionY() + self.radioButtonAchieve:getInnerContentSize().height + var_30_0 - 55)
	elseif var_0_24[self.curClassType] then
		self.tabelView:setViewSize(cc.size(640, self.height - self.radioButtonAchieve:getInnerContentSize().height - var_30_0 - 260))
		self.tabelView:setPosition(0, self.radioButtonAchieve:getPositionY() + self.radioButtonAchieve:getInnerContentSize().height + var_30_0)
	else
		self.tabelView:setViewSize(cc.size(640, self.height - var_30_0 - 260))
		self.tabelView:setPositionY(self.listViewTasks:getPositionY() + var_30_0)
	end

	self.tabelView:reloadData()
end

function TopPlotListLayer.dequeueTaskInfo(arg_31_0, arg_31_1, arg_31_2)
	if var_0_23[arg_31_1] then
		if arg_31_1 == PLOT_CLASS.WEEKLY then
			arg_31_1 = TASK_TYPE_WEEKLY
		end

		local var_31_0 = task_manager:dequeueTaskInfo(arg_31_1, arg_31_2)

		if type(var_31_0) == "table" then
			local var_31_1 = {
				taskid = var_31_0.taskid,
				name = task_data[var_31_0.taskid].name,
				des = task_data[var_31_0.taskid].task_des,
				percent = var_31_0.percent,
				jump = task_data[var_31_0.taskid].jump,
				drop = task_data[var_31_0.taskid].drop,
				order = task_data[var_31_0.taskid].order
			}

			var_31_1.img = task_data[var_31_0.taskid].image or 1
			var_31_1.medal_id = task_data[var_31_0.taskid].medal_id
			var_31_1.head_image = task_data[var_31_0.taskid].head_image

			return var_31_1
		else
			return var_31_0
		end
	elseif var_0_24[arg_31_1] then
		local var_31_2 = achieve_manager:dequeueTaskInfo(arg_31_1, arg_31_2)

		if type(var_31_2) == "table" then
			local var_31_3 = {
				taskid = var_31_2.taskid,
				name = task_data[var_31_2.taskid].name,
				des = task_data[var_31_2.taskid].task_des,
				percent = var_31_2.percent,
				jump = task_data[var_31_2.taskid].jump,
				drop = task_data[var_31_2.taskid].drop,
				order = task_data[var_31_2.taskid].order
			}

			var_31_3.img = task_data[var_31_2.taskid].image or 1
			var_31_3.medal_id = task_data[var_31_2.taskid].medal_id
			var_31_3.head_image = task_data[var_31_2.taskid].head_image

			return var_31_3
		else
			return var_31_2
		end
	elseif arg_31_1 == PLOT_CLASS.DAILY_WEEKLY then
		local var_31_4 = var_0_8:getTaskDataByIndex(arg_31_2)
		local var_31_5 = {
			taskid = var_31_4.taskid,
			name = task_data[var_31_4.taskid].name,
			des = task_data[var_31_4.taskid].task_des,
			percent = var_31_4.percent,
			jump = task_data[var_31_4.taskid].jump,
			drop = task_data[var_31_4.taskid].drop,
			order = task_data[var_31_4.taskid].order
		}

		var_31_5.img = task_data[var_31_4.taskid].image or 1
		var_31_5.medal_id = task_data[var_31_4.taskid].medal_id
		var_31_5.head_image = task_data[var_31_4.taskid].head_image
		var_31_5.active_num = task_data[var_31_4.taskid].active_num

		return var_31_5
	else
		return PlotManager:dequeueTaskInfo(arg_31_1, arg_31_2)
	end
end

local function var_0_39(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	arg_33_3 = arg_33_3 or {}

	local var_33_0 = ccui.ImageView:create(arg_33_0, arg_33_3.ConfigTextureType or var_0_17)

	if arg_33_2 then
		var_33_0:setContentSize(arg_33_2)
		var_33_0:ignoreContentAdaptWithSize(false)
	end

	local var_33_1 = cc.Label:createWithTTF(arg_33_1, arg_33_3.font or "fonts/new1.ttf", arg_33_3.fontSize or 20)

	var_33_1:setColor(arg_33_3.color or cc.c3b(171, 239, 58))
	var_33_1:setAnchorPoint(cc.p(0, 0.5))
	var_33_1:setPosition(var_33_0:getContentSize().width - (arg_33_0 == var_0_19 and 5 or 0), var_33_0:getContentSize().height / 2)
	var_33_0:addChild(var_33_1)

	local var_33_2 = ccui.Layout:create()

	var_33_2:setContentSize(cc.size(var_33_0:getContentSize().width + var_33_1:getContentSize().width, var_33_0:getContentSize().height))
	var_33_0:setAnchorPoint(cc.p(0, 0))
	var_33_0:setPosition(0, 0)
	var_33_2:addChild(var_33_0)

	return var_33_2
end

function TopPlotListLayer:initTopUI()
	self.labelComplete = ccui.Text:create(L_ACTIVITY_TASK_COMPLETE_DATA.Complete_Num, FONT_NAME, 28)
	self.labelTaskCount = ccui.Text:create("", FONT_NAME, 28)

	self.imgTitle:addChild(self.labelComplete)
	self.imgTitle:addChild(self.labelTaskCount)
	self.imgTitle:loadTexture(var_0_26[PLOT_CLASS.DAILY_WEEKLY].bg, var_0_17)
	self.labelTaskCount:setAnchorPoint(cc.p(1, 0.5))
	self.labelTaskCount:setColor(cc.c3b(60, 248, 103))
	self.labelTaskCount:setPosition(self.imgTitle:getContentSize().width - 165, 65)
	self.imgBgDiamond:setPosition(cc.p(535, 160))

	local var_35_0 = TempWidget:CreateTempImg(var_0_26[PLOT_CLASS.DAILY_WEEKLY].title, self.imgTitle)

	var_35_0:align(cc.p(1, 1), self.imgTitle:getContentSize().width - 20, self.imgTitle:getContentSize().height - 20)

	self.titleImg = var_35_0

	local var_35_1 = TempWidget:CreateTempImg("dailytask/hunt_reward_bg.png", self.imgTitle)

	var_35_1:setName("huntRewardBg")
	var_35_1:align(cc.p(0.5, 0), self.imgTitle:getContentSize().width - 80, 5)

	self.huntRewardBg = var_35_1

	local var_35_2 = TempWidget:CreateTempImg(nil, var_35_1)

	var_35_2:hide()
	var_35_2:center()
	var_35_2:setScale(0.5)
	var_35_2:setName("huntRewardImg")

	local var_35_3 = TempWidget:CreateTempImg("dailytask/hunt_reward_num_bg.png", var_35_1)

	var_35_3:setName("huntRewardNumBg")
	var_35_3:align(cc.p(0.5, 1), var_35_1:size().w / 2, 20)

	local var_35_4 = TempWidget:CreateTempLabel("", FONT_NAME, 20, var_35_3)

	var_35_4:setName("huntRewardNumText")
	var_35_4:center()

	local var_35_5 = TempWidget:CreateTempBtn("dailytask/hunt_btn.png", var_35_3)

	var_35_5:setName("HuntBtn")
	var_35_5:align(cc.p(0.5, 1), -100, 47)
	var_35_5:_addEvent(function()
		self:onBtnUpgrade()
	end)

	local var_35_6 = TempWidget:CreateTempLabel(TOP_PLOT_LIST[5], FONT_DES, 18, var_35_3)

	var_35_6:setAlignment(cc.TEXT_ALIGNMENT_LEFT)
	var_35_6:setMaxLineWidth(270)
	var_35_6:setName("huntTipsText")
	var_35_6:align(cc.p(0.5, 0), -70, 110)
end

function TopPlotListLayer:initActivityBottomBg()
	self.activityBottomBg = TempWidget:CreateTempImg("dailytask/activity_bottom_bg.png", self.panelMain)

	self.activityBottomBg:align(cc.p(0.5, 0), cc.p(self.imgDaily:getPosition()))
	self.activityBottomBg:hide()
	self.activityBottomBg:_addEvent(function()
		return
	end)

	self.activityBottomBg._btns = {}

	for iter_37_0 = 1, var_0_8.BoxNum do
		local var_37_0 = TempWidget:CreateTempBtn("dailytask/box_doing1.png", self.activityBottomBg)

		var_37_0:align(cc.p(0.5, 0.5), 120 + (iter_37_0 - 1) * 195, self.activityBottomBg:size().h / 2 + 15)

		self.activityBottomBg._btns[iter_37_0] = var_37_0

		if iter_37_0 == 1 then
			var_37_0:_addEvent(function()
				var_0_8:requestGetBoxReward(function()
					if var_0_18 then
						self:updateBottomUI()
						self:updateTaskAlert()
					end
				end)
			end)
		end

		local var_37_1 = TempWidget:CreateTempImg("dailytask/state_dealy.png", var_37_0)

		var_37_1:align(cc.p(0.5, 1), var_37_0:size().w / 2, 20)
		var_37_1:hide()

		var_37_0._stateImg = var_37_1

		local var_37_2 = TempWidget:CreateTempLayout(var_37_0)

		var_37_2:hide()
		var_37_2:setContentSize(cc.size(110, 30))
		var_37_2:align(cc.p(0.5, 1), var_37_0:size().w / 2, 12)

		var_37_0._progressLayout = var_37_2

		local var_37_3 = TempWidget:CreateTempImg("dailytask/box_progress_bg.png", var_37_2)

		var_37_3:align(cc.p(0.5, 1), var_37_2:size().w / 2, var_37_2:size().h)

		local var_37_4 = cc.ProgressTimer:create((TempWidget:CreateTempSprite("dailytask/box_progress.png")))

		var_37_4:setType(cc.PROGRESS_TIMER_TYPE_BAR)
		var_37_4:setBarChangeRate(cc.p(1, 0))
		var_37_4:setMidpoint(cc.p(0, 0))
		var_37_4:setAnchorPoint(cc.p(0.5, 1))
		var_37_2:addChild(var_37_4)
		var_37_4:setPosition(var_37_3:pos())
		var_37_4:setPercentage(20)

		var_37_0._bar = var_37_4

		local var_37_5 = TempWidget:CreateTempLabel("0/0", FONT_NAME, 18, var_37_2)

		var_37_5:align(cc.p(0.5, 0), var_37_2:property().top_bottom)

		var_37_0._progressLabel = var_37_5

		local var_37_6 = TempWidget:CreateTempImg("dailytask/reward_tips.png", var_37_0)

		var_37_6:setVisible(iter_37_0 == 1)
		var_37_6:align(cc.p(0.5, 0.5), var_37_0:size().w + 15, var_37_0:size().h)

		var_37_0._rewardImg = var_37_6

		local var_37_7 = TempWidget:CreateTempImg("public/currency/888888.png", var_37_6)

		var_37_7:align(cc.p(0.5, 0.5), var_37_6:size().w / 2 - 25, var_37_6:size().h / 2 + 7)

		local var_37_8 = TempWidget:CreateTempLabel("x0", FONT_NAME, 18, var_37_6)

		var_37_8:align(cc.p(0, 0.5), 58, var_37_7:pos().y)

		var_37_0._rewardNumLabel = var_37_8
	end
end

function TopPlotListLayer:initDailyUI()
	self.imgDaily:loadTexture("dailytask/bg_daily.png", var_0_17)

	self.progressDaily = self.imgDaily:getChildByName("progressDaily")

	local var_41_0 = self.progressDaily:getChildByName("label_" .. 1)

	if var_41_0 then
		var_41_0:setFontName("fonts/name.ttf")
		var_41_0:setString("" .. 0)
	end

	local var_41_1 = self.progressDaily:getContentSize().width

	for iter_41_0, iter_41_1 in ipairs((Utility:convertTableToSequence(require("data.daily_task_reward_data"), function(arg_42_0, arg_42_1)
		return arg_42_0.active_num < arg_42_1.active_num
	end))) do
		local var_41_2 = Utility:getDropData(iter_41_1.dropid)
		local var_41_3 = self.progressDaily:getChildByName("imgPoint_" .. iter_41_0)
		local var_41_4 = self.progressDaily:getChildByName("label_" .. iter_41_0 + 1)

		if not var_41_3 or not var_41_4 then
			return
		end

		var_41_4:setFontName("fonts/name.ttf")
		var_41_4:setString("" .. iter_41_1.active_num)

		local var_41_5 = math.floor(var_41_1 * iter_41_1.active_num / 100) - 2

		var_41_3:setPositionX(var_41_5)
		var_41_4:setPositionX(var_41_5)

		for iter_41_2, iter_41_3 in ipairs(var_41_2) do
			local var_41_6

			if iter_41_3.itemid == "diamond" then
				var_41_6 = var_0_39(var_0_19, "X" .. iter_41_3.num, nil, {
					fontSize = 20,
					font = "fonts/number.ttf",
					color = cc.c3b(255, 255, 255)
				})

				var_41_6:setPosition(-45, 18 + (iter_41_2 - 1) * 35)
			elseif type(iter_41_3.itemid) == "number" then
				var_41_6 = var_0_39("equipment/" .. item_data[iter_41_3.itemid].image_id .. ".png", "X" .. iter_41_3.num, cc.size(36, 36), {
					fontSize = 20,
					font = "fonts/number.ttf",
					ConfigTextureType = 0,
					color = cc.c3b(255, 255, 255)
				})

				var_41_6:setPosition(-30, 18 + (iter_41_2 - 1) * 35)
				Utility:addClickEventListener(var_41_6, function()
					LayerManager:pushInLayer("PopItemLayer", {
						itemid = iter_41_3.itemid
					})
				end)
			end

			if var_41_6 then
				var_41_6:setScale(0.8)
				var_41_3:addChild(var_41_6)
			end
		end
	end
end

function TopPlotListLayer:createOnePanelTask(arg_44_1, arg_44_2)
	local var_44_0 = self.panelItem:clone()
	local var_44_1 = TempWidget:CreateTempBtn("dailytask/task_refresh_btn.png", var_44_0:getChildByName("imgBorder"))

	var_44_1:setName("taskRefreshBtn")
	var_44_1:hide()
	var_44_1:_addEvent(function()
		var_0_8:requestRefresh(var_44_0._index, function(arg_46_0)
			if var_0_18 then
				self:updateTopUI()
				self:updateOnePanleTask(var_44_0, self:dequeueTaskInfo(self.curClassType, var_44_0._index), {
					dailyWeeklyAnima = true
				})
				self:updateTaskAlert()
			end
		end)
	end, {
		touchDelay = 0.5
	})
	var_44_1:align(cc.p(0, 1), 0, var_44_0:getChildByName("imgBorder"):getContentSize().height + 7)

	local var_44_2 = TempWidget:CreateTempLayout(var_44_0)

	var_44_2:setName("activeNumLayout")
	var_44_2:setContentSize(cc.size(200, 100))
	var_44_2:align(cc.p(0.5, 0.5), var_44_0:getContentSize().width * 0.7, var_44_0:getContentSize().height * 0.5)
	TempWidget:CreateTempImg("dailytask/active_num_img.png", var_44_2):align(cc.p(0, 0.5), 10, var_44_2:size().h / 2)

	local var_44_3 = TempWidget:CreateTempLabel("+10", FONT_W5, 36, var_44_2)

	var_44_2._activeNumLabel = var_44_3

	var_44_3:align(cc.p(0, 0.5), var_44_2:size().w * 0.6, var_44_2:size().h / 2 + 10)

	local var_44_4 = TempWidget:CreateTempLabel(L_PLAYER_DATA_TYPE.Active, FONT_NAME, 24, var_44_2)

	var_44_2._activeNumTipLabel = var_44_4

	var_44_4:align(cc.p(0, 0.5), var_44_3:pos().x, var_44_2:size().h / 2 - 25)

	var_44_0.index = arg_44_2

	var_44_0:setSwallowsTouches(false)

	local var_44_5 = var_44_0:getChildByName("imgTask")
	local var_44_6 = var_44_0:getChildByName("labelTitle")
	local var_44_7 = var_44_0:getChildByName("labelInfo")

	var_44_7:setContentSize(cc.size(500, 46))
	var_44_6:setFontName("fonts/name.ttf")
	var_44_7:setFontName("fonts/name.ttf")
	var_44_0:getChildByName("labelProgress"):setFontName("fonts/number.ttf")
	self:updateOnePanleTask(var_44_0, arg_44_1)

	local var_44_8 = var_44_0:getChildByName("imgBorder")

	var_44_8:setLocalZOrder(-100)

	local var_44_9 = TempWidget:CreateTempImg("dailytask/task_title_bg.png", var_44_8)

	var_44_9:setName("labelTitleBg")
	var_44_9:align(cc.p(0, 1), 0, var_44_8:getContentSize().height - 15)
	var_44_5:setLocalZOrder(var_44_8:getLocalZOrder() + 1)
	var_44_6:setLocalZOrder(var_44_5:getLocalZOrder() + 1)
	var_44_7:setLocalZOrder(var_44_5:getLocalZOrder() + 1)
	var_44_1:setLocalZOrder(1000)

	return var_44_0
end

function TopPlotListLayer:updateOnePanleTask(arg_47_1, arg_47_2, arg_47_3)
	local var_47_0
	local var_47_1 = false

	if type(arg_47_2) == "table" then
		var_47_0 = arg_47_2
	elseif type(arg_47_2) == "number" then
		var_47_0 = task_data[arg_47_2]
		var_47_1 = true
	end

	self:updatePanleTask(arg_47_1, var_47_0, var_47_1, arg_47_3)
end

function TopPlotListLayer:updatePanleTask(arg_48_1, arg_48_2, arg_48_3, arg_48_4)
	if not arg_48_2 then
		return
	end

	arg_48_4 = arg_48_4 or {}

	if arg_48_4.dailyWeeklyAnima then
		local var_48_0 = arg_48_1:clone()

		arg_48_1:getParent():addChild(var_48_0)

		local var_48_1 = cc.p(arg_48_1:getPosition())

		var_48_0:setPosition(var_48_1)
		var_48_0:runAction(cc.Sequence:create(cc.MoveBy:create(0.3, cc.p(-640, 0)), cc.RemoveSelf:create()))
		arg_48_1:setPosition(cc.p(var_48_1.x + 640, var_48_1.y))
		arg_48_1:runAction(cc.Sequence:create(cc.MoveBy:create(0.3, cc.p(-640, 0))))
	end

	local var_48_2 = arg_48_1:getChildByName("imgBorder")

	var_48_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_48_2:setPositionX(arg_48_1:getContentSize().width / 2)
	var_48_2:getChildByName("taskRefreshBtn"):setVisible(self.curClassType == PLOT_CLASS.DAILY_WEEKLY)

	local var_48_3 = arg_48_1:getChildByName("activeNumLayout")

	var_48_3:setVisible(self.curClassType == PLOT_CLASS.DAILY_WEEKLY)

	local var_48_4 = arg_48_1:getChildByName("imgTask")
	local var_48_5 = arg_48_1:getChildByName("progressbg")
	local var_48_6 = arg_48_1:getChildByName("progressbar")
	local var_48_7 = arg_48_1:getChildByName("labelProgress")
	local var_48_8 = arg_48_1:getChildByName("imgMask")
	local var_48_9 = arg_48_1:getChildByName("btnStatus")

	if not arg_48_3 then
		Utility:addClickEventListener(var_48_9, handler(self, self.onBtnStatus), arg_48_2)
	end

	var_48_9:setTouchEnabled(not arg_48_3)
	arg_48_1:getChildByName("labelTitle"):setString(arg_48_2.name)
	arg_48_1:getChildByName("labelInfo"):setString(arg_48_2.des or arg_48_2.task_des or "")

	if self.curClassType == PLOT_CLASS.DAILY_WEEKLY then
		var_48_3._activeNumLabel:setString("+" .. arg_48_2.active_num)
	end

	local task_data = require("data.task_data")

	if not arg_48_3 then
		var_48_6:setPercent(arg_48_2.percent)
		var_48_7:setString(arg_48_2.percent .. "%")

		if task_data[arg_48_2.taskid] and task_data[arg_48_2.taskid].needs_type and task_data[arg_48_2.taskid].needs_type == 1 then
			if arg_48_2.percent == 100 then
				var_48_6:setPercent(100)
				var_48_7:setString("100%")
			else
				var_48_6:setPercent(0)
				var_48_7:setString("0%")
			end
		end

		if arg_48_2.percent == 100 then
			var_48_2:loadTexture("dailytask/img_border_1.png", var_0_17)
			var_48_9:loadTextures("dailytask/btn_get.png", nil, "dailytask/btn_get.png", var_0_17)
		else
			var_48_2:loadTexture("dailytask/img_border_2.png", var_0_17)
			var_48_9:loadTextures("dailytask/btn_go.png", nil, "dailytask/btn_go.png", var_0_17)
		end
	else
		var_48_6:setPercent(100)
		var_48_2:loadTexture("dailytask/img_border_1.png", var_0_17)
		var_48_9:loadTextures("dailytask/btn_rewarded.png", nil, "dailytask/btn_rewarded.png", var_0_17)
	end

	var_48_8:setLocalZOrder(5)
	var_48_8:setVisible(arg_48_3)
	var_48_5:setVisible(not arg_48_3)
	var_48_6:setVisible(not arg_48_3)
	var_48_7:setVisible(not arg_48_3)
	self:updateLabelColor(arg_48_1, arg_48_2, arg_48_3)
	self:updateTaskImg(arg_48_1, var_48_4, arg_48_2)
	self:updateAwardList(arg_48_1, arg_48_2)
end

function TopPlotListLayer:updateLabelColor(arg_49_1, arg_49_2, arg_49_3)
	local var_49_0 = arg_49_1:getChildByName("labelTitle")

	var_49_0:setFontSize(24)

	if arg_49_2.medal_id then
		var_49_0:setPosition(cc.p(20, 80))
	elseif self.curClassType == PLOT_CLASS.NORMAL then
		var_49_0:setPosition(cc.p(20, 80))
	else
		var_49_0:setPosition(cc.p(80, 80))
	end

	local var_49_1 = arg_49_1:getChildByName("labelInfo")

	var_49_1:setFontSize(20)
	var_49_1:setPosition(cc.p(20, 27))

	local var_49_2 = arg_49_1:getChildByName("labelProgress")

	var_49_2:setFontSize(18)

	if not arg_49_3 then
		var_49_0:setColor(cc.c3b(255, 255, 255))
		var_49_1:setColor(cc.c3b(255, 255, 255))
		var_49_2:setColor(cc.c3b(255, 255, 255))
	else
		var_49_0:setColor(cc.c3b(255, 255, 255))
		var_49_1:setColor(cc.c3b(255, 255, 255))
		var_49_2:setColor(cc.c3b(255, 255, 255))
	end

	if self.curClassType == PLOT_CLASS.DAILY_WEEKLY then
		local var_49_3 = arg_49_1:getChildByName("activeNumLayout")._activeNumTipLabel

		if arg_49_2.percent == 100 then
			var_49_3:setColor(cc.c3b(135, 231, 255))
		else
			var_49_3:setColor(cc.c3b(194, 147, 255))
		end
	end
end

function TopPlotListLayer:updateTaskImg(arg_50_1, arg_50_2, arg_50_3)
	local var_50_0
	local var_50_1

	arg_50_2:setVisible(true)

	if arg_50_3.head_image then
		var_50_0 = ROLE_HEAD_IMAGE_PATH .. (arg_50_3.head_image or 1) .. ".png"
		var_50_1 = 0.5

		if arg_50_1:getChildByName("medal") then
			arg_50_1:getChildByName("medal"):removeFromParent()
		end
	elseif arg_50_3.medal_id then
		local var_50_3 = item_data[tonumber(arg_50_3.medal_id)]

		if var_50_3.bg then
			var_50_0 = "equipment/" .. var_50_3.bg .. ".png" or var_0_32[var_50_3.equip_quality]
		end

		var_50_1 = 0.5

		arg_50_2:setVisible(false)
	else
		var_50_0 = var_0_34 .. ((not arg_50_3.img or nil) and (arg_50_3.image or 1)) .. ".png"
		var_50_1 = self.curClassType == PLOT_CLASS.NORMAL and 1 or self.curClassType == PLOT_CLASS.DAILY_WEEKLY and 1 or 0.5

		if arg_50_1:getChildByName("medal") then
			arg_50_1:getChildByName("medal"):removeFromParent()
		end
	end

	arg_50_2:loadTexture(var_50_0)
	arg_50_2:setScale(var_50_1)
	arg_50_2:setAnchorPoint(cc.p(0, 0.5))

	if self.curClassType == PLOT_CLASS.NORMAL then
		arg_50_2:setPosition(cc.p(10, arg_50_1:getContentSize().height - 37))
	elseif self.curClassType == PLOT_CLASS.DAILY_WEEKLY then
		arg_50_2:setPosition(cc.p(10, arg_50_1:getContentSize().height - 37))
	else
		arg_50_2:setPosition(cc.p(15, arg_50_1:getContentSize().height - 37))
	end

	if arg_50_3.medal_id then
		local var_50_5 = arg_50_1:getChildByName("bg")
		local var_50_6 = item_data[tonumber(arg_50_3.medal_id)]

		if not var_50_5 then
			var_50_5 = ccui.ImageView:create(var_0_31[var_50_6.equip_quality], var_0_17)

			var_50_5:ignoreContentAdaptWithSize(false)
			var_50_5:setPositionX(arg_50_2:getPositionX() + 4)
			var_50_5:setPositionY(arg_50_2:getPositionY() - 4)
			arg_50_1:addChild(var_50_5)
			var_50_5:setName("bg")
		end

		var_50_5:setVisible(true)
		var_50_5:setContentSize(86, 86)
		var_50_5:loadTexture(var_0_31[var_50_6.equip_quality], var_0_17)
		var_50_5:setVisible(false)
	elseif arg_50_1:getChildByName("bg") then
		arg_50_1:getChildByName("bg"):setVisible(false)
	end
end

function TopPlotListLayer:onBtnStatus(arg_51_1, arg_51_2)
	if arg_51_2.percent < 100 then
		self:onBtnTaskJump(arg_51_1, arg_51_2)
	elseif arg_51_2.percent == 100 then
		self:confirmAwards(arg_51_2.taskid, arg_51_1)
	end
end

function TopPlotListLayer.onBtnTaskJump(arg_52_0, arg_52_1, arg_52_2)
	print("taskinfo.jump = ", arg_52_2.jump)

	if arg_52_2.jump == 130 then
		LayerManager:pushInLayer("SignLayerNew", {
			callback = function()
				if var_0_18 then
					arg_52_0:useMidasAfterUpdate()
				end
			end
		})
	elseif arg_52_2.jump == 111 then
		require("controller.sign_manager"):createMidasLayer(function()
			if var_0_18 then
				arg_52_0:useMidasAfterUpdate()
			end
		end)
	elseif arg_52_2.jump == 220 then
		LayerManager:pushInLayer("FightResultLayerNew", {
			createItemType = "itemid",
			items = playermodel.dropcache,
			surecallback = function()
				if FightLayer and FightLayer.getInstance() then
					ccui.Helper:seekWidgetByName(FightLayer.getInstance().rootNode, "dropcache"):checkPlayerDropCache()
					AnalyticManager.collectDropcache()
				end
			end,
			cancelcallback = function()
				return
			end
		}, {
			exitCallback = function()
				if var_0_18 then
					arg_52_0:useMidasAfterUpdate()
				end
			end
		})
	elseif arg_52_2.jump == 400001 then
		LayerManager:switchShowLayer((require("controller.community_system_manager"):getInintJumpLayerName()))
	elseif arg_52_2.jump == 1313 then
		if not require("controller.level_manager"):isChapterPass(2, 5) then
			global_ShowBlockWords(L_PATROL_LIST_LOCK)

			return
		end

		LayerManager:pushInLayer("PatrolFightLayer", {
			exitCallback = function(...)
				if var_0_18 then
					arg_52_0:useMidasAfterUpdate()
				end
			end
		})
	elseif arg_52_2.jump == 1307 then
		substitution_manager:get_substitution_list(function(arg_59_0)
			if not arg_59_0 or not next(arg_59_0) then
				global_ShowBlockWords(L_SUBSTUTUTION_NULL)
			elseif #arg_59_0 == 1 then
				LayerManager:switchShowLayer("SubstitutionLayer", {
					mode = arg_59_0[1].mode,
					endtime = arg_59_0[1].remaintime
				})
			else
				LayerManager:switchShowLayer(SYSTEMID[arg_52_2.jump])
			end
		end)
	elseif arg_52_2.jump then
		require("controller.goto_system_manager")

		local var_52_0 = {
			jump_to_system = arg_52_2.jump
		}

		var_52_0.config = system_jump_config[SYSTEMID[arg_52_2.jump]] and global_deepCopy(system_jump_config[SYSTEMID[arg_52_2.jump]].config)

		if var_52_0.config then
			if var_52_0.config.exitCallbackType == "function" then
				var_52_0.config.exitCallback = nil
			elseif var_52_0.config.exitCallbackType == "string" then
				var_52_0.config = "MainLayer"
			end
		end

		goto_complete_system(var_52_0)
	end
end

function TopPlotListLayer:updateAwardList(arg_60_1, arg_60_2)
	local var_60_0 = arg_60_1:getChildByName("listViewRewards")

	var_60_0:setPositionY(50)
	var_60_0:setTouchEnabled(false)
	var_60_0:setClippingEnabled(false)
	var_60_0:setVisible((not not arg_60_2.drop or self.curClassType == PLOT_CLASS.DAILY) and self.curClassType ~= PLOT_CLASS.DAILY_WEEKLY)

	if not arg_60_2.drop and self.curClassType ~= PLOT_CLASS.DAILY then
		return
	end

	local var_60_1 = {}

	if self.curClassType ~= PLOT_CLASS.DAILY then
		var_60_1 = Utility:getDropData(arg_60_2.drop)
	else
		local var_60_2 = {}
		local var_60_3 = {
			itemid = "active"
		}

		var_60_3.num = task_data[arg_60_2.taskid or arg_60_2.id].active_num or 0
		var_60_2[1] = var_60_3
		var_60_1 = var_60_2
	end

	var_60_0:setItemsMargin(-20)
	var_60_0:removeAllItems()

	for iter_60_0, iter_60_1 in ipairs(var_60_1) do
		local var_60_4 = ItemSpriteActivityRecharge:createSignItem(var_60_1[iter_60_0].itemid, var_60_1[iter_60_0].num)

		var_60_4:setScale(0.7)
		var_60_4:setLabelNumFontSize(25)
		var_60_0:pushBackCustomItem(var_60_4)
		var_60_4:addClickEventListener(handler(self, self.onBtnItem), var_60_1[iter_60_0].itemid)
	end

	local var_60_5 = var_60_0:getItems()
	local var_60_6 = 0

	for iter_60_2, iter_60_3 in ipairs(var_60_5) do
		var_60_6 = iter_60_3:getContentSize().width * 0.7 + var_60_6
	end

	var_60_0:setPositionX(340 + (var_60_0:getContentSize().width - (var_60_6 + math.max((#var_60_5 - 1) * 10, 10))))
end

function TopPlotListLayer.onBtnItem(arg_61_0, arg_61_1, arg_61_2)
	if type(arg_61_2) ~= "number" then
		return
	end

	LayerManager:pushInLayer("PopItemLayer", {
		itemid = arg_61_2
	})
end

function TopPlotListLayer:confirmAwards(arg_62_1, arg_62_2)
	local function var_62_0(arg_63_0, arg_63_1)
		if arg_63_0 == 1 then
			self:handleGetAwards(arg_63_1, arg_62_2)

			if self.curClassType == PLOT_CLASS.DAILY then
				self:handleGetDailyTaskAvtiveNum(arg_63_1)
			end
		end
	end

	if self.curClassType == PLOT_CLASS.DAILY then
		task_manager:getDailyTaskActiveNum(arg_62_1, var_62_0)
	elseif var_0_23[self.curClassType] then
		task_manager:getTaskReward(arg_62_1, var_62_0)
	elseif var_0_24[self.curClassType] then
		achieve_manager:getTaskReward(arg_62_1, var_62_0)
	elseif self.curClassType == PLOT_CLASS.DAILY_WEEKLY then
		var_0_8:requestGetRewardByTaskId(arg_62_1, var_62_0)
	else
		PlotManager:finishPlot(arg_62_1, var_62_0)
	end
end

function TopPlotListLayer:updateTaskAlert()
	local var_64_0 = true

	if playermodel.class == #PlAYER_CLASS then
		var_64_0 = false
	else
		for iter_64_0, iter_64_1 in pairs(task_manager.tasks[TASK_TYPE_CAREER]) do
			if iter_64_1.percent < 100 then
				var_64_0 = false
			end
		end
	end

	local var_64_1 = false

	for iter_64_2, iter_64_3 in pairs(var_0_27) do
		local var_64_2 = (iter_64_2 ~= PLOT_CLASS.NORMAL or #PlotManager.topPlotList ~= 0 or nil) and (iter_64_2 ~= PLOT_CLASS.ACTIVITY or #PlotManager.topActivityPlotList ~= 0 or nil) and self:dequeueTaskInfo(iter_64_2, 1)

		if iter_64_2 == PLOT_CLASS.DAILY_WEEKLY then
			if var_0_8:haveTaskComplete() or var_0_8:haveBoxReward() then
				var_0_27[iter_64_2] = true

				if var_0_24[iter_64_2] then
					var_64_1 = true
				end
			else
				var_0_27[iter_64_2] = false
			end
		elseif type(var_64_2) == "table" and var_64_2.percent >= 100 then
			var_0_27[iter_64_2] = true

			if var_0_24[iter_64_2] then
				var_64_1 = true
			end
		else
			var_0_27[iter_64_2] = false
		end

		local var_64_4 = cc.p(0, 0)

		var_64_4 = var_0_24[iter_64_2] and cc.p(97, 40) or cc.p(120, 74)

		local var_64_5 = iter_64_2 == PLOT_CLASS.DAILY and self.totalActiveNum >= 100

		if iter_64_2 == PLOT_CLASS.CAREER then
			AlertManager:add_redDot(self:queryAlertNodeByClassType(iter_64_2), var_64_0 or var_0_27[iter_64_2], var_64_4)
		else
			AlertManager:add_redDot(self:queryAlertNodeByClassType(iter_64_2), (var_0_27[iter_64_2] or nil) and not var_64_5, var_64_4)
		end
	end

	AlertManager:add_redDot(self:queryAlertNodeByClassType(PLOT_CLASS.ACHIEVE), var_64_1, cc.p(120, 74))
end

function TopPlotListLayer.showGetDiamondAni(arg_65_0, arg_65_1)
	require("controller.audio_manager"):playeffectMusicTest("sound/gain_diamond")
	cc.SpriteFrameCache:getInstance():addSpriteFrames("effect/gain_diamond/jinbi.plist")
	cc.SpriteFrameCache:getInstance():addSpriteFrames("effect/gain_diamond/feizou.plist")

	local var_65_0 = cc.Sprite:createWithSpriteFrameName("jinbi01.png")

	var_65_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_65_0:setPosition(320, GameDisplay.height / 2)
	var_65_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
		local var_66_0 = cc.Sprite:createWithSpriteFrameName("feizou_00001.png")

		var_66_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_66_0:setPosition(270, 468)
		var_66_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.6666666666666666), cc.CallFunc:create(arg_65_1), cc.RemoveSelf:create()))

		local var_66_1 = cc.Animation:create()

		for iter_66_0 = 1, 14 do
			var_66_1:addSpriteFrame((cc.SpriteFrameCache:getInstance():getSpriteFrame(string.format("feizou_%05d.png", iter_66_0))))
		end

		var_66_1:setDelayPerUnit(0.047619047619047616)
		var_66_1:setRestoreOriginalFrame(false)
		var_66_0:runAction(cc.Animate:create(var_66_1))
		var_66_0:runAction(cc.MoveTo:create(0.6666666666666666, cc.p(540, 1107)))
		global_basic_scene:addChild(var_66_0, 100000)
	end), cc.RemoveSelf:create()))

	local var_65_1 = cc.Animation:create()

	for iter_65_0 = 1, 7 do
		var_65_1:addSpriteFrame((cc.SpriteFrameCache:getInstance():getSpriteFrame(string.format("jinbi%02d.png", iter_65_0))))
	end

	var_65_1:setDelayPerUnit(0.0625)
	var_65_1:setRestoreOriginalFrame(false)
	var_65_0:runAction(cc.Animate:create(var_65_1))
	global_basic_scene:addChild(var_65_0, 100000)
end

function TopPlotListLayer:initDiamondNum()
	self.labelDiamond:setString(global_trans_number(playermodel.diamond))
end

function TopPlotListLayer:updateDiamondNum()
	self.labelDiamond:setString(global_trans_number(playermodel.diamond))
	self.labelDiamond:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1.2), cc.ScaleTo:create(0.2, 1)))
end

function TopPlotListLayer:updateShowingCells()
	local var_69_0, var_69_1 = GetTableViewShowCellIdx(self.tabelView, {
		cellsize = cc.size(var_0_35, var_0_36),
		maxcount = self.curtaskListLen
	})

	for iter_69_0 = var_69_0, var_69_1 do
		self.tabelView:updateCellAtIndex(iter_69_0)
	end
end

function TopPlotListLayer.useMidasAfterUpdate(arg_70_0)
	PlotManager:get_top_task_list(function()
		if arg_70_0.curClassType == PLOT_CLASS.DAILY_WEEKLY then
			var_0_8:requestRefreshInfo(function()
				arg_70_0:switchPageByClassType(PLOT_CLASS.DAILY_WEEKLY)
				arg_70_0:updateTaskAlert()
				arg_70_0:updateDiamondNum()
				arg_70_0:updateShowingCells()
				arg_70_0:updateTopUI()
				arg_70_0:updateBottomUI()
			end)
		else
			arg_70_0:switchPageByClassType(2)
			arg_70_0:updateTaskAlert()
			arg_70_0:updateDiamondNum()
			arg_70_0:updateShowingCells()
			arg_70_0:updateTopUI()
			arg_70_0:updateBottomUI()
		end
	end)
end

function TopPlotListLayer:upPlayerClassAni()
	local var_73_0 = ccui.Layout:create()

	var_73_0:setTouchEnabled(true)
	var_73_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_73_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_73_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_73_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_73_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_73_0:setBackGroundColorOpacity(180)
	self:addChild(var_73_0, 10000)
	audio_manager:playeffectMusic(CLASS_UPGRADE_EFFECT)
	var_73_0:addChild((armature_manager:createAndPlayArmature("playerUpClass", {
		grade1 = var_0_30[playermodel.class - 1],
		grade2 = var_0_30[playermodel.class]
	}, {})))
	var_73_0:runAction(cc.Sequence:create(cc.DelayTime:create(10), cc.RemoveSelf:create()))
	var_73_0:addTouchEventListener(function(arg_74_0, arg_74_1)
		if arg_74_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_73_0:runAction(cc.RemoveSelf:create())
	end)
end

function TopPlotListLayer:layerOutAni(arg_75_1)
	self.startRunOutAni = true

	self:updateShowingCells()
	self.rootNode:runAction(cc.Sequence:create(cc.DelayTime:create(LAYER_OUT_TIME), cc.CallFunc:create(arg_75_1)))
end

function TopPlotListLayer:fullScreen()
	self.imgTitle:setPositionType(0)
	self.imgTitle:setPositionY(self.imgTitle:getPositionY() - GameDisplay.statusbar_height)
end

function TopPlotListLayer:exit()
	self:layerOutAni(function()
		LayerManager:removePopLayer()
	end)
end

function TopPlotListLayer.getTaskFinishLen(arg_79_0, arg_79_1)
	if var_0_24[arg_79_1] then
		return achieve_manager:getTaskFinishLen(arg_79_1)
	else
		if arg_79_1 == PLOT_CLASS.WEEKLY then
			arg_79_1 = TASK_TYPE_WEEKLY
		end

		return task_manager:getTaskFinishLen(arg_79_1)
	end
end

function TopPlotListLayer.getTaskListMaxLen(arg_80_0, arg_80_1)
	if var_0_24[arg_80_1] then
		return achieve_manager:getTaskListMaxLen(arg_80_1)
	else
		if arg_80_1 == PLOT_CLASS.WEEKLY then
			arg_80_1 = TASK_TYPE_WEEKLY
		end

		return task_manager:getTaskListMaxLen(arg_80_1)
	end
end

function TopPlotListLayer.getTaskListLen(arg_81_0, arg_81_1)
	if arg_81_1 == PLOT_CLASS.WEEKLY then
		return task_manager:getTaskListLen(TASK_TYPE_WEEKLY)
	elseif arg_81_1 == PLOT_CLASS.DAILY then
		return task_manager:getTaskListLen(TASK_TYPE_DAILY)
	elseif arg_81_1 == PLOT_CLASS.CAREER then
		return task_manager:getTaskListLen(TASK_TYPE_CAREER)
	elseif arg_81_1 == PLOT_CLASS.ACHIEVE then
		return task_manager:getTaskListLen(TASK_TYPE_ACHIEVE)
	elseif arg_81_1 == PLOT_CLASS.ACTIVITY then
		return #PlotManager.topActivityPlotList
	elseif arg_81_1 == PLOT_CLASS.NORMAL then
		return #PlotManager.topPlotList
	elseif var_0_24[arg_81_1] then
		return achieve_manager:getTaskListLen(arg_81_1)
	elseif arg_81_1 == PLOT_CLASS.DAILY_WEEKLY then
		return var_0_8:getTaskDataNum()
	end
end

function TopPlotListLayer:initRadioSwitch()
	self.radioButtonSwitch = require("view.Sprite.RadioButtonGroup"):create({
		space = -15
	})

	self.radioButtonSwitch:setPosition(80, 0)
	self.panelMain:addChild(self.radioButtonSwitch, var_0_37.RADIO_SWITCH)

	for iter_82_0, iter_82_1 in ipairs(var_0_28) do
		local var_82_0 = ccui.Button:create(var_0_25[iter_82_1].off, var_0_25[iter_82_1].on, var_0_25[iter_82_1].on, var_0_17)

		var_82_0:setName("classBnt" .. iter_82_1)
		var_82_0:setScale(0.9)
		self.radioButtonSwitch:addButton(var_82_0)
	end

	self.radioButtonSwitch:setClippingEnabled(true)
	self.radioButtonSwitch:setMaxContentSize(cc.size(560, 1000))
	self.radioButtonSwitch:doLayout()
	self.radioButtonSwitch:registerClickEvent(handler(self, self.onRadioSwitch))
end

function TopPlotListLayer:onRadioSwitch(arg_83_1)
	local var_83_0 = var_0_28[arg_83_1]

	if not var_0_28[arg_83_1] then
		return
	end

	if self.curClassType == var_0_28[arg_83_1] then
		return
	end

	if var_0_28[arg_83_1] == PLOT_CLASS.DAILY then
		self.isSwitchAchieve = false

		EventManager:requestGetDailyTaskInfo()
	end

	if var_0_28[arg_83_1] == PLOT_CLASS.DAILY_WEEKLY then
		self.isSwitchAchieve = false

		var_0_8:requestInfo(function(arg_84_0)
			if var_0_18 then
				self.isSwitchAchieve = true

				self:switchPlotTaskClass(var_83_0)
				self:updateTaskAlert()
			end
		end)

		return
	end

	if var_0_28[arg_83_1] ~= PLOT_CLASS.ACHIEVE then
		self.isSwitchAchieve = true

		self:switchPlotTaskClass(var_0_28[arg_83_1])
	else
		self.radioButtonAchieve:setSelectedButton(1, true)
	end
end

function TopPlotListLayer:initRadioAchieve()
	self.radioButtonAchieve = require("view.Sprite.RadioButtonGroup"):create({
		space = 2
	})

	self.radioButtonAchieve:setPosition(0, self.radioButtonSwitch:getPositionY() + self.radioButtonSwitch:getInnerContentSize().height)
	self.panelMain:addChild(self.radioButtonAchieve, var_0_37.RADIO_ACHIEVE)

	for iter_85_0, iter_85_1 in ipairs(var_0_29) do
		self.radioButtonAchieve:addButton((ccui.Button:create(var_0_25[iter_85_1].off, var_0_25[iter_85_1].on, var_0_25[iter_85_1].on, var_0_17)))
	end

	self.radioButtonAchieve:setClippingEnabled(true)
	self.radioButtonAchieve:doLayout()
	self.radioButtonAchieve:registerClickEvent(handler(self, self.onRadioAchieve))
end

function TopPlotListLayer:onRadioAchieve(arg_86_1)
	if not var_0_29[arg_86_1] then
		return
	end

	if self.curClassType == var_0_29[arg_86_1] then
		return
	end

	self:switchPlotTaskClass(var_0_29[arg_86_1])
end

function TopPlotListLayer:switchPageByClassType(arg_87_1)
	if var_0_24[arg_87_1] then
		self.radioButtonAchieve:setSelectedButton(Utility:indexOf(var_0_29, arg_87_1), true)
		self.radioButtonSwitch:setSelectedButton(Utility:indexOf(var_0_28, PLOT_CLASS.ACHIEVE), false)
		self.radioButtonSwitch:getInnerContainer():jumpToRight()
	else
		self.radioButtonSwitch:setSelectedButton(Utility:indexOf(var_0_28, arg_87_1), true)
	end
end

function TopPlotListLayer:queryAlertNodeByClassType(arg_88_1)
	if var_0_24[arg_88_1] then
		return self.radioButtonAchieve:getButton((Utility:indexOf(var_0_29, arg_88_1)))
	else
		return self.radioButtonSwitch:getButton((Utility:indexOf(var_0_28, arg_88_1)))
	end
end

function TopPlotListLayer:updateDailyActiveList()
	self.progressDaily:setPercent(Utility:clamp(math.floor(self.totalActiveNum), 0, 100))
	self:setPanelMaskVisible(self.totalActiveNum >= 100 and self.curClassType == PLOT_CLASS.DAILY, false, true)
	self.panelMask:setPositionY(80)
end

function TopPlotListLayer:setPanelMaskVisible(arg_90_1, arg_90_2, arg_90_3)
	self.panelMask:getChildByName("label"):setVisible(not not arg_90_2)
	self.panelMask:getChildByName("img"):setVisible(not not arg_90_3)
	self.panelMask:setVisible(false)
end

function TopPlotListLayer:handleGetDailyTaskInfo(arg_91_1)
	if not arg_91_1 then
		return
	end

	if arg_91_1.result == 1 then
		self.totalActiveNum = arg_91_1.totalActiveNum

		print("current active num: ", self.totalActiveNum)
	end

	self:updateDailyActiveList()
	self:updateTaskAlert()
end

function TopPlotListLayer.handleGetDailyTaskAvtiveNum(arg_92_0, arg_92_1)
	if not arg_92_1 then
		return
	end

	if arg_92_1.result == 1 then
		print("get active num: ", arg_92_1.activeNum)
		global_gain({
			active = arg_92_1.activeNum,
			surecallback = function()
				EventManager:requestGetDailyTaskReward()
			end,
			cancelcallback = function()
				EventManager:requestGetDailyTaskReward()
			end
		})
	elseif arg_92_1.result == 2 then
		print("任务未完成")
	end
end

function TopPlotListLayer:handleGetDailyTaskReward(arg_95_1)
	if not arg_95_1 then
		return
	end

	if arg_95_1.result == 1 then
		global_gain(arg_95_1)
		self:updateDiamondNum()
	else
		print("没有奖励可以领取")
	end

	EventManager:requestGetDailyTaskInfo()
end

function TopPlotListLayer:handleGetAwards(arg_96_1, arg_96_2)
	global_gain(arg_96_1)

	if arg_96_1.items then
		while arg_96_1.items[1] do
			if item_data[arg_96_1.items[1].itemid].bag_item_type == 64 then
				require("view.Layer.GetRoleAnimationLayer")
				cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(arg_96_1.items[1].itemid), 1000)
			end
		end
	end

	if not var_0_18 then
		return
	end

	self:updateBottomUI()

	if self.curClassType == PLOT_CLASS.DAILY_WEEKLY then
		self:updateOnePanleTask(arg_96_2:getParent(), self:dequeueTaskInfo(self.curClassType, arg_96_1.changeIndex), {
			dailyWeeklyAnima = true
		})
	else
		self:updateTableViewTask()
	end

	if self.curClassType == PLOT_CLASS.DAILY then
		self.totalActiveNum = self.totalActiveNum + arg_96_1.activeNum

		self:updateDailyActiveList()
	end

	self:updateTaskAlert()
	self:updateDiamondNum()
	self:updateTopUI()
end
