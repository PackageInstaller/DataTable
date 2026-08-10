local var_0_0 = import("game.views.stageArchive.momotalk.StageArchiveMomoTalkView")
local var_0_1 = class("StageAshMomoTalkView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Activity_EkChuah/EkChuah_BattleUI/EkChuah_NPCChatPopUI"
end

function var_0_1.OnEnter(arg_2_0)
	var_0_1.super.OnEnter(arg_2_0)

	local var_2_0 = StageArchivesCollectMomoTalkCfg.get_id_list_by_momotalk_plot_id[arg_2_0.customID][1]

	arg_2_0.headIcon_.sprite = getSpriteViaConfig("StoryHeadIcon", StageArchivesCollectMomoTalkCfg[var_2_0].speaker_icon)
	arg_2_0.bubbleTxt_.text = GetTips("ASH_MOMOTALK_OCCUR_TIP")

	if arg_2_0.params_.isSelectEnter then
		SetActive(arg_2_0.enterGo_, true)
	end
end

function var_0_1.PlayTalk(arg_3_0)
	arg_3_0:InitPlayTalk()

	if arg_3_0.params_.isSkip then
		arg_3_0:PlayTalkImmediately()
	else
		arg_3_0:PlayTalkByTime()
	end
end

function var_0_1.OnExitInput(arg_4_0)
	arg_4_0:Back()

	return true
end

return var_0_1
