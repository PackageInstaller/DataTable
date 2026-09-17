SignLayer = class("SignLayer", function()
	return cc.Layer:create()
end)

require("controller.global_func")
require("data.constants")
require("socket")
require("view.Layer.WeaponLayer")

local network = require("network.network")
local sign_data = require("data.sign_data")
local item_data = require("data.item_data")
local drop_data = require("data.drop_data")
local accumulated_sign_data = require("data.accumulated_sign_data")
local drop_manager = require("controller.drop_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local autopop_manager = require("controller.autopop_manager")
local sign_manager = require("controller.sign_manager")
local var_0_13 = 0
local var_0_14 = config._DEBUG and 0 or 1
local var_0_15 = "public/button/selected_tab_across_on.png"
local var_0_16 = "public/button/selected_tab_across_off.png"
local var_0_17 = cc.c4b(56, 122, 255, 150)
local var_0_18 = cc.c4b(255, 84, 0, 150)
local var_0_19 = "sign/jindutiao1.png"
local var_0_20 = 1
local var_0_21 = 0
local var_0_25
local var_0_26 = {
	isPlay = false,
	msg = {}
}

function SignLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = SignLayer.new()

	var_2_0:initBg(arg_2_1)
	var_2_0:setName("SignLayer")

	return var_2_0
end

function SignLayer:init(arg_3_1)
	sign_manager:setSign()

	var_0_25 = self

	local var_3_0

	self.exitCallback = nil

	if arg_3_1 then
		var_3_0 = arg_3_1.callback
		self.exitCallback = arg_3_1.exitCallback
	end

	local var_3_1 = arg_3_1.initpara

	self.Day = arg_3_1.initpara.day
	self.serverTime = var_3_1.serverTime
	self.SignLimit = var_3_1.signLimit
	self.statusTag = var_3_1.statusTag
	self.SignDay = var_3_1.day
	self.SignLastTime = var_3_1.signLastTime
	self.SignTask = var_3_1.signTask
	self.AccumulatedSign = var_3_1.accumulatedSign
	self.awardItems = var_3_1.items
	self.callback = var_3_1.callback
	var_0_26.msg = var_3_1.itemMessage
	self.serial_number = 1
	self.sign_tag = self.sign_tag or false
	self.midas_tag = self.sign_tag or false
	self.show_tag = self.show_tag or false
	self.sign_complete = self.sign_complete or false
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "sign.json" or "sign.ExportJson")

	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.rootLayer:setName("SignLayer")
	self.rootLayer:setTouchEnabled(true)
	self:addChild(self.rootLayer, 1)
	self:initUISrc()
	self:UIOrganize()
	global_window_open_action(self.image_bg)

	if not self.one_week_tag and not self.total_sign_tag then
		self.one_week_tag = false
		self.total_sign_tag = false
	end

	self.rootLayer:getChildByName("image_bg"):setTouchEnabled(true)
	self.image_sign_bg:setVisible(true)
	self.image_show_bg:setVisible(false)
	self.button_everyday_awards:setTouchEnabled(true)
	self:initAwards()

	if self.sign_complete == false then
		self:initAddUpAwards()
	end

	self:initTime()
	self:initButtonEvent()
	self:setSignStatus()

	self.sign_tag = true

	self.rootLayer:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.serial_number == 1 then
			global_window_close_action(self.image_bg, function()
				self.image_bg:stopAllActions()
				LayerManager:removePopLayer(self.__queueindex)
			end)
		elseif self.serial_number == 2 then
			self.button_everyday_awards:setTouchEnabled(true)
			self.image_sign_bg:setVisible(true)
			self.image_show_bg:setVisible(false)

			self.serial_number = 1
		end
	end)
	LayerManager:createFullScreenMask(self, 0, function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.serial_number == 1 then
			global_window_close_action(self.image_bg, function()
				self.image_bg:stopAllActions()
				LayerManager:removePopLayer(self.__queueindex)
			end)
		elseif self.serial_number == 2 then
			self.button_everyday_awards:setTouchEnabled(true)
			self.image_sign_bg:setVisible(true)
			self.image_show_bg:setVisible(false)

			self.serial_number = 1
		end
	end)
	self:registerScriptHandler(function(arg_8_0)
		if arg_8_0 == "exit" then
			if var_3_0 then
				var_3_0()
			end

			if var_0_26.msg ~= nil and var_0_26.isPlay ~= true then
				self:gainItemMsg(var_0_26.msg)
			end

			var_0_26.msg = nil
			var_0_26.isPlay = false
			var_0_25 = nil
			shared_midasLayer = nil

			print("excute signManager:resumeSign()!!!!!!!!!!!!!!!")
			sign_manager:resumeSign()
			autopop_manager:resumeAchievementPop()
		end
	end)
	self:fullScreen(self.rootLayer)
end

function SignLayer:initUISrc()
	self:initImage()
	self:initButton()
	self:initLabel()
	self:initListview()
	self:initPanel()
	self:initInfo()
	self:initOther()
end

function SignLayer:initImage()
	self.image_bg = ccui.Helper:seekWidgetByName(self.rootLayer, "image_bg")
	self.image_sign_bg = ccui.Helper:seekWidgetByName(self.rootLayer, "image_sign_bg")
	self.image_show_bg = ccui.Helper:seekWidgetByName(self.rootLayer, "image_show_bg")
end

