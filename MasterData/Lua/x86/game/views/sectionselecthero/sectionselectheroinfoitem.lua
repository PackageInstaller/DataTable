local SectionSelectHeroInfoItem = class("SectionSelectHeroInfoItem", ReduxView)

function SectionSelectHeroInfoItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.pos_ = arg_1_2

	SetActive(self.gameObject_, true)

	self.positionCulculated_ = false

	self:Init()
end

function SectionSelectHeroInfoItem:Init()
	self:BindCfgUI()
	self:InitHandler()
	self:InitController()
	self:InitSubView()
	self:AddUIListener()
end

function SectionSelectHeroInfoItem:InitHandler()
	self.beginDragHeroHandler_ = handler(self, self.OnSectionBeginDragHero)
end

function SectionSelectHeroInfoItem:InitController()
	self.tipsController_ = self.controllerExCollection_:GetController("tips")
	self.trialController_ = self.controllerExCollection_:GetController("trial")
	self.heroLockController_ = self.controllerExCollection_:GetController("heroLock")
	self.postController_ = self.controllerExCollection_:GetController("post")
	self.emptyController_ = self.controllerExCollection_:GetController("empty")
	self.hpController_ = self.controllerExCollection_:GetController("HP")
	self.assistantController_ = self.controllerExCollection_:GetController("assistant")
	self.powerController_ = self.controllerExCollection_:GetController("power")
	self.energyController_ = self.controllerExCollection_:GetController("energy")
end

function SectionSelectHeroInfoItem:InitSubView()
	self.randomAttributeTipsView_ = SectionRandomAttributeTipsView.New(self.randomAttributeTipsGo_)
end

function SectionSelectHeroInfoItem:AddUIListener()
	self.dragEventListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_7_0, arg_7_1)
		self.canDrag_ = not self:IsEmpty()

		if not self.canDrag_ then
			return
		end

		if self.beginDragCallback_ then
			self.beginDragCallback_(self.pos_, arg_7_0, arg_7_1)
		end
	end))
	self.dragEventListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_8_0, arg_8_1)
		if not self.canDrag_ then
			return
		end

		if self.dragCallback_ then
			self.dragCallback_(self.pos_, arg_8_0, arg_8_1)
		end
	end))
	self.dragEventListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_9_0, arg_9_1)
		if not self.canDrag_ then
			return
		end

		if self.endDragCallback_ then
			self.endDragCallback_(self.pos_, arg_9_0, arg_9_1)
		end
	end))
	self.dragEventListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_10_0, arg_10_1)
		if self.clickCallback_ then
			self.clickCallback_(self.pos_, arg_10_0, arg_10_1)
		end
	end))
	self:AddBtnListener(self.randomAttributeTipsBtn_, nil, function()
		manager.notify:Invoke(SECTION_CLICK_RANDOM_ATTRIBUTE_TIPS, self.randomAttributeTipsView_.transform_)
		self.randomAttributeTipsView_:SetData(self.sectionProxy_)
	end)
end

function SectionSelectHeroInfoItem:RegisterBeginDrag(arg_12_1)
	self.beginDragCallback_ = arg_12_1
end

function SectionSelectHeroInfoItem:RegisterDrag(arg_13_1)
	self.dragCallback_ = arg_13_1
end

function SectionSelectHeroInfoItem:RegisterEndDrag(arg_14_1)
	self.endDragCallback_ = arg_14_1
end

function SectionSelectHeroInfoItem:RegistClick(arg_15_1)
	self.clickCallback_ = arg_15_1
end

function SectionSelectHeroInfoItem:GetOriginalDragPosition()
	return self.originalDragPosition_
end

function SectionSelectHeroInfoItem:GetOriginalDragScreenPosition()
	return self.originalDragScreenPos_
end

function SectionSelectHeroInfoItem:Dispose()
	self:RemoveTriggerListeners()

	self.originalDragPosition_ = nil

	self.randomAttributeTipsView_:Dispose()
	SectionSelectHeroInfoItem.super.Dispose(self)
end

function SectionSelectHeroInfoItem:RemoveTriggerListeners()
	self.dragEventListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	self.dragEventListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	self.dragEventListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	self.dragEventListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
end

function SectionSelectHeroInfoItem:SetProxy(arg_20_1)
	self.sectionProxy_ = arg_20_1
end

function SectionSelectHeroInfoItem:OnEnter(arg_21_1)
	self:BindRedPoint()
	self:AddEventListener()
	self:Show(false)
end

function SectionSelectHeroInfoItem:OnExit()
	self.randomAttributeTipsView_:OnExit()
	self:UnBindRedPoint()
	self:RemoveAllEventListener()
	self:StopAdaptPositionTimer()
end

function SectionSelectHeroInfoItem:AddEventListener()
	self:RegistEventListener(SECTION_BEGIN_DRAG_HERO, self.beginDragHeroHandler_)
end

