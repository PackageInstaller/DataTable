local var_0_0 = class("SeaWarfareMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_Navigation/QuanZhou_NavigationEnter"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddUIListener()
	arg_4_0:InitRewardList()
	arg_4_0:InitStageList()
	arg_4_0:InitController()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.startBattle_, nil, function()
		arg_5_0.needSkipUnloadModel_ = true

		arg_5_0:Go("/seaWarfareBattleReady", {
			stageID = arg_5_0.selectStageID_
		})
	end)
end

function var_0_0.InitRewardList(arg_7_0)
	arg_7_0.rewardItemList_ = {}
	arg_7_0.itemDataList_ = {}

	local var_7_0 = arg_7_0.rewardPanelTrans_.childCount

	for iter_7_0 = 1, var_7_0 do
		arg_7_0.rewardItemList_[iter_7_0] = CommonItemView.New(arg_7_0.rewardPanelTrans_:GetChild(iter_7_0 - 1).gameObject, true)
		arg_7_0.itemDataList_[iter_7_0] = clone(ItemTemplateData)
		arg_7_0.itemDataList_[iter_7_0].clickFun = function(arg_8_0)
			ShowPopItem(POP_ITEM, {
				arg_8_0.id,
				arg_8_0.number
			})
		end
	end
end

function var_0_0.InitStageList(arg_9_0)
	arg_9_0.stageItemList_ = {}
	arg_9_0.selectStageHandler_ = handler(arg_9_0, arg_9_0.OnSelectStage)
end

function var_0_0.InitController(arg_10_0)
	arg_10_0.completeController_ = arg_10_0.controllerEx_:GetController("complete")
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:InitCamera()
	arg_11_0:InitModel()
	arg_11_0:GetStageIDList()

	local var_11_0 = SeaWarfareTools.GetNeedFirstCompleteAnimStageID()

	if var_11_0 ~= nil then
		arg_11_0.selectStageID_ = var_11_0
	else
		arg_11_0.selectStageID_ = arg_11_0:GetDefaultSelectStageID()
	end

	arg_11_0:RefreshUI()
	arg_11_0:PlayEnterAnim()
end

function var_0_0.InitCamera(arg_12_0)
	QWorldMgr:EnableCustomCamera(SeaWarfareConst.CAMERA_GROUP_ID, 1, QWorldCameraLayer.System)
end

function var_0_0.InitModel(arg_13_0)
	arg_13_0.needSkipUnloadModel_ = false

	if not arg_13_0.params_.isBack then
		SeaWarfareModelView:GetInstance():Load()
	else
		SeaWarfareModelView:GetInstance():SwitchModelAnim(0)
	end
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0:CloseCamera()

	for iter_14_0, iter_14_1 in pairs(arg_14_0.stageItemList_) do
		iter_14_1:ResetAnim()
	end

	if not arg_14_0.needSkipUnloadModel_ then
		SeaWarfareModelView:GetInstance():Unload()
	end

	arg_14_0.params_.lastSelectStageID = arg_14_0.selectStageID_

	arg_14_0:StopAnim()
end

function var_0_0.CloseCamera(arg_15_0)
	QWorldMgr:ExitCustomCamera(SandplayCameraGroupCfg[SeaWarfareConst.CAMERA_GROUP_ID].camera[1])
end

function var_0_0.OnTop(arg_16_0)
	arg_16_0:UpdateBar()
end

function var_0_0.OnBehind(arg_17_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_18_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if SeaWarfareTools.GetIsGoBackFromBattle() then
			SeaWarfareTools.SetIsGoBackFromBattle(false)
			arg_18_0:Back()
		else
			JumpTools.OpenPageByJump("/qWorldBookletEntry")
		end
	end)
end

function var_0_0.GetStageIDList(arg_20_0)
	arg_20_0.stageIDList_ = SeaWarfareTools.GetStageIDList(SeaWarfareConst.STAGE_TYPE.CHALLENGE)
end

