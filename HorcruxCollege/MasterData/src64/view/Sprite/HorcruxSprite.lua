local var_0_0 = config._DEBUG and 0 or 1

HorcruxSprite = class("HorcruxSprite", function()
	return ccui.Button:create("public/rolebg/horcrux_bag_rarity_1.png", "public/rolebg/horcrux_bag_rarity_1.png", "public/rolebg/horcrux_bag_rarity_1.png", var_0_0)
end)

local playermodel = require("model.playermodel")
local horcrux_data = require("data.horcrux_data")
local model_data = require("data.model_data")
local total_skill_data = require("data.total_skill_data")
local item_data = require("data.item_data")
local var_0_6 = require("data.total_skill_data")
local horcrux_manager = require("controller.horcrux_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local array_manager = require("controller.array_manager")
local substitution_manager = require("controller.substitution_manager")
local arenatft_manager = require("controller.arenatft_manager")
local servant_data = require("data.servant_data")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_14 = L_NUMBER_TEXT
local var_0_15 = 1
local var_0_17 = {
	SELECTED = 103,
	LOCK = 101,
	DECOMPOSE = 123,
	PRESSBAR = 111,
	HOOK = 124,
	ICON = 3,
	INFO = 7,
	SKILLPANEL = 120,
	ATTR = 4,
	SERVANT = 122,
	RECOMMEND = 122,
	SKILL = 10,
	REDDOT = 104,
	BG = 0,
	BACKPANEL = 5,
	RACE = 121
}
local var_0_18 = {
	RED_DOT_BAG = 3,
	NEW_ICON = 1,
	RED_DOT = 2
}

local function var_0_19(arg_2_0)
	return global_get_model_attr(horcrux_data[arg_2_0].model)
end

local var_0_20 = "public/rolebg/horcrux_new.png"
local var_0_21 = {
	[var_0_18.NEW_ICON] = function(arg_3_0)
		return playermodel.items[arg_3_0].new
	end,
	[var_0_18.RED_DOT] = function(arg_4_0)
		return horcrux_manager:isTipsHorcruxUpgrade(arg_4_0)
	end,
	[var_0_18.RED_DOT_BAG] = function(arg_5_0)
		return horcrux_manager:horcruxBagIsTipsHorcruxUpgrade(arg_5_0) or horcrux_manager:horcruxBagCanBreakOut(arg_5_0)
	end
}

function HorcruxSprite.create(arg_6_0, arg_6_1)
	local var_6_0
	local var_6_1 = {
		detailedStyle = function()
			var_6_0 = HorcruxDetailedStyleSprite.new()

			var_6_0:init()
		end,
		previewStyle = function()
			var_6_0 = HorcruxPreviewStyleSprite.new()

			var_6_0:init(arg_6_1)
		end,
		previewTopStype = function()
			var_6_0 = HorcruxPreviewTopStyleSprite.new()

			var_6_0:init()
		end,
		arrayMemberStyle = function()
			var_6_0 = HorcruxArrayMemberStyleSprite.new()

			var_6_0:init()
		end,
		arrayMemberMainStyle = function()
			var_6_0 = HorcruxArrayMemberMainStyleSprite.new()

			var_6_0:init()
		end,
		arrayMemberModeStyle = function()
			var_6_0 = HorcruxArrayMemberModeStyleSprite.new()

			var_6_0:init()
		end,
		enemyArrayMemberStyle = function()
			var_6_0 = HorcruxEnemyArrayMemberStyleSprite.new()

			var_6_0:init()
		end,
		enemyArrayMemberFormationStyle = function()
			var_6_0 = HorcruxEnemyArrayMemberFormationStyleSprite.new()

			var_6_0:init()
		end,
		enemyScoreArenaArrayMemberStyle = function()
			var_6_0 = HorcruxEnemyScoreArenaArrayMemberStyleSprite.new()

			var_6_0:init()
		end,
		patrolStyle = function()
			var_6_0 = HorcruxPatrolStyleSprite.new()

			var_6_0:init()
		end,
		areanAttackStyle = function()
			var_6_0 = HorcruxAreanAttackSprite.new()

			var_6_0:init()
		end,
		areanDefenceStyle = function()
			var_6_0 = HorcruxAreanDefenceSprite.new()

			var_6_0:init()
		end,
		subStyle = function()
			var_6_0 = HorcruxSubSprite.new()

			var_6_0:init()
		end,
		tvtDefenceStyle = function()
			var_6_0 = HorcruxTvtDefenceSprite.new()

			var_6_0:init()
		end,
		tvtAttackStyle = function()
			var_6_0 = HorcruxTvtAttackSprite.new()

			var_6_0:init()
		end
	}

	if arg_6_1 and var_6_1[arg_6_1.initType] then
		var_6_1[arg_6_1.initType]()
	else
		var_6_0 = HorcruxDefaultSprite.new()

		var_6_0:init()
	end

	return var_6_0
end

function HorcruxSprite.getAttr(arg_22_0, arg_22_1)
	return global_get_model_attr(horcrux_data[arg_22_1].model)
end

function HorcruxSprite:updateLockIcon()
	if self:getChildByName("lock") then
		self:getChildByName("lock"):setVisible(playermodel.items[self.entityid].horcrux_attr.lock)
	end
end

function HorcruxSprite:setLockIconVisible(arg_24_1)
	if self:getChildByName("lock") then
		self:getChildByName("lock"):setVisible(arg_24_1)
	end
end

function HorcruxSprite:setReddotVisible(arg_25_1)
	if self:getChildByName("redDot") then
		self:getChildByName("redDot"):setVisible(arg_25_1)
	end
end

function HorcruxSprite:updateHorcruxInfos(arg_26_1, arg_26_2, arg_26_3)
	self:update(arg_26_1, arg_26_2, arg_26_3)
end

function HorcruxSprite:updateFrameBg(arg_27_1)
	if arg_27_1 then
		if self:getChildByName("heightLight") then
			self:getChildByName("heightLight"):setVisible(true)

			if self:getChildByName("heightLight").play then
				self:getChildByName("heightLight"):play()
			end
		else
			self.createItemHightLight(self, self)
		end
	else
		self:removeChild(self.selectBg, true)
	end
end

function HorcruxSprite:startPressBar(arg_28_1, arg_28_2)
	if not self.pressBar then
		self:createPressBar()
	end

	local var_28_0 = 0.3
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

function HorcruxSprite:endPressBar()
	if not self.pressBar then
		return
	end

	self.pressBar:setVisible(false)
	self.pressBar:stopAllActions()
end

function HorcruxSprite:createPressBar()
	self.pressBar = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("public/button/press_bar.png") or cc.Sprite:createWithSpriteFrameName("public/button/press_bar.png")))

	self.pressBar:setScale(0.6)
	self.pressBar:setAnchorPoint(cc.p(0.5, 0.5))
	self.pressBar:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
	self.pressBar:setPositionX(self:getContentSize().width / 2)
	self.pressBar:setPositionY(self:getContentSize().height / 2)
	self.pressBar:setReverseDirection(true)
	self:addChild(self.pressBar, var_0_17.PRESSBAR)
end

function HorcruxSprite.getStringInsertChar(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = ""
	local var_32_1 = 1

	repeat
		c = string.sub(arg_32_1, var_32_1, var_32_1)
		b = string.byte(c)

		local var_32_2 = {
			0,
			192,
			224,
			240,
			248,
			252
		}
		local var_32_3 = #var_32_2

		while var_32_2[var_32_3] do
			if b >= var_32_2[var_32_3] then
				var_32_0 = var_32_0 .. string.sub(arg_32_1, var_32_1, var_32_1 + var_32_3 - 1) .. arg_32_2
				var_32_1 = var_32_1 + var_32_3

				break
			end

			var_32_3 = var_32_3 - 1
		end

		if var_32_3 == 0 then
			var_32_1 = var_32_1 + 1
		end
	until var_32_1 > #arg_32_1

	return var_32_0
end

function HorcruxSprite.updateRedDot(arg_33_0, arg_33_1)
	ccui.Helper:seekWidgetByName(arg_33_0, "redDot"):setVisible(arg_33_1)
end

function HorcruxSprite:updateAlert(arg_34_1)
	self:updateRedDot(self:isShowRedDot(arg_34_1))
end

function HorcruxSprite.isShowRedDot(arg_35_0, arg_35_1)
	return horcrux_manager:isTipsHorcruxUpgrade(arg_35_1)
end

function HorcruxSprite:updateRaceIcon(arg_36_1)
	self:getChildByName("raceIcon"):loadTexture("public/rolebg/" .. horcrux_manager:getRaceByEntityid(arg_36_1) .. ".png", var_0_0)
end

function HorcruxSprite:updateRaceIconByItemid(arg_37_1)
	self:getChildByName("raceIcon"):loadTexture("public/rolebg/" .. horcrux_manager:getRaceByItemid(arg_37_1) .. ".png", var_0_0)
end

HorcruxDefaultSprite = class("HorcruxDefaultSprite", function()
	return HorcruxSprite.new()
end)

function HorcruxDefaultSprite:init()
	self:loadTextures("public/rolebg/horcrux_bag_rarity_1.png", "public/rolebg/horcrux_bag_rarity_1.png", "public/rolebg/horcrux_bag_rarity_1.png", var_0_0)
	self:setAnchorPoint(cc.p(0.5, 0.5))
	self:initFrameBg()
	self:initHocruxRole()
end

local var_0_22 = cc.p(0.5, 0)
local var_0_23 = cc.p(90, 25)
local var_0_24 = 0.65
local var_0_25 = "public/currency/weapon_star.png"
local var_0_26 = "public/currency/weapon_star.png"
local var_0_27 = "public/box/used_on.png"
local var_0_28 = "public/box/used_on.png"

function HorcruxDefaultSprite:initFrameBg()
	self.frameBg = ccui.ImageView:create("public/rolebg/horcrux_bag_rarity_1.png", var_0_0)

	self.frameBg:setAnchorPoint(cc.p(0.5, 0.5))
	self.frameBg:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height / 2))
	self:addChild(self.frameBg, var_0_17.BG)

	local var_40_0 = {
		cc.p(180, 60),
		cc.p(180, 84),
		cc.p(180, 108),
		cc.p(180, 132),
		cc.p(180, 156)
	}

	for iter_40_0 = 1, 5 do
		local var_40_1 = ccui.ImageView:create(var_0_26, var_0_0)

		var_40_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_40_1:setPosition(var_40_0[iter_40_0])
		var_40_1:setName("star_" .. iter_40_0)
		self:addChild(var_40_1, var_0_17.INFO)
	end

	local var_40_2 = cc.Label:createWithTTF("???", FONT_NAME, 22)

	var_40_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_40_2:setPosition(cc.p(self:getContentSize().width / 2 + 25, 18))
	var_40_2:setColor(cc.c3b(195, 189, 211))
	var_40_2:setName("name")
	self:addChild(var_40_2, var_0_17.INFO)

	local var_40_3 = ccui.ImageView:create("public/rolebg/horcrux_+5.png", var_0_0)

	var_40_3:setPosition(cc.p(120, 275))
	var_40_3:setName("grade")
	var_40_3:setVisible(true)
	self:addChild(var_40_3, var_0_17.INFO)

	local var_40_4 = ccui.ImageView:create("public/rolebg/horcru_bag_bg.png", var_0_0)

	var_40_4:setPosition(cc.p(83, 48))
	var_40_4:setName("levelBg")
	lvBg:setScaleX(self:getContentSize().width / lvBg:getContentSize().width)
	self:addChild(var_40_4, var_0_17.INFO - 1)

	local var_40_5 = ccui.ImageView:create(CAREER_ICON.tank_wind, var_0_0)

	var_40_5:setAnchorPoint(cc.p(0.5, 0.5))
	var_40_5:setPosition(cc.p(var_40_5:getContentSize().width / 2, var_40_5:getContentSize().height / 2 - 2))
	var_40_5:setName("attr")
	self:addChild(var_40_5, var_0_17.INFO)

	local var_40_6 = cc.Label:createWithTTF("???", FONT_DES, 22)

	var_40_6:setAnchorPoint(cc.p(0, 0.5))
	var_40_6:setPosition(cc.p(72, 46))
	var_40_6:setColor(cc.c3b(255, 255, 255))
	var_40_6:setName("lvLabel")
	self:addChild(var_40_6, var_0_17.INFO)

	local var_40_7 = ccui.ImageView:create(var_0_27, var_0_0)

	var_40_7:setAnchorPoint(cc.p(0.5, 0.5))
	var_40_7:setScale9Enabled(true)
	var_40_7:setCapInsets(cc.rect(50, 20, 1, 1))
	var_40_7:setContentSize(cc.size(self:getContentSize().width - 6, var_40_7:getContentSize().height))
	var_40_7:setPosition(cc.p(self:getContentSize().width / 2, 80))
	var_40_7:setName("fightingtag")

	local var_40_8 = cc.Label:createWithTTF(L_HORCRUXSELECT_FIGHT_TAG, "fonts/newkj.ttf", 22)

	var_40_8:setColor(cc.c3b(255, 100, 0))
	var_40_8:setPosition(cc.p(var_40_7:getContentSize().width / 2, var_40_7:getContentSize().height / 2))
	var_40_8:setName("fightlabel")
	var_40_7:addChild(var_40_8)
	self:addChild(var_40_7, var_0_17.INFO - 1)

	local var_40_9 = ccui.ImageView:create(var_0_28, var_0_0)

	var_40_9:setAnchorPoint(cc.p(0.5, 0.5))
	var_40_9:setScale9Enabled(true)
	var_40_9:setCapInsets(cc.rect(50, 20, 1, 1))
	var_40_9:setContentSize(cc.size(self:getContentSize().width - 6, var_40_9:getContentSize().height))
	var_40_9:setPosition(cc.p(self:getContentSize().width / 2, 80))
	var_40_9:setName("workingtag")

	local var_40_10 = cc.Label:createWithTTF(L_HORCRUXSELECT_WORK_TAG, "fonts/newkj.ttf", 22)

	var_40_10:setColor(cc.c3b(255, 100, 0))
	var_40_10:setPosition(cc.p(var_40_9:getContentSize().width / 2, var_40_9:getContentSize().height / 2))
	var_40_9:addChild(var_40_10)
	self:addChild(var_40_9, var_0_17.INFO - 1)

	local var_40_11 = ccui.Layout:create()

	var_40_11:setContentSize(cc.size(190, 260))
	var_40_11:setAnchorPoint(cc.p(0.5, 0.5))
	var_40_11:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height / 2 + 12))
	var_40_11:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_40_11:setBackGroundColor(cc.c3b(0, 0, 0))
	var_40_11:setBackGroundColorOpacity(200)
	var_40_11:setVisible(false)
	var_40_11:setName("skillBg")
	self:addChild(var_40_11, var_0_17.ATTR)

	local var_40_12 = ccui.Button:create("public/button/unlock.png", nil, "public/button/unlock.png", var_0_0)

	var_40_12:setPosition(cc.p(self:getContentSize().width - 25, self:getContentSize().height - 30))
	var_40_12:setName("lock")
	var_40_12:setVisible(false)
	var_40_12:setScale(0.7)
	self:addChild(var_40_12, var_0_17.LOCK)

	local var_40_13 = ccui.ImageView:create(SMALL_RARITY_ICON[1], var_0_0)

	var_40_13:setAnchorPoint(cc.p(0, 1))
	var_40_13:setPosition(cc.p(6, self:getContentSize().height - 8))
	var_40_13:setName("rarityIcon")
	self:addChild(var_40_13, var_0_17.INFO)

	local var_40_14 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

	var_40_14:setPositionX(self:getContentSize().width - 10)
	var_40_14:setPositionY(self:getContentSize().height - 10)
	var_40_14:setName("redDot")
	self:addChild(var_40_14, var_0_17.REDDOT)
end

function HorcruxDefaultSprite:initHocruxRole()
	self.horcruxPanel = ccui.Layout:create()

	self.horcruxPanel:setContentSize(cc.size(190, 260))
	self.horcruxPanel:setAnchorPoint(cc.p(0.5, 0))
	self.horcruxPanel:setPosition(cc.p(self:getContentSize().width / 2, 26))
	self.horcruxPanel:setClippingEnabled(true)
	self:addChild(self.horcruxPanel, var_0_17.ICON)

	local var_41_0 = ccui.ImageView:create("GUI/image.png", var_0_0)

	var_41_0:setAnchorPoint(var_0_22)
	var_41_0:setPosition(var_0_23)
	var_41_0:setScale(var_0_24)
	var_41_0:setName("horcrux")
	self.horcruxPanel:addChild(var_41_0)
end

function HorcruxDefaultSprite:update(arg_42_1, arg_42_2)
	self.entityid = arg_42_1
	arg_42_2 = arg_42_2 or false

	local var_42_0 = playermodel.items[arg_42_1].itemid
	local var_42_1 = (item_data[playermodel.items[arg_42_1].itemid].image_offse_x or 0) * (self.scale or 1)
	local var_42_2 = (item_data[var_42_0].image_offset_y or 0) * (self.scale or 1)

	self.frameBg:loadTexture("public/rolebg/horcrux_bag_rarity_" .. horcrux_data[var_42_0].rarity .. ".png", var_0_0)

	local var_42_3 = self:getChildByName("skillBg")

	var_42_3:setVisible(arg_42_2)

	if arg_42_2 then
		local var_42_5
		local var_42_6

		if not var_42_3:getChildByName("fightCapacityLabel") then
			var_42_6 = cc.Label:createWithTTF("", FONT_DES, 26)

			var_42_6:setAnchorPoint(cc.p(0, 0.5))
			var_42_6:setPosition(cc.p(5, var_42_3:getContentSize().height - 70))
			var_42_6:setCascadeOpacityEnabled(false)
			var_42_6:setColor(cc.c3b(255, 150, 0))
			var_42_6:setName("fightCapacityLabel")
			var_42_3:addChild(var_42_6)
		else
			var_42_6 = var_42_3:getChildByName("fightCapacityLabel")
		end

		if not var_42_3:getChildByName("damageLabel") then
			var_42_5 = cc.Label:createWithTTF("", FONT_DES, 26)

			var_42_5:setAnchorPoint(cc.p(0, 0.5))
			var_42_5:setPosition(cc.p(5, var_42_6:getPositionY() - 40))
			var_42_5:setCascadeOpacityEnabled(false)
			var_42_5:setName("damageLabel")
			var_42_3:addChild(var_42_5)
		else
			var_42_5 = var_42_3:getChildByName("damageLabel")
		end

		if not var_42_3:getChildByName("hpLabel") then
			local var_42_7 = cc.Label:createWithTTF("", FONT_DES, 26)

			var_42_7:setAnchorPoint(cc.p(0, 0.5))
			var_42_7:setPosition(cc.p(5, var_42_5:getPositionY() - 60))
			var_42_7:setCascadeOpacityEnabled(false)
			var_42_7:setName("hpLabel")
			var_42_3:addChild(var_42_7)
		else
			local var_42_8 = var_42_3:getChildByName("hpLabel")
		end

		local var_42_9 = var_42_3:getChildByName("hpLabel")
		local var_42_10 = var_42_3:getChildByName("damageLabel")
		local var_42_11 = horcrux_manager:getHorcruxAssistConfig(arg_42_1)
		local var_42_12
		local var_42_13

		if horcrux_manager:getHorcruxHClass(arg_42_1) > 0 then
			var_42_12 = horcrux_manager:getHorcruxDamageFac(self.entityid) / 100 + horcrux_manager:getHorcruxDamageFacAdditionByEntityid(self.entityid) / 100
			var_42_13 = math.floor(horcrux_manager:getHorcruxHpFac(self.entityid) / 100 + horcrux_manager:getHorcruxHpFacAdditionByEntityid(self.entityid) / 100)
		else
			var_42_12 = horcrux_manager:getHorcruxDamageFac(self.entityid) / 100
			var_42_13 = math.floor(horcrux_manager:getHorcruxHpFac(self.entityid) / 100)
		end

		var_42_9:setString(L_GIRL_INFO_TABLE[5] .. math.floor(var_42_11.hp) .. "\n(" .. var_42_13 .. ")")
		var_42_10:setString(L_GIRL_INFO_TABLE[4] .. math.floor(var_42_11.damage) .. "\n(" .. var_42_12 .. ")")
		var_42_6:setString(L_GIRL_INFO_TABLE[3] .. fight_capacity_manager:getHorcruxAddition(arg_42_1))
	end

	self.horcruxPanel:getChildByName("horcrux"):setPositionX(var_0_23.x + var_42_1)
	self.horcruxPanel:getChildByName("horcrux"):setPositionY(var_0_23.y + var_42_2)
	TextureManager:loadImageViewTexture(nil, self.horcruxPanel:getChildByName("horcrux"), CUTE_ROLE_IMAGE_PATH .. model_data[horcrux_data[playermodel.items[arg_42_1].itemid].model].cute_Q .. ".png")
	global_load_star(self, horcrux_manager:getHorcruxStarLevel(arg_42_1), nil, "star_")

	local var_42_15 = horcrux_manager:getHorcruxHClass(self.entityid)

	self:getChildByName("name"):setString(horcrux_data[var_42_0].name)
	self:getChildByName("lvLabel"):setString("等级." .. horcrux_manager:getHorcruxHLV(arg_42_1))
	self:getChildByName("attr"):loadTexture(CAREER_ICON[horcrux_data[var_42_0].career .. "_" .. self:getAttr(var_42_0)], var_0_0)
	self:getChildByName("grade"):loadTexture("public/rolebg/horcrux_+" .. var_42_15 .. ".png", var_0_0)
	self:getChildByName("grade"):setVisible(var_42_15 > 0)

	local var_42_16 = array_manager:getArrayByHorcruxID(arg_42_1)

	if var_42_16 then
		self:getChildByName("fightingtag"):setVisible(true)
		self:getChildByName("fightingtag"):getChildByName("fightlabel"):setString(L_TEAM .. var_42_16)
		self:getChildByName("workingtag"):setVisible(false)
	elseif playermodel.items[arg_42_1].horcrux_attr.working then
		self:getChildByName("fightingtag"):setVisible(false)
		self:getChildByName("workingtag"):setVisible(true)
	else
		self:getChildByName("fightingtag"):setVisible(false)
		self:getChildByName("workingtag"):setVisible(false)
	end

	self:getChildByName("rarityIcon"):loadTexture(SMALL_RARITY_ICON[horcrux_data[var_42_0].rarity], var_0_0)
	self:getChildByName("lock"):setVisible(playermodel.items[arg_42_1].horcrux_attr.lock)
	self:updateAlert(arg_42_1)
