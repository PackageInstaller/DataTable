local var_0_0 = g.core.sound.SoundManager
local var_0_1 = g.core.common.ServerTime
local TypeWriter = require("app.view.common.TypeWriter")
local WeddingVowAsmrComp = class("WeddingVowAsmrComp", require("app.fairyGUI.wedding.UI_WeddingVowAsmrComp"))

function WeddingVowAsmrComp:ctor()
	self._knightStruct = nil
	self._asmrLineArr = {}
	self._asmrIndex = 1
	self._isAsmrEnd = false
	self._typeWriter = nil
	self._curLineStartTime = 0

	self.m_touchBg:addClickListener(handler(self, self._onClickPlay))
end

function WeddingVowAsmrComp:initAsmr(arg_2_1)
	self.m_enterTransition:play()
	self.m_bgLoader:setURL("bg/wedding/bg_asmr1.jpg")

	self._knightStruct = arg_2_1

	local var_2_0 = self._knightStruct:getVoiceResInfo()
	local var_2_2

	::label_2_0::

	if var_2_0["asmr_lines_" .. 1] and var_2_0["asmr_lines_" .. 1] ~= "" then
		repeat
			table.insert(self._asmrLineArr, {
				sound = var_2_0["asmr_sound_" .. 1],
				line = var_2_0["asmr_lines_" .. 1],
				time = var_2_0["asmr_lines_time_" .. 1]
			})

			goto label_2_0
		until true

		var_2_2 = {}
	end

	var_2_2.name = self._knightStruct:getName()

	self.m_asmrTxt:setText(g.core.lang:get(412031, var_2_2))
	self.m_eff:addEffectSpine({
		anim = "play",
		name = "eff_ui_wedding_bg",
		isLoop = false
	})
end

function WeddingVowAsmrComp:_playAsmr()
	self.m_bgLoader:setURL("bg/wedding/bg_asmr2.jpg")
	self.m_dialogComp:setVisible(true)
	self.m_effectSpeaker:addEffectSpine({
		anim = "play",
		name = "eff_ui_wedding_audio",
		isLoop = true
	})
	self:_showNextAsmrLine()
end

function WeddingVowAsmrComp:_showNextAsmrLine()
	if self._asmrLineArr[self._asmrIndex] then
		var_0_0:playSound(self._asmrLineArr[self._asmrIndex].sound)
		self:_updateAsmrView(self._asmrLineArr[self._asmrIndex])
	else
		self._isAsmrEnd = true

		self:_onAsmrEnd()
	end
end

function WeddingVowAsmrComp:_updateAsmrView(arg_5_1)
	self._typeWriter = TypeWriter.new({
		label = self.m_dialogTxt,
		str = arg_5_1.line,
		callback = handler(self, self._asmrWriterEnd)
	})
	self._curLineStartTime = var_0_1:getTime()

	self._typeWriter:start()
end

function WeddingVowAsmrComp:_asmrWriterEnd()
	self._asmrIndex = self._asmrIndex + 1

	self:newScheduleOnce(handler(self, self._showNextAsmrLine), (math.max(0, self._asmrLineArr[self._asmrIndex].time - (var_0_1:getTime() - self._curLineStartTime))))
end

function WeddingVowAsmrComp:_onAsmrEnd()
	if self._isAsmrEnd then
		self:dispatchCompEvent("ASMR_PLAY_END")
	end
end

function WeddingVowAsmrComp:_onClickPlay()
	self.m_touchBg:setVisible(false)
	self.m_asmrTipGroup:setVisible(false)
	self.m_continueGroup:setVisible(false)
	self:_playAsmr()
end

return WeddingVowAsmrComp
