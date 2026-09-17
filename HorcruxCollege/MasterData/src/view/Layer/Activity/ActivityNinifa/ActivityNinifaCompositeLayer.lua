ActivityNinifaCompositeLayer = class("ActivityNinifaCompositeLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = 3
local var_0_1 = 4
local var_0_2 = config._DEBUG and 0 or 1
local var_0_3 = {}

var_0_3[3] = "public/box/weapon_bg_blue.png"
var_0_3[var_0_1] = "public/box/weapon_bg_purple.png"

local item_data = require("data.item_data")

require("view.Sprite.ItemSprite")

local l2utils = require("controller.l2utils")
local audio_manager = require("controller.audio_manager")
local activity_manager = require("controller.activity_manager")
local activity_ninifa_manager = require("controller.activity_ninifa_manager")

function ActivityNinifaCompositeLayer.create(arg_2_0)
	local var_2_0 = ActivityNinifaCompositeLayer.new()

	var_2_0:init()

	return var_2_0
end

function ActivityNinifaCompositeLayer:init()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityNinifaCompositeLayer.json" or "ActivityNinifaCompositeLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.compountCount = 1
	self.selectItems = {}

	self:initUI()
	self:registerActivityEventListener()
	self:switchShowItemListLayout()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("ActivityNinifaCompositeLayer")
		end
	end)
end

function ActivityNinifaCompositeLayer.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("ActivityNinifaCompositeLayer", activity_manager.activityEventId.ITEM_COMPOUND_SUCCESSED, function(arg_6_0)
		arg_5_0.selectItems = {}
		arg_5_0.compountCount = 1

		arg_5_0.rootLayer:getChildByName("start_compound_layout"):getChildByName("count_bg"):getChildByName("num_lbl"):setString(tostring(arg_5_0.compountCount))
		arg_5_0:updateItemSelectLayout()
		arg_5_0:updateItemList()

		for iter_6_0 = 1, 3 do
			arg_5_0.itemSelectLayout:getChildByName("item_bg_" .. iter_6_0):getChildByName("item_" .. iter_6_0):runAction(cc.Sequence:create(cc.FadeIn:create(0)))
		end
	end)
	activity_manager:registerEventListener("ActivityNinifaCompositeLayer", activity_manager.activityEventId.NEED_DIRECT_GOTO_COMPOUD, function(arg_7_0)
		arg_5_0:whenNeedDirectToCompoud(arg_7_0)
	end)
end

function ActivityNinifaCompositeLayer:initUI()
	self:initBG()
	self:initItemListLayout()
	self:initItemSelectLayout()
	self:initStartCompoundLayout()
	self:initBottomList()
end

function ActivityNinifaCompositeLayer:initBG()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_bg"):setBackGroundImage("mainScenebg/activity/branch11/bg_child.jpg")
	require("view.Sprite.TitleSprite")

	self.titleSprite = TitleSprite:create("ActivityNinifaCompositeLayer/title.png", 2)

	self.titleSprite:setPosition(cc.p(0, GameDisplay.getUiScreenSize().height - 56 - GameDisplay.fix_y))
	self.rootLayer:addChild(self.titleSprite)
end

function ActivityNinifaCompositeLayer:initItemListLayout()
	local var_10_0 = self.rootLayer:getChildByName("select_item_layout")
	local var_10_1 = var_10_0:getChildByName("basic_select_btn")
	local var_10_2 = var_10_0:getChildByName("middle_select_btn")

	var_10_1:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_10_1:loadTextures("ActivityNinifaCompositeLayer/basic_selected_btn.png", nil, "ActivityNinifaCompositeLayer/basic_selected_btn.png", var_0_2)
		var_10_2:loadTextures("ActivityNinifaCompositeLayer/middle_unselected_btn.png", nil, "ActivityNinifaCompositeLayer/middle_unselected_btn.png", var_0_2)

		if self.selectQuality ~= var_0_0 then
			self.selectItems = {}
			self.selectQuality = var_0_0
		end

		self:updateItemSelectLayout()
		self:updateItemList()
	end)
	var_10_2:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_10_2:loadTextures("ActivityNinifaCompositeLayer/middle_selected_btn.png", nil, "ActivityNinifaCompositeLayer/middle_selected_btn.png", var_0_2)
		var_10_1:loadTextures("ActivityNinifaCompositeLayer/basic_unselected_btn.png", nil, "ActivityNinifaCompositeLayer/basic_unselected_btn.png", var_0_2)

		if self.selectQuality ~= var_0_1 then
			self.selectItems = {}
			self.selectQuality = var_0_1
		end

		self:updateItemSelectLayout()
		self:updateItemList()
	end)
