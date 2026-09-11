local ChatRecallItemView = class("ChatRecallItemView", (import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")))

function ChatRecallItemView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	self:AddListeners()
	self:Show(true)
end

function ChatRecallItemView:Dispose()
	self.commonPortrait_:Dispose()

	self.commonPortrait_ = nil

	ChatRecallItemView.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ChatRecallItemView:GetUserID()
	return self.itemData_.id
end

function ChatRecallItemView:AddListeners()
	self.commonPortrait_:RegisteClickCallback(function()
		if CooperationData:CheckInRoom() then
			return
		end

		ForeignInfoAction:TryToCheckForeignDetailInfo(self:GetUserID())
	end)
	self:AddBtnListener(self.copyBtn_, nil, function()
		ShowTips("COPY_SUCCESS")

		UnityEngine.GUIUtility.systemCopyBuffer = self.textContent_.text
	end)
end

function ChatRecallItemView:GetNick()
	return self.itemData_.nick
end

function ChatRecallItemView:SetText(arg_8_1)
	if arg_8_1.id == USER_ID then
		local var_8_0 = PlayerData:GetPlayerInfo()

		self.textName_.text = GetI18NText(var_8_0.nick)

		self.commonPortrait_:RenderHead(var_8_0.portrait)
		self.commonPortrait_:RenderFrame(var_8_0.icon_frame)
	else
		self.textName_.text = GetI18NText(arg_8_1.nick)

		self.commonPortrait_:RenderHead(arg_8_1.icon)
		self.commonPortrait_:RenderFrame(arg_8_1.iconFrame)
	end

	self.textContent_.text = GetI18NText(arg_8_1.content)
	self.tipsText_.text = GetTips("RECALLED_SHARE_TIPS")

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.rectContent_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.rectGo_)
end

function ChatRecallItemView:SetData(arg_9_1, arg_9_2)
	self.itemData_ = arg_9_1
	self.index_ = arg_9_2

	self:Show(true)
	self:SetText(arg_9_1)
	self:SetIP(self.itemData_)
end

function ChatRecallItemView:SetIP(arg_10_1)
	if not self.ipGo_ then
		return
	end

	self.ip_.text = arg_10_1.ip

	SetActive(self.ipGo_, GameToSDK.CURRENT_SERVER == AreaConst.CHINA)

	if self.gameObject_.activeSelf then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ipGo_.transform)
	end
end

function ChatRecallItemView:SetAsLastSibling()
	self.transform_:SetAsLastSibling()
end

function ChatRecallItemView:SetAsFirstSibling()
	self.transform_:SetAsFirstSibling()
end

function ChatRecallItemView:Show(arg_13_1)
	SetActive(self.gameObject_, arg_13_1)
end

return ChatRecallItemView
