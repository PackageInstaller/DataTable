local ChatGuildRecruitItemView = class("ChatGuildRecruitItemView", (import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")))

function ChatGuildRecruitItemView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	self:AddListeners()

	self.guildItemView_ = ChatGuildInfoView.New(self.guildRecruitGo_)

	self:Show(true)
end

function ChatGuildRecruitItemView:Dispose()
	self.commonPortrait_:Dispose()

	self.commonPortrait_ = nil

	self.guildItemView_:Dispose()

	self.guildItemView_ = nil

	ChatGuildRecruitItemView.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ChatGuildRecruitItemView:GetUserID()
	return self.itemData_.id
end

function ChatGuildRecruitItemView:AddListeners()
	self.commonPortrait_:RegisteClickCallback(function()
		if CooperationData:CheckInRoom() then
			return
		end

		ForeignInfoAction:TryToCheckForeignDetailInfo(self:GetUserID())
	end)
end

function ChatGuildRecruitItemView:GetNick()
	return self.itemData_.nick
end

function ChatGuildRecruitItemView:SetText(arg_7_1)
	if arg_7_1.id == USER_ID then
		local var_7_0 = PlayerData:GetPlayerInfo()

		self.textName_.text = GetI18NText(var_7_0.nick)

		self.commonPortrait_:RenderHead(var_7_0.portrait)
		self.commonPortrait_:RenderFrame(var_7_0.icon_frame)
	else
		self.textName_.text = GetI18NText(arg_7_1.nick)

		self.commonPortrait_:RenderHead(arg_7_1.icon)
		self.commonPortrait_:RenderFrame(arg_7_1.iconFrame)
	end

	if arg_7_1.content == "" then
		SetActive(self.contentGo_, false)
	else
		SetActive(self.contentGo_, true)

		self.contentText_.text = GetI18NText(arg_7_1.content)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.rectContent_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.rectGo_)
end

function ChatGuildRecruitItemView:SetData(arg_8_1, arg_8_2)
	self.itemData_ = arg_8_1
	self.index_ = arg_8_2

	self:Show(true)
	self:SetText(arg_8_1)
	self.guildItemView_:SetGuildID(arg_8_1.guildID)
end

function ChatGuildRecruitItemView:SetAsLastSibling()
	self.transform_:SetAsLastSibling()
end

function ChatGuildRecruitItemView:SetAsFirstSibling()
	self.transform_:SetAsFirstSibling()
end

function ChatGuildRecruitItemView:Show(arg_11_1)
	SetActive(self.gameObject_, arg_11_1)
end

return ChatGuildRecruitItemView
