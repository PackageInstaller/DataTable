PopWeaponUpLevelList = class("PopWeaponUpLevelList", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local weapon_manager = require("controller.weapon_manager")
local audio_manager = require("controller.audio_manager")
local core_manager = require("controller.core_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local Utility = require("common.Utility")
local LocalEvent = require("common.LocalEvent")

function PopWeaponUpLevelList.create(arg_2_0, arg_2_1)
	local var_2_0 = PopWeaponUpLevelList.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopWeaponUpLevelList:init(arg_3_1)
	print(dump(arg_3_1))
	LayerManager:createFullScreenMask(self, 120, function()
		return
	end)

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopWeaponUpLevelList.json" or "PopWeaponUpLevelList.ExportJson")

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2 - GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.initParam = arg_3_1
	self.activity = true

	self:initData()
	self:updateData()
	self:initUI()
	self:updaeWeaponAttr()
	self:JumpToLevel(self.curIndex, 0)
	Utility:registerNodeEvent(self)
	LocalEvent:registerEvent(self, LocalEvent.EVENT_IDS.COMPOUND_ITEM_ONE_KEY, handler(self, self.handleCompoundOneKey))
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("on_buy_shop", function(arg_5_0)
		self:onBuyShop()
	end), self)
end

function PopWeaponUpLevelList.onExit(arg_6_0)
	LocalEvent:removeEvent(arg_6_0)
end

function PopWeaponUpLevelList:initData()
	if self.initParam.entityid then
		self.entityid = self.initParam.entityid
		self.itemid = playermodel.items[self.entityid].itemid
		self.level = playermodel.items[self.entityid].weapon_attr.level
		self.surecallback = self.initParam.surecallback
	else
		self.itemid = self.initParam.itemid
		self.level = -1
	end

	self.goto_back_system_id = self.initParam.goto_back_system_id

	local var_7_0 = 0

	while item_data[self.itemid]["lv" .. var_7_0 + 1 .. "_attr1"] do
		var_7_0 = var_7_0 + 1
	end

	self.servantRank = core_manager:getServantCoreRank(self.servantid)
	self.limit = weapon_manager:getWeponCurMaxLevel(self.servantRank)
	self.maxRank = #WEAPON_SERVANT_LIMIT
	self.passEvent = true
	self.maxLevel = var_7_0
	self.curIndex = self.level + 1
end

function PopWeaponUpLevelList:updateData()
	if self.entityid then
		self.level = playermodel.items[self.entityid].weapon_attr.level
	end

	self.weaponAddAttr = weapon_manager:getWeaponAddMainAttr(self.itemid, self.maxLevel)
	self.servantid = item_data[self.itemid].servant
	self.servantRank = core_manager:getServantCoreRank(self.servantid)
	self.limit = weapon_manager:getWeponCurMaxLevel(self.servantRank)
	self.limit = math.max(self.limit, self.level)

	if self.limit == self.level then
		self.showLevel = self.limit

		if self.showLevel > self.maxLevel then
			self.showLevel = self.maxLevel
		end
	else
		self.showLevel = self.limit
	end

	self.curIndex = math.min(self.curIndex, self.showLevel)
end

local var_0_10 = 178
local var_0_11 = {
	0,
	120,
	-62,
	16,
	-74,
	120,
	120,
	-74,
	60,
	-62,
	110,
	110,
	-74,
	60,
	0
}

setmetatable(var_0_11, {
	__index = function(arg_9_0, arg_9_1)
		if arg_9_1 > 15 then
			return var_0_11[arg_9_1 % 15]
		end
	end
})

local var_0_12 = {
	[0] = {
		angle = 90,
		len = 178
	},
	{
		angle = 56.012831,
		len = 214.671843
	},
	{
		angle = 135.63794,
		len = 254.574154
	},
	{
		angle = 66.336161,
		len = 194.339908
	},
	{
		angle = 116.822772,
		len = 199.459269
	},
	{
		angle = 42.535783,
		len = 263.286916
	},
	{
		angle = 90,
		len = 178
	},
	{
		angle = 137.464217,
		len = 263.286916
	},
	{
		angle = 53.026147,
		len = 222.800359
	},
	{
		angle = 124.427492,
		len = 215.7962
	},
	{
		angle = 45.980819,
		len = 247.523736
	},
	{
		angle = 90,
		len = 178
	},
	{
		angle = 135.950922,
		len = 256.007812
	},
	{
		angle = 53.026147,
		len = 222.800359
	},
	{
		angle = 108.628413,
		len = 187.840358
	},
	{
		angle = 90,
		len = 178
	}
}

setmetatable(var_0_12, {
	__index = function(arg_10_0, arg_10_1)
		if arg_10_1 > 15 then
			return var_0_12[arg_10_1 % 15]
		end
	end
})

function PopWeaponUpLevelList.getNodePosY(arg_11_0, arg_11_1)
	return (var_0_11[arg_11_1] or 0) + 200
end

local var_0_13 = 0.1

function PopWeaponUpLevelList:initUI()
	self.levelNodeList = {}
	self.levelLineList = {}
	self.scrollView = ccui.Helper:seekWidgetByName(self.rootLayer, "ScrollView_list")
	self.innerContainer = self.scrollView:getInnerContainer()

	self.scrollView:setContentSize(cc.size(GameDisplay.width, 380 + GameDisplay.fix_y))
	self.scrollView:setPosition(cc.p(0, 320 + GameDisplay.fix_y / 2))
	self.innerContainer:setContentSize(cc.size(var_0_10 * self.showLevel + self:getLockArenaWidth(), 380 + GameDisplay.fix_y))
	self.scrollView:addEventListener(function(arg_13_0, arg_13_1)
		return
	end)

	for iter_12_0 = 1, 3 do
		local var_12_0 = ItemSmallSprite:createSmallItem()

		var_12_0:setName("materialNode" .. iter_12_0)
		var_12_0:setScale(0.7)
		var_12_0:setInfoTouchEvent(true)
		var_12_0:setPosition(cc.p(100 + (iter_12_0 - 1) * 150, -10 + ccui.Helper:seekWidgetByName(self.rootLayer, "Image_infoBg"):getContentSize().height / 2))
		var_12_0:registerGotoSystemCallback(function(arg_14_0)
			AnalyticManager.goto_gain_break_item({
				itemid = arg_14_0
			})
		end)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_infoBg"):addChild(var_12_0)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):addTouchEventListener(self:getSureHandel())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_infoBg"):setOpacity(0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_infoBg"):runAction(cc.FadeIn:create(var_0_13))
	self:updateAttrPanel()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_attr"):setVisible(false)

	local function var_12_1(...)
		for iter_15_0 = 1, self.showLevel do
			local var_15_0 = self:createLine()

			var_15_0:update(iter_15_0)

			local var_15_1 = (self:getNodePosY(iter_15_0) + self:getNodePosY(iter_15_0 + 1)) / 2

			var_15_0:setPositionX((var_0_10 * iter_15_0 + var_0_10 * (iter_15_0 + 1)) / 2 - var_0_10 / 2)
			var_15_0:setPositionY(var_15_1)
			self.scrollView:addChild(var_15_0)
			table.insert(self.levelLineList, var_15_0)

			local var_15_2 = self:createLevelSp()

			var_15_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_15_2:update(iter_15_0)
			var_15_2:setPositionX(var_0_10 * iter_15_0 - var_0_10 / 2)
			var_15_2:setPositionY(self:getNodePosY(iter_15_0))
			var_15_2:addTouchEventListener(self:getLevelNodeTouchHandel())
			self.scrollView:addChild(var_15_2)
			table.insert(self.levelNodeList, var_15_2)

			if iter_15_0 % 5 == 0 then
				var_15_2:setScale(1.092)
			else
				var_15_2:setScale(0.84)
			end

			var_15_0:setOpacity(0)
			var_15_2:setOpacity(0)
			var_15_0:runAction(cc.FadeIn:create(0))
			var_15_2:runAction(cc.FadeIn:create(0))
		end

		self:resetCurSelectAttr()
		self:scaleCurSelectLevelNode()

		if self.showLevel < self:getWeaponMaxLevel() then
			self:addLockArena()
		end

		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_attr"):setVisible(true)
	end

	self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function(...)
		var_12_1()
	end)))
	self:initBottomBtnList()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_weaponBg"):setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Image_weaponBg"):getPositionY() + GameDisplay.fix_y * 2)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_upStar"):addTouchEventListener(self:getStartUpHandel())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_buttonStarUpDes"):setString(L_STAR_UP)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg"):setContentSize(cc.size(640, 624 + GameDisplay.fix_y * 2))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_32"):setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Image_32"):getPositionY() + GameDisplay.fix_y)
