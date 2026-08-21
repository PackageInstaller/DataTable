local var_0_0 = class("ReserveProposalRenameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Formation/FormationProposalRenameUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:InitIntputField()

	arg_4_0.attributeItemList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.attrubuteListGo_, ReserveProposalAttributeTagItem)
	arg_4_0.selectHandler_ = handler(arg_4_0, arg_4_0.OnSelectAttribute)
	arg_4_0.backHandler_ = handler(arg_4_0, arg_4_0.Back)
	arg_4_0.mainTitleText_.text = GetTips("RESERVE_PROPOSAL_TITLE")
	arg_4_0.nameTitleText_.text = GetTips("NIL_NAME")
end

function var_0_0.InitIntputField(arg_5_0)
	arg_5_0:GetOrAddComponent(arg_5_0.input_.gameObject, typeof(InputFieldHelper))
	dealEnter(arg_5_0.input_.gameObject)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.cancelbtnBtn_, nil, function()
		OperationRecorder.Record(arg_6_0.lastRecord_, "proposal_cancelBtn")
		manager.notify:Invoke(INPUT_POP_CLICK_CANCEL)
		JumpTools.Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.bgmaskBtn_, nil, function()
		manager.notify:Invoke(INPUT_POP_CLICK_CLOSE, arg_6_0.input_.text, arg_6_0.input_)
		JumpTools.Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.okbtnBtn_, nil, function()
		OperationRecorder.Record(arg_6_0.lastRecord_, "proposal_okBtn")
		arg_6_0:WorldVarify()
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:UpdateRecord()
	arg_10_0:InitSelectData()
	arg_10_0:RefreshUI()
	arg_10_0:RegistEventListener(INPUT_POP_BACK, arg_10_0.backHandler_)
end

function var_0_0.UpdateRecord(arg_11_0)
	local var_11_0, var_11_1 = gameContext:GetLastHistoryAndParams()

	if string.char(string.byte(var_11_0)) == "/" then
		var_11_0 = string.sub(var_11_0, 2)
	end

	arg_11_0.lastRecord_ = var_11_0
end

function var_0_0.InitSelectData(arg_12_0)
	local var_12_0 = arg_12_0.params_.selectAttributeList or {}

	arg_12_0.selectAttributeIdDic_ = {}

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		arg_12_0.selectAttributeIdDic_[iter_12_1] = true
	end

	arg_12_0.selectCount_ = #var_12_0
end

function var_0_0.RefreshUI(arg_13_0)
	arg_13_0:RefreshInput()
	arg_13_0:RefreshAttributeList()
	arg_13_0:RefreshAttributeTagTitle()
end

function var_0_0.RefreshInput(arg_14_0)
	arg_14_0.input_.text = GetI18NText(arg_14_0.params_.defaultText) or ""
end

function var_0_0.RefreshAttributeList(arg_15_0)
	arg_15_0.attributeIdList_ = FormationProposalTagCfg.all

	arg_15_0.attributeItemList_:StartScroll(#arg_15_0.attributeIdList_)
end

function var_0_0.RefreshAttributeTagTitle(arg_16_0)
	local var_16_0 = GameSetting.max_num_of_reserve_proposal_tag.value[1]

	arg_16_0.attributeTagTitleText_.text = GetTipsF("RESERVE_PROPOSAL_TAG_TITLE", arg_16_0.selectCount_, var_16_0)
end

function var_0_0.IndexItem(arg_17_0, arg_17_1, arg_17_2)
	arg_17_2:SetData(arg_17_0.attributeIdList_[arg_17_1])
	arg_17_2:SetSelect(arg_17_0.selectAttributeIdDic_[arg_17_0.attributeIdList_[arg_17_1]])
	arg_17_2:SetSelectCallBack(arg_17_0.selectHandler_)
end

function var_0_0.OnSelectAttribute(arg_18_0, arg_18_1)
	local var_18_0 = GameSetting.max_num_of_reserve_proposal_tag.value[1]

	if not arg_18_0.selectAttributeIdDic_[arg_18_1] and var_18_0 <= arg_18_0.selectCount_ then
		ShowTips(GetTipsF("MAX_NUM_OF_RESERVE_PROPOSAL_TAG_TIP", var_18_0))

		return
	end

	arg_18_0:UpdateSelectAttribute(arg_18_1)
	arg_18_0:RefreshSelectState()
	arg_18_0:RefreshAttributeTagTitle()
end

function var_0_0.UpdateSelectAttribute(arg_19_0, arg_19_1)
	if arg_19_0.selectAttributeIdDic_[arg_19_1] then
		arg_19_0.selectAttributeIdDic_[arg_19_1] = nil
		arg_19_0.selectCount_ = arg_19_0.selectCount_ - 1
	else
		arg_19_0.selectAttributeIdDic_[arg_19_1] = true
		arg_19_0.selectCount_ = arg_19_0.selectCount_ + 1
	end
end

function var_0_0.RefreshSelectState(arg_20_0)
	local var_20_0 = arg_20_0.attributeItemList_:GetItemList()

	for iter_20_0, iter_20_1 in pairs(var_20_0) do
		iter_20_1:SetSelect(arg_20_0.selectAttributeIdDic_[iter_20_1:GetId()])
	end
end

function var_0_0.OnExit(arg_21_0)
	arg_21_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0.attributeItemList_:Dispose()
	var_0_0.super.Dispose(arg_22_0)
end

function var_0_0.WorldVarify(arg_23_0)
	local var_23_0 = arg_23_0.input_.text

	if var_23_0 == "" then
		ShowTips("INPUT_EQUIP_PROPOSAL_NAME")

		return
	end

	if IsAllSpace(var_23_0) then
		ShowTips("INPUT_CHAT_CONTENT")

		arg_23_0.input_.text = ""

		return
	end

	local var_23_1, var_23_2 = textLimit(var_23_0, GameSetting.user_name_max.value[1])

	arg_23_0.input_.text = var_23_1

	local var_23_3 = var_23_1

	if not nameRule(var_23_3) then
		ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

		arg_23_0.input_.text = ""

		return
	end

	WordVerifyBySDK(var_23_3, function(arg_24_0)
		if not arg_24_0 then
			ShowTips("SENSITIVE_WORD")

			arg_23_0.input_.text = ""

			return
		else
			if not var_23_2 then
				return
			end

			arg_23_0:WorldVarifySuccess(var_23_3)
		end
	end, JUDGE_MESSAGE_TYPE.OTHER)
end

function var_0_0.WorldVarifySuccess(arg_25_0, arg_25_1)
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in pairs(arg_25_0.selectAttributeIdDic_) do
		table.insert(var_25_0, iter_25_0)
	end

	table.sort(var_25_0, function(arg_26_0, arg_26_1)
		return arg_26_0 < arg_26_1
	end)
	manager.notify:Invoke(INPUT_POP_CLICK_OK, arg_25_1, var_25_0)
end

return var_0_0
