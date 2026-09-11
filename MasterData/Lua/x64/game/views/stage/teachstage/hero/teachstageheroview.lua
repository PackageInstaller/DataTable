local TeachStageHeroView = class("TeachStageHeroView", ReduxView)

function TeachStageHeroView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.switchType_ = arg_1_2

	self:InitUI()
	self:AddListeners()
end

function TeachStageHeroView:InitUI()
	self:BindCfgUI(self.gameObject_)

	self.curIndex_ = 0
	self.inited_ = false
	self.isScroll_ = false
	self.list_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, TeachStageHeroItem)

	self.list_:SetHeadTailChangeHandler(handler(self, self.OnListInit))

	self.selectStageItemHandler_ = handler(self, self.OnSelectStageItem)
end

function TeachStageHeroView:OnEnter()
	self:InitHeroList()
	self:RefreshUI()
	manager.windowBar:RegistBackCallBack(function()
		if self:IsOpenSectionView() then
			self.inited_ = true

			for iter_4_0, iter_4_1 in pairs((self.list_:GetItemList())) do
				iter_4_1:RefreshSelect(0)
			end

			self.m_scrollCom.horizontal = true
		end

		JumpTools.Back()
	end)
end

function TeachStageHeroView:RefreshUI()
	if self.heroID_ then
		if self.inited_ then
			if self.herolist_ == nil then
				self:InitHeroList()
			end

			local var_5_0 = table.indexof(self.herolist_, self.heroID_)

			self.list_:StartScroll(self:GetHeroNum(), var_5_0)
			self:RefreshSelectStageItem(var_5_0)

			local var_5_1 = self.list_:GetItemList()[var_5_0]

			if var_5_1 then
				self:RemoveTween()

				self.tween_ = LeanTween.value(self.m_scrollContent, self.m_scrollContent.transform.localPosition.x, -var_5_1.transform_.localPosition.x + self.m_scrollViewTrans.rect.width / 3 - var_5_1.transform_.rect.width / 2, 0):setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					self.m_scrollContent.transform.localPosition = Vector3(arg_6_0, 0, 0)
				end))
				self.m_scrollCom.horizontal = false
			else
				self.m_scrollCom.horizontal = true
			end

			self.heroID_ = nil
		else
			if self.herolist_ == nil then
				self:InitHeroList()
			end

			self.curIndex_ = table.indexof(self.herolist_, self.heroID_)

			if not self.isScroll_ then
				self.list_:StartScroll(self:GetHeroNum())

				self.isScroll_ = true
			end

			self:ScrollToCurIndex()
		end
	elseif self.curIndex_ > 0 then
		local var_5_2 = self.list_:GetItemList()[self.curIndex_]

		if var_5_2 then
			self:RemoveTween()

			self.tween_ = LeanTween.value(self.m_scrollContent, self.m_scrollContent.transform.localPosition.x, -var_5_2.transform_.localPosition.x + self.m_scrollViewTrans.rect.width / 3 - var_5_2.transform_.rect.width / 2, 0):setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
				self.m_scrollContent.transform.localPosition = Vector3(arg_7_0, 0, 0)
			end))
		end

		if self:IsOpenSectionInfo() then
			for iter_5_0, iter_5_1 in pairs((self.list_:GetItemList())) do
				iter_5_1:RefreshSelect(self.curIndex_)
			end

			self.m_scrollCom.horizontal = false
		else
			for iter_5_2, iter_5_3 in pairs((self.list_:GetItemList())) do
				iter_5_3:RefreshSelect(0)
			end

			self.m_scrollCom.horizontal = true
		end
	else
		self.list_:StartScroll(self:GetHeroNum())
	end
end

function TeachStageHeroView:OnListInit(arg_8_1, arg_8_2)
	if not self.inited_ and self.heroID_ then
		if self.herolist_ == nil then
			self:InitHeroList()
		end

		local var_8_0 = table.indexof(self.herolist_, self.heroID_)

		self.curIndex_ = table.indexof(self.herolist_, self.heroID_)
		self.m_scrollCom.horizontal = false
		self.m_scrollContent.transform.localPosition = Vector3(-(303 * self.curIndex_ - self.m_scrollViewTrans.rect.width / 3), 0, 0)
	end
end

function TeachStageHeroView:OnSelectStageItem(arg_9_1)
	self.inited_ = true

	self:RefreshSelectStageItem(arg_9_1)

	local var_9_0 = self.list_:GetItemList()[arg_9_1]

	if var_9_0 then
		self:RemoveTween()

		self.tween_ = LeanTween.value(self.m_scrollContent, self.m_scrollContent.transform.localPosition.x, -var_9_0.transform_.localPosition.x + self.m_scrollViewTrans.rect.width / 3 - var_9_0.transform_.rect.width / 2, 0.2):setOnUpdate(LuaHelper.FloatAction(function(arg_10_0)
			self.m_scrollContent.transform.localPosition = Vector3(arg_10_0, 0, 0)
		end))
		self.m_scrollCom.horizontal = false
	else
		self.m_scrollCom.horizontal = true
	end
