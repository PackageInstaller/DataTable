ActivityExploreLayer_186 = class("ActivityExploreLayer_186", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local explore_manager = require("controller.explore_manager")
local time_check_manager = require("controller.time_check_manager")

function ActivityExploreLayer_186.create(arg_2_0)
	local var_2_0 = ActivityExploreLayer_186.new()

	var_2_0:init({
		id = 173
	})

	return var_2_0
end

function ActivityExploreLayer_186:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityExploreLayer_186.json" or "ActivityExploreLayer_186.ExportJson")

	self:addChild(self.rootLayer)
	self:initUI()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("ActivityExploreLayer_186")
		end
	end)
end

function ActivityExploreLayer_186:initUI()
	self:fullscreen()
	self:initBtn()
end

function ActivityExploreLayer_186:fullscreen()
	self.title = self.rootLayer:getChildByName("title")
	self.btn_1 = self.rootLayer:getChildByName("btn_1")
	self.btn_2 = self.rootLayer:getChildByName("btn_2")
	self.role_1 = self.rootLayer:getChildByName("role_1")
	self.role_2 = self.rootLayer:getChildByName("role_2")
	self.btnReturn = self.rootLayer:getChildByName("Button_35")

	self.title:setPositionY(self.title:getPositionY() + GameDisplay.fix_y)
	self.role_1:setPositionY(self.role_1:getPositionY() + GameDisplay.fix_y)
	self.role_2:setPositionY(self.role_2:getPositionY() - GameDisplay.fix_y)
	self.btnReturn:setPositionY(self.btnReturn:getPositionY() - GameDisplay.fix_y)
end

function ActivityExploreLayer_186:initBtn()
	self.btnReturn:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	local var_7_0 = 186

	self.btn_1:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:get_activity_explore(var_7_0, function(arg_10_0)
			if arg_10_0.result == 1 then
				local var_10_0 = {
					returnLayer = "ActivityExploreLayer_186",
					type = "activity",
					activityid = var_7_0,
					cancelCallback = function(arg_11_0)
						if arg_11_0 == 2 then
							global_ShowBlockWords(L_EXPLORE_ERROR_NEW[2])
						elseif arg_11_0 == 3 then
							global_ShowBlockWords(L_EXPLORE_ERROR_NEW[3])
						elseif arg_11_0 == 4 then
							global_ShowBlockWords(L_EXPLORE_ERROR_NEW[4])
						elseif arg_11_0 == 5 then
							global_ShowBlockWords(L_EXPLORE_ERROR_NEW[5])
						elseif arg_11_0 == 0 then
							global_ShowBlockWords(L_EXPLORE_ERROR_NEW[6])
						elseif arg_11_0 then
							global_ShowBlockWords(L_EXPLORE_ERROR_NEW[arg_11_0])
						end
					end
				}

				var_10_0.activity_explore_id = 1

				if arg_10_0.explore_info[1].finish_times > 0 then
					if arg_10_0.explore_info[3].daily_times > 0 then
						global_ShowBlockWords(L_EXPLORE_ERROR_NEW[8])

						return
					else
						var_10_0.activity_explore_id = 3
					end
				end

				explore_manager:begin_explore(var_10_0)
			end
		end)
	end)

	local var_7_1 = activity_manager:getActivityExploreConfData(186)
	local var_7_2 = time_check_manager:getCurTime()

	if var_7_2 > global_get_time_by_date(var_7_1[2].starttime) and var_7_2 < global_get_time_by_date(var_7_1[2].finishtime) then
		self.btn_2:loadTextures("ActivityExploreLayer_186/btn_2.png", nil, "ActivityExploreLayer_186/btn_2.png", var_0_0)
		self.role_2:loadTexture("ActivityExploreLayer_186/role_2.png", var_0_0)
		self.btn_2:addTouchEventListener(function(arg_12_0, arg_12_1)
			if arg_12_1 ~= ccui.TouchEventType.ended then
				return
			end

			activity_manager:get_activity_explore(186, function(arg_13_0)
				if arg_13_0.result == 1 then
					local var_13_0 = {
						returnLayer = "ActivityExploreLayer_186",
						type = "activity",
						activityid = var_7_0,
						cancelCallback = function(arg_14_0)
							if arg_14_0 == 2 then
								global_ShowBlockWords(L_EXPLORE_ERROR_NEW[2])
							elseif arg_14_0 == 3 then
								global_ShowBlockWords(L_EXPLORE_ERROR_NEW[3])
							elseif arg_14_0 == 4 then
								global_ShowBlockWords(L_EXPLORE_ERROR_NEW[4])
							elseif arg_14_0 == 5 then
								global_ShowBlockWords(L_EXPLORE_ERROR_NEW[5])
							elseif arg_14_0 == 0 then
								global_ShowBlockWords(L_EXPLORE_ERROR_NEW[6])
							elseif arg_14_0 then
								global_ShowBlockWords(L_EXPLORE_ERROR_NEW[arg_14_0])
							end
						end
					}

					var_13_0.activity_explore_id = 2

					if arg_13_0.explore_info[2].finish_times > 0 then
						if arg_13_0.explore_info[4].daily_times > 0 then
							global_ShowBlockWords(L_EXPLORE_ERROR_NEW[8])

							return
						else
							var_13_0.activity_explore_id = 4
						end
					end

					explore_manager:begin_explore(var_13_0)
				end
			end)
		end)
	else
		self.btn_2:loadTextures("ActivityExploreLayer_186/btn_2_lock.png", nil, "ActivityExploreLayer_186/btn_2_lock.png", var_0_0)
		self.role_2:loadTexture("ActivityExploreLayer_186/role_2_lock.png", var_0_0)
	end
end
