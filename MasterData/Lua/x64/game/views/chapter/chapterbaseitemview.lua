local ChapterBaseItemView = class("ChapterBaseItemView", ReduxView)

function ChapterBaseItemView:OnCtor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.chapterClientID_ = arg_1_3
	self.chapterToggle_ = arg_1_4
	self.transform_.name = arg_1_3
	self.tempVector3_ = Vector3.New(0, 0, 0)

	self:InitUI()
end

function ChapterBaseItemView:OnEnter()
	self:RefrshData()
	self:RefreshItem()
	self:RefreshLock()
	self:Show(true)
end

function ChapterBaseItemView:Show(arg_3_1)
	SetActive(self.gameObject_, arg_3_1)
end

function ChapterBaseItemView:OnExit()
	self:Show(false)
end

function ChapterBaseItemView:Dispose()
	ChapterBaseItemView.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ChapterBaseItemView:InitUI()
	self:BindCfgUI()
	self:AddListeners()

	self.lockController_ = self.controllerEx_:GetController("lock")
	self.timeController_ = self.controllerEx_:GetController("time")

	self.timeController_:SetSelectedState("state1")
end

function ChapterBaseItemView:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if BattleFieldData:GetCacheChapterClient(self.chapterToggle_) ~= self.chapterClientID_ then
			BattleFieldData:SetCacheChapterClient(self.chapterToggle_, self.chapterClientID_)
			manager.notify:Invoke(CHANGE_DUNGEON)

			return
		end

		BattleFieldData:SetCacheChapterClient(self.chapterToggle_, self.chapterClientID_)

		if not self:GetLockState() then
			SystemRedPoint:CancelNewTagByChapterId(self.chapterClientID_)
		end

		self:ClickItem(self.chapterClientID_)
	end)
end

function ChapterBaseItemView:RefrshData()
	self:IsNotice()
	self:IsLock()
	self:IsAssetPendLock()
end

function ChapterBaseItemView:IsNotice()
	self.notice_ = false
end

function ChapterBaseItemView:GetLockState()
	return self.isLock_
end

function ChapterBaseItemView:GetAssetPendLockkState()
	return self.isAssetPendLock_
end

function ChapterBaseItemView:SetSiblingIndex(arg_13_1)
	self.transform_:SetSiblingIndex(arg_13_1)
end

function ChapterBaseItemView:PlayAnimatorEnter()
	if self.gameObject_.activeInHierarchy then
		self.animator_:Play("Fx_mapRenderItemt_cx", 0, 0)
		self.animator_:Update(0)
	end
end

function ChapterBaseItemView:PlayAnimatorExit()
	if self.gameObject_.activeInHierarchy then
		self.animator_:Play("Fx_mapRenderItemt_xs", 0, 0)
		self.animator_:Update(0)
	end
end

function ChapterBaseItemView:RefreshItem()
	if not ChapterClientCfg[self.chapterClientID_] then
		return
	end

	self.nameText_.text = GetI18NText(ChapterClientCfg[self.chapterClientID_].name)

	self:RefreshCustomItem(ChapterClientCfg[self.chapterClientID_])
end

function ChapterBaseItemView:RefreshCustomItem(arg_17_1)
	return
end

function ChapterBaseItemView:RefreshLock()
	if self.isLock_ then
		self.lockController_:SetSelectedState("true")
	elseif self.isAssetPendLock_ then
		self.lockController_:SetSelectedState("assetpend")
	else
		self.lockController_:SetSelectedState("false")
	end
end

function ChapterBaseItemView:GetLocalPosition()
	return self.transform_.localPosition
end

function ChapterBaseItemView:SetPosition(arg_20_1, arg_20_2, arg_20_3)
	self.tempVector3_.x = arg_20_1
	self.tempVector3_.y = arg_20_2
	self.tempVector3_.z = self.transform_.localPosition.z
	self.transform_.localPosition = self.tempVector3_
	self.tempVector3_.x = arg_20_3
	self.tempVector3_.y = arg_20_3
	self.tempVector3_.z = 1
	self.transform_.localScale = self.tempVector3_
end

function ChapterBaseItemView:InvokeBtn()
	self.isAbove_ = true

	self.btn_.onClick:Invoke()
end

function ChapterBaseItemView:GetChapterClientID()
	return self.chapterClientID_
end

function ChapterBaseItemView:IsLock()
	local var_23_0, var_23_1 = JumpTools.GetSystemLockedText(ChapterClientCfg[self.chapterClientID_].jump_system)

	self.isLock_ = var_23_0
	self.lockTips_ = var_23_1
end

function ChapterBaseItemView:IsAssetPendLock()
	self.asset_pend_key = ChapterClientCfg[self.chapterClientID_].asset_pend_key
	self.isAssetPendLock_ = not manager.assetPend:CheckAssetPend(self.asset_pend_key)
end

function ChapterBaseItemView:GetLockTips()
	return self.lockTips_
end

function ChapterBaseItemView:CheckLock()
	if self.isLock_ then
		ShowTips(self.lockTips_)

		return true
	end

	if self.isAssetPendLock_ then
		manager.assetPend:ShowAssetPendMessageBox(self.asset_pend_key)

		return true
	end

	return false
end

return ChapterBaseItemView