end

function TeachStageHeroView:TryToCloseSectionView()
	if self:IsOpenSectionView() then
		self.inited_ = true

		for iter_11_0, iter_11_1 in pairs((self.list_:GetItemList())) do
			iter_11_1:RefreshSelect(0)
		end

		self.m_scrollCom.horizontal = true

		JumpTools.Back()
	end
end

function TeachStageHeroView:RefreshSelectStageItem(arg_12_1)
	self.curIndex_ = arg_12_1

	for iter_12_0, iter_12_1 in pairs((self.list_:GetItemList())) do
		iter_12_1:RefreshSelect(arg_12_1)
	end
end

function TeachStageHeroView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil)
		LeanTween.cancel(self.m_scrollContent)

		self.tween_ = nil
	end
end

function TeachStageHeroView:IsOpenSectionView()
	return self:IsOpenRoute("teachSectionInfo")
end

function TeachStageHeroView:OnExit()
	self:RemoveTween()

	self.inited_ = true

	if not self:IsOpenSectionInfo() then
		for iter_15_0, iter_15_1 in pairs((self.list_:GetItemList())) do
			iter_15_1:RefreshSelect(0)
		end

		self.m_scrollCom.horizontal = true
	end
end

function TeachStageHeroView:OnClickTeachViewBtn()
	for iter_16_0, iter_16_1 in pairs((self.list_:GetItemList())) do
		iter_16_1:RefreshSelect(0)
	end

	self.m_scrollCom.horizontal = true
end

function TeachStageHeroView:Dispose()
	self.m_scrollEvent:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerDown)
	self.m_scrollEvent:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	TeachStageHeroView.super.Dispose(self)

	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end
end

function TeachStageHeroView:IndexItem(arg_18_1, arg_18_2)
	arg_18_2:SetData(arg_18_1, self.curIndex_, self.inited_)
	arg_18_2:SetHeroID(self.herolist_[arg_18_1])
	arg_18_2:SetSelectCallBack(self.selectStageItemHandler_)
end

function TeachStageHeroView:AddListeners()
	self:AddBtnListener(self.bgbtn_, nil, function()
		self:TryToCloseSectionView()
	end)
	self.m_scrollEvent:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_21_0, arg_21_1)
		self:TryToCloseSectionView()
	end))
	self.m_scrollEvent:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_22_0, arg_22_1)
		self:TryToCloseSectionView()
	end))
end

function TeachStageHeroView:RemoveListeners()
	return
end

function TeachStageHeroView:SwitchPageUI(arg_24_1, arg_24_2)
	local var_24_0 = self.switchType_ == arg_24_1

	SetActive(self.gameObject_, self.switchType_ == arg_24_1)

	if var_24_0 then
		self.heroID_ = arg_24_2

		self:ScrollToCurIndex()
		BattleTeachAction.CancelHeroTeachRedPoint()
	end
end

function TeachStageHeroView:ScrollToCurIndex()
	if self.curIndex_ > 0 then
		self.list_:SetScrolledPosition(Vector2.New((self.curIndex_ * 303 - 200) / self.m_scrollContent.transform.rect.width, 0))
	end
end

function TeachStageHeroView:InitHeroList()
	local var_26_0 = {}
	local var_26_1 = {}
	local var_26_2 = {}
	local var_26_3 = {}

	for iter_26_0, iter_26_1 in pairs(HeroData:GetHeroList()) do
		if not HeroTools.GetIsHide(iter_26_1.id) then
			table.insert(var_26_3, iter_26_1)
		end
	end

	table.sort(var_26_3, function(arg_27_0, arg_27_1)
		if arg_27_0.id < arg_27_1.id then
			return true
		end

		return false
	end)

	for iter_26_2, iter_26_3 in pairs(var_26_3) do
		if iter_26_3.unlock == 1 then
			if BattleTeachData:GetHeroTeachInfo(iter_26_3.id, HeroCfg[iter_26_3.id].study_stage[1]) > 0 then
				table.insert(var_26_1, iter_26_3.id)
			else
				table.insert(var_26_0, iter_26_3.id)
			end
		else
			table.insert(var_26_2, iter_26_3.id)
		end
	end

	table.insertto(var_26_0, var_26_1)
	table.insertto(var_26_0, var_26_2)

	self.herolist_ = var_26_0
end

function TeachStageHeroView:GetHeroNum()
	local var_28_0 = 0

	for iter_28_0, iter_28_1 in ipairs(HeroCfg.get_id_list_by_private[0]) do
		if not HeroTools.GetIsHide(iter_28_1) then
			var_28_0 = var_28_0 + 1
		end
	end

	return var_28_0
end

function TeachStageHeroView:IsOpenSectionInfo()
	return self:IsOpenRoute("teachSectionInfo")
end

return TeachStageHeroView