end

function ActivityNinifaCompositeLayer:updateItemList()
	self.selectQuality = self.selectQuality or var_0_0

	local var_13_0 = self.rootLayer:getChildByName("select_item_layout")
	local var_13_1 = var_13_0:getChildByName("basic_select_btn")
	local var_13_2 = var_13_0:getChildByName("middle_select_btn")

	if self.selectQuality == var_0_0 then
		var_13_1:loadTextures("ActivityNinifaCompositeLayer/basic_selected_btn.png", nil, "ActivityNinifaCompositeLayer/basic_selected_btn.png", var_0_2)
		var_13_2:loadTextures("ActivityNinifaCompositeLayer/middle_unselected_btn.png", nil, "ActivityNinifaCompositeLayer/middle_unselected_btn.png", var_0_2)
	else
		var_13_2:loadTextures("ActivityNinifaCompositeLayer/middle_selected_btn.png", nil, "ActivityNinifaCompositeLayer/middle_selected_btn.png", var_0_2)
		var_13_1:loadTextures("ActivityNinifaCompositeLayer/basic_unselected_btn.png", nil, "ActivityNinifaCompositeLayer/basic_unselected_btn.png", var_0_2)
	end

	local var_13_3 = activity_ninifa_manager:getMaterialsByQuality(self.selectQuality)
	local var_13_4 = self.rootLayer:getChildByName("select_item_layout"):getChildByName("item_list")

	var_13_4:removeAllChildren()

	for iter_13_0, iter_13_1 in pairs(var_13_3) do
		local var_13_5 = ItemPurchaseSprite:createPurchaseItem(iter_13_0, iter_13_1.have_count)

		var_13_5:setScale(0.7)
		var_13_5:setPositionX(50 + (1 - 1) % 4 * 120)
		var_13_5:setPositionY(235 - (math.ceil(1 / 4) - 1) * 130)
		var_13_4:addChild(var_13_5)

		if self:isItemBeSelected(iter_13_0) then
			var_13_5:setColor(cc.c3b(90, 90, 90))
		end

		var_13_5:setTouchEnabled(true)
		var_13_5:addTouchEventListener(function(arg_14_0, arg_14_1)
			if arg_14_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self:isItemBeSelected(iter_13_0) then
				self:deleteSelectItem(var_13_5, iter_13_0)

				return
			end

			if self.selectItems[1] and self.selectItems[2] and self.selectItems[3] then
				return
			end

			arg_14_0:setColor(cc.c3b(90, 90, 90))
			self:insertSelectedItem(iter_13_0)
		end)
	end
end

function ActivityNinifaCompositeLayer:deleteSelectItem(arg_15_1, arg_15_2)
	if not next(self.selectItems) then
		return false
	end

	local var_15_0 = 0

	for iter_15_0, iter_15_1 in pairs(self.selectItems) do
		if iter_15_1 == arg_15_2 then
			var_15_0 = iter_15_0
		end
	end

	self.selectItems[var_15_0] = nil

	arg_15_1:setColor(cc.c3b(255, 255, 255))
	self:updateItemSelectLayout()
end

function ActivityNinifaCompositeLayer:initItemSelectLayout()
	self.itemSelectLayout = self.rootLayer:getChildByName("item_select_layout")

	for iter_16_0 = 1, 3 do
		self.itemSelectLayout:getChildByName("item_bg_" .. iter_16_0):getChildByName("item_" .. iter_16_0):addTouchEventListener(function(arg_17_0, arg_17_1)
			if arg_17_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.selectItems[iter_16_0] then
				self.selectItems[iter_16_0] = nil

				self:updateItemList()
				self:updateItemSelectLayout()
			end

			self:switchShowItemListLayout()
		end)
	end
end

function ActivityNinifaCompositeLayer:updateItemSelectLayout()
	if not next(self.selectItems) then
		for iter_18_0 = 1, 3 do
			local var_18_0 = self.itemSelectLayout:getChildByName("item_bg_" .. iter_18_0)
			local var_18_1 = var_18_0:getChildByName("item_" .. iter_18_0)

			var_18_0:loadTexture(var_0_3[self.selectQuality], var_0_2)
			var_18_1:loadTexture("ActivityNinifaCompositeLayer/need_add.png", var_0_2)
		end

		return
	end

	for iter_18_1 = 1, 3 do
		local var_18_2 = self.itemSelectLayout:getChildByName("item_bg_" .. iter_18_1)
		local var_18_3 = var_18_2:getChildByName("item_" .. iter_18_1)

		var_18_2:loadTexture(var_0_3[self.selectQuality], var_0_2)

		if not self.selectItems[iter_18_1] then
			var_18_3:loadTexture("ActivityNinifaCompositeLayer/need_add.png", var_0_2)
		else
			var_18_3:loadTexture("equipment/" .. self.selectItems[iter_18_1] .. ".png")
		end
	end
