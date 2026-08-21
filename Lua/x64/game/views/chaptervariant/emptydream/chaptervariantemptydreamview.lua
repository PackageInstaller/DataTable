ChapterVariantBaseView = import("game.views.chapterVariant.base.ChapterVariantBaseView")

local var_0_0 = class("ChapterVariantEmptyDreamView", ChapterVariantBaseView)

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	arg_1_0.skuldBtnController_ = ControllerUtil.GetController(arg_1_0.skuldbtn_.transform, "isbreach")
end

function var_0_0.OnEnter(arg_2_0)
	var_0_0.super.OnEnter(arg_2_0)
	SetActive(arg_2_0.gameObject_, not arg_2_0.isLock_)
	SetActive(arg_2_0.skuldbtn_.gameObject, SkuldTravelData:GetSkuldTravelIsOpen())
	arg_2_0.skuldBtnController_:SetSelectedState(SkuldTravelData:GetSkuldBtnIsBreach() and "true" or "false")

	local var_2_0 = RedPointConst.TRAVEL_SKULD_BATTLE .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL

	manager.redPoint:bindUIandKey(arg_2_0.skuldbtn_.transform, var_2_0)
end

function var_0_0.OnExit(arg_3_0)
	var_0_0.super.OnExit(arg_3_0)

	local var_3_0 = RedPointConst.TRAVEL_SKULD_BATTLE .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL

	manager.redPoint:unbindUIandKey(arg_3_0.skuldbtn_.transform, var_3_0)
end

function var_0_0.GetItemClass(arg_4_0)
	return ChapterVariantEmptyDreamItem
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.skuldbtn_, nil, function()
		if SkuldTravelData:GetSkuldTravelIsOpen() then
			JumpTools.GoToSystem("/skuldTravelView")
		else
			local var_6_0 = GameSetting.travel_skuld_unlock.value[1]
			local var_6_1 = getChapterDifficulty(var_6_0)
			local var_6_2, var_6_3 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, var_6_0)

			ShowTips(string.format(GetTips("MISSION_PROGRESS_UNLOCK_EX"), var_6_1, var_6_2 .. "-" .. var_6_3))
		end
	end)
end

return var_0_0
