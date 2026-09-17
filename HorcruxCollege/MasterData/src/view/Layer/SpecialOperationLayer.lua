require("view.Layer.LevelMapLayer")

function LevelMapLayer.only_create(arg_1_0, arg_1_1)
	return (LevelMapLayer.new())
end

SpecialOperationLayer = class("SpecialOperationLayer", function(...)
	return (LevelMapLayer:only_create(...))
end)

local var_0_0 = config._DEBUG and 0 or 1
local var_0_1
local patrol_manager = require("controller.patrol_manager")
local level_manager = require("controller.level_manager")
local CityList = require("view.Sprite.CityList")

function SpecialOperationLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = SpecialOperationLayer.new(arg_3_1)

	var_3_0:init(arg_3_1)

	return var_3_0
end

function SpecialOperationLayer.getInstance()
	return var_0_1
end

function SpecialOperationLayer:init(arg_5_1)
	var_0_1 = self
	self._playingani = false

	if arg_5_1 then
		self.initcity = arg_5_1.initcity
		self.initdifficulty = arg_5_1.initdifficulty
		self.jumpselet = arg_5_1.jumpselet
	end

	patrol_manager:reset()
	self:initTimers()
	level_manager:getModesLockState(function()
		self.showDetail = true

		self:initBasicUILayer()
		self:initListView()
		self:initCityMapLayer()
		self:initChangeBnt()
		self:playInitShowAni()
		self:fullScreen()
		self:initOther(arg_5_1)
	end)
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			self.setInstance(nil)
		end
	end)
end

function SpecialOperationLayer:initOther(arg_8_1)
	self.curcity = self.initcity or level_manager:getCurFightCity()

	self:updateMapJsonInfo()
	self:updateCityOnSelect(self.curcity)
	self:cleanAllTimers()
	self:updateUIInfos()
	self:updateCityMapLayer()
	self.specailBnt:loadTextures("LevelMap/btn_special_off.png", "", "LevelMap/btn_special_off.png", var_0_0)
	self.specailBnt:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		return LayerManager:switchShowLayer("specialOperationLayer")
	end)
	self.mainBtn:loadTextures("LevelMap/goto_main.png", "", "LevelMap/goto_main.png", var_0_0)
	self.mainBtn:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("LevelMapLayer")
	end)
	self:getChildByName("left_tag"):setVisible(false)
	self:getChildByName("right_tag"):setVisible(false)
end

function SpecialOperationLayer.changeTheCityList(arg_11_0, arg_11_1)
	return (level_manager:getSpecialCityList())
end
