LabLineLayer = class("LabLineLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local alert_manager = require("controller.alert_manager")
local lab_manager = require("controller.lab_manager")
local armature_manager = require("controller.armature_manager")
local item_data = require("data.item_data")
local lab_recipe_data = require("data.lab_recipe_data")

require("view.Sprite.BottomBtnList")
require("view.Sprite.ItemSprite")

local var_0_9 = {
	"public/box/weapon_bg_white.png",
	"public/box/weapon_bg_green.png",
	"public/box/weapon_bg_blue.png",
	"public/box/weapon_bg_purple.png",
	"public/box/weapon_bg_orange.png",
	"public/box/weapon_bg_red.png"
}
local var_0_10

function LabLineLayer.getInstance()
	return var_0_10
end

function LabLineLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = LabLineLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function LabLineLayer:init(arg_4_1)
	var_0_10 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "LabLineLayer.json" or "LabLineLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.slotInfo = arg_4_1.slotInfo
	self.exitcallback = arg_4_1.exitcallback
	self.curSelectRecipe = self.slotInfo.id

	if self.curSelectRecipe then
		self.costPower = lab_recipe_data[self.curSelectRecipe].cost_power or 0
	end

	self.curSelectNum = self.slotInfo.status == RECIPE_WORKING and self.slotInfo.allNum - self.slotInfo.completeNum or self.slotInfo.id and 1 or 0
	self.electric = self.curSelectNum * self.costPower
	self.sumCostPower = self.electric
	self.waitNet = false
	self.goto_back_system_id = arg_4_1.goto_back_system_id
	self.timer = cc.Node:create()

	self:addChild(self.timer)
	self:startScheduler()
	self:initUI()
	self:updateUI()
	self:initElectricNum()
	self:initItemElectricNum()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			var_0_10 = nil

			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduler)

			self.scheduler = nil

			if self.exitcallback then
				self.exitcallback()
			end

			GlobalUpdateElectric()
		end
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_9"):setString(L_LABLINELAYER[1])
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_name"):setString(L_LABLINELAYER[2])
end

function LabLineLayer:updateElectricNum(arg_6_1, arg_6_2)
	if ELECTRIC == arg_6_1 then
		if arg_6_2 >= 0 then
			print("222222222222222222", arg_6_2)
		end

		self:initElectricNum()
		print("12222222", item_manager:getItemNumber(ELECTRIC))
	end
end

function LabLineLayer:initElectricNum()
	if not self.imageEle then
		local var_7_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_console")

		self.imageEle = ccui.ImageView:create("lab_line/electric.png", var_0_0)

		self.imageEle:setTouchEnabled(true)
		self.imageEle:setPosition(cc.p(560, 1100 + GameDisplay.fix_y))
		self.rootLayer:addChild(self.imageEle, 999)

		self.labelEle = cc.Label:createWithTTF(global_trans_number(item_manager:getItemNumber(ELECTRIC)), FONT_DES, 20)

		self.labelEle:setPosition(cc.p(self.imageEle:getContentSize().width / 2, self.imageEle:getContentSize().height / 2))
		self.imageEle:addChild(self.labelEle, 999)
		self.imageEle:addTouchEventListener(function(arg_8_0, arg_8_1)
			if arg_8_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_8_0

			if self.touchLock then
				do return end

				var_8_0 = {}
			end

			function var_8_0.callback()
				self:updateUI()

				if self.labelEle then
					self.labelEle:setString(global_trans_number(item_manager:getItemNumber(ELECTRIC)))
				end
			end

			msg = var_8_0

			LayerManager:pushInLayer("PopElectricSupplyLayer", msg)
		end)
	else
		self.labelEle:setString(global_trans_number(item_manager:getItemNumber(ELECTRIC)))
	end
end

