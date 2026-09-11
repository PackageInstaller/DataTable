local GuideView = class("GuideView")
local var_0_1 = Vector2(50, 40)

function GuideView:Ctor()
	self._isInit = false
end

function GuideView:Init()
	if self._isInit then
		return
	end

	self.gameObject_ = GameObject.Instantiate(Asset.Load("Widget/System/GuideNewUI/GuideNewUI2"), manager.ui.uiTips.transform)
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	self:AddUIListener()

	self._isInit = true
	self.isInDrag_ = false

	SetActive(self.gameObject_, false)
	self:CheckQworldGuide(false)
end

function GuideView:InitUI()
	ComponentBinder.GetInstance():BindCfgUI(self, self.gameObject_)

	self.breakGuideTrs_ = self.btnBreakGuide_.gameObject:GetComponent(typeof(RectTransform))
	self.imgRectList_ = {}

	for iter_3_0 = 1, 4 do
		table.insert(self.imgRectList_, self["maskImage" .. iter_3_0 .. "_"].gameObject:GetComponent(typeof(RectTransform)))
	end

	self.dragController_ = self.transCon_:GetController("showDrag")
	self.maskController_ = self.transCon_:GetController("mask")
	self.talkItemDic_ = {}
end

function GuideView:AddUIListener()
	self.btnMaskBtn_.onClick:AddListener(function()
		manager.guide:OnComponentClick()
	end)
	self.btnBreakGuide_.onClick:AddListener(function()
		JumpTools.OpenPageByJump("guideStuckPopView", {
			content = GetTips("SKIP_GUIDE"),
			OkCallback = function()
				manager.guide:SkipGuide(self.skipGuide_)
				manager.guide.view:Hide()
			end
		})
	end)
	self.btnNoMask_.onClick:AddListener(function()
		manager.guide:FinishCurrentStep()
	end)
	self.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(function(arg_9_0, arg_9_1)
		if self.isInDrag_ then
			return
		end

		manager.guide:OnEventTrigger("pointerClick", arg_9_1)
	end))
	self.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_10_0, arg_10_1)
		if self.isInDrag_ then
			return
		end

		manager.guide:OnEventTrigger("pointerUp", arg_10_1)
	end))
	self.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_11_0, arg_11_1)
		if self.isInDrag_ then
			return
		end

		manager.guide:OnEventTrigger("pointerDown", arg_11_1)
	end))
	self.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_12_0, arg_12_1)
		if self.isInDrag_ then
			return
		end

		manager.guide:OnEventTrigger("beginDrag", arg_12_1)
	end))
	self.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_13_0, arg_13_1)
		if self.isInDrag_ then
			return
		end

		manager.guide:OnEventTrigger("drag", arg_13_1)
	end))
	self.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerEnter, LuaHelper.EventTriggerAction1(function(arg_14_0, arg_14_1)
		manager.guide:OnEventTrigger("onPointerEnter", arg_14_1)
	end))
	self.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerExit, LuaHelper.EventTriggerAction1(function(arg_15_0, arg_15_1)
		manager.guide:OnEventTrigger("onPointerExit", arg_15_1)
	end))
	self.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_16_0, arg_16_1)
		if self.isInDrag_ then
			return
		end

		manager.guide:OnEventTrigger("endDrag", arg_16_1)
	end))
	self.eventTrigger2_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerEnter, LuaHelper.EventTriggerAction1(function(arg_17_0, arg_17_1)
		manager.guide:OnEventTrigger("onPointerEnter", arg_17_1)
	end))
	self.eventTrigger2_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_18_0, arg_18_1)
		manager.guide:OnEventTrigger("beginDrag", arg_18_1)
	end))
	self.eventTrigger2_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_19_0, arg_19_1)
		manager.guide:OnEventTrigger("drag", arg_19_1)
	end))
	self.eventTrigger2_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_20_0, arg_20_1)
		manager.guide:OnEventTrigger("endDrag", arg_20_1)
	end))
