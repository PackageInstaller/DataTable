local AutoChessOpenCardView = class("AutoChessOpenCardView", ReduxView)

function AutoChessOpenCardView:UIName()
	return "Widget/System/Activity_AutoChess_Main/Unpack/Activity_Unpack_OpenBoxUI"
end

function AutoChessOpenCardView:UIParent()
	return manager.ui.uiMain.transform
end

function AutoChessOpenCardView:Init()
	self:InitUI()
	self:AddListeners()
end

function AutoChessOpenCardView:InitUI()
	self:BindCfgUI()

	self.choiceController = self.controller_:GetController("choice")
	self.guideController_ = self.controller_:GetController("guide")
	self.cardListController_ = self.controller_:GetController("cardList")
	self.cardItemSingleList = {}
	self.cardItemList = {}
	self.BoxItems = {}
	self.BoxItems[6] = AutoChessOpenCardBoxItem.New(self.boxGo_, self.singleCardTrans_)

	self.BoxItems[6]:SetLightState(true)

	for iter_4_0 = 1, 5 do
		self.BoxItems[iter_4_0] = AutoChessOpenCardBoxItem.New(self.boxGo_, self["multiCardTrans" .. iter_4_0 .. "_"])

		self.BoxItems[iter_4_0]:SetLightState(false)
	end

	self.URFactoryItem_ = AutoChessURFactoryItem.New(self.UrItemGo_)
end

function AutoChessOpenCardView:AddListeners()
	self:AddBtnListener(self.skipBtn_, nil, function()
		self.anim_:Play("UI_Activity_Unpack_OpenBoxUI_hide")
		JumpTools.OpenPageByJump("autoChessShowCardListPop", {
			mode = self.mode_,
			cardList = cardList
		})
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_gacha_skip",
			activity_id = AutoChessData:GetActivityID()
		})
	end)
end

function AutoChessOpenCardView:OnBeginDragFun()
	if self.disableDrag_ then
		return
	end

	self.isBeginDrag_ = true

	self.guideController_:SetSelectedState("show")
	self:SetGuideState("off")

	self.posX_ = nil
	self.length_ = 0
end

function AutoChessOpenCardView:OnTop()
	SetActive(self.skipBtn_.gameObject, true)
	manager.windowBar:HideBar()
end

function AutoChessOpenCardView:SetGuideState(arg_9_1)
	if self.mode_ == AutoChessCardConst.OPEN_CARD_MODE_SINGLE then
		self.BoxItems[6]:SetGuideState(arg_9_1)
	else
		self.BoxItems[1]:SetGuideState(arg_9_1)
	end
end

function AutoChessOpenCardView:OnDragFun()
	if self.disableDrag_ then
		return
	end

	if not self.isBeginDrag_ then
		return
	end

	local var_10_0, var_10_1 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.parentTrans_, Vector2.New(Input.mousePosition.x, Input.mousePosition.y), manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, {})

	self.guideTrans_.localPosition = var_10_1

	self:Check(var_10_1)
end

function AutoChessOpenCardView:Check(arg_11_1)
	if self.areaTrans_.localPosition.x < arg_11_1.x and arg_11_1.x < self.areaTrans_.localPosition.x + self.areaTrans_.rect.width and self.areaTrans_.localPosition.y < arg_11_1.y and arg_11_1.y < self.areaTrans_.localPosition.y + self.areaTrans_.rect.height then
		if self.length_ >= self:GetCheckMaxLength() then
			return
		end

		if self.posX_ == nil then
			self.posX_ = arg_11_1.x
		elseif arg_11_1.x > self.posX_ then
			self.length_ = math.max(self.length_, arg_11_1.x - self.posX_)
		end
	else
		if self.length_ >= self:GetCheckMaxLength() then
			return
		end

		self.posX_ = nil
		self.length_ = 0
	end
end

function AutoChessOpenCardView:OnEndDragFun()
	if self.disableDrag_ then
		return
	end

	self.isBeginDrag_ = false

	if self.length_ >= self:GetCheckMaxLength() then
		self.guideController_:SetSelectedState("hide")
		self:SetGuideState("off")
		manager.windowBar:HideBar()
		SetActive(self.skipBtn_.gameObject, false)
		self:PlayExitAnim()
	else
		self.guideController_:SetSelectedState("show")
		self:SetGuideState("on")
	end
end

function AutoChessOpenCardView:GetCheckMaxLength()
	return self.areaTrans_.rect.width / 2
end

