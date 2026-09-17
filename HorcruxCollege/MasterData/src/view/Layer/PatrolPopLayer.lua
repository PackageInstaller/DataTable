PatrolPopLayer = class("PatrolPopLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.GirlSprite")
require("view.Sprite.HorcruxSprite")

local playermodel = require("model.playermodel")
local array_manager = require("controller.array_manager")
local level_manager = require("controller.level_manager")
local drop_manager = require("controller.drop_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local L2Actor = require("view.Sprite.L2Actor")
local alert_manager = require("controller.alert_manager")
local patrol_manager = require("controller.patrol_manager")
local l2utils = require("controller.l2utils")
local city_data = require("data.city_data")
local chapter_data = require("data.chapter_data")
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local levelmode_data = require("data.levelmode_data")
local var_0_15
local var_0_16 = config._DEBUG and 0 or 1
local var_0_17 = 1
local var_0_18 = 3
local var_0_19 = 2
local var_0_21 = 1
local var_0_22 = 2
local var_0_23 = 1
local var_0_24 = 2
local var_0_25 = {
	5,
	10
}
local var_0_26 = {
	"patrol/btn_easy.png",
	"patrol/btn_hard.png",
	"patrol/btn_hell.png",
	"patrol/btn_nightmare.png"
}

local function var_0_27(arg_2_0)
	return string.format("%02d:%02d:%02d", math.floor(arg_2_0 / 3600), math.floor(arg_2_0 % 3600 / 60), arg_2_0 % 60)
end

function PatrolPopLayer.create(arg_4_0, arg_4_1)
	local var_4_0 = PatrolPopLayer.new()

	var_4_0:init(arg_4_1)

	return var_4_0
end

function PatrolPopLayer.getInstance()
	return var_0_15
end

function PatrolPopLayer:init(arg_6_1)
	var_0_15 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "patrol.json" or "patrol.ExportJson")

	self:addChild(self.rootLayer)
	self.rootLayer:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setLocalZOrder(1)
	LayerManager:createFullScreenMask(self, 200, function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)

	self.inittype = arg_6_1.inittype
	self.callback = arg_6_1.callback
	self.exitCallback = arg_6_1.exitCallback
	self.array = {}

	self:initData(arg_6_1)
	self:initBaseUI()
	self:initTimer()
	self:initDifficultBnt()
	self:initArrayPanel()
	self:initConditionPanel()
	self:initButton()
	level_manager:getChapterPatrolInfo(self.mode, self.chapter, function(arg_9_0)
		self:initDrop(arg_9_0)
	end)
	self:registerScriptHandler(function(arg_10_0)
		if arg_10_0 == "exit" then
			var_0_15 = nil

			if self.exitCallback then
				self.exitCallback()
			end
		end
	end)
end

function PatrolPopLayer:initData(arg_11_1)
	if self.inittype == var_0_23 then
		self.cityid = arg_11_1.cityid
		self.chapter = arg_11_1.chapter
		self.mode = arg_11_1.mode
		self.difficult = level_manager:getDifficultByMode(self.mode)
		self.maxDifficult = self:getUnlockedDifficultyInCity(self.cityid, self.chapter)
	elseif self.inittype == var_0_24 then
		self.mode = arg_11_1.mode
		self.chapter = arg_11_1.chapter
		self.cityid = levelmode_data[self.mode].city
		self.difficult = level_manager:getDifficultByMode(self.mode)
		self.maxDifficult = self:getUnlockedDifficultyInCity(self.cityid, self.chapter)
	end

	self.chapterInfo = chapter_data[self.mode .. "-" .. self.chapter]
	self.stateType = patrol_manager:getPatrolState(self.mode .. "-" .. self.chapter)

	local var_11_0, var_11_1, var_11_2, var_11_3 = patrol_manager:get_patrol_condition(self.mode, self.chapter)

	self.conditions = {
		rank = var_11_0,
		lv = patrol_manager:getShowTotalLevel(self.mode, self.chapter),
		total_num = var_11_2,
		ele = var_11_3
	}
end

function PatrolPopLayer:updateData()
	self.chapterInfo = chapter_data[self.mode .. "-" .. self.chapter]
	self.stateType = patrol_manager:getPatrolState(self.mode .. "-" .. self.chapter)

	local var_12_0, var_12_1, var_12_2, var_12_3 = patrol_manager:get_patrol_condition(self.mode, self.chapter)

	self.conditions = {
		rank = var_12_0,
		lv = patrol_manager:getShowTotalLevel(self.mode, self.chapter),
		total_num = var_12_2,
		ele = var_12_3
	}
	self.array = {}
end

function PatrolPopLayer.dealDataFormate(arg_13_0, arg_13_1)
	if not arg_13_1 then
		return
	end

	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		local var_13_1 = true

		for iter_13_2 = 1, #var_13_0 do
			if iter_13_1.itemid == var_13_0[iter_13_2].itemid then
				var_13_1 = false

				break
			end
		end

		if var_13_1 then
			table.insert(var_13_0, iter_13_1)
		end
	end

	local var_13_2 = {}

	for iter_13_3, iter_13_4 in ipairs(var_13_0) do
		if iter_13_4 and iter_13_4.rare == 1 then
			table.insert(var_13_2, {
				dropid = iter_13_4.itemid,
				dropNum = iter_13_4.count
			})
		end
	end

	return var_13_2
