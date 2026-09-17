ActivityMusicalNotesLayer = class("ActivityMusicalNotesLayer", function()
	return cc.Layer:create()
end)

local Utility = require("common.Utility")
local item_data = require("data.item_data")
local musicialnote_conf = require("data.musicialnote_conf")
local time_check_manager = require("controller.time_check_manager")
local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local musicalNotes_gamelogic_manager = require("controller.musicalNotes_gamelogic_manager")

function ActivityMusicalNotesLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityMusicalNotesLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityMusicalNotesLayer:init(arg_3_1)
	self.activityId = arg_3_1.activityId
	self.layerName = "ActivityMusicalNotesLayer_" .. self.activityId
	self.respath = "ActivityMusicalNotesLayer_" .. self.activityId .. "/"

	TextureManager:loadLayerTextures({
		self.layerName
	})

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))

	self:addChild(self.rootLayer)
	self:initUI()
	self:registerActivityEventListener()
	self:initTouchEvent()
	musicalNotes_gamelogic_manager:registerUIRef(self)
	musicalNotes_gamelogic_manager:gameStart()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName(self.layerName)
			TextureManager:removeLayerTextures({
				self.layerName
			})
			musicalNotes_gamelogic_manager:exitGame()
		end
	end)
	self:fullScreen()
	self:updateItemNum()
end

function ActivityMusicalNotesLayer:registerActivityEventListener()
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_6_0)
		self:updateItemNum()
	end)
end

function ActivityMusicalNotesLayer:initTouchEvent()
	self.title:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityMusicalNotesLayer_" .. self.activityId
		})
	end)
	self.gameitem_btn:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopDoLayer", {
			surecallback = function()
				self.gameitem_btn:setBright(false)
				hx_print("surecallback")
				activity_manager:activity_smallgame_use_speacial_item(self.activityId, {
					gametype = ACTIVITY_SMALLGAME_TYPE_MUSICIALNOTE
				}, function(arg_11_0)
					if arg_11_0.result == 1 then
						musicalNotes_gamelogic_manager:useingGameItem(arg_11_0.note)
						self:updateItemNum()
					end

					self.gameitem_btn:setBright(true)
				end)
			end,
			labels = {
				titleImage = "title_warorder.png",
				des = "确定使用特殊道具来将任意一个音符变为万能音符吗？点击确定即使用"
			}
		})
	end)
	self.return_btn:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.task_btn:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityGameTaskLayer", {
			uiconfmodule = "musicalNotes",
			activityId = self.activityId
		})
	end)
	self.shop_btn:addTouchEventListener(function(arg_14_0, arg_14_1)
		local var_14_0

		if arg_14_1 ~= ccui.TouchEventType.ended then
			do return end

			var_14_0 = {}
		end

		var_14_0[1] = "1-" .. tonumber(musicialnote_conf[self.activityId].shop) % 1500000

		LayerManager:switchShowLayer("MarketLayer", {
			singleMarket = var_14_0,
			showType = var_14_0[1]
		})
	end)
	self.refresh_btn:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopDoLayer", {
			surecallback = function()
				self.refresh_btn:setBright(false)
				hx_print("surecallback")
				activity_manager:activity_musicalnote_refresh(self.activityId, function(arg_17_0)
					if arg_17_0.result == 1 then
						musicalNotes_gamelogic_manager:musicialNotesRefresh()
					end

					self.refresh_btn:setBright(true)
				end)
			end,
			labels = {
				titleImage = "title_warorder.png",
				des = "确定刷新场上的所有音符吗?每日只有一次机会哦~"
			}
		})
	end)
	self.clearlines_btn:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		musicalNotes_gamelogic_manager:clearLines()
	end)
end

function ActivityMusicalNotesLayer:initUI()
	self.title = self.rootLayer:getChildByName("title")
	self.item_bg = self.rootLayer:getChildByName("item_bg")
	self.key_item_num = self.item_bg:getChildByName("key_item_num")
	self.key_point_num = self.item_bg:getChildByName("key_point_num")
	self.shop_btn = self.rootLayer:getChildByName("btn_shop")
	self.task_btn = self.rootLayer:getChildByName("btn_task")
	self.bottom = self.rootLayer:getChildByName("bottom")
	self.return_btn = self.bottom:getChildByName("btn_return")
	self.gameitem_btn = self.bottom:getChildByName("gameitem_btn")
	self.refresh_btn = self.bottom:getChildByName("refresh_btn")
	self.clearlines_btn = self.bottom:getChildByName("clearlines_btn")
	self.game_sure_panel = self.rootLayer:getChildByName("game_sure_panel")
	self.tips_bg = self.game_sure_panel:getChildByName("tips_bg")

	self.game_sure_panel:setVisible(false)

	self.use_gameitem_mask = self.rootLayer:getChildByName("use_gameitem_mask")

	self.use_gameitem_mask:setVisible(false)
end

function ActivityMusicalNotesLayer:popGameSurePanel(arg_20_1)
	hx_print("ActivityMusicalNotesLayer:popGameSurePanel")
	self.game_sure_panel:setVisible(true)

	local var_20_0 = self.tips_bg:getChildByName("yes_btn")

	var_20_0:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_20_0:setBright(false)
		activity_manager:activity_smallgame_data_report(self.activityId, {
			score = arg_20_1.count,
			gametype = ACTIVITY_SMALLGAME_TYPE_MUSICIALNOTE
		}, function(arg_22_0)
			if arg_22_0.result == 1 then
				musicalNotes_gamelogic_manager:NoteDispealSuccess(arg_20_1.note)
				self:updateItemNum()
			else
				musicalNotes_gamelogic_manager:gameContinue(arg_20_1.note)
			end

			var_20_0:setBright(true)
		end)
		self.game_sure_panel:setVisible(false)
	end)
	self.tips_bg:getChildByName("no_btn"):addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		musicalNotes_gamelogic_manager:gameContinue(arg_20_1.note)
		self.game_sure_panel:setVisible(false)
	end)
end

function ActivityMusicalNotesLayer:popUseGameItemMask()
	self.use_gameitem_mask:setVisible(true)
	self.use_gameitem_mask:setTouchEnabled(true)
end

function ActivityMusicalNotesLayer:updateItemNum()
	self.key_item_num:setString(item_manager:getItemNumber(musicialnote_conf[self.activityId].key_item))
	self.key_point_num:setString(item_manager:getItemNumber(musicialnote_conf[self.activityId].key_point))
end

function ActivityMusicalNotesLayer:fullScreen()
	self.title:setPositionY(self.title:getPositionY() + GameDisplay.fix_y)
	self.bottom:setPositionY(self.bottom:getPositionY() - GameDisplay.fix_y)
	self.item_bg:setPositionY(self.item_bg:getPositionY() + GameDisplay.fix_y)
	self.shop_btn:setPositionY(self.shop_btn:getPositionY() + GameDisplay.fix_y)
	self.task_btn:setPositionY(self.task_btn:getPositionY() + GameDisplay.fix_y)
end

function ActivityMusicalNotesLayer:initTest()
	musicalNotes_gamelogic_manager:registerUIRef(self)
	musicalNotes_gamelogic_manager:gameStart()
	self:registerScriptHandler(function(arg_28_0)
		if arg_28_0 == "exit" then
			musicalNotes_gamelogic_manager:exitGame()
		end
	end)
end