function LabLineLayer:startEffect()
	local function var_10_0()
		if self.slotInfo.status == RECIPE_WORKING or self.slotInfo.cacheItemCount > 0 then
			local var_11_0

			var_11_0 = armature_manager:createAndPlayArmature("labLineAct2", nil, nil, {
				["end"] = function(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
					ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cache"):setOpacity(255)
					var_11_0:setVisible(false)
				end
			})

			;(nil):setAnchorPoint(cc.p(0.5, 0))
			var_11_0:setPositionX(var_11_0:getPositionX() + 16)
			var_11_0:setPositionY(252)
			self.rootLayer:addChild(var_11_0)
		end
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_console"):setOpacity(0)

	local var_10_1

	var_10_1 = armature_manager:createAndPlayArmature("labLineAct1", nil, nil, {
		["end"] = function(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
			ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_console"):setOpacity(255)
			var_10_1:setVisible(false)
			var_10_0()
		end
	})

	;(nil):setAnchorPoint(cc.p(0.5, 0))
	var_10_1:setPositionY(422)
	self.rootLayer:addChild(var_10_1)
end

function LabLineLayer:initUI()
	self:startEffect()
	self:initBottomList()

	local function var_14_0()
		return function(arg_16_0, arg_16_1)
			if arg_16_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_16_0.itemid then
				return
			end

			if arg_16_0.ownNum <= arg_16_0.singleNum then
				local var_16_0 = PopLayer.new()

				LayerManager:pushInLayer("PopGoGainLayer", {
					item = arg_16_0.itemid,
					goto_back_system_id = self.goto_back_system_id
				})
			else
				({
					itemid = arg_16_0.itemid,
					goto_back_system_id = self.goto_back_system_id
				}).layer = cc.Layer:create()
			end
		end
	end

	local var_14_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_console")
	local var_14_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material1")

	for iter_14_0 = 4, 6 do
		local var_14_3 = var_14_2:clone()

		var_14_1:addChild(var_14_3)
		var_14_3:setName("Image_material" .. iter_14_0)
		var_14_3:setPosition(ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material" .. iter_14_0 - 3):getPositionX() + 130, ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material" .. iter_14_0 - 3):getPositionY())
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material1"):addTouchEventListener(var_14_0())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material2"):addTouchEventListener(var_14_0())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material3"):addTouchEventListener(var_14_0())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material4"):addTouchEventListener(var_14_0())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material5"):addTouchEventListener(var_14_0())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material6"):addTouchEventListener(var_14_0())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_selectBtn"):addTouchEventListener(self:getSelectBtnHandel())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sub"):addTouchEventListener(self:getChangeNumHandel())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_add"):addTouchEventListener(self:getChangeNumHandel())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_max"):addTouchEventListener(self:getChangeNumHandel())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):addTouchEventListener(self:getSureBtnHandel())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_cancel"):addTouchEventListener(self:getSureBtnHandel())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_get"):addTouchEventListener(self:getCollectBtnHandel())
	self:initMaterialSp()
	;(function()
		self.curSelectNumLabel = ccui.TextBMFont:create(88, "fonts/number_workshop.fnt")

		local var_17_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sub")

		self.curSelectNumLabel:setPositionX((var_17_0:getPositionX() + ccui.Helper:seekWidgetByName(self.rootLayer, "Button_add").getPositionX(var_17_0)) / 2 + 12)
		self.curSelectNumLabel:setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sub"):getPositionY())
		self.curSelectNumLabel:setAnchorPoint(cc.p(0.5, 0.5))
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_controller"):addChild(self.curSelectNumLabel)
	end)()

	if self.slotInfo.status ~= RECIPE_WORKING and self.slotInfo.cacheItemCount < 1 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_cacheBg"):setScaleX(0)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_cacheBg"):setVisible(false)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cache"):setOpacity(0)
	end

	if self.slotInfo.status ~= RECIPE_WORKING then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_controller"):setPositionX(0)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_controller"):setPositionX(150)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_selectBtn"):setAnchorPoint(cc.p(0.5, 0.5))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_selectBtn"):setPosition(cc.p(471, 324))

	local var_14_5 = ItemSmallSprite:createSmallItem()

	var_14_5:setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_collect"):getContentSize().width / 2)
	var_14_5:setPositionY(110)
	var_14_5:setInfoTouchEvent(true)
	var_14_5:setName("itemSp")
	var_14_5:setScale(0.7)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_collect"):addChild(var_14_5)

	self.quickBtn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_quick")

	self.quickBtn:addTouchEventListener(self:getQuickFinishHandel())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_name"):setPositionY(1100 + GameDisplay.fix_y)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_box"):setPositionY(264 - GameDisplay.fix_y)
end

function LabLineLayer:updateProgressBar()
	if self.curTime and self.slotInfo.status == RECIPE_WORKING then
		local var_18_0 = math.ceil(self.curTime - self.slotInfo.startTime) + self.slotInfo.addTime

		var_18_0 = var_18_0 == 0 and 0 or var_18_0 % lab_recipe_data[self.slotInfo.id].recipe_time == 0 and lab_recipe_data[self.slotInfo.id].recipe_time or var_18_0 % lab_recipe_data[self.slotInfo.id].recipe_time

		local var_18_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "ProgressBar_bar")
		local var_18_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_barbg")

		var_18_1:setPercent(var_18_0 / lab_recipe_data[self.slotInfo.id].recipe_time * 100)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_percent"):setPositionX(var_18_2:getPositionX() + var_18_2:getContentSize().width * (var_18_0 / lab_recipe_data[self.slotInfo.id].recipe_time) - var_18_2:getContentSize().width / 2)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_percent"):setVisible(true)
	else
		local var_18_3 = ccui.Helper:seekWidgetByName(self.rootLayer, "ProgressBar_bar")

		var_18_3:setPercent(0)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_percent"):setPositionX(var_18_3:getPositionX() - var_18_3:getContentSize().width / 2)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_percent"):setVisible(false)
	end
end

function LabLineLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer()
	end)

	self.bottomList:setName("bottomlist")
	self.bottomList:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.bottomList, 1000)
end

function LabLineLayer:initItemElectricNum()
	if not self.imageEleTwo then
		self.imageEleTwo = ccui.ImageView:create("public/currency/electric.png", var_0_0)

		self.imageEleTwo:setPosition(cc.p(450, 150))

		local var_21_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg")

		var_21_0:addChild(self.imageEleTwo, 999)

		self.itemEleNum = cc.Label:createWithTTF(global_trans_number(self.sumCostPower), FONT_TITLE, 28)

		self.itemEleNum:setAnchorPoint(cc.p(0, 0.5))
		self.itemEleNum:setPosition(cc.p(self.imageEleTwo:getPositionX() + 30, self.imageEleTwo:getPositionY()))
		var_21_0:addChild(self.itemEleNum, 999)

		if self.sumCostPower == 0 then
			self.imageEleTwo:setVisible(false)
			self.itemEleNum:setVisible(false)
		else
			self.imageEleTwo:setVisible(false)
			self.itemEleNum:setVisible(false)
		end
	else
		self.imageEleTwo:setVisible(false)
		self.itemEleNum:setVisible(false)
		self.itemEleNum:setString(self.costPower)
	end
end

function LabLineLayer:updateItemElectricNum()
	self.sumCostPower = self.sumCostPower + self.electric

	self.itemEleNum:setString(global_trans_number(self.sumCostPower))
end

