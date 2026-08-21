local var_0_0 = class("LetterBoxView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Mailbox/LetterBox"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.emptyController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "empty")
	arg_5_0.roleSrollHelper_ = LuaList.New(handler(arg_5_0, arg_5_0.indexRoleItem), arg_5_0.roleListGo_, LetterBoxRoleItem)
	arg_5_0.letterScrollHelper_ = LuaList.New(handler(arg_5_0, arg_5_0.indexLetterItem), arg_5_0.letterListGo_, LetterBoxListItem)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.filterBtn_, nil, function()
		JumpTools.OpenPageByJump("commonFilterView", {
			filterGroup = Filter_Root_Define.Mail_Filter_List
		})
	end)
end

function var_0_0.AddEventListener(arg_8_0)
	arg_8_0:RegistEventListener(LETTER_READ_UPDATE, handler(arg_8_0, arg_8_0.OnLetterReadUpdate))
	arg_8_0:RegistEventListener(COMMON_FILTER_OK, handler(arg_8_0, arg_8_0.FilterUpdataList))
end

function var_0_0.OnLetterReadUpdate(arg_9_0, arg_9_1)
	LetterAction.UpdateLetterRedPoint(arg_9_1)
end

function var_0_0.indexRoleItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2.handler_ = handler(arg_10_0, arg_10_0.OnRoleClick)

	local var_10_0 = arg_10_0.heroList_[arg_10_1]
	local var_10_1 = LetterData.GetSender(var_10_0)

	arg_10_2:SetData(var_10_1)

	if arg_10_0.curSenderId_ and arg_10_0.curSenderId_ == var_10_1.id then
		arg_10_2:SetSelected(true)
	else
		arg_10_2:SetSelected(false)
	end
end

function var_0_0.indexLetterItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2.handler_ = handler(arg_11_0, arg_11_0.OnLetterClick)

	local var_11_0 = LetterData.GetLettersFromSender(arg_11_0.curSenderId_)[arg_11_1]
	local var_11_1 = LetterData.GetLetter(var_11_0)

	arg_11_2:SetData(arg_11_1, var_11_1)
end

function var_0_0.OnRoleClick(arg_12_0, arg_12_1)
	arg_12_0:SelectRole(arg_12_1:GetData().id)
end

function var_0_0.OnLetterClick(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1:GetData().id

	LetterAction.ReadLetter(var_13_0)
	JumpTools.OpenPageByJump("letterPop", {
		letterId = var_13_0
	})
end

function var_0_0.OnEnter(arg_14_0)
	LetterAction.SortLetters()
	arg_14_0:AddEventListener()
	arg_14_0:UpdateList()
end

function var_0_0.UpdateList(arg_15_0, arg_15_1)
	arg_15_0.heroList_ = LetterData.GetFilterSendSort()

	SetActive(arg_15_0.filterBtn_.gameObject, #LetterData.GetSenderSort() > 0)
	arg_15_0.emptyController_:SetSelectedState(#arg_15_0.heroList_ <= 0 and "true" or "false")

	if #arg_15_0.heroList_ <= 0 then
		arg_15_0.roleSrollHelper_:StartScroll(0)

		arg_15_0.curSenderId_ = nil
	else
		if not arg_15_0.curSenderId_ or arg_15_1 then
			arg_15_0.curSenderId_ = arg_15_0:GetFirstSelectedId()
		end

		if arg_15_0.curSenderId_ ~= 0 then
			local var_15_0 = table.indexof(arg_15_0.heroList_, arg_15_0.curSenderId_)

			arg_15_0.roleSrollHelper_:StartScroll(#arg_15_0.heroList_, var_15_0)
			arg_15_0.roleSrollHelper_:Refresh()
			arg_15_0:UpdateLetterView(arg_15_0.curSenderId_)
		else
			arg_15_0.roleSrollHelper_:StartScroll(0)

			arg_15_0.curSenderId_ = nil
		end
	end
end

function var_0_0.GetFirstSelectedId(arg_16_0)
	local var_16_0 = math.min(1, #arg_16_0.heroList_)

	return arg_16_0.heroList_[var_16_0] or 0
end

function var_0_0.SelectRole(arg_17_0, arg_17_1)
	if arg_17_1 == 0 then
		return
	end

	if arg_17_1 == arg_17_0.curSenderId_ then
		return
	end

	arg_17_0.curSenderId_ = arg_17_1

	arg_17_0.roleSrollHelper_:Refresh()
	arg_17_0:UpdateLetterView(arg_17_1)
end

function var_0_0.UpdateLetterView(arg_18_0, arg_18_1)
	local var_18_0 = LetterData.GetLettersFromSender(arg_18_1)

	if #var_18_0 <= 0 then
		arg_18_0.letterScrollHelper_:StartScroll(0)
	else
		arg_18_0.letterScrollHelper_:StartScroll(#var_18_0)
	end
end

function var_0_0.FilterUpdataList(arg_19_0)
	arg_19_0:UpdateList(true)
end

function var_0_0.OnTop(arg_20_0)
	arg_20_0:ShowDefaultBar()
end

function var_0_0.OnExit(arg_21_0)
	manager.windowBar:HideBar()
	CommonFilterData:ClearFilter(Filter_Root_Define.Mail_Filter_List.filter_id)
	arg_21_0:RemoveAllEventListener()

	arg_21_0.curSenderId_ = nil
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0:RemoveAllListeners()
	arg_22_0:RemoveAllEventListener()

	if arg_22_0.roleSrollHelper_ then
		arg_22_0.roleSrollHelper_:Dispose()

		arg_22_0.roleSrollHelper_ = nil
	end

	if arg_22_0.letterScrollHelper_ then
		arg_22_0.letterScrollHelper_:Dispose()

		arg_22_0.letterScrollHelper_ = nil
	end

	manager.classPool:DisposeOnePool(LetterBoxListItem)
	var_0_0.super.Dispose(arg_22_0)
end

return var_0_0