function var_0_0.GetDefaultSelectStageID(arg_21_0)
	if arg_21_0.params_.isBack then
		return arg_21_0.params_.lastSelectStageID
	else
		local var_21_0 = clone(arg_21_0.stageIDList_)

		table.sort(var_21_0, function(arg_22_0, arg_22_1)
			local var_22_0 = SeaWarfareTools.IsStageLock(arg_22_0)

			if var_22_0 ~= SeaWarfareTools.IsStageLock(arg_22_1) then
				return not var_22_0
			else
				local var_22_1 = SeaWarfareTools.IsStageCompleted(arg_22_0)

				if var_22_1 ~= SeaWarfareTools.IsStageCompleted(arg_22_1) then
					return not var_22_1
				else
					return arg_22_0 < arg_22_1
				end
			end
		end)

		return var_21_0[1]
	end
end

function var_0_0.RefreshUI(arg_23_0)
	arg_23_0:RefreshStageList()
	arg_23_0:RefreshStageSelect()
	arg_23_0:RefreshStage()
end

function var_0_0.RefreshStageList(arg_24_0)
	for iter_24_0, iter_24_1 in ipairs(arg_24_0.stageIDList_) do
		if not arg_24_0.stageItemList_[iter_24_0] then
			local var_24_0 = Object.Instantiate(arg_24_0.stageItemGo_, arg_24_0.stageItemContentTrans_)

			SetActive(var_24_0, true)

			arg_24_0.stageItemList_[iter_24_0] = SeaWarfareStageItem.New(var_24_0)
		end

		arg_24_0:IndexItem(iter_24_0, arg_24_0.stageItemList_[iter_24_0])
	end
end

