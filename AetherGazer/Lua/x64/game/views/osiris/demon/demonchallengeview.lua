local var_0_0 = class("DemonChallengeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/OsirisUI/OsirisDemonUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.inited = false
	arg_3_0.curLevelIndex_ = arg_3_0.params_.levelIndex
	arg_3_0.levelCount_ = DemonChallengeData:GetLevelCount()
	arg_3_0.levelControllers_ = {}
	arg_3_0.lastOpenStatusList_ = {}

	for iter_3_0 = 1, arg_3_0.levelCount_ do
		arg_3_0.lastOpenStatusList_[iter_3_0] = false
	end

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.inited = true
	arg_3_0.tiemOut_ = false
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.openTimeTextList_ = {}
	arg_4_0.levelNameTextList_ = {}
	arg_4_0.tree_ = LuaTree.New(arg_4_0.treeGo_)

	arg_4_0.tree_:SetSelectedHandler(handler(arg_4_0, arg_4_0.OnLevelSelect))
	arg_4_0.tree_:SetRenderer(handler(arg_4_0, arg_4_0.LevelRenderer))

	local var_4_0 = UITreeData.New()

	for iter_4_0 = 1, arg_4_0.levelCount_ do
		local var_4_1 = UITreeGroupData.New()

		var_4_1.id = iter_4_0
		var_4_1.text = "group" .. iter_4_0

		var_4_0.groupDatas:Add(var_4_1)
	end

	arg_4_0.tree_:SetData(var_4_0)
end

function var_0_0.OnEnter(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_OSIRIS_HEART_DEMON_CHALLENGE_DESCRIPE")

	if arg_5_0.curLevelIndex_ == nil then
		arg_5_0.curLevelIndex_ = DemonChallengeData:GetCacheSelectLevelIndex() or DemonChallengeData:GetAnyOpen()
	end

	arg_5_0:AddUpdateTimer()
	arg_5_0:RefreshTime()
	arg_5_0:RegisterRedPoint()
end

function var_0_0.OnTop(arg_6_0)
	if arg_6_0.curLevelIndex_ == -1 then
		print("********** 没有一个关卡是开启的 ***************")
		arg_6_0:Back()

		return
	end

	arg_6_0.tree_:SelectGroup(arg_6_0.curLevelIndex_)
end

function var_0_0.OnLevelSelect(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if not arg_7_0.inited then
		return
	end

	if not DemonChallengeData:IsOpened(arg_7_1) then
		local var_7_0, var_7_1 = GetTips("OPEN_TIME")
		local var_7_2 = DemonChallengeData:GetLevelOpenTimeByIndex(arg_7_1)
		local var_7_3 = string.format(var_7_0, manager.time:GetLostTimeStr(var_7_2))

		manager.tips:ShowTips(var_7_3, var_7_1)
		arg_7_0.tree_:SelectGroup(arg_7_0.curLevelIndex_)

		return
	end

	arg_7_0:RefreshRewardRedPoint(arg_7_0.curLevelIndex_, arg_7_1)
	DemonChallengeData:SaveSelectLevelIndex(arg_7_1)

	if DemonChallengeData:IsSelected(arg_7_1) == false and not arg_7_0.tiemOut_ then
		DemonChallengeData:SaveSelected(arg_7_1)
	end

	arg_7_0.curLevelIndex_ = arg_7_1

	arg_7_0:RefreshUI()
end

function var_0_0.LevelRenderer(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:BindCfgUI(arg_8_2)

	arg_8_0.levelControllers_[arg_8_1] = ControllerUtil.GetController(arg_8_2.transform, "lock")

	arg_8_0.levelControllers_[arg_8_1]:SetSelectedState("false")

	local var_8_0 = arg_8_0.openTimeText_
	local var_8_1 = arg_8_0.levelNameText_

	arg_8_0.openTimeTextList_[arg_8_1] = var_8_0
	arg_8_0.levelNameTextList_[arg_8_1] = var_8_1

	arg_8_0:RefreshLevelName(arg_8_1)
end

function var_0_0.AddUIListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.rewardBtn_, nil, function()
		if arg_9_0.tiemOut_ then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("demonChallengeReward", {
			levelIndex = arg_9_0.curLevelIndex_
		})
	end)
	arg_9_0:AddBtnListener(arg_9_0.startBtn_, nil, function()
		if arg_9_0.tiemOut_ then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("/demonChallengeSelect", {
			levelIndex = arg_9_0.curLevelIndex_
		})
	end)
end

function var_0_0.RegisterRedPoint(arg_12_0)
	for iter_12_0 = 1, arg_12_0.levelCount_ do
		local var_12_0 = DemonChallengeData:GetRedPointConst(iter_12_0)

		manager.redPoint:bindUIandKey(arg_12_0.tree_:GetGroupRedPointContainerById(iter_12_0), RedPointConst[var_12_0])
	end
end

function var_0_0.UnRegisterRedPoint(arg_13_0)
	for iter_13_0 = 1, arg_13_0.levelCount_ do
		local var_13_0 = DemonChallengeData:GetRedPointConst(iter_13_0)

		manager.redPoint:unbindUIandKey(arg_13_0.tree_:GetGroupRedPointContainerById(iter_13_0), RedPointConst[var_13_0])
	end

	if arg_13_0.curLevelIndex_ ~= -1 then
		local var_13_1 = DemonChallengeData:GetRedPointConst(arg_13_0.curLevelIndex_)

		manager.redPoint:unbindUIandKey(arg_13_0.rewardBtn_.transform, RedPointConst[var_13_1])
	end
end

function var_0_0.RefreshRewardRedPoint(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = DemonChallengeData:GetRedPointConst(arg_14_1)

	manager.redPoint:unbindUIandKey(arg_14_0.rewardBtn_.transform, RedPointConst[var_14_0])

	local var_14_1 = DemonChallengeData:GetRedPointConst(arg_14_2)

	manager.redPoint:bindUIandKey(arg_14_0.rewardBtn_.transform, RedPointConst[var_14_1])

	if not DemonChallengeData:IsCompletedLevel(arg_14_2) then
		manager.redPoint:unbindUIandKey(arg_14_0.rewardBtn_.transform, RedPointConst[var_14_1])
	end
end

function var_0_0.RefreshUI(arg_15_0)
	arg_15_0:RefreshDescText()
	arg_15_0:RefreshRoleImg()
end

function var_0_0.RefreshRoleImg(arg_16_0)
	arg_16_0.roleImg_.sprite = DemonChallengeData:GetRoleImg(arg_16_0.curLevelIndex_)

	arg_16_0:AdaptImage()
end

function var_0_0.AdaptImage(arg_17_0)
	if arg_17_0.roleImageAdaptor_ == nil then
		arg_17_0.roleImageAdaptor_ = arg_17_0:FindCom("AdaptImage", nil, arg_17_0.roleImageTrs_)
	end

	arg_17_0.roleImageAdaptor_:AdaptImg()
end

function var_0_0.RefreshLevelName(arg_18_0, arg_18_1)
	arg_18_0.levelNameTextList_[arg_18_1].text = DemonChallengeData:GetLevelName(arg_18_1)
end

function var_0_0.RefreshTime(arg_19_0)
	local var_19_0 = DemonChallengeData:GetRemainTime()

	if var_19_0 - manager.time:GetServerTime() > 0 then
		arg_19_0.remainTimeText_.text = manager.time:GetLostTimeStr(var_19_0)
	else
		DemonChallengeData:SetAllRedPoint(0)

		arg_19_0.tiemOut_ = true
		arg_19_0.remainTimeText_.text = GetTips("TIME_OVER")

		arg_19_0:RemoveUpdatTimer()

		return
	end

	if arg_19_0.levelControllers_ ~= nil then
		for iter_19_0, iter_19_1 in pairs(arg_19_0.levelControllers_) do
			if arg_19_0.lastOpenStatusList_[iter_19_0] == false then
				local var_19_1 = DemonChallengeData:GetLevelOpenTimeByIndex(iter_19_0)
				local var_19_2 = var_19_1 - manager.time:GetServerTime() <= 0

				if var_19_2 == true then
					iter_19_1:SetSelectedState("true")
					DemonChallengeData:CalcRedPoint()
				else
					arg_19_0:RefreshOpenTimeText(iter_19_0, var_19_1)
				end

				arg_19_0.lastOpenStatusList_[iter_19_0] = var_19_2
			end
		end
	end
end

function var_0_0.RefreshOpenTimeText(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0.openTimeTextList_[arg_20_1].text = string.format("%s后开启", manager.time:GetLostTimeStr(arg_20_2))
end

function var_0_0.RefreshDescText(arg_21_0)
	arg_21_0.descText_.text = DemonChallengeData:GetDescText(arg_21_0.curLevelIndex_)
end

function var_0_0.AddUpdateTimer(arg_22_0)
	arg_22_0:RemoveUpdatTimer()

	arg_22_0.updateTimer_ = Timer.New(function()
		arg_22_0:RefreshTime()
	end, 1, -1)

	if arg_22_0.updateTimer_ then
		arg_22_0.updateTimer_:Start()
	end
end

function var_0_0.RemoveUpdatTimer(arg_24_0)
	if arg_24_0.updateTimer_ then
		arg_24_0.updateTimer_:Stop()

		arg_24_0.updateTimer_ = nil
	end
end

function var_0_0.OnExit(arg_25_0)
	arg_25_0:RemoveUpdatTimer()
	arg_25_0:UnRegisterRedPoint()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_26_0)
	if arg_26_0.tree_ then
		arg_26_0.tree_:Dispose()

		arg_26_0.tree_ = nil
	end

	var_0_0.super.Dispose(arg_26_0)
end

return var_0_0
