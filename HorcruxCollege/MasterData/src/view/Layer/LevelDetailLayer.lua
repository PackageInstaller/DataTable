LevelDetailLayer = class("LevelDetailLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local l2utils = require("controller.l2utils")
local var_0_2 = require("controller.servant_rank_manager").getInstance()
local var_0_3 = var_0_2.FIGHT_TYPE
local var_0_4 = var_0_2.RANK_TYPE
local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local monster_manager = require("controller.monster_manager")
local explore_manager = require("controller.explore_manager")
local horcrux_manager = require("controller.horcrux_manager")
local model_data = require("data.model_data")
local total_skill_data = require("data.total_skill_data")
local chapter_data = require("data.chapter_data")
local chapter_star_data = require("data.chapter_star_data")
local drop_data = require("data.drop_data")
local tower_defence_manager = require("controller.tower_defence_manager")
local Utility = require("common.Utility")
local levelmode_data = require("data.levelmode_data")
local item_data = require("data.item_data")
local audio_manager = require("controller.audio_manager")
local photo_manager = require("controller.photo_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local array_manager = require("controller.array_manager")
local var_0_23 = require("data.total_skill_data")
local account_manager = require("controller.account_manager")
local var_0_25 = require("controller.level_manager")
local var_0_26 = {
	FREE = 1,
	FORBID = 2,
	LOCKING = 3
}

local function var_0_27(arg_2_0)
	local var_2_0, var_2_1 = arg_2_0:match("(%d+)-(%d+)")

	return tonumber(var_2_0), tonumber(var_2_1)
end

local function var_0_28(arg_3_0)
	return global_get_model_attr(arg_3_0)
end

local function var_0_29(arg_4_0)
	local var_4_0 = {}

	var_4_0.name = model_data[arg_4_0.modelid].main_name or model_data[arg_4_0.modelid].name
	var_4_0.icon = model_data[arg_4_0.modelid].cute_role
	var_4_0.quality = model_data[arg_4_0.modelid].monster_level
	var_4_0.level = arg_4_0.level or "?"
	var_4_0.modelid = arg_4_0.modelid
	var_4_0.id = arg_4_0.id
	var_4_0.attr = var_0_28(arg_4_0.modelid)

	local var_4_1 = horcrux_manager:getMonsterHorcruxAssistConfig(arg_4_0)

	var_4_0.affix = {}

	if var_4_1 then
		for iter_4_0, iter_4_1 in ipairs(var_4_1.skills) do
			var_4_0.affix[iter_4_0] = {
				id = iter_4_1,
				name = total_skill_data[iter_4_1].name,
				des = string.format("%s。", total_skill_data[iter_4_1].description),
				icon = total_skill_data[iter_4_1].icon
			}
		end
	end

	return var_4_0
end

local function var_0_30(arg_5_0)
	local var_5_0 = global_get_model_attr(arg_5_0)

	if not var_5_0 then
		return
	end

	return CAREER_ICON[model_data[arg_5_0].career .. "_" .. var_5_0]
end

function LevelDetailLayer:fullScreen()
	self.rootlayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.rootlayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))

	for iter_6_0, iter_6_1 in pairs({}) do
		local var_6_0 = self.rootlayer:getChildByName(iter_6_1)

		var_6_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, var_6_0:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

		var_6_0:setPositionY(var_6_0.full_posY)
	end

	for iter_6_2, iter_6_3 in pairs({
		"boss",
		"element",
		"btn_horcrux",
		"element_title",
		"map_name",
		"level_name",
		"word",
		"target",
		"enemy"
	}) do
		local var_6_1 = self.rootlayer:getChildByName(iter_6_3)

		var_6_1.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - var_6_1:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

		var_6_1:setPositionY(var_6_1.full_posY)
	end
end

function LevelDetailLayer.create(arg_7_0, arg_7_1)
	local var_7_0 = LevelDetailLayer.new()

	if arg_7_1.mode ~= 104 or arg_7_1.fight_type == "EXPLORE" then
		var_7_0:initBg(arg_7_1)
	elseif arg_7_1.callback then
		arg_7_1.callback()
	end

	return var_7_0
end

function LevelDetailLayer:init(arg_8_1)
	print(dump(arg_8_1))

	self.initconfig = arg_8_1 or {}
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "LevelDetailLayer.json" or "LevelDetailLayer.ExportJson")

	self:addChild(self.rootlayer)

	self.bgNode = self.rootlayer:getChildByName("bg")

	self.bgNode:setTouchEnabled(true)

	self.bossPanelNode = self.rootlayer:getChildByName("boss")

	self.bossPanelNode:getChildByName("mask"):setPositionY(420)

	self.btn_skill_detail = self.bossPanelNode:getChildByName("btn_skill_detail")
	self.btn_back = self.rootlayer:getChildByName("btn_back")
	self.btn_team = self.rootlayer:getChildByName("btn_team")
	self.btn_fight = self.rootlayer:getChildByName("btn_fight")
	self.btn_horcrux = self.rootlayer:getChildByName("btn_horcrux")
	self.elementTitleNode = self.rootlayer:getChildByName("element_title")
	self.mapNameNode = self.rootlayer:getChildByName("map_name")
	self.levelNameNode = self.rootlayer:getChildByName("level_name")
	self.mapNameNode = self.rootlayer:getChildByName("map_name")
	self.wordPanelNode = self.rootlayer:getChildByName("word")
	self.targetPanelNode = self.rootlayer:getChildByName("target")
	self.fightPowerPanelNode = self.rootlayer:getChildByName("fight_power")
	self.dropPanelNode = self.rootlayer:getChildByName("drop")
	self.enemyPanelNode = self.rootlayer:getChildByName("enemy")

	self.enemyPanelNode:setTouchEnabled(false)
	self.enemyPanelNode:setVisible(true)

	self.bloodPanelNode = self.bossPanelNode:getChildByName("blood")
	self.btn_reloadtalk = ccui.Button:create("public/button/btn_reloadtalk.png", "public/button/btn_reloadtalk.png", "public/button/btn_reloadtalk,png", var_0_0)

	self.rootlayer:addChild(self.btn_reloadtalk)
	self.btn_reloadtalk:setName("btn_reloadtalk")
	self.btn_reloadtalk:setPosition(555, 123)

	if self.initconfig and self.initconfig.can_reload_talklayer then
		self.btn_reloadtalk:setVisible(true)
		self.btn_reloadtalk:addTouchEventListener(function(arg_9_0, arg_9_1)
			if arg_9_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.initconfig.reload_talklayer_func()
		end)
	else
		self.btn_reloadtalk:setVisible(false)
	end

	self.rootlayer:getChildByName("element_title"):setVisible(false)
	self.rootlayer:setTouchEnabled(true)
	self.rootlayer:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)
	self.btn_back:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)
	self.btn_team:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:onBtnTeamCallback()
	end)
	self.btn_fight:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:onBtnFightCallback()
	end)
	self.btn_horcrux:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.initconfig.fight_type ~= "EXPLORE" then
			LayerManager:switchShowLayer("ServantRankLayer", {
				fightType = self.fightType,
				rankType = self.rankType,
				mode = self.mode,
				chapter = self.chapter
			})
		end
	end)
	self.btn_skill_detail:addTouchEventListener(function(arg_15_0, arg_15_1)
		local var_15_0

		if arg_15_1 ~= ccui.TouchEventType.ended then
			do return end

			var_15_0 = {
				id = model_data[self.levelInfo.enemyInfo[self.levelInfo.selectEnemyIndex].modelid].photofile_model
			}
		end

		var_15_0.modelid = self.levelInfo.enemyInfo[self.levelInfo.selectEnemyIndex].modelid
		var_15_0.contentType = {
			contentType = photo_manager:getFileType(model_data[self.levelInfo.enemyInfo[self.levelInfo.selectEnemyIndex].modelid].photofile_type)
		}

		if photo_manager:isBigPicture(model_data[self.levelInfo.enemyInfo[self.levelInfo.selectEnemyIndex].modelid].photofile_type) then
			LayerManager:pushInLayer("PhotoFileRoleFileLayer", var_15_0)
		else
			LayerManager:pushInLayer("PhotoFileHelpGirlLayer", var_15_0)
		end
	end)
	self:initInfo()
	self:initPanel()
	self:fullScreen()
	self:checkAutoFight()
	self:checkWeeklyAutoFight()
	self:runAction((cc.CallFunc:create(function()
		self.rootlayer:setScale(1, 0)
		self.rootlayer:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1), cc.CallFunc:create(function()
			self:updateGuidesOnLayer()
		end)))
	end)))
	self:registerScriptHandler(function(arg_18_0)
		if arg_18_0 == "exit" then
			l2utils:removeNodeShake(self.curbossNode)

			if self.callback then
				self.callback()
			end
		end
	end)
