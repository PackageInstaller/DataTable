ChapterAdvertureTower = class("ChapterAdvertureTower", function()
	return cc.Layer:create()
end)

local net_dispatcher = require("network.net_dispatcher")
local network = require("network.network")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")

require("view.Sprite.BottomBtnList")
require("view.Sprite.TitleSprite")

local level_manager = require("controller.level_manager")
local audio_manager = require("controller.audio_manager")
local levelmode_data = require("data.levelmode_data")
local var_0_9 = require("data.item_data")
local var_0_12
local var_0_13 = 630
local var_0_14 = 175

function ChapterAdvertureTower.create(arg_2_0, arg_2_1)
	local var_2_0 = ChapterAdvertureTower.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ChapterAdvertureTower:init(arg_3_1)
	var_0_12 = self

	if arg_3_1 then
		self.modetype = arg_3_1.modetype or RoleDefault:getInstance():getIntegerForKey("AdventureEnterIndex", 104)
	end

	self.modetype = self.modetype or RoleDefault:getInstance():getIntegerForKey("AdventureEnterIndex", 104)

	if arg_3_1 then
		self.returnbacklayer = arg_3_1.returnbacklayer or "MainLayer"
	end

	TopcostLayer.getInstance():hideTopcostLayer()

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ChapterAdvertureTower.json" or "ChapterAdvertureTower.ExportJson")

	self:addChild(self.rootLayer)

	local var_3_0 = GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT

	self.roleTableView = cc.TableView:create(cc.size(640, 1050 + var_3_0))

	self.roleTableView:setPosition(cc.p(0, 90))
	self.roleTableView:setDelegate()
	self.roleTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.rootLayer:addChild(self.roleTableView)
	self.roleTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.rootLayer:setName("self.roleTableView")

	self.roleTableViewhight = 1050 + var_3_0

	self:getListData(self.modetype)
	self:initBottomList()
	self:fullScreen(self.rootLayer)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			var_0_12 = nil
		end
	end)
end

function ChapterAdvertureTower:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	self:addChild(self.bottomList, 10)
end

function ChapterAdvertureTower:createNode()
	local var_7_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "items"):clone()

	var_7_0:setTouchEnabled(false)

	return var_7_0
end

function ChapterAdvertureTower:updateNode(arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1:getChildByName("nostatrt_img")
	local var_8_1 = arg_8_1:getChildByName("change_btn")

	self:updataImage(arg_8_1, arg_8_2)
	ccui.Helper:seekWidgetByName(arg_8_1, "fuben_name"):setString(arg_8_2.name)
	ccui.Helper:seekWidgetByName(arg_8_1, "time"):setString("")
	ccui.Helper:seekWidgetByName(arg_8_1, "lefttime1_1"):setString(tostring(""))

	if self:canChange(arg_8_2, true) then
		var_8_1:setVisible(true)
		var_8_0:setVisible(false)
	else
		var_8_1:setVisible(true)
		var_8_0:setVisible(false)
	end

	var_8_1:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self:canChange(arg_8_2) then
			RoleDefault:getInstance():setIntegerForKey("SpecialAdventureEnterMode", arg_8_2.mode)
			RoleDefault:getInstance():flush()
			LayerManager:switchShowLayer("AdventureNewTowerLayer", {
				returnbacklayer = "ChapterAdvertureTower",
				layer = self.modetype,
				chaptermode = arg_8_2.mode
			})
		end
	end)
end

