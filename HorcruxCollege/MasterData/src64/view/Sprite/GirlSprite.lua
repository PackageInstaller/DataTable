local major_factor_data = require("data.major_factor_data")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local core_data = require("data.core_data")
local npc_data = require("data.npc_data")
local servants_reddot_show_data = require("data.servants_reddot_show_data")
local core_manager = require("controller.core_manager")
local component_manager = require("controller.component_manager")
local model_manager = require("controller.model_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local marry_manager = require("controller.marry_manager")
local weapon_manager = require("controller.weapon_manager")
local explore_manager = require("controller.explore_manager")
local souls_manager = require("controller.souls_manager")
local role_false_level_manager = require("controller.role_false_level_manager")
local help_battle_manager = require("controller/help_battle/help_battle_manager")
local var_0_16 = help_battle_manager:getInstance()
local var_0_17 = require("controller/help_battle/help_battle_formation_manager").getInstance(help_battle_manager)
local playermodel = require("model.playermodel")
local var_0_19 = config._DEBUG and 0 or 1

GirlSprite = class("GirlSprite", function()
	return ccui.Button:create("public/rolebg/frame_rarity_3.png", "public/rolebg/frame_rarity_3.png", "public/rolebg/frame_rarity_3.png", var_0_19)
end)

function GirlSprite:getModelid(...)
	return self.modelid
end

function GirlSprite.create(arg_3_0, arg_3_1)
	local var_3_0
	local var_3_1 = {
		arrayStyle = function()
			var_3_0 = GrilArraySprite.new()

			var_3_0:init(arg_3_1)
		end,
		patrolStyle = function()
			var_3_0 = GrilPatrolSprite.new()

			var_3_0:init(arg_3_1)
			var_3_0:initPatrolStyle()
		end,
		formationStype = function(...)
			var_3_0 = FormationSprite.new()

			var_3_0:init(arg_3_1)
		end,
		enemyStyle = function()
			var_3_0 = GrilArenaEnemySprite.new()

			var_3_0:init(arg_3_1)
		end,
		subArrayStyle = function()
			var_3_0 = SubGrilArraySprite.new()

			var_3_0:init(arg_3_1)
		end,
		girlSelectLayerStype = function(...)
			var_3_0 = GirlSelectLayerStype.new()

			var_3_0:init(arg_3_1)
		end,
		dormitoryStype = function(...)
			var_3_0 = DormitorySprite.new()

			var_3_0:init()
		end,
		enemyFormationStyle = function()
			var_3_0 = GrilArenaEnemyFormationSprite.new()

			var_3_0:init(arg_3_1)
		end,
		girlSelectTestFightStype = function()
			var_3_0 = girlSelectTestFightSprite.new()

			var_3_0:init(arg_3_1)
		end,
		helpBattleStyle = function(...)
			var_3_0 = HelpBattleSprite.new()

			var_3_0:init(arg_3_1)
		end,
		girlSelectAutoChess = function()
			var_3_0 = girlSelectAutoChessSprite.new()

			var_3_0:init(arg_3_1)
		end
	}

	if arg_3_1 and var_3_1[arg_3_1.initType] then
		var_3_1[arg_3_1.initType]()

		var_3_0.initType = arg_3_1.initType
	else
		var_3_0 = GirlSprite.new()
	end

	return var_3_0
end

function GirlSprite.getAttrIconPath(arg_15_0, arg_15_1)
	local var_15_0 = global_get_all_model_attrs(servant_data[arg_15_1].modelid)
	local var_15_1 = var_15_0.main

	if var_15_0.sub and next(var_15_0.sub) then
		for iter_15_0, iter_15_1 in ipairs(var_15_0.sub) do
			var_15_1 = var_15_1 .. "_" .. iter_15_1
		end
	end

	return var_15_1
end

local function var_0_20(arg_16_0)
	local var_16_0 = global_get_all_model_attrs(servant_data[arg_16_0].modelid)
	local var_16_1 = var_16_0.main

	if var_16_0.sub and next(var_16_0.sub) then
		for iter_16_0, iter_16_1 in ipairs(var_16_0.sub) do
			var_16_1 = var_16_1 .. "_" .. iter_16_1
		end
	end

	return var_16_1
end

GrilArraySprite = class("GrilArraySprite", function()
	return GirlSprite.new()
end)

local var_0_21 = {
	HEADIMG = 2,
	INFO = 4,
	PRESSBAR = 101
}

function GirlSprite:init(arg_18_1)
	self:loadTextures("public/rolebg/frame_rarity_3.png", "public/rolebg/frame_rarity_3.png", "public/rolebg/frame_rarity_3.png", var_0_19)

	self.scale = 0.8
	self.clipSize = cc.size(128, 228)
	self.clipPanel = ccui.Layout:create()

	self.clipPanel:setContentSize(self.clipSize)
	self.clipPanel:setAnchorPoint(cc.p(0, 0))
	self.clipPanel:setPosition(cc.p(6, 6))
	self.clipPanel:setClippingEnabled(true)
	self:addChild(self.clipPanel, var_0_21.HEADIMG)

	local var_18_0 = ccui.ImageView:create("GUI/image.png", var_0_19)

	var_18_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_18_0:setPosition(cc.p(self.clipSize.width / 2, 24))
	var_18_0:setScale(self.scale)
	var_18_0:setName("girlHeadImg")
	self.clipPanel:addChild(var_18_0, var_0_21.HEADIMG)

	local var_18_1 = ccui.ImageView:create(SHOT_RARITY_CION[1], var_0_19)

	var_18_1:setAnchorPoint(cc.p(1, 1))
	var_18_1:setPosition(cc.p(self:getContentSize().width + 5, self:getContentSize().height + 2))
	var_18_1:setName("rarityIcon")
	var_18_1:setScale(0.9)
	self:addChild(var_18_1, var_0_21.INFO)

	local var_18_2 = ccui.ImageView:create("public/rolebg/breakout_0.png", var_0_19)

	var_18_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_18_2:setPosition(cc.p(self:getContentSize().width - var_18_2:getContentSize().width / 2 * 0.5 - 4, 34))
	var_18_2:setName("breakoutIcon")
	var_18_2:setScale(0.5)
	self:addChild(var_18_2, var_0_21.INFO)

	local var_18_3 = ccui.ImageView:create("public/rolebg/break_servant_limit_num_bg.png", var_0_19)

	var_18_3:setAnchorPoint(cc.p(0, 0))
	var_18_3:setPosition(0, 0)
	var_18_3:setName("nameBg")
	self.clipPanel:addChild(var_18_3, var_0_21.INFO)

	local var_18_4 = ccui.Text:create("", FONT_DES, 18)

	var_18_4:setColor(cc.c3b(234, 238, 245))
	var_18_4:setAnchorPoint(cc.p(1, 0.5))
	var_18_4:setPosition(cc.p(self:getContentSize().width - 36, 34))
	var_18_4:setName("lvLabel")
	self:addChild(var_18_4, var_0_21.INFO)

	local var_18_5 = ccui.ImageView:create("public/rolebg/img_lv.png", var_0_19)

	var_18_5:setPositionX(var_18_4:getPositionX() - var_18_4:getContentSize().width - 12)
	var_18_5:setPositionY(14)
	var_18_5:setName("lvIcon")
	var_18_5:setVisible(false)
	self:addChild(var_18_5, 6)

	local var_18_6 = ccui.ImageView:create(CAREER_ICON.assassin_dark, var_0_19)

	var_18_6:setPositionX(var_18_6:getContentSize().width / 2 * 0.56 + 4)
	var_18_6:setPositionY(var_18_6:getContentSize().height / 2 * 0.56 + 4)
	var_18_6:setScale(0.45)
	var_18_6:setName("careerIcon")
	self:addChild(var_18_6, var_0_21.INFO)

	local var_18_7 = ccui.ImageView:create("public/rolebg/+1.png", var_0_19)

	var_18_7:setScale(0.6)
	var_18_7:setAnchorPoint(cc.p(0.5, 0.5))
	var_18_7:setPositionX(var_18_7:getContentSize().width / 2 + 2)
	var_18_7:setPositionY(self:getContentSize().height - var_18_7:getContentSize().height / 2 + 2)
	var_18_7:setName("classNum")
	self:addChild(var_18_7, var_0_21.INFO)

	local var_18_8 = cc.Label:createWithTTF("", FONT_NAME, 18)

	var_18_8:setName("nameLabel")
	var_18_8:setAnchorPoint(cc.p(1, 0.5))
	var_18_8:setPosition(cc.p(self:getContentSize().width - 8, 16))
	self:addChild(var_18_8, var_0_21.INFO)

	if arg_18_1 and arg_18_1.isHpInherit then
		self:createHpBar(arg_18_1)
	end
end

function GirlSprite:createHpBar(arg_19_1)
	if config._DEBUG then
		self.sprBg = cc.Sprite:create("fight/hp_bg_inherit_4.png") or cc.Sprite:createWithSpriteFrameName("fight/hp_bg_inherit_4.png")
	end

	self.sprBg:setAnchorPoint(cc.p(0, 0.5))
	self.sprBg:setPosition(cc.p(5, 12))
	self:addChild(self.sprBg, var_0_21.INFO)

	self.progressTimer = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("fight/hp_bar_inherit_4.png") or cc.Sprite:createWithSpriteFrameName("fight/hp_bar_inherit_4.png")))

	self:addChild(self.progressTimer, var_0_21.INFO)
	self.progressTimer:setAnchorPoint(cc.p(0, 0.5))
	self.progressTimer:setPosition(cc.p(7, 12))
	self.progressTimer:setMidpoint(cc.p(0, 0.5))
	self.progressTimer:setBarChangeRate(cc.p(1, 0))
	self.progressTimer:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.progressTimer:setPercentage(100)

	local var_19_0 = self.progressTimer:getContentSize().width

	self.labelHp = cc.Label:createWithTTF("100%", "fonts/new1.ttf", 13)

	self.labelHp:setAnchorPoint(cc.p(1, 0.5))
	self.labelHp:setPosition(cc.p(self.progressTimer:getContentSize().width, 6))
	self.labelHp:setAlignment(cc.TEXT_ALIGNMENT_RIGHT, cc.TEXT_ALIGNMENT_CENTER)
	self.labelHp:enableOutline(cc.c4b(255, 255, 255, 220), 1)
	self.progressTimer:addChild(self.labelHp)
	self.labelHp:setVisible(false)
	self:adjustElementPositionY(14)
end

function GirlSprite:adjustElementPositionY(arg_20_1)
	if self.diff == arg_20_1 then
		return
	end

	self.diff = arg_20_1

	local var_20_0 = {}

	var_20_0[#var_20_0 + 1] = self:getChildByName("lvLabel")
	var_20_0[#var_20_0 + 1] = self:getChildByName("nameLabel")
	var_20_0[#var_20_0 + 1] = self.clipPanel:getChildByName("nameBg")
	var_20_0[#var_20_0 + 1] = self:getChildByName("lvIcon")
	var_20_0[#var_20_0 + 1] = self:getChildByName("careerIcon")
	var_20_0[#var_20_0 + 1] = self:getChildByName("breakoutIcon")

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		if iter_20_1 then
			iter_20_1:setPositionY(iter_20_1:getPositionY() + arg_20_1)
		end
	end
end

function GirlSprite:showHpBar(arg_21_1)
	if not self.progressTimer or not self.labelHp or not self.sprBg then
		return
	end

	self.progressTimer:setVisible(true)
	self.labelHp:setVisible(true)
	self.sprBg:setVisible(true)
	self:adjustElementPositionY(14)

	local var_21_0 = explore_manager:getHpInherit(arg_21_1)

	self.progressTimer:setPercentage(var_21_0 * 100)
	self.labelHp:setString(math.round(var_21_0 * 100) .. "%")
end

function GrilArraySprite:imgScaleTo(arg_22_1, arg_22_2)
	self.clipPanel:getChildByName("girlHeadImg"):runAction(cc.ScaleTo:create(arg_22_2, self.scale * arg_22_1, self.scale * arg_22_1))
end

function GrilArraySprite:update(arg_23_1)
	self.servantid = arg_23_1

	local var_23_0 = core_manager:getServantCoreRank(arg_23_1)
	local var_23_1 = self:getChildByName("lvLabel")
	local var_23_2 = 1

	var_23_2 = self._getGirlServantRollFunc and self._getGirlServantRollFunc(arg_23_1) or souls_manager:get_servant_cur_roll_rarity(arg_23_1)

	local var_23_3 = global_get_servant_skin(arg_23_1)

	self:loadTextures("public/rolebg/frame_rarity_" .. var_23_2 .. ".png", nil, nil, var_0_19)

	local var_23_4 = self.clipPanel:getChildByName("girlHeadImg")

	var_23_4:loadTexture("roleimage/role/shop_image/" .. model_data[var_23_3].role_image .. ".png")
	var_23_4:setAnchorPoint(cc.p(0.5, self.clipSize.height / 370 / 2))
	var_23_1:setString("" .. core_manager:getCoreLv(arg_23_1))
	var_23_1:setFontSize(18)
	var_23_1:setColor(cc.c3b(255, 255, 255))
	self:getChildByName("rarityIcon"):loadTexture(SHOT_RARITY_CION[var_23_2], var_0_19)
	self:getChildByName("breakoutIcon"):loadTexture("public/rolebg/breakout_" .. var_23_0 .. ".png", var_0_19)
	self:getChildByName("careerIcon"):loadTexture(CAREER_ICON[servant_data[arg_23_1].career .. "_" .. self:getAttrIconPath(arg_23_1)], var_0_19)

	local var_23_5 = playermodel.soulOverClock[arg_23_1] or 0

	if playermodel.soulContract[arg_23_1] > 0 and var_23_5 == 0 then
		self:getChildByName("classNum"):setVisible(true)
		self:getChildByName("classNum"):loadTexture("public/rolebg/+" .. playermodel.soulContract[arg_23_1] .. ".png", var_0_19)
	elseif var_23_5 > 0 then
		self:getChildByName("classNum"):setVisible(true)
		self:getChildByName("classNum"):loadTexture("public/rolebg/oc.png", var_0_19)
	else
		self:getChildByName("classNum"):setVisible(false)
	end

	self:getChildByName("lvIcon"):setPositionX(var_23_1:getPositionX() - var_23_1:getContentSize().width - 12)
	self:getChildByName("nameLabel"):setString(major_factor_data[servant_data[arg_23_1].major].easy_name)
	self:showHpBar(arg_23_1)
end

function GrilArraySprite:updateByFalseLevel(arg_24_1, arg_24_2, arg_24_3)
	if arg_24_2 == core_manager:getServantCoreRank(arg_24_1) and playermodel.cores[arg_24_1].level == arg_24_3 then
		self:stopFalseLevelAni()
	else
		self:getChildByName("breakoutIcon"):loadTexture("public/rolebg/breakout_" .. arg_24_2 .. ".png", var_0_19)

		local var_24_0 = self:getChildByName("lvLabel")

		var_24_0:setColor(cc.c3b(206, 255, 167))
		var_24_0:setFontSize(18)
		var_24_0:setString("" .. arg_24_3)

		local var_24_1 = true

		var_24_0:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(2), cc.CallFunc:create(function(...)
			if var_24_1 then
				var_24_0:setFontSize(12)
				var_24_0:setString("等级固定中")
			else
				var_24_0:setFontSize(18)
				var_24_0:setString("" .. arg_24_3)
			end

			var_24_1 = not var_24_1
		end), cc.FadeIn:create(2))))
		self:getChildByName("breakoutIcon"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(2), cc.CallFunc:create(function(...)
			return
		end), cc.FadeIn:create(2))))
	end
end

function GrilArraySprite:stopFalseLevelAni()
	if not self.servantid then
		return
	end

	local var_27_0 = core_manager:getServantCoreRank(self.servantid)

	self:getChildByName("breakoutIcon"):stopAllActions()
	self:getChildByName("lvLabel"):stopAllActions()
	self:getChildByName("breakoutIcon"):setOpacity(255)
	self:getChildByName("breakoutIcon"):loadTexture("public/rolebg/breakout_" .. var_27_0 .. ".png", var_0_19)
	self:getChildByName("lvLabel"):setOpacity(255)
	self:getChildByName("lvLabel"):setFontSize(18)
	self:getChildByName("lvLabel"):setString("" .. core_manager:getCoreLv(self.servantid))
	self:getChildByName("lvLabel"):setColor(cc.c3b(234, 238, 245))
end

function GrilArraySprite:startPressBar(arg_28_1, arg_28_2, arg_28_3)
	if not self.pressBar then
		self:createPressBar()
	end

	local var_28_0 = arg_28_3 or 0.3
	local var_28_1 = 0

	self.pressBar:setVisible(true)
	self.pressBar:setPercentage(0)
	self.pressBar:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
		self.pressBar:setPercentage(var_28_1 / var_28_0 * 100)

		if var_28_1 > var_28_0 then
			self.pressBar:stopAllActions()

			if arg_28_1 then
				arg_28_1()
			end
		end

		var_28_1 = var_28_1 + 0.016666666666666666

		if arg_28_2 then
			arg_28_2(0.016666666666666666)
		end
	end))))
