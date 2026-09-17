DoubleHoliday_AchievementLayer = class("DoubleHoliday_AchievementLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Sprite.BottomBtnList")

local task_manager = require("controller.task_manager")
local drop_manager = require("controller.drop_manager")
local activity_manager = require("controller.activity_manager")
local item_data = require("data.item_data")
local task_data = require("data.task_data")
local image_data = require("data.image_data")
local activity_task_stage_data = require("data.activity_task_stage_data")
local activity_conf_data = require("data.activity_conf_data")
local activity_doubleholiday_manager = require("controller.activity_doubleholiday_manager")
local activity_plague_achievement_data = require("data.activity_plague_achievement_data")
local playermodel = require("model.playermodel")
local network = require("network.network")
local var_0_12 = config._DEBUG and 0 or 1
local var_0_14
local var_0_15 = 606
local var_0_16 = 151
local var_0_17 = {
	L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_12 .. L_DOUBLEHOLIDAY_WOLDCITYLAYER.NAME_INFO[1] .. L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_13,
	L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_12 .. L_DOUBLEHOLIDAY_WOLDCITYLAYER.NAME_INFO[2] .. L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_13,
	L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_12 .. L_DOUBLEHOLIDAY_WOLDCITYLAYER.NAME_INFO[3] .. L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_13,
	L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_12 .. L_DOUBLEHOLIDAY_WOLDCITYLAYER.NAME_INFO[4] .. L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_13,
	L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_12 .. L_DOUBLEHOLIDAY_WOLDCITYLAYER.NAME_INFO[5] .. L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_13,
	L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_12 .. L_DOUBLEHOLIDAY_WOLDCITYLAYER.NAME_INFO[6] .. L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_13,
	L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_12 .. L_DOUBLEHOLIDAY_WOLDCITYLAYER.NAME_INFO[7] .. L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_13,
	L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_12 .. L_DOUBLEHOLIDAY_WOLDCITYLAYER.NAME_INFO[8] .. L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_13
}
local var_0_18 = {
	"Activity_doubleholiday/huodong_play.png",
	"Activity_doubleholiday/huodong_get.png",
	"Activity_doubleholiday/huodong_haveget.png"
}
local var_0_19 = {
	"Activity_doubleholiday/huodong_go.png",
	"Activity_doubleholiday/huodong_can.png",
	"Activity_doubleholiday/huodong_go.png"
}

function DoubleHoliday_AchievementLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = DoubleHoliday_AchievementLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function DoubleHoliday_AchievementLayer:init(arg_3_1)
	var_0_14 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "DoubleHoliday_achievement.json" or "DoubleHoliday_achievement.ExportJson")

	self:addChild(self.rootLayer)

	if arg_3_1 then
		self.callback = arg_3_1.callback or nil
	end

	require("view.Sprite.TitleSprite")

	local var_3_0 = TitleSprite:create("Activity_doubleholiday/huodong_biaoti.png", 2, "Activity_doubleholiday/top_bg.png")

	var_3_0:setPosition(0, 1080)
	var_3_0:setName("title_sprite")
	self.rootLayer:addChild(var_3_0, 25)

	self.taskPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "label_exp")

	self:initBottomList()

	self.roleTableView = cc.TableView:create(cc.size(640, 1010 + GameDisplay.height - 1136))

	self.roleTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.roleTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.roleTableView:setAnchorPoint(cc.p(0, 0))
	self.roleTableView:setPosition(cc.p(20, self.bottomlist:getPositionY() + self.bottomlist:getContentSize().height / 2))
	self.roleTableView:setDelegate()
	self.rootLayer:addChild(self.roleTableView)

	self.roleTableViewhight = 1010 + GameDisplay.height - 1136

	self:getListData()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			if self.callback then
				self.callback()
			end

			var_0_14 = nil
		end
	end)
	self:fullScreen(self.rootLayer)
end

function DoubleHoliday_AchievementLayer:createNode()
	local var_5_0 = self.taskPanel:clone()

	var_5_0:setTouchEnabled(false)

	return var_5_0
end

