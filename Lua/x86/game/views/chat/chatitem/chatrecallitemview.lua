local var_0_0 = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")
local var_0_1 = class("ChatRecallItemView", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()

	arg_1_0.commonPortrait_ = CommonHeadPortrait.New(arg_1_0.headItem_)

	arg_1_0:AddListeners()
	arg_1_0:Show(true)
end

function var_0_1.Dispose(arg_2_0)
	arg_2_0.commonPortrait_:Dispose()

	arg_2_0.commonPortrait_ = nil

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
	arg_4_0:AddBtnListener(arg_4_0.copyBtn_, nil, function()
		ShowTips("COPY_SUCCESS")

		UnityEngine.GUIUtility.systemCopyBuffer = arg_4_0.textContent_.text
	end)
end

function var_0_1.GetNick(arg_7_0)
	return arg_7_0.itemData_.nick
end

function var_0_1.SetText(arg_8_0, arg_8_1)
	if arg_8_1.id == USER_ID then
		local var_8_0 = PlayerData:GetPlayerInfo()

		arg_8_0.textName_.text = GetI18NText(var_8_0.nick)

		arg_8_0.commonPortrait_:RenderHead(var_8_0.portrait)
		arg_8_0.commonPortrait_:RenderFrame(var_8_0.icon_frame)
	else
		arg_8_0.textName_.text = GetI18NText(arg_8_1.nick)

		arg_8_0.commonPortrait_:RenderHead(arg_8_1.icon)
		arg_8_0.commonPortrait_:RenderFrame(arg_8_1.iconFrame)
	end

	arg_8_0.textContent_.text = GetI18NText(arg_8_1.content)
	arg_8_0.tipsText_.text = GetTips("RECALLED_SHARE_TIPS")

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.rectContent_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.rectGo_)
end

function var_0_1.SetData(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.itemData_ = arg_9_1
	arg_9_0.index_ = arg_9_2

	arg_9_0:Show(true)
	arg_9_0:SetText(arg_9_1)
	arg_9_0:SetIP(arg_9_0.itemData_)
end

function var_0_1.SetIP(arg_10_0, arg_10_1)
	if not arg_10_0.ipGo_ then
		return
	end

	arg_10_0.ip_.text = arg_10_1.ip

	SetActive(arg_10_0.ipGo_, GameToSDK.CURRENT_SERVER == AreaConst.CHINA)

	if arg_10_0.gameObject_.activeSelf then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.ipGo_.transform)
	end
end

function var_0_1.SetAsLastSibling(arg_11_0)
	arg_11_0.transform_:SetAsLastSibling()
end

function var_0_1.SetAsFirstSibling(arg_12_0)
	arg_12_0.transform_:SetAsFirstSibling()
end

function var_0_1.Show(arg_13_0, arg_13_1)
	SetActive(arg_13_0.gameObject_, arg_13_1)
end

return var_0_1