end

function GrilArraySprite:endPressBar()
	if not self.pressBar then
		return
	end

	self.pressBar:setVisible(false)
	self.pressBar:stopAllActions()
end

function GrilArraySprite:createPressBar()
	self.pressBar = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("public/button/press_bar.png") or cc.Sprite:createWithSpriteFrameName("public/button/press_bar.png")))

	self.pressBar:setScale(0.8)
	self.pressBar:setAnchorPoint(cc.p(0.5, 0.5))
	self.pressBar:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
	self.pressBar:setPositionX(self:getContentSize().width / 2)
	self.pressBar:setPositionY(self:getContentSize().height / 2)
	self.pressBar:setReverseDirection(true)
	self:addChild(self.pressBar, var_0_21.PRESSBAR)
end

function GrilArraySprite.setGetGirlServantRollFunc(arg_32_0, arg_32_1)
	arg_32_0._getGirlServantRollFunc = arg_32_1
end

SubGrilArraySprite = class("SubGrilArraySprite", function()
	return GrilArraySprite.new()
end)

function SubGrilArraySprite:updateSub(arg_34_1)
	local var_34_0 = self:getChildByName("lvLabel")
	local var_34_1 = souls_manager:get_servant_cur_roll_rarity(arg_34_1.servantid, arg_34_1.addRollRarity)
	local var_34_2 = arg_34_1.modelid and tostring(arg_34_1.modelid) or global_get_servant_skin(arg_34_1.servantid, arg_34_1.servantskin)

	self:loadTextures("public/rolebg/frame_rarity_" .. var_34_1 .. ".png", nil, nil, var_0_19)

	local var_34_3 = self.clipPanel:getChildByName("girlHeadImg")

	var_34_3:loadTexture("roleimage/role/shop_image/" .. model_data[var_34_2].role_image .. ".png")
	var_34_3:setAnchorPoint(cc.p(0.5, self.clipSize.height / 370 / 2))
	var_34_0:setString("" .. core_manager:getCoreLv(arg_34_1.servantid))
	self:getChildByName("rarityIcon"):loadTexture(SHOT_RARITY_CION[var_34_1], var_0_19)
	self:getChildByName("breakoutIcon"):loadTexture("public/rolebg/breakout_" .. arg_34_1.servantrank .. ".png", var_0_19)
	self:getChildByName("careerIcon"):loadTexture(CAREER_ICON[servant_data[arg_34_1.servantid].career .. "_" .. self:getAttrIconPath(arg_34_1.servantid)], var_0_19)

	local var_34_5 = arg_34_1.contract or 0
	local var_34_6 = arg_34_1.overclock or 0

	if var_34_5 > 0 and var_34_6 == 0 then
		self:getChildByName("classNum"):setVisible(true)
		self:getChildByName("classNum"):loadTexture("public/rolebg/+" .. var_34_5 .. ".png", var_0_19)
	elseif var_34_6 > 0 then
		self:getChildByName("classNum"):setVisible(true)
		self:getChildByName("classNum"):loadTexture("public/rolebg/oc.png", var_0_19)
	else
		self:getChildByName("classNum"):setVisible(false)
	end

	self:getChildByName("lvIcon"):setPositionX(var_34_0:getPositionX() - var_34_0:getContentSize().width - 12)
	print("????????", dump(arg_34_1))
	self:getChildByName("nameLabel"):setString(major_factor_data[servant_data[arg_34_1.servantid].major].easy_name)
end

function SubGrilArraySprite:update(arg_35_1)
	self.servantid = arg_35_1

	local var_35_0 = self:getChildByName("lvLabel")
	local var_35_1 = souls_manager:get_servant_cur_roll_rarity(arg_35_1)

	self:loadTextures("public/rolebg/frame_rarity_" .. var_35_1 .. ".png", nil, nil, var_0_19)

	local var_35_2 = self.clipPanel:getChildByName("girlHeadImg")

	var_35_2:loadTexture("roleimage/role/shop_image/" .. model_data[global_get_servant_skin(arg_35_1)].role_image .. ".png")
	var_35_2:setAnchorPoint(cc.p(0.5, self.clipSize.height / 370 / 2))
	var_35_0:setString(core_manager:getCoreLv(arg_35_1))
	self:getChildByName("rarityIcon"):loadTexture(SHOT_RARITY_CION[var_35_1], var_0_19)
	self:getChildByName("breakoutIcon"):loadTexture("public/rolebg/breakout_" .. core_manager:getServantCoreRank(arg_35_1) .. ".png", var_0_19)
	self:getChildByName("careerIcon"):loadTexture(CAREER_ICON[servant_data[arg_35_1].career .. "_" .. self:getAttrIconPath(arg_35_1)], var_0_19)

	local var_35_3 = playermodel.soulOverClock[arg_35_1] or 0

	if playermodel.soulContract[arg_35_1] > 0 and var_35_3 == 0 then
		self:getChildByName("classNum"):setVisible(true)
		self:getChildByName("classNum"):loadTexture("public/rolebg/+" .. playermodel.soulContract[arg_35_1] .. ".png", var_0_19)
	elseif var_35_3 > 0 then
		self:getChildByName("classNum"):setVisible(true)
		self:getChildByName("classNum"):loadTexture("public/rolebg/oc.png", var_0_19)
	else
		self:getChildByName("classNum"):setVisible(false)
	end

	self:getChildByName("lvIcon"):setPositionX(var_35_0:getPositionX() - var_35_0:getContentSize().width - 12)
	self:getChildByName("nameLabel"):setString(major_factor_data[servant_data[arg_35_1].major].easy_name)
	self:showHpBar(arg_35_1)
end

function SubGrilArraySprite:stopFalseLevelAni()
	if not self.servantid then
		return
	end

	local var_36_0 = core_manager:getServantCoreRank(self.servantid)

	self:getChildByName("breakoutIcon"):stopAllActions()
	self:getChildByName("lvLabel"):stopAllActions()
	self:getChildByName("lvLabel"):setFontSize(18)
	self:getChildByName("breakoutIcon"):setOpacity(255)
	self:getChildByName("breakoutIcon"):loadTexture("public/rolebg/breakout_" .. var_36_0 .. ".png", var_0_19)
	self:getChildByName("lvLabel"):setOpacity(255)
	self:getChildByName("lvLabel"):setString("" .. core_manager:getCoreLv(self.servantid))
	self:getChildByName("lvLabel"):setColor(cc.c3b(234, 238, 245))
end

GrilPatrolSprite = class("GrilPatrolSprite", function()
	return GrilArraySprite.new()
end)

function GrilPatrolSprite:initPatrolStyle()
	local var_38_0 = self:getChildByName("classNum")

	var_38_0:setPositionX(var_38_0:getContentSize().width / 2 + 8)
	var_38_0:setPositionY(self:getContentSize().height - var_38_0:getContentSize().height / 2 - 8)
end

GrilArenaEnemySprite = class("GrilArenaEnemySprite", function()
	return GrilArraySprite.new()
end)

function GrilArenaEnemySprite:update(arg_40_1, arg_40_2)
	local var_40_0 = arg_40_1.level
	local var_40_1 = arg_40_1.contract
	local var_40_2 = arg_40_1.rank
	local var_40_3 = arg_40_1.overclock or arg_40_1.soulOC or 0
	local var_40_4
	local var_40_5
	local var_40_6
	local var_40_7

	if arg_40_1.servantId then
		var_40_4 = global_get_servant_skin(arg_40_1.servantId, arg_40_1.servantskin or -1)
		var_40_5 = souls_manager:get_servant_cur_roll_rarity(arg_40_1.servantId, arg_40_1.addRollRarity)
		var_40_6 = CAREER_ICON[servant_data[arg_40_1.servantId].career .. "_" .. self:getAttrIconPath(arg_40_1.servantId)]
		var_40_7 = major_factor_data[servant_data[arg_40_1.servantId].major].easy_name
	elseif arg_40_1.npcsoulid then
		var_40_4 = npc_data[arg_40_1.npcsoulid].model

		if not npc_data[arg_40_1.npcsoulid].roll_rarity then
			::label_40_0::

			var_40_5 = 1
		end

		var_40_6 = CAREER_ICON[npc_data[arg_40_1.npcsoulid].career .. "_" .. global_get_model_attr(var_40_4)]
		var_40_7 = npc_data[arg_40_1.npcsoulid].easy_name
	end

	local var_40_8 = self.clipPanel:getChildByName("girlHeadImg")

	var_40_8:loadTexture("roleimage/role/shop_image/" .. model_data[var_40_4].role_image .. ".png")
	var_40_8:setAnchorPoint(cc.p(0.5, self.clipSize.height / 370 / 2))
	self:getChildByName("breakoutIcon"):loadTexture("public/rolebg/breakout_" .. var_40_2 .. ".png", var_0_19)
	self:getChildByName("lvLabel"):setString("" .. var_40_0)
	self:getChildByName("rarityIcon"):loadTexture(SHOT_RARITY_CION[var_40_5], var_0_19)
	self:loadTextures("public/rolebg/frame_rarity_" .. var_40_5 .. ".png", nil, nil, var_0_19)

	local var_40_9 = self:getChildByName("classNum")

	var_40_9:setPositionX(var_40_9:getContentSize().width / 2 + 8)
	var_40_9:setPositionY(self:getContentSize().height - var_40_9:getContentSize().height / 2)
	self:getChildByName("careerIcon"):loadTexture(var_40_6, var_0_19)

	if var_40_1 > 0 and var_40_3 == 0 then
		var_40_9:setVisible(true)
		var_40_9:loadTexture("public/rolebg/+" .. var_40_1 .. ".png", var_0_19)
	elseif var_40_3 > 0 then
		var_40_9:setVisible(true)
		var_40_9:loadTexture("public/rolebg/oc.png", var_0_19)
	elseif var_40_3 > 0 then
		var_40_9:setVisible(true)
		var_40_9:loadTexture("public/rolebg/oc.png", var_0_19)
	else
		var_40_9:setVisible(false)
	end

	self:getChildByName("lvIcon"):setPositionX(self:getChildByName("lvLabel"):getPositionX() - self:getChildByName("lvLabel"):getContentSize().width - 12)
	self:getChildByName("nameLabel"):setString(var_40_7)
	self:showHpBar(arg_40_2 or arg_40_1.servantId)
end

GirlSelectLayerStype = class("GirlSelectLayerStype", function()
	local var_41_0 = GirlSprite.new()

	var_41_0:loadTextures("public/rolebg/girlselect_frame.png", "public/rolebg/girlselect_frame.png", "public/rolebg/girlselect_frame.png", var_0_19)

	return var_41_0
end)

