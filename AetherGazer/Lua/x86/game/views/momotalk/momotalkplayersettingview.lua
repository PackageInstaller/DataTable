local var_0_0 = import("game.views.momoTalk.momotalkItem.MomoTalkSettingItem")
local var_0_1 = class("MomoTalkPlayerSettingView", ReduxView)

function var_0_1.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
	arg_1_0:InitList()
end

function var_0_1.InitList(arg_2_0)
	arg_2_0.selectedHeadID_ = MomoTalkData.icon
	arg_2_0.selectedBubleID_ = PlayerData:GetCurChatBubbleID()
	arg_2_0.dataList_ = {}

	if arg_2_0.listGo_ then
		arg_2_0.luaList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.listGo_, var_0_0)
	end

	arg_2_0.previewItem_ = var_0_0.New(arg_2_0.previewItemGo_)
end

function var_0_1.AddListeners(arg_3_0)
	if arg_3_0.closeBtn_ then
		arg_3_0:AddBtnListener(arg_3_0.closeBtn_, nil, function()
			manager.notify:Invoke(MOMOTALK_BACK_FROM_SETTING)
		end)
	end

	if arg_3_0.headTabBtn_ then
		arg_3_0:AddBtnListener(arg_3_0.headTabBtn_, nil, function()
			arg_3_0:SwitchTab("head")
		end)
	end

	if arg_3_0.bubleTabBtn_ then
		arg_3_0:AddBtnListener(arg_3_0.bubleTabBtn_, nil, function()
			arg_3_0:SwitchTab("bubble")
		end)
	end

	if arg_3_0.useBtn_ then
		arg_3_0:AddBtnListener(arg_3_0.useBtn_, nil, function()
			arg_3_0:UseSelectedItem()
		end)
	end

	if arg_3_0.tabControllerEx_ then
		arg_3_0.tabConroller_ = arg_3_0.tabControllerEx_:GetController("selectState")
	end

	if arg_3_0.btnControllerEx_ then
		arg_3_0.btnController_ = arg_3_0.btnControllerEx_:GetController("btnState")
	end
end

function var_0_1.OnEnter(arg_8_0)
	arg_8_0.selectedHeadID_ = MomoTalkData.icon
	arg_8_0.selectedBubleID_ = PlayerData:GetCurChatBubbleID()

	arg_8_0:SwitchTab("head")
end

function var_0_1.OnExit(arg_9_0)
	return
end

function var_0_1.SwitchTab(arg_10_0, arg_10_1)
	arg_10_0.currentTab_ = arg_10_1

	local var_10_0 = arg_10_1 == "head"

	if arg_10_0.tabConroller_ then
		arg_10_0.tabConroller_:SetSelectedState(var_10_0 and "head" or "bubble")
	end

	arg_10_0:RefreshList()
end

