local BarSprite = class("BarSprite", function()
	return cc.Node:create()
end)

function BarSprite:createHpBar(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = BarSprite.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)

	return var_2_0
end

function BarSprite:init(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	self.curHp = arg_3_1
	self.totalHp = arg_3_2
	self.hpCount = arg_3_3
	self.curhpCount = arg_3_3
	self.fileConf = arg_3_4
	self.direction = arg_3_5
	self.barActions = {}
	self.running = false
	self.hp_percent = cc.Label:createWithTTF("" .. global_trans_number(self.curHp), "fonts/new1.ttf", 20)

	self.hp_percent:enableOutline(cc.c4b(0, 0, 0, 255), 1)
	self:addChild(self.hp_percent, 4)

	self.bar2 = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create(arg_3_4.sub) or cc.Sprite:createWithSpriteFrameName(arg_3_4.sub)))

	self.bar2:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.bar2:setBarChangeRate(cc.p(1, 0))
	self:addChild(self.bar2, 2)

	if arg_3_5 == 1 then
		self.bar2:setMidpoint(cc.p(0, 0))
		self.bar2:setScaleX(-1)
		self.hp_percent:setAnchorPoint(cc.p(1, 0.5))
		self.hp_percent:setPosition(cc.p(41, 0))
	elseif arg_3_5 == -1 then
		self.bar2:setMidpoint(cc.p(0, 0))
		self.hp_percent:setAnchorPoint(cc.p(0, 0.5))
		self.hp_percent:setPosition(cc.p(-41, 0))
	end

	self:updateHpBar(self.curhpCount)
	self:setTotalHp(arg_3_2)
	self:setCurHp(arg_3_1)
	self:createShieldBar()
end

function BarSprite:dequeueFileIndex(arg_4_1)
	return (self.hpCount - arg_4_1) % #self.fileConf + 1
end

function BarSprite:updateHpBar(arg_5_1)
	local var_5_0 = self.fileConf[self:dequeueFileIndex(arg_5_1)]

	if not var_5_0 then
		return
	end

	local var_5_1

	if arg_5_1 > 1 then
		var_5_1 = self.fileConf[self:dequeueFileIndex(arg_5_1 - 1)]
	end

	if not self.bar1Top then
		self.bar1Top = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create(var_5_0.bar) or cc.Sprite:createWithSpriteFrameName(var_5_0.bar)))

		self.bar1Top:setType(cc.PROGRESS_TIMER_TYPE_BAR)
		self.bar1Top:setBarChangeRate(cc.p(1, 0))
		self.bar1Top:setMidpoint(cc.p(0, 0))
		self.bar1Top:setScaleX(-1 * self.direction)
		self:addChild(self.bar1Top, 3)
	elseif config._DEBUG then
		self.bar1Top:getSprite():setTexture(var_5_0.bar)
	else
		self.bar1Top:getSprite():setSpriteFrame(var_5_0.bar)
	end

	if var_5_1 then
		if not self.bar1Bottom then
			if config._DEBUG then
				self.bar1Bottom = cc.Sprite:create(var_5_1.bar) or cc.Sprite:createWithSpriteFrameName(var_5_1.bar)
			end

			self.bar1Bottom:setScaleX(-1 * self.direction)
			self:addChild(self.bar1Bottom, 1)
		elseif config._DEBUG then
			self.bar1Bottom:setTexture(var_5_1.bar)
		else
			self.bar1Bottom:setSpriteFrame(var_5_1.bar)
		end

		self.bar1Bottom:setVisible(true)
	elseif self.bar1Bottom then
		self.bar1Bottom:setVisible(false)
	end
end

function BarSprite:setPercent(arg_6_1, arg_6_2)
	arg_6_1:setPercentage(arg_6_2)
end

function BarSprite:setCurHp(arg_7_1)
	self.curHp = arg_7_1

	self:setPercent(self.bar1Top, self.curHp * 100 / self.totalHp)
	self:setPercent(self.bar2, self.curHp * 100 / self.totalHp)
	self.hp_percent:setString("" .. global_trans_number(self.curHp))
end

function BarSprite:resetCurHp(arg_8_1)
	if arg_8_1 == 0 then
		self.curHp = arg_8_1
	else
		self.curHp = arg_8_1 % self.totalHp

		if self.curHp == 0 then
			self.curHp = self.totalHp
		end
	end

	self:setPercent(self.bar1Top, self.curHp * 100 / self.totalHp)
	self:setPercent(self.bar2, self.curHp * 100 / self.totalHp)
	self.hp_percent:setString("" .. global_trans_number(self.curHp))
end

function BarSprite:setTotalHp(arg_9_1)
	self.totalHp = arg_9_1

	self:setPercent(self.bar1Top, self.curHp * 100 / self.totalHp)
	self:setPercent(self.bar2, self.curHp * 100 / self.totalHp)
	self.hp_percent:setString("" .. global_trans_number(self.curHp))
end

function BarSprite:setHpCount(arg_10_1)
	self.hpCount = arg_10_1
	self.curhpCount = arg_10_1

	self:updateHpBar(arg_10_1)
end

function BarSprite:resetBar()
	self.curHp = self.totalHp

	self:removeAllBarActions()

	for iter_11_0 = self.curhpCount, self.hpCount do
		self:pushInBarAction("all", "add", iter_11_0)
	end

	self.curhpCount = self.hpCount
