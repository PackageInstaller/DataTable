BossFightPreviewLayer = class("BossFightPreviewLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local chapter_data = require("data.chapter_data")
local levelmode_data = require("data.levelmode_data")
local battlefield_status_data = require("data.battlefield_status_data")
local model_data = require("data.model_data")
local total_skill_data = require("data.total_skill_data")
local drop_data = require("data.drop_data")
local item_data = require("data.item_data")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local playermodel = require("model.playermodel")
local var_0_10 = require("data.total_skill_data")
local level_manager = require("controller.level_manager")
local monster_manager = require("controller.monster_manager")
local array_manager = require("controller.array_manager")
local servant_data = require("data.servant_data")
local core_manager = require("controller.core_manager")
local audio_manager = require("controller.audio_manager")
local explore_manager = require("controller.explore_manager")
local horcrux_manager = require("controller.horcrux_manager")
local var_0_19 = require("controller.level_manager")
local l2utils = require("controller.l2utils")
local chapter_star_data = require("data.chapter_star_data")
local var_0_22 = require("data.levelmode_data")
local photo_manager = require("controller.photo_manager")
local tower_defence_manager = require("controller.tower_defence_manager")
local account_manager = require("controller.account_manager")
local var_0_28 = {
	"BossFightPreview/level_d.png",
	"BossFightPreview/level_c.png",
	"BossFightPreview/level_b.png",
	"BossFightPreview/level_a.png",
	"BossFightPreview/level_s.png",
	"BossFightPreview/level_ss.png",
	"BossFightPreview/level_sss.png"
}
local var_0_29 = {
	FREE = 1,
	FORBID = 2,
	LOCKING = 3
}

function BossFightPreviewLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = BossFightPreviewLayer.new()

	if arg_2_1.mode ~= 104 or arg_2_1.fight_type == "EXPLORE" then
		var_2_0:initBg(arg_2_1)
	elseif arg_2_1.callback then
		arg_2_1.callback()
	end

	return var_2_0
end

local function var_0_30(arg_3_0)
	local var_3_0, var_3_1 = arg_3_0:match("(%d+)-(%d+)")

	return tonumber(var_3_0), tonumber(var_3_1)
end

local function var_0_31(arg_4_0)
	local var_4_0 = global_get_model_attr(arg_4_0)

	if not var_4_0 then
		return
	end

	return CAREER_ICON[model_data[arg_4_0].career .. "_" .. var_4_0]
end

function BossFightPreviewLayer.updateGuidesOnLayer(arg_5_0)
	GuideListener.cleanCurGuides()
	GuideListener.lockGuideTrigger(false)
	GuideListener.updateGuides(arg_5_0)
end

function BossFightPreviewLayer:fullScreen(arg_6_1, arg_6_2)
	arg_6_1:setContentSize(GameDisplay.getScreenSize())
	arg_6_1:setPositionY(arg_6_1:getPositionY() - GameDisplay.fix_y)
	arg_6_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	arg_6_2:setPositionY(arg_6_2:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)
	self.sureBnt:setPositionY(self.sureBnt:getPositionY() - GameDisplay.fix_y)
end

function BossFightPreviewLayer:init(arg_7_1)
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "BossFightPreview.json" or "BossFightPreview.ExportJson")

	self:addChild(self.rootlayer)

	self.initconfig = arg_7_1 or {}
	self.arrayID = self.initconfig.initindex or 1
	self.adventuresure = self.initconfig.adventuresurecallback

	if self.initconfig.fight_type == "ADVENTURE" then
		self.chapter = self.initconfig.chapter
		self.level = self.initconfig.level
		self.mode = self.initconfig.mode

		if not self.adventuresure then
			ccui.Helper:seekWidgetByName(self.rootlayer, "Button_challenge"):setVisible(false)
		end

		self.callback = self.initconfig.callback
	elseif self.initconfig.fight_type == "SUBSTITUTION" then
		self.chapter = self.initconfig.chapter
		self.level = self.initconfig.level
		self.mode = self.initconfig.mode

		if not self.adventuresure then
			ccui.Helper:seekWidgetByName(self.rootlayer, "Button_challenge"):setVisible(false)
		end

		self.callback = self.initconfig.callback
	elseif self.initconfig.fight_type == "TOWERDEFENCE" then
		self.chapter = self.initconfig.chapter
		self.level = self.initconfig.level
		self.mode = self.initconfig.mode

		if not self.adventuresure then
			ccui.Helper:seekWidgetByName(self.rootlayer, "Button_challenge"):setVisible(false)
		end

		self.callback = self.initconfig.callback
	elseif self.initconfig.fight_type == "EXPLORE" then
		self.mode, self.chapter, self.level = self.initconfig.mode, var_0_30(self.initconfig.level)
		self.uniqueMonsterId = self.initconfig.uniqueMonsterId
	elseif self.initconfig.fight_type == "REFIGHT" then
		self.mode = self.initconfig.mode
		self.chapter, self.level = var_0_30(self.initconfig.level)
	else
		self.mode = playermodel.curMode
		self.chapter, self.level = var_0_30(playermodel.curLevel)
	end

	self.isUmaru = false

	if arg_7_1.isUmaru == true then
		self.isUmaru = true
	end

	self.panelAll = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_ALL")

	self.panelAll:setAnchorPoint(cc.p(0.5, 0.5))
	self.panelAll:setPosition(cc.p(320, 588))
	self.panelAll:addTouchEventListener(function(arg_8_0, arg_8_1)
		return
	end)
	self:runAction((cc.CallFunc:create(function()
		self.panelAll:setScale(1, 0)
		self.panelAll:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1), cc.CallFunc:create(function()
			self:updateGuidesOnLayer()
		end)))
	end)))
	self:registerScriptHandler(function(arg_11_0)
		if arg_11_0 == "exit" then
			if self.emenySkill then
				self.emenySkill:release()
			end

			if self.panelRole then
				self.panelRole:release()
			end

			if self.panelDropOne then
				self.panelDropOne:release()
			end

			if self.btnEnemy then
				self.btnEnemy:release()
			end

			if self.emenyAffix then
				self.emenyAffix:release()
			end

			l2utils:removeNodeShake(self.imageCuteShake)
			l2utils:removeNodeShake(self.imageBossVD)

			if self.callback then
				self.callback()
			end
		end
	end)

	self.bossTeam = self:GetBossOrEnemyInfo()
	self.panelBack = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_back")

	self.panelBack:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.initconfig.cancelcallback then
			self.initconfig.cancelcallback()
		end

		LayerManager:removePopLayer()
	end)

	self.PanelBossInfo = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_bossInfo")

	self.PanelBossInfo:setLocalZOrder(99999)

	self.labelTitle = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_title")
	self.panelBoss = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_boss")
	self.ButtonMapAffix = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_mapAffix")

	self.ButtonMapAffix:setAnchorPoint(cc.p(0.5, 0.5))

	if self.isUmaru == true then
		self.ButtonMapAffix:setPositionY(self.ButtonMapAffix:getPositionY() - 30)
	else
		self.ButtonMapAffix:setPositionX(-250)
		self.ButtonMapAffix:setPositionY(self.ButtonMapAffix:getPositionY() + 50)
	end

	local var_7_1 = {
		battlefieldstatus = {}
	}

	if self.initconfig.fight_type ~= "EXPLORE" then
		print("这里可能没有章节标题，要改")
		self.labelTitle:setString(level_manager:getChapterName(self.mode, self.chapter))

		for iter_7_0, iter_7_1 in pairs(chapter_data[self.mode .. "-" .. self.chapter]) do
			local var_7_2 = string.match(iter_7_0, "battlefieldstatus(%d+)")

			if var_7_2 and not (var_7_2 and chapter_data[self.mode .. "-" .. self.chapter]["cizhui_hide" .. var_7_2]) then
				var_7_1.battlefieldstatus[tonumber(var_7_2)] = {
					des = battlefield_status_data[iter_7_1].des,
					targetside = battlefield_status_data[iter_7_1].targetside
				}
			end
		end
	else
		self.labelTitle:setString("")
	end

	self.sureBnt = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_challenge")

	if self.isUmaru == false or self.isUmaru == false and self.initconfig.curChapterStatus == var_0_29.FREE then
		self.sureBnt:setColor(cc.c3b(255, 255, 255))
	elseif self.initconfig.curChapterStatus == var_0_29.LOCKING then
		self.sureBnt:setColor(cc.c3b(125, 125, 125))
	elseif self.initconfig.curChapterStatus == var_0_29.FORBID then
		self.sureBnt:setColor(cc.c3b(125, 125, 125))
	end

	self.sureBnt:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.isUmaru == false or self.initconfig.curChapterStatus == var_0_29.FREE then
			local var_13_0 = self.initconfig.callback

			LayerManager:removePopLayer()

			if var_13_0 and self.initconfig.fight_type == "ADVENTURE" or self.initconfig.fight_type == "SUBSTITUTION" or self.initconfig.fight_type == "TOWERDEFENCE" then
				self.initconfig.callback(self.arrayID)

				if self.adventuresure then
					self.adventuresure()
				end
			elseif var_13_0 then
				var_13_0()
			end
		elseif self.initconfig.curChapterStatus == var_0_29.LOCKING then
			if self.initconfig.mode == 23092 or self.initconfig.mode == 23093 or self.initconfig.mode == 23094 then
				if var_0_22[self.initconfig.mode] then
					if var_0_22[self.initconfig.mode].unlocktime then
						local var_13_1 = os.date("*t", (global_get_time_by_date(var_0_22[self.initconfig.mode].unlocktime)))

						global_ShowBlockWords((string.format(L_MAP_CITY_CHAPTERS.Unlock_Day, var_13_1.month, var_13_1.day)))
					end
				end
			else
				global_ShowBlockWords(L_MAP_CITY_CHAPTERS.Locking)
			end

			audio_manager:playeffectMusicTest("sound/invalid")
		elseif self.initconfig.curChapterStatus == var_0_29.FORBID then
			global_ShowBlockWords(L_MAP_CITY_CHAPTERS.Forbid)
			audio_manager:playeffectMusicTest("sound/invalid")
		end
	end)

	self.imageEffect = ccui.ImageView:create("BossFightPreview/popup_buff_details.png", var_0_0)

	self.imageEffect:setScale9Enabled(true)
	self.imageEffect:setContentSize(cc.size(416, 96))
	self.imageEffect:setAnchorPoint(cc.p(0.5, 0.5))
	self.panelBoss:addChild(self.imageEffect, 1001)

	local var_7_3 = ""

	for iter_7_2 = 1, #var_7_1.battlefieldstatus do
		if var_7_1.battlefieldstatus[iter_7_2].des then
			var_7_3 = var_7_3 .. var_7_1.battlefieldstatus[iter_7_2].des .. "\n"
		end
	end

	self.labelEffect = cc.Label:createWithTTF("", "fonts/number.ttf", 20)

	local var_7_4 = 1
	local var_7_5 = 1

	if var_7_3 == "" then
		self.labelEffect:setString(L_BOSS_FIGHT_NO_EFFECT)
	else
		self.labelEffect:setString(var_7_3)
	end

	if self.labelEffect:getContentSize().height > self.imageEffect:getContentSize().height then
		var_7_5 = self.labelEffect:getContentSize().height / self.imageEffect:getContentSize().height
	end

	if self.labelEffect:getContentSize().width > self.imageEffect:getContentSize().width then
		var_7_4 = self.labelEffect:getContentSize().width / self.imageEffect:getContentSize().width
	end

	self.imageEffect:setAnchorPoint(cc.p(0, 1))
	self.imageEffect:setScale(var_7_4, var_7_5)
	self.labelEffect:setColor(cc.c3b(245, 246, 232))
	self.labelEffect:setAnchorPoint(cc.p(0, 1))
	self.panelBoss:addChild(self.labelEffect, 1003)

	if self.isUmaru == true then
		self.imageEffect:setPosition(cc.p(self.ButtonMapAffix:getPositionX() - self.imageEffect:getContentSize().width - self.ButtonMapAffix:getContentSize().width / 2, self.ButtonMapAffix:getPositionY() + self.imageEffect:getContentSize().height / 2))
		self.labelEffect:setPosition(cc.p(self.ButtonMapAffix:getPositionX() - self.imageEffect:getContentSize().width - self.ButtonMapAffix:getContentSize().width / 2, self.ButtonMapAffix:getPositionY() + self.imageEffect:getContentSize().height / 2))
	else
		self.imageEffect:setPosition(cc.p(self.ButtonMapAffix:getPositionX() + self.ButtonMapAffix:getContentSize().width / 2, self.ButtonMapAffix:getPositionY() + self.imageEffect:getContentSize().height / 2))
		self.labelEffect:setPosition(cc.p(self.ButtonMapAffix:getPositionX() + self.ButtonMapAffix:getContentSize().width / 2, self.ButtonMapAffix:getPositionY() + self.imageEffect:getContentSize().height / 2))
	end

	self.imageEffect:setVisible(false)
	self.labelEffect:setVisible(false)

	local var_7_6 = cc.EventListenerTouchOneByOne:create()

	var_7_6:setSwallowTouches(false)
	var_7_6:registerScriptHandler(function(arg_14_0, arg_14_1)
		if self.labelEffect then
			self.labelEffect:setVisible(false)
			self.imageEffect:setVisible(false)
		end

		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_7_6:registerScriptHandler(function(arg_15_0, arg_15_1)
		if self.labelEffect then
			self.labelEffect:setVisible(false)
			self.imageEffect:setVisible(false)
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_7_6, self.labelEffect)

	if #var_7_1.battlefieldstatus ~= 0 then
		self.ButtonMapAffix:loadTextures("BossFightPreview/affix_button_yellow.png", nil, "BossFightPreview/affix_button_yellow.png", var_0_0)
	else
		self.ButtonMapAffix:setVisible(false)
	end

	self.ButtonMapAffix:setLocalZOrder(1000)
	self.ButtonMapAffix:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.imageEffect:setVisible(self.imageEffect:isVisible() == false)
		self.labelEffect:setVisible(self.labelEffect:isVisible() == false)
	end)

	self.count = 0
	self.fightPowerSum = 0

	self:initSkill()
	self:inifBossOrEnemyInfo()
	self:initMonster()

	if self.initconfig.fight_type == "REFIGHT" then
		self:initRefightStarsInfo()
	elseif self.initconfig.fight_type == "MAIN" then
		self:initDrop()
		self:initMainStarsInfo()
	elseif self.initconfig.fight_type == "ADVENTURE" and var_0_22[self.mode].is_check_stars then
		self:initDrop()
		self:initMainStarsInfo()
	else
		self:initDrop()
	end

	self:createHpBar()
	self:switchEnemy(1)

	if self.initconfig.fight_type == "SUBSTITUTION" then
		self:initSubUI()
	end

	self:fullScreen(self.panelBack, self.panelAll)

	if self.initconfig.fight_type ~= "EXPLORE" then
		self.nodeServantRank = require("view.Sprite.NodeServantRankEntrance").showInLayer(self.panelAll, {
			mode = self.mode,
			chapter = self.chapter,
			fightType = require("controller.servant_rank_manager").getInstance().FIGHT_TYPE.PVE,
			clickCallBack = function()
				self.callback = nil
			end
		}, cc.p(80, 230))

		self.nodeServantRank:setLocalZOrder(5)
	end
