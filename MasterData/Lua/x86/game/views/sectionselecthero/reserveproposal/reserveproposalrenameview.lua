local ReserveProposalRenameView = class("ReserveProposalRenameView", ReduxView)

function ReserveProposalRenameView:UIName()
	return "Widget/System/Formation/FormationProposalRenameUI"
end

function ReserveProposalRenameView:UIParent()
	return manager.ui.uiPop.transform
end

function ReserveProposalRenameView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ReserveProposalRenameView:InitUI()
	self:BindCfgUI()
	self:InitIntputField()

	self.attributeItemList_ = LuaList.New(handler(self, self.IndexItem), self.attrubuteListGo_, ReserveProposalAttributeTagItem)
	self.selectHandler_ = handler(self, self.OnSelectAttribute)
	self.backHandler_ = handler(self, self.Back)
	self.mainTitleText_.text = GetTips("RESERVE_PROPOSAL_TITLE")
	self.nameTitleText_.text = GetTips("NIL_NAME")
end

function ReserveProposalRenameView:InitIntputField()
	self:GetOrAddComponent(self.input_.gameObject, typeof(InputFieldHelper))
	dealEnter(self.input_.gameObject)
end

function ReserveProposalRenameView:AddUIListener()
	self:AddBtnListener(self.cancelbtnBtn_, nil, function()
		OperationRecorder.Record(self.lastRecord_, "proposal_cancelBtn")
		manager.notify:Invoke(INPUT_POP_CLICK_CANCEL)
		JumpTools.Back()
	end)
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		manager.notify:Invoke(INPUT_POP_CLICK_CLOSE, self.input_.text, self.input_)
		JumpTools.Back()
	end)
	self:AddBtnListener(self.okbtnBtn_, nil, function()
		OperationRecorder.Record(self.lastRecord_, "proposal_okBtn")
		self:WorldVarify()
	end)
end

function ReserveProposalRenameView:OnEnter()
	self:UpdateRecord()
	self:InitSelectData()
	self:RefreshUI()
	self:RegistEventListener(INPUT_POP_BACK, self.backHandler_)
end

function ReserveProposalRenameView:UpdateRecord()
	local var_11_0, var_11_1 = gameContext:GetLastHistoryAndParams()

	if string.char(string.byte(var_11_0)) == "/" then
		var_11_0 = string.sub(var_11_0, 2)
	end

	self.lastRecord_ = var_11_0
end

function ReserveProposalRenameView:InitSelectData()
	local var_12_0 = self.params_.selectAttributeList or {}

	self.selectAttributeIdDic_ = {}

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		self.selectAttributeIdDic_[iter_12_1] = true
	end

	self.selectCount_ = #var_12_0
end

function ReserveProposalRenameView:RefreshUI()
	self:RefreshInput()
	self:RefreshAttributeList()
	self:RefreshAttributeTagTitle()
end

function ReserveProposalRenameView:RefreshInput()
	self.input_.text = GetI18NText(self.params_.defaultText) or ""
end

function ReserveProposalRenameView:RefreshAttributeList()
	self.attributeIdList_ = FormationProposalTagCfg.all

	self.attributeItemList_:StartScroll(#self.attributeIdList_)
end

function ReserveProposalRenameView:RefreshAttributeTagTitle()
	self.attributeTagTitleText_.text = GetTipsF("RESERVE_PROPOSAL_TAG_TITLE", self.selectCount_, GameSetting.max_num_of_reserve_proposal_tag.value[1])
end

function ReserveProposalRenameView:IndexItem(arg_17_1, arg_17_2)
	arg_17_2:SetData(self.attributeIdList_[arg_17_1])
	arg_17_2:SetSelect(self.selectAttributeIdDic_[self.attributeIdList_[arg_17_1]])
	arg_17_2:SetSelectCallBack(self.selectHandler_)
end

function ReserveProposalRenameView:OnSelectAttribute(arg_18_1)
	if not self.selectAttributeIdDic_[arg_18_1] and GameSetting.max_num_of_reserve_proposal_tag.value[1] <= self.selectCount_ then
		ShowTips(GetTipsF("MAX_NUM_OF_RESERVE_PROPOSAL_TAG_TIP", GameSetting.max_num_of_reserve_proposal_tag.value[1]))

		return
	end

	self:UpdateSelectAttribute(arg_18_1)
	self:RefreshSelectState()
	self:RefreshAttributeTagTitle()
end

function ReserveProposalRenameView:UpdateSelectAttribute(arg_19_1)
	if self.selectAttributeIdDic_[arg_19_1] then
		self.selectAttributeIdDic_[arg_19_1] = nil
		self.selectCount_ = self.selectCount_ - 1
	else
		self.selectAttributeIdDic_[arg_19_1] = true
		self.selectCount_ = self.selectCount_ + 1
	end
end

function ReserveProposalRenameView:RefreshSelectState()
	for iter_20_0, iter_20_1 in pairs((self.attributeItemList_:GetItemList())) do
		iter_20_1:SetSelect(self.selectAttributeIdDic_[iter_20_1:GetId()])
	end
end

function ReserveProposalRenameView:OnExit()
	self:RemoveAllEventListener()
end

function ReserveProposalRenameView:Dispose()
	self.attributeItemList_:Dispose()
	ReserveProposalRenameView.super.Dispose(self)
end

function ReserveProposalRenameView:WorldVarify()
	if self.input_.text == "" then
		ShowTips("INPUT_EQUIP_PROPOSAL_NAME")

		return
	end

	if IsAllSpace(self.input_.text) then
		ShowTips("INPUT_CHAT_CONTENT")

		self.input_.text = ""

		return
	end

	local var_23_0, var_23_1 = textLimit(self.input_.text, GameSetting.user_name_max.value[1])

	self.input_.text = var_23_0

	local var_23_2 = var_23_0

	if not nameRule(var_23_0) then
		ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

		self.input_.text = ""

		return
	end

	WordVerifyBySDK(var_23_0, function(arg_24_0)
		if not arg_24_0 then
			ShowTips("SENSITIVE_WORD")

			self.input_.text = ""

			return
		else
			if not var_23_1 then
				return
			end

			self:WorldVarifySuccess(var_23_2)
		end
	end, JUDGE_MESSAGE_TYPE.OTHER)
end

function ReserveProposalRenameView:WorldVarifySuccess(arg_25_1)
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in pairs(self.selectAttributeIdDic_) do
		table.insert(var_25_0, iter_25_0)
	end

	table.sort(var_25_0, function(arg_26_0, arg_26_1)
		return arg_26_0 < arg_26_1
	end)
	manager.notify:Invoke(INPUT_POP_CLICK_OK, arg_25_1, var_25_0)
end

return ReserveProposalRenameView
