ActivityBestComboLayer = class("ActivityBestComboLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local Utility = require("common.Utility")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local time_check_manager = require("controller.time_check_manager")
local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local var_0_8 = 9
local var_0_9 = 4

function ActivityBestComboLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityBestComboLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityBestComboLayer:init(arg_3_1)
	self.activityId = arg_3_1.activityId
	self.layerName = "Activity_BestCombo_" .. self.activityId
	self.respath = "Activity_BestCombo_" .. self.activityId .. "/"

	TextureManager:loadLayerTextures({
		self.layerName
	})

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))

	self:addChild(self.rootLayer)
	self:initUI()
	self:fullScreen()
	self:registerActivityEventListener()
	self:initTouchEvent()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName(self.layerName)
			TextureManager:removeLayerTextures({
				self.layerName
			})
		end
	end)

	if arg_3_1.entercallback then
		arg_3_1.entercallback()
	end

	self:updateItemNum()
end

function ActivityBestComboLayer:registerActivityEventListener()
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_BESTCOMBO_RESULT, function(arg_6_0)
		for iter_6_0, iter_6_1 in ipairs(arg_6_0.combo_result) do
			self.combo_horcurx[iter_6_0] = iter_6_1.horcrux_index == 0 and math.random(10, 12) or iter_6_1.horcrux_index
		end

		self:updateItemNum()
		self:updateComboPanel(arg_6_0.combo_result)
		LayerManager:pushInLayer("PopActivityComboResultLayer", {
			activityId = self.activityId,
			msg = arg_6_0
		})
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_7_0)
		self:updateItemNum()
	end)
end

function ActivityBestComboLayer:initUI()
	self.title = self.rootLayer:getChildByName("title")
	self.chance_label = self.rootLayer:getChildByName("chance_bg"):getChildByName("itemNum")
	self.chance_add_btn = self.rootLayer:getChildByName("chance_bg"):getChildByName("btn_add")
	self.keypoint_label = self.rootLayer:getChildByName("keypoint_bg"):getChildByName("itemNum")
	self.keypoint_add_btn = self.rootLayer:getChildByName("keypoint_bg"):getChildByName("btn_add")
	self.btn_combo = self.rootLayer:getChildByName("btn_combo")
	self.btn_reset = self.rootLayer:getChildByName("btn_reset")
	self.btn_return = self.rootLayer:getChildByName("bottom"):getChildByName("btn_return")
	self.btn_shop = self.rootLayer:getChildByName("bottom"):getChildByName("Button_59")
	self.btn_task = self.rootLayer:getChildByName("bottom"):getChildByName("Button_60")
	self.combo_bg = self.rootLayer:getChildByName("combo_bg")
	self.choose_bg = self.rootLayer:getChildByName("choose_bg")
	self.combo_horcurx = {}

	self:initSelectPanel()
	self:initComboPanel()
end

function ActivityBestComboLayer:initSelectPanel()
	for iter_9_0 = 1, var_0_8 do
		local var_9_0 = ccui.Button:create(self.respath .. "select" .. iter_9_0 .. ".png", nil, self.respath .. "select" .. iter_9_0 .. ".png", var_0_0)

		var_9_0:setPosition(50 + (iter_9_0 - 1) * 65, 65)
		self.choose_bg:addChild(var_9_0)
		var_9_0:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_10_0

			for iter_10_0 = 1, var_0_9 do
				if not self.combo_horcurx[iter_10_0] then
					var_10_0 = var_10_0 or iter_10_0
				elseif self.combo_horcurx[iter_10_0] == iter_9_0 then
					global_ShowBlockWords("重复选择,点击上方区域即可取消选择")

					return
				end
			end

			if not var_10_0 then
				global_ShowBlockWords("已经选满啦")

				return
			end

			self.combo_horcurx[var_10_0] = iter_9_0

			self:updateComboPanel()
		end)
	end
end

function ActivityBestComboLayer:initComboPanel()
	local var_11_0 = {
		cc.p(195, 483),
		cc.p(450, 483),
		cc.p(195, 240),
		cc.p(450, 240)
	}

	for iter_11_0 = 1, var_0_9 do
		local var_11_1 = ccui.Button:create(self.respath .. iter_11_0 .. "-on.png", nil, self.respath .. iter_11_0 .. "-on.png", var_0_0)

		var_11_1:setPosition(var_11_0[iter_11_0])
		self.combo_bg:addChild(var_11_1)
		var_11_1:addTouchEventListener(function(arg_12_0, arg_12_1)
			if arg_12_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.combo_horcurx[iter_11_0] then
				self.combo_horcurx[iter_11_0] = nil

				self:updateComboPanel()
			end
		end)
		var_11_1:setVisible(false)

		self["comboBtn" .. iter_11_0] = var_11_1

		local var_11_2 = ccui.ImageView:create(self.respath .. "horrcurx_effect.png", var_0_0)

		var_11_2:setAnchorPoint(0, 0)
		var_11_2:setPosition(-12, -12)
		var_11_2:setName("effect")
		var_11_1:addChild(var_11_2)
		var_11_2:setVisible(false)
	end