end

function ActivityNinifaCompositeLayer:initStartCompoundLayout()
	local var_19_0 = self.rootLayer:getChildByName("start_compound_layout")
	local var_19_1 = var_19_0:getChildByName("count_lbl")
	local var_19_2 = var_19_0:getChildByName("btn_start_compound")

	var_19_2:getChildByName("start_compound_lbl"):setString(L_ACTIVITY_NINIFA.START_COMPOUND)
	var_19_2:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not activity_ninifa_manager:checkCanCoumpound(self.selectItems[1], self.selectItems[2], self.selectItems[3], self.compountCount) then
			return
		end

		if self.isCompounding then
			return
		end

		local function var_20_0()
			self.isCompounding = false

			self.weaponImg:setVisible(true)
			activity_ninifa_manager:startCompound(self.selectItems[1], self.selectItems[2], self.selectItems[3], self.compountCount)
		end

		self.isCompounding = true

		self:switchShowWeaponLayout(function()
			for iter_22_0 = 1, 3 do
				self.itemSelectLayout:getChildByName("item_bg_" .. iter_22_0):getChildByName("item_" .. iter_22_0):runAction(cc.Sequence:create(cc.FadeOut:create(0.2)))
			end

			self.weaponImg:setVisible(false)
			self:playComSpineEffect(var_20_0)
		end)
	end)

	local var_19_3 = var_19_0:getChildByName("count_bg")
	local var_19_4 = var_19_3:getChildByName("num_lbl")
	local var_19_5 = var_19_3:getChildByName("btn_reduce")

	l2utils:registerDelayPressEvent(var_19_5, 0.3, 0.1, function()
		self.compountCount = self.compountCount - 1

		if self.compountCount < 1 then
			self.compountCount = 1
		end

		var_19_4:setString(tostring(self.compountCount))
	end)
	var_19_5:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 == ccui.TouchEventType.began then
			var_19_5:startDelayPressEvent()
		elseif arg_24_1 == ccui.TouchEventType.moved then
			var_19_5:stopDelayPressEvent()
		elseif arg_24_1 == ccui.TouchEventType.ended then
			var_19_5:stopDelayPressEvent()

			self.compountCount = self.compountCount - 1

			if self.compountCount < 1 then
				self.compountCount = 1
			end

			var_19_4:setString(tostring(self.compountCount))
		end
	end)

	local var_19_6 = var_19_3:getChildByName("btn_add")

	l2utils:registerDelayPressEvent(var_19_6, 0.3, 0.1, function()
		self.compountCount = self.compountCount + 1

		if self.compountCount > 99 then
			self.compountCount = 99
		end

		var_19_4:setString(tostring(self.compountCount))
	end)
	var_19_6:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 == ccui.TouchEventType.began then
			var_19_6:startDelayPressEvent()
		elseif arg_26_1 == ccui.TouchEventType.moved then
			var_19_6:stopDelayPressEvent()
		elseif arg_26_1 == ccui.TouchEventType.ended then
			var_19_6:stopDelayPressEvent()

			self.compountCount = self.compountCount + 1

			if self.compountCount > 99 then
				self.compountCount = 99
			end

			var_19_4:setString(tostring(self.compountCount))
		end
	end)
end

function ActivityNinifaCompositeLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchReturnLayer("ActivityNinifaLayer")
	end, {
		{
			texture = "ActivityNinifaCompositeLayer/btn_record.png",
			name = "go_record",
			word = "",
			handler = function(arg_29_0, arg_29_1)
				if arg_29_1 ~= ccui.TouchEventType.ended then
					return
				end

				LayerManager:pushInLayer("PopNinifaRecordLayer")
			end
		},
		{
			texture = "ActivityNinifaCompositeLayer/btn_illustrated.png",
			name = "go_illustrateds",
			word = "",
			handler = function(arg_30_0, arg_30_1)
				if arg_30_1 ~= ccui.TouchEventType.ended then
					return
				end

				LayerManager:pushInLayer("PopNinifaIllustrateLayer")
			end
		}
	})

	self.bottomList:setName("bottomlist")
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
	self.rootLayer:addChild(self.bottomList, 2)

	local var_27_0 = self.bottomList:getChildByName("go_illustrateds")

	var_27_0:setPositionX(var_27_0:getPositionX() + 20)
