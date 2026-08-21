ChapterChallengeItemWithCD = import("game.views.chapter.challenge.ChapterChallengeItemWithCD")

local var_0_0 = class("ChapterEquipSeizureItemView", ChapterChallengeItemWithCD)

function var_0_0.GetLostTime(arg_1_0)
	return EquipSeizureData:NextRefreshTimestamp()
end

function var_0_0.ClickItem(arg_2_0, arg_2_1)
	if arg_2_0:CheckLock() then
		return
	end

	local var_2_0 = ChapterClientCfg[arg_2_1].chapter_list[1]

	JumpTools.OpenPageByJump("/equipSeizure", {
		chapterID = var_2_0
	})
end

return var_0_0
