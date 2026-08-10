local var_0_0 = class("DemonChallengeMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return nil
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.InitGo(arg_3_0, arg_3_1)
	if arg_3_0.gameObject_ then
		arg_3_0:Dispose()
		Object.Destroy(arg_3_0.gameObject_)
	end

	local var_3_0 = Asset.Load(arg_3_1)

	arg_3_0.gameObject_ = Object.Instantiate(var_3_0, arg_3_0:UIParent())
	arg_3_0.transform_ = arg_3_0.gameObject_.transform

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.tree_ = LuaTree.New(arg_4_0.treeGo_)

	arg_4_0.tree_:SetSelectedHandler(handler(arg_4_0, arg_4_0.OnLevelSelect))
	arg_4_0.tree_:SetRenderer(handler(arg_4_0, arg_4_0.LevelRenderer))

	arg_4_0.levelControllerS_ = {}
	arg_4_0.lockTextS_ = {}
	arg_4_0.iconS_ = {}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("demonChallengeAward", {
			selectId = arg_5_0.curSelectId_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.startBtn_, nil, function()
		JumpTools.OpenPageByJump("demonChallengeDifficultySelect", {
			selectId = arg_5_0.curSelectId_
		})
	end)

	if arg_5_0.talentBtn_ then
		arg_5_0:AddBtnListener(arg_5_0.talentBtn_, nil, function()
			local var_8_0 = ActivityTools.GetActivityTheme(arg_5_0.activityId_)
			local var_8_1 = TalentTreeTools.GetActivityIdByTheme(var_8_0)

			if var_8_1 then
				JumpTools.OpenPageByJump("/talentTree", {
					activityID = var_8_1
				})
			end
		end)
	end
end

function var_0_0.InitTree(arg_9_0)
	local var_9_0 = UITreeData.New()
	local var_9_1 = ActivityData:GetActivityData(arg_9_0.activityId_).subActivityIdList

	for iter_9_0 = 1, #var_9_1 do
		local var_9_2 = UITreeGroupData.New()

		var_9_2.id = var_9_1[iter_9_0]

		local var_9_3 = DemonChallengeTools.GetStageId(var_9_1[iter_9_0], 1)
		local var_9_4 = BattleHeartDemonStageCfg[var_9_3]

		if var_9_4 then
			var_9_2.text = GetI18NText(var_9_4.name)
		end

		var_9_0.groupDatas:Add(var_9_2)
	end

	arg_9_0.tree_:SetData(var_9_0)
end

function var_0_0.OnLevelSelect(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = ActivityData:GetActivityData(arg_10_2)

	if not var_10_0:IsActivitying() then
		if arg_10_0.curLevelIndex_ and arg_10_0.curLevelIndex_ ~= arg_10_1 then
			if var_10_0.stopTime <= manager.time:GetServerTime() then
				ShowTips("TIME_OVER")
			else
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_10_0.startTime)))
			end

			arg_10_0.tree_:SelectGroup(arg_10_0.curLevelIndex_)
		else
			arg_10_0.isNeedExit_ = true
		end

		return
	end

	arg_10_0:RefreshRewardRedPoint(arg_10_0.curSelectId_, arg_10_2)

	arg_10_0.curLevelIndex_ = arg_10_1
	arg_10_0.curSelectId_ = arg_10_2

	print("childId", childId)

	local var_10_1 = DemonChallengeTools.GetChildId(arg_10_0.curSelectId_, 1)
	local var_10_2 = getSpriteWithoutAtlas("TextureConfig/" .. DemonChallengeCfg[var_10_1].icon)

	if var_10_2 then
		arg_10_0.roleImg_.sprite = var_10_2
	end

	arg_10_0:RefreshDescText()
	SubDemonChallengeAction.SetSelectedActivityId(arg_10_2)
end

function var_0_0.LevelRenderer(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0.levelControllerS_[arg_11_1] == nil then
		arg_11_0.levelControllerS_[arg_11_1] = ControllerUtil.GetController(arg_11_2.transform, "lock")
	end

	arg_11_0.levelControllerS_[arg_11_1]:SetSelectedState("false")

	arg_11_0.lockTextS_[arg_11_1] = arg_11_0:FindCom(typeof(Text), "title/lock/text", arg_11_2.transform)

	local var_11_0 = arg_11_0:FindTrs("title/icon", arg_11_2.transform)

	if var_11_0 then
		arg_11_0.iconS_[arg_11_1] = var_11_0:GetComponent(typeof(Image))
	end

	if arg_11_0.iconS_[arg_11_1] then
		local var_11_1 = DemonChallengeTools.GetChildId(arg_11_1, 1)

		arg_11_0.iconS_[arg_11_1].sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/" .. DemonChallengeCfg[var_11_1].icon)
	end
end

function var_0_0.RefreshDescText(arg_12_0)
	local var_12_0 = DemonChallengeTools.GetStageId(arg_12_0.curSelectId_, 1)
	local var_12_1 = BattleHeartDemonStageCfg[var_12_0]

	if var_12_1 then
		arg_12_0.descText_.text = GetI18NText(var_12_1.tips)

		if arg_12_0.titleText_ then
			arg_12_0.titleText_.text = GetI18NText(var_12_1.name)
		end
	end
end

function var_0_0.RefreshTime(arg_13_0)
	local var_13_0 = ActivityData:GetActivityData(arg_13_0.activityId_)

	if var_13_0:GetRemainTime() >= 0 then
		arg_13_0.remainTimeText_.text = string.format(GetTips("TIME_DISPLAY_3"), manager.time:GetLostTimeStr(var_13_0.stopTime))
	end

	for iter_13_0, iter_13_1 in pairs(arg_13_0.lockTextS_) do
		local var_13_1 = ActivityData:GetActivityData(iter_13_0)

		if var_13_1:GetTimeBeforeStart() > 0 then
			arg_13_0.levelControllerS_[iter_13_0]:SetSelectedState("false")

			arg_13_0.lockTextS_[iter_13_0].text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_13_1.startTime))

			if arg_13_0.iconS_[iter_13_0] then
				arg_13_0.iconS_[iter_13_0].color = Color.gray
			end
		else
			arg_13_0.levelControllerS_[iter_13_0]:SetSelectedState("true")

			if arg_13_0.iconS_[iter_13_0] then
				arg_13_0.iconS_[iter_13_0].color = Color.white
			end
		end
	end
