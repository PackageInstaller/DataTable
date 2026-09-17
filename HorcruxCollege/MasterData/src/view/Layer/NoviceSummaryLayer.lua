NoviceSummaryLayer = class("NoviceSummaryLayer", function()
	return ccui.Layout:create()
end)

local item_data = require("data.item_data")
local novice_pass_level_data = require("data.novice_pass_level_data")
local texture_manager = require("controller.texture_manager")
local time_check_manager = require("controller.time_check_manager")
local activity_manager = require("controller.activity_manager")
local activity_return_manager = require("controller.activity_return_manager")
local level_manager = require("controller.level_manager")
local playermodel = require("model.playermodel")
local ui_layer_infos = require("controller.layerconfig.ui_layer_infos")
local pop_layer_infos = require("controller.layerconfig.pop_layer_infos")
local var_0_10 = config._DEBUG and 0 or 1
local var_0_11 = {}

local function var_0_12(arg_2_0, arg_2_1)
	if arg_2_1 then
		if pop_layer_infos[arg_2_0] and pop_layer_infos[arg_2_0].textures then
			texture_manager:loadPopLayerTextures(pop_layer_infos[arg_2_0].textures)

			for iter_2_0, iter_2_1 in pairs(pop_layer_infos[arg_2_0].textures) do
				table.insert(var_0_11, iter_2_1)
			end
		end
	elseif ui_layer_infos[arg_2_0] and ui_layer_infos[arg_2_0].textures then
		texture_manager:loadPopLayerTextures(ui_layer_infos[arg_2_0].textures)

		for iter_2_2, iter_2_3 in pairs(ui_layer_infos[arg_2_0].textures) do
			table.insert(var_0_11, iter_2_3)
		end
	end
end

