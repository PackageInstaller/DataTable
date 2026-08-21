local var_0_0 = class("WhackMoleSectionInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_WhackMoleUI/SUWhackMoleInfoUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.itemList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.uiListGo_, MoleItem)
	arg_4_0.lockController_ = arg_4_0.lockCon_:GetController("lock")
	arg_4_0.scoreController_ = arg_4_0.controllerEx_:GetController("score")
	arg_4_0.stageTypeController_ = arg_4_0.controllerEx_:GetController("stageType")
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.battleBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(arg_5_0.activityID_) then
			return
		end

		arg_5_0:OnClickBtn()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:RefreshData()
	arg_7_0:RefreshUI()
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0.whackMoleID_ = nil
end

function var_0_0.OnUpdate(arg_9_0)
	if arg_9_0.whackMoleID_ == arg_9_0.params_.whackMoleID then
		return
	end

	arg_9_0:RefreshData()
	arg_9_0:RefreshUI()
end

function var_0_0.RefreshData(arg_10_0)
	arg_10_0.activityID_ = arg_10_0.params_.activityID
	arg_10_0.whackMoleID_ = arg_10_0.params_.whackMoleID
	arg_10_0.stageID_ = ActivityWhackMoleCfg[arg_10_0.whackMoleID_].stage_id
	arg_10_0.stageCfg_ = BattleWhackMoleStageCfg[arg_10_0.stageID_]
	arg_10_0.moleIDList_ = ActivityWhackMoleCfg[arg_10_0.whackMoleID_].mole_list
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0:RefreshStageInfo()
	arg_11_0:RefreshLock()
	arg_11_0:RefreshScore()
	arg_11_0.itemList_:StartScroll(#arg_11_0.moleIDList_)
end

function var_0_0.RefreshStageInfo(arg_12_0)
	arg_12_0.sectionName_.text = GetI18NText(arg_12_0.stageCfg_.name)
	arg_12_0.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, arg_12_0.stageCfg_.background_1))

	if ActivityWhackMoleCfg[arg_12_0.whackMoleID_].type == WhackMoleConst.STAGE_TYPE.INFINITY then
		local var_12_0 = ActivityWhackMoleCfg[arg_12_0.whackMoleID_].stage_id

		arg_12_0.stageDescText_.text = BattleWhackMoleStageCfg[var_12_0].tips

		arg_12_0.stageTypeController_:SetSelectedState("infinity")
	else
		arg_12_0.targetScoreText_.text = ActivityWhackMoleCfg[arg_12_0.whackMoleID_].target_point
		arg_12_0.limitTimeText_.text = ActivityWhackMoleCfg[arg_12_0.whackMoleID_].limit_time .. GetTips("SECOND")

		arg_12_0.stageTypeController_:SetSelectedState("normal")
	end
end

function var_0_0.RefreshLock(arg_13_0)
	local var_13_0 = WhackMoleTools.GetStageIsLock(arg_13_0.whackMoleID_)

	arg_13_0.lockController_:SetSelectedState(tostring(var_13_0))

	if var_13_0 then
		arg_13_0.lockTipsText_.text = GetTips("ACTIVITY_ZUMA_OPEN_FRONT")
	end
end

function var_0_0.RefreshScore(arg_14_0)
	if WhackMoleData:GetStageScore(arg_14_0.whackMoleID_) <= 0 then
		arg_14_0.scoreController_:SetSelectedState("off")
	else
		arg_14_0.scoreController_:SetSelectedState("on")

		arg_14_0.maxScoreText_.text = WhackMoleData:GetStageScore(arg_14_0.whackMoleID_)
	end
end

function var_0_0.IndexItem(arg_15_0, arg_15_1, arg_15_2)
	arg_15_2:SetData(arg_15_1, arg_15_0.moleIDList_[arg_15_1])
	arg_15_2:RegisterClick(function(arg_16_0)
		JumpTools.OpenPageByJump("whackMoleDesc", {
			idList = arg_15_0.moleIDList_,
			index = arg_16_0
		})
	end)
end

function var_0_0.OnClickBtn(arg_17_0)
	local var_17_0 = arg_17_0.whackMoleID_

	WhackMoleAction.LaunchBattle(var_17_0)
end

function var_0_0.Dispose(arg_18_0)
	var_0_0.super.Dispose(arg_18_0)
	arg_18_0.itemList_:Dispose()

	arg_18_0.itemList_ = nil
end

return var_0_0