end

function HorcruxDefaultSprite:createItemHightLight(arg_43_1)
	self.selectBg = ccui.Layout:create()

	local var_43_2

	if config._DEBUG then
		var_43_2 = cc.Sprite:create("public/rolebg/new_item_bg_on1.png") or cc.Sprite:createWithSpriteFrameName("public/rolebg/new_item_bg_on1.png")
	end

	var_43_2:setPosition(arg_43_1:getContentSize().width / 2, arg_43_1:getContentSize().height / 2 - 3)
	self.selectBg:addChild(var_43_2)

	local var_43_3 = {}

	for iter_43_0 = 1, 2 do
		if iter_43_0 == 1 then
			if config._DEBUG then
				var_43_3[iter_43_0] = cc.Sprite:create("public/rolebg/new_item_bg_on2.png") or cc.Sprite:createWithSpriteFrameName("public/rolebg/new_item_bg_on2.png")
			end
		elseif config._DEBUG then
			var_43_3[iter_43_0] = cc.Sprite:create("public/rolebg/new_item_bg_on2.png") or cc.Sprite:createWithSpriteFrameName("public/rolebg/new_item_bg_on2.png")
		end

		var_43_3[iter_43_0]:setPosition(arg_43_1:getContentSize().width / 2, arg_43_1:getContentSize().height / 2 - 3)
		var_43_3[iter_43_0]:setName("img" .. iter_43_0)
		self.selectBg:addChild(var_43_3[iter_43_0])
	end

	function self.selectBg:play()
		self:getChildByName("img1"):setScale(1.1)
		self:getChildByName("img1"):setOpacity(0)
		self:getChildByName("img1"):stopAllActions()
		self:getChildByName("img1"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)))))
		self:getChildByName("img2"):setScale(1)
		self:getChildByName("img2"):setOpacity(255)
		self:getChildByName("img2"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)))))
	end

	self.selectBg:play()
	self.selectBg:setName("heightLight")
	self:addChild(self.selectBg, var_0_17.SELECTED)
end

function HorcruxDefaultSprite:setDefaultSp()
	self:getChildByName("grade"):setVisible(false)
	self:getChildByName("lvLabel"):setVisible(false)
	self:getChildByName("lock"):setVisible(false)
	self:getChildByName("redDot"):setVisible(false)
	self:getChildByName("fightingtag"):setVisible(false)
end

function HorcruxDefaultSprite:setShaderDark()
	local l2utils = require("controller.l2utils")

	l2utils:shaderDarkNode(self:getChildByName("rarityIcon"):getVirtualRenderer())
	l2utils:shaderDarkNode(self:getChildByName("attr"):getVirtualRenderer())
	l2utils:shaderDarkNode(self:getChildByName("levelBg"):getVirtualRenderer())
	l2utils:shaderDarkNode(self.horcruxPanel:getChildByName("horcrux"):getVirtualRenderer())
	l2utils:shaderDarkNode(self.frameBg:getVirtualRenderer())

	for iter_46_0 = 1, 5 do
		l2utils:shaderDarkNode(self:getChildByName("star_" .. iter_46_0):getVirtualRenderer())
	end
end

HorcruxDetailedStyleSprite = class("HorcruxDetailedStyleSprite", function()
	return HorcruxSprite.new()
end)

function HorcruxDetailedStyleSprite:init()
	self.horcruxPos = cc.p(86, 0)
	self.horcruxScale = 0.4
	self.isShowFac = true
	self.isShowVaule = false

	self:loadTextures("public/rolebg/detailed_style_bg.png", "public/rolebg/detailed_style_bg.png", "public/rolebg/detailed_style_bg.png", var_0_0)
	self:setAnchorPoint(cc.p(0, 0))

	local var_48_0 = ccui.ImageView:create("public/rolebg/horcrux_bag_rarity_1.png", var_0_0)

	var_48_0:setPosition(cc.p(-10, 0))
	var_48_0:setAnchorPoint(cc.p(0, 0))
	var_48_0:setName("attrBg")
	self:addChild(var_48_0, var_0_17.BG)

	self.horcruxPanel = ccui.Layout:create()

	self.horcruxPanel:setContentSize(cc.size(172, 126))
	self.horcruxPanel:setAnchorPoint(cc.p(0.5, 0.5))
	self.horcruxPanel:setPosition(cc.p(86, 60))
	self.horcruxPanel:setClippingEnabled(true)
	self:addChild(self.horcruxPanel, var_0_17.ICON)

	local var_48_1 = ccui.ImageView:create(CAREER_ICON.assassin_dark, var_0_0)

	var_48_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_48_1:setPosition(cc.p(0, self:getContentSize().height))
	var_48_1:setScale(0.5)
	var_48_1:setName("careerIcon")
	self:addChild(var_48_1, var_0_17.SKILLPANEL + 1)

	local var_48_2 = ccui.ImageView:create("GUI/image.png", var_0_0)

	var_48_2:setAnchorPoint(var_0_22)
	var_48_2:setPosition(self.horcruxPos)
	var_48_2:setScale(self.horcruxScale)
	var_48_2:setAnchorPoint(cc.p(0.5, 0))
	var_48_2:setName("horcrux")
	self.horcruxPanel:addChild(var_48_2)

	local var_48_3 = ccui.ImageView:create("public/rolebg/horcrux_+5.png", var_0_0)

	var_48_3:setPosition(cc.p(138, 16))
	var_48_3:setAnchorPoint(cc.p(0, 0.5))
	var_48_3:setName("grade")
	self:addChild(var_48_3, var_0_17.SKILLPANEL + 1)

	local var_48_4 = cc.Label:createWithTTF("等级:", FONT_NAME, 21)

	var_48_4:setAnchorPoint(cc.p(0, 0.5))
	var_48_4:setPosition(cc.p(220, 75))
	var_48_4:setColor(cc.c3b(0, 255, 198))
	var_48_4:setName("lvDesLabel")
	self:addChild(var_48_4, var_0_17.INFO)

	local var_48_5 = cc.Label:createWithTTF("???", FONT_NAME, 21)

	var_48_5:setAnchorPoint(cc.p(0, 0.5))
	var_48_5:setPosition(cc.p(var_48_4:getPositionX() + var_48_4:getContentSize().width, var_48_4:getPositionY()))
	var_48_5:setColor(cc.c3b(0, 255, 198))
	var_48_5:setName("lvLabel")
	self:addChild(var_48_5, var_0_17.INFO)

	local var_48_6 = cc.Label:createWithTTF(L_HORCRUX_BREAK_LIMIT.Aptitude_Str[2], FONT_NAME, 21)

	var_48_6:setAnchorPoint(cc.p(0, 0.5))
	var_48_6:setPosition(cc.p(220, 50))
	var_48_6:setColor(cc.c3b(181, 189, 220))
	var_48_6:setName("damageDesLabel")
	self:addChild(var_48_6, var_0_17.INFO)

	local var_48_7 = cc.Label:createWithTTF("???", FONT_NAME, 21)

	var_48_7:setAnchorPoint(cc.p(0, 0.5))
	var_48_7:setPosition(cc.p(var_48_6:getPositionX() + var_48_6:getContentSize().width, var_48_6:getPositionY()))
	var_48_7:setColor(cc.c3b(181, 189, 220))
	var_48_7:setName("damageLabel")
	self:addChild(var_48_7, var_0_17.INFO)

	local var_48_8 = cc.Label:createWithTTF(L_HORCRUX_BREAK_LIMIT.Aptitude_Str[3], FONT_NAME, 21)

	var_48_8:setAnchorPoint(cc.p(0, 0.5))
	var_48_8:setPosition(cc.p(220, 25))
	var_48_8:setColor(cc.c3b(181, 189, 220))
	var_48_8:setName("hpDesLabel")
	self:addChild(var_48_8, var_0_17.INFO)

	local var_48_9 = cc.Label:createWithTTF("???", FONT_NAME, 21)

	var_48_9:setAnchorPoint(cc.p(0, 0.5))
	var_48_9:setPosition(cc.p(var_48_8:getPositionX() + var_48_8:getContentSize().width, var_48_8:getPositionY()))
	var_48_9:setColor(cc.c3b(181, 189, 220))
	var_48_9:setName("hpLabel")
	self:addChild(var_48_9, var_0_17.INFO)

	for iter_48_0 = 1, 5 do
		local var_48_10 = ccui.ImageView:create(var_0_25, var_0_0)

		var_48_10:setAnchorPoint(cc.p(0, 0.5))
		var_48_10:setPosition(cc.p(216, 100))
		var_48_10:setScale(0.75)
		var_48_10:setName("star_" .. iter_48_0)
		self:addChild(var_48_10, var_0_17.INFO + 2)
	end

	self.skillDesPanel = ccui.Layout:create()

	self.skillDesPanel:setContentSize(cc.size(450, self:getContentSize().height))
	self.skillDesPanel:setAnchorPoint(cc.p(0, 0))
	self.skillDesPanel:setPosition(cc.p(0, 0))
	self.skillDesPanel:setClippingEnabled(true)
	self.skillDesPanel:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.skillDesPanel:setBackGroundColor(cc.c3b(0, 0, 0))
	self.skillDesPanel:setBackGroundColorOpacity(200)
	self.skillDesPanel:setVisible(false)
	self:addChild(self.skillDesPanel, var_0_17.SKILLPANEL)

	local var_48_12 = cc.Label:createWithTTF("???", FONT_NAME, 28)

	var_48_12:setAnchorPoint(cc.p(0, 0.5))
	var_48_12:setPosition(cc.p(20, self.skillDesPanel:getContentSize().height - 25))
	var_48_12:setColor(cc.c3b(255, 150, 0))
	var_48_12:setName("skillDesPanelName")
	self.skillDesPanel:addChild(var_48_12)

	local var_48_13 = cc.Label:createWithTTF("???", FONT_DES, 22)

	var_48_13:setAnchorPoint(cc.p(0, 1))
	var_48_13:setPosition(cc.p(20, self.skillDesPanel:getContentSize().height - 45))
	var_48_13:setColor(cc.c3b(255, 255, 255))
	var_48_13:setMaxLineWidth(self.skillDesPanel:getContentSize().width - 40)
	var_48_13:setLineBreakWithoutSpace(true)
	var_48_13:setName("skillDesPanelDes")
	self.skillDesPanel:addChild(var_48_13)

	local function var_48_14(arg_49_0, arg_49_1)
		if arg_49_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_49_0:getTouchBeganPosition().y - arg_49_0:getTouchEndPosition().y) > 50 then
			return
		end

		if not self.lastClickSkill or self.lastClickSkill ~= arg_49_0.skillid or not self.skillDesPanel:isVisible() then
			self.lastClickSkill = arg_49_0.skillid

			self.skillDesPanel:setVisible(true)
			var_48_12:setString(var_0_6[arg_49_0.skillid].name)
			var_48_13:setString(var_0_6[arg_49_0.skillid].description)

			if self.touchSkillCallback then
				self.touchSkillCallback()
			end
		else
			self.skillDesPanel:setVisible(false)
		end
	end

	local var_48_15 = ccui.Button:create("GUI/image.png", "GUI/image.png", "GUI/image.png", var_0_0)

	var_48_15:setAnchorPoint(cc.p(0.5, 0.5))
	var_48_15:setPosition(cc.p(477, 85))
	var_48_15:setName("skill1Icon")
	self:addChild(var_48_15, var_0_17.SKILL)
	var_48_15:setScale(0.4)
	var_48_15:addTouchEventListener(var_48_14)

	local var_48_16 = ccui.Button:create("GUI/image.png", "GUI/image.png", "GUI/image.png", var_0_0)

	var_48_16:setAnchorPoint(cc.p(0.5, 0.5))
	var_48_16:setPosition(cc.p(477, 35))
	var_48_16:setName("skill2Icon")
	self:addChild(var_48_16, var_0_17.SKILL)
	var_48_16:setScale(0.4)
	var_48_16:addTouchEventListener(var_48_14)

	local var_48_17 = ccui.Button:create("public/button/pop_unlock.png", nil, "public/button/pop_unlock.png", var_0_0)

	var_48_17:setPosition(cc.p(self:getContentSize().width - 12, self:getContentSize().height - 12))
	var_48_17:setName("lock")
	var_48_17:setVisible(false)
	var_48_17:setScale(0.85)
	self:addChild(var_48_17, var_0_17.LOCK)

	local var_48_18 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

	var_48_18:setPositionX(515)
	var_48_18:setPositionY(120)
	var_48_18:setName("redDot")
	self:addChild(var_48_18, var_0_17.REDDOT)

	local var_48_19 = ccui.ImageView:create("public/rolebg/horcrux_array_tag.png", var_0_0)

	var_48_19:setAnchorPoint(cc.p(0, 0))
	var_48_19:setPosition(cc.p(-10, 0))
	var_48_19:setName("fightingtag")

	local var_48_20 = ccui.TextBMFont:create(L_GIRL_SELECT_CELL.fightlabel, "fonts/number_array.fnt")

	var_48_20:setPosition(cc.p(var_48_19:getContentSize().width / 2 + 20, 15))
	var_48_20:setName("fightlabel")
	var_48_20:getVirtualRenderer():setBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)
	var_48_19:addChild(var_48_20)
	self:addChild(var_48_19, var_0_17.INFO + 1)

	local var_48_21 = ccui.ImageView:create("public/rolebg/h_fac_grade_a.png", var_0_0)

	var_48_21:setPositionX(400)
	var_48_21:setAnchorPoint(cc.p(0, 0.5))
	var_48_21:setPositionY(var_48_7:getPositionY())
	var_48_21:setName("damageFacGradeImg")
	self:addChild(var_48_21, var_0_17.INFO)

	local var_48_22 = ccui.ImageView:create("public/rolebg/h_fac_grade_a.png", var_0_0)

	var_48_22:setPositionX(400)
	var_48_22:setAnchorPoint(cc.p(0, 0.5))
	var_48_22:setPositionY(var_48_9:getPositionY())
	var_48_22:setName("hpFacGradeImg")
	self:addChild(var_48_22, var_0_17.INFO)

	self.hookFrame = ccui.ImageView:create("public/rolebg/horcrux_hook_frame.png", var_0_0)

	self.hookFrame:setPosition(cc.p(-34, self:getContentSize().height / 2))
	self.hookFrame:setName("hookFrame")
	self.hookFrame:setTouchEnabled(true)
	self:addChild(self.hookFrame, var_0_17.HOOK)

	local var_48_23 = TempWidget:CreateTempLabel(L_HORCRUX_DECOMPOSE.NOT_SUPPORTED, FONT_NAME, 20, self)

	var_48_23:setLocalZOrder(var_0_17.HOOK)
	var_48_23:align(cc.p(0.5, 0.5), cc.p(self.hookFrame:getPosition()))
	var_48_23:hide()

	self.notDecomposeLabel = var_48_23
	self.hook = ccui.ImageView:create("public/rolebg/horcrux_hook.png", var_0_0)

	self.hook:setPosition(cc.p(-34, self:getContentSize().height / 2))
	self.hook:setName("hook")
	self:addChild(self.hook, var_0_17.HOOK)

	local var_48_24 = ccui.ImageView:create("public/rolebg/race_bg.png", var_0_0)

	var_48_24:setScale(0.8)
	var_48_24:setPositionX(0)
	var_48_24:setPositionY(80)
	self:addChild(var_48_24, var_0_17.RACE)

	local var_48_25 = ccui.ImageView:create("public/rolebg/1.png", var_0_0)

	var_48_25:setName("raceIcon")
	var_48_25:setScale(0.4)
	var_48_25:setPositionX(var_48_24:getPositionX())
	var_48_25:setPositionY(var_48_24:getPositionY())
	self:addChild(var_48_25, var_0_17.RACE)
end

function HorcruxDetailedStyleSprite:setShowMode(arg_50_1, arg_50_2, arg_50_3)
	if arg_50_1 == var_0_15 then
		self:setPositionX(self.orginPosX)
		self.hookFrame:setVisible(false)
		self.hook:setVisible(false)
		self.notDecomposeLabel:hide()
		self:getChildByName("lock"):setPositionX(self:getContentSize().width - 12)
	else
		if horcrux_data[playermodel.items[arg_50_3].itemid].break_lock then
			self.hookFrame:setVisible(false)
			self.notDecomposeLabel:show()
		else
			self.hookFrame:setVisible(true)
			self.notDecomposeLabel:hide()
		end

		self:setPositionX(self.orginPosX + 40)
		self:getChildByName("lock"):setPositionX(self:getContentSize().width - 30)
	end

	if arg_50_2 then
		self.hook:setVisible(true)
	else
		self.hook:setVisible(false)
	end
end