local var_0_13 = {
	{
		id = 1,
		imgpath = "NoviceSummaryLayer/groupbtn_",
		tablist = {
			{
				layerName = "ActivityNoviceTaskLayer",
				id = 1,
				createFunc = function(...)
					require("view.Layer.Pops.PopBaseLayer")
					var_0_12("ActivityNoviceTaskLayer", true)

					return (ActivityNoviceTaskLayer:create(...))
				end,
				isShow = function(...)
					if not activity_manager:is_module_stat_finished(2, "task_novice") then
						return (playermodel.create_time < os.time(parse_time("2020-9-19 00:00:00")) and os.time(parse_time("2020-9-19 00:00:00")) + 1209600 or playermodel.create_time + 1209600) > time_check_manager:getCurTime()
					end
				end,
				isReddot = function(...)
					return activity_manager:getAlertAllStatus(2, "task")
				end,
				mainViewContenSize = cc.size(640, 982 + GameDisplay.fix_y * 2),
				mainViewPos = cc.p(0, 154)
			},
			{
				layerName = "ActivitySignBaseLayer",
				id = 2,
				createFunc = function(...)
					require("view.Layer.Activity.ActivitySignBaseLayer")

					local var_6_0 = ActivitySignBaseLayer:create({
						activityUIObjName = "ActivitySignFmlLayer",
						activityid = 2
					})

					function var_6_0.exit(...)
						print("点了不给关")
					end

					var_6_0:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
						var_6_0:getChildByName("gaussBg"):setVisible(false)

						var_6_0.addheight = 0 + GameDisplay.fix_y
					end)))

					return var_6_0
				end,
				isShow = function(...)
					return not activity_manager:is_module_stat_finished(2, "sign")
				end,
				isReddot = function(...)
					return activity_manager:getAlertStatus(2, "sign")
				end,
				mainViewContenSize = cc.size(640, 982 + GameDisplay.fix_y * 2),
				mainViewPos = cc.p(0, 154)
			},
			{
				layerName = "ActivityNoviceThirtyTaskLayer",
				id = 3,
				createFunc = function(...)
					require("view.Layer.Pops.ActivityNoviceThirtyTaskLayer")
					var_0_12("ActivityNoviceThirtyTaskLayer")

					return (ActivityNoviceThirtyTaskLayer:create({
						activityUIObjName = "ActivityNoviceThirtyTaskLayer",
						activityid = 480
					}))
				end,
				isShow = function(...)
					return not activity_manager:is_module_stat_finished(480, "sign")
				end,
				isReddot = function(...)
					return activity_manager:getAlertStatus(480, "sign")
				end,
				mainViewContenSize = cc.size(640, 982 + GameDisplay.fix_y * 2),
				mainViewPos = cc.p(0, 154)
			},
			{
				layerName = "ManageMoneyLayer",
				id = 4,
				createFunc = function(...)
					require("view.Layer.ManageMoneyLayer")
					var_0_12("ManageMoneyLayer")

					return (ManageMoneyLayer:create({
						activityid = MANAGE_MONEY_ACTIVITYID
					}))
				end,
				isShow = function(...)
					return activity_manager:getActivityObj(MANAGE_MONEY_ACTIVITYID)
				end,
				isReddot = function(...)
					return activity_manager:getAlertStatus(MANAGE_MONEY_ACTIVITYID, "investment")
				end,
				mainViewContenSize = cc.size(640, 982 + GameDisplay.fix_y * 2),
				mainViewPos = cc.p(0, 154)
			},
			{
				layerName = "NewbeeTwistReturnLayer",
				id = 5,
				createFunc = function(...)
					require("view.Layer.NewbeeTwistReturnLayer")
					var_0_12("NewbeeTwistReturnLayer")

					return (NewbeeTwistReturnLayer:create({
						activityid = MANAGE_MONEY_ACTIVITYID
					}))
				end,
				isShow = function(...)
					return activity_manager:getActivityObj(TWIST_RETURN_ACTIVITYID)
				end,
				isReddot = function(...)
					return activity_manager:getAlertStatus(TWIST_RETURN_ACTIVITYID, "twistreturn")
				end,
				mainViewContenSize = cc.size(640, 982 + GameDisplay.fix_y * 2),
				mainViewPos = cc.p(0, 154)
			}
		}
	},
	{
		id = 2,
		imgpath = "NoviceSummaryLayer/groupbtn_",
		tablist = {
			{
				layerName = "ActivityXinxiYaBPLayer",
				id = 1,
				createFunc = function(...)
					require("view.Layer.Activity.ActivityGeneralBPLayer")

					local var_20_0 = ActivityGeneralBPLayer:create({
						activityId = playermodel.create_time < os.time(parse_time("2022-02-12 00:00:00")) and 136 or 255
					})

					var_20_0.rootLayer:getChildByName("panel_up"):setPositionY(GameDisplay.getUiScreenSize().height - GameDisplay.fix_y - 128)
					var_20_0.rootLayer:getChildByName("Panel_zi"):setPositionY(GameDisplay.getUiScreenSize().height - 402 - GameDisplay.fix_y - 128)
					var_20_0.timeLabel:setVisible(false)
					var_20_0:setPositionY(var_20_0:getPositionY() + GameDisplay.fix_y)

					return var_20_0
				end,
				isShow = function(...)
					return activity_manager:getActivityObj(136) ~= nil or activity_manager:getActivityObj(255) ~= nil
				end,
				isReddot = function(...)
					return activity_manager:getAlertAllStatus(136) or activity_manager:getAlertStatus(255, "bpg")
				end,
				mainViewContenSize = cc.size(640, 982 + GameDisplay.fix_y * 2),
				mainViewPos = cc.p(0, 154)
			}
		}
	},
	{
		id = 3,
		imgpath = "NoviceSummaryLayer/groupbtn_",
		tablist = {
			{
				layerName = "NoviceJumpLayer",
				id = 1,
				createFunc = function(...)
					require("view.Layer.NoviceJumpLayer")
					var_0_12("NoviceJumpLayer")

					return (NoviceJumpLayer:create(...))
				end,
				isShow = function(...)
					return playermodel.create_time + 2592000 - time_check_manager:getCurTime() > 0
				end,
				isReddot = function(...)
					return false
				end,
				mainViewContenSize = cc.size(640, 1032 + GameDisplay.fix_y * 2),
				mainViewPos = cc.p(0, 104)
			}
		}
	}
}
local var_0_14 = {
	{
		id = 1,
		imgpath = "NoviceSummaryLayer/wake_groupbtn_",
		tablist = {
			{
				layerName = "PopNovicePasslevelAwardLayer",
				id = 1,
				createFunc = function(...)
					require("view.Layer.Pops.PopBaseLayer")
					var_0_12("PopNovicePasslevelAwardLayer", true)

					return (PopNovicePasslevelAwardLayer:create(...))
				end,
				isShow = function(...)
					return false
				end,
				isReddot = function(...)
					local level_manager = require("controller.level_manager")
					local var_40_1 = {}

					for iter_40_0, iter_40_1 in pairs(playermodel.novice_pass_level_award) do
						var_40_1[iter_40_1] = true
					end

					for iter_40_2, iter_40_3 in pairs((require("data.novice_pass_level_data"))) do
						if level_manager:isPlayerPassLevel(iter_40_3.limit_level) and not var_40_1[iter_40_3.id] then
							return true
						end
					end
				end,
				mainViewContenSize = cc.size(640, 982 + GameDisplay.fix_y * 2),
				mainViewPos = cc.p(0, 154)
			}
		}
	},
	{
		id = 2,
		imgpath = "NoviceSummaryLayer/wake_groupbtn_",
		tablist = {
			{
				layerName = "ActivityWakefundBaseLayer",
				id = 1,
				createFunc = function(...)
					print("ActivityWakefundBaseLayer_createFunc")
					require("view.Layer.ActivityNew.BaseLayer.ActivityWakefundBaseLayer")

					return (ActivityWakefundBaseLayer:create({
						activityid = 2
					}))
				end,
				isShow = function(...)
					return not activity_manager:is_module_stat_finished(2, "wake_fund")
				end,
				isReddot = function(...)
					return activity_manager:getAlertStatus(2, "wake_fund")
				end,
				mainViewContenSize = cc.size(640, 982 + GameDisplay.fix_y * 2),
				mainViewPos = cc.p(0, 154)
			}
		}
	},
	{
		id = 3,
		imgpath = "NoviceSummaryLayer/wake_groupbtn_",
		tablist = {
			{
				layerName = "ActivityWakefundBaseLayer2",
				id = 1,
				createFunc = function(...)
					require("view.Layer.ActivityNew.BaseLayer.ActivityWakefundBaseLayer")

					return (ActivityWakefundBaseLayer:create({
						activityid = 406
					}))
				end,
				isShow = function(...)
					if not level_manager:isPlayerPassLevel({
						chapter = 10,
						mode = 8
					}) then
						return false
					end

					return not activity_manager:is_module_stat_finished(406, "wake_fund")
				end,
				isReddot = function(...)
					return activity_manager:getAlertStatus(406, "wake_fund")
				end,
				mainViewContenSize = cc.size(640, 982 + GameDisplay.fix_y * 2),
				mainViewPos = cc.p(0, 154)
			}
		}
	},
	{
		id = 4,
		imgpath = "NoviceSummaryLayer/wake_groupbtn_",
		tablist = {
			{
				layerName = "ActivityWakefundBaseLayer3",
				id = 1,
				createFunc = function(...)
					print("ActivityWakefundBaseLayer_createFunc3")
					require("view.Layer.ActivityNew.BaseLayer.ActivityWakefundBaseLayer")

					return (ActivityWakefundBaseLayer:create({
						activityid = 486
					}))
				end,
				isShow = function(...)
					return not activity_manager:is_module_stat_finished(486, "wake_fund")
				end,
				isReddot = function(...)
					return activity_manager:getAlertStatus(486, "wake_fund")
				end,
				mainViewContenSize = cc.size(640, 982 + GameDisplay.fix_y * 2),
				mainViewPos = cc.p(0, 154)
			}
		}
	},
	{
		id = 5,
		imgpath = "NoviceSummaryLayer/wake_groupbtn_",
		tablist = {
			{
				layerName = "ActivityWakefundBaseLayer4",
				id = 1,
				createFunc = function(...)
					print("ActivityWakefundBaseLayer_createFunc4")
					require("view.Layer.ActivityNew.BaseLayer.ActivityWakefundBaseLayer")

					return (ActivityWakefundBaseLayer:create({
						activityid = 710
					}))
				end,
				isShow = function(...)
					return not activity_manager:is_module_stat_finished(710, "wake_fund")
				end,
				isReddot = function(...)
					return activity_manager:getAlertStatus(710, "wake_fund")
				end,
				mainViewContenSize = cc.size(640, 982 + GameDisplay.fix_y * 2),
				mainViewPos = cc.p(0, 154)
			}
		}
	}
}
local var_0_15
local var_0_16