function SectionSelectHeroInfoItem:Refresh(arg_24_1)
	self.pos_ = arg_24_1
	self.isCaptain_ = arg_24_1 == 1
	self.heroID_ = self.sectionProxy_.heroInfoList[self.pos_].heroID
	self.trialID_ = self.sectionProxy_.heroInfoList[self.pos_].trialID
	self.isPosLock_ = self.sectionProxy_.heroInfoList[self.pos_].isPosLock
	self.isHeroLock_ = self.sectionProxy_.heroInfoList[self.pos_].isHeroLock

	self:RefreshUI()
	self:RefreshCustomUI()
end

function SectionSelectHeroInfoItem:RefreshUI()
	self:RefreshAddBtn()

	if self:IsEmpty() then
		self.emptyController_:SetSelectedState("true")

		return
	else
		self.emptyController_:SetSelectedState("false")
	end

	self:RefrehsTips()
	self:RefreshTrial()
	self:RefreshHeroLock()
	self:RefershPower()
	self:RefreshRace()
	self:RefreshPost()
	self:RefreshAttackType()
	self:RefreshHP()
	self:RefreshAssistant()
	self:RefreshEnergy()
	self:RefreshBaseInfoShow()
end

function SectionSelectHeroInfoItem:RefreshCustomUI()
	return
end

function SectionSelectHeroInfoItem:RefrehsTips()
	if type(HeroCfg[self.heroID_].ATK_attribute) == "table" then
		for iter_27_0, iter_27_1 in ipairs(HeroCfg[self.heroID_].ATK_attribute) do
			if iter_27_1 == HeroConst.HERO_ATTACK_TYPE.RANDOM then
				self.tipsController_:SetSelectedState("on")

				return
			end
		end
	end

	self.tipsController_:SetSelectedState("off")
end

function SectionSelectHeroInfoItem:RefreshTrial()
	self.trialController_:SetSelectedState(tostring((not self.isPosLock_ and not self.isHeroLock_ or nil) and self.trialID_ and self.trialID_ ~= 0))
end

function SectionSelectHeroInfoItem:RefreshHeroLock()
	self.heroLockController_:SetSelectedState(tostring(self.isHeroLock_ or self.isPosLock_))
end

function SectionSelectHeroInfoItem:RefreshAddBtn()
	if not self:IsEmpty() then
		SectionSelectHeroScene.GetInstance():RefreshPositionState(self.pos_, SectionSelectHeroConst.HERO_POS_STATE.selected)
	elseif self.isPosLock_ == true or not self.sectionProxy_.canChangeTeam then
		SectionSelectHeroScene.GetInstance():RefreshPositionState(self.pos_, SectionSelectHeroConst.HERO_POS_STATE.lock)
	else
		SectionSelectHeroScene.GetInstance():RefreshPositionState(self.pos_, SectionSelectHeroConst.HERO_POS_STATE.empty)
	end
end

function SectionSelectHeroInfoItem:RebindController()
	SectionSelectHeroScene.GetInstance():RebindController(self.pos_)
end

function SectionSelectHeroInfoItem:IsEmpty()
	return not self.heroID_ or self.heroID_ == 0
end

function SectionSelectHeroInfoItem:RefershPower()
	self.powerController_:SetSelectedState(tostring(self.sectionProxy_.needHeroPower))

	if self.sectionProxy_.needHeroPower then
		self:RefreshPowerUI()
	end
end

function SectionSelectHeroInfoItem:RefreshPowerUI()
	self.powerText_.text = self:GetHeroPower()
end

function SectionSelectHeroInfoItem:RefreshRace()
	self.raceIcon_.sprite = HeroTools.GetHeroRaceIcon(self.heroID_)
end

function SectionSelectHeroInfoItem:RefreshPost()
	self.postController_:SetSelectedState(tostring(self.isCaptain_))
end

function SectionSelectHeroInfoItem:RefreshAttackType()
	local var_37_0 = HeroTools.GetHeroSkillAttributeIcon(self.heroID_)

	if var_37_0 then
		SetActive(self.attackTypeIcon_.gameObject, true)

		self.attackTypeIcon_.sprite = var_37_0
	else
		SetActive(self.attackTypeIcon_.gameObject, false)
	end
end

function SectionSelectHeroInfoItem:RefreshHP()
	self.hpController_:SetSelectedState(tostring(self.sectionProxy_.needHeroHP))

	if self.sectionProxy_.needHeroHP then
		self:RefreshHPUI()
	end
end

function SectionSelectHeroInfoItem:RefreshHPUI()
	local var_39_0, var_39_1 = self:GetHeroHP()

	self.hpImg_.fillAmount = var_39_1 / 100
	self.hpText_.text = var_39_1 .. "%"
end

function SectionSelectHeroInfoItem:RefreshAssistant()
	self.assistantController_:SetSelectedState(tostring(self.sectionProxy_.needHeroAssistant))

	if self.sectionProxy_.needHeroAssistant then
		self:RefreshAssistantUI()
	end
end

function SectionSelectHeroInfoItem:RefreshAssistantUI()
	self.assistantController_:SetSelectedState(tostring(self.sectionProxy_.heroInfoList[self.pos_].isAssistant))
end