function LabLineLayer.getSelectBtnHandel(arg_23_0)
	local var_23_0 = 0

	return function(arg_24_0, arg_24_1)
		if arg_24_1 == ccui.TouchEventType.began then
			arg_24_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
				var_23_0 = 0.2

				if arg_23_0.curSelectRecipe then
					PopLayer:Item({
						itemid = lab_recipe_data[arg_23_0.curSelectRecipe].target,
						goto_back_system_id = arg_23_0.goto_back_system_id,
						layer = cc.Layer:create()
					})
				end
			end)))
		elseif arg_24_1 == ccui.TouchEventType.canceled then
			arg_24_0:stopAllActions()

			var_23_0 = 0
		elseif arg_24_1 == ccui.TouchEventType.ended then
			arg_24_0:stopAllActions()

			if var_23_0 == 0 then
				local var_24_0

				if arg_23_0.slotInfo.status == RECIPE_WORKING then
					global_ShowBlockWords(L_LABLINE_PRODUCE.Producing)

					do return end

					var_24_0 = {
						listType = 1,
						goto_back_system_id = arg_23_0.goto_back_system_id
					}
				end

				function var_24_0.selectCallback(arg_26_0)
					if arg_26_0 ~= arg_23_0.curSelectRecipe then
						arg_23_0.curSelectRecipe = arg_26_0
						arg_23_0.costPower = lab_recipe_data[arg_23_0.curSelectRecipe].cost_power or 0
						arg_23_0.sumCostPower = arg_23_0.costPower
						arg_23_0.curSelectNum = 1

						arg_23_0:changeRecipeEffect(function()
							arg_23_0:initItemElectricNum()
							arg_23_0:updateUI()
							arg_23_0:updateTime()
							arg_23_0:updateProgressBar()
							arg_23_0:setSpNum()
						end)
					end
				end

				LayerManager:pushInLayer("LabRecipeListLayer", var_24_0)
			end

			var_23_0 = 0
		end
	end
end

function LabLineLayer:getChangeNumHandel()
	local var_28_0 = 0
	local var_28_1 = cc.Node:create()

	self:addChild(var_28_1)

	local function var_28_2(arg_29_0, arg_29_1)
		if arg_29_0:getName() == "Button_sub" then
			if not self.curSelectRecipe then
				global_ShowBlockWords(L_LABLINE_CHANGE_NUM.Unselect)

				return
			end

			if self.curSelectNum - 1 < 1 then
				global_ShowBlockWords(L_LABLINE_CHANGE_NUM.Less)
			else
				self.curSelectNum = self.curSelectNum - 1
				self.electric = self.curSelectNum * self.costPower

				if self.slotInfo.status == RECIPE_WORKING then
					self:pushMessageQueue(self.curSelectNum)

					self.electric = self.curSelectNum * self.costPower - (self.curSelectNum + 1) * self.costPower

					self:updateItemElectricNum()
				else
					self.electric = self.curSelectNum * self.costPower - (self.curSelectNum + 1) * self.costPower

					self:updateItemElectricNum()
				end

				self:updateUI()
				self:setSpNum()
				self:updateTime()
				self:updateProgressBar()
			end
		end

		if arg_29_0:getName() == "Button_add" then
			if not self.curSelectRecipe then
				global_ShowBlockWords(L_LABLINE_CHANGE_NUM.Unselect)

				return
			end

			if ((self.curSelectRecipe == 10001 or nil) and 300) < self.curSelectNum + 1 then
				global_ShowBlockWords(L_LABLINE_CHANGE_NUM.More)
			elseif self:isEnough(self.curSelectNum + 1, var_28_1) == 0 then
				global_ShowBlockWords(L_COMMON_WARNING.Material_Lack)
			elseif self:isEnough(self.curSelectNum + 1, var_28_1) == -1 then
				global_ShowBlockWords(L_ELECTRIC_LACK)
			else
				self.curSelectNum = self.curSelectNum + 1
				self.electric = self.curSelectNum * self.costPower

				if self.slotInfo.status == RECIPE_WORKING then
					self:pushMessageQueue(self.curSelectNum)

					self.electric = self.curSelectNum * self.costPower - (self.curSelectNum - 1) * self.costPower

					self:updateItemElectricNum()
				else
					self.electric = self.curSelectNum * self.costPower - (self.curSelectNum - 1) * self.costPower

					self:updateItemElectricNum()
				end

				self:updateUI()
				self:setSpNum()
				self:updateTime()
				self:updateProgressBar()
			end
		end

		if arg_29_0:getName() == "Button_max" then
			if self.slotInfo.status == RECIPE_WORKING then
				return
			end

			if not self.curSelectRecipe then
				global_ShowBlockWords(L_LABLINE_CHANGE_NUM.Unselect)

				return
			end

			local var_29_1 = self:getMaxProduceNum()

			if var_29_1 == 0 then
				global_ShowBlockWords("材料或电力不足，无法生产")

				return
			end

			local var_29_2 = self.curSelectNum

			self.curSelectNum = var_29_1
			self.electric = self.curSelectNum * self.costPower

			if self.slotInfo.status == RECIPE_WORKING then
				self:pushMessageQueue(self.curSelectNum)

				self.electric = self.curSelectNum * self.costPower - var_29_2 * self.costPower

				self:updateItemElectricNum()
			else
				self.electric = self.curSelectNum * self.costPower - var_29_2 * self.costPower

				self:updateItemElectricNum()
			end

			self:updateUI()
			self:setSpNum()
			self:updateTime()
			self:updateProgressBar()
		end
	end

	return function(arg_30_0, arg_30_1)
		if arg_30_0:getName() == "Button_max" then
			if arg_30_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_28_2(arg_30_0, arg_30_1)

			return
		end

		if arg_30_1 == ccui.TouchEventType.began then
			arg_30_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
				var_28_0 = 0.2

				var_28_1:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
					var_28_2(arg_30_0, arg_30_1)
				end), cc.DelayTime:create(0.022222222222222223))))
			end)))
		elseif arg_30_1 == ccui.TouchEventType.canceled then
			var_28_1:stopAllActions()
			arg_30_0:stopAllActions()

			var_28_0 = 0
		elseif arg_30_1 == ccui.TouchEventType.ended then
			var_28_1:stopAllActions()
			arg_30_0:stopAllActions()

			if var_28_0 == 0 then
				var_28_2(arg_30_0, arg_30_1)
			end

			var_28_0 = 0
		end
	end