function NoviceSummaryLayer.create(arg_41_0, arg_41_1)
	local var_41_0 = NoviceSummaryLayer.new()

	var_41_0:init(arg_41_1)

	return var_41_0
end

function NoviceSummaryLayer:init(arg_42_1)
	self.layerName = arg_42_1 and arg_42_1.layerName

	local var_42_0

	if arg_42_1 then
		::label_42_0::

		var_42_0 = arg_42_1.layerName and arg_42_1.isHideOther
	end

	self.isHideOther = var_42_0
	self.type = arg_42_1 and arg_42_1.type

	self:initUI()
	self:initData(function(...)
		self:updateUI()
		self:pushAnalytic()
	end)
	self:initEventListener()
	self:registerScriptHandler(function(arg_44_0)
		if arg_44_0 == "exit" then
			activity_manager:releaseEventListenerByName("NoviceSummaryLayer")

			if arg_42_1 and arg_42_1.exitCallback then
				arg_42_1.exitCallback()
			end

			texture_manager:unloadPopLayerTextures(var_0_11)
		end
	end)
end

function NoviceSummaryLayer.updateGuidesOnLayer(arg_45_0)
	LayerManager:updateGuidesOnSwitchLayer()
end

function NoviceSummaryLayer:initData(arg_46_1)
	local var_46_0 = var_0_13

	if self.type == "wake_fund" then
		var_46_0 = var_0_14
		self.isHideOther = false
	end

	activity_return_manager:get_game_buffs(function(arg_47_0)
		if tolua.isnull(self) then
			return
		end

		if self.layerName then
			for iter_47_0, iter_47_1 in pairs(var_46_0) do
				for iter_47_2, iter_47_3 in pairs(iter_47_1.tablist) do
					if iter_47_3.layerName == self.layerName then
						self.group = iter_47_1.id
						self.tab = iter_47_3.id

						break
					end
				end
			end
		end

		self.layerTbl = {}

		for iter_47_4, iter_47_5 in pairs(var_46_0) do
			local var_47_0 = 1

			while iter_47_5.tablist[var_47_0] do
				vv = iter_47_5.tablist[var_47_0]

				if self.isHideOther then
					if self.layerName == vv.layerName and vv:isShow() then
						local var_47_1 = self.layerTbl[iter_47_5.id]

						if not self.layerTbl[iter_47_5.id] then
							var_47_1 = {
								id = iter_47_5.id,
								imgpath = iter_47_5.imgpath,
								tablist = {}
							}
							self.layerTbl[iter_47_5.id] = var_47_1
						end

						var_47_1.tablist[vv.id] = vv
					end
				elseif vv:isShow() then
					local var_47_2 = self.layerTbl[iter_47_5.id]

					if not self.layerTbl[iter_47_5.id] then
						var_47_2 = {
							id = iter_47_5.id,
							imgpath = iter_47_5.imgpath,
							tablist = {}
						}
						self.layerTbl[iter_47_5.id] = var_47_2
					end

					var_47_2.tablist[vv.id] = vv
				end

				var_47_0 = var_47_0 + 1
			end
		end

		self.group = self.group or var_0_15 or 1
		self.tab = self.tab or var_0_16 or 1

		if not self.layerTbl[self.group] then
			local var_47_3 = 1

			while var_47_3 <= 5 do
				if self.layerTbl[var_47_3] then
					self.group = var_47_3

					break
				end

				var_47_3 = var_47_3 + 1
			end
		end

		if not self.layerTbl[self.group].tablist[self.tab] then
			local var_47_4 = 1

			while var_47_4 <= 5 do
				if self.layerTbl[self.group].tablist[var_47_4] then
					self.tab = var_47_4

					break
				end

				var_47_4 = var_47_4 + 1
			end
		end

		print(dump(self.layerTbl), 888)

		self.selectLayer = self.layerTbl[self.group].tablist[self.tab].layerName

		if arg_46_1 then
			arg_46_1()
		end
	end)
