SpecialJumpTowerLayer = class("SpecialJumpTowerLayer", function()
	return cc.Layer:create()
end)

local net_dispatcher = require("network.net_dispatcher")
local network = require("network.network")
local var_0_3 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local time_check_manager = require("controller.time_check_manager")

require("view.Sprite.BottomBtnList")
require("view.Sprite.TitleSprite")

local var_0_8 = {
	fire = 3,
	water = 5,
	positive = 7,
	light = 4,
	dark = 6,
	imaginary = 9,
	wind = 2,
	other = 1,
	devil = 8
}
local var_0_9 = {
	fire = "spicalTower/fire.png",
	water = "spicalTower/water.png",
	positive = "spicalTower/positive.png",
	summer = "spicalTower/summer.png",
	light = "spicalTower/light.png",
	dark = "spicalTower/dark.png",
	imaginary = "spicalTower/imaginary.png",
	wind = "spicalTower/wind.png",
	other = "spicalTower/new_itemdi.png",
	devil = "spicalTower/devil.png"
}
local var_0_10 = {
	summer = cc.c3b(161, 255, 243),
	other = cc.c3b(234, 22, 255),
	fire = cc.c3b(141, 208, 255),
	wind = cc.c3b(255, 0, 87),
	light = cc.c3b(238, 137, 255),
	water = cc.c3b(161, 255, 243),
	dark = cc.c3b(255, 236, 152),
	positive = cc.c3b(255, 163, 163),
	devil = cc.c3b(255, 188, 22),
	imaginary = cc.c3b(186, 160, 255)
}
local level_manager = require("controller.level_manager")
local audio_manager = require("controller.audio_manager")
local monster_manager = require("controller.monster_manager")
local levelmode_data = require("data.levelmode_data")
local var_0_15 = require("data.item_data")
local var_0_18
local var_0_19 = 638
local var_0_20 = 230

local function var_0_21(arg_2_0)
	if not arg_2_0 then
		return ""
	end

	if arg_2_0 > 86400 then
		return string.format(L_TIME_SINGLE.Day, math.floor(arg_2_0 / 3600 / 24))
	elseif arg_2_0 >= 3600 then
		return string.format(L_TIME_SINGLE.Hour, math.floor(arg_2_0 / 3600))
	elseif arg_2_0 >= 60 then
		return string.format(L_TIME_SINGLE.Minute, math.floor(arg_2_0 % 3600 / 60))
	else
		return string.format(L_TIME_SINGLE.Minute, 1)
	end
end

function SpecialJumpTowerLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = SpecialJumpTowerLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function SpecialJumpTowerLayer:init(arg_4_1)
	var_0_18 = self

	if arg_4_1 then
		self.modetype = arg_4_1.modetype or 7
	end

	if arg_4_1 then
		self.returnbacklayer = arg_4_1.returnbacklayer or "AdventureLayer"
	end

	if TopcostLayer and TopcostLayer.getInstance() then
		TopcostLayer.getInstance():hideTopcostLayer()
	end

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "SpecialJumpTowerLayer.json" or "SpecialJumpTowerLayer.ExportJson")

	self:addChild(self.rootLayer)
	self.rootLayer:setBackGroundColorOpacity(0)

	local var_4_0 = GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT

	self.roleTableView = cc.TableView:create(cc.size(640, 950 + var_4_0))

	self.roleTableView:setPosition(cc.p(0, 120))
	self.roleTableView:setDelegate()
	self.roleTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.rootLayer:addChild(self.roleTableView, 1)
	self.roleTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.rootLayer:setName("self.roleTableView")

	self.roleTableViewhight = 950 + var_4_0

	self:getListData(self.modetype)
	self:initBottomList()
	self:createTitleSprite()
	self:fullScreen(self.rootLayer)
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			local var_5_0 = 0

			for iter_5_0, iter_5_1 in pairs(self.data) do
				if RoleDefault:getInstance():getIntegerForKey("newJumpTower" .. iter_5_1.mode, 1) == 1 then
					var_5_0 = var_5_0 + 1
				end
			end

			if var_5_0 == #self.data then
				require("controller.alert_manager"):unregister_alert(E_ALTER_LEVEL_ADVENTURE, true)
			end

			var_0_18 = nil

			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerId)
		end
	end)