function SignLayer:initButton()
	self.button_not = ccui.Helper:seekWidgetByName(self.rootLayer, "button_time")
	self.button_add_awards = ccui.Helper:seekWidgetByName(self.rootLayer, "button_add_awards")
	self.button_everyday_awards = ccui.Helper:seekWidgetByName(self.rootLayer, "button_everyday_awards")
	self.button_add = self.image_show_bg:getChildByName("button_add_award")
	self.button_day = self.image_show_bg:getChildByName("button_day_award")

	self.button_add:setPositionX(self.button_add:getPositionX() + 258)
	self.button_day:setPositionX(self.button_day:getPositionX() + 258)
	self.button_add_awards:getChildByName("label_button"):setString("More")
	self.button_everyday_awards:getChildByName("Label_66"):setString(L_SIGN_AWARD_DETAIL)
	self.button_everyday_awards:getChildByName("Label_66"):setFontSize(39)
end

function SignLayer:initLabel()
	self.label_tips = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_55")

	self.label_tips:setPositionX(self.label_tips:getPositionX() + 20)

	self.label_progress = ccui.Helper:seekWidgetByName(self.rootLayer, "label_progress")
	self.label_time = ccui.Helper:seekWidgetByName(self.image_sign_bg, "label_time")
end

function SignLayer:initListview()
	self.listview_one_week = ccui.Helper:seekWidgetByName(self.rootLayer, "listview_one_week")
	self.listview_total_sign = ccui.Helper:seekWidgetByName(self.rootLayer, "listview_total_sign")
end

function SignLayer:initPanel()
	self.panel_one_week = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_one_week")
	self.panel_total_sign = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_total_sign")

	self.panel_one_week:removeFromParent()
	self.panel_total_sign:removeFromParent()
	self.panel_one_week:retain()
	self.panel_total_sign:retain()
end

function SignLayer:initInfo()
	self.infobg = ccui.Helper:seekWidgetByName(self.rootLayer, "image_show_bg")
	self.infopanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_info")

	self.infobg:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.infobg:setVisible(false)
		self.button_add_awards:setTouchEnabled(true)
		self.button_everyday_awards:setTouchEnabled(true)
	end)
end

function SignLayer:initOther()
	self.more_award = ccui.Helper:seekWidgetByName(self.rootLayer, "image_item_bg")
	self.progress_bar_bg = ccui.Helper:seekWidgetByName(self.rootLayer, "progress_bar_bg")

	ccui.Helper:seekWidgetByName(self.rootLayer, "label_time_str"):setString(L_SIGN_NEXT_TIME)
	ccui.Helper:seekWidgetByName(self.rootLayer, "label_time_str"):setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "label_time_str"):getPositionX() - 10)
end

function SignLayer:UIOrganize()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_46"):setOpacity(0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_59"):setOpacity(0)

	for iter_18_0 = 1, 3 do
		local var_18_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "equip" .. iter_18_0)

		var_18_0:setPositionY(var_18_0:getPositionY() + 60)
	end

	if self.SignLimit <= 0 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "label_time_str"):setString(L_SIGN_TODAY_END)
		ccui.Helper:seekWidgetByName(self.rootLayer, "label_time_str"):setPositionX(-20)
		ccui.Helper:seekWidgetByName(self.image_sign_bg, "label_time"):setVisible(false)
	end

	self.getAllAward = self.AccumulatedSign >= accumulated_sign_data[#accumulated_sign_data].needs

	self.label_tips:setVisible(false)
	self.button_add_awards:setVisible(true)
end

function SignLayer:initButtonEvent()
	self.button_everyday_awards:setScale(1)
	self.button_everyday_awards:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.serial_number = 1

		self.image_show_bg:setVisible(true)
		self.button_everyday_awards:setTouchEnabled(false)
		self.button_add:loadTextures(var_0_16, var_0_16, var_0_16, var_0_14)
		self.button_day:loadTextures(var_0_15, var_0_15, var_0_15, var_0_14)
		self.button_add:setTouchEnabled(true)
		self.button_day:setTouchEnabled(false)
		self.label_tips:setVisible(false)

		if self.one_week_tag == false then
			self:showOneWeekAwards()
		elseif self.one_week_tag == true then
			self.listview_one_week:setVisible(true)
		end

		self.listview_total_sign:setVisible(false)
	end)
	self.button_add_awards:setScale(1)
	self.button_add_awards:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.serial_number = 1

		self.image_show_bg:setVisible(true)
		self.button_add_awards:setTouchEnabled(false)
		self.button_everyday_awards:setTouchEnabled(false)
		self.button_add:loadTextures(var_0_15, var_0_15, var_0_15, var_0_14)
		self.button_day:loadTextures(var_0_16, var_0_16, var_0_16, var_0_14)
		self.button_add:setTouchEnabled(false)
		self.button_day:setTouchEnabled(true)
		self.label_tips:setVisible(true)

		local var_21_0 = self.AccumulatedSign

		if self.statusTag.normal == true then
			var_21_0 = var_21_0 + 1
		end

		self.label_tips:setColor(cc.c3b(203, 219, 235))
		self.label_tips:getChildByName("Label_21"):setColor(cc.c3b(203, 219, 235))
		self.label_tips:getChildByName("leiji_sign_label"):setString("" .. var_21_0)
		self.label_tips:getChildByName("leiji_sign_label"):getVirtualRenderer():setBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)
		self.label_tips:getChildByName("Label_21"):setPositionX(self.label_tips:getChildByName("leiji_sign_label"):getPositionX() + self.label_tips:getChildByName("leiji_sign_label"):getContentSize().width - 10)

		if self.total_sign_tag == false then
			self:showTotalSignAwards()
		elseif self.total_sign_tag == true then
			self.listview_total_sign:setVisible(true)
		end

		self.listview_one_week:setVisible(false)
	end)
	self.button_day:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.serial_number = 2

		self.image_show_bg:setVisible(true)
		self.button_everyday_awards:setTouchEnabled(false)
		self.button_add:loadTextures(var_0_16, var_0_16, var_0_16, var_0_14)
		self.button_day:loadTextures(var_0_15, var_0_15, var_0_15, var_0_14)
		self.button_add:setTouchEnabled(true)
		self.button_day:setTouchEnabled(false)
		self.label_tips:setVisible(false)
		self:changeLabel(self.button_day)
		self:changeLabel(self.button_add)

		if self.one_week_tag == false then
			self:showOneWeekAwards()
		elseif self.one_week_tag == true then
			self.listview_one_week:setVisible(true)
		end

		self.listview_total_sign:setVisible(false)
	end)
	self.button_add:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.serial_number = 2

		self.image_show_bg:setVisible(true)
		self.button_everyday_awards:setTouchEnabled(false)
		self.button_add:loadTextures(var_0_15, var_0_15, var_0_15, var_0_14)
		self.button_day:loadTextures(var_0_16, var_0_16, var_0_16, var_0_14)
		self.button_add:setTouchEnabled(false)
		self.button_day:setTouchEnabled(true)
		self.label_tips:setVisible(false)
		self:changeLabel(self.button_day)
		self:changeLabel(self.button_add)

		if self.total_sign_tag == false then
			self:showTotalSignAwards()
		elseif self.total_sign_tag == true then
			self.listview_total_sign:setVisible(true)
		end

		self.listview_one_week:setVisible(false)
	end)