end

function GuideView:RemoveUIListener()
	self.btnMaskBtn_.onClick:RemoveAllListeners()
	self.eventTrigger_:RemoveAllListeners()
end

function GuideView:ShowTalk(arg_22_1)
	local var_22_0 = arg_22_1.talk_anchors
	local var_22_1 = arg_22_1.talk_position == "" and {} or arg_22_1.talk_position
	local var_22_2 = arg_22_1.talk_adapt

	if not arg_22_1.talk_content or arg_22_1.talk_content == "" then
		SetActive(self.textPanel_, false)

		return
	end

	SetActive(self.textPanel_, true)

	if var_22_0 == 1 then
		self.textRect_.anchorMax = Vector2.New(0, 1)
		self.textRect_.anchorMin = Vector2.New(0, 1)
	elseif var_22_0 == 2 then
		self.textRect_.anchorMax = Vector2.New(1, 1)
		self.textRect_.anchorMin = Vector2.New(1, 1)
	elseif var_22_0 == 3 then
		self.textRect_.anchorMax = Vector2.New(1, 0)
		self.textRect_.anchorMin = Vector2.New(1, 0)
	elseif var_22_0 == 4 then
		self.textRect_.anchorMax = Vector2.New(0, 0)
		self.textRect_.anchorMin = Vector2.New(0, 0)
	elseif var_22_0 == 5 then
		self.textRect_.anchorMax = Vector2.New(0, 0.5)
		self.textRect_.anchorMin = Vector2.New(0, 0.5)
	elseif var_22_0 == 6 then
		self.textRect_.anchorMax = Vector2.New(0.5, 1)
		self.textRect_.anchorMin = Vector2.New(0.5, 1)
	elseif var_22_0 == 7 then
		self.textRect_.anchorMax = Vector2.New(1, 0.5)
		self.textRect_.anchorMin = Vector2.New(1, 0.5)
	elseif var_22_0 == 8 then
		self.textRect_.anchorMax = Vector2.New(0.5, 0)
		self.textRect_.anchorMin = Vector2.New(0.5, 0)
	else
		self.textRect_.anchorMax = Vector2.New(0.5, 0.5)
		self.textRect_.anchorMin = Vector2.New(0.5, 0.5)
	end

	self.textRect_.anchoredPosition = var_22_2 == 1 and Vector2.New((var_22_1[1] or 0) + ReduxView.VIEW_ADAPT_DISTANCE, var_22_1[2] or 0) or var_22_2 == 2 and Vector2.New((var_22_1[1] or 0) - ReduxView.VIEW_ADAPT_DISTANCE, var_22_1[2] or 0) or Vector2.New(var_22_1[1] or 0, var_22_1[2] or 0)
end

function GuideView:ShowHoldMask(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	SetActive(self.gameObject_, true)
	SetActive(self.btnMaskGo_, true)
	self.maskController_:SetSelectedState(tostring(not arg_23_4))
	self:CheckQworldGuide(true)

	local var_23_0 = arg_23_1:GetComponent("RectTransform")

	if var_23_0 ~= nil then
		self:ShowUIMask(arg_23_1, var_23_0, arg_23_2)
	else
		local var_23_1 = manager.ui.mainCameraCom_
		local var_23_2 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

		if self.timer2_ then
			self.timer2_:Stop()
		end

		self.maskImage1_.sprite = nil
		self.maskImage2_.sprite = nil
		self.imgRectList_[1].pivot = Vector2(0.5, 0.5)
		self.imgRectList_[2].pivot = Vector2(0.5, 0.5)
		self.timer2_ = Timer.New(function()
			local var_24_0, var_24_1 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.transform_, UnityEngine.RectTransformUtility.WorldToScreenPoint(var_23_1, arg_23_1.transform.position), var_23_2, nil)

			self.imgRectList_[1].sizeDelta = Vector2(arg_23_3[1][1], arg_23_3[1][2])
			self.imgRectList_[2].sizeDelta = Vector2(arg_23_3[1][1], arg_23_3[1][2])
			self.imgRectList_[1].anchoredPosition = var_24_1
			self.imgRectList_[2].anchoredPosition = var_24_1
			self.btnMaskCom_.sizeDelta = Vector2(arg_23_3[1][1], arg_23_3[1][2]) + var_0_1
			self.btnMaskCom_.anchoredPosition = var_24_1
		end, 0.033, -1)

		self.timer2_:Start()
	end
