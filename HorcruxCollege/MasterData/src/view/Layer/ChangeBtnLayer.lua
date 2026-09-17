ChangeBtnLayer = class("ChangeBtnLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local var_0_1 = 601
local scorearena_manager = require("controller.scorearena_manager")
local arena_manager = require("controller.arena_manager")
local alert_manager = require("controller.alert_manager")
local array_manager = require("controller.array_manager")
local monster_manager = require("controller.monster_manager")
local time_check_manager = require("controller.time_check_manager")
local levelmode_data = require("data.levelmode_data")
local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local substitution_manager = require("controller.substitution_manager")
local audio_manager = require("controller.audio_manager")
local model_data = require("data.model_data")
local var_0_14 = GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT
local network = require("network.network")

function ChangeBtnLayer.create(arg_2_0)
	local var_2_0 = ChangeBtnLayer.new()

	var_2_0:init()

	return var_2_0
end

function ChangeBtnLayer.getInstance()
	return ChangeBtnLayerInstance
end

local var_0_16 = {
	"ArenaLayer"
}
local var_0_18 = {
	ScoreArenaLayer = {
		{
			x = 5,
			y = 267
		},
		{
			x = 5,
			y = 350
		},
		{
			x = 621,
			y = 350
		},
		{
			x = 621,
			y = 3
		}
	},
	ArenaLayer = {
		{
			x = 0,
			y = 0
		},
		{
			x = 0,
			y = 341
		},
		{
			x = 621,
			y = 80
		},
		{
			x = 621,
			y = 0
		}
	}
}
local var_0_19 = {
	ArenaLayer = "button_arean",
	ScoreArenaLayer = "button_scroce"
}

local function var_0_20(arg_4_0, arg_4_1)
	if arg_4_1 == ccui.TouchEventType.began then
		if not isContainPosOfConvexPolygon(var_0_18[arg_4_0.key], (arg_4_0:convertToNodeSpace((arg_4_0:getTouchBeganPosition())))) then
			return
		end

		if arg_4_0:getName() == "button_scroce" then
			arg_4_0:loadTextures("adventurenewlayer/jifensai1.png", "adventurenewlayer/jifensai1.png", "adventurenewlayer/jifensai1.png", var_0_0)
		else
			arg_4_0:loadTextures("adventurenewlayer/qiangwei1.png", "adventurenewlayer/qiangwei1.png", "adventurenewlayer/qiangwei1.png", var_0_0)
		end
	elseif arg_4_1 == ccui.TouchEventType.canceled then
		if arg_4_0:getName() == "button_scroce" then
			arg_4_0:loadTextures("adventurenewlayer/jifensai.png", "adventurenewlayer/jifensai.png", "adventurenewlayer/jifensai.png", var_0_0)
		else
			arg_4_0:loadTextures("adventurenewlayer/qiangwei.png", "adventurenewlayer/qiangwei.png", "adventurenewlayer/qiangwei.png", var_0_0)
		end
	elseif arg_4_1 == ccui.TouchEventType.ended then
		if arg_4_0:getName() == "button_scroce" then
			arg_4_0:loadTextures("adventurenewlayer/jifensai.png", "adventurenewlayer/jifensai.png", "adventurenewlayer/jifensai.png", var_0_0)
		else
			arg_4_0:loadTextures("adventurenewlayer/qiangwei.png", "adventurenewlayer/qiangwei.png", "adventurenewlayer/qiangwei.png", var_0_0)
		end
	end

	if arg_4_1 ~= ccui.TouchEventType.ended then
		return
	end

	if not isContainPosOfConvexPolygon(var_0_18[arg_4_0.key], (arg_4_0:convertToNodeSpace((arg_4_0:getTouchBeganPosition())))) then
		return
	end

	local var_4_0 = arg_4_0:getName()

	if not var_4_0 then
		return
	end

	for iter_4_0, iter_4_1 in pairs(var_0_19) do
		if iter_4_1 == var_4_0 then
			if iter_4_0 == "ArenaLayer" then
				AnalyticManager.click_arean_enter()

				local var_4_1, var_4_2 = LayerManager:getLayerUnlockStat("ArenaLayer")

				if var_4_1 then
					-- block empty
				end

				ChangeBtnLayerInstance:updateNewAlertStatus()
			else
				AnalyticManager.click_score_enter()
				RoleDefault:getInstance():setIntegerForKey("ScoreArenaEnterTime", os.time() - 86400)
				ChangeBtnLayerInstance:updateNewAlertStatus()
			end

			LayerManager:switchShowLayer(iter_4_0)
		end
	end
end

local function var_0_21(arg_5_0)
	if not arg_5_0 then
		return
	end

	if arg_5_0 >= 86400 then
		return string.format(L_TIME_FORMAT[1], math.floor(arg_5_0 / 86400), math.floor(arg_5_0 % 86400 / 3600))
	elseif arg_5_0 >= 3600 then
		return string.format(L_TIME_FORMAT[2], math.floor(arg_5_0 / 3600), math.floor(arg_5_0 % 3600 / 60))
	else
		return string.format(L_TIME_FORMAT[3], math.floor(arg_5_0 / 60))
	end
end

function ChangeBtnLayer:init()
	ChangeBtnLayerInstance = self
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ChangeBtnLayer.json" or "ChangeBtnLayer.ExportJson")

	self.rootlayer:setBackGroundColorOpacity(0)
	self:addChild(self.rootlayer)

	self.btn_scroce = ccui.Helper:seekWidgetByName(self.rootlayer, "button_scroce")
	self.btn_arena = ccui.Helper:seekWidgetByName(self.rootlayer, "button_arean")
	self.timelable = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_22")

	self.timelable:setString("")

	self.ranklable = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_23")
	self.ranklable_bg = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_26")
	self.rankClass = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_arenaclass")
	self.nojiesuo = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_28")
	self.lock = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_28")
	self.btn_ade4 = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_shilianta")

	self.btn_ade4:setPositionY(self.btn_ade4:getPositionY() - 25)

	self.btn_back = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_23")
	self.listview = ccui.Helper:seekWidgetByName(self.rootlayer, "listview_ade")
	self.listviewitem = ccui.Helper:seekWidgetByName(self.rootlayer, "items")

	self.btn_ade4:setVisible(false)

	self.bossface = ccui.Helper:seekWidgetByName(self.rootlayer, "bossface")
	self.bossani = ccui.Helper:seekWidgetByName(self.rootlayer, "aniimg")
	self.scoretime = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_25")
	self.bosschang = ccui.Helper:seekWidgetByName(self.rootlayer, "bosschang_btn")
	self.substitutionBtn = ccui.Helper:seekWidgetByName(self.rootlayer, "substitution_btn")
	self.isSub = self:checkSubTime()

	self:moveToScreenOut()

	if self.isSub then
		self:initBigBossChange()
	else
		self:initBigBossChange()
		self.bosschang:getChildByName("Label_level"):setPosition(cc.p(60, 25))
		self.substitutionBtn:setVisible(false)
		self.bosschang:loadTextures("adventurenewlayer/boss_change_origin.png", "adventurenewlayer/boss_change1_origin.png", "adventurenewlayer/boss_change1_origin.png", var_0_0)
	end

	for iter_6_0, iter_6_1 in pairs(var_0_19) do
		if iter_6_0 == "ScoreArenaLayer" then
			ccui.Helper:seekWidgetByName(self.rootlayer, iter_6_1):setSwallowTouches(true)
		else
			ccui.Helper:seekWidgetByName(self.rootlayer, iter_6_1):setSwallowTouches(false)
		end

		ccui.Helper:seekWidgetByName(self.rootlayer, iter_6_1).key = iter_6_0

		ccui.Helper:seekWidgetByName(self.rootlayer, iter_6_1):addTouchEventListener(var_0_20)
	end

	local var_6_0, var_6_1 = LayerManager:getLayerUnlockStat("AdventureNewTowerLayer")

	self.bosschang:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("AdventureNewTowerLayer", 5)
		RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", 5)
	end)
	self.btn_back:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:playEnterOrOutAni(nil, function()
			LayerManager:switchShowLayer("FightLayer")
		end)
	end)
	self:initSubEntrance(var_0_1)
	self:updateScoreTime()
	self:registerScriptHandler(function(arg_10_0)
		if arg_10_0 == "exit" then
			ChangeBtnLayerInstance = nil
		end
	end)
	self:initPanelList_H()

	self.Panel_top = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_top")

	self:fullScreen(self.rootlayer)
	self:playEnterOrOutAni(true)
	self:registerScriptHandler(function(arg_11_0)
		if arg_11_0 == "exit" then
			-- block empty
		end
	end)
