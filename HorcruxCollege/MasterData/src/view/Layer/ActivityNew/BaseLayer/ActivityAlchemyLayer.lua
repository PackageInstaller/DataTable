ActivityAlchemyLayer = class("ActivityAlchemyLayer", function()
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
local var_0_8 = 4
local alchemy_gamelogic_manager = require("controller.alchemy_gamelogic_manager")

function ActivityAlchemyLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityAlchemyLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityAlchemyLayer:init(arg_3_1)
	self.activityId = arg_3_1.activityId
	self.layerName = "Activity_Alchemy_" .. self.activityId
	self.respath = "Activity_Alchemy_" .. self.activityId .. "/"

	TextureManager:loadLayerTextures({
		self.layerName
	})

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))

	self:addChild(self.rootLayer)
	self:initUI()
	self:fullScreen()
	self:initTouchEvent()
	alchemy_gamelogic_manager:registerUIRef(self)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			alchemy_gamelogic_manager:exitGame()
			activity_manager:releaseEventListenerByName(self.layerName)
			TextureManager:removeLayerTextures({
				self.layerName
			})
		end
	end)

	if arg_3_1.entercallback then
		arg_3_1.entercallback()
	end
end

function ActivityAlchemyLayer:registerActivityEventListener()
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.Activity_Alchemy_RESULT, function(arg_6_0)
		return
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_7_0)
		return
	end)
end

function ActivityAlchemyLayer:initUI()
	self.title = self.rootLayer:getChildByName("title")
	self.choose_bg = self.rootLayer:getChildByName("choose_bg")
	self.bottom = self.rootLayer:getChildByName("bottom")
	self.alchemy_bg = self.rootLayer:getChildByName("alchemy_bg")
	self.time_bg = self.alchemy_bg:getChildByName("time_bg")
	self.time_label = self.time_bg:getChildByName("time_label")
	self.material_tip = self.alchemy_bg:getChildByName("material_tip")

	self.time_bg:setVisible(false)

	self.score_label = self.alchemy_bg:getChildByName("score_label")
	self.btn_start = self.alchemy_bg:getChildByName("btn_start")
	self.indextip_label = self.choose_bg:getChildByName("material_tipbg"):getChildByName("indextip_label")

	for iter_8_0 = 1, var_0_8 do
		self["btn_material" .. iter_8_0] = self.choose_bg:getChildByName("btn_material" .. iter_8_0)

		local var_8_0 = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create(self.respath .. "material_mask.png") or cc.Sprite:createWithSpriteFrameName(self.respath .. "material_mask.png")))

		var_8_0:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
		var_8_0:setReverseDirection(true)

		local var_8_1 = self["btn_material" .. iter_8_0]:getContentSize()

		var_8_0:setPosition(cc.p(var_8_1.width / 2, var_8_1.height / 2))
		self["btn_material" .. iter_8_0]:addChild(var_8_0)
		var_8_0:setPercentage(0)
		var_8_0:setName("cd_progress")

		local var_8_2 = sp.SkeletonAnimation:create("spine/bakery/skeleton.json", "spine/bakery/skeleton.atlas", 1)

		self["btn_material" .. iter_8_0]:addChild(var_8_2)
		var_8_2:setPosition(cc.p(var_8_1.width / 2, var_8_1.height / 2))
		var_8_2:setName("true_effect")
	end

	self.btn_return = self.bottom:getChildByName("btn_return")
	self.btn_shop = self.bottom:getChildByName("btn_shop")
	self.btn_task = self.bottom:getChildByName("btn_task")

	self.btn_shop:setVisible(false)
	self.score_label:setString("0")

	self.btn_material_posy = self.btn_material1:getPositionY()
end

function ActivityAlchemyLayer:updateUI(arg_9_1)
	if arg_9_1.time < arg_9_1.limit_time then
		self.time_bg:setVisible(true)
		self.time_label:setString(math.floor(arg_9_1.limit_time - arg_9_1.time))
	else
		self.time_bg:setVisible(false)
	end

	if arg_9_1.error_cd_time ~= 0 and arg_9_1.cd_time < arg_9_1.error_cd_time then
		for iter_9_0 = 1, var_0_8 do
			self["btn_material" .. iter_9_0]:getChildByName("cd_progress"):setPercentage(100 * (arg_9_1.error_cd_time - arg_9_1.cd_time) / arg_9_1.error_cd_time)
		end
	else
		for iter_9_1 = 1, var_0_8 do
			self["btn_material" .. iter_9_1]:getChildByName("cd_progress"):setPercentage(0)
		end
	end

	if arg_9_1.score then
		self.score_label:setString(arg_9_1.score)
	end
end