end

local function var_0_31(arg_19_0)
	print(arg_19_0, "aaaaa")

	return ({
		[542] = true,
		[572] = true,
		[522] = true,
		[582] = true,
		[1042] = true,
		[532] = true,
		[562] = true,
		[1041] = true,
		[1043] = true,
		[501] = true,
		[552] = true,
		[512] = true
	})[arg_19_0]
end

function LevelDetailLayer:initAutoFight()
	if self.initconfig.fight_type ~= "MAIN" then
		return
	end

	local var_20_0 = ccui.ImageView:create("LevelDetailLayer/auto_fight_bg.png", var_0_0)

	self.rootlayer:addChild(var_20_0)
	var_20_0:setPosition(568, 270 + 2 * GameDisplay.fix_y)
	var_20_0:setScale(1.2, 1.2)

	local var_20_1 = ccui.Button:create("LevelDetailLayer/auto_fight_choose.png", nil, "LevelDetailLayer/auto_fight_choose.png", var_0_0)

	var_20_0:addChild(var_20_1)
	var_20_1:setPosition(var_20_0:getContentSize().width - var_20_1:getContentSize().width / 2 - 5, var_20_1:getContentSize().height / 2 + 5)
	var_20_1:setScale(1.2, 1.2)

	local var_20_2 = ccui.ImageView:create("LevelDetailLayer/auto_fight_on.png", var_0_0)

	var_20_1:addChild(var_20_2)
	var_20_2:setPosition(15, 15)
	var_20_2:setScale(1.2, 1.2)

	self.autoFight = RoleDefault:getInstance():getBoolForKey("MainLineAutoFight", false)

	var_20_2:setVisible(self.autoFight)
	var_20_1:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.autoFight = not self.autoFight

		var_20_2:setVisible(self.autoFight)
		RoleDefault:getInstance():setBoolForKey("MainLineAutoFight", self.autoFight)
	end)

	if self.autoFight and self.initconfig.fight_type == "MAIN" then
		global_count_down_layer(4, function()
			self:onBtnFightCallback()
		end, function()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("main_line_auto_fight")))
			RoleDefault:getInstance():setBoolForKey("MainLineAutoFight", false)
		end)
	end

	if not var_0_25:isPlayerPassLevel(UNLOCK_FIGHT_AUTO) then
		var_20_2:setVisible(false)
		var_20_0:setVisible(false)
		var_20_1:setVisible(false)
	end

	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("main_line_auto_fight", function(arg_24_0)
		self.autoFight = false

		var_20_2:setVisible(self.autoFight)
	end), self)
end

function LevelDetailLayer:checkAutoFight()
	if not var_0_31(self.mode) then
		return
	end

	if not (self.initconfig.fight_type == "ADVENTURE" and self.adventuresure ~= nil or self.initconfig.fight_type ~= "ADVENTURE") then
		return
	end

	if self.initconfig.fight_type ~= "ADVENTURE" then
		return
	end

	if RoleDefault:getInstance():getBoolForKey("AdventureTowerAutoFight", false) then
		global_count_down_layer(4, function()
			self:onBtnFightCallback()
		end, function()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("adv_tower_auto_fight")))
			RoleDefault:getInstance():setBoolForKey("AdventureTowerAutoFight", false)
		end)
	end
end

function LevelDetailLayer:checkWeeklyAutoFight()
	if require("controller.weekly_tower_manager").getInstance():isWeeklyTowerModetpye(levelmode_data[self.mode].modetype) == false then
		return
	end

	if self.initconfig.fight_type ~= "ADVENTURE" then
		return
	end

	if RoleDefault:getInstance():getBoolForKey("WeeklyAutoFight", false) then
		global_count_down_layer(4, function()
			self:onBtnFightCallback()
		end, function()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("set_weekly_autofight_false")))
			RoleDefault:getInstance():setBoolForKey("WeeklyAutoFight", false)
		end)
	end
end

function LevelDetailLayer:onBtnTeamCallback()
	if self.initconfig.teamCallback ~= null then
		self.initconfig.teamCallback()
	else
		self:onBtnFightCallback(true)
	end
end

function LevelDetailLayer:onBtnFightCallback(arg_32_1)
	if self.isUmaru ~= true or self.initconfig.curChapterStatus == var_0_26.FREE then
		local var_32_0 = self.initconfig.callback

		self:exit()

		if self.initconfig.fight_type == "ADVENTURE" or self.initconfig.fight_type == "SUBSTITUTION" or self.initconfig.fight_type == "TOWERDEFENCE" or self.initconfig.fight_type == "WORLDBOSS" then
			if var_32_0 then
				self.initconfig.callback(self.arrayID)
			end

			if self.adventuresure then
				self.adventuresure()
			end
		elseif var_32_0 then
			if arg_32_1 then
				self.initconfig.callback(false)
			else
				self.initconfig.callback(true)
			end
		end
	elseif self.initconfig.curChapterStatus == var_0_26.LOCKING then
		global_ShowBlockWords(L_MAP_CITY_CHAPTERS.Locking)
		audio_manager:playeffectMusicTest("sound/invalid")
	elseif self.initconfig.curChapterStatus == var_0_26.FORBID then
		global_ShowBlockWords(L_MAP_CITY_CHAPTERS.Forbid)
		audio_manager:playeffectMusicTest("sound/invalid")
	end
end

function LevelDetailLayer:exit()
	if self.initconfig and self.initconfig.cancelcallback then
		self.initconfig.cancelcallback()
	end

	LayerManager:removePopLayer()
end

function LevelDetailLayer.updateGuidesOnLayer(arg_34_0)
	GuideListener.cleanCurGuides()
	GuideListener.lockGuideTrigger(false)
	GuideListener.updateGuides(arg_34_0)
