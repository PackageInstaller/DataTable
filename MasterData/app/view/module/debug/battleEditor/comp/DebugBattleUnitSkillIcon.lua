local var_0_0 = g.core.const.ConstMgr.UniteTokenConst
local BattleEditorData = require("app.view.module.debug.model.BattleEditorData")
local DebugBattleUnitSkillIcon = class("DebugBattleUnitSkillIcon", require("app.fairyGUI.debug.UI_DebugBattleUnitSkillIcon"))

function DebugBattleUnitSkillIcon:ctor()
	self._isDrag = false
	self._isOtherDrag = false
	self._skillPos = 0
	self._tokenData = {}

	self:addClickListener(handler(self, self._onClick))
	self:addEventListener(fgui.UIEventType.RollOver, handler(self, self._onRollOver))
	self:addEventListener(fgui.UIEventType.RollOut, handler(self, self._onRollOut))
end

function DebugBattleUnitSkillIcon:setIdentity(arg_2_1)
	self._identity = arg_2_1
end

function DebugBattleUnitSkillIcon:setSkillPos(arg_3_1)
	self._skillPos = arg_3_1
end

function DebugBattleUnitSkillIcon:getSkillPos()
	return self._skillPos
end

function DebugBattleUnitSkillIcon:getSkillId()
	if self._tokenData then
		return self._tokenData:getAdvanceId()
	else
		return 0
	end
end

function DebugBattleUnitSkillIcon:updateFormatUnlock(arg_6_1)
	self.m_stateController:setSelectedIndex(var_0_0.CTRL_FORMAT_UNLV)
	self.m_openText:setText(g.core.lang:get(202514, {
		level = arg_6_1
	}))
end

function DebugBattleUnitSkillIcon:updateTokenFormatIcon(arg_7_1)
	if not arg_7_1 or not next(arg_7_1) then
		self.m_stateController:setSelectedIndex(var_0_0.CTRL_FORMAT_TODO)
		g.core.utils.Action.playBlinkAction(self.m_addPic, 1, 0)
		self.m_skillIcon:updateIcon()

		self._tokenData = nil

		return
	end

	self._tokenData = arg_7_1

	self.m_stateController:setSelectedIndex(var_0_0.CTRL_FORMAT_DONE)
	self.m_skillIcon:updateIcon({
		skillId = self._tokenData:getSkillId()
	})
end

function DebugBattleUnitSkillIcon:_onClick()
	if not self._tokenData or not next(self._tokenData) then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.debug.pop.BattleEditorUniteTokenPop").new({
			pos = self._skillPos,
			identity = self._identity
		}))
	else
		BattleEditorData.getInstance():unpackTokenByPos(self._skillPos, self._identity)
		g.core.event.EventManager:dispatchEvent("EVENT_CHANGE_UNITE", false)
	end
end

function DebugBattleUnitSkillIcon:_onRollOut()
	self:setScale(1)
end

function DebugBattleUnitSkillIcon:_onRollOver()
	if self._isOtherDrag and not self._isDrag then
		self:setScale(1.1)
	end
end

return DebugBattleUnitSkillIcon
