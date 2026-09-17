PopActivityReturnSignLayer = class("PopActivityReturnSignLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")

local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local activity_return_manager = require("controller.activity_return_manager")
local gamebuff_data = require("data.gamebuff_data")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local var_0_7 = require("model.playermodel")
local returnback_conf_data = require("data.returnback_conf_data")
local returnback_sign_data = require("data.returnback_sign_data")
local var_0_10 = {
	"一",
	"二",
	"三",
	"四",
	"五",
	"六",
	"七",
	"八",
	"九",
	"十",
	"十一",
	"十二",
	"十三",
	"十四",
	"十五",
	"十六",
	"十七",
	"十八",
	"十九",
	"二十",
	"二十一",
	"二十二"
}
local item_data = require("data.item_data")

function PopActivityReturnSignLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopActivityReturnSignLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopActivityReturnSignLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Activity_Return_SignLayer.json" or "Activity_Return_SignLayer.ExportJson")

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg")

	self.rootpanel:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2))
	self.rootpanel:setScaleY(0)
	self.rootpanel:setTouchEnabled(false)

	self.jump_btn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_17")
	self.Listview = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_9")
	self.exitcallback = arg_3_1 and arg_3_1.callback
	self.updateCallback = arg_3_1 and arg_3_1.updateCallback

	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_19"):setVisible(false)
	self.rootLayer:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			if self.exitcallback then
				self.exitcallback()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self.showActions.extendVertical(self)
	activity_return_manager:get_returnback_info()
	self:registerActivityEventListener()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			activity_manager:releaseEventListenerByName("PopActivityReturnSignLayer")

			if self.activityScheduler then
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end
		end
	end)
end

local function var_0_12(arg_7_0)
	if arg_7_0 >= 86400 then
		return string.format("%02d天%02d小时", math.floor(arg_7_0 / 86400), math.floor(arg_7_0 % 86400 / 3600))
	elseif arg_7_0 >= 3600 then
		return string.format("%02d小时%02d分钟", math.floor(arg_7_0 / 3600), math.floor(arg_7_0 % 3600 / 60))
	else
		return string.format("%02d分钟%02d秒", math.floor(arg_7_0 / 60), math.floor(arg_7_0 % 60))
	end
end

function PopActivityReturnSignLayer.registerActivityEventListener(arg_8_0)
	activity_manager:registerEventListener("PopActivityReturnSignLayer", activity_manager.activityEventId.ACTIVITY_RETURN_SIGN_UPDATE, function(arg_9_0)
		arg_8_0:updateLefttime()

		arg_8_0.sign_data = activity_return_manager:get_sign_count()

		arg_8_0:initUI()
	end)
end

