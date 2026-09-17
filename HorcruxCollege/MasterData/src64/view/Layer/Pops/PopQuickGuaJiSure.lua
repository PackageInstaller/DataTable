PopQuickGuaJiSure = class("PopQuickGuaJiSure", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Layer.PopLayer")

local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local dropcache_manager = require("controller.dropcache_manager")
local level_manager = require("controller.level_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local model_data = require("data.model_data")
local var_0_8 = 1
local var_0_9 = 3
local var_0_10 = 174
local var_0_11 = 228

local function var_0_12(arg_2_0)
	if arg_2_0 >= 86400 then
		return string.format(L_TIME_FORMAT_DAYHOURMIN, math.floor(arg_2_0 / 86400), math.floor(arg_2_0 % 86400 / 3600), math.floor(arg_2_0 % 3600 / 60))
	elseif arg_2_0 >= 3600 then
		return string.format(L_TIME_FORMAT_HOURMINSEC, math.floor(arg_2_0 / 3600), math.floor(arg_2_0 % 3600 / 60), arg_2_0 % 60)
	else
		return string.format(L_TIME_FORMAT_HOURMIN, math.floor(arg_2_0 / 60), math.floor(arg_2_0 % 60))
	end
end

function PopQuickGuaJiSure.create(arg_3_0)
	local var_3_0 = PopQuickGuaJiSure.new()

	var_3_0:init()

	return var_3_0
end

function PopQuickGuaJiSure:init()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "quick_guaji_sure.json" or "quick_guaji_sure.ExportJson")

	self.rootLayer:setPositionY(self.rootLayer:getPositionY() - GameDisplay.fix_y)
	self:addChild(self.rootLayer, 2)

	self.rootpanel = self.rootLayer
	self.quickGuajiType = var_0_8

	self:initUI()
	self:updateUI()
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		self:updateGuidesOnLayer()
	end)))
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			-- block empty
		end
	end)
end

function PopQuickGuaJiSure:initUI()
	self:initBG()
	self:initTitle()
	self:initItemView()
	self:initCostPanel()
	self.showActions.extendVertical(self)
end

function PopQuickGuaJiSure:initBG()
	self:setPosition(cc.p(GameDisplay.fix_x, GameDisplay.fix_y))

	local var_8_0 = cc.LayerColor:create(cc.c4b(10, 10, 10, 0), GameDisplay.width, GameDisplay.height)

	var_8_0:setPosition(cc.p(-GameDisplay.fix_x, -GameDisplay.fix_y * 2))
	self:addChild(var_8_0, 0)

	local var_8_1 = ccui.Layout:create()

	var_8_1:setPosition(-GameDisplay.fix_x, -GameDisplay.fix_y * 2)
	var_8_1:setContentSize(GameDisplay.width, GameDisplay.height)
	var_8_1:setTouchEnabled(true)
	var_8_1:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)
	self:addChild(var_8_1, 0)
	var_8_0:runAction(cc.Sequence:create(cc.FadeIn:create(0.2), cc.EaseOut:create(cc.FadeTo:create(2, 200), 2)))
end

function PopQuickGuaJiSure:initTitle()
	self.titleTime = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_4")

	self.titleTime:setString(string.format(L_FIGHT_RESULT_TITLE.Hangup_Title[1], var_0_12(7200)))

	local var_10_0, var_10_1 = playermodel.curLevel:match("(%d+)-(%d+)")

	self.titleLevel = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_5")

	self.titleLevel:setString(L_FIGHT_RESULT_TITLE.Hangup_Title[2] .. ": " .. level_manager:getChapterName(playermodel.curMode, (tonumber(var_10_0))))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_6"):setString(L_FIGHT_RESULT_TITLE.Hangup_Title[4])
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_17"):setString(L_FIGHT_RESULT_TITLE.Hangup_Title[4])
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_20"):setString(L_FIGHT_RESULT_TITLE.Hangup_Title[5])

	local var_10_2 = tostring(self:getShowRole())

	self.roleIcon = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_15")

	self.roleIcon:setScale(0.4)

	if var_10_2 then
		self.roleIcon:loadTexture("role1/" .. model_data[var_10_2].cute_role .. ".png")
	else
		self.roleIcon:setVisible(false)
	end

	self.titleSp = ccui.Helper:seekWidgetByName(self.rootLayer, "BitmapLabel_8")

	self.titleSp:setString(global_trans_number(0))

	self.titleGold = ccui.Helper:seekWidgetByName(self.rootLayer, "BitmapLabel_10")

	self.titleGold:setString(global_trans_number(0))
end

function PopQuickGuaJiSure:initItemView()
	self.scrollView = ccui.Helper:seekWidgetByName(self.rootLayer, "ScrollView_12")