function DoubleHoliday_AchievementLayer:updateNode(arg_6_1, arg_6_2)
	local var_6_0 = ccui.Helper:seekWidgetByName(arg_6_1, "Image_14")
	local var_6_1 = ccui.Helper:seekWidgetByName(arg_6_1, "progress_bar")
	local var_6_2 = ccui.Helper:seekWidgetByName(arg_6_1, "button_goto")
	local var_6_3 = ccui.Helper:seekWidgetByName(arg_6_1, "percentage")
	local var_6_4 = ccui.Helper:seekWidgetByName(arg_6_1, "progress_bg")
	local var_6_5 = ccui.Helper:seekWidgetByName(arg_6_1, "bg")
	local var_6_6 = ccui.Helper:seekWidgetByName(arg_6_1, "label_pt")
	local var_6_7 = ccui.Helper:seekWidgetByName(arg_6_1, "Image_14")

	ccui.Helper:seekWidgetByName(arg_6_1, "Image_18"):setVisible(false)
	var_6_6:setPositionY(5)
	ccui.Helper:seekWidgetByName(arg_6_1, "des"):setString(var_0_17[arg_6_2.city] .. arg_6_2.award.progress .. "%")
	var_6_6:setString("X" .. arg_6_2.award.drop_num1)

	if arg_6_2.stage == 1 then
		var_6_4:setVisible(true)
		var_6_1:setPercent(arg_6_2.percent)
		var_6_3:setString("" .. arg_6_2.percent .. "%")
		var_6_2:loadTextures(var_0_18[1], nil, var_0_18[1], var_0_12)
		var_6_5:loadTexture(var_0_19[1], var_0_12)
		self:addNewFlag(var_6_2)
	elseif arg_6_2.stage == 2 then
		var_6_4:setVisible(true)
		var_6_1:setPercent(100)
		var_6_3:setString("100%")
		var_6_2:loadTextures(var_0_18[2], nil, var_0_18[2], var_0_12)
		var_6_5:loadTexture(var_0_19[2], var_0_12)
		self:addNewFlag(var_6_2, true)
	elseif arg_6_2.stage == 3 then
		var_6_4:setVisible(false)
		var_6_2:loadTextures(var_0_18[3], nil, var_0_18[3], var_0_12)
		var_6_5:loadTexture(var_0_19[3], var_0_12)
		self:addNewFlag(var_6_2)
	end

	var_6_2.status = arg_6_2.stage
	var_6_2.tag = arg_6_2.city
	var_6_2.lock = arg_6_2.unlock

	var_6_7:loadTexture("equipment/201912002.png")
	var_6_2:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_7_0:setBright(false)
		self:dealChangeBtn(arg_7_0, function()
			if var_0_14 then
				arg_7_0:setBright(true)
			end
		end)
	end)
end

function DoubleHoliday_AchievementLayer.dealChangeBtn(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1.status == 1 then
		if not arg_9_1.lock then
			LayerManager:switchShowLayer("DoubleHoliday_CityNodeLayer", {
				callback = arg_9_2,
				city = arg_9_1.tag
			})
		else
			global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.UNLOCK)

			if arg_9_2 then
				arg_9_2()
			end
		end
	elseif arg_9_1.status == 2 then
		activity_doubleholiday_manager:get_cityaward(12, arg_9_1.tag, function(arg_10_0)
			if arg_10_0.result == 1 then
				global_gain({
					gold = arg_10_0.gold,
					diamond = arg_10_0.diamond,
					honor = arg_10_0.honor,
					items = arg_10_0.items
				})
				arg_9_0:updateAward(arg_10_0)

				if arg_9_2 then
					arg_9_2()
				end
			elseif arg_9_2 then
				arg_9_2()
			end
		end)
	elseif arg_9_1.status == 3 then
		global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.TIPS_14)

		return
	end
end

function DoubleHoliday_AchievementLayer:initTableView()
	self.roleTableView:registerScriptHandler(function(arg_13_0, arg_13_1)
		return var_0_15, var_0_16
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_0:dequeueCell()

		if not var_12_0 then
			var_12_0 = cc.TableViewCell:create()

			local var_12_1 = self:createNode()

			var_12_1:setName("node")
			var_12_1:setPosition(cc.p(5, 5))
			self:updateNode(var_12_1, self.data[arg_12_1 + 1])

			if not self.sucessflag then
				if arg_12_1 <= math.floor(self.roleTableViewhight / var_0_16) then
					var_12_1:setOpacity(0)
					var_12_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_12_1), cc.FadeIn:create(0.1)))
				else
					var_12_1:setOpacity(255)
				end
			end

			var_12_0:addChild(var_12_1)
		else
			local var_12_2 = var_12_0:getChildByName("node")

			if not self.sucessflag then
				var_12_2:setOpacity(255)
			end

			self:updateNode(var_12_2, self.data[arg_12_1 + 1])
		end

		return var_12_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_14_0, arg_14_1)
		return #self.data
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.roleTableView:reloadData()
end

