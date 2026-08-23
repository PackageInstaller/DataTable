local BattleConst = require("app.view.battle.const.BattleConst")
local BattlePath = require("app.view.battle.BattlePath")
local BattleBossHpComp = class("BattleBossHpComp", require("app.fairyGUI.battle.UI_BattleBossHpComp"))

function BattleBossHpComp:ctor()
	self._anger = 0
	self._hp = 0
	self._angerSp = nil
	self._shield = 0
	self._angerSpShow = false
	self._name = 0
	self._maxHp = 1
	self._monsterId = nil
	self._buffMarkIcons = {}

	self:updateShield(0)
end

function BattleBossHpComp:setMaxHp(arg_2_1)
	self._maxHp = arg_2_1

	if g.core.battle.BattleProxy:getType() == BattleConst.TYPE_DEMON_BOSS then
		self.m_upEffNode:removeAllEffect()
		self.m_upEffNode:addNode((require("app.view.common.SpineBase").new({
			isLoop = false,
			anim = "play",
			resId = "",
			path = g.core.common.Path:getEffSpine("eff_ui_battle_bossup")
		})))
	end
end

function BattleBossHpComp:updateInfo(arg_3_1, arg_3_2)
	self._monsterId = arg_3_1

	self:_initView(arg_3_2)
end

function BattleBossHpComp:_initView(arg_4_1)
	self._hp, self._maxHp = arg_4_1:getHp()
	self._anger = arg_4_1._bar:getAnger()
	self._hpTubeNum = arg_4_1:getBaseInfo().hpTube or 1

	self:updateHp(self._hp)
	self:updateBossAnger(self._anger)

	local var_4_0 = g.core.config.monster_info.get(self._monsterId)

	self.m_nameText:setText(var_4_0.name)
	self.m_bossIcon:setURL((BattlePath.getBossIconPath(var_4_0.res_id)))
	self.m_skillIcon1:setURL((BattlePath.getSkillIconPath(g.core.config.skill_info.get(var_4_0.common_id).icon)))
	self.m_skillIcon2:setURL((BattlePath.getSkillIconPath(g.core.config.skill_info.get(var_4_0.active_skill_id).icon)))

	self._buffMarkIcons = {}

	for iter_4_0 = 1, BattleConst.MAX_BUFF_ICON_NUM do
		local var_4_1 = fgui.UIPackage:createObject("battle", "BattleMarkIconComp")

		var_4_1:setPosition((iter_4_0 - 1) * 23, 0)
		var_4_1:setVisible(false)
		self.m_buffPlaceHolder:addChild(var_4_1)
		table.insert(self._buffMarkIcons, var_4_1)
	end

	self.m_levelGroup:setVisible(false)
end

function BattleBossHpComp:setIcon(arg_5_1, arg_5_2)
	self:setIconByPath(g.core.common.Path:getKnightIconById(arg_5_1), arg_5_2)
end

function BattleBossHpComp:setIconByPath(arg_6_1, arg_6_2)
	self.m_knightLoader:setURL(arg_6_1, arg_6_2)
end

function BattleBossHpComp:updateHp(arg_7_1)
	if self._hpTubeNum ~= 1 then
		local var_7_0 = self._maxHp / self._hpTubeNum
		local var_7_1 = math.ceil(arg_7_1 / (self._maxHp / self._hpTubeNum))
		local var_7_2 = arg_7_1 % (self._maxHp / self._hpTubeNum)

		if arg_7_1 % (self._maxHp / self._hpTubeNum) < 0 then
			var_7_2 = 0
		end

		if var_7_2 == 0 and var_7_1 > 0 then
			var_7_2 = var_7_0
		end

		if var_7_1 > 0 then
			self.m_hpTubeBg:setVisible(true)
		else
			self.m_hpTubeBg:setVisible(false)
		end

		local var_7_3 = math.min(1, var_7_2 / var_7_0)

		self.m_progressImg:setFillAmount(var_7_3)
		self.m_tweenProgress:setPercent({
			tween = true,
			max = 100,
			cur = var_7_3 * 100
		})
		self.m_percentText:setText(string.format("%.1f%%", var_7_3 * 100))
		self.m_hpTubeText:setText(g.core.lang:get(109536, {
			num = var_7_1
		}))
		self.m_hpTubeTextBg:setVisible(true)
	else
		self.m_hpTubeBg:setVisible(false)
		self.m_hpTubeText:setVisible(false)
		self.m_hpTubeTextBg:setVisible(false)

		local var_7_4 = math.min(1, arg_7_1 / self._maxHp)

		self.m_progressImg:setFillAmount(var_7_4)
		self.m_tweenProgress:setPercent({
			tween = true,
			max = 100,
			cur = var_7_4 * 100
		})
		self.m_percentText:setText(string.format("%.1f%%", var_7_4 * 100))
	end
end

function BattleBossHpComp:updateShield(arg_8_1)
	if arg_8_1 > 0 then
		self.m_progressShieldImg:setFillAmount((math.min(1, arg_8_1 / (self._maxHp * 2))))
		self.m_progressShieldImg:setVisible(true)
	else
		self.m_progressShieldImg:setVisible(false)
	end
end

function BattleBossHpComp:updateLevel(arg_9_1)
	if arg_9_1 ~= self._level then
		self.m_levelComp:getChild("levelText"):setText(arg_9_1)

		self._level = arg_9_1
	end
end

function BattleBossHpComp:showBossLevel(arg_10_1)
	self.m_levelComp:setVisible(arg_10_1)

	if g.core.battle.BattleProxy:getType() == BattleConst.TYPE_DEMON_BOSS and not self._levelEffect then
		self._levelEffect = require("app.view.common.SpineBase").new({
			isLoop = true,
			anim = "play",
			resId = "",
			path = g.core.common.Path:getEffSpine("eff_ui_battle_bosslevel")
		})

		self.m_levelEffNode:addNode(self._levelEffect)
	end
end

function BattleBossHpComp:updateBossAnger(arg_11_1)
	for iter_11_0 = 1, 4 do
		if iter_11_0 <= arg_11_1 then
			self["m_angerImg" .. iter_11_0]:setVisible(true)
		else
			self["m_angerImg" .. iter_11_0]:setVisible(false)
		end
	end
end

function BattleBossHpComp:updateBossBuffIcons(arg_12_1)
	for iter_12_0 = 1, BattleConst.MAX_BUFF_ICON_NUM do
		self._buffMarkIcons[iter_12_0]:setVisible(false)
	end

	for iter_12_1 = #arg_12_1, 1, -1 do
		if 0 >= BattleConst.MAX_BUFF_ICON_NUM then
			break
		end

		local var_12_0

		if arg_12_1[iter_12_1] then
			self._buffMarkIcons[BattleConst.MAX_BUFF_ICON_NUM - 0]:updateView(arg_12_1[iter_12_1])
			self._buffMarkIcons[BattleConst.MAX_BUFF_ICON_NUM - 0]:setVisible(true)

			var_12_0 = 0 + 1
		end
	end
end

function BattleBossHpComp:transferBoss()
	return
end

function BattleBossHpComp:onLoad()
	return
end

function BattleBossHpComp:onUnload()
	return
end

function BattleBossHpComp:updateTotalDamage(arg_16_1)
	return
end

return BattleBossHpComp