end

function SpecialJumpTowerLayer:initBottomList()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_9"):addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchReturnLayer(self.returnbacklayer)
	end)
end

function SpecialJumpTowerLayer:createNode()
	local var_8_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "items"):clone()

	var_8_0:setTouchEnabled(false)

	return var_8_0
end

function SpecialJumpTowerLayer:createTitleSprite()
	self.title = TitleSprite:create("spicalTower/title.png", 2)

	self.title:setName("title")
	self.title:setPosition(cc.p(0, GameDisplay.getUiScreenSize().height - 56))
	self.rootLayer:addChild(self.title, 5)
end

function SpecialJumpTowerLayer:updateNode(arg_10_1, arg_10_2)
	local var_10_0 = ccui.Helper:seekWidgetByName(arg_10_1, "level_label")
	local var_10_1 = ccui.Helper:seekWidgetByName(arg_10_1, "total_lable")
	local var_10_2 = arg_10_1:getChildByName("change_btn")
	local var_10_3 = true
	local var_10_4

	if levelmode_data[arg_10_2.mode].ele_type then
		var_10_4 = levelmode_data[arg_10_2.mode].ele_type or "other"
	end

	var_10_4 = levelmode_data[arg_10_2.mode].mode == 74221 and "summer" or var_10_4

	var_10_2:setSwallowTouches(false)

	local var_10_5

	if levelmode_data[arg_10_2.mode].btn_path then
		var_10_5 = "spicalTower/" .. levelmode_data[arg_10_2.mode].btn_path or var_0_9[var_10_4]
	end

	var_10_2:loadTextures(var_10_5, nil, var_10_5, var_0_3)

	local var_10_6 = playermodel.levelmode[arg_10_2.mode].status - 1

	if playermodel.levelmode[arg_10_2.mode].status - 1 > arg_10_2.totalchapter then
		var_10_6 = arg_10_2.totalchapter
	end

	if RoleDefault:getInstance():getIntegerForKey("newJumpTower" .. arg_10_2.mode, 1) == 2 then
		if arg_10_1:getChildByName("newTower") then
			arg_10_1:getChildByName("newTower"):removeFromParent()
		end

		local var_10_7 = ccui.ImageView:create("spicalTower/newTower.png", var_0_3)

		var_10_7:setName("newTower")
		var_10_7:setAnchorPoint(cc.p(0.5, 1))
		var_10_7:setPosition(cc.p(570, 220))
		arg_10_1:addChild(var_10_7)
	elseif arg_10_1:getChildByName("newTower") then
		arg_10_1:getChildByName("newTower"):removeFromParent()
	end

	var_10_0:setString("" .. var_10_6)
	var_10_1:setString("/" .. arg_10_2.totalchapter)

	local var_10_8

	if levelmode_data[arg_10_2.mode].btn_color then
		local var_10_9, var_10_10, var_10_11 = (function(arg_11_0)
			local var_11_0 = arg_11_0:gsub("#", "")

			return tonumber(var_11_0:sub(1, 2), 16), tonumber(var_11_0:sub(3, 4), 16), (tonumber(var_11_0:sub(5, 6), 16))
		end)(levelmode_data[arg_10_2.mode].btn_color)

		var_10_8 = cc.c3b(var_10_9, var_10_10, var_10_11)
	else
		var_10_8 = var_0_10[var_10_4]
	end

	var_10_1:setColor(var_10_8)
	var_10_1:setPositionX(var_10_0:getPositionX() + var_10_0:getContentSize().width)

	if var_10_3 then
		var_10_2:setVisible(true)
	else
		var_10_2:setVisible(true)
	end

	self:canChange(arg_10_2, arg_10_1, true)
	var_10_2:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_12_0:getTouchBeganPosition().y - arg_12_0:getTouchEndPosition().y) > 50 then
			return
		end

		if arg_10_2.mode ~= 501 and not level_manager:isPlayerPassLevel(UNLOCK_SPECIAL_TOWER) then
			global_ShowBlockWords(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_SPECIAL_TOWER)))

			return
		end

		if self:canChange(arg_10_2, arg_10_1) then
			RoleDefault:getInstance():setIntegerForKey("newJumpTower" .. arg_10_2.mode, 1)
			RoleDefault:getInstance():setIntegerForKey("SpecialAdventureEnterMode", arg_10_2.mode)
			RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", arg_10_2.modetype)
			RoleDefault:getInstance():flush()
			LayerManager:switchShowLayer("AdventureNewTowerLayer", {
				returnbacklayer = "SpecialJumpTowerLayer",
				layer = self.modetype,
				chaptermode = arg_10_2.mode
			})
		end
	end)

	local var_10_12 = arg_10_1:getChildByName("count_down")
	local var_10_13 = var_10_12:getChildByName("count_down_label")

	var_10_13:setVisible(arg_10_2.mode ~= 501)

	if arg_10_2.mode ~= 501 then
		local var_10_14 = time_check_manager:getCurTime()
		local var_10_15 = os.date("*t", var_10_14)

		var_10_15.day = 1
		var_10_15.month = var_10_15.month + 1
		var_10_15.sec = 0
		var_10_15.min = 0

		var_10_13:setString(L_SPECIAL_JUMP_TOWER .. var_0_21(os.time(var_10_15) - var_10_14))

		arg_10_1.show = true

		if arg_10_2.endtime then
			var_10_13:setString(L_LEFT_TIME_SPACE .. var_0_21(os.time(parse_time(arg_10_2.endtime)) - var_10_14))
		end
	end

	local var_10_16 = arg_10_1:getChildByName("lock_icon")

	if arg_10_2.mode ~= 501 then
		if not var_10_16 then
			var_10_16 = ccui.ImageView:create("public/button/fight_lock.png", var_0_3)

			var_10_16:setName("lock_icon")
			var_10_16:setVisible(false)
			var_10_16:setPosition(cc.p(arg_10_1:getContentSize().width - 35, arg_10_1:getContentSize().height - 35))
			arg_10_1:addChild(var_10_16, 1000)
		end

		if level_manager:isPlayerPassLevel(UNLOCK_SPECIAL_TOWER) then
			var_10_12:setVisible(true)
			var_10_16:setVisible(false)
			arg_10_1:setOpacity(255)
		else
			var_10_12:setVisible(false)
			var_10_16:setVisible(true)
			arg_10_1:setOpacity(122)

			if arg_10_1:getChildByName("newTower") then
				arg_10_1:getChildByName("newTower"):removeFromParent()
			end
		end
	else
		if var_10_16 then
			var_10_16:setVisible(false)
		end

		arg_10_1:setOpacity(255)
	end