end

function PopWeaponUpLevelList:updateAllLevelNode()
	for iter_17_0, iter_17_1 in pairs(self.levelNodeList) do
		iter_17_1:update(iter_17_0)
	end

	for iter_17_2, iter_17_3 in pairs(self.levelLineList) do
		iter_17_3:update(iter_17_2)
	end
end

function PopWeaponUpLevelList:addLockArena()
	local var_18_0 = var_0_10 * self.showLevel + self:getLockArenaWidth() - 76
	local var_18_1 = math.max(1, #self.levelNodeList)
	local var_18_2 = self.levelNodeList[#self.levelNodeList]:getPositionY()
	local var_18_3 = ccui.ImageView:create("PopWeaponUpLevelList/lock_line.png", var_0_0)

	var_18_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_18_3:setScale9Enabled(true)
	var_18_3:setContentSize(cc.size(math.pow(math.pow(((380 + GameDisplay.fix_y) / 2 + var_18_2) / 2 - var_18_2, 2) + math.pow(var_0_10, 2), 0.5), var_18_3:getContentSize().height))
	var_18_3:runAction(cc.RotateTo:create(0, math.atan((var_18_2 - ((380 + GameDisplay.fix_y) / 2 + var_18_2) / 2) / var_0_10) * 180 / 3.1415))
	var_18_3:setPosition(cc.p((var_18_0 + self.levelNodeList[#self.levelNodeList]:getPositionX()) / 2, ((380 + GameDisplay.fix_y) / 2 + var_18_2) / 2))
	self.innerContainer:addChild(var_18_3, -1)

	if self.servantRank < self.maxRank then
		local var_18_4 = ccui.ImageView:create("PopWeaponUpLevelList/break_bg.png", var_0_0)

		var_18_4:setAnchorPoint(cc.p(0, 0.5))
		var_18_4:setScale9Enabled(true)
		var_18_4:setScaleY((var_18_4:getContentSize().height + GameDisplay.fix_y * 2) / var_18_4:getContentSize().height)
		var_18_4:setPosition(cc.p(var_18_0 + 6, (380 + GameDisplay.fix_y) / 2))
		self.innerContainer:addChild(var_18_4)

		local var_18_5 = ccui.ImageView:create("PopWeaponUpLevelList/break_" .. self.servantRank + 1 .. ".png", var_0_0)

		var_18_5:setAnchorPoint(cc.p(0, 0.5))
		var_18_5:setPosition(cc.p(var_18_0, (380 + GameDisplay.fix_y) / 2))
		self.innerContainer:addChild(var_18_5)
	end
end

function PopWeaponUpLevelList.getWeaponMaxLevel(arg_19_0)
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in pairs(WEAPON_SERVANT_LIMIT) do
		var_19_0 = math.max(var_19_0, iter_19_1.limit)
	end

	return var_19_0
end

function PopWeaponUpLevelList.createLevelSp(arg_20_0)
	local var_20_0 = ccui.ImageView:create("PopWeaponUpLevelList/attr_bg1_on.png", var_0_0)

	var_20_0:setTouchEnabled(true)

	local var_20_1 = cc.Label:createWithTTF("等级.-1", FONT_NAME, 20)

	var_20_1:setName("levelLabel")
	var_20_1:setPositionX(var_20_0:getContentSize().width / 2)
	var_20_1:setPositionY(-2)
	var_20_0:addChild(var_20_1)

	function var_20_0:update(arg_21_1)
		self:getChildByName("levelLabel"):setString("等级." .. arg_21_1)

		self.level = arg_21_1

		if arg_21_1 % 5 == 0 then
			if arg_21_1 <= arg_20_0.level then
				self:loadTexture("PopWeaponUpLevelList/attr_bg1_on.png", var_0_0)
			elseif arg_21_1 == arg_20_0.level + 1 then
				self:loadTexture("PopWeaponUpLevelList/attr_bg1_next.png", var_0_0)
			else
				self:loadTexture("PopWeaponUpLevelList/attr_bg1.png", var_0_0)
			end
		else
			local var_21_0 = item_data[arg_20_0.itemid]["lv" .. arg_21_1 .. "_attr1"]

			if arg_21_1 <= arg_20_0.level then
				self:loadTexture("PopWeaponUpLevelList/attr_bg_" .. var_21_0 .. "_on.png", var_0_0)
			elseif arg_21_1 == arg_20_0.level + 1 then
				self:loadTexture("PopWeaponUpLevelList/attr_bg_" .. var_21_0 .. "_next.png", var_0_0)
			else
				self:loadTexture("PopWeaponUpLevelList/attr_bg_" .. var_21_0 .. ".png", var_0_0)
			end
		end
	end

	return var_20_0
end

function PopWeaponUpLevelList.createLine(arg_22_0)
	local var_22_0 = ccui.ImageView:create("PopWeaponUpLevelList/line_off.png", var_0_0)

	var_22_0:setName("line")
	var_22_0:setScale9Enabled(true)
	var_22_0:setAnchorPoint(cc.p(0.5, 0.5))

	function var_22_0:update(arg_23_1)
		self:setContentSize(cc.size(self:getContentSize().width, var_0_12[arg_23_1].len))
		self:runAction(cc.RotateTo:create(0, var_0_12[arg_23_1].angle))
		self:setVisible(arg_23_1 < arg_22_0.showLevel)

		if arg_23_1 < arg_22_0.level then
			self:loadTexture("PopWeaponUpLevelList/line_on.png", var_0_0)
		elseif arg_23_1 == arg_22_0.level then
			self:loadTexture("PopWeaponUpLevelList/line_next.png", var_0_0)
		else
			self:loadTexture("PopWeaponUpLevelList/line_off.png", var_0_0)
		end
	end

	return var_22_0
end

function PopWeaponUpLevelList.getLockArenaWidth(arg_24_0)
	return 150
end

function PopWeaponUpLevelList:updateAttrPanel()
	local var_25_0 = math.max(1, self.curIndex)
	local var_25_2 = {}
	local var_25_3 = item_data[self.itemid]["lv" .. var_25_0 .. "_cost"] or 0
	local var_25_4 = var_25_3 <= playermodel.gold
	local var_25_5 = 1

	while item_data[self.itemid]["lv" .. var_25_0 .. "_material" .. var_25_5] do
		local var_25_6 = item_manager:getItemNumber(item_data[self.itemid]["lv" .. var_25_0 .. "_material" .. var_25_5])

		var_25_4 = var_25_4 and item_data[self.itemid]["lv" .. var_25_0 .. "_material" .. var_25_5 .. "_num"] <= var_25_6

		table.insert(var_25_2, {
			itemid = item_data[self.itemid]["lv" .. var_25_0 .. "_material" .. var_25_5],
			needNum = item_data[self.itemid]["lv" .. var_25_0 .. "_material" .. var_25_5 .. "_num"],
			ownNum = var_25_6
		})

		var_25_5 = var_25_5 + 1
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "materialNode1"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "materialNode2"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "materialNode3"):setVisible(false)
	table.insert(var_25_2, {
		itemid = "gold",
		needNum = var_25_3,
		ownNum = playermodel.gold
	})

	for iter_25_0, iter_25_1 in pairs(var_25_2) do
		local var_25_7 = ccui.Helper:seekWidgetByName(self.rootLayer, "materialNode" .. iter_25_0)

		var_25_7:setVisible(true)
		var_25_7:updateSmallItemByItemid(iter_25_1.itemid, iter_25_1.ownNum, iter_25_1.needNum, self.goto_back_system_id)
	end

	;(function()
		if self.level >= self.limit then
			if self.level == self.maxLevel then
				ccui.Helper:seekWidgetByName(self.rootLayer, "Label_buttonDes"):setString(L_LEVEL_MAX)
			elseif self.level == self.limit then
				ccui.Helper:seekWidgetByName(self.rootLayer, "Label_buttonDes"):setString(L_ARRIVE_LIMIT)
			else
				ccui.Helper:seekWidgetByName(self.rootLayer, "Label_buttonDes"):setString(L_WEAPON_UP_BTN)
			end

			ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):loadTextures("public/button/public_button_gray.png", nil, "public/button/public_button_gray.png", var_0_0)
		else
			ccui.Helper:seekWidgetByName(self.rootLayer, "Label_buttonDes"):setString(L_WEAPON_UP_BTN)

			if self.curIndex ~= self.level + 1 then
				ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):loadTextures("public/button/public_button_gray.png", nil, "public/button/public_button_gray.png", var_0_0)
			elseif item_data[self.itemid]["lv" .. var_25_0 .. "_cost"] > playermodel.gold or not var_25_4 then
				ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):loadTextures("public/button/public_button_gray.png", nil, "public/button/public_button_gray.png", var_0_0)
			else
				ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):loadTextures("public/button/public_button_normal_y.png", nil, "public/button/public_button_normal_y.png", var_0_0)
			end
		end
	end)()
end

function PopWeaponUpLevelList:JumpToLevel(arg_27_1, arg_27_2)
	arg_27_1 = math.max(1, arg_27_1)
	arg_27_1 = math.min(arg_27_1, self.showLevel)
	arg_27_2 = arg_27_2 or 0.2

	self.innerContainer:stopAllActions()

	local var_27_1 = arg_27_1 < GameDisplay.width / 2 / var_0_10 and 0 or arg_27_1 > self.showLevel - math.ceil(self:getLockArenaWidth() / var_0_10) and 100 or (arg_27_1 - GameDisplay.width * 0.63 / var_0_10) / (self.showLevel - GameDisplay.width / var_0_10) * 100 * (self.showLevel * var_0_10 - GameDisplay.width - self:getLockArenaWidth()) / (self.showLevel * var_0_10 - GameDisplay.width)

	if 0 <= 0 then
		var_27_1 = 0.1
	end

	if var_27_1 >= 100 then
		var_27_1 = 100
	end

	self.scrollView:scrollToPercentHorizontal(var_27_1, arg_27_2 or 0.2, false)
end

function PopWeaponUpLevelList.getSureHandel(arg_28_0)
	return function(arg_29_0, arg_29_1)
		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_28_0.curIndex ~= arg_28_0.level + 1 then
			if arg_28_0.curIndex == arg_28_0.maxLevel then
				global_ShowBlockWords(L_LEVEL_MAX)
			elseif arg_28_0.curIndex == arg_28_0.limit then
				global_ShowBlockWords(L_ARRIVE_LEVEL_LIMIT)
			end

			return
		end

		if not arg_29_0:isBright() then
			return
		end

		arg_29_0:setBright(false)
		weapon_manager:strengthenWeapon(arg_28_0.entityid, nil, function(arg_30_0)
			if not arg_28_0.activity then
				return
			end

			arg_29_0.islock = false

			if arg_30_0 == 1 then
				audio_manager:playeffectMusic("sound/upgrade")
				arg_28_0:updateData()
				arg_28_0:updateAttrPanel()
				arg_28_0:updateAllLevelNode()

				arg_28_0.curIndex = math.min(arg_28_0.level + 1, arg_28_0.showLevel)

				arg_28_0:JumpToLevel(arg_28_0.curIndex)
				arg_28_0:updateAttrPanel()
				arg_28_0:updateCurSelectAttr()
				arg_28_0:scaleCurSelectLevelNode()
				arg_28_0:updaeWeaponAttr()

				local var_30_0 = {}

				while item_data[arg_28_0.itemid]["lv" .. arg_28_0.level .. "_attr" .. 1 .. "_value"] do
					table.insert(var_30_0, FIGHT_ATTR_INFO[item_data[arg_28_0.itemid]["lv" .. arg_28_0.level .. "_attr" .. 1]] .. ": +" .. FIGHT_ATTR_FORMAT(item_data[arg_28_0.itemid]["lv" .. arg_28_0.level .. "_attr" .. 1], item_data[arg_28_0.itemid]["lv" .. arg_28_0.level .. "_attr" .. 1 .. "_value"] * ATTR_TRANS_FAC[item_data[arg_28_0.itemid]["lv" .. arg_28_0.level .. "_attr" .. 1]]))
				end

				require("controller.fight_capacity_manager"):showUpgrade(var_30_0)
			elseif arg_30_0 == 2 then
				global_ShowBlockWords(L_WEAPON_STRENGTHEN.Fail[2])
				audio_manager:playeffectMusicTest("sound/invalid")
			elseif arg_30_0 == 3 then
				global_ShowBlockWords(L_WEAPON_STRENGTHEN.Fail[3])
				audio_manager:playeffectMusicTest("sound/invalid")
			elseif arg_30_0 == 4 then
				global_ShowBlockWords(L_GOLD_LACK)
				audio_manager:playeffectMusicTest("sound/invalid")
				LayerManager:pushInLayer("HandOfMidasLayer", {
					callback = function()
						arg_28_0:updateAttrPanel()
					end
				})
			elseif arg_30_0 == 5 then
				global_ShowBlockWords(L_WEAPON_STRENGTHEN.Fail[5])
				audio_manager:playeffectMusicTest("sound/invalid")
			elseif arg_30_0 == 7 then
				global_ShowBlockWords(L_WEAPON_STRENGTHEN.Fail[7])
			end

			arg_29_0:setBright(true)
		end)
	end
end

function PopWeaponUpLevelList.getLevelNodeTouchHandel(arg_32_0, arg_32_1, arg_32_2)
	return function(arg_33_0, arg_33_1)
		if arg_33_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_32_0:JumpToLevel(arg_33_0.level, 0.2)

		arg_32_0.curIndex = arg_33_0.level

		arg_32_0:updateAttrPanel()
		arg_32_0:updateCurSelectAttr()
		arg_32_0:scaleCurSelectLevelNode()
	end
end

function PopWeaponUpLevelList:updateCurSelectAttr()
	local var_34_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_attr")

	var_34_0:stopAllActions()
	var_34_0:runAction(cc.Sequence:create(cc.FadeOut:create(0.08), cc.DelayTime:create(0.04), cc.CallFunc:create(function()
		self:resetCurSelectAttr()
	end), cc.FadeIn:create(0.08)))
end

function PopWeaponUpLevelList:resetCurSelectAttr()
	local var_36_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_attr")

	for iter_36_0 = 1, 2 do
		var_36_0:getChildByName("Label_attr" .. iter_36_0):setVisible(false)

		if item_data[self.itemid]["lv" .. self.curIndex .. "_attr" .. iter_36_0] then
			local var_36_2 = FIGHT_ATTR_FORMAT[self.weaponAddAttr[self.curIndex][iter_36_0].attrtype](self.weaponAddAttr[self.curIndex][iter_36_0].value * (ATTR_TRANS_FAC[self.weaponAddAttr[self.curIndex][iter_36_0].attrtype] or 1))

			var_36_0:getChildByName("Label_attr" .. iter_36_0):setVisible(true)
			var_36_0:getChildByName("Label_attr" .. iter_36_0):setString(FIGHT_ATTR_INFO[self.weaponAddAttr[self.curIndex][iter_36_0].attrtype] .. "+" .. var_36_2)
		end
	end

	var_36_0:setPositionX(self.curIndex * var_0_10 - var_0_10 / 2)

	if self.curIndex % 5 == 0 then
		var_36_0:setPositionY(self:getNodePosY(self.curIndex) - 120)
	else
		var_36_0:setPositionY(self:getNodePosY(self.curIndex) - 110)
	end
end

function PopWeaponUpLevelList.scaleCurSelectLevelNode(arg_37_0)
	return
end

function PopWeaponUpLevelList:initBottomBtnList()
	self.bottomList = BottomBtnList:create(function(arg_39_0, arg_39_1)
		if arg_39_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.initParam and self.initParam.exitCallback then
			self.initParam.exitCallback()
		end

		LayerManager:removePopLayer()
	end)

	self.bottomList:setName("bottomBtn")
	self.rootLayer:addChild(self.bottomList, 10)
end

local function var_0_14(arg_40_0)
	return ({
		[2227201] = 0.44,
		[2215111] = 0.56,
		[2220201] = 0.52,
		[2215201] = 0.64,
		[2209201] = 0.5,
		[2206201] = 0.5,
		[2215051] = 0.5,
		[2208201] = 0.6,
		[2228201] = 0.54,
		[2219201] = 0.52,
		[2208021] = 0.58,
		[2229101] = 0.34,
		[2231201] = 0.5,
		[2210201] = 0.5,
		[2225201] = 0.52,
		[2234001] = 0.54,
		[2229201] = 0.34,
		[2238001] = 0.52,
		[2218201] = 0.52,
		[2207201] = 0.5,
		[2214301] = 0.62,
		[2237201] = 0.62,
		[2233201] = 0.56,
		[2226201] = 0.42,
		[2210051] = 0.56,
		[2240201] = 0.5,
		[2232201] = 0.58,
		[2211041] = 0.5,
		[2206021] = 0.48,
		[2223201] = 0.5,
		[2241201] = 0.58,
		[2248001] = 0.54,
		[2216201] = 0.52,
		[2205201] = 0.5,
		[2212041] = 0.53,
		[2251001] = 0.42,
		[2201041] = 0.5,
		[2253001] = 0.44,
		[2213201] = 0.58,
		[2239201] = 0.44,
		[2203031] = 0.56,
		[2254001] = 0.52,
		[2214031] = 0.52,
		[2221201] = 0.54,
		[2255201] = 0.44,
		[2260001] = 0.5,
		[2216301] = 0.54,
		[2203201] = 0.53,
		[2205021] = 0.5,
		[2211201] = 0.52,
		[2204201] = 0.5,
		[2202021] = 0.5,
		[2208101] = 0.6,
		[2212201] = 0.61,
		[2201201] = 0.52
	})[arg_40_0] or 0.5
end

function PopWeaponUpLevelList:updaeWeaponAttr()
	local var_41_9000

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_subAttr"):setString(L_WEAPON_SUB_ATTR)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_mainAttr"):setString(L_WEAPON_MAIN_ATTR)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_weaponIcon"):setScale(var_0_14(item_data[self.itemid].image_id))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_weaponIcon"):loadTexture("weaponIcon/" .. item_data[self.itemid].image_id .. ".png")
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_weaponName"):setString(item_data[self.itemid].name)

	local var_41_0 = playermodel.items[self.entityid].weapon_attr.nowStars

	for iter_41_0 = 1, 5 do
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_star" .. iter_41_0):setVisible(false)

		if var_41_0 >= iter_41_0 + 5 then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_star" .. iter_41_0):setVisible(true)
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_star" .. iter_41_0):loadTexture("public/currency/pink_star.png", var_0_0)
		elseif var_41_0 <= 5 and iter_41_0 <= var_41_0 then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_star" .. iter_41_0):setVisible(true)
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_star" .. iter_41_0):loadTexture("public/currency/weapon_star.png", var_0_0)
		end
	end

	if weapon_manager:checkIsCanUpgrade(self.entityid) then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_upStarReddot"):setVisible(true)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_upStarReddot"):setVisible(false)
	end

	local var_41_1 = weapon_manager:getWeaponAddMainAttr(self.itemid, self.level)

	table.insert(var_41_1, {
		{
			attrtype = item_data[self.itemid].main_attr,
			value = item_data[self.itemid].value
		}
	})

	local var_41_2 = {}

	for iter_41_1, iter_41_2 in pairs(var_41_1) do
		for iter_41_3, iter_41_4 in pairs(iter_41_2) do
			var_41_2[iter_41_4.attrtype] = var_41_2[iter_41_4.attrtype] or 0
			var_41_2[iter_41_4.attrtype] = var_41_2[iter_41_4.attrtype] + iter_41_4.value
		end
	end

	local var_41_3 = ""
	local var_41_4 = ""
	local var_41_5 = 1

	for iter_41_5, iter_41_6 in pairs(var_41_2) do
		if var_41_5 % 2 == 1 then
			local var_41_6 = ATTR_TRANS_FAC[iter_41_5] or 1

			var_41_3 = var_41_3 .. FIGHT_ATTR_INFO[iter_41_5] .. " + " .. FIGHT_ATTR_FORMAT[iter_41_5](iter_41_6 * var_41_6) .. "\n"
		else
			local var_41_8 = ATTR_TRANS_FAC[iter_41_5] or 1

			var_41_4 = var_41_4 .. var_41_9000 .. " + " .. FIGHT_ATTR_FORMAT[iter_41_5](iter_41_6 * var_41_8) .. "\n"
		end

		var_41_5 = var_41_5 + 1
	end

	local var_41_11 = ""

	for iter_41_7, iter_41_8 in pairs((weapon_manager:getWeaponAddSubAttr(self.itemid, var_41_0))) do
		var_41_11 = var_41_11 .. FIGHT_ATTR_INFO[iter_41_8.attrtype] .. " + " .. FIGHT_ATTR_FORMAT[iter_41_8.attrtype](iter_41_8.value) .. "\n"
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_attrDes"):setString(var_41_11)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_attrDes1"):setString(var_41_3)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_attrDes2"):setString(var_41_4)
end

