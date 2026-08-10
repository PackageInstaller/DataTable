local var_0_0 = class("GuideWeakView")
local var_0_1 = Vector2(40, 30)

function var_0_0.Ctor(arg_1_0)
	arg_1_0._isInit = false
end

function var_0_0.Init(arg_2_0)
	if arg_2_0._isInit then
		return
	end

	arg_2_0.gameObject_ = GameObject.Instantiate(Asset.Load("Widget/System/GuideNewUI/GuideWeakUI"), manager.ui.uiStory.transform)
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0._isInit = true

	SetActive(arg_2_0.gameObject_, false)
end

function var_0_0.InitUI(arg_3_0)
	ComponentBinder.GetInstance():BindCfgUI(arg_3_0, arg_3_0.gameObject_)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0.btnTextPanel_.onClick:AddListener(function()
		arg_4_0:Hide()
	end)
	arg_4_0.btnIcon_.onClick:AddListener(function()
		arg_4_0:Hide()
	end)
	arg_4_0.btnMaskBtn_.onClick:AddListener(function()
		arg_4_0:Hide()
	end)
end

function var_0_0.RemoveUIListener(arg_8_0)
	if isNil(arg_8_0.btnTextPanel_) or isNil(arg_8_0.btnIcon_) or isNil(arg_8_0.btnMaskBtn_) then
		return
	end

	arg_8_0.btnTextPanel_.onClick:RemoveAllListeners()
	arg_8_0.btnIcon_.onClick:RemoveAllListeners()
	arg_8_0.btnMaskBtn_.onClick:RemoveAllListeners()
end