end

function PatrolPopLayer:formatChartEndData(arg_14_1)
	if not arg_14_1 then
		return
	end

	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		local var_14_1 = true

		for iter_14_2 = 1, #var_14_0 do
			if iter_14_1.itemid == var_14_0[iter_14_2].itemid then
				var_14_1 = false

				break
			end
		end

		if var_14_1 then
			table.insert(var_14_0, iter_14_1)
		end
	end

	local var_14_2 = {
		attribute = 1,
		content = {}
	}
	local var_14_3 = {
		attribute = 2,
		content = {}
	}
	local var_14_4 = {
		attribute = 3,
		content = {}
	}
	local var_14_5 = {
		attribute = 4,
		content = {}
	}
	local var_14_6 = {}
	local var_14_7 = {}

	for iter_14_3, iter_14_4 in ipairs(var_14_0) do
		if iter_14_4.rare and iter_14_4.rare == 1 then
			table.insert(var_14_2.content, {
				dropid = iter_14_4.itemid,
				itemid = iter_14_4.itemid
			})
		elseif item_data[iter_14_4.itemid].bag_item_type and item_data[iter_14_4.itemid].bag_item_type == kITEM_MATRIAL then
			table.insert(var_14_4.content, {
				dropid = iter_14_4.itemid,
				itemid = iter_14_4.itemid
			})
		elseif item_data[iter_14_4.itemid].bag_item_type and item_data[iter_14_4.itemid].bag_item_type == kITEM_COMPONENT then
			table.insert(var_14_5.content, {
				dropid = iter_14_4.itemid,
				itemid = iter_14_4.itemid
			})
		else
			table.insert(var_14_3.content, {
				dropid = iter_14_4.itemid,
				itemid = iter_14_4.itemid
			})
		end
	end

	if #var_14_2.content > 0 then
		table.insert(var_14_6, L_FIGHT_RESULT_LEVLE_DROP_DATA.raredata)
		self:sortByQuality(var_14_2.content)
		table.insert(var_14_7, var_14_2)
	end

	if #var_14_3.content > 0 then
		table.insert(var_14_6, L_FIGHT_RESULT_LEVLE_DROP_DATA.commondata)
		self:sortByQuality(var_14_3.content)
		table.insert(var_14_7, var_14_3)
	end

	if #var_14_4.content > 0 then
		table.insert(var_14_6, L_FIGHT_RESULT_LEVLE_DROP_DATA.sciencedata)
		self:sortByQuality(var_14_4.content)
		table.insert(var_14_7, var_14_4)
	end

	if #var_14_5.content > 0 then
		table.insert(var_14_6, L_FIGHT_RESULT_LEVLE_DROP_DATA.componentdata)

		var_14_5.content = self:formatComponentData(var_14_5.content)

		table.insert(var_14_7, var_14_5)
	end

	var_14_7.type_tbl = var_14_6

	return var_14_7
end

function PatrolPopLayer.formatComponentData(arg_15_0, arg_15_1)
	if not arg_15_1 then
		return
	end

	local var_15_2 = {}
	local var_15_3 = {}
	local var_15_4 = {}
	local var_15_5 = {}

	local function var_15_6(arg_16_0)
		if arg_16_0 and #arg_16_0 > 1 then
			table.sort(arg_16_0, function(arg_17_0, arg_17_1)
				return arg_17_0.itemid < arg_17_1.itemid
			end)
		end
	end

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		local var_15_7 = true

		for iter_15_2, iter_15_3 in ipairs(var_15_2) do
			if item_data[iter_15_1.itemid].equip_quality == iter_15_3 then
				var_15_7 = false

				break
			end
		end

		if var_15_7 then
			table.insert(var_15_2, item_data[iter_15_1.itemid].equip_quality)
		end

		local var_15_8 = true
		local var_15_9 = tostring(iter_15_1.itemid)
		local var_15_10 = string.len(var_15_9)
		local var_15_11 = tonumber(string.sub(var_15_9, var_15_10 - 1, var_15_10))

		for iter_15_4, iter_15_5 in ipairs(var_15_5) do
			if var_15_11 == iter_15_5 then
				var_15_8 = false

				break
			end
		end

		if var_15_8 then
			table.insert(var_15_5, var_15_11)
		end
	end

	table.sort(var_15_2, function(arg_18_0, arg_18_1)
		return arg_18_1 < arg_18_0
	end)
	table.sort(var_15_5, function(arg_19_0, arg_19_1)
		return arg_19_1 < arg_19_0
	end)

	for iter_15_6, iter_15_7 in ipairs(var_15_2) do
		local var_15_12 = {}

		for iter_15_8, iter_15_9 in ipairs(arg_15_1) do
			if item_data[iter_15_9.itemid].equip_quality == iter_15_7 then
				table.insert(var_15_12, iter_15_9)
			end
		end

		if #var_15_12 > 0 then
			local var_15_13 = {}

			for iter_15_10, iter_15_11 in ipairs(var_15_5) do
				local var_15_14 = {}

				for iter_15_12, iter_15_13 in ipairs(var_15_12) do
					local var_15_15 = tostring(iter_15_13.itemid)
					local var_15_16 = string.len(var_15_15)

					if tonumber(string.sub(var_15_15, var_15_16 - 1, var_15_16)) == iter_15_11 then
						table.insert(var_15_14, iter_15_13)
					end
				end

				var_15_6(var_15_14)

				var_15_13[iter_15_10] = var_15_14
			end

			var_15_3[iter_15_6] = var_15_13
		end
	end

	for iter_15_14, iter_15_15 in ipairs(var_15_3) do
		for iter_15_16, iter_15_17 in ipairs(iter_15_15) do
			for iter_15_18, iter_15_19 in ipairs(iter_15_17) do
				table.insert(var_15_4, iter_15_19)
			end
		end
	end

	return var_15_4
