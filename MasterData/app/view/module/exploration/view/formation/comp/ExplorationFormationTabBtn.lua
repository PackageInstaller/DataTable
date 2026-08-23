local ExplorationFormationTabBtn = class("ExplorationFormationTabBtn", require("app.fairyGUI.exploration.UI_ExplorationFormationTabBtn"))

function ExplorationFormationTabBtn:ctor()
	self._idx = -1
	self._btnSpine = nil
	self._movingSpine = nil
	self._movingName = ""
	self._arrowSpine = nil
end

function ExplorationFormationTabBtn:updateComp(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	if arg_2_1.title then
		self:setTitle(arg_2_1.title)
	end

	if arg_2_1.process then
		if arg_2_1.process == 1 then
			self.m_isProcessFullController:setSelectedIndex(1)
		else
			self.m_isProcessFullController:setSelectedIndex(0)
			self.m_percentTxt:setText(string.format("%.0f%%", arg_2_1.process * 100))
		end
	end

	if arg_2_1.idx then
		self.m_teamIndexText:setText(g.core.lang:get(500050 + arg_2_1.idx))
		self:setTitle(g.core.lang:get(500142, {
			num = g.core.lang:get(100 + arg_2_1.idx)
		}))
		self.m_teamIndexNumText:setText(string.format("%02d", arg_2_1.idx))
	end

	if arg_2_1.idx and (not self._mulIndex or arg_2_1.idx ~= self._mulIndex) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				formationIndex = arg_2_1.idx
			}
		})
	end

	self._mulIndex = arg_2_1.idx
end

function ExplorationFormationTabBtn:playBtnEffect()
	if not self._btnSpine then
		self._btnSpine = self.m_effectNode:addEffectSpine({
			anim = "play",
			name = "eff_ui_fogNightmare_btn",
			isLoop = false
		})
	else
		self._btnSpine:setAnimation(0, "play", false)
	end

	self.m_effectNode:setVisible(true)
end

function ExplorationFormationTabBtn:closeBtnEffect()
	self.m_effectNode:setVisible(false)
end

return ExplorationFormationTabBtn
