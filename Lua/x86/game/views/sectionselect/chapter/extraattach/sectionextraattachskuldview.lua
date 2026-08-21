SectionExtraAttachBaseView = import("game.views.sectionSelect.chapter.extraAttach.SectionExtraAttachBaseView")

local var_0_0 = class("SectionSkuldExtraAttachView", SectionExtraAttachBaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.parent_ = arg_1_1
	arg_1_0.gameObject_ = Object.Instantiate(Asset.Load(arg_1_2), arg_1_3.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0:AddMoveFollowTimer()
	SetActive(arg_2_0.gameObject_, true)
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0:StopMoveFollowTimer()

	arg_3_0.imageFlag_ = nil

	arg_3_0:RemoveTween()
	SetActive(arg_3_0.gameObject_, false)
end

function var_0_0.AddListeners(arg_4_0)
	return
end

function var_0_0.RefreshUI(arg_5_0)
	return
end

function var_0_0.CheckSkuldBtn(arg_6_0)
	return
end

function var_0_0.AddMoveFollowTimer(arg_7_0)
	local var_7_0 = arg_7_0.parent_.chapterID_
	local var_7_1 = ChapterCfg[var_7_0].section_id_list[#ChapterCfg[var_7_0].section_id_list]
	local var_7_2 = BattleChapterStageCfg[var_7_1].position[1] - arg_7_0.parent_.viewportRect_.rect.width / 2
	local var_7_3 = ChapterCfg[var_7_0].max_width

	if var_7_3 == 0 then
		var_7_3 = (arg_7_0.parent_.bgTf_.rect.width - arg_7_0.parent_.viewportRect_.rect.width) / 2
	else
		var_7_3 = var_7_3 - ChapterCfg[var_7_0].max_width / 2
	end

	local var_7_4 = arg_7_0.parent_.contentRect_.localPosition.x * var_7_3 / var_7_2

	arg_7_0.imagePanelTf_.localPosition = Vector3(var_7_4, 0, 0)

	arg_7_0:StopMoveFollowTimer()

	arg_7_0.moveFollowTimer_ = FrameTimer.New(function()
		local var_8_0 = arg_7_0.parent_.contentRect_.localPosition.x * var_7_3 / var_7_2

		arg_7_0.imagePanelTf_.localPosition = Vector3(var_8_0, 0, 0)

		arg_7_0:CheckImage()
	end, 1, -1)

	arg_7_0.moveFollowTimer_:Start()
end

function var_0_0.StopMoveFollowTimer(arg_9_0)
	if arg_9_0.moveFollowTimer_ then
		arg_9_0.moveFollowTimer_:Stop()

		arg_9_0.moveFollowTimer_ = nil
	end
end

function var_0_0.CheckImage(arg_10_0)
	local var_10_0 = arg_10_0.parent_.chapterID_
	local var_10_1 = ChapterCfg[var_10_0].switch_bg_index

	if var_10_1 == 0 then
		return
	end

	local var_10_2 = ChapterCfg[var_10_0].section_id_list[var_10_1]
	local var_10_3 = ChapterCfg[var_10_0].section_id_list[var_10_1 - 1]
	local var_10_4 = ChapterCfg[var_10_0].section_id_list[var_10_1 + 1]
	local var_10_5 = arg_10_0.parent_.viewportRect_.rect.width / 2

	if arg_10_0.parent_.contentRect_.localPosition.x * -1 < BattleChapterStageCfg[var_10_3].position[1] - var_10_5 and arg_10_0.imageFlag_ ~= 1 then
		arg_10_0.imageFlag_ = 1

		arg_10_0:SwitchMiddleGB(1)
	elseif arg_10_0.parent_.contentRect_.localPosition.x * -1 > BattleChapterStageCfg[var_10_4].position[1] - var_10_5 and arg_10_0.imageFlag_ ~= 2 then
		arg_10_0.imageFlag_ = 2

		arg_10_0:SwitchMiddleGB(2)
	end
end

function var_0_0.SwitchMiddleGB(arg_11_0, arg_11_1)
	if arg_11_0.imageFlag_ == nil then
		arg_11_0.bgCanvas1_.alpha = arg_11_1 ~= 1 and 1 or 0
		arg_11_0.bgCanvas2_.alpha = arg_11_1 == 1 and 1 or 0

		return
	end

	arg_11_0:RemoveTween()

	if arg_11_1 == 1 then
		arg_11_0.tween_ = LeanTween.value(arg_11_0.gameObject_, 1, 0, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_12_0)
			arg_11_0.bgCanvas2_.alpha = arg_12_0
			arg_11_0.bgCanvas1_.alpha = 1 - arg_12_0
		end)):setOnComplete(System.Action(function()
			arg_11_0.bgCanvas2_.alpha = 0

			arg_11_0:RemoveTween()
		end)):setEase(LeanTweenType.easeOutSine)
	else
		arg_11_0.tween_ = LeanTween.value(arg_11_0.gameObject_, 1, 0, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_14_0)
			arg_11_0.bgCanvas1_.alpha = arg_14_0
			arg_11_0.bgCanvas2_.alpha = 1 - arg_14_0
		end)):setOnComplete(System.Action(function()
			arg_11_0.bgCanvas1_.alpha = 0

			arg_11_0:RemoveTween()
		end)):setEase(LeanTweenType.easeOutSine)
	end
end

function var_0_0.RemoveTween(arg_16_0)
	if arg_16_0.tween_ then
		arg_16_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_16_0.tween_.id)

		arg_16_0.tween_ = nil
	end
end

return var_0_0
