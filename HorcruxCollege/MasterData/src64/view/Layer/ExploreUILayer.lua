ExploreUILayer = class("ExploreUILayer", function()
	return cc.Layer:create()
end)

local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local favor_data = require("data.favor_data")
local explore_buff_data = require("data.explore.explore_buff_data")
local explore_sellbuff_data = require("data.explore.explore_sellbuff_data")
local total_skill_data = require("data.total_skill_data")
local skill_data = require("data.skill_data")
local explore_sellweapon_data = require("data.explore.explore_sellweapon_data")
local explore_weapon_data = require("data.explore.explore_weapon_data")
local explore_map_config_data = require("data.explore.explore_map_config_data")
local servant_data = require("data.servant_data")
local plot_data = require("data.plot_data")
local plot_class_data = require("data.plot_class_data")
local L2Actor = require("view.Sprite.L2Actor")
local explore_manager = require("controller.explore_manager")
local weapon_manager = require("controller.weapon_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local core_manager = require("controller.core_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local audio_manager = require("controller.audio_manager")
local l2utils = require("controller.l2utils")
local var_0_24 = config._DEBUG and 0 or 1
local var_0_25
local var_0_26 = 4000001
local var_0_27 = {
	wind = "public/part_bg/shuxing/wind_long.png",
	water = "public/part_bg/shuxing/water_long.png",
	fire = "public/part_bg/shuxing/fire_long.png",
	light = "public/part_bg/shuxing/light_long.png",
	dark = "public/part_bg/shuxing/dark_long.png"
}
local var_0_28 = {
	"explore/san_nothing.png",
	"explore/san_less.png",
	"explore/san_many.png",
	"explore/san_full.png"
}
local var_0_29 = {
	cc.p(336, 873),
	cc.p(147, 688),
	cc.p(464, 630),
	cc.p(49, 461),
	cc.p(409, 405),
	(cc.p(-25, 255))
}

function ExploreUILayer.create(arg_2_0)
	local var_2_0 = ExploreUILayer.new()

	var_2_0:init()

	return var_2_0
end

function ExploreUILayer.getInstance(arg_3_0)
	return ExploreUILayerInstance
end

function ExploreUILayer:init(arg_4_1)
	var_0_25 = self
	explore_manager.curLayerName = ""

	self:initUI()
	explore_manager:getCurExploreConfig(function(arg_5_0)
		local var_5_0 = ccui.Layout:create()

		var_5_0:setContentSize(cc.size(640, 1136))
		var_5_0:setTouchEnabled(true)
		self:addChild(var_5_0, 999)

		explore_manager.exploreConfigs[201] = {
			mapfloor = 0,
			maptype = 201,
			maplevel = 6,
			order = 6
		}

		if arg_5_0 then
			self:initMapList()
			self:switchMapType()
			self:popExploreDifficult(arg_5_0)
			var_5_0:runAction(cc.RemoveSelf:create())
		else
			self:initMapList()
			self.selectPanel:setVisible(true)
			var_5_0:runAction(cc.RemoveSelf:create())
		end
	end)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_25 = nil
		end
	end)
end

function ExploreUILayer:initUI()
	self.selectPanel = ccui.Layout:create()

	self.selectPanel:setVisible(false)
	self.selectPanel:setContentSize(cc.size(640, 1136))
	self.selectPanel:setBackGroundImage("mainScenebg/explore/explore_bg.jpg")
	self:addChild(self.selectPanel)

	for iter_7_0, iter_7_1 in pairs(explore_map_config_data) do
		local var_7_0 = ccui.ImageView:create("explore/map_point.png", var_0_24)

		var_7_0:setName("point" .. iter_7_0)
		var_7_0:setPosition(var_0_29[iter_7_1.order])
		self.selectPanel:addChild(var_7_0)

		local var_7_1 = ccui.Button:create("explore/" .. explore_map_config_data[iter_7_0].cover .. ".png", nil, "explore/" .. explore_map_config_data[iter_7_0].cover .. ".png", var_0_24)

		var_7_1:setName("cover" .. iter_7_0)
		var_7_1:setAnchorPoint(cc.p(0, 1))
		var_7_1:setPosition(var_0_29[iter_7_1.order].x + 20, var_0_29[iter_7_1.order].y + var_7_0:getContentSize().height / 2)
		self.selectPanel:addChild(var_7_1)
	end

	local var_7_2 = ccui.Button:create("EquipLayer/tips_off.png", "EquipLayer/tips_on.png", "EquipLayer/tips_off.png", var_0_24)

	var_7_2:setAnchorPoint(cc.p(1, 1))
	var_7_2:setPosition(640, 1000)
	self.selectPanel:addChild(var_7_2)
	var_7_2:addTouchEventListener(function(arg_8_0, arg_8_1)
		local var_8_0

		if arg_8_1 ~= ccui.TouchEventType.ended then
			do return end

			var_8_0 = {}
		end

		var_8_0.tips = {
			"mainScenebg/guide/5.jpg",
			"mainScenebg/guide/6.jpg",
			"mainScenebg/guide/7.jpg",
			"mainScenebg/guide/13.jpg"
		}

		LayerManager:pushInLayer("TipsLayer", var_8_0)
	end)

	self.auto_exploreBnt = ccui.Button:create("explore/auto_explore.png", nil, "explore/auto_explore.png", var_0_24)

	self.auto_exploreBnt:setPosition(570, 160)
	self.selectPanel:addChild(self.auto_exploreBnt)

	self.auto_explore_num = cc.Label:createWithTTF("×" .. item_manager:getItemNumber(1749901), FONT_NAME, 20)

	self.auto_explore_num:setPosition(102, 105)
	self.auto_exploreBnt:addChild(self.auto_explore_num)
	self.auto_exploreBnt:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_9_0:setTouchEnabled(false)
		self:popAutoExplore(function()
			arg_9_0:setTouchEnabled(true)
		end)
	end)

	local var_7_3 = ccui.Button:create("explore/shop_img.png", nil, "explore/shop_img.png", var_0_24)

	var_7_3:setAnchorPoint(cc.p(0, 1))
	var_7_3:setPosition(0, 1020)
	self.selectPanel:addChild(var_7_3)
	var_7_3:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_11_0 = cc.EventCustom:new("switchShowLayer")

		var_11_0.layerName = "MarketLayer"
		var_11_0.initparam = {
			showType = "1-7",
			returnLayer = "ExploreMapLayer"
		}

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_11_0)
	end)
end

function ExploreUILayer:initMapList()
	for iter_12_0, iter_12_1 in pairs(explore_map_config_data) do
		if explore_manager.exploreConfigs[iter_12_0] then
			local var_12_0 = explore_manager.exploreConfigs[iter_12_0]
			local var_12_1

			if self.selectPanel:getChildByName("point" .. iter_12_0) then
				var_12_1 = self.selectPanel:getChildByName("point" .. iter_12_0)
			else
				var_12_1 = ccui.ImageView:create("explore/map_point.png", var_0_24)

				var_12_1:setName("point" .. iter_12_0)
				var_12_1:setPosition(var_0_29[var_12_0.order])
				self.selectPanel:addChild(var_12_1)
			end

			local var_12_2

			if self.selectPanel:getChildByName("cover" .. iter_12_0) then
				var_12_2 = self.selectPanel:getChildByName("cover" .. iter_12_0)
			else
				var_12_2:setName("cover" .. iter_12_0)
				var_12_2:setAnchorPoint(cc.p(0, 1))
				var_12_2:setPosition(var_0_29[var_12_0.order].x + 20, var_0_29[var_12_0.order].y + var_12_1:getContentSize().height / 2)
				self.selectPanel:addChild(var_12_2)
			end

			local var_12_3 = cc.Label:createWithTTF(explore_map_config_data[iter_12_0].name, FONT_NAME, 22)

			var_12_3:setPosition(cc.p(77, 20))
			var_12_2:addChild(var_12_3)

			if explore_manager:check_is_unlock(iter_12_0) then
				var_12_2:setOpacity(100)
			else
				var_12_2:setOpacity(255)
			end

			if explore_map_config_data[iter_12_0].ele then
				local var_12_4 = ccui.ImageView:create("explore/" .. explore_map_config_data[iter_12_0].ele .. "_tips.png", var_0_24)

				var_12_4:setAnchorPoint(cc.p(0, 1))
				var_12_4:setPosition(20, var_12_2:getContentSize().height - 6)
				var_12_2:addChild(var_12_4)
			end

			var_12_2:addTouchEventListener(function(arg_13_0, arg_13_1)
				if arg_13_1 ~= ccui.TouchEventType.ended then
					return
				end

				local var_13_0 = explore_manager:check_is_unlock(iter_12_0)

				if var_13_0 then
					global_ShowBlockWords(var_13_0)

					return
				end

				self:popExploreDifficult(iter_12_0)
			end)
		else
			if self.selectPanel:getChildByName("point" .. iter_12_0) then
				self.selectPanel:getChildByName("point" .. iter_12_0):setVisible(false)
			end

			if self.selectPanel:getChildByName("cover" .. iter_12_0) then
				self.selectPanel:getChildByName("cover" .. iter_12_0):setVisible(false)
			end
		end
	end

	LayerManager:getPlotObj():updatePlotRemind("ExploreMapLayer")
