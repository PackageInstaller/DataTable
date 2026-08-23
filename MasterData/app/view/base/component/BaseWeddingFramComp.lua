local var_0_0 = g.core.model.User.weddingData
local BaseWeddingFramComp = class("BaseWeddingFramComp", require("app.fairyGUI.base_new.UI_BaseWeddingFrameComp"))

function BaseWeddingFramComp:ctor(arg_1_1)
	self._effect = nil
end

function BaseWeddingFramComp:updateCompByKnight(arg_2_1)
	if not arg_2_1 then
		self:setVisible(false)

		return
	end

	local var_2_0 = arg_2_1:getAdvanceId()

	if arg_2_1:isOwn() and var_0_0:isWeddingVowByKnightId(var_2_0) then
		self:setVisible(true)

		if not g.core.utils.Quality.needCloseUIAnime() then
			self:addWeddingFrameSpine()
		end

		self.m_isWeddingController:setSelectedIndex(1)
		self.m_weddingLoader:setURL(g.core.common.Path:getWeddingVowBagIcon())
		self.m_weddingLevelText:setText(var_0_0:getCurFavorInfo(var_2_0).level)
	else
		self.m_isWeddingController:setSelectedIndex(0)
		self:setVisible(false)
	end
end

function BaseWeddingFramComp:addWeddingFrameSpine()
	self._effect = self._effect or self.m_effectNode:addEffectSpine({
		anim = "play",
		name = "eff_ui_wedding_frameBig",
		remove = false,
		isLoop = true
	})
end

return BaseWeddingFramComp
