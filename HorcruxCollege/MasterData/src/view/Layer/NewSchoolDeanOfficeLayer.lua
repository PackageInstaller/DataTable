NewSchoolDeanOfficeLayer = class("NewSchoolDeanOfficeLayer", function()
	return cc.Layer:create()
end)

local souls_manager = require("controller.souls_manager")
local role_false_level_manager = require("controller.role_false_level_manager")
local var_0_2 = require("controller/help_battle/help_battle_manager"):getInstance()
local var_0_3 = require("controller.course_cultivate_manager").getInstance()
local bond_manager = require("controller.bond_manager")
local servant_level_data = require("data.servant_level_data")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_7 = {
	IMAGINARY = 7,
	BASE = 1,
	OTHER = 12,
	QUANTUM = 4,
	POSITIVE = 10,
	ZEROSUPPERESSION = 11,
	LIGHT_ENERGY = 2,
	MIMICRY = 9,
	DEVIL = 8,
	DRAK_MATTER = 6,
	THERMAL_ENERGY = 3,
	ELECTROMAGNETISM = 5
}
local var_0_8 = {
	var_0_2.CAREER.SHOOTER,
	var_0_2.CAREER.ASSASSIN,
	var_0_2.CAREER.WARRIOR,
	var_0_2.CAREER.SUPPORT,
	var_0_2.CAREER.MASTER,
	var_0_2.CAREER.TANK
}
local playermodel = require("model.playermodel")
local audio_manager = require("controller.audio_manager")
local theater_director = require("controller.theater_director")
local lab_manager = require("controller.lab_manager")
local alert_manager = require("controller.alert_manager")
local l2utils = require("controller.l2utils")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local lab_workshop_data = require("data.lab_workshop_data")
local lab_recipe_data = require("data.lab_recipe_data")
local npc_data = require("data.npc_data")
local Utility = require("common.Utility")
local var_0_23 = "NewSchoolDeanOfficeLayer/"

local function var_0_24(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:setVisible(true)
	arg_2_0:setOpacity(0)
	arg_2_0:runAction(cc.Sequence:create(cc.DelayTime:create(arg_2_1), cc.FadeIn:create(arg_2_2)))
end

function NewSchoolDeanOfficeLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = NewSchoolDeanOfficeLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

local var_0_25 = config._DEBUG and 0 or 1

function NewSchoolDeanOfficeLayer.returnEvent(arg_4_0)
	KeyCodeManager:onKeyReleasedCallFunc()
end

function NewSchoolDeanOfficeLayer:init(arg_5_1)
	self.initconfig = initconfig

	AnalyticManager.enterOffice()

	self.initParam = arg_5_1

	self:initUI()
	self:createAni()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("updateNewSchoolDeanOfficeData", function(arg_6_0)
		self:updateUI()
	end), self)
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			-- block empty
		end
	end)
end

function NewSchoolDeanOfficeLayer:initUI(arg_8_1)
	self.rootLayer = ccui.ImageView:create("mainScenebg/newSchoolDeanOfficeLayer_bg.png")

	self:addChild(self.rootLayer)
	self.rootLayer:setAnchorPoint(0, 0)
	self.rootLayer:setPositionY(-GameDisplay.fix_y)

	local var_8_0 = ccui.Button:create(var_0_23 .. "title.png", nil, var_0_23 .. "title.png", var_0_25)

	self.rootLayer:addChild(var_8_0, 2)
	var_8_0:setAnchorPoint(0, 1)
	var_8_0:setPosition(20, GameDisplay.height - 20)

	local var_8_1 = ccui.Button:create(var_0_23 .. "btn_return.png", nil, var_0_23 .. "btn_return.png", var_0_25)

	self.rootLayer:addChild(var_8_1, 2)
	var_8_1:setAnchorPoint(0, 0)
	var_8_1:setPosition(20, 20)
	var_8_1:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self:initList()
	self:initContract()
	self:initAfkLevel()
	self:initHelpBattle()
	self:initBasicCourse()
	self:initElementCourse()
	self:initBond()
end

function NewSchoolDeanOfficeLayer:initList()
	self.additionListView = ccui.ListView:create()

	self.additionListView:setDirection(ccui.ScrollViewDir.vertical)
	self.additionListView:setContentSize(cc.size(570, GameDisplay.height - 250))
	self.additionListView:setPosition(cc.p(335, 120))
	self.rootLayer:addChild(self.additionListView, 2)
	self.additionListView:setBounceEnabled(true)
	self.additionListView:setAnchorPoint(0.5, 0)

	self.listcells = {}