end

function LevelDetailLayer:initInfo()
	self.arrayID = self.initconfig.initindex or 1
	self.adventuresure = self.initconfig.adventuresurecallback
	self.isUmaru = self.initconfig.isUmaru
	self.rankType = var_0_4.NORMAL
	self.mode = 0
	self.chapter = 0
	self.level = 0
	self.fightType = var_0_3.PVE
	self.levelInfo = {}
	self.levelInfo.mapname = "测试地图"
	self.levelInfo.levelname = "测试关卡"
	self.levelInfo.starInfo = {}
	self.levelInfo.bossInfo = {
		careerPath = "",
		name = "",
		levelStr = "",
		bossPath = "",
		bossBgPath = ""
	}
	self.levelInfo.fightPowerNum = 60
	self.levelInfo.dropTitlePath = "LevelDetailLayer/drop_title1.png"
	self.levelInfo.dropInfo = {}

	local var_35_0
	local var_35_1 = cc.c3b(255, 255, 255)
	local var_35_3

	if self.initconfig.fight_type == "ADVENTURE" then
		self.mode = self.initconfig.mode
		self.chapter = self.initconfig.chapter
		self.level = self.initconfig.level
		self.callback = self.initconfig.callback
		var_35_0 = chapter_data[self.mode .. "-" .. self.chapter] and chapter_data[self.mode .. "-" .. self.chapter].combat_limit and chapter_data[self.mode .. "-" .. self.chapter].combat_limit or var_35_0
		var_35_3 = fight_capacity_manager:getArrayFightCapacity(array_manager:getBattleArrayData(self.arrayID), nil, nil, FIGHTTYPE_ADVENTURE, self.mode)
	elseif self.initconfig.fight_type == "SUBSTITUTION" then
		self.chapter = self.initconfig.chapter
		self.level = self.initconfig.level
		self.mode = self.initconfig.mode
		self.callback = self.initconfig.callback
		var_35_0 = chapter_data[self.mode .. "-" .. self.chapter] and chapter_data[self.mode .. "-" .. self.chapter].combat_limit and chapter_data[self.mode .. "-" .. self.chapter].combat_limit or var_35_0
		var_35_3 = fight_capacity_manager:getArrayFightCapacity(array_manager:getBattleArrayData(self.arrayID), nil, nil, FIGHTTYPE_SUBSTITUTION, self.mode)
	elseif self.initconfig.fight_type == "TOWERDEFENCE" then
		self.chapter = self.initconfig.chapter
		self.level = self.initconfig.level
		self.mode = self.initconfig.mode
		self.callback = self.initconfig.callback
		var_35_0 = chapter_data[self.mode .. "-" .. self.chapter] and chapter_data[self.mode .. "-" .. self.chapter].boss_combat and chapter_data[self.mode .. "-" .. self.chapter].boss_combat or var_35_0
		var_35_3 = fight_capacity_manager:getArrayFightCapacity(array_manager:getBattleArrayData(self.arrayID), nil, nil, FIGHTTYPE_TOWER, self.mode)
	elseif self.initconfig.fight_type == "EXPLORE" then
		self.chapter, self.level = var_0_27(self.initconfig.level)
		self.mode = self.initconfig.mode or playermodel.curMode
		self.uniqueMonsterId = self.initconfig.uniqueMonsterId
		self.levelInfo.dropTitlePath = "LevelDetailLayer/drop_title2.png"
		var_35_3 = explore_manager:getCurFightCapacity()
	elseif self.initconfig.fight_type == "REFIGHT" then
		self.mode = self.initconfig.mode
		self.chapter, self.level = var_0_27(self.initconfig.level)
		var_35_0 = chapter_data[self.mode .. "-" .. self.chapter] and chapter_data[self.mode .. "-" .. self.chapter].boss_combat and chapter_data[self.mode .. "-" .. self.chapter].boss_combat or var_35_0
		var_35_3 = fight_capacity_manager:getArrayFightCapacity(array_manager:getBattleArrayData(self.arrayID), nil, nil, nil, self.mode)
	elseif self.initconfig.fight_type == "WORLDBOSS" then
		self.chapter = self.initconfig.chapter
		self.level = self.initconfig.level
		self.mode = self.initconfig.mode
		self.callback = self.initconfig.callback
		var_35_0 = chapter_data[self.mode .. "-" .. self.chapter] and chapter_data[self.mode .. "-" .. self.chapter].combat_limit and chapter_data[self.mode .. "-" .. self.chapter].combat_limit or var_35_0
		var_35_3 = fight_capacity_manager:getArrayFightCapacity(array_manager:getBattleArrayData(self.arrayID), nil, nil, FIGHTTYPE_ADVENTURE, self.mode)
	else
		self.mode = playermodel.curMode
		self.chapter, self.level = var_0_27(playermodel.curLevel)
		var_35_0 = chapter_data[self.mode .. "-" .. self.chapter] and chapter_data[self.mode .. "-" .. self.chapter].boss_combat and chapter_data[self.mode .. "-" .. self.chapter].boss_combat or var_35_0
		var_35_3 = fight_capacity_manager:getArrayFightCapacity(array_manager:getBattleArrayData(self.arrayID), nil, nil, nil, self.mode)
	end

	self.levelInfo.mapname = self.initconfig.fight_type ~= "EXPLORE" and level_manager:getModeName(self.mode) or ""
	self.levelInfo.levelname = self.initconfig.fight_type ~= "EXPLORE" and level_manager:getChapterName(self.mode, self.chapter) or ""

	local var_35_6 = self:GetBossOrEnemyInfo()

	if self.initconfig.fight_type == "MAIN" or self.initconfig.fight_type == "REFIGHT" or self.initconfig.fight_type == "ADVENTURE" and levelmode_data[self.mode].is_check_stars then
		local var_35_7 = level_manager:getChapterStarsState(self.mode, self.chapter)
		local var_35_8 = self.initconfig.fight_type == "MAIN" or self.initconfig.fight_type == "REFIGHT"

		if chapter_star_data[self.mode .. "-" .. self.chapter] then
			for iter_35_0 = 1, 3 do
				local var_35_10 = {}

				var_35_10.ishave = var_35_7[iter_35_0] or false
				var_35_10.des = chapter_star_data[self.mode .. "-" .. self.chapter]["star" .. iter_35_0 .. "_des"] or ""
				var_35_10.isshowdiamond = var_35_8
				self.levelInfo.starInfo[iter_35_0] = var_35_10
			end
		end
	end

	local var_35_11 = self.initconfig and self.initconfig.drops

	if var_35_11 == nil or next(var_35_11) == nil then
		var_35_11 = self:getDropData()
	end

	if var_35_11.items == nil then
		var_35_11.items = {}
	end

	for iter_35_1, iter_35_2 in pairs(var_35_11) do
		if type(iter_35_1) == "number" then
			table.insert(var_35_11.items, {
				num = iter_35_2.num,
				itemid = iter_35_2.itemid
			})
		end
	end

	if var_35_11.gold and var_35_11.gold > 0 then
		table.insert(var_35_11.items, {
			itemid = "gold",
			num = var_35_11.gold
		})

		var_35_11.gold = nil
	end

	if var_35_11.diamond and var_35_11.diamond > 0 then
		table.insert(var_35_11.items, {
			itemid = "diamond",
			num = var_35_11.diamond
		})

		var_35_11.diamond = nil
	end

	self.levelInfo.dropInfo = var_35_11.items

	if var_35_6.monster == nil then
		var_35_6.monster = {}
	end

	if var_35_6.boss then
		table.insert(var_35_6.monster, 1, var_35_6.boss)

		var_35_6.boss = nil
	end

	self.levelInfo.enemyInfo = var_35_6.monster

	if var_35_0 == nil then
		var_35_0 = 0

		for iter_35_3, iter_35_4 in pairs(self.levelInfo.enemyInfo) do
			var_35_0 = var_35_0 + (self.initconfig.fight_type == "EXPLORE" and fight_capacity_manager:getExploreEnemyFightCapacity(self.mode, iter_35_4.id) or self.initconfig.fight_type == "TOWERDEFENCE" and (iter_35_4.fightpower or 99) or fight_capacity_manager:getEnemyFightCapacity(self.mode, iter_35_4.id))
		end
	end

	self.levelInfo.fightPowerNum = var_35_0
	self.levelInfo.fightPowerStrColor = var_35_3 and var_35_0 <= var_35_3 and cc.c3b(0, 255, 0) or var_35_3 and var_35_3 < var_35_0 and cc.c3b(255, 0, 0) or cc.c3b(255, 255, 255)
	self.levelInfo.selectEnemyIndex = 1
