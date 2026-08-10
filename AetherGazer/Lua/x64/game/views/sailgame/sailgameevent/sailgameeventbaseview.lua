local var_0_0 = class("SailGameEventBaseView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyagesBaseEventPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	if arg_5_0.cancelBtn_ then
		arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, function()
			arg_5_0:CancelEvent()
		end)
	end

	if arg_5_0.acceptBtn_ then
		arg_5_0:AddBtnListener(arg_5_0.acceptBtn_, nil, function()
			arg_5_0:AcceptEvent()
		end)
	end
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityID_ = arg_8_0.params_.activityID
	arg_8_0.curStageIndex_ = arg_8_0.params_.stageIndex
	arg_8_0.eventID_ = arg_8_0.params_.eventID

	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0:RefreshReward()
	arg_9_0:RefreshTitle()
end

function var_0_0.RefreshReward(arg_10_0)
	local var_10_0 = SailGameData:GetCurGameData(activityID).eventList[arg_10_0.curStageIndex_].rewardNum

	if var_10_0 > 0 then
		arg_10_0.rewardIcon_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_SKADI_SEA_COIN.item_id)
		arg_10_0.rewardNumText_.text = var_10_0

		SetActive(arg_10_0.rewardPanelGo_, true)
	else
		SetActive(arg_10_0.rewardPanelGo_, false)
	end
end

function var_0_0.RefreshTitle(arg_11_0)
	arg_11_0.titleText_.text = SailGameEventCfg[arg_11_0.eventID_].name
	arg_11_0.descText_.text = SailGameEventCfg[arg_11_0.eventID_].desc

	local var_11_0 = pureGetSpriteWithoutAtlas("TextureConfig/Fishing/FishPortrait/" .. SailGameEventCfg[arg_11_0.eventID_].picture)

	if var_11_0 then
		arg_11_0.roleIcon_.sprite = var_11_0
	end
end

function var_0_0.CancelEvent(arg_12_0)
	arg_12_0.tipsIndex_ = nil

	SailGameAction.EventOperate(arg_12_0.activityID_, arg_12_0.curStageIndex_, SailGameConst.EVENT_COMMON_OPERATE.OVER)
end

function var_0_0.AcceptEvent(arg_13_0)
	arg_13_0.tipsIndex_ = SailGameConst.GAME_COMMON_TIPS_INDEX.SUCCESS

	SailGameAction.EventOperate(arg_13_0.activityID_, arg_13_0.curStageIndex_, SailGameConst.EVENT_COMMON_OPERATE.OVER)
end

function var_0_0.OnEventOperateSuccess(arg_14_0)
	SailGameAction.SetEventEndMark(arg_14_0.activityID_, arg_14_0.tipsIndex_)
	SailGameTools.GoToGameView(arg_14_0.activityID_)
end

return var_0_0