end

function GuideView:ShowHoldMask2(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	self.isInDrag_ = true

	self:CheckQworldGuide(true)

	local var_25_0 = arg_25_1:GetComponent("RectTransform")

	if var_25_0 ~= nil then
		self:ShowUIMask2(arg_25_1, var_25_0, arg_25_2)
	else
		local var_25_1 = manager.ui.mainCameraCom_
		local var_25_2 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

		if self.timer3_ then
			self.timer3_:Stop()
		end

		self.maskImage3_.sprite = nil
		self.maskImage4_.sprite = nil
		self.imgRectList_[3].pivot = Vector2(0.5, 0.5)
		self.imgRectList_[4].pivot = Vector2(0.5, 0.5)
		self.timer3_ = Timer.New(function()
			local var_26_0, var_26_1 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.transform_, UnityEngine.RectTransformUtility.WorldToScreenPoint(var_25_1, arg_25_1.transform.position), var_25_2, nil)

			self.imgRectList_[3].sizeDelta = Vector2(arg_25_3[1][1], arg_25_3[1][2])
			self.imgRectList_[4].sizeDelta = Vector2(arg_25_3[1][1], arg_25_3[1][2])
			self.imgRectList_[3].anchoredPosition = var_26_1
			self.imgRectList_[4].anchoredPosition = var_26_1
		end, 0.033, -1)

		self.timer3_:Start()
	end

	self.dragController_:SetSelectedState("show")
	SetActive(self.btnMaskGo2_, true)
end

function GuideView:UpdateMask(arg_28_1, arg_28_2)
	arg_28_2.com1.pivot = arg_28_1.pivot
	arg_28_2.com2.pivot = arg_28_1.pivot
	arg_28_2.com1.sizeDelta = Vector2(arg_28_1.rect.width, arg_28_1.rect.height) + arg_28_2.highLightOffSize
	arg_28_2.com2.sizeDelta = Vector2(arg_28_1.rect.width, arg_28_1.rect.height) + arg_28_2.highLightOffSize
	arg_28_2.com1.position = arg_28_1.position
	arg_28_2.com2.position = arg_28_1.position
	arg_28_2.com1.eulerAngles = arg_28_1.eulerAngles
	arg_28_2.com2.eulerAngles = arg_28_1.eulerAngles
	arg_28_2.com1.localScale = arg_28_2.scale
	arg_28_2.com2.localScale = arg_28_2.scale
	arg_28_2.maskCom.sizeDelta = Vector2(arg_28_1.rect.width, arg_28_1.rect.height) + var_0_1 + arg_28_2.offSize
	arg_28_2.maskCom.position = arg_28_1.position
	arg_28_2.maskCom.anchoredPosition = arg_28_2.maskCom.anchoredPosition + Vector2.Scale(arg_28_2.scale, (Vector3((0.5 - arg_28_1.pivot.x) * arg_28_1.rect.width, (0.5 - arg_28_1.pivot.y) * arg_28_1.rect.height, 0)))
	arg_28_2.maskCom.eulerAngles = arg_28_1.eulerAngles
	arg_28_2.maskCom.localScale = arg_28_2.scale
end