function HorcruxDetailedStyleSprite:setArrayFontDefaultVisible(arg_51_1)
	if array_manager:getArrayByHorcruxID(self.entityid) then
		self:getChildByName("fightingtag"):getChildByName("fightlabel"):setVisible(arg_51_1)
	elseif array_manager:horcruxIsDefenceArray(self.entityid) then
		self:getChildByName("fightingtag"):setVisible(true)
		self:getChildByName("fightingtag"):getChildByName("fightlabel"):setVisible(arg_51_1)
	else
		self:getChildByName("fightingtag"):getChildByName("fightlabel"):setVisible(false)
	end
end

function HorcruxDetailedStyleSprite:update(arg_52_1, arg_52_2)
	if arg_52_2 then
		self.isShowFac = false
		self.isShowVaule = true
	else
		self.isShowFac = true
		self.isShowVaule = false
	end

	self.entityid = arg_52_1
	self.horcruxPos.x = model_data[horcrux_data[playermodel.items[arg_52_1].itemid].model].bag_posx or 86
	self.horcruxPos.y = model_data[horcrux_data[playermodel.items[arg_52_1].itemid].model].bag_posy or 0
	self.horcruxScale = model_data[item_data[playermodel.items[arg_52_1].itemid].model].bag_scale or 0.4

	ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionX(self.horcruxPos.x)
	ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionY(self.horcruxPos.y)
	ccui.Helper:seekWidgetByName(self, "horcrux"):setScale(self.horcruxScale)
	ccui.Helper:seekWidgetByName(self, "attrBg"):loadTexture("public/rolebg/horcrux_bag_rarity_" .. horcrux_data[playermodel.items[arg_52_1].itemid].rarity .. ".png", var_0_0)
	ccui.Helper:seekWidgetByName(self, "careerIcon"):loadTexture(CAREER_ICON["assassin_" .. self:getAttr(playermodel.items[arg_52_1].itemid)], var_0_0)
	ccui.Helper:seekWidgetByName(self, "horcrux"):loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[horcrux_data[playermodel.items[arg_52_1].itemid].model].cute_Q .. ".png")

	local var_52_0 = horcrux_manager:getHorcruxHClass(arg_52_1)

	ccui.Helper:seekWidgetByName(self, "grade"):loadTexture("public/rolebg/horcrux_+" .. var_52_0 .. ".png", var_0_0)
	ccui.Helper:seekWidgetByName(self, "grade"):setVisible(var_52_0 > 0)
	self:getChildByName("lvLabel"):setString(horcrux_manager:getHorcruxHLV(arg_52_1))

	if self.isShowFac then
		if horcrux_manager:getHorcruxHClass(self.entityid) > 0 then
			self:getChildByName("damageLabel"):setString(horcrux_manager:getHorcruxDamageFac(self.entityid) / 100 + horcrux_manager:getHorcruxDamageFacAdditionByEntityid(self.entityid) / 100)
			self:getChildByName("hpLabel"):setString((math.floor(horcrux_manager:getHorcruxHpFac(self.entityid) / 100 + horcrux_manager:getHorcruxHpFacAdditionByEntityid(self.entityid) / 100)))
		else
			self:getChildByName("damageLabel"):setString(horcrux_manager:getHorcruxDamageFac(self.entityid) / 100)
			self:getChildByName("hpLabel"):setString((math.floor(horcrux_manager:getHorcruxHpFac(self.entityid) / 100)))
		end

		self:getChildByName("damageDesLabel"):setString(L_HORCRUX_BREAK_LIMIT.Aptitude_Str[2])
		self:getChildByName("hpDesLabel"):setString(L_HORCRUX_BREAK_LIMIT.Aptitude_Str[3])
	else
		local var_52_1 = horcrux_manager:getHorcruxAssistConfig(self.entityid)

		self:getChildByName("damageLabel"):setString(math.floor(var_52_1.damage))
		self:getChildByName("hpLabel"):setString(math.floor(var_52_1.hp))
		self:getChildByName("damageDesLabel"):setString(L_SHOW_ROLE_INFO_1[2] .. ":")
		self:getChildByName("hpDesLabel"):setString(L_SHOW_ROLE_INFO_1[1] .. ":")
	end

	self:getChildByName("damageLabel"):setPositionX(self:getChildByName("damageDesLabel"):getPositionX() + self:getChildByName("damageDesLabel"):getContentSize().width)
	self:getChildByName("hpLabel"):setPositionX(self:getChildByName("hpDesLabel"):getPositionX() + self:getChildByName("hpDesLabel"):getContentSize().width)
	global_load_star(self, horcrux_manager:getHorcruxStarLevel(arg_52_1), nil, "star_")
	ccui.Helper:seekWidgetByName(self, "lock"):setVisible(playermodel.items[arg_52_1].horcrux_attr.lock)
	self:updateAlert(arg_52_1)

	local var_52_2 = horcrux_manager:getHorcruxSkills(arg_52_1)
	local var_52_3 = playermodel.items[arg_52_1]
	local var_52_4 = var_52_2[1]

	if var_52_2[1] and var_52_3.horcrux_attr.enable_skill_idxs then
		var_52_4 = false

		for iter_52_0, iter_52_1 in pairs(var_52_3.horcrux_attr.enable_skill_idxs) do
			if iter_52_1 == 1 then
				var_52_4 = true

				break
			end
		end
	end

	if var_52_4 then
		ccui.Helper:seekWidgetByName(self, "skill1Icon"):setVisible(true)
		ccui.Helper:seekWidgetByName(self, "skill1Icon"):loadTextures("skill_new/skill/" .. var_0_6[var_52_2[1]].icon .. ".png", "skill_new/skill/" .. var_0_6[var_52_2[1]].icon .. ".png", "skill_new/skill/" .. var_0_6[var_52_2[1]].icon .. ".png", var_0_0)
	else
		ccui.Helper:seekWidgetByName(self, "skill1Icon"):setVisible(false)
	end

	ccui.Helper:seekWidgetByName(self, "skill1Icon").skillid = var_52_2[1]

	local var_52_5 = var_52_2[2]

	if var_52_2[2] and var_52_3.horcrux_attr.enable_skill_idxs then
		var_52_5 = false

		for iter_52_2, iter_52_3 in pairs(var_52_3.horcrux_attr.enable_skill_idxs) do
			if iter_52_3 == 2 then
				var_52_5 = true

				break
			end
		end
	end

	if var_52_5 then
		ccui.Helper:seekWidgetByName(self, "skill2Icon"):setVisible(true)
		ccui.Helper:seekWidgetByName(self, "skill2Icon"):loadTextures("skill_new/skill/" .. var_0_6[var_52_2[2]].icon .. ".png", "skill_new/skill/" .. var_0_6[var_52_2[2]].icon .. ".png", "skill_new/skill/" .. var_0_6[var_52_2[2]].icon .. ".png", var_0_0)
	else
		ccui.Helper:seekWidgetByName(self, "skill2Icon"):setVisible(false)
	end

	ccui.Helper:seekWidgetByName(self, "skill2Icon").skillid = var_52_2[2]

	for iter_52_4, iter_52_5 in pairs(var_52_2) do
		if ccui.Helper:seekWidgetByName(self, "skill" .. iter_52_4 .. "Icon") then
			ccui.Helper:seekWidgetByName(self, "skill" .. iter_52_4 .. "Icon"):setPositionY(64 + (iter_52_4 * 2 - #var_52_2 - 1) / 2 * 43)
		end
	end

	local var_52_6 = array_manager:getArrayByHorcruxID(arg_52_1)

	if var_52_6 then
		self:getChildByName("fightingtag"):setVisible(true)
		self:getChildByName("fightingtag"):getChildByName("fightlabel"):setString(L_GIRL_SELECT_CELL.Update[2] .. var_0_14[var_52_6])
	elseif array_manager:horcruxIsDefenceArray(arg_52_1) then
		self:getChildByName("fightingtag"):setVisible(true)
		self:getChildByName("fightingtag"):getChildByName("fightlabel"):setString(L_GIRL_SELECT_CELL.arenaDefence)
	else
		self:getChildByName("fightingtag"):setVisible(false)
	end

	self.skillDesPanel:setVisible(false)

	local var_52_7 = {
		s = "public/rolebg/h_fac_s.png",
		a = "public/rolebg/h_fac_grade_a.png",
		s_plus = "public/rolebg/h_fac_s_plus.png",
		b_minus = "public/rolebg/h_fac_grade_b_minus.png",
		b_plus = "public/rolebg/h_fac_grade_b_plus.png",
		a_minus = "public/rolebg/h_fac_grade_a_minus.png",
		b = "public/rolebg/h_fac_grade_b.png",
		c = "public/rolebg/h_fac_grade_c.png",
		a_puls = "public/rolebg/h_fac_a_puls.png"
	}

	self:getChildByName("damageFacGradeImg"):loadTexture(var_52_7[horcrux_manager:getHorcruxDamageFacSectionGrade(arg_52_1)], var_0_0)
	self:getChildByName("hpFacGradeImg"):loadTexture(var_52_7[horcrux_manager:getHorcruxHpFacSectionGrade(arg_52_1)], var_0_0)
	self:updateRaceIcon(arg_52_1)
end

function HorcruxDetailedStyleSprite:setSkillDesPanelVisible(arg_53_1)
	self.skillDesPanel:setVisible(arg_53_1 or false)
end

function HorcruxDetailedStyleSprite.registerSkillTouchCallback(arg_54_0, arg_54_1)
	arg_54_0.touchSkillCallback = arg_54_1
end

function HorcruxDetailedStyleSprite.updateAlert(arg_55_0, arg_55_1)
	local var_55_0 = {
		{
			enum = var_0_18.NEW_ICON,
			updateFun = function(arg_56_0)
				arg_55_0:updateNewIcon(arg_56_0)
			end
		},
		{
			enum = var_0_18.RED_DOT_BAG,
			updateFun = function(arg_57_0)
				arg_55_0:updateRedDot(arg_57_0)
			end
		}
	}
	local var_55_1 = 1

	while var_55_0[var_55_1] do
		var_55_0[var_55_1].updateFun(false)

		var_55_1 = var_55_1 + 1
	end

	local var_55_2 = 1

	while var_55_0[var_55_2] do
		if var_0_21[var_55_0[var_55_2].enum](arg_55_1) then
			var_55_0[var_55_2].updateFun(true)

			break
		end

		var_55_2 = var_55_2 + 1
	end
end

function HorcruxDetailedStyleSprite:updateNewIcon(arg_58_1)
	if arg_58_1 then
		if not self:getChildByName("newIcon") then
			local var_58_0 = ccui.ImageView:create(var_0_20, var_0_0)

			var_58_0:setPositionX(518)
			var_58_0:setPositionY(126)
			var_58_0:setName("newIcon")
			self:addChild(var_58_0, var_0_17.REDDOT)
		end
	elseif self:getChildByName("newIcon") then
		self:getChildByName("newIcon"):setVisible(false)
	end
end

HorcruxPreviewStyleSprite = class("HorcruxPreviewStyleSprite", function()
	return HorcruxSprite.new()
end)

function HorcruxPreviewStyleSprite:init(arg_60_1)
	arg_60_1 = arg_60_1 or {}

	local var_60_0 = cc.p(75, 40)

	self.isHpInherit = not not (arg_60_1 and arg_60_1.isHpInherit)
	self.hideFightingTag = arg_60_1.hideFightingTag
	self.scale = 0.46

	self:loadTextures("public/rolebg/horcrux_new_rarity_1.png", "public/rolebg/horcrux_new_rarity_1.png", "public/rolebg/horcrux_new_rarity_1.png", var_0_0)
	self:setAnchorPoint(cc.p(0, 0))

	self.horcruxPanel = ccui.Layout:create()

	self.horcruxPanel:setContentSize(cc.size(self:getContentSize().width - 8, self:getContentSize().height - 12))
	self.horcruxPanel:setAnchorPoint(cc.p(0, 0))
	self.horcruxPanel:setPosition(cc.p(4, 6))
	self.horcruxPanel:setClippingEnabled(true)
	self:addChild(self.horcruxPanel, var_0_17.ICON)

	local var_60_1 = ccui.ImageView:create("GUI/image.png", var_0_0)

	var_60_1:setAnchorPoint(var_0_22)
	var_60_1:setPosition(var_60_0)
	var_60_1:setScale(self.scale)
	var_60_1:setName("horcrux")

	self.horcrux = var_60_1

	self.horcruxPanel:addChild(var_60_1)

	self.topImg = TempWidget:CreateTempImg("public/rolebg/horcrux_new_rarity_top_1.png", self)

	self.topImg:setLocalZOrder(var_0_17.INFO - 1)
	self.topImg:align(cc.p(0.5, 0.5), self:getContentSize().width / 2, self:getContentSize().height / 2)

	local var_60_2 = ccui.ImageView:create("public/rolebg/horcrux_+5.png", var_0_0)

	var_60_2:setScale(0.8)
	var_60_2:setAnchorPoint(cc.p(0, 0))
	var_60_2:setPositionX(70)
	var_60_2:setPositionY(28)
	var_60_2:setName("grade")
	self:addChild(var_60_2, var_0_17.INFO)

	for iter_60_0 = 1, 5 do
		local var_60_3 = ccui.ImageView:create("public/currency/weapon_star.png", var_0_0)

		var_60_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_60_3:setScale(0.7)
		var_60_3:setPosition(cc.p(30, 17))
		var_60_3:setName("star_" .. iter_60_0)
		self:addChild(var_60_3, var_0_17.INFO)
	end

	local var_60_5 = ccui.ImageView:create(CAREER_ICON.assassin_dark, var_0_0)

	var_60_5:setAnchorPoint(cc.p(1, 1))
	var_60_5:setPosition(cc.p(self:getContentSize().width - 5, self:getContentSize().height - 5))
	var_60_5:setScale(0.45)
	var_60_5:setName("careerIcon")
	self:addChild(var_60_5, var_0_17.INFO)

	local var_60_6 = cc.Label:createWithTTF("888", "fonts/archives.ttf", 31)

	var_60_6:setColor(cc.c3b(255, 255, 255))
	var_60_6:setAnchorPoint(cc.p(0.5, 0))
	var_60_6:setPosition(cc.p(self:getContentSize().width - 20, 28))
	var_60_6:setName("lvLabel")
	self:addChild(var_60_6, var_0_17.INFO)

	local var_60_7 = ccui.ImageView:create(SHOT_RARITY_CION[1], var_0_0)

	var_60_7:setAnchorPoint(cc.p(1, 1))
	var_60_7:setPosition(cc.p(self:getContentSize().width, self:getContentSize().height))
	var_60_7:setScale(0.8)
	var_60_7:setName("rarityIcon")
	var_60_7:setVisible(false)
	self:addChild(var_60_7, var_0_17.INFO)

	local var_60_8 = ccui.ImageView:create("public/rolebg/img_lv.png", var_0_0)

	var_60_8:setPositionX(var_60_6:getPositionX() - var_60_6:getContentSize().width - 6)
	var_60_8:setPositionY(10)
	var_60_8:setName("lvIcon")
	var_60_8:setVisible(false)
	self:addChild(var_60_8, var_0_17.INFO)

	local var_60_9 = ccui.Button:create("public/button/unlock_new.png", nil, "public/button/unlock_new.png", var_0_0)

	var_60_9:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height / 2))
	var_60_9:setName("lock")
	var_60_9:setVisible(false)
	self:addChild(var_60_9, var_0_17.LOCK)

	local var_60_10 = ccui.ImageView:create(var_0_27, var_0_0)

	var_60_10:setAnchorPoint(cc.p(0.5, 0.5))
	var_60_10:setScale9Enabled(true)
	var_60_10:setCapInsets(cc.rect(50, 20, 1, 1))
	var_60_10:setContentSize(cc.size(self:getContentSize().width - 6, var_60_10:getContentSize().height))
	var_60_10:setPosition(cc.p(self:getContentSize().width / 2, 80))
	var_60_10:setName("fightingtag")

	local var_60_11 = cc.Label:createWithTTF(L_HORCRUXSELECT_FIGHT_TAG, "fonts/newkj.ttf", 22)

	var_60_11:setColor(cc.c3b(255, 100, 0))
	var_60_11:setPosition(cc.p(var_60_10:getContentSize().width / 2, var_60_10:getContentSize().height / 2))
	var_60_11:setName("fightlabel")
	var_60_10:addChild(var_60_11)
	self:addChild(var_60_10, var_0_17.INFO - 1)

	local var_60_12 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

	var_60_12:setPositionX(self:getContentSize().width - 10)
	var_60_12:setPositionY(self:getContentSize().height - 10)
	var_60_12:setName("redDot")
	self:addChild(var_60_12, var_0_17.REDDOT)

	local var_60_13 = ccui.Layout:create()

	var_60_13:setContentSize(cc.size(self:getContentSize().width, self:getContentSize().height))
	var_60_13:setAnchorPoint(cc.p(0, 0))
	var_60_13:setPosition(cc.p(0, 0))
	var_60_13:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_60_13:setBackGroundColor(cc.c3b(0, 0, 0))
	var_60_13:setBackGroundColorOpacity(200)
	var_60_13:setVisible(false)
	var_60_13:setName("backPanel")
	self:addChild(var_60_13, var_0_17.INFO)

	local var_60_14 = cc.Label:createWithTTF("", FONT_DES, 24)

	var_60_14:setAnchorPoint(cc.p(0, 0.5))
	var_60_14:setPosition(cc.p(5, var_60_13:getContentSize().height - 60))
	var_60_14:setCascadeOpacityEnabled(false)
	var_60_14:setColor(cc.c3b(255, 150, 0))
	var_60_14:setName("fightCapacityLabel")
	var_60_13:addChild(var_60_14)

	local var_60_15 = cc.Label:createWithTTF("", FONT_DES, 22)

	var_60_15:setAnchorPoint(cc.p(0, 0.5))
	var_60_15:setPosition(cc.p(5, var_60_14:getPositionY() - 40))
	var_60_15:setCascadeOpacityEnabled(false)
	var_60_15:setName("damageLabel")
	var_60_13:addChild(var_60_15)

	local var_60_16 = cc.Label:createWithTTF("", FONT_DES, 22)

	var_60_16:setAnchorPoint(cc.p(0, 0.5))
	var_60_16:setPosition(cc.p(5, var_60_15:getPositionY() - 52))
	var_60_16:setCascadeOpacityEnabled(false)
	var_60_16:setName("hpLabel")
	var_60_13:addChild(var_60_16)

	local var_60_17 = ccui.ImageView:create("public/rolebg/1.png", var_0_0)

	var_60_17:setAnchorPoint(cc.p(0, 1))
	var_60_17:setName("raceIcon")
	var_60_17:setPositionX(5)
	var_60_17:setPositionY(self:getContentSize().height - 5)
	var_60_17:setScale(0.35)
	self:addChild(var_60_17, var_0_17.RACE)

	self.raceIcon = var_60_17

	local var_60_18

	if config._DEBUG then
		var_60_18 = cc.Sprite:create("public/rolebg/q_mask.png") or cc.Sprite:createWithSpriteFrameName("public/rolebg/q_mask.png")
	end

	local var_60_19 = cc.ClippingNode:create(var_60_18)

	var_60_19:setAlphaThreshold(0.5)
	var_60_19:setPosition(20, self:getContentSize().height - 20)
	self:addChild(var_60_19, var_0_17.SERVANT)

	self.servantclip = var_60_19

	var_60_18:setScale(0.7)

	local var_60_20 = ccui.ImageView:create("res/roleimage/role1/215020.png")

	var_60_20:setAnchorPoint(cc.p(0.5, 0.5))
	var_60_20:setName("servantimg")
	var_60_20:setScale(0.2)
	var_60_20:setPositionX(-5)
	var_60_19:addChild(var_60_20)

	self.servantimg = var_60_20

	local var_60_21 = ccui.ImageView:create("public/rolebg/horcrux_recommend.png", var_0_0)

	var_60_21:setAnchorPoint(cc.p(0.5, 1))
	var_60_21:setName("recommendIcon")
	var_60_21:setPositionX(self:getContentSize().width / 2)
	var_60_21:setPositionY(self:getContentSize().height)
	self:addChild(var_60_21, var_0_17.RECOMMEND)

	self.recommendIcon = var_60_21

	function var_60_21:play()
		self:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(1), cc.FadeIn:create(1), cc.DelayTime:create(2.5))))
	end

	var_60_21:setVisible(false)
