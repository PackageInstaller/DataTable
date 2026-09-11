local StageAshMomoTalkView = class("StageAshMomoTalkView", (import("game.views.stageArchive.momotalk.StageArchiveMomoTalkView")))

function StageAshMomoTalkView:UIName()
	return "Widget/System/Activity_EkChuah/EkChuah_BattleUI/EkChuah_NPCChatPopUI"
end

function StageAshMomoTalkView:OnEnter()
	StageAshMomoTalkView.super.OnEnter(self)

	self.headIcon_.sprite = getSpriteViaConfig("StoryHeadIcon", StageArchivesCollectMomoTalkCfg[StageArchivesCollectMomoTalkCfg.get_id_list_by_momotalk_plot_id[self.customID][1]].speaker_icon)
	self.bubbleTxt_.text = GetTips("ASH_MOMOTALK_OCCUR_TIP")

	if self.params_.isSelectEnter then
		SetActive(self.enterGo_, true)
	end
end

function StageAshMomoTalkView:PlayTalk()
	self:InitPlayTalk()

	if self.params_.isSkip then
		self:PlayTalkImmediately()
	else
		self:PlayTalkByTime()
	end
end

function StageAshMomoTalkView:OnExitInput()
	self:Back()

	return true
end

return StageAshMomoTalkView
