local PubgMiniMapItemComp = class("PubgMiniMapItemComp", require("app.fairyGUI.pubg.UI_PubgMiniMapItemComp"))

function PubgMiniMapItemComp:playShowAirDrop()
	self._airDropEff = self._airDropEff or self.m_effAirDrop:addEffectSpine({
		name = "eff_ui_pubg_airdropmapglow",
		isLoop = false,
		remove = false,
		scale = 1,
		eventHandler = handler(self, self._onDropEffEvent)
	})

	if not self._isPlayShow then
		if self._airDropEff then
			self._airDropEff:setAnimation(0, "drop", false)
		end

		self._isPlayShow = true
	else
		self:playLoopAirDrop()
	end

	self.m_airDropTransition:play()
end

function PubgMiniMapItemComp:_onDropEffEvent(arg_2_1)
	if arg_2_1.type == "complete" then
		self:playLoopAirDrop()
	end
end

function PubgMiniMapItemComp:playLoopAirDrop()
	self._airDropEff = self._airDropEff or self.m_effAirDrop:addEffectSpine({
		name = "eff_ui_pubg_airdropmapglow",
		isLoop = false,
		remove = false,
		scale = 1,
		eventHandler = handler(self, self._onDropEffEvent)
	})

	if not self._isPlayLoop then
		if self._airDropEff then
			self._airDropEff:setAnimation(0, "loop", true)
		end

		self.m_airDropLoopTransition:play()

		self._isPlayLoop = true
	end
end

function PubgMiniMapItemComp:resetComp()
	self._isPlayShow = false
	self._isPlayLoop = false

	if self._airDropEff then
		self.m_effAirDrop:removeAllEffect()

		self._airDropEff = nil
	end
end

return PubgMiniMapItemComp