function AutoChessOpenCardView:PlayExitAnim()
	self.disableDrag_ = true

	AnimatorTools.Stop()

	if self.mode_ == AutoChessCardConst.OPEN_CARD_MODE_SINGLE then
		self.BoxItems[6]:PlayAnim(function()
			self:PlayOutAnim()
		end)
	else
		local var_14_0 = 1

		self.BoxItems[1]:PlayAnim()

		self.timer_ = Timer.New(function()
			var_14_0 = var_14_0 + 1

			if var_14_0 == 5 then
				if self:CheckIsOpenURCard(1, #self.cardList_) then
					-- block empty
				end

				self.UrAnim_:Play("UrRotation", 0, 0)
				self.BoxItems[var_14_0]:PlayAnim(function()
					self:PlayOutAnim()
				end)
			else
				self.BoxItems[var_14_0]:PlayAnim()
			end
		end, 0.25, 4)

		self.timer_:Start()
	end
end

function AutoChessOpenCardView:PlayOutAnim()
	AnimatorTools.PlayAnimationWithCallback(self.anim_, "UI_Activity_Unpack_OpenBoxUI_out", function()
		self.anim_:Play("UI_Activity_Unpack_OpenBoxUI_hide")
		JumpTools.OpenPageByJump("autoChessShowCardListPop", {
			mode = self.mode_,
			cardList = self.cardList_
		})
	end, false, 0, 0)
end

function AutoChessOpenCardView:RefreshOneUI()
	for iter_20_0, iter_20_1 in ipairs(self.cardList_) do
		if self.cardItemSingleList[iter_20_0] then
			self.cardItemSingleList[iter_20_0]:SetData(iter_20_1, self.URFactoryItem_:GetItem(iter_20_1))
		else
			local var_20_0 = AutoChessCardItem.New(self.onePanelTrans_:GetChild(iter_20_0 - 1).gameObject)

			var_20_0:SetData(iter_20_1, self.URFactoryItem_:GetItem(iter_20_1))

			self.cardItemSingleList[iter_20_0] = var_20_0
		end
	end
end

function AutoChessOpenCardView:RefreshMoreUI()
	for iter_21_0, iter_21_1 in ipairs(self.cardList_) do
		local var_21_0 = math.ceil(iter_21_0 / 5)

		if self.cardItemList[iter_21_0] then
			self.cardItemList[iter_21_0]:SetData(iter_21_1, self.URFactoryItem_:GetItem(iter_21_1))
		else
			local var_21_1 = AutoChessCardItem.New(self["morePanelTrans" .. var_21_0 .. "_"]:GetChild(iter_21_0 % 5).gameObject)

			var_21_1:SetData(iter_21_1, self.URFactoryItem_:GetItem(iter_21_1))

			self.cardItemList[iter_21_0] = var_21_1
		end
	end
end

function AutoChessOpenCardView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function AutoChessOpenCardView:OnEnter()
	self.disableDrag_ = false

	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(self, self.OnBeginDragFun)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(self, self.OnDragFun)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(self, self.OnEndDragFun)))

	self.mode_ = self.params_.mode
	self.cardList_ = self.params_.cardList

	if self.mode_ == AutoChessCardConst.OPEN_CARD_MODE_SINGLE then
		self.choiceController:SetSelectedState("CardPanelSingle")
		self.BoxItems[6]:SetData(self:CheckIsOpenURCard(1, 5))
		self.cardListController_:SetSelectedState("single")
		self:RefreshOneUI()
	else
		self.choiceController:SetSelectedState("CardPanelEven")
		self.cardListController_:SetSelectedState("multi")
		self:RefreshMoreUI()

		for iter_23_0 = 1, 5 do
			self.BoxItems[iter_23_0]:SetData(self:CheckIsOpenURCard((iter_23_0 - 1) * 5 + 1, iter_23_0 * 5))
		end
	end

	self:SetGuideState("on")
end

function AutoChessOpenCardView:CheckIsOpenURCard(arg_24_1, arg_24_2)
	for iter_24_0 = arg_24_1, arg_24_2 do
		if self.cardList_[iter_24_0] and AutoChessCardCfg[self.cardList_[iter_24_0]].type == AutoChessCardConst.CARD_TYPE.UR then
			return true
		end
	end

	return false
end

function AutoChessOpenCardView:OnExit()
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	self.anim_:Rebind()

	for iter_25_0, iter_25_1 in ipairs(self.BoxItems) do
		iter_25_1:OnExit()
	end

	manager.windowBar:HideBar()
end

function AutoChessOpenCardView:Dispose()
	AnimatorTools.Stop()

	for iter_26_0, iter_26_1 in ipairs(self.BoxItems) do
		iter_26_1:Dispose()
	end

	for iter_26_2, iter_26_3 in ipairs(self.cardItemList) do
		iter_26_3:Dispose()
	end

	for iter_26_4, iter_26_5 in ipairs(self.cardItemSingleList) do
		iter_26_5:Dispose()
	end

	self.URFactoryItem_:Dispose()
	self:StopTimer()
	AutoChessOpenCardView.super.Dispose(self)
end

return AutoChessOpenCardView