function var_0_1.RefreshList(arg_11_0)
	arg_11_0.dataList_ = arg_11_0.currentTab_ == "head" and arg_11_0:GetHeadList() or arg_11_0:GetBubleList()

	arg_11_0:EnsureSelectedID()

	if arg_11_0.luaList_ then
		arg_11_0.luaList_:StartScroll(#arg_11_0.dataList_)
	end

	arg_11_0:RefreshPreview()
	arg_11_0:RefreshUseState()
end

function var_0_1.GetHeadList(arg_12_0)
	local var_12_0 = MomoTalkTools.GetHeadData()

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		iter_12_1.type = "head"
	end

	return var_12_0
end

function var_0_1.GetBubleList(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = AvatarTools.GetChatBubbleList() or {}

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		table.insert(var_13_0, iter_13_1)
	end

	table.sort(var_13_0, function(arg_14_0, arg_14_1)
		local var_14_0 = arg_14_0 and PlayerData:GetChatBubble(arg_14_0.id)
		local var_14_1 = arg_14_1 and PlayerData:GetChatBubble(arg_14_1.id)
		local var_14_2 = var_14_0 and var_14_0.unlock == 1
		local var_14_3 = var_14_1 and var_14_1.unlock == 1

		if var_14_2 and var_14_3 then
			return arg_14_0.id < arg_14_1.id
		elseif var_14_2 then
			return true
		elseif var_14_3 then
			return false
		else
			return arg_14_0.id < arg_14_1.id
		end
	end)

	local var_13_2 = {}

	for iter_13_2, iter_13_3 in ipairs(var_13_0) do
		local var_13_3 = PlayerData:GetChatBubble(iter_13_3.id)

		table.insert(var_13_2, {
			type = "bubble",
			id = iter_13_3.id,
			state = var_13_3 and var_13_3.unlock or 0,
			lasted_time = var_13_3 and var_13_3.lasted_time or 0
		})
	end

	return var_13_2
end

function var_0_1.EnsureSelectedID(arg_15_0)
	local var_15_0 = arg_15_0.currentTab_ == "head" and arg_15_0.selectedHeadID_ or arg_15_0.selectedBubleID_

	if arg_15_0:GetDataByID(var_15_0) then
		return
	end

	local var_15_1 = arg_15_0.dataList_ and arg_15_0.dataList_[1]

	if not var_15_1 then
		return
	end

	if arg_15_0.currentTab_ == "head" then
		arg_15_0.selectedHeadID_ = var_15_1.id
	else
		arg_15_0.selectedBubleID_ = var_15_1.id
	end
end

function var_0_1.IndexItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.dataList_[arg_16_1]

	if not var_16_0 then
		return
	end

	local var_16_1 = var_16_0.type == "head"
	local var_16_2 = var_16_1 and arg_16_0.selectedHeadID_ or arg_16_0.selectedBubleID_
	local var_16_3 = var_16_1 and MomoTalkData.icon or PlayerData:GetCurChatBubbleID()

	arg_16_2:SetData(var_16_0, var_16_0.id == var_16_2, var_16_0.id == var_16_3, function(arg_17_0)
		arg_16_0:OnSelectItem(arg_17_0)
	end)
end

function var_0_1.OnSelectItem(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:GetDataByID(arg_18_1)

	if not var_18_0 then
		return
	end

	if var_18_0.type ~= "head" and var_18_0.state ~= 1 then
		if JumpTools.ShowItemSource then
			JumpTools.ShowItemSource(arg_18_1)
		end

		return
	end

	if arg_18_0.currentTab_ == "head" then
		arg_18_0.selectedHeadID_ = arg_18_1
	else
		arg_18_0.selectedBubleID_ = arg_18_1
	end

	arg_18_0:RefreshVisibleItems()
	arg_18_0:RefreshPreview()
	arg_18_0:RefreshUseState()
end

function var_0_1.GetDataByID(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0.dataList_ or {}) do
		if iter_19_1.id == arg_19_1 then
			return iter_19_1
		end
	end
end

function var_0_1.RefreshVisibleItems(arg_20_0)
	if arg_20_0.luaList_ then
		arg_20_0.luaList_:Refresh()
	end
end

function var_0_1.RefreshUseState(arg_21_0)
	if not arg_21_0.btnController_ then
		return
	end

	local var_21_0 = arg_21_0.currentTab_ == "head" and arg_21_0.selectedHeadID_ or arg_21_0.selectedBubleID_
	local var_21_1 = arg_21_0.currentTab_ == "head" and MomoTalkData.icon or PlayerData:GetCurChatBubbleID()
	local var_21_2 = arg_21_0:GetDataByID(var_21_0)

	if not var_21_2 or var_21_2.state ~= 1 then
		arg_21_0.btnController_:SetSelectedState("grey")
	elseif var_21_0 == var_21_1 then
		arg_21_0.btnController_:SetSelectedState("used")
	else
		arg_21_0.btnController_:SetSelectedState("use")
	end
end

function var_0_1.RefreshPreview(arg_22_0)
	if not arg_22_0.previewItem_ then
		return
	end

	local var_22_0 = arg_22_0.currentTab_ == "head" and arg_22_0.selectedHeadID_ or arg_22_0.selectedBubleID_
	local var_22_1 = arg_22_0:GetDataByID(var_22_0)

	if var_22_1 then
		local var_22_2 = arg_22_0.currentTab_ == "head" and MomoTalkData.icon or PlayerData:GetCurChatBubbleID()

		arg_22_0.previewItem_:SetData(var_22_1, false, var_22_1.id == var_22_2)
	end

	if arg_22_0.nameTxt_ then
		local var_22_3 = ""

		if var_22_1 then
			if var_22_1.type == "head" then
				local var_22_4 = var_22_1.cfg or ChatMonoAvatarCfg[var_22_1.id]

				var_22_3 = var_22_4 and GetI18NText(var_22_4.name or "") or ""
			else
				local var_22_5 = ItemCfg[var_22_1.id]

				var_22_3 = var_22_5 and GetI18NText(var_22_5.name or "") or ""
			end
		end

		arg_22_0.nameTxt_.text = var_22_3
	end
end

function var_0_1.UseSelectedItem(arg_23_0)
	local var_23_0 = arg_23_0.currentTab_ == "head" and arg_23_0.selectedHeadID_ or arg_23_0.selectedBubleID_
	local var_23_1 = arg_23_0:GetDataByID(var_23_0)

	if not var_23_1 or var_23_1.state ~= 1 then
		return
	end

	if arg_23_0.currentTab_ == "head" then
		if var_23_0 == MomoTalkData.icon then
			return
		end

		MomoTalkAction.SetMomoFrame(var_23_0, function()
			MomoTalkData.icon = var_23_0

			manager.notify:Invoke(MOMOTALK_REFRESH_PLAYER_ICON)
			arg_23_0:RefreshVisibleItems()
			arg_23_0:RefreshPreview()
			arg_23_0:RefreshUseState()
		end)
	else
		if var_23_0 == PlayerData:GetCurChatBubbleID() then
			return
		end

		PlayerAction.ChangeChatBubble(var_23_0, function()
			arg_23_0:RefreshVisibleItems()
			arg_23_0:RefreshPreview()
			arg_23_0:RefreshUseState()
		end)
	end
end

function var_0_1.Dispose(arg_26_0)
	if arg_26_0.previewItem_ then
		arg_26_0.previewItem_:Dispose()

		arg_26_0.previewItem_ = nil
	end

	if arg_26_0.luaList_ then
		arg_26_0.luaList_:Dispose()

		arg_26_0.luaList_ = nil
	end

	var_0_1.super.Dispose(arg_26_0)
end

return var_0_1