end

function LevelDetailLayer:getDropData()
	local var_36_2 = {
		gold = 0,
		diamond = 0,
		items = {}
	}
	local var_36_3 = drop_data[self.initconfig.fight_type == "EXPLORE" and explore_manager.getCurData("level", self.mode)[self.chapter .. "-" .. self.level].equip_drop or level_manager:isMainChapterOrFeederChapter(self.mode) and ((account_manager:getChannel() == "270056" or account_manager:getChannel() == "palmpi") and (playermodel.create_time < os.time({
		hour = 0,
		month = 3,
		year = 2022,
		min = 0,
		sec = 0,
		day = 4
	}) and (chapter_data[self.mode .. "-" .. self.chapter].bigbossdrop_old or chapter_data[self.mode .. "-" .. self.chapter].bigbossdrop) or chapter_data[self.mode .. "-" .. self.chapter].bigbossdrop) or playermodel.create_time < os.time({
		hour = 0,
		month = 3,
		year = 2022,
		min = 0,
		sec = 0,
		day = 25
	}) and (chapter_data[self.mode .. "-" .. self.chapter].bigbossdrop_old or chapter_data[self.mode .. "-" .. self.chapter].bigbossdrop) or chapter_data[self.mode .. "-" .. self.chapter].bigbossdrop) or level_manager.loadLevelData(self.mode)[self.mode .. "-" .. self.chapter .. "-" .. self.level].equip_drop] or {}

	if var_36_3.gold then
		var_36_2.gold = var_36_2.gold + var_36_3.gold
	end

	if var_36_3.diamond then
		var_36_2.diamond = var_36_2.diamond + var_36_3.diamond
	end

	local var_36_4 = 1

	if var_36_3["drop_id" .. 1] then
		local var_36_5 = 1

		while var_36_3["drop_id" .. var_36_5] do
			var_36_2.items[var_36_4] = {
				itemid = var_36_3["drop_id" .. var_36_5],
				num = var_36_3["drop_num" .. var_36_5]
			}
			var_36_5 = var_36_5 + 1
			var_36_4 = var_36_4 + 1
		end
	end

	if var_36_3["dropmodel_id" .. 1] then
		local var_36_6 = 1

		while var_36_3["dropmodel_id" .. var_36_6] do
			if drop_data[var_36_3["dropmodel_id" .. var_36_6]].gold then
				var_36_2.gold = var_36_2.gold + drop_data[var_36_3["dropmodel_id" .. var_36_6]].gold
			end

			if drop_data[var_36_3["dropmodel_id" .. var_36_6]].diamond then
				var_36_2.diamond = var_36_2.diamond + drop_data[var_36_3["dropmodel_id" .. var_36_6]].diamond
			end

			if drop_data[var_36_3["dropmodel_id" .. var_36_6]]["drop_id" .. 1] then
				local var_36_7 = 1

				while drop_data[var_36_3["dropmodel_id" .. var_36_6]]["drop_id" .. var_36_7] do
					var_36_2.items[var_36_4] = {
						itemid = drop_data[var_36_3["dropmodel_id" .. var_36_6]]["drop_id" .. var_36_7],
						num = drop_data[var_36_3["dropmodel_id" .. var_36_6]]["drop_num" .. var_36_7]
					}
					var_36_7 = var_36_7 + 1
					var_36_4 = var_36_4 + 1
				end
			end

			if drop_data[var_36_3["dropmodel_id" .. var_36_6]]["rd_drop_id" .. 1] then
				local var_36_8 = 1

				while drop_data[var_36_3["dropmodel_id" .. var_36_6]]["rd_drop_id" .. var_36_8] do
					var_36_2.items[var_36_4] = {
						itemid = drop_data[var_36_3["dropmodel_id" .. var_36_6]]["rd_drop_id" .. var_36_8],
						num = drop_data[var_36_3["dropmodel_id" .. var_36_6]]["rd_drop_num" .. var_36_8]
					}
					var_36_8 = var_36_8 + 1
					var_36_4 = var_36_4 + 1
				end
			end

			var_36_6 = var_36_6 + 1
		end
	end

	if var_36_3["rd_drop_id" .. 1] then
		local var_36_9 = 1

		while var_36_3["rd_drop_id" .. var_36_9] do
			var_36_2.items[var_36_4] = {
				itemid = var_36_3["rd_drop_id" .. var_36_9],
				num = var_36_3["rd_drop_num" .. var_36_9]
			}
			var_36_9 = var_36_9 + 1
			var_36_4 = var_36_4 + 1
		end
	end

	if var_36_3["rd_dropmodel_id" .. 1] then
		local var_36_10 = 1

		while var_36_3["rd_dropmodel_id" .. var_36_10] do
			if drop_data[var_36_3["rd_dropmodel_id" .. var_36_10]].gold then
				var_36_2.gold = var_36_2.gold + drop_data[var_36_3["rd_dropmodel_id" .. var_36_10]].gold
			end

			if drop_data[var_36_3["rd_dropmodel_id" .. var_36_10]].diamond then
				var_36_2.diamond = var_36_2.diamond + drop_data[var_36_3["rd_dropmodel_id" .. var_36_10]].diamond
			end

			if drop_data[var_36_3["rd_dropmodel_id" .. var_36_10]]["drop_id" .. 1] then
				local var_36_11 = 1

				while drop_data[var_36_3["rd_dropmodel_id" .. var_36_10]]["drop_id" .. var_36_11] do
					var_36_2.items[var_36_4] = {
						itemid = drop_data[var_36_3["rd_dropmodel_id" .. var_36_10]]["drop_id" .. var_36_11],
						num = drop_data[var_36_3["rd_dropmodel_id" .. var_36_10]]["drop_num" .. var_36_11]
					}
					var_36_11 = var_36_11 + 1
					var_36_4 = var_36_4 + 1
				end
			end

			if drop_data[var_36_3["rd_dropmodel_id" .. var_36_10]]["rd_drop_id" .. 1] then
				local var_36_12 = 1

				while drop_data[var_36_3["rd_dropmodel_id" .. var_36_10]]["rd_drop_id" .. var_36_12] do
					var_36_2.items[var_36_4] = {
						itemid = drop_data[var_36_3["rd_dropmodel_id" .. var_36_10]]["rd_drop_id" .. var_36_12],
						num = drop_data[var_36_3["rd_dropmodel_id" .. var_36_10]]["rd_drop_num" .. var_36_12]
					}
					var_36_12 = var_36_12 + 1
					var_36_4 = var_36_4 + 1
				end
			end

			var_36_10 = var_36_10 + 1
		end
	end

	return var_36_2