function GirlSelectLayerStype:init(arg_42_1)
	self:setSwallowTouches(false)
	self:setTouchEnabled(false)

	self.scale = 0.64
	self.fightType = arg_42_1.fightType
	self.levelmode = arg_42_1.levelmode
	self.clipPanel = ccui.Layout:create()

	self.clipPanel:setContentSize(self:getContentSize())
	self.clipPanel:setAnchorPoint(cc.p(0.5, 0.5))
	self.clipPanel:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height / 2))
	self.clipPanel:setClippingEnabled(true)
	self:addChild(self.clipPanel, var_0_21.HEADIMG)

	local var_42_0 = ccui.ImageView:create("GUI/image.png", var_0_19)

	var_42_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_42_0:setPosition(cc.p(self.clipPanel:getContentSize().width / 2, self.clipPanel:getContentSize().height / 2 - 50))
	var_42_0:setScale(self.scale)
	var_42_0:setName("girlHeadImg")
	self.clipPanel:addChild(var_42_0, var_0_21.HEADIMG)

	local var_42_1 = ccui.ImageView:create("public/rolebg/girlselect_rarity_2.png", var_0_19)

	var_42_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_42_1:setPosition(cc.p(var_42_1:getContentSize().width / 2 - 9, var_42_1:getContentSize().height / 2))
	var_42_1:setName("rarityIcon")
	self:addChild(var_42_1, var_0_21.INFO)

	local var_42_2 = ccui.ImageView:create("public/rolebg/breakout_0.png", var_0_19)

	var_42_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_42_2:setPosition(cc.p(self:getContentSize().width - var_42_2:getContentSize().width / 2 * 0.5 - 4, 30))
	var_42_2:setName("breakoutIcon")
	var_42_2:setScale(0.5)
	self:addChild(var_42_2, var_0_21.INFO)

	local var_42_3 = ccui.ImageView:create("public/rolebg/servant_sprite_name_bg.png", var_0_19)

	var_42_3:setAnchorPoint(cc.p(0, 0))
	var_42_3:setPosition(0, 0)
	var_42_3:setName("nameBg")
	self.clipPanel:addChild(var_42_3, var_0_21.INFO)

	local var_42_4 = ccui.Text:create("", FONT_NAME, 18)

	var_42_4:setAnchorPoint(cc.p(1, 0.5))
	var_42_4:setPosition(cc.p(self:getContentSize().width - 2, var_42_2:getPositionY()))
	var_42_4:setName("lvLabel")
	self:addChild(var_42_4, var_0_21.INFO)

	local var_42_5 = ccui.ImageView:create("public/rolebg/img_lv.png", var_0_19)

	var_42_5:setPositionX(var_42_4:getPositionX() - var_42_4:getContentSize().width - 12)
	var_42_5:setPositionY(14)
	var_42_5:setName("lvIcon")
	var_42_5:setVisible(false)
	self:addChild(var_42_5, 6)

	local var_42_6 = ccui.ImageView:create(CAREER_ICON.assassin_dark, var_0_19)

	var_42_6:setPositionX(self:getContentSize().width - var_42_6:getContentSize().width / 2 * 0.56 + 4)
	var_42_6:setPositionY(self:getContentSize().height - var_42_6:getContentSize().height / 2 * 0.56 + 4)
	var_42_6:setScale(0.45)
	var_42_6:setName("careerIcon")
	self:addChild(var_42_6, var_0_21.INFO)

	local var_42_7 = cc.Label:createWithTTF("", FONT_NAME, 18)

	var_42_7:setName("nameLabel")
	var_42_7:setAnchorPoint(cc.p(1, 0.5))
	var_42_7:setPosition(cc.p(self:getContentSize().width - 2, 10))
	self:addChild(var_42_7, var_0_21.INFO)

	local var_42_8 = ccui.ImageView:create("public/rolebg/girlsprite_class_4.png", var_0_19)

	var_42_8:setAnchorPoint(cc.p(0.5, 0.5))
	var_42_8:setPositionX(14)
	var_42_8:setPositionY(var_42_7:getPositionY())
	var_42_8:setName("classNum")
	self:addChild(var_42_8, var_0_21.INFO)

	local var_42_9 = ccui.ImageView:create("public/rolebg/girlsprite_array_bg.png", var_0_19)

	var_42_9:setPositionX(115)
	var_42_9:setPositionY(150)
	var_42_9:setName("arraybg")
	self:addChild(var_42_9, var_0_21.INFO)

	local var_42_10 = ccui.Text:create("", FONT_NAME, 14)

	var_42_10:setPositionX(var_42_9:getContentSize().width / 2)
	var_42_10:setPositionY(var_42_9:getContentSize().height / 2)
	var_42_10:setName("arraylabel")
	var_42_9:addChild(var_42_10)

	local var_42_11 = ccui.ImageView:create("public/rolebg/girlselect_sprite_lock.png", var_0_19)

	var_42_11:setPositionX(self:getContentSize().width / 2 - 4)
	var_42_11:setPositionY(self:getContentSize().height / 2)
	var_42_11:setName("lockMask")
	self:addChild(var_42_11, var_0_21.INFO)

	local var_42_12 = ccui.ImageView:create("public/rolebg/girlselect_sprite_attr_bg.png", var_0_19)

	var_42_12:setPositionX(self:getContentSize().width / 2)
	var_42_12:setPositionY(self:getContentSize().height / 2)
	var_42_12:setName("attrBg")
	self:addChild(var_42_12, var_0_21.INFO)

	local var_42_13 = 10
	local var_42_14 = 192
	local var_42_15 = {
		{
			L_GIRL_INFO_TABLE[1],
			[2] = "careerLabel"
		},
		{
			L_GIRL_INFO_TABLE[2],
			[2] = "lvLabel"
		},
		{
			L_GIRL_INFO_TABLE[3],
			[2] = "fightCapacityLabel"
		},
		{
			L_GIRL_INFO_TABLE[4],
			[2] = "attackLabel"
		},
		{
			L_GIRL_INFO_TABLE[5],
			[2] = "hpLabel"
		}
	}

	for iter_42_0 = 1, 5 do
		local var_42_16 = 18
		local var_42_18

		if var_42_15[iter_42_0][2] == "careerLabel" then
			var_42_16 = 18
			var_42_18 = 0
		else
			var_42_16 = 18
			var_42_18 = 0
		end

		local var_42_19 = cc.Label:createWithTTF(var_42_15[iter_42_0][1], FONT_DES, var_42_16)

		var_42_19:setPosition(cc.p(var_42_13, var_42_14 + var_42_18))
		var_42_19:setAnchorPoint(cc.p(0, 1))
		var_42_19:setColor(cc.c3b(255, 255, 255))
		var_42_19:setName("label1_" .. iter_42_0)
		var_42_12:addChild(var_42_19)

		local var_42_20 = cc.Label:createWithTTF("", FONT_DES, var_42_16)

		var_42_20:setPosition(cc.p(var_42_19:getContentSize().width + var_42_13, var_42_14 + var_42_18))
		var_42_20:setAnchorPoint(cc.p(0, 1))
		var_42_20:setName(var_42_15[iter_42_0][2])
		var_42_20:setColor(cc.c3b(255, 255, 255))
		var_42_12:addChild(var_42_20)

		var_42_14 = var_42_14 - var_42_16
	end

	local var_42_21 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_19)

	var_42_21:setName("reddot")
	var_42_21:setPositionX(self:getContentSize().width)
	var_42_21:setPositionY(self:getContentSize().height)
	self:addChild(var_42_21, var_0_21.INFO)

	if arg_42_1 and arg_42_1.isHpInherit then
		self:createHpBar(arg_42_1)
	end
end

function GirlSelectLayerStype:createHpBar(arg_43_1)
	if config._DEBUG then
		self.sprBg = cc.Sprite:create("fight/hp_bg_inherit_4.png") or cc.Sprite:createWithSpriteFrameName("fight/hp_bg_inherit_4.png")
	end

	self.sprBg:setAnchorPoint(cc.p(0, 0.5))
	self.sprBg:setPosition(cc.p(5, 12))
	self:addChild(self.sprBg, var_0_21.INFO)

	self.progressTimer = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("fight/hp_bar_inherit_4.png") or cc.Sprite:createWithSpriteFrameName("fight/hp_bar_inherit_4.png")))

	self:addChild(self.progressTimer, var_0_21.INFO)
	self.progressTimer:setAnchorPoint(cc.p(0, 0.5))
	self.progressTimer:setPosition(cc.p(-4, 10))
	self.progressTimer:setMidpoint(cc.p(0, 0.5))
	self.progressTimer:setBarChangeRate(cc.p(1, 0))
	self.progressTimer:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.progressTimer:setPercentage(100)

	self.labelHp = cc.Label:createWithTTF("100%", "fonts/new1.ttf", 13)

	self.labelHp:setAnchorPoint(cc.p(1, 0.5))
	self.labelHp:setPosition(cc.p(self.progressTimer:getContentSize().width, 6))
	self.labelHp:enableOutline(cc.c4b(0, 0, 0, 255), 1)
	self.labelHp:setAlignment(cc.TEXT_ALIGNMENT_RIGHT, cc.TEXT_ALIGNMENT_CENTER)
	self.labelHp:enableOutline(cc.c4b(255, 255, 255, 220), 1)
	self.progressTimer:addChild(self.labelHp)
	self.labelHp:setVisible(false)
	self:adjustElementPositionY(16)
end

function GirlSelectLayerStype:adjustElementPositionY(arg_44_1)
	if self.diff == arg_44_1 then
		return
	end

	self.diff = arg_44_1

	local var_44_0 = {}

	var_44_0[#var_44_0 + 1] = self:getChildByName("lvLabel")
	var_44_0[#var_44_0 + 1] = self:getChildByName("nameLabel")

	local var_44_1 = self.clipPanel:getChildByName("nameBg")

	var_44_0[#var_44_0 + 1] = self:getChildByName("lvIcon")

	local var_44_2 = self:getChildByName("careerIcon")

	var_44_0[#var_44_0 + 1] = self:getChildByName("breakoutIcon")

	for iter_44_0, iter_44_1 in ipairs(var_44_0) do
		if iter_44_1 then
			iter_44_1:setPositionY(iter_44_1:getPositionY() + arg_44_1)
		end
	end
end

function GirlSelectLayerStype:showHpBar(arg_45_1)
	if not self.progressTimer or not self.labelHp or not self.sprBg then
		return
	end

	if not playermodel.haveServant[arg_45_1] then
		self.progressTimer:setVisible(false)
		self.labelHp:setVisible(false)
		self.sprBg:setVisible(false)
		self:adjustElementPositionY(-16)
	else
		self.progressTimer:setVisible(true)
		self.labelHp:setVisible(true)
		self.sprBg:setVisible(true)
		self:adjustElementPositionY(16)
	end

	local var_45_0 = explore_manager:getHpInherit(arg_45_1)

	self.progressTimer:setPercentage(var_45_0 * 100)
	self.labelHp:setString(math.round(var_45_0 * 100) .. "%")

	if var_45_0 <= 0 then
		self:lockGirlByLowerHp()
	elseif self.maskBattle then
		self.maskBattle:setVisible(false)
	end
end

function GirlSelectLayerStype:update(arg_46_1, arg_46_2)
	local var_46_0 = core_manager:getServantCoreRank(arg_46_1)
	local var_46_1 = self:getChildByName("lvLabel")
	local var_46_2 = self.clipPanel:getChildByName("girlHeadImg")

	var_46_2:loadTexture("roleimage/role/shop_image/" .. model_data[global_get_servant_skin(arg_46_1)].role_image .. ".png")
	var_46_2:setAnchorPoint(cc.p(0.5, self.clipPanel:getContentSize().height / 370 / 2))
	var_46_1:setString("等级." .. core_manager:getCoreLv(arg_46_1))
	var_46_1:setColor(cc.c3b(255, 255, 255))
	self:getChildByName("rarityIcon"):loadTexture("public/rolebg/girlselect_rarity_" .. souls_manager:get_servant_cur_roll_rarity(arg_46_1) .. ".png", var_0_19)
	self:getChildByName("breakoutIcon"):loadTexture("public/rolebg/breakout_" .. var_46_0 .. ".png", var_0_19)
	self:getChildByName("breakoutIcon"):setPositionX(var_46_1:getPositionX() - var_46_1:getContentSize().width - 20)
	self:getChildByName("careerIcon"):loadTexture(CAREER_ICON[servant_data[arg_46_1].career .. "_" .. var_0_20(arg_46_1)], var_0_19)

	local var_46_3 = playermodel.soulOverClock[arg_46_1] or 0

	if playermodel.soulContract[arg_46_1] > 0 and var_46_3 == 0 then
		self:getChildByName("classNum"):setVisible(true)
		self:getChildByName("classNum"):loadTexture("public/rolebg/girlsprite_class_" .. playermodel.soulContract[arg_46_1] .. ".png", var_0_19)
	elseif var_46_3 > 0 then
		self:getChildByName("classNum"):setVisible(true)
		self:getChildByName("classNum"):loadTexture("public/rolebg/girlsprite_class_oc.png", var_0_19)
	else
		self:getChildByName("classNum"):setVisible(false)
	end

	self:getChildByName("lvIcon"):setPositionX(var_46_1:getPositionX() - var_46_1:getContentSize().width - 12)
	self:getChildByName("nameLabel"):setString(major_factor_data[servant_data[arg_46_1].major].easy_name)

	if playermodel.haveServant[arg_46_1] then
		ccui.Helper:seekWidgetByName(self, "lockMask"):setVisible(false)
		var_46_1:setVisible(true)
		self:getChildByName("breakoutIcon"):setVisible(var_46_0 > 0)

		if role_false_level_manager:isRoleFalseLevelMember(arg_46_1, self.fightType, self.levelmode) then
			local var_46_4, var_46_5, var_46_6 = role_false_level_manager:getRoleFalseAttrInfoByAllRole(arg_46_1, self.fightType, self.levelmode)

			self:updateByFalseLevel(arg_46_1, var_46_4, var_46_5)
		end

		if arg_46_2 then
			self:getChildByName("attrBg"):setVisible(true)

			local var_46_7 = model_manager.new()

			var_46_7:initPlayerAttribute(arg_46_1)

			if playermodel.haveServant[arg_46_1] and playermodel.weaponId[arg_46_1] then
				var_46_7:updateWeaponAttr((weapon_manager:getWeaponConfig(playermodel.items[playermodel.weaponId[arg_46_1]])))
			end

			local var_46_8, var_46_9 = component_manager:getSoulComponentlist(arg_46_1)

			var_46_7:updateComponentAttr(var_46_8)

			local var_46_10 = self:getChildByName("attrBg"):getChildByName("lvLabel")
			local var_46_11 = self:getChildByName("attrBg"):getChildByName("attackLabel")
			local var_46_12 = self:getChildByName("attrBg"):getChildByName("hpLabel")
			local var_46_13 = self:getChildByName("attrBg"):getChildByName("careerLabel")
			local var_46_14 = self:getChildByName("attrBg"):getChildByName("fightCapacityLabel")

			if playermodel.haveServant[arg_46_1] then
				local var_46_15 = core_manager:getServantCoreRank(arg_46_1)

				var_46_10:setString(core_manager:getCoreLv(arg_46_1))
				var_46_11:setString(global_trans_number(var_46_7:getAttribute("damage")))
				var_46_12:setString(global_trans_number(var_46_7:getAttribute("hp")))
				var_46_13:setString(L_CAREER[SERVANT_CAREE_TBL[var_46_7:getAttribute("career")]])
				var_46_14:setString(fight_capacity_manager:getSoulFightCapacity(arg_46_1))
				self:getChildByName("attrBg"):getChildByName("label1_1"):setVisible(true)
				self:getChildByName("attrBg"):getChildByName("label1_2"):setVisible(true)
				self:getChildByName("attrBg"):getChildByName("label1_3"):setVisible(true)
				self:getChildByName("attrBg"):getChildByName("label1_4"):setVisible(true)
				self:getChildByName("attrBg"):getChildByName("label1_5"):setVisible(true)
				var_46_10:setVisible(true)
				var_46_11:setVisible(true)
				var_46_12:setVisible(true)
				var_46_13:setVisible(true)
				var_46_14:setVisible(true)
			else
				self:getChildByName("attrBg"):getChildByName("label1_1"):setVisible(false)
				self:getChildByName("attrBg"):getChildByName("label1_2"):setVisible(false)
				self:getChildByName("attrBg"):getChildByName("label1_3"):setVisible(false)
				self:getChildByName("attrBg"):getChildByName("label1_4"):setVisible(false)
				self:getChildByName("attrBg"):getChildByName("label1_5"):setVisible(false)
				var_46_10:setVisible(false)
				var_46_11:setVisible(false)
				var_46_12:setVisible(false)
				var_46_13:setVisible(false)
				var_46_14:setVisible(false)
			end
		else
			self:getChildByName("attrBg"):setVisible(false)
		end
	else
		ccui.Helper:seekWidgetByName(self, "lockMask"):setVisible(true)
		var_46_1:setVisible(false)
		self:getChildByName("breakoutIcon"):setVisible(false)
		self:getChildByName("attrBg"):setVisible(false)
	end

	self:getChildByName("reddot"):setVisible(false)

	if playermodel.newservants[arg_46_1] then
		self:getChildByName("reddot"):setVisible(true)
		self:getChildByName("reddot"):loadTexture("public/reddot/new.png", var_0_19)
	elseif playermodel.haveServant[arg_46_1] and servants_reddot_show_data[arg_46_1] and servants_reddot_show_data[arg_46_1].isNewShowReddot and global_is_in_time(servants_reddot_show_data[arg_46_1].starttime, servants_reddot_show_data[arg_46_1].endtime) then
		self:getChildByName("reddot"):setVisible(core_manager:isTipsBreakOut(arg_46_1) or core_manager:isBreakLimit(arg_46_1) or souls_manager:check_is_can_avance_with_material(arg_46_1))
		self:getChildByName("reddot"):loadTexture("public/reddot/reddot2.png", var_0_19)
	end

	self:showHpBar(arg_46_1)
end

function GirlSelectLayerStype:updateByFalseLevel(arg_47_1, arg_47_2, arg_47_3)
	if arg_47_2 == core_manager:getServantCoreRank(arg_47_1) and playermodel.cores[arg_47_1].level == arg_47_3 then
		self:stopFalseLevelAni()
	else
		self:getChildByName("breakoutIcon"):loadTexture("public/rolebg/breakout_" .. arg_47_2 .. ".png", var_0_19)

		local var_47_0 = self:getChildByName("lvLabel")

		var_47_0:setColor(cc.c3b(206, 255, 167))
		var_47_0:setFontSize(18)
		var_47_0:setString("" .. arg_47_3)

		local var_47_1 = true

		var_47_0:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(2), cc.CallFunc:create(function(...)
			if var_47_1 then
				var_47_0:setFontSize(12)
				var_47_0:setString("等级提升中")
			else
				var_47_0:setFontSize(18)
				var_47_0:setString("" .. arg_47_3)
			end

			var_47_1 = not var_47_1
		end), cc.FadeIn:create(2))))
		self:getChildByName("breakoutIcon"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(2), cc.CallFunc:create(function(...)
			return
		end), cc.FadeIn:create(2))))
	end
