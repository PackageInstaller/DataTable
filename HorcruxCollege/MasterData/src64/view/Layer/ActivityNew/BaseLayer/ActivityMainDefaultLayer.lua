require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

local ActivityMainDefaultLayer = class("ActivityMainDefaultLayer", function(...)
	return ActivityMainLayerBaseLayer:create(...)
end)
local activity_conf_data = require("data.activity_conf_data")
local activity_task_conf = require("data.activity_modules.activity_task_conf")
local activity_main_conf = require("data.activity_modules.activity_main_conf")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local audio_manager = require("controller.audio_manager")
local explore_manager = require("controller.explore_manager")
local activity_manager = require("controller.activity_manager")
local share_manager = require("controller.share_manager")
local time_check_manager = require("controller.time_check_manager")
local ShowGirlLayer = require("view.Layer.ShowGirlLayer")
local var_0_12 = require("data.activity_skin_access_data").twistLsit
local var_0_13 = {
	[2] = {
		cc.p(320, 420),
		cc.p(320, 190)
	},
	[3] = {
		cc.p(320, 520),
		cc.p(320, 340),
		cc.p(320, 160)
	},
	[4] = {
		cc.p(320, 630),
		cc.p(320, 480),
		cc.p(320, 330),
		cc.p(320, 180)
	}
}
local var_0_14 = {
	[813] = {
		cc.p(280, 600),
		cc.p(280, 400),
		cc.p(280, 200)
	},
	[837] = {
		cc.p(290, 700),
		cc.p(290, 550),
		cc.p(290, 400),
		cc.p(290, 250)
	},
	[838] = {
		cc.p(320, 730),
		cc.p(320, 530),
		cc.p(320, 330)
	},
	[839] = {
		cc.p(320, 340),
		cc.p(320, 170)
	},
	[855] = {
		cc.p(320, 670),
		cc.p(320, 440)
	},
	[865] = {
		cc.p(320, 570),
		cc.p(320, 400)
	},
	[888] = {
		cc.p(320, 570),
		cc.p(320, 400)
	},
	[892] = {
		cc.p(320, 630),
		cc.p(320, 480),
		cc.p(320, 330)
	}
}

function ActivityMainDefaultLayer:create(arg_2_1)
	local var_2_0 = ActivityMainDefaultLayer.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()
	var_2_0:initOther(arg_2_1)

	return var_2_0
end

function ActivityMainDefaultLayer:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainDefaultLayer:initOther(arg_4_1)
	local var_4_0 = arg_4_1.activityid

	self.activityid = arg_4_1.activityid

	if activity_main_conf[arg_4_1.activityid].bgm then
		SwitchManageLayer:switchLayerBGM(activity_main_conf[arg_4_1.activityid].bgm)
	end

	if self.btnExplore then
		self.btnExplore:addTouchEventListener(function(arg_5_0, arg_5_1)
			if arg_5_1 ~= ccui.TouchEventType.ended then
				return
			end

			ErrorCodeManager:check({
				systemname = "ActivityExploreLayer",
				id = var_4_0
			})

			if activity_manager:isHasExploreMapLayer(var_4_0) then
				LayerManager:switchShowLayer("ActivityExploreLayer_" .. var_4_0, {
					activityid = var_4_0
				})
			else
				activity_manager:get_activity_explore(var_4_0, function(arg_6_0)
					if arg_6_0.result == 1 then
						explore_manager:begin_explore({
							returnLayer = "ActivityMainDefaultLayer",
							type = "activity",
							activityid = var_4_0,
							cancelCallback = function(arg_7_0)
								if arg_7_0 == 2 then
									global_ShowBlockWords(L_EXPLORE_ERROR_NEW[2])
								elseif arg_7_0 == 3 then
									global_ShowBlockWords(L_EXPLORE_ERROR_NEW[3])
								elseif arg_7_0 == 4 then
									global_ShowBlockWords(L_EXPLORE_ERROR_NEW[4])
								elseif arg_7_0 == 5 then
									global_ShowBlockWords(L_EXPLORE_ERROR_NEW[5])
								elseif arg_7_0 == 0 then
									global_ShowBlockWords(L_EXPLORE_ERROR_NEW[6])
								elseif arg_7_0 then
									global_ShowBlockWords(L_EXPLORE_ERROR_NEW[arg_7_0])
								end
							end,
							activity_explore_id = activity_manager:getCurExploreId(var_4_0)
						})
					end
				end)
			end
		end)
	end

	if activity_main_conf[arg_4_1.activityid].talk then
		if not RoleDefault:getInstance():getBoolForKey("act_" .. arg_4_1.activityid .. "_story", false) then
			RoleDefault:getInstance():setBoolForKey("act_" .. arg_4_1.activityid .. "_story", true)
			global_basic_scene:addChild(TalkLayer:create(activity_main_conf[arg_4_1.activityid].talk, nil, 1, "", nil))
		end
	end

	if self.btnTwistChoose1 then
		self.btnTwistChoose1:addTouchEventListener(function(arg_8_0, arg_8_1)
			if arg_8_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.selectType = 1

			self:createTwistChosee()
		end)
	end

	if self.btnTwistChoose2 then
		self.btnTwistChoose2:addTouchEventListener(function(arg_9_0, arg_9_1)
			if arg_9_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.selectType = 2

			self:createTwistChosee()
		end)
	end

	if self.btnTwistChoose3 then
		self.btnTwistChoose3:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.selectType = 3

			self:createTwistChosee()
		end)
	end

	if self.btnTwistChoose4 then
		self.btnTwistChoose4:addTouchEventListener(function(arg_11_0, arg_11_1)
			if arg_11_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.selectType = 4

			self:createTwistChosee()
		end)
	end