end

function LabLineLayer:getMaxProduceNum()
	local var_33_0 = 99

	if self.curSelectRecipe == 10001 then
		var_33_0 = 300
	end

	local var_33_1 = math.floor(item_manager:getItemNumber(ELECTRIC) / self.costPower)
	local var_33_2 = var_33_0

	while lab_recipe_data[self.curSelectRecipe]["material" .. 1] do
		var_33_2 = math.min(var_33_2, (math.floor(item_manager:getItemNumber(lab_recipe_data[self.curSelectRecipe]["material" .. 1]) / lab_recipe_data[self.curSelectRecipe]["material" .. 1 .. "_num"])))
	end

	return math.min(var_33_0, var_33_1, var_33_2)
end

local var_0_11 = cc.p(150, 0)
local var_0_12 = cc.p(0, 0)

function LabLineLayer.getSureBtnHandel(arg_34_0)
	return function(arg_35_0, arg_35_1)
		if arg_35_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_34_0.curSelectRecipe then
			global_ShowBlockWords(L_LABLINE_CHANGE_NUM.Unselect)

			return
		end

		if ccui.Helper:seekWidgetByName(arg_34_0.rootLayer, "Panel_controller").moving then
			return
		end

		if arg_34_0.slotInfo.status == RECIPE_COMPLETE then
			if arg_34_0.waitNet then
				return
			end

			if arg_34_0:isEnough() == 1 then
				if not ccui.Helper:seekWidgetByName(arg_34_0.rootLayer, "Image_cacheBg"):isVisible() then
					ccui.Helper:seekWidgetByName(arg_34_0.rootLayer, "Image_cacheBg"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1.2, 1), cc.ScaleTo:create(0.1, 1, 1)))
					ccui.Helper:seekWidgetByName(arg_34_0.rootLayer, "Image_cacheBg"):setVisible(true)
				end

				arg_34_0.queueCache = nil
				arg_34_0.waitNet = true

				lab_manager:start_lab_recipe(arg_34_0.slotInfo.slot, arg_34_0.curSelectRecipe, arg_34_0.curSelectNum, function(arg_36_0)
					if not var_0_10 then
						return
					end

					if arg_36_0.result == 1 then
						arg_34_0:updateSlotData(arg_36_0.recipe_single)
						arg_34_0:updateUI()

						ccui.Helper:seekWidgetByName(arg_34_0.rootLayer, "Panel_controller").moving = true

						ccui.Helper:seekWidgetByName(arg_34_0.rootLayer, "Panel_controller"):runAction(cc.Sequence:create(cc.MoveTo:create(0.2, var_0_11), cc.CallFunc:create(function()
							ccui.Helper:seekWidgetByName(arg_34_0.rootLayer, "Panel_controller").moving = false
						end)))
					end

					arg_34_0.waitNet = false
				end)
			elseif arg_34_0:isEnough() == 0 then
				global_ShowBlockWords(L_COMMON_WARNING.Material_Lack)
			elseif arg_34_0:isEnough() == -1 then
				global_ShowBlockWords(L_ELECTRIC_LACK)
			end
		end

		if arg_34_0.slotInfo.status == RECIPE_WORKING then
			arg_34_0.waitNet = true

			lab_manager:stop_lab_recipe(arg_34_0.slotInfo.slot, function(arg_38_0)
				if not var_0_10 then
					return
				end

				arg_34_0.waitNet = false

				arg_34_0:updateSlotData(arg_38_0.recipe_single)

				arg_34_0.curSelectRecipe = arg_34_0.slotInfo.id
				arg_34_0.curSelectNum = 0
				arg_34_0.costPower = 0
				arg_34_0.electric = 0

				arg_34_0:updateUI()

				ccui.Helper:seekWidgetByName(arg_34_0.rootLayer, "Panel_controller").moving = true

				ccui.Helper:seekWidgetByName(arg_34_0.rootLayer, "Panel_controller"):runAction(cc.Sequence:create(cc.MoveTo:create(0.2, cc.p(var_0_12)), cc.CallFunc:create(function()
					ccui.Helper:seekWidgetByName(arg_34_0.rootLayer, "Panel_controller").moving = false
				end)))
				ccui.Helper:seekWidgetByName(arg_34_0.rootLayer, "Image_cacheBg"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 0, 1)))
			end)

			if arg_34_0.imageEleTwo and arg_34_0.itemEleNum then
				arg_34_0.imageEleTwo:setVisible(false)
				arg_34_0.itemEleNum:setVisible(false)
			end
		end

		if arg_34_0.slotInfo.status == RECIPE_FREE then
			if arg_34_0:isEnough() == 1 then
				if not ccui.Helper:seekWidgetByName(arg_34_0.rootLayer, "Image_cacheBg"):isVisible() then
					ccui.Helper:seekWidgetByName(arg_34_0.rootLayer, "Image_cacheBg"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1.2, 1), cc.ScaleTo:create(0.1, 1, 1)))
					ccui.Helper:seekWidgetByName(arg_34_0.rootLayer, "Image_cacheBg"):setVisible(true)
				end

				arg_34_0.queueCache = nil
				arg_34_0.waitNet = true

				lab_manager:start_lab_recipe(arg_34_0.slotInfo.slot, arg_34_0.curSelectRecipe, arg_34_0.curSelectNum, function(arg_40_0)
					if not var_0_10 then
						return
					end

					arg_34_0.waitNet = false

					arg_34_0:updateSlotData(arg_40_0.recipe_single)
					arg_34_0:updateUI()

					arg_34_0.electric = arg_34_0.curSelectNum * arg_34_0.costPower
					ccui.Helper:seekWidgetByName(arg_34_0.rootLayer, "Panel_controller").moving = true

					ccui.Helper:seekWidgetByName(arg_34_0.rootLayer, "Panel_controller"):runAction(cc.Sequence:create(cc.MoveTo:create(0.2, var_0_11), cc.CallFunc:create(function()
						ccui.Helper:seekWidgetByName(arg_34_0.rootLayer, "Panel_controller").moving = false
					end)))
					ccui.Helper:seekWidgetByName(arg_34_0.rootLayer, "Image_cacheBg"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1.2, 1), cc.ScaleTo:create(0.1, 1, 1)))
				end)
			elseif arg_34_0:isEnough() == 0 then
				global_ShowBlockWords(L_COMMON_WARNING.Material_Lack)
			else
				global_ShowBlockWords(L_ELECTRIC_LACK)
			end
		end
	end