end

function BossFightPreviewLayer:createHpBar()
	if not explore_manager:isHpInherit() then
		return
	end

	local var_18_0 = 0
	local var_18_1 = 190
	local var_18_2

	if config._DEBUG then
		var_18_2 = cc.Sprite:create("fight/hp_bg_inherit_3.png") or cc.Sprite:createWithSpriteFrameName("fight/hp_bg_inherit_3.png")
	end

	var_18_2:setAnchorPoint(cc.p(0, 0))
	var_18_2:setPosition(cc.p(var_18_0, var_18_1 + 8))
	self.panelAll:addChild(var_18_2, 5)

	self.progressTimer = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("fight/hp_bar_inherit_3.png") or cc.Sprite:createWithSpriteFrameName("fight/hp_bar_inherit_3.png")))

	self.panelAll:addChild(self.progressTimer, 5, "progressTimer")
	self.progressTimer:setAnchorPoint(cc.p(0, 0))
	self.progressTimer:setPosition(cc.p(var_18_0 + 38, var_18_1 + 11))
	self.progressTimer:setMidpoint(cc.p(0, 0.5))
	self.progressTimer:setBarChangeRate(cc.p(1, 0))
	self.progressTimer:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.progressTimer:setPercentage(100)

	self.labelHp = cc.Label:createWithTTF("100%", "fonts/new1.ttf", 22)

	self.labelHp:setAnchorPoint(cc.p(0.5, 0.5))
	self.labelHp:setPosition(cc.p(self.progressTimer:getContentSize().width / 2, 14))
	self.labelHp:setAlignment(cc.TEXT_ALIGNMENT_CENTER, cc.TEXT_ALIGNMENT_CENTER)
	self.progressTimer:addChild(self.labelHp)
end

