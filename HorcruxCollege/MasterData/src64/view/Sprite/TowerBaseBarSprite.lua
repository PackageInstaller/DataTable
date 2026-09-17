local BossBarSprite = require("view.Sprite.BossBarSprite")
local TowerBaseBarSprite = class("TowerBaseBarSprite", function()
	return BossBarSprite:createParent()
end)

function TowerBaseBarSprite:createHpBar(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = TowerBaseBarSprite.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)

	return var_2_0
end

local var_0_2 = {
	enemy = "fight/enemybase_blood1.png",
	player = "fight/playerbase_blood1.png"
}
local var_0_3 = {
	enemy = "fight/enemybase_blood_bg.png",
	player = "fight/playerbase_blood_bg.png"
}
local var_0_4 = {
	enemy = "fight/enemybase_blood1.png",
	player = "fight/playerbase_blood1.png"
}
local var_0_6 = {
	enemy = "fight/enemybase_head_bg.png",
	player = "fight/playerbase_head_bg.png"
}
local var_0_7 = "fonts/boss_blood_number.png"

function TowerBaseBarSprite:init(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	self.curHp = arg_3_1
	self.totalHp = arg_3_2
	self.hpCount = arg_3_3
	self.curhpCount = arg_3_3
	self.direction = arg_3_4
	self.charactertype = arg_3_5.charactertype
	self.barActions = {}
	self.running = false
	self.hp_percent = cc.Label:createWithTTF(string.format("%d%%", math.floor(self:getHpPercent())), FONT_W5, 20)

	self:addChild(self.hp_percent, 5)

	self.hp_count = cc.Label:createWithCharMap(var_0_7, 28, 27, 48)

	self.hp_count:setVisible(false)
	self.hp_count:setScale(0.8)
	self:addChild(self.hp_count, 5)

	self.bar1 = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create(var_0_2[self.charactertype]) or cc.Sprite:createWithSpriteFrameName(var_0_2[self.charactertype])))

	self.bar1:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.bar1:setBarChangeRate(cc.p(1, 0))
	self:addChild(self.bar1, 3)

	self.bar2 = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create(var_0_4[self.charactertype]) or cc.Sprite:createWithSpriteFrameName(var_0_4[self.charactertype])))

	self.bar2:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.bar2:setBarChangeRate(cc.p(1, 0))

	self.bar2.status = "reduce"

	self:addChild(self.bar2, 2)

	if config._DEBUG then
		self.bg = cc.Sprite:create(var_0_3[self.charactertype]) or cc.Sprite:createWithSpriteFrameName(var_0_3[self.charactertype])
	end

	self:addChild(self.bg, 1)

	local var_3_0 = cc.Label:createWithTTF(L_EXPEDITION_SELECT[2], FONT_NAME, 30)

	var_3_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_0:setPosition(320, self.bar1:getContentSize().height / 2)
	var_3_0:setVisible(self.charactertype == "player" and true or false)
	self:addChild(var_3_0)

	if self.charactertype == "player" then
		self.bar1:setMidpoint(cc.p(0, 0))
		self.bar1:setAnchorPoint(cc.p(0, 0))
		self.bar2:setMidpoint(cc.p(0, 0))
		self.bar2:setAnchorPoint(cc.p(0, 0))
		self.bg:setAnchorPoint(cc.p(0, 0))
		self.hp_percent:setAnchorPoint(cc.p(0, 0.5))
		self.hp_percent:setPosition(cc.p(5, self.bar1:getContentSize().height / 2))
	else
		self.bar1:setMidpoint(cc.p(1, 0))
		self.bar1:setAnchorPoint(cc.p(1, 0))
		self.bar2:setMidpoint(cc.p(1, 0))
		self.bar2:setAnchorPoint(cc.p(1, 0))
		self.bg:setAnchorPoint(cc.p(1, 0))
		self.hp_percent:setAnchorPoint(cc.p(1, 0.5))
		self.hp_percent:setPosition(cc.p(-5, self.bar1:getContentSize().height / 2))
	end

	self:setBoss(arg_3_5)
	self:updateHpBar(self.curhpCount)
	self:setTotalHp(arg_3_2)
	self:setCurHp(arg_3_1)
	self:createShieldBar()
end