end

function LabLineLayer:isEnoughOfMaterial(arg_42_1)
	if not self.curSelectRecipe then
		return false
	end

	local var_42_0 = arg_42_1 or self.curSelectNum

	if self.slotInfo.status == RECIPE_WORKING then
		var_42_0 = var_42_0 - (self.slotInfo.allNum - self.slotInfo.completeNum)
	end

	local var_42_1 = 1

	while lab_recipe_data[self.curSelectRecipe]["material" .. var_42_1] do
		if lab_recipe_data[self.curSelectRecipe]["material" .. var_42_1 .. "_num"] * var_42_0 > item_manager:getItemNumber(lab_recipe_data[self.curSelectRecipe]["material" .. var_42_1]) then
			return false
		end

		var_42_1 = var_42_1 + 1
	end

	if item_manager:getItemNumber(ELECTRIC) < self.sumCostPower then
		return false
	end

	if var_42_0 == 0 then
		return false
	end

	return true
end

function LabLineLayer:isEnough(arg_43_1, arg_43_2)
	if not self.curSelectRecipe then
		return false
	end

	local var_43_0 = arg_43_1 or self.curSelectNum

	if self.slotInfo.status == RECIPE_WORKING then
		var_43_0 = var_43_0 - (self.slotInfo.allNum - self.slotInfo.completeNum)
	end

	local var_43_1 = 1

	while lab_recipe_data[self.curSelectRecipe]["material" .. var_43_1] do
		if lab_recipe_data[self.curSelectRecipe]["material" .. var_43_1 .. "_num"] * var_43_0 > item_manager:getItemNumber(lab_recipe_data[self.curSelectRecipe]["material" .. var_43_1]) then
			return 0
		end

		var_43_1 = var_43_1 + 1
	end

	if item_manager:getItemNumber(ELECTRIC) < self.sumCostPower then
		if arg_43_2 then
			arg_43_2:stopAllActions()
		end

		if LayerManager:getRef():getTopPopLayer():getName() ~= "PopElectricSupplyLayer" then
			msg = {
				callback = function()
					self:updateUI()

					if self.labelEle then
						self.labelEle:setString(global_trans_number(item_manager:getItemNumber(ELECTRIC)))
					end
				end
			}

			LayerManager:pushInLayer("PopElectricSupplyLayer", msg)
		end

		return -1
	end

	if var_43_0 == 0 then
		return 0
	end

	return 1
end

function LabLineLayer.getCollectBtnHandel(arg_45_0)
	return function(arg_46_0, arg_46_1)
		if arg_46_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_45_0.slotInfo.cacheItemCount < 1 then
			global_ShowBlockWords(L_LABLINE_PRODUCE.Collect_Nil)

			return
		end

		if arg_45_0.waitNet then
			return
		end

		arg_45_0.waitNet = true

		lab_manager:collect_recipe_slot(arg_45_0.slotInfo.slot, function(arg_47_0)
			if not var_0_10 then
				return
			end

			arg_45_0.waitNet = false

			arg_45_0:updateSlotData(arg_47_0.recipe_single)
			arg_45_0:updateUI()
		end)
	end
end

function LabLineLayer:initMaterialSp()
	for iter_48_0 = 1, 6 do
		local var_48_0 = ccui.ImageView:create(var_0_9[1], var_0_0)

		var_48_0:setScale(0.7)
		var_48_0:setName("needItemObj_" .. iter_48_0)
		var_48_0:setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material" .. iter_48_0):getPositionX())
		var_48_0:setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material" .. iter_48_0):getPositionY())
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_console"):addChild(var_48_0)

		local var_48_1 = ccui.ImageView:create("GUI/image.png", var_0_0)

		var_48_1:setPositionX(var_48_0:getContentSize().width / 2)
		var_48_1:setPositionY(var_48_0:getContentSize().height / 2)
		var_48_1:setName("icon")
		var_48_0:addChild(var_48_1, 1)

		local var_48_2 = ccui.ImageView:create("public/box/word_black_bg.png", var_0_0)

		var_48_2:setPositionX(var_48_0:getContentSize().width / 2)
		var_48_2:setPositionY(var_48_0:getContentSize().height / 2 - 60)
		var_48_0:addChild(var_48_2, 2)

		local var_48_3 = ccui.Text:create("1/1", FONT_DES, 24)

		var_48_3:setPositionX(var_48_2:getPositionX())
		var_48_3:setPositionY(var_48_2:getPositionY())
		var_48_3:setName("numLabel")
		var_48_0:addChild(var_48_3, 3)
		var_48_0:setVisible(false)
	end