end

function PopQuickGuaJiSure:initCostPanel()
	self.panelsmall = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_18")
	self.panelbig = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_19")
	self.surebtn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_13")

	self.surebtn:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.isRunAction then
			return
		end

		self.isRunAction = true

		self:quickFight()
	end)

	self.chooseBtnSmall = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_23")
	self.chooseBtnBig = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_24")

	self.chooseBtnSmall:setTouchEnabled(true)
	self.chooseBtnSmall:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.quickGuajiType == var_0_8 then
			return
		end

		self.quickGuajiType = var_0_8

		self:updateUI()
	end)
	self.chooseBtnBig:setTouchEnabled(true)
	self.chooseBtnBig:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.quickGuajiType == var_0_9 then
			return
		end

		self.quickGuajiType = var_0_9

		self:updateUI()
	end)

	local var_12_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_27")
	local var_12_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_28")

	var_12_0:loadTexture("equipment/6800301.png")
	var_12_1:loadTexture("equipment/6800302.png")
	var_12_0:setTouchEnabled(true)
	var_12_0:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_16_0 = PopLayer:Item({
			itemid = 9999999,
			hideGainButton = false
		})
	end)
	var_12_1:setTouchEnabled(true)
	var_12_1:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_17_0 = PopLayer:Item({
			itemid = 9999998,
			hideGainButton = false
		})
	end)

	self.numSmall = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_31")
	self.numBig = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_32")
	self.lessTimeNum = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_33")
end

function PopQuickGuaJiSure.getShowRole(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(playermodel.arrays) do
		for iter_18_2 = 1, FORMATION_SHOW_GIRL_NUM do
			if iter_18_1["pos_" .. iter_18_2].fight_girl then
				return iter_18_1["pos_" .. iter_18_2].fight_girl
			end
		end
	end

	return nil
end

function PopQuickGuaJiSure.updateUI(arg_19_0)
	level_manager:getQuickFightTime(function(arg_20_0)
		if tolua.isnull(arg_19_0.rootLayer) then
			return
		end

		arg_19_0.timeData = arg_20_0

		arg_19_0:upDateTitle()
		arg_19_0:updateItems()
		arg_19_0:updateCostPanel()
	end)
end

function PopQuickGuaJiSure:upDateTitle()
	local var_21_0 = self.quickGuajiType == var_0_8 and 7200 or 36000

	self.titleTime:setString(L_FIGHT_RESULT_TITLE.Hangup_Title[1] .. ":" .. var_0_12(self.quickGuajiType == var_0_8 and 7200 or 36000))
	self.titleSp:setString(global_trans_bitmapnumber(math.floor(self.timeData.sp * var_21_0 / 10)))
	self.titleGold:setString(global_trans_bitmapnumber(math.floor(self.timeData.gold * var_21_0 / 10)))
end

function PopQuickGuaJiSure:updateItems()
	self.scrollView:removeAllChildren()
	table.sort(self.timeData.items, function(arg_23_0, arg_23_1)
		return item_data[arg_23_0].equip_quality > item_data[arg_23_1].equip_quality
	end)

	local var_22_0 = {}
	local var_22_1 = {}

	for iter_22_0, iter_22_1 in ipairs(self.timeData.items) do
		if not var_22_0[iter_22_1] then
			table.insert(var_22_1, iter_22_1)

			var_22_0[iter_22_1] = true
		end
	end

	self.timeData.items = var_22_1

	local var_22_2 = 0

	self.allSp = {}
	self.itemNum = #self.timeData.items

	local var_22_3 = self.scrollView:getContentSize()

	print(var_22_3.width / (10 + (var_0_10 + 20) * 5))

	local var_22_4 = (40 + math.ceil(self.itemNum / 5) * (20 + var_0_11)) * (var_22_3.width / (10 + (var_0_10 + 20) * 5))

	if var_22_4 < var_22_3.height then
		var_22_4 = var_22_3.height
	end

	self.scrollView:setInnerContainerSize(cc.size(var_22_3.width, var_22_4))

	self.initposY = self.initposY or self.scrollView:getInnerContainer():getPositionY()
	self.scrollheight = var_22_4

	for iter_22_2, iter_22_3 in ipairs(self.timeData.items) do
		local var_22_5 = ItemSprite:createNewWithItemId(iter_22_3)

		var_22_5:setAnchorPoint(cc.p(0.5, 0.5))
		var_22_5:setScale(var_22_3.width / (10 + (var_0_10 + 20) * 5))
		var_22_5:setName("sp" .. "_" .. iter_22_2)
		self.scrollView:addChild(var_22_5)
		var_22_5:setPosition(cc.p((var_0_10 / 2 + (var_0_10 + 20) * var_22_2) * (var_22_3.width / (10 + (var_0_10 + 20) * 5)), var_22_4 - (20 + var_0_11 / 2 + (var_0_11 + 20) * 0) * (var_22_3.width / (10 + (var_0_10 + 20) * 5))))
		var_22_5:addSpriteTouchEventListener(function(arg_24_0, arg_24_1)
			if arg_24_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_24_0:getLocation().y - arg_24_0:getStartLocation().y) >= 25 then
				return
			end

			if item_data[iter_22_3].bag_item_type == kITEM_HORCRUX then
				return
			end

			if item_data[iter_22_3].bag_item_type == kITEM_HERO then
				return
			end
		end)
		table.insert(self.allSp, var_22_5)

		var_22_2 = var_22_2 + 1

		if var_22_2 >= 5 then
			var_22_2 = 0
		end
	end