end

function PatrolPopLayer.sortByQuality(arg_20_0, arg_20_1)
	if arg_20_1 and #arg_20_1 > 1 then
		table.sort(arg_20_1, function(arg_21_0, arg_21_1)
			if item_data[arg_21_0.dropid].equip_quality == item_data[arg_21_1.dropid].equip_quality then
				return arg_21_0.dropid < arg_21_1.dropid
			else
				return item_data[arg_21_0.dropid].equip_quality > item_data[arg_21_1.dropid].equip_quality
			end
		end)
	end
end

function PatrolPopLayer:initChapterLeftTime()
	local var_22_0 = cc.Label:createWithTTF(string.format(L_PATROL_CHAPTER_LEFT, self.patrolLeftTimes), FONT_NAME, 24)

	var_22_0:setAnchorPoint(cc.p(0.5, 1))
	var_22_0:setPosition(self.sureBnt:getPositionX(), self.sureBnt:getPositionY() - self.sureBnt:getContentSize().height / 2)
	self.sureBnt:getParent():addChild(var_22_0)
end

function PatrolPopLayer:initBaseUI()
	self.bg = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg")
	self.title = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_title")
	self.chapterLabel = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_chapter")
	self.timeBg = ccui.Helper:seekWidgetByName(self.rootLayer, "time_bg")
	self.time = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_time")
	self.cover = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_main")
	self.dropList = ccui.Helper:seekWidgetByName(self.rootLayer, "drop_list")
	self.dropBnt = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_drop")
	self.difficultPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_difficult")
	self.quickBnt = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_quick")
	self.cancelBnt = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_cancel")
	self.sureBnt = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure")
	self.arrayPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_spine")
	self.conditionPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_condition")

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_48"):setString(L_PROFALL[1])
	;(function()
		self.title:setString(levelmode_data[self.mode].name)
		self.chapterLabel:setString(chapter_data[self.mode .. "-" .. self.chapter].name)
		self.chapterLabel:setPositionX(self.title:getPositionX() + self.title:getContentSize().width + 5)
	end)()
	;(function()
		if self.stateType == var_0_17 then
			if (self.chapterInfo.patrol_time or 1) >= 1 then
				self.time:setString(L_TIME .. string.format(L_TIME_SINGLE.Hour, self.chapterInfo.patrol_time or 1))
			else
				self.time:setString(L_TIME .. string.format(L_TIME_SINGLE.Minute, (self.chapterInfo.patrol_time or 1) * 60))
			end
		else
			self.time:setString(L_TIME .. var_0_27(patrol_manager:getPatrolInfo(self.mode .. "-" .. self.chapter).time))
		end
	end)()
	;(function()
		self.cover:loadTexture((self.chapterInfo.patrol_img or nil) and ("mainScenebg/chapter_cover/" .. self.chapterInfo.patrol_img .. ".png" or "mainScenebg/chapter_cover/001.png"))
	end)()
end

function PatrolPopLayer:initTimer(arg_27_1)
	self:scheduleUpdateWithPriorityLua(function(arg_28_0)
		local var_28_0 = patrol_manager:getPatrolInfo(self.mode .. "-" .. self.chapter)

		if var_28_0 then
			self.time:setString(L_TIME .. var_0_27(var_28_0.time))

			if var_28_0.time <= 0 and self.stateType ~= var_0_19 then
				self.stateType = var_0_19

				self.sureBnt:loadTextures("patrol/gain_bnt.png", nil, "patrol/gain_bnt.png", var_0_16)
				self.sureBnt:setVisible(true)
				self.cancelBnt:setVisible(false)
				self.quickBnt:setVisible(false)

				for iter_28_0 = 1, #var_28_0.array do
					if self.arrayPanel:getChildByName("spine_bg" .. iter_28_0):getChildByName("spine") then
						self.arrayPanel:getChildByName("spine_bg" .. iter_28_0):getChildByName("spine"):playAni(nil, "idle", true)
					end
				end
			end
		end
	end, 0)
end

