local ActivityMainLayer_173 = class("ActivityMainLayer_173", function(...)
	return ActivityMainLayerBaseLayer:create(...)
end)
local servant_data = require("data.servant_data")
local activity_manager = require("controller.activity_manager")
local explore_manager = require("controller.explore_manager")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local activity_main_conf = require("data.activity_modules.activity_main_conf")
local activity_explore_conf = require("data.activity_modules.activity_explore_conf")

function ActivityMainLayer_173:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_173.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()
	var_2_0:initOther()

	return var_2_0
end

function ActivityMainLayer_173:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

local var_0_9 = {
	27720,
	27620,
	27820
}

function ActivityMainLayer_173:initOther()
	RoleDefault:getInstance():setBoolForKey("ActivityMainLayer_173_first", true)
	self.btnWar:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		RoleDefault:getInstance():setIntegerForKey("act_alert_war_173", os.date("*t", (time_check_manager:getCurTime())).day)
		LayerManager:switchShowLayer("ExploreOfferLayer")
	end)
	self.btnWar:setVisible(false)
	self.btnDetail:setTouchEnabled(false)
	self.img_1:setTouchEnabled(true)
	self.img_1:addTouchEventListener(function(arg_6_0, arg_6_1)
		local var_6_0

		if arg_6_1 ~= ccui.TouchEventType.ended then
			do return end

			var_6_0 = {
				id = 103,
				PhotoFileLayer = 1,
				contentType = {
					contentType = "file_player"
				},
				modelid = servant_data[var_0_9[1]].modelid
			}
		end

		var_6_0.servantid = var_0_9[1]

		LayerManager:pushInLayer("PhotoFileRoleFileLayer", var_6_0)
	end)
	self.img_2:setTouchEnabled(true)
	self.img_2:addTouchEventListener(function(arg_7_0, arg_7_1)
		local var_7_0

		if arg_7_1 ~= ccui.TouchEventType.ended then
			do return end

			var_7_0 = {
				id = 102,
				PhotoFileLayer = 1,
				contentType = {
					contentType = "file_player"
				},
				modelid = servant_data[var_0_9[2]].modelid
			}
		end

		var_7_0.servantid = var_0_9[2]

		LayerManager:pushInLayer("PhotoFileRoleFileLayer", var_7_0)
	end)
	self.img_3:setTouchEnabled(true)
	self.img_3:addTouchEventListener(function(arg_8_0, arg_8_1)
		local var_8_0

		if arg_8_1 ~= ccui.TouchEventType.ended then
			do return end

			var_8_0 = {
				id = 104,
				PhotoFileLayer = 1,
				contentType = {
					contentType = "file_player"
				},
				modelid = servant_data[var_0_9[3]].modelid
			}
		end

		var_8_0.servantid = var_0_9[3]

		LayerManager:pushInLayer("PhotoFileRoleFileLayer", var_8_0)
	end)
	self.btnExplore:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		explore_manager:begin_explore({
			classid = 3,
			type = "level",
			cur_step = 1,
			returnLayer = "ActivityMainLayer_" .. self.id,
			cancelCallback = function(arg_10_0)
				print("!!!!!!!!!!!!!!!")
				print(dump(arg_10_0))

				if arg_10_0 == 2 then
					global_ShowBlockWords(L_EXPLORE_ERROR_NEW[2])
				elseif arg_10_0 == 3 then
					global_ShowBlockWords(L_EXPLORE_ERROR_NEW[3])
				elseif arg_10_0 == 4 then
					global_ShowBlockWords(L_EXPLORE_ERROR_NEW[4])
				elseif arg_10_0 == 5 then
					global_ShowBlockWords(L_EXPLORE_ERROR_NEW[5])
				elseif arg_10_0 == 0 then
					global_ShowBlockWords(L_EXPLORE_ERROR_NEW[6])
				elseif arg_10_0 then
					global_ShowBlockWords(L_EXPLORE_ERROR_NEW[arg_10_0])
				end
			end
		})
	end)
end

return ActivityMainLayer_173
