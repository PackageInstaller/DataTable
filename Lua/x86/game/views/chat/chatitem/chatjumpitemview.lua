local var_0_0 = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")
local var_0_1 = class("ChatJumpItemView", var_0_0)

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
		ForeignInfoAction:TryToCheckForeignDetailInfo(arg_4_0:GetUserID())
	end)
	arg_4_0:AddBtnListener(arg_4_0.jumpBtn_, nil, function()
		arg_4_0:JumpFunc()
	end)
	arg_4_0:AddBtnListener(arg_4_0.buttonContent_, nil, function()
		manager.notify:Invoke(CHAT_REPORT, {
			reportData = {
				nick = arg_4_0:GetNick(),
				msgID = arg_4_0.itemData_.msgID
			},
			parentRect = arg_4_0.rectReportParent_,
			x = arg_4_0:CalcOffsetX(),
			y = arg_4_0:CalcOffsetY()
		})
	end)
end

function var_0_1.JumpFunc(arg_8_0)
	JumpTools.JumpToPage2(arg_8_0.jumpLink_)
end

function var_0_1.GetNick(arg_9_0)
	return arg_9_0.itemData_.nick
end

function var_0_1.SetText(arg_10_0, arg_10_1)
	return
end

function var_0_1.SetData(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.itemData_ = arg_11_1
	arg_11_0.jumpLink_ = arg_11_1.jumpLink
	arg_11_0.index_ = arg_11_2

	if arg_11_1.id == USER_ID then
		local var_11_0 = PlayerData:GetPlayerInfo()

		arg_11_0.textName_.text = var_11_0.nick

		arg_11_0.commonPortrait_:RenderHead(var_11_0.portrait)
		arg_11_0.commonPortrait_:RenderFrame(var_11_0.icon_frame)
	else
		arg_11_0.textName_.text = arg_11_1.nick

		arg_11_0.commonPortrait_:RenderHead(arg_11_1.icon)
		arg_11_0.commonPortrait_:RenderFrame(arg_11_1.iconFrame)
	end

	arg_11_0.textContent_.text = arg_11_1.content

	arg_11_0:Show(true)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.rectContent_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.transform_)
end

function var_0_1.SetAsLastSibling(arg_12_0)
	arg_12_0.transform_:SetAsLastSibling()
end

function var_0_1.SetAsFirstSibling(arg_13_0)
	arg_13_0.transform_:SetAsFirstSibling()
end

function var_0_1.Show(arg_14_0, arg_14_1)
	if arg_14_0.gameObject_.activeSelf == false and arg_14_1 == true then
		manager.notify:Invoke(CHAT_REPORT_HIDE)
	end

	SetActive(arg_14_0.gameObject_, arg_14_1)
end

function var_0_1.CalcOffsetX(arg_15_0)
	local var_15_0 = arg_15_0.rectBg_.rect.width

	return arg_15_0.rectReportParent_:InverseTransformPoint(arg_15_0.rectBg_:TransformPoint(Vector3(var_15_0 / 2, 0, 0))).x
end

function var_0_1.CalcOffsetY(arg_16_0)
	local var_16_0 = arg_16_0.rectReportParent_:InverseTransformPoint(arg_16_0.rectScrollView_:TransformPoint(Vector3.zero))
	local var_16_1 = arg_16_0.rectReportParent_.rect.height / 2

	if var_16_1 > var_16_0.y then
		return var_16_0.y + var_16_1 - arg_16_0.rectReportParent_:TransformPoint(Vector3(0, var_16_0.y + var_16_1, 0)).y - 20
	else
		return 0
	end
end

return var_0_1
