local var_0_0 = class("SectionSelectHeroBuffView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.emptyController_ = arg_1_0.controllerEx_:GetController("state01")
	arg_1_0.buffItemList_ = {}

	SetActive(arg_1_0.gameObject_, true)
end

function var_0_0.OnEnter(arg_2_0)
	return
end

function var_0_0.OnExit(arg_3_0)
	return
end

function var_0_0.Dispose(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.buffItemList_) do
		iter_4_1:Dispose()
	end

	arg_4_0.buffItemList_ = nil

	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("sequentialBattleBuffInfo", {
			buffInfoActivityID = arg_5_0.activityID_,
			stageID = arg_5_0.stageID_
		})
	end)
end

function var_0_0.SetProxy(arg_7_0, arg_7_1)
	arg_7_0.sectionProxy_ = arg_7_1
	arg_7_0.activityID_ = arg_7_0.sectionProxy_.activityID
	arg_7_0.stageID_ = arg_7_0.sectionProxy_.stageID
end

function var_0_0.Refresh(arg_8_0)
	local var_8_0 = table.keyof(SequentialBattleChapterCfg[arg_8_0.activityID_].stage_id, arg_8_0.stageID_)

	arg_8_0.enabledBuff_ = SequentialBattleTools.GetEnabledBuff(arg_8_0.activityID_, var_8_0)

	for iter_8_0 = 1, #arg_8_0.enabledBuff_ do
		arg_8_0.buffItemList_[iter_8_0] = arg_8_0.buffItemList_[iter_8_0] or SectionSelectHeroBuffItem.New(arg_8_0.buffItem_, arg_8_0.buffParent_)

		arg_8_0.buffItemList_[iter_8_0]:SetData(arg_8_0.enabledBuff_[iter_8_0])
	end

	for iter_8_1 = #arg_8_0.enabledBuff_ + 1, #arg_8_0.buffItemList_ do
		arg_8_0.buffItemList_[iter_8_1]:Show(false)
	end
end

return var_0_0