function var_0_0.IndexItem(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0.stageIDList_[arg_25_1]

	arg_25_2:SetData(var_25_0, arg_25_1)
	arg_25_2:SetSelect(var_25_0 == arg_25_0.selectStageID_)
	arg_25_2:SetClickCallback(arg_25_0.selectStageHandler_)
end

function var_0_0.OnSelectStage(arg_26_0, arg_26_1)
	if arg_26_0.selectStageID_ == arg_26_1 then
		return
	end

	arg_26_0.selectStageID_ = arg_26_1

	arg_26_0:RefreshStageSelect()
	arg_26_0:RefreshStage()
end

function var_0_0.RefreshStageSelect(arg_27_0)
	for iter_27_0, iter_27_1 in pairs(arg_27_0.stageItemList_) do
		local var_27_0 = iter_27_1:GetStageID()

		iter_27_1:SetSelect(var_27_0 == arg_27_0.selectStageID_)
	end
end

function var_0_0.RefreshStage(arg_28_0)
	arg_28_0:RefreshStageInfo()
	arg_28_0:RefreshReward()
end

function var_0_0.RefreshStageInfo(arg_29_0)
	local var_29_0 = SeaWarfareStageCfg[arg_29_0.selectStageID_].stage_id
	local var_29_1 = BattleSeaWarfareStageCfg[var_29_0]

	arg_29_0.stageName_.text = var_29_1.name
	arg_29_0.stageDesc_.text = var_29_1.tips
end

function var_0_0.RefreshReward(arg_30_0)
	arg_30_0:RefreshRewardState()
	arg_30_0:RefreshRewardItem()
end

function var_0_0.RefreshRewardState(arg_31_0)
	local var_31_0 = SeaWarfareTools.IsStageCompleted(arg_31_0.selectStageID_)

	arg_31_0.completeController_:SetSelectedState(var_31_0 and "on" or "off")
end

function var_0_0.RefreshRewardItem(arg_32_0)
	local var_32_0 = SeaWarfareStageCfg[arg_32_0.selectStageID_].reward
	local var_32_1 = getRewardFromDropCfg(var_32_0, true)
	local var_32_2 = SeaWarfareTools.IsStageCompleted(arg_32_0.selectStageID_)

	for iter_32_0, iter_32_1 in ipairs(var_32_1) do
		arg_32_0.itemDataList_[iter_32_0].id = iter_32_1.id
		arg_32_0.itemDataList_[iter_32_0].number = iter_32_1.num

		arg_32_0.rewardItemList_[iter_32_0]:SetData(arg_32_0.itemDataList_[iter_32_0])
		arg_32_0.rewardItemList_[iter_32_0]:RefreshGray(var_32_2)
		arg_32_0.rewardItemList_[iter_32_0]:RefreshCompleted(var_32_2)
	end

	for iter_32_2 = #var_32_1 + 1, #arg_32_0.rewardItemList_ do
		arg_32_0.rewardItemList_[iter_32_2]:SetData(nil)
	end
end

function var_0_0.Dispose(arg_33_0)
	for iter_33_0, iter_33_1 in ipairs(arg_33_0.stageItemList_) do
		iter_33_1:Dispose()
	end

	for iter_33_2, iter_33_3 in pairs(arg_33_0.rewardItemList_) do
		iter_33_3:Dispose()
	end

	var_0_0.super.Dispose(arg_33_0)
end

function var_0_0.StopAnim(arg_34_0)
	if arg_34_0.enterAnimTimer_ then
		arg_34_0.enterAnimTimer_:Stop()

		arg_34_0.enterAnimTimer_ = nil
	end

	if arg_34_0.checkActiveTimer_ then
		arg_34_0.checkActiveTimer_:Stop()

		arg_34_0.checkActiveTimer_ = nil
	end
end

function var_0_0.PlayEnterAnim(arg_35_0)
	arg_35_0:StopAnim()

	arg_35_0.checkActiveTimer_ = FrameTimer.New(function()
		if arg_35_0.gameObject_.activeInHierarchy then
			arg_35_0.checkActiveTimer_:Stop()

			arg_35_0.checkActiveTimer_ = nil
			arg_35_0.enterAnimTimer_ = SeaWarfareTools.PlayAnim(arg_35_0.enterAnim_, "UI_right_cx", handler(arg_35_0, arg_35_0.PlayStageCompletedAnim))
		end
	end, 1, -1)

	arg_35_0.checkActiveTimer_:Start()
end

function var_0_0.PlayStageCompletedAnim(arg_37_0)
	arg_37_0.firstCompleteStageID_ = SeaWarfareTools.GetNeedFirstCompleteAnimStageID()

	if not arg_37_0.firstCompleteStageID_ then
		return
	end

	for iter_37_0, iter_37_1 in pairs(arg_37_0.stageItemList_) do
		if iter_37_1:GetStageID() == arg_37_0.firstCompleteStageID_ then
			SeaWarfareTools.SetNeedFirstCompleteAnimStageID(nil)
			iter_37_1:PlayCompletedAnim(handler(arg_37_0, arg_37_0.OnStageCompletedAnimEnd))

			break
		end
	end
end

function var_0_0.OnStageCompletedAnimEnd(arg_38_0)
	arg_38_0.firstUnlockStageID_ = SeaWarfareTools.GetNeedFirstUnlockAnimStageID()

	if not arg_38_0.firstUnlockStageID_ then
		return
	end

	for iter_38_0, iter_38_1 in pairs(arg_38_0.stageItemList_) do
		if iter_38_1:GetStageID() == arg_38_0.firstUnlockStageID_ then
			SeaWarfareTools.SetNeedFirstUnlockAnimStageID(nil)
			iter_38_1:PlayUnlockAnim(handler(arg_38_0, arg_38_0.OnStageUnlockAnimEnd))

			break
		end
	end
end

function var_0_0.OnStageUnlockAnimEnd(arg_39_0)
	if arg_39_0.selectStageID_ == arg_39_0.firstCompleteStageID_ and arg_39_0.firstUnlockStageID_ then
		arg_39_0.selectStageID_ = arg_39_0.firstUnlockStageID_

		arg_39_0:RefreshUI()
	end
end

return var_0_0
