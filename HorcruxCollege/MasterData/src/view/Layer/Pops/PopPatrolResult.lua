PopPatrolResult = class("PopPatrolResult", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Layer.PopLayer")

local var_0_0 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local dropcache_manager = require("controller.dropcache_manager")
local level_manager = require("controller.level_manager")
local array_manager = require("controller.array_manager")
local audio_manager = require("controller.audio_manager")
local var_0_11 = 174
local var_0_12 = 228

function PopPatrolResult.create(arg_2_0, arg_2_1)
	local var_2_0 = PopPatrolResult.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopPatrolResult:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "quick_guaji_result.json" or "quick_guaji_result.ExportJson")

	self:addChild(self.rootLayer, 2)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPositionY(-GameDisplay.fix_y)

	self.scrollView = ccui.Helper:seekWidgetByName(self.rootLayer, "ScrollView_12")
	self.title_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_4")
	self.title_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_5")

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_6"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_11"):setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Label_6"):getPositionY())

	self.title_3 = ccui.Helper:seekWidgetByName(self.rootLayer, "BitmapLabel_8")
	self.title_4 = ccui.Helper:seekWidgetByName(self.rootLayer, "BitmapLabel_10")
	self.surebtn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_13")
	self.bg = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_1")
	self.imge = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_15")

	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_3"):loadTexture("fightResultNew/title_garrisonfight.png", var_0_0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_11"):getVirtualRenderer():setColor(cc.c3b(181, 196, 201))

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_1")

	self.rootpanel:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootpanel:setPosition(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2)
	audio_manager:playeffectMusic(PATROL_SUCCESS_EFFECT)

	self.updateUICallback = arg_3_1.updateUICallback

	self.surebtn:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)

			if arg_3_1.updateUICallback then
				arg_3_1.updateUICallback()

				arg_3_1.updateUICallback = nil
			end
		end)
	end)
	self:createFullScreenMask(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)

			if arg_3_1.updateUICallback then
				arg_3_1.updateUICallback()

				arg_3_1.updateUICallback = nil
			end
		end)
	end)
	self:initResultPanel(arg_3_1)
	self.showActions.extendVertical(self)
end

function PopPatrolResult:initTitleNameList(arg_8_1)
	self.scrollview = ccui.ScrollView:create()

	self.scrollview:setDirection(ccui.ScrollViewDir.horizontal)
	self.scrollview:setBounceEnabled(true)
	self.scrollview:setAnchorPoint(self.title_2:getAnchorPoint())
	self.scrollview:setPosition(self.title_2:getPosition())
	self.scrollview:setContentSize(cc.size(self.title_2:getContentSize().width > 400 and 400 or self.title_2:getContentSize().width, self.title_2:getContentSize().height))
	self.scrollview:setInnerContainerSize(self.title_2:getContentSize())
	self.title_2:getParent():addChild(self.scrollview)

	local var_8_0 = self.title_2:clone()

	var_8_0:setPosition(0, 0)
	self.scrollview:addChild(var_8_0)
	self.title_2:setVisible(false)

	if arg_8_1.isOneKey then
		var_8_0:removeFromParent()
		self.title_1:setVisible(false)
		self.title_2:setVisible(true)
		self.title_2:setString(string.format(L_PATROL_RESULT_1, arg_8_1.completeNum))
		self.title_2:setColor(cc.c3b(255, 242, 172))
	end
end

function PopPatrolResult:initResultPanel(arg_9_1)
	self.title_1:setString(L_PATROL_RESULT.Title_1 .. (arg_9_1.time or ""))
	self.title_2:setString(L_PATROL_RESULT.Title_2 .. arg_9_1.name)
	self.title_3:setString((global_trans_number(tonumber(arg_9_1.sp))))
	self.title_4:setString((global_trans_number(tonumber(arg_9_1.gold))))
	self:initPanelList(arg_9_1)
	self:initTitleNameList(arg_9_1)
end

function PopPatrolResult:initPanelList(arg_10_1)
	self:initFightGirl(arg_10_1)

	if not arg_10_1.items or next(arg_10_1.items) == nil then
		local var_10_0 = cc.Label:createWithTTF(L_PATROL_RESULT.Gain_Nil, FONT_TITLE, 40)

		var_10_0:setPosition(320, 520)
		self.bg:addChild(var_10_0)

		return
	end

	local var_10_1 = arg_10_1.items
	local var_10_2 = 0
	local var_10_3 = 0

	self.scrollView:setContentSize(cc.size(self.scrollView:getContentSize().width, self.scrollView:getContentSize().height + 70))

	local var_10_4 = self.scrollView:getContentSize()
	local var_10_5 = var_10_4.width / (60 + (var_0_11 + 20) * 4)
	local var_10_6 = (40 + math.ceil(#arg_10_1.items / 4) * (20 + var_0_12)) * (var_10_4.width / (60 + (var_0_11 + 20) * 4))

	if var_10_6 < var_10_4.height then
		var_10_6 = var_10_4.height
	end

	self.scrollView:setPositionY(self.scrollView:getPositionY() - 70)
	self.scrollView:setInnerContainerSize(cc.size(var_10_4.width, var_10_6))

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		local var_10_7
		local var_10_8

		if arg_10_1.createItemType == "itemid" then
			local var_10_9

			if iter_10_1.component_attr then
				var_10_9 = iter_10_1.component_attr
			elseif iter_10_1.weapon_attr then
				var_10_9 = iter_10_1.weapon_attr
			elseif iter_10_1.horcrux_attr then
				var_10_9 = iter_10_1.horcrux_attr
			end

			var_10_7 = ItemSprite:createNewWithItemId(iter_10_1.itemid, iter_10_1.itemcount, nil, nil, var_10_9)
			var_10_8 = iter_10_1.itemid
		else
			var_10_7 = ItemSprite:createBigWithEntityId(iter_10_1.entityid, iter_10_1.dropNum)
			var_10_8 = iter_10_1.dropid
		end

		var_10_7:setTouchEnabled(true)
		self:addListenerForSP(var_10_7, var_10_8, iter_10_1.entityid)
		var_10_7:setAnchorPoint(cc.p(0.5, 0.5))
		var_10_7:setScale(var_10_5)
		var_10_7:setPosition(cc.p((40 + var_0_11 / 2 + (var_0_11 + 20) * var_10_3) * var_10_5, var_10_6 - (20 + var_0_12 / 2 + (var_0_12 + 20) * var_10_2) * var_10_5))
		self.scrollView:addChild(var_10_7)

		var_10_3 = var_10_3 + 1

		if var_10_3 >= 4 then
			var_10_2 = var_10_2 + 1
			var_10_3 = 0
		end
	end
end

function PopPatrolResult:initFightGirl(arg_11_1)
	self.imge:loadTexture("role1/" .. model_data[global_get_servant_skin(arg_11_1.servantid)].cute_role .. ".png")
	self.imge:setScale(0.5)
	self.imge:setPositionX(self.imge:getPositionX() + 18)
	self.imge:setPositionY(self.imge:getPositionY() + 30)
end

function PopPatrolResult.addListenerForSP(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
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

function PopPatrolResult:exit()
	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)

		if self.updateUICallback then
			self.updateUICallback()

			self.updateUICallback = nil
		end
	end)
end
