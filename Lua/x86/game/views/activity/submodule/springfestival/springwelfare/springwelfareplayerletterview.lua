local var_0_0 = class("SpringPreheatEditLetterView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreePopUI1"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
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

	arg_4_0.letterList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexTextItem), arg_4_0.letterUiListGo_, SpringWelfarePlayerLetterTextItem)
	arg_4_0.playerInfo_ = arg_4_0:GetLocalPlayerInfo()
	arg_4_0.shareController_ = ControllerUtil.GetController(arg_4_0.transform_, "share")
	arg_4_0.friendController_ = ControllerUtil.GetController(arg_4_0.playerTitleRect_, "newFriend")
	arg_4_0.stateController_ = ControllerUtil.GetController(arg_4_0.transform_, "state")
	arg_4_0.arrowController_ = ControllerUtil.GetController(arg_4_0.transform_, "arrow")
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
	arg_7_0.letterServerId_ = arg_7_0.params_.letterServerId

	local var_7_0 = SpringWelfareData:GetLetterData(arg_7_0.letterServerId_)

	arg_7_0.playerInfo_ = SpringWelfareData:GetPlayerInfo(var_7_0.playerId)

	for iter_7_0, iter_7_1 in ipairs(var_7_0.stickerList) do
		arg_7_0.stickerInfo_[iter_7_0].stickerID = iter_7_1.id
	end

	arg_7_0.firstView_ = arg_7_0.params_.firstView

	arg_7_0:RefreshUI()
	arg_7_0:RefreshArrowUI()
end

function var_0_0.OnTop(arg_8_0)
	arg_8_0:OnEnter()
end

function var_0_0.OnExit(arg_9_0)
	AnimatorTools.Stop()
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.letterList_:Dispose()
	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.AddListeners(arg_11_0)
	arg_11_0:AddBtnListener(arg_11_0.headBtn_, nil, function()
		ForeignInfoAction:TryToCheckForeignDetailInfo(arg_11_0.playerInfo_.uid)
	end)
	arg_11_0:AddBtnListener(arg_11_0.addFriendBtn_, nil, function()
		arg_11_0:OnClickAddFriendBtn()
	end)
	arg_11_0:AddBtnListener(arg_11_0.maskBtn_, nil, function()
		arg_11_0:OnClickClose()
	end)
	arg_11_0:AddBtnListener(arg_11_0.leftArrowBtn_, nil, function()
		arg_11_0:JumpNextLetter(-1)
	end)
	arg_11_0:AddBtnListener(arg_11_0.rightArrowBtn_, nil, function()
		arg_11_0:JumpNextLetter(1)
	end)
	arg_11_0:AddBtnListener(arg_11_0.shareBtn_, nil, function()
		manager.share:Share(function()
			arg_11_0.shareController_:SetSelectedState("true")
		end, function()
			arg_11_0.shareController_:SetSelectedState("false")
		end, function()
			return
		end)
	end)
end

function var_0_0.IndexTextItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = SpringWelfareData:GetLetterParagText(arg_21_0.letterServerId_, arg_21_1)

	arg_21_2:SetText(var_21_0)
end

function var_0_0.RefreshUI(arg_22_0)
	arg_22_0.stateController_:SetSelectedState("receiver")
	arg_22_0:RefreshPlayerUI()

	for iter_22_0 = 1, arg_22_0.stickerNum_ do
		arg_22_0:RefreshStickerUI(iter_22_0)
	end

	local var_22_0 = #SpringPreheatData:GetPlayerLetter().option_button_list

	arg_22_0.letterList_:StartScroll(var_22_0)
	arg_22_0.shareController_:SetSelectedState(arg_22_0.firstView_ and "true" or "false")
end

function var_0_0.RefreshPlayerUI(arg_23_0)
	local var_23_0 = arg_23_0.playerInfo_

	arg_23_0.playerNameText_.text = var_23_0.nick
	arg_23_0.playerIcon_.sprite = ItemTools.getItemSprite(var_23_0.icon)

	arg_23_0.playerIcon_:SetNativeSize()

	local var_23_1 = SpringWelfareData:GetLetterData(arg_23_0.letterServerId_)

	arg_23_0.letterDateText_.text = manager.time:STimeDescS(var_23_1.timestamp, "!%Y/%m/%d")

	local var_23_2 = SpringWelfareData:IsFriendOrInRequest(arg_23_0.playerInfo_.uid)

	arg_23_0.friendController_:SetSelectedState(var_23_2 and "send" or "add")
end

function var_0_0.RefreshStickerUI(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.stickerInfo_[arg_24_1]

	arg_24_0.stickerController_[arg_24_1]:SetSelectedState(var_24_0.stickerID > 0 and "active" or "add")

	local var_24_1 = arg_24_0.stickerImg_[arg_24_1]

	if var_24_0.stickerID > 0 and var_24_1 then
		var_24_1.sprite = ItemTools.getItemSprite(var_24_0.stickerID, {
			size = var_24_0.size
		})
	end

	arg_24_0.stickerFrameImg_[1].enabled = false
	arg_24_0.stickerFrameImg_[2].enabled = false

	SetActive(arg_24_0.stickerAddGo_1, false)
	SetActive(arg_24_0.stickerAddGo_2, false)
end

function var_0_0.RefreshArrowUI(arg_25_0)
	if arg_25_0.firstView_ then
		arg_25_0.arrowController_:SetSelectedState("none")

		return
	end

	local var_25_0 = arg_25_0:GetLetterIdList()
	local var_25_1 = table.indexof(var_25_0, arg_25_0.letterServerId_)
	local var_25_2 = #var_25_0
	local var_25_3 = var_25_1 > 1
	local var_25_4 = var_25_1 < var_25_2

	if var_25_3 and var_25_4 then
		arg_25_0.arrowController_:SetSelectedState("both")
	elseif var_25_3 then
		arg_25_0.arrowController_:SetSelectedState("left")
	elseif var_25_4 then
		arg_25_0.arrowController_:SetSelectedState("right")
	else
		arg_25_0.arrowController_:SetSelectedState("none")
	end
end

function var_0_0.JumpNextLetter(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:GetLetterIdList()
	local var_26_1 = table.indexof(var_26_0, arg_26_0.letterServerId_)
	local var_26_2 = #var_26_0
	local var_26_3 = var_26_1 + arg_26_1

	if var_26_3 < 1 or var_26_2 < var_26_3 then
		return
	end

	JumpTools.OpenPageByJump("springWelfarePlayerLetter", {
		letterServerId = var_26_0[var_26_3]
	})
end

function var_0_0.GetLetterIdList(arg_27_0)
	return SpringWelfareData:GetPlayerLetterIdList()
end

function var_0_0.OnClickClose(arg_28_0)
	arg_28_0:Back()
end

function var_0_0.OnClickAddFriendBtn(arg_29_0)
	FriendsAction:TryToRequestToFriend(arg_29_0.playerInfo_.uid, FriendConst.ADD_FRIEND_SOURCE.ACTIVITY_COMMON, SpringWelfareData:GetActivityId())
end

function var_0_0.OnFriendsListChange(arg_30_0)
	local var_30_0 = SpringWelfareData:IsFriendOrInRequest(arg_30_0.playerInfo_.uid)

	arg_30_0.friendController_:SetSelectedState(var_30_0 and "send" or "add")
end

function var_0_0.GetActivityID(arg_31_0)
	return arg_31_0.params_.activityId
end

return var_0_0
