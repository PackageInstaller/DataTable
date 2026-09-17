DropPreviewLayer = class("DropPreviewLayer", function()
	return cc.Layer:create()
end)

local playermodel = require("model.playermodel")
local major_factor_data = require("data.major_factor_data")
local model_data = require("data.model_data")
local drop_data = require("data.drop_data")
local item_data = require("data.item_data")
local monster_manager = require("controller.monster_manager")
local level_manager = require("controller.level_manager")
local model_manager = require("controller.model_manager")
local item_manager = require("controller.item_manager")
local component_manager = require("controller.component_manager")
local drop_manager = require("controller.drop_manager")
local explore_manager = require("controller.explore_manager")
local total_skill_data = require("data.total_skill_data")

require("view.Sprite.ItemSprite")
require("data.language_constants")

function DropPreviewLayer.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = DropPreviewLayer.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)

	return var_2_0
end

function DropPreviewLayer:init(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Confirm_fight.json" or "Confirm_fight.ExportJson")

	self:addChild(self.rootlayer)

	self.fighttype = arg_3_1

	local var_3_0, var_3_1 = arg_3_2:match("(%d+)-(%d+)")

	self.curLevel = arg_3_2
	self.mode = tonumber(var_3_0)
	self.level = tonumber(var_3_1)
	self.confirmPanel = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_confirm_fight")

	self.confirmPanel:setTouchEnabled(true)
	self.confirmPanel:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)

	self.panelawards = ccui.Helper:seekWidgetByName(self.confirmPanel, "Panel_awards")
	self.playerPanel = ccui.Helper:seekWidgetByName(self.confirmPanel, "info_bg_zhujue")
	self.enemyPanel = ccui.Helper:seekWidgetByName(self.confirmPanel, "info_bg_boss")
	self.box = ccui.Helper:seekWidgetByName(self.confirmPanel, "bg")

	self:intiBossTeam()
	self:initTextInfo()

	if arg_3_1 == FIGHTTYPE_NORMAL then
		if self.level == playermodel.levelmode[self.mode].level then
			ccui.Helper:seekWidgetByName(self.confirmPanel, "image_fight_finish"):setVisible(false)
		else
			ccui.Helper:seekWidgetByName(self.confirmPanel, "image_fight_finish"):setVisible(true)
		end
	elseif arg_3_1 == FIGHTTYPE_ADVENTURE or arg_3_1 == FIGHTTYPE_ADVENTURE_TOWER then
		if arg_3_4 then
			ccui.Helper:seekWidgetByName(self.confirmPanel, "image_fight_finish"):setVisible(true)
		else
			ccui.Helper:seekWidgetByName(self.confirmPanel, "image_fight_finish"):setVisible(false)
		end
	elseif arg_3_1 == FIGHTTYPE_EXPLORE then
		ccui.Helper:seekWidgetByName(self.confirmPanel, "image_fight_finish"):setVisible(false)
	end

	self.confirmPanel:getChildByName("title"):setString(level_manager.getCurLevelData(self.mode, self.level).name)
	self:initDropList(arg_3_4)
	self:initConfirmButton(arg_3_3, arg_3_4, arg_3_5)
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" and self.enemy then
			self.enemy:release()

			self.enemy = nil
		end
	end)
end

function DropPreviewLayer:exit(arg_6_1)
	self:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		if arg_6_1 then
			arg_6_1()
		end
	end), cc.RemoveSelf:create()))
end

function DropPreviewLayer:intiBossTeam()
	local var_8_0 = level_manager.getCurLevelData(self.mode, self.level)

	self.curEnemies = monster_manager.initBossList(var_8_0.boss_team)
	self.zhenrong = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_confirm_fight"):getChildByName("zhenrong")

	for iter_8_0, iter_8_1 in pairs(self.curEnemies) do
		ccui.Helper:seekWidgetByName(self.zhenrong, "player" .. 1):setVisible(true)
		ccui.Helper:seekWidgetByName(self.zhenrong, "player" .. 1):loadTexture("role1/" .. model_data[iter_8_1.majorlist.modelid].cute_role .. ".png")
	end

	local var_8_2 = ""
	local var_8_3 = ""
	local var_8_4 = ""

	if var_8_0.combat_attack_limit ~= nil then
		var_8_2 = var_8_2 .. L_SCIENCE_NAME.ATTACK
		var_8_3 = var_8_3 .. var_8_0.combat_attack_limit
		var_8_4 = "/"
	end

	if var_8_0.combat_hp_limit ~= nil then
		var_8_2 = var_8_2 .. var_8_4 .. L_SCIENCE_NAME.HP
		var_8_3 = var_8_3 .. var_8_4 .. var_8_0.combat_hp_limit
		var_8_4 = "/"
	end

	if var_8_0.combat_xp_limit ~= nil then
		var_8_2 = var_8_2 .. var_8_4 .. L_SCIENCE_NAME.XP
		var_8_3 = var_8_3 .. var_8_4 .. var_8_0.combat_xp_limit
	end

	local var_8_5 = cc.Label:createWithTTF(string.format(L_DROP_PREVIEW_TEXT.Suggest_str, var_8_2, var_8_3), "fonts/W5.ttf", 20)

	var_8_5:setAnchorPoint(cc.p(0.5, 0.5))
	var_8_5:setPosition(cc.p(self.zhenrong:getContentSize().width / 2, -5))
	self.zhenrong:addChild(var_8_5, 1)
