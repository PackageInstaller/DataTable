local var_0_0 = import("game.views.sectionSelect.SectionBaseView")
local var_0_1 = class("ActivityHeroEnhanceSectionView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return ActivityHeroEnhanceTools.GetStageUIName(arg_1_0.params_.activityID)
end

function var_0_1.GetCfgName(arg_2_0)
	return BattleHeroEnhanceCfg
end

function var_0_1.GetSectionItemClass(arg_3_0)
	return ActivityHeroEnhanceSectionItem
end

function var_0_1.IsOpenSectionInfo(arg_4_0)
	return arg_4_0:IsOpenRoute("activityHeroEnhanceSectionInfo")
end

function var_0_1.RefreshBGM(arg_5_0)
	return
end

function var_0_1.Init(arg_6_0)
	var_0_1.super.Init(arg_6_0)
end

function var_0_1.InitCustom(arg_7_0)
	arg_7_0:BindCfgUI()
end

function var_0_1.OnEnter(arg_8_0)
	var_0_1.super.OnEnter(arg_8_0)

	if arg_8_0.params_.exitFromBattle then
		ActivityHeroEnhanceHeroView.enterBattleCfgId_ = arg_8_0.params_.cfgId
		arg_8_0.params_.exitFromBattle = nil
	end
end

function var_0_1.RefreshData(arg_9_0)
	local var_9_0 = arg_9_0.params_.cfgId

	arg_9_0.activityId_ = arg_9_0.params_.activityID
	arg_9_0.cfgId_ = var_9_0

	local var_9_1 = ActivityHeroEnhanceCfg[var_9_0]

	arg_9_0.stageList_ = var_9_1.stage_list
	arg_9_0.oepnStageList_ = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.stageList_) do
		if ActivityHeroEnhanceTools.IsCfgStageUnlock(var_9_1, iter_9_1) then
			table.insert(arg_9_0.oepnStageList_, iter_9_1)
		end
	end

	local var_9_2 = arg_9_0:GetAttachView()
	local var_9_3 = ActivityHeroEnhanceTools.GetCfgActivatedTalentDict(var_9_1)

	var_9_2:SetData(var_9_0, var_9_3)
	var_9_2:RefreshUI()
end

function var_0_1.GetAttachView(arg_10_0)
	if arg_10_0.attachView_ == nil then
		local var_10_0 = ActivityHeroEnhanceTools.GetStageAttachUIName(arg_10_0.activityId_)

		arg_10_0.attachView_ = ActivityHeroEnhanceSectionAttachView.New(arg_10_0.setionAttachGo_, var_10_0)
	end

	return arg_10_0.attachView_
end

function var_0_1.OnClickSectionItem(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_2 then
		-- block empty
	else
		arg_11_0:Go("activityHeroEnhanceSectionInfo", {
			section = arg_11_1,
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_HERO_ENHANCE,
			activityID = arg_11_0.activityId_,
			heroEnhance_CfgID = arg_11_0.cfgId_
		})
	end
end

function var_0_1.RefreshMissionList(arg_12_0)
	for iter_12_0 = #arg_12_0.stageList_ + 1, #arg_12_0.missionItem_ do
		arg_12_0.missionItem_[iter_12_0]:Show(false)
	end

	for iter_12_1 = 1, #arg_12_0.stageList_ do
		local var_12_0 = arg_12_0.missionItem_[iter_12_1]

		if var_12_0 == nil then
			var_12_0 = arg_12_0:GetSectionItemClass().New(arg_12_0.sectionItem_, arg_12_0.content_)
			arg_12_0.missionItem_[iter_12_1] = var_12_0

			var_12_0:SetClickHandler(function(arg_13_0, arg_13_1)
				arg_12_0:OnClickSectionItem(arg_13_0, arg_13_1)
			end)
		end

		var_12_0:SetData(arg_12_0.cfgId_, arg_12_0.stageList_[iter_12_1])
		var_12_0:RefreshData()
		var_12_0:RefreshUI()
	end

	arg_12_0:CreateLineItemList()
end

function var_0_1.CreateLineItemList(arg_14_0)
	arg_14_0.lineType_ = 0

	local var_14_0 = 0
	local var_14_1 = arg_14_0.oepnStageList_

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		local var_14_2 = table.keyof(arg_14_0.stageList_, iter_14_1)
		local var_14_3 = arg_14_0.missionItem_[var_14_2]:GetLocalPosition() + Vector3(0, 0, 0)
		local var_14_4 = arg_14_0:GetCfgName()[iter_14_1].next_unlock_id_list or {}

		for iter_14_2, iter_14_3 in ipairs(var_14_4) do
			local var_14_5 = arg_14_0:GetCfgName()[iter_14_1]

			if table.keyof(var_14_1, iter_14_3) then
				local var_14_6 = table.keyof(arg_14_0.stageList_, iter_14_3)
				local var_14_7 = arg_14_0.missionItem_[var_14_6]:GetLocalPosition() + Vector3(0, 0, 0)

				var_14_0 = var_14_0 + 1
				arg_14_0.lineList_[var_14_0] = arg_14_0.lineList_[var_14_0] or arg_14_0:GetLineClass(arg_14_0.lineType_).New(arg_14_0:GetLineGo(arg_14_0.lineType_), arg_14_0.content_, arg_14_0:GetPointGo(arg_14_0.lineType_))

				arg_14_0.lineList_[var_14_0]:Show(true)
				arg_14_0.lineList_[var_14_0]:RefreshUI(var_14_3, var_14_7)
			end
		end
	end

	for iter_14_4, iter_14_5 in pairs(arg_14_0.lineList_) do
		iter_14_5:Show(iter_14_4 <= var_14_0)
	end
end

function var_0_1.Dispose(arg_15_0)
	if arg_15_0.attachView_ then
		arg_15_0.attachView_:Dispose()
	end

	var_0_1.super.Dispose(arg_15_0)
end

return var_0_1