end

function HorcruxPreviewStyleSprite:update(arg_62_1, arg_62_2, arg_62_3)
	local var_62_0 = cc.p(75, 15)

	self.entityid = arg_62_1

	local var_62_1 = (item_data[playermodel.items[arg_62_1].itemid].image_offset_y or 0) * (self.scale or 1)

	self.horcrux:setPositionX(var_62_0.x + (item_data[playermodel.items[arg_62_1].itemid].image_offse_x or 0) * (self.scale or 1))
	self.horcrux:setPositionY(var_62_0.y + var_62_1)

	local var_62_2 = self:getAttr(playermodel.items[arg_62_1].itemid)

	self:loadTextures("public/rolebg/horcrux_new_rarity_" .. horcrux_data[playermodel.items[arg_62_1].itemid].rarity .. ".png", "public/rolebg/horcrux_new_rarity_" .. horcrux_data[playermodel.items[arg_62_1].itemid].rarity .. ".png", "public/rolebg/horcrux_new_rarity_" .. horcrux_data[playermodel.items[arg_62_1].itemid].rarity .. ".png", var_0_0)
	self.topImg:loadTextureEx("public/rolebg/horcrux_new_rarity_top_" .. horcrux_data[playermodel.items[arg_62_1].itemid].rarity .. ".png")
	self.horcrux:loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[horcrux_data[playermodel.items[arg_62_1].itemid].model].cute_Q .. ".png")
	ccui.Helper:seekWidgetByName(self, "grade"):loadTexture("public/rolebg/horcrux_+" .. horcrux_manager:getHorcruxHClass(arg_62_1) .. ".png", var_0_0)
	self:getChildByName("lvLabel"):setString(horcrux_manager:getHorcruxHLV(arg_62_1))
	self:getChildByName("careerIcon"):loadTexture(CAREER_ICON[horcrux_data[playermodel.items[arg_62_1].itemid].career .. "_" .. var_0_19(playermodel.items[arg_62_1].itemid)], var_0_0)
	global_load_star(self, horcrux_manager:getHorcruxStarLevel(arg_62_1), nil, "star_")
	ccui.Helper:seekWidgetByName(self, "lock"):setVisible(playermodel.items[arg_62_1].horcrux_attr.lock)

	if playermodel.horcruxServants[arg_62_1] and servant_data[playermodel.horcruxServants[arg_62_1]] then
		ccui.Helper:seekWidgetByName(self, "raceIcon"):setVisible(not playermodel.items[arg_62_1].horcrux_attr.lock)
		self.servantclip:setVisible(playermodel.items[arg_62_1].horcrux_attr.lock)
		self.servantimg:loadTexture("res/roleimage/role1/" .. model_data[servant_data[playermodel.horcruxServants[arg_62_1]].modelid].cute_role .. ".png")
	else
		ccui.Helper:seekWidgetByName(self, "raceIcon"):setVisible(true)
		self.servantclip:setVisible(false)
	end

	if (self.isHpInherit and array_manager:getArrayByHorcruxIDHpInherit(arg_62_1) or array_manager:getArrayByHorcruxID(arg_62_1)) and not self.hideFightingTag then
		self:getChildByName("fightingtag"):setVisible(true)

		if self.isHpInherit then
			self:getChildByName("fightingtag"):getChildByName("fightlabel"):setString("已装备")
		else
			self:getChildByName("fightingtag"):getChildByName("fightlabel"):setString(L_TEAM .. "中")
		end
	else
		self:getChildByName("fightingtag"):setVisible(false)
	end

	if arg_62_2 then
		local var_62_4 = horcrux_manager:getHorcruxAssistConfig(arg_62_1)
		local var_62_5
		local var_62_6

		if horcrux_manager:getHorcruxHClass(arg_62_1) > 0 then
			var_62_5 = horcrux_manager:getHorcruxDamageFac(self.entityid) / 100 + horcrux_manager:getHorcruxDamageFacAdditionByEntityid(self.entityid) / 100
			var_62_6 = math.floor(horcrux_manager:getHorcruxHpFac(self.entityid) / 100 + horcrux_manager:getHorcruxHpFacAdditionByEntityid(self.entityid) / 100)
		else
			var_62_5 = horcrux_manager:getHorcruxDamageFac(self.entityid) / 100
			var_62_6 = math.floor(horcrux_manager:getHorcruxHpFac(self.entityid) / 100)
		end

		local var_62_8 = self:getChildByName("backPanel")

		var_62_8:setVisible(true)
		var_62_8:getChildByName("hpLabel"):setString(L_GIRL_INFO_TABLE[5] .. global_trans_number(math.floor(var_62_4.hp)) .. "\n(" .. var_62_6 .. ")")
		var_62_8:getChildByName("damageLabel"):setString(L_GIRL_INFO_TABLE[4] .. global_trans_number(math.floor(var_62_4.damage)) .. "\n(" .. var_62_5 .. ")")
		var_62_8:getChildByName("fightCapacityLabel"):setString(L_GIRL_INFO_TABLE[3] .. fight_capacity_manager:getHorcruxAddition(arg_62_1))
	else
		self:getChildByName("backPanel"):setVisible(false)
	end

	if arg_62_3 then
		self.recommendIcon:setVisible(true)
		self.recommendIcon:play()
	else
		self.recommendIcon:setVisible(false)
		self.recommendIcon:stopAllActions()
	end

	self:updateAlert(arg_62_1)
	self:updateRaceIcon(arg_62_1)
end

function HorcruxPreviewStyleSprite:createItemHightLight(arg_63_1)
	self.selectBg = ccui.Layout:create()

	local var_63_4

	if config._DEBUG then
		var_63_4 = cc.Sprite:create("public/rolebg/new_item_bg_on3.png") or cc.Sprite:createWithSpriteFrameName("public/rolebg/new_item_bg_on3.png")
	end

	var_63_4:setPosition(arg_63_1:getContentSize().width / 2, arg_63_1:getContentSize().height / 2)
	self.selectBg:addChild(var_63_4)

	function self.selectBg:play()
		self:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(1.25), cc.FadeIn:create(1.25))))
	end

	self.selectBg:play()
	self.selectBg:setName("heightLight")
	self:addChild(self.selectBg, var_0_17.SELECTED)
end

function HorcruxPreviewStyleSprite:updateSelectHook(arg_65_1)
	if arg_65_1 and not self.selectBg then
		self.selectBg = ccui.Layout:create()

		self.selectBg:setTouchEnabled(false)
		self.selectBg:setContentSize(cc.size(self:getContentSize().width, self:getContentSize().height))
		self.selectBg:setAnchorPoint(cc.p(0.5, 0.5))
		self.selectBg:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height / 2))
		self.selectBg:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		self.selectBg:setBackGroundColor(cc.c3b(0, 0, 0))
		self.selectBg:setBackGroundColorOpacity(120)

		local var_65_0 = ccui.ImageView:create("public/rolebg/hook.png", var_0_0)

		var_65_0:setPosition(cc.p(self.selectBg:getContentSize().width / 2, self.selectBg:getContentSize().height / 2))
		self.selectBg:addChild(var_65_0)

		function self.selectBg.play(arg_66_0)
			return
		end

		self.selectBg:play()
		self.selectBg:setName("heightLight")
		self:addChild(self.selectBg, var_0_17.SELECTED)
	end

	if arg_65_1 ~= nil and self.selectBg then
		self.selectBg:setVisible(arg_65_1)
	end
end

function HorcruxPreviewStyleSprite:updateNewIcon(arg_67_1)
	if arg_67_1 then
		if not self:getChildByName("newIcon") then
			local var_67_0 = ccui.ImageView:create("public/rolebg/horcrux_new1.png", var_0_0)

			var_67_0:setPositionX(self:getContentSize().width - 10)
			var_67_0:setPositionY(self:getContentSize().height - 5)
			var_67_0:setName("newIcon")
			self:addChild(var_67_0, var_0_17.REDDOT)
		end

		self:getChildByName("newIcon"):setVisible(true)
	elseif self:getChildByName("newIcon") then
		self:getChildByName("newIcon"):setVisible(false)
	end
end

function HorcruxPreviewStyleSprite.updateAlert(arg_68_0, arg_68_1)
	local var_68_0 = {
		{
			enum = var_0_18.NEW_ICON,
			updateFun = function(arg_69_0)
				arg_68_0:updateNewIcon(arg_69_0)
			end
		},
		{
			enum = var_0_18.RED_DOT_BAG,
			updateFun = function(arg_70_0)
				arg_68_0:updateRedDot(arg_70_0)
			end
		}
	}
	local var_68_1 = 1

	while var_68_0[var_68_1] do
		var_68_0[var_68_1].updateFun(false)

		var_68_1 = var_68_1 + 1
	end

	local var_68_2 = 1

	while var_68_0[var_68_2] do
		if var_0_21[var_68_0[var_68_2].enum](arg_68_1) then
			var_68_0[var_68_2].updateFun(true)

			break
		end

		var_68_2 = var_68_2 + 1
	end
end

function HorcruxPreviewStyleSprite:setUnkonw(arg_71_1, arg_71_2, arg_71_3, arg_71_4)
	arg_71_1 = arg_71_1 or 1
	arg_71_2 = arg_71_2 or 1
	arg_71_3 = arg_71_3 or 1
	arg_71_2 = 1

	ccui.Helper:seekWidgetByName(self, "grade"):setVisible(false)
	ccui.Helper:seekWidgetByName(self, "lock"):setVisible(false)
	self.servantclip:setVisible(false)
	ccui.Helper:seekWidgetByName(self, "raceIcon"):setVisible(true)
	self:getChildByName("fightingtag"):setVisible(false)
	self:getChildByName("raceIcon"):setVisible(false)
	self:getChildByName("lvLabel"):setVisible(false)

	if ccui.Helper:seekWidgetByName(self, "redDot") then
		ccui.Helper:seekWidgetByName(self, "redDot"):setVisible(false)
	end

	self:getChildByName("careerIcon"):loadTexture(ATTRICONPATH[arg_71_1], var_0_0)
	self:loadTextures("public/rolebg/horcrux_rarity_" .. arg_71_2 .. ".png", "public/rolebg/horcrux_rarity_" .. arg_71_2 .. ".png", "public/rolebg/horcrux_rarity_" .. arg_71_2 .. ".png", var_0_0)
	self.topImg:loadTextureEx("public/rolebg/horcrux_new_rarity_top_" .. arg_71_2 .. ".png")
	global_load_star(self, arg_71_3, nil, "star_")

	if arg_71_4 then
		self.horcrux:loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[item_data[arg_71_4].model].cute_Q .. ".png")

		local var_71_1 = (item_data[arg_71_4].image_offse_x or 0) * (self.scale or 1)
		local var_71_2 = (item_data[arg_71_4].image_offset_y or 0) * (self.scale or 1)
		local var_71_3 = cc.p(75, 15)

		self.horcrux:setPositionX(var_71_3.x + var_71_1)
		self.horcrux:setPositionY(var_71_3.y + var_71_2)
		self:getChildByName("careerIcon"):setVisible(false)
		require("controller.l2utils"):shaderGrayDark(self.horcrux:getVirtualRenderer())
	else
		self.horcrux:loadTexture("public/rolebg/unkonw_horcrux.png", var_0_0)
		self.horcrux:setScale(1.2)
		self.horcrux:setPositionY(15)
	end
end

HorcruxAreanAttackSprite = class("HorcruxAreanAttackSprite", function()
	return HorcruxPreviewStyleSprite.new()
end)

function HorcruxAreanAttackSprite:update(arg_73_1, arg_73_2)
	local var_73_0 = cc.p(75, 15)

	self.entityid = arg_73_1

	local var_73_1 = (item_data[playermodel.items[arg_73_1].itemid].image_offset_y or 0) * (self.scale or 1)

	ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionX(var_73_0.x + (item_data[playermodel.items[arg_73_1].itemid].image_offse_x or 0) * (self.scale or 1))
	ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionY(var_73_0.y + var_73_1)

	local var_73_2 = self:getAttr(playermodel.items[arg_73_1].itemid)

	ccui.Helper:seekWidgetByName(self, "horcrux"):loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[horcrux_data[playermodel.items[arg_73_1].itemid].model].cute_Q .. ".png")
	ccui.Helper:seekWidgetByName(self, "grade"):loadTexture("public/rolebg/horcrux_+" .. horcrux_manager:getHorcruxHClass(arg_73_1) .. ".png", var_0_0)
	self:getChildByName("lvLabel"):setString(horcrux_manager:getHorcruxHLV(arg_73_1))
	self:getChildByName("careerIcon"):loadTexture(CAREER_ICON[horcrux_data[playermodel.items[arg_73_1].itemid].career .. "_" .. var_0_19(playermodel.items[arg_73_1].itemid)], var_0_0)
	global_load_star(self, horcrux_manager:getHorcruxStarLevel(arg_73_1), nil, "star_")
	ccui.Helper:seekWidgetByName(self, "lock"):setVisible(playermodel.items[arg_73_1].horcrux_attr.lock)

	if array_manager:getAreanAttackByHorcruxID(arg_73_1) then
		self:getChildByName("fightingtag"):setVisible(true)
		self:getChildByName("fightingtag"):getChildByName("fightlabel"):setString("编队中")
	else
		self:getChildByName("fightingtag"):setVisible(false)
	end

	if arg_73_2 then
		local var_73_4 = horcrux_manager:getHorcruxAssistConfig(arg_73_1)
		local var_73_5
		local var_73_6

		if horcrux_manager:getHorcruxHClass(arg_73_1) > 0 then
			var_73_5 = horcrux_manager:getHorcruxDamageFac(self.entityid) / 100 + horcrux_manager:getHorcruxDamageFacAdditionByEntityid(self.entityid) / 100
			var_73_6 = math.floor(horcrux_manager:getHorcruxHpFac(self.entityid) / 100 + horcrux_manager:getHorcruxHpFacAdditionByEntityid(self.entityid) / 100)
		else
			var_73_5 = horcrux_manager:getHorcruxDamageFac(self.entityid) / 100
			var_73_6 = math.floor(horcrux_manager:getHorcruxHpFac(self.entityid) / 100)
		end

		local var_73_8 = self:getChildByName("backPanel")

		var_73_8:setVisible(true)
		var_73_8:getChildByName("hpLabel"):setString("血量:" .. global_trans_number(math.floor(var_73_4.hp)) .. "\n(" .. var_73_6 .. ")")
		var_73_8:getChildByName("damageLabel"):setString("攻击:" .. global_trans_number(math.floor(var_73_4.damage)) .. "\n(" .. var_73_5 .. ")")
		var_73_8:getChildByName("fightCapacityLabel"):setString("战力:" .. fight_capacity_manager:getHorcruxAddition(arg_73_1))
	else
		self:getChildByName("backPanel"):setVisible(false)
	end

	self:updateAlert(arg_73_1)
	self:updateRaceIcon(arg_73_1)
end

HorcruxSubSprite = class("HorcruxSubSprite", function()
	return HorcruxPreviewStyleSprite.new()
end)

function HorcruxSubSprite:updateSubArray(arg_75_1, arg_75_2)
	local var_75_0 = cc.p(75, 15)

	self.entityid = arg_75_1

	local var_75_1 = (item_data[arg_75_1.itemid].image_offset_y or 0) * (self.scale or 1)

	ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionX(var_75_0.x + (item_data[arg_75_1.itemid].image_offse_x or 0) * (self.scale or 1))
	ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionY(var_75_0.y + var_75_1)

	local var_75_2 = self:getAttr(arg_75_1.itemid)

	ccui.Helper:seekWidgetByName(self, "horcrux"):loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[horcrux_data[arg_75_1.itemid].model].cute_Q .. ".png")
	ccui.Helper:seekWidgetByName(self, "grade"):loadTexture("public/rolebg/horcrux_+" .. arg_75_1.hclass .. ".png", var_0_0)
	self:getChildByName("lvLabel"):setString(arg_75_1.hlv)
	self:getChildByName("careerIcon"):loadTexture(CAREER_ICON[horcrux_data[arg_75_1.itemid].career .. "_" .. var_0_19(arg_75_1.itemid)], var_0_0)
	global_load_star(self, arg_75_1.star, nil, "star_")

	local var_75_4 = substitution_manager:getSubByHorcruxID(arg_75_1)

	if arg_75_2 then
		local var_75_5 = horcrux_manager:getHorcruxAssistConfig(arg_75_1)
		local var_75_6
		local var_75_7

		if horcrux_manager:getHorcruxHClass(arg_75_1) > 0 then
			var_75_6 = horcrux_manager:getHorcruxDamageFac(self.entityid) / 100 + horcrux_manager:getHorcruxDamageFacAdditionByEntityid(self.entityid) / 100
			var_75_7 = math.floor(horcrux_manager:getHorcruxHpFac(self.entityid) / 100 + horcrux_manager:getHorcruxHpFacAdditionByEntityid(self.entityid) / 100)
		else
			var_75_6 = horcrux_manager:getHorcruxDamageFac(self.entityid) / 100
			var_75_7 = math.floor(horcrux_manager:getHorcruxHpFac(self.entityid) / 100)
		end

		local var_75_9 = self:getChildByName("backPanel")

		var_75_9:setVisible(true)
		var_75_9:getChildByName("hpLabel"):setString("血量:" .. global_trans_number(math.floor(var_75_5.hp)) .. "\n(" .. var_75_7 .. ")")
		var_75_9:getChildByName("damageLabel"):setString("攻击:" .. global_trans_number(math.floor(var_75_5.damage)) .. "\n(" .. var_75_6 .. ")")
		var_75_9:getChildByName("fightCapacityLabel"):setString("战力:" .. fight_capacity_manager:getHorcruxAddition(arg_75_1))
	else
		self:getChildByName("backPanel"):setVisible(false)
	end
end