function GuideView:ShowUIMask(arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = Vector3(0, 0, 0)
	local var_29_1 = Vector3(0, 0, 0)
	local var_29_2 = Vector2(0, 0)
	local var_29_3 = Vector2(0, 0)

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_2)

	local var_29_4 = arg_29_1:GetComponent(typeof(Image))

	if var_29_4 and var_29_4.enabled then
		self.maskImage1_.sprite = var_29_4.sprite
		self.maskImage2_.sprite = var_29_4.sprite
	else
		self.maskImage1_.sprite = nil
		self.maskImage2_.sprite = nil
	end

	if self.timer_ then
		self.timer_:Stop()
	end

	local var_29_5 = {
		isDrag = true,
		highLightOffSize = var_29_3,
		offSize = var_29_2,
		scale = arg_29_3,
		com1 = self.imgRectList_[1],
		com2 = self.imgRectList_[2],
		maskCom = self.btnMaskCom_
	}

	self.timer_ = Timer.New(function()
		if isNil(arg_29_1) then
			self.timer_:Stop()

			self.timer_ = nil

			return
		end

		self:UpdateMask(arg_29_2, var_29_5)
	end, 0.033, -1)

	self.timer_:Start()
end

function GuideView:ShowUIMask2(arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = Vector3(0, 0, 0)
	local var_31_1 = Vector3(0, 0, 0)
	local var_31_2 = Vector2(0, 0)
	local var_31_3 = Vector2(0, 0)

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_2)

	local var_31_4 = arg_31_1:GetComponent(typeof(Image))

	if var_31_4 and var_31_4.enabled then
		self.maskImage3_.sprite = var_31_4.sprite
		self.maskImage4_.sprite = var_31_4.sprite
	else
		self.maskImage3_.sprite = nil
		self.maskImage4_.sprite = nil
	end

	if self.timer4_ then
		self.timer4_:Stop()
	end

	local var_31_5 = {
		isDrag = true,
		highLightOffSize = var_31_3,
		offSize = var_31_2,
		scale = arg_31_3,
		com1 = self.imgRectList_[3],
		com2 = self.imgRectList_[4],
		maskCom = self.btnMaskCom2_
	}

	self.timer4_ = Timer.New(function()
		if isNil(arg_31_1) then
			self.timer4_:Stop()

			self.timer4_ = nil

			return
		end

		self:UpdateMask(arg_31_2, var_31_5)
	end, 0.033, -1)

	self.timer4_:Start()
end

function GuideView:ShowBreakStuck(arg_33_1, arg_33_2)
	self:AdaptBreakGuide()

	self.skipGuide_ = arg_33_1

	SetActive(self.btnBreakGuide_, arg_33_2)
end

function GuideView:AdaptBreakGuide()
	if not isNil(self.breakGuideTrs_) then
		self.breakGuideTrs_.anchoredPosition = Vector3(-ReduxView.VIEW_ADAPT_DISTANCE, -53.7, 0)
	end
end

function GuideView:Hide()
	if self.timer_ then
		self.timer_:Stop()
	end

	if self.timer2_ then
		self.timer2_:Stop()
	end

	if self.timer3_ then
		self.timer3_:Stop()
	end

	if self.timer4_ then
		self.timer4_:Stop()
	end

	SetActive(self.gameObject_, false)
	SetActive(self.btnMaskGo_, false)
	SetActive(self.btnMaskGo2_, false)

	if self.dragController_ then
		self.dragController_:SetSelectedState("hide")
	end

	self.isInDrag_ = false

	self:CheckQworldGuide(false)
end

function GuideView:HideButton()
	if self.timer_ then
		self.timer_:Stop()
	end

	if self.timer2_ then
		self.timer2_:Stop()
	end

	if self.timer3_ then
		self.timer3_:Stop()
	end

	if self.timer4_ then
		self.timer4_:Stop()
	end

	SetActive(self.btnMaskGo_, false)
	SetActive(self.btnMaskGo2_, false)

	if self.dragController_ then
		self.dragController_:SetSelectedState("hide")
	end

	self.isInDrag_ = false
end

