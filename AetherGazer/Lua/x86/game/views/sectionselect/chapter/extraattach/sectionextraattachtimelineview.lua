SectionExtraAttachBaseView = import("game.views.sectionSelect.chapter.extraAttach.SectionExtraAttachBaseView")

local var_0_0 = class("SectionExtraAttachTimelineView", SectionExtraAttachBaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.parent_ = arg_1_1
	arg_1_0.gameObject_ = Object.Instantiate(Asset.Load(arg_1_2), arg_1_3.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.playableDirector_ = arg_1_0.gameObject_:GetComponent(typeof(PlayableDirector))
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0:AddMoveFollowTimer()
	SetActive(arg_2_0.gameObject_, true)
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0:StopMoveFollowTimer()
	SetActive(arg_3_0.gameObject_, false)
end

function var_0_0.AddMoveFollowTimer(arg_4_0)
	local var_4_0 = arg_4_0.parent_.chapterID_
	local var_4_1 = ChapterCfg[var_4_0].section_id_list[#ChapterCfg[var_4_0].section_id_list]
	local var_4_2 = BattleChapterStageCfg[var_4_1].position[1] - arg_4_0.parent_.viewportRect_.rect.width + arg_4_0.parent_.viewportRect_.rect.width / 4

	arg_4_0:Play(var_4_2)

	arg_4_0.moveFollowTimer_ = FrameTimer.New(function()
		arg_4_0:Play(var_4_2)
	end, 1, -1)

	arg_4_0.moveFollowTimer_:Start()
end

function var_0_0.Play(arg_6_0, arg_6_1)
	local var_6_0 = -1 * arg_6_0.parent_.contentRect_.localPosition.x / arg_6_1
	local var_6_1 = arg_6_0.parent_.chapterID_
	local var_6_2 = ChapterCfg[var_6_1]
	local var_6_3 = ChapterTools.GetUnclearStageCnt(var_6_1)

	if var_6_0 < 0 then
		var_6_0 = 0
	elseif var_6_0 > 1 then
		var_6_0 = 1
	end

	local var_6_4 = 1
	local var_6_5 = #var_6_2.section_id_list - var_6_3

	if type(var_6_2.unlock_scroll_rate) == "table" then
		for iter_6_0, iter_6_1 in ipairs(var_6_2.unlock_scroll_rate) do
			if var_6_5 < iter_6_1[1] then
				var_6_4 = iter_6_1[2]

				break
			end
		end
	end

	if var_6_4 < var_6_0 then
		var_6_0 = var_6_4
	end

	arg_6_0.playableDirector_.time = arg_6_0.playableDirector_.duration * var_6_0

	arg_6_0.playableDirector_:Evaluate()
end

function var_0_0.StopMoveFollowTimer(arg_7_0)
	if arg_7_0.moveFollowTimer_ then
		arg_7_0.moveFollowTimer_:Stop()

		arg_7_0.moveFollowTimer_ = nil
	end
end

return var_0_0