end

function ActivityMainDefaultLayer:createTwistChosee()
	self.twistChoseeLayer = ccui.Layout:create()

	self.twistChoseeLayer:setTouchEnabled(true)
	self.twistChoseeLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.twistChoseeLayer:setAnchorPoint(cc.p(0, 0))
	self.twistChoseeLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.twistChoseeLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.twistChoseeLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.twistChoseeLayer:setBackGroundColorOpacity(180)
	self:addChild(self.twistChoseeLayer)
	self.twistChoseeLayer:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.twistChoseeLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.RemoveSelf:create()))
	end)
	self.twistChoseeLayer:setVisible(false)

	self.bg = ccui.ImageView:create("activitiesRes/activity" .. self.activityid .. "/main/twistChoseeBg_1.png")

	self.bg:setTouchEnabled(true)
	self.bg:setPosition(cc.p(320, 520 + GameDisplay.fix_y))
	self.twistChoseeLayer:addChild(self.bg)

	local var_12_0 = var_0_12[self.activityid][self.selectType] or {}

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_1 = string.format("activitiesRes/activity%d/main/twistChoseebtn%d_%d.png", self.activityid, self.selectType, iter_12_0)

		if self.activityid == 838 and self.selectType == 1 and iter_12_0 == 2 and time_check_manager:getCurTime() > global_get_time_by_date("2025-10-03 00:00:00") then
			var_12_1 = string.format("activitiesRes/activity%d/main/twistChoseebtn%d_%d_replace.png", self.activityid, self.selectType, iter_12_0)
		end

		if self.activityid == 865 and self.selectType == 1 and iter_12_0 == 2 and time_check_manager:getCurTime() > global_get_time_by_date("2026-02-16 00:00:00") then
			var_12_1 = string.format("activitiesRes/activity%d/main/twistChoseebtn%d_%d_replace.png", self.activityid, self.selectType, iter_12_0)
		end

		self["btn" .. iter_12_0] = ccui.Button:create(var_12_1, nil, var_12_1)

		if var_0_14[self.activityid] then
			self["btn" .. iter_12_0]:setPosition(var_0_14[self.activityid][iter_12_0])
		else
			self["btn" .. iter_12_0]:setPosition(var_0_13[#var_12_0][iter_12_0])
		end

		self.bg:addChild(self["btn" .. iter_12_0])
		self["btn" .. iter_12_0]:addTouchEventListener(function(arg_14_0, arg_14_1)
			local var_14_0

			if arg_14_1 ~= ccui.TouchEventType.ended then
				do return end

				var_14_0 = {}
			end

			var_14_0.jump_to_system = var_0_12[self.activityid][self.selectType][iter_12_0]

			goto_complete_system(var_14_0)
		end)
	end

	self.twistChoseeLayer:setOpacity(0)
	self.twistChoseeLayer:setVisible(true)
	self.twistChoseeLayer:runAction(cc.Sequence:create(cc.FadeIn:create(0.5)))
end

function ActivityMainDefaultLayer:playOutEffect(arg_15_1)
	if arg_15_1 then
		arg_15_1()
	end
end

return ActivityMainDefaultLayer
