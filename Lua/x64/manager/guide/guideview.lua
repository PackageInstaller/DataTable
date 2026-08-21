local var_0_0 = class("GuideView")
local var_0_1 = Vector2(50, 40)

function var_0_0.Ctor(arg_1_0)
	arg_1_0._isInit = false
end

function var_0_0.Init(arg_2_0)
	if arg_2_0._isInit then
		return
	end

	arg_2_0.gameObject_ = GameObject.Instantiate(Asset.Load("Widget/System/GuideNewUI/GuideNewUI2"), manager.ui.uiTips.transform)
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0._isInit = true
	arg_2_0.isInDrag_ = false

	SetActive(arg_2_0.gameObject_, false)
	arg_2_0:CheckQworldGuide(false)
end

function var_0_0.InitUI(arg_3_0)
	ComponentBinder.GetInstance():BindCfgUI(arg_3_0, arg_3_0.gameObject_)

	arg_3_0.breakGuideTrs_ = arg_3_0.btnBreakGuide_.gameObject:GetComponent(typeof(RectTransform))
	arg_3_0.imgRectList_ = {}

	for iter_3_0 = 1, 4 do
		table.insert(arg_3_0.imgRectList_, arg_3_0["maskImage" .. iter_3_0 .. "_"].gameObject:GetComponent(typeof(RectTransform)))
	end

	arg_3_0.dragController_ = arg_3_0.transCon_:GetController("showDrag")
	arg_3_0.maskController_ = arg_3_0.transCon_:GetController("mask")
	arg_3_0.talkItemDic_ = {}
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0.btnMaskBtn_.onClick:AddListener(function()
		manager.guide:OnComponentClick()
	end)
	arg_4_0.btnBreakGuide_.onClick:AddListener(function()
		local var_6_0 = {
			content = GetTips("SKIP_GUIDE"),
			OkCallback = function()
				manager.guide:SkipGuide(arg_4_0.skipGuide_)
				manager.guide.view:Hide()
			end
		}

		JumpTools.OpenPageByJump("guideStuckPopView", var_6_0)
	end)
	arg_4_0.btnNoMask_.onClick:AddListener(function()
		manager.guide:FinishCurrentStep()
	end)
	arg_4_0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(function(arg_9_0, arg_9_1)
		if arg_4_0.isInDrag_ then
			return
		end

		manager.guide:OnEventTrigger("pointerClick", arg_9_1)
	end))
	arg_4_0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_10_0, arg_10_1)
		if arg_4_0.isInDrag_ then
			return
		end

		manager.guide:OnEventTrigger("pointerUp", arg_10_1)
	end))
	arg_4_0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_11_0, arg_11_1)
		if arg_4_0.isInDrag_ then
			return
		end

		manager.guide:OnEventTrigger("pointerDown", arg_11_1)
	end))
	arg_4_0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_12_0, arg_12_1)
		if arg_4_0.isInDrag_ then
			return
		end

		manager.guide:OnEventTrigger("beginDrag", arg_12_1)
	end))
	arg_4_0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_13_0, arg_13_1)
		if arg_4_0.isInDrag_ then
			return
		end

		manager.guide:OnEventTrigger("drag", arg_13_1)
	end))
	arg_4_0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerEnter, LuaHelper.EventTriggerAction1(function(arg_14_0, arg_14_1)
		manager.guide:OnEventTrigger("onPointerEnter", arg_14_1)
	end))
	arg_4_0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerExit, LuaHelper.EventTriggerAction1(function(arg_15_0, arg_15_1)
		manager.guide:OnEventTrigger("onPointerExit", arg_15_1)
	end))
	arg_4_0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_16_0, arg_16_1)
		if arg_4_0.isInDrag_ then
			return
		end

		manager.guide:OnEventTrigger("endDrag", arg_16_1)
	end))
	arg_4_0.eventTrigger2_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerEnter, LuaHelper.EventTriggerAction1(function(arg_17_0, arg_17_1)
		manager.guide:OnEventTrigger("onPointerEnter", arg_17_1)
	end))
	arg_4_0.eventTrigger2_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_18_0, arg_18_1)
		manager.guide:OnEventTrigger("beginDrag", arg_18_1)
	end))
	arg_4_0.eventTrigger2_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_19_0, arg_19_1)
		manager.guide:OnEventTrigger("drag", arg_19_1)
	end))
	arg_4_0.eventTrigger2_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_20_0, arg_20_1)
		manager.guide:OnEventTrigger("endDrag", arg_20_1)
	end))
end

