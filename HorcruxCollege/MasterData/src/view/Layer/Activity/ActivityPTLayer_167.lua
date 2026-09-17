require("view.Layer.Activity.ActivityPTBaseLayer")

ActivityPTLayer_167 = class("ActivityPTLayer_167", function()
	return ActivityPTBaseLayer:create()
end)

local activity_conf_data = require("data.activity_conf_data")

function ActivityPTLayer_167.create(arg_2_0)
	local var_2_0 = ActivityPTLayer_167.new()

	var_2_0:init()

	return var_2_0
end

function ActivityPTLayer_167:initDynamicConfig()
	self.layerName = "ActivityPTLayer_167"
	self.activityId = 167
	self.addPosY = 30
	self.pointitemid = activity_conf_data[self.activityId].item1 or 123010001
	self.pointmaxnum = activity_conf_data[self.activityId].item_limit1 or 1000000
end

function ActivityPTLayer_167.resetValues(arg_4_0)
	arg_4_0.LEVEL_CELL_HEIGHT = 128
	arg_4_0.TASK_CELL_HEIGHT = 130
end

function ActivityPTLayer_167:setUIPosition()
	local var_5_0 = self.rootLayer:getChildByName("panel_up")
	local var_5_1 = var_5_0:getChildByName("title_detial")

	var_5_1:setAnchorPoint(cc.p(0, 1))
	var_5_1:setPosition(8, var_5_0:getContentSize().height - 16)
	var_5_0:getChildByName("btn_detail"):setPosition(var_5_1:getContentSize().width, 230)
	var_5_0:getChildByName("upup"):setPosition(60, 128)
	var_5_0:getChildByName("button_jump_to"):setPosition(204, 58)

	local var_5_2 = var_5_0:getChildByName("level_bg")

	var_5_2:setAnchorPoint(cc.p(1, 0.5))
	var_5_2:setPosition(318, 122)
	var_5_2:setScale9Enabled(true)
	var_5_2:setCapInsets(cc.rect(14, 0, 134, 24))

	local var_5_3 = var_5_2:getChildByName("cur_level")

	var_5_3:setAnchorPoint(cc.p(0, 0.5))
	var_5_3:setPositionX(0)
	var_5_3:setColor(cc.c3b(52, 36, 175))

	self.progressBar_pos = cc.p(190, 104)

	local var_5_4 = var_5_0:getChildByName("lbl_time")

	var_5_4:setPosition(184, 180)
	var_5_4:setColor(cc.c3b(66, 165, 255))

	local var_5_5 = var_5_0:getChildByName("cur_exp")

	var_5_5:setPosition(cc.p(50, var_5_5:getPostionY()))
	var_5_5:setColor(cc.c3b(255, 82, 82))
end