function HorcruxSubSprite:update(arg_76_1, arg_76_2)
	local var_76_0 = cc.p(75, 15)

	self.entityid = arg_76_1

	local var_76_1 = (item_data[playermodel.items[arg_76_1].itemid].image_offset_y or 0) * (self.scale or 1)

	ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionX(var_76_0.x + (item_data[playermodel.items[arg_76_1].itemid].image_offse_x or 0) * (self.scale or 1))
	ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionY(var_76_0.y + var_76_1)

	local var_76_2 = self:getAttr(playermodel.items[arg_76_1].itemid)

	ccui.Helper:seekWidgetByName(self, "horcrux"):loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[horcrux_data[playermodel.items[arg_76_1].itemid].model].cute_Q .. ".png")
	ccui.Helper:seekWidgetByName(self, "grade"):loadTexture("public/rolebg/horcrux_+" .. horcrux_manager:getHorcruxHClass(arg_76_1) .. ".png", var_0_0)
	self:getChildByName("lvLabel"):setString(horcrux_manager:getHorcruxHLV(arg_76_1))
	self:getChildByName("careerIcon"):loadTexture(CAREER_ICON[horcrux_data[playermodel.items[arg_76_1].itemid].career .. "_" .. var_0_19(playermodel.items[arg_76_1].itemid)], var_0_0)
	global_load_star(self, horcrux_manager:getHorcruxStarLevel(arg_76_1), nil, "star_")
	ccui.Helper:seekWidgetByName(self, "lock"):setVisible(playermodel.items[arg_76_1].horcrux_attr.lock)

	local var_76_4 = substitution_manager:getSubByHorcruxID(arg_76_1)

	if var_76_4 then
		self:getChildByName("fightingtag"):setVisible(true)
		self:getChildByName("fightingtag"):getChildByName("fightlabel"):setString("编队" .. var_76_4)
	else
		self:getChildByName("fightingtag"):setVisible(false)
	end

	if arg_76_2 then
		local var_76_5 = horcrux_manager:getHorcruxAssistConfig(arg_76_1)
		local var_76_6
		local var_76_7

		if horcrux_manager:getHorcruxHClass(arg_76_1) > 0 then
			var_76_6 = horcrux_manager:getHorcruxDamageFac(self.entityid) / 100 + horcrux_manager:getHorcruxDamageFacAdditionByEntityid(self.entityid) / 100
			var_76_7 = math.floor(horcrux_manager:getHorcruxHpFac(self.entityid) / 100 + horcrux_manager:getHorcruxHpFacAdditionByEntityid(self.entityid) / 100)
		else
			var_76_6 = horcrux_manager:getHorcruxDamageFac(self.entityid) / 100
			var_76_7 = math.floor(horcrux_manager:getHorcruxHpFac(self.entityid) / 100)
		end

		local var_76_9 = self:getChildByName("backPanel")

		var_76_9:setVisible(true)
		var_76_9:getChildByName("hpLabel"):setString("血量:" .. global_trans_number(math.floor(var_76_5.hp)) .. "\n(" .. var_76_7 .. ")")
		var_76_9:getChildByName("damageLabel"):setString("攻击:" .. global_trans_number(math.floor(var_76_5.damage)) .. "\n(" .. var_76_6 .. ")")
		var_76_9:getChildByName("fightCapacityLabel"):setString("战力:" .. fight_capacity_manager:getHorcruxAddition(arg_76_1))
	else
		self:getChildByName("backPanel"):setVisible(false)
	end

	self:updateAlert(arg_76_1)
end

HorcruxAreanDefenceSprite = class("HorcruxAreanDefenceSprite", function()
	return HorcruxPreviewStyleSprite.new()
end)

function HorcruxAreanDefenceSprite:update(arg_78_1, arg_78_2)
	local var_78_0 = cc.p(75, 15)

	self.entityid = arg_78_1

	local var_78_1 = playermodel.items[arg_78_1].itemid
	local var_78_2 = (item_data[var_78_1].image_offset_y or 0) * (self.scale or 1)

	ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionX(var_78_0.x + (item_data[playermodel.items[arg_78_1].itemid].image_offse_x or 0) * (self.scale or 1))
	ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionY(var_78_0.y + var_78_2)

	local var_78_3 = self:getAttr(var_78_1)

	self:loadTextures("public/rolebg/horcrux_rarity_" .. horcrux_data[var_78_1].rarity .. ".png", "public/rolebg/horcrux_rarity_" .. horcrux_data[var_78_1].rarity .. ".png", "public/rolebg/horcrux_rarity_" .. horcrux_data[var_78_1].rarity .. ".png", var_0_0)
	ccui.Helper:seekWidgetByName(self, "rarityIcon"):loadTexture(SHOT_RARITY_CION[horcrux_data[var_78_1].rarity], var_0_0)
	ccui.Helper:seekWidgetByName(self, "horcrux"):loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[horcrux_data[playermodel.items[arg_78_1].itemid].model].cute_Q .. ".png")

	local var_78_4 = horcrux_manager:getHorcruxHClass(arg_78_1)

	ccui.Helper:seekWidgetByName(self, "grade"):loadTexture("public/rolebg/horcrux_+" .. var_78_4 .. ".png", var_0_0)
	ccui.Helper:seekWidgetByName(self, "grade"):setVisible(var_78_4 > 0)

	local var_78_5 = self:getChildByName("lvLabel")

	var_78_5:setString(horcrux_manager:getHorcruxHLV(arg_78_1))
	self:getChildByName("lvIcon"):setPositionX(var_78_5:getPositionX() - var_78_5:getContentSize().width - 12)
	self:getChildByName("careerIcon"):loadTexture(CAREER_ICON[horcrux_data[playermodel.items[arg_78_1].itemid].career .. "_" .. var_0_19(var_78_1)], var_0_0)
	global_load_star(self, horcrux_manager:getHorcruxStarLevel(arg_78_1), nil, "star_")
	ccui.Helper:seekWidgetByName(self, "lock"):setVisible(playermodel.items[arg_78_1].horcrux_attr.lock)

	if array_manager:getAreanDefenceByHorcruxID(arg_78_1) then
		self:getChildByName("fightingtag"):setVisible(true)
		self:getChildByName("fightingtag"):getChildByName("fightlabel"):setString("编队中")
	else
		self:getChildByName("fightingtag"):setVisible(false)
	end

	if arg_78_2 then
		local var_78_6 = horcrux_manager:getHorcruxAssistConfig(arg_78_1)
		local var_78_7
		local var_78_8

		if horcrux_manager:getHorcruxHClass(arg_78_1) > 0 then
			var_78_7 = horcrux_manager:getHorcruxDamageFac(self.entityid) / 100 + horcrux_manager:getHorcruxDamageFacAdditionByEntityid(self.entityid) / 100
			var_78_8 = math.floor(horcrux_manager:getHorcruxHpFac(self.entityid) / 100 + horcrux_manager:getHorcruxHpFacAdditionByEntityid(self.entityid) / 100)
		else
			var_78_7 = horcrux_manager:getHorcruxDamageFac(self.entityid) / 100
			var_78_8 = math.floor(horcrux_manager:getHorcruxHpFac(self.entityid) / 100)
		end

		local var_78_10 = self:getChildByName("backPanel")

		var_78_10:setVisible(true)
		var_78_10:getChildByName("hpLabel"):setString("血量:" .. global_trans_number(math.floor(var_78_6.hp)) .. "\n(" .. var_78_8 .. ")")
		var_78_10:getChildByName("damageLabel"):setString("攻击:" .. global_trans_number(math.floor(var_78_6.damage)) .. "\n(" .. var_78_7 .. ")")
		var_78_10:getChildByName("fightCapacityLabel"):setString("战力:" .. fight_capacity_manager:getHorcruxAddition(arg_78_1))
	else
		self:getChildByName("backPanel"):setVisible(false)
	end

	self:updateAlert(arg_78_1)
	self:updateRaceIcon(arg_78_1)
end

HorcruxTvtDefenceSprite = class("HorcruxTvtDefenceSprite", function()
	return HorcruxPreviewStyleSprite.new()
end)

function HorcruxTvtDefenceSprite:update(arg_80_1, arg_80_2)
	local var_80_0 = cc.p(75, 15)

	self.entityid = arg_80_1

	local var_80_1 = playermodel.items[arg_80_1].itemid
	local var_80_2 = (item_data[var_80_1].image_offset_y or 0) * (self.scale or 1)

	ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionX(var_80_0.x + (item_data[playermodel.items[arg_80_1].itemid].image_offse_x or 0) * (self.scale or 1))
	ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionY(var_80_0.y + var_80_2)

	local var_80_3 = self:getAttr(var_80_1)

	self:loadTextures("public/rolebg/horcrux_rarity_" .. horcrux_data[var_80_1].rarity .. ".png", "public/rolebg/horcrux_rarity_" .. horcrux_data[var_80_1].rarity .. ".png", "public/rolebg/horcrux_rarity_" .. horcrux_data[var_80_1].rarity .. ".png", var_0_0)
	ccui.Helper:seekWidgetByName(self, "rarityIcon"):loadTexture(SHOT_RARITY_CION[horcrux_data[var_80_1].rarity], var_0_0)
	ccui.Helper:seekWidgetByName(self, "horcrux"):loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[horcrux_data[playermodel.items[arg_80_1].itemid].model].cute_Q .. ".png")

	local var_80_4 = horcrux_manager:getHorcruxHClass(arg_80_1)

	ccui.Helper:seekWidgetByName(self, "grade"):loadTexture("public/rolebg/horcrux_+" .. var_80_4 .. ".png", var_0_0)
	ccui.Helper:seekWidgetByName(self, "grade"):setVisible(var_80_4 > 0)

	local var_80_5 = self:getChildByName("lvLabel")

	var_80_5:setString(horcrux_manager:getHorcruxHLV(arg_80_1))
	self:getChildByName("lvIcon"):setPositionX(var_80_5:getPositionX() - var_80_5:getContentSize().width - 12)
	self:getChildByName("careerIcon"):loadTexture(CAREER_ICON[horcrux_data[playermodel.items[arg_80_1].itemid].career .. "_" .. var_0_19(var_80_1)], var_0_0)
	global_load_star(self, horcrux_manager:getHorcruxStarLevel(arg_80_1), nil, "star_")
	ccui.Helper:seekWidgetByName(self, "lock"):setVisible(playermodel.items[arg_80_1].horcrux_attr.lock)

	local var_80_6 = arenatft_manager:getTvtDefenceByHorcruxID(arg_80_1)

	print("·arrayIdarrayIdarrayIdarrayId===··", var_80_6, arg_80_1)

	if var_80_6 then
		self:getChildByName("fightingtag"):setVisible(true)
		self:getChildByName("fightingtag"):getChildByName("fightlabel"):setString("编队" .. var_80_6)
	else
		self:getChildByName("fightingtag"):setVisible(false)
	end

	if arg_80_2 then
		local var_80_7 = horcrux_manager:getHorcruxAssistConfig(arg_80_1)
		local var_80_8
		local var_80_9

		if horcrux_manager:getHorcruxHClass(arg_80_1) > 0 then
			var_80_8 = horcrux_manager:getHorcruxDamageFac(self.entityid) / 100 + horcrux_manager:getHorcruxDamageFacAdditionByEntityid(self.entityid) / 100
			var_80_9 = math.floor(horcrux_manager:getHorcruxHpFac(self.entityid) / 100 + horcrux_manager:getHorcruxHpFacAdditionByEntityid(self.entityid) / 100)
		else
			var_80_8 = horcrux_manager:getHorcruxDamageFac(self.entityid) / 100
			var_80_9 = math.floor(horcrux_manager:getHorcruxHpFac(self.entityid) / 100)
		end

		local var_80_11 = self:getChildByName("backPanel")

		var_80_11:setVisible(true)
		var_80_11:getChildByName("hpLabel"):setString("血量:" .. global_trans_number(math.floor(var_80_7.hp)) .. "\n(" .. var_80_9 .. ")")
		var_80_11:getChildByName("damageLabel"):setString("攻击:" .. global_trans_number(math.floor(var_80_7.damage)) .. "\n(" .. var_80_8 .. ")")
		var_80_11:getChildByName("fightCapacityLabel"):setString("战力:" .. fight_capacity_manager:getHorcruxAddition(arg_80_1))
	else
		self:getChildByName("backPanel"):setVisible(false)
	end

	self:updateAlert(arg_80_1)
end

HorcruxTvtAttackSprite = class("HorcruxTvtAttackSprite", function()
	return HorcruxPreviewStyleSprite.new()
end)

function HorcruxTvtAttackSprite:update(arg_82_1, arg_82_2)
	local var_82_0 = cc.p(75, 15)

	self.entityid = arg_82_1

	local var_82_1 = playermodel.items[arg_82_1].itemid
	local var_82_2 = (item_data[var_82_1].image_offset_y or 0) * (self.scale or 1)

	ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionX(var_82_0.x + (item_data[playermodel.items[arg_82_1].itemid].image_offse_x or 0) * (self.scale or 1))
	ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionY(var_82_0.y + var_82_2)

	local var_82_3 = self:getAttr(var_82_1)

	self:loadTextures("public/rolebg/horcrux_rarity_" .. horcrux_data[var_82_1].rarity .. ".png", "public/rolebg/horcrux_rarity_" .. horcrux_data[var_82_1].rarity .. ".png", "public/rolebg/horcrux_rarity_" .. horcrux_data[var_82_1].rarity .. ".png", var_0_0)
	ccui.Helper:seekWidgetByName(self, "rarityIcon"):loadTexture(SHOT_RARITY_CION[horcrux_data[var_82_1].rarity], var_0_0)
	ccui.Helper:seekWidgetByName(self, "horcrux"):loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[horcrux_data[playermodel.items[arg_82_1].itemid].model].cute_Q .. ".png")

	local var_82_4 = horcrux_manager:getHorcruxHClass(arg_82_1)

	ccui.Helper:seekWidgetByName(self, "grade"):loadTexture("public/rolebg/horcrux_+" .. var_82_4 .. ".png", var_0_0)
	ccui.Helper:seekWidgetByName(self, "grade"):setVisible(var_82_4 > 0)

	local var_82_5 = self:getChildByName("lvLabel")

	var_82_5:setString(horcrux_manager:getHorcruxHLV(arg_82_1))
	self:getChildByName("lvIcon"):setPositionX(var_82_5:getPositionX() - var_82_5:getContentSize().width - 12)
	self:getChildByName("careerIcon"):loadTexture(CAREER_ICON[horcrux_data[playermodel.items[arg_82_1].itemid].career .. "_" .. var_0_19(var_82_1)], var_0_0)
	global_load_star(self, horcrux_manager:getHorcruxStarLevel(arg_82_1), nil, "star_")
	ccui.Helper:seekWidgetByName(self, "lock"):setVisible(playermodel.items[arg_82_1].horcrux_attr.lock)

	local var_82_6 = arenatft_manager:getTvtAttackByHorcruxID(arg_82_1)

	print("·arrayIdarrayIdarrayIdarrayId===··", var_82_6, arg_82_1)

	if var_82_6 then
		self:getChildByName("fightingtag"):setVisible(true)
		self:getChildByName("fightingtag"):getChildByName("fightlabel"):setString("编队" .. var_82_6)
	else
		self:getChildByName("fightingtag"):setVisible(false)
	end

	if arg_82_2 then
		local var_82_7 = horcrux_manager:getHorcruxAssistConfig(arg_82_1)
		local var_82_8
		local var_82_9

		if horcrux_manager:getHorcruxHClass(arg_82_1) > 0 then
			var_82_8 = horcrux_manager:getHorcruxDamageFac(self.entityid) / 100 + horcrux_manager:getHorcruxDamageFacAdditionByEntityid(self.entityid) / 100
			var_82_9 = math.floor(horcrux_manager:getHorcruxHpFac(self.entityid) / 100 + horcrux_manager:getHorcruxHpFacAdditionByEntityid(self.entityid) / 100)
		else
			var_82_8 = horcrux_manager:getHorcruxDamageFac(self.entityid) / 100
			var_82_9 = math.floor(horcrux_manager:getHorcruxHpFac(self.entityid) / 100)
		end

		local var_82_11 = self:getChildByName("backPanel")

		var_82_11:setVisible(true)
		var_82_11:getChildByName("hpLabel"):setString("血量:" .. global_trans_number(math.floor(var_82_7.hp)) .. "\n(" .. var_82_9 .. ")")
		var_82_11:getChildByName("damageLabel"):setString("攻击:" .. global_trans_number(math.floor(var_82_7.damage)) .. "\n(" .. var_82_8 .. ")")
		var_82_11:getChildByName("fightCapacityLabel"):setString("战力:" .. fight_capacity_manager:getHorcruxAddition(arg_82_1))
	else
		self:getChildByName("backPanel"):setVisible(false)
	end

	self:updateAlert(arg_82_1)
end

HorcruxPreviewTopStyleSprite = class("HorcruxPreviewTopStyleSprite", function()
	return HorcruxSprite.new()
end)

function HorcruxPreviewTopStyleSprite:init()
	local var_84_0 = cc.p(75, 15)

	self.scale = 0.46

	self:setAnchorPoint(cc.p(0, 0))
	self:setScale9Enabled(true)
	self:setCapInsets(cc.rect(40, 40, 20, 20))
	self:setContentSize(cc.size(240, 190))
	self:setOpacity(0)
	self:setCascadeOpacityEnabled(false)

	self.horcruxPanel = ccui.Layout:create()

	self.horcruxPanel:setContentSize(cc.size(self:getContentSize().width, self:getContentSize().height))
	self.horcruxPanel:setAnchorPoint(cc.p(0, 0))
	self.horcruxPanel:setPosition(cc.p(4, 6))
	self.horcruxPanel:setClippingEnabled(true)
	self:addChild(self.horcruxPanel, var_0_17.ICON)

	local var_84_1 = ccui.ImageView:create("GUI/image.png", var_0_0)

	var_84_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_84_1:setPosition(cc.p(self.horcruxPanel:getContentSize().width / 2, self.horcruxPanel:getContentSize().height / 2 + 30))
	var_84_1:setScale(self.scale)
	var_84_1:setName("horcrux")
	self.horcruxPanel:addChild(var_84_1)

	local var_84_2 = ccui.ImageView:create("public/rolebg/horcrux_+5.png", var_0_0)

	var_84_2:setAnchorPoint(cc.p(0, 0))
	var_84_2:setPositionX(5)
	var_84_2:setPositionY(25)
	var_84_2:setName("grade")
	self:addChild(var_84_2, var_0_17.INFO)

	local var_84_3 = TempWidget:CreateTempImg("public/currency/star1.png", self)

	var_84_3:setName("starImg")
	var_84_3:align(cc.p(0.5, 0), self:getContentSize().width / 2, -20)
	var_84_3:setLocalZOrder(var_0_17.ICON)

	local var_84_4 = ccui.ImageView:create(CAREER_ICON.assassin_dark, var_0_0)

	var_84_4:setAnchorPoint(cc.p(1, 1))
	var_84_4:setPosition(cc.p(self:getContentSize().width - 5, self:getContentSize().height - 5))
	var_84_4:setScale(0.5)
	var_84_4:setName("careerIcon")
	self:addChild(var_84_4, var_0_17.INFO)

	local var_84_5 = TempWidget:CreateTempImg(CAREER_ICON.assassin_dark, var_84_4)
	local var_84_6 = TempWidget:CreateTempImg(CAREER_ICON.assassin_dark, var_84_5)

	var_84_6:center()
	var_84_6:setOpacity(0)
	var_84_5:setName("linkCareerIcon")
	var_84_5:hide()

	var_84_5.linkCareerScaleIcon = var_84_6

	function var_84_5.play()
		var_84_5:stopAllActions()
		var_84_5:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(1, 150), cc.CallFunc:create(function()
			var_84_6:stopAllActions()
			var_84_6:runAction(cc.Sequence:create(cc.FadeTo:create(0, 200), cc.EaseExponentialOut:create(cc.Spawn:create(cc.ScaleTo:create(1, 1.8), cc.FadeOut:create(1))), cc.ScaleTo:create(0, 1)))
		end), cc.FadeIn:create(0.5))))
	end

	var_84_5:center()

	local var_84_7 = TempWidget:CreateTempLabel("等级:", FONT_NAME, 16, self)

	var_84_7:setLocalZOrder(var_0_17.INFO)
	var_84_7:_setColor("ebb62b")
	var_84_7:align(cc.p(1, 0), self:getContentSize().width - 5, var_84_2:getPositionY() + 30)

	local var_84_8 = cc.Label:createWithTTF("888", "fonts/archives.ttf", 31)

	var_84_8:setColor(cc.c3b(255, 255, 255))
	var_84_8:setAnchorPoint(cc.p(0.5, 0))
	var_84_8:setPosition(cc.p(self:getContentSize().width - 25, var_84_2:getPositionY()))
	var_84_8:setName("lvLabel")
	self:addChild(var_84_8, var_0_17.INFO)

	local var_84_9 = ccui.Layout:create()

	var_84_9:setContentSize(self.horcruxPanel:getContentSize())
	var_84_9:setAnchorPoint(cc.p(0.5, 0.5))
	var_84_9:setPosition(cc.p(self.horcruxPanel:getPositionX() + self.horcruxPanel:getContentSize().width / 2, self.horcruxPanel:getPositionY() + self.horcruxPanel:getContentSize().height / 2))
	var_84_9:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_84_9:setBackGroundColor(cc.c3b(0, 0, 0))
	var_84_9:setBackGroundColorOpacity(200)
	var_84_9:setVisible(false)
	var_84_9:setName("skillBg")
	self:addChild(var_84_9, var_0_17.BACKPANEL)

	local var_84_10 = cc.Label:createWithTTF("", FONT_NAME, 26)

	var_84_10:setAnchorPoint(cc.p(0, 0.5))
	var_84_10:setColor(cc.c3b(255, 150, 0))
	var_84_10:setPosition(cc.p(5, var_84_9:getContentSize().height - 13))
	var_84_10:setName("skillName")
	var_84_9:addChild(var_84_10)

	local var_84_11 = cc.Label:createWithTTF("", FONT_DES, 22)

	var_84_11:setAnchorPoint(cc.p(0, 1))
	var_84_11:setPosition(cc.p(5, var_84_9:getContentSize().height - 30))
	var_84_11:setMaxLineWidth(var_84_9:getContentSize().width - 10)
	var_84_11:setLineBreakWithoutSpace(true)
	var_84_11:setName("skillDes")
	var_84_9:addChild(var_84_11)

	local var_84_12 = ccui.ImageView:create("public/rolebg/1.png", var_0_0)

	var_84_12:setName("raceIcon")
	var_84_12:setScale(0.4)
	var_84_12:setAnchorPoint(cc.p(0, 1))
	var_84_12:setPositionX(5)
	var_84_12:setPositionY(self:getContentSize().height - 5)
	self:addChild(var_84_12, var_0_17.RACE)
