LevelMapBoxLayer = class("LevelMapBoxLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local audio_manager = require("controller.audio_manager")
local l2utils = require("controller.l2utils")
local time_check_manager = require("controller.time_check_manager")
local patrol_manager = require("controller.patrol_manager")
local barrage_manager = require("controller.barrage_manager")
local item_data = require("data.item_data")
local city_data = require("data.city_data")
local CityList = require("view.Sprite.CityList")

require("view.Sprite.ChapterSprite")

local var_0_17

function LevelMapBoxLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = LevelMapBoxLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function LevelMapBoxLayer.getInstance()
	return var_0_17
end

function LevelMapBoxLayer:init(arg_4_1)
	var_0_17 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "LevelMapBoxLayer.json" or "LevelMapBoxLayer.ExportJson")

	self:addChild(self.rootLayer)
	self:fullScreen()
	self:initData()
	self:updateData()
	self:initUI()
	self:updateUI()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			var_0_17 = false
		end
	end)
end

function LevelMapBoxLayer:initData(...)
	self.cityList = level_manager:getCityBoxList()

	table.insert(self.cityList, -1)
end

function LevelMapBoxLayer.updateData(arg_7_0, ...)
	return
end

function LevelMapBoxLayer:initUI(...)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_return"):addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("FightLayer")
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_main"):addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("LevelMapLayer")
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_talkline"):addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("LevelTalkMapLayer")
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_branch"):loadTextures("LevelMapBoxLayer/btn_branch_off.png", "LevelMapBoxLayer/btn_branch_off.png", "LevelMapBoxLayer/btn_branch_off.png", var_0_0)

	self.specailBnt = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_special")

	self.specailBnt:loadTextures("LevelMapBoxLayer/btn_special_off.png", nil, "LevelMapBoxLayer/btn_special_off.png", var_0_0)
	self.specailBnt:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("SpecialOperationLayer", {
			initcity = 51
		})
	end)
end

function LevelMapBoxLayer:updateUI(...)
	if not self.tableView then
		self:createTableView()
	end

	self:updateShowingCells()
end

local var_0_18 = 640
local var_0_19 = 920
local var_0_20 = 0
local var_0_21 = 120
local var_0_22 = 640
local var_0_23 = 230
local var_0_24 = cc.p(50, 0)