end

function LabLineLayer:updateSp()
	for iter_49_0 = 1, 6 do
		if self.curSelectRecipe and lab_recipe_data[self.curSelectRecipe]["material" .. iter_49_0] then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material" .. iter_49_0).itemid = lab_recipe_data[self.curSelectRecipe]["material" .. iter_49_0]
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material" .. iter_49_0).needNum = lab_recipe_data[self.curSelectRecipe]["material" .. iter_49_0 .. "_num"] * self.curSelectNum
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material" .. iter_49_0).singleNum = lab_recipe_data[self.curSelectRecipe]["material" .. iter_49_0 .. "_num"]
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material" .. iter_49_0).ownNum = item_manager:getItemNumber(lab_recipe_data[self.curSelectRecipe]["material" .. iter_49_0])

			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material" .. iter_49_0):setOpacity(0)
		else
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material" .. iter_49_0).itemid = nil
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material" .. iter_49_0).needNum = nil
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material" .. iter_49_0).singleNum = nil
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material" .. iter_49_0).ownNum = nil

			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material" .. iter_49_0):setOpacity(255)
		end
	end

	for iter_49_1 = 1, 6 do
		local var_49_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "needItemObj_" .. iter_49_1)

		if ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material" .. iter_49_1).itemid then
			var_49_0:setVisible(true)

			var_49_0.needNum = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material" .. iter_49_1).needNum
			var_49_0.ownNum = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material" .. iter_49_1).ownNum
			var_49_0.singleNum = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material" .. iter_49_1).singleNum
			var_49_0.itemid = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_material" .. iter_49_1).itemid

			var_49_0:loadTexture(var_0_9[item_data[var_49_0.itemid].equip_quality], var_0_0)
			var_49_0:getChildByName("icon"):loadTexture("equipment/" .. item_data[var_49_0.itemid].image_id .. ".png")

			if self.slotInfo.status == RECIPE_WORKING then
				var_49_0:getChildByName("numLabel"):setString(var_49_0.ownNum + (self.slotInfo.allNum - self.slotInfo.completeNum - self.curSelectNum + self.curSelectNum) * var_49_0.singleNum .. "/" .. var_49_0.singleNum * self.curSelectNum)

				if var_49_0.ownNum + (self.slotInfo.allNum - self.slotInfo.completeNum - self.curSelectNum + self.curSelectNum) * var_49_0.singleNum < var_49_0.singleNum * self.curSelectNum then
					var_49_0:getChildByName("numLabel"):setColor(cc.c3b(255, 55, 55))
				else
					var_49_0:getChildByName("numLabel"):setColor(cc.c3b(61, 255, 107))
				end
			else
				var_49_0:getChildByName("numLabel"):setString(var_49_0.ownNum .. "/" .. var_49_0.singleNum)

				if var_49_0.ownNum < var_49_0.singleNum then
					var_49_0:getChildByName("numLabel"):setColor(cc.c3b(255, 55, 55))
				else
					var_49_0:getChildByName("numLabel"):setColor(cc.c3b(61, 255, 107))
				end
			end
		else
			var_49_0:setVisible(false)
		end
	end
end

function LabLineLayer:setSpNum()
	self:updateSp()
end

function LabLineLayer:pushMessageQueue(arg_51_1)
	self.queueCache = arg_51_1

	self.timer:stopAllActions()
	self.timer:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		if self.queueCache then
			self.waitNet = true

			lab_manager:start_lab_recipe(self.slotInfo.slot, self.slotInfo.id, self.curSelectNum, function(arg_53_0)
				if not var_0_10 then
					return
				end

				if arg_53_0.result == 1 then
					self:updateSlotData(arg_53_0.recipe_single)
					self:updateUI()
				end

				self.waitNet = false
			end)
		end

		self.queueCache = nil
	end)))
end