local function var_0_15(arg_42_0, arg_42_1)
	for iter_42_0, iter_42_1 in pairs(arg_42_0) do
		if iter_42_1.attrtype == arg_42_1 then
			return iter_42_1.value
		end
	end

	return 0
end

function PopWeaponUpLevelList.getStartUpHandel(arg_43_0)
	return function(arg_44_0, arg_44_1)
		if arg_44_1 ~= ccui.TouchEventType.ended then
			return
		end

		if playermodel.items[arg_43_0.entityid].weapon_attr.nowStars < item_data[playermodel.items[arg_43_0.entityid].itemid].max_star then
			local var_44_0 = require("data.weapon_strengthen" .. item_data[arg_43_0.itemid].equip_quality .. "_data")
			local var_44_1 = weapon_manager:getWeaponConfig(playermodel.items[arg_43_0.entityid]).sub_attr
			local var_44_2 = item_data[arg_43_0.itemid]["upgrade_need_num" .. playermodel.items[arg_43_0.entityid].weapon_attr.nowStars + 1] or 1
			local var_44_3 = {
				showIntro = true,
				labels = {},
				materials = {},
				cancelcallback = callback
			}

			for iter_44_0, iter_44_1 in pairs((weapon_manager:getWeaponAddSubAttr(arg_43_0.itemid, playermodel.items[arg_43_0.entityid].weapon_attr.nowStars + 1))) do
				if var_0_15(var_44_1, iter_44_1.attrtype) ~= iter_44_1.value then
					table.insert(var_44_3.labels, {
						newvalue = FIGHT_ATTR_FORMAT(iter_44_1.attrtype, var_0_15(var_44_1, iter_44_1.attrtype)) .. " → " .. FIGHT_ATTR_FORMAT(iter_44_1.attrtype, iter_44_1.value),
						name = FIGHT_ATTR_INFO[iter_44_1.attrtype] .. ": "
					})
				end
			end

			local var_44_4 = item_manager:getItemByItemId(arg_43_0.itemid)

			for iter_44_2 = #var_44_4, 1, -1 do
				if var_44_4[iter_44_2] == arg_43_0.entityid or playermodel.items[var_44_4[iter_44_2]].weapon_attr.use then
					table.remove(var_44_4, iter_44_2)
				end
			end

			table.sort(var_44_4, function(arg_45_0, arg_45_1)
				local var_45_0 = playermodel.items[arg_45_0].weapon_attr
				local var_45_1 = playermodel.items[arg_45_1].weapon_attr

				if playermodel.items[arg_45_0].weapon_attr.nowStars == playermodel.items[arg_45_1].weapon_attr.nowStars then
					return var_45_0.level < var_45_1.level
				else
					return var_45_0.nowStars < var_45_1.nowStars
				end
			end)

			local function var_44_5(arg_46_0)
				if #var_44_4 < 1 then
					return -1
				elseif #var_44_4 >= 1 then
					table.remove(var_44_4, 1)

					return var_44_4[1]
				end
			end

			local var_44_6 = {}

			for iter_44_3 = 1, var_44_2 do
				local var_44_7 = var_44_5(arg_43_0.itemid)

				table.insert(var_44_3.materials, {
					neednum = 1,
					entityid = var_44_7,
					id = arg_43_0.itemid,
					ownnum = var_44_7 > 0 and 1 or 0
				})

				if var_44_7 and var_44_7 > 0 then
					table.insert(var_44_6, var_44_7)
				end
			end

			function var_44_3.surecallback()
				if not arg_44_0:isBright() then
					return
				end

				arg_44_0:setBright(false)

				local var_47_0 = weapon_manager:getWeaponConfig(playermodel.items[arg_43_0.entityid]).sub_attr.value

				weapon_manager:UpgradeWeapon(arg_43_0.entityid, var_44_6, function(arg_48_0)
					if arg_48_0 == 1 then
						local var_48_1 = weapon_manager:getWeaponConfig(playermodel.items[arg_43_0.entityid]).sub_attr

						arg_43_0:playStarUpEffect(arg_43_0.entityid, var_44_3.labels)
						arg_43_0:updateData()
						arg_43_0:updateAttrPanel()
						arg_43_0:updateAttrPanel()
						arg_43_0:updaeWeaponAttr()
						LayerManager:removePopLayer()
					elseif arg_48_0 == 2 then
						global_ShowBlockWords(L_WEAPON_UPGRADE_FAIL[2])
					elseif arg_48_0 == 3 then
						global_ShowBlockWords(L_WEAPON_UPGRADE_FAIL[3])
					elseif arg_48_0 == 4 then
						global_ShowBlockWords(L_WEAPON_UPGRADE_FAIL[4])
					elseif arg_48_0 == 5 then
						global_ShowBlockWords(L_WEAPON_UPGRADE_FAIL[5])
					end

					arg_44_0:setBright(true)
				end)
			end

			function var_44_3.shopBuyCallback(arg_49_0)
				require("controller.shop_manager"):pushBuyWeaponPop(arg_43_0.servantid, arg_49_0)
			end

			var_44_3.title = L_WEAPON_UPGRADE.title
			var_44_3.imageTitle = "public/title/title_weapon_upgrade.png"
			var_44_3.bntstr = L_WEAPON_UPGRADE.bntstr
			var_44_3.curStar = playermodel.items[arg_43_0.entityid].weapon_attr.nowStars

			LayerManager:pushInLayer("PopUpgradeCostlayer", var_44_3)
			AnalyticManager.click_weapon_star_up_btn({
				weaponid = playermodel.items[arg_43_0.entityid].itemid,
				level = playermodel.items[arg_43_0.entityid].weapon_attr.level,
				star = playermodel.items[arg_43_0.entityid].weapon_attr.nowStars
			})
		else
			global_ShowBlockWords(L_WEAPON_UPGRADE_FAIL[5])
		end
	end
