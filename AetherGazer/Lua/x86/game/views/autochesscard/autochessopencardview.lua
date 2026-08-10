local var_0_0 = class("AutoChessOpenCardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_AutoChess_Main/Unpack/Activity_Unpack_OpenBoxUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.choiceController = arg_4_0.controller_:GetController("choice")
	arg_4_0.guideController_ = arg_4_0.controller_:GetController("guide")
	arg_4_0.cardListController_ = arg_4_0.controller_:GetController("cardList")
	arg_4_0.cardItemSingleList = {}
	arg_4_0.cardItemList = {}
	arg_4_0.BoxItems = {}
	arg_4_0.BoxItems[6] = AutoChessOpenCardBoxItem.New(arg_4_0.boxGo_, arg_4_0.singleCardTrans_)

	arg_4_0.BoxItems[6]:SetLightState(true)

	for iter_4_0 = 1, 5 do
		arg_4_0.BoxItems[iter_4_0] = AutoChessOpenCardBoxItem.New(arg_4_0.boxGo_, arg_4_0["multiCardTrans" .. iter_4_0 .. "_"])

		arg_4_0.BoxItems[iter_4_0]:SetLightState(false)
	end

	arg_4_0.URFactoryItem_ = AutoChessURFactoryItem.New(arg_4_0.UrItemGo_)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.skipBtn_, nil, function()
		arg_5_0.anim_:Play("UI_Activity_Unpack_OpenBoxUI_hide")
		JumpTools.OpenPageByJump("autoChessShowCardListPop", {
			mode = arg_5_0.mode_,
			cardList = cardList
		})
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_gacha_skip",
			activity_id = AutoChessData:GetActivityID()
		})
	end)
end

function var_0_0.OnBeginDragFun(arg_7_0)
	if arg_7_0.disableDrag_ then
		return
	end

	arg_7_0.isBeginDrag_ = true

	arg_7_0.guideController_:SetSelectedState("show")
	arg_7_0:SetGuideState("off")

	arg_7_0.posX_ = nil
	arg_7_0.length_ = 0
end

function var_0_0.OnTop(arg_8_0)
	SetActive(arg_8_0.skipBtn_.gameObject, true)
	manager.windowBar:HideBar()
end

function var_0_0.SetGuideState(arg_9_0, arg_9_1)
	if arg_9_0.mode_ == AutoChessCardConst.OPEN_CARD_MODE_SINGLE then
		arg_9_0.BoxItems[6]:SetGuideState(arg_9_1)
	else
		arg_9_0.BoxItems[1]:SetGuideState(arg_9_1)
	end
end

function var_0_0.OnDragFun(arg_10_0)
	if arg_10_0.disableDrag_ then
		return
	end

	if not arg_10_0.isBeginDrag_ then
		return
	end

	local var_10_0 = Vector2.New(Input.mousePosition.x, Input.mousePosition.y)
	local var_10_1 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_10_2 = {}
	local var_10_3, var_10_4 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_10_0.parentTrans_, var_10_0, var_10_1, var_10_2)

	arg_10_0.guideTrans_.localPosition = var_10_4

	arg_10_0:Check(var_10_4)
end

