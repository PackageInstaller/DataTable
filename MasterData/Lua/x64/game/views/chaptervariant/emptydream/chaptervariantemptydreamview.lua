ChapterVariantBaseView = import("game.views.chapterVariant.base.ChapterVariantBaseView")

local ChapterVariantEmptyDreamView = class("ChapterVariantEmptyDreamView", ChapterVariantBaseView)

function ChapterVariantEmptyDreamView:Init()
	ChapterVariantEmptyDreamView.super.Init(self)

	self.skuldBtnController_ = ControllerUtil.GetController(self.skuldbtn_.transform, "isbreach")
end

function ChapterVariantEmptyDreamView:OnEnter()
	ChapterVariantEmptyDreamView.super.OnEnter(self)
	SetActive(self.gameObject_, not self.isLock_)
	SetActive(self.skuldbtn_.gameObject, SkuldTravelData:GetSkuldTravelIsOpen())
	self.skuldBtnController_:SetSelectedState(SkuldTravelData:GetSkuldBtnIsBreach() and "true" or "false")
	manager.redPoint:bindUIandKey(self.skuldbtn_.transform, RedPointConst.TRAVEL_SKULD_BATTLE .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
end

function ChapterVariantEmptyDreamView:OnExit()
	ChapterVariantEmptyDreamView.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.skuldbtn_.transform, RedPointConst.TRAVEL_SKULD_BATTLE .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
end

function ChapterVariantEmptyDreamView:GetItemClass()
	return ChapterVariantEmptyDreamItem
end

function ChapterVariantEmptyDreamView:AddListeners()
	self:AddBtnListener(self.skuldbtn_, nil, function()
		if SkuldTravelData:GetSkuldTravelIsOpen() then
			JumpTools.GoToSystem("/skuldTravelView")
		else
			local var_6_0, var_6_1 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, GameSetting.travel_skuld_unlock.value[1])

			ShowTips(string.format(GetTips("MISSION_PROGRESS_UNLOCK_EX"), getChapterDifficulty(GameSetting.travel_skuld_unlock.value[1]), var_6_0 .. "-" .. var_6_1))
		end
	end)
end

return ChapterVariantEmptyDreamView
