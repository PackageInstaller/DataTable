local TowerHardTabBtn = class("TowerHardTabBtn", require("app.fairyGUI.tower.UI_TowerHardTabBtn"))

function TowerHardTabBtn:ctor()
	return
end

function TowerHardTabBtn:updateComp(arg_2_1)
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
				formationType = arg_2_1.stageType,
				formationIndex = arg_2_1.idx,
				group = arg_2_1.group
			}
		})
	end

	self._mulIndex = arg_2_1.idx
end

function TowerHardTabBtn:playBtnEffect()
	if not self._spine or tolua.isnull(self._spine) then
		self._spine = self.m_effectNode:addEffectSpine({
			anim = "play",
			name = "eff_ui_fogNightmare_btn",
			isLoop = false
		})
	else
		self._spine:setAnimation(0, "play", false)
	end

	self.m_effectNode:setVisible(true)
end

function TowerHardTabBtn:closeBtnEffect()
	self.m_effectNode:setVisible(false)
end

function TowerHardTabBtn:onLoad()
	return
end

function TowerHardTabBtn:onUnload()
	return
end

return TowerHardTabBtn
