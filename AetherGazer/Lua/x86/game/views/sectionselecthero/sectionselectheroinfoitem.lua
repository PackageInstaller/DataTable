local var_0_0 = class("SectionSelectHeroInfoItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.pos_ = arg_1_2

	SetActive(arg_1_0.gameObject_, true)

	arg_1_0.positionCulculated_ = false

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:InitHandler()
	arg_2_0:InitController()
	arg_2_0:InitSubView()
	arg_2_0:AddUIListener()
end

function var_0_0.InitHandler(arg_3_0)
	arg_3_0.beginDragHeroHandler_ = handler(arg_3_0, arg_3_0.OnSectionBeginDragHero)
end

function var_0_0.InitController(arg_4_0)
	arg_4_0.tipsController_ = arg_4_0.controllerExCollection_:GetController("tips")
	arg_4_0.trialController_ = arg_4_0.controllerExCollection_:GetController("trial")
	arg_4_0.heroLockController_ = arg_4_0.controllerExCollection_:GetController("heroLock")
	arg_4_0.postController_ = arg_4_0.controllerExCollection_:GetController("post")
	arg_4_0.emptyController_ = arg_4_0.controllerExCollection_:GetController("empty")
	arg_4_0.hpController_ = arg_4_0.controllerExCollection_:GetController("HP")
	arg_4_0.assistantController_ = arg_4_0.controllerExCollection_:GetController("assistant")
	arg_4_0.powerController_ = arg_4_0.controllerExCollection_:GetController("power")
	arg_4_0.energyController_ = arg_4_0.controllerExCollection_:GetController("energy")
end

function var_0_0.InitSubView(arg_5_0)
	arg_5_0.randomAttributeTipsView_ = SectionRandomAttributeTipsView.New(arg_5_0.randomAttributeTipsGo_)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0.dragEventListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_7_0, arg_7_1)
		arg_6_0.canDrag_ = not arg_6_0:IsEmpty()

		if not arg_6_0.canDrag_ then
			return
		end

		if arg_6_0.beginDragCallback_ then
			arg_6_0.beginDragCallback_(arg_6_0.pos_, arg_7_0, arg_7_1)
		end
	end))
	arg_6_0.dragEventListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_8_0, arg_8_1)
		if not arg_6_0.canDrag_ then
			return
		end

		if arg_6_0.dragCallback_ then
			arg_6_0.dragCallback_(arg_6_0.pos_, arg_8_0, arg_8_1)
		end
	end))
	arg_6_0.dragEventListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_9_0, arg_9_1)
		if not arg_6_0.canDrag_ then
			return
		end

		if arg_6_0.endDragCallback_ then
			arg_6_0.endDragCallback_(arg_6_0.pos_, arg_9_0, arg_9_1)
		end
	end))
	arg_6_0.dragEventListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_10_0, arg_10_1)
		if arg_6_0.clickCallback_ then
			arg_6_0.clickCallback_(arg_6_0.pos_, arg_10_0, arg_10_1)
		end
	end))
	arg_6_0:AddBtnListener(arg_6_0.randomAttributeTipsBtn_, nil, function()
		manager.notify:Invoke(SECTION_CLICK_RANDOM_ATTRIBUTE_TIPS, arg_6_0.randomAttributeTipsView_.transform_)
		arg_6_0.randomAttributeTipsView_:SetData(arg_6_0.sectionProxy_)
	end)
end

function var_0_0.RegisterBeginDrag(arg_12_0, arg_12_1)
	arg_12_0.beginDragCallback_ = arg_12_1
end

function var_0_0.RegisterDrag(arg_13_0, arg_13_1)
	arg_13_0.dragCallback_ = arg_13_1
end

function var_0_0.RegisterEndDrag(arg_14_0, arg_14_1)
	arg_14_0.endDragCallback_ = arg_14_1
end

function var_0_0.RegistClick(arg_15_0, arg_15_1)
	arg_15_0.clickCallback_ = arg_15_1
end

function var_0_0.GetOriginalDragPosition(arg_16_0)
	return arg_16_0.originalDragPosition_
end

function var_0_0.GetOriginalDragScreenPosition(arg_17_0)
	return arg_17_0.originalDragScreenPos_
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0:RemoveTriggerListeners()

	arg_18_0.originalDragPosition_ = nil

	arg_18_0.randomAttributeTipsView_:Dispose()
	var_0_0.super.Dispose(arg_18_0)
