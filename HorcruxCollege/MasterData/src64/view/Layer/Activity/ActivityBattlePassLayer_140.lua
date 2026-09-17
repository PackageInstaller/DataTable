local item_manager = require("controller.item_manager")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local playermodel = require("model.playermodel")
local share_manager = require("controller.share_manager")
local shop_manager = require("controller.shop_manager")
local horcrux_manager = require("controller.horcrux_manager")
local audio_manager = require("controller.audio_manager")
local component_manager = require("controller.component_manager")
local twist_manager = require("controller.twist_manager")
local weapon_manager = require("controller.weapon_manager")
local level_manager = require("controller.level_manager")
local autopop_manager = require("controller.autopop_manager")
local aiattack_manager = require("controller.aiattack_manager")
local l2utils = require("controller.l2utils")
local drop_data = require("data.drop_data")
local shop_data = require("data.shop_data")
local item_data = require("data.item_data")
local horcrux_data = require("data.horcrux_data")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local servant_data = require("data.servant_data")
local total_skill_data = require("data.total_skill_data")
local twist_config_data = require("data.twist_config_data")

ActivityBattlePassLayer_140 = class("ActivityBattlePassLayer_140", function()
	return ActivityBattlePassBaseLayer:create()
end)

function ActivityBattlePassLayer_140.create(arg_2_0)
	local var_2_0 = ActivityBattlePassLayer_140.new()

	var_2_0:init()

	return var_2_0
end

function ActivityBattlePassLayer_140.initDynamicConfig(arg_3_0)
	arg_3_0.layerName = "ActivityBattlePassLayer_140"
	arg_3_0.activityId = 140
	arg_3_0.height_add = 50
	arg_3_0.bottomconf = {
		img = "ActivityBattlePassLayer_140/return_btn.png"
	}
	arg_3_0.bottombgPath = "ActivityBattlePassLayer_140/bottom_bg.png"
end

function ActivityBattlePassLayer_140:setUIPosition()
	local var_4_0 = self.rootLayer:getChildByName("panel_up")
	local var_4_1 = var_4_0:getChildByName("title_detial")

	var_4_1:setAnchorPoint(cc.p(0, 1))
	var_4_1:setPosition(0, var_4_0:getContentSize().height)
	var_4_0:getChildByName("btn_detail"):setPosition(360, 220)
	var_4_0:getChildByName("lbl_time"):setPosition(162, 175)

	local var_4_2 = var_4_0:getChildByName("upup")

	var_4_2:setScale(0.9)
	var_4_2:setPosition(60, 133)

	self.progress_banner_pos = cc.p(185, 122)

	local var_4_3 = var_4_0:getChildByName("level_bg")

	var_4_3:setPosition(305, 135)

	local var_4_4 = var_4_3:getChildByName("cur_level")

	var_4_4:setPosition(var_4_3:getContentSize().width / 2 - 1, var_4_3:getContentSize().height / 2 + 7)
	var_4_4:setColor(cc.c3b(73, 66, 114))

	local var_4_5 = ccui.Helper:seekWidgetByName(var_4_0, "cur_exp")

	var_4_5:setFontSize(20)
	var_4_5:setColor(cc.c3b(255, 255, 255))
	var_4_5:setPosition(145, 135)

	self.BtnBuyPt_pos = cc.p(235, 137)

	var_4_0:getChildByName("button_jump_to"):setPosition(185, 80)

	local var_4_6 = var_4_0:getChildByName("switch_btn_level")

	var_4_6:setPositionY(var_4_6:getPositionY() + 46)

	local var_4_7 = var_4_0:getChildByName("switch_btn_task")

	var_4_7:setPositionY(var_4_7:getPositionY() + 46)

	self.curLevelLbl_color = cc.c3b(84, 58, 71)
	self.ptNum_color = cc.c3b(97, 63, 50)
	self.itemsp_wordbg = "ActivityBattlePassLayer_140/item_num_bg.png"

	local var_4_8 = ccui.Layout:create()

	var_4_8:setContentSize(cc.size(300, 400))
	var_4_8:setPosition(cc.p(400, 45))
	var_4_8:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_4_8:setTouchEnabled(true)
	var_4_0:addChild(var_4_8)
	var_4_8:setTouchEnabled(true)
	var_4_8:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopShowGirlPageLayer")
	end)

	local var_4_9 = ccui.ImageView:create("ActivityBattlePassLayer_140/tips.png", config._DEBUG and 0 or 1)

	var_4_9:setPosition(cc.p(490, 95))
	var_4_0:addChild(var_4_9)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_suo"):setPosition(385, 30)
	self.rootLayer:getChildByName("Panel_zi"):setPositionY(GameDisplay.getUiScreenSize().height - 360 - GameDisplay.fix_y)
