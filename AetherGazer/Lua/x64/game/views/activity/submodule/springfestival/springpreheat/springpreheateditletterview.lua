local var_0_0 = class("SpringPreheatEditLetterView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreePopUI1"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	arg_3_0.stickerNum_ = 2
	arg_3_0.stickerBtn_ = {}
	arg_3_0.stickerImg_ = {}
	arg_3_0.stickerFrameImg_ = {}
	arg_3_0.stickerInfo_ = {}
	arg_3_0.stickerController_ = {}
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()

	for iter_4_0 = 1, arg_4_0.stickerNum_ do
		arg_4_0.stickerInfo_[iter_4_0] = arg_4_0:CreateEmptyStickerInfo()

		local var_4_0 = arg_4_0[string.format("stickerBtn_%d", iter_4_0)]

		arg_4_0.stickerBtn_[iter_4_0] = var_4_0
		arg_4_0.stickerController_[iter_4_0] = ControllerUtil.GetController(var_4_0.transform, "state")
		arg_4_0.stickerImg_[iter_4_0] = arg_4_0[string.format("stickerImg_%d", iter_4_0)]
		arg_4_0.stickerFrameImg_[iter_4_0] = arg_4_0[string.format("stickerFrameImg_%d", iter_4_0)]
	end

	arg_4_0:AddListeners()

	arg_4_0.letterList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexTextItem), arg_4_0.letterUiListGo_, SpringPreheatLetterTextItem)
	arg_4_0.playerInfo_ = arg_4_0:GetLocalPlayerInfo()
	arg_4_0.stateController_ = ControllerUtil.GetController(arg_4_0.transform_, "state")

	arg_4_0.stateController_:SetSelectedState("writing")
end

function var_0_0.CreateEmptyStickerInfo(arg_5_0)
	return {
		stickerID = 0,
		size = 1
	}
end

function var_0_0.GetLocalPlayerInfo(arg_6_0)
	local var_6_0 = PlayerData:GetPlayerInfo()

	return {
		user_id = var_6_0.userID,
		nick = var_6_0.nick,
		icon = var_6_0.portrait,
		icon_frame = var_6_0.icon_frame
	}
end

function var_0_0.OnEnter(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(handler(arg_7_0, arg_7_0.OnClickBackBtn))
	arg_7_0:RefreshUI()
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()
	AnimatorTools.Stop()
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.letterList_:Dispose()
	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.AddListeners(arg_10_0)
	for iter_10_0 = 1, arg_10_0.stickerNum_ do
		local var_10_0 = arg_10_0.stickerBtn_[iter_10_0]

		if var_10_0 then
			arg_10_0:AddBtnListener(var_10_0, nil, function()
				arg_10_0:SelectSticker(iter_10_0)
			end)
		end
	end

	arg_10_0:AddBtnListener(arg_10_0.sendBtn_, nil, function()
		arg_10_0:TrySendBlessingLetter()
	end)
	arg_10_0:AddBtnListener(arg_10_0.resetBtn_, nil, function()
		arg_10_0:ResetLetter()
	end)
	arg_10_0:AddBtnListener(arg_10_0.maskBtn_, nil, function()
		return
	end)
	arg_10_0:RegistEventListener(NEW_DAY, handler(arg_10_0, arg_10_0.OnNewDay))
end

function var_0_0.IndexTextItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.selectingImg_ and arg_15_0.selectingImg_.sprite or nil
	local var_15_1 = arg_15_0.selectedImg_ and arg_15_0.selectedImg_.sprite or nil

	arg_15_2:SetData(arg_15_1, var_15_0, var_15_1)
end

function var_0_0.RefreshUI(arg_16_0, arg_16_1)
	local var_16_0 = manager.time:GetServerTime()
	local var_16_1 = manager.time:STimeDescS(var_16_0, "!%Y/%m/%d")

	arg_16_0.letterDateText_.text = var_16_1
	arg_16_0.tipsText_.text = GetTips("SPRING_PREHEAT_TITLE_TIPS")
	arg_16_0.resetText_.text = GetTips("SPRING_PREHEAT_RESET")

	arg_16_0:RefreshPlayerUI()

	for iter_16_0 = 1, arg_16_0.stickerNum_ do
		arg_16_0:RefreshStickerUI(iter_16_0)
	end

	if not arg_16_1 then
		local var_16_2 = #SpringPreheatData:GetPlayerLetter().option_button_list

		arg_16_0.letterList_:StartScroll(var_16_2)
	end
end

function var_0_0.RefreshPlayerUI(arg_17_0)
	local var_17_0 = arg_17_0.playerInfo_

	arg_17_0.playerNameText_.text = var_17_0.nick
	arg_17_0.playerIcon_.sprite = ItemTools.getItemSprite(var_17_0.icon)

	arg_17_0.playerIcon_:SetNativeSize()
end

function var_0_0.SelectSticker(arg_18_0, arg_18_1)
	if arg_18_0.isAniPlaying_ or arg_18_0.isStaying_ then
		return
	end

	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.stickerInfo_) do
		if iter_18_1.stickerID ~= 0 then
			table.insert(var_18_0, iter_18_1.stickerID)
		end
	end

	JumpTools.OpenPageByJump("springPreheatLetterSelect", {
		isStickerMode = true,
		usedList = var_18_0,
		info = arg_18_0.stickerInfo_[arg_18_1],
		index = arg_18_1,
		onChangeSticker = handler(arg_18_0, arg_18_0.OnChangeSticker)
	})
end

