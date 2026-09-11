local StoryTimeLineItemBaseView = class("StoryTimeLineItemBaseView", ReduxView)

function StoryTimeLineItemBaseView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.tempVector3_ = Vector3.New(0, 0, 0)
	self.parent_ = arg_1_2

	self:InitUI()
	self:Show(true)
end

function StoryTimeLineItemBaseView:OnEnter()
	return
end

function StoryTimeLineItemBaseView:OnExit()
	return
end

function StoryTimeLineItemBaseView:Dispose()
	self:RemoveListeners()
	StoryTimeLineItemBaseView.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function StoryTimeLineItemBaseView:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.controller_:GetController("state")
	self.categoryController_ = self.controller_:GetController("category")
	self.illShowController_ = self.controller_:GetController("illShow")
	self.lockController_ = self.controller_:GetController("lock")

	self:AddListeners()
end

function StoryTimeLineItemBaseView:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickCallBack_ then
			self.clickCallBack_(self.id_, self)
		end
	end)
	self:AddBtnListener(self.branchBtn_, nil, function()
		if self.clickCallBack_ then
			self.clickCallBack_(self.id_, self)
		end
	end)
	self:AddBtnListener(self.branchBtn2_, nil, function()
		if self.clickCallBack_ then
			self.clickCallBack_(self.id_, self)
		end
	end)
	self:AddBtnListener(self.bigBtn_, nil, function()
		if self.clickCallBack_ then
			self.clickCallBack_(self.id_, self)
		end
	end)
	self:AddBtnListener(self.lockBtn_, nil, function()
		if self.lockClickCallBack_ then
			self.lockClickCallBack_(self.id_, self)
		end
	end)
end

function StoryTimeLineItemBaseView:RemoveListeners()
	return
end

function StoryTimeLineItemBaseView:RefreshData()
	self.isIllu_ = false
end

function StoryTimeLineItemBaseView:RefreshUI()
	self:RefreshItem()
	self:RefreshCollect()
	self:RefreshIllShow()
end

function StoryTimeLineItemBaseView:RefreshItem()
	if self.sizeState_ == 0 or self.sizeState_ == 1 then
		local var_15_1 = ChapterClientCfg[self.id_]

		self.nameText_.text = GetI18NText(ChapterClientCfg[self.id_].name)

		SetSpriteWithoutAtlasAsync(self.img_, SpritePathCfg.CollectPlotBig.path .. var_15_1.chapter_paint)

		if var_15_1.toggle == BattleConst.TOGGLE.PLOT then
			self.isLock_ = not ChapterTools.IsFinishPreChapter(self.id_)

			self.categoryController_:SetSelectedState("main")
			self.lockController_:SetSelectedState(tostring(self.isLock_))
		else
			self.isLock_ = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_SUB_PLOT)

			self.categoryController_:SetSelectedState("branch")

			self.branchText_.text = GetI18NText(var_15_1.name)

			SetSpriteWithoutAtlasAsync(self.branchImg_, SpritePathCfg.CollectPlotBig.path .. var_15_1.chapter_paint)
			self.lockController_:SetSelectedState(tostring(self.isLock_))
		end

		self.collectPrecent_ = ChapterTools.GetChapterClientFinishPercentage(self.id_)
		self.storyProgress_.fillAmount = self.collectPrecent_
		self.storyProgressText_.text = string.format("%s%%", math.floor(self.collectPrecent_ * 100))
	elseif self.sizeState_ == 2 then
		if ChapterClassCfg[self.id_].mid_type == 1 then
			self.nameText_.text = GetI18NText(ChapterClassCfg[self.id_].mid_name)

			SetSpriteWithoutAtlasAsync(self.img_, SpritePathCfg.CollectPlotBig.path .. ChapterClassCfg[self.id_].mid_pic)
			self.categoryController_:SetSelectedState("main")
		else
			self.categoryController_:SetSelectedState("branch")
		end

		self.lockController_:SetSelectedState("false")
	elseif self.sizeState_ == 3 then
		self.nameText2_.text = GetI18NText(ChapterClassCfg[ChapterClassCfg.get_id_list_by_big_id[self.id_][1]].big_name)

		SetSpriteWithoutAtlasAsync(self.img2_, SpritePathCfg.ChapterPaint.path .. ChapterClassCfg[ChapterClassCfg.get_id_list_by_big_id[self.id_][1]].big_pic)
		self.categoryController_:SetSelectedState("main")
		self.lockController_:SetSelectedState("false")
	end
end

function StoryTimeLineItemBaseView:RefreshLock()
	self.lockController_:SetSelectedState(tostring(self.isLock_))
end

function StoryTimeLineItemBaseView:RefreshIllShow()
	self.illShowController_:SetSelectedState(tostring(self.isIllu_))
end

function StoryTimeLineItemBaseView:RefreshActivity()
	return
end

function StoryTimeLineItemBaseView:RefreshCollect()
	return
end

function StoryTimeLineItemBaseView:PlayAnimate()
	return
end

function StoryTimeLineItemBaseView:SetID(arg_21_1)
	self.id_ = arg_21_1
	self.transform_.name = arg_21_1

	self:RefreshData()
	self:RefreshUI()
	self:Show(true)
end

function StoryTimeLineItemBaseView:SetLocalPosition(arg_22_1)
	self.transform_.localPosition = arg_22_1
end

function StoryTimeLineItemBaseView:GetLocalPosition()
	return self.transform_.localPosition + self.parent_.transform.localPosition
end

function StoryTimeLineItemBaseView:Show(arg_24_1)
	if arg_24_1 == false then
		self.tempVector3_.x = 1000000000000
		self.tempVector3_.y = 1000000000000
		self.tempVector3_.z = 1000000000000

		self:SetLocalPosition(self.tempVector3_)
	else
		SetActive(self.gameObject_, arg_24_1)
	end
end

function StoryTimeLineItemBaseView:Scale(arg_25_1)
	self.tempVector3_.x = arg_25_1
	self.tempVector3_.y = arg_25_1
	self.tempVector3_.z = 1
	self.transform_.localScale = self.tempVector3_
end

function StoryTimeLineItemBaseView:SetAlpha(arg_26_1)
	return
end

function StoryTimeLineItemBaseView:SetSizeState(arg_27_1)
	self.sizeState_ = arg_27_1

	self.stateController_:SetSelectedState(arg_27_1)
end

function StoryTimeLineItemBaseView:SetClickCallBack(arg_28_1)
	self.clickCallBack_ = arg_28_1
end

function StoryTimeLineItemBaseView:SetLockClickCallBack(arg_29_1)
	self.lockClickCallBack_ = arg_29_1
end

function StoryTimeLineItemBaseView:SetScale(arg_30_1)
	self.tempVector3_.x = arg_30_1
	self.tempVector3_.y = arg_30_1
	self.tempVector3_.z = 1
	self.mainTrs_.localScale = self.tempVector3_
end

function StoryTimeLineItemBaseView:GetID()
	return self.id_
end

function StoryTimeLineItemBaseView:IsLock()
	return self.isLock_
end

return StoryTimeLineItemBaseView
