local var_0_0 = class("TeachStageBaseView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.switchType_ = arg_1_2

	arg_1_0:InitUI()
	arg_1_0:AddListeners()

	arg_1_0.missionItem_ = {}
	arg_1_0.lineList_ = {}
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0:RefreshData()
	arg_2_0:RefreshUI()
end

function var_0_0.OnUpdate(arg_3_0)
	arg_3_0:RefreshUI()
end

function var_0_0.OnClickTeachViewBtn(arg_4_0)
	return
end

function var_0_0.OnExit(arg_5_0)
	BattleTeachData:SetBaseScrollViewHorizontal(arg_5_0.scrollMoveView_:GetHorizontalNormalizedPosition())

	arg_5_0.isFirst_ = false

	arg_5_0.scrollMoveView_:OnExit()
end

function var_0_0.Dispose(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.missionItem_) do
		iter_6_1:Dispose()
	end

	arg_6_0.missionItem_ = nil

	for iter_6_2, iter_6_3 in pairs(arg_6_0.lineList_) do
		iter_6_3:Dispose()
	end

	arg_6_0.lineList_ = nil

	arg_6_0.scrollMoveView_:Dispose()

	arg_6_0.scrollMoveView_ = nil

	arg_6_0:RemoveListeners()

	arg_6_0.scrollViewEvent_ = nil
	arg_6_0.scrollViewGo_ = nil
	arg_6_0.scrollView_ = nil
	arg_6_0.viewportRect_ = nil
	arg_6_0.content_ = nil
	arg_6_0.contentRect_ = nil
	arg_6_0.sectionItem_ = nil
	arg_6_0.lineGo_ = nil
end

function var_0_0.InitUI(arg_7_0)
	arg_7_0:BindCfgUI()

	arg_7_0.scrollMoveView_ = ScrollMoveView.New(arg_7_0, arg_7_0.basiScrollView_)
end

function var_0_0.AddListeners(arg_8_0)
	return
end

function var_0_0.RemoveListeners(arg_9_0)
	return
end

function var_0_0.RefreshData(arg_10_0)
	local var_10_0 = ChapterCfg.get_id_list_by_type[arg_10_0.switchType_][1]

	arg_10_0.stageList_ = ChapterCfg[var_10_0].section_id_list

	arg_10_0:GetScrollWidth()
end

function var_0_0.GetScrollWidth(arg_11_0)
	local var_11_0 = arg_11_0.stageList_[#arg_11_0.stageList_]

	arg_11_0.scrollWidth_ = BattleBaseTeachStageCfg[var_11_0].position[1]
end

function var_0_0.SwitchPageUI(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_0.switchType_ == arg_12_1

	SetActive(arg_12_0.gameObject_, var_12_0)

	if var_12_0 then
		BattleTeachAction.CancelBaseTeachRedPoint()
	end

	if arg_12_3 then
		local var_12_1 = ChapterCfg.get_id_list_by_type[arg_12_0.switchType_][1]

		BattleFieldData:SetCacheStage(var_12_1, ChapterCfg[var_12_1].section_id_list[1])
		BattleTeachData:SetBaseScrollViewHorizontal(0)
	end
end

function var_0_0.IsOpenSectionInfo(arg_13_0)
	return arg_13_0:IsOpenRoute("teachSectionInfo")
end

function var_0_0.RefreshUI(arg_14_0)
	arg_14_0:RefreshMissionList()

	local var_14_0 = ChapterCfg.get_id_list_by_type[arg_14_0.switchType_][1]
	local var_14_1 = BattleFieldData:GetCacheStage(var_14_0) or arg_14_0.stageList_[1]
	local var_14_2 = table.keyof(arg_14_0.stageList_, var_14_1)
	local var_14_3 = BattleBaseTeachStageCfg[arg_14_0.stageList_[var_14_2]].position[1]

	arg_14_0.lastSelect_ = var_14_2

	if not arg_14_0.isFirst_ then
		arg_14_0.scrollMoveView_:SetHorizontalNormalizedPosition(BattleTeachData:GetBaseScrollViewHorizontal(), arg_14_0.scrollWidth_)

		arg_14_0.isFirst_ = true
	else
		arg_14_0.scrollMoveView_:RefreshUI(var_14_3, arg_14_0.scrollWidth_, not arg_14_0:IsOpenSectionInfo())
	end

	if arg_14_0:IsOpenSectionInfo() then
		for iter_14_0, iter_14_1 in ipairs(arg_14_0.missionItem_) do
			iter_14_1:RefreshSelect(var_14_1)
		end
	else
		for iter_14_2, iter_14_3 in ipairs(arg_14_0.missionItem_) do
			iter_14_3:RefreshSelect(0)
		end
	end
end

function var_0_0.GetSectionItemClass(arg_15_0)
	return TeachStageBaseItem
end

function var_0_0.RefreshMissionList(arg_16_0)
	for iter_16_0 = 1, #arg_16_0.missionItem_ do
		arg_16_0.missionItem_[iter_16_0]:Show(false)
	end

	for iter_16_1 = 1, #arg_16_0.stageList_ do
		if arg_16_0.missionItem_[iter_16_1] then
			arg_16_0.missionItem_[iter_16_1]:SetData(arg_16_0.stageList_[iter_16_1])
		else
			arg_16_0.missionItem_[iter_16_1] = arg_16_0:GetSectionItemClass().New(arg_16_0.sectionItem_, arg_16_0.content_, arg_16_0.stageList_[iter_16_1])
		end
	end

	arg_16_0:CreateLineItemList()
end

function var_0_0.CreateLineItemList(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.lineList_) do
		iter_17_1:Show(false)
	end

	for iter_17_2, iter_17_3 in ipairs(arg_17_0.stageList_) do
		if iter_17_2 > 1 then
			local var_17_0 = arg_17_0.missionItem_[iter_17_2 - 1]:GetLocalPosition() + Vector3(150, 6.2, 0)
			local var_17_1 = arg_17_0.missionItem_[iter_17_2]:GetLocalPosition() + Vector3(-157, 6.2, 0)

			arg_17_0.lineList_[iter_17_2] = arg_17_0.lineList_[iter_17_2] or SectionLineItem.New(arg_17_0.lineGo_, arg_17_0.content_, arg_17_0.pointGo_)

			arg_17_0.lineList_[iter_17_2]:RefreshUI(var_17_0, var_17_1)
			arg_17_0.lineList_[iter_17_2]:Show(true)
		end
	end
end

return var_0_0
