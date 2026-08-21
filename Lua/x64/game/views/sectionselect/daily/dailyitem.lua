local var_0_0 = import("game.views.sectionSelect.SectionBaseItem")
local var_0_1 = class("DailyItem", var_0_0)

function var_0_1.IsOpenSectionInfo(arg_1_0)
	return arg_1_0:IsOpenRoute("dailySectionInfo")
end

function var_0_1.InitCustom(arg_2_0)
	SetActive(arg_2_0.collectGo_, false)
	arg_2_0.showStarController_:SetSelectedState("false")
end

function var_0_1.ShowRedPoint(arg_3_0)
	SetActive(arg_3_0.noticeContainer_.gameObject, true)
	manager.redPoint:unbindUIandKey(arg_3_0.noticeContainer_)
	manager.redPoint:bindUIandKey(arg_3_0.noticeContainer_, DailyNewRedPoint:GetNewRedKey(arg_3_0.stageID_))
end

function var_0_1.GetPosition(arg_4_0)
	local var_4_0 = BattleDailyStageCfg[arg_4_0.stageID_]

	return var_4_0 and var_4_0.position or {
		0,
		0
	}
end

function var_0_1.RefreshData(arg_5_0)
	local var_5_0 = BattleStageData:GetStageData()[arg_5_0.stageID_]

	if var_5_0 then
		arg_5_0.isLock_ = false
		arg_5_0.clearTimes_ = var_5_0.clear_times
		arg_5_0.starCnt_ = 3
	else
		arg_5_0.isLock_ = true
		arg_5_0.clearTimes_ = 0
		arg_5_0.starCnt_ = 0
	end

	arg_5_0.enoughLevel_ = PlayerData:GetPlayerInfo().userLevel >= BattleDailyStageCfg[arg_5_0.stageID_].level
end

function var_0_1.OnClick(arg_6_0)
	if arg_6_0.isLock_ then
		-- block empty
	else
		DailyNewRedPoint:CancelNewTag(arg_6_0.stageID_)
		BattleFieldData:SetStageByClientID(arg_6_0.chapterID_, arg_6_0.stageID_)
		arg_6_0:Go("dailySectionInfo", {
			chapterID = arg_6_0.chapterID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY,
			section = arg_6_0.stageID_
		})
	end
end

function var_0_1.RefreshText(arg_7_0)
	local var_7_0, var_7_1 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY, arg_7_0.stageID_)

	arg_7_0.text_.text = string.format("%s-%s", GetI18NText(var_7_0), GetI18NText(var_7_1))
end

function var_0_1.Dispose(arg_8_0)
	var_0_1.super.Dispose(arg_8_0)
	manager.redPoint:unbindUIandKey(arg_8_0.noticeContainer_, DailyNewRedPoint:GetNewRedKey(arg_8_0.stageID_))
end

return var_0_1
