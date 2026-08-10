local var_0_0 = class("CatchDuckSelectionInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_Duck/SUDuckInfoUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.duckList_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.duckListGo_, DuckItem)
	arg_4_0.lockController_ = arg_4_0.lockCon_:GetController("lock")
	arg_4_0.maxController_ = arg_4_0.controllerEx_:GetController("Recordhigh")
	arg_4_0.descController_ = arg_4_0.controllerEx_:GetController("mode")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnBattle_, nil, function()
		CatchDuckData:SetEnterIndex(arg_5_0.params_.index)

		local var_6_0 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_CATCH_DUCK, arg_5_0.stageData_.stage_id)

		BattleController.GetInstance():LaunchBattle(var_6_0)
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.stageData_ = arg_7_0.params_.stageData

	arg_7_0:RefreshData()
	arg_7_0:RefreshUI()
end

function var_0_0.OnUpdate(arg_8_0)
	arg_8_0.stageData_ = arg_8_0.params_.stageData

	arg_8_0:RefreshData()
	arg_8_0:RefreshUI()
end

function var_0_0.RefreshData(arg_9_0)
	arg_9_0.stageCfg_ = BattleCatchDuckStageCfg[arg_9_0.stageData_.stage_id]
	arg_9_0.targetScore_ = arg_9_0.stageData_.target_score
	arg_9_0.limitTime_ = arg_9_0.stageData_.limit_time
	arg_9_0.duckType_ = arg_9_0.stageData_.duck_type
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.sectionName_.text = GetI18NText(arg_10_0.stageCfg_.name)
	arg_10_0.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, arg_10_0.stageCfg_.background_1))
	arg_10_0.targetScoreText_.text = string.format(GetTips("DUCK_NUM"), arg_10_0.targetScore_)
	arg_10_0.limitTimeText_.text = manager.time:DescCDTime(arg_10_0.limitTime_)

	if arg_10_0.stageData_.score then
		arg_10_0.maxController_:SetSelectedState("recordHigh")

		if arg_10_0.stageData_.isEndless then
			arg_10_0.maxScoreText_.text = string.format(GetTips("DUCK_NUM"), arg_10_0.stageData_.score)
		else
			arg_10_0.maxScoreText_.text = manager.time:DescCDTime(arg_10_0.stageData_.seconds)
		end
	else
		arg_10_0.maxController_:SetSelectedState("empty")
	end

	arg_10_0.descController_:SetSelectedState(arg_10_0.stageData_.isEndless and "endless" or "general")

	arg_10_0.descText_.text = arg_10_0.stageCfg_.tips

	arg_10_0.lockController_:SetSelectedState(tostring(arg_10_0.stageData_.isLock))
	arg_10_0.duckList_:StartScroll(#arg_10_0.duckType_)
end

function var_0_0.indexItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2:RefreshData(arg_11_1, arg_11_0.duckType_[arg_11_1], true)
	arg_11_2:RegisterClick(function(arg_12_0)
		JumpTools.OpenPageByJump("catchDuckInfoPop", {
			duckList = arg_11_0.duckType_,
			index = arg_12_0
		})
	end)
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
	arg_13_0.duckList_:Dispose()
end

return var_0_0