function PatrolPopLayer.initDrop(arg_29_0, arg_29_1)
	(function()
		arg_29_0.dropBnt:setTouchEnabled(true)
		arg_29_0.dropBnt:addTouchEventListener(function(arg_31_0, arg_31_1)
			if arg_31_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("DropDetailsLayer", {
				callback = callback,
				category = {
					type = 1
				},
				items_tbl = arg_29_0:formatChartEndData(arg_29_1),
				words_tbl = {
					type_tbl = {}
				}
			})
		end)
	end)()
	;(function()
		arg_29_0.dropList:setItemsMargin(10)

		local var_32_0 = arg_29_0:dealDataFormate(arg_29_1)

		arg_29_0:sortByQuality(var_32_0)

		if var_32_0 then
			local var_32_1 = 1
			local var_32_2 = cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
				if var_32_1 > #var_32_0 then
					arg_29_0:stopActionByTag(var_0_21)

					return
				end

				if var_32_0[var_32_1].dropid then
					local var_33_0 = var_32_0[var_32_1].dropid
					local var_33_1 = ccui.ImageView:create("public/box/" .. item_data[var_32_0[var_32_1].dropid].equip_quality .. ".png", var_0_16)
					local var_33_2

					if item_data[var_32_0[var_32_1].dropid].bag_item_type == kITEM_COMPONENT then
						var_33_2 = require("controller.component_manager"):create_component_icon(item_data[var_32_0[var_32_1].dropid].id)
					else
						assert(item_data[var_32_0[var_32_1].dropid].image_id, item_data[var_32_0[var_32_1].dropid].id)

						var_33_2 = ccui.ImageView:create("equipment/" .. item_data[var_32_0[var_32_1].dropid].image_id .. ".png")
					end

					var_33_2:setScale(80 / var_33_2:getContentSize().width)
					var_33_2:setPosition(var_33_1:getContentSize().width / 2, var_33_1:getContentSize().height / 2)
					var_33_1:addChild(var_33_2)
					var_33_1:setTouchEnabled(true)
					var_33_1:addTouchEventListener(function(arg_34_0, arg_34_1)
						if arg_34_1 ~= ccui.TouchEventType.ended then
							return
						end

						PopLayer:Item({
							itemid = var_33_0,
							removeParentCallback = function()
								arg_29_0:runAction(cc.RemoveSelf:create())
							end
						})
					end)
					arg_29_0.dropList:pushBackCustomItem(var_33_1)
				end

				var_32_1 = var_32_1 + 1
			end)))

			var_32_2:setTag(var_0_21)
			arg_29_0:runAction(var_32_2)
		end
	end)()
end

function PatrolPopLayer:updateDrop()
	local function var_36_0(arg_37_0)
		self.dropBnt:setTouchEnabled(true)
		self.dropBnt:addTouchEventListener(function(arg_38_0, arg_38_1)
			if arg_38_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("DropDetailsLayer", {
				callback = callback,
				category = {
					type = 1
				},
				items_tbl = self:formatChartEndData(arg_37_0),
				words_tbl = {
					type_tbl = {}
				}
			})
		end)
	end

	local function var_36_1(arg_39_0)
		local var_39_0 = self:dealDataFormate(arg_39_0)

		self:sortByQuality(var_39_0)

		if var_39_0 then
			local var_39_2 = 1
			local var_39_3 = cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
				if var_39_2 > #var_39_0 then
					self:stopActionByTag(var_0_21)

					return
				end

				if var_39_0[var_39_2].dropid then
					local var_40_0 = var_39_0[var_39_2].dropid
					local var_40_1 = ccui.ImageView:create("public/box/" .. item_data[var_39_0[var_39_2].dropid].equip_quality .. ".png", var_0_16)
					local var_40_2

					if item_data[var_39_0[var_39_2].dropid].bag_item_type == kITEM_COMPONENT then
						var_40_2 = require("controller.component_manager"):create_component_icon(item_data[var_39_0[var_39_2].dropid].id)
					else
						assert(item_data[var_39_0[var_39_2].dropid].image_id, item_data[var_39_0[var_39_2].dropid].id)

						var_40_2 = ccui.ImageView:create("equipment/" .. item_data[var_39_0[var_39_2].dropid].image_id .. ".png")
					end

					var_40_2:setScale(80 / var_40_2:getContentSize().width)
					var_40_2:setPosition(var_40_1:getContentSize().width / 2, var_40_1:getContentSize().height / 2)
					var_40_1:addChild(var_40_2)
					var_40_1:setTouchEnabled(true)
					var_40_1:addTouchEventListener(function(arg_41_0, arg_41_1)
						if arg_41_1 ~= ccui.TouchEventType.ended then
							return
						end

						PopLayer:Item({
							itemid = var_40_0,
							removeParentCallback = function()
								self:runAction(cc.RemoveSelf:create())
							end
						})
					end)
					self.dropList:pushBackCustomItem(var_40_1)
				end

				var_39_2 = var_39_2 + 1
			end)))

			var_39_3:setTag(var_0_21)
			self:runAction(var_39_3)
		end
	end

	self.dropBnt:setTouchEnabled(false)
	self:stopActionByTag(var_0_21)
	self.dropList:removeAllChildren()
	level_manager:getChapterPatrolInfo(self.mode, self.chapter, function(arg_43_0)
		var_36_0(arg_43_0)
		var_36_1(arg_43_0)
	end)
end

