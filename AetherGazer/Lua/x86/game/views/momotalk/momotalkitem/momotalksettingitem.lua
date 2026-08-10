local var_0_0 = class("MomoTalkSettingItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:InitController()
	arg_1_0:AddListeners()
end

function var_0_0.InitController(arg_2_0)
	if arg_2_0.controllerEx_ then
		arg_2_0.iconSelectController_ = arg_2_0.controllerEx_:GetController("select")
		arg_2_0.iconLockController_ = arg_2_0.controllerEx_:GetController("lock")
		arg_2_0.iconUseController_ = arg_2_0.controllerEx_:GetController("use")
		arg_2_0.itemTypeController_ = arg_2_0.controllerEx_:GetController("type")
	end
end

function var_0_0.AddListeners(arg_3_0)
	if arg_3_0.iconBtn_ then
		arg_3_0:AddBtnListener(arg_3_0.iconBtn_, nil, function()
			if arg_3_0.onClick_ then
				arg_3_0.onClick_(arg_3_0.id_)
			end
		end)
	end
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.data_ = arg_5_1
	arg_5_0.id_ = arg_5_1 and arg_5_1.id
	arg_5_0.onClick_ = arg_5_4

	local var_5_0 = arg_5_1 and arg_5_1.type == "bubble"

	arg_5_0:SetControllerState(arg_5_0.itemTypeController_, var_5_0 and "chatBubble" or "head")

	if arg_5_0.iconImg_ then
		SetActive(arg_5_0.iconImg_.gameObject, not var_5_0)
	end

	if arg_5_0.chatBubbleCont_ then
		SetActive(arg_5_0.chatBubbleCont_.gameObject, var_5_0)
	end

	if var_5_0 then
		arg_5_0:RefreshBubble(arg_5_1, arg_5_2, arg_5_3)
	else
		arg_5_0:RefreshHead(arg_5_1, arg_5_2, arg_5_3)
	end
end

function var_0_0.RefreshHead(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_1 and arg_6_1.state == 1

	arg_6_0:DestroyBubble()

	if arg_6_0.iconImg_ and arg_6_1 then
		arg_6_0.iconImg_.sprite = MomoTalkTools.GetMonoAvatarIcon(arg_6_1.id)
		arg_6_0.iconImg_.color = LuaHelper.StringToColor("#FFFFFF")
	end

	arg_6_0:SetControllerState(arg_6_0.iconSelectController_, arg_6_2 and "select" or "default")
	arg_6_0:SetControllerState(arg_6_0.iconLockController_, var_6_0 and "default" or "lock")
	arg_6_0:SetControllerState(arg_6_0.iconUseController_, arg_6_3 and "used" or "default")
end

function var_0_0.RefreshBubble(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_1 and arg_7_1.state == 1
	local var_7_1 = arg_7_1 and ChatBubbleCfg[arg_7_1.id]

	if not var_7_1 then
		return
	end

	if arg_7_0.chatBubbleTxt_ then
		local var_7_2 = ItemCfg[arg_7_1.id]

		arg_7_0.chatBubbleTxt_.text = var_7_2 and GetI18NText(var_7_2.name) or ""
	end

	local var_7_3 = var_7_1.color2 or var_7_1.color1 or "FFFFFF"

	if var_7_1.type and var_7_1.type == 2 then
		if arg_7_0.chatBubbleCont_ then
			SetActive(arg_7_0.chatBubbleCont_.gameObject, true)
		end

		if arg_7_0.chatBubbleImg_ then
			arg_7_0.chatBubbleImg_.enabled = false
		end

		if arg_7_0.chatBubbleCont_ and arg_7_0.dynamicBubbleName_ ~= var_7_1.image1 then
			local var_7_4 = DynamicPortraitPool.GetInstance():GetBubble(var_7_1.image1, arg_7_0.chatBubbleCont_)

			if not isNil(arg_7_0.dynamicBubble_) then
				arg_7_0:DestroyBubble()
			end

			arg_7_0.dynamicBubbleName_ = var_7_1.image1
			arg_7_0.dynamicBubble_ = var_7_4
		end

		if arg_7_0.chatBubblePrevImg_ then
			arg_7_0.chatBubblePrevImg_.color = LuaHelper.StringToColor("#" .. var_7_3)

			arg_7_0.chatBubblePrevImg_.transform:SetAsLastSibling()
		end

		if arg_7_0.chatBubbleTxt_ then
			arg_7_0.chatBubbleTxt_.color = LuaHelper.StringToColor("#" .. var_7_3)
		end
	else
		arg_7_0:DestroyBubble()

		if arg_7_0.chatBubbleCont_ then
			SetActive(arg_7_0.chatBubbleCont_.gameObject, false)
		end

		if arg_7_0.chatBubbleImg_ then
			arg_7_0.chatBubbleImg_.enabled = true
			arg_7_0.chatBubbleImg_.sprite = ItemTools.getItemSprite(arg_7_1.id)
		end

		if arg_7_0.chatBubbleTxt_ then
			var_7_3 = var_7_1.color1 or var_7_3
			arg_7_0.chatBubbleTxt_.color = LuaHelper.StringToColor("#" .. var_7_3)
		end
	end

	arg_7_0:SetControllerState(arg_7_0.iconSelectController_, arg_7_2 and "select" or "default")
	arg_7_0:SetControllerState(arg_7_0.iconLockController_, var_7_0 and "default" or "lock")
	arg_7_0:SetControllerState(arg_7_0.iconUseController_, arg_7_3 and "used" or "default")
end

function var_0_0.SetControllerState(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 then
		arg_8_1:SetSelectedState(arg_8_2)
	end
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:DestroyBubble()
	arg_9_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.DestroyBubble(arg_10_0)
	if not isNil(arg_10_0.dynamicBubble_) then
		DynamicPortraitPool.GetInstance():ReturnBubble(arg_10_0.dynamicBubbleName_, arg_10_0.dynamicBubble_)
	end

	arg_10_0.dynamicBubble_ = nil
	arg_10_0.dynamicBubbleName_ = nil
end

return var_0_0