end

function GirlSelectLayerStype:stopFalseLevelAni()
	if not self.servantId then
		return
	end

	local var_50_0 = core_manager:getServantCoreRank(self.servantId)

	self:getChildByName("breakoutIcon"):stopAllActions()
	self:getChildByName("lvLabel"):stopAllActions()
	self:getChildByName("breakoutIcon"):setOpacity(255)
	self:getChildByName("breakoutIcon"):loadTexture("public/rolebg/breakout_" .. var_50_0 .. ".png", var_0_19)
	self:getChildByName("lvLabel"):setOpacity(255)
	self:getChildByName("lvLabel"):setFontSize(18)
	self:getChildByName("lvLabel"):setString("" .. core_manager:getCoreLv(self.servantId))
	self:getChildByName("lvLabel"):setColor(cc.c3b(234, 238, 245))
end

function GirlSelectLayerStype:lockGirlByLowerHp()
	ccui.Helper:seekWidgetByName(self, "lvLabel"):setVisible(false)
	self:getChildByName("breakoutIcon"):setVisible(false)
	self:getChildByName("attrBg"):setVisible(false)

	if self.maskBattle then
		self.maskBattle:setVisible(true)
	else
		self.maskBattle = ccui.ImageView:create("fight/can_not_battle.png", var_0_19)

		self.maskBattle:setAnchorPoint(0, 0)
		self:addChild(self.maskBattle, var_0_21.INFO)
	end
end

function GirlSelectLayerStype.updateArrayTag(arg_52_0, arg_52_1)
	if not arg_52_1 then
		ccui.Helper:seekWidgetByName(arg_52_0, "arraybg"):setVisible(false)
	else
		ccui.Helper:seekWidgetByName(arg_52_0, "arraybg"):setVisible(true)
		ccui.Helper:seekWidgetByName(arg_52_0, "arraylabel"):setString(glabal_trans_text_horizontal_to_vertical(arg_52_1))
	end
end

DormitorySprite = class("DormitorySprite", function()
	local var_53_0 = GirlSprite.new()

	var_53_0:loadTextures("public/rolebg/girlselect_frame.png", "public/rolebg/girlselect_frame.png", "public/rolebg/girlselect_frame.png", var_0_19)

	return var_53_0
end)

function DormitorySprite:init()
	self:setSwallowTouches(false)
	self:setTouchEnabled(false)

	self.scale = 0.64
	self.clipPanel = ccui.Layout:create()

	self.clipPanel:setContentSize(self:getContentSize())
	self.clipPanel:setAnchorPoint(cc.p(0.5, 0.5))
	self.clipPanel:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height / 2))
	self.clipPanel:setClippingEnabled(true)
	self:addChild(self.clipPanel, var_0_21.HEADIMG)

	local var_54_0 = ccui.ImageView:create("GUI/image.png", var_0_19)

	var_54_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_54_0:setPosition(cc.p(self.clipPanel:getContentSize().width / 2, self.clipPanel:getContentSize().height / 2 - 50))
	var_54_0:setScale(self.scale)
	var_54_0:setName("girlHeadImg")
	self.clipPanel:addChild(var_54_0, var_0_21.HEADIMG)

	local var_54_1 = ccui.ImageView:create("public/rolebg/servant_sprite_name_bg.png", var_0_19)

	var_54_1:setAnchorPoint(cc.p(0, 0))
	var_54_1:setPosition(0, 0)
	var_54_1:setName("nameBg")
	self.clipPanel:addChild(var_54_1, var_0_21.INFO)

	local var_54_2 = cc.Label:createWithTTF("", FONT_NAME, 18)

	var_54_2:setName("nameLabel")
	var_54_2:setAnchorPoint(cc.p(1, 0.5))
	var_54_2:setPosition(cc.p(self:getContentSize().width - 2, 10))
	self:addChild(var_54_2, var_0_21.INFO)

	local var_54_3 = ccui.TextBMFont:create(L_GIRL_SELECT_CELL.favoriteLabel, "fonts/role_impress.fnt")

	var_54_3:setAnchorPoint(cc.p(1, 0))
	var_54_3:setPosition(cc.p(146, 18))
	var_54_3:setName("favoriteLabel")
	var_54_3:getVirtualRenderer():setBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)
	self:addChild(var_54_3, var_0_21.INFO)

	local var_54_4 = ccui.ImageView:create("public/rolebg/girlselect_sprite_lock.png", var_0_19)

	var_54_4:setPositionX(self:getContentSize().width / 2)
	var_54_4:setPositionY(self:getContentSize().height / 2)
	var_54_4:setName("lockMask")
	self:addChild(var_54_4, var_0_21.INFO)

	local var_54_5 = ccui.ImageView:create("public/rolebg/marry_bg_new2.png", var_0_19)

	var_54_5:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2)
	var_54_5:setName("marryFrame")
	self:addChild(var_54_5, var_0_21.INFO)
end

function DormitorySprite:update(arg_55_1, arg_55_2)
	local var_55_0
	local var_55_1 = ""

	if arg_55_1 > 0 and arg_55_1 < 1000 then
		if arg_55_2 == SELECT_GIRL_HOME then
			local var_55_2 = 1

			while major_factor_data[arg_55_1]["fight_model" .. var_55_2] do
				for iter_55_0, iter_55_1 in pairs(servant_data) do
					if playermodel.haveServant[iter_55_1.id] and iter_55_1.classtype == 1 and iter_55_1.modelid == major_factor_data[arg_55_1]["fight_model" .. var_55_2] then
						var_55_0 = major_factor_data[arg_55_1]["fight_model" .. var_55_2]
					end
				end

				var_55_2 = var_55_2 + 1
			end

			var_55_0 = var_55_0 or major_factor_data[arg_55_1].model
		else
			var_55_0 = major_factor_data[arg_55_1].model
		end

		var_55_1 = major_factor_data[arg_55_1].easy_name
	else
		var_55_0 = npc_data[arg_55_1].model
		var_55_1 = npc_data[arg_55_1].name
	end

	if model_data[var_55_0].major == arg_55_1 and arg_55_2 == SELECT_GIRL_HOME then
		if RoleDefault:getInstance():getStringForKey("MainLayerShowGirl") ~= "" then
			local var_55_3 = json.decode(RoleDefault:getInstance():getStringForKey("MainLayerShowGirl"))

			print(dump(var_55_3))

			if var_55_3["m" .. arg_55_1] and major_factor_data[arg_55_1] then
				var_55_0 = tostring(var_55_3["m" .. arg_55_1])
			end
		end
	end

	self.modelid = var_55_0

	local var_55_4 = self.clipPanel:getChildByName("girlHeadImg")

	var_55_4:loadTexture("roleimage/role/shop_image/" .. model_data[var_55_0].role_image .. ".png")
	var_55_4:setAnchorPoint(cc.p(0.5, self.clipPanel:getContentSize().height / 370 / 2))
	self:getChildByName("nameLabel"):setString(var_55_1)
	ccui.Helper:seekWidgetByName(self, "marryFrame"):setVisible(false)

	local var_55_5 = self:getChildByName("favoriteLabel")

	if not npc_data[arg_55_1] then
		var_55_5:setVisible(true)
		var_55_5:setString(L_GIRL_SELECT_CELL.Update[3] .. playermodel.favor[arg_55_1].favorlevel)

		var_55_5.visible = true

		if playermodel.haveSuit[arg_55_1] then
			ccui.Helper:seekWidgetByName(self, "lockMask"):setVisible(false)
		else
			ccui.Helper:seekWidgetByName(self, "lockMask"):setVisible(true)
		end

		if marry_manager:checkIsMarried(arg_55_1) then
			ccui.Helper:seekWidgetByName(self, "marryFrame"):setVisible(true)
		end
	else
		var_55_5:setVisible(false)
		ccui.Helper:seekWidgetByName(self, "lockMask"):setVisible(false)

		var_55_5.visible = false
	end
end

function DormitorySprite:updateShopImage(arg_56_1)
	self.modelid = arg_56_1

	self.clipPanel:getChildByName("girlHeadImg"):loadTexture("roleimage/role/shop_image/" .. model_data[arg_56_1].role_image .. ".png")
end

FormationSprite = class("FormationSprite", function()
	local var_57_0 = GirlSprite.new()

	var_57_0:loadTextures("public/rolebg/girlselect_frame.png", "public/rolebg/girlselect_frame.png", "public/rolebg/girlselect_frame.png", var_0_19)

	return var_57_0
end)

function FormationSprite:init(arg_58_1)
	self:setSwallowTouches(false)
	self:setTouchEnabled(false)

	self.scale = 0.64
	self.clipPanel = ccui.Layout:create()

	self.clipPanel:setContentSize(self:getContentSize())
	self.clipPanel:setAnchorPoint(cc.p(0.5, 0.5))
	self.clipPanel:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height / 2))
	self.clipPanel:setClippingEnabled(true)
	self:addChild(self.clipPanel, var_0_21.HEADIMG)

	local var_58_0 = ccui.ImageView:create("GUI/image.png", var_0_19)

	var_58_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_58_0:setPosition(cc.p(self.clipPanel:getContentSize().width / 2, self.clipPanel:getContentSize().height / 2 - 50))
	var_58_0:setScale(self.scale)
	var_58_0:setName("girlHeadImg")
	self.clipPanel:addChild(var_58_0, var_0_21.HEADIMG)

	local var_58_1 = ccui.ImageView:create("public/rolebg/girlselect_rarity_2.png", var_0_19)

	var_58_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_58_1:setPosition(cc.p(var_58_1:getContentSize().width / 2 - 9, var_58_1:getContentSize().height / 2))
	var_58_1:setName("rarityIcon")
	self:addChild(var_58_1, var_0_21.INFO)

	local var_58_2 = ccui.ImageView:create("public/rolebg/breakout_0.png", var_0_19)

	var_58_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_58_2:setPosition(cc.p(71, 30))
	var_58_2:setName("breakoutIcon")
	var_58_2:setScale(0.5)
	self:addChild(var_58_2, var_0_21.INFO)

	local var_58_3 = ccui.ImageView:create("public/rolebg/servant_sprite_name_bg.png", var_0_19)

	var_58_3:setAnchorPoint(cc.p(0, 0))
	var_58_3:setPosition(0, 0)
	var_58_3:setName("nameBg")
	self.clipPanel:addChild(var_58_3, var_0_21.INFO)

	local var_58_4 = ccui.Text:create("", FONT_NAME, 18)

	var_58_4:setAnchorPoint(cc.p(1, 0.5))
	var_58_4:setPosition(cc.p(self:getContentSize().width - 2, var_58_2:getPositionY()))
	var_58_4:setName("lvLabel")
	self:addChild(var_58_4, var_0_21.INFO)

	local var_58_5 = ccui.ImageView:create("public/rolebg/img_lv.png", var_0_19)

	var_58_5:setPositionX(var_58_4:getPositionX() - var_58_4:getContentSize().width - 12)
	var_58_5:setPositionY(14)
	var_58_5:setName("lvIcon")
	var_58_5:setVisible(false)
	self:addChild(var_58_5, 6)

	local var_58_6 = ccui.ImageView:create(CAREER_ICON.assassin_dark, var_0_19)

	var_58_6:setPositionX(self:getContentSize().width - var_58_6:getContentSize().width / 2 * 0.56 + 4)
	var_58_6:setPositionY(self:getContentSize().height - var_58_6:getContentSize().height / 2 * 0.56 + 4)
	var_58_6:setScale(0.45)
	var_58_6:setName("careerIcon")
	self:addChild(var_58_6, var_0_21.INFO)

	local var_58_7 = cc.Label:createWithTTF("", FONT_NAME, 18)

	var_58_7:setName("nameLabel")
	var_58_7:setAnchorPoint(cc.p(1, 0.5))
	var_58_7:setPosition(cc.p(self:getContentSize().width - 2, 10))
	self:addChild(var_58_7, var_0_21.INFO)

	local var_58_8 = ccui.ImageView:create("public/rolebg/girlsprite_class_4.png", var_0_19)

	var_58_8:setAnchorPoint(cc.p(0.5, 0.5))
	var_58_8:setPositionX(14)
	var_58_8:setPositionY(var_58_7:getPositionY())
	var_58_8:setName("classNum")
	self:addChild(var_58_8, var_0_21.INFO)

	local var_58_9 = ccui.ImageView:create("public/rolebg/girlsprite_array_bg.png", var_0_19)

	var_58_9:setPositionX(115)
	var_58_9:setPositionY(150)
	var_58_9:setName("arraybg")
	self:addChild(var_58_9, var_0_21.INFO)

	local var_58_10 = ccui.Text:create("", FONT_NAME, 14)

	var_58_10:setPositionX(var_58_9:getContentSize().width / 2)
	var_58_10:setPositionY(var_58_9:getContentSize().height / 2)
	var_58_10:setName("arraylabel")
	var_58_9:addChild(var_58_10)

	local var_58_11 = ccui.ImageView:create("public/rolebg/girlselect_sprite_lock.png", var_0_19)

	var_58_11:setPositionX(self:getContentSize().width / 2 - 4)
	var_58_11:setPositionY(self:getContentSize().height / 2)
	var_58_11:setName("lockMask")
	self:addChild(var_58_11, var_0_21.INFO)

	local var_58_12 = ccui.ImageView:create("public/rolebg/girlselect_sprite_attr_bg.png", var_0_19)

	var_58_12:setPositionX(self:getContentSize().width / 2)
	var_58_12:setPositionY(self:getContentSize().height / 2)
	var_58_12:setName("attrBg")
	self:addChild(var_58_12, var_0_21.INFO)

	local var_58_13 = ccui.ImageView:create("public/rolebg/test_img.png", var_0_19)

	var_58_13:setPositionX(22)
	var_58_13:setPositionY(self:getContentSize().height - 13)
	var_58_13:setVisible(false)
	var_58_13:setName("testImg")
	self:addChild(var_58_13, var_0_21.INFO)

	for iter_58_0 = 1, 6 do
		local var_58_14 = ccui.ImageView:create("public/rolebg/star1.png", var_0_19)

		var_58_14:setPositionX(-3)
		var_58_14:setPositionY(-3 + 12 * iter_58_0)
		var_58_14:setName("starImg" .. iter_58_0)
		var_58_14:setVisible(false)
		self:addChild(var_58_14, var_0_21.INFO)
	end

	local var_58_15 = 10
	local var_58_16 = 192
	local var_58_17 = {
		{
			L_GIRL_INFO_TABLE[1],
			[2] = "careerLabel"
		},
		{
			L_GIRL_INFO_TABLE[2],
			[2] = "lvLabel"
		},
		{
			L_GIRL_INFO_TABLE[3],
			[2] = "fightCapacityLabel"
		},
		{
			L_GIRL_INFO_TABLE[4],
			[2] = "attackLabel"
		},
		{
			L_GIRL_INFO_TABLE[5],
			[2] = "hpLabel"
		}
	}

	for iter_58_1 = 1, 5 do
		local var_58_18 = 18
		local var_58_20

		if var_58_17[iter_58_1][2] == "careerLabel" then
			var_58_18 = 18
			var_58_20 = 0
		else
			var_58_18 = 18
			var_58_20 = 0
		end

		local var_58_21 = cc.Label:createWithTTF(var_58_17[iter_58_1][1], FONT_DES, var_58_18)

		var_58_21:setPosition(cc.p(var_58_15, var_58_16 + var_58_20))
		var_58_21:setAnchorPoint(cc.p(0, 1))
		var_58_21:setColor(cc.c3b(255, 255, 255))
		var_58_21:setName("label1_" .. iter_58_1)
		var_58_12:addChild(var_58_21)

		local var_58_22 = cc.Label:createWithTTF("", FONT_DES, var_58_18)

		var_58_22:setPosition(cc.p(var_58_21:getContentSize().width + var_58_15, var_58_16 + var_58_20))
		var_58_22:setAnchorPoint(cc.p(0, 1))
		var_58_22:setName(var_58_17[iter_58_1][2])
		var_58_22:setColor(cc.c3b(255, 255, 255))
		var_58_12:addChild(var_58_22)

		var_58_16 = var_58_16 - var_58_18
	end

	local var_58_23 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_19)

	var_58_23:setName("reddot")
	var_58_23:setPositionX(self:getContentSize().width)
	var_58_23:setPositionY(self:getContentSize().height)
	self:addChild(var_58_23, var_0_21.INFO)

	if arg_58_1 and arg_58_1.isHpInherit then
		self:createHpBar(arg_58_1)
	end