function BossFightPreviewLayer:updateHpBar(arg_19_1)
	if not self.progressTimer or not self.labelHp then
		return
	end

	local var_19_0 = explore_manager:getHpInherit(arg_19_1 .. self.uniqueMonsterId) or 1

	self.progressTimer:setPercentage(math.round(var_19_0 * 100))
	self.labelHp:setString(math.round(var_19_0 * 100) .. "%")
end

function BossFightPreviewLayer:initEarn()
	self.earn = self:getEarnData()
	self.panel_content = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_get")
	self.labelEarn = ccui.Helper:seekWidgetByName(self.rootlayer, "label_earn")

	local var_20_0 = 0

	if self.earn.gold ~= 0 then
		local var_20_1 = self.labelEarn:clone()
		local var_20_2 = ccui.ImageView:create(IMAGE_GOLD, var_0_0)

		var_20_2:setAnchorPoint(cc.p(0, 0.5))
		var_20_2:setPosition(cc.p(var_20_0, 0))
		self.panel_content:addChild(var_20_2)

		var_20_0 = var_20_0 + var_20_2:getContentSize().width + 5

		var_20_1:setString("+" .. self.earn.gold * 6 .. "/M")
		var_20_1:setColor(cc.c3b(234, 232, 226))
		var_20_1:setAnchorPoint(cc.p(0, 0.5))
		var_20_1:setPosition(cc.p(var_20_0, 0))
		var_20_1:setName("goldLabel")
		self.panel_content:addChild(var_20_1)

		var_20_0 = var_20_0 + var_20_1:getContentSize().width + 5
	end

	if self.earn.exp ~= 0 then
		local var_20_3 = self.labelEarn:clone()
		local var_20_4 = ccui.ImageView:create("BossFightPreview/award_exp.png", var_0_0)

		var_20_4:setAnchorPoint(cc.p(0, 0.5))
		var_20_4:setPosition(cc.p(var_20_0, 0))
		self.panel_content:addChild(var_20_4)

		var_20_0 = var_20_0 + var_20_4:getContentSize().width + 5

		var_20_3:setString("+" .. self.earn.exp * 6 .. "/M")
		var_20_3:setColor(cc.c3b(234, 232, 226))
		var_20_3:setAnchorPoint(cc.p(0, 0.5))
		var_20_3:setPosition(cc.p(var_20_0, 0))
		var_20_3:setName("expLabel")
		self.panel_content:addChild(var_20_3)

		var_20_0 = var_20_0 + var_20_3:getContentSize().width + 5
	end

	if self.earn.strengthpoint ~= 0 then
		local var_20_5 = self.labelEarn:clone()
		local var_20_6 = ccui.ImageView:create(IMAGE_STRENGTHPOINT, var_0_0)

		var_20_6:setAnchorPoint(cc.p(0, 0.5))
		var_20_6:setPosition(cc.p(var_20_0 - 2, 0))
		self.panel_content:addChild(var_20_6)
		var_20_5:setString("+" .. self.earn.strengthpoint * 6 .. "/M")
		var_20_5:setColor(cc.c3b(234, 232, 226))
		var_20_5:setAnchorPoint(cc.p(0, 0.5))
		var_20_5:setPosition(cc.p(var_20_0 + var_20_6:getContentSize().width + 5, 0))
		var_20_5:setName("strengthPointLabel")
		self.panel_content:addChild(var_20_5)
	end
end

function BossFightPreviewLayer:getEarnData()
	local var_21_0 = {
		exp = 0,
		gold = 0,
		strengthpoint = 0
	}
	local var_21_1 = level_manager:isMainChapterOrFeederChapter(self.mode) and chapter_data[self.mode .. "-" .. self.chapter] or self.initconfig.fight_type == "EXPLORE" and explore_manager.getCurData("level", self.mode)[self.chapter .. "-" .. self.level] or level_manager.loadLevelData(self.mode)[self.mode .. "-" .. self.chapter .. "-" .. self.level]

	if self.chapter == 1 or self.initconfig.fight_type == "EXPLORE" then
		if var_21_1.gold then
			var_21_0.gold = var_21_1.gold
		end

		if var_21_1.exp then
			var_21_0.exp = var_21_1.exp
		end

		if var_21_1.strengthpoint then
			var_21_0.strengthpoint = var_21_1.strengthpoint
		end
	else
		local var_21_2 = chapter_data[self.mode .. "-" .. self.chapter - 1]

		if var_21_1.gold then
			var_21_0.gold = var_21_1.gold - var_21_2.gold
		end

		if var_21_1.exp then
			var_21_0.exp = var_21_1.exp - var_21_2.exp
		end

		if var_21_1.strengthpoint then
			var_21_0.strengthpoint = var_21_1.strengthpoint - var_21_2.strengthpoint
		end
	end

	return var_21_0
end

function BossFightPreviewLayer:initDropWithParams(arg_22_1)
	local Utility = require("common.Utility")

	for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
		local var_22_1 = self.panelDropOne:clone()
		local var_22_2 = ItemSprite:createNewWithItemId(iter_22_1.itemid, iter_22_1.num)

		Utility:addClickEventListener(var_22_1, function()
			LayerManager:pushInLayer("PopItemLayer", {
				itemid = iter_22_1.itemid
			})
		end)
		var_22_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_22_2:setScale(0.46)
		var_22_2:setPosition(cc.p(var_22_1:getContentSize().width * 0.5, var_22_1:getContentSize().height * 0.5))
		var_22_1:addChild(var_22_2)
		self.ListViewDrop:pushBackCustomItem(var_22_1)
	end
end

function BossFightPreviewLayer:initDrop()
	if self.initconfig.fight_type == "EXPLORE" then
		ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_drop"):getChildByName("Label_33"):setString(L_PROFALL[1])
	elseif self.initconfig.fight_type == "MAIN" then
		ccui.Helper:seekWidgetByName(self.rootlayer, "ListView_drop"):setContentSize(cc.size(240, 96))
		ccui.Helper:seekWidgetByName(self.rootlayer, "ListView_drop"):setClippingEnabled(true)
	end

	self.ListViewDrop = ccui.Helper:seekWidgetByName(self.rootlayer, "ListView_drop")

	self.ListViewDrop:setItemsMargin(10)

	self.panelDropOne = self.ListViewDrop:getChildByName("Panel_dropOne")

	self.panelDropOne:retain()
	self.panelDropOne:removeFromParent()

	if self.initconfig.drops then
		self:initDropWithParams(self.initconfig.drops)

		return
	end

	local var_24_0 = self:getDropData()

	if var_24_0.gold > 0 then
		local var_24_1 = self.panelDropOne:clone()
		local var_24_2 = ItemSprite:createNewWithItemId("gold", var_24_0.gold)

		var_24_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_24_2:setPosition(cc.p(var_24_1:getContentSize().width * 0.5, var_24_1:getContentSize().height * 0.5))
		var_24_2:setScale(0.46)
		var_24_1:addChild(var_24_2)
		self.ListViewDrop:pushBackCustomItem(var_24_1)
	end

	if var_24_0.diamond > 0 then
		local var_24_3 = self.panelDropOne:clone()
		local var_24_4 = ItemSprite:createNewWithItemId("diamond", var_24_0.diamond)

		var_24_4:setAnchorPoint(cc.p(0.5, 0.5))
		var_24_4:setPosition(cc.p(var_24_3:getContentSize().width * 0.5, var_24_3:getContentSize().height * 0.5))
		var_24_4:setScale(0.46)
		var_24_3:addChild(var_24_4)
		self.ListViewDrop:pushBackCustomItem(var_24_3)
	end

	for iter_24_0 = 1, #var_24_0.items do
		local var_24_5 = self.panelDropOne:clone()
		local var_24_6 = ItemSprite:createNewWithItemId(var_24_0.items[iter_24_0].itemid, var_24_0.items[iter_24_0].num)

		var_24_6:setAnchorPoint(cc.p(0.5, 0.5))
		var_24_6:setScale(0.46)
		var_24_6:setPosition(cc.p(var_24_5:getContentSize().width * 0.5, var_24_5:getContentSize().height * 0.5))
		var_24_5:addChild(var_24_6)

		var_24_5.item_type = "item"

		var_24_5:addTouchEventListener(function(arg_25_0, arg_25_1)
			if arg_25_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:showDetailsofItems(var_24_0.items[iter_24_0].itemid, var_24_5.item_type)
		end)

		if self.initconfig.fight_type == "SUBSTITUTION" then
			local var_24_7 = var_24_6:getChildByName("number")

			var_24_7:setString(item_data[var_24_0.items[iter_24_0].itemid].name)
			var_24_7:setPositionY(var_24_7:getPositionY() + 5)
		end

		self.ListViewDrop:pushBackCustomItem(var_24_5)
	end
