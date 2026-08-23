local KnightVoiceCommon = require("app.view.module.knight.common.KnightVoiceCommon")
local GuideDialogComp = class("GuideDialogComp", require("app.fairyGUI.guide.UI_GuideDialogComp"))

function GuideDialogComp:updateView(arg_1_1, arg_1_2)
	self._voice = arg_1_2

	local var_1_0 = g.core.config.guide_text_info.fetch(arg_1_1.dialogId)

	self.m_guideDescTxt:setText((var_1_0 or nil) and (var_1_0.text or arg_1_1.dialogId))

	if arg_1_1.dialogRevert then
		self.m_revertController:setSelectedIndex(1)
	end

	self.m_enterTransition:play(handler(self, self._onEnterActionFinish))
end

function GuideDialogComp:_onEnterActionFinish()
	if self._voice and not g.core.const.ConstMgr.BASE_CONST.MUTE_STORY_AND_GUIDE_SOUND then
		KnightVoiceCommon.playVoice({
			voiceName = "Vo_500070_guide" .. self._voice
		})
	end
end

function GuideDialogComp:onUnload()
	if not g.core.model.User.storyData:isInStory() then
		KnightVoiceCommon.stopVoice()
	end
end

function GuideDialogComp:updateText(arg_4_1)
	self.m_guideDescTxt:setText(arg_4_1)
	self.m_enterTransition:play()
end

return GuideDialogComp