end

local function var_0_27(arg_24_0)
	local var_24_0

	if config._DEBUG then
		var_24_0 = cc.Sprite:create("sign/item_bg.png") or cc.Sprite:createWithSpriteFrameName("sign/item_bg.png")
	end

	var_24_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_24_0:setPosition(cc.p(arg_24_0:getContentSize().width / 2 - 2, arg_24_0:getContentSize().height / 2))
	arg_24_0:addChild(var_24_0)
end

function SignLayer:setSignStatus()
	local var_25_0 = {}
	local var_25_1 = {}

	for iter_25_0 = 1, 3 do
		var_25_0[iter_25_0] = ccui.Helper:seekWidgetByName(self.rootLayer, "equip" .. iter_25_0)
	end

	local var_25_2

	if self.statusTag.normal == true then
		var_25_2 = self.SignLimit + 1 or self.SignLimit

		if var_25_2 == 3 then
			return
		end
	end

	for iter_25_1 = 1, 3 - var_25_2 do
		if config._DEBUG then
			var_25_1[iter_25_1] = cc.Sprite:create("sign/fragment_tic_new.png") or cc.Sprite:createWithSpriteFrameName("sign/fragment_tic_new.png")
		end

		var_25_1[iter_25_1]:setAnchorPoint(cc.p(0.5, 0.5))
		var_25_1[iter_25_1]:setPosition(cc.p(var_25_0[iter_25_1]:getContentSize().width * 3 / 4 - 20, var_25_0[iter_25_1]:getContentSize().height / 4 + 10))
		var_25_0[iter_25_1]:addChild(var_25_1[iter_25_1], 10)
		var_0_27(var_25_0[iter_25_1])
	end
end

function SignLayer:showItemDetails(arg_26_1, arg_26_2)
	if arg_26_2 == "item" then
		if item_data[arg_26_1].bag_item_type == KITEM_HORCRUX then
			local var_26_1 = 1
			local var_26_2 = require("data.horcrux_data")[arg_26_1].horcruxtype

			for iter_26_0, iter_26_1 in pairs((require("data.photofile_HelpGirl_data"))) do
				if arg_26_1 == iter_26_1.Item_id then
					var_26_1 = iter_26_0

					break
				end
			end

			if var_26_1 == -1 then
				print("did not find id")

				return
			end

			require("view.Layer.DetailsofHelpGirlLayer")
			LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
				id = var_26_1,
				itemid = arg_26_1,
				callback = callback
			})
		elseif item_data[arg_26_1].bag_item_type == KITEM_HERO then
			require("view.Layer.EquipLayer")
			LayerManager:pushInLayer("SoulsLayer", {
				showButtonList = true,
				layertype = "DropDetailsLayer",
				showtype = 6,
				cursoul = item_data[arg_26_1].servant,
				exitCallback = callback
			})
		elseif not self:getChildByName("OTHER_LAYER") then
			local var_26_3 = PopLayer:Item({
				hideGainButton = true,
				itemid = arg_26_1
			})
		end
	elseif arg_26_2 == "gold" then
		-- block empty
	elseif arg_26_2 == "diamond" then
		-- block empty
	end
end