end

function DropPreviewLayer:initTextInfo()
	local var_9_3 = {}

	for iter_9_0, iter_9_1 in pairs(self.curEnemies) do
		local var_9_4 = {}

		while iter_9_1.majorlist["horcruxskill_" .. 1] do
			var_9_4[#var_9_4 + 1] = total_skill_data[iter_9_1.majorlist["horcruxskill_" .. 1]].name
		end

		var_9_3[#var_9_3 + 1] = var_9_4
	end

	for iter_9_2, iter_9_3 in pairs(var_9_3) do
		for iter_9_4, iter_9_5 in ipairs(iter_9_3) do
			local var_9_6 = ccui.Helper:seekWidgetByName(self.zhenrong, "player" .. iter_9_2)

			if var_9_6 then
				local var_9_7 = cc.Label:createWithTTF(iter_9_5, "fonts/new.ttf", 28)

				var_9_7:setAnchorPoint(cc.p(0.5, 0.5))

				local var_9_9 = 380

				if iter_9_4 >= 3 then
					var_9_9 = var_9_9 + var_9_7:getContentSize().height + 30
				end

				var_9_7:setPosition(cc.p(iter_9_4 % 2 == 0 and var_9_6:getChildByName(iter_9_4 - 1):getStringLength() * 58 * 1.7 or 50, var_9_9))
				var_9_7:setScale(1.7)
				var_9_7:setName(iter_9_4)
				var_9_6:addChild(var_9_7)
			end
		end
	end
end

function DropPreviewLayer:initDropList(arg_10_1)
	if self.fighttype == FIGHTTYPE_NORMAL then
		self.panelawards:getChildByName("label_awards"):setString(L_DROP_PREVIEW_TEXT.Drop_List_Label.FIGHTTYPE_NORMAL[1])
		self.panelawards:getChildByName("label_dropoff"):setString(L_DROP_PREVIEW_TEXT.Drop_List_Label.FIGHTTYPE_NORMAL[2])
	elseif self.fighttype == FIGHTTYPE_ADVENTURE or self.fighttype == FIGHTTYPE_ADVENTURE_TOWER then
		self.panelawards:getChildByName("label_awards"):setString(L_DROP_PREVIEW_TEXT.Drop_List_Label.FIGHTTYPE_ADVENTURE[1])

		if self.mode == MODE_ADVENTURE_JIN and not arg_10_1 then
			self.panelawards:getChildByName("tittle"):setString(L_DROP_PREVIEW_TEXT.Drop_List_Label.FIGHTTYPE_ADVENTURE[2])
		elseif math.floor(self.mode / 10) == ADVENTURE_TYPE_TRAINING then
			self.panelawards:getChildByName("label_dropoff"):setString(L_DROP_PREVIEW_TEXT.Drop_List_Label.FIGHTTYPE_ADVENTURE[3])
		else
			self.panelawards:getChildByName("label_dropoff"):setString(L_DROP_PREVIEW_TEXT.Drop_List_Label.FIGHTTYPE_ADVENTURE[4])
		end
	end

	local var_10_0 = drop_data[level_manager.getCurLevelData(self.mode, self.level).equip_drop]

	self.panelawards:getChildByName("diamond"):setVisible(false)
	self.panelawards:getChildByName("diaNum"):setVisible(false)

	if var_10_0.gold and var_10_0.gold > 0 then
		self.panelawards:getChildByName("label_awards"):setVisible(true)
		self.panelawards:getChildByName("gold_image"):setVisible(true)
		self.panelawards:getChildByName("gold_number"):setVisible(true)
		self.panelawards:getChildByName("gold_number"):setString(var_10_0.gold)
	else
		self.panelawards:getChildByName("label_awards"):setVisible(false)
		self.panelawards:getChildByName("gold_image"):setVisible(false)
		self.panelawards:getChildByName("gold_number"):setVisible(false)
	end

	local var_10_1 = ccui.ScrollView:create()

	var_10_1:setDirection(ccui.ScrollViewDir.horizontal)
	var_10_1:setContentSize(cc.size(550, 130))
	var_10_1:setInnerContainerSize(cc.size(550, 130))
	var_10_1:setPosition(cc.p(100, -10))
	self.panelawards:addChild(var_10_1, 10)

	local var_10_2 = 1
	local var_10_3 = 0

	while var_10_0["drop_id" .. var_10_2] do
		if var_10_0["drop_num" .. var_10_2] > 0 and var_10_0["drop_rate" .. var_10_2] > 0 then
			local var_10_4 = ItemSprite:createWithItemId(var_10_0["drop_id" .. var_10_2], var_10_0["drop_num" .. var_10_2], true)

			var_10_4:setPosition(cc.p(60 + 110 * var_10_3, 80))
			var_10_4:setScale(0.9)
			var_10_1:addChild(var_10_4, 2)

			var_10_3 = var_10_3 + 1
		end

		var_10_2 = var_10_2 + 1
	end

	local var_10_5 = 1

	while var_10_0["rd_drop_id" .. var_10_5] do
		if var_10_0["rd_drop_num" .. var_10_5] > 0 and var_10_0["rd_drop_weight" .. var_10_5] > 0 then
			local var_10_6 = ItemSprite:createWithItemId(var_10_0["rd_drop_id" .. var_10_5], var_10_0["rd_drop_num" .. var_10_5], true)

			var_10_6:setPosition(cc.p(60 + 110 * var_10_3, 80))
			var_10_6:setScale(0.9)
			var_10_1:addChild(var_10_6, 2)

			var_10_3 = var_10_3 + 1
		end

		var_10_5 = var_10_5 + 1
	end

	local var_10_7 = 1
	local var_10_8 = 0

	while var_10_0["dropmodel_id" .. var_10_7] do
		if var_10_0["dropmodel_num" .. var_10_7] > 0 and var_10_0["dropmodel_rate" .. var_10_7] > 0 then
			local var_10_9 = drop_manager:getEquipAllDrops(var_10_0["dropmodel_id" .. var_10_7])

			for iter_10_0, iter_10_1 in ipairs(var_10_9) do
				local var_10_10 = ItemSprite:createWithItemId(iter_10_1.dropid, iter_10_1.dropNum, true)

				var_10_10:setPosition(cc.p(60 + 110 * (iter_10_0 + var_10_8 - 1), 80))
				var_10_10:setScale(0.9)
				var_10_1:addChild(var_10_10, 2)
			end

			var_10_8 = var_10_8 + #var_10_9
		end

		var_10_7 = var_10_7 + 1
	end

	local var_10_11 = 1
	local var_10_12 = 0

	while var_10_0["rd_dropmodel_id" .. var_10_11] do
		if var_10_0["rd_dropmodel_num" .. var_10_11] > 0 and var_10_0["rd_dropmodel_rate" .. var_10_11] > 0 then
			local var_10_13 = drop_manager:getEquipAllDrops(var_10_0["rd_dropmodel_id" .. var_10_11])

			for iter_10_2, iter_10_3 in ipairs(var_10_13) do
				local var_10_14 = ItemSprite:createWithItemId(iter_10_3.dropid, iter_10_3.dropNum, true)

				var_10_14:setPosition(cc.p(60 + 110 * (iter_10_2 + var_10_12 - 1), 80))
				var_10_14:setScale(0.9)
				var_10_1:addChild(var_10_14, 2)
			end

			var_10_12 = var_10_12 + #var_10_13
		end

		var_10_11 = var_10_11 + 1
	end

	if var_10_12 >= 6 then
		var_10_1:setInnerContainerSize(cc.size(110 * (var_10_12 + 1), 105))
	end
end

function DropPreviewLayer:initConfirmButton(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = self.confirmPanel:getChildByName("button_sure")

	if arg_11_1 then
		var_11_0:setVisible(true)

		if var_11_0:getChildByName("Label_75") then
			var_11_0:getChildByName("Label_75"):setVisible(false)
		end

		var_11_0:addTouchEventListener(function(arg_12_0, arg_12_1)
			if arg_12_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.fighttype == FIGHTTYPE_ADVENTURE or self.fighttype == FIGHTTYPE_ADVENTURE_TOWER then
				local var_12_0 = {}

				var_12_0.initindex = adventureManager.curArray or 1
				var_12_0.configtype = CONFIG_TYPE_MODE
				var_12_0.configcallback = arg_11_3
				var_12_0.mode = self.mode

				self:addChild(require("view.Layer.Formation.FormationModeLayer"):create(var_12_0))
			elseif self.fighttype == FIGHTTYPE_EXPLORE then
				local var_12_1 = {}

				var_12_1.initindex = explore_manager.curArray or 1
				var_12_1.configtype = CONFIG_TYPE_EXPLORE
				var_12_1.configcallback = arg_11_3

				self:addChild(require("view.Layer.Formation.FormationExploreLayer"):create(var_12_1))
			elseif self.fighttype == FIGHTTYPE_NORMAL then
				self:exit()
				arg_11_3()
			end
		end)

		if self.fighttype == FIGHTTYPE_NORMAL then
			local var_11_1 = cc.Label:createWithTTF(L_DROP_PREVIEW_CONFIRM_LABEL.Boss, "fonts/W5.ttf", 36)

			var_11_1:enableOutline(cc.c4b(184, 76, 56, 255), 2)
			var_11_1:setAnchorPoint(cc.p(0.5, 0.5))
			var_11_1:setPosition(cc.p(var_11_0:getContentSize().width / 2, var_11_0:getContentSize().height / 2 + 10))
			var_11_0:addChild(var_11_1, 1)
		elseif self.fighttype == FIGHTTYPE_ADVENTURE or self.fighttype == FIGHTTYPE_ADVENTURE_TOWER then
			if math.floor(self.mode / 10) == ADVENTURE_TYPE_NORMAL then
				if arg_11_2 then
					local var_11_2 = item_manager:getItemNumber(levelData[self.mode .. "-" .. self.level].fight_ticket)
					local var_11_3 = cc.Label:createWithTTF(L_DROP_PREVIEW_CONFIRM_LABEL.Sweep, "fonts/W5.ttf", 36)

					var_11_3:enableOutline(cc.c4b(184, 76, 56, 255), 2)
					var_11_3:setAnchorPoint(cc.p(0.5, 0.5))
					var_11_3:setPosition(cc.p(var_11_0:getContentSize().width / 2, var_11_0:getContentSize().height / 2 + 10))
					var_11_0:addChild(var_11_3, 2)
				else
					local var_11_4 = cc.Label:createWithTTF(L_DROP_PREVIEW_CONFIRM_LABEL.Boss, "fonts/W5.ttf", 36)

					var_11_4:enableOutline(cc.c4b(184, 76, 56, 255), 2)
					var_11_4:setAnchorPoint(cc.p(0.5, 0.5))
					var_11_4:setPosition(cc.p(var_11_0:getContentSize().width / 2, var_11_0:getContentSize().height / 2 + 10))
					var_11_0:addChild(var_11_4, 1)
				end
			else
				if arg_11_2 then
					local var_11_5 = cc.Label:createWithTTF(L_DROP_PREVIEW_CONFIRM_LABEL.Sweep, "fonts/W5.ttf", 36)

					var_11_5:enableOutline(cc.c4b(184, 76, 56, 255), 2)
					var_11_5:setAnchorPoint(cc.p(0.5, 0.5))
					var_11_5:setPosition(cc.p(var_11_0:getContentSize().width / 2, var_11_0:getContentSize().height / 2 + 10))
					var_11_0:addChild(var_11_5, 1)
				else
					local var_11_6 = cc.Label:createWithTTF(L_DROP_PREVIEW_CONFIRM_LABEL.Boss, "fonts/W5.ttf", 36)

					var_11_6:enableOutline(cc.c4b(184, 76, 56, 255), 2)
					var_11_6:setAnchorPoint(cc.p(0.5, 0.5))
					var_11_6:setPosition(cc.p(var_11_0:getContentSize().width / 2, var_11_0:getContentSize().height / 2 + 10))
					var_11_0:addChild(var_11_6, 1)
				end

				if TrainingLayer and TrainingLayer.getInstance() then
					local var_11_7 = cc.Label:createWithTTF("", "fonts/new1.ttf", 24)

					var_11_7:setString(string.format(L_DROP_PREVIEW_CONFIRM_LABEL.Rest_Time, TrainingLayer.getInstance():getTraintimes()))
					var_11_7:setColor(cc.c3b(238, 118, 36))
					var_11_7:setAnchorPoint(cc.p(0.5, 0.5))
					var_11_7:setPosition(cc.p(var_11_0:getContentSize().width / 2, var_11_0:getContentSize().height + 20))
					var_11_0:addChild(var_11_7, 2)
				end
			end
		elseif self.fighttype == FIGHTTYPE_EXPLORE then
			local var_11_8 = cc.Label:createWithTTF(L_DROP_PREVIEW_CONFIRM_LABEL.Adventure, "fonts/W5.ttf", 36)

			var_11_8:enableOutline(cc.c4b(184, 76, 56, 255), 2)
			var_11_8:setAnchorPoint(cc.p(0.5, 0.5))
			var_11_8:setPosition(cc.p(var_11_0:getContentSize().width / 2, var_11_0:getContentSize().height / 2 + 10))
			var_11_0:addChild(var_11_8, 1)
		end
	else
		var_11_0:setVisible(false)
	end
end