function PopActivityReturnSignLayer.dealWithData(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(returnback_sign_data) do
		table.insert(var_10_0, iter_10_1)
	end

	return var_10_0
end

function PopActivityReturnSignLayer.check_time_is_over(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return false
	end

	return not (arg_11_1.finishtime and time_check_manager:getCurTime() > global_get_time_by_date(arg_11_1.finishtime))
end

function PopActivityReturnSignLayer.dealJumpBtn(arg_12_0)
	local var_12_0 = activity_return_manager:get_jumpid()

	if not var_12_0 then
		print("error: ---------->  no jumpid!!!!!!!!!!!")
	end

	require("controller.goto_system_manager")
	goto_complete_system({
		jump_to_system = var_12_0.jump
	})
end

function PopActivityReturnSignLayer:initUI()
	self.Listview:removeAllChildren()

	if not self.sign_data then
		print("error:------------> no data")

		return
	end

	self.data = self:dealWithData(self.sign_data)
	self.can_get = activity_return_manager:get_can_sign()

	self.Listview:setItemsMargin(10)

	local var_13_0 = self.sign_data + 1

	if not self.can_get then
		var_13_0 = self.sign_data
	end

	for iter_13_0 = 1, #self.data do
		local var_13_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "items"):clone()

		while var_13_1:getChildByName("award" .. 1) do
			var_13_1:getChildByName("award" .. 1):removeFromParent()
		end

		local var_13_3 = activity_return_manager:getDropData(self.data[iter_13_0].drop_id)
		local var_13_4 = var_13_1:getChildByName("Label_13"):setString(glabal_trans_text_horizontal_to_vertical("第" .. var_0_10[returnback_sign_data[iter_13_0].id] .. "天"))

		for iter_13_1 = 1, #var_13_3 do
			local var_13_6 = type(var_13_3[iter_13_1].itemid) == "string" and ccui.Button:create("public/box/" .. "1" .. ".png", "public/box/" .. "1" .. ".png", nil, var_0_0) or ccui.Button:create("public/box/" .. item_data[var_13_3[iter_13_1].itemid].equip_quality .. ".png", "public/box/" .. item_data[var_13_3[iter_13_1].itemid].equip_quality .. ".png", nil, var_0_0)

			var_13_6:setAnchorPoint(cc.p(0.5, 0.5))
			var_13_6:setPosition(cc.p(0, 0))
			var_13_6:setTouchEnabled(true)
			var_13_6:setSwallowTouches(true)
			var_13_6:setPosition(cc.p(130 + (iter_13_1 - 1) * 110, 54))
			var_13_6:setName("award" .. iter_13_1)
			var_13_1:addChild(var_13_6, 1)

			local var_13_7
			local var_13_8

			if var_13_3[iter_13_1].itemid == "gold" and var_13_3[iter_13_1].num > 0 then
				var_13_7 = "equipment/1000001.png"
			elseif var_13_3[iter_13_1].itemid == "diamond" and var_13_3[iter_13_1].num > 0 then
				var_13_7 = "equipment/1000000.png"
			elseif item_data[var_13_3[iter_13_1].itemid].image_id then
				var_13_7 = "equipment/" .. item_data[var_13_3[iter_13_1].itemid].image_id .. ".png"
			else
				var_13_8 = item_data[var_13_3[iter_13_1].itemid].bag_item_type == kITEM_MEDAL and ItemSprite:create_medal_icon(var_13_3[iter_13_1].itemid) or componentManager:create_component_icon(var_13_3[iter_13_1].itemid, nil, nil)
			end

			var_13_8 = var_13_8 or ccui.ImageView:create(var_13_7)

			var_13_8:setPosition(cc.p(var_13_6:getContentSize().width / 2, var_13_6:getContentSize().height / 2))
			var_13_6:addChild(var_13_8)
			var_13_8:setScale(66 / math.min(var_13_8:getContentSize().width, var_13_8:getContentSize().height))

			local var_13_9 = cc.Label:createWithTTF("", "fonts/name.ttf", 18)

			var_13_9:setAnchorPoint(cc.p(0.5, 0.5))
			var_13_9:setString("x" .. var_13_3[iter_13_1].num)
			var_13_9:setName("drop_num")
			var_13_9:setPosition(cc.p(var_13_6:getContentSize().width / 2, var_13_6:getContentSize().height / 2 - 35))
			var_13_6:addChild(var_13_9, 10)

			var_13_6.itemtype = "gold"

			if var_13_3[iter_13_1].itemid ~= "gold" and var_13_3[iter_13_1].itemid ~= "diamond" then
				var_13_6.itemtype = "item"
			end

			var_13_6:addTouchEventListener(function(arg_14_0, arg_14_1)
				if arg_14_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:showDetailsofItems(var_13_3[iter_13_1].itemid, var_13_6.itemtype)
			end)
		end

		if iter_13_0 < var_13_0 then
			var_13_1:getChildByName("Image_11"):loadTexture("activity_return/sign_item1.png", var_0_0)
			var_13_1:getChildByName("button_get"):setVisible(false)
			var_13_1:getChildByName("button_lock"):setVisible(false)
			var_13_1:getChildByName("image_get"):setVisible(true)
		elseif var_13_0 == iter_13_0 then
			if self.can_get then
				var_13_1:getChildByName("Image_11"):loadTexture("activity_return/sign_item2.png", var_0_0)
				var_13_1:getChildByName("button_get"):setVisible(true)
				var_13_1:getChildByName("button_lock"):setVisible(false)
				var_13_1:getChildByName("image_get"):setVisible(false)
				var_13_1:getChildByName("button_get"):addTouchEventListener(function(arg_15_0, arg_15_1)
					if arg_15_1 ~= ccui.TouchEventType.ended then
						return
					end

					activity_return_manager:returnback_sign(function()
						activity_return_manager:get_returnback_info(function()
							if type(self.updateCallback) == "function" then
								self.updateCallback()
							end
						end)
					end)
				end)
			else
				var_13_1:getChildByName("Image_11"):loadTexture("activity_return/sign_item2.png", var_0_0)
				var_13_1:getChildByName("button_get"):setVisible(false)
				var_13_1:getChildByName("button_lock"):setVisible(false)
				var_13_1:getChildByName("image_get"):setVisible(true)
			end
		else
			var_13_1:getChildByName("Image_11"):loadTexture("activity_return/sign_item1.png", var_0_0)
			var_13_1:getChildByName("button_get"):setVisible(false)
			var_13_1:getChildByName("button_lock"):setVisible(true)
			var_13_1:getChildByName("image_get"):setVisible(false)
		end

		self.Listview:pushBackCustomItem(var_13_1)
	end
end

function PopActivityReturnSignLayer:exit(arg_18_1)
	self.hideActions.shrinkVertical(self, function()
		if self.exitcallback then
			self.exitcallback()
		end

		if arg_18_1 then
			arg_18_1()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopActivityReturnSignLayer:initBg(arg_20_1)
	local var_20_0 = ccui.Layout:create()

	var_20_0:setTouchEnabled(true)
	var_20_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_20_0:setAnchorPoint(cc.p(0, 0))
	var_20_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_20_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_20_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_20_0:setOpacity(0)
	var_20_0:setCascadeOpacityEnabled(false)
	self:addChild(var_20_0, -1)

	local var_20_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_20_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_20_1:setPositionX(var_20_0:getContentSize().width / 2)
	var_20_1:setPositionY(var_20_0:getContentSize().height / 2)
	var_20_0:addChild(var_20_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_21_0)
		self:addChild(arg_21_0, -2)
		arg_21_0:setPositionY(arg_21_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_20_1)
		var_20_0:setOpacity(102)
		var_20_0:setTouchEnabled(false)
	end)
end

function PopActivityReturnSignLayer:showDetailsofItems(arg_22_1, arg_22_2)
	local function var_22_1()
		return
	end

	if arg_22_2 == "item" then
		if item_data[arg_22_1].bag_item_type == kITEM_HORCRUX then
			local var_22_2 = -1
			local HelpGirl_data = require("data.HelpGirl_data")

			for iter_22_0, iter_22_1 in pairs((require("data.photofile_HelpGirl_data"))) do
				if iter_22_1.model_id == HelpGirl_data[arg_22_1].model then
					var_22_2 = iter_22_0

					break
				end
			end

			if var_22_2 == -1 then
				print("did not find id")

				return
			end

			LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
				id = var_22_2,
				itemid = arg_22_1,
				callback = var_22_1
			})
		elseif item_data[arg_22_1].bag_item_type == kITEM_HERO then
			LayerManager:pushInLayer("SoulsLayer", {
				showtype = 6,
				layertype = "DropDetailsLayer",
				cursoul = item_data[arg_22_1].servant,
				exitCallback = var_22_1
			})
		elseif not self:getChildByName("OTHER_LAYER") then
			local var_22_4 = PopLayer:Item({
				hideGainButton = true,
				itemid = arg_22_1
			})
		end
	elseif arg_22_2 == "gold" then
		-- block empty
	elseif arg_22_2 == "diamond" then
		-- block empty
	end
end

function PopActivityReturnSignLayer:updateLefttime()
	local var_24_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_time")
	local var_24_1 = activity_return_manager:get_end_time()

	if not var_24_1 then
		return
	end

	if var_24_1 > 0 then
		var_24_0:setString("剩余时间:" .. var_0_12(var_24_1 - time_check_manager:getCurTime()))
	else
		var_24_0:setString("活动已结束")
	end
end

function PopActivityReturnSignLayer:registerTimeCheckEvent()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("timeCheckManagerEvent", function(arg_26_0)
		if arg_26_0.eventType == NEXT_DAY then
			var_0_7:getServerTime(function()
				activity_return_manager:get_returnback_info()
			end)
		end
	end), self)
end
