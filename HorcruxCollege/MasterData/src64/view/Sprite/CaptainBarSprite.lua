local CaptainBarSprite = class("CaptainBarSprite", function()
	return cc.Node:create()
end)

function CaptainBarSprite:createHpBar(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = CaptainBarSprite.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)

	return var_2_0
end

local var_0_1 = cc.c3b(91, 11, 9)
local var_0_2 = {
	cc.c3b(255, 11, 8),
	cc.c3b(162, 0, 65),
	cc.c3b(205, 58, 6),
	cc.c3b(255, 108, 19),
	cc.c3b(255, 161, 32)
}
local var_0_3 = "fight/captain_blood.png"
local var_0_4 = "fight/captain_blood_frame.png"
local var_0_5 = "fight/captain_effect_add_blood.png"
local var_0_6 = "fight/captain_effect_reduce_blood.png"
local var_0_7 = "fonts/boss_blood_number.png"

function CaptainBarSprite:init(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	self.curHp = arg_3_1
	self.totalHp = arg_3_2
	self.hpCount = arg_3_3
	self.curhpCount = arg_3_3
	self.direction = arg_3_4
	self.barActions = {}
	self.running = false
	self.hp_count = cc.Label:createWithCharMap(var_0_7, 28, 27, 48)

	self.hp_count:setScale(0.5)
	self:addChild(self.hp_count, 5)

	self.bar1 = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create(var_0_3) or cc.Sprite:createWithSpriteFrameName(var_0_3)))

	self.bar1:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.bar1:setBarChangeRate(cc.p(1, 0))
	self:addChild(self.bar1, 3)

	self.bar2 = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create(var_0_6) or cc.Sprite:createWithSpriteFrameName(var_0_6)))

	self.bar2:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.bar2:setBarChangeRate(cc.p(1, 0))

	self.bar2.status = "reduce"

	self:addChild(self.bar2, 2)

	if config._DEBUG then
		self.bg = cc.Sprite:create(var_0_3) or cc.Sprite:createWithSpriteFrameName(var_0_3)
	end

	self.bg:setColor(var_0_1)
	self:addChild(self.bg, 1)

	if config._DEBUG then
		self.frame = cc.Sprite:create(var_0_4) or cc.Sprite:createWithSpriteFrameName(var_0_4)
	end

	self:addChild(self.frame, 4)

	if arg_3_4 == 1 then
		self.bar1:setMidpoint(cc.p(0, 0))
		self.bar2:setMidpoint(cc.p(0, 0))
		self.frame:setPosition(cc.p(0, 0))
		self.hp_count:setAnchorPoint(cc.p(1, 0.5))
		self.hp_count:setPosition(cc.p(self.bg:getContentSize().width / 2 - 20, 0))
	end

	self:setBoss(arg_3_5)
	self:updateHpBar(self.curhpCount)
	self:setTotalHp(arg_3_2)
	self:setCurHp(arg_3_1)
	self:createShieldBar()
end

function CaptainBarSprite:setBoss(arg_4_1)
	local var_4_0 = cc.Node:create()

	var_4_0:setPosition(cc.p(-self.frame:getContentSize().width / 2 - self.frame:getPositionX() - 40, 30))
	self:addChild(var_4_0, 5)

	local var_4_1

	if config._DEBUG then
		var_4_1 = cc.Sprite:create("public/rolebg/icon_bg.png") or cc.Sprite:createWithSpriteFrameName("public/rolebg/icon_bg.png")
	end

	local var_4_2 = cc.Sprite:create("role/wuji/" .. arg_4_1.headimg .. ".png")

	var_4_2:setPosition(cc.p(var_4_1:getContentSize().width / 2, var_4_1:getContentSize().height / 2))
	var_4_1:addChild(var_4_2, 1)
	var_4_1:setScale(0.4)
	var_4_0:addChild(var_4_1)

	local var_4_3

	if config._DEBUG then
		var_4_3 = cc.Sprite:create(CAREER_ICON[arg_4_1.careericon]) or cc.Sprite:createWithSpriteFrameName(CAREER_ICON[arg_4_1.careericon])
	end

	var_4_3:setPosition(cc.p(-40, -30))
	var_4_3:setScale(0.5)
	var_4_0:addChild(var_4_3, 3)

	local var_4_4

	if config._DEBUG then
		var_4_4 = cc.Sprite:create("fight/frame_boss_lv.png") or cc.Sprite:createWithSpriteFrameName("fight/frame_boss_lv.png")
	end

	var_4_4:setPosition(cc.p(0, -33))
	var_4_4:setScale(0.8)
	var_4_0:addChild(var_4_4, 2)

	local var_4_5 = cc.Label:createWithTTF(tostring(arg_4_1.lv), FONT_DES, 20)

	var_4_5:setColor(cc.c3b(255, 224, 54))
	var_4_5:setAnchorPoint(cc.p(0.5, 0.5))
	var_4_5:setPosition(cc.p(var_4_4:getContentSize().width / 2 + 15, var_4_4:getContentSize().height / 2))
	var_4_4:addChild(var_4_5)

	local var_4_6

	if config._DEBUG then
		var_4_6 = cc.Sprite:create("fight/img_lv_boss_blood.png") or cc.Sprite:createWithSpriteFrameName("fight/img_lv_boss_blood.png")
	end

	var_4_6:setPosition(cc.p(var_4_4:getContentSize().width / 2 - 20, var_4_4:getContentSize().height / 2))
	var_4_4:addChild(var_4_6)
