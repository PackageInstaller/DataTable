local CustomCenterHeroSkinPanel = class("CustomCenterHeroSkinPanel", ReduxView)

function CustomCenterHeroSkinPanel:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.skinIdList_ = {}
	self.skinItemList_ = {}

	self:BindCfgUI()
	self:AddListeners()
end

function CustomCenterHeroSkinPanel:Dispose()
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)

	for iter_2_0, iter_2_1 in pairs(self.skinItemList_) do
		iter_2_1:Dispose()
	end

	self.skinItemList_ = nil

	CustomCenterHeroSkinPanel.super.Dispose(self)
end

function CustomCenterHeroSkinPanel:AddListeners()
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(self, self.BeginDragFun)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(self, self.EndDragFun)))
	self.scrollView_.onValueChanged:AddListener(function()
		self:RefreshItemScale()
	end)
end

function CustomCenterHeroSkinPanel:RefreshUI(arg_5_1)
	self.heroID_ = arg_5_1
	self.skinID_ = PlayerData:GetCacheHeroSkinID(arg_5_1)

	self:RefreshItemData()
	self:RefreshSkinItemList()
end

function CustomCenterHeroSkinPanel:RefreshItemData()
	self.skinIdList_ = {}

	for iter_6_0, iter_6_1 in ipairs(SkinCfg.get_id_list_by_hero[self.heroID_]) do
		if not HeroTools.GetIsSkinHide(iter_6_1) then
			if HeroTools.GetHasOwnedSkin(iter_6_1) then
				table.insert(self.skinIdList_, iter_6_1)
			elseif HeroTools.CanChangeSkin(iter_6_1) then
				-- block empty
			elseif CustomCenterTools.IsValidHeroSkin(self.heroID_, iter_6_1) then
				table.insert(self.skinIdList_, iter_6_1)
			end
		end
	end
end

function CustomCenterHeroSkinPanel:RefreshSkinItemList()
	for iter_7_0, iter_7_1 in pairs(self.skinItemList_) do
		iter_7_1:SetActive(false)
	end

	for iter_7_2, iter_7_3 in ipairs(self.skinIdList_) do
		local var_7_0

		if self.skinItemList_[iter_7_2] then
			var_7_0 = self.skinItemList_[iter_7_2]
		else
			var_7_0 = self:GetSkinItem()

			table.insert(self.skinItemList_, var_7_0)
			var_7_0:SetDelegate(handler(self, self.RefreshButton))
		end

		var_7_0:Show(self.skinIdList_[iter_7_2], iter_7_2)
		var_7_0:ShowSelect(self.selectIndex_ == iter_7_2)
		var_7_0:SetActive(true)
	end

	self:Scroll2SelectItem(5)
end

function CustomCenterHeroSkinPanel:UpdateSkinItem()
	self:RefreshItemData()
	self:RefreshSkinItemList()
end

function CustomCenterHeroSkinPanel:RefreshItemBattleSkin(arg_9_1)
	if not self.skinItemList_ then
		return
	end

	if arg_9_1 == 0 then
		arg_9_1 = self.heroID_
	end

	for iter_9_0, iter_9_1 in ipairs(self.skinItemList_) do
		iter_9_1:ShowBattleSkin(arg_9_1 == iter_9_1.skinID_)
	end
end

function CustomCenterHeroSkinPanel:RefreshButton(arg_10_1)
	self.selectIndex_ = arg_10_1.index_

	if arg_10_1.skinID_ == self.skinID_ then
		self:Scroll2SelectItem(5)

		return
	end

	self.skinID_ = arg_10_1.skinID_

	PlayerData:SetCacheHeroSkinID(SkinCfg[arg_10_1.skinID_].hero, arg_10_1.skinID_)
	self:RefreshUI(self.heroID_)
	self:Scroll2SelectItem(5)
	manager.notify:Invoke(CUSTOM_CENTER_SWITCH_HERO_SKIN)