function PatrolPopLayer:initDifficultBnt()
	self.difficultBnts = {}

	for iter_44_0 = 1, self.maxDifficult do
		local var_44_0 = ccui.Button:create(var_0_26[iter_44_0], nil, var_0_26[iter_44_0], var_0_16)

		var_44_0:setPosition((iter_44_0 - (self.maxDifficult + 1) / 2) * 130 + self.difficultPanel:getContentSize().width / 2, self.difficultPanel:getContentSize().height / 2)
		var_44_0:setTouchEnabled(self.stateType == var_0_17)
		self.difficultPanel:addChild(var_44_0)

		self.difficultBnts[iter_44_0] = var_44_0

		if iter_44_0 ~= self.difficult then
			l2utils:shaderNode(var_44_0:getVirtualRenderer())
		end

		var_44_0:addTouchEventListener(function(arg_45_0, arg_45_1)
			if arg_45_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:switchDifficult(iter_44_0)
		end)
	end
end

function PatrolPopLayer:initButton()
	local var_46_0

	if self.stateType == var_0_17 then
		var_46_0 = "patrol/go_bnt.png"

		self.quickBnt:setVisible(true)
		self.cancelBnt:setVisible(true)
		self.sureBnt:setVisible(false)
		self.quickBnt:setTitleText(L_PATROL_BTN[self.stateType].quick)
		self.cancelBnt:setTitleText(L_PATROL_BTN[self.stateType].cancel)
	elseif self.stateType == var_0_19 then
		var_46_0 = "patrol/gain_bnt.png"

		self.quickBnt:setVisible(false)
		self.cancelBnt:setVisible(false)
		self.sureBnt:setVisible(true)
	elseif self.stateType == var_0_18 then
		var_46_0 = "patrol/stop_bnt.png"

		self.quickBnt:setVisible(true)
		self.cancelBnt:setVisible(true)
		self.sureBnt:setVisible(false)
		self.quickBnt:setTitleText(L_PATROL_BTN[self.stateType].quick)
		self.cancelBnt:setTitleText(L_PATROL_BTN[self.stateType].cancel)
	end

	self.sureBnt:loadTextures(var_46_0, nil, var_46_0, var_0_16)
	self.sureBnt:addTouchEventListener(function(arg_47_0, arg_47_1)
		if arg_47_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_47_0.isLock then
			return
		end

		arg_47_0.isLock = true

		local function var_47_0()
			arg_47_0.isLock = false

			alert_manager:check_weapon_update(false)
			alert_manager:check_component_update(false)
		end

		if self.stateType == var_0_17 then
			self:goPatrol(var_47_0)
		else
			self:backPatrol(var_47_0)
		end
	end)
	self.quickBnt:addTouchEventListener(function(arg_49_0, arg_49_1)
		if arg_49_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_49_0.isLock then
			return
		end

		arg_49_0.isLock = true

		local function var_49_0()
			arg_49_0.isLock = false

			alert_manager:check_weapon_update(false)
			alert_manager:check_component_update(false)
		end

		if self.stateType == var_0_17 then
			self:goPatrol(var_49_0)
		else
			self:backPatrol(var_49_0)
		end
	end)
	self.cancelBnt:addTouchEventListener(function(arg_51_0, arg_51_1)
		if arg_51_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_51_0.isLock then
			return
		end

		arg_51_0.isLock = true

		local function var_51_0()
			arg_51_0.isLock = false

			alert_manager:check_weapon_update(false)
			alert_manager:check_component_update(false)
		end

		if self.stateType == var_0_18 then
			self:cancelPatrol(var_51_0)
		elseif self.stateType == var_0_17 then
			if #self.array > 0 then
				self:unDoOnekey(var_51_0)
			else
				self:selectOnekey(var_51_0)
			end

			arg_51_0.isLock = false
		end
	end)
end

function PatrolPopLayer:initConditionPanel()
	if self.stateType == var_0_17 then
		self.conditionPanel:setVisible(true)
		self:updateConditionPanel()
	else
		self.conditionPanel:setVisible(false)
	end
end

function PatrolPopLayer:updateConditionPanel()
	local var_54_0 = self.conditionPanel:getChildByName("Label_num")
	local var_54_1 = self.conditionPanel:getChildByName("lv_ele")
	local var_54_2 = self.conditionPanel:getChildByName("lv_bg")

	var_54_2:getChildByName("Label_lv"):setString("Lv:" .. self.conditions.lv)
	var_54_2:getChildByName("role_break_icon"):loadTexture("public/rolebg/breakout_" .. self.conditions.rank .. ".png", var_0_16)
	var_54_1:getChildByName("Image_ele"):loadTexture("public/career_icon/" .. self.conditions.ele .. ".png", var_0_16)
	var_54_1:getChildByName("Label_ele"):setString(L_SORT_ATTR[({
		wind = 1,
		water = 3,
		fire = 2,
		light = 4,
		dark = 5
	})[self.conditions.ele]])

	local var_54_3 = 0

	for iter_54_0, iter_54_1 in pairs(self.array) do
		if patrol_manager:check_core_lv(self.mode, self.chapter, iter_54_1) then
			var_54_3 = var_54_3 + 1
		end
	end

	var_54_0:setString(var_54_3 .. "/" .. self.conditions.total_num)

	if var_54_3 >= self.conditions.total_num then
		var_54_0:setColor(cc.c3b(166, 226, 45))
	else
		var_54_0:setColor(cc.c3b(248, 51, 51))
	end

	if self.stateType == var_0_17 then
		if #self.array > 0 then
			self.cancelBnt:setTitleText(L_PATROL_BTN[self.stateType].reset)
		else
			self.cancelBnt:setTitleText(L_PATROL_BTN[self.stateType].cancel)
		end
	end