end

function BossFightPreviewLayer:initRefightStarsInfo()
	local var_26_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_redFightPower"):getParent()

	ccui.Helper:seekWidgetByName(self.rootlayer, "Image_redFightPower"):setPosition(335, 150)
	ccui.Helper:seekWidgetByName(self.rootlayer, "Label_33"):setVisible(false)

	local var_26_1 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_redFightPower")

	ccui.Helper:seekWidgetByName(self.rootlayer, "labelBossFightGreen"):setPosition(cc.p(var_26_1:getPositionX() + var_26_1:getContentSize().width * 0.9, var_26_1:getPositionY()))
	ccui.Helper:seekWidgetByName(self.rootlayer, "labelBossFightRed"):setPosition(cc.p(var_26_1:getPositionX() + var_26_1:getContentSize().width * 0.9, var_26_1:getPositionY()))

	local var_26_2 = ccui.ImageView:create("BossFightPreview/stars_info.png", var_0_0)

	var_26_2:setPosition(102, 150)
	var_26_0:addChild(var_26_2)

	local var_26_3 = var_0_19:getChapterStarsState(self.mode, self.chapter)

	for iter_26_0 = 1, LEVEL_STARS_NUM do
		if var_26_3[iter_26_0] then
			local var_26_4 = ccui.ImageView:create("BossFightPreview/star_icon.png", var_0_0)

			var_26_4:setScale(1.25)
			var_26_4:setPosition(0, 100 - (iter_26_0 - 1) * 40)
			var_26_0:addChild(var_26_4)

			local var_26_5 = cc.Label:createWithTTF(chapter_star_data[self.mode .. "-" .. self.chapter]["star" .. iter_26_0 .. "_des"] or "", FONT_NAME, 23)

			var_26_5:setAnchorPoint(cc.p(0, 0.5))
			var_26_5:setColor(cc.c3b(255, 228, 0))

			if self.isUmaru == true then
				var_26_5:setPosition(30, 100 - (iter_26_0 - 1) * 40 - 10)
			else
				var_26_5:setPosition(30, 100 - (iter_26_0 - 1) * 40)
			end

			var_26_0:addChild(var_26_5)
		else
			local var_26_6 = 100 - (iter_26_0 - 1) * 40
			local var_26_7 = ccui.ImageView:create("BossFightPreview/star_gray.png", var_0_0)

			var_26_7:setScale(1.25)
			var_26_7:setPosition(0, var_26_6)
			var_26_0:addChild(var_26_7)

			local var_26_8 = cc.Label:createWithTTF(chapter_star_data[self.mode .. "-" .. self.chapter]["star" .. iter_26_0 .. "_des"] or "", FONT_NAME, 23)

			var_26_8:setColor(cc.c3b(190, 213, 228))
			var_26_8:setAnchorPoint(cc.p(0, 0.5))

			if self.isUmaru == true then
				var_26_8:setPosition(30, var_26_6 - 10)
			else
				var_26_8:setPosition(30, var_26_6)
			end

			var_26_0:addChild(var_26_8)

			local var_26_9 = cc.Label:createWithTTF("未完成", FONT_NAME, 23)

			var_26_9:setColor(cc.c3b(187, 30, 72))
			var_26_9:setAnchorPoint(cc.p(0, 0.5))
			var_26_9:setPosition(437, var_26_6)
			var_26_0:addChild(var_26_9)
		end
	end
end

function BossFightPreviewLayer:initMainStarsInfo()
	if var_0_19:isTalkLevel(self.mode) then
		return
	end

	local var_27_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_redFightPower"):getParent()
	local var_27_1 = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_drop"):getChildByName("Label_33"):clone()

	var_27_1:setContentSize(cc.size(20, 170))
	var_27_1:setString(L_CHALLENGE_TARGET)

	if self.isUmaru == true then
		var_27_1:setPosition(290, 0)
	else
		var_27_1:setPosition(290, 67)
	end

	var_27_0:addChild(var_27_1)

	local var_27_2 = var_0_19:getChapterStarsState(self.mode, self.chapter)

	for iter_27_0 = 1, LEVEL_STARS_NUM do
		local var_27_4 = 80 - (iter_27_0 - 1) * 40 + 20

		if self.isUmaru == true then
			var_27_4 = 80 - (iter_27_0 - 1) * 40 + 10
		end

		if var_27_2[iter_27_0] then
			local var_27_6 = ccui.ImageView:create("BossFightPreview/star_icon.png", var_0_0)

			var_27_6:setScale(1.25)
			var_27_6:setPosition(320, var_27_4)
			var_27_0:addChild(var_27_6)

			local var_27_7 = cc.Label:createWithTTF(chapter_star_data[self.mode .. "-" .. self.chapter]["star" .. iter_27_0 .. "_des"] or "", FONT_NAME, 23)

			var_27_7:setAnchorPoint(cc.p(0, 0.5))
			var_27_7:setColor(cc.c3b(255, 228, 0))

			if self.isUmaru == true then
				var_27_7:setPosition(350, var_27_4 - 10)
			else
				var_27_7:setPosition(350, var_27_4)
			end

			var_27_0:addChild(var_27_7)
		else
			local var_27_9 = ccui.ImageView:create("BossFightPreview/star_gray.png", var_0_0)

			var_27_9:setScale(1.25)
			var_27_9:setPosition(320, var_27_4)
			var_27_0:addChild(var_27_9)

			if var_0_22[self.mode].modetype == 1 then
				local var_27_10 = ccui.ImageView:create("public/currency/888888.png", var_0_0)

				var_27_10:setPosition(250, var_27_4)
				var_27_10:setScale(0.7)
				var_27_0:addChild(var_27_10)

				local var_27_11 = cc.Label:createWithTTF("+5", FONT_NAME, 23)

				var_27_11:setPosition(280, var_27_4)
				var_27_11:setColor(cc.c3b(190, 213, 228))
				var_27_0:addChild(var_27_11)
			end

			local var_27_12 = cc.Label:createWithTTF(chapter_star_data[self.mode .. "-" .. self.chapter]["star" .. iter_27_0 .. "_des"] or "", FONT_NAME, 23)

			var_27_12:setAnchorPoint(cc.p(0, 0.5))
			var_27_12:setColor(cc.c3b(190, 213, 228))

			if self.isUmaru == true then
				var_27_12:setPosition(350, var_27_4 - 10)
			else
				var_27_12:setPosition(350, var_27_4)
			end

			var_27_0:addChild(var_27_12)
		end
	end
end

function BossFightPreviewLayer:showDetailsofItems(arg_28_1, arg_28_2)
	local function var_28_1()
		self.rootlayer:setVisible(true)
	end

	if arg_28_2 == "item" then
		if item_data[arg_28_1].bag_item_type == kITEM_HORCRUX then
			local var_28_2 = -1
			local horcrux_data = require("data.horcrux_data")

			for iter_28_0, iter_28_1 in pairs((require("data.photofile_HelpGirl_data"))) do
				if iter_28_1.model_id == horcrux_data[arg_28_1].model then
					var_28_2 = iter_28_0

					break
				end
			end

			if var_28_2 == -1 then
				print("did not find id")

				return
			end

			LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
				id = var_28_2,
				itemid = arg_28_1,
				callback = var_28_1
			})
			self.rootlayer:setVisible(false)
		elseif item_data[arg_28_1].bag_item_type == kITEM_HERO then
			LayerManager:pushInLayer("SoulsLayer", {
				showtype = 6,
				layertype = "DropDetailsLayer",
				cursoul = item_data[arg_28_1].servant,
				exitCallback = var_28_1
			})
			self.rootlayer:setVisible(false)
		elseif not self:getChildByName("OTHER_LAYER") then
			local var_28_4 = PopLayer:Item({
				hideGainButton = true,
				itemid = arg_28_1
			})
		end
	elseif arg_28_2 == "gold" then
		-- block empty
	elseif arg_28_2 == "diamond" then
		-- block empty
	end
end

