local FogNightmareTalentIconGroupComp = class("FogNightmareTalentIconGroupComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareTalentIconGroupComp"))
local var_0_1 = g.core.model.User.fogNightmareData

function FogNightmareTalentIconGroupComp:ctor()
	self.m_touchPic:addEventListener(fgui.UIEventType.Click, handler(self, self._onItemSelect))
	self.m_touchLoader:addEventListener(fgui.UIEventType.Click, handler(self, self._onHideTip))

	self._isBig = false
	self._smallNum = 0
end

function FogNightmareTalentIconGroupComp:updateCell(arg_2_1)
	self.m_isSelect_bController:setSelectedIndex(0)

	if #arg_2_1 == 1 and arg_2_1[1]:getCfg().key_node == 1 then
		self.m_isSmallController:setSelectedIndex(0)

		if arg_2_1[1].isMax then
			self.m_txtCurLv:setText(g.core.lang:get(112201))
		else
			self.m_txtCurLv:setText(arg_2_1[1].curLevel)
		end

		self._data = arg_2_1[1]
		self._isBig = true

		self.m_pointIcon:setURL(g.core.common.Path:getFogNightmareTalentPicRes(arg_2_1[1]:getCfg().icon))
		self.m_pointIcon2:setURL(g.core.common.Path:getFogNightmareTalentPicRes(arg_2_1[1]:getCfg().icon .. "_1"))

		if self._data:getUpgrade() then
			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.FOG_NIGHTMARE_TALENT_LEVEL_UP)
			self.m_effUpgradeB:addEffectSpine({
				anim = "play",
				name = "eff_ui_fogNightmare_talentUpgrade",
				isLoop = false
			})
			self._data:setUpgrade(false)
		end
	else
		self.m_isSmallController:setSelectedIndex(1)
		self.m_numTypeController:setSelectedIndex(#arg_2_1 - 2)

		for iter_2_0 = 1, #arg_2_1 do
			self["m_smallIcon" .. iter_2_0]:updateView(arg_2_1[iter_2_0])
		end

		self._smallNum = #arg_2_1
		self._isBig = false
	end

	if not arg_2_1[1].isUnLock then
		self.m_bigStatusController:setSelectedIndex(2)

		if self._isBig and arg_2_1[1]:getCfg().layer ~= 1 then
			self.m_lockProgress:setValue(var_0_1:getTalentData():getLayerLevelByTabAndLayer(arg_2_1[1]:getCfg().tab, arg_2_1[1]:getCfg().layer - 1) / arg_2_1[1]:getCfg().previous_layer_level * 100)
		end
	elseif var_0_1:getTalentData():getLayerLevelByTabAndLayer(arg_2_1[1]:getCfg().tab, arg_2_1[1]:getCfg().layer) == 0 and not arg_2_1[1]:isSpecial() then
		if self._isBig and arg_2_1[1]:getPlayLock() then
			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.FOG_NIGHTMARE_TALENT_UNLOCK)
			self.m_effUnlockB:addEffectSpine({
				anim = "play",
				name = "eff_ui_fogNightmare_talentUnlock",
				isLoop = false
			})
			arg_2_1[1]:setPlayLock(false)
		end

		self.m_bigStatusController:setSelectedIndex(1)
	else
		self.m_bigStatusController:setSelectedIndex(0)
	end

	if var_0_1:getTalentData():getLayerUpgrade() == arg_2_1[1]:getCfg().layer then
		if var_0_1:getTalentData():getHasUnlock() then
			self.m_effCurved:addEffectSpine({
				anim = "play",
				name = "eff_ui_fogNightmare_talentCurved",
				isLoop = false
			})
			var_0_1:getTalentData():setHasUnlock(false)
		else
			self.m_effCurved:addEffectSpine({
				anim = "play2",
				name = "eff_ui_fogNightmare_talentCurved",
				isLoop = false
			})
		end

		var_0_1:getTalentData():setLayerUpgrade(0)
	end
end

function FogNightmareTalentIconGroupComp:resetState()
	if self._isBig then
		self.m_isSelect_bController:setSelectedIndex(0)
	else
		for iter_3_0 = 1, self._smallNum do
			self["m_smallIcon" .. iter_3_0]:resetState()
		end
	end
end

function FogNightmareTalentIconGroupComp:_onItemSelect()
	self:dispatchCompEvent("ENTER_FOG_SELECT_TALENT", {
		data = self._data
	})
	self.m_isSelect_bController:setSelectedIndex(1)
end

function FogNightmareTalentIconGroupComp:_onHideTip()
	self:dispatchCompEvent("ENTER_FOG_HIDE_TIP")
end

return FogNightmareTalentIconGroupComp