function var_0_0.OnChangeSticker(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0.stickerInfo_) do
		if iter_19_1.stickerID == arg_19_2 then
			arg_19_0.stickerInfo_[iter_19_0] = arg_19_0:CreateEmptyStickerInfo()
		end
	end

	arg_19_0.stickerInfo_[arg_19_1] = {
		stickerID = arg_19_2,
		size = arg_19_3
	}

	for iter_19_2 = 1, arg_19_0.stickerNum_ do
		arg_19_0:RefreshStickerUI(iter_19_2)
	end
end

function var_0_0.RefreshStickerUI(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.stickerInfo_[arg_20_1]

	arg_20_0.stickerController_[arg_20_1]:SetSelectedState(var_20_0.stickerID > 0 and "active" or "add")

	local var_20_1 = arg_20_0.stickerImg_[arg_20_1]

	if var_20_0.stickerID > 0 and var_20_1 then
		var_20_1.sprite = ItemTools.getItemSprite(var_20_0.stickerID, {
			size = var_20_0.size
		})
	end
end

function var_0_0.TrySendBlessingLetter(arg_21_0)
	local var_21_0 = arg_21_0.playerInfo_.user_id
	local var_21_1 = {}

	for iter_21_0 = 1, arg_21_0.stickerNum_ do
		local var_21_2 = arg_21_0.stickerInfo_[iter_21_0]

		table.insert(var_21_1, var_21_2.stickerID)
	end

	local var_21_3 = {}
	local var_21_4 = SpringPreheatData:GetPlayerLetter()

	for iter_21_1, iter_21_2 in pairs(arg_21_0.letterList_:GetItemList()) do
		local var_21_5 = iter_21_2:GetLetterInfo()

		for iter_21_3 = 1, #var_21_5 do
			if SpringPreheatData:IsEnableOption(var_21_4.id, iter_21_1, iter_21_3) then
				local var_21_6 = var_21_5[iter_21_3]

				if var_21_6 == 0 then
					ShowTips("SPRING_PREHEAT_WORD_NOT_SELECT")

					return
				end

				local var_21_7 = SpringPreheatData:GetLetterOptionList(var_21_4.id, iter_21_1, iter_21_3)
				local var_21_8 = table.indexof(var_21_7, var_21_6)

				table.insert(var_21_3, var_21_8)
			end
		end
	end

	SpringPreheatAction:SendBlessingLetter(var_21_0, var_21_3, var_21_1, function()
		arg_21_0:PlayEffect(handler(arg_21_0, arg_21_0.OnFinishSendBlessingLetter))
	end)
end

function var_0_0.PlayEffect(arg_23_0, arg_23_1)
	arg_23_0:SwitchSendingMode(true)

	local var_23_0 = GameSetting.spring_preheat_2_8_watingtime.value[1]

	arg_23_0.isStaying_ = true

	Timer.New(function()
		if arg_23_0.sendLetterAni_ then
			manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_preheat_sent", "")

			arg_23_0.isAniPlaying_ = true

			arg_23_0.sendLetterAni_:Play("PopUI1_send", -1, 0)
			arg_23_0.sendLetterAni_:Update(0)
			AnimatorTools.PlayAnimationWithCallback(arg_23_0.sendLetterAni_, "PopUI1_send", function()
				arg_23_0.isAniPlaying_ = false

				arg_23_1()
			end)
		else
			arg_23_1()
		end

		arg_23_0.isStaying_ = false
	end, var_23_0, 0):Start()
end

function var_0_0.OnFinishSendBlessingLetter(arg_26_0)
	if arg_26_0.params_.onFinishSendLetter then
		arg_26_0.params_.onFinishSendLetter()
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_26_0:Back()

	local var_26_0 = GameSetting.spring_preheat_2_8_story.value[2]

	if var_26_0 and not manager.story:IsStoryPlayed(var_26_0) then
		manager.story:StartStoryById(var_26_0, function(arg_27_0)
			JumpTools.OpenPageByJump("/springPreheatBlank/springPreheatPray", {})
		end)

		return
	end

	JumpTools.OpenPageByJump("/springPreheatBlank/springPreheatPray", {})
end

function var_0_0.ResetLetter(arg_28_0)
	for iter_28_0, iter_28_1 in pairs(arg_28_0.letterList_:GetItemList()) do
		iter_28_1:ResetLetterInfo()
	end

	for iter_28_2 = 1, #arg_28_0.stickerInfo_ do
		arg_28_0.stickerInfo_[iter_28_2] = arg_28_0:CreateEmptyStickerInfo()
	end

	arg_28_0:RefreshUI(true)
	arg_28_0.sendLetterAni_:Play("btn", -1, 0)
end

function var_0_0.SwitchSendingMode(arg_29_0, arg_29_1)
	arg_29_0.stateController_:SetSelectedState(arg_29_1 and "preview" or "writing")

	arg_29_0.stickerFrameImg_[1].enabled = not arg_29_1
	arg_29_0.stickerFrameImg_[2].enabled = not arg_29_1

	SetActive(arg_29_0.stickerAddGo_1, not arg_29_1)
	SetActive(arg_29_0.stickerAddGo_2, not arg_29_1)

	for iter_29_0, iter_29_1 in pairs(arg_29_0.letterList_:GetItemList()) do
		iter_29_1:SetSendingMode(arg_29_1)
		iter_29_1:RefreshUI()
	end

	if arg_29_1 then
		manager.windowBar:HideBar()
	end
end

function var_0_0.OnNewDay(arg_30_0)
	arg_30_0:SwitchSendingMode(false)
	arg_30_0:ResetLetter()
end

function var_0_0.OnClickBackBtn(arg_31_0)
	if arg_31_0.isAniPlaying_ or arg_31_0.isStaying_ then
		return
	end

	JumpTools.Back()
	JumpTools.Back()
end

function var_0_0.GetActivityID(arg_32_0)
	return arg_32_0.params_.activityId
end

return var_0_0
