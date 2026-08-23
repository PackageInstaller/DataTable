local var_0_0 = g.core.model.User.allianceData
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.common.ModuleUnlock
local var_0_3 = g.core.config.guild_alliance_buildings_info
local AllianceEnterBtn = class("AllianceEnterBtn", require("app.fairyGUI.alliance.UI_AllianceEnterBtn"))

function AllianceEnterBtn:ctor()
	self._buildInfo = nil
	self._data = nil

	self:initView()
end

function AllianceEnterBtn:initView()
	self:addClickListener(handler(self, self._onClickEnterBtn))
end

function AllianceEnterBtn:_onClickEnterBtn()
	if self._data then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Capture)

		if var_0_2:checkModuleUnlockStatus(self._buildInfo.id) and (not self._data.enterCheck or self._data.enterCheck()) then
			if self._data.buildId == g.core.const.ConstMgr.FUNCTION_TYPE.ALLIANCE_HONOR then
				g.core.network.GameNetProxy:send_C2S_GuildAlliance_HonourGetInfo({})
			else
				g.core.module.ModuleManager:pushModule(self._data.moduleEnter, self._data.moduleParams or {})
			end
		end
	end
end

function AllianceEnterBtn:setData(arg_4_1)
	self._data = arg_4_1

	local var_4_0 = arg_4_1.buildId

	self._buildInfo = var_0_3.get(arg_4_1.buildId)

	self:setIcon(var_0_1:getAllianceBuildIcon(self._buildInfo.icon, false))
	self:setTitle(self._buildInfo.name)
	self.m_isLockController:setSelectedIndex(var_0_2:isModuleUnlock(var_4_0) and 0 or 1)
end

function AllianceEnterBtn:checkLevelUpUnlock()
	if self._buildInfo and self._buildInfo.level == var_0_0:getAllianceLevel() then
		self.m_eff:addEffectSpine({
			anim = "play",
			name = "eff_ui_alliance_unlock",
			remove = true,
			isLoop = false
		})
	end
end

return AllianceEnterBtn