end

function ExploreUILayer:popExploreDifficult(arg_14_1)
	local var_14_0 = ccui.Layout:create()

	var_14_0:setContentSize(cc.size(640, 1136))
	var_14_0:setTouchEnabled(true)
	var_14_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_14_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_14_0:setBackGroundColorOpacity(245)
	var_14_0:setCascadeOpacityEnabled(false)
	self.selectPanel:addChild(var_14_0, 999)

	var_14_0.maptype = arg_14_1
	self.isPopExploreDifficult = var_14_0

	local var_14_1, var_14_2 = explore_manager:getMapDifficults(arg_14_1)
	local var_14_3 = ccui.Button:create("explore/select_return.png", nil, "explore/select_return.png", var_0_24)

	var_14_3:setAnchorPoint(cc.p(1, 0))
	var_14_3:setPosition(640, 80)
	var_14_0:addChild(var_14_3, 1)
	var_14_3:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_14_0:runAction(cc.RemoveSelf:create())
		LayerManager:getPlotObj():exploreUpdatePlotShow("ExploreMapLayer")

		self.isPopExploreDifficult = false
	end)

	local var_14_4 = ccui.ScrollView:create()

	var_14_4:setContentSize(cc.size(640, 900))
	var_14_4:setName("scrollView")
	var_14_4:setInnerContainerSize(cc.size(640, 240 * var_14_2))
	var_14_4:setAnchorPoint(cc.p(0, 0))
	var_14_4:setPosition(0, 80)
	var_14_0:addChild(var_14_4)

	if explore_manager.exploreConfigs[arg_14_1].endtime then
		local var_14_5 = explore_manager.exploreConfigs[arg_14_1].endtime - os.time()
		local var_14_6 = cc.Label:createWithTTF(L_REST .. string.format(L_TIME_TEXT[1], math.floor(var_14_5 / 86400), math.floor(var_14_5 % 86400 / 3600)), FONT_TITLE, 28)

		var_14_6:setAnchorPoint(cc.p(0, 0.5))
		var_14_6:setPosition(290, 1006)

		var_14_0.timeLabel = var_14_6

		var_14_0:addChild(var_14_6, 1)
	end

	local var_14_7 = ccui.ImageView:create("explore/city_name" .. arg_14_1 .. ".png", var_0_24)

	var_14_7:setAnchorPoint(cc.p(0, 0.5))
	var_14_7:setPosition(10, 1006)
	var_14_0:addChild(var_14_7)

	local var_14_8 = ccui.ImageView:create("explore/city_name_bg.png", var_0_24)

	var_14_8:setPosition(var_14_7:getContentSize().width / 2, var_14_7:getContentSize().height / 2)
	var_14_7:addChild(var_14_8, -1)

	local var_14_9 = ccui.ImageView:create("equipment/" .. item_data[var_0_26].image_id .. ".png")

	var_14_9:setScale(0.4)
	var_14_9:setPosition(180, 1006)
	var_14_0:addChild(var_14_9)
	var_14_9:setTouchEnabled(true)
	var_14_9:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_16_0 = {
			goto_back_system_id = 10000
		}

		if item_manager:haveItem(var_0_26) then
			var_16_0.entityid = var_0_26 or nil
		end

		var_16_0.itemid = var_0_26

		var_14_0:addChild(PopLayer:Item(var_16_0), 900)
	end)

	local var_14_10 = cc.Label:createWithTTF("×" .. item_manager:getItemNumber(var_0_26), FONT_DES, 24)

	var_14_10:setAnchorPoint(cc.p(0, 0.5))
	var_14_10:setPosition(var_14_9:getPositionX() + var_14_9:getBoundingBox().width / 2, var_14_9:getPositionY())
	var_14_0:addChild(var_14_10)

	function var_14_0.updateUI(arg_17_0)
		var_14_10:setString("×" .. item_manager:getItemNumber(var_0_26))

		for iter_17_0, iter_17_1 in ipairs(var_14_1[var_14_4.difficult]) do
			if var_14_4:getChildByName("coverBg" .. iter_17_1.mapfloor):getChildByName("coverBnt" .. iter_17_1.mapfloor) then
				if iter_17_1.mapfloor <= (explore_manager.exploreConfigs[arg_14_1].maplevel or 0) then
					var_14_4:getChildByName("coverBg" .. iter_17_1.mapfloor):getChildByName("coverBnt" .. iter_17_1.mapfloor):setOpacity(255)
				else
					var_14_4:getChildByName("coverBg" .. iter_17_1.mapfloor):getChildByName("coverBnt" .. iter_17_1.mapfloor):setOpacity(100)
				end
			end

			if iter_17_1.starttime and iter_17_0 > 1 then
				if var_14_1[var_14_4.difficult][iter_17_0].mapfloor == (explore_manager.exploreConfigs[arg_14_1].maplevel or 0) then
					local var_17_2 = var_14_4:getChildByName("coverBg" .. iter_17_1.mapfloor):getChildByName("coverBnt" .. iter_17_1.mapfloor)

					if os.time() >= os.time(parse_time(iter_17_1.starttime)) then
						var_17_2:setOpacity(255)
					else
						var_17_2:setOpacity(100)

						local var_17_3 = os.time(parse_time(iter_17_1.starttime)) - os.time()

						if not var_14_4:getChildByName("coverBg" .. iter_17_1.mapfloor):getChildByName("floortime") then
							local var_17_5 = cc.Label:createWithTTF(string.format(L_ACTIVITY_EXPLORE_START, var_17_3 > 86400 and string.format(L_TIME_FORMAT_DAYNHOUR, math.floor(var_17_3 / 86400), math.floor(var_17_3 % 86400 / 3600)) or string.format(L_TIME_FORMAT[2], math.floor(var_17_3 / 3600), math.floor(var_17_3 % 3600 / 60))), FONT_NAME, 30)

							var_17_5:setPosition(var_17_2:getPositionX() + var_17_2:getContentSize().width / 2, var_17_2:getPositionY())
							var_17_5:enableOutline(cc.c4b(10, 10, 10, 255), 1)
							var_17_5:setName("floortime")
							var_14_4:getChildByName("coverBg" .. iter_17_1.mapfloor):addChild(var_17_5)

							arg_17_0.floortime = var_17_5
						end
					end
				end
			end
		end
	end

	local var_14_11 = ccui.Button:create("explore/difficult_bnt.png", nil, "explore/difficult_bnt.png", var_0_24)

	var_14_11:setAnchorPoint(cc.p(1, 1))
	var_14_11:setPosition(640, 1030)
	var_14_0:addChild(var_14_11, 1)

	local var_14_12 = ccui.ImageView:create("explore/normal.png", var_0_24)

	var_14_12:setPosition(var_14_11:getContentSize().width / 2, var_14_11:getContentSize().height / 2)
	var_14_11:addChild(var_14_12)

	local var_14_13 = cc.Label:createWithTTF("", FONT_TITLE, 20)

	var_14_13:setColor(cc.c3b(0, 0, 0))
	var_14_13:setAnchorPoint(cc.p(0, 0.5))
	var_14_13:setPosition(10, var_14_11:getContentSize().height / 2)
	var_14_11:addChild(var_14_13)

	local var_14_14 = ccui.ImageView:create("explore/arrow_bnt.png", var_0_24)

	var_14_14:setPosition(var_14_11:getContentSize().width - var_14_14:getContentSize().width / 2 + 5, var_14_11:getContentSize().height / 2)
	var_14_11:addChild(var_14_14)

	local var_14_15 = ccui.Layout:create()

	var_14_15:setTouchEnabled(false)
	var_14_15:setClippingEnabled(true)
	var_14_15:setContentSize(cc.size(var_14_11:getContentSize().width, 140))
	var_14_15:setPosition(0, -140)
	var_14_11:addChild(var_14_15)

	local var_14_16 = ccui.Layout:create()

	var_14_16:setTouchEnabled(true)
	var_14_16:setContentSize(cc.size(var_14_11:getContentSize().width, 140))
	var_14_16:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_14_16:setBackGroundColor(cc.c3b(53, 97, 158))
	var_14_16:setBackGroundColorOpacity(200)
	var_14_16:setCascadeOpacityEnabled(false)

	var_14_16.showtype = "up"

	var_14_16:setPosition(0, 141)
	var_14_15:addChild(var_14_16)

	local var_14_17 = ccui.ImageView:create("explore/difficult_flag.png", var_0_24)

	var_14_17:setAnchorPoint(cc.p(0, 0.5))
	var_14_16:addChild(var_14_17, 9)

	local var_14_18 = {
		"explore/normal.png",
		"explore/hard.png",
		"explore/hell.png"
	}
	local var_14_19 = L_DIFFICULT_NAME

	for iter_14_0 = 1, #var_14_1 do
		local var_14_20 = ccui.Button:create(var_14_18[iter_14_0], nil, var_14_18[iter_14_0], var_0_24)

		var_14_20:setPosition(var_14_16:getContentSize().width / 2, 120 - (iter_14_0 - 1) * (var_14_20:getContentSize().height + 15))
		var_14_16:addChild(var_14_20)

		local var_14_21 = cc.Label:createWithTTF(L_DIFFICULT_NAME[iter_14_0], FONT_TITLE, 20)

		var_14_21:setColor(cc.c3b(0, 0, 0))
		var_14_21:setPosition(var_14_20:getContentSize().width / 2, var_14_20:getContentSize().height / 2)
		var_14_20:addChild(var_14_21)
		var_14_20:setName("difficult_bnt" .. iter_14_0)
		var_14_20:addTouchEventListener(function(arg_18_0, arg_18_1)
			if arg_18_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_14_0:switchDifficult(iter_14_0)
		end)
	end

	if #var_14_1 <= 1 then
		var_14_11:setVisible(false)

		if var_14_0.timeLabel then
			var_14_0.timeLabel:setAnchorPoint(cc.p(1, 0.5))
			var_14_0.timeLabel:setPositionX(640)
		end
	end

	var_14_11:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_14_0:isShowDifficultPanel()
	end)

	function var_14_0.isShowDifficultPanel(arg_20_0)
		if var_14_16.showtype == "up" then
			var_14_16.showtype = "running"

			var_14_16:runAction(cc.Sequence:create(cc.MoveTo:create(0.2, cc.p(0, 0)), cc.CallFunc:create(function()
				var_14_16.showtype = "down"

				var_14_14:setFlippedY(false)
			end)))
		elseif var_14_16.showtype == "down" then
			var_14_16.showtype = "running"

			var_14_16:runAction(cc.Sequence:create(cc.MoveTo:create(0.2, cc.p(0, 141)), cc.CallFunc:create(function()
				var_14_16.showtype = "up"

				var_14_14:setFlippedY(true)
			end)))
		end
	end

	function var_14_0:switchDifficult(arg_23_1)
		local var_23_9000

		if var_14_4.difficult and var_14_4.difficult == arg_23_1 then
			return
		end

		var_14_12:loadTexture(var_14_18[arg_23_1], var_0_24)
		var_14_17:setPosition(var_14_16:getChildByName("difficult_bnt" .. arg_23_1):getPositionX() - var_23_9000 - 5, var_14_16:getChildByName("difficult_bnt" .. arg_23_1).getPositionY(var_14_16:getChildByName("difficult_bnt" .. arg_23_1):getContentSize().width / 2))

		var_14_4.difficult = arg_23_1

		var_14_4:removeAllChildren()
		var_14_13:setString(var_14_19[arg_23_1])

		for iter_23_0, iter_23_1 in ipairs(var_14_1[arg_23_1]) do
			local var_23_0 = ccui.ImageView:create("explore/map_cover_bg.png", var_0_24)

			var_23_0:setName("coverBg" .. iter_23_1.mapfloor)
			var_23_0:setAnchorPoint(cc.p(0.5, 0))
			var_23_0:setPosition(var_14_4:getContentSize().width / 2, var_14_4:getInnerContainerSize().height - (iter_23_0 - 1) * 15 - iter_23_0 * var_23_0:getContentSize().height)
			var_14_4:addChild(var_23_0)

			local var_23_1 = ccui.Button:create(iter_23_1.cover, nil, iter_23_1.cover)

			var_23_1:setName("coverBnt" .. iter_23_1.mapfloor)
			var_23_1:setAnchorPoint(cc.p(0, 0.5))
			var_23_1:setPosition(20, var_23_0:getContentSize().height / 2)
			var_23_0:addChild(var_23_1)

			if iter_23_1.mapfloor <= (explore_manager.exploreConfigs[arg_14_1].maplevel or 0) then
				var_23_1:setOpacity(255)
			else
				var_23_1:setOpacity(100)
			end

			if iter_23_1.starttime and iter_23_0 > 1 then
				if var_14_1[arg_23_1][iter_23_0].mapfloor == (explore_manager.exploreConfigs[arg_14_1].maplevel or 0) then
					if os.time() >= os.time(parse_time(iter_23_1.starttime)) then
						var_23_1:setOpacity(255)
					else
						var_23_1:setOpacity(100)

						local var_23_3 = os.time(parse_time(iter_23_1.starttime)) - os.time()
						local var_23_5 = cc.Label:createWithTTF(string.format(L_ACTIVITY_EXPLORE_START, var_23_3 > 86400 and string.format(L_TIME_FORMAT_DAYNHOUR, math.floor(var_23_3 / 86400), math.floor(var_23_3 % 86400 / 3600)) or string.format(L_TIME_FORMAT[2], math.floor(var_23_3 / 3600), math.floor(var_23_3 % 3600 / 60))), FONT_NAME, 30)

						var_23_5:setPosition(var_23_1:getPositionX() + var_23_1:getContentSize().width / 2, var_23_1:getPositionY())
						var_23_5:enableOutline(cc.c4b(10, 10, 10, 255), 1)
						var_23_0:addChild(var_23_5)

						self.floortime = var_23_5
					end
				end
			end

			var_23_1:addTouchEventListener(function(arg_24_0, arg_24_1)
				if arg_24_1 ~= ccui.TouchEventType.ended then
					return
				end

				if (explore_manager.exploreConfigs[arg_14_1].maplevel or 0) < iter_23_1.mapfloor then
					global_ShowBlockWords(iter_23_1.unlock_str or L_UNLOCK_BY_PROGRESS)

					return
				end
			end)

			local var_23_6 = ccui.ImageView:create(var_0_27[iter_23_1.ele], var_0_24)

			var_23_6:setName("eleImg")
			var_23_6:setScale9Enabled(true)
			var_23_6:setCapInsets(cc.rect(2, 2, 2, 2))
			var_23_6:setContentSize(cc.size(var_23_6:getContentSize().width, var_23_1:getContentSize().height))
			var_23_6:setAnchorPoint(cc.p(0, 0.5))
			var_23_6:setPosition(0, var_23_1:getContentSize().height / 2 + 3)
			var_23_1:addChild(var_23_6)

			local var_23_7 = cc.Label:createWithTTF(iter_23_1.name, FONT_NAME, 22)

			var_23_7:setName("nameLabel")
			var_23_7:setAnchorPoint(cc.p(0.5, 0))
			var_23_7:setColor(cc.c3b(204, 218, 255))
			var_23_7:setPosition(var_23_1:getContentSize().width / 2, 3)
			var_23_1:addChild(var_23_7)

			local var_23_8 = ccui.ImageView:create("explore/cover_name_bg.png", var_0_24)

			var_23_8:setName("levelBg")
			var_23_8:setAnchorPoint(cc.p(0, 1))
			var_23_8:setPosition(12, var_23_0:getContentSize().height - var_23_8:getContentSize().height / 2 + 4)
			var_23_0:addChild(var_23_8)

			local var_23_9 = cc.Label:createWithTTF(L_FIGHT_CAPACITY_MSG.Recommend_Capacity .. " " .. global_trans_number(iter_23_1.needspower), FONT_NAME, 20)

			var_23_9:setName("leveLabel")
			var_23_9:setPosition(var_23_8:getContentSize().width / 2, var_23_8:getContentSize().height / 2)
			var_23_8:addChild(var_23_9)

			local var_23_10 = ccui.ListView:create()

			var_23_10:setDirection(ccui.ListViewDirection.horizontal)
			var_23_10:setItemsMargin(0)
			var_23_10:setAnchorPoint(cc.p(0, 0))
			var_23_10:setPosition(370, 50)
			var_23_10:setContentSize(cc.size(260, 130))
			var_23_0:addChild(var_23_10)

			local var_23_11 = drop_manager:getEquipAllDrops(iter_23_1.dropid)

			if var_23_11 then
				for iter_23_2, iter_23_3 in pairs(var_23_11) do
					if iter_23_2 <= 3 then
						local var_23_12 = ccui.ImageView:create("public/box/" .. item_data[iter_23_3.dropid].equip_quality .. ".png", var_0_24)

						var_23_12:setScale(0.9)

						local var_23_13

						if item_data[iter_23_3.dropid].bag_item_type == kITEM_COMPONENT then
							var_23_13 = require("controller.component_manager"):create_component_icon(item_data[iter_23_3.dropid].id)
						else
							assert(item_data[iter_23_3.dropid].image_id, item_data[iter_23_3.dropid].id)

							var_23_13 = ccui.ImageView:create("equipment/" .. item_data[iter_23_3.dropid].image_id .. ".png")
						end

						var_23_13:setPosition(var_23_12:getContentSize().width / 2, var_23_12:getContentSize().height / 2)
						var_23_13:setScale(80 / var_23_13:getContentSize().width)
						var_23_12:addChild(var_23_13)
						var_23_10:pushBackCustomItem(var_23_12)
					end
				end
			end

			local var_23_14 = ccui.Button:create("explore/more_drop.png", nil, "explore/more_drop.png", var_0_24)

			var_23_14:setAnchorPoint(cc.p(0, 0))
			var_23_14:setPosition(368, 28)
			var_23_0:addChild(var_23_14)
			var_23_14:addTouchEventListener(function(arg_25_0, arg_25_1)
				if arg_25_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:popMapDrop(iter_23_1.dropid)
			end)

			if ({
				nil,
				nil,
				nil,
				true,
				true,
				true,
				nil,
				nil,
				nil,
				true,
				true,
				true,
				nil,
				nil,
				nil,
				true,
				[18] = true,
				[17] = true
			})[iter_23_0] and not explore_map_config_data[arg_14_1].starttime then
				local var_23_15 = cc.Label:createWithTTF(L_WEAPON_FRAGMENT, FONT_NAME, 22)

				var_23_15:setAnchorPoint(cc.p(0.5, 0.5))
				var_23_15:setPosition(498, 192)
				var_23_0:addChild(var_23_15)
			end
		end

		LayerManager:getPlotObj():updatePlotUI("ExploreMapLayer" .. self.maptype)
	end

	local var_14_23 = RoleDefault:getInstance():getIntegerForKey("map" .. arg_14_1 .. "_last_mapfloor", explore_manager.exploreConfigs[arg_14_1].maplevel or 0)

	var_14_0:switchDifficult(var_14_23 <= 6 and 1 or var_14_23 <= 12 and 2 or 3)
	LayerManager:getPlotObj():clean_all()
	LayerManager:getPlotObj():updatePlotNpc("ExploreMapLayer" .. var_14_0.maptype)
	GuideListener.swallowEvent(false)
	GuideListener.lockGuideTrigger(false)
	GuideListener.updateGuides(self)