end

function PopQuickGuaJiSure:updateCostPanel()
	self.chooseBtnSmall:getChildByName("Image_25"):setVisible(self.quickGuajiType == var_0_8)
	self.chooseBtnBig:getChildByName("Image_26"):setVisible(self.quickGuajiType == var_0_9)

	if self.timeData.times == self.timeData.totaltimes then
		self.panelsmall:setVisible(false)
		self.panelbig:setVisible(false)
		self.lessTimeNum:setVisible(false)
		self.surebtn:setPositionY(140)
		self.surebtn:getChildByName("Label_21"):setString(L_FREE_FOR_CHARGE)
	else
		self.panelsmall:setVisible(true)
		self.panelbig:setVisible(true)
		self.lessTimeNum:setVisible(self.quickGuajiType == var_0_8)
		self.surebtn:setPositionY(-26)
		self.surebtn:getChildByName("Label_21"):setString(L_QUICK_FIGHT.button)
	end

	local var_25_0 = cc.c3b(255, 73, 86)
	local var_25_1 = cc.c3b(102, 255, 116)

	self.numSmall:setString(item_manager:getItemNumber(9999999) .. "/1")
	self.numBig:setString(item_manager:getItemNumber(9999998) .. "/1")
	self.numSmall:setColor(item_manager:haveItem(9999999) and var_25_1 or var_25_0)
	self.numBig:setColor(item_manager:haveItem(9999998) and var_25_1 or var_25_0)
	self.lessTimeNum:setString(string.format(L_QUICK_HANGUP_LISSTIME, self.timeData.times, self.timeData.totaltimes))
end

function PopQuickGuaJiSure:showQuickFightAni(arg_26_1)
	local var_26_0 = ccui.Layout:create()

	var_26_0:setContentSize(GameDisplay.getScreenSize())
	var_26_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_26_0:setPositionY(var_26_0:getPositionY() - GameDisplay.fix_y)
	var_26_0:setBackGroundColor(cc.c3b(15, 15, 15))
	var_26_0:setCascadeOpacityEnabled(false)
	var_26_0:setBackGroundColorOpacity(200)
	var_26_0:setTouchEnabled(true)
	self:addChild(var_26_0, 30)
	require("view.Armature.L2Skeleton")

	local var_26_1 = L2Skeleton:create("spine/ui/radar.json", "spine/ui/radar.atlas")

	var_26_1:refreshSkeleton()
	var_26_1:setPosition(cc.p(320, GameDisplay.getScreenSize().height / 2))
	var_26_0:addChild(var_26_1, 20)
	audio_manager:playeffectMusicTest("sound/quickfight")
	var_26_1:registerListener(SP_ANIMATION_COMPLETE, function(arg_27_0)
		if arg_27_0.animation == "animation" then
			var_26_0:runAction(cc.RemoveSelf:create())

			self.isRunAction = false

			LayerManager:pushInLayer("PopQuickGuaJiResult", arg_26_1)
		end
	end)
	var_26_1:play("animation", false)
end

function PopQuickGuaJiSure.updateGuidesOnLayer(arg_28_0)
	GuideListener.cleanCurGuides()
	GuideListener.lockGuideTrigger(false)
	GuideListener.updateGuides(arg_28_0)
end

