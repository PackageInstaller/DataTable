local BuffRule = require("battle.core.rule.BuffRule")
local BattleConst = require("app.view.battle.const.BattleConst")
local BattlePath = require("app.view.battle.BattlePath")
local BattleBossHpCompElder = class("BattleBossHpCompElder", require("app.fairyGUI.battle.UI_BattleBossHpCompElder"))

function BattleBossHpCompElder:ctor()
	self._hp = 0
	self._shield = 0
	self._name = 0
	self._maxHp = 1
	self._buffMarkIcons = {}
	self._hpTubeNum = 1
	self._battleField = nil

	self:updateShield(0)
end

function BattleBossHpCompElder:setElderData(arg_2_1)
	self._battleField = arg_2_1
end

function BattleBossHpCompElder:refreshMaxHp()
	self._maxHp = 0

	for iter_3_0, iter_3_1 in ipairs((self._battleField:getBattleData():getKnightList(2, true))) do
		if iter_3_1:getBuffCount(BuffRule.TYPE.BUFF_530, true) == 0 then
			self._maxHp = self._maxHp + iter_3_1.originInfo.INITIAL_HP
		end
	end
end

function BattleBossHpCompElder:_getCurHp()
	local var_4_0 = 0

	for iter_4_0, iter_4_1 in ipairs((self._battleField:getBattleData():getKnightList(2, true))) do
		if iter_4_1:getBuffCount(BuffRule.TYPE.BUFF_530, true) == 0 then
			var_4_0 = var_4_0 + iter_4_1.baseInfo.INITIAL_HP
		end
	end

	return var_4_0
end

function BattleBossHpCompElder:setMaxHp()
	return
end

function BattleBossHpCompElder:updateInfo(arg_6_1)
	self:refreshMaxHp()
	self:_initView(arg_6_1)
end

function BattleBossHpCompElder:_initView(arg_7_1)
	self._hp = self:_getCurHp()

	self:updateHp(self._hp)

	local var_7_0 = g.core.config.monster_info.get(arg_7_1)

	self.m_nameText:setText(var_7_0.name)
	self.m_bossIcon:setURL((BattlePath.getBossIconPath(var_7_0.res_id)))
	self.m_skillIcon1:setURL((BattlePath.getSkillIconPath(g.core.config.skill_info.get(var_7_0.common_id).icon)))
	self.m_skillIcon2:setURL((BattlePath.getSkillIconPath(g.core.config.skill_info.get(var_7_0.active_skill_id).icon)))

	self._buffMarkIcons = {}

	for iter_7_0 = 1, BattleConst.MAX_BUFF_ICON_NUM do
		local var_7_1 = fgui.UIPackage:createObject("battle", "BattleMarkIconComp")

		var_7_1:setPosition((iter_7_0 - 1) * 23, 0)
		var_7_1:setVisible(false)
		self.m_buffPlaceHolder:addChild(var_7_1)
		table.insert(self._buffMarkIcons, var_7_1)
	end
end

function BattleBossHpCompElder:setIcon(arg_8_1, arg_8_2)
	self:setIconByPath(g.core.common.Path:getKnightIconById(arg_8_1), arg_8_2)
end

function BattleBossHpCompElder:setIconByPath(arg_9_1, arg_9_2)
	self.m_knightLoader:setURL(arg_9_1, arg_9_2)
end

function BattleBossHpCompElder:updateHp()
	local var_10_0 = self:_getCurHp()

	if self._hpTubeNum ~= 1 then
		local var_10_1 = self._maxHp / self._hpTubeNum
		local var_10_2 = math.ceil(var_10_0 / (self._maxHp / self._hpTubeNum))
		local var_10_3 = var_10_0 % (self._maxHp / self._hpTubeNum)

		if var_10_0 % (self._maxHp / self._hpTubeNum) < 0 then
			var_10_3 = 0
		end

		if var_10_3 == 0 and var_10_2 > 0 then
			var_10_3 = var_10_1
		end

		if var_10_2 > 0 then
			self.m_hpTubeBg:setVisible(true)
		else
			self.m_hpTubeBg:setVisible(false)
		end

		local var_10_4 = math.min(1, var_10_3 / var_10_1)

		self.m_progressImg:setFillAmount(var_10_4)
		self.m_tweenProgress:setPercent({
			tween = true,
			max = 100,
			cur = var_10_4 * 100
		})
		self.m_percentText:setText(string.format("%.1f%%", var_10_4 * 100))
		self.m_hpTubeText:setText(g.core.lang:get(109536, {
			num = var_10_2
		}))
		self.m_hpTubeTextBg:setVisible(true)
	else
		self.m_hpTubeBg:setVisible(false)
		self.m_hpTubeText:setVisible(false)
		self.m_hpTubeTextBg:setVisible(false)

		local var_10_5 = math.min(1, var_10_0 / self._maxHp)

		self.m_progressImg:setFillAmount(var_10_5)
		self.m_tweenProgress:setPercent({
			tween = true,
			max = 100,
			cur = var_10_5 * 100
		})
		self.m_percentText:setText(string.format("%.1f%%", var_10_5 * 100))
	end
end

function BattleBossHpCompElder:updateShield(arg_11_1)
	if arg_11_1 > 0 then
		self.m_progressShieldImg:setFillAmount((math.min(1, arg_11_1 / (self._maxHp * 2))))
		self.m_progressShieldImg:setVisible(true)
	else
		self.m_progressShieldImg:setVisible(false)
	end
end

function BattleBossHpCompElder:updateLevel(arg_12_1)
	if arg_12_1 ~= self._level then
		self.m_levelComp:getChild("levelText"):setText(arg_12_1)

		self._level = arg_12_1
	end
end

function BattleBossHpCompElder:showBossLevel(arg_13_1)
	self.m_levelComp:setVisible(arg_13_1)
end

function BattleBossHpCompElder:updateBossAnger(arg_14_1)
	return
end

function BattleBossHpCompElder:updateBossBuffIcons(arg_15_1)
	for iter_15_0 = 1, BattleConst.MAX_BUFF_ICON_NUM do
		self._buffMarkIcons[iter_15_0]:setVisible(false)
	end

	for iter_15_1 = #arg_15_1, 1, -1 do
		if 0 >= BattleConst.MAX_BUFF_ICON_NUM then
			break
		end

		local var_15_0

		if arg_15_1[iter_15_1] then
			self._buffMarkIcons[BattleConst.MAX_BUFF_ICON_NUM - 0]:updateView(arg_15_1[iter_15_1])
			self._buffMarkIcons[BattleConst.MAX_BUFF_ICON_NUM - 0]:setVisible(true)

			var_15_0 = 0 + 1
		end
	end
end

function BattleBossHpCompElder:transferBoss()
	return
end

function BattleBossHpCompElder:onLoad()
	return
end

function BattleBossHpCompElder:onUnload()
	return
end

function BattleBossHpCompElder:updateTotalDamage(arg_19_1)
	return
end

return BattleBossHpCompElder