end

function SpecialJumpTowerLayer.updataImage(arg_13_0, arg_13_1, arg_13_2)
	return
end

function SpecialJumpTowerLayer:initTableView()
	self.roleTableView:registerScriptHandler(function(arg_16_0, arg_16_1)
		return var_0_19, var_0_20
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_15_0, arg_15_1)
		local var_15_0 = arg_15_0:dequeueCell()

		if not var_15_0 then
			var_15_0 = cc.TableViewCell:create()

			var_15_0:setName("cell_node" .. arg_15_1)

			local var_15_1 = self:createNode()

			var_15_1:setName("btn_node")
			var_15_1:setPosition(cc.p(5, 0))

			local var_15_2 = math.floor(self.roleTableViewhight / var_0_20)

			self:updateNode(var_15_1, self.data[arg_15_1 + 1])
			var_15_0:addChild(var_15_1)
		else
			self:updateNode(var_15_0:getChildByName("btn_node"), self.data[arg_15_1 + 1])
		end

		return var_15_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_17_0, arg_17_1)
		return #self.data
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.roleTableView:reloadData()

	self.schedulerId = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		local var_18_0 = time_check_manager:getCurTime()
		local var_18_1 = os.date("*t", var_18_0)

		var_18_1.day = 1
		var_18_1.month = var_18_1.month + 1
		var_18_1.sec = 0
		var_18_1.min = 0

		local var_18_2 = var_0_21(os.time(var_18_1) - var_18_0)

		print("refresh", var_18_2)

		for iter_18_0, iter_18_1 in pairs((self.roleTableView:getContainer():getChildren())) do
			local var_18_3 = iter_18_1:getChildByName("btn_node")

			if var_18_3 and var_18_3:getChildByName("count_down") and var_18_3:getChildByName("count_down_label") and var_18_3.show then
				var_18_3:getChildByName("count_down"):getChildByName("count_down_label"):setString("下次重置：" .. var_18_2)
			end
		end
	end, 60, false)