end

function PopWeaponUpLevelList:playStarUpEffect(arg_50_1, arg_50_2)
	audio_manager:playeffectMusic("weapon_starup")

	local var_50_0 = ccui.Layout:create()

	var_50_0:setTouchEnabled(true)
	var_50_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_50_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_50_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_50_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_50_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_50_0:setBackGroundColorOpacity(220)
	self.rootLayer:addChild(var_50_0, 999)

	local var_50_1 = playermodel.items[arg_50_1].itemid

	local function var_50_2()
		local var_51_0 = item_data[var_50_1].max_star
		local var_51_1 = {}

		for iter_51_0 = 1, item_data[var_50_1].max_star do
			local var_51_3 = ccui.ImageView:create(iter_51_0 <= playermodel.items[arg_50_1].weapon_attr.nowStars and (iter_51_0 <= 5 and "public/currency/weapon_star.png" or "public/currency/pink_star.png") or "public/currency/weapon_star_empty.png", var_0_0)

			var_51_3:setPosition(cc.p(320 + (iter_51_0 - (var_51_0 + 1) / 2) * (var_51_3:getContentSize().width - 10), GameDisplay.height / 2 - 76))
			table.insert(var_51_1, var_51_3)
			var_51_3:setVisible(false)
			var_50_0:addChild(var_51_3)
		end

		for iter_51_1, iter_51_2 in pairs(var_51_1) do
			var_51_1[iter_51_1]:setScale(8)
			var_51_1[iter_51_1]:runAction(cc.Sequence:create(cc.DelayTime:create(iter_51_1 / 30), cc.CallFunc:create(function()
				var_51_1[iter_51_1]:setVisible(true)
			end), cc.Spawn:create(cc.RotateBy:create(0.55, 72), cc.Sequence:create(cc.ScaleTo:create(0.15, 1, 1), cc.ScaleTo:create(0.25, 2, 2), cc.ScaleTo:create(0.15, 1, 1)))))
		end
	end

	local var_50_3 = L2Skeleton:create("spine/ui/weapon_up_quality/weapon_up.json", "spine/ui/weapon_up_quality/weapon_up.atlas")

	var_50_3:refreshSkeleton()
	var_50_3:setSlotTexture("wuqi", "diergewuqi", "weaponIcon/" .. item_data[playermodel.items[arg_50_1].itemid].image_id .. ".png")
	var_50_3:setSlotTexture("wuqi", "wuqishengjiewuqi", "weaponIcon/" .. item_data[playermodel.items[arg_50_1].itemid].image_id .. ".png")
	var_50_3:setSlotTexture("wuqikuang", "wuqishengjiewuqikuang", ({
		"weaponIcon/weapon_bg_white.png",
		"weaponIcon/weapon_bg_green.png",
		"weaponIcon/weapon_bg_blue.png",
		"weaponIcon/weapon_bg_purple.png",
		"weaponIcon/weapon_bg_orange.png",
		"weaponIcon/weapon_bg_red.png"
	})[item_data[playermodel.items[arg_50_1].itemid].equip_quality])
	var_50_3.skeletonAnimation:setPosition(cc.p(320, GameDisplay.height / 2))
	var_50_3:play("unique_up", false)
	var_50_0:addChild(var_50_3)
	var_50_0:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
		var_50_2()
	end), cc.DelayTime:create(8), cc.RemoveSelf:create(), cc.CallFunc:create(function()
		self:showUpgrade(arg_50_2)

		if callback then
			callback()
		end
	end)))
	var_50_0:addTouchEventListener(function(arg_55_0, arg_55_1)
		if arg_55_1 ~= ccui.TouchEventType.ended then
			return
		end

		if callback then
			callback()
		end

		var_50_0:runAction(cc.Sequence:create(cc.RemoveSelf:create(), cc.CallFunc:create(function()
			self:showUpgrade(arg_50_2)
		end)))
	end)