function SignLayer:initAwards()
	if not signlayerinstance then
		-- block empty
	end

	local var_27_0 = {}

	for iter_27_0 = 1, 3 do
		local var_27_1
		local var_27_2 = self.awardItems[iter_27_0].itemid

		var_27_0[iter_27_0] = ccui.Helper:seekWidgetByName(self.rootLayer, "equip" .. iter_27_0)
		var_27_1 = self.awardItems[iter_27_0].itemid == 0 and ItemSprite:createNewWithItemId("diamond", self.awardItems[iter_27_0].itemnum, nil, nil, nil) or self.awardItems[iter_27_0].itemid == 1 and ItemSprite:createNewWithItemId("gold", self.awardItems[iter_27_0].itemnum) or ItemSprite:createNewWithItemId(item_data[self.awardItems[iter_27_0].itemid].id, self.awardItems[iter_27_0].itemnum, nil, nil, nil)

		var_27_1:setPosition(cc.p(85, 114))
		var_27_1:setTouchEnabled(false)
		var_27_0[iter_27_0]:addChild(var_27_1)
		var_27_0[iter_27_0]:setScale(0.8)
		var_27_0[iter_27_0]:addTouchEventListener(function(arg_28_0, arg_28_1)
			if arg_28_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_28_0
			local var_28_2

			if var_27_2 == 0 then
				var_28_0 = var_27_2
				var_28_2 = "diamond"
			elseif var_27_2 == 1 then
				var_28_0 = var_27_2
				var_28_2 = "gold"
			else
				var_28_0 = item_data[var_27_2].id
				var_28_2 = "item"
			end

			self:showItemDetails(var_28_0, var_28_2)
		end)
	end
end

function SignLayer:initTime()
	labelTime = self.label_time

	labelTime:setVisible(false)

	local var_29_0 = 0

	if not var_0_25 then
		return
	end

	if self.signLimit == 0 then
		var_29_0 = 86400 - tonumber((os.date("%H", self.serverTime))) * 3600 + tonumber((os.date("%M", self.serverTime))) * 60 + tonumber((os.date("%S", self.serverTime)))
	else
		var_29_0 = self.SignLastTime + 10800 - self.serverTime

		if self.SignLastTime + 10800 - self.serverTime < 0 then
			var_29_0 = 10799
		end
	end

	labelTime:setString(string.format("%02d:%02d:%02d", math.floor(var_29_0 / 3600), math.floor(var_29_0 % 3600 / 60), (math.floor(var_29_0 % 3600 % 60))))

	if self.SignLimit <= 0 then
		labelTime:setVisible(false)
	else
		labelTime:setVisible(true)
		schedule(labelTime, function()
			var_29_0 = var_29_0 - 1

			if var_29_0 < 0 then
				labelTime:setVisible(true)
			else
				labelTime:setVisible(true)
				labelTime:setString(string.format("%02d:%02d:%02d", math.floor(var_29_0 / 3600), math.floor(var_29_0 % 3600 / 60), (math.floor(var_29_0 % 3600 % 60))))
			end
		end, 1)
	end

	self:Signbuttoncallback()
end

function SignLayer:Signbuttoncallback()
	if self.statusTag.normal == true then
		AnalyticManager.daily_sign_success({
			accumalatetimes = self.SignTask,
			daily_times = 3 - self.SignLimit
		})
	end

	local function var_31_0()
		local var_32_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "equip" .. 3 - self.SignLimit)
		local var_32_3

		if config._DEBUG then
			var_32_3 = cc.Sprite:create("sign/item_bg.png") or cc.Sprite:createWithSpriteFrameName("sign/item_bg.png")
		end

		var_32_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_32_3:setPosition(cc.p(var_32_2:getContentSize().width / 2 - 2, var_32_2:getContentSize().height / 2))
		var_32_2:addChild(var_32_3)

		local var_32_4 = 20

		audio_manager:playeffectMusic(SIGN_GET_AWARDS_EFFECT)

		local var_32_5

		if config._DEBUG then
			var_32_5 = cc.Sprite:create("sign/fragment_tic_new.png") or cc.Sprite:createWithSpriteFrameName("sign/fragment_tic_new.png")
		end

		var_32_5:setScale(5)
		var_32_5:setAnchorPoint(cc.p(0.5, 0.5))
		var_32_5:setPosition(cc.p(var_32_2:getContentSize().width * 3 / 4 - var_32_4, var_32_2:getContentSize().height / 4 + 10))
		var_32_2:addChild(var_32_5, 10)
		var_32_5:runAction(cc.Sequence:create(cc.ScaleTo:create(0.5, 1), cc.CallFunc:create(function()
			if accumulated_sign_data[self.SignTask + 1] then
				self.progress_bar:setPercentage((self.AccumulatedSign + 1) / accumulated_sign_data[self.SignTask + 1].needs * 100)
				self.label_progress:setString(string.format(L_SIGN_REST, (accumulated_sign_data[self.SignTask + 1].needs - (self.AccumulatedSign + 1) < 0 and accumulated_sign_data[self.SignTask + 2] or nil) and accumulated_sign_data[self.SignTask + 2].needs - (self.AccumulatedSign + 1)) .. self.awardname)
			end
		end)))
	end

	local function var_31_1()
		local var_34_3 = self.more_award
		local var_34_4 = ccui.Helper:seekWidgetByName(self.rootLayer, "image_count_award")

		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_zhezhao"):setVisible(true)

		local var_34_5 = 15

		audio_manager:playeffectMusic(SIGN_GET_AWARDS_EFFECT)

		local var_34_6

		if config._DEBUG then
			var_34_6 = cc.Sprite:create("sign/fragment_tic_new.png") or cc.Sprite:createWithSpriteFrameName("sign/fragment_tic_new.png")
		end

		var_34_6:setScale(5)
		var_34_6:setName("gainPanel")
		var_34_6:setAnchorPoint(cc.p(0.5, 0.5))
		var_34_6:setPosition(cc.p(var_34_3:getContentSize().width * 3 / 4 - var_34_5 - 245, var_34_3:getContentSize().height / 4 + 18))
		var_34_4:addChild(var_34_6, 10)
		var_34_6:runAction(cc.Sequence:create(cc.ScaleTo:create(0.5, 0.8), cc.CallFunc:create(function()
			self.progress_bar:setPercentage(100)
			self.label_progress:setString(" ")

			if not accumulated_sign_data[self.SignTask + 2] then
				self.label_progress:setString(L_SIGN_TOTAL_END)
			end
		end)))
	end

	if not var_0_25 then
		return
	end

	self:runAction((cc.Sequence:create(cc.CallFunc:create(function()
		if self.statusTag.normal == true then
			var_31_0()
		end
	end), cc.DelayTime:create(0.6), cc.CallFunc:create(function()
		if self.statusTag.accumulated == true then
			var_31_1()
		end
	end), cc.DelayTime:create(0.3), cc.CallFunc:create(function()
		if var_0_26.msg ~= nil then
			self:gainItemMsg(var_0_26.msg)
		end
	end))))
