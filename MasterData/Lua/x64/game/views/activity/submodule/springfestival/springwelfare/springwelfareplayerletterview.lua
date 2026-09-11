local SpringPreheatEditLetterView = class("SpringPreheatEditLetterView", ReduxView)

function SpringPreheatEditLetterView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreePopUI1"
end

function SpringPreheatEditLetterView:UIParent()
	return manager.ui.uiPop.transform
end

function SpringPreheatEditLetterView:OnCtor()
	self.stickerNum_ = 2
	self.stickerBtn_ = {}
	self.stickerImg_ = {}
	self.stickerFrameImg_ = {}
	self.stickerInfo_ = {}
	self.stickerController_ = {}
end

function SpringPreheatEditLetterView:Init()
	self:BindCfgUI()

	for iter_4_0 = 1, self.stickerNum_ do
		self.stickerInfo_[iter_4_0] = self:CreateEmptyStickerInfo()

		local var_4_0 = self[string.format("stickerBtn_%d", iter_4_0)]

		self.stickerBtn_[iter_4_0] = var_4_0
		self.stickerController_[iter_4_0] = ControllerUtil.GetController(var_4_0.transform, "state")
		self.stickerImg_[iter_4_0] = self[string.format("stickerImg_%d", iter_4_0)]
		self.stickerFrameImg_[iter_4_0] = self[string.format("stickerFrameImg_%d", iter_4_0)]
	end

	self:AddListeners()

	self.letterList_ = LuaList.New(handler(self, self.IndexTextItem), self.letterUiListGo_, SpringWelfarePlayerLetterTextItem)
	self.playerInfo_ = self:GetLocalPlayerInfo()
	self.shareController_ = ControllerUtil.GetController(self.transform_, "share")
	self.friendController_ = ControllerUtil.GetController(self.playerTitleRect_, "newFriend")
	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")
	self.arrowController_ = ControllerUtil.GetController(self.transform_, "arrow")
end

function SpringPreheatEditLetterView:CreateEmptyStickerInfo()
	return {
		stickerID = 0,
		size = 1
	}
end

function SpringPreheatEditLetterView:GetLocalPlayerInfo()
	local var_6_0 = PlayerData:GetPlayerInfo()

	return {
		user_id = var_6_0.userID,
		nick = var_6_0.nick,
		icon = var_6_0.portrait,
		icon_frame = var_6_0.icon_frame
	}
end

function SpringPreheatEditLetterView:OnEnter()
	self.letterServerId_ = self.params_.letterServerId

	local var_7_0 = SpringWelfareData:GetLetterData(self.letterServerId_)

	self.playerInfo_ = SpringWelfareData:GetPlayerInfo(var_7_0.playerId)

	for iter_7_0, iter_7_1 in ipairs(var_7_0.stickerList) do
		self.stickerInfo_[iter_7_0].stickerID = iter_7_1.id
	end

	self.firstView_ = self.params_.firstView

	self:RefreshUI()
	self:RefreshArrowUI()
end

function SpringPreheatEditLetterView:OnTop()
	self:OnEnter()
end

function SpringPreheatEditLetterView:OnExit()
	AnimatorTools.Stop()
end

function SpringPreheatEditLetterView:Dispose()
	self.letterList_:Dispose()
	SpringPreheatEditLetterView.super.Dispose(self)
end

function SpringPreheatEditLetterView:AddListeners()
	self:AddBtnListener(self.headBtn_, nil, function()
		ForeignInfoAction:TryToCheckForeignDetailInfo(self.playerInfo_.uid)
	end)
	self:AddBtnListener(self.addFriendBtn_, nil, function()
		self:OnClickAddFriendBtn()
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:OnClickClose()
	end)
	self:AddBtnListener(self.leftArrowBtn_, nil, function()
		self:JumpNextLetter(-1)
	end)
	self:AddBtnListener(self.rightArrowBtn_, nil, function()
		self:JumpNextLetter(1)
	end)
	self:AddBtnListener(self.shareBtn_, nil, function()
		manager.share:Share(function()
			self.shareController_:SetSelectedState("true")
		end, function()
			self.shareController_:SetSelectedState("false")
		end, function()
			return
		end)
	end)
