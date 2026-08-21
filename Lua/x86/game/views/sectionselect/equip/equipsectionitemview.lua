local var_0_0 = class("EquipSectionItemView", import("game.views.sectionSelect.SectionBaseItem"))

function var_0_0.IsOpenSectionInfo(arg_1_0)
	return arg_1_0:IsOpenRoute("equipSectionInfo")
end

function var_0_0.InitCustom(arg_2_0)
	SetActive(arg_2_0.collectGo_, false)
	SetActive(arg_2_0.storyIconGo_, false)
	arg_2_0.showStarController_:SetSelectedState("false")
	manager.redPoint:bindUIandKey(arg_2_0.noticeContainer_, BattleEquipData:GetNewRedPrefix() .. arg_2_0.level_)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.itemBtn_, nil, function()
		BattleEquipData:CancelNewTag(arg_3_0.level_)
		arg_3_0:Go("equipSectionInfo", {
			chapterID = arg_3_0.chapterID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP,
			section = arg_3_0.stageID_
		})
	end)
end

function var_0_0.RefreshData(arg_5_0)
	arg_5_0.level_ = BattleInstance.GetHardLevel(arg_5_0.stageID_)
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = arg_6_0:GetPosition()

	arg_6_0.transform_.localPosition = Vector3(var_6_0[1], var_6_0[2], 0)

	local var_6_1 = GameSetting.equip_stage_unlock.value

	arg_6_0.isLock_ = JumpTools.IsConditionLocked({
		ViewConst.SYSTEM_LOCK_TYPE.LEVEL,
		var_6_1[arg_6_0.level_]
	})

	arg_6_0.isBossController_:SetSelectedState("false")
	arg_6_0:RefreshText()
	arg_6_0:ShowRedPoint()
end

function var_0_0.ShowRedPoint(arg_7_0)
	return
end

function var_0_0.GetPosition(arg_8_0)
	local var_8_0 = BattleEquipStageCfg[arg_8_0.stageID_]

	return var_8_0 and var_8_0.position or {
		0,
		0
	}
end

function var_0_0.RefreshText(arg_9_0)
	local var_9_0, var_9_1 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP, arg_9_0.stageID_)

	arg_9_0.text_.text = string.format("%s%s", GetI18NText(var_9_0), GetI18NText(var_9_1))
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
	manager.redPoint:unbindUIandKey(arg_10_0.noticeContainer_, BattleEquipData:GetNewRedPrefix() .. arg_10_0.level_)
end

return var_0_0
