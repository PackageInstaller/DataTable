local var_0_0 = import("game.views.sectionSelect.SectionBaseView")
local var_0_1 = class("ActivityHeroEnhanceSectionView_4_5", var_0_0)

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
	arg_8_0.stopAni_ = true
	arg_8_0.activityId_ = arg_8_0.params_.activityID

	local var_8_0 = ActivityHeroEnhanceTools.GetIsNewTalent(arg_8_0.activityId_)

	if var_8_0 ~= -1 then
		arg_8_0.cacheNewTalent_ = var_8_0

		JumpTools.OpenPageByJump("/activityHeroEnhancePopView_4_5", {
			talentID = var_8_0,
			activityID = arg_8_0.activityId_
		})

		return
	end

	arg_8_0:GetAttachView():PlayTalentAnim(arg_8_0.cacheNewTalent_)

	arg_8_0.cacheNewTalent_ = nil

	if arg_8_0.params_.cfgId then
		arg_8_0:ChangeCfgID(arg_8_0.params_.cfgId)
	end

	local var_8_1 = ActivityHeroEnhanceTools.GetCfgIdList(arg_8_0.activityId_)

	for iter_8_0 = #var_8_1, 1, -1 do
		local var_8_2 = ActivityHeroEnhanceCfg[var_8_1[iter_8_0]]
		local var_8_3, var_8_4 = ActivityHeroEnhanceTools.IsCfgHeroLock(var_8_2)

		if not var_8_3 then
			if iter_8_0 > 1 and not getData("heroEnhanceUnlockCfgID" .. arg_8_0.activityId_, tostring(var_8_1[iter_8_0])) then
				saveData("heroEnhanceUnlockCfgID" .. arg_8_0.activityId_, tostring(var_8_1[iter_8_0]), true)

				if iter_8_0 - 1 > 0 then
					arg_8_0:ChangeCfgID(var_8_1[iter_8_0 - 1])
				else
					arg_8_0:ChangeCfgID(var_8_1[iter_8_0])
				end

				FrameTimer.New(function()
					arg_8_0:GetAttachView():PlayAnim(var_8_1[iter_8_0], function()
						arg_8_0:ChangeCfgID(var_8_1[iter_8_0])
					end)
				end, 1, 1):Start()
			elseif arg_8_0.params_.cfgId then
				arg_8_0.params_.cfgId = nil
			else
				arg_8_0:ChangeCfgID(var_8_1[iter_8_0])
			end

			break
		end
	end

	var_0_1.super.OnEnter(arg_8_0)
end

function var_0_1.RefreshData(arg_11_0)
	if not arg_11_0.cfgId_ then
		return
	end

	local var_11_0 = ActivityHeroEnhanceCfg[arg_11_0.cfgId_]

	arg_11_0.stageList_ = var_11_0.stage_list
	arg_11_0.oepnStageList_ = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.stageList_) do
		if ActivityHeroEnhanceTools.IsCfgStageUnlock(var_11_0, iter_11_1) then
			table.insert(arg_11_0.oepnStageList_, iter_11_1)
		end
	end

	local var_11_1 = arg_11_0:GetAttachView()
	local var_11_2 = ActivityHeroEnhanceTools.GetCfgTalentList(var_11_0)

	var_11_1:SetData(arg_11_0.cfgId_, var_11_2)
	var_11_1:RefreshUI()
end

function var_0_1.GetAttachView(arg_12_0)
	if arg_12_0.attachView_ == nil then
		local var_12_0 = ActivityHeroEnhanceTools.GetStageAttachUIName(arg_12_0.activityId_)

		arg_12_0.attachView_ = ActivityHeroEnhanceSectionAttachView_4_5.New(arg_12_0.setionAttachGo_, var_12_0, arg_12_0.activityId_, function(arg_13_0)
			arg_12_0:ChangeCfgID(arg_13_0)
		end)
	end

	return arg_12_0.attachView_
end

