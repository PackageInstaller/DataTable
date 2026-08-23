local ThemeBioVoteChapterBuildComp = class("ThemeBioVoteChapterBuildComp", require("app.fairyGUI.themeBio.UI_ThemeBioVoteChapterBuildComp"))

function ThemeBioVoteChapterBuildComp:ctor()
	return
end

function ThemeBioVoteChapterBuildComp:update(arg_2_1)
	return
end

function ThemeBioVoteChapterBuildComp:onLoad()
	return
end

function ThemeBioVoteChapterBuildComp:onUnload()
	return
end

function ThemeBioVoteChapterBuildComp:playUnlockEffect()
	self.m_effChapter:addEffectSpine({
		anim = "play",
		remove = true,
		isLoop = false,
		name = "eff_ui_themeBioVote_unlockChapter" .. self.m_chapterController:getSelectedIndex() + 1
	})
end

return ThemeBioVoteChapterBuildComp