end

function LevelDetailLayer:GetBossOrEnemyInfo()
	local var_37_0

	print(self.initconfig.fight_type, level_manager:isMainChapterOrFeederChapter(self.mode))

	var_37_0 = self.initconfig.fight_type == "EXPLORE" and explore_manager:initBossListInfo(self.chapter .. "-" .. self.level) or level_manager:isMainChapterOrFeederChapter(self.mode) and monster_manager.getChapterBigBossAll(self.mode, self.mode .. "-" .. self.chapter) or monster_manager.getLevelBossAll(self.mode, self.chapter .. "-" .. self.level)

	print("datata")
	print(self.mode, self.chapter .. "-" .. self.level)

	local var_37_1 = {}

	if var_37_0.boss then
		var_37_1.boss = var_0_29(var_37_0.boss.majorlist)
	end

	if var_37_0.monster and next(var_37_0.monster) then
		var_37_1.monster = {}

		for iter_37_0, iter_37_1 in ipairs(var_37_0.monster) do
			table.insert(var_37_1.monster, var_0_29(iter_37_1.majorlist))
		end
	end

	if self.initconfig.fight_type == "TOWERDEFENCE" then
		var_37_1.boss = var_0_29(tower_defence_manager:getEnemyBaseConf(self.mode, self.chapter)[1].majorlist)
	end

	if var_37_1.boss then
		var_37_1.boss.isBoss = true
	end

	return var_37_1
end

function LevelDetailLayer.getAffixItemNode(arg_38_0)
	local var_38_0 = ccui.Layout:create()

	var_38_0:setContentSize(cc.size(100, 100))

	local var_38_1 = ccui.ImageView:create("")

	var_38_1:setName("icon")
	var_38_1:setAnchorPoint(cc.p(0, 0))
	var_38_1:setTouchEnabled(true)
	var_38_0:addChild(var_38_1)

	return var_38_0
end

function LevelDetailLayer:skillDesc(arg_39_1, arg_39_2)
	self.layerSkill = ccui.Layout:create()

	self.layerSkill:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.layerSkill:setBackGroundColor(cc.c3b(0, 0, 0))
	self.layerSkill:setAnchorPoint(cc.p(0, 0.5))
	self.layerSkill:setBackGroundColorOpacity(180)
	self.layerSkill:setPosition(cc.p(arg_39_2.x - 50, arg_39_2.y))
	self.layerSkill:setCascadeOpacityEnabled(false)
	self.wordPanelNode:addChild(self.layerSkill, 9999999)

	local var_39_0 = cc.Label:createWithTTF(var_0_23[arg_39_1].name, "fonts/number.ttf", 20)

	var_39_0:setColor(cc.c3b(253, 211, 81))
	var_39_0:setAnchorPoint(cc.p(0, 1))
	self.layerSkill:addChild(var_39_0, 999)

	local var_39_1 = cc.Label:createWithTTF(var_0_23[arg_39_1].description, "fonts/number.ttf", 18)

	var_39_1:setColor(cc.c3b(234, 232, 226))
	var_39_1:setAnchorPoint(cc.p(0, 1))
	var_39_1:setWidth(170)
	self.layerSkill:setContentSize(cc.size(190, var_39_1:getContentSize().height + 60))

	local var_39_2 = self.layerSkill:getContentSize().height

	var_39_0:setPosition(cc.p(10, var_39_2))
	var_39_1:setPosition(cc.p(10, var_39_2 - var_39_0:getContentSize().height))
	self.layerSkill:addChild(var_39_1, 999)

	local var_39_3 = cc.EventListenerTouchOneByOne:create()

	var_39_3:setSwallowTouches(false)
	var_39_3:registerScriptHandler(function(arg_40_0, arg_40_1)
		if self.layerSkill then
			self.layerSkill:removeFromParent()
		end

		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_39_3:registerScriptHandler(function(arg_41_0, arg_41_1)
		if self.layerSkill then
			self.layerSkill:removeFromParent()
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_39_3, self.layerSkill)
end

function LevelDetailLayer:initPanel()
	self.btn_horcrux:setVisible(self.initconfig.fight_type ~= "EXPLORE" and self.mode ~= 1 and self.initconfig.fight_type ~= "WORLDBOSS")
	self.mapNameNode:setString(self.levelInfo.mapname)
	self.levelNameNode:setString(self.levelInfo.levelname)

	if self.levelInfo.starInfo and next(self.levelInfo.starInfo) ~= nil then
		self.targetPanelNode:setVisible(true)

		for iter_42_0 = 1, 3 do
			local var_42_0 = self.levelInfo.starInfo[iter_42_0]
			local var_42_1 = self.targetPanelNode:getChildByName("star" .. iter_42_0)
			local var_42_2 = var_42_1:getChildByName("icon")
			local var_42_3 = var_42_1:getChildByName("des")

			var_42_2:loadTexture(self.levelInfo.starInfo[iter_42_0].ishave == true and "LevelDetailLayer/star_on.png" or "LevelDetailLayer/star_off.png", var_0_0)
			var_42_3:setString(var_42_0.des)

			local var_42_4 = var_42_1:getChildByName("label")

			var_42_4:setAnchorPoint(cc.p(0, 0.5))

			local var_42_5 = var_42_1:getChildByName("num")
			local var_42_6 = var_42_1:getChildByName("diamond")

			if var_42_0.ishave == true then
				var_42_4:setVisible(true)
				var_42_4:setString("达成")
				var_42_5:setVisible(false)
				var_42_6:setVisible(false)
				var_42_4:setPosition(cc.p(600, 18))
			elseif var_42_0.isshowdiamond == true then
				var_42_4:setVisible(true)
				var_42_4:setString("+")
				var_42_5:setVisible(true)
				var_42_6:setVisible(true)
				var_42_4:setPosition(cc.p(605, 18))
			else
				var_42_4:setVisible(false)
				var_42_5:setVisible(false)
				var_42_6:setVisible(false)
			end
		end
	else
		self.targetPanelNode:setVisible(false)
	end

	local var_42_7 = self.fightPowerPanelNode:getChildByName("num")

	var_42_7:setString(global_trans_number(self.levelInfo.fightPowerNum))
	var_42_7:setColor(self.levelInfo.fightPowerStrColor)

	local var_42_8 = self.btn_team:getChildByName("label")
	local var_42_9 = self:getCurTeamFightNum()

	var_42_8:setVisible(false)
	self.btn_team:getChildByName("icon"):setVisible(false)
	var_42_8:setString(global_trans_number(var_42_9))
	var_42_8:enableGlow(var_42_9 >= self.levelInfo.fightPowerNum and cc.c4b(0, 0, 255, 255) or cc.c4b(255, 0, 0, 255))
	self:initDropPanel()
	self:initEnemyPanel()
	self:initBossPanel(self.levelInfo.selectEnemyIndex)

	local var_42_10 = self.initconfig.fight_type == "ADVENTURE" and self.adventuresure ~= nil or self.initconfig.fight_type ~= "ADVENTURE"

	self.btn_fight:setVisible((self.initconfig.fight_type == "ADVENTURE" and self.adventuresure ~= nil or self.initconfig.fight_type ~= "ADVENTURE") and true or false)
	self.btn_team:setVisible(var_42_10 and self.initconfig.fight_type ~= "EXPLORE" and self.initconfig.fight_type ~= "SUBSTITUTION" and self.initconfig.fight_type ~= "WORLDBOSS")

	if self.initconfig.fight_type == "SUBSTITUTION" then
		self:addInfoButton()
	end
end

function LevelDetailLayer:addInfoButton()
	local var_43_0 = self.bgNode:getChildByName("title")
	local var_43_1 = ccui.Button:create("LevelDetailLayer/sub_detail.png", "LevelDetailLayer/sub_detail.png", "LevelDetailLayer/sub_detail.png", var_0_0)

	var_43_1:setAnchorPoint(cc.p(0, 0.5))
	var_43_1:setPosition(cc.p(var_43_0:getContentSize().width - 100, var_43_0:getContentSize().height / 2))
	var_43_0:addChild(var_43_1, 1)
	var_43_1:addTouchEventListener(function(arg_44_0, arg_44_1)
		if arg_44_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "OldSubstitute"
		})
	end)
