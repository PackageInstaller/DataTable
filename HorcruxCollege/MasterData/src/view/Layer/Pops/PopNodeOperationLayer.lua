PopNodeOperationLayer = class("PopNodeOperationLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Layer.PopLayer")

local var_0_0 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local detail_data = require("data.detail_data")
local activity_plague_city_data = require("data.activity_plague_city_data")
local activity_plague_data = require("data.activity_plague_data")
local activity_plague_virus_data = require("data.activity_plague_virus_data")
local activity_doubleholiday_manager = require("controller.activity_doubleholiday_manager")
local item_doubleholiday_data = require("data.item_doubleholiday_data")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local activity_plague_other_data = require("data.activity_plague_other_data")

require("view.Sprite.ItemSprite")
require("view.Layer.Pops.PopGoodsLayer")
require("view.Layer.Pops.PopGiftBagLayer")
require("view.Layer.Pops.PopComponentLayer")

local var_0_12 = require("controller.item_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")

function PopNodeOperationLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopNodeOperationLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopNodeOperationLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "DoubleHoliday_CostShop.json" or "DoubleHoliday_CostShop.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "bg")

	self.rootpanel:setPositionY(self.rootpanel:getPositionY() + GameDisplay.fix_y)

	self.sp = ccui.Helper:seekWidgetByName(self.rootLayer, "sp")
	self.item_name = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_name")
	self.item_num = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_name2")
	self.item_dec1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_46"):getChildByName("Label_49")
	self.item_dec2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_47"):getChildByName("Label_49")
	self.sure_btn = ccui.Helper:seekWidgetByName(self.rootLayer, "button_sure")
	self.sure_left_time = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_name2_0_1_0")

	if arg_3_1 then
		self.callback = arg_3_1.callback
	end

	self.rootLayer:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_window_close_action(self.rootpanel, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)

	self.itemid = arg_3_1.itemid or 201912006
	self.surecallback = arg_3_1.surecallback

	self:initUI(self.itemid)
	global_window_open_action(self.rootpanel)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" and self.callback then
			self.callback()
		end
	end)
end

function PopNodeOperationLayer.getData(arg_7_0)
	return
end

function PopNodeOperationLayer.dealWithData(arg_9_0, arg_9_1)
	return
end

function PopNodeOperationLayer.subCost(arg_10_0, arg_10_1)
	if not arg_10_1 then
		return
	end

	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		if iter_10_1.entityid == 0 then
			playermodel.gold = playermodel.gold - iter_10_1.num
		elseif iter_10_1.entityid == 1 then
			playermodel.diamond = playermodel.diamond - iter_10_1.num
		else
			var_0_12:deleteItem(iter_10_1.entityid, iter_10_1.num)
		end
	end
end

