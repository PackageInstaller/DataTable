local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local LineUpArtifactBtn = class("LineUpArtifactBtn", require("app.fairyGUI.lineUp.UI_LineUpArtifactBtn"))

function LineUpArtifactBtn:ctor(arg_1_1)
	self._effectNode = nil
end

function LineUpArtifactBtn:updateArtifactEntranceBtn(arg_2_1, arg_2_2, arg_2_3)
	self.m_isWearController:setSelectedIndex(arg_2_1 and 1 or 0)

	if self._effectNode then
		self._effectNode:removeFromParent()

		self._effectNode = nil
	end

	if arg_2_1 then
		self.m_redPointComp:setId(243)
		self.m_starComp:initStar({
			gap = -2,
			index = 4,
			style = 2,
			max = arg_2_1:getMaxStar(),
			num = arg_2_1:getStar()
		})
		self.m_levelTxt:setText("Lv." .. arg_2_1:getLevel())
		self:setIcon((g.core.common.Path:getArtifactEntranceIcon(arg_2_1:getCfg().res_id)))
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				pos = arg_2_3,
				advId = arg_2_1:getAdvanceId()
			}
		})
		self:_playAnim(arg_2_2)
	else
		self:setIcon("")
		self.m_redPointComp:setId(248)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				pos = arg_2_3
			}
		})
	end
end

function LineUpArtifactBtn:_playAnim(arg_3_1)
	if self.m_enterTransition then
		self.m_enterTransition:play()
	end

	if arg_3_1 then
		self._effectNode = self.m_effectComp:addEffectSpine({
			name = "eff_ui_artifact_kuang",
			anim = "play",
			isLoop = true
		})
	end
end

return LineUpArtifactBtn
