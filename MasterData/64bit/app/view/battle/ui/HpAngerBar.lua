local HpAngerBar = class("HpAngerBar", function()
	return cc.Node:create()
end)
local BattlePath = require("app.view.battle.BattlePath")
local BattleConst = require("app.view.battle.const.BattleConst")
local BattleAttr = require("battle.const.BattleAttr")
local SpineBase = require("app.view.common.SpineBase")
local var_0_5 = g.core.const.ConstMgr.QUALITY_TYPE
local HpBuffIcon = require("app.view.battle.ui.HpBuffIcon")
local HpMarkIcon = require("app.view.battle.ui.HpMarkIcon")
local var_0_8 = {
	buffIcon = 17,
	urAnger = -17,
	anger = -10,
	energy = -11,
	hp = -4,
	urMark = -4,
	mark = -2,
	shield = 3
}
local var_0_9 = 80
local var_0_10 = 82
local var_0_11 = -41
local var_0_13 = 25

function HpAngerBar:ctor(arg_2_1, arg_2_2)
	self._anger = 0
	self._energy = 0

	for iter_2_0 = 1, #arg_2_1.attrs do
		if arg_2_1.attrs[iter_2_0].type == BattleAttr.INITIAL_HP then
			self._maxHp = arg_2_1.attrs[iter_2_0].value
		elseif arg_2_1.attrs[iter_2_0].type == BattleAttr.INITIAL_ANGER then
			self._anger = arg_2_1.attrs[iter_2_0].value
		elseif arg_2_1.attrs[iter_2_0].type == BattleAttr.BATTLE_HP then
			self._hp = arg_2_1.attrs[iter_2_0].value
		end
	end

	self._hp = self._hp or self._maxHp
	self._angerSp = nil
	self._shield = 0
	self._angerSpShow = false
	self._name = arg_2_1.name
	self._tempShield = 0

	local var_2_0 = ((arg_2_1.isMonster or nil) and (g.core.config.monster_info or g.core.config.knight_info)).get(arg_2_1.id)

	self._quality = var_2_0.quality
	self._hpRoot = display.newNode()

	self:addChild(self._hpRoot)
	self._hpRoot:setPosition(var_0_11, var_0_8.hp)

	self._bgHp = display.newSprite("battle/common/bg_xuetiaodi.png", {
		scale9 = true,
		capInsets = cc.rect(5, 5, 2, 2)
	})

	self._bgHp:setAnchorPoint(0, 0.5)
	self._bgHp:setPosition(0, 0)
	self._bgHp:setContentSize(cc.size(var_0_10, 8))
	self._hpRoot:addChild(self._bgHp)
	self._bgHp:setCascadeColorEnabled(true)
	self._bgHp:setCascadeOpacityEnabled(true)

	local var_2_1 = display.newSprite("battle/common/pic_xuetiao_2.png", {
		scale9 = true,
		capInsets = cc.rect(3, 3, 2, 2)
	})

	var_2_1:setContentSize(cc.size(var_0_9, 6))
	var_2_1:setAnchorPoint(0, 0.5)
	var_2_1:setPosition(1, 0)
	var_2_1:setVisible(false)
	self._hpRoot:addChild(var_2_1)

	self._hpBgBar = var_2_1

	local var_2_2 = display.newSprite("battle/common/pic_xuetiao.png", {
		scale9 = true,
		capInsets = cc.rect(3, 3, 2, 2)
	})

	var_2_2:setContentSize(cc.size(var_0_9, 6))
	var_2_2:setAnchorPoint(0, 0.5)
	var_2_2:setPosition(1, 0)
	self._hpRoot:addChild(var_2_2)

	self._hpBar = var_2_2
	self._shieldRoot = display.newNode()

	self:addChild(self._shieldRoot)
	self._shieldRoot:setPosition(var_0_11, var_0_8.shield)

	self._bgShield = display.newSprite("battle/common/bg_xuetiaodi.png", {
		scale9 = true,
		capInsets = cc.rect(5, 5, 2, 2)
	})

	self._bgShield:setAnchorPoint(0, 0.5)
	self._bgShield:setPosition(0, 0)
	self._bgShield:setContentSize(cc.size(var_0_10, 6))
	self._bgShield:setVisible(false)
	self._shieldRoot:addChild(self._bgShield)
	self._bgShield:setCascadeColorEnabled(true)
	self._bgShield:setCascadeOpacityEnabled(true)

	local var_2_3 = display.newSprite("battle/common/pic_hudun.png", {
		scale9 = true,
		capInsets = cc.rect(3, 3, 2, 2)
	})

	var_2_3:setContentSize(cc.size(0, 6))
	var_2_3:setAnchorPoint(0, 0.5)
	var_2_3:setScaleY(0.5)
	var_2_3:setPosition(1, 0)
	self._shieldRoot:addChild(var_2_3)

	self._shieldBar = var_2_3

	local var_2_4 = display.newSprite("battle/common/pic_linshihudun.png", {
		scale9 = true,
		capInsets = cc.rect(3, 3, 2, 2)
	})

	var_2_4:setContentSize(cc.size(0, 6))
	var_2_4:setAnchorPoint(0, 0.5)
	var_2_4:setScaleY(0.5)
	var_2_4:setOpacity(127)
	var_2_4:setPosition(1, 0)
	self._shieldRoot:addChild(var_2_4)

	self._tempShieldBar = var_2_4

	local var_2_5 = false
	local var_2_6
	local var_2_7 = arg_2_2:getKnightData(arg_2_1.memberId)

	if var_2_7 and var_2_7.energySkillCfg then
		var_2_5 = true

		if self._quality == var_0_5.UR then
			self._energy = var_2_7.baseInfo.INITIAL_ENERGY
			var_2_6 = "battle/common/pic_ur_nengliang.png"
		elseif self._quality == var_0_5.MR then
			self._energy = var_2_7.baseInfo.INITIAL_THRESH
			var_2_6 = "battle/common/pic_mr_nengliang.png"
		end
	end

	self._energyRoot = display.newNode()

	self:addChild(self._energyRoot)
	self._energyRoot:setPosition(var_0_11, var_0_8.energy)
	self._energyRoot:setVisible(var_2_5)

	self._bgEnergy = display.newSprite("battle/common/bg_xuetiaodi.png", {
		scale9 = true,
		capInsets = cc.rect(5, 5, 2, 2)
	})

	self._bgEnergy:setAnchorPoint(0, 0.5)
	self._bgEnergy:setPosition(0, 0)
	self._bgEnergy:setContentSize(cc.size(var_0_10, 6))
	self._bgEnergy:setVisible(true)
	self._energyRoot:addChild(self._bgEnergy)
	self._bgEnergy:setCascadeColorEnabled(true)
	self._bgEnergy:setCascadeOpacityEnabled(true)

	local var_2_8 = display.newSprite(var_2_6)

	var_2_8:setContentSize(cc.size(0, 5))
	var_2_8:setAnchorPoint(0, 0.5)
	var_2_8:setPosition(2, 0)
	self._energyRoot:addChild(var_2_8)

	self._energyBar = var_2_8

	local var_2_9

	if var_2_5 then
		var_2_9 = var_0_8.urAnger or var_0_8.anger
	end

	self._angerRoot = display.newNode()

	self:addChild(self._angerRoot)
	self._angerRoot:setPosition(-40, var_2_9)

	self._angers = {}
	self._angersEff = {}
	self._markDict = {}
	self._markRoot = display.newNode()

	self:addChild(self._markRoot)
	self._markRoot:setPosition(var_0_11, (var_2_5 or nil) and (var_0_8.urMark or var_0_8.mark))

	local var_2_10 = ccui.Text:create(self._name, BattleConst.FONT, 18)

	var_2_10:setTextColor(g.core.common.Color.getQualityColor(var_2_0.quality, true))
	var_2_10:enableOutline(g.core.common.Color.qualityOutlineEx[var_2_0.quality], 2)
	var_2_10:setPosition(0, 20)
	var_2_10:setVisible(false)
	self:addChild(var_2_10)

	if BattleConst.DEBUG then
		self._hpLabel = ccui.Text:create("", BattleConst.FONT, 20)

		self._hpLabel:setAnchorPoint(0, 0.5)
		self._hpLabel:setPosition(55, 5)
		self._hpLabel:setTextColor(cc.c3b(234, 234, 1))
		self._hpLabel:enableOutline(cc.c4b(0, 0, 0, 255))
		self._hpLabel:setVisible(false)
		self:addChild(self._hpLabel)
	end

	self._buffMarkIcons = {}

	for iter_2_1 = 1, BattleConst.MAX_BUFF_ICON_NUM do
		local var_2_11 = HpBuffIcon.new()

		var_2_11:setAnchorPoint(0.5, 0.5)
		var_2_11:setPosition(50 - iter_2_1 * 20, var_0_8.buffIcon)
		var_2_11:setVisible(false)
		self:addChild(var_2_11)
		table.insert(self._buffMarkIcons, var_2_11)
	end

	self:updateHp(self._hp, true)
	self:updateAnger(self._anger)
	self:updateEnergy(self._energy)
	self:setCascadeColorEnabled(true)
	self:setCascadeOpacityEnabled(true)