end

function var_0_0.RegisterRedPoint(arg_14_0)
	local var_14_0 = ActivityData:GetActivityData(arg_14_0.activityId_).subActivityIdList

	for iter_14_0 = 1, #var_14_0 do
		local var_14_1 = arg_14_0.tree_:GetGroupRedPointContainerById(var_14_0[iter_14_0])

		manager.redPoint:bindUIandKey(var_14_1, RedPointConst.DEMON_CHALLENGE .. var_14_0[iter_14_0])
	end
end

function var_0_0.UnRegisterRedPoint(arg_15_0)
	local var_15_0 = ActivityData:GetActivityData(arg_15_0.activityId_).subActivityIdList

	for iter_15_0 = 1, #var_15_0 do
		local var_15_1 = arg_15_0.tree_:GetGroupRedPointContainerById(var_15_0[iter_15_0])

		manager.redPoint:unbindUIandKey(var_15_1, RedPointConst.DEMON_CHALLENGE .. var_15_0[iter_15_0])
	end

	if arg_15_0.curSelectId_ then
		manager.redPoint:unbindUIandKey(arg_15_0.rewardBtn_.transform, RedPointConst.DEMON_CHALLENGE_REWARD .. arg_15_0.curSelectId_)
	end
end

function var_0_0.RefreshRewardRedPoint(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 then
		manager.redPoint:unbindUIandKey(arg_16_0.rewardBtn_.transform, RedPointConst.DEMON_CHALLENGE_REWARD .. arg_16_1)
	end

	manager.redPoint:bindUIandKey(arg_16_0.rewardBtn_.transform, RedPointConst.DEMON_CHALLENGE_REWARD .. arg_16_2)
end

function var_0_0.StartUpdateTimer(arg_17_0)
	arg_17_0:StopUpdatTimer()
	arg_17_0:RefreshTime()

	arg_17_0.updateTimer_ = Timer.New(function()
		arg_17_0:RefreshTime()
	end, 1, -1)

	arg_17_0.updateTimer_:Start()
end

function var_0_0.StopUpdatTimer(arg_19_0)
	if arg_19_0.updateTimer_ then
		arg_19_0.updateTimer_:Stop()

		arg_19_0.updateTimer_ = nil
	end
end

function var_0_0.OnEnter(arg_20_0)
	if not arg_20_0.activityId_ or arg_20_0.params_.activityID ~= arg_20_0.activityId_ then
		arg_20_0.activityId_ = arg_20_0.params_.activityID

		arg_20_0:InitGo(DemonChallengeTools.GetMainUIName(arg_20_0.params_.activityID))
		arg_20_0:InitTree()
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_OSIRIS_HEART_DEMON_CHALLENGE_DESCRIPE")
	arg_20_0:StartUpdateTimer()
	arg_20_0:RegisterRedPoint()

	if arg_20_0.params_.childId then
		local var_20_0 = ActivityData:GetActivityData(arg_20_0.activityId_).subActivityIdList
		local var_20_1 = table.indexof(var_20_0, arg_20_0.params_.childId)

		if var_20_1 then
			arg_20_0.tree_:SelectGroup(var_20_1)
		end

		arg_20_0.params_.childId = nil
	elseif arg_20_0.curLevelIndex_ then
		arg_20_0.tree_:SelectGroup(arg_20_0.curLevelIndex_)
	else
		arg_20_0.tree_:SelectGroup(1)
	end

	if arg_20_0.isNeedExit_ then
		ShowTips("TIME_OVER")

		arg_20_0.timer_ = Timer.New(function()
			JumpTools.Back()
		end, 0.2, 1)

		arg_20_0.timer_:Start()
	end
end

function var_0_0.OnExit(arg_22_0)
	arg_22_0:StopUpdatTimer()
	arg_22_0:UnRegisterRedPoint()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_23_0)
	var_0_0.super.Dispose(arg_23_0)
	arg_23_0.tree_:Dispose()

	arg_23_0.activityId_ = nil
end

return var_0_0