end

function ChangeBtnLayer:initBigBossChange()
	self.btn_ade4:loadTextures("adventurenewlayer/lianta.png", "adventurenewlayer/lianta1.png", "adventurenewlayer/lianta1.png", var_0_0)

	local var_12_0

	for iter_12_0, iter_12_1 in pairs(levelmode_data) do
		if iter_12_1.modetype == 5 then
			var_12_0 = iter_12_1
		end
	end

	if var_12_0 then
		local var_12_3 = playermodel.levelmode[var_12_0.mode].status

		if playermodel.levelmode[var_12_0.mode].status then
			if var_12_3 <= var_12_0.totalchapter then
				self.bosschang:getChildByName("Label_level"):setString("" .. var_12_3)
			else
				self.bosschang:getChildByName("Label_level"):setString(L_CLEAR_ALL)
			end
		else
			self.bosschang:getChildByName("Label_level"):setString("")
		end

		if var_12_3 > var_12_0.totalchapter then
			-- block empty
		end
	end
end

function ChangeBtnLayer:initPanelList_H()
	self.listview:setItemsMargin(0)
	self.listviewitem:retain()
	self.listviewitem:removeFromParent()

	local var_13_0 = var_0_14

	if var_0_14 > 160 then
		var_13_0 = 160
	end

	self.listview:setContentSize(cc.size(GameDisplay.getScreenSize().width, 317 + var_13_0))
	self.listviewitem:setContentSize(cc.size(212, 317 + var_13_0))

	for iter_13_0, iter_13_1 in ipairs((self:getModeTypeData())) do
		local var_13_1 = self.listviewitem:clone()

		var_13_1:setName("icon" .. iter_13_0)

		local var_13_2 = var_13_1:getChildByName("button_ade")
		local var_13_3 = var_13_2:getChildByName("Image_18"):getChildByName("labeltime")

		var_13_2:setName("Button_ade" .. iter_13_0)
		var_13_3:setName("labeltime" .. iter_13_0)
		var_13_2:getChildByName("Image_18"):setVisible(false)

		if iter_13_1 == 2 then
			var_13_2:loadTextures("adventurenewlayer/wuzi.png", "adventurenewlayer/wuzi1.png", "adventurenewlayer/wuzi.png", var_0_0)
		elseif iter_13_1 == 3 then
			var_13_2:loadTextures("adventurenewlayer/yuansu.png", "adventurenewlayer/yuansu1.png", "adventurenewlayer/yuansu.png", var_0_0)
		elseif iter_13_1 == 4 then
			var_13_2:loadTextures("adventurenewlayer/zhiye.png", "adventurenewlayer/zhiye1.png", "adventurenewlayer/zhiye.png", var_0_0)
		elseif iter_13_1 == 5 then
			var_13_2:loadTextures("adventurenewlayer/boss_change.png", "adventurenewlayer/boss_change1.png", "adventurenewlayer/boss_change.png", var_0_0)
		end

		self:updatAdeTimes(var_13_1, iter_13_0, iter_13_1)
		var_13_2:addTouchEventListener(function(arg_14_0, arg_14_1)
			if arg_14_1 ~= ccui.TouchEventType.ended then
				return
			end

			if iter_13_1 ~= 5 then
				LayerManager:switchShowLayer("AdventureNewItemLayer", {
					layer = iter_13_1
				})
				RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", iter_13_1)
				self:updateNewAlertStatus()
			else
				LayerManager:switchShowLayer("AdventureNewTowerLayer", 5)
				RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", 5)
			end
		end)
		self.listview:pushBackCustomItem(var_13_1)
	end
