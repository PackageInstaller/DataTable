NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local var_0_0 = class("BattleResultSkuldView", NewBattleSettlementView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Skuld/Activity_Skuld_ResultWinUI"
end

function var_0_0.OnEnter(arg_2_0)
	var_0_0.super.OnEnter(arg_2_0)

	if arg_2_0.params_.skuldIconNum == 0 then
		SetActive(arg_2_0.trustGo_, false)
	else
		SetActive(arg_2_0.trustGo_, true)
	end

	arg_2_0.frontSkuldIconText_.text = SkuldSystemData:GetCacheSkuldIconNum()
	arg_2_0.curSkuldIconText_.text = SkuldSystemData:GetCacheSkuldIconNum() + arg_2_0.params_.skuldIconNum

	if SkuldSystemData:GetLevelIDIsClear(arg_2_0.params_.levelID) then
		SetActive(arg_2_0.contentContainer_.gameObject, false)
	else
		SetActive(arg_2_0.contentContainer_.gameObject, true)
		SetActive(arg_2_0.missionView.conditionGo_, false)
	end

	SkuldSystemData:UpdateSkuldStageArchiveRed()
end

function var_0_0.NeedOnceMore(arg_3_0)
	if SkuldStageCfg[arg_3_0.params_.levelID].ending == 1 then
		return true, GetTips("ACTIVITY_HERO_ENHANCE_BUTTON_CONTINUE")
	else
		return false
	end
end

function var_0_0.OnAddListner(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.nextStageBtn_, nil, function()
		local var_5_0 = SkuldStageCfg[arg_4_0.params_.levelID]
		local var_5_1 = table.indexof(SkuldStageCfg.all, arg_4_0.params_.levelID)

		if var_5_1 > 0 and var_5_1 ~= #SkuldStageCfg.all then
			local var_5_2 = SkuldStageCfg.all[var_5_1 + 1]
			local var_5_3 = SkuldStageCfg[var_5_2]

			if SkuldSystemData:GetLevelIDIsOpen(var_5_2) then
				arg_4_0.params_.stageData:SetStartNext()
				BattleInstance.QuitBattle(arg_4_0.params_.stageData)
			else
				ShowTips("ACTIVITY_ZUMA_OPEN_FRONT")
			end
		end
	end)
end

function var_0_0.RefreshBottomBtn(arg_6_0)
	local var_6_0 = {
		1008,
		1019,
		1026,
		1030,
		2006
	}
	local var_6_1 = table.indexof(var_6_0, arg_6_0.params_.levelID) ~= false

	SetActive(arg_6_0.nextStageBtn_, not var_6_1)
end

return var_0_0
