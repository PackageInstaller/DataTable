local var_0_0 = class("FireWorkMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/EmptyDream/Firework/FireworkMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.headList = LuaList.New(handler(arg_4_0, arg_4_0.IndexHeadItem), arg_4_0.m_roleList, FireWorkHeadItem)
	arg_4_0.rewardList = LuaList.New(handler(arg_4_0, arg_4_0.IndexRewardItem), arg_4_0.m_rewardList, CommonItem)
	arg_4_0.stateController = ControllerUtil.GetController(arg_4_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_receiveBtn, nil, function()
		FireWorkAction.QueryReceiveReward(arg_5_0.select)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_reviewBtn, nil, function()
		JumpTools.OpenPageByJump("/fireWorkShow", {
			fire_activity_id = arg_5_0.select
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_inviteBtn, nil, function()
		JumpTools.OpenPageByJump("fireWorkMake", {
			start = true,
			fire_activity_id = arg_5_0.select
		})
	end)
end

function var_0_0.OnTop(arg_9_0)
	local var_9_0 = GameSetting.activity_firework_describe and GameSetting.activity_firework_describe.value or {}

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = var_9_0
		}
	})
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.activity_id = ActivityConst.FIRE_WORK
	arg_10_0.sub_activity_list = ActivityCfg[arg_10_0.activity_id].sub_activity_list

	if arg_10_0.params_.fire_activity_id then
		arg_10_0.select = arg_10_0.params_.fire_activity_id
		arg_10_0.params_.fire_activity_id = nil
	end

	if arg_10_0.select == nil or not ActivityData:GetActivityIsOpen(arg_10_0.select) then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0.sub_activity_list) do
			if ActivityData:GetActivityIsOpen(iter_10_1) then
				arg_10_0.select = iter_10_1

				break
			end
		end
	end

	local var_10_0 = table.indexof(arg_10_0.sub_activity_list, arg_10_0.select) or 1

	arg_10_0.headList:StartScroll(#arg_10_0.sub_activity_list, var_10_0, true)
	arg_10_0:RefreshUI()
	arg_10_0:RefrenTime()

	arg_10_0.timer = Timer.New(function()
		arg_10_0:RefrenTime()
	end, 1, -1)

	arg_10_0.timer:Start()

	local var_10_1 = GameSetting.activity_firework_story.value[1]

	if var_10_1 and not manager.story:IsStoryPlayed(var_10_1) then
		manager.story:StartStoryById(var_10_1, function(arg_12_0)
			return
		end)
	end
end

function var_0_0.OnExit(arg_13_0)
	manager.windowBar:HideBar()

	if arg_13_0.timer then
		arg_13_0.timer:Stop()

		arg_13_0.timer = nil
	end

	local var_13_0 = arg_13_0.headList:GetItemList()

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		iter_13_1:OnExit()
	end
end

function var_0_0.RefrenTime(arg_14_0)
	local var_14_0 = ActivityData:GetActivityData(arg_14_0.activity_id)

	if var_14_0 and var_14_0:IsActivitying() then
		arg_14_0.m_timeLab.text = manager.time:GetLostTimeStr(var_14_0.stopTime)
	else
		arg_14_0.m_timeLab.text = GetTips("TIME_OVER")
	end

	local var_14_1 = arg_14_0.headList:GetItemList()

	for iter_14_0, iter_14_1 in pairs(var_14_1) do
		iter_14_1:RefrenTime()
	end
end

function var_0_0.RefreshUI(arg_15_0)
	if arg_15_0.select and ActivityFireWorkCfg[arg_15_0.select] then
		local var_15_0 = ActivityFireWorkCfg[arg_15_0.select]

		FireWorkAction.SetRead(arg_15_0.select)

		arg_15_0.m_roleDes.text = GetI18NText(var_15_0.desc)
		arg_15_0.m_roleIcon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/EmptyDream/letter_role_title/" .. var_15_0.icon)
		arg_15_0.rewards = var_15_0.reward_item_list

		arg_15_0.rewardList:StartScroll(#arg_15_0.rewards)

		local var_15_1 = FireWorkData:GetInvited(arg_15_0.select)

		if FireWorkData:GetReward(arg_15_0.select) then
			arg_15_0.stateController:SetSelectedIndex(2)
		elseif var_15_1 then
			arg_15_0.stateController:SetSelectedIndex(1)
		else
			arg_15_0.stateController:SetSelectedIndex(0)
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.FIRE_WORK_OPEN, arg_15_0.select), 0)
	else
		arg_15_0.m_roleIcon.sprite = nil
		arg_15_0.m_roleDes.text = ""

		arg_15_0.rewardList:StartScroll(0)
		arg_15_0.stateController:SetSelectedIndex(0)
	end
end

function var_0_0.HeadClick(arg_16_0, arg_16_1)
	arg_16_0.select = arg_16_1

	arg_16_0:RefreshUI()

	local var_16_0 = arg_16_0.headList:GetItemList()

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		iter_16_1:UpdateSelect(arg_16_0.select)
	end
end

function var_0_0.IndexHeadItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.sub_activity_list[arg_17_1]

	arg_17_2:SetData(var_17_0)
	arg_17_2:UpdateSelect(arg_17_0.select)
	arg_17_2:RegistCallBack(handler(arg_17_0, arg_17_0.HeadClick))
end

function var_0_0.IndexRewardItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.rewards[arg_18_1]

	arg_18_2:RefreshData(formatReward(var_18_0))
	arg_18_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_18_0)
	end)
end

function var_0_0.Dispose(arg_20_0)
	arg_20_0.headList:Dispose()
	arg_20_0.rewardList:Dispose()
	var_0_0.super.Dispose(arg_20_0)
end

function var_0_0.OnFireWordUpdate(arg_21_0)
	arg_21_0:RefreshUI()
end

return var_0_0
