local var_0_0 = class("SpringWelfareSystemLetterView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeLetterPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.rewardUiList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.listGo_, SpringWelfareLetterRewardItem)
	arg_3_0.shareController_ = ControllerUtil.GetController(arg_3_0.transform_, "share")
	arg_3_0.arrowController_ = ControllerUtil.GetController(arg_3_0.transform_, "arrow")
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.letterServerId_ = arg_4_0.params_.letterServerId

	local var_4_0 = SpringWelfareData:GetLetterData(arg_4_0.letterServerId_)

	arg_4_0.firstView_ = arg_4_0.params_.firstView

	if arg_4_0.params_.gotReward == false then
		arg_4_0.gotReward_ = false
		arg_4_0.params_.gotReward = nil
	end

	arg_4_0.rewardList_ = SpringWelfareData:GetLetterData(arg_4_0.letterServerId_).rewardList

	arg_4_0:RefreshArrowUI()
	arg_4_0:RefreshUI()
end

function var_0_0.OnTop(arg_5_0)
	arg_5_0:OnEnter()
end

function var_0_0.OnExit(arg_6_0)
	AnimatorTools.Stop()
end

function var_0_0.OnTop(arg_7_0)
	SetActive(arg_7_0.gameObject_, true)
end

function var_0_0.OnBehind(arg_8_0)
	SetActive(arg_8_0.gameObject_, false)
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.rewardUiList_:Dispose()
	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.AddListeners(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.maskBtn_, nil, function()
		arg_10_0:OnClickClose()
	end)
	arg_10_0:AddBtnListener(arg_10_0.shareBtn_, nil, function()
		manager.share:Share(function()
			arg_10_0.shareController_:SetSelectedState("false")
		end, function()
			arg_10_0.shareController_:SetSelectedState("true")
		end, function()
			return
		end)
	end)
	arg_10_0:AddBtnListener(arg_10_0.leftArrowBtn_, nil, function()
		arg_10_0:JumpNextLetter(-1)
	end)
	arg_10_0:AddBtnListener(arg_10_0.rightArrowBtn_, nil, function()
		arg_10_0:JumpNextLetter(1)
	end)
end

function var_0_0.IndexItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.rewardList_[arg_18_1]
	local var_18_1 = var_18_0[1]
	local var_18_2 = var_18_0[2]

	arg_18_2:SetClickHandler(function(arg_19_0)
		ShowPopItem(POP_ITEM, {
			var_18_1
		})
	end)

	local var_18_3 = not arg_18_0.firstView_ or arg_18_0.gotReward_

	arg_18_2:SetData(var_18_1, var_18_2, var_18_3)
end

function var_0_0.RefreshUI(arg_20_0)
	arg_20_0:RefreshLetterUI()
	arg_20_0:RefreshHeroUI()
	arg_20_0:RefreshRewardList()
	arg_20_0.shareController_:SetSelectedState(arg_20_0.firstView_ and "false" or "true")
end

function var_0_0.RefreshLetterUI(arg_21_0)
	local var_21_0 = SpringWelfareData:GetLetterData(arg_21_0.letterServerId_).letterId

	arg_21_0.titleText_.text = GetTips(SpringPreheatData:GetLetterTitle(var_21_0))
	arg_21_0.contentText_.text = GetTips(SpringPreheatData:GetLetterFixedText(var_21_0, 1, 1))
end

function var_0_0.RefreshHeroUI(arg_22_0)
	local var_22_0 = arg_22_0:GetHeroId()
	local var_22_1 = HeroData:GetHeroData(var_22_0)
	local var_22_2 = HeroTools.GetHeadSprite(var_22_0)

	arg_22_0.heroImg_.sprite = var_22_2
	arg_22_0.heroNameText_.text = HeroTools.GetHeroFullName(var_22_0)
end

function var_0_0.RefreshRewardList(arg_23_0)
	arg_23_0.rewardUiList_:StartScrollWithoutAnimator(#arg_23_0.rewardList_)
	arg_23_0.rewardUiList_:Refresh()
end

function var_0_0.RefreshArrowUI(arg_24_0)
	if arg_24_0.firstView_ then
		arg_24_0.arrowController_:SetSelectedState("none")

		return
	end

	local var_24_0 = arg_24_0:GetLetterIdList()
	local var_24_1 = table.indexof(var_24_0, arg_24_0.letterServerId_)
	local var_24_2 = #var_24_0
	local var_24_3 = var_24_1 > 1
	local var_24_4 = var_24_1 < var_24_2

	if var_24_3 and var_24_4 then
		arg_24_0.arrowController_:SetSelectedState("both")
	elseif var_24_3 then
		arg_24_0.arrowController_:SetSelectedState("left")
	elseif var_24_4 then
		arg_24_0.arrowController_:SetSelectedState("right")
	else
		arg_24_0.arrowController_:SetSelectedState("none")
	end
end

function var_0_0.JumpNextLetter(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:GetLetterIdList()
	local var_25_1 = table.indexof(var_25_0, arg_25_0.letterServerId_)
	local var_25_2 = #var_25_0
	local var_25_3 = var_25_1 + arg_25_1

	if var_25_3 < 1 or var_25_2 < var_25_3 then
		return
	end

	arg_25_0:Back()
	JumpTools.OpenPageByJump("springWelfareSystemLetter", {
		letterServerId = var_25_0[var_25_3]
	})
end

function var_0_0.GetLetterIdList(arg_26_0)
	return SpringWelfareData:GetSystemLetterIdList()
end

function var_0_0.OnClickClose(arg_27_0)
	if not arg_27_0.firstView_ then
		arg_27_0:Back()

		return
	end

	if arg_27_0.gotReward_ then
		arg_27_0:Back()

		local var_27_0 = SpringWelfareData:GetNextNewPlayerLetterId()

		if var_27_0 then
			JumpTools.OpenPageByJump("springWelfarePlayerLetter", {
				firstView = true,
				letterServerId = var_27_0
			})
		end
	else
		local var_27_1 = SpringWelfareData:GetLetterData(arg_27_0.letterServerId_)

		SpringWelfareAction:AcquireLetterReward(var_27_1.day, function()
			arg_27_0.gotReward_ = true

			arg_27_0.rewardUiList_:Refresh()
			SpringWelfareAction:UpdateRedPoint(SpringWelfareData:GetActivityId())
		end)
	end
end

function var_0_0.GetHeroId(arg_29_0)
	return SpringWelfareData:GetLetterData(arg_29_0.letterServerId_).heroId
end

return var_0_0