function var_0_0.UpdateView(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0.id_ = arg_9_1.id

	arg_9_0:ShowTalk(arg_9_1)
	arg_9_0:ShowHoldMask(arg_9_3 or arg_9_2)
	arg_9_0:SetCloseTime(arg_9_1.closetime)
end

function var_0_0.ShowTalk(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.talk_content
	local var_10_1 = arg_10_1.talk_anchors
	local var_10_2 = arg_10_1.talk_position
	local var_10_3 = arg_10_1.narrator_name
	local var_10_4 = arg_10_1.narrator_icon
	local var_10_5 = arg_10_1.talk_adapt

	if not var_10_0 or var_10_0 == "" then
		SetActive(arg_10_0.textPanel_, false)

		return
	end

	SetActive(arg_10_0.textPanel_, true)

	arg_10_0.textCom_.text = var_10_0
	arg_10_0.dialogNameText_.text = var_10_3
	arg_10_0.dialogHeadImg_.sprite = getSpriteViaConfig("StoryHeadIcon", string.format("story_%s", var_10_4))

	if var_10_1 == 1 then
		arg_10_0.textRect_.anchorMax = Vector2.New(0, 1)
		arg_10_0.textRect_.anchorMin = Vector2.New(0, 1)
	elseif var_10_1 == 2 then
		arg_10_0.textRect_.anchorMax = Vector2.New(1, 1)
		arg_10_0.textRect_.anchorMin = Vector2.New(1, 1)
	elseif var_10_1 == 3 then
		arg_10_0.textRect_.anchorMax = Vector2.New(1, 0)
		arg_10_0.textRect_.anchorMin = Vector2.New(1, 0)
	elseif var_10_1 == 4 then
		arg_10_0.textRect_.anchorMax = Vector2.New(0, 0)
		arg_10_0.textRect_.anchorMin = Vector2.New(0, 0)
	elseif var_10_1 == 5 then
		arg_10_0.textRect_.anchorMax = Vector2.New(0, 0.5)
		arg_10_0.textRect_.anchorMin = Vector2.New(0, 0.5)
	elseif var_10_1 == 6 then
		arg_10_0.textRect_.anchorMax = Vector2.New(0.5, 1)
		arg_10_0.textRect_.anchorMin = Vector2.New(0.5, 1)
	elseif var_10_1 == 7 then
		arg_10_0.textRect_.anchorMax = Vector2.New(1, 0.5)
		arg_10_0.textRect_.anchorMin = Vector2.New(1, 0.5)
	elseif var_10_1 == 8 then
		arg_10_0.textRect_.anchorMax = Vector2.New(0.5, 0)
		arg_10_0.textRect_.anchorMin = Vector2.New(0.5, 0)
	else
		arg_10_0.textRect_.anchorMax = Vector2.New(0.5, 0.5)
		arg_10_0.textRect_.anchorMin = Vector2.New(0.5, 0.5)
	end

	if var_10_5 == 1 then
		arg_10_0.textRect_.anchoredPosition = Vector2.New((var_10_2[1] or 0) + ReduxView.VIEW_ADAPT_DISTANCE, var_10_2[2] or 0)
	elseif var_10_5 == 2 then
		arg_10_0.textRect_.anchoredPosition = Vector2.New((var_10_2[1] or 0) - ReduxView.VIEW_ADAPT_DISTANCE, var_10_2[2] or 0)
	else
		arg_10_0.textRect_.anchoredPosition = Vector2.New(var_10_2[1] or 0, var_10_2[2] or 0)
	end
end

function var_0_0.ShowHoldMask(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:GetComponent("RectTransform")

	arg_11_0.isHide_ = false

	SetActive(arg_11_0.gameObject_, not arg_11_0.isHide_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(var_11_0)

	local var_11_1 = Vector3((0.5 - var_11_0.pivot.x) * var_11_0.rect.width, (0.5 - var_11_0.pivot.y) * var_11_0.rect.height, 0)

	if arg_11_0.timer_ then
		arg_11_0.timer_:Stop()
	end

	arg_11_0.timer_ = Timer.New(function()
		if isNil(arg_11_1) then
			arg_11_0.timer_:Stop()

			arg_11_0.timer_ = nil

			return
		end

		arg_11_0.btnMaskCom_.sizeDelta = Vector2(var_11_0.rect.width, var_11_0.rect.height) + var_0_1
		arg_11_0.btnMaskCom_.position = var_11_0.position
		arg_11_0.btnMaskCom_.anchoredPosition = arg_11_0.btnMaskCom_.anchoredPosition + var_11_1
		arg_11_0.btnMaskCom_.eulerAngles = var_11_0.eulerAngles
	end, 0.033, -1)

	arg_11_0.timer_:Start()
end

function var_0_0.SetCloseTime(arg_13_0, arg_13_1)
	if arg_13_1 == 0 then
		return
	end

	arg_13_0.closeTimer = Timer.New(function()
		arg_13_0:Hide()
	end, arg_13_1, 0)

	arg_13_0.closeTimer:Start()
end

function var_0_0.GetIsInWeakGuide(arg_15_0)
	return not arg_15_0.isHide_
end

function var_0_0.Hide(arg_16_0, arg_16_1)
	if arg_16_0.isHide_ then
		return
	end

	if arg_16_0.id_ and not arg_16_1 then
		NewPlayerGuideAction.FinishWeakGuide(arg_16_0.id_)

		arg_16_0.id_ = nil
	end

	if arg_16_0.timer_ then
		arg_16_0.timer_:Stop()

		arg_16_0.timer_ = nil
	end

	if arg_16_0.closeTimer then
		arg_16_0.closeTimer:Stop()

		arg_16_0.closeTimer = nil
	end

	arg_16_0.isHide_ = true

	SetActive(arg_16_0.gameObject_, not arg_16_0.isHide_)
end

function var_0_0.Dispose(arg_17_0, arg_17_1)
	if arg_17_0.id_ and arg_17_1 then
		NewPlayerGuideAction.FinishWeakGuide(arg_17_0.id_)
	end

	arg_17_0.id_ = nil

	if arg_17_0.timer_ then
		arg_17_0.timer_:Stop()

		arg_17_0.timer_ = nil
	end

	if arg_17_0.closeTimer then
		arg_17_0.closeTimer:Stop()

		arg_17_0.closeTimer = nil
	end

	if arg_17_0._isInit then
		arg_17_0:RemoveUIListener()
		Object.Destroy(arg_17_0.gameObject_)
	end

	arg_17_0._isInit = false
end

return var_0_0
