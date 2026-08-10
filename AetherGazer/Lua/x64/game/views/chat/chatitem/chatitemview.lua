local var_0_0 = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")
local var_0_1 = class("ChatItemView", var_0_0)

var_0_1.bgExtendHeight = 40
var_0_1.contentMaxWidth = 540

function var_0_1.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.scrollView_ = arg_1_3

	arg_1_0:BindCfgUI()

	arg_1_0.commonPortrait_ = CommonHeadPortrait.New(arg_1_0.headItem_)
	arg_1_0.bubble_ = BubbleItemView.New(arg_1_0.bubbleGo_, arg_1_0.rectReportParent_, arg_1_0.rectScrollView_)

	arg_1_0:AddListeners()
	arg_1_0:Show(true)
end

function var_0_1.Dispose(arg_2_0)
	arg_2_0.commonPortrait_:Dispose()
	arg_2_0.bubble_:Dispose()
	var_0_1.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.gameObject_ = nil
	arg_2_0.transform_ = nil
end

function var_0_1.GetUserID(arg_3_0)
	return arg_3_0.itemData_.id
end

function var_0_1.AddListeners(arg_4_0)
	arg_4_0.commonPortrait_:RegisteClickCallback(function()
		if CooperationData:CheckInRoom() then
			return
		end

		ForeignInfoAction:TryToCheckForeignDetailInfo(arg_4_0:GetUserID())
	end)
end

function var_0_1.GetNick(arg_6_0)
	return arg_6_0.itemData_.nick
end

function var_0_1.SetText(arg_7_0, arg_7_1)
	if arg_7_1.id == USER_ID then
		local var_7_0 = PlayerData:GetPlayerInfo()

		arg_7_0.textName_.text = GetI18NText(var_7_0.nick)

		arg_7_0.commonPortrait_:RenderHead(var_7_0.portrait)
		arg_7_0.commonPortrait_:RenderFrame(var_7_0.icon_frame)

		local var_7_1 = PlayerData:GetCurChatBubbleID() or GameSetting.profile_chat_bubble_default.value[1]

		arg_7_0.bubble_:RenderM(var_7_1)
	else
		arg_7_0.textName_.text = GetI18NText(arg_7_1.nick)

		arg_7_0.commonPortrait_:RenderHead(arg_7_1.icon)
		arg_7_0.commonPortrait_:RenderFrame(arg_7_1.iconFrame)

		local var_7_2 = arg_7_1.bubbleID or GameSetting.profile_chat_bubble_default.value[1]

		arg_7_0.bubble_:RenderO(var_7_2)
	end
end

function var_0_1.SetData(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.itemData_ = arg_8_1
	arg_8_0.index_ = arg_8_2

	arg_8_0:Show(true)
	arg_8_0:SetText(arg_8_0.itemData_)
	arg_8_0.bubble_:SetData(arg_8_0.itemData_)
	arg_8_0:SetIP(arg_8_0.itemData_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.rectContent_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.rectGo_)
end

function var_0_1.SetIP(arg_9_0, arg_9_1)
	if not arg_9_0.ipGo_ then
		return
	end

	arg_9_0.ip_.text = arg_9_1.ip

	SetActive(arg_9_0.ipGo_, GameToSDK.CURRENT_SERVER == AreaConst.CHINA)

	if arg_9_0.gameObject_.activeSelf then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_0.ipGo_.transform)
	end
end

function var_0_1.SetAsLastSibling(arg_10_0)
	arg_10_0.transform_:SetAsLastSibling()
end

function var_0_1.SetAsFirstSibling(arg_11_0)
	arg_11_0.transform_:SetAsFirstSibling()
end

function var_0_1.Show(arg_12_0, arg_12_1)
	if arg_12_0.gameObject_.activeSelf == false and arg_12_1 == true then
		manager.notify:Invoke(CHAT_REPORT_HIDE)
	end

	SetActive(arg_12_0.gameObject_, arg_12_1)
end

return var_0_1