end

function SpringPreheatEditLetterView:IndexTextItem(arg_21_1, arg_21_2)
	arg_21_2:SetText((SpringWelfareData:GetLetterParagText(self.letterServerId_, arg_21_1)))
end

function SpringPreheatEditLetterView:RefreshUI()
	self.stateController_:SetSelectedState("receiver")
	self:RefreshPlayerUI()

	for iter_22_0 = 1, self.stickerNum_ do
		self:RefreshStickerUI(iter_22_0)
	end

	self.letterList_:StartScroll(#SpringPreheatData:GetPlayerLetter().option_button_list)
	self.shareController_:SetSelectedState(self.firstView_ and "true" or "false")
end

function SpringPreheatEditLetterView:RefreshPlayerUI()
	self.playerNameText_.text = self.playerInfo_.nick
	self.playerIcon_.sprite = ItemTools.getItemSprite(self.playerInfo_.icon)

	self.playerIcon_:SetNativeSize()

	self.letterDateText_.text = manager.time:STimeDescS(SpringWelfareData:GetLetterData(self.letterServerId_).timestamp, "!%Y/%m/%d")

	self.friendController_:SetSelectedState(SpringWelfareData:IsFriendOrInRequest(self.playerInfo_.uid) and "send" or "add")
end

function SpringPreheatEditLetterView:RefreshStickerUI(arg_24_1)
	local var_24_0 = self.stickerInfo_[arg_24_1]

	self.stickerController_[arg_24_1]:SetSelectedState(self.stickerInfo_[arg_24_1].stickerID > 0 and "active" or "add")

	if var_24_0.stickerID > 0 and self.stickerImg_[arg_24_1] then
		self.stickerImg_[arg_24_1].sprite = ItemTools.getItemSprite(var_24_0.stickerID, {
			size = var_24_0.size
		})
	end

	self.stickerFrameImg_[1].enabled = false
	self.stickerFrameImg_[2].enabled = false

	SetActive(self.stickerAddGo_1, false)
	SetActive(self.stickerAddGo_2, false)
end

function SpringPreheatEditLetterView:RefreshArrowUI()
	if self.firstView_ then
		self.arrowController_:SetSelectedState("none")

		return
	end

	local var_25_0 = self:GetLetterIdList()
	local var_25_1 = table.indexof(var_25_0, self.letterServerId_)
	local var_25_2 = var_25_1 > 1
	local var_25_3 = var_25_1 < #var_25_0

	if var_25_1 > 1 and var_25_3 then
		self.arrowController_:SetSelectedState("both")
	elseif var_25_2 then
		self.arrowController_:SetSelectedState("left")
	elseif var_25_3 then
		self.arrowController_:SetSelectedState("right")
	else
		self.arrowController_:SetSelectedState("none")
	end
end

function SpringPreheatEditLetterView:JumpNextLetter(arg_26_1)
	local var_26_0 = self:GetLetterIdList()
	local var_26_1 = table.indexof(var_26_0, self.letterServerId_) + arg_26_1

	if var_26_1 < 1 or #var_26_0 < var_26_1 then
		return
	end

	JumpTools.OpenPageByJump("springWelfarePlayerLetter", {
		letterServerId = var_26_0[var_26_1]
	})
end

function SpringPreheatEditLetterView:GetLetterIdList()
	return SpringWelfareData:GetPlayerLetterIdList()
end

function SpringPreheatEditLetterView:OnClickClose()
	self:Back()
end

function SpringPreheatEditLetterView:OnClickAddFriendBtn()
	FriendsAction:TryToRequestToFriend(self.playerInfo_.uid, FriendConst.ADD_FRIEND_SOURCE.ACTIVITY_COMMON, SpringWelfareData:GetActivityId())
end

function SpringPreheatEditLetterView:OnFriendsListChange()
	self.friendController_:SetSelectedState(SpringWelfareData:IsFriendOrInRequest(self.playerInfo_.uid) and "send" or "add")
end

function SpringPreheatEditLetterView:GetActivityID()
	return self.params_.activityId
end

return SpringPreheatEditLetterView
