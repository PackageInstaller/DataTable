local BattleConst = require("app.view.battle.const.BattleConst")
local BattlePath = require("app.view.battle.BattlePath")
local BattleBossHpCompShmc = class("BattleBossHpCompShmc", require("app.fairyGUI.battle.UI_BattleBossHpCompShmc"))

function BattleBossHpCompShmc:ctor()
	self._bossInfo = g.core.config.spire_boss_info.indexOf(1)
	self._onceDamage = self._bossInfo.boss_hp
	self._knightId = nil
	self._totalDamage = 0
	self._buffMarkIcons = {}
	self._curBarCount = 0
	self._targetPer = 0
	self._lastBarCount = 0
	self._lastBarPer = 0
	self._hasAnim = false
	self._amin1Time = 0.15
	self._amin2Time = 0.3
end

function BattleBossHpCompShmc:setMaxHp()
	return
end

function BattleBossHpCompShmc:setBossInfo(arg_3_1)
	if arg_3_1 then
		self._bossInfo = arg_3_1
		self._onceDamage = self._bossInfo.boss_hp
	end
end

function BattleBossHpCompShmc:updateInfo(arg_4_1, arg_4_2)
	self._knightId = arg_4_1

	self:_initView(arg_4_2)
end

function BattleBossHpCompShmc:_initView(arg_5_1)
	local var_5_0 = arg_5_1:getKnightInfo()

	self.m_nameText:setText(self._bossInfo.name)
	self.m_bossIcon:setURL((BattlePath.getBossIconPath(var_5_0.res_id)))
	self.m_skillIcon1:setURL((BattlePath.getSkillIconPath(g.core.config.skill_info.get(var_5_0.common_id).icon)))
	self.m_skillIcon2:setURL((BattlePath.getSkillIconPath(g.core.config.skill_info.get(var_5_0.active_skill_id).icon)))

	self._buffMarkIcons = {}

	for iter_5_0 = 1, BattleConst.MAX_BUFF_ICON_NUM do
		local var_5_1 = fgui.UIPackage:createObject("battle", "BattleMarkIconComp")

		var_5_1:setPosition((iter_5_0 - 1) * 23, 0)
		var_5_1:setVisible(false)
		self.m_buffPlaceHolder:addChild(var_5_1)
		table.insert(self._buffMarkIcons, var_5_1)
	end

	self.m_levelGroup:setVisible(false)
end

function BattleBossHpCompShmc:setIcon(arg_6_1, arg_6_2)
	self:setIconByPath(g.core.common.Path:getKnightIconById(arg_6_1), arg_6_2)
end

function BattleBossHpCompShmc:setIconByPath(arg_7_1, arg_7_2)
	self.m_knightLoader:setURL(arg_7_1, arg_7_2)
end

function BattleBossHpCompShmc:updateHp(arg_8_1)
	return
end

function BattleBossHpCompShmc:updateShield(arg_9_1)
	return
end

function BattleBossHpCompShmc:updateLevel(arg_10_1)
	return
end

function BattleBossHpCompShmc:showBossLevel(arg_11_1)
	return
end

function BattleBossHpCompShmc:updateBossAnger(arg_12_1)
	return
end

function BattleBossHpCompShmc:updateBossBuffIcons(arg_13_1)
	for iter_13_0 = 1, BattleConst.MAX_BUFF_ICON_NUM do
		self._buffMarkIcons[iter_13_0]:setVisible(false)
	end

	for iter_13_1 = #arg_13_1, 1, -1 do
		if 0 >= BattleConst.MAX_BUFF_ICON_NUM then
			break
		end

		local var_13_0

		if arg_13_1[iter_13_1] then
			self._buffMarkIcons[BattleConst.MAX_BUFF_ICON_NUM - 0]:updateView(arg_13_1[iter_13_1])
			self._buffMarkIcons[BattleConst.MAX_BUFF_ICON_NUM - 0]:setVisible(true)

			var_13_0 = 0 + 1
		end
	end
end

function BattleBossHpCompShmc:transferBoss()
	return
end

function BattleBossHpCompShmc:onLoad()
	self:newSchedule(handler(self, self._updateHpAnim), 0.033)
end

function BattleBossHpCompShmc:onUnload()
	return
end

function BattleBossHpCompShmc:updateTotalDamage(arg_17_1)
	if arg_17_1 == self._totalDamage then
		return
	end

	self._totalDamage = arg_17_1

	local var_17_0 = math.floor(arg_17_1 / self._onceDamage)

	self.m_barCount:disableAutoChange()
	self.m_barCount:runChangeAni(self._lastBarCount, var_17_0, true, "x")

	self._lastBarCount = math.max(self._curBarCount, var_17_0 - 3)
	self._curBarCount = var_17_0
	self._targetPer = arg_17_1 % self._onceDamage / self._onceDamage
	self._hasAnim = true
end

function BattleBossHpCompShmc:_updateHpAnim()
	if self._lastBarCount < self._curBarCount then
		self._lastBarPer = self._lastBarPer + 0.033 / self._amin1Time

		if self._lastBarPer >= 1 then
			self._lastBarPer = 0
			self._lastBarCount = self._lastBarCount + 1
		end
	elseif self._lastBarCount == self._curBarCount then
		self._lastBarPer = self._lastBarPer + 0.033 / self._amin2Time

		if self._lastBarPer > self._targetPer then
			self._lastBarPer = self._targetPer
			self._hasAnim = false
		end
	else
		self._lastBarCount = self._curBarCount
		self._lastBarPer = self._targetPer
		self._hasAnim = false
	end

	if not self._hasAnim then
		return
	end

	local var_18_0 = self._lastBarCount % 4 + 1

	if self._lastBarCount <= 0 then
		self.m_hpLoader1:setVisible(false)
		self.m_hpLoader2:setURL("ui://battle/pic_shmc_xuetiao" .. var_18_0)
		self.m_hpLoader2:setFillAmount(self._lastBarPer)
	else
		self.m_hpLoader1:setURL("ui://battle/pic_shmc_xuetiao" .. var_18_0)
		self.m_hpLoader1:setVisible(true)

		if var_18_0 == 4 then
			self.m_hpLoader2:setURL("ui://battle/pic_shmc_xuetiao1")
		else
			self.m_hpLoader2:setURL("ui://battle/pic_shmc_xuetiao" .. var_18_0 + 1)
		end

		self.m_hpLoader2:setFillAmount(self._lastBarPer)
	end
end

return BattleBossHpCompShmc
