PopTrainPackageLayer = class("PopTrainPackageLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local item_data = require("data.item_data")
local playermodel = require("model.playermodel")
local train_package_data = require("data.train_package_data")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local core_data = require("data.core_data")
local core_manager = require("controller.core_manager")
local item_manager = require("controller.item_manager")

function PopTrainPackageLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopTrainPackageLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

local var_0_9 = {
	"public/box/new_item_bg1.png",
	"public/box/new_item_bg2.png",
	"public/box/new_item_bg3.png",
	"public/box/new_item_bg4.png"
}
local var_0_10 = {
	[0] = "public/rolebg/breakout_0.png",
	"public/rolebg/breakout_1.png",
	"public/rolebg/breakout_2.png",
	"public/rolebg/breakout_3.png"
}

setmetatable(var_0_10, {
	__index = function(arg_3_0, arg_3_1)
		return "public/rolebg/breakout_" .. arg_3_1 .. ".png"
	end
})

function PopTrainPackageLayer:init(arg_4_1)
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopTrainPackage.json" or "PopTrainPackage.ExportJson")

	self:addChild(self.rootlayer)
	self.rootlayer:setLocalZOrder(999)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_bottom")

	self.rootpanel:setPositionY(GameDisplay.getScreenSize().height / 2)

	self.sureCallback = arg_4_1.sureCallback
	self.roomid = arg_4_1.roomid

	print("roomid=====", self.roomid)

	self.soulsId = arg_4_1.soulsid

	self:createFullScreenMask(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_5_0:isBright() then
			return
		end

		arg_5_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 180)
	self.showActions.extendVertical(self)

	self.btnSure = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_sure")

	self:initUI()
	self:switchPackage(1)
end

function PopTrainPackageLayer:initUI()
	ccui.Helper:seekWidgetByName(self.rootlayer, "Image_role"):loadTexture("roleimage/role1/" .. model_data[servant_data[self.soulsId].modelid].cute_role .. ".png")
	ccui.Helper:seekWidgetByName(self.rootlayer, "Label_name"):setString(servant_data[self.soulsId].name)
	ccui.Helper:seekWidgetByName(self.rootlayer, "Image_rank"):loadTexture(var_0_10[core_manager:getServantCoreRank(self.soulsId)], var_0_0)

	local var_7_0 = core_manager:getServantCoreRank(self.soulsId)

	ccui.Helper:seekWidgetByName(self.rootlayer, "Label_old_level"):setString("等级." .. core_manager:getCoreLv(self.soulsId))

	self.imageProgressBar = ccui.ImageView:create("SchoolTrainLayer/progress_exp2.png", var_0_0)

	self.imageProgressBar:setAnchorPoint(cc.p(0, 0.5))
	self.imageProgressBar:setPosition(cc.p(35, 250))
	self.imageProgressBar:setScaleX(1.8)

	local var_7_1 = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("SchoolTrainLayer/progress_exp1.png") or cc.Sprite:createWithSpriteFrameName("SchoolTrainLayer/progress_exp1.png")))

	var_7_1:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	var_7_1:setBarChangeRate(cc.p(1, 0))
	var_7_1:setMidpoint(cc.p(0, 0))
	var_7_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_7_1:setPosition(cc.p(self.imageProgressBar:getContentSize().width / 2, self.imageProgressBar:getContentSize().height / 2))
	var_7_1:setName("progressBar")
	var_7_1:setPercentage(0)
	self.imageProgressBar:addChild(var_7_1, 999)
	self.rootpanel:addChild(self.imageProgressBar, 999)
	self:initPackage()
end