end

function ActivityBattlePassLayer_140:createLevelSprite(arg_6_1)
	local var_6_0 = config._DEBUG and 0 or 1
	local var_6_1 = ccui.ImageView:create(self.layerName .. "/pt_bg.png", config._DEBUG and 0 or 1)

	var_6_1:setName("sprite_bg")
	var_6_1:setTag(100)

	if type(arg_6_1.level) == "string" then
		var_6_1:setVisible(false)
	else
		var_6_1:setVisible(true)
	end

	local var_6_2 = ccui.ImageView:create(self.layerName .. "/level_bg_b.png", var_6_0)

	var_6_2:setPosition(cc.p(60, self.LEVEL_CELL_HEIGHT / 2))
	var_6_2:setName("cur_level_bg_b")
	var_6_1:addChild(var_6_2, 100)

	if arg_6_1.stat ~= self.LEVEL_UNACHIEVE then
		if type(arg_6_1.level) == "number" and arg_6_1.level % 5 == 0 then
			var_6_2:loadTexture(self.layerName .. "/LV_b.png", var_6_0)
		else
			var_6_2:loadTexture(self.layerName .. "/LV_s.png", var_6_0)
		end
	elseif type(arg_6_1.level) == "number" and arg_6_1.level % 5 == 0 then
		var_6_2:loadTexture(self.layerName .. "/level_bg_b.png", var_6_0)
	else
		var_6_2:loadTexture(self.layerName .. "/level_bg_s.png", var_6_0)
	end

	local var_6_3 = cc.Label:createWithBMFont("fonts/qixi_number.fnt", 1)

	var_6_3:setString(tostring(arg_6_1.level))
	var_6_3:setName("cur_level_lbl")
	var_6_3:setPosition(cc.p(var_6_2:getContentSize().width / 2, var_6_2:getContentSize().height / 2 + 2 + (self.curLevelLbl_offset_Y or 0)))
	var_6_2:addChild(var_6_3)

	local var_6_4 = ccui.Slider:create()

	var_6_4:setAnchorPoint(cc.p(0, 0.5))
	var_6_4:setRotation(90)
	var_6_4:setName("progress_bar")
	var_6_4:loadBarTexture(self.layerName .. "/progress_acr_bg.png", var_6_0)
	var_6_4:loadProgressBarTexture(self.layerName .. "/progress_acr.png", var_6_0)
	var_6_4:setPosition(cc.p(var_6_2:getPositionX(), var_6_2:getPositionY() - var_6_2:getContentSize().height / 2 + 28))
	var_6_1:addChild(var_6_4, 50)

	if type(arg_6_1.level) == "string" or arg_6_1.level == 30 then
		var_6_4:setVisible(false)
	elseif arg_6_1.level + 1 < self.curLevel then
		var_6_4:setPercent(100)
	elseif arg_6_1.level + 1 == self.curLevel then
		var_6_4:setPercent((activity_manager:getCurLevelProceed(self.activityId, self.curLevel)))
	else
		var_6_4:setPercent(0)
	end

	if type(arg_6_1.level) ~= "string" and arg_6_1.drop then
		local var_6_5 = ccui.Layout:create()

		var_6_5:setPosition(cc.p(var_6_1:getContentSize().width / 2 - 10, self.LEVEL_CELL_HEIGHT / 2 + 10))
		var_6_5:setName("drop_node")
		var_6_1:addChild(var_6_5)

		for iter_6_0, iter_6_1 in pairs((activity_manager:getBattlePassDrop(self.activityId, arg_6_1.drop))) do
			local var_6_6 = ItemPurchaseSprite:createPurchaseItem(iter_6_1.dropid, iter_6_1.dropNum)

			var_6_6:setScale(0.6)
			var_6_6:setTouchEnabled(true)
			var_6_6:setSwallowTouches(false)
			var_6_6:switchToBpItem(arg_6_1.stat >= self.RECEIVE_ORDINARY, false, nil, self.itemsp_wordbg, self.layerName)
			var_6_6:addTouchEventListener(function(arg_7_0, arg_7_1)
				if arg_7_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_6_1.stat == self.LEVEL_UNACHIEVE then
					showItemDetails(iter_6_1.dropid)

					return
				end

				if arg_6_1.stat == self.RECEIVE_ALL then
					return
				end

				if arg_6_1.stat == self.RECEIVE_ORDINARY and not activity_manager:isBattlePassVIP(self.activityId) then
					return
				end

				activity_manager:getBattlePassReward(self.activityId, arg_6_1.level)
			end)
			var_6_6:setPosition(cc.p(-100 + (iter_6_0 - 1) * 150, -10))
			var_6_5:addChild(var_6_6)
		end
	end

	if type(arg_6_1.level) ~= "string" and arg_6_1.specialDrop then
		local var_6_8 = ccui.Layout:create()

		var_6_8:setPosition(cc.p(var_6_1:getContentSize().width / 2 + 50 + 100 * 1, self.LEVEL_CELL_HEIGHT / 2 + 10))
		var_6_8:setName("special_drop_node")
		var_6_1:addChild(var_6_8)

		for iter_6_2, iter_6_3 in pairs((activity_manager:getBattlePassDrop(self.activityId, arg_6_1.specialDrop))) do
			local var_6_9 = ItemPurchaseSprite:createPurchaseItem(iter_6_3.dropid, iter_6_3.dropNum)

			var_6_9:setScale(0.6)
			var_6_9:setTouchEnabled(true)
			var_6_9:setSwallowTouches(false)
			var_6_9:switchToBpItem(arg_6_1.stat == self.RECEIVE_ALL, not activity_manager:isBattlePassVIP(self.activityId), not activity_manager:isBattlePassVIP(self.activityId), self.itemsp_wordbg, self.layerName)
			var_6_9:addTouchEventListener(function(arg_8_0, arg_8_1)
				if math.abs(arg_8_0:getTouchBeganPosition().y - arg_8_0:getTouchEndPosition().y) > 50 then
					return
				end

				if arg_8_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not activity_manager:isBattlePassVIP(self.activityId) then
					LayerManager:pushInLayer(activity_manager:getBuyVipJumpTo(self.activityId), {
						activityId = self.activityId,
						imagePath = self.layerName
					})

					return
				end

				if arg_6_1.stat == self.LEVEL_UNACHIEVE then
					showItemDetails(iter_6_3.dropid)

					return
				end

				if arg_6_1.stat == self.RECEIVE_ALL then
					return
				end

				if arg_6_1.stat == self.RECEIVE_ORDINARY and not activity_manager:isBattlePassVIP(self.activityId) then
					return
				end

				activity_manager:getBattlePassReward(self.activityId, arg_6_1.level)
			end)
			var_6_9:setPosition(cc.p(-100 + (iter_6_2 - 1) * 150, -10))
			var_6_8:addChild(var_6_9)
		end
	end

	if type(arg_6_1.level) == "string" then
		var_6_1:setVisible(false)
	else
		var_6_1:setVisible(true)
	end

	return var_6_1
end
