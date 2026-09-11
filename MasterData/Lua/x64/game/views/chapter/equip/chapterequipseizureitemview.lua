ChapterChallengeItemWithCD = import("game.views.chapter.challenge.ChapterChallengeItemWithCD")

local ChapterEquipSeizureItemView = class("ChapterEquipSeizureItemView", ChapterChallengeItemWithCD)

function ChapterEquipSeizureItemView:GetLostTime()
	return EquipSeizureData:NextRefreshTimestamp()
end

function ChapterEquipSeizureItemView:ClickItem(arg_2_1)
	local var_2_0

	if self:CheckLock() then
		do return end

		var_2_0 = {}
	end

	var_2_0.chapterID = ChapterClientCfg[arg_2_1].chapter_list[1]

	JumpTools.OpenPageByJump("/equipSeizure", var_2_0)
end

return ChapterEquipSeizureItemView