function var_0_0.RemoveUIListener(arg_21_0)
	arg_21_0.btnMaskBtn_.onClick:RemoveAllListeners()
	arg_21_0.eventTrigger_:RemoveAllListeners()
end

function var_0_0.ShowTalk(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1.talk_content
	local var_22_1 = arg_22_1.talk_anchors
	local var_22_2 = arg_22_1.talk_position == "" and {} or arg_22_1.talk_position
	local var_22_3 = arg_22_1.talk_adapt

	if not var_22_0 or var_22_0 == "" then
		SetActive(arg_22_0.textPanel_, false)

		return
	end

	SetActive(arg_22_0.textPanel_, true)

	if var_22_1 == 1 then
		arg_22_0.textRect_.anchorMax = Vector2.New(0, 1)
		arg_22_0.textRect_.anchorMin = Vector2.New(0, 1)
	elseif var_22_1 == 2 then
		arg_22_0.textRect_.anchorMax = Vector2.New(1, 1)
		arg_22_0.textRect_.anchorMin = Vector2.New(1, 1)
	elseif var_22_1 == 3 then
		arg_22_0.textRect_.anchorMax = Vector2.New(1, 0)
		arg_22_0.textRect_.anchorMin = Vector2.New(1, 0)
	elseif var_22_1 == 4 then
		arg_22_0.textRect_.anchorMax = Vector2.New(0, 0)
		arg_22_0.textRect_.anchorMin = Vector2.New(0, 0)
	elseif var_22_1 == 5 then
		arg_22_0.textRect_.anchorMax = Vector2.New(0, 0.5)
		arg_22_0.textRect_.anchorMin = Vector2.New(0, 0.5)
	elseif var_22_1 == 6 then
		arg_22_0.textRect_.anchorMax = Vector2.New(0.5, 1)
		arg_22_0.textRect_.anchorMin = Vector2.New(0.5, 1)
	elseif var_22_1 == 7 then
		arg_22_0.textRect_.anchorMax = Vector2.New(1, 0.5)
		arg_22_0.textRect_.anchorMin = Vector2.New(1, 0.5)
	elseif var_22_1 == 8 then
		arg_22_0.textRect_.anchorMax = Vector2.New(0.5, 0)
		arg_22_0.textRect_.anchorMin = Vector2.New(0.5, 0)
	else
		arg_22_0.textRect_.anchorMax = Vector2.New(0.5, 0.5)
		arg_22_0.textRect_.anchorMin = Vector2.New(0.5, 0.5)
	end

	if var_22_3 == 1 then
		arg_22_0.textRect_.anchoredPosition = Vector2.New((var_22_2[1] or 0) + ReduxView.VIEW_ADAPT_DISTANCE, var_22_2[2] or 0)
	elseif var_22_3 == 2 then
		arg_22_0.textRect_.anchoredPosition = Vector2.New((var_22_2[1] or 0) - ReduxView.VIEW_ADAPT_DISTANCE, var_22_2[2] or 0)
	else
		arg_22_0.textRect_.anchoredPosition = Vector2.New(var_22_2[1] or 0, var_22_2[2] or 0)
	end
end

function var_0_0.ShowHoldMask(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	SetActive(arg_23_0.gameObject_, true)
	SetActive(arg_23_0.btnMaskGo_, true)
	arg_23_0.maskController_:SetSelectedState(tostring(not arg_23_4))
	arg_23_0:CheckQworldGuide(true)

	local var_23_0 = arg_23_1:GetComponent("RectTransform")

	if var_23_0 ~= nil then
		arg_23_0:ShowUIMask(arg_23_1, var_23_0, arg_23_2)
	else
		local var_23_1 = manager.ui.mainCameraCom_
		local var_23_2 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

		if arg_23_0.timer2_ then
			arg_23_0.timer2_:Stop()
		end

		arg_23_0.maskImage1_.sprite = nil
		arg_23_0.maskImage2_.sprite = nil
		arg_23_0.imgRectList_[1].pivot = Vector2(0.5, 0.5)
		arg_23_0.imgRectList_[2].pivot = Vector2(0.5, 0.5)
		arg_23_0.timer2_ = Timer.New(function()
			local var_24_0 = arg_23_1.transform.position
			local var_24_1 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_23_1, var_24_0)
			local var_24_2, var_24_3 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_23_0.transform_, var_24_1, var_23_2, nil)

			arg_23_0.imgRectList_[1].sizeDelta = Vector2(arg_23_3[1][1], arg_23_3[1][2])
			arg_23_0.imgRectList_[2].sizeDelta = Vector2(arg_23_3[1][1], arg_23_3[1][2])
			arg_23_0.imgRectList_[1].anchoredPosition = var_24_3
			arg_23_0.imgRectList_[2].anchoredPosition = var_24_3
			arg_23_0.btnMaskCom_.sizeDelta = Vector2(arg_23_3[1][1], arg_23_3[1][2]) + var_0_1
			arg_23_0.btnMaskCom_.anchoredPosition = var_24_3
		end, 0.033, -1)

		arg_23_0.timer2_:Start()
	end