end

function HorcruxPreviewTopStyleSprite:showSkillPanel(arg_87_1)
	local var_87_0 = self:getChildByName("skillBg")

	if not arg_87_1 then
		var_87_0:setVisible(false)

		return
	end

	var_87_0:setVisible(true)
	var_87_0:getChildByName("skillName"):setString(total_skill_data[arg_87_1].name)
	var_87_0:getChildByName("skillDes"):setString(total_skill_data[arg_87_1].description)
end

function HorcruxPreviewTopStyleSprite:hideSkillPanel()
	self:getChildByName("skillBg"):setVisible(false)
end

function HorcruxPreviewTopStyleSprite:update(arg_89_1)
	local var_89_0 = cc.p(75, 15)

	self.entityid = arg_89_1

	local var_89_3 = self:getAttr(playermodel.items[arg_89_1].itemid)

	ccui.Helper:seekWidgetByName(self, "horcrux"):loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[horcrux_data[playermodel.items[arg_89_1].itemid].model].cute_Q .. ".png")
	ccui.Helper:seekWidgetByName(self, "grade"):loadTexture("public/rolebg/horcrux_+" .. horcrux_manager:getHorcruxHClass(arg_89_1) .. ".png", var_0_0)
	self:getChildByName("lvLabel"):setString(horcrux_manager:getHorcruxHLV(arg_89_1))

	local var_89_5 = var_0_19(playermodel.items[arg_89_1].itemid)

	self:getChildByName("careerIcon"):loadTexture(CAREER_ICON[horcrux_data[playermodel.items[arg_89_1].itemid].career .. "_" .. var_89_5], var_0_0)
	self:getChildByName("careerIcon"):getChildByName("linkCareerIcon"):loadTexture("public/career_icon/link_" .. var_89_5 .. ".png", var_0_0)
	self:getChildByName("careerIcon"):getChildByName("linkCareerIcon"):center()
	self:getChildByName("careerIcon"):getChildByName("linkCareerIcon").linkCareerScaleIcon:loadTexture("public/career_icon/link_" .. var_89_5 .. ".png", var_0_0)
	self:getChildByName("careerIcon"):getChildByName("linkCareerIcon").linkCareerScaleIcon:center()
	self:getChildByName("starImg"):loadTextureEx("public/currency/star" .. horcrux_manager:getHorcruxStarLevel(arg_89_1) .. ".png")
	self:updateRaceIcon(arg_89_1)
end

function HorcruxPreviewTopStyleSprite:imgScaleTo(arg_90_1, arg_90_2)
	self.horcruxPanel:getChildByName("horcrux"):runAction(cc.ScaleTo:create(arg_90_2, self.scale * arg_90_1, self.scale * arg_90_1))
end

HorcruxArrayMemberStyleSprite = class("HorcruxArrayMemberStyleSprite", function()
	return HorcruxSprite.new()
end)

function HorcruxArrayMemberStyleSprite:init()
	self.horcruxPos = cc.p(50, 5)
	self.scale = 0.26

	self:loadTextures("public/rolebg/horcrux_array_member_rarity_3.png", "public/rolebg/horcrux_array_member_rarity_3.png", "public/rolebg/horcrux_array_member_rarity_3.png", var_0_0)
	self:setAnchorPoint(cc.p(0, 0))

	self.horcruxPanel = ccui.Layout:create()

	self.horcruxPanel:setContentSize(cc.size(self:getContentSize().width - 6, self:getContentSize().height - 9))
	self.horcruxPanel:setAnchorPoint(cc.p(0, 0))
	self.horcruxPanel:setPosition(cc.p(3, 3))
	self.horcruxPanel:setClippingEnabled(true)
	self:addChild(self.horcruxPanel, var_0_17.ICON)

	local var_92_0 = ccui.Layout:create()

	var_92_0:setContentSize(self.horcruxPanel:getContentSize())
	var_92_0:setPosition(cc.p(self.horcruxPanel:getContentSize().width / 2, self.horcruxPanel:getContentSize().height / 2))
	var_92_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_92_0:setName("scale_layer")
	self.horcruxPanel:addChild(var_92_0)

	local var_92_1 = ccui.ImageView:create(SHOT_RARITY_CION[1], var_0_0)

	var_92_1:setAnchorPoint(cc.p(1, 1))
	var_92_1:setPosition(cc.p(self:getContentSize().width - 2, self:getContentSize().height - 2))
	var_92_1:setName("rarityIcon")
	var_92_1:setScale(0.38)
	self:addChild(var_92_1, var_0_17.INFO)

	local var_92_2 = ccui.ImageView:create("GUI/image.png", var_0_0)

	var_92_2:setAnchorPoint(var_0_22)
	var_92_2:setPosition(self.horcruxPos)
	var_92_2:setScale(self.scale)
	var_92_2:setName("horcrux")
	var_92_0:addChild(var_92_2)

	local var_92_3 = ccui.ImageView:create("public/rolebg/horcrux_+5.png", var_0_0)

	var_92_3:setScale(0.6)
	var_92_3:setAnchorPoint(cc.p(0, 1))
	var_92_3:setPositionX(6)
	var_92_3:setPositionY(self:getContentSize().height - 6)
	var_92_3:setName("grade")
	self:addChild(var_92_3, var_0_17.INFO)

	for iter_92_0 = 1, 5 do
		local var_92_4 = ccui.ImageView:create("public/currency/weapon_star.png", var_0_0)

		var_92_4:setAnchorPoint(cc.p(0.5, 0.5))
		var_92_4:setScale(0.46)
		var_92_4:setPosition(cc.p(80, 78))
		var_92_4:setName("star_" .. iter_92_0)
		self:addChild(var_92_4, var_0_17.INFO)
	end

	local var_92_6 = ccui.ImageView:create("public/rolebg/horcru_array_bg.png", var_0_0)

	var_92_6:setAnchorPoint(cc.p(0, 0))
	var_92_6:setPosition(cc.p(0, 0))
	var_92_6:setScaleX(self:getContentSize().width / var_92_6:getContentSize().width)
	var_92_6:setName("lvBg")
	var_92_6:setContentSize(cc.size(self:getContentSize().width, var_92_6:getContentSize().height))
	self.horcruxPanel:addChild(var_92_6, var_0_17.INFO)

	local var_92_7 = ccui.ImageView:create(CAREER_ICON.assassin_dark, var_0_0)

	var_92_7:setAnchorPoint(cc.p(0, 0))
	var_92_7:setPosition(cc.p(6, 6))
	var_92_7:setScale(0.26)
	var_92_7:setName("careerIcon")
	self:addChild(var_92_7, var_0_17.INFO)

	local var_92_8 = cc.Label:createWithTTF("888", FONT_DES, 18)

	var_92_8:setColor(cc.c3b(255, 255, 255))
	var_92_8:setAnchorPoint(cc.p(1, 0.5))
	var_92_8:setPosition(cc.p(self:getContentSize().width - 10, 10))
	var_92_8:setName("lvLabel")
	self:addChild(var_92_8, var_0_17.INFO)

	local var_92_9 = ccui.ImageView:create("public/rolebg/img_lv.png", var_0_0)

	var_92_9:setPositionX(var_92_8:getPositionX() - var_92_8:getContentSize().width - 6)
	var_92_9:setPositionY(10)
	var_92_9:setName("lvIcon")
	self:addChild(var_92_9, var_0_17.INFO)

	local var_92_10 = ccui.Layout:create()

	var_92_10:setContentSize(self.horcruxPanel:getContentSize())
	var_92_10:setAnchorPoint(cc.p(0.5, 0.5))
	var_92_10:setPosition(cc.p(self.horcruxPanel:getPositionX() + self.horcruxPanel:getContentSize().width / 2, self.horcruxPanel:getPositionY() + self.horcruxPanel:getContentSize().height / 2))
	var_92_10:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_92_10:setBackGroundColor(cc.c3b(0, 0, 0))
	var_92_10:setBackGroundColorOpacity(200)
	var_92_10:setVisible(false)
	var_92_10:setName("skillBg")
	self:addChild(var_92_10, var_0_17.BACKPANEL)

	local var_92_11 = cc.Label:createWithTTF("", FONT_NAME, 26)

	var_92_11:setAnchorPoint(cc.p(0, 0.5))
	var_92_11:setColor(cc.c3b(255, 150, 0))
	var_92_11:setPosition(cc.p(5, var_92_10:getContentSize().height - 13))
	var_92_11:setName("skillName")
	var_92_10:addChild(var_92_11)

	local var_92_12 = cc.Label:createWithTTF("", FONT_DES, 22)

	var_92_12:setAnchorPoint(cc.p(0, 1))
	var_92_12:setPosition(cc.p(5, var_92_10:getContentSize().height - 30))
	var_92_12:setMaxLineWidth(var_92_10:getContentSize().width - 40)
	var_92_12:setLineBreakWithoutSpace(true)
	var_92_12:setName("skillDes")
	var_92_10:addChild(var_92_12)

	local var_92_13 = ccui.ImageView:create("public/rolebg/1.png", var_0_0)

	var_92_13:setName("raceIcon")
	var_92_13:setScale(0.3)
	var_92_13:setPositionX(128)
	var_92_13:setPositionY(50)
	var_92_13:setVisible(false)
	self:addChild(var_92_13, var_0_17.RACE)
end

function HorcruxArrayMemberStyleSprite:showSkillPanel(arg_93_1)
	local var_93_0 = self:getChildByName("skillBg")

	if not arg_93_1 then
		var_93_0:setVisible(false)

		return
	end

	var_93_0:setVisible(true)
	var_93_0:getChildByName("skillName"):setString(total_skill_data[arg_93_1].name)
	var_93_0:getChildByName("skillDes"):setString(total_skill_data[arg_93_1].easy_description)
end

function HorcruxArrayMemberStyleSprite:hideSkillPanel()
	self:getChildByName("skillBg"):setVisible(false)
end

function HorcruxArrayMemberStyleSprite:updateSub(arg_95_1)
	local var_95_1 = (item_data[arg_95_1.itemid].image_offset_y or 0) * (self.scale or 1)

	ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionX(self.horcruxPos.x + (item_data[arg_95_1.itemid].image_offse_x or 0) * (self.scale or 1))
	ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionY(self.horcruxPos.y + var_95_1)

	local var_95_2 = self:getAttr(arg_95_1.itemid)

	self:loadTextures("public/rolebg/horcrux_array_member_rarity_" .. horcrux_data[arg_95_1.itemid].rarity .. ".png", "public/rolebg/horcrux_array_member_rarity_" .. horcrux_data[arg_95_1.itemid].rarity .. ".png", "public/rolebg/horcrux_array_member_rarity_" .. horcrux_data[arg_95_1.itemid].rarity .. ".png", var_0_0)
	ccui.Helper:seekWidgetByName(self, "rarityIcon"):loadTexture(SHOT_RARITY_CION[horcrux_data[arg_95_1.itemid].rarity], var_0_0)
	ccui.Helper:seekWidgetByName(self, "horcrux"):loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[horcrux_data[arg_95_1.itemid].model].cute_Q .. ".png")

	local var_95_3 = arg_95_1.hclass

	ccui.Helper:seekWidgetByName(self, "grade"):loadTexture("public/rolebg/horcrux_+" .. arg_95_1.hclass .. ".png", var_0_0)
	ccui.Helper:seekWidgetByName(self, "grade"):setVisible(var_95_3 > 0)

	local var_95_4 = self:getChildByName("lvLabel")

	var_95_4:setString(arg_95_1.hlv)
	self:getChildByName("lvIcon"):setPositionX(var_95_4:getPositionX() - var_95_4:getContentSize().width - 12)
	self:getChildByName("careerIcon"):loadTexture(CAREER_ICON[horcrux_data[arg_95_1.itemid].career .. "_" .. var_0_19(arg_95_1.itemid)], var_0_0)
	global_load_star(self, arg_95_1.star, nil, "star_")
end

function HorcruxArrayMemberStyleSprite:update(arg_96_1)
	self.entityid = arg_96_1

	local var_96_0 = playermodel.items[arg_96_1].itemid
	local var_96_1 = (item_data[var_96_0].image_offset_y or 0) * (self.scale or 1)

	ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionX(self.horcruxPos.x + (item_data[playermodel.items[arg_96_1].itemid].image_offse_x or 0) * (self.scale or 1))
	ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionY(self.horcruxPos.y + var_96_1)

	local var_96_2 = self:getAttr(var_96_0)

	self:loadTextures("public/rolebg/horcrux_array_member_rarity_" .. horcrux_data[var_96_0].rarity .. ".png", "public/rolebg/horcrux_array_member_rarity_" .. horcrux_data[var_96_0].rarity .. ".png", "public/rolebg/horcrux_array_member_rarity_" .. horcrux_data[var_96_0].rarity .. ".png", var_0_0)
	ccui.Helper:seekWidgetByName(self, "rarityIcon"):loadTexture(SHOT_RARITY_CION[horcrux_data[var_96_0].rarity], var_0_0)
	ccui.Helper:seekWidgetByName(self, "horcrux"):loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[horcrux_data[playermodel.items[arg_96_1].itemid].model].cute_Q .. ".png")

	local var_96_3 = horcrux_manager:getHorcruxHClass(arg_96_1)

	ccui.Helper:seekWidgetByName(self, "grade"):loadTexture("public/rolebg/horcrux_+" .. var_96_3 .. ".png", var_0_0)
	ccui.Helper:seekWidgetByName(self, "grade"):setVisible(var_96_3 > 0)

	local var_96_4 = self:getChildByName("lvLabel")

	var_96_4:setString(horcrux_manager:getHorcruxHLV(arg_96_1))
	self:getChildByName("lvIcon"):setPositionX(var_96_4:getPositionX() - var_96_4:getContentSize().width - 12)
	self:getChildByName("careerIcon"):loadTexture(CAREER_ICON[horcrux_data[playermodel.items[arg_96_1].itemid].career .. "_" .. var_0_19(var_96_0)], var_0_0)
	global_load_star(self, horcrux_manager:getHorcruxStarLevel(arg_96_1), nil, "star_")
	self:updateRaceIcon(arg_96_1)
end

function HorcruxArrayMemberStyleSprite:imgScaleTo(arg_97_1, arg_97_2)
	ccui.Helper:seekWidgetByName(self.horcruxPanel, "horcrux"):runAction(cc.ScaleTo:create(arg_97_2, self.scale * arg_97_1, self.scale * arg_97_1))
end

HorcruxPatrolStyleSprite = class("HorcruxPatrolStyleSprite", function()
	return HorcruxSprite.new()
end)

function HorcruxPatrolStyleSprite:init()
	self:setAnchorPoint(cc.p(0.5, 0.5))
	self:loadTextures("public/rolebg/horcrux_bag_rarity_1.png", "public/rolebg/horcrux_bag_rarity_1.png", "public/rolebg/horcrux_bag_rarity_1.png", var_0_0)

	local var_99_0 = ccui.ImageView:create("GUI/image.png", var_0_0)

	var_99_0:setName("head_img")
	var_99_0:setAnchorPoint(cc.p(0.5, 0.23333333333333334))
	var_99_0:setScale((self:getContentSize().height - 5) / 300)
	var_99_0:setPosition(self:getContentSize().width / 2, 42)
	self:addChild(var_99_0)

	for iter_99_0 = 1, 5 do
		local var_99_1 = ccui.ImageView:create("patrol/star.png", var_0_0)

		var_99_1:setName("star_" .. iter_99_0)
		var_99_1:setPosition(24 + (iter_99_0 - 1) * 14, 26)
		self:addChild(var_99_1)
	end

	local var_99_2 = ccui.ImageView:create("public/rolebg/level_bg.png", var_0_0)

	var_99_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_99_2:setPosition(cc.p(self:getContentSize().width - var_99_2:getContentSize().width / 2 - 12, 26))
	var_99_2:setName("lvBg")
	self:addChild(var_99_2, var_0_17.INFO)

	local var_99_3 = cc.Label:createWithTTF("???", FONT_NAME, 24)

	var_99_3:setColor(cc.c3b(255, 224, 54))
	var_99_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_99_3:setPosition(cc.p(var_99_2:getPositionX() + 18, var_99_2:getPositionY()))
	var_99_3:setName("lvLabel")
	self:addChild(var_99_3, var_0_17.INFO)

	local var_99_4 = ccui.ImageView:create("public/rolebg/1.png", var_0_0)

	var_99_4:setName("raceIcon")
	var_99_4:setPositionX(100)
	var_99_4:setPositionY(100)
	var_99_4:setScale(0.3)
	self:addChild(var_99_4, var_0_17.RACE)
end

function HorcruxPatrolStyleSprite:update(arg_100_1)
	local var_100_0 = self:getAttr(playermodel.items[arg_100_1].itemid)

	self:loadTextures("public/rolebg/horcrux_bag_rarity_" .. horcrux_data[playermodel.items[arg_100_1].itemid].rarity .. ".png", "public/rolebg/horcrux_bag_rarity_" .. horcrux_data[playermodel.items[arg_100_1].itemid].rarity .. ".png", "public/rolebg/horcrux_bag_rarity_" .. horcrux_data[playermodel.items[arg_100_1].itemid].rarity .. ".png", var_0_0)
	self:getChildByName("head_img"):loadTexture("roleimage/role/wuji/" .. model_data[horcrux_data[playermodel.items[arg_100_1].itemid].model].head_image .. ".png")
	global_load_star(self, horcrux_manager:getHorcruxStarLevel(arg_100_1), nil, "star_")
	self:getChildByName("lvLabel"):setString(horcrux_manager:getHorcruxHLV(arg_100_1))
	self:updateRaceIcon(arg_100_1)
end

HorcruxEnemyArrayMemberStyleSprite = class("HorcruxEnemyArrayMemberStyleSprite", function()
	return HorcruxArrayMemberStyleSprite.new()
end)