function PopQuickGuaJiSure:exit()
	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopQuickGuaJiSure:quickFight(arg_31_1)
	local var_31_0 = playermodel.curMode
	local var_31_1, var_31_2 = playermodel.curLevel:match("(%d+)-(%d+)")
	local var_31_3 = tonumber(var_31_1)
	local var_31_4, var_31_5 = level_manager:isQuickFightValid(playermodel.curMode, var_31_3)

	if not var_31_4 then
		global_ShowBlockWords(var_31_5)

		return
	end

	local var_31_6 = self.quickGuajiType == var_0_8 and var_0_12(7200) or var_0_12(36000)

	local function var_31_7()
		GuideListener.lockGuideTriggerManual(false)
		GuideListener.updateGuides(LayerManager:getCurrentLayerObj())

		self.isRunAction = false

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("updateMainLineTaskUI"))
	end

	local function var_31_8(arg_33_0, arg_33_1)
		if tolua.isnull(self) then
			return
		end

		if arg_33_0 == 1 then
			if arg_33_1.items and #arg_33_1.items > 1 then
				table.sort(arg_33_1.items, function(arg_34_0, arg_34_1)
					if item_data[arg_34_0.dropid].equip_quality == item_data[arg_34_1.dropid].equip_quality then
						return arg_34_0.entityid < arg_34_1.entityid
					else
						return item_data[arg_34_0.dropid].equip_quality > item_data[arg_34_1.dropid].equip_quality
					end
				end)
			end

			self:showQuickFightAni({
				gold = arg_33_1.gold,
				sp = arg_33_1.sp,
				items = arg_33_1.items,
				name = level_manager:getChapterName(var_31_0, var_31_3),
				time = var_31_6,
				levelinfo = level_manager:getModeName(var_31_0) .. level_manager:getChapterName(var_31_0, var_31_3),
				surecallback = var_31_7,
				cancelcallback = var_31_7,
				callback = function()
					self:updateUI()
					require("controller.condition_trigger_packs_manager"):check_trigger_condition({
						shop_type = PROMOTION_PACKS,
						quick_fight_times = self.timeData.times,
						quickGuajiType = self.quickGuajiType
					})
				end
			})
		elseif arg_33_0 == 2 then
			global_ShowBlockWords(L_QUICK_HANGUP_RESULT[2])
			var_31_7()
		elseif arg_33_0 == 3 then
			global_ShowBlockWords(L_QUICK_HANGUP_RESULT[3])
			var_31_7()
		elseif arg_33_0 == 4 then
			global_ShowBlockWords(L_QUICK_HANGUP_RESULT[4])
			var_31_7()
		elseif arg_33_0 == 5 then
			global_ShowBlockWords(string.format(L_QUICK_HANGUP_RESULT[5], var_31_3))
			var_31_7()
		end
	end

	local function var_31_9()
		level_manager:quickFight(var_31_0, var_31_3, self.quickGuajiType, var_31_8)
	end

	if self.timeData.times > 0 or self.quickGuajiType == var_0_9 then
		GuideListener.lockGuideTriggerManual(true)
		GuideListener.cleanCurGuides()

		if self.quickGuajiType == var_0_8 then
			if require("data.diamond_update_data")[1000 + (self.timeData.totaltimes - self.timeData.times + 1)].costdiamond > item_manager:getItemNumber(9999999) then
				self.isRunAction = false

				;(function(arg_37_0)
					local var_37_0 = {
						costtype = "diamond",
						is_need_pop_layer = 1,
						own = playermodel.diamond,
						cost = item_data[9999999].price_diamond * arg_37_0,
						surecallback = function()
							level_manager:buyQuickFightTicket(arg_37_0, function(arg_39_0)
								if arg_39_0 == 1 then
									var_31_9()
								elseif arg_39_0 == 2 then
									LayerManager:pushInLayer("PopGoBuyDiamond", {
										is_need_pop_layer = 1
									})
								end
							end)
						end,
						des = string.format(L_QUICK_HANGUP_BUY, item_data[9999999].price_diamond * arg_37_0, arg_37_0),
						labels = L_COMPONENT_QUICKFIGHT
					}

					var_37_0.labels.titleImage = "title_items_lack.png"

					LayerManager:pushInLayer("PopDoLayer", var_37_0)
				end)(require("data.diamond_update_data")[1000 + (self.timeData.totaltimes - self.timeData.times + 1)].costdiamond - item_manager:getItemNumber(9999999))
			else
				var_31_9()
			end
		else
			var_31_9()
		end
	else
		GuideListener.lockGuideTriggerManual(true)
		GuideListener.cleanCurGuides()

		self.isRunAction = false

		if self.timeData.times == 0 then
			global_ShowBlockWords(L_QUICK_HANGUP_RESULT[3])
		else
			LayerManager:pushInLayer("PopGoBuyGiftTicketLayer", {
				targetlayer = "PopSupermarketLayer",
				initSelectPage = 1,
				bgpath = "public/panelbg/gain_card.png",
				callback = function(...)
					self:updateUI()
				end
			})
		end
	end
end

return PopQuickGuaJiSure