end

function FormationSprite:createHpBar(arg_59_1)
	if config._DEBUG then
		self.sprBg = cc.Sprite:create("fight/hp_bg_inherit_4.png") or cc.Sprite:createWithSpriteFrameName("fight/hp_bg_inherit_4.png")
	end

	self.sprBg:setAnchorPoint(cc.p(0, 0.5))
	self.sprBg:setPosition(cc.p(5, 12))
	self:addChild(self.sprBg, var_0_21.INFO)

	self.progressTimer = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("fight/hp_bar_inherit_4.png") or cc.Sprite:createWithSpriteFrameName("fight/hp_bar_inherit_4.png")))

	self:addChild(self.progressTimer, var_0_21.INFO)
	self.progressTimer:setAnchorPoint(cc.p(0, 0.5))
	self.progressTimer:setPosition(cc.p(-4, 10))
	self.progressTimer:setMidpoint(cc.p(0, 0.5))
	self.progressTimer:setBarChangeRate(cc.p(1, 0))
	self.progressTimer:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.progressTimer:setPercentage(100)

	self.labelHp = cc.Label:createWithTTF("100%", "fonts/new1.ttf", 13)

	self.labelHp:setAnchorPoint(cc.p(1, 0.5))
	self.labelHp:setPosition(cc.p(self.progressTimer:getContentSize().width, 6))
	self.labelHp:enableOutline(cc.c4b(0, 0, 0, 255), 1)
	self.labelHp:setAlignment(cc.TEXT_ALIGNMENT_RIGHT, cc.TEXT_ALIGNMENT_CENTER)
	self.labelHp:enableOutline(cc.c4b(255, 255, 255, 220), 1)
	self.progressTimer:addChild(self.labelHp)
	self.labelHp:setVisible(false)
	self:adjustElementPositionY(16)
end

function FormationSprite:adjustElementPositionY(arg_60_1)
	if self.diff == arg_60_1 then
		return
	end

	self.diff = arg_60_1

	local var_60_0 = {}

	var_60_0[#var_60_0 + 1] = self:getChildByName("lvLabel")
	var_60_0[#var_60_0 + 1] = self:getChildByName("nameLabel")

	local var_60_1 = self.clipPanel:getChildByName("nameBg")

	var_60_0[#var_60_0 + 1] = self:getChildByName("lvIcon")

	local var_60_2 = self:getChildByName("careerIcon")

	var_60_0[#var_60_0 + 1] = self:getChildByName("breakoutIcon")

	for iter_60_0, iter_60_1 in ipairs(var_60_0) do
		if iter_60_1 then
			iter_60_1:setPositionY(iter_60_1:getPositionY() + arg_60_1)
		end
	end
end

function FormationSprite:showHpBar(arg_61_1)
	if not self.progressTimer or not self.labelHp or not self.sprBg then
		return
	end

	if not playermodel.haveServant[arg_61_1] then
		self.progressTimer:setVisible(false)
		self.labelHp:setVisible(false)
		self.sprBg:setVisible(false)
		self:adjustElementPositionY(-16)
	else
		self.progressTimer:setVisible(true)
		self.labelHp:setVisible(true)
		self.sprBg:setVisible(true)
		self:adjustElementPositionY(16)
	end

	local var_61_0 = explore_manager:getHpInherit(arg_61_1)

	self.progressTimer:setPercentage(var_61_0 * 100)
	self.labelHp:setString(math.round(var_61_0 * 100) .. "%")

	if var_61_0 <= 0 then
		self:lockGirlByLowerHp()
	elseif self.maskBattle then
		self.maskBattle:setVisible(false)
	end
end

function FormationSprite:update(arg_62_1, arg_62_2)
	self.servantid = arg_62_1

	local var_62_0 = core_manager:getServantCoreRank(arg_62_1)
	local var_62_1 = self:getChildByName("lvLabel")
	local var_62_2 = self.clipPanel:getChildByName("girlHeadImg")

	var_62_2:loadTexture("roleimage/role/shop_image/" .. model_data[global_get_servant_skin(arg_62_1)].role_image .. ".png")
	var_62_2:setAnchorPoint(cc.p(0.5, self.clipPanel:getContentSize().height / var_62_2:getContentSize().height / 2))
	var_62_1:setString("等级." .. core_manager:getCoreLv(arg_62_1))
	var_62_1:setColor(cc.c3b(255, 255, 255))
	self:getChildByName("rarityIcon"):loadTexture("public/rolebg/girlselect_rarity_" .. souls_manager:get_servant_cur_roll_rarity(arg_62_1) .. ".png", var_0_19)
	self:getChildByName("breakoutIcon"):loadTexture("public/rolebg/breakout_" .. var_62_0 .. ".png", var_0_19)
	self:getChildByName("breakoutIcon"):setPositionX(12)
	self:getChildByName("careerIcon"):loadTexture(CAREER_ICON[servant_data[arg_62_1].career .. "_" .. var_0_20(arg_62_1)], var_0_19)

	local var_62_3 = playermodel.soulOverClock[arg_62_1] or 0

	if playermodel.soulContract[arg_62_1] > 0 and var_62_3 == 0 then
		self:getChildByName("classNum"):setVisible(true)
		self:getChildByName("classNum"):loadTexture("public/rolebg/girlsprite_class_" .. playermodel.soulContract[arg_62_1] .. ".png", var_0_19)
	elseif var_62_3 > 0 then
		self:getChildByName("classNum"):setVisible(true)
		self:getChildByName("classNum"):loadTexture("public/rolebg/girlsprite_class_oc.png", var_0_19)
	else
		self:getChildByName("classNum"):setVisible(false)
	end

	self:getChildByName("lvIcon"):setPositionX(var_62_1:getPositionX() - var_62_1:getContentSize().width - 12)
	self:getChildByName("nameLabel"):setString(major_factor_data[servant_data[arg_62_1].major].easy_name)

	if playermodel.haveServant[arg_62_1] then
		ccui.Helper:seekWidgetByName(self, "lockMask"):setVisible(false)
		var_62_1:setVisible(true)
		self:getChildByName("breakoutIcon"):setVisible(var_62_0 > 0)

		if arg_62_2 then
			self:getChildByName("attrBg"):setVisible(true)

			local var_62_4 = model_manager.new()

			var_62_4:initPlayerAttribute(arg_62_1)

			if playermodel.haveServant[arg_62_1] and playermodel.weaponId[arg_62_1] then
				var_62_4:updateWeaponAttr((weapon_manager:getWeaponConfig(playermodel.items[playermodel.weaponId[arg_62_1]])))
			end

			local var_62_5, var_62_6 = component_manager:getSoulComponentlist(arg_62_1)

			var_62_4:updateComponentAttr(var_62_5)

			local var_62_7 = self:getChildByName("attrBg"):getChildByName("lvLabel")
			local var_62_8 = self:getChildByName("attrBg"):getChildByName("attackLabel")
			local var_62_9 = self:getChildByName("attrBg"):getChildByName("hpLabel")
			local var_62_10 = self:getChildByName("attrBg"):getChildByName("careerLabel")
			local var_62_11 = self:getChildByName("attrBg"):getChildByName("fightCapacityLabel")

			if playermodel.haveServant[arg_62_1] then
				local var_62_12 = core_manager:getServantCoreRank(arg_62_1)

				var_62_7:setString(core_manager:getCoreLv(arg_62_1))
				var_62_8:setString(global_trans_number(var_62_4:getAttribute("damage")))
				var_62_9:setString(global_trans_number(var_62_4:getAttribute("hp")))
				var_62_10:setString(L_CAREER[SERVANT_CAREE_TBL[var_62_4:getAttribute("career")]])
				var_62_11:setString(fight_capacity_manager:getSoulFightCapacity(arg_62_1))
				self:getChildByName("attrBg"):getChildByName("label1_1"):setVisible(true)
				self:getChildByName("attrBg"):getChildByName("label1_2"):setVisible(true)
				self:getChildByName("attrBg"):getChildByName("label1_3"):setVisible(true)
				self:getChildByName("attrBg"):getChildByName("label1_4"):setVisible(true)
				self:getChildByName("attrBg"):getChildByName("label1_5"):setVisible(true)
				var_62_7:setVisible(true)
				var_62_8:setVisible(true)
				var_62_9:setVisible(true)
				var_62_10:setVisible(true)
				var_62_11:setVisible(true)
			else
				self:getChildByName("attrBg"):getChildByName("label1_1"):setVisible(false)
				self:getChildByName("attrBg"):getChildByName("label1_2"):setVisible(false)
				self:getChildByName("attrBg"):getChildByName("label1_3"):setVisible(false)
				self:getChildByName("attrBg"):getChildByName("label1_4"):setVisible(false)
				self:getChildByName("attrBg"):getChildByName("label1_5"):setVisible(false)
				var_62_7:setVisible(false)
				var_62_8:setVisible(false)
				var_62_9:setVisible(false)
				var_62_10:setVisible(false)
				var_62_11:setVisible(false)
			end
		else
			self:getChildByName("attrBg"):setVisible(false)
		end

		if role_false_level_manager:isRoleFalseLevelMember(arg_62_1, self.fightType, self.levelmode) then
			local var_62_13, var_62_14, var_62_15 = role_false_level_manager:getRoleFalseAttrInfoByAllRole(arg_62_1, self.fightType, self.levelmode)

			self:updateByFalseLevel(arg_62_1, var_62_13, var_62_14)
		end
	else
		ccui.Helper:seekWidgetByName(self, "lockMask"):setVisible(true)
		var_62_1:setVisible(false)
		self:getChildByName("breakoutIcon"):setVisible(false)
		self:getChildByName("attrBg"):setVisible(false)
	end

	self:getChildByName("reddot"):setVisible(false)
	self:showHpBar(arg_62_1)
end

function FormationSprite:lockGirlByLowerHp()
	ccui.Helper:seekWidgetByName(self, "lvLabel"):setVisible(false)
	self:getChildByName("breakoutIcon"):setVisible(false)
	self:getChildByName("attrBg"):setVisible(false)

	if self.maskBattle then
		self.maskBattle:setVisible(true)
	else
		self.maskBattle = ccui.ImageView:create("fight/can_not_battle.png", var_0_19)

		self.maskBattle:setAnchorPoint(0, 0)
		self:addChild(self.maskBattle, var_0_21.INFO)
	end
end

function FormationSprite.updateArrayTag(arg_64_0, arg_64_1)
	if not arg_64_1 then
		ccui.Helper:seekWidgetByName(arg_64_0, "arraybg"):setVisible(false)
	else
		ccui.Helper:seekWidgetByName(arg_64_0, "arraybg"):setVisible(true)
		ccui.Helper:seekWidgetByName(arg_64_0, "arraylabel"):setString(glabal_trans_text_horizontal_to_vertical(arg_64_1))
	end
end

function FormationSprite:startPressBar(arg_65_1, arg_65_2, arg_65_3)
	if not self.pressBar then
		self:createPressBar()
	end

	local var_65_0 = arg_65_3 or 0.3
	local var_65_1 = 0

	self.pressBar:setVisible(true)
	self.pressBar:setPercentage(0)
	self.pressBar:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
		self.pressBar:setPercentage(var_65_1 / var_65_0 * 100)

		if var_65_1 > var_65_0 then
			self.pressBar:stopAllActions()

			if arg_65_1 then
				arg_65_1()
			end
		end

		var_65_1 = var_65_1 + 0.016666666666666666

		if arg_65_2 then
			arg_65_2(0.016666666666666666)
		end
	end))))
end

function FormationSprite:endPressBar()
	if not self.pressBar then
		return
	end

	self.pressBar:setVisible(false)
	self.pressBar:stopAllActions()
end

function FormationSprite:createPressBar()
	self.pressBar = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("public/button/press_bar.png") or cc.Sprite:createWithSpriteFrameName("public/button/press_bar.png")))

	self.pressBar:setScale(0.8)
	self.pressBar:setAnchorPoint(cc.p(0.5, 0.5))
	self.pressBar:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
	self.pressBar:setPositionX(self:getContentSize().width / 2)
	self.pressBar:setPositionY(self:getContentSize().height / 2)
	self.pressBar:setReverseDirection(true)
	self:addChild(self.pressBar, var_0_21.PRESSBAR)
end

function FormationSprite:imgScaleTo(arg_69_1, arg_69_2)
	self.clipPanel:getChildByName("girlHeadImg"):runAction(cc.ScaleTo:create(arg_69_2, self.scale * arg_69_1, self.scale * arg_69_1))
end

function FormationSprite:endPressBar()
	if not self.pressBar then
		return
	end

	self.pressBar:setVisible(false)
	self.pressBar:stopAllActions()
end

