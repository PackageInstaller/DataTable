local LetterBoxView = class("LetterBoxView", ReduxView)

function LetterBoxView:UIName()
	return "Widget/System/Mailbox/LetterBox"
end

function LetterBoxView:UIParent()
	return manager.ui.uiMain.transform
end

function LetterBoxView:OnCtor()
	return
end

function LetterBoxView:Init()
	self:InitUI()
	self:AddUIListener()
end

function LetterBoxView:InitUI()
	self:BindCfgUI()

	self.emptyController_ = ControllerUtil.GetController(self.gameObject_.transform, "empty")
	self.roleSrollHelper_ = LuaList.New(handler(self, self.indexRoleItem), self.roleListGo_, LetterBoxRoleItem)
	self.letterScrollHelper_ = LuaList.New(handler(self, self.indexLetterItem), self.letterListGo_, LetterBoxListItem)
end

function LetterBoxView:AddUIListener()
	self:AddBtnListener(self.filterBtn_, nil, function()
		JumpTools.OpenPageByJump("commonFilterView", {
			filterGroup = Filter_Root_Define.Mail_Filter_List
		})
	end)
end

function LetterBoxView:AddEventListener()
	self:RegistEventListener(LETTER_READ_UPDATE, handler(self, self.OnLetterReadUpdate))
	self:RegistEventListener(COMMON_FILTER_OK, handler(self, self.FilterUpdataList))
end

function LetterBoxView:OnLetterReadUpdate(arg_9_1)
	LetterAction.UpdateLetterRedPoint(arg_9_1)
end

function LetterBoxView:indexRoleItem(arg_10_1, arg_10_2)
	arg_10_2.handler_ = handler(self, self.OnRoleClick)

	local var_10_0 = LetterData.GetSender(self.heroList_[arg_10_1])

	arg_10_2:SetData(var_10_0)

	if self.curSenderId_ and self.curSenderId_ == var_10_0.id then
		arg_10_2:SetSelected(true)
	else
		arg_10_2:SetSelected(false)
	end
end

function LetterBoxView:indexLetterItem(arg_11_1, arg_11_2)
	arg_11_2.handler_ = handler(self, self.OnLetterClick)

	arg_11_2:SetData(arg_11_1, (LetterData.GetLetter(LetterData.GetLettersFromSender(self.curSenderId_)[arg_11_1])))
end

function LetterBoxView:OnRoleClick(arg_12_1)
	self:SelectRole(arg_12_1:GetData().id)
end

function LetterBoxView:OnLetterClick(arg_13_1)
	local var_13_0 = arg_13_1:GetData().id

	LetterAction.ReadLetter(var_13_0)
	JumpTools.OpenPageByJump("letterPop", {
		letterId = var_13_0
	})
end

function LetterBoxView:OnEnter()
	LetterAction.SortLetters()
	self:AddEventListener()
	self:UpdateList()
end

function LetterBoxView:UpdateList(arg_15_1)
	self.heroList_ = LetterData.GetFilterSendSort()

	SetActive(self.filterBtn_.gameObject, #LetterData.GetSenderSort() > 0)
	self.emptyController_:SetSelectedState(#self.heroList_ <= 0 and "true" or "false")

	if #self.heroList_ <= 0 then
		self.roleSrollHelper_:StartScroll(0)

		self.curSenderId_ = nil
	else
		if not self.curSenderId_ or arg_15_1 then
			self.curSenderId_ = self:GetFirstSelectedId()
		end

		if self.curSenderId_ ~= 0 then
			self.roleSrollHelper_:StartScroll(#self.heroList_, (table.indexof(self.heroList_, self.curSenderId_)))
			self.roleSrollHelper_:Refresh()
			self:UpdateLetterView(self.curSenderId_)
		else
			self.roleSrollHelper_:StartScroll(0)

			self.curSenderId_ = nil
		end
	end
end

function LetterBoxView:GetFirstSelectedId()
	return self.heroList_[math.min(1, #self.heroList_)] or 0
end

function LetterBoxView:SelectRole(arg_17_1)
	if arg_17_1 == 0 then
		return
	end

	if arg_17_1 == self.curSenderId_ then
		return
	end

	self.curSenderId_ = arg_17_1

	self.roleSrollHelper_:Refresh()
	self:UpdateLetterView(arg_17_1)
end

function LetterBoxView:UpdateLetterView(arg_18_1)
	local var_18_0 = LetterData.GetLettersFromSender(arg_18_1)

	if #var_18_0 <= 0 then
		self.letterScrollHelper_:StartScroll(0)
	else
		self.letterScrollHelper_:StartScroll(#var_18_0)
	end
end

function LetterBoxView:FilterUpdataList()
	self:UpdateList(true)
end

function LetterBoxView:OnTop()
	self:ShowDefaultBar()
end

function LetterBoxView:OnExit()
	manager.windowBar:HideBar()
	CommonFilterData:ClearFilter(Filter_Root_Define.Mail_Filter_List.filter_id)
	self:RemoveAllEventListener()

	self.curSenderId_ = nil
end

function LetterBoxView:Dispose()
	self:RemoveAllListeners()
	self:RemoveAllEventListener()

	if self.roleSrollHelper_ then
		self.roleSrollHelper_:Dispose()

		self.roleSrollHelper_ = nil
	end

	if self.letterScrollHelper_ then
		self.letterScrollHelper_:Dispose()

		self.letterScrollHelper_ = nil
	end

	manager.classPool:DisposeOnePool(LetterBoxListItem)
	LetterBoxView.super.Dispose(self)
end

return LetterBoxView