end

function CaptainBarSprite:dequeueBarColor(arg_5_1)
	if arg_5_1 == self.hpcount then
		return var_0_2[#var_0_2]
	else
		return var_0_2[(arg_5_1 - 1) % #var_0_2 + 1]
	end
end

function CaptainBarSprite:updateHpBar(arg_6_1)
	local var_6_0 = arg_6_1 > 1 and self:dequeueBarColor(arg_6_1 - 1) or var_0_1

	self.bar1:getSprite():setColor((self:dequeueBarColor(arg_6_1)))
	self.bg:setColor(var_6_0)

	if arg_6_1 > 0 then
		self.bar1:setPercentage(100)
		self.bar2:setPercentage(100)
	end

	self.hp_count:setString(":" .. arg_6_1)
end

function CaptainBarSprite:updateSubHpBar(arg_7_1)
	if self.bar2.status == arg_7_1 then
		return
	end

	if arg_7_1 == "add" then
		if config._DEBUG then
			self.bar2:getSprite():setTexture(var_0_5)
		else
			self.bar2:getSprite():setSpriteFrame(var_0_5)
		end

		self.bar2.status = "add"
	else
		if config._DEBUG then
			self.bar2:getSprite():setTexture(var_0_6)
		else
			self.bar2:getSprite():setSpriteFrame(var_0_6)
		end

		self.bar2.status = "reduce"
	end
end

function CaptainBarSprite:getHpPercent()
	return 100 * (self.curHp + self.totalHp * (self.curhpCount - 1)) / self.totalHp
end

function CaptainBarSprite:setPercent(arg_9_1, arg_9_2)
	arg_9_1:setPercentage(arg_9_2)
end

function CaptainBarSprite:setCurHp(arg_10_1)
	self.curHp = arg_10_1

	self:setPercent(self.bar1, self.curHp * 100 / self.totalHp)
	self:setPercent(self.bar2, self.curHp * 100 / self.totalHp)
end

function CaptainBarSprite:resetCurHp(arg_11_1)
	if arg_11_1 == 0 then
		self.curHp = 0
	else
		self.curHp = arg_11_1 % self.totalHp

		if self.curHp == 0 then
			self.curHp = self.totalHp
		end
	end

	self.curhpCount = math.ceil(arg_11_1 / self.totalHp)

	self:updateHpBar(self.curhpCount)
	self:setPercent(self.bar1, self.curHp * 100 / self.totalHp)
	self:setPercent(self.bar2, self.curHp * 100 / self.totalHp)
end

function CaptainBarSprite:setTotalHp(arg_12_1)
	self.totalHp = arg_12_1

	self:setPercent(self.bar1, self.curHp * 100 / self.totalHp)
	self:setPercent(self.bar2, self.curHp * 100 / self.totalHp)
end

function CaptainBarSprite:setHpCount(arg_13_1)
	self.hpCount = arg_13_1
	self.curhpCount = arg_13_1

	self:updateHpBar(arg_13_1)
end

function CaptainBarSprite:resetBar()
	self.curHp = self.totalHp

	self:removeAllBarActions()

	for iter_14_0 = self.curhpCount, self.hpCount do
		self:pushInBarAction("all", "add", iter_14_0)
	end

	self.curhpCount = self.hpCount
end

function CaptainBarSprite:runBar(arg_15_1)
	if arg_15_1 == 0 then
		return
	end

	local var_15_0 = self.curHp + self.totalHp * (self.curhpCount - 1) + arg_15_1

	if self.curHp + self.totalHp * (self.curhpCount - 1) + arg_15_1 > self.totalHp * self.hpCount then
		var_15_0 = self.totalHp * self.hpCount
	end

	if var_15_0 < 0 then
		var_15_0 = 0
	end

	local var_15_1 = var_15_0 % self.totalHp

	if var_15_0 % self.totalHp == 0 and var_15_0 >= self.totalHp then
		var_15_1 = self.totalHp
	end

	local var_15_2 = math.ceil(var_15_0 / self.totalHp)

	if var_15_2 > self.curhpCount then
		for iter_15_0 = self.curhpCount, var_15_2 - 1 do
			self:pushInBarAction("all", "add", iter_15_0)
		end
	elseif var_15_2 < self.curhpCount then
		for iter_15_1 = self.curhpCount, var_15_2 + 1, -1 do
			self:pushInBarAction("all", "reduce", iter_15_1)
		end
	end

	self:pushInBarAction("normal", arg_15_1 > 0 and "add" or "reduce", var_15_1, var_15_2)

	self.curHp = var_15_1
	self.curhpCount = var_15_2
end

function CaptainBarSprite:pushInBarAction(...)
	table.insert(self.barActions, {
		...
	})

	if not self.running then
		self:dequeueNextAction()()
	end
end

function CaptainBarSprite:dequeueNextAction()
	local var_17_0 = table.remove(self.barActions, 1)

	if not var_17_0 then
		return function()
			self.running = false
		end
	end

	if var_17_0[1] == "all" then
		if var_17_0[2] == "add" then
			return function()
				self.running = true

				self.bar2:stopAllActions()
				self.bar1:stopAllActions()
				self.bar1:runAction(cc.ProgressTo:create(0.2, 100))
				self:updateSubHpBar("add")
				self.bar2:setPercentage(100)
				self.bar2:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
					if var_17_0[3] < self.hpCount then
						self:updateHpBar(var_17_0[3] + 1)
					end

					self:dequeueNextAction()()
				end)))
			end
		else
			return function()
				self.running = true

				self.bar2:stopAllActions()
				self.bar1:stopAllActions()
				self.bar1:setPercentage(0)
				self:updateSubHpBar("reduce")
				self.bar2:runAction(cc.Sequence:create(cc.ProgressTo:create(0.2, 0), cc.CallFunc:create(function()
					self.bar2:setPercentage(0)

					if var_17_0[3] > 1 then
						self:updateHpBar(var_17_0[3] - 1)
					else
						self.hp_count:setString(":0")
					end

					self:dequeueNextAction()()
				end)))
			end
		end
	elseif var_17_0[2] == "add" then
		return function()
			self.running = true

			self.bar2:stopAllActions()
			self.bar1:stopAllActions()
			self.bar1:runAction(cc.ProgressTo:create(0.1, var_17_0[3] * 100 / self.totalHp))
			self:updateSubHpBar("add")
			self.bar2:setPercentage(var_17_0[3] * 100 / self.totalHp)
			self:dequeueNextAction()()
		end
	else
		return function()
			self.running = true

			self.bar2:stopAllActions()
			self.bar1:stopAllActions()
			self:updateSubHpBar("reduce")
			self.bar1:setPercentage(var_17_0[3] * 100 / self.totalHp)
			self.bar2:runAction(cc.ProgressTo:create(0.1, var_17_0[3] * 100 / self.totalHp))

			if var_17_0[4] <= 0 then
				self.hp_count:setString(":0")
			end

			self:dequeueNextAction()()
		end
	end