function HorcruxEnemyArrayMemberStyleSprite:update(arg_102_1)
	if not arg_102_1.horcrux then
		return
	end

	local var_102_0 = arg_102_1.horcrux.itemid
	local var_102_1 = arg_102_1.horcrux.hclass
	local var_102_2 = arg_102_1.horcrux.hlv
	local var_102_3 = arg_102_1.horcrux.star or 2
	local var_102_4 = cc.p(75, 15)
	local var_102_7 = self:getAttr(var_102_0)

	self:loadTextures("public/rolebg/horcrux_array_member_rarity_" .. horcrux_data[var_102_0].rarity .. ".png", "public/rolebg/horcrux_array_member_rarity_" .. horcrux_data[var_102_0].rarity .. ".png", "public/rolebg/horcrux_array_member_rarity_" .. horcrux_data[var_102_0].rarity .. ".png", var_0_0)
	self:getChildByName("careerIcon"):loadTexture(CAREER_ICON[horcrux_data[var_102_0].career .. "_" .. var_0_19(var_102_0)], var_0_0)
	ccui.Helper:seekWidgetByName(self, "rarityIcon"):loadTexture(SHOT_RARITY_CION[horcrux_data[var_102_0].rarity], var_0_0)
	ccui.Helper:seekWidgetByName(self, "horcrux"):loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[horcrux_data[arg_102_1.horcrux.itemid].model].cute_Q .. ".png")
	ccui.Helper:seekWidgetByName(self, "grade"):loadTexture("public/rolebg/horcrux_+" .. var_102_1 .. ".png", var_0_0)
	ccui.Helper:seekWidgetByName(self, "grade"):setVisible(var_102_1 > 0)
	self:getChildByName("lvLabel"):setString("" .. var_102_2)
	global_load_star(self, var_102_3, nil, "star_")
	self:updateRaceIconByItemid(var_102_0)
end

HorcruxEnemyScoreArenaArrayMemberStyleSprite = class("HorcruxEnemyScoreArenaArrayMemberStyleSprite", function()
	return HorcruxPreviewTopStyleSprite.new()
end)

function HorcruxEnemyScoreArenaArrayMemberStyleSprite:update(arg_104_1)
	if not arg_104_1.horcrux then
		return
	end

	local var_104_0 = arg_104_1.horcrux.itemid
	local var_104_1 = arg_104_1.horcrux.hclass
	local var_104_2 = arg_104_1.horcrux.hlv
	local var_104_3 = arg_104_1.horcrux.star or 2
	local var_104_4 = cc.p(75, 15)
	local var_104_7 = self:getAttr(var_104_0)

	self:loadTextures("public/rolebg/horcrux_rarity_" .. horcrux_data[var_104_0].rarity .. ".png", "public/rolebg/horcrux_rarity_" .. horcrux_data[var_104_0].rarity .. ".png", "public/rolebg/horcrux_rarity_" .. horcrux_data[var_104_0].rarity .. ".png", var_0_0)
	self:getChildByName("careerIcon"):loadTexture(CAREER_ICON[horcrux_data[var_104_0].career .. "_" .. var_0_19(var_104_0)], var_0_0)
	ccui.Helper:seekWidgetByName(self, "rarityIcon"):loadTexture(SHOT_RARITY_CION[horcrux_data[var_104_0].rarity], var_0_0)
	ccui.Helper:seekWidgetByName(self, "horcrux"):loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[horcrux_data[arg_104_1.horcrux.itemid].model].cute_Q .. ".png")
	ccui.Helper:seekWidgetByName(self, "grade"):loadTexture("public/rolebg/horcrux_+" .. var_104_1 .. ".png", var_0_0)
	ccui.Helper:seekWidgetByName(self, "grade"):setVisible(var_104_1 > 0)
	self:getChildByName("lvLabel"):setString("" .. var_104_2)
	self:getChildByName("lvIcon"):setPositionX(130)
	global_load_star(self, var_104_3, nil, "star_")
	self:updateRaceIconByItemid(var_104_0)
end

HorcruxArrayMemberModeStyleSprite = class("HorcruxArrayMemberModeStyleSprite", function()
	return HorcruxSprite.new()
end)

function HorcruxArrayMemberModeStyleSprite:init(arg_106_1)
	local var_106_0 = cc.p(75, 40)

	self.isHpInherit = not not (arg_106_1 and arg_106_1.isHpInherit)
	self.scale = 0.46

	self:loadTextures("public/rolebg/horcrux_rarity_1.png", "public/rolebg/horcrux_rarity_1.png", "public/rolebg/horcrux_rarity_1.png", var_0_0)
	self:setAnchorPoint(cc.p(0, 0))
	self:setScale9Enabled(true)
	self:setCapInsets(cc.rect(40, 40, 20, 20))
	self:setContentSize(cc.size(168, 230))

	self.horcruxPanel = ccui.Layout:create()

	self.horcruxPanel:setContentSize(cc.size(self:getContentSize().width - 8, self:getContentSize().height - 12))
	self.horcruxPanel:setAnchorPoint(cc.p(0, 0))
	self.horcruxPanel:setPosition(cc.p(4, 6))
	self.horcruxPanel:setClippingEnabled(true)
	self:addChild(self.horcruxPanel, var_0_17.ICON)

	local var_106_1 = ccui.ImageView:create(SHOT_RARITY_CION[1], var_0_0)

	var_106_1:setAnchorPoint(cc.p(1, 1))
	var_106_1:setPosition(cc.p(self:getContentSize().width, self:getContentSize().height))
	var_106_1:setScale(0.8)
	var_106_1:setName("rarityIcon")
	self:addChild(var_106_1, var_0_17.INFO)

	local var_106_2 = ccui.ImageView:create("GUI/image.png", var_0_0)

	var_106_2:setAnchorPoint(var_0_22)
	var_106_2:setPosition(var_106_0)
	var_106_2:setScale(self.scale)
	var_106_2:setName("horcrux")
	self.horcruxPanel:addChild(var_106_2)

	local var_106_3 = ccui.ImageView:create("public/rolebg/horcrux_+5.png", var_0_0)

	var_106_3:setScale(0.8)
	var_106_3:setAnchorPoint(cc.p(0, 1))
	var_106_3:setPositionX(6)
	var_106_3:setPositionY(self:getContentSize().height - 6)
	var_106_3:setName("grade")
	self:addChild(var_106_3, var_0_17.INFO)

	local var_106_4 = self:getContentSize().width - 24

	for iter_106_0 = 1, 5 do
		local var_106_5 = ccui.ImageView:create("public/currency/weapon_star.png", var_0_0)

		var_106_5:setAnchorPoint(cc.p(0.5, 0.5))
		var_106_5:setPosition(cc.p(var_106_4, 180))
		var_106_5:setName("star_" .. iter_106_0)
		self:addChild(var_106_5, var_0_17.INFO)
	end

	local var_106_7 = ccui.ImageView:create("public/rolebg/horcru_bag_bg.png", var_0_0)

	var_106_7:setAnchorPoint(cc.p(0, 0))
	var_106_7:setPosition(cc.p(0, 0))
	var_106_7:setScaleX(self:getContentSize().width / var_106_7:getContentSize().width)
	var_106_7:setName("lvBg")
	self.horcruxPanel:addChild(var_106_7, var_0_17.INFO)

	local var_106_8 = ccui.ImageView:create(CAREER_ICON.assassin_dark, var_0_0)

	var_106_8:setAnchorPoint(cc.p(0, 0))
	var_106_8:setPosition(cc.p(8, 8))
	var_106_8:setScale(0.5)
	var_106_8:setName("careerIcon")
	self:addChild(var_106_8, var_0_17.INFO)

	local var_106_9 = cc.Label:createWithTTF("888", FONT_DES, 30)

	var_106_9:setColor(cc.c3b(255, 255, 255))
	var_106_9:setAnchorPoint(cc.p(1, 0.5))
	var_106_9:setPosition(cc.p(self:getContentSize().width - 15, 7))
	var_106_9:setName("lvLabel")
	self:addChild(var_106_9, var_0_17.INFO)

	local var_106_10 = ccui.ImageView:create("public/rolebg/img_lv.png", var_0_0)

	var_106_10:setPositionX(var_106_9:getPositionX() - var_106_9:getContentSize().width - 12)
	var_106_10:setPositionY(var_106_10:getContentSize().height / 2 + 8)
	var_106_10:setName("lvIcon")
	self:addChild(var_106_10, var_0_17.INFO)

	local var_106_11 = ccui.Button:create("public/button/unlock.png", nil, "public/button/unlock.png", var_0_0)

	var_106_11:setPosition(cc.p(self:getContentSize().width - 25, self:getContentSize().height - 25))
	var_106_11:setName("lock")
	var_106_11:setVisible(false)
	var_106_11:setScale(0.7)
	self:addChild(var_106_11, var_0_17.LOCK)

	local var_106_12 = ccui.ImageView:create(var_0_27, var_0_0)

	var_106_12:setAnchorPoint(cc.p(0.5, 0.5))
	var_106_12:setScale9Enabled(true)
	var_106_12:setCapInsets(cc.rect(50, 20, 1, 1))
	var_106_12:setContentSize(cc.size(self:getContentSize().width - 6, var_106_12:getContentSize().height))
	var_106_12:setPosition(cc.p(self:getContentSize().width / 2, 80))
	var_106_12:setName("fightingtag")

	local var_106_13 = cc.Label:createWithTTF(L_HORCRUXSELECT_FIGHT_TAG, "fonts/newkj.ttf", 22)

	var_106_13:setColor(cc.c3b(255, 100, 0))
	var_106_13:setPosition(cc.p(var_106_12:getContentSize().width / 2, var_106_12:getContentSize().height / 2))
	var_106_13:setName("fightlabel")
	var_106_12:addChild(var_106_13)
	self:addChild(var_106_12, var_0_17.INFO - 1)

	local var_106_14 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

	var_106_14:setPositionX(self:getContentSize().width - 10)
	var_106_14:setPositionY(self:getContentSize().height - 10)
	var_106_14:setName("redDot")
	self:addChild(var_106_14, var_0_17.REDDOT)

	local var_106_15 = ccui.Layout:create()

	var_106_15:setContentSize(cc.size(self:getContentSize().width, self:getContentSize().height))
	var_106_15:setAnchorPoint(cc.p(0, 0))
	var_106_15:setPosition(cc.p(0, 0))
	var_106_15:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_106_15:setBackGroundColor(cc.c3b(0, 0, 0))
	var_106_15:setBackGroundColorOpacity(200)
	var_106_15:setVisible(false)
	var_106_15:setName("backPanel")
	self:addChild(var_106_15, var_0_17.BACKPANEL)

	local var_106_16 = cc.Label:createWithTTF("", FONT_DES, 24)

	var_106_16:setAnchorPoint(cc.p(0, 0.5))
	var_106_16:setPosition(cc.p(5, var_106_15:getContentSize().height - 60))
	var_106_16:setCascadeOpacityEnabled(false)
	var_106_16:setColor(cc.c3b(255, 150, 0))
	var_106_16:setName("fightCapacityLabel")
	var_106_15:addChild(var_106_16)

	local var_106_17 = cc.Label:createWithTTF("", FONT_DES, 22)

	var_106_17:setAnchorPoint(cc.p(0, 0.5))
	var_106_17:setPosition(cc.p(5, var_106_16:getPositionY() - 40))
	var_106_17:setCascadeOpacityEnabled(false)
	var_106_17:setName("damageLabel")
	var_106_15:addChild(var_106_17)

	local var_106_18 = cc.Label:createWithTTF("", FONT_DES, 22)

	var_106_18:setAnchorPoint(cc.p(0, 0.5))
	var_106_18:setPosition(cc.p(5, var_106_17:getPositionY() - 52))
	var_106_18:setCascadeOpacityEnabled(false)
	var_106_18:setName("hpLabel")
	var_106_15:addChild(var_106_18)

	local var_106_19 = ccui.ImageView:create("public/rolebg/1.png", var_0_0)

	var_106_19:setName("raceIcon")
	var_106_19:setPositionX(142)
	var_106_19:setPositionY(46)
	var_106_19:setScale(0.4)
	self:addChild(var_106_19, var_0_17.RACE)
end

function HorcruxArrayMemberModeStyleSprite:update(arg_107_1, arg_107_2)
	local var_107_0 = cc.p(75, 15)

	self.entityid = arg_107_1

	local var_107_1 = playermodel.items[arg_107_1].itemid
	local var_107_2 = (item_data[var_107_1].image_offset_y or 0) * (self.scale or 1)

	ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionX(var_107_0.x + (item_data[playermodel.items[arg_107_1].itemid].image_offse_x or 0) * (self.scale or 1))
	ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionY(var_107_0.y + var_107_2)

	local var_107_3 = self:getAttr(var_107_1)

	self:loadTextures("public/rolebg/horcrux_rarity_" .. horcrux_data[var_107_1].rarity .. ".png", "public/rolebg/horcrux_rarity_" .. horcrux_data[var_107_1].rarity .. ".png", "public/rolebg/horcrux_rarity_" .. horcrux_data[var_107_1].rarity .. ".png", var_0_0)
	ccui.Helper:seekWidgetByName(self, "rarityIcon"):loadTexture(SHOT_RARITY_CION[horcrux_data[var_107_1].rarity], var_0_0)
	ccui.Helper:seekWidgetByName(self, "horcrux"):loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[horcrux_data[playermodel.items[arg_107_1].itemid].model].cute_Q .. ".png")

	local var_107_4 = horcrux_manager:getHorcruxHClass(arg_107_1)

	ccui.Helper:seekWidgetByName(self, "grade"):loadTexture("public/rolebg/horcrux_+" .. var_107_4 .. ".png", var_0_0)
	ccui.Helper:seekWidgetByName(self, "grade"):setVisible(var_107_4 > 0)

	local var_107_5 = self:getChildByName("lvLabel")

	var_107_5:setString(horcrux_manager:getHorcruxHLV(arg_107_1))
	self:getChildByName("lvIcon"):setPositionX(var_107_5:getPositionX() - var_107_5:getContentSize().width - 12)
	self:getChildByName("careerIcon"):loadTexture(CAREER_ICON[horcrux_data[playermodel.items[arg_107_1].itemid].career .. "_" .. var_0_19(var_107_1)], var_0_0)
	global_load_star(self, horcrux_manager:getHorcruxStarLevel(arg_107_1), nil, "star_")
	ccui.Helper:seekWidgetByName(self, "lock"):setVisible(playermodel.items[arg_107_1].horcrux_attr.lock)

	local var_107_6
	local var_107_7 = require("controller.formation.formation_mode_manager"):getInstance():getFormationInfo()[1] or {}

	for iter_107_0 = 1, #var_107_7 do
		if var_107_7[iter_107_0].assist_girl == arg_107_1 then
			var_107_6 = 1

			break
		end
	end

	if var_107_6 then
		self:getChildByName("fightingtag"):setVisible(true)
		self:getChildByName("fightingtag"):getChildByName("fightlabel"):setString("已装备")
	else
		self:getChildByName("fightingtag"):setVisible(false)
	end

	if arg_107_2 then
		local var_107_8 = horcrux_manager:getHorcruxAssistConfig(arg_107_1)
		local var_107_9
		local var_107_10

		if horcrux_manager:getHorcruxHClass(arg_107_1) > 0 then
			var_107_9 = horcrux_manager:getHorcruxDamageFac(self.entityid) / 100 + horcrux_manager:getHorcruxDamageFacAdditionByEntityid(self.entityid) / 100
			var_107_10 = math.floor(horcrux_manager:getHorcruxHpFac(self.entityid) / 100 + horcrux_manager:getHorcruxHpFacAdditionByEntityid(self.entityid) / 100)
		else
			var_107_9 = horcrux_manager:getHorcruxDamageFac(self.entityid) / 100
			var_107_10 = math.floor(horcrux_manager:getHorcruxHpFac(self.entityid) / 100)
		end

		local var_107_12 = self:getChildByName("backPanel")

		var_107_12:setVisible(true)
		var_107_12:getChildByName("hpLabel"):setString(L_GIRL_INFO_TABLE[5] .. global_trans_number(math.floor(var_107_8.hp)) .. "\n(" .. var_107_10 .. ")")
		var_107_12:getChildByName("damageLabel"):setString(L_GIRL_INFO_TABLE[4] .. global_trans_number(math.floor(var_107_8.damage)) .. "\n(" .. var_107_9 .. ")")
		var_107_12:getChildByName("fightCapacityLabel"):setString(L_GIRL_INFO_TABLE[3] .. fight_capacity_manager:getHorcruxAddition(arg_107_1))
	else
		self:getChildByName("backPanel"):setVisible(false)
	end

	self:updateAlert(arg_107_1)
	self:updateRaceIcon(arg_107_1)
end

function HorcruxArrayMemberModeStyleSprite:createItemHightLight(arg_108_1)
	local var_108_2 = 0.86
	local var_108_3 = 0.86

	self.selectBg = ccui.Layout:create()

	local var_108_4

	if config._DEBUG then
		var_108_4 = cc.Sprite:create("public/rolebg/new_item_bg_on1.png") or cc.Sprite:createWithSpriteFrameName("public/rolebg/new_item_bg_on1.png")
	end

	var_108_4:setPosition(arg_108_1:getContentSize().width / 2, arg_108_1:getContentSize().height / 2)
	var_108_4:setScaleX(var_108_2)
	var_108_4:setScaleY(var_108_3)
	self.selectBg:addChild(var_108_4)

	local var_108_5 = {}

	for iter_108_0 = 1, 2 do
		if iter_108_0 == 1 then
			if config._DEBUG then
				var_108_5[iter_108_0] = cc.Sprite:create("public/rolebg/new_item_bg_on2.png") or cc.Sprite:createWithSpriteFrameName("public/rolebg/new_item_bg_on2.png")
			end
		elseif config._DEBUG then
			var_108_5[iter_108_0] = cc.Sprite:create("public/rolebg/new_item_bg_on2.png") or cc.Sprite:createWithSpriteFrameName("public/rolebg/new_item_bg_on2.png")
		end

		var_108_5[iter_108_0]:setPosition(arg_108_1:getContentSize().width / 2, arg_108_1:getContentSize().height / 2 - 3)
		var_108_5[iter_108_0]:setName("img" .. iter_108_0)
		self.selectBg:addChild(var_108_5[iter_108_0])
	end

	function self.selectBg:play()
		self:getChildByName("img1"):setScaleX(1.1 * var_108_2)
		self:getChildByName("img1"):setScaleY(1.1 * var_108_3)
		self:getChildByName("img1"):setOpacity(0)
		self:getChildByName("img1"):stopAllActions()
		self:getChildByName("img1"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1 * var_108_2, 1 * var_108_3)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1 * var_108_2, 1.1 * var_108_3)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1 * var_108_2, 1 * var_108_3)), cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1 * var_108_2, 1.1 * var_108_3)))))
		self:getChildByName("img2"):setScale(1 * var_108_2)
		self:getChildByName("img2"):setScaleY(1 * var_108_3)
		self:getChildByName("img2"):setOpacity(255)
		self:getChildByName("img2"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1 * var_108_2, 1.1 * var_108_3)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1 * var_108_2, 1 * var_108_3)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1 * var_108_2, 1.1 * var_108_3)), cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1 * var_108_2, 1 * var_108_3)))))
	end

	self.selectBg:play()
	self.selectBg:setName("heightLight")
	self:addChild(self.selectBg, var_0_17.SELECTED)
end