end

function NewSchoolDeanOfficeLayer:initContract()
	local var_11_0 = souls_manager:get_total_contract_attr()
	local var_11_1 = ccui.ImageView:create(var_0_23 .. "contract_bg.png", var_0_25)

	self.additionListView:pushBackCustomItem(var_11_1)

	local var_11_2 = ccui.Button:create(var_0_23 .. "go_btn.png", nil, var_0_23 .. "go_btn.png", var_0_25)

	var_11_1:addChild(var_11_2, 2)
	var_11_2:setAnchorPoint(0, 0)
	var_11_2:setPosition(310, 35)
	var_11_2:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopContractAttrDetailLayer")
	end)

	local var_11_3 = cc.Label:createWithTTF("前往共振", FONT_BUTTON, 27)

	var_11_3:setPosition(var_11_2:getContentSize().width / 2, var_11_2:getContentSize().height / 2 + 5)
	var_11_2:addChild(var_11_3)

	local var_11_4 = cc.Label:createWithTTF(var_11_0, FONT_NAME, 25)

	var_11_4:setPosition(355, 204)
	var_11_1:addChild(var_11_4)
	var_11_4:setColor(cc.c3b(220, 50, 58))
	var_11_4:setAnchorPoint(0, 0)

	local var_11_5 = cc.Label:createWithTTF(100 * CONTRACT_ATTR_ADD * var_11_0 .. "%", FONT_NAME, 25)

	var_11_5:setPosition(355, 157)
	var_11_1:addChild(var_11_5)
	var_11_5:setColor(cc.c3b(220, 50, 58))
	var_11_5:setAnchorPoint(0, 0)
	table.insert(self.listcells, var_11_1)
end

function NewSchoolDeanOfficeLayer:initAfkLevel()
	local var_13_0 = role_false_level_manager:getCurAfkLevel()
	local var_13_1 = math.round(0.1 * ((servant_level_data[var_13_0] or nil) and (servant_level_data[var_13_0].strengthen_attribute or 0)))
	local var_13_2 = ccui.ImageView:create(var_0_23 .. "afk_level_bg.png", var_0_25)

	self.additionListView:pushBackCustomItem(var_13_2)

	local var_13_3 = ccui.Button:create(var_0_23 .. "go_btn.png", nil, var_0_23 .. "go_btn.png", var_0_25)

	var_13_2:addChild(var_13_3, 2)
	var_13_3:setAnchorPoint(0, 0)
	var_13_3:setPosition(310, 35)
	var_13_3:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("AfkLevelLayer")
	end)

	local var_13_4 = cc.Label:createWithTTF("前往协调台", FONT_BUTTON, 27)

	var_13_4:setPosition(var_13_3:getContentSize().width / 2, var_13_3:getContentSize().height / 2 + 5)
	var_13_3:addChild(var_13_4)

	local var_13_5 = cc.Label:createWithTTF(var_13_0, FONT_NAME, 25)

	var_13_5:setPosition(360, 202)
	var_13_2:addChild(var_13_5)
	var_13_5:setColor(cc.c3b(220, 50, 58))
	var_13_5:setAnchorPoint(0, 0)

	local var_13_6 = cc.Label:createWithTTF(var_13_1, FONT_NAME, 25)

	var_13_6:setPosition(360, 152)
	var_13_2:addChild(var_13_6)
	var_13_6:setColor(cc.c3b(220, 50, 58))
	var_13_6:setAnchorPoint(0, 0)
	table.insert(self.listcells, var_13_2)
end