function ActivityPTLayer_167:createLevelSprite(arg_6_1)
	local var_6_0 = ccui.ImageView:create(self.layerName .. "/pt_bg.png", ConfigTextureType)

	var_6_0:setName("sprite_bg")
	var_6_0:setTag(100)

	if type(arg_6_1.level) == "string" then
		var_6_0:setVisible(false)
	else
		var_6_0:setVisible(true)
	end

	local var_6_1 = ccui.ImageView:create(self.layerName .. (self:checkPointEnough(arg_6_1) and "/level_bg_l.png" or "/level_bg_b.png"), ConfigTextureType)

	var_6_1:setPosition(cc.p(63, self.LEVEL_CELL_HEIGHT / 2))
	var_6_1:setName("cur_level_bg_b")
	var_6_0:addChild(var_6_1, 100)

	local var_6_2 = cc.Label:createWithTTF(tostring(arg_6_1.limitpoint), FONT_NAME, global_change_fontsize_by_length(arg_6_1.limitpoint, 26, 3, 8))

	var_6_2:setName("cur_level_lbl")
	var_6_2:setColor(self:checkPointEnough(arg_6_1) and cc.c3b(116, 66, 38) or cc.c3b(6, 57, 150))
	var_6_2:setPosition(cc.p(var_6_1:getContentSize().width / 2, var_6_1:getContentSize().height / 2))
	var_6_1:addChild(var_6_2)

	local var_6_3 = ccui.Slider:create()

	var_6_3:setAnchorPoint(cc.p(0, 0.5))
	var_6_3:setRotation(90)
	var_6_3:setName("progress_bar")
	var_6_3:loadBarTexture(self.layerName .. "/progress_acr_bg.png", ConfigTextureType)
	var_6_3:loadProgressBarTexture(self.layerName .. "/progress_acr.png", ConfigTextureType)
	var_6_3:setPosition(cc.p(var_6_1:getPositionX(), var_6_1:getPositionY() - var_6_1:getContentSize().height / 2 + 8))
	var_6_0:addChild(var_6_3, 50)

	if arg_6_1.level == activityManager:getPTProceedMaxLevel(self.activityId) then
		var_6_3:setVisible(false)
	elseif arg_6_1.level < self.curLevel then
		var_6_3:setPercent(100)
	elseif arg_6_1.level == self.curLevel then
		var_6_3:setPercent((self:getCurLevelProceedPrecent(self.curLevel)))
	else
		var_6_3:setPercent(0)
	end

	if type(arg_6_1.level) ~= "string" and arg_6_1.drop then
		local var_6_4 = ccui.Layout:create()

		var_6_4:setPosition(cc.p(124, self.LEVEL_CELL_HEIGHT / 2))
		var_6_4:setName("drop_node")
		var_6_0:addChild(var_6_4)

		for iter_6_0, iter_6_1 in pairs((activityManager:getPTDrop(arg_6_1.drop))) do
			local var_6_5 = ItemPurchaseSprite:createPurchaseItem(iter_6_1.dropid, iter_6_1.dropNum)

			var_6_5:setScale(0.6)
			var_6_5:setTouchEnabled(true)
			var_6_5:setOpacity(arg_6_1.stat == self.AWARD_YES and 180 or 255)
			var_6_5:setSwallowTouches(false)
			var_6_5:getChildByName("wordBg"):loadTexture(self.layerName .. "/num_bg.png", ConfigTextureType)
			var_6_5:getChildByName("wordBg"):setScale(1.6)
			var_6_5:getChildByName("numLabel"):setColor(cc.p(78, 65, 138))
			var_6_5:addTouchEventListener(function(arg_7_0, arg_7_1)
				if arg_7_1 ~= ccui.TouchEventType.ended then
					return
				end

				if math.abs(arg_7_0:getTouchBeganPosition().y - arg_7_0:getTouchEndPosition().y) > 50 then
					return
				end

				if type(iter_6_1.dropid) == "string" then
					return
				end

				LayerManager:pushInLayer("PopItemLayer", {
					itemid = iter_6_1.dropid
				})
			end)
			var_6_5:setPosition(cc.p(92 + (iter_6_0 - 1) * 150, 0))
			var_6_4:addChild(var_6_5)

			local var_6_6 = ccui.ImageView:create(self.layerName .. "/sp_mark.png", ConfigTextureType)

			var_6_6:setVisible(arg_6_1.stat == self.AWARD_YES)
			var_6_6:setPosition(var_6_5:getPositionX(), var_6_5:getPositionY())
			var_6_6:setName("pt_mark")
			var_6_4:addChild(var_6_6, 999)
		end
	end

	local var_6_8 = ccui.Button:create(self.layerName .. (arg_6_1.stat == self.AWARD_YES and "/progress_btn3.png" or self:checkPointEnough(arg_6_1) and "/progress_btn.png" or "/progress_btn2.png"), nil, self.layerName .. "/progress_btn.png", ConfigTextureType)

	var_6_8:setPosition(526, self.LEVEL_CELL_HEIGHT / 2)
	var_6_8:setName("sureBtn")
	var_6_0:addChild(var_6_8)
	var_6_8:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_8_0:getTouchBeganPosition().y - arg_8_0:getTouchEndPosition().y) > 50 then
			return
		end

		if self.global_touch_lock then
			return
		end

		if arg_6_1.stat == self.AWARD_YES then
			return
		end

		self:getPTProceedAward(arg_6_1.level)
	end)

	if type(arg_6_1.level) == "string" then
		var_6_0:setVisible(false)
	else
		var_6_0:setVisible(true)
	end

	return var_6_0
end
