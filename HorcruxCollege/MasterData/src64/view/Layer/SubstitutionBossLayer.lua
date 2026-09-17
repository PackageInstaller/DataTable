SubstitutionBossLayer = class("SubstitutionBossLayer", function()
	return cc.Layer:create()
end)

local net_dispatcher = require("network.net_dispatcher")
local item_manager = require("controller.item_manager")
local network = require("network.network")
local var_0_4 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local shop_data = require("data.shop_data")
local shop_manager = require("controller.shop_manager")
local account_manager = require("controller.account_manager")
local ItemSprite = require("view.Sprite.ItemSprite")
local level_manager = require("controller.level_manager")
local audio_manager = require("controller.audio_manager")
local levelmode_data = require("data.levelmode_data")
local alert_manager = require("controller.alert_manager")
local substitution_manager = require("controller.substitution_manager")
local time_check_manager = require("controller.time_check_manager")

require("view.Sprite.BottomBtnList")
require("view.Sprite.TitleSprite")

local var_0_18 = "SubstitutionBossLayer/"
local var_0_21 = GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT
local var_0_22
local var_0_23 = 600
local var_0_24 = 280

function add_new_tag(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0:getChildByName("reddot") then
		arg_2_0:getChildByName("reddot"):setVisible(true)

		return
	end

	local var_2_0 = arg_2_2 or 999
	local var_2_1 = arg_2_1 or {
		x = arg_2_0:getContentSize().width,
		y = arg_2_0:getContentSize().height
	}
	local var_2_2 = ccui.ImageView:create("public/reddot/reddot0.png", config._DEBUG and 0 or 1)

	var_2_2:setName("reddot")
	var_2_2:setAnchorPoint(cc.p(1, 1))
	var_2_2:setPosition(cc.p(var_2_1.x, var_2_1.y))
	arg_2_0:addChild(var_2_2, var_2_0)
end

function remove_alert_tag(arg_3_0)
	if not arg_3_0:getChildByName("reddot") then
		return
	end

	arg_3_0:getChildByName("reddot"):runAction(cc.RemoveSelf:create())
end

function SubstitutionBossLayer.create(arg_4_0, arg_4_1)
	local var_4_0 = SubstitutionBossLayer.new()

	var_4_0:init(arg_4_1)

	return var_4_0
end

function SubstitutionBossLayer:init(arg_5_1)
	var_0_22 = self

	if arg_5_1 then
		self.returnbacklayer = arg_5_1.returnbacklayer or "AdventureLayer"
	end

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "SubstitutionBossLayer.json" or "SubstitutionBossLayer.ExportJson")

	self:addChild(self.rootLayer)
	self.rootLayer:setBackGroundColorOpacity(0)

	local var_5_0 = GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT

	self.roleTableView = cc.TableView:create(cc.size(640, 1050 + var_5_0))

	self.roleTableView:setPosition(cc.p(0, 90))
	self.roleTableView:setDelegate()
	self.roleTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.rootLayer:addChild(self.roleTableView)
	self.roleTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.rootLayer:setName("self.roleTableView")

	self.roleTableViewhight = 1050 + var_5_0

	self:getLeftTimes()
	self:initBottomList()
	self:createTitleSprite()
	self:fullScreen(self.rootLayer)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_22 = nil
		end
	end)
end

function SubstitutionBossLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	self:addChild(self.bottomList, 10)
end

function SubstitutionBossLayer:createNode()
	local var_9_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "items"):clone()

	var_9_0:setTouchEnabled(false)

	return var_9_0
end

function SubstitutionBossLayer:createTitleSprite()
	self.title = TitleSprite:create("SubstitutionBossLayer/title.png", 2)

	self.title:setName("title")
	self.title:setPosition(cc.p(0, GameDisplay.getUiScreenSize().height - 56))
	self.rootLayer:addChild(self.title, 5)
end

