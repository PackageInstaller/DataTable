PopShowGilrPreviewLayer = class("PopShowGilrPreviewLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local item_manager = require("controller.item_manager")
local item_data = require("data.item_data")
local favorfile_data = require("data.favorfile_data")
local model_data = require("data.model_data")
local playermodel = require("model.playermodel")
local L2Actor = require("view.Sprite.L2Actor")
local major_factor_data = require("data.major_factor_data")
local var_0_8 = {}

function PopShowGilrPreviewLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopShowGilrPreviewLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopShowGilrPreviewLayer:init(arg_3_1)
	local var_3_0 = arg_3_1.itemid
	local var_3_1 = arg_3_1.modelid
	local var_3_2 = arg_3_1.showGain

	if not arg_3_1.modelid then
		var_3_1 = item_data[arg_3_1.itemid].model or "15330"
	end

	local var_3_3 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "SoulGirlPop.json" or "SoulGirlPop.ExportJson")
	local var_3_4 = ccui.Helper:seekWidgetByName(var_3_3, "Panel_26")

	var_3_4:setLocalZOrder(1)
	self:addChild(var_3_3)

	self.rootLayer = var_3_3
	self.showSoulGirlScenePanel = ccui.Helper:seekWidgetByName(var_3_3, "Image_back")

	self.showSoulGirlScenePanel:setPosition(cc.p(320, 568))
	self.showSoulGirlScenePanel:setTouchEnabled(true)
	self.showSoulGirlScenePanel:setLocalZOrder(0)

	local var_3_5 = ccui.Helper:seekWidgetByName(var_3_3, "Button_return")

	var_3_5:loadTextures("MarketLayer/return_btn_bright.png", nil, "MarketLayer/return_btn_bright.png", var_0_0)
	var_3_5:setLocalZOrder(2)

	local function var_3_6(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.showgirlLayer:resetCurTalkConfig()
		LayerManager:removePopLayer()
	end

	var_3_5:setTouchEnabled(false)
	self.showSoulGirlScenePanel:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function(...)
		var_3_5:setTouchEnabled(true)
		var_3_5:addTouchEventListener(var_3_6)
	end)))

	local var_3_7 = ccui.Helper:seekWidgetByName(var_3_3, "Panel_cute_role")
	local var_3_8 = ccui.Helper:seekWidgetByName(var_3_3, "Image_cute_role")

	var_3_8:loadTexture("roleimage/role1/" .. model_data[var_3_1].cute_role .. ".png")
	var_3_8:setPosition(cc.p(var_3_7:getContentSize().width / 2, var_3_7:getContentSize().height / 2 + 30))
	var_3_8:setScale(0.4)
	var_3_8:setVisible(false)

	local var_3_9 = ccui.Helper:seekWidgetByName(var_3_3, "Panel_up"):setPositionY(568 + GameDisplay.fix_y)
	local var_3_10 = ccui.Helper:seekWidgetByName(var_3_3, "Panel_down"):setPositionY(568 - GameDisplay.fix_y)

	ccui.Helper:seekWidgetByName(var_3_3, "Panel_down"):setLocalZOrder(3)
	ccui.Helper:seekWidgetByName(var_3_3, "Panel_up"):setLocalZOrder(3)

	L2ActorSprite = L2Actor:create(ROLE_SPINE_PATH .. model_data[var_3_1].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_3_1].spine_model .. ".atlas", (model_data[var_3_1].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[var_3_1].clothes_model .. ".atlas" or nil))

	local var_3_11 = model_data[var_3_1].actorScale or model_data[var_3_1].modelscale / 1.3 * 0.4

	L2ActorSprite:setScale(var_3_11, var_3_11)
	L2ActorSprite:setContentSize(cc.size(100, 200))
	L2ActorSprite:setPosition(cc.p(var_3_7:getContentSize().width / 2, var_3_7:getContentSize().height / 2 - 60))
	var_3_7:addChild(L2ActorSprite, 99)
	L2ActorSprite:playAni(nil, "idle", true)
	var_3_7:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_6_0 = math.random(2, 5)

		local function var_6_1()
			L2ActorSprite:playAni(nil, "idle", true)
		end

		if var_6_0 == 2 then
			L2ActorSprite:playAni(var_6_1, "run", false)
		elseif var_6_0 == 3 then
			L2ActorSprite:playAni(var_6_1, "yule", false)
		elseif var_6_0 == 4 then
			L2ActorSprite:playAni(var_6_1, "chihe", false)
		else
			L2ActorSprite:playAni(var_6_1, "fadai", false)
		end
	end)

	local var_3_12 = ccui.Helper:seekWidgetByName(var_3_3, "Label_name")
	local var_3_13 = ccui.Helper:seekWidgetByName(var_3_3, "Image_cv")

	var_3_13:loadTexture("public/panelbg/cv_bg.png", var_0_0)

	if favorfile_data[3][model_data[var_3_1].photofile_model] then
		var_3_13:setVisible(favorfile_data[3][model_data[var_3_1].photofile_model] ~= L_CV_UNSURE)

		local var_3_14 = cc.Label:createWithTTF(L_CV .. favorfile_data[3][model_data[var_3_1].photofile_model], FONT_DES, 28)

		var_3_14:setPosition(cc.p(var_3_13:getContentSize().width / 2, var_3_13:getContentSize().height / 2 - 3))
		var_3_13:addChild(var_3_14)
	else
		var_3_13:setVisible(false)
	end

	var_3_12:setFontSize(global_change_fontsize_by_length(major_factor_data[model_data[var_3_1].major].easy_name, 40, 4, 6))
	var_3_12:setString(major_factor_data[model_data[var_3_1].major].easy_name)
	var_3_12:setLocalZOrder(9999)

	local var_3_15 = ccui.Helper:seekWidgetByName(var_3_3, "Label_name_bottom")
	local var_3_16 = ccui.Helper:seekWidgetByName(var_3_3, "Label_name_top")

	var_3_15:setString(model_data[var_3_1].main_name)
	var_3_16:setString(model_data[var_3_1].main_name)
	var_3_15:setColor(cc.c3b(40, 125, 205))
	var_3_16:setColor(cc.c3b(0, 255, 246))

	local var_3_17 = ccui.Helper:seekWidgetByName(var_3_3, "Image_type")
	local var_3_18

	if model_data[var_3_1].live2d and not model_data[var_3_1].origin then
		var_3_18 = "MarketLayer/skin_type_live2d.png"
	elseif model_data[var_3_1].rolespine then
		var_3_18 = "MarketLayer/skin_type_spine.png"
	else
		var_3_17:setVisible(false)
	end

	var_3_17:loadTextures(var_3_18, nil, var_3_18, var_0_0)

	local var_3_19 = ccui.Helper:seekWidgetByName(var_3_3, "Image_cost_bottom")

	var_3_19:loadTexture("MarketLayer/cost_bottom_bright.png", var_0_0)
	var_3_19:setVisible(false)
	ccui.Helper:seekWidgetByName(var_3_3, "Image_name"):loadTexture("MarketLayer/skin_name_bottom_bright.png", var_0_0)

	local var_3_20 = ccui.Helper:seekWidgetByName(var_3_3, "Button_buy")

	var_3_20:loadTextures("MarketLayer/buy_btn_bright.png", nil, "MarketLayer/buy_btn_bright.png", var_0_0)
	var_3_20:setVisible(false)

	local var_3_21 = ccui.Layout:create()

	var_3_21:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_3_21:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_21:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_3_21:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_3_21:setBackGroundColor(cc.c3b(0, 0, 0))
	var_3_21:setBackGroundColorOpacity(0)
	var_3_4:addChild(var_3_21, 2)

	local var_3_22 = cc.EventListenerTouchOneByOne:create()

	var_3_22:setSwallowTouches(false)
	var_3_22:registerScriptHandler(function(arg_8_0, arg_8_1)
		if item_manager:getItemNumber(var_3_0) > 0 then
			return true
		end

		if var_0_8[playermodel.playerid][var_3_1] > PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT + 1 and item_manager:getItemNumber(var_3_0) < 1 then
			global_ShowBlockWords(L_DORMROOM_SEND_GIFT.Interaciton_Used_Up)

			return true
		elseif var_0_8[playermodel.playerid][var_3_1] >= PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT then
			var_0_8[playermodel.playerid][var_3_1] = var_0_8[playermodel.playerid][var_3_1] + 1

			global_ShowBlockWords(L_DORMROOM_SEND_GIFT.Interaciton_Used_Up)

			return false
		else
			return true
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_3_22:registerScriptHandler(function(arg_9_0, arg_9_1)
		self:showUI()

		return false
	end, cc.Handler.EVENT_TOUCH_ENDED)
	var_3_21:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_3_22, var_3_21)

	if item_manager:getItemNumber(arg_3_1.itemid) == 1 then
		var_3_20:setVisible(false)
		var_3_19:setVisible(false)
	end

	local var_3_23 = ccui.Helper:seekWidgetByName(var_3_3, "Image_costType_new")

	self.showSoulGirlScenePanel:setVisible(true)
	var_3_23:setVisible(false)
	ccui.Helper:seekWidgetByName(var_3_3, "Label_cost_num_new"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_3_3, "Panel_old_cost"):setVisible(false)

	self.showgirlLayer = require("view.Layer.ShowGirlLayer"):create(var_3_1, 3, nil, function(arg_10_0)
		if arg_10_0 == EVENT_SETTING_SHOWGIRL.LIVE2D_START then
			self:hideUI()
		elseif arg_10_0 == EVENT_SETTING_SHOWGIRL.LIVE2D_FINISH then
			self:showUI()
		end
	end, true)

	self.showgirlLayer:resetCurTalkConfig()

	if not var_0_8[playermodel.playerid] then
		var_0_8[playermodel.playerid] = {}
		var_0_8[playermodel.playerid][var_3_1] = var_0_8[playermodel.playerid][var_3_1] or 0
	else
		var_0_8[playermodel.playerid][var_3_1] = var_0_8[playermodel.playerid][var_3_1] or 0
	end

	self.showgirlLayer:setTalkEnabled(item_manager:getItemNumber(arg_3_1.itemid) > 0 or var_0_8[playermodel.playerid][var_3_1] < PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT)
	self.showgirlLayer:setTouchTalkCallback(function()
		var_0_8[playermodel.playerid][var_3_1] = var_0_8[playermodel.playerid][var_3_1] + 1

		self.showgirlLayer:setTalkEnabled(item_manager:getItemNumber(var_3_0) > 0 or var_0_8[playermodel.playerid][var_3_1] < PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT)
	end)
	var_3_4:addChild(self.showgirlLayer, 1)

	if model_data[var_3_1].backgroundid then
		var_3_4:addChild(BackGroundLayer:create(model_data[var_3_1].backgroundid, (model_data[var_3_1].is_own_full_screen_background == 1 or nil) and 2), 0)
	end

	if var_3_2 and item_manager:getItemNumber(major_factor_data[model_data[var_3_1].major].swim_suit) <= 0 then
		self:addGoGainBtn(var_3_1)
	end
end

function PopShowGilrPreviewLayer:addGoGainBtn(arg_12_1)
	local var_12_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_buy")
	local var_12_1 = ccui.Button:create("SwimMainLayer/buy_btn_gain.png", nil, "SwimMainLayer/buy_btn_gain.png", var_0_0)

	var_12_1:setPosition(cc.p(var_12_0:getPositionX(), var_12_0:getPositionY()))
	var_12_0:getParent():addChild(var_12_1)
	var_12_1:addTouchEventListener(function(arg_13_0, arg_13_1)
		local var_13_0

		if arg_13_1 ~= ccui.TouchEventType.ended then
			do return end

			var_13_0 = {}
		end

		var_13_0.item = major_factor_data[model_data[arg_12_1].major].swim_suit

		LayerManager:pushInLayer("PopGoGainLayer", var_13_0)
	end)
end

function PopShowGilrPreviewLayer.exit(arg_14_0)
	LayerManager:removePopLayer()
end

function PopShowGilrPreviewLayer:hideUI()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_up"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_down"):setVisible(false)
end

function PopShowGilrPreviewLayer:showUI()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_up"):setVisible(true)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_down"):setVisible(true)
end