end

function var_0_0.ShowHoldMask2(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	arg_25_0.isInDrag_ = true

	arg_25_0:CheckQworldGuide(true)

	local var_25_0 = arg_25_1:GetComponent("RectTransform")

	if var_25_0 ~= nil then
		arg_25_0:ShowUIMask2(arg_25_1, var_25_0, arg_25_2)
	else
		local var_25_1 = manager.ui.mainCameraCom_
		local var_25_2 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

		if arg_25_0.timer3_ then
			arg_25_0.timer3_:Stop()
		end

		arg_25_0.maskImage3_.sprite = nil
		arg_25_0.maskImage4_.sprite = nil
		arg_25_0.imgRectList_[3].pivot = Vector2(0.5, 0.5)
		arg_25_0.imgRectList_[4].pivot = Vector2(0.5, 0.5)
		arg_25_0.timer3_ = Timer.New(function()
			local var_26_0 = arg_25_1.transform.position
			local var_26_1 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_25_1, var_26_0)
			local var_26_2, var_26_3 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_25_0.transform_, var_26_1, var_25_2, nil)

			arg_25_0.imgRectList_[3].sizeDelta = Vector2(arg_25_3[1][1], arg_25_3[1][2])
			arg_25_0.imgRectList_[4].sizeDelta = Vector2(arg_25_3[1][1], arg_25_3[1][2])
			arg_25_0.imgRectList_[3].anchoredPosition = var_26_3
			arg_25_0.imgRectList_[4].anchoredPosition = var_26_3
		end, 0.033, -1)

		arg_25_0.timer3_:Start()
	end

	arg_25_0.dragController_:SetSelectedState("show")
	SetActive(arg_25_0.btnMaskGo2_, true)
end

local function var_0_2(arg_27_0, arg_27_1)
	return Vector3(arg_27_0.lossyScale.x / arg_27_1.lossyScale.x, arg_27_0.lossyScale.y / arg_27_1.lossyScale.y, arg_27_0.lossyScale.z / arg_27_1.lossyScale.z)
end