function TowerBaseBarSprite:setBoss(arg_4_1)
	local var_4_0

	if config._DEBUG then
		var_4_0 = cc.Sprite:create(var_0_6[self.charactertype]) or cc.Sprite:createWithSpriteFrameName(var_0_6[self.charactertype])
	end

	self:addChild(var_4_0, 6)

	local var_4_1 = ccui.Layout:create()

	var_4_1:setContentSize(var_4_0:getContentSize())
	var_4_1:setClippingEnabled(true)
	var_4_0:addChild(var_4_1)

	local var_4_2 = cc.Sprite:create("role/wuji/" .. arg_4_1.headimg .. ".png")

	var_4_2:setScale(0.3)
	var_4_1:addChild(var_4_2)

	local var_4_3

	if config._DEBUG then
		var_4_3 = cc.Sprite:create(CAREER_ICON[arg_4_1.careericon]) or cc.Sprite:createWithSpriteFrameName(CAREER_ICON[arg_4_1.careericon])
	end

	var_4_3:setScale(0.32)
	var_4_0:addChild(var_4_3, 3)

	local var_4_4 = cc.Label:createWithTTF(L_ITEMPANEL_SORT_STR.level2 .. tostring(arg_4_1.lv), FONT_W5, 16)

	var_4_0:addChild(var_4_4)

	if self.charactertype == "player" then
		var_4_0:setAnchorPoint(cc.p(0, 1))
		var_4_0:setPosition(0, 0)
		var_4_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_4_2:setPosition(cc.p((var_4_0:getContentSize().width - 30) / 2, var_4_0:getContentSize().height / 2))
		var_4_3:setAnchorPoint(cc.p(0, 1))
		var_4_3:setPosition(0, -4)
		var_4_4:setAnchorPoint(cc.p(0, 1))
		var_4_4:setPosition(cc.p(var_4_3:getBoundingBox().width, var_4_3:getPositionY()))
	else
		var_4_0:setAnchorPoint(cc.p(1, 1))
		var_4_0:setPosition(0, 0)
		var_4_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_4_2:setPosition(cc.p(var_4_0:getContentSize().width - (var_4_0:getContentSize().width - 30) / 2, var_4_0:getContentSize().height / 2))
		var_4_3:setAnchorPoint(cc.p(1, 1))
		var_4_3:setPosition(var_4_0:getContentSize().width, -4)
		var_4_4:setAnchorPoint(cc.p(1, 1))
		var_4_4:setPosition(cc.p(var_4_3:getPositionX() - var_4_3:getBoundingBox().width, var_4_3:getPositionY()))
	end
end

function TowerBaseBarSprite:updateHpBar(arg_5_1)
	if arg_5_1 > 0 then
		self.bar1:setPercentage(100)
		self.bar2:setPercentage(100)
	end

	self.hp_count:setString(":" .. arg_5_1)
end

function TowerBaseBarSprite:dequeueBarColor(arg_6_1)
	return var_0_2[self.charactertype]
end

function TowerBaseBarSprite:setCurHp(arg_7_1)
	self.curHp = arg_7_1

	self:setPercent(self.bar1, self.curHp * 100 / self.totalHp)
	self:setPercent(self.bar2, self.curHp * 100 / self.totalHp)
	self.hp_percent:setString(string.format("%d%%", math.floor(self:getHpPercent())))
end

local var_0_10 = {
	enemy = "fight/boss_shield_bg.png",
	player = "fight/boss_shield_bg.png"
}
local var_0_11 = {
	enemy = "fight/boss_shield.png",
	player = "fight/boss_shield.png"
}

function TowerBaseBarSprite:createShieldBar()
	self.totalShield = 0
	self.curShield = 0

	if config._DEBUG then
		self.shield = cc.Sprite:create(var_0_10[self.charactertype]) or cc.Sprite:createWithSpriteFrameName(var_0_10[self.charactertype])
	end

	self.shield:setPosition(cc.p(-2, 4))
	self:addChild(self.shield, 4)

	if config._DEBUG then
		self.shieldBar = cc.ProgressTimer:create(cc.Sprite:create(var_0_11[self.charactertype])) or cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName(var_0_11[self.charactertype]))
	end

	self.shieldBar:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.shieldBar:setBarChangeRate(cc.p(1, 0))
	self.shieldBar:setMidpoint(cc.p(0, 0))
	self.shieldBar:setPosition(cc.p(self.shield:getContentSize().width / 2, self.shield:getContentSize().height / 2))
	self.shield:addChild(self.shieldBar)
	self.shieldBar:setPercentage(0)
	self.shield:setVisible(false)
end

return TowerBaseBarSprite