end

function ActivityNinifaCompositeLayer:switchShowItemListLayout(arg_31_1)
	self:updateItemList()

	local var_31_0 = self.rootLayer:getChildByName("compound_bg")
	local var_31_1 = self.rootLayer:getChildByName("select_item_layout")

	var_31_0:runAction(cc.Sequence:create(cc.ScaleTo:create(0, 1, 1), cc.CallFunc:create(function()
		var_31_0:setVisible(true)
	end)))
	var_31_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
		var_31_1:setVisible(true)
	end), cc.ScaleTo:create(0, 1, 1), cc.CallFunc:create(function()
		if arg_31_1 then
			arg_31_1()
		end
	end)))
end

function ActivityNinifaCompositeLayer:switchShowWeaponLayout(arg_35_1)
	local var_35_0 = self.rootLayer:getChildByName("compound_bg")
	local var_35_1 = self.rootLayer:getChildByName("select_item_layout")

	self.weaponImg = var_35_0:getChildByName("weapon_img")

	var_35_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0, 1, 1), cc.CallFunc:create(function()
		var_35_1:setVisible(true)
	end)))
	var_35_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
		var_35_0:setVisible(true)
	end), cc.ScaleTo:create(0, 1, 1), cc.CallFunc:create(function()
		if arg_35_1 then
			arg_35_1()
		end
	end)))
end

function ActivityNinifaCompositeLayer:isItemBeSelected(arg_39_1)
	if not next(self.selectItems) then
		return false
	end

	for iter_39_0, iter_39_1 in pairs(self.selectItems) do
		if iter_39_1 == arg_39_1 then
			return true
		end
	end

	return false
end

function ActivityNinifaCompositeLayer:insertSelectedItem(arg_40_1)
	for iter_40_0 = 1, 3 do
		if self.selectItems[iter_40_0] == nil then
			self.selectItems[iter_40_0] = arg_40_1

			self:updateItemSelectLayout()

			return
		end
	end
end

function ActivityNinifaCompositeLayer:playComSpineEffect(arg_41_1)
	audio_manager:playeffectMusicTest("sound/ninifa_open")

	if not self.skeletonData then
		self.skeletonData = SpineCacheManager:addSpineData(UI_SPINE_PATH .. "ninifa_hecheng.json", UI_SPINE_PATH .. "ninifa_hecheng.atlas")

		self.skeletonData:retain()
	end

	local var_41_0 = ccui.Layout:create()

	var_41_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_41_0:setAnchorPoint(cc.p(0, 0))
	var_41_0:setPosition(cc.p(-96, 50))
	var_41_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_41_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_41_0:setBackGroundColorOpacity(0)
	cc.Director:getInstance():getRunningScene():addChild(var_41_0, 1000)
	var_41_0:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function(...)
		if arg_41_1 then
			arg_41_1()
		end
	end), cc.RemoveSelf:create()))
	var_41_0:setTouchEnabled(true)
	var_41_0:addTouchEventListener(function(arg_43_0, arg_43_1)
		if arg_43_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_41_0:runAction(cc.RemoveSelf:create())

		if arg_41_1 then
			arg_41_1()
		end
	end)

	local var_41_1 = sp.SkeletonAnimation:create(self.skeletonData:getData())

	var_41_1:setPositionX(GameDisplay.width / 2)
	var_41_1:setPositionY(GameDisplay.height / 2 + 80)
	var_41_0:addChild(var_41_1)
	var_41_1:setAnimation(0, "ninifa_hecheng", false)
end

function ActivityNinifaCompositeLayer:whenNeedDirectToCompoud(arg_44_1)
	if not activity_ninifa_manager:checkCanCoumpound(arg_44_1.data.need_item1, arg_44_1.data.need_item2, arg_44_1.data.need_item3, 1) then
		return
	end

	LayerManager:removePopLayer()

	self.selectItems = {
		arg_44_1.data.need_item1,
		arg_44_1.data.need_item2,
		arg_44_1.data.need_item3
	}
	self.compountCount = 1
	self.selectQuality = item_data[arg_44_1.data.need_item1].equip_quality

	print(self.selectQuality, dump(item_data[arg_44_1.data.need_item1]))
	self.rootLayer:getChildByName("start_compound_layout"):getChildByName("count_bg"):getChildByName("num_lbl"):setString(tostring(self.compountCount))
	self:updateItemSelectLayout()
	self:switchShowItemListLayout()
end