end

function NoviceSummaryLayer:initUI()
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.rootLayer:setAnchorPoint(cc.p(0, 0))
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootLayer)

	self.mainViewLayer = ccui.Layout:create()

	self.mainViewLayer:setTouchEnabled(true)
	self.mainViewLayer:setContentSize(640, 982 + GameDisplay.fix_y * 2)
	self.mainViewLayer:setAnchorPoint(cc.p(0, 0))
	self.mainViewLayer:setPosition(cc.p(0, 154))
	self.mainViewLayer:setClippingEnabled(true)
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.rootLayer:addChild(self.mainViewLayer, 2)

	self.bottomBg = ccui.ImageView:create("NoviceSummaryLayer/bottom_bg.png", var_0_10)

	self.bottomBg:setPositionX(320)
	self.bottomBg:setPositionY(self.bottomBg:getContentSize().height / 2)
	self.bottomBg:setTouchEnabled(true)
	self.rootLayer:addChild(self.bottomBg, 2)

	self.returnBtn = ccui.Button:create("NoviceSummaryLayer/btn_return.png", nil, "NoviceSummaryLayer/btn_return.png", var_0_10)

	self.returnBtn:setPosition(cc.p(50, 38))
	self.returnBtn:setName("NoviceSummaryLayer_returnBtn")
	self.returnBtn:addTouchEventListener(self:getReturnBtnHandel())
	self.rootLayer:addChild(self.returnBtn, 5)

	self.groupScorllView = ccui.ScrollView:create()

	self.groupScorllView:setBounceEnabled(false)
	self.groupScorllView:setPosition(cc.p(100, 0))
	self.groupScorllView:setContentSize(cc.size(540, 200))
	self.groupScorllView:setInnerContainerSize(cc.size(640, 200))
	self.groupScorllView:setDirection(ccui.ScrollViewDir.horizontal)
	self.groupScorllView:setTouchEnabled(false)
	self.rootLayer:addChild(self.groupScorllView, 4)

	self.tabScorllView = ccui.ScrollView:create()

	self.tabScorllView:setBounceEnabled(false)
	self.tabScorllView:setPosition(cc.p(0, 105))
	self.tabScorllView:setContentSize(cc.size(640, 100))
	self.tabScorllView:setInnerContainerSize(cc.size(640, 100))
	self.tabScorllView:setDirection(ccui.ScrollViewDir.horizontal)
	self.tabScorllView:setTouchEnabled(false)
	self.rootLayer:addChild(self.tabScorllView, 3)

	self.title = ccui.ImageView:create("NoviceSummaryLayer/title.png", var_0_10)

	self.title:setPosition(cc.p(320, 1136 + GameDisplay.fix_y * 2 - self.title:getContentSize().height / 2))
	self.rootLayer:addChild(self.title)