function BossFightPreviewLayer:getDropData()
	local var_30_2 = {
		gold = 0,
		diamond = 0,
		items = {}
	}
	local var_30_3 = drop_data[level_manager:isMainChapterOrFeederChapter(self.mode) and ((account_manager:getChannel() == "270056" or account_manager:getChannel() == "palmpi") and (playermodel.create_time < os.time({
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
	}) and (chapter_data[self.mode .. "-" .. self.chapter].bigbossdrop_old or chapter_data[self.mode .. "-" .. self.chapter].bigbossdrop) or chapter_data[self.mode .. "-" .. self.chapter].bigbossdrop) or self.initconfig.fight_type == "EXPLORE" and explore_manager.getCurData("level", self.mode)[self.chapter .. "-" .. self.level].equip_drop or level_manager.loadLevelData(self.mode)[self.mode .. "-" .. self.chapter .. "-" .. self.level].equip_drop] or {}

	if var_30_3.gold then
		var_30_2.gold = var_30_2.gold + var_30_3.gold
	end

	if var_30_3.diamond then
		var_30_2.diamond = var_30_2.diamond + var_30_3.diamond
	end

	local var_30_4 = 1

	if var_30_3["drop_id" .. 1] then
		local var_30_5 = 1

		while var_30_3["drop_id" .. var_30_5] do
			var_30_2.items[var_30_4] = {
				itemid = var_30_3["drop_id" .. var_30_5],
				num = var_30_3["drop_num" .. var_30_5]
			}
			var_30_5 = var_30_5 + 1
			var_30_4 = var_30_4 + 1
		end
	end

	if var_30_3["dropmodel_id" .. 1] then
		local var_30_6 = 1

		while var_30_3["dropmodel_id" .. var_30_6] do
			if drop_data[var_30_3["dropmodel_id" .. var_30_6]].gold then
				var_30_2.gold = var_30_2.gold + drop_data[var_30_3["dropmodel_id" .. var_30_6]].gold
			end

			if drop_data[var_30_3["dropmodel_id" .. var_30_6]].diamond then
				var_30_2.diamond = var_30_2.diamond + drop_data[var_30_3["dropmodel_id" .. var_30_6]].diamond
			end

			if drop_data[var_30_3["dropmodel_id" .. var_30_6]]["drop_id" .. 1] then
				local var_30_7 = 1

				while drop_data[var_30_3["dropmodel_id" .. var_30_6]]["drop_id" .. var_30_7] do
					var_30_2.items[var_30_4] = {
						itemid = drop_data[var_30_3["dropmodel_id" .. var_30_6]]["drop_id" .. var_30_7],
						num = drop_data[var_30_3["dropmodel_id" .. var_30_6]]["drop_num" .. var_30_7]
					}
					var_30_7 = var_30_7 + 1
					var_30_4 = var_30_4 + 1
				end
			end

			if drop_data[var_30_3["dropmodel_id" .. var_30_6]]["rd_drop_id" .. 1] then
				local var_30_8 = 1

				while drop_data[var_30_3["dropmodel_id" .. var_30_6]]["rd_drop_id" .. var_30_8] do
					var_30_2.items[var_30_4] = {
						itemid = drop_data[var_30_3["dropmodel_id" .. var_30_6]]["rd_drop_id" .. var_30_8],
						num = drop_data[var_30_3["dropmodel_id" .. var_30_6]]["rd_drop_num" .. var_30_8]
					}
					var_30_8 = var_30_8 + 1
					var_30_4 = var_30_4 + 1
				end
			end

			var_30_6 = var_30_6 + 1
		end
	end

	if var_30_3["rd_drop_id" .. 1] then
		local var_30_9 = 1

		while var_30_3["rd_drop_id" .. var_30_9] do
			var_30_2.items[var_30_4] = {
				itemid = var_30_3["rd_drop_id" .. var_30_9],
				num = var_30_3["rd_drop_num" .. var_30_9]
			}
			var_30_9 = var_30_9 + 1
			var_30_4 = var_30_4 + 1
		end
	end

	if var_30_3["rd_dropmodel_id" .. 1] then
		local var_30_10 = 1

		while var_30_3["rd_dropmodel_id" .. var_30_10] do
			if drop_data[var_30_3["rd_dropmodel_id" .. var_30_10]].gold then
				var_30_2.gold = var_30_2.gold + drop_data[var_30_3["rd_dropmodel_id" .. var_30_10]].gold
			end

			if drop_data[var_30_3["rd_dropmodel_id" .. var_30_10]].diamond then
				var_30_2.diamond = var_30_2.diamond + drop_data[var_30_3["rd_dropmodel_id" .. var_30_10]].diamond
			end

			if drop_data[var_30_3["rd_dropmodel_id" .. var_30_10]]["drop_id" .. 1] then
				local var_30_11 = 1

				while drop_data[var_30_3["rd_dropmodel_id" .. var_30_10]]["drop_id" .. var_30_11] do
					var_30_2.items[var_30_4] = {
						itemid = drop_data[var_30_3["rd_dropmodel_id" .. var_30_10]]["drop_id" .. var_30_11],
						num = drop_data[var_30_3["rd_dropmodel_id" .. var_30_10]]["drop_num" .. var_30_11]
					}
					var_30_11 = var_30_11 + 1
					var_30_4 = var_30_4 + 1
				end
			end

			if drop_data[var_30_3["rd_dropmodel_id" .. var_30_10]]["rd_drop_id" .. 1] then
				local var_30_12 = 1

				while drop_data[var_30_3["rd_dropmodel_id" .. var_30_10]]["rd_drop_id" .. var_30_12] do
					var_30_2.items[var_30_4] = {
						itemid = drop_data[var_30_3["rd_dropmodel_id" .. var_30_10]]["rd_drop_id" .. var_30_12],
						num = drop_data[var_30_3["rd_dropmodel_id" .. var_30_10]]["rd_drop_num" .. var_30_12]
					}
					var_30_12 = var_30_12 + 1
					var_30_4 = var_30_4 + 1
				end
			end

			var_30_10 = var_30_10 + 1
		end
	end

	return var_30_2
end

function BossFightPreviewLayer:initMonster()
	self.LabelBossFightPower = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_bossFightPower")
	self.ListViewBoss = ccui.Helper:seekWidgetByName(self.rootlayer, "ListView_boss")

	self.ListViewBoss:setItemsMargin(5)

	self.panelList = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_listBoss")
	self.btnEnemy = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_boss")

	self.btnEnemy:retain()
	self.btnEnemy:removeFromParent()

	self.btnEnemys = {}

	local var_31_0 = 470
	local var_31_1 = self.btnEnemy:getPositionY()
	local var_31_2 = self.btnEnemy:getContentSize().width
	local var_31_3 = 0

	if self.bossTeam.boss then
		local var_31_4 = self.btnEnemy:clone()
		local var_31_5 = ccui.ImageView:create("roleimage/role/wuji/" .. model_data[self.bossTeam.boss.modelid].head_image .. ".png")

		var_31_5:setScale(0.42)
		var_31_5:setName("imageHead")
		var_31_5:setPosition(var_31_4:getContentSize().width / 2, var_31_4:getContentSize().height / 2 + 10)
		var_31_4:addChild(var_31_5, 999)
		var_31_4:setPosition(cc.p(var_31_0, var_31_1))
		self.panelList:addChild(var_31_4, 999)

		self.btnEnemys[1] = var_31_4
		var_31_3 = var_31_3 + (self.initconfig.fight_type == "EXPLORE" and fight_capacity_manager:getExploreEnemyFightCapacity(self.mode, self.bossTeam.boss.id) or self.initconfig.fight_type == "TOWERDEFENCE" and (self.bossTeam.boss.fightpower or 99) or fight_capacity_manager:getEnemyFightCapacity(self.mode, self.bossTeam.boss.id))

		var_31_4:addTouchEventListener(function(arg_32_0, arg_32_1)
			if arg_32_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:switchEnemy(1)
		end)
	end

	if self.bossTeam.monster then
		for iter_31_0 = 1, #self.bossTeam.monster do
			local var_31_7 = self.bossTeam.boss and iter_31_0 + 1 or iter_31_0

			var_31_3 = var_31_3 + (self.initconfig.fight_type == "EXPLORE" and fight_capacity_manager:getExploreEnemyFightCapacity(self.mode, self.bossTeam.monster[iter_31_0].id) or fight_capacity_manager:getEnemyFightCapacity(self.mode, self.bossTeam.monster[iter_31_0].id))

			local var_31_9 = self.btnEnemy:clone()
			local var_31_10 = ccui.ImageView:create("roleimage/role/wuji/" .. model_data[self.bossTeam.monster[iter_31_0].modelid].head_image .. ".png")

			var_31_10:setScale(0.42)
			var_31_10:setName("imageHead")
			var_31_10:setPosition(var_31_9:getContentSize().width / 2, var_31_9:getContentSize().height / 2 + 10)
			var_31_9:addChild(var_31_10, 999)
			var_31_9:setPosition(cc.p(var_31_0 - (var_31_7 - 1) * var_31_2, var_31_1))
			self.panelList:addChild(var_31_9, 999)

			self.btnEnemys[var_31_7] = var_31_9

			var_31_9:addTouchEventListener(function(arg_33_0, arg_33_1)
				if arg_33_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:switchEnemy(var_31_7)
			end)
		end
	end

	local var_31_11 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_redFightPower")
	local var_31_13 = ccui.Helper:seekWidgetByName(self.rootlayer, "labelBossFightGreen")
	local var_31_14 = ccui.Helper:seekWidgetByName(self.rootlayer, "labelBossFightRed")

	if self.initconfig.fight_type == "ADVENTURE" then
		var_31_3 = chapter_data[self.mode .. "-" .. self.chapter].combat_limit

		local var_31_15 = array_manager:getBattleArrayData(self.arrayID)

		if chapter_data[self.mode .. "-" .. self.chapter].combat_limit < fight_capacity_manager:getArrayFightCapacity(var_31_15, nil, nil, nil, self.mode) then
			var_31_13:setString(global_trans_bitmapnumber(var_31_3))
		else
			var_31_14:setString(global_trans_bitmapnumber(var_31_3))
		end

		if var_31_3 < fight_capacity_manager:getArrayFightCapacity(var_31_15, nil, nil, nil, self.mode) then
			var_31_11:loadTexture("BossFightPreview/img_recommend_easy.png", var_0_0)
			var_31_13:setPosition(cc.p(var_31_11:getPositionX() + var_31_11:getContentSize().width * 0.9, var_31_11:getPositionY()))
		else
			var_31_11:loadTexture("BossFightPreview/img_recommend_hard.png", var_0_0)
			var_31_14:setPosition(cc.p(var_31_11:getPositionX() + var_31_11:getContentSize().width * 0.9, var_31_11:getPositionY()))
		end
	elseif self.initconfig.fight_type == "SUBSTITUTION" then
		var_31_3 = chapter_data[self.mode .. "-" .. self.chapter].combat_limit

		local var_31_16 = array_manager:getBattleArrayData(self.arrayID)

		if chapter_data[self.mode .. "-" .. self.chapter].combat_limit < fight_capacity_manager:getArrayFightCapacity(var_31_16, nil, nil, nil, self.mode) then
			var_31_13:setString(global_trans_bitmapnumber(var_31_3))
		else
			var_31_14:setString(global_trans_bitmapnumber(var_31_3))
		end

		if var_31_3 < fight_capacity_manager:getArrayFightCapacity(var_31_16, nil, nil, nil, self.mode) then
			var_31_11:loadTexture("BossFightPreview/img_recommend_easy.png", var_0_0)
			var_31_13:setPosition(cc.p(var_31_11:getPositionX() + var_31_11:getContentSize().width * 0.9, var_31_11:getPositionY()))
		else
			var_31_11:loadTexture("BossFightPreview/img_recommend_hard.png", var_0_0)
			var_31_14:setPosition(cc.p(var_31_11:getPositionX() + var_31_11:getContentSize().width * 0.9, var_31_11:getPositionY()))
		end
	elseif self.initconfig.fight_type == "EXPLORE" then
		local var_31_17 = explore_manager:getCurFightCapacity()

		if var_31_17 then
			if var_31_3 < var_31_17 then
				var_31_13:setString(global_trans_bitmapnumber(var_31_3))
				var_31_11:loadTexture("BossFightPreview/img_recommend_easy.png", var_0_0)
				var_31_13:setPosition(cc.p(var_31_11:getPositionX() + var_31_11:getContentSize().width * 0.9, var_31_11:getPositionY()))
				var_31_14:setVisible(false)
			else
				var_31_14:setString(global_trans_bitmapnumber(var_31_3))
				var_31_11:loadTexture("BossFightPreview/img_recommend_hard.png", var_0_0)
				var_31_14:setPosition(cc.p(var_31_11:getPositionX() + var_31_11:getContentSize().width * 0.9, var_31_11:getPositionY()))
				var_31_13:setVisible(false)
			end
		else
			var_31_14:setString(global_trans_bitmapnumber(var_31_3))
		end
	else
		local var_31_18 = array_manager:getBattleArrayData(playermodel.curArray)

		var_31_3 = chapter_data[self.mode .. "-" .. self.chapter] and chapter_data[self.mode .. "-" .. self.chapter].boss_combat and chapter_data[self.mode .. "-" .. self.chapter].boss_combat or var_31_3

		if var_31_3 < fight_capacity_manager:getArrayFightCapacity(var_31_18, nil, nil, nil, self.mode) then
			var_31_13:setString(global_trans_bitmapnumber(var_31_3))
		else
			var_31_14:setString(global_trans_bitmapnumber(var_31_3))
		end

		if var_31_3 < fight_capacity_manager:getArrayFightCapacity(var_31_18, nil, nil, nil, self.mode) then
			var_31_11:loadTexture("BossFightPreview/img_recommend_easy.png", var_0_0)
			var_31_13:setPosition(cc.p(var_31_11:getPositionX() + var_31_11:getContentSize().width * 0.9, var_31_11:getPositionY()))
			var_31_14:setVisible(false)
		else
			var_31_11:loadTexture("BossFightPreview/img_recommend_hard.png", var_0_0)
			var_31_14:setPosition(cc.p(var_31_11:getPositionX() + var_31_11:getContentSize().width * 0.9, var_31_11:getPositionY()))
			var_31_13:setVisible(false)
		end
	end

	self.labelTitle:setPositionX(var_31_11:getPositionX())
end

function BossFightPreviewLayer:switchEnemy(arg_34_1)
	if self.enemyID == arg_34_1 then
		return
	end

	self.enemyID = arg_34_1

	for iter_34_0, iter_34_1 in pairs(self.btnEnemys) do
		if iter_34_0 == self.enemyID then
			self.count = self.count + 1

			iter_34_1:getChildByName("Image_58"):setVisible(true)
			self:updateBossOrEnemyInfo(self.enemyID)
			iter_34_1:getChildByName("imageHead"):setScale(0.56)
			iter_34_1:setColor(cc.c3b(255, 255, 255))

			if self.count >= 2 then
				l2utils:shakeNode(self.imageCuteShake, {
					scanlinethreshold = 0.025,
					driftpixel = 0,
					waitframe = 0,
					shakeframe = 12,
					restoreframe = 12,
					scanlinedriftfac = 5
				})
				l2utils:shakeNode(self.imageBossVD, {
					scanlinethreshold = 0.025,
					driftpixel = 0,
					waitframe = 0,
					shakeframe = 12,
					restoreframe = 12,
					scanlinedriftfac = 5
				})
				self.imageBossVD:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
					l2utils:removeNodeShake(self.imageBossVD)
					l2utils:removeNodeShake(self.imageCuteShake)
				end)))
			end

			iter_34_1:getChildByName("Image_58"):setLocalZOrder(999)
		else
			iter_34_1:getChildByName("Image_58"):setVisible(false)
			iter_34_1:getChildByName("imageHead"):setScale(0.42)
			iter_34_1:setColor(cc.c3b(222, 222, 222))
			iter_34_1:getChildByName("Image_58"):setLocalZOrder(1)
		end
	end