end

function SpecialJumpTowerLayer:getListData(arg_19_1)
	if not arg_19_1 then
		print("no data error!")
	end

	local var_19_0 = arg_19_1
	local var_19_1 = {}
	local var_19_2 = {}
	local var_19_3

	for iter_19_0, iter_19_1 in pairs(levelmode_data) do
		if iter_19_1.modetype == 5 and iter_19_1.mode == 501 then
			var_19_3 = iter_19_1
		end
	end

	var_19_1[1] = var_19_3

	for iter_19_2, iter_19_3 in pairs(levelmode_data) do
		if iter_19_3.modetype == var_19_0 and iter_19_3.active == 1 and global_is_in_time(iter_19_3.starttime, iter_19_3.endtime) then
			table.insert(var_19_2, iter_19_3)
		end
	end

	local var_19_4 = {}
	local var_19_5 = false

	for iter_19_4, iter_19_5 in pairs(var_19_2) do
		if iter_19_5 and iter_19_5.order then
			table.insert(var_19_4, iter_19_5.order)
		end
	end

	if next(var_19_4) and #var_19_4 > 1 then
		for iter_19_6 = 2, #var_19_4 do
			if var_19_4[iter_19_6] == var_19_4[1] then
				var_19_5 = true

				break
			end
		end
	end

	self:sortByOrder(var_19_2, var_19_5)

	for iter_19_7, iter_19_8 in ipairs(var_19_2) do
		table.insert(var_19_1, iter_19_8)
	end

	self.data = var_19_1

	self:initTableView()
end

function SpecialJumpTowerLayer.sortByOrder(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 and #arg_20_1 > 1 then
		if arg_20_2 then
			table.sort(arg_20_1, function(arg_21_0, arg_21_1)
				return (var_0_8[arg_21_0.ele_type] or var_0_8.other) < (var_0_8[arg_21_1.ele_type] or var_0_8.other)
			end)
		else
			table.sort(arg_20_1, function(arg_22_0, arg_22_1)
				return arg_22_0.order < arg_22_1.order
			end)
		end
	end
end

function SpecialJumpTowerLayer.showBossInfo(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = {
		fight_type = "ADVENTURE",
		level = 1,
		mode = arg_23_1,
		chapter = arg_23_2,
		callback = arg_23_3
	}

	var_23_0.initindex = RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)

	LayerManager:pushInLayer("LevelDetailLayer", var_23_0)
end

function SpecialJumpTowerLayer.canChange(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	return true
end

function SpecialJumpTowerLayer.getUnlockString(arg_25_0)
	return level_manager:formatSystemUnlockLevel(UNLOCK_ELEMENTTA, 1) .. L_UNLOCK
end

function SpecialJumpTowerLayer.checkIsVaild(arg_26_0, arg_26_1)
	return
end

function SpecialJumpTowerLayer.checkTimeIsOverVaild(arg_27_0, arg_27_1)
	return
end

function SpecialJumpTowerLayer.dealString(arg_28_0, arg_28_1)
	return
end

function SpecialJumpTowerLayer.fullScreen(arg_29_0, arg_29_1)
	arg_29_1:setContentSize((GameDisplay.getScreenSize()))
	arg_29_1:setPositionY(arg_29_1:getPositionY() - GameDisplay.fix_y)
end