end

function ChangeBtnLayer:initSubEntrance(arg_15_1)
	local function var_15_0(arg_16_0)
		print("result=======", arg_16_0)

		if arg_16_0 == 1 then
			LayerManager:switchShowLayer("FightLayer")
			FightManager.refreshFightToType(FIGHTTYPE_SUBSTITUTION)
		else
			if arg_16_0 == 2 or arg_16_0 == 3 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_SUBSTITUTION_WARNING[arg_16_0])
			end

			GuideListener.showAllGuidesWithFullScreen(true)
		end
	end

	self.substitutionBtn:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("SubstitutionBossLayer")
	end)
end

function ChangeBtnLayer.updatAdeTimes(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	arg_22_1:getChildByName("Button_ade" .. arg_22_2):getChildByName("Image_18"):setVisible(false)

	if arg_22_3 == 5 then
		return
	end

	level_manager:getAdventureDailytimeByModeType(nil, function(arg_23_0, arg_23_1)
		arg_22_0.times = arg_23_1

		local var_23_0 = 0

		if arg_22_0.times then
			for iter_23_0, iter_23_1 in pairs(arg_22_0.times) do
				if iter_23_1.modetype == arg_22_3 then
					var_23_0 = iter_23_1.time

					break
				end
			end

			if var_23_0 < 0 then
				var_23_0 = 0
			end

			arg_22_1:getChildByName("Button_ade" .. arg_22_2):getChildByName("Image_18"):getChildByName("labeltime" .. arg_22_2):setString("" .. var_23_0)
		else
			arg_22_1:getChildByName("Button_ade" .. arg_22_2):getChildByName("Image_18"):setVisible(false)
		end
	end)
end

function ChangeBtnLayer.getModeTypeData(arg_24_0)
	return {
		2,
		3,
		4
	}
end

function ChangeBtnLayer:updateButtonsUnlockStatus()
	for iter_25_0, iter_25_1 in ipairs(var_0_16) do
		local var_25_0, var_25_1 = LayerManager:getLayerUnlockStat(iter_25_1)

		if not var_25_0 then
			if self.btn_arena:getChildByName("alert_new") then
				self.btn_arena:getChildByName("alert_new"):setVisible(false)
			end

			self.ranklable_bg:setVisible(false)
			self.lock:setVisible(true)
		else
			if not RoleDefault:getInstance():getBoolForKey("ArenaLayerIsEnter", false) then
				-- block empty
			end

			arena_manager:get_fight_data(function(arg_26_0)
				self:updateArenaBtnLable(arg_26_0.rank, arg_26_0.class)
			end)
		end
	end
end

function ChangeBtnLayer.initNewAlertStatus(arg_27_0)
	return
end

function ChangeBtnLayer.updateNewAlertStatus(arg_28_0)
	return
end

function ChangeBtnLayer:updateScoreTime()
	local var_29_0 = require("controller.time_check_manager"):getCurTime()
	local var_29_1 = os.date("*t", math.floor(var_29_0))
	local var_29_2 = 0

	if var_29_1.wday < 7 and var_29_1.wday >= 2 then
		var_29_2 = (5 - (var_29_1.wday - 1)) * 24 * 3600 + (23 - var_29_1.hour) * 3600 + (59 - var_29_1.min) * 60 + (59 - var_29_1.sec)
	elseif var_29_1.wday == 1 then
		var_29_2 = (23 - var_29_1.hour) * 3600 + (59 - var_29_1.min) * 60 + (59 - var_29_1.sec) + 432000
	elseif var_29_1.wday == 7 then
		var_29_2 = (23 - var_29_1.hour) * 3600 + (59 - var_29_1.min) * 60 + (59 - var_29_1.sec) + 518400
	end

	self.endtime = var_29_2 + var_29_0

	self:updateScroceBtnLable(var_29_2)
	self:updateButtonsUnlockStatus()
	self:initNewAlertStatus()
end

function ChangeBtnLayer.checkSubTime(arg_30_0)
	if time_check_manager:getCurTime() >= global_get_time_by_date("2019-12-7 00:00:00") then
		return true
	else
		return false
	end
end

function ChangeBtnLayer:updateScroceBtnLable(arg_31_1)
	self.timelable:setString((var_0_21(arg_31_1)))
end

function ChangeBtnLayer:updateArenaBtnLable(arg_32_1, arg_32_2)
	self.ranklable_bg:setVisible(true)
	self.lock:setVisible(false)

	if arg_32_1 < 0 then
		self.ranklable:setString(L_PVP_RESULT_NO_RANK)
		self.ranklable:setPositionX(self.ranklable:getPositionX() - 15)
	elseif arg_32_1 < 1000 then
		self.ranklable:setString(string.format("%03d", arg_32_1))
	else
		self.ranklable:setString(arg_32_1)
	end

	if arg_32_1 >= 10000 then
		self.ranklable:setPositionX(self.ranklable:getPositionX() - 15)
	end

	if arg_32_2 < 1000 then
		self.rankClass:getChildByName("label_class"):setString(string.format("%04d", arg_32_2))
	else
		self.rankClass:getChildByName("label_class"):setString(arg_32_2)
	end
end

function ChangeBtnLayer:initBottomList()
	local var_33_0 = BottomBtnList:create(function(arg_34_0, arg_34_1)
		if arg_34_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchReturnLayer("FightLayer")
	end)

	var_33_0:setName("bottomlist")
	self:addChild(var_33_0, 10)
end

function ChangeBtnLayer:fullScreen(arg_35_1)
	arg_35_1:setContentSize((GameDisplay.getScreenSize()))
	arg_35_1:setPositionY(arg_35_1:getPositionY() - GameDisplay.fix_y)
	self.Panel_top:setPositionY(self.Panel_top:getPositionY() + var_0_14)

	local var_35_0 = 0

	if var_0_14 > 160 then
		var_35_0 = var_0_14 - 160
	end

	self.bosschang:setPositionY(self.bosschang:getPositionY() + var_0_14 - var_35_0 / 2 + 2)
	self.substitutionBtn:setPositionY(self.substitutionBtn:getPositionY() + var_0_14 - var_35_0 / 2 - 4)
end

function ChangeBtnLayer:playEnterOrOutAni(arg_36_1, arg_36_2)
	if arg_36_1 then
		self.btn_arena:runAction(cc.MoveTo:create(0.5, cc.p(316, self.btn_arena:getPositionY())))
		self.btn_scroce:runAction(cc.MoveTo:create(0.5, cc.p(316, self.btn_scroce:getPositionY())))
		self.listview:runAction(cc.MoveTo:create(0.5, cc.p(0, self.listview:getPositionY())))
		self.btn_ade4:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.MoveTo:create(0.5, cc.p(534, self.btn_ade4:getPositionY()))))

		if self.isSub then
			self.bosschang:runAction(cc.MoveTo:create(0.5, cc.p(452, self.bosschang:getPositionY())))
			self.substitutionBtn:runAction(cc.MoveTo:create(0.5, cc.p(180, self.substitutionBtn:getPositionY())))
		else
			self.bosschang:runAction(cc.MoveTo:create(0.5, cc.p(320, self.bosschang:getPositionY())))
		end
	else
		self.btn_arena:runAction(cc.MoveTo:create(0.5, cc.p(-1500, self.btn_arena:getPositionY())))
		self.btn_scroce:runAction(cc.MoveTo:create(0.5, cc.p(1500, self.btn_scroce:getPositionY())))
		self.listview:runAction(cc.MoveTo:create(0.5, cc.p(1500, self.listview:getPositionY())))
		self.btn_ade4:runAction(cc.MoveTo:create(0.5, cc.p(1500, self.btn_ade4:getPositionY())))

		if self.isSub then
			self.bosschang:runAction(cc.MoveTo:create(0.5, cc.p(1500, self.bosschang:getPositionY())))
			self.substitutionBtn:runAction(cc.MoveTo:create(0.5, cc.p(-1500, self.substitutionBtn:getPositionY())))
		else
			self.bosschang:runAction(cc.MoveTo:create(0.5, cc.p(1500, self.bosschang:getPositionY())))
		end

		if arg_36_2 then
			arg_36_2()
		end
	end
end

function ChangeBtnLayer:moveToScreenOut()
	self.btn_arena:setPositionX(-1500)
	self.btn_scroce:setPositionX(1500)
	self.listview:setPositionX(1500)
	self.btn_ade4:setPositionX(1500)
	self.bosschang:setPositionX(1500)
	self.substitutionBtn:setPositionX(-1500)
end

return ChangeBtnLayer