function HorcruxArrayMemberModeStyleSprite:updateSelectHook(arg_110_1)
	if arg_110_1 and not self.selectBg then
		self.selectBg = ccui.Layout:create()

		self.selectBg:setTouchEnabled(false)
		self.selectBg:setContentSize(cc.size(self:getContentSize().width, self:getContentSize().height))
		self.selectBg:setAnchorPoint(cc.p(0.5, 0.5))
		self.selectBg:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height / 2))
		self.selectBg:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		self.selectBg:setBackGroundColor(cc.c3b(0, 0, 0))
		self.selectBg:setBackGroundColorOpacity(120)

		local var_110_0 = ccui.ImageView:create("public/rolebg/hook.png", var_0_0)

		var_110_0:setPosition(cc.p(self.selectBg:getContentSize().width / 2, self.selectBg:getContentSize().height / 2))
		self.selectBg:addChild(var_110_0)

		function self.selectBg.play(arg_111_0)
			return
		end

		self.selectBg:play()
		self.selectBg:setName("heightLight")
		self:addChild(self.selectBg, var_0_17.SELECTED)
	end

	if arg_110_1 ~= nil and self.selectBg then
		self.selectBg:setVisible(arg_110_1)
	end
end

function HorcruxArrayMemberModeStyleSprite:updateNewIcon(arg_112_1)
	if arg_112_1 then
		if not self:getChildByName("newIcon") then
			local var_112_0 = ccui.ImageView:create(var_0_20, var_0_0)

			var_112_0:setPositionX(self:getContentSize().width - 10)
			var_112_0:setPositionY(self:getContentSize().height - 5)
			var_112_0:setName("newIcon")
			self:addChild(var_112_0, var_0_17.REDDOT)
		end

		self:getChildByName("newIcon"):setVisible(true)
	elseif self:getChildByName("newIcon") then
		self:getChildByName("newIcon"):setVisible(false)
	end
end

function HorcruxArrayMemberModeStyleSprite.updateAlert(arg_113_0, arg_113_1)
	local var_113_0 = {
		{
			enum = var_0_18.NEW_ICON,
			updateFun = function(arg_114_0)
				arg_113_0:updateNewIcon(arg_114_0)
			end
		},
		{
			enum = var_0_18.RED_DOT_BAG,
			updateFun = function(arg_115_0)
				arg_113_0:updateRedDot(arg_115_0)
			end
		}
	}
	local var_113_1 = 1

	while var_113_0[var_113_1] do
		var_113_0[var_113_1].updateFun(false)

		var_113_1 = var_113_1 + 1
	end

	local var_113_2 = 1

	while var_113_0[var_113_2] do
		if var_0_21[var_113_0[var_113_2].enum](arg_113_1) then
			var_113_0[var_113_2].updateFun(true)

			break
		end

		var_113_2 = var_113_2 + 1
	end
end

function HorcruxArrayMemberModeStyleSprite:setUnkonw(arg_116_1, arg_116_2, arg_116_3, arg_116_4)
	arg_116_1 = arg_116_1 or 1
	arg_116_2 = arg_116_2 or 1
	arg_116_3 = arg_116_3 or 1
	arg_116_2 = 1

	ccui.Helper:seekWidgetByName(self, "grade"):setVisible(false)
	self:getChildByName("lvIcon"):setVisible(false)
	ccui.Helper:seekWidgetByName(self, "lock"):setVisible(false)
	self:getChildByName("fightingtag"):setVisible(false)
	self:getChildByName("raceIcon"):setVisible(false)
	self:getChildByName("lvLabel"):setVisible(false)

	if ccui.Helper:seekWidgetByName(self, "redDot") then
		ccui.Helper:seekWidgetByName(self, "redDot"):setVisible(false)
	end

	ccui.Helper:seekWidgetByName(self, "rarityIcon"):setVisible(false)
	self:getChildByName("careerIcon"):loadTexture(ATTRICONPATH[arg_116_1], var_0_0)
	self:loadTextures("public/rolebg/horcrux_rarity_" .. arg_116_2 .. ".png", "public/rolebg/horcrux_rarity_" .. arg_116_2 .. ".png", "public/rolebg/horcrux_rarity_" .. arg_116_2 .. ".png", var_0_0)
	global_load_star(self, arg_116_3, nil, "star_")

	if arg_116_4 then
		ccui.Helper:seekWidgetByName(self, "horcrux"):loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[item_data[arg_116_4].model].cute_Q .. ".png")

		local var_116_1 = (item_data[arg_116_4].image_offse_x or 0) * (self.scale or 1)
		local var_116_2 = (item_data[arg_116_4].image_offset_y or 0) * (self.scale or 1)
		local var_116_3 = cc.p(75, 15)

		ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionX(var_116_3.x + var_116_1)
		ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionY(var_116_3.y + var_116_2)
		self:getChildByName("careerIcon"):setVisible(false)
		require("controller.l2utils"):shaderGrayDark(ccui.Helper:seekWidgetByName(self, "horcrux"):getVirtualRenderer())
	else
		ccui.Helper:seekWidgetByName(self, "horcrux"):loadTexture("public/rolebg/unkonw_horcrux.png", var_0_0)
		ccui.Helper:seekWidgetByName(self, "horcrux"):setScale(1.2)
		ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionY(15)
	end
end

HorcruxArrayMemberMainStyleSprite = class("HorcruxArrayMemberMainStyleSprite", function()
	return HorcruxSprite.new()
end)

function HorcruxArrayMemberMainStyleSprite:init()
	self.horcruxPos = cc.p(25, 0)
	self.scale = 0.2

	self:loadTextures("public/rolebg/horcrux_bg.png", "public/rolebg/horcrux_bg.png", "public/rolebg/horcrux_bg.png", var_0_0)
	self:setAnchorPoint(cc.p(0, 0))

	self.horcruxPanel = ccui.Layout:create()

	self.horcruxPanel:setContentSize(cc.size(self:getContentSize().width - 6, self:getContentSize().height - 9))
	self.horcruxPanel:setAnchorPoint(cc.p(0, 0))
	self.horcruxPanel:setPosition(cc.p(3, 3))
	self.horcruxPanel:setClippingEnabled(true)
	self:addChild(self.horcruxPanel, var_0_17.ICON)

	local var_118_0 = ccui.Layout:create()

	var_118_0:setContentSize(self.horcruxPanel:getContentSize())
	var_118_0:setPosition(cc.p(self.horcruxPanel:getContentSize().width / 2, self.horcruxPanel:getContentSize().height / 2))
	var_118_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_118_0:setName("scale_layer")
	self.horcruxPanel:addChild(var_118_0)

	local var_118_1 = ccui.ImageView:create(SHOT_RARITY_CION[1], var_0_0)

	var_118_1:setAnchorPoint(cc.p(1, 1))
	var_118_1:setPosition(cc.p(self:getContentSize().width - 2, self:getContentSize().height - 2))
	var_118_1:setName("rarityIcon")
	var_118_1:setScale(0.38)
	var_118_1:setVisible(false)
	self:addChild(var_118_1, var_0_17.INFO)

	local var_118_2 = ccui.ImageView:create("GUI/image.png", var_0_0)

	var_118_2:setAnchorPoint(var_0_22)
	var_118_2:setPosition(self.horcruxPos)
	var_118_2:setScale(self.scale)
	var_118_2:setName("horcrux")
	var_118_0:addChild(var_118_2)

	local var_118_3 = ccui.ImageView:create("public/rolebg/horcrux_+5.png", var_0_0)

	var_118_3:setScale(0.6)
	var_118_3:setAnchorPoint(cc.p(0, 1))
	var_118_3:setPositionX(6)
	var_118_3:setPositionY(self:getContentSize().height - 6)
	var_118_3:setName("grade")
	self:addChild(var_118_3, var_0_17.INFO)

	for iter_118_0 = 1, 5 do
		local var_118_4 = ccui.ImageView:create("public/currency/horcrux_weapon_star.png", var_0_0)

		var_118_4:setAnchorPoint(cc.p(0.5, 0.5))
		var_118_4:setPosition(cc.p(60, 52))
		var_118_4:setName("star_" .. iter_118_0)
		self:addChild(var_118_4, var_0_17.INFO)
	end

	local var_118_6 = ccui.ImageView:create("public/rolebg/horcru_array_bg.png", var_0_0)

	var_118_6:setAnchorPoint(cc.p(0, 0))
	var_118_6:setPosition(cc.p(0, 0))
	var_118_6:setScaleX(self:getContentSize().width / var_118_6:getContentSize().width)
	var_118_6:setName("lvBg")
	var_118_6:setContentSize(cc.size(self:getContentSize().width, var_118_6:getContentSize().height))
	self.horcruxPanel:addChild(var_118_6, var_0_17.INFO)

	local var_118_7 = ccui.ImageView:create(CAREER_ICON.assassin_dark, var_0_0)

	var_118_7:setAnchorPoint(cc.p(1, 1))
	var_118_7:setPosition(cc.p(self:getContentSize().width + 2, self:getContentSize().height - 2))
	var_118_7:setScale(0.26)
	var_118_7:setName("careerIcon")
	self:addChild(var_118_7, var_0_17.INFO)

	local var_118_8 = cc.Label:createWithTTF("888", FONT_DES, 14)

	var_118_8:setColor(cc.c3b(255, 255, 255))
	var_118_8:setAnchorPoint(cc.p(1, 0.5))
	var_118_8:setPosition(cc.p(self:getContentSize().width, 10))
	var_118_8:setName("lvLabel")
	self:addChild(var_118_8, var_0_17.INFO)

	local var_118_9 = ccui.Layout:create()

	var_118_9:setContentSize(self.horcruxPanel:getContentSize())
	var_118_9:setAnchorPoint(cc.p(0.5, 0.5))
	var_118_9:setPosition(cc.p(self.horcruxPanel:getPositionX() + self.horcruxPanel:getContentSize().width / 2, self.horcruxPanel:getPositionY() + self.horcruxPanel:getContentSize().height / 2))
	var_118_9:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_118_9:setBackGroundColor(cc.c3b(0, 0, 0))
	var_118_9:setBackGroundColorOpacity(200)
	var_118_9:setVisible(false)
	var_118_9:setName("skillBg")
	self:addChild(var_118_9, var_0_17.BACKPANEL)

	local var_118_10 = cc.Label:createWithTTF("", FONT_NAME, 26)

	var_118_10:setAnchorPoint(cc.p(0, 0.5))
	var_118_10:setColor(cc.c3b(255, 150, 0))
	var_118_10:setPosition(cc.p(5, var_118_9:getContentSize().height - 13))
	var_118_10:setName("skillName")
	var_118_9:addChild(var_118_10)

	local var_118_11 = cc.Label:createWithTTF("", FONT_DES, 22)

	var_118_11:setAnchorPoint(cc.p(0, 1))
	var_118_11:setPosition(cc.p(5, var_118_9:getContentSize().height - 30))
	var_118_11:setMaxLineWidth(var_118_9:getContentSize().width - 40)
	var_118_11:setLineBreakWithoutSpace(true)
	var_118_11:setName("skillDes")
	var_118_9:addChild(var_118_11)

	local var_118_12 = ccui.ImageView:create("public/rolebg/1.png", var_0_0)

	var_118_12:setName("raceIcon")
	var_118_12:setScale(0.3)
	var_118_12:setPositionX(128)
	var_118_12:setPositionY(50)
	var_118_12:setVisible(false)
	self:addChild(var_118_12, var_0_17.RACE)

	local var_118_13 = ccui.ImageView:create("public/rolebg/horcrux_select_rarity_2.png", var_0_0)

	var_118_13:setAnchorPoint(cc.p(0, 0.5))
	var_118_13:setPosition(cc.p(0, self:getContentSize().height / 2))
	var_118_13:setName("rarityBg")
	var_118_13:setScaleY(0.85)
	self:addChild(var_118_13, var_0_17.RACE)
end

function HorcruxArrayMemberMainStyleSprite:showSkillPanel(arg_119_1)
	local var_119_0 = self:getChildByName("skillBg")

	if not arg_119_1 then
		var_119_0:setVisible(false)

		return
	end

	var_119_0:setVisible(true)
	var_119_0:getChildByName("skillName"):setString(total_skill_data[arg_119_1].name)
	var_119_0:getChildByName("skillDes"):setString(total_skill_data[arg_119_1].easy_description)
end

function HorcruxArrayMemberMainStyleSprite:hideSkillPanel()
	self:getChildByName("skillBg"):setVisible(false)
end

function HorcruxArrayMemberMainStyleSprite:updateSub(arg_121_1)
	local var_121_1 = (item_data[arg_121_1.itemid].image_offset_y or 0) * (self.scale or 1)

	ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionX(self.horcruxPos.x + (item_data[arg_121_1.itemid].image_offse_x or 0) * (self.scale or 1))
	ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionY(self.horcruxPos.y + var_121_1)

	local var_121_2 = self:getAttr(arg_121_1.itemid)

	ccui.Helper:seekWidgetByName(self, "rarityBg"):loadTexture("public/rolebg/horcrux_select_rarity_" .. horcrux_data[arg_121_1.itemid].rarity .. ".png", var_0_0)
	ccui.Helper:seekWidgetByName(self, "rarityIcon"):loadTexture(SHOT_RARITY_CION[horcrux_data[arg_121_1.itemid].rarity], var_0_0)
	ccui.Helper:seekWidgetByName(self, "horcrux"):loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[horcrux_data[arg_121_1.itemid].model].cute_Q .. ".png")

	local var_121_3 = arg_121_1.hclass

	ccui.Helper:seekWidgetByName(self, "grade"):loadTexture("public/rolebg/horcrux_+" .. arg_121_1.hclass .. ".png", var_0_0)
	ccui.Helper:seekWidgetByName(self, "grade"):setVisible(var_121_3 > 0)
	self:getChildByName("lvLabel"):setString("等级." .. arg_121_1.hlv)
	self:getChildByName("careerIcon"):loadTexture(CAREER_ICON[horcrux_data[arg_121_1.itemid].career .. "_" .. var_0_19(arg_121_1.itemid)], var_0_0)

	local var_121_4 = arg_121_1.star
	local var_121_5 = arg_121_1.star % 5
	local var_121_6 = "star_"

	for iter_121_0 = 1, 5 do
		local var_121_9 = self:getChildByName(var_121_6 .. iter_121_0)

		if var_121_9 then
			var_121_9:setVisible(var_121_4 >= 5 or iter_121_0 <= var_121_5)
			var_121_9:loadTexture(var_121_7, var_0_0)
		end
	end
end

function HorcruxArrayMemberMainStyleSprite:update(arg_122_1)
	self.entityid = arg_122_1

	local var_122_0 = playermodel.items[arg_122_1].itemid
	local var_122_1 = (item_data[var_122_0].image_offset_y or 0) * (self.scale or 1)

	ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionX(self.horcruxPos.x + (item_data[playermodel.items[arg_122_1].itemid].image_offse_x or 0) * (self.scale or 1))
	ccui.Helper:seekWidgetByName(self, "horcrux"):setPositionY(self.horcruxPos.y + var_122_1)

	local var_122_2 = self:getAttr(var_122_0)

	ccui.Helper:seekWidgetByName(self, "rarityBg"):loadTexture("public/rolebg/horcrux_select_rarity_" .. horcrux_data[var_122_0].rarity .. ".png", var_0_0)
	ccui.Helper:seekWidgetByName(self, "rarityIcon"):loadTexture(SHOT_RARITY_CION[horcrux_data[var_122_0].rarity], var_0_0)
	ccui.Helper:seekWidgetByName(self, "horcrux"):loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[horcrux_data[playermodel.items[arg_122_1].itemid].model].cute_Q .. ".png")

	local var_122_3 = horcrux_manager:getHorcruxHClass(arg_122_1)

	ccui.Helper:seekWidgetByName(self, "grade"):loadTexture("public/rolebg/horcrux_+" .. var_122_3 .. ".png", var_0_0)
	ccui.Helper:seekWidgetByName(self, "grade"):setVisible(var_122_3 > 0)
	self:getChildByName("lvLabel"):setString("等级." .. horcrux_manager:getHorcruxHLV(arg_122_1))
	self:getChildByName("careerIcon"):loadTexture(CAREER_ICON[horcrux_data[playermodel.items[arg_122_1].itemid].career .. "_" .. var_0_19(var_122_0)], var_0_0)

	local var_122_4 = horcrux_manager:getHorcruxStarLevel(arg_122_1)
	local var_122_5 = var_122_4
	local var_122_6 = var_122_4 % 5
	local var_122_7 = "star_"

	for iter_122_0 = 1, 5 do
		local var_122_10 = self:getChildByName(var_122_7 .. iter_122_0)

		if var_122_10 then
			var_122_10:setVisible(var_122_5 >= 5 or iter_122_0 <= var_122_6)
			var_122_10:loadTexture(var_122_8, var_0_0)
		end
	end

	self:updateRaceIcon(arg_122_1)
end

function HorcruxArrayMemberMainStyleSprite:imgScaleTo(arg_123_1, arg_123_2)
	ccui.Helper:seekWidgetByName(self.horcruxPanel, "horcrux"):runAction(cc.ScaleTo:create(arg_123_2, self.scale * arg_123_1, self.scale * arg_123_1))
end

function HorcruxSprite:createPressBar()
	self.pressBar = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("public/button/press_bar.png") or cc.Sprite:createWithSpriteFrameName("public/button/press_bar.png")))

	self.pressBar:setScale(0.4)
	self.pressBar:setAnchorPoint(cc.p(0.5, 0.5))
	self.pressBar:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
	self.pressBar:setPositionX(self:getContentSize().width / 2)
	self.pressBar:setPositionY(self:getContentSize().height / 2)
	self.pressBar:setReverseDirection(true)
	self:addChild(self.pressBar, var_0_17.PRESSBAR)
end

HorcruxEnemyArrayMemberFormationStyleSprite = class("HorcruxEnemyArrayMemberFormationStyleSprite", function()
	return HorcruxArrayMemberMainStyleSprite.new()
end)

function HorcruxEnemyArrayMemberFormationStyleSprite:update(arg_126_1)
	if not arg_126_1.horcrux then
		return
	end

	local var_126_0 = arg_126_1.horcrux.itemid

	self.itemid = arg_126_1.horcrux.itemid

	local var_126_1 = arg_126_1.horcrux.hclass
	local var_126_2 = arg_126_1.horcrux.hlv
	local var_126_3 = arg_126_1.horcrux.star or 2
	local var_126_4 = cc.p(75, 15)
	local var_126_7 = self:getAttr(var_126_0)

	ccui.Helper:seekWidgetByName(self, "rarityBg"):loadTexture("public/rolebg/horcrux_select_rarity_" .. horcrux_data[var_126_0].rarity .. ".png", var_0_0)
	self:getChildByName("careerIcon"):loadTexture(CAREER_ICON[horcrux_data[var_126_0].career .. "_" .. var_0_19(var_126_0)], var_0_0)
	ccui.Helper:seekWidgetByName(self, "rarityIcon"):loadTexture(SHOT_RARITY_CION[horcrux_data[var_126_0].rarity], var_0_0)
	ccui.Helper:seekWidgetByName(self, "horcrux"):loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[horcrux_data[var_126_0].model].cute_Q .. ".png")
	ccui.Helper:seekWidgetByName(self, "grade"):loadTexture("public/rolebg/horcrux_+" .. var_126_1 .. ".png", var_0_0)
	ccui.Helper:seekWidgetByName(self, "grade"):setVisible(var_126_1 > 0)
	self:getChildByName("lvLabel"):setString("等级." .. var_126_2)

	local var_126_8 = var_126_3
	local var_126_9 = var_126_3 % 5
	local var_126_10 = "star_"

	for iter_126_0 = 1, 5 do
		local var_126_13 = self:getChildByName(var_126_10 .. iter_126_0)

		if var_126_13 then
			var_126_13:setVisible(var_126_8 >= 5 or iter_126_0 <= var_126_9)
			var_126_13:loadTexture(var_126_11, var_0_0)
		end
	end

	self:updateRaceIconByItemid(var_126_0)
end
