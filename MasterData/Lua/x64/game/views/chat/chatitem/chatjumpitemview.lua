local ChatJumpItemView = class("ChatJumpItemView", (import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")))

function ChatJumpItemView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	self:AddListeners()
	self:Show(true)
end

function ChatJumpItemView:Dispose()
	self.commonPortrait_:Dispose()
	ChatJumpItemView.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ChatJumpItemView:GetUserID()
	return self.itemData_.id
end

function ChatJumpItemView:AddListeners()
	self.commonPortrait_:RegisteClickCallback(function()
		ForeignInfoAction:TryToCheckForeignDetailInfo(self:GetUserID())
	end)
	self:AddBtnListener(self.jumpBtn_, nil, function()
		self:JumpFunc()
	end)
	self:AddBtnListener(self.buttonContent_, nil, function()
		manager.notify:Invoke(CHAT_REPORT, {
			reportData = {
				nick = self:GetNick(),
				msgID = self.itemData_.msgID
			},
			parentRect = self.rectReportParent_,
			x = self:CalcOffsetX(),
			y = self:CalcOffsetY()
		})
	end)
end

function ChatJumpItemView:JumpFunc()
	JumpTools.JumpToPage2(self.jumpLink_)
end

function ChatJumpItemView:GetNick()
	return self.itemData_.nick
end

function ChatJumpItemView:SetText(arg_10_1)
	return
end

function ChatJumpItemView:SetData(arg_11_1, arg_11_2)
	self.itemData_ = arg_11_1
	self.jumpLink_ = arg_11_1.jumpLink
	self.index_ = arg_11_2

	if arg_11_1.id == USER_ID then
		local var_11_0 = PlayerData:GetPlayerInfo()

		self.textName_.text = var_11_0.nick

		self.commonPortrait_:RenderHead(var_11_0.portrait)
		self.commonPortrait_:RenderFrame(var_11_0.icon_frame)
	else
		self.textName_.text = arg_11_1.nick

		self.commonPortrait_:RenderHead(arg_11_1.icon)
		self.commonPortrait_:RenderFrame(arg_11_1.iconFrame)
	end

	self.textContent_.text = arg_11_1.content

	self:Show(true)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.rectContent_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function ChatJumpItemView:SetAsLastSibling()
	self.transform_:SetAsLastSibling()
end

function ChatJumpItemView:SetAsFirstSibling()
	self.transform_:SetAsFirstSibling()
end

function ChatJumpItemView:Show(arg_14_1)
	if self.gameObject_.activeSelf == false and arg_14_1 == true then
		manager.notify:Invoke(CHAT_REPORT_HIDE)
	end

	SetActive(self.gameObject_, arg_14_1)
end

function ChatJumpItemView:CalcOffsetX()
	return self.rectReportParent_:InverseTransformPoint(self.rectBg_:TransformPoint(Vector3(self.rectBg_.rect.width / 2, 0, 0))).x
end

function ChatJumpItemView:CalcOffsetY()
	local var_16_0 = self.rectReportParent_:InverseTransformPoint(self.rectScrollView_:TransformPoint(Vector3.zero))

	if self.rectReportParent_.rect.height / 2 > var_16_0.y then
		return var_16_0.y + self.rectReportParent_.rect.height / 2 - self.rectReportParent_:TransformPoint(Vector3(0, var_16_0.y + self.rectReportParent_.rect.height / 2, 0)).y - 20
	else
		return 0
	end
end

return ChatJumpItemView