function SubstitutionBossLayer.updateTime(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if not arg_11_2 then
		ccui.Helper:seekWidgetByName(arg_11_1, "Image_surplustime"):setVisible(false)

		return
	end

	local var_11_0 = ccui.Helper:seekWidgetByName(arg_11_1, "surplusTime")

	if arg_11_3 then
		var_11_0:setString(L_SUBSTITUTION_OPEN_TIME .. global_format_time_by_date(arg_11_2, 1))
	else
		local var_11_7 = math.floor(arg_11_2 / 24 / 3600)
		local var_11_8 = math.floor((arg_11_2 - var_11_7 * 24 * 3600) / 3600)
		local var_11_9 = math.floor((arg_11_2 - var_11_7 * 24 * 3600 - var_11_8 * 3600) / 60)

		var_11_0:setString(L_LEFT_TIME_SPACE .. (0 ~= 0 and string.format(L_TIME_TEXT[1], var_11_7, var_11_8) or var_11_8 ~= 0 and string.format(L_TIME_TEXT[2], var_11_8, var_11_9) or string.format(L_TIME_TEXT[3], var_11_9)))
	end
end

function SubstitutionBossLayer:updateNode(arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1:getChildByName("change_btn")

	var_12_0:loadTextures(var_0_18 .. arg_12_2.mode .. ".png", nil, var_0_18 .. arg_12_2.mode .. ".png", var_0_4)
	var_12_0:setSwallowTouches(false)
	var_12_0:addTouchEventListener(function(arg_13_0, arg_13_1)
		if math.abs(arg_13_0:getTouchBeganPosition().y - arg_13_0:getTouchEndPosition().y) > 50 then
			return
		end

		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_12_2.starttime then
			global_ShowBlockWords(L_SUBSTITUTION_INVALID)

			return
		end

		if self:canChange(left_time, ticket_num) then
			LayerManager:switchShowLayer("SubstitutionLayer", {
				mode = arg_12_2.mode,
				endtime = arg_12_2.remaintime,
				recommendRank = arg_12_2.recommend_rank
			})
		end
	end)
	ccui.Helper:seekWidgetByName(arg_12_1, "Label_max_score"):setString(global_trans_number(arg_12_2.score_toweek or "暂无"))
	self:updateTime(arg_12_1, arg_12_2.starttime or arg_12_2.remaintime, arg_12_2.starttime and 1 or nil)
	self:updateNewAlertStatus(arg_12_1, arg_12_2.id)
end

function SubstitutionBossLayer:initTableView()
	self.roleTableView:registerScriptHandler(function(arg_16_0, arg_16_1)
		return var_0_23, var_0_24
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_15_0, arg_15_1)
		local var_15_0 = arg_15_0:dequeueCell() or cc.TableViewCell:create()
		local var_15_1 = var_15_0:getChildByName("btn_node")

		if not var_15_1 then
			local var_15_2 = self:createNode()

			var_15_2:setPosition(cc.p(20, -85))
			var_15_2:setName("btn_node")

			if not self.data[arg_15_1 + 1] then
				var_15_2:setOpacity(0)
			else
				var_15_2:setOpacity(255)
				self:updateNode(var_15_2, self.data[arg_15_1 + 1])

				if arg_15_1 <= math.floor(self.roleTableViewhight / var_0_24) then
					var_15_2:setOpacity(0)
					var_15_2:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_15_1), cc.FadeIn:create(0.1)))
				else
					var_15_2:setOpacity(255)
				end
			end

			var_15_0:addChild(var_15_2)
		else
			var_15_1:setOpacity(255)

			if not self.data[arg_15_1 + 1] then
				var_15_1:setOpacity(0)
			else
				var_15_1:setOpacity(255)
				self:updateNode(var_15_1, self.data[arg_15_1 + 1])
			end
		end

		return var_15_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_17_0, arg_17_1)
		if #self.data ~= 0 then
			return #self.data + 1
		else
			return 0
		end
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.roleTableView:reloadData()
end

function SubstitutionBossLayer:getListData()
	self:getLeftTimes()
end

function SubstitutionBossLayer.getLeftTimes(arg_19_0)
	substitution_manager:get_substitution_list(function(arg_20_0)
		if not var_0_22 then
			return
		end

		arg_19_0.data = arg_20_0

		arg_19_0:initTableView()
	end)
end

function SubstitutionBossLayer.sortByOrder(arg_21_0, arg_21_1)
	return
end

function SubstitutionBossLayer.showBossInfo(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	return
end

function SubstitutionBossLayer.canChange(arg_23_0, arg_23_1, arg_23_2)
	return true
end

function SubstitutionBossLayer.updateNewAlertStatus(arg_24_0, arg_24_1, arg_24_2)
	return
end

function SubstitutionBossLayer.getResidueTime(arg_25_0, arg_25_1)
	if not arg_25_1 then
		return "-1"
	end

	local var_25_5 = global_get_time_by_date(arg_25_1) - playermodel.onlineTime
	local var_25_6 = math.floor(var_25_5 / 24 / 3600)
	local var_25_7 = math.floor((var_25_5 - var_25_6 * 24 * 3600) / 3600)
	local var_25_8 = math.floor((var_25_5 - var_25_6 * 24 * 3600 - var_25_7 * 3600) / 60)

	return var_25_6 ~= 0 and string.format(L_TIME_TEXT[1], var_25_6, var_25_7) or var_25_7 ~= 0 and string.format(L_TIME_TEXT[2], var_25_7, var_25_8) or string.format(L_TIME_TEXT[3], var_25_8)
end

function SubstitutionBossLayer.createTimeString(arg_26_0, arg_26_1)
	return
end

function SubstitutionBossLayer.checkIsVaild(arg_27_0, arg_27_1)
	return
end

function SubstitutionBossLayer.checkTimeIsOverVaild(arg_28_0, arg_28_1)
	return
end

function SubstitutionBossLayer.dealString(arg_29_0, arg_29_1)
	return
end

function SubstitutionBossLayer:fullScreen(arg_30_1)
	arg_30_1:setContentSize((GameDisplay.getScreenSize()))
	arg_30_1:setPositionY(arg_30_1:getPositionY() - GameDisplay.fix_y)
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
end