function var_0_0.Check(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.areaTrans_.rect.width
	local var_11_1 = arg_11_0.areaTrans_.rect.height
	local var_11_2 = arg_11_0.areaTrans_.localPosition

	if var_11_2.x < arg_11_1.x and arg_11_1.x < var_11_2.x + var_11_0 and var_11_2.y < arg_11_1.y and arg_11_1.y < var_11_2.y + var_11_1 then
		if arg_11_0.length_ >= arg_11_0:GetCheckMaxLength() then
			return
		end

		if arg_11_0.posX_ == nil then
			arg_11_0.posX_ = arg_11_1.x
		elseif arg_11_1.x > arg_11_0.posX_ then
			local var_11_3 = arg_11_1.x - arg_11_0.posX_

			arg_11_0.length_ = math.max(arg_11_0.length_, var_11_3)
		end
	else
		if arg_11_0.length_ >= arg_11_0:GetCheckMaxLength() then
			return
		end

		arg_11_0.posX_ = nil
		arg_11_0.length_ = 0
	end
end

function var_0_0.OnEndDragFun(arg_12_0)
	if arg_12_0.disableDrag_ then
		return
	end

	arg_12_0.isBeginDrag_ = false

	local var_12_0 = arg_12_0.areaTrans_.rect.width

	if arg_12_0.length_ >= arg_12_0:GetCheckMaxLength() then
		arg_12_0.guideController_:SetSelectedState("hide")
		arg_12_0:SetGuideState("off")
		manager.windowBar:HideBar()
		SetActive(arg_12_0.skipBtn_.gameObject, false)
		arg_12_0:PlayExitAnim()
	else
		arg_12_0.guideController_:SetSelectedState("show")
		arg_12_0:SetGuideState("on")
	end
end

function var_0_0.GetCheckMaxLength(arg_13_0)
	return arg_13_0.areaTrans_.rect.width / 2
end

function var_0_0.PlayExitAnim(arg_14_0)
	arg_14_0.disableDrag_ = true

	AnimatorTools.Stop()

	if arg_14_0.mode_ == AutoChessCardConst.OPEN_CARD_MODE_SINGLE then
		arg_14_0.BoxItems[6]:PlayAnim(function()
			arg_14_0:PlayOutAnim()
		end)
	else
		local var_14_0 = 1

		arg_14_0.BoxItems[var_14_0]:PlayAnim()

		arg_14_0.timer_ = Timer.New(function()
			var_14_0 = var_14_0 + 1

			if var_14_0 == 5 then
				local var_16_0 = arg_14_0.blueAnim_

				if arg_14_0:CheckIsOpenURCard(1, #arg_14_0.cardList_) then
					var_16_0 = arg_14_0.UrAnim_
				end

				var_16_0:Play("UrRotation", 0, 0)
				arg_14_0.BoxItems[var_14_0]:PlayAnim(function()
					arg_14_0:PlayOutAnim()
				end)
			else
				arg_14_0.BoxItems[var_14_0]:PlayAnim()
			end
		end, 0.25, 4)

		arg_14_0.timer_:Start()
	end
end

function var_0_0.PlayOutAnim(arg_18_0)
	AnimatorTools.PlayAnimationWithCallback(arg_18_0.anim_, "UI_Activity_Unpack_OpenBoxUI_out", function()
		arg_18_0.anim_:Play("UI_Activity_Unpack_OpenBoxUI_hide")
		JumpTools.OpenPageByJump("autoChessShowCardListPop", {
			mode = arg_18_0.mode_,
			cardList = arg_18_0.cardList_
		})
	end, false, 0, 0)
end

function var_0_0.RefreshOneUI(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0.cardList_) do
		if arg_20_0.cardItemSingleList[iter_20_0] then
			arg_20_0.cardItemSingleList[iter_20_0]:SetData(iter_20_1, arg_20_0.URFactoryItem_:GetItem(iter_20_1))
		else
			local var_20_0 = AutoChessCardItem.New(arg_20_0.onePanelTrans_:GetChild(iter_20_0 - 1).gameObject)

			var_20_0:SetData(iter_20_1, arg_20_0.URFactoryItem_:GetItem(iter_20_1))

			arg_20_0.cardItemSingleList[iter_20_0] = var_20_0
		end
	end
end

function var_0_0.RefreshMoreUI(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0.cardList_) do
		local var_21_0 = iter_21_0 % 5
		local var_21_1 = math.ceil(iter_21_0 / 5)

		if arg_21_0.cardItemList[iter_21_0] then
			arg_21_0.cardItemList[iter_21_0]:SetData(iter_21_1, arg_21_0.URFactoryItem_:GetItem(iter_21_1))
		else
			local var_21_2 = arg_21_0["morePanelTrans" .. var_21_1 .. "_"]
			local var_21_3 = AutoChessCardItem.New(var_21_2:GetChild(var_21_0).gameObject)

			var_21_3:SetData(iter_21_1, arg_21_0.URFactoryItem_:GetItem(iter_21_1))

			arg_21_0.cardItemList[iter_21_0] = var_21_3
		end
	end
end

function var_0_0.StopTimer(arg_22_0)
	if arg_22_0.timer_ then
		arg_22_0.timer_:Stop()

		arg_22_0.timer_ = nil
	end
end

function var_0_0.OnEnter(arg_23_0)
	arg_23_0.disableDrag_ = false

	arg_23_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_23_0, arg_23_0.OnBeginDragFun)))
	arg_23_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(arg_23_0, arg_23_0.OnDragFun)))
	arg_23_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(arg_23_0, arg_23_0.OnEndDragFun)))

	arg_23_0.mode_ = arg_23_0.params_.mode
	arg_23_0.cardList_ = arg_23_0.params_.cardList

	if arg_23_0.mode_ == AutoChessCardConst.OPEN_CARD_MODE_SINGLE then
		arg_23_0.choiceController:SetSelectedState("CardPanelSingle")
		arg_23_0.BoxItems[6]:SetData(arg_23_0:CheckIsOpenURCard(1, 5))
		arg_23_0.cardListController_:SetSelectedState("single")
		arg_23_0:RefreshOneUI()
	else
		arg_23_0.choiceController:SetSelectedState("CardPanelEven")
		arg_23_0.cardListController_:SetSelectedState("multi")
		arg_23_0:RefreshMoreUI()

		for iter_23_0 = 1, 5 do
			arg_23_0.BoxItems[iter_23_0]:SetData(arg_23_0:CheckIsOpenURCard((iter_23_0 - 1) * 5 + 1, iter_23_0 * 5))
		end
	end

	arg_23_0:SetGuideState("on")
end

function var_0_0.CheckIsOpenURCard(arg_24_0, arg_24_1, arg_24_2)
	for iter_24_0 = arg_24_1, arg_24_2 do
		local var_24_0 = arg_24_0.cardList_[iter_24_0]

		if var_24_0 and AutoChessCardCfg[var_24_0].type == AutoChessCardConst.CARD_TYPE.UR then
			return true
		end
	end

	return false
end

function var_0_0.OnExit(arg_25_0)
	arg_25_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	arg_25_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	arg_25_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	arg_25_0.anim_:Rebind()

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.BoxItems) do
		iter_25_1:OnExit()
	end

	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_26_0)
	AnimatorTools.Stop()

	for iter_26_0, iter_26_1 in ipairs(arg_26_0.BoxItems) do
		iter_26_1:Dispose()
	end

	for iter_26_2, iter_26_3 in ipairs(arg_26_0.cardItemList) do
		iter_26_3:Dispose()
	end

	for iter_26_4, iter_26_5 in ipairs(arg_26_0.cardItemSingleList) do
		iter_26_5:Dispose()
	end

	arg_26_0.URFactoryItem_:Dispose()
	arg_26_0:StopTimer()
	var_0_0.super.Dispose(arg_26_0)
end

return var_0_0