end

function PatrolPopLayer:initArrayPanel()
	self.arraySprite = {}

	local function var_55_0(arg_56_0)
		for iter_56_0 = 1, arg_56_0 do
			local var_56_0

			if iter_56_0 == 1 then
				var_56_0 = self.arrayPanel:getChildByName("spine_bg")
			else
				var_56_0 = self.arraySprite[1]:clone()

				self.arrayPanel:addChild(var_56_0)
			end

			var_56_0:setName("spine_bg" .. iter_56_0)
			var_56_0:setPositionX(297 + (iter_56_0 - (self.conditions.total_num + 1) / 2) * var_56_0:getBoundingBox().width)

			self.arraySprite[iter_56_0] = var_56_0
			self.arraySprite[iter_56_0].index = iter_56_0

			ccui.Helper:seekWidgetByName(var_56_0, "Button_levelup"):addTouchEventListener(function(arg_57_0, arg_57_1)
				if arg_57_1 ~= ccui.TouchEventType.ended then
					return
				end

				local var_57_0 = {}

				for iter_57_0, iter_57_1 in pairs(self.arraySprite) do
					table.insert(var_57_0, ccui.Helper:seekWidgetByName(iter_57_1, "Button_levelup").servantid)
				end

				LayerManager:pushInLayer("SoulStrengthLayer", {
					servantid = arg_57_0.servantid,
					topServants = var_57_0,
					exitCallback = function(...)
						self:updateArrayPanel()
						self:updateConditionPanel()
					end
				})
			end)
		end
	end

	if self.stateType == var_0_17 then
		(function()
			local function var_61_0(arg_62_0)
				if next((patrol_manager:getArrayonekey(self.mode, self.chapter))) == nil then
					return
				end

				local var_62_0 = {}

				for iter_62_0, iter_62_1 in pairs(self.array) do
					table.insert(var_62_0, iter_62_1)
				end

				LayerManager:pushInLayer("PatrolGirlSelectLayer", {
					patrol_conditions = self.conditions,
					servants = var_62_0,
					sureCallback = function(arg_63_0)
						self.array[arg_62_0] = arg_63_0

						self:updateArrayPanel()
						self:updateConditionPanel()
					end
				})
			end

			var_55_0(self.conditions.total_num)

			for iter_61_0 = 1, self.conditions.total_num do
				local var_61_1 = self.arraySprite[iter_61_0]:getChildByName("Button_add")

				var_61_1.index = iter_61_0

				self.arraySprite[iter_61_0]:getChildByName("name_bg"):setVisible(false)
				var_61_1:addTouchEventListener(function(arg_64_0, arg_64_1)
					if arg_64_1 ~= ccui.TouchEventType.ended then
						return
					end

					if arg_64_0.servantid and not patrol_manager:check_core_lv(self.mode, self.chapter, arg_64_0.servantid) then
						LayerManager:pushInLayer("SoulStrengthLayer", {
							servantid = arg_64_0.servantid,
							exitCallback = function(...)
								self:updateArrayPanel()
								self:updateConditionPanel()
							end
						})
					else
						var_61_0(arg_64_0:getParent().index)
					end
				end)
			end

			self:updateArrayPanel()
		end)()
	else
		(function()
			local var_59_0 = patrol_manager:getPatrolInfo(self.mode .. "-" .. self.chapter)

			var_55_0(#var_59_0.array)

			for iter_59_0 = 1, #var_59_0.array do
				self.arraySprite[iter_59_0]:setVisible(false)
			end

			local var_59_1 = 1
			local var_59_2 = cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
				if not var_59_0.array[var_59_1] then
					self:stopActionByTag(var_0_22)

					return
				end

				if var_59_0.array[var_59_1] then
					local var_60_0 = var_59_0.array[var_59_1]
					local var_60_1 = global_get_servant_skin(var_59_0.array[var_59_1])
					local var_60_2 = 0.3
					local var_60_3 = cc.size(model_data[var_60_1].modelweight, model_data[var_60_1].modelheight)
					local var_60_4 = L2Actor:create(ROLE_SPINE_PATH .. model_data[var_60_1].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_60_1].spine_model .. ".atlas", (model_data[var_60_1].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[var_60_1].clothes_model .. ".atlas" or nil))

					var_60_4:setName("spine")
					var_60_4:setScale(var_60_2, var_60_2)

					if self.stateType == var_0_19 then
						var_60_4:playAni(nil, "idle", true)
					elseif self.stateType == var_0_18 then
						var_60_4:playAni(nil, "run", true)
					end

					var_60_4:setContentSize(var_60_3)

					var_60_4.servantid = var_60_0

					self.arraySprite[var_59_1]:setVisible(true)
					var_60_4:setPosition(self.arraySprite[var_59_1]:getContentSize().width / 2, self.arraySprite[var_59_1]:getContentSize().height / 2 - 20)
					self.arraySprite[var_59_1]:addChild(var_60_4)
					ccui.Helper:seekWidgetByName(self.arraySprite[var_59_1], "name"):setString((string.gsub(string.gsub(servant_data[var_60_0].name, "【", ""), "】", "")))
				else
					self.arrayPanel:getChildByName("spine_bg" .. var_59_1):setVisible(false)
				end

				var_59_1 = var_59_1 + 1
			end)))

			var_59_2:setTag(var_0_22)
			self:runAction(var_59_2)
			self.sureBnt:getChildByName("effect"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(1), cc.FadeIn:create(1))))

			if self.stateType == var_0_19 then
				self.sureBnt:getChildByName("effect"):setVisible(true)
			elseif self.stateType == var_0_18 then
				self.sureBnt:getChildByName("effect"):setVisible(false)
			end
		end)()
	end