function PopTrainPackageLayer:initPackage()
	local var_8_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_package")
	local var_8_1 = var_8_0:getContentSize().width + 10

	self.packageTable = {}

	for iter_8_0, iter_8_1 in pairs(train_package_data) do
		local var_8_2 = var_8_0:clone()

		var_8_2:setPosition(cc.p(20, 20))
		self.rootpanel:addChild(var_8_2, 999)

		local var_8_4 = ccui.ImageView:create(var_0_9[iter_8_1.id], var_0_0)

		var_8_4:setScale(0.66)
		var_8_4:setPosition(cc.p(var_8_2:getContentSize().width / 2, var_8_2:getContentSize().height / 2))
		var_8_2:addChild(var_8_4, 1)
		var_8_2:getChildByName("Label_electric_num"):setString(iter_8_1.cost_power)

		local var_8_5 = ccui.ImageView:create("SchoolTrainLayer/train_card_" .. iter_8_1.id .. ".png", var_0_0)

		var_8_5:setPosition(cc.p(var_8_4:getContentSize().width / 2, var_8_4:getContentSize().height / 2))
		var_8_4:addChild(var_8_5)

		self.packageTable[#self.packageTable + 1] = var_8_2
		var_8_2.id = iter_8_0

		var_8_2:addTouchEventListener(function(arg_9_0, arg_9_1)
			if arg_9_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:switchPackage(arg_9_0.id)
		end)
	end
end

function PopTrainPackageLayer:switchPackage(arg_10_1)
	if self.index == arg_10_1 then
		return
	end

	self.index = arg_10_1

	for iter_10_0, iter_10_1 in pairs(self.packageTable) do
		if self.packageTable[iter_10_0].id == self.index then
			self.packageTable[iter_10_0]:getChildByName("Image_select"):setVisible(true)

			self.packageId = self.index

			self:updateUI()
		else
			self.packageTable[iter_10_0]:getChildByName("Image_select"):setVisible(false)
		end
	end
end

function PopTrainPackageLayer:getTime()
	return (math.fmod(math.floor(train_package_data[self.index].cost_time / 60 / 60), 25))
end

function PopTrainPackageLayer:updateUI()
	local var_12_0, var_12_1, var_12_2 = core_manager:getFutureLevel(self.soulsId, train_package_data[self.index].gain_exp)

	ccui.Helper:seekWidgetByName(self.rootlayer, "Label_new_level"):setString("等级." .. var_12_0)

	local var_12_3 = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_exp")

	if core_manager:getCoreLv(self.soulsId) == core_manager:getCoreMaxTotalLv() or var_12_2 == 0 then
		var_12_3:setString(L_SOUL_STRENGTH_PANEL_BTN_TITLE[3])
		var_12_3:setTextAreaSize(cc.size(60, 90))
		var_12_3:setAnchorPoint(cc.p(1, 0.9))
		self.imageProgressBar:setVisible(false)
	elseif var_12_2 == -1 then
		var_12_3:setAnchorPoint(cc.p(1, 1))
		var_12_3:setTextAreaSize(cc.size(300, 100))
		var_12_3:setString(L_EXP_OVERFLOW)
		self.imageProgressBar:setVisible(false)
	elseif var_12_2 == -2 then
		var_12_3:setAnchorPoint(cc.p(1, 1))
		var_12_3:setTextAreaSize(cc.size(300, 100))
		var_12_3:setString(L_EXP_OVERFLOW)
		self.imageProgressBar:setVisible(false)
	elseif var_12_2 == -3 then
		var_12_3:setAnchorPoint(cc.p(1, 1))
		var_12_3:setTextAreaSize(cc.size(300, 100))
		var_12_3:setString(L_EXP_OVERFLOW_1)
		self.imageProgressBar:setVisible(false)
	else
		var_12_3:setString(var_12_1 .. "/" .. var_12_2)
		var_12_3:setAnchorPoint(cc.p(1, 0.9))
		self.imageProgressBar:setVisible(true)
		var_12_3:setTextAreaSize(cc.size(60, 90))
		self.imageProgressBar:getChildByName("progressBar"):setPercentage(var_12_1 / var_12_2 * 100)
	end

	ccui.Helper:seekWidgetByName(self.rootlayer, "Label_package"):setString(string.format(L_TRAIN_TO_EXP, self:getTime(), global_trans_number(train_package_data[self.index].gain_exp)))
	self.btnSure:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if core_manager:getCoreLv(self.soulsId) == core_manager:getCoreMaxTotalLv() or var_12_2 == 0 then
			global_ShowBlockWords(L_SOUL_STRENGTH_PANEL_BTN_TITLE[3])
			arg_13_0:setTouchEnabled(false)
		elseif core_manager:getCoreLv(self.soulsId) >= core_manager:getCoreMaxLevelByGrade() then
			global_ShowBlockWords(L_GIRL_LEVEL_LIMIT)
			arg_13_0:setTouchEnabled(false)
		elseif item_manager:getItemNumber(ELECTRIC) < train_package_data[self.index].cost_power then
			global_ShowBlockWords(L_ELECTRIC_LACK)
			LayerManager:removePopLayer()
			LayerManager:pushInLayer("PopElectricSupplyLayer")
		else
			if self.sureCallback then
				self.sureCallback(self.roomid, self.packageId)
			end

			item_manager:deleteItem(ELECTRIC, train_package_data[self.index].cost_power)
			LayerManager:removePopLayer()
		end
	end)
end