end

function SignLayer:initAddUpAwards()
	if self.sign_complete == true then
		return
	end

	local var_39_0 = self.SignTask

	if not accumulated_sign_data[self.SignTask + 1] then
		var_39_0 = #accumulated_sign_data - 1
	end

	local var_39_1 = self.AccumulatedSign
	local var_39_4, var_39_5, var_39_6 = self:addUpItemCheck(var_39_0 + 1)

	self:setAwardName(var_39_4, var_39_0 + 1)
	self:drawAddUppIcon(nil)
	self:addUpText(var_39_0, var_39_1, accumulated_sign_data[var_39_0 + 1].needs)
	self:addUpProgressBar(var_39_1, accumulated_sign_data[var_39_0 + 1].needs)
	self.more_award:addTouchEventListener(function(arg_40_0, arg_40_1)
		if arg_40_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_40_0
		local var_40_2

		if var_39_4 ~= "diamond" then
			var_40_0 = item_data[var_39_4].id
			var_40_2 = "item"
		else
			var_40_0 = var_39_4
			var_40_2 = "diamond"
		end

		self:showItemDetails(var_40_0, var_40_2)
	end)
end

function SignLayer.addUpItemCheck(arg_41_0, arg_41_1)
	local var_41_0
	local var_41_1
	local var_41_2

	if drop_data[accumulated_sign_data[arg_41_1].dropid].drop_id1 then
		var_41_0 = drop_data[accumulated_sign_data[arg_41_1].dropid].drop_id1
		var_41_1 = drop_data[accumulated_sign_data[arg_41_1].dropid].drop_num1 or 1

		local var_41_3 = drop_data[accumulated_sign_data[arg_41_1].dropid].drop_extra1 or nil

		var_41_2 = var_41_0 ~= 0 and ItemSprite:createNewWithItemId(item_data[var_41_0].id, var_41_1, nil, nil, var_41_3) or ItemSprite:createNewWithItemId("diamond", var_41_1, nil, nil, var_41_3)
	elseif drop_data[accumulated_sign_data[arg_41_1].dropid].gold then
		var_41_0 = "gold"
		var_41_1 = drop_data[accumulated_sign_data[arg_41_1].dropid].gold
		var_41_2 = ItemSprite:createNewWithItemId("gold", drop_data[accumulated_sign_data[arg_41_1].dropid].gold, nil, nil, nil)
	elseif drop_data[accumulated_sign_data[arg_41_1].dropid].diamond then
		var_41_0 = "diamond"
		var_41_1 = drop_data[accumulated_sign_data[arg_41_1].dropid].diamond
		var_41_2 = ItemSprite:createNewWithItemId("diamond", drop_data[accumulated_sign_data[arg_41_1].dropid].diamond, nil, nil, nil)
	end

	return var_41_0, var_41_1, var_41_2
end

function SignLayer.setAwardName(arg_42_0, arg_42_1, arg_42_2)
	arg_42_0.awardname = ""

	if drop_data[accumulated_sign_data[arg_42_2].dropid].drop_id1 then
		arg_42_0.awardname = arg_42_1 ~= 0 and item_data[arg_42_1].name or L_DIAMOND
	elseif drop_data[accumulated_sign_data[arg_42_2].dropid].gold then
		arg_42_0.awardname = L_GOLD
	elseif drop_data[accumulated_sign_data[arg_42_2].dropid].diamond then
		arg_42_0.awardname = L_DIAMOND
	end
end

function SignLayer:drawAddUppIcon(arg_43_1)
	arg_43_1:setScale(0.8)
	arg_43_1:setPosition(cc.p(70, 95))
	self.more_award:addChild(arg_43_1)
	self.more_award:setTouchEnabled(true)

	if self.getAllAward then
		local var_43_0 = self.more_award
		local var_43_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "image_count_award")

		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_zhezhao"):setVisible(true)

		local var_43_2

		if config._DEBUG then
			var_43_2 = cc.Sprite:create("sign/fragment_tic_new.png") or cc.Sprite:createWithSpriteFrameName("sign/fragment_tic_new.png")
		end

		var_43_2:setScale(0.8)
		var_43_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_43_2:setPosition(cc.p(var_43_0:getContentSize().width * 3 / 4 - 260, var_43_0:getContentSize().height / 4 + 18))
		var_43_1:addChild(var_43_2, 10)
	end