end

function CaptainBarSprite:removeAllBarActions()
	self.barActions = {}
	self.running = false

	self.bar1:stopAllActions()
	self.bar2:stopAllActions()
end

local var_0_9 = "fight/captain_shield_bg.png"
local var_0_10 = "fight/captain_shield.png"

function CaptainBarSprite:createShieldBar()
	self.totalShield = 0
	self.curShield = 0

	if config._DEBUG then
		self.shield = cc.Sprite:create(var_0_9) or cc.Sprite:createWithSpriteFrameName(var_0_9)
	end

	self.shield:setPosition(cc.p(0, -self.bar2:getContentSize().height / 2))
	self:addChild(self.shield, 4)

	if config._DEBUG then
		self.shieldBar = cc.ProgressTimer:create(cc.Sprite:create(var_0_10)) or cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName(var_0_10))
	end

	self.shieldBar:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.shieldBar:setBarChangeRate(cc.p(1, 0))
	self.shieldBar:setMidpoint(cc.p(0, 0))
	self.shieldBar:setPosition(cc.p(self.shield:getContentSize().width / 2, self.shield:getContentSize().height / 2))
	self.shield:addChild(self.shieldBar)
	self.shieldBar:setPercentage(0)
	self.shield:setVisible(false)
end

function CaptainBarSprite:addShield(arg_27_1)
	self.totalShield = arg_27_1
	self.curShield = arg_27_1

	self.shieldBar:stopAllActions()
	self.shield:setVisible(true)
	self.shieldBar:setPercentage(100)
end

function CaptainBarSprite:reduceShield(arg_28_1, arg_28_2)
	self.curShield = self.curShield - arg_28_1

	if arg_28_2 then
		self.shieldBar:stopAllActions()
		self.shieldBar:runAction(cc.Sequence:create(cc.ProgressTo:create(0.1, self.curShield / self.totalShield * 100), cc.CallFunc:create(function()
			if self.curShield <= 0 then
				self.shield:setVisible(false)
			end
		end)))
	else
		self.shieldBar:stopAllActions()
		self.shieldBar:setPercentage(self.curShield / self.totalShield * 100)

		if self.curShield <= 0 then
			self.shield:setVisible(false)
		end
	end
end

return CaptainBarSprite
