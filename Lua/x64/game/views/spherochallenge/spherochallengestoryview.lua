local var_0_0 = class("SPHeroChallengeStoryView", import("game.views.sectionSelect.SectionBaseView"))
local var_0_1 = 420

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.activityID_ = arg_1_2

	local var_1_0 = Asset.Load(arg_1_0:UIName())

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	var_0_0.super.Init(arg_1_0)

	arg_1_0.scrollMoveView_.viewportRect_.sizeDelta = Vector2(arg_1_0.scrollViewTrs.sizeDelta.x - var_0_1, arg_1_0.scrollMoveView_.viewportRect_.sizeDelta.y)
	arg_1_0.scrollMoveView_.viewportRect_.anchoredPosition = Vector2(var_0_1 + arg_1_0.scrollViewTrs.sizeDelta.x / 2, arg_1_0.scrollMoveView_.viewportRect_.anchoredPosition.y)
end

function var_0_0.OnEnter(arg_2_0)
	if arg_2_0.params_.stageID then
		arg_2_0.params_.isDetailJump = true
	end

	local var_2_0 = SPHeroChallengeData:GetCurActivityInfo()
	local var_2_1 = #var_2_0.storyFinStageList + 1

	if var_2_1 > #var_2_0.storyFinStageList then
		var_2_1 = #var_2_0.storyFinStageList
	end

	local var_2_2 = arg_2_0:GetCfgName().get_id_list_by_sub_type[SpHeroChallengeConst.BattleSubType.story][var_2_1]

	var_0_0.super.OnEnter(arg_2_0)

	if arg_2_0.params_.isDetailJump then
		local var_2_3

		if arg_2_0.params_.stageID then
			var_2_3 = arg_2_0.params_.stageID
		else
			var_2_3 = SPHeroChallengeTools:GetNextCanBattleStageID(SpHeroChallengeConst.ScheduleSubType.story)
		end

		for iter_2_0, iter_2_1 in pairs(arg_2_0.missionItem_) do
			if iter_2_1.stageID_ == var_2_3 then
				iter_2_1:OnClick()
			end
		end

		arg_2_0.params_.isDetailJump = nil
	end
end

function var_0_0.Show(arg_3_0, arg_3_1)
	SetActive(arg_3_0.gameObject_, arg_3_1)
end

function var_0_0.OnUpdate(arg_4_0)
	if arg_4_0:IsOpenSectionInfo() then
		arg_4_0.state = 1
	else
		arg_4_0.state = 2
	end

	var_0_0.super.OnUpdate(arg_4_0)
end

function var_0_0.RefreshUI(arg_5_0)
	var_0_0.super.RefreshUI(arg_5_0)
	arg_5_0:SwitchBG()
end

function var_0_0.OnExit(arg_6_0)
	if arg_6_0.state == 1 then
		arg_6_0.state = 2
	end

	var_0_0.super.OnExit(arg_6_0)
end

function var_0_0.Dispose(arg_7_0)
	if arg_7_0.gameObject_ then
		GameObject.Destroy(arg_7_0.gameObject_)

		arg_7_0.gameObject_ = nil
	end

	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.GetCfgName(arg_8_0)
	return BattleVerthandiExclusiveCfg
end

function var_0_0.GetSectionItemClass(arg_9_0)
	return SPHeroChallengeStroyItem
end

function var_0_0.IsOpenSectionInfo(arg_10_0)
	return arg_10_0:IsOpenRoute("spHeroChallengeSectionView")
end

function var_0_0.RefreshData(arg_11_0)
	arg_11_0.chapterID_ = SPHeroChallengeData.activityCfg[arg_11_0.activityID_].storyChapter
	arg_11_0.stageData_ = {}
	arg_11_0.stageList_ = ChapterCfg[arg_11_0.chapterID_].section_id_list

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.stageList_) do
		arg_11_0.stageData_[iter_11_1] = {
			id = arg_11_0.stageList_[iter_11_0]
		}
	end

	arg_11_0.oepnStageList_ = SPHeroChallengeTools:GetStoryOpenStageList(arg_11_0.chapterID_, arg_11_0:GetCfgName())
end

return var_0_0