end

function SignLayer:addUpText(arg_44_1, arg_44_2, arg_44_3)
	local var_44_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "label_progress")
	local var_44_1 = arg_44_3 - arg_44_2

	if arg_44_3 - arg_44_2 < 0 and accumulated_sign_data[arg_44_1 + 2] then
		var_44_1 = accumulated_sign_data[arg_44_1 + 2].needs - arg_44_2
	end

	if self.getAllAward then
		var_44_0:setString(L_SIGN_TOTAL_END)
	else
		var_44_0:setString(string.format(L_SIGN_REST, var_44_1) .. self.awardname)
	end
end

function SignLayer:addUpProgressBar(arg_45_1, arg_45_2)
	local var_45_0 = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create(var_0_19) or cc.Sprite:createWithSpriteFrameName(var_0_19)))

	var_45_0:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	var_45_0:setBarChangeRate(cc.p(1, 0))
	var_45_0:setMidpoint(cc.p(0, 0))
	var_45_0:setAnchorPoint(cc.p(0, 0.5))
	var_45_0:setPosition(cc.p(0, 13))
	self.progress_bar_bg:addChild(var_45_0)

	self.progress_bar = var_45_0

	var_45_0:setPercentage(arg_45_1 / arg_45_2 * 100)
end

function SignLayer:showOneWeekAwards()
	self.listview_one_week:setVisible(true)
	self.listview_one_week:setTouchEnabled(true)
	self.listview_total_sign:setVisible(false)
	self.listview_total_sign:setTouchEnabled(false)

	local var_46_0 = {}

	var_0_13 = tonumber(self.SignDay)

	for iter_46_0 = 1, 7 do
		var_46_0[iter_46_0] = self.panel_one_week:clone()

		var_46_0[iter_46_0]:setVisible(true)

		local var_46_1, var_46_2, var_46_3 = string.match(os.date("%x", os.time() + 86400 * (iter_46_0 - 1)), "(%d+)/(%d+)/(%d+)")

		var_46_0[iter_46_0]:getChildByName("image_one_week_bg"):getChildByName("label_date"):setString(string.format(L_DATE_TEXT, tostring(var_46_1), tostring(var_46_2)))
		self:drawOneWeekAwards(var_0_13 + iter_46_0 - 1, var_46_0[iter_46_0])
		self.listview_one_week:pushBackCustomItem(var_46_0[iter_46_0])
	end

	self.one_week_tag = true
end

function SignLayer:drawOneWeekAwards(arg_47_1, arg_47_2)
	local var_47_0 = {
		"firsttime",
		"secondtime",
		"thirdtime"
	}
	local var_47_1 = {
		"firstnum",
		"secondnum",
		"thirdnum"
	}
	local var_47_2 = {}

	for iter_47_0 = 1, 3 do
		var_47_2[iter_47_0] = arg_47_2:getChildByName("image_one_week_bg"):getChildByName("equip" .. tostring(iter_47_0))

		local var_47_3 = sign_data[arg_47_1][var_47_0[iter_47_0]]
		local var_47_4 = sign_data[arg_47_1][var_47_0[iter_47_0]] == 0 and ItemSprite:createNewWithItemId("diamond", sign_data[arg_47_1][var_47_1[iter_47_0]], nil, nil, nil) or sign_data[arg_47_1][var_47_0[iter_47_0]] == 1 and ItemSprite:createNewWithItemId("gold", sign_data[arg_47_1][var_47_1[iter_47_0]], nil, nil, nil) or ItemSprite:createNewWithItemId(item_data[sign_data[arg_47_1][var_47_0[iter_47_0]]].id, sign_data[arg_47_1][var_47_1[iter_47_0]], nil, nil, nil)

		var_47_4:setPosition(cc.p(85, 114))
		var_47_2[iter_47_0]:addChild(var_47_4)
		var_47_2[iter_47_0]:setOpacity(0)
		var_47_2[iter_47_0]:setCascadeOpacityEnabled(false)

		if arg_47_1 == tonumber(self.SignDay) and iter_47_0 <= 3 - self.SignLimit then
			var_0_27(var_47_2[iter_47_0])

			local var_47_5

			if config._DEBUG then
				var_47_5 = cc.Sprite:create("sign/fragment_tic_new.png") or cc.Sprite:createWithSpriteFrameName("sign/fragment_tic_new.png")
			end

			var_47_5:setAnchorPoint(cc.p(0.5, 0.5))
			var_47_5:setPosition(cc.p(var_47_2[1]:getContentSize().width * 3 / 4 - 20, var_47_2[1]:getContentSize().height / 4 + 10))
			var_47_2[iter_47_0]:addChild(var_47_5, 10)
		end

		var_47_2[iter_47_0]:addTouchEventListener(function(arg_48_0, arg_48_1)
			if arg_48_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_48_0
			local var_48_2

			if var_47_3 == 0 then
				var_48_0 = var_47_3
				var_48_2 = "diamond"
			elseif var_47_3 == 1 then
				var_48_0 = var_47_3
				var_48_2 = "gold"
			else
				var_48_0 = item_data[var_47_3].id
				var_48_2 = "item"
			end

			self:showItemDetails(var_48_0, var_48_2)
		end)
	end
