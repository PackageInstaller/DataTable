LevelResultLayer = class("LevelResultLayer", function()
	return cc.Layer:create()
end)

local playermodel = require("model.playermodel")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local major_factor_data = require("data.major_factor_data")
local drop_data = require("data.drop_data")
local servant_data = require("data.servant_data")
local recommend_team_data = require("data.recommend_team_data")
local role_conversation_data = require("data.role_conversation_data")
local conversation_class_data = require("data.conversation_class_data")
local npc_fightconfig_data = require("data.npc_fightconfig_data")
local audio_manager = require("controller.audio_manager")
local array_manager = require("controller.array_manager")
local level_manager = require("controller.level_manager")
local weapon_manager = require("controller.weapon_manager")
local component_manager = require("controller.component_manager")
local horcrux_manager = require("controller.horcrux_manager")
local core_manager = require("controller.core_manager")
local item_manager = require("controller.item_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local explore_manager = require("controller.explore_manager")
local hexie_manager = require("controller.hexie_manager")
local var_0_21 = 2
local var_0_22 = 7
local var_0_23 = 9
local var_0_24 = config._DEBUG and 0 or 1
local var_0_25 = "role/"

local function var_0_31(arg_2_0)
	return model_data[arg_2_0].levelresult_scale or 0.8
end

local function var_0_32()
	require("controller.texture_manager"):loadPopLayerTextures({
		"LevelResultLayer",
		"ChapterSettlement"
	})
end

local var_0_33

function LevelResultLayer.create(arg_4_0, arg_4_1)
	if LayerManager:getCurrentLayerName() ~= "FightLayer" and LayerManager:getCurrentLayerName() ~= "PopChatInterfaceLayer" then
		return
	end

	var_0_32()

	local var_4_0 = LevelResultLayer.new()

	var_4_0:init(arg_4_1)
	cc.Director:getInstance():getRunningScene():addChild(var_4_0, 999)
end

function LevelResultLayer:init(arg_5_1)
	local var_5_0 = ccui.Layout:create()

	var_5_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_5_0:setName("fullScreenMask")
	var_5_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_5_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_5_0:setBackGroundColorOpacity(160)
	var_5_0:setPosition(0, 0)
	var_5_0:setTouchEnabled(true)
	var_5_0:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_6_0:setTouchEnabled(false)
		self.rootLayer:stopAllActions()
		self:runAction(cc.RemoveSelf:create())

		if arg_5_1.surecallback then
			arg_5_1.surecallback = nil
			arg_5_1.cancelcallback = nil

			arg_5_1.surecallback()
		end

		if arg_5_1.packs_buy_callback then
			arg_5_1.packs_buy_callback()
		end
	end)
	self:addChild(var_5_0)

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "LevelResultLayer.json" or "LevelResultLayer.ExportJson")

	self.rootLayer:setPosition(GameDisplay.fix_x, GameDisplay.fix_y)
	self.rootLayer:setBackGroundColorOpacity(0)
	self:addChild(self.rootLayer)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_gotoStrengthenBg"):setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Image_gotoStrengthenBg"):getPositionY() - GameDisplay.fix_y)

	var_0_33 = self

	self.rootLayer:setOpacity(0)
	self.rootLayer:runAction(cc.FadeIn:create(0.5))

	self.roleImg = ccui.Helper:seekWidgetByName(self.rootLayer, "image_system_figure")

	self.roleImg:loadTexture("role/broken_21204.png")
	self.roleImg:setOpacity(255)

	self.labels = {}

	self:initFailMsg(arg_5_1)
	self:initStarsBnt(arg_5_1)
	audio_manager:playeffectMusicTest("sound/lose")

	self.btnStatistics = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_fight_statistics")

	if arg_5_1.createPopLayerCallBack then
		self.btnStatistics:setVisible(true)

		local var_5_1 = {}
		local var_5_2 = FightManager.getPlayerConf()

		while 1 ~= FORMATION_SHOW_GIRL_NUM + 1 do
			if var_5_2[1] then
				var_5_1[#var_5_1 + 1] = {}
				var_5_1[#var_5_1].model = global_get_servant_skin(var_5_2[1].modelid)
			end
		end

		local var_5_4, var_5_5 = self:get_chapterlevel(arg_5_1.fightlevel)
		local var_5_6 = fight_capacity_manager:getBossOrEnemyInfo(arg_5_1.fightdifficulty, var_5_4)
		local var_5_7 = {}

		if var_5_6.boss then
			if #var_5_6.boss == 0 then
				var_5_7[#var_5_7 + 1] = {}
				var_5_7[#var_5_7].model = var_5_6.boss.modelid
			else
				for iter_5_0 = 1, #var_5_6.boss do
					var_5_7[#var_5_7 + 1] = {}
					var_5_7[#var_5_7].model = var_5_6.boss[iter_5_0].modelid
				end
			end
		end

		if var_5_6.monster then
			for iter_5_1 = 1, #var_5_6.monster do
				var_5_7[#var_5_7 + 1] = {}
				var_5_7[#var_5_7].model = var_5_6.monster[iter_5_1].modelid
			end
		end

		local function var_5_8()
			self:setVisible(true)
			self.btnStatistics:setTouchEnabled(true)
		end

		local var_5_9

		if arg_5_1.fightData then
			var_5_9 = arg_5_1.fightData
		end

		local var_5_10 = {
			enemyName = "AI",
			oldRank = 0,
			RankIsVisable = true,
			enemyRank = 0,
			playerName = playermodel.nickname,
			playerArray = var_5_1,
			enemyArray = var_5_7
		}

		self.btnStatistics:addTouchEventListener(function(arg_8_0, arg_8_1)
			if arg_8_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.btnStatistics:setTouchEnabled(false)
			self:setVisible(false)
			LayerManager:pushInLayer("PvpResultLayer", {
				fightResult = "fail",
				fightData = var_5_9,
				fighttime = arg_5_1.fighttime,
				rankChange = var_5_10,
				cancelCallback = var_5_8
			})
		end)
	else
		self.btnStatistics:setVisible(false)
	end

	self.rootLayer:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_9_0:setTouchEnabled(false)
		self.rootLayer:stopAllActions()
		self:runAction(cc.RemoveSelf:create())

		if arg_5_1.surecallback then
			arg_5_1.surecallback = nil
			arg_5_1.cancelcallback = nil

			arg_5_1.surecallback()
		end

		if arg_5_1.packs_buy_callback then
			arg_5_1.packs_buy_callback()
		end
	end)
	self:registerScriptHandler(function(arg_10_0)
		if arg_10_0 == "exit" then
			KeyCodeManager:setKeyCodeEventlock(false)
			require("controller.autopop_manager"):resumeAchievementPop()

			var_0_33 = nil
		end
	end)
end

function LevelResultLayer.get_chapterlevel(arg_11_0, arg_11_1)
	local var_11_0, var_11_1 = arg_11_1:match("(%d+)-(%d+)")

	return tonumber(var_11_0), tonumber(var_11_1)
end

function LevelResultLayer:initFailMsg(arg_12_1)
	local var_12_0 = {
		{
			jumpId = 300,
			strengType = "SoulLvStrength",
			UIName = "Button_servantStreng"
		},
		{
			jumpId = 520,
			strengType = "strengHorcrux",
			UIName = "Button_horcruxStreng"
		},
		{
			jumpId = 300,
			strengType = "strengWeapon",
			UIName = "Button_weapon"
		},
		{
			jumpId = 300,
			strengType = "strengComponent",
			UIName = "Button_component"
		},
		{
			jumpId = 220,
			hasPing = true,
			strengType = "hasQuickFightTicket",
			UIName = "Button_quickFight"
		}
	}

	if (function()
		if arg_12_1.showtype ~= var_0_22 and arg_12_1.showtype ~= var_0_23 then
			return true
		end

		return false
	end)() then
		cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("main_line_auto_fight")))
		RoleDefault:getInstance():setBoolForKey("MainLineAutoFight", false)

		for iter_12_0, iter_12_1 in pairs(var_12_0) do
			local var_12_1 = ccui.Helper:seekWidgetByName(self.rootLayer, iter_12_1.UIName)

			local function var_12_2(arg_14_0)
				if not var_0_33 then
					return
				end

				AlertManager:add_alert_by_config(var_12_1, arg_14_0 ~= nil, {
					ALERT_SHOW_REDDOT,
					"",
					cc.p(var_12_1:getContentSize().width - 10, var_12_1:getContentSize().height - 10)
				})
				var_12_1:addTouchEventListener(function(arg_15_0, arg_15_1)
					if arg_15_1 ~= ccui.TouchEventType.ended then
						return
					end

					arg_15_0:setTouchEnabled(false)
					self:runAction(cc.RemoveSelf:create())
					AnalyticManager.fightfailTip(iter_12_1.jumpId)

					if arg_12_1.showtype == var_0_22 then
						if arg_12_1.cancelcallback then
							arg_12_1.surecallback = nil
							arg_12_1.cancelcallback = nil

							arg_12_1.cancelcallback()
						end
					elseif arg_12_1.showtype == var_0_21 then
						if arg_12_1.cancelcallback then
							arg_12_1.surecallback = nil
							arg_12_1.cancelcallback = nil

							arg_12_1.cancelcallback()
						end

						self:gotoStrengLayer(iter_12_1.strengType, arg_14_0)
					else
						self:gotoStrengLayer(iter_12_1.strengType, arg_14_0)
					end
				end)
			end

			if iter_12_1.hasPing then
				self:isStrengServant(iter_12_1.strengType, function(arg_16_0)
					var_12_2(arg_16_0)
				end)
			else
				var_12_2((self:isStrengServant(iter_12_1.strengType)))
			end
		end
	else
		for iter_12_2, iter_12_3 in pairs(var_12_0) do
			ccui.Helper:seekWidgetByName(self.rootLayer, iter_12_3.UIName):setVisible(false)
		end

		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_gotoStrengthenBg"):setVisible(false)
	end

	local var_12_4 = arg_12_1.curarray and next(arg_12_1.curarray) ~= nil and arg_12_1.curarray or playermodel.curSoul
	local var_12_5

	if arg_12_1.showtype == var_0_23 then
		var_12_5 = arg_12_1.modelid
	else
		local var_12_6 = {}

		for iter_12_4, iter_12_5 in pairs(var_12_4) do
			if iter_12_5.fight_girl and iter_12_5.classtype == 1 then
				table.insert(var_12_6, iter_12_5)
			end
		end

		if #var_12_6 == 0 then
			if var_12_4[1].fight_girl and var_12_4[1].classtype == 2 then
				var_12_5 = arg_12_1.showtype == var_0_22 and global_get_servant_skin(var_12_4[1].fight_girl, (explore_manager:getCurArraySkin(var_12_4[1]))) or global_get_servant_skin(var_12_4[1].fight_girl)
			end
		else
			local var_12_7 = math.random(#var_12_6)

			var_12_5 = arg_12_1.showtype == var_0_22 and global_get_servant_skin(var_12_6[var_12_7].fight_girl, (explore_manager:getCurArraySkin(var_12_6[var_12_7]))) or global_get_servant_skin(var_12_6[var_12_7].fight_girl)
		end
	end

	local var_12_8 = cc.p(420, 210)

	var_12_8.x = var_12_8.x + (model_data[var_12_5].levelresult_offset_x or 0)
	var_12_8.y = var_12_8.y + (model_data[var_12_5].levelresult_offset_y or 0)

	if model_data[var_12_5].is_big_role_image == 1 then
		var_12_8.x = 320
		var_12_8.y = -104
	end

	self.roleImg:setPosition(var_12_8)

	local var_12_9

	if arg_12_1.showtype == var_0_23 then
		var_12_9 = var_0_25 .. model_data[var_12_5].role_image .. ".png"
	else
		var_12_9 = hexie_manager:canShowBroken() and var_0_25 .. model_data[var_12_5].broken_role .. ".png" or var_0_25 .. model_data[var_12_5].role_image .. ".png"

		GlobalPlayRoleSound(var_12_5, ROLE_SOUND_TYPE.lose)
	end

	self.roleImg:loadTexture(var_12_9)
	self.roleImg:setScale((var_0_31(var_12_5)))

	if arg_12_1.data and next(arg_12_1.data) and arg_12_1.data.scoreinfinite and arg_12_1.data.scoreinfinite >= 0 then
		local var_12_10 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_gotoStrengthenBg")

		var_12_10:setVisible(false)

		local var_12_11 = ccui.ImageView:create("ChapterSettlement/infinite_scorebg.png", var_0_24)

		var_12_11:setAnchorPoint(cc.p(0.5, 0.5))
		var_12_11:setPosition(cc.p(var_12_10:getPositionX(), var_12_10:getPositionY()))
		self.rootLayer:addChild(var_12_11, 99)

		local var_12_12 = cc.Label:createWithTTF("", "fonts/name.ttf", 50)

		var_12_12:setAnchorPoint(cc.p(0, 0))
		var_12_12:enableOutline(cc.c4b(0, 0, 0, 255), 1)
		var_12_11:addChild(var_12_12, 1000)
		require("controller.l2utils"):numberlabelRandomAction(var_12_12, "" .. math.ceil(arg_12_1.data.scoreinfinite), 2, "linear", 20)
		var_12_12:setPosition(cc.p(var_12_11:getContentSize().width / 2 - 120, var_12_11:getContentSize().height / 2 - 34))

		local var_12_13 = level_manager:getinfiniteScoreInfo(playermodel.curMode)

		if var_12_13 and var_12_13 < arg_12_1.data.scoreinfinite then
			local var_12_14 = ccui.ImageView:create("ChapterSettlement/infinite_newflag.png", var_0_24)

			var_12_14:setAnchorPoint(cc.p(0, 0))
			var_12_14:setPosition(cc.p(var_12_12:getPositionX() + var_12_12:getContentSize().width, var_12_12:getPositionY() + var_12_12:getContentSize().height - 10))
			var_12_11:addChild(var_12_14)
		end
	end
end

function LevelResultLayer.isStrengServant(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = {
		SoulLvStrength = function()
			local var_18_0

			for iter_18_0, iter_18_1 in pairs((array_manager:getBattleArrayData((array_manager:getLevelArray())))) do
				if iter_18_1.fight_girl then
					if core_manager:StrengthenJudge(iter_18_1.fight_girl) == 1 and core_manager:getCoreLv(iter_18_1.fight_girl) < playermodel.grade then
						var_18_0 = iter_18_1.fight_girl

						break
					end

					if core_manager:StrengthenJudge(iter_18_1.fight_girl) == 2 and core_manager:check_upgrade_conditions(iter_18_1.fight_girl) then
						var_18_0 = iter_18_1.fight_girl

						break
					end
				end
			end

			return var_18_0
		end,
		strengComponent = function()
			local var_19_0

			for iter_19_0, iter_19_1 in pairs((array_manager:getBattleArrayData((array_manager:getLevelArray())))) do
				if iter_19_1.fight_girl then
					while 1 <= 3 do
						if component_manager:checkIsCanReplaceBetter(iter_19_1.fight_girl, 1) then
							var_19_0 = iter_19_1.fight_girl

							break
						end
					end

					if var_19_0 then
						break
					end

					if component_manager:isBecomeStronger(iter_19_1.fight_girl) then
						var_19_0 = iter_19_1.fight_girl

						break
					end
				end
			end

			return var_19_0
		end,
		strengWeapon = function()
			local var_20_0

			for iter_20_0, iter_20_1 in pairs((array_manager:getBattleArrayData((array_manager:getLevelArray())))) do
				if iter_20_1.fight_girl and weapon_manager:checkIsCanReplaceBetter(iter_20_1.fight_girl) then
					var_20_0 = iter_20_1.fight_girl

					break
				end

				if iter_20_1.fight_girl and weapon_manager:isTipsStrengWeapon(iter_20_1.fight_girl) then
					var_20_0 = iter_20_1.fight_girl

					break
				end
			end

			return var_20_0
		end,
		strengHorcrux = function()
			local var_21_0

			for iter_21_0, iter_21_1 in pairs((array_manager:getBattleArrayData((array_manager:getLevelArray())))) do
				if iter_21_1.fight_girl and iter_21_1.assist_girl and horcrux_manager:isUpLevelToNext(iter_21_1.assist_girl) then
					var_21_0 = iter_21_1.assist_girl

					break
				end
			end

			return var_21_0
		end,
		hasQuickFightTicket = function(arg_22_0)
			level_manager:getCurQuickFightTime(function(arg_23_0)
				if arg_23_0 < QUICK_FIGHT_DAILY_TIME and item_manager:getItemNumber(9999999) > 0 then
					if arg_22_0 then
						arg_22_0(true)
					end
				elseif arg_22_0 then
					arg_22_0()
				end
			end)
		end
	}

	if var_17_0[arg_17_1] then
		if arg_17_2 then
			var_17_0[arg_17_1](arg_17_2)
		else
			return var_17_0[arg_17_1]()
		end
	end
end

function LevelResultLayer.gotoStrengLayer(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = {
		SoulLvStrength = function()
			LayerManager:pushInLayer("SoulStrengthLayer", {
				goto_back_system_id = 201
			})
		end,
		strengComponent = function()
			LayerManager:switchShowLayer("EquipLayer", {
				bottomBtnState = 1,
				cursoul = arg_24_2
			})
		end,
		strengWeapon = function()
			LayerManager:switchShowLayer("EquipLayer", {
				bottomBtnState = 1,
				cursoul = arg_24_2
			})
		end,
		strengHorcrux = function()
			LayerManager:switchShowLayer("HorcruxLayer")
		end,
		hasQuickFightTicket = function()
			LayerManager:pushInLayer("FightResultLayerNew", {
				createItemType = "itemid",
				items = playermodel.dropcache,
				surecallback = function()
					if FightLayer and FightLayer.getInstance() then
						ccui.Helper:seekWidgetByName(FightLayer.getInstance().rootLayer, "dropcache"):checkPlayerDropCache()
						AnalyticManager.collectDropcache()
					end
				end,
				cancelcallback = function()
					return
				end
			})
		end
	}

	if var_24_0[arg_24_1] then
		var_24_0[arg_24_1]()
		AnalyticManager.clickFightFailBtn({
			clickexit = arg_24_1
		})
	end
end

function LevelResultLayer:initStarsBnt(arg_32_1)
	if arg_32_1.showtype ~= var_0_21 then
		return
	end

	if not level_manager:isMainChapterOrFeederChapter(playermodel.curMode) then
		return
	end

	if level_manager:isTalkLevel(playermodel.curMode) then
		return
	end

	local var_32_0 = ccui.Button:create("public/button/public_button_red.png", nil, "public/button/public_button_red.png", config._DEBUG and 0 or 1)

	self.rootLayer:addChild(var_32_0, 9)

	local var_32_1 = cc.Label:createWithTTF(L_FIGHT_AGAIN, FONT_NAME, 30)

	var_32_1:setPosition(var_32_0:getContentSize().width / 2, var_32_0:getContentSize().height / 2 + 3)
	var_32_0:addChild(var_32_1)
	var_32_0:setPosition(180, 180 - GameDisplay.fix_y)
	var_32_0:addTouchEventListener(function(arg_33_0, arg_33_1)
		if arg_33_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_33_0:isBright() then
			return
		end

		arg_33_0:setBright(false)
		self.rootLayer:stopAllActions()
		self:runAction(cc.RemoveSelf:create())
		require("controller.parse_server"):onFightBigBoss(playermodel.curMode, level_manager:getCurChapter(playermodel.curMode), array_manager.last_refight_array)

		if arg_32_1.cancelcallback then
			arg_32_1.surecallback = nil
			arg_32_1.cancelcallback = nil

			arg_32_1.cancelcallback(1)
		end
	end)

	local var_32_2 = ccui.Button:create("public/button/public_button_blue.png", nil, "public/button/public_button_blue.png", config._DEBUG and 0 or 1)

	self.rootLayer:addChild(var_32_2, 9)

	local var_32_3 = cc.Label:createWithTTF(L_EXPLORE_TASK.Sure_Btn, FONT_NAME, 30)

	var_32_3:setColor(cc.c3b(0, 0, 0))
	var_32_3:setPosition(var_32_2:getContentSize().width / 2, var_32_2:getContentSize().height / 2 + 3)
	var_32_2:addChild(var_32_3)
	var_32_2:setPosition(460, 180 - GameDisplay.fix_y)
	var_32_2:addTouchEventListener(function(arg_34_0, arg_34_1)
		if arg_34_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_34_0:isBright() then
			return
		end

		arg_34_0:setBright(false)
		self.rootLayer:stopAllActions()
		self:runAction(cc.RemoveSelf:create())

		if arg_32_1.cancelcallback then
			arg_32_1.surecallback = nil
			arg_32_1.cancelcallback = nil

			arg_32_1.cancelcallback()
		end

		if arg_32_1.packs_buy_callback then
			arg_32_1.packs_buy_callback()
		end
	end)
end