end

function BarSprite:runBar(arg_12_1)
	if arg_12_1 == 0 then
		return
	end

	local var_12_0 = self.curHp + self.totalHp * (self.curhpCount - 1) + arg_12_1

	if self.curHp + self.totalHp * (self.curhpCount - 1) + arg_12_1 > self.totalHp * self.hpCount then
		var_12_0 = self.totalHp * self.hpCount
	end

	if var_12_0 < 0 then
		var_12_0 = 0
	end

	local var_12_1 = var_12_0 % self.totalHp

	if var_12_0 % self.totalHp == 0 and var_12_0 >= self.totalHp then
		var_12_1 = self.totalHp
	end

	local var_12_2 = math.ceil(var_12_0 / self.totalHp)

	if var_12_2 <= 0 then
		var_12_2 = 1
	end

	if var_12_2 > self.curhpCount then
		for iter_12_0 = self.curhpCount, var_12_2 - 1 do
			self:pushInBarAction("all", "add", iter_12_0)
		end
	elseif var_12_2 < self.curhpCount then
		for iter_12_1 = self.curhpCount, var_12_2 + 1, -1 do
			self:pushInBarAction("all", "minus", iter_12_1)
		end
	end

	self:pushInBarAction("normal", var_12_1)

	self.curHp = var_12_1
	self.curhpCount = self.curhpCount
end

function BarSprite:pushInBarAction(...)
	table.insert(self.barActions, {
		...
	})

	if not self.running then
		self:dequeueNextAction()()
	end
end

function BarSprite:dequeueNextAction()
	local var_14_0 = table.remove(self.barActions, 1)

	if not var_14_0 then
		return function()
			self.running = false
		end
	end

	if var_14_0[1] == "all" then
		if var_14_0[2] == "add" then
			return function()
				self.running = true

				self.bar2:stopAllActions()
				self.bar1Top:stopAllActions()
				self.bar1Top:runAction(cc.ProgressTo:create(0.1, 100))
				self.bar2:setOpacity(255)
				self.bar2:runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.CallFunc:create(function()
					self.bar2:setPercentage(100)

					if var_14_0[3] < self.hpCount then
						self:updateHpBar(var_14_0[3] + 1)
						self.hp_percent:setString("0")
					end

					self:dequeueNextAction()()
				end)))
				self.hp_percent:setString("" .. global_trans_number(self.totalHp))
			end
		else
			return function()
				self.running = true

				self.bar2:stopAllActions()
				self.bar1Top:stopAllActions()
				self.bar1Top:runAction(cc.ProgressTo:create(0.1, 0))
				self.bar2:setOpacity(255)
				self.bar2:runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.CallFunc:create(function()
					self.bar2:setPercentage(0)

					if var_14_0[3] > 1 then
						self:updateHpBar(var_14_0[3] - 1)
						self.hp_percent:setString("" .. global_trans_number(self.totalHp))
					end

					self:dequeueNextAction()()
				end)))
				self.hp_percent:setString("0")
			end
		end
	else
		return function()
			self.running = true

			self.bar2:stopAllActions()
			self.bar1Top:stopAllActions()
			self.bar1Top:runAction(cc.ProgressTo:create(0.1, var_14_0[2] * 100 / self.totalHp))
			self.bar2:setOpacity(255)
			self.bar2:runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.CallFunc:create(function()
				self.bar2:setPercentage(var_14_0[2] * 100 / self.totalHp)
			end)))
			self.hp_percent:setString("" .. global_trans_number(var_14_0[2]))
			self:dequeueNextAction()()
		end
	end
end

function BarSprite:removeAllBarActions()
	self.barActions = {}
	self.running = false

	self.bar1Top:stopAllActions()
	self.bar2:stopAllActions()
end

local var_0_1 = "fight/shield_bg.png"
local var_0_2 = "fight/shield.png"

function BarSprite:createShieldBar()
	self.totalShield = 0
	self.curShield = 0

	if config._DEBUG then
		self.shield = cc.Sprite:create(var_0_1) or cc.Sprite:createWithSpriteFrameName(var_0_1)
	end

	self.shield:setPosition(cc.p(0, -self.bar2:getContentSize().height / 2))
	self.shield:setScaleX(-1 * self.direction)
	self:addChild(self.shield, 4)

	if config._DEBUG then
		self.shieldBar = cc.ProgressTimer:create(cc.Sprite:create(var_0_2)) or cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName(var_0_2))
	end

	self.shieldBar:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.shieldBar:setBarChangeRate(cc.p(1, 0))
	self.shieldBar:setMidpoint(cc.p(0, 0))
	self.shieldBar:setPosition(cc.p(self.shield:getContentSize().width / 2, self.shield:getContentSize().height / 2))
	self.shield:addChild(self.shieldBar)
	self.shieldBar:setPercentage(0)
	self.shield:setVisible(false)
end

function BarSprite:addShield(arg_24_1)
	self.totalShield = arg_24_1
	self.curShield = arg_24_1

	self.shieldBar:stopAllActions()
	self.shield:setVisible(true)
	self.shieldBar:setPercentage(100)
end

function BarSprite:reduceShield(arg_25_1, arg_25_2)
	self.curShield = self.curShield - arg_25_1

	if arg_25_2 then
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

return BarSprite