end

function SignLayer:showTotalSignAwards()
	self.listview_one_week:setVisible(false)
	self.listview_one_week:setTouchEnabled(false)
	self.listview_total_sign:setVisible(true)
	self.listview_total_sign:setTouchEnabled(true)

	if self.statusTag.accumulated == true then
		self.SignTask = self.SignTask + 1
	end

	for iter_49_0 = 1, #accumulated_sign_data do
		local var_49_0 = self.panel_total_sign:clone()

		var_49_0:setVisible(true)

		local var_49_1 = var_49_0:getChildByName("image_total_sign_bg")
		local var_49_2 = var_49_1:getChildByName("panel_time"):getChildByName("label_days")
		local var_49_3 = var_49_0:getChildByName("image_total_sign_bg"):getChildByName("label_total_1")
		local var_49_4 = var_49_0:getChildByName("image_total_sign_bg"):getChildByName("label_total_2")

		var_49_3.setFontSize(var_49_1, 19)
		var_49_3:setColor(cc.c3b(203, 219, 235))
		var_49_4:setFontSize(19)
		var_49_4:setColor(cc.c3b(203, 219, 235))
		var_49_4:setString(L_SIGN_TOTAL_REST)
		var_49_2:setString(accumulated_sign_data[iter_49_0].needs)
		var_49_2:getVirtualRenderer():setBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)

		local var_49_5 = var_49_0:getChildByName("image_total_sign_bg"):getChildByName("equip")
		local var_49_8, var_49_9, var_49_10 = self:addUpItemCheck(iter_49_0)

		var_49_10:setPosition(cc.p(85, 114))
		var_49_5:setOpacity(0)
		var_49_5:setCascadeOpacityEnabled(false)
		var_49_5:addChild(nil)
		self:drawTotalSignShade(var_49_0, iter_49_0)
		var_49_5:addTouchEventListener(function(arg_50_0, arg_50_1)
			if arg_50_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_50_0
			local var_50_2

			if var_49_8 ~= "diamond" then
				var_50_0 = item_data[var_49_8].id
				var_50_2 = "item"
			else
				var_50_0 = var_49_8
				var_50_2 = "diamond"
			end

			print("item_type = ", var_50_2)
			self:showItemDetails(var_50_0, var_50_2)
		end)
		self.listview_total_sign:pushBackCustomItem(var_49_0)
	end

	self.total_sign_tag = true
end

function SignLayer:drawTotalSignShade(arg_51_1, arg_51_2)
	local var_51_0 = arg_51_1:getChildByName("image_total_sign_bg"):getChildByName("equip")

	if arg_51_2 <= self.SignTask then
		var_0_27(var_51_0)

		local var_51_1

		if config._DEBUG then
			var_51_1 = cc.Sprite:create("sign/fragment_tic_new.png") or cc.Sprite:createWithSpriteFrameName("sign/fragment_tic_new.png")
		end

		var_51_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_51_1:setPosition(cc.p(var_51_0:getContentSize().width * 3 / 4 - 20, var_51_0:getContentSize().height / 4 + 10))
		var_51_1:setName("issuccess")
		var_51_0:addChild(var_51_1, 10)
	end
end

function SignLayer.createLabel(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	local var_52_0 = cc.Label:createWithTTF(arg_52_2, FONT_NAME, 30)

	var_52_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_52_0:setPosition(cc.p(arg_52_1:getContentSize().width / 2, arg_52_1:getContentSize().height / 2 + 5))
	var_52_0:setName("label")

	var_52_0.status = arg_52_3 or var_0_21

	if arg_52_3 == var_0_20 then
		var_52_0:enableOutline(var_0_18, 1)
		var_52_0:enableShadow(var_0_18, cc.size(0, 0))
	else
		var_52_0:enableOutline(var_0_17, 1)
		var_52_0:enableShadow(var_0_17, cc.size(0, 0))
	end

	arg_52_1:addChild(var_52_0)
end

function SignLayer.changeLabel(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_1:getChildByName("label")

	if var_53_0 then
		if var_53_0.status == var_0_20 then
			var_53_0:enableOutline(var_0_17, 1)
			var_53_0:enableShadow(var_0_17, cc.size(0, 0))

			var_53_0.status = var_0_21
		else
			var_53_0:enableOutline(var_0_18, 1)
			var_53_0:enableShadow(var_0_18, cc.size(0, 0))

			var_53_0.status = var_0_20
		end
	else
		print("error, label not exist")
	end
end

function SignLayer:fullScreen(arg_54_1)
	local var_54_0 = GameDisplay.getScreenSize()

	arg_54_1:setContentSize(var_54_0)
	arg_54_1:setPositionY(arg_54_1:getPositionY() - GameDisplay.fix_y)
	self.infobg:setContentSize(var_54_0)
	self.infopanel:setPositionY(self.infopanel:getPositionY() + GameDisplay.fix_y)
	arg_54_1:getChildByName("image_bg"):setPositionY(arg_54_1:getChildByName("image_bg"):getPositionY() + GameDisplay.fix_y)
end

function SignLayer:initBg(arg_55_1)
	local var_55_0 = ccui.Layout:create()

	var_55_0:setTouchEnabled(true)
	var_55_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_55_0:setAnchorPoint(cc.p(0, 0))
	var_55_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_55_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_55_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_55_0:setOpacity(0)
	self:addChild(var_55_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_56_0)
		self:addChild(arg_56_0, -2)
		arg_56_0:setPositionY(arg_56_0:getPositionY() - GameDisplay.fix_y)

		local var_56_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_56_0:setAnchorPoint(cc.p(0, 0))
		var_56_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_56_0, -1)
		self:init(arg_55_1)
		var_55_0:setOpacity(102)
		var_55_0:setTouchEnabled(false)
	end)
