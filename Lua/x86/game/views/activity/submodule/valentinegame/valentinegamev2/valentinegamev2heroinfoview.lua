local var_0_0 = class("ValentineGameV2HeroInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaValentineUI/IndiaValentineStageUI"
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

	arg_4_0.stateController_ = ControllerUtil.GetController(arg_4_0.transform_, "state")
	arg_4_0.rewardList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, ValentineGameV2RewardItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.cfg_.reward_item_list[arg_5_1])
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.startBtn_, nil, function()
		if ActivityData:GetActivityIsOpen(arg_6_0.activityID_) then
			if ValentineGameData:GetData(arg_6_0.activityID_).isClear and type(ActivityValentineCfg[arg_6_0.activityID_].cost_item) == "table" and not checkGold(ActivityValentineCfg[arg_6_0.activityID_].cost_item[1][2], true) then
				return
			end

			JumpTools.OpenPageByJump("/valentineGameV2GameStartView", {
				activityID = arg_6_0.activityID_
			})
		elseif manager.time:GetServerTime() < ActivityData:GetActivityData(arg_6_0.activityID_).startTime then
			local var_7_0 = manager.time:GetLostTimeStr(ActivityData:GetActivityData(arg_6_0.activityID_).startTime)

			ShowTips(string.format(GetTips("OPEN_TIME"), var_7_0))
		else
			ShowTips(GetTips("TIME_OVER"))
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.rewardBtn_, nil, function()
		ValentineGameAction:GetReward(arg_6_0.activityID_)
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.activityID_ = arg_9_0.params_.activityID
	arg_9_0.cfg_ = ActivityValentineCfg[arg_9_0.activityID_]

	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.nameText_.text = arg_10_0.cfg_.name
	arg_10_0.desText_.text = arg_10_0.cfg_.desc

	local var_10_0 = ValentineGameData:GetData(arg_10_0.activityID_)

	arg_10_0.finishNumText_.text = #var_10_0.selectQuestionID .. "/" .. #arg_10_0.cfg_.hero_qa_id
	arg_10_0.heroImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. arg_10_0.cfg_.hero_id .. "_split_1")

	arg_10_0.heroImage_:SetNativeSize()
	arg_10_0.rewardList_:StartScroll(#arg_10_0.cfg_.reward_item_list)

	local var_10_1 = ValentineGameData:GetData(arg_10_0.activityID_)

	if var_10_1 and var_10_1.isReward then
		arg_10_0.stateController_:SetSelectedState("received")
	elseif var_10_1 and var_10_1.isClear then
		arg_10_0.stateController_:SetSelectedState("complete")
	else
		arg_10_0.stateController_:SetSelectedState("test")
	end

	if var_10_1 and var_10_1.isClear then
		SetActive(arg_10_0.costGo_, true)

		arg_10_0.costIcon_.sprite = getSprite("Atlas/Currency", arg_10_0.cfg_.cost_item[1][1])
		arg_10_0.costText_.text = arg_10_0.cfg_.cost_item[1][2]
	else
		SetActive(arg_10_0.costGo_, false)
	end
end

function var_0_0.OnTop(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_VALENTINE_DESCRIBE")
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnValentineGameReward(arg_13_0)
	arg_13_0:RefreshUI()
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.rewardList_ then
		arg_14_0.rewardList_:Dispose()

		arg_14_0.rewardList_ = nil
	end

	arg_14_0.super.Dispose(arg_14_0)
end

return var_0_0