function DoubleHoliday_AchievementLayer:getListData()
	self:getActivityTaskList(activityid, function(arg_16_0)
		if arg_16_0.result == 0 then
			global_ShowBlockWords(L_ACTIVITY_TASK_LIST[0])
		else
			self.data = self:dealEndData(global_deepCopy(arg_16_0.list))

			self:initTableView()
		end
	end)
end

function DoubleHoliday_AchievementLayer.getActivityTaskList(arg_17_0, arg_17_1, arg_17_2)
	activity_doubleholiday_manager:get_achievement_info(12, arg_17_2)
end

function DoubleHoliday_AchievementLayer.dealEndData(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in pairs(arg_18_1) do
		local var_18_4 = {}

		for iter_18_2, iter_18_3 in ipairs(activity_plague_achievement_data) do
			if iter_18_1.cityid == iter_18_3.cityid and iter_18_1.cityid ~= 1 then
				table.insert(var_18_4, iter_18_3)
			end
		end

		if #var_18_4 > 0 then
			local var_18_5 = 1
			local var_18_6
			local var_18_7

			if iter_18_1.step < #var_18_4 then
				if iter_18_1.record >= var_18_4[iter_18_1.step + 1].progress then
					var_18_5 = 2
					var_18_7 = iter_18_1.step + 1
				else
					var_18_5 = 1
					var_18_6 = iter_18_1.record
					var_18_7 = iter_18_1.step + 1
				end
			else
				var_18_5 = 3
				var_18_6 = 100
				var_18_7 = iter_18_1.step
			end

			table.insert(var_18_0, {
				city = iter_18_1.cityid,
				stage = var_18_5,
				percent = var_18_6,
				award = var_18_4[var_18_7]
			})
		end
	end

	for iter_18_4 = 2, 8 do
		local var_18_8 = true
		local var_18_9 = {}

		for iter_18_5, iter_18_6 in pairs(arg_18_1) do
			if iter_18_6.cityid == iter_18_4 then
				var_18_8 = false
			end
		end

		if var_18_8 then
			for iter_18_7, iter_18_8 in ipairs(activity_plague_achievement_data) do
				if iter_18_4 == iter_18_8.cityid then
					table.insert(var_18_9, iter_18_8)
				end
			end

			table.insert(var_18_0, {
				stage = 1,
				percent = 0,
				unlock = true,
				city = iter_18_4,
				award = var_18_9[1]
			})
		end
	end

	table.sort(var_18_0, function(arg_20_0, arg_20_1)
		return arg_20_0.city < arg_20_1.city
	end)

	return var_18_0
end

function DoubleHoliday_AchievementLayer:initBottomList()
	self.bottomlist = BottomBtnList:create(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()

		if callback then
			callback()
		end
	end, {})

	self:addChild(self.bottomlist, 5)
end

function DoubleHoliday_AchievementLayer:updateAward(arg_23_1)
	self:getListData()
end

function DoubleHoliday_AchievementLayer.addNewFlag(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1:getChildByName("new_falg") then
		arg_24_1:getChildByName("new_falg"):removeFromParent()
	end

	if arg_24_2 then
		local var_24_0 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_12)

		var_24_0:setPosition(cc.p(arg_24_1:getContentSize().width / 2 + 50, arg_24_1:getContentSize().height / 2 + 50))
		var_24_0:setName("new_falg")
		arg_24_1:addChild(var_24_0, 10)
	end
end

function DoubleHoliday_AchievementLayer:fullScreen(arg_25_1)
	arg_25_1:setContentSize((GameDisplay.getScreenSize()))
	arg_25_1:setPositionY(arg_25_1:getPositionY() - GameDisplay.fix_y)
	arg_25_1:getChildByName("title_sprite"):setPosition(cc.p(0, GameDisplay.getUiScreenSize().height - 56))
	self.bottomlist:setPositionY(self.bottomlist:getPositionY() - GameDisplay.fix_y)
end
