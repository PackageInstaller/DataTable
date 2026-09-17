local ActivityMainLayer_210 = class("ActivityMainLayer_210", function(...)
	return ActivityMainLayerBaseLayer:create(...)
end)
local activity_conf_data = require("data.activity_conf_data")
local activity_task_conf = require("data.activity_modules.activity_task_conf")
local activity_main_conf = require("data.activity_modules.activity_main_conf")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local explore_manager = require("controller.explore_manager")
local activity_manager = require("controller.activity_manager")
local share_manager = require("controller.share_manager")
local time_check_manager = require("controller.time_check_manager")
local ShowGirlLayer = require("view.Layer.ShowGirlLayer")

function ActivityMainLayer_210:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_210.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()
	var_2_0:initOther(arg_2_1)

	return var_2_0
end

function ActivityMainLayer_210:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainLayer_210:initOther(arg_4_1)
	local var_4_0 = arg_4_1.activityid

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
							returnLayer = "ActivityMainLayer_210",
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

	if not RoleDefault:getInstance():getBoolForKey("act_210_story", false) then
		RoleDefault:getInstance():setBoolForKey("act_210_story", true)
		global_basic_scene:addChild(TalkLayer:create(2021100, nil, 1, "", nil))
	end
end

function ActivityMainLayer_210:playInEffect(arg_8_1)
	self.imgBg:setOpacity(0)
	self.imgBg:runAction(cc.FadeIn:create(0.3))
	self.btnDetail:setOpacity(0)
	self.btnDetail:runAction(cc.Sequence:create(cc.FadeIn:create(0.6), cc.CallFunc:create(function()
		self.btnDetail:setOpacity(0)

		local var_9_0 = L2Skeleton:create(self._path .. "title.json", self._path .. "title.atlas")

		var_9_0:refreshSkeleton()
		var_9_0.skeletonAnimation:setPositionX(self.btnDetail:getContentSize().width / 2 - 3)
		var_9_0.skeletonAnimation:setPositionY(self.btnDetail:getContentSize().height / 2 - 39)
		var_9_0:setName("titleSpine")
		var_9_0:play("animation", false)
		self.btnDetail:addChild(var_9_0)
		self:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(3), cc.CallFunc:create(function()
			var_9_0:play("animation", false)
		end))))
	end)))
	self.btnTwist:setOpacity(0)
	self.btnTwist:runAction(cc.Sequence:create(cc.DelayTime:create(0.6), cc.CallFunc:create(function()
		self.btnTwist:setOpacity(0)

		local var_11_0 = L2Skeleton:create(self._path .. "niudan.json", self._path .. "niudan.atlas")

		var_11_0:refreshSkeleton()
		var_11_0.skeletonAnimation:setPositionX(self.btnTwist:getContentSize().width / 2)
		var_11_0.skeletonAnimation:setPositionY(self.btnTwist:getContentSize().height / 2)
		var_11_0:setName("twistSpine")
		var_11_0:play("animation", false)
		self.btnTwist:addChild(var_11_0)
	end)))

	local var_8_0 = L2Skeleton:create(self._path .. "1.json", self._path .. "1.atlas")

	var_8_0:refreshSkeleton()
	var_8_0.skeletonAnimation:setPositionX(self.imgBg:getContentSize().width / 2)
	var_8_0.skeletonAnimation:setPositionY(self.imgBg:getContentSize().height / 2)
	var_8_0:setName("huabanXSpine")
	var_8_0:play("idle", true)
	self.imgBg:addChild(var_8_0, 999)

	for iter_8_0, iter_8_1 in ipairs({
		self.btnShop,
		self.btnBp,
		self.btnCollect,
		self.btnFlop,
		self.btnSign,
		self.btnExplore,
		self.btnRoulette,
		self.btnLevel,
		self.btnRecharge,
		self.btnArt,
		self.btnInfinite,
		self.btnShare
	}) do
		local var_8_1, var_8_2 = iter_8_1:getPosition()

		iter_8_1:setOpacity(0)
		iter_8_1:runAction(cc.Sequence:create(cc.FadeIn:create(0.6), cc.DelayTime:create(0.9), cc.CallFunc:create(function()
			iter_8_1:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveTo:create(1, cc.p(var_8_1, var_8_2 + 1.5)), cc.MoveTo:create(1, cc.p(var_8_1, var_8_2 - 1.5)))))
		end)))
	end
end

return ActivityMainLayer_210
