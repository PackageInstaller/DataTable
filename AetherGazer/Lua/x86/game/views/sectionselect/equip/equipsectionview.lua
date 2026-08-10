local var_0_0 = class("EquipSectionView", import("..SectionBaseView"))

function var_0_0.GetSectionItemClass(arg_1_0)
	return EquipSectionItemView
end

function var_0_0.IsOpenSectionInfo(arg_2_0)
	return arg_2_0:IsOpenRoute("equipSectionInfo")
end

function var_0_0.InitCustom(arg_3_0)
	SetActive(arg_3_0.equipPanel_, true)
	arg_3_0:AddBtnListener(arg_3_0.switchBtn_, nil, function()
		if arg_3_0.isUnChoose_ then
			RedPointAction.HandleRedPoint(RED_POINT_ID.BATTLE_EQUIP)
			manager.redPoint:SetRedPointIndependent(arg_3_0.switchBtn_.transform, false)
		end

		JumpTools.OpenPageByJump("suitSelect", {
			suitId = arg_3_0.upSuitId_,
			currentSuitId = arg_3_0.upSuitId_
		})
	end)
end

function var_0_0.RefreshData(arg_5_0)
	arg_5_0.battleEquipData_ = BattleEquipData:GetBattleEquipData()

	local var_5_0 = arg_5_0.battleEquipData_.baseStageId

	if arg_5_0:IsOpenSectionInfo() and arg_5_0.lastBaseStageId_ and arg_5_0.lastBaseStageId_ ~= var_5_0 then
		arg_5_0.isOpenInfoView_ = false

		JumpTools.Back()
	end

	arg_5_0.lastBaseStageId_ = var_5_0
	arg_5_0.stageList_ = StageGroupCfg[var_5_0].stage_list
	arg_5_0.stageData_ = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.stageList_) do
		arg_5_0.stageData_[iter_5_1] = {
			id = arg_5_0.stageList_[iter_5_0]
		}
	end

	arg_5_0:RefreshCustomData()

	arg_5_0.oepnStageList_ = arg_5_0.stageList_
end

function var_0_0.RefreshUI(arg_6_0)
	arg_6_0:RefreshMissionList()

	local var_6_0 = arg_6_0.params_.section or BattleFieldData:GetCacheStage(arg_6_0.chapterID_) or arg_6_0.stageList_[1]

	arg_6_0.selectSection_ = var_6_0

	if table.keyof(arg_6_0.stageList_, var_6_0) == nil then
		arg_6_0.selectSection_ = arg_6_0.stageList_[1]

		local var_6_1 = 1
	end

	local var_6_2 = arg_6_0:GetScrollPos()
	local var_6_3 = arg_6_0:GetScrollWidth()

	arg_6_0.scrollMoveView_:RefreshUI(var_6_2, var_6_3)
	arg_6_0:RefreshSelectItem()
	arg_6_0:RefreshRemainTime()
	arg_6_0:RefreshUpSuit()

	if arg_6_0.params_.equipId then
		local var_6_4 = EquipCfg[arg_6_0.params_.equipId].suit

		JumpTools.OpenPageByJump("suitSelect", {
			suitId = var_6_4,
			currentSuitId = arg_6_0.upSuitId_
		})

		arg_6_0.params_.equipId = nil
	end

	arg_6_0:SwitchBG()
end

function var_0_0.GetCfgName(arg_7_0)
	return BattleEquipStageCfg
end

function var_0_0.RefreshUpSuit(arg_8_0)
	arg_8_0.upSuitId_ = arg_8_0.battleEquipData_.upSuitId

	local var_8_0 = EquipSuitCfg[arg_8_0.upSuitId_]

	arg_8_0.equipName_.text = GetI18NText(var_8_0.name)

	SetSpriteWithoutAtlasAsync(arg_8_0.equipIcon_, SpritePathCfg.EquipIcon_s.path .. arg_8_0.upSuitId_)
end

