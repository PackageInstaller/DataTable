local UniteTokenSkillPop = require("app.view.module.tip.view.UniteTokenSkillPop")
local var_0_1 = g.core.model.User
local var_0_2 = g.core.const.ConstMgr.UniteTokenConst
local FormationSkillBtn = class("FormationSkillBtn", require("app.fairyGUI.formation.UI_FormationSkillBtn"))

function FormationSkillBtn:ctor()
	self._unLock = true
	self._isDrag = false
	self._isOtherDrag = false
	self._isPreComp = false
	self._skillPos = 0
	self._skillInfo = {}
	self._tokenData = {}
	self._unLockText = nil
	self._clickAddCall = nil

	self:setScale(0.9)
	self:addClickListener(handler(self, self._onClick))
	self:addEventListener(fgui.UIEventType.RollOver, handler(self, self._onRollOver))
	self:addEventListener(fgui.UIEventType.RollOut, handler(self, self._onRollOut))
end

function FormationSkillBtn:setSkillPos(arg_2_1)
	self._skillPos = arg_2_1
end

function FormationSkillBtn:getSkillPos()
	return self._skillPos
end

function FormationSkillBtn:getDragParam()
	if self._tokenData and self._tokenData.getAdvanceId then
		return self._tokenData:getAdvanceId()
	else
		return 0
	end
end

function FormationSkillBtn:updateFormatUnlock(arg_5_1)
	self._unLock = false

	self.m_stateController:setSelectedIndex(var_0_2.CTRL_FORMAT_UNLV)

	self._unLockText = g.core.lang:get(202514, {
		level = arg_5_1
	})
end

function FormationSkillBtn:updateTokenFormatIcon(arg_6_1, arg_6_2)
	self._isPreComp = arg_6_2 == true

	if not arg_6_2 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				pos = self._skillPos
			}
		})
	end

	self._tokenData = arg_6_1

	if not arg_6_1 or not next(arg_6_1) then
		self.m_stateController:setSelectedIndex(var_0_2.CTRL_FORMAT_TODO)
		g.core.utils.Action.playBlinkAction(self.m_addPic, 1, 0)

		return
	end

	self.m_stateController:setSelectedIndex(var_0_2.CTRL_FORMAT_DONE)

	local var_6_0 = self._tokenData:getSkillId()

	self._skillInfo = var_0_1.uniteTokenData:getTokenBaseInfo(var_6_0).skillInfo

	self.m_skillIcon:updateIcon({
		skillId = var_6_0
	})
end

function FormationSkillBtn:onDragStart()
	self._isDrag = true

	self.m_skillIcon:setAlpha(0.5)
end

function FormationSkillBtn:onDragEnd()
	self.m_skillIcon:setAlpha(1)
	self:newScheduleOnce(handler(self, function()
		self._isDrag = false
	end), 0.03)
end

function FormationSkillBtn:_onClick()
	if not self._isDrag and self._unLock then
		if self._tokenData and next(self._tokenData) and not self._isPreComp then
			g.core.module.ModuleManager:pushPopup(UniteTokenSkillPop.new(self._skillInfo, self._tokenData, self.m_isOtherController:getSelectedIndex() == 1), {
				touchDisappear = true
			})
		elseif not self._isOther and self._clickAddCall then
			self._clickAddCall(self._skillPos)
		end
	elseif not self._isDrag and not self._unLock and self._unLockText and not self._isOther then
		g.core.module.ModuleManager:tip(self._unLockText)
	end
end

function FormationSkillBtn:setClickAddCall(arg_11_1)
	self._clickAddCall = arg_11_1
end

function FormationSkillBtn:_onRollOut()
	self:setScale(0.9)
end

function FormationSkillBtn:_onRollOver()
	if not self._isDrag and not self._isOther then
		self:setScale(0.9900000000000001)
	end
end

function FormationSkillBtn:setIsOtherStyle()
	self._isOther = true

	self.m_isOtherController:setSelectedIndex(1)
	self.m_redPointComp:setId(0)
	self.m_redPointComp:setVisible(false)
end

return FormationSkillBtn