end

function PatrolPopLayer:updateArrayPanel()
	for iter_66_0 = 1, self.conditions.total_num do
		if not self.arraySprite[iter_66_0] then
			self.arraySprite[iter_66_0] = self.arraySprite[1]:clone()

			self.arraySprite[iter_66_0]:setName("spine_bg" .. iter_66_0)
			self.arrayPanel:addChild(self.arraySprite[iter_66_0])
		end

		self.arraySprite[iter_66_0].index = iter_66_0

		self.arraySprite[iter_66_0]:setPositionX(297 + (iter_66_0 - (self.conditions.total_num + 1) / 2) * self.arraySprite[iter_66_0]:getBoundingBox().width)

		local var_66_0 = self.arraySprite[iter_66_0]:getChildByName("Button_add")
		local var_66_1 = self.arraySprite[iter_66_0]:getChildByName("role_img")
		local var_66_2 = self.arraySprite[iter_66_0]:getChildByName("name_bg")
		local var_66_3 = self.arraySprite[iter_66_0]:getChildByName("Button_levelup")

		var_66_0.servantid = nil

		if self.array[iter_66_0] then
			local var_66_4 = self.array[iter_66_0]

			if not var_66_1 then
				var_66_1 = self:createQimg(var_66_4)

				var_66_1:setPosition(self.arraySprite[iter_66_0]:getContentSize().width / 2, self.arraySprite[iter_66_0]:getContentSize().height / 2 - 10)
				self.arraySprite[iter_66_0]:addChild(var_66_1)
			else
				var_66_1:updateImg(var_66_4)
			end

			var_66_0.servantid = var_66_4

			var_66_0:setOpacity(0)
			var_66_2:setVisible(true)
			var_66_2:getChildByName("name"):setString((string.gsub(string.gsub(servant_data[var_66_4].name, "【", ""), "】", "")))

			if patrol_manager:check_core_lv(self.mode, self.chapter, var_66_4) then
				var_66_2:getChildByName("name"):setColor(cc.c3b(114, 219, 255))
				var_66_3:setVisible(false)
				var_66_2:loadTexture("patrol/spine_name_bg.png", var_0_16)
				self.arraySprite[iter_66_0]:loadTexture("patrol/spine_bg.png", var_0_16)
			else
				var_66_2:getChildByName("name"):setColor(cc.c3b(246, 40, 83))
				var_66_3:setVisible(true)

				var_66_3.servantid = var_66_4

				var_66_2:loadTexture("patrol/spine_name_bg_not_enough.png", var_0_16)
				self.arraySprite[iter_66_0]:loadTexture("patrol/spine_bg_not_enough.png", var_0_16)
			end
		else
			if var_66_1 then
				var_66_1:removeFromParent()
			end

			var_66_0:setOpacity(255)
			var_66_2:setVisible(false)
			var_66_3:setVisible(false)
			self.arraySprite[iter_66_0]:loadTexture("patrol/spine_bg.png", var_0_16)
		end
	end

	if #self.arraySprite > self.conditions.total_num then
		for iter_66_1 = self.conditions.total_num + 1, #self.arraySprite do
			self.arraySprite[iter_66_1]:removeFromParent()

			self.arraySprite[iter_66_1] = nil
		end
	end
end

function PatrolPopLayer:createSpine(arg_67_1)
	local var_67_0 = global_get_servant_skin(arg_67_1)
	local var_67_1 = 0.3
	local var_67_2 = cc.size(model_data[var_67_0].modelweight, model_data[var_67_0].modelheight)
	local var_67_3 = L2Actor:create(ROLE_SPINE_PATH .. model_data[var_67_0].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_67_0].spine_model .. ".atlas", (model_data[var_67_0].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[var_67_0].clothes_model .. ".atlas" or nil))

	var_67_3:setName("spine")
	var_67_3:setScale(var_67_1, var_67_1)

	if self.stateType == var_0_19 then
		var_67_3:playAni(nil, "idle", true)
	elseif self.stateType == var_0_18 then
		var_67_3:playAni(nil, "run", true)
	end

	var_67_3:setContentSize(var_67_2)

	var_67_3.servantid = arg_67_1

	return var_67_3