end

function SignLayer.getItemMsg(arg_57_0, arg_57_1, arg_57_2)
	local playermodel = require("model.playermodel")
	local item_manager = require("controller.item_manager")
	local var_57_2 = 0
	local var_57_3 = 0
	local var_57_4 = {}

	if arg_57_1.gold and checkint(arg_57_1.gold) ~= 0 then
		var_57_2 = checkint(arg_57_1.gold)
	end

	if arg_57_1.diamond and arg_57_1.diamond ~= 0 then
		var_57_3 = arg_57_1.diamond
	end

	if arg_57_1.items then
		print("??????????", dump(arg_57_1.items))

		for iter_57_0, iter_57_1 in pairs(arg_57_1.items) do
			if iter_57_1.addNumber > 0 then
				var_57_4[#var_57_4 + 1] = {
					dropid = iter_57_1.itemid,
					dropNum = iter_57_1.addNumber,
					entityid = iter_57_1.entityid
				}
			end
		end
	end

	if arg_57_1.surecallback then
		surecallback = arg_57_1.surecallback
	end

	local function var_57_5()
		print("$$$$退出", arg_57_2.SignTask)

		if arg_57_2.statusTag and arg_57_2.statusTag.accumulated then
			arg_57_2:updateAddUpAwards()
		end
	end

	global_update_gold_stone_diamond(arg_57_1.gold, arg_57_1.stone, arg_57_1.diamond)

	return var_57_2, var_57_3, var_57_4, var_57_5
end

function SignLayer.gainItemMsg(arg_59_0, arg_59_1)
	var_0_26.isPlay = true

	local var_59_0, var_59_1, var_59_2, var_59_3 = SignLayer:getItemMsg(arg_59_1, arg_59_0)

	print("##########", dump(arg_59_0))

	local var_59_4 = {
		gold = var_59_0,
		diamond = var_59_1,
		items = var_59_2,
		surecallback = surecallback,
		cancelcallback = var_59_3
	}

	print("###popmsg", dump(var_59_4))
	LayerManager:pushInLayer("PopPurchaseResultLayer", var_59_4)
end

function SignLayer:updateAddUpAwards()
	if self.sign_complete == true then
		return
	end

	self.more_award:removeAllChildren()
	self.progress_bar_bg:removeAllChildren()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_zhezhao"):setVisible(false)

	local var_60_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "image_count_award")

	var_60_0:removeChild(var_60_0:getChildByName("gainPanel"), true)

	if not accumulated_sign_data[self.SignTask + 1 + 1] then
		return
	end

	local var_60_1 = self.AccumulatedSign + 1
	local var_60_4, var_60_5, var_60_6 = self:addUpItemCheck(self.SignTask + 1 + 1)

	self:setAwardName(var_60_4, self.SignTask + 1 + 1)
	self:drawAddUppIcon(nil)
	self:addUpText(self.SignTask + 1, var_60_1, accumulated_sign_data[self.SignTask + 1 + 1].needs)
	self:addUpProgressBar(var_60_1, accumulated_sign_data[self.SignTask + 1 + 1].needs)
	self.more_award:addTouchEventListener(function(arg_61_0, arg_61_1)
		if arg_61_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_61_0
		local var_61_2

		if var_60_4 ~= "diamond" then
			var_61_0 = item_data[var_60_4].id
			var_61_2 = "item"
		else
			var_61_0 = var_60_4
			var_61_2 = "diamond"
		end

		self:showItemDetails(var_61_0, var_61_2)
	end)
end

function SignLayer:updateTime()
	labelTime = self.label_time

	labelTime:setVisible(false)

	local var_62_0 = 10800

	labelTime:setString(string.format("%02d:%02d:%02d", math.floor(10800 / 3600), math.floor(10800 % 3600 / 60), (math.floor(10800 % 3600 % 60))))

	if self.SignLimit <= 0 or self.SignLimit == 1 and self.statusTag.normal == true then
		labelTime:setVisible(false)
	else
		labelTime:setVisible(true)
		schedule(labelTime, function()
			var_62_0 = var_62_0 - 1

			if var_62_0 < 0 then
				labelTime:setVisible(true)
			else
				labelTime:setVisible(true)
				labelTime:setString(string.format("%02d:%02d:%02d", math.floor(var_62_0 / 3600), math.floor(var_62_0 % 3600 / 60), (math.floor(var_62_0 % 3600 % 60))))
			end
		end, 1)
	end
end

function SignLayer:exit()
	print("@@@@@@@@@@@@@exit@@@@@@@@@@@")

	if self.serial_number == 1 then
		global_window_close_action(self.image_bg, function()
			self.image_bg:stopAllActions()
			LayerManager:removePopLayer()
		end)
	elseif self.serial_number == 2 then
		self.button_everyday_awards:setTouchEnabled(true)
		self.image_sign_bg:setVisible(true)
		self.image_show_bg:setVisible(false)

		self.serial_number = 1
	end
end