function NewSchoolDeanOfficeLayer:initHelpBattle()
	var_0_2:setParam({
		configType = CONFIG_TYPE_HANGUP,
		mode = playermodel.curMode
	})

	local var_15_0 = ccui.ImageView:create(var_0_23 .. "helpBattle_bg.png", var_0_25)

	self.additionListView:pushBackCustomItem(var_15_0)

	local var_15_1 = ccui.Button:create(var_0_23 .. "go_btn.png", nil, var_0_23 .. "go_btn.png", var_0_25)

	var_15_0:addChild(var_15_1, 2)
	var_15_1:setAnchorPoint(0, 0)
	var_15_1:setPosition(310, 35)
	var_15_1:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("HelpBattleLayer", {
			formationIndex = 1,
			configType = CONFIG_TYPE_HANGUP
		})
	end)

	local var_15_2 = cc.Label:createWithTTF("前往助战", FONT_BUTTON, 27)

	var_15_2:setPosition(var_15_1:getContentSize().width / 2, var_15_1:getContentSize().height / 2 + 5)
	var_15_1:addChild(var_15_2)

	for iter_15_0 = 1, 3 do
		for iter_15_1 = 1, 2 do
			local var_15_3 = (iter_15_0 - 1) * 2 + iter_15_1
			local var_15_4 = var_0_2:getBonus(var_0_8[(iter_15_0 - 1) * 2 + iter_15_1])
			local var_15_5 = TempWidget:CreateTempLabel("+" .. var_15_4.value.hp, FONT_NAME, 14, var_15_0)

			var_15_5:_setColor("DC323A")
			var_15_5:align(cc.p(0, 0), iter_15_1 == 1 and 255 or 390, 263 - iter_15_0 * 43)

			local var_15_6 = TempWidget:CreateTempLabel("+" .. var_15_4.value.damage, FONT_NAME, 14, var_15_0)

			var_15_6:_setColor("DC323A")
			var_15_6:align(cc.p(0, 0), iter_15_1 == 1 and 255 or 390, 280 - iter_15_0 * 43)

			self["helpBattle" .. var_15_3] = {
				hpText = var_15_5,
				atkText = var_15_6
			}
		end
	end

	table.insert(self.listcells, var_15_0)
end

local function var_0_26(arg_17_0)
	local var_17_0 = var_0_3:getCourseDatasByType(arg_17_0, true)
	local var_17_1 = {}
	local var_17_2 = #var_17_0

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		if not iter_17_1.root.unlock then
			var_17_2 = iter_17_0 - 1

			break
		end

		if iter_17_1.root.courses[iter_17_1.root.courseLevel] then
			table.insert(var_17_1, iter_17_1.root.courses[iter_17_1.root.courseLevel].refBuff)
		end

		if iter_17_1.root.courseLevel < #iter_17_1.root.courses then
			var_17_2 = iter_17_0

			break
		end
	end

	return var_17_2, #var_17_0, var_17_1
end

function NewSchoolDeanOfficeLayer:initBasicCourse()
	local var_18_1, var_18_2, var_18_3 = var_0_26(var_0_7.BASE)
	local buff_data = require("data.buff_data")
	local status_data = require("data.status_data")
	local var_18_6 = 0

	for iter_18_0, iter_18_1 in ipairs(var_18_3) do
		if status_data[buff_data[iter_18_1].status_add1].status_type == HP_ADD then
			var_18_6 = var_18_6 + status_data[buff_data[iter_18_1].status_add1].value1
		end
	end

	local var_18_7 = ccui.ImageView:create(var_0_23 .. "basicCourse_bg.png", var_0_25)

	self.additionListView:pushBackCustomItem(var_18_7)

	local var_18_8 = ccui.Button:create(var_0_23 .. "go_btn.png", nil, var_0_23 .. "go_btn.png", var_0_25)

	var_18_7:addChild(var_18_8, 2)
	var_18_8:setAnchorPoint(0, 0)
	var_18_8:setPosition(310, 35)
	var_18_8:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("CourseCultivateLayer", {
			returnLayer = "NewSchoolDeanOfficeLayer",
			courseType = var_0_7.BASE
		})
	end)

	local var_18_9 = cc.Label:createWithTTF("前往学习", FONT_BUTTON, 27)

	var_18_9:setPosition(var_18_8:getContentSize().width / 2, var_18_8:getContentSize().height / 2 + 5)
	var_18_8:addChild(var_18_9)

	local var_18_10 = cc.Label:createWithTTF(var_18_1 .. "/" .. var_18_2, FONT_NAME, 25)

	var_18_10:setPosition(355, 204)
	var_18_7:addChild(var_18_10)
	var_18_10:setColor(cc.c3b(220, 50, 58))
	var_18_10:setAnchorPoint(0, 0)

	local var_18_11 = cc.Label:createWithTTF(var_18_6, FONT_NAME, 25)

	var_18_11:setPosition(355, 157)
	var_18_7:addChild(var_18_11)
	var_18_11:setColor(cc.c3b(220, 50, 58))
	var_18_11:setAnchorPoint(0, 0)
	table.insert(self.listcells, var_18_7)
