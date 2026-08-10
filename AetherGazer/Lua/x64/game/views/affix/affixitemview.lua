local var_0_0 = class("AffixItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if arg_1_2 == nil then
		arg_1_0.gameObject_ = arg_1_1
	else
		arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	end

	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	if arg_1_3 ~= nil then
		arg_1_0:SetData(arg_1_3)
	end

	arg_1_0.hideInfoHandler_ = handler(arg_1_0, arg_1_0.HideInfo)

	manager.notify:RegistListener(CLICK_AFFIX, arg_1_0.hideInfoHandler_)
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	arg_2_0:ShowInfo(false)

	arg_2_0.nameText_.text = GetI18NText(getAffixName(arg_2_1))
	arg_2_0.icon_.sprite = getAffixSprite(arg_2_1)
	arg_2_0.level_.text = arg_2_1[2]

	arg_2_0:Show(true)

	arg_2_0.textInfoName_.text = GetI18NText(getAffixName(arg_2_1))
	arg_2_0.textInfoDesc_.text = GetI18NText(getAffixDesc(arg_2_1))
end

function var_0_0.Show(arg_3_0, arg_3_1)
	SetActive(arg_3_0.gameObject_, arg_3_1)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
	manager.notify:RemoveListener(CLICK_AFFIX, arg_4_0.hideInfoHandler_)

	arg_4_0.hideInofHandler_ = nil

	Object.Destroy(arg_4_0.gameObject_)

	arg_4_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.button_, nil, function()
		manager.notify:Invoke(CLICK_AFFIX)
		arg_5_0:ShowInfo(true)
	end)
end

function var_0_0.HideInfo(arg_7_0)
	arg_7_0:ShowInfo(false)
end

function var_0_0.ShowInfo(arg_8_0, arg_8_1)
	SetActive(arg_8_0.goInfo_, arg_8_1)

	if arg_8_1 then
		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.transformInfoName_)
		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.transformInfoDesc_)
	end
end

function var_0_0.AddHideTimer(arg_9_0)
	arg_9_0:StopHideTimer()

	arg_9_0.hideTimer_ = Timer.New(function()
		arg_9_0:ShowInfo(false)
	end, 3, 1)

	arg_9_0.hideTimer_:Start()
end

function var_0_0.StopHideTimer(arg_11_0)
	if arg_11_0.hideTimer_ then
		arg_11_0.hideTimer_:Stop()

		arg_11_0.hideTimer_ = nil
	end
end

function var_0_0.AddClickTimer(arg_12_0)
	arg_12_0:StopTimer()

	arg_12_0.buttonUp_ = 0
	arg_12_0.clickTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function()
		if Input.GetMouseButtonUp(0) then
			arg_12_0.buttonUp_ = arg_12_0.buttonUp_ + 1

			if arg_12_0.buttonUp_ >= 2 then
				arg_12_0:ShowInfo(false)

				if arg_12_0.clickTimer_ then
					FuncTimerManager.inst:RemoveFuncTimer(arg_12_0.clickTimer_)

					arg_12_0.clickTimer_ = nil
				end
			end
		end
	end, -1, true)
end

function var_0_0.StopTimer(arg_14_0)
	if arg_14_0.clickTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(arg_14_0.clickTimer_)

		arg_14_0.clickTimer_ = nil
	end
end

return var_0_0