end

function LevelDetailLayer:getCurTeamFightNum()
	local var_45_1 = playermodel.curArray or 1
	local var_45_2 = require("controller.formation.formation_main_manager"):getInstance():getFormationInfo() or {}

	return (var_45_2 and var_45_2[var_45_1] or nil) and require("controller.fight_capacity_manager"):getArrayFightCapacity(var_45_2[var_45_1], nil, nil, nil, self.mode)
end

local function var_0_32(arg_46_0)
	if not arg_46_0 or type(arg_46_0) ~= "string" then
		return nil
	end

	local var_46_0, var_46_1 = arg_46_0:match("(%d+),(%d+)")

	return cc.p(tonumber(var_46_0), tonumber(var_46_1))
end

function LevelDetailLayer:initBossPanel(arg_47_1)
	self.levelInfo.bossInfo = {}

	local var_47_0 = self.levelInfo.enemyInfo[arg_47_1]
	local var_47_1 = model_data[self.levelInfo.enemyInfo[arg_47_1].modelid]
	local var_47_2 = ""
	local var_47_3 = 1
	local var_47_4 = cc.p(-130, 280)
	local var_47_5 = false

	if model_data[self.levelInfo.enemyInfo[arg_47_1].modelid].role_image then
		var_47_2 = "roleimage/role/" .. var_47_1.role_image .. ".png"

		local var_47_6 = cc.p(450, 20)

		var_47_4 = cc.p(var_47_4.x + var_47_6.x, var_47_4.y + var_47_6.y)
	else
		var_47_2 = "roleimage/role1/" .. var_47_1.cute_role .. ".png"
		var_47_3 = var_47_1.boss_cute_preview_scale or var_47_3

		if var_47_1.bosscutepreviewpos then
			local var_47_7, var_47_8 = var_47_1.bosscutepreviewpos:match("(.+),(.+)")

			var_47_4 = cc.p(var_47_4.x + (tonumber(var_47_7) or 0) + 320, var_47_4.y + (tonumber(var_47_8) or 0) + 210)
		else
			var_47_4 = cc.p(var_47_4.x + 230, var_47_4.y + 330)
		end

		if var_47_1.bosscutepreviewflip then
			var_47_5 = var_47_1.bosscutepreviewflip < 0
		end
	end

	self.levelInfo.bossInfo.bossPath = var_47_2
	self.levelInfo.bossInfo.bossScale = var_47_3
	self.levelInfo.bossInfo.bossPos = var_47_4
	self.levelInfo.bossInfo.isFlipX = var_47_5

	if self.mode >= 1 and self.mode <= 8 then
		self.levelInfo.bossInfo.bossBgPath = "LevelDetailLayer/bg_" .. self.mode .. ".png" or "LevelDetailLayer/bg_usual.png"
	end

	self.levelInfo.bossInfo.careerPath = var_0_30(var_47_0.modelid)
	self.levelInfo.bossInfo.name = var_47_0.name
	self.levelInfo.bossInfo.levelStr = L_FAVOR_EVENT[1] .. "：" .. var_47_0.level
	self.levelInfo.bossInfo.scorePath = "LevelDetailLayer/level_" .. var_47_1.monster_level .. ".png"
	self.levelInfo.bossInfo.bossHp = self.initconfig.fight_type == "EXPLORE" and explore_manager:getHpInherit(var_47_0.modelid .. self.uniqueMonsterId) or 1

	if self.bossPanelNode:getChildByName("newboss") then
		self.bossPanelNode:getChildByName("newboss"):removeFromParent()
	end

	self.bossPanelNode:getChildByName("boss"):setVisible(false)

	local var_47_11

	if var_47_1.role_image then
		local var_47_12

		if config._DEBUG then
			var_47_12 = cc.Sprite:create("LevelDetailLayer/clip_mask.png") or cc.Sprite:createWithSpriteFrameName("LevelDetailLayer/clip_mask.png")
		end

		var_47_12:setContentSize(cc.size(640, 400))

		local var_47_13 = cc.Sprite:create(self.levelInfo.bossInfo.bossPath)
		local var_47_14 = var_0_32(var_47_1.bosspreviewpos)

		var_47_13:setPosition(cc.p(-250 + var_47_14.x, -250 + var_47_14.y))
		var_47_13:setScale(self.levelInfo.bossInfo.bossScale)

		local var_47_15 = cc.ClippingNode:create(var_47_12)

		var_47_15:setAlphaThreshold(1)
		var_47_15:setContentSize(cc.size(640, 100))
		var_47_15:setPosition(var_47_4)
		var_47_15:setAnchorPoint(cc.p(0, 1))
		var_47_15:addChild(var_47_13)
		var_47_15:setName("newboss")
		self.bossPanelNode:addChild(var_47_15, 1)

		var_47_11 = var_47_15
	else
		local var_47_16 = cc.Sprite:create(self.levelInfo.bossInfo.bossPath)

		var_47_16:setPosition(var_47_4)
		var_47_16:setAnchorPoint(cc.p(0, 1))
		var_47_16:setName("newboss")
		var_47_16:setScale(self.levelInfo.bossInfo.bossScale)
		self.bossPanelNode:addChild(var_47_16, 1)

		var_47_11 = var_47_16
	end

	self.curbossNode = var_47_11

	l2utils:shakeNode(var_47_11, {
		scanlinethreshold = 0.025,
		driftpixel = 0,
		waitframe = 0,
		shakeframe = 12,
		restoreframe = 12,
		scanlinedriftfac = 5
	})
	var_47_11:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		l2utils:removeNodeShake(var_47_11)
	end)))

	local var_47_17 = self.bossPanelNode:getChildByName("score")

	self.bossPanelNode:getChildByName("bg"):loadTexture(self.levelInfo.bossInfo.bossBgPath, var_0_0)
	print_lua_table(self.levelInfo)
	self.bossPanelNode:getChildByName("boss_name"):setString(self.levelInfo.bossInfo.name)
	self.bossPanelNode:getChildByName("career"):loadTexture(self.levelInfo.bossInfo.careerPath, var_0_0)
	self.bossPanelNode:getChildByName("level"):setString(self.levelInfo.bossInfo.levelStr)
	var_47_17:loadTexture(self.levelInfo.bossInfo.scorePath, var_0_0)
	var_47_17:setVisible(false)

	local var_47_18 = self.rootlayer:getChildByName("element")
	local var_47_19 = MAJOR_RES_TBL[global_get_model_attr(var_47_0.modelid)]
	local var_47_20 = L_SORT_ATTR[ATTR_INDEX[var_47_19]] or ""

	var_47_18:getChildByName("icon"):loadTexture("public/career_icon/" .. var_47_19 .. ".png", var_0_0)
	var_47_18:getChildByName("label"):setString(var_47_20 .. "学员有利")
	var_47_18:setVisible(false)
	self:initBossHpPanel()
	self:initAffixPanel()

	local var_47_21 = next(self.levelInfo.starInfo) ~= nil

	if var_47_21 == false and next(self.levelInfo.enemyInfo[self.levelInfo.selectEnemyIndex].affix) ~= nil == false then
		-- block empty
	end

	self.bgNode:setScale9Enabled(true)

	if var_47_21 == false then
		self.bgNode:setContentSize(cc.size(640, 852))
		self.bgNode:setPositionY(160)
		self.bgNode:getChildByName("title"):setPositionY(818)
		self.dropPanelNode:setPositionY(255)
		self.btn_back:setPositionY(220)
		self.btn_fight:setPositionY(216)
		self.btn_team:setPositionY(215)
		self.btn_reloadtalk:setPositionY(283)
	else
		self.bgNode:setContentSize(cc.size(640, 1012))
		self.bgNode:setPositionY(0)
		self.bgNode:getChildByName("title"):setPositionY(978)
		self.dropPanelNode:setPositionY(95)
		self.btn_back:setPositionY(60)
		self.btn_fight:setPositionY(56)
		self.btn_team:setPositionY(55)
		self.btn_reloadtalk:setPositionY(123)
	end

	local var_47_22 = {
		"bg",
		"btn_back",
		"btn_fight",
		"btn_team",
		"drop",
		"fight_power",
		"btn_reloadtalk"
	}

	for iter_47_0, iter_47_1 in pairs({}) do
		local var_47_23 = self.rootlayer:getChildByName(iter_47_1)

		var_47_23.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, var_47_23:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

		var_47_23:setPositionY(var_47_23.full_posY)
	end

	for iter_47_2, iter_47_3 in pairs(var_47_22) do
		local var_47_24 = self.rootlayer:getChildByName(iter_47_3)

		var_47_24.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - var_47_24:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

		var_47_24:setPositionY(var_47_24.full_posY)
	end