end

function var_0_0.RemoveTriggerListeners(arg_19_0)
	arg_19_0.dragEventListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	arg_19_0.dragEventListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	arg_19_0.dragEventListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	arg_19_0.dragEventListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
end

function var_0_0.SetProxy(arg_20_0, arg_20_1)
	arg_20_0.sectionProxy_ = arg_20_1
end

function var_0_0.OnEnter(arg_21_0, arg_21_1)
	arg_21_0:BindRedPoint()
	arg_21_0:AddEventListener()
	arg_21_0:Show(false)
end

function var_0_0.OnExit(arg_22_0)
	arg_22_0.randomAttributeTipsView_:OnExit()
	arg_22_0:UnBindRedPoint()
	arg_22_0:RemoveAllEventListener()
	arg_22_0:StopAdaptPositionTimer()
end

function var_0_0.AddEventListener(arg_23_0)
	arg_23_0:RegistEventListener(SECTION_BEGIN_DRAG_HERO, arg_23_0.beginDragHeroHandler_)
end

function var_0_0.Refresh(arg_24_0, arg_24_1)
	arg_24_0.pos_ = arg_24_1
	arg_24_0.isCaptain_ = arg_24_1 == 1
	arg_24_0.heroID_ = arg_24_0.sectionProxy_.heroInfoList[arg_24_0.pos_].heroID
	arg_24_0.trialID_ = arg_24_0.sectionProxy_.heroInfoList[arg_24_0.pos_].trialID
	arg_24_0.isPosLock_ = arg_24_0.sectionProxy_.heroInfoList[arg_24_0.pos_].isPosLock
	arg_24_0.isHeroLock_ = arg_24_0.sectionProxy_.heroInfoList[arg_24_0.pos_].isHeroLock

	arg_24_0:RefreshUI()
	arg_24_0:RefreshCustomUI()
end

function var_0_0.RefreshUI(arg_25_0)
	arg_25_0:RefreshAddBtn()

	if arg_25_0:IsEmpty() then
		arg_25_0.emptyController_:SetSelectedState("true")

		return
	else
		arg_25_0.emptyController_:SetSelectedState("false")
	end

	arg_25_0:RefrehsTips()
	arg_25_0:RefreshTrial()
	arg_25_0:RefreshHeroLock()
	arg_25_0:RefershPower()
	arg_25_0:RefreshRace()
	arg_25_0:RefreshPost()
	arg_25_0:RefreshAttackType()
	arg_25_0:RefreshHP()
	arg_25_0:RefreshAssistant()
	arg_25_0:RefreshEnergy()
	arg_25_0:RefreshBaseInfoShow()
end

function var_0_0.RefreshCustomUI(arg_26_0)
	return
end

function var_0_0.RefrehsTips(arg_27_0)
	local var_27_0 = HeroCfg[arg_27_0.heroID_].ATK_attribute

	if type(var_27_0) == "table" then
		for iter_27_0, iter_27_1 in ipairs(var_27_0) do
			if iter_27_1 == HeroConst.HERO_ATTACK_TYPE.RANDOM then
				arg_27_0.tipsController_:SetSelectedState("on")

				return
			end
		end
	end

	arg_27_0.tipsController_:SetSelectedState("off")
end

function var_0_0.RefreshTrial(arg_28_0)
	local var_28_0 = not arg_28_0.isPosLock_ and not arg_28_0.isHeroLock_ and arg_28_0.trialID_ and arg_28_0.trialID_ ~= 0

	arg_28_0.trialController_:SetSelectedState(tostring(var_28_0))
end

function var_0_0.RefreshHeroLock(arg_29_0)
	local var_29_0 = arg_29_0.isHeroLock_ or arg_29_0.isPosLock_

	arg_29_0.heroLockController_:SetSelectedState(tostring(var_29_0))
end

function var_0_0.RefreshAddBtn(arg_30_0)
	if not arg_30_0:IsEmpty() then
		SectionSelectHeroScene.GetInstance():RefreshPositionState(arg_30_0.pos_, SectionSelectHeroConst.HERO_POS_STATE.selected)
	elseif arg_30_0.isPosLock_ == true or not arg_30_0.sectionProxy_.canChangeTeam then
		SectionSelectHeroScene.GetInstance():RefreshPositionState(arg_30_0.pos_, SectionSelectHeroConst.HERO_POS_STATE.lock)
	else
		SectionSelectHeroScene.GetInstance():RefreshPositionState(arg_30_0.pos_, SectionSelectHeroConst.HERO_POS_STATE.empty)
	end