end

function ExploreUILayer.switchMapType(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	LayerManager:switchShowLayer("ExploreMapLayer")
end

function ExploreUILayer:popMapDrop(arg_27_1)
	local var_27_0 = ccui.Layout:create()

	var_27_0:setTouchEnabled(true)
	var_27_0:setContentSize(cc.size(640, 1136))
	var_27_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_27_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_27_0:setBackGroundColorOpacity(200)
	var_27_0:setCascadeOpacityEnabled(false)
	self:addChild(var_27_0, 999)
	var_27_0:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_27_0:runAction(cc.RemoveSelf:create())
	end)

	local var_27_1 = cc.SpriteBatchNode:create("tilemap/pop_bg_tile.png")

	var_27_0:addChild(var_27_1)

	local var_27_2 = 30

	for iter_27_0 = 1, 10 do
		for iter_27_1 = 1, 7 do
			local var_27_3 = cc.Sprite:create("tilemap/pop_bg_tile.png")

			var_27_3:setPosition(80 + (iter_27_1 - 1) * 80, 260 + (iter_27_0 - 1) * 80 - var_27_2)
			var_27_1:addChild(var_27_3)
		end
	end

	local var_27_4 = ccui.ImageView:create("explore/pop_up.png", var_0_24)

	var_27_4:setPosition(320, 1040 - var_27_2)
	var_27_4:setScaleX(560 / var_27_4:getContentSize().width)
	var_27_0:addChild(var_27_4)

	local var_27_5 = cc.Label:createWithTTF(L_DROP_LIST, FONT_TITLE, 30)

	var_27_5:setAnchorPoint(cc.p(0, 0.5))
	var_27_5:setPosition(10, 20)
	var_27_4:addChild(var_27_5)

	local var_27_6 = ccui.ImageView:create("explore/pop_down.png", var_0_24)

	var_27_6:setPosition(320, 218 - var_27_2)
	var_27_6:setScaleX(560 / var_27_6:getContentSize().width)
	var_27_0:addChild(var_27_6)

	local var_27_7 = drop_manager:getEquipAllDrops(arg_27_1)
	local var_27_8 = ccui.ScrollView:create()

	var_27_8:setBounceEnabled(true)

	local var_27_9 = math.ceil(#var_27_7 / 3) * 250 < 800 and 800 or math.ceil(#var_27_7 / 3) * 250

	var_27_8:setInnerContainerSize(cc.size(560, var_27_9))
	var_27_8:setDirection(ccui.ScrollViewDir.vertical)
	var_27_8:setContentSize(cc.size(560, 800))
	var_27_8:setAnchorPoint(cc.p(0.5, 0))
	var_27_8:setPosition(320, 220 - var_27_2)
	var_27_0:addChild(var_27_8)

	for iter_27_2, iter_27_3 in ipairs(var_27_7) do
		local var_27_10 = ItemSprite:createNewWithItemId(iter_27_3.dropid)

		var_27_10:setAnchorPoint(cc.p(0, 0))
		var_27_10:setPosition(4 + (iter_27_2 - 1) % 3 * 189, var_27_9 - (math.floor((iter_27_2 - 1) / 3) + 1) * 250)
		var_27_8:addChild(var_27_10)
		var_27_10:setTouchEnabled(true)
		var_27_10:addSpriteTouchEventListener(function(arg_29_0, arg_29_1)
			if arg_29_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_29_0:getLocation().y - arg_29_0:getStartLocation().y) > 50 then
				return
			end

			var_27_0:addChild(PopLayer:Item({
				hideGainButton = true,
				itemid = iter_27_3.dropid
			}))
		end)
	end