end

local function var_0_32(arg_36_0)
	if not arg_36_0 or type(arg_36_0) ~= "string" then
		return nil
	end

	local var_36_0, var_36_1 = arg_36_0:match("(%d+),(%d+)")

	return cc.p(tonumber(var_36_0), tonumber(var_36_1))
end

function BossFightPreviewLayer:updateBossOrEnemyInfo(arg_37_1)
	local var_37_0
	local var_37_1
	local var_37_2

	local function var_37_3(arg_38_0, arg_38_1)
		self.imageDegree:loadTexture(var_0_28[model_data[arg_38_1.modelid].monster_level], var_0_0)
		self.imageCuteShake:setTexture("roleimage/role1/" .. arg_38_1.icon .. ".png")

		if model_data[arg_38_1.modelid].role_image ~= nil then
			self.imageCuteShake:setVisible(false)

			local var_38_0 = "roleimage/role/" .. model_data[arg_38_1.modelid].role_image .. ".png"

			if not model_data[arg_38_1.modelid].role_image then
				var_38_0 = "roleimage/role1/" .. model_data[arg_38_1.modelid].cute_role .. ".png"
			end

			self.imageBossVD:setVisible(true)
			self.imageBossVD:setTexture(var_38_0)
		else
			print("???????????????", arg_38_1.modelid)
			self.imageBossVD:setVisible(false)
			self.imageCuteShake:setVisible(true)
			self.imageCuteShake:setTexture("roleimage/role1/" .. model_data[arg_38_1.modelid].cute_role .. ".png")
			self.imageCuteShake:setScale(model_data[arg_38_1.modelid].boss_cute_preview_scale or 1)

			if model_data[arg_38_1.modelid].bosscutepreviewpos then
				local var_38_1, var_38_2 = model_data[arg_38_1.modelid].bosscutepreviewpos:match("(.+),(.+)")

				self.imageCuteShake:setPosition(tonumber(var_38_1), (tonumber(var_38_2)))
			end

			if model_data[arg_38_1.modelid].bosscutepreviewflip then
				self.imageCuteShake:setFlippedX(model_data[arg_38_1.modelid].bosscutepreviewflip < 0)
			end
		end

		var_37_0 = arg_38_1.modelid

		self.imageBossVD:setPosition(var_0_32(model_data[var_37_0].bosspreviewpos) or cc.p(232, 121))
		self.imageBossVD:setFlippedX(model_data[var_37_0].bosspreviewflip or 0 > 0)

		if var_0_31(arg_38_1.modelid) ~= nil then
			self.imageBossElement:setVisible(true)
			self.imageBossElement:loadTexture(var_0_31(arg_38_1.modelid), var_0_0)
		else
			self.imageBossElement:setVisible(false)
		end

		self.LabelBossName:setString(arg_38_1.name)
		self.LabelLv:setString(arg_38_1.level)

		fightCapacity = self.initconfig.fight_type == "EXPLORE" and global_trans_number(fight_capacity_manager:getExploreEnemyFightCapacity(self.mode, arg_38_1.id)) or self.initconfig.fight_type == "TOWERDEFENCE" and arg_38_0 == 1 and (arg_38_1.fightpower or 99) or global_trans_number(fight_capacity_manager:getEnemyFightCapacity(self.mode, arg_38_1.id))
		var_37_1 = model_data[var_37_0].photofile_model
		var_37_2 = model_data[var_37_0].photofile_type

		self:updateSkill(arg_38_0, arg_38_1.modelid)
	end

	local var_37_4 = 0

	if arg_37_1 == 1 and self.bossTeam.boss then
		var_37_3(arg_37_1, self.bossTeam.boss)

		var_37_4 = self.bossTeam.boss.id
	elseif self.bossTeam.boss then
		var_37_3(arg_37_1, self.bossTeam.monster[arg_37_1 - 1])

		var_37_4 = self.bossTeam.monster[arg_37_1 - 1].id
	elseif self.bossTeam.boss == nil then
		var_37_3(arg_37_1, self.bossTeam.monster[arg_37_1])

		var_37_4 = self.bossTeam.monster[arg_37_1].id
	end

	self:updateHpBar(var_37_4)

	local var_37_5 = {
		id = var_37_1,
		modelid = nil,
		contentType = {
			contentType = photo_manager:getFileType(var_37_2)
		}
	}

	self.PanelMore:addTouchEventListener(function(arg_39_0, arg_39_1)
		if arg_39_1 ~= ccui.TouchEventType.ended then
			return
		end

		if photo_manager:isBigPicture(var_37_2) then
			LayerManager:pushInLayer("PhotoFileRoleFileLayer", var_37_5)
		else
			LayerManager:pushInLayer("PhotoFileHelpGirlLayer", var_37_5)
		end
	end)
