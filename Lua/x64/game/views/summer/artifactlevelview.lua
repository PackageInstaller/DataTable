local var_0_0 = class("ArtifactLevelView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/SummerUI/SummeDivinepersonalitytwoUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Ctor(arg_3_0)
	arg_3_0.itemControllers_ = {}
	arg_3_0.openTimeTextList_ = {}
	arg_3_0.curAwardsList_ = {}
	arg_3_0.isInit_ = false
	arg_3_0.isFirstIn_ = true
	arg_3_0.activityId_ = ActivityConst.SUMMER_ARTIFACT
end

function var_0_0.Init(arg_4_0)
	arg_4_0.curLevelIndex_ = ArtifactLevelData:GetCurLevelIndex()
	arg_4_0.levelCount_ = ArtifactLevelData:GetLevelCount()

	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.awardList_ = LuaList.New(handler(arg_5_0, arg_5_0.AwardIndexItem), arg_5_0.listGo_, CommonItem)
	arg_5_0.tree_ = LuaTree.New(arg_5_0.treeGo_)

	arg_5_0.tree_:SetSelectedHandler(handler(arg_5_0, arg_5_0.OnLevelSelect))
	arg_5_0.tree_:SetRenderer(handler(arg_5_0, arg_5_0.ItemRander))

	local var_5_0 = UITreeData.New()

	var_5_0.defaultIndex = ArtifactLevelData:GetCurLevelIndex() - 1

	for iter_5_0 = 1, arg_5_0.levelCount_ do
		local var_5_1 = UITreeGroupData.New()

		var_5_1.id = iter_5_0
		var_5_1.text = ArtifactLevelData:GetLevelNameByIndex(iter_5_0)

		var_5_0.groupDatas:Add(var_5_1)
	end

	arg_5_0.tree_:SetData(var_5_0)
end

function var_0_0.OnEnter(arg_6_0)
	if arg_6_0.isInit_ then
		arg_6_0.curLevelIndex_ = ArtifactLevelData:GetCurLevelIndex()

		arg_6_0:UpdateUI()

		arg_6_0.timer_ = Timer.New(function()
			for iter_7_0 = 1, ArtifactLevelData:GetLevelCount() do
				if ArtifactLevelData:GetIsOpenByIndex(iter_7_0) then
					if ArtifactLevelData:GetIsAwardedByIndex(iter_7_0) then
						arg_6_0.itemControllers_[iter_7_0]:SetSelectedState("get")
					else
						arg_6_0.itemControllers_[iter_7_0]:SetSelectedState("unlock")
					end
				else
					arg_6_0.itemControllers_[iter_7_0]:SetSelectedState("lock")

					if ActivityData:GetActivityData(ArtifactLevelData:GetLevelIdByIndex(iter_7_0)).stopTime < manager.time:GetServerTime() then
						arg_6_0.openTimeTextList_[iter_7_0].text = string.format(GetTips("TIME_OVER"))
					else
						local var_7_0 = manager.time:GetLostTimeStr(ActivityData:GetActivityData(ArtifactLevelData:GetLevelIdByIndex(iter_7_0)).startTime)

						arg_6_0.openTimeTextList_[iter_7_0].text = string.format(GetTips("OPEN_TIME"), var_7_0)
					end
				end
			end
		end, 1, -1)

		arg_6_0.timer_:Start()
		arg_6_0:RegisterRedPoint()
	end
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_SUMMER_ARTIFACT_DESCRIPE")
end

function var_0_0.OnExit(arg_9_0)
	if arg_9_0.timer_ then
		arg_9_0.timer_:Stop()
	end

	manager.windowBar:HideBar()
	arg_9_0:UnRegisterRedPoint()
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.tree_ then
		arg_10_0.tree_:Dispose()

		arg_10_0.tree_ = nil
	end

	if arg_10_0.awardList_ then
		arg_10_0.awardList_:Dispose()

		arg_10_0.awardList_ = nil
	end

	arg_10_0.super.Dispose(arg_10_0)
end

function var_0_0.OnLevelSelect(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if ArtifactLevelData:GetIsOpenByIndex(arg_11_1) then
		arg_11_0.curLevelIndex_ = arg_11_1

		ArtifactLevelData:SetCurLevelIndex(arg_11_1)
		ArtifactLevelData:SetSelectedByIndex(arg_11_1)
		arg_11_0:UpdateUI()
		ArtifactLevelData:UpdateRedPoint()
	elseif arg_11_1 ~= arg_11_0.curLevelIndex_ then
		arg_11_0.tree_:SelectGroup(arg_11_0.curLevelIndex_)

		if ActivityData:GetActivityData(ArtifactLevelData:GetLevelIdByIndex(arg_11_1)).stopTime < manager.time:GetServerTime() then
			ShowTips(GetTips("TIME_OVER"))
		else
			local var_11_0 = manager.time:GetLostTimeStr(ActivityData:GetActivityData(ArtifactLevelData:GetLevelIdByIndex(arg_11_1)).startTime)

			ShowTips(string.format(GetTips("OPEN_TIME"), var_11_0))
		end
	end
end

function var_0_0.ItemRander(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:BindCfgUI(arg_12_2)

	arg_12_0.itemControllers_[arg_12_1] = ControllerUtil.GetController(arg_12_2.transform, "lock")

	if ArtifactLevelData:GetIsAwardedByIndex(arg_12_1) then
		arg_12_0.itemControllers_[arg_12_1]:SetSelectedState("get")
	elseif ArtifactLevelData:GetIsOpenByIndex(arg_12_1) then
		arg_12_0.itemControllers_[arg_12_1]:SetSelectedState("unlock")
	end

	arg_12_0.openTimeTextList_[arg_12_1] = arg_12_0.openTimeText_

	if ActivityData:GetActivityData(ArtifactLevelData:GetLevelIdByIndex(arg_12_1)).stopTime < manager.time:GetServerTime() then
		arg_12_0.openTimeTextList_[arg_12_1].text = string.format(GetTips("TIME_OVER"))
	else
		local var_12_0 = manager.time:GetLostTimeStr(ActivityData:GetActivityData(ArtifactLevelData:GetLevelIdByIndex(arg_12_1)).startTime)

		arg_12_0.openTimeTextList_[arg_12_1].text = string.format(GetTips("OPEN_TIME"), var_12_0)
	end

	arg_12_0.levelNumText_.text = "0" .. arg_12_1
	arg_12_0.isInit_ = true
end

function var_0_0.AddUIListener(arg_13_0)
	arg_13_0:AddBtnListener(arg_13_0.btnStart_, nil, function()
		if ArtifactLevelData:GetIsOpenByIndex(arg_13_0.curLevelIndex_) then
			local var_14_0 = ActivityArtifactLevelCfg[ArtifactLevelData:GetLevelIdByIndex(arg_13_0.curLevelIndex_)].stage_id

			arg_13_0:Go("/sectionSelectHero", {
				section = var_14_0,
				sectionType = BattleConst.STAGE_TYPE_NEW.ARTIFACT,
				activityID = ActivityConst.SUMMER_ARTIFACT
			})
		elseif ActivityData:GetActivityData(ArtifactLevelData:GetLevelIdByIndex(arg_13_0.curLevelIndex_)).stopTime < manager.time:GetServerTime() then
			ShowTips(GetTips("TIME_OVER"))
		else
			local var_14_1 = manager.time:GetLostTimeStr(ActivityData:GetActivityData(ArtifactLevelData:GetLevelIdByIndex(arg_13_0.curLevelIndex_)).startTime)

			ShowTips(string.format(GetTips("OPEN_TIME"), var_14_1))
		end
	end)
end

function var_0_0.UpdateUI(arg_15_0)
	if arg_15_0.isInit_ then
		arg_15_0.levelNameText_.text = ArtifactLevelData:GetLevelNameByIndex(arg_15_0.curLevelIndex_)
		arg_15_0.descText_.text = ArtifactLevelData:GetLevelDesc(arg_15_0.curLevelIndex_)
		arg_15_0.curAwardsList_ = getRewardFromDropCfg(ArtifactLevelData:GetAwardListByIndex(arg_15_0.curLevelIndex_), true)

		arg_15_0.awardList_:StartScroll(#arg_15_0.curAwardsList_)
		ArtifactLevelData:UpdateRedPoint()
	end
end

function var_0_0.AwardIndexItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.curAwardsList_[arg_16_1]

	arg_16_2:RefreshData(rewardToItemTemplate(var_16_0))

	local var_16_1 = ControllerUtil.GetController(arg_16_2.transform_, "received")

	if ArtifactLevelData:GetIsAwardedByIndex(arg_16_0.curLevelIndex_) then
		var_16_1:SetSelectedState("true")
	else
		var_16_1:SetSelectedState("false")
	end

	arg_16_2:RegistCallBack(function(arg_17_0)
		ShowPopItem(POP_ITEM, arg_17_0)
	end)
end

function var_0_0.RegisterRedPoint(arg_18_0)
	for iter_18_0 = 1, ArtifactLevelData:GetLevelCount() do
		local var_18_0 = arg_18_0.tree_:GetGroupRedPointContainerById(iter_18_0)

		manager.redPoint:bindUIandKey(var_18_0, string.format("%s_%s", RedPointConst.ARTIFACT, ArtifactLevelData:GetLevelIdByIndex(iter_18_0)))
	end
end

function var_0_0.UnRegisterRedPoint(arg_19_0)
	for iter_19_0 = 1, ArtifactLevelData:GetLevelCount() do
		local var_19_0 = arg_19_0.tree_:GetGroupRedPointContainerById(iter_19_0)

		manager.redPoint:unbindUIandKey(var_19_0, string.format("%s_%s", RedPointConst.ARTIFACT, ArtifactLevelData:GetLevelIdByIndex(iter_19_0)))
	end
end

return var_0_0