function var_0_1.OnClickSectionItem(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_2 then
		-- block empty
	else
		arg_14_0:Go("activityHeroEnhanceSectionInfo", {
			section = arg_14_1,
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_HERO_ENHANCE,
			activityID = arg_14_0.activityId_,
			heroEnhance_CfgID = arg_14_0.cfgId_
		})
	end
end

function var_0_1.RefreshUI(arg_15_0)
	arg_15_0:RefreshMissionList()

	local var_15_0 = arg_15_0.stageList_[1]

	for iter_15_0 = 1, #arg_15_0.stageList_ do
		local var_15_1 = ActivityHeroEnhanceCfg[arg_15_0.cfgId_]

		if not not ActivityHeroEnhanceTools.IsCfgStageUnlock(var_15_1, arg_15_0.stageList_[iter_15_0]) then
			var_15_0 = arg_15_0.stageList_[iter_15_0]
		end
	end

	arg_15_0.selectSection_ = arg_15_0.params_.section or BattleFieldData:GetCacheStage(arg_15_0.chapterID_) or var_15_0

	local var_15_2 = arg_15_0:GetScrollPos()
	local var_15_3 = arg_15_0:GetScrollWidth()

	if arg_15_0.stopMove_ then
		-- block empty
	elseif arg_15_0.stopAni_ then
		arg_15_0.stopAni_ = false

		arg_15_0.scrollMoveView_:RefreshUI(var_15_2, var_15_3, true)
	else
		arg_15_0.scrollMoveView_:RefreshUI(var_15_2, var_15_3)
	end

	arg_15_0:RefreshSelectItem()
end

function var_0_1.RefreshMissionList(arg_16_0)
	if not arg_16_0.cfgId_ then
		return
	end

	for iter_16_0 = #arg_16_0.stageList_ + 1, #arg_16_0.missionItem_ do
		arg_16_0.missionItem_[iter_16_0]:Show(false)
	end

	local var_16_0 = 0

	for iter_16_1 = 1, #arg_16_0.stageList_ do
		local var_16_1 = arg_16_0.missionItem_[iter_16_1]

		if var_16_1 == nil then
			var_16_1 = arg_16_0:GetSectionItemClass().New(arg_16_0.sectionItem_, arg_16_0.content_)
			arg_16_0.missionItem_[iter_16_1] = var_16_1

			var_16_1:SetClickHandler(function(arg_17_0, arg_17_1)
				arg_16_0:OnClickSectionItem(arg_17_0, arg_17_1)
			end)
		end

		var_16_1:SetData(arg_16_0.cfgId_, arg_16_0.stageList_[iter_16_1])
		var_16_1:RefreshData()
		var_16_1:RefreshUI()
	end

	arg_16_0:CreateLineItemList()
end

function var_0_1.CreateLineItemList(arg_18_0)
	arg_18_0.lineType_ = 0

	local var_18_0 = 0
	local var_18_1 = arg_18_0.oepnStageList_

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		local var_18_2 = table.keyof(arg_18_0.stageList_, iter_18_1)
		local var_18_3 = arg_18_0.missionItem_[var_18_2]:GetLocalPosition() + Vector3(0, 0, 0)
		local var_18_4 = arg_18_0:GetCfgName()[iter_18_1].next_unlock_id_list or {}

		for iter_18_2, iter_18_3 in ipairs(var_18_4) do
			local var_18_5 = arg_18_0:GetCfgName()[iter_18_1]

			if table.keyof(var_18_1, iter_18_3) then
				local var_18_6 = table.keyof(arg_18_0.stageList_, iter_18_3)
				local var_18_7 = arg_18_0.missionItem_[var_18_6]:GetLocalPosition() + Vector3(0, 0, 0)

				var_18_0 = var_18_0 + 1
				arg_18_0.lineList_[var_18_0] = arg_18_0.lineList_[var_18_0] or arg_18_0:GetLineClass(arg_18_0.lineType_).New(arg_18_0:GetLineGo(arg_18_0.lineType_), arg_18_0.content_, arg_18_0:GetPointGo(arg_18_0.lineType_))

				arg_18_0.lineList_[var_18_0]:Show(true)
				arg_18_0.lineList_[var_18_0]:RefreshUI(var_18_3, var_18_7)
			end
		end
	end

	for iter_18_4, iter_18_5 in pairs(arg_18_0.lineList_) do
		iter_18_5:Show(iter_18_4 <= var_18_0)
	end
end

function var_0_1.ChangeCfgID(arg_19_0, arg_19_1)
	if arg_19_0.cfgId_ == arg_19_1 then
		return
	end

	arg_19_0.stopAni_ = true
	arg_19_0.cfgId_ = arg_19_1

	arg_19_0:RefreshData()
	arg_19_0.attachView_:ChooseCfg(arg_19_0.cfgId_)
	arg_19_0:RefreshUI()
end

function var_0_1.Dispose(arg_20_0)
	if arg_20_0.attachView_ then
		arg_20_0.attachView_:Dispose()
	end

	var_0_1.super.Dispose(arg_20_0)
end

return var_0_1