end

function BossFightPreviewLayer:updateSkill(arg_40_1, arg_40_2)
	if self.panelAffix then
		for iter_40_0 = 1, #self.panelAffix do
			self.panelAffix[iter_40_0]:removeFromParent()
		end
	end

	self.panelAffix = {}

	if arg_40_1 == 1 and self.bossTeam.boss then
		for iter_40_1 = 1, #self.bossTeam.boss.affix do
			self:loopInitSkill(self.bossTeam.boss, iter_40_1)

			if iter_40_1 == 3 then
				break
			end
		end
	elseif self.bossTeam.boss then
		for iter_40_2 = 1, #self.bossTeam.monster[arg_40_1 - 1].affix do
			self:loopInitSkill(self.bossTeam.monster[arg_40_1 - 1], iter_40_2)

			if iter_40_2 == 3 then
				break
			end
		end
	elseif self.bossTeam.boss == nil then
		for iter_40_3 = 1, #self.bossTeam.monster[arg_40_1].affix do
			self:loopInitSkill(self.bossTeam.monster[arg_40_1], iter_40_3)

			if iter_40_3 == 3 then
				break
			end
		end
	end
end

function BossFightPreviewLayer:inifBossOrEnemyInfo()
	self.imageCute = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_bossCute")

	self.imageCute:setVisible(false)

	self.imageCuteShake = cc.Sprite:create()

	self.imageCuteShake:setPosition(cc.p(self.imageCute:getPositionX(), self.imageCute:getPositionY() + 20))
	self.panelBoss:addChild(self.imageCuteShake, 999)

	self.panelBossVD = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_bossVD")
	self.imageBossElement = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_bossElement")
	self.LabelBossName = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_bossName")
	self.LabelLv = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_lv")
	self.PanelMore = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_more")
	self.panelAttr = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_element")
	self.imageDegree = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_degree")
	self.imageBossVD = cc.Sprite:create()
	self.ImageBossAttr = ccui.ImageView:create()
	self.ImageReBossAttr = ccui.ImageView:create()

	self.ImageBossAttr:setPosition(cc.p(81, 40))
	self.ImageReBossAttr:setPosition(cc.p(81, 40))
	self.panelAttr:addChild(self.ImageBossAttr, 999)
	self.panelAttr:addChild(self.ImageReBossAttr, 999)

	local var_41_0

	if self.bossTeam.boss then
		var_41_0 = self.bossTeam.boss.modelid

		local var_41_1

		if not self.bossTeam.boss.modelid then
			var_41_0 = self.bossTeam.monster[1].modelid
			var_41_1 = var_0_32(model_data[var_41_0].bosspreviewpos) or cc.p(232, 121)
		end
	end

	self.imageBossVD:setPosition(var_41_1)
	self.imageBossVD:setFlippedX(model_data[var_41_0].bosspreviewflip or 0 > 0)
	self.panelBossVD:addChild(self.imageBossVD, 1)
	self.imageBossElement:setScale(1)
	self.panelAttr:addTouchEventListener(function(arg_42_0, arg_42_1)
		local var_42_0

		if arg_42_1 ~= ccui.TouchEventType.ended then
			do return end

			var_42_0 = {}
		end

		var_42_0.tips = {
			"mainScenebg/guide/16.jpg",
			"mainScenebg/guide/23.jpg",
			"mainScenebg/guide/24.jpg",
			"mainScenebg/guide/25.jpg",
			"mainScenebg/guide/26.jpg",
			"mainScenebg/guide/27.jpg",
			"mainScenebg/guide/28.jpg",
			"mainScenebg/guide/29.jpg"
		}

		LayerManager:pushInLayer("TipsLayer", var_42_0)
	end)
	self.imageBossElement:setTouchEnabled(true)
	self.imageBossElement:addTouchEventListener(function(arg_43_0, arg_43_1)
		local var_43_0

		if arg_43_1 ~= ccui.TouchEventType.ended then
			do return end

			var_43_0 = {}
		end

		var_43_0.tips = {
			"mainScenebg/guide/16.jpg",
			"mainScenebg/guide/23.jpg",
			"mainScenebg/guide/24.jpg",
			"mainScenebg/guide/25.jpg",
			"mainScenebg/guide/26.jpg",
			"mainScenebg/guide/27.jpg",
			"mainScenebg/guide/28.jpg",
			"mainScenebg/guide/29.jpg"
		}

		LayerManager:pushInLayer("TipsLayer", var_43_0)
	end)
end

function BossFightPreviewLayer:initSkill()
	self.emenyAffix = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_affix")
	self.emenyAffixPosX = self.emenyAffix:getPositionX()
	self.emenyAffixPosY = self.emenyAffix:getPositionY()

	self.emenyAffix:retain()
	self.emenyAffix:removeFromParent()

	self.panelAffix = {}
end