end

function PopWeaponUpLevelList:getLineLenAndAngle(...)
	for iter_57_0 = 1, 26 do
		local var_57_0 = self:getNodePosY(iter_57_0)
		local var_57_1 = self:getNodePosY(iter_57_0 + 1)

		print(string.format("[%d] = {angle = %02f, len = %02f},", iter_57_0, math.atan((var_57_0 - var_57_1) / var_0_10) * 180 / 3.1415 + 90, (math.pow(math.pow(var_57_1 - var_57_0, 2) + math.pow(var_0_10, 2), 0.5))))
	end
end

function PopWeaponUpLevelList.showUpgrade(arg_58_0, arg_58_1)
	local var_58_0 = {}
	local var_58_1 = {}
	local var_58_2 = {}

	for iter_58_0, iter_58_1 in pairs(arg_58_1) do
		table.insert(var_58_0, iter_58_1.name .. iter_58_1.newvalue)
		table.insert(var_58_1, cc.c3b(250, 130, 72))
		table.insert(var_58_2, iter_58_0)
	end

	local var_58_3 = ccui.Layout:create()

	var_58_3:setTouchEnabled(true)
	var_58_3:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_58_3:setAnchorPoint(cc.p(0, 0))
	var_58_3:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_58_3:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	global_basic_scene:addChild(var_58_3, 100000)
	var_58_3:setTouchEnabled(true)
	var_58_3:addTouchEventListener(function(arg_59_0, arg_59_1)
		if arg_59_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_58_3:stopAllActions()
		var_58_3:runAction(cc.RemoveSelf:create())
	end)

	local var_58_4 = {
		1,
		1,
		1.2,
		1.3,
		1.5,
		1.8
	}
	local var_58_5 = 1

	var_58_3:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
		if var_58_2[var_58_5] then
			local var_60_0 = var_58_4[var_58_2[var_58_5]] or 1
			local var_60_1 = ccui.ImageView:create("public/panelbg/component_strengthen_effect_bg.png", var_0_0)

			var_60_1:setPositionX(320)
			var_60_1:setPositionY(GameDisplay.height / 2)
			global_basic_scene:addChild(var_60_1, 100000)

			local var_60_2 = cc.Label:createWithTTF(var_58_0[var_58_5], FONT_TITLE, 32)

			var_60_2:setPosition(cc.p(var_60_1:getContentSize().width / 2, var_60_1:getContentSize().height / 2))
			var_60_2:setColor(var_58_1[var_58_5])
			var_60_1:addChild(var_60_2)
			var_60_1:setScale(4 * var_60_0)
			var_60_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1), cc.DelayTime:create(0.2 * var_60_0), cc.Spawn:create(cc.MoveBy:create(0.3, cc.p(0, 200)), cc.FadeOut:create(0.3)), cc.RemoveSelf:create()))
		end

		var_58_5 = var_58_5 + 1

		if var_58_5 > #var_58_0 then
			var_58_3:stopAllActions()
			var_58_3:removeFromParent()
		end
	end), cc.DelayTime:create(0.25))))
end

function PopWeaponUpLevelList:exit()
	if self.initParam and self.initParam.exitCallback then
		self.initParam.exitCallback()
	end

	LayerManager:removePopLayer()
end

function PopWeaponUpLevelList:handleCompoundOneKey()
	self:updateAttrPanel()
end

function PopWeaponUpLevelList:onBuyShop()
	self:updaeWeaponAttr()
end