function ChapterAdvertureTower.updataImage(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {}

	for iter_10_0 = 1, 4 do
		if arg_10_2["show_item" .. iter_10_0] then
			table.insert(var_10_0, arg_10_2["show_item" .. iter_10_0])
		end
	end

	for iter_10_1 = 1, 4 do
		if var_10_0[iter_10_1] then
			arg_10_1:getChildByName("img_" .. iter_10_1):loadTexture("equipment/" .. var_0_9[var_10_0[iter_10_1]].image_id .. ".png")
			arg_10_1:getChildByName("img_" .. iter_10_1):setVisible(true)

			local var_10_1 = math.min(arg_10_1:getChildByName("img_" .. iter_10_1):getContentSize().width, arg_10_1:getChildByName("img_" .. iter_10_1):getContentSize().height)

			if iter_10_1 == 1 then
				arg_10_1:getChildByName("img_" .. iter_10_1):setScale(128 / var_10_1)
			else
				arg_10_1:getChildByName("img_" .. iter_10_1):setScale(89.6 / var_10_1)
			end
		else
			arg_10_1:getChildByName("img_" .. iter_10_1):setVisible(false)
		end
	end
end

function ChapterAdvertureTower:initTableView()
	self.roleTableView:registerScriptHandler(function(arg_13_0, arg_13_1)
		return var_0_13, var_0_14
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_0:dequeueCell()

		if not var_12_0 then
			var_12_0 = cc.TableViewCell:create()

			local var_12_1 = self:createNode()

			var_12_1:setName("node")
			var_12_1:setPosition(cc.p(5, -85))
			self:updateNode(var_12_1, self.data[arg_12_1 + 1])

			if arg_12_1 <= math.floor(self.roleTableViewhight / var_0_14) then
				var_12_1:setOpacity(0)
				var_12_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_12_1), cc.FadeIn:create(0.1)))
			else
				var_12_1:setOpacity(255)
			end

			var_12_0:addChild(var_12_1)
		else
			local var_12_2 = var_12_0:getChildByName("node")

			var_12_2:setOpacity(255)
			self:updateNode(var_12_2, self.data[arg_12_1 + 1])
		end

		return var_12_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_14_0, arg_14_1)
		return #self.data
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.roleTableView:reloadData()
end

function ChapterAdvertureTower:getListData(arg_15_1)
	if not arg_15_1 then
		print("no data error!")
	end

	local var_15_0 = arg_15_1
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in pairs(levelmode_data) do
		if iter_15_1.modetype == var_15_0 then
			table.insert(var_15_1, iter_15_1)
		end
	end

	self:sortByOrder(var_15_1)

	self.data = var_15_1

	self:initTableView()
end

function ChapterAdvertureTower.sortByOrder(arg_16_0, arg_16_1)
	if arg_16_1 and #arg_16_1 > 1 then
		table.sort(arg_16_1, function(arg_17_0, arg_17_1)
			return arg_17_0.order < arg_17_1.order
		end)
	end
end

function ChapterAdvertureTower.canChange(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_1 then
		if not arg_18_2 then
			global_ShowBlockWords("error:  no data ")
		end

		return false
	elseif not arg_18_1.recommend then
		return true
	elseif level_manager:isLevelModePass(arg_18_1.recommend) then
		return true
	else
		if not arg_18_2 then
			global_ShowBlockWords(L_CLEAR_CHAPTER .. "【" .. L_MODE_DIFFICULTY_LAMIA[level_manager:getDifficultByMode(arg_18_1.recommend)] .. "】" .. level_manager:getChapterName(arg_18_1.recommend, arg_18_1.totalchapter) .. L_UNLOCK)
		end

		return false
	end
end

function ChapterAdvertureTower.createTimeString(arg_19_0, arg_19_1)
	return
end

function ChapterAdvertureTower.checkIsVaild(arg_20_0, arg_20_1)
	return
end

function ChapterAdvertureTower.checkTimeIsOverVaild(arg_21_0, arg_21_1)
	return
end

function ChapterAdvertureTower.dealString(arg_22_0, arg_22_1)
	return
end

function ChapterAdvertureTower:fullScreen(arg_23_1)
	arg_23_1:setContentSize((GameDisplay.getScreenSize()))
	arg_23_1:setPositionY(arg_23_1:getPositionY() - GameDisplay.fix_y)
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
end