end

function CustomCenterHeroSkinPanel:GetSkinItem()
	return CustomCenterHeroSkinItem.New(self.itemGo_, self.contentTf_)
end

function CustomCenterHeroSkinPanel:BeginDragFun(arg_12_1, arg_12_2)
	if manager.ui.uiCanvasGroup.blocksRaycasts == false then
		self.scrollView_.enabled = false

		return
	end

	self:StopMoveTimer()
	self:StopScrollTimer()

	self.scrollView_.enabled = true

	self.scrollView_:OnBeginDrag(arg_12_2)
end

function CustomCenterHeroSkinPanel:Scroll2SelectItem(arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(self.skinItemList_) do
		if iter_13_1.isActive then
			local var_13_0 = iter_13_1:GetSkinID() == self.skinID_

			if var_13_0 then
				self:AddMoveTimer(iter_13_1, arg_13_1)
			end

			iter_13_1:ShowSelect(var_13_0)
		end
	end
end

function CustomCenterHeroSkinPanel:GetNearestItem()
	local var_14_0

	for iter_14_0, iter_14_1 in ipairs(self.skinItemList_) do
		if iter_14_1.isActive then
			if math.abs(self.contentTf_.localPosition.x + iter_14_1:GetLocalPosition().x - self.scrollTf_.rect.width / 2) < 9999 then
				var_14_0 = iter_14_1
			end
		end
	end

	return var_14_0
end

function CustomCenterHeroSkinPanel:EndDragFun(arg_15_1, arg_15_2)
	self.scrollView_:OnEndDrag(arg_15_2)
	self:AddScrollTimer()
end

function CustomCenterHeroSkinPanel:AddScrollTimer()
	self:StopScrollTimer()

	self.scrollTimer_ = nil
	self.scrollTimer_ = FrameTimer.New(function()
		if math.abs(self.scrollView_.velocity.x) <= 100 then
			self.scrollTimer_:Stop()
			self:AdjustItem()
		end
	end, 1, -1)

	self.scrollTimer_:Start()
end

function CustomCenterHeroSkinPanel:StopScrollTimer()
	if self.scrollTimer_ then
		self.scrollTimer_:Stop()

		self.scrollTimer_ = nil
	end
end

function CustomCenterHeroSkinPanel:AdjustItem()
	self:RefreshButton((self:GetNearestItem()))
end

function CustomCenterHeroSkinPanel:RefreshItemScale()
	for iter_20_0, iter_20_1 in pairs(self.skinItemList_) do
		if iter_20_1.isActive then
			iter_20_1:RefreshShow()
		end
	end
end

function CustomCenterHeroSkinPanel:AddMoveTimer(arg_21_1, arg_21_2)
	self:StopMoveTimer()

	self.moveTimer_ = FrameTimer.New(function()
		local var_22_1 = arg_21_1:GetLocalPosition().x * -1 + self.scrollTf_.rect.width / 2

		self.contentTf_.localPosition = Vector3.Lerp(self.contentTf_.localPosition, Vector3.New(var_22_1, self.contentTf_.localPosition.y, self.contentTf_.localPosition.z), arg_21_2 * math.pow(self.scrollView_.decelerationRate, UnityEngine.Time.unscaledDeltaTime) * UnityEngine.Time.unscaledDeltaTime)

		if math.abs(self.contentTf_.localPosition.x - var_22_1) <= 1 then
			self.contentTf_.localPosition = Vector3(var_22_1, self.contentTf_.localPosition.y, self.contentTf_.localPosition.z)

			self:StopMoveTimer()
		end
	end, 1, -1)

	self.moveTimer_:Start()
end

function CustomCenterHeroSkinPanel:StopMoveTimer()
	if self.moveTimer_ then
		self.moveTimer_:Stop()

		self.moveTimer_ = nil
	end
end

return CustomCenterHeroSkinPanel