end

function NewSchoolDeanOfficeLayer:initElementCourse()
	local var_20_0 = 0
	local var_20_1 = 0

	for iter_20_0, iter_20_1 in pairs(var_0_7) do
		if iter_20_1 ~= var_0_7.BASE then
			local var_20_2, var_20_3 = var_0_26(iter_20_1)

			var_20_1 = var_20_1 + var_20_2
			var_20_0 = var_20_0 + var_20_3
		end
	end

	local var_20_4 = ccui.ImageView:create(var_0_23 .. "elementCourse_bg.png", var_0_25)

	self.additionListView:pushBackCustomItem(var_20_4)

	local var_20_5 = ccui.Button:create(var_0_23 .. "go_btn.png", nil, var_0_23 .. "go_btn.png", var_0_25)

	var_20_4:addChild(var_20_5, 2)
	var_20_5:setAnchorPoint(0, 0)
	var_20_5:setPosition(310, 35)
	var_20_5:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("CourseCultivateLayer", {
			returnLayer = "NewSchoolDeanOfficeLayer",
			courseType = var_0_7.DEVIL
		})
	end)

	local var_20_6 = cc.Label:createWithTTF("前往学习", FONT_BUTTON, 27)

	var_20_6:setPosition(var_20_5:getContentSize().width / 2, var_20_5:getContentSize().height / 2 + 5)
	var_20_5:addChild(var_20_6)

	local var_20_7 = cc.Label:createWithTTF(var_20_1 .. "/" .. var_20_0, FONT_NAME, 25)

	var_20_7:setPosition(355, 200)
	var_20_4:addChild(var_20_7)
	var_20_7:setColor(cc.c3b(220, 50, 58))
	var_20_7:setAnchorPoint(0, 0)
	table.insert(self.listcells, var_20_4)
end

function NewSchoolDeanOfficeLayer:initBond()
	local var_22_0 = bond_manager:getBondInfo()
	local var_22_1 = 0

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		if iter_22_1.curLevel > 0 then
			var_22_1 = var_22_1 + 1
		end
	end

	local var_22_2 = ccui.ImageView:create(var_0_23 .. "bond_bg.png", var_0_25)

	self.additionListView:pushBackCustomItem(var_22_2)

	local var_22_3 = ccui.Button:create(var_0_23 .. "go_btn.png", nil, var_0_23 .. "go_btn.png", var_0_25)

	var_22_2:addChild(var_22_3, 2)
	var_22_3:setAnchorPoint(0, 0)
	var_22_3:setPosition(310, 35)
	var_22_3:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("BondLayer")
	end)

	local var_22_4 = cc.Label:createWithTTF("前往提升", FONT_BUTTON, 27)

	var_22_4:setPosition(var_22_3:getContentSize().width / 2, var_22_3:getContentSize().height / 2 + 5)
	var_22_3:addChild(var_22_4)

	local var_22_5 = cc.Label:createWithTTF(var_22_1 .. "/" .. #var_22_0, FONT_NAME, 25)

	var_22_5:setPosition(355, 210)
	var_22_2:addChild(var_22_5)
	var_22_5:setColor(cc.c3b(220, 50, 58))
	var_22_5:setAnchorPoint(0, 0)

	self.bond_progress_label = var_22_5

	table.insert(self.listcells, var_22_2)
end

function NewSchoolDeanOfficeLayer:updateUI()
	for iter_24_0, iter_24_1 in ipairs(var_0_8) do
		local var_24_0 = var_0_2:getBonus(var_0_8[iter_24_0])

		self["helpBattle" .. iter_24_0].hpText:setString("+" .. var_24_0.value.hp)
		self["helpBattle" .. iter_24_0].atkText:setString("+" .. var_24_0.value.damage)
	end

	local var_24_1 = bond_manager:getBondInfo()
	local var_24_2 = 0

	for iter_24_2, iter_24_3 in ipairs(var_24_1) do
		if iter_24_3.curLevel > 0 then
			var_24_2 = var_24_2 + 1
		end
	end

	self.bond_progress_label:setString(var_24_2 .. "/" .. #var_24_1)
end

function NewSchoolDeanOfficeLayer:createAni()
	for iter_25_0, iter_25_1 in ipairs(self.listcells) do
		var_0_24(iter_25_1, 0.1, 0.1 + 0.1)
	end
end
