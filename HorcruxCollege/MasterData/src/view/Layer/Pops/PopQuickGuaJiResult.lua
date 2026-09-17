PopQuickGuaJiResult = class("PopQuickGuaJiResult", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Layer.PopLayer")

local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local dropcache_manager = require("controller.dropcache_manager")
local level_manager = require("controller.level_manager")
local array_manager = require("controller.array_manager")
local var_0_10 = 174
local var_0_11 = 228

function PopQuickGuaJiResult.create(arg_2_0, arg_2_1)
	local var_2_0 = PopQuickGuaJiResult.new()

	var_2_0:init(arg_2_1, arg_2_1.callback)

	return var_2_0
end

function PopQuickGuaJiResult:init(arg_3_1, arg_3_2)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "quick_guaji_result.json" or "quick_guaji_result.ExportJson")

	self:addChild(self.rootLayer, 2)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_11"):getVirtualRenderer():setColor(cc.c3b(181, 196, 201))

	self.scrollView = ccui.Helper:seekWidgetByName(self.rootLayer, "ScrollView_12")
	self.title_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_4")
	self.title_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_5")
	self.title_3 = ccui.Helper:seekWidgetByName(self.rootLayer, "BitmapLabel_8")
	self.title_4 = ccui.Helper:seekWidgetByName(self.rootLayer, "BitmapLabel_10")
	self.title_5 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_6")
	self.surebtn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_13")

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_11"):setString(L_FIGHT_RESULT_TITLE.Item_Title[1])
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_21"):setString(L_BUTTON_TEXT.Comfirm)
	self.surebtn:setScale(1)

	self.bg = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_1")
	self.imge = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_15")
	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_1")

	self.rootpanel:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootpanel:setPosition(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2)

	local var_3_0 = arg_3_1.surecallback
	local var_3_1 = arg_3_1.cancelcallback

	self.cancelcallback = arg_3_1.cancelcallback

	self.surebtn:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)

			if var_3_0 then
				var_3_0()
			end
		end)
	end)
	self:createFullScreenMask(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)

			if var_3_1 then
				var_3_1()
			end
		end)
	end)
	self:initResultPanel(arg_3_1)
	self.showActions.extendVertical(self)
	self:registerScriptHandler(function(arg_8_0)
		if arg_8_0 == "exit" and arg_3_2 then
			arg_3_2()
		end
	end)
end

function PopQuickGuaJiResult:initResultPanel(arg_9_1)
	self.title_1:setString(L_FIGHT_RESULT_TITLE.Hangup_Title[1] .. ": " .. arg_9_1.time)
	self.title_2:setString(L_FIGHT_RESULT_TITLE.Hangup_Title[2] .. ": " .. arg_9_1.name)
	self.title_3:setString((global_trans_bitmapnumber(tonumber(arg_9_1.sp))))
	self.title_4:setString((global_trans_bitmapnumber(tonumber(arg_9_1.gold))))
	self.title_5:setString(L_FIGHT_RESULT_TITLE.Hangup_Title[3])
	self:initPanelList(arg_9_1)
end

function PopQuickGuaJiResult:initPanelList(arg_10_1)
	self:initFightGirl()

	local var_10_0 = 0
	local var_10_1 = 0
	local var_10_2 = self.scrollView:getContentSize()
	local var_10_3 = var_10_2.width / (60 + (var_0_10 + 20) * 4)
	local var_10_4 = (40 + math.ceil(#arg_10_1.items / 4) * (20 + var_0_11)) * (var_10_2.width / (60 + (var_0_10 + 20) * 4))

	if var_10_4 < var_10_2.height then
		var_10_4 = var_10_2.height
	end

	self.scrollView:setContentSize(var_10_2)
	self.scrollView:setInnerContainerSize(cc.size(var_10_2.width, var_10_4))

	for iter_10_0, iter_10_1 in ipairs(arg_10_1.items) do
		local var_10_5
		local var_10_6

		if arg_10_1.createItemType == "itemid" then
			local var_10_7

			if iter_10_1.component_attr then
				var_10_7 = iter_10_1.component_attr
			elseif iter_10_1.weapon_attr then
				var_10_7 = iter_10_1.weapon_attr
			elseif iter_10_1.horcrux_attr then
				var_10_7 = iter_10_1.horcrux_attr
			end

			var_10_5 = ItemSprite:createNewWithItemId(iter_10_1.itemid, iter_10_1.itemcount, nil, nil, var_10_7)
			var_10_6 = iter_10_1.itemid
		else
			var_10_5 = ItemSprite:createBigWithEntityId(iter_10_1.entityid, iter_10_1.dropNum)
			var_10_6 = iter_10_1.dropid
		end

		var_10_5:setTouchEnabled(true)
		self:addListenerForSP(var_10_5, var_10_6, iter_10_1.entityid)
		var_10_5:setAnchorPoint(cc.p(0.5, 0.5))
		var_10_5:setScale(var_10_3)
		var_10_5:setPosition(cc.p((40 + var_0_10 / 2 + (var_0_10 + 20) * var_10_1) * var_10_3, var_10_4 - (20 + var_0_11 / 2 + (var_0_11 + 20) * var_10_0) * var_10_3))
		self.scrollView:addChild(var_10_5)

		var_10_1 = var_10_1 + 1

		if var_10_1 >= 4 then
			var_10_0 = var_10_0 + 1
			var_10_1 = 0
		end
	end
end

function PopQuickGuaJiResult:initFightGirl()
	local var_11_0

	for iter_11_0, iter_11_1 in pairs((array_manager:getBattleArrayData(array_manager:getLevelArray()))) do
		if iter_11_1.fight_girl then
			var_11_0 = iter_11_1.fight_girl

			break
		end
	end

	self.imge:loadTexture("role1/" .. model_data[global_get_servant_skin(var_11_0)].cute_role .. ".png")
	self.imge:setScale(0.5)
	self.imge:setPositionX(self.imge:getPositionX() + 18)
	self.imge:setPositionY(self.imge:getPositionY() + 30)
end

function PopQuickGuaJiResult.addListenerForSP(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_1:addSpriteTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_data[arg_12_2].bag_item_type == kITEM_HORCRUX then
			return
		end

		if item_data[arg_12_2].bag_item_type == kITEM_HERO then
			return
		end

		if math.abs(arg_13_0:getLocation().y - arg_13_0:getStartLocation().y) >= 50 then
			return
		end

		if not arg_12_0:getChildByName("OTHER_LAYER") then
			local var_13_0 = PopLayer:Item({
				hideGainButton = true,
				itemid = arg_12_2,
				entityid = arg_12_3
			})
		end
	end)
end

function PopQuickGuaJiResult:exit()
	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)

		if self.cancelcallback then
			self.cancelcallback()
		end
	end)
end

return PopQuickGuaJiResult
