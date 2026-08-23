local FogNightmareSmallIcon = class("FogNightmareSmallIcon", require("app.fairyGUI.fogNightmare.UI_FogNightmareSmallIcon"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareSmallIcon",
		pkgPath = "ui/fogNightmare/fogNightmare",
		isFullScreen = true,
		pkgName = "fogNightmare"
	}, ...)
end)

function FogNightmareSmallIcon:ctor()
	self.m_touchPic:addEventListener(fgui.UIEventType.Click, handler(self, self._onItemSelect))
end

function FogNightmareSmallIcon:updateView(arg_3_1)
	self.m_isSelectController:setSelectedIndex(0)

	if arg_3_1.isMax then
		self.m_txtCurLv:setText(g.core.lang:get(112201))
	else
		self.m_txtCurLv:setText(arg_3_1.curLevel)
	end

	self._data = arg_3_1

	self.m_pointIcon:setURL(g.core.common.Path:getFogNightmareTalentPicRes(self._data:getCfg().icon))
	self.m_pointIcon2:setURL(g.core.common.Path:getFogNightmareTalentPicRes(self._data:getCfg().icon .. "_1"))

	if self._data:getUpgrade() then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.FOG_NIGHTMARE_TALENT_LEVEL_UP)
		self.m_effUpgradeS:addEffectSpine({
			anim = "play2",
			name = "eff_ui_fogNightmare_talentUpgrade",
			isLoop = false
		})
		self._data:setUpgrade(false)
	end

	if not self._data.isUnLock then
		self.m_statusController:setSelectedIndex(2)
	elseif self._data.curLevel == 0 and not self._data:isSpecial() then
		if self._data:getPlayLock() then
			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.FOG_NIGHTMARE_TALENT_UNLOCK)
			self.m_effUnlockS:addEffectSpine({
				anim = "play2",
				name = "eff_ui_fogNightmare_talentUnlock",
				isLoop = false
			})
			self._data:setPlayLock(false)
		end

		self.m_statusController:setSelectedIndex(1)
	else
		self.m_statusController:setSelectedIndex(0)
	end
end

function FogNightmareSmallIcon:resetState()
	self.m_isSelectController:setSelectedIndex(0)
end

function FogNightmareSmallIcon:_onItemSelect()
	self:dispatchCompEvent("ENTER_FOG_SELECT_TALENT", {
		data = self._data
	})
	self.m_isSelectController:setSelectedIndex(1)
end

return FogNightmareSmallIcon