end

function var_0_0.RebindController(arg_31_0)
	SectionSelectHeroScene.GetInstance():RebindController(arg_31_0.pos_)
end

function var_0_0.IsEmpty(arg_32_0)
	return not arg_32_0.heroID_ or arg_32_0.heroID_ == 0
end

function var_0_0.RefershPower(arg_33_0)
	arg_33_0.powerController_:SetSelectedState(tostring(arg_33_0.sectionProxy_.needHeroPower))

	if arg_33_0.sectionProxy_.needHeroPower then
		arg_33_0:RefreshPowerUI()
	end
end

function var_0_0.RefreshPowerUI(arg_34_0)
	arg_34_0.powerText_.text = arg_34_0:GetHeroPower()
end

function var_0_0.RefreshRace(arg_35_0)
	arg_35_0.raceIcon_.sprite = HeroTools.GetHeroRaceIcon(arg_35_0.heroID_)
end

function var_0_0.RefreshPost(arg_36_0)
	arg_36_0.postController_:SetSelectedState(tostring(arg_36_0.isCaptain_))
end

function var_0_0.RefreshAttackType(arg_37_0)
	local var_37_0 = HeroTools.GetHeroSkillAttributeIcon(arg_37_0.heroID_)

	if var_37_0 then
		SetActive(arg_37_0.attackTypeIcon_.gameObject, true)

		arg_37_0.attackTypeIcon_.sprite = var_37_0
	else
		SetActive(arg_37_0.attackTypeIcon_.gameObject, false)
	end
end

function var_0_0.RefreshHP(arg_38_0)
	arg_38_0.hpController_:SetSelectedState(tostring(arg_38_0.sectionProxy_.needHeroHP))

	if arg_38_0.sectionProxy_.needHeroHP then
		arg_38_0:RefreshHPUI()
	end
end

function var_0_0.RefreshHPUI(arg_39_0)
	local var_39_0, var_39_1 = arg_39_0:GetHeroHP()

	arg_39_0.hpImg_.fillAmount = var_39_1 / 100
	arg_39_0.hpText_.text = var_39_1 .. "%"
end

function var_0_0.RefreshAssistant(arg_40_0)
	arg_40_0.assistantController_:SetSelectedState(tostring(arg_40_0.sectionProxy_.needHeroAssistant))

	if arg_40_0.sectionProxy_.needHeroAssistant then
		arg_40_0:RefreshAssistantUI()
	end
end

function var_0_0.RefreshAssistantUI(arg_41_0)
	local var_41_0 = arg_41_0.sectionProxy_.heroInfoList[arg_41_0.pos_].isAssistant

	arg_41_0.assistantController_:SetSelectedState(tostring(var_41_0))
end

function var_0_0.RefreshEnergy(arg_42_0)
	arg_42_0.energyController_:SetSelectedState(tostring(arg_42_0.sectionProxy_.needHeroEnergy))

	if arg_42_0.sectionProxy_.needHeroEnergy then
		arg_42_0:RefreshEnergyUI()
	end
end

function var_0_0.RefreshEnergyUI(arg_43_0)
	if arg_43_0.heroID_ ~= 0 then
		arg_43_0.energyController_:SetSelectedState("true")

		arg_43_0.energyText_.text = arg_43_0:GetHeroEnergy()

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_0.energyBgTrans_)
	else
		arg_43_0.energyController_:SetSelectedState("false")
	end
end

function var_0_0.RefreshBaseInfoShow(arg_44_0)
	local var_44_0 = arg_44_0.heroID_ ~= 0 and HeroCfg[arg_44_0.heroID_] or nil

	if var_44_0 and (var_44_0.role_type == 1 or var_44_0.role_type == 2) then
		SetActive(arg_44_0.baseInfo_, false)
	else
		SetActive(arg_44_0.baseInfo_, true)
	end
end

function var_0_0.BindRedPoint(arg_45_0)
	arg_45_0.sectionProxy_:CustomHeroBindRedPoint(arg_45_0.pos_, arg_45_0)
end

function var_0_0.UnBindRedPoint(arg_46_0)
	arg_46_0.sectionProxy_:CustomHeroUnBindRedPoint(arg_46_0.pos_, arg_46_0)
