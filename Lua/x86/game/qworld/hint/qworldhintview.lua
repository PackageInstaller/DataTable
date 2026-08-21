local var_0_0 = class("QWorldHintView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SandPlay/SandPlay_InScenes/item/SandPlay_HintUI"
end

function var_0_0.Init(arg_2_0)
	arg_2_0.gameObject_ = GameObject.Instantiate(Asset.Load(arg_2_0:UIName()), manager.ui.uiPop.transform)
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	arg_2_0:BindCfgUI()
	arg_2_0:AdaptScreen()
	arg_2_0:AddUIListener()

	arg_2_0.hasTagController_ = arg_2_0.controller_:GetController("hasTag")
	arg_2_0.stateController_ = arg_2_0.controller_:GetController("state")
	arg_2_0.itemList_ = {}
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		QWorldMgr:GetQWorldTagMgr():GotoTag(arg_3_0.tag_, arg_3_0.entityId)
	end)
end

function var_0_0.DisplayHint(arg_5_0, arg_5_1, arg_5_2)
	if isNil(arg_5_0.gameObject_) then
		arg_5_0:Init()
	end

	SetActive(arg_5_0.gameObject_, true)

	if arg_5_1 then
		SetActive(arg_5_0.eventGo_, true)
		arg_5_0.hintAni_:Play("UI_SandPlay_Hint_cx", -1, 0)
		arg_5_0.hintAni_:Update(0)
		arg_5_0:Refresh(arg_5_1)
	elseif not arg_5_2 or #arg_5_2 == 0 then
		arg_5_0:HideHintTips()
	end

	arg_5_0.isShow_ = true

	arg_5_0.transform_:SetAsLastSibling()

	if arg_5_2 and #arg_5_2 > 0 then
		local var_5_0 = #arg_5_2

		SetActive(arg_5_0.bookGo_, true)

		for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
			if not arg_5_0.itemList_[iter_5_0] then
				local var_5_1 = Object.Instantiate(arg_5_0.bookTipsGo_, arg_5_0.bookBaseTrs_)

				arg_5_0.itemList_[iter_5_0] = QWorldHintItem.New(var_5_1)
			end

			arg_5_0.itemList_[iter_5_0]:SetData(iter_5_1)
			arg_5_0.itemList_[iter_5_0]:Show(true)
		end

		for iter_5_2 = var_5_0 + 1, #arg_5_0.itemList_ do
			arg_5_0.itemList_[iter_5_2]:Show(false)
		end
	else
		SetActive(arg_5_0.bookGo_, false)
	end
end

function var_0_0.Refresh(arg_6_0, arg_6_1)
	arg_6_0.id_ = arg_6_1
	arg_6_0.cfg_ = SandPlayHintCfg[arg_6_1]

	if not arg_6_0.cfg_ then
		Debug.LogError("有不存在的Hint ID：" .. arg_6_1)

		return
	end

	arg_6_0.icon_.spriteAsync = "TextureConfig/SandPlay/MiniIcon/" .. arg_6_0.cfg_.icon
	arg_6_0.desc_.text = GetI18NText(arg_6_0.cfg_.desc)
	arg_6_0.tag_ = arg_6_0.cfg_.tag

	arg_6_0.hasTagController_:SetSelectedState(tostring(arg_6_0.tag_ ~= 0))

	if arg_6_1 == 323641001 then
		arg_6_0.stateController_:SetSelectedState("photo")
	else
		arg_6_0.stateController_:SetSelectedState("normal")
	end
end

function var_0_0.HideHint(arg_7_0, arg_7_1)
	if isNil(arg_7_0.gameObject_) then
		arg_7_0:Init()
	end

	if arg_7_0.itemList_ then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0.itemList_) do
			if iter_7_1 and iter_7_1.Dispose then
				iter_7_1:Dispose()
			end
		end

		arg_7_0.itemList_ = {}
	end

	arg_7_0:HideHintTips(arg_7_1)

	arg_7_0.isShow_ = false
end

function var_0_0.HideHintTips(arg_8_0, arg_8_1)
	if arg_8_0.hideTimer_ then
		arg_8_0.hideTimer_:Stop()

		arg_8_0.hideTimer_ = nil
	end

	if not arg_8_1 then
		if arg_8_0.hintAni_ then
			arg_8_0.hintAni_:Play("UI_SandPlay_Hint_xs", -1, 0)
			arg_8_0.hintAni_:Update(0)

			arg_8_0.hideTimer_ = Timer.New(function()
				SetActive(arg_8_0.eventGo_, false)
				SetActive(arg_8_0.gameObject_, false)
			end, 0.1, 1)

			arg_8_0.hideTimer_:Start()
		end
	else
		SetActive(arg_8_0.eventGo_, false)
		SetActive(arg_8_0.gameObject_, false)
	end
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)

	if arg_10_0.hideTimer_ then
		arg_10_0.hideTimer_:Stop()

		arg_10_0.hideTimer_ = nil
	end

	Object.Destroy(arg_10_0.gameObject_)

	arg_10_0.transform_ = nil
	arg_10_0.gameObject_ = nil
	arg_10_0.hintAni_ = nil
end

return var_0_0