end

function NoviceSummaryLayer.getReturnBtnHandel(arg_49_0, ...)
	return function(arg_50_0, arg_50_1)
		if arg_50_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_0_15 = nil
		var_0_16 = nil

		KeyCodeManager:onKeyReleasedCallFunc()
	end
end

function NoviceSummaryLayer.getGroupBtnHandel(arg_51_0, ...)
	return function(arg_52_0, arg_52_1)
		if arg_52_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_51_0.group == arg_52_0.group then
			return
		end

		arg_51_0.group = arg_52_0.group

		while 1 <= 5 do
			if arg_51_0.layerTbl[arg_51_0.group].tablist[1] then
				arg_51_0.tab = 1

				break
			end
		end

		arg_51_0.selectLayer = arg_51_0.layerTbl[arg_51_0.group].tablist[arg_51_0.tab].layerName
		var_0_15 = arg_51_0.group
		var_0_16 = arg_51_0.tab

		arg_51_0:pushAnalytic()
		arg_51_0:updateUI()
	end
end

function NoviceSummaryLayer.getTabBtnHandel(arg_53_0, ...)
	return function(arg_54_0, arg_54_1)
		if arg_54_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_53_0.tab == arg_54_0.tab then
			return
		end

		arg_53_0.tab = arg_54_0.tab
		var_0_16 = arg_53_0.tab
		arg_53_0.selectLayer = arg_53_0.layerTbl[arg_53_0.group].tablist[arg_53_0.tab].layerName

		arg_53_0:pushAnalytic()
		arg_53_0:updateUI()
	end
end