end

function ActivityBestComboLayer:updateComboPanel(arg_13_1)
	for iter_13_0 = 1, var_0_9 do
		if self.combo_horcurx[iter_13_0] then
			self["comboBtn" .. iter_13_0]:setVisible(true)
			self["comboBtn" .. iter_13_0]:loadTextures(self.respath .. self.combo_horcurx[iter_13_0] .. "-on.png", nil, self.respath .. self.combo_horcurx[iter_13_0] .. "-on.png", var_0_0)
		else
			self["comboBtn" .. iter_13_0]:setVisible(false)
		end

		self["comboBtn" .. iter_13_0]:getChildByName("effect"):setVisible(false)
	end

	if arg_13_1 then
		for iter_13_1, iter_13_2 in ipairs(arg_13_1) do
			if iter_13_2.horcrux_index == 0 then
				self["comboBtn" .. iter_13_1]:getChildByName("effect"):setVisible(true)
				self["comboBtn" .. iter_13_1]:getChildByName("effect"):loadTexture(self.respath .. "best_effect.png", var_0_0)
			elseif iter_13_2.pos_boolean then
				self["comboBtn" .. iter_13_1]:getChildByName("effect"):setVisible(true)
				self["comboBtn" .. iter_13_1]:getChildByName("effect"):loadTexture(self.respath .. "pos_effect.png", var_0_0)
			elseif iter_13_2.horcrux_boolean then
				self["comboBtn" .. iter_13_1]:getChildByName("effect"):setVisible(true)
				self["comboBtn" .. iter_13_1]:getChildByName("effect"):loadTexture(self.respath .. "horrcurx_effect.png", var_0_0)
			end
		end
	end
end

function ActivityBestComboLayer:initTouchEvent()
	self.btn_combo:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_15_0:isBright() then
			return
		end

		arg_15_0:setBright(false)

		if #self.combo_horcurx ~= 4 then
			global_ShowBlockWords("请选择四个魂器进行组合")
			arg_15_0:setBright(true)

			return
		end

		for iter_15_0 = 1, var_0_9 do
			if not self.combo_horcurx[iter_15_0] then
				global_ShowBlockWords("请选择四个魂器进行组合")
				arg_15_0:setBright(true)

				return
			end
		end

		activity_manager:set_bestcombo_combo(self.activityId, self.combo_horcurx, function()
			arg_15_0:setBright(true)
		end)
	end)
	self.btn_reset:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.combo_horcurx = {}

		self:updateComboPanel()
	end)
	self.btn_return:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.btn_shop:addTouchEventListener(function(arg_19_0, arg_19_1)
		local var_19_0

		if arg_19_1 ~= ccui.TouchEventType.ended then
			do return end

			var_19_0 = {}
		end

		var_19_0[1] = "1-" .. tonumber(activity_manager:get_bestcombo_conf(self.activityId).shop_id) % 1500000

		LayerManager:switchShowLayer("MarketLayer", {
			singleMarket = var_19_0,
			showType = var_19_0[1]
		})
	end)
	self.btn_task:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityGameTaskLayer", {
			uiconfmodule = "bestCombo",
			activityId = self.activityId
		})
	end)
	self.title:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityBestCombo_" .. self.activityId
		})
	end)

	local var_14_0 = activity_manager:get_bestcombo_conf(self.activityId)
	local var_14_1 = var_14_0.key_item
	local var_14_2 = var_14_0.key_point

	self.chance_add_btn:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopItemLayer", {
			itemid = var_14_1
		})
	end)
	self.keypoint_add_btn:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopItemLayer", {
			itemid = var_14_2
		})
	end)
end

function ActivityBestComboLayer:updateItemNum()
	local var_24_0 = activity_manager:get_bestcombo_conf(self.activityId)

	self.chance_label:setString((item_manager:getItemNumber(var_24_0.key_item)))
	self.keypoint_label:setString((item_manager:getItemNumber(var_24_0.key_point)))
end

function ActivityBestComboLayer:fullScreen()
	self.title:setPositionY(self.title:getPositionY() + 0.7 * GameDisplay.fix_y)
	self.rootLayer:getChildByName("keypoint_bg"):setPositionY(self.rootLayer:getChildByName("keypoint_bg"):getPositionY() + 0.4 * GameDisplay.fix_y)
	self.rootLayer:getChildByName("chance_bg"):setPositionY(self.rootLayer:getChildByName("chance_bg"):getPositionY() + 0.4 * GameDisplay.fix_y)
	self.btn_combo:setPositionY(self.btn_combo:getPositionY() - 0.4 * GameDisplay.fix_y)
	self.btn_reset:setPositionY(self.btn_reset:getPositionY() - 0.4 * GameDisplay.fix_y)
	self.choose_bg:setPositionY(self.choose_bg:getPositionY() - 0.7 * GameDisplay.fix_y)
	self.rootLayer:getChildByName("bottom"):setPositionY(self.rootLayer:getChildByName("bottom"):getPositionY() - GameDisplay.fix_y)
end
