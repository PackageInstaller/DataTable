local var_0_0 = class("MonsterCosplayStageItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.stateController = arg_1_0.controller_:GetController("state")
	arg_1_0.typeController = arg_1_0.controller_:GetController("type")
	arg_1_0.selController = arg_1_0.controller_:GetController("sel")
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.stageID = arg_2_1
	arg_2_0.monsterID = arg_2_2
	arg_2_0.monsterData = MonsterCosplayData:GetDataByPara("monsterData")[arg_2_0.monsterID]
	arg_2_0.stageData = arg_2_0.monsterData.finishedStage
	arg_2_0.openStage = MonsterCosplayData:GetDataByPara("openStage")[arg_2_2]
	arg_2_0.finishedPointStageData = arg_2_0.monsterData.finishedPointStage
	arg_2_0.parent = arg_2_3

	arg_2_0:RefreshUI()
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.transform_ = nil
	arg_3_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.button_, nil, function()
		local var_5_0 = BattleActivityMonsterCosplayCfg[arg_4_0.stageID]

		if IsConditionAchieved(tonumber(var_5_0.unlock_condition)) == false then
			ShowTips(ConditionCfg[tonumber(var_5_0.unlock_condition)].desc)

			return
		end

		arg_4_0.parent.leftAnimator_.enabled = false
		arg_4_0.parent.selectStageID = arg_4_0.stageID

		JumpTools.OpenPageByJump("MonsterCosplaySectionInfo", {
			section = arg_4_0.stageID,
			monsterID = arg_4_0.monsterID,
			parent = arg_4_0.parent
		})
		arg_4_0:SelectorItem(arg_4_0.stageID)
		arg_4_0.parent:SelectedItem(arg_4_0.stageID)
		arg_4_0.parent.infoController:SetSelectedState("state1")
		arg_4_0.parent:RefreshUI()
	end)
end

function var_0_0.IsOpenSectionInfo(arg_6_0)
	return arg_6_0:IsOpenRoute("subPlotSectionInfo")
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0:Show(true)
	arg_7_0:RefreshCustomUI()
end

function var_0_0.RefreshCustomUI(arg_8_0)
	arg_8_0.selController:SetSelectedState("false")

	local var_8_0 = BattleActivityMonsterCosplayCfg[arg_8_0.stageID]

	arg_8_0.textIndex_.text = var_8_0.name
	arg_8_0.scoreLevelTxt_.text = var_8_0.name

	if arg_8_0.stageData[arg_8_0.stageID] then
		arg_8_0.stateController:SetSelectedState("2")

		if var_8_0.sub_type == 2 and arg_8_0.finishedPointStageData[arg_8_0.stageID] then
			arg_8_0.scoreTxt_.text = arg_8_0.finishedPointStageData[arg_8_0.stageID].maxScore
		end
	elseif arg_8_0.stageID == arg_8_0.openStage and IsConditionAchieved(tonumber(var_8_0.unlock_condition[1])) then
		arg_8_0.stateController:SetSelectedState("1")
	else
		arg_8_0.stateController:SetSelectedState("3")
	end

	if var_8_0.sub_type == 1 then
		arg_8_0.typeController:SetSelectedState("2")
	elseif var_8_0.sub_type == 2 then
		arg_8_0.typeController:SetSelectedState("3")
	end
end

function var_0_0.BindRedPoint(arg_9_0)
	local var_9_0 = RedPointConst.MONSTER_COSPLAY_STAGE .. arg_9_0.stageID

	manager.redPoint:bindUIandKey(arg_9_0.transform_, var_9_0)
end

function var_0_0.UnbindRedPoint(arg_10_0)
	local var_10_0 = RedPointConst.MONSTER_COSPLAY_STAGE .. arg_10_0.stageID

	manager.redPoint:unbindUIandKey(arg_10_0.transform_, var_10_0)
end

function var_0_0.SelectorItem(arg_11_0, arg_11_1)
	if arg_11_0.stageID == arg_11_1 then
		arg_11_0.selController:SetSelectedState("state1")
	else
		arg_11_0.selController:SetSelectedState("state0")
	end
end

function var_0_0.GetLocalPosition(arg_12_0)
	return arg_12_0.transform_.localPosition
end

function var_0_0.Show(arg_13_0, arg_13_1)
	SetActive(arg_13_0.gameObject_, arg_13_1)
end

return var_0_0