function NoviceSummaryLayer:updateUI(...)
	(function(...)
		self.mainViewLayer:setContentSize(self.layerTbl[self.group].tablist[self.tab].mainViewContenSize.width, self.layerTbl[self.group].tablist[self.tab].mainViewContenSize.height)
		self.mainViewLayer:setPosition(self.layerTbl[self.group].tablist[self.tab].mainViewPos)

		local var_56_0 = self.layerTbl[self.group].tablist[self.tab].layerName

		self.mainViewList = self.mainViewList or {}

		if not self.mainViewList[var_56_0] then
			local var_56_1 = self:createMainViewSprite()

			self.mainViewList[var_56_0] = var_56_1

			self.mainViewLayer:addChild(var_56_1)
		end

		for iter_56_0, iter_56_1 in pairs(self.mainViewList) do
			iter_56_1:setVisible(iter_56_0 == var_56_0)
		end
	end)()
	self:updateSelectGroupBtn()
	self:updateTabBtn()
end

function NoviceSummaryLayer:updateSelectGroupBtn(...)
	while ccui.Helper:seekWidgetByName(self.groupScorllView, "groupbtn_" .. 1) do
		ccui.Helper:seekWidgetByName(self.groupScorllView, "groupbtn_" .. 1):setVisible(false)

		if ccui.Helper:seekWidgetByName(self.groupScorllView, "imgReddot_" .. 1) then
			ccui.Helper:seekWidgetByName(self.groupScorllView, "imgReddot_" .. 1):setVisible(false)
		end
	end

	local var_57_1 = self.group
	local var_57_2 = 0

	while 1 <= 5 do
		if self.layerTbl[1] then
			local var_57_3 = 1
			local var_57_4 = self.layerTbl[1]
			local var_57_5 = ccui.Helper:seekWidgetByName(self.groupScorllView, "groupbtn_" .. 1)

			if not var_57_5 then
				var_57_5 = ccui.Button:create("NoviceSummaryLayer/groupbtn_1_off.png", nil, "NoviceSummaryLayer/groupbtn_1_off.png", var_0_10)

				var_57_5:setName("groupbtn_" .. var_57_3)
				var_57_5:setPosition(cc.p(66, 58))
				var_57_5:setTouchEnabled(false)
				self.groupScorllView:addChild(var_57_5)

				local var_57_6 = ccui.Layout:create()

				var_57_6:setTouchEnabled(true)
				var_57_6:setContentSize(cc.size(var_57_5:getContentSize().width - 20, 90))
				var_57_6:setPosition(cc.p(66 - (var_57_5:getContentSize().width - 20) / 2, 0))
				var_57_6:setName("groupbtn_touchlayer_" .. var_57_3)
				var_57_6:addTouchEventListener(self:getGroupBtnHandel())
				self.groupScorllView:addChild(var_57_6)

				local var_57_7 = 66 + var_57_5:getContentSize().width - 20

				print("groupbtn:getContentSize().width\t", var_57_5:getContentSize().width)
			end

			var_57_5:setVisible(true)

			ccui.Helper:seekWidgetByName(self.groupScorllView, "groupbtn_touchlayer_" .. var_57_3).group = self.layerTbl[1].id

			if var_57_1 == self.layerTbl[1].id then
				var_57_5:loadTextures(var_57_4.imgpath .. var_57_4.id .. "_on.png", nil, var_57_4.imgpath .. var_57_4.id .. "_on.png", var_0_10)
			else
				var_57_5:loadTextures(var_57_4.imgpath .. var_57_4.id .. "_off.png", nil, var_57_4.imgpath .. var_57_4.id .. "_off.png", var_0_10)
			end

			var_57_2 = var_57_2 + var_57_5:getContentSize().width - 20 + 10

			local var_57_8

			for iter_57_0, iter_57_1 in pairs(var_57_4.tablist) do
				if iter_57_1:isReddot() then
					var_57_8 = true
				end
			end

			local var_57_9 = ccui.Helper:seekWidgetByName(self.groupScorllView, "imgReddot_" .. var_57_3)

			if var_57_9 then
				var_57_9:setVisible(false)
			end

			if var_57_8 then
				if not var_57_9 then
					var_57_9 = ccui.ImageView:create("GUI/image.png", var_0_10)

					var_57_9:setPositionX(var_57_5:getPositionX() + (var_57_5:getContentSize().width - 20) / 2 - 5)
					var_57_9:setPositionY(var_57_5:getPositionY() + var_57_5:getContentSize().height / 2 - 20)
					var_57_9:setName("imgReddot_" .. var_57_3)
					self.groupScorllView:addChild(var_57_9, 2)
				end

				var_57_9:setVisible(true)
				var_57_9:loadTexture("public/reddot/reddot2.png", var_0_10)
			end
		end
	end

	self.groupScorllView:setInnerContainerSize(cc.size(var_57_2, 90))