end

function ExploreUILayer.popAutoExplore(arg_30_0, arg_30_1)
	local var_30_1 = 0
	local var_30_2 = 1
	local var_30_3 = 2
	local var_30_4 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "auto_explore.json" or "auto_explore.ExportJson")

	global_basic_scene:addChild(var_30_4, 999)
	var_30_4:addTouchEventListener(function(arg_31_0, arg_31_1)
		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_31_0:setTouchEnabled(false)

		if var_30_4.classBnt then
			var_30_4.classBnt:release()
		end

		if var_30_4.soulBg then
			var_30_4.soulBg:release()
		end

		if var_30_4.mapBnt then
			var_30_4.mapBnt:release()
		end

		var_30_4:runAction(cc.RemoveSelf:create())

		if arg_30_1 then
			arg_30_1()
		end
	end)

	function var_30_4:init()
		self.usedServants = {}

		self:getChildByName("Bg"):setVisible(false)
		self:getChildByName("Bg"):setOpacity(0)
		self:setTouchEnabled(false)
		explore_manager:getAutoExploreInfos(function()
			self.auto_exploreMapInfos = explore_manager:getCurAutoExploreInfos()

			self:getChildByName("Bg"):runAction(cc.Sequence:create(cc.Show:create(), cc.FadeIn:create(0.5), cc.CallFunc:create(function()
				self:setTouchEnabled(true)
			end)))
			self:initBaseUI()
			self:switchClass(1)
		end)
	end

	function var_30_4.getTimeStr(arg_35_0, arg_35_1)
		return arg_35_1 > 3600 and string.format(L_TIME_FORMAT[2], math.floor(arg_35_1 / 3600), math.floor(arg_35_1 % 3600 / 60)) or string.format(L_TIME_FORMAT_MINSEC, math.floor(arg_35_1 / 60), math.floor(arg_35_1 % 60))
	end

	function var_30_4.getTimeStr1(arg_36_0, arg_36_1)
		return (string.format("%d:%02d:%02d", math.floor(arg_36_1 / 3600), math.floor(arg_36_1 % 3600 / 60), math.floor(arg_36_1 % 3600 % 60)))
	end

	function var_30_4.getEleIcon(arg_37_0, arg_37_1, arg_37_2)
		local var_37_0

		if model_data[arg_37_2].wind then
			var_37_0 = "wind"
		elseif model_data[arg_37_2].fire then
			var_37_0 = "fire"
		elseif model_data[arg_37_2].water then
			var_37_0 = "water"
		elseif model_data[arg_37_2].light then
			var_37_0 = "light"
		elseif model_data[arg_37_2].dark then
			var_37_0 = "dark"
		elseif model_data[arg_37_2].attr_null then
			var_37_0 = "null"
		end

		return CAREER_ICON[servant_data[arg_37_1].career .. "_" .. var_37_0]
	end

	function var_30_4.createSoulSpine(arg_38_0, arg_38_1)
		local var_38_0 = global_get_servant_skin(arg_38_1)
		local var_38_1 = 0.3
		local var_38_2 = cc.size(model_data[var_38_0].modelweight, model_data[var_38_0].modelheight)
		local var_38_3 = L2Actor:create(ROLE_SPINE_PATH .. model_data[var_38_0].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_38_0].spine_model .. ".atlas", (model_data[var_38_0].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[var_38_0].clothes_model .. ".atlas" or nil))

		var_38_3:setName("spine")
		var_38_3:setScale(var_38_1, var_38_1)
		var_38_3:setContentSize(var_38_2)

		var_38_3.servantid = arg_38_1

		return var_38_3
	end

	function var_30_4:initBaseUI()
		self.classListView = ccui.Helper:seekWidgetByName(self, "ListView_class")
		self.classBnt = ccui.Helper:seekWidgetByName(self.classListView, "airship_bnt")

		self.classBnt:retain()
		self.classBnt:removeFromParent()

		self.team_need_fight_power = ccui.Helper:seekWidgetByName(self, "Label_need_fight_power")
		self.team_cur_fight_power = ccui.Helper:seekWidgetByName(self, "Label_fight_power")
		self.dropListView = ccui.Helper:seekWidgetByName(self, "ListView_drops")
		self.sureBnt = ccui.Helper:seekWidgetByName(self, "Button_sure")
		self.oneClickSelectBnt = ccui.Helper:seekWidgetByName(self, "Button_one_click")

		self:initDifficulty()
		self:initClassBnts()
		self:initArrayUI()
		self:initMapsUI()
		self:initBntEvent()
		self:mapsSchedule()
		self:diffSchedule()
	end

	function var_30_4:initDifficulty()
		self.diff = ccui.Helper:seekWidgetByName(self, "Panel_difficulty")
		self.bnt_difficulty = ccui.Helper:seekWidgetByName(self.diff, "Button_easy")
		self.difficultyBnts = {}

		self.bnt_difficulty:retain()
		self.bnt_difficulty:removeFromParent()

		local var_40_0 = {
			"easy",
			"hardd",
			"helll"
		}
		local var_40_1 = {
			"no_selected_easy",
			"no_selected_hard",
			"no_selected_hell"
		}
		local var_40_2 = {
			"4:00:00",
			"6:00:00",
			"8:00:00"
		}
		local var_40_3 = {
			94,
			262,
			431
		}

		for iter_40_0 = 1, 3 do
			local var_40_4 = self.bnt_difficulty:clone()

			var_40_4:loadTextures("explore/" .. var_40_1[iter_40_0] .. ".png", "explore/" .. var_40_0[iter_40_0] .. ".png", "explore/" .. var_40_0[iter_40_0] .. ".png", var_0_24)
			var_40_4:setPositionX(var_40_3[iter_40_0])
			var_40_4:getChildByName("time"):setString(var_40_2[iter_40_0])
			self.diff:addChild(var_40_4)

			self.difficultyBnts[iter_40_0] = var_40_4

			var_40_4:addTouchEventListener(function(arg_41_0, arg_41_1)
				if arg_41_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:switchDifficulty(iter_40_0)
			end)
		end
	end

	function var_30_4:initBntEvent()
		self.sureBnt:addTouchEventListener(function(arg_43_0, arg_43_1)
			if arg_43_1 ~= ccui.TouchEventType.ended then
				return
			end

			arg_43_0:setTouchEnabled(false)

			if arg_43_0.status == "begin" then
				local var_43_0 = {}

				for iter_43_0, iter_43_1 in pairs(self.soulBgs) do
					if iter_43_1.servantid then
						table.insert(var_43_0, {
							pos = iter_43_0,
							fight_girl = iter_43_1.servantid
						})
					end

					if core_manager:getCoreLv(iter_43_1.servantid) < self.auto_exploreMapInfos[self.cityid].arrayLimit[iter_43_0] then
						global_ShowBlockWords(L_MEMBER_LV_LOW)
						arg_43_0:setTouchEnabled(true)

						return
					end
				end

				if #var_43_0 == 3 and self.team_cur_fight_power.value and self.team_cur_fight_power.value < self.team_need_fight_power.value then
					global_ShowBlockWords(L_TOTAL_CAPACITY_LOW)
					arg_43_0:setTouchEnabled(true)

					return
				end

				explore_manager:beginAutoExplore(self.classid, self.cityid, var_43_0, function(arg_44_0)
					if arg_44_0 == 1 then
						self.auto_exploreMapInfos = explore_manager:getCurAutoExploreInfos()

						self.mapBnts[self.cityid]:updateShow()
						self:updateSureBnt()

						for iter_44_0, iter_44_1 in pairs(self.soulBgs) do
							iter_44_1:updateSoulImg(iter_44_1.servantid)
						end
					end

					arg_43_0:setTouchEnabled(true)
				end)
			elseif arg_43_0.status == "finish" then
				local var_43_1 = self.auto_exploreMapInfos[self.cityid].begintime and math.floor((os.time() - self.auto_exploreMapInfos[self.cityid].begintime) / 3600 * 10) / 10 or self.auto_exploreMapInfos[self.cityid].needtime

				self:addChild(PopLayer:Do({
					surecallback = function()
						explore_manager:finishAutoExplore(self.classid, function(arg_46_0)
							if arg_46_0 == 1 then
								self.auto_exploreMapInfos = explore_manager:getCurAutoExploreInfos()

								self.mapBnts[self.cityid]:updateShow()
								self:updateSureBnt()

								for iter_46_0, iter_46_1 in pairs(self.soulBgs) do
									iter_46_1:updateSoulImg()
								end
							end

							arg_43_0:setTouchEnabled(true)
						end)
					end,
					cancelcallback = function()
						arg_43_0:setTouchEnabled(true)
					end,
					labels = {
						title = L_CALLBACK_TEAM_MSG.title,
						des = string.format(L_CALLBACK_TEAM_MSG.des, var_43_1),
						button = L_CALLBACK_TEAM_MSG.button
					}
				}), 999)
			end
		end)
		self.oneClickSelectBnt:addTouchEventListener(function(arg_48_0, arg_48_1)
			if arg_48_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_48_0 = explore_manager:oneClickSelectAutoGirls(self.auto_exploreMapInfos[self.cityid].arrayLimit, self.auto_exploreMapInfos[self.cityid].fightPowerLimit)

			for iter_48_0 = 1, 3 do
				self.soulBgs[iter_48_0]:updateSoulImg(var_48_0[iter_48_0])
			end

			self:updateArrayFightPower()
			self:checkArray()
		end)
	end

	function var_30_4:initArrayUI()
		self.arrayBg = ccui.Helper:seekWidgetByName(self, "Panel_array")
		self.soulBg = ccui.Helper:seekWidgetByName(self.arrayBg, "Image_bottom")

		self.soulBg:retain()
		self.soulBg:removeFromParent()

		self.soulBgs = {}

		local var_49_0 = {
			100,
			274,
			450
		}

		for iter_49_0 = 1, 3 do
			local var_49_1 = self.soulBg:clone()

			var_49_1:setPositionX(var_49_0[iter_49_0])
			self.arrayBg:addChild(var_49_1)

			self.soulBgs[iter_49_0] = var_49_1

			local var_49_2 = var_49_1:getChildByName("Button_add")
			local var_49_3 = var_49_1:getChildByName("Image_need_lv")
			local var_49_4 = var_49_1:getChildByName("Image_name")
			local var_49_5 = var_49_1:getChildByName("Image_name"):getChildByName("Label_lv")
			local var_49_6 = var_49_1:getChildByName("Image_name"):getChildByName("ele_icon")
			local var_49_7 = ccui.Button:create(var_0_28[1], nil, var_0_28[1], var_0_24)

			var_49_7:setPosition(120, 100)
			var_49_7:setName("sanBnt")
			var_49_1:addChild(var_49_7, 99)
			var_49_7:addTouchEventListener(function(arg_50_0, arg_50_1)
				if arg_50_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not var_49_1.servantid then
					return
				end

				if var_49_7:getChildByName("des_layout") then
					return
				end

				local var_50_0 = ccui.Layout:create()

				var_50_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
				var_50_0:setBackGroundColor(cc.c3b(0, 0, 0))
				var_50_0:setBackGroundColorOpacity(200)
				var_50_0:setName("des_layout")
				var_50_0:setAnchorPoint(cc.p(0.5, 0))
				var_50_0:setCascadeOpacityEnabled(false)
				var_49_7:addChild(var_50_0)

				local var_50_1 = cc.Label:createWithTTF(L_SPIRIT_CAPACITY .. playermodel.souls_sanvalue[servant_data[var_49_1.servantid].major], FONT_DES, 24)

				var_50_1:setAnchorPoint(cc.p(0, 0))
				var_50_0:addChild(var_50_1)
				var_50_0:setContentSize((var_50_1:getContentSize()))
				var_50_0:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.RemoveSelf:create()))
			end)
			var_49_2:addTouchEventListener(function(arg_51_0, arg_51_1)
				if arg_51_1 ~= ccui.TouchEventType.ended then
					return
				end

				if explore_manager.auto_exploreInfos[self.classid].status ~= var_30_1 then
					return
				end

				self:setVisible(false)
				LayerManager:pushInLayer("GirlSelectLayer", {
					is_auto = true,
					selectType = SELECT_GIRL_EXPLORE,
					cursoul = var_49_1.servantid,
					lv_limit = self.auto_exploreMapInfos[self.cityid].arrayLimit[iter_49_0],
					exploringSouls = explore_manager:getExploringSouls(),
					usedServants = self.usedServants,
					sureCallBack = function(arg_52_0)
						var_49_1:updateSoulImg(arg_52_0)
						self:updateArrayFightPower()
						self:checkArray()
						self:setVisible(true)
					end,
					exitcallback = function()
						self:setVisible(true)
					end
				})
			end)

			function var_49_1:updateSoulImg(arg_54_1)
				if arg_54_1 then
					local var_54_0

					if self:getChildByName("spine") then
						if self.servantid == arg_54_1 then
							var_54_0 = self:getChildByName("spine")
						else
							self:getChildByName("spine"):removeFromParent()

							var_54_0 = self:createSoulSpine(arg_54_1)

							var_54_0:setName("spine")
							var_54_0:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 3)
							self:addChild(var_54_0)
						end
					else
						var_54_0 = self:createSoulSpine(arg_54_1)

						var_54_0:setName("spine")
						var_54_0:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 3)
						self:addChild(var_54_0)
					end

					if explore_manager.auto_exploreInfos[self.classid].status == var_30_1 or explore_manager.auto_exploreInfos[self.classid].status == var_30_3 then
						var_54_0:playAni(nil, "idle", true)
					elseif explore_manager.auto_exploreInfos[self.classid].status == var_30_2 then
						var_54_0:playAni(nil, "run", true)
					end

					var_49_2:setOpacity(0)
					var_49_3:setVisible(false)
					var_49_4:setVisible(true)
					var_49_5:setVisible(true)

					local var_54_1 = var_49_5:getContentSize().width / 2

					var_49_7:setVisible(true)

					local var_54_2 = core_manager:getCoreLv(arg_54_1)

					var_49_5:setString("Lv." .. var_54_2)

					if var_54_2 < self.auto_exploreMapInfos[self.cityid].arrayLimit[iter_49_0] then
						var_49_5:setColor(cc.c3b(255, 0, 0))
					else
						var_49_5:setColor(cc.c3b(255, 255, 255))
					end

					local var_54_3 = model_data[global_get_servant_skin(arg_54_1)]

					var_49_4:getChildByName("Label_name"):setString(servant_data[arg_54_1].name)
					var_49_6:loadTexture(self:getEleIcon(arg_54_1, var_54_3.id), var_0_24)
					var_49_5:setPositionX(var_49_6:getContentSize().width + var_54_1)

					local var_54_4 = var_0_28[explore_manager:getServantSanLevel(arg_54_1)]

					var_49_7:loadTextures(var_54_4, nil, var_54_4, var_0_24)
				else
					if self:getChildByName("spine") then
						self:getChildByName("spine"):removeFromParent()
					end

					var_49_2:setOpacity(255)
					var_49_3:setVisible(true)
					var_49_4:setVisible(false)
					var_49_5:setVisible(false)
					var_49_7:setVisible(false)
					var_49_3:getChildByName("Label_need_lv"):setString(self.auto_exploreMapInfos[self.cityid].arrayLimit[iter_49_0] .. L_LV)
				end

				if arg_54_1 then
					if self.servantid and self.servantid ~= arg_54_1 then
						self.usedServants[self.servantid] = nil
					end

					self.usedServants[arg_54_1] = true
				elseif self.servantid then
					self.usedServants[self.servantid] = nil
				end

				self.servantid = arg_54_1
			end
		end
	end

	function var_30_4:initClassBnts()
		self.classBnts = {}

		for iter_55_0, iter_55_1 in pairs(explore_manager.auto_exploreInfos) do
			local var_55_0 = self.classBnt:clone()

			var_55_0:loadTextures("explore/airship" .. iter_55_0 .. "bnt.png", "explore/airship" .. iter_55_0 .. "bnt_on.png", "explore/airship" .. iter_55_0 .. "bnt_on.png", var_0_24)
			var_55_0:setPositionX((var_55_0:getContentSize().width - 8) * (iter_55_0 - 1) - 3)
			self.classListView:addChild(var_55_0)

			self.classBnts[iter_55_0] = var_55_0

			var_55_0:addTouchEventListener(function(arg_56_0, arg_56_1)
				if arg_56_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:switchClass(iter_55_0)
			end)
		end

		if #explore_manager.auto_exploreInfos < 5 then
			local var_55_1 = self.classBnt:clone()

			var_55_1:loadTextures("explore/actions_bnt.png", "explore/actions_bnt.png", "explore/actions_bnt.png", var_0_24)
			var_55_1:setPositionX(self.classBnt:getContentSize().width * #explore_manager.auto_exploreInfos + var_55_1:getContentSize().width / 2)
			self.classListView:addChild(var_55_1)
			var_55_1:addTouchEventListener(function(arg_57_0, arg_57_1)
				if arg_57_1 ~= ccui.TouchEventType.ended then
					return
				end

				local var_57_0 = PopLayer:Go_Gain_Layer({
					goto_back_system_id = 10000,
					item = 1749901,
					surecallback = function()
						self:runAction(cc.RemoveSelf:create())

						if arg_30_1 then
							arg_30_1()
						end
					end
				})

				if var_57_0 then
					global_basic_scene:addChild(var_57_0, 999)
				end
			end)
		end
	end

	function var_30_4:initMapsUI()
		self.mapListView = ccui.Helper:seekWidgetByName(self, "ScrollView_maps")
		self.mapBnt = ccui.Helper:seekWidgetByName(self.mapListView, "Button_map")

		self.mapBnt:retain()
		self.mapBnt:removeFromParent()
		self.mapListView:setInnerContainerSize(cc.size(207 * table.nums(self.auto_exploreMapInfos) + 4, self.mapListView:getContentSize().height))

		self.mapBnts = {}

		for iter_59_0, iter_59_1 in pairs(self.auto_exploreMapInfos) do
			local var_59_0 = self.mapBnt:clone()

			var_59_0.cityid = iter_59_1.id

			var_59_0:loadTextures(iter_59_1.img, nil, iter_59_1.img)

			if not iter_59_1.isunlock then
				l2utils:shaderNode(var_59_0:getVirtualRenderer())
			end

			var_59_0:setPositionX(self.mapBnt:getPositionX() + (iter_59_1.order - 1) * (var_59_0:getContentSize().width + 15))
			var_59_0:getChildByName("Panel_time"):setPosition(0, 0)
			var_59_0:getChildByName("Panel_auto_exploreing"):setPosition(0, var_59_0:getContentSize().height / 2)
			var_59_0:getChildByName("Panel_auto_exploreing"):setVisible(false)
			self.mapListView:addChild(var_59_0)

			self.mapBnts[iter_59_1.id] = var_59_0

			var_59_0:addTouchEventListener(function(arg_60_0, arg_60_1)
				if arg_60_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:switchMap(iter_59_1.id)
			end)

			function var_59_0:updateShow()
				if self.auto_exploreMapInfos[self.cityid].status == var_30_1 then
					self:getChildByName("Panel_auto_exploreing"):setVisible(false)

					if self.auto_exploreMapInfos[self.cityid].isunlock then
						self:getChildByName("Panel_time"):getChildByName("Label_time"):setString(string.format(L_INFO_NEEDTIME, self.auto_exploreMapInfos[self.cityid].needtime))
					else
						self:getChildByName("Panel_time"):getChildByName("Label_time"):setString(L_MAP_LOCK)
					end
				elseif self.auto_exploreMapInfos[self.cityid].status == var_30_2 then
					self:getChildByName("Panel_auto_exploreing"):setVisible(true)
					self:getChildByName("Panel_auto_exploreing"):getChildByName("Label_29"):setString(string.format(L_AIRSHIP_HANGUP, self.auto_exploreMapInfos[self.cityid].airshipId))
				elseif self.auto_exploreMapInfos[self.cityid].status == var_30_3 then
					self:getChildByName("Panel_auto_exploreing"):setVisible(true)
					self:getChildByName("Panel_auto_exploreing"):getChildByName("Label_29"):setString(string.format(L_AIRSHIP_FINISH, self.auto_exploreMapInfos[self.cityid].airshipId))
					self:getChildByName("Panel_time"):getChildByName("Label_time"):setString(L_AIRSHIP_RETURN)
				end
			end

			var_59_0:updateShow()
		end
	end

	function var_30_4:diffSchedule()
		self:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
			for iter_63_0, iter_63_1 in pairs(self.mapBnts) do
				if self.auto_exploreMapInfos[iter_63_0].status == var_30_2 and self.classid == self.auto_exploreMapInfos[iter_63_0].airshipId then
					local var_63_0 = self.auto_exploreMapInfos[iter_63_0].needtime * 3600 - os.time() + self.auto_exploreMapInfos[iter_63_0].begintime

					self.difficultyBnts[1]:getChildByName("time"):setString(self:getTimeStr1(var_63_0))

					if var_63_0 <= 0 then
						self.auto_exploreMapInfos[iter_63_0].status = var_30_3

						self.difficultyBnts[1]:getChildByName("time"):setString("4:00:00")

						if self.classid == self.auto_exploreMapInfos[iter_63_0].airshipId then
							for iter_63_2, iter_63_3 in pairs(self.soulBgs) do
								if curSoulBg:getChildByName("spine") then
									curSoulBg:getChildByName("spine"):playAni(function()
										curSoulBg:getChildByName("spine"):playAni(nil, "idle", true)
									end, "win", false)
								end
							end
						end
					end
				end
			end
		end), cc.DelayTime:create(1))))
	end

	function var_30_4:mapsSchedule()
		self:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
			for iter_66_0, iter_66_1 in pairs(self.mapBnts) do
				if self.auto_exploreMapInfos[iter_66_0].status == var_30_2 then
					local var_66_0 = self.auto_exploreMapInfos[iter_66_0].needtime * 3600 - os.time() + self.auto_exploreMapInfos[iter_66_0].begintime

					iter_66_1:getChildByName("Panel_time"):getChildByName("Label_time"):setString(L_REST .. self:getTimeStr(var_66_0))

					if var_66_0 <= 0 then
						self.auto_exploreMapInfos[iter_66_0].status = var_30_3

						iter_66_1:updateShow()

						if self.classid == self.auto_exploreMapInfos[iter_66_0].airshipId then
							for iter_66_2, iter_66_3 in pairs(self.soulBgs) do
								if curSoulBg:getChildByName("spine") then
									curSoulBg:getChildByName("spine"):playAni(function()
										curSoulBg:getChildByName("spine"):playAni(nil, "idle", true)
									end, "win", false)
								end
							end
						end
					end
				end
			end
		end), cc.DelayTime:create(1))))
	end

	function var_30_4:switchClass(arg_68_1)
		if self.classid and self.classid == arg_68_1 then
			return
		end

		self.classid = arg_68_1

		for iter_68_0, iter_68_1 in pairs(self.classBnts) do
			if iter_68_0 == self.classid then
				if self.classid == 5 then
					iter_68_1:setPositionX(402)
				end

				iter_68_1:loadTextures("explore/airship" .. iter_68_0 .. "bnt_on.png", "explore/airship" .. iter_68_0 .. "bnt_on.png", "explore/airship" .. iter_68_0 .. "bnt_on.png", var_0_24)
				iter_68_1:setLocalZOrder(1)
			else
				if iter_68_0 == 5 then
					iter_68_1:setPositionX(428)
				end

				iter_68_1:loadTextures("explore/airship" .. iter_68_0 .. "bnt.png", "explore/airship" .. iter_68_0 .. "bnt_on.png", "explore/airship" .. iter_68_0 .. "bnt_on.png", var_0_24)
				iter_68_1:setLocalZOrder(0)
			end
		end

		self:switchMap(explore_manager.auto_exploreInfos[self.classid].city)
		self.difficultyBnts[1]:getChildByName("time"):setString("4:00:00")
		self:updateArray()
		self:updateArrayFightPower()
	end

	function var_30_4:switchMap(arg_69_1)
		arg_69_1 = arg_69_1 or 101

		if self.cityid then
			self.mapBnts[self.cityid]:getChildByName("heightLight"):removeFromParent()
		end

		self.cityid = arg_69_1

		local var_69_0 = ccui.ImageView:create("explore/map_light.png", var_0_24)

		var_69_0:setName("heightLight")
		var_69_0:setPosition(self.mapBnts[self.cityid]:getContentSize().width / 2, self.mapBnts[self.cityid]:getContentSize().height / 2)
		self.mapBnts[self.cityid]:addChild(var_69_0)
		self.team_need_fight_power:setString(global_trans_number(self.auto_exploreMapInfos[arg_69_1].fightPowerLimit))

		self.team_need_fight_power.value = self.auto_exploreMapInfos[arg_69_1].fightPowerLimit

		self:switchDifficulty(1)
	end

	function var_30_4:switchDifficulty(arg_70_1)
		self.diffid = arg_70_1

		for iter_70_0, iter_70_1 in pairs(self.difficultyBnts) do
			if iter_70_0 == self.diffid then
				iter_70_1:setBright(false)
			else
				iter_70_1:setBright(true)
			end
		end

		self:updateDrops()
		self:checkArray()
		self:updateSureBnt()
	end

	function var_30_4:updateArrayFightPower()
		local var_71_0 = {}

		for iter_71_0 = 1, 3 do
			var_71_0[iter_71_0] = {
				pos = iter_71_0,
				fight_girl = self.soulBgs[iter_71_0].servantid
			}
		end

		local var_71_1 = fight_capacity_manager:getArrayFightCapacity(var_71_0, nil, nil, FIGHTTYPE_EXPLORE)

		self.team_cur_fight_power.value = var_71_1

		self.team_cur_fight_power:setString((global_trans_number(var_71_1)))
	end

	function var_30_4:updateSureBnt()
		explore_manager.auto_exploreInfos[self.classid].status = explore_manager.auto_exploreInfos[self.classid].status or 0
		auto_exploreMapInfo = self.auto_exploreMapInfos[self.cityid]

		if explore_manager.auto_exploreInfos[self.classid].status == 0 then
			if not auto_exploreMapInfo.isunlock then
				global_ShowBlockWords(L_PASS_NOMAL_UNLOCK)
				self.sureBnt:setVisible(false)
			elseif auto_exploreMapInfo.status ~= var_30_1 then
				self.sureBnt:setVisible(false)
			else
				self.sureBnt.status = "begin"

				self.sureBnt:setVisible(true)
				self.sureBnt:loadTextures("explore/confirme.png", "explore/confirme.png", "explore/confirme.png", var_0_24)
			end

			self.oneClickSelectBnt:setVisible(true)
		else
			if explore_manager.auto_exploreInfos[self.classid].city == self.cityid then
				self.sureBnt:setVisible(true)

				if explore_manager.auto_exploreInfos[self.classid].status == var_30_2 then
					self.sureBnt.status = "finish"

					self.sureBnt:loadTextures("explore/abandon.png", "explore/abandon.png", "explore/abandon.png", var_0_24)
				elseif explore_manager.auto_exploreInfos[self.classid].status == var_30_3 then
					self.sureBnt.status = "finish"

					self.sureBnt:loadTextures("explore/get_reward.png", "explore/get_reward.png", "explore/get_reward.png", var_0_24)
				end
			else
				self.sureBnt:setVisible(false)
			end

			self.oneClickSelectBnt:setVisible(false)
		end
	end

	function var_30_4:updateArray()
		local var_73_0 = {}

		if explore_manager.auto_exploreInfos[self.classid].array then
			for iter_73_0, iter_73_1 in pairs(explore_manager.auto_exploreInfos[self.classid].array) do
				var_73_0[iter_73_1.pos] = iter_73_1.fight_girl
			end
		end

		for iter_73_2 = 1, 3 do
			if var_73_0[iter_73_2] then
				self.soulBgs[iter_73_2]:updateSoulImg(var_73_0[iter_73_2])
			else
				self.soulBgs[iter_73_2]:updateSoulImg()
			end
		end
	end

	function var_30_4:updateDrops()
		self.dropListView:setItemsMargin(10)
		self.dropListView:removeAllChildren()

		local var_74_0 = drop_manager:getEquipAllDrops(self.auto_exploreMapInfos[self.cityid].dropid)

		if var_74_0 then
			for iter_74_0, iter_74_1 in pairs(var_74_0) do
				local var_74_1 = ccui.ImageView:create("public/box/" .. item_data[iter_74_1.dropid].equip_quality .. ".png", var_0_24)
				local var_74_2

				if item_data[iter_74_1.dropid].bag_item_type == kITEM_COMPONENT then
					var_74_2 = require("controller.component_manager"):create_component_icon(item_data[iter_74_1.dropid].id)
				else
					assert(item_data[iter_74_1.dropid].image_id, item_data[iter_74_1.dropid].id)

					var_74_2 = ccui.ImageView:create("equipment/" .. item_data[iter_74_1.dropid].image_id .. ".png")
				end

				var_74_2:setScale(80 / var_74_2:getContentSize().width)
				var_74_2:setPosition(var_74_1:getContentSize().width / 2, var_74_1:getContentSize().height / 2)
				var_74_1:addChild(var_74_2)
				var_74_1:setTouchEnabled(true)
				var_74_1:addTouchEventListener(function(arg_75_0, arg_75_1)
					if arg_75_1 ~= ccui.TouchEventType.ended then
						return
					end

					global_basic_scene:addChild(PopLayer:Item({
						itemid = iter_74_1.dropid,
						removeParentCallback = function()
							self:runAction(cc.RemoveSelf:create())
						end
					}), 999)
				end)
				self.dropListView:pushBackCustomItem(var_74_1)
			end
		end
	end

	function var_30_4:checkArray()
		for iter_77_0, iter_77_1 in pairs(self.soulBgs) do
			if iter_77_1.servantid then
				if core_manager:getCoreLv(iter_77_1.servantid) < self.auto_exploreMapInfos[self.cityid].arrayLimit[iter_77_0] then
					iter_77_1:getChildByName("Image_name"):getChildByName("Label_lv"):setColor(cc.c3b(255, 0, 0))
					iter_77_1:getChildByName("Image_need_lv"):setVisible(true)
					iter_77_1:getChildByName("Image_name"):setVisible(false)
					iter_77_1:getChildByName("Image_need_lv"):getChildByName("Label_need_lv"):setString(self.auto_exploreMapInfos[self.cityid].arrayLimit[iter_77_0] .. L_LV)
				else
					iter_77_1:getChildByName("Image_name"):getChildByName("Label_lv"):setColor(cc.c3b(255, 255, 255))
					iter_77_1:getChildByName("Image_need_lv"):setVisible(false)
					iter_77_1:getChildByName("Image_name"):setVisible(true)
				end
			else
				iter_77_1:getChildByName("Image_need_lv"):getChildByName("Label_need_lv"):setString(self.auto_exploreMapInfos[self.cityid].arrayLimit[iter_77_0] .. L_LV)
			end
		end
	end

	var_30_4:init()
end