end

function PatrolPopLayer.createQimg(arg_68_0, arg_68_1)
	local var_68_0 = cc.Sprite:create(CUTE_ROLE_IMAGE_PATH .. model_data[global_get_servant_skin(arg_68_1)].cute_role .. ".png")

	var_68_0:setAnchorPoint(0.5, 0)
	var_68_0:setName("role_img")
	var_68_0:setScale(0.4)

	var_68_0.servantid = arg_68_1

	function var_68_0:updateImg(arg_69_1)
		if self.servantid == arg_69_1 then
			return
		end

		self.servantid = arg_69_1

		self:setTexture(CUTE_ROLE_IMAGE_PATH .. model_data[global_get_servant_skin(arg_69_1)].cute_role .. ".png")
	end

	return var_68_0
end

function PatrolPopLayer:switchDifficult(arg_70_1)
	if self.difficult == arg_70_1 then
		return
	end

	local var_70_0 = self.difficult

	self.difficult = arg_70_1
	self.mode = city_data[self.cityid]["difficulty" .. self.difficult]

	for iter_70_0, iter_70_1 in pairs(self.difficultBnts) do
		if iter_70_0 == self.difficult then
			l2utils:recoverShader(iter_70_1:getVirtualRenderer())
		elseif iter_70_0 == var_70_0 then
			l2utils:shaderNode(iter_70_1:getVirtualRenderer())
		end
	end

	self:updateData()
	self:updateArrayPanel()
	self:updateDrop()
	self:updateConditionPanel()
end

function PatrolPopLayer:goPatrol(arg_71_1)
	patrol_manager:beginPatrol(self.mode, self.chapter, self.array, function(arg_72_0)
		if arg_72_0 == 1 then
			LayerManager:removePopLayer(self.__queueindex)

			if self.callback then
				self.callback()
			end
		end

		if arg_71_1 then
			arg_71_1()
		end
	end)
end

function PatrolPopLayer:backPatrol(arg_73_1)
	local function var_73_0()
		patrol_manager:finishPatrol(self.mode, self.chapter, function(arg_75_0)
			LayerManager:removePopLayer(self.__queueindex)

			if arg_73_1 then
				arg_73_1()
			end

			if self.callback then
				self.callback("finish")
			end
		end)
	end

	local var_73_1 = patrol_manager:getPatrolInfo(self.mode .. "-" .. self.chapter)

	if var_73_1.time <= 0 then
		var_73_0()
	else
		local var_73_2 = math.ceil(var_73_1.time / 360)

		LayerManager:pushInLayer("PopDoLayer", {
			costtype = "diamond",
			surecallback = var_73_0,
			cancelcallback = function()
				if arg_73_1 then
					arg_73_1()
				end
			end,
			own = playermodel.diamond,
			cost = var_73_2,
			labels = {
				titleNewImage = "public/title/quikc_complete_patrol.png",
				title = L_PATROL_QUICK_MSG.title,
				des = string.format(L_PATROL_QUICK_MSG.des, var_73_2),
				button = L_PATROL_QUICK_MSG.button
			}
		})
	end
end

function PatrolPopLayer.cancelPatrol(arg_77_0, arg_77_1)
	LayerManager:pushInLayer("PopDoLayer", {
		surecallback = function()
			patrol_manager:cancelPatrol(arg_77_0.mode, arg_77_0.chapter, function(arg_79_0)
				LayerManager:removePopLayer(arg_77_0.__queueindex)

				if arg_77_1 then
					arg_77_1()
				end

				if arg_77_0.callback then
					arg_77_0.callback("cancel")
				end
			end)
		end,
		cancelcallback = function()
			if arg_77_1 then
				arg_77_1()
			end
		end,
		labels = {
			titleNewImage = "public/title/title_recall_team.png",
			title = L_TEAM_Array_WARNING.Type_HangUp[0].title,
			des = L_TEAM_Array_WARNING.Type_HangUp[0].des,
			button = L_TEAM_Array_WARNING.Type_HangUp[0].button
		}
	})
end

function PatrolPopLayer:selectOnekey()
	self.array = patrol_manager:getArrayonekey(self.mode, self.chapter)

	self:updateArrayPanel()
	self:updateConditionPanel()
end

function PatrolPopLayer:unDoOnekey()
	self.array = {}

	self:updateArrayPanel()
	self:updateConditionPanel()
end

function PatrolPopLayer.exit(arg_83_0)
	LayerManager:removePopLayer()
end

function PatrolPopLayer.getUnlockedDifficultyInCity(arg_84_0, arg_84_1, arg_84_2)
	local var_84_0 = 1

	while city_data[arg_84_1]["difficulty" .. 1] do
		local var_84_1

		if not level_manager:isModeManualLocked(city_data[arg_84_1]["difficulty" .. 1]) and level_manager:isChapterPass(city_data[arg_84_1]["difficulty" .. 1], arg_84_2 or var_0_25[1]) then
			var_84_0 = 1
			var_84_1 = 1 + 1
		else
			break
		end
	end

	return var_84_0
end