end

function NoviceSummaryLayer:updateTabBtn(...)
	while 1 < 5 do
		if ccui.Helper:seekWidgetByName(self.tabScorllView, "tabbtn_" .. 1) then
			ccui.Helper:seekWidgetByName(self.tabScorllView, "tabbtn_" .. 1):setVisible(false)
		end

		if ccui.Helper:seekWidgetByName(self.tabScorllView, "imgReddot_" .. 1) then
			ccui.Helper:seekWidgetByName(self.tabScorllView, "imgReddot_" .. 1):setVisible(false)
		end
	end

	local var_58_1 = self.tab
	local var_58_2 = self.layerTbl[self.group].tablist
	local var_58_3 = 0
	local var_58_4 = 1

	while var_58_4 <= 5 do
		if var_58_2[var_58_4] then
			local var_58_5 = var_58_4
			local var_58_6 = var_58_2[var_58_4]
			local var_58_7 = ccui.Helper:seekWidgetByName(self.tabScorllView, "tabbtn_" .. var_58_4)

			if not var_58_7 then
				var_58_7 = ccui.Button:create("NoviceSummaryLayer/" .. var_58_6.layerName .. "_off.png", nil, "NoviceSummaryLayer/" .. var_58_6.layerName .. "_off.png", var_0_10)

				var_58_7:setName("tabbtn_" .. var_58_5)
				var_58_7:setPosition(cc.p(78, 23))
				var_58_7:addTouchEventListener(self:getTabBtnHandel())
				self.tabScorllView:addChild(var_58_7)
			end

			local var_58_8 = 78 + var_58_7:getContentSize().width

			var_58_7:setVisible(true)

			var_58_7.tab = var_58_2[var_58_4].id

			if var_58_1 == var_58_2[var_58_4].id then
				var_58_7:loadTextures("NoviceSummaryLayer/" .. var_58_6.layerName .. "_on.png", nil, "NoviceSummaryLayer/" .. var_58_6.layerName .. "_on.png", var_0_10)
			else
				var_58_7:loadTextures("NoviceSummaryLayer/" .. var_58_6.layerName .. "_off.png", nil, "NoviceSummaryLayer/" .. var_58_6.layerName .. "_off.png", var_0_10)
			end

			var_58_3 = var_58_3 + var_58_7:getContentSize().width

			if var_58_6:isReddot() then
				local var_58_9 = ccui.Helper:seekWidgetByName(self.tabScorllView, "imgReddot_" .. var_58_5)

				if not var_58_9 then
					var_58_9 = ccui.ImageView:create("GUI/image.png", var_0_10)

					var_58_9:setPositionX(var_58_7:getPositionX() + var_58_7:getContentSize().width / 2 - 5)
					var_58_9:setPositionY(var_58_7:getPositionY() + var_58_7:getContentSize().height / 2 - 5)
					var_58_9:setName("imgReddot_" .. var_58_5)
					self.tabScorllView:addChild(var_58_9, 2)
				end

				var_58_9:setVisible(true)
				var_58_9:loadTexture("public/reddot/reddot2.png", var_0_10)
			end

			if var_58_2[var_58_4].layerName == "NoviceJumpLayer" then
				var_58_7:setVisible(false)
			end
		end

		var_58_4 = var_58_4 + 1
	end

	self.tabScorllView:setInnerContainerSize(cc.size(var_58_3, 46))
end

function NoviceSummaryLayer:createMainViewSprite()
	return (self.layerTbl[self.group].tablist[self.tab]:createFunc())
end

function NoviceSummaryLayer:initEventListener()
	activity_manager:registerEventListener("NoviceSummaryLayer", activity_manager.activityEventId.UPDATE_ACTIVITY_STATUS_ALERT, function(arg_61_0)
		self:updateUI()
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("NOVICE_SUMMARY_UPDATE", function()
		self:updateGuidesOnLayer()
	end), self)
end

function NoviceSummaryLayer:pushAnalytic(...)
	print("点击了 " .. self.group .. " " .. self.tab .. " " .. self.selectLayer)
	AnalyticManager.clickNoviceSummaryLayer({
		layerName = self.selectLayer
	})
end

return NoviceSummaryLayer