end

function LevelDetailLayer:initBossHpPanel()
	local var_49_0 = self.bossPanelNode:getChildByName("boss_name")
	local var_49_1 = self.bossPanelNode:getChildByName("career")
	local var_49_2 = self.bossPanelNode:getChildByName("level")
	local var_49_3 = self.bossPanelNode:getChildByName("btn_skill_detail")
	local var_49_4 = self.bossPanelNode:getChildByName("score")

	if explore_manager:isHpInherit() then
		self.bloodPanelNode:setVisible(true)
		var_49_0:setPosition(cc.p(10, 315))
		var_49_1:setPosition(cc.p(48, 387))
		var_49_2:setPosition(cc.p(12, 289))
		var_49_4:setPosition(cc.p(255, 205))
		self.fightPowerPanelNode:setPosition(cc.p(0, 655))
		self.bloodPanelNode:getChildByName("num"):setString(self.levelInfo.bossInfo.bossHp * 100 .. "%")
		self.bloodPanelNode:getChildByName("blood"):setScaleX(self.levelInfo.bossInfo.bossHp)
	else
		local var_49_5 = -50

		self.bloodPanelNode:setVisible(false)
		var_49_0:setPosition(cc.p(10, 315 + var_49_5))
		var_49_1:setPosition(cc.p(48, 387 + var_49_5))
		var_49_2:setPosition(cc.p(12, 289 + var_49_5))
		self.fightPowerPanelNode:setPosition(cc.p(0, 655 + var_49_5))
		var_49_4:setPosition(cc.p(255, 205 + var_49_5))
	end
end

