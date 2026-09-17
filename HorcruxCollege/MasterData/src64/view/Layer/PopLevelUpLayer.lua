PopLevelUpLayer = class("PopLevelUpLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local model_data = require("data.model_data")
local core_manager = require("controller.core_manager")
local playermodel = require("model.playermodel")
local armature_manager = require("controller.armature_manager")
local servant_data = require("data.servant_data")
local favorfile_data = require("data.favorfile_data")
local train_package_data = require("data.train_package_data")
local var_0_8 = {
	[0] = "public/rolebg/breakout_0.png",
	"public/rolebg/breakout_1.png",
	"public/rolebg/breakout_2.png",
	"public/rolebg/breakout_3.png"
}

setmetatable(var_0_8, {
	__index = function(arg_2_0, arg_2_1)
		return "public/rolebg/breakout_" .. arg_2_1 .. ".png"
	end
})

function PopLevelUpLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = PopLevelUpLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function PopLevelUpLayer:fullScreen()
	ccui.Helper:seekWidgetByName(self.rootlayer, "Image_top"):setPositionY(GameDisplay.getUiScreenSize().height - 57 - GameDisplay.fix_y)
	ccui.Helper:seekWidgetByName(self.rootlayer, "Image_down"):setPositionY(68 - GameDisplay.fix_y)
end

function PopLevelUpLayer:init(arg_5_1)
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopLevelUpLayer.json" or "PopLevelUpLayer.ExportJson")

	self:addChild(self.rootlayer)

	self.servantid = arg_5_1.soulsid
	self.packageid = arg_5_1.packageid

	print("self.servantid==", self.servantid, type(self.servantid))

	self.modelid = servant_data[self.servantid].modelid
	self.msg = arg_5_1

	self.rootlayer:setOpacity(0)
	self.rootlayer:runAction(cc.FadeIn:create(0.2))

	local var_5_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_bottom")

	var_5_0:loadTexture("mainScenebg/bg_room_train_lv_up.png")
	var_5_0:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		playermodel.cores[self.servantid].extra = arg_5_1.core.extra
		playermodel.cores[self.servantid].exp = arg_5_1.core.exp
		playermodel.cores[self.servantid].coreid = arg_5_1.core.coreid
		playermodel.cores[self.servantid].level = arg_5_1.core.level

		if arg_5_1.exitCallback then
			arg_5_1.exitCallback()
		end

		LayerManager:removePopLayer()
	end)
	self:initUI(self.msg)
	self:fullScreen()
end

function PopLevelUpLayer.animation(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.labelObj
	local var_7_1 = arg_7_1.str
	local var_7_2 = utfstrlen(arg_7_1.str)
	local var_7_3 = 1

	arg_7_1.labelObj:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(function()
		var_7_0:setString(utfmatch(var_7_1, var_7_3))
		var_7_0:setVisible(true)

		var_7_3 = var_7_3 + 1

		if var_7_3 > var_7_2 then
			var_7_0:stopAllActions()

			if var_7_0:getName() == "Label_progress_bar" then
				arg_7_0:runAnim(arg_7_0.msg)
			end
		end
	end))))
end

function PopLevelUpLayer.showText(arg_9_0, arg_9_1)
	for iter_9_0 = 1, #arg_9_1 do
		arg_9_1[iter_9_0]:setVisible(false)
		arg_9_1[iter_9_0]:runAction(cc.Sequence:create(cc.DelayTime:create(iter_9_0 * 0.1), cc.CallFunc:create(function()
			local var_10_0 = {
				[iter_9_0] = {}
			}

			var_10_0[iter_9_0].labelObj = arg_9_1[iter_9_0]
			var_10_0[iter_9_0].str = arg_9_1[iter_9_0]:getString()

			arg_9_0:animation(var_10_0[iter_9_0])
		end)))
	end
end