function BossFightPreviewLayer:loopInitSkill(arg_45_1, arg_45_2)
	local var_45_0 = self.emenyAffix:clone()
	local var_45_1 = cc.Label:createWithTTF(arg_45_1.affix[arg_45_2].name, "fonts/name.ttf", 22)
	local var_45_2 = ccui.ImageView:create("BossFightPreview/frame_skill.png", var_0_0)

	var_45_2:setPosition(cc.p(var_45_0:getContentSize().width / 2, var_45_0:getContentSize().height / 2 - 10))
	var_45_0:addChild(var_45_2, 999)
	var_45_1:setColor(cc.c3b(168, 185, 198))

	local var_45_4 = ccui.ImageView:create("skill_new/fight_boss_skill_frame.png", var_0_0)

	var_45_4:setScale(1.26)
	var_45_4:setPosition(cc.p(var_45_0:getContentSize().width / 2, var_45_0:getContentSize().height / 2))
	var_45_0:addChild(var_45_4, 999)

	local var_45_5 = ccui.Button:create("skill_new/skill/" .. arg_45_1.affix[arg_45_2].icon .. ".png", "skill_new/skill/" .. arg_45_1.affix[arg_45_2].icon .. ".png", nil, var_0_0)

	var_45_0:addChild(var_45_5, 999)
	var_45_1:setPosition(cc.p(var_45_0:getContentSize().width / 2, var_45_0:getContentSize().height / 2 - 40))
	var_45_0:setPosition(cc.p(self.emenyAffixPosX, self.emenyAffixPosY - 80 * (arg_45_2 - 1)))
	var_45_5:setScale(0.56)
	var_45_5:setPosition(cc.p(var_45_0:getContentSize().width / 2, var_45_0:getContentSize().height / 2))
	var_45_0:addChild(var_45_1, 999)
	var_45_5:addTouchEventListener(function(arg_46_0, arg_46_1)
		if arg_46_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:skillDesc(arg_45_1.affix[arg_45_2].id, var_45_0:getPositionY())
	end)
	self.PanelBossInfo:addChild(var_45_0, 999)

	self.panelAffix[arg_45_2] = var_45_0
end

function BossFightPreviewLayer:skillDesc(arg_47_1, arg_47_2)
	self.layerSkill = ccui.Layout:create()

	self.layerSkill:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.layerSkill:setBackGroundColor(cc.c3b(0, 0, 0))
	self.layerSkill:setAnchorPoint(cc.p(0, 0.5))
	self.layerSkill:setBackGroundColorOpacity(180)
	self.layerSkill:setPosition(cc.p(-350, arg_47_2))
	self.layerSkill:setCascadeOpacityEnabled(false)
	self.PanelBossInfo:addChild(self.layerSkill, 9999999)

	local var_47_0 = cc.Label:createWithTTF(var_0_10[arg_47_1].name, "fonts/number.ttf", 20)

	var_47_0:setColor(cc.c3b(253, 211, 81))
	var_47_0:setAnchorPoint(cc.p(0, 1))
	self.layerSkill:addChild(var_47_0, 999)

	local var_47_1 = cc.Label:createWithTTF(var_0_10[arg_47_1].description, "fonts/number.ttf", 18)

	var_47_1:setColor(cc.c3b(234, 232, 226))
	var_47_1:setAnchorPoint(cc.p(0, 1))
	var_47_1:setWidth(170)
	self.layerSkill:setContentSize(cc.size(190, var_47_1:getContentSize().height + 60))

	local var_47_2 = self.layerSkill:getContentSize().height

	var_47_0:setPosition(cc.p(10, var_47_2))
	var_47_1:setPosition(cc.p(10, var_47_2 - var_47_0:getContentSize().height))
	self.layerSkill:addChild(var_47_1, 999)

	local var_47_3 = cc.EventListenerTouchOneByOne:create()

	var_47_3:setSwallowTouches(false)
	var_47_3:registerScriptHandler(function(arg_48_0, arg_48_1)
		if self.layerSkill then
			self.layerSkill:removeFromParent()
		end

		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_47_3:registerScriptHandler(function(arg_49_0, arg_49_1)
		if self.layerSkill then
			self.layerSkill:removeFromParent()
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_47_3, self.layerSkill)
end

function BossFightPreviewLayer:initSubUI()
	ccui.Helper:seekWidgetByName(self.rootlayer, "Image_9"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_element"):setVisible(false)

	local var_50_0 = ccui.ImageView:create("BossFightPreview/title_substitution.png", var_0_0)

	var_50_0:setAnchorPoint(cc.p(0, 0))
	var_50_0:setPosition(cc.p(-50, self.panelAll:getContentSize().height - 130))
	self.panelAll:addChild(var_50_0)

	local var_50_1 = ccui.Button:create("BossFightPreview/sub_detail.png", "BossFightPreview/sub_detail.png", "BossFightPreview/sub_detail.png", var_0_0)

	var_50_1:setAnchorPoint(cc.p(0, 0))
	var_50_1:setPosition(cc.p(var_50_0:getPositionX() + var_50_0:getContentSize().width - 70, var_50_0:getPositionY() + 50))
	self.panelAll:addChild(var_50_1)

	local var_50_2 = ccui.Button:create("BossFightPreview/sub_shop.png", "BossFightPreview/sub_shop.png", "BossFightPreview/sub_shop.png", var_0_0)

	var_50_2:setAnchorPoint(cc.p(1, 0))
	var_50_2:setPosition(cc.p(self.panelAll:getContentSize().width, self.panelAll:getContentSize().height - 85))
	self.panelAll:addChild(var_50_2)
	var_50_1:addTouchEventListener(function(arg_51_0, arg_51_1)
		if arg_51_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("显示活动信息")

		local var_51_0 = {}

		var_51_0.key = "substitution"

		LayerManager:pushInLayer("PopActivityDetail", var_51_0)
	end)
	var_50_2:addTouchEventListener(function(arg_52_0, arg_52_1)
		if arg_52_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("商店GoGoGoooooo")
		arg_52_0:setTouchEnabled(false)

		local var_52_0 = cc.EventCustom:new("switchShowLayer")

		var_52_0.layerName = "MarketLayer"
		var_52_0.initparam = {
			singleMarket = "1-18",
			returnLayer = "AdventureLayer"
		}

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_52_0)
	end)
end

local function var_0_33(arg_53_0)
	return global_get_model_attr(arg_53_0)
end

local function var_0_34(arg_54_0)
	local var_54_0 = {}

	var_54_0.name = model_data[arg_54_0.modelid].main_name or model_data[arg_54_0.modelid].name
	var_54_0.icon = model_data[arg_54_0.modelid].cute_role
	var_54_0.quality = model_data[arg_54_0.modelid].monster_level
	var_54_0.level = arg_54_0.level or "?"
	var_54_0.modelid = arg_54_0.modelid
	var_54_0.id = arg_54_0.id
	var_54_0.attr = var_0_33(arg_54_0.modelid)

	local var_54_1 = horcrux_manager:getMonsterHorcruxAssistConfig(arg_54_0)

	var_54_0.affix = {}

	if var_54_1 then
		for iter_54_0, iter_54_1 in ipairs(var_54_1.skills) do
			var_54_0.affix[iter_54_0] = {
				id = iter_54_1,
				name = total_skill_data[iter_54_1].name,
				des = string.format("%s。", total_skill_data[iter_54_1].description),
				icon = total_skill_data[iter_54_1].icon
			}
		end
	end

	return var_54_0
end

function BossFightPreviewLayer:GetBossOrEnemyInfo()
	local var_55_0 = level_manager:isMainChapterOrFeederChapter(self.mode) and monster_manager.getChapterBigBossAll(self.mode, self.mode .. "-" .. self.chapter) or self.initconfig.fight_type == "EXPLORE" and explore_manager:initBossListInfo(self.chapter .. "-" .. self.level) or monster_manager.getLevelBossAll(self.mode, self.chapter .. "-" .. self.level)
	local var_55_1 = {}

	if var_55_0.boss then
		var_55_1.boss = var_0_34(var_55_0.boss.majorlist)
	end

	if var_55_0.monster and next(var_55_0.monster) then
		var_55_1.monster = {}

		for iter_55_0, iter_55_1 in ipairs(var_55_0.monster) do
			table.insert(var_55_1.monster, var_0_34(iter_55_1.majorlist))
		end
	end

	if self.initconfig.fight_type == "TOWERDEFENCE" then
		var_55_1.boss = var_0_34(tower_defence_manager:getEnemyBaseConf(self.mode, self.chapter)[1].majorlist)
	end

	return var_55_1
end

function BossFightPreviewLayer:initBg(arg_56_1)
	local var_56_0 = ccui.Layout:create()

	var_56_0:setTouchEnabled(true)
	var_56_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_56_0:setAnchorPoint(cc.p(0, 0))
	var_56_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_56_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_56_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_56_0:setOpacity(0)
	self:addChild(var_56_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_57_0)
		self:addChild(arg_57_0, -2)
		arg_57_0:setPositionY(arg_57_0:getPositionY() - GameDisplay.fix_y)

		local var_57_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_57_0:setAnchorPoint(cc.p(0, 0))
		var_57_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_57_0, -1)
		self:init(arg_56_1, initInfo)
		var_56_0:setOpacity(102)
		var_56_0:setTouchEnabled(false)
	end)
end

function BossFightPreviewLayer:exit()
	if self.initconfig.cancelcallback then
		self.initconfig.cancelcallback()
	end

	LayerManager:removePopLayer()
end