function FormationSprite:updateByFalseLevel(arg_71_1, arg_71_2, arg_71_3)
	if arg_71_2 == core_manager:getServantCoreRank(arg_71_1) and playermodel.cores[arg_71_1].level == arg_71_3 then
		self:stopFalseLevelAni()
	else
		self:getChildByName("breakoutIcon"):loadTexture("public/rolebg/breakout_" .. arg_71_2 .. ".png", var_0_19)

		local var_71_0 = self:getChildByName("lvLabel")

		var_71_0:setColor(cc.c3b(206, 255, 167))
		var_71_0:setFontSize(18)
		var_71_0:setString("" .. arg_71_3)

		local var_71_1 = true

		var_71_0:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(2), cc.CallFunc:create(function(...)
			if var_71_1 then
				var_71_0:setFontSize(12)
				var_71_0:setString("等级提升中")
			else
				var_71_0:setFontSize(18)
				var_71_0:setString("" .. arg_71_3)
			end

			var_71_1 = not var_71_1
		end), cc.FadeIn:create(2))))
		self:getChildByName("breakoutIcon"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(2), cc.CallFunc:create(function(...)
			return
		end), cc.FadeIn:create(2))))
	end
end

function FormationSprite:stopFalseLevelAni()
	if not self.servantid then
		return
	end

	local var_74_0 = core_manager:getServantCoreRank(self.servantid)

	self:getChildByName("breakoutIcon"):stopAllActions()
	self:getChildByName("lvLabel"):stopAllActions()
	self:getChildByName("breakoutIcon"):setOpacity(255)
	self:getChildByName("breakoutIcon"):loadTexture("public/rolebg/breakout_" .. var_74_0 .. ".png", var_0_19)
	self:getChildByName("lvLabel"):setOpacity(255)
	self:getChildByName("lvLabel"):setFontSize(18)
	self:getChildByName("lvLabel"):setString("" .. core_manager:getCoreLv(self.servantid))
	self:getChildByName("lvLabel"):setColor(cc.c3b(234, 238, 245))
end

girlSelectTestFightSprite = class("girlSelectTestFightSprite", FormationSprite)

function girlSelectTestFightSprite:update(arg_75_1, arg_75_2)
	self.servantid = arg_75_1

	local var_75_0 = core_manager:getServantCoreRank(arg_75_1)
	local var_75_1 = self:getChildByName("lvLabel")
	local var_75_2 = self.clipPanel:getChildByName("girlHeadImg")

	var_75_2:loadTexture("roleimage/role/shop_image/" .. model_data[global_get_servant_skin(arg_75_1)].role_image .. ".png")
	var_75_2:setAnchorPoint(cc.p(0.5, self.clipPanel:getContentSize().height / var_75_2:getContentSize().height / 2))
	var_75_1:setString("等级." .. 300)
	var_75_1:setColor(cc.c3b(255, 255, 255))
	self:getChildByName("rarityIcon"):loadTexture("public/rolebg/girlselect_rarity_" .. souls_manager:get_servant_cur_roll_rarity(arg_75_1) .. ".png", var_0_19)
	self:getChildByName("breakoutIcon"):loadTexture("public/rolebg/breakout_" .. var_75_0 .. ".png", var_0_19)
	self:getChildByName("breakoutIcon"):setPositionX(var_75_1:getPositionX() - var_75_1:getContentSize().width - 20)
	self:getChildByName("careerIcon"):loadTexture(CAREER_ICON[servant_data[arg_75_1].career .. "_" .. var_0_20(arg_75_1)], var_0_19)

	local var_75_3 = playermodel.soulOverClock[arg_75_1] or 0

	if playermodel.soulContract[arg_75_1] > 0 and var_75_3 == 0 then
		self:getChildByName("classNum"):setVisible(true)
		self:getChildByName("classNum"):loadTexture("public/rolebg/girlsprite_class_" .. playermodel.soulContract[arg_75_1] .. ".png", var_0_19)
	elseif var_75_3 > 0 then
		self:getChildByName("classNum"):setVisible(true)
		self:getChildByName("classNum"):loadTexture("public/rolebg/girlsprite_class_oc.png", var_0_19)
	else
		self:getChildByName("classNum"):setVisible(false)
	end

	self:getChildByName("testImg"):setVisible(true)
	self:getChildByName("lvIcon"):setPositionX(var_75_1:getPositionX() - var_75_1:getContentSize().width - 12)
	self:getChildByName("nameLabel"):setString(major_factor_data[servant_data[arg_75_1].major].easy_name)
	ccui.Helper:seekWidgetByName(self, "lockMask"):setVisible(false)
	var_75_1:setVisible(true)
	self:getChildByName("breakoutIcon"):setVisible(var_75_0 > 0)

	if arg_75_2 then
		self:getChildByName("attrBg"):setVisible(true)

		local var_75_4 = model_manager.new()

		var_75_4:initPlayerAttribute(arg_75_1)

		if playermodel.haveServant[arg_75_1] and playermodel.weaponId[arg_75_1] then
			var_75_4:updateWeaponAttr((weapon_manager:getWeaponConfig(playermodel.items[playermodel.weaponId[arg_75_1]])))
		end

		local var_75_5, var_75_6 = component_manager:getSoulComponentlist(arg_75_1)

		var_75_4:updateComponentAttr(var_75_5)

		local var_75_7 = self:getChildByName("attrBg"):getChildByName("lvLabel")
		local var_75_8 = self:getChildByName("attrBg"):getChildByName("attackLabel")
		local var_75_9 = self:getChildByName("attrBg"):getChildByName("hpLabel")
		local var_75_10 = self:getChildByName("attrBg"):getChildByName("careerLabel")
		local var_75_11 = self:getChildByName("attrBg"):getChildByName("fightCapacityLabel")

		if playermodel.haveServant[arg_75_1] then
			var_75_7:setString(0)
			var_75_8:setString(global_trans_number(var_75_4:getAttribute("damage")))
			var_75_9:setString(global_trans_number(var_75_4:getAttribute("hp")))
			var_75_10:setString(L_CAREER[SERVANT_CAREE_TBL[var_75_4:getAttribute("career")]])
			var_75_11:setString(fight_capacity_manager:getSoulFightCapacity(arg_75_1))
			self:getChildByName("attrBg"):getChildByName("label1_1"):setVisible(true)
			self:getChildByName("attrBg"):getChildByName("label1_2"):setVisible(true)
			self:getChildByName("attrBg"):getChildByName("label1_3"):setVisible(true)
			self:getChildByName("attrBg"):getChildByName("label1_4"):setVisible(true)
			self:getChildByName("attrBg"):getChildByName("label1_5"):setVisible(true)
			var_75_7:setVisible(true)
			var_75_8:setVisible(true)
			var_75_9:setVisible(true)
			var_75_10:setVisible(true)
			var_75_11:setVisible(true)
		else
			self:getChildByName("attrBg"):getChildByName("label1_1"):setVisible(false)
			self:getChildByName("attrBg"):getChildByName("label1_2"):setVisible(false)
			self:getChildByName("attrBg"):getChildByName("label1_3"):setVisible(false)
			self:getChildByName("attrBg"):getChildByName("label1_4"):setVisible(false)
			self:getChildByName("attrBg"):getChildByName("label1_5"):setVisible(false)
			var_75_7:setVisible(false)
			var_75_8:setVisible(false)
			var_75_9:setVisible(false)
			var_75_10:setVisible(false)
			var_75_11:setVisible(false)
		end
	else
		self:getChildByName("attrBg"):setVisible(false)
	end

	self:getChildByName("reddot"):setVisible(false)
	self:showHpBar(arg_75_1)
end

GrilArenaEnemyFormationSprite = class("GrilArenaEnemyFormationSprite", function()
	return GrilArraySprite.new()
end)

function GrilArenaEnemyFormationSprite:init(arg_77_1)
	self:loadTextures("public/rolebg/girlselect_frame.png", "public/rolebg/girlselect_frame.png", "public/rolebg/girlselect_frame.png", var_0_19)
	self:setSwallowTouches(false)
	self:setTouchEnabled(false)

	self.scale = 0.64
	self.clipSize = self:getContentSize()
	self.clipPanel = ccui.Layout:create()

	self.clipPanel:setContentSize(self:getContentSize())
	self.clipPanel:setAnchorPoint(cc.p(0.5, 0.5))
	self.clipPanel:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height / 2))
	self.clipPanel:setClippingEnabled(true)
	self:addChild(self.clipPanel, var_0_21.HEADIMG)

	local var_77_0 = ccui.ImageView:create("GUI/image.png", var_0_19)

	var_77_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_77_0:setPosition(cc.p(self.clipPanel:getContentSize().width / 2, self.clipPanel:getContentSize().height / 2 - 50))
	var_77_0:setScale(self.scale)
	var_77_0:setName("girlHeadImg")
	self.clipPanel:addChild(var_77_0, var_0_21.HEADIMG)

	local var_77_1 = ccui.ImageView:create("public/rolebg/girlselect_rarity_2.png", var_0_19)

	var_77_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_77_1:setPosition(cc.p(var_77_1:getContentSize().width / 2 - 9, var_77_1:getContentSize().height / 2))
	var_77_1:setName("rarityIcon")
	self:addChild(var_77_1, var_0_21.INFO)

	local var_77_2 = ccui.ImageView:create("public/rolebg/breakout_0.png", var_0_19)

	var_77_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_77_2:setPosition(cc.p(71, 30))
	var_77_2:setName("breakoutIcon")
	var_77_2:setScale(0.5)
	self:addChild(var_77_2, var_0_21.INFO)

	local var_77_3 = ccui.ImageView:create("public/rolebg/servant_sprite_name_bg.png", var_0_19)

	var_77_3:setAnchorPoint(cc.p(0, 0))
	var_77_3:setPosition(0, 0)
	var_77_3:setName("nameBg")
	self.clipPanel:addChild(var_77_3, var_0_21.INFO)

	local var_77_4 = ccui.Text:create("", FONT_NAME, 18)

	var_77_4:setAnchorPoint(cc.p(1, 0.5))
	var_77_4:setPosition(cc.p(self:getContentSize().width - 2, var_77_2:getPositionY()))
	var_77_4:setName("lvLabel")
	self:addChild(var_77_4, var_0_21.INFO)

	local var_77_5 = ccui.ImageView:create("public/rolebg/img_lv.png", var_0_19)

	var_77_5:setPositionX(var_77_4:getPositionX() - var_77_4:getContentSize().width - 12)
	var_77_5:setPositionY(14)
	var_77_5:setName("lvIcon")
	var_77_5:setVisible(false)
	self:addChild(var_77_5, 6)

	local var_77_6 = ccui.ImageView:create(CAREER_ICON.assassin_dark, var_0_19)

	var_77_6:setPositionX(self:getContentSize().width - var_77_6:getContentSize().width / 2 * 0.56 + 4)
	var_77_6:setPositionY(self:getContentSize().height - var_77_6:getContentSize().height / 2 * 0.56 + 4)
	var_77_6:setScale(0.45)
	var_77_6:setName("careerIcon")
	self:addChild(var_77_6, var_0_21.INFO)

	local var_77_7 = cc.Label:createWithTTF("", FONT_NAME, 18)

	var_77_7:setName("nameLabel")
	var_77_7:setAnchorPoint(cc.p(1, 0.5))
	var_77_7:setPosition(cc.p(self:getContentSize().width - 2, 10))
	self:addChild(var_77_7, var_0_21.INFO)

	local var_77_8 = ccui.ImageView:create("public/rolebg/girlsprite_class_4.png", var_0_19)

	var_77_8:setAnchorPoint(cc.p(0.5, 0.5))
	var_77_8:setPositionX(14)
	var_77_8:setPositionY(var_77_7:getPositionY())
	var_77_8:setName("classNum")
	self:addChild(var_77_8, var_0_21.INFO)

	local var_77_9 = ccui.ImageView:create("public/rolebg/test_img.png", var_0_19)

	var_77_9:setPositionX(22)
	var_77_9:setPositionY(self:getContentSize().height - 13)
	var_77_9:setVisible(false)
	var_77_9:setName("testImg")
	self:addChild(var_77_9, var_0_21.INFO)

	if arg_77_1 and arg_77_1.isHpInherit then
		self:createHpBar(arg_77_1)
	end
end

function GrilArenaEnemyFormationSprite:update(arg_78_1, arg_78_2)
	local var_78_0 = arg_78_1.level
	local var_78_1 = arg_78_1.contract
	local var_78_2 = arg_78_1.rank
	local var_78_3 = arg_78_1.overclock or arg_78_1.soulOC or 0
	local var_78_4 = arg_78_1.modelid
	local var_78_5
	local var_78_6
	local var_78_7

	if arg_78_1.servantId then
		var_78_4 = var_78_4 or global_get_servant_skin(arg_78_1.servantId, arg_78_1.servantskin or -1)
		var_78_5 = souls_manager:get_servant_cur_roll_rarity(arg_78_1.servantId, arg_78_1.addRollRarity)
		var_78_6 = CAREER_ICON[servant_data[arg_78_1.servantId].career .. "_" .. self:getAttrIconPath(arg_78_1.servantId)]
		var_78_7 = major_factor_data[servant_data[arg_78_1.servantId].major].easy_name
	elseif arg_78_1.npcsoulid then
		var_78_4 = npc_data[arg_78_1.npcsoulid].model

		if not npc_data[arg_78_1.npcsoulid].roll_rarity then
			::label_78_0::

			var_78_5 = 1
		end

		var_78_6 = CAREER_ICON[npc_data[arg_78_1.npcsoulid].career .. "_" .. global_get_model_attr(var_78_4)]
		var_78_7 = npc_data[arg_78_1.npcsoulid].easy_name
	end

	local var_78_8 = self.clipPanel:getChildByName("girlHeadImg")

	var_78_8:loadTexture("roleimage/role/shop_image/" .. model_data[var_78_4].role_image .. ".png")
	var_78_8:setAnchorPoint(cc.p(0.5, self.clipSize.height / var_78_8:getContentSize().height / 2))

	local var_78_9 = self:getChildByName("lvLabel")

	var_78_9:setString("等级." .. var_78_0)
	var_78_9:setColor(cc.c3b(255, 255, 255))
	self:getChildByName("breakoutIcon"):loadTexture("public/rolebg/breakout_" .. var_78_2 .. ".png", var_0_19)
	self:getChildByName("breakoutIcon"):setPositionX(12)
	self:getChildByName("lvIcon"):setPositionX(var_78_9:getPositionX() - var_78_9:getContentSize().width - 12)
	print(role_false_level_manager:isRoleFalseLevelMember(arg_78_1.servantId, self.fightType, self.levelmode))

	if role_false_level_manager:isRoleFalseLevelMember(arg_78_1.servantId, self.fightType, self.levelmode) then
		local var_78_10, var_78_11, var_78_12 = role_false_level_manager:getRoleFalseAttrInfoByAllRole(arg_78_1.servantId, self.fightType, self.levelmode)

		self:updateByFalseLevel(arg_78_1.servantId, var_78_10, var_78_11)
	end

	self:getChildByName("rarityIcon"):loadTexture("public/rolebg/girlselect_rarity_" .. var_78_5 .. ".png", var_0_19)

	local var_78_13 = self:getChildByName("classNum")

	self:getChildByName("careerIcon"):loadTexture(var_78_6, var_0_19)

	if var_78_1 > 0 and var_78_3 == 0 then
		var_78_13:setVisible(true)
		var_78_13:loadTexture("public/rolebg/girlsprite_class_" .. var_78_1 .. ".png", var_0_19)
	elseif var_78_3 > 0 then
		var_78_13:setVisible(true)
		var_78_13:loadTexture("public/rolebg/girlsprite_class_oc.png", var_0_19)
	else
		var_78_13:setVisible(false)
	end

	self:getChildByName("nameLabel"):setString(var_78_7)
	self:showHpBar(arg_78_2 or arg_78_1.servantId)
