local ArtifactSpiritProgComp = class("ArtifactSpiritProgComp", require("app.fairyGUI.artifact.UI_ArtifactSpiritProgComp"))

function ArtifactSpiritProgComp:ctor()
	self:addClickListener(handler(self, self._onTipsBtnClick))
	self.m_advanceTransition:setHook("cut", handler(self, self.updateProgView))
end

function ArtifactSpiritProgComp:setArtifactStruct(arg_2_1)
	self._struct = arg_2_1

	if self._struct:isNowSpiritStageUp() then
		self.m_advanceTransition:play()
		self.m_effHolder:addEffectSpine({
			remove = true,
			name = "eff_ui_artifact_advance",
			isLoop = false
		})
	else
		self:updateProgView()
	end
end

function ArtifactSpiritProgComp:updateProgView()
	if self._struct then
		self.m_stageNumTxt:setText(self._struct:getSpiritStage())
		self.m_curLvTxt:setText(g.core.lang:get(120) .. self._struct:getSpiritLevel())
		self.m_fullLvTxt:setText("/" .. self._struct:getSpiritStageMaxLevel())
	end
end

function ArtifactSpiritProgComp:_onTipsBtnClick()
	if self._struct then
		self.m_curDescTxt:setText(g.core.lang:get(205571, {
			stage = self._struct:getSpiritStage(),
			maxStage = self._struct:getMaxSpiritStage(),
			level = self._struct:getSpiritStageMaxLevel()
		}))
		self.m_tipGroup:setVisible(true)
	end
end

function ArtifactSpiritProgComp:gameTouchFinish()
	self.m_tipGroup:setVisible(false)
end

return ArtifactSpiritProgComp