function PopNodeOperationLayer:initUI(arg_11_1)
	self.sp:loadTexture("equipment/" .. item_doubleholiday_data[arg_11_1].image_id .. ".png")

	self.itemid = arg_11_1

	local var_11_0 = var_0_12:getItemNumber(arg_11_1)

	self.item_name:setString(item_doubleholiday_data[arg_11_1].name)
	self.item_num:setString(L_FOOD_NUM .. global_trans_number(var_11_0))
	self.item_dec1:setString((item_doubleholiday_data[arg_11_1].user_manual or nil) and (item_doubleholiday_data[arg_11_1].user_manual or L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_9))
	self.item_dec2:setString(item_doubleholiday_data[arg_11_1].intro)

	local var_11_1 = activity_doubleholiday_manager:get_left_time()

	if var_11_1 < 0 then
		self.sure_left_time:setString(L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_10 .. "0")
	else
		self.sure_left_time:setString(L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_10 .. var_11_1)
	end

	if var_11_0 > 0 then
		self.sure_btn:getChildByName("label"):setString(L_BUTTON_TEXT.Use)

		self.sure_btn.status = 1
	else
		self.sure_btn:getChildByName("label"):setString(L_DOUBLEHOLIDAY_WOLDCITYLAYER.BUY_AND_USE)

		self.sure_btn.status = 2
	end

	local var_11_2 = activity_doubleholiday_manager:get_contain()

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_name2_0_1"):setString(L_DOUBLEHOLIDAY_WOLDCITYLAYER.NOW_VIRUS .. global_trans_number(item_manager:getItemNumber(201912001)) .. "/" .. var_11_2)

	self.diamondIcon = ccui.ImageView:create("public/currency/UI_battleEnd_diamond.png", var_0_0)

	self.diamondIcon:setPositionX(140)
	self.diamondIcon:setPositionY(-20)
	self.sure_btn:addChild(self.diamondIcon)

	self.diamondLabel = cc.Label:createWithTTF(activity_plague_other_data.virus_buy_cost.rule, FONT_DES, 25)

	self.diamondLabel:setAnchorPoint(cc.p(0, 0.5))
	self.diamondLabel:setPositionX(160)
	self.diamondLabel:setPositionY(-20)
	self.sure_btn:addChild(self.diamondLabel)
	self.diamondLabel:setVisible(var_11_0 <= 0)
	self.diamondIcon:setVisible(var_11_0 <= 0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_name2_0"):setVisible(var_11_2 > item_manager:getItemNumber(201912001))
	self:updateTime()
	self.sure_btn:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_doubleholiday_manager:add_virus(12, self.sure_btn.status, function(arg_15_0)
			if arg_15_0.result == 1 then
				global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.USE_SUCESS)

				if arg_15_0.virus then
					global_gain({
						items = {
							arg_15_0.virus
						}
					})
				end

				if arg_15_0.diamond and arg_15_0.diamond > 0 then
					playermodel.diamond = playermodel.diamond - arg_15_0.diamond

					global_update_gold_stone_diamond(nil, nil, arg_15_0.diamond)
				end

				if arg_15_0.consumes then
					self:subCost(arg_15_0.consumes)
				end

				local var_15_0 = activity_doubleholiday_manager:get_left_time()

				if var_15_0 < 0 then
					self.sure_left_time:setString(L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_10 .. "0")
				else
					self.sure_left_time:setString(L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_10 .. var_15_0)
				end

				local var_15_1 = var_0_12:getItemNumber(self.itemid)

				self.item_num:setString(L_FOOD_NUM .. global_trans_number(var_15_1))

				if var_15_1 > 0 then
					self.sure_btn:getChildByName("label"):setString(L_BUTTON_TEXT.Use)

					self.sure_btn.status = 1
				else
					self.sure_btn:getChildByName("label"):setString(L_DOUBLEHOLIDAY_WOLDCITYLAYER.BUY_AND_USE)

					self.sure_btn.status = 2
				end

				self.diamondLabel:setVisible(var_15_1 <= 0)
				self.diamondIcon:setVisible(var_15_1 <= 0)
				ccui.Helper:seekWidgetByName(self.rootLayer, "Label_name2_0"):setVisible(item_manager:getItemNumber(201912001) < var_11_2)
				ccui.Helper:seekWidgetByName(self.rootLayer, "Label_name2_0_1"):setString(L_DOUBLEHOLIDAY_WOLDCITYLAYER.NOW_VIRUS .. global_trans_number(item_manager:getItemNumber(201912001)) .. "/" .. activity_doubleholiday_manager:get_contain())
			elseif arg_15_0.result == 2 then
				global_ShowBlockWords(L_MARKET_MSG.Item_Lack)
			elseif arg_15_0.result == 3 then
				global_ShowBlockWords(L_MARKET_BUY_WARNING[3])
			elseif arg_15_0.result == 4 then
				LayerManager:pushInLayer("PopGoBuyDiamond", {
					is_need_pop_layer = 1
				})
			end
		end)
	end)
end

function PopNodeOperationLayer:updateTime()
	self:updateTime1(ccui.Helper:seekWidgetByName(self.rootLayer, "Label_name2_0"), (activity_doubleholiday_manager:get_recover_time()))
end

function PopNodeOperationLayer.updateTime1(arg_17_0, arg_17_1, arg_17_2)
	arg_17_1:scheduleUpdateWithPriorityLua(function(arg_18_0)
		local var_18_0 = activity_doubleholiday_manager:get_recover_time() - time_check_manager:getCurTime()

		arg_17_0:updateVirsYinZi()

		if var_18_0 <= 0 then
			arg_17_1:setString("")
		else
			arg_17_1:setString("(" .. (function(arg_19_0)
				return string.format("%02d:%02d", math.floor(var_18_0 / 60), var_18_0 % 60)
			end)(var_18_0) .. L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_11)
		end
	end, 0)
end

function PopNodeOperationLayer:updateVirsYinZi()
	local var_20_0 = activity_doubleholiday_manager:get_contain()

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_name2_0_1"):setString(L_DOUBLEHOLIDAY_WOLDCITYLAYER.NOW_VIRUS .. global_trans_number(item_manager:getItemNumber(201912001)) .. "/" .. var_20_0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_name2_0"):setVisible(var_20_0 > item_manager:getItemNumber(201912001))
end

function PopNodeOperationLayer.updateNode(arg_21_0, arg_21_1)
	return
end

function PopNodeOperationLayer:initBg(arg_22_1)
	local var_22_0 = ccui.Layout:create()

	var_22_0:setTouchEnabled(true)
	var_22_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_22_0:setAnchorPoint(cc.p(0, 0))
	var_22_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_22_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_22_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_22_0:setOpacity(0)
	var_22_0:setCascadeOpacityEnabled(false)
	self:addChild(var_22_0, -1)

	local var_22_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_22_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_22_1:setPositionX(var_22_0:getContentSize().width / 2)
	var_22_1:setPositionY(var_22_0:getContentSize().height / 2)
	var_22_0:addChild(var_22_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_23_0)
		self:addChild(arg_23_0, -2)
		arg_23_0:setPositionY(arg_23_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_22_1)
		var_22_0:setOpacity(102)
		var_22_0:setTouchEnabled(false)
	end)
end