end

function GrilArenaEnemyFormationSprite:showHpBar(arg_79_1)
	if not self.progressTimer or not self.labelHp or not self.sprBg then
		return
	end

	self.progressTimer:setVisible(true)
	self.progressTimer:setPosition(cc.p(-7, 5))
	self.labelHp:setVisible(true)
	self.sprBg:setVisible(true)
	self.sprBg:setPosition(cc.p(-9, 5))
	self:adjustElementPositionY(0)

	local var_79_0 = self:getChildByName("careerIcon")

	var_79_0:setPositionY(var_79_0:getPositionY() - 15)

	local var_79_1 = explore_manager:getHpInherit(arg_79_1)

	self.progressTimer:setPercentage(var_79_1 * 100)
	self.labelHp:setString(math.round(var_79_1 * 100) .. "%")
end

function GrilArenaEnemyFormationSprite:updateByFalseLevel(arg_80_1, arg_80_2, arg_80_3)
	if arg_80_2 == core_manager:getServantCoreRank(arg_80_1) and playermodel.cores[arg_80_1].level == arg_80_3 then
		self:stopFalseLevelAni()
	else
		self:getChildByName("breakoutIcon"):loadTexture("public/rolebg/breakout_" .. arg_80_2 .. ".png", var_0_19)

		local var_80_0 = self:getChildByName("lvLabel")

		var_80_0:setColor(cc.c3b(206, 255, 167))
		var_80_0:setFontSize(18)
		var_80_0:setString("" .. arg_80_3)

		local var_80_1 = true

		var_80_0:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(2), cc.CallFunc:create(function(...)
			if var_80_1 then
				var_80_0:setFontSize(12)
				var_80_0:setString("等级提升中")
			else
				var_80_0:setFontSize(18)
				var_80_0:setString("" .. arg_80_3)
			end

			var_80_1 = not var_80_1
		end), cc.FadeIn:create(2))))
		self:getChildByName("breakoutIcon"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(2), cc.CallFunc:create(function(...)
			return
		end), cc.FadeIn:create(2))))
	end
end

girlSelectAutoChessSprite = class("girlSelectAutoChessSprite", FormationSprite)

function girlSelectAutoChessSprite:update(arg_83_1, arg_83_2)
	self.servantid = arg_83_1

	local var_83_0 = core_manager:getServantCoreRank(arg_83_1)
	local var_83_1 = self:getChildByName("lvLabel")
	local var_83_2 = self.clipPanel:getChildByName("girlHeadImg")

	var_83_2:loadTexture("roleimage/role/shop_image/" .. model_data[global_get_servant_skin(arg_83_1)].role_image .. ".png")
	var_83_2:setAnchorPoint(cc.p(0.5, self.clipPanel:getContentSize().height / var_83_2:getContentSize().height / 2))
	var_83_1:setString("等级." .. require("controller.activity_manager"):getAutoChessLvByStar(arg_83_2))
	var_83_1:setColor(cc.c3b(255, 255, 255))
	self:getChildByName("rarityIcon"):loadTexture("public/rolebg/girlselect_rarity_" .. souls_manager:get_servant_cur_roll_rarity(arg_83_1) .. ".png", var_0_19)
	self:getChildByName("breakoutIcon"):loadTexture("public/rolebg/breakout_" .. var_83_0 .. ".png", var_0_19)
	self:getChildByName("breakoutIcon"):setPositionX(var_83_1:getPositionX() - var_83_1:getContentSize().width - 20)
	self:getChildByName("careerIcon"):loadTexture(CAREER_ICON[servant_data[arg_83_1].career .. "_" .. var_0_20(arg_83_1)], var_0_19)

	local var_83_3 = playermodel.soulOverClock[arg_83_1] or 0

	if playermodel.soulContract[arg_83_1] > 0 and var_83_3 == 0 then
		self:getChildByName("classNum"):setVisible(true)
		self:getChildByName("classNum"):loadTexture("public/rolebg/girlsprite_class_" .. playermodel.soulContract[arg_83_1] .. ".png", var_0_19)
	elseif var_83_3 > 0 then
		self:getChildByName("classNum"):setVisible(true)
		self:getChildByName("classNum"):loadTexture("public/rolebg/girlsprite_class_oc.png", var_0_19)
	else
		self:getChildByName("classNum"):setVisible(false)
	end

	self:getChildByName("testImg"):setVisible(true)
	self:getChildByName("lvIcon"):setPositionX(var_83_1:getPositionX() - var_83_1:getContentSize().width - 12)
	self:getChildByName("nameLabel"):setString(major_factor_data[servant_data[arg_83_1].major].easy_name)

	for iter_83_0 = 1, 6 do
		self:getChildByName("starImg" .. iter_83_0):setVisible(iter_83_0 <= arg_83_2)
	end

	ccui.Helper:seekWidgetByName(self, "lockMask"):setVisible(false)
	var_83_1:setVisible(true)
	self:getChildByName("breakoutIcon"):setVisible(var_83_0 > 0)

	if isShowAttr then
		self:getChildByName("attrBg"):setVisible(true)

		local var_83_4 = model_manager.new()

		var_83_4:initPlayerAttribute(arg_83_1)

		if playermodel.haveServant[arg_83_1] and playermodel.weaponId[arg_83_1] then
			var_83_4:updateWeaponAttr((weapon_manager:getWeaponConfig(playermodel.items[playermodel.weaponId[arg_83_1]])))
		end

		local var_83_5, var_83_6 = component_manager:getSoulComponentlist(arg_83_1)

		var_83_4:updateComponentAttr(var_83_5)

		local var_83_7 = self:getChildByName("attrBg"):getChildByName("lvLabel")
		local var_83_8 = self:getChildByName("attrBg"):getChildByName("attackLabel")
		local var_83_9 = self:getChildByName("attrBg"):getChildByName("hpLabel")
		local var_83_10 = self:getChildByName("attrBg"):getChildByName("careerLabel")
		local var_83_11 = self:getChildByName("attrBg"):getChildByName("fightCapacityLabel")

		if playermodel.haveServant[arg_83_1] then
			var_83_7:setString(0)
			var_83_8:setString(global_trans_number(var_83_4:getAttribute("damage")))
			var_83_9:setString(global_trans_number(var_83_4:getAttribute("hp")))
			var_83_10:setString(L_CAREER[SERVANT_CAREE_TBL[var_83_4:getAttribute("career")]])
			var_83_11:setString(fight_capacity_manager:getSoulFightCapacity(arg_83_1))
			self:getChildByName("attrBg"):getChildByName("label1_1"):setVisible(true)
			self:getChildByName("attrBg"):getChildByName("label1_2"):setVisible(true)
			self:getChildByName("attrBg"):getChildByName("label1_3"):setVisible(true)
			self:getChildByName("attrBg"):getChildByName("label1_4"):setVisible(true)
			self:getChildByName("attrBg"):getChildByName("label1_5"):setVisible(true)
			var_83_7:setVisible(true)
			var_83_8:setVisible(true)
			var_83_9:setVisible(true)
			var_83_10:setVisible(true)
			var_83_11:setVisible(true)
		else
			self:getChildByName("attrBg"):getChildByName("label1_1"):setVisible(false)
			self:getChildByName("attrBg"):getChildByName("label1_2"):setVisible(false)
			self:getChildByName("attrBg"):getChildByName("label1_3"):setVisible(false)
			self:getChildByName("attrBg"):getChildByName("label1_4"):setVisible(false)
			self:getChildByName("attrBg"):getChildByName("label1_5"):setVisible(false)
			var_83_7:setVisible(false)
			var_83_8:setVisible(false)
			var_83_9:setVisible(false)
			var_83_10:setVisible(false)
			var_83_11:setVisible(false)
		end
	else
		self:getChildByName("attrBg"):setVisible(false)
	end

	self:getChildByName("reddot"):setVisible(false)
	self:showHpBar(arg_83_1)
end

HelpBattleSprite = class("HelpBattleSprite", function()
	local var_84_0 = GirlSprite.new()

	var_84_0:loadTextures("public/rolebg/girlselect_frame.png", "public/rolebg/girlselect_frame.png", "public/rolebg/girlselect_frame.png", var_0_19)

	return var_84_0
end)

function HelpBattleSprite:init(arg_85_1)
	self:setSwallowTouches(false)
	self:setTouchEnabled(false)

	self.scale = 0.64
	self.clipPanel = ccui.Layout:create()

	self.clipPanel:setContentSize(self:getContentSize())
	self.clipPanel:setAnchorPoint(cc.p(0.5, 0.5))
	self.clipPanel:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height / 2))
	self.clipPanel:setClippingEnabled(true)
	self:addChild(self.clipPanel, var_0_21.HEADIMG)

	local var_85_0 = ccui.ImageView:create("GUI/image.png", var_0_19)

	var_85_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_85_0:setPosition(cc.p(self.clipPanel:getContentSize().width / 2, self.clipPanel:getContentSize().height / 2 - 50))
	var_85_0:setScale(self.scale)
	var_85_0:setName("girlHeadImg")
	self.clipPanel:addChild(var_85_0, var_0_21.HEADIMG)

	local var_85_1 = ccui.ImageView:create("public/rolebg/girlselect_rarity_2.png", var_0_19)

	var_85_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_85_1:setPosition(cc.p(var_85_1:getContentSize().width / 2 - 9, var_85_1:getContentSize().height / 2))
	var_85_1:setName("rarityIcon")
	self:addChild(var_85_1, var_0_21.INFO)

	local var_85_2 = ccui.ImageView:create("public/rolebg/breakout_0.png", var_0_19)

	var_85_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_85_2:setPosition(cc.p(71, 30))
	var_85_2:setName("breakoutIcon")
	var_85_2:setScale(0.5)
	self:addChild(var_85_2, var_0_21.INFO)

	local var_85_3 = ccui.ImageView:create("public/rolebg/servant_sprite_name_bg.png", var_0_19)

	var_85_3:setAnchorPoint(cc.p(0, 0))
	var_85_3:setPosition(0, 0)
	var_85_3:setName("nameBg")
	self.clipPanel:addChild(var_85_3, var_0_21.INFO)

	local var_85_4 = ccui.Text:create("", FONT_NAME, 18)

	var_85_4:setAnchorPoint(cc.p(1, 0.5))
	var_85_4:setPosition(cc.p(self:getContentSize().width - 2, var_85_2:getPositionY()))
	var_85_4:setName("lvLabel")
	self:addChild(var_85_4, var_0_21.INFO)

	local var_85_5 = ccui.ImageView:create("public/rolebg/img_lv.png", var_0_19)

	var_85_5:setPositionX(var_85_4:getPositionX() - var_85_4:getContentSize().width - 12)
	var_85_5:setPositionY(14)
	var_85_5:setName("lvIcon")
	var_85_5:setVisible(false)
	self:addChild(var_85_5, 6)

	local var_85_6 = ccui.ImageView:create(CAREER_ICON.assassin_dark, var_0_19)

	var_85_6:setPositionX(self:getContentSize().width - var_85_6:getContentSize().width / 2 * 0.56 + 4)
	var_85_6:setPositionY(self:getContentSize().height - var_85_6:getContentSize().height / 2 * 0.56 + 4)
	var_85_6:setScale(0.45)
	var_85_6:setName("careerIcon")
	self:addChild(var_85_6, var_0_21.INFO)

	local var_85_7 = cc.Label:createWithTTF("", FONT_NAME, 18)

	var_85_7:setName("nameLabel")
	var_85_7:setAnchorPoint(cc.p(1, 0.5))
	var_85_7:setPosition(cc.p(self:getContentSize().width - 2, 10))
	self:addChild(var_85_7, var_0_21.INFO)

	local var_85_8 = ccui.ImageView:create("public/rolebg/girlsprite_class_4.png", var_0_19)

	var_85_8:setAnchorPoint(cc.p(0.5, 0.5))
	var_85_8:setPositionX(14)
	var_85_8:setPositionY(var_85_7:getPositionY())
	var_85_8:setName("classNum")
	self:addChild(var_85_8, var_0_21.INFO)

	local var_85_9 = ccui.ImageView:create("public/rolebg/girlsprite_array_bg.png", var_0_19)

	var_85_9:setPositionX(115)
	var_85_9:setPositionY(150)
	var_85_9:setName("arraybg")
	self:addChild(var_85_9, var_0_21.INFO)

	local var_85_10 = ccui.Text:create("", FONT_NAME, 14)

	var_85_10:setPositionX(var_85_9:getContentSize().width / 2)
	var_85_10:setPositionY(var_85_9:getContentSize().height / 2)
	var_85_10:setName("arraylabel")
	var_85_9:addChild(var_85_10)

	local var_85_11 = ccui.ImageView:create("public/rolebg/girlselect_sprite_lock.png", var_0_19)

	var_85_11:setPositionX(self:getContentSize().width / 2 - 4)
	var_85_11:setPositionY(self:getContentSize().height / 2)
	var_85_11:setName("lockMask")
	self:addChild(var_85_11, var_0_21.INFO)

	local var_85_12 = ccui.ImageView:create("public/rolebg/girlselect_sprite_attr_bg.png", var_0_19)

	var_85_12:setPositionX(self:getContentSize().width / 2)
	var_85_12:setPositionY(self:getContentSize().height / 2)
	var_85_12:setName("attrBg")
	self:addChild(var_85_12, var_0_21.INFO)

	local var_85_13 = ccui.ImageView:create("public/rolebg/test_img.png", var_0_19)

	var_85_13:setPositionX(22)
	var_85_13:setPositionY(self:getContentSize().height - 13)
	var_85_13:setVisible(false)
	var_85_13:setName("testImg")
	self:addChild(var_85_13, var_0_21.INFO)

	local var_85_14 = 5
	local var_85_15 = 192
	local var_85_16 = {
		{
			L_GIRL_INFO_TABLE[1],
			[2] = "careerLabel"
		},
		{
			L_GIRL_INFO_TABLE[2],
			[2] = "lvLabel"
		},
		{
			L_GIRL_INFO_TABLE[3],
			[2] = "fightCapacityLabel"
		},
		{
			L_GIRL_INFO_TABLE[4],
			[2] = "attackLabel"
		},
		{
			L_GIRL_INFO_TABLE[5],
			[2] = "hpLabel"
		}
	}

	for iter_85_0 = 1, 5 do
		local var_85_17 = 18
		local var_85_19

		if var_85_16[iter_85_0][2] == "careerLabel" then
			var_85_17 = 18
			var_85_19 = 0
		else
			var_85_17 = 18
			var_85_19 = 0
		end

		local var_85_20 = cc.Label:createWithTTF(var_85_16[iter_85_0][1], FONT_DES, var_85_17)

		var_85_20:setPosition(cc.p(var_85_14, var_85_15 + var_85_19))
		var_85_20:setAnchorPoint(cc.p(0, 1))
		var_85_20:setColor(cc.c3b(255, 255, 255))
		var_85_20:setName("label1_" .. iter_85_0)
		var_85_12:addChild(var_85_20)

		local var_85_21 = cc.Label:createWithTTF("", FONT_DES, var_85_17)

		var_85_21:setPosition(cc.p(var_85_20:getContentSize().width + var_85_14, var_85_15 + var_85_19))
		var_85_21:setAnchorPoint(cc.p(0, 1))
		var_85_21:setName(var_85_16[iter_85_0][2])
		var_85_21:setColor(cc.c3b(255, 255, 255))
		var_85_12:addChild(var_85_21)

		var_85_15 = var_85_15 - var_85_17
	end

	local var_85_22 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_19)

	var_85_22:setName("reddot")
	var_85_22:setPositionX(self:getContentSize().width)
	var_85_22:setPositionY(self:getContentSize().height)
	self:addChild(var_85_22, var_0_21.INFO)

	if arg_85_1 and arg_85_1.isHpInherit then
		self:createHpBar(arg_85_1)
	end