function LevelMapBoxLayer:createTableView()
	self.tableView = cc.TableView:create(cc.size(var_0_18, var_0_19 + GameDisplay.fix_y * 2))

	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableView:setPosition(cc.p(var_0_20, var_0_21 - GameDisplay.fix_y))
	self.tableView:setDelegate()
	self.tableView:setName("tableView")
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_root"):addChild(self.tableView)
	self.tableView:registerScriptHandler(function(arg_15_0, arg_15_1)
		return var_0_22, var_0_23
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:registerScriptHandler(function(arg_16_0, arg_16_1)
		local var_16_0 = arg_16_0:dequeueCell()

		if not var_16_0 then
			var_16_0 = cc.TableViewCell:create()

			var_16_0:setName("cell_" .. arg_16_1)

			local var_16_1 = self:getCitySp()

			var_16_1:setPosition(cc.p(var_0_24))
			var_16_1:setName("sp")
			var_16_0:addChild(var_16_1)
		end

		local var_16_2 = var_16_0:getChildByName("sp")

		if arg_16_1 % 2 == 0 then
			var_16_2:setPositionX(100)
		else
			var_16_2:setPositionX(230)
		end

		var_16_2:update(arg_16_1 + 1)

		return var_16_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:registerScriptHandler(function(arg_17_0, arg_17_1)
		return #self.cityList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:registerScriptHandler(function(arg_18_0)
		return
	end, cc.SCROLLVIEW_SCRIPT_SCROLL)
	self.tableView:reloadData()
end

function LevelMapBoxLayer:updateShowingCells()
	local var_19_0, var_19_1 = GetTableViewShowCellIdx(self.tableView, {
		maxcount = #self.cityList,
		cellsize = cc.size(var_0_22, var_0_23)
	})

	for iter_19_0 = var_19_0, var_19_1 do
		self.tableView:updateCellAtIndex(iter_19_0)
	end
end

function LevelMapBoxLayer:getCitySp(...)
	local var_20_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cell"):clone()

	function var_20_0:update(arg_21_1)
		local var_21_0 = self.cityList[arg_21_1]

		self:getChildByName("Button_cityimg").cityid = self.cityList[arg_21_1]

		if var_21_0 == -1 then
			self:getChildByName("Button_cityimg"):loadTextures("CityMap/levelmapbox/" .. var_21_0 .. ".png", "", "")
			self:getChildByName("Image_frame"):setVisible(false)
			self:getChildByName("Label_maxstar"):setVisible(false)
			self:getChildByName("Label_curstar"):setVisible(false)
			self:getChildByName("Image_reddot"):setVisible(false)
			self:getChildByName("Image_new"):setVisible(false)
		else
			self:getChildByName("Image_frame"):setVisible(true)
			self:getChildByName("Label_maxstar"):setVisible(true)
			self:getChildByName("Label_curstar"):setVisible(true)
			self:getChildByName("Button_cityimg"):loadTextures("CityMap/levelmapbox/" .. var_21_0 .. ".png", "", "")

			local var_21_1 = level_manager:getCurModeByCity(var_21_0)

			self:getChildByName("Label_curstar"):setString((level_manager:getCurCityUnlockModeTotalStars(var_21_0)))
			self:getChildByName("Label_maxstar"):setString("/" .. level_manager:getCurCityUnlockModeMaxStar(var_21_0))

			local var_21_2 = self:getChildByName("Label_curstar")
			local var_21_3 = var_21_2:getPositionX()

			self:getChildByName("Label_curstar"):setPositionX(300 - self:getChildByName("Label_maxstar").getContentSize(var_21_2).width / 2)

			local var_21_4 = self:getChildByName("Label_maxstar")
			local var_21_5 = var_21_4:getPositionX()

			self:getChildByName("Label_maxstar"):setPositionX(300 + self:getChildByName("Label_curstar").getContentSize(var_21_4).width / 2)

			if level_manager:isCityCanUnlock(var_21_0) then
				self:getChildByName("Image_new"):setVisible(true)
			else
				self:getChildByName("Image_new"):setVisible(false)
			end

			if patrol_manager:isCityFinishedPatrol(var_21_0) or level_manager:checkIsNewStarRewardInCity(var_21_0) then
				self:getChildByName("Image_reddot"):setVisible(true)
			else
				self:getChildByName("Image_reddot"):setVisible(false)
			end

			if level_manager:isCityUnlocked(var_21_0) then
				self:getChildByName("Image_lock"):setVisible(false)
				self:getChildByName("Label_lock"):setVisible(false)
			else
				self:getChildByName("Image_lock"):setVisible(true)
				self:getChildByName("Label_lock"):setVisible(true)
			end
		end
	end

	var_20_0:getChildByName("Button_cityimg"):setSwallowTouches(false)
	var_20_0:getChildByName("Button_cityimg"):addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_22_0:getTouchBeganPosition().y - arg_22_0:getTouchEndPosition().y) > 50 then
			return
		end

		local var_22_0 = arg_22_0.cityid

		if arg_22_0.cityid == -1 then
			return
		end

		if level_manager:isCityUnlocked(var_22_0) or level_manager:isCityCanUnlock(var_22_0) then
			LayerManager:switchShowLayer("LevelMapSingleLayer", {
				cityid = var_22_0
			})
			print("on touch cityid " .. var_22_0)
		else
			local var_22_1 = tonumber(level_manager:getPremode((level_manager:getFirstModeByCity(var_22_0))))

			global_ShowBlockWords(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(var_22_1 * 1000 + level_manager:getModeTotalChapter(var_22_1))))
		end
	end)

	return var_20_0
end

function LevelMapBoxLayer:fullScreen(...)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bottom"):setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bottom"):getPositionY() - GameDisplay.fix_y)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_title"):setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Image_title"):getPositionY() + GameDisplay.fix_y)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_tips"):setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Image_tips"):getPositionY() - GameDisplay.fix_y)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Listview"):setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Listview"):getPositionY() - GameDisplay.fix_y)
end