function LabLineLayer:updateUI()
	self:updateSp()

	if self.slotInfo.status == RECIPE_COMPLETE then
		if self.slotInfo.id == self.curSelectRecipe then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_finish"):setVisible(true)
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_finish"):loadTexture("lab_line/img_finish_workshop.png", var_0_0)
		else
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_finish"):setVisible(false)
		end
	elseif self.slotInfo.status == RECIPE_WORKING then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_finish"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_finish"):loadTexture("lab_line/img_processing_workshop.png", var_0_0)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_finish"):setVisible(false)
	end

	self.curSelectNumLabel:setString(tostring(self.curSelectNum))

	if self.slotInfo.status == RECIPE_FREE or self.slotInfo.status == RECIPE_COMPLETE then
		if self:isEnoughOfMaterial() then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):loadTextures("lab_line/btn_start_workshop.png", nil, "lab_line/btn_start_workshop.png", var_0_0)
		else
			ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):loadTextures("lab_line/btn_gray_start_workshop.png", nil, "lab_line/btn_gray_start_workshop.png", var_0_0)
		end

		if self.slotInfo.id then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Label_time"):setString(string.format("%02d", math.floor((lab_recipe_data[self.slotInfo.id].recipe_time * self.curSelectNum - self.slotInfo.addTime) / 3600)) .. ":" .. string.format("%02d", math.floor((lab_recipe_data[self.slotInfo.id].recipe_time * self.curSelectNum - self.slotInfo.addTime) % 3600 / 60)) .. ":" .. string.format("%02d", math.ceil((lab_recipe_data[self.slotInfo.id].recipe_time * self.curSelectNum - self.slotInfo.addTime) % 60)))
		else
			ccui.Helper:seekWidgetByName(self.rootLayer, "Label_time"):setString("00:00:00")
		end
	end

	if self.slotInfo.cacheItemCount > 0 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_get"):loadTextures("lab_line/btn_getaward_on_workshop.png", nil, "lab_line/btn_getaward_on_workshop.png", var_0_0)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_get"):loadTextures("lab_line/btn_getaward_workshop.png", nil, "lab_line/btn_getaward_workshop.png", var_0_0)
	end

	if self.curSelectRecipe and (not self.targetSp or self.targetSp.recipe ~= self.curSelectRecipe) then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_selectBtn"):removeChild(self.targetSp)

		self.targetSp = ItemSprite:createNewWithItemId(lab_recipe_data[self.curSelectRecipe].target, nil, nil, item_data[lab_recipe_data[self.curSelectRecipe].target].name)

		self.targetSp:setCascadeOpacityEnabled(true)

		self.targetSp.recipe = self.curSelectRecipe

		self.targetSp:setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_selectBtn"):getContentSize().width / 2)
		self.targetSp:setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_selectBtn"):getContentSize().height / 2)
		self.targetSp:setScale(228 / self.targetSp:getContentSize().width)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_selectBtn"):addChild(self.targetSp)
	end

	if not self.curSelectRecipe and self.targetSp then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_selectBtn"):removeChild(self.targetSp)

		self.targetSp = nil
	end

	if not self.targetSp or not self.targetSp:isVisible() then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_selectBtn"):setOpacity(255)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_selectBtn"):setOpacity(0)
	end

	if self.curSelectRecipe then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cacheItem"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_cacheNum"):setString(L_LAB_GET .. string.format("%02d", self.slotInfo.cacheItemCount))
		ccui.Helper:seekWidgetByName(self.rootLayer, "itemSp"):updateSmallItemByItemid((self.slotInfo.id or nil) and lab_recipe_data[self.slotInfo.id].target)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cacheItem"):setVisible(false)
	end

	if self.slotInfo.status == RECIPE_WORKING then
		self.quickBtn:loadTextures("lab_line/quick_btn_on.png", nil, "lab_line/quick_btn_on.png", var_0_0)
	else
		self.quickBtn:loadTextures("lab_line/quick_btn_off.png", nil, "lab_line/quick_btn_off.png", var_0_0)
	end

	if self.labelEle then
		self.labelEle:setString(global_trans_number(item_manager:getItemNumber(ELECTRIC)))
	end

	if self.slotInfo.status == RECIPE_FREE then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_max"):setVisible(true)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_max"):setVisible(false)
	end
end

function LabLineLayer:updateTime()
	if self.curTime and self.slotInfo.status == RECIPE_WORKING then
		local var_55_0 = self.slotInfo.startTime + lab_recipe_data[self.slotInfo.id].recipe_time * (self.curSelectNum + self.slotInfo.completeNum) - math.ceil(self.curTime) - self.slotInfo.addTime

		if not self.oldDiff then
			self.oldDiff = var_55_0
		elseif math.abs(self.oldDiff - var_55_0) < 1 then
			return
		else
			self.oldDiff = var_55_0
		end

		local var_55_1 = string.format("%02d", math.floor(var_55_0 / 3600))
		local var_55_2 = string.format("%02d", math.floor(var_55_0 % 3600 / 60))
		local var_55_3 = string.format("%02d", math.ceil(var_55_0 % 60))

		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_time"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.05, 1.05, 1.05), cc.CallFunc:create(function()
			ccui.Helper:seekWidgetByName(self.rootLayer, "Label_time"):setString(var_55_1 .. ":" .. var_55_2 .. ":" .. var_55_3)
		end), cc.ScaleTo:create(0.05, 1, 1)))
	elseif self.curSelectRecipe and self.curSelectNum > 0 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_time"):setString(string.format("%02d", math.floor(lab_recipe_data[self.curSelectRecipe].recipe_time * self.curSelectNum / 3600)) .. ":" .. string.format("%02d", math.floor(lab_recipe_data[self.curSelectRecipe].recipe_time * self.curSelectNum % 3600 / 60)) .. ":" .. string.format("%02d", math.ceil(lab_recipe_data[self.curSelectRecipe].recipe_time * self.curSelectNum % 60)))
	end
end

