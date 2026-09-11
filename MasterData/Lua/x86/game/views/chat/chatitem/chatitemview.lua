local ChatItemView = class("ChatItemView", (import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")))

ChatItemView.bgExtendHeight = 40
ChatItemView.contentMaxWidth = 540

function ChatItemView:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.scrollView_ = arg_1_3

	self:BindCfgUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
	self.bubble_ = BubbleItemView.New(self.bubbleGo_, self.rectReportParent_, self.rectScrollView_)

	self:AddListeners()
	self:Show(true)
end

function ChatItemView:Dispose()
	self.commonPortrait_:Dispose()
	self.bubble_:Dispose()
	ChatItemView.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ChatItemView:GetUserID()
	return self.itemData_.id
end

function ChatItemView:AddListeners()
	self.commonPortrait_:RegisteClickCallback(function()
		if CooperationData:CheckInRoom() then
			return
		end

		ForeignInfoAction:TryToCheckForeignDetailInfo(self:GetUserID())
	end)
end

function ChatItemView:GetNick()
	return self.itemData_.nick
end

function ChatItemView:SetText(arg_7_1)
	if arg_7_1.id == USER_ID then
		local var_7_0 = PlayerData:GetPlayerInfo()

		self.textName_.text = GetI18NText(var_7_0.nick)

		self.commonPortrait_:RenderHead(var_7_0.portrait)
		self.commonPortrait_:RenderFrame(var_7_0.icon_frame)
		self.bubble_:RenderM(PlayerData:GetCurChatBubbleID() or GameSetting.profile_chat_bubble_default.value[1])
	else
		self.textName_.text = GetI18NText(arg_7_1.nick)

		self.commonPortrait_:RenderHead(arg_7_1.icon)
		self.commonPortrait_:RenderFrame(arg_7_1.iconFrame)
		self.bubble_:RenderO(arg_7_1.bubbleID or GameSetting.profile_chat_bubble_default.value[1])
	end
end

function ChatItemView:SetData(arg_8_1, arg_8_2)
	self.itemData_ = arg_8_1
	self.index_ = arg_8_2

	self:Show(true)
	self:SetText(self.itemData_)
	self.bubble_:SetData(self.itemData_)
	self:SetIP(self.itemData_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.rectContent_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.rectGo_)
end

function ChatItemView:SetIP(arg_9_1)
	if not self.ipGo_ then
		return
	end

	self.ip_.text = arg_9_1.ip

	SetActive(self.ipGo_, GameToSDK.CURRENT_SERVER == AreaConst.CHINA)

	if self.gameObject_.activeSelf then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ipGo_.transform)
	end
end

function ChatItemView:SetAsLastSibling()
	self.transform_:SetAsLastSibling()
end

function ChatItemView:SetAsFirstSibling()
	self.transform_:SetAsFirstSibling()
end

function ChatItemView:Show(arg_12_1)
	if self.gameObject_.activeSelf == false and arg_12_1 == true then
		manager.notify:Invoke(CHAT_REPORT_HIDE)
	end

	SetActive(self.gameObject_, arg_12_1)
end

return ChatItemView