function ActivityAlchemyLayer:newTurn(arg_10_1)
	if arg_10_1.turns == 1 then
		global_ShowBlockWords("游戏开始!")
	else
		global_ShowBlockWords(string.format("第%d波", arg_10_1.turns))
	end

	if arg_10_1.combo and arg_10_1.combo >= 2 then
		local var_10_0 = ccui.ImageView:create(self.respath .. "combo" .. math.min(10, arg_10_1.combo) .. ".png", var_0_0)

		var_10_0:setAnchorPoint(0, 0)
		self.rootLayer:addChild(var_10_0)
		var_10_0:setPosition(640, self.alchemy_bg:getPositionY() + 280)
		var_10_0:runAction(cc.Sequence:create(cc.MoveBy:create(0.25, cc.p(-var_10_0:getContentSize().width - 30, 0)), cc.MoveBy:create(0.1, cc.p(30, 0)), cc.DelayTime:create(0.6), cc.FadeOut:create(0.3), cc.CallFunc:create(function()
			var_10_0:removeFromParent(false)
		end)))
	end

	for iter_10_0 = 1, var_0_8 do
		self["btn_material" .. iter_10_0]:getChildByName("icon"):loadTexture(self.respath .. "material" .. arg_10_1.material[iter_10_0] .. ".png", var_0_0)
	end

	local var_10_1 = arg_10_1.material_order
	local var_10_3 = arg_10_1.tips_time
	local var_10_4 = 1

	self.material_tip:stopAllActions()

	local function var_10_6()
		self.isShowTips = true

		if not var_10_1[var_10_4] then
			self.isShowTips = false

			return
		end

		self.material_tip:stopAllActions()
		self.material_tip:setOpacity(0)
		self.material_tip:loadTexture(self.respath .. "material" .. arg_10_1.material[var_10_1[var_10_4]] .. ".png", var_0_0)
		self.material_tip:runAction(cc.Sequence:create(cc.DelayTime:create(var_10_4 == 1 and 0.8 or 0.01), cc.FadeIn:create(var_10_3 * 0.25), cc.DelayTime:create(var_10_3 * 0.5), cc.FadeOut:create(var_10_3 * 0.25), cc.CallFunc:create(function()
			var_10_6()
		end)))

		var_10_4 = var_10_4 + 1
	end

	;(nil)()

	for iter_10_1 = 1, var_0_8 do
		self["btn_material" .. iter_10_1]:stopAllActions()
		self["btn_material" .. iter_10_1]:setPositionY(self.btn_material_posy)
		self["btn_material" .. iter_10_1]:runAction(cc.Sequence:create(cc.FadeOut:create(0.15), cc.FadeIn:create(0.5)))
	end

	self.indextip_label:setString("第1个材料")
end

function ActivityAlchemyLayer:gameEnd(arg_14_1)
	global_ShowBlockWords(string.format("游戏结束, 本局得分%s", arg_14_1.score))
	self.btn_start:setVisible(true)
	activity_manager:alchemy_gameend(self.activityId, arg_14_1.score)
end

function ActivityAlchemyLayer:addMaterResult(arg_15_1)
	local var_15_0 = arg_15_1.cur_index

	self["btn_material" .. arg_15_1.index]:stopAllActions()

	if arg_15_1.result then
		self["btn_material" .. arg_15_1.index]:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(0, 16)), cc.MoveBy:create(0.15, cc.p(0, -24)), cc.MoveBy:create(0.05, cc.p(0, 8))))
		self["btn_material" .. arg_15_1.index]:getChildByName("true_effect"):setAnimation(0, "dianji", false)
	else
		self["btn_material" .. arg_15_1.index]:runAction(cc.Sequence:create(cc.RotateBy:create(0.05, 10), cc.RotateBy:create(0.05, -10), cc.RotateBy:create(0.05, -10), cc.RotateBy:create(0.05, 10), cc.RotateBy:create(0.05, 10), cc.RotateBy:create(0.05, -10), cc.RotateBy:create(0.05, -10), cc.RotateBy:create(0.05, 10)))
	end

	self.indextip_label:setString(string.format("第%d个材料", var_15_0))
end

function ActivityAlchemyLayer:registerGameEvent()
	alchemy_gamelogic_manager:registerGameEvent("UPDATE_UI", self, self.updateUI)
	alchemy_gamelogic_manager:registerGameEvent("NEW_TURNS", self, self.newTurn)
	alchemy_gamelogic_manager:registerGameEvent("GAME_END", self, self.gameEnd)
	alchemy_gamelogic_manager:registerGameEvent("ADD_MATERIAL_RESULT", self, self.addMaterResult)
end

function ActivityAlchemyLayer:initTouchEvent()
	self.btn_return:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.btn_task:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityGameTaskLayer", {
			uiconfmodule = "alchemy",
			activityId = self.activityId
		})
	end)
	self.btn_start:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		alchemy_gamelogic_manager:gameStart()
		self.btn_start:setVisible(false)
		self.time_bg:setVisible(true)
	end)
	self.title:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityAlchemy_" .. self.activityId
		})
	end)

	for iter_17_0 = 1, var_0_8 do
		self["btn_material" .. iter_17_0]:setTouchEnabled(true)
		self["btn_material" .. iter_17_0]:addTouchEventListener(function(arg_22_0, arg_22_1)
			if arg_22_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.isShowTips then
				global_ShowBlockWords("观看完提示才能投放材料哦")

				return
			end

			alchemy_gamelogic_manager:addMaterial(iter_17_0)
		end)
	end
end

function ActivityAlchemyLayer:updateItemNum()
	local var_23_0 = activity_manager:get_bestcombo_conf(self.activityId)

	self.chance_label:setString((item_manager:getItemNumber(var_23_0.key_item)))
	self.keypoint_label:setString((item_manager:getItemNumber(var_23_0.key_point)))
end

function ActivityAlchemyLayer:fullScreen()
	self.title:setPositionY(self.title:getPositionY() - 70 + 0.7 * GameDisplay.fix_y)
	self.choose_bg:setPositionY(self.choose_bg:getPositionY() + 20 - 0.5 * GameDisplay.fix_y)
	self.bottom:setPositionY(self.bottom:getPositionY() + 110 - GameDisplay.fix_y)
end