function LabLineLayer.getQuickFinishHandel(arg_57_0)
	return function(arg_58_0, arg_58_1)
		if arg_58_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_58_0

		if arg_57_0.slotInfo.status ~= RECIPE_WORKING then
			global_ShowBlockWords(L_LABLINE_PRODUCE.No_Working)

			do return end

			var_58_0 = {
				sureCallback = function(arg_59_0, arg_59_1, arg_59_2)
					lab_manager:quick_complete_lab_recipe(arg_57_0.slotInfo.slot, arg_59_0, arg_59_1, function(arg_60_0)
						if not var_0_10 then
							return
						end

						if arg_60_0.result == 1 then
							arg_57_0:updateSlotData(arg_60_0.recipe_single)

							if arg_57_0.slotInfo.status == RECIPE_FREE then
								arg_57_0.curSelectRecipe = nil
								ccui.Helper:seekWidgetByName(arg_57_0.rootLayer, "Panel_controller").moving = true

								ccui.Helper:seekWidgetByName(arg_57_0.rootLayer, "Panel_controller"):runAction(cc.Sequence:create(cc.MoveTo:create(0.2, cc.p(var_0_12)), cc.CallFunc:create(function()
									ccui.Helper:seekWidgetByName(arg_57_0.rootLayer, "Panel_controller").moving = false
								end)))
								ccui.Helper:seekWidgetByName(arg_57_0.rootLayer, "Image_cacheBg"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 0, 1)))

								arg_57_0.curSelectNum = 1
							else
								arg_57_0.curSelectNum = arg_57_0.slotInfo.allNum - arg_57_0.slotInfo.completeNum
							end

							arg_57_0:updateUI()
							global_ShowBlockWords(L_LABLINE_QUICK_FINISH.Success)
						end

						arg_57_0.waitNet = false

						if arg_59_2 then
							arg_59_2(arg_60_0.result)
						end
					end)
				end
			}
		end

		var_58_0.sumTime = arg_57_0.slotInfo.startTime + lab_recipe_data[arg_57_0.slotInfo.id].recipe_time * (arg_57_0.curSelectNum + arg_57_0.slotInfo.completeNum) - math.ceil(arg_57_0.curTime) - arg_57_0.slotInfo.addTime
		var_58_0.recipeid = arg_57_0.slotInfo.id
		var_58_0.goto_back_system_id = arg_57_0.goto_back_system_id

		LayerManager:pushInLayer("PopLabQuickFinish", var_58_0)
	end
end

function LabLineLayer:updateSlotData(arg_62_1)
	for iter_62_0, iter_62_1 in pairs({
		allNum = true,
		completeNum = true,
		collectNum = true,
		addTime = true,
		slot = true,
		status = true,
		id = true,
		cacheItemCount = true,
		startTime = true
	}) do
		self.slotInfo[iter_62_0] = arg_62_1[iter_62_0]
	end
end

function LabLineLayer:changeRecipeEffect(arg_63_1)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_selectBtn"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 0, 1), cc.CallFunc:create(function()
		if arg_63_1 then
			arg_63_1()
		end
	end), cc.ScaleTo:create(0.1, 1, 1)))
end

function LabLineLayer.startScheduler(arg_65_0)
	local function var_65_0()
		local function var_66_0(arg_67_0)
			arg_65_0.curTime = arg_65_0.curTime + arg_67_0

			if arg_65_0.slotInfo.status == RECIPE_WORKING then
				if arg_65_0.slotInfo.startTime + lab_recipe_data[arg_65_0.slotInfo.id].recipe_time * arg_65_0.slotInfo.allNum - 1 <= arg_65_0.curTime + arg_65_0.slotInfo.addTime then
					arg_65_0.slotInfo.status = RECIPE_COMPLETE
					ccui.Helper:seekWidgetByName(arg_65_0.rootLayer, "Panel_controller").moving = true

					ccui.Helper:seekWidgetByName(arg_65_0.rootLayer, "Panel_controller"):runAction(cc.Sequence:create(cc.MoveTo:create(0.2, var_0_12), cc.CallFunc:create(function()
						ccui.Helper:seekWidgetByName(arg_65_0.rootLayer, "Panel_controller").moving = false
					end)))

					arg_65_0.slotInfo.completeNum = arg_65_0.slotInfo.allNum
					arg_65_0.slotInfo.cacheItemCount = arg_65_0.slotInfo.cacheItemCount + 1
					arg_65_0.curSelectNum = 1

					arg_65_0:updateUI()

					arg_65_0.waitNet = true

					lab_manager:get_recipe_list(false, function(arg_69_0)
						for iter_69_0, iter_69_1 in pairs(arg_69_0.list) do
							if iter_69_1.slot == arg_65_0.slotInfo.slot then
								for iter_69_2, iter_69_3 in pairs(iter_69_1) do
									arg_65_0.slotInfo[iter_69_2] = iter_69_3
								end
							end
						end

						arg_65_0:updateUI()

						arg_65_0.waitNet = false
					end)
				else
					local var_67_0 = math.floor((math.ceil(arg_65_0.curTime) - arg_65_0.slotInfo.startTime + arg_65_0.slotInfo.addTime) / lab_recipe_data[arg_65_0.slotInfo.id].recipe_time)

					if var_67_0 > arg_65_0.slotInfo.completeNum then
						arg_65_0.slotInfo.cacheItemCount = arg_65_0.slotInfo.cacheItemCount + var_67_0 - arg_65_0.slotInfo.completeNum
						arg_65_0.slotInfo.completeNum = var_67_0
						arg_65_0.sumCostPower = arg_65_0.sumCostPower - arg_65_0.costPower

						arg_65_0.itemEleNum:setString(global_trans_number(arg_65_0.sumCostPower))

						arg_65_0.curSelectNum = arg_65_0.slotInfo.allNum - arg_65_0.slotInfo.completeNum

						arg_65_0:updateUI()
					end
				end
			end

			arg_65_0:updateTime()
			arg_65_0:updateProgressBar()
		end

		arg_65_0.scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(var_66_0, 0.1, false)

		var_66_0(0)
	end

	playermodel:getServerTime(function()
		arg_65_0.curTime = playermodel.onlineTime

		arg_65_0:updateUI()
		var_65_0()
	end)
end

function LabLineLayer.exit(arg_71_0)
	LayerManager:removePopLayer()
end
