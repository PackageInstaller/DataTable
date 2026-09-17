TestFightLayer = class("TestFightLayer", function()
	return cc.Layer:create()
end)

local model_data = require("data.model_data")
local test_fight_manager = require("controller.test_fight_manager")
local var_0_2 = require("controller.formation.formation_manager"):getInstance()
local activity_manager = require("controller.activity_manager")
local TempWidget = require("view/Sprite/TempWidget")
local var_0_5 = config._DEBUG and 0 or 1

function TestFightLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = TestFightLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function TestFightLayer:init(arg_3_1)
	self.bg = TempWidget:CreateTempImg("mainScenebg/roledatabg.jpg", self, 0)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "TestFightLayer.json" or "TestFightLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.setPlayerArray = arg_3_1

	self:initUI()
	self:registerEventListener()
	self:fullScreen()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("TestFightLayer")
		end
	end)
end

function TestFightLayer.registerEventListener(arg_5_0)
	activity_manager:registerEventListener("TestFightLayer", activity_manager.activityEventId.CHANGE_TEST_E_FIGHT_ARRAY_SUCCESS, function(arg_6_0)
		arg_5_0:updatePvpPanel()
		arg_5_0:updatePvePanel()
	end)
	activity_manager:registerEventListener("TestFightLayer", activity_manager.activityEventId.CHANGE_TEST_P_FIGHT_ARRAY_SUCCESS, function(arg_7_0)
		arg_5_0:updatePlayerPanel()
	end)
end

function TestFightLayer:initUI()
	self:initBottomList()
	self:initEmptyPanel()
	self:initPlayerPanel()
end

function TestFightLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	self.rootLayer:addChild(self.bottomList, 6)

	self.title = self.rootLayer:getChildByName("title")

	self.title:getChildByName("btn_shop"):addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("MarketLayer", {
			singleMarket = "1-17101"
		})
	end)
end

function TestFightLayer:initEmptyPanel()
	self.pvpPanel = self.rootLayer:getChildByName("pvp_panel")
	self.pvePanel = self.rootLayer:getChildByName("pve_panel")

	self.pvpPanel:getChildByName("desc"):setString(L_PVP_TEST_FIGHT)
	self.pvePanel:getChildByName("desc"):setString(L_PVE_TEST_FIGHT)
	test_fight_manager:getPvpArrayFromSever()
end

function TestFightLayer:initPlayerPanel()
	self.playerPanel = self.rootLayer:getChildByName("player_panel")

	test_fight_manager:getPLayerArrayFromSever(self.setPlayerArray)
end

function TestFightLayer:updatePvpPanel()
	local var_14_0 = test_fight_manager:getPvpArray()

	for iter_14_0 = 1, FORMATION_SHOW_GIRL_NUM do
		local var_14_1 = self.pvpPanel:getChildByName("role_" .. iter_14_0)

		if var_14_0[iter_14_0] then
			var_14_1:setScale(0.45)
			var_14_1:loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[var_14_0[iter_14_0].modelid].cute_role .. ".png")
		else
			var_14_1:setScale(1)
			var_14_1:loadTexture("TestFightLayer/role_bg.png", var_0_5)
		end

		var_14_1:setTouchEnabled(true)
		var_14_1:addTouchEventListener(function(arg_15_0, arg_15_1)
			if arg_15_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_0_2:pushFormationLayer("FormationTestFightLayer", {
				configtype = CONFIG_TYPE_TEST_FIGHT_EMPTY
			})
		end)
	end

	self.pvpPanel:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if FightManager.refreshFightToType(FIGHTTYPE_STAKE_PVP) then
			LayerManager:switchShowLayer("FightLayer", {
				is_hide_topcost = true,
				is_hide_listbutton = true
			})
		end
	end)
end

function TestFightLayer:updatePvePanel()
	for iter_17_0, iter_17_1 in pairs((test_fight_manager:getPveArray())) do
		local var_17_0 = self.pvePanel:getChildByName("role_" .. iter_17_0)

		var_17_0:setScale(0.45)
		var_17_0:loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[iter_17_1.modelid].cute_role .. ".png")
	end

	self.pvePanel:setTouchEnabled(true)
	self.pvePanel:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		if FightManager.refreshFightToType(FIGHTTYPE_STAKE_PVE) then
			LayerManager:switchShowLayer("FightLayer", {
				is_hide_topcost = true,
				is_hide_listbutton = true
			})
		end
	end)
end

function TestFightLayer:updatePlayerPanel()
	local var_19_0 = test_fight_manager:getPlayerArray()

	for iter_19_0 = 1, FORMATION_SHOW_GIRL_NUM do
		local var_19_1 = self.playerPanel:getChildByName("role_" .. iter_19_0)

		if var_19_0[iter_19_0] then
			var_19_1:setScale(0.45)
			var_19_1:loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[var_19_0[iter_19_0].modelid].cute_role .. ".png")
		else
			var_19_1:setScale(1)
			var_19_1:loadTexture("TestFightLayer/role_bg.png", var_0_5)
		end

		var_19_1:setTouchEnabled(true)
		var_19_1:addTouchEventListener(function(arg_20_0, arg_20_1)
			if arg_20_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_0_2:pushFormationLayer("FormationTestFightLayer", {
				configtype = CONFIG_TYPE_TEST_FIGHT_PLAYER
			})
		end)
	end
end

function TestFightLayer:fullScreen()
	self.bg:align(cc.p(0.5, 0.5), self:getContentSize().width / 2, self:getContentSize().height / 2 - GameDisplay.fix_y)
	self.title:setPositionY(self.title:getPositionY() + GameDisplay.fix_y)
	self.pvpPanel:setPositionY(self.pvpPanel:getPositionY() + GameDisplay.fix_y * 0.61)
	self.pvePanel:setPositionY(self.pvePanel:getPositionY() + GameDisplay.fix_y * 0.31)
	self.playerPanel:setPositionY(self.playerPanel:getPositionY() - GameDisplay.fix_y * 0.5)
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
end