function var_0_0.UpdateMask(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_2.com1
	local var_28_1 = arg_28_2.com2
	local var_28_2 = arg_28_2.maskCom
	local var_28_3 = arg_28_1.pivot
	local var_28_4 = arg_28_1.rect.width
	local var_28_5 = arg_28_1.rect.height
	local var_28_6 = arg_28_1.position
	local var_28_7 = arg_28_1.eulerAngles
	local var_28_8 = Vector3((0.5 - arg_28_1.pivot.x) * arg_28_1.rect.width, (0.5 - arg_28_1.pivot.y) * arg_28_1.rect.height, 0)

	var_28_0.pivot = var_28_3
	var_28_1.pivot = var_28_3
	var_28_0.sizeDelta = Vector2(var_28_4, var_28_5) + arg_28_2.highLightOffSize
	var_28_1.sizeDelta = Vector2(var_28_4, var_28_5) + arg_28_2.highLightOffSize
	var_28_0.position = var_28_6
	var_28_1.position = var_28_6
	var_28_0.eulerAngles = var_28_7
	var_28_1.eulerAngles = var_28_7
	var_28_0.localScale = arg_28_2.scale
	var_28_1.localScale = arg_28_2.scale
	var_28_2.sizeDelta = Vector2(arg_28_1.rect.width, arg_28_1.rect.height) + var_0_1 + arg_28_2.offSize
	var_28_2.position = arg_28_1.position
	var_28_2.anchoredPosition = var_28_2.anchoredPosition + Vector2.Scale(arg_28_2.scale, var_28_8)
	var_28_2.eulerAngles = arg_28_1.eulerAngles
	var_28_2.localScale = arg_28_2.scale
end

function var_0_0.ShowUIMask(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = Vector3(0, 0, 0)
	local var_29_1 = Vector3(0, 0, 0)
	local var_29_2 = Vector2(0, 0)
	local var_29_3 = Vector2(0, 0)

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_2)

	local var_29_4 = arg_29_1:GetComponent(typeof(Image))

	if var_29_4 and var_29_4.enabled then
		arg_29_0.maskImage1_.sprite = var_29_4.sprite
		arg_29_0.maskImage2_.sprite = var_29_4.sprite
	else
		arg_29_0.maskImage1_.sprite = nil
		arg_29_0.maskImage2_.sprite = nil
	end

	if arg_29_0.timer_ then
		arg_29_0.timer_:Stop()
	end

	local var_29_5 = {
		isDrag = true,
		highLightOffSize = var_29_3,
		offSize = var_29_2,
		scale = arg_29_3,
		com1 = arg_29_0.imgRectList_[1],
		com2 = arg_29_0.imgRectList_[2],
		maskCom = arg_29_0.btnMaskCom_
	}

	arg_29_0.timer_ = Timer.New(function()
		if isNil(arg_29_1) then
			arg_29_0.timer_:Stop()

			arg_29_0.timer_ = nil

			return
		end

		arg_29_0:UpdateMask(arg_29_2, var_29_5)
	end, 0.033, -1)

	arg_29_0.timer_:Start()
end

function var_0_0.ShowUIMask2(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = Vector3(0, 0, 0)
	local var_31_1 = Vector3(0, 0, 0)
	local var_31_2 = Vector2(0, 0)
	local var_31_3 = Vector2(0, 0)

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_2)

	local var_31_4 = arg_31_1:GetComponent(typeof(Image))

	if var_31_4 and var_31_4.enabled then
		arg_31_0.maskImage3_.sprite = var_31_4.sprite
		arg_31_0.maskImage4_.sprite = var_31_4.sprite
	else
		arg_31_0.maskImage3_.sprite = nil
		arg_31_0.maskImage4_.sprite = nil
	end

	if arg_31_0.timer4_ then
		arg_31_0.timer4_:Stop()
	end

	local var_31_5 = {
		isDrag = true,
		highLightOffSize = var_31_3,
		offSize = var_31_2,
		scale = arg_31_3,
		com1 = arg_31_0.imgRectList_[3],
		com2 = arg_31_0.imgRectList_[4],
		maskCom = arg_31_0.btnMaskCom2_
	}

	arg_31_0.timer4_ = Timer.New(function()
		if isNil(arg_31_1) then
			arg_31_0.timer4_:Stop()

			arg_31_0.timer4_ = nil

			return
		end

		arg_31_0:UpdateMask(arg_31_2, var_31_5)
	end, 0.033, -1)

	arg_31_0.timer4_:Start()
end

function var_0_0.ShowBreakStuck(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0:AdaptBreakGuide()

	arg_33_0.skipGuide_ = arg_33_1

	SetActive(arg_33_0.btnBreakGuide_, arg_33_2)
end

function var_0_0.AdaptBreakGuide(arg_34_0)
	if not isNil(arg_34_0.breakGuideTrs_) then
		arg_34_0.breakGuideTrs_.anchoredPosition = Vector3(-ReduxView.VIEW_ADAPT_DISTANCE, -53.7, 0)
	end
end

function var_0_0.Hide(arg_35_0)
	if arg_35_0.timer_ then
		arg_35_0.timer_:Stop()
	end

	if arg_35_0.timer2_ then
		arg_35_0.timer2_:Stop()
	end

	if arg_35_0.timer3_ then
		arg_35_0.timer3_:Stop()
	end

	if arg_35_0.timer4_ then
		arg_35_0.timer4_:Stop()
	end

	SetActive(arg_35_0.gameObject_, false)
	SetActive(arg_35_0.btnMaskGo_, false)
	SetActive(arg_35_0.btnMaskGo2_, false)

	if arg_35_0.dragController_ then
		arg_35_0.dragController_:SetSelectedState("hide")
	end

	arg_35_0.isInDrag_ = false

	arg_35_0:CheckQworldGuide(false)
end

function var_0_0.HideButton(arg_36_0)
	if arg_36_0.timer_ then
		arg_36_0.timer_:Stop()
	end

	if arg_36_0.timer2_ then
		arg_36_0.timer2_:Stop()
	end

	if arg_36_0.timer3_ then
		arg_36_0.timer3_:Stop()
	end

	if arg_36_0.timer4_ then
		arg_36_0.timer4_:Stop()
	end

	SetActive(arg_36_0.btnMaskGo_, false)
	SetActive(arg_36_0.btnMaskGo2_, false)

	if arg_36_0.dragController_ then
		arg_36_0.dragController_:SetSelectedState("hide")
	end

	arg_36_0.isInDrag_ = false
end

function var_0_0.CheckQworldGuide(arg_37_0, arg_37_1)
	if QWorldMgr.isQWorldLoaded_ then
		QWorldLuaBridge.StopControl(arg_37_1)
	end
end

function var_0_0.SetTalkItem(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_2.talk_item_path == "" and "Widget/System/GuideNewUI/Guide_text_default" or arg_38_2.talk_item_path
	local var_38_1 = string.split(var_38_0, "/")
	local var_38_2 = var_38_1[#var_38_1]

	for iter_38_0, iter_38_1 in pairs(arg_38_0.talkItemDic_) do
		iter_38_1:Hide()
	end

	if not arg_38_0.talkItemDic_[var_38_2] then
		local var_38_3 = GameObject.Instantiate(Asset.Load(var_38_0), arg_38_0.textRect_, false)

		var_38_3.transform.localPosition = Vector3.New(0, 0, 0)
		arg_38_0.talkItemDic_[var_38_2] = GuideTalkItem.New(var_38_3)
	end

	arg_38_0.talkItem_ = arg_38_0.talkItemDic_[var_38_2]

	arg_38_0.talkItem_:SetData(arg_38_1, arg_38_2)
	arg_38_0.talkItem_:Show()
end

function var_0_0.SetPointerMove(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	arg_39_0:ResetPointer()

	arg_39_0.delayTimer_ = Timer.New(function()
		local var_40_0 = Vector2.New(arg_39_0.btnMaskCom2_.anchoredPosition.x + arg_39_1.x, arg_39_0.btnMaskCom2_.anchoredPosition.y + arg_39_1.y)
		local var_40_1 = Vector2.New(arg_39_0.btnMaskCom_.anchoredPosition.x + arg_39_2.x, arg_39_0.btnMaskCom_.anchoredPosition.y + arg_39_2.y)
		local var_40_2 = false

		arg_39_0.pointMoveTween_ = LeanTween.value(0, 1, arg_39_3):setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
			if not var_40_2 and arg_41_0 >= 0.05 then
				SetActive(arg_39_0.pointRect_.gameObject, true)
				LuaForUtil.SetTrailRendererClear(arg_39_0.pointRect_.gameObject)

				var_40_2 = true
			end

			arg_39_0.pointRect_.anchoredPosition = Vector2.Lerp(var_40_0, var_40_1, arg_41_0)

			if arg_41_0 >= 1 then
				var_40_2 = false

				SetActive(arg_39_0.pointRect_.gameObject, false)
			end
		end)):setLoopType(LeanTweenType.clamp):setRepeat(-1)
	end, 1, 1)

	arg_39_0.delayTimer_:Start()
end

function var_0_0.ResetPointer(arg_42_0)
	SetActive(arg_42_0.pointRect_.gameObject, false)

	if arg_42_0.pointMoveTween_ then
		arg_42_0.pointMoveTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_42_0.pointMoveTween_.id)

		arg_42_0.pointMoveTween_ = nil
	end

	if arg_42_0.delayTimer_ then
		arg_42_0.delayTimer_:Stop()
	end
end

function var_0_0.Dispose(arg_43_0)
	if arg_43_0.timer_ then
		arg_43_0.timer_:Stop()
	end

	arg_43_0.timer_ = nil

	if arg_43_0.timer2_ then
		arg_43_0.timer2_:Stop()
	end

	arg_43_0.timer2_ = nil

	if arg_43_0.timer3_ then
		arg_43_0.timer3_:Stop()
	end

	arg_43_0.timer3_ = nil

	if arg_43_0.timer4_ then
		arg_43_0.timer4_:Stop()
	end

	arg_43_0.timer4_ = nil

	if arg_43_0.delayTimer_ then
		arg_43_0.delayTimer_:Stop()
	end

	arg_43_0.delayTimer_ = nil

	if arg_43_0.pointMoveTween_ then
		arg_43_0.pointMoveTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_43_0.pointMoveTween_.id)

		arg_43_0.pointMoveTween_ = nil
	end

	if arg_43_0._isInit then
		arg_43_0:RemoveUIListener()
		Object.Destroy(arg_43_0.gameObject_)
	end

	if arg_43_0.talkItemDic_ then
		for iter_43_0, iter_43_1 in pairs(arg_43_0.talkItemDic_) do
			iter_43_1:Dispose()
		end

		arg_43_0.talkItemDic_ = {}
	end

	arg_43_0._isInit = false
end

return var_0_0