function var_0_0.RefreshRemainTime(arg_9_0)
	if arg_9_0.updateTimer_ then
		arg_9_0.updateTimer_:Stop()

		arg_9_0.updateTimer_ = nil
	end

	local var_9_0 = arg_9_0.battleEquipData_.next_refresh_time - manager.time:GetServerTime()

	arg_9_0.timeText_.text = string.format(GetTips("TIME_DISPLAY_15"), manager.time:DescCDTime(var_9_0))
	arg_9_0.updateTimer_ = Timer.New(function()
		var_9_0 = var_9_0 - 1
		arg_9_0.timeText_.text = string.format(GetTips("TIME_DISPLAY_15"), manager.time:DescCDTime(var_9_0))

		if var_9_0 <= 0 then
			BattleEquipAction.RequestBattleEquipInfo()
		end
	end, 1, var_9_0, 1)

	arg_9_0.updateTimer_:Start()
end

function var_0_0.RefreshMissionList(arg_11_0)
	for iter_11_0 = 1, #arg_11_0.stageList_ do
		if arg_11_0.missionItem_[iter_11_0] then
			arg_11_0.missionItem_[iter_11_0]:SetData(arg_11_0.chapterID_, arg_11_0.stageList_[iter_11_0])
		else
			arg_11_0.missionItem_[iter_11_0] = arg_11_0:GetSectionItemClass().New(arg_11_0.sectionItem_, arg_11_0.content_, arg_11_0.stageList_[iter_11_0], arg_11_0.chapterID_)
		end
	end

	arg_11_0:CreateLineItemList()
end

function var_0_0.RefreshRedPoint(arg_12_0)
	arg_12_0.isUnChoose_ = not RedPointData:GetIsRedPointOpen(RED_POINT_ID.BATTLE_EQUIP)

	if arg_12_0.isUnChoose_ then
		manager.redPoint:SetRedPointIndependent(arg_12_0.switchBtn_.transform, true)
	end
end

function var_0_0.OnBattleEquipUpdate(arg_13_0)
	arg_13_0:RefreshData()
	arg_13_0:RefreshUI()
end

function var_0_0.OnTop(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("EQUIP_STAGE_DESCRIPE")
	manager.windowBar:RegistBackCallBack(function()
		if arg_14_0:IsOpenSectionInfo() then
			arg_14_0.isOpenInfoView_ = false
		end

		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_16_0)
	manager.ui:SetMainCamera("null")
	arg_16_0:ShowPanel()
	BattleEquipAction.RequestBattleEquipInfo()

	arg_16_0.chapterID_ = ChapterCfg.get_id_list_by_type[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP][1]

	arg_16_0:RefreshBGM()
	arg_16_0:RefreshMultiReward()
	arg_16_0:RefreshRedPoint()
end

function var_0_0.OnExit(arg_17_0)
	var_0_0.super.OnExit(arg_17_0)

	if arg_17_0.updateTimer_ then
		arg_17_0.updateTimer_:Stop()

		arg_17_0.updateTimer_ = nil
	end
end

function var_0_0.CreateLineItemList(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.lineList_) do
		iter_18_1:Show(false)
	end

	local var_18_0 = 1

	for iter_18_2, iter_18_3 in ipairs(arg_18_0.stageList_) do
		if iter_18_2 > 1 then
			local var_18_1 = arg_18_0.missionItem_[iter_18_2]:GetLocalPosition() + Vector3(0, 0, 0)
			local var_18_2 = arg_18_0.missionItem_[iter_18_2 - 1]:GetLocalPosition() + Vector3(0, 0, 0)

			arg_18_0.lineList_[var_18_0] = arg_18_0.lineList_[var_18_0] or arg_18_0:GetLineClass(0).New(arg_18_0.lineGo_, arg_18_0.content_, arg_18_0.pointGo_)

			arg_18_0.lineList_[var_18_0]:Show(true)
			arg_18_0.lineList_[var_18_0]:RefreshUI(var_18_2, var_18_1)

			var_18_0 = var_18_0 + 1
		end
	end
end

return var_0_0