function LevelDetailLayer:initAffixPanel(arg_50_1)
	arg_50_1 = self.levelInfo.selectEnemyIndex or 1

	local var_50_0 = self.levelInfo.enemyInfo[arg_50_1]

	if self.affixViewNode == nil then
		self.affixViewNode = ccui.Layout:create()

		self.affixViewNode:setAnchorPoint(cc.p(1, 0))
		self.affixViewNode:setPosition(cc.p(220, -20))
		self.affixViewNode:setName("dropView")
		self.affixViewNode:setContentSize(cc.size(220, 220))
		self.affixViewNode:setScale(0.6)
		self.wordPanelNode:addChild(self.affixViewNode, 99)
	end

	local var_50_1 = var_50_0.affix

	self.wordPanelNode:setVisible(#var_50_0.affix > 0)

	for iter_50_0 = 1, math.ceil(#var_50_1 / 2) do
		local var_50_2 = ccui.Layout:create()

		var_50_2:setContentSize(cc.size(100, 220))

		for iter_50_1 = 1, 2 do
			local var_50_3 = var_50_1[(iter_50_0 - 1) * 2 + iter_50_1]

			if var_50_1[(iter_50_0 - 1) * 2 + iter_50_1] then
				local var_50_4 = self:getAffixItemNode()

				var_50_4:setPosition(cc.p(0, (2 - iter_50_1) * 110))

				local var_50_5 = var_50_4:getChildByName("icon")

				var_50_5:loadTexture("skill_new/skill/" .. var_50_1[(iter_50_0 - 1) * 2 + iter_50_1].icon .. ".png", var_0_0)
				var_50_5:addTouchEventListener(function(arg_51_0, arg_51_1)
					if arg_51_1 ~= ccui.TouchEventType.ended then
						return
					end

					local var_51_0, var_51_1 = var_50_4:getPosition()

					self:skillDesc(var_50_3.id, cc.p(var_51_0, var_51_1))
				end)
				var_50_2:addChild(var_50_4)
			end
		end

		var_50_2:setPosition(cc.p(110 - (iter_50_0 - 1) * 110, 0))
		self.affixViewNode:addChild(var_50_2)
	end
end

function LevelDetailLayer:initDropPanel()
	self.dropPanelNode:getChildByName("title"):loadTexture(self.levelInfo.dropTitlePath, var_0_0)
	self.dropPanelNode:setVisible(false)

	if self.levelInfo.dropInfo == nil or next(self.levelInfo.dropInfo) == nil then
		return
	end

	self.dropPanelNode:setVisible(true)

	if self.dropViewNode == nil then
		self.dropViewNode = ccui.ListView:create()

		self.dropViewNode:setDirection(ccui.ListViewDirection.horizontal)
		self.dropViewNode:setAnchorPoint(cc.p(0, 0))
		self.dropViewNode:setPosition(cc.p(10, 20))
		self.dropViewNode:setName("dropView")
		self.dropViewNode:setContentSize(cc.size(640 / 0.6, 230))
		self.dropViewNode:setScale(0.6)
		self.dropPanelNode:addChild(self.dropViewNode, 99)
	end

	self.dropViewNode:setItemsMargin(20)
	self.dropViewNode:removeAllItems()

	for iter_52_0, iter_52_1 in pairs(self.levelInfo.dropInfo) do
		local var_52_0 = iter_52_1
		local var_52_1 = iter_52_1.itemid
		local var_52_2 = ccui.Layout:create()

		var_52_2:setContentSize(cc.size(180, 230))
		var_52_2:setName("layout")

		local var_52_3 = ItemSprite:createNewWithItemId(iter_52_1.itemid, iter_52_1.num)

		var_52_3:setName("item")
		var_52_3:setAnchorPoint(cc.p(0, 0))
		var_52_2:addChild(var_52_3)
		var_52_2:setTouchEnabled(true)
		var_52_2:addTouchEventListener(function(arg_53_0, arg_53_1)
			if arg_53_1 ~= ccui.TouchEventType.ended then
				return
			end

			if type(var_52_0.itemid) ~= "number" then
				return
			end

			local var_53_0 = item_data[var_52_1].bag_item_type

			if item_data[var_52_1].bag_item_type == kITEM_HORCRUX then
				local var_53_1 = -1
				local horcrux_data = require("data.horcrux_data")

				for iter_53_0, iter_53_1 in pairs((require("data.photofile_HelpGirl_data"))) do
					if iter_53_1.model_id == horcrux_data[var_52_1].model then
						var_53_1 = iter_53_0

						break
					end
				end

				if var_53_1 == -1 then
					print("did not find id")

					return
				end

				LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
					id = var_53_1,
					itemid = var_52_1,
					callback = callback
				})
			elseif var_53_0 == kITEM_HERO then
				LayerManager:pushInLayer("SoulsLayer", {
					showtype = 6,
					layertype = "DropDetailsLayer",
					cursoul = item_data[var_52_1].servant,
					exitCallback = callback
				})
			else
				LayerManager:pushInLayer("PopItemLayer", {
					itemid = var_52_0.itemid
				})
			end
		end)

		if self.initconfig.fight_type == "SUBSTITUTION" then
			var_52_3:getChildByName("number"):setString(item_data[iter_52_1.itemid].name)
		end

		self.dropViewNode:pushBackCustomItem(var_52_2)
	end
end

function LevelDetailLayer:initEnemyPanel()
	if self.levelInfo.enemyInfo == nil then
		return
	end

	if self.enemyViewNode == nil then
		self.enemyViewNode = ccui.ListView:create()

		self.enemyViewNode:setDirection(ccui.ListViewDirection.horizontal)
		self.enemyViewNode:setAnchorPoint(cc.p(0, 0))
		self.enemyViewNode:setPosition(cc.p(10, 25))
		self.enemyViewNode:setName("dropView")
		self.enemyViewNode:setContentSize(cc.size(640 / 1, 230))
		self.enemyViewNode:setTouchEnabled(false)
		self.enemyViewNode:setScale(1)
		self.enemyPanelNode:addChild(self.enemyViewNode, 99)
	end

	self.enemyViewNode:setItemsMargin(0)
	self.enemyViewNode:removeAllItems()

	for iter_54_0, iter_54_1 in pairs(self.levelInfo.enemyInfo) do
		local var_54_0 = iter_54_1
		local var_54_1 = ccui.Layout:create()

		var_54_1:setContentSize(cc.size(124, 230))
		var_54_1:setName("layout")

		local var_54_2 = self:getEnemyItemNode()

		var_54_2:setName("item")
		var_54_2:setAnchorPoint(cc.p(0, 0))
		var_54_1:addChild(var_54_2)
		var_54_2:getChildByName("icon"):loadTexture("roleimage/role/wuji/" .. model_data[var_54_0.modelid].head_image .. ".png")

		local var_54_3 = var_54_2:getChildByName("click")
		local var_54_4 = var_54_2:getChildByName("bg")

		var_54_4:loadTexture(var_54_0.isBoss == true and "LevelDetailLayer/item_boss_bg.png" or "LevelDetailLayer/item_bg.png", var_0_0)

		var_54_4.index = iter_54_0

		var_54_4:addTouchEventListener(function(arg_55_0, arg_55_1)
			if arg_55_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.levelInfo.selectEnemyIndex == arg_55_0.index then
				return
			end

			self.levelInfo.selectEnemyIndex = arg_55_0.index

			for iter_55_0, iter_55_1 in pairs((self.enemyViewNode:getItems())) do
				iter_55_1:getChildByName("item"):getChildByName("click"):setVisible(false)
			end

			var_54_3:setVisible(true)
			self:initBossPanel(self.levelInfo.selectEnemyIndex)
		end)
		var_54_3:setVisible(iter_54_0 == self.levelInfo.selectEnemyIndex)
		self.enemyViewNode:pushBackCustomItem(var_54_1)
	end
end

function LevelDetailLayer.getEnemyItemNode(arg_56_0)
	local var_56_0 = ccui.Layout:create()

	var_56_0:setContentSize(cc.size(124, 124))

	local var_56_1 = ccui.ImageView:create("LevelDetailLayer/item_bg.png", var_0_0)

	var_56_1:setName("bg")
	var_56_1:setAnchorPoint(cc.p(0, 0))
	var_56_1:setTouchEnabled(true)
	var_56_0:addChild(var_56_1)

	local var_56_2 = ccui.ImageView:create("")

	var_56_2:setName("icon")
	var_56_2:setPosition(var_56_1:getContentSize().width / 2, var_56_1:getContentSize().height / 2)
	var_56_2:setScale(0.5)
	var_56_0:addChild(var_56_2)

	local var_56_3 = ccui.ImageView:create("LevelDetailLayer/frame_select_boss.png", var_0_0)

	var_56_3:setName("click")
	var_56_3:setVisible(false)
	var_56_3:setAnchorPoint(cc.p(0, 0))
	var_56_0:addChild(var_56_3)

	return var_56_0
end

function LevelDetailLayer:initBg(arg_57_1)
	local var_57_0 = ccui.Layout:create()

	var_57_0:setTouchEnabled(true)
	var_57_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_57_0:setAnchorPoint(cc.p(0, 0))
	var_57_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_57_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_57_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_57_0:setOpacity(0)
	self:addChild(var_57_0, -1)
	l2utils:captureScreenGaussBlur(function(arg_58_0)
		self:addChild(arg_58_0, -2)
		arg_58_0:setPositionY(arg_58_0:getPositionY() - GameDisplay.fix_y)

		local var_58_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_58_0:setAnchorPoint(cc.p(0, 0))
		var_58_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_58_0, -1)
		self:init(arg_57_1, initInfo)
		var_57_0:setOpacity(102)
		var_57_0:setTouchEnabled(false)
	end)
end
