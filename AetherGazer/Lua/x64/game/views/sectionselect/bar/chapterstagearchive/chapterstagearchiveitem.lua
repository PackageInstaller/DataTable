local var_0_0 = class("ChapterStageArchiveItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.lockController_ = ControllerUtil.GetController(arg_1_0.transform_, "lock")
end

function var_0_0.OnEnter(arg_2_0)
	return
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0:UnBindRedPoint(arg_3_0.archiveID_)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
	Object.Destroy(arg_4_0.gameObject_)

	arg_4_0.transform_ = nil
	arg_4_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.button_, nil, function()
		if arg_5_0.isLock_ then
			local var_6_0 = BattleStageTools.GetStageCfg(ChapterCfg[arg_5_0.chapterID_].type, arg_5_0.stageID_)

			ShowTips(string.format(GetTips("ACTIVITY_RACE_UNLOCK"), var_6_0.name))

			return
		end

		manager.notify:Invoke(CHAPTER_SCROLL_STOP)
		BattleStageAction.ClickChapterArchive(arg_5_0.archiveID_)
		JumpTools.OpenPageByJump("chapterStageArchiveInfo", {
			archiveID = arg_5_0.archiveID_
		})

		arg_5_0.isLock_ = false

		arg_5_0:RefreshLockState()
	end)
end

function var_0_0.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0:UnBindRedPoint(arg_8_0.archiveID_)
	arg_8_0:BindRedPoint(arg_8_3)

	arg_8_0.archiveID_ = arg_8_3
	arg_8_0.chapterID_ = arg_8_1
	arg_8_0.stageID_ = arg_8_2
	arg_8_0.isLock_ = BattleStageData:GetStageData()[arg_8_2].clear_times <= 0

	arg_8_0:RefreshLockState()

	local var_8_0 = StageArchiveCfg[arg_8_3].position

	arg_8_0.transform_.localPosition = Vector3(var_8_0[1], var_8_0[2], 0)

	local var_8_1 = StageArchiveCfg[arg_8_3]

	arg_8_0.titleText_.text = GetI18NText(var_8_1.name)

	arg_8_0:Show(true)
end

function var_0_0.RefreshLockState(arg_9_0)
	arg_9_0.lockController_:SetSelectedState(tostring(arg_9_0.isLock_))
end

function var_0_0.BindRedPoint(arg_10_0, arg_10_1)
	manager.redPoint:bindUIandKey(arg_10_0.redPointTf_, string.format("%s_%s", RedPointConst.COMBAT_CHAPTER_ARCHIVE, arg_10_1))
end

function var_0_0.UnBindRedPoint(arg_11_0, arg_11_1)
	if arg_11_1 then
		manager.redPoint:unbindUIandKey(arg_11_0.redPointTf_, string.format("%s_%s", RedPointConst.COMBAT_CHAPTER_ARCHIVE, arg_11_1))
	end
end

return var_0_0
