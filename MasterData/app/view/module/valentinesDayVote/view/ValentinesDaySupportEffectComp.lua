local ValentinesDaySupportEffectComp = class("ValentinesDaySupportEffectComp", require("app.fairyGUI.valentinesDayVote.UI_ValentinesDaySupportEffectComp"))

function ValentinesDaySupportEffectComp:ctor()
	self._ICON_URL = {
		"ui://valentinesDayVote/pic_vote_flower1",
		"ui://valentinesDayVote/pic_vote_flower2",
		"ui://valentinesDayVote/pic_vote_flower3"
	}
end

function ValentinesDaySupportEffectComp:update(arg_2_1)
	return
end

function ValentinesDaySupportEffectComp:onLoad()
	return
end

function ValentinesDaySupportEffectComp:onUnload()
	return
end

function ValentinesDaySupportEffectComp:initView()
	for iter_5_0 = 1, 10 do
		if self["m_icon" .. iter_5_0] then
			self["m_icon" .. iter_5_0]:setURL(self._ICON_URL[math.random(3)])
		end
	end
end

function ValentinesDaySupportEffectComp:playEffect()
	self.m_enterTransition:play(handler(self, function()
		self:dispatchCompEvent("supportEffect_finish")
	end))
end

function ValentinesDaySupportEffectComp:stopEffect()
	if self.m_enterTransition:isPlaying() then
		self.m_enterTransition:stop()
	end
end

return ValentinesDaySupportEffectComp
