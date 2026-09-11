local ChatFriendsTabItem = class("ChatFriendsTabItem", ReduxView)

function ChatFriendsTabItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ChatFriendsTabItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChatFriendsTabItem:InitUI()
	self:BindCfgUI()

	self.selectStateController_ = self.itemControllerEx_:GetController("selectState")
	self.onlineStateController_ = self.itemControllerEx_:GetController("onlineState")
	self.commonPortrait_ = CommonHeadPortrait.New(self.commonHead_)
end

function ChatFriendsTabItem:AddUIListener()
	self:AddBtnListener(self.itemBtn_, nil, function()
		if self.click_ then
			self.click_()
		end
	end)
	self.commonPortrait_:RegisteClickCallback(function()
		if self.click_ then
			self.click_()
		end
	end)
end

function ChatFriendsTabItem:SetData(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self.friendID_ = arg_7_1
	self.index_ = arg_7_2
	self.click_ = arg_7_4

	self:SetSelectState(arg_7_1 == arg_7_3)

	if arg_7_1 == USER_ID then
		local var_7_0 = PlayerData:GetPlayerInfo()

		self.nickText_.text = GetI18NText(var_7_0.nick)

		self.commonPortrait_:RenderHead(var_7_0.portrait)
		self.commonPortrait_:RenderFrame(var_7_0.icon_frame)
	else
		local var_7_1 = FriendsData:GetInfoByID(arg_7_1)

		if var_7_1 == false then
			print("unfind friend data", arg_7_1)
			self:Show(false)

			return
		end

		self.nickText_.text = GetI18NText(var_7_1.nick)

		self.commonPortrait_:RenderHead(var_7_1.icon)
		self.commonPortrait_:RenderFrame(var_7_1.icon_frame)
		self.onlineStateController_:SetSelectedState(var_7_1.online_state == 0 and "on" or "off")
	end
end

function ChatFriendsTabItem:SetSelectState(arg_8_1)
	self.selectStateController_:SetSelectedState(arg_8_1 and "select" or "cancel")
	self:RefreshRedPoint(arg_8_1)
end

function ChatFriendsTabItem:Show(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)
end

function ChatFriendsTabItem:RefreshRedPoint(arg_10_1)
	local var_10_0 = ChatFriendData:GetUnreadMsgCnt(self.friendID_)

	if var_10_0 <= 0 or arg_10_1 then
		SetActive(self.goNotice_, false)
	else
		SetActive(self.goNotice_, true)

		self.textNoticeCnt_.text = var_10_0
	end
end

function ChatFriendsTabItem:Dispose()
	self.commonPortrait_:Dispose()
	ChatFriendsTabItem.super.Dispose(self)
end

return ChatFriendsTabItem