function GuideView:CheckQworldGuide(arg_37_1)
	if QWorldMgr.isQWorldLoaded_ then
		QWorldLuaBridge.StopControl(arg_37_1)
	end
end

function GuideView:SetTalkItem(arg_38_1, arg_38_2)
	local var_38_0 = arg_38_2.talk_item_path == "" and "Widget/System/GuideNewUI/Guide_text_default" or arg_38_2.talk_item_path
	local var_38_1 = string.split(arg_38_2.talk_item_path == "" and "Widget/System/GuideNewUI/Guide_text_default" or arg_38_2.talk_item_path, "/")

	for iter_38_0, iter_38_1 in pairs(self.talkItemDic_) do
		iter_38_1:Hide()
	end

	if not self.talkItemDic_[var_38_1[#var_38_1]] then
		local var_38_2 = GameObject.Instantiate(Asset.Load(var_38_0), self.textRect_, false)

		var_38_2.transform.localPosition = Vector3.New(0, 0, 0)
		self.talkItemDic_[var_38_1[#var_38_1]] = GuideTalkItem.New(var_38_2)
	end

	self.talkItem_ = self.talkItemDic_[var_38_1[#var_38_1]]

	self.talkItem_:SetData(arg_38_1, arg_38_2)
	self.talkItem_:Show()
end

function GuideView:SetPointerMove(arg_39_1, arg_39_2, arg_39_3)
	self:ResetPointer()

	self.delayTimer_ = Timer.New(function()
		local var_40_0 = Vector2.New(self.btnMaskCom2_.anchoredPosition.x + arg_39_1.x, self.btnMaskCom2_.anchoredPosition.y + arg_39_1.y)
		local var_40_1 = Vector2.New(self.btnMaskCom_.anchoredPosition.x + arg_39_2.x, self.btnMaskCom_.anchoredPosition.y + arg_39_2.y)
		local var_40_2 = false

		self.pointMoveTween_ = LeanTween.value(0, 1, arg_39_3):setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
			if not var_40_2 and arg_41_0 >= 0.05 then
				SetActive(self.pointRect_.gameObject, true)
				LuaForUtil.SetTrailRendererClear(self.pointRect_.gameObject)

				var_40_2 = true
			end

			self.pointRect_.anchoredPosition = Vector2.Lerp(var_40_0, var_40_1, arg_41_0)

			if arg_41_0 >= 1 then
				var_40_2 = false

				SetActive(self.pointRect_.gameObject, false)
			end
		end)):setLoopType(LeanTweenType.clamp):setRepeat(-1)
	end, 1, 1)

	self.delayTimer_:Start()
end

function GuideView:ResetPointer()
	SetActive(self.pointRect_.gameObject, false)

	if self.pointMoveTween_ then
		self.pointMoveTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.pointMoveTween_.id)

		self.pointMoveTween_ = nil
	end

	if self.delayTimer_ then
		self.delayTimer_:Stop()
	end
end

function GuideView:Dispose()
	if self.timer_ then
		self.timer_:Stop()
	end

	self.timer_ = nil

	if self.timer2_ then
		self.timer2_:Stop()
	end

	self.timer2_ = nil

	if self.timer3_ then
		self.timer3_:Stop()
	end

	self.timer3_ = nil

	if self.timer4_ then
		self.timer4_:Stop()
	end

	self.timer4_ = nil

	if self.delayTimer_ then
		self.delayTimer_:Stop()
	end

	self.delayTimer_ = nil

	if self.pointMoveTween_ then
		self.pointMoveTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.pointMoveTween_.id)

		self.pointMoveTween_ = nil
	end

	if self._isInit then
		self:RemoveUIListener()
		Object.Destroy(self.gameObject_)
	end

	if self.talkItemDic_ then
		for iter_43_0, iter_43_1 in pairs(self.talkItemDic_) do
			iter_43_1:Dispose()
		end

		self.talkItemDic_ = {}
	end

	self._isInit = false
end

return GuideView