end

function HpAngerBar:_onSpineEvent(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1.type == BattleConst.SPINE_EVENT.COMPLETE then
		-- block empty
	end
end

function HpAngerBar:getMaxBuffRoundByBuffId(arg_4_1)
	return
end

function HpAngerBar:updateBuffIcons(arg_5_1)
	for iter_5_0 = 1, BattleConst.MAX_BUFF_ICON_NUM do
		self._buffMarkIcons[iter_5_0]:setVisible(false)
	end

	for iter_5_1 = #arg_5_1, 1, -1 do
		if 0 >= BattleConst.MAX_BUFF_ICON_NUM then
			break
		end

		local var_5_0

		if arg_5_1[iter_5_1] then
			self._buffMarkIcons[BattleConst.MAX_BUFF_ICON_NUM - 0]:updateView(arg_5_1[iter_5_1])
			self._buffMarkIcons[BattleConst.MAX_BUFF_ICON_NUM - 0]:setVisible(true)

			var_5_0 = 0 + 1
		end
	end

	if self._isBoss then
		self._battleLayer:updateBossBuffIcons(arg_5_1)
	end
end

function HpAngerBar:addShield()
	return
end

function HpAngerBar:addTempShield(arg_7_1)
	self._tempShield = self._tempShield + arg_7_1

	self:updateTempShield(self._tempShield)
end

function HpAngerBar:updateTempShield(arg_8_1)
	local var_8_0 = arg_8_1 / self._maxHp

	var_8_0 = arg_8_1 / self._maxHp > 1 and 1 or var_8_0

	self._tempShieldBar:setContentSize(cc.size(var_0_9 * var_8_0, 6))
end

function HpAngerBar:addAngerSpine()
	if #self._angers > 0 then
		return
	end

	self._angerBg = display.newSprite("battle/common/bg_xuetiaodi.png", {
		scale9 = true,
		capInsets = cc.rect(3, 3, 2, 2)
	})

	self._angerBg:setAnchorPoint(0, 0.5)
	self._angerBg:setPosition(0, 0)
	self._angerBg:setContentSize(cc.size(75, 6))
	self._angerRoot:addChild(self._angerBg)
	self._angerBg:setCascadeColorEnabled(true)
	self._angerBg:setCascadeOpacityEnabled(true)

	for iter_9_0 = 1, 4 do
		local var_9_0 = display.newSprite((BattlePath:getAngerImgByQuality(0)))

		var_9_0:setAnchorPoint(0, 0.5)
		var_9_0:setPosition((iter_9_0 - 1) * 19, 0)
		var_9_0:setCascadeColorEnabled(true)
		var_9_0:setCascadeOpacityEnabled(true)
		self._angerRoot:addChild(var_9_0)

		local var_9_1 = display.newSprite((BattlePath:getAngerImgByQuality(self._quality)))

		var_9_1:setAnchorPoint(0, 0.5)
		var_9_1:setPosition(0, 3)
		var_9_1:setCascadeColorEnabled(true)
		var_9_1:setCascadeOpacityEnabled(true)
		var_9_0:addChild(var_9_1)
		var_9_0:setScale(0.5)

		self._angers[#self._angers + 1] = {
			img = var_9_1,
			bg = var_9_0
		}

		local var_9_2 = {
			isLoop = true
		}

		var_9_2.resId = "eff_ui_battle_anger"
		var_9_2.path = g.core.common.Path:getEffSpine("eff_ui_battle_anger")
		var_9_2.anim = "play_" .. self._quality + 1

		local var_9_3 = SpineBase.new(var_9_2)

		var_9_3:setAnchorPoint(0, 0.5)
		var_9_3:setPosition(14, 4)
		var_9_0:addChild(var_9_3)

		self._angersEff[#self._angersEff + 1] = {
			eff = var_9_3
		}
	end
end

function HpAngerBar:updateAnger(arg_10_1)
	if arg_10_1 >= 0 then
		self:addAngerSpine()
	end

	arg_10_1 = math.max(arg_10_1, 0)

	for iter_10_0 = 1, #self._angers do
		self._angers[iter_10_0].img:setVisible(iter_10_0 <= arg_10_1)
	end

	for iter_10_1 = 1, #self._angersEff do
		self._angersEff[iter_10_1].eff:setVisible(iter_10_1 <= arg_10_1 - 4)
	end

	for iter_10_2 = self._anger + 1, math.min(self._anger + math.max(arg_10_1 - self._anger, 0), 4) do
		if self._angers[iter_10_2].img then
			self._angers[iter_10_2].img:setVisible(iter_10_2 <= arg_10_1)
		end
	end

	self._anger = arg_10_1

	if self._isBoss then
		self._battleLayer:updateBossAnger(self._anger)
	end
end

function HpAngerBar:updateEnergy(arg_11_1)
	local var_11_0 = arg_11_1 / 100

	var_11_0 = arg_11_1 / 100 > 1 and 1 or var_11_0
	self._energy = arg_11_1

	self._energyBar:setContentSize(cc.size(var_0_9 * var_11_0, 5))

	if var_11_0 >= 1 then
		if not self._energyEffect then
			local var_11_1 = {
				isLoop = true
			}

			var_11_1.resId = "eff_ui_battle_barfull"
			var_11_1.anim = "play_" .. self._quality + 1
			var_11_1.path = g.core.common.Path:getEffSpine("eff_ui_battle_barfull")

			local var_11_2 = SpineBase.new(var_11_1)

			var_11_2:setAnchorPoint(0, 0.5)
			var_11_2:setPosition(var_0_10 / 2, 0)
			self._energyRoot:addChild(var_11_2)

			self._energyEffect = var_11_2
		end

		self._energyEffect:setVisible(true)
	elseif self._energyEffect then
		self._energyEffect:setVisible(false)
	end
end

function HpAngerBar:updateSp()
	return
end

function HpAngerBar:setLayer(arg_13_1, arg_13_2)
	self._battleLayer = arg_13_1
	self._memberId = arg_13_2

	self:updateHp(self._hp, true)
	self:updateAnger(self._anger)
end

function HpAngerBar:getHp()
	return self._hp, self._maxHp
end

function HpAngerBar:setMaxHp(arg_15_1)
	self._maxHp = arg_15_1

	if self._isBoss then
		self._battleLayer:setBossMaxHp(arg_15_1)
	end
end

function HpAngerBar:resetHp(arg_16_1)
	self._hp = arg_16_1
end

function HpAngerBar:setShield(arg_17_1)
	self._shield = arg_17_1

	if self._isBoss then
		self._battleLayer:updateBossShield(arg_17_1)
	end
end

function HpAngerBar:addHp(arg_18_1, arg_18_2)
	if arg_18_1 >= 0 then
		self._hp = self:_limitNumber(self._hp + arg_18_1)
	elseif arg_18_2 then
		self._hp = self:_limitNumber(self._hp + arg_18_1)
	elseif self._shield + arg_18_1 > 0 then
		self._shield = self._shield + arg_18_1
	else
		self._shield = 0
		self._hp = self:_limitNumber(self._hp + self._shield + arg_18_1)
	end

	self:updateProgressBar()
end

function HpAngerBar:updateProgressBar()
	if self._shield > 0 then
		self._bgShield:setVisible(true)
		self:updateHp(self._hp)
		self:updateShield(self._shield)
	elseif self._shield <= 0 then
		self._bgShield:setVisible(false)
		self:updateHp(self._hp)
		self:updateShield(0)
	end
end

function HpAngerBar:_limitNumber(arg_20_1)
	arg_20_1 = math.min(arg_20_1, self._maxHp)
	arg_20_1 = math.max(arg_20_1, 0)
	arg_20_1 = math.floor(arg_20_1)

	return arg_20_1
end

function HpAngerBar:updateHp(arg_21_1, arg_21_2)
	local var_21_0 = arg_21_1 / self._maxHp

	var_21_0 = arg_21_1 / self._maxHp > 1 and 1 or var_21_0

	self._hpBar:setContentSize(cc.size(var_0_9 * var_21_0, 6))

	if arg_21_2 then
		self:_onStopHpAction(arg_21_1)
	else
		self:_onPlayHpAction(arg_21_1)
	end

	if BattleConst.DEBUG then
		self._hpLabel:setString(arg_21_1)
	end

	if self._isBoss then
		self._battleLayer:updateBossHp(self._hp)
	end

	return arg_21_1
end

function HpAngerBar:_onPlayHpAction(arg_22_1)
	self:_onStopHpAction()

	local var_22_0 = 1
	local var_22_1 = arg_22_1 / self._maxHp

	var_22_1 = arg_22_1 / self._maxHp > 1 and 1 or var_22_1

	if math.abs(self._hpBgBar:getScaleX() - var_22_1) < 0.15 then
		var_22_0 = 0.5
	end

	local var_22_2 = handler(self, self._onStopHpAction)

	self._hpBgBar:runAction((cc.EaseSineInOut:create((cc.Sequence:create(cc.ScaleTo:create(var_22_0, var_22_1, 1), (cc.CallFunc:create(function()
		var_22_2()
	end)))))))
	self._hpBgBar:setVisible(true)
end

function HpAngerBar:_onStopHpAction(arg_24_1)
	self._hpBgBar:stopAllActions()

	if arg_24_1 then
		local var_24_0 = arg_24_1 / self._maxHp

		var_24_0 = arg_24_1 / self._maxHp > 1 and 1 or var_24_0

		self._hpBgBar:setScaleX(var_24_0)
	end

	self._hpBgBar:setVisible(false)
end

function HpAngerBar:updateShield(arg_25_1)
	local var_25_0 = arg_25_1 / (self._maxHp * 2)

	var_25_0 = arg_25_1 / (self._maxHp * 2) > 1 and 1 or var_25_0

	self._shieldBar:setContentSize(cc.size(var_0_9 * var_25_0, 6))

	if self._isBoss then
		self._battleLayer:updateBossShield(arg_25_1)
	end

	return arg_25_1
end

function HpAngerBar:addAnger(arg_26_1)
	self:updateAnger(self._anger + arg_26_1)
end

function HpAngerBar:addEnergy(arg_27_1)
	if self._quality == var_0_5.UR then
		self:updateEnergy(self._energy + arg_27_1)
	end
end

function HpAngerBar:addThresh(arg_28_1)
	if self._quality == var_0_5.MR then
		self:updateEnergy(self._energy + arg_28_1)
	end
end

function HpAngerBar:isAngerFull()
	return self._anger >= 4
end

function HpAngerBar:getAnger()
	return self._anger
end

function HpAngerBar:getAngerRect()
	local var_31_0 = self._bgHp:convertToWorldSpace(cc.p(0, 0))
	local var_31_1 = self._bgHp:getContentSize()

	return (cc.rect(var_31_0.x, var_31_0.y, var_31_1.width, var_31_1.height))
end

function HpAngerBar:setBoss()
	self._isBoss = true
end

function HpAngerBar:getShield()
	return self._shield
end

function HpAngerBar:clear()
	for iter_34_0 = 1, #self._angers do
		if self._angers[iter_34_0][2] then
			self._angers[iter_34_0][2]:dispose()
		end
	end

	if self._energyEffect then
		self._energyEffect:dispose()

		self._energyEffect = nil
	end
end

function HpAngerBar:clearMarks()
	for iter_35_0, iter_35_1 in pairs(self._markDict) do
		iter_35_1:removeFromParent()
	end

	self._markDict = {}
end

function HpAngerBar:addMark(arg_36_1, arg_36_2)
	if arg_36_1.is_show == 0 then
		return
	end

	local var_36_0 = arg_36_1.type

	if not self._markDict[arg_36_1.type] and table.nums(self._markDict) < var_0_13 then
		local var_36_1 = HpMarkIcon.new(arg_36_1)

		self._markDict[var_36_0] = var_36_1

		self._markRoot:addChild(var_36_1)
		self:updateMarkIconPos()
	end

	if self._markDict[var_36_0] then
		self._markDict[var_36_0]:addValue(arg_36_2)
	end

	if self._isBoss then
		-- block empty
	end
end

function HpAngerBar:updateMarkIconPos()
	for iter_37_0, iter_37_1 in pairs(self._markDict) do
		iter_37_1:setPosition(-var_0_13 * (0 + 0.5), -2)
	end
end

function HpAngerBar:delMark(arg_38_1, arg_38_2)
	if self._markDict[arg_38_1] then
		self._markDict[arg_38_1]:addValue(-arg_38_2)

		if self._markDict[arg_38_1]:getValue() <= 0 then
			self._markDict[arg_38_1]:removeFromParent()

			self._markDict[arg_38_1] = nil

			self:updateMarkIconPos()
		end
	end

	if self._isBoss then
		-- block empty
	end
end

return HpAngerBar