end

function var_0_0.GetHeroPower(arg_47_0)
	return arg_47_0.sectionProxy_:CustomGetHeroPower(arg_47_0.pos_, arg_47_0.heroID_, arg_47_0.trialID_)
end

function var_0_0.GetHeroHP(arg_48_0)
	return arg_48_0.sectionProxy_:CustomGetHeroHP(arg_48_0.pos_, arg_48_0.heroID_, arg_48_0.trialID_)
end

function var_0_0.GetHeroEnergy(arg_49_0)
	return arg_49_0.sectionProxy_:CustomGetHeroEnergy(arg_49_0.pos_, arg_49_0.heroID_, arg_49_0.trialID_)
end

function var_0_0.Show(arg_50_0, arg_50_1)
	SetActive(arg_50_0.gameObject_, arg_50_1)

	if arg_50_1 then
		arg_50_0.enterAnim_:Update(0)
		arg_50_0:AdaptPosition()
	else
		arg_50_0.randomAttributeTipsView_:Show(false)
	end
end

function var_0_0.OnSectionBeginDragHero(arg_51_0)
	arg_51_0.emptyController_:SetSelectedState("true")
	arg_51_0.randomAttributeTipsView_:Show(false)
end

function var_0_0.UpdatePosition(arg_52_0)
	if not arg_52_0:UpdateLocalPosition() then
		return false
	end

	arg_52_0:UpdateDragPosition()
	arg_52_0:Show(true)

	return true
end

function var_0_0.UpdateLocalPosition(arg_53_0)
	local var_53_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

	if not arg_53_0:IsEmpty() then
		local var_53_1 = SectionSelectHeroScene.GetInstance():GetModelPowerPointScreenPos(arg_53_0.pos_)

		if var_53_1 then
			if var_53_1.x < 0 or var_53_1.x > _G.SCREEN_WIDTH then
				Debug.Log("HeroInfoItem position is out of range, powerPoitnScreenPosX: " .. var_53_1.x)

				return false
			end

			local var_53_2, var_53_3 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_53_0.transform_.parent, var_53_1, var_53_0, nil)

			arg_53_0.transform_:SetLocalPositionEx(var_53_3.x, var_53_3.y, 0)
		end
	else
		local var_53_4 = SectionSelectHeroScene.GetInstance():GetStateGoScreenPos(arg_53_0.pos_)

		if var_53_4 then
			if var_53_4.x < 0 or var_53_4.x > _G.SCREEN_WIDTH then
				Debug.Log("HeroInfoItem position is out of range, sceneStateGoScreenPos: " .. var_53_4.x)

				return false
			end

			local var_53_5, var_53_6 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_53_0.transform_.parent, var_53_4, var_53_0, nil)

			arg_53_0.transform_:SetLocalPositionX(var_53_6.x)
		end
	end

	arg_53_0:AdaptPosition()

	return true
end

function var_0_0.AdaptPosition(arg_54_0)
	arg_54_0:StopAdaptPositionTimer()
	arg_54_0:StartAdaptPositionTimer()
end

function var_0_0.StartAdaptPositionTimer(arg_55_0)
	arg_55_0.adaptTimer = FrameTimer.New(function()
		local var_56_0 = manager.ui.uiCamera:WorldToScreenPoint(arg_55_0.topPointTrans_.position).y

		if var_56_0 > _G.SCREEN_HEIGHT then
			local var_56_1 = (_G.SCREEN_HEIGHT - var_56_0) * manager.ui.canvasRate

			arg_55_0.transform_:SetLocalPositionY(arg_55_0.transform_:GetLocalPositionY() + var_56_1)
		end
	end, 1, 1)

	arg_55_0.adaptTimer:Start()
end

function var_0_0.StopAdaptPositionTimer(arg_57_0)
	if arg_57_0.adaptTimer then
		arg_57_0.adaptTimer:Stop()

		arg_57_0.adaptTimer = nil
	end
end

function var_0_0.UpdateDragPosition(arg_58_0)
	local var_58_0 = arg_58_0.dragEventListener_.transform

	arg_58_0.originalDragPosition_ = var_58_0:GetLocalPosition()
	arg_58_0.originalDragScreenPos_ = manager.ui.uiCamera:WorldToScreenPoint(var_58_0.position)
end

return var_0_0