function PopLevelUpLayer:runAnim(arg_11_1)
	playermodel.cores[self.servantid].extra = arg_11_1.core.extra
	playermodel.cores[self.servantid].exp = arg_11_1.core.exp
	playermodel.cores[self.servantid].coreid = arg_11_1.core.coreid
	playermodel.cores[self.servantid].level = arg_11_1.core.level

	self.aniObj:setVisible(true)

	local var_11_0 = core_manager:getCoreMaxExp(self.servantid)
	local var_11_2 = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_lv")
	local var_11_3 = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_progress_bar")
	local var_11_4, var_11_5, var_11_6 = core_manager:getFutureLevel(self.servantid, train_package_data[self.packageid].gain_exp)
	local var_11_8 = core_manager:getFutureExp(self.servantid, arg_11_1.exp.oldLevel)
	local var_11_10 = arg_11_1.exp.oldLevel
	local var_11_11 = 0
	local var_11_12 = arg_11_1.core.level - arg_11_1.exp.oldLevel < 5 and (arg_11_1.core.level - arg_11_1.exp.oldLevel) / 10 or (arg_11_1.core.level - arg_11_1.exp.oldLevel) / 30
	local var_11_13 = math.floor(var_11_12)
	local var_11_14 = var_11_12 - var_11_13
	local var_11_15 = var_11_8 * (var_11_12 - var_11_13 - (var_11_12 - var_11_13) % 0.01)

	self.progressBar:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
		self.progressBar:setPercentage(var_11_14 * 100)
		var_11_3:setString(var_11_15 .. "/" .. var_11_8)

		var_11_14 = var_11_14 + var_11_14
		var_11_10 = var_11_10 + math.floor(var_11_14)
		var_11_10 = var_11_10 + var_11_13

		if var_11_10 + var_11_13 > arg_11_1.core.level then
			var_11_10 = arg_11_1.core.level
		end

		var_11_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1.2, 1.2), cc.ScaleTo:create(0.1, 1, 1), cc.CallFunc:create(function()
			var_11_2:setString("等级." .. var_11_10)
			armature_manager:reStartAnim(self.aniObj, "levelUpAnim")
		end)))

		if var_11_14 > 1 then
			var_11_14 = var_11_14 - 1
		end

		var_11_8 = var_11_10 == arg_11_1.core.level and arg_11_1.core.exp or core_manager:getFutureExp(self.servantid, var_11_10)

		if var_11_8 ~= 0 then
			var_11_11 = var_11_14 - var_11_14 % 0.01
			var_11_15 = var_11_8 * var_11_11
		end

		if var_11_10 == arg_11_1.core.level then
			if core_manager:getCoreLv(self.servantid) == 100 then
				var_11_3:setString(L_COMPONENT_TEXT.Button_Label[4])
				self.progressBar:setVisible(false)
			else
				self.progressBar:setPercentage(arg_11_1.core.exp / var_11_0 * 100)
				var_11_3:setString(arg_11_1.core.exp .. "/" .. var_11_0)
			end

			self.progressBar:stopAllActions()
		end
	end), cc.DelayTime:create(0.1))))
end

function PopLevelUpLayer:initUI(arg_14_1)
	local var_14_0 = {}
	local var_14_1 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_role")

	var_14_1:loadTexture("roleimage/role1/" .. model_data[self.modelid].cute_role .. ".png")

	self.aniObj = armature_manager:createAndPlayArmature("levelUpAnim")

	self.aniObj:setName("levelUpAnim")
	self.aniObj:setScale(4)
	var_14_1:addChild(self.aniObj, 999)
	self.aniObj:setVisible(false)
	self.aniObj:setPosition(cc.p(var_14_1:getContentSize().width / 2, var_14_1:getContentSize().height / 2))

	local var_14_2 = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_name")

	print("姓名:favorfileData[1][modelData[self.modelid].photofile_model]")
	print(favorfile_data[1][model_data[self.modelid].photofile_model])

	favorfile_data[1][model_data[self.modelid].photofile_model] = favorfile_data[1][model_data[self.modelid].photofile_model]

	var_14_2:setString(favorfile_data[1][model_data[self.modelid].photofile_model])

	var_14_0[#var_14_0 + 1] = var_14_2

	ccui.Helper:seekWidgetByName(self.rootlayer, "Image_break"):loadTexture(var_0_8[core_manager:getServantCoreRank(self.servantid)], var_0_0)

	local var_14_3 = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_lv")

	var_14_3:setString("等级." .. arg_14_1.exp.oldLevel)

	var_14_0[#var_14_0 + 1] = var_14_3

	local var_14_4 = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_progress_bar")

	var_14_4:setString(arg_14_1.exp.oldExp .. "/" .. arg_14_1.exp.oldMaxExp)

	var_14_0[#var_14_0 + 1] = var_14_4

	local var_14_5 = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_get_exp")

	var_14_5:setString(global_trans_number(self:getExp(arg_14_1)))

	var_14_0[#var_14_0 + 1] = var_14_5

	local var_14_6 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_progressbar")

	self.progressBar = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("SchoolTrainLayer/progress_exp1.png") or cc.Sprite:createWithSpriteFrameName("SchoolTrainLayer/progress_exp1.png")))

	self.progressBar:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.progressBar:setBarChangeRate(cc.p(1, 0))
	self.progressBar:setMidpoint(cc.p(0, 0))
	self.progressBar:setAnchorPoint(cc.p(0.5, 0.5))
	self.progressBar:setPosition(cc.p(var_14_6:getContentSize().width / 2, var_14_6:getContentSize().height / 2))
	self.progressBar:setPercentage(arg_14_1.exp.oldExp / arg_14_1.exp.oldMaxExp * 100)
	var_14_6:addChild(self.progressBar, 999)
	self:showText(var_14_0)
end

function PopLevelUpLayer:getExp(arg_15_1)
	local var_15_0 = 0

	for iter_15_0 = 1, arg_15_1.core.level - arg_15_1.exp.oldLevel do
		var_15_0 = var_15_0 + core_manager:getFutureExp(self.servantid, arg_15_1.exp.oldLevel + iter_15_0)
	end

	return var_15_0 + arg_15_1.core.exp - arg_15_1.exp.oldExp
end