function SectionSelectHeroInfoItem:RefreshEnergy()
	self.energyController_:SetSelectedState(tostring(self.sectionProxy_.needHeroEnergy))

	if self.sectionProxy_.needHeroEnergy then
		self:RefreshEnergyUI()
	end
end

function SectionSelectHeroInfoItem:RefreshEnergyUI()
	if self.heroID_ ~= 0 then
		self.energyController_:SetSelectedState("true")

		self.energyText_.text = self:GetHeroEnergy()

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.energyBgTrans_)
	else
		self.energyController_:SetSelectedState("false")
	end
end

function SectionSelectHeroInfoItem:RefreshBaseInfoShow()
	if self.heroID_ ~= 0 then
		local var_44_0 = HeroCfg[self.heroID_] or nil

		if var_44_0 and (var_44_0.role_type == 1 or var_44_0.role_type == 2) then
			SetActive(self.baseInfo_, false)

			goto label_44_0
		end
	end

	SetActive(self.baseInfo_, true)

	::label_44_0::
end

function SectionSelectHeroInfoItem:BindRedPoint()
	self.sectionProxy_:CustomHeroBindRedPoint(self.pos_, self)
end

function SectionSelectHeroInfoItem:UnBindRedPoint()
	self.sectionProxy_:CustomHeroUnBindRedPoint(self.pos_, self)
end

function SectionSelectHeroInfoItem:GetHeroPower()
	return self.sectionProxy_:CustomGetHeroPower(self.pos_, self.heroID_, self.trialID_)
end

function SectionSelectHeroInfoItem:GetHeroHP()
	return self.sectionProxy_:CustomGetHeroHP(self.pos_, self.heroID_, self.trialID_)
end

function SectionSelectHeroInfoItem:GetHeroEnergy()
	return self.sectionProxy_:CustomGetHeroEnergy(self.pos_, self.heroID_, self.trialID_)
end

function SectionSelectHeroInfoItem:Show(arg_50_1)
	SetActive(self.gameObject_, arg_50_1)

	if arg_50_1 then
		self.enterAnim_:Update(0)
		self:AdaptPosition()
	else
		self.randomAttributeTipsView_:Show(false)
	end
end

function SectionSelectHeroInfoItem:OnSectionBeginDragHero()
	self.emptyController_:SetSelectedState("true")
	self.randomAttributeTipsView_:Show(false)
end

function SectionSelectHeroInfoItem:UpdatePosition()
	if not self:UpdateLocalPosition() then
		return false
	end

	self:UpdateDragPosition()
	self:Show(true)

	return true
end

function SectionSelectHeroInfoItem:UpdateLocalPosition()
	local var_53_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

	if not self:IsEmpty() then
		local var_53_1 = SectionSelectHeroScene.GetInstance():GetModelPowerPointScreenPos(self.pos_)

		if var_53_1 then
			if var_53_1.x < 0 or var_53_1.x > _G.SCREEN_WIDTH then
				Debug.Log("HeroInfoItem position is out of range, powerPoitnScreenPosX: " .. var_53_1.x)

				return false
			end

			local var_53_2, var_53_3 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.transform_.parent, var_53_1, var_53_0, nil)

			self.transform_:SetLocalPositionEx(var_53_3.x, var_53_3.y, 0)
		end
	else
		local var_53_4 = SectionSelectHeroScene.GetInstance():GetStateGoScreenPos(self.pos_)

		if var_53_4 then
			if var_53_4.x < 0 or var_53_4.x > _G.SCREEN_WIDTH then
				Debug.Log("HeroInfoItem position is out of range, sceneStateGoScreenPos: " .. var_53_4.x)

				return false
			end

			local var_53_5, var_53_6 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.transform_.parent, var_53_4, var_53_0, nil)

			self.transform_:SetLocalPositionX(var_53_6.x)
		end
	end

	self:AdaptPosition()

	return true
end

function SectionSelectHeroInfoItem:AdaptPosition()
	self:StopAdaptPositionTimer()
	self:StartAdaptPositionTimer()
end

function SectionSelectHeroInfoItem:StartAdaptPositionTimer()
	self.adaptTimer = FrameTimer.New(function()
		local var_56_0 = manager.ui.uiCamera:WorldToScreenPoint(self.topPointTrans_.position).y

		if var_56_0 > _G.SCREEN_HEIGHT then
			self.transform_:SetLocalPositionY(self.transform_:GetLocalPositionY() + (_G.SCREEN_HEIGHT - var_56_0) * manager.ui.canvasRate)
		end
	end, 1, 1)

	self.adaptTimer:Start()
end

function SectionSelectHeroInfoItem:StopAdaptPositionTimer()
	if self.adaptTimer then
		self.adaptTimer:Stop()

		self.adaptTimer = nil
	end
end

function SectionSelectHeroInfoItem:UpdateDragPosition()
	self.originalDragPosition_ = self.dragEventListener_.transform:GetLocalPosition()
	self.originalDragScreenPos_ = manager.ui.uiCamera:WorldToScreenPoint(self.dragEventListener_.transform.position)
end

return SectionSelectHeroInfoItem