end

function HelpBattleSprite:createHpBar(arg_86_1)
	if config._DEBUG then
		self.sprBg = cc.Sprite:create("fight/hp_bg_inherit_4.png") or cc.Sprite:createWithSpriteFrameName("fight/hp_bg_inherit_4.png")
	end

	self.sprBg:setAnchorPoint(cc.p(0, 0.5))
	self.sprBg:setPosition(cc.p(5, 12))
	self:addChild(self.sprBg, var_0_21.INFO)

	self.progressTimer = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("fight/hp_bar_inherit_4.png") or cc.Sprite:createWithSpriteFrameName("fight/hp_bar_inherit_4.png")))

	self:addChild(self.progressTimer, var_0_21.INFO, "progressTimer")
	self.progressTimer:setAnchorPoint(cc.p(0, 0.5))
	self.progressTimer:setPosition(cc.p(-4, 10))
	self.progressTimer:setMidpoint(cc.p(0, 0.5))
	self.progressTimer:setBarChangeRate(cc.p(1, 0))
	self.progressTimer:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.progressTimer:setPercentage(100)

	self.labelHp = cc.Label:createWithTTF("100%", "fonts/new1.ttf", 13)

	self.labelHp:setAnchorPoint(cc.p(1, 0.5))
	self.labelHp:setPosition(cc.p(self.progressTimer:getContentSize().width, 6))
	self.labelHp:enableOutline(cc.c4b(0, 0, 0, 255), 1)
	self.labelHp:setAlignment(cc.TEXT_ALIGNMENT_RIGHT, cc.TEXT_ALIGNMENT_CENTER)
	self.labelHp:enableOutline(cc.c4b(255, 255, 255, 220), 1)
	self.progressTimer:addChild(self.labelHp)
	self.labelHp:setVisible(false)
	self:adjustElementPositionY(16)
end

function HelpBattleSprite:adjustElementPositionY(arg_87_1)
	if self.diff == arg_87_1 then
		return
	end

	self.diff = arg_87_1

	local var_87_0 = {}

	var_87_0[#var_87_0 + 1] = self:getChildByName("lvLabel")
	var_87_0[#var_87_0 + 1] = self:getChildByName("nameLabel")

	local var_87_1 = self.clipPanel:getChildByName("nameBg")

	var_87_0[#var_87_0 + 1] = self:getChildByName("lvIcon")

	local var_87_2 = self:getChildByName("careerIcon")

	var_87_0[#var_87_0 + 1] = self:getChildByName("breakoutIcon")

	for iter_87_0, iter_87_1 in ipairs(var_87_0) do
		if iter_87_1 then
			iter_87_1:setPositionY(iter_87_1:getPositionY() + arg_87_1)
		end
	end
end

function HelpBattleSprite:showHpBar(arg_88_1)
	if not self.progressTimer or not self.labelHp or not self.sprBg then
		return
	end

	if not playermodel.haveServant[arg_88_1] then
		self.progressTimer:setVisible(false)
		self.labelHp:setVisible(false)
		self.sprBg:setVisible(false)
		self:adjustElementPositionY(-16)
	else
		self.progressTimer:setVisible(true)
		self.labelHp:setVisible(true)
		self.sprBg:setVisible(true)
		self:adjustElementPositionY(16)
	end

	local var_88_0 = explore_manager:getHpInherit(arg_88_1)

	self.progressTimer:setPercentage(var_88_0 * 100)
	self.labelHp:setString(math.round(var_88_0 * 100) .. "%")

	if var_88_0 <= 0 then
		self:lockGirlByLowerHp()
	elseif self.maskBattle then
		self.maskBattle:setVisible(false)
	end
end

function HelpBattleSprite:update(arg_89_1, arg_89_2)
	self.servantid = arg_89_1

	local var_89_0 = core_manager:getServantCoreRank(arg_89_1)
	local var_89_1 = self:getChildByName("lvLabel")
	local var_89_2 = self.clipPanel:getChildByName("girlHeadImg")

	var_89_2:loadTexture("roleimage/role/shop_image/" .. model_data[global_get_servant_skin(arg_89_1)].role_image .. ".png")
	var_89_2:setAnchorPoint(cc.p(0.5, self.clipPanel:getContentSize().height / var_89_2:getContentSize().height / 2))
	var_89_1:setString("等级." .. core_manager:getCoreLv(arg_89_1))
	var_89_1:setColor(cc.c3b(255, 255, 255))
	self:getChildByName("rarityIcon"):loadTexture("public/rolebg/girlselect_rarity_" .. souls_manager:get_servant_cur_roll_rarity(arg_89_1) .. ".png", var_0_19)
	self:getChildByName("breakoutIcon"):loadTexture("public/rolebg/breakout_" .. var_89_0 .. ".png", var_0_19)
	self:getChildByName("breakoutIcon"):setPositionX(12)
	self:getChildByName("careerIcon"):loadTexture(CAREER_ICON[servant_data[arg_89_1].career .. "_" .. var_0_20(arg_89_1)], var_0_19)

	local var_89_3 = playermodel.soulOverClock[arg_89_1] or 0

	if playermodel.soulContract[arg_89_1] > 0 and var_89_3 == 0 then
		self:getChildByName("classNum"):setVisible(true)
		self:getChildByName("classNum"):loadTexture("public/rolebg/girlsprite_class_" .. playermodel.soulContract[arg_89_1] .. ".png", var_0_19)
	elseif var_89_3 > 0 then
		self:getChildByName("classNum"):setVisible(true)
		self:getChildByName("classNum"):loadTexture("public/rolebg/girlsprite_class_oc.png", var_0_19)
	else
		self:getChildByName("classNum"):setVisible(false)
	end

	self:getChildByName("lvIcon"):setPositionX(var_89_1:getPositionX() - var_89_1:getContentSize().width - 12)
	self:getChildByName("nameLabel"):setString(major_factor_data[servant_data[arg_89_1].major].easy_name)

	if playermodel.haveServant[arg_89_1] then
		ccui.Helper:seekWidgetByName(self, "lockMask"):setVisible(false)
		var_89_1:setVisible(true)
		self:getChildByName("breakoutIcon"):setVisible(var_89_0 > 0)

		if arg_89_2 then
			self:getChildByName("attrBg"):setVisible(true)

			local var_89_4 = model_manager.new()

			var_89_4:initPlayerAttribute(arg_89_1)

			if playermodel.haveServant[arg_89_1] and playermodel.weaponId[arg_89_1] then
				var_89_4:updateWeaponAttr((weapon_manager:getWeaponConfig(playermodel.items[playermodel.weaponId[arg_89_1]])))
			end

			local var_89_5, var_89_6 = component_manager:getSoulComponentlist(arg_89_1)

			var_89_4:updateComponentAttr(var_89_5)

			local var_89_7 = self:getChildByName("attrBg"):getChildByName("lvLabel")
			local var_89_8 = self:getChildByName("attrBg"):getChildByName("attackLabel")
			local var_89_9 = self:getChildByName("attrBg"):getChildByName("hpLabel")
			local var_89_10 = self:getChildByName("attrBg"):getChildByName("careerLabel")
			local var_89_11 = self:getChildByName("attrBg"):getChildByName("fightCapacityLabel")

			if playermodel.haveServant[arg_89_1] then
				local var_89_12 = var_0_16:getBonusByServantId(arg_89_1)
				local var_89_13 = core_manager:getServantCoreRank(arg_89_1)

				var_89_7:setString(playermodel.cores[arg_89_1].extra)
				var_89_8:setString(var_89_12.value.damage)
				var_89_9:setString(var_89_12.value.hp)
				var_89_10:setString(L_CAREER[SERVANT_CAREE_TBL[var_89_4:getAttribute("career")]])
				var_89_11:setString(fight_capacity_manager:getSoulFightCapacity(arg_89_1))
				self:getChildByName("attrBg"):getChildByName("label1_1"):setVisible(true)
				self:getChildByName("attrBg"):getChildByName("label1_2"):setVisible(true)
				self:getChildByName("attrBg"):getChildByName("label1_3"):setVisible(true)
				self:getChildByName("attrBg"):getChildByName("label1_4"):setVisible(true)
				self:getChildByName("attrBg"):getChildByName("label1_5"):setVisible(true)
				var_89_7:setVisible(true)
				var_89_8:setVisible(true)
				var_89_9:setVisible(true)
				var_89_10:setVisible(true)
				var_89_11:setVisible(true)
			else
				self:getChildByName("attrBg"):getChildByName("label1_1"):setVisible(false)
				self:getChildByName("attrBg"):getChildByName("label1_2"):setVisible(false)
				self:getChildByName("attrBg"):getChildByName("label1_3"):setVisible(false)
				self:getChildByName("attrBg"):getChildByName("label1_4"):setVisible(false)
				self:getChildByName("attrBg"):getChildByName("label1_5"):setVisible(false)
				var_89_7:setVisible(false)
				var_89_8:setVisible(false)
				var_89_9:setVisible(false)
				var_89_10:setVisible(false)
				var_89_11:setVisible(false)
			end
		else
			self:getChildByName("attrBg"):setVisible(false)
		end
	else
		ccui.Helper:seekWidgetByName(self, "lockMask"):setVisible(true)
		var_89_1:setVisible(false)
		self:getChildByName("breakoutIcon"):setVisible(false)
		self:getChildByName("attrBg"):setVisible(false)
	end

	self:getChildByName("reddot"):setVisible(false)
	self:showHpBar(arg_89_1)
end

function HelpBattleSprite:lockGirlByLowerHp()
	ccui.Helper:seekWidgetByName(self, "lvLabel"):setVisible(false)
	self:getChildByName("breakoutIcon"):setVisible(false)
	self:getChildByName("attrBg"):setVisible(false)

	if self.maskBattle then
		self.maskBattle:setVisible(true)
	else
		self.maskBattle = ccui.ImageView:create("fight/can_not_battle.png", var_0_19)

		self.maskBattle:setAnchorPoint(0, 0)
		self:addChild(self.maskBattle, var_0_21.INFO)
	end
end

function HelpBattleSprite.updateArrayTag(arg_91_0, arg_91_1)
	if not arg_91_1 then
		ccui.Helper:seekWidgetByName(arg_91_0, "arraybg"):setVisible(false)
	else
		ccui.Helper:seekWidgetByName(arg_91_0, "arraybg"):setVisible(true)
		ccui.Helper:seekWidgetByName(arg_91_0, "arraylabel"):setString(glabal_trans_text_horizontal_to_vertical(arg_91_1))
	end
end

function HelpBattleSprite:startPressBar(arg_92_1, arg_92_2, arg_92_3)
	if not self.pressBar then
		self:createPressBar()
	end

	local var_92_0 = arg_92_3 or 0.3
	local var_92_1 = 0

	self.pressBar:setVisible(true)
	self.pressBar:setPercentage(0)
	self.pressBar:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
		self.pressBar:setPercentage(var_92_1 / var_92_0 * 100)

		if var_92_1 > var_92_0 then
			self.pressBar:stopAllActions()

			if arg_92_1 then
				arg_92_1()
			end
		end

		var_92_1 = var_92_1 + 0.016666666666666666

		if arg_92_2 then
			arg_92_2(0.016666666666666666)
		end
	end))))
end

function HelpBattleSprite:endPressBar()
	if not self.pressBar then
		return
	end

	self.pressBar:setVisible(false)
	self.pressBar:stopAllActions()
end

function HelpBattleSprite:createPressBar()
	self.pressBar = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("public/button/press_bar.png") or cc.Sprite:createWithSpriteFrameName("public/button/press_bar.png")))

	self.pressBar:setScale(0.8)
	self.pressBar:setAnchorPoint(cc.p(0.5, 0.5))
	self.pressBar:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
	self.pressBar:setPositionX(self:getContentSize().width / 2)
	self.pressBar:setPositionY(self:getContentSize().height / 2)
	self.pressBar:setReverseDirection(true)
	self:addChild(self.pressBar, var_0_21.PRESSBAR)
end

function HelpBattleSprite:imgScaleTo(arg_96_1, arg_96_2)
	self.clipPanel:getChildByName("girlHeadImg"):runAction(cc.ScaleTo:create(arg_96_2, self.scale * arg_96_1, self.scale * arg_96_1))
end

function HelpBattleSprite:endPressBar()
	if not self.pressBar then
		return
	end

	self.pressBar:setVisible(false)
	self.pressBar:stopAllActions()
end

function HelpBattleSprite:updateByFalseLevel(arg_98_1, arg_98_2, arg_98_3)
	if arg_98_2 == core_manager:getServantCoreRank(arg_98_1) and playermodel.cores[arg_98_1].level == arg_98_3 then
		self:stopFalseLevelAni()
	else
		self:getChildByName("breakoutIcon"):loadTexture("public/rolebg/breakout_" .. arg_98_2 .. ".png", var_0_19)

		local var_98_0 = self:getChildByName("lvLabel")

		var_98_0:setColor(cc.c3b(206, 255, 167))
		var_98_0:setFontSize(18)
		var_98_0:setString("" .. arg_98_3)

		local var_98_1 = true

		var_98_0:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(2), cc.CallFunc:create(function(...)
			if var_98_1 then
				var_98_0:setFontSize(12)
				var_98_0:setString("等级提升中")
			else
				var_98_0:setFontSize(18)
				var_98_0:setString("" .. arg_98_3)
			end

			var_98_1 = not var_98_1
		end), cc.FadeIn:create(2))))
		self:getChildByName("breakoutIcon"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(2), cc.CallFunc:create(function(...)
			return
		end), cc.FadeIn:create(2))))
	end
end

function HelpBattleSprite:stopFalseLevelAni()
	if not self.servantid then
		return
	end

	local var_101_0 = core_manager:getServantCoreRank(self.servantid)

	self:getChildByName("breakoutIcon"):stopAllActions()
	self:getChildByName("lvLabel"):stopAllActions()
	self:getChildByName("breakoutIcon"):setOpacity(255)
	self:getChildByName("breakoutIcon"):loadTexture("public/rolebg/breakout_" .. var_101_0 .. ".png", var_0_19)
	self:getChildByName("lvLabel"):setOpacity(255)
	self:getChildByName("lvLabel"):setFontSize(18)
	self:getChildByName("lvLabel"):setString("" .. core_manager:getCoreLv(self.servantid))
	self:getChildByName("lvLabel"):setColor(cc.c3b(234, 238, 245))
end
